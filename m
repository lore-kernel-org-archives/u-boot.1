Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5276ACF5389
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 13:36:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3B4E8930D;
	Wed, 23 Oct 2024 15:29:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="QZx/K37z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADE948938E; Wed, 23 Oct 2024 15:29:35 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96C2689345
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 15:29:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4316a44d1bbso40682505e9.3
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 06:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1729690169; x=1730294969; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aQ3fiwac6368tQvYZ51DF5qc0QaxNfwumSk8n6WYLF4=;
 b=QZx/K37z5w5XUffKchRFD+AZpKALhEZV2MEbsTg9xkx0H4e7sLLonQNgU/kAs6p5Wr
 ltLh/2Q6bZan6AqzVUhiSIiYVCq8IyhwWP03KrH9UaDOGIo8NOXpb8yXQQAVG/xtQF+U
 24XkZIbrbLm3KvoTGOFaPgxbrmlo7ccca96G4+aXAtlZQy3ZfYEhxBYSFJQ7Od+pHqeN
 ju5PWqDFJoX9TJSREK732DFeiF+D4ayYRwNgvkRf2ECMXYx/cdKtndnWbU47Cnq6+pmD
 vG+gFYsISWSQtxayQl7IsGvTy42n5LMPiHVMBO9I3FJnSkFrHazRAuJDXlmOIx4lrLtT
 D8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729690169; x=1730294969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aQ3fiwac6368tQvYZ51DF5qc0QaxNfwumSk8n6WYLF4=;
 b=GhaDB7SkUa6KTQ1Zgqoqnq2NktF5U4AOmpxHTizkYZaChtRGm6OW2u6cT0q9Iziy0O
 45Mh0jodz23IRpDFfJFMPreb/aziDSww/5cDyCczapqNqWWunzLAOxsRBRz5tiw3leud
 6rnJNQHzD43rciirkipQGqTz5VTnp6T3o2i1VZXUW9IAAaxTH4OwcDkQ8r/X0/30WbNm
 LT4F8iU47kKwd6rIaXlXeZTCCczfXY/HicEH4oitvKCvch27o9a1lUQFJvDxxH9qM2gE
 QsQqmKL6Pz7x6MMfv7C4twdXWmpgAbMnZ7vLSBsCM0dNeLtdDNOava/xYiNQAYxYT5vg
 /vQA==
X-Gm-Message-State: AOJu0Yzv9fGWS0TVquvAoUbRONPwiIPACLhqCvBerDca6LvCpMNqDKNV
 ya3bKctzjxSqKYpUFExTaj2LTAuNW/TGgW1Ppb1JO979Osg0cIRjU3VqiPnY+sfXL1LT01EmOMU
 T
X-Google-Smtp-Source: AGHT+IEbHRtadZQdck4N2LEJCemaMzwAbIa0MY+3Lz9kbX0/yOaw6eHHlCryU0TMeT5GC0OP7yDQjQ==
X-Received: by 2002:adf:ea47:0:b0:377:683f:617c with SMTP id
 ffacd0b85a97d-37efcf0b7afmr1841728f8f.23.1729690169008; 
 Wed, 23 Oct 2024 06:29:29 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0b9b186sm8907478f8f.91.2024.10.23.06.29.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 06:29:28 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v10 31/37] armv8: cpu: Enable ACPI parking protocol
Date: Wed, 23 Oct 2024 15:20:14 +0200
Message-ID: <20241023132116.970117-32-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241023132116.970117-1-patrick.rudolph@9elements.com>
References: <20241023132116.970117-1-patrick.rudolph@9elements.com>
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

