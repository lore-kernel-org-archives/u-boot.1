Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE26C49EA1
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 04:40:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 616E9889BE;
	Tue,  6 Aug 2024 06:39:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BGa0bUJY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D16A889BB; Tue,  6 Aug 2024 06:39:21 +0200 (CEST)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 705FD8898E
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 06:39:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7a103ac7be3so142069a12.3
 for <u-boot@lists.denx.de>; Mon, 05 Aug 2024 21:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722919158; x=1723523958; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jf/b6iiVz/UaBb6ZBEUBNk3d6OpI3PR+OhPNq5FDTRE=;
 b=BGa0bUJYzHKfVQlTOjQrlmlXc+X4OLn3r37Cw3luYudMgIZv72VCVjLW+aPyyBnJ1A
 NDNblDXmUJFWfMxFlJQCgWGKfur8W2VRxqNFeUDfI3r/7+wOje+FASU/f5VrSccVJJ0a
 2qpVac1ekFsLItQNbslO1vsdPhioa8Cw8yqh0OVEwgwpSii6RLWpJg6hQsCpupVdYW5K
 sB2nU6emNlMAApimbkFzkqUk8Sjyov0343p/5EMGHnBRUM5MgcOuvZBPR00Zz3l+aQpW
 JR0dDBHGbeSGnb4qqY9ZTsdP+UQCDcwDXuuMOoPT71asd5aWyD9eHOfl7wMK56O6lbKX
 mYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722919158; x=1723523958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jf/b6iiVz/UaBb6ZBEUBNk3d6OpI3PR+OhPNq5FDTRE=;
 b=v+Any8Ov0pVK2LshQ19f74r1Wp+3bsOInmp4eRwROL46oEY9TfMU+fSLYgTsVaWop+
 0PAd6WViJgbrPD2/xzagaUC4WvOVxgKX4zXNRit+GcirjHdZ+yZdn5AWD78f2DfjyTj8
 jhDfUnUI1GXt3zhZuJ65JXI6O+RHsICjumprlqjA6wj39b1sa9ybrczlNXGUhxyFP9l2
 Fww4YVq2qCkP4oWgzz0yUszUfgIe28wlVoC/WYH5n+VQTTD+BlWO+9BAkIAqkoa+PZ0N
 uJoFh6dbs0wMc3RchTHsujU6KmsCX8rBaZA/I+7HiuMWZ266ZSj42ILA/N6FF1PVJ2GX
 h9sQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMfVT7m4qu/c015PHn1DnLMOO6gJclQ/LDQ8MFbdYDPfgEq2sH0fTGXxsB/svCzPV8YZUNnY1/zZIsi0bA5KCkRCc1Og==
X-Gm-Message-State: AOJu0YzitidHekxTmY6nGtz+hiUIIO16s7YQ6y462v14Bcduf7M0gPkq
 j+906ZhdYErvFeu9G7lQIAnQeIXoKoWSaeb3pAup5UJMU5cQ+9y+
X-Google-Smtp-Source: AGHT+IFI/ycXybbHs7syvhQ/MdfibP+qIejJVXO3ScKooVOWsAnTXeV54tQ5/kuzsH8+rMPr0vzjSw==
X-Received: by 2002:a05:6a20:2589:b0:1c4:b302:ad14 with SMTP id
 adf61e73a8af0-1c6995856d0mr15192275637.24.1722919157627; 
 Mon, 05 Aug 2024 21:39:17 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20077164e0esm5823485ad.185.2024.08.05.21.39.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 21:39:17 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v1 05/12] arch: rockchip: rk3066: Update syscon driver binding
 method
Date: Tue,  6 Aug 2024 04:38:42 +0000
Message-ID: <20240806043849.3607-6-linux.amoon@gmail.com>
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
 arch/arm/mach-rockchip/rk3066/syscon_rk3066.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-rockchip/rk3066/syscon_rk3066.c b/arch/arm/mach-rockchip/rk3066/syscon_rk3066.c
index ff269b53b54..4e13aeca03e 100644
--- a/arch/arm/mach-rockchip/rk3066/syscon_rk3066.c
+++ b/arch/arm/mach-rockchip/rk3066/syscon_rk3066.c
@@ -19,6 +19,9 @@ static const struct udevice_id rk3066_syscon_ids[] = {
 U_BOOT_DRIVER(syscon_rk3066) = {
 	.name = "rk3066_syscon",
 	.id = UCLASS_SYSCON,
+#if CONFIG_IS_ENABLED(OF_REAL)
+	.bind = dm_scan_fdt_dev,
+#endif
 	.of_match = rk3066_syscon_ids,
 };
 
-- 
2.46.0

