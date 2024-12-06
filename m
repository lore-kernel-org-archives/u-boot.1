Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C0F9E77179
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 23:06:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8E6088DFA;
	Sat,  7 Dec 2024 00:06:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="OBnK3yVB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E66B88D72; Sat,  7 Dec 2024 00:06:16 +0100 (CET)
Received: from mx3.securetransport.de (mx3.securetransport.de [116.203.31.6])
 by phobos.denx.de (Postfix) with ESMTP id DD4AC8974C
 for <u-boot@lists.denx.de>; Sat,  7 Dec 2024 00:06:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1733526346;
 bh=JVzB0Goe2csNr6aC41CkhmwFTVcPoebxIWkOdKB2nPM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=OBnK3yVBYJAFQvLmgmNq1GOf+a7nUuN+xIVXk4okJExQdY0yKba6+PxjhHQ2kgzmt
 DVEAOw40khA1kJmtagJ4SqljWDLTmL/uK3CPAKwQ/RodMX5mZBwgBHyuJhzjsmPZV+
 Pi3mz0MJaBwfXFDi6XH/vBHR28Sd81o9cFlnl9V6GN+C8FAYirbfzvhY5xmR/0el5W
 yJuygIGzx0DSNzLB/0+gChbnCUSyIupBFcjcBoIeZD7oL58zzUajeYpO4QztoS7u3n
 hU8NfrLnbmJW3/BTCRN03DO53p6SoJreb85twqrQT2STTb9YZGOyqBtkYjXYJBIDlh
 5gPOgi/rK3XKw==
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
To: <u-boot@lists.denx.de>
CC: Christoph Niedermaier <cniedermaier@dh-electronics.com>, Marek Vasut
 <marex@denx.de>, NXP i.MX U-Boot Team <uboot-imx@nxp.com>, Fabio Estevam
 <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>, Tom Rini
 <trini@konsulko.com>, <u-boot@dh-electronics.com>
Subject: [PATCH V6 4/4] board: dhelectronics: Sync env variable
 dh_som_serial_number with SN
Date: Sat, 7 Dec 2024 00:04:20 +0100
Message-ID: <20241206230420.54704-5-cniedermaier@dh-electronics.com>
X-klartext: yes
In-Reply-To: <20241206230420.54704-1-cniedermaier@dh-electronics.com>
References: <20241206230420.54704-1-cniedermaier@dh-electronics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

The env variable "SN" is used to store the serial number on DH electronics
SoMs. New SoMs will use the variable "dh_som_serial_number". To ensure
compatibility, these env variables are synchronized. This is achieved
using callback functions.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Reviewed-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
---
V3: - Add this patch to the series
V4: - Remove the recursion prevention from the callback functions
      => The recursion prevention will be generally solved in the
         callback function call in a separate patch
v5: - No functional changes, but changed the order of the patches
V6: - Add Reviewed-by tag
---
 board/dhelectronics/common/dh_common.c | 17 +++++++++++++++++
 configs/dhsom.config                   |  1 +
 2 files changed, 18 insertions(+)

diff --git a/board/dhelectronics/common/dh_common.c b/board/dhelectronics/common/dh_common.c
index 6a942909cc..71010803f5 100644
--- a/board/dhelectronics/common/dh_common.c
+++ b/board/dhelectronics/common/dh_common.c
@@ -11,6 +11,23 @@
 
 #include "dh_common.h"
 
+static int on_dh_som_serial_number(const char *name, const char *value, enum env_op op,
+				   int flags)
+{
+	env_set("SN", value);
+	return 0;
+}
+
+U_BOOT_ENV_CALLBACK(dh_som_serial_number, on_dh_som_serial_number);
+
+static int on_SN(const char *name, const char *value, enum env_op op, int flags)
+{
+	env_set("dh_som_serial_number", value);
+	return 0;
+}
+
+U_BOOT_ENV_CALLBACK(SN, on_SN);
+
 bool dh_mac_is_in_env(const char *env)
 {
 	unsigned char enetaddr[6];
diff --git a/configs/dhsom.config b/configs/dhsom.config
index fc76632630..380bedaa5d 100644
--- a/configs/dhsom.config
+++ b/configs/dhsom.config
@@ -49,6 +49,7 @@ CONFIG_CMD_UUID=y
 CONFIG_CMD_WGET=y
 CONFIG_CMD_XXD=y
 CONFIG_CRC32_VERIFY=y
+CONFIG_ENV_CALLBACK_LIST_STATIC="dh_som_serial_number:dh_som_serial_number,SN:SN,"
 CONFIG_HASH_VERIFY=y
 CONFIG_MD5SUM_VERIFY=y
 CONFIG_SHA1SUM_VERIFY=y
-- 
2.30.2

