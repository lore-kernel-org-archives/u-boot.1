Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 732DECA0EE4
	for <u-boot@archiver.kernel.org>; Sun, 17 Aug 2025 14:30:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7957883935;
	Sun, 17 Aug 2025 16:30:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="jIXdazNh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5124F83939; Sun, 17 Aug 2025 16:30:56 +0200 (CEST)
Received: from mail-m4921.qiye.163.com (mail-m4921.qiye.163.com [45.254.49.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E65083824
 for <u-boot@lists.denx.de>; Sun, 17 Aug 2025 16:30:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [121.204.18.212])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1fa11ec6e;
 Sun, 17 Aug 2025 22:30:46 +0800 (GMT+08:00)
Message-ID: <6af1a69a-8c00-44c3-85c9-e7a3771b63c5@rock-chips.com>
Date: Sun, 17 Aug 2025 22:30:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] rockchip: Add initial RK3582 support
To: Quentin Schulz <quentin.schulz@cherry.de>, Jonas Karlman
 <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250810222644.4095072-1-jonas@kwiboo.se>
 <20250810222644.4095072-2-jonas@kwiboo.se>
 <1b1ad33a-3004-480d-9d32-3ea05e7eaf63@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <1b1ad33a-3004-480d-9d32-3ea05e7eaf63@cherry.de>
X-HM-Tid: 0a98b870a58503afkunma2cd470fc33235
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDTB4aVh9KTRlPTR5JTxodGVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpDVUlKSVlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0
 tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
 b=jIXdazNh09f9QKhdcKJLjsToVy/anVSTEHeEt6DF9i7lDWk73HVkupEliuozwDJFuVLuuWkU8lPSaxjNeOApJz0ORD+L50cgEGxA2AGSZl3zwqhLudtfA1CVidclqevWhNcxT6ARgQ/p+l2FgykpMhus7JS28iEM2gP5eKS2VVI=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=NS1zml+p61r5fy0xy0Yb8Oi0OniYJqg6R0b9nFwcjpQ=;
 h=date:mime-version:subject:message-id:from;
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Quentin, Jonas,


On 2025/8/11 23:44, Quentin Schulz wrote:
> Hi Jonas,
>
> On 8/11/25 12:26 AM, Jonas Karlman wrote:
>> The RK3582 SoC is a variant of the RK3588S with some IP blocks disabled.
>> What blocks are disabled/non-working is indicated by ip-state in OTP.
>>
>> This add initial support for RK3582 by using ft_system_setup() to mark
>> any cpu and/or vdec/venc node with status=fail as indicated by ip-state.
>>
>> This apply same policy as vendor U-Boot for RK3582, i.e. two big cpu
>> cores and one vdec/venc core is always failed/disabled.
>>
>> Enable Kconfig option OF_SYSTEM_SETUP in board defconfig to make use of
>> the required DT fixups for RK3582 board variants.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> Changes in v3:
>> - Apply same policy for RK3582/RK3583 to match vendor U-Boot
>>    linux-6.1-stan-rkr6 tag, allow use of the GPU and one vdec core.
>
> Isn't the GPU supposed to be possibly non-fonctional on RK3582/RK3583? 
> If we don't disable it in the DT, how will the system actually behave?
>
> @Kever may have more official info on that?

RK3582 and RK3583 is different on GPU,  RK3582 do not have GPU, while 
RK3583 has limited GPU.

Did you see any RK3583 device on the market, it should only available in 
limited device instead of public, so maybe we can support rk3582 first 
due to

we have a ROCK 5C Lite with this chipset.

Thanks,

- Kever

>
> See remarks on v2 otherwise, most of them still apply.
>
>> - Update rkvdec node name to match latest mainling Linux DT patches.
>
> Should we rather wait for the patches to be actually merged before 
> trying to patch the device tree nodes that do not exist yet?
>
> Cheers,
> Quentin 
