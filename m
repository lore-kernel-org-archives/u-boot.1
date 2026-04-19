Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A05EA719C
	for <u-boot@archiver.kernel.org>; Sun, 19 Apr 2026 14:34:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7D61842F2;
	Sun, 19 Apr 2026 16:33:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="aS+wt0V0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85E78842E1; Sun, 19 Apr 2026 16:33:11 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 885C58419E
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 16:33:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so34554645e9.2
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 07:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1776609189; x=1777213989;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z0aGuMwDclvcyPdUtza4RjG7PG1o+7vRHLMxYH5Ix6Q=;
 b=aS+wt0V068k1V6/OnXFsobmtXplGHrn305kR8njnGH7cHm+e5c+W+ZzjlPBlFMJNAN
 +WLz+U5+F+MRJuj/VBkC2HZZgH1H9Rp2kxpym7hQ7FWfZ/5iIKSE+Ui+GlviXwVnKQJV
 2fLKYcBZ6OnYkMLZcHu/wlQZDCmpNFi4t9EfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776609189; x=1777213989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z0aGuMwDclvcyPdUtza4RjG7PG1o+7vRHLMxYH5Ix6Q=;
 b=XJ5flBf4F9FEcb0tf/5xVYFGiQ7jCdIOIIo+6Ty5TevBIB/CCe1ap/BmyYrtame+Cf
 RFFrkl6q//DWNIbF7qoYScR/KOle00DgNUm2BnvDZC0T8BmB8o/wHhnQYL8Le+k8k0wl
 yQ7GHUkDlmvcciGQ7Le6S3wuI0lVFMcZKic+ldK9E8GVM4iZDvMXDmymiJ5st4ylOV1N
 X9X/Peourrhn0k1F9QLaqJJt9Ft+gjsWEDaBxlZ3zDasZ6Bz+tDsEwcqERi7vy7M9pvq
 zTx5LB0xyEXFBJPxDJzlOscPTnPVJO44VdmcL4gMDrIrgtJd4yI4+NRvq5ncIC6LOa9D
 AODw==
X-Gm-Message-State: AOJu0YwvKx9Y7C8sTKrgfENQbKjN0Y1PJB73cRpOnQscbMhts4F9zBSy
 5FTChlvgCUypkBL5MbkoVx5sIrZNSxDA3CRoi5QWgPvpB7/KK1xMYlng6kqr81gCjzOtieg88n8
 V5Dtr
X-Gm-Gg: AeBDiesXcUQkDTEzRF7IHwRsIfQzC0neD7Qway15bXKACquMBiEFteZu5R3DRz6/Qgy
 YeqyetcTO8oAQKtJuEdScrPyaTES048MLp4Abz96yRkpyXMyf3JNwX5GexP0s0MC+E5EE5ddN+7
 Jb2THo+9lpEs86KRf8va8FwcjRut1c0Dia7vcoJqCq0PK0xpUcvozKXzFvQ+Gt3VCpZXKmOC6i7
 R/DNzbAtiWbiiRlUnPXtdf3f+XxNctjdU/KGcUkIumvIMLH8EvJl9ax/hNNX+2GWgmzxUhe3R54
 p0sgWixiU6+H1Nn00ccm+HcrPDOVPJigTsgnZaoGb7YPC4Ym5SE3I/rqtywu34l4nji+Emiey7j
 8G0zT8gq1rfIeT4DjC3aQz413yDhPaLWo3lDWZs6nJhx+mafgz3hxeOyp8KrAsSbPsJXBxctmEI
 rnv1Jjra3qP0W3fN1wpTLJ6FiZKFdB/GxQ6mMnxSnP7OfV70NXUBDU2g6VNIDI4O43qGZEvGfK+
 a7j2SJ/vLV9yYR7KjvJJW1y1i1hJkgopBR1SuL02NQ/Qpm+FGgbG6Tj8EA6AJjpA4HHeefDi2s0
 teMwVka2z3joCxGHgCtsSEcLWvSiKTty
X-Received: by 2002:a05:600d:1b:b0:483:8062:b43 with SMTP id
 5b1f17b1804b1-488fb771438mr123463775e9.19.1776609188736; 
 Sun, 19 Apr 2026 07:33:08 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-20-97-39.retail.telecomitalia.it. [79.20.97.39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb755938sm86864245e9.3.2026.04.19.07.33.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 07:33:08 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v4 8/8] board: st: stm32mp25: support dynamic A/B bank bootup
Date: Sun, 19 Apr 2026 16:31:48 +0200
Message-ID: <20260419143247.437733-9-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260419143247.437733-1-dario.binacchi@amarulasolutions.com>
References: <20260419143247.437733-1-dario.binacchi@amarulasolutions.com>
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

