Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 734DDC25B74
	for <u-boot@archiver.kernel.org>; Sat, 18 May 2024 07:34:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 774ED8865D;
	Sat, 18 May 2024 09:34:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1716017651;
	bh=ibZv6RUnA4L6i0Ekk2VPcFIzqKRcenpKcpDsuqUk6YU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WI8xzdXhaKLM85HOIxVVw6bywFh+UvtGcEnCdFWHXlXV2StqqElPEFxRkGjQQlJxP
	 sd1O6Xm2bvnOMibHPxS8ZIjuGaClHPD07k0ph2GOhhEuMgyud56LDntu8di/0UbiZM
	 /lN2JIHrKdTBO0GsLphTxPzafq+gMaS6ao1KHV1cxbNNKu3PDxSuDEOOPTnnMK47a8
	 Z6JVJV2dkE2DQgKYGThR5oA9usksyEC9V5Asf/RlYF0niGFvr9MNQ3cQrhCkzX14+l
	 w0VpPYWeaSQaq2W6lkXhc7iukWjrO6BIkjXcTEAlMdFfg/5YKiffKKtGQoUxX6XgVA
	 XdMUqIbIH5oOw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23C348865E; Sat, 18 May 2024 09:34:10 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5C328865C
 for <u-boot@lists.denx.de>; Sat, 18 May 2024 09:34:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4VhFvM3W7yz9sr1;
 Sat, 18 May 2024 09:34:07 +0200 (CEST)
Message-ID: <7f45eeed-4bcd-4a3a-9663-133a20c182f7@denx.de>
Date: Sat, 18 May 2024 09:34:04 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/3] cyclic: make clients embed a struct cyclic_info in
 their own data structure
Content-Language: en-US
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20240516075314.1548051-1-rasmus.villemoes@prevas.dk>
 <20240516075314.1548051-4-rasmus.villemoes@prevas.dk>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240516075314.1548051-4-rasmus.villemoes@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4VhFvM3W7yz9sr1
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

Hi Rasmus,

On 5/16/24 09:53, Rasmus Villemoes wrote:
> There are of course not a whole lot of examples in-tree yet, but
> before they appear, let's make this API change: Instead of separately
> allocating a 'struct cyclic_info', make the users embed such an
> instance in their own structure, and make the convention that the
> callback simply receives the 'struct cyclic_info *', from which the
> clients can get their own data using the container_of() macro.
> 
> This has a number of advantages.
> 
> First, it means cyclic_register() simply cannot fail, simplifying the
> code. The necessary storage will simply be allocated automatically
> when the client's own structure is allocated (often via
> uclass_priv_auto or similar).
> 
> Second, code for which CONFIG_CYCLIC is just an option can more easily
> be written without #ifdefs, if we just provide an empty struct
> cyclic_info {}. For example, the nested CONFIG_IS_ENABLED()s in
> https://lore.kernel.org/u-boot/20240316201416.211480-1-marek.vasut+renesas@mailbox.org/
> are mostly due to the existence of the 'struct cyclic_info *' member
> being guarded by #ifdef CONFIG_CYCLIC.
> 
> And we do probably want to avoid the extra memory overhead of that
> member when !CONFIG_CYCLIC. But that is automatic if, instead of a
> 'struct cyclic_info *', one simply embeds a 'struct cyclic_info',
> which will have size 0 when !CONFIG_CYCLIC. Also, the no-op
> cyclic_register() function can just unconditionally be called, and the
> compiler will see that (1) the callback is referenced, so not emit a
> warning for a maybe-unused function and (2) see that it can actually
> never be reached, so not emit any code for it.
> 
> Reviewed-by: Stefan Roese <sr@denx.de>
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>   board/Marvell/octeon_nic23/board.c |  9 +++++---
>   cmd/cyclic.c                       | 12 +++++------
>   common/cyclic.c                    | 22 +++++--------------
>   doc/develop/cyclic.rst             | 26 ++++++++++++++---------
>   drivers/watchdog/wdt-uclass.c      | 33 +++++++++++++----------------
>   include/cyclic.h                   | 34 +++++++++++++++---------------
>   6 files changed, 64 insertions(+), 72 deletions(-)

This introduces some problems when compiling e.g. sandbox:

In file included from test/common/cyclic.c:10:
test/common/cyclic.c: In function ‘dm_test_cyclic_running’:
test/common/cyclic.c:25:42: warning: passing argument 1 of 
‘cyclic_register’ from incompatible pointer type 
[-Wincompatible-pointer-types]
    25 |         ut_assertnonnull(cyclic_register(cyclic_test, 10 * 
1000, "cyclic_demo",
       |                                          ^~~~~~~~~~~
       |                                          |
       |                                          void (*)(void *)
include/test/ut.h:298:29: note: in definition of macro ‘ut_assertnonnull’
   298 |         const void *_val = (expr); 
         \
       |                             ^~~~
In file included from test/common/cyclic.c:6:
include/cyclic.h:58:42: note: expected ‘struct cyclic_info *’ but 
argument is of type ‘void (*)(void *)’
    58 | void cyclic_register(struct cyclic_info *cyclic, cyclic_func_t 
func,
       |                      ~~~~~~~~~~~~~~~~~~~~^~~~~~
test/common/cyclic.c:25:55: warning: passing argument 2 of 
‘cyclic_register’ makes pointer from integer without a cast 
[-Wint-conversion]
    25 |         ut_assertnonnull(cyclic_register(cyclic_test, 10 * 
1000, "cyclic_demo",
       |                                                       ^~~~~~~~~
       |                                                       |
       |                                                       int

Could you please also change the test file accordingly? I'll then
try to get this upstream shortly.

Many thanks in advance,
Stefan


> diff --git a/board/Marvell/octeon_nic23/board.c b/board/Marvell/octeon_nic23/board.c
> index bc9332cb74a..74b9c741b7b 100644
> --- a/board/Marvell/octeon_nic23/board.c
> +++ b/board/Marvell/octeon_nic23/board.c
> @@ -357,10 +357,13 @@ int board_late_init(void)
>   	board_configure_qlms();
>   
>   	/* Register cyclic function for PCIe FLR fixup */
> -	cyclic = cyclic_register(octeon_board_restore_pf, 100,
> -				 "pcie_flr_fix", NULL);
> -	if (!cyclic)
> +	cyclic = calloc(1, sizeof(*cyclic));
> +	if (cyclic) {
> +		cyclic_register(cyclic, octeon_board_restore_pf, 100,
> +				"pcie_flr_fix");
> +	} else {
>   		printf("Registering of cyclic function failed\n");
> +	}
>   
>   	return 0;
>   }
> diff --git a/cmd/cyclic.c b/cmd/cyclic.c
> index 40e966de9aa..339dd4a7bce 100644
> --- a/cmd/cyclic.c
> +++ b/cmd/cyclic.c
> @@ -15,14 +15,16 @@
>   #include <time.h>
>   #include <vsprintf.h>
>   #include <linux/delay.h>
> +#include <linux/kernel.h>
>   
>   struct cyclic_demo_info {
> +	struct cyclic_info cyclic;
>   	uint delay_us;
>   };
>   
> -static void cyclic_demo(void *ctx)
> +static void cyclic_demo(struct cyclic_info *c)
>   {
> -	struct cyclic_demo_info *info = ctx;
> +	struct cyclic_demo_info *info = container_of(c, struct cyclic_demo_info, cyclic);
>   
>   	/* Just a small dummy delay here */
>   	udelay(info->delay_us);
> @@ -32,7 +34,6 @@ static int do_cyclic_demo(struct cmd_tbl *cmdtp, int flag, int argc,
>   			  char *const argv[])
>   {
>   	struct cyclic_demo_info *info;
> -	struct cyclic_info *cyclic;
>   	uint time_ms;
>   
>   	if (argc < 3)
> @@ -48,10 +49,7 @@ static int do_cyclic_demo(struct cmd_tbl *cmdtp, int flag, int argc,
>   	info->delay_us = simple_strtoul(argv[2], NULL, 0);
>   
>   	/* Register demo cyclic function */
> -	cyclic = cyclic_register(cyclic_demo, time_ms * 1000, "cyclic_demo",
> -				 info);
> -	if (!cyclic)
> -		printf("Registering of cyclic_demo failed\n");
> +	cyclic_register(&info->cyclic, cyclic_demo, time_ms * 1000, "cyclic_demo");
>   
>   	printf("Registered function \"%s\" to be executed all %dms\n",
>   	       "cyclic_demo", time_ms);
> diff --git a/common/cyclic.c b/common/cyclic.c
> index c62e7fa7d19..ec38fad6775 100644
> --- a/common/cyclic.c
> +++ b/common/cyclic.c
> @@ -26,34 +26,22 @@ struct hlist_head *cyclic_get_list(void)
>   	return (struct hlist_head *)&gd->cyclic_list;
>   }
>   
> -struct cyclic_info *cyclic_register(cyclic_func_t func, uint64_t delay_us,
> -				    const char *name, void *ctx)
> +void cyclic_register(struct cyclic_info *cyclic, cyclic_func_t func,
> +		     uint64_t delay_us, const char *name)
>   {
> -	struct cyclic_info *cyclic;
> -
> -	cyclic = calloc(1, sizeof(struct cyclic_info));
> -	if (!cyclic) {
> -		pr_debug("Memory allocation error\n");
> -		return NULL;
> -	}
> +	memset(cyclic, 0, sizeof(*cyclic));
>   
>   	/* Store values in struct */
>   	cyclic->func = func;
> -	cyclic->ctx = ctx;
>   	cyclic->name = name;
>   	cyclic->delay_us = delay_us;
>   	cyclic->start_time_us = timer_get_us();
>   	hlist_add_head(&cyclic->list, cyclic_get_list());
> -
> -	return cyclic;
>   }
>   
> -int cyclic_unregister(struct cyclic_info *cyclic)
> +void cyclic_unregister(struct cyclic_info *cyclic)
>   {
>   	hlist_del(&cyclic->list);
> -	free(cyclic);
> -
> -	return 0;
>   }
>   
>   void cyclic_run(void)
> @@ -76,7 +64,7 @@ void cyclic_run(void)
>   		if (time_after_eq64(now, cyclic->next_call)) {
>   			/* Call cyclic function and account it's cpu-time */
>   			cyclic->next_call = now + cyclic->delay_us;
> -			cyclic->func(cyclic->ctx);
> +			cyclic->func(cyclic);
>   			cyclic->run_cnt++;
>   			cpu_time = timer_get_us() - now;
>   			cyclic->cpu_time_us += cpu_time;
> diff --git a/doc/develop/cyclic.rst b/doc/develop/cyclic.rst
> index 67831496a70..893c269099a 100644
> --- a/doc/develop/cyclic.rst
> +++ b/doc/develop/cyclic.rst
> @@ -19,20 +19,26 @@ Registering a cyclic function
>   
>   To register a cyclic function, use something like this::
>   
> -    static void cyclic_demo(void *ctx)
> +    struct donkey {
> +        struct cyclic_info cyclic;
> +        void (*say)(const char *s);
> +    };
> +
> +    static void cyclic_demo(struct cyclic_info *c)
>       {
> -        /* Just a small dummy delay here */
> -        udelay(10);
> +        struct donkey *donkey = container_of(c, struct donkey, cyclic);
> +
> +        donkey->say("Are we there yet?");
>       }
> -
> -    int board_init(void)
> +
> +    int donkey_init(void)
>       {
> -        struct cyclic_info *cyclic;
> -
> +        struct donkey *donkey;
> +
> +        /* Initialize donkey ... */
> +
>           /* Register demo cyclic function */
> -        cyclic = cyclic_register(cyclic_demo, 10 * 1000, "cyclic_demo", NULL);
> -        if (!cyclic)
> -        printf("Registering of cyclic_demo failed\n");
> +        cyclic_register(&donkey->cyclic, cyclic_demo, 10 * 1000, "cyclic_demo");
>           
>           return 0;
>       }
> diff --git a/drivers/watchdog/wdt-uclass.c b/drivers/watchdog/wdt-uclass.c
> index 12850016c93..e2e7f9ab84b 100644
> --- a/drivers/watchdog/wdt-uclass.c
> +++ b/drivers/watchdog/wdt-uclass.c
> @@ -17,12 +17,15 @@
>   #include <asm/global_data.h>
>   #include <dm/device-internal.h>
>   #include <dm/lists.h>
> +#include <linux/kernel.h>
>   
>   DECLARE_GLOBAL_DATA_PTR;
>   
>   #define WATCHDOG_TIMEOUT_SECS	(CONFIG_WATCHDOG_TIMEOUT_MSECS / 1000)
>   
>   struct wdt_priv {
> +	/* The udevice owning this wdt_priv. */
> +	struct udevice *dev;
>   	/* Timeout, in seconds, to configure this device to. */
>   	u32 timeout;
>   	/*
> @@ -40,18 +43,17 @@ struct wdt_priv {
>   	/* autostart */
>   	bool autostart;
>   
> -	struct cyclic_info *cyclic;
> +	struct cyclic_info cyclic;
>   };
>   
> -static void wdt_cyclic(void *ctx)
> +static void wdt_cyclic(struct cyclic_info *c)
>   {
> -	struct udevice *dev = ctx;
> -	struct wdt_priv *priv;
> +	struct wdt_priv *priv = container_of(c, struct wdt_priv, cyclic);
> +	struct udevice *dev = priv->dev;
>   
>   	if (!device_active(dev))
>   		return;
>   
> -	priv = dev_get_uclass_priv(dev);
>   	if (!priv->running)
>   		return;
>   
> @@ -124,20 +126,14 @@ int wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
>   		memset(str, 0, 16);
>   		if (IS_ENABLED(CONFIG_WATCHDOG)) {
>   			if (priv->running)
> -				cyclic_unregister(priv->cyclic);
> +				cyclic_unregister(&priv->cyclic);
>   
>   			/* Register the watchdog driver as a cyclic function */
> -			priv->cyclic = cyclic_register(wdt_cyclic,
> -						       priv->reset_period * 1000,
> -						       dev->name, dev);
> -			if (!priv->cyclic) {
> -				printf("cyclic_register for %s failed\n",
> -				       dev->name);
> -				return -ENODEV;
> -			} else {
> -				snprintf(str, 16, "every %ldms",
> -					 priv->reset_period);
> -			}
> +			cyclic_register(&priv->cyclic, wdt_cyclic,
> +					priv->reset_period * 1000,
> +					dev->name);
> +
> +			snprintf(str, 16, "every %ldms", priv->reset_period);
>   		}
>   
>   		priv->running = true;
> @@ -162,7 +158,7 @@ int wdt_stop(struct udevice *dev)
>   		struct wdt_priv *priv = dev_get_uclass_priv(dev);
>   
>   		if (IS_ENABLED(CONFIG_WATCHDOG) && priv->running)
> -			cyclic_unregister(priv->cyclic);
> +			cyclic_unregister(&priv->cyclic);
>   
>   		priv->running = false;
>   	}
> @@ -262,6 +258,7 @@ static int wdt_pre_probe(struct udevice *dev)
>   			autostart = true;
>   	}
>   	priv = dev_get_uclass_priv(dev);
> +	priv->dev = dev;
>   	priv->timeout = timeout;
>   	priv->reset_period = reset_period;
>   	priv->autostart = autostart;
> diff --git a/include/cyclic.h b/include/cyclic.h
> index 38946216fb8..dc0749ba03d 100644
> --- a/include/cyclic.h
> +++ b/include/cyclic.h
> @@ -18,7 +18,6 @@
>    * struct cyclic_info - Information about cyclic execution function
>    *
>    * @func: Function to call periodically
> - * @ctx: Context pointer to get passed to this function
>    * @name: Name of the cyclic function, e.g. shown in the commands
>    * @delay_ns: Delay is ns after which this function shall get executed
>    * @start_time_us: Start time in us, when this function started its execution
> @@ -29,8 +28,7 @@
>    * @already_warned: Flag that we've warned about exceeding CPU time usage
>    */
>   struct cyclic_info {
> -	void (*func)(void *ctx);
> -	void *ctx;
> +	void (*func)(struct cyclic_info *c);
>   	const char *name;
>   	uint64_t delay_us;
>   	uint64_t start_time_us;
> @@ -42,28 +40,30 @@ struct cyclic_info {
>   };
>   
>   /** Function type for cyclic functions */
> -typedef void (*cyclic_func_t)(void *ctx);
> +typedef void (*cyclic_func_t)(struct cyclic_info *c);
>   
>   #if defined(CONFIG_CYCLIC)
>   /**
>    * cyclic_register - Register a new cyclic function
>    *
> + * @cyclic: Cyclic info structure
>    * @func: Function to call periodically
>    * @delay_us: Delay is us after which this function shall get executed
>    * @name: Cyclic function name/id
> - * @ctx: Context to pass to the function
> - * @return: pointer to cyclic_struct if OK, NULL on error
> + *
> + * The function @func will be called with @cyclic as its
> + * argument. @cyclic will usually be embedded in some device-specific
> + * structure, which the callback can retrieve using container_of().
>    */
> -struct cyclic_info *cyclic_register(cyclic_func_t func, uint64_t delay_us,
> -				    const char *name, void *ctx);
> +void cyclic_register(struct cyclic_info *cyclic, cyclic_func_t func,
> +		     uint64_t delay_us, const char *name);
>   
>   /**
>    * cyclic_unregister - Unregister a cyclic function
>    *
>    * @cyclic: Pointer to cyclic_struct of the function that shall be removed
> - * @return: 0 if OK, -ve on error
>    */
> -int cyclic_unregister(struct cyclic_info *cyclic);
> +void cyclic_unregister(struct cyclic_info *cyclic);
>   
>   /**
>    * cyclic_unregister_all() - Clean up cyclic functions
> @@ -97,17 +97,17 @@ void cyclic_run(void);
>    */
>   void schedule(void);
>   #else
> -static inline struct cyclic_info *cyclic_register(cyclic_func_t func,
> -						  uint64_t delay_us,
> -						  const char *name,
> -						  void *ctx)
> +
> +struct cyclic_info {
> +};
> +
> +static inline void cyclic_register(struct cyclic_info *cyclic, cyclic_func_t func,
> +				   uint64_t delay_us, const char *name)
>   {
> -	return NULL;
>   }
>   
> -static inline int cyclic_unregister(struct cyclic_info *cyclic)
> +static inline void cyclic_unregister(struct cyclic_info *cyclic)
>   {
> -	return 0;
>   }
>   
>   static inline void cyclic_run(void)
> -

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
