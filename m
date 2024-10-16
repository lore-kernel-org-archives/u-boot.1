Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A7C5D2069E
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 06:17:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 614C388DF8;
	Wed, 16 Oct 2024 08:13:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="GPR0d6Kv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DBA988F28; Wed, 16 Oct 2024 08:13:37 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CD8E88D70
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 08:13:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-37d4ac91d97so5253721f8f.2
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 23:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1729059215; x=1729664015; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aQ3fiwac6368tQvYZ51DF5qc0QaxNfwumSk8n6WYLF4=;
 b=GPR0d6KvktI52uxzoT8QEkIGCZbMQqb/Q60V+T4cnz1wNT9lFrYUnQwef2giBpIFiq
 vNKCJibYPZ7dQyt5XUKfRPLmguwAVb3NmSOALOS69bypxM1WMTgZpBsKbfCZV7uT5wfo
 0TEvB1vJG2CtC6A7g5LQG/6+PVPcMIfkFstO4f6lgoC+o36+Z6L9wMj8+A1gfz7UlBNN
 nTCbUBZmiSHIyeZ5IT5K4+LvEdtgUSyhEFFUBmYrd6xv/8cxyzbzZ7VJ9azn0YmuTyKU
 bAic6vCJ6ummpIkP4rG4Xhrdv4Tm3vxToFmzOUM5c1iyhKaJv/I+l+VRmkXvRHOkvEc6
 pVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729059215; x=1729664015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aQ3fiwac6368tQvYZ51DF5qc0QaxNfwumSk8n6WYLF4=;
 b=Bmy5eeRcBoBOrUK0e44KZgWUxhAqsBj1kwARw0bb9P6uCFcR2E+RMPubpYzXxJHL9+
 6YPthNvOKv4uo4lgLh97rMec2t7klP8FavtB2Gly4wnjHWXlvjCdRcY/xI0ZG+UyE6YM
 6/PPut6wqZqjVedz6rkcB1yHcHB+4TSpEWs0S3b1Tywhqt0/aO699HAk34OeVfZX01Kv
 SlysMMAs5+NWvSugel9+jykV29sxv94YqW2Vbmlg1UiV24S32MnyJk8bNVyomCHPONLd
 ExC9jvukCIXkgQTrg/aL6tIM0D7wuiHUeMm7/pOLLup0EZs+Ixng4CJ5wHsC7wWSMo+y
 8Qtw==
X-Gm-Message-State: AOJu0YyFrxJTUKYLFv1+4PtF5/XKm5kWktRc9wHxnOCItpzWn+gIr+ti
 jRijjSizvAQVAFepUpSBe+wjFZE1Agz3+0020P4J0imS026LpjNZWF3svlrGIXqBXttbVVEIbfB
 z
X-Google-Smtp-Source: AGHT+IF0WF9262pXm3AimlPehYVZDw7T5rdGjTAdRucV8iABeQqaQ+6usn9UsgCP8UQq2Eb5AUp86A==
X-Received: by 2002:a5d:540a:0:b0:37d:47e0:45fb with SMTP id
 ffacd0b85a97d-37d5ff86f1dmr12103470f8f.21.1729059214701; 
 Tue, 15 Oct 2024 23:13:34 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a2981702bsm141743466b.112.2024.10.15.23.13.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 23:13:34 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v9 31/37] armv8: cpu: Enable ACPI parking protocol
Date: Wed, 16 Oct 2024 08:04:17 +0200
Message-ID: <20241016060523.888804-32-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241016060523.888804-1-patrick.rudolph@9elements.com>
References: <20241016060523.888804-1-patrick.rudolph@9elements.com>
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

