Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB11CD6E6E
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 22:34:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C806848BC;
	Fri,  5 Jun 2026 00:34:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="F2StWJ6n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25DAB84928; Fri,  5 Jun 2026 00:34:18 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50C9284868
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 00:34:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gWfWB0kbbz9tfX;
 Fri,  5 Jun 2026 00:34:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1780612454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qjAI0oTzTASxnStNP2zS8IXIDxQVyIx1hEnSZIDKeoM=;
 b=F2StWJ6nEi6UIdK0PqzGy/o9JFIIz2uUjZUuRDqzQ/bi+xIXro+MywXViidljTGttdDui5
 sAE3yqamJjfkkn1NQURqMKCZQ3Bts0P9IaZHOzCuYWlrxQVWBIJjfvta6UV46D0i4Uuon1
 txkHKt0OH8NI+4nEKAHsLOn3b3yboi+blzcQKSnh7rl6Il/ztTLKIIXOUXRNk0En2ScDE6
 2vToY5E4YQiYz0VXUeggPg0hViGX/LeFPXxVNPjdWOMkAjyiG1ryrXfwGzvrZZpT0NGGGc
 m4Io8n/gYLeK28+A6eVe9II8AM1cYpiU790O1Dy382Flmg14/hznSMBSMQmXog==
Message-ID: <e8b3cdf7-80c2-4c81-8d2d-a1d2140083c6@mailbox.org>
Date: Fri, 5 Jun 2026 00:34:11 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v5 5/7] common: Add an option to relocate on ram top
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, trini@konsulko.com
Cc: jonas@kwiboo.se, anshuld@ti.com, sjg@chromium.org, u-boot@lists.denx.de
References: <20260604073719.48723-1-ilias.apalodimas@linaro.org>
 <20260604073719.48723-6-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260604073719.48723-6-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 663a75959a83e28dba8
X-MBO-RS-META: pc1mdrmrconb5g6besatixpu438qb9ew
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

On 6/4/26 9:37 AM, Ilias Apalodimas wrote:
> Right now we only relocate u-boot to the top of the first
> memory bank unless the board specific code overwrites it.
> This is problematic when loading big binaries as it
> fragments the contiguous memory space for no apparent reason.
> 
> On certain platforms, it is currently not possible to relocate U-Boot
> above the 32bit boundary, due to various dependencies on content located
> below the 32bit boundary. One such example is ethernet, where the packet
> buffer built into U-Boot binary is placed below the 32bit boundary and
> allows loading of data via ethernet even above 32bit boundary due to
> memory copy from the packet buffer to the destination location.
> 
> A previous patch moves the bi_dram[] info from bd to gd and make
> the memory bank information available early. So move the
> dram_init_banksize() INITCALL before the relocation address calculation
> and use it to derive the address.
> 
> Also add a Kconfig option and allow the common code to relocate U-Boot
> to the top of the last discovered bank.
> It's worth noting that this patch changes when dram_init_banksize()
> is called. It's now called  much earlier in the board init process.
> That is a significant ordering change for every board with a custom
> dram_init_banksize(), and it is unconditional (not gated on RELOC_ADDR_TOP).
> 
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
