Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 105ACFF8875
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 08:07:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90A048467B;
	Thu, 30 Apr 2026 10:06:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="YEBE4axH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6599E8466F; Thu, 30 Apr 2026 10:06:53 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5ADFD84198
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 10:06:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43d64313c39so459413f8f.3
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 01:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1777536410; x=1778141210;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5S2gUI+yh0xPdb/QwVrb1gySfcxDflQCsZShYuF0V2Q=;
 b=YEBE4axHrCF99O3NElekHKJWez6FZx13JtmtzonQ4fDtrnN+3xTiD00DJhf1XWMSaB
 zoLp+1sYFKqIyrgcSihkYa+l3P5WS6Nbmyg1A7aYekXzGliDcYeyAACtKPFBLIZRZxtA
 /TYZn8qGBS4/WyARf+uHG1RYudW2clbhpoVfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777536410; x=1778141210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5S2gUI+yh0xPdb/QwVrb1gySfcxDflQCsZShYuF0V2Q=;
 b=o9j3GHLnz/rlE0+iEsQF6AzxnW3rERR0fwCdgmChSmUFa00r0C9XCDLxJbiBIDgUdX
 CxpuBC765e/VI84wV6kRCDVcA1GaosiGyOsfcCTtGCzxxmYJd77LTXaCIpZ82aYz3ARS
 ks2qUnIAf5Sb2VBeeRzMcuMKWl49AWd2V3UHneOudbt4TNr/ptqab7n6leLD7CDEiqH0
 BxDVOJw+IY5oFZ4FYzQJpY9L5Plhbtrp51sKL4KN7IIy8MlCdLvKDzO5itjY/rDFPxSk
 FczRN7N4IK/FOYQZo2bnrLuowvGn0uoMwt1b/2YhuQvQkWaT9sMYzTjZ0IvkPeIPqnd9
 lpUw==
X-Gm-Message-State: AOJu0YwAZkPjEsiPr3/Y9QFVKlYWk825qD0n+TKn9iarjW4J3voVv9uO
 7kN4t5UUyvnwZF746gmoyn0YyBXGlTLOQt9n+bdkN3ZQ2+aId9A7M6xtF65iqjhLAyU2CV1gj7k
 YTS7E
X-Gm-Gg: AeBDiev5U893teuDTo0Iqkah+jzjmh9/263Pjtx6NMf/2SiE8LGU93ZEp7nfvV+9cAs
 W/bR/+yiZniLoQuwTfwyVNdgssDjnlP0PHfSnKBIfbUikhn79+fv5PQo0vqaZTfjDp2BJQhLyLo
 5qs073kp7aaQ33VByOgk0cowVlkA3t0Nv3tegqcWtiSLql8mwYDpisSlFlJ6GmnsGGA0KGyITtZ
 yb48IeuGRsAE2W3XEKc6tneBcH28Wj79PsnDptJw4FALrMJsjYkSSNcUAn8itamR7UaGPLzoMl+
 bJCHx1osNLqWXS8FE/DlMEa/ugbNXKxjBhx4t6WXlmXZ9Pk0eRv3tW37kqCe9hdkqgcnDNQy1dI
 GQjh1RElquhz9yZQaA0Q1G6qUqnI3Msk8BZ4ZPDGNbrVE64Twe1bwmShiPd2Gb8exZg5prDa+bq
 DhfuHe4vf3isJ+PjYbEl6KAec6QH5RkkloSFoKl2LDpfSpfq8x0eQ0Zjln8PJBhE2IaE5MwIOEx
 y2WI9huaUGmMYIiuWqtUtX/D/znrxsC/S0YkRGkv3yxY8kXrWqbHXVoNH9g79ilEvDJ5r9S8Ieq
 pzAu01ScDVmgjmRODgEkbrYbc/A8yYQ4gLmCYMBvGXm7vg==
X-Received: by 2002:a05:6000:26c4:b0:441:1fa5:457f with SMTP id
 ffacd0b85a97d-4493e982952mr2858427f8f.28.1777536410433; 
 Thu, 30 Apr 2026 01:06:50 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-82-56-22-134.retail.telecomitalia.it. [82.56.22.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-449c576d0a2sm668071f8f.31.2026.04.30.01.06.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 01:06:49 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v8 8/8] board: st: stm32mp25: support dynamic A/B bank bootup
Date: Thu, 30 Apr 2026 10:06:09 +0200
Message-ID: <20260430080627.849636-9-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430080627.849636-1-dario.binacchi@amarulasolutions.com>
References: <20260430080627.849636-1-dario.binacchi@amarulasolutions.com>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

---

Changes in v8:
- Add Reviewed-by of Patrice Chotard
- Skip cmd_test_part tests for configurations where MMC is not enabled
  or the device is missing

Changes in v5:
- Add Acked-by of Ilias Apalodimas to patch 6/8 "fwu: add helper to get
  image GUID by type and bank index"

Changes in v4:
- Add patch 7/8 test: dm: fwu_mdata: add test for fwu_mdata_get_image_guid

Changes in v3:
- Wrap lines exceeding 80 columns in test/cmd/part.c file.
- Combine run_command() and ut_asserteq() -> ut_asserteq(1, run_command(
- Add kerneldoc comment for fwu_mdata_get_image_guid() above its declaration
  in fwu.h.
- Add log_warning() messages to fwu_platform_hook() to catch inconsistent
  FWU metadata (boot GUID found but root GUID missing or viceversa), as
  suggested by Simon Glass.
- Add Reviewed-by tag of Simon Glass.

Changes in v2:
- Add links to the XBOOTLDR specification in the commit message of patch
   1/7 lib: uuid: add partition type GUID for extended bootloader.
- Update help for 'part start', 'part size' to mention UUID.
- Add kerneldoc comment for fwu_mdata_get_image_guid().
- Pass efi_guid_t by pointer in fwu_mdata_get_image_guid().
- Add patches:
   5/7 test: cmd: part: add UUID lookup tests
   3/7 test: cmd: add unit tests for part command
   2/7 test: dm: part: add test for part_get_info_by_uuid
- Pass efi_guid_t by pointer in fwu_mdata_get_image_guid() calls.

 board/st/stm32mp2/stm32mp2.c          | 32 +++++++++++++++++++++++++++
 include/configs/stm32mp25_st_common.h | 15 +++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/board/st/stm32mp2/stm32mp2.c b/board/st/stm32mp2/stm32mp2.c
index 43bc583378e6..5cbbbc322a3a 100644
--- a/board/st/stm32mp2/stm32mp2.c
+++ b/board/st/stm32mp2/stm32mp2.c
@@ -208,4 +208,36 @@ void fwu_plat_get_bootidx(uint *boot_idx)
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
+	int retb, retr;
+
+	fwu_plat_get_bootidx(&boot_idx);
+
+	retb = fwu_mdata_get_image_guid(&boot_uuid, &boot_type_guid, boot_idx);
+	retr = fwu_mdata_get_image_guid(&root_uuid, &root_type_guid, boot_idx);
+
+	if (!retb && !retr) {
+		uuid_bin_to_str(boot_uuid.b, uuidbuf, UUID_STR_FORMAT_GUID);
+		env_set("boot_partuuid", uuidbuf);
+
+		uuid_bin_to_str(root_uuid.b, uuidbuf, UUID_STR_FORMAT_GUID);
+		env_set("root_partuuid", uuidbuf);
+	} else if (!retb && retr) {
+		log_warning("%s: found boot GUID but missing root GUID (%d)\n",
+			    __func__, retr);
+	} else if (!retr && retb) {
+		log_warning("%s: found root GUID but missing boot GUID (%d)\n",
+			    __func__, retb);
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

