Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1A0D29DC9
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 05:36:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21539836A3;
	Tue, 13 Jan 2026 06:35:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="ecTUdxTc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CD0383935; Tue, 13 Jan 2026 06:35:48 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D9E583693
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 06:35:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+EG+mJg/Cz6cHwYq+l/4VEXmmM+yoFAVWV7FjR+H9+z1ydHKALgFdYQkZ7X5Jk8HNw2EvWYiNHNI3Tth/+tPa41JEg40AwC6wyz1jxwCPHW5uzajUMEQH/YXXJ1qg6IzXut0+rB38GXcOxXIY0IGA8keCyRaJAJwLjMfu2EEGIXlvNxwTy0VsWw6YlteoYCv/gDj2khIULptBPN0K+Zzv/3/XpD4jrv2wRdLJJ3K04vych1FiUC4hb9OpXNduPl3GKyb72YhOlt+Mh83gvhXVDNNQ6odUyEv2k9vmR/18Ya+k8vLpCbX1skciKUnYIbvx7ujsPy2YcPJmAbBBYFuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEaJKizChjrIBm7zpMls9QQXSouXtnyKjKSdFpFChIU=;
 b=cFDVXLBr8qYmp+ZDfN5CH4XW0rJr7sD8On7ONVfQwK+0DSBfHhJjHeGtgSHeqi2wjLkO953p7j1KM6ar8wCypSdwURsqlURe/CzUNiCiX/cUpA+2CXQrv/ZIDybQjCYoRO/R2NwvVUunHSzfzUptb0T968YGpVemAXNZLZdpgu/qEWCrpuzyfrqfDoS1LKYAq3skPnA/CJ1I54ecrlpL51E4mMokjfR2LwClB+ntZw52xGyd15ps7Eicd7QjNmmpwq4EXNRqIoahJW1PjGSkoJ8TauPoxzND4SR5Y3T+AbV9ZvLo5CEOJQSk7IqFKPgPJ3MQRYyzzUh+wQe5gA36VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEaJKizChjrIBm7zpMls9QQXSouXtnyKjKSdFpFChIU=;
 b=ecTUdxTc4HP/Fm+PNCTTpallagZuuNd1d4r/eTtQ1tm1hBEUBgVJqsWd/dRRxKtbJIYb5EWWLyBMsaOkSW0KPnpUfK3DhpBvl6IxG5x+5TN+P0RPVBp/CXprG/CX8tmkphHVldoG3cuzNr1lXcQ4OAMB+cxRKh6af2zSXQgpjfWErzJtq/ItHm2N2Kcg5JCxODaaoGkDhSUjTnZLo9/9J0d0GF4CBiH3xZek6vBgTvVuNw3NFehUtDgjPMij+dn/fgRsua1/hzmfma4Y0OoEBbE06FbhzHb3uq1QQ5AUGy0XthhZHqRKn0/RLZ6zACePXFq36pFtDtuKX5BUjMnUOQ==
Received: from DB3PR08CA0008.eurprd08.prod.outlook.com (2603:10a6:8::21) by
 DBAP195MB1099.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:1ca::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.7; Tue, 13 Jan 2026 05:35:39 +0000
Received: from DB1PEPF000509FB.eurprd03.prod.outlook.com
 (2603:10a6:8:0:cafe::18) by DB3PR08CA0008.outlook.office365.com
 (2603:10a6:8::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Tue,
 13 Jan 2026 05:35:43 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 DB1PEPF000509FB.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 05:35:39 +0000
Received: from phytec.de (172.25.0.51) by Postix.phytec.de (172.25.0.11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 13 Jan
 2026 06:35:38 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <ggiordano@phytec.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH 1/3] configs: phycore_am6xx_a53_defconfig: Enable CMD_DDR4
Date: Tue, 13 Jan 2026 06:35:29 +0100
Message-ID: <20260113053531.1204984-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FB:EE_|DBAP195MB1099:EE_
X-MS-Office365-Filtering-Correlation-Id: dd5de920-c44a-476e-b736-08de526595d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TwtVV0xyRfINkHkupoTFJNpBVwyouBx341YBGU7VXJ4JtqxqrdE0/HS2f6zn?=
 =?us-ascii?Q?eauThUryC4SiCtQ6mO6Vm2Q66Dhpdmygb7KFE8qU67tBmq8BdZMs/h6+6k0H?=
 =?us-ascii?Q?bE40yphoBEDLH3s2AeCBxNrHgxvU/7oYAZGWcYSdggl/T8ABi6/ngLMyP5Cn?=
 =?us-ascii?Q?ubqzjjPeNw2hHqfxnX5NWWBeJjfKCenumkEJNbpfhCOmSfHtBAsnyF0iIHhp?=
 =?us-ascii?Q?MbXzMEkILVh4Eo+x07+p1nMG19y6GXWXNl6kZ/9yokV64RDg0yQDuScSkuvJ?=
 =?us-ascii?Q?CO44MyMKkLjXhI0/csCcuWz51wN3auEsZfalETH2AzNdBMGM/c9twT0swW7h?=
 =?us-ascii?Q?JzrbzqoDZKDHeaJgQBwJWKu/S9d9zmyTzfZRavpYdg3iW55kDVDZXuSmeTpO?=
 =?us-ascii?Q?2fJ0Yw6FCqB1SM4EYp27KW8SKloP7xp2J8gxUwlvISTFeH9U7LeJxJ1OArix?=
 =?us-ascii?Q?Ui9o0xRnO1eJIN5xKf4QAXe62X59rmf76hJW357yZ8UhbUglNDUR6cYOjm1v?=
 =?us-ascii?Q?uyh1PMBemVUmOFB0dCm5u/6NqAWQoSrm1T3g6St8V+XQh0wppCNPGwKqWc5P?=
 =?us-ascii?Q?jgvHvT9lQ+UrvwhM47u259ZI9ihqwU2bHNbEAroNIAKrjkJvvYq93b62yBXm?=
 =?us-ascii?Q?X3Mu9HcJInn5vEmzUXnG/j10uqYZzBYqBXpZBKjvBVVGG1GI0o93cwW6zSYO?=
 =?us-ascii?Q?h23HGvbM5n3Vcn0zSZ3mRllP6nFt0AjHWugqab1Ia+Sxu3zTNsT40sdFEnv+?=
 =?us-ascii?Q?yQKMUuUJg/k4JBII7i6T/WXV5DWCYX296YQ3KsXQ6KYLrJXqKndaNjkVYzr2?=
 =?us-ascii?Q?BFGyVNFoBkJ96CO4bqDk4qjMLe0UCOEA1romSxrMAzRqoNH57KgmiJJXJ+4g?=
 =?us-ascii?Q?hxNdtRFp3pQ5Dd91/H0cMkFZWoPJcHVxDhLMaB9A9S+iVRw/F+9GFHlL/Do/?=
 =?us-ascii?Q?nyTb2tAnMQFgQLSiGxr0kFXx+R84TRzNvR+nfwLDycN+UVP9Zh/9uPYB7qjV?=
 =?us-ascii?Q?q8QL0FOGP9vLi7cOLbx5HtgvY/r+MoL3ypNbFHDmwcHGNCSigirz0J8iuYXu?=
 =?us-ascii?Q?/vD5NRNZ/K+NAmj5ka3i2/qaSXNqeYBz18E0pdd7qj+QUDJJyJ7D5oaLdGec?=
 =?us-ascii?Q?g3Xp4fROPLyskX7ZPO6yyLXmfx/COVvbSAL2JWT/LVVW/zL/Ku49feBsFzaB?=
 =?us-ascii?Q?BX5/VIM3no//w/jW1G+1x/IHuZOLqX3+PKD/NJSmRh6N+NNYF84WI1BXenA4?=
 =?us-ascii?Q?+VHSKkh7qyLkEyD+H40t5sGn1fi8baKqKfOlX6udNTmDNs6eif+WccwB4O6N?=
 =?us-ascii?Q?x4Zdnhn9+Kuf0AcCNW4dCnD3o4BWXsf308gjWCgt6KZPQpbNjry9Ryl81h8N?=
 =?us-ascii?Q?J1+q+LRPe2ecM2Fi2PRt/g7Ojmmp6LaRjgwrqBXTWc8ZWPo7j+jVRgK96AB5?=
 =?us-ascii?Q?OEBwwpoYuXB/dx8nBubGMhHcyFqzSHc7lW6qepasmSwmJh6wTklLJhGh+Dm6?=
 =?us-ascii?Q?DWVXWnTnW1ko6ucYYXyOMy3MUO1xzgM4qLs4AS/V+wWppNbqke3gIsyG+ZHw?=
 =?us-ascii?Q?ZOXgscAp+L/A6rkE/Y0=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 05:35:39.1170 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd5de920-c44a-476e-b736-08de526595d1
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509FB.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP195MB1099
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

Enable command for verifying DDRSS inline ECC features.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 configs/phycore_am62ax_a53_defconfig | 1 +
 configs/phycore_am62x_a53_defconfig  | 1 +
 configs/phycore_am64x_a53_defconfig  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/configs/phycore_am62ax_a53_defconfig b/configs/phycore_am62ax_a53_defconfig
index ab50545d307..a0423b80721 100644
--- a/configs/phycore_am62ax_a53_defconfig
+++ b/configs/phycore_am62ax_a53_defconfig
@@ -78,6 +78,7 @@ CONFIG_CMD_WDT=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_RTC=y
+CONFIG_CMD_DDR4=y
 CONFIG_CMD_SMC=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
diff --git a/configs/phycore_am62x_a53_defconfig b/configs/phycore_am62x_a53_defconfig
index fa5c4466791..afed0bfafc6 100644
--- a/configs/phycore_am62x_a53_defconfig
+++ b/configs/phycore_am62x_a53_defconfig
@@ -80,6 +80,7 @@ CONFIG_CMD_WDT=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_RTC=y
+CONFIG_CMD_DDR4=y
 CONFIG_CMD_SMC=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
diff --git a/configs/phycore_am64x_a53_defconfig b/configs/phycore_am64x_a53_defconfig
index fcf61590c60..d0b33661cf6 100644
--- a/configs/phycore_am64x_a53_defconfig
+++ b/configs/phycore_am64x_a53_defconfig
@@ -80,6 +80,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_RTC=y
 CONFIG_CMD_TIME=y
+CONFIG_CMD_DDR4=y
 CONFIG_CMD_SMC=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
-- 
2.48.1

