Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF3AC54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 14:30:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC66A82F28;
	Mon, 26 May 2025 16:30:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k4qSjvHY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E13D82EDA; Mon, 26 May 2025 16:30:31 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9C5F82F54
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 16:30:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-54e7967cf67so2827942e87.0
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 07:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748269828; x=1748874628; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h7QpoCBu4fgtOCvygmqb0nSHaj+hOzW4YCMsnBcy44s=;
 b=k4qSjvHYJpZo+ZoMe+P5puxugd6cMvzE/VEu2Mx6XB2cbLPz2ektXPx+py1yJHDWNf
 Si4INZrjcCniadPtU5TBSxEx2pBJUNR81sc2HLmySA2w5/V7xCv3EnXYEVckd6v9tUW2
 OUQ78VPQGJb2FAUPc5RuUa0R7DTIBtZWJPmRdwewZ1/jOU41Hv8QE7iynfSUIbcSui6z
 eCZyug5gMnEyKPQuSKoCnZHnfINCIlRO4u9VW11P7iy6e1PhqeBS9IYxt2k76vU82jsP
 vb5XYbCKmYAm5Dh6y5g/7edeaLSipjyODc+uMtxPytBZ+/7iMOQ03ROrurJlzwjijwqj
 slqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748269828; x=1748874628;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h7QpoCBu4fgtOCvygmqb0nSHaj+hOzW4YCMsnBcy44s=;
 b=Q/Kny+6dJ5tFMOkBQkc2nnjc3d8X3vrY0gvLS8MT1S1wZkaaq28LUs8wORpAx1Wvsz
 gb1vU6Ka2Pg4MSNRmxto6DfOplNs1dk7bYA8F1OUR+z1oLN1VZD9OhTasxQaxYYbAv9a
 rD3IVSId9Krwfe1OM2XTEN6YaiZfDL8jU3URmPv/eyfTbTeknPKqrSY3rftXXjOFQ2Qd
 zzjV2CNozBbmmwKLzQAFljd5JXyiT7lvvWG96mRQcuf4WWluxL7OQ+/0cugHj6WLXl/a
 IPDDDBXUNSXmWh2IKaDJzAL/umn0gxHKF2ZaP0ycWDSezhjjPSU4oKAcunfIpqxx0wVi
 f1XA==
X-Gm-Message-State: AOJu0Yzc3jTgJsvIp5pDXBKz6u6vbhKQLYNaYt55pusjKyZH7R4US+AS
 0J7iS/Hxtmldb+nsYJoV6iZbq1e1DxMSh4JYKhiVULAE3pqFePS9iFg3S7hmP1yp91buD7OYHqs
 RRmXNlheVnPlXyACvwrXUO2bAa6/PmUk=
X-Gm-Gg: ASbGncs4s4xs/vfVclDaqu5jcWU3qTbtn/AnOfqkpX4d9WJV6kn6I8wXQE3gItads1w
 S4h2+jXlN9kUsXfKPPb297kZujjZfY/PL926sK4++DbXa42eo3h+5GwV2rqUGb+nZJvVNAymGrx
 ZoCwcDh+k5nMp9jMRvqJfjrdOn92jT8Ztps3w5mPSp812yQxnQ3gh8l0P+48NCp/gZYppRAD17i
 9E=
X-Google-Smtp-Source: AGHT+IF0eE02gtmCAu3Tt6kI48DRYY+pTV5mnavtlG9C64/T9FwossT8RSodVSlk3PjL95gb+EHCsgZCotAOIhzpyoU=
X-Received: by 2002:a05:6512:3191:b0:545:b28:2fa2 with SMTP id
 2adb3069b0e04-5521c7a83demr2748535e87.7.1748269827924; Mon, 26 May 2025
 07:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250525122316.661999-1-michael@amarulasolutions.com>
 <20250525122316.661999-4-michael@amarulasolutions.com>
In-Reply-To: <20250525122316.661999-4-michael@amarulasolutions.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 26 May 2025 11:30:16 -0300
X-Gm-Features: AX0GCFudntbWTQERBAre8-Sza3mmzdmIYM8QQ0UCFvuQcnR8vV_W-YQ6xaYfGhI
Message-ID: <CAOMZO5Dn7JRfvcxjB9Nxg2K0myxwJ=a+=OWm_pB1oWdV4+pmJg@mail.gmail.com>
Subject: Re: [PATCH 4/4] configs/imx6ulz_smm_m2_defconfig: Enable clock
 framework
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, Marek Vasut <marex@denx.de>, 
 Patrick Barsanti <patrick.barsanti@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
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

On Sun, May 25, 2025 at 9:24=E2=80=AFAM Michael Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Allow to use clock framework for the m2 platform. This allow
> to have better performance to nand controller

Enable the clock framework on the m2 platform.

This helps to increase the NAND controller performance.

> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
>
>  configs/imx6ulz_smm_m2_defconfig | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/configs/imx6ulz_smm_m2_defconfig b/configs/imx6ulz_smm_m2_de=
fconfig
> index 436bfb78cc2..5f0ec452467 100644
> --- a/configs/imx6ulz_smm_m2_defconfig
> +++ b/configs/imx6ulz_smm_m2_defconfig
> @@ -43,6 +43,8 @@ CONFIG_ENV_IS_IN_NAND=3Dy
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
>  CONFIG_NO_NET=3Dy
>  CONFIG_BOUNCE_BUFFER=3Dy
> +CONFIG_CLK_COMPOSITE_CCF=3Dy
> +CONFIG_CLK_IMX6UL=3Dy
>  CONFIG_USB_FUNCTION_FASTBOOT=3Dy
>  CONFIG_FASTBOOT_BUF_ADDR=3D0x82000000
>  CONFIG_FASTBOOT_FLASH=3Dy
> @@ -50,6 +52,7 @@ CONFIG_FASTBOOT_UUU_SUPPORT=3Dy
>  CONFIG_SYS_I2C_MXC=3Dy
>  # CONFIG_MMC is not set
>  CONFIG_MTD=3Dy
> +CONFIG_DM_MTD=3Dy

This change is not mentioned in the commit log.
