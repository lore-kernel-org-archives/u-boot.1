Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B901C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 15:26:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B51180C69;
	Mon, 10 Feb 2025 16:26:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Zm1fwGnH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86D2980BA9; Mon, 10 Feb 2025 16:26:11 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20725.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::725])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81CC2807D6
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 16:26:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/w7a31se+NPGy0hGkqLFXAFpSxrtFNxm+ckLFI3UODN+YGR2PegScnkW9HQAXPsw0xx/hsnt2LIPqwKUytVI0ARtkQK6VKFZI39TdmI46ByZwdi578Tixiriqt1xQPZw4bCTfwrlskV+0SraTQXkpBZh57ZEDSce+wBsPXOQPi12usgEFRJJMGVI3XsaZ7gUitqdl6ffvEr2akMvb18DcjJOmUdpv/cfUA5DEQI07bty15yQYoKset1a+udcIA0z8MfduzmNs6gvQxA7sLgqJKsffuMeuIBXS+FI1xhUbpddVUWjSWYvi3dfUo/BjPzs1Kp8uj7yRh2KBpTTEaX5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfXFhtZvQJ/gQW6tc39lmfQreF7BC0YYRCPnW6qfEfg=;
 b=qQ23Y4EKt7SUz8jQOgwWeXfA5yWai/r3HbTNngjkDJhljWC6OTQmpFe6eNi8M0RUc2tUg3PuL4wSAmZSb5dIaFVEpIMGMurrxqtgRmanEUle31NkenhzC+ln0DVNJ3KAHjgHGN5J7FaZqTgK0ZRW667NIHwX89DedGP1WcCxkIsFaGm4yg+gVXxXdssp5IU9zhEYqmVlojpuYvG7/Wr42XAVXyJockD5IPBrYiKMvfW/3AifOCGxp0Wr7jL4gy20juYf8BsfiJGcnbkL89X0YARXEz02QOVtFg/eZffoA3+A5rsh/+tQVmsoiVYBiyXOwx9Vc5as89KXowKBj9Dvtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfXFhtZvQJ/gQW6tc39lmfQreF7BC0YYRCPnW6qfEfg=;
 b=Zm1fwGnHpZZegX9vMBxgaHrqDLVVka1LJtOfoHbsy4eRsXUpLHx0/lYk/pTdOL9mbvSjrioKJVeWjD6j/k9apU+Ve82nCd/jsNgvMGf/qS5ySsODZNngi6Hk+eA1Xparch3NxqVADIGaGFeKVa8V8Z83Dd+rJff5xWo6DZNaG7r/qZa1OfGottVm+fO+kpd28qUJ5RgpzrpJ5idevzRUT30HSa8dFa5ccKjmQHhQCrWGDl4v4QfHmkKJ62ygKEIDkBRecWL13/oe/YWd1YwJDhR+niTAV/DfBqUeBK9IQr39qn1K7mQXWJR2FS0wgd4E6kAZbxIDCKiph9qHtq2m+Q==
Received: from DU7P195CA0030.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::17)
 by PAXP195MB1605.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:285::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 15:26:06 +0000
Received: from DU6PEPF00009528.eurprd02.prod.outlook.com
 (2603:10a6:10:54d:cafe::11) by DU7P195CA0030.outlook.office365.com
 (2603:10a6:10:54d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 15:26:06 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU6PEPF00009528.mail.protection.outlook.com (10.167.8.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 15:26:05 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 10 Feb
 2025 16:26:05 +0100
Received: from ls-radium.phytec (172.25.39.17) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 10 Feb
 2025 16:26:04 +0100
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <upstream@lists.phytec.de>, Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 3/4] board: Phytec: phycore_am64x: Increase size for Image in
 SPI
Date: Mon, 10 Feb 2025 07:25:47 -0800
Message-ID: <20250210152548.1263498-3-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250210152548.1263498-1-d.schultz@phytec.de>
References: <20250210152548.1263498-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009528:EE_|PAXP195MB1605:EE_
X-MS-Office365-Filtering-Correlation-Id: 779738c5-8b78-4417-d14c-08dd49e73cbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bWZTQ0QsF94kTluYVh3tFSax7L0nIWS039RloefNIuTDxPriRbUQhrKa86C5?=
 =?us-ascii?Q?HJWIR8DPoxwMcyxmYQrpNxzU7DSnIx8A26jFTCdK6sE9+AbQ2xBXP4uUg8eJ?=
 =?us-ascii?Q?gB2eTafKHa13lUCKBI7JkL4qlvD75s6gGbnohVimA3WTy7K5m5pk9kSJ8Q/V?=
 =?us-ascii?Q?A/H5FJRWC/pn5Ye+/nzUf8S/5rGUa37BOR2mj6co1uhceFRe8Uu787KhSO2O?=
 =?us-ascii?Q?weXyo64904PcQxiuPSeSVdmXvNVwQpDQ19zmSJN4b0pXT+aZlCGTNmZwTJfe?=
 =?us-ascii?Q?Vbv1gokwKx3T4JOsAb/wW3ZbPxgZTZGgw96/qpXPgtH7FXj5fOg90hraQGVf?=
 =?us-ascii?Q?haWsdcffv0MWXIX704GOKChF7t0rJbaKbXkLnL2t5VDz999zrfF0FXTxu95V?=
 =?us-ascii?Q?K1LTbVALAO5rsz/WZkv9wKdz/WO2Tu/JBZxw0rSypLK+qv2FAusXeccZH+Y3?=
 =?us-ascii?Q?PWyq4w4FLhfkPeDaJrRvMGYGjJbid2OviXoVQa+wzGXZsdCyTsp+eAktCw6O?=
 =?us-ascii?Q?TmxYxJRmqDr7EEBhYHCNefst31ykaiL4ZBQSGH58W7LZg65Nce36eiBnIwEi?=
 =?us-ascii?Q?TRjHQBt9P0yR52s6GBUggpNFk0MS0f4cvTlPEPbZu9N/9olMKPxuS6eZsF95?=
 =?us-ascii?Q?h2uE0+62LiDApD0RpLZKr3SRBG9z4wb8BK5fl+24n3hqfPTbuS5ziBK1/fuS?=
 =?us-ascii?Q?4jjr9Lel9jWaDY5HTJgRRk/sr9PNElV1UFffhGZDuF77sZ/J3U5WYCzvQe3n?=
 =?us-ascii?Q?GMqcyDmKABNCllYRiMQOU6EfXykyY0aFTMXVRPi4TXsw7tDpb+ySCSo2aOKr?=
 =?us-ascii?Q?SB0Oc3CkwUR1d3kG83BHqfHtXZbZzgKbbdKFmEXqraWFolRqBGQCAcFtW1T7?=
 =?us-ascii?Q?g+2rkWCT/fMd6l5ywYmG+pOP2LSdeIbnHL09SW/eNUiteHydtffPIzpaL+Kt?=
 =?us-ascii?Q?+GP1yn58yDViej2Rb5VOKWQhuZ2gn2lmaOJdvx+/24gQbEI1VIROHCz2iWKy?=
 =?us-ascii?Q?mS2Z/sGvjwyav5tWvAaGLDrL8CSaedPAptqhKH5dNWThcTWceNg0PHKGTp7L?=
 =?us-ascii?Q?0yJECXi0i9Mf+PGjWUPDEDau3wtssdY6Q1e7SgGjDoswIAyWsHBuVkM2J3SI?=
 =?us-ascii?Q?25YXaW5VrgMd9eiT7aMvoRRI7Yx9VGaQACM1wei4zbFZcOoj/QZsIL/XhRZ/?=
 =?us-ascii?Q?kz0yjWicqzIYOSBen5qdRDNnf0/jrjYZiEn6APOSqcEGBOelyfjHK3GV4Hru?=
 =?us-ascii?Q?BeVOA/F5tgxuloPvGBpSJMunNfGpLujsOFTph95CrEs8I5/wS8Rzk66PFd2D?=
 =?us-ascii?Q?1MyyKNSarNiR9SqmJ3o9Rx8PM5eE1A5te9IdfF34mPz9h00mK7WW9exjm6FX?=
 =?us-ascii?Q?Yxkax89mLu3EF2b9gsa0/MPK6aYIVU3CV3RyoJephITVZ1e31IXRsXP77AY/?=
 =?us-ascii?Q?VqeuJMQsaczhxwMFB/tQMrgA6krrDdqo7wvl2MsrhkfepBORTnlsY4KK/PBD?=
 =?us-ascii?Q?iW/hl8QDhUxMxhk=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 15:26:05.9949 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 779738c5-8b78-4417-d14c-08dd49e73cbd
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009528.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP195MB1605
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

Increase the maximum Image size from 23 MB to 26 MB by moving the
initramfs start address up. This gives us a bigger ranger to
provide kernel images which are not stripped down too much.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 board/phytec/phycore_am64x/phycore_am64x.env | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/phytec/phycore_am64x/phycore_am64x.env b/board/phytec/phycore_am64x/phycore_am64x.env
index 3032b518e0b..d69dfe75674 100644
--- a/board/phytec/phycore_am64x/phycore_am64x.env
+++ b/board/phytec/phycore_am64x/phycore_am64x.env
@@ -21,4 +21,4 @@ get_cmd=tftp
 
 spi_fdt_addr=0x700000
 spi_image_addr=0x800000
-spi_ramdisk_addr=0x1e00000
+spi_ramdisk_addr=0x2200000
-- 
2.25.1

