Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23755CD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 16:41:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4646A847B0;
	Tue, 26 May 2026 18:41:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="AX5rIwii";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFFC684878; Tue, 26 May 2026 18:41:49 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B9818469F
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 18:41:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4f60=DY=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1779813706;
 bh=uGCjRZJoejIDpv02m35bZGsRNePZL+faFwPcTgDainc=;
 b=AX5rIwii57cpP0U8E3IW42nHQFCph1D4BQujjBUPRuRv+JimttiRC4lv4VbLwT30BSln2Zvqp
 LEGYoFPRZdZQ+RdKwKvyLC97Jh9HOoLprLJz8SzVJdN8aBNLCVFgbQNmm7lJ+gPVb1XmRWbQglh
 9RbjSNlY4g1VrzIiD9E79jj/y5O5pHRCx8VieIYwUeboZ34rb1YvCDXuFQZMMzpbTKw/ULeAznN
 UYbi0v6FP3kme2+K83aDr1YxPB0+eN1L/cO5kW+9GQgg7xHFxH4AZ5JlIsLwqzil+LWM+Mj/PSu
 0uUJh1H7t+np3FM9bvBzL6Nwb//aRL9zsQ4hwm8fjeWA==
X-Forward-Email-ID: 6a15cd48e96c3f6a03c0b6a1
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.8.15
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <b716e806-9d7b-4873-99d4-117ad247dc54@kwiboo.se>
Date: Tue, 26 May 2026 18:41:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 02/18] clk: rockchip: rk3568: Fix probe with
 OF_PLATDATA enabled
To: Pavel Golikov <paullo612@ya.ru>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Yao Zi <me@ziyao.cc>, Finley Xiao <finley.xiao@rock-chips.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20260517-rk3568-raminit-v1-0-a24e16302a13@ya.ru>
 <20260517-rk3568-raminit-v1-2-a24e16302a13@ya.ru>
 <bc4973d8-2b04-4f24-a6bf-62b182a100be@kwiboo.se>
 <20260524193908.GA144447@pgolikov-home-desktop>
 <1b37b5cc-5fe6-4cc6-8eae-cad50a584319@kwiboo.se>
 <20260526151454.GA265884@pgolikov-home-desktop>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260526151454.GA265884@pgolikov-home-desktop>
Content-Type: text/plain; charset=UTF-8
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

Hi Pavel,

On 5/26/2026 5:14 PM, Pavel Golikov wrote:
> Hi Jonas,
> 
> On Tue, May 26, 2026 at 10:17:16AM +0200, Jonas Karlman wrote:
>> Hi Pavel,
>>
>> On 5/24/2026 9:39 PM, Pavel Golikov wrote:
>>> Hi Jonas,
>>>
>>> On Sun, May 24, 2026 at 08:42:33PM +0200, Jonas Karlman wrote:
>>>> Hi Pavel,
>>>>
>>>> On 5/17/2026 9:24 PM, Pavel Golikov wrote:
>>>>> Properly initialize cru address space reference when CONFIG_OF_PLATDATA
>>>>> is enabled.
>>>>
>>>> Do we have to use OF_PLATDATA for TPL to fit into SRAM?
>>>
>>> DRAM driver is heavily based on one for rv1126. rv1126 utilizes OF_PLATDATA,
>>> even though it is 32 bit (with the same amount of SRAM), and 32 bit TPL should
>>> be even smaller.
>>
>> None of the existing Rockchip TPL implementation is very optimized and
>> likely not a good candidate on how optimized DRAM init can be handled :-)
>>
>>>> Also, why do we need CLK driver in TPL? Based on small glance at the
>>>> code it looks like the DPLL was handled by the RAM driver itself.
>>>
>>> I'm getting
>>>
>>> aarch64-linux-gnu-ld: arch/arm/mach-rockchip/rk3568/clk_rk3568.o: in function `rockchip_get_clk':
>>> <...>/build-tpl/../arch/arm/mach-rockchip/rk3568/clk_rk3568.c:14: undefined reference to `_u_boot_list_2_driver_2_rockchip_rk3568_cru'
>>> aarch64-linux-gnu-ld: <...>/build-tpl/../arch/arm/mach-rockchip/rk3568/clk_rk3568.c:14: undefined reference to `_u_boot_list_2_driver_2_rockchip_rk3568_cru'
>>>
>>> when trying to build TPL without CLK (both with OF_PLATDATA and OF_REAL).
>>> rockchip_get_clk is needed by sysreset_rockchip, which, in turn, is always
>>> built for ARCH_ROCKCHIP (sorry).
>>
>> Correct, as I mentioned, there are dependency issues that needs to be
>> resolved, the question remains, does the DRAM init code need to
>> initialize any clocks that is currently handled in the clock driver?
> 
> No, it does not.

Great :-)

>> Or could macros from cru_rk3568.h be used directly in DRAM init code
>> to save on size?
>>
>> Anyway, I have some work-in-progress code [1] that cleanup some of these
>> dependency issues and should allow for a very light TPL.
>>
>>   make generic-rk3568_defconfig rockchip-tpl-lpddr4.config
>>
>> With that I get a ~2 KiB TPL that could be used as a starting ground
>> for a size optimized DRAM init.
> 
> Did a quick rebase on top of your branch here [1]. It works without TPL_DM, but
> requires CFG_SYS_NS16550_CLK and CFG_SYS_NS16550_COM1 definitions to make it
> all buildable.

Yeah, I did a quick run myself and noticed debug uart was not part of
the build, did some more tuning and with TPL_FRAMEWORK=n and some HACK
for TPL_SERIAL_PRESENT=n the resulting binary of ~1600 bytes could run:

  U-Boot TPL 2026.07-rc3-00120-g5e02efad2ee9-dirty (May 26 2026 - 16:13:44)
  DRAM init failed
  Returning to boot ROM...

on RK3568 (and RK3576).

With TPL_FRAMEWORK=n and dropping printf() in tpl.c, tiny-printf could
be avoided to help save some space.

> 46184 vs 37288 bytes for TPL, and no malloc in the image. Impressive.

Impressive!

> But still board_init_f_alloc_reserve(0xfdcd8000). I also wonder why we move
> stack pointer on TPL start, instead of using the stack provided by bootrom.
> I suspect that 0xfdcc0600 - 0xfdcc1000 is a bootrom stack region.

Yeah, 0xfdcd8000 looks like a strange stack addr to use? I tested with
0xfdcd0000 as the stack addr (end of sys sram). We should avoid touching
anything in bootrom stack, since we jump back to bootrom to load next
stage.

> I also noticed that debug_uart_init() is called twice. Once in
> crt0.S/crt0_64.S, and once in board_init_f. Is this behaviour intended?

Great find, I dropped the call in tpl.c and did a re-test on my rk3568
and rk3576 boards, then pushed two new commits to my ci branch that
included the above mentioned tuning. Not happy with the SERIAL_PRESENT
hack, but it could compile and reduced code size ;-)

I will try to cleanup and push out a few patches later this week, after
doing some runtime validation on the other RK SoCs that currently use
TPL.

>> Implement board_debug_uart_init(), sdram_init() and the missing RK3568
>> specific TPL Kconfig options, i.e. TPL_TEXT_BASE etc. and hopefully that
>> should be enough for a size optimized DRAM init.
>>
>> [1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/ci
>>
>> I will rework some of those patches and send to list later this week.
>>
>> Regards,
>> Jonas
>>
>>>
>>> We could actually delegate DPLL to CLK, but there is no API to configure spread
>>> spectrum (although it is disabled by default in loader_params). I also have no
>>> idea of how MSCH clock tree looks like.
>>>
>>> Regards,
>>> Pavel 
>>
> 
> [1] https://github.com/Paullo612/u-boot/tree/ci-rk3568-raminit-rfc-v2

Will take a closer look/review of your patches and do some runtime tests
later.

Regards,
Jonas

> 
> Regards,
> Pavel

