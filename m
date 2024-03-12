Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F6F4C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 14:31:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4318087FB9;
	Tue, 12 Mar 2024 15:30:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="CYfmK8U9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C67587D9B; Tue, 12 Mar 2024 15:30:47 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A391E87F60
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 15:30:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=L.Anderweit@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1710253843; x=1712845843;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VzDbe5DS04LWt/FV7B+1Zd/3fVoVBvJMDOwtSJWwVko=;
 b=CYfmK8U9PPpVOqITiy7ulrXuW++LHFN8eCvjZ0aIHHnWXXmZfSvEDbKxFagYAHJJ
 5OXoFd+q8RBZnCvAYam+bgs/UW9uFSUWUgM4hq38z2exmjk06artGaEc/qTIQssc
 rqJXBdjd+K/gbtJ+1h4SwcmVwF+Z48wbNWyD/XFUQWg=;
X-AuditID: ac14000a-fadff7000000290d-9c-65f06713fd63
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id FA.0A.10509.31760F56;
 Tue, 12 Mar 2024 15:30:43 +0100 (CET)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 12 Mar
 2024 15:30:43 +0100
From: Leonard Anderweit <l.anderweit@phytec.de>
To: <trini@konsulko.com>, <t.remmet@phytec.de>, <festevam@gmail.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH v3 4/5] include: env: Add phytec RAUC boot logic
Date: Tue, 12 Mar 2024 15:30:32 +0100
Message-ID: <20240312143033.3336-5-l.anderweit@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240312143033.3336-1-l.anderweit@phytec.de>
References: <20240312143033.3336-1-l.anderweit@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsWyRpKBR1c4/UOqwcIuFYuHV/0tpk7azG7x
 dm8nu0X3O3UHFo+ds+6ye7w6sIrd4+ydHYwe/d0trAEsUVw2Kak5mWWpRfp2CVwZj6e9YCt4
 Jlixvv04UwPjBr4uRk4OCQETie4TV5hAbCGBxUwSsx5LdzFyAdmPGSW69zWxgCTYBPQlVr5c
 BGaLCLhI/Fq6B8jm4GAWMJOY8DkZxBQWcJD4fCUZpIJFQFXiVXcbO4jNK2ApcWDqMXaIVfIS
 My99B7M5Bawktr3bxQ6x1lJidu8jRoh6QYmTM5+AbWIGqm/eOpsZwpaQOPjiBTNEvZLEnVO/
 2GBmTjv3mhnCDpU4smk10wRGoVlIRs1CMmoWklELGJlXMQrlZiZnpxZlZusVZFSWpCbrpaRu
 YgQFuAgD1w7GvjkehxiZOBgPMUpwMCuJ8L7WeZsqxJuSWFmVWpQfX1Sak1p8iFGag0VJnHd1
 R3CqkEB6YklqdmpqQWoRTJaJg1OqgVE8sk0rdSbvvGMhXCETjZ7Ner2H96BoauUav2M/5y5Z
 ktP2qqeeY/FjjnkHDtbwLI+RdNyna6Yot3mnRIykwpa+xd122+cv3LiBS6ss5VO37jPzX8xX
 vzwrjLye9oV/94aX3VGPJNYElm28faBRSeXFNedfphazVmd+eroqJu6PTvifY09uaD9VYinO
 SDTUYi4qTgQAL+/Oc14CAAA=
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
Tested-by: Teresa Remmet <t.remmet@phytec.de>
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

