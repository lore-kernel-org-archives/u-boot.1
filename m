Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E95FC83F3E
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 17:17:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01D378658D;
	Tue,  5 Sep 2023 19:17:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=arvanta.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 254C4865DA; Tue,  5 Sep 2023 19:17:48 +0200 (CEST)
Received: from fx.arvanta.net (unknown [109.72.52.77])
 by phobos.denx.de (Postfix) with ESMTP id 96144864DD
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 19:17:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=arvanta.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=mps@arvanta.net
Received: from m1 (m1pro.arvanta.net [10.5.1.5])
 by fx.arvanta.net (Postfix) with ESMTP id 9BB1A7FF3;
 Tue,  5 Sep 2023 19:17:44 +0200 (CEST)
Date: Tue, 5 Sep 2023 19:17:44 +0200
From: Milan =?utf-8?Q?P=2E_Stani=C4=87?= <mps@arvanta.net>
To: Tom Rini <triniatkonsulko.com@m1>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] riscv: Rework riscv_cpu_probe for current event macros
Message-ID: <20230905171744.GA29543@m1>
References: <20230904190635.3896494-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230904190635.3896494-1-trini@konsulko.com>
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

On Mon, 2023-09-04 at 15:06, Tom Rini wrote:
> This function should now be a EVENT_SPY_SIMPLE call, update it.
> 
> Signed-off-by: Tom Rini <trini at konsulko.com>
Tested-by: Milan P. Stanić <mps@arvanta.net>

> ---
>  arch/riscv/cpu/cpu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/cpu/cpu.c b/arch/riscv/cpu/cpu.c
> index d64aa330f206..cfe9fdc9df55 100644
> --- a/arch/riscv/cpu/cpu.c
> +++ b/arch/riscv/cpu/cpu.c
> @@ -66,7 +66,7 @@ static inline bool supports_extension(char ext)
>  #endif /* CONFIG_CPU */
>  }
>  
> -static int riscv_cpu_probe(void *ctx, struct event *event)
> +static int riscv_cpu_probe(void)
>  {
>  #ifdef CONFIG_CPU
>  	int ret;
> @@ -79,7 +79,7 @@ static int riscv_cpu_probe(void *ctx, struct event *event)
>  
>  	return 0;
>  }
> -EVENT_SPY(EVT_DM_POST_INIT_R, riscv_cpu_probe);
> +EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_R, riscv_cpu_probe);
>  
>  /*
>   * This is called on secondary harts just after the IPI is init'd. Currently
> -- 
> 2.34.1
> 
