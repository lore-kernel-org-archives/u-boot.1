Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9812C54FB3
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 00:37:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76B9382E76;
	Fri, 30 May 2025 02:37:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="YPvKsexk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8D868301F; Fri, 30 May 2025 02:36:59 +0200 (CEST)
Received: from mail-m32100.qiye.163.com (mail-m32100.qiye.163.com
 [220.197.32.100])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A17582E26
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 02:36:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 16e6a4868;
 Fri, 30 May 2025 08:36:48 +0800 (GMT+08:00)
Message-ID: <9d02e0bf-0910-4efc-b4ef-e25023e7efad@rock-chips.com>
Date: Fri, 30 May 2025 08:36:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] rockchip: Update rng compatible for RK356x and
 RK3588
To: Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20250408221151.2762853-1-jonas@kwiboo.se>
 <CALeDE9N+9ki7OtCqG9U0FU4FXP-z-WSTuPQkonWYGTQkMuynzw@mail.gmail.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <CALeDE9N+9ki7OtCqG9U0FU4FXP-z-WSTuPQkonWYGTQkMuynzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZHx0YVhpNShlITkNMSUJCQlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a971e9eb8c603afkunmd8cc80b8e9925
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nwg6LQw*EDE3SUITDz8JIxEv
 AhwaCyNVSlVKTE9DTk1OT0tCSUtDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUlCT043Bg++
DKIM-Signature: a=rsa-sha256;
 b=YPvKsexkfcuwklVJBAYjGEgbkVYjwPAmrXS0SZnk0YkMlr3BpvYjnV17qvixJyMWK8vqzXSM7wwNJXyy7OkaYv6OcA9Pvcq6U2yMCu1xObv6fW/o9G4VMOU+tb4fUHxegkd6SpT4j0zsPmbRUEhO8dXI0EFuoujFdFaludEZH+s=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=g053DyogsM4kq6QyRyKYuTDNnwxj+s72/CCM8OPcu/E=;
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

Hi Peter,

On 2025/5/29 19:11, Peter Robinson wrote:
> Hi Jonas,
>
> Sorry for the late reply here.
>
> On Tue, 8 Apr 2025 at 23:37, Jonas Karlman <jonas@kwiboo.se> wrote:
>> This series adds support for and updates the random generator compatible
>> used for RK356x and RK3588.
>>
>> The RK356x rng node is already part of dts/upstream so the rng node in
>> u-boot.dtsi is removed, and because it is not enabled for rk3566 it gets
>> enabled in u-boot.dtsi to restore its use in U-Boot.
> It's explicitly disabled in the upstream kernel because it doesn't
> produce actual random data

rockchip trng module is able to pass the third party RNG test, should be 
"actual random data",

so no idea why kernel people think it doesn't produce actual random data.

> and hence upstream believe it shouldn't be
> used, there's a couple of threads on it.
>
> Have we tested to see if the data produced in U-Boot from the HW
> exhibits a different outcome? I wonder if Kever is aware of the kernel
> issue and can provide input.

I only follow linux-rockchip mailing list, so didn't notice the the 
kernel issue.


Thanks,
- Kever
>
> Peter
>
>> The RK3588 rng node is added into dts/upstream DT by picking a commit
>> from devicetree-rebasing v6.15-rc1-dts and the rng node in u-boot.dtsi
>> is removed.
>>
>> Changes in v2:
>> - Split rng driver and DT change into separate patches for RK356x
>> - Pick RK3588 rng node commit from devicetree-rebasing v6.15-rc1-dts
>>
>> Jonas Karlman (3):
>>    rng: rockchip_rng: Add compatible for RK3568
>>    rockchip: rk356x: Remove rng node from u-boot.dtsi
>>    rng: rockchip_rng: Update compatible for RK3588
>>
>> Nicolas Frattaroli (1):
>>    arm64: dts: rockchip: Add rng node to RK3588
>>
>>   arch/arm/dts/rk356x-u-boot.dtsi                  | 9 ++++-----
>>   arch/arm/dts/rk3588s-u-boot.dtsi                 | 5 -----
>>   drivers/rng/rockchip_rng.c                       | 6 +++++-
>>   dts/upstream/src/arm64/rockchip/rk3588-base.dtsi | 8 ++++++++
>>   4 files changed, 17 insertions(+), 11 deletions(-)
>>
>> --
>> 2.49.0
>>
