Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6BBCD5BD0
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 21:07:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4121847C4;
	Wed, 27 May 2026 23:07:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="XkfKPLp1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D75B84837; Wed, 27 May 2026 23:07:05 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0DCD84704
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 23:07:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=cb24=DZ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1779916019;
 bh=OFlU4bbIeLKVr0QB33gB2uRlA3JxyG4mYKGFeOEfCnU=;
 b=XkfKPLp10Rdw6q/gPvaIwN7TPTvStFfBGzEKa5LJpao8Uh9Uk60jPNp/LHU6hMvQqgRAt9J0U
 3SPBo+k35KlcPkbNHrBfHtnNIYmSLjQJzrPyMILvnn7DT4JJZPMb+UnWX87zRXHeNd0snsa5gFb
 0sTC6+teIgXQWBuDXDDjvBvYwavKD9hlPMgpl98IQegu1gK3bW8JeoeYMbZRQgdzZiAR8ecJp+5
 ye3Ko90Uq66xfJBdHkVdPXcegvPaKkZoue1pVdPArhOnJ/Vz/QNa0LQ7nFGZrMt75s2zaEbohnq
 yDOEARF4KKqD2EWHsllT5cn1Y0INJ+56WA7BlmsaGPmQ==
X-Forward-Email-ID: 6a175cefdc926995d029005b
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.8.15
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <6a7510ba-23ed-4b49-bbe0-28902220df94@kwiboo.se>
Date: Wed, 27 May 2026 23:06:51 +0200
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
 <b716e806-9d7b-4873-99d4-117ad247dc54@kwiboo.se>
 <20260526175952.GA340716@pgolikov-home-desktop>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260526175952.GA340716@pgolikov-home-desktop>
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

On 5/26/2026 7:59 PM, Pavel Golikov wrote:
> Hi Jonas,
> 
> On Tue, May 26, 2026 at 06:41:39PM +0200, Jonas Karlman wrote:
>> Hi Pavel,
>>
>> On 5/26/2026 5:14 PM, Pavel Golikov wrote:
>>> Hi Jonas,
>>>
>>> On Tue, May 26, 2026 at 10:17:16AM +0200, Jonas Karlman wrote:
>>>> Hi Pavel,
>>>>
>>>> On 5/24/2026 9:39 PM, Pavel Golikov wrote:
>>>>> Hi Jonas,
>>>>>
>>>>> On Sun, May 24, 2026 at 08:42:33PM +0200, Jonas Karlman wrote:
>>>>>> Hi Pavel,
>>>>>>
>>>>>> On 5/17/2026 9:24 PM, Pavel Golikov wrote:
>>>>>>> Properly initialize cru address space reference when CONFIG_OF_PLATDATA
>>>>>>> is enabled.
>>>>>>
>>>>>> Do we have to use OF_PLATDATA for TPL to fit into SRAM?
>>>>>
>>>>> DRAM driver is heavily based on one for rv1126. rv1126 utilizes OF_PLATDATA,
>>>>> even though it is 32 bit (with the same amount of SRAM), and 32 bit TPL should
>>>>> be even smaller.
>>>>
>>>> None of the existing Rockchip TPL implementation is very optimized and
>>>> likely not a good candidate on how optimized DRAM init can be handled :-)
>>>>
>>>>>> Also, why do we need CLK driver in TPL? Based on small glance at the
>>>>>> code it looks like the DPLL was handled by the RAM driver itself.
>>>>>
>>>>> I'm getting
>>>>>
>>>>> aarch64-linux-gnu-ld: arch/arm/mach-rockchip/rk3568/clk_rk3568.o: in function `rockchip_get_clk':
>>>>> <...>/build-tpl/../arch/arm/mach-rockchip/rk3568/clk_rk3568.c:14: undefined reference to `_u_boot_list_2_driver_2_rockchip_rk3568_cru'
>>>>> aarch64-linux-gnu-ld: <...>/build-tpl/../arch/arm/mach-rockchip/rk3568/clk_rk3568.c:14: undefined reference to `_u_boot_list_2_driver_2_rockchip_rk3568_cru'
>>>>>
>>>>> when trying to build TPL without CLK (both with OF_PLATDATA and OF_REAL).
>>>>> rockchip_get_clk is needed by sysreset_rockchip, which, in turn, is always
>>>>> built for ARCH_ROCKCHIP (sorry).
>>>>
>>>> Correct, as I mentioned, there are dependency issues that needs to be
>>>> resolved, the question remains, does the DRAM init code need to
>>>> initialize any clocks that is currently handled in the clock driver?
>>>
>>> No, it does not.
>>
>> Great :-)
>>
>>>> Or could macros from cru_rk3568.h be used directly in DRAM init code
>>>> to save on size?
>>>>
>>>> Anyway, I have some work-in-progress code [1] that cleanup some of these
>>>> dependency issues and should allow for a very light TPL.
>>>>
>>>>   make generic-rk3568_defconfig rockchip-tpl-lpddr4.config
>>>>
>>>> With that I get a ~2 KiB TPL that could be used as a starting ground
>>>> for a size optimized DRAM init.
>>>
>>> Did a quick rebase on top of your branch here [1]. It works without TPL_DM, but
>>> requires CFG_SYS_NS16550_CLK and CFG_SYS_NS16550_COM1 definitions to make it
>>> all buildable.
>>
>> Yeah, I did a quick run myself and noticed debug uart was not part of
>> the build, did some more tuning and with TPL_FRAMEWORK=n and some HACK
>> for TPL_SERIAL_PRESENT=n the resulting binary of ~1600 bytes could run:
>>
>>   U-Boot TPL 2026.07-rc3-00120-g5e02efad2ee9-dirty (May 26 2026 - 16:13:44)
>>   DRAM init failed
>>   Returning to boot ROM...
>>
>> on RK3568 (and RK3576).
>>
>> With TPL_FRAMEWORK=n and dropping printf() in tpl.c, tiny-printf could
>> be avoided to help save some space.
>>
>>> 46184 vs 37288 bytes for TPL, and no malloc in the image. Impressive.
>>
>> Impressive!
>>
>>> But still board_init_f_alloc_reserve(0xfdcd8000). I also wonder why we move
>>> stack pointer on TPL start, instead of using the stack provided by bootrom.
>>> I suspect that 0xfdcc0600 - 0xfdcc1000 is a bootrom stack region.
>>
>> Yeah, 0xfdcd8000 looks like a strange stack addr to use? I tested with
>> 0xfdcd0000 as the stack addr (end of sys sram). We should avoid touching
>> anything in bootrom stack, since we jump back to bootrom to load next
>> stage.
> 
> As strange as rv1126. It also places its stack somwhere in undocumented memory
> region.

That sounds very weird, do not think I have any rv1126 device, so cannot
do any runtime tests on that SoC myself.

> I'm talking about something like
> 
> diff --git a/arch/arm/lib/crt0_64.S b/arch/arm/lib/crt0_64.S
> index 3e7627aa389..ec4df0e57b5 100644
> --- a/arch/arm/lib/crt0_64.S
> +++ b/arch/arm/lib/crt0_64.S
> @@ -70,7 +70,7 @@ ENTRY(_main)
>   * Set up initial C runtime environment and call board_init_f(0).
>   */
>  #if CONFIG_IS_ENABLED(HAVE_INIT_STACK)
> -	ldr	x0, =CONFIG_VAL(STACK)
> +	mov	x0, sp
>  #elif defined(CONFIG_INIT_SP_RELATIVE)
>  #if CONFIG_POSITION_INDEPENDENT
>  	adrp	x0, __bss_start     /* x0 <- Runtime &__bss_start */
> diff --git a/arch/arm/mach-rockchip/rk3568/Kconfig b/arch/arm/mach-rockchip/rk3568/Kconfig
> index 893185291d8..86eddf01b03 100644
> --- a/arch/arm/mach-rockchip/rk3568/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3568/Kconfig
> @@ -78,10 +78,10 @@ config TPL_LDSCRIPT
>  	default "arch/arm/mach-rockchip/u-boot-tpl-v8.lds"
>  
>  config TPL_STACK
> -	default 0xfdcd8000
> +	default 0xcafebabe
>  
>  config TPL_SYS_MALLOC_F_LEN
> -	default 0x2000
> +	default 0x1
>  
>  config TPL_TEXT_BASE
>  	default 0xfdcc1000
> diff --git a/arch/arm/mach-rockchip/tpl.c b/arch/arm/mach-rockchip/tpl.c
> index 2eb72dfdd20..235ff6e5268 100644
> --- a/arch/arm/mach-rockchip/tpl.c
> +++ b/arch/arm/mach-rockchip/tpl.c
> @@ -42,6 +42,9 @@ void board_init_f(ulong dummy)
>  	 * printascii("string");
>  	 */
>  	debug_uart_init();
> +
> +	char buffer[16];
> +	printf("Our stack: %x", (uint32_t)(void *)buffer);
>  #ifdef CONFIG_TPL_BANNER_PRINT
>  	printascii("\nU-Boot TPL " PLAIN_VERSION " (" U_BOOT_DATE " - " \
>  				U_BOOT_TIME ")\n");
> 
> DRAM init still works with this applied. And I'm getting
> 
> Our stack: fdcc0e10
> U-Boot TPL 2026.07-rc3-ge39964c734f3-dirty (May 26 2026 - 20:53:34)
> ...
> 
> So, bootrom calls us with valid stack pointer, and there is a little sence in
> moving the stack anywhere if we fit into it. 0x110 bytes on the stack is taken
> by struct global_data.

I still think it is best to use our own stack and leave the brom stack
as-is for when we eventually longjmp back to brom. We never know what
Kconfig options end users try to enable, some of them could require a
larger stack or could potentially corrupt some internal state for brom.

Btw, I continued to shave off a few bytes and started to split some of
the changes into separate commits as a preparation for a proper series.

Using my latest force-push ci-branch, a skeleton TPL that call dram init
and then go back to BootROM to load next image take up around:

  TPL_SERIAL=n, LTO=y:   848 bytes
  TPL_SERIAL=n, LTO=n:   904 bytes
  TPL_SERIAL=y, LTO=y:  1256 bytes
  TPL_SERIAL=y, LTO=n:  1368 bytes

Will validate on older RK SoCs that these changes do not brake anything,
and then start sending some of the changes to the list, likely later
this weekend.

Regards,
Jonas

> 
>>> I also noticed that debug_uart_init() is called twice. Once in
>>> crt0.S/crt0_64.S, and once in board_init_f. Is this behaviour intended?
>>
>> Great find, I dropped the call in tpl.c and did a re-test on my rk3568
>> and rk3576 boards, then pushed two new commits to my ci branch that
>> included the above mentioned tuning. Not happy with the SERIAL_PRESENT
>> hack, but it could compile and reduced code size ;-)
>>
>> I will try to cleanup and push out a few patches later this week, after
>> doing some runtime validation on the other RK SoCs that currently use
>> TPL.
>>
>>>> Implement board_debug_uart_init(), sdram_init() and the missing RK3568
>>>> specific TPL Kconfig options, i.e. TPL_TEXT_BASE etc. and hopefully that
>>>> should be enough for a size optimized DRAM init.
>>>>
>>>> [1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/ci
>>>>
>>>> I will rework some of those patches and send to list later this week.
>>>>
>>>> Regards,
>>>> Jonas
>>>>
>>>>>
>>>>> We could actually delegate DPLL to CLK, but there is no API to configure spread
>>>>> spectrum (although it is disabled by default in loader_params). I also have no
>>>>> idea of how MSCH clock tree looks like.
>>>>>
>>>>> Regards,
>>>>> Pavel 
>>>>
>>>
>>> [1] https://github.com/Paullo612/u-boot/tree/ci-rk3568-raminit-rfc-v2
>>
>> Will take a closer look/review of your patches and do some runtime tests
>> later.
>>
>> Regards,
>> Jonas
>>
>>>
>>> Regards,
>>> Pavel
>>
> 
> Regards,
> Pavel

