Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68935606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 12:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tZCy6YYs;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=ep9Zjxuj
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3110C80D9D;
	Mon, 16 Nov 2026 12:48:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6l4Pn0E5kBzh; Mon, 16 Nov 2026 12:48:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2E33280C74
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794833299;
	b=C1y0rNL1FsopiNcBQxvu5v8EfrdoyQOfe9AsiJLJzfNxNTGk7B7L9bASgLRLNIotX9vx
	 auBLt7PdMMeDlwXrPhsP3DgBCAaaZvgSnEERtnXMoIEJAC4ajW48ytriyv3K6IQGIIN+X
	 +AcAdfSqW6tuHzWilKAgktCJmemzEfFYWVSiyHnZArYMtjPQxDz8CNToypKYd/7fDfdkm
	 xc+/mg9oUTga0M1ZhIjYwRbrJonV8DjXL53UMTFxmqelncEZz0T3iUPmoBMgHLHjuHqaM
	 hb6DVbVo0JEiKiiLQFvN8FCts+kiN3fiwAJaUEAdOuMa4EpKiqpX80uxO3TSClGXieQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794833299;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+5kkqIrhwKoKZuRnvHJNGJaWTJamnbqfqfkwPdTaBCE=;
	b=eqijq2jD3Dq61sLf51qBav6q6Jd9hBy5To/lkY/E/aXDZjDNVHpUpfH4sVgmwQ0CELJG
	 jGbGL8hlx2egm0u81jcKEL4uMPoTd62vem/gcp1UOJTp1rTI97UqeW7/TDD0h1dkbQyWE
	 Ev7vMycadz9UD949uOAvKjFfd7Mhywui5cGHT6kBd+WshYqY+myueiqLeQt4pNEBd7gYu
	 GBlZEOj9JbUSiE2svnoE5Ay0Tq4TB5ayuv0y6a9eNnUjbSqZyTAPdW0mfjUxO+mf/AGDU
	 C2fi0nP5bpmVqmtYRvzSumOJHWgdxhqe9WiUTxGOxrEVLjHrkLirKoFLC7c+99D1lkw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794833299;
	bh=+5kkqIrhwKoKZuRnvHJNGJaWTJamnbqfqfkwPdTaBCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tZCy6YYszdLTV84XzNMcnXLzUXAGERv61ME4XbRVWKLhdjkvjob9hZM///jBmAUhZ
	 pTcxtLsRIPYsMcAyMiX3wTikUV5URt/uDp5Xkkz/4LpaQAcQYxjeomw4sRHtObYDhV
	 uAP331GnxU1ZjZ77HHsvhpL21IkwS7MfJR8IGHp1TtqyhSObAik8w8gw/gJ7/wQJX6
	 PRy0T7RanLw/9pnH3Oi8csUmELJkQSamEC62oHJ5y0rNHxCiz7Kbvi1hV3PsAd7yVw
	 hgq6RvxO2LcuSbLuhZ3gnn4EUd0//DzatAGHCt7tBkTq6CCl0aYhyNfrK3c1DSWHbx
	 jhE00q1kiMbKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2E33280C74;
	Mon, 16 Nov 2026 12:48:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 94B941E7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 12:48:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7ADEE4009D
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 12:48:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rpjNFLDPNH8M for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 12:48:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 669ED40068
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=ep9Zjxuj
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 669ED40068
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 12:48:14 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=ep9Zjxuj+i3PGMDyfrkTXLRDTvsEDA0pUlSZ2lrfFvcXKQCr24xMkU5vcPpb3Xry5Ueeo5DGhLo120TFj5JC3dLGRKNCMzUIZ2Ja5X/W4efprJuG+cBPmOvLmWYZq+/GdJEJPhRLngtt2Di9SawU0KD2bHMkOJ+aaap8Nsy7oeE=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=+5kkqIrhwKoKZuRnvHJNGJaWTJamnbqfqfkwPdTaBCE=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794833144360669.713116839423;
 Mon, 16 Nov 2026 04:45:44 -0800 (PST)
Date: Mon, 16 Nov 2026 12:45:36 +0000
From: Yao Zi <me@ziyao.cc>
To: Zhouqi Jiang <luojia@rustsbi.com>, u-boot@lists.u-boot-project.org
Cc: tim609@andestech.com, leo.liang@sifive.com, me@ziyao.cc,
 sjg@chromium.org, alpernebiyasak@gmail.com, trini@konsulko.com
Subject: Re: [PATCH] riscv: Add RustSBI firmware support
Message-ID: <avr68Io04mE4YFs-@pie>
References: <2744044E69DD25E5+20261115143808.1812787-1-luojia@rustsbi.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2744044E69DD25E5+20261115143808.1812787-1-luojia@rustsbi.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.637.76
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 15, 2026 at 10:38:08PM +0800, Zhouqi Jiang wrote:
> RustSBI is a security-focused, open-source RISC-V SBI implementation
> written in Rust. It is listed in the SBI specification with
> implementation ID 4.
> 
> Add RustSBI support to U-Boot:
> - Add SPL firmware selection and dynamic handoff.
> - Add the RustSBI FIT image type and RUSTSBI binman input.
> - Update RISC-V FIT templates, documentation and tests.
> 
> Ref: https://docs.riscv.org/reference/sbi/_attachments/riscv-sbi.pdf
> Signed-off-by: Zhouqi Jiang <luojia@rustsbi.com>
> ---
>  MAINTAINERS                             |  1 +
>  Makefile                                |  1 +
>  arch/riscv/Kconfig                      | 10 +++----
>  arch/riscv/dts/binman.dtsi              | 23 ++++++++++++++-
>  arch/riscv/dts/thead-th1520-binman.dtsi | 24 ++++++++++++++++
>  boot/image.c                            |  1 +
>  common/spl/Kconfig                      | 37 +++++++++++++++++++------
>  common/spl/Makefile                     |  1 +
>  common/spl/spl.c                        |  3 ++
>  common/spl/spl_fit.c                    |  3 +-
>  common/spl/spl_rustsbi.c                | 13 +++++++++
>  doc/board/emulation/qemu-riscv.rst      |  9 ++++++
>  include/image.h                         |  1 +
>  include/spl.h                           |  5 ++++
>  tools/binman/etype/rustsbi.py           | 18 ++++++++++++
>  tools/binman/ftest.py                   | 16 +++++++++++
>  tools/binman/missing-blob-help          |  4 +++
>  tools/binman/test/fip/rustsbi.dts       | 11 ++++++++

These changes should be defnitely split into separate commits, since
they're related to too many different components (riscv, boot flow,
spl loaders, binman, and doc).

>  18 files changed, 165 insertions(+), 16 deletions(-)
>  create mode 100644 common/spl/spl_rustsbi.c
>  create mode 100644 tools/binman/etype/rustsbi.py
>  create mode 100644 tools/binman/test/fip/rustsbi.dts

[...]

> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 386241efd4a..4bd562437cb 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -476,8 +476,7 @@ config SBI_V02
>  	  single hart needs to boot and enter the operating system. The booting
>  	  hart can bring up secondary harts one by one afterwards.
>  
> -	  Choose this option if OpenSBI release v0.7 or above is used together
> -	  with U-Boot.
> +	  Choose this option if the SBI firmware implements SBI v0.2 or later.

This change itself looks like a good clean-up, and could be accepted
independently with RustSBI support. Please split it into a separate
commit.

[...]

> diff --git a/doc/board/emulation/qemu-riscv.rst b/doc/board/emulation/qemu-riscv.rst
> index a76a1a8bf75..1be2f53f54e 100644
> --- a/doc/board/emulation/qemu-riscv.rst
> +++ b/doc/board/emulation/qemu-riscv.rst
> @@ -124,6 +124,15 @@ with the following commands.
>      make qemu-riscv64_spl_defconfig
>      make
>  
> +To use RustSBI firmware, build RustSBI Prototyper in dynamic mode for the
> +target with the SPL firmware load address. See https://github.com/rustsbi/rustsbi
> +for details. Set RUSTSBI to the firmware binary and build U-Boot::
> +
> +    make qemu-riscv32_spl_defconfig  # Or qemu-riscv64_spl_defconfig
> +    scripts/config --disable SPL_OPENSBI --enable SPL_RUSTSBI
> +    make olddefconfig
> +    make RUSTSBI=/path/to/rustsbi-prototyper-dynamic.bin
> +
>  The minimal QEMU commands to run U-Boot SPL in both 32-bit and 64-bit
>  configurations are:

We should probably not cover every possible SBI implementations in a
board-specific documentation. A better option might be explaining the
support status of different SBI implementations in RISC-V-specific
doc doc/arch/riscv.rst, and keep all the board-level ones as-is.

[...]

-- 
Thanks,
Yao Zi

Meow-mrrp-mrow, I'm a cat.
