Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF74C46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 07:41:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2DEC8789A;
	Wed, 27 Dec 2023 08:40:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ot+BDdD6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5B2C87872; Wed, 27 Dec 2023 08:40:51 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A82DA8760D
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 08:40:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40d5095834aso30339525e9.2
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 23:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703662848; x=1704267648; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RbsdqRhX3WUqbngc6X5DRSlO+A2MBqb6wJxlBenbfU8=;
 b=Ot+BDdD6PtnBd1Eug8rjbL/3sRQ0iaaGRIB0dPQ7CbDCvZ4Dmr+tXKyD/dj1+UhQUC
 3n7NtfSs5QEuTz1QBueYW1WAsu1/8sXgBMVDyTcuI/NO3B7BoljGQwgqqX4QLYO2HlCN
 7JwKRlgH9py1g/NOGkjubqzVnjVNRXBirz6hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703662848; x=1704267648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RbsdqRhX3WUqbngc6X5DRSlO+A2MBqb6wJxlBenbfU8=;
 b=ZCZ+2T8uofhzZcLUAIs4mzuwSgUlnGob8fEWKvWrAKxCt5jASqgMFwnw99j8G+Mvsf
 dJwfwyGsqjwyyp3ReAyyPegMr+Z2M2nYjNcko0sQevjlh7gFXV+d+oeFqK7Fgj8x219C
 0VSUhMpVjIJyPDbr2Zw4scma/B592UJ/c95NOCDZUxPkpGXHcSLhZXvNHF9Yn1AAX+KU
 ak1gpaHsZqt4Ec0siWqSEh1G5y3VnKAiZihGzhCBB550Z/CpK5wWxBVl6pTpG6+p88m7
 FHWEQy6XQeQNR9u/Y2NVrUw5FCViCOihyBWp7mX2C7Hi7kfEWNyluY7233M5LSdmK0Nl
 G2xA==
X-Gm-Message-State: AOJu0YwIuZJ75eBu6fvCvPUZ6ixvkaQEtnPRe0wGmLJweB1zB8JIgk3p
 /7+3CE3ybU03r/pceu0XBtXmt55uxowE9kEEM9BO87sIeJxk
X-Google-Smtp-Source: AGHT+IFHuINa0wnyilSBu6wN1vUNWJtKnz6jnZoHa3VrFpVp3BHBGjza0z3w2sv5NBe1EJCrpiE4nw==
X-Received: by 2002:a05:600c:ac5:b0:40d:5c8d:4947 with SMTP id
 c5-20020a05600c0ac500b0040d5c8d4947mr284237wmr.289.1703662847726; 
 Tue, 26 Dec 2023 23:40:47 -0800 (PST)
Received: from tasman.chapterst.org (80-42-48-87.dynamic.dsl.as9105.com.
 [80.42.48.87]) by smtp.gmail.com with ESMTPSA id
 s23-20020adf9797000000b00336813bb588sm14314426wrb.111.2023.12.26.23.40.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 23:40:47 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 3/7] smbios: SMBIOS 3.0 (64-bit) Entry Point structure
Date: Wed, 27 Dec 2023 07:40:20 +0000
Message-Id: <20231227074025.2178825-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231227074025.2178825-1-sjg@chromium.org>
References: <20231227074025.2178825-1-sjg@chromium.org>
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

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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

