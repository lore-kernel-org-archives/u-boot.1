Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0CEEC36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 12:28:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB2DC820E3;
	Tue,  1 Apr 2025 14:28:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="eiLsuHFH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F20F8209D; Tue,  1 Apr 2025 14:28:29 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::700])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A93E820B7
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 14:28:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=L.Anderweit@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P7Ngv6578A0AmgQnksEDGNRaEImjw4BSiDG0AHVyxQxfKAJzelc5FAKhjw334fagg3BJQ9hjzWS5nHhw98WAhJeN3i+HU7Ghsyf885a4LWZy9be/0Nc8YgnM2A/IICFLGVHMRvDFHqBdwg19mQ/OEtMFXSgBfgdwMKggztunGgFq2I7pMEtNbVFDTyuPBcYVQ37ndco7/QScRGiz37Pwu1Cx7GLXDX/Il28/11nAhEnAbsYP8tTiTAVTiltyC60aHypF4j9cCXwWIMvshwrouLREj0XS3/1OAjbS7ViAJfz7AAnYDd9vkrz/zxBzIMmkq4iPNm8EmJnSWwQEoi7IDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTan27EWikCOzpV9p14RKmMG4TGhLoz1ZpeytuKVpqk=;
 b=Pc0xn/g27coutIrUsb6ezpDUAgsVxvBKcRfsOfXSfxcwZCrHOXkGw2pTENsCqmly1hyMB5utnC0Hm9Qxg2HeNJaC1S0d2XwA1XWs3i6n0t5cunH1kCkmd2NcMdWIauLeHUGt2DuVJtjLgoaWLp3pe8+PJOyLOv7Z5k8JkD4eblJuSWdEgrhTEWtQIqB3Od41D5wUieUnKFf+HoWJwuTu7W4bNfBCp4i4ISqWJgyXoYcTGOvVIA/eOa4tu5fMKKgglZ/+jqvMHuCyGVj+D7hsoWwurR7XAI3Hfalm82PZABuzxmS11ES+OKYDmzXt4D97w5138vu1wUh85Byw4zNuEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTan27EWikCOzpV9p14RKmMG4TGhLoz1ZpeytuKVpqk=;
 b=eiLsuHFHOLmeM7lhlCIFD4XA1rZezcIzU0+ewavvVKYov7O7gfXQ8TEq60/alpxpc2SjoLr2SYYs6lDvtFclO2Nc6FEidfKs6ZRNxYT0FwHYKKipX26eOWoakZ19/Qs3KFdmAknHMzId9GUg9N/p9Nnjm9QD4y2sapZMf2aKiTfIoX4DFGR8r4etMK5mzTSNVjXDhHy5sbPT1MCQKKaohl8uXs7DfIvpuV0c44DsI/8JXWr5aDI1yTEW1++TQK+ra6nAYbRaYo64kTc6VIjNBHsOFML5KRPGYcW2fC8ru1hAianxExVjfHbPudgt4G8UnsDRAU6GOiOvp+jXIfOH5g==
Received: from DU7P195CA0006.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::29)
 by GVXP195MB1829.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 12:28:23 +0000
Received: from DU2PEPF00028D07.eurprd03.prod.outlook.com
 (2603:10a6:10:54d:cafe::e9) by DU7P195CA0006.outlook.office365.com
 (2603:10a6:10:54d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.54 via Frontend Transport; Tue,
 1 Apr 2025 12:28:22 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU2PEPF00028D07.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Tue, 1 Apr 2025 12:28:21 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 1 Apr
 2025 14:28:21 +0200
Received: from llp-anderweit.phytec.de (172.25.32.242) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 1 Apr
 2025 14:28:20 +0200
From: Leonard Anderweit <l.anderweit@phytec.de>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <quentin.schulz@cherry.de>,
 <upstream@lists.phytec.de>
Subject: [PATCH v2 2/2] doc: build: docker: Use code-block for syntax
 highlighting
Date: Tue, 1 Apr 2025 14:28:11 +0200
Message-ID: <20250401122811.14806-2-l.anderweit@phytec.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250401122811.14806-1-l.anderweit@phytec.de>
References: <20250401122811.14806-1-l.anderweit@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.32.242]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D07:EE_|GVXP195MB1829:EE_
X-MS-Office365-Filtering-Correlation-Id: e731d8da-5619-4bc2-5546-08dd7118b115
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GlmcbiRX+G1aBvT0vGd+FNSlFDij9gsXLojB9RX5x6NT7wPFAeeULJAOO7uM?=
 =?us-ascii?Q?8o8xA9114RZd3R9/JwldjWQoijrwa3Dl9SQkbVomRoRAdNd7fWTAT/zKITUC?=
 =?us-ascii?Q?88Uufu5eJ61kWEnZ1rS1khdbxtPDpdIvB7eyfK5uSuM+OWjhi7IFJZe1xANd?=
 =?us-ascii?Q?ulPW54b/pkieNU+DNhjruUe6mqUDpzM3QO6Xndxd+yjXmd/3/QiCfcWSkqAB?=
 =?us-ascii?Q?adw33FIYAbkx7liVONBh3E3TARFW+esb6omw1b3XLsbEAhO3ePA1jfB2c9A3?=
 =?us-ascii?Q?8HDC4+aqE2W4HkAIBvqlb4Oivo+CqSWU4k9enmZnwkQ5ybM45y5P1ts9vaJ2?=
 =?us-ascii?Q?aDaLo/DBWG13cWWsCCVOeTZhMryfOwZmbAt11RfvYujYAuxk/Vn4qRJHkar0?=
 =?us-ascii?Q?rjxAezgsI5R1HxdAZEVJui0VJnahelwES0sLU+hXCsCk+DnCj7n6sMk799Iy?=
 =?us-ascii?Q?Atom1KbONpo+4raJGd/tbRYDyV8+VBIKG2gItHF5+6wim8x/6/OjspYeHLAO?=
 =?us-ascii?Q?udkwK9FqUs4osm1CyKjyHFUiVJK5EJO0SRaF9wL8AJmdUMEr2q6F/gXCYJEU?=
 =?us-ascii?Q?7bijIuKHlhXORKIZnkHWmZmQK39dkHWdwGRMCPCfXsVK1fSRHww+HMDK3oPx?=
 =?us-ascii?Q?XxgdS1QZf11Fo0siE1zDEWeEksveylD8BGYoBNBtcj3DRoJ46Jx99QxVjpYx?=
 =?us-ascii?Q?1IKBq1j4X23qjBmIoJIfrM36uP00/bgIpHzuKeOpHLSHkGEtPOZfWY0QxARZ?=
 =?us-ascii?Q?9CQok1Wfl38zHZeBSFWTmGEBZyGtoA47VTCyMQYeGja0hCwqbs+wz1TVtJv4?=
 =?us-ascii?Q?nOAnxdZ5Y+FRFBaKfCrJuthRrFBgaAFYzQzLnv1cCYQxpwhu95jVn4CKgWCM?=
 =?us-ascii?Q?2vjBXutUTM1LUdp8jZ7AwGAZVJMLQl2JV0vLnlWPSVoOvJQRSUCyQ6HHJLSn?=
 =?us-ascii?Q?NocnG8NjYKlkZOCblhsxDwQsp0uPy5rQNvG7JY6h4I+SZhxPOuz7Mdu3S4DY?=
 =?us-ascii?Q?SxDjgmYYU2cR7ui1e/FdPamssSAqeurdecitTQxoigLvPDy4BEcQE7pfVXPt?=
 =?us-ascii?Q?QJxO0rMX6ijVOvavbSJiUXvpJ6K0/mQnlu9hvtAK++Om6byN6Mc5pipSUK31?=
 =?us-ascii?Q?WPpWMzMIbJm0kmfbKkmX53ohNjqLAeG/vApWBW6ZyepaOpSwn8XBsrw26K3A?=
 =?us-ascii?Q?hpv9mAVortudnH/EVtkbLZoZ+PeO+LnTGiMyTKXBd/n2EFf6pOaVuyUyQb+K?=
 =?us-ascii?Q?KxALFXycFT79ACwZjsmD85431JpXpLKKplLUudLamlm9/aORA8q55aQ8aEq3?=
 =?us-ascii?Q?JLYLYjWJjOaWDFHZCpI9b8/WL+HGs3e0A/qkx38oKtH8XIPlFH5dPfl5n22g?=
 =?us-ascii?Q?U5PL7MVSbQRCrRxGGStTsiBU8pSLSKORBG+DqydXOSsWJ4PcXPf/rnSeFQ1i?=
 =?us-ascii?Q?PcS+1VFqCT+8Wvapn9d8dSx6wAIrCVKhbsUKMXue3L1BFZ4ZARh9B/st6VF6?=
 =?us-ascii?Q?mOgiQ+K3ew1zObo=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 12:28:21.9816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e731d8da-5619-4bc2-5546-08dd7118b115
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D07.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP195MB1829
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

Use ..code-block:: syntax highlighting instead of :: so all bash
commands use the same syntax highlighting.

Signed-off-by: Leonard Anderweit <l.anderweit@phytec.de>
---
 doc/build/docker.rst | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/doc/build/docker.rst b/doc/build/docker.rst
index fe087651d347..4974a98d4af5 100644
--- a/doc/build/docker.rst
+++ b/doc/build/docker.rst
@@ -12,7 +12,9 @@ You will need a multi-platform container, otherwise this error is shown::
     ERROR: Multi-platform build is not supported for the docker driver.
     Switch to a different driver, or turn on the containerd image store, and try again.
 
-You can add a simple one with::
+You can add a simple one with:
+
+.. code-block:: bash
 
     sudo docker buildx create --name multiarch --driver docker-container --use
 
@@ -20,7 +22,9 @@ This will result in a builder that will use QEMU for the non-native
 architectures request in a build.  While both amd64 and arm64 happen in
 parallel, the non-native part will take considerably longer as it must use QEMU
 to emulate the foreign code.  An alternative, if you have accesss to reasonably
-fast amd64 (i.e. 64-bit x86) and arm64 machines is::
+fast amd64 (i.e. 64-bit x86) and arm64 machines is:
+
+.. code-block:: bash
 
     sudo docker buildx create --name multiarch-multinode --node localNode --bootstrap --use
     sudo docker buildx create --name multiarch-multinode --append --node remoteNode --bootstrap ssh://user@host
-- 
2.43.0

