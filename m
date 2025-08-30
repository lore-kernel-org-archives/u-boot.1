Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2201CCA0FFF
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 14:30:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 961EE83542;
	Sat, 30 Aug 2025 16:30:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="VKS932Uj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E47F3836AB; Sat, 30 Aug 2025 16:30:42 +0200 (CEST)
Received: from mail-m1973196.qiye.163.com (mail-m1973196.qiye.163.com
 [220.197.31.96])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B70483043
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 16:30:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [121.204.19.91])
 by smtp.qiye.163.com (Hmail) with ESMTP id 212398501;
 Sat, 30 Aug 2025 22:30:36 +0800 (GMT+08:00)
Message-ID: <86935040-d87a-4cbb-afd7-4d3c5c9c5fee@rock-chips.com>
Date: Sat, 30 Aug 2025 22:30:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ram: rk3328: add ddr4-1600 sdram timing
To: Christian Hewitt <christianshewitt@gmail.com>,
 Loic Devulder <ldevulder@suse.com>, Chen-Yu Tsai <wens@csie.org>,
 Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Da Xue <da@libre.computer>, u-boot@lists.denx.de
References: <20250610190820.1462097-1-christianshewitt@gmail.com>
 <20250610190820.1462097-2-christianshewitt@gmail.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250610190820.1462097-2-christianshewitt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a98fb63277b03afkunm4ad546e1405acf
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaS0xLVkIYS01KTElCGUIdGFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpCVUJKWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=VKS932UjaQcZrrkAJdxGpXq6gcRzQuef7VD4lhUFWTMCbBfr2sCr67FyqnwDAHNlYwZYdHY18bLkxprs4UoHQu9m5PkzRkg+3tDsNTxZy4Rg6d0QMrVePwmQOFsy132GuLM9q0HIA//us1bgr6zLENoME8ZVtVwA3tONOJNUzdw=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=v3/Bg7yBc/vCBqi3J69nKZhALYrTvWgLEEQ3zOTkr+E=;
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


On 2025/6/11 03:08, Christian Hewitt wrote:
> From: Da Xue <da@libre.computer>
>
> Add DDR4 1600MHz SDRAM timing data from LibreComputer u-boot sources
> for the ROC-3328-CC board.
>
> Signed-off-by: Da Xue <da@libre.computer>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3328-sdram-ddr4-1600.dtsi | 226 +++++++++++++++++++++++
>   1 file changed, 226 insertions(+)
>   create mode 100644 arch/arm/dts/rk3328-sdram-ddr4-1600.dtsi
>
> diff --git a/arch/arm/dts/rk3328-sdram-ddr4-1600.dtsi b/arch/arm/dts/rk3328-sdram-ddr4-1600.dtsi
> new file mode 100644
> index 00000000000..9594bb42839
> --- /dev/null
> +++ b/arch/arm/dts/rk3328-sdram-ddr4-1600.dtsi
> @@ -0,0 +1,226 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +// Copyright (c) 2018 Fuzhou Rockchip Electronics Co., Ltd.
> +
> +&dmc {
> +	rockchip,sdram-params = <
> +		0x1
> +		0xA
> +		0x2
> +		0x1
> +		0x0
> +		0x0
> +		0x11
> +		0x0
> +		0x11
> +		0x0
> +		0
> +
> +		0x94496354
> +		0x00000000
> +		0x0000002a
> +		0x000004e2
> +		0x00000015
> +		0x0000034a
> +		0x000000ff
> +
> +		800
> +		0
> +		1
> +		0
> +		0
> +
> +		0x00000000
> +		0x43041010
> +		0x00000064
> +		0x0061008c
> +		0x000000d0
> +		0x000200c5
> +		0x000000d4
> +		0x00500000
> +		0x000000d8
> +		0x00000100
> +		0x000000dc
> +		0x03140401
> +		0x000000e0
> +		0x00000000
> +		0x000000e4
> +		0x00110000
> +		0x000000e8
> +		0x00000420
> +		0x000000ec
> +		0x00000400
> +		0x000000f4
> +		0x000f011f
> +		0x00000100
> +		0x0c0e1b0e
> +		0x00000104
> +		0x00030314
> +		0x00000108
> +		0x0506050b
> +		0x0000010c
> +		0x0040400c
> +		0x00000110
> +		0x06030307
> +		0x00000114
> +		0x04040302
> +		0x00000120
> +		0x06060b06
> +		0x00000124
> +		0x00020308
> +		0x00000180
> +		0x01000040
> +		0x00000184
> +		0x00000000
> +		0x00000190
> +		0x07040003
> +		0x00000198
> +		0x05001100
> +		0x000001a0
> +		0xc0400003
> +		0x00000240
> +		0x0600060c
> +		0x00000244
> +		0x00000201
> +		0x00000250
> +		0x00000f00
> +		0x00000490
> +		0x00000001
> +		0xffffffff
> +		0xffffffff
> +		0xffffffff
> +		0xffffffff
> +		0xffffffff
> +		0xffffffff
> +		0xffffffff
> +		0xffffffff
> +		0xffffffff
> +		0xffffffff
> +		0xffffffff
> +		0xffffffff
> +		0xffffffff
> +		0xffffffff
> +
> +		0x00000004
> +		0x0000000c
> +		0x00000028
> +		0x0000000c
> +		0x0000002c
> +		0x00000000
> +		0x00000030
> +		0x00000009
> +		0xffffffff
> +		0xffffffff
> +
> +		0x77
> +		0x88
> +		0x79
> +		0x79
> +		0x87
> +		0x97
> +		0x87
> +		0x78
> +		0x77
> +		0x78
> +		0x87
> +		0x88
> +		0x87
> +		0x87
> +		0x77
> +
> +		0x78
> +		0x78
> +		0x78
> +		0x78
> +		0x78
> +		0x78
> +		0x78
> +		0x78
> +		0x78
> +		0x69
> +		0x9
> +
> +		0x77
> +		0x78
> +		0x77
> +		0x78
> +		0x77
> +		0x78
> +		0x77
> +		0x78
> +		0x77
> +		0x79
> +		0x9
> +
> +		0x78
> +		0x78
> +		0x78
> +		0x78
> +		0x78
> +		0x78
> +		0x78
> +		0x78
> +		0x78
> +		0x69
> +		0x9
> +
> +		0x77
> +		0x78
> +		0x77
> +		0x77
> +		0x77
> +		0x77
> +		0x77
> +		0x77
> +		0x77
> +		0x79
> +		0x9
> +
> +		0x78
> +		0x78
> +		0x78
> +		0x78
> +		0x78
> +		0x78
> +		0x78
> +		0x78
> +		0x78
> +		0x69
> +		0x9
> +
> +		0x77
> +		0x78
> +		0x77
> +		0x78
> +		0x77
> +		0x78
> +		0x77
> +		0x78
> +		0x77
> +		0x79
> +		0x9
> +
> +		0x78
> +		0x78
> +		0x78
> +		0x78
> +		0x78
> +		0x78
> +		0x78
> +		0x78
> +		0x78
> +		0x69
> +		0x9
> +
> +		0x77
> +		0x78
> +		0x77
> +		0x77
> +		0x77
> +		0x77
> +		0x77
> +		0x77
> +		0x77
> +		0x79
> +		0x9
> +	>;
> +};

-- 
Thanks & Best regards,
   Kever Yang
**************************************************************************************************
杨凯  市场部             Kever Yang      Marketing Department
瑞芯微电子股份有限公司                Rockchip Electronics Co.，Ltd。
地址：福建省福州市铜盘路软件大道89号软件园A区18号楼 (350003)
Addr : No.18 Building，A District，No.89，Fuzhou Software Boulevard，Fuzhou，Fujian，PRC

