Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA58D711A6
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 14:52:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77CB8890D5;
	Wed, 20 Nov 2024 15:52:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c/QuxiU3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85A7289229; Wed, 20 Nov 2024 15:52:46 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CE3E88EEA
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 15:52:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2ea4e9e6ef2so2994403a91.1
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 06:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732114362; x=1732719162; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LD4SprUhxvOuM4BIqI/GgDJsRBolxopvr6Dqt7XmUKI=;
 b=c/QuxiU3UacLIHJ2ceVNU9nf+h2f+E8mP8z0c2oncCqNmeLZbFFyEPoTMP5bcwZyNr
 4PowwvmSW19iROQkFQTJjwrJnD/g3tjkFe3eQnmPC6s2/8H1D9yk9twBGoc+DNNuNGQP
 uwHtJBlu0OEiMZSJnZ61B1Qs2t5VtO8Fbw/J3f+tW4tqDlQgKKbEyewyu3kSugUvoSon
 B7T9NHO+F+7Jfd0ih8ij4lHoo+s5fxhLSBqHe0fmOurgpvZT0v58KmsYCJJb5TzhHy97
 ICHhIV2ZlVWP41ZmuYsqCeGqLQx+U21t+VBpzVrswkOB46GAFROvZ9kUar8ln3mwhfaB
 /VFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732114362; x=1732719162;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LD4SprUhxvOuM4BIqI/GgDJsRBolxopvr6Dqt7XmUKI=;
 b=AAyiwlIdIm7CyY0EZZ1WBace3fmeBzr6uEOG1KEKxxkvB0oTzte6hQOHKaWRdvMcOd
 WWiQMSJm7a1PN5c9XgskfstROsDVFA3gNE92ayuVU4oOi+HS8ew6ShDW0hg0SxkLZnYC
 8Qmai6TgxuRsVJ7nBiF45WTHd3Dq4Fpg0uAFYNbPW7rVp+wDm+eN+7HIbr/tNQeBhoSu
 BY1XOieRWlxlsNNQlfzJ2NmFc1nslVss5vbb4Y4KMzaQFiEDiubKRwoys+20goNguHc0
 9WHHMJh/y1GIa1wLGa8Yf1swtaOdnKdsxQwcJ/kBmlKes/K0j2AcafirARiEv9peUXku
 6j+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwR8bGVAbGpMo2uJpWQQVUL1+pYZuVTenF8s+JbQ+OwGfxdCR5Q6uTSsgWbtkDqgTCe2CNLgY=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2qqED2Raqc59PiGzvIsORo/zM5NwivukaD8rjPI0xQWfeplf1
 KpAPu85IBDmUC/LPFgNZsETeOLAT/WBXKdqbdLZ8Uabm6GRU/oIpi3SXsU6Yg39jbUXv0xJpSgF
 5JqjSrDNBmdAZ4fgNnQXmhUrLtxs=
X-Google-Smtp-Source: AGHT+IHT4R4thQlyKPO/6oilJkOaa/e7SbkqQo4MQLG4q4nvLhf8qWBHz69ias4eiq5WBABbUzIcFEMyYEwUpGwaSic=
X-Received: by 2002:a17:90b:2249:b0:2ea:3836:33de with SMTP id
 98e67ed59e1d1-2eaca73e0c1mr3576774a91.20.1732114362371; Wed, 20 Nov 2024
 06:52:42 -0800 (PST)
MIME-Version: 1.0
References: <20241118210908.51196-1-adrianox@gmail.com>
 <20241118210908.51196-8-adrianox@gmail.com>
 <d3e50c54-4d39-4930-a6f1-b29ba60bfd19@canonical.com>
In-Reply-To: <d3e50c54-4d39-4930-a6f1-b29ba60bfd19@canonical.com>
From: =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>
Date: Wed, 20 Nov 2024 11:52:31 -0300
Message-ID: <CAMGU2hWJ07OaWJtavxt-dauKQ=WoH5ipuTp2HecKdmKJ4X1M9Q@mail.gmail.com>
Subject: Re: [PATCH v4 07/14] efi_loader: device_path: add support for HTTP
 device path
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org, 
 ilias.apalodimas@linaro.org, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

El mar, 19 nov 2024 a las 7:14, Heinrich Schuchardt (<
heinrich.schuchardt@canonical.com>) escribi=C3=B3:

> On 18.11.24 22:09, Adriano Cordova wrote:
> > Add efi_dp_from_http to form a device path from HTTP. The
> > device path is the concatenation of the device path returned
> > by efi_dp_from_ipv4 together with an URI node and an END node.
> >
> > Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> > ---
> > Changes in v4:
> > - Reworked an if-else
> >
> > Changes in v3:
> > - Moved argument checks in efi_dp_from_http to the beginning of the
> function
> >   include/efi_loader.h             |  1 +
> >   lib/efi_loader/efi_device_path.c | 52 +++++++++++++++++++++++++++++++=
+
> >   2 files changed, 53 insertions(+)
> >
> > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > index 612bc42816..96b204dfc3 100644
> > --- a/include/efi_loader.h
> > +++ b/include/efi_loader.h
> > @@ -872,6 +872,7 @@ struct efi_device_path *efi_dp_part_node(struct
> blk_desc *desc, int part);
> >   struct efi_device_path *efi_dp_from_file(const struct efi_device_path
> *dp,
> >                                        const char *path);
> >   struct efi_device_path *efi_dp_from_eth(void);
> > +struct efi_device_path *efi_dp_from_http(const char *server);
> >   struct efi_device_path *efi_dp_from_mem(uint32_t mem_type,
> >                                       uint64_t start_address,
> >                                       size_t size);
> > diff --git a/lib/efi_loader/efi_device_path.c
> b/lib/efi_loader/efi_device_path.c
> > index cdeea4791f..9ee03062ac 100644
> > --- a/lib/efi_loader/efi_device_path.c
> > +++ b/lib/efi_loader/efi_device_path.c
> > @@ -1012,6 +1012,58 @@ struct efi_device_path *efi_dp_from_ipv4(struct
> efi_ipv4_address *ip,
> >       return dp2;
> >   }
> >
>
> A function description is missing.
> Please,
>
> > +struct efi_device_path *efi_dp_from_http(const char *server)
> > +{
> > +     struct efi_device_path *dp1, *dp2;
> > +     struct efi_device_path_uri *uridp;
> > +     efi_uintn_t uridp_len;
> > +     char *pos;
> > +     char tmp[128];
> > +     struct efi_ipv4_address ip;
> > +     struct efi_ipv4_address mask;
> > +
> > +     if ((server && strlen("http://") + strlen(server) + 1  >
> sizeof(tmp)) ||
> > +         (!server && IS_ENABLED(CONFIG_NET_LWIP)))
> > +             return NULL;
> > +
> > +     efi_net_get_addr(&ip, &mask, NULL);
> > +
> > +     dp1 =3D efi_dp_from_ipv4(&ip, &mask, NULL);
>
> This seems to be the only usage of efi_dp_from_ipv4(). So we should make
> it static.
>
> dp1 is expected to be NULL if we are out of memory. This error needs to
> be handled.
>
> > +
> > +     strcpy(tmp, "http://");
>
> @Ilias:
> Linaro sent a patch series for supporting https.
> Will that go in after this series?
>
> > +
> > +     if (server) {
> > +             memcpy(tmp + strlen("http://"), server, strlen(server) +
> 1);
>
> Please, use strcat() to simplify this line.
>
> > +     }
> > +#if !IS_ENABLED(CONFIG_NET_LWIP)
>
> Please use 'else if' instead of '#if'.
>
> Best regards
>
> Heinrich
>

Hi Heinrich,
I can't use 'else if' as the symbol net_server_ip is only defined in legacy
net

Best,
Adriano

>
> > +     else {
> > +             ip_to_string(net_server_ip, tmp + strlen("http://"));
> > +     }
> > +#endif
> > +
> > +     uridp_len =3D sizeof(struct efi_device_path) + strlen(tmp) + 1;
> > +     uridp =3D efi_alloc(uridp_len + sizeof(END));
> > +     if (!uridp) {
> > +             log_err("Out of memory\n");
> > +             return NULL;
> > +     }
> > +     uridp->dp.type =3D DEVICE_PATH_TYPE_MESSAGING_DEVICE;
> > +     uridp->dp.sub_type =3D DEVICE_PATH_SUB_TYPE_MSG_URI;
> > +     uridp->dp.length =3D uridp_len;
> > +     debug("device path: setting uri device path to %s\n", tmp);
> > +     memcpy(uridp->uri, tmp, strlen(tmp) + 1);
> > +
> > +     pos =3D (char *)uridp + uridp_len;
> > +     memcpy(pos, &END, sizeof(END));
> > +
> > +     dp2 =3D efi_dp_concat(dp1, (const struct efi_device_path *)uridp,=
 0);
> > +
> > +     efi_free_pool(uridp);
> > +     efi_free_pool(dp1);
> > +
> > +     return dp2;
> > +}
> > +
> >   /* Construct a device-path for memory-mapped image */
> >   struct efi_device_path *efi_dp_from_mem(uint32_t memory_type,
> >                                       uint64_t start_address,
>
>
