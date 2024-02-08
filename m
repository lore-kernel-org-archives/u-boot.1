Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5038AC48260
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 13:08:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1FEE87D16;
	Thu,  8 Feb 2024 14:08:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h/vRVk2x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86AF88709C; Thu,  8 Feb 2024 14:08:40 +0100 (CET)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5ACDD87D16
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 14:08:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5a0dc313058so406316a12.0
 for <u-boot@lists.denx.de>; Thu, 08 Feb 2024 05:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707397715; x=1708002515; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rncFTezZUKmWhv5DgZj8jkb1JSZTWUQX7f/MS5V09Yw=;
 b=h/vRVk2xBPuFFJHrNsRHMy6tqxh/epX1n3mX7+TmSnZsXEGhdzgbYBeIShuezzq7tZ
 2VDHP34+m8AyJivF5K8VzzC30oisWAzdq1Q0eiTeEZGZGP3jnwV38sQQWtB7vzWxt9GU
 xpFnKmDIVIPy/Q5aosbK7KvicNZzlpxfl+NGUrcEob9Wdq13ElthZ2BKyL8TjIIaTYAp
 Q1ZJG6OmEL/0VMRvnY8LRiArGRbgCCuqtFQSRSlyJV3sSK/bvTIjeYY5Il873RlQ5Dvj
 H9kfL0FqENURqLq6l0HeCzSdWw5TrElQ8kp4PMqkIJ5wy5hdwIhWiNCxj7kovzL2lej/
 /IfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707397715; x=1708002515;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rncFTezZUKmWhv5DgZj8jkb1JSZTWUQX7f/MS5V09Yw=;
 b=V21D/c8RlGfl+gkeFR0ATTnN/8tn5WMidQBTwVcA4YiD4x2tReuNPiePbwm/ScUoEX
 +QVJ4mH6wDGlNuNDlB0P8sk4FlY+gXiVsNcXmdtXDtp5xiFFSh7wAaSuHMBZuO7TRjkl
 0Rkxg8nTjWmTSpDNgFW4XfIUMKhG2s4e44inDzLaOeDf8Kq2mkqUq5eNiA8+OnHx7Eqb
 HtKvnZIBA666/qM4qZLCwnhRtiwLRh6CO0zXMKwcBWAfRuIN9/DSUmawoWJJ0Od+fMaf
 EyKg7LaaX6xgTN22kbOnf5LU90wM/aySMZnDAbO40S5sqRSOBu/KyMFMZWZ0Wnkiw5Mr
 RESg==
X-Gm-Message-State: AOJu0YwCQaPkhrltAveBFM7D51h0V9c0wjVXbeEytfhYDER8FDLqLuDc
 lWp1g7EG17Fl0bbnpF9Y7k4/4xUe5b5gq4NxZ41FqfbA/J0bRTVOxs58wmL3kLxRL6N5xNK39wv
 VupJcmz5Qg8Aw8caYqGBs6z5Dmeo=
X-Google-Smtp-Source: AGHT+IF+jSdGnOcXIbxyy7pz8d2tvvR9GjTkMZfG1ofYC5HLI2DTA9DbedN85Nj/xLImKaVMMy7YYB22PmspAaN/9bA=
X-Received: by 2002:a17:90b:3141:b0:296:df79:c663 with SMTP id
 ip1-20020a17090b314100b00296df79c663mr5129028pjb.3.1707397715511; Thu, 08 Feb
 2024 05:08:35 -0800 (PST)
MIME-Version: 1.0
References: <20240206164008.1620933-1-Mr.Bossman075@gmail.com>
In-Reply-To: <20240206164008.1620933-1-Mr.Bossman075@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 8 Feb 2024 10:08:23 -0300
Message-ID: <CAOMZO5CHMYZ5LFz9xCukrZ_BeF-Knt=Pbe9Qs7wrOnr0-ZSP_A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] imx: imxrt1050-evk: Add support for SPI flash
 booting
To: Jesse Taube <mr.bossman075@gmail.com>
Cc: u-boot@lists.denx.de, 
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Stefano Babic <sbabic@denx.de>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
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

Hi Jesse,

On Tue, Feb 6, 2024 at 1:40=E2=80=AFPM Jesse Taube <mr.bossman075@gmail.com=
> wrote:
>
> Add support for booting the imxrt1050-evk from spi.
> Add imximage config and the ability for SPL to boot from NOR.
>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>

This causes the following build failure when building imxrt1020-evk_defconf=
ig:

arm: + imxrt1020-evk
1221+binman: Device tree 'u-boot.dtb' does not have a 'binman' node
1222+make[1]: *** [Makefile:1125: .binman_stamp] Error 1
1223+make: *** [Makefile:177: sub-make] Error 2
1224w+arch/arm/dts/imxrt1170-evk.dtb: Warning (reg_format):
/memory/ocram@20240000:reg: property has invalid length (8 bytes)
(#address-cells =3D=3D 2, #size-cells =3D=3D 1)
1225w+arch/arm/dts/imxrt1170-evk.dtb: Warning (reg_format):
/memory/sdram@80000000:reg: property has invalid length (8 bytes)
(#address-cells =3D=3D 2, #size-cells =3D=3D 1)
1226w+arch/arm/dts/imxrt1170-evk.dtb: Warning
(avoid_default_addr_size): /memory/ocram@20240000: Relying on default
#address-cells value
1227w+arch/arm/dts/imxrt1170-evk.dtb: Warning
(avoid_default_addr_size): /memory/ocram@20240000: Relying on default
#size-cells value
1228w+arch/arm/dts/imxrt1170-evk.dtb: Warning
(avoid_default_addr_size): /memory/sdram@80000000: Relying on default
#address-cells value
1229w+arch/arm/dts/imxrt1170-evk.dtb: Warning
(avoid_default_addr_size): /memory/sdram@80000000: Relying on default
#size-cells value
1230 arm: w+ topic_miamiplus

Please fix and resend.

Also, there was a whitespace warning when applying this series.

Please make sure to run checkpatch on the patches.
