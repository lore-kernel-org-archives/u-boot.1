Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50888CD5BB4
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 05:32:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8CEE8469F;
	Tue, 26 May 2026 07:32:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="lPM9bpS1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06436846C0; Tue, 26 May 2026 07:32:31 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D75984659
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 07:32:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UweS03baGPi2e5EHfTo+RwLX02ubNSa21W4WkshA8yjfj+zYn0HiEjcW0wE/cgEFkdvX+Vwoca2JDVxNrZxnJK37T9m1IZrC5Ff9XqxopsvImjdgh7Z8m/c345LeOp1J1iGcLi6mVCtO3Ykl+xOtf6Q9bUCE3YG/aPY2g6ml8UBCXOkGxGaIleMuNI/WGcE2C01Q0Ft/9fCwiwVJ6wCWSBt0W2Vf4EYVKcMtjTAfGu120c5UND4jutCe0dKVL49d9OyZmXydz6Hi/RrM6I2nVZFEigoSUYh5tF21p+Eifbhp/Lrj+jXZivavfOGXZrCtQp7ItjDmMD+b4AB/ZlOdcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agz7kTft9AknUSN8wJh6GUlZBFnBrBopfCHF2T1wTGk=;
 b=R51H59/RzPu8PYuFYwKezmPTaQcmGrGwMU1eQhoKAiFhSZPmPmKCRVyrFtUS9VbWQFUbpDdfe3qZyODzUGCXhjEdh7xV6gpQE3DmUBxsePpm+FQmPpRtJ2aMpYGnxYKuKHjH5sQiyjUylV+0qjA6pN3IATNYUW7sccTZobdxQilkQPQIWrud7afDL4D+q61l4SjVfiac53ZMaXLThMfFX9xhIu1eZDHX9zMBNxbBszyHl27PqvaFHijpWhsh8l/Tp0smuXiWGmYfqWzFFE7kGncKVg+q1TZ9rFds9BjuoD3uMmVrMfg1zzeCqo/i3aUYbAJYCSNX0OB2uC4mHtn3CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agz7kTft9AknUSN8wJh6GUlZBFnBrBopfCHF2T1wTGk=;
 b=lPM9bpS1fkHGQ83RiTHRKflMWg5HelzEHvjmfN9P3ky3FOyjETEpJXNktE8BC5xEvW6NX1tvD8erH+O9G/+WsS0eNL9qQmnRCLHFag2cWGaCYuLRK8S3dgM3DgeMTgXNDlpjUwguaN/Q5pgIm5wJJOcHcKrUMqj4+aNEkixyf94ySHxHS0KXpL7rFXFxdWPf8iErBGLc7uFj4M/0E/mRV62Wx3VOqglZQngtkKz8QAuSThCVspFFf5r4IYEFEhopK3tc4eG1OLN4m5SECrnQlNiGeB75SO/g/6y22khhjFdayCr+eZg7oqInu8DLURgyOybSRqfzRneTNduKvMzU2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AS8PR04MB8295.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 05:32:27 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 05:32:27 +0000
From: peng.fan@nxp.com
To: trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] thermal: ti-bandgap: Use dev_read_addr_index()
Date: Tue, 26 May 2026 14:49:09 +0800
Message-ID: <20260526064909.2741888-1-peng.fan@nxp.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:295::16) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|AS8PR04MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d1bb0d0-2ff7-4db9-a3a9-08debae82c53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|19092799006|11063799006|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: g2PqI0sraC8mxBaAUcxbkiivSv5JmqxlrVs1fBpKS7myYpURaU3bImRU9oij2n7tFCa6HywvsYoY9U2GVj75Civx6jHiX9AhRZ/MpuCiCvghPKQQlcit/l9SZ8blyhtWmX/NHE2UoZAWxsLqnyrotYU2XIIXLR5D2rBzzkgK8C1upgLLum6378B1ntsbb0BNjEJILT3SV7Pm+cCYqYgHzRLUSDoOpxcpQLoANWNtxeEvaoqlbmTF1fMvu+/BBoXU/JUBIrmPOmDh5ib3vtqsCizmCwwkaiu6PoPxnuQDFcZAKo21+Tj79sTlRAszoRFhARh330AnPY1bahDP5UEjpnF0k6ltvHOmACKQuWYZ0bRlWZt0h/xfp7icX/1i6b0X7ImfiMInXGoDM1It4BWeArw9qUqnpuZadfR4ZF0WorgRj5JieFF2JFixRNWcrzujt2Q823ACQXVQ1vay4g7TFYJIJBymhaWmz/zZU0+8Z00z1B20VhCcOx9rggQAAdem00em98czDuV20dXjq0uTs4JS9orS6aBMNrUT8btC8cZ9EJDAVgArlFif2T7Gqx4BgfY+aoU2POj5Cls9HL4bbkH8RogjDBAlU431xNKHTuIv8bxvOuf9nquclkBe6AznTW4/rYv11pnQreP0jVbpLTIxABwXJzwSbkoXtmFL5onQh4MkWl8vI4xQ4TNVHrUSW2W6NeXfUQvWB/gJqdTYGTjvwOOHXwC4WV3psorfIK4/My73ieHik54pYq/ysQaC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(19092799006)(11063799006)(18002099003)(56012099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FMHRxGkVYTewHmYTU8XX7+qrwrEZZZCwpPvJ1rIDJdOg6n3Hu4lECvKjIw3n?=
 =?us-ascii?Q?Ig5ySWzEfRalENe+BOZxrdBumnIDztNjmDJzEThlr96P9Npx56o+iuH7FAJY?=
 =?us-ascii?Q?S2AiMxYa5aAcmL6DWzJnYsxVSPGJEaxG/milZGL9/cC6kjaIIjqTjKERCUlp?=
 =?us-ascii?Q?Fvz3mVm4u/ja9K40bu+cgyLc1XcTcAWYYMcQhbUV05JGIqWgR6NADW4m29wu?=
 =?us-ascii?Q?obo/N2cLSl/LypIUapQmzGs9g+h2GxUzwIMuUq0hkPGacGbvNbc8faTajCUC?=
 =?us-ascii?Q?zHFOrK4z+K2iGdmTmBcogwAElXC0RlAHj0Q19UBIM3KrnczHbIcSAzKiCZ2a?=
 =?us-ascii?Q?D4xxYO38T4hz64md48FGovvomrDWcClRLpuwDgM/1nIIycaVqOL1bNrJ4dUJ?=
 =?us-ascii?Q?xi4XqpfWoUS2+cDwOLmljsWfpSQVy7Dy69YdDaGnjQqP1hUS7LevD3g5LAu5?=
 =?us-ascii?Q?3d+EeFq7r80NjszbZ7nlq2igXmuLgDOuAoXLDN8zh5AkarwblUUax83x19UR?=
 =?us-ascii?Q?ZnpsHigtH0MM3RoR0nlSZl53wk7NyWJQR2x5/Kl+iN8iqbf8zgL5mSdJb2fH?=
 =?us-ascii?Q?YsDQpX6KN0PdjaPRaFNm9uxJdFdozkSf0AiuK3XPiZssSX8xM8sfwFNA9bmz?=
 =?us-ascii?Q?mDS/Vh46RRkucU2oRyheVhCE+b4GCjYpGebUtoSb4Dq7ukSdD0cWBsIdmxiM?=
 =?us-ascii?Q?kiDvySv/L5RFkCvjkQ0HXgrpmG23jIoT+yh7Gsi6VngsgTqk/hZAfOwPgYfd?=
 =?us-ascii?Q?zDgV7qt7gnfnUPnI9MJYepMAo1+gW1Ry4EOzFk1wyl29CuhUgKCSuu0g1Q67?=
 =?us-ascii?Q?AJfww6iDXg44u5PzO/O8+oioAEeFN4O4AuNTy8Pt/ohW7p/LA1UQ9g3sawIn?=
 =?us-ascii?Q?W3J7dBmexpES8VbJHeoExolkqStvLSxdf4w3pft40NEh6vvQOmsYwpzDeWuL?=
 =?us-ascii?Q?RQH0dOtrHsFFGfUvyGEOzz+6kCTwaiG7haLUOB2gEsyJyfWbwC6Pcs2cJxt7?=
 =?us-ascii?Q?9b5fGJ+5UGTUoBFmFCOv2YRUQrZf+sUfBcGjOHOrmtFoOkAOMurSImq226X1?=
 =?us-ascii?Q?p49W+/h5Y1wlLQu9QhnJ90QOKmNdjgu/ZFqqZrl1YimtPBCQDDHUt9ScDgFS?=
 =?us-ascii?Q?RCeiIWzcmlX73YU5Di2F4cLZ3BBWp3wpPtt26+TF0qpbWaxObNhnLALV/2kI?=
 =?us-ascii?Q?3Nq7iL8+VZHaIoahTpsH1e3rmEG3cwMGR8O3VqQfnr5faXeYvqgW4sCKMDjC?=
 =?us-ascii?Q?PtWvL7e2c4zj1ZlxMAm9GTQ2pQ8Zii2a3rn/5yI56QDIyTUuey6bcazZZ886?=
 =?us-ascii?Q?exxNRrLSkIPT3mn/PWqH6iU+mIvX40qCmLLt2vNYRZTN1Tbk5Frrjg3HQqCn?=
 =?us-ascii?Q?DCvEJI29VNZyEn5iV2dw54HQ1CsbJF76jvQkYKLFYGq2z9TQ7qaniSpjc9q5?=
 =?us-ascii?Q?IJuQMXpnd1ry5IBnJ/WyMnHqR6O9/akirJ9UG2byR1buTDfxrC1Ap6PLHsNK?=
 =?us-ascii?Q?tNw/StjUufwejv3IRN11XlVQ8CLhBW9jGIzulfMwNYsVW8XOBDPXL3f5JuJi?=
 =?us-ascii?Q?2C81Dugig1y2cbAOkxwkfY+htqG231rkYt6xtX2BAYsgj4GVjbNe8Te9lStM?=
 =?us-ascii?Q?JUxY6at1Ulxd0PqhiCGIe7SdqIl6Hp+DMt8DiVfbLquOCyhnXH3TZRk7LXB8?=
 =?us-ascii?Q?QRxFLwtj4kGyxObQuLcNeqSxm9YK9zBTtuaUrdSOVuBVkwGfkNJjH+1rGdHJ?=
 =?us-ascii?Q?L1SUX/DUIQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1bb0d0-2ff7-4db9-a3a9-08debae82c53
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 05:32:27.4648 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XQqwwp1LTgd/QJ1/hRKs6KiA3uQVa6dfP/4HviExDmwleA+6OmdsXOmmu8u2jIXKYzXt5/qp3053gV1B57LUOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8295
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

Use dev_read_addr_index() which supports both live device tree and flat DT
backends, avoiding direct dependency on devfdt_* helpers.

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/thermal/ti-bandgap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/ti-bandgap.c b/drivers/thermal/ti-bandgap.c
index dc869f108e4..643971e12cd 100644
--- a/drivers/thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-bandgap.c
@@ -176,7 +176,7 @@ static int ti_bandgap_probe(struct udevice *dev)
 {
 	struct ti_bandgap *bgp = dev_get_priv(dev);
 
-	bgp->base = devfdt_get_addr_index(dev, 1);
+	bgp->base = dev_read_addr_index(dev, 1);
 
 	return 0;
 }
-- 
2.51.0

