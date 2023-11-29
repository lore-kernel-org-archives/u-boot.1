Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9140C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 00:49:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05C2A86940;
	Wed, 29 Nov 2023 01:49:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="t7aehK4B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82E228753A; Wed, 29 Nov 2023 01:49:05 +0100 (CET)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com
 [IPv6:2607:f8b0:4864:20::b49])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79AE58772E
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 01:49:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=3fIpmZQcKBl0HJMDOUABJJBG9.7JHP-6JJOGDNON.89IS.89@flex--moritzf.bounces.google.com
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-dae71322ed4so7963659276.1
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 16:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1701218940; x=1701823740; darn=lists.denx.de;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Bm/fnJOFMvGm+wGRwdjIkKPjjfPgkGkFyORGIcsd9g8=;
 b=t7aehK4BL6LQUs55JepSxwpUOSGbL/hFFm85GE00PIXcUjADS8viDzLgIIOUhQnbfl
 r2br9fErS+DarVzLEsZ4HNxg39F4gEUDBFOznyJCJ/9fTZ11ROZ9tZp/+/vaiFCk4Zy+
 sbEzl9FLAmNXsrPKrJypl2qmVN4u6ywxvd4FW16CZWm2QmA9vaMBzTXFwe9dnArnAgqm
 HA26nCR7K0s6w1ppghQE3acJ0juML4G5E+WSa93vHYDiVFUEhUKfjcVn2IRnvG3j2qLF
 6nqXlVYzDXEUbXS7oU2HGdzoN9GNc1MQjTQ6+ut8q6azHqJ+X/Z9OaPoTr2NAAtP2ZPk
 1OHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701218940; x=1701823740;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bm/fnJOFMvGm+wGRwdjIkKPjjfPgkGkFyORGIcsd9g8=;
 b=qDIxH+fWd6diO9h/w2Rvh/RWc4ehY8YC4L10wPqd2aU3R9n4LVLBU5UFlhjdjPurXg
 T5a9aeSTxaCJH0wI0Reg3Gt0ZNz6afVRQn5BAOytS7nOxvcIo9Stp8Jfied5XttIm6ug
 fgEKoiw6ZPDJPbsfAA06Um+UrVcXjVYJLLg2+JZ/JVySLBW11Ud417uCwcaGlxP9UGlP
 9ZPgX/Bi8VENfC0ShodM+ORygpumc1fDCKVZiknBgDYo2p0oJAHz6ZQ7l8GGnwczXawz
 Hv9k8gG8mR3tdhYLG6yh8MbGr1fZboWOadCvDIsh8C+F221ePwobi/Y9+VchJFHUd6BN
 FpgQ==
X-Gm-Message-State: AOJu0YydbGx+ktTJvIhYUMfs/o1an5Ir6X22M3a3Qz5uUVXlCl2mVwo+
 pHDhXKR218kMp1UG4Kp5t0v4+SziECyS
X-Google-Smtp-Source: AGHT+IEthVcGkg+2PY6eXyq2KhVTpoQ5yEcb8fYxHJt4l6XJkG5rIeHVhweotMPZ3Y4B2nLq0Nr4iM2AoH+/
X-Received: from morats.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:d9e])
 (user=moritzf job=sendgmr) by 2002:a25:1ed4:0:b0:db4:5edd:3c77
 with SMTP id
 e203-20020a251ed4000000b00db45edd3c77mr463643ybe.4.1701218940200; Tue, 28 Nov
 2023 16:49:00 -0800 (PST)
Date: Wed, 29 Nov 2023 00:48:50 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231129004850.2542811-1-moritzf@google.com>
Subject: [PATCH v2] pci: Enable dm_pci_map_bar() for 64-bit BARs
From: Moritz Fischer <moritzf@google.com>
To: sjg@chromium.org, u-boot@lists.denx.de, trini@konsulko.com
Cc: bmeng.cn@gmail.com, marex@denx.de, xypron.glpk@gmx.de, 
 stcarlso@linux.microsoft.com, Moritz Fischer <moritzf@google.com>, 
 Philip Oberfichtner <pro@denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Allow dm_pci_map_bar() usage on systems with CONFIG_SYS_PCI_64BIT.

Reviewed-by: Philip Oberfichtner <pro@denx.de>
Signed-off-by: Moritz Fischer <moritzf@google.com>
---
Changes from v1:
- Fixed commit message
---
 drivers/pci/pci-uclass.c | 11 +++++++++++
 include/pci.h            |  4 ++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-uclass.c b/drivers/pci/pci-uclass.c
index e0d01f6a85..82308c7477 100644
--- a/drivers/pci/pci-uclass.c
+++ b/drivers/pci/pci-uclass.c
@@ -1611,6 +1611,17 @@ void *dm_pci_map_bar(struct udevice *dev, int bar, size_t offset, size_t len,
 	dm_pci_read_config32(udev, bar, &bar_response);
 	pci_bus_addr = (pci_addr_t)(bar_response & ~0xf);
 
+	/*
+	 * This assumes that dm_pciauto_setup_device() will allocate
+	 * a 64-bit address if CONFIG_SYS_PCI_64BIT is enabled and
+	 * the device advertises that it supports it.
+	 */
+	if (IS_ENABLED(CONFIG_SYS_PCI_64BIT) &&
+	    (bar_response & PCI_BASE_ADDRESS_MEM_TYPE_64)) {
+		dm_pci_read_config32(udev, bar + 4, &bar_response);
+		pci_bus_addr |= (pci_addr_t)bar_response << 32;
+	}
+
 	if (~((pci_addr_t)0) - pci_bus_addr < offset)
 		return NULL;
 
diff --git a/include/pci.h b/include/pci.h
index 2f5eb30b83..0d1ac7b015 100644
--- a/include/pci.h
+++ b/include/pci.h
@@ -1350,8 +1350,8 @@ pci_addr_t dm_pci_phys_to_bus(struct udevice *dev, phys_addr_t addr, size_t len,
  *
  * Looks up a base address register and finds the physical memory address
  * that corresponds to it.
- * Can be used for 32b BARs 0-5 on type 0 functions and for 32b BARs 0-1 on
- * type 1 functions.
+ * Can be used for 32b/64b BARs 0-5 on type 0 functions and for 32b BARs 0-1
+ * on type 1 functions.
  * Can also be used on type 0 functions that support Enhanced Allocation for
  * 32b/64b BARs.  Note that duplicate BEI entries are not supported.
  *
-- 
2.43.0.rc1.413.gea7ed67945-goog

