Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A6FCF45CF
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 21:09:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6083E8382A;
	Mon, 12 Jan 2026 22:09:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t0om2iPM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A6A6836C8; Mon, 12 Jan 2026 22:09:30 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20743836AC
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 22:09:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-459ac606f0bso4015645b6e.0
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 13:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768252161; x=1768856961; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=INaR+5WnSYDzdYR2pGFWGFtY+/+nOZGUbJiQw3NgXpM=;
 b=t0om2iPMvrUkE5bDrbtpgPgPFktCpRALvMxfLvRNKnOospzHZP/4pE0CAI3se4Kulb
 UH2nzZ+ga7EjQbuYy8OfvzgB04Hu4Sz4DgL4RZQI1vqUfnjM3dmxSD5aTnoTUJaG8Bsr
 o0BakZGx6KeY/sNZvbH6M8pVQ5f234C1FQo0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768252161; x=1768856961;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=INaR+5WnSYDzdYR2pGFWGFtY+/+nOZGUbJiQw3NgXpM=;
 b=ETLiKXnD5VArYBdZ1YpuUykFph+Wt8BrfqEvamSd7oZelMbQdbSAHDYjEr+9E4dIIm
 7WawJ+Ty4AqrYWHBt9zHbQR1kdxD/oSAXiWQN6u3xmvK4KQKmJhJxF+L52m3sSeUPXlH
 fLC3YbJvid7obppMVysIibXoxQ3ycoPt0yo82wW2tfmHMxBA90DyvVA6YZqhqsXfIZZ5
 DiWyzo7NvouBbCjSkqaQRFjrktW2SYKD7UUytRXjCPAAl1e1RViElfEjqO79yuKzmR62
 9rS3a9QjWsJZ6mrGnWLpJjf1V2Oylz2lbo1Buhr8V6rd1BO7ZrPGdvpoixfV2mqrkuMD
 UD1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1lHCyX1teEDotSwb0QPJp1EOwlcNtNbG22c5FvsusISlkr3Fat2DStMZuM7Q4yXARwpl64W4=@lists.denx.de
X-Gm-Message-State: AOJu0YyVBNdyKIiYqIkcHvX+eMLhc2sPZcNb1RlUy+aujpy0Xc6/ccUH
 hm4Ygm9U/eYw2HZ0wOgJsRuZ0X/3z1u6oTWaFj9vbz4ataCw/1hZB5Mpi6SUQ3u7KWE=
X-Gm-Gg: AY/fxX5nQpkc37outJKB2XUkVYgD2V4AE1swsQ3Nbf6gzcQdFWfNj0UJxbr9bCnpH6C
 GoYVRRBp+kPBFccmVrElVac5uZTbonv/rYMg/Z97GqT/ikFtxQLSZbASkeLUQdY25kHq4FYJx8f
 f6kYoC3B+5K2Sju7pO9tLNUv8p92cFS2J3xeHkv4Od8ujNgcSv+DOPF+SVly+6svg+lDf+SxdWS
 7nkrc/Qll2WpN/1PMo3OVQOJP0XuGKzUcN4fSD8gE+hbgidW7XZNOatpCJ2rvBsKKjc35bz9C03
 wTHGqU+ihkAR2XZQm/hPDESFCt9+WEtDlogmnW/3Arq3Keyg8XWYamj2pbKX1w0y7gkryP+k0Gt
 n7DUomn58A6EODcYJ2iiUrNqP1mgn9ZPZLQNNalX+Cr5r3M6Zkkva1xceupbyd247sXiMb05+xX
 hx2MNKBO4Zz3L4c11XBQlZZJAnL7RMk4ZjxqMuSr6pBw0YLCBB9mUcMfkOrc7bHiVTwxCn7/MCN
 jr6/Hf+HahO6F0AywO7nlRp10YP+513c0pNKg==
X-Google-Smtp-Source: AGHT+IH1joHfxUfqkMzzAyS3zHrUfo0lyFl7Rvc/dBVd95rOhQ4s7VgAsPhyzNB12UMmujlMLkvlcg==
X-Received: by 2002:a05:6808:1c06:b0:455:8b5b:c763 with SMTP id
 5614622812f47-45a6beeb423mr9564073b6e.67.1768252161196; 
 Mon, 12 Jan 2026 13:09:21 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45a5e17cd0esm8800789b6e.3.2026.01.12.13.09.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 13:09:20 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Julien Masson <jmasson@baylibre.com>, Lukasz Majewski <lukma@denx.de>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <20260107-clk-mtk-mt8365-fixes-v2-0-3294a5d2f239@baylibre.com>
References: <20260107-clk-mtk-mt8365-fixes-v2-0-3294a5d2f239@baylibre.com>
Subject: Re: [PATCH v2 0/9] clk: mediatek: mt8365: fix clocks
Message-Id: <176825216019.1883046.3207468706211029212.b4-ty@konsulko.com>
Date: Mon, 12 Jan 2026 15:09:20 -0600
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

On Wed, 07 Jan 2026 10:21:06 -0600, David Lechner wrote:

> There were a number of bugs in the clock definitions for the mt8365
> clock drivers. This series aims to fix the obvious issues.
> 
> This builds on [1] that implements the clk dump command to inspect the
> clock trees at runtime. Using that revealed quite a few mistakes in
> the clock definitions.
> 
> [...]

Applied to u-boot/master, thanks!

[1/9] mt8365_evk_defconfig: enable clk command
      commit: 488c396e711aa3821896242ae5742195a535fe2f
[2/9] clk: mediatek: mt8365: fix missing and out of order clocks
      commit: 32087f61adae56e9e23d80f82567dbb6ce3e8e54
[3/9] clk: mediatek: add separate gates_offs for cg gates
      commit: a694df199a4246036497447479bc08c6c4c09534
[4/9] clk: mediatek: fix fixed clock parents
      commit: 9e84e145e37ec64f5e2aecefe40ab977f10ba8a0
[5/9] clk: mediatek: mt8365: fix some clock parents
      commit: 72f56becc003f9cad9e15c5174ba29fcd793c6bc
[6/9] clk: mediatek: mt8365: split struct mtk_clk_tree
      commit: 4cc0f1b31857d57a980ac16f626ddb57bc3a5610
[7/9] clk: mediatek: allow gates in topckgen drivers
      commit: 8aeeeff50d467bb63209ff727823dd1c15caf62c
[8/9] clk: mediatek: mt8365: remove separate topckgen-cg driver
      commit: ba207d7f54f97c447053d634f8da7b66f222af9e
[9/9] clk: mediatek: mt8365: fix missing topckgen IDs
      commit: 682528df206b0fd6a7239815b57cd151bc895695
-- 
Tom


