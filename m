Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08BFCC35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 21:25:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 870D9876F3;
	Thu, 21 Dec 2023 22:25:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="0+vKs+wD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 769F086D38; Thu, 21 Dec 2023 22:25:09 +0100 (CET)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com
 [IPv6:2607:f8b0:4864:20::114a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67F228755B
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 22:25:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=3Mq2EZQcKBtE9BE5GM23BB381.zB9H-yBBG85FGF.01AK.01@flex--moritzf.bounces.google.com
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-5e76b663ef3so22299767b3.1
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 13:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1703193906; x=1703798706; darn=lists.denx.de;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=56B5QlmgiBhJjIU/02bwjiuW97QMGU+karPJt+FNKYk=;
 b=0+vKs+wD62dwqreBEDJTT4mH/juNcmLdggQw3M4tnHzVz1VdcVozzL2uzwV3Z+pVEE
 R4TawSxGUCsSgUt/Bo08e6w/qxBH94Oyu00+XlzYj99/C6r+TIli7dCGUO4Z6vg/6Wl2
 1OBcmj7qr5FRrFUBL6+u/si+1mTl4H6tKN7ujQWHZYUjB5z4unAhUoA8xv7zzaUbwxU8
 UN/RdVKO8F+15zeC8IDORGZhohCwuvSCzBfGqD5I1zfxzTH7CCxwfl19xoosrk1KfRay
 mFdQQfj6kr/dB08sSdRACqbMfyy9CU3mgWWnn2g/mXf9GKaphOz/kdXyNshBFdLcCrHx
 oA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703193906; x=1703798706;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=56B5QlmgiBhJjIU/02bwjiuW97QMGU+karPJt+FNKYk=;
 b=LKjwH2tVgZw7I8Tnc43blxH/u0vJ6Lkwxa+x0jj80W6ZBjOs5qwN2SL1sJwTvolEuy
 XzP4zRpUPX/jNiNngcGwKdV9tpHGZ0MUqjLqvU26U4NYELP5PLHDC9BgM/y6Vhg8M/iw
 epFyNx9G+yMqaeN4EsdM25Y2eCsCdlwAQqkW7HFtEuGCcSr41DU45MAX9wYhho5HXlu7
 Hpi/r+K2kZ1OQMbpfIsj3LIeyFLB16pGpstzyp3qCK33SEdk/X+LS/EUoPOgEOp9qvW6
 rayRnvoSsxqZRcus/Awp9E5dSSTASO+7E+6BSLj2w5IsRWERL0qVYgfObU03xU4Jm/Qd
 5s2A==
X-Gm-Message-State: AOJu0YzU2Z4EF2bO8IXsGreouDyreCW6xsJUooHsMfRa+HaCn0ia2xM7
 +5XtryfV9DVZjTZl6SdGiJK3ygXcCZDpTkHwMdM=
X-Google-Smtp-Source: AGHT+IFhNwxgzvOOM2+jC32IM9qSil0yhRcwBBcFbv+YJZ+2a1Y20XPKGPuXXaLJSimoBe+c0CwX4aU+DorU
X-Received: from morats.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:d9e])
 (user=moritzf job=sendgmr) by 2002:a05:690c:a90:b0:5e8:1f45:30e6
 with SMTP id
 ci16-20020a05690c0a9000b005e81f4530e6mr212101ywb.5.1703193906147; Thu, 21 Dec
 2023 13:25:06 -0800 (PST)
Date: Thu, 21 Dec 2023 21:24:42 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231221212443.2716500-1-moritzf@google.com>
Subject: [PATCH v3] pci: Enable dm_pci_map_bar() for 64-bit BARs
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

Changes from V2:

- Turned IS_ENABLED() into #if defined to allow
  building on platforms that don't define 
  CONFIG_SYS_PCI_64BIT

Changes from V1:

- Reworded commit message / typo

---
 drivers/pci/pci-uclass.c | 12 ++++++++++++
 include/pci.h            |  4 ++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-uclass.c b/drivers/pci/pci-uclass.c
index e0d01f6a85..04c82d3884 100644
--- a/drivers/pci/pci-uclass.c
+++ b/drivers/pci/pci-uclass.c
@@ -1611,6 +1611,18 @@ void *dm_pci_map_bar(struct udevice *dev, int bar, size_t offset, size_t len,
 	dm_pci_read_config32(udev, bar, &bar_response);
 	pci_bus_addr = (pci_addr_t)(bar_response & ~0xf);
 
+#if defined(CONFIG_SYS_PCI_64BIT)
+	/*
+	 * This assumes that dm_pciauto_setup_device() will allocate
+	 * a 64-bit address if CONFIG_SYS_PCI_64BIT is enabled and
+	 * the device advertises that it supports it.
+	 */
+	if (bar_response & PCI_BASE_ADDRESS_MEM_TYPE_64) {
+		dm_pci_read_config32(udev, bar + 4, &bar_response);
+		pci_bus_addr |= (pci_addr_t)bar_response << 32;
+	}
+#endif /* CONFIG_SYS_PCI_64BIT */
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

