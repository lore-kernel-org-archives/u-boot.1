Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E0AD715EE
	for <u-boot@archiver.kernel.org>; Sat, 24 Jan 2026 18:33:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF64A83B72;
	Sat, 24 Jan 2026 19:33:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="es2RsTOU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BE2683B72; Sat, 24 Jan 2026 17:36:22 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E497483AEE
 for <u-boot@lists.denx.de>; Sat, 24 Jan 2026 17:36:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ivitro@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48058548779so2310845e9.0
 for <u-boot@lists.denx.de>; Sat, 24 Jan 2026 08:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769272579; x=1769877379; darn=lists.denx.de;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=W3rhVGVAGYEReESQ6QbITTRStbMqBaG9XHySxJuR0t4=;
 b=es2RsTOU0jhE9iyMwh6UCHilE6Nh8VA29/A0A54GN727JOeqErMdIySFZ3BFn3b6lE
 yaqeqI7oMUmqk9EjdqOVRtqFVFCmILO77tc960/K9A/UAndaFqrvh44KVltVYjE9k65P
 SapnQtfciKzY2kMBJ6evxQoMvNZiQTLy5OCRihnQ9MnQrE+dWABrf8t3CZWpaXIMprDg
 ztHesLizB+buWf7CDsEqZsC8UVLT5OJuoYlf1KsOG+K08K1usibRoXMyICHtkqxVg/c+
 CxmtJ98e4TPvnTRIwQaNlnEHpLBRpDRrTUssbVJyCGDok3aAvDOpwl9LpJSTieMG1T6t
 jdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769272579; x=1769877379;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W3rhVGVAGYEReESQ6QbITTRStbMqBaG9XHySxJuR0t4=;
 b=Da8ouVfSEF/TRX4c3jTzmYXFwr1po6rmZmBDY9ByXPVil038PFptaSLJOMib91QcxO
 WuKMfjiMBRyMzxIFSMcMjXiCv4Kk9RJVVESkjzFvOniSHvT14nvVWCyayhLEceTrkuaR
 b8EUGB1/a1K1ijkwAbT7R2puc4iAi0cqauOc18LjYpGCDJttFQnr1IgFvMGYoO8cNiSK
 2A8OA2WMMYwrSaOdFjKEbdYP2NUCKmauS7JzhUG+G7hVgvmbNq3rx67GAsiwiC3vyCrU
 K71kqILHLzbYyuKxgixJd2PMkmo2h8CE5xqglgJ3Lmbt+M7zErgPAKlB8Emr6+LyazdQ
 yZTw==
X-Gm-Message-State: AOJu0YzB8aXdz4BLv9mC1iqqEyN13pwl3+yRq7SC3sv2hHkNVz7hdpTR
 X9oH9jEYPZ8803P+ZmY3u4bbJC3qPbIDWljL+FxOww4663VP5+euMV9S
X-Gm-Gg: AZuq6aKBVwUw2A2RGdFrHrbqr+bnOHPR4oDWvEWrHEw/HV+D4HEbF3jaU3RJMmRFiNT
 xpFiqIyS+NvVwGRwax29sV2WEI7Wh16/GZGIWfRr2RgNa2z5VlgDQ7w35WyLTFGtxHuU9p2llZx
 Y9HryxXv0YOD1mrPI/tnn3LyiuzRkLaXZZ5BY9NX4PSRKWQATM9SWDaToILHrn0vYRmqImg3NkX
 krj1+ZWUhxgZVyF6x3xR8n7A+PFDxJ0ACa9RrhQu5ILRdkvZasmJAJ6xwwgzUv9FYsl1cIJeyzE
 8S7KYRdzuccJxMwJ9f/gDZ2hWpt47EAim5QPD0d++3h8RbT9u73HQPdJ4cnG8jDtEaVxlnJjHhS
 BRi5gsri4E39pa8d0dHGlZUevLy4T5v5iUtrDrm8QvOC/z9kRG8rA5DCsrex+HlvMXo+iM+8u8P
 9CrJQ9POILWkj5wbg+RYhygPwx2cNliLhUAA==
X-Received: by 2002:a05:600c:811a:b0:480:53ce:45d3 with SMTP id
 5b1f17b1804b1-48053d97deemr48193765e9.18.1769272579112; 
 Sat, 24 Jan 2026 08:36:19 -0800 (PST)
Received: from vitor-nb.Home (bl19-170-125.dsl.telepac.pt. [2.80.170.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804d84ebb9sm121415445e9.4.2026.01.24.08.36.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Jan 2026 08:36:18 -0800 (PST)
Message-ID: <06bd1e1cee6a2c3d8fc408330279e093c734f487.camel@gmail.com>
Subject: Re: Toradex Verdin AM62 boot failure on recent master
From: Vitor Soares <ivitro@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, vitor.soares@toradex.com, n-francis@ti.com, 
 b-padhi@ti.com, afd@ti.com, anshuld@ti.com, festevam@denx.de
Date: Sat, 24 Jan 2026 16:36:17 +0000
In-Reply-To: <20260123150129.GK3416603@bill-the-cat>
References: <d7d22e35540857e9726f4b435a73a1435aa4fe37.camel@gmail.com>
 <20260123150129.GK3416603@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
MIME-Version: 1.0
X-Mailman-Approved-At: Sat, 24 Jan 2026 19:33:45 +0100
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

On Fri, 2026-01-23 at 09:01 -0600, Tom Rini wrote:
> On Thu, Jan 22, 2026 at 11:58:54PM +0000, Vitor Soares wrote:
>=20
> >=20
> > Hi,
> >=20
> > I'm experiencing a boot failure on Toradex Verdin AM62 with the latest
> > master.
> > The last known good commit is a4dc1c3b7d56 and it fails to boot at
> > 64662b99c0eb
> > (current HEAD).
> >=20
> > Looking at the 35 commits in this range, I noticed that the first commi=
t
> > after
> > my last known good is 85f586035d75 ("ARM: OMAP2+: Pad SPL binary to 8-b=
yte
> > alignment before DTB"), which directly modifies the K3/AM62 SPL linker
> > script.
> >=20
> > Related commits:
> > =C2=A0=C2=A0 85f586035d75 ARM: OMAP2+: Pad SPL binary to 8-byte alignme=
nt before DTB
> > =C2=A0=C2=A0 8b0ebe054bb3 arm: Update linker scripts to ensure appended=
 device tree is
> > aligned
> >=20
> > Could these changes be related to the boot failure? Any insights would
> > be appreciated.
>=20
> You likely need
> https://patchwork.ozlabs.org/project/uboot/patch/20260122172247.2995437-1=
-b-padhi@ti.com/
>=20

The v3 patch alone didn't fix the boot issue on Verdin AM62.

However, Marek's suggested approach [1] that only aligns flat_dt type
images to 8 bytes does fix it:

diff --git a/tools/fit_image.c b/tools/fit_image.c
--- a/tools/fit_image.c
+++ b/tools/fit_image.c
@@ -685,6 +685,13 @@ static int fit_extract_data(...)
              const char *data, *type;
              int len;

+             /* Ensure flat_dt images are 8-byte aligned per DT spec */
+             if (align_size < 8) {
+                     type =3D fdt_getprop(fdt, node, FIT_TYPE_PROP, &len);
+                     if (type && len > 0 && !strncmp(type, "flat_dt", len =
< 8 ?
len : 7))
+                             align_size =3D 8;
+             }
+
              data =3D fdt_getprop(fdt, node, FIT_DATA_PROP, &len);

+Cc Fabio - this should resolve your boot failure as well.

[1]
https://lore.kernel.org/u-boot/1e1f2e09-bfb7-4c7d-abd6-25a79271f256@mailbox=
.org/

Best regards,
Vitor Soares



