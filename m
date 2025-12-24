Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81580E75423
	for <u-boot@archiver.kernel.org>; Wed, 24 Dec 2025 08:25:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65327841DF;
	Wed, 24 Dec 2025 09:24:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="ZNp7Y/6O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C646484205; Wed, 24 Dec 2025 09:24:35 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA512841D2
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 09:24:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XsKfIpC3rJb2KdKy1eqJH549oTmOl/qFBeJi9iCdW65rMk9jMkIfVBez3QQ+PHFg2wxKn8t8vJZhRCbzveU+xFeZ3m5PLnYTFplEstS3Jm0r/kMAN4rTfOONXOp0wL1ac1SZI9ctz4dV1T5VpXTde7ruuTf7CElxF1BStGmmKvAY0Igfchx01AmUWUrHKZY8XtB4QVHmeE/YY2K9tfJZBWg/6jzZMGCCPCv5sr6HIGz5ZVe2rX+EELP7AAuEGlHSDyHlWKGmObOVO0nt/ugtUN+yt7rycExzMI/g5KNH2Dr4jI3Bt+6tLRGHAzDCLkX7Kbs8b/4P2lNS9nOm0hXmWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRlVDWHPiIJ4OacymBhkm/G2afdk+8JKVb7R1SZ9awY=;
 b=sMf1D8c5JpLTGWnvcsJh1zdOabI60utjQZcv2lbpAFxVbOoTwkn2d0+mfwUWXYI1J9SPQA4J38rW8U0BYD3OumJdQqa8ypp1FvYWsnw2qHz/5B1UcAkssUYyCbus6OClLhffkBybLJxqYd/+Z2sbGBCUspmgaZrbJ8MUQgUkJmC8khIkZlkBehjtCrUTnH1pE19IrjTpcXOB2KdoJ4AQihU7RmfEAFpKyGsAQjg/YP7R2zDUET258xRXATXjftcfZX30VRY9FeUTkOsfZqLfGKb7QkoiAIp4vmkx2oWj6q5RrE+1VhHC3qMUKTwTi2siNorxIN4bFBnlJmHI/I2Gtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRlVDWHPiIJ4OacymBhkm/G2afdk+8JKVb7R1SZ9awY=;
 b=ZNp7Y/6O8nI/pwxZbnEzXywhZnDOivCLLTyOaZsLWMIXPiAFB1rCbBtReHMAbd052PXBpWwFUzzXEP+2e2hpAhn8NAxYPNYoepWmBEANJ8IVPlca8ePRsC1fPKb00YNtOWzvFzRBlXS2ounsGRZi1Idid1z07GSjiqal+C9e7ZTf+EIXiDblU5E7LfGwZgXLH6M3n4tSs4x4bx4IcybkPzg2LnhRgQQKZXfbrRQrdYkSHLPLXMV+9uLYUVqdV5R+U6vYYDNP6w7++l3iOmVAdrfN3VEGr4QPxM/VoDU3ldcTgzVr7lFb+/WYx+11eRnTZf5o+CPsix5n4pAzbXurWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM9PR08MB6721.eurprd08.prod.outlook.com (2603:10a6:20b:305::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Wed, 24 Dec
 2025 08:24:32 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9434.009; Wed, 24 Dec 2025
 08:24:32 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <me@ziyao.cc>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Markus Gothe <markus.gothe@genexis.eu>, Greg Malysa <malysagreg@gmail.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH RESEND 04/19] net: airoha: declare airoha_eth_port as
 U_BOOT_DRIVER()
Date: Wed, 24 Dec 2025 11:23:54 +0300
Message-ID: <20251224082409.1347373-5-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251224082409.1347373-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251224082409.1347373-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::15) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM9PR08MB6721:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dd3a65e-ea2f-43cf-dab7-08de42c5dd54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|376014|52116014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MDeC1mpd+/Ht22Y3P3SHqBV84fhvLb16OXwV4GP+yumPP/o+ju8CY46SKtHy?=
 =?us-ascii?Q?fpztzAyoWwNRM5ofHbm8pKsANv2zs7HMRixCJ8njMo4BYMa7x8IHBsZQkG4R?=
 =?us-ascii?Q?wjPJ3HQaNuXXzqA2R/Dzky5tOmHpD5xwcXiEdyQmHi7k+7ThiKvr6HJ7ymzK?=
 =?us-ascii?Q?oFmbjpkLLW9aNgIiLNOyUVe2beDGqhujMQlp7xI761xWpleXim5trMd7weFn?=
 =?us-ascii?Q?8al7hOoOLaQQ6xoiH1jGiDioLTIqzrkUCSmmPimchCshlrig7FRp/5QAj6ob?=
 =?us-ascii?Q?x/Xf4G2HhKSMSitaPlGu3Wcj2qhUrSaN5K0L39GXAejus+KOT3rHGqotT844?=
 =?us-ascii?Q?GxgZWQMkTgSlIVpkzhkPhrk3Muyx90zEEKheFZy4v2PA7oP7W40oOHf6b7zn?=
 =?us-ascii?Q?jbkZbQ6q2wXDuOzsj5yzu75GkUA0vOuWswriO92d6mXA7XYNcPWYGWI+FzoG?=
 =?us-ascii?Q?WKIh5iLyFhxPZfJOiqiBBuhEvHxoGlnSDU9ISmrqhuGw9zHBbEyoQYFTgzDi?=
 =?us-ascii?Q?Fl84gOkYDZ5bqhl1zK9PqSbJhl+m5nQUSqKHnHzOtd0+6Qynkfma4ZAZigdr?=
 =?us-ascii?Q?4bG+q9+D2y0fplEicnBu4cOq1yXUCknE5jSEZ1GazKuuEym5vw4nzvVZAbxQ?=
 =?us-ascii?Q?9JsZZq2NzIhYF4DVjRVcxBoyIiRX5pHy7rRry/49KVnmlFgja0P5DwITDmMi?=
 =?us-ascii?Q?lk2UvvFfNrcxgrwXrwJjL0YhbMoh5a38iTSFr4itiO85IPQ/EVnq+1nQiDAL?=
 =?us-ascii?Q?RF6v1IS1WcRsv8zG+cpMSX0SiC1DvlDQYkeG5F7DNDck+hIwoEQj+xSPR0Ym?=
 =?us-ascii?Q?tdMdVX6s9oTdGyDp4QZHXK6TObDTsSAKkul5q5awsERElvJe0zewrWXT2lbC?=
 =?us-ascii?Q?Z0JbeYmk87yd6QS/jDDdYRsXKvH0XRNzHnQCEvaWn8bp6SAJCrZZVlCCsATX?=
 =?us-ascii?Q?9bsDFWnY1ihLQui78XCJe1WR3RFVojw75FKFFV/fXKu/jpBQKxKbejPs6FaN?=
 =?us-ascii?Q?y0XcmT8oVx3QblSC/dZa6Xsla91reZCDFhXQLytJjhJb9hDtpjxhFEby5Mch?=
 =?us-ascii?Q?g8nRpYCOLqKfLJkyBocqccJI7irDwOGqnUvS6qvr6SP3cPBXIFMIpdQ2tWSs?=
 =?us-ascii?Q?weKxQUDrGr28ImrGzW16zD4mO1qs5SeE0vwY8jVMMgppsLtlfRY//KqbxADZ?=
 =?us-ascii?Q?gykPNJ+BppMJRrf0UsexE3StNUaQAdMAbv4xiV6yAem+o09BFxjuUrYgeQKC?=
 =?us-ascii?Q?RXNLHRQ8JumWKFnQuw1qWLPSIj3KPZYDMLdj/v+iAgfPbBOGcTOONTgKySU5?=
 =?us-ascii?Q?bqQ6cTk+u+X5DfGD8bm6vT3GDBHMk724ytAuTuwQ0SKYq1cosGeXuN3veZeY?=
 =?us-ascii?Q?LLzIX7yEltnRJvkHS++OcTZDR2fQdhaIzmyoaaPdfVKh2rw3KHUcgNscxNcq?=
 =?us-ascii?Q?qaG/PkHsJWLUotgVGOkL+gEVLCW75Sqrz92L65ho0ikDlC89HYqmL2GHp1Wo?=
 =?us-ascii?Q?qsANxxkfIpTNFE4jPr6Wwf/7mQ7JkyWzQDjsFoWts4lNsh7KwHjQwB+5rw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014)(52116014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cPJJyk8xay9IOfui6+Afv78HMuZMgv6fb2chrRiZUgnuYrgtt+vSA+0vVY8L?=
 =?us-ascii?Q?mwPZuwOUAh8IOZ+lU7bEgyIx2srsfV6SDWZL1P4MHKm6vfAbmMtwyX4Ic221?=
 =?us-ascii?Q?rHOrEGWFiVdpRmgkqQ1Wl08E3+WIw9EpEU1T6Tg35KFa7GJ8XLrqIJ+igzP0?=
 =?us-ascii?Q?lF7/OSpNE3dOfyfWx+39bvgrJR6+Ik+ozvUof8dBXlIofMRdM48Ochu7RIj+?=
 =?us-ascii?Q?knQLXTg2bJcdfYcoekM/KFK1jgJZZ5tF9bqwR6f3npPbAzsugXQYJDKVg3Cf?=
 =?us-ascii?Q?rki7lTQufnHc7LQaBZAkADqZ9zQZZs2a6EirUBaRjNcyZsMuo6fnvkfLEQLe?=
 =?us-ascii?Q?+Z0WvQxmia6ujncb+ptMZZeZJoNOiLl0PdDGb4NOLnZzksc+fA5GkW0UUy9h?=
 =?us-ascii?Q?uxzBiTVguG/5X+Us8t1kx+Rt5B2tNpyAnOBytsHcYVgmlKOqqYaq+yBUJ+bH?=
 =?us-ascii?Q?gZpYOMVYW7dGaT9qEKAS658HPw1NF6I3CPdH87FrjZ6+uL4wyw0uTWqcn2cx?=
 =?us-ascii?Q?20nrCpfdcyvGLLdI3LOXNStVf3G59940btYxOGmiRB6+00Fl9WqTFNi2XYtm?=
 =?us-ascii?Q?3VAGo0OoXNcWcmSNRRKr/PovLL9Cfxf27NEdPn5lxmjtSsUmND+3mNtK9j01?=
 =?us-ascii?Q?xFqdJ/KNEp2jy9tZ8U5Wuu87FqVAy8pdDRYhMbQhuJ9xJH/g7Y0ZI7Kz2tdh?=
 =?us-ascii?Q?vSa2mGlsl8IYC7DevV8lZslSzbH8pW/c34JRlQ3FBfnUYxJHj8cG51ktKjKD?=
 =?us-ascii?Q?KU4CKroic51aAEqYAe5z862CjBmP6Qi6GjmdLXXgOiBnrWHhFqdOAkZCsdaY?=
 =?us-ascii?Q?6oZhmP1WNGfDgCJcCF9BAr3/Nh9ULRN5b6hJ52XgvoJ3RCmFJItl73PYPZSR?=
 =?us-ascii?Q?ISZRBLy2NBAPt87Z2XVMhlqU7V3whUJgBprALNXnltpsHX/Es3Tp1YThgKHK?=
 =?us-ascii?Q?+/DKkdZWy+9AmQB8U15pTsANXnC45ArGu2NMCtxAatzwo5PRbUWPs7FqjVaO?=
 =?us-ascii?Q?6/wWs84iyVw/0l6341qkkxTjeJYRTxun90b9r7CMDadHhpLb0mA3D0A5BN8R?=
 =?us-ascii?Q?kUwpJ5qd6r+gnpTvwJNcfGg4ww1PFrUcqWCz0W8OZriCEjV7V9wFbxY7lLVE?=
 =?us-ascii?Q?Eu8VnHPZASmA1i4eqiy7czvV2xGZkSSTBlWso/8v//4Ut7WusvinoWXLZ/x/?=
 =?us-ascii?Q?nX0BLQ4ngVYsvgxXgcu/24nos6lwZV/GCBdzv7wsm855qYs6j9CwfYE4VR9R?=
 =?us-ascii?Q?zujTn+GzzWRXLOlGKG824R3oCCOaR189Ry/CL/tIHOdOFx1AM06tppC/ceQ7?=
 =?us-ascii?Q?47dAgEn6qxOZb94oZLBbadYb5AE1wB60ctNMO1qehzd9hJaxLJCa5auk0wUV?=
 =?us-ascii?Q?Wqi91Q3570jFtbZ0TWON9zXtpBtuzO6O3pN3QZYP9/+GtkyAQ8AGN3W+kkcY?=
 =?us-ascii?Q?M68uZD26zWbzXpUuTORVrE5t3l//n3e5E7tpIvW8Vepza19ByIm1B/Viu3uJ?=
 =?us-ascii?Q?5zAd7YxcL1OWutoXSmImtmQ+qc/W6uafYgzborvAks0v5Y3SWP0aY2RFPipQ?=
 =?us-ascii?Q?YcnipngcrOF5lW4nq1quMUdAoOTCezaR8cqW37ECf257nRSjWBeGONgONZgE?=
 =?us-ascii?Q?B2A4OT23u17Vi+Mh6E9JDRthSfAVM4h2tbTgXGFMPuwgOlyNuGUzP7l3saX9?=
 =?us-ascii?Q?utY+LMoPT6iiX1rCm9TE5/RVNIt3zBftbv/WRJnCtktaV38xmrSq2Djf/TND?=
 =?us-ascii?Q?w1X+Ba//frOWXCYcq1j+yyfDxkafxwQ=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd3a65e-ea2f-43cf-dab7-08de42c5dd54
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2025 08:24:32.5340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uKdk8LCp1WgBXFWKSmU/tjgLtylTxok79zhJdCto/GzhWHRAdM0egojyGRXmage313d97kTmrHmFMhdvmb1hzFdSMeDjpOq4qIFn4zDDMi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6721
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

Declare airoha_eth_port as U_BOOT_DRIVER(), fix airoha_alloc_gdm_port()
to lookup a driver instead of direct airoha_eth_port usage.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/airoha_eth.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index 900cea46264..ed8ee9da4c9 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -395,8 +395,6 @@ static u32 airoha_rmw(void __iomem *base, u32 offset, u32 mask, u32 val)
 #define airoha_switch_wr(eth, offset, val)			\
 	airoha_wr((eth)->switch_regs, (offset), (val))
 
-static struct driver airoha_eth_port;
-
 static inline dma_addr_t dma_map_unaligned(void *vaddr, size_t len,
 					   enum dma_data_direction dir)
 {
@@ -779,10 +777,15 @@ static int airoha_alloc_gdm_port(struct udevice *dev, ofnode node)
 {
 	struct airoha_eth *eth = dev_get_priv(dev);
 	struct udevice *gdm_dev;
+	struct driver *gdm_drv;
 	char *str;
 	int ret;
 	u32 id;
 
+	gdm_drv = lists_driver_lookup_name("airoha-eth-port");
+	if (!gdm_drv)
+		return -ENOENT;
+
 	ret = ofnode_read_u32(node, "reg", &id);
 	if (ret)
 		return ret;
@@ -797,7 +800,7 @@ static int airoha_alloc_gdm_port(struct udevice *dev, ofnode node)
 	snprintf(str, AIROHA_GDM_PORT_STRING_LEN,
 		 "airoha-gdm%d", id);
 
-	ret = device_bind_with_driver_data(dev, &airoha_eth_port, str,
+	ret = device_bind_with_driver_data(dev, gdm_drv, str,
 					   (ulong)eth, node, &gdm_dev);
 	if (ret) {
 		free(str);
@@ -1128,7 +1131,7 @@ static const struct eth_ops airoha_eth_ops = {
 	.write_hwaddr = arht_eth_write_hwaddr,
 };
 
-static struct driver airoha_eth_port = {
+U_BOOT_DRIVER(airoha_eth_port) = {
 	.name = "airoha-eth-port",
 	.id = UCLASS_ETH,
 	.of_to_plat = airoha_eth_port_of_to_plat,
-- 
2.51.0

