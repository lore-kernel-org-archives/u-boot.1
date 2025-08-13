Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A68CA0EE0
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 21:41:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 435E282ADA;
	Wed, 13 Aug 2025 23:41:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Bc7TrepO";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xq9Gup8v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24CE2836C8; Wed, 13 Aug 2025 23:41:12 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C64E082A53
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 23:41:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4c2MJ54Bxgz9stK;
 Wed, 13 Aug 2025 23:41:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1755121269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z1mmRfzQVDoTnHKJ+Mq3ts6PPxPWVsOhP9NjAqEJOBU=;
 b=Bc7TrepOUwUN0aqf7W4dRelLDRp8chvG3UXyV9/usCsonTXnYkm/pHh88V6W8M3W8kUzX+
 nnadeOcx3W9EQ3NoPz2KEGjwaoSw/Xcf1+5DRyP/t3cqumX+sO+pTyiqaqzL9YL9xuQlkX
 3m4NMveMgYuW6YZcG1tY7iKf2wS5pt8Bjos0yDTDJ2SlQKY093teODOf2Nxw7t/6++9bsT
 QsL/azGb8h2TwWKqBgJyFYaWZGq6acCdn+E/sN+RVpe9N+9J8IP0d6Ix4erYpScVhuJjay
 0Vq0uFi4Oy5rScOTMGyOwuLLt+7/W6iLR5wDJny12leanpmw6YYoemZCGjStcw==
Message-ID: <78d92d4d-c665-4d95-bfee-68d3b79efa2b@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1755121267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z1mmRfzQVDoTnHKJ+Mq3ts6PPxPWVsOhP9NjAqEJOBU=;
 b=xq9Gup8vHj5yNGGnJmUBPzJA7HbbOgpZHx8W7pLG2ryKr7Zd73nzr6jlr/BJlWP+dzm3d5
 BYVXleshTAcx30FyRFNM2xkZo8aQdDlRypaVsrMpqrCnhTY2SozBwYz4s6EEEKauRSypGx
 jKoqsObMwe1BwcAvSk3KJHEhNwaenFZVQFQ+r92GtsLWO2J+So39zjGNzxLS8oPIDRwP6W
 gUIYLJN2OzZikgYOS1OglSR0DXkSxLdBSyusAvqbucn1H1/WVUtMcOrh5qDH3JTRUz29Vu
 yFQDfsme3k1wKcLM/2LVv1zP/gyFbnSsPlKIvFYRDd3S2QafGIYbTAZdeKjuTw==
Date: Wed, 13 Aug 2025 23:41:03 +0200
MIME-Version: 1.0
Subject: Re: [U-Boot, v4, 1/1] misc: fs_loader: Add
 request_firmware_into_buf_via_script() for flexible firmware loading via
 U-Boot script
To: "Lucien.Jheng" <lucienzx159@gmail.com>, u-boot@lists.denx.de,
 marek.vasut+renesas@mailbox.org, tien.fong.chee@altera.com,
 trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de, seanga2@gmail.com,
 daniel@makrotopia.org
Cc: lucien.jheng@airoha.com, frank-w@public-files.de, albert-al.lee@airoha.com
References: <20250804150734.4901-1-lucienzx159@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250804150734.4901-1-lucienzx159@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 3j9nc8nrrsmi1zzjsowk3o1yow1e76nb
X-MBO-RS-ID: ef20a18a8f991c0a12f
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

On 8/4/25 5:07 PM, Lucien.Jheng wrote:

> +/**
> + * request_firmware_into_buf_via_script() -
> + * Load firmware using a U-Boot script and copy to buffer
> + * @buf: Pointer to a pointer where the firmware buffer will be stored.
> + * @max_size: Maximum allowed size for the firmware to be loaded.
> + * @script_name: Name of the U-Boot script to execute for firmware loading.
> + *
> + * Executes a U-Boot script (@script_name) that loads firmware into
> + * memory and sets the environment variables 'fw_addr' (address) and
> + * 'fw_size' (size in bytes)

- Allocates a buffer, copies the firmware
- from the given address, and returns the pointer via @buf.

+ On success, copies the firmware
+ from the given address to user buffer @buf.

> + *
> + * The script must set these environment variables:
> + *   fw_addr - Address where firmware is loaded in memory
> + *   fw_size - Size of the firmware in bytes
> + *
> + * The script should be defined in the U-Boot environment, for example:
> + *   env set script_name 'load mmc 0:1 ${loadaddr} firmware.bin &&
> + *   env set fw_addr ${loadaddr} && env set fw_size ${filesize}
> + * Return: 0 on success, negative value on error.
> + */

This function description can be present only in one copy in the header 
file include/fs_loader.h , drop this redundant copy.

> +int request_firmware_into_buf_via_script(void **buf, size_t max_size,
> +					 const char *script_name)
> +{
> +	ulong addr, size;
> +	int ret;
> +	char cmd[32];
> +
> +	if (!buf || !script_name || !max_size)
> +		return -EINVAL;
> +
> +	/* Create command to run the firmware loading script */
> +	snprintf(cmd, sizeof(cmd), "run %s", script_name);
> +
> +	/* Run the firmware loading script */
> +	ret = run_command_list(cmd, -1, 0);
> +	if (ret) {
> +		log_err("Firmware loading script '%s' not defined or failed.\n",
> +			script_name);
> +		return -EINVAL;
> +	}
> +
> +	/* Find out where the firmware got loaded and how long it is */
> +	addr = env_get_hex("fw_addr", 0);
> +	size = env_get_hex("fw_size", 0);
> +
> +	/* Clear the variables set by the firmware loading script */
> +	env_set("fw_addr", NULL);
> +	env_set("fw_size", NULL);
> +
> +	if (!addr || !size) {
> +		log_err("Firmware address (0x%lx) or size (0x%lx) are invalid.\n",
> +			addr, size);
> +		return -EINVAL;
> +	}

Please also add one more check:

if (size > max_size) {
   log_err("Loaded firmware size 0x%lx exceeded maximum allowed size 
0x%lx.\n", size, max_size);
   return -E2BIG;
}

> +	memcpy(*buf, (void *)addr, min(size, max_size));
> +
> +	return 0;
> +}
With these two nitpicks above fixed, it looks perfect. Thanks !
