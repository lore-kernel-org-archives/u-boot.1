Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBEEC5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 13:07:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 331C587F1B;
	Mon, 11 Mar 2024 14:06:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="L9jh23k3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F6AF87D35; Mon, 11 Mar 2024 14:04:23 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9718587E32
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 14:04:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=L.Anderweit@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1710162258; x=1712754258;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i7KynB8sYA84kaAnpXY2+yNAqnV9IJ0YSX4xjWmTn+4=;
 b=L9jh23k3S5NTb6u9nQv8unU8/9LJk9IBZpsg/U+r86ZZe40+Je9lw5lE61E70R9U
 aqxQ6YCOgVtkbrfOu0CKDXoyCPzjfSfAxfisUkfnTAq3qSgTBjNq2Dkkpgx4eUb+
 nDgwLo9W8wglxzmd58xuYc+Y0C3Iwy6WDDWMewTWENU=;
X-AuditID: ac14000a-fbefe7000000290d-0d-65ef015258d8
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id A4.93.10509.2510FE56;
 Mon, 11 Mar 2024 14:04:18 +0100 (CET)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 11 Mar
 2024 14:04:18 +0100
From: Leonard Anderweit <l.anderweit@phytec.de>
To: <trini@konsulko.com>, <t.remmet@phytec.de>, <festevam@gmail.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH 4/5] include: env: Add phytec RAUC boot logic
Date: Mon, 11 Mar 2024 14:03:59 +0100
Message-ID: <20240311130400.4023780-5-l.anderweit@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240311130400.4023780-1-l.anderweit@phytec.de>
References: <20240311130400.4023780-1-l.anderweit@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsWyRpKBRzeI8X2qwcpHkhYPr/pbTJ20md3i
 7d5Odovud+oOLB47Z91l93h1YBW7x9k7Oxg9+rtbWANYorhsUlJzMstSi/TtErgybky9zVqw
 XbBiw/kDzA2MbXxdjJwcEgImEosmT2TpYuTiEBJYzCTROmk9I4TzmFHi4pE17CBVbAL6Eitf
 LmIBsUUEXCR+Ld0DZHNwMAuYSUz4nAwSFhawlbh18gUbiM0ioCqxc/l5JhCbV8BG4v/lFnaI
 ZfISMy99B7M5gepnPfjLDGILAdW82XSRDaJeUOLkzCdgq5iB6pu3zmaGsCUkDr54AVWvJHHn
 1C82mJnTzr1mhrBDJY5sWs00gVFoFpJRs5CMmoVk1AJG5lWMQrmZydmpRZnZegUZlSWpyXop
 qZsYQUEuwsC1g7FvjschRiYOxkOMEhzMSiK8r3XepgrxpiRWVqUW5ccXleakFh9ilOZgURLn
 Xd0RnCokkJ5YkpqdmlqQWgSTZeLglGpgdH3E5jG1vPPkr+Nhe0ov3q3x65E+eujb4zAvtUOS
 gYv7Axao7br2eKfVVa3tLMEu87corqvI/3H+jo3JGu75j4QkHjiX+vK53hRtu3X2/WGO40Ys
 TJdfRxdVPbu0XuJ6pFbAEg3bzcF1jtP9rt9sk/jQaayWGOobvErggEjO1E+GL/4eM3RlVmIp
 zkg01GIuKk4EAMsxOG1gAgAA
X-Mailman-Approved-At: Mon, 11 Mar 2024 14:06:01 +0100
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

Add logic for booting systems with the RAUC update mechanism. This can
be reused by other phytec boards.

Signed-off-by: Leonard Anderweit <l.anderweit@phytec.de>
---
 include/env/phytec/rauc.env | 52 +++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 include/env/phytec/rauc.env

diff --git a/include/env/phytec/rauc.env b/include/env/phytec/rauc.env
new file mode 100644
index 000000000000..89e17ff70ec6
--- /dev/null
+++ b/include/env/phytec/rauc.env
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+/* Logic to select a boot partition based on environment variables and switch
+ * to the other if the boot fails. */
+
+doraucboot=0
+
+raucbootpart0=1
+raucrootpart0=5
+raucbootpart1=2
+raucrootpart1=6
+
+raucinit=
+	echo Booting RAUC A/B system;
+	test -n "${BOOT_ORDER}" || env set BOOT_ORDER "system0 system1";
+	test -n "${BOOT_system0_LEFT}" || env set BOOT_system0_LEFT 3;
+	test -n "${BOOT_system1_LEFT}" || env set BOOT_system1_LEFT 3;
+	env set raucstatus;
+	for BOOT_SLOT in "${BOOT_ORDER}"; do
+		if test "x${raucstatus}" != "x"; then
+			echo Skipping remaing slots!;
+		elif test "x${BOOT_SLOT}" = "xsystem0"; then
+			if test ${BOOT_system0_LEFT} -gt 0; then
+				echo Found valid slot A, ${BOOT_system0_LEFT} attempts remaining;
+				setexpr BOOT_system0_LEFT ${BOOT_system0_LEFT} - 1;
+				env set mmcpart ${raucbootpart0};
+				env set mmcroot ${raucrootpart0};
+				env set raucargs rauc.slot=system0;
+				env set raucstatus success;
+			fi;
+		elif test "x${BOOT_SLOT}" = "xsystem1"; then
+			if test ${BOOT_system1_LEFT} -gt 0; then
+				echo Found valid slot B, ${BOOT_system1_LEFT} attempts remaining;
+				setexpr BOOT_system1_LEFT ${BOOT_system1_LEFT} - 1;
+				env set mmcpart ${raucbootpart1};
+				env set mmcroot ${raucrootpart1};
+				env set raucargs rauc.slot=system1;
+				env set raucstatus success;
+			fi;
+		fi;
+	done;
+	if test -n "${raucstatus}"; then
+		env delete raucstatus;
+		env save;
+	else
+		echo WARN: No valid slot found;
+		env set BOOT_system0_LEFT 3;
+		env set BOOT_system1_LEFT 3;
+		env delete raucstatus;
+		env save;
+		reset;
+	fi;
-- 
2.25.1

