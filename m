Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25751C531F9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 12:38:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DB4B84076D;
	Fri, 24 Jul 2026 12:38:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ncyS81j3u-lM; Fri, 24 Jul 2026 12:38:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9FF4A40787
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784896692;
	bh=kbzCwHUdszvZzw//dAbiymqHcp+q/5oXY8Kjp93J454=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=mosoNzmCUscFfQZbkSKdCgzRcrFuHq9/TIAhx1lUDueaGqptSZgABWABrlqskXL3t
	 Sm09R87gQCvSfGu/OcbYc/+NaJzDhjGPuDlUhP904Ij/d6mO5VtnqSE2jqapICV7I+
	 FltA3XNWpdcKTeU0NjdTzigLfrrMz8zrDgQ/Gt4nRasNowFvNLliFtDkMxcBxYC1qB
	 O4srZU3dsE71WS4WWEynVzSZUuPWs4VMhejJ1qFGcV2hN3cO2iNepZncxkXBRpD2TE
	 0bOSipU++g4qGtbmxxUkLvR7oY5x/hA4aQrUfYCDOnIyk7/ntogl47BVakaGL9zhPo
	 kf7pnflfGKpeg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9FF4A40787;
	Fri, 24 Jul 2026 12:38:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8FFDC429
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 12:38:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2B118606A6
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 12:38:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A-dx8MiGipy5 for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 12:38:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=203.137.112.168;
 helo=mx0.gmx.wtf; envelope-from=u-boot@vicb.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6465960B56
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6465960B56
Received: from mx0.gmx.wtf (mx0.gmx.wtf [203.137.112.168])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6465960B56
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 12:38:08 +0000 (UTC)
Date: Fri, 24 Jul 2026 14:38:02 +0200
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.u-boot-project.org
Subject: Re: RK3399 TF-A hash verification failure for atf-3
Message-ID: <amNcqiirO1PbPS9H@localhost>
References: <alujuCnNh13eRfdA@vicb.net>
 <56c497f8-4109-42a4-95df-7c0e0b6277e8@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56c497f8-4109-42a4-95df-7c0e0b6277e8@cherry.de>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vicb.net; 
 s=f747d04263f05989; t=1784896686;
 bh=kbzCwHUdszvZzw//dAbiymqHcp+q/5oXY8Kjp93J454=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ftmKqS3TKY33xyRK5BHom3kVyOCODnSQxQlqxXylyhGDF1iCc27F188I3hI41w2Xv
 BoDjGhqJM0XjSNWvcujX5K6Kq4vxL04fZsSvjmhj4DIk5PzCnANFzhtP1srdWGH4cS
 cLpmCKICQDVIgzoyefAPv3z8JFj3CMnXFNlPmqLMuAEIjk3SIlbfz8gtIHAApA5mvC
 XaHttBWD1WLTtYXfesufAD8YYBpMzdFNhN9NZ4WF41ObtvuhqnwF8IogybIGHvRBCP
 lVwskLeBDzK0avcRgCMqLuO/x6FTL6ENHcEB00BkQv2EKUGKpk1yg9B4+BYNpkeCXp
 4/Ri4WZ2C6uTQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=vicb.net
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=vicb.net header.i=@vicb.net header.a=rsa-sha256
 header.s=f747d04263f05989 header.b=ftmKqS3T
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
From: Vic B via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Vic B <u-boot@vicb.net>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Wed, Jul 22, 2026 at 07:12:42PM +0200, Quentin Schulz wrote:
> Hi Vic,

Hi Quentin,

> 
> Debian toolchain issue, reported to TF-A last year, see https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/36981/comments/877be809_5abf10d8.
> We wanted to rely on Debian upgrading at some point their TF-A, hitting the
> same issue and working on it but it seems they are stuck on lts-v2.12.1
> (which is slightly concerning considering we're at lts-v2.12.12 already) so
> this hasn't happened yet. I'm building on Fedora and my company's CI has
> lts-v2.12 pinned to avoid this issue, so I'm not going to be chasing this
> myself. Can you try to work this out with Debian maybe? You're not the
> first, not the last I suspect either.

Thanks for the link, I think that Chris Kay's comment there is really
valuable, so let me quote it here:

 "It's not necessarily the case that the Debian GCC distribution is buggy!

 What we presume has happened is that an object with a strict page
 alignment has had to shift to the next page due to an increase in
 code/data size. This happens from time to time and is generally
 harmless, but if we we've hit a memory limit somewhere then this is the
 sort of error we see. That we don't see this on other distributions of
 GCC is likely just down to configuration differences."

I think that Chris is right, and have doubts about the assumption that
Debian folks will start working on this issue and fix their gcc after
their TF-A package gets updated. If Debian's maintainers of TF-A happen
to test the new version on RK3399, this path may result in a deadlock
where the new TF-A doesn't get to Debian because it fails to build,
so it won't push Debian do fix their gcc...

The Armbian's attempt to fix the issue by increasing PMUSRAM_RSIZE
in plat/rockchip/rk3399/include/shared/addressmap_shared.h from 8K
to 16K seems like more promising course to me - although the resulting
build with oversized pmusram isn't really usable, it produces much more
material to investigate than the "`PMUSRAM' overflowed by 3928 bytes"
message that one gets without this change.

With the PMUSRAM_RSIZE set to 16K, the build results in bl31.elf with
oversized .pmusram section (which can be extracted with objcopy and
hexdumped to see that something there obviously gets aligned to 8 KiB
boundary), and objdump of bl31.elf shows that this (mis)aligned part at
address 0xff3b2000 is rk3399m0pmu_bin (dump follows below in P.S.), which
seems to be linked using plat/rockchip/rk3399/drivers/pmu/pmu_fw.S,
which only requests it to be aligned to 4 bytes:

 .macro INCBIN file sym sec
         .section \sec, "a"
         .global \sym
         .type \sym, @object
         .align 4
 \sym :
         .incbin "\file"
         .size \sym , .-\sym
         .global \sym\()_end
 \sym\()_end :
 .endm
  
 INCBIN RK3399M0FW, "rk3399m0_bin", ".sram.incbin"
 INCBIN RK3399M0PMUFW, "rk3399m0pmu_bin", ".pmusram.incbin"

So what happens here seems to be gcc aligning to 8 KiB when asked to
align to 4 B. That really looks like page alignment issues as suggested
by Chris, and doesn't necessarily mean a bug in gcc - there's only a
directive to align to 4 B boundary, and that one is fulfilled even
with the 8 KiB alignment; gcc can even be credited for fulfilling the
directive 2048 times...

I'll try to look into this over the weekend and find some linker
options or directives to get the page alignment under control.
As I'm not really familiar with this, suggestions are welcome!

Cheers,

Vic

P.S.: here's the promised dump of the oversized .pmusram section:

 $ aarch64-linux-gnu-objdump -j .pmusram -d build/rk3399/release/bl31/bl31.elf
 
 build/rk3399/release/bl31/bl31.elf:     file format elf64-littleaarch64
 
 
 Disassembly of section .pmusram:
 
 00000000ff3b0000 <pmu_cpuson_entrypoint>:
     ff3b0000:	580000c2 	ldr	x2, ff3b0018 <sys_resume+0x8>
     ff3b0004:	9100005f 	mov	sp, x2
     ff3b0008:	940001d1 	bl	ff3b074c <dmc_resume>
     ff3b000c:	940003bf 	bl	ff3b0f08 <__sram_restore_veneer>
 
 00000000ff3b0010 <sys_resume>:
     ff3b0010:	940003ba 	bl	ff3b0ef8 <__bl31_warm_entrypoint_veneer>
     ff3b0014:	00000000 	udf	#0
     ff3b0018:	ff8c3000 	.word	0xff8c3000
     ff3b001c:	00000000 	.word	0x00000000
 
 00000000ff3b0020 <sram_regcpy>:
     ff3b0020:	cb010000 	sub	x0, x0, x1
     ff3b0024:	51000442 	sub	w2, w2, #0x1
     ff3b0028:	3100045f 	cmn	w2, #0x1
     ff3b002c:	54000041 	b.ne	ff3b0034 <sram_regcpy+0x14>  // b.any
     ff3b0030:	d65f03c0 	ret
     ff3b0034:	b9400023 	ldr	w3, [x1]
     ff3b0038:	b8216803 	str	w3, [x0, x1]
     ff3b003c:	91001021 	add	x1, x1, #0x4
     ff3b0040:	17fffff9 	b	ff3b0024 <sram_regcpy+0x4>
 
 00000000ff3b0044 <sram_udelay>:
     ff3b0044:	d53be021 	mrs	x1, cntpct_el0
     ff3b0048:	7100281f 	cmp	w0, #0xa
     ff3b004c:	52812c02 	mov	w2, #0x960                 	// #2400
     ff3b0050:	52801e00 	mov	w0, #0xf0                  	// #240
     ff3b0054:	1a820000 	csel	w0, w0, w2, eq	// eq = none
     ff3b0058:	d53be023 	mrs	x3, cntpct_el0
     ff3b005c:	6b03003f 	cmp	w1, w3
     ff3b0060:	4b010062 	sub	w2, w3, w1
     ff3b0064:	1a9f97e3 	cset	w3, hi	// hi = pmore
     ff3b0068:	4b030042 	sub	w2, w2, w3
     ff3b006c:	6b00005f 	cmp	w2, w0
     ff3b0070:	54ffff49 	b.ls	ff3b0058 <sram_udelay+0x14>  // b.plast
     ff3b0074:	d65f03c0 	ret
 
 00000000ff3b0078 <rkclk_ddr_reset>:
     ff3b0078:	531e0000 	ubfiz	w0, w0, #2, #1
     ff3b007c:	11002004 	add	w4, w0, #0x8
     ff3b0080:	11006003 	add	w3, w0, #0x18
     ff3b0084:	1ac42021 	lsl	w1, w1, w4
     ff3b0088:	11002404 	add	w4, w0, #0x9
     ff3b008c:	11006400 	add	w0, w0, #0x19
     ff3b0090:	1ac42042 	lsl	w2, w2, w4
     ff3b0094:	2a020021 	orr	w1, w1, w2
     ff3b0098:	52800022 	mov	w2, #0x1                   	// #1
     ff3b009c:	1ac02040 	lsl	w0, w2, w0
     ff3b00a0:	1ac32042 	lsl	w2, w2, w3
     ff3b00a4:	2a020000 	orr	w0, w0, w2
     ff3b00a8:	2a000021 	orr	w1, w1, w0
     ff3b00ac:	d2808200 	mov	x0, #0x410                 	// #1040
     ff3b00b0:	f2bfeec0 	movk	x0, #0xff76, lsl #16
     ff3b00b4:	b9000001 	str	w1, [x0]
     ff3b00b8:	d65f03c0 	ret
 
 00000000ff3b00bc <select_per_cs_training_index>:
     ff3b00bc:	52842a03 	mov	w3, #0x2150                	// #8528
     ff3b00c0:	53114002 	lsl	w2, w0, #15
     ff3b00c4:	72bff503 	movk	w3, #0xffa8, lsl #16
     ff3b00c8:	0b003c60 	add	w0, w3, w0, lsl #15
     ff3b00cc:	b9400000 	ldr	w0, [x0]
     ff3b00d0:	368001c0 	tbz	w0, #16, ff3b0108 <select_per_cs_training_index+0x4c>
     ff3b00d4:	5155f443 	sub	w3, w2, #0x57d, lsl #12
     ff3b00d8:	5155f442 	sub	w2, w2, #0x57d, lsl #12
     ff3b00dc:	53081c21 	lsl	w1, w1, #24
     ff3b00e0:	513f8063 	sub	w3, w3, #0xfe0
     ff3b00e4:	511f8042 	sub	w2, w2, #0x7e0
     ff3b00e8:	2a0303e4 	mov	w4, w3
     ff3b00ec:	11080063 	add	w3, w3, #0x200
     ff3b00f0:	b9400080 	ldr	w0, [x4]
     ff3b00f4:	12077800 	and	w0, w0, #0xfeffffff
     ff3b00f8:	2a010000 	orr	w0, w0, w1
     ff3b00fc:	b9000080 	str	w0, [x4]
     ff3b0100:	6b02007f 	cmp	w3, w2
     ff3b0104:	54ffff21 	b.ne	ff3b00e8 <select_per_cs_training_index+0x2c>  // b.any
     ff3b0108:	d65f03c0 	ret
 
 00000000ff3b010c <data_training.constprop.0>:
     ff3b010c:	2a0003e1 	mov	w1, w0
     ff3b0110:	d2800482 	mov	x2, #0x24                  	// #36
     ff3b0114:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
     ff3b0118:	aa0103e6 	mov	x6, x1
     ff3b011c:	d0000000 	adrp	x0, ff3b2000 <rk3399m0pmu_bin>
     ff3b0120:	9b027c21 	mul	x1, x1, x2
     ff3b0124:	91090000 	add	x0, x0, #0x240
     ff3b0128:	910003fd 	mov	x29, sp
     ff3b012c:	a90153f3 	stp	x19, x20, [sp, #16]
     ff3b0130:	3861680b 	ldrb	w11, [x0, x1]
     ff3b0134:	39413000 	ldrb	w0, [x0, #76]
     ff3b0138:	71001c1f 	cmp	w0, #0x7
     ff3b013c:	540013a1 	b.ne	ff3b03b0 <data_training.constprop.0+0x2a4>  // b.any
     ff3b0140:	7100057f 	cmp	w11, #0x1
     ff3b0144:	528001e9 	mov	w9, #0xf                   	// #15
     ff3b0148:	528000a1 	mov	w1, #0x5                   	// #5
     ff3b014c:	1a811129 	csel	w9, w9, w1, ne	// ne = any
     ff3b0150:	5285cf88 	mov	w8, #0x2e7c                	// #11900
     ff3b0154:	531140c5 	lsl	w5, w6, #15
     ff3b0158:	72bff508 	movk	w8, #0xffa8, lsl #16
     ff3b015c:	0b063d08 	add	w8, w8, w6, lsl #15
     ff3b0160:	b9400101 	ldr	w1, [x8]
     ff3b0164:	320a0021 	orr	w1, w1, #0x400000
     ff3b0168:	b9000101 	str	w1, [x8]
     ff3b016c:	71001c1f 	cmp	w0, #0x7
     ff3b0170:	540013a0 	b.eq	ff3b03e4 <data_training.constprop.0+0x2d8>  // b.none
     ff3b0174:	7100181f 	cmp	w0, #0x6
     ff3b0178:	54001240 	b.eq	ff3b03c0 <data_training.constprop.0+0x2b4>  // b.none
     ff3b017c:	71000c1f 	cmp	w0, #0x3
     ff3b0180:	54001360 	b.eq	ff3b03ec <data_training.constprop.0+0x2e0>  // b.none
     ff3b0184:	52801fea 	mov	w10, #0xff                  	// #255
     ff3b0188:	5155fca7 	sub	w7, w5, #0x57f, lsl #12
     ff3b018c:	5280000c 	mov	w12, #0x0                   	// #0
     ff3b0190:	5119c0e7 	sub	w7, w7, #0x670
     ff3b0194:	5280002d 	mov	w13, #0x1                   	// #1
     ff3b0198:	1acc21a0 	lsl	w0, w13, w12
     ff3b019c:	6a09001f 	tst	w0, w9
     ff3b01a0:	54000540 	b.eq	ff3b0248 <data_training.constprop.0+0x13c>  // b.none
     ff3b01a4:	2a0c03e1 	mov	w1, w12
     ff3b01a8:	2a0603e0 	mov	w0, w6
     ff3b01ac:	97ffffc4 	bl	ff3b00bc <select_per_cs_training_index>
     ff3b01b0:	5155f4ae 	sub	w14, w5, #0x57d, lsl #12
     ff3b01b4:	b94000e0 	ldr	w0, [x7]
     ff3b01b8:	5155fca1 	sub	w1, w5, #0x57f, lsl #12
     ff3b01bc:	511a4021 	sub	w1, w1, #0x690
     ff3b01c0:	5155fca3 	sub	w3, w5, #0x57f, lsl #12
     ff3b01c4:	12167400 	and	w0, w0, #0xfffffcff
     ff3b01c8:	5155f4a4 	sub	w4, w5, #0x57d, lsl #12
     ff3b01cc:	32170000 	orr	w0, w0, #0x200
     ff3b01d0:	b90000e0 	str	w0, [x7]
     ff3b01d4:	5155f4af 	sub	w15, w5, #0x57d, lsl #12
     ff3b01d8:	12a06022 	mov	w2, #0xfcfeffff            	// #-50397185
     ff3b01dc:	b9400020 	ldr	w0, [x1]
     ff3b01e0:	51152063 	sub	w3, w3, #0x548
     ff3b01e4:	511ec084 	sub	w4, w4, #0x7b0
     ff3b01e8:	5116c1ce 	sub	w14, w14, #0x5b0
     ff3b01ec:	0a020000 	and	w0, w0, w2
     ff3b01f0:	510ec1ef 	sub	w15, w15, #0x3b0
     ff3b01f4:	2a0c6000 	orr	w0, w0, w12, lsl #24
     ff3b01f8:	52850410 	mov	w16, #0x2820                	// #10272
     ff3b01fc:	32100000 	orr	w0, w0, #0x10000
     ff3b0200:	52850011 	mov	w17, #0x2800                	// #10240
     ff3b0204:	b9000020 	str	w0, [x1]
     ff3b0208:	b9400062 	ldr	w2, [x3]
     ff3b020c:	b9400080 	ldr	w0, [x4]
     ff3b0210:	b94001d3 	ldr	w19, [x14]
     ff3b0214:	b94001f2 	ldr	w18, [x15]
     ff3b0218:	53087c41 	lsr	w1, w2, #8
     ff3b021c:	2a130000 	orr	w0, w0, w19
     ff3b0220:	0a422202 	and	w2, w16, w2, lsr #8
     ff3b0224:	2a120000 	orr	w0, w0, w18
     ff3b0228:	531e7c00 	lsr	w0, w0, #30
     ff3b022c:	6b11005f 	cmp	w2, w17
     ff3b0230:	54000cc1 	b.ne	ff3b03c8 <data_training.constprop.0+0x2bc>  // b.any
     ff3b0234:	35000d00 	cbnz	w0, ff3b03d4 <data_training.constprop.0+0x2c8>
     ff3b0238:	5155fca0 	sub	w0, w5, #0x57f, lsl #12
     ff3b023c:	5287ef81 	mov	w1, #0x3f7c                	// #16252
     ff3b0240:	51151000 	sub	w0, w0, #0x544
     ff3b0244:	b9000001 	str	w1, [x0]
     ff3b0248:	1100058c 	add	w12, w12, #0x1
     ff3b024c:	7100119f 	cmp	w12, #0x4
     ff3b0250:	54fffa41 	b.ne	ff3b0198 <data_training.constprop.0+0x8c>  // b.any
     ff3b0254:	b94000e0 	ldr	w0, [x7]
     ff3b0258:	12167400 	and	w0, w0, #0xfffffcff
     ff3b025c:	b90000e0 	str	w0, [x7]
     ff3b0260:	5155fca7 	sub	w7, w5, #0x57f, lsl #12
     ff3b0264:	5155f4ad 	sub	w13, w5, #0x57d, lsl #12
     ff3b0268:	5284140e 	mov	w14, #0x20a0                	// #8352
     ff3b026c:	511c40e7 	sub	w7, w7, #0x710
     ff3b0270:	513581ad 	sub	w13, w13, #0xd60
     ff3b0274:	5280000c 	mov	w12, #0x0                   	// #0
     ff3b0278:	72bff50e 	movk	w14, #0xffa8, lsl #16
     ff3b027c:	6b0c017f 	cmp	w11, w12
     ff3b0280:	54000ba8 	b.hi	ff3b03f4 <data_training.constprop.0+0x2e8>  // b.pmore
     ff3b0284:	5155f4a0 	sub	w0, w5, #0x57d, lsl #12
     ff3b0288:	5155f4a3 	sub	w3, w5, #0x57d, lsl #12
     ff3b028c:	513f8000 	sub	w0, w0, #0xfe0
     ff3b0290:	511f8063 	sub	w3, w3, #0x7e0
     ff3b0294:	2a0003e2 	mov	w2, w0
     ff3b0298:	b9400041 	ldr	w1, [x2]
     ff3b029c:	32100021 	orr	w1, w1, #0x10000
     ff3b02a0:	b9000041 	str	w1, [x2]
     ff3b02a4:	11037002 	add	w2, w0, #0xdc
     ff3b02a8:	11080000 	add	w0, w0, #0x200
     ff3b02ac:	b9400041 	ldr	w1, [x2]
     ff3b02b0:	72a04001 	movk	w1, #0x200, lsl #16
     ff3b02b4:	b9000041 	str	w1, [x2]
     ff3b02b8:	6b00007f 	cmp	w3, w0
     ff3b02bc:	54fffec1 	b.ne	ff3b0294 <data_training.constprop.0+0x188>  // b.any
     ff3b02c0:	5155fca0 	sub	w0, w5, #0x57f, lsl #12
     ff3b02c4:	5155f4ad 	sub	w13, w5, #0x57d, lsl #12
     ff3b02c8:	51338000 	sub	w0, w0, #0xce0
     ff3b02cc:	5284158e 	mov	w14, #0x20ac                	// #8364
     ff3b02d0:	513551ad 	sub	w13, w13, #0xd54
     ff3b02d4:	5280000c 	mov	w12, #0x0                   	// #0
     ff3b02d8:	72bff50e 	movk	w14, #0xffa8, lsl #16
     ff3b02dc:	b9400001 	ldr	w1, [x0]
     ff3b02e0:	32180021 	orr	w1, w1, #0x100
     ff3b02e4:	b9000001 	str	w1, [x0]
     ff3b02e8:	b94000e0 	ldr	w0, [x7]
     ff3b02ec:	12167400 	and	w0, w0, #0xfffffcff
     ff3b02f0:	b90000e0 	str	w0, [x7]
     ff3b02f4:	5155fca7 	sub	w7, w5, #0x57f, lsl #12
     ff3b02f8:	511b00e7 	sub	w7, w7, #0x6c0
     ff3b02fc:	6b0c017f 	cmp	w11, w12
     ff3b0300:	54000dc8 	b.hi	ff3b04b8 <data_training.constprop.0+0x3ac>  // b.pmore
     ff3b0304:	b94000e0 	ldr	w0, [x7]
     ff3b0308:	12067400 	and	w0, w0, #0xfcffffff
     ff3b030c:	b90000e0 	str	w0, [x7]
     ff3b0310:	371817aa 	tbnz	w10, #3, ff3b0604 <data_training.constprop.0+0x4f8>
     ff3b0314:	3620198a 	tbz	w10, #4, ff3b0644 <data_training.constprop.0+0x538>
     ff3b0318:	5155fca7 	sub	w7, w5, #0x57f, lsl #12
     ff3b031c:	5280000a 	mov	w10, #0x0                   	// #0
     ff3b0320:	511840e7 	sub	w7, w7, #0x610
     ff3b0324:	5280002b 	mov	w11, #0x1                   	// #1
     ff3b0328:	1aca2160 	lsl	w0, w11, w10
     ff3b032c:	6a09001f 	tst	w0, w9
     ff3b0330:	540017e0 	b.eq	ff3b062c <data_training.constprop.0+0x520>  // b.none
     ff3b0334:	2a0a03e1 	mov	w1, w10
     ff3b0338:	2a0603e0 	mov	w0, w6
     ff3b033c:	97ffff60 	bl	ff3b00bc <select_per_cs_training_index>
     ff3b0340:	5155fca0 	sub	w0, w5, #0x57f, lsl #12
     ff3b0344:	529fdfe2 	mov	w2, #0xfeff                	// #65279
     ff3b0348:	5114b000 	sub	w0, w0, #0x52c
     ff3b034c:	72bfff82 	movk	w2, #0xfffc, lsl #16
     ff3b0350:	52860803 	mov	w3, #0x3040                	// #12352
     ff3b0354:	b9400001 	ldr	w1, [x0]
     ff3b0358:	12177821 	and	w1, w1, #0xfffffeff
     ff3b035c:	b9000001 	str	w1, [x0]
     ff3b0360:	5155fca1 	sub	w1, w5, #0x57f, lsl #12
     ff3b0364:	b94000e0 	ldr	w0, [x7]
     ff3b0368:	51187021 	sub	w1, w1, #0x61c
     ff3b036c:	120e7400 	and	w0, w0, #0xfffcffff
     ff3b0370:	320f0000 	orr	w0, w0, #0x20000
     ff3b0374:	b90000e0 	str	w0, [x7]
     ff3b0378:	b9400020 	ldr	w0, [x1]
     ff3b037c:	0a020000 	and	w0, w0, w2
     ff3b0380:	2a0a4000 	orr	w0, w0, w10, lsl #16
     ff3b0384:	32180000 	orr	w0, w0, #0x100
     ff3b0388:	b9000020 	str	w0, [x1]
     ff3b038c:	5155fca1 	sub	w1, w5, #0x57f, lsl #12
     ff3b0390:	51152021 	sub	w1, w1, #0x548
     ff3b0394:	b9400020 	ldr	w0, [x1]
     ff3b0398:	53087c02 	lsr	w2, w0, #8
     ff3b039c:	0a402060 	and	w0, w3, w0, lsr #8
     ff3b03a0:	71400c1f 	cmp	w0, #0x3, lsl #12
     ff3b03a4:	540013c0 	b.eq	ff3b061c <data_training.constprop.0+0x510>  // b.none
     ff3b03a8:	3637ff62 	tbz	w2, #6, ff3b0394 <data_training.constprop.0+0x288>
     ff3b03ac:	1400000a 	b	ff3b03d4 <data_training.constprop.0+0x2c8>
     ff3b03b0:	7100057f 	cmp	w11, #0x1
     ff3b03b4:	52800069 	mov	w9, #0x3                   	// #3
     ff3b03b8:	1a9f1529 	csinc	w9, w9, wzr, ne	// ne = any
     ff3b03bc:	17ffff65 	b	ff3b0150 <data_training.constprop.0+0x44>
     ff3b03c0:	528000ea 	mov	w10, #0x7                   	// #7
     ff3b03c4:	17ffff71 	b	ff3b0188 <data_training.constprop.0+0x7c>
     ff3b03c8:	121b0021 	and	w1, w1, #0x20
     ff3b03cc:	2a000020 	orr	w0, w1, w0
     ff3b03d0:	34fff1c0 	cbz	w0, ff3b0208 <data_training.constprop.0+0xfc>
     ff3b03d4:	12800000 	mov	w0, #0xffffffff            	// #-1
     ff3b03d8:	a94153f3 	ldp	x19, x20, [sp, #16]
     ff3b03dc:	a8c27bfd 	ldp	x29, x30, [sp], #32
     ff3b03e0:	d65f03c0 	ret
     ff3b03e4:	528003ca 	mov	w10, #0x1e                  	// #30
     ff3b03e8:	17ffff9e 	b	ff3b0260 <data_training.constprop.0+0x154>
     ff3b03ec:	528001ca 	mov	w10, #0xe                   	// #14
     ff3b03f0:	17ffff9c 	b	ff3b0260 <data_training.constprop.0+0x154>
     ff3b03f4:	2a0c03e1 	mov	w1, w12
     ff3b03f8:	2a0603e0 	mov	w0, w6
     ff3b03fc:	97ffff30 	bl	ff3b00bc <select_per_cs_training_index>
     ff3b0400:	5155f4af 	sub	w15, w5, #0x57d, lsl #12
     ff3b0404:	b94000e0 	ldr	w0, [x7]
     ff3b0408:	5155fca1 	sub	w1, w5, #0x57f, lsl #12
     ff3b040c:	511c5021 	sub	w1, w1, #0x714
     ff3b0410:	529fdfe2 	mov	w2, #0xfeff                	// #65279
     ff3b0414:	12167400 	and	w0, w0, #0xfffffcff
     ff3b0418:	5155fca3 	sub	w3, w5, #0x57f, lsl #12
     ff3b041c:	32170000 	orr	w0, w0, #0x200
     ff3b0420:	b90000e0 	str	w0, [x7]
     ff3b0424:	5155f4b0 	sub	w16, w5, #0x57d, lsl #12
     ff3b0428:	72bfff82 	movk	w2, #0xfffc, lsl #16
     ff3b042c:	b9400020 	ldr	w0, [x1]
     ff3b0430:	51152063 	sub	w3, w3, #0x548
     ff3b0434:	0b0e00a4 	add	w4, w5, w14
     ff3b0438:	512d81ef 	sub	w15, w15, #0xb60
     ff3b043c:	0a020000 	and	w0, w0, w2
     ff3b0440:	51258210 	sub	w16, w16, #0x960
     ff3b0444:	2a0c4000 	orr	w0, w0, w12, lsl #16
     ff3b0448:	52848212 	mov	w18, #0x2410                	// #9232
     ff3b044c:	32180000 	orr	w0, w0, #0x100
     ff3b0450:	52848013 	mov	w19, #0x2400                	// #9216
     ff3b0454:	b9000020 	str	w0, [x1]
     ff3b0458:	b9400062 	ldr	w2, [x3]
     ff3b045c:	b9400080 	ldr	w0, [x4]
     ff3b0460:	b94001be 	ldr	w30, [x13]
     ff3b0464:	b94001f1 	ldr	w17, [x15]
     ff3b0468:	53087c41 	lsr	w1, w2, #8
     ff3b046c:	b9400214 	ldr	w20, [x16]
     ff3b0470:	2a1e0000 	orr	w0, w0, w30
     ff3b0474:	0a422242 	and	w2, w18, w2, lsr #8
     ff3b0478:	2a140231 	orr	w17, w17, w20
     ff3b047c:	2a110000 	orr	w0, w0, w17
     ff3b0480:	12140000 	and	w0, w0, #0x1000
     ff3b0484:	6b13005f 	cmp	w2, w19
     ff3b0488:	54000101 	b.ne	ff3b04a8 <data_training.constprop.0+0x39c>  // b.any
     ff3b048c:	35fffa40 	cbnz	w0, ff3b03d4 <data_training.constprop.0+0x2c8>
     ff3b0490:	5155fca0 	sub	w0, w5, #0x57f, lsl #12
     ff3b0494:	5287ef81 	mov	w1, #0x3f7c                	// #16252
     ff3b0498:	51151000 	sub	w0, w0, #0x544
     ff3b049c:	1100058c 	add	w12, w12, #0x1
     ff3b04a0:	b9000001 	str	w1, [x0]
     ff3b04a4:	17ffff76 	b	ff3b027c <data_training.constprop.0+0x170>
     ff3b04a8:	121c0021 	and	w1, w1, #0x10
     ff3b04ac:	2a000020 	orr	w0, w1, w0
     ff3b04b0:	34fffd40 	cbz	w0, ff3b0458 <data_training.constprop.0+0x34c>
     ff3b04b4:	17ffffc8 	b	ff3b03d4 <data_training.constprop.0+0x2c8>
     ff3b04b8:	2a0c03e1 	mov	w1, w12
     ff3b04bc:	2a0603e0 	mov	w0, w6
     ff3b04c0:	97fffeff 	bl	ff3b00bc <select_per_cs_training_index>
     ff3b04c4:	5155f4af 	sub	w15, w5, #0x57d, lsl #12
     ff3b04c8:	b94000e0 	ldr	w0, [x7]
     ff3b04cc:	5155fca1 	sub	w1, w5, #0x57f, lsl #12
     ff3b04d0:	511b6021 	sub	w1, w1, #0x6d8
     ff3b04d4:	5155fca3 	sub	w3, w5, #0x57f, lsl #12
     ff3b04d8:	12067400 	and	w0, w0, #0xfcffffff
     ff3b04dc:	5155f4b0 	sub	w16, w5, #0x57d, lsl #12
     ff3b04e0:	32070000 	orr	w0, w0, #0x2000000
     ff3b04e4:	b90000e0 	str	w0, [x7]
     ff3b04e8:	12a06022 	mov	w2, #0xfcfeffff            	// #-50397185
     ff3b04ec:	51152063 	sub	w3, w3, #0x548
     ff3b04f0:	b9400020 	ldr	w0, [x1]
     ff3b04f4:	0b0e00a4 	add	w4, w5, w14
     ff3b04f8:	512d51ef 	sub	w15, w15, #0xb54
     ff3b04fc:	51255210 	sub	w16, w16, #0x954
     ff3b0500:	0a020000 	and	w0, w0, w2
     ff3b0504:	52844112 	mov	w18, #0x2208                	// #8712
     ff3b0508:	2a0c6000 	orr	w0, w0, w12, lsl #24
     ff3b050c:	5284401e 	mov	w30, #0x2200                	// #8704
     ff3b0510:	32100000 	orr	w0, w0, #0x10000
     ff3b0514:	b9000020 	str	w0, [x1]
     ff3b0518:	b9400062 	ldr	w2, [x3]
     ff3b051c:	b9400080 	ldr	w0, [x4]
     ff3b0520:	b94001b4 	ldr	w20, [x13]
     ff3b0524:	b94001f1 	ldr	w17, [x15]
     ff3b0528:	53087c41 	lsr	w1, w2, #8
     ff3b052c:	b9400213 	ldr	w19, [x16]
     ff3b0530:	2a140000 	orr	w0, w0, w20
     ff3b0534:	0a422242 	and	w2, w18, w2, lsr #8
     ff3b0538:	2a130231 	orr	w17, w17, w19
     ff3b053c:	2a110000 	orr	w0, w0, w17
     ff3b0540:	120a0400 	and	w0, w0, #0xc00000
     ff3b0544:	6b1e005f 	cmp	w2, w30
     ff3b0548:	54000101 	b.ne	ff3b0568 <data_training.constprop.0+0x45c>  // b.any
     ff3b054c:	35fff440 	cbnz	w0, ff3b03d4 <data_training.constprop.0+0x2c8>
     ff3b0550:	5155fca0 	sub	w0, w5, #0x57f, lsl #12
     ff3b0554:	5287ef81 	mov	w1, #0x3f7c                	// #16252
     ff3b0558:	51151000 	sub	w0, w0, #0x544
     ff3b055c:	1100058c 	add	w12, w12, #0x1
     ff3b0560:	b9000001 	str	w1, [x0]
     ff3b0564:	17ffff66 	b	ff3b02fc <data_training.constprop.0+0x1f0>
     ff3b0568:	121d0021 	and	w1, w1, #0x8
     ff3b056c:	2a000020 	orr	w0, w1, w0
     ff3b0570:	34fffd40 	cbz	w0, ff3b0518 <data_training.constprop.0+0x40c>
     ff3b0574:	17ffff98 	b	ff3b03d4 <data_training.constprop.0+0x2c8>
     ff3b0578:	2a0c03e1 	mov	w1, w12
     ff3b057c:	2a0603e0 	mov	w0, w6
     ff3b0580:	97fffecf 	bl	ff3b00bc <select_per_cs_training_index>
     ff3b0584:	b94000e0 	ldr	w0, [x7]
     ff3b0588:	529fdfe1 	mov	w1, #0xfeff                	// #65279
     ff3b058c:	72bf9fe1 	movk	w1, #0xfcff, lsl #16
     ff3b0590:	2a0e03e2 	mov	w2, w14
     ff3b0594:	120e7400 	and	w0, w0, #0xfffcffff
     ff3b0598:	52842083 	mov	w3, #0x2104                	// #8452
     ff3b059c:	320f0000 	orr	w0, w0, #0x20000
     ff3b05a0:	b90000e0 	str	w0, [x7]
     ff3b05a4:	52842004 	mov	w4, #0x2100                	// #8448
     ff3b05a8:	b94001a0 	ldr	w0, [x13]
     ff3b05ac:	0a010000 	and	w0, w0, w1
     ff3b05b0:	2a0c6000 	orr	w0, w0, w12, lsl #24
     ff3b05b4:	32180000 	orr	w0, w0, #0x100
     ff3b05b8:	b90001a0 	str	w0, [x13]
     ff3b05bc:	b9400040 	ldr	w0, [x2]
     ff3b05c0:	53087c01 	lsr	w1, w0, #8
     ff3b05c4:	0a402060 	and	w0, w3, w0, lsr #8
     ff3b05c8:	6b04001f 	cmp	w0, w4
     ff3b05cc:	54000060 	b.eq	ff3b05d8 <data_training.constprop.0+0x4cc>  // b.none
     ff3b05d0:	3617ff61 	tbz	w1, #2, ff3b05bc <data_training.constprop.0+0x4b0>
     ff3b05d4:	17ffff80 	b	ff3b03d4 <data_training.constprop.0+0x2c8>
     ff3b05d8:	5155fca0 	sub	w0, w5, #0x57f, lsl #12
     ff3b05dc:	1100058c 	add	w12, w12, #0x1
     ff3b05e0:	51151000 	sub	w0, w0, #0x544
     ff3b05e4:	5287ef81 	mov	w1, #0x3f7c                	// #16252
     ff3b05e8:	b9000001 	str	w1, [x0]
     ff3b05ec:	6b0c017f 	cmp	w11, w12
     ff3b05f0:	54fffc48 	b.hi	ff3b0578 <data_training.constprop.0+0x46c>  // b.pmore
     ff3b05f4:	b94000e0 	ldr	w0, [x7]
     ff3b05f8:	120e7400 	and	w0, w0, #0xfffcffff
     ff3b05fc:	b90000e0 	str	w0, [x7]
     ff3b0600:	17ffff45 	b	ff3b0314 <data_training.constprop.0+0x208>
     ff3b0604:	5155fcad 	sub	w13, w5, #0x57f, lsl #12
     ff3b0608:	5155fcae 	sub	w14, w5, #0x57f, lsl #12
     ff3b060c:	511b61ad 	sub	w13, w13, #0x6d8
     ff3b0610:	511521ce 	sub	w14, w14, #0x548
     ff3b0614:	5280000c 	mov	w12, #0x0                   	// #0
     ff3b0618:	17fffff5 	b	ff3b05ec <data_training.constprop.0+0x4e0>
     ff3b061c:	5155fca0 	sub	w0, w5, #0x57f, lsl #12
     ff3b0620:	5287ef81 	mov	w1, #0x3f7c                	// #16252
     ff3b0624:	51151000 	sub	w0, w0, #0x544
     ff3b0628:	b9000001 	str	w1, [x0]
     ff3b062c:	1100054a 	add	w10, w10, #0x1
     ff3b0630:	7100115f 	cmp	w10, #0x4
     ff3b0634:	54ffe7a1 	b.ne	ff3b0328 <data_training.constprop.0+0x21c>  // b.any
     ff3b0638:	b94000e0 	ldr	w0, [x7]
     ff3b063c:	120e7400 	and	w0, w0, #0xfffcffff
     ff3b0640:	b90000e0 	str	w0, [x7]
     ff3b0644:	b9400100 	ldr	w0, [x8]
     ff3b0648:	12097800 	and	w0, w0, #0xffbfffff
     ff3b064c:	b9000100 	str	w0, [x8]
     ff3b0650:	52800000 	mov	w0, #0x0                   	// #0
     ff3b0654:	17ffff61 	b	ff3b03d8 <data_training.constprop.0+0x2cc>
 
 00000000ff3b0658 <phy_dll_bypass_set>:
     ff3b0658:	52859182 	mov	w2, #0x2c8c                	// #11404
     ff3b065c:	72bff502 	movk	w2, #0xffa8, lsl #16
     ff3b0660:	0b003c43 	add	w3, w2, w0, lsl #15
     ff3b0664:	51080042 	sub	w2, w2, #0x200
     ff3b0668:	51080044 	sub	w4, w2, #0x200
     ff3b066c:	510cd045 	sub	w5, w2, #0x334
     ff3b0670:	0b003c48 	add	w8, w2, w0, lsl #15
     ff3b0674:	5114d046 	sub	w6, w2, #0x534
     ff3b0678:	511cd047 	sub	w7, w2, #0x734
     ff3b067c:	5124d042 	sub	w2, w2, #0x934
     ff3b0680:	0b003c84 	add	w4, w4, w0, lsl #15
     ff3b0684:	0b003ca5 	add	w5, w5, w0, lsl #15
     ff3b0688:	0b003cc6 	add	w6, w6, w0, lsl #15
     ff3b068c:	0b003ce7 	add	w7, w7, w0, lsl #15
     ff3b0690:	0b003c40 	add	w0, w2, w0, lsl #15
     ff3b0694:	528b2802 	mov	w2, #0x5940                	// #22848
     ff3b0698:	72a0ee62 	movk	w2, #0x773, lsl #16
     ff3b069c:	6b02003f 	cmp	w1, w2
     ff3b06a0:	b9400001 	ldr	w1, [x0]
     ff3b06a4:	540002c8 	b.hi	ff3b06fc <phy_dll_bypass_set+0xa4>  // b.pmore
     ff3b06a8:	32160421 	orr	w1, w1, #0xc00
     ff3b06ac:	b9000001 	str	w1, [x0]
     ff3b06b0:	b94000e0 	ldr	w0, [x7]
     ff3b06b4:	32160400 	orr	w0, w0, #0xc00
     ff3b06b8:	b90000e0 	str	w0, [x7]
     ff3b06bc:	b94000c0 	ldr	w0, [x6]
     ff3b06c0:	32160400 	orr	w0, w0, #0xc00
     ff3b06c4:	b90000c0 	str	w0, [x6]
     ff3b06c8:	b94000a0 	ldr	w0, [x5]
     ff3b06cc:	32160400 	orr	w0, w0, #0xc00
     ff3b06d0:	b90000a0 	str	w0, [x5]
     ff3b06d4:	b9400080 	ldr	w0, [x4]
     ff3b06d8:	320e0400 	orr	w0, w0, #0xc0000
     ff3b06dc:	b9000080 	str	w0, [x4]
     ff3b06e0:	b9400100 	ldr	w0, [x8]
     ff3b06e4:	320e0400 	orr	w0, w0, #0xc0000
     ff3b06e8:	b9000100 	str	w0, [x8]
     ff3b06ec:	b9400060 	ldr	w0, [x3]
     ff3b06f0:	320e0400 	orr	w0, w0, #0xc0000
     ff3b06f4:	b9000060 	str	w0, [x3]
     ff3b06f8:	d65f03c0 	ret
     ff3b06fc:	12147421 	and	w1, w1, #0xfffff3ff
     ff3b0700:	b9000001 	str	w1, [x0]
     ff3b0704:	b94000e0 	ldr	w0, [x7]
     ff3b0708:	12147400 	and	w0, w0, #0xfffff3ff
     ff3b070c:	b90000e0 	str	w0, [x7]
     ff3b0710:	b94000c0 	ldr	w0, [x6]
     ff3b0714:	12147400 	and	w0, w0, #0xfffff3ff
     ff3b0718:	b90000c0 	str	w0, [x6]
     ff3b071c:	b94000a0 	ldr	w0, [x5]
     ff3b0720:	12147400 	and	w0, w0, #0xfffff3ff
     ff3b0724:	b90000a0 	str	w0, [x5]
     ff3b0728:	b9400080 	ldr	w0, [x4]
     ff3b072c:	120c7400 	and	w0, w0, #0xfff3ffff
     ff3b0730:	b9000080 	str	w0, [x4]
     ff3b0734:	b9400100 	ldr	w0, [x8]
     ff3b0738:	120c7400 	and	w0, w0, #0xfff3ffff
     ff3b073c:	b9000100 	str	w0, [x8]
     ff3b0740:	b9400060 	ldr	w0, [x3]
     ff3b0744:	120c7400 	and	w0, w0, #0xfff3ffff
     ff3b0748:	17ffffeb 	b	ff3b06f4 <phy_dll_bypass_set+0x9c>
 
 00000000ff3b074c <dmc_resume>:
     ff3b074c:	a9b97bfd 	stp	x29, x30, [sp, #-112]!
     ff3b0750:	d0000000 	adrp	x0, ff3b2000 <rk3399m0pmu_bin>
     ff3b0754:	910003fd 	mov	x29, sp
     ff3b0758:	397d3000 	ldrb	w0, [x0, #3916]
     ff3b075c:	a90153f3 	stp	x19, x20, [sp, #16]
     ff3b0760:	a9025bf5 	stp	x21, x22, [sp, #32]
     ff3b0764:	a90363f7 	stp	x23, x24, [sp, #48]
     ff3b0768:	a9046bf9 	stp	x25, x26, [sp, #64]
     ff3b076c:	a90573fb 	stp	x27, x28, [sp, #80]
     ff3b0770:	360002a0 	tbz	w0, #0, ff3b07c4 <dmc_resume+0x78>
     ff3b0774:	d280a200 	mov	x0, #0x510                 	// #1296
     ff3b0778:	52800041 	mov	w1, #0x2                   	// #2
     ff3b077c:	f2bfeec0 	movk	x0, #0xff76, lsl #16
     ff3b0780:	b9000001 	str	w1, [x0]
     ff3b0784:	d2900080 	mov	x0, #0x8004                	// #32772
     ff3b0788:	f2bff080 	movk	x0, #0xff84, lsl #16
     ff3b078c:	52800121 	mov	w1, #0x9                   	// #9
     ff3b0790:	b9000001 	str	w1, [x0]
     ff3b0794:	b85fc001 	ldur	w1, [x0, #-4]
     ff3b0798:	32000021 	orr	w1, w1, #0x1
     ff3b079c:	b81fc001 	stur	w1, [x0, #-4]
     ff3b07a0:	52800ec1 	mov	w1, #0x76                  	// #118
     ff3b07a4:	b9000801 	str	w1, [x0, #8]
     ff3b07a8:	940001b1 	bl	ff3b0e6c <secure_watchdog_ungate>
     ff3b07ac:	d2800b81 	mov	x1, #0x5c                  	// #92
     ff3b07b0:	12800282 	mov	w2, #0xffffffeb            	// #-21
     ff3b07b4:	f2bfe621 	movk	x1, #0xff31, lsl #16
     ff3b07b8:	b9400020 	ldr	w0, [x1]
     ff3b07bc:	0a020000 	and	w0, w0, w2
     ff3b07c0:	b9000020 	str	w0, [x1]
     ff3b07c4:	940001ba 	bl	ff3b0eac <pmu_sgrf_rst_hld_release>
     ff3b07c8:	940001be 	bl	ff3b0ec0 <restore_pmu_rsthold>
     ff3b07cc:	940001ad 	bl	ff3b0e80 <sram_secure_timer_init>
     ff3b07d0:	d0000000 	adrp	x0, ff3b2000 <rk3399m0pmu_bin>
     ff3b07d4:	d2802302 	mov	x2, #0x118                 	// #280
     ff3b07d8:	f2bfeec2 	movk	x2, #0xff76, lsl #16
     ff3b07dc:	d0000003 	adrp	x3, ff3b2000 <rk3399m0pmu_bin>
     ff3b07e0:	b94f3001 	ldr	w1, [x0, #3888]
     ff3b07e4:	aa0203e0 	mov	x0, x2
     ff3b07e8:	32103c21 	orr	w1, w1, #0xffff0000
     ff3b07ec:	b8134401 	str	w1, [x0], #-204
     ff3b07f0:	52a06001 	mov	w1, #0x3000000             	// #50331648
     ff3b07f4:	b8134041 	stur	w1, [x2, #-204]
     ff3b07f8:	913cd061 	add	x1, x3, #0xf34
     ff3b07fc:	d1001000 	sub	x0, x0, #0x4
     ff3b0800:	b94f3463 	ldr	w3, [x3, #3892]
     ff3b0804:	32103c63 	orr	w3, w3, #0xffff0000
     ff3b0808:	b81f8003 	stur	w3, [x0, #-8]
     ff3b080c:	b9400423 	ldr	w3, [x1, #4]
     ff3b0810:	32103c63 	orr	w3, w3, #0xffff0000
     ff3b0814:	b81fc003 	stur	w3, [x0, #-4]
     ff3b0818:	b9400823 	ldr	w3, [x1, #8]
     ff3b081c:	b9000003 	str	w3, [x0]
     ff3b0820:	b9401023 	ldr	w3, [x1, #16]
     ff3b0824:	32103c63 	orr	w3, w3, #0xffff0000
     ff3b0828:	b9000803 	str	w3, [x0, #8]
     ff3b082c:	b9401423 	ldr	w3, [x1, #20]
     ff3b0830:	32103c63 	orr	w3, w3, #0xffff0000
     ff3b0834:	b9000c03 	str	w3, [x0, #12]
     ff3b0838:	b9400c21 	ldr	w1, [x1, #12]
     ff3b083c:	32103c21 	orr	w1, w1, #0xffff0000
     ff3b0840:	b8134041 	stur	w1, [x2, #-204]
     ff3b0844:	b9400001 	ldr	w1, [x0]
     ff3b0848:	36ffffe1 	tbz	w1, #31, ff3b0844 <dmc_resume+0xf8>
     ff3b084c:	d2800800 	mov	x0, #0x40                  	// #64
     ff3b0850:	d2802215 	mov	x21, #0x110                 	// #272
     ff3b0854:	f2bfe660 	movk	x0, #0xff33, lsl #16
     ff3b0858:	52984001 	mov	w1, #0xc200                	// #49664
     ff3b085c:	d0000016 	adrp	x22, ff3b2000 <rk3399m0pmu_bin>
     ff3b0860:	f2bff515 	movk	x21, #0xffa8, lsl #16
     ff3b0864:	910902d3 	add	x19, x22, #0x240
     ff3b0868:	914022b7 	add	x23, x21, #0x8, lsl #12
     ff3b086c:	72b84001 	movk	w1, #0xc200, lsl #16
     ff3b0870:	52800014 	mov	w20, #0x0                   	// #0
     ff3b0874:	b9000001 	str	w1, [x0]
     ff3b0878:	52850009 	mov	w9, #0x2800                	// #10240
     ff3b087c:	d000000b 	adrp	x11, ff3b2000 <rk3399m0pmu_bin>
     ff3b0880:	910a516b 	add	x11, x11, #0x294
     ff3b0884:	72bff509 	movk	w9, #0xffa8, lsl #16
     ff3b0888:	5280000a 	mov	w10, #0x0                   	// #0
     ff3b088c:	39413660 	ldrb	w0, [x19, #77]
     ff3b0890:	6b0a001f 	cmp	w0, w10
     ff3b0894:	540004e8 	b.hi	ff3b0930 <dmc_resume+0x1e4>  // b.pmore
     ff3b0898:	39400660 	ldrb	w0, [x19, #1]
     ff3b089c:	34000040 	cbz	w0, ff3b08a4 <dmc_resume+0x158>
     ff3b08a0:	32000294 	orr	w20, w20, #0x1
     ff3b08a4:	39409660 	ldrb	w0, [x19, #37]
     ff3b08a8:	34000040 	cbz	w0, ff3b08b0 <dmc_resume+0x164>
     ff3b08ac:	321f0294 	orr	w20, w20, #0x2
     ff3b08b0:	b94002a0 	ldr	w0, [x21]
     ff3b08b4:	12000281 	and	w1, w20, #0x1
     ff3b08b8:	32100000 	orr	w0, w0, #0x10000
     ff3b08bc:	b90002a0 	str	w0, [x21]
     ff3b08c0:	b94002e0 	ldr	w0, [x23]
     ff3b08c4:	32100000 	orr	w0, w0, #0x10000
     ff3b08c8:	b90002e0 	str	w0, [x23]
     ff3b08cc:	360000d4 	tbz	w20, #0, ff3b08e4 <dmc_resume+0x198>
     ff3b08d0:	d2800402 	mov	x2, #0x20                  	// #32
     ff3b08d4:	f2bfe622 	movk	x2, #0xff31, lsl #16
     ff3b08d8:	b9400040 	ldr	w0, [x2]
     ff3b08dc:	320d0000 	orr	w0, w0, #0x80000
     ff3b08e0:	b9000040 	str	w0, [x2]
     ff3b08e4:	121f0285 	and	w5, w20, #0x2
     ff3b08e8:	36081374 	tbz	w20, #1, ff3b0b54 <dmc_resume+0x408>
     ff3b08ec:	d2800402 	mov	x2, #0x20                  	// #32
     ff3b08f0:	f2bfe622 	movk	x2, #0xff31, lsl #16
     ff3b08f4:	b9400040 	ldr	w0, [x2]
     ff3b08f8:	32090000 	orr	w0, w0, #0x800000
     ff3b08fc:	b9000040 	str	w0, [x2]
     ff3b0900:	35000ea1 	cbnz	w1, ff3b0ad4 <dmc_resume+0x388>
     ff3b0904:	d295de82 	mov	x2, #0xaef4                	// #44788
     ff3b0908:	f2bff502 	movk	x2, #0xffa8, lsl #16
     ff3b090c:	b9400040 	ldr	w0, [x2]
     ff3b0910:	12067400 	and	w0, w0, #0xfcffffff
     ff3b0914:	32070000 	orr	w0, w0, #0x2000000
     ff3b0918:	b9000040 	str	w0, [x2]
     ff3b091c:	35000ea1 	cbnz	w1, ff3b0af0 <dmc_resume+0x3a4>
     ff3b0920:	d2906585 	mov	x5, #0x832c                	// #33580
     ff3b0924:	52800cc4 	mov	w4, #0x66                  	// #102
     ff3b0928:	f2bff505 	movk	x5, #0xffa8, lsl #16
     ff3b092c:	1400010d 	b	ff3b0d60 <dmc_resume+0x614>
     ff3b0930:	52800022 	mov	w2, #0x1                   	// #1
     ff3b0934:	2a0203e1 	mov	w1, w2
     ff3b0938:	2a0a03e0 	mov	w0, w10
     ff3b093c:	97fffdcf 	bl	ff3b0078 <rkclk_ddr_reset>
     ff3b0940:	52800140 	mov	w0, #0xa                   	// #10
     ff3b0944:	97fffdc0 	bl	ff3b0044 <sram_udelay>
     ff3b0948:	52800002 	mov	w2, #0x0                   	// #0
     ff3b094c:	52800021 	mov	w1, #0x1                   	// #1
     ff3b0950:	2a0a03e0 	mov	w0, w10
     ff3b0954:	97fffdc9 	bl	ff3b0078 <rkclk_ddr_reset>
     ff3b0958:	52800140 	mov	w0, #0xa                   	// #10
     ff3b095c:	97fffdba 	bl	ff3b0044 <sram_udelay>
     ff3b0960:	52800002 	mov	w2, #0x0                   	// #0
     ff3b0964:	52800001 	mov	w1, #0x0                   	// #0
     ff3b0968:	2a0a03e0 	mov	w0, w10
     ff3b096c:	97fffdc3 	bl	ff3b0078 <rkclk_ddr_reset>
     ff3b0970:	52800140 	mov	w0, #0xa                   	// #10
     ff3b0974:	97fffdb4 	bl	ff3b0044 <sram_udelay>
     ff3b0978:	39413260 	ldrb	w0, [x19, #76]
     ff3b097c:	71001c1f 	cmp	w0, #0x7
     ff3b0980:	54000081 	b.ne	ff3b0990 <dmc_resume+0x244>  // b.any
     ff3b0984:	b9404a61 	ldr	w1, [x19, #72]
     ff3b0988:	2a0a03e0 	mov	w0, w10
     ff3b098c:	97ffff33 	bl	ff3b0658 <phy_dll_bypass_set>
     ff3b0990:	aa0b03e1 	mov	x1, x11
     ff3b0994:	52802962 	mov	w2, #0x14b                 	// #331
     ff3b0998:	1284ff60 	mov	w0, #0xffffd804            	// #-10236
     ff3b099c:	0b000120 	add	w0, w9, w0
     ff3b09a0:	97fffda0 	bl	ff3b0020 <sram_regcpy>
     ff3b09a4:	51400924 	sub	w4, w9, #0x2, lsl #12
     ff3b09a8:	1284ffe1 	mov	w1, #0xffffd800            	// #-10240
     ff3b09ac:	0b010125 	add	w5, w9, w1
     ff3b09b0:	b9405260 	ldr	w0, [x19, #80]
     ff3b09b4:	52801902 	mov	w2, #0xc8                  	// #200
     ff3b09b8:	d0000001 	adrp	x1, ff3b2000 <rk3399m0pmu_bin>
     ff3b09bc:	911f0021 	add	x1, x1, #0x7c0
     ff3b09c0:	b90000a0 	str	w0, [x5]
     ff3b09c4:	aa0403e0 	mov	x0, x4
     ff3b09c8:	97fffd96 	bl	ff3b0020 <sram_regcpy>
     ff3b09cc:	1118e120 	add	w0, w9, #0x638
     ff3b09d0:	52800062 	mov	w2, #0x3                   	// #3
     ff3b09d4:	d0000001 	adrp	x1, ff3b2000 <rk3399m0pmu_bin>
     ff3b09d8:	91393021 	add	x1, x1, #0xe4c
     ff3b09dc:	97fffd91 	bl	ff3b0020 <sram_regcpy>
     ff3b09e0:	1284dde2 	mov	w2, #0xffffd910            	// #-9968
     ff3b09e4:	0b020121 	add	w1, w9, w2
     ff3b09e8:	b9400020 	ldr	w0, [x1]
     ff3b09ec:	32100000 	orr	w0, w0, #0x10000
     ff3b09f0:	b9000020 	str	w0, [x1]
     ff3b09f4:	111bd121 	add	w1, w9, #0x6f4
     ff3b09f8:	b9400020 	ldr	w0, [x1]
     ff3b09fc:	12067400 	and	w0, w0, #0xfcffffff
     ff3b0a00:	32080000 	orr	w0, w0, #0x1000000
     ff3b0a04:	b9000020 	str	w0, [x1]
     ff3b0a08:	d5033ebf 	dmb	st
     ff3b0a0c:	b9400080 	ldr	w0, [x4]
     ff3b0a10:	11198122 	add	w2, w9, #0x660
     ff3b0a14:	11199123 	add	w3, w9, #0x664
     ff3b0a18:	1118f121 	add	w1, w9, #0x63c
     ff3b0a1c:	32000000 	orr	w0, w0, #0x1
     ff3b0a20:	b9000080 	str	w0, [x4]
     ff3b0a24:	1119a124 	add	w4, w9, #0x668
     ff3b0a28:	b94000a0 	ldr	w0, [x5]
     ff3b0a2c:	32000000 	orr	w0, w0, #0x1
     ff3b0a30:	b90000a0 	str	w0, [x5]
     ff3b0a34:	320083e5 	mov	w5, #0x10001               	// #65537
     ff3b0a38:	b9400047 	ldr	w7, [x2]
     ff3b0a3c:	b9400060 	ldr	w0, [x3]
     ff3b0a40:	b9400086 	ldr	w6, [x4]
     ff3b0a44:	368000a7 	tbz	w7, #16, ff3b0a58 <dmc_resume+0x30c>
     ff3b0a48:	12008000 	and	w0, w0, #0x10001
     ff3b0a4c:	6b05001f 	cmp	w0, w5
     ff3b0a50:	54000041 	b.ne	ff3b0a58 <dmc_resume+0x30c>  // b.any
     ff3b0a54:	37000066 	tbnz	w6, #0, ff3b0a60 <dmc_resume+0x314>
     ff3b0a58:	b9400020 	ldr	w0, [x1]
     ff3b0a5c:	3607fee0 	tbz	w0, #0, ff3b0a38 <dmc_resume+0x2ec>
     ff3b0a60:	d0000005 	adrp	x5, ff3b2000 <rk3399m0pmu_bin>
     ff3b0a64:	11180126 	add	w6, w9, #0x600
     ff3b0a68:	51200124 	sub	w4, w9, #0x800
     ff3b0a6c:	912b80a5 	add	x5, x5, #0xae0
     ff3b0a70:	11180120 	add	w0, w9, #0x600
     ff3b0a74:	528007e2 	mov	w2, #0x3f                  	// #63
     ff3b0a78:	d0000001 	adrp	x1, ff3b2000 <rk3399m0pmu_bin>
     ff3b0a7c:	91385021 	add	x1, x1, #0xe14
     ff3b0a80:	97fffd68 	bl	ff3b0020 <sram_regcpy>
     ff3b0a84:	2a0403e0 	mov	w0, w4
     ff3b0a88:	aa0503e1 	mov	x1, x5
     ff3b0a8c:	52800b62 	mov	w2, #0x5b                  	// #91
     ff3b0a90:	11080084 	add	w4, w4, #0x200
     ff3b0a94:	97fffd63 	bl	ff3b0020 <sram_regcpy>
     ff3b0a98:	6b04013f 	cmp	w9, w4
     ff3b0a9c:	54ffff41 	b.ne	ff3b0a84 <dmc_resume+0x338>  // b.any
     ff3b0aa0:	d0000005 	adrp	x5, ff3b2000 <rk3399m0pmu_bin>
     ff3b0aa4:	913130a5 	add	x5, x5, #0xc4c
     ff3b0aa8:	aa0503e1 	mov	x1, x5
     ff3b0aac:	2a0403e0 	mov	w0, w4
     ff3b0ab0:	528004c2 	mov	w2, #0x26                  	// #38
     ff3b0ab4:	11080084 	add	w4, w4, #0x200
     ff3b0ab8:	97fffd5a 	bl	ff3b0020 <sram_regcpy>
     ff3b0abc:	910260a5 	add	x5, x5, #0x98
     ff3b0ac0:	6b0400df 	cmp	w6, w4
     ff3b0ac4:	54ffff21 	b.ne	ff3b0aa8 <dmc_resume+0x35c>  // b.any
     ff3b0ac8:	1100054a 	add	w10, w10, #0x1
     ff3b0acc:	11402129 	add	w9, w9, #0x8, lsl #12
     ff3b0ad0:	17ffff6f 	b	ff3b088c <dmc_resume+0x140>
     ff3b0ad4:	d285de82 	mov	x2, #0x2ef4                	// #12020
     ff3b0ad8:	f2bff502 	movk	x2, #0xffa8, lsl #16
     ff3b0adc:	b9400040 	ldr	w0, [x2]
     ff3b0ae0:	12067400 	and	w0, w0, #0xfcffffff
     ff3b0ae4:	32070000 	orr	w0, w0, #0x2000000
     ff3b0ae8:	b9000040 	str	w0, [x2]
     ff3b0aec:	35fff0c5 	cbnz	w5, ff3b0904 <dmc_resume+0x1b8>
     ff3b0af0:	d2806586 	mov	x6, #0x32c                 	// #812
     ff3b0af4:	52800cc4 	mov	w4, #0x66                  	// #102
     ff3b0af8:	f2bff506 	movk	x6, #0xffa8, lsl #16
     ff3b0afc:	b94000c0 	ldr	w0, [x6]
     ff3b0b00:	361811e0 	tbz	w0, #3, ff3b0d3c <dmc_resume+0x5f0>
     ff3b0b04:	d2802201 	mov	x1, #0x110                 	// #272
     ff3b0b08:	d0000002 	adrp	x2, ff3b2000 <rk3399m0pmu_bin>
     ff3b0b0c:	f2bff501 	movk	x1, #0xffa8, lsl #16
     ff3b0b10:	913c4042 	add	x2, x2, #0xf10
     ff3b0b14:	b9400020 	ldr	w0, [x1]
     ff3b0b18:	120f7800 	and	w0, w0, #0xfffeffff
     ff3b0b1c:	b9000020 	str	w0, [x1]
     ff3b0b20:	d2841c80 	mov	x0, #0x20e4                	// #8420
     ff3b0b24:	f2bff500 	movk	x0, #0xffa8, lsl #16
     ff3b0b28:	91200003 	add	x3, x0, #0x800
     ff3b0b2c:	b9400001 	ldr	w1, [x0]
     ff3b0b30:	b8404444 	ldr	w4, [x2], #4
     ff3b0b34:	12044c21 	and	w1, w1, #0xf000ffff
     ff3b0b38:	2a040021 	orr	w1, w1, w4
     ff3b0b3c:	b9000001 	str	w1, [x0]
     ff3b0b40:	91080000 	add	x0, x0, #0x200
     ff3b0b44:	eb03001f 	cmp	x0, x3
     ff3b0b48:	54ffff21 	b.ne	ff3b0b2c <dmc_resume+0x3e0>  // b.any
     ff3b0b4c:	35ffeea5 	cbnz	w5, ff3b0920 <dmc_resume+0x1d4>
     ff3b0b50:	14000002 	b	ff3b0b58 <dmc_resume+0x40c>
     ff3b0b54:	35fffc01 	cbnz	w1, ff3b0ad4 <dmc_resume+0x388>
     ff3b0b58:	d288011c 	mov	x28, #0x4008                	// #16392
     ff3b0b5c:	aa1303fa 	mov	x26, x19
     ff3b0b60:	f2bff51c 	movk	x28, #0xffa8, lsl #16
     ff3b0b64:	5280001b 	mov	w27, #0x0                   	// #0
     ff3b0b68:	52800038 	mov	w24, #0x1                   	// #1
     ff3b0b6c:	52800079 	mov	w25, #0x3                   	// #3
     ff3b0b70:	39413662 	ldrb	w2, [x19, #77]
     ff3b0b74:	6b1b005f 	cmp	w2, w27
     ff3b0b78:	540011e8 	b.hi	ff3b0db4 <dmc_resume+0x668>  // b.pmore
     ff3b0b7c:	39400660 	ldrb	w0, [x19, #1]
     ff3b0b80:	340002c0 	cbz	w0, ff3b0bd8 <dmc_resume+0x48c>
     ff3b0b84:	d2880201 	mov	x1, #0x4010                	// #16400
     ff3b0b88:	b9400e63 	ldr	w3, [x19, #12]
     ff3b0b8c:	f2bff501 	movk	x1, #0xffa8, lsl #16
     ff3b0b90:	aa0103e0 	mov	x0, x1
     ff3b0b94:	b8004403 	str	w3, [x0], #4
     ff3b0b98:	b9401263 	ldr	w3, [x19, #16]
     ff3b0b9c:	b9000423 	str	w3, [x1, #4]
     ff3b0ba0:	b9401661 	ldr	w1, [x19, #20]
     ff3b0ba4:	b9000401 	str	w1, [x0, #4]
     ff3b0ba8:	b9401a61 	ldr	w1, [x19, #24]
     ff3b0bac:	b9000801 	str	w1, [x0, #8]
     ff3b0bb0:	b9401e61 	ldr	w1, [x19, #28]
     ff3b0bb4:	b900fc01 	str	w1, [x0, #252]
     ff3b0bb8:	394902c0 	ldrb	w0, [x22, #576]
     ff3b0bbc:	7100041f 	cmp	w0, #0x1
     ff3b0bc0:	540000c1 	b.ne	ff3b0bd8 <dmc_resume+0x48c>  // b.any
     ff3b0bc4:	d2808a01 	mov	x1, #0x450                 	// #1104
     ff3b0bc8:	f2bff501 	movk	x1, #0xffa8, lsl #16
     ff3b0bcc:	b9400020 	ldr	w0, [x1]
     ff3b0bd0:	320f0000 	orr	w0, w0, #0x20000
     ff3b0bd4:	b9000020 	str	w0, [x1]
     ff3b0bd8:	39409660 	ldrb	w0, [x19, #37]
     ff3b0bdc:	340002c0 	cbz	w0, ff3b0c34 <dmc_resume+0x4e8>
     ff3b0be0:	d2980201 	mov	x1, #0xc010                	// #49168
     ff3b0be4:	b9403263 	ldr	w3, [x19, #48]
     ff3b0be8:	f2bff501 	movk	x1, #0xffa8, lsl #16
     ff3b0bec:	aa0103e0 	mov	x0, x1
     ff3b0bf0:	b8004403 	str	w3, [x0], #4
     ff3b0bf4:	b9403663 	ldr	w3, [x19, #52]
     ff3b0bf8:	b9000423 	str	w3, [x1, #4]
     ff3b0bfc:	b9403a61 	ldr	w1, [x19, #56]
     ff3b0c00:	b9000401 	str	w1, [x0, #4]
     ff3b0c04:	b9403e61 	ldr	w1, [x19, #60]
     ff3b0c08:	b9000801 	str	w1, [x0, #8]
     ff3b0c0c:	b9404261 	ldr	w1, [x19, #64]
     ff3b0c10:	b900fc01 	str	w1, [x0, #252]
     ff3b0c14:	39409260 	ldrb	w0, [x19, #36]
     ff3b0c18:	7100041f 	cmp	w0, #0x1
     ff3b0c1c:	540000c1 	b.ne	ff3b0c34 <dmc_resume+0x4e8>  // b.any
     ff3b0c20:	d2908a01 	mov	x1, #0x8450                	// #33872
     ff3b0c24:	f2bff501 	movk	x1, #0xffa8, lsl #16
     ff3b0c28:	b9400020 	ldr	w0, [x1]
     ff3b0c2c:	320f0000 	orr	w0, w0, #0x20000
     ff3b0c30:	b9000020 	str	w0, [x1]
     ff3b0c34:	39413a60 	ldrb	w0, [x19, #78]
     ff3b0c38:	d29c0201 	mov	x1, #0xe010                	// #57360
     ff3b0c3c:	f2bfe661 	movk	x1, #0xff33, lsl #16
     ff3b0c40:	53165400 	lsl	w0, w0, #10
     ff3b0c44:	32061000 	orr	w0, w0, #0x7c000000
     ff3b0c48:	b9000020 	str	w0, [x1]
     ff3b0c4c:	d2802480 	mov	x0, #0x124                 	// #292
     ff3b0c50:	52803001 	mov	w1, #0x180                 	// #384
     ff3b0c54:	f2bfeea0 	movk	x0, #0xff75, lsl #16
     ff3b0c58:	72a03801 	movk	w1, #0x1c0, lsl #16
     ff3b0c5c:	b9000001 	str	w1, [x0]
     ff3b0c60:	d280a201 	mov	x1, #0x510                 	// #1296
     ff3b0c64:	f2bfeec1 	movk	x1, #0xff76, lsl #16
     ff3b0c68:	b9400020 	ldr	w0, [x1]
     ff3b0c6c:	32000400 	orr	w0, w0, #0x3
     ff3b0c70:	b9000020 	str	w0, [x1]
     ff3b0c74:	d2803780 	mov	x0, #0x1bc                 	// #444
     ff3b0c78:	528000a1 	mov	w1, #0x5                   	// #5
     ff3b0c7c:	f2bff500 	movk	x0, #0xffa8, lsl #16
     ff3b0c80:	72a006a1 	movk	w1, #0x35, lsl #16
     ff3b0c84:	b9400000 	ldr	w0, [x0]
     ff3b0c88:	53107c00 	lsr	w0, w0, #16
     ff3b0c8c:	11000400 	add	w0, w0, #0x1
     ff3b0c90:	12000015 	and	w21, w0, #0x1
     ff3b0c94:	531c0000 	ubfiz	w0, w0, #4, #1
     ff3b0c98:	2a010000 	orr	w0, w0, w1
     ff3b0c9c:	d2bfec41 	mov	x1, #0xff620000            	// #4284612608
     ff3b0ca0:	b9000020 	str	w0, [x1]
     ff3b0ca4:	d2800200 	mov	x0, #0x10                  	// #16
     ff3b0ca8:	f2bfec40 	movk	x0, #0xff62, lsl #16
     ff3b0cac:	b9400001 	ldr	w1, [x0]
     ff3b0cb0:	3617ffe1 	tbz	w1, #2, ff3b0cac <dmc_resume+0x560>
     ff3b0cb4:	d2bfec41 	mov	x1, #0xff620000            	// #4284612608
     ff3b0cb8:	320f83e3 	mov	w3, #0x20002               	// #131074
     ff3b0cbc:	b9000023 	str	w3, [x1]
     ff3b0cc0:	b9400001 	ldr	w1, [x0]
     ff3b0cc4:	3607ffe1 	tbz	w1, #0, ff3b0cc0 <dmc_resume+0x574>
     ff3b0cc8:	d285c017 	mov	x23, #0x2e00                	// #11776
     ff3b0ccc:	53185eb5 	lsl	w21, w21, #8
     ff3b0cd0:	d2800014 	mov	x20, #0x0                   	// #0
     ff3b0cd4:	52900016 	mov	w22, #0x8000                	// #32768
     ff3b0cd8:	f2bff517 	movk	x23, #0xffa8, lsl #16
     ff3b0cdc:	12806038 	mov	w24, #0xfffffcfe            	// #-770
     ff3b0ce0:	2a1403e0 	mov	w0, w20
     ff3b0ce4:	6b14005f 	cmp	w2, w20
     ff3b0ce8:	540001c9 	b.ls	ff3b0d20 <dmc_resume+0x5d4>  // b.plast
     ff3b0cec:	39413261 	ldrb	w1, [x19, #76]
     ff3b0cf0:	71001c3f 	cmp	w1, #0x7
     ff3b0cf4:	540000c0 	b.eq	ff3b0d0c <dmc_resume+0x5c0>  // b.none
     ff3b0cf8:	9bb65e83 	umaddl	x3, w20, w22, x23
     ff3b0cfc:	b9400061 	ldr	w1, [x3]
     ff3b0d00:	0a180021 	and	w1, w1, w24
     ff3b0d04:	2a0102a1 	orr	w1, w21, w1
     ff3b0d08:	b9000061 	str	w1, [x3]
     ff3b0d0c:	b9006fe2 	str	w2, [sp, #108]
     ff3b0d10:	97fffcff 	bl	ff3b010c <data_training.constprop.0>
     ff3b0d14:	b9406fe2 	ldr	w2, [sp, #108]
     ff3b0d18:	91000694 	add	x20, x20, #0x1
     ff3b0d1c:	34fffe20 	cbz	w0, ff3b0ce0 <dmc_resume+0x594>
     ff3b0d20:	a94153f3 	ldp	x19, x20, [sp, #16]
     ff3b0d24:	a9425bf5 	ldp	x21, x22, [sp, #32]
     ff3b0d28:	a94363f7 	ldp	x23, x24, [sp, #48]
     ff3b0d2c:	a9446bf9 	ldp	x25, x26, [sp, #64]
     ff3b0d30:	a94573fb 	ldp	x27, x28, [sp, #80]
     ff3b0d34:	a8c77bfd 	ldp	x29, x30, [sp], #112
     ff3b0d38:	d65f03c0 	ret
     ff3b0d3c:	71000484 	subs	w4, w4, #0x1
     ff3b0d40:	54ffd9c0 	b.eq	ff3b0878 <dmc_resume+0x12c>  // b.none
     ff3b0d44:	52800c80 	mov	w0, #0x64                  	// #100
     ff3b0d48:	97fffcbf 	bl	ff3b0044 <sram_udelay>
     ff3b0d4c:	17ffff6c 	b	ff3b0afc <dmc_resume+0x3b0>
     ff3b0d50:	71000484 	subs	w4, w4, #0x1
     ff3b0d54:	54ffd920 	b.eq	ff3b0878 <dmc_resume+0x12c>  // b.none
     ff3b0d58:	52800c80 	mov	w0, #0x64                  	// #100
     ff3b0d5c:	97fffcba 	bl	ff3b0044 <sram_udelay>
     ff3b0d60:	b94000a0 	ldr	w0, [x5]
     ff3b0d64:	361fff60 	tbz	w0, #3, ff3b0d50 <dmc_resume+0x604>
     ff3b0d68:	d2902201 	mov	x1, #0x8110                	// #33040
     ff3b0d6c:	d0000002 	adrp	x2, ff3b2000 <rk3399m0pmu_bin>
     ff3b0d70:	f2bff501 	movk	x1, #0xffa8, lsl #16
     ff3b0d74:	913c8042 	add	x2, x2, #0xf20
     ff3b0d78:	b9400020 	ldr	w0, [x1]
     ff3b0d7c:	120f7800 	and	w0, w0, #0xfffeffff
     ff3b0d80:	b9000020 	str	w0, [x1]
     ff3b0d84:	d2941c80 	mov	x0, #0xa0e4                	// #41188
     ff3b0d88:	f2bff500 	movk	x0, #0xffa8, lsl #16
     ff3b0d8c:	91200003 	add	x3, x0, #0x800
     ff3b0d90:	b9400001 	ldr	w1, [x0]
     ff3b0d94:	b8404444 	ldr	w4, [x2], #4
     ff3b0d98:	12044c21 	and	w1, w1, #0xf000ffff
     ff3b0d9c:	2a040021 	orr	w1, w1, w4
     ff3b0da0:	b9000001 	str	w1, [x0]
     ff3b0da4:	91080000 	add	x0, x0, #0x200
     ff3b0da8:	eb03001f 	cmp	x0, x3
     ff3b0dac:	54ffff21 	b.ne	ff3b0d90 <dmc_resume+0x644>  // b.any
     ff3b0db0:	17ffff6a 	b	ff3b0b58 <dmc_resume+0x40c>
     ff3b0db4:	39413260 	ldrb	w0, [x19, #76]
     ff3b0db8:	7100181f 	cmp	w0, #0x6
     ff3b0dbc:	540000e1 	b.ne	ff3b0dd8 <dmc_resume+0x68c>  // b.any
     ff3b0dc0:	52800140 	mov	w0, #0xa                   	// #10
     ff3b0dc4:	97fffca0 	bl	ff3b0044 <sram_udelay>
     ff3b0dc8:	2a1b03e0 	mov	w0, w27
     ff3b0dcc:	97fffcd0 	bl	ff3b010c <data_training.constprop.0>
     ff3b0dd0:	34000080 	cbz	w0, ff3b0de0 <dmc_resume+0x694>
     ff3b0dd4:	17fffea9 	b	ff3b0878 <dmc_resume+0x12c>
     ff3b0dd8:	71001c1f 	cmp	w0, #0x7
     ff3b0ddc:	54ffff61 	b.ne	ff3b0dc8 <dmc_resume+0x67c>  // b.any
     ff3b0de0:	39401b40 	ldrb	w0, [x26, #6]
     ff3b0de4:	39400741 	ldrb	w1, [x26, #1]
     ff3b0de8:	39400b42 	ldrb	w2, [x26, #2]
     ff3b0dec:	0b000021 	add	w1, w1, w0
     ff3b0df0:	39400344 	ldrb	w4, [x26]
     ff3b0df4:	0b020021 	add	w1, w1, w2
     ff3b0df8:	39400f42 	ldrb	w2, [x26, #3]
     ff3b0dfc:	b9400b43 	ldr	w3, [x26, #8]
     ff3b0e00:	0b020021 	add	w1, w1, w2
     ff3b0e04:	51005021 	sub	w1, w1, #0x14
     ff3b0e08:	1ac12302 	lsl	w2, w24, w1
     ff3b0e0c:	7100049f 	cmp	w4, #0x1
     ff3b0e10:	54000268 	b.hi	ff3b0e5c <dmc_resume+0x710>  // b.pmore
     ff3b0e14:	52800000 	mov	w0, #0x0                   	// #0
     ff3b0e18:	39401744 	ldrb	w4, [x26, #5]
     ff3b0e1c:	340000a4 	cbz	w4, ff3b0e30 <dmc_resume+0x6e4>
     ff3b0e20:	0b000400 	add	w0, w0, w0, lsl #1
     ff3b0e24:	1ac12321 	lsl	w1, w25, w1
     ff3b0e28:	53027c22 	lsr	w2, w1, #2
     ff3b0e2c:	53027c00 	lsr	w0, w0, #2
     ff3b0e30:	53057c00 	lsr	w0, w0, #5
     ff3b0e34:	2a031863 	orr	w3, w3, w3, lsl #6
     ff3b0e38:	d3453042 	ubfx	x2, x2, #5, #8
     ff3b0e3c:	b9000383 	str	w3, [x28]
     ff3b0e40:	53181c00 	ubfiz	w0, w0, #8, #8
     ff3b0e44:	1100077b 	add	w27, w27, #0x1
     ff3b0e48:	2a020000 	orr	w0, w0, w2
     ff3b0e4c:	9100935a 	add	x26, x26, #0x24
     ff3b0e50:	b9000780 	str	w0, [x28, #4]
     ff3b0e54:	9140239c 	add	x28, x28, #0x8, lsl #12
     ff3b0e58:	17ffff46 	b	ff3b0b70 <dmc_resume+0x424>
     ff3b0e5c:	39401f44 	ldrb	w4, [x26, #7]
     ff3b0e60:	4b040000 	sub	w0, w0, w4
     ff3b0e64:	1ac02440 	lsr	w0, w2, w0
     ff3b0e68:	17ffffec 	b	ff3b0e18 <dmc_resume+0x6cc>
 
 00000000ff3b0e6c <secure_watchdog_ungate>:
     ff3b0e6c:	d29c0180 	mov	x0, #0xe00c                	// #57356
     ff3b0e70:	52a0a001 	mov	w1, #0x5000000             	// #83886080
     ff3b0e74:	f2bfe660 	movk	x0, #0xff33, lsl #16
     ff3b0e78:	b9000001 	str	w1, [x0]
     ff3b0e7c:	d65f03c0 	ret
 
 00000000ff3b0e80 <sram_secure_timer_init>:
     ff3b0e80:	d2901401 	mov	x1, #0x80a0                	// #32928
     ff3b0e84:	12800002 	mov	w2, #0xffffffff            	// #-1
     ff3b0e88:	f2bff0c1 	movk	x1, #0xff86, lsl #16
     ff3b0e8c:	aa0103e0 	mov	x0, x1
     ff3b0e90:	b8004402 	str	w2, [x0], #4
     ff3b0e94:	b9000422 	str	w2, [x1, #4]
     ff3b0e98:	52800021 	mov	w1, #0x1                   	// #1
     ff3b0e9c:	b9000c1f 	str	wzr, [x0, #12]
     ff3b0ea0:	b9000c1f 	str	wzr, [x0, #12]
     ff3b0ea4:	b9001801 	str	w1, [x0, #24]
     ff3b0ea8:	d65f03c0 	ret
 
 00000000ff3b0eac <pmu_sgrf_rst_hld_release>:
     ff3b0eac:	d2802480 	mov	x0, #0x124                 	// #292
     ff3b0eb0:	52a00801 	mov	w1, #0x400000              	// #4194304
     ff3b0eb4:	f2bfeea0 	movk	x0, #0xff75, lsl #16
     ff3b0eb8:	b9000001 	str	w1, [x0]
     ff3b0ebc:	d65f03c0 	ret
 
 00000000ff3b0ec0 <restore_pmu_rsthold>:
     ff3b0ec0:	d0000000 	adrp	x0, ff3b2000 <rk3399m0pmu_bin>
     ff3b0ec4:	d2802401 	mov	x1, #0x120                 	// #288
     ff3b0ec8:	913d4002 	add	x2, x0, #0xf50
     ff3b0ecc:	f2bfeea1 	movk	x1, #0xff75, lsl #16
     ff3b0ed0:	b94f5000 	ldr	w0, [x0, #3920]
     ff3b0ed4:	32103c00 	orr	w0, w0, #0xffff0000
     ff3b0ed8:	b9000020 	str	w0, [x1]
     ff3b0edc:	b9400440 	ldr	w0, [x2, #4]
     ff3b0ee0:	32103c00 	orr	w0, w0, #0xffff0000
     ff3b0ee4:	b9000420 	str	w0, [x1, #4]
     ff3b0ee8:	d65f03c0 	ret
     ff3b0eec:	00000000 	udf	#0
     ff3b0ef0:	14000400 	b	ff3b1ef0 <__bl31_pmusram_text_end>
     ff3b0ef4:	d503201f 	nop
 
 00000000ff3b0ef8 <__bl31_warm_entrypoint_veneer>:
     ff3b0ef8:	90806490 	adrp	x16, 40000 <RAM_REGION_START>
     ff3b0efc:	9105c210 	add	x16, x16, #0x170
     ff3b0f00:	d61f0200 	br	x16
     ff3b0f04:	00000000 	udf	#0
 
 00000000ff3b0f08 <__sram_restore_veneer>:
     ff3b0f08:	d0806550 	adrp	x16, 5a000 <pmu_power_domain_ctr.isra.0+0x64>
     ff3b0f0c:	91175210 	add	x16, x16, #0x5d4
     ff3b0f10:	d61f0200 	br	x16
 	...
 
 00000000ff3b1ef0 <__bl31_pmusram_text_end>:
 	...
 
 00000000ff3b2000 <rk3399m0pmu_bin>:
     ff3b2000:	00000240 00000135 00000131 00000131     @...5...1...1...
 	...
     ff3b202c:	00000131 00000000 00000000 00000131     1...........1...
     ff3b203c:	00000131 00000000 00000000 00000000     1...............
 	...
     ff3b20e8:	68134a0e d0fc2b00 4a0d2101 438b6813     .J.h.+...!.J.h.C
     ff3b20f8:	4a0a6013 2b106813 2102d9fc 68134a09     .`.J.h.+...!.J.h
     ff3b2108:	6013430b 68134a05 d9fc2b19 4a052102     .C.`.J.h.+...!.J
     ff3b2118:	438b6813 bf306013 46c0e7fd 47310078     .h.C.`0....Fx.1G
     ff3b2128:	47310020 47310024 46c0e7fe f7ffb510      .1G$.1G...F....
     ff3b2138:	bd10ffd7 00000000 00000000 00000000     ................
 	...
 
 00000000ff3b2240 <sdram_config>:
 	...
 
 00000000ff3b2f30 <cru_clksel_con6>:
     ff3b2f30:	00000000                                ....
 
 00000000ff3b2f34 <dpll_data>:
 	...
 
 00000000ff3b2f4c <pmu_enable_watchdog0>:
     ff3b2f4c:	00000000                                ....
 
 00000000ff3b2f50 <pmu_slp_data>:
 	...






> Quentin
> 
