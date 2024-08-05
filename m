Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C2BC3DA4A
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 12:23:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F18A38882C;
	Mon,  5 Aug 2024 14:23:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="q4QTuerr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26DC288890; Mon,  5 Aug 2024 14:23:18 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 699D3887E8
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 14:23:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=6949=PF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1722860575;
 bh=u9l/SRWNIBr4AQv+Fetuc4VzjnJtuLH31Upm4bew1dI=;
 b=q4QTuerrm5w/326zPpTNeic8A0ebxz19P7azyQhf5C/DoMPdRqF0SEI19w6q9s54kWK/64STT
 ov0Ew762swImR/AWz+VMV5VxndvAq++pDr1lpfPq7WsWV5yJHg+cdQF9Mf/MRjC8mXjqqMmXMkn
 stKtrxezURTyAeCQrQzuTnS5Gp/llrlyiGAyUeszxoDtq7jq0kXyELIGRXVrl1O+dWyCV7x6GGf
 yjeaJRTnGNixiKbz1jYXn+Pd/tmHMgGO2gczfAQ6rohx5VwUnu+9RvY8fuXWZy/a+xBGJF2wKTE
 YO8ZQKVVbaKL7hAyEVR4VG6SpWx5scq8orb/U8cyFTEg==
Message-ID: <ea4c0f12-bf49-405a-afdb-3312e1eb8c95@kwiboo.se>
Date: Mon, 5 Aug 2024 14:22:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] rockchip: Skip serial pinctrl at pre-reloc phase
To: Quentin Schulz <quentin.schulz@cherry.de>, Lukasz Czechowski
 <lukasz.czechowski@thaumatec.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20240805084350.3895788-1-jonas@kwiboo.se>
 <6df6a6df-f8fc-44c3-9688-6f2ccbd8888d@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <6df6a6df-f8fc-44c3-9688-6f2ccbd8888d@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66b0c41be96ab59460b16ee5
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

On 2024-08-05 12:23, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 8/5/24 10:43 AM, Jonas Karlman wrote:
>> UART pinctrl for serial is typically applied multiple times:
>> - in external TPL or in TPL for DEBUG_UART in board_debug_uart_init()
>> - in SPL for DEBUG_UART in board_debug_uart_init()
>> - in SPL using pinctrl from DT
>> - in pre-reloc phase using pinctrl from DT
>> - after relocation using pinctrl from DT
>>
>> This series change bootph props for the UART pinctrl to not include them
>> in pre-reloc phase to save some boot time:
>>
> 
> NACK. I feel like this is a hack for vendor trees only.

I disagree, this just relaxes the bootph props currently enforced by
<soc>-u-boot.dtsi files. For boards that has special need they can
still add bootph-all or the bootph-some-ram prop to restore prior
behavior.

Also please do not associate me with any vendor, I am a hobbyist :-)

> 
> 1) The Device Tree represents the hardware. We need the mux at all times.

I do not think this changes the the description of the hardware in any
way. The bootph props is currently already more of a representation of
how software should behave than hardware.

In general for Rockchip use of the bootph-some-ram prop (pre-relocation
phase) does not fully make any sense, since we already have full SDRAM
in SPL.

If we where to fully follow the dtschema description for the bootph
props, for Rockchip they should probably map to something like:

TPL:
- bootph-pre-sram: Enable this node when SRAM is not available.
- bootph-pre-ram: Enable this node in the phase that sets up SDRAM.

SPL:
- bootph-some-ram: Enable this node in the phase that is run after SDRAM
                   is working but before all of it is available.

U-Boot pre-reloc:
- no prop mapping, we have all SDRAM and can use all devices, ideally
  for Rockchip we should just do bare minimum to relocate without
  loading any driver and then move to main post-reloc phase.

Instead they map to the different U-Boot software stages:
- bootph-pre-sram: TPL
- bootph-pre-ram: SPL
- bootph-some-ram: U-Boot pre-reloc

> 2) This breaks users who want to have no serial in TPL/SPL but in proper 
> (where you want it as soon as possible I assume, thus pre-reloc).

Do you know of any such user/board? Adding the bootph-some-ram or
bootph-all prop can easily be done in <board>-u-boot.dtsi for such
user/board to restore current behavior.

> 3) This likely also means if BL31 is configured to output on a different 
> UART mux of the same controller for some reason (I've seen weird stuff), 
> now U-Boot proper pre-reloc will not output anything as well.

Same as for 2), adding the bootph-some-ram or bootph-all can and should
be done at board level for boards that have special, or weird,
requirements.

It is also possible to add board specific code that call
debug_uart_init() early if you want to ensure pinmux without adding the
unnecessary delay that use of pinctrl in pre-reloc brings.

> 
> Adding Lukasz in Cc who's trying to fix U-Boot so that this is possible 
> on PX30 (therefore, not just a theoretical use case I'm bringing up ;) ).
> 
>> - Radxa ROCK Pi S (RK3308): ~80 ms
>> - Radxa ZERO 3W (RK3566): ~120 ms
>> - Radxa ROCK 5B (RK3588): ~150 ms
>>
>> Similar change has already been applied for RK3328 and RK3399 boards.
>>
> 
> Then I believe this was a mistake.

My wording may have been misleading, when we added broad use of pinctrl props
to SPL for rk3328/rk3399 we limited so that the uart pinctrl group was only
enabled for TPL/SPL and not pre-reloc phase, because also including it at
pre-reloc added 200-300 ms in extra boot time.

This series tries to apply same findings on remaining Rockchip aarch64
boards.

> 
>> The change for PX30 has not been runtime tested, and only include change
>> for uart2, not uart0 and uart5 used on two of the supported px30 boards.
>>
> 
> This means we have uart2 pinctrl at all stages even though we make no 
> use of it?

Yes, in my opinion the px30-u-boot.dtsi include lots of nodes that seem
very board specific, some that probably should move to board specific
u-boot.dtsi files.

> 
> I'm starting to wonder if this optimization isn't orthogonal to having 
> as much support as possible via an <soc>-u-boot.dtsi which was done to 
> make bring-up and maintenance easier. If you're really after 
> optimization AND we keep the pinctrl for the debug uart (thus, not 
> breaking 2) above), then what we want is cleaning up the default 
> px30-u-boot.dtsi and move bootph properties to the board DTS instead?

Agree, for other aarch64 socs I have already tried to cleanup
<soc>-u-boot.dtsi to only contain what more than 70-80% of all supported
boards may need. For rk3399 bob and kevin even use /delete-property/ to
remove some of the common boothp props because all other rk3399 boards
benefited from those common boothp props.

I have no px30 board and the only rk3326 board I do have does not
include the px30-u-boot.dtsi, so I will not try to do any cleanup of
that file.

> 
> I was a bit against this "turn-key" solution wrt u-boot DT for 
> rk3568/rk3588 but we went ahead, are we changing our mind now? Just to 
> know what exactly is the direction we are planning to take.

Please elaborate, I do not understand what you mean by this.

The noticeable effect of boot time was discovered when reworking
rk3399-u-boot.dtsi, after rk3568/rk3588 u-boot.dtsi already had gained a
bootph-all prop in its uart2m0_xfer node. This try to apply those
findings on a few more SoCs.

Regards,
Jonas

> 
> Cheers,
> Quentin

