Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 715B2C02198
	for <u-boot@archiver.kernel.org>; Fri, 14 Feb 2025 18:26:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B4A080805;
	Fri, 14 Feb 2025 19:26:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="CawQmK/E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4588A80B98; Fri, 14 Feb 2025 19:26:27 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB07480756
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 19:26:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 5FEE12529F;
 Fri, 14 Feb 2025 19:26:24 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0ju4fcObCy5J; Fri, 14 Feb 2025 19:26:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1739557580; bh=Zz5UzrHQ2N/bStWhN8RR4xjBZqcX1yFBrjFsponxqh4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=CawQmK/E+lH22INbfMuVwOgWWESLXz9vk/iPVPR9rjvRVdExQMpOMUECVRE0DqbS7
 GbRJMo5QEqTTNyxwH56aKWwQ27TLcy7ApdF0wHjHNr3lZMuMT5Uw/o9CEGTZ5HTrzU
 NucF+/agjlsT/3rp1Bc65A62A1QBwVOMF1fd5saoNmPRsBTZEsLfl8Tp2B8E4J3bEQ
 kwH+L1VU0witzPPzmTGTXgR+bQ1brpUfD3Swk+rjYIyqhE0GQTlm0Z54Eh/yS7/Hb+
 2lVEBiM7gAiE8QAJDo6GaY9PGIIr7mQlpcIKkJ7fzxNR2zoQwkknqNpRTWLZUinvYN
 jUBMSw1RF+qvw==
Date: Fri, 14 Feb 2025 18:25:59 +0000
From: Yao Zi <ziyao@disroot.org>
To: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Michal Simek <michal.simek@amd.com>
Subject: Re: [RFC PATCH 06/10] uthread: add cooperative multi-tasking interface
Message-ID: <Z6-KtxZxp2JfsSMP@pie.lan>
References: <20250214140031.484344-1-jerome.forissier@linaro.org>
 <20250214140031.484344-7-jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214140031.484344-7-jerome.forissier@linaro.org>
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

On Fri, Feb 14, 2025 at 03:00:21PM +0100, Jerome Forissier wrote:
> Add an new internal API called uthread (Kconfig symbol: UTHREAD) which
> provides cooperative multi-tasking. The goal is to be able to improve
> the performance of some parts of U-Boot by overlapping lengthy
> operations. Each uthread has its own stack allocated on the heap. The
> default stack size is defined by the UTHREAD_STACK_SIZE symbol and is
> used when uthread_create() is passed zero for the stack_sz argument.
> 
> The implementation is based on context-switching via initjmp()/setjmp()/
> longjmp() and is inspired from barebox threads [1].
> 
> [1] https://github.com/barebox/barebox/blob/master/common/bthread.c
> 
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  include/uthread.h |  31 ++++++++++++++
>  lib/Kconfig       |  19 ++++++++
>  lib/Makefile      |   2 +
>  lib/uthread.c     | 107 ++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 159 insertions(+)
>  create mode 100644 include/uthread.h
>  create mode 100644 lib/uthread.c
> 
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 1a683dea670..c3416bbd0be 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -1255,6 +1255,25 @@ config PHANDLE_CHECK_SEQ
>  	  enable this config option to distinguish them using
>  	  phandles in fdtdec_get_alias_seq() function.
>  
> +config UTHREAD
> +	bool "Enable thread support"
> +	depends on HAVE_INITJMP
> +	help
> +	  Implement a simple form of cooperative multi-tasking based on
> +	  context-switching via initjmp(), setjmp() and longjmp(). The
> +	  uthread_ interface enables the main thread of execution to create
> +	  one or more secondary threads and schedule them until they all have
> +	  returned. At any point a thread may suspend its execution and
> +	  schedule another thread, which allows for the efficient multiplexing
> +	  of leghthy operations.
> +
> +config UTHREAD_STACK_SIZE
> +	int "Default uthread stack size"
> +	depends on UTHREAD
> +	default 32168

Why choose 32168? It's even not a power of two. Typo for 32768?

> +	help
> +	  The default stask size for uthreads. Each uthread has its own stack.
> +
>  endmenu
>  
>  source "lib/fwu_updates/Kconfig"

Thanks,
Yao Zi
