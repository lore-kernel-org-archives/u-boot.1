Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B9CD1CDCF
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 04:15:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE50283DDF;
	Thu,  4 Dec 2025 05:14:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="TXaQICnJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D295383BB1; Thu,  4 Dec 2025 05:14:51 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B48E483C19
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 05:14:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=be3glVJ/7+2rUh3WitB/5kAn2mnBUAfDnWGI+XDYoeZShb7Mw39/fNeMJIf+V4BQE3czrqrGAxXtDugNr68JRzKySTKXa62Cn6HWHtkicuLr2OAeZn2ZFa395XcJy4e8zLJKOilq+vIt2O4l4SK/SqFvu6OY4++3FPfH2rtw81ql6b7j1I/lWs08ZjuXcaq7einVHlyZWDfNqWX1i8vTxpQQt8WQjnsnmiaTJDUWAut/Nt8iA62ElTCEUZWk9ys46AMWnPuX3UutZF3h+ItUAcjJMTGVjQ7Sko7q1Cs4k9qih6ARueVTwGLGhtoLNqptFxCVGUytBMbmK3RwO2b/ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRlVDWHPiIJ4OacymBhkm/G2afdk+8JKVb7R1SZ9awY=;
 b=MOatQeCt/s9rC/G80uHXcQ6JYmtIwRJrybNaaaiUACsO9W8Kcp7tIycoWJHgWkTtghl4IGNMG3UjAA+RHSDU0Q+3zHRnZlp4kcK9+Pw+xXN5RUpKubxYcbf7LyUSWtHILnJ8fMxalXpq5riBQsjGAW2QyIwN34YbjxqPlD0XJQv67PK9N8bw3JWim8egsrr8j1r0lowVfOv4YLdE1C19+vqZjX4GsYDmBNYF3YgS2UYmtZHSRHrbBNMFOVED7ONpE4rfkpmWB4B027vaHlh9Zmat1KinWBbLOHu8PpqWg0mEZd8Z0P0qIJBgUrD0UTboAchPfRRrkZFPx/79TzXjbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRlVDWHPiIJ4OacymBhkm/G2afdk+8JKVb7R1SZ9awY=;
 b=TXaQICnJSAGsHXicv9uvHm0b/cG1pUYX2qFFmnvlU3osr+Jk2NHkg4tX7HLNO6hMJ2x3Ya/gqFvKxlB8KibW3eaKKimIaOi37URZKd8XENlUx0CMN4+45Ox1kPoHUspfI5WtzVUCRVQSkgZHV9UlxQEKE5dhG9FtJK9uthPH/jxUw4V9MVsQWzStA+Xd0Ubm0E1G8tYg53ZV9ZKjcwjTluYiT+JqxC3EX6C3RcddQm4oj2AokdN4HCcneZfIdrhO2md4sDRCVnRzBwCehMg9+Z1F/agGn1HKG6GjYB47CWD9l2aD8N17fgsDSlUzRyrQ4ObG6EDa+Fsy6Lv/y4GzMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB10009.eurprd08.prod.outlook.com (2603:10a6:20b:64b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 04:14:48 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 04:14:48 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Yao Zi <ziyao@disroot.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Greg Malysa <malysagreg@gmail.com>, Markus Gothe <markus.gothe@genexis.eu>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 04/19] net: airoha: declare airoha_eth_port as U_BOOT_DRIVER()
Date: Thu,  4 Dec 2025 07:14:18 +0300
Message-ID: <20251204041433.3459826-5-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251204041433.3459826-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251204041433.3459826-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0055.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:271::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB10009:EE_
X-MS-Office365-Filtering-Correlation-Id: 74a35657-5c34-4008-0a35-08de32eba9f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cYr3JA6lnxXknm0T7e346dj4y/xLB6HpKWBpbKyUYaL8l1O7JUAQGssj64VP?=
 =?us-ascii?Q?IAz58yLAAZCUOiS86W2WymcySWVixc3hKclApwzZQQH0nju64RJP/mnpauVk?=
 =?us-ascii?Q?NtTdrpXkjt438M3gYnTSJmRmtGDNxXr5mYU5YH89tRITKoXI3n14Tmi7njgt?=
 =?us-ascii?Q?yxTKinO0Ia1dG7um29koIVSseJspQUbXwLkliwoGgyqxsxXgK34A0eRRYQ93?=
 =?us-ascii?Q?jX+Q2WjxGCHgy5HyowtdKNSbK4doSGoWrwndZXk0HYnSUr5/Pw/hUTXXd9OR?=
 =?us-ascii?Q?j3uDkwjH9/8QFVpuiHagkN/30k9Q14kZmW5QBn9BnVbmS1yU+IVpEr+pEaDK?=
 =?us-ascii?Q?2CbBfPDgVpJXYEOaXqiv8/D0Y6dAoMZZgc7fW94TPgDHD/qnlgez8tDA2FQ/?=
 =?us-ascii?Q?ghYgLkHESo4KEAQoawyx2ULTTmAYtMuInAmHJH9sK8t2iYK1LpPfMCrTGh6s?=
 =?us-ascii?Q?NDzjQOSDSdxK8GL7TlppS/eXDfjyL5hP7DQVUzGUSXSgYnTtxzHPY4BrXJPJ?=
 =?us-ascii?Q?fla4olGVQYaOzL63PATnWGjev0BLZh/2RTOFTunU3K0OWENX5Tj6c0ooRhCC?=
 =?us-ascii?Q?5Beg3JH+ikaEKFi+YaGaEHgp1GDzf8RJuHdfRPD9fkz3/6Cfll/w/Oizc1uE?=
 =?us-ascii?Q?htApkH20F3/14y6nQ9uCSbIKHu9tyABGEBdtJvGL6Tjt55dukKNrzK+UkWrW?=
 =?us-ascii?Q?9nqAFc2OfkrWOcQJQsQ2iZKO6kJfUQFHv+RFwQLLT383BjI8qqFEUU+qYeyY?=
 =?us-ascii?Q?6KNrmz33Ot0Taqeu7kXDT/xn5MC9HkDmYndWhd4AqZWR1MoXkHmVyZqQhm1Y?=
 =?us-ascii?Q?aZTFf1TXLmERdjVyMWy19W/ZsZbAZmJxLZ/d/5+KXadFbsODFZ2vAfGv3MRz?=
 =?us-ascii?Q?cvIlMvg2ypP77VhwWOApyYrX55eCMLeMm/ZGYFpQiYg8364yYl/PzVLs2MNj?=
 =?us-ascii?Q?iGYghm+6MkHtzHqizk/8KlZdq1gcll8ozv2gqRxdOW5GR49sz64CXJV5vd5K?=
 =?us-ascii?Q?/6NDbsvdvQ25ynsWuT5nI2kSEb2UxcJZTEnlYoqhQ/aC85kn8Rger8ji/7/O?=
 =?us-ascii?Q?p57W4Ap6itn1VHw6h6IkpHCXtXrMO5dgB+QDpCRxv4ov5cHu1LvQkbjEZoPs?=
 =?us-ascii?Q?7dEQUdO/DJzaWQQBISoAo+9QmQ5++Rk3t8ucA/PVtUxMMEApGoA2YFdEeAL5?=
 =?us-ascii?Q?katpN17ieHPhsOzsVO0JJ4N8b/Lif0m6RRHDUiSYyLH36D8czBKzq4HTAFpL?=
 =?us-ascii?Q?AMNC+fRqR0rNFpGxIAVSqBUafjqVvz4wXQ5s36EE96aRKpakIDrqjGKdr8fm?=
 =?us-ascii?Q?cA1+I/h1L0y2uMj7QnkC9X3ZnGrzH3e4dKiZqhb6HPVI8E6ssMKYL91R78DR?=
 =?us-ascii?Q?9hi6hnf63/hMDadmguwVElDYyOoxYuHv3VzkY/IBgmb+ryGCyTpt/LlJha0f?=
 =?us-ascii?Q?/1f0TMIdVFtUebY7PwhAyneh8JwljNv4mJdtNJQ4fZgeQWR3IBYM6466ULEJ?=
 =?us-ascii?Q?mem/Sjc4YAVo3IxGd/qYV6HmR6TYSoAZQREr5RGbi2RBq5uFHYKeTXX31g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DElsnV6jILlUfx5uqoZJPPnZbiT9GRtUHszgKQzRmOxd/jifSS7OwdB1Rmvf?=
 =?us-ascii?Q?HY2rjDECpVjMh4fYamYB0M9E3yJa5OBXvW8urCf0nZXF8R9PJQmIQHs8Ljjn?=
 =?us-ascii?Q?rFHmch2spl9hwUj0+4cCH1vTg3AvCpVNtphpaFOIjeYjzvuREaA/kx11sadq?=
 =?us-ascii?Q?Pjoj8QiqieZaW3iBXP5qc5cdHidYqeSUD9DdAgRX+EiY9LmWPJDsG8jQf58p?=
 =?us-ascii?Q?v9qPXIDTHJ1ex7xLne9iPWRP8+6efswKd/Drdcqzac1MAHicMiRrQrywSXVS?=
 =?us-ascii?Q?B26wUnuofGaxC5AYxST89vQP29HEGcrrVGvVNXZPCdTHVpCAuIi4L3CACiYa?=
 =?us-ascii?Q?8m1SKEuIX9xpZ6TgxMsYDBbqsF05YAQ6J5aD672wpCj7XHx+2F5qvyUAHzQc?=
 =?us-ascii?Q?U+HeiVChSXi0n1mbsPNizCxr4N3mjtr+y0J/Nrg1xFNsC84bJM1WDs4Gb74g?=
 =?us-ascii?Q?zu6vIFJs9lSJBtNo3IlAzu+Nran2Jt66zZ2lPteTdNA48bY4FpqY/vKhi3o1?=
 =?us-ascii?Q?lD/L7s2JqkMjxJ/QbFC2AHJ93duBbgCz0YhNbG3mOdqWKi0s3XiOvsV/GAzb?=
 =?us-ascii?Q?F7k2Z9jGkpe/peXzU1/TlIsuVtf9Ubvwg8J9RkE+UhGgobcxyzkdKJkOfU8k?=
 =?us-ascii?Q?pAWdGwDbjzMspXDBrBOvcPXd2KpOcUAaLJvX7lW2rLObKMybvS51MFXm4TO+?=
 =?us-ascii?Q?32QlIu9XEhoNOu04dmaUPcI6rzf3luPZiIaTbBRFF+QbmM4dxhkr0OiJuE+Q?=
 =?us-ascii?Q?sQgWLgEpCQV4tyv2Meqz6188ey3DPba2szXuWV+XTbmyYcCSuIoMtOig3kFj?=
 =?us-ascii?Q?ag4XEj2Z/Bez0TmDzU+ezjJLpBQE1j/DiKN//HMra5zRMKyYzOiXVD5yTMYe?=
 =?us-ascii?Q?jkXzjtsqS09iT7JBfo2ydta8hj/LBX+OVE4Knxh0POMXi/1A7zu5TwIs8uGu?=
 =?us-ascii?Q?MQnQWK7O/ShdmGh8+Dx+VU52zz2Xk5Lypo9t6T+pc5PD6gSDbOc48GTpZzjA?=
 =?us-ascii?Q?bnGxHYNhOz9hWORbmNpl+L1l10JB7tcGL8FfPLsr6Ozx7QMWYjPQYxXUYvU/?=
 =?us-ascii?Q?7ReE6Os8IX4Qyyx2OB4Aga1Et+a/uQrtTgemvpF4DT1G5bLZkFPJwGZHTOUK?=
 =?us-ascii?Q?2k46kY8pe4RvUD4U1g8gXbuT9OuTFvieOEGFXtCGBNczJ5BW2ZNKfeUGn4Iz?=
 =?us-ascii?Q?qZWelOfjJDVPRzcv3KomQaqioFVpCtDeHakUJiWE4HIrGArWAuLUz3IKMSqU?=
 =?us-ascii?Q?YJiz7j5iY7lbTHev0FtOvXSBynTAjkZZ5ecKeYf5FdemT9pe8g6O3tu1ILiC?=
 =?us-ascii?Q?VsB8I/KLKaEOxghBa8q3lHAg/Zz4L6nqQfa/JpWOTLibf6kSTJG3afk+FUfV?=
 =?us-ascii?Q?lwTWXcn7VWO9GhGVriJ2ivd2Pe7sHCriXB+0cH7lYmPuLkTmb6XhfoawjFOY?=
 =?us-ascii?Q?R87nHKcmKqmeqL3pVXnKoLMybh6duP3WnC56FIx66k8iOkMy6LR6SNAmY7MJ?=
 =?us-ascii?Q?wKRmGu8HQr/Um6McLY55fteNiOr2t8/er+SRpWkEP0GO7gze/s9b/suS/zhM?=
 =?us-ascii?Q?dGgdgIp75DSFptHPmNbm+3Lu0LtY6E3P4EW85Csu+A52NtjoKbGtubpXSZnf?=
 =?us-ascii?Q?NYxEojir+Z19tSAIojc1FqA=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a35657-5c34-4008-0a35-08de32eba9f2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 04:14:48.4751 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DrnHnBsmK8nuht8T5zDZvG+IV8Lrr3Y/Kl1yGLtjAytEQp5lJXAIRhDNcnWn4PcCp8J/oLKg73RZZvB14F+DA5vGfBw1rHFIfFmAYEpfIs4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10009
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

