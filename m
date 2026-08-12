Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C63C5AD5A
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 09:55:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 417164085F;
	Wed, 12 Aug 2026 09:55:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i9ByWEWueKZo; Wed, 12 Aug 2026 09:55:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 494DB4084F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786528519;
	bh=msOO1t+NQyD0xbs5J0B4lauLLOTQluWtj0acUgd+e2I=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=l+xW+VvOlAAAEihYxB09gYztxHn71YxurIlEZPzQ4fSW0iE7DJ/1sXkr0aMs7LId1
	 iLGcQP7B8bkvPFZ9hk0pkrfQiBpO6Y6MIR1O7RBR3jJiJrpS5CKeDmf1JuPG/QT/eQ
	 yknzUsjv44NTNbn0a4VRmxkGMcNHzaTr2+BxPJIfEh8wQd7c7TvJsh8eMhf7Sko/jM
	 0hh/T/RTotv4HW7721sDFDqcBIQwlgHgweyF3q26lpxbo0tQWj/VrHEho+Lb9RVL6a
	 +hfPnB+3/5ZieTt4g1XCaA7zXDcq6mKViVxbI8ULFu8iOHuEIHhkEA3X4crb1Qbr83
	 mpe2FgxmwVTCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 494DB4084F;
	Wed, 12 Aug 2026 09:55:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id ABB7A282
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 09:55:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 94A8E4084F
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 09:55:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rux7HQs4XOVT for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 09:55:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.25.12;
 helo=smtp-190c.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4C66640824
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4C66640824
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch
 [185.125.25.12])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4C66640824
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 09:55:15 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hKkGV6mbwzYrw;
 Wed, 12 Aug 2026 11:49:06 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hKkGT6Kj7zP6j; Wed, 12 Aug 2026 11:49:05 +0200 (CEST)
Message-ID: <574bc6fa-8469-417c-9418-023d1bd0eb29@0leil.net>
Date: Wed, 12 Aug 2026 11:49:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] rockchip: rk3506: Update ENV_MEM_LAYOUT_SETTINGS
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org
References: <20260803190946.2259514-1-jonas@kwiboo.se>
 <20260803190946.2259514-3-jonas@kwiboo.se>
Content-Language: en-US
In-Reply-To: <20260803190946.2259514-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0leil.net; s=20231125; t=1786528146;
 bh=msOO1t+NQyD0xbs5J0B4lauLLOTQluWtj0acUgd+e2I=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Ob5cMZp2qqAJHAzdpO7dmUIQXYlwn80DUXdEVDhUvIeyC93iRGm0RKRiiPH8PbrBg
 YLlyF1WsGmuu0Dl6mXjbCwV7S4Ne1GnataraAnFDQ5bV6HQ/04wmTodfE+4MPZgHAN
 zIDSecAuIwz2ys9pld/7NALOZKiRsWdN5ElYDyIAa2jcRUtIaukJ4Hj9rIexsR0miU
 /IaU8mSoAJFm1dKrYIuI7CkuPtamQC6LKxfe97G24Q7QeCjPQqY0P0jny8/QAOFnbi
 47IW4YggstjkQjp7gjYtLuUwpSeuqS36tOLsJoe6bPRU6YdVJkpqJXDAzaa/DHVVpX
 jszwcm0voaQ6Q==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=0leil.net
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=Ob5cMZp2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <u-boot@0leil.net>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Jonas,

On 8/3/26 9:09 PM, Jonas Karlman wrote:
> The RK3506G1 has 64 MiB integrated DDR2, the RK3506G2 has 128 MiB
> integrated DDR3 and the RK3506B support external memory up to 1 GiB.
> 
> Current memory layout cause issues using compressed kernels or ramdisk
> due to the default load addresses being used.
> 

RK3506 is an Aarch32 SoC, and Linux kernels on that architecture are 
self-decompressing, U-Boot doesn't do anything with compressed kernels. 
You can see that kernel_comp_addr_r is only ever used in cmd/booti.c 
which depends on ARM64 to be actually built.

I simply recommend getting rid of this variable as it's quite 
misleading. All other Aarch32 Rockchip SoCs we support don't seem to be 
setting this variable, so no additional cleanup to do.
Same for kernel_comp_size.

> Change the default load addresses to also work on SoC variants with
> limited memory, keep all default addresses in the 0-64 MiB range.
> 
> 			 old		 new
>    scriptaddr		5 MiB		2 MiB
>    pxefile_addr_r	6 MiB		1 MiB
>    kernel_addr_r		32.5 MiB	8 MiB
>    kernel_comp_addr_r	128 MiB		48 MiB
>    fdt_addr_r		30.5 MiB	4 MiB
>    fdtoverlay_addr_r	31.5 MiB	6 MiB
>    ramdisk_addr_r	96 MiB		48 MiB

That leaves less than 18MiB for an initramfs (don't forget U-Boot proper 
is located at the end of the DRAM as far as I remember), which is very 
little.

Do we really need 2MiB for the DTB and DTBO? 1MiB ought to be enough for 
the DTB and I'm sure less than 1MiB ought to be enough per overlay 
(overlay are loaded and applied one after the other). This should free 
an additional 2MiB for either the kernel or initramfs.

The multi_v5_defconfig and multi_v7_defconfig zImage kernels as built by 
KernelCI are respectively 7.5 and 11.6MiB as of yesterday, c.f. 
https://dashboard.kernelci.org/build/maestro%3A6a7b3f4762f33761c0aedc06 
https://dashboard.kernelci.org/build/maestro%3A6a7b3f6562f33761c0aedc2f
So maybe we can reserve a bit less than 40MiB for the kernel? But maybe 
kernel_addr_r is also used for FIT images which may be much bigger than 
the size of the kernel alone? The load/entry properties are required for 
images of type kernel according to the FIT spec so that part isn't 
something we need to deal with.

Have you figured out how to identify the variant of the RK3506 already? 
Another option is to dynamically modify those variables (if they aren't 
already part of the environment) based on the size of available DRAM 
(and/or SoC variant). I don't like the idea too much but that could be a 
way to stretch the available memory for each binary loaded by U-Boot as 
much as possible.

Cheers,
Quentin
