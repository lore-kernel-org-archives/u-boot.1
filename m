Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 039E7C61DF4
	for <u-boot@archiver.kernel.org>; Fri, 24 Nov 2023 10:16:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D3F086CF7;
	Fri, 24 Nov 2023 11:16:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="ydyTcD8w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43DDF86C33; Fri, 24 Nov 2023 11:15:58 +0100 (CET)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com
 [IPv6:2607:f8b0:4864:20::114a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CD5F86CF7
 for <u-boot@lists.denx.de>; Fri, 24 Nov 2023 11:15:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=31ndgZQcKBnkjlofqwcdlldib.Zljr-Yllqifpqp.abku.ab@flex--moritzf.bounces.google.com
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-5cd3cf2e21dso26942337b3.0
 for <u-boot@lists.denx.de>; Fri, 24 Nov 2023 02:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1700820951; x=1701425751; darn=lists.denx.de;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=qt1DxEN9S/KwvyxVishZz4COZfFyH0SVh6zwVaMd0H0=;
 b=ydyTcD8w9YGh39rwU058G8MZUz78q/wjxp7Pul0Xc6ovMySaFb70KXnbTEel+ueLKQ
 QaBRmBhvYxjxoHxny10na2Rvl5hqvgJlGuHiWU57O72WdeLtfp2TuziM0A0ajpbtkBXg
 xPiS8580Kcl3/Vf21uOALDKcw9t/5sPgu0VnwdYHaVmB9vn0uXITkOeIpT668mfL68IC
 ZHycceZ2iIOZ6D1OhtV/ltZEUHpIN8hBLNK7/waJsFG09zDYZQQ7y2tJWDRLLVEII2WH
 iNUQXkQKaezW/tTmbhaMI3iBNIcYttSK7CLbDAt1mLPH07tOXMPN3FagjhJ1yfOzFCmc
 4hVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700820951; x=1701425751;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qt1DxEN9S/KwvyxVishZz4COZfFyH0SVh6zwVaMd0H0=;
 b=jFKgon8USuuv1DZwwpOUH8Zfn2Dm+JMIQPfLfpjAA1ZHc/Cu1Q8n2B+iPDUPxmM+MS
 5+Z/STv30TvpO7+jFILwhso53EXFzNLdn87cL3mTv+VXK3TZzZSZuxevmT6GWzXnvgJT
 W8SCh4pywFtKyarISnhcoohNOhi2tTNz8SbVgEP6248CYGPpsYgDH+4E3SjEowz0w0Cd
 TyyAyNEhMfS/oQJUpDsQxqycdP1aBrAMG5+MdK/pG1QGhvwkHm75kCfOatIRKwQpQlEb
 GR2G8W4prmaAKwDzzqbLSNYyEFebWlxaAsA3jr2sT2HMgH2kv6HPk02LVdvbEYKjQBXX
 f0hA==
X-Gm-Message-State: AOJu0YyJYojud3ds2iK9h5kJnF3egPiYClngqolprGm68lWP5TpkcNVV
 VpPN/4h+fR4Uv8Qjc+N+6eTkl/oVw1Xi
X-Google-Smtp-Source: AGHT+IGH4EGCwddXSrqm6rANZWafTnl8IcJXkwNUsG2mGynwHtouM3motQvoOHDfVcgpBXAQIMf602hz4Obl
X-Received: from morats.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:d9e])
 (user=moritzf job=sendgmr) by 2002:a81:b614:0:b0:5cc:3af6:291 with
 SMTP id
 u20-20020a81b614000000b005cc3af60291mr70110ywh.5.1700820950823; Fri, 24 Nov
 2023 02:15:50 -0800 (PST)
Date: Fri, 24 Nov 2023 10:15:20 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231124101520.1077082-1-moritzf@google.com>
Subject: [PATCH] pci: Enable dm_pci_map_bar() for 64-bit BARs
From: Moritz Fischer <moritzf@google.com>
To: sjg@chromium.org, u-boot@lists.denx.de
Cc: bmeng.cn@gmail.com, marex@denx.de, xypron.glpk@gmx.de, 
 stcarlso@linux.microsoft.com, Moritz Fischer <moritzf@google.com>
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

Allow dm_pci_map_bar() usage on systems with CONFIG_PCI_SYS_64BIT.

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
2.43.0.rc1.413.gea7ed67945-goog

