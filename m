Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63213C55167
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 06:35:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2602780F59;
	Fri, 31 Jul 2026 06:35:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hiwpLSPXvueM; Fri, 31 Jul 2026 06:35:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3182D80F3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785479730;
	bh=2aiHxHqK+ix0imJKZlm21GNtmf6MpTdw+BnFTkaoiRc=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Nf6UQ4rk/AQnbKpVN5njsTzVVbmjsa9r1PmsSMBISDmzBWLDXHSsRoPuP9uZsvwFn
	 sambNMlJCIYebHXyo1vPR8mJgWyu7ka3wv957eidyZTwZF9kirRoQtfojlmM2oawOX
	 Sey8BIWXV+GYjHitHjfYlod3ZvksE2W5TnTLOKqtzOsd1Irq6v2B/EodEc7nGPcji5
	 SaMv6oWblHYyt8xd4CFiYS+6xTS9x4uGtXCbNO3MCYHuotEmAoYvIRSUbbUY7+SZH1
	 tV0KKppXJK6PkKJkLcob6TFwwQPSQ/Jl6qeoXKEUdmpyckjEHqniakIpzQLIPJawpE
	 A6FdwrHnjNVhA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3182D80F3D;
	Fri, 31 Jul 2026 06:35:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 10CBA37F
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 06:35:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0266B6071E
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 06:35:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lr7lluu98k15 for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 06:35:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=stefan.roese@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D786960789
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D786960789
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D786960789
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 06:35:25 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hBGXT2hL7zMlKB;
 Fri, 31 Jul 2026 08:35:21 +0200 (CEST)
To: Quentin Schulz <foss+uboot@0leil.net>, Stefan Roese <sr@denx.de>,
 Gregory CLEMENT <gregory.clement@free-electrons.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ben Schneider <ben@bens.haus>
Subject: Re: [PATCH] arm64: a37xx: pinctrl: fix info->dev used but never set
Date: Fri, 31 Jul 2026 08:35:13 +0200
Message-ID: <20260731063518.1915237-1-stefan.roese@mailbox.org>
In-Reply-To: <20260625-pinctrl-armada-37xx-devm-v1-1-6850a91dd02a@cherry.de>
References: <20260625-pinctrl-armada-37xx-devm-v1-1-6850a91dd02a@cherry.de>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: a7afec2a553765198a3
X-MBO-RS-META: ttm1rc543c9mp4kkqxpizgpbawgj7emx
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785479721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2aiHxHqK+ix0imJKZlm21GNtmf6MpTdw+BnFTkaoiRc=;
 b=KujXH7jC87W4cdrbzMnkpdDMjFTmaK+W2lIOZnkvaSGiIHTFAvNN/d48WmQcLfiLGvD51U
 vGxHdnAewsIaWetvwAwvw8WO8I3M6A96XkhI/mWtLbEJ5Nil1VIivfUstDOWhoyP8qolvc
 C18328s7whzKs+CBQ7AmsVGbWohg4A8nUuCr715JTWRsKG3dyWSlFLno4SzrkIvrU9w0qw
 OIhp/GCG1o5+twFF7VtmlOLcvRYQ6mdhiOHbvPACty3K6q3CLzhM02Rd1sTJVL4WcsSSES
 220NdI+75VkXEc36XFc9WAM22/yRNmDy5787FA7T0waZ+nA0dBHqDFKVrtJa2w==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=KujXH7jC
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Stefan Roese via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Stefan Roese <stefan.roese@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 6/25/26 11:45, Quentin Schulz wrote:

> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> A bunch of code calls info->dev, mostly dev_* messages and devm_kzalloc.
>
> The former can be passed a NULL device and _dev_printk handles this just
> fine.
> The latter ignores the dev argument whenever !CONFIG_IS_ENABLED(DEVRES)
> which was true in most cases until we made CONFIG_DEVRES mandatory for
> U-Boot proper in commit 217cf656e249 ("dm: core: Default to using DEVRES
> outside of xPL"). Failing to set info->dev before it's used by
> devm_kzalloc results in crashes, therefore let's set info->dev before it
> can be used.
>
> Reported-by: Ben Schneider <ben@bens.haus>
> Closes: https://lore.kernel.org/u-boot/IRefanijM8fTzOXeGe-H5hmhRkm7pt4Q83BV6VcWKlWp0s4i8mYcONTQz-IVhvNWlGta4LtnfK7ti6gxlrqq8h8cotgG1S0Fs6_DviAHvyo=@bens.haus/
> Fixes: 0871806629b5 ("pinctrl: armada-37xx: Add pin controller support for Armada 37xx")
> Fixes: 217cf656e249 ("dm: core: Default to using DEVRES outside of xPL")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Applied to u-boot-marvell/main

Thanks,
Stefan
