Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 903C3C53200
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 09:16:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84EB883EF9;
	Fri, 20 Feb 2026 10:15:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="r0EjEpQ5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90A2283F14; Fri, 20 Feb 2026 10:15:43 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 608A883E7F
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 10:15:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fhvz4fvSxx8Qko+F/axSlTKACsayJ/Q64GiGZLQyoyRiBYkIBZNKi4aUs8YOlBbtC+HpAlXsP74/XQlwhM/AUXpg4QKWMjvttJz0Gx/x6yD5cB6CDZ2EvVcwBDvozzo05QPQNAbazqAHutR9YATVpC16I8F5S+hY/y/eXtbBj5W7TEiPAfWZ0ehYDY9ezSF7sDHND/0xlzu4QxW6SGx98jRAA8CbNjSrd+TTAt4qt8zvWhhae76jYok3JwjEWc2ZjaMz6yifRGlnDhbXAz9vtQQ08j1bsmUs84riXIPEyhWoBvFl/ePxwaPFQJjrnguLcdORjNqdVXa34SlOWMbd4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RIwo0g76p9idcQiLiMnL5jzSICQk9G5GUcfE2/D9sZY=;
 b=Ps1/64fVKCpizJnAC6qpvGLL510PXtwwTvkw4DoJqCVuHAY8uTiI49oGkuy9O4npZv5/JBjOL/+X1x4bGVE+O7mbLL2OycoDuK8IRod6WA/lpO+YEVDwXr6jSVFrrWTjavzTeBjYdHPnJbmkPiDJZa6o0ISmBy3uDFLMRqqOzz5sUm6iWILDNAJF87sh1kImeHkR4cztDVt8tvr7HACR/zl+Owa9gVBk/HMqcgZi1BTgAjv09Gckmhm+r8MF5vFvAVKXDJmqo8GlXcEgcN+UJfuxw3usejL4pPI+QHIryRtn3U2M0eSS1cPWjgXkG2rGC2gOQ4705MCY0A5ujZP/jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIwo0g76p9idcQiLiMnL5jzSICQk9G5GUcfE2/D9sZY=;
 b=r0EjEpQ5lnL9PRQFri0iaKsJfos6gPwDZUrAIma5DZBNxGhDeG40V4fOjiVxjYujAaIoxnkUqenPYIZmwMKUZQaXrkX6JHvVopEUfG1B1pnqRWAeAwOCPpeg3D9MhV3ywZOeujJfV959sG+KSyYdppKM35Rr9/dLNpDI1FrMQII=
Received: from SN6PR16CA0056.namprd16.prod.outlook.com (2603:10b6:805:ca::33)
 by DS0PR10MB8007.namprd10.prod.outlook.com (2603:10b6:8:203::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 09:15:37 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:805:ca:cafe::4e) by SN6PR16CA0056.outlook.office365.com
 (2603:10b6:805:ca::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Fri,
 20 Feb 2026 09:15:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Fri, 20 Feb 2026 09:15:37 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Feb
 2026 03:15:36 -0600
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Feb
 2026 03:15:36 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 20 Feb 2026 03:15:36 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61K9FXgx3622993;
 Fri, 20 Feb 2026 03:15:34 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>
CC: <bb@ti.com>, <reatmon@ti.com>, <u-boot@lists.denx.de>, <u-kumar1@ti.com>, 
 <gehariprasath@ti.com>, <s-k6@ti.com>, <n-francis@ti.com>
Subject: [PATCH] configs: k3_*: Add config fragments for inline ECC and BIST
Date: Fri, 20 Feb 2026 14:45:32 +0530
Message-ID: <20260220091532.3584771-1-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|DS0PR10MB8007:EE_
X-MS-Office365-Filtering-Correlation-Id: a044a00a-cfdf-4ad1-6418-08de70609c30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+AJlpnaSDBBbwRmY10SXM4DcRynRvMRb/ssftm1blMnyxyxe/dSMmf0nvEBt?=
 =?us-ascii?Q?4fdADqQ/Z0gSMdx+UAzEN+Z/5RF08bSfFdg1RENH5VHFdKL+Vt3bz3GSXFoj?=
 =?us-ascii?Q?AIhINfSpvuiv0rVKjdZRg+bWL+16C9u0eCEohvC0bU0G+EIiM4gQS82XPheH?=
 =?us-ascii?Q?/8mByPwc5sew8HTQAuVFssDSzDiR3rUWtDRgJapcP96sLMhIQIUMpN7u+IT5?=
 =?us-ascii?Q?LqSqYEdn2CyxBeFX8wS/eaqrSP6gYO5NH8DBIi61hR/+ypyWJ8r0zkz1/z4p?=
 =?us-ascii?Q?b4JtvIIuQqE8y61uf9efOu+GCho6JcYPBuYUsB/M+6L5u3ZV/7XCTxzAjCc9?=
 =?us-ascii?Q?F+NrxXR+1RmndcfwriPzqgzZY9nT1K8A0nERS9fCMzFATnyFQz12Xaia+bUt?=
 =?us-ascii?Q?uKQeNlDk81a49G1nCaTntb7DBBx+mTBKVnUy5zAatlMkGGzTrNr/kpSV6FQs?=
 =?us-ascii?Q?auNufFk4/wTUeGlDhTe4iGE+NDsXP15uD8QqYP+sbYTGiBhycWVWHqNT2Wl6?=
 =?us-ascii?Q?veyk59lzwH5qDes6Zc8fq55+XZQe5JeiNZ4EaNK4CPNvxAD+lvPXY+HwcrI3?=
 =?us-ascii?Q?kQ0QIaNqFLoxfpmfaeK/kBR1t3lwrS5o3z2nLKUXOCDzoirBjQyMCrVmhi/l?=
 =?us-ascii?Q?6/N8QMrZ+YUUUKlbZrZ1/iRXprgTtmS15A0RMKiS11siV8Th9px8omuoeqPm?=
 =?us-ascii?Q?Z8t2SDrByjvzBww28XqEvdpgaRXAgZvJ90nj76tKdgI8cASCw9MWGBWIi4Eg?=
 =?us-ascii?Q?lf2eourtu4C5HLnTF9m5M3hYUN51JcjSYe7yhzw4s7kseXDIXIE8oCggNxKF?=
 =?us-ascii?Q?RGaiCLbN+UfBgXTRk6REC6c/HIQfAfJLV17P0Hh+Mpi/Ij3zdRr+Ls9Ht7Oc?=
 =?us-ascii?Q?FsAN0lR880rhYOL8PzukEqXSCeabGzvugLJqKjpeyitY7uguBewGsee++kj7?=
 =?us-ascii?Q?AkmzYYm04FUQfxsWetMts5TxqIBj7xxKdXRO7EUm75Mgi4MT8x6qAa9pbwrI?=
 =?us-ascii?Q?0sjizM/gzR2Pe9eEpVM74KUJFQeOczTyK6F03dDoo9j6BqoqVyMGF4Nj5+uI?=
 =?us-ascii?Q?Zyy/aOmsmR9FSZyvsL3C4QsbnSS4ZgI6vsUarGXcsIebZHdTn/syxo72Aun7?=
 =?us-ascii?Q?2wvAtcaFCOOz++9hxQR7gFqMbjAMOA4HakkguQKqkucHEmCYyt4t6J58OxIO?=
 =?us-ascii?Q?+HSIq6FoB6zNdigQv/ox13U2YpqqjsK+Yu0nL+rqWK3xBAAOng+EdsCRCNOm?=
 =?us-ascii?Q?wi6fnUmq6kCEZlidodYhG9KwgnMSOJSy443rP1DatIX7rYc4AtOQnnQCwWeC?=
 =?us-ascii?Q?n5OUyKT8gpIKConXRqT+hUo3+Mqdok+RzL+uYESFJX/z2OiFEtPK7/CscQN/?=
 =?us-ascii?Q?xnwbBHBY3IXY4PHLJeLkZmyvZkwlUqAV5VZrLTMtQrBdmFAmW8/Ke4I60gl4?=
 =?us-ascii?Q?k2mnwIbWYtXiLOIC1OkIwMZvdQ9FdRAaOJGyUxjSyFRWRMw7Y1NgPalC99RJ?=
 =?us-ascii?Q?S8NyLW8On68/JH01i62bqQ9gnopDYszLfUeOmcwRFbMh2HxOhPIP1xdnih1p?=
 =?us-ascii?Q?+w3hN5Lr7pgTN/D8UY9m+L7ZqE8GjHNELDw/CS69XNsV5EHtIvpD1FJ2x176?=
 =?us-ascii?Q?mqlnoEjMbof1E3CPQQHdUDnHq+SohfkxmAayeZ8OgcMCiW8GpjNP5dZNmdVa?=
 =?us-ascii?Q?iZOnrQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nV9A3TgEtgW3JTHDzfz3KSvYo5C4Tdxg+T5As6r8hxxSnh5n0jK1RqLhzswj88K3rRAL1Tj7P8KPEBrpCDNdhyds4EaJsP3nDA1Rmg5j4/Lk1EO6NZsL49L+9eAqj27TGuR/QWGwedLU+D8dxo4IXspXUJGojzdOlXalkGK/BBooQCrmxCwevOOeZ4vFu8w7++3J7pW1kzFSt+ugek05OOY+1N3M2ezXIMVgtfEof19J7m2MTKhjrPWTnL4IUsQ/hS9zNAwC+Eq/6lLI0DKhpUFtkDT89mFDd+RJxw+xSrT5UsjKsi4YrcMiskX62hN+IhUyT064NDg5z5rTFDu7bNqas/6IA+UBiCa4asBaCwQ41V78rk51egnnwkjh3eyxwYe3BnskD8bJetLY52cGcwx336Z/G32o2/rCHGtod8Mxm9w5rW511kB0/rQEHAC8
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 09:15:37.1963 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a044a00a-cfdf-4ad1-6418-08de70609c30
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8007
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

Add config fragment support for enabling inline ECC and/or BIST on TI K3
supported platforms.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
Typically we do not enable these configs by default but would still like to have
the option to start building them in our default build flow for testing. Also
there is the added advantage of users being able to see what is needed in case
they choose to enable these features.

 configs/k3_bist.config       | 1 +
 configs/k3_inline_ecc.config | 1 +
 2 files changed, 2 insertions(+)
 create mode 100644 configs/k3_bist.config
 create mode 100644 configs/k3_inline_ecc.config

diff --git a/configs/k3_bist.config b/configs/k3_bist.config
new file mode 100644
index 00000000000..671dda1a9dc
--- /dev/null
+++ b/configs/k3_bist.config
@@ -0,0 +1 @@
+CONFIG_K3_BIST=y
diff --git a/configs/k3_inline_ecc.config b/configs/k3_inline_ecc.config
new file mode 100644
index 00000000000..143c814b41c
--- /dev/null
+++ b/configs/k3_inline_ecc.config
@@ -0,0 +1 @@
+CONFIG_K3_INLINE_ECC=y
-- 
2.34.1

