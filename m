Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB0BCE79A9
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 03:03:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3213286C85;
	Wed, 20 Sep 2023 05:00:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IaTd03tf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DCFE86C70; Wed, 20 Sep 2023 05:00:47 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3928C86BC4
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 05:00:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-34fcd36c86eso13623455ab.0
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695178844; x=1695783644; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8mTL3TExfqkC4D5DmsYWTygmSJA1qDRpwvuLA8K/7Gw=;
 b=IaTd03tfL+m4+qkW45c3+tnUb+BxBWOFBM8n/kNkUBESnilN1MTJ7zTeNwgDsZ9zNb
 sBWxZDD1nTUllNYUbBMM11R7WHuhBgbeMTM/7+eyMl36vkoX1vzuwJ8+qAkeRY+8dChu
 3p0mJYbR+vYjZxvE3ZxO+NrDZ3hvO05Y32amc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695178844; x=1695783644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8mTL3TExfqkC4D5DmsYWTygmSJA1qDRpwvuLA8K/7Gw=;
 b=bJEVsni7PrKl1jTMSPsKsM4ynCfgdiKKz2q+qGQXtPQpsM2+uTMX3/oK14lJwCxGVG
 J3iLmoDubM6Mbw7OfqqUNpTXKA7/dY+673wG7gPKgpiLruYvVnzCMgux8pr2rzkX/AX3
 YH0Qr/cNeGoQw2C3Lbjz+J5TuagBkWcqGzSuBhP4OKOXGrCnoTHO3zWFvxcUBbE6A3ma
 K/H9egmYuS739hy0hXhOB7muKlsJsEoSg2bHIv341bvUY644SHi9fo7I78Tx3oEvH5N+
 ABuv8WOY4g7FL3/qjktxGxrj8g1qZZSKk5oaBT9dTPo3B1qsYu5By6a8jf8y8Uid3+JM
 kwRg==
X-Gm-Message-State: AOJu0Yxo6TTBVbdr3fZsKa5IBO0kCN64yUeSIeFrc3BYeWlUt0Ki4unZ
 q2+OuRLXp0aH1Kvl5oeQLE6yI7nrs8eblofVB4k=
X-Google-Smtp-Source: AGHT+IGBbgHb7SHLnv2Xv98P5ru18GVM6Xg3uSjq0wzTNKIzofj0YfxlXbQ4QtwhwmYFO8DNi7enRw==
X-Received: by 2002:a05:6e02:b22:b0:350:f0bb:6a3b with SMTP id
 e2-20020a056e020b2200b00350f0bb6a3bmr1962258ilu.17.1695178843874; 
 Tue, 19 Sep 2023 20:00:43 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 s5-20020a92d905000000b0034feb68437fsm1835423iln.24.2023.09.19.20.00.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 20:00:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 14/20] Record the position of the SMBIOS tables
Date: Tue, 19 Sep 2023 21:00:15 -0600
Message-ID: <20230920030027.1385833-15-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230920030027.1385833-1-sjg@chromium.org>
References: <20230920030027.1385833-1-sjg@chromium.org>
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
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---

(no changes since v4)

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
index 2a222c53882a..b385bae02669 100644
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
index 9d97517e124c..937fa4d15446 100644
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
2.42.0.459.ge4e396fd5e-goog

