Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FDE1D29DC9
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 05:35:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D80198388D;
	Tue, 13 Jan 2026 06:35:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="P7sEAE7d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 552C7838E6; Tue, 13 Jan 2026 06:35:47 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E03BD83885
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 06:35:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aSp1I4EeBGCmxTHe2iX0hOKdN7yomPTlBdHsT1g4om0YBqxQ0ryfXhkt62nBm0vxERz5BCkcl3stqHD4lJrVABa7tNPPS4GFLKLou94D113QNU6+swh0aPB7/g+3dfUq2+A7D2xLzhyalj1qnx5VkLBZwCN/3hgRVFeS7g+1jQbHisjWuEwdfDePuEkeV/cbyO23lEM8E4xHbCoHUr6l4pvV6j+G1Y9nSUYxIzdkwkF22uqrdTiHBrZnqzzUx6z3uj7bu6qRMP+OybBYff6CePQqxvBDqRoBYU3FQ1s+IDf/3xeix7Mkq1tcNlvq0cSrlL55RQj9TukvuyaAM4OWUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ue2VUqaBhXmYorYzwu1/TGjBcLlihLA5aMDrlmXr8ik=;
 b=Sdlgt/DfQk0g417129a2OerSsmo1Q0268oi7vyzoP1TUbI8e1ukCy3zTSN+qgFPP62DuqKdYeOJM6Uv/lGAiz0DMAesPmY+Eb7WwGNVHc2KMzTL+3Pfk/vW6rr+/tEad9+qjklPf1EgEvpS9WsRvsBOrk1aYOGSHLWbzgsqbRziVeru9oD0lkdtXrLsj1XRrzO+NdYPnpmaee13Bm9UHg95//TTKzfIH7Gw9UPUhaLD00MD5cEicoI/Urav3YfjD0IoJDghVkaIJEy60akSxSM33gIP63mKrX+67X7AF6dQgI7J1bvKCP/jwcscVJ9AL+PUVDtP4MEwXmeqrmkDikQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ue2VUqaBhXmYorYzwu1/TGjBcLlihLA5aMDrlmXr8ik=;
 b=P7sEAE7dp/vMy9TSKcvl928kb1lahUp3BP9cUsy/FXrfCfio+Ow0SGBu1yL1NKSo86OkugYNFPONP0Ry0Pi4/dxUpPl7nPK+FnpPlkmRTQaAedR7FHjcvd2/9six3g/9OfTSktMnjhthdNrwcOl5y4tx00+ojNZwy2pvv3weSwWPJvH/tf+mmOxmGOwDfVgiBrCswx7BpJA57Lc/NiGCki9Z5jRiCEMxaKX9v42TCnEQ2a5YZR00MnFbaFb3vbLZN/6u9pBxKQe3cto/dbyG9Sjy5GlGF/R/VHWfZkWMP7GSGCdSA20CQUyR7xVIf3rGW1J3pZbZQj8/fKnP9gdRKg==
Received: from DB3PR08CA0019.eurprd08.prod.outlook.com (2603:10a6:8::32) by
 VI1P195MB0575.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:15e::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.7; Tue, 13 Jan 2026 05:35:39 +0000
Received: from DB1PEPF000509FB.eurprd03.prod.outlook.com
 (2603:10a6:8:0:cafe::14) by DB3PR08CA0019.outlook.office365.com
 (2603:10a6:8::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Tue,
 13 Jan 2026 05:35:41 +0000
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
Subject: [PATCH 2/3] configs: phycore_am62x_r5_ethboot_defconfig: Drop
 NET_RANDOM_ETHADDR
Date: Tue, 13 Jan 2026 06:35:30 +0100
Message-ID: <20260113053531.1204984-2-w.egorov@phytec.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113053531.1204984-1-w.egorov@phytec.de>
References: <20260113053531.1204984-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FB:EE_|VI1P195MB0575:EE_
X-MS-Office365-Filtering-Correlation-Id: c0882606-97a3-467f-72e9-08de52659609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ncWsIdzhmfF9vE0DnwIkPpGmuiC/Wgo978ptwraEU8dLGqUYmWRW6s08ps2P?=
 =?us-ascii?Q?q8xlkw+7UeW+GJlh2yxVINKQGUCIhyei7O2gAUPIWni/Sb2umlfoXg1vmHXR?=
 =?us-ascii?Q?KMtgRPcTN22ls6nBg4zDvqtQoSl8mVvyBon3GD1Ml5F2k7SeLWNhOwd6tRDa?=
 =?us-ascii?Q?jdTrZqwaJhfnpL5oeajJnUzVoYulEhtvfjEsZrZhld2uHrMFbmkZ5LPV4baF?=
 =?us-ascii?Q?C1p4eMkVgTWHDiPXJAfwl/jO+IZxEGvk/7GkZ9oXgvzeUdUkvyr6FEWheIZp?=
 =?us-ascii?Q?YgBOa36K2bgT/JbMZ1OTESYWmqnHMs+Pq4BxT7lEOwKVIZk7cjaJZGDNbJTp?=
 =?us-ascii?Q?us653Yv7DzvS5zfA8Rlz3a6gjEuJD4wlUVAAjKvpsi5SGC2N5IUcRELxBxbL?=
 =?us-ascii?Q?yz1BKkyOfKHvr0xbnR80v3h9ozFSoMwHf9TvgfXVJGU5Gj/z8jXzHfdTsgwa?=
 =?us-ascii?Q?xyX0mfiql5GXOnUhj+8sN4zmZkiDfVX6GqLndv4ORDVoV8o5fiL8VgiT+7vJ?=
 =?us-ascii?Q?jvRK3EE6pmcf2nMtGLGEgodOPjHKVXl89QEdCGshJAvSXNdJnnIJX0Zet+fo?=
 =?us-ascii?Q?SYRt57vIzOF7t+y+rmsP+uov8fEfYWSXdYN+nwOq8FmYLO6YvWNUdhdLpZl9?=
 =?us-ascii?Q?u5sbtSNFHY4MB+1ykNpr84uP1T+IsEEB3vcYUuzu8yNnmazfsDonvtUBEDci?=
 =?us-ascii?Q?QzAoMweqBMUD6Xb97CC1CDWsbpN95u/Trx6mg2lfaRHQA99b/EUnxjkJCBFG?=
 =?us-ascii?Q?Fzdef1bk6Q37mRen2lgSfF/JoNfReayyMpdqF96qSNuiNDa0LgHnlKeZJ/31?=
 =?us-ascii?Q?9g/27fPrL9HWPGX948x60lsfjePpBNBzIpI3SZIOEyZRWsOOuFkUQnrIjmI+?=
 =?us-ascii?Q?3PUaajLGYTMswzNGDjboC5Kkw90uWS+RWTGNvLdfwi3a3ZlzJ8TovGMyhYHU?=
 =?us-ascii?Q?wrHYixBxZTD7Qq9dsBZ1jfTq+X3tliUgYOpuGPfV88mheHUVgv2ZYLd80+l8?=
 =?us-ascii?Q?HximXbfk1zIlQG40I/9ZTinNutmhqOARz4lyhSBrqauSVuqDeaqggQLJiztA?=
 =?us-ascii?Q?yALVb3wI453eE7aNmGesYHf19gRgpXsr3ou7O23ujEovG/mEIKb1k9V4np44?=
 =?us-ascii?Q?QdtR4Qo8mHJfxRJBgO0EmiLjv0SHcx7J0RmL9xfUrDl9FG2/vN2AMkMrv2ol?=
 =?us-ascii?Q?ZULBk8mGQ+xR874obU87W6rRNaJU8PlnyXcqW4T6nREV/TQTGFimI+/HLVK1?=
 =?us-ascii?Q?C5yAAVMUEf6ibI1ZtpHTc+G8/SEm8BhrRArxm1k+sW1bPc6FkZ9pzWw8LoXr?=
 =?us-ascii?Q?oDqTM07gD53gXsU2NY+MM+ZTSGkNcMeIJaF6BcItremLPs7LvEuUY1uECqOa?=
 =?us-ascii?Q?3JSJflyVhNTIEZd+d0r+14H/zpMvH9DlpxoIaep4K3laS/CDn+hJ4lgFv3zV?=
 =?us-ascii?Q?2afHG24gUUllZJt2d5vSEm/09N7G0z+qB2tta9WmKbzIbogtC4osZBJ4+p2R?=
 =?us-ascii?Q?WxbmFszVrhQH9PoE9VUHZgqe0PB8bqSkNJ05ZV7rAy/w/eQ3wuN2kX5pJx0Z?=
 =?us-ascii?Q?bBxXaPgCBeH3KQokiWU=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 05:35:39.4827 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0882606-97a3-467f-72e9-08de52659609
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509FB.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P195MB0575
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

From: Daniel Schultz <d.schultz@phytec.de>

BOOTP does not support dynamic lease expiration. Using random MAC
addresses on R5 network boot binaries would result in continuously
allocated IPs without proper release.

Since only one interface is enabled for network boot, rely on the
MAC address provided by the efuses instead.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 configs/phycore_am62x_r5_ethboot_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/phycore_am62x_r5_ethboot_defconfig b/configs/phycore_am62x_r5_ethboot_defconfig
index 92dd0be647e..a4434388ff8 100644
--- a/configs/phycore_am62x_r5_ethboot_defconfig
+++ b/configs/phycore_am62x_r5_ethboot_defconfig
@@ -20,7 +20,6 @@ CONFIG_TI_K3_NAVSS_UDMA=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_OMAP24XX=y
 CONFIG_PHY_TI_DP83867=y
-CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_TI_AM65_CPSW_NUSS=y
 CONFIG_SPL_MMC=n
 CONFIG_SPL_DM_SPI=n
-- 
2.48.1

