Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5460FC83F17
	for <u-boot@archiver.kernel.org>; Sun, 13 Jul 2025 23:32:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60A5D81E06;
	Mon, 14 Jul 2025 01:32:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Lk+h7KHr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71E0281FEE; Mon, 14 Jul 2025 01:32:29 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41F00805D7
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 01:32:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=afea=Z3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1752449544;
 bh=3ZFoGrlJxb04mAzxl7UBU2nz7VQ7VTOncNfAAmyFDG8=;
 b=Lk+h7KHrRntiiKcqHgz7HlX7UoYg426N+gBMVxVFXqUQakQYuucolZg76Q/9NFXa/svcru6Io
 0iZfZvPzS8S0m9AtNgMzsKU4zIWPV07ZSpzjyHR7WVe6O+hQhHwiLull4w/qwkjY1rOqxoQ4rfZ
 KPNTCl/Usopymf86RFF575VUKClN50mId4pj/14zDIPQmR7ZnuNH08O8yVrdxsCCl5aJWKZqI3e
 qDz5Yozia1rJhQSObxybNfHKbueNns8jd3Odh1dQERjbALQj/5Qp77ItQOOicIqlW4vEYb13x8V
 ccl1rm54ACCQaR4unvfocC9rA7a+gYXcjgBhLYRd7ZdA==
X-Forward-Email-ID: 687442001bd28f9311449296
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <e1202cd9-6db7-4c9f-8744-94ffc6f28c9a@kwiboo.se>
Date: Mon, 14 Jul 2025 01:32:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rockchip: px30/rk3326: Implement checkboard() to print
 SoC variant
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Heiko Stuebner <heiko@sntech.de>,
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20250610-px30-identify-variant-v3-1-957d70a8df9e@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250610-px30-identify-variant-v3-1-957d70a8df9e@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 6/10/2025 11:42 AM, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> This implements checkboard() to print the current SoC model used by a
> board, e.g. one of:
> 
> SoC:   PX30
> SoC:   PX30S
> SoC:   PX30K
> SoC:   RK3326
> SoC:   RK3326S
> 
> when U-Boot proper is running.
> 
> The information is read from the OTP and also the DDR_GRF. There's no
> public information as far as I know about the layout and stored
> information on OTP but this was provided by Rockchip themselves through
> their support channel.
> 
> The OTP stores the information of whether the SoC is PX30K or something
> else. To differentiate between PX30/RK3326 and PX30S/RK3326S, one needs
> to read some undocumented bitfield in a DDR_GRF register as done in
> vendor kernel,
> c.f. https://github.com/armbian/linux-rockchip/blob/rk-6.1-rkr5.1/drivers/soc/rockchip/rockchip-cpuinfo.c#L118-L133
> 
> I do not own a PX30S, nor RK3326/RK3326S so cannot test it works
> properly.
> 
> Also add the OTP node to the pre-relocation phase of U-Boot proper so
> that the SoC variant can be printed when DISPLAY_BOARDINFO is enabled.
> This is not required if DISPLAY_BOARDINFO_LATE is enabled because this
> happens after relocation. If both are enabled, then the SoC variant will
> be printed twice in the boot log, e.g.:
> 
> U-Boot 2025.07-rc3-00014-g7cb731574ae6-dirty (May 28 2025 - 13:52:47 +0200)
> 
> Model: Theobroma Systems PX30-uQ7 SoM on Haikou devkit
> SoC:   PX30  <---- due to DISPLAY_BOARDINFO
> DRAM:  2 GiB
> PMIC:  RK809 (on=0x40, off=0x00)
> Core:  293 devices, 27 uclasses, devicetree: separate
> MMC:   mmc@ff370000: 1, mmc@ff390000: 0
> Loading Environment from MMC... Reading from MMC(1)... OK
> 
> In:    serial@ff030000
> Out:   serial@ff030000
> Err:   serial@ff030000
> Model: Theobroma Systems PX30-uQ7 SoM on Haikou devkit
> SoC:   PX30  <----- due to DISPLAY_BOARDINFO_LATE
> Net:   eth0: ethernet@ff360000
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

I have now tested this on my RK3326 ODROID-GO Super:

  U-Boot 2025.07 (Jul 13 2025 - 10:07:16 +0000)

  Model: ODROID-GO Super
  SoC:   RK3326
  DRAM:  1 GiB (total 1022 MiB)

so this is,

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

Regards,
Jonas

> ---
> Tested on a PX30 Ringneck and PX30K Ringneck. Would be nice if anyone
> had a device with a PX30S, RK3326 or RK3326S so we could verify it
> prints what it should :)
> ---
> Changes in v3:
> - added (theoretical, untested) support for RK3326/RK3326S based on
>   feedback from Jonas,
> - Link to v2: https://lore.kernel.org/r/20250606-px30-identify-variant-v2-1-624d34ccc381@cherry.de
> 
> Changes in v2:
> - added (theoretical, untested) support for PX30S based on feedback from
>   Kever,
> - Link to v1: https://lore.kernel.org/r/20250528-px30-identify-variant-v1-1-4ea69c527a0d@cherry.de
> ---
>  arch/arm/dts/px30-u-boot.dtsi      |  4 +++
>  arch/arm/mach-rockchip/px30/px30.c | 61 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 65 insertions(+)

[snip]
