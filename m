Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BE9606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 20:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=U5/FUHlz;
	dkim=pass (2048-bit key, unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=xz2sug3J
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8518460DA9;
	Wed, 11 Nov 2026 20:05:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UQz__sivet8w; Wed, 11 Nov 2026 20:05:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7223360D9B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794427520;
	b=RvQkE/9LMkLK5odGgsx9X1qFnUx8sTLrZVnpeY9hoW5KBDcdEjrUA+U+cNbSEq16hIo2
	 fAiIOM23IzQ37biO+8SZFpm3xfvYyljqhqQKyB3sRxeQKcu1W+6IU75P+tDOgKM5P5kQh
	 /vZut9h7PWK+9AjWRnobDmqIeUH5ZvE6AKx+4D2hJD2MO5yCGPP2cjtKYsneRHO8bzuCZ
	 roeqSDQGyfOREayFWaodaM7Okd7gbgrSZ3/2zCyDe8oRx0C69v/6zBWfHbpjCkr+AuYpe
	 Wgon7Nj5/8fm09r05v2z+AFQ1pQdF0oTOZI/gWVqvyWGLlTWIkp7WQkC+CMSBD9iEfg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794427520;
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
	bh=AswuVM0Ea6Y2537bxa0VLKCHDW2LQscQMES3+2NdINI=;
	b=e7yllK+J9v1K4pTn08YuyMrszFH9VoNSKyuB61fBGQ/mtxgbSQvtDxtmlc3Dl84CVFDw
	 /VxBYU+43lDbk7vp+zlgf6f832BdSF8ifLBB6BIIwg2JbH30Nb35KVOtUj4326Q15eA10
	 mmYRm61VW1dBGT5HYz6d0PVsUb4MajAAQWD/kSAGsz2K873HUEydYBr6mH2S4e7iwNB4n
	 2XdnzAWXK//ncjQd37HuJRqArZ6M9Iw01lly1CunJU/fc1OS1t8KQBY7Gt8kiCAaljVLt
	 E33nFQNCmILygXBfg/h02np5H+4epnZA6gHpcgPvw6Q7FPqNM/BLmcxDrkwlJIqRdpQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794427520;
	bh=AswuVM0Ea6Y2537bxa0VLKCHDW2LQscQMES3+2NdINI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U5/FUHlzijH0hhE1vjtRjpBgXtjiF5hgbjnHT89ZX6VmJskix+38teZE2kdDCfNQU
	 PHAan8GUiYmkXw/r8D9tisporqdMLVI6jYNoqdYxiY58B+zB43eCF1SR6eCvZ3HTle
	 dbcwz56TWPtGULncmz1WLVe9zWFSM5eEaVKEXUp628YDvf5Fz1X9dxq4AtJ065PB+A
	 7+l6yqeRO22CgPn0yLnYkwcrJZslqYGRRAnXmbnub8SU+pfehl6TV9jrh40ytXB/Y5
	 VdBKHUHXSau9/aepKUv3ioWZl5NABgEMvw/i9Qt7XZQkxIPN+FyITdL03C7dyBz/5p
	 ykSf/iZ+u9eFg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7223360D9B;
	Wed, 11 Nov 2026 20:05:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8676E2FE
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:05:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6BACE81ED4
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:05:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jop7bjmsvQ4S for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 20:05:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8DA2C81ED6
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=33c1=jb=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=xz2sug3J
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8DA2C81ED6
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From:
 Content-Language: References: Cc: To: Subject: MIME-Version: Date:
 Message-ID; q=dns/txt; s=fe-e1b5cab7be; t=1794427515;
 bh=AswuVM0Ea6Y2537bxa0VLKCHDW2LQscQMES3+2NdINI=;
 b=xz2sug3JxOPEWg+JG2b3dyix0uHQwk05QdiSST0HtldMrfG9ijvTJG+IeGgOC2gkkxc4JGrF2
 kKkb0os+ryE1+jkW/PnAV8R17dltQ58f0fv++J7Xrhkgp3aEL5zWh6OA6p0TJgBncyCAX1aGYPa
 882acFN05qulmLe9DfaqnidfiMD6RmPTAIlJm8nE7KFUUCfYF34Aceg4HeUq/2FRgrC4Qmsddkg
 bMerD5IB8lfbCqFPOcWqOHqkL1IdrT8BAGG4/mOvrAG42xLmGQCVeaNLuVb0akIqOwTWIt/NeWV
 RiTZQbMQ13WcCnQXBBGDd9Q0yX+gL7WbIu/VzQ8qzHNA==
X-Forward-Email-ID: 6af4ca78e9f47b241c602f17
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.19.18
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <5f481ac3-f885-4b14-a67e-680f2d9f36f1@kwiboo.se>
Date: Wed, 11 Nov 2026 21:05:06 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] board: rockchip: Add LCKFB TaishanPi 3M
To: Xuechao Han <220110626hanxuechao@alu.hit.edu.cn>,
 Quentin Schulz <u-boot@0leil.net>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.u-boot-project.org
References: <20261111165135.245826-1-220110626hanxuechao@alu.hit.edu.cn>
 <179441628581.251684.11046053143224226025@alu.hit.edu.cn>
 <7f90a097-1b57-417d-9e35-d66b1cf898f1@0leil.net>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <7f90a097-1b57-417d-9e35-d66b1cf898f1@0leil.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 11/11/2026 6:51 PM, Quentin Schulz wrote:
> Hi Xuechao Han,
> 
> On 11/11/26 5:58 PM, Xuechao Han wrote:
>> Hi Quentin,
>>
>> I sent the v2 patch a moment ago; the changelog in it is only a short
>> summary, so here are the detailed replies to your comments.
>>
> 
> When there's still an open discussion on some part(s) of the review, 
> please do not send a new version until we've agreed on the outcome of 
> said discussion(s).
> 
>>> issue: Device Tree is a representation of the HW, so hacks are not
>>> welcome there
>>
>> The DWMMC driver does not use cd-gpios at all: its get_cd callback reads
>> the controller's internal CDETECT register, so supporting cd-gpios there
>> would mean adding a generic GPIO card-detect path to dw_mmc, which affects
>> every dw_mmc platform and cannot be validated on the hardware I have.
> 
> That's exactly what I'm asking you to do. Adapt the driver to support 
> your use-case. If other boards also use cd-gpios and you break them by 
> adding support for cd-gpios, then they probably had an incorrect Device 
> Tree to begin with and they'll need to fix it.
> 
>> This pinmux is also very common in the same SoC family - rk3576-evb1-v10,
>> rk3576-evb2-v10, rk3576-nanopi-r76s and rk3576-nanopi-m5 all select
>> sdmmc0_det in their pinctrl - so I followed the same pattern for this
>> board. With that, the SD card works in 4-bit high-speed mode.
>>
> 
> It doesn't matter what other boards do if they do things differently at 
> the hardware level. If they do the same thing at hardware level, it 
> might still be they are doing things wrong and doing it the right way is 
> better than doing it wrong because everybody's doing it wrong. Jonas 
> said[1] that other boards seem to be doing it wrong and they probably 
> should get their pinctrl fixed as well.
> 
> Does the SD card work in Linux with sdmmc0_det_l? If yes, then it means 
> the Device Tree is likely correct and we need to adapt U-Boot driver to 
> support it, not hack the Device Tree in U-Boot only to make it work with 
> the U-Boot driver.
> 
> You have two options:
> - fix the Device Tree in the Linux kernel so it uses sdmmc0_det instead 
> of sdmmc_det_l, and remove cd-gpios. Your "U-Boot doesn't support 
> cd-gpios" justification for doing this change will not convince the 
> Linux kernel maintainer. You can try, but I'm pretty sure you won't get 
> positive feedback on it.
> - add support for cd-gpios in dwmmc driver in U-Boot.

The cd-gpios should typically only be needed for cases when a different pad
is used for card detection signal or when card detection is not triggered
using the controller detection logic due to e.g. controller detection not
working when powered down and GPIO func instead can help detect when a card
is inserted and power on the controller (rk3588 if I am not mistaken).

Not sure rk3576 has similar detection issue, if a new card can be detected
by Linux using internal CDETECT (no cd-gpios) after being powered on without
a card inserted there should likely not be any need to use the GPIO func mux
(with cd-gpios) for the board.

> 
> [1] 
> https://lore.kernel.org/u-boot/13bfc090-7a2b-4215-9926-259633840359@kwiboo.se/
> 
>>> question: what are you trying to do/prevent here?
>>> For the boot targets, do you really always want to try eMMC first, and
>>> then SD?
>>> Unsure why you want to limit the possible bootmeths?
>>
>> You are right, v2 no longer overrides bootcmd or boot_targets; both keep
>> their defaults (bootcmd is "bootflow scan -lb" and boot_targets comes from
>> rockchip-common.h). The only remaining deviation is
> 
> You had mmc0 before mmc1 in v1, but now it would be mmc1 before mmc0. 
> Are you sure this is what you want? (I don't care, I'm just saying the 
> behavior changes between your v1 and v2)
> 
>> "# CONFIG_BOOTMETH_EFI_BOOTMGR is not set".
>>
>> The reason is that the EFI boot manager is a global boot method, so it
>> runs before any normal boot method. On this board it took over the boot
>> flow and booted the EFI payload on the SD card before boot.scr could run.

This sounds like a strange behavior, the efi bootmgr should normally be
deferred until just before 'slow' boot media is probed (network), starting
from v2026.01-rc1. Could it be BOOTMETH_EFILOADER behavior you are observing
and possible want to disable?

Regards,
Jonas

>> The board has quite a few optional peripherals that need device tree
>> overlays, which we apply from boot.scr, so boot.scr must get a chance to
>> run before any EFI payload. The 'efi' boot method stays enabled, so an
> 
> How do you know which overlays to apply at runtime? What does your 
> script do?
> 
> [...]
> 
>>> nitpick: remove clock-names from CONFIG_OF_SPL_REMOVE_PROPS
>>
>> I kept it on purpose: all eight RK3576 defconfigs in U-Boot use exactly
>> the same CONFIG_OF_SPL_REMOVE_PROPS value, so I would rather not diverge
>> from them here. If you still prefer it removed, I can drop it.
>>
> 
> Please drop. I'll eventually clean up the various defconfigs with 
> CONFIG_OF_SPL_REMOVE_PROPS, but I don't see why clock-names should be 
> removed from SPL DTB.
> 
>>> question: why not enabling SATA?
>>
>> The mini-PCIe style connector is configured as SATA in the board device
>> tree (&sata0 is okay, for Linux), and the same serdes lanes can also be
>> re-routed to PCIe or USB by an overlay. I have no SATA device available
>> for testing, so I did not enable it.
>>
> 
> OK.
> 
>> Also sorry about the missing Cc last time; I have passed the Cc list
>> explicitly to git send-email this time.
>>
> 
> Consider using b4[1], it makes contribution *much* easier.
> 
> [1] https://b4.docs.kernel.org/en/latest/contributor/overview.html
> 
> Cheers,
> Quentin

