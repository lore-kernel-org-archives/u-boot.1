Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E89D0C602
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 11:59:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D986889028;
	Fri, 25 Oct 2024 13:59:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="LwM395K/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4333F8901F; Fri, 25 Oct 2024 13:59:06 +0200 (CEST)
Received: from mail-m49200.qiye.163.com (mail-m49200.qiye.163.com
 [45.254.49.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7A9D88FAA
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 13:59:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id ebe5836;
 Fri, 25 Oct 2024 19:58:57 +0800 (GMT+08:00)
Message-ID: <ee8fe335-9b3c-45c5-a980-d2ebb3c0faba@rock-chips.com>
Date: Fri, 25 Oct 2024 19:58:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/18] arm64: dts: rockchip: add board-aliases for
 Qnap-TS433
To: Heiko Stuebner <heiko@sntech.de>, u-boot@lists.denx.de,
 philipp.tomsich@vrull.eu, sjg@chromium.org
Cc: ukleinek@debian.org
References: <20241013192424.84280-1-heiko@sntech.de>
 <20241013192424.84280-8-heiko@sntech.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241013192424.84280-8-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUgfHlYaSh4aQkpMQ0sdSUhWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a92c38b476809d6kunmebe5836
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pj46Pyo6LzIvORcDOVEUNiE6
 IwMKFAJVSlVKTElCQ05MTkhDQk5DVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKTEtKNwY+
DKIM-Signature: a=rsa-sha256;
 b=LwM395K/PrCHItIN4dDJg85daIJ3H8eCcIzPZRihMfwXhqWn2Cdl5w8eIDGo2dTBSIqP5aNjaS30ghfBSPWfagU6K1hFC7tSPHYigHYNhXPmiuA+I50q5EfufiJEZUbS9dNrlAcdGtrUSHPsmLNU8AuGYqFHejB/+eK8HMzqlUU=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=I6zadCnMpYg1Al4ZS9eWotinZxrUMVQBIQfdG806VWI=;
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


On 2024/10/14 03:24, Heiko Stuebner wrote:
> Add the aliases for the internal network interface as well as the emmc
> on the board and make sure the dedicated RTC is always the first one.
>
> The TS433 actually has two rtc devices. One coming from the rk809 pmic
> without added functionality and also a dedicated RTC from Mycrocrystal
> that is battery backed to keep the time.
>
> Tested-by: Uwe Kleine-König <ukleinek@debian.org>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Link: https://lore.kernel.org/r/20240723195538.1133436-8-heiko@sntech.de
>
> [ upstream commit: dadd4256e12360d3ff1f6481b2e4697f9d890caf ]
>
> (cherry picked from commit cb53815764403f7f17967a32eec2aeb6625b396f)
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
> index 40af4dd0e41..8be36250aa1 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
> +++ b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
> @@ -13,6 +13,12 @@
>   	model = "Qnap TS-433-4G NAS System 4-Bay";
>   	compatible = "qnap,ts433", "rockchip,rk3568";
>   
> +	aliases {
> +		ethernet0 = &gmac0;
> +		mmc0 = &sdhci;
> +		rtc0 = &rtc_rv8263;
> +	};
> +
>   	chosen {
>   		stdout-path = "serial2:115200n8";
>   	};
> @@ -120,7 +126,7 @@
>   &i2c1 {
>   	status = "okay";
>   
> -	rtc@51 {
> +	rtc_rv8263: rtc@51 {
>   		compatible = "microcrystal,rv8263";
>   		reg = <0x51>;
>   		wakeup-source;
