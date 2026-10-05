Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB12CA5FF5
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 00:55:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6A7124069F;
	Mon,  5 Oct 2026 00:55:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id thR0esgeF1YK; Mon,  5 Oct 2026 00:55:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 487C140695
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791161719;
	b=mKxd9Qz0rUcmNujZDeixawrKIx6fEmmxWgxYLwbOH8NgoOIShEZxEdB2ZViWAdXdzwV3
	 9vUNa0shOPx8JoVohzixF4CzKQu/g5ccRkZ/LxQQVOOLGP5CMmjv6yvlgZJ50SLzhYwc2
	 Rt5jC2MIP+iRL8CjcjBxnWx00nl9KbWu1gnxqO5Sy5Ukj28LelNlV0eLtgeVkLGYDca5m
	 VKlV1sBLuFN4KeLAL8QpCP13it91Dr3pIzvMCWMMRM3j24vuxWr/4HHh1X5uYXt9YfS+x
	 XzSoRs+uWa20v1OKZggqHrkzCKAthNN83ITBFJGeSgudsm8cNn6bB59zikZgV3p+Jvw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791161719;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=RjWIPnMo0WuuORQ8XVbFkHZMWG+22lnu2Y2UOJjDMgQ=;
	b=YQMZOp/aNZT2Sal5yHZoDVG0SYXtiiiIYJnwOyPZZ9WhlC4mKzBQuiiuOqPjtmJp3rwj
	 uMNQm0mhBhyuE7xi5AhC6sH6t6xuUk4gwjE2R3wbU/4gvEL+YvQtZ7nbBviF86Swcrkjv
	 aEtIDcQ9MqHu5TZWQkHsTdcfoiGgi/3/Ni84XrrHzMrifT7/PX6O01cNlezvbfxC4ne69
	 QPzsr0UvzlVXJikw3prTcp/irl544DOJjX0iviq2wmDGnplZi1M6VGv6NB93YZ8JMSuwO
	 bxsNskgegQg+OlEHSNRycPSTiS74gP9g9H+6whUniExArzahG4btxK9d6Xx/fdnNcfg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=freeshell.de;
	dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b="nZk6/9Zk";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791161719;
	bh=RjWIPnMo0WuuORQ8XVbFkHZMWG+22lnu2Y2UOJjDMgQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gqP+4p32/5iflnUhM6M6/NIv78BTou7c99Yq7D0h9EIWropdTZZtQ/H2UEpgHgJ7K
	 MDX/IpZ3A3sA8p7700xXb4K8j3oFhqPnochpLmrnRPAUnlkituH3QEwpVpm/GSKgW4
	 RLuAL4E4EphNNi5PH/WNtheaXYotENyh0AF8FCrOMVcQuc7GZUcB3r7pRZlpYHmoep
	 FP3S6/bpbx6/+jWFctLt0Rpcm1apa7BXHQ5asln3NctkosEKzCIwsTmtbVCyE2K7kE
	 OM691J4Z8N1kpb1R7AKmbZIk/QJ9EdK20ibBMJ7IBuM9U5DqkQLbdHpGIO0KDua1rl
	 INJZeV36ug6xw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 487C140695;
	Mon,  5 Oct 2026 00:55:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BEED7335
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 00:55:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AB62B40695
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 00:55:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dCCt97zgY544 for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 00:55:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5C0FD40692
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791161713;
 b=saHRyBdXhHj8tfuJ9w/+GKI4DzCVnfdu06ZHYnyqTANaiFKQtj5pql1DWECX9ltqA0Sk
 KSeJSEE4OpgibBMmMtp5uSG4DfU0rDYdU08g64AX16e4oJbh7gbHu2Jwz1weZ5opOXYdj
 YUkE0Gw4zTJJkQfta25SNDx0uDudXFXEZbuyZ3O818Nl/GK2L3lpvAyQUFa0jWSJK0QOE
 Q35vOlZ2p/udGFX8R/eMJ6GbNonSDuqCbZcgE/zgiQDp76af0SmTEXINQD3ZolHYv+PBu
 1QIOt17VdL4aB6s/bB4NsRvUKKJR1O5i24fkFWb2WVRSYSd2F+InnUZeEKm712whegA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791161713;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=RjWIPnMo0WuuORQ8XVbFkHZMWG+22lnu2Y2UOJjDMgQ=;
 b=iDE24RhYRiH+9wRRX6UWHBcA9qkYr2KANVl8usAUX4Kbd932rB+nUd/XZ+7FAiC3sqO8
 XHMqcy10bxDSxDduYxs3ySSAR8AkbAKG4whx64r808GRZQ8l6IMyrrMljBMe2MdhsEU3I
 HKCvJmi4vQEvjVgodoPU8A8S0p8qxKJUauBpT814NViSUxXilclv8oqwyGe3uziB71Hzl
 SIL2P2tqc4mDA/wrhJ0d2RonoA4MK3q2EqA2N+KOr0jQvfmEhpuQ7/6sYp75jT3R8JJQC
 hmXOlYtG7rZ1ATaeHc9fLAgPUuSye9Ge+IsK0xpkwF3TlnMRbJ/Hcwm92/HW6ybEH2A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=freeshell.de; 
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b="nZk6/9Zk"; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=nZk6/9Zk
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5C0FD40692
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 00:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1791161685;
 bh=RjWIPnMo0WuuORQ8XVbFkHZMWG+22lnu2Y2UOJjDMgQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=nZk6/9ZkLpBLRFXyLOX7Hs12bHRtmbM7SB7xvK1LxnNlL3Oaeb3VkhHYIt6NSP8s0
 pWGC5RCJSBfVqzVqjnw96XgBmZ8ivmWYh7Acx7GdEb2x3B4jaK7RePVMFXZTsUsHY8
 iFq2OO70VFwfHUB8fF6h9bW9N3+F4HWuwHQMn8hTVkn/M6yr6A6d2UXHewRCSA6yqd
 uCY+jsd0IfdoU0umcIc8AqbCp6/nmCFiXCCCBNmC23u9SkfK4DFELMY/5HbkAue/CA
 tWhj9dMnygmrBmGyLjlPGk8DC6QCQxxElRjasgogKnUt3PlPP72eA2U6bkL+80dSNP
 QeB0ffLyI7+rg==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 7F21BB2217C7;
 Mon,  5 Oct 2026 02:54:43 +0200 (CEST)
Message-ID: <edc620db-7b9e-4c37-81ba-dead078a02f2@freeshell.de>
Date: Sun, 4 Oct 2026 17:54:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] tools: mkimage: add SpacemiT K3 boot image support
To: Junhui Liu <junhui.liu@pigmoral.tech>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>,
 Randolph Sapp <rs@ti.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yixun Lan <dlan@kernel.org>,
 Yao Zi <me@ziyao.cc>, spacemit@lists.linux.dev
References: <20260921-spacemit-aihd-v3-0-f660fc85d2a5@pigmoral.tech>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20260921-spacemit-aihd-v3-0-f660fc85d2a5@pigmoral.tech>
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

Hi Junhui,

On 9/21/26 07:54, Junhui Liu wrote:
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
> base-commit: 211de43d0f954a00a490220c1aac9db298287c40
> change-id: 20260820-spacemit-aihd-05c46aae886e
> 
> Best regards,
> --  
> Junhui Liu <junhui.liu@pigmoral.tech>
> 

Thanks for your work on this, the actionable concerns I have with this
series are about keeping documentation short for being reviewable in
diff output, and revising the suggested SPL image output name to be more
sensible for mainline u-boot. Let's see another version and get this
merged, please.

-E
