Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC2BC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 14:07:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DB2384C2D;
	Mon, 13 Jul 2026 16:07:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="weWzzNdz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D307E84C39; Mon, 13 Jul 2026 16:07:18 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 128C584B8D
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 16:07:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5a7b=FI=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1783951635;
 bh=Hpxb6ZuT6xxSynofxQA+3uplwc79BIArhP8FTNRJ08c=;
 b=weWzzNdzZwH5Z+0ywYGmaX4MJoJSjq2ihG0lLE2+bLHNJ1VFa3x3xn6nCGDsxz3xiLKbxg+QF
 cE0K338XgfL4h0Cp3tEX7WiDuiM71NQ0xfGDPJPoau+doUd3JkyhK4v1NzOxppQUh3y0uw0EJb1
 gBge7/ofQ+W382o4TIkV10BtplnbDlpADGTnplde9FjKUxqalvNGhu3Bqm4US1p3XzUcwNr6StJ
 j5Iu6q2+kWNfctZ90BRdYpZO6jIubUeu0kujSw0XjfR/yArbAeu7/t6cabI66vh0b2u6L+5U/6V
 qc3OQkxvcUNSy66R2k0LdlUwr9p04YX8x9qQh1MuTTPw==
X-Forward-Email-ID: 6a54f10edd7e85e8e8c0ca98
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.10.5
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <99a50a6c-a731-443d-a196-4944d15c8245@kwiboo.se>
Date: Mon, 13 Jul 2026 16:07:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] rockchip: fix boot from SDMMC on RK3576
To: Alexey Charkov <alchark@flipper.net>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <u-boot@0leil.net>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Xuhui Lin <xuhui.lin@rock-chips.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de
References: <20260713-rk3576-boost-v1-0-9d23aa08f674@flipper.net>
 <b09297f9-f22d-493a-974f-47749955e532@kwiboo.se>
 <CAKTNdwFWMKoA3fkXUWXJYJSDROHhrqbPbJ3RTCjvnOAF7UCfQw@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAKTNdwFWMKoA3fkXUWXJYJSDROHhrqbPbJ3RTCjvnOAF7UCfQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi Alexey,

On 7/13/2026 2:47 PM, Alexey Charkov wrote:
> On Mon, Jul 13, 2026 at 2:44 PM Jonas Karlman <jonas@kwiboo.se> wrote:
>>
>> Hi Alexey,
>>
>> On 7/13/2026 12:02 PM, Alexey Charkov wrote:
>>> This aims to upstream Jonas Karlman's long-standing patch series fixing
>>> the boot from SDMMC on RK3576, which requires a hotfix to the boot ROM's
>>> global state area before any SDMMC reads are initiated to avoid clobbing
>>> the ROM's state and breaking the boot process.
>>>
>>> The preparatory patches for the image tools are submitted verbatim from
>>> Jonas' version, while the "boost" code doing the actual hotfix is
>>> converted from using a pre-built tiny binary to a from-source build using
>>> the existing U-Boot build system.
>>
>> Thanks for re-sending this, this should likely have been labeled v2 and
>> there are review comments on my original series [1] that should be
>> addressed.
>>
>> I was planning on sending a v2 of the preparation series now that we
>> once again have an active maintainer for Rockchip, but unsure how to
>> handle that now :-)
>>
>> [1] https://patch.msgid.link/20250129223641.1888833-1-jonas@kwiboo.se/
> 
> Oops, here I am again, missing things already reviewed on the ML. My
> changes, though, are only concerning the very last patch in the series
> (which hadn't been sent out back then), and I haven't touched the
> other code in any way.

Hehe, no worries, I was planning on trying to get an updated version
(without rk3576 parts) out later this week. As stated on IRC [3], I was
planing to first focus on TPL refactoring and a few RK35xx clock fixes.

> Would you like to give the mkimage-related patches another go then,
> and then we bring in the boost.bin changes on top? I'm also happy to
> help incorporating Quentin's feedback if you'd like, although I don't
> know if that enters "too many cooks" territory :)

I can try to get the mkimage related patches another go later this week.
Have some other improvements/fixes I noticed while playing around with
other SoCs, or that where not ready when initial series was sent.

However, I think the boost patch you included (without mkimage parts)
could be sent as a standalone patch. The resulting .bin-file should work
as a replacement for the vendor boost blob.

[3] https://libera.catirclogs.org/linux-rockchip/2026-07-10#40172912;

> 
>>> From-source build also alleviates the problem with parallel out-of-tree
>>> builds, which could skip the pre-built binary but which always pick up the
>>> from-source build.
>>
>> My original intent was to try and embed the generated code to possible
>> match what I did to support emmc boot with the amlimage format, see [2].
>>
>> Building the boost blob ourself the way you do here seem like a better
>> option, however we should probably change to include the blob and
>> setting the required parameters using binman instead.
>>
>> For e.g. RK3572 and RK3538 there may be dboot/rboot blobs needed prior
>> to ddr-init, along with choosing to load SPL to a different DRAM address.
>> So we should prepare for being able to pass parameters, how I do not yet
>> know, possible using a new rkimage etype in binman.
> 
> Having everything in binman sounds neat, but on the other hand the
> current mkimage-based approach seems to work fine, so why fix what's
> not (yet?) broken? :)
> 
> For RK3576 that would mostly mean "reimplement mkimage in binman",
> from what I can see, as we still need to give the boot ROM the
> combined idbloader header it's built for and which mkimage produces.

Initially I was more thinking of wrapping the mkimage etype and passing
some rkcommon specific parameters to mkimage, not sure that is even
possible.

Using hardcoded parameters in rkcommon seem like a bad idea and
something we should avoid if possible, especially now that other SoCs
also may need similar workarounds or parameters/flags.

I am torn, will try to fix remaining review remarks in a v2 of the
mkimage preparation series. How we should best handle parameters will
likely be a discussion for later or be a follow up on that. At least
that was my plan for a v2, skip the last patch in v1 and only focus on the
cleanup and adding support for using 4 KiB blocks, together with some
local patches that e.g. add support for reading signed images.

> 
>> [2] https://patch.msgid.link/20250103215904.2590769-3-jonas@kwiboo.se/
>>
>>> Tested on a number of RK3576 boards, including the Rockchip RK3576 EVB1,
>>> ArmSoM Sige5, FriendlyElec NanoPi M5, Luckfox Omni3576, Radxa Rock 4D and
>>> Flipper One, all of which fail to boot from SDMMC without this series but
>>> boot fine with it applied.
>>
>> It has always been possible to boot from an SD-card if you compose an
>> alternative idbloader.img using boost+ddr blobs and u-boot-spl.bin from
>> U-Boot using the boot_merger tool from rkbin and write that and u-boot.itb
>> to the SD-card.
> 
> Rockchip's boost.bin blob does exactly the same thing as your
> assembly, plus setting UFS power mode parameters - and that's it.
> Power mode parameters at pre-TPL stage don't make any meaningful
> difference in any of the workloads I tried, so I'm not even sure why
> that part is included. So yes, using their blob and their tool should
> work too, but that doesn't count in the context of mainline IMO :)

I was more thinking something like a RK3576MINIALL-mmc.ini with

[CHIP_NAME]
NAME=RK3576
[VERSION]
MAJOR=1
MINOR=100
[CODE471_OPTION]
NUM=2
Path1=arch/arm/mach-rockchip/rk3576/rk3576-boost.bin
Path2=mkimage-in-simple-bin.mkimage-rockchip-tpl
Sleep=1
[CODE472_OPTION]
NUM=1
Path1=mkimage-in-simple-bin.mkimage-u-boot-spl
[LOADER_OPTION]
NUM=3
LOADER1=FlashBoost
LOADER2=FlashData
LOADER3=FlashBoot
FlashBoost=arch/arm/mach-rockchip/rk3576/rk3576-boost.bin
FlashData=mkimage-in-simple-bin.mkimage-rockchip-tpl
FlashBoot=mkimage-in-simple-bin.mkimage-u-boot-spl
[DOWNLOADBOOT1_PARAM]
LOAD_ADDR=0x3FFC0000
FLAG=0x0
[LOADER1_PARAM]
LOAD_ADDR=0x3FFC0000
FLAG=0x0
[LOADER2_PARAM]
LOAD_ADDR=0x3FF81000
FLAG=0x0
[OUTPUT]
PATH=u-boot-rockchip-loader.bin
IDB_PATH=u-boot-rockchip-idblock.bin
[SYSTEM]
NEWIDB=true
ALIGN=8
[FLAG]
CREATE_IDB=true
471_RC4_OFF=true
RC4_OFF=true
CRC_OFF=true

and then running something like

  ../rkbin/tools/boot_merger RK3576MINIALL-mmc.ini

after a successful build of a rk3576 defconfig target to get a
u-boot-rockchip-idblock.bin that should be in correct format as
idbloader.img. This idblock.bin and u-boot.itb could be used together
instead of u-boot-rockchip.bin to have working SD-card boot.

This still uses vendor tools and the vendor TPL blob but remaining is
mainline U-Boot. At least an option until mkimage parts are ready.

Regards,
Jonas

> 
>>> I've also done some JTAG debugging of the boot process, and the single-
>>> word write which the boost binary performs to the SRAM at 0x3ff803b0
>>> appears to be relocating the base of the SDMMC IDMAC DMA descriptor buffer
>>> to the top of SRAM, which prevents large multi-page SDMMC reads from
>>> overrunning adjacent ROM state and thus breaking the boot process. A
>>> comment has been added to the boost code to reflect this.
>>
>> Awesome, thanks for this information :-)
> 
> Cutting down magic in this world, one memory store instruction at a time :-D
> 
> Best regards,
> Alexey

