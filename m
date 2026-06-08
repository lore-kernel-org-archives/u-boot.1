Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E8BDCD8C9F
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 13:28:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 719CD8484F;
	Mon,  8 Jun 2026 15:28:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="DjLX+Xmd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B4688405A; Mon,  8 Jun 2026 15:28:20 +0200 (CEST)
Received: from mail-m822136196.xmail.ntesmail.com
 (mail-m822136196.xmail.ntesmail.com [8.221.36.196])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D970284843
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 15:28:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [59.56.83.5])
 by smtp.qiye.163.com (Hmail) with ESMTP id 41874f133;
 Mon, 8 Jun 2026 21:28:09 +0800 (GMT+08:00)
Message-ID: <c06ef698-405d-418e-a034-ee455fe80128@rock-chips.com>
Date: Mon, 8 Jun 2026 21:28:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/6] arm64: dts: rockchip: enable UFS controller on
 FriendlyElec NanoPi M5
To: Alexey Charkov <alchark@flipper.net>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heiko Stuebner <heiko@sntech.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Jonas Karlman <jonas@kwiboo.se>, Finley Xiao <finley.xiao@rock-chips.com>,
 Elaine Zhang <zhangqing@rock-chips.com>, Joseph Chen
 <chenjh@rock-chips.com>, Xuhui Lin <xuhui.lin@rock-chips.com>,
 Dhruva Gole <d-gole@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Alexey Charkov <alchark@gmail.com>
References: <20260311-rk3576-ufs-v6-0-c7c353739242@flipper.net>
 <20260311-rk3576-ufs-v6-2-c7c353739242@flipper.net>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20260311-rk3576-ufs-v6-2-c7c353739242@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9ea76b552509cckunm55350bed34d97c
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCGkxLVklMTUsZTk5JGB8fS1YVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlOQlVOTVVDSFVOWVdZFhoPEhUdFFlBWU9LSFVKS0lPT0
 9IVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=DjLX+XmdfRg2h7Ue7Xr0CmkXaGPT7eZ2dxvNuAFJCHwKaWWRudNC+y8gLEhAdumMFRhNZJ7rsPLGRprg0OYVSMbZiz/Ya5sGOgMVtBi2qQhz837Ya1HwzJj0hl12zVXlpqnCZEpdCFxjv9sgTY9FDG5muKfi7oEmp49BtKqITwo=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=DYbox8jemWdzqNVtk6RcYwXief3o0lfz76XSf2fHN9E=;
 h=date:mime-version:subject:message-id:from;
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


On 2026/3/11 21:30, Alexey Charkov wrote:
> From: Alexey Charkov <alchark@gmail.com>
>
> The NanoPi M5 board supports pluggable UFS modules using the UFSHC
> inside its Rockchip RK3576 SoC.
>
> Enable the respective devicetree node and add its supply regulators.
>
> Link: https://wiki.friendlyelec.com/wiki/images/9/97/NanoPi_M5_LP5_2411_SCH.pdf
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> Link: https://patch.msgid.link/20251230-nanopi-m5-ufs-v3-1-ed188ae34fdb@gmail.com
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>
> [ upstream commit: cd50298ffc5f98872ddf0ac05c51a014003a34b7 ]
>
> (cherry picked from commit d9f2b91a7b6cc955e272c31a4bcb03a1c564efad)
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   .../src/arm64/rockchip/rk3576-nanopi-m5.dts        | 24 ++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3576-nanopi-m5.dts b/dts/upstream/src/arm64/rockchip/rk3576-nanopi-m5.dts
> index bb2cc2814b83..5c6e6c7a213a 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3576-nanopi-m5.dts
> +++ b/dts/upstream/src/arm64/rockchip/rk3576-nanopi-m5.dts
> @@ -110,6 +110,22 @@
>   		regulator-name = "vcc12v_dcin";
>   	};
>   
> +	vcc1v2_ufs_vccq: regulator-vcc1v2-ufs-vccq {
> +		compatible = "regulator-fixed";
> +		regulator-min-microvolt = <1200000>;
> +		regulator-max-microvolt = <1200000>;
> +		regulator-name = "vcc1v2_ufs_vccq";
> +		vin-supply = <&vcc5v0_sys_s5>;
> +	};
> +
> +	vcc1v8_ufs_vccq2: regulator-vcc1v8-ufs-vccq2 {
> +		compatible = "regulator-fixed";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-name = "vcc1v8_ufs_vccq2";
> +		vin-supply = <&vcc_1v8_s3>;
> +	};
> +
>   	vcc3v3_m2_keym: regulator-vcc3v3-m2-keym {
>   		compatible = "regulator-fixed";
>   		enable-active-high;
> @@ -910,6 +926,14 @@
>   	status = "okay";
>   };
>   
> +&ufshc {
> +	vcc-supply = <&vcc_3v3_s3>;
> +	vccq-supply = <&vcc1v2_ufs_vccq>;
> +	vccq2-supply = <&vcc1v8_ufs_vccq2>;
> +	vdd-hba-supply = <&vdda_1v2_s0>;
> +	status = "okay";
> +};
> +
>   &usbdp_phy {
>   	status = "okay";
>   };
>
