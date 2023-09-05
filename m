Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4708DCA0FE2
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 17:21:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FBC38658D;
	Tue,  5 Sep 2023 19:20:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=arvanta.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2F5186595; Tue,  5 Sep 2023 19:20:57 +0200 (CEST)
Received: from fx.arvanta.net (unknown [109.72.52.77])
 by phobos.denx.de (Postfix) with ESMTP id 1E0E586582
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 19:20:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=arvanta.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=mps@arvanta.net
Received: from m1 (m1pro.arvanta.net [10.5.1.5])
 by fx.arvanta.net (Postfix) with ESMTP id 158CD7FF6;
 Tue,  5 Sep 2023 19:20:54 +0200 (CEST)
Date: Tue, 5 Sep 2023 19:20:54 +0200
From: Milan =?utf-8?Q?P=2E_Stani=C4=87?= <mps@arvanta.net>
To: Tom Rini <triniatkonsulko.com@m1>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] riscv: Correct event usage for riscv_cpu_probe/setup
Message-ID: <20230905172054.GB29543@m1>
References: <20230904190635.3896494-1-trini@konsulko.com>
 <20230904190635.3896494-2-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230904190635.3896494-2-trini@konsulko.com>
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
> With having both an EVENT_SPY_SIMPLE setup for both riscv_cpu_probe and
> riscv_cpu_setup we do not need the latter function to call the former
> function as it will already have been done in time.
> 
> Fixes: 1c55d62fb9cc ("riscv: cpu: make riscv_cpu_probe to EVT_DM_POST_INIT_R callback")
> Signed-off-by: Tom Rini <trini at konsulko.com>
Tested-by: Milan P. Stanić <mps@arvanta.net>

> ---
> Cc: Rick Chen <rick at andestech.com>
> Cc: Leo Yu-Chi Liang  <ycliang at andestech.com>
> Cc: Simon Glass <sjg at chromium.org>
> Cc: Nikita Shubin <n.shubin at yadro.com>
> Cc: Chanho Park <chanho61.park at samsung.com>
> Cc: Yu Chien Peter Lin <peterlin at andestech.com>
> ---
>  arch/riscv/cpu/cpu.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/arch/riscv/cpu/cpu.c b/arch/riscv/cpu/cpu.c
> index cfe9fdc9df55..c1a9638c1ab7 100644
> --- a/arch/riscv/cpu/cpu.c
> +++ b/arch/riscv/cpu/cpu.c
> @@ -94,11 +94,7 @@ static void dummy_pending_ipi_clear(ulong hart, ulong arg0, ulong arg1)
>  
>  int riscv_cpu_setup(void)
>  {
> -	int ret;
> -
> -	ret = riscv_cpu_probe(ctx, event);
> -	if (ret)
> -		return ret;
> +	int __maybe_unused ret;
>  
>  	/* Enable FPU */
>  	if (supports_extension('d') || supports_extension('f')) {
> -- 
> 2.34.1
> 
