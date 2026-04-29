Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 537BEFF8875
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 23:55:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0CD0848FD;
	Thu, 30 Apr 2026 01:55:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hZvyj70N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6707C848FD; Thu, 30 Apr 2026 01:55:34 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33328848F3
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 01:55:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-bb662d56b5aso60906366b.1
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 16:55:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777506932; cv=none;
 d=google.com; s=arc-20240605;
 b=DfTS0fWSKtV1vCstOErDt8U4YancF+OYuwFBI0cPvTVOBpkk0NtZLo0wdnDFNCLBy+
 i9KS7Dozv3p0xlUo2Nq2jg0uOPhXuY1apaCtxlO/IG+RdspyPFABZR8HqR3hxdWJBIvD
 nampYG2akS/zP1ZzIywRkh0twPjZiG1yF3hNdUBm6erENXtpUrNlBg5LZq8mU/unX0wG
 aqAnBuQOkemZCaXnsCsQN4PULAOWBNcgfHciTSdo6idLY1VfWEuujvYo9/JSN9ceIaai
 ky1q0Hj0AA1tKMtbb5gvX7YBqj+btRx9Pdp/Q049WZPLXuWfqIZuwimfd+TuexL4D12m
 0pnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WgAqhuxP3nwmIeu1aGUsqnJ9B3KVf4HCyFgqE9kBEhU=;
 fh=W+98wJVgelTEn3G0vWkRNFn3JWtAlkgbLGlCypg//J0=;
 b=fC4nOx8a8IbdC1oFCQkR8sCV8oMhttnF/4j4wcaLA4MeJrki9XLc1LmU45lME2SLGG
 Kax44vLc2b5d5Af4I31xh+Sy066XbbSgMHwUwUH49Eu7vw30ZK3beH6jYgJ/2wEw5CRB
 tYmKTuxv4E3B13MIB8Ba/QStlj8/shgjjpyK5qfxi7et8kRCcHQX/fDZUGrmxcy2Yie3
 3/UOblWGXtTNnkRbTnqg/uwfIc8EbF+qhs7+Cq3HSUhbVyNYx62KwmYpGpkl+f7MORhi
 X9EJWPzMc/biB9q4KNhvLti7o/DZsMlNepxWycIlRozZoYEK0bDJaF1mN9bx/UzG1XFu
 mdhw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777506932; x=1778111732; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WgAqhuxP3nwmIeu1aGUsqnJ9B3KVf4HCyFgqE9kBEhU=;
 b=hZvyj70NWWi5WpOCAmcrjy9TCcogokC7tCNqApmeCJ3SoJSAEwlMV4I0VoIrNl3CB3
 OAEY1XigMwjylkhv9OFseOMWq1POi2vQZehZqtA34lHDfqwgs/Z+op6DLe6LWxU2ugGP
 H0k4jMl+dU6R9aEvgLEoMrfkTj5DrIt88k2Lw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777506932; x=1778111732;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WgAqhuxP3nwmIeu1aGUsqnJ9B3KVf4HCyFgqE9kBEhU=;
 b=n4qMxqJ2cBIq+LfNiy3Il+qJxcNg2MOHcO0rKTr+DAF9kgZaX7MfsLeWtxcdOaLMKE
 RY3V309GdM95W+Gx3AB07smN44NfrkMh6N8PbJmwXicQqGLHxOhv/DRH/hlix2IhiSU4
 Is2refTJuqfPOPuMaVDoe2D27pSw37gwP/ceLMRG2meaLH2bWtB41hVqYMp57+BNfbmQ
 BKcFas0om5k1tUrRmoBeheoDh0if6YY4sqFYC80ObmzqhZhfZF2A0lU6xNrsSFFYTHnu
 GF7jmNNbgpSuk9QcDdSSUU6FvBad7UKYIUPtuoQ3j1tmm2H+hajuCHWmUefCvg67rZOC
 KGkA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+rxZl/8NygcUTyAEvMatauDWa7H1UH8dVQb6p9g/bjtMDxhSwk954JnnwYqP5FlLuhl7iT6E4=@lists.denx.de
X-Gm-Message-State: AOJu0Yz0R819sZIT7ZT+WkZGhNwt9tTmY/j0VyPEAGNE8DHd9P4gx8fj
 99BpcxY2aia/ohdydNOdAELxFXVevHsV7TlmgJbk5il4xKkDq3FZeDZPgn182Rdm4zlC4019xvW
 6/lOFnGtpY1G5o4mkrTGafoIyGnXNeuDM3jOf2IcM
X-Gm-Gg: AeBDietgO1ya6USjZunArO6BVIhe8joEEbLAXCSlHca5F3hnbM4i3DOVKxlZu09uAjm
 vL17g8KpUf0RhBu8Sgj7Lju4/O3orHluauYOvF8gGY/+THLJyVTNVtIR2KYMltEUn8QdJahOR2e
 DkCkcQme8r1/oHBGyu9Rbr4SrM01AI7kn3JTMPoyChzKhryRVKCTQaIRhpqrOiBwQ4ZERhJ7JUf
 ZHmsZPdGjf3kKTt9bAs2TJgVJ9XjBMDGmeRam4pcsRv3hTi9baIf6E2dRXgF4UqQiER8pBzcxxJ
 AtZc1RwwNMunPTTM
X-Received: by 2002:a17:906:6a12:b0:b9e:8d2:1eb6 with SMTP id
 a640c23a62f3a-bbb98a71a68mr6579666b.27.1777506931642; Wed, 29 Apr 2026
 16:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260425033742.1519298-1-b-padhi@ti.com>
 <20260425033742.1519298-8-b-padhi@ti.com>
In-Reply-To: <20260425033742.1519298-8-b-padhi@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Apr 2026 17:55:19 -0600
X-Gm-Features: AVHnY4LWXq0bjojQC5K_HfnZiKHVnQl0r_lkD7H8D75zyTjZWiSQhsDEL3obHrw
Message-ID: <CAFLszTjkWWv4AsKusuD3nMm23UBdc2izkZONnqr25ZM0D84WpA@mail.gmail.com>
Subject: Re: [PATCH v4 07/11] binman: openssl: Add boot and load extensions to
 x509 cert
To: b-padhi@ti.com
Cc: trini@konsulko.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On 2026-04-25T03:37:39, Padhi, Beleswar <b-padhi@ti.com> wrote:
> binman: openssl: Add boot and load extensions to x509 cert
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
>
> tools/binman/btool/openssl.py   | 49 ++++++++++++++++++++++++++++++++++++=
+----
>  tools/binman/etype/ti_secure.py | 18 +++++++++++++++
>  tools/binman/etype/x509_cert.py |  4 +++-
>  3 files changed, 66 insertions(+), 5 deletions(-)

> diff --git a/tools/binman/btool/openssl.py b/tools/binman/btool/openssl.p=
y
> @@ -101,12 +102,52 @@ imageSize              =3D INTEGER:{len(indata)}
> +        if boot_ext_data is not None:
> +            boot_ext =3D f'''
> +[ sysfw_boot_seq ]
> +bootCore =3D INTEGER:{boot_ext_data['proc_id']}
> +bootCoreOpts_set =3D INTEGER:{boot_ext_data['flags_set']}
> +bootCoreOpts_clr =3D INTEGER:{boot_ext_data['flags_clr']}
> +resetVec =3D FORMAT:HEX,OCT:{boot_ext_data['reset_vector']:08x}

Does this section actually make it into the certificate? The test in
patch 8 only checks the file is non-empty, so it would not catch this.

> diff --git a/tools/binman/btool/openssl.py b/tools/binman/btool/openssl.p=
y
> @@ -101,12 +102,52 @@ imageSize              =3D INTEGER:{len(indata)}
> +rsvd1 =3D INTEGER:0x00
> +rsdv2 =3D INTEGER:0x00
> +rsdv3 =3D INTEGER:0x00

rsdv2 / rsdv3 should be rsvd2 / rsvd3 to match rsvd1 above.

> diff --git a/tools/binman/etype/ti_secure.py b/tools/binman/etype/ti_secu=
re.py
> @@ -116,6 +116,7 @@ class Entry_ti_secure(Entry_x509_cert):
>          if auth_in_place:
>              self.firewall_cert_data['auth_in_place'] =3D auth_in_place
>              self.ReadFirewallNode()
> +        self.ReadLoadableCoreNode()

The new properties (proc_id, flags_set, flags_clr, reset_vector,
dest_addr, auth_type) are not described in the Entry_ti_secure
docstring. Please document them alongside auth-in-place, including
whether each group is optional and what the values mean.

> diff --git a/tools/binman/etype/ti_secure.py b/tools/binman/etype/ti_secu=
re.py
> @@ -126,6 +127,23 @@ class Entry_ti_secure(Entry_x509_cert):
> +    def ReadLoadableCoreNode(self):
> +        boot_ext_props =3D ['proc_id', 'flags_set', 'flags_clr', 'reset_=
vector']
> +        load_ext_props =3D ['dest_addr', 'auth_type']
> +
> +        self.boot_ext =3D self.ReadDictFromList(boot_ext_props)
> +        self.load_ext =3D self.ReadDictFromList(load_ext_props)
> +
> +    def ReadDictFromList(self, props):
> +        props_dict =3D dict.fromkeys(props)
> +        for prop in props:
> +            val =3D fdt_util.GetInt(self._node, prop)
> +            if val is None:
> +                return None
> +            else:
> +                props_dict[prop] =3D val
> +        return props_dict

A few things:

- ReadDictFromList() is a misleading name as it reads from a node,
using a list of property names, into a dict. How about ReadIntProps()
?
- Drop the else after 'return None' =E2=80=94 just fall through, that's the
usual Python style.
- Silently returning None on the first missing prop means a
partially-specified set (e.g. user provides proc_id and flags_set but
forgets reset_vector) is treated identically to "no boot extension
wanted". That is going to be very hard to debug. Best to raise an
explicit error listing the missing properties (similar to what
Firewall.ensure_props() does) when some but not all of the group are
present. Then you can test it too.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
