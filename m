Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D05D9C48297
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 11:09:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 099CD879DF;
	Mon, 12 Feb 2024 12:09:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="tSepR1d2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37AD887BE5; Mon, 12 Feb 2024 12:09:27 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFE1186A26
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 12:09:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=b753=JV=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1707736124;
 bh=46D2tBdQ56d9wNZVEfDH8S/g8x/Z+sv7k3ICCEIl3DQ=;
 b=tSepR1d2efTCYzp1vJ0T+7xsRQ/FkI1PYNOU9pEDufHbk5M6VGtyCnaIGzY4/P3gkb5AlWK46
 3yiOHOR4pQUdti1JbLL6pbJPUtK4SLhHOi4w4ygJkzMiCEPjs8BVGUGrBhO2ipxIkak5Z7VEfGU
 ForDpQ2ncxd2KYZnmOqloVvakHYDcuj3CET3oZVbBwWXuapk6J7psTCeWRpCDnpiRILptlycQMC
 ILG62H12CqyTPpEEEhb7hA8lQfjwZZ5LxdGcnn+NxvBNaEVC/YwkcretqlWr/nU2+qh3ax08YI1
 SUrUmKQKED2Tw0ThS27yEDFkx2GFG0k6OxcoImbghHgA==
Message-ID: <c3f2027d-3d87-4b71-bb13-35090640dc9a@kwiboo.se>
Date: Mon, 12 Feb 2024 12:08:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rockchip: rk3399: Update stack and bss addresses
Content-Language: en-US
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
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
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <d8e10b17-0571-4ebc-9783-2301c429c6b3@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 65c9fc3b824ba36109ad370b
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

On 2024-02-12 11:37, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 2/12/24 01:59, Jonas Karlman wrote:
>> With the stack and text base used by U-Boot SPL and proper on RK3399
>> there is a high likelihood of overlapping when U-Boot proper + FDT nears
>> 1 MiB in size.
>>
>> Currently the following memory layout is used:
>> - 0x00000000 (@0 MiB): U-Boot SPL text base
>> - 0x00040000 (@256 KiB): TF-A
>> - 0x00200000 (@2 MiB): U-Boot proper text base
>> - 0x00300000 (@3 MiB): U-Boot proper init stack
>> - 0x00400000 (@4 MiB): U-Boot SPL init stack
>> - 0x00400000 (@4 MiB): U-Boot SPL bss
>> - 0x02000000 (@64 MiB): U-Boot SPL reloc stack
>> - 0x08400000 (@132 MiB): optional OPTEE
>>
>> SPL load TF-A, U-Boot proper and optional OPTEE after SPL stack has
>> relocated, meaning that there is room for close to 2 MiB (@2-4 MiB).
>> However, the initial stack used by U-Boot proper is limiting the size
>> of U-Boot proper + FDT to below 1 MiB (@2-3 MiB).
>>
>> Instead change to use the following memory layout:
>> - 0x00000000 (@0 MiB): U-Boot SPL text base
>> - 0x00040000 (@256 KiB): TF-A
>> - 0x00200000 (@2 MiB): U-Boot proper text base
>> - 0x00400000 (@4 MiB): U-Boot SPL init stack
>> - 0x00800000 (@8 MiB): U-Boot proper init stack (changed)
>> - 0x02000000 (@32 MiB): U-Boot SPL bss (changed)
>> - 0x04000000 (@64 MiB): U-Boot SPL reloc stack
>> - 0x08400000 (@132 MiB): optional OPTEE
>>
>> This should leave room for loading and running a U-Boot proper close
>> to 6 MiB (@2-8 MiB) in size. When U-Boot proper has relocated is should
>> be possible to use @2-132 MiB and @164 MiB+ for scripts, kernel etc.
>>
>> With the moved SPL reloc stack it is also possible to use a much larger
>> malloc area in SPL, e.g. using default SPL_STACK_R_MALLOC_SIMPLE_LEN.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> 
> Do we not need to update memory addresses in the environment as well?

The addresses in environment is to my knowledge only used in U-Boot
proper after relocation. And at that time we should be free to use @2+
MiB up to somewhere close to gd ram_top/relocaddr. The optional Rockchip
OPTEE blobb may occupy @132-164 MiB, but I do not think loading OPTEE
blobs works as-is, so that may not be a big issue.

So to my knowledge we do not need to update any of the memory addresses
in the environment as well.

> 
> scriptaddr=0x00500000
> 
> This is at 5MiB if I'm not mistaken?
> 
> Basically everything in include/configs/rk3399_common.h in 
> ENV_MEM_LAYOUT_SETTINGS needs to be updated to be located after 164MiB?
> 
> Did I misunderstand something? I find it weird the current values seems 
> to be located after U-Boot SPL bss and that e.g.
> 
> kernel_addr_r=0x02080000
> 
> is at 32.5MiB, and with U-Boot SPL reloc stack currently at 64MiB... a 
> 31.5+MiB kernel Image would mess up the data there? (what do we need it 
> for BTW once in U-boot proper after relocation?).

After SPL has jumped to TF-A and U-boot proper any memory used by SPL
can be overwritten/used for something else.

My understanding is as follow:
- SPL always need access to bss
- SPL need access to init stack until it has relocated to reloc stack
- SPL will load FIT images using the reloc stack, at this time only
  SPL code, bss and reloc stack matters
- U-boot proper will use its init stack until it has relocated to end
  of memory. Until U-Boot proper has relocated it will use init stack
- We could use same memory position for init stack for SPL and proper,
  e.g. SPL_SHARES_INIT_SP_ADDR=y without any issue
- After U-Boot proper has relocated we should be free to use @2+ MiB
  up to where U-Boot proper was relocated.

> 
> Side question, what about making those values the default for RK3399 
> instead of having it in each defconfig? This could grow quickly out of 
> hands to move this to the Kconfig symbol itself, so not sure it's that 
> interesting to the project, but raising this anyway.

Agree, was trying to define these as defaults in soc Kconfig, but that
rearranged some values in other defconfigs so I avoided doing that in
this series. Also touching each defconfig helped me ping board
maintainers of the change.

Hopefully a follow-up series can move these, and other options, into
soc Kconfig.

Regards,
Jonas

> 
> Cheers,
> Quentin

