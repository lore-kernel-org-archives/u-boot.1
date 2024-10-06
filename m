Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2660CFB424
	for <u-boot@archiver.kernel.org>; Sun,  6 Oct 2024 09:49:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D5CB88965;
	Sun,  6 Oct 2024 11:49:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Zft2+qgT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FCBA88D08; Sun,  6 Oct 2024 11:49:18 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64D2E87C69
 for <u-boot@lists.denx.de>; Sun,  6 Oct 2024 11:49:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kjhg1jDuQMGRpXolFAz3qUL9/zigqrYn5q7udgGWJEpJIkIWUWbnIlj0tQmeBSd3Ajag5bx1kh21FPT1HVLYwayjOenaY4FspOHPzD0EJNr0HPp9pnC1BbmWs2PnhtI1/UyhYwGQfavc6IO1Gfz6/oU7rz7Vy6CRFRxeB8Hunf5vBIPh5KNd+GOJSXD4g242zjuZvIREJfLLF5iqWjMJ0mjeFJC7A04/rCvnG5qTvsUXkuXA9aVrLo5HGbFg2JARRd06SC7MPVyu9DRA5tgnPqbzFCe2TZzjrMinOIQ3f+fObNt7xONs0dEY51jO3wALQz6RK1VCoO24WBFPJOwKUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lg8+9vMwu/G5EA9bTjXsEPfU3q4B7AahHbVKRazJ0Hk=;
 b=OvIcSg8MUYIKXzZOm2+SjTZZjBtoFPXXm96EFg1pWjKCTc+tqCQ1rD0r6lvxFlqoDmlySmMh5yva4tFKGNG+7y5FJ2dNPwpPu+ftqQCRe8+auoeypW3TAYYBPaZkPm3Y6Dxv9vTQrMPRZAFfIER3Ngb2ytpLPOmrb15JZiDfHtfTm+WwnE+nWuaToWTHQGchG09Na83v2urQSAZcx533sgo55N592PbbZSfL1ikoTBJUCfImRFSuF07nySxX/945KevTdYtdbETmo5lW40MeP2Sqx5snUn65hcTsk4CZxQeY79ETL5uxEDxzKfXEjyDvPSWNMJzvzFVx8w7oIgQsDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lg8+9vMwu/G5EA9bTjXsEPfU3q4B7AahHbVKRazJ0Hk=;
 b=Zft2+qgTDPbgFV1Vv82wQlLBhsWIdVflsTPt4V9tPzIPcRzF+DHq6QEZKdinfAT5cocvKkFzk1WPyFo3YambHrolIKgpw6h6BEfArc2hO6VyjG6X1cjfEgVnQXEiSsVXDGlyqnwwO0R0se1eQLrMYGh+7eAe6Xoy4pp0wJ/pigwpPZv5tV8EHJhpk6cYNNX2qj8JNcFHJBvhUjkw6KI55CKQwx4Y5Y8dEHlantG8Fsb+srJ8Z/ND/FqZwyU5Kva43mxLyyEr9PzMSB3slrO+ZOtzjd3Il8dlcMCJPsCGIQ1EZTD/NtuuNg09Eqn41t9N1xboX0KWpU0ZCG08fJWufQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS5PR04MB9769.eurprd04.prod.outlook.com (2603:10a6:20b:679::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Sun, 6 Oct
 2024 09:49:14 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8026.019; Sun, 6 Oct 2024
 09:49:14 +0000
From: alice.guo@oss.nxp.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, alice.guo@nxp.com, sjg@chromium.org,
 etienne.carriere@foss.st.com, peng.fan@nxp.com, akashi.tkhro@gmail.com,
 festevam@gmail.com, marex@denx.de, Ye Li <ye.li@nxp.com>
Subject: [PATCH v1] firmware: scmi: mailbox: support probe in pre-reloc stage
Date: Sun,  6 Oct 2024 17:48:15 +0800
Message-Id: <20241006094815.2800493-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:195::9) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS5PR04MB9769:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cf39f1c-90ca-4298-714c-08dce5ec22ca
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FASdZERFjzGzHCeLYRlicfCo7VlRm9TepHbdDvsIClHbZvg+Z/wk4eQo08Kx?=
 =?us-ascii?Q?4nmFZAEcf4hWcEF9UHDKncPK+VVy8BRcSRQajCgT9xzeyeocCceap7/BoPn8?=
 =?us-ascii?Q?D813iItLpe9OLShRsYwQKR5+Z1odOA08+0w8n6kr3381NHgJmJ5Ihg4ILGSF?=
 =?us-ascii?Q?uP1/csSrPehir4SW0k+kl/JpF2G7gRiuc+9ExjKwZCNTMFZtdywE2CC/uTi4?=
 =?us-ascii?Q?bq7HF/Dnbj1VXLaMJZkFai7vOot9759nCw39tcOzvFN2DRxRvdldbwJxkXX4?=
 =?us-ascii?Q?HfUAQoiKqzMWjDw2VW3GCtla3lDWNqgGg8h2ykkuboaSOhckhhcqLK6zQmqn?=
 =?us-ascii?Q?Q03bywHaIoLmv/k7exxzMjNNwnWZ//m4Tg1Ld+BKhkIYXRCbD3I9wNwRfbKO?=
 =?us-ascii?Q?xkgyQejgcQWnUW5SvQ/IE4aZi2CLahf7Ge9+Ytz6B6+5uin4PmrpTIEGWr24?=
 =?us-ascii?Q?ww00W0tFGawDOJkWsifTNMmGnSmgFAfLRSqBCdfWisPEZGGXLbmQok1eFRX7?=
 =?us-ascii?Q?RsBC4NjKEZUYPrT0pZ2WLfMljz9FjIaJ3KLFFkwEf/3e6dU+RPeUlsnrfAB6?=
 =?us-ascii?Q?yMYDfZ3DlQRpgekZ75fvwXPv2PRVotiXXm5Ibjip7s5+c6O5nlu0/ug9f/Jr?=
 =?us-ascii?Q?MYviOb1B8srIsEWrclkxzv8F9fvN6udprN/tnUfNr7btk7rJ8gR6kru6U0H4?=
 =?us-ascii?Q?kItkvp/BbWFDcl95ujuv5x18O3/vwYzHHCzsEtuEg13McFb8DSgx5TIdbVpp?=
 =?us-ascii?Q?CXVB0K1yS4ewwHvhER4fx+FmGMddhrNq5M21cy1cAOT+2oS0JpXsA7QOk+JH?=
 =?us-ascii?Q?2+ZVRQ/ZRW5w7UVzqW6nB5dkFgBz5Xq7Y0xYj9tdi9zEXsIky4gnUWMXTEHL?=
 =?us-ascii?Q?jpLjTclETiPIkrVrgRvsRmqfbuHszjN3NVlezs6g69fDbB3nDfA1POjSl/05?=
 =?us-ascii?Q?AjA5M+2OIOC7O4lNelkcepQvnxbEZF4RApXWpnitOBNY88KhL4Mt37Qk4Cr9?=
 =?us-ascii?Q?PFIEeCdtmwoA3TlThBVomLG78nS+5m1EZumvrhhX/I7/spJCi3eECeucMcc2?=
 =?us-ascii?Q?dZujapglyHms7MgCYnfKzupquflYO7Mky0D4iztOKZBI8KrHNHTFyNgngKkb?=
 =?us-ascii?Q?E6raWlWixkMNszu3Hr/BHYMlu7iKu0MbksjR0d9vcfav6rI/JwfA8P1DQleS?=
 =?us-ascii?Q?y4O55N8kF4vzDYhlhKb5QRNrF6iooJylTtBReSUJy8gRVf3Jp30XXasBhB74?=
 =?us-ascii?Q?Irj0pJwTHxeKqYu4WfbqBhGtYWwU8fYA9pyJ2U6DvNEtx2vEaQGQBoY7GOGK?=
 =?us-ascii?Q?JwMNVFRy6AKQswBVRKvRONc2Datoe/wj9ylMDb+muITjIw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lhdlUmi1ITSE/es6RRnqQE1NrUbt0uN8tOnrx/UFMzOsRH5Gb3sRiIvf7b1v?=
 =?us-ascii?Q?SHQEJlcV/Sjw6g+IzGD8jj2IVpmU0vUmCP0VMLniBr3zQdu+0hjj9dX3/RaK?=
 =?us-ascii?Q?XjIEARDwpEHUE9yul3qqCIIxaRbvyl7pPsOob70PRBmQRKlddG6ok3DFLY7l?=
 =?us-ascii?Q?IdUut7D/Qz0bmE3x+V58510ykHkWg2gjSl0mgov9kTek/rTGRMqDEcHK6fGv?=
 =?us-ascii?Q?dmCMMiGvSV8mPg8ZOOJYhstVPZj1LwkhwTKfvTAVz5ZZtHLNxTTVvKiQ/hg6?=
 =?us-ascii?Q?pWJpe2IUKb90vjVyX6le/PntruzThYSv+spZ+E5j4qg6fbi0lA9ezsw4pGon?=
 =?us-ascii?Q?9QezLpnHnQbgY+py/SsHHjS6RZg7MIVcVqxDjv81yWkzh62RkuPDohlh4Y1t?=
 =?us-ascii?Q?7JWy5dvPSXMcxji2jcagja8qyd1y8Iiwe8m1qeTx3lxiHxcbwSKrd0J9L43u?=
 =?us-ascii?Q?AXjkX8oNYlJf141ns5dLtj4cY1GsosP0hP9N5DWkUhDLBs+T2X+uxDsno4Yp?=
 =?us-ascii?Q?Z59PKSwqToEUZD9aLsBhrxppQzKkF6eTHdBRc8tddrm0sqJBct18HrlJtA56?=
 =?us-ascii?Q?AeK8P6hn1IcBE5B+G8fAyDuAFQ3Ke2kViFVCFRyV2CeiuXRMY7ok3tDI5fFk?=
 =?us-ascii?Q?q08OmI1j2hrwx7D+bukQzYTyAmzCnpi43lF18Ml8l/mHEbiJzdnvTtoOQQyd?=
 =?us-ascii?Q?OAZa+OfMLygrRVW+FjLnA7HAxm6tPdZtFdijqSoi/fCnqiKVAGl1TKW3gsNn?=
 =?us-ascii?Q?45UtdSqqRkntduD8DotvfpPmXBpO2fACOPfDbeKN7kULIQHOsS/JuzKR7m0J?=
 =?us-ascii?Q?KUNCK6Qx4Ni3eYgrrdWTIvjcMRb7P5ySiXzRqxrCEpLId//aXnUFbP4YT9lI?=
 =?us-ascii?Q?NSMqRxWFuq1ykpwqJLVtEVOOOGC/c9RHjRB8Y9ouHZRa/K/ZX9GmroYDVd3v?=
 =?us-ascii?Q?aTlaRJQZZ6HdO8P7OSuPsEvMyIQljuJt8gvhnMdvXIwY/19vz/3lqYXEbd0L?=
 =?us-ascii?Q?zwfzVTiGTZjLlmKOdo6z6VgREOkPawpqjr1/TfRg4aNjbWvI8zZw0bA5a5K8?=
 =?us-ascii?Q?/XMkVqPZb21I505EL6DMfo+mOykN4AeRbfP5BBZC6++fwCsvpEIvK3nEHvN7?=
 =?us-ascii?Q?fBCpHto+uRkRrAcyGvluvA2VCUjyd+4MXj1fZemrfOV+DcnfgmBn8RPn2RU5?=
 =?us-ascii?Q?LA6lV6CkGzE7zg41cIvI2RIeYciQSIXBq5tkqb3D6a60ZqGvx85ZPQorp1/m?=
 =?us-ascii?Q?zjaEdITjLA79tzgl0M8lBLw6Y3QNgmJfRsWNzIt7kFd8+6Fyt7bVBG7QGXBi?=
 =?us-ascii?Q?YqLbeLkadO+SOi9O4OawQKQFQpkLOtz+C8U2qeHAsQShuURF25JbF13w7gD3?=
 =?us-ascii?Q?SgTWWpCHkA2PWr4kpPPSIOy0Pyv/k+aM5QLKT4AUsvxJCCjGlUbLcPorHhlI?=
 =?us-ascii?Q?kawHqdhlmVex47q02vR6YxkWbFoqQdhiGP9cz9wFOvUV45cVyNRhB1wThm50?=
 =?us-ascii?Q?5rMwykEydSD4IWYWjFG+s7z1m1c5XMNGzZFlOtuZO0FubfI8NPXnMAyv2Pzj?=
 =?us-ascii?Q?sZXhQQmGFn2n4z0dTzMxRDCe45ZZGQnwAG050tnV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf39f1c-90ca-4298-714c-08dce5ec22ca
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2024 09:49:14.1305 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rK88fb4bwMBxIfCysxXREdH8kn33CFW7sI+3s3vEzXMPeUiuAoRUZmfA8bi6x7vjFQo2s7hCB9L9aJT1Rqh92g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9769
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

From: Peng Fan <peng.fan@nxp.com>

Support the mailbox agent driver probe in pre-reloc stage.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 drivers/firmware/scmi/mailbox_agent.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/scmi/mailbox_agent.c b/drivers/firmware/scmi/mailbox_agent.c
index 6d4497f4b9..b024b1d32b 100644
--- a/drivers/firmware/scmi/mailbox_agent.c
+++ b/drivers/firmware/scmi/mailbox_agent.c
@@ -147,4 +147,5 @@ U_BOOT_DRIVER(scmi_mbox) = {
 	.plat_auto	= sizeof(struct scmi_mbox_channel),
 	.of_to_plat	= scmi_mbox_of_to_plat,
 	.ops		= &scmi_mbox_ops,
+	.flags		= DM_FLAG_PRE_RELOC,
 };
-- 
2.34.1

