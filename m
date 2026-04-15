Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA1CF4213F
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 18:34:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76F8F84227;
	Wed, 15 Apr 2026 20:33:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="mNghHytY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E0A48423E; Wed, 15 Apr 2026 20:33:18 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A00C984223
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 20:33:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so94133865e9.0
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 11:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1776277995; x=1776882795;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gEPs0fGJ6OgadP+ub4aVqo1ljemvKjXa6np+zn4X2AI=;
 b=mNghHytYzTCTj9o55D35JctAIBpuTSArNUkSSSQPPrhZJ8HM44DEX7zwsH61XjeDkx
 EpaezjbhmRheF7aUZDUnGcoPjKM6+J8rquYXP9Cr9wpaUWVMNX9Xvl3kI7v7DWgC/6xs
 yD2t4eNSxw3NmY8cyChAshSUkgzMUEMjX9QXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776277995; x=1776882795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gEPs0fGJ6OgadP+ub4aVqo1ljemvKjXa6np+zn4X2AI=;
 b=AiANcRn5HQsSa4fVZxs91hcOpCh2SFStOhypmf7WfhywtSRej9J1sOvEbUy5nJT4TD
 L0o/FsxYYxd43QS3uJpCf6qc4221CWhKWMvHV49FYErjR+FZmCHRWQgLgX1STfeeRO0d
 FwJuSt7LMnl/GkCniLw5NP1wxaYOuaqOkP9SIT/yhF05IsFGEux6L5vxLG9zo7SCIC5Z
 HvxEtyrP40ceRNAXwGz9Gnk5twqSByvozEmRg5oY3Ne8peg2/o1wil+Ppvyk0Q4pBUCP
 lnkQ4ZvhtuOVX51wbpDU7VOrMU60YRp4mSws9y+PcrkvzRGFnaTZrAT+h6Vhyp0ZODkR
 +Z4w==
X-Gm-Message-State: AOJu0YyQJ+NbRtok0zfX1PovCdwVVMxh4FD63BRl6rGkEt+e5cvsE/y2
 5ciROF7/Sxk67gd6ucvgO3BPqiT1uz9ris+f2YBPO9J+B9xUtlOLzNChwqrPjqED27C7OptHj+h
 Al5pt
X-Gm-Gg: AeBDiesxIGQzadHZLDNjtMjMaaIOWs1Ft/MNv3PPEQ53Hb1Vgk7A66z7bokKFtpkp6b
 /uXujTJFgg2xi1R4UjmhOpioCFFFutwoYbgsGZgUm5lWCtQRTGKuTabTbj++OkJvfLcHDnh2OkS
 zKNagu1B8+lmd8ZybuVbA1CjAzK4tLYwUf86YzUf/qfrQN68xqUoDWiJtDuOr2V0Q9dMTtJgRDa
 6sbHfMn8dlwYIxrEa/eV2dtmklIuVUVQYo4in0ojf3HQ67tROWN+l4uymzfvP6bRZTCGaJiNlDb
 /lL2tdqfqpcyc8Ck9+y9cI591rpHv24psSZ7cUaWtnlCX5Ld+/KMbocui+ANd6aV4iSr1SW/Mxz
 UJEI4ojzuINfML2Go6PySo8chQrBT5HHlgFuASaIu1U9BdruboaBBnfe75iaef1mVTR0IYpag1F
 rHOOyOKkntwgMbIX2ljIi1kFORfSzT4sW2k6rvMAnBN9xqW2JIQl9znHcGWcbSGt90ybhWKecfi
 Hlqu3Q9PVEAbokS4lL74PHWWiALLId4/oIbILdyJP1tdsSkz+xZuGjVsw==
X-Received: by 2002:a05:600c:c0da:b0:488:b187:d898 with SMTP id
 5b1f17b1804b1-488d685b6e8mr276633475e9.14.1776277994818; 
 Wed, 15 Apr 2026 11:33:14 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com ([2.196.40.93])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f0e72980sm34953115e9.5.2026.04.15.11.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 11:33:14 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v3 7/7] board: st: stm32mp25: support dynamic A/B bank bootup
Date: Wed, 15 Apr 2026 20:31:34 +0200
Message-ID: <20260415183250.3031030-8-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415183250.3031030-1-dario.binacchi@amarulasolutions.com>
References: <20260415183250.3031030-1-dario.binacchi@amarulasolutions.com>
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

---

Changes in v3:
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

