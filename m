Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CBE8C46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 19:31:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFA4C8785A;
	Tue, 30 Jan 2024 20:31:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DWYs1cJu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C579878CB; Tue, 30 Jan 2024 20:31:23 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B4728784B
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 20:31:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2950a3fcf42so986731a91.0
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 11:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706643079; x=1707247879; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1wN5Gyj1e0HZl/puOag7EjRUCI0qBttQK4ComtSyqes=;
 b=DWYs1cJuINWqXCmgtG1Jcj66CoCZjwhf3ij9SgqX4yqBAe5mb5C59rbHDguz2ZJzOh
 qFJfvSf+YooXGBlHFEj2ZXg6gh9DGOt41JTSJzWLTxO7EA9x6s1LeXHec1CSwnvJXW4T
 49gKwqHqE9Vhw/P496I9859uPTRem1h9jup54ij92aJX9efwGHgbnYU2e7/8x/rXmBZu
 XSpg4EywZFUVo2cGt1+tlaZSd8Tr2NiSp+ApnbZ4aSpBXqd7drHp3iqWMLoC640sWE+k
 P6gefXE/2FoTMMIlVqpmfK/U4yKntElWIkK+SnjpLvZgZV5smFcyRWp5h+d3USaCGS82
 ZaMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706643079; x=1707247879;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1wN5Gyj1e0HZl/puOag7EjRUCI0qBttQK4ComtSyqes=;
 b=Rz+hv+jWBVCzAuYSth6w0F75UsJwfyMOjPdS2XywTQq4Xqe9ojMchjoV4yDSyTwDp8
 c2kP+vYGWNn8Y82Put+SK5X3r9nmopb8/xSjFTqh1Lr65uV3vV7BcP7zdJjAPep6x4Za
 NY2ib5rSWb8i0B6QBGrkX6hgKCMf3uNnG0hk98Ea98ESlJKCE8EfFa4OjU53tu5y7fvR
 CZYfa2uK7e9T1hty/8ihUFPmr54s8Ya/USxWupuqTe6sJPWrB48qjkL4Y3Qz0RIKmYmv
 FXO2IY6UsMvz5jdtokpd8rrOl0qjN5gXbHlzzhzr6Mmy0Ks+/XBmTs5w2JBosG2fnTQf
 VFTQ==
X-Forwarded-Encrypted: i=0;
 AJvYcCX95u7SK8CQOywMCaknHFZQU1gf7vHOCFQu31p+DPcJFgYustzF53tW5hqmDE5OdUYpExEHb7ePIzjkXBuKChDLsYy3Lg==
X-Gm-Message-State: AOJu0YwATGZg2XF2y+rehJ/R5CqobeaiLxlaSTETPAAM7DbYzY8yzNyU
 HwFSir6pNc13dCmflEFb/DBzZvznd4uyxRaN0N1Fj/ZubWXz90fBn4MCiREJCt/McfA0KnSHiQ0
 MtiSbYkShHlcJEH9qRftqUMf70g4=
X-Google-Smtp-Source: AGHT+IHKCpPioqrcPETWEBtfrcJT/MlFg7qOEZNvL8LapYGEGVkks+hixsQNq1t36x/CDSyCJEPuHEywhk48W84mACY=
X-Received: by 2002:a17:90a:df11:b0:290:f5f7:caff with SMTP id
 gp17-20020a17090adf1100b00290f5f7caffmr735291pjb.3.1706643079598; Tue, 30 Jan
 2024 11:31:19 -0800 (PST)
MIME-Version: 1.0
References: <20230523192155.33222-1-gilles.talis@gmail.com>
 <58a07085-3926-b942-fb8c-58f1f5eac421@oss.nxp.com> <877clq6odx.fsf@redhat.com>
 <CAKcgs2x1FdvW0afXN=GGRc5nb8rhZtm70xzkURFeworcmTHPpg@mail.gmail.com>
 <87bkavbo6c.fsf@redhat.com> <877cjrss43.fsf@redhat.com>
In-Reply-To: <877cjrss43.fsf@redhat.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 30 Jan 2024 16:31:09 -0300
Message-ID: <CAOMZO5A2W4ZZBdUjNkA9fqB+kBgASM7esfcLL3RvdwmCi9qakw@mail.gmail.com>
Subject: Re: [PATCH v2] imx: imx8mp: Add support for Polyhex Debix Model A SBC
To: Milan Zamazal <mzamazal@redhat.com>
Cc: Gilles Talis <gilles.talis@gmail.com>, Peng Fan <peng.fan@oss.nxp.com>,
 uboot-imx@nxp.com, u-boot@lists.denx.de
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

Hi Milan,

On Tue, Jan 30, 2024 at 9:22=E2=80=AFAM Milan Zamazal <mzamazal@redhat.com>=
 wrote:

> Well, after trying both the SD cards again with fresh reinstallations, it=
 works
> with a 32 GB card and I get the error above with a 64 GB card.  Is it pos=
sible
> that there is something wrong with SDXC cards?

Does the change below help?

--- a/arch/arm/dts/imx8mp-debix-model-a-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-debix-model-a-u-boot.dtsi
@@ -128,6 +128,9 @@
        bootph-pre-ram;
        sd-uhs-sdr104;
        sd-uhs-ddr50;
+       assigned-clocks =3D <&clk IMX8MP_CLK_USDHC2>;
+       assigned-clock-rates =3D <400000000>;
+       assigned-clock-parents =3D <&clk IMX8MP_SYS_PLL1_400M>;
 };

 &usdhc3 {
