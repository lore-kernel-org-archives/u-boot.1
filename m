Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D657606A324
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 11:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jupBTyTr;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=F6Ocb5bu
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3437640A6D;
	Thu, 19 Nov 2026 11:15:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ebi52sUsXS71; Thu, 19 Nov 2026 11:15:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0A6C640A9C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795086936;
	b=JFnEGLTCOF4oMThHVvBQ0qmeNo47WoBDDcnJPYk/q9XWACYChdjZB/kRvhMdMwI2Op9P
	 4wZwNMjbJ/dh3DusW8KoUsa3Nubsqu2zrBAyJVYDqCNBiaRfBoR00hC9tqXJwwBVI60w2
	 BigTeVGJ8Gtg/yu3YbHJg1e/AUcTQxn//6QqCzYeIlKcTCioEh72o2qW627yxQK9UqZuz
	 YBS9YnOQE64/M5F2NZh85kyv0LiquHcTf7Hc5yJzu3zenXQRQaSNXgutwyQr5KDxp/CSY
	 AFzGeywWgY/VyRgvHjGJH7S1TT1WNBuuP+u66A82tD4RJIGkqdoXfEOCwLIuYlo7d3Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795086936;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XvOrc3HljnUI0Q8t848mySIFiYu4lmJvQZtNiFuQWL4=;
	b=eg5SsQkFpuW1Jofx2C+Gso/FbQ1pXedC72/QuyMp9ChEkpraKREixOSeptv/xKkqg4r1
	 7KtaTT8jKCKzgTuQH53aoW9Hoede8sOkax82pZuKqA0am/DYobWm+1G6no7ef15/4IBK+
	 +8Y22lgGhS+2WZXdR1tRPzTePCdPs41niGyHTEDdxqJiIa9aEkRCblDOyGJ9cKf3nIbez
	 oWUhjeDqVghdu2rA8bxDp3HrAp1UpfsIOKEGS21rHGLKZytwh02Lmtut2BxDFX0cLKzPI
	 BrYrQcDN5XWodOvUjVe7NdGdsZ0HwwNZDhEDIoCRQvTF6M3Djo18DcBQVTRJm6gi5dw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795086936;
	bh=XvOrc3HljnUI0Q8t848mySIFiYu4lmJvQZtNiFuQWL4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jupBTyTrvswxf2TU41eK6hsYQcVtNszWH7BmCi9RWKm67ZQAqRYJLfY0q8MXR/BdB
	 akRP+BX+YJPcBAjKFOQzdDHgK/eu5lNnGzFoSRFPCtmWZ9VHXhrhhsWLJrHXN1vQSd
	 a3UyJ9Z1OOxXaSnIh9CpBQkjoia4rGy3lpv947tmTFRNRkNh/glxjhEIYAY3HWIhXI
	 n7ekU4LoHU7CJhyo4qfA/+zg2jIiKaCb9dV5cqX5hTMNpUfTOtthLDoFdxxp5F4z/h
	 MmKtCZZsDUSfAbq/EE1NrBS6OAw58uNA4n08VtQhkYAxUD+ZlL4yXrr8heEy8BHpLL
	 kJX0JIrpgymjA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A6C640A9C;
	Thu, 19 Nov 2026 11:15:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 887501C9
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 11:15:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6F00F81328
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 11:15:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LxEMjas1Rdd4 for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 11:15:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4E5648131A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=F6Ocb5bu
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4E5648131A
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 11:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1795086902;
 bh=XvOrc3HljnUI0Q8t848mySIFiYu4lmJvQZtNiFuQWL4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=F6Ocb5buVJS/8Pv374fkQYPF/7ey7kDPAuxr33h1IvhRFWglzfbxFx+3c/UJ+fJtQ
 pNv91+1uxio8TmHzdDMSwy7Wa9dkygeZIXBu9s8PYSEHHhya0HB2waa92WoQb+8FPo
 0fRSlLHCfQMoMtYysoAkbF5gbbeOXAnLroG5fL6CEMFJvCtvx498CwaN9k4RBVhuRl
 XFgoOtbVS5kyFguobGziEedn8xmPPwQDzu41SJQNIKwnOM5FC9tJKUEdVDf94f395y
 jLAwA/D7/4QiiEqORcqB+ozu0Ei2Inj0XhFBT7Lvqx0RACZASReu739epp71oo3PSJ
 yV8i9TUgUoFrg==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id A5A9DB22097D;
 Thu, 19 Nov 2026 12:14:59 +0100 (CET)
Message-ID: <35001dcd-3fec-48a9-8b1f-e2cc68c644b8@freeshell.de>
Date: Thu, 19 Nov 2026 03:14:57 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] riscv: Document SBI firmware support in SPL
To: Zhouqi Jiang <luojia@rustsbi.com>, u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, tim609@andestech.com, leo.liang@sifive.com,
 me@ziyao.cc, sjg@chromium.org, alpernebiyasak@gmail.com,
 jiangzhouqi2025@iscas.ac.cn, plucky@rustsbi.com,
 Chao Liu <chao.liu@processmission.com>, Daniel Maslowski <info@orangecms.org>
References: <2744044E69DD25E5+20261115143808.1812787-1-luojia@rustsbi.com>
 <20261119091842.3062208-1-luojia@rustsbi.com>
 <356792A791E175F1+20261119091842.3062208-4-luojia@rustsbi.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <356792A791E175F1+20261119091842.3062208-4-luojia@rustsbi.com>
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
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Zhougi,

On 11/19/26 01:18, Zhouqi Jiang wrote:
> Document how to supply OpenSBI and RustSBI Prototyper dynamic
> firmware to the existing SPL handoff. Explain the firmware load
> address, the FIT OS label, and how each implementation handles
> SPL_OPENSBI_SCRATCH_OPTIONS.
> 
> Mention RustSBI compatibility in the SPL Kconfig help so users can
> find it when configuring U-Boot.
> 
> Signed-off-by: Zhouqi Jiang <luojia@rustsbi.com>
> ---
> Changes in v2:
> - Document the shared handoff in the RISC-V architecture guide.
> - Explain scratch options in the architecture guide and SPL help.
> 
>  common/spl/Kconfig |  8 +++++++-
>  doc/arch/riscv.rst | 17 +++++++++++++++++
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 4930ecb0861..07548094e38 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -1744,7 +1744,10 @@ config SPL_OPENSBI
>  	  Interface (SBI) specification. U-Boot supports the OpenSBI FW_DYNAMIC
>  	  firmware. It is loaded and started by U-Boot SPL.
>  
> -	  More details are available at https://github.com/riscv/opensbi and
> +	  RustSBI Prototyper dynamic firmware also supports this handoff.

How is 'RustSBI Prototyper' distinct from 'RustSBI'. Is this a
registered trademark? Is it a company name?

It should be enough to simply introduce that SBI implementations can be
passed to the build process with OPENSBI= and then to list (in 'LANG=C
sort' order) or link to specific build instructions for the available
implementations where different from OpenSBI.

> +
> +	  More details are available at https://github.com/riscv/opensbi,
the trailing comma at the end of URL here is problematic since it is a
valid component of any URI

> +	  https://github.com/rustsbi/rustsbi and
>  	  https://github.com/riscv/riscv-sbi-doc
>  
>  config SPL_OPENSBI_LOAD_ADDR
> @@ -1763,6 +1766,9 @@ config SPL_OPENSBI_SCRATCH_OPTIONS
>  	  - SBI_SCRATCH_NO_BOOT_PRINTS = 0x1 (Disable prints during boot)
>  	  - SBI_SCRATCH_DEBUG_PRINTS   = 0x2 (Enable runtime debug prints)
>  
> +	  RustSBI Prototyper currently does not use these options. See the
> +	  RISC-V architecture documentation for details.
> +

What does the RISC-V architecture documentation have to say about
'RustSBI Prototyper' lacking support for OpenSBI scratch options. This
sounds like four unrelated topics in one sentence.

>  config SPL_TARGET
>  	string "Addtional build targets for 'make'"
>  	default "spl/u-boot-spl.srec" if RCAR_GEN2
> diff --git a/doc/arch/riscv.rst b/doc/arch/riscv.rst
> index af0c48b8982..dc4cc853baa 100644
> --- a/doc/arch/riscv.rst
> +++ b/doc/arch/riscv.rst
> @@ -72,6 +72,23 @@ To examine the boot process with the QEMU virt machine, you can follow the
>  steps in the "Running U-Boot SPL" section of the following document:
>  :doc:`../board/emulation/qemu-riscv`.
>  
> +SBI firmware for SPL
> +--------------------
> +
> +With ``CONFIG_SPL_OPENSBI``, SPL passes FW_DYNAMIC handoff information to
> +the firmware loaded from the FIT image. Supported implementations include:

U-Boot main app build for SpacemiT K3 packages OpenSBI fw_dynamic.bin
and so I'm not understanding this explanation you have provided.

$ ls build/opensbi/platform/generic/firmware/fw_*bin
build/opensbi/platform/generic/firmware/fw_dynamic.bin
build/opensbi/platform/generic/firmware/fw_jump.bin
build/opensbi/platform/generic/firmware/fw_payload.bin

At some point in OpenSBI development, if I remember correctly v1.5 tag
or so, fw_dynamic.bin transitioned to be built fully dynamic /
relocatable. Previous to then it required the .text section address
specified at build time.

> +
> +* `OpenSBI FW_DYNAMIC <https://github.com/riscv-software-src/opensbi>`_.
> +* `RustSBI Prototyper dynamic firmware <https://github.com/rustsbi/rustsbi/tree/main/firmware>`_.
> +
> +Provide the firmware using either ``OPENSBI=/path/to/firmware.bin`` or
> +``RUSTSBI=/path/to/firmware.bin``. Its link address must match
> +``CONFIG_SPL_OPENSBI_LOAD_ADDR``. Both use the ``opensbi`` FIT OS label.
> +
> +``CONFIG_SPL_OPENSBI_SCRATCH_OPTIONS`` passes options to the firmware. OpenSBI
> +uses ``0x1`` to disable boot prints and ``0x2`` for runtime debug prints;

It could be 0x3 for both options?

> +RustSBI Prototyper currently ignores these options.
> +

Is that a bug? Why mention this, here?

>  Toolchain
>  ---------
>  

-E
