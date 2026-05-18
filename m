Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C04CD343F
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 06:54:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94A7D84150;
	Mon, 18 May 2026 08:54:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="LFAqWxVa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7CBA8467A; Mon, 18 May 2026 08:54:49 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B8F283EF9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 08:54:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso19370185e9.3
 for <u-boot@lists.denx.de>; Sun, 17 May 2026 23:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1779087287; x=1779692087;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zUQoicOitN7Tw5WrQojtXh9PhrTku5oBZRubCr+yO7Q=;
 b=LFAqWxVaFzRTdm0DsHJRcabt2/RwBt3w5qsk76r/WUQ3HD3e9DJshg7HmYryUACfCM
 wGbYtVBM5e0p4x8gnBlAV54bq2NCh8HLVz2ODunHpJONDZ7oYiZhm0ruIO7NfTKKe5ZY
 AcugINA5kZjJkwdKyziiNlgIicwUnAyCDtW0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779087287; x=1779692087;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zUQoicOitN7Tw5WrQojtXh9PhrTku5oBZRubCr+yO7Q=;
 b=jImthZkM3C6BpluA52Ig9qcwO9s2nHgWKU7Pm8ADaNR5Zb8+vRv0rPblFXF7NxBcan
 2nsqO67vssGVofzC9GYwy0EgDijgPAR50g+qESLer9tGs32EQn/w3xJxvRDOsyfUK2HE
 iGKQiO+Z2atNGOrKsYd1eYHvkmD/x1VJeoAEf8/ig+4FJArDVdwq9+0QZN0VBu/HYiGj
 rmZXksunW8mWd38DYihNfdgWCqD4bHoOtJnf0ZmfmPcUJvJGb1KeviLKD+QRO+5SrzZm
 tngLk0nonYEQss2FR4W6kG3xqMtBk8s4CmNLu80qyDTwJPaoNXmD8AZzOCWLGsBQZba6
 LVyA==
X-Gm-Message-State: AOJu0YzD58WQUW+ZeHdA83+FGl/LuLkHC74qVEmEsS9vw362DBC7HwSt
 CUwflBSaa2mF8+BBg6jbMn0ibSlgqgQZCgqOOVw4J7N04OM8LbUfRfN7FUccJ33eoOdp11Tpi7f
 WN3g/
X-Gm-Gg: Acq92OEEMQyocaTrJZsqGVPI48Qd/XQ7E4tKXObuW92qqrxXqsbqKEqEDCYTaYmrk3F
 hKimCwGV9XUkUTHm0mKRa0YtK9naqJAgqefDbVgJ4pHvyNoa+B9kCvABgkuOSpsQeZoZTApV2Rz
 tWRKMh9gwnNJMBaV5RHx9LJWaB9hDn2cJH+QWcrFz/jWP5Qa3et2YA3zk74lJ498U302/epmAcQ
 DRCh9prGLA2N3dL9SJBsbkmn8qCGkmZM6kF1VmQ/X15uVVvtEsWxeQ8Lkx20fUc5k99vkYtnDV2
 vVipKqGSHbSUkbuNW+kQw1BZ5azRcAocIZ0hIQUl5RQQZw75VWXYC9a+9CAnRyUIm8glAHRWBtf
 CnbQzcNvMkFiI4dw99EdsKm4f/yIqhoogClc2mdbVURO5vLNbDVNCDOs3774ANAMnmXj2pnQg/I
 wZlwzY5lzVnHfVyAlJhPrQIHjnxAkN4WjVji23ytLCWkhV8HuhecA0OeJjrhUoySaLmt44FRTON
 iszDgPixWDwnu4dZECaEviA2bfWOSyFp9wOJNXa68GtR2zf3qlFGm+Sh6w0+t4pseiFwFLqtp8a
 6KZyVQvDCh/W7/FV+ep9Naqc6bFnziQ7Q0M=
X-Received: by 2002:a05:600c:34cc:b0:48e:635a:18d7 with SMTP id
 5b1f17b1804b1-48fe59b047bmr230418275e9.0.1779087286967; 
 Sun, 17 May 2026 23:54:46 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-82-56-22-134.retail.telecomitalia.it. [82.56.22.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe248dsm34308524f8f.30.2026.05.17.23.54.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 23:54:46 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 1/2] board: st: stm32mp15: support dynamic A/B bank bootup
Date: Mon, 18 May 2026 08:54:27 +0200
Message-ID: <20260518065443.2531017-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
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

Following commit 4300f9f4c5d7 ("board: st: stm32mp25: support dynamic
A/B bank bootup"), this patch enables automatic detection of the active
A/B bank on STM32MP15 platforms by retrieving partition GUIDs from FWU
metadata.

This ensures the system correctly identifies the bootable partitions
even in multi-bank scenarios, falling back to a standard bootable flag
scan if the UUIDs are missing.

To enable A/B bank bootup on STM32MP15 boards, add the following Kconfig
options to the  stm32mp15[_basic]_defconfig:

 CONFIG_FWU_MULTI_BANK_UPDATE=y
 CONFIG_FWU_MDATA=y
 CONFIG_FWU_NUM_BANKS=2
 CONFIG_FWU_NUM_IMAGES_PER_BANK=3
 CONFIG_CMD_FWU_METADATA=y
 CONFIG_FWU_MDATA_V2=y

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 board/st/stm32mp1/stm32mp1.c          | 33 +++++++++++++++++++++++++++
 include/configs/stm32mp15_st_common.h | 15 ++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/board/st/stm32mp1/stm32mp1.c b/board/st/stm32mp1/stm32mp1.c
index 88ede4e39106..8164a62e9a3a 100644
--- a/board/st/stm32mp1/stm32mp1.c
+++ b/board/st/stm32mp1/stm32mp1.c
@@ -857,4 +857,37 @@ void fwu_plat_get_bootidx(uint *boot_idx)
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
+
diff --git a/include/configs/stm32mp15_st_common.h b/include/configs/stm32mp15_st_common.h
index 60838cb0e3f0..7727e583fc77 100644
--- a/include/configs/stm32mp15_st_common.h
+++ b/include/configs/stm32mp15_st_common.h
@@ -8,7 +8,22 @@
 #ifndef __CONFIG_STM32MP15_ST_COMMON_H__
 #define __CONFIG_STM32MP15_ST_COMMON_H__
 
+#ifdef CONFIG_FWU_MULTI_BANK_UPDATE
+#define SCAN_DEV_FOR_BOOT_PARTS \
+	"setenv devplist; " \
+	"env exists boot_partuuid && " \
+		"part number ${devtype} ${devnum} ${boot_partuuid} devplist; " \
+	"env exists devplist || " \
+		"part list ${devtype} ${devnum} -bootable devplist; "
+
+#define ST_STM32MP15_FWU_ENV \
+	"altbootcmd=${bootcmd}\0"
+#else
+#define ST_STM32MP15_FWU_ENV
+#endif
+
 #define STM32MP_BOARD_EXTRA_ENV \
+	ST_STM32MP15_FWU_ENV \
 	"usb_pgood_delay=2000\0" \
 	"console=ttySTM0\0" \
 	"splashimage=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
-- 
2.43.0

base-commit: 215496fec59b3fa09256b4fb62f92af46e2ec7f9
branch: fwumdata-ab-stm32mp1
