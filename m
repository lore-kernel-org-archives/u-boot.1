Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C46606A334
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 03:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hDrT9kns;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=gVdie+/g
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ED0F140598;
	Wed,  4 Nov 2026 03:57:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oNNryv2T7eWB; Wed,  4 Nov 2026 03:57:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CEB234057A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793764635;
	b=iCgmVd/W52j9DkcAu9ZEtbCwg/qpi8+QLW7VGp3fUK5WohNAUznkwAo482Sm2qNCZjS+
	 YAEy3fIUvBsQ4PpqyjyHKXpL0TVEh7WqdY4y0rr+8FACfYnaHC2n65WcIvjf0c+i6U43t
	 sxL79h18rZzZrBcIChXh/MbIbByEDL0CLltTW3nGTk+GvriNoVlpKuZjdo81VT8Hq130Q
	 vQVxXrqSATf4BTmJKGJyeCmBtD/1ywLc3IGdPJv2t8aDZbjbmcQiLDAZyFro13QG0ERUT
	 SDI1hwC+8EjgOXjdDyHIw36jpBpIKR+BlCKuVpZR8hQKzpVjGtQgapOo8MMnu8DaRnw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793764635;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KG076o9TNl2hMAEFUu34ZSmDRE9DCApKZ8ewgiuIoCw=;
	b=c1M26qJY3wzMIfuKyKC+wS8HI9ZKSPUdYQv001zSfObAFbq3R/cI7DFfPIV9DvBJBfWt
	 WJ12+OWA7HY2aGRqwA1fe2v0+AxlL2GKTjbdpIISu3CTmHgNJEeaVluFUHkPc/qqCmDC8
	 16V/Y8RwddWRTGsxZnQVBgwIIMpEZWLKtvgmnRJXiAtTGMu1No9UVtb4sdOkhiF484jp6
	 uPyX5skUzuq4Unr5ftw5t1hF1lCmXaeNZuzDZVT+emdSOz6FLzRDmoD56vaepT0H77tCC
	 UkRqiBjvnoyAJet0k7tiekJa1CTw8ZvRwBLz89diQ0WqetZtdfJNK2jVY9Jcz9Cdm2w==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793764634;
	bh=KG076o9TNl2hMAEFUu34ZSmDRE9DCApKZ8ewgiuIoCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hDrT9kns3rkqWB4mMnD14z0zyndn1m/RVIDaXN9G+GSRFUf3cVy0ke47IhayijU43
	 IVMd9wSlihk5O9Hha8kl93Xz5o0eBuUtcOwS0I/n7kt5r5+wUARP5tl3hxCO1hsv8X
	 TIpDdWeqFMwV0B+Ba+Zfnh9+xpl88L8H6OLZRyP0nkPxb2znGnI4WsSgpuKxeV+A+5
	 OsrM1ZFRp3nJw+NetLqPyavbKaeupCrr4gh5CbkDSXEZrgCnqXVlqpiiUYJe3RH5Sk
	 hkuzNHhga2XrdULK3H47h8a13KLiBKFncnUY2RFaJyTbI/SwTy2wdo0goGbaH6Ho3J
	 CdacC0kOiJsXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CEB234057A;
	Wed,  4 Nov 2026 03:57:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E14A8784
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 03:57:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C6CE380D32
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 03:57:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jpp17h48i9Qs for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 03:57:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 89FCF80D30
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793764631;
 b=iBBWBzeMHe9GGQAOili/jJgLMNRZvU8iZHO8+KDji0Y0uQdJuPJJUpAvLK+lMOywuB4N
 oNzS6sjDGqgQixk6d/flYT1s0hmId4mDjTmEcwAMtO8j9qGsUHOYXJNieOj2aUWsnmWMN
 r8EXECEYa0haJZT4JiuQwbS4E8klk6vlPgE6X6zpIstPPpXeHPYkOR0r5P76xBpSHVaBK
 CuLhbeTHAESRnAKI376c8boHbVt1InHGtbo7bDtOs0XPuZ53RDrcpftepfdIbtNufJ7wY
 /vCLCYK4gO/UTAeivCWbi4JPC56QDscPVtIXxfuFyJYMbDHVbU+drl8TYe88+k1eaWw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793764631;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=KG076o9TNl2hMAEFUu34ZSmDRE9DCApKZ8ewgiuIoCw=;
 b=b7vWKt+qvx86EnRSSJeP7K7w2brtafeBAQhsZVd+Ugz6uFlXVm63TOi0o+e6aSsI9eBL
 nf43Wleb44Yce/mqW6WtOHZD6VI8jiagIi9ou6uyxmRiStmZrwQmI607GonE+Rub6yYDd
 oQYn6Db4LbnHXaxg/U3U/R/6P+OWxMdmlbq3vokyCoQk7xfq5W5dZ/OeohSUnB0EU2AgV
 VO81hfHSYan/mqYA4nZYs7qSATkQ9MH7/A+OdViPWLrpEYkNVQfHTlp5XoVWAtpe0m4Bg
 A0kfA2XJ3qbd61aT48fvqLg/SSpjyEaH4oX3SVCOqAm34k8NMvEn79yBIkgAyJhL7Qw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b="gVdie+/g"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=gVdie+/g
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 89FCF80D30
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 03:57:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793764605; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ciyRejo+wxCGd+jd7aNVKAu19sZOloO6+xMUEzGKjLUNw5wzq3cEiALTpcziepK6+Zqa0Yfevwr1PEiJDn2M/d6+r1rbUw1A1NWcQigpia2LxmgSRXfv38pEJ/cr08GPxJf0UblGFe3LKEn4R2nfFhohyQjtD5GOQiEZ2GbaRwQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793764605;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=KG076o9TNl2hMAEFUu34ZSmDRE9DCApKZ8ewgiuIoCw=; 
 b=bvLG/BD9eoNqZEeZhm9gKw/9rNMIsnnxG+SODUQVztV3XH6qF4tMpAgPsjyG+uF6LEopAXaQ0Abpa54SpqxH5EX2W4yKw8kKpeKzfvapMLhqLfzFgV2Wuxiixfa3rZQGCLbm4YPcBCkMwxLOF7lSzO/S8A/Fo8YzBUHPEckfmwg=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: a=rsa-sha256;
 b=gVdie+/g9qbq4KP/9oZ5DwhBH6l/T553lr0NRl/tKO48g37XZEr4FJxR/APTC/l1Hq4umPJ1xNfar62DkfwKs5gmzGf8HXTwAP4MD7ciNNnN7MtoZvl0WI7rJ7YxcX+4w4E+geL4kv7tcf8Fz63dELTFGHITm+F/PYFEEozYupY=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=KG076o9TNl2hMAEFUu34ZSmDRE9DCApKZ8ewgiuIoCw=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 179376460434524.262489550976625; 
 Tue, 3 Nov 2026 19:56:44 -0800 (PST)
Date: Wed, 4 Nov 2026 03:56:32 +0000
From: Yao Zi <me@ziyao.cc>
To: Hiago De Franco <hfranco@baylibre.com>, u-boot@lists.u-boot-project.org,
 Yao Zi <me@ziyao.cc>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Marek Vasut <marex@nabladev.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Bin Liu <b-liu@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Andrei Lalaev <andrey.lalaev@gmail.com>,
 Zhuxu Ran <zhuxu_ran@zohomail.com>, Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH 4/8] board: sophgo: milkv_duo: add SPL support
Message-ID: <auqs8BSPdzT2N9dL@pie>
References: <20261021-milkv-duo-spl-v1-0-ee7618860237@baylibre.com>
 <20261021-milkv-duo-spl-v1-4-ee7618860237@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021-milkv-duo-spl-v1-4-ee7618860237@baylibre.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/293.744.82
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 09:54:20AM -0300, Hiago De Franco wrote:
> Wire up SPL for the Milk-V Duo so it no longer depends on the vendor
> FSBL.
> 
> The SPL uses the BootROM ROMAPI to load the FIT image with OpenSBI,
> U-Boot and the device tree, from offset 0x40000 of fip.bin.
> 
> The BootROM loads the SPL into the 100 KiB VC SRAM at 0x3bc00000 and
> jumps past the 32-byte BL2 header, so SPL_TEXT_BASE is 0x3bc00020.
> SPL_MAX_SIZE (0x13fe0) is exactly SPL_BSS_START_ADDR (0x3bc14000) minus
> SPL_TEXT_BASE, so the SPL image cannot grow into its own BSS.
> SPL_BSS_MAX_SIZE (0x1000) caps that 4 KiB BSS, ending at 0x3bc15000, and
> SPL_STACK (0x3bc19000) is the end of the SRAM, leaving 16 KiB below it
> for the stack, the pre-relocation malloc_f pool (SPL_SYS_MALLOC_F_LEN, 8
> KiB) and the global data, as the generic SPL board_init_f flow expects.

Thanks for the helpful explanation, I think it would be better to add
some documentation for the SoC bootflow.

> In DRAM, SPL_OPENSBI_LOAD_ADDR (0x80000000) is the base of RAM: the
> fixed link address OpenSBI's "generic" platform uses for fw_dynamic, and
> the load address given to it in the FIT. SPL_CUSTOM_SYS_MALLOC_ADDR
> (0x81000000) moves the SPL heap into DRAM once it is up, 16 MiB in,
> clear of SYS_LOAD_ADDR (0x80080000), U-Boot's default load address, and
> of TEXT_BASE (0x80200000).
> 
> SPL_SMP is disabled, as only one hart is brought up, and
> SPL_OPENSBI_SCRATCH_OPTIONS is cleared so that OpenSBI prints its boot
> banner, which the default (SBI_SCRATCH_NO_BOOT_PRINTS) hides.

Should we avoid this to keep aligned with other RISC-V boards? The
banner, IMHO, is only meaningful for debugging purpose.

> Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
> ---
>  arch/riscv/dts/cv1800b-milkv-duo-u-boot.dtsi  | 92 +++++++++++++++++++++++++++
>  arch/riscv/include/asm/arch-cv1800b/rom_api.h | 36 +++++++++++
>  board/sophgo/milkv_duo/Kconfig                |  5 ++
>  board/sophgo/milkv_duo/MAINTAINERS            |  5 +-
>  board/sophgo/milkv_duo/Makefile               |  1 +
>  board/sophgo/milkv_duo/spl.c                  | 76 ++++++++++++++++++++++
>  configs/milkv_duo_defconfig                   | 18 ++++++
>  7 files changed, 232 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/dts/cv1800b-milkv-duo-u-boot.dtsi b/arch/riscv/dts/cv1800b-milkv-duo-u-boot.dtsi
> new file mode 100644
> index 00000000000..7f9a7a03c5d
> --- /dev/null
> +++ b/arch/riscv/dts/cv1800b-milkv-duo-u-boot.dtsi
> @@ -0,0 +1,92 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (c) 2026, Hiago De Franco <hfranco@baylibre.com>
> + */

...

> +&uart0 {
> +	bootph-pre-ram;
> +	clock-frequency = <25000000>;

The upstream UART 8250 binding disallows clocks and clock-frequency
to co-exist, and with current Linux drivers, it does cause issues, see
this series[1].

If you worry about the burden of introducing clock related stuff to SPL,
consider define CFG_SYS_NS16550_CLK in the board configuration header
instead.

...

Best regards,
Yao Zi

[1]: https://lore.kernel.org/all/20250623093445.62327-1-ziyao@disroot.org/
