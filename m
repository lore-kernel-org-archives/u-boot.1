Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89504E6780A
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 20:28:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE79889559;
	Sun, 24 Nov 2024 21:27:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ca50aFmA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC42189920; Sun, 24 Nov 2024 21:27:45 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E40889550
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 21:27:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aa51bf95ce1so343427866b.3
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 12:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732480061; x=1733084861; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lpUxQwwmFw9bFeiYwkmIFnE5Thzcl48LnnV2hQz+scM=;
 b=Ca50aFmAm4s+J+rfsnQ8GJXaL6ggfKh0v5F/mXJ5Hrk56cs5msxxSX0B1l3ToGZnYQ
 vIni8HgKC2Odw7DmMoXIT7zF3gEKxc+b40qQHQl5ps7P60LOAzG1sG1WItQY+Idr6bYL
 yn3jO0i5GUpAsuu4BUwdfeCLlDTfvHCN7fhdyGlKh4H3SsYjBa6Hb1duYL+GkoKuPTc4
 YKVslKtJjQG6XPWNS7St9Un0yvhST02ALQSBgMw245HxCjsmAIfz5+avMtsWx1r9G84f
 aGd2pCOL0Lp8Lf0HJZNs5XvxSoXFZzZFetPLLaYRjLxcgF9ue79y8r/WsBQ1Eku9M6vO
 1rsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732480061; x=1733084861;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lpUxQwwmFw9bFeiYwkmIFnE5Thzcl48LnnV2hQz+scM=;
 b=hS0wW6vvf8mj1IbSVAPaUtr2hz/Bgdmji47npV40HOIGrmbklaS+z762NDKeEp9p+9
 78B29nsWt5LDrVeerXwZ0NRISJ+hoeKk0GbUPq3Hif3GzqyKJUpHQhmM9Hgr4iqPk6le
 XMYTT6nVE/LTktXO+FYJc2a08bpSCDuviXHTBGbR8JI374pn9w+I4o996+x+HkJ9CXcA
 SDbHm53DtCQhMRpuV9xNzY1JUy8b91C959eKOnBUf5j3qrltiqpANk7L78QJZ3Ealv9t
 x+zcJ2Q7bDH/BVRtNj2+bKa02iARofTXrxtypi8hoWZg+RqNkYIJNW5EJLteavqlih0P
 3BQw==
X-Gm-Message-State: AOJu0Yxbxq2Up/QC0iaRPBzugGPRzYDyqvZorj6sezN5AIRDmbnO1e1o
 65+NiN137UkiLokLRr8iIesMznIdgfUblUNfpCYPmS4tZ0oyJAAUIP77G5Djz5A=
X-Gm-Gg: ASbGncucR8nYnvLT68Zs+rdTejjzpAi7tav4WF2ie2EcSJYjd0hO7kx3nvx2gf7qbK9
 pfDGR6F9xqtQ5vznFqmbzDBZSoDR7LzffvHDjdjkBlEoeOrRl611j7XyVp6LbpEvZSOa3afXQPa
 SxBr4mxhEMoR4ISCyNjf8zDg3A5bkRrpP8qBJRa4VMhcV+hxkhXwuL8GFomW5Y/y/E4+CeNP266
 mA92n1r08YJErDW1t9VxNPh/Fo9nWPzsQ+US3u8T32cjL6JBzkBVIjnVHMMUj4b2PzC
X-Google-Smtp-Source: AGHT+IEedJP07bSntoO/P7fod1RYjz894k9G9PlKJHLJ7T6a7gt+EQk+0uDt/NAEiGIHlfDlYP+5zA==
X-Received: by 2002:a17:906:319a:b0:aa5:1957:3431 with SMTP id
 a640c23a62f3a-aa5195742demr843942366b.1.1732480061661; 
 Sun, 24 Nov 2024 12:27:41 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa50b28cda1sm378720666b.9.2024.11.24.12.27.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 12:27:41 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Sun, 24 Nov 2024 21:27:03 +0100
Subject: [PATCH RFC 07/14] efi: stub: add known memory to U-Boot's EFI
 memory map
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241124-b4-efistub-arm64-v1-7-3e33f0340071@linaro.org>
References: <20241124-b4-efistub-arm64-v1-0-3e33f0340071@linaro.org>
In-Reply-To: <20241124-b4-efistub-arm64-v1-0-3e33f0340071@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Anatolij Gustschin <agust@denx.de>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3219;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=82PHdaNRpiJtg6jlRroX7Blcj1PA8ll6Md2RMXHogzk=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhnTnHqMuzetZmp/+Fj7yYVT4vHB5TqDmxlNxEm2MAiv5d
 3UzLtzaUcrCIMjBICumyCJ+Ypll09rL9hrbF1yAmcPKBDKEgYtTACbSYsXwv3aZ/kyO6dNXM/zk
 Wr+It+Zuc/LB594+DeXJs2eyJgYxb2Fk2FW94qVC4bucmFklvI/WBD69Gtrpp5G/9jRPyHXZ1Jr
 4XQA=
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

When running U-Boot as an EFI payload with CONFIG_EFI_STUB, the reserved
regions from the previous stage EFI bootloader should be carried over
since they may not fully align with the reserved-memory regions in
devicetree.

Implement a helper to map these pages when the EFI subsystem starts up.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 include/efi_stub.h          |  7 +++++++
 lib/efi/efi_info.c          | 31 +++++++++++++++++++++++++++++++
 lib/efi_loader/efi_memory.c |  5 +++++
 3 files changed, 43 insertions(+)

diff --git a/include/efi_stub.h b/include/efi_stub.h
index ff3befd4830b..343c84435970 100644
--- a/include/efi_stub.h
+++ b/include/efi_stub.h
@@ -56,5 +56,12 @@ int of_populate_from_efi(struct device_node *root);
  * EFI payload with CONFIG_EFI_STUB enabled.
  */
 int dram_init_banksize_from_efi(void);
 
+/**
+ * efi_add_known_memory_from_efi() - Add known memory pages from the memory map
+ * of the EFI bootloader that booted U-Boot. This is only applicable when running
+ * U-Boot as an EFI payload with CONFIG_EFI_STUB enabled.
+ */
+void efi_add_known_memory_from_efi(void);
+
 #endif /* _EFI_STUB_H */
diff --git a/lib/efi/efi_info.c b/lib/efi/efi_info.c
index f9743a3e7fad..ef4e646b082b 100644
--- a/lib/efi/efi_info.c
+++ b/lib/efi/efi_info.c
@@ -5,8 +5,9 @@
  * Access to the EFI information table
  */
 
 #include <efi.h>
+#include <efi_loader.h>
 #include <efi_stub.h>
 #include <errno.h>
 #include <mapmem.h>
 #include <asm/global_data.h>
@@ -177,4 +178,34 @@ int dram_init_banksize_from_efi(void)
 	}
 
 	return 0;
 }
+
+/* Called by U-Boot's EFI subsystem to add known memory. In our case
+ * we need to add some specific memory types from the original bootloaders
+ * EFI memory map
+ */
+void efi_add_known_memory_from_efi(void)
+{
+	struct efi_mem_desc *desc, *end;
+	struct efi_entry_memmap *map;
+	int ret, size;
+
+	EFI_PRINT("Adding known memory from previous stage EFI bootloader\n");
+
+	ret = efi_info_get(EFIET_MEMORY_MAP, (void **)&map, &size);
+	if (ret) {
+		EFI_PRINT("%s: Missing memory map\n", __func__);
+		return;
+	}
+	end = (struct efi_mem_desc *)((ulong)map + size);
+
+	for (desc = map->desc; desc < end; desc = efi_get_next_mem_desc(desc, map->desc_size)) {
+		switch (desc->type) {
+		case EFI_RESERVED_MEMORY_TYPE:
+			efi_add_memory_map_pg(desc->physical_start, desc->num_pages, desc->type, false);
+			break;
+		default:
+			continue;
+		}
+	}
+}
diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index d2f5d563f2a0..50b0010608e7 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -7,8 +7,9 @@
 
 #define LOG_CATEGORY LOGC_EFI
 
 #include <efi_loader.h>
+#include <efi_stub.h>
 #include <init.h>
 #include <lmb.h>
 #include <log.h>
 #include <malloc.h>
@@ -834,8 +835,12 @@ static void add_u_boot_and_runtime(void)
 int efi_memory_init(void)
 {
 	efi_add_known_memory();
 
+#ifdef CONFIG_EFI_STUB
+	efi_add_known_memory_from_efi();
+#endif
+
 	add_u_boot_and_runtime();
 
 #ifdef CONFIG_EFI_LOADER_BOUNCE_BUFFER
 	/* Request a 32bit 64MB bounce buffer region */

-- 
2.47.0

