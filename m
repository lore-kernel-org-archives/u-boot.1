Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A750EE49A6
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 21:25:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA5C186D9C;
	Sat, 19 Aug 2023 23:23:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KQ3pjzCy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4FBC87005; Sat, 19 Aug 2023 23:23:32 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EF0C86F9B
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 23:23:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-79196067c75so65681539f.1
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 14:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692480208; x=1693085008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YFnAZd1+0Oaf6CcPCBpjM5Ca9kF4hN0iw6OTiq24ezs=;
 b=KQ3pjzCyWPMPrMWD8VQMF6Vk62Jmx9PyIIgRw/XZW1E8lLBqRu54bnHUYPzRqc09wP
 uUbi6ydPYgq9AdpsNwjezLYNfN7Ew4Rzka9oALBcnP3eMMcT53khiRvF5FqGR8Jk1xlP
 w3dTMJsZeq45IDs0iR9R+QwCfROOxdKkBSRpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692480208; x=1693085008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YFnAZd1+0Oaf6CcPCBpjM5Ca9kF4hN0iw6OTiq24ezs=;
 b=LhRuEtevWXvqu9G4rWhL0jZW6Lnx/yKq+l/RRZBX1+orOZm9vtZF/NYGG8aTJrHGwy
 PPsgIwRWODt2pUCFwYjTArj1jfzVMFiWvYF7eMuhoI+iMB+KY7o6cjdqTbC/bU+nQIkT
 BVCi3vIhI465jYw1wOGdZ0hE8JBjG8G0aqXoTWvX3ilq5G28BkNg5f/4zLIPIZ6SpgIn
 B7+/cRKohm+q/pd6AmN5CB1JOM8It8A+FqBIFJNLJoR2L8etcgW+xZdDigc334ncpYVL
 bncFJah51aJXpgAPvpJ0cABcpKIR+b0bZ7SJInwKEKgTAHZpG4QclOOCvdlQCRJRId6x
 7OAw==
X-Gm-Message-State: AOJu0YzDQXT5ZFRnrtfhmF9u5DmziOeek6hYPv7lo2Z+2P9wot/zjz1Z
 08L+0gfe9KHUTfP7lW4Gnyn0/wOy8jxn2scrkAY=
X-Google-Smtp-Source: AGHT+IGe6Wf3hF2lYt4HyyKtA45q8Er/zWEL1trbnqaqeJ00jcW86nCmXutNTd9bN4nrUANVM5hhew==
X-Received: by 2002:a5d:9390:0:b0:790:f866:d717 with SMTP id
 c16-20020a5d9390000000b00790f866d717mr3794077iol.10.1692480208130; 
 Sat, 19 Aug 2023 14:23:28 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 c22-20020a6bec16000000b00786f5990435sm1507256ioh.7.2023.08.19.14.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Aug 2023 14:23:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 13/19] x86: Record the position of the SMBIOS tables
Date: Sat, 19 Aug 2023 15:22:51 -0600
Message-ID: <20230819212309.1094440-14-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230819212309.1094440-1-sjg@chromium.org>
References: <20230819212309.1094440-1-sjg@chromium.org>
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

Remember where these end up so that we can pass this information on to
the EFI layer.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Add new patch

 arch/sandbox/include/asm/global_data.h | 1 +
 arch/x86/include/asm/global_data.h     | 1 +
 arch/x86/lib/tables.c                  | 3 +++
 include/asm-generic/global_data.h      | 8 ++++++++
 4 files changed, 13 insertions(+)

diff --git a/arch/sandbox/include/asm/global_data.h b/arch/sandbox/include/asm/global_data.h
index f0ab3ba5c146..c6977735029d 100644
--- a/arch/sandbox/include/asm/global_data.h
+++ b/arch/sandbox/include/asm/global_data.h
@@ -17,6 +17,7 @@ struct arch_global_data {
 	ulong table_end;		/* End address of x86 tables */
 	ulong table_start_high;		/* Start address of high x86 tables */
 	ulong table_end_high;		/* End address of high x86 tables */
+	ulong smbios_start;		/* Start address of SMBIOS table */
 };
 
 #include <asm-generic/global_data.h>
diff --git a/arch/x86/include/asm/global_data.h b/arch/x86/include/asm/global_data.h
index ea58259ad774..6f4a7130f1da 100644
--- a/arch/x86/include/asm/global_data.h
+++ b/arch/x86/include/asm/global_data.h
@@ -127,6 +127,7 @@ struct arch_global_data {
 	ulong table_end;		/* End address of x86 tables */
 	ulong table_start_high;		/* Start address of high x86 tables */
 	ulong table_end_high;		/* End address of high x86 tables */
+	ulong smbios_start;		/* Start address of SMBIOS table */
 };
 
 #endif
diff --git a/arch/x86/lib/tables.c b/arch/x86/lib/tables.c
index 67bc0a72aebc..5b5070f7ca57 100644
--- a/arch/x86/lib/tables.c
+++ b/arch/x86/lib/tables.c
@@ -97,6 +97,9 @@ int write_tables(void)
 		int size = table->size ? : CONFIG_ROM_TABLE_SIZE;
 		u32 rom_table_end;
 
+		if (!strcmp("smbios", table->name))
+			gd->arch.smbios_start = rom_addr;
+
 		if (IS_ENABLED(CONFIG_BLOBLIST_TABLES) && table->tag) {
 			if (!gd->arch.table_end)
 				gd->arch.table_end = rom_addr;
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 8fc205ded1a3..3421daea3632 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -552,6 +552,14 @@ static_assert(sizeof(struct global_data) == GD_SIZE);
 #define gd_set_acpi_start(addr)
 #endif
 
+#ifdef CONFIG_SMBIOS
+#define gd_smbios_start()	gd->smbios_start
+#define gd_set_smbios_start(addr)	gd->arch.smbios_start = addr
+#else
+#define gd_smbios_start()	0UL
+#define gd_set_smbios_start(addr)
+#endif
+
 #if CONFIG_IS_ENABLED(MULTI_DTB_FIT)
 #define gd_multi_dtb_fit()	gd->multi_dtb_fit
 #define gd_set_multi_dtb_fit(_dtb)	gd->multi_dtb_fit = _dtb
-- 
2.42.0.rc1.204.g551eb34607-goog

