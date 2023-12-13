Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C1AC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 16:14:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AAEB87813;
	Wed, 13 Dec 2023 17:14:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jSok9lzh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD25487804; Wed, 13 Dec 2023 17:14:40 +0100 (CET)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on0619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0e::619])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAEA4875FD
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 17:14:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=radu-nicolae.pirea@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLptnCKCax1GVSYvCbvgxDpLfmrkxY6iJLyJFwqsrpNcI+dh3k74cECgLjcYK7/mC364IzKNKriWnMlsxgs7HYTzEJjb0ke7ZJjj2/NL+ztdNi0uMEaJFPzjiPuGkQUde4WlAB1MejK6MIzqn6sHyEApknHXbe2zT9Re13Wuj1Aodg9jui2BOWwd5F+09M38wKn3HnqvJ02B3Z6ko+OwI82SV/e2V1N+T/OgpAEoSEx6c/rEGdN3fmkAgUfyW0HH08mTlMV/yU6xvw6Zwk+g9+R2ul0spjjwOSDBA/boRIMPFL527eZU+u+Yv0VMCTGHgaK4O/99Odbt+SqQeqOjfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMWFcU/HIBT4wivgjORs48if/eZDr42cFoKAvQrJkOI=;
 b=ffk0fF39RnSsYw3hsUnsiqerKZ2o4cR0pqfW7+HksWPURC1iAJ/9z9QnsPFVqHqOmfEBTKZ4GRojohYDp9/zNjSaVfCG3/nB7xJ5Bxsrvr+2wfdFZUUAW1lzMf75uT6OPqi6+87PU42Mw1pBOXUSD5iEPPutec1cgVQMVAN7/N7kM85klFHz+BysTOTH7n02sdcWYDfQi7uNMino0+IW8UmepOhuH5rS3SDRBCewVWlc1jLBC2Rsg1jvpDYbOLllEGFzNzMQG3PSLfCQ3BhC4VxV4Al6CpD8nbmditoSvrrvKOPHVv0XaRRgyu5PplowTzcOC3/enRBKdL8Z8jHcJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMWFcU/HIBT4wivgjORs48if/eZDr42cFoKAvQrJkOI=;
 b=jSok9lzhPqx7KttRs5QcPYjBl5bkD4jC0/TLDrgedfPEJb+1x2e++6lEKtEfE+bQ5UtwkMAh4/zGLiRyRBLKfJARJjVkEYCW8O/4Os3EKLaKXOmYfiTPmcpG+bG+JxMfyPcu3E/wgtBrnT8n+f5BmsfaUH3GtGq1h0dx+cXpjgM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM7PR04MB6871.eurprd04.prod.outlook.com (2603:10a6:20b:109::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 16:14:37 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::d618:e9c8:189a:892c]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::d618:e9c8:189a:892c%6]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 16:14:37 +0000
From: "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To: joe.hershberger@ni.com, rfried.dev@gmail.com,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com, nm@ti.com
Cc: u-boot@lists.denx.de, andrei.botila@oss.nxp.com,
 sebastian.tobuschat@oss.nxp.com,
 "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH v1 1/4] net: phy: nxp-c45-tja11xx: use local definion of
 features
Date: Wed, 13 Dec 2023 18:14:20 +0200
Message-Id: <20231213161423.258870-2-radu-nicolae.pirea@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c0a5a0af-2dd9-4e49-bb4c-08dbfbf69a78
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pBXMe2W0BN2iFbUmei7AcKpxeYxMmWrMX+ref2geNL43KYnAKeVSG4zR2IJCzKLO4OOnL3hSsHjBWFns/eOlspqQcOqyhrGTnz8FdTeeWTmdWl5wnSsApt36JdrEKlVRv+dsoyzsIVq9WeIzlfmKcDZoAL3/mwlt1urVQ2QK4vITi5RJ0sVX8IBsi6labHHmbVEn++dGpfY0te371mfiaXn4nQmZL5MgjD9HTYTV2NiCP/uCNmprkXNcXDBaqMTUX1dCA+vS0cbwWZNmqj7E9Or/vTambl6XKcNwha1ovaM/NbL4ZlpkhtXQ1FWzuj5EvfQIYqdtshJ3L2dS6kLbvJFiLc4GoiiofBh+7gkW/iQdXL0mTlY8vVvoqSZGiIwrQ9KfyFk1XC4VVRu0b7nfXV8CCwsQBpgN1M2FR/PKjbq7rdy63aJqqxlbVh1gno3bGsQHz6Sw1U/16+3cfeVkkV9yeujcPEb77lxiDFl6XqrkbkV5Hhj/gMqYT01nYmSdf3dZ6BCAOh3LXmxQa/SWrMa3EMWqrLmr+dkrTZf6NMT+gC8uSHj/UI3qjNnHRibBTtyF0KO5ZeJFs5C+B9Aj59lWukLQJi6ghVGtTdRoqh1qiLaGVDPzvBhZPf/BGt/Z
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8954.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(346002)(366004)(39860400002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(26005)(66946007)(66476007)(66556008)(86362001)(38350700005)(83380400001)(6506007)(2616005)(6512007)(1076003)(52116002)(316002)(6666004)(2906002)(478600001)(6486002)(5660300002)(4326008)(8676002)(38100700002)(41300700001)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eTmmxqL7d3cxm/Xl6HwKB4FROTl+O8R47xfwcr14e42HgKNhDYEycHJe3uQi?=
 =?us-ascii?Q?Wmn0JgDUls+IJfhwXjXzzIHf/QSOzMta3GFcKVi2N9P64VeWGWxJsLhZ/abF?=
 =?us-ascii?Q?jZwUg0RS4N8fbglDD0kQw9G236O13AW9CuOAJxG4knC9gph9IbaNIPiwDIbd?=
 =?us-ascii?Q?Q2AeMR7ospgalHtBzFYIKcwwg4w+WUjqW0JgFt353TChhLddfFQbhjGy5A9A?=
 =?us-ascii?Q?dXsJVV3APw9ZRwwWnZDMTo75qIfZy8xRzb68a4WS22B22HJ7b3YC7+x/n2+5?=
 =?us-ascii?Q?OV6EIY0x59J+sqV0Bjri0hE7e46w5eW8DDw8sV2qqqCg/0tLfLPaRpx/0J/l?=
 =?us-ascii?Q?HKqMK85E0A/eTUNdwjY+JZq9OW4hz72U/x7hF7yLWGqgCE+Q5yTFU9VDF6sY?=
 =?us-ascii?Q?JkBy3Pc9IXFep9AozC4ohNlgZFRN6QnTkT4EsjNFVOlFcRmJRDpFezXDYtxL?=
 =?us-ascii?Q?Yt8565IpxxHYWySngh3WstOZ0d43y6WfKUsrHicW2ybkNxUKBclNrB2XwMAe?=
 =?us-ascii?Q?arlX0EGgzsCTaZz7fo+X8NgW25FyD3cbTX8BGAvb6r9y0w7UWiZEdjn3xM7n?=
 =?us-ascii?Q?ydnBPLW/tEGwMK92kx7K5/tQzQ3AbPSV8OqK2fBLShFbOOLObqmBphHYxLfp?=
 =?us-ascii?Q?SJVk6VdZ35uggokane0h9WkOsLHXxp20pBPm6b8I8NT06mp/SX6L3OpevzKo?=
 =?us-ascii?Q?4OKRdVa5sRlZOPwg12P+KShJ/oNJm1aLImBGvlg0nb5HUTpGI5JrzdsAAeeg?=
 =?us-ascii?Q?sC+YW6rGqkxV7UnaqhGSHiqWljh1oJqBxO/ljivJiWJC6dCPBLcPVGjottjF?=
 =?us-ascii?Q?pnMwlBoT/ciwzmw659gu6YtG0PR+K1FDSu8O6T00RAS+1LpcfdyNi7giTRVS?=
 =?us-ascii?Q?J0H5M1Er5lCG7ESB9gIK2qUe++wAfIWvjiMTFLrtriVZEp1r7s0AD4l+9cJS?=
 =?us-ascii?Q?trBH/BQI143+hT6jnubVGVIeXo2b7us3+cIhtnK+5WGcWJgwTCEOSxZuB4d2?=
 =?us-ascii?Q?No492hexzDfJvx4wXBhNS3DWIGV+T1EBjP+w0YejtUln+Aqrf7a6z/gdUCf+?=
 =?us-ascii?Q?dSW8Qg8+2YwNvo0pjYE4OaCsHnwEeQ9E7E+rkXPK6tzI3T+ovKqMgpUoEX25?=
 =?us-ascii?Q?Q/rPqTdL2+3wqmLBLi+5KSMpdvZbE6hwIbkOSB2JiuSMZEaOL96Ly1IJAK0K?=
 =?us-ascii?Q?yVyWm8uXqq9Hycjp2TIcQuOonUJwttC+ge6eRXMpoupTinNUQRD4LVDwUSpJ?=
 =?us-ascii?Q?s1Z8JgvnOvoCGeXbmzpIswbrRTejPloqmYAVTmAHRWeLUUHXvhWVQ8HYvPly?=
 =?us-ascii?Q?tNGcefVqYDGVWyz0DfSBRebPkYXj9bkjQIY6riYbNviM6F8lw3//hzKbXoS2?=
 =?us-ascii?Q?9jZ/Ngm+AMSJ5avwHhGspNUmvW2Bt2H3I5vfWAgueCtm/t3MzIkIZ2IeEpTP?=
 =?us-ascii?Q?VHD0rGtgVEbMDwvXE8z7hxaRdsrifc13o8pYnU3CjRxLT3SPpCzxHI7F+JcL?=
 =?us-ascii?Q?4rywcCWXubTI62EP6c3uAHpSQgQrBgEjSCSPYkTSgaMjqFC8SVaN4vVgLnqy?=
 =?us-ascii?Q?QffsSedJ5XhyFGzvdYQHJSA84HXW17ZBUAJdWmvcLKtTikjI29ZfkO2U7+gK?=
 =?us-ascii?Q?sA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a5a0af-2dd9-4e49-bb4c-08dbfbf69a78
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 16:14:37.7167 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ziHecBeVI6vHz9CZo5aUqjPBdsMyF+UmvIGwDwZHPFeWPWoGMgb1gOMUoLjmZLOzPPvLEqaWg/2e+afwdGqV347Qrczt6HdDOa4juo1xtRI=
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

Use a local definition for the PHY features. PHY_100BT1_FEATURES are
not defined using the 100BaseT1 bit, so keep this workaround in the driver.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 5 ++++-
 include/phy.h                     | 4 ----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index f701790194..38fb38b9fb 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -330,11 +330,14 @@ static int nxp_c45_probe(struct phy_device *phydev)
 	return 0;
 }
 
+#define NXP_C45_COMMON_FEATURES	(SUPPORTED_TP | \
+	SUPPORTED_MII)
+
 U_BOOT_PHY_DRIVER(nxp_c45_tja11xx) = {
 	.name = "NXP C45 TJA1103",
 	.uid  = PHY_ID_TJA_1103,
 	.mask = 0xfffff0,
-	.features = PHY_100BT1_FEATURES,
+	.features = NXP_C45_COMMON_FEATURES | SUPPORTED_100baseT_Full,
 	.probe = &nxp_c45_probe,
 	.config = &nxp_c45_config,
 	.startup = &nxp_c45_startup,
diff --git a/include/phy.h b/include/phy.h
index 27effdb576..e02cbdb58c 100644
--- a/include/phy.h
+++ b/include/phy.h
@@ -51,10 +51,6 @@ struct udevice;
 				 PHY_100BT_FEATURES | \
 				 PHY_DEFAULT_FEATURES)
 
-#define PHY_100BT1_FEATURES	(SUPPORTED_TP | \
-				 SUPPORTED_MII | \
-				 SUPPORTED_100baseT_Full)
-
 #define PHY_GBIT_FEATURES	(PHY_BASIC_FEATURES | \
 				 PHY_1000BT_FEATURES)
 
-- 
2.34.1

