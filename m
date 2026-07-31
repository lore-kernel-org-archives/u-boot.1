Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A2DC54F54
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 06:35:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B37C880F41;
	Fri, 31 Jul 2026 06:35:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pFKrGkOVVBpi; Fri, 31 Jul 2026 06:35:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 18E1880F18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785479727;
	bh=WKbajsAeuKhQbQcYl2xtGOF+xwe6SfqHFZQa7KU6mGY=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=xL4DVNBijQ0+teukjoJx/rbns9QTtYtFt0g/iiNgCYXyO44+36x8Ehx52QVk0ntXm
	 92jFCu1uoVvbo1OAZnlKBhHw/7RKHEQHh1w7Cnto0fib+dFIPcdCMhL6Ypw4En2zUs
	 gOH9XbJf/7RsYme0uXbHae4vAR/1CnBKRWCJvJkaTj2X+MVh4DiKuMGsh6JTPoHf2A
	 4s4Su12ki0/vh6X45ttRt9R/lmSCdsbwfX35XpUONNejm0HbHzDPUp5gaaZbEilSHs
	 dTSbdd2S5v3+uGq0JggvVPlZl0Wrk1Al6f8+xlkwqL6pVcC+efwmiavbPGIxboNVHR
	 mqt5wcCae7ghw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 18E1880F18;
	Fri, 31 Jul 2026 06:35:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 78A33218
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 06:35:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6A3B7607A2
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 06:35:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PNQ9d-t3Vt2K for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 06:35:25 +0000 (UTC)
X-Greylist: delayed 41825 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 31 Jul 2026 06:35:25 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 50B3E6071E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 50B3E6071E
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=stefan.roese@mailbox.org;
 receiver=<UNKNOWN> 
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 50B3E6071E
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 06:35:25 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hBGXV16lnz8t4y;
 Fri, 31 Jul 2026 08:35:22 +0200 (CEST)
To: Chris Packham <judge.packham@gmail.com>, trini@konsulko.com,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] arm: mach-mvebu: Add more AC3 & PC3 variants
Date: Fri, 31 Jul 2026 08:35:14 +0200
Message-ID: <20260731063518.1915237-2-stefan.roese@mailbox.org>
In-Reply-To: <20260626071156.3129812-1-judge.packham@gmail.com>
References: <20260626071156.3129812-1-judge.packham@gmail.com>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: nqhnmfijr6th41bt36nkygersjpapg7q
X-MBO-RS-ID: b57518b43082bfc31ba
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785479722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WKbajsAeuKhQbQcYl2xtGOF+xwe6SfqHFZQa7KU6mGY=;
 b=nJbw8p8GvXjjY1p0FMcRFa361OjF1nwD3CiptbskQQX5M0rnrRLnofw4C208gsrBf79wQb
 O1wCfuYqS8k6vM1oD/6omH7taM6yrQXcYeTNlukMzT0+8iyrzE2w9UXRTMKbundr1CmipG
 uchCugMh2XuR6aTdYG43kKyPPLTxyPPg1OtS3hRuMP9iOkq9DDsO8KgWxRISbW7xQVZy0w
 vJv4+4Q4EzZh5sRnDtyBH63i0Ns9rUJwkn5AMXbSRk5/OdBENG8amSvMUawN3S9llAEcko
 H/xwl8UG5zzC/qfX/sSgAzMKfTToHXHPrmcoErarRdMBbG+kzDxEs8oOh9vtFw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=nJbw8p8G
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

On 6/26/26 19:11, Chris Packham wrote:

> Add IDs for more of the Alleycat3 and Poncat3 variants. This makes the
> SoC information at boot say something other than "Unknown-??".
>
> Signed-off-by: Chris Packham <judge.packham@gmail.com>

Applied to u-boot-marvell/main

Thanks,
Stefan
