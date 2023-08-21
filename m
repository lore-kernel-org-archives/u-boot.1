Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF21AEE4996
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 03:47:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 906CD871D1;
	Tue, 22 Aug 2023 05:47:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rucky.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=rucky.eu header.i=@rucky.eu header.b="qN7lE3Jo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 183FA87015; Mon, 21 Aug 2023 20:02:13 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 582B286813
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 20:02:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=rucky.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=roland@rucky.eu
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4RV0g35DqKz9spd;
 Mon, 21 Aug 2023 20:02:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rucky.eu; s=MBO0001;
 t=1692640927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mm4QX4pM2laWWU9302315dWsg+ecRg9iKviuZ/BttxE=;
 b=qN7lE3JotuVcKokSVafcq3gRsZU3njHaKNlMRfk1PdQC+jgKgeEi/pHFsFzikO919ZIXZl
 1F/2cFQUxniOYt6nFpHC7wuibgZUWWhgvPfTP61BkscW3WOoNOHzEGWHV4PgX8z8LgX2lU
 zgUPCSXNHaCj1BLH9m8I4mw9A4BExYmMSGC8FcL9CG4eakYbvUmx8Uxvit16AXGxvOsjtA
 kxgdzBIqyN5sTWGG8czXG1uysZBbMY8KeCTfDqcGGxTeRYh6eK6D443UTl3T8H45+nYpO/
 pyTQCdoqifxzcEi9Q6sx5tscogx7gSu6zD2T82w7Pg6bCCEaOEVrfq8wEHAsYQ==
Message-ID: <f2a1b35d-3c3f-45f0-9f7e-9c516be0089f@rucky.eu>
Date: Mon, 21 Aug 2023 20:02:06 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] riscv: cpu: make riscv_cpu_probe to
 EVT_DM_POST_INIT_R callback
Content-Language: en-US
To: Chanho Park <chanho61.park@samsung.com>
References: <20230818051103.2427590-1-chanho61.park@samsung.com>
 <CGME20230818052645epcas2p3df52c8522cd903f869d366fed46ea89d@epcas2p3.samsung.com>
 <20230818051103.2427590-3-chanho61.park@samsung.com>
Cc: u-boot@lists.denx.de
From: Roland Ruckerbauer <roland@rucky.eu>
In-Reply-To: <20230818051103.2427590-3-chanho61.park@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 22 Aug 2023 05:47:23 +0200
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

Tested on visionfive2, it works.

On 18.08.23 07:11, Chanho Park wrote:
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
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Bin Meng <bmeng.cn@gmail.com>
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
Tested-by: Roland Ruckerbauer <mail@ruabmbua.dev>
> ---
>   arch/riscv/cpu/cpu.c | 11 +++--------
>   1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/arch/riscv/cpu/cpu.c b/arch/riscv/cpu/cpu.c
> index ecfb1fb08c4b..0b4208e72199 100644
> --- a/arch/riscv/cpu/cpu.c
> +++ b/arch/riscv/cpu/cpu.c
> @@ -66,7 +66,7 @@ static inline bool supports_extension(char ext)
>   #endif /* CONFIG_CPU */
>   }
>   
> -static int riscv_cpu_probe(void)
> +static int riscv_cpu_probe(void *ctx, struct event *event)
>   {
>   #ifdef CONFIG_CPU
>   	int ret;
> @@ -79,6 +79,7 @@ static int riscv_cpu_probe(void)
>   
>   	return 0;
>   }
> +EVENT_SPY(EVT_DM_POST_INIT_R, riscv_cpu_probe);
>   
>   /*
>    * This is called on secondary harts just after the IPI is init'd. Currently
> @@ -95,7 +96,7 @@ int riscv_cpu_setup(void *ctx, struct event *event)
>   {
>   	int ret;
>   
> -	ret = riscv_cpu_probe();
> +	ret = riscv_cpu_probe(ctx, event);
>   	if (ret)
>   		return ret;
>   
> @@ -149,12 +150,6 @@ EVENT_SPY(EVT_DM_POST_INIT_F, riscv_cpu_setup);
>   
>   int arch_early_init_r(void)
>   {
> -	int ret;
> -
> -	ret = riscv_cpu_probe();
> -	if (ret)
> -		return ret;
> -
>   	if (IS_ENABLED(CONFIG_SYSRESET_SBI))
>   		device_bind_driver(gd->dm_root, "sbi-sysreset",
>   				   "sbi-sysreset", NULL);
