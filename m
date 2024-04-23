Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95CEFC4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 10:02:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EECA088507;
	Tue, 23 Apr 2024 12:02:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="VXK15oRs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0E1388504; Tue, 23 Apr 2024 12:02:12 +0200 (CEST)
Received: from mail-m49227.qiye.163.com (mail-m49227.qiye.163.com
 [45.254.49.227])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D11C88585
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 12:02:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=VXK15oRsSr4Zww3xiPwm8xiwaKIZiRKLGdheAmblob86oRl9r02EYdQdxA0hcEa08f+wpvVVo3KJykuXrqXh57yxAzX7PpAUNnJ5sPAoLumDOf2T3IPKztrM8QiQlo1vY9mKTy6c5GBAb/0tpJU/eR+CeWknIHlGYBTRTdmgrAY=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=YlWELgka9V2Yd1NBojrMP/5Ew8QifefjabO7AUmfvso=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id DC11B90031A;
 Tue, 23 Apr 2024 18:01:52 +0800 (CST)
Message-ID: <37e1db75-9725-4d40-a1c0-db3601c4cda1@rock-chips.com>
Date: Tue, 23 Apr 2024 18:01:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rockchip: rk3588: add support for UART2 M1 and M2 in
 SPL
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Quentin Schulz <foss+uboot@0leil.net>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: u-boot@lists.denx.de
References: <20240422-tiger-v1-0-8816b070d748@theobroma-systems.com>
 <20240422-tiger-v1-1-8816b070d748@theobroma-systems.com>
 <e8a60f99-4012-4ef6-a210-436ac41bd1ae@rock-chips.com>
 <1e6e1991-a54b-4c9c-9541-fa5554b557ec@theobroma-systems.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <1e6e1991-a54b-4c9c-9541-fa5554b557ec@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR5PHlZLHR1PTkwfGkpKGB9VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8f0a679b9403a9kunmdc11b90031a
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kz46STo*STNDPj4OHTRKM1Yq
 Sx9PFCpVSlVKTEpIQ01NTkpITUhCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFISkNJNwY+
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

Hi Quentin,

On 2024/4/23 17:31, Quentin Schulz wrote:
> Hi Kever,
>
> On 4/23/24 03:09, Kever Yang wrote:
>> Hi Quentin,
>>
>> On 2024/4/23 00:41, Quentin Schulz wrote:
>>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>>
>>> UART2 controller is the controller in the reference design for debug
>>> console. The default mux is M0 in that reference design. Until now, all
>>> boards seemed to be using UART2M0 but RK3588 Tiger for example will be
>>> using UART2M2 instead.
>> This feature already been supported, please use 
>> CONFIG_DEBUG_UART_BASE and
>> CONFIG_ROCKCHIP_UART_MUX_SEL_M to select your output channel.
>>
>
> CONFIG_ROCKCHIP_UART_MUX_SEL_M is only available in Rockchip's 
> downstream U-Boot.

Sorry, my mistake, I'm searching the wrong code.

I though we should already have solution for this, it should be 
DEBUG_UART_CHANNEL then.


Thanks,

- Kever

>
> git log -p -S ROCKCHIP_UART_MUX_SEL_M
>
> returns nothing upstream, neither does git grep.
>
> I used the same mechanism as for PX30.
>
> This patch will be removed though as it's not needed until we have an 
> open-source DRAM init. Until then we have to rely on the DDR bin to 
> setup the UART.
>
> Cheers,
> Quentin
