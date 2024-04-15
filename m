Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3D1C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 11:51:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A1C888089;
	Mon, 15 Apr 2024 13:50:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="FxA1uoaH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E9FD8814A; Mon, 15 Apr 2024 13:50:56 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9BBF88158
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 13:50:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3E5AF3F44E
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 11:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1713181853;
 bh=4NAFeDaUZWPrleNuu1mePXnsMZQ5brYAVWCYoD/L+70=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=FxA1uoaH+5z86dD9XcwhcX6wiZMbVZMuW62IGbz82Xzvfar6TL7MZE22dVhx67eNu
 DTyZI8k1HfLXk8WvGuQP5zApq1m38cqY+E6etwECGUQm+TN5jRNi7MnN1E2vIgJRju
 CRTh1/zywK8YsQ9Mff0DcSDyjIN9vzWXL6RBNSVPFz0uzN0yx3U6PDqZOp7gAUAEKr
 5AKjkCgcMaosEj3LTAC/lSsj5o4JEs4m8lW83w4qrmrQmBiLGJ5+z7dxGHSCJTnn1M
 xq7j6CilLc7elttqq8Esc2xo5oqIGm+2R4VgF1x3OZ6T01KLC7OZ3Kn3oJRwAp4VHw
 wY0pJSUFXSAyw==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-343da0a889dso2451389f8f.0
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 04:50:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713181853; x=1713786653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4NAFeDaUZWPrleNuu1mePXnsMZQ5brYAVWCYoD/L+70=;
 b=PMIEah5CZW6v7AJWRSQGves1/Y1ELZ9ZKPwrXcCckvA0BGDaf6dr2i0K5wiLLxcqKV
 z7l18ZHrfDOGbOKFXTKJm9vjiO/kv7Cvf3SuPqcOr90UZ8cMjNpe7YGwIiFC1YU0Raaq
 mSIELXsAzEfQtr3TAFStzmUr5FJ7MgH5/uGtkBg1j7oN5u/saOwAOispmGNM61rFTMc3
 MRB7KwGvzgyNPPMfF3p/xxIgID+gDDNT+ZnwvTbG6r8bdGbu9U/axEehwOfNXlb660gG
 FJozjFJPn9GpQsQfzL0sX+zZ85qD5xXdAl/ViPKtXM+ZQw1FnQtqTX6k4eSinW0vV8TJ
 gDpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9XHzo6MdmH2FEwl0/ik/yndxBJitmqLiT6/HozwTeDIWVC/NiYltqbZxeMCO5ThPz3IuNVGcQUIrXTfbdT5ypp+mgaQ==
X-Gm-Message-State: AOJu0YxIuEF2kP5Bcd49wMBKO63IN7QauJKYq16xTS/y0viHai2IK+Gh
 qnbKNi93thu+P6KxZzC+SIAXoznYEhPkEYfoubXiB+EbvK6xX4dxqYmBh5jrHACnmRLeJ50cs0j
 C+7RSu4bJX1L0K0xbzAC0ir2nhuyobaxXOWjN82fkA7GZg5vVQscOWDFcBKMR3sHIPLk=
X-Received: by 2002:adf:e28a:0:b0:343:78da:9817 with SMTP id
 v10-20020adfe28a000000b0034378da9817mr6979830wri.68.1713181852945; 
 Mon, 15 Apr 2024 04:50:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjMRvcYv8q57FF7DfXRnwc/fP0JfzSiRZ4W2ugthec/62XdHQl2ISVHz7s14azjzikkQIkZw==
X-Received: by 2002:adf:e28a:0:b0:343:78da:9817 with SMTP id
 v10-20020adfe28a000000b0034378da9817mr6979816wri.68.1713181852541; 
 Mon, 15 Apr 2024 04:50:52 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 j10-20020adff00a000000b003469e7f5c52sm11924130wro.80.2024.04.15.04.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 04:50:52 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
Cc: Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Shengyu Qu <wiagn233@outlook.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, E Shattow <lucent@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/4] board: add support for Milk-V Mars CM
Date: Mon, 15 Apr 2024 13:50:33 +0200
Message-ID: <20240415115035.46199-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415115035.46199-1-heinrich.schuchardt@canonical.com>
References: <20240415115035.46199-1-heinrich.schuchardt@canonical.com>
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

We already support the VisionFive 2 and the Milk-V Mars board by
patching the VisionFive 2 device tree. With this patch the same
is done for the Milk-V Mars CM.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 board/starfive/visionfive2/spl.c              | 27 ++++++++++++++++++-
 .../visionfive2/starfive_visionfive2.c        | 11 +++++++-
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index 45848db6d8b..bb0f28d7aad 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -129,6 +129,29 @@ void spl_fdt_fixup_mars(void *fdt)
 	}
 }
 
+void spl_fdt_fixup_marc(void *fdt)
+{
+	const char *compat;
+	const char *model;
+
+	spl_fdt_fixup_mars(fdt);
+
+	if (!get_mmc_size_from_eeprom()) {
+		int offset;
+
+		model = "Milk-V Mars CM SDCard";
+		compat = "milkv,mars-cm-sdcard\0starfive,jh7110";
+
+		offset = fdt_path_offset(fdt, "/soc/pinctrl/mmc0-pins/mmc0-pins-rest");
+		fdt_setprop_u32(fdt, offset, "pinmux", 0xff130016);
+	} else {
+		model = "Milk-V Mars CM eMMC";
+		compat = "milkv,mars-cm-emmc\0starfive,jh7110";
+	}
+	fdt_setprop(fdt, fdt_path_offset(fdt, "/"), "compatible", compat, sizeof(compat));
+	fdt_setprop_string(fdt, fdt_path_offset(fdt, "/"), "model", model);
+}
+
 void spl_fdt_fixup_version_a(void *fdt)
 {
 	static const char compat[] = "starfive,visionfive-2-v1.2a\0starfive,jh7110";
@@ -236,7 +259,9 @@ void spl_perform_fixups(struct spl_image_info *spl_image)
 		pr_err("Can't read EEPROM\n");
 		return;
 	}
-	if (!strncmp(product_id, "MARS", 4)) {
+	if (!strncmp(product_id, "MARC", 4)) {
+		spl_fdt_fixup_marc(spl_image->fdt_addr);
+	} else if (!strncmp(product_id, "MARS", 4)) {
 		spl_fdt_fixup_mars(spl_image->fdt_addr);
 	} else if (!strncmp(product_id, "VF7110", 6)) {
 		version = get_pcb_revision_from_eeprom();
diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/starfive/visionfive2/starfive_visionfive2.c
index a86bca533b2..be6ca85b030 100644
--- a/board/starfive/visionfive2/starfive_visionfive2.c
+++ b/board/starfive/visionfive2/starfive_visionfive2.c
@@ -17,6 +17,10 @@
 DECLARE_GLOBAL_DATA_PTR;
 #define JH7110_L2_PREFETCHER_BASE_ADDR		0x2030000
 #define JH7110_L2_PREFETCHER_HART_OFFSET	0x2000
+#define FDTFILE_MILK_V_MARC_SD \
+	"starfive/jh7110-milkv-mars-cm-sdcard.dtb"
+#define FDTFILE_MILK_V_MARC_MMC \
+	"starfive/jh7110-milkv-mars-cm-emmc.dtb"
 #define FDTFILE_MILK_V_MARS \
 	"starfive/jh7110-milkv-mars.dtb"
 #define FDTFILE_VISIONFIVE2_1_2A \
@@ -61,7 +65,12 @@ static void set_fdtfile(void)
 		log_err("Can't read EEPROM\n");
 		return;
 	}
-	if (!strncmp(product_id, "MARS", 4)) {
+	if (!strncmp(product_id, "MARC", 4)) {
+		if (get_mmc_size_from_eeprom())
+			fdtfile = FDTFILE_MILK_V_MARC_MMC;
+		else
+			fdtfile = FDTFILE_MILK_V_MARC_SD;
+	} else if (!strncmp(product_id, "MARS", 4)) {
 		fdtfile = FDTFILE_MILK_V_MARS;
 	} else if (!strncmp(product_id, "VF7110", 6)) {
 		version = get_pcb_revision_from_eeprom();
-- 
2.43.0

