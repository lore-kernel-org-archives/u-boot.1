Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4609CF45CF
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 21:09:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F085838A0;
	Mon, 12 Jan 2026 22:09:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ojbgzqql";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 334D383759; Mon, 12 Jan 2026 22:09:30 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F5E1836A3
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 22:09:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-455dc1cf59aso4160628b6e.0
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 13:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768252160; x=1768856960; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8/pw7GZlzU0gZfUwLlWe391SmummDdXXsORivpFzFPQ=;
 b=ojbgzqqldDz3ap476f/SUtnNWu3VPipGPQBU5fKgo2ALzs5BIyn6o2fmQ2b/E0E1ld
 vZvgrpnshPlG6UtZQYTfAveMC8MGS5WKz89PCIs3KNLaLNjUXRw9OTZcG+Qnvmb3YYsI
 Rin4MzkCxpwKstioTxbCpEHS2Zp3H+xbxHtyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768252160; x=1768856960;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8/pw7GZlzU0gZfUwLlWe391SmummDdXXsORivpFzFPQ=;
 b=UzMvKmAvmMErElVH9htx4e+NcQviA7pstrPTWwPl16G4t8THdmwtHp53hlLI/qgjNe
 fYrt6Minxe7ZYBBLkMjmUizyEpUqtYAp0zWIEoL3tyLxMhQ7HBGbxk4prvUA+SFH3ojv
 QjNwwqfbur82A86rvvGG/BCoSEIFDbGClaQ4mQJSUP3BBNJftWoXdEHN/80dA9bHUCvy
 C8WqtEWYIFdeQUvUDFXm0ohD5LELiiL7j8dympxLrfZQ5eEH+W9aSThymyxbIItjVcyO
 1CYf3BiW1mx5G8hmWQlA3DmDJ+slbGEyEkkiec2R4cBJm7wN0So9lT1Wf2WjlXdXGuGv
 nEdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXz9PriifqBhQ+VIlIOokPOft+jjV2RsmT9XjyUCPFtfXz/6nt4hYCvKmFcyOjq9Aki5fC/WkI=@lists.denx.de
X-Gm-Message-State: AOJu0YyEUFZlr8N6kEf7LeYizm3D+CLelM1WX9CQyH8Q/PgkbPYZwIUV
 PETrmO/5fCQYr3XFNfwcTenh6hmq2FcCMXtdRlVRv1c+zSZte7tCWr1o+w34rwKqScA=
X-Gm-Gg: AY/fxX7JvzgX7fYtCbJFKBeYEBm4mlCujQmCfslT489nOKkTuUYJFx6vzAK4f3HfG/k
 zgfYqCOCWshLUop3tcakysyzVWJBe0PYTTnB6Lh+HZEiKjniQKCAb76NyJi2kcb+rv1SAHRObl5
 YXks/CYRnNbdB7S47WujMKkSV0Fd2rjAYBgwUm/VB5ALccBVsWpplMEpuwVgQjlzS8JIg4+7YEq
 gE0sI9/lqHLSXCA3HdaiXGIXVMU5VlAbNRId6PnbU+na498FmAlEavFI1I8GW9D3yUWSOqGngst
 zoZgoMnUyVwk0IG3bwZWyX5+ePx+9L/ofHSYDXDDzSVYudaXAcnkXAcWRNeUg1KMeOLW2sXUP6F
 QLLIke9wjSVIUODuMLVAEpZLlCqR08OpiCXBGkKsZ7nbl+WBGMCfstq4i50D64hhH7z28BoiERz
 Sn58N/b6fZbj1GgeRdQYAqSMRrfxxqfibFC1xkh2UQxEM5SP5B0Bhg2mf/wjKtl70Sa6P/cMLUL
 UaRjU5zTZOxeSkqClwS3fp3bNTv1xhD/WE21g==
X-Google-Smtp-Source: AGHT+IGzzbTOEaljW+bnDmRYoZAmvOglFsogi1MKYzom9G8HsaFnfAdSvCB1EpeVesxuU752MvXmHw==
X-Received: by 2002:a05:6808:4fe4:b0:44d:a570:bc24 with SMTP id
 5614622812f47-45a6bcc9b08mr9573851b6e.9.1768252160060; 
 Mon, 12 Jan 2026 13:09:20 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45a5e17cd0esm8800789b6e.3.2026.01.12.13.09.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 13:09:19 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20260107-clk-mtk-improvements-v2-0-7d4338e520a1@baylibre.com>
References: <20260107-clk-mtk-improvements-v2-0-7d4338e520a1@baylibre.com>
Subject: Re: [PATCH v2 0/8] clk: mediatek: implement of_xlate and dump
Message-Id: <176825215864.1883046.3486262205594859871.b4-ty@konsulko.com>
Date: Mon, 12 Jan 2026 15:09:18 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 07 Jan 2026 09:50:10 -0600, David Lechner wrote:

> I started looking into fixing some bugs in the mt8365 clock driver and
> realized that there was no way to inspect or debug the clock trees.
> 
> I set out to implement the dump function to help with this. The driver
> architecture didn't make this easy since there was no way to know the
> number of elements in each of the clock arrays. The first few patches
> in this series are adding fields to the data structures to hold this
> information.
> 
> [...]

Applied to u-boot/master, thanks!

[1/8] clk: mediatek: add array size fields to clk trees
      commit: 3d54f47ae50b737e4f577ab2d41df51f67e975ed
[2/8] clk: mediatek: add array size fields to cg gates
      commit: 538f72f4038652be5bbb907f23fbc74dad682a19
[3/8] clk: mediatek: add array size field for id_offs_map
      commit: 6094f0a040765932dd7820941fd77e25c6dd4e34
[4/8] clk: mediatek: organize infrasys functions
      commit: 159825bdd5ec63cd443c855adeceb3adf29e4655
[5/8] clk: mediatek: add of_xlate ops
      commit: b1358915728b9c38c0d8c4ef11a3a6f5ab5687bb
[6/8] clk: mediatek: clarify mapped vs. unmapped ID
      commit: cc1a458a3d315bd94ed2b5faf7e74baf8f667d9b
[7/8] clk: mediatek: mt7623: set unmapped IDs to -1
      commit: eb2bf2bc832d34440204ad90795ca7475ede4402
[8/8] clk: mediatek: implement dump callbacks
      commit: c8ebe42b3f5f753f2c84266e289a31e85e257110
-- 
Tom


