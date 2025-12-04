Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83CF2D1CDBE
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 02:08:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5EE383B82;
	Thu,  4 Dec 2025 03:08:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="NHja93AA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8509583B8B; Thu,  4 Dec 2025 03:08:21 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AE3C83B4F
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 03:08:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8cqYu01dM6brQXrsdz6EMaBsIgMuI7Iecpi61yvnwdjUIgb+OGZJMbUAw3OTppr6/mIvULk1Obf57e3mSiWtTcOAziVT9Ghl9oPn/32UGPsnvmOYsMoNfpS/+cYCmfUhahpduAiPa2uBa6h+4XKETBwKQJw0Ynsjm9R52jJoby7Suzrq13Zuzc9cq/UpixIYqaxJc4UhNhP1WzXIah7CHyRN7FZPcUERzwBkCzE2xKq3kbekLvOvHOX/675RDB16D5Pwz7U9KBSFngL/lWMpfejEBeErZ/Z2/aNctDZvJeIBV9bhZBAqY/EJeH8rTtiux59Z2kPuVHAx2IvDhufRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wd6clnZVfHOToYWlov/bIzl+H+PyQG4qAM7df2VnpBI=;
 b=gNRt1Ivmfcpv1+4K9Z9/LvHini4cNxZmqnb/IvR+pRhm0KjLip7OJHrqr0BskDkvgGlp9Xp7uXF9fU0tbfr2Sm2NGl4SfWQbcBgRdmvJUBmPoWm7OAW6Qh1nF/feEKFdHnyvjjipaIP3zg3ZCciE2cfEBu9QP1Eb4gM6yAS2KUaGtyhHyANiUbkBy/USpJldgn5W2ogbAGbjPFvv8fXv31iZz9CYyGbeCMIEhWnQe/Qsvyvngqe2W2FyWwii3QfO0QiNaQLpnJEbMoUriIjjDxhGkC4Tqe0wKDWhSsYt6FQHjm2Fht/ieJYaXCvW1tIarGgJ2V5/E5v8YqYRze2Y7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wd6clnZVfHOToYWlov/bIzl+H+PyQG4qAM7df2VnpBI=;
 b=NHja93AAzQiLgbeZt9WfzVZmFhCKFDRilVMFKke5ChDTbeKGXv07aVPN3kLAKP0ib8ed7MPGOIoLae2eQekjJEWTlIVvgqHgnDPLFNUEof40Py6wj9YgqUb/fuIu+VASc/VCtqN14KTgmzvB0LPXalZcUSzMiwex+IdNAZXnW/XEq45NNTf9isMuA6hFfz3BWCU21AWXTagqwaJsM9/mJ0Nz2dPTBZtokTO0z2UXOqepEuWB4j7a+JQgPOmPEnNBaCRaI1AM0Lh5N2ywkKFVq416ODE2RtiXtAOwpJNjo1PkUwjLFJqqjUI3cUF+HNUbWR6U6cQmoOjcAKbe/Ky7UQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by PH0PR03MB5912.namprd03.prod.outlook.com (2603:10b6:510:40::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 02:08:14 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%6]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 02:08:14 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1] configs: arria10: Disable mkeficapsule tool build
Date: Wed,  3 Dec 2025 18:08:10 -0800
Message-ID: <20251204020810.24716-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:a03:180::25) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|PH0PR03MB5912:EE_
X-MS-Office365-Filtering-Correlation-Id: 2097471b-507a-4849-4e91-08de32d9fbbb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h7RSCk0wmshOjLB1vrwAvTrRonT4aCiraz8k2A9aTnmR2n+e8zkuDVyJjSYs?=
 =?us-ascii?Q?FTqnveqtYroqGPWKGrM2nl+Erx4kXmeH4u5mcRdUqjFEHBtTFpFDl1S3i4BH?=
 =?us-ascii?Q?W1KOAEmkHcwwumLzXJ+hMK8gprASZqsN3L8hSoMB0hxpjyhC0kouYov/GMZt?=
 =?us-ascii?Q?wstkNKa45GH3x78D9BzlaXZ96Ccp7tBCWuE/id9WmiEJZhWWR1sACxfn7AYS?=
 =?us-ascii?Q?Jaxi/POQuUcYPmB0GCilxIC8Dw16VjBEoJS9R7jWee8g6AdXkK6pFdRVBbvm?=
 =?us-ascii?Q?BUDxi+x5EDiSZi7X9RoYqa25gQEoOHRNtcjJlNzJ/PS5xhADluRfSL4KCFHt?=
 =?us-ascii?Q?l6SYzG2b3gYUiOHz9U7w7Q3HogT8aDMmmdkq9pDQjx5I+BiquGK8f2iGgqd2?=
 =?us-ascii?Q?0N5RPKd9BL8qaP9/ptTE8qcqaQxEyB/laeKE+zaXHW0b3raycdiaom6RZ7cn?=
 =?us-ascii?Q?5skKaLo8Zey1ypWcd/YQCmue4MeSw8wtmukn0to8LYWwlOLPitgmKV3/2MQJ?=
 =?us-ascii?Q?ZKe5Zgy/5ZoUzSojHDB+G3wnQp2neHezfftrpYl8qyT8gi7JdgVCfCVcdcIF?=
 =?us-ascii?Q?6hY0h1oxlAUVHdx0RXwRn62YoMeSyyayR3Aet/Ek9mTkTf/VmhsceWVInuFc?=
 =?us-ascii?Q?ZvGycx+BwvGQwSZqVS2gdmuOokPP2fkBrz9lmQmkZgFaAaZfumWDMSu60BA0?=
 =?us-ascii?Q?iG0HUww0CcotiaeFVxLtDkBZIJr4Vd2aPh05XY0VpOjP2uBnMnkWLNWUSVfT?=
 =?us-ascii?Q?LGKkP6R26kYVf+hkP0Y1AZ02iNbn+aMgKfdHUA/jaRdX3WTqZeMQ9mpl8fuO?=
 =?us-ascii?Q?32jdNsxJHbvS4YuUI36oxZ4o4NZhhDswZVVumL99d23iG8hKohtzGZfXlZY0?=
 =?us-ascii?Q?SjQaE0MI1FgMdV1pY7pzIMDNdFwtSzr8iQu7DCv32YN8I8wtv8d4sticwrpi?=
 =?us-ascii?Q?TaoqVaxLUeLAE5TEH0tRXsiBtjb34xdH2tX/5Kv8Xzktnxqt+bFz0nRdLk7+?=
 =?us-ascii?Q?4OVzs1VtV9qG/pJQeFrR9hyQn51WyycgrTFgOLwo2WZbvQQ1+rk0MWYFkkRn?=
 =?us-ascii?Q?xHKHyb7tyJTW6ukFhTFwJ5J+GQ+y4SDWdXx6KhpzCZqqP6ZcpxKrBDPq0GSr?=
 =?us-ascii?Q?UXwP75fTk/s1VQJatgdNbwlKmHcTuIIf7X69/q1wAU5t/COBOshPjiBjuNEk?=
 =?us-ascii?Q?PXaA8NkTAhYHBfo46/Bj9a3erLytzTb9Iy0HUDSp6i4FWH307/f/gZ7UwTcH?=
 =?us-ascii?Q?xycIoCJ27ikR2XQONHHX7GHO9Q1zBnQGCfmreYtUEXNMWPVjLcGG3ffbOF34?=
 =?us-ascii?Q?X/VhkoqeSxRVEkTfRqAwwiaCsnw+8GZzXC1f+3poEMQMtoCxnGcf0BV+beWT?=
 =?us-ascii?Q?znZxHdWMHFTm/nyvVonrw5vaYYLFrf+ASgYfogWbAPUHWUm/a7rwLpoBDRHj?=
 =?us-ascii?Q?2iYJPStEraRXpNyCRkRDIFzAaUgu0Yjk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VL3FhwBc+PCSuqrWJT4OJpRMUmydUlo5CQ+pCQcpsNXLlSTXgPKTf08wOawv?=
 =?us-ascii?Q?efZyvEVy17nJJOW86m3ppN8YEEjLBxhMczpu8TfDrhMlh7+2J317ThYeRYmR?=
 =?us-ascii?Q?yJBIj5/S8qK239RDJ97+s9cfsYp3NkQX5e+fmlA62R9ETzAu5UxbsieWhETa?=
 =?us-ascii?Q?aGxaumAWD3PFFgmHMXNe2H/MxSeNYX7xOqHEfIIWrAavbLm5bDT7C38Jx4XP?=
 =?us-ascii?Q?K0kyLtimr2+FrpUuVVpsy2Pmyw24zEt3u7rTi+QZ/AZ6icibaAH5tLgT3KOl?=
 =?us-ascii?Q?WrRH5u8orkZPznyE6+fw56zX1Y2+BE4hQXY+97jIGbA+bzdJDAeiEYSXCNC9?=
 =?us-ascii?Q?2zboG7Mvezh056x+t5GV/DVW7nh8bLF3kO5UwlWBRcb/FAru6mOGBI8f+bKv?=
 =?us-ascii?Q?n/kTRJMoBEqJu1RvSyu/rur0VEHkXYn+dGknAiEfGYNaNcl++Pd39WL7Nc4F?=
 =?us-ascii?Q?uScqleBrxED8LWAMjVlM2Esc863aDVgG67f8GektGQ5VlgeymfOgIEs7rxIg?=
 =?us-ascii?Q?JNAdJ64x5awQzBEaqvpreOWjqaRGTcEoyVzdVupGp85Py1HIxHQijxQvENxv?=
 =?us-ascii?Q?bupDosawkHKr3xdCwB+X6JyfOeQhp8eKwQT6i4jl8Grp/YSQyWNe6adhyJxg?=
 =?us-ascii?Q?d0v2P80Nkp2lOiMkslyiXOkrVIzAsnNEJEap/SC7WTuJKmCcsltrTPKHyDt1?=
 =?us-ascii?Q?JPDFitI9t5i7oa3PWeBnFWYw9oCCu97hsllBSZzm6H86dNePQCylHQY7GkI2?=
 =?us-ascii?Q?vtsJz9phKZ/FxA1rkWvUlybqhaqyz8Iex32K7uaoYp2nP9BBPUXcYjnY8uud?=
 =?us-ascii?Q?Eu5TzUHD02NxiL9MHfVk0ynkPGGXwxgVH4Kl1BzNa9emalM9wqzETjwL5mcM?=
 =?us-ascii?Q?q06srS6s0UnoOt9DUhSTxW/dd37dJTS0sd6wwJ0P0LxpLwWPpBcvck8oiQMg?=
 =?us-ascii?Q?rauPeltGk/DnxAtQ2zNNWwJJFE8+ASaXNOVpm5vqMTPNuz38ueSlOcl57lGU?=
 =?us-ascii?Q?14T1WEQGXQjPgcaj55d8yU9VhOPPLLe/C4fanDo1I6kXD+NGyYOGizRMHxJJ?=
 =?us-ascii?Q?N3BTWWQrK6A8qKnCt5sMOVfKIQSYdMKnuWw/UX/TJq7mQ6jRayGceaqd3TCD?=
 =?us-ascii?Q?vObZsE1TL91geHMTLg3HqC/HBzXToz6dtEIpFnGatRu9UYlqT81zVXKO/VcE?=
 =?us-ascii?Q?ryh5BhlpAKfh9ccFWsIl7eIHs+5XQtfl+ReoxCJPWpD5Ht9jZeCl/q2nIUKQ?=
 =?us-ascii?Q?JtDdNDjiqsZZSUg7Odw4mUjUilUU7PZxveNiA1bK3w5CUonY/YhLhuWuIiPa?=
 =?us-ascii?Q?y3TzRwUU/F+fwR/cE9BzkDbxcoWKenOoDeAaV6TLtReStbdYRTWpSk/4Vuln?=
 =?us-ascii?Q?+gW276vjaD7yWHBdT0Rc2H8OLWl0Sjt7tjOWwunTX6AW75G+4id1ydE08Cgt?=
 =?us-ascii?Q?duwY/xG1VASR5P2WEBDVM4pvOOVCX4bpMblvP0j/5tNT3hP5t1LugGDl4U1J?=
 =?us-ascii?Q?bcxW+X7a4WGApWFD1sAXdx/T/oUfcPXwmk6IRvSFmnUf+MFiravzOiEcAaK5?=
 =?us-ascii?Q?cTAoDfvx3iz/nsM+By1ROitKITUB3ExugGqMG7ZRLx5MxU3Ad0lwNMCMZobb?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2097471b-507a-4849-4e91-08de32d9fbbb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 02:08:14.7748 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r/pPWAFKCu4OMRW3iXQJEsuvqgsX6Ae+V2uO5hqQofDoeigKZ7b+H18BLx2nciFy4P3I1diVbtPP1H7VKA3DTF7PjhwHBoPSfiP/HaHsusE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5912
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

mkeficapsule tool will be built by default if EFI_LOADER is set due to
commit b7a625b1ce49 ("tools: Build mkeficapsule tool by default if
EFI_LOADER is set").

This will cause compilation error on all our SoCFPGA devices, hence we will
be disabling this config as we do not utilize this tool.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 configs/socfpga_arria10_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/socfpga_arria10_defconfig b/configs/socfpga_arria10_defconfig
index 76fdc0aa4a6..b32f40ae408 100644
--- a/configs/socfpga_arria10_defconfig
+++ b/configs/socfpga_arria10_defconfig
@@ -68,3 +68,4 @@ CONFIG_DESIGNWARE_APB_TIMER=y
 CONFIG_USB=y
 CONFIG_USB_DWC2=y
 # CONFIG_SPL_WDT is not set
+# CONFIG_TOOLS_MKEFICAPSULE is not set
-- 
2.43.7

