Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E5CC3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 31 Dec 2023 15:26:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03685878AD;
	Sun, 31 Dec 2023 16:26:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WdvwXOIO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 563F0878AD; Sun, 31 Dec 2023 16:26:16 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B5CA8786C
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 16:26:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7ba834684abso420253939f.2
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 07:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704036372; x=1704641172; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0r7WMJ8pyss8QinvvlKC1FgWho9b7PErKAiC9PWgfo8=;
 b=WdvwXOIOLbLOvOiiJ6Bbxqfc6VsAp7rgS8dD65lybKaAEG/G+p+KjEA0TaUceTGVnH
 +nGaUFI6VN0vMCemEsOm5Swh3DEIl931GEJ3xTxEt+7n0Nfk/e75sqc/il8gRRlb5NO4
 r+IXAm6mSmfCVK9JDE9vzPo9mFuncU2HSyxfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704036372; x=1704641172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0r7WMJ8pyss8QinvvlKC1FgWho9b7PErKAiC9PWgfo8=;
 b=phl/6o2IBqbVmCdgNwIa8PQT7L2zB72myC47Rja9IK8veqen6xaiY3BKs6/arCaJq1
 ewJOX7ZEFJQLa7N6w/qOtBgXm0YQQRWJHIF4sAC5dXQGbkxxY7IXw8fnLQh2wODgaGZz
 1/s7lEdipxFtRfQr/ZSrOyOlIOAoN1pOR57i08Hn/Xd84WpdPkGu6PsdxMhaD6q3oAN4
 4vIMmWD+crbzSz4HAtCMDXVvFjv8pp6rXlbqSd5QyHuID8Q2bMpcdy0SurdgpH+ySDMc
 UT3mb4DMjadRH5qA+Jx/b0qyAaxryA+uzEihqw/SDn42a0twjk+cBHuvtfN4a4ASTEjP
 zuvA==
X-Gm-Message-State: AOJu0YwYZCAFo7UrokhgY8UQmdWfY/Mt58Cp7NMVkIJa01UxvQLSHct0
 4tG4tUuTSRyzv+y4dqFKQH87WL1JP5nNtY5Pw3MoEeESSeqA
X-Google-Smtp-Source: AGHT+IE8lfh7zrZ8lrJJRRUvVIiSKx1PPAIwLRRMtn9hKHZxyHHrjn6vxXHj+AMOnRG7FCYc/ns/2g==
X-Received: by 2002:a05:6602:2756:b0:7b7:fefc:e243 with SMTP id
 b22-20020a056602275600b007b7fefce243mr20069298ioe.38.1704036371912; 
 Sun, 31 Dec 2023 07:26:11 -0800 (PST)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 cz9-20020a0566384a0900b0046b482039ecsm5632625jab.55.2023.12.31.07.26.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 07:26:11 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 03/12] smbios: SMBIOS 3.0 (64-bit) Entry Point structure
Date: Sun, 31 Dec 2023 08:25:46 -0700
Message-Id: <20231231152555.464874-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231231152555.464874-1-sjg@chromium.org>
References: <20231231152555.464874-1-sjg@chromium.org>
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

From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Add definition of the SMBIOS 3.0 (64-bit) Entry Point structure.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v4)

Changes in v4:
- Bring in this patch from Heinrich's series

 include/smbios.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/smbios.h b/include/smbios.h
index c9df2706f5a..e601283d293 100644
--- a/include/smbios.h
+++ b/include/smbios.h
@@ -54,6 +54,32 @@ struct __packed smbios_entry {
 	u8 bcd_rev;
 };
 
+/**
+ * struct smbios3_entry - SMBIOS 3.0 (64-bit) Entry Point structure
+ */
+struct __packed smbios3_entry {
+	/** @anchor: anchor string */
+	u8 anchor[5];
+	/** @checksum: checksum of the entry point structure */
+	u8 checksum;
+	/** @length: length of the entry point structure */
+	u8 length;
+	/** @major_ver: major version of the SMBIOS specification */
+	u8 major_ver;
+	/** @minor_ver: minor version of the SMBIOS specification */
+	u8 minor_ver;
+	/** @docrev: revision of the SMBIOS specification */
+	u8 doc_rev;
+	/** @entry_point_rev: revision of the entry point structure */
+	u8 entry_point_rev;
+	/** @reserved: reserved */
+	u8 reserved;
+	/** maximum size of SMBIOS table */
+	u32 max_struct_size;
+	/** @struct_table_address: 64-bit physical starting address */
+	u64 struct_table_address;
+};
+
 /* BIOS characteristics */
 #define BIOS_CHARACTERISTICS_PCI_SUPPORTED	(1 << 7)
 #define BIOS_CHARACTERISTICS_UPGRADEABLE	(1 << 11)
-- 
2.34.1

