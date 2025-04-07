Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CA6C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 11:11:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38A4982D39;
	Mon,  7 Apr 2025 13:10:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="tUtpC303";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1976682DB0; Mon,  7 Apr 2025 13:10:58 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7124182CEA
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 13:10:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=13a0=WZ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: Cc:
 References: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1744024254;
 bh=Edg3voBgUC7Nk8s8jvADxBgl6cR4REGVRf/GLLTeygg=;
 b=tUtpC303kZ0RSwOiugzydmZw3wVELH5sZFnnaWe+QCCn2ZZmB9DZAQV30xazYxYFFHP8y49n+
 m2eibgp3sn9O3NXMApuEGxQcshuTnnsCYNExBcbzPnZaE173NU9Gb1QBg0mWDAUU7lb+CMKU8Ri
 w96gvTbJnuh9hENmMJglQ2aaAT8imgVwM/OMs3sq7zHzllGPc2nAqAJ3a0j2stx5Ms1wahLfR6U
 g22iSbjyBAwDMmtmoXJuqIy/LM2KPYt0DBr9yURYOWkg8SS6Py9ydS+m7TWT5pk6bYM2YNWZTzR
 9fYgZQ+N7SXIdkzubgOjLES0gKkxgYbSYwT7ZWQE1cjw==
X-Forward-Email-ID: 67f3b2af454af5417a2dfb50
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <765a4f82-d0c8-43a3-beb3-31e133fd4811@kwiboo.se>
Date: Mon, 7 Apr 2025 13:10:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] riscv: Provide __image_copy_{start_end} symbols in
 linkerscript
To: Yao Zi <ziyao@disroot.org>
References: <20250407033744.4025-1-ziyao@disroot.org>
 <20250407033744.4025-3-ziyao@disroot.org>
Content-Language: en-US
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>, Trevor Woerner <twoerner@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marex@denx.de>,
 Paul Kocialkowski <contact@paulk.fr>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Lukas Funke <lukas.funke@weidmueller.com>,
 u-boot@lists.denx.de
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250407033744.4025-3-ziyao@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi,

On 2025-04-07 05:37, Yao Zi wrote:
> Binman looks for __image_copy_start to determine the base address of an
> entry if elf-base-sym isn't specified, which is missing in RISC-V port.
> This causes binman skips RISC-V SPL entries without filling addresses
> into its .binman_sym_table section.
> 
> This patch defines __image_copy_start in linkerscript of both SPL and
> proper U-Boot to ensure binman_sym functions correctly with the default
> binman.dtsi. The paired symbol, __image_copy_end, is introduced as well
> for completeness.
> 
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  arch/riscv/cpu/u-boot-spl.lds | 2 ++
>  arch/riscv/cpu/u-boot.lds     | 3 +++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/arch/riscv/cpu/u-boot-spl.lds b/arch/riscv/cpu/u-boot-spl.lds
> index 907094620bd..18eb62c01c6 100644
> --- a/arch/riscv/cpu/u-boot-spl.lds
> +++ b/arch/riscv/cpu/u-boot-spl.lds
> @@ -16,6 +16,7 @@ ENTRY(_start)
>  SECTIONS
>  {
>  	. = ALIGN(4);
> +	__image_copy_start = ADDR(.text);
>  	.text : {
>  		arch/riscv/cpu/start.o	(.text)
>  		*(.text*)
> @@ -46,6 +47,7 @@ SECTIONS
>  
>  	_end = .;
>  	_image_binary_end = .;
> +	_image_copy_end = .;

This looks like a typo, should probably be with two _ ?

Regards,
Jonas

>  
>  	.bss : {
>  		__bss_start = .;
> diff --git a/arch/riscv/cpu/u-boot.lds b/arch/riscv/cpu/u-boot.lds
> index 2ffe6ba3c8f..b11ea8b56d2 100644
> --- a/arch/riscv/cpu/u-boot.lds
> +++ b/arch/riscv/cpu/u-boot.lds
> @@ -10,6 +10,7 @@ ENTRY(_start)
>  SECTIONS
>  {
>  	. = ALIGN(4);
> +	__image_copy_start = ADDR(.text);
>  	.text : {
>  		arch/riscv/cpu/start.o	(.text)
>  	}
> @@ -57,6 +58,8 @@ SECTIONS
>  		__efi_runtime_rel_stop = .;
>  	}
>  
> +	__image_copy_end = .;
> +
>  	/DISCARD/ : { *(.rela.plt*) }
>  	.rela.dyn : {
>  		__rel_dyn_start = .;

