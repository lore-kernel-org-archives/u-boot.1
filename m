Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F7AC36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 07:58:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8927835B2;
	Wed,  9 Apr 2025 09:58:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IhSAMFMg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A341E835AE; Wed,  9 Apr 2025 09:58:33 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD75C835A2
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 09:58:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3965c995151so3261544f8f.1
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 00:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744185510; x=1744790310; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=w5Wy9z7FIynAAeuVOIX71aJGlF0g1o3yS5LgZGdGOVc=;
 b=IhSAMFMgZXDb4/AfbYTRURimXvqlldhmADErARi3usvGzpGu2qFReBd3xuo0vYdm6C
 hWcANSz48cSVXGgWlEvciwemsyPNML+xeuN613CBd3nMZxy3mCwn+rp84kBGGNdoYnCl
 hIYbPKyXXYMP/FiIpdRSGDlIyANmnzBq8pTZXO4/q/ssAzHeFvH0Qaf26mY5SRDaQVON
 vAhSAUUhA5qtp1aXTwdmb8tsXekxRPpgpM/6Fkw8GwJtzVecpn7P20+TLe7zTqpJfUGD
 1A6QufuIOOQMeI8tKaJV5c5xjEGChc9nzZRz9SvIKIc3DhIp3CF9AyhH6+j2XVjNbwFx
 s7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744185510; x=1744790310;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w5Wy9z7FIynAAeuVOIX71aJGlF0g1o3yS5LgZGdGOVc=;
 b=OcbdJ7IPaYr5xN3wnofQNlfg35dCNKr9degXCLap/9gXmDvLn5rdSchB6mNq/AXYir
 GShIWfNymJJsziyz2kZFB2beacFflt77jaJQEFgYOaibmA4h3r6B4x544SHYboBSzCm1
 tFchfXMSo2jZVG4H/0lV6ZcqmwsD0BhVVPjsbays2bJm/3HuR8XXd2X5kqlT9wIp2cZq
 jbABMvFSOCueT6p55rcoJf6WOMDI5TF92z783oKlrYvVnCsStL49QhPjgprfXGcxFoQS
 ZWhys4SQOEk6/dPSdLVTFNPYR4OwuASv+cROw2X94REkeVFh95mrRWXzNsW+uTR8crvr
 yJ+A==
X-Gm-Message-State: AOJu0Yxav3cJA7sFIbz1AdQaiVpDcnjQ7/z51UCFBZLR5fNRHR1bYQ3c
 Qnl6fo1xBZE2ahn2S2MxDv5DCdesaYcSSB1pnyg8SRxIgC3V3X+knCz2ZH4d5Bk=
X-Gm-Gg: ASbGnctNTIgKj7FtCa7k8/TbuAJorBzR/VSIxdV0/k91QaESwtmYV+EEkjpoUxXkwzU
 u3pK7qDP5RXoKW2F6jFAR2sjIRqRQ+v+Y7vGA4B195cU6e5EOeeq/IEufT464+Kd2VGiZ4PR2qj
 LX3IXAsoXZ66sqYmXM3PVujl4HiBlgruLSPGxo91Pbd4xstJyvlZl6SxoZ0tE1yPbfTxJ9sRriT
 tfHz/rJyxgknwGDkzQzS0H/tewQ73ZD/TE3cbFxWBs87TANaOQw6hy8NAduDhQzJQWsCG11u7FA
 Pvx28ZNQONVH/JyxaG3nM436QANqtMuFCLxM2OsRrFKFaa4EFl5qna7VbP+Mlw==
X-Google-Smtp-Source: AGHT+IF6Lj5pVJx3sNeQgFcyNMnS7GSdGETTptLD4vx5hKaiCXIEwsWgcjL1Mf+jWjSF5GYAL6LN/g==
X-Received: by 2002:a5d:6d82:0:b0:390:f9a5:bd79 with SMTP id
 ffacd0b85a97d-39d87ab5d5bmr1673952f8f.26.1744185510119; 
 Wed, 09 Apr 2025 00:58:30 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39d893f0b82sm842878f8f.66.2025.04.09.00.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 00:58:29 -0700 (PDT)
From: neil.armstrong@linaro.org
Date: Wed, 09 Apr 2025 09:58:27 +0200
Subject: [PATCH RFT v2 3/3] fastboot: integrate block flashing back-end
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-topic-fastboot-blk-v2-3-c676f21d414f@linaro.org>
References: <20250409-topic-fastboot-blk-v2-0-c676f21d414f@linaro.org>
In-Reply-To: <20250409-topic-fastboot-blk-v2-0-c676f21d414f@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitrii Merkurev <dimorinny@google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4032;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=/s7SmPXwChWG0I2o9AJo+du5EcQn++uDCrN668W9J6Q=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBn9iijf8V22lGjWy1ySTljtA/InMHgKLLHdxftDFnp
 iculLO6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ/YoowAKCRB33NvayMhJ0fi3EA
 CggBosHoGVdFq+mrm9r/WkTWFlnbFkoQy2GwqtBojf4Nvu4NaqK+0nmaCZGGjC4at/6kQ9EQLxSxhj
 rv2cDXK9j7VWBZG9wvTmWkaLFZZ62jEQ2q3jVNdS5hPAQcs36X+7sXjVaK6Hv2O8j+09n8zJ0K7tqE
 inWqIHtq84V1TuMWbNsRszZpyJySFFjGo4EPjA8YStBczYJ6Yxpy0ypKxQzzSBSJYdVcq6yFYTsDI3
 csM0jJ5jafKxuq40VRQn3LzY1fRTGMw/bmZshiyk25bBpFfySfd/Tdtf3nKlFj/Vz/Si82lA5PZ28F
 MBpLtUBxrG0JPuUk9tAJ5A2p6VsEMdHFxZnrIOrEgI94sw3eWX7LpirmhLKnJWrqXzWie8UQEBUfqN
 GbKx4OrAJH/SUbvChFA8vZywXi8u3xddiyy+qryR/d86FYw6SAaL1I4WS8zJ1kK1zjgueATey5CJ+r
 oqnNSgfE5XBfsUBBsRT6RosMUAlkR1T8ugN+UgCrHZUpVS9puMgjrOICkGry2EQHlzi2jwC1IMpYnC
 +yQgqWdv2o35+h/MbEHd9uXJ0NeVHfpZ/zpfAa7llnG2d+5UqkPjQ7c9x8vhbtDq949N1Hv4pT2b/f
 u2r39/34EF8E6IY1wdKYyjQLqucJCH/wU2kfCOovt8NAcmtOYwMevgYhg8vg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

From: Dmitrii Merkurev <dimorinny@google.com>

1. Get partition info/size
2. Erase partition
3. Flash partition
4. BCB

Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/fastboot/fb_command.c |  8 ++++++++
 drivers/fastboot/fb_common.c  | 16 ++++++++++++----
 drivers/fastboot/fb_getvar.c  |  8 +++++++-
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
index e4484d65aca5994cbaeb1a9276e09fbe732fb46f..f1ab824ad619d04b4430b0391d13d256581ccea1 100644
--- a/drivers/fastboot/fb_command.c
+++ b/drivers/fastboot/fb_command.c
@@ -8,6 +8,7 @@
 #include <env.h>
 #include <fastboot.h>
 #include <fastboot-internal.h>
+#include <fb_block.h>
 #include <fb_mmc.h>
 #include <fb_nand.h>
 #include <part.h>
@@ -336,6 +337,10 @@ void fastboot_data_complete(char *response)
  */
 static void __maybe_unused flash(char *cmd_parameter, char *response)
 {
+	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK))
+		fastboot_block_flash_write(cmd_parameter, fastboot_buf_addr,
+					   image_size, response);
+
 	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC))
 		fastboot_mmc_flash_write(cmd_parameter, fastboot_buf_addr,
 					 image_size, response);
@@ -356,6 +361,9 @@ static void __maybe_unused flash(char *cmd_parameter, char *response)
  */
 static void __maybe_unused erase(char *cmd_parameter, char *response)
 {
+	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK))
+		fastboot_block_erase(cmd_parameter, response);
+
 	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC))
 		fastboot_mmc_erase(cmd_parameter, response);
 
diff --git a/drivers/fastboot/fb_common.c b/drivers/fastboot/fb_common.c
index 12ffb463deb98229b3486cfd54b4785fcc041224..58d99f1472e2ffbf9460f0e9a8d4cb14b3f1bacb 100644
--- a/drivers/fastboot/fb_common.c
+++ b/drivers/fastboot/fb_common.c
@@ -97,16 +97,24 @@ int __weak fastboot_set_reboot_flag(enum fastboot_reboot_reason reason)
 		[FASTBOOT_REBOOT_REASON_FASTBOOTD] = "boot-fastboot",
 		[FASTBOOT_REBOOT_REASON_RECOVERY] = "boot-recovery"
 	};
-	const int mmc_dev = config_opt_enabled(CONFIG_FASTBOOT_FLASH_MMC,
-					       CONFIG_FASTBOOT_FLASH_MMC_DEV, -1);
 
-	if (!IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC))
+	int device = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
+					CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID, -1);
+	if (device == -1) {
+		device = config_opt_enabled(CONFIG_FASTBOOT_FLASH_MMC,
+					    CONFIG_FASTBOOT_FLASH_MMC_DEV, -1);
+	}
+	const char *bcb_iface = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
+						   CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
+						   "mmc");
+
+	if (device == -1)
 		return -EINVAL;
 
 	if (reason >= FASTBOOT_REBOOT_REASONS_COUNT)
 		return -EINVAL;
 
-	ret = bcb_find_partition_and_load("mmc", mmc_dev, "misc");
+	ret = bcb_find_partition_and_load(bcb_iface, device, "misc");
 	if (ret)
 		goto out;
 
diff --git a/drivers/fastboot/fb_getvar.c b/drivers/fastboot/fb_getvar.c
index 9c2ce65a4e5bce0da6b18aa1b2818f7db556c528..f083b21c797dc7e55315f2cba017a4372483fa92 100644
--- a/drivers/fastboot/fb_getvar.c
+++ b/drivers/fastboot/fb_getvar.c
@@ -7,6 +7,7 @@
 #include <fastboot.h>
 #include <fastboot-internal.h>
 #include <fb_mmc.h>
+#include <fb_block.h>
 #include <fb_nand.h>
 #include <fs.h>
 #include <part.h>
@@ -114,7 +115,12 @@ static int getvar_get_part_info(const char *part_name, char *response,
 	struct disk_partition disk_part;
 	struct part_info *part_info;
 
-	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC)) {
+	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK)) {
+		r = fastboot_block_get_part_info(part_name, &dev_desc, &disk_part,
+						 response);
+		if (r >= 0 && size)
+			*size = disk_part.size * disk_part.blksz;
+	} else if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC)) {
 		r = fastboot_mmc_get_part_info(part_name, &dev_desc, &disk_part,
 					       response);
 		if (r >= 0 && size)

-- 
2.34.1

