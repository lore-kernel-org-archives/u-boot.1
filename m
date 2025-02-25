Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0B8C021A4
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 02:39:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01DA5805C3;
	Tue, 25 Feb 2025 03:39:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QtEfF2pU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84526807B1; Tue, 25 Feb 2025 03:39:20 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E61680540
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 03:39:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2211acda7f6so113585315ad.3
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 18:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740451157; x=1741055957; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G9pQ9YQzImLymze39gBgCf2v64nw2ACYFL6zeD6l4F8=;
 b=QtEfF2pUF4WBdduqbLYi5TUTSz66qcYN/OcIo4Vnx1PnBCTzvvT0F4RmcIbvVqy1zG
 vBGNgh1vDx6GV28KmNwT9mpAFYBWQhkrx5Ps09g2GIp7BT5Drt5tQJ0Lm338YRT7ijwk
 Ww6mj5rZznUSAxWH25p+YfIKCgtUBHrWtS0is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740451157; x=1741055957;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G9pQ9YQzImLymze39gBgCf2v64nw2ACYFL6zeD6l4F8=;
 b=QXTlN4jGIdg1ckCazp+HGDt8l+Ll6+YEs0SFcWmJLnvf3JfVCGfcHRmfVdX8yknZMB
 gqNjyEOqvLihhXPNak1ya1Ut/MehIW++duQWJ0r8H+p9DMdNq3I7Twhr1LkU2VN3u8/m
 c0DFCxmaqglwjyl7t7KXsfWVCj3u4dY4O1yZw6hfV4ouSFOuccfdMyXePjRbaX72cU9a
 xgzLlbYpaR7iPZSHVkO+xHj/QYgBWNcQ6pQh+G9pVLWLGLoigb4H9OED42FJbz7pG2KP
 UNMrz6WsQcezciYlRyOD3NDhsrGzjInYXszzWLIcYdpJrKHnDVyvySMX8rwGw1xBbERM
 vuGQ==
X-Gm-Message-State: AOJu0YyopJyBpgdzAD6rDUvPSvfiRDY1cFoc+ASv9EfN2rdDoLd4W4Lk
 Tj6uusgLbc3jqOCEGZLsy+AucZzC636ti9BXPkyLF3qCkYo9yGZ0J7H8mIA0mgQInSIplkxCfSQ
 j
X-Gm-Gg: ASbGnct5gIiOLNgzrHr0LBMEJ6C2lPyWUw2a/ttB89Ga9BK2zbzvpjAJhRVGcD9/iqe
 yEXyzqXDbNxg0n96sMT5sz78DRqxPb6Wp3mwDHDzK+umlSuMzjzs84pPvo1EJrppxRQi4Iv7rPI
 tYdTlC4NicTJnsL07A5bpwwETkBTD0d0Hnfu9no/40iWuhzj4+A0z1ZJt0dRqCpss5s8P+7icsJ
 RgqS8Mooj3XqT8pBQkPd/hjhbR14I/4G6u60+AnWpQWoLjAgI8ylBtljp8kh7UZSRR5wDS+A+Lt
 lLVMZPwYkA9eLeHHHll9DhTO
X-Google-Smtp-Source: AGHT+IGKKowB5dyWEMqyc4MG01nO7NZv21GCrvumx8Xd1MpRKjMt5fRxBesGfFxj8cFGgf3MDNP81g==
X-Received: by 2002:aa7:88cb:0:b0:732:1bad:e24b with SMTP id
 d2e1a72fcca58-73426cb1e51mr22981021b3a.10.1740451156579; 
 Mon, 24 Feb 2025 18:39:16 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7347a839dadsm363710b3a.174.2025.02.24.18.39.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 18:39:16 -0800 (PST)
Date: Mon, 24 Feb 2025 20:39:13 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Heiko Schocher <hs@denx.de>
Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20250225023913.GK1233568@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pUo84+ody5eQjlgu"
Content-Disposition: inline
X-Clacks-Overhead: GNU Terry Pratchett
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


--pUo84+ody5eQjlgu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Here's the latest report. Getting closer with the led change. I do wish
it was easier to test fixes here.

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Mon, Feb 24, 2025, 5:05 PM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to Das U-Boot
found with Coverity Scan.

1 new defect(s) introduced to Das U-Boot found with Coverity Scan.
2 defect(s), reported by Coverity Scan earlier, were marked fixed in the
recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 1 of 1 defect(s)


** CID 542488:  Control flow issues  (NO_EFFECT)
/drivers/led/led-uclass.c: 277 in led_get_function_name()


___________________________________________________________________________=
_____________________________
*** CID 542488:  Control flow issues  (NO_EFFECT)
/drivers/led/led-uclass.c: 277 in led_get_function_name()
271                     return uc_plat->label;
272
273             /* Now try to detect function label name */
274             func =3D dev_read_string(dev, "function");
275             cp =3D dev_read_u32(dev, "color", &color);
276             // prevent coverity scan error CID 541279: (TAINTED_SCALAR)
>>>     CID 542488:  Control flow issues  (NO_EFFECT)
>>>     This less-than-zero comparison of an unsigned value is never true.
"color < 0U".
277             if (color < LED_COLOR_ID_WHITE || color >=3D LED_COLOR_ID_M=
AX)
278                     cp =3D -EINVAL;
279
280             if (cp =3D=3D 0 || func) {
281                     ret =3D dev_read_u32(dev, "function-enumerator",
&enumerator);
282                     if (!ret) {


----- End forwarded message -----

--=20
Tom

--pUo84+ody5eQjlgu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme9LU0ACgkQFHw5/5Y0
tyzIlwv/ebhJ5MiaPZjtxNMV3v4jaik9phJBa/cmc3qLG8kVm6QDUR9tc3aAsQWW
b7ZsbQtZDtr+nDar0Mr0OCS5HrjrMJ8z8nwcN6vn1Jp+RoTvDvxsKto9bSg0h68b
bGgelhf+on8sMKyQfMBBm81PH3c0xEs3ZoaEfeVzrbrDKCLO9I4wki/vxE+vYz7g
P9sM4HbJwJd3I59HcDlCpWHVU8JKmSIFNCGOAPn/KXazf9V6BKHbg5SuI9wwphbj
qk6uBoad1fCEcU0XNJ5v7KL2NkYAP9YZ4q8N6TQG43N8bqrguQvpk6eoBfbidQqP
QaaE4S+zTfVQmcHsfStS3+E2eYWoVF7D48O4bEm5i6f414X/QiaeZzlI9mBqkVFB
kiVCwFOIh5qHeYbf/dC2qP8kcBkGuCFSRfcM/4hOBKx2rRKo0fkB8HPv27Exaeo2
p7VOA3/D8QJ7Znibyag2QkZ+FUao+rX0GzJTbW+67RNclvfT/YhFe+Hj4A5duePc
zvtB5pya
=BZpo
-----END PGP SIGNATURE-----

--pUo84+ody5eQjlgu--
