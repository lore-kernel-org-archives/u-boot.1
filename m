Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF854CD4F24
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 16:16:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDF7B84099;
	Tue, 12 May 2026 18:16:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="mZbLuEqm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E704483CD3; Tue, 12 May 2026 18:16:41 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9513683E81
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 18:16:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WE5V3fp08W/6qi9QplkM+zrwkG9ZeLvj374+0oEOK5lMGfKbVgrUq2IonMPOcw06DrcjyThMdrMEmsyxFfygYr11a5hpGGWom/l7GrZu4PNXDOE+Kklr1DncTLm/Rn09rd+p91Jm7PSFPCE/2QFzAsqJode22KjtdPGl5ngydqB2GunAHSVNQRhPHGyE4Bjr27/YWENfVelBdbdLDnXhn49BNIzI68Ut+r70r8AgrZQS+DxfiaGDnsdZ34vFM7M46OuqJCX8Q2SMTWCdZn9zUNIAbQ7LCK9J4Hk13lzkw5N708E7G73R+HRkWhZslKRhtPs652uHAWLErrGtIsT7jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECQpvM8A0MrM/PBN5DNL5tMdxO/vJsLjE+c8Ew3llas=;
 b=xuupEwRsVFLIsgfZ8U15ivDAQhl45hhedhUuAWvFIac91VNhAY93bn/kcnX8dKXIPm5qdZh1Hl4fqpJIgp23wJwOuHfkWaxdTlAawcJs15XAWOpHocgUf9ZpjzYPr7mOLxUUzQ7Wq75tts4jTJR3GXopSa0qUaCw6R1tIflnfwSxBSN4eif1c3cHvQOGnaGy29kwxJUExk4c0HkadoGnllh5+4sJgB/sDKCN56iYBg7/yPfLux2MPG3uSBbnHgtoEFAiePRX2WBquKb9QEvOJ5SJsEf/5C6vAaFkvPm+xDKCyFj8RXmmX0WUt+hzajVtOOmgF8J2VJ8N7FBxzAz4Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECQpvM8A0MrM/PBN5DNL5tMdxO/vJsLjE+c8Ew3llas=;
 b=mZbLuEqmQmw0+sv528QJOuazMQ5FEauwh39IPmaktTRNC7jXL46g0PEBfZZMD9jcJ2nGO/34btwjTtQwSekFLZowx+5AkwNgsqOvWmoz6g1swIRVA/P41/WxmyV+FyC80wceMNCxtpQE0nrae8sGVVZHdO/MId1q+j3vpmFLkdE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AM0PR10MB3668.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Tue, 12 May
 2026 16:16:36 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 16:16:36 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 2/2] test: hook up test of allowing control DTB to act as FIT
 image
Date: Tue, 12 May 2026 18:16:31 +0200
Message-ID: <20260512161631.284143-3-ravi@prevas.dk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512161631.284143-1-ravi@prevas.dk>
References: <20260512161631.284143-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPAP307CA0001.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:3::10) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AM0PR10MB3668:EE_
X-MS-Office365-Filtering-Correlation-Id: c9837320-5f2c-4a65-b641-08deb041d734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014|3023799003|11063799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: YdBfYpot1RxzfBwL8nwVjH0hNCk3hDPWJcmPg1SAekjkgtngeVXCdcVErAIrrIdFHsisHzzQqizDUd9KQCcApFC2ZDjKjYEXvZw3ApUfa7NehjJcbhcyI0APhdB0KHNSt3HmbVpCk1T9xnLgu4smM+Mhmba0+688JTCcBYsvTJJSdgjDR0NIjLyrEtLc+6hpzbCDG8C9bulRG9VSFjSvYJoXStZJaCVnACHX/HwIKXG4W5HqjrwLDnzXyVLXDeJu/5vWnRRG5uCdkqMrZT8H33MMHkCd76wKmZ20Nzz27gOwfRTAQOnmCPa2kblhUSGikeJF+OyHsfD8GShljNpzuzVdQLh6S+cGxsQq1KYP0+9yJ4sYoBi40bEfQElnRY6Tm4zO1ZmUfwClgOOfn+qzgUWbqZI/CExQZN4Rpmd28RVr7JciQ7MdaucRohLqmE3XWJGcuhDQzt+Jqmm/fRFtql84gNGEy57JMLMuMqPpJGhZ2oB/YlKYmukmQoM9ftx+yfmBLXF8iLroG7d4qbX/0sLqcTEajVFEK4ue8Lfdk2ZiC7aKTR0YDxZZRizOoM6bbLuO5bfqSK265Z4PqvWJ2wiDg3phuS7gp0YuRcBcrmKWXk2Ily5K8uPzvW0hVs4u/G752C8fsnglkWBBWWn8Qos4evpx59ViehIVzDn22pUO5R9Dx4NE5Eh1eJ0T8DK+broewO5gduNO+Um304vy5V/sExPGQIIIMWIhvF+QK39hErURTbeBzf3l02SbaIo0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014)(3023799003)(11063799003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FU/9VKcIHjA42v/mq5E9+3FNj72/e0H7R/ZKKDx7Ipjv9T+JT+ZirBEnFCrT?=
 =?us-ascii?Q?uJ2TKJvQSa1AAhi2J1p5kJf1sFet6hcfDsIS+BiofSzT2yErh6Zv4/Ub1/cj?=
 =?us-ascii?Q?QvWrBJ89M3pZbCRTUfXczERaB2sDCEtusrR/eI+GcxrYFPWfXRMtdKKpXDPl?=
 =?us-ascii?Q?KZv+CEQ6JqZjR0O80TkXn1udgIdhXjLH9abGk8fr8RPmBWSDha0j1vkj+6D6?=
 =?us-ascii?Q?DpJbvIxEE5ZCVzTvbFti9lCwTTBYUCapSADpzT8ohSFiJbqApfp8VwQDgrIz?=
 =?us-ascii?Q?GS1j5Aap+WOSQprUD3EVFU/jV4mrXcGuELX1UEbPo0/fibAVi4CiyNcPE/uw?=
 =?us-ascii?Q?GCoI9JlneandZBZ24EYex53Ie0X36gMzn8oSYhPdCBzGO8VshXKDLLz/S0FL?=
 =?us-ascii?Q?gvq/EXVlbT48tZ+pJdCuPRAPqqGvJdmFCuXnFudjGaN6fUKE83IPS0vPApiL?=
 =?us-ascii?Q?5WL//Iaj2x9gj2252tfCAbh+dwkRR1frx6WL1DIu0fCTRS3q+mJYGFakv9u3?=
 =?us-ascii?Q?Hd6O9cZehkVI3ZiAautF4MCwE/H/rDutQ9pubcfEcy1NW/HupjuNuHhipDyT?=
 =?us-ascii?Q?szhyGnH2BONivAx7XuKli3JMrvVl9jDL0nTI5Ao6e1ahUSkSlm6bAIONpd4j?=
 =?us-ascii?Q?TYFihDgq6Hfl2nWrMLgFH+1/gmLrf5VE7Bi5g6PtLwNEgRfknfLhIFlMeQb5?=
 =?us-ascii?Q?Wq8Z5dmBAPhPYZ8i5Qhvi6zL8rMkzLaXS+TAb8kg7EFeRzsOpCGVy8AM2apO?=
 =?us-ascii?Q?YLl+geFojzfabMTFp8gWyPznEOe+ofPWqB0niLq7K+tuYxLGlX57vxGS4u9S?=
 =?us-ascii?Q?9ldSepfmvBAaOXD3016iJehv21pJjn0GEmHfMQGW2ut/kUZeacB338xyFGDK?=
 =?us-ascii?Q?5KJoqPc3aD3l2F8f7CG8uQzC966Y8qkO0fVvcDG8mVb7PPVXnsJ4wCIEi8Em?=
 =?us-ascii?Q?RZ5fCS8SMoW3BqBL/lXX2LguGyBTYIE52tOTaPp+2SVBJv7/TuA8GFzLNjU7?=
 =?us-ascii?Q?ilz9Z6I9/Q/R9zdU+Z8vPhZ6lOnyG9QgjhXu/bGvVpTAu8/UwAeMprcmwRWN?=
 =?us-ascii?Q?C5m8mwKxTJPyFGUYscYHEJKxHX+aVPHW4GW7HVgJHALxeyoX0rOOycQFw2QB?=
 =?us-ascii?Q?y+3Va5NM3CyW3L7vzG0Uhmjon5Zs01nSKcjPS0ZaZV9LaLgOJnxXixb7WyWV?=
 =?us-ascii?Q?KZCGJnQJlKjO3RCt+KGjHCzR5fhmDGTG72/SIE7xkoEW7r3DCsJbgQf2EyW5?=
 =?us-ascii?Q?oMZg78jIcs1pbQuJgTE+Dev99TMoF+vZ8K/2jzHw447+n6a+qKyWCk2Jv2/b?=
 =?us-ascii?Q?fUcwxKb/UG0/JmqG1pjdyi4QEUYZrVWTAAeVq97o47RBzeM3QbCxcsEoBIDf?=
 =?us-ascii?Q?6apxZ4zvkVxFITkz8GYVvlJYtCS/krsZHiSTyIw/YPnBB2PByT1g8Xl18J23?=
 =?us-ascii?Q?JTVdCEcnrzk2/2XNJ5N+6K6EG7xKXvW1qiJ/KCAXwg16K4C0QSmhFajPXV+S?=
 =?us-ascii?Q?OrFdE8B8YuVdBEf3RrdHzEf+7KStatjCXKXNwQ70r2IZbGuCwpQ5+3MS1+3u?=
 =?us-ascii?Q?kWTGvmiIinYpaBJCpXBWa7WJYx7k/GdMhWI1SwSp7QJPX7TIwwtWiTwwMFE+?=
 =?us-ascii?Q?jHSarXGg0RT+e5Czmh3lNCzUc4QLmaJNsSFzlh5a89Aj45xq24+MXWJtTVTv?=
 =?us-ascii?Q?NGZ4lSC/m/RYDFkhKslKvKe5qsJTU79hZKHQEK7QOBrA9IO1TfN/Im51XI8e?=
 =?us-ascii?Q?6Ixj8ctTkwM8qONPe1HuV4IXRGOqbBI=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: c9837320-5f2c-4a65-b641-08deb041d734
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 16:16:36.4527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wMI1ikEEzkQMkcdxjqZKKNn01MvLPxyUnWiLMsMKYAXFVU+pOHM6WXAJezrD5cxTamKU/DWqp05qZ3kaThroXRlw9SedntuepSyoql3uD/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3668
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
control DTB and verifying that the source command can be used with
${fdtcontroladdr}.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 arch/sandbox/dts/sandbox-test1.sh     |  4 ++++
 arch/sandbox/dts/sandbox-test2.sh     |  4 ++++
 arch/sandbox/dts/sandbox_scripts.dtsi | 18 ++++++++++++++++++
 configs/sandbox_defconfig             |  1 +
 test/py/tests/test_source.py          | 12 ++++++++++++
 5 files changed, 39 insertions(+)
 create mode 100644 arch/sandbox/dts/sandbox-test1.sh
 create mode 100644 arch/sandbox/dts/sandbox-test2.sh
 create mode 100644 arch/sandbox/dts/sandbox_scripts.dtsi

diff --git a/arch/sandbox/dts/sandbox-test1.sh b/arch/sandbox/dts/sandbox-test1.sh
new file mode 100644
index 00000000000..9d65a71bd7b
--- /dev/null
+++ b/arch/sandbox/dts/sandbox-test1.sh
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+echo "aaa"
+source ${fdtcontroladdr}:test2
+echo "ccc"
diff --git a/arch/sandbox/dts/sandbox-test2.sh b/arch/sandbox/dts/sandbox-test2.sh
new file mode 100644
index 00000000000..c84a0a3b97d
--- /dev/null
+++ b/arch/sandbox/dts/sandbox-test2.sh
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+# Some comment.
+echo "bbb"
diff --git a/arch/sandbox/dts/sandbox_scripts.dtsi b/arch/sandbox/dts/sandbox_scripts.dtsi
new file mode 100644
index 00000000000..f54c95b72b3
--- /dev/null
+++ b/arch/sandbox/dts/sandbox_scripts.dtsi
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/ {
+	images {
+		default = "test";
+		test1 {
+			description = "Testscript";
+			data = /incbin/("sandbox-test1.sh");
+			type = "script";
+			compression = "none";
+		};
+		test2 {
+			description = "Another testscript";
+			data = /incbin/("sandbox-test2.sh");
+			type = "script";
+			compression = "none";
+		};
+	};
+};
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 55dc7845544..083383eea2b 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -154,6 +154,7 @@ CONFIG_CMD_SPAWN=y
 CONFIG_MAC_PARTITION=y
 CONFIG_OF_CONTROL=y
 CONFIG_OF_LIVE=y
+CONFIG_DEVICE_TREE_INCLUDES="sandbox_scripts.dtsi"
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_IS_IN_EXT4=y
diff --git a/test/py/tests/test_source.py b/test/py/tests/test_source.py
index 970d8c79869..315aaee3fd6 100644
--- a/test/py/tests/test_source.py
+++ b/test/py/tests/test_source.py
@@ -34,3 +34,15 @@ def test_source(ubman):
     ubman.run_command('fdt rm /images default')
     assert 'Fail' in ubman.run_command('source || echo Fail')
     assert 'Fail' in ubman.run_command('source \\# || echo Fail')
+
+    output = ubman.run_command('source ${fdtcontroladdr}:test1')
+    assert 'aaa' in output
+    assert 'bbb' in output
+    assert 'ccc' in output
+
+    output = ubman.run_command('source ${fdtcontroladdr}:test2')
+    assert 'aaa' not in output
+    assert 'bbb' in output
+    assert 'ccc' not in output
+
+    assert 'Fail' in ubman.run_command('source ${fdtcontroladdr}:no-such-script || echo Fail')
-- 
2.54.0

