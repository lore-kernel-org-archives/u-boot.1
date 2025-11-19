Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF2CCF34DB
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 15:39:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E4FA83FA4;
	Wed, 19 Nov 2025 16:39:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="In+D0tEI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BC5183E52; Wed, 19 Nov 2025 11:09:23 +0100 (CET)
Received: from mail-m15588.qiye.163.com (mail-m15588.qiye.163.com
 [101.71.155.88])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0577A8004F
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 11:09:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chaoyi.chen@rock-chips.com
Received: from [172.16.12.51] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2a2265d9e;
 Wed, 19 Nov 2025 18:09:16 +0800 (GMT+08:00)
Message-ID: <208fb48c-a4b6-4b5d-a8a3-9587fd447ab9@rock-chips.com>
Date: Wed, 19 Nov 2025 18:09:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: rockchip: Enable RK806 PMIC on rk3588-evb
To: Quentin Schulz <quentin.schulz@cherry.de>, Chaoyi Chen
 <kernel@airkyi.com>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>,
 Finley Xiao <finley.xiao@rock-chips.com>
Cc: u-boot@lists.denx.de
References: <20251119015554.153-1-kernel@airkyi.com>
 <bae11d52-65cf-4d8f-a51e-115a90a7444c@cherry.de>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <bae11d52-65cf-4d8f-a51e-115a90a7444c@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a9b9701bd03abkunm4e258133ca69b3
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkkdTFYeSB9LTE9DSElDQhlWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=In+D0tEI5GHB11YqeJ5Pcvt5eM5DX52cAF4JRsdIBfs2Gku9HpcuBaRBy2PoHExPoo34u8VOLIMhv2VQ1fmWWZhIKsOWhkzi5p//d21yMZETinhinwy5e0Gk0DrCeJK4B2VSD1N6Ckwe0/ZGWPa4VDyDkUmfzhMSpFu3g4qXhIo=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=k8pqg1t7qv1Q0yR1FxNmtlKdXQ57JKJpRJ9a43B34JU=;
 h=date:mime-version:subject:message-id:from;
X-Mailman-Approved-At: Wed, 19 Nov 2025 16:39:33 +0100
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

On 11/19/2025 5:52 PM, Quentin Schulz wrote:
> Hi Chaoyi Chen,
>
> On 11/19/25 2:55 AM, Chaoyi Chen wrote:
>> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>>
>> Some pmdomains rely on RK806 PMIC for power supply. If we don't
>> enable them in U-Boot, random panic may occur during the Kernel
>> boot process.
>>
>
> The kernel shouldn't rely on U-Boot doing something to work, so please fix this with upstream Linux kernel.
>
> Can you tell us what's the issue?
>
> The issue with this patch here is that we probably would need **all** RK3588 boards to have the PMIC enabled, and all the appropriate regulators brought up before booting into the kernel. It'd be *much* better this is fixed in Linux (and depending on what we're talking about, it may need another fix in U-Boot so that whatever depends on the PM domain works as well).
>
> Also, why the PMIC in SPL but not the regulators?

It make sense, but I haven't thought of a specific solution for Kernel yet.

To be specific, I'm trying to get RKVENC to work. It uses an independent power domain. If RK806 is not enabled in U-Boot, the first power-up attempt for the pmdomain corresponding to RKVENC will fail in the Kernel.

And essentially, the operations of pmdomains in the Kernel are dependent on regulators. But it seems that pmdomains driver haven't dealt with this. I have seen some cases, but it seems that the dependency issue has not been fully resolved [0].


[0]: https://lore.kernel.org/all/20250909111130.132976-3-ulf.hansson@linaro.org/

>
> Cheers,
> Quentin
>
>
-- 
Best,
Chaoyi

