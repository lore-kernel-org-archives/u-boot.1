Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B2ABC41535
	for <u-boot@archiver.kernel.org>; Sun, 17 Dec 2023 00:52:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C6BF87BBB;
	Sun, 17 Dec 2023 01:52:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="z8EaObyl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4764187BE2; Sun, 17 Dec 2023 01:52:38 +0100 (CET)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com
 [IPv6:2607:f8b0:4864:20::114a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 291C2876C5
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 01:52:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=3UkZ-ZQcKBgsxz2t4Aqrzzrwp.nzx5-mzz4wt343.opy8.op@flex--moritzf.bounces.google.com
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-5e19414f714so21529787b3.0
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 16:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1702774355; x=1703379155; darn=lists.denx.de;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=2Zs8sClYzzGwQfMicncjIriK9D7gzxZU6UpjTCJ8kto=;
 b=z8EaObylZU9fV+/lODw24Ffpa6LgUUgikGlP+Z3FwK0G1ntDzj9cwWb0/bcflUsI9y
 gg+EjAAxoROVv0uJ2yxdy0gClAsb5E9dnhYB5z60/bu5pUXsy5g5UH9xR0Q7h6rjDWG7
 HJEkm8fLarB68/sz2ktVSWef66kbHDcBU12RbyPg7z/64klL03Ct5+2w0IDL21aO66Zq
 14o80nmfMCA3eUSF7Yh/G4LL136mMibiGGFUIvObCpH/l9JW8x4gOqa+0rBVKmm5h+p/
 vMd6/PbZMwULcCqzW0AScwHWS4dM7krFy9HGZztxRtcsezuWXkbcdsU/rEqACftlAg/C
 kg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702774355; x=1703379155;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2Zs8sClYzzGwQfMicncjIriK9D7gzxZU6UpjTCJ8kto=;
 b=PTm418nw87ATr43UXjNQJu4Qymd3mFot+yRFHtOUjHFv7jye8gyDG1Ge/D9mwDIFVE
 Csdxkcz/lRjzH3o6lE+7byw8qw2sVVILWu2mejy++IKLTi0GfKB33/aPR0XTPnODTd3T
 3YBzdPITrR/bwk/G1Z8gB3hIk4tbFVQvxB8b9kaqilb1XZpy3Uok1PBeARNm+zYR3WzT
 TNwqvFO5krkfIgP0Uq5eW98qGbVeU1MEM5rSNjaU2NFlS/42eoXB08bz8RH81dburpn3
 uGUWwS4bSRMB7VnRIgFcS8Lm92z9sU1F4oEN1b4+NhAReR8yPJme9+OW3foJMSbNMetc
 M06A==
X-Gm-Message-State: AOJu0YwDxLelgfjNjTBSnH4+JjpdigOTHvAqeTKdmeqUuqOEZCeaeONd
 DVcNoy+lkK+phCgu+eSjH/4DwEhZHNpo
X-Google-Smtp-Source: AGHT+IGnRY9a2FCnkWuV31porCExveYiQhpimYVu0Waiob5KB/YOla7kL/FU2564IO7oKEW4uPYEnOvWUsWp
X-Received: from morats.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:d9e])
 (user=moritzf job=sendgmr) by 2002:a05:690c:c19:b0:5e4:15b:5746
 with SMTP id
 cl25-20020a05690c0c1900b005e4015b5746mr936440ywb.9.1702774354865; Sat, 16 Dec
 2023 16:52:34 -0800 (PST)
Date: Sun, 17 Dec 2023 00:52:09 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231217005209.2789651-1-moritzf@google.com>
Subject: [PATCH v2 RESEND] pci: Enable dm_pci_map_bar() for 64-bit BARs
From: Moritz Fischer <moritzf@google.com>
To: sjg@chromium.org
Cc: bmeng.cn@gmail.com, xypron.glpk@gmx.de, pro@denx.de, marex@denx.de, 
 stcarlso@linux.microsoft.com, trini@konsulko.com, u-boot@lists.denx.de, 
 Moritz Fischer <moritzf@google.com>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Moritz Fischer <moritzf@google.com>
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
2.43.0.472.g3155946c3a-goog

