Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B23B2C982DA
	for <u-boot@archiver.kernel.org>; Sun, 20 Sep 2026 15:49:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 75B9740EFB;
	Sun, 20 Sep 2026 15:49:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QYtcVnvw3b7x; Sun, 20 Sep 2026 15:49:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org EFEF040EE4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789919394;
	b=HDkYAJ5SxP6jS+OS6PHL0zx+r35Fn73G824kKuz2aIxyINdSD+5wVOlO/CxcH4rS1dtI
	 j4ecbhKUpYSACk2xl8xADbUsG8+Koyku599v2czphwn/omOc9yo6jTrUT0PfvAk9pNOdq
	 eW+GLV+vrvGdDSt2TALpKnn3njZfAw3eTUSgYurV8cSY8grumRHvhwwB0mfe5ng184AiH
	 mpXl2JqGquTwzfOZTQ7dQ6llWf5oOYQUXmrq1FUfT+YUIFa9nJgB8NoZNvYo3h/LkF1dK
	 riQ5CwCX3PxiDl9aGZMFLh/rrkhzI8yaTNCIk+pvcURVraWJ0f8jRmRbZNQ/K+fKapw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789919394;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=3yTMaPjp6zucIOMfqF4Pg2ioMm9sYYBMzHTWqB1MbQA=;
	b=RvKZ43Cw9YLbtq6eYgtwc0WyjXQgvlzVHT62UMXayyxPiQRRkITzaINWlk5IljrzCYuq
	 kP418kn7U9mQoRDx14bgktjfg3aZe5hkzCm3RNPkfuMgraMQBk31XespDTZzhXDSMhu2g
	 N93z1XnaIswlzHJHYs/FMySYTTKKeO8DG5XpFTqj1o5HX3984mBJOKWzllS6JAx7P944u
	 AiqsPuiZf0qtVXYOeP1dncIKBXalql2SveKzbywFOiy8JQY84nJhCStURDX/FrHI/UeyD
	 OHWuS3YOiIC8ap/3HRAsJ6YnPPzAJ9F3Tru24lsPACJMGohFa9TgpRtQuFgQJVvYI7g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789919394;
	bh=3yTMaPjp6zucIOMfqF4Pg2ioMm9sYYBMzHTWqB1MbQA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AxpbvgnBza4bm5ij1Zuf096O5hdJ7pahmEq/R7XBCNhJuH2f4WHh2qO27u5VikqDf
	 pR2wWpJkF/goRu3IxVgw6B73uRQ9BdBHLkAyoaI0DmeRsYgnEvEZF2HgrgmjNBq83F
	 kyDkH9xzuKivkxZVsRvNYl6R6AjCRk2gapAhTPiw4inIB8tsdmcKFgyRD+5+MM+nLO
	 gFFOXnv/PzACy/y1oJ1++nwjvHBEXLrn1RzWiL8/OeoAsJXx02nG0KiqvktNbiFj/b
	 DHFEePD6PTi+utrDJp9mcNkgq8fY71bjMsvJfRKzBTL/Jub0ii1R5NzH0+/auY4eZI
	 n7IeRQ2AGw/EQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EFEF040EE4;
	Sun, 20 Sep 2026 15:49:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 354AA3DD
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 15:49:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1BC6D606F2
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 15:49:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n9WfUjQ4HOaN for <u-boot@lists.u-boot-project.org>;
 Sun, 20 Sep 2026 15:49:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B63EE60629
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789919391;
 b=dmc0UMOdU/t5h+mfY2xuAhrozXJp1qQzod3xn41gK3fxCUBQCIRdU2n8QirmhUwXQ/1V
 xBL+DXMOKj1oJQEZLSbuPNsZ1I8XuAo7DsFOZ4Kt6oNKwWFpRHm5/8sSw9onJY6lH9aT5
 64z21+ceU8fOqALCarvPdqaSbCxldJrmcqO0E5XWmIIsdx2OCQjjlNyE3ClhsL/OmPi1d
 rYC6F1D8e27JKV7Xt/L78WwroWl2WtU/lGy+5CFX9QftQlXASZKLJ+WNfUDntn3TOfj09
 PQikKt1p71mOcb2rcgJQUNT2/E1EUHSDyBXMAK0ayN+/l1Gr4jn8HhxZnhcb/PXfDCQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789919391;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=3yTMaPjp6zucIOMfqF4Pg2ioMm9sYYBMzHTWqB1MbQA=;
 b=PQURvK9yfKkOSLtLMqOicGgCb1wUwQj1rnClpQ+gH/jLKtsQNO9JpElpdKV6HpQ9zcDJ
 /xiU8s1XyBcsjjARu7AQAmw29+YDM9HvPx1J0gMF1zrP+S3v8BMnYVWvIeIlyII1BBzLR
 YJB4T1/9gXktJFLBhSjGvGqlTwaUBu/IyhyKNOW9bDvYwu4cTLplBZxEh3l9L/Jc17YHT
 yLKKImv+3ZrEwaFbr/ZlvfOWczxOFC7bSOv5zRnDdaRBfzwb+Miy5FlZQo/96gr1XRLn7
 ANJYcoeq9QiazOBSRbj4lpUMLKluJyps0JFWyWr3NrZBidicIVxIU72oLmVvgsPn7Vg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kwiboo.se; 
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=F320Ghcy; 
 arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=b560=hn=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=F320Ghcy
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B63EE60629
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 15:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1789919388;
 bh=3yTMaPjp6zucIOMfqF4Pg2ioMm9sYYBMzHTWqB1MbQA=;
 b=F320GhcygWxKA0V/2C9Kv5DFwv1/zTIVfCca5+nvo9Ow2y4kB9lW9G7FjA2Hf6VSZJZrLwkoQ
 hbWoBr/U2qf0MWhAmW1Hxu46cwhXjRGT/Tpl/7yXyx8oPz2NT/1eY+5tNUFFx/q5loQiqdBmW95
 z0lkbnZweAECSVhvcmjPN8bTgN7t5Y8aFA8nfQliwuJaAwWD1G+vRKPANbaEF6kAj4bsOFJe4oH
 MxTxFY+Qr+lZtfSHLtaXZMDm+CXMZbNIzNwajc59bj2KNFCrKM0fYajq5KDVfP4Feh881rF8wCn
 s4+vPI7B6BdoUDdRteaevkn4Lmp5qBm+BegMakdP4vsw==
X-Forward-Email-ID: 6ab0009ac12d15e53d8e07d2
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.15.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <ad7869e9-d7ee-4130-b924-ebcf9719b93a@kwiboo.se>
Date: Sun, 20 Sep 2026 17:49:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/11] rockchip: SoC info and reset cause printouts
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Quentin Schulz <u-boot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>,
 u-boot@lists.u-boot-project.org
References: <20260920-reset-v1-0-42820216369f@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260920-reset-v1-0-42820216369f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Massimo,

On 9/20/2026 4:15 PM, Massimo Pegorer wrote:
> Looking to provide a way to print reset cause on a board equipped with
> a PX30 SoC I ran into the following existing issues related to Rockchip
> SoCs:
> 
> 1. It is not possible to select DISPLAY_CPUINFO configuration option
>    with ARCH_ROCKCHIP, except for RK3399 RK3288 RK3568 RK3588 SoCs, due
>    to incomplete definition of type 'struct rockchip_cru' caused by
>    Rockchip common implementation of print_cpuinfo() function: see
>    0f9872c4db11 for the RK3588 SoC "workaround", which I feel not
>    optimal. Note that DISPLAY_CPUINFO has default y if ARM; therefore,
>    it is deselected in each Rockchip defconfig except for listed SoCs.
> 
> 2. It is not possible to deselect DISPLAY_CPUINFO configuration option
>    with TARGET_ROC_PC_RK3399 due to missing get_reset_cause() symbol
>    caused by mach-rockchip/Makefile skipping cpu-info.c. I do not see
>    how e230c579a3f6 commit separated the reset cause from displaying
>    cpuinfo as proposed.

Please see the series "rockchip: Add and use rockchip_sysreset_bind()
helper" [1] that already should resolve above issues.

That series has some loose depends for a clean apply, but the idea is to
fully move the resets status handling into the sysreset driver and start
cleanup of 'struct rockchip_cru' use.

Please try, review and possible build on top of that :-)

[1] https://patch.msgid.link/20260805174509.2968252-1-jonas@kwiboo.se/

Regards,
Jonas

> 
> 3. For the most recent Rockchip SoCs (RK3588 RK3576 RK3568 RK3528 RK3506
>    RK3308 PX30) the checkboard() function is implemented at mach level
>    to print SoC information: it overrides the weak empty implementation
>    called by show_board_info() when DISPLAY_BOARDINFO(_LATE) option is
>    selected.
> 
>    Most of the other machs do not provide a checkboard() implementation
>    leaving symbol available for overriding at board level. I did not
>    find any "regulatory" definition in the documentation, but SoC info
>    sounds to me more related to CPUINFO than to BOARDINFO, and other
>    machs approach in my opinion seems more consistent with the function
>    and configuration option names (checkboard and DISPLAY_BOARDINFO).
>    Moreover, this approach has the advantage of allowing each board to
>    implement its own checkboard() if needed (other hooks exist for
>    board specific printout, of course).
> 
> 4. Implementation of get_reset_cause() cannot be common in Rockchip mach
>    due to different CRU_GLB_RST_ST register definitions from SoC to SoC:
>    RK3288 and RK3399 share the same one, but RK3568 and RK3588 ones have
>    more bit flags defined (and not all of them seem mutually exclusive),
>    and PX30 and RK3308 common one differs again having WDT and TSADC bit
>    flags swapped.
> 
> Here is my proposal, awaiting your comments and feedback:
> 
> 1. Create a Rockchip common print_cpuinfo() suitable for any SoC/board,
>    making possible DISPLAY_CPUINFO selection without build issues.
> 
> 2. Avoid DISPLAY_CPUINFO deselection causes build issues for any board.
> 
> 3. Make print_cpuinfo() to execute code that is currently in function
>    named checkboard() at SoC level (if implemented), which prints more
>    info than CONFIG_SYS_SOC. Of course, keep printing CONFIG_SYS_SOC if
>    function is unavailable and on returning error.
> 
> 4. Make print_cpuinfo() to execute code to get the SoC reset cause and
>    to print its description if the reset cause is available.
> 
> 5. Avoid DISPLAY_BOARDINFO(_LATE) printing the same SoC info now printed
>    by DISPLAY_CPUINFO too: it seems redundant and quite misleading. This
>    makes checkboard() implementation at Rockchip mach level unnecessary:
>    remove it and leave the overriding option available for board level
>    implementation if needed.
> 
> 6. Select DISPLAY_CPUINFO in all Rockchip board configurations related
>    to PX30 RK3308 and any RK35xx (all the SoCs that were providing a
>    checkboard() implementation) that already have the DISPLAY_BOARDINFO
>    and/or the DISPLAY_BOARDINFO_LATE option selected, to keep SoC info
>    printout. BTW they are all of PX30 RK3308 and RK35xx board configs.
> 
> The whole series has been built with buildman for all of the involved
> board configurations, i.e. those related to PX30 RK3288 RK3308 RK3399
> RK35xx.
> 
> ---
> Massimo Pegorer (11):
>       arm: rockchip: include SoC-specific CRU header file
>       rockchip: cru: move code from header to source file
>       rockchip: cru: remove unnecessary common cru.h file
>       rockchip: cru: improve and simplify reset cause handling
>       arm: rockchip: support DISPLAY_CPUINFO on all Rockchip SoC
>       arm: rockchip: unbind cpu-info.c from DISPLAY_CPUINFO
>       arm: rockchip: print SoC detailed info with DISPLAY_CPUINFO
>       arm: rockchip: print reset cause only when available
>       arm: rockchip: do not print SoC info with DISPLAY_BOARDINFO
>       configs: rockchip: resync Anbernic RG-DS with savedefconfig
>       configs: rockchip: add DISPLAY_CPUINFO to keep SoC info print
> 
>  arch/arm/include/asm/arch-rockchip/clock.h      | 11 +++++
>  arch/arm/include/asm/arch-rockchip/cru.h        | 39 ----------------
>  arch/arm/include/asm/arch-rockchip/cru_rk3399.h |  1 +
>  arch/arm/mach-rockchip/Makefile                 |  2 +-
>  arch/arm/mach-rockchip/cpu-info.c               | 61 ++++++++++++-------------
>  arch/arm/mach-rockchip/px30/px30.c              | 12 ++---
>  arch/arm/mach-rockchip/rk3288/clk_rk3288.c      | 37 ++++++++++++++-
>  arch/arm/mach-rockchip/rk3288/rk3288.c          |  2 +-
>  arch/arm/mach-rockchip/rk3308/rk3308.c          |  2 +-
>  arch/arm/mach-rockchip/rk3399/clk_rk3399.c      | 37 ++++++++++++++-
>  arch/arm/mach-rockchip/rk3399/rk3399.c          |  2 +-
>  arch/arm/mach-rockchip/rk3506/rk3506.c          | 10 ++--
>  arch/arm/mach-rockchip/rk3528/rk3528.c          | 10 ++--
>  arch/arm/mach-rockchip/rk3568/clk_rk3568.c      | 35 ++++++++++++++
>  arch/arm/mach-rockchip/rk3568/rk3568.c          | 12 ++---
>  arch/arm/mach-rockchip/rk3576/rk3576.c          | 10 ++--
>  arch/arm/mach-rockchip/rk3588/clk_rk3588.c      | 35 ++++++++++++++
>  arch/arm/mach-rockchip/rk3588/rk3588.c          | 10 ++--
>  board/firefly/roc-pc-rk3399/roc-pc-rk3399.c     |  4 +-
>  configs/9tripod-x3568-v4-rk3568_defconfig       |  1 -
>  configs/anbernic-rg-ds-rk3568_defconfig         |  6 ---
>  configs/anbernic-rgxx3-rk3566_defconfig         |  1 -
>  configs/bpi-r2-pro-rk3568_defconfig             |  1 -
>  configs/cm3588-nas-rk3588_defconfig             |  1 -
>  configs/coolpi-4b-rk3588s_defconfig             |  1 -
>  configs/coolpi-cm5-evb-rk3588_defconfig         |  1 -
>  configs/coolpi-cm5-genbook-rk3588_defconfig     |  1 -
>  configs/easepi-r1-rk3568_defconfig              |  1 -
>  configs/evb-px30_defconfig                      |  1 -
>  configs/evb-rk3308_defconfig                    |  1 -
>  configs/evb-rk3568_defconfig                    |  1 -
>  configs/evb-rk3588_defconfig                    |  1 -
>  configs/fastrhino-r66s-rk3568_defconfig         |  1 -
>  configs/firefly-px30_defconfig                  |  1 -
>  configs/gameforce-ace-rk3588s_defconfig         |  1 -
>  configs/generic-rk3528_defconfig                |  1 -
>  configs/generic-rk3568_defconfig                |  1 -
>  configs/generic-rk3576_defconfig                |  1 -
>  configs/generic-rk3588_defconfig                |  1 -
>  configs/jaguar-rk3588_defconfig                 |  1 -
>  configs/khadas-edge2-rk3588s_defconfig          |  1 -
>  configs/lckfb-tspi-rk3566_defconfig             |  1 -
>  configs/lubancat-2-rk3568_defconfig             |  1 -
>  configs/mnt-reform2-rk3588_defconfig            |  1 -
>  configs/nanopc-t6-rk3588_defconfig              |  1 -
>  configs/nanopi-m5-rk3576_defconfig              |  1 -
>  configs/nanopi-r3s-rk3566_defconfig             |  1 -
>  configs/nanopi-r5c-rk3568_defconfig             |  1 -
>  configs/nanopi-r5s-rk3568_defconfig             |  1 -
>  configs/nanopi-r6c-rk3588s_defconfig            |  1 -
>  configs/nanopi-r6s-rk3588s_defconfig            |  1 -
>  configs/nanopi-r76s-rk3576_defconfig            |  1 -
>  configs/nanopi-zero2-rk3528_defconfig           |  1 -
>  configs/neu6a-io-rk3588_defconfig               |  1 -
>  configs/neu6b-io-rk3588_defconfig               |  1 -
>  configs/nova-rk3588s_defconfig                  |  1 -
>  configs/odroid-go2_defconfig                    |  1 -
>  configs/odroid-m1-rk3568_defconfig              |  1 -
>  configs/odroid-m1s-rk3566_defconfig             |  1 -
>  configs/odroid-m2-rk3588s_defconfig             |  1 -
>  configs/omni3576-rk3576_defconfig               |  1 -
>  configs/orangepi-3b-rk3566_defconfig            |  1 -
>  configs/orangepi-5-max-rk3588_defconfig         |  1 -
>  configs/orangepi-5-plus-rk3588_defconfig        |  1 -
>  configs/orangepi-5-rk3588s_defconfig            |  1 -
>  configs/orangepi-5-ultra-rk3588_defconfig       |  1 -
>  configs/pinetab2-rk3566_defconfig               |  1 -
>  configs/powkiddy-x55-rk3566_defconfig           |  1 -
>  configs/px30-core-ctouch2-of10-px30_defconfig   |  1 -
>  configs/px30-core-ctouch2-px30_defconfig        |  1 -
>  configs/px30-core-edimm2.2-px30_defconfig       |  1 -
>  configs/qnap-ts433-rk3568_defconfig             |  1 -
>  configs/quartz64-a-rk3566_defconfig             |  1 -
>  configs/quartz64-b-rk3566_defconfig             |  1 -
>  configs/quartzpro64-rk3588_defconfig            |  1 -
>  configs/radxa-cm3-io-rk3566_defconfig           |  1 -
>  configs/radxa-e20c-rk3528_defconfig             |  1 -
>  configs/radxa-e25-rk3568_defconfig              |  1 -
>  configs/radxa-zero-3-rk3566_defconfig           |  1 -
>  configs/ringneck-px30_defconfig                 |  1 -
>  configs/roc-cc-rk3308_defconfig                 |  1 -
>  configs/roc-pc-rk3576_defconfig                 |  1 -
>  configs/roc-pc-rk3588s_defconfig                |  1 -
>  configs/rock-2-rk3528_defconfig                 |  1 -
>  configs/rock-3a-rk3568_defconfig                |  1 -
>  configs/rock-3b-rk3568_defconfig                |  1 -
>  configs/rock-3c-rk3566_defconfig                |  1 -
>  configs/rock-4d-rk3576_defconfig                |  1 -
>  configs/rock-5-itx-rk3588_defconfig             |  1 -
>  configs/rock-5c-rk3588s_defconfig               |  1 -
>  configs/rock-pi-s-rk3308_defconfig              |  1 -
>  configs/rock-s0-rk3308_defconfig                |  1 -
>  configs/rock5a-rk3588s_defconfig                |  1 -
>  configs/rock5b-rk3588_defconfig                 |  1 -
>  configs/sige1-rk3528_defconfig                  |  1 -
>  configs/sige5-rk3576_defconfig                  |  1 -
>  configs/sige7-rk3588_defconfig                  |  1 -
>  configs/soquartz-blade-rk3566_defconfig         |  1 -
>  configs/soquartz-cm4-rk3566_defconfig           |  1 -
>  configs/soquartz-model-a-rk3566_defconfig       |  1 -
>  configs/tiger-rk3588_defconfig                  |  1 -
>  configs/toybrick-rk3588_defconfig               |  1 -
>  configs/turing-rk1-rk3588_defconfig             |  1 -
>  drivers/clk/rockchip/clk_rk3288.c               |  2 +-
>  drivers/clk/rockchip/clk_rk3399.c               |  2 +-
>  drivers/ram/rockchip/sdram_rk3288.c             |  2 +-
>  drivers/ram/rockchip/sdram_rk3399.c             |  2 +-
>  drivers/video/rockchip/rk3288_mipi.c            |  2 +-
>  drivers/video/rockchip/rk3399_mipi.c            |  2 +-
>  drivers/video/rockchip/rk_mipi.c                |  2 +-
>  110 files changed, 229 insertions(+), 206 deletions(-)
> ---
> base-commit: b8e0086b585791a771416ce51b58ce0097bc0b28
> change-id: 20260908-reset-e69a40d3f5c6
> 
> Best regards,
> --  
> Massimo Pegorer <massimo.pegorer+oss@gmail.com>

