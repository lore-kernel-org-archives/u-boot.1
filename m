Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45482CD8CA8
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 06:53:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 771F2838BB;
	Tue,  9 Jun 2026 08:53:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sigma-star.at header.i=@sigma-star.at header.b="rLqvSuIv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4C54839A8; Tue,  9 Jun 2026 08:53:29 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CE74807C4
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 08:53:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard@sigma-star.at
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-45efa80e0afso3949795f8f.2
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 23:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1780988007; x=1781592807; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RVNcV9PuFd0C40DVWC4Au6oTieajN7Jpqn7GuAojb7c=;
 b=rLqvSuIvxNqKNr7m7LQNK7WtPUzBm+O0UzDiaLj8rJ9iu6XOdcSoaosM72LN7wjEtH
 l2UV+UgD7ejCM2rjsQ8qcRVm2o6aX9B6MWpE7UcXVABWLogEV/RI7q4u1N+m2xMAzQwQ
 GBlYU6uArG5s9LRo/yKm5levF+LYRsJw7Iym1ErQ7YeuOUHbXv4LJoJLNqTqH4ft67to
 gi8RTYkmvYyyArAvC9bbkwoX582kxsEn190uxU3BeNqQE4/4PJb9SMt2wzxDtHjImzGj
 Jb9KcMMIsc7c0dQrVjJWJ/j+JdavQ2QxHfonMlR87RfOPTXl5fFJSVQ/vYrhTp6+UJS6
 UA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780988007; x=1781592807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RVNcV9PuFd0C40DVWC4Au6oTieajN7Jpqn7GuAojb7c=;
 b=VRpe25ikw420y2SqrsThTTx0FlnwvjmDavV3krOovVJGpxj5VZ8f7Ljg+wkeFQRef/
 kuDgalBlT3MnbD3OEPHyNUa4nxzotcB1Y/mxR+2mDKSbmFxpVw11jlhRqNMCtrSFkVIf
 xEIImQHyn98EMtE1rG3TXdxqJk/oUEVeTQ21dhsA8Fcm5ZpYWH+y6Kw3ELIynhXdQNg4
 K2ZsleUgoGUyiuNLzKaP0JW0dINXNyXyEefadjwvgQEhKTSLjvC6wuN7l0/yuWDF/cBt
 1CJjONBbLtfM93E5+3UZbpeEXS+vUaEVphxGh4KDhEdDr9HtBXzBD8RugRbLbGvMARpz
 OjzA==
X-Gm-Message-State: AOJu0Yw/eVXjlzU2CB6jDs/pCID1n3Jce6pGBFI+ieFh8BhhjlHt5V1f
 CqFA7nSpMiKTOAlnk0MobObczo//F+e0QHXHFHBRhSZ6biGlKtrERJBuPP5o8c+IamU=
X-Gm-Gg: Acq92OEfz9GUX1ugnugm5e2M/rvgTbwDknikcqV2dzexhRiFPPuwesvVTwXHhmiWjG8
 8inol97ZR8+Ltdgp/S2f+GYAOWx0lU7Zv8OOil5Auk+moJTpS8m/5QH+XpSW0qO18kzlnvYBoI9
 pl8eYFCOxcUYjp4xO/PnReTug0O2U/GCBHyPbfcGcPiAk9rTRN07tIqpT5iEP+hqeRyVtAuN3BC
 0qUI51XZUxYz6U7HhUbE+IYYN1Oe6f7aOCGYGFJPwDnRb3H2jJ1zxtSxEJ4ViyrxBxUQf8ajnA2
 vt9H7Se7GrsfkDG2KqUbiyOoYT/HoHp+g3H95wKIdZRkTtBOuHYUWwRbvFkzR++x9P165tdXOv3
 lFf52rz5yGUnru3YCOb5o0MRm3vVHiN4WAwTwTX+96Qmg39ApQqj2kgzJhuFM1fZ9KRPhbtjJ02
 l+UF5R6otBTfvuijAWP6gY8lF78IUeBKIOBPEtx2pZGv+O4GuXfqAE2jCGY5Rywl4XM/7tMl24Y
 ihD9jW+IAWudw==
X-Received: by 2002:a5d:6190:0:b0:45e:ec18:f20a with SMTP id
 ffacd0b85a97d-46030759730mr19846455f8f.32.1780988006569; 
 Mon, 08 Jun 2026 23:53:26 -0700 (PDT)
Received: from somecomputer (85-127-105-26.dsl.dynamic.surfer.at.
 [85.127.105.26]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f3446aesm65094573f8f.24.2026.06.08.23.53.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 23:53:26 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: sahil.malhotra@nxp.com, Ye Li <ye.li@oss.nxp.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, alice.guo@nxp.com,
 peng.fan@nxp.com, upstream+uboot@sigma-star.at, ye.li@nxp.com
Subject: Re: TZASC misconfiguration on i.mx8m
Date: Tue, 09 Jun 2026 08:53:25 +0200
Message-ID: <4466851.5hrfCrGMcO@nailgun>
In-Reply-To: <9bcf6592-e616-4b7f-9d54-83987c6a2bbb@oss.nxp.com>
References: <3208216.Ym5mLc6kNg@nailgun>
 <CAKxiovgS_1x4rVYN+bdXGGSBLQ87Q-ho88wSLn=eVEMQO9BG6Q@mail.gmail.com>
 <9bcf6592-e616-4b7f-9d54-83987c6a2bbb@oss.nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Ye Li,

On Dienstag, 9. Juni 2026 03:44 Ye Li wrote:
> >     We have discussed this with iMX optee owner. The fix should be done=
 in
> >     OPTEE not u-boot.
> >     1. OPTEE uses secure memory, so it needs to re-confiure trustzone to
> >     meet secure requirement not depending on SPL setting.
> >     2. SPL also supports Non-optee case.
> >=20
> >     Best regards,
> >     Ye Li
> >=20
> >=20
> > Can you please point to this discussion?
>=20
> It is our internal discussion not on community thread. I add Sahil to=20
> comment for optee. And please notice, trustzone should be enabled before=
=20
> DDR initialization. So it should be in SPL not optee. Optee can=20
> reconfigure trustzone setting.

But U-Boot right now harms the TZASC settings.

This is exactly why upstream OP-TEE has the following guard:
commit 443c5817de47f1bd19091b419806898070382a67
Author: Marco Felsch <m.felsch@pengutronix.de>
Date:   Tue Jun 17 13:27:53 2025 +0200

    drivers: imx: tzc380: add support to verify region0
   =20
    There are platforms where memory aliasing can't be prevented, e.g. the
    i.MX8M. If the previous running firmware configured region0, which
    covers the whole AXI address space, to be accessible from secure and
    non-secure world the OP-TEE core memory would be accessible via memory
    aliasing.
   =20
    To prevent such attacks we need to ensure that region0 is accessible
    from the secure world only.
   =20
    Reviewed-by: Sahil Malhotra <sahil.malhotra@nxp.com>
    Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

Upstream A-TF also used to misconfigure region0, this got fixed by:
https://github.com/ARM-software/arm-trusted-firmware/commit/9bf148071aad597=
e7fe7d1080c00aeb35b67a3dd

So, why is U-Boot working *against* upstream?
Instead of using the sledgehammer and enable normal world access to the who=
le
region0, apply a more precise fix to make these USB masters work.
I know, with downstream IMX OP-TEE it's less of a problem, because you carr=
y this change:

commit c09d6e9da171f8c5ee42b42ff144b320761a5f16
Author: Sahil Malhotra <sahil.malhotra@nxp.com>
Date:   Mon Aug 4 20:08:59 2025 +0200

    LFOPTEE-468 core: plat-imx: tzc380: update TZASC configuration
   =20
    In order to prevent Memory aliasing, need to ensure that region0
    is accessible from secure world only.
   =20
    Signed-off-by: Sahil Malhotra <sahil.malhotra@nxp.com>

Thanks,
//richard
=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT UID/VAT Nr:
ATU 66964118 | FN: 374287y


