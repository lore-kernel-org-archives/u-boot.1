Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37210C87FCA
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 21:51:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B75808396E;
	Thu, 31 Jul 2025 23:50:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=yngvason.is
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=yngvason.is header.i=@yngvason.is header.b="D8noIIZT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 503D683857; Thu, 31 Jul 2025 20:15:58 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09AE383927
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 20:15:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=yngvason.is
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andri@yngvason.is
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3b7910123a0so1217804f8f.1
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 11:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=yngvason.is; s=google; t=1753985755; x=1754590555; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O/4gQmNApAaEk+0JLQUftLNUXzigmx37hrE4IifsT8c=;
 b=D8noIIZTJ7UGP4flVaSfgY0epnzwLtKd6cX8/nUf8BBc9CkIk61QP8RZbFeLw/SzSU
 8LiChMJNYSTSZf/j3JM/hLGwq3efKHi3eQBRPQKk9FH4TdWR8GS94f2Bt4J9fitAqiQO
 /2hDMrXGtRIrqokCHa71u7HBuHY31f6YZ4XMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753985755; x=1754590555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O/4gQmNApAaEk+0JLQUftLNUXzigmx37hrE4IifsT8c=;
 b=GMAuiusVGNFAO9m/GqwFVVXOtouZKzvGrk18n4NGVVtKTiMSBLbLTxe63ODGkHgU3J
 XBg+gHqM14hL5mCfqX3D+pimm70zaWIzcM4DiK/fi0IJC0BxE/HfI7Zi/Y9b/mKEySsX
 e9HjIKc/APxSupfad1/1WZNrn3c9Dwlo7RLlB6BIv556BTeLmWuGNxpZSWQLz0zvKPpy
 cwdlR/FNCHIC6msFhwCd5hpvUF+6OGCt1T5E6Z7D4d3cjMqVUWZzogW+VF5FuZvp5TuF
 xUPD8C05tnpVoiFdnCScWjKZ+poq+GkPbU66ratPk1QtTpH97alxgALQPcQSjEdwDnQU
 UU/w==
X-Gm-Message-State: AOJu0YwxNAXTE93PzPuOmRN3huF19SoZla3/8apnNyp61mPsoD2tGuAS
 bXSSj8VuRpF4bdtNtSPl/R79v4r1bYQGL9Cuz69QFJ8cq6Fq6EPEcCtL72S7ZHevFmOlZtMcEW4
 3c0x8bpJ1xw==
X-Gm-Gg: ASbGncuaJ7zTJzve42SNVSNI4smFqpD0NUJvX/ayUDeRH3oNFBQJ2iWgnkq45su2jXz
 sjDGaKk3TWvI7KE/WWLsxPsXFSFhWLxhb+A6DU/3fLFummbVGHVJXotMUytitySOO+auteiiFG5
 tXCYohMpfY/n+5PRKaXCIi35ailuss3NaWsrQ1rCZeHlIcPh1uuKNQ1MwEvJKIOzt/FpCi1DaGS
 WLfV4349gpLUJ7ymZyR+oNBaQl0cQFEEum2RhEHVoxW5t0ZPP3UajfsQrSosp+tS29pTizfk8Ch
 VebXqHvW+KREst2NKB6STe65bq6m1KpBGq7ocEspNFLllUIYeDIkFpDRKEzuMQGadsj5QfXR2U/
 NRHepYFN3/J/I6QYFbU/9UzzQ/wx0yRUVYmAUD9kyOTZgqTK0+P9GArMgnRo=
X-Google-Smtp-Source: AGHT+IH4ptxmig3H0bbgeNMR3n2a9SHGa7ytLIZerqOyUtr6xFaF5HHSakGZmFblEE7ABwfJZH0uWQ==
X-Received: by 2002:a05:6000:26d1:b0:3b7:930a:bb25 with SMTP id
 ffacd0b85a97d-3b795029b20mr5815262f8f.39.1753985755216; 
 Thu, 31 Jul 2025 11:15:55 -0700 (PDT)
Received: from andri-workstation.turninn.appdynamic.com
 ([2a01:8280:aa07:ad:7285:c2ff:fef0:4baf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3abedesm3236129f8f.3.2025.07.31.11.15.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 11:15:54 -0700 (PDT)
From: Andri Yngvason <andri@yngvason.is>
To: u-boot@lists.denx.de
Cc: Andri Yngvason <andri@yngvason.is>
Subject: [PATCH 2/2] Forward chosen raw mmc A/B sector to OS
Date: Thu, 31 Jul 2025 18:15:33 +0000
Message-ID: <20250731181533.1872390-3-andri@yngvason.is>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250731181533.1872390-1-andri@yngvason.is>
References: <20250731181533.1872390-1-andri@yngvason.is>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 31 Jul 2025 23:50:52 +0200
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

This adds a property named u-boot,mmc-boot-sector to the /chosen node in
the device tree. It can be either "a" or "b", based on which sector was
chosen by the SPL to boot U-Boot Proper.

This makes it possible to check from the OS if an upgrade to U-Boot was
successful before committing to it.

The way this is intended to be used is as follows:

 - Write new U-Boot image to the sector that's currently unused
 - Write 00 XX to control sector, where XX = 1 for A and 2 for B
 - Reboot
 - If u-boot,mmc-boot-sector contains the correct value, update the
   control sector to boot from the new U-Boot.
 - If it contains the wrong value, then the update must have failed.

Signed-off-by: Andri Yngvason <andri@yngvason.is>
---
 boot/fdt_support.c   | 20 ++++++++++++++++++++
 common/bloblist.c    |  1 +
 common/spl/spl_mmc.c | 21 ++++++++++++++++++++-
 include/bloblist.h   |  1 +
 include/spl.h        |  9 +++++++++
 5 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/boot/fdt_support.c b/boot/fdt_support.c
index b7331bb76b3..309f3726314 100644
--- a/boot/fdt_support.c
+++ b/boot/fdt_support.c
@@ -27,6 +27,8 @@
 #include <fdtdec.h>
 #include <version.h>
 #include <video.h>
+#include <bloblist.h>
+#include <spl.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -342,6 +344,7 @@ int fdt_chosen(void *fdt)
 	int   nodeoffset;
 	int   err;
 	const char *str;		/* used to set string properties */
+	__maybe_unused struct spl_mmcsd_raw_ab_handoff *handoff;
 
 	err = fdt_check_header(fdt);
 	if (err < 0) {
@@ -396,6 +399,23 @@ int fdt_chosen(void *fdt)
 		return err;
 	}
 
+	if (IS_ENABLED(CONFIG_BLOBLIST) &&
+	    IS_ENABLED(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR_AB)) {
+		handoff = bloblist_find(BLOBLISTT_MMCSD_RAW_AB,
+					sizeof(struct spl_mmcsd_raw_ab_handoff));
+		if (handoff) {
+			err = fdt_setprop(fdt, nodeoffset, "u-boot,mmc-boot-sector",
+					  handoff->sector == SPL_MMCSD_RAW_B_SECTOR ? "b" : "a", 2);
+			if (err < 0) {
+				printf("WARNING: could not set u-boot,mmc-boot-sector %s.\n",
+				       fdt_strerror(err));
+				return err;
+			}
+		} else {
+			printf("WARNING: Missing mmc a/b boot sector\n");
+		}
+	}
+
 	return fdt_fixup_stdout(fdt, nodeoffset);
 }
 
diff --git a/common/bloblist.c b/common/bloblist.c
index 6e4f020d7c4..cafa2036084 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -61,6 +61,7 @@ static struct tag_name {
 	{ BLOBLISTT_U_BOOT_SPL_HANDOFF, "SPL hand-off" },
 	{ BLOBLISTT_VBE, "VBE" },
 	{ BLOBLISTT_U_BOOT_VIDEO, "SPL video handoff" },
+	{ BLOBLISTT_MMCSD_RAW_AB, "MMC raw A/B boot sector" },
 
 	/* BLOBLISTT_VENDOR_AREA */
 };
diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index f4a1a3425b5..22cea00bc96 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -16,6 +16,7 @@
 #include <mmc.h>
 #include <image.h>
 #include <imx_container.h>
+#include <bloblist.h>
 
 static ulong h_spl_load_read(struct spl_load_info *load, ulong off,
 			     ulong size, void *buf)
@@ -330,6 +331,7 @@ int __weak spl_mmc_emmc_boot_partition(struct mmc *mmc)
 #ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR_AB
 unsigned long spl_mmc_get_raw_ab_sector(struct mmc *mmc, unsigned long raw_sect)
 {
+	__maybe_unused struct spl_mmcsd_raw_ab_handoff *handoff;
 	u8 buf[512];
 	int ret = blk_dread(mmc_get_blk_desc(mmc),
 			CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_AB_CONTROL_SECTOR,
@@ -357,7 +359,7 @@ unsigned long spl_mmc_get_raw_ab_sector(struct mmc *mmc, unsigned long raw_sect)
 			raw_sect = CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR_B;
 			puts("Selected mmc raw sector B\n");
 		}
-		return raw_sect;
+		goto out;
 	}
 
 	buf[1] = 0xff;
@@ -370,6 +372,23 @@ unsigned long spl_mmc_get_raw_ab_sector(struct mmc *mmc, unsigned long raw_sect)
 	}
 
 out:
+	if (IS_ENABLED(CONFIG_BLOBLIST)) {
+		ret = bloblist_ensure_size(BLOBLISTT_MMCSD_RAW_AB,
+					   sizeof(struct spl_mmcsd_raw_ab_handoff),
+					   0, (void **)&handoff);
+		if (ret)
+			return raw_sect;
+
+		switch (raw_sect) {
+		case CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR:
+			handoff->sector = SPL_MMCSD_RAW_A_SECTOR;
+			break;
+		case CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR_B:
+			handoff->sector = SPL_MMCSD_RAW_B_SECTOR;
+			break;
+		}
+	}
+
 	return raw_sect;
 }
 #endif
diff --git a/include/bloblist.h b/include/bloblist.h
index f32faf78560..bf50b82ef3c 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -153,6 +153,7 @@ enum bloblist_tag_t {
 	BLOBLISTT_U_BOOT_SPL_HANDOFF	= 0xfff000, /* Hand-off info from SPL */
 	BLOBLISTT_VBE			= 0xfff001, /* VBE per-phase state */
 	BLOBLISTT_U_BOOT_VIDEO		= 0xfff002, /* Video info from SPL */
+	BLOBLISTT_MMCSD_RAW_AB		= 0xfff003, /* MMC A/B Sector from SPL */
 };
 
 /**
diff --git a/include/spl.h b/include/spl.h
index 7736b00c474..e1895db736b 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -804,6 +804,15 @@ struct spl_image_loader {
 			  struct spl_boot_device *bootdev);
 };
 
+enum spl_mmcsd_raw_ab_sector {
+	SPL_MMCSD_RAW_A_SECTOR = 0,
+	SPL_MMCSD_RAW_B_SECTOR,
+};
+
+struct spl_mmcsd_raw_ab_handoff {
+	enum spl_mmcsd_raw_ab_sector sector;
+};
+
 /* Helper function for accessing the name */
 static inline const char *spl_loader_name(const struct spl_image_loader *loader)
 {
-- 
2.50.0

