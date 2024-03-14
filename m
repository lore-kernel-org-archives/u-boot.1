Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698FEC54E5D
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 07:09:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D154887F73;
	Thu, 14 Mar 2024 08:09:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ttip4oEF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1D1487F49; Thu, 14 Mar 2024 08:09:24 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EF2687F4E
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 08:09:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=78b9=KU=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1710400145;
 bh=8cePO7s7cmAonhSGweS6A63+2vtH1l5seMQryWRMqFA=;
 b=ttip4oEFdK2YmGLRG3uMEV2hwKAcvMlJNAnA3eYT74zq9ZFaeNXyHKfQnhKfcd8xq+JMS9v/g
 P2G9UyHCZkQJRB3efeuSmX3V7MmST23ErfJHKEieFwNbHZozTqqEjfW6MinKd3zCSdN0+pKfpsx
 6EIUo4h3vC45rXioYbOpcaqw0nPnA5AeYbmdp/wgAHaUEoYShfdlkp+FWYmIlLaAIejPSIszJ77
 L1TAameCuFfW9Aw5RUuEEX44KENm3N/Qmu2SScmXg0QljTpvhXKktMKXpL6PkHxoOcySVWlzpwE
 YdD91wyQplcBpQJv0iMXZSRpjU+gsSD2yQ54Ogw+TnCg==
Message-ID: <f07d914c-1004-438b-b309-fca9e5e23afd@kwiboo.se>
Date: Thu, 14 Mar 2024 08:08:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] rockchip: Use common bss and stack addresses on
 RK3328
Content-Language: en-US
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>, Tianling Shen
 <cnsztl@gmail.com>, David Bauer <mail@david-bauer.net>, Loic Devulder
 <ldevulder@suse.com>, "Chen-Yu Tsai" <wens@csie.org>, Banglang Huang
 <banglang.huang@foxmail.com>, "Matwey V. Kornilov"
 <matwey.kornilov@gmail.com>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, Christopher Obbard
 <chris.obbard@collabora.com>, u-boot@lists.denx.de
References: <20240302191629.322562-1-jonas@kwiboo.se>
 <20240302191629.322562-4-jonas@kwiboo.se>
 <92121a89-9ae3-4e82-9c64-cbda7358753a@rock-chips.com>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <92121a89-9ae3-4e82-9c64-cbda7358753a@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65f2a28fffda568fff1647a9
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

Hi Kever,

On 2024-03-13 11:39, Kever Yang wrote:
> Hi Jonas,
> 
>      This patch does not able to apply on next, could you help to take a 
> look.
> 
> And also add document of memory layout in rockchip.rst if possible.

I will send a follow-up patch that adds details about this memory layout
and the new Kconfig option to the rockchip documentation.

Regards,
Jonas

> 
> 
> Thanks,
> 
> - Kever
> 
> On 2024/3/3 03:16, Jonas Karlman wrote:
>> With the stack and text base used by U-Boot SPL and proper on RK3328
>> there is a high likelihood of overlapping when U-Boot proper + FDT nears
>> or exceeded 1 MiB in size.
>>
>> Currently the following memory layout is typically used on RK3328:
>> [    0, 256K) - SPL binary
>> [ 256K,   2M) - TF-A / reserved
>> [   2M,   +X) - U-Boot proper binary (TEXT_BASE)
>> [   -X,   3M) - U-Boot proper pre-reloc stack (CUSTOM_SYS_INIT_SP_ADDR)
>> [  -8K,   3M)   - pre-reloc malloc heap (SYS_MALLOC_F_LEN)
>> [   -X,   4M) - SPL pre-reloc stack (SPL_STACK)
>> [  -8K,   4M)   - pre-reloc malloc heap (SPL_SYS_MALLOC_F_LEN)
>> [   -X,   6M) - SPL reloc stack (SPL_STACK_R_ADDR)
>> [   5M,   6M)   - reloc malloc heap (SPL_STACK_R_MALLOC_SIMPLE_LEN)
>> [  32M,  +8K) - SPL bss (SPL_BSS_START_ADDR, SPL_BSS_MAX_SIZE)
>>
>> SPL can safely load U-Boot proper + FDT to [2M, 4M-8K) with this layout.
>> However, the stack at [-X, 3M) used during U-Boot proper pre-reloc is
>> restricting the safe size of U-Boot proper + FDT to be less than 1 MiB.
>>
>> Migrate to use common bss, stack and malloc heap size and addresses to
>> fix this restriction and allow for a larger U-Boot proper image size.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>   arch/arm/mach-rockchip/rk3328/Kconfig         | 11 ++++-------
>>   configs/evb-rk3328_defconfig                  | 17 -----------------
>>   configs/nanopi-r2c-plus-rk3328_defconfig      | 15 ---------------
>>   configs/nanopi-r2c-rk3328_defconfig           | 15 ---------------
>>   configs/nanopi-r2s-rk3328_defconfig           | 15 ---------------
>>   configs/orangepi-r1-plus-lts-rk3328_defconfig | 15 ---------------
>>   configs/orangepi-r1-plus-rk3328_defconfig     | 15 ---------------
>>   configs/roc-cc-rk3328_defconfig               | 15 ---------------
>>   configs/rock-pi-e-rk3328_defconfig            | 17 -----------------
>>   configs/rock64-rk3328_defconfig               | 15 ---------------
>>   10 files changed, 4 insertions(+), 146 deletions(-)
>>

[snip]
