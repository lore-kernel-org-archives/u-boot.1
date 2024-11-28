Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95FD3D69113
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 14:22:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 039F089D08;
	Thu, 28 Nov 2024 15:22:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="NmI37WY6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1118D89D0E; Thu, 28 Nov 2024 15:22:54 +0100 (CET)
Received: from mx2.securetransport.de (mx2.securetransport.de [188.68.39.254])
 by phobos.denx.de (Postfix) with ESMTP id 11C3C8985C
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 15:22:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1732803766;
 bh=3p10Y9PuV6QZhXshqot3LrFElSDF9q7pMuKQbSlWYNA=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=NmI37WY68jkOobqPrT4seew6K7miAaS1tjqq9sa/sPos0oB4inJkX3S4dZjGaRHu6
 P3xwyS4n2cASGOiOwnzKjrQkLpMdjoDDVA3sGqiP2arYDvL8eDvh42JBUsrNT6GN8E
 bVHXPe3VFPuNLm2m1jMnkK9qetHtjA+sUyYPe/uk2QRPpO19mdX7fLHMa/8FgjJrf0
 9luun6RyCITSpArmKEYAIPElz7PqDOO0Nqvvi7R/mzRYt2PfE3N4A0fb/QrbMXgf6l
 AJOm2mya3wryvaNLxhAU+RDn2UptIuC65g2dZJXMCRLoV+ncwGdJWAo8ylqoHH7+Rz
 IXAo0D92yjqig==
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
To: <u-boot@lists.denx.de>
CC: Christoph Niedermaier <cniedermaier@dh-electronics.com>, NXP i.MX U-Boot
 Team <uboot-imx@nxp.com>, Marek Vasut <marex@denx.de>, Fabio Estevam
 <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>, Tom Rini
 <trini@konsulko.com>, <u-boot@dh-electronics.com>
Subject: [PATCH V4 3/4] board: dhelectronics: Sync env variable
 dh_som_serial_number with SN
Date: Thu, 28 Nov 2024 15:20:19 +0100
Message-ID: <20241128142020.35386-4-cniedermaier@dh-electronics.com>
X-klartext: yes
In-Reply-To: <20241128142020.35386-1-cniedermaier@dh-electronics.com>
References: <20241128142020.35386-1-cniedermaier@dh-electronics.com>
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
---
 board/dhelectronics/common/dh_common.c | 17 +++++++++++++++++
 configs/dhsom.config                   |  1 +
 2 files changed, 18 insertions(+)

diff --git a/board/dhelectronics/common/dh_common.c b/board/dhelectronics/common/dh_common.c
index 0bf1f2f8c1..4dff5f7b16 100644
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

