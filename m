Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE1BCFD316
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 10:39:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CA7A89376;
	Fri, 11 Oct 2024 12:35:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="UoLybwS0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E87C89380; Fri, 11 Oct 2024 12:35:28 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 579B189377
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 12:35:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a995f56ea2dso300225666b.1
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 03:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1728642926; x=1729247726; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aQ3fiwac6368tQvYZ51DF5qc0QaxNfwumSk8n6WYLF4=;
 b=UoLybwS0pXoiaELaowu9bN6yaSfprF1OhZ2T69mSQHYHSPAy3EnKyHH6q85xf01Bkk
 GfBT8gHRaaaiTdQIwOHqIlGmFOBZqMOeeBdxhp0wuaYpd/ZYUvhlrElKo1/NgevfZL/G
 POB6ALF+FwmCkjKq3tPJqikXKptVHljMdRwfnUkvZLFW6oW3IvEcLvmcYlm6QURb5dIV
 4aP7rjRTi6LxIy8ly8fbedd6scpK91Hxz0+U9RPbtYxwpyVf/+/9t0iLVN+9y8aKzsC2
 2giDQb+SZDx9+wXidIoLxjgoubSseksJLflzEEaO69tQjkes4v0UxeTcd9lZYaTCpz9x
 3gDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728642926; x=1729247726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aQ3fiwac6368tQvYZ51DF5qc0QaxNfwumSk8n6WYLF4=;
 b=cvT5wKc1lofZfACDMR3kDnymn6ZNTjy375wHwr6N35FBLQ7Cs/j9MQ1GQB548kb3i9
 IPr77wFUmAbH+0MHaErR8k+ZUDv0DaqUvWncxVm/c3QY3ug2fhLrEQV3bgA8P3XB86m9
 GsVM4zK2jR8OG0RRrxRkdE47u/iYHfvOycYUqJWz4sq1ruyNmpcYy/mHWd6iLkmfnXGI
 5/KESVjefERyI+/iVTcM6gFtEWoz8odbdv7kUA82iMvd5x9dXydxeAg7TDLuDQOBR6Om
 y6WDHDCuprI5isnPAmetQfeNQfEjjYjqg/tsSY6l+/lYZ4DHwWnKK+CkgdNzYL+Rt+5j
 mtug==
X-Gm-Message-State: AOJu0YwkVUWlIgVUDnSN2hpVWpPWZ/zqT7n2jUxzzvtsbJsqFh4ehK1B
 mf2I9VAgF1QdrrFBVovSD4517cWXOMSYtfFiHLcgUwhQ28+MKdkToz7XBCgHUk+NP/r6XJIU+f2
 GGhQ=
X-Google-Smtp-Source: AGHT+IEgC5xNmfKCbZyhjbL8OTm7WM7d/PpARIGX6jw5YvqVKaxBRwJfSr3oMu1MrQ3eiPkPCFA5fA==
X-Received: by 2002:a17:907:d596:b0:a99:537d:5d14 with SMTP id
 a640c23a62f3a-a99b93c7905mr185664366b.28.1728642925803; 
 Fri, 11 Oct 2024 03:35:25 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a80f29besm195353466b.211.2024.10.11.03.35.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 03:35:25 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v7 31/37] armv8: cpu: Enable ACPI parking protocol
Date: Fri, 11 Oct 2024 12:23:12 +0200
Message-ID: <20241011102419.12523-32-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011102419.12523-1-patrick.rudolph@9elements.com>
References: <20241011102419.12523-1-patrick.rudolph@9elements.com>
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

