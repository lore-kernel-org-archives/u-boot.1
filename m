Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A58D5CF31AE
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 09:57:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D88189202;
	Wed,  2 Oct 2024 11:52:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="NPInX03S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32CA888F64; Wed,  2 Oct 2024 11:52:56 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3921A89202
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 11:52:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42cbface8d6so79524385e9.3
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 02:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727862774; x=1728467574; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aQ3fiwac6368tQvYZ51DF5qc0QaxNfwumSk8n6WYLF4=;
 b=NPInX03SSSeDImHHiqryDSBXrPrP9Xjf1k6vVXMPRqomoFg17G4GrTh4lzP9V3oYS2
 hBgfTyFMKXZVozMPxFDb2laelgXlEhIRLPmmsGMewHl3cbT56GE3yYqSXR5eE1LNI2D9
 rJS78vCp04UNS5EskgClI0e79moQVDJ1Jt4hJOqpmNSBLUTNXF6Nz8dMYOdcb3p8JVll
 KS5LrHqH0EUDWN0xfqNpT9KUT+mPTbRlGFn0DnJXAYLECd3+UND3qlCBv+PivQ2vjYtn
 qGkSXCfEzOphZh1axZSLK48AJfMPfhXZsSm7Eg8pQ7nJbxw1bQVQgFScB+MrBU4IbNwp
 N73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727862774; x=1728467574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aQ3fiwac6368tQvYZ51DF5qc0QaxNfwumSk8n6WYLF4=;
 b=rJrp9xU0R977w9vzB2kP59UHPiYNv25aCoYpIiyRHt4IMh5AF1DtqkombZfPCDLF/U
 QwP7aZGY0WW4LZTmQ6JqWlqTGsuCPC3mrYkVJDuTAb/5nINczhszhcjTPM1N/xicWnL3
 VnjzRsbLPA1+oqcRdEn59tNmUvvm8qPNmrjEYJVQZZ7i1k+XqUAryLtKk32OvxN2i9YM
 PKsFyStl6B2eWJI7BqOOjbFgntVISn+jG6IN4pdczAkjUF2pTjV4ya5CeZP3yhz01wFb
 qgaZkA+RN5XHjOFKwFjmBijYhiOY68m01mUxy7IQni4dG44Z2S9VmT16O8fw/95qaXml
 VXbw==
X-Gm-Message-State: AOJu0YzM9POGefeuz5YpnpM2k/PGWTtpSYJ7hVB3X/nTLkO5bc2xQp5q
 /9ZOW4bGiUgUAUiIAot1B6DsubWCUitj3J+9Kg8xl8Whk+HHO6uQoIHo++oOT3L0d/Ve6DY2qV5
 W
X-Google-Smtp-Source: AGHT+IE0E9p69PU3vGQFD/QhNve6jT4Uf5BUVtK8HDGAKcf4CAa0yHBNpeEPbPAZ5NKbpYPqBjXQKg==
X-Received: by 2002:a05:600c:35cf:b0:42c:b555:43dd with SMTP id
 5b1f17b1804b1-42f777b2039mr22081415e9.3.1727862773313; 
 Wed, 02 Oct 2024 02:52:53 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e94c4sm13555292f8f.62.2024.10.02.02.52.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 02:52:52 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 31/37] armv8: cpu: Enable ACPI parking protocol
Date: Wed,  2 Oct 2024 11:47:22 +0200
Message-ID: <20241002094832.24933-32-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002094832.24933-1-patrick.rudolph@9elements.com>
References: <20241002094832.24933-1-patrick.rudolph@9elements.com>
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

