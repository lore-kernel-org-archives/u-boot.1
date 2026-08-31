Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D5FC61DF0
	for <u-boot@archiver.kernel.org>; Mon, 31 Aug 2026 06:11:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5E44E605F8;
	Mon, 31 Aug 2026 06:10:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2vcxbxyljBIz; Mon, 31 Aug 2026 06:10:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788156656;
	bh=uIBeyMj5kkTAI0cycERcA6YRp2C7r18Lgx63KYwBAes=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aibbS/9LcmRADLhgaMXdWQlWY56jYHsZPEh9sVw5UiXv6bIYrPs2jujLLp0JaP/7z
	 y1qfyXShbDgf2Hkw1papnb/AV0eDROxZg0BOeOd94UqqVXx3ZccmK5/1yiLKo6PtoP
	 BGeUor1lf4suerB5WFDd46srs+4sxcALaQzAhYhFfy/Q4yGP5AeoIYKmOf+iXKl6N7
	 /tBLu3WJORBOdWJb4w7HQDTdXxSvjELF2EVqLtTGm5Vmmf4owQcrLRua+xjBVgn0zY
	 LHX9Qg6nEqrvKr5SvQHfaK6n2VG4QNbNIWQx9AzKgz3gyffim4FAMNb9HoLdZ2383r
	 UiFgDrX/p7eqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF5A8605D5;
	Mon, 31 Aug 2026 06:10:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id ED49B355
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 06:10:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DEE8A4054D
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 06:10:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9fm1GOLql3pC for <u-boot@lists.u-boot-project.org>;
 Mon, 31 Aug 2026 06:10:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=TalHJXmE
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 946E440534
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 06:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1788156608;
 bh=uIBeyMj5kkTAI0cycERcA6YRp2C7r18Lgx63KYwBAes=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=TalHJXmE2+YFa6ULKFa0jwtN51XkKMsu3aoY/Bp+iI8XkfDQRFas8sL0fwUG7/VPC
 IsZFK9GzBFSmYFyjZTZe9Vvbo+epPvL067GnaOZey3EWAX2awN2Mvj5XEKeq1slUxf
 7IVjsdzTZjHEsDxPLR1UkGine4zsks/IAQM2HW403F1p4ii/c8F55qBanJO8LLSDOV
 rotYfdNMAUcPhS2i5PTvMblukNzA4E5cg3wqvVROIRud1o2+hnxIUl6Q8Fzt8z3die
 yZODahKoyLfeeno6dOH7kTQg8E1SKgT8igyZICHqOGztbX6YL7IEaVcuUFBkKb7SUR
 ZCgctMKbMJVZw==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 4C680B22028C;
 Mon, 31 Aug 2026 08:10:06 +0200 (CEST)
Message-ID: <6565faeb-12cb-49af-ba4c-4fbc66f64eac@freeshell.de>
Date: Sun, 30 Aug 2026 23:09:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] tools: mkimage: add SpacemiT K3 AIHD image support
To: Junhui Liu <junhui.liu@pigmoral.tech>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>,
 Randolph Sapp <rs@ti.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Guodong Xu <guodong.xu@oss.qualcomm.com>, Yixun Lan <dlan@kernel.org>,
 spacemit@lists.linux.dev
References: <20260822-spacemit-aihd-v1-0-bf4c41993891@pigmoral.tech>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20260822-spacemit-aihd-v1-0-bf4c41993891@pigmoral.tech>
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

On 8/22/26 01:56, Junhui Liu wrote:
> The SpacemiT BootROM loads a first-stage bootloader from storage or over
> USB in MaskROM mode. Vendor firmware packages this bootloader as FSBL.bin.
> Its headers use the magic "AIHD".
> 
> This series documents the AIHD image format and adds the "aihdimage"
> mkimage type for the CRC32-protected K3 variant used in non-secure boot
> mode. It provides the FSBL packaging needed for future K3 SPL support.
> Select K3 with "-n k3" when creating an image.
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
>   $ ./tools/mkimage -T aihdimage -n k3 -d k3-uart.bin k3-uart-aihd.bin
> 
> Hold the FDL button, power on the board to enter MaskROM, then run
> fastboot on host:
> 
>   $ fastboot stage k3-uart-aihd.bin
>   $ fastboot continue
> 
> ---
> Junhui Liu (2):
>       tools: mkimage: add SpacemiT K3 AIHD image support
>       doc: board: spacemit: document the AIHD image format
> 
>  boot/image.c                 |   1 +
>  doc/board/spacemit/aihd.rst  | 145 +++++++++++++++++++++++++++++++
>  doc/board/spacemit/index.rst |   2 +-
>  include/image.h              |   1 +
>  tools/Makefile               |   3 +-
>  tools/aihdimage.c            | 202 +++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 352 insertions(+), 2 deletions(-)
> ---
> base-commit: 6073c36b2c8d39afe3ecc789b281667a3ddebc70
> change-id: 20260820-spacemit-aihd-05c46aae886e
> 
> Best regards,
> --  
> Junhui Liu <junhui.liu@pigmoral.tech>
> 

I confirm this output as described with Sipeed K3 Pico-ITX and Debian 13
Trixie host build OS

For the series,

Tested-by: E Shattow <e@freeshell.de>
