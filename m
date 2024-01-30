Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0639DC46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 12:37:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A7C487C38;
	Tue, 30 Jan 2024 13:37:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DMtKwKWX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC12A86FCE; Tue, 30 Jan 2024 13:36:58 +0100 (CET)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA3F987C38
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 13:36:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6de3b440472so195264b3a.1
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 04:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706618213; x=1707223013; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=btGxMdcCDacmbC1vMqNKNKTn+Q9awp/z4y4jsRybwLE=;
 b=DMtKwKWXWhr++aeFp8h5BaHDkj0+WGjbuJby0wAHBD1lpixcUGDjz749uiAqEfp8ta
 OC+MFvNiuFZ3K0+4TRscPVs6M2t78ZCdDZw7FfeOHYNVvCOuMs6DtRjLOIBhG4x9YKKA
 NWLAe448e3m9zNOYvm31XcmJUn6lQL6tMQQgPtbLHkMzYrTS3Jw1BV6M2CsxZjJRRBmR
 /pOlDkylSpn1CCQxCDrOBI5GQWLdJWFC1srKZu4GmrqfB9xv0fIPKfTh++iTWuSt2YaI
 gs9fVSqII/n/T4cK8S6xbyT+2BnKoFckdQov7pf7hQe6i+N8w91czkaWp293y54NoVix
 gkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706618213; x=1707223013;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=btGxMdcCDacmbC1vMqNKNKTn+Q9awp/z4y4jsRybwLE=;
 b=MeX7bzh+rUlpQyBAJV+eUtjIx/ARzZ3otgml8WcJfxxe4zG1sXKVHbO1Ei8v5xwu/C
 /y8fRL0PrplSfT30o4DuKRrww3CYh1ryr860luOeAHqXrBRXFtTC9rJJQ3BDjYIoL0Y/
 My3olxP3T7FMEj4fYhHSv+UuQJaYxNXKHEl1UBCHDQ8Be2vdkgqdSHZ4HyigODAfHd+r
 kMWcweCuhp2RckEywiKWrs3uYWQ6svcbenDE+KGhIfTMqXwoHh9kiE0R3sM4YghfEHtq
 AdkyZ8gELLjIocDgk5y0cM4X7Fc94n7/5NUMmXYHoEr5ccDVufnUAJYMIP/+N1G9CBwA
 Yuxw==
X-Gm-Message-State: AOJu0YzhJLMclAHz2exq3c/35D2FDx6veZy5b1lQ83vUqDOYv2LznjwV
 1dhJZJ2vViE5db5cKOpnGT6a4pakz32Y0K+g8a7xJYcTERUssDM1wtZhpuPUkmCYiElfF6L3Dsd
 LuVvuKyGcJtFxDr9LJXCcrnoaJnw=
X-Google-Smtp-Source: AGHT+IExkzrhXrJ53+RfCAtxoW33De4nthG6bH7vq8CXTbxptwSq8YajH4gojJ71layhulDDc+nxB6NGRanLzYyWMIE=
X-Received: by 2002:a05:6a21:3384:b0:19c:ad33:5244 with SMTP id
 yy4-20020a056a21338400b0019cad335244mr5946217pzb.2.1706618213248; Tue, 30 Jan
 2024 04:36:53 -0800 (PST)
MIME-Version: 1.0
References: <20240129-usb_support-v1-0-8bd2fe84005b@phytec.de>
 <20240129-usb_support-v1-1-8bd2fe84005b@phytec.de>
In-Reply-To: <20240129-usb_support-v1-1-8bd2fe84005b@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 30 Jan 2024 09:36:42 -0300
Message-ID: <CAOMZO5ALc6qkaT8FoB6J2EHKWkCTNLzuzTYk8HNsVufV0Pv7Yg@mail.gmail.com>
Subject: Re: [PATCH 1/3] phycore-imx8mp: add USB host support
To: Benjamin Hahn <B.Hahn@phytec.de>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Teresa Remmet <t.remmet@phytec.de>, Tom Rini <trini@konsulko.com>,
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

Hi Benjamin,

On Mon, Jan 29, 2024 at 4:56=E2=80=AFAM Benjamin Hahn <B.Hahn@phytec.de> wr=
ote:

> diff --git a/arch/arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi b/arch/a=
rm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi
> index 1c7b250549..5d6974f8fa 100644
> --- a/arch/arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi
> @@ -70,6 +70,19 @@
>         bootph-pre-ram;
>  };
>
> +&usb3_1 {
> +       status =3D "okay";
> +       dr_mode =3D "host";
> +};
> +
> +&usb_dwc3_1 {
> +       status =3D "okay";
> +};
> +
> +&usb3_phy1 {
> +       status =3D "okay";
> +};

Why are these USB nodes being added to -u-boot.dtsi?

These nodes are already present in  the kernel dts:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arc=
h/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts?h=3Dv6.8-rc2#n169

Please add a patch to the series that syncs
imx8mp-phyboard-pollux-rdk.dts with the upstream version, then you
don't need to touch u-boot.dtsi.
