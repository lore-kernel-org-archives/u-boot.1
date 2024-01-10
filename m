Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DADB0C47074
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 04:59:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F12BA87710;
	Wed, 10 Jan 2024 05:59:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="VcG9+fhA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B76D87702; Wed, 10 Jan 2024 05:59:20 +0100 (CET)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com
 [IPv6:2607:f8b0:4864:20::114a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D52E87716
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 05:59:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=3IiSeZQcKBhc9BE5GM23BB381.zB9H-yBBG85FGF.01AK.01@flex--moritzf.bounces.google.com
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-5f240ace2efso51726677b3.1
 for <u-boot@lists.denx.de>; Tue, 09 Jan 2024 20:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1704862755; x=1705467555; darn=lists.denx.de;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=zFAKStRb6qhoQ3Wj3+p5Fzf/Z5f+3AJKVo0wbvW8U9Y=;
 b=VcG9+fhA/0uXXirrifABrsq5CGjAeGmKWnKs5csS2B4K/YvBbvbfee87LxUOKj5M8z
 3mYf8JagdLS5RKIl0ZQe71NdSJkrQEh+KUtsZd19zb/A3HASnx5WD4pygBRMWguLM548
 lFJa/HOfOUbu3uh/zVgtox6vHtaic/3Ui7b9+ic8SZw8hSO1wiIPABv3oLg6ISICE4oq
 yQdPWY3rQqVvBAvIT+tWn955C4QCwBinH1BOHEhRlJ4C2rTm/y1/UpPhEM1HVf4u27zX
 hP2407As7tF4fqgJ7zrx+Wje35xSFsKEDQW+VJMZKnso7tBb1KE8cr4yZbF/WRKNcCRm
 yHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704862755; x=1705467555;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zFAKStRb6qhoQ3Wj3+p5Fzf/Z5f+3AJKVo0wbvW8U9Y=;
 b=omLIRCP35Zl+lomOhofDOgabYuDe2Q4w5RC14ur7DuJG6wcOoLWAujtRc5gC4vG7vb
 IzGhwa3im6ovVBeg57g8EPwYtCpQirMyL1fyvIFM2PMjNdN9bcWpmFqPElu+D4SNBPLO
 fpzi8Jk0urNwNuqt5rpa8M5oigT5hQTPh28keND7gkK2+mC5/bL3kI80/sLnAs4CAvgc
 n1i4B76LuW68r6qGSDURx9YJFPkXLUzYUs88AiaqX9b9Oy0pfc2JEv6O0T8dVj3exJMp
 YmDkdZhWw5GPV27zhReZZiOzC8WSNhpas7fZAYURx5JsGw1CDIQyOePd/eFsw6Akw4Yj
 TFMw==
X-Gm-Message-State: AOJu0YwOj/9AezFYRLZD+XQqjL2RWn3eZsaHPu4la+XOV13OgghF5QAm
 SSaP23afbGA7UXL2I+wmBfgF3EWlRG2+/72Sa1U=
X-Google-Smtp-Source: AGHT+IGLcji2rwwtHLaH1imrMs2ZOcZ89XqMWW3S1bNtLxy4JsbOuQhRxqOsesGUtkcKJSIjTOWyaYALO3QH
X-Received: from morats.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:d9e])
 (user=moritzf job=sendgmr) by 2002:a25:bb46:0:b0:dbe:ee69:bf1a
 with SMTP id
 b6-20020a25bb46000000b00dbeee69bf1amr13421ybk.7.1704862754841; Tue, 09 Jan
 2024 20:59:14 -0800 (PST)
Date: Wed, 10 Jan 2024 04:59:02 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240110045903.1439339-1-moritzf@google.com>
Subject: [PATCH v4] drivers: pci: Fix dm_pci_map_bar() to support 64b BARs
From: Moritz Fischer <moritzf@google.com>
To: sjg@chromium.org, trini@konsulko.com
Cc: bmeng.cn@gmail.com, xypron.glpk@gmx.de, pro@denx.de, marex@denx.de, 
 stcarlso@linux.microsoft.com, u-boot@lists.denx.de, 
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

This enables 64b BARs if CONFIG_SYS_PCI_64BIT is enabled.

Reviewed-by: Philip Oberfichtner <pro@denx.de>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Moritz Fischer <moritzf@google.com>
---

Changes from V3:
- Rebased onto v2024.01

Changes from V2:

- Turned IS_ENABLED() into #if defined to allow
  building on platforms that don't define
  CONFIG_SYS_PCI_64BIT

Changes from V1:

- Reworded commit message / typo

---
 drivers/pci/pci-uclass.c | 11 +++++++++++
 include/pci.h            |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/pci/pci-uclass.c b/drivers/pci/pci-uclass.c
index e0d01f6a85..1a48256de0 100644
--- a/drivers/pci/pci-uclass.c
+++ b/drivers/pci/pci-uclass.c
@@ -1611,6 +1611,17 @@ void *dm_pci_map_bar(struct udevice *dev, int bar, size_t offset, size_t len,
 	dm_pci_read_config32(udev, bar, &bar_response);
 	pci_bus_addr = (pci_addr_t)(bar_response & ~0xf);
 
+	/* This has a lot of baked in assumptions, but essentially tries
+	 * to mirror the behavior of BAR assignment for 64 Bit enabled
+	 * hosts and 64 bit placeable BARs in the auto assign code.
+	 */
+#if defined(CONFIG_SYS_PCI_64BIT)
+	if (bar_response & PCI_BASE_ADDRESS_MEM_TYPE_64) {
+		dm_pci_read_config32(udev, bar + 4, &bar_response);
+		pci_bus_addr |= (pci_addr_t)bar_response << 32;
+	}
+#endif /* CONFIG_SYS_PCI_64BIT */
+
 	if (~((pci_addr_t)0) - pci_bus_addr < offset)
 		return NULL;
 
diff --git a/include/pci.h b/include/pci.h
index 2f5eb30b83..aad233769a 100644
--- a/include/pci.h
+++ b/include/pci.h
@@ -1354,6 +1354,7 @@ pci_addr_t dm_pci_phys_to_bus(struct udevice *dev, phys_addr_t addr, size_t len,
  * type 1 functions.
  * Can also be used on type 0 functions that support Enhanced Allocation for
  * 32b/64b BARs.  Note that duplicate BEI entries are not supported.
+ * Can also be used on 64b bars on type 0 functions.
  *
  * @dev:	Device to check
  * @bar:	Bar register offset (PCI_BASE_ADDRESS_...)
-- 
2.43.0.472.g3155946c3a-goog

