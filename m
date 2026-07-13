Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E788C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 10:44:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F41684ABE;
	Mon, 13 Jul 2026 12:44:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="zIl47x7J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5622784AC0; Mon, 13 Jul 2026 12:44:30 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 799BB84ABB
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 12:44:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=7c05=FH=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1783939466;
 bh=Xpwx4KkhgWlzXR+TFobAOHvsyuWomyamjH/S8w7BKX4=;
 b=zIl47x7JIjLkNfvdDZAlzEd/HjV+B+y7LfApkoKou+UdyKd71YC3QBUWNUGVNteOfOG+CcTgc
 48t+rPK3u4lQJDTseqeWp4+RmKUnZtDLnnriyi6I2KPOye/UlCmD+UmqyMvHZnhjR6CW3TZPEUz
 FujW2ECwAWyas/AVpkU1bHj1+RM2ySTfdYOZYwAPS/GPzjoLn7d1uvvwopJs98CKlzgJ5WSRodD
 BzsdAdTjRtl7V7XmeKfZhNYX/xgp3FgHrjP/SE29m+pRbEjLDaffWThkfgqPisXzMxu/+jSW2Mv
 KQ5pjMKQ3kymL30deOPwlsdsvSp4H4xSaP95lNBcV6kA==
X-Forward-Email-ID: 6a54c1802926819d22ecea3d
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.10.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <b09297f9-f22d-493a-974f-47749955e532@kwiboo.se>
Date: Mon, 13 Jul 2026 12:44:12 +0200
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
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260713-rk3576-boost-v1-0-9d23aa08f674@flipper.net>
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

Hi Alexey,

On 7/13/2026 12:02 PM, Alexey Charkov wrote:
> This aims to upstream Jonas Karlman's long-standing patch series fixing
> the boot from SDMMC on RK3576, which requires a hotfix to the boot ROM's
> global state area before any SDMMC reads are initiated to avoid clobbing
> the ROM's state and breaking the boot process.
> 
> The preparatory patches for the image tools are submitted verbatim from
> Jonas' version, while the "boost" code doing the actual hotfix is
> converted from using a pre-built tiny binary to a from-source build using
> the existing U-Boot build system.

Thanks for re-sending this, this should likely have been labeled v2 and
there are review comments on my original series [1] that should be
addressed.

I was planning on sending a v2 of the preparation series now that we
once again have an active maintainer for Rockchip, but unsure how to
handle that now :-)

[1] https://patch.msgid.link/20250129223641.1888833-1-jonas@kwiboo.se/

> From-source build also alleviates the problem with parallel out-of-tree
> builds, which could skip the pre-built binary but which always pick up the
> from-source build.

My original intent was to try and embed the generated code to possible
match what I did to support emmc boot with the amlimage format, see [2].

Building the boost blob ourself the way you do here seem like a better
option, however we should probably change to include the blob and
setting the required parameters using binman instead.

For e.g. RK3572 and RK3538 there may be dboot/rboot blobs needed prior
to ddr-init, along with choosing to load SPL to a different DRAM address.
So we should prepare for being able to pass parameters, how I do not yet
know, possible using a new rkimage etype in binman.

[2] https://patch.msgid.link/20250103215904.2590769-3-jonas@kwiboo.se/

> Tested on a number of RK3576 boards, including the Rockchip RK3576 EVB1,
> ArmSoM Sige5, FriendlyElec NanoPi M5, Luckfox Omni3576, Radxa Rock 4D and
> Flipper One, all of which fail to boot from SDMMC without this series but
> boot fine with it applied.

It has always been possible to boot from an SD-card if you compose an
alternative idbloader.img using boost+ddr blobs and u-boot-spl.bin from
U-Boot using the boot_merger tool from rkbin and write that and u-boot.itb
to the SD-card.

> I've also done some JTAG debugging of the boot process, and the single-
> word write which the boost binary performs to the SRAM at 0x3ff803b0
> appears to be relocating the base of the SDMMC IDMAC DMA descriptor buffer
> to the top of SRAM, which prevents large multi-page SDMMC reads from
> overrunning adjacent ROM state and thus breaking the boot process. A
> comment has been added to the boost code to reflect this.

Awesome, thanks for this information :-)

Regards,
Jonas

> 
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
> Jonas Karlman (7):
>       rockchip: mkimage: Split size_and_off and size_and_nimage
>       rockchip: mkimage: Print image information for all embedded images
>       rockchip: mkimage: Print boot0 and boot1 parameters
>       rockchip: mkimage: Add option to change image offset alignment
>       rockchip: mkimage: Add support for up to 4 input files
>       rockchip: mkimage: Add option for image load address and flag
>       rockchip: mkimage: Add rk3576 align and sd-card workaround
> 
>  arch/arm/mach-rockchip/rk3576/Makefile       |  10 +
>  arch/arm/mach-rockchip/rk3576/rk3576-boost.c |  31 +++
>  tools/rkcommon.c                             | 290 +++++++++++++++++----------
>  tools/rkcommon.h                             |   2 -
>  4 files changed, 228 insertions(+), 105 deletions(-)
> ---
> base-commit: 6741b0dfb41dc82a284ab1cff4c58af6ef2f3f9c
> change-id: 20260713-rk3576-boost-58a5f47e74e3
> 
> Best regards,
> --  
> Alexey Charkov <alchark@flipper.net>
> 

