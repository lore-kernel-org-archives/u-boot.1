Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CAF5CA0EE4
	for <u-boot@archiver.kernel.org>; Fri, 15 Aug 2025 11:11:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 131DD83AAE;
	Fri, 15 Aug 2025 13:11:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="GmOJvfIg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC91083AB5; Fri, 15 Aug 2025 13:11:06 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20723.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::723])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D469683AB7
 for <u-boot@lists.denx.de>; Fri, 15 Aug 2025 13:11:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B5Wyi3MuusnaKlBNK+LecURjlgHjXUwBhUAhXQazdnGGNwTxw4JgwSnIofu73IhQ0Uy3CNV/vSmJJqf6lMrr4+wpBslstFbTi6crF4dviDYWXWzswBWXkrf+k1bunlOWXfc8MY7rgbki7h2Zz5ox44LpP4Nk5keRxSX0E2LDT1P0n4CKrM7aL+UCXx3q+z6sjKRaPqxJuNi+Icp8/TAuCqfxYgjxCE6kbmD94YKBpCBtmg2RbbIl9rCGQqPNoYvOZLY6cN8YkdounaTd9M/d8r/+ZhhUZSGTMY83Np4NbJklRbsJ4/4dn8SVk+Gdr2y+RQ4h/nUI4vSuleYl6+/fug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/UO92/XtNlx6k5MgdYOGQzUoe91oNzz7GQORrwCYLgo=;
 b=lj8kZACJn7rBxinmGpdevQ3hdaCj5Q77t5AVeWICkOXtloXRRA7cHGkzOGyGx4tO1MzDKVTpyG5YirnSVxAIKSdq80wJZyaype8FhTKqwJiyq6ISWerMjxihxEWiw6y4Oy3bbnVKJttVpYQ4D0Sa702z6suwdDqWPrIciQJ11cYNRMIkEuIPqC7ydvV+AOKr9NUW4yAxR7MAO9VpxtvP7RQKPEngB1CbKolOommMJM748uuitSxqo0LR0tFnz5IDxy6S4a+1vWl0abWd26yf2m1NR5WFAf0Xx3VtM0HsNEtG0115xsJ8+kSVwY9g7FuXTh5igWhvicz7FgYpBc9zyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UO92/XtNlx6k5MgdYOGQzUoe91oNzz7GQORrwCYLgo=;
 b=GmOJvfIgSl11FMz1JG+n1MHt9l3gwaZswkDoT9rJg/HhGuHoAbWaF3Bd+LNZK+mBKD+9PYa97EQndHDLrjN/l9RFz695LTPxifNBeVRBEB1vQaphtouIiAtjKzwKESh6SLoprTAsRdj01iguNVY4yMg3nVwQNgS6O0QIW/D8qd0dOCajLW36VJA5ouT1HbsI6nZ0b89k3kHXqJ0EdqQ2uOmxHMRvkxx0aRxG6XRvmX34uMM5CIHZXVH7WTKTU0AW6F5kj/be4pLv+BhpPh9yH8e+8io9uW5l72IVnu7iS2DlkP7ZyEi4xCME6ghTUHKcRsBRaxvRldeU3wSpEv/R+A==
Received: from AM0PR02CA0187.eurprd02.prod.outlook.com (2603:10a6:20b:28e::24)
 by PA1PPF6917FB770.EURP195.PROD.OUTLOOK.COM (2603:10a6:108:1::1d2)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 11:11:01 +0000
Received: from AMS0EPF0000019A.eurprd05.prod.outlook.com
 (2603:10a6:20b:28e:cafe::91) by AM0PR02CA0187.outlook.office365.com
 (2603:10a6:20b:28e::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Fri,
 15 Aug 2025 11:11:01 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF0000019A.mail.protection.outlook.com (10.167.16.246) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 11:11:01 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Fri, 15 Aug
 2025 13:10:59 +0200
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Fri, 15 Aug
 2025 13:10:59 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <d.schultz@phytec.de>, <ggiordano@phytec.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH 4/4] configs: phycore_am62ax_a53_defconfig: Resync after
 savedefconfig
Date: Fri, 15 Aug 2025 13:10:51 +0200
Message-ID: <20250815111051.2277173-5-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250815111051.2277173-1-w.egorov@phytec.de>
References: <20250815111051.2277173-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019A:EE_|PA1PPF6917FB770:EE_
X-MS-Office365-Filtering-Correlation-Id: b947104d-1da9-44fc-2b97-08dddbec6b24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tJeAyJwFgMG/S00/dF+GIRk7yz+/c2h6Mn90RSToOdS2aLWxqZepr+1dQhL5?=
 =?us-ascii?Q?OG/OuWwH+eDkeWS7ff+NmXX4vNgsNKJgApPe+7iQvNdVUs3HuLDmawv9FmN1?=
 =?us-ascii?Q?lk5ZxXux/6CGgPTQycu1h4UOlexV5tHPCWjtqaN9l2SVbZdpQhROR7C331R/?=
 =?us-ascii?Q?/FV3isXaP7Qqbp3PRSpzILzmsCyR/+YPDjeLo7C508h8lZL0tAz3gYK6xbS2?=
 =?us-ascii?Q?6SStfQlCB0ReYhBPFtxBPzCNIwgJ+/T4BHmq2yuYMQYWdKAfLKdC0HbuCn+S?=
 =?us-ascii?Q?RD8a28MzrCKykiwYNUPvwmhmN5w5BOymc0G1rEa6xcUUv20UsuP05S4e9W2y?=
 =?us-ascii?Q?stbcoowwPZrT3chm0eo6U9GpoD0zAPcdF42eYBuqS6fJZNuMSJI4jDoVTcr0?=
 =?us-ascii?Q?LhtkNc4cnW1RXAQSPv/4VIjEW7wYNBwyyZkkaScTDhXApJ8QUwMj677aWZjW?=
 =?us-ascii?Q?uMr70ZhYtP32mfNdmIu8d+DhmSx2Kef9bnfm4n5KwaCG/bChtuwFZCEJ3bbm?=
 =?us-ascii?Q?10oPfSVO/w9CNqe5P7hGHSbxRhtHaCPfi85MzivrYpAID55wWqjRSHtVXLvw?=
 =?us-ascii?Q?ko9+o6a2JGt7c46mmqdAuXqwEy9+LyF4FUwf7RX1o/v4VQiZcy2IvYgoKDc3?=
 =?us-ascii?Q?8bDyq3QzXaLYmg0dILiFtNFjS9fER8dQkmpRCiCvwqHVqjMQLhU0ooam4ef0?=
 =?us-ascii?Q?zFgtmFZAuFID0Vrb9yLOzO3wlnwLMZxypAQsoxVjibjfYKs/SC8O3iPeLLAC?=
 =?us-ascii?Q?2LDFSGx4mvYVOQQfRigwoLvPQrnh5V7k55p80f0Rzv2HJEydPVQH7768hgZF?=
 =?us-ascii?Q?UdC9bhO8zd+tcBTbl6OKVSMZ7/XzQeSfD30JcDHSJSaMCv48Csb0MOJhluqm?=
 =?us-ascii?Q?yrgIK2yCzquTHpetAXnGQhx//5A8mbZTUqcSA7suUqS5Fv9dgtYN6/4mzMBA?=
 =?us-ascii?Q?CiXZpQRZlyhDRuB/5CMQWthIfx6azQWHh2v8TIhzjRnN1IkQ+EeSUwV/EqYc?=
 =?us-ascii?Q?/RQAsih2ZNnwUH/xbbCBuVKYN3/3jElFW0Gu0IkXQ776jSTWUxy0N9qYEZzL?=
 =?us-ascii?Q?Zu9tqBx+g2Y825U3NIz6rSetUUvIuJcXVDpcI8ifmvsjdgfr63JngzVUasDY?=
 =?us-ascii?Q?E5XkK6fcQMIKkgCrRzCMNpxkNwOJyxX1vg3d1JLyV3GpQJhFCkt/5uwwhvA3?=
 =?us-ascii?Q?8PnehENz9JaUv7lDCGJft47VToZF2fRO1qCV0+nYRK2cesn/BDpwTl/umljM?=
 =?us-ascii?Q?+2b/mQ/+GrYP/QX3crWWu3tjJOLaAxgQM94kGtAUP7/FjskEpDUas04J58Lg?=
 =?us-ascii?Q?5PA9CyZ+klT3YOZok1nf+RmEchKNyWP56z3v1KSVgzNtbLqiXJt1ZgrKgCFB?=
 =?us-ascii?Q?ravMsIl21V4XRtMAihf8PBIc8GrBqwXGV+NVUm7eipKoNKXxYqIvuBXWE2zn?=
 =?us-ascii?Q?f/tVxFvIjWELPKMwslW1ioVjoo0Atfk7QwBzU9dMl0ZRiH9k76DxJ2c275Qc?=
 =?us-ascii?Q?xGO/MlmuNzzYNYthKqkN+O5jNajWhzHGvLfp?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 11:11:01.2306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b947104d-1da9-44fc-2b97-08dddbec6b24
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019A.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PPF6917FB770
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

Remove PHYTEC_SOM_DETECTION_BLOCKS after it was enabled per default
for this platform.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 configs/phycore_am62ax_a53_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/phycore_am62ax_a53_defconfig b/configs/phycore_am62ax_a53_defconfig
index 05849d05be4..4ec7fa77865 100644
--- a/configs/phycore_am62ax_a53_defconfig
+++ b/configs/phycore_am62ax_a53_defconfig
@@ -6,7 +6,6 @@ CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_SOC_K3_AM62A7=y
 CONFIG_PHYTEC_SOM_DETECTION=y
-CONFIG_PHYTEC_SOM_DETECTION_BLOCKS=y
 CONFIG_TARGET_PHYCORE_AM62AX_A53=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80480000
-- 
2.48.1

