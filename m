Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8566C5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 07:34:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 766E980C1E;
	Mon, 17 Aug 2026 07:34:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m4TYZNZz4SP6; Mon, 17 Aug 2026 07:34:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7B48A80D80
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786952080;
	bh=a1T6Akad+F/zNS5fOKNlfiW3zqE0uGLh7qvRkqjtpxo=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=qPjcoXaGEOfyVGiw3g9KGc4qLGn/DeQmFmOwPdQCUkFTiy60N+kScmatMspqBIwfR
	 vuwU5dFq0maVnKB2F1uBm1TfzVL9wtAzDSr7ofoR85rHrv0rEFJwhcun+b66K91fTv
	 MN16+iwxERN0bho20HqAevE+bTg1V6sFWpSWVHvAgA/NFIOFvmlCL2Qy2hTIv0CDfr
	 7yRygExjbDu/iDwm7ZihGP/67548bnh48xIbIj4dLs3v1NJx12oGjqu6Bpo3ZHsp8E
	 RI0dTbDHgZCfEqAOogMVl4zCgYCkzg60d/ok2pcDOChT/tS9iEWDrMDoL1xKGNFAX2
	 2taCl8XDUzuAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7B48A80D80;
	Mon, 17 Aug 2026 07:34:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2ABBD194
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 07:34:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 10B87406D0
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 07:34:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wlcp9eFxvTse for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 07:34:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c001::2;
 helo=sj2pr03cu001.outbound.protection.outlook.com;
 envelope-from=boon.khai.ng@altera.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 01AD5406CB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 01AD5406CB
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 01AD5406CB
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 07:34:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izlqfl0PeFMUeC32dyEGqwIykAqTIPGAwi5haK2Z1rJ2YXAI7FgRJRYOVE/O2DMxHcTrXyp/za2xQhaJ9T42KBXWohhToAYcEJr7HBnjfI2eQf/eTI0mxXpsKXzDZXFkalIshpDT4sRYeAi1ea1dRAm0T3jCKzD8KKjTvZfUqi/gNVWWMapgQ/IX7SHju8D2esALdnGDCPeFIwmKSr0mXXEt+fD3oqkpWlePbgtt1dL+ZZhG+SV7GZrYOxJqxFIq98vmlWtmLVvdBJqqIPIxtJpYEbX/Rjy68KpeK+DXgGF28R9fVkd+X6aY0AGE4YywZ9ufDpKECjEV0GL0nkDsbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1T6Akad+F/zNS5fOKNlfiW3zqE0uGLh7qvRkqjtpxo=;
 b=Bzxa9B/io3V80Pph/1iSsBBp8xLP8SNZK9T2wlvk5jhmLMy3fVaLwAPYGe96os7C5+MA5x+1Yx88E8ES+xL2smb7BYTiz/R1yoNv9+QB0KxhHYlqfkdlkOZA3GNfV3REClb3kVqDPJdr3uWutb1mgxhZXvYJf5hQtFLa6d3AEXezwzo/utgxEUCN7ffuurcJ0hDpDQP/zN36g2nwkMt0/mpdZDBzG0u677FKP5lniJY5AZuBDeIgMP5WprY28KDG2BnyJUbsiD32lNNphGrNdJsVRjIS++9k0Z7LB4kQN7TS7t5glWYzC6WFqEjS9lHS5gxrZ3U0c3JvUmqr0tVZWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by PH0PR03MB5702.namprd03.prod.outlook.com (2603:10b6:510:41::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Mon, 17 Aug
 2026 07:34:34 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53%6]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 07:34:34 +0000
To: U-boot Openlist <u-boot@lists.denx.de>
Cc: Boon Khai Ng <boon.khai.ng@altera.com>, Chin-Liang See <clsee@altera.com>,
 Dinh Nguyen <dinguyen@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Marek Vasut <marek.vasut+socfpga@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v2] configs: socfpga: Add QSPI support for Cyclone 5
Date: Mon, 17 Aug 2026 15:33:22 +0800
Message-ID: <20260817073322.26993-1-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0090.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::35) To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|PH0PR03MB5702:EE_
X-MS-Office365-Filtering-Correlation-Id: 63179d6e-587b-4a9d-d961-08defc31fb7b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|18002099003|55112099003|56012099006|3023799007|6133799003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: smDpdYCG3G3bp5KDBU/F8C7e9yjTNEvEdoUre7qFgcpHa+BLYKtr3ma64V+2O9CtnkVRda9wfhhFDfWo7xHFIraCdnRH6t2qmAQ0jcjGKiJnd9xrdHaIF5R0ShR9YXCw2ls6n+RofFo8BBtKmUvCyqPK4z8XKbGtS7l6GJYYTZNCOzq2naabZmVC5aMyyILG8txWQSAsPW/1aPmRXqCbSqaKjjyqXthbrF5OcvZHK8Fh+XeZwc4Nx3600aYWnPKmwe4iCYhn42hamTYfYNt5KkHisUWHCynFVw5EVRYr6ZvlqmgVFZb24QajW0r9e5Iajo2L5ICIHjmo6BGb4kzPpnm14vfOUR/y+BPtThVBtiqFrMQyjOy8bWMxBuZLsgYVzia597vuBBlmSWv/QUx9E+pIsl6d/bRWcKSTb8wo9SRD6bhbx87N4fCnihwvlZaKmHUnksf6WHaELcmFUmI8BWYPqfN2C1pKLh76i+83aThBX7hAknfZkbW0dI3zInSgRJx2ksL9QR/yNnAR7ynEneu5lIXSC9g9jpTIhYrFT1fxGnYaj4bzJAprn3uhUOq2xXKcTaQtY2fO9VPnq0rb3bu6sU6bn+9N8232iau2xJ74CB1b5RzIrAqSv7o2kS1Jb12yUF9y7rXJx7+Z2fttbGdFnKBvHcNQuWLhAax3sOU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(18002099003)(55112099003)(56012099006)(3023799007)(6133799003)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?59enITEhERAQSfdU6gIOddznF63QNTaSMG1oeWEOd7JXRy9RPuf9+dzCPxgH?=
 =?us-ascii?Q?UGoNTAjIADyXW5BNxxqbIda7IpI5NS0P0Q02nJdTytKB0pMo2A7YgJaW4nzD?=
 =?us-ascii?Q?NN/hfDC8PLqMlOeuxMSgSTTGrl9ZEGesLkO/zrz8JUg6RUPi6QvQQByri0w9?=
 =?us-ascii?Q?kik0pr3hKM0jlDzxYI4byms3nAzKW9XRIUtVP2cXCLTC0KYggN+w3LKblXl2?=
 =?us-ascii?Q?2Z7WT8q3P8xr5srbMAaFCWGiQQLdMvDeYPkXbGJJMek7FGu7FAs2VvIiC6jT?=
 =?us-ascii?Q?IeYDMmi1/BZVFW0z+yKm1DeAZ5iJhjlgoMxzk8hIigP2GxFYH35kM4SP5Nn5?=
 =?us-ascii?Q?SWQ6dEalXVD3ZLzHalkNLuNACNRuaO6Ld6Cb5sE+NVo/DHnB0PNE9urBuwtr?=
 =?us-ascii?Q?zQoqk8gyFYyI5Hb+7WRSI93XfrSaavqPwf4dRB487qYZatpF4g1VbA1sZnvw?=
 =?us-ascii?Q?QvWPQOo0L7aQO7S80ilWpa4tTxbwIgmBfEmAHMvo3ztspoNckhWLYbVKqK7h?=
 =?us-ascii?Q?hakxEjZOaoK5E5lE54bDTVhVhqIQmMZ5Updwdl/1GJM/PC2XQZyhmHUrU5FR?=
 =?us-ascii?Q?cV2E5v8VSAe/RXUeHH/OoGWfxtra+H24SbW2/ag51KTM8EUBJcOQJUI39KHN?=
 =?us-ascii?Q?E6Uqeo6C6M75uYxjNFEbZxhRtd1gB0Xc/i9jUlo25Q/mLEaoVNII86YUZSiZ?=
 =?us-ascii?Q?9sEZ6WPiKKUpWE5dCxZd6VBv9NR3KwG8z/WYEJf64azCfrfkB+kJ1JA990l5?=
 =?us-ascii?Q?zB7WK1TjZShMVxDyBZ5ImZiULfs1aAiC71Hj16JFCg2hN3gdc9wqIZKPAy9j?=
 =?us-ascii?Q?WdKL9oPXur7ajjHyGLSwqBLQmdWLhUoRnmhlXaOyvhjj1QrgHMt1T3ugVA2F?=
 =?us-ascii?Q?EKmTQCyYTX2GgDXjSOk+LAsVP9t0Trqp9t2j1fDh4/GM/3GNPcW+x0VodD5y?=
 =?us-ascii?Q?8GLIq62PIy6YphHAMG/e8oqIGR+jc3p0P+3UHIpoAhs2c09FN0Iau5auKAcB?=
 =?us-ascii?Q?GhG9wkpkJzre+pighaSC0GYYKDSj0NTJAxGsV+HbpkK3wueMDao1ED5yYX58?=
 =?us-ascii?Q?oPIuW3ZGS48ZnPrR0Cs1h9PR8pEJG33jOewm1H/guTaDeaRXEp6vlhJZ4ppp?=
 =?us-ascii?Q?w1KFJ/+99DbpLttSB1sCihqcCk0DioBC/abVSz17K2jsgFYS6ZkzBmBfXMcU?=
 =?us-ascii?Q?JxlfUpl5PdY6Qh1HDIVBzCDMhwaty1mVQ3Q/N/saD0pgPwvfJ9PwU4TDEIx0?=
 =?us-ascii?Q?YKtD+GBWB1d9qaEQun/y6J4NheCO77YcRlGUUmbT5rHtv0Z80e6HtpFWKHyi?=
 =?us-ascii?Q?O2c6x8dJb0tW0DQLG1/fV1nOWZFpCsiYjnP2lCReN6NyYT5inYS/tMsRnffD?=
 =?us-ascii?Q?xQS1IiZi+/G8dMGSYqjKGT6MP+RsJFlQCidyXrSySvTirj6mUIn3IoixA1oA?=
 =?us-ascii?Q?bL8haTMrm+LHE4Pav4bKM+HRCdPtXwxtM4OFvBPwKKdw47gD3ABVFVMnXMQe?=
 =?us-ascii?Q?VR6LiM5uUuMEFkfj5AsG9hBM5lFmjRt/m+lxi60m/ybO5g7CcEkhvdmHfzhA?=
 =?us-ascii?Q?eL97RoDJO+3XOrwWoXvXyowGbd9kkUA1z6DBJUlmGUzc/1iu1Gg9gxfazZnN?=
 =?us-ascii?Q?ucyO8vWH7MtS1oaDlJqrt4oVebHxDNIewlnrWcRR/IR7llOdDwI7W4xkrZDK?=
 =?us-ascii?Q?tW+ygHyTBARBj5GugEXfKbExj2lWIIDvCH26Bf/ABU9JzMAIRZ3JBXZXJ55k?=
 =?us-ascii?Q?PkqwH+w6QQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63179d6e-587b-4a9d-d961-08defc31fb7b
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 07:34:34.0228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /EViGj7jOmXzF3t0h/HTwXrW4AQTDw+XOzgtOTizAQXbuIUjj37jMILX0a+yD+XMCY04mcJkIztqU9BFqTplPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5702
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Boon Khai Ng via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Boon Khai Ng <boon.khai.ng@altera.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add QSPI boot support to boot target devices list.
Platform can provide their own boot settings through
SOCFPGA_BOOT_SETTINGS macro if needed.

Add SOCFPGA_BOOT_SETTINGS for Cyclone 5.

Guard QSPI boot-target integration with a new Kconfig option,
SOCFPGA_DISTRO_BOOT_QSPI, so that only boards which actually define
qspiload/qspiboot get "qspi" appended to boot_targets. Without this,
any SoCFPGA board enabling CONFIG_CMD_SF (e.g. Arria V, DE10, SoCKit)
for an unrelated SPI flash use-case would also pick up bootcmd_qspi
and could fail during distro autoboot

Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
---
v2:
- Fix commit message typo: OCFPGA_BOOT_SETTINGS -> SOCFPGA_BOOT_SETTINGS.
- Add new Kconfig option SOCFPGA_DISTRO_BOOT_QSPI, depends on CMD_SF,
  default y only for TARGET_SOCFPGA_CYCLONE5_SOCDK, so QSPI is only
  added to boot_targets on boards that opt in and provide
  qspiload/qspiboot. Per review comment from Tien Fong.

v1: https://patchwork.ozlabs.org/project/uboot/patch/20260318104018.2261-1-boon.khai.ng@altera.com/
- Added QSPI to BOOT_TARGET_DEVICES unconditionally whenever
  CONFIG_CMD_SF is enabled, plus bootcmd_qspi/qspiload/qspiboot
  helper commands.
- Added SOCFPGA_BOOT_SETTINGS definition for Cyclone 5 SoCDK (fdt_size,
  kernel_size, qspi_fdt_addr, qspi_kernel_addr, qspiboot, qspiload) so
  the board can boot kernel + FDT from QSPI flash.
---
 arch/arm/mach-socfpga/Kconfig            | 12 ++++++++++++
 include/configs/socfpga_common.h         | 18 ++++++++++++++++++
 include/configs/socfpga_cyclone5_socdk.h | 18 ++++++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index a9b639a5ed9..56aac117c1b 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -22,6 +22,18 @@ config SOCFPGA_SECURE_VAB_AUTH_ALLOW_NON_FIT_IMAGE
 	bool "Allow non-FIT VAB signed images"
 	depends on SOCFPGA_SECURE_VAB_AUTH
 
+config SOCFPGA_DISTRO_BOOT_QSPI
+	bool "Append QSPI to distro boot targets (boot_targets)"
+	depends on CMD_SF
+	default y if TARGET_SOCFPGA_CYCLONE5_SOCDK
+	help
+	  When enabled, socfpga_common.h adds QSPI to the distro boot
+	  device list and defines bootcmd_qspi (run qspiload; run
+	  qspiboot). The board header must supply qspiload and qspiboot
+	  in the default environment (for example via
+	  SOCFPGA_BOOT_SETTINGS). Disable on boards that enable CMD_SF
+	  for a small SPI flash or a layout incompatible with that flow.
+
 config SPL_SIZE_LIMIT
 	default 0x10000 if ARCH_SOCFPGA_GEN5
 
diff --git a/include/configs/socfpga_common.h b/include/configs/socfpga_common.h
index 36d6bfb3d03..910cd2648f7 100644
--- a/include/configs/socfpga_common.h
+++ b/include/configs/socfpga_common.h
@@ -137,11 +137,28 @@
 #define BOOT_TARGET_DEVICES_MMC(func)
 #endif
 
+#if IS_ENABLED(CONFIG_CMD_SF) && IS_ENABLED(CONFIG_SOCFPGA_DISTRO_BOOT_QSPI)
+#define BOOT_TARGET_DEVICES_QSPI(func) func(QSPI, qspi, na)
+#else
+#define BOOT_TARGET_DEVICES_QSPI(func)
+#endif
+
+#define BOOTENV_DEV_QSPI(devtypeu, devtypel, instance) \
+	"bootcmd_qspi=run qspiload; run qspiboot\0"
+
+#define BOOTENV_DEV_NAME_QSPI(devtypeu, devtypel, instance) \
+	"qspi "
+
 #define BOOT_TARGET_DEVICES(func) \
 	BOOT_TARGET_DEVICES_MMC(func) \
+	BOOT_TARGET_DEVICES_QSPI(func) \
 	BOOT_TARGET_DEVICES_PXE(func) \
 	BOOT_TARGET_DEVICES_DHCP(func)
 
+#ifndef SOCFPGA_BOOT_SETTINGS
+#define SOCFPGA_BOOT_SETTINGS
+#endif
+
 #include <config_distro_bootcmd.h>
 
 #ifndef CFG_EXTRA_ENV_SETTINGS
@@ -154,6 +171,7 @@
 	"pxefile_addr_r=0x02200000\0" \
 	"ramdisk_addr_r=0x02300000\0" \
 	"socfpga_legacy_reset_compat=1\0" \
+	SOCFPGA_BOOT_SETTINGS \
 	BOOTENV
 
 #endif
diff --git a/include/configs/socfpga_cyclone5_socdk.h b/include/configs/socfpga_cyclone5_socdk.h
index c23ba2325b8..3ebb7b18020 100644
--- a/include/configs/socfpga_cyclone5_socdk.h
+++ b/include/configs/socfpga_cyclone5_socdk.h
@@ -10,6 +10,24 @@
 /* Memory configurations */
 #define PHYS_SDRAM_1_SIZE		0x40000000	/* 1GiB on SoCDK */
 
+/* QSPI boot */
+#define FDT_SIZE		__stringify(0x00010000)
+#define KERNEL_SIZE		__stringify(0x005d0000)
+#define QSPI_FDT_ADDR		__stringify(0x00220000)
+#define QSPI_KERNEL_ADDR	__stringify(0x00230000)
+
+#define SOCFPGA_BOOT_SETTINGS \
+	"fdt_size=" FDT_SIZE "\0" \
+	"kernel_size=" KERNEL_SIZE "\0" \
+	"qspi_fdt_addr=" QSPI_FDT_ADDR "\0" \
+	"qspi_kernel_addr=" QSPI_KERNEL_ADDR "\0" \
+	"qspiboot=setenv bootargs earlycon " \
+		"root=/dev/mtdblock1 rw rootfstype=jffs2; " \
+		"bootz ${kernel_addr_r} - ${fdt_addr_r}\0" \
+	"qspiload=sf probe; " \
+		"sf read ${kernel_addr_r} ${qspi_kernel_addr} ${kernel_size}; " \
+		"sf read ${fdt_addr_r} ${qspi_fdt_addr} ${fdt_size}\0"
+
 /* The rest of the configuration is shared */
 #include <configs/socfpga_common.h>
 
-- 
2.43.7

