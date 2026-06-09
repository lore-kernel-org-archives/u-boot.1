Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B4E3CD8CB9
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 04:00:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CF67839A8;
	Wed, 10 Jun 2026 06:00:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="gTY9r/jR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E76C2838BB; Wed, 10 Jun 2026 06:00:45 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 388A88005D
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 06:00:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gZsWX2pjcz9v2R;
 Wed, 10 Jun 2026 06:00:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781064040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pfTfWDxXdC8PVIXDtkq+/Z+Bm4QgfpqqntRN+KciWMo=;
 b=gTY9r/jRSljQ5G7NvS9rimNzBIEk+MZlCK8FWHCtaVFPq4rfKR+7pkl4Rs0HMa4dcFq3LW
 O2UcmJkfAVPYOHqvgIOVOwVYK3IURXdR/RgcU1d745IDTwcysZ3kWiWi9RknuHC2mUDDXV
 YUEe8ODzLnuARU2uLlZSrGSk5PsuK2U+/SyIgkNDydCkYdMRrC1iV752SwO/W0O4fn4a69
 OTEnNd8SKN2qI7JZPpyu3EbLLt9T0jIUXJ4wr5ZLaiHNb+PMS685jxYim+URFBBH7INne7
 ojr0YHhUgFH+L0FbBp9PMrYsUryrW2eOFt3oEF8neBWbljp1+qGFJSqeAbQGoQ==
Message-ID: <7d68bdee-78de-48f2-9813-4fd804a419a9@mailbox.org>
Date: Tue, 9 Jun 2026 21:27:12 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] spl: atf: support Linux as BL33 with ATF
To: Alexey Charkov <alchark@flipper.net>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
References: <20260609-atf-falcon-v1-0-2b20c5e83615@flipper.net>
 <20260609-atf-falcon-v1-1-2b20c5e83615@flipper.net>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260609-atf-falcon-v1-1-2b20c5e83615@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: rezttn9h34614cqrtg7wcuo3e6ed9ogc
X-MBO-RS-ID: 4f1681c328432024348
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

On 6/9/26 6:52 PM, Alexey Charkov wrote:
> Modern SoCs such as Rockchip RK3576 need ATF to be running to provide
> firmware services to the OS.
> 
> Enable the ATF boot flow to allow using Linux as BL33 (including its
> calling convention) to facilitate Falcon mode boot on such SoCs.

TFA

> +/* BL33 defaults to U-Boot unless Falcon mode selects Linux. */
> +static int spl_atf_bl33_os;
> +

Can we avoid this global static variable ?

>   /* Holds all the structures we need for bl31 parameter passing */
>   struct bl2_to_bl31_params_mem {
>   	struct bl31_params bl31_params;
> @@ -87,8 +90,11 @@ struct bl31_params *bl2_plat_get_bl31_params_default(ulong bl32_entry,
>   	SET_PARAM_HEAD(bl33_ep_info, ATF_PARAM_EP, ATF_VERSION_1,
>   		       ATF_EP_NON_SECURE);
>   
> -	/* BL33 expects to receive the primary CPU MPID (through x0) */

That seems a bit inconsistent, and not quite right. Do you know where 
U-Boot expects primary CPU ID in x0 exactly ? Which part of U-Boot code 
depends on it ?

> -	bl33_ep_info->args.arg0 = 0xffff & read_mpidr();
> +	/* Linux-at-BL33 expects DTB in x0, U-Boot expects primary CPU MPID in x0. */
> +	if (IS_ENABLED(CONFIG_SPL_OS_BOOT) && spl_atf_bl33_os == IH_OS_LINUX)
> +		bl33_ep_info->args.arg0 = fdt_addr;
> +	else
> +		bl33_ep_info->args.arg0 = 0xffff & read_mpidr();

[...]

> @@ -269,15 +279,22 @@ void __noreturn spl_invoke_atf(struct spl_image_info *spl_image)
>   		bl32_entry = spl_fit_images_get_entry(blob, node);
>   
>   	/*
> -	 * Find the U-Boot binary (in /fit-images) load addreess or
> -	 * entry point (if different) and pass it as the BL3-3 entry
> -	 * point.
> -	 * This will need to be extended to support Falcon mode.
> +	 * Find BL33 entry point. In Falcon mode, prefer Linux when requested.
> +	 * Fall back to U-Boot if Linux cannot be resolved.
That does not seem correct, if Linux cannot be resolved, then the system 
should stop booting, falling back into a bootloader could be security 
risk. There is a "recovery" boot weak symbol function, which can be used 
to start fallback bootloader, but that has to be deliberately 
implemented and triggered by the user e.g. by holding a button down.
