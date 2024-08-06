Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A769C3DA64
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 04:40:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54C9188A12;
	Tue,  6 Aug 2024 06:39:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CN+KkLc2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42A2A889F8; Tue,  6 Aug 2024 06:39:27 +0200 (CEST)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22C018898E
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 06:39:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-75a6c290528so69513a12.1
 for <u-boot@lists.denx.de>; Mon, 05 Aug 2024 21:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722919163; x=1723523963; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zm+lewJzulVV0Jb7pfNAsttbE//2ARpPeBbMmvNfcN0=;
 b=CN+KkLc2Z1zjiNBv5nWuQCkG/CVSjBVuonrZ+GDQGsFxDWq8SUw7jxUg5pDnl6hPi8
 p0nPZjcfaVh5jFk/ZYd8o39ysAcDp3mz0fC3wHJnHADb9Gka8QzJBkGlcVM4T7RlswRF
 nt5pkB4ttpj6t7tgQkLvY2BRH6c+a/eM2U77D7Ur2gu+5BYbD5AbEDFJMsmrUzGbJKT9
 XORQBPbBkmqunvdq0TbEpxAi3a0MCO5wqn/CavxiQ3wTVLs8m1JuJbyseB7/klDqwPFQ
 dXtSAAlJt6+VgreLtdO2/hjtM0avnpbRSwQDPXuZh+YBzd+a0Ft8fIo/EhEbKFj9JLJi
 tJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722919163; x=1723523963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zm+lewJzulVV0Jb7pfNAsttbE//2ARpPeBbMmvNfcN0=;
 b=T5bccybTAZ+3j1Q/iE9w0jHg/xMW+ozTBkuvuTZPN7YrqRCxro3VrAdSpdybceOjJ9
 qucPC5WgGZIiiInVI4osnY0fwqHSrj/XU5O5rnttC0BL6OHIexrw/xF+3/0WfCqyBxvq
 PmMK9XePea5OTkbCFoYAyMrK6/huB4Y5rVDT4+KUlnSLqcmapCHbw4jsjg1UHYH4XL1a
 LgAVsySpDk0IpoRfiPUbbmo7lu/jekfjvYbOh/uIDFt/9zjzdpP2PoQjqc2ApJRlFjeu
 E8gSP6eYshF/T6IJFNRmNS+/Pr5FPnIQJeZFzN9ksVR1t8GQtd7gx9soy4ImhZAux6IJ
 eRNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVqJyhdvkyGEGnnkOFrpVQvef+OrRhCZRntisx37vNqf+Aw1nVappcMlLmN0YUhpvY+H3vGt2MvXmbaKcyQlp/uHKhZg==
X-Gm-Message-State: AOJu0Yz3jcrUFkosUp6SlzHPowL0fOWT5s3lSHHcQ7O+NlhbFY1lERB3
 mLrMSB4+dIZrOrwsDnidgqict9K60Y9kcvmvUTjYBX9+3T+Xomf3
X-Google-Smtp-Source: AGHT+IH2f42mxjoVHoZ8mVm9qfyDA0yFsMz54yvNPfvf9QkYmSzRCOguh3u2n8F4MxKR9/jW23YmJg==
X-Received: by 2002:a05:6a20:a9a9:b0:1c4:87b2:e069 with SMTP id
 adf61e73a8af0-1c69965b000mr10271078637.36.1722919163453; 
 Mon, 05 Aug 2024 21:39:23 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20077164e0esm5823485ad.185.2024.08.05.21.39.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 21:39:23 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v1 07/12] arch: rockchip: rk3368: Update syscon driver binding
 method
Date: Tue,  6 Aug 2024 04:38:44 +0000
Message-ID: <20240806043849.3607-8-linux.amoon@gmail.com>
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
 arch/arm/mach-rockchip/rk3368/syscon_rk3368.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-rockchip/rk3368/syscon_rk3368.c b/arch/arm/mach-rockchip/rk3368/syscon_rk3368.c
index 7389c028364..89caa6c310c 100644
--- a/arch/arm/mach-rockchip/rk3368/syscon_rk3368.c
+++ b/arch/arm/mach-rockchip/rk3368/syscon_rk3368.c
@@ -25,6 +25,9 @@ static const struct udevice_id rk3368_syscon_ids[] = {
 U_BOOT_DRIVER(syscon_rk3368) = {
 	.name = "rk3368_syscon",
 	.id = UCLASS_SYSCON,
+#if CONFIG_IS_ENABLED(OF_REAL)
+	.bind = dm_scan_fdt_dev,
+#endif
 	.of_match = rk3368_syscon_ids,
 };
 
-- 
2.46.0

