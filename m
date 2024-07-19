Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55515C3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 14:14:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDDD588B79;
	Fri, 19 Jul 2024 16:14:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dryfxPno";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CFE788B79; Fri, 19 Jul 2024 16:14:06 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A338A87F51
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 16:14:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2ee98a224b8so4185821fa.2
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 07:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721398444; x=1722003244; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oMQUqxwkgZpDFmKqArteyQgnRS5MQIA4I1MecVtqgkw=;
 b=dryfxPnoUJqm7XjbQHGXfIZwFI6dYBjgmZo8DwrQ3RT6SvdEuFOHJN4khZmDX+P2pc
 MmEuxU1A9IMoIFuBt1m+IjkP4hW0VaTV8NtUBnUjR+rxDUEeMr/urQ7M4YHZSxC7VPhA
 RVRz5YkOTdqu1wJjRbGl0aU6DG54njILRkfd00TfejpAMVlZnh9SOf5B8wEdYHn8OdiU
 JrP8nC/cAnKm7H4bsrX4vLt8x12rBLG9FYcwnkinMHdhejgVSSqw8iLhocgRiijn9457
 CEPFAUz2CvhEcmtPRgLaSCXHf0pdNXOOGCsG8d9kl7TLiGkwJo2CHDf0yF5GfG/5ECti
 n83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721398444; x=1722003244;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oMQUqxwkgZpDFmKqArteyQgnRS5MQIA4I1MecVtqgkw=;
 b=tGauGKbGoFM3tlaXrH0Gtk2daaacI0uEZVMfPklxKyHqdkSomln22EvHB/tfBaVgeP
 0uHVej2YnpzPX5LbruwzgIrWjea8yhEUBaeQz39KvjD2kheTMTdnISyuxEWU0yQpRIJG
 wHxhNk+bICxrsdoh+HBVfGp5Cebtl1GgJqDHioPYDkPgF80iOaDUmE6pU1ugQqCrXwfB
 NxwDKF55DulXzN+eNWyfVamCPNo+e5Mkjy/b+S7eCshjKG5sePrRn5e1gxhssoOUnSNg
 wIGQ6TErokmNCZ4OYDJxpXHZ7+HukyWIPD1XB23ZJPO5pymn8GI6So0LXRyTrk2MJP1T
 fTwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVi60YY/N4F8N0sJlVnguaKnonogklZmxx1lD1MvD0jtjsNdNAh8SG9qSR5GTjsh3U/2cTcLJKa9uCq6jo4BejP0viRDw==
X-Gm-Message-State: AOJu0YxaHvZKCNIQjCEMFp2hy+ALZdm/Bo6FDe0eGAoeXrQXL84jL0Gu
 o74hkLhZYWKGBTW8WJKpF1SET3M9OaSHhYyKUmy3bZXzoP/SzYgxt6oQX9JGMd4g9DIiCBmHshX
 lH52bHhTpOMvFhs4e05LpwUJtFJc=
X-Google-Smtp-Source: AGHT+IGKvNk/cRRiS/aBKDJwS524qygOshO8Xho7CwcdDme/mVPbGUxDx8qnaNQQQKB/pe4CZMOPiUTWd6cguIV6LpI=
X-Received: by 2002:a2e:a583:0:b0:2ee:d55c:602 with SMTP id
 38308e7fff4ca-2ef0da3f476mr11569031fa.6.1721398443606; Fri, 19 Jul 2024
 07:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240718165454.904763-1-festevam@gmail.com>
 <abf7f940-1bfb-4e5f-937b-135a580034b3@armadeus.com>
In-Reply-To: <abf7f940-1bfb-4e5f-937b-135a580034b3@armadeus.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 19 Jul 2024 11:13:51 -0300
Message-ID: <CAOMZO5D4FFvK=L+GwdfpLAyGBV2d2t-9d3GGTAuXYU0jt3kfjg@mail.gmail.com>
Subject: Re: [PATCH] imx93-u-boot: Describe the CPU clocks in the devicetree
To: =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>
Cc: peng.fan@nxp.com, uboot-imx@nxp.com, m.othacehe@gmail.com, 
 u-boot@lists.denx.de
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

Hi S=C3=A9bastien,

On Fri, Jul 19, 2024 at 11:00=E2=80=AFAM S=C3=A9bastien Szymanski
<sebastien.szymanski@armadeus.com> wrote:

> > +&A55_0 {
> > +     clocks =3D <&clk IMX93_CLK_ARM_PLL>;
>
> Why IMX93_CLK_ARM_PLL and not IMX93_CLK_A55_SEL ?

IMX93_CLK_A55_SEL is a mux that can select between a55_alt versus arm_pll.

The real CPU clock is IMX93_CLK_ARM_PLL, so this one better represents it.

This is also consistent with the other i.MX8M SoCs.

Take imx8mm.dtsi for example:

A53_0: cpu@0 {
....
     clocks =3D <&clk IMX8MM_CLK_ARM>;

This also uses the "real" CPU clock, not the mux one (imx8mm_a53_sels).

I also plan to upstream this clock change to the Linux devicetree.

Thanks
