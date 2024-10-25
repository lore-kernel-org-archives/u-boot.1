Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 509FBD0C603
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 12:02:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4064389096;
	Fri, 25 Oct 2024 14:00:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="bhbfLxL3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0E6489079; Fri, 25 Oct 2024 14:00:50 +0200 (CEST)
Received: from mail-m12772.qiye.163.com (mail-m12772.qiye.163.com
 [115.236.127.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D314688FE2
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 14:00:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id ebe58b8;
 Fri, 25 Oct 2024 20:00:34 +0800 (GMT+08:00)
Message-ID: <59666ee5-2730-4447-9a61-43964f8323d0@rock-chips.com>
Date: Fri, 25 Oct 2024 20:00:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/18] arm64: dts: rockchip: add product-data eeproms
 to QNAP TS433
To: Heiko Stuebner <heiko@sntech.de>, u-boot@lists.denx.de,
 philipp.tomsich@vrull.eu, sjg@chromium.org
Cc: ukleinek@debian.org
References: <20241013192424.84280-1-heiko@sntech.de>
 <20241013192424.84280-18-heiko@sntech.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241013192424.84280-18-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkofGFYaQxlNGk1PTx9MTktWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a92c38cbf5109d6kunmebe58b8
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NxQ6LSo4DDIfKRchKVExNgML
 AwNPCglVSlVKTElCQ05MTUhOS0pJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKTE9JNwY+
DKIM-Signature: a=rsa-sha256;
 b=bhbfLxL3pR1n3dfMMnojNm++8BSvgYRKlvj+UApznqXI4IPNSL8LCqrJ133bR+W5IYw0HmdlBirkJLBQLblodx75NEePuAzwddfxxmrtcsQoKfJx8p3s/XjT2tO2ZFeyBcwQeRQ0f+ospcjNZM6tyVuK243m2P8/6MYWORNfaKs=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=ho0EzuBRYwgrTC4XrkOZo6m+Vq7UQwjS2Z/TNrYZKWs=;
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
> The device contains two i2c-connected eeproms holding some product-
> specific values. One sitting on the mainboard and one on the statically
> connected backplane.
>
> While the eeprom chips themself have a size of 512 byte, the eeprom data
> only uses 256 byte each, probably to stay compatible with other models.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Link: https://lore.kernel.org/r/20240810211438.286441-3-heiko@sntech.de
>
> [ upstream commit: da6f4130234448122fe3e66c8116f7d9eea8a5c7 ]
>
> (cherry picked from commit 0b3109708caf5002ba188ae28eae9ce46b2c39b4)
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   .../src/arm64/rockchip/rk3568-qnap-ts433.dts  | 20 +++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
> index 90d8d526629..e601d9271ba 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
> +++ b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
> @@ -454,6 +454,26 @@
>   		reg = <0x51>;
>   		wakeup-source;
>   	};
> +
> +	/* eeprom for vital-product-data on the mainboard */
> +	eeprom@54 {
> +		compatible = "giantec,gt24c04a", "atmel,24c04";
> +		reg = <0x54>;
> +		label = "VPD_MB";
> +		num-addresses = <2>;
> +		pagesize = <16>;
> +		read-only;
> +	};
> +
> +	/* eeprom for vital-product-data on the backplane */
> +	eeprom@56 {
> +		compatible = "giantec,gt24c04a", "atmel,24c04";
> +		reg = <0x56>;
> +		label = "VPD_BP";
> +		num-addresses = <2>;
> +		pagesize = <16>;
> +		read-only;
> +	};
>   };
>   
>   &mdio0 {
