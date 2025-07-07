Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9782C8303C
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 15:53:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0E3983145;
	Mon,  7 Jul 2025 17:52:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="K5om+OfS";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hUKcefPE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C763F831D6; Mon,  7 Jul 2025 17:52:25 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F066583046
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 17:52:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bbTJl5BTyz9svb;
 Mon,  7 Jul 2025 17:52:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751903543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m1TDzIC0TmOjgqmn4tN26qruRxoan5f/1ES97UVG2FY=;
 b=K5om+OfStOoPFbHPinPnYGHYbkINx6bNtXZBtifPdcbhBaRM7iwDKf7SK5/wdaocHB9qXX
 CMsVz70hHxk0VWsoC7yuPfnQbpQ6iJqRgAiPR4d79iSoLPQtKGxZNrdqVe7L5kP+uOGRU5
 ELdLGlhZxJnq3xEjfJtQpUGWXocnsbIIIaMH9FLBUlq4L9PflsfUfIAsA1WiV/RIckoXAD
 En3mjWPOCLLrhXRyzUj75jFMCbVvpJ/+Lku9Z/jmXqZ4DjE0CPNecWZuUf6//SMn4escG+
 xRZG885jILIqxZvyaYWuzMrfrGsahhgzE4uBpog4LEGZ7QDmcctsco39T9uxtQ==
Message-ID: <27e8e250-6297-41a9-9664-9dadd1429c26@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751903541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m1TDzIC0TmOjgqmn4tN26qruRxoan5f/1ES97UVG2FY=;
 b=hUKcefPEHjWQ/vn/V6785dL38S7l1FL8UthQX1ErmAAOrZIMj5+tsw0X/gsMbNLJgoFOmj
 n0+4koBxogdTlMxkCvsAD6629OGo7oZ8QMkk87kdu3Aqap2jcnjcoGR8lNPOAG3iw3Xfhh
 9xZyvalg+ef4PFeNtr3ElNPZQ6zVZBnYUTfGaOJOpf5hbfothsgKL60mdayMa2aFdcQoAa
 zKyQB2KoBd3qE625ctZTdZl0/Dn9XCiHV33KFSrgd+i+7qxGXqcT8zPs5As8N8yLv91h8m
 6NjfMkjTKy13PCU5ZpeBVjgyzFXlO0kYZHVLDGsbCwvhZQR66+RRe/AvO5S0uA==
Date: Mon, 7 Jul 2025 17:49:15 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 8/9] ARM: renesas: Add RZ/A2 GR-Mango board support
To: Magnus Damm <damm@opensource.se>, u-boot@lists.denx.de
Cc: Chris.Brandt@renesas.com, marek.vasut+renesas@mailbox.org,
 geert+renesas@glider.be
References: <175180131601.86839.3544906856404059041.sendpatchset@1.0.0.127.in-addr.arpa>
 <175180137742.86839.9519699030077029409.sendpatchset@1.0.0.127.in-addr.arpa>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <175180137742.86839.9519699030077029409.sendpatchset@1.0.0.127.in-addr.arpa>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 0fbb104f2071694ced5
X-MBO-RS-META: fazn88itnptg83eekf4knrhrrjzf73b6
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

On 7/6/25 1:29 PM, Magnus Damm wrote:

[...]

> +++ work/board/renesas/grmango/grmango.c	2025-07-05 19:42:53.297553497 +0900
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2017 Renesas Electronics
> + * Copyright (C) Chris Brandt
> + */
> +
> +#include <init.h>
> +#include <linux/io.h>
> +#include <asm/global_data.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +int board_init(void)
> +{
> +	gd->bd->bi_boot_params = CFG_SYS_SDRAM_BASE + 0x100;
> +
> +	/* configure PFENET register to use MII for Ethernet */
> +	writeb(0x00, 0xfcffe2ff);
> +	writeb(0x40, 0xfcffe2ff);
> +	writeb(0x02, 0xfcffe820);

Please add symbolic names (introduce macros) for those registers here.

> +	return 0;
> +}

[...]

-- 
Best regards,
Marek Vasut
