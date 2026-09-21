Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD24C982E6
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 23:28:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C7FF60706;
	Mon, 21 Sep 2026 23:28:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aTqlbHz1o9_Y; Mon, 21 Sep 2026 23:28:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 28C07606B8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790033282;
	b=mlC27RtGbT3EnFgc7M++/+orpfKG8nd6jAsIVrIEAMgtjSPnzY/9RR/5HI30HEoBmSGA
	 Ej7hWW0MHOxXHtFKQUMhEgP3WccYrLqwST7jHYkHpZVGDr8zEf+HGHxwRsRn1PZxUda19
	 LMLqBVhxZk9aa4xAygXZr3bQZ3iLBB0kcv9Nfj0vfSIwLTwUNld83AoTW3fqRYoNkvLQO
	 iPyPKnTpj2DTO5zswxBeU/RagDgl1R2ClcIAlgJ9I9lnFnPioe0A/VhaAKNzn11uMAmQY
	 CWQ3Jt/XDcSlSUCwGWpExlcAcPltJSQBN9fVPPF4SXLJ9PQyDfu4CalYUCAb2MUsHCg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790033282;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GYdCJGCYLHjDainyCD1+PMu/DeJhUUSAbfN+C9JxI4U=;
	b=aNYa3Lru00jOsonCGxk2KkIcHaOOPjsObGEItXc1Af+dCgjel7dzMS1dK8gdjQPwGoZ6
	 g+Ih9Q2dVOxKZPvEMkcrHCUJi3NV1EmC3YEIxU5zriMFeas8sySie9iOvqmarMsCOYvZV
	 VJStfrgxSXOTGweDMFmSwMcovFlhzQxfnPD40tsObv9hkV+DLX01FyE5r++s5+8kver0/
	 N1Lj/9eIQenlFuUS/RScRiwlYHA6cV/fovpFk1S1Pf3HhRxH8NhCbC+Pa4gy0j18Lxggb
	 qf5oDynhYh8fH6j+Ge7UKpFTRKzxcg+Nh6ts3CrXZn1wmLs+qoMSBBLfAaf/v2B5yGQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790033282;
	bh=GYdCJGCYLHjDainyCD1+PMu/DeJhUUSAbfN+C9JxI4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0fuJ8ADfkSJyNOwuS911VovWsleTBBEcOUdIIvISs33aw+1RqeMye6ZfA4trzpl8v
	 RjMvRUXGWt7jJx2Q3EwfBtp87AH6hSmJT7MP89hJ6RV59VtCJHqBEk59M2kmvHNVp0
	 T6SkGf3+carI0EoGlVrYOGFXaFBi/TVyrvGdLQwUSAUaoHzT2vjGPYd5bxbOvioNFA
	 ev6K6hzfEBt5ZGuE1b3dXSjxYYJKUWm9EBy9NIPNNXfpBOwGc4MxQv6NYYQPz6Y9oE
	 qSJL5CetAU0BpPOIUgAbfBKMHtXyeBovsWelhhKLXDMZkdHZF3ezRthN/IqYPIT/1E
	 qxCAwdG+dcyow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 28C07606B8;
	Mon, 21 Sep 2026 23:28:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E6BD63A9
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 23:28:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D83A880CD9
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 23:28:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qPXirWtGuzRU for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 23:28:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E1CE080CC4
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790033280;
 b=Xgks3B5muCdgat0wDuQRIqwL8ly1QOH4Maw0oDJLev0JDfpEfV+0qRpfnJxWz2hBgdl1
 IrxmjQvd0sUPiyMNcTzQUa25NZ/hqveFmxWzNTgv3yDH1iouDeGb8b2iZMEjgK9rRN+8R
 XzAIjNZj8EuQPc3U4WghhdacNIX2bXleMETtwc5zxrk1t3Uk5KloTDkAJFf1PlYdyZwQA
 GpJ2zYcrBtSco3baR7rXmx2Xydo5w/XpN/9f7MJbSkfjSdoA6Bf7D5jZuyRGasMRR/u65
 LFGkBL0Wc8AjlidkKnv8TQYa/OFNN+2JPGGvoLIiT/iTonskxzf/mgp6FocdiNAWtpQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790033280;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=GYdCJGCYLHjDainyCD1+PMu/DeJhUUSAbfN+C9JxI4U=;
 b=RbeW7K2gxWI7+eCvaudHNKeg3zhG/H/ckhk2Kto+GczgWMZCHPHeWF3FDKTHo1ap0rOd
 OavvRg5sIzfeecHSgwUVW1O4KYavi8xPRgYGEITPzLA2Ku86kEWRhAuqtFgd8GUgm6obl
 Bc6IA9FG8Dq7brEHYLLTtq6ytRYuRPPmzRb2xLO0/baQc+j6SWFpk6dpwqSjj8WOQ28QT
 ZnXd158Gm+WCuOkTezk3kAZBYhCCccFvzeW5zrfozccpWe+H93playi7ZDfs1hoFgMdtu
 uBBYOTfm8fuxPVdJcRtLUye+nARC0NBrd0NFCrH/dPtcyU1sVGy6GXGTDCh/pwD1vww==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=JVCSdeyH; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=JVCSdeyH
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E1CE080CC4
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 23:27:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6281941507;
 Mon, 21 Sep 2026 23:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D281F00898;
 Mon, 21 Sep 2026 23:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790033277;
 bh=GYdCJGCYLHjDainyCD1+PMu/DeJhUUSAbfN+C9JxI4U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=JVCSdeyHMF/ngT1AGL5m+a/8mgoFjlYG6BCc+AFfjEKFn8+yzhp0qEN6YBuCNcYLL
 Ca1xlLuWEnp5Ms3ydZ+BwJD/za30XowBIywavhT+m58tdXfAY8HUlh0RdGnbRTUnEB
 th/YMmGabPfQINMoEQ/lQvEpbHXK3KjRy5Wu3ANvZQeNQbi1QsEMPDE+qOkOZ9hLVa
 hccYctv0I6LjwVJqsHBmhLVYOguZC5PEtVnSk8kLqYw9OtoebaQUEULw4Lir4wR9Te
 /4d74wsC6lH/d+AwWHUViFx7gqTfQbZ1y+qzvyjeoxPgBQdSHz3/KvyxrmFi9uBVsU
 wzLK2NTWvrY3g==
Date: Mon, 21 Sep 2026 23:27:55 +0000
From: Yixun Lan <dlan@kernel.org>
To: Junhui Liu <junhui.liu@pigmoral.tech>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Daniel Golle <daniel@makrotopia.org>, Randolph Sapp <rs@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 E Shattow <e@freeshell.de>, Yao Zi <me@ziyao.cc>, spacemit@lists.linux.dev
Subject: Re: [PATCH v3 0/2] tools: mkimage: add SpacemiT K3 boot image support
Message-ID: <20260921232755-GKA353745@kernel.org>
References: <20260921-spacemit-aihd-v3-0-f660fc85d2a5@pigmoral.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260921-spacemit-aihd-v3-0-f660fc85d2a5@pigmoral.tech>
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

Hi Junhui,

On 22:54 Mon 21 Sep     , Junhui Liu wrote:
> The SpacemiT BootROM loads a first-stage bootloader from storage or over
> USB in MaskROM mode. Vendor firmware packages this bootloader as FSBL.bin.
> 
> This series documents the SpacemiT boot image format and adds the
> "smtimage" mkimage type for the CRC32-protected K3 variant used in
> non-secure boot mode. It provides the FSBL packaging needed for future
> K3 SPL support. Select K3 with "-n k3" when creating an image.
> 
> K1 and K3 secure boot use RSA authentication and are not supported yet.
> 
> How to test
> -----------
> 
> Rebuild mkimage, wrap a small UART test payload, and load it through K3
> MaskROM fastboot. The payload is linked at 0xc0801000 because the BootROM
> places the complete image at 0xc0800000 and enters the payload after the
> 4 KiB prefix. UART0 should print "Hello SpacemiT K3!" and then loop
> indefinitely.
> 
>   $ make tools-only_defconfig
>   $ make tools-only
> 
>   $ cat > k3-uart.S << 'EOF'
>   	.equ	UART0_THR, 0xd4017000
> 	.equ	UART0_LSR, 0xd4017014
> 
> 	.section	.text
> 	.global	_start
> _start:
> 	la	s0, str
> 1:
> 	lbu	a0, (s0)
> 	beqz	a0, exit
> 	call	uart_send
> 	addi	s0, s0, 1
> 	j	1b
> 
> exit:
> 	j	exit
> 
> uart_send:
> 	li	t0, UART0_LSR
> 	lw	t1, (t0)
> 	andi	t1, t1, 0x20
> 	beqz	t1, uart_send
> 	li	t0, UART0_THR
> 	sw	a0, (t0)
> 	ret
> 
> 	.section	.rodata
> str:
> 	.asciz	"Hello SpacemiT K3!\n"
> EOF
> 
>   $ riscv64-linux-gnu-gcc -nostdlib -fno-builtin -fno-pie -no-pie -static \
>     -march=rv64gc -mabi=lp64 -g -Wall -Wl,--build-id=none \
>     -Ttext=0xc0801000 -o k3-uart.elf k3-uart.S
>   $ riscv64-linux-gnu-objcopy -O binary k3-uart.elf k3-uart.bin
>   $ ./tools/mkimage -T smtimage -n k3 -d k3-uart.bin k3-uart-smt.bin
> 
> Hold the FDL button, power on the board to enter MaskROM, then run
> fastboot on host:
> 
>   $ fastboot stage k3-uart-smt.bin
>   $ fastboot continue
> 
> ---
> Changes in v3:
> - Align the uimage_type table entry with surrounding columns
> - Explicitly include the needed headers
> - Drop SMT_PAYLOAD_ALIGN macro
> - Simplify the NULL check in smtimage_get_variant()
> - Fix the title underline length in smtimage.rst
> - Link to v2: https://patch.msgid.link/20260909-spacemit-aihd-v2-0-780e98cf2fec@pigmoral.tech
> 
> Changes in v2:
> - Use "smtimage" for the image type
> - Update the documentation and command examples to match
> - Link to v1: https://patch.msgid.link/20260822-spacemit-aihd-v1-0-bf4c41993891@pigmoral.tech
> 
> ---
> Junhui Liu (2):
>       tools: mkimage: add SpacemiT K3 boot image support
>       doc: board: spacemit: document the SpacemiT boot image format
> 
>  boot/image.c                    |   1 +
>  doc/board/spacemit/index.rst    |   2 +-
>  doc/board/spacemit/smtimage.rst | 143 +++++++++++++++++++++++++++
>  include/image.h                 |   1 +
>  tools/Makefile                  |   1 +
>  tools/smtimage.c                | 208 ++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 355 insertions(+), 1 deletion(-)
> ---
Looks good, so with

Reviewed-by: Yixun Lan <dlan@kernel.org>

-- 
Yixun Lan (dlan)
