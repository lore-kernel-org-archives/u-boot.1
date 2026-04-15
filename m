Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5593FA0C2B
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 05:11:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99D8F83936;
	Wed, 15 Apr 2026 07:11:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="aYSjR+1y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F154839D5; Wed, 15 Apr 2026 07:11:02 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED067838BB
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 07:10:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQ36A5lmXIfqG2pAFYoTsdQTx/mkquyVDf6A/N07u46CD0PlfrwkLrSFVaMDacI6Cv2fer4vVrrcDpqSqTyJQAt6KR1FjvqVQs6lgc9DQQUUEm60xbPQERvTNegl+Am2ihbRpdjWDbCWmHSPD03X/XrHikevgb9E6vPdHNup1bWovIa8ztkknKTKDeQHUQjWmtw/ZRRo7TbGZpB8XtWrriWtuM7wvXoXKg3YpsIyux3dpEYERh7JChGt+MfD8xrx13GaDyzFIjZeBqA8d4A5f8ENfOECw54VD60nnjr7gvIbyKMUmZ5aQ20m9f8Ngetpz8LllsICGDljvk4Hpa281A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fu7g2vQsZZkCtRiuXGiwOsnMR1uvbNpzrryz3VH7Gw=;
 b=npmh7BNyNrW6GNMB+XYCWKPoYy1G/BuCBghOObQnmjqduEXgCWy1DdyZ08WHvshxu6J9llyLkuGo8lscFDQwOviWKzvt5QqmMFlePsfxqfM40DBH3AEX7QUEryOmlFOcD2+nTWFzgXafz5K4sKBlJx6qZWMjFrvfKjNo5oe8CFZ803ecdbBiPUd84/UEuCx95bwxsbB5zidjj/UchUDj9ULHvfI3rGeDdCNm8shnQkXlXHplurxCB1aQE8IrBf4WdITjK41gX7xB7sagyf3w04ZPvByZDAMsoojeCdEpjPLBt1KExnwcTUTceL/mzWsg73e9e0+IymTP4mAGKxr2rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fu7g2vQsZZkCtRiuXGiwOsnMR1uvbNpzrryz3VH7Gw=;
 b=aYSjR+1yRIPel430GQcOzbDGRW3Vmu0VM6U8lBI1JnGOsVviBksBO1gtUTMCeerNlZ6bVz4ytF/3YrtXDVG2GWHckvrJWIotjRkDGhzr3APVDseh88UbzAS2lG33zzwZN+L4QDkOSFv/jasAGMBTAa30w65GSkB3HG/hmcerCr41CMTdU4cQKVCIDRoF69DGGHHhRtEz49gNZbaa2UXQyb5XU/ol7xoemaDnajcQR2MPiaq9AGqZEd0JwqozvWIJzal/0ZFxhO3wkYqMaPcLHyrYBdyNLj75f9oYAfBLrSThs2O/s+HDuq0fX0og8yqU9HoipOmo12ZjsMJ0y33KfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by PH7PR03MB7321.namprd03.prod.outlook.com (2603:10b6:510:2f4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 05:10:55 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 05:10:55 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v2] drivers: clk: altera: arria10: Fix wrong API used for
 memory free
Date: Wed, 15 Apr 2026 13:10:16 +0800
Message-ID: <20260415051016.3316-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:a03:254::20) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|PH7PR03MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: 43b3829a-bc29-43ea-8f37-08de9aad5f3f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|18002099003|55112099003; 
X-Microsoft-Antispam-Message-Info: ZzRtMb29NRFR92j0XuG8/RyWP+7yD9FnMp64YabcqzMDIzE+viQWG4xCmoEv7X+C8TXnaxCLf1+tfjQ7DDCrSTU6wzR7JhJNEU2bma0D4cB9GOd1IhK0WuiXkOV3cDoqm3ZOVjjxPFfurxn8oUNUsCndLEbwEBQl48kpI26QzUNQoDsViO5Ze19uIUnseLrra4oEDemqo9tY+zEGCxJqVy7C/p1LBMNs1QCpHqD3F07Zmc4RXiRgQC3N0jcT127EewZkZKbTyam42qu81YKdEWjafVCybBsWxpWYiPZbMBEsOn4mmBmbtlsvO7dxYjbpEod4o9EAVFpp5Fvw/cZ6HZz5NMMP/R9LG/eEif6KbP4nmJbQNliMVA9/1r6T0lobqizri5NV0y2BPAP0F1vERkoM2Mr5eM7nkyK49C9o5XUtoi3+PCTadBS4fNOj6iXPFMCNMZ1iL0lOEFZgezXOHvUa0BAeb3+ijGC1DZy2p1mj50fDS0GOLLFAuCqbnlI7yq1kdILuY9Jg3qZMuirMWUjibRB3IRKJ0xQjV1apDBko6QgSpmbk2HX5AAGRnVzC0g4dKfS0Bwar/qtTWUDRX89rVAayl1++zhlVRKuiqF1pruHZH/iuEkcf0C8m3lbmDMAJLJx66OyWCgpKKeX+nwhDSEZ9+5ZiIBSwP3hpcWcS5uxgrNHk2x2hMc9PdgKmywJqLf2TUGVP2hjhWn85JfwnZl73+5RZAT2mUtQoGLc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1B5RD6d2elkf3JoXjpKBpp/xfcv3np/mjQG//qr9HTXd9WfTrjRaMfOCbUzs?=
 =?us-ascii?Q?1ktCir0AHyETh7HXEiLar+Hfi6okd4U74X5PTd9jjSI1pbCQR/JlZ9FbUE1S?=
 =?us-ascii?Q?+KB5YMxhjVMYiwIoQ+I0UViKmrtYlcAm4zv/DwAdNnz4c4WeWvhAstiTc7xL?=
 =?us-ascii?Q?InEw2Nil0tcr6/vIZjpYYJ1Z+dS1TUVrbu1jEm43+FUHUXaE1YEGHuv/VfM0?=
 =?us-ascii?Q?Uhu4mOZRUHuMYxlH1kBgawbwFAldaLdenzMS8ry0r7wgE6nV5+2cOp00jArj?=
 =?us-ascii?Q?Prnt7x5ClfjLoHE/GjXfolAm4/FSbqaHf0Pxo5PGxwRSKpElSxkLx6dDhh3n?=
 =?us-ascii?Q?QxiATZwL/QdWLBrwEhbDKJe1gu/Y9GLO0mUfBULZnGvWsdbDatA6UYM7FiG0?=
 =?us-ascii?Q?2b3GjqhPmYH76HXgZC3uW18Z00bvzBKJSnQrXQgC8jw26z1ETI/GMSjcZaV1?=
 =?us-ascii?Q?bZk78OTWRVw6uCcpg6rI0SVKDXzYH2nUyVGP/09YkgH/FY+Yu+1QhbWic4V7?=
 =?us-ascii?Q?9eZV8uP4WFVpQuBc15akb+XS/JxxC4XNRMRzG/RMjbOOLnLZLf9V4du7sHtQ?=
 =?us-ascii?Q?RPjDjh2zQw9R2gDITiTrqzPcoqnHguYzacD3Rh0QaWvdXgRjVNYlj9Vk0MlY?=
 =?us-ascii?Q?98L3oxYwQ1ii2rTCHOfcObGa1+ag9D3Ajh7TZEFKZ9TqrLtgLv9BFxLxyAot?=
 =?us-ascii?Q?5xyuZGnmytuq6EvRzTyZpFIajNlhU/Ay19tIYxI/vMtaO3QzmUOnEWhCwYVJ?=
 =?us-ascii?Q?cmUZGjA4i7MbTxQgZMyAq0Ucn6u/h7O0HRgSTNcDrAfa5wlI9Kng5b/qYSye?=
 =?us-ascii?Q?RuZpBORO74DmXgrhkEfV1ciJIqmMG0+IHx9nBZDqn+qAqz2xQCkxEXBtW1gX?=
 =?us-ascii?Q?xHQGTx0Rt7vGxT4bKSE01DEUi6ks+Ql61s271op2KUHbHXauVp7gfPJqjH5R?=
 =?us-ascii?Q?TO9+hCCXWMO1gGd3zKmqyqswFhMZAPOUCOBbdd1LH7cOrOyG2eFOznKwb0zy?=
 =?us-ascii?Q?78+uCfXbh5M/zdw5dppw+kCZ2cGwfCIHbjA7FdFLLg29wNRcqAVHxZsyS5Hw?=
 =?us-ascii?Q?z46lX2GK1efN/tdc/+DMfiSWPxsKd/ERRsjN8ZPWypowvFCptluGq6Eul+Pg?=
 =?us-ascii?Q?Om8StKtIrLELyV9xZ32r3Ta7tyHKljtQX/RIUqGcvdO366CcFRSz5Ww90yUt?=
 =?us-ascii?Q?u7zT63ds4ZKKICJLWbxNpVk8M96fojlRSm0x0UF16k4Ql9otHJie2ZR0gKz7?=
 =?us-ascii?Q?4hn9ac1X/T+41xN1XJTxYsxyHboBxedz8cMp4UHWMh19Ht3diycHBbnAsC5x?=
 =?us-ascii?Q?+RK5Yg7QEOH/fyIaOfhe12UMlSjjAUZUpMe/R0t0lZqL1UA/1/hNjafOvN22?=
 =?us-ascii?Q?Jrz3Ib4FAHjeAOMf79aIJPSXXobxrGEzFrTH1E4RfsvjavmvZy6a9c5pq4Gj?=
 =?us-ascii?Q?wgyDp5XT8A9HhBL2G38XJIL8YVtoI5FJHp6pmbU91aXy8tA6S0Zaur+g+AGr?=
 =?us-ascii?Q?D5Hwu/bnx56c+FRbboHptmVDHQTD00lkp6A4d1wvxdN+mw4YZ57pGgK54iIH?=
 =?us-ascii?Q?iYbPSvNTwRoE5/U+yEge3ESVE9/KxxTiNmq0hop5kFfw5HI1xW7UmJKsUPTc?=
 =?us-ascii?Q?g6crRqq83dx/TjB1e2ANzAFZ5kFQCVCFJT4u7KEd68ZD4jyRsTV3eXLASwC9?=
 =?us-ascii?Q?pHsJ5NgFkr98TVH51yy8zCZQFm4PFq451ub8xOd9z/MZRZ7OILmkhv+B9CQX?=
 =?us-ascii?Q?dOgBA5nCaQJ0hJt7HjUnpU7gjkBwjEA=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43b3829a-bc29-43ea-8f37-08de9aad5f3f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 05:10:55.5927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OjxKfi5H1yB8N65tN9iBYjo7d9Rcux4sRZ5CmO5kfSF9Q6Jf7bmza8owhtS87b+27z9raIO4PPfbsmGES7pn4HibD8ioiI2rMUMEkfvOjE8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7321
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Fix the wrong API used for memory free.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 drivers/clk/altera/clk-arria10.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/altera/clk-arria10.c b/drivers/clk/altera/clk-arria10.c
index 1840f73beee..081f8f2b7aa 100644
--- a/drivers/clk/altera/clk-arria10.c
+++ b/drivers/clk/altera/clk-arria10.c
@@ -222,8 +222,11 @@ static void socfpga_a10_handoff_workaround(struct udevice *dev)
 		return;
 
 	ret = clk_request(dev, &bulk->clks[0]);
-	if (ret)
-		free(bulk->clks);
+	if (ret) {
+		devm_kfree(dev, bulk->clks);
+		bulk->clks = NULL;
+		bulk->count = 0;
+	}
 }
 
 static int socfpga_a10_clk_bind(struct udevice *dev)
-- 
2.43.7

