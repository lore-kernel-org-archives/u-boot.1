Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F128EEE4993
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 18:06:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68D028704F;
	Mon, 21 Aug 2023 20:06:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=ruabmbua.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ruabmbua.dev header.i=@ruabmbua.dev header.b="Utwp9+FT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EA4787051; Mon, 21 Aug 2023 20:06:16 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 642F08700F
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 20:06:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=ruabmbua.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mail@ruabmbua.dev
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4RV0lk6dhVz9sSP;
 Mon, 21 Aug 2023 20:06:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ruabmbua.dev;
 s=MBO0001; t=1692641170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GLW6IMjd6g5gmfXXXV2l0TDaC+Wgp+yqjnswJJwSpUQ=;
 b=Utwp9+FTMgQBv6rJ3LInkVNZgt54sVYuS4xzeZfi8eMl5YIvQ4Ge6jL7eUfKw42lQXLOd9
 ep8zzhiYZZjyz+/467LgFD3o7zFajbq/Pa7IwwUhJgasYOTFM5wTbrQQes8su5vb23NVhn
 HpWELmYC3UgDVd1yGjO+k5VCSB2IJkJ+iIElcgWN9UtfhjipZs38YW+KbCVkHQz5r14poT
 u53qNam86QTbqVWCl/25A/DFT3CLzHFoJTCNQCgSOg8RutMfrrGakgVuJB4A/WGPwO0qWx
 gFmXTXiDaIUxIoWuAjrYovvAKa7fQGEsto4QcNY0RaSzVwJB/1gcBKXtgcTCfA==
Message-ID: <f8e516fb-3915-4416-bfab-8744f4e879bb@ruabmbua.dev>
Date: Mon, 21 Aug 2023 20:06:10 +0200
MIME-Version: 1.0
From: Roland Ruckerbauer <mail@ruabmbua.dev>
Subject: Re: [PATCH v2 2/2] riscv: cpu: make riscv_cpu_probe to
 EVT_DM_POST_INIT_R callback (resend)
To: Chanho Park <chanho61.park@samsung.com>
Cc: u-boot@lists.denx.de
References: <20230818051103.2427590-1-chanho61.park@samsung.com>
 <CGME20230818052645epcas2p3df52c8522cd903f869d366fed46ea89d@epcas2p3.samsung.com>
 <20230818051103.2427590-3-chanho61.park@samsung.com>
Content-Language: en-US
In-Reply-To: <20230818051103.2427590-3-chanho61.park@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
> arch/riscv/cpu/cpu.c | 11 +++--------
> 1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/arch/riscv/cpu/cpu.c b/arch/riscv/cpu/cpu.c
> index ecfb1fb08c4b..0b4208e72199 100644
> --- a/arch/riscv/cpu/cpu.c
> +++ b/arch/riscv/cpu/cpu.c
> @@ -66,7 +66,7 @@ static inline bool supports_extension(char ext)
> #endif /* CONFIG_CPU */
> }
> -static int riscv_cpu_probe(void)
> +static int riscv_cpu_probe(void *ctx, struct event *event)
> {
> #ifdef CONFIG_CPU
> int ret;
> @@ -79,6 +79,7 @@ static int riscv_cpu_probe(void)
> return 0;
> }
> +EVENT_SPY(EVT_DM_POST_INIT_R, riscv_cpu_probe);
> /*
> * This is called on secondary harts just after the IPI is init'd. 
> Currently
> @@ -95,7 +96,7 @@ int riscv_cpu_setup(void *ctx, struct event *event)
> {
> int ret;
> - ret = riscv_cpu_probe();
> + ret = riscv_cpu_probe(ctx, event);
> if (ret)
> return ret;
> @@ -149,12 +150,6 @@ EVENT_SPY(EVT_DM_POST_INIT_F, riscv_cpu_setup);
> int arch_early_init_r(void)
> {
> - int ret;
> -
> - ret = riscv_cpu_probe();
> - if (ret)
> - return ret;
> -
> if (IS_ENABLED(CONFIG_SYSRESET_SBI))
> device_bind_driver(gd->dm_root, "sbi-sysreset",
> "sbi-sysreset", NULL);
