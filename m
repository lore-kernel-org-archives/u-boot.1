Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F80C47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 13:30:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF312877B0;
	Wed, 17 Jan 2024 14:30:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="tjrjRR1a";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jqwkt2cY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5FAA8798D; Wed, 17 Jan 2024 14:30:50 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC5D387522
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 14:30:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4TFRbB3QTYz9t2n;
 Wed, 17 Jan 2024 14:30:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1705498246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SY/fsLTL/eVFUMA50CfEZADIbUXjMby6WKSPAdGGDkk=;
 b=tjrjRR1ajG4clshVB9HMtyoCeK8eU00K/BoBzwDplNudQ2jg6FQvwOgGb21gyzCZO5WRDp
 US82UFVbgNH9DvR8xrlbuwLvMaXHHEIrV9t2HnPDubNYkP34mV458P3/rQFXe+pgQpB8GQ
 F88RSfKagvDVcXV5Fz6fJKbOaGHUnkLjV5TAVjdGgIZawvIuiuM5KrxXhZPiA25rI+LjuX
 eTfyPICsNHD+xofcrKgkg5+t6pYSfwU2kA/EzylRZHsMVpsEme+SSZOSvZulMy9jxcI26b
 xIzHii7CsANqSFSdy6KEKY2qpB25l8fEw5f07H5nbCXRyeq9UVR4I3zNx98HLw==
Message-ID: <2adbc4f0-69ad-4b08-bcf2-7427ae936d88@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1705498244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SY/fsLTL/eVFUMA50CfEZADIbUXjMby6WKSPAdGGDkk=;
 b=jqwkt2cYkQAp7sfs8JaNsjfAObTqbqAxNdOpyZI3eC2IzEJyfww0YRyzIutvagd24TZk/e
 5ok7w/nybjV9MxQ1MZ0Xy8RQn+uWsc9DZjl9AEy6W4FJY5PE4tOVaWva7PSIF4PTRxL+su
 dpEzLmpg/Jws0n4BpUsUTL2L6JwnW96jBeN9oFNWM5pXEX6il/3MsDrVz0PPyb/wP37lq7
 ehZ/pbRD7iLoHR04c7fziP7uXpupRPgy7HORqXLXYkqEK8tqTKO3yz4B0QZTnhWIiIuV4I
 ebFdv9wszrwzepnKO5eBfwkvJS0M3ua48t04SJegkgJrfmlEZbNemVjkcqO3qQ==
Date: Wed, 17 Jan 2024 14:30:41 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2] common: console: Fix print complete stdio device list
To: Patrice Chotard <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Bin Meng <bmeng@tinylab.org>, Ion Agorria <ion@agorria.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>
References: <20240117123714.50380-1-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20240117123714.50380-1-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: bgg3o35o4dwg74bo8um5q7cym673acuh
X-MBO-RS-ID: 932d97a21ee3ab02a6e
X-Rspamd-Queue-Id: 4TFRbB3QTYz9t2n
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

On 1/17/24 13:37, Patrice Chotard wrote:
> In case CONSOLE_MUX and SYS_CONSOLE_IS_IN_ENV are on and
> stdin or stdout or stderr are missing in environment, as fallback, get
> these either from stdio_devices[std] or stdio_devices[std]->name.
> 
> Fixes: 6b343ab38d ("console: Print out complete stdio device list")
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>

Yes, please, this is a good idea:

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
