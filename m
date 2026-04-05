Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD9BE64011
	for <u-boot@archiver.kernel.org>; Sun,  5 Apr 2026 04:32:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F142B807C0;
	Sun,  5 Apr 2026 06:32:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="nVNP1pxr";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="HrNSn5J0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF3E683C5E; Sun,  5 Apr 2026 06:32:47 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB53880433
 for <u-boot@lists.denx.de>; Sun,  5 Apr 2026 06:32:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fpKM11DJpz9tCY;
 Sun,  5 Apr 2026 06:32:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1775363565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fcispgOr4nkenO21NUWB+uvdXKKy1jFEdfaL0e1a4k8=;
 b=nVNP1pxrrpxhimxHi9y1X8pa7uCJ4lOeBC/ZTNtxBWKSZcf87+9L9itNYK3iEdfS43xmAd
 DbACyuwmTMPoVdrx5ydS6GC7ygCRoiDdcsBWVNOYsqcETHy7tIMCx9YedRZGOlTEs+pidP
 4hFYAsg98lu7SeHz9ZEZQAf3fhjxVjrd+5L3v85GnfVkDA8p8bUYeof8BmkcjXGnUvws17
 IxTl9EOezTzf1HAnXSW3I5lPhs2L2UtCqBfIXdN+nkX9WHAyZvFJ6Hn1G2h/aecD0LVf2i
 NWA3LPttOOVrih60i9SsXyWZjilCGhoDqc6bvi/dTbGKbcbEqPupJKIaT8huGg==
Message-ID: <b4015957-76b8-4531-b694-cae143a65f49@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1775363563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fcispgOr4nkenO21NUWB+uvdXKKy1jFEdfaL0e1a4k8=;
 b=HrNSn5J00pbvm1wT/Mrb4bBiauyisfMF0MF5uVwCC0rB24nJKu2tf4OnEYRekihGR3ZU2E
 jSR5gTUu/P3xZK5cOdyaDhXZA8k9pwydp95kDhjqPNkuC7ryeozkIwU73jki9HmWAzUXT/
 Q4U5ku19vl8emy1JcbEBTqdnkSega4yhQgmtlY3NTqqoYRDqCYTkL+j0PsbepUnskcXTae
 83iNr7fl6qZO/5qA1TDc8r2FRfZUxCLsG0VxwjdrryLhh5O8PyCzBzv6bj5c/RhrYlAK1p
 qA0N01Dkruz2FciSNkAqDQymzP8IEvGrqxlF0q0awzIFu2OeN1JW2jjEbAbhfA==
Date: Sun, 5 Apr 2026 05:59:52 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v1 2/4] common: move ram_base calculation to independent
 INITCALL()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, u-boot@lists.denx.de
References: <20260403090109.3564638-1-ilias.apalodimas@linaro.org>
 <20260403090109.3564638-3-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260403090109.3564638-3-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: e959sdc6kermaobt6n6g7344bnksn1pq
X-MBO-RS-ID: c90b0738cfa203862ef
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

On 4/3/26 11:01 AM, Ilias Apalodimas wrote:
> Currently, ram_base is calculated within setup_dest_addr().
> However, upcoming patches that enable U-Boot relocation to the highest
> DRAM bank require ram_base to be initialized earlier.
> 
> The default dram_init_banksize() definition relies on ram_base
> to calculate the start of the first bank. But following patches
> will move that function to execute immediately before setup_dest_addr().
> 
> So let's split the ram_base initialization in its own INITCALL.
> 
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   common/board_f.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/common/board_f.c b/common/board_f.c
> index 91c569da9682..7df92281c35a 100644
> --- a/common/board_f.c
> +++ b/common/board_f.c
> @@ -329,6 +329,14 @@ __weak int arch_setup_dest_addr(void)
>   	return 0;
>   }
>   
> +static int setup_ram_base(void)
> +{
> +#ifdef CFG_SYS_SDRAM_BASE
> +	gd->ram_base = CFG_SYS_SDRAM_BASE;

Would it make sense to reset the variable to 0 in case 
CFG_SYS_SDRAM_BASE is not defined ?

Or better yet, how about moving CFG_SYS_SDRAM_BASE to Kconfig with 
default value 0 ?
