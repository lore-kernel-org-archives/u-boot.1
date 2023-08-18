Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0CBBC678DC
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 00:29:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55A7A86C03;
	Fri, 18 Aug 2023 02:27:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MbcIKYcU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84F0F86C4C; Fri, 18 Aug 2023 02:27:30 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B852686C20
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 02:27:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-34bae82b2ffso1364605ab.1
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 17:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692318444; x=1692923244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b4qazxgbB9MhwNucuEcdU+mzcad4nCMSD/2jL6yYmUk=;
 b=MbcIKYcUBo50pfWNW6jKVIdZn85HBbHc8E3MKERiCnD+jJSBX0LopJPceIauNoTwP9
 +QfivztB8gBjZoQB8N20RJwyxTl+eXoGsB9M64xSntjb0EJIgE3gGXUtdSZAuL4hCJLL
 mLwHT80LbLhWgTuVTTWrSP0xivLusjKo8RLn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692318444; x=1692923244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b4qazxgbB9MhwNucuEcdU+mzcad4nCMSD/2jL6yYmUk=;
 b=VDaj/KurdxC2tLp2fUyv4PQn52IQ7R8mH+3/y95xRtWZZoU03ozV1oZAkVa/KiCqrs
 SbXaAVNuc48upj4oGz7bjMvoEIqvYVV+Sufulk9k8y3u26fzL00IgYF9pFQWbPEuArvG
 EpATUGM09Ex5yK9G+EOZUIjcYzFHsSvkPoUTvU789EDFis6Mtk9gf2Siju0rWT98GQ38
 V3glQ5OZ2b7nA0+1EIP2Ia5JNPLn6G6N3o5YDndP4zjpBrkxQWV3C4MZEzUs1oeJO6n3
 5PgRcrT+r/AaJS3xW1ef7nGiOhrFq1Mn5aIS5EB69HD8nb+6o5pbrpZaSbcYUd1kMn0e
 MFNw==
X-Gm-Message-State: AOJu0YzPg+20Rwn5FDynie7HAEW7T4pCbm9WFfeCsE0xrqyAN4U8akFS
 GiDyMpu3rfTfRKKo0i+QgbG6xDg2GEMx9ELVLXg=
X-Google-Smtp-Source: AGHT+IG1OrUKoz2Kh8j3EklOEW6hLhKBJgK/AWRybZqe8vYv6/cGREnMmY3Xw3XYo/WlK1NGHXbhrg==
X-Received: by 2002:a05:6e02:f48:b0:34a:8bb9:d7a9 with SMTP id
 y8-20020a056e020f4800b0034a8bb9d7a9mr1060440ilj.27.1692318444417; 
 Thu, 17 Aug 2023 17:27:24 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 i14-20020a056e02054e00b0034bad471d1fsm190376ils.3.2023.08.17.17.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 17:27:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Nikhil M Jain <n-jain1@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Stefan Roese <sr@denx.de>
Subject: [PATCH v2 13/20] x86: Record the position of the SMBIOS tables
Date: Thu, 17 Aug 2023 18:26:52 -0600
Message-ID: <20230818002706.853550-14-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230818002706.853550-1-sjg@chromium.org>
References: <20230818002706.853550-1-sjg@chromium.org>
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

Changes in v2:
- Add new patch

 arch/x86/include/asm/global_data.h | 1 +
 arch/x86/lib/tables.c              | 3 +++
 include/asm-generic/global_data.h  | 8 ++++++++
 3 files changed, 12 insertions(+)

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

