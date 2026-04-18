Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2150CF99C79
	for <u-boot@archiver.kernel.org>; Sat, 18 Apr 2026 11:21:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 356108422D;
	Sat, 18 Apr 2026 13:21:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rBwsK2r/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9318842BF; Sat, 18 Apr 2026 13:21:20 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AE2783B99
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 13:21:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJiCZS3u0902xnI4p2JFosQZl5cJZN24UhSrOc4WbujVMKN2sNSX/i5sEBAJMRb7KJLzIuEEesDezrhx/88y6Cd2WgRg4XkM20YxY+J/k2Wf66iz8Ctx+Lx5AroFjqCH/k4P48bxMePR3x09nJ1L1EnKpnFlT7hPPBA87gGC7Ef417Mge9Uj7esyTWnlrP8HK+MLJeEoouGs0CEBc8mkO+or02cNPpnxLX+RuCCVyeRiBgRhhzH7cX1cwHYfVHoulNR4Hsbp7I5x0I+uK+sH+xcqOohLdsGakJiVGaZcpXFcNJcCgq3AKAGNYwJ+gPZSL3SzEDqXGyekRbuvHIoZxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fW16NNXloCfDzwteube6HsMOWP4B0KMKMUw2DvH5XsI=;
 b=QKDup4ywN9JJPlm6asnPuwbzXgCw054vPtG0l5viBRgb4rMvDLPCRIRGOG8n2F9uI9sx5v7CXaK1TIySB31B2FIwcBrSL8igUZWGb8X9YWqxPqxLn2LHLtzqBwbgq6LDqI/QU0eeIHe2qq2w9+YpjN2EqiZhceL9lJ446V6UMHAX4FWiRNhBjE3cjYPM6WZulzYwkTnJMbfWMXIeZwLlh+tebfgIxMP3MEPfNmjskqIS/31gcC1PiU3ipqFm5cMzd/J4NQU9AJbpCQ53TT3s53ET0iHDs1mjumaxVDpAd4yYPTgKKwwdcRh2Pv/+aUiC/P5qhw0Zrlklld93ptmILA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fW16NNXloCfDzwteube6HsMOWP4B0KMKMUw2DvH5XsI=;
 b=rBwsK2r/qX2vEL/yZR9uK6EsSJW9JQzJcTlWhmKhZT6l+DzKRX6HPR3sRnjqGgiR41c7FEwZEyiVjGiJUK6NzLT7urVq08pp5xqIar+MXNbH3T1ls0b9qXkqep39G/dSKmxHaMCRDUD1nvodQmP/f5Oc9xn836d6CemUv+vMNoHfjD4b++ihZahMmalsqwhqcDjL0OyVItoCapxH1iUBxSZKV3fDVqIvyNre/8CWYpfDItIDkKnFuY/uPDgsJFsvc6oO0ghbGVyONn33G6boEtn6tqx9cSXEE5gwiw4Z6WIuNEaEhSbjEcQsx9rjAkAmO18zRA7Pl6UDIWIZ5/IH9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10756.eurprd04.prod.outlook.com (2603:10a6:150:226::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.30; Sat, 18 Apr
 2026 11:21:15 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9818.023; Sat, 18 Apr 2026
 11:21:15 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 18 Apr 2026 20:37:34 +0800
Subject: [PATCH 3/4] power: regulator: pfuze100: support non-independent mode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260418-pfuze100-v1-3-80d2a96dd927@nxp.com>
References: <20260418-pfuze100-v1-0-80d2a96dd927@nxp.com>
In-Reply-To: <20260418-pfuze100-v1-0-80d2a96dd927@nxp.com>
To: u-boot@lists.denx.de
Cc: uboot-imx@nxp.com, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MA0PR01CA0029.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::11) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB10756:EE_
X-MS-Office365-Filtering-Correlation-Id: e4197cf4-9037-4a09-7920-08de9d3c9a9c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|19092799006|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: VIH85/YNqZtSlo2hnSNmIkAZz9+tMSAL/28ama9wGZQMSoRGAksWzOFVSPGA3KA6IuSVpPqpK0Prh8LKDY1wAPjh7EmInpIQM9NtECfRQjExmyZ+/rd0jgrDpl+AppZMX7eOrbnOKUMtxGT/jyqnSn9LJc3BqBlXC+wbiUKw/WBVn9MG/rlP1fg5GxLTNd39U0YmIIFQcRpgvvJ1hhXFTCR4niZVymy0nDdnHnlTg6XX3CLXskjqgpVuu5cN7xI0nyfQY0jNOEc0BhGcK3otCeGAegRiWKD/hCDACmFgCYcK4SiRw5XsiproBE5pd+v3CQYiHBDp2bT/3pauabfiyTF3I6WGJE2m8uc9eXE70xd5vylj/vAZMXORVJHQj7/leQw3r8kFraMKXqKaw42scLjjROhdmEB8PiLZD4WzYFG6gOpetCcjEd8zNRFFXFFaIGNSLa2JYaGGDJlVeiVQ9cv6Nd83CiOYyWv25Zq+fQQw2v6rayEF/sha4CN3puXpD55+LlcDdrCbP9/4jbW+cMMLI4dsJPw3JV58PkWe+IRXil2vPZRs3YwzQ9jZUbGpRS6GJ48luTcXrLK/bZnLBZC3htuNvP85ajzhFKtHDvBNUqXlCtyFTbpIE1g2UGKHZ5I6gkvFVSssnyPKU0qUYDhieUseiaMQepYCvhPKRJQvj0SqG3RNa/Gxv0QH7Ed4B8KWmTnnq1iCQuqr9bDIyt/Jq/E7WMhbhpnaPybOTqgiF0Ns1fi7erxvWoBwTipUYX4GkzIKnFqQp4IGxkVbLZdLIiSmyrmXDxmeRTmucco=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(19092799006)(38350700014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b09kVFp0akNUTno2bDlIVWdLUnV0ZnBDUFREUE40WUIzaVBSN1JzcWRpWHNC?=
 =?utf-8?B?a2hvQTFydFNZNzkreFc2ZlJxRWFPUkJEQ2taRVVpUmFBZ0lZNFFRN1NxS05X?=
 =?utf-8?B?VVhzblA1dVRjV1pkb0FaZ1lsUjA3VkdLbFVMRmw5WkFQbnV4TldmUTRQeTIx?=
 =?utf-8?B?SjRKZUpBZmQxVlV2RUN1TytWcndkOXNRemRZTkhZM0g4eUFYbUZxSmhVSXht?=
 =?utf-8?B?N0xTVzVzc3p5d3gvNmdCSTZlMzNkbWx0clY1eU5ESXZ0Z1ZkMDhuT1VjS3A3?=
 =?utf-8?B?NnY2d2crU0Y5YUVFZFVnZWZpY0RrQzd3WG94dDlpbGpnWDNldksyd21VamQ2?=
 =?utf-8?B?aG1VRFpzbUpIT2hFamwyMTJBUUhxOEJNS0lJbVk3OFBVUXBJclkvTk5YQUU0?=
 =?utf-8?B?anpCWGJYaWhKcWJkb0MzSWNUV2E5T01BVk5xMmlXQ3pxOEZmY0RDMXg4Q0Va?=
 =?utf-8?B?YXQwNW0rNkNXQnY1cU5NRTNuR0o2RWxacm1qcEQ4RGdYWG9XdS83S0RiM2kv?=
 =?utf-8?B?blhLSnZrYVEwczFhN3U0aDRjNmsyMkx0enMzR2tGNXB1Sm4wQUcxcytEcENX?=
 =?utf-8?B?OXpVL0VNSHFiUGUwNVNvdEpzeFJvSmNFRlhsV1ZJZlBvOTk0YUZCbG8xRnhW?=
 =?utf-8?B?cEZnOUQ1a2grUFk3eWJneXlwWW52S2RsaWlQWlA1SlhhbkVsNVc0YWk4NlB6?=
 =?utf-8?B?eEdHWVdvT0tBanhFSUl3a0kremxLRmZRZklqMm10NjRXQm1Oc3VVT3NIdjY4?=
 =?utf-8?B?UTBUV2NmdXRId1pOU1VaMXdJMmdRR3hqZzJySURkdUkraG84NkU1M1JvSjdX?=
 =?utf-8?B?UzZwRFRFM21NUUxYem92a0NZcVVVSlowZDhjMUMxeEdmdndBSi9rTEZiQkNt?=
 =?utf-8?B?alhuR2FsNTY5WUFnL3RoOW80ejU5UENFS0ZNaEJZdDJCaGZEMUdCdWpOQ1BF?=
 =?utf-8?B?Uy9aODBCWVlpZk1JS2VEUXl4eEcwckQ4S290ZkpxMk5CT0xaUy8yY1NLaHBO?=
 =?utf-8?B?Q1ViOC9pR0FmOXVFUDJXS1NiQ0tkczFFQ0lXbWJlM3oyay8yTE9wYm5HOFg1?=
 =?utf-8?B?cnZISDVjL0liS2krbUZVc2ZLbFRRME9DWDdWQnRlaTErcVl4L0djVmdnWTAy?=
 =?utf-8?B?N2R5bXBYMjI0SzhhRkNKdzh1SVk3NktFVEpEcFNqR2lQampIVGR6T0c4dFJN?=
 =?utf-8?B?SC9vdklVdXlTaEFjRis0QU5jc1hrOVF6OVRHd3k4Rjgvd3p0aVhTeWxoYjFl?=
 =?utf-8?B?VjBkT2hibGhsRFZnWEtlVVJqVnNsWlNpK0JGY3F2ZFJzbnIzVWQ4OWF5d09j?=
 =?utf-8?B?WmJ6bi9vd0xHc0JXdVdiazEySzdFaFo4cEcxdFFXWGo4QzN2dVRKa1UvOWcy?=
 =?utf-8?B?UnlabEFEZVl3bHlkRS8wR29HaHhneHkwSnhWbXNDN1d0STd0THJkM05KeWtD?=
 =?utf-8?B?N0g4TkdlOUJ3Wmt5WGV3OFhReVV4ckNObFgwYWFIcDZRdG1XWEtKa1BBRXBB?=
 =?utf-8?B?T0c1SGU3bkkrbjB2MVdNNVN4eXVqQmo4NTZxRzh1ZktjaGFBeHFMTUpBSjNq?=
 =?utf-8?B?RDF1TDViUldhNXZFK3FxRjBHVk16cWRQbU9uY0FOVEgrblBQeUVCT2x1R3A2?=
 =?utf-8?B?TjdvcHZteXl3bGxFbUVpK3UxODBmbjl1WjB3a1J2OG1ET1l0RU80a09Zd2Jo?=
 =?utf-8?B?QjVBVSs3cXNRN3cyVWlYamhWalI4VHZ3ZWs3MXN2cnU2M0lZdUFTMUptU3gz?=
 =?utf-8?B?dDFUWUd0Kzh4UHdoM3hJRkthbmlRbjl6ZFlOOHhnc1labjhSejRrc3BUTmhQ?=
 =?utf-8?B?RUQ0bzVhVjQ0bkJVc1NnZ2lHcG1Ic3FOVk02YUNyMHkwWmtaMi9xZDhheXM1?=
 =?utf-8?B?UkRXK0QzNGlhSVQyWTRDTXdHNVNrZWdFM3dFREEzQ1VITlBQS21vbHk0eCtG?=
 =?utf-8?B?SC9GTElxR0FIWTg2U0dDZUNhYkV3SGVSblJndWN4aE5rN05kcHpYZm9DcFRZ?=
 =?utf-8?B?VEpoTTRWWlRYeVdPYURDcVpRbHVoKzBEaS90U2lWK0kxd2NMS3NCWVZDWXVv?=
 =?utf-8?B?bzRUK21XOFl4MjZPYWg3QjZ0Y0I3YVI4cGdlcjBxWUtUQzRGRlF5NzQ1ZUtu?=
 =?utf-8?B?SWhpL2N5alo5Zll3RmZpZkFjc2dIcHd0NnVHdU4vMU84bytKQ0hJTEliWW8v?=
 =?utf-8?B?NmltQ2pmVTBXT1pzZ1lPLzJiVTFTY0N0ZE9pUUxWRDAvK1hKTWZ1V1ltdHZt?=
 =?utf-8?B?bjQ5eG9OUGxPSjhGRkJlSitPOHhOYVR5aWlCaGE4UC96cEtobEFpMVJJTnl5?=
 =?utf-8?B?YWJkOWhRNlZTOEJpaXlxWWo5YzRNbmRSMG9WakxMbDV1bjl3bitsZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4197cf4-9037-4a09-7920-08de9d3c9a9c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2026 11:21:15.1797 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BpqyOqPGOXgb6lWWhqJkjK41NsDGiL0+PHcPyKmCzrCnQdBDgfL1s+4YAjiq/3foEa3znJuxM9yHNnskc3Onyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10756
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

From: Peng Fan <peng.fan@nxp.com>

Some BUCKs could work in single/dual phase mode, not in independent
mode. In single/dual phase mode, registers of both regulators,
must be identically set. So configure mode and value for both BUCKs.

CONF registers are not touched, leave them as default OTP settings.

PFUZE100/200 SW3A/B, could work in single/dual phase mode, so introduce
a new macro by adding a pointer to the SW3B descriptor.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/power/regulator/pfuze100.c | 49 ++++++++++++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 4 deletions(-)

diff --git a/drivers/power/regulator/pfuze100.c b/drivers/power/regulator/pfuze100.c
index ed69e6e14c3..77c82a00b65 100644
--- a/drivers/power/regulator/pfuze100.c
+++ b/drivers/power/regulator/pfuze100.c
@@ -33,6 +33,8 @@ struct pfuze100_high_volt_desc {
  * @voltage: Current voltage for REGULATOR_TYPE_FIXED type regulator.
  * @high_volt_mask: Low or High Output voltage mode mask
  * @high_volt_desc: High Output voltage description
+ * @b: Some regulators could work together to provide one output when working
+ * in single phase or dual phase mode.
  */
 struct pfuze100_regulator_desc {
 	char *name;
@@ -47,6 +49,7 @@ struct pfuze100_regulator_desc {
 	unsigned int voltage;
 	unsigned int high_volt_mask;
 	struct pfuze100_high_volt_desc *high_volt_desc;
+	struct pfuze100_regulator_desc *b;
 };
 
 /**
@@ -79,6 +82,21 @@ struct pfuze100_regulator_plat {
 		.high_volt_mask	=	(mask),				\
 	}
 
+#define PFUZE100_SWAB_REG(_name, base, step, min, volt_desc, mask, desc)	\
+	{								\
+		.name		=	#_name,				\
+		.type		=	REGULATOR_TYPE_BUCK,		\
+		.uV_step	=	(step),				\
+		.min_uV		=	(min),				\
+		.vsel_reg	=	(base) + PFUZE100_VOL_OFFSET,	\
+		.vsel_mask	=	0x3F,				\
+		.stby_reg	=	(base) + PFUZE100_STBY_OFFSET,	\
+		.stby_mask	=	0x3F,				\
+		.high_volt_desc	=	(volt_desc),			\
+		.high_volt_mask	=	(mask),				\
+		.b		=	(desc),				\
+	}
+
 #define PFUZE100_SWB_REG(_name, base, mask, step, voltages)		\
 	{								\
 		.name		=	#_name,				\
@@ -184,6 +202,8 @@ static struct pfuze100_regulator_desc pfuze100_regulators[] = {
 	PFUZE100_SW_REG(sw1c, PFUZE100_SW1CVOL, 25000, 300000, NULL, 0),
 	PFUZE100_SW_REG(sw2, PFUZE100_SW2VOL, 25000, 400000, &high_desc, BIT(6)),
 	PFUZE100_SW_REG(sw3a, PFUZE100_SW3AVOL, 25000, 400000, &high_desc, BIT(6)),
+	PFUZE100_SWAB_REG(sw3ab, PFUZE100_SW3AVOL, 25000, 400000, &high_desc, BIT(6),
+			  &pfuze100_regulators[5]),
 	PFUZE100_SW_REG(sw3b, PFUZE100_SW3BVOL, 25000, 400000, &high_desc, BIT(6)),
 	PFUZE100_SW_REG(sw4, PFUZE100_SW4VOL, 25000, 400000, &high_desc, BIT(6)),
 	PFUZE100_SWB_REG(swbst, PFUZE100_SWBSTCON1, 0x3, 50000, pfuze100_swbst),
@@ -202,6 +222,8 @@ static struct pfuze100_regulator_desc pfuze200_regulators[] = {
 	PFUZE100_SW_REG(sw1ab, PFUZE100_SW1ABVOL, 25000, 300000, NULL, 0),
 	PFUZE100_SW_REG(sw2, PFUZE100_SW2VOL, 25000, 400000, &high_desc, BIT(6)),
 	PFUZE100_SW_REG(sw3a, PFUZE100_SW3AVOL, 25000, 400000, &high_desc, BIT(6)),
+	PFUZE100_SWAB_REG(sw3ab, PFUZE100_SW3AVOL, 25000, 400000, &high_desc, BIT(6),
+			  &pfuze200_regulators[4]),
 	PFUZE100_SW_REG(sw3b, PFUZE100_SW3BVOL, 25000, 400000, &high_desc, BIT(6)),
 	PFUZE100_SWB_REG(swbst, PFUZE100_SWBSTCON1, 0x3, 50000, pfuze100_swbst),
 	PFUZE100_SNVS_REG(vsnvs, PFUZE100_VSNVSVOL, 0x7, pfuze100_vsnvs),
@@ -380,6 +402,16 @@ static int pfuze100_regulator_mode(struct udevice *dev, int op, int *opmode)
 				       desc->vsel_reg + PFUZE100_MODE_OFFSET,
 				       SW_MODE_MASK,
 				       *opmode << SW_MODE_SHIFT);
+		if (val)
+			return val;
+
+		if (desc->b) {
+			desc = desc->b;
+			val = pmic_clrsetbits(dev->parent,
+					       desc->vsel_reg + PFUZE100_MODE_OFFSET,
+					       SW_MODE_MASK,
+					       *opmode << SW_MODE_SHIFT);
+		}
 
 	} else if (desc->type == REGULATOR_TYPE_LDO) {
 		val = pmic_clrsetbits(dev->parent, desc->vsel_reg,
@@ -458,7 +490,7 @@ static int pfuze100_regulator_enable(struct udevice *dev, int op, bool *enable)
 
 static int pfuze100_regulator_val(struct udevice *dev, int op, int *uV)
 {
-	int i;
+	int i, ret;
 	int val, min_uV, uV_step;
 	struct pfuze100_regulator_plat *plat = dev_get_plat(dev);
 	struct pfuze100_regulator_desc *desc = plat->desc;
@@ -526,9 +558,18 @@ static int pfuze100_regulator_val(struct udevice *dev, int op, int *uV)
 			uV_step = desc->uV_step;
 		}
 
-		return pmic_clrsetbits(dev->parent, desc->vsel_reg,
-				       desc->vsel_mask,
-				       (*uV - min_uV) / uV_step);
+		ret = pmic_clrsetbits(dev->parent, desc->vsel_reg,
+				      desc->vsel_mask, (*uV - min_uV) / uV_step);
+		if (ret)
+			return ret;
+
+		if (desc->b) {
+			desc = desc->b;
+			ret = pmic_clrsetbits(dev->parent, desc->vsel_reg,
+					      desc->vsel_mask, (*uV - min_uV) / uV_step);
+			if (ret)
+				return ret;
+		}
 	}
 
 	return 0;

-- 
2.51.0

