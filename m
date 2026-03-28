Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44F110F3DEC
	for <u-boot@archiver.kernel.org>; Sat, 28 Mar 2026 17:17:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03CAF83E7A;
	Sat, 28 Mar 2026 18:17:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="dfwR8qt0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1817C80077; Sat, 28 Mar 2026 18:17:13 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F75E83E7A
 for <u-boot@lists.denx.de>; Sat, 28 Mar 2026 18:17:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-486fb14227cso40582975e9.3
 for <u-boot@lists.denx.de>; Sat, 28 Mar 2026 10:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1774718230; x=1775323030;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uhbnKG6I3uBd8YPHLeHNZI+uBaM8ZyYIr9wbspDdQNI=;
 b=dfwR8qt0xfrQ5EBVD910J6tULcKrLGZ+LnTM/nI0sGer2n5M2DJ4LnWJ+p+fypDopN
 kch2V7NZ3O3yXw4kZY3/n6koXZOyMo+8SvrCwN1SiF/iu+r7nmXvwOft7mdbSp6nXuCL
 ik3OtBqB4TLBimA8FkocpX9s81ZoXVJ/z6lWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774718230; x=1775323030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uhbnKG6I3uBd8YPHLeHNZI+uBaM8ZyYIr9wbspDdQNI=;
 b=pFzpCM4lJY9Trsq1JphdhVV8C9JdZlHJBgxgYm2dyrjfeiToQHjCRKdBAQ3YufF5hb
 Pd28iwmRYmy9+rGXq1swxlLTiI7+ft6bUNuGd2XRdvvu+TE94pOUfQHf7o7smauznhO6
 0vABByOP1akk/nx/W3X9Aip6PfecIJdldL7p5ouYJ/bJbAp15i/vAG0w94aoDfLJ9uKD
 nHKOcHSinSRFir76grH3LZj9u9i9n4F4pFR6Fd54f7XpZtXYexNzWeE5BSGp/LL3TrCQ
 R+hUk94BsGGIthBHykx2qxmLeEQjjmxVatCNZ5iuccWHmSMxwSdXhCE/DcnMLJC6rcJ2
 9XNg==
X-Gm-Message-State: AOJu0YyZBaTWVq1PJrIRHjpccmLDk3BEHflKMDX3s6guzzFsJlPAPhH3
 H5xjqL0vkLDTb8oTy7daPDFkGJ4QBX6S6NCY3o9oiofqO57EgxH0FR0O/jptj5nXhzt/iOPVpAQ
 UE3QN
X-Gm-Gg: ATEYQzwzn6tQvltZrJcNAwWMtl5kAwLK8nvS+5v2rAgOafv+82qXw6Fm0OFEvU1+I1D
 Qrp2Oos63SYm5yCHi1lABVCH5tsjabv+Nt29MZwyyvq+5bU9MhkhJPFQckKTE8yAHSMJGZzCVLy
 PjKBv9Q76iK1JuPvapVLRuENzx9T7v3/o44iVuAJPW+8zeE/t2CBI4aEJbvmkVIFwbzrX0kkvNM
 yH0dwwhf0hj2M05u1nj3jHFMOpjNpwTpk3YO4aKqGrvT/7hE19gq+UYDqtP0kdmvwt6FLIqIu1h
 cCT+gApiTsDdXN0in1cSX6EaxN91hfcS6ntMMIh75a//lQYAkzbZoNXpdrBe6BWMshznBHoJV8u
 UdLLU+kLtaPt9Clb1c8jFNjvooc8zDuYK9R5+4myBCEEEHdhdah1HDaCyQ2ZdXngTCeW5BIoDmH
 357s4or2DU+zA7mUx9WnUv9g7+XXCJojNts1rmMNfFPX3qmDi5DK+QEkKzQM/7h5guZtSn1JM8Q
 aSY4Wj3nuHFohVzR32m41vY5BA7Jc03ahgVKE62/9HbytWckrB5YYC0eIBR8RttdJF4nFOxn79r
 luU5ItEJ8+pDf4obOiEntzp6
X-Received: by 2002:a05:600c:800f:b0:487:1520:d107 with SMTP id
 5b1f17b1804b1-48727f4e9d3mr108463165e9.31.1774718230218; 
 Sat, 28 Mar 2026 10:17:10 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-87-9-100-184.retail.telecomitalia.it. [87.9.100.184])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722c6b105sm332432465e9.1.2026.03.28.10.17.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Mar 2026 10:17:09 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 4/4] board: st: stm32mp25: support dynamic A/B bank bootup
Date: Sat, 28 Mar 2026 18:15:17 +0100
Message-ID: <20260328171624.2377527-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260328171624.2377527-1-dario.binacchi@amarulasolutions.com>
References: <20260328171624.2377527-1-dario.binacchi@amarulasolutions.com>
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

 board/st/stm32mp2/stm32mp2.c          | 25 +++++++++++++++++++++++++
 include/configs/stm32mp25_st_common.h | 15 +++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/board/st/stm32mp2/stm32mp2.c b/board/st/stm32mp2/stm32mp2.c
index 43bc583378e6..42df750eae9b 100644
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
+	if (!fwu_mdata_get_image_guid(&boot_uuid, boot_type_guid,
+				      boot_idx) &&
+	    !fwu_mdata_get_image_guid(&root_uuid, root_type_guid,
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

