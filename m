Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9553CD4F54
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 22:55:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07C558487F;
	Wed, 20 May 2026 00:55:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="eML/g8z8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D1C28483C; Wed, 20 May 2026 00:55:10 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B811F84859
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 00:55:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DAwVT8Hts0aaJnxP2xwrS1haJ2LOq3aJhFDi3XqhGTjA5P9L11opvrNK61cDE63wBHmyvsLCnRlreezkuhSYIOH0c/LdswIjgXcOj9cUATKCNb/AWJWR3yDP4EQWYGJzLP4VgJKC26OY3d1a5C1OTTrkzIW6UgxUhIt629WhiKGkcpMDIsHhE5tP0nVNaX9DN6ooTk3vJzM7RjreavyZhD7Ac9OZ1x5Bbz4d65V6Lf1Wz+K6jvr/j3iopuvO7RDJ4gs1RDMoxjtG6kPRFXUCBdz+QF9iE0zyGAC9y5Qf0QQWwZwWSnc8dHa5LeOtUx70DoDsClzCXFcEhYd0c0cNwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b5sb0x4btiUt/PD/iBuGPR9FMmR0BGtfPEdHu6zcrig=;
 b=JjtyvEsGne3YFmudup/L0DZP3LsGMHXUiPszNh+VFA7fDiAKLe2vp2XeUdThWodLore96sSY7ucJTL3wwdJGPgF/qixpx+VAbeEfIQhP76RtuaRl9Nt7HqHuxuPL/MrfX0/T7wFopN8bNM/RI64xFY4mQgKSRxrKyx+JzoK8MH+dNn9fPp0lTa62TVDO+Gbq9moVxd6H4uylvJ0ZX6TPZA74i9sN0wDoKFRwegFBDCyZgPe1DOosCCGFP/ulWrz5OoZKuqHM5aDAkSpcyBYwLiKZ48TGsAIxN/sNFSZImCxwGZmtamN1JF8I/MCZiShynjxmIOSGKyq36a1ykhv2FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5sb0x4btiUt/PD/iBuGPR9FMmR0BGtfPEdHu6zcrig=;
 b=eML/g8z8fqRXcvFliBeeuGnMoi0l0pxCvIuD5WJ67zzJF0CvzM0jJe03bV7wcIOLWuxSLQ4Y3nqD2TliEoQGa3N/qDQrYSeVarKHPmQXEykoMAqdR0ulLF7A9qq89OoMZLFGZKZH/riUVHX1aOgwhavy+XA4NWV364kB85fL48I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AM4PR10MB9424.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:6cc::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 22:55:05 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 22:55:05 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 3/3] test: hook up test of allowing control DTB to act as
 FIT image
Date: Wed, 20 May 2026 00:54:58 +0200
Message-ID: <20260519225458.5587-4-ravi@prevas.dk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519225458.5587-1-ravi@prevas.dk>
References: <20260519225458.5587-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPCP307CA0004.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380::17)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AM4PR10MB9424:EE_
X-MS-Office365-Filtering-Correlation-Id: cd4eff4d-405a-4cef-044a-08deb5f9ab1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|11063799006|56012099003|22082099003|5023799004|38350700014|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: uhR1Y+Fn8f80zi2eVOl+5PQzepqsfBp6ZglBiRCaEBaObVZaTvKtUNX4Owbl9czd8AfOeUMn3ahcbRgCNPUaoqOQrL71BAorZ8WdBNDaXq1J+P5QjTXfdKrqFWhp07uELKHXHOmi5wTGhB6Yd5lalxH3jPzb0ZXthVFxOQfw54s2jWK8LL/CsrAz47Uw5nJwThnRjZCqN9ZXbAkxTeCEcARyEZaLzCebie/WbKNPiMife4lCTVhOiLBBXZ2hp/bR4N21HhmguFVOm22gbDGBBodkdWMuKia9Dka9JTKpWAfHboqAsbmskB2WXzdD6giHyrlbQU0aLxxXtWZSESELAZ+3M2Ee2K3CKuE98HnnSezCrL8LK9M4BL8l63FCkFX3gCe1n6ZBncE7wOuaOPex0m92d0mD4Y970RSLU8ZrV/h6tPFgVv+8ppgyK55PP/amtK0ALGzSg7klpx/rWF1XjeJK95fkrQt9seuhdOVYc7yubu/eY5KgTdjJKXaeX6f8xK08uVyluo8XK7DW6/+3WF4DdebfYtdKXnSDcROB1mB5FPVMHBqzEXZzO9zgLG+0NLhkXsEYzM1QKt+ORV2arCypSnI28ZtD7IJjvBNStx1J38e3VyqesLQKJM9sRZv7MA0806H11w1xybV+jTEfYPzbur2EPm6VYwgEKoUMJuoHgTfTm2zY7LXIR2+1cRS5i3d4VTgYMSHiIID4G+3WVHwQhsmr69+/kU0NlWu/LG4jdAE6NqNLhGC9HTWel0vS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(11063799006)(56012099003)(22082099003)(5023799004)(38350700014)(3023799007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0ySEHEcaC5cMPA7dXCWrVhx9tDH8Phsc/Py5SYByfuGpTnW4f6WDsE3GSw+M?=
 =?us-ascii?Q?rNRrMSeJyeZZqccqRtoLXqhUBqPFkyPWL53BC+Ta/97ivX2ePgtiPUU0+V+3?=
 =?us-ascii?Q?ECtIWcDBQgYnDPjVgqcJLex4PDPwFcZjrOn0AEsvzKybDt/JEIyLuX3vwbL2?=
 =?us-ascii?Q?qhL+S/0t7maj6/9t3ewXuQZxknZizAd+LENna0lBcMQ4gl8CqWTUSnA883iJ?=
 =?us-ascii?Q?fk1cspfufAONq+HcmdLnImhFf/usjlhcr3VpqInO1IEUfJb64OChRJdYG20Z?=
 =?us-ascii?Q?CVsx7Ry9PBAlNo3dBUrP3WAOoIfh1gnVfqncGD2fN0pO5y8u74kUJWVHZqj3?=
 =?us-ascii?Q?6DN9k7YO5D+zWGMrx3eYk9SOeMDk47hSLkJInONMSc6M0x6sDWtUoe8k2Z7Y?=
 =?us-ascii?Q?qmwsGj6A9PmEkf+hhCbpeYp6LEPfpRyXkt+T9Nzs0XlH06uHlt5s1ElC+b59?=
 =?us-ascii?Q?04puWSdGHQOyZ5jp4QP7mZZrH8ZbxP6+xUme8tJnQ548N7/FIU+MSJJBYYOb?=
 =?us-ascii?Q?o/cPVeWr/XIihhlg1vvhj++DU1fGqARMADtiGFbJF0FUDeYYkeYMSd6xI8MY?=
 =?us-ascii?Q?S6XQHzYONlOjjX7jiNsUbFgMyKWO24yUXFavcj/7eLdnm2iXAUV90kN5l/gv?=
 =?us-ascii?Q?I6GQIttr6lmXnVxx2YfCtQpVOzpF0PUKegXTRtwfORmm4vps9GNkFGg8xS7C?=
 =?us-ascii?Q?G0lHiHG6QKSbCyTpywvzOrNTep5owB+h8q8cf53H+U2la/2WMYlOWBXWMvLV?=
 =?us-ascii?Q?fZjf+Jz/DWkCLsHlYM+vhyfR1a0Tekvl1icD8AT83qIDErpBL+1Ncm9imw1/?=
 =?us-ascii?Q?6BP681GIWShGiGoEaepFNNg69CqOVg8kKR03XR+2NDFQJxg/yvUJ69FOPc7h?=
 =?us-ascii?Q?WBhyJTbGzOa8Epbq9Wkmce+9+C+pvTFcIPaw77/ZKuXLqMPG0RSj6Ax7U3MQ?=
 =?us-ascii?Q?MOj+3HB7FBhP3lvF8n4ltll7ppmt2OZxIbgm0SF46VtYv6jv4hcXivE8HZjV?=
 =?us-ascii?Q?+bwF1z2v9QANsCj/rJ12ox8MEfJatvQbCGxUqNw+wu8Zla5s6OeiXnKNb4NC?=
 =?us-ascii?Q?k0rf4AhHRTy86s8TuwjOnsVVrXzd1UStnOzc15rNSXdoq9i+us9lbMqVqall?=
 =?us-ascii?Q?RENs1GA4CdQkZuqnK1vhHNkqRou9nc2C68ETLefkUrreBYFLjNA4xDEGvz56?=
 =?us-ascii?Q?IeouidIvT+CbnKb/Dxx4IIDBQcbMZWg6WCYG3xZZ8LApA3bDP6mkNgL/N8VE?=
 =?us-ascii?Q?JfO+s6g2g7C6INysj3O497Fhfwnbt3JVtpgpFZb9+gRE1ZenQeESN/X7KdtV?=
 =?us-ascii?Q?w2eupz+o61QHE7ZQlSpmRTk1edZlX6xkU8wboQfQSSHVUqBkfircWGkKmmEQ?=
 =?us-ascii?Q?C0Lj+WZzPj/d78aKdIDjvLV9dZjA9TbGXhQkb9FxiUTw1pkEFz5Tvg3Pbn+Z?=
 =?us-ascii?Q?RdeHhrzDyY9pe924asPGecF/IhkHjV7IG+5D+vNNBNLKf7EneGjqSzkSuqTc?=
 =?us-ascii?Q?M+7utylPjgPNQaW6zBjJgqTh3JrPQkoZm26pFMehiXY+lxtRtnLv16RJwqN4?=
 =?us-ascii?Q?A670rLKgFBKQRRb14jBKRS4b5hJbclF6Qai9oFieCeEwqdxCz7CFzKy/1NAQ?=
 =?us-ascii?Q?178IxBSYrLW6SuxDztxlvEXLtpis4Wh8ie2bjY+GkI/baNcftZCQgPuhMGw1?=
 =?us-ascii?Q?6VIZzGj7i4XV8pOWHZYOyJZT3zxE5JDbF3mh6mIuzuW3rKdBkPwLUIxlXdb0?=
 =?us-ascii?Q?gewrb2aUeQ/ssJ19am8BdTk1J9ZdkjI=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: cd4eff4d-405a-4cef-044a-08deb5f9ab1e
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 22:55:05.6640 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: odqfJpNaIuRbguJyvkBvGxk99a0b7BX/qupIiPIiFXo2/jVuunRtJu5Y2F2CXUUYnQYmLIxfvhujXK4G/zfo6/psYCCYWHHCX8QVgpGZvcs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR10MB9424
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

Add a test demonstrating how one can embed various scripts in the
control DTB.

Verify that the source command can be used with ${fdtcontroladdr} by
itself (invoking the default script), and with :<node-name>
suffix. Also check that the scripts themselves can invoke "sibling"
scripts.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 arch/sandbox/dts/sandbox-boot.sh      |  2 ++
 arch/sandbox/dts/sandbox-inner.sh     |  4 ++++
 arch/sandbox/dts/sandbox-outer.sh     |  4 ++++
 arch/sandbox/dts/sandbox_scripts.dtsi | 24 ++++++++++++++++++++++++
 configs/sandbox_defconfig             |  2 ++
 test/py/tests/test_source.py          | 18 ++++++++++++++++++
 6 files changed, 54 insertions(+)
 create mode 100644 arch/sandbox/dts/sandbox-boot.sh
 create mode 100644 arch/sandbox/dts/sandbox-inner.sh
 create mode 100644 arch/sandbox/dts/sandbox-outer.sh
 create mode 100644 arch/sandbox/dts/sandbox_scripts.dtsi

diff --git a/arch/sandbox/dts/sandbox-boot.sh b/arch/sandbox/dts/sandbox-boot.sh
new file mode 100644
index 00000000000..4f7fa661151
--- /dev/null
+++ b/arch/sandbox/dts/sandbox-boot.sh
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+echo "* default script"
diff --git a/arch/sandbox/dts/sandbox-inner.sh b/arch/sandbox/dts/sandbox-inner.sh
new file mode 100644
index 00000000000..b8fc8f7484b
--- /dev/null
+++ b/arch/sandbox/dts/sandbox-inner.sh
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+# Some comment.
+echo "* inner"
diff --git a/arch/sandbox/dts/sandbox-outer.sh b/arch/sandbox/dts/sandbox-outer.sh
new file mode 100644
index 00000000000..40294085433
--- /dev/null
+++ b/arch/sandbox/dts/sandbox-outer.sh
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+echo "* outer 1"
+source ${fdtcontroladdr}:inner
+echo "* outer 2"
diff --git a/arch/sandbox/dts/sandbox_scripts.dtsi b/arch/sandbox/dts/sandbox_scripts.dtsi
new file mode 100644
index 00000000000..c800ec39e87
--- /dev/null
+++ b/arch/sandbox/dts/sandbox_scripts.dtsi
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/ {
+	images {
+		default = "boot";
+		boot {
+			description = "Test boot script";
+			data = /incbin/("sandbox-boot.sh");
+			type = "script";
+			compression = "none";
+		};
+		outer {
+			description = "Script testing recursion";
+			data = /incbin/("sandbox-outer.sh");
+			type = "script";
+			compression = "none";
+		};
+		inner {
+			description = "Another test script";
+			data = /incbin/("sandbox-inner.sh");
+			type = "script";
+			compression = "none";
+		};
+	};
+};
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index ba800f7d19d..bfdc5ee6010 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -20,6 +20,7 @@ CONFIG_EFI_CAPSULE_AUTHENTICATE=y
 CONFIG_EFI_CAPSULE_CRT_FILE="board/sandbox/capsule_pub_key_good.crt"
 CONFIG_BUTTON_CMD=y
 CONFIG_FIT=y
+CONFIG_CONTROL_DTB_AS_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_FIT_CIPHER=y
 CONFIG_FIT_VERBOSE=y
@@ -152,6 +153,7 @@ CONFIG_CMD_STACKPROTECTOR_TEST=y
 CONFIG_CMD_SPAWN=y
 CONFIG_MAC_PARTITION=y
 CONFIG_OF_LIVE=y
+CONFIG_DEVICE_TREE_INCLUDES="sandbox_scripts.dtsi"
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_IS_IN_EXT4=y
diff --git a/test/py/tests/test_source.py b/test/py/tests/test_source.py
index 970d8c79869..785e6fb935b 100644
--- a/test/py/tests/test_source.py
+++ b/test/py/tests/test_source.py
@@ -9,6 +9,7 @@ import utils
 @pytest.mark.buildconfigspec('cmd_echo')
 @pytest.mark.buildconfigspec('cmd_source')
 @pytest.mark.buildconfigspec('fit')
+@pytest.mark.buildconfigspec('control_dtb_as_fit')
 def test_source(ubman):
     # Compile our test script image
     mkimage = os.path.join(ubman.config.build_dir, 'tools/mkimage')
@@ -34,3 +35,20 @@ def test_source(ubman):
     ubman.run_command('fdt rm /images default')
     assert 'Fail' in ubman.run_command('source || echo Fail')
     assert 'Fail' in ubman.run_command('source \\# || echo Fail')
+
+    output = ubman.run_command('source ${fdtcontroladdr}')
+    assert '* default script' in output
+
+    output = ubman.run_command('source ${fdtcontroladdr}:boot')
+    assert '* default script' in output
+
+    output = ubman.run_command('source ${fdtcontroladdr}:outer')
+    assert '* outer 1' in output
+    assert '* inner' in output
+    assert '* outer 2' in output
+
+    output = ubman.run_command('source ${fdtcontroladdr}:inner')
+    assert '* outer' not in output
+    assert '* inner' in output
+
+    assert 'Fail' in ubman.run_command('source ${fdtcontroladdr}:no-such-script || echo Fail')
-- 
2.54.0

