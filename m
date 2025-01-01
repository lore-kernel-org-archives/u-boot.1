Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE358E7718F
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:24:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D187C80628;
	Wed,  1 Jan 2025 23:23:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KhP7iTZp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CC3F80379; Wed,  1 Jan 2025 23:23:16 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBF748050A
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:23:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-216728b1836so129119565ad.0
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735770192; x=1736374992; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7UWsoDLa9yoYIt2t8ApXI+OTaSLsK3o9384OlC/61O4=;
 b=KhP7iTZpr8Z3D3RDFWzMwBiWbg4Q7L/dRXxO8bYutv1rJdJiSKNcYZEsYX9egW4c+B
 jurmL2XSk+BulHYae31H1tlV6QYZYRBPloEACGEvjwQgwgwbTZJFO5Y/iWvO7eSnIXtT
 3K+roNqiljhXxxqlgK6VeY6ZgWJc1IE8KUzYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735770192; x=1736374992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7UWsoDLa9yoYIt2t8ApXI+OTaSLsK3o9384OlC/61O4=;
 b=h00qeCCPVXrZeVfY//8pQ0NiMuGMg147Vos1BcJ5R0EueDLhXZCkOIyoHY7qgyKZcN
 zoaYZA6K6yIwJV+TmYlZlcFS9L7b16fI/a+mbe7XMNee95UR2QHd4CWBGCmLRSjEw3/q
 Y6+nMjed334faY0CiUsfAPTCBasoZ6rDR/6Q4hJYmIE7F9Bd4qCec7R2lImPQcmS1qJa
 3oanE1+8alo3Eq0q0lOT/S7U6h0q+CFtCv/GEGdOjy94D1hLmkPM6ZnteQWOVan3CzUR
 u396CRTCkhLH9rryWO2ihzB9fIvNdD8IRx9XiTyGMtyzmq2litlVg/wQE1ubgn1fYDrQ
 XO7w==
X-Gm-Message-State: AOJu0YwLOwvFJtYCCVKRl2G6LAM/7fPKFafyE2iGtBAeiyU9aIa4b1BY
 RZfcQPSvvziYmvwL/OOuUVC6hhn6iRWj9vvhCcJPNs7+BZcX5gUxWREDTTV9Ep51keV3rTtt0tw
 =
X-Gm-Gg: ASbGncvTp8FFX/MoOuGwWRvRInaDN3W4YbL28+5Pb5uJ9KoMb4Xvt5rUaOkt7e1ICce
 PRCEvPE7utT4BcRSENOzk2zF9esL+NA4oOCOL0LOVWYsKDWtdS2X/2EEjydJKOUWb9xUpc0wUq4
 1UIeblwYXIlbFjfP+LeRfotaMTDO611uwXy5dMtk5+dqt+TsDzY1NDRe/6djWUsz+ra1f9eqT9H
 /M3FA5BbrWB2Cto9rX8dsljstBcmVw4ih00k/ZHeL4wpNEs5j9wHAM=
X-Google-Smtp-Source: AGHT+IGPw/linCI9Be4eJHiaQJZAeo21zIHPjdZge6Qmum00ZB6tBILFWztJEWsSFltrTtDNSBJAjw==
X-Received: by 2002:a05:6a21:3989:b0:1dc:e8d:c8f0 with SMTP id
 adf61e73a8af0-1e5e07f884cmr65633431637.29.1735770191850; 
 Wed, 01 Jan 2025 14:23:11 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.23.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:23:11 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 60/67] upl: Add PCI information
Date: Thu,  2 Jan 2025 11:09:46 +1300
Message-ID: <20250101221003.1944600-61-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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

So far we have not needed PCI information, but EDK2 does complain when
it is missing. Add the required structures, as a starting point.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/upl.h | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/include/upl.h b/include/upl.h
index 0d76595cc48..62341f2f719 100644
--- a/include/upl.h
+++ b/include/upl.h
@@ -243,6 +243,43 @@ struct upl_graphics {
 	enum upl_graphics_format format;
 };
 
+/**
+ * struct pci_range - Information about a PCI 'ranges' entry
+ *
+ * The ranges property contains:
+ *
+ *   child_flags (1 cell)
+ *   child_base (1 or 2 cells)
+ *   parent_base (1 or 2 cells)
+ *   child_len (1 or 2 cells)
+ *
+ * @child_base: Child base address
+ * @child_flags: Child flags and space code (first cell of devicetree)
+ * @parent_base: Parent base address
+ * @child_size: Child-space size
+ * @first_bus: Bus number of the first child bus
+ * @last_bus: Bus number of the last child bus
+ */
+struct pci_range {
+	u64 parent_base;
+	u64 child_base;
+	ulong child_flags;
+	ulong child_len;
+	uint first_bus;
+	uint last_bus;
+};
+
+/**
+ * struct upl_pci - Information about PCI root bridge
+ *
+ * @reg: PCI ECAM region
+ * @range: List of ranges (struct pci_range)
+ */
+struct upl_pci {
+	struct memregion reg;
+	struct alist range;
+};
+
 /*
  * Information about the UPL state
  *
@@ -263,7 +300,7 @@ struct upl {
 
 	ulong smbios;
 	ulong acpi;
-	uint bootmode;
+	enum upl_boot_mode bootmode;
 	struct memregion fit;
 	uint conf_offset;
 	uint addr_width;
@@ -274,6 +311,7 @@ struct upl {
 	struct alist memres;
 	struct upl_serial serial;
 	struct upl_graphics graphics;
+	struct upl_pci pci;
 };
 
 /**
-- 
2.43.0

