Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE0FD7308D
	for <u-boot@archiver.kernel.org>; Sat,  4 Apr 2026 15:28:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B729184180;
	Sat,  4 Apr 2026 17:27:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="j0CpTbU+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 492C284129; Sat,  4 Apr 2026 17:27:07 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B42483A8C
 for <u-boot@lists.denx.de>; Sat,  4 Apr 2026 17:27:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43cf906b007so1483612f8f.0
 for <u-boot@lists.denx.de>; Sat, 04 Apr 2026 08:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1775316424; x=1775921224;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pvGO0HArPxKblfO1hvPOj1oWNQ73LOhu35jHyXZXYrs=;
 b=j0CpTbU+1HsmuWshvi5WVETq97en7oyTSjWFR4O0p1Iu+5ArlVGegYvQgoiojjr0s5
 S3MUfPid8561P18HV8QuaS/MyxhWJpyXARsb2JN6bS5MlVkxAIe0S7wPvfQojjNzPVu4
 TyhXcPIVWbboYY4AE+nPJBvI4CKaRNRqUW3CM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775316424; x=1775921224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pvGO0HArPxKblfO1hvPOj1oWNQ73LOhu35jHyXZXYrs=;
 b=tCJZDWd0Y6VThbUgjXOwuVSbEsWzK7u4JYW1HEbQsEHWb7S4BuS3h4znebOgrIViv1
 /kR7zFSl9YaQcYwJEQxuld9hC25UtYABb8qnAOY0PhbAUd5MKMnr+7FHsRvff/ZTK1mW
 l8VXhgP0AohurU/kPA5mAkSYToRKFDrU3cfV7s79WyYQdmHY+sTKIA2bKLQtu80Mb32W
 AIzSfvsIlYUPjHAL50TKsRfUs1KN4/6FaErg+PSQSaPPkJ8IBvnGAWGz9x5EgrOJX66F
 v3dM2+W6t22qNOhdMIGXaaee6KnTqNwHfL/ptB6P/hSZ8iedlDIfgj9ZKNONRE0kPBRO
 SxLg==
X-Gm-Message-State: AOJu0Yxecr0KsFdEVGHQV8Z4/PCW6doyde3l0y+P7OMg8L77I0/zuNZS
 BbdLN5V55f3xpzIW+GUD4xTP6NUPCtyTDkPhJhMeBrN0cNZ7tzR1YbrHLSYlmgeq4qbBj7n2yEm
 vSRNS
X-Gm-Gg: AeBDietzk1zETEIIRGmXyzBWUwxKqQBccCy+RxdZs9hYzIZwjtT8XGjXpE8ol1LjdXE
 Cv3A3ulmnC+9ElJ/DYRCG/h7vPkHIWGd+EoDpZiV0uSQ+uSr4FF/2YkFZ+ghGy9448E/imSA43E
 O/a2b/6yusuSBUR62OQS8pIkHdmKWLRz0YOrqaUHpCIvQnJpzqavxHcQIHBSo1dXunnGwYHrGJ4
 yr29G8EqDEEa37Vrmks2yKlOsR5jawyDWqaHBkgBkn85NViPbjBMCDMfkX7MpH5mrY6zxGwnVFz
 YZskYn5ME/FSQ3Dqpr0PbTdck/D1rm67+jRgDAYmZtVd1tu5ueZWVdxNRgVCTC4ZmN2LQktmxOT
 7PXBdjskugBFjjend1e7xxYay31s5yEXxns6wKE3gE4PR6Gl2ZzCjP+e24bomjC9DptZMXy3q2N
 5n5ODwVM/xGfLKM3NuOXFw6sHH25TyNWAFLRt6xSfmATmKiJy1qeHGUx0NRn1EdGwP9jN3zWKwr
 ZoyuHKm+rZupfdVHVb6lyXldGpIjV4OUqw+U30K8Cgb/ozNZ89LnXSmrZfAqFQmhvxM3HFpxtKi
 8vdN+5JT0YEo8605Y9KDr5hh
X-Received: by 2002:adf:ec4c:0:b0:43d:30d1:857c with SMTP id
 ffacd0b85a97d-43d30d1859bmr4013249f8f.7.1775316424542; 
 Sat, 04 Apr 2026 08:27:04 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-87-9-100-184.retail.telecomitalia.it. [87.9.100.184])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4f1a99sm28059462f8f.32.2026.04.04.08.27.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2026 08:27:04 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 7/7] board: st: stm32mp25: support dynamic A/B bank bootup
Date: Sat,  4 Apr 2026 17:23:34 +0200
Message-ID: <20260404152640.3297713-8-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260404152640.3297713-1-dario.binacchi@amarulasolutions.com>
References: <20260404152640.3297713-1-dario.binacchi@amarulasolutions.com>
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

Enable automatic detection of the active A/B bank by retrieving
partition GUIDs from FWU metadata.

This ensures the system correctly identifies the bootable partitions
even in multi-bank scenarios, falling back to a standard bootable flag
scan if the UUIDs are missing.

To enable A/B bank bootup on stm32mp25 boards, add the following Kconfig
options to the stm32mp25_defconfig:

 CONFIG_FWU_MULTI_BANK_UPDATE=y
 CONFIG_FWU_MDATA=y
 CONFIG_FWU_NUM_BANKS=2
 CONFIG_FWU_NUM_IMAGES_PER_BANK=3
 CONFIG_CMD_FWU_METADATA=y
 CONFIG_FWU_MDATA_V2=y

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Pass efi_guid_t by pointer in fwu_mdata_get_image_guid() calls.

 board/st/stm32mp2/stm32mp2.c          | 25 +++++++++++++++++++++++++
 include/configs/stm32mp25_st_common.h | 15 +++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/board/st/stm32mp2/stm32mp2.c b/board/st/stm32mp2/stm32mp2.c
index 43bc583378e6..cb9a33252212 100644
--- a/board/st/stm32mp2/stm32mp2.c
+++ b/board/st/stm32mp2/stm32mp2.c
@@ -208,4 +208,29 @@ void fwu_plat_get_bootidx(uint *boot_idx)
 	*boot_idx = (readl(TAMP_FWU_BOOT_INFO_REG) >>
 		    TAMP_FWU_BOOT_IDX_OFFSET) & TAMP_FWU_BOOT_IDX_MASK;
 }
+
+int fwu_platform_hook(struct udevice *dev, struct fwu_data *data)
+{
+	uint boot_idx;
+	efi_guid_t boot_uuid, root_uuid;
+	const efi_guid_t boot_type_guid = PARTITION_XBOOTLDR;
+	const efi_guid_t root_type_guid =
+		PARTITION_LINUX_FILE_SYSTEM_DATA_GUID;
+	char uuidbuf[UUID_STR_LEN + 1];
+
+	fwu_plat_get_bootidx(&boot_idx);
+
+	if (!fwu_mdata_get_image_guid(&boot_uuid, &boot_type_guid,
+				      boot_idx) &&
+	    !fwu_mdata_get_image_guid(&root_uuid, &root_type_guid,
+				      boot_idx)) {
+		uuid_bin_to_str(boot_uuid.b, uuidbuf, UUID_STR_FORMAT_GUID);
+		env_set("boot_partuuid", uuidbuf);
+
+		uuid_bin_to_str(root_uuid.b, uuidbuf, UUID_STR_FORMAT_GUID);
+		env_set("root_partuuid", uuidbuf);
+	}
+
+	return 0;
+}
 #endif /* CONFIG_FWU_MULTI_BANK_UPDATE */
diff --git a/include/configs/stm32mp25_st_common.h b/include/configs/stm32mp25_st_common.h
index cb679eb1be22..0b0267ae99b0 100644
--- a/include/configs/stm32mp25_st_common.h
+++ b/include/configs/stm32mp25_st_common.h
@@ -8,7 +8,22 @@
 #ifndef __CONFIG_STM32MP25_ST_COMMON_H__
 #define __CONFIG_STM32MP25_ST_COMMON_H__
 
+#ifdef CONFIG_FWU_MULTI_BANK_UPDATE
+#define SCAN_DEV_FOR_BOOT_PARTS \
+	"setenv devplist; " \
+	"env exists boot_partuuid && " \
+		"part number ${devtype} ${devnum} ${boot_partuuid} devplist; " \
+	"env exists devplist || " \
+		"part list ${devtype} ${devnum} -bootable devplist; "
+
+#define ST_STM32MP25_FWU_ENV \
+	"altbootcmd=${bootcmd}\0"
+#else
+#define ST_STM32MP25_FWU_ENV
+#endif
+
 #define STM32MP_BOARD_EXTRA_ENV \
+	ST_STM32MP25_FWU_ENV \
 	"usb_pgood_delay=2000\0" \
 	"console=ttySTM0\0"
 
-- 
2.43.0

