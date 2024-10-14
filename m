Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F81D16260
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 13:18:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B88618915C;
	Mon, 14 Oct 2024 15:13:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="XwwJ3f6p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E629B89063; Mon, 14 Oct 2024 15:13:09 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2F248918A
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 15:13:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-37d4ac91d97so3702167f8f.2
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 06:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1728911584; x=1729516384; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aQ3fiwac6368tQvYZ51DF5qc0QaxNfwumSk8n6WYLF4=;
 b=XwwJ3f6pOa4KIMyXPxrbGw5UO2BSNdaG7WHdv7d1Kr/W0UpTzEL0ZAxYjCcFmtub3V
 I6VxtQv2o89KpDI+62zJ/jGD9ZBZqhcBx0BioOkLixUY1OJMcI7gS2/29QXB/cxxkLDt
 cD0Gpp8IjZufcUSxx5ZzrGhn6EMB8rd07xU9qt72Tk3fa3ASVWyot60QUEiiOyed4jS0
 4hHMjvFjeqk4UnmNMLqeAOEqJJ7ytnGed2YFz6TPvYqLKvlN7E5mAqRH99hOkqbHCfNd
 skCKSZU43KAy9i6p/hioszBBaOvqns7z1BJkqlY6640+HKuCUDTDvLdoEZDzqcSAFVcO
 A8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728911584; x=1729516384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aQ3fiwac6368tQvYZ51DF5qc0QaxNfwumSk8n6WYLF4=;
 b=M0wa7utuVfMMWeXybFvcS1JkVbBDNSawyBq8k3zk8xBELmzxqH03qqwEiSHi0oqlTA
 Kj8/+Osn5NDgGbTPG49iDto/+Q/P9k4xt1H/JvqhUvK/czyTDNUBnVOAsOzSy92g59zh
 c1+v7BB2WCAwDgJPZuDI1vfCOH+TMCluC5tAXuWtGitFCs1X8XKe80A/5hIhf9lIF/UV
 WnV53HTzcaoDUKetzzX3Sp/FtiFMZoaslxOpMarORNjfH8H3cbC9kRELaQbAWD+eFiaN
 SGRICaasCMeXBkeETsBVrPCF5P1oKOgZ03iiFFtk/21XuGP7m0r42/118SADF+7Atvnf
 JLsA==
X-Gm-Message-State: AOJu0YxlBB7qLN32g7lUnmv4rrbhAb0D0vrDbXGrS9Y3b+un4moj+PNB
 9OPk3yGIR0V0E34WyOeIulVTaMfpn1Cu3gHweYMAvH1K+gOn7EA2LOBLScAsQ6/CvbVAcmItD7Z
 5
X-Google-Smtp-Source: AGHT+IH2GWLzAQw/te43dYy0dVJiY21oZeXtwmtdL2hpOlzksZL6MD4EorkNDlnjyP7fdTbxMbpEeA==
X-Received: by 2002:a05:6000:11ce:b0:37d:3e6d:6a00 with SMTP id
 ffacd0b85a97d-37d600d329cmr7828611f8f.47.1728911584053; 
 Mon, 14 Oct 2024 06:13:04 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d605c197bsm7103718f8f.38.2024.10.14.06.13.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 06:13:03 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v8 31/37] armv8: cpu: Enable ACPI parking protocol
Date: Mon, 14 Oct 2024 15:10:47 +0200
Message-ID: <20241014131152.267405-32-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241014131152.267405-1-patrick.rudolph@9elements.com>
References: <20241014131152.267405-1-patrick.rudolph@9elements.com>
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
2.46.2

