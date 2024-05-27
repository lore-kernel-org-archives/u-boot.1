Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6FFAC25B74
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 18:07:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06CD287DD3;
	Mon, 27 May 2024 20:07:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="NcwDpuKu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5473C87E3F; Mon, 27 May 2024 20:07:08 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9CE587DCD
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 20:07:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=921e=M7=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1716833187;
 bh=ZkkvWb919ErG3/AmJJybiv/b6nfjzXB9K1zrTIVlftI=;
 b=NcwDpuKu6s+guHm5zJaTbys9PVEdp6bSA5G1TGd8I6M1D+Z8KM0sFExtWgHZgkC9QpZeobsEJ
 z+7Zst870Vpk9BEVAiftlyEXvDM1AZm5zFA7OVIEcfp00prR7b7Drn5NULhsGicyCCRvwKgg497
 kE74beOdS9z/6Q05tuINchh27GjQZy3h0hi2YUP2oSdSz/EaDREeS5vmGo9MuV+VLX/XpoRJJLF
 hfpOxXRjpnfJ3COeiMa5QWZvCntmZVu/r05YeBtlgMYnaZHi/vt9LgGJaNPWuMEl2HX9izKbwhI
 2RrXFrSfsG2biNOKhQTYKsMp7jAbrXivgtxUHGd7mrew==
Message-ID: <874c1629-5e6c-411c-affc-4a084fe9cb7b@kwiboo.se>
Date: Mon, 27 May 2024 20:06:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] add ArmSoM Sige7 Rk3588 board
To: Jianfeng Liu <liujianfeng1994@gmail.com>
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, Boris Brezillon
 <boris.brezillon@collabora.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Christopher Obbard
 <chris.obbard@collabora.com>, Diederik de Haas <didi.debian@cknow.org>,
 Eugen Hristev <eugen.hristev@collabora.com>, FUKAUMI Naoki
 <naoki@radxa.com>, Heiko Stuebner <heiko@sntech.de>, Jagan Teki
 <jagan@edgeble.ai>, John Clark <inindev@gmail.com>, Joshua Riek
 <jjriek@verizon.net>, Kever Yang <kever.yang@rock-chips.com>, Marek Vasut
 <marex@denx.de>, Massimo Pegorer <massimo.pegorer+oss@gmail.com>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>, Michal Simek
 <michal.simek@amd.com>, Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, Sebastian Reichel
 <sebastian.reichel@collabora.com>, Simon Glass <sjg@chromium.org>, Sumit
 Garg <sumit.garg@linaro.org>, Tianling Shen <cnsztl@gmail.com>, Tom Rini
 <trini@konsulko.com>, Weizhao Ouyang <weizhao.ouyang@arm.com>,
 u-boot@lists.denx.de
References: <20240527170214.283988-1-liujianfeng1994@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240527170214.283988-1-liujianfeng1994@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6654cba16d5775985ce00faf
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

Hi Jianfeng,

On 2024-05-27 19:02, Jianfeng Liu wrote:
> Devicetree of ArmSoM Sige7 is merged to kernel v6.10-rc1 with USBDP and
> GPU nodes. So I use update-dts-subtree.sh to pick related commits of
> rk3588s.dtsi, and then pick the commit of ArmSoM Sige7's devicetree.
> I also did run command:
> ./dts/update-dts-subtree.sh pull v6.10-rc1-dts
> based on my work but there is a merge conflict of file:
> dts/upstream/Bindings/Makefile
> I think this should not be related to my work.

I have only received the cover letter and patch 7/7 but have two quick
notes:

This seem to be missing 2 patches from v6.10-rc1-dts for rk3588s.dtsi:
- f6835a60a8a2 ("arm64: dts: rockchip: reorder usb2phy properties for rk3588")
- ea9a34aa0d78 ("arm64: dts: rockchip: add rk3588 pcie and php IOMMUs")

Probably better to fully sync the rk3588/rk3588s.dtsi-files to the
v6.10-rc1-dts state.

Also please add a commit that removes the usbdpphy-grf, usb2phy-grf,
usbdp-phy, vo-grf and usb-grf related nodes from rk3588-u-boot.dtsi and
rk3588s-u-boot.dtsi. The usb nodes in rk3588 -u-boot.dtsi-files should
be obsolete after this series.

Regards,
Jonas

> 
> Changes in v3:
> - Use update-dts-subtree.sh to pick upstream dts
> 
> Changes in v2:
> - Fix alphabetical order of MAINTAINERS
> - Use arch/arm/dts/rk3588-armsom-sige7* in board MAINTAINERS
> - Remove spi flash related config
> - Move kernel dts to dts/upstream/src/arm64/rockchip/
> 
> Boris Brezillon (1):
>   arm64: dts: rockchip: Add rk3588 GPU node
> 
> Diederik de Haas (1):
>   arm64: dts: rockchip: Fix ordering of nodes on rk3588s
> 
> Jianfeng Liu (2):
>   arm64: dts: rockchip: Add ArmSom Sige7 board
>   board: rockchip: add ArmSoM Sige7 Rk3588 board
> 
> Sebastian Reichel (3):
>   arm64: dts: rockchip: fix usb2phy nodename for rk3588
>   arm64: dts: rockchip: add USBDP phys on rk3588
>   arm64: dts: rockchip: add USB3 DRD controllers on rk3588
> 
>  MAINTAINERS                                   |   1 +
>  arch/arm/dts/rk3588-armsom-sige7-u-boot.dtsi  |  28 +
>  arch/arm/mach-rockchip/rk3588/Kconfig         |  26 +
>  board/armsom/sige7-rk3588/Kconfig             |  12 +
>  board/armsom/sige7-rk3588/MAINTAINERS         |   7 +
>  configs/sige7-rk3588_defconfig                |  93 +++
>  doc/board/rockchip/rockchip.rst               |   1 +
>  .../arm64/rockchip/rk3588-armsom-sige7.dts    | 721 ++++++++++++++++++
>  dts/upstream/src/arm64/rockchip/rk3588.dtsi   |  72 ++
>  dts/upstream/src/arm64/rockchip/rk3588s.dtsi  | 337 +++++---
>  include/configs/sige7-rk3588.h                |  15 +
>  11 files changed, 1215 insertions(+), 98 deletions(-)
>  create mode 100644 arch/arm/dts/rk3588-armsom-sige7-u-boot.dtsi
>  create mode 100644 board/armsom/sige7-rk3588/Kconfig
>  create mode 100644 board/armsom/sige7-rk3588/MAINTAINERS
>  create mode 100644 configs/sige7-rk3588_defconfig
>  create mode 100644 dts/upstream/src/arm64/rockchip/rk3588-armsom-sige7.dts
>  create mode 100644 include/configs/sige7-rk3588.h
> 

