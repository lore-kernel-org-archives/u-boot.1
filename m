Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A58C3DA64
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 04:40:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14558889BA;
	Tue,  6 Aug 2024 06:39:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mHHOIsOc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 471BC88A0C; Tue,  6 Aug 2024 06:39:33 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 270B2889EB
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 06:39:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1fdd6d81812so1233015ad.1
 for <u-boot@lists.denx.de>; Mon, 05 Aug 2024 21:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722919169; x=1723523969; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2PanVgp+C4VZ55RyPX0AQuUyYeWg3odMdo/uDoZc1e8=;
 b=mHHOIsOcdGN0LDRAWH/jE/N14YTuRvn/en/nDgy3HwmQI6xyE76FQTlr/fDvdMKm9E
 nJ7xC4pgvuIkitH3CFB2Ncl260x5IdsHWDQavlAUOEn9gQYa+jwxUY47YW4dllvGCmeF
 nWUT7PQxVfj/vhAIh4MJ/hemeY76r7Xp2tKburqPY22TbJabbkeMJ8IHwM8i+3RBygqN
 uKE5ZYXiQ0VzUnD3qpF/npvFv8AWm4IFt4JjQ6cq1UZUyUegC4e4fTZwlth1TFZPJfft
 PcwXuRsUmbwbRZZ0tbP9R4BUSeI6OgBpasw0IBkuJTG96LkcOrkBiIORgSlzrY7/IYBo
 hiPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722919169; x=1723523969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2PanVgp+C4VZ55RyPX0AQuUyYeWg3odMdo/uDoZc1e8=;
 b=GWc3+TbUhZOk+3t010BJVUlk/DsNPOk5LsnuFoe2h6aPlx9wUCpfcNLe8un03WsTat
 CQoCwq8dkQJ5O4lTUeuOFaTipfQcKLCCAvRPd9An5HdXvJ4ZxSBCwcJytOrPehZC23U4
 xqf94T+FVSlu6Sj5DJuHuBNHAEHWj8mPUdXa8upi83jgDrtvfrm46C8Z2ybRq7gcSJdA
 S9Z7qv8BPsiJnNppSujkYNWFu3Ut2LViArEKiYQvdnMQPP4AnJjCmKY8Uz/UJ5KYfiZ0
 n7xqy5X9aEtmp7xNW4mzy2nsO5Ne3Oj4FujbaG0we5DSU4PlXGb0BAWiOerWOdSpFKF3
 bEUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnMA4UoUJgfAJ78uC7pI8jcDkykNbgDaZz4UjSvV/HBKbkO9Ul0IW/J5tDFFHwwIJ+8LJEVcEhCWPtxtIBbljApymKOg==
X-Gm-Message-State: AOJu0Yxx+TzPhAVTpYHknXa06YhH6oSZCxoBpFTXXZZ9AXp3YwCAztKQ
 GQoFKrSvQkJW7jD5X5dUO3vEchNCt4CT466FoMlbr8Dw1rSOD5lB
X-Google-Smtp-Source: AGHT+IGqjAuRKUe69OVGIhijhkvSooBYD1bWWqqBcW5ciAd5NDBSRF92i6xnAqBnh9u7SJESQyr99g==
X-Received: by 2002:a17:903:1251:b0:1fb:98db:ad5f with SMTP id
 d9443c01a7336-1ff5722de68mr180794945ad.5.1722919169181; 
 Mon, 05 Aug 2024 21:39:29 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20077164e0esm5823485ad.185.2024.08.05.21.39.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 21:39:28 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v1 09/12] arch: rockchip: rk3188: Update syscon driver binding
 method
Date: Tue,  6 Aug 2024 04:38:46 +0000
Message-ID: <20240806043849.3607-10-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240806043849.3607-1-linux.amoon@gmail.com>
References: <20240806043849.3607-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Updated the binding method to use `dm_scan_fdt_dev` when
OF_REAL` is enabled.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/mach-rockchip/rk3188/syscon_rk3188.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-rockchip/rk3188/syscon_rk3188.c b/arch/arm/mach-rockchip/rk3188/syscon_rk3188.c
index 6df054e5b27..bcd7870c503 100644
--- a/arch/arm/mach-rockchip/rk3188/syscon_rk3188.c
+++ b/arch/arm/mach-rockchip/rk3188/syscon_rk3188.c
@@ -19,6 +19,9 @@ static const struct udevice_id rk3188_syscon_ids[] = {
 U_BOOT_DRIVER(syscon_rk3188) = {
 	.name = "rk3188_syscon",
 	.id = UCLASS_SYSCON,
+#if CONFIG_IS_ENABLED(OF_REAL)
+	.bind = dm_scan_fdt_dev,
+#endif
 	.of_match = rk3188_syscon_ids,
 };
 
-- 
2.46.0

