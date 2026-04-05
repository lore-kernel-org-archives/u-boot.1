Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E87E64011
	for <u-boot@archiver.kernel.org>; Sun,  5 Apr 2026 04:32:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 387C884020;
	Sun,  5 Apr 2026 06:32:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="LswtDln5";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Hdu6/YV5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1161C8341A; Sun,  5 Apr 2026 06:32:49 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2795B8341A
 for <u-boot@lists.denx.de>; Sun,  5 Apr 2026 06:32:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fpKM25pm5z9v5y;
 Sun,  5 Apr 2026 06:32:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1775363566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CG8WMjxGp6ZrJT9sDvV0ZqpbSOt8uWF9/9hMs/TY7+I=;
 b=LswtDln5gmPZ9em/3WQC9Nqyp4a1urj38sz8VhrnsnABf/iQpoR2GbjSpK7XvhpTtOLhF7
 L8YfAkCijUk6VnXncmvje8tPNSAF+zqbPg3gPLNt+DUu7TMQ3CxJypGZXF0ATOAkPL3Cbn
 mhWuvgLR70QardCwtw9u0e5Z1SLFHttxyZbDSYV4wXD7+QxKwxNPytvXFc8H/bQoGFuPpD
 I92pTVKhA6ACsV8hziPRaBtOfpdAh7bGQkQN+STZwgxYrj1lYapC80U9UbZap6Ac8/3dCu
 iOv/VxzNBrSeMeMeuPBP0KWkLBcFaT7LEBQUVbX9Kr7H8ZFGxDdw5aSRnMY9mg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="Hdu6/YV5";
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <3b93c2f7-e83f-4cdc-8481-089aceb9cf48@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1775363565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CG8WMjxGp6ZrJT9sDvV0ZqpbSOt8uWF9/9hMs/TY7+I=;
 b=Hdu6/YV5kPv3sMoNJzOVwOxD7DFJghhqSF4xe8lIZCdMeE8WWUmc0Cl+UFXxsuKQ4fle68
 c1cJdVMhti+JHHBUT5I0jLDCq5bLmUDtNDKasSRdzXg06x8aYvIlkIdYl9JTwktUPXNTys
 vrgbySBhvAtx7Aaa31FQku9ljvffFsFzl5DCVTgiM9o3E2RSDugyUS9nHG90aJUDwfkA/A
 PAcRjT/NgXm8kx2+YKcDeX4jZPCh1V6rrYsACjyrqSPkaqcDHQymrFpZhXvcxqz33N6V4Q
 8ffJYYOPcXwvv8uGWwidPpeNCs+Ldn4uv0wJfhLkCq2BA4O2OuKiVhs/SpB8ww==
Date: Sun, 5 Apr 2026 06:01:32 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v1 4/4] common: Add an optionto relocate on ram top
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, u-boot@lists.denx.de
References: <20260403090109.3564638-1-ilias.apalodimas@linaro.org>
 <20260403090109.3564638-5-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260403090109.3564638-5-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ttsxdod3rn944uors77mqqnwg413abba
X-MBO-RS-ID: 41e3662cc01eb90c268
X-Rspamd-Queue-Id: 4fpKM25pm5z9v5y
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

[...]

> @@ -353,8 +357,19 @@ static int setup_ram_config(void)
>   	 */
>   	gd->ram_size -= CONFIG_SYS_MEM_TOP_HIDE;
>   #endif
> +#if CONFIG_IS_ENABLED(RELOC_ADDR_TOP)
> +	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
> +		if (gd->ram_top <= gd->bi_dram[bank].start)
> +			gd->ram_top = gd->bi_dram[bank].start +
> +					gd->bi_dram[bank].size;
> +		total_size += gd->bi_dram[bank].size;
> +	}
> +
> +	gd->ram_size = total_size;
> +#else
>   	gd->ram_top = gd->ram_base + get_effective_memsize();
>   	gd->ram_top = board_get_usable_ram_top(gd->mon_len);
> +#endif
It would be nice if we could get rid of this ifdeffery and align the two 
branches of the code, but otherwise this looks nice.
