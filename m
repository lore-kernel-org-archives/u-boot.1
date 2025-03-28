Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62AE3C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 05:58:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 857C28129B;
	Fri, 28 Mar 2025 06:58:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="EYgF+nQL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D459A8144A; Fri, 28 Mar 2025 06:58:47 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2071c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::71c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F753805C8
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:58:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tFUV5zyKWF9GAuTlXFfDt9JC10Gs1CpuoY+xPvLLle5gl4D/HPsw5TMU2SLBeXhE3CqigtQ6ROsDCyvE153urHK10Bej+NxpHzMH1t1/Uih2Rb41cPXI/vBY8pLo4zAFS7hqo4H0agF0slXrOJE6Al6ztuayCiHmQqSo9rsO76pKzdq6Oae7QSR96HYD/X4pVJn4jhT1ODO56M9nWrGcJVYbSd/mpj2gCvBsufl87Lh8tBMADKgQDxfnQjgep7Mk9g3n/chegnQe7BOnvjjdn0H7ELtfLfiM/q/ankh10WoFGWx0QZxrTIFSD3zMWeu+T+F2/dWCsp8gOx773C8ISw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Asrg8qbqLTk0YWN8c0uMfHdd4Q1heovzJFlLkkFvxzw=;
 b=yq1Xhy7Y8Ijkb8JLhZd7JKvzEASRUG+SsStu3gTR0aexvFvEu0DOj59W4ZZYvB3TzYC15ygOjR8I3jXCcjR4CJODoJHsUyGHRzYEXHp0Ee8kYyQVkt/j0acm2Fds1s/FkKipQe2Dv3JSQ+WKD58Qi/BbCUWThNZW46k4aSArSAgcC9gK4QhYaUMLD8dhVw49p9i9cV7elEkE8+WSsUMaBopKJXQuK/cX5QXx9+924bVzAOluUDoomcqvHrxE6C9AyPy1dQ+a2/NXWREmNdXn08RCrpKGNYlpnZTPJwmoPLThE5an0MQrwhb1kj7d1R70V5nPNASPpmB8fIGFOmwx4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Asrg8qbqLTk0YWN8c0uMfHdd4Q1heovzJFlLkkFvxzw=;
 b=EYgF+nQLKx/eWtSB2HOwklnAvNXc0ULByz67ACeuakNK/R+Or0xm3y6Lk9Qd3BYDoWg85oQniS8Mwdno03wqiilGkKoES/dT39m/k/YtA4ZtdtgYkZ3gsxwHK7w4X5kGYo//0cqgeRzYvU2+JXDJNlAJwz6PJLJejODg89cG9np2yX9v5hL+QfwAJP1dFbpXoORpVSmKDfNDiKgVj1Bh7pAW6w/zwlgZWgeki25aixSgGmP5/F7ftGHhGd11UvYhyNhzhGBBFFkLYj96OcmVr3Zo3Kp8aYJzM2bLnA2R4B6LWmMi0QVRFc4+JM7IyjLiA+wFrJKI0hI1bxS8rktvAA==
Received: from PR1P264CA0003.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:19e::8)
 by AM9P195MB1362.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:38a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 05:58:42 +0000
Received: from AM4PEPF00025F97.EURPRD83.prod.outlook.com
 (2603:10a6:102:19e:cafe::80) by PR1P264CA0003.outlook.office365.com
 (2603:10a6:102:19e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.44 via Frontend Transport; Fri,
 28 Mar 2025 05:58:42 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM4PEPF00025F97.mail.protection.outlook.com (10.167.16.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.2 via Frontend Transport; Fri, 28 Mar 2025 05:58:42 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 28 Mar
 2025 06:58:42 +0100
Received: from ls-radium.phytec (172.25.39.17) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 28 Mar
 2025 06:58:40 +0100
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <mkorpershoek@baylibre.com>, <B.Hahn@phytec.de>,
 <upstream@lists.phytec.de>, Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 1/3] configs: phycore_am64x_a53_defconfig: Enable remoteproc
 cmd
Date: Thu, 27 Mar 2025 22:58:22 -0700
Message-ID: <20250328055824.3849523-1-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F97:EE_|AM9P195MB1362:EE_
X-MS-Office365-Filtering-Correlation-Id: f6b263d2-d0e8-4eb2-09a4-08dd6dbd9815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1XOrT8C0v75TZ7d1MCkuexd8CQTyZ3f0+hHg5+q4dSK1hDq8r2TMeMQsdAfD?=
 =?us-ascii?Q?A6Z5ZNcJYCL7+3j7MVde4xK3lSN++jlbYrsMlhQ3b7qWy3s/+22E95WhBNsy?=
 =?us-ascii?Q?IF4boyNgSQibLITq9tBBPjdMibBBXQ8Xf6wweofAidS3yaTymsznTOTqjjbN?=
 =?us-ascii?Q?rTJTxPG8a+NkTjOwrls9dMofTbxAVkbA4IKbWmfxTyzMH5sa7v3dwzQEgghc?=
 =?us-ascii?Q?FHcY6tsViTi4MPmMQdUtIb4cxvRiHWzPTH01ATkK+RKlA6wOLBIlJIFFNQtr?=
 =?us-ascii?Q?3v6Aneo/O29YhRPlWZGOgHZ8v19jRWiHcigRLwFZiY2gR44p4MM3rrFuB3PE?=
 =?us-ascii?Q?sPH0Of7WpUhb3z2kphLiBsn3X+iTlQ8CXsH4ALrGM9yWeGfUjHm44nlr0R68?=
 =?us-ascii?Q?eat7hvRDgAjwmtZruAev8MH2N2TB6KZhHM3Fn0w1MHEly5/x/m+K2QhCCRRU?=
 =?us-ascii?Q?WGlVYsii/QsQOgSMZSJn5NAzav2jB5q3PIk5scYJmh37ei3qb5KAIy/mxdof?=
 =?us-ascii?Q?tLu7bEnx/7tALc3HK8D6snu6z0Phi9sanpsvP4q/Gsz+1B7pTW2DtdhMe/Dh?=
 =?us-ascii?Q?xIdGN0JJHC7+rjSf/0o8NDuswBN9yDTcO38DZwwN4jAWTxJja3vJcHVBkuNX?=
 =?us-ascii?Q?l3Spox2Cy/Ierg426ic4/u61r789qrhoEBZM0z3+DBupgBEbv/L4zUSVln5E?=
 =?us-ascii?Q?YZoHvJCkWhbsGGYXgnLEkM5eIYpaN592I6/SEH+PffOQCAlUhGmsRQlIpk+M?=
 =?us-ascii?Q?L4UADzshotZUmWREMn9BdXeLG2/8uueAb6+bJJHip4D4D9mLaOnDDmeCx7s8?=
 =?us-ascii?Q?SvB+UOUYIULc0ZgEJk6Lo5JP07V5xJD/Pk0IpU7qJnjFXei2js1owF/93U/n?=
 =?us-ascii?Q?o+2U711PZv/EafMgEt5jpZ/6UQvNdrem0HDXkN7E1/D8IXu496WyYLW5secT?=
 =?us-ascii?Q?cd+kpIuHRBpMaNDIM/CfQekEd2+qSqz1U4pTTA7derpVydJODzDRVd/RNCC9?=
 =?us-ascii?Q?Kr8vQzSlYaFSpBSJEDHLyA2+QR+AYnKeR4PL+GBzoizx5cRSjHYS5wf63868?=
 =?us-ascii?Q?N9aP1n2ZVSrjbfq66+UHywnjHtwiLpmuZJ7ybJ8xjkSbN4+1aYVAyIe8Ii/i?=
 =?us-ascii?Q?WPVt8ruq0zJauWWP4ArDbaHP6B8dBlM1Z3pqYTsGijBhTgL+ftiOVgaVmSD0?=
 =?us-ascii?Q?ZMSKXZDza4EZpBkO0naOHTWNodxSglTkPH9IKBXn+tLMjU3dav/tG0uip+Tp?=
 =?us-ascii?Q?oTzeHkOG7s8GZGAlPxN+brZNQCvfPOD8G2YzrZ6lfgVQZqtGbywoAWCfosqK?=
 =?us-ascii?Q?64n8gbXzVW9/t0BdKuwFx0I9wnrzAqmaP2r+eyuDCU42lK4CvW6TTaDyXs/O?=
 =?us-ascii?Q?Asrar43RYNgkb1VVnYc0C5bKpvD3n7wkxZfnIVOpSFGlPqkdq++MLP07Aabc?=
 =?us-ascii?Q?K40R5i18MvMUW3wsngxgXCIo0N+OOx/D9k+BerEuGl69Rudc45eeN/OPwMCC?=
 =?us-ascii?Q?/tldRuxljK8lmiY=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 05:58:42.3819 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b263d2-d0e8-4eb2-09a4-08dd6dbd9815
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F97.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P195MB1362
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

This enables the 'rproc' command, allowing users to
start, stop, and manage co-processors as well as load firmware
images.

Useful for systems with auxiliary cores, such as M4 or R5 cores
in the AM64x soc.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 configs/phycore_am64x_a53_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/phycore_am64x_a53_defconfig b/configs/phycore_am64x_a53_defconfig
index 4ee1bd829a3..72936865132 100644
--- a/configs/phycore_am64x_a53_defconfig
+++ b/configs/phycore_am64x_a53_defconfig
@@ -77,6 +77,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_MTD=y
+CONFIG_CMD_REMOTEPROC=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
-- 
2.25.1

