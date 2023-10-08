Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD8E3E95A67
	for <u-boot@archiver.kernel.org>; Sun,  8 Oct 2023 09:10:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BEC186410;
	Sun,  8 Oct 2023 11:10:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="kG9Q9Dcd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E6B3866B2; Sun,  8 Oct 2023 11:10:09 +0200 (CEST)
Received: from mail-m15594.qiye.163.com (mail-m15594.qiye.163.com
 [101.71.155.94])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5F35863D3
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 11:10:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=kG9Q9DcdvZfVbr5q8EWtIh+ySRJZA4hYZRn0ESxvhfBzNajIsrsiO6sxQPXUkI8ivwh29iPd8sASjnGdZ55wsdM8zTCIln4FBpfB7Pj/qDn9Ky5kBa6x/RCSno17asJAIHgzQJW1TSCqSWJV/mOC3sS8a2+ecJh1SngznUO4xaw=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=xmnySFb00nbXx5m90fIX4hue/wk6oRHbO8Qwf1Xwyos=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id E02F0400362;
 Sun,  8 Oct 2023 17:09:22 +0800 (CST)
Message-ID: <3145ccc9-d6d6-ee81-4158-9ac576f1a236@rock-chips.com>
Date: Sun, 8 Oct 2023 17:09:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] board: rockchip: add FriendlyElec NanoPC-T6 rk3588 board
Content-Language: en-US
To: John Clark <inindev@gmail.com>
Cc: Eugen Hristev <eugen.hristev@collabora.com>, Jagan Teki
 <jagan@edgeble.ai>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 chenfen <chenfen@rock-chips.com>, =?UTF-8?B?6LW15Luq5bOw?=
 <zyf@rock-chips.com>
References: <20231007212552.11109-1-inindev@gmail.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20231007212552.11109-1-inindev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhodH1YfSUwdGUJPTUIdSBpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8b0e8c621c2eb3kusne02f0400362
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mkk6ITo5Pjw6Kh4tSDwCNwgo
 EEIKCyFVSlVKTUJNTE5NSk1ITk9MVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJT0NNNwY+
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


On 2023/10/8 05:25, John Clark wrote:
> NanoPC-T6 is a Rockchip RK3588 based SBC by FriendlyElec.
>
> There are four variants depending on the DRAM size: 4G/32GB eMMC, 8G/64GB eMMC,
> 16G/16MB SPI NOR, and 16G/256GB eMMC/16MB SPI NOR

So the board is using SPI NOR flash.


[...]

> diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
> index b1f535fad5..e08ebfa39b 100644
> --- a/arch/arm/mach-rockchip/rk3588/rk3588.c
> +++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
> @@ -40,6 +40,7 @@ DECLARE_GLOBAL_DATA_PTR;
>   const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>   	[BROM_BOOTSOURCE_EMMC] = "/mmc@fe2e0000",
>   	[BROM_BOOTSOURCE_SPINOR] = "/spi@fe2b0000/flash@0",
> +	[BROM_BOOTSOURCE_SPINAND] = "/spi@fe2b0000/flash@0",

Why need a SPI NAND?

If this is really needed, will be a separate patch to support a new boot 
source from bootrom.


Thanks,
- Kever

