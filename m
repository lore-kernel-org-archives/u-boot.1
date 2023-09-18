Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63BAAC46CA1
	for <u-boot@archiver.kernel.org>; Mon, 18 Sep 2023 19:00:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FAE786958;
	Mon, 18 Sep 2023 21:00:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="urU8jdpg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C59B8695F; Mon, 18 Sep 2023 20:59:59 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B58D868C0
 for <u-boot@lists.denx.de>; Mon, 18 Sep 2023 20:59:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 7e802c1c-5655-11ee-b85d-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 7e802c1c-5655-11ee-b85d-005056992ed3;
 Mon, 18 Sep 2023 20:59:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=prPtiQ6LYnSYAmDWa+C1/pQgfDEpXmFclgiwFx/EYmo=;
 b=urU8jdpg1ym6dZyiCAecBMA3NXsXFTDogjIYRiyQAGN/zIXlkO8kpQerQ1vcZ8rQ3Lmg+Xtzk0lxo
 9drF/n318gecfpefge60tc1970ZJTCQRMeHeXvgoTCxYJ2avnp8L0s8AyODWyfJJuLGMNsK8eEKowX
 X9IGKI0XDtSwAh5uknWD6Ch1lV5Ef/ed5xC03SRt9oIoC+F1KT/CH1VATxtNS1YIG031J4451ImgGh
 cRzkUV2mYlmdIahmzEI3TYmfw50pfnuZpZAkZZ3EzBnSpdaLM7jQdgss4dOJq6h9CdNqK5M6bTVn8n
 5sqg/l4XbYGvMgDkWeNGEpiMYLCJarw==
X-KPN-MID: 33|7MPof5v7E4rpcDo0LP6PYlzjFsG6IpBAITZ4dFn6FzJDqa9ouyctFDmT0YAEaBo
 Z3D3KPg63QYND6WuKJUsIFLKQY1mLJ0FvTrz8iFI8tHU=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|yLYgSjE6FO8SUGaOpsDkBXynYS6s4Ixr+p9LbyX0L3Tx7aIlmlWWhwLUFHKLgUs
 i56j/AN8bk6VriHq+vW5/ng==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 8e3cb367-5655-11ee-ac77-00505699b758;
 Mon, 18 Sep 2023 20:59:56 +0200 (CEST)
Date: Mon, 18 Sep 2023 20:59:55 +0200
Message-Id: <87v8c7e28k.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: frank-w@public-files.de
Cc: linux@fw-web.de, u-boot@lists.denx.de, sjg@chromium.org,
 philipp.tomsich@vrull.eu, kever.yang@rock-chips.com, jonas@kwiboo.se
In-Reply-To: <32AADEE4-360F-423A-BF6C-C8A934D86EF8@public-files.de> (message
 from Frank Wunderlich on Mon, 18 Sep 2023 20:09:54 +0200)
Subject: Re: [PATCH v4] board: rockchip: Add Bananapi R2Pro Board
References: <20230918173624.31464-1-linux@fw-web.de>
 <87wmwne5cw.fsf@bloch.sibelius.xs4all.nl>
 <32AADEE4-360F-423A-BF6C-C8A934D86EF8@public-files.de>
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

> Date: Mon, 18 Sep 2023 20:09:54 +0200
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Am 18. September 2023 19:52:31 MESZ schrieb Mark Kettenis <mark.kettenis@xs4all.nl>:
> >> From: Frank Wunderlich <linux@fw-web.de>
> >> Date: Mon, 18 Sep 2023 19:36:24 +0200
> 
> Hi Mark,

Hello Frank,

> >> --- /dev/null
> >> +++ b/arch/arm/dts/rk3568-bpi-r2pro-u-boot.dtsi
> >> @@ -0,0 +1,28 @@
> >> +// SPDX-License-Identifier: GPL-2.0+
> >> +/*
> >> + * (C) Copyright 2021 Rockchip Electronics Co., Ltd
> >> + */
> >> +
> >> +#include "rk356x-u-boot.dtsi"
> >> +
> >> +/ {
> >> +	chosen {
> >> +		stdout-path = &uart2;
> >> +	};
> >> +};
> >> +
> >> +&uart2 {
> >> +	clock-frequency = <24000000>;
> >> +	bootph-pre-ram;
> >> +	status = "okay";
> >> +};
> >> +
> >> +&gmac0 {
> >> +	status = "disabled";
> >> +};
> >> +
> >> +/delete-node/ &{/ethernet@fe2a0000/mdio/switch@0};
> >
> >Why are you deleting the switch node?  This way an OS that uses the
> >device tree provided by U-boot will not have a working switch...
> 
> Is there such an OS?

Yes, OpenBSD tends to rely on the device tree provided by U-Boot.  It
is impossible to include device trees for all possible boards on the
installation media.  And if U-Boot provides the device tree for the
board we don't need to (as long as the device tree uses the "official"
bindings).

> Linux uses own dts.

Well, Linux *may* use its own dts.  Some boards never make it in the
official Linux tree.  Or a generic Linux distro may use a kernel that
was released before the board made it to the market.  So generic Linux
distros face the same problem as OpenBSD in that it isn't practical to
include device trees for every possible board on the installation
media.

So the goal is that U-Boot provides a usable device tree for as many
boards as possible.

> The switch will also not work because the gmac0 is deactivated to
> fix the timeout in uboot because phy does not answer.

I missed that.  But that is a bug in U-Boot that should be fixed.
Probably by adding support for "fixed-link" switch ports.  Now I
appreciate that having a U-Boot that partly works is better than no
U-Boot at all.  So that may justify what you did.  However...

> I can leave the switch-node, but i do not want the timeout on network access on gmac0.

...such a timeout could be seen as a reminder that the work isn't
finished yet.

> >> +&mdio0 {
> >> +	#address-cells = <1>;
> >> +	#size-cells = <0>;
> >> +
> >> +	switch@0 {
> >> +		compatible = "mediatek,mt7531";
> >> +		reg = <0>;
> >> +
> >> +		ports {
> >> +			#address-cells = <1>;
> >> +			#size-cells = <0>;
> >> +
> >> +			port@1 {
> >> +				reg = <1>;
> >> +				label = "lan0";
> >> +			};
> >> +
> >> +			port@2 {
> >> +				reg = <2>;
> >> +				label = "lan1";
> >> +			};
> >> +
> >> +			port@3 {
> >> +				reg = <3>;
> >> +				label = "lan2";
> >> +			};
> >> +
> >> +			port@4 {
> >> +				reg = <4>;
> >> +				label = "lan3";
> >> +			};
> >> +
> >> +			port@5 {
> >> +				reg = <5>;
> >> +				label = "cpu";
> >> +				ethernet = <&gmac0>;
> >> +				phy-mode = "rgmii";
> >> +
> >> +				fixed-link {
> >> +					speed = <1000>;
> >> +					full-duplex;
> >> +					pause;
> >> +				};
> >> +			};
> >> +		};
> >> +	};
> >> +};
> 
> 
> regards Frank
> 
