Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E969E6BF10
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 22:07:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC3F084568;
	Fri, 30 Jan 2026 23:06:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="nqP5/gcl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27E248457E; Fri, 30 Jan 2026 23:06:50 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4022A8455B
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 23:06:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZbTQ8B5O2xHpu0lww9q5hINtNffVndlORGWXFvieq0E8W2ZS2pC+XqgkYC/SJQbMVTcaxNcg48BtuiinoI9d8pu/DI4tO5NVqrbNhjO3XnZFaquQ091rGlP79OmXm0lPEU1Q8vdoVwtewlGiaTexi8db/giX7TaiCuGCh5+JRaryFQvSc4VmTbdZYDROC98o5G8CdHz5V48/S6mvALVFXFNnzDXgpYfsVWuOAq4KhQTJ4B4Aw65O+Er2jKmyOvRZApegZ9y4PFlX+daDnB+i8CJXdimyGsPG4zmL7KXHO9R0+9jvaPd1+FTX9l0+ze5zkfOJ1wevBKXVKOshiO5wtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pvv9GtjqMvXixTxJYdoVKRzP5ka5zkbjIYN+CYHr/wQ=;
 b=lGw7Zn9GrtIeieHki4DpDswqTG97CGigZg3KY5csUbpS35aK4e60ck0RQeKG74GY4ZnloMx7ogUxJ4BS9Iv1F0J2fVJQ9JvJ/nBTrdr1w65s8RO9hie0XpOYV7+XyjGZ+G7AoeAsI8h81Cy+1k9kGbxRepaRE36wctIOexUqtval+k/2QMoPKFmJLwt9PTV06azFjgaJxnfxAOoL4i68wx9qOsVtZcAPjG2YQnN0enLJodOzrzs4WnoJtmm3bpI2XiVlWYCSLXniB1i3ozJYpyUQc/j0OkheiTKj++6GQR3LNigh1I9Sk4YLBYETND47QSuHJhmTFl/w3PKB88jvug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pvv9GtjqMvXixTxJYdoVKRzP5ka5zkbjIYN+CYHr/wQ=;
 b=nqP5/gcl+ao/dkOdTOmdLSoG7CFol9PH9+v6ZSbiRApc+SmKqDu1uIFX0+W1O6kdrhf4ajGZbGo3DFwdp2+lY1OXS8kUeuTKx2hgVM+Y029e7uw4B+NdeulbNq5lyzr5T1ZcrdP3oOgXgX2pUx1MH3GyvaLvLTeLHPy1Woq1WbgOTSYnQgJkiQ5giBQAJWPJ8iBXPAD4X7thxs69R5s/nHUGfyR3JEpJGkgCsgSWzXINVZPjBFVL45dhse4LK7/aB5Baw6ljXc7XfPwocr5Snhee0o52uUfF481QsYNGU5wwVCzqHyG8oOnqiriEqSOS3C4/YOpnnSAtkGBv4CqObw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DBBPR08MB10697.eurprd08.prod.outlook.com (2603:10a6:10:52a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 22:06:47 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%4]) with mapi id 15.20.9520.011; Fri, 30 Jan 2026
 22:06:47 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome@forissier.org>, Ray Liu <ray.xy.liu@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Yao Zi <me@ziyao.cc>,
 Robert Marko <robert.marko@sartura.hr>, Greg Malysa <malysagreg@gmail.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 2/7] net: airoha_eth: use proper switch node for en7523 case
Date: Sat, 31 Jan 2026 01:06:24 +0300
Message-ID: <20260130220629.4040550-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130220629.4040550-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260130220629.4040550-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0002.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::7) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DBBPR08MB10697:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bae26e4-0451-46e1-6965-08de604bdc46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|52116014|376014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?z4NpOzVD7nmkul3NRytGhmnCRAMq2iacCG4WSkSKVpx7YeUV2fV/m/kvolFl?=
 =?us-ascii?Q?KqDQbPqFFSFRdZ/zgdkpPSBWusl3tOyYtrtTUntrbDDI1/pCdaRlzU1s6PUZ?=
 =?us-ascii?Q?PxWmEZhhJGsvV7ukWVuq/unXj3VFREVjJxUdaypVZR2gNehIZZB2PeKtCgRF?=
 =?us-ascii?Q?Yg0ILDQBHZ9lkTowd2+3WgKoCMEfg0KgrZWPC0xgY9ieaMV0W3vYLvop15UQ?=
 =?us-ascii?Q?3NqqYhuB0JxhEsFPPm2Esq9xQLBYp5qd2JhUwPuzF2j1j/wJPFxaevoBZj1u?=
 =?us-ascii?Q?MJ172NVNYBa6ftbkZzrdRjDc6sMamUOax36P5eHzmWOqzxlIKB93Xsy9hoNr?=
 =?us-ascii?Q?WWuIs5yTCZ/9GmLB5UcAKMjz2/3G9MEO4FuyvJI5UWdNQtEVT964//jHNoWf?=
 =?us-ascii?Q?h+dnI9HvQdtTsuecJyPhUvLycGkqusaaf3Fvtg0U1RmQmzBA9SYDsDmsMWvs?=
 =?us-ascii?Q?cwF7SV3NF5g4kj1ic6nHtUZzSMgzwliTcGWfuSsQnpWD7IL78XskEC8aPVws?=
 =?us-ascii?Q?2guY1YIr90yWfGfG1goLvI+VulEHd+s1FmDT3zV5DHv4i+kRxszrh/mljIGV?=
 =?us-ascii?Q?0a/RBGorSAlFuNumXVcekKpZA5uxUJfQ2/+Difx5kjphfrXqm4h3hZd3vRLr?=
 =?us-ascii?Q?Uxk6P0dnVq+4Sl/WMqJ5zko5Z7DwIYg1abKKP2TNYIo1lUwiQW2/ZBE68+cd?=
 =?us-ascii?Q?JQCx+m2VIbjTFzfAx4Ffzw8PnWkzgz9Rt9V1hADT2S0FScj/H6B6/K6MPw8P?=
 =?us-ascii?Q?PPn/DmwGRmFypiqF9dPGkBZGd0Jamd8ykgjZLe4tx8zY+tWsqlPDdK82jN7R?=
 =?us-ascii?Q?eokmYf7KA2BxTwe0FK5RR5rKItjUkSSJFl6kdivtI00wWCTu5+ZXknROGwbY?=
 =?us-ascii?Q?cL9eE0qJovkID+CeTWl+kMllXLDFPDngmEMU5EHLE30P9cQJPdl/rrxEVMZt?=
 =?us-ascii?Q?KXyw6JNL7fMiliNJ3XLDe56fi+md99aVGRBUHqr6J6evBRKe9YX74ujKajii?=
 =?us-ascii?Q?7vHiD0r38V7vMehAbREUR2KaETzP+QGgRNxz59vIY8NQEGziw83Is3qiKHin?=
 =?us-ascii?Q?y0KEy3cQOpVWRI5XL7yrnLYKkSgAlLebu0pcCUkUap7YKttpDhSw0ah93XE0?=
 =?us-ascii?Q?NXGfU9kDTl52DKr03FpFfspmNgfK6rYUpbAvTjuYb7L0kHB25q5rSKoH8K4I?=
 =?us-ascii?Q?Pq+IxP8aefLSQd0ZjjkQIFnEI95Uw3qz7D2kWlQNUgTu26D+Bf5So77b7hS6?=
 =?us-ascii?Q?ihwPN6XL3JT2rPaDdgUCYakszACkSJmEHwGgQY82vHGjScaYyCBib8ZBU2fZ?=
 =?us-ascii?Q?8oPHThj2/jmmOh5mTRP3OhHlmaH407bSnznsqlIbBVASs1KyYR7CP/Rx5dxV?=
 =?us-ascii?Q?lu1EIiZEw5baryUq8uCSvI1Dzar4fddgtNCJBqLEgo8gxbxj37OI1LMJgmE5?=
 =?us-ascii?Q?zpbX/LLClqXmL+0ehoY4mr/G9CMFf1UKMUPTfbGO/zlUJDf9RhmZ5/bxWbBv?=
 =?us-ascii?Q?+cvAU9fXrUcvwYQK6+BN35P3um9EH/tTVLV+5kCqI3v6QE3SwAlHprtl5Bl/?=
 =?us-ascii?Q?SCvZSG+9tfoRuH1J8wCshw7VWfUbUJCFN+IJUAmw6XcM+G/nosc9hAbklsoJ?=
 =?us-ascii?Q?vSWUs8UIvjJh7oQrrWa3OXRddO6Bay1EbFjJhwq0q0XF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?25siTs/dPyT+Rw8w5C/iL4zY2U9NQOq5TuOTIKvzaABeBhr3rRbTUArY25ph?=
 =?us-ascii?Q?wt15cdOAcjUo/3jva22/pDRfePz21y61sKe2LHgCw7rqSLs5IkDpjGkqdBbR?=
 =?us-ascii?Q?dhJLGztMXWjkiIrKuQKTPZF4SSQsjkRULB83Zl8RinSf3EJlRwkez6OLaW98?=
 =?us-ascii?Q?rr2LbAM62qL1INRj9AIhF37i+hLNDSE4fgB5jPqLSpuD50gjn73aym16TL9Z?=
 =?us-ascii?Q?KV07PWUvNykE/C8og8y1FOhHBo76B1yh5Ypz8u+ZEcR0LYT+M93OzmKSY6aO?=
 =?us-ascii?Q?iBTRYyJZvjyNmAZtsB+RQBtGjjIiLH4XFR01t+U4nRV/7KZMyQ3qhejpxNjq?=
 =?us-ascii?Q?AkjMR76SmIM9qxh0nijHUC04mvl4ELl3tRP5pD0hgkjUmutIDwLcQsqloklb?=
 =?us-ascii?Q?Bkh9TukgCIzDLpPIRwiH9q49fw1x/Y3QGXSqEnRrPC7H1YhHa5lYq/Y8/ErB?=
 =?us-ascii?Q?MsBJW2fFDFfok57aIM6REKesb9dAo52IE2tj2Dzv2eGrxugwQEgcB1DJnhNw?=
 =?us-ascii?Q?GoBIeyo31qJ/t3MiJ/MGcDBc8buTxf05mfTBlsR3He2pLVO3YAqUa7yNl5XS?=
 =?us-ascii?Q?297+u8A4k/xNhJhwMuVPhxTftq0sccajKVsOBzuoQq9nU9Jb0UiPRJNH+w//?=
 =?us-ascii?Q?LSQCT/rM8QtnR+Ri5V3ShfzgvdGHYja9Ewv/Zg5CvSWJUeVZ4LnZGopPP1IP?=
 =?us-ascii?Q?WgVDJW/YZKtx/sp0okhsdIk7VoBmA5bjlIWD+7fmadIFEk/7bW8YxBw97BwL?=
 =?us-ascii?Q?OIF71kTb+K2k2i5r3GKnfkXvHscUhiC2IgU7MpTvn908Hzi9iWYnzmYXyRGG?=
 =?us-ascii?Q?GVF5wUpFIvZu+LvjIPmiFEjh5IQSA+3tvPjHGe+Nr0k1Eox5TLXJhH51jxFc?=
 =?us-ascii?Q?nt8GwiPM8bYJ67eMWExW7hYGD+JT9CUJGTb4MBqp7/ziiM5KKOKKhMahU/uo?=
 =?us-ascii?Q?hNbiQu8BgFA+YQJ7R5H33xlJIXMFzkg7wJpuy2EMHGuVxRrdJ8LOXJrYZO14?=
 =?us-ascii?Q?cKX4jlvkZOrMxojbwuX6CeSWZjfk5KAe3esMZIi08TimjvDVH4l34IkzjfY5?=
 =?us-ascii?Q?NFNzSla2XjKcHvkbXU2nJ01+ohLKdCQPt6tgpoDWs6HidMK8fp6IaYxdRthh?=
 =?us-ascii?Q?2e+yDQwCkI+0VrxV4oUBow0WwjaQymeFB/TEaCa1vNCtntoWe/MV8tAZVF3I?=
 =?us-ascii?Q?spRF/HeRdW0FYRQfRPuvyCxOdou5uWDSubkUivkJ7JNzLztQjJiDehKMPszy?=
 =?us-ascii?Q?oY1AaloPIql7ycRVHXpf0Zo6Hkx5EQaUZkUhQ/ddgpeuCoM/3a1NxlY8oflW?=
 =?us-ascii?Q?jbiu7vyEb2c+cgG+qGKXhuFqBSb9YNIE51vHTOnzZ7otlEImmVR/ssRBnDjC?=
 =?us-ascii?Q?06SuphAM7BhdR71XfPyhrHEXbAAFrMbDHDEPzzFo7/Yh0qwOEccusIdB0StC?=
 =?us-ascii?Q?QD3r1JpVNkhGaMVTih7gOkjnN9b5ySBYM/p4Eeqc/2atXiNzeSvM772Qkeio?=
 =?us-ascii?Q?qFLTccf0SL562/W3ir5vEGihDW9OHLca3CjEHnYyPPXzwi3lJApGZMKe5Tym?=
 =?us-ascii?Q?IRQ6yOkCNUA3Y2sAE/HEi02jVuW8a07HBNcewNgnqk1cKvy0mWYd66Xmz3YA?=
 =?us-ascii?Q?aPf2U3GkhvCT2BOKJk+UKrDyv8o8FG3gpgdlnMB+6LkoXsrXCAFNRihWUx2Q?=
 =?us-ascii?Q?C7uPPYq4gJ9PitG0gZXOO+353Q72wJ+AHVCTdz2gsMS7GtmCKrijRrfAPGaZ?=
 =?us-ascii?Q?/8iKfyy6YRPo0bd/9PX3KijRvLFQTtE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bae26e4-0451-46e1-6965-08de604bdc46
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 22:06:46.9779 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2FSaoUXV2yVwdoFK42F7GT3XbOdSYBDyLoYRuklhl1Epm/jde+Hg0lwK37clUZL7YK4YobiAMHlokwKUo8osJGcwMVDSnz53HG5GNAnJkmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10697
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

Commit d2145a89bcf6 ("net: airoha: bind MDIO controller on Ethernet load")
uses "airoha,en7581-switch" dts node for finding MDIO childs. This is wrong
for EN7523 SoC. The correct node name should be used instead.

Fixes: d2145a89bcf6 ("net: airoha: bind MDIO controller on Ethernet load")
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/airoha_eth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index 5e393db5ffe..3a0ac7ce368 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -985,6 +985,7 @@ static int arht_eth_write_hwaddr(struct udevice *dev)
 
 static int airoha_eth_bind(struct udevice *dev)
 {
+	struct airoha_eth_soc_data *data = (void *)dev_get_driver_data(dev);
 	ofnode switch_node, mdio_node;
 	struct udevice *mdio_dev;
 	int ret = 0;
@@ -993,7 +994,7 @@ static int airoha_eth_bind(struct udevice *dev)
 		return 0;
 
 	switch_node = ofnode_by_compatible(ofnode_null(),
-					   "airoha,en7581-switch");
+					   data->switch_compatible);
 	if (!ofnode_valid(switch_node)) {
 		debug("Warning: missing switch node\n");
 		return 0;
-- 
2.51.0

