Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C90C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 11:54:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8C3A887E4;
	Mon, 15 Jul 2024 13:54:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="uyaBEPwP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F51188765; Mon, 15 Jul 2024 13:54:19 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB1D1887E4
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 13:54:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e035dc23a21so4163932276.0
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 04:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1721044455; x=1721649255;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SLz9IB67PomVjl0qtNxXj+FZd8MahnFGCv2CgDU0nKM=;
 b=uyaBEPwPQsCOYKQHJdlQVj9u0GIp3qLXVCQ4HXnOXHLfem3Y7BWvN4SBEVWJWvwkzp
 LRWkcw1Mf+mEIJjw0NImxCDucs82dl/kuPWy076DjdOwAL5/eBaiWmtFPGuY9ZprT9FU
 /HXWUV9mbqD5BH3FgoM4jpsS4945VeGy5M4m739WN/06jeNkatUOjg/kYwK1aa/IjquR
 /w0j+lFx4EWwDLZ6czZIavKqZfLaHRpxt6ryJlrKh3fWyeYeKDh6RkrAi1IrWJqoGZ1b
 0zv6wS9WRC9rASQGApoL/KknNYpZCSg1wPAJejO1Eb6OnmGhMywvqD4RzvcsXCoNQdFs
 7k+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721044455; x=1721649255;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SLz9IB67PomVjl0qtNxXj+FZd8MahnFGCv2CgDU0nKM=;
 b=so5BAdeQ2UeHU9ypH4A7JF3qVWEM6MLpB52usi1TAlavZd3oUt27QwLGgombuTtzTe
 fT4c7vw00dzcCDLpU+Ybn+n8JM5WuYSL2cWSPc7k358tXW6CRYyO2ealvE5Ci1x1jiDf
 FyfmfGZ5MxGfBOm89q7xWM40reZ2Gz/uyTthT+RvAkQBXBK6RTH+w3XL9ghZ2P0+B+Aj
 fYrxWqE/1Us8mbGgaS1NfydGtkBGUwETQg3WvAxefdww478pMDRIXjjsy+ShlxtBrlZj
 Epo1UBWCJVEQRyYeyZVUzPlh/XRIZEMEZOHiD04INMRzlHMwfM1cIz3q0+Ll/u6FFsZh
 BVRg==
X-Gm-Message-State: AOJu0YyS24RlhsCCtTLlEqn7bswteZXumkfc7gZSUbq4rGjv9K/6RxJh
 fC17ENCtktBmHkfQby/vtWSseR/vG45s+NNB2YAFDPRdMJqzLNpi3OKAAUYvZIektJW5MQAeFda
 boYtAfl5vE4n42XYzFMlyvwSTAzMMFLg7dvIq
X-Google-Smtp-Source: AGHT+IHS9sXzFv+wz0VuBXm2dqC6iuiXGB02jCKw1uFHga1P/QtZ9PuXPUYVDE7s4wEG3z0pFqPrrys6DHDTfoj/gkQ=
X-Received: by 2002:a05:6902:1026:b0:e02:b623:ba62 with SMTP id
 3f1490d57ef6-e041b15b3bdmr26948085276.58.1721044454196; Mon, 15 Jul 2024
 04:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240605100221.3571-1-venkatesh.abbarapu@amd.com>
In-Reply-To: <20240605100221.3571-1-venkatesh.abbarapu@amd.com>
From: Michal Simek <monstr@monstr.eu>
Date: Mon, 15 Jul 2024 13:54:04 +0200
Message-ID: <CAHTX3d+fpBhnTmqoGQCaC33rKCAcBsDk5JtdNrd-nXfG1kq0wg@mail.gmail.com>
Subject: Re: [PATCH 0/7] Add the USB5744 hub driver as per new DT binding
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Tom Rini <trini@konsulko.com>, 
 =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>, fabrice.gasnier@foss.st.com
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@amd.com
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

Hi Tom, Marek and Fabrice,

st 5. 6. 2024 v 12:02 odes=C3=ADlatel Venkatesh Yadav Abbarapu
<venkatesh.abbarapu@amd.com> napsal:
>
> Add the usb5744/usb2744 hub driver which does the reset gpio toggling
> and the i2c initialization sequence.
>
> Tested the USB5744/USB2744 usb hub for usb0, usb1 with the
> DT nodes on KR260 board.
>
> Venkatesh Yadav Abbarapu (7):
>   usb: onboard-hub: Add reset-gpio support
>   usb: onboard-hub: Fix the return values of regulator APIs
>   usb: onboard-hub: add support for Microchip USB5744
>   usb: onboard-hub: Add i2c initialization for usb5744 hub
>   usb: onboard-hub: Bail out if peer hub is already probed
>   configs: zynqmp_kria: Enable the USB onboard hub
>   arm64: zynqmp: Update the usb5744 hub node as per binding
>
>  arch/arm/dts/zynqmp-sck-kr-g-revA.dtso |  48 +++++++
>  arch/arm/dts/zynqmp-sck-kr-g-revB.dtso |  48 +++++++
>  arch/arm/dts/zynqmp-sck-kv-g-revA.dtso |  18 +++
>  arch/arm/dts/zynqmp-sck-kv-g-revB.dtso |  25 +++-
>  common/usb_onboard_hub.c               | 176 +++++++++++++++++++++++--
>  configs/xilinx_zynqmp_kria_defconfig   |   1 +
>  6 files changed, 304 insertions(+), 12 deletions(-)
>
> --
> 2.17.1
>

Can someone please take a look at this patchset?

I am fine with 6/7 and 7/7.
Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal


--
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
