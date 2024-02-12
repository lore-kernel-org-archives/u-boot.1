Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D05C4829E
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 20:50:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89F8487E78;
	Mon, 12 Feb 2024 21:50:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="U6t/po2b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8EAC87E96; Mon, 12 Feb 2024 21:50:38 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51BF587C52
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 21:50:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=15da=JW=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1707770978;
 bh=pogTlKvInWEWuWgVD8bqMHzOHxkw3zNvq/nDV2TiVbg=;
 b=U6t/po2bSHtYRUiIXNclHziV9SmB0EJ2x4nYKcx7OSXxx4hK94P5F+JaeTjlMfLmpnjEGQeXF
 TRE1+XCOiYnF9+4pWfRFWZ2HF8uCd9Wm+diIJ6+S+x57JXB1SCdZh+6tj/SqVt6qiOF91BuUhUf
 dAm5RmX5np3eweKDjmblGxzxaaovG/PZUOlh8gOXpietkC/nd/qRcftzvGgK93G/f3r4mM3RweO
 Woj1KiI6l2ZDB2C3hHIIioZIZCtCLn51zYwpcRR9N6t7r2Y7I8taTathDGNxC7e/AYuxGQihs+I
 tc8ANDDga75o0SySzRFjTyhq1cmXY+HSCO+HPkfBDzhw==
Message-ID: <2ca6e59a-aa10-4bc3-89f2-869f1a23400a@kwiboo.se>
Date: Mon, 12 Feb 2024 21:49:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rockchip: rk3399: Update stack and bss addresses
Content-Language: en-US
To: Jerome Forissier <jerome.forissier@linaro.org>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Andy Yan
 <andy.yan@rock-chips.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Nick Xie <nick@khadas.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Deepak Das <deepakdas.linux@gmail.com>,
 Alexandre Vicenzi <linux@alxd.me>, Xiaobo Tian <peterwillcn@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>, Klaus Goger
 <klaus.goger@theobroma-systems.com>, Levin Du <djw@t-chip.com.cn>, Suniel
 Mahesh <sunil@amarulasolutions.com>, FUKAUMI Naoki <naoki@radxa.com>,
 Christopher Obbard <chris.obbard@collabora.com>, u-boot@lists.denx.de
References: <20240212005914.3512640-1-jonas@kwiboo.se>
 <20240212005914.3512640-3-jonas@kwiboo.se>
 <d8e10b17-0571-4ebc-9783-2301c429c6b3@theobroma-systems.com>
 <c3f2027d-3d87-4b71-bb13-35090640dc9a@kwiboo.se>
 <3b213c6d-9b97-48d1-8c36-4970dd1c4aa8@theobroma-systems.com>
 <44d1809d-4317-4363-a0e2-c83029357285@linaro.org>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <44d1809d-4317-4363-a0e2-c83029357285@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 65ca84617b36b4417b5d8045
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

On 2024-02-12 14:15, Jerome Forissier wrote:
> On 2/12/24 12:51, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 2/12/24 12:08, Jonas Karlman wrote:
>>> Hi Quentin,
>>>
>>> On 2024-02-12 11:37, Quentin Schulz wrote:
>>>> Hi Jonas,
>>>>
>>>> On 2/12/24 01:59, Jonas Karlman wrote:
>>>>> With the stack and text base used by U-Boot SPL and proper on RK3399
>>>>> there is a high likelihood of overlapping when U-Boot proper + FDT nears
>>>>> 1 MiB in size.
>>>>>
>>>>> Currently the following memory layout is used:
>>>>> - 0x00000000 (@0 MiB): U-Boot SPL text base
>>>>> - 0x00040000 (@256 KiB): TF-A
>>>>> - 0x00200000 (@2 MiB): U-Boot proper text base
>>>>> - 0x00300000 (@3 MiB): U-Boot proper init stack
>>>>> - 0x00400000 (@4 MiB): U-Boot SPL init stack
>>>>> - 0x00400000 (@4 MiB): U-Boot SPL bss
>>>>> - 0x02000000 (@64 MiB): U-Boot SPL reloc stack
>>>>> - 0x08400000 (@132 MiB): optional OPTEE
>>>>>
>>>>> SPL load TF-A, U-Boot proper and optional OPTEE after SPL stack has
>>>>> relocated, meaning that there is room for close to 2 MiB (@2-4 MiB).
>>>>> However, the initial stack used by U-Boot proper is limiting the size
>>>>> of U-Boot proper + FDT to below 1 MiB (@2-3 MiB).
>>>>>
>>>>> Instead change to use the following memory layout:
>>>>> - 0x00000000 (@0 MiB): U-Boot SPL text base
>>>>> - 0x00040000 (@256 KiB): TF-A
>>>>> - 0x00200000 (@2 MiB): U-Boot proper text base
>>>>> - 0x00400000 (@4 MiB): U-Boot SPL init stack
>>>>> - 0x00800000 (@8 MiB): U-Boot proper init stack (changed)
>>>>> - 0x02000000 (@32 MiB): U-Boot SPL bss (changed)
>>>>> - 0x04000000 (@64 MiB): U-Boot SPL reloc stack
>>>>> - 0x08400000 (@132 MiB): optional OPTEE
>>>>>
>>>>> This should leave room for loading and running a U-Boot proper close
>>>>> to 6 MiB (@2-8 MiB) in size. When U-Boot proper has relocated is should
>>>>> be possible to use @2-132 MiB and @164 MiB+ for scripts, kernel etc.
>>>>>
>>>>> With the moved SPL reloc stack it is also possible to use a much larger
>>>>> malloc area in SPL, e.g. using default SPL_STACK_R_MALLOC_SIMPLE_LEN.
>>>>>
>>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>>
>>>> Do we not need to update memory addresses in the environment as well?
>>>
>>> The addresses in environment is to my knowledge only used in U-Boot
>>> proper after relocation. And at that time we should be free to use @2+
>>> MiB up to somewhere close to gd ram_top/relocaddr. The optional Rockchip
>>> OPTEE blobb may occupy @132-164 MiB, but I do not think loading OPTEE
>>> blobs works as-is, so that may not be a big issue.
>>>
>>
>> Upstream OP-TEE OS seems to support RK3399, c.f. https://github.com/OP-TEE/optee_os/blob/master/core/arch/arm/plat-rockchip/platform_rk3399.c
> 
> It does indeed. I run the quarterly release tests on a RockPi4B. We record which
> platforms have been tested in the commit description for each release tag. For
> example, see [1].
> 
> In the configuration I test, OP-TEE is loaded at 0x30000000 and uses 32MB (for
> some reason the Linux DT reserves 36MB but I don't think it matters much).
> 
> [1] https://github.com/OP-TEE/optee_os/commit/18b424c23aa5a798dfe2e4d20b4bde3919dc4e99
> 

Great, I did a quick test run with OP-TEE on my ROCK 4SE and seem to
work, see short boot log below.

Also good to know that it runs at @768 MiB, we should be able to use
@2-768 MiB for loading kernel, initrd etc in U-Boot proper with open
source OP-TEE.

---
U-Boot SPL 2024.04-rc1 (Feb 12 2024 - 20:39:20 +0000)
Trying to boot from MMC2
## Checking hash(es) for config config-1 ... OK
## Checking hash(es) for Image atf-1 ... sha256+ OK
## Checking hash(es) for Image u-boot ... sha256+ OK
## Checking hash(es) for Image fdt-1 ... sha256+ OK
## Checking hash(es) for Image atf-2 ... sha256+ OK
## Checking hash(es) for Image atf-3 ... sha256+ OK
## Checking hash(es) for Image atf-4 ... sha256+ OK
load_simple_fit: Skip load 'atf-5': image size is 0!
## Checking hash(es) for Image tee-1 ... sha256+ OK
NOTICE:  BL31: v2.10.2(release):
NOTICE:  BL31: Built : 20:23:10, Feb 12 2024
INFO:    GICv3 with legacy support detected.
INFO:    ARM GICv3 driver initialized in EL3
INFO:    Maximum SPI INTID supported: 287
INFO:    plat_rockchip_pmu_init(1624): pd status 3e
INFO:    BL31: Initializing runtime services
INFO:    BL31: Initializing BL32
I/TC:
I/TC: No non-secure external DT
I/TC: OP-TEE version: Unknown_4.1 (gcc version 10.5.0 (Ubuntu 10.5.0-1ubuntu1~22.04)) #2 Mon Feb 12 20:37:33 UTC 2024 aarch64
I/TC: WARNING: This OP-TEE configuration might be insecure!
I/TC: WARNING: Please check https://optee.readthedocs.io/en/latest/architecture/porting_guidelines.html
I/TC: Primary CPU initializing
I/TC: GIC redistributor base address not provided
I/TC: Assuming default GIC group status and modifier
I/TC: Primary CPU switching to normal world boot
INFO:    BL31: Preparing for EL3 exit to normal world
INFO:    Entry point address = 0x200000
INFO:    SPSR = 0x3c9


U-Boot 2024.04-rc1 (Feb 12 2024 - 20:39:20 +0000)

SoC: Rockchip rk3399
Reset cause: POR
Model: Radxa ROCK 4SE
DRAM:  4 GiB (effective 3.9 GiB)
---

Regards,
Jonas
