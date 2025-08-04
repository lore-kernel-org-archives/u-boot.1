Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31EEDC87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 01:27:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32EE383E60;
	Mon,  4 Aug 2025 03:25:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="BJ2/VMfe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFD9A83E20; Mon,  4 Aug 2025 03:25:26 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0E5C83DB6
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 03:25:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jIRmfaSaR14yfcCo/22rt6p0qrgVcNbxfvm5visT3KG2+DHbRFNSLipM/W9Rzb5GAEsEiQ9+SbNVRu/wQiLUv3WE3iU6NFConwui/I7iCuW2J3z/faO51lE4F2QAlRhK4HlVHLsAoizHb7Gtrrl3g4uZjDXNPrrcFxXH9lw6Eu4ma3JTilYtd3DyZVvRUF69XLtrekvkRn9Y/JMcW6wAgLD160DXeitJxyZpIO8c4EIB+z2n9LAR6GB6dIMMjwKjyhqBmBwLrIH7x8JsPPkikZOLb8699jbBW0t0fRcCCwyMTYx2qDTi88Cfc8uaWg2wtrKyFue6xfsL/L3Qy1z5NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zm3N4usRg0Cvjxe83Mv+45vtoBpHv0+E38UWA1jqFn8=;
 b=F/VZ5jDRcTlruwqaqyV6bfO3A048L5B38YpYAZ21PmUXBwNlcCaa6bVScI+nrpjKeC197WzcPSUkqyI4UOv/EQwhTH1SiuNIgm/wfb3UA1STa7OefxIUS0xOOmpHicN9Yv/5Y2Rc+qCayX35e/mtO3pZ9JPbuPX2OEQk5TXiNhCUZbnro5cRztqPfnXgiT0N7bJkoKXN8ZQrZxjKmgf3T5EGvZx+zaVkS2edo5IsZbKoAsgGnZIudspbNTYwPjq4Au6bi787ZXxgCuwD9rqXoysDulC9PGqpeM0+Nf/vIKJrHAeeWcFXWQXKFqLDOP99om6Z+w9QkDTJ4nJM/su12A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zm3N4usRg0Cvjxe83Mv+45vtoBpHv0+E38UWA1jqFn8=;
 b=BJ2/VMfeckLB1CsL7VIlIVMRJMnxSQKF97gZJqUSbQGYxfBRh3VoN/2+j9xjlUQFgaCbsx+qwxgtIfwwxiPpZE3qrgXL84z+oHu2B4S69V6HZCG6DuUxsFFUUIs8/nGhtNPiGxJycgXK3Z0ximlT6HXbN5Xk/sDFdidqkXok9RJ6pV0OWvYQIrBtLefWEWLBwcyi5IlreqOKlmLo24ExThvHssOVsvOUMbyBOIZ4Ag9mogHBn+Kx/1z3fsrHJ8hyIUa0Cfr27BS9TVD8eKQ6KyUNOGZ/M+9KcDypXXP4LZapnbsRM8HisoOK8kx4X5tZhyQWGMToQJ5QWmrM4lIyLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SA6PR03MB7973.namprd03.prod.outlook.com (2603:10b6:806:42c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 01:25:23 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%3]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 01:25:23 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Naresh Kumar Ravulapalli <naresh.kumar.ravulapalli@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 13/34] arm: socfpga: Define the usage of boot scratch cold
 reg 8
Date: Sun,  3 Aug 2025 18:24:40 -0700
Message-Id: <20250804012501.21811-14-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
References: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0035.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::48) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SA6PR03MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: 443cf96b-dc35-4e6b-85b3-08ddd2f5c8e2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1FBVXpWQgr73MnkbZGtysqwmWG10+zCjaJVFY4XaNdMc2vdeyo6cMeJYYZ20?=
 =?us-ascii?Q?emPl8zdIk8V/0MchQml/9Uw5+umV5kYie5Gs44kGkO0/seYeuN1L4V/fXf8Y?=
 =?us-ascii?Q?0Ol1khh4FAJG5VAA/i6aFU7PaDjajK+0sL6VzqDw3k2wL1+07FId28jrCcLj?=
 =?us-ascii?Q?d52jQUZj/MQ1zr3ib8+hCmZOvKC9nOVHVaO2nyzJnNky11U+Ub938N+gxYYn?=
 =?us-ascii?Q?WFqqFta9QpkbMxnH6pBZvfYxt9t+sA5meGZ6UErxX2TvO9Bvo3HVPTHH8KOW?=
 =?us-ascii?Q?7mV9Fln6Qxsze9/83RXslLhTgcF/Lnz9y+tUM7ytyWbOlvrdjBwQBTkYihhM?=
 =?us-ascii?Q?0ke+lQ9k2veo4sKO1TEbZacpPmT2+LWa8M2Yhwn1NUGZJ858YpMQ0rURrNOE?=
 =?us-ascii?Q?HMRfJfye52cbdgouhexzPiZSTK0Mqsgv0uGxWgJWQYG5tyS6j+oS+BZIg01Y?=
 =?us-ascii?Q?278U9gyOCF2qDpXf/VRqehckfifsbZpPjy6332XmMWr1Pe+eNucztEPG7eNv?=
 =?us-ascii?Q?S/Ofrhk+sohEDdZkmdMYbaoIQxXd3oPkmdY558x1c7Nztxh2GcWU8qsrRxaS?=
 =?us-ascii?Q?vcOrZFi4Lezqm+eNM/jhathPC5uzgvuJJfSr4GQloP6xV1d0x8G8ZrZr41Qi?=
 =?us-ascii?Q?LmirQlgP/sa+lWPddhBctredx7ozUmi/mfd2SFzGYn7nDjEKUOcG33/mxdoj?=
 =?us-ascii?Q?Td+PQNLyArVtfpnHrP0TYWGUrGDyAhPnN1U91QY+9KrOIdYcn8TwHmcG1qrp?=
 =?us-ascii?Q?B0y3+Wt8wFRcB8OtoU6CwteawrTH1ferS4+B3LaRdJFRYLDfBBra3XI79zHq?=
 =?us-ascii?Q?5vkrAvaOqt4NgzpXAtN4rEaEMFzHYwN324tYz3hVXW0m144WjGQkSG2BOonD?=
 =?us-ascii?Q?egyHPUlMNFbFffhnsg8FNogYQK4/6l5IjJvILk6tPdleRN/MQvCbADohTFJy?=
 =?us-ascii?Q?0kOBvtCZSVFM3WSl/fUdTUgrH762eaZH7eo2Sr3r73LVyKfTIw+1YEi1b48P?=
 =?us-ascii?Q?f5avhbMpdkyY8u/MQZDPdKcroHjwwYB+vGgtHqf+cOs4YVfWd6eOJiG3ez3O?=
 =?us-ascii?Q?5iufg/W0lRvQfFkFT598NfJodnrZWxQojZbHWsMyuEz/EXjNwxmfRlwamI+a?=
 =?us-ascii?Q?FPwWro+uWZqEkkRjz5sFXNVqpFhcDOC2NGMb+CE7J23toV9x/ToOUWT/RTeU?=
 =?us-ascii?Q?qvwASpyjPQ7g5siqyRYxHH2xr2I8fpjo0cVFDFzg6uGj3IVgK7xTRP3AAojn?=
 =?us-ascii?Q?pLDFQOhyjmAT9kUDRPeGI7z1qFtdJkMoCPhp1jJI/VmIM+THJO+MJuLmfsDt?=
 =?us-ascii?Q?TZGYZUtf55jhCJVcGT2C2kAu0w+pTCIOAPIf7w6Udjzt+fT3ywpWgUkNqtFN?=
 =?us-ascii?Q?Px+YW0IupMuUEepEWR833zWSXWL/zyJhsS8SpmdLatB7lqu4+u5FTH4iPbK1?=
 =?us-ascii?Q?aOPOLrREymo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lrRavO/DAYazLQnYMh0Zzwz2sM+CAcg3oWHUuR+00ykDU6gSLj/CimR57b6c?=
 =?us-ascii?Q?UFyD3IOjd9G5Fl649RAbcsWI7svSgVJL6CF2YhyqBrkdknRHOs8Bdtwpx3gK?=
 =?us-ascii?Q?MpE/pUvqXQ8SM2jUbQXka9oiG2tMaeb5pLKctjXxaV2oCi5xNxjY/BC3nt4h?=
 =?us-ascii?Q?PNIrwfZLjk0EtZ+Oiy0Yb+8cC6rGvgX1WHuMSqkn+U4t2mSPP35SOS5f216t?=
 =?us-ascii?Q?DcOd68bHUopl3ELmKQ1VCd7RyokheHwb01bo/Hj3OTRqyOwNizxnqU8WVXO+?=
 =?us-ascii?Q?JMC8zjoovpXn/02EPFdheo/p80O5j4a/V783ciT0YfP2rI8gWRTkaxG2hoF7?=
 =?us-ascii?Q?lnXuyctD6LULqGyBe83SPg4fy9pzCGnJB1fTLEJoL13HDY+JklZN3CJDg5S0?=
 =?us-ascii?Q?jv9cc8xOyvegXH2+NgqT0HwbGi/FlL30+8JJfMEXCrKPVAmh5yPiQz0mm+AW?=
 =?us-ascii?Q?8iqTuEIMd8Ic611bF/3VOlUjtLg4HmlDebz48EY30QCr4KfY8cyP07T9vy1v?=
 =?us-ascii?Q?2TKs/i50zaXW9y/E3yclXpGW0rA/yVd0wU2SnzaRVKm299bvBupb4AEBD9ei?=
 =?us-ascii?Q?yJyxJspdGJNLduvniuo+ySOhrsoq/bAztKd0CK/w7hLUOJdsOYcmLGgt7Bog?=
 =?us-ascii?Q?wyRm24vWMAgsHCjM+tWqp9+3x4Uemsre8TItpnkpZBANWEZmJZ1r46EWHxcf?=
 =?us-ascii?Q?6qocBg/FnrEfilu+dCvWoatUmnxyWzc7y55FXw1bbAP8mPzLaoA0CRC3qmEs?=
 =?us-ascii?Q?VBPqqkiRDpwHezYZqSGesCkmUvqM2+xwD8PQ1i2ZUnk7B1XHtZLTUFuQlevN?=
 =?us-ascii?Q?5f4qzZF26Owh4E4ANKwABwNBLgUo0XUIW8S/Hi75YS46FYAvomq5Z0C3JdC/?=
 =?us-ascii?Q?baiFSx0Wv3AebFXsl8oB8ca9P0AThqx797DWQ/CmsbWUz/sTDQVECENAqWIn?=
 =?us-ascii?Q?6L8vVLru912ktSbTOeMwZgmN0qrbG8LT7h/i+9lvYHYzM7NiszT48zSJhtnB?=
 =?us-ascii?Q?w6GZzTzPTId1qoNNHW1NLB+MOtWRc8dEO6GeXrtUIfG6QWf9/aM9wjeSOzRM?=
 =?us-ascii?Q?at/qDXWJsE+/mlPkka3ums4d8dgDXf2aMO27b4bEXsoGsv/cFSXNDfHJfb50?=
 =?us-ascii?Q?fGOI2wkfOvJ2Ry/ZIAkJ6VuucDFjYmi66Xl1E7ldtSoIYTsEnKxPRn8bD7/H?=
 =?us-ascii?Q?dUJhGE59NBVw9Rf+wyWhTpO5dOQR3zskrKTULcefonVKl8p+WuLAxZH+Ihpt?=
 =?us-ascii?Q?t7ltDZQbpjwN+AWMvN9VXZiOc73Yr2TzhTQsC6+sSJmPcqVC+QMY56SrPgi8?=
 =?us-ascii?Q?j0lulWo3eypoyUvDSVB3a7n6GgvApGMSB1ZQDzzbQFCvn9SehTGCihavc8jT?=
 =?us-ascii?Q?OFdvlsr1xFkocQFMqLdsGXccDtCC8WHpF1hniaxx7aoN9feKsZK2eW6TWwpy?=
 =?us-ascii?Q?x/K7XpW/qJPUNpasVqgNIbODSHsTsL1rRD2/Fb4LFDTYISjR9NZwOSMsAP74?=
 =?us-ascii?Q?OFEzCv2CrXcmc8n1PuiAB+WaKk54r/kY4CqKkxwV1lDCfu0NAxT4X+34YL3C?=
 =?us-ascii?Q?mH8c4t22h3IagVk/f8gL3VzP35GvHblcBlenFAvkOfzVKS9hS/Jjrmuo9Geg?=
 =?us-ascii?Q?m2Ae3ctMlB3SbhBef63thOI=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 443cf96b-dc35-4e6b-85b3-08ddd2f5c8e2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 01:25:23.7147 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HUYQ90pCaPtRE+5ALh2NOWQsKwrATzA6kPT/cDM+4Fq3pwUU7jlr8PjW+jtognPwONTj072LsfWk5WtT0If8uMvMzObiROpSPkr9HvwjRnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7973
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

The boot scratch cold reg 8 is shared between DBE, DDR init progress
update and Linux EDAC. This patch defines how the bits are used by
respective features above and their macro names used in U-Boot.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 .../include/mach/system_manager_soc64.h             | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
index c2ca0a50e35..8e12aeec011 100644
--- a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
+++ b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
@@ -141,6 +141,19 @@ void populate_sysmgr_pinmux(void);
 #define ALT_SYSMGR_SCRATCH_REG_0_DDR_RESET_TYPE_MASK	(BIT(29) | BIT(28))
 #define ALT_SYSMGR_SCRATCH_REG_0_DDR_RESET_TYPE_SHIFT	28
 
+/*
+ * Bits for SYSMGR_SOC64_BOOT_SCRATCH_COLD8
+ * Bit[31] reserved for FSBL to check DBE is triggered (set by SDM to "1") ?
+ *
+ * Bit[30] reserved for FSBL to update the DDR init progress
+ * 1 - means in progress, 0 - haven't started / DDR is up running.
+ *
+ * Bit[17:1] - Setting by Linux EDAC.
+ * Bit[1](ECC_OCRAM), Bit[16](ECC_DDR0), Bit[17](ECC_DDR1)
+ */
+#define ALT_SYSMGR_SCRATCH_REG_8_DDR_DBE_MASK	BIT(31)
+#define ALT_SYSMGR_SCRATCH_REG_8_DDR_PROGRESS_MASK	BIT(30)
+
 #define SYSMGR_SDMMC				SYSMGR_SOC64_SDMMC
 
 #define SYSMGR_ROMCODEGRP_CTRL_WARMRSTCFGPINMUX	BIT(0)
-- 
2.35.3

