Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92FB2D3C931
	for <u-boot@archiver.kernel.org>; Sun, 20 Oct 2024 02:25:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4B498910A;
	Sun, 20 Oct 2024 04:25:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729391141;
	bh=mPJTu90+NcXulh41VfigUgD6ONpPpajCefclODUhHWQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j7iSU+73C4xMX8AvidX6Z4DDcSM27DkTU+zoreM/yCQ554i0gfWgRsSdD+xuTxPEG
	 ama5B7yH8OjLrGU2H+D22kew8v9Od9Sao6W3mk8Ya97f9fQ/cazGFbxpNQHMhVfrRT
	 iQHDhBXa71w3/iUMp0Ge0Y6VsgPT/PAABMacHXfPPwpwO4MLjRaLHdvXs7P1TZQXhH
	 2TMgVAtMSFLkVj2zm+hMKx7bMb1ip7Tr7/Kc+LGZRSRSqTZ+d28U5brkiLhtP1J7TE
	 MlkuSsgCFU0SgusaET9KUnDS3hfTalK/j6P+yCiSMYHHjbjzt2WHKKHhfU+x3ZC3yd
	 v23yJRwfZzwuw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id BF03688FE8;
 Sun, 20 Oct 2024 04:25:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729391139;
 bh=mPJTu90+NcXulh41VfigUgD6ONpPpajCefclODUhHWQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=UtkDo00puAE+pjUrdDkEdvqbJDncPRUwli3FzseBeCaioQWnYlvsxLMA7Q/U/tGj8
 QbqXUMBfGd7pnF/VfK3R1D8h88ulSAkeeA/Aaa4/9GcQWo7DM3eC+hdX1+Pp9wJkxk
 FF8ACFZYPz4ZBDO1H1CBDokDPaHbxP98UX0+wlqq+sbkIQ+zTomSSZQhgXLBh1C0Ff
 CxHz58UysL9KQtOnqJlJwM+JtuRTbmj93lMvwkISlJde9e0cmxdMkk6I1OcqQY6xMq
 yiGSy6k8mNpaBx+p395hYdTilvLQppwS41mTu2uZoX+VULjgTcLmd/SmqTRNEv2CfW
 Skk/zFze+nQAA==
Message-ID: <403105c3-e432-4d1d-a986-b81ca786b6d5@denx.de>
Date: Sun, 20 Oct 2024 04:25:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: imx: soc: Select default TEXT_BASE for i.MX6
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Adam Ford <aford173@gmail.com>,
 Breno Lima <breno.lima@nxp.com>,
 Francesco Montefoschi <francesco.montefoschi@udoo.org>,
 Ian Ray <ian.ray@gehealthcare.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@dh-electronics.com, Fabio Estevam <festevam@gmail.com>
References: <20241019220938.365256-1-marex@denx.de>
 <20241020002701.GC4959@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241020002701.GC4959@bill-the-cat>
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

On 10/20/24 2:27 AM, Tom Rini wrote:
> On Sun, Oct 20, 2024 at 12:09:03AM +0200, Marek Vasut wrote:
> 
>> Select default U-Boot and SPL text base for the i.MX6 SoC. The U-Boot
>> and SPL text base is picked as the one used by various i.MX6 boards.
>> Update all the boards.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
> [snip]
>> diff --git a/arch/arm/mach-imx/mx6/Kconfig b/arch/arm/mach-imx/mx6/Kconfig
>> index 1f8022ee685..10b19984143 100644
>> --- a/arch/arm/mach-imx/mx6/Kconfig
>> +++ b/arch/arm/mach-imx/mx6/Kconfig
>> @@ -15,6 +15,13 @@ config MX6
>>   	select GPT_TIMER if !MX6UL && !MX6ULL
>>   	imply CMD_FUSE
>>   
>> +config TEXT_BASE
>> +	default 0x17800000
>> +
>> +config SPL_TEXT_BASE
>> +	depends on SPL
>> +	default 0x00908000
> 
> Please do these in Kconfig and common/spl/Kconfig with the other
> SoC-wide default values, thanks.
There are many examples which do it in arch/$ARCH/$SOC , imx7 does it 
already, so ... why Kconfig instead ?

$ git grep config.TEXT_BASE
Kconfig:config TEXT_BASE
arch/arm/mach-apple/Kconfig:config TEXT_BASE
arch/arm/mach-aspeed/Kconfig:config TEXT_BASE
arch/arm/mach-imx/mx7/Kconfig:config TEXT_BASE
arch/arm/mach-ipq40xx/Kconfig:config TEXT_BASE
arch/arm/mach-npcm/Kconfig:config TEXT_BASE
arch/arm/mach-owl/Kconfig:config TEXT_BASE
arch/arm/mach-rockchip/Kconfig:config TEXT_BASE
arch/arm/mach-rockchip/rk3308/Kconfig:config TEXT_BASE
arch/arm/mach-rockchip/rk3568/Kconfig:config TEXT_BASE
arch/arm/mach-rockchip/rk3588/Kconfig:config TEXT_BASE
arch/arm/mach-rockchip/rv1126/Kconfig:config TEXT_BASE
arch/arm/mach-socfpga/Kconfig:config TEXT_BASE
arch/arm/mach-stm32mp/Kconfig.13x:config TEXT_BASE
arch/arm/mach-stm32mp/Kconfig.15x:config TEXT_BASE
arch/arm/mach-stm32mp/Kconfig.25x:config TEXT_BASE

(CC list clipped, sorry if someone got dropped)
