Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F16AEE49A8
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 21:09:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2529787077;
	Mon, 21 Aug 2023 23:09:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IntnNWLn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 999648704F; Mon, 21 Aug 2023 23:09:33 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF5D387085
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 23:09:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-58dfe2d5b9aso52050107b3.1
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 14:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692652169; x=1693256969;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FsRGN9fg5fov2wjxXQLdeWunP/x6Bz2tBjPEoT7P0NM=;
 b=IntnNWLnHWEjuYHlRuIiTXhLdmGWDjr5fD/SncJKiKg1q5rWpTS7ahmrMd/JGP8Hgn
 mHpR0uKWn4YD2a879JWOrtWDKwZBTM3Pkxehad565dbaf3g3dlxflzz79S/ZiMpl6xiB
 hafXVpL+oNuXTgzyTJVhBBUQvfAL7RvhhKpdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692652169; x=1693256969;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FsRGN9fg5fov2wjxXQLdeWunP/x6Bz2tBjPEoT7P0NM=;
 b=ReyK4bqhcq/HJQaSz6Xvyd+hJ5/5xHjs+tKBjq5FkQpnXmYwNzq0E0QhM1223aEcFB
 AzxCXznlnLFZGqVPg2yG+4OuL8V936fHsyMct4bfdWnD8yr7HwQPbDyNEADdNebeWWIe
 4+4Vvu5rW+5yrQ4Cd/GqdKUGmaWCe6WMZouD5q5Rxs/odOSJ4bzJDpWvnHCguEqZZunz
 8CPEfK/lfAaB+QKqzDO7nW+A6SQ65qTM02LGkRJgzJ7sk3jkUy8HUGmjnIQ9L6ItWpn+
 7jrvmhwl31scxvJYkeN3vFNiu1KvVoMUUiEGpbGixZf4Pi8nqZTX/8WVL3+xX3Gz0mNS
 8WqQ==
X-Gm-Message-State: AOJu0YzqVLZ0E7Ko+pUG2A+cTzemY+O33WER6+f6EglB/XiA4d9LW3H9
 tzDNlPeDxk+b61xuO0GmamkSJl9ZzHJOpYO/phq13Q==
X-Google-Smtp-Source: AGHT+IEuvn9s5Yv8lDQeWgoXXkNNGTpqn0xd6TjFmo+nbgE8zncbaG7OAsytC8+WMDtA0WzWlSPgkQ==
X-Received: by 2002:a81:6c46:0:b0:583:aca3:469c with SMTP id
 h67-20020a816c46000000b00583aca3469cmr5908292ywc.2.1692652169318; 
 Mon, 21 Aug 2023 14:09:29 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-49e5-7fcb-0da2-d03f.res6.spectrum.com.
 [2603:6081:7b00:6400:49e5:7fcb:da2:d03f])
 by smtp.gmail.com with ESMTPSA id
 g123-20020a0ddd81000000b0055a373a7e5asm2436796ywe.131.2023.08.21.14.09.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 14:09:28 -0700 (PDT)
Date: Mon, 21 Aug 2023 17:09:27 -0400
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de,
 Alvaro Fernando =?iso-8859-1?Q?Garc=EDa?= <alvarofernandogarcia@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20230821210927.GL3953269@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1XpdCwwUDSyubd1u"
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


--1XpdCwwUDSyubd1u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Here's the latest report

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Mon, Aug 21, 2023 at 4:30=E2=80=AFPM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to Das
U-Boot found with Coverity Scan.

4 new defect(s) introduced to Das U-Boot found with Coverity Scan.


New defect(s) Reported-by: Coverity Scan
Showing 4 of 4 defect(s)


** CID 464362:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
/drivers/video/pwm_backlight.c: 68 in set_pwm()


___________________________________________________________________________=
_____________________________
*** CID 464362:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
/drivers/video/pwm_backlight.c: 68 in set_pwm()
62     {
63      u64 width;
64      uint duty_cycle;
65      int ret;
66
67      if (priv->period_ns) {
>>>     CID 464362:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
>>>     Potentially overflowing expression "priv->period_ns * (priv->cur_le=
vel - priv->min_level)" with type "unsigned int" (32 bits, unsigned) is eva=
luated using 32-bit arithmetic, and then used in a context that expects an =
expression of type "u64" (64 bits, unsigned).
68              width =3D priv->period_ns * (priv->cur_level - priv->min_le=
vel);
69              duty_cycle =3D div_u64(width,
70                                   (priv->max_level - priv->min_level));
71              ret =3D pwm_set_config(priv->pwm, priv->channel, priv->peri=
od_ns,
72                                   duty_cycle);
73      } else {

** CID 464361:  Control flow issues  (DEADCODE)
/drivers/firmware/arm-ffa/arm-ffa-uclass.c: 148 in ffa_print_error_log()


___________________________________________________________________________=
_____________________________
*** CID 464361:  Control flow issues  (DEADCODE)
/drivers/firmware/arm-ffa/arm-ffa-uclass.c: 148 in ffa_print_error_log()
142
143             if (ffa_id < FFA_FIRST_ID || ffa_id > FFA_LAST_ID)
144                     return -EINVAL;
145
146             abi_idx =3D FFA_ID_TO_ERRMAP_ID(ffa_id);
147             if (abi_idx < 0 || abi_idx >=3D FFA_ERRMAP_COUNT)
>>>     CID 464361:  Control flow issues  (DEADCODE)
>>>     Execution cannot reach this statement: "return -22;".
148                     return -EINVAL;
149
150             if (!err_msg_map[abi_idx].err_str[err_idx])
151                     return -EINVAL;
152
153             log_err("%s\n", err_msg_map[abi_idx].err_str[err_idx]);

** CID 464360:  Control flow issues  (NO_EFFECT)
/drivers/firmware/arm-ffa/arm-ffa-uclass.c: 207 in ffa_get_version_hdlr()


___________________________________________________________________________=
_____________________________
*** CID 464360:  Control flow issues  (NO_EFFECT)
/drivers/firmware/arm-ffa/arm-ffa-uclass.c: 207 in ffa_get_version_hdlr()
201             major =3D GET_FFA_MAJOR_VERSION(res.a0);
202             minor =3D GET_FFA_MINOR_VERSION(res.a0);
203
204             log_debug("FF-A driver %d.%d\nFF-A framework %d.%d\n",
205                      FFA_MAJOR_VERSION, FFA_MINOR_VERSION, major, minor=
);
206
>>>     CID 464360:  Control flow issues  (NO_EFFECT)
>>>     This greater-than-or-equal-to-zero comparison of an unsigned value =
is always true. "minor >=3D 0".
207             if (major =3D=3D FFA_MAJOR_VERSION && minor >=3D FFA_MINOR_=
VERSION) {
208                     log_debug("FF-A versions are compatible\n");
209
210                     if (dev) {
211                             uc_priv =3D dev_get_uclass_priv(dev);
212                             if (uc_priv)

** CID 464359:    (PASS_BY_VALUE)
/drivers/firmware/arm-ffa/arm-ffa-uclass.c: 168 in invoke_ffa_fn()
/drivers/firmware/arm-ffa/ffa-emul-uclass.c: 673 in invoke_ffa_fn()


___________________________________________________________________________=
_____________________________
*** CID 464359:    (PASS_BY_VALUE)
/drivers/firmware/arm-ffa/arm-ffa-uclass.c: 168 in invoke_ffa_fn()
162      * @args: FF-A ABI arguments to be copied to Xn registers
163      * @res: FF-A ABI return data to be copied from Xn registers
164      *
165      * Calls low level SMC implementation.
166      * This function should be implemented by the user driver.
167      */
>>>     CID 464359:    (PASS_BY_VALUE)
>>>     Passing parameter args of type "ffa_value_t" (size 144 bytes) by va=
lue, which exceeds the low threshold of 128 bytes.
168     void __weak invoke_ffa_fn(ffa_value_t args, ffa_value_t *res)
169     {
170     }
171
172     /**
173      * ffa_get_version_hdlr() - FFA_VERSION handler function
/drivers/firmware/arm-ffa/ffa-emul-uclass.c: 673 in invoke_ffa_fn()
667      * invoke_ffa_fn() - SMC wrapper
668      * @args: FF-A ABI arguments to be copied to Xn registers
669      * @res: FF-A ABI return data to be copied from Xn registers
670      *
671      * Calls the emulated SMC call.
672      */
>>>     CID 464359:    (PASS_BY_VALUE)
>>>     Passing parameter args of type "ffa_value_t" (size 144 bytes) by va=
lue, which exceeds the low threshold of 128 bytes.
673     void invoke_ffa_fn(ffa_value_t args, ffa_value_t *res)
674     {
675             sandbox_arm_ffa_smccc_smc(&args, res);
676     }
677
678     /**

--=20
Tom

--1XpdCwwUDSyubd1u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTj0oQACgkQFHw5/5Y0
tyxwgQwAg+pCrfpUgiXFytS5u0LMxYDvgzgyHOYs23PbCNoJauEGeIe9ckpgT5k5
3ucRIdUsoUxTUQo1fpYVBfMv/8WyO4bk7yz2ySOVrs4kTQM5IpgadbURKCqx0tX5
Uhdml4zsPhWG/DOS5TXcFndHX+iDpfjgks3NXR3PjeNK10tNSnxmXFwsMMJEMF4c
1cI0V+pH+sQ3plvrjQRFJAX5Cirej5hhn5KxXmZ1r3/goMPy0rG5SK8LFzdR69Dh
ZTE/LEl4va4FSN9ulDIgvf3+2oDlg/Z8w/E+V4Ur0PRhluOP1cuvbBjbT9vHIOa5
0hr4VlmDX1hQGnzapcoXRLt7BMyW3CV3p7VCkrT+6i7Q8FYaFTDlac9xAIzRGOhh
2D7h4nLupZlg5Byl837XN/5RO57mkvDlmE7PGyG3oXyiVs0mGxQHnpxyWTelG7oE
GSPWw2IVShqJy42si0V+eeHruv41/9eIs3ZoOUlhtGeqR9GLcFNIcDbKIl8EHJNB
Gon5DwFQ
=BXSB
-----END PGP SIGNATURE-----

--1XpdCwwUDSyubd1u--
