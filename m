Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E2F0CD0422
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 23:30:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCA5A83D9F;
	Tue,  6 Jan 2026 00:30:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kTrFkuyD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8707583DEB; Tue,  6 Jan 2026 00:30:42 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3541283D9F
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 00:30:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-65063a95558so614047a12.0
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 15:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767655840; x=1768260640; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=24/X3eGSXq42BdWLsg2Znarq7MEhZ/QuKMTSedoqPCM=;
 b=kTrFkuyDo6rhtCp5J/DUieEoWGsQEWadSBs8axaXOQFPK3tjny61+4FvKjdCmKGCGH
 b9ohzKoQDklYsBbLSxgT23nY0OY74E7Xwu9CnmCn6nb2c/c0psMlAxqLQuiMLmYUmQdF
 SSsbmDrl9sWo//zQypjlflniFu6ec6NR88u94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767655840; x=1768260640;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=24/X3eGSXq42BdWLsg2Znarq7MEhZ/QuKMTSedoqPCM=;
 b=fxQkI+A13z+H4IN+uR7rh0qZkfx4FaUREpnYflqiagnh1o86EY4KaiYi/reozCWOn0
 on8W7Z5MLjOOA72ObdBu3Hbl9CyKhqoxlAjZBZhkInjcoUwDbcKz95fhZS03S+yAK7Ho
 CDAM12iOfDBwldAlN6/gXg63rZkfS9QfM1Nf52EwOgZH3AJmPBF9KgR0E/wnMozmOG7l
 rnJNWRQ9/ukKKRVFF4CKsBaNgca9ep4dfWrovl2wwsSIZtM8eqe5ZznMcKTm3/+ZqbXd
 qTu6wog0yLhnAgiawlqm06tpWjLHQUP3hg0uXG8DVgGlT1O0kjVqjlyuvzNCusBbBrah
 kTsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmOq6K4wEhXhJ+OVjSFjzJSvxz+t4ZtQ/DWfQx2sc5Bip8pvuD40gAur7HI1GBKh5s5aqy7Ho=@lists.denx.de
X-Gm-Message-State: AOJu0YxMDLysmsJiy3C7wqPjj6q8e4rd+2se/OpabkPqkEypXuY1A/t7
 KP63pRQjCUwNKV/1fp4OoQLjtM9ZYfeUeABpZBkbOOaA6g/uhjBf69J9zldJKyA+DOh5H4Kgg+a
 ErIKdYDIZ/UNWTuIFIuYmHcP+ro1CHyCW+IfohB46
X-Gm-Gg: AY/fxX6q8IkibmxpTY/ubdH7m815pFVQv72YTE8wrP60E5RSHLgoujkbwG4cUQZ9qJt
 z14GHFUnp/p+KIn9oJpowU/EjsIKgsibHLcXQEoBr8QZHgitX/YKMa8CLjpyjhDGQkF49/a6I+6
 b2Ezj6WOwVpjOdybiYEXZCv7jEG122IOGEEg2hBROw8eXsdP/YKsGTnca9u2kFt7yI0uLW39+aY
 k/gpRrr9Pj4fUwiDOfc3qDG4KJ9vBukJ+KzeQAj9UlLm1wa9csCILY304YHN0bgtUVuqQ==
X-Google-Smtp-Source: AGHT+IEG0ohLrTf2ZXxtezaYr1oEA6DF5BzCcgFq07ldz8NJ7OX9Qins/MQF5lwAgCUoZCzmuk8pWXX7RdsZ1brak8M=
X-Received: by 2002:a17:907:9347:b0:b74:984c:a3de with SMTP id
 a640c23a62f3a-b8426acbb4dmr154927066b.28.1767655839656; Mon, 05 Jan 2026
 15:30:39 -0800 (PST)
MIME-Version: 1.0
References: <20251231173621.1069988-1-b-padhi@ti.com>
 <20251231173621.1069988-8-b-padhi@ti.com>
In-Reply-To: <20251231173621.1069988-8-b-padhi@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 5 Jan 2026 16:30:24 -0700
X-Gm-Features: AQt7F2oMfsER16S4GoTH_bX6tIaOrm1vo87IFfqFOuOd_TqrVPe6fjAO9ak8npA
Message-ID: <CAFLszTi73RSFM4d2fzvndyw9mOq4D-gqQ2Gp-YGcYdp5gu-s1g@mail.gmail.com>
Subject: Re: [PATCH v3 07/11] binman: openssl: Add boot and load extensions to
 x509 cert
To: Beleswar Padhi <b-padhi@ti.com>
Cc: trini@konsulko.com, afd@ti.com, bb@ti.com, anshuld@ti.com, hnagalla@ti.com,
 jm@ti.com, nm@ti.com, n-francis@ti.com, u-kumar1@ti.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Beleswar,

On Wed, 31 Dec 2025 at 10:37, Beleswar Padhi <b-padhi@ti.com> wrote:
>
> The boot and load extensions in the x509 certificate are required for
> requesting the secure entity (TIFS) to boot a core. These fields are
> defined in the binman node for each core that must be booted by TIFS
> and must be included when generating the signed certificate.
>
> Add support to parse the boot and load extension properties from the
> binman node and populate them into the certificate. If any of the
> mandatory properties for an extension are missing, that respective
> extension section is NOT added to the certificate.
>
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
> v3: Changelog:
> 1. New patch. Add support to sign HSM firmware here in U-Boot.
>
>  tools/binman/btool/openssl.py   | 49 ++++++++++++++++++++++++++++++---
>  tools/binman/etype/ti_secure.py | 18 ++++++++++++
>  tools/binman/etype/x509_cert.py |  4 ++-
>  3 files changed, 66 insertions(+), 5 deletions(-)
>
> diff --git a/tools/binman/btool/openssl.py b/tools/binman/btool/openssl.py
> index b26f087c447..35898aa488b 100644
> --- a/tools/binman/btool/openssl.py
> +++ b/tools/binman/btool/openssl.py
> @@ -82,7 +82,8 @@ imageSize              = INTEGER:{len(indata)}
>          return self.run_cmd(*args)
>
>      def x509_cert_sysfw(self, cert_fname, input_fname, key_fname, sw_rev,
> -                  config_fname, req_dist_name_dict, firewall_cert_data):
> +                  config_fname, req_dist_name_dict, firewall_cert_data,
> +                  boot_ext_data, load_ext_data):
>          """Create a certificate to be booted by system firmware
>
>          Args:
> @@ -101,12 +102,52 @@ imageSize              = INTEGER:{len(indata)}
>                  extended certificate
>                - certificate (str): Extended firewall certificate with
>                  the information for the firewall configurations.
> +            boot_ext_data (dict):
> +              - proc_id (int): The processor ID of core being booted
> +              - flags_set (int): The config flags to set for core being booted
> +              - flags_clr (int): The config flags to clear for core being booted
> +              - reset_vector (int): The location of reset vector for core being
> +                booted
> +            load_ext_data (dict):
> +              - dest_addr (int): The address to which image has to be copied
> +              - auth_type (int): Contains the host ID for core being booted and
> +                how the image is to be copied
>
>          Returns:
>              str: Tool output
>          """
>          indata = tools.read_file(input_fname)
>          hashval = hashlib.sha512(indata).hexdigest()
> +
> +        if boot_ext_data is not None:
> +            boot_ext = f'''
> +[ sysfw_boot_seq ]
> +bootCore = INTEGER:{boot_ext_data['proc_id']}
> +bootCoreOpts_set = INTEGER:{boot_ext_data['flags_set']}
> +bootCoreOpts_clr = INTEGER:{boot_ext_data['flags_clr']}
> +resetVec = FORMAT:HEX,OCT:{boot_ext_data['reset_vector']:08x}
> +# Reserved for future use
> +flagsValid = FORMAT:HEX,OCT:00000000
> +rsvd1 = INTEGER:0x00
> +rsdv2 = INTEGER:0x00
> +rsdv3 = INTEGER:0x00
> +'''
> +        else:
> +            boot_ext = ""
> +
> +        if load_ext_data is not None:
> +            load_ext = f'''
> +[ sysfw_image_load ]
> +destAddr = FORMAT:HEX,OCT:{load_ext_data['dest_addr']:08x}
> +authInPlace = INTEGER:{load_ext_data['auth_type']}
> +'''
> +        else:
> +            load_ext = f'''
> +[ sysfw_image_load ]
> +destAddr = FORMAT:HEX,OCT:00000000
> +authInPlace = INTEGER:{hex(firewall_cert_data['auth_in_place'])}
> +'''
> +
>          with open(config_fname, 'w', encoding='utf-8') as outf:
>              print(f'''[ req ]
>  distinguished_name     = req_distinguished_name
> @@ -138,9 +179,9 @@ shaType                = OID:2.16.840.1.101.3.4.2.3
>  shaValue               = FORMAT:HEX,OCT:{hashval}
>  imageSize              = INTEGER:{len(indata)}
>
> -[ sysfw_image_load ]
> -destAddr = FORMAT:HEX,OCT:00000000
> -authInPlace = INTEGER:{hex(firewall_cert_data['auth_in_place'])}
> +{boot_ext}
> +
> +{load_ext}
>
>  [ firewall ]
>  numFirewallRegions = INTEGER:{firewall_cert_data['num_firewalls']}
> diff --git a/tools/binman/etype/ti_secure.py b/tools/binman/etype/ti_secure.py
> index f6caa0286d9..bc44b684892 100644
> --- a/tools/binman/etype/ti_secure.py
> +++ b/tools/binman/etype/ti_secure.py
> @@ -116,6 +116,7 @@ class Entry_ti_secure(Entry_x509_cert):
>          if auth_in_place:
>              self.firewall_cert_data['auth_in_place'] = auth_in_place
>              self.ReadFirewallNode()
> +        self.ReadLoadableCoreNode()
>          self.sha = fdt_util.GetInt(self._node, 'sha', 512)
>          self.req_dist_name = {'C': 'US',
>                  'ST': 'TX',
> @@ -126,6 +127,23 @@ class Entry_ti_secure(Entry_x509_cert):
>                  'emailAddress': 'support@ti.com'}
>          self.debug = fdt_util.GetBool(self._node, 'debug', False)
>
> +    def ReadLoadableCoreNode(self):
> +        boot_ext_props = ['proc_id', 'flags_set', 'flags_clr', 'reset_vector']
> +        load_ext_props = ['dest_addr', 'auth_type']
> +
> +        self.boot_ext = self.ReadDictFromList(boot_ext_props)
> +        self.load_ext = self.ReadDictFromList(load_ext_props)
> +
> +    def ReadDictFromList(self, props):
> +        props_dict = dict.fromkeys(props)
> +        for prop in props:
> +            val = fdt_util.GetInt(self._node, prop)
> +            if val is None:
> +                return None
> +            else:
> +                props_dict[prop] = val
> +        return props_dict
> +

It looks like you are adding new code but without a test. Please can
you run 'binman test -T' and ensure you cover all lines.

>      def ReadFirewallNode(self):
>          self.firewall_cert_data['certificate'] = ""
>          self.firewall_cert_data['num_firewalls'] = 0
> diff --git a/tools/binman/etype/x509_cert.py b/tools/binman/etype/x509_cert.py
> index b6e8b0b4fb0..b6028f6be84 100644
> --- a/tools/binman/etype/x509_cert.py
> +++ b/tools/binman/etype/x509_cert.py
> @@ -102,7 +102,9 @@ class Entry_x509_cert(Entry_collection):
>                  config_fname=config_fname,
>                  sw_rev=self.sw_rev,
>                  req_dist_name_dict=self.req_dist_name,
> -                firewall_cert_data=self.firewall_cert_data)
> +                firewall_cert_data=self.firewall_cert_data,
> +                boot_ext_data=self.boot_ext,
> +                load_ext_data=self.load_ext)
>          elif type == 'rom':
>              stdout = self.openssl.x509_cert_rom(
>                  cert_fname=output_fname,
> --
> 2.34.1
>

Regards,
Simon
