Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9179C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 22:40:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCA318880B;
	Thu,  1 Aug 2024 00:40:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="OtUFntPd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F23668897F; Thu,  1 Aug 2024 00:40:32 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 733708869E
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 00:40:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=72bb=PA=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1722465617;
 bh=2PTuBY2zidHegV6a7ewinS1WLdhuXiQoHntedO3lQ74=;
 b=OtUFntPdMGkyYhf0bzPP11HjzeNPQpL1RKsIHRrhwdKbIHzqJLqqtlV1Yj272QsyMevDR+5Ih
 Cqx3HmvVX2130OE4aHgEiHbOA3JMVlRxaKxj1Le0Xl47Hp9SNCJ9uZqph+IG6mJ+GI0Xanxldxt
 otHwRRtWcN9Ei70gI1g19TnqT3WcbXbCLfbsn/q5RwJZl173iMAf0H5UX1nrlk2zGu8PNGUkUUY
 m4Sig0H+qiuMjLnlX1IOosIsS2AckvGcH0e3hYDbSzXrTUGeFVta3EM6sFs9PMu4rSwS8mEojsA
 0FWD9f8NmDW6JLa28MNTA9jGFtRfCZUacJZaWJBUK7sg==
Message-ID: <e08fb2d4-a5a3-4fa5-8abe-ac9391311d60@kwiboo.se>
Date: Thu, 1 Aug 2024 00:40:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 8/8] rockchip: Avoid #ifdefs in RK3399 SPL
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, huang lin <hl@rock-chips.com>, "U-Boot Mailing
 List" <u-boot@lists.denx.de>
References: <20240731144908.795290-1-sjg@chromium.org>
 <20240731144908.795290-9-sjg@chromium.org>
 <d77dd5c5-37fc-4743-9f3d-3ef88eabb07f@kwiboo.se>
 <CAFLszTgNAvfC=SdfTYtWtbXEc9FOkOvR-1cKDrQHgzamBCiPFg@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAFLszTgNAvfC=SdfTYtWtbXEc9FOkOvR-1cKDrQHgzamBCiPFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66aabd4f06984f15edfbdbb7
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

On 2024-07-31 23:52, Simon Glass wrote:
> Hi Jonas,
> 
> On Wed, 31 Jul 2024 at 09:03, Jonas Karlman <jonas@kwiboo.se> wrote:
>>
>> Hi Simon,
>>
>> On 2024-07-31 16:49, Simon Glass wrote:
>>> The code here is confusing due to large blocks which are #ifdefed out.
>>> Add a function phase_sdram_init() which returns whether SDRAM init
>>> should happen in the current phase, using that as needed to control the
>>> code flow.
>>>
>>> This increases code size by about 500 bytes in SPL when the cache is on,
>>> since it must call the rather large rockchip_sdram_size() function.
>>
>> I am guessing this size increase only is related to kevin/bob since all
>> other RK3399 boards already use rockchip_sdram_size() in SPL.
> 
> That's not what I am seeing:

Ahh, this is adding the rockchip_sdram_size() call to TPL for all other
RK3399 boards that has no need for it, hence the size increase on all
other boards beside bob and kevin.

This should be adjusted to only be called in SPL, as there is no point
for it to be called/used in TPL, in TPL we only initialize DRAM, write
the DRAM size to the os reg and finally jump back to BROM to load next
stage, SPL.

Regards,
Jonas

> 
> buildman -b bugs8 rk3399 -sS
> Summary of 9 commits for 29 boards (29 threads, 2 jobs per thread)
> 01: Merge patch series "led: implement software blinking"
>    aarch64:  w+   roc-pc-mezzanine-rk3399 roc-pc-rk3399 chromebook_bob
> chromebook_kevin pinebook-pro-rk3399 pinephone-pro-rk3399
> rockpro64-rk3399 rock-4c-plus-rk3399 rock-4se-rk3399 rock-pi-4-rk3399
> rock-pi-4c-rk3399 eaidk-610-rk3399 evb-rk3399 firefly-rk3399
> khadas-edge-captain-rk3399 khadas-edge-rk3399 khadas-edge-v-rk3399
> leez-rk3399 nanopc-t4-rk3399 nanopi-m4-2gb-rk3399 nanopi-m4-rk3399
> nanopi-m4b-rk3399 nanopi-neo4-rk3399 nanopi-r4s-rk3399 orangepi-rk3399
> rock-pi-n10-rk3399pro puma-rk3399 ficus-rk3399 rock960-rk3399
> 02: mkeficapsule: Add a --version argument
> 03: binman: Collect the version number for mkeficapsule
> 04: binman: Deal with mkeficapsule being missing
> 05: binman: Return failure when a usage() message is generated
> 06: binman: Keep the efi_capsule input file
> 07: fdt: Correct condition for bloblist existing
> 08: rockchip: Ensure memory size is available in RK3399 SPL
>    aarch64: (for 29/29 boards) spl/u-boot-spl:all +33.1
> spl/u-boot-spl:text +33.1 tpl/u-boot-tpl:all +446.9
> tpl/u-boot-tpl:text +446.9
> 09: rockchip: Avoid #ifdefs in RK3399 SPL
>    aarch64: (for 29/29 boards) all +69.2 bss +5.2 spl/u-boot-spl:all
> +24.0 spl/u-boot-spl:text +24.0 text +64.0 tpl/u-boot-tpl:all +21.5
> tpl/u-boot-tpl:text +21.5
> ✔ ~/u [bugs8 ↓·18↑·8|…2⚑ 1001]
> 15:48 $ buildman -b bugs8 rk3399 -sSB
> Summary of 9 commits for 29 boards (29 threads, 2 jobs per thread)
> 01: Merge patch series "led: implement software blinking"
>    aarch64:  w+   roc-pc-mezzanine-rk3399 roc-pc-rk3399 chromebook_bob
> chromebook_kevin pinebook-pro-rk3399 pinephone-pro-rk3399
> rockpro64-rk3399 rock-4c-plus-rk3399 rock-4se-rk3399 rock-pi-4-rk3399
> rock-pi-4c-rk3399 eaidk-610-rk3399 evb-rk3399 firefly-rk3399
> khadas-edge-captain-rk3399 khadas-edge-rk3399 khadas-edge-v-rk3399
> leez-rk3399 nanopc-t4-rk3399 nanopi-m4-2gb-rk3399 nanopi-m4-rk3399
> nanopi-m4b-rk3399 nanopi-neo4-rk3399 nanopi-r4s-rk3399 orangepi-rk3399
> rock-pi-n10-rk3399pro puma-rk3399 ficus-rk3399 rock960-rk3399
> 02: mkeficapsule: Add a --version argument
> 03: binman: Collect the version number for mkeficapsule
> 04: binman: Deal with mkeficapsule being missing
> 05: binman: Return failure when a usage() message is generated
> 06: binman: Keep the efi_capsule input file
> 07: fdt: Correct condition for bloblist existing
> 08: rockchip: Ensure memory size is available in RK3399 SPL
>    aarch64: (for 29/29 boards) spl/u-boot-spl:all +33.1
> spl/u-boot-spl:text +33.1 tpl/u-boot-tpl:all +446.9
> tpl/u-boot-tpl:text +446.9
>             roc-pc-mezzanine-rk3399: tpl/u-boot-tpl:all +480
> tpl/u-boot-tpl:text +480
>                tpl-u-boot-tpl: add: 1/0, grow: 1/0 bytes: 480/0 (480)
>                  function                                   old     new   delta
>                  rockchip_sdram_size                          -     432    +432
>                  rk3399_dmc_probe                          4120    4168     +48
>             roc-pc-rk3399  : tpl/u-boot-tpl:all +480 tpl/u-boot-tpl:text +480
>                tpl-u-boot-tpl: add: 1/0, grow: 1/0 bytes: 480/0 (480)
>                  function                                   old     new   delta
>                  rockchip_sdram_size                          -     432    +432
>                  rk3399_dmc_probe                          4120    4168     +48
>             chromebook_bob : spl/u-boot-spl:all +480 spl/u-boot-spl:text +480
>                spl-u-boot-spl: add: 1/0, grow: 1/0 bytes: 480/0 (480)
>                  function                                   old     new   delta
>                  rockchip_sdram_size                          -     432    +432
>                  rk3399_dmc_probe                          4304    4352     +48
>             chromebook_kevin: spl/u-boot-spl:all +480 spl/u-boot-spl:text +480
>                spl-u-boot-spl: add: 1/0, grow: 1/0 bytes: 480/0 (480)
>                  function                                   old     new   delta
>                  rockchip_sdram_size                          -     432    +432
>                  rk3399_dmc_probe                          4304    4352     +48
>             pinebook-pro-rk3399: tpl/u-boot-tpl:all +480
> tpl/u-boot-tpl:text +480
>                tpl-u-boot-tpl: add: 1/0, grow: 1/0 bytes: 480/0 (480)
>                  function                                   old     new   delta
>                  rockchip_sdram_size                          -     432    +432
>                  rk3399_dmc_probe                          4164    4212     +48
>             pinephone-pro-rk3399: tpl/u-boot-tpl:all +480
> tpl/u-boot-tpl:text +480
>                tpl-u-boot-tpl: add: 1/0, grow: 1/0 bytes: 480/0 (480)
>                  function                                   old     new   delta
>                  rockchip_sdram_size                          -     432    +432
>                  rk3399_dmc_probe                          4164    4212     +48
>             rockpro64-rk3399: tpl/u-boot-tpl:all +480 tpl/u-boot-tpl:text +480
>                tpl-u-boot-tpl: add: 1/0, grow: 1/0 bytes: 480/0 (480)
>                  function                                   old     new   delta
>                  rockchip_sdram_size                          -     432    +432
>                  rk3399_dmc_probe                          4164    4212     +48
>             rock-4c-plus-rk3399: tpl/u-boot-tpl:all +480
> tpl/u-boot-tpl:text +480
>                tpl-u-boot-tpl: add: 1/0, grow: 1/0 bytes: 480/0 (480)
>                  function                                   old     new   delta
>                  rockchip_sdram_size                          -     432    +432
>                  rk3399_dmc_probe                          4164    4212     +48
>             rock-4se-rk3399: tpl/u-boot-tpl:all +480 tpl/u-boot-tpl:text +480
>                tpl-u-boot-tpl: add: 1/0, grow: 1/0 bytes: 480/0 (480)
>                  function                                   old     new   delta
>                  rockchip_sdram_size                          -     432    +432
>                  rk3399_dmc_probe                          4164    4212     +48
>             rock-pi-4-rk3399: tpl/u-boot-tpl:all +480 tpl/u-boot-tpl:text +480
>                tpl-u-boot-tpl: add: 1/0, grow: 1/0 bytes: 480/0 (480)
>                  function                                   old     new   delta
>                  rockchip_sdram_size                          -     432    +432
>                  rk3399_dmc_probe                          4164    4212     +48
>             rock-pi-4c-rk3399: tpl/u-boot-tpl:all +480 tpl/u-boot-tpl:text +480
>                tpl-u-boot-tpl: add: 1/0, grow: 1/0 bytes: 480/0 (480)
>                  function                                   old     new   delta
>                  rockchip_sdram_size                          -     432    +432
>                  rk3399_dmc_probe                          4164    4212     +48
>             eaidk-610-rk3399: tpl/u-boot-tpl:all +480 tpl/u-boot-tpl:text +480
>                tpl-u-boot-tpl: add: 1/0, grow: 1/0 bytes: 480/0 (480)
>                  function                                   old     new   delta
>                  rockchip_sdram_size                          -     432    +432
>                  rk3399_dmc_probe                          4304    4352     +48
>             evb-rk3399     : tpl/u-boot-tpl:all +480 tpl/u-boot-tpl:text +480
>                tpl-u-boot-tpl: add: 1/0, grow: 1/0 bytes: 480/0 (480)
>                  function                                   old     new   delta
>                  rockchip_sdram_size                          -     432    +432
>                  rk3399_dmc_probe                          4304    4352     +48
>             firefly-rk3399 : tpl/u-boot-tpl:all +480 tpl/u-boot-tpl:text +480
>                tpl-u-boot-tpl: add: 1/0, grow: 1/0 bytes: 480/0 (480)
>                  function                                   old     new   delta
>                  rockchip_sdram_size                          -     432    +432
>                  rk3399_dmc_probe                          4304    4352     +48
>             khadas-edge-captain-rk3399: tpl/u-boot-tpl:all +480
> tpl/u-boot-tpl:text +480
>                tpl-u-boot-tpl: add: 1/0, grow: 1/0 bytes: 480/0 (480)
>                  function                                   old     new   delta
>                  rockchip_sdram_size                          -     432    +432
>                  rk3399_dmc_probe                          4164    4212     +48
>             khadas-edge-rk3399: tpl/u-boot-tpl:all +480 tpl/u-boot-tpl:text +480
>                tpl-u-boot-tpl: add: 1/0, grow: 1/0 bytes: 480/0 (480)
>                  function                                   old     new   delta
>                  rockchip_sdram_size                          -     432    +432
>                  rk3399_dmc_probe                          4164    4212     +48
>             khadas-edge-v-rk3399: tpl/u-boot-tpl:all +480
> tpl/u-boot-tpl:text +480
>                tpl-u-boot-tpl: add: 1/0, grow: 1/0 bytes: 480/0 (480)
>                  function                                   old     new   delta
>                  rockchip_sdram_size                          -     432    +432
>                  rk3399_dmc_probe                          4164    4212     +48
>             leez-rk3399    : tpl/u-boot-tpl:all +480 tpl/u-boot-tpl:text +480
>                tpl-u-boot-tpl: add: 1/0, grow: 1/0 bytes: 480/0 (480)
>                  function                                   old     new   delta
>                  rockchip_sdram_size                          -     432    +432
>                  rk3399_dmc_probe                          4164    4212     +48
>             nanopc-t4-rk3399: tpl/u-boot-tpl:all +480 tpl/u-boot-tpl:text +480
>                tpl-u-boot-tpl: add: 1/0, grow: 1/0 bytes: 480/0 (480)
>                  function                                   old     new   delta
>                  rockchip_sdram_size                          -     432    +432
>                  rk3399_dmc_probe                          4304    4352     +48
>             nanopi-m4-2gb-rk3399: tpl/u-boot-tpl:all +480
> tpl/u-boot-tpl:text +480
>                tpl-u-boot-tpl: add: 1/0, grow: 1/0 bytes: 480/0 (480)
>                  function                                   old     new   delta
>                  rockchip_sdram_size                          -     432    +432
>                  rk3399_dmc_probe                          4304    4352     +48
>             nanopi-m4-rk3399: tpl/u-boot-tpl:all +480 tpl/u-boot-tpl:text +480
>                tpl-u-boot-tpl: add: 1/0, grow: 1/0 bytes: 480/0 (480)
>                  function                                   old     new   delta
>                  rockchip_sdram_size                          -     432    +432
>                  rk3399_dmc_probe                          4304    4352     +48
>             nanopi-m4b-rk3399: tpl/u-boot-tpl:all +480 tpl/u-boot-tpl:text +480
>                tpl-u-boot-tpl: add: 1/0, grow: 1/0 bytes: 480/0 (480)
>                  function                                   old     new   delta
>                  rockchip_sdram_size                          -     432    +432
>                  rk3399_dmc_probe                          4304    4352     +48
>             nanopi-neo4-rk3399: tpl/u-boot-tpl:all +480 tpl/u-boot-tpl:text +480
>                tpl-u-boot-tpl: add: 1/0, grow: 1/0 bytes: 480/0 (480)
>                  function                                   old     new   delta
>                  rockchip_sdram_size                          -     432    +432
>                  rk3399_dmc_probe                          4304    4352     +48
>             nanopi-r4s-rk3399: tpl/u-boot-tpl:all +480 tpl/u-boot-tpl:text +480
>                tpl-u-boot-tpl: add: 1/0, grow: 1/0 bytes: 480/0 (480)
>                  function                                   old     new   delta
>                  rockchip_sdram_size                          -     432    +432
>                  rk3399_dmc_probe                          4164    4212     +48
>             orangepi-rk3399: tpl/u-boot-tpl:all +480 tpl/u-boot-tpl:text +480
>                tpl-u-boot-tpl: add: 1/0, grow: 1/0 bytes: 480/0 (480)
>                  function                                   old     new   delta
>                  rockchip_sdram_size                          -     432    +432
>                  rk3399_dmc_probe                          4304    4352     +48
>             rock-pi-n10-rk3399pro: tpl/u-boot-tpl:all +480
> tpl/u-boot-tpl:text +480
>                tpl-u-boot-tpl: add: 1/0, grow: 1/0 bytes: 480/0 (480)
>                  function                                   old     new   delta
>                  rockchip_sdram_size                          -     432    +432
>                  rk3399_dmc_probe                          4248    4296     +48
>             puma-rk3399    : tpl/u-boot-tpl:all +480 tpl/u-boot-tpl:text +480
>                tpl-u-boot-tpl: add: 1/0, grow: 1/0 bytes: 480/0 (480)
>                  function                                   old     new   delta
>                  rockchip_sdram_size                          -     432    +432
>                  rk3399_dmc_probe                          4304    4352     +48
>             ficus-rk3399   : tpl/u-boot-tpl:all +480 tpl/u-boot-tpl:text +480
>                tpl-u-boot-tpl: add: 1/0, grow: 1/0 bytes: 480/0 (480)
>                  function                                   old     new   delta
>                  rockchip_sdram_size                          -     432    +432
>                  rk3399_dmc_probe                          4304    4352     +48
>             rock960-rk3399 : tpl/u-boot-tpl:all +480 tpl/u-boot-tpl:text +480
>                tpl-u-boot-tpl: add: 1/0, grow: 1/0 bytes: 480/0 (480)
>                  function                                   old     new   delta
>                  rockchip_sdram_size                          -     432    +432
>                  rk3399_dmc_probe                          4304    4352     +48
> 09: rockchip: Avoid #ifdefs in RK3399 SPL
>    aarch64: (for 29/29 boards) all +69.2 bss +5.2 spl/u-boot-spl:all
> +24.0 spl/u-boot-spl:text +24.0 text +64.0 tpl/u-boot-tpl:all +21.5
> tpl/u-boot-tpl:text +21.5
>             rock-4c-plus-rk3399: all +120 bss +56 spl/u-boot-spl:all
> +24 spl/u-boot-spl:text +24 text +64 tpl/u-boot-tpl:all +24
> tpl/u-boot-tpl:text +24
>                tpl-u-boot-tpl: add: 0/0, grow: 1/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_probe                          4212    4236     +24
>                u-boot: add: 1/0, grow: 1/0 bytes: 40/0 (40)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      32     +32
>                  rk3399_dmc_probe                            64      72      +8
>                spl-u-boot-spl: add: 1/0, grow: 0/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      24     +24
>             nanopc-t4-rk3399: all +120 bss +56 spl/u-boot-spl:all +24
> spl/u-boot-spl:text +24 text +64 tpl/u-boot-tpl:all +24
> tpl/u-boot-tpl:text +24
>                tpl-u-boot-tpl: add: 0/0, grow: 1/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_probe                          4352    4376     +24
>                u-boot: add: 1/0, grow: 1/0 bytes: 40/0 (40)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      32     +32
>                  rk3399_dmc_probe                            64      72      +8
>                spl-u-boot-spl: add: 1/0, grow: 0/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      24     +24
>             nanopi-r4s-rk3399: all +120 bss +56 spl/u-boot-spl:all +24
> spl/u-boot-spl:text +24 text +64 tpl/u-boot-tpl:all +24
> tpl/u-boot-tpl:text +24
>                tpl-u-boot-tpl: add: 0/0, grow: 1/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_probe                          4212    4236     +24
>                u-boot: add: 1/0, grow: 1/0 bytes: 40/0 (40)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      32     +32
>                  rk3399_dmc_probe                            64      72      +8
>                spl-u-boot-spl: add: 1/0, grow: 0/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      24     +24
>             rockpro64-rk3399: all +72 bss +8 spl/u-boot-spl:all +24
> spl/u-boot-spl:text +24 text +64 tpl/u-boot-tpl:all +24
> tpl/u-boot-tpl:text +24
>                tpl-u-boot-tpl: add: 0/0, grow: 1/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_probe                          4212    4236     +24
>                u-boot: add: 1/0, grow: 1/0 bytes: 40/0 (40)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      32     +32
>                  rk3399_dmc_probe                            64      72      +8
>                spl-u-boot-spl: add: 1/0, grow: 0/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      24     +24
>             nanopi-m4-2gb-rk3399: all +72 bss +8 spl/u-boot-spl:all
> +24 spl/u-boot-spl:text +24 text +64 tpl/u-boot-tpl:all +24
> tpl/u-boot-tpl:text +24
>                tpl-u-boot-tpl: add: 0/0, grow: 1/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_probe                          4352    4376     +24
>                u-boot: add: 1/0, grow: 1/0 bytes: 40/0 (40)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      32     +32
>                  rk3399_dmc_probe                            64      72      +8
>                spl-u-boot-spl: add: 1/0, grow: 0/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      24     +24
>             nanopi-m4-rk3399: all +72 bss +8 spl/u-boot-spl:all +24
> spl/u-boot-spl:text +24 text +64 tpl/u-boot-tpl:all +24
> tpl/u-boot-tpl:text +24
>                tpl-u-boot-tpl: add: 0/0, grow: 1/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_probe                          4352    4376     +24
>                u-boot: add: 1/0, grow: 1/0 bytes: 40/0 (40)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      32     +32
>                  rk3399_dmc_probe                            64      72      +8
>                spl-u-boot-spl: add: 1/0, grow: 0/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      24     +24
>             nanopi-m4b-rk3399: all +72 bss +8 spl/u-boot-spl:all +24
> spl/u-boot-spl:text +24 text +64 tpl/u-boot-tpl:all +24
> tpl/u-boot-tpl:text +24
>                tpl-u-boot-tpl: add: 0/0, grow: 1/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_probe                          4352    4376     +24
>                u-boot: add: 1/0, grow: 1/0 bytes: 40/0 (40)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      32     +32
>                  rk3399_dmc_probe                            64      72      +8
>                spl-u-boot-spl: add: 1/0, grow: 0/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      24     +24
>             puma-rk3399    : all +72 bss +8 spl/u-boot-spl:all +24
> spl/u-boot-spl:text +24 text +64 tpl/u-boot-tpl:all +24
> tpl/u-boot-tpl:text +24
>                tpl-u-boot-tpl: add: 0/0, grow: 1/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_probe                          4352    4376     +24
>                u-boot: add: 1/0, grow: 1/0 bytes: 40/0 (40)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      32     +32
>                  rk3399_dmc_probe                            64      72      +8
>                spl-u-boot-spl: add: 1/0, grow: 0/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      24     +24
>             eaidk-610-rk3399: all +64 spl/u-boot-spl:all +24
> spl/u-boot-spl:text +24 text +64 tpl/u-boot-tpl:all +24
> tpl/u-boot-tpl:text +24
>                tpl-u-boot-tpl: add: 0/0, grow: 1/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_probe                          4352    4376     +24
>                u-boot: add: 1/0, grow: 1/0 bytes: 40/0 (40)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      32     +32
>                  rk3399_dmc_probe                            64      72      +8
>                spl-u-boot-spl: add: 1/0, grow: 0/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      24     +24
>             firefly-rk3399 : all +64 spl/u-boot-spl:all +24
> spl/u-boot-spl:text +24 text +64 tpl/u-boot-tpl:all +24
> tpl/u-boot-tpl:text +24
>                tpl-u-boot-tpl: add: 0/0, grow: 1/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_probe                          4352    4376     +24
>                u-boot: add: 1/0, grow: 1/0 bytes: 40/0 (40)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      32     +32
>                  rk3399_dmc_probe                            64      72      +8
>                spl-u-boot-spl: add: 1/0, grow: 0/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      24     +24
>             khadas-edge-captain-rk3399: all +64 spl/u-boot-spl:all +24
> spl/u-boot-spl:text +24 text +64 tpl/u-boot-tpl:all +24
> tpl/u-boot-tpl:text +24
>                tpl-u-boot-tpl: add: 0/0, grow: 1/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_probe                          4212    4236     +24
>                u-boot: add: 1/0, grow: 1/0 bytes: 40/0 (40)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      32     +32
>                  rk3399_dmc_probe                            64      72      +8
>                spl-u-boot-spl: add: 1/0, grow: 0/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      24     +24
>             khadas-edge-rk3399: all +64 spl/u-boot-spl:all +24
> spl/u-boot-spl:text +24 text +64 tpl/u-boot-tpl:all +24
> tpl/u-boot-tpl:text +24
>                tpl-u-boot-tpl: add: 0/0, grow: 1/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_probe                          4212    4236     +24
>                u-boot: add: 1/0, grow: 1/0 bytes: 40/0 (40)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      32     +32
>                  rk3399_dmc_probe                            64      72      +8
>                spl-u-boot-spl: add: 1/0, grow: 0/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      24     +24
>             khadas-edge-v-rk3399: all +64 spl/u-boot-spl:all +24
> spl/u-boot-spl:text +24 text +64 tpl/u-boot-tpl:all +24
> tpl/u-boot-tpl:text +24
>                tpl-u-boot-tpl: add: 0/0, grow: 1/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_probe                          4212    4236     +24
>                u-boot: add: 1/0, grow: 1/0 bytes: 40/0 (40)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      32     +32
>                  rk3399_dmc_probe                            64      72      +8
>                spl-u-boot-spl: add: 1/0, grow: 0/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      24     +24
>             leez-rk3399    : all +64 spl/u-boot-spl:all +24
> spl/u-boot-spl:text +24 text +64 tpl/u-boot-tpl:all +24
> tpl/u-boot-tpl:text +24
>                tpl-u-boot-tpl: add: 0/0, grow: 1/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_probe                          4212    4236     +24
>                u-boot: add: 1/0, grow: 1/0 bytes: 40/0 (40)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      32     +32
>                  rk3399_dmc_probe                            64      72      +8
>                spl-u-boot-spl: add: 1/0, grow: 0/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      24     +24
>             orangepi-rk3399: all +64 spl/u-boot-spl:all +24
> spl/u-boot-spl:text +24 text +64 tpl/u-boot-tpl:all +24
> tpl/u-boot-tpl:text +24
>                tpl-u-boot-tpl: add: 0/0, grow: 1/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_probe                          4352    4376     +24
>                u-boot: add: 1/0, grow: 1/0 bytes: 40/0 (40)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      32     +32
>                  rk3399_dmc_probe                            64      72      +8
>                spl-u-boot-spl: add: 1/0, grow: 0/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      24     +24
>             rock-pi-n10-rk3399pro: all +72 bss +8 spl/u-boot-spl:all
> +24 spl/u-boot-spl:text +24 text +64 tpl/u-boot-tpl:all +16
> tpl/u-boot-tpl:text +16
>                tpl-u-boot-tpl: add: 0/0, grow: 1/0 bytes: 16/0 (16)
>                  function                                   old     new   delta
>                  rk3399_dmc_probe                          4296    4312     +16
>                u-boot: add: 1/0, grow: 1/0 bytes: 40/0 (40)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      32     +32
>                  rk3399_dmc_probe                            64      72      +8
>                spl-u-boot-spl: add: 1/0, grow: 0/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      24     +24
>             ficus-rk3399   : all +64 spl/u-boot-spl:all +24
> spl/u-boot-spl:text +24 text +64 tpl/u-boot-tpl:all +24
> tpl/u-boot-tpl:text +24
>                tpl-u-boot-tpl: add: 0/0, grow: 1/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_probe                          4352    4376     +24
>                u-boot: add: 1/0, grow: 1/0 bytes: 40/0 (40)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      32     +32
>                  rk3399_dmc_probe                            64      72      +8
>                spl-u-boot-spl: add: 1/0, grow: 0/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      24     +24
>             pinebook-pro-rk3399: all +56 bss -8 spl/u-boot-spl:all +24
> spl/u-boot-spl:text +24 text +64 tpl/u-boot-tpl:all +24
> tpl/u-boot-tpl:text +24
>                tpl-u-boot-tpl: add: 0/0, grow: 1/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_probe                          4212    4236     +24
>                u-boot: add: 1/0, grow: 1/0 bytes: 40/0 (40)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      32     +32
>                  rk3399_dmc_probe                            64      72      +8
>                spl-u-boot-spl: add: 1/0, grow: 0/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      24     +24
>             pinephone-pro-rk3399: all +56 bss -8 spl/u-boot-spl:all
> +24 spl/u-boot-spl:text +24 text +64 tpl/u-boot-tpl:all +24
> tpl/u-boot-tpl:text +24
>                tpl-u-boot-tpl: add: 0/0, grow: 1/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_probe                          4212    4236     +24
>                u-boot: add: 1/0, grow: 1/0 bytes: 40/0 (40)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      32     +32
>                  rk3399_dmc_probe                            64      72      +8
>                spl-u-boot-spl: add: 1/0, grow: 0/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      24     +24
>             rock-4se-rk3399: all +56 bss -8 spl/u-boot-spl:all +24
> spl/u-boot-spl:text +24 text +64 tpl/u-boot-tpl:all +24
> tpl/u-boot-tpl:text +24
>                tpl-u-boot-tpl: add: 0/0, grow: 1/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_probe                          4212    4236     +24
>                u-boot: add: 1/0, grow: 1/0 bytes: 40/0 (40)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      32     +32
>                  rk3399_dmc_probe                            64      72      +8
>                spl-u-boot-spl: add: 1/0, grow: 0/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      24     +24
>             rock-pi-4-rk3399: all +56 bss -8 spl/u-boot-spl:all +24
> spl/u-boot-spl:text +24 text +64 tpl/u-boot-tpl:all +24
> tpl/u-boot-tpl:text +24
>                tpl-u-boot-tpl: add: 0/0, grow: 1/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_probe                          4212    4236     +24
>                u-boot: add: 1/0, grow: 1/0 bytes: 40/0 (40)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      32     +32
>                  rk3399_dmc_probe                            64      72      +8
>                spl-u-boot-spl: add: 1/0, grow: 0/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      24     +24
>             rock-pi-4c-rk3399: all +56 bss -8 spl/u-boot-spl:all +24
> spl/u-boot-spl:text +24 text +64 tpl/u-boot-tpl:all +24
> tpl/u-boot-tpl:text +24
>                tpl-u-boot-tpl: add: 0/0, grow: 1/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_probe                          4212    4236     +24
>                u-boot: add: 1/0, grow: 1/0 bytes: 40/0 (40)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      32     +32
>                  rk3399_dmc_probe                            64      72      +8
>                spl-u-boot-spl: add: 1/0, grow: 0/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      24     +24
>             evb-rk3399     : all +56 bss -8 spl/u-boot-spl:all +24
> spl/u-boot-spl:text +24 text +64 tpl/u-boot-tpl:all +24
> tpl/u-boot-tpl:text +24
>                tpl-u-boot-tpl: add: 0/0, grow: 1/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_probe                          4352    4376     +24
>                u-boot: add: 1/0, grow: 1/0 bytes: 40/0 (40)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      32     +32
>                  rk3399_dmc_probe                            64      72      +8
>                spl-u-boot-spl: add: 1/0, grow: 0/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      24     +24
>             nanopi-neo4-rk3399: all +56 bss -8 spl/u-boot-spl:all +24
> spl/u-boot-spl:text +24 text +64 tpl/u-boot-tpl:all +24
> tpl/u-boot-tpl:text +24
>                tpl-u-boot-tpl: add: 0/0, grow: 1/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_probe                          4352    4376     +24
>                u-boot: add: 1/0, grow: 1/0 bytes: 40/0 (40)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      32     +32
>                  rk3399_dmc_probe                            64      72      +8
>                spl-u-boot-spl: add: 1/0, grow: 0/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      24     +24
>             rock960-rk3399 : all +56 bss -8 spl/u-boot-spl:all +24
> spl/u-boot-spl:text +24 text +64 tpl/u-boot-tpl:all +24
> tpl/u-boot-tpl:text +24
>                tpl-u-boot-tpl: add: 0/0, grow: 1/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_probe                          4352    4376     +24
>                u-boot: add: 1/0, grow: 1/0 bytes: 40/0 (40)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      32     +32
>                  rk3399_dmc_probe                            64      72      +8
>                spl-u-boot-spl: add: 1/0, grow: 0/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      24     +24
>             roc-pc-mezzanine-rk3399: all +56 bss -8 spl/u-boot-spl:all
> +24 spl/u-boot-spl:text +24 text +64 tpl/u-boot-tpl:all +16
> tpl/u-boot-tpl:text +16
>                tpl-u-boot-tpl: add: 0/0, grow: 1/0 bytes: 16/0 (16)
>                  function                                   old     new   delta
>                  rk3399_dmc_probe                          4168    4184     +16
>                u-boot: add: 1/0, grow: 1/0 bytes: 40/0 (40)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      32     +32
>                  rk3399_dmc_probe                            64      72      +8
>                spl-u-boot-spl: add: 1/0, grow: 0/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      24     +24
>             roc-pc-rk3399  : all +56 bss -8 spl/u-boot-spl:all +24
> spl/u-boot-spl:text +24 text +64 tpl/u-boot-tpl:all +16
> tpl/u-boot-tpl:text +16
>                tpl-u-boot-tpl: add: 0/0, grow: 1/0 bytes: 16/0 (16)
>                  function                                   old     new   delta
>                  rk3399_dmc_probe                          4168    4184     +16
>                u-boot: add: 1/0, grow: 1/0 bytes: 40/0 (40)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      32     +32
>                  rk3399_dmc_probe                            64      72      +8
>                spl-u-boot-spl: add: 1/0, grow: 0/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      24     +24
>             chromebook_bob : all +72 bss +8 spl/u-boot-spl:all +24
> spl/u-boot-spl:text +24 text +64
>                u-boot: add: 1/0, grow: 1/0 bytes: 40/0 (40)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      32     +32
>                  rk3399_dmc_probe                            64      72      +8
>                spl-u-boot-spl: add: 0/0, grow: 1/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_probe                          4352    4376     +24
>             chromebook_kevin: all +72 bss +8 spl/u-boot-spl:all +24
> spl/u-boot-spl:text +24 text +64
>                u-boot: add: 1/0, grow: 1/0 bytes: 40/0 (40)
>                  function                                   old     new   delta
>                  rk3399_dmc_of_to_plat                        -      32     +32
>                  rk3399_dmc_probe                            64      72      +8
>                spl-u-boot-spl: add: 0/0, grow: 1/0 bytes: 24/0 (24)
>                  function                                   old     new   delta
>                  rk3399_dmc_probe                          4352    4376     +24
> 
>>
>>>
>>> - Drop the non-dcache optimisation, since the cache should normally be on
>>
>> Is this referencing to something that is still done in this patch?
> 
> No, it is attached to v5, but I had a blank line in the way. Will fix.
> 
>>
>>>
>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>> ---
>>>
>>> (no changes since v5)
>>>
>>> Changes in v5:
>>> - Move setting of pmugrf into the probe() function
>>> - Drop patches previously applied
>>>
>>> Changes in v4:
>>> - Fix 'stating' typo
>>> - Move Binman size feature to a separate series
>>>
>>> Changes in v3:
>>> - Split out the refactoring into a separate patch
>>>
>>> Changes in v2:
>>> - Drop patch "regulator: rk8xx: Fix incorrect parameter"
>>> - Rewrite boneblack patch to onstead drop the target and update docs
>>>
>>>  drivers/ram/rockchip/sdram_rk3399.c | 33 ++++++++++++++---------------
>>>  1 file changed, 16 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
>>> index bc79c034808..8a7cbb1849f 100644
>>> --- a/drivers/ram/rockchip/sdram_rk3399.c
>>> +++ b/drivers/ram/rockchip/sdram_rk3399.c
>>> @@ -13,6 +13,7 @@
>>>  #include <log.h>
>>>  #include <ram.h>
>>>  #include <regmap.h>
>>> +#include <spl.h>
>>>  #include <syscon.h>
>>>  #include <asm/arch-rockchip/clock.h>
>>>  #include <asm/arch-rockchip/cru.h>
>>> @@ -63,8 +64,6 @@ struct chan_info {
>>>  };
>>>
>>>  struct dram_info {
>>> -#if defined(CONFIG_TPL_BUILD) || \
>>> -     (!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
>>>       u32 pwrup_srefresh_exit[2];
>>>       struct chan_info chan[2];
>>>       struct clk ddr_clk;
>>> @@ -75,7 +74,6 @@ struct dram_info {
>>>       struct rk3399_pmusgrf_regs *pmusgrf;
>>>       struct rk3399_ddr_cic_regs *cic;
>>>       const struct sdram_rk3399_ops *ops;
>>> -#endif
>>>       struct ram_info info;
>>>       struct rk3399_pmugrf_regs *pmugrf;
>>>  };
>>> @@ -92,9 +90,6 @@ struct sdram_rk3399_ops {
>>>                                       struct rk3399_sdram_params *params);
>>>  };
>>>
>>> -#if defined(CONFIG_TPL_BUILD) || \
>>> -     (!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
>>> -
>>>  struct rockchip_dmc_plat {
>>>  #if CONFIG_IS_ENABLED(OF_PLATDATA)
>>>       struct dtd_rockchip_rk3399_dmc dtplat;
>>> @@ -191,6 +186,17 @@ struct io_setting {
>>>       },
>>>  };
>>>
>>> +/**
>>> + * phase_sdram_init() - Check if this is the phase where SDRAM init happens
>>> + *
>>> + * Returns: true to do SDRAM init in this phase, false to not
>>> + */
>>> +static bool phase_sdram_init(void)
>>> +{
>>> +     return spl_phase() == PHASE_TPL ||
>>> +         (!IS_ENABLED(CONFIG_TPL) && !spl_in_proper());
>>
>> This is still wrong, please consider ROCKCHIP_EXTERNAL_TPL or this
>> function fail to do what you document it to do.
>>
>> See our prior thread about this:
>> https://lore.kernel.org/u-boot/CAFLszThg5xohR-9AgSMHVrW5Dp_tN39nC7rq1Z4ZMnqOQqJa1w@mail.gmail.com/
> 
> Oh yes, I was looking at that earlier and then forgot about it.
> 
> Regards,
> Simon
> 
> 
>>
>> Regards,
>> Jonas
>>
>>> +}
>>> +
>>>  static struct io_setting *
>>>  lpddr4_get_io_settings(const struct rk3399_sdram_params *params, u32 mr5)
>>>  {
>>> @@ -3024,7 +3030,7 @@ static int rk3399_dmc_of_to_plat(struct udevice *dev)
>>>       struct rockchip_dmc_plat *plat = dev_get_plat(dev);
>>>       int ret;
>>>
>>> -     if (!CONFIG_IS_ENABLED(OF_REAL))
>>> +     if (!CONFIG_IS_ENABLED(OF_REAL) || !phase_sdram_init())
>>>               return 0;
>>>
>>>       ret = dev_read_u32_array(dev, "rockchip,sdram-params",
>>> @@ -3093,7 +3099,6 @@ static int rk3399_dmc_init(struct udevice *dev)
>>>       priv->cic = syscon_get_first_range(ROCKCHIP_SYSCON_CIC);
>>>       priv->grf = syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
>>>       priv->pmu = syscon_get_first_range(ROCKCHIP_SYSCON_PMU);
>>> -     priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
>>>       priv->pmusgrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUSGRF);
>>>       priv->pmucru = rockchip_get_pmucru();
>>>       priv->cru = rockchip_get_cru();
>>> @@ -3138,19 +3143,16 @@ static int rk3399_dmc_init(struct udevice *dev)
>>>
>>>       return 0;
>>>  }
>>> -#endif
>>>
>>>  static int rk3399_dmc_probe(struct udevice *dev)
>>>  {
>>>       struct dram_info *priv = dev_get_priv(dev);
>>>
>>> -#if defined(CONFIG_TPL_BUILD) || \
>>> -     (!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
>>> -     if (rk3399_dmc_init(dev))
>>> -             return 0;
>>> -#endif
>>>       priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
>>>       debug("%s: pmugrf = %p\n", __func__, priv->pmugrf);
>>> +     if (phase_sdram_init() && rk3399_dmc_init(dev))
>>> +             return 0;
>>> +
>>>       priv->info.base = CFG_SYS_SDRAM_BASE;
>>>       priv->info.size =
>>>               rockchip_sdram_size((phys_addr_t)&priv->pmugrf->os_reg2);
>>> @@ -3181,10 +3183,7 @@ U_BOOT_DRIVER(dmc_rk3399) = {
>>>       .id = UCLASS_RAM,
>>>       .of_match = rk3399_dmc_ids,
>>>       .ops = &rk3399_dmc_ops,
>>> -#if defined(CONFIG_TPL_BUILD) || \
>>> -     (!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
>>>       .of_to_plat = rk3399_dmc_of_to_plat,
>>> -#endif
>>>       .probe = rk3399_dmc_probe,
>>>       .priv_auto      = sizeof(struct dram_info),
>>>  #if defined(CONFIG_TPL_BUILD) || \
>>

