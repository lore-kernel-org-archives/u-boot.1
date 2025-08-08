Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 167C2C87FD3
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 11:16:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70292846CC;
	Fri,  8 Aug 2025 13:16:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Cabii73u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08251846CC; Fri,  8 Aug 2025 13:16:48 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19AAB846AC
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 13:16:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel.schwierzeck@gmail.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-af93150f7c2so310854766b.3
 for <u-boot@lists.denx.de>; Fri, 08 Aug 2025 04:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754651805; x=1755256605; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZAHHedukFL/xXBlu9QI2wnD8fcbjC9AWetpcm6ftEfc=;
 b=Cabii73ud5p+pnUnWF8hJ9kS04vPk68mt5LwNnzCbItv49fzScfSb5ChTb8M483uoZ
 smL0p674u06WIfco+8JK3oG+Ac8/1OHGcPO4tPa2kLJhRiDPURFn3DE93H8VDz0c4TPE
 nyZhf3vXswlOqvmHDzf9VIPWC4tT11nw2U1hoSi2adDD+q1yc4INz7iUuWuvv+OwcrnK
 dr3qIt9YTvRia0b8DB6cwLdFBgco4VV5nu61OWcb1dV+/0pZ+sVGmzVo8dLrGvEHwAYj
 fIKGYgabXAd9rOvoDLeHEhmwt/oMaSNpQAAIlLLRZ/AD6QN6kYiY9Ju6T2rehsH4BFoN
 9AXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754651805; x=1755256605;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZAHHedukFL/xXBlu9QI2wnD8fcbjC9AWetpcm6ftEfc=;
 b=LMcmFdWdnxdNLZJc7BnxIOK5GhnOuL/4S3aagB6jYSF2UIhSChMzPIFfuVGt/Osn/D
 Klw6ieh2pSwhB/dKkVUnRDPx32TLUVWbdA+qq19Q18G7IJHlej8XqgB/1sqWqXtX0NLH
 qmKnsHOtQbC51YAYzZtODTNXa8pTvlC2sl2RBx+ykUNgvAPChfhFo5kSACiisQ8KAwiq
 1Lb/p/wRc0u9J0sJjxAkFkjKk0ifSzS2aNDsfl1+ydEdr54g5ii5zy3mLnatjyPhXHmf
 jcdVrnOL7RRCxeLDdhCPWz+RUdJeoJNOM+QlrIPUCPdD4VmGfNp7MyQ99aBLmxuN0/6M
 VmkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+UZo3FiOgwlIPGk5pTNy5h/f1znujnDDpG82xpKIjNKl6FNjLyDnP511/5Iu0bC8C01GxQg0=@lists.denx.de
X-Gm-Message-State: AOJu0YxEeQ/3bvTRkrfDBtps8j/nU+sLbDX83KNqkhLQJYzCeY+2yZGN
 /xeIoVAo/wrlxY2DZ81+R0NLdKnS3vjM0eNN2AEtfju4rg4av4f31DVjXy0ZwXl8
X-Gm-Gg: ASbGncusEUx5TaFHLci6buqpdj6ckgUSChG0cvquvcSsGBNG2kH88kKIlt+E9Ab/eto
 ZeZLoKU66yM2JKUs3nAYTXf9SlWSfehRbxuhkL3oxtvhhvFmX66etxIKDf0VCFh6ooOQgmo+ckr
 XN8BIgCZ5sAzx/4nD6ONCA1ZnhpDZsDTaXIxaemECg83qycmw6K26QrS+M4IVFraZvDbt2Z4Vlb
 L4GL+II/i/96+eC0qbiKhNClhZWiov95ix/WZhrVF8TxXt+P9EqdhFL9i7OZXUIYx4n9wekiopF
 j+F0YXdrT3plPu2CJHGMyklLQimEPMVuMLqFknkWp/bl44enj+RUiB2rEYoxScPh5Fw1xxE++FK
 2EtEGAoCpRkT5xkMWgQ3H4y/v1k52TYBuQU4Z6j/FyB3k/cXllZ3keavzmnqB7JKWY7+n31EZKM
 pyB3RSPZJqRQ==
X-Google-Smtp-Source: AGHT+IFnaUkyCvbMU3PIgIHhV0FGMab3GY9VN9aziI2joEoLFy17mu/8GdtDwGqrHT84liI5VtF93Q==
X-Received: by 2002:a17:907:1c22:b0:af9:71c2:9f7 with SMTP id
 a640c23a62f3a-af9c63b0ca7mr192657166b.2.1754651805298; 
 Fri, 08 Aug 2025 04:16:45 -0700 (PDT)
Received: from ?IPV6:2001:9e8:9c:3e10:4efa:fd63:dc77:6cc6?
 ([2001:9e8:9c:3e10:4efa:fd63:dc77:6cc6])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af91b36e91dsm1437031066b.69.2025.08.08.04.16.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Aug 2025 04:16:44 -0700 (PDT)
Message-ID: <a41fe76a-8b61-4587-a5cc-479e0e78cdc9@gmail.com>
Date: Fri, 8 Aug 2025 13:16:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/4] mips: mt7628: Add Onion Omega2/2+ board support
To: Philip Oberfichtner <pro@denx.de>, u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Weijie Gao <weijie.gao@mediatek.com>
References: <20250807075653.356088-1-pro@denx.de>
 <20250807075653.356088-5-pro@denx.de>
From: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Content-Language: en-US
In-Reply-To: <20250807075653.356088-5-pro@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 8/7/25 09:56, Philip Oberfichtner wrote:
> The Omega2 / Omega2+ are based on the MediaTek MT7688 SoC with the
> following features:
>      - 64 / 128MB of DDR2 memory
>      - 16 / 32MB of SPI NOR flash
>      - USB, WiFi and many more peripherals
> 
> Signed-off-by: Philip Oberfichtner <pro@denx.de>
> ---
> 
> Notes:
>      Changes in v6:
>      	As Daniel pointed out in his review, vendor specific
>      	configurations should be kept in the downstream sources. All of
>      	this non-generic code has been removed in v6. Most notably, that
>      	is:
>      		- custom environment and bootcommand
>      		- network settings
>      		- mtd partitioning
>      
>      	Apart from that, there are a few more simplifications, like the
>      	removal of gpio_init() and superfluous spi drivers.
>      
>      Changes in v5: none
>      
>      Changes in v4:
>      	- Adapt bootcmd
>      	- Rebase defconfig
>      
>      Changes in v3:
>      	- Adapt defconfig to [PATCH 1/2] (SPL_SIZE_LIMIT)
>      
>      Changes in v2:
>      	- Fix style issues as reported by checkpatch
>      	- Add MAINTAINERS file
> 
>   arch/mips/dts/Makefile               |  1 +
>   arch/mips/dts/onion-omega2p.dts      | 58 ++++++++++++++++++++++
>   arch/mips/mach-mtmips/mt7628/Kconfig |  7 +++
>   board/onion/omega2p/Kconfig          | 12 +++++
>   board/onion/omega2p/MAINTAINERS      |  6 +++
>   configs/onion-omega2p_defconfig      | 73 ++++++++++++++++++++++++++++
>   include/configs/onion-omega2p.h      | 15 ++++++
>   7 files changed, 172 insertions(+)
>   create mode 100644 arch/mips/dts/onion-omega2p.dts
>   create mode 100644 board/onion/omega2p/Kconfig
>   create mode 100644 board/onion/omega2p/MAINTAINERS
>   create mode 100644 configs/onion-omega2p_defconfig
>   create mode 100644 include/configs/onion-omega2p.h
> 

Reviewed-by: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>

-- 
- Daniel

