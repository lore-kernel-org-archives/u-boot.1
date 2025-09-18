Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91EA0CAC5A0
	for <u-boot@archiver.kernel.org>; Thu, 18 Sep 2025 13:17:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1FD38004F;
	Thu, 18 Sep 2025 15:17:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="YkolTAlt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19DB681E13; Thu, 18 Sep 2025 15:17:27 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E34318003E
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 15:17:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cSGQB5JDrz9tsr;
 Thu, 18 Sep 2025 15:17:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758201442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8qpLQKCGVX6cwitkrumYuocOTcNJkyPJkhVRrDrNyjU=;
 b=YkolTAltivVhy9zQIN3Ljz2GoBmhzBKg/EvFQ0BX2GTNh7xImtYMGUYXcZGH8cuYVRzOHc
 B5JMxFzGa4ZCEAwBuU4SOuTD6MSZTtlqd6AvfJUMUE8lP80Ycjrf2FpQFngbb9T6jHga21
 G6WJwKplcR67TmRNxNpyJekGeahePUJA3URPDLNnKLtgMvk5pcvGS2ORHMri0WOppUN7JC
 DaWuHSVt89v5RxV8Vu2HAetjHhytzCoAZXjCst2QwHZ8+aD1Em+4K/YagIB7nAEZ/JKCIk
 Nrn+HQamGQDNGbnRp75Yef62jAr6QdJNOdjn8T5+iYUoxf2YWZzDm4+XrmATSA==
Message-ID: <173f12da-c201-4272-83a1-f70f2d4ca47b@mailbox.org>
Date: Thu, 18 Sep 2025 15:17:19 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] board: rzg2l: Do not expect a DTB blob from the TF-A.
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: anton.reding@landisgyr.com, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Tom Rini <trini@konsulko.com>, Paul Barker <paul@pbarker.dev>,
 Peng Fan <peng.fan@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 u-boot@lists.denx.de, Biju Das <biju.das.jz@bp.renesas.com>,
 Chris Paterson <Chris.Paterson2@renesas.com>
References: <20250918124827.5577-1-othacehe@gnu.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250918124827.5577-1-othacehe@gnu.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: actqggk3zzjrcgedik9fbh4ioih76agt
X-MBO-RS-ID: 4ed91f17c9fad9786c0
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

On 9/18/25 2:48 PM, Mathieu Othacehe wrote:
> On the RZG2L platform, the advised
> TF-A (https://github.com/renesas-rz/rzg_trusted-firmware-a/tree/v2.5/rzg2l)
> does not pass any DTB blob to U-Boot.
> 
> On the other hand, the RZG2L part of U-Boot expects a DTB to be passed.  It
> means that if one flashes the latest TF-A as well as the mainline U-Boot,
> it will crash trying to dereference the NULL DTB pointer before outputing
> anything, which is painful to debug.

This part is unexpected ...

[...]

> -int board_fit_config_name_match(const char *name)
> -{
> -	void *atf_fdt_blob = (void *)(rcar_atf_boot_args[1]);
> -
> -	if (fdt_magic(atf_fdt_blob) != FDT_MAGIC)
... because every function which handles such passed DT is testing its 
DT magic validity first. Is the magic actually valid in your fail case?

Also, enable CONFIG_DEBUG_UART in your U-Boot config, then you will get 
very early UART output capabilities, it works even before DT is used.
