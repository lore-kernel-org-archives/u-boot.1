Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98F8E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 16:22:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2533780352;
	Fri, 20 Dec 2024 17:22:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="evUSEtgp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E95E980381; Fri, 20 Dec 2024 17:22:48 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7D5480326
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 17:22:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=69d4=TO=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1734711759;
 bh=9VObm20yFVbX8sSovoBVEOeXFMrjelKVt3jMssomRoU=;
 b=evUSEtgpZ5ojKN6diaMiPKuvTuoI70KvUsjVC2yxRXnsB+Deu2dRzAZgxiqPP/BkG7HneIlwC
 6zY4MGKsqTVF/8oablE+QMxZ7Hk8m1mBX2AvztIpxU+EwrePBKM8sKYf6/22Gz3p8NH4U7EH/tS
 zLlGMY6FgARtxzKaMKihTPxD33V6dYvgfC+7Bcq0WjPTyWXLKZ7cPw53wRIl1SlFEl5dgv0c19w
 yowDyuR9lpUqAxHC7oIfQv/LMa3kkuquqYKkOXGx9zXJVOKWsieHJl9tKf3Jyy1GC0NMtc7ywsZ
 hjKcEmLlY3CLkLZB3yjp0pgtBa+mWJSd+2o4ZRtndECw==
Message-ID: <2631e34e-2fd0-45f4-aa4b-0e7405808301@kwiboo.se>
Date: Fri, 20 Dec 2024 17:22:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] rockchip: rk3399: Migrate to use TPL on bob and
 kevin
To: Simon Glass <sjg@chromium.org>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <20241212235735.164272-1-jonas@kwiboo.se>
 <CAFLszTg=UkyZc7qUmgNSv06Sm8vXgS62mHMczH9wudFX1jqHdA@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAFLszTg=UkyZc7qUmgNSv06Sm8vXgS62mHMczH9wudFX1jqHdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 676599cab8c9120276e3cca2
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

Hi Simon,

On 2024-12-13 04:09, Simon Glass wrote:
> Hi Jonas,
> 
> On Thu, 12 Dec 2024 at 16:57, Jonas Karlman <jonas@kwiboo.se> wrote:
>>
>> This is a continuation of an RFC [1] sent back in August.
>>
>> All Rockchip aarch64 boards, beside bob and kevin, use TPL to initialize
>> DRAM and SPL to load FIT with U-Boot proper and TF-A.
>>
>> Bob and kevin currently does not use TPL and instead initialize DRAM
>> in SPL and directly after tries to load a FIT with only U-Boot proper.
>>
>> This series migrate bob and kevin to also use TPL to uniform TPL/SPL use
>> for all Rockchip aarch64 boards.
>>
>> Features and changes in this series:
>> - Use of Rockchip aarch64 common bss and stack addresses
>> - SHA256 checksum/signature check of FIT images in SPL
>> - Use of dcache to speed up checksum check in SPL
>> - SDMA use for eMMC access to speed up read/write in U-Boot proper
>> - FIT location moved from 0x40000 to 0xE0000 in SPI flash
>>
>> Changes sinc RFC:
>> - Include pinctrl props and enable regulators based on DT in SPL
>> - Drop bob and kevin board specific code from common rk3399.c
>>
>> Please note that I do not have any bob or kevin so this has only been
>> compile tested and the original RFC [1] was runtime tested by Simon.
>>
>> [1] https://patchwork.ozlabs.org/patch/1967517/
>>
>> Jonas Karlman (12):
>>   rockchip: rk3399: Fix TPL build of bob and kevin
>>   rockchip: rk3399-gru: Use SYS_SPI_U_BOOT_OFFS value in offset prop
>>   rockchip: rk3399-gru: Move SPI flash payload offset for bob and kevin
>>   rockchip: rk3399-gru: Fix include of TPL in u-boot.rom image
>>   rockchip: rk3399-gru: Use TPL with common bss and stack addresses
>>   rockchip: rk3399-gru: Include binman generated FIT in u-boot.rom image
>>   rockchip: rk3399: Drop common Kconfig options already implied
>>   rockchip: rk3399-gru: Remove unused nodes from xPL control FDT
>>   rockchip: rk3399-gru: Enable dcache and signature validation in SPL
>>   rockchip: rk3399-gru: Use SDMA mode to read from eMMC
>>   rockchip: rk3399-gru: Include pinctrl and regulators in SPL
>>   rockchip: rk3399: Drop unneeded bob and kevin board specific code
>>
>>  arch/arm/dts/rk3399-gru-u-boot.dtsi    | 29 ++++++++++++++++++++++++--
>>  arch/arm/dts/rk3399-u-boot.dtsi        | 14 +++++++++++--
>>  arch/arm/mach-rockchip/rk3399/Kconfig  | 12 -----------
>>  arch/arm/mach-rockchip/rk3399/rk3399.c | 23 +-------------------
>>  configs/chromebook_bob_defconfig       | 23 ++++++--------------
>>  configs/chromebook_kevin_defconfig     | 23 ++++++--------------
>>  6 files changed, 52 insertions(+), 72 deletions(-)
> 
> Thank you for doing this!
> 
> I'm not sure if you have access to your own denx tree. If so, kevin
> and bob are in the sjg lab. If not, you can sign up at sjg.u-boot.org
> to get access to my tree.

I do not have access to my own tree.

> 
> This series eems to work for me, except for the final commit, which
> hangs with no output.

Strange, guess we can just skip the last patch, should I send a v2
without the last patch?

I wonder if it is not setting io_vsel or the regulators that is causing
an issue. Setting io_vsel is probably delayed until U-Boot proper
instead of being set very early in SPL (due to no IO-domain driver in
SPL), and enable of regulators may happen later in SPL with the last
patch applied.

There is also some code in board/google/gru/gru.c that mention a delay
related to the regulators may be needed, however board_early_init_f() is
never called as following can be found in .config:

  # CONFIG_BOARD_EARLY_INIT_F is not set

Will you be able to test with just the rk_setreg(&grf->io_vsel, 1 << 0);
and remove the spl_gpio_output/set_pull parts of the last patch before I
send a v2?

Regards,
Jonas

> 
> Regards,
> Simon

