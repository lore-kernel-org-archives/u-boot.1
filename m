Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F40A8C5DF97
	for <u-boot@archiver.kernel.org>; Sat, 22 Aug 2026 15:22:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B9B7980F75;
	Sat, 22 Aug 2026 15:22:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ypn8JhMNJVhN; Sat, 22 Aug 2026 15:21:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787412119;
	bh=vE+rPoX1JypIEJhnugEfBc9n4hMQLgAUMuGr+lAObqA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wdhkDou9UnF38PGgSYju6MnL0mpHFrYRdo3BFFtRDp3beyGMsDiNflpWrBTYhlCSo
	 UoFUi7O0pr5FGpkBrV25tI0O5mILdtuFj2+W0DlA8+UoAwtxj45RUeqD1hJ+HsIXLb
	 /cHAmlaw+Og05HGSJBGojC26EQJVEcoSkTAcjjuAGCxzaULJR0TC+Sp/Y70owTN97Y
	 cOwVKFjhwbNydWcq+sNJzeh8vOl6ZYx6PUiiVZcaiSj5BVTgPLMmKrtK4WTTczfXe+
	 QTbbSAbJofWtJyuiaf0qoFXFDsP30Jb+Q15dRcApr40EuLorsCTR0xFF1v8SKOQSMD
	 jh/ldbKaBxyjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7261780FB3;
	Sat, 22 Aug 2026 15:21:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C50EA336
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 15:21:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AB10A4083B
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 15:21:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1Uiiqmzdm8MM for <u-boot@lists.u-boot-project.org>;
 Sat, 22 Aug 2026 15:21:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::235; helo=mail-oi1-x235.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=tClHvHHa
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A228040825
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 15:21:50 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-4af7283bf83so1313504b6e.3
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 08:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787412109; x=1788016909;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vE+rPoX1JypIEJhnugEfBc9n4hMQLgAUMuGr+lAObqA=;
 b=tClHvHHaRcVxnbsJ+cdgbZ33vsoht8KxdZwOruN/h0mLubcTj6epR5EAYsnGApE7Qj
 LTAejKQrdzNewnhRGxC/uRduX7j8uHtRAVHQTbDJFE1AFJPnkLqXWUIwmtYzYhPubJ7E
 K0FmZxdpNM533cnRg/HKD1jnoFOKtHwXUYgv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787412109; x=1788016909;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vE+rPoX1JypIEJhnugEfBc9n4hMQLgAUMuGr+lAObqA=;
 b=tMqbO+nvYmX2DfKpVcoqZWUSavRzcy/123+PO8QMPg/srnuu76KiCMbg3MfsOqc/FV
 w3dM6ANsQmFOMKMfvZ9kUVskohW2diPMbEtcCA8C5dPSUzAxoAorJfLndgXA/n7uCPMS
 F+D2z2Gb3vlkGQdE3hm5wH4VLRvfvtez+ogaIhv30eeyFfyeYQkqKquoOErpk7yEUj6p
 jYrYY47DGEE00i/GCKCdFgQPm9HazOSp//K7EOgzXcoSLDrUgoE+MyKHUaNhk+yXqvLC
 j9wjCcQTah/183PoVYpzPuqjxWQZpeHjuukRCtiyMTDvZncjpVp1m7raQUEuvTSXM5S/
 K4gw==
X-Gm-Message-State: AFuF++kGNxsv+FPyhItueGbLodbIPLQGZ9MStUIjsR4ADS2Ccs8izoCA
 v7TX//oZLmFsjk6EZ4yVqQKcaTkw+OpqNfEaFeMyI2/7yOMhiKcD7zwZioZdFM6hgFY=
X-Gm-Gg: AR+sD12b1sQ8BIW5sCTO0ylvis6by7RxW1cPC9mTqYirG7m5RD9iDrV5kEuDosROFyn
 +qG0RNS8N1DZidZsg6RXocW/Bmt4EtgiLCM1pupKJmzTTpRP8GDF/vGd63Nm1/qa8PjpsIwj25l
 uoC43szxUBk0soND0fw0OW7NIWyVkhnMO2WYrEPpx1ZyVtTsbcqf1rgPV//0Pnw23RADeJiWJv8
 xWpx9J3Kp9uyc+Gp29EiE4lZ7JKf5snFdGMtMmuC4EWM5X1HMCLHl1xG7GPRmfEW495RIG9wF+o
 sFWUQd2nUUwNks6Ig142FbU7hXdVl594O67idmLjiOYrqz6aGIs2resKW6YwRwQAL3tyQTbwk09
 1c/NLT2g27Rj0owKCvYVe00PrEefvrwhJuOWW3DJEJbqBeCaZ+d1QInQWcc9LVZlyR9lGX/1OGk
 gDMm4v+wTEa7jQu6Xh0y8u6hurCTuERl4mUXBYaxXb48LZHeRPluezkORmlLgYd5/zDOKW8vpT1
 rWE/q/OfMpi4RW9bw04VDONv27iDB+oYjvOLe7Y0sTe6rTH1ddg99r3bPBAWaOVhzXJ09YzgEfG
 wPKU2Y0q
X-Received: by 2002:a05:6808:1922:b0:497:df42:1dff with SMTP id
 5614622812f47-4b3099ff989mr8359312b6e.1.1787412108956; 
 Sat, 22 Aug 2026 08:21:48 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2d6cdd6cbsm7345983b6e.10.2026.08.22.08.21.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 08:21:48 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Franz Schnyder <fra.schnyder@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Fabio Estevam <festevam@gmail.com>, 
 Franz Schnyder <franz.schnyder@toradex.com>
In-Reply-To: <20260814-get-rid-pid4-table-v1-0-b8605ac094d0@toradex.com>
References: <20260814-get-rid-pid4-table-v1-0-b8605ac094d0@toradex.com>
Subject: Re: [PATCH 0/8] toradex: Decouple from Toradex product ID table
Message-Id: <178741210779.4158046.3012905168019230271.b4-ty@konsulko.com>
Date: Sat, 22 Aug 2026 09:21:47 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Fri, 14 Aug 2026 13:21:15 +0200, Franz Schnyder wrote:

> The sysinfo currently uses the Toradex product ID table to print a
> detailed board model string. With various new SoMs that are released by
> Toradex, the PID table grows and needs maintenance effort which can be
> avoided.
> 
> Rather than printing the board model based on the PID table, rely on
> the model property of the device tree and the data written to the config
> block during manufacturing, which already describes the HW correctly.
> 
> [...]

Applied to u-boot/next, thanks!

[1/8] toradex: verdin-am62: Set WiFI DTB as default for new PIDs
      commit: 83a35efca58c12b2f7686970b42071cd7c1a720f
[2/8] toradex: verdin-am62p: Set WiFi DTB as default for new PIDs
      commit: 54efe43bf87398996574fd49bcff837f464c4b9b
[3/8] toradex: verdin-imx95: Set WiFi DTB as default for new PIDs
      commit: 951f0d802a9b6896079119430e967671a2bcaf55
[4/8] toradex: verdin-imx8mp: Set WiFi DTB as default for new PIDs
      commit: 330d967aab8dea0c22030036ba0017759f45886c
[5/8] toradex: verdin-imx8mm: Set WiFi DTB as default for new PIDs
      commit: 0d95b64ceb466f85ce5c72e6513e79cf3cab936b
[6/8] toradex: common: Decouple board sysinfo from the product ID table
      commit: c19981ab9acb50c987211b1f28c3fb9681a85bed
[7/8] toradex: tdx-cfg-block: Remove validation against PID table
      commit: 073d55b2ad7900c31d039cda70ef1fb1292a6593
[8/8] toradex: tdx-cfg-block: Remove product ID limitation
      commit: 7239c5a6b5e4d24803b4a71ad8c0402a5de75f55
-- 
Tom


