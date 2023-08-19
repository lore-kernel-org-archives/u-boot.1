Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC136EE4993
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 11:04:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5598980842;
	Sat, 19 Aug 2023 13:04:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=arvanta.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AD7A833DE; Sat, 19 Aug 2023 13:04:12 +0200 (CEST)
Received: from fx.arvanta.net (unknown [109.72.52.77])
 by phobos.denx.de (Postfix) with ESMTP id 0579B8082D
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 13:04:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=arvanta.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=mps@arvanta.net
Received: from m1 (ab.arvanta.net [10.5.1.5])
 by fx.arvanta.net (Postfix) with ESMTP id C92EC7396;
 Sat, 19 Aug 2023 13:04:08 +0200 (CEST)
Date: Sat, 19 Aug 2023 13:04:07 +0200
From: Milan =?utf-8?Q?P=2E_Stani=C4=87?= <mps@arvanta.net>
To: Chanho Park <chanho61.park@samsung.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/2] riscv: cpu: make riscv_cpu_probe to
 EVT_DM_POST_INIT_R callback
Message-ID: <20230819110407.GD3096@m1>
References: <20230818051103.2427590-1-chanho61.park@samsung.com>
 <CGME20230818052645epcas2p3df52c8522cd903f869d366fed46ea89d@epcas2p3.samsung.com>
 <20230818051103.2427590-3-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230818051103.2427590-3-chanho61.park@samsung.com>
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

It works.

On Fri, 2023-08-18 at 14:11, Chanho Park wrote:
> Since the Patch 55171aedda88, VisionFive2 booting has been broken [1].
> VisionFive2 board requires to enable CONFIG_TIMER_EARLY but booting went
> to panic from initr_dm_devices due to lack of a timer device.
> 
> - Error logs
> initcall sequence 00000000fffd8d38 failed at call 00000000402185e4
> (err=-19)
> 
> Thus, we need to move riscv_cpu_probe function in order to register
> the timer earlier than initr_dm_devices.
> 
> Fixes: 7fe32b3442f0 ("event: Convert arch_cpu_init_dm() to use events")
> Cc: Simon Glass <sjg at chromium.org>
> Cc: Bin Meng <bmeng.cn at gmail.com>
> Signed-off-by: Chanho Park <chanho61.park at samsung.com>
Tested-by: Milan P. Stanić <mps@arvanta.net>

> ---
>  arch/riscv/cpu/cpu.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/riscv/cpu/cpu.c b/arch/riscv/cpu/cpu.c
> index ecfb1fb08c4b..0b4208e72199 100644
> --- a/arch/riscv/cpu/cpu.c
> +++ b/arch/riscv/cpu/cpu.c
> @@ -66,7 +66,7 @@ static inline bool supports_extension(char ext)
>  #endif /* CONFIG_CPU */
>  }
>  
> -static int riscv_cpu_probe(void)
> +static int riscv_cpu_probe(void *ctx, struct event *event)
>  {
>  #ifdef CONFIG_CPU
>  	int ret;
> @@ -79,6 +79,7 @@ static int riscv_cpu_probe(void)
>  
>  	return 0;
>  }
> +EVENT_SPY(EVT_DM_POST_INIT_R, riscv_cpu_probe);
>  
>  /*
>   * This is called on secondary harts just after the IPI is init'd. Currently
> @@ -95,7 +96,7 @@ int riscv_cpu_setup(void *ctx, struct event *event)
>  {
>  	int ret;
>  
> -	ret = riscv_cpu_probe();
> +	ret = riscv_cpu_probe(ctx, event);
>  	if (ret)
>  		return ret;
>  
> @@ -149,12 +150,6 @@ EVENT_SPY(EVT_DM_POST_INIT_F, riscv_cpu_setup);
>  
>  int arch_early_init_r(void)
>  {
> -	int ret;
> -
> -	ret = riscv_cpu_probe();
> -	if (ret)
> -		return ret;
> -
>  	if (IS_ENABLED(CONFIG_SYSRESET_SBI))
>  		device_bind_driver(gd->dm_root, "sbi-sysreset",
>  				   "sbi-sysreset", NULL);
> -- 
> 2.39.2
> 
