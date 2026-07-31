Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A59C54F54
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 06:35:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CF78080F53;
	Fri, 31 Jul 2026 06:35:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x5ntxeMIXGPY; Fri, 31 Jul 2026 06:35:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 14CBA80F7F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785479733;
	bh=tau/Iss25QfCJ1FmpArkbIej1u+6v6LsjjDaJxpnnNI=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=klXnTph4Il8byDCudGDwu2uim0fdTDeFOclv9cJVIcxe1ioLUdbBI4Labj6up63qu
	 8VAd8dmKjU09tdr0Won/nL6T+z6ydxriMXx7H0IImDtUHovJM+zQYCogoYAiZOvMOz
	 8EgD9UEMq6usRwZ0dT0EhUUrJHzLFg5i+4wQVYqIdvrHaXphDpst6ktbLajM3QwbAX
	 ukHSkDNPbc8xT1PZUtVR5Al2TbOeTk8OB+8I1rmqxmKRm/CKZGMWCQcSlqdjm4OiZB
	 SG1ukg8EhZGYW//i/aFDHl+/BLCHeYt4UaGZdhQwno7dZkkHWnSx7OUNhQfB09TvEU
	 SeazbsWXxEdsg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 14CBA80F7F;
	Fri, 31 Jul 2026 06:35:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5120937F
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 06:35:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3656D80F0E
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 06:35:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h1bYe_UnCVCt for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 06:35:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=stefan.roese@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7921780F39
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7921780F39
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7921780F39
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 06:35:27 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hBGXX0Gf5zKw09;
 Fri, 31 Jul 2026 08:35:24 +0200 (CEST)
To: Chris Packham <judge.packham@gmail.com>, trini@konsulko.com,
 ilias.apalodimas@linaro.org
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] arm: mvebu: Add Allied Telesis x960 board
Date: Fri, 31 Jul 2026 08:35:16 +0200
Message-ID: <20260731063518.1915237-4-stefan.roese@mailbox.org>
In-Reply-To: <20260729081719.1074442-1-judge.packham@gmail.com>
References: <20260729081719.1074442-1-judge.packham@gmail.com>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: g8i4xsf8kb31chickeyh4wthw5hq8qpz
X-MBO-RS-ID: bec6acdfdd167663e8e
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785479724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tau/Iss25QfCJ1FmpArkbIej1u+6v6LsjjDaJxpnnNI=;
 b=q8fx4toT/yH+kJfWuTEvbCchbMkPcT54jTHWvgiJPHCZEBqmzpy6tyAJHG3nDRnddch6ra
 ecz/JbyTfY05tyH3qhPzWzwI6NTz8RLkzKUbD+Yr3rLlKpbX/2YZuASd8JWkyE1u+WEpEb
 hasp2YRgemB1GtloT3BiqqcYegR8A/kvl7Z73RmuMJKrKwSgCuA4Guzcu2T9JN3q1GEVfx
 YJuqy26IfgBE22mw4iQevknTdFvGSA4JBC+3y3LGlYKiXLMeAeoU3rXvk5vfJiDEF7R+qY
 D1T0+SAKQgE3U42Mpb72Nz4UUMxl8tudYjxjS9aOWfm9LelXoOdTABpPeFSajw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=q8fx4toT
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

On 7/29/26 20:17, Chris Packham wrote:

> The  x960-28YSQ is a 25G/100G layer 3 switch from Allied Telesis.
>
> Signed-off-by: Chris Packham <judge.packham@gmail.com>

Applied to u-boot-marvell/main

Thanks,
Stefan
