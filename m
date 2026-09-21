Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FED2C982ED
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 16:53:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E5B4760749;
	Mon, 21 Sep 2026 16:53:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D0INqjyLhFGg; Mon, 21 Sep 2026 16:53:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 28EBA60740
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790009623;
	b=AVF28wUP6H1aKfb+8zkv0FWPKDSZzyAwFHiHEE6Fbttar803u6IFEcaKAULfr7hTBlR/
	 2H4JjNgh7OVBibgPZTOl/A2u24pT5GdGklkYNcJ5rI9qQjokI3Wi9MAN/HeY1jepV4lAh
	 V2CdBdF28bbiFEP67GiBPx6mq6KgKVcX3HXgTTU99f7344C+KqFmwiJPK08v3IE+Fuw0f
	 uVB0uDddtp4RTHVDlSHlYZygJNuiVbB294la11RPHF9Gj3pSMAqig8BtOIuQvH72U4c03
	 uZxNB4FA0sW5EbxqjRp6i3KMslnn+qZR/XKRQqElyuXl7T933jsbnilbYIvL/19KsfQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790009623;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=K+L3SLq90kDfYzcPgGFoIViEEhflyVMvFHya6naqWDw=;
	b=QuM8DMSxdiQbA7apUYTYmn08TwKY91dxcmE+8fr7gycEAzP/fXGdkcgRn5Vp4f5n1sHc
	 F2Gg9P0cnBTFT/DKojYU7oN79AZpSMRkGxjX4ryEaVOB/fxX5nFIZ7n05tBvZfBdBtLsW
	 fXj/rZl2JM3vEn2sklgX+OAoMTvVFUCjXnUffAzJEH81T6zV5gHf87b0tURWYanCzOuK8
	 57Hiwk21RYfPTVeHEOqYiPM+DGcA2PXw8W1wEnri4ok+Dg82MPuTclVAZw9HnBVcDfj/f
	 20v0uNwexkjm3xRZ4/KNDo5xe/RPI9Yn9YpPzwHjFtydiBAZR787OjY1xA37eipyRzw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790009623;
	bh=K+L3SLq90kDfYzcPgGFoIViEEhflyVMvFHya6naqWDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rZh8zustOuLjMl7zHdCej4ZAqx8PNKC6B5WLgBuIwWMMHCXAxIQidUS7vpFfRhdAL
	 WAKamH3MqwVAOufMRf+J60c4cRJItcMp9z4/lXpOmuQTPqaaxNMGBFR/G0LdNZDSCN
	 QM/LlNitbujcveXaHgEqO/XhyHnmZ++r+hQV25hcUvho0DS80SclecNCm5VFb0gxt9
	 hTykjJnz1wxii8lxp8/KbZbuR3rtlprJR9H87J4bvesN0NMXD0lPjpDNYaMp1zWHIt
	 y8rZnZJC0/ceZYSXxZOpBuTGHuF4mP20f6wsFZ4wuoKLRAHRQElTy0GEeTugmHVZvF
	 SqGNZsruTT4wg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 28EBA60740;
	Mon, 21 Sep 2026 16:53:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4E05F334
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 16:53:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 340A840800
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 16:53:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cey736pVxGsU for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 16:53:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6FD67407F2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790009620;
 b=B2ATeapkP3M9505Ch1Szs80t6IGAtaddoZi/JBBvxtLNEd9IWtBur6q0zPcpfxOms2C+
 R0+oGH2aF5eEjUeosQFxYiCuGB2fFa2Lgxp46yy+3QLWDdgEK9P4wQDWEla55c4OA5Z2g
 pDvGL247MWxtVEMFn//caChTB0e1xSGPi1Rs3nGCscnkHK4k/S+/0jC7FORPrKSsrmCiD
 RGk3xaNYutE4mInP5F83BMLirtygTgxcDoRnX9rn9kkfGAZTFQYg0w3CJtjDMmV+JTwkS
 +ahA84gU8eMdH1ybCVMzuufz0QZz4dfbvQBFNl6cNvQbF0HA8LrTv94hZ51TdYQ++gw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790009620;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=K+L3SLq90kDfYzcPgGFoIViEEhflyVMvFHya6naqWDw=;
 b=qBD+xXRvu+253rRPewMFWoUgQ6mYRxc+91sU1J4lje0UCUybleXMB0vkFadmR5E5EgtY
 aAG2gbhAodTj/Gg4t72eVyz+ihJ+3WY6DX0E61EIba7uRPPL2DMuWUi5Lk0w4QzQSJc4z
 3Y6oojW8l5k3L00v7cC3u2rTLgaVAhhjHGZz8j3aA9o6I1hdLNngEvBpkbzIZe890D57N
 ewcN5McyGz1PPF/elK8UH/QuZwA3mW7Xg01wyIgI7D9AQAZwY/Mt9/CtsKCPHoWnGf1I4
 TEO6x14D6nnm/jzL0W3dQtlPSPWgNzhY1GNKAMM3NrQz1p3scuEVC3o90yJiZ0Hr5LA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=ziyao.cc; 
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=PYKUNjWO; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=PYKUNjWO
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6FD67407F2
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 16:53:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790009596; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Fo0Tcz66tbSBNkfuvBO8vBSZDsE7zkEiJGvOzvJ96Tq8p64fxWgueFweFTu11tyvztBSBe6le8Yz7PR9ECIUFGpbHQFxW8/MbBRjZzFEP0hOHamfEuFZZTxZU/Ttl1haun6y5426pwOUb7PDrZm+m96SSd5GHD3JjNOAzlfIVfE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790009596;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=K+L3SLq90kDfYzcPgGFoIViEEhflyVMvFHya6naqWDw=; 
 b=Wp+XiDUgrMAZIPrUGgW70BOA1vaRfKxp0JEHMUxKOWAQzaRTMKHMJVIUPcyLtgSkNvw6iQHHi15II6Nemfe90QJIuLEOpglLrTDvW013FWuLAMT9IrXgYmjwOBIJiTT4kkZrORFUFLBWbDxqA64HyF70FE4jwg3ZhF+hv+qQ//4=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790009596; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=K+L3SLq90kDfYzcPgGFoIViEEhflyVMvFHya6naqWDw=;
 b=PYKUNjWOdqiVv8t8DNJsBQi1XdSCUTrI/a2sdp/bybGeKRkclSa3hYFbUJk1TIq2
 hVgoJXPhd4uCVT4lR6m2QINssh361gLXbGHFh8cJMQ5hgmQspJV8gdOtL3sOg3hQf6l
 KOaLBAj9IXgbmjLr/J682p79LmAY6qAlwHGMfkjI=
Received: by smtp.zohomail.com with SMTPS id 1790009595515668.187319522702;
 Mon, 21 Sep 2026 09:53:15 -0700 (PDT)
Date: Mon, 21 Sep 2026 16:53:08 +0000
From: Yao Zi <me@ziyao.cc>
To: Junhui Liu <junhui.liu@pigmoral.tech>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <sjg@chromium.org>,
 Daniel Golle <daniel@makrotopia.org>, Randolph Sapp <rs@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 E Shattow <e@freeshell.de>, Yixun Lan <dlan@kernel.org>,
 Yao Zi <me@ziyao.cc>, spacemit@lists.linux.dev
Subject: Re: [PATCH v3 0/2] tools: mkimage: add SpacemiT K3 boot image support
Message-ID: <arFg9Pii2uosUkrz@pie>
References: <20260921-spacemit-aihd-v3-0-f660fc85d2a5@pigmoral.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-spacemit-aihd-v3-0-f660fc85d2a5@pigmoral.tech>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/289.848.60
X-ZohoMailClient: External
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

On Mon, Sep 21, 2026 at 10:54:37PM +0800, Junhui Liu wrote:
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

For the series,

Reviewed-by: Yao Zi <me@ziyao.cc>

Thanks,
Yao Zi
