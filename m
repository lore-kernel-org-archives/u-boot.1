Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81226C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 16:15:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65FD6877E5;
	Wed, 13 Dec 2023 17:14:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jFcRas9n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A510487815; Wed, 13 Dec 2023 17:14:42 +0100 (CET)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on0607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0e::607])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA369874A5
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 17:14:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=radu-nicolae.pirea@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3UBuuIz4cabs5hHkOvi/hZoZX6wGwv1twLVWyKm/yrIF11WQv/k+aocJkDWbszZv52QtGmgu10EPVA3syyxtRJN9sFokYv4EmLphPlIim/wAgjbf2fxtOQbs2fBdgrx+IY/qD2ABcElyqhOEK460qATDwTDK+PQIlQFifdLCPguy6O5fS4ungp5YnhItaTVcUOPMYDfbBhe3G8TF0oqXmY/hNYhBI6BSU6YQQHzMmCWBU6JJgzAoN50R7J8Stf/F0NLrHMqnPkGdNJfPn9bWo6X3XeQlmp7Jhakp/qIyPQH/1NKI0uAUm/erbP4aq6aoDCe/GNWmlce1cYm47mZ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LHe6nRkwFXJWzgvLOJ7sAJmfR62GdQGbE6yaLafkY4=;
 b=C4pAZcpeg6KKCfDcyMbHM5YiUMVJzPal1RhkkHjT9lt54wDZDuEOr7bjZQhrRY5rzfz/I52e9G0OPDp8pLeew5ZGFtQ3xCDPbc4VpaI+665Et+jaY5FTI9CCObfAnaQtOBJIYWa69P+y+HrGOYOny+xoyJvZq7FE75NWsa3Sa/vYewAQJ7ZirhAgV2ZU2OmGlEI1ZUPaywuFmDpI4T7ED68hQB6ikFeObV+eSsJPbTgBJwDvKQJf3hDe0c4R6Quld2B7/7HO2h/RH5BEL7fVh8kRNHzt7D7t/2uSdTaEyf6djmE6YxA1yaGh4GNtdDD2Syl3KvFt6BAsu57X3i/Mtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LHe6nRkwFXJWzgvLOJ7sAJmfR62GdQGbE6yaLafkY4=;
 b=jFcRas9n/uSrJLSgV5di/WE5das+w8UPWwg7Y6LGWhCQoBKApu7Dn+3HsMCh/Z0TOtjGr2yPMbKcdI3wCCJ9xZfZkP679gPMBAvuGZ7t6RmRo2i48I7xvafmeAaKy5Q62z0zFrJCs2luyHejE4rOrDD68CHOP5jQ064PzGUsBBo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM7PR04MB6871.eurprd04.prod.outlook.com (2603:10a6:20b:109::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 16:14:39 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::d618:e9c8:189a:892c]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::d618:e9c8:189a:892c%6]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 16:14:39 +0000
From: "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To: joe.hershberger@ni.com, rfried.dev@gmail.com,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com, nm@ti.com
Cc: u-boot@lists.denx.de, andrei.botila@oss.nxp.com,
 sebastian.tobuschat@oss.nxp.com,
 "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH v1 3/4] net: phy: nxp-c45-tja11xx: rename nxp_c45_tja11xx
 structure
Date: Wed, 13 Dec 2023 18:14:22 +0200
Message-Id: <20231213161423.258870-4-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213161423.258870-1-radu-nicolae.pirea@oss.nxp.com>
References: <20231213161423.258870-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0034.eurprd05.prod.outlook.com (2603:10a6:205::47)
 To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AM7PR04MB6871:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fe90cd9-0d17-4596-0a38-08dbfbf69b7f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s/VfWIuQw6cChET0aDKwtdTy2eFbUDnTSvjF794WCmkvOrGk+eY5ovSVOTgu582H56b9Aga8tuL9QHLwa2pY/oqSunR07k49Ok/4cyZ85bq/iL4T4rsj5V0lZuxLTf9N7h6iSZ58yEP+NLkr8NauJvYWzjcFvRX6G7dfHfRSFqD8gjy4bmJif1OY+iXbGnSvbHgKshMTbCnaUKFe6XW6LWGREuyReWk40fY+7a+07NpgkHaGbTuZQpbWzgXyDexw5/nlbGJdrOTOnWLeVlc6vw+J9YnqjVQM3Tle+bG8L3Q+hFLxXxXwYQcw1co2mnpx+1SALBDMVoCSqzja7M56cWG+wgNSDsY0/GwMvtiJZ4A9wA/Npn8U7EQECJ4kyz7KCVTrphxsaTUraEIpEbKa1R2KCTNMxp3YFQnIDyJ78L2Zn1AxnqeQtdEtfeQrUU5lEUnUKmJZsGAx1VfWbV5JKo67nfx9oAHhDShAaJA2FJTuahwKIyJUnQhcc45tS9qQNyFIdk9E58/AFl+3cM2ac3HTDaablqiwNTjqnhremHyqP8+MhTQ6SDvJMqWJpmrFJglVBkHdlrs7y+OmuLYSc5cz0WoDCPwrobvvKgboE5TjN5xXjpMVQwMv601iho9l
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8954.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(346002)(366004)(39860400002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(26005)(66946007)(66476007)(66556008)(86362001)(38350700005)(83380400001)(6506007)(2616005)(6512007)(1076003)(52116002)(316002)(6666004)(4744005)(2906002)(478600001)(6486002)(5660300002)(4326008)(8676002)(38100700002)(41300700001)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wPP/xE25Lw6o9eORBV7cCgDPMfQKht5LQY5L3CH1C39Tq3URBxakxv5hBSGb?=
 =?us-ascii?Q?Ec1VAHWcILdjVPnlp6GMVvF+2auOCWFnsKNaU1kLU5V5dTADpeA044B+7Ttw?=
 =?us-ascii?Q?Ip44GbQQBnL9nr8f786ZabYzrso5hKLnvWQ+g3wXTpvo2Nv0alZVHdzlkIEh?=
 =?us-ascii?Q?GYV1TVD4cFQMpak0JXQPrsw061v+xUs5T9N/w2jxGkXijiVgxnZUjXLbSD6Q?=
 =?us-ascii?Q?t1LlM2ou6os63n5qXvJzHZoduw0bOywl6ejFpxK1ur+FDVUgXfTXCogaH4/g?=
 =?us-ascii?Q?F+XdtI7NBwIyDGg7+guE7CSeACdjzfXSXtsoaL3t5Qiyk3qFnBpYcuhHCxDo?=
 =?us-ascii?Q?5pX1zET45BIQ6vrJgjoST46hb27MVqZdOos+nLKepj9MEsGMHyuCzgt47eEz?=
 =?us-ascii?Q?/rE1k7cHXjUseei6657htOHhjuU4A3SNmQOz6Ou0GrSQ0eQySKDO2+4PtnR2?=
 =?us-ascii?Q?d5q9/AEzizWj2EPNWbfPwKJ7gijtpwp28yiqSsfDR99f2kyxe7AS+y/mYTNo?=
 =?us-ascii?Q?bt5Tz8gyL02ftGtgrCy8yHA+7aYQtdJS6QQe0rLWdHjiAd5SNQTx2ddRlpwD?=
 =?us-ascii?Q?Us4vFBVHeBIYLzYP5Xq4hmPjZOTFyCxeykzSNd07DBdzYTPPmLpvRTfrD8KO?=
 =?us-ascii?Q?M7bDiT25lKha29zgxzwL0UDhJrZVgZfVQqBQu41nYW9Fd0xDsN/QKPV0KGg4?=
 =?us-ascii?Q?7AM86i8Bn+8boDu/pHjnwc/UqpAO3mEAnt7Sw83FL8hnjH1HM1ZeIBxV185y?=
 =?us-ascii?Q?XuH88WXXwvcsSh77qEFbJ+X7kKYkpimNoT3QiEJNz4kEMiOIBUHYpj79jMH/?=
 =?us-ascii?Q?OHxiTa59mKIOtawB7lzDbrNnOog5SYZNX5HC/mX6/L0JcDB+XQrcD/BSc3b2?=
 =?us-ascii?Q?lJPFT9ocmds4ODBACIj3bHf9gLSLzWDZacimFW7Qc69jxdguVDoqSz4DVcz6?=
 =?us-ascii?Q?orI3pHzo+v6u06BCLWImb3rS0AdjzooidKES55PGZQ1aBHT6KqCpU1AJ6Kc+?=
 =?us-ascii?Q?uf7T59kzq+pk/NJbC51fZ0ttyV/YCKwVfCkONA+TLdD4i3PKGsCHseZxeiGz?=
 =?us-ascii?Q?8jM5po/OqXwj/59NsZ1h+pwu/RaoEu4ublJfSsNgIdxF/TwIcioTtCFbhbDN?=
 =?us-ascii?Q?73u8uN5RvLKXQoqyfVILro3zR/alaGKq3R/DRlAiWsSgtjE2PtTflINd0koi?=
 =?us-ascii?Q?eLP7gURbY/V0eMbMZggAoLNJUQbQ0D+kJDPawBOYy1mEWrPxl4K0keCr/kDf?=
 =?us-ascii?Q?Cj+gbGnT/Ul5YW9fPlCt920nOtntxlzlzhHiSPT6P1lUC5wWPT78vrLlIGUo?=
 =?us-ascii?Q?W5/r74bJjga5lZJ4xyKKmnz5Soac+5Z4RKTzXP+CzXsHslq2HpCyH3Cp07TU?=
 =?us-ascii?Q?LHWiW2HBIImaT0y6uD2Az606Jy+ogPvUaJBcg7W6/oMz4AwS2HxjANDxDbsM?=
 =?us-ascii?Q?CnWRds1EqFxNFnNAKFB19QOfQ7XpNNH3ba0iZuMs1GEc1TxBPkBYO4KM65Ue?=
 =?us-ascii?Q?sgXkV9hPX9SqdJp9lZuuHE4nYIpSMHz88pPWAb+/NUP9eeuwpCGEql5rqiBK?=
 =?us-ascii?Q?Jeyo8vekQik3QIcNBUU0eow3iJ8+n0rcL8uSh5Ji1REZswJo0dvbsNlnpKJK?=
 =?us-ascii?Q?2Q=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe90cd9-0d17-4596-0a38-08dbfbf69b7f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 16:14:39.4354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sKEdCnHd3An6vpEUKtaTzlaJ/aROIYfZVEgotCRlpSqH+LfNdLZw7G6Yr9XXPBopD9GZeZOaoSOl3moGOFZA+lZXBhu1Sw9Iv6nWxPzvdV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6871
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

Rename nxp_c45_tja11xx structure to nxp_c45_tja1103. The driver will
support more PHYs and nxp_c45_tja11xx is too generic.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 27d871c4b6..e787f5fbb9 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -353,7 +353,7 @@ static int nxp_c45_probe(struct phy_device *phydev)
 #define NXP_C45_COMMON_FEATURES	(SUPPORTED_TP | \
 	SUPPORTED_MII)
 
-U_BOOT_PHY_DRIVER(nxp_c45_tja11xx) = {
+U_BOOT_PHY_DRIVER(nxp_c45_tja1103) = {
 	.name = "NXP C45 TJA1103",
 	.uid  = PHY_ID_TJA_1103,
 	.mask = 0xfffff0,
-- 
2.34.1

