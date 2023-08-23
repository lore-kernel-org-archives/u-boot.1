Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1303C3DA6F
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 21:13:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3248864F9;
	Wed, 23 Aug 2023 23:11:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Sq07p7+p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D44558651B; Wed, 23 Aug 2023 23:11:22 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7E8E864CB
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 23:11:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-34ca22e3b3dso13781195ab.3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 14:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692825079; x=1693429879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TGvjMimKFvDFVcc1H8qPvijZldQcIb+oy8bX3OMtNMI=;
 b=Sq07p7+pl3l2VG8syxY3Mh/xbOeX5stYFL2QeKKXNmGLGzq6lPcg56VjFk2/o91YZy
 jpEGNQ+N/md30XtxgBZzWZswN9dYZH+1xb+G3Br7SYIzrMj2+QPQVdE+y5YPUWMTl7m9
 oIszcVJcZsFBky+OqGTFR3DcKeiZnfVqGUIcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692825079; x=1693429879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TGvjMimKFvDFVcc1H8qPvijZldQcIb+oy8bX3OMtNMI=;
 b=cpjMl+toYH3UFYXkMNcjSZ9g/Q1WHNKxVNeOl80jNpeUC+do/xvxUtprB+xtmp4W5w
 +7kNBN0vgL0Tn53Yup9qk8DFzPgl7YYfhyxNYvw1eHrwcpmOz091L/mnH4D8Torjax4V
 m/RhHinEtyZCioeiXCyRI/MkRwrOUuO87ywP4RmpfUsmSdLpuIs/+TKpdZq5Zb67hvUF
 s1XJiAXDim7MklaLcNJMLYm5JKRR5iJ2UD7FtOs24IHR+uYHGubHrnmsyaI1jeF7HWwZ
 weQrHLtDv+SYJMhWcwSwsqj/ycDyia6VWMU9lGCfDTzfWGKn6lYWXrjwx4wW37cOvJxx
 90WA==
X-Gm-Message-State: AOJu0YwHu1CxUj8y76VStGMPRCUr6uuMctFwFizevy+O9xsyoT6JL/zd
 6WESj8V7GN0avFcKYcQn4DsTciEjdmz74CF4sXQ=
X-Google-Smtp-Source: AGHT+IEeBNX41NVO0ET91hQ7U2jIZWEnrU6XejK6QKkNN2pUViUVt00fRy4iyoG1+rQGQPbmve+MEw==
X-Received: by 2002:a05:6e02:1189:b0:349:865d:9fb with SMTP id
 y9-20020a056e02118900b00349865d09fbmr3606500ili.5.1692825079243; 
 Wed, 23 Aug 2023 14:11:19 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:938f:460b:b19c:dee2])
 by smtp.gmail.com with ESMTPSA id
 c15-20020a02c9cf000000b0041627abe120sm3921075jap.160.2023.08.23.14.11.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 14:11:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 14/20] Record the position of the SMBIOS tables
Date: Wed, 23 Aug 2023 15:10:31 -0600
Message-ID: <20230823211059.1235147-15-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230823211059.1235147-1-sjg@chromium.org>
References: <20230823211059.1235147-1-sjg@chromium.org>
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

Changes in v4:
- Fix arm and riscv

Changes in v2:
- Add new patch

 arch/arm/include/asm/global_data.h     | 3 +++
 arch/riscv/include/asm/global_data.h   | 3 +++
 arch/sandbox/include/asm/global_data.h | 1 +
 arch/x86/include/asm/global_data.h     | 1 +
 arch/x86/lib/tables.c                  | 3 +++
 include/asm-generic/global_data.h      | 8 ++++++++
 6 files changed, 19 insertions(+)

diff --git a/arch/arm/include/asm/global_data.h b/arch/arm/include/asm/global_data.h
index 2a222c53882..b385bae0266 100644
--- a/arch/arm/include/asm/global_data.h
+++ b/arch/arm/include/asm/global_data.h
@@ -102,6 +102,9 @@ struct arch_global_data {
 #ifdef CONFIG_ARCH_IMX8ULP
 	bool m33_handshake_done;
 #endif
+#ifdef CONFIG_SMBIOS
+	ulong smbios_start;		/* Start address of SMBIOS table */
+#endif
 };
 
 #include <asm-generic/global_data.h>
diff --git a/arch/riscv/include/asm/global_data.h b/arch/riscv/include/asm/global_data.h
index 9d97517e124..937fa4d1544 100644
--- a/arch/riscv/include/asm/global_data.h
+++ b/arch/riscv/include/asm/global_data.h
@@ -32,6 +32,9 @@ struct arch_global_data {
 	ulong available_harts;
 #endif
 #endif
+#ifdef CONFIG_SMBIOS
+	ulong smbios_start;		/* Start address of SMBIOS table */
+#endif
 };
 
 #include <asm-generic/global_data.h>
diff --git a/arch/sandbox/include/asm/global_data.h b/arch/sandbox/include/asm/global_data.h
index f0ab3ba5c14..c6977735029 100644
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
index ea58259ad77..6f4a7130f1d 100644
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
index 67bc0a72aeb..5b5070f7ca5 100644
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
index 8fc205ded1a..3421daea363 100644
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

