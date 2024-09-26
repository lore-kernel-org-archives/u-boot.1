Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D71FCCF9E9
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 08:10:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F8DA88CFB;
	Thu, 26 Sep 2024 10:03:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="LodlYNpW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CBDD88DEF; Thu, 26 Sep 2024 10:03:34 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 951B788CFB
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 10:03:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5367ae52a01so878136e87.3
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 01:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727337809; x=1727942609; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=znlor91B2IZ8C7sZbCPoTy3JnLr5Yrwkd/pP2EeuZeY=;
 b=LodlYNpWmfDgsAfNScxIzAnKgOeWlDVn05yp0dxOb6hG1WYy2nOojOyk3r03jfwTU/
 lEpKg421+Gsr6E5OeozzIRUotfG2VKPOQtRDGvMXULWHWEhLwVYktkc3TPwXp7nhwkoO
 T6X4VnHwyTzCXaNQI8hA++9V4dXCVqZ28W5gnBw1PgKZlUWKBu6n0050uZ+IBXvFgT9v
 tGFQfGQf9Vgv+PMS4O2RzuxOllMG1kao3q+BlcWZp4blnqEC55v9L7uDAW6y4c+vcJ1b
 AbdfC76qSIdoy4YOjm2Xiz+M4mbEOf1jy9Es9veYJcwWWqP2a+Er9YDKbPWW/ySRz3mM
 4uAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727337809; x=1727942609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=znlor91B2IZ8C7sZbCPoTy3JnLr5Yrwkd/pP2EeuZeY=;
 b=EF9EOpyYbIlfeu21v2Xin9nkAVIZUwkhLTYgWv0Mw/qn5Ef6ZCi/xZxBMT9XY3YT2X
 276aJoO5fa3gnXvjCfVYEM+QoNHp/WMUU7gHL/zuw2Ta8cplTANdshGZhLxfykHGkuBn
 wrfNGwbyOCrAErvYOej7WPTcfOQYg0ebB5cQg8gvtbm81n5NZHG8nci+UfJ/b/csvU2a
 mn8ofnevZYrcQ9L/W0Ox7T3au4n1WtZNQIwWssrg9PI82xSSwfD57Gwe6M3QTvYac07Q
 /S+vHmQHRdTNJ5fSPvlNBP8Z/OyZx+7aPxjYc0UGDYRBFsKQnXqpseSIz1qxxZoso30V
 w/vw==
X-Gm-Message-State: AOJu0YypgdfLJ2Q8/S0dFuUMXN1rR0Cp7N8WWeJ6kt9REITgy3jGWrKr
 7hmV7o60DCTMN5zRWhmw+ruQLm34p53pYk9OCXjTVb6fuVAr/PuX0fDoXnrsIvLxy09DUd1Flx6
 tugg=
X-Google-Smtp-Source: AGHT+IHMIhmfgmAe3U5f3gtwB8rFxcu9T3slLbnMISPl7wAXDk4+febZ1nCXRiowbsDmc9/xOp8e9A==
X-Received: by 2002:a05:6512:158f:b0:536:5515:e9bc with SMTP id
 2adb3069b0e04-5387755eee8mr3414752e87.46.1727337808764; 
 Thu, 26 Sep 2024 01:03:28 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c5cf4c4fe3sm2822449a12.68.2024.09.26.01.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 01:03:27 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 31/36] armv8: cpu: Enable ACPI parking protocol
Date: Thu, 26 Sep 2024 09:59:19 +0200
Message-ID: <20240926080021.148031-32-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240926080021.148031-1-patrick.rudolph@9elements.com>
References: <20240926080021.148031-1-patrick.rudolph@9elements.com>
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

Update the generic entry point code to support the ACPI parking protocol.
The ACPI parking protocol can be used when PSCI is not available to bring
up secondary CPU cores.

When enabled secondary CPUs will enter U-Boot proper and spin in their own
4KiB reserved memory page, which also acts as mailbox with the OS to
release the CPU.

TEST: Boots all CPUs on qemu-system-aarch64 -machine raspi4b

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 arch/arm/cpu/armv8/start.S | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/cpu/armv8/start.S b/arch/arm/cpu/armv8/start.S
index 7461280261..544a4a5364 100644
--- a/arch/arm/cpu/armv8/start.S
+++ b/arch/arm/cpu/armv8/start.S
@@ -178,6 +178,18 @@ pie_fixup_done:
 	branch_if_master x0, master_cpu
 	b	spin_table_secondary_jump
 	/* never return */
+#elif defined(CONFIG_ACPI_PARKING_PROTOCOL) && !defined(CONFIG_SPL_BUILD)
+	branch_if_master x0, master_cpu
+	/*
+	 * Waits for ACPI parking protocol memory to be allocated and the spin-table
+	 * code to be written. Once ready the secondary CPUs will jump and spin in
+	 * their own 4KiB memory region, which is also used as mailbox, until released
+	 * by the OS.
+	 * The mechanism is similar to the DT enable-method = "spin-table", but works
+	 * with ACPI enabled platforms.
+	 */
+	b	acpi_pp_secondary_jump
+	/* never return */
 #elif defined(CONFIG_ARMV8_MULTIENTRY)
 	branch_if_master x0, master_cpu
 
-- 
2.46.0

