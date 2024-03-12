Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B575C54E66
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 09:00:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C02187F49;
	Tue, 12 Mar 2024 10:00:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="htthj8Kq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A62EF87F2D; Tue, 12 Mar 2024 10:00:11 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A048F87F27
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 10:00:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=L.Anderweit@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1710234007; x=1712826007;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i7KynB8sYA84kaAnpXY2+yNAqnV9IJ0YSX4xjWmTn+4=;
 b=htthj8KqCLB2NOxF5EdTqu/hM+j9xWEgqb/vbbY/OgIrQi0x5+Cn9MliBL8P3KGA
 jYDCqWB8E1OcLjvDBx+UQidIUXqytCfElARglrtZiMXVmYZEDi5YsdC+NH1l2imw
 TkR93+Y4t6l4lSEXcpZ2BmNbG4TV/HM8P50l0vAMu2U=;
X-AuditID: ac14000a-fadff7000000290d-fd-65f019979f12
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id B4.97.10509.79910F56;
 Tue, 12 Mar 2024 10:00:07 +0100 (CET)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 12 Mar
 2024 10:00:07 +0100
From: Leonard Anderweit <l.anderweit@phytec.de>
To: <trini@konsulko.com>, <t.remmet@phytec.de>, <festevam@gmail.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH v2 4/5] include: env: Add phytec RAUC boot logic
Date: Tue, 12 Mar 2024 09:59:56 +0100
Message-ID: <20240312085957.902398-5-l.anderweit@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240312085957.902398-1-l.anderweit@phytec.de>
References: <20240312085957.902398-1-l.anderweit@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsWyRpKBR3e65IdUg+VrFC0eXvW3mDppM7vF
 272d7Bbd79QdWDx2zrrL7vHqwCp2j7N3djB69He3sAawRHHZpKTmZJalFunbJXBl3Jh6m7Vg
 u2DFhvMHmBsY2/i6GDk5JARMJHZP/MfWxcjFISSwmEli5vGdUM5jRonrm56xglSxCehLrHy5
 iAXEFhFwkfi1dA+QzcHBLGAmMeFzMkhYWMBB4tDHu0wgNouAqsTmznPsIDavgLXE09OnWSGW
 yUvMvPSdHaSVU8BGYvVERxBTCKjk6I0oiGpBiZMzn4AtYgaqbt46mxnClpA4+OIFmC0koCRx
 59QvNpiJ0869ZoawQyWObFrNNIFRaBaSUbOQjJqFZNQCRuZVjEK5mcnZqUWZ2XoFGZUlqcl6
 KambGEEBLsLAtYOxb47HIUYmDsZDjBIczEoivK913qYK8aYkVlalFuXHF5XmpBYfYpTmYFES
 513dEZwqJJCeWJKanZpakFoEk2Xi4JRqYAxKZhM++DH74GJvc9GJgU7J37syVbYuWbRv6U0D
 ydOX9uitOLDs0+HHMjJpPovL9KIec2yOPHBuR/mZKN17Fd/DLFm3c32dd2D7kj4fp2Lx9PO2
 enEWBlmffvIeETkhIHKGsbn35Out5cyM+wWOSenfPBkSxO3GsFnqyurcOUW/rST4Hz/L+ajE
 UpyRaKjFXFScCAAX+gfwXgIAAA==
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

