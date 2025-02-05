Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 875B9C02194
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 08:02:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1BDA807E0;
	Wed,  5 Feb 2025 09:02:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="AsGb0NNK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A60280207; Wed,  5 Feb 2025 09:02:23 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20707.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::707])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88BBA806FE
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 09:02:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ofoW19ExDzJ/9jrDjXn2vyPDt+pn4wG7fNv/0LFPHFCAgPu709CvpmJzhs0boQPnLfPk1TwzQnzwRwALBfhw4wLNzYpI3qpuSLVNr3M/9amijpYuo2wr1kCI5eJB/zV9Qu92sQD9VSr8WL4D+SbXC9qThR7jTLsnb/PC2D+n6w4QiJZlR32mHP8rv2pZYnQNUj/cEyH8CF7GiD+tAlEKy0IADW/9+VT/K/zyjcMX/hanpg0AMhXTgH69C0sDKZ3Cr8Ox3KD531+h/v2t8K/mopG6Ju+eWLQj2evWIKe4Ln5ftnDTFSoYIUSy7wCDnX7QA0qGFAOmN2vwMN82J29yGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hl7VmF8LHP+/Vv2p7F4pGHovqKAkxQukkAx8XMBLqLE=;
 b=azMe+25u9J4r8Et0p+z8Ej+QaJH1eoNb+B2iuTWLmryFOR+Xu8GMRxO/qrwg9bflQleDDgjt4/RAE/0qmie3xl8uJsoMvwaJEEOUXlCJGkZDGAF/55Eu0OQLiWGLDnVMp4OGo3HMh0sTL0hc9E5ModKf/BMwuHphj9BHAx7UeVbG9Zbj8nCoYhqHbKnfDpRGpQGOvpWHl7fXDmTtXH8If1GXpsSKVL+9SFl6HXP3QuegnGr0NSqqmsmG7jymtsYZYhBJhvfwEpfai/72Zwyn6rhQDOCQDZmu4RvEqRO284Wm+LIpqovKxJh6lqP2k5AGJwY7k7hG05fMmm4IlO/4yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hl7VmF8LHP+/Vv2p7F4pGHovqKAkxQukkAx8XMBLqLE=;
 b=AsGb0NNKzssz0aMj1mA4ncNqk9sWM8Ne+DMZsSC356IQn6VWMDeL9f0VJMrsVW9vT/fRUCVB3okhftC9IlZDAyTi7ks5VKRVPgC0jZTXpj1KJWwH6i4lb2b7T8aQUBis68nt/fdr7Puu8S8I35HKDid1tb05saFgtba8UzdYq+zc8Z2hREzGRwiS/Zu40sx7j96JkIZMrLWYy2CFxagzfCTwZySW15RPI2q2shNnZpuMn84tvYtBhLvgq4jBmyRyr5Wv5nGBZmiQECRfMzDwouHiDv4sqWEE/Po6SbHk5+kCf1TqbxBeC1HLY56F6GrIydTIEeJgv/E0b9MqtwUa/w==
Received: from AM5PR1001CA0067.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:15::44) by AM9P195MB1137.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:3af::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Wed, 5 Feb
 2025 08:02:20 +0000
Received: from AM3PEPF0000A797.eurprd04.prod.outlook.com
 (2603:10a6:206:15:cafe::31) by AM5PR1001CA0067.outlook.office365.com
 (2603:10a6:206:15::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Wed,
 5 Feb 2025 08:02:20 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM3PEPF0000A797.mail.protection.outlook.com (10.167.16.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 08:02:20 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Feb
 2025 09:02:20 +0100
Received: from ls-radium.phytec (172.25.39.17) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Feb
 2025 09:02:17 +0100
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <ggiordano@phytec.com>,
 <joe.hershberger@ni.com>, <u-boot@lists.denx.de>
CC: <nm@ti.com>, <d-gole@ti.com>, <n-francis@ti.com>, <nmorrisson@phytec.com>, 
 <m.otto@phytec.de>, <bb@ti.com>, <upstream@lists.phytec.de>, Daniel Schultz
 <d.schultz@phytec.de>
Subject: [PATCH 04/10] board: Phytec: phycore_am6*: Add k3 Kconfig to A53
Date: Wed, 5 Feb 2025 00:01:40 -0800
Message-ID: <20250205080146.1944928-5-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250205080146.1944928-1-d.schultz@phytec.de>
References: <20250205080146.1944928-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A797:EE_|AM9P195MB1137:EE_
X-MS-Office365-Filtering-Correlation-Id: 87caabf8-52a6-4fe4-0a28-08dd45bb6a90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UZauZrbDePcjUp2YJvaWEwt48oOzkFF2IwtWYf3tV0LQq24MH4t0MbLYITzK?=
 =?us-ascii?Q?8/VoVXcn+9zn4lnTSjaYf+Dhl2A93M0sRs/vw4utx8LGPzHOE/USMkg0Bmx9?=
 =?us-ascii?Q?pE7j92tzlOap0gxcQDq8vBnATVHwZFcGKifIAvUYfD5wAbjT8VWJ1BBV8LJF?=
 =?us-ascii?Q?LzmIC1znGCi7DgSELc+9eVVYFw2SVLPu3lcW8QFEbwNBSMRh7AlMbdshsaqG?=
 =?us-ascii?Q?MOdXdvtwa2uG7QjOJuBCLcQr/zWxj20pp/Wuc5hQllqCfCbdlbVenJxakhTG?=
 =?us-ascii?Q?PBtckEg/rxSZYRwGO6jLUL4+X3VmpxTQR0IBko1bo2kmfcel03cHbtVo4lcv?=
 =?us-ascii?Q?325FN3PZrNBi87kV7eB0jsdVQbShc2K2IlVzPGM2NXxr0iPD1Qte2rDI8xxp?=
 =?us-ascii?Q?ydYggsBd2PrOipOLUusM3IYUgLd4Ndt8c/79+OLIkiEl7Rki5lmYrqGrESP+?=
 =?us-ascii?Q?9tch1yPmZX7XBV/08e4VeknwzphdpEplIjq/jn+pAKMgpc8Je5Dnpe0l2m2Z?=
 =?us-ascii?Q?ajQObIfQyMxmFNZ2XbVOP9CnhuMTxHWajs3Ou/SOW1LkQmXgQP2Q2jBDt4WE?=
 =?us-ascii?Q?R8S9Td/w7Ah5yi45MSeGChNL/4CcQ6SYsxTMtptpWyenmXmsJsMx9G0D50YD?=
 =?us-ascii?Q?TwK1r6JiVLrkWlGwO/XLz0JAIyYxc3G2wtKpj2XK17DPhRcG98rW8em21iCq?=
 =?us-ascii?Q?R00JCyAfM8Cm1bOz3/zRKQp24zDC7Leqv+CiSkc4uk3SBey1xgzW+aVtVcxJ?=
 =?us-ascii?Q?CLo+DMt4fhWuMYfdzOT/l6XKTBwbpED8luc1DCLKZMvFjy6U2rylpX4wivfW?=
 =?us-ascii?Q?qtYmkQodcFbP9OXDtVsfoNMg1umKyVaWMRLTDT56yNAUEQGC/XvdVjO9hwCb?=
 =?us-ascii?Q?OPT1q+mVecp2rSP2cniPslTU4y1K/fhd0Sh51OxZtja+u2TadhY8fw1pMkuB?=
 =?us-ascii?Q?O1F5NJj6vFsLbE0V77fZcUM0CNOgnkGYK1jORLM6QGBMRShs+VpUeVEeOWiH?=
 =?us-ascii?Q?o5HabZaH0JV2FSzdVQ+UYnDJc+0xcfn/2ym85NCV8GdVlG+DM0g0b879B7CE?=
 =?us-ascii?Q?RObbm9ibFwPBigRf76so5EVR15uuUgnEa4N3GH3RDo0VhaPVAJ/GCd0Is6xU?=
 =?us-ascii?Q?S5xww0xjBBSFpJYGF6lbW4BXc68IhRmLUfUO2hwLCaSyXyfLDh03I+7DeK0n?=
 =?us-ascii?Q?FtOOVDa1VwX6Ufo6bnfHm/bYKp7UEpMdwgGj8N11d8iYh6Y8II2rqm35fEW8?=
 =?us-ascii?Q?gxMkGbSSfdoHh26ZBWbA3ks9GHQd1+7l9WKoHXFYpnxF/QrKElL9ahaeqUsl?=
 =?us-ascii?Q?+LjjNevZ0JzVgtH8QBffjQQcGN0DvkA1Q6fyktaoQWaYS228P+Yb25+2BM+W?=
 =?us-ascii?Q?eMT0k/j3RHJHT9yiQlUuVRA6gTKdZDCKVLqGPj6mWGxfELF6wmEAt+dCGoMO?=
 =?us-ascii?Q?vEyqhyG3wHC0HdDP20KlVztV+sI85+VPZQYvSC877f9GPshh1zzPMDpuDPgU?=
 =?us-ascii?Q?QFPuYIxkJZQItzY=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 08:02:20.5191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87caabf8-52a6-4fe4-0a28-08dd45bb6a90
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P195MB1137
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

Add board/phytec/common/k3/Kconfig to the A53 builds to make
the PHYTEC_K3_EMBED_RAUC configuration visible for this defconfig.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 board/phytec/phycore_am62ax/Kconfig | 1 +
 board/phytec/phycore_am62x/Kconfig  | 1 +
 board/phytec/phycore_am64x/Kconfig  | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/board/phytec/phycore_am62ax/Kconfig b/board/phytec/phycore_am62ax/Kconfig
index 516dc8e2020..81f2311ec97 100644
--- a/board/phytec/phycore_am62ax/Kconfig
+++ b/board/phytec/phycore_am62ax/Kconfig
@@ -15,6 +15,7 @@ config SYS_CONFIG_NAME
        default "phycore_am62ax"
 
 source "board/phytec/common/Kconfig"
+source "board/phytec/common/k3/Kconfig"
 
 endif
 
diff --git a/board/phytec/phycore_am62x/Kconfig b/board/phytec/phycore_am62x/Kconfig
index ecee5873c0c..6c2eb82787e 100644
--- a/board/phytec/phycore_am62x/Kconfig
+++ b/board/phytec/phycore_am62x/Kconfig
@@ -15,6 +15,7 @@ config SYS_CONFIG_NAME
        default "phycore_am62x"
 
 source "board/phytec/common/Kconfig"
+source "board/phytec/common/k3/Kconfig"
 
 endif
 
diff --git a/board/phytec/phycore_am64x/Kconfig b/board/phytec/phycore_am64x/Kconfig
index 829526c3295..ddfb4a39989 100644
--- a/board/phytec/phycore_am64x/Kconfig
+++ b/board/phytec/phycore_am64x/Kconfig
@@ -18,6 +18,7 @@ config SYS_CONFIG_NAME
        default "phycore_am64x"
 
 source "board/phytec/common/Kconfig"
+source "board/phytec/common/k3/Kconfig"
 
 endif
 
@@ -33,5 +34,6 @@ config SYS_CONFIG_NAME
        default "phycore_am64x"
 
 source "board/phytec/common/Kconfig"
+source "board/phytec/common/k3/Kconfig"
 
 endif
-- 
2.25.1

