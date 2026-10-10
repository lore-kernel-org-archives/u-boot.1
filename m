Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF87CA9EC5
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 22:07:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 56FD4605ED;
	Sat, 10 Oct 2026 22:07:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hKiVFO25QaDh; Sat, 10 Oct 2026 22:07:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C878160639
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791670036;
	b=LaON5tZ3i0PNpENyCGcznpvrtcndW2e56GrwV0ZIshpmRWnaOKGOhpZ8sp1WWPKQvUi3
	 5ZrsXNC+gyyd4E2JGIGnGZkpmTJIfI7Spum7p8Hg0ivTuyb/dwaw2MJAXCVWmmGl4KaH4
	 ivSYn7CbvX+cqbljcbjx9M1W3H2a3HpD9bNxJe9zx/KoutPo5qw453Epz7FSflrB6mWf+
	 qWuesIMfIFLAelnGCVkym6/2yXGFtbYo9ph9QzCihRPIHL43MGgVICxUlh2DKCdaeKCky
	 AEXfT3CtWNAlPuh227iQOucgu1oRIQ+8g2iQAKTAO9dJJCO50BgIibwICazlVdKbRDA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791670036;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=RUjCQn+C/p7DT5Ev/wV8gDMIVKDGxJu6y57/j+Ia2f4=;
	b=HqbXyixDrFcMqHRXUdEouhC+WIOPkqOaLu/0O15JU8t5HCISUEwvrhTPtnkSbUzMDCl7
	 gwKvD6ulH4CnbYa3t8z6P1OrSXSSASNKolEWH6iYthsb1log1aXj3QdOD1hgbtRxGjbwq
	 Zp9TTWSHeaN5oLiIadFfKkTjCwk4pX9puAVqK6Eb+mIar+Y1j3ZvVgOUD4/Nl1FAJkh/J
	 kdkqxQxpGmE6BjICPSGPeFUaB3sQj3WswhrvqgdTg72WG50SD1e7NYHK1D7qvd3gLb2bi
	 YR1ZpA7T/NZ6a8lToRPkL1aYxanmsDWB+xL+SYVpHo3Bu4Nd77z5YGfb8yPKPNX5j8g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791670036;
	bh=RUjCQn+C/p7DT5Ev/wV8gDMIVKDGxJu6y57/j+Ia2f4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o52HNGV8jQHcq6djTXbUCGq2lkbd30uW7cSP7hNoMirgX2wUEIUvlQmqDhbR64cW8
	 utMqPMqQ/r2KYahPZeLhvapQ3u8lo2PHZUw/DmAVIcUE87n8cD/rtlJp3qMClpsHMi
	 6Q+sSHL/e8PGiXMOvpXNrzyb1FquRNVnG49emPtpq50995/iom96LdZaIVr2cWoM3b
	 FeVaGHOC6+jhDVENQCghSJeh/2JSyGlxywGhzD+qLOU5iQjHfRqB0J4ZERJ6csAmAF
	 4qllPYQrZUGqUxLYiB399J8LJDcfl2KaufKIbmC73ukid0X3/yROuOotJ6IM4OWRBw
	 FW0v294yZwIqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C878160639;
	Sat, 10 Oct 2026 22:07:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2194022B
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 22:07:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 103868097B
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 22:07:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z9K8AU7qefya for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 22:07:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8CA6480EFB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791670032;
 b=owIdaBJBfugcEFsqSQaBqDtCnbUOU9MYT/nrvf/PPPsMLKN0h4/1G6yD4zwzOXIP8WCY
 UFR9EVyeNsBnNBqqz+BWdf31RIJBcyd2jaQ80fkw09q4H2WCEtiVqopVUzhUGXMj6Md4S
 0F/jyobROgTtXfYvJh9/n8JFNqVcDLJab3GZocb+ZV96HkrzGmCAFIn3cfSycD3P1Szzl
 IlqsVbWh4IaF03P3aKXWORtN9AWFAb5eEur5Uk8VKd/rkDvSMjuM4Th0/nHfsLc3Fc6sG
 6w5MsdOK9NQ27V+qIB2JWNgnxvUhfEXv+pv1iYckS+0vV2gHyEUxG9BGlcJpEDr94dA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791670032;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=RUjCQn+C/p7DT5Ev/wV8gDMIVKDGxJu6y57/j+Ia2f4=;
 b=tV4Pa+wTr3cMzz344mP0IuvmF1/KBmkAXvWtck1rOYdrChG8qwdDw/houSf5FuDL+Bmj
 ++rH28lq6vqymbU3qCLuYEOVbB8Zt/KLwIIRSYoS4+GUJIbc83Fihtyihv4fQNXQ/UZoz
 BzcZy5zqkHaUE27raWdJU0BzoDjFstegoOLz7IHr58mU0d0n/JZtmojAolgRwFDi29K+U
 hMDPBI2aXIGtIL39g037PswdIwG5ijfS8L/fLGj58O7H7U2bzMebeCFwISGicWUCI30JQ
 GOKCxAnwDKkFPf3OPzqdQdf7c7YLPm+jVm06uCCC5waCY/9aawLXtgpXWwsxWrav9Dw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=dQH0lvqo; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=dQH0lvqo
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8CA6480EFB
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 22:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1791669992;
 bh=RUjCQn+C/p7DT5Ev/wV8gDMIVKDGxJu6y57/j+Ia2f4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=dQH0lvqo/w5iDWHxJqWrf0PqDN01D5gSMOS9GdHRPsXFs0DlAtqUAV2kmsTFkkeMU
 0VkDAzTbP4KY1u9HRSwm3gzUFb2kxytuy1Kl7l4JtKpofNciv4ekTJH7+pKAc6WgA/
 KtCNAZA1QaVl7fRu4khxy2424InOvEsIF4Bb5cJyjtaatBV15zoQDuxIa3+hjB86zw
 sNuDidhehZwfhdG/PDmco0aEFzp7t/irPwe5XOLyk0lqchYSMAuZowmVbR+doPsEKx
 Pf18m1K/vEg4X+CF7jAtF4z336AUv7/fZ1ERpMnzduiEnB/RgKrEpZAZ72SzPyqwi1
 u8nAN/tpwWpoA==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id F32D3B2202B4;
 Sun, 11 Oct 2026 00:06:29 +0200 (CEST)
Message-ID: <c5b06565-355c-4fdc-9f4d-c72977cd5130@freeshell.de>
Date: Sat, 10 Oct 2026 15:06:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] tools: mkimage: add SpacemiT K3 boot image support
To: Junhui Liu <junhui.liu@pigmoral.tech>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>,
 Randolph Sapp <rs@ti.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yixun Lan <dlan@kernel.org>,
 Yao Zi <me@ziyao.cc>, spacemit@lists.linux.dev
References: <20261010-spacemit-aihd-v4-0-e7152ae4d71a@pigmoral.tech>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20261010-spacemit-aihd-v4-0-e7152ae4d71a@pigmoral.tech>
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

On 10/9/26 09:31, Junhui Liu wrote:
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
> Changes in v4:
> - Revise the documentation wording and layout
> - Collect tags
> - Link to v3: https://patch.msgid.link/20260921-spacemit-aihd-v3-0-f660fc85d2a5@pigmoral.tech
> 
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
>  doc/board/spacemit/smtimage.rst | 144 ++++++++++++++++++++++++++++
>  include/image.h                 |   1 +
>  tools/Makefile                  |   1 +
>  tools/smtimage.c                | 208 ++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 356 insertions(+), 1 deletion(-)
> ---
> base-commit: 0a55b098d6f5f6bafa84fc2f18b433dd167bf729
> change-id: 20260820-spacemit-aihd-05c46aae886e
> 
> Best regards,
> --  
> Junhui Liu <junhui.liu@pigmoral.tech>
> 

The documentation (patch v4 2/2) is not what I'd like it to be since not
all changes requested since v3 are being implemented. I suppose this is
a difference of opinion that happens with documentation and I accept
that the most important technical content has been improved to what I
consider acceptable.

Without objection this series (or at least the functional portion patch
1-of-2) should be applied for the 2027.01 merge window.

For the series and with much gratitude to Junhui for their work on this,

Reviewed-by: E Shattow <e@freeshell.de>
