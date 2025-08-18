Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4BD0CA0EC0
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 10:08:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4813682BF6;
	Mon, 18 Aug 2025 12:06:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="pxFUbJpt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0721F82BA7; Mon, 18 Aug 2025 12:06:48 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3891482103
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 12:06:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=py1SzHhPHfe4maJ3xr0kuMPUv0y72l007OIrEEFyZX1q/V5Z+QVfBSO0EN1Fl4BBC7t4ZnrFnBg6PxCs0XwPY6r27Kr8dc3LUzsgObA0npZhqFTMH0aQMQdCdQAL/SvF9GlFWE8QevI45OhtvMwrIZmzaAp4Vl2BwWWdwmRuIZ7wmR+xIUathORKxok+wFmUKEuT1CrZ867M1L+vn+09Xq+Fw+GaG+Hyjpxs14ZlWxqvnovrG04p803+hAaf02Oi66lzb/S9D3RiXIEKg6vUVsHOThqf+jUkauks/CArxMdQX8nZjBn1xL0VF7djbWZ5gi3AWaQ0LavNpZKF/Qx0Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEUOwTKDG92EiocRfKwLJN+MuO1K9OQy2ws7uj6Wt6Y=;
 b=iva6iNiapeh+7ymhg80/tSmSXhmqb0GKtdMzOFl9ayqSGOmEIRzITt6/ERxG4qtMH7R8vuF7zkN5VYOQx7uBKdfi8jcG7GK1qUwyqvrR3xGVgJF6488wIf2frRN6KOE5c0wuVlFOWFIwiVM3P+LRkCb7VjRK/cc46MhlXORI2DAr3KZ1OKvJSJyngipCXZuzdHSOc2cZAUxEF2C7EGaCXCwzXM63eNgzfWUzWQTq5SBsOiXAKp4AU7pv8Ets84ycukYHItFjF6LWod6ZShxWfNudV4421CB8tvJ7zReXlh+qr/kSv4BqGTY8ijRIIpzvmM+mFSU+beh0Zrw5eNfISw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEUOwTKDG92EiocRfKwLJN+MuO1K9OQy2ws7uj6Wt6Y=;
 b=pxFUbJptocSJ1stOkYH/XC6lNYSytn/UW4KkQ67u0tpyX7HoyHBvMmsTZPMPy/ePQlA1tnQEJ1UaW/VWaqlY8bRyrq7PuqH1HzoSUX2U7lprvEU5+NW1pBLs5Fi5LF8mHlWbijqinp+breDol6XzXtwYHTLI6UNuvIhtbihNeu1WKkbrNfosRlnQh5X90Jfair9OQM26woco5EiRrT0F/+4xU+/neDWY2TiSAurZ3ECH65DZjx9N8WYkUo40KU8v+QCre6lgkUY/MbMIqLzsqFvQkhvrinhB2irmMWXjqsp8E7LAB2VPNhz7q6qNuo7ASMaraJjAFSfYQyMVwrFAeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB9719.eurprd08.prod.outlook.com (2603:10a6:20b:615::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 10:06:44 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Mon, 18 Aug 2025
 10:06:43 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v6 13/21] mtd: spinand: Remove write_enable_op() in markbad()
Date: Mon, 18 Aug 2025 13:06:05 +0300
Message-ID: <20250818100614.432931-14-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002E2E.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB9719:EE_
X-MS-Office365-Filtering-Correlation-Id: a7fba77f-da4c-409a-01d3-08ddde3eef1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GXAvLR1+IxBDKRmEWK6OjFt61zxuLu8AGhqsy2KNK6LaHkDTo/SQZX9we+9V?=
 =?us-ascii?Q?n1ifGLCOen3uKZBF3xVz1b48Xy4DAzcDgX/urczCI5DuXcSxkJZd5GKs7tMX?=
 =?us-ascii?Q?wyjYEg9mi2fYmQxtLbmCqGsFVNc9lK02EWV2beObj25X8SegSQqrjhFKP957?=
 =?us-ascii?Q?LrVvO2sUA/Vrc72kwpC36jJYhTRyL+iROGX76JU0QKnhCyroecXT7oyU4W4F?=
 =?us-ascii?Q?YHeH/gZ/zsH23BHkz+a3dWeyBFjlj84iLUhK0eF8ZeT2N5QCR+FIM8fq41WY?=
 =?us-ascii?Q?CTOILs0YHuPcIw5N0ilWkdjz1Phffval2LV4coNdE1SpKlqj8GNjDECLaLTO?=
 =?us-ascii?Q?xGUMbnh2ZIKtEGKO9l7ku8Svac+QsY7cbZCIivGt3Qvp7gHazU/Q6McrfKdq?=
 =?us-ascii?Q?/alJACiyYALt3VLf8HVauQzbH7IDFiE/NuEoe2m+f3mJbx3/sM0WTb3lbjo7?=
 =?us-ascii?Q?xbiK03NK2M5Ac2FGk7vEcjRm5S/ywMAzH9C3d63us2gUP666xcy06/kaTbMn?=
 =?us-ascii?Q?DiTe3hCbacju73tj6IGg41IWVP/dWq3AA36kJWh7ACPfDvwU0me/CVCZGYKz?=
 =?us-ascii?Q?B1ZddqkulS8utwsnBpQYP6hHEm8O6Bnz5SisFoKvq263tTBWAW5/JQ/fRMuf?=
 =?us-ascii?Q?gXm6+vjCFwLUO3ANnsZcc5bXuN7AJhkFiGGziBdPfFtttIum3JaBMd/asWCF?=
 =?us-ascii?Q?mcROovq8XzdV/h4M3psNhvNJ3HymcnbqYr7KxyY3oOTrXGWmIEoQhJ87//c6?=
 =?us-ascii?Q?YKsgKZpImYTzQIJi5Th75Eb1glEwL5d/SJ2nzSg5Iqy64rAPlGxS3j5x6CZO?=
 =?us-ascii?Q?iNWw0ePn6RSZEd4FsToNXiTQgrVI4WpCIRcOphHRfFW9U1zJ0dasAdepJCm7?=
 =?us-ascii?Q?nTE+Era1txv8ox4nl7/Txx8MkDBtE8PZy58leJKRch8t/S6DcATAsXPF5RVc?=
 =?us-ascii?Q?G8h7r8aMuxQo1EREi0+FJxUnWnsZRO2yoguN8Nu+cskaY4558kqnEov7keim?=
 =?us-ascii?Q?NKpnYf4lX2Uyw/7wsjJKBTnI8LIP0GQbsoSR5LtX+QBrIjnqJzaHVlcU5s+N?=
 =?us-ascii?Q?4lUMwy+d+3yEPTRyHoIW3oZQWfAtFIm2YVtTHf2eqNavKb44Jo+ZruSzx/eL?=
 =?us-ascii?Q?tACgtyRQAvam1VMPfg4SDT0MulPLi6mfGulu96khXe/LI/rOi48po6GAQmAf?=
 =?us-ascii?Q?HlN1vBRrpZN82CGWSBuwGM/qkCON6TbajWhgpih78mYbvZB/6Xo4uU7Ox/wb?=
 =?us-ascii?Q?u+Nv1ZtMoEBNqI8AV2tOm38oA8jv87Oi4P+GB9ymQQhUWvNB8jANXVkqtgtU?=
 =?us-ascii?Q?67wc57nZz+clkOBCwyXb2nm9AZh9TjAA/TwgVypot5zTsRMvqeYu8QRvYPjt?=
 =?us-ascii?Q?rZXLA4/MDV9imKZW5jWwARcC3juxWgGQpIz3C9gJHyviwekFZ+zHnR7gMhZt?=
 =?us-ascii?Q?yb3fbuUvfH5jvrdwkGkVROssDy+H+I47nwzpZS+2tECXBMxEW9CKZqVdXTOU?=
 =?us-ascii?Q?KG+GzjbqwGUGTb0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5jj/ng2Tu6Ri+axMJGb4uXMQnx9/TyC/GZ3BOzviX50M7efurH8JDbMif+o/?=
 =?us-ascii?Q?RjOo50YHxrg9Ofnh01ic6CAADwm1EZwcIkBZYNhxfkHQDd6ZdaHvrf9bVc/J?=
 =?us-ascii?Q?he5ZKg7Lh3Ho5NapZ8N33QeQwsgYag19F00KEGhtz+iA62SiRKy50riYs8xL?=
 =?us-ascii?Q?c7R/uOpwpb7pCe0IL0iq9z1z3njc7xnFBdlRs7W3jMu6IaCaZylGglf0r1s8?=
 =?us-ascii?Q?g5GAixmd++QEeCe7a5n2qmjfWr3MQBkSNts/0IdmVnhZlJ0N4z0IO8OKnZVX?=
 =?us-ascii?Q?akVHdxgQ2J9B+7V3N9MsWsgkCm3S1AxHCCquoyHKSgupFHS2RoI1Oqvl7i4W?=
 =?us-ascii?Q?4+USWMqXLF6NsAMJRgtXLOkfcEbibCBxd9UQ5hqDmbU88PxGr3J+JrX6QADW?=
 =?us-ascii?Q?AZWuKII/2+xybMyM+RVHRQS9fV784ToPOdMOjjfuZ1bRJ8g315w1z1C+rD3w?=
 =?us-ascii?Q?j0OJTwFnU7AhBdgpLDpQSGl4EIJrpWZVAEE6AMc5ULII35cjvzU6jMryBOxT?=
 =?us-ascii?Q?Nwf+bTRQqSxK/lhTSN5g1FRIw1rK6A2t7gFFyGmWw73YddpIMy96C2Q0MQLI?=
 =?us-ascii?Q?/gBiqDXrLvT06gPgsy+Sp6aXdqMYB92b5sybQyu7JQeOtNtumNPt9OqK95p/?=
 =?us-ascii?Q?QGhmvw1OUlmw0SMOFPWhFh89GuE4ZAin9F4BI1d+Sv5J26j/hhpE4W2im6m+?=
 =?us-ascii?Q?TWiyypgiHIpjIBgvJI2eh0ej9lx+D8ERksLbeWupMSZSWyHQWyIhTSsnNUiO?=
 =?us-ascii?Q?C0idqzjKMMa+ibOgeajIFi/GtDIYcWjYrC44PszuMFgfizvEp0CYT1NbtyKS?=
 =?us-ascii?Q?xTEJ8UkdoOnR7kXe4rBgXRc2Z59nbRSPvGpfQy70XP+mpT/aRnpCgC4lf2FB?=
 =?us-ascii?Q?n/oPOqtAnCVSIf8ColmRxPGshL4tXUpbG9tWQWFXXwLpuoLth/cpQC/GfO93?=
 =?us-ascii?Q?OuwR9GV48JiJhqOxPNRqFDU4TG6r1py7xmUma/pbxrXMSJMVagMYJxMd5xd0?=
 =?us-ascii?Q?2bb4qp6k9/UJjFF2wbbroGo9HN0Zn1CKWrrJlt3FEIekzCRjuEAW28iUidLo?=
 =?us-ascii?Q?B+nXWFh3W0OwKybRd45cN/mhs26JOtdytLnjhaw+Z2cNA1sLIMEHBlpO3ekI?=
 =?us-ascii?Q?KrfcPuW/+ojZLOySXOiLXWQxT0bnKpTjaoQnypFYXJFgUCHJmWpUip2Oy2Rs?=
 =?us-ascii?Q?kkDou4wGRAumP5MsD1vuESqWgPjw4B7xJhnLGAkuwe1VOvsouZVRtCHhp1x9?=
 =?us-ascii?Q?2mErDJJwPGkcCmKxXkeguhox/O2IrDEcWG1vWBBAxZHDjYXSJ8dAp/UbW/HN?=
 =?us-ascii?Q?Wj5ckkQlA9KN817TmviZf3yur42OxdT46qkML1Df0bjlYO5wBMBOWtUYog8v?=
 =?us-ascii?Q?anf8bnuTwOmfMed7bxpM7cC7k9WLD23twLQC2j4Cn4w2Sh9H8OVRsm+Eygx7?=
 =?us-ascii?Q?3ZLDfld/4yDR2RNk8kIfiCoXfkEoW+JLeKfoq97ngCtK3eUYC6le+tUvJpUF?=
 =?us-ascii?Q?mDRoD+jggIIPo3Hq9j4OYFRm9yWw7icT/h5Y8AL1BS4l3+ECHC56rxnsXxrp?=
 =?us-ascii?Q?MoiG1zOJF2XYQnLnYXqAbMj5srRuSU1CeGV0GXEtv11mS3d9ypDzV6nSGZIj?=
 =?us-ascii?Q?FtoAU+MpXrrsl6/tItOKOqk=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a7fba77f-da4c-409a-01d3-08ddde3eef1c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 10:06:43.9271 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 21pFd2k1iCpiFXk2IT93k5E4F5sQgAZSHd42WwIPvQFC2OD4hud1d6rS8wGm+xHrIohrborgUfW7OaKIpO5Vhe2lhFhf3hmk00p0s+c2Rec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9719
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

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

We don't have to call spinand_write_enable_op() in spinand_markbad() as
it is called in spinand_write_page().

This is the port of linux commit
c6858779f1f5 (mtd: spinand: Remove write_enable_op() in markbad())

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu> # U-Boot port
---
 drivers/mtd/nand/spi/core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 2083e3673cc..d0c9083a5b3 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -795,10 +795,6 @@ static int spinand_markbad(struct nand_device *nand, const struct nand_pos *pos)
 	if (ret)
 		return ret;
 
-	ret = spinand_write_enable_op(spinand);
-	if (ret)
-		return ret;
-
 	return spinand_write_page(spinand, &req);
 }
 
-- 
2.50.1

