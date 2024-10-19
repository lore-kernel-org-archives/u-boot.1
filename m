Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97DCED3C91E
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 16:16:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C146288FE8;
	Sat, 19 Oct 2024 18:16:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XHEXaZVl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D95EE8918C; Sat, 19 Oct 2024 18:16:24 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1E3488969
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 18:16:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6cbceb321b3so22073536d6.3
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 09:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729354581; x=1729959381; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3b+V53lcIVUPxiMCOyuayy9fezdENg8UL2XiAaTg8fI=;
 b=XHEXaZVlPBoZrNazmPIPzDHfjG0GfC81mjEht8PvekEHWopXe5Q1E8mhlwxxe/Pety
 Cx34nAgC36CwIJhddTPy3pD2YnyyjzlXuK91eYtM6iX9AJ7CEeRhsgwruq25lU/x0Z4W
 LGYXPr1EgSnWjZuY5+c24/7fDLLuYMyn3CJQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729354581; x=1729959381;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3b+V53lcIVUPxiMCOyuayy9fezdENg8UL2XiAaTg8fI=;
 b=bPgxAN5gmWLpWcl5kHURPcCVU+5P64Qq2zSfaXGPW/cNGjZl5RbCBnUHTpC75Hmmyf
 RACsTppVS+pRJ7BhyD7eLN25RHRlS2B1iLCn07O+syxkUKkvg93PTBQyqcxrmCr2+EkB
 Ri8naZhRb6mSU5nEO2xMsbShBUTQ1LcQHSy+Vr9txlaC7kThWHV9nAx99zY2pe3SbMtJ
 7FyHLvCNW5h99e07CbA2V+d3xZucpATvXsde145cKC/95nNDVQs6fPhWuPntV91hK3Rm
 Kq2IDg9fs1eBvPh+11l5Llsiz9jZnKHfbEVRFYILsbOw5jAdFpC8b9LUWry+hUBJ6R1P
 DF7w==
X-Gm-Message-State: AOJu0YyE3UHwIvUFncNF8sEGdMS22T6Xaf2i98RC7JaogyB+0dGfOeLd
 29WYps7XYDB7rVS0mzbn9cHd5/+ozBiksWq9Omc+0Xy8WS/51qukObH09R6LljjY1BlCX20dU99
 AuxA=
X-Google-Smtp-Source: AGHT+IFcEWr+eaIAnmESxD4Nu+J+SogzRTCB3mocawS9skyPqSNgujwB0UJqEl7qPzYnHMr6c7JWtg==
X-Received: by 2002:a05:6214:31a1:b0:6cb:7e7a:ae92 with SMTP id
 6a1803df08f44-6cde1612120mr93680766d6.45.1729354581528; 
 Sat, 19 Oct 2024 09:16:21 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cde114d426sm20438526d6.39.2024.10.19.09.16.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2024 09:16:20 -0700 (PDT)
Date: Sat, 19 Oct 2024 10:16:17 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20241019161617.GT4959@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NOZutCV5cded63El"
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


--NOZutCV5cded63El
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Here's a short update.

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Sat, Oct 19, 2024, 8:35 AM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to Das U-Boot
found with Coverity Scan.

2 new defect(s) introduced to Das U-Boot found with Coverity Scan.
3 defect(s), reported by Coverity Scan earlier, were marked fixed in the
recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 2 of 2 defect(s)


** CID 510857:  Memory - corruptions  (OVERRUN)


___________________________________________________________________________=
_____________________________
*** CID 510857:  Memory - corruptions  (OVERRUN)
/test/boot/bootdev.c: 160 in bootdev_test_any()
154              */
155             if (CONFIG_IS_ENABLED(DSA_SANDBOX))
156                     seq =3D "8";
157             else
158                     seq =3D "6";
159
>>>     CID 510857:  Memory - corruptions  (OVERRUN)
>>>     Overrunning buffer pointed to by "seq" of 2 bytes by passing it to
a function which accesses it at byte offset 2.
160             ut_assertok(bootdev_find_by_any(seq, &dev, &mflags));
161             ut_asserteq(UCLASS_BOOTDEV, device_get_uclass_id(dev));
162             ut_asserteq(BOOTFLOW_METHF_SINGLE_DEV, mflags);
163             media =3D dev_get_parent(dev);
164             ut_asserteq(UCLASS_MMC, device_get_uclass_id(media));
165             ut_asserteq_str("mmc2", media->name);

** CID 510856:  Control flow issues  (UNREACHABLE)
/lib/binman.c: 142 in binman_init()


___________________________________________________________________________=
_____________________________
*** CID 510856:  Control flow issues  (UNREACHABLE)
/lib/binman.c: 142 in binman_init()
136     int binman_init(void)
137     {
138             int ret;
139
140             return 0;
141             binman =3D malloc(sizeof(struct binman_info));
>>>     CID 510856:  Control flow issues  (UNREACHABLE)
>>>     This code cannot be reached: "if (!binman)
  return ((voi...".
142             if (!binman)
143                     return log_msg_ret("space for binman", -ENOMEM);
144             ret =3D find_image_node(&binman->image);
145             if (ret)
146                     return log_msg_ret("node", -ENOENT);
147             binman_set_rom_offset(ROM_OFFSET_NONE);


----- End forwarded message -----

--=20
Tom

--NOZutCV5cded63El
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcT200ACgkQFHw5/5Y0
tyybGAwAicQGJBeEUJLTaT3K6AHjM+f3vpiU89ArokIAZDb343VzguWiyhoRP7lz
rrpin+OyWzw0DKIyRkzPxjQJdJL0XsKBkZ/ppc/k6VKnPmxNlrB1UjHh5Gvt3Ggn
38q4Rerws7KIKm3vZ2Nr6cWBmQgi4ZqlVFNryji0ErPG+glDvmSNo39mGtVXwqr4
berHExxCKsg9RAuUmsgwUF15zUkvt8VPCJZIUEjuglsTZ+F/2Hv5u96oYhdv98mV
JfTXz1E/95AYu8IHCWMAdxa01Si87lY1OHbBVKALj9kGo2D7CnWlrDNnrIbABnPl
Nn/jGU6AmbCvN9Ibdq6/kK8+2LQjoiwXuNKGPYQqpAt/1o0AvN5DtJeHA3zO1fb+
WEHgJ/fBMNxmH9KuSFLwHOhLu0Q4eXb2yKzfFrA2Prg7t3aW+CkNB1esucWdbmuf
Q59S/1PObjTSqOrv4ujxrls91T5JDiuKHBKElFywgi6InUtbScFqMgJsAvI2IZ9h
ZmYMhLAH
=N3NI
-----END PGP SIGNATURE-----

--NOZutCV5cded63El--
