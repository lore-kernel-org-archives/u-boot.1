Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9B8E75423
	for <u-boot@archiver.kernel.org>; Wed, 24 Dec 2025 08:24:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A75E841F2;
	Wed, 24 Dec 2025 09:24:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="5HsDov1D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32AC8841E7; Wed, 24 Dec 2025 09:24:27 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 430F1841DF
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 09:24:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mx07+I4Q0wPXm211vpJ1BRQhcq/uN4h/qYKhR/rs1cYp445bBioRvwVt3JgxmbPwxStCfutiCRLx7At4eGaroKm0ORyiXKMleuNJXuInQsK9txp0D2WN1Eh9bkOp/XZF/e3Gu6kUUxethATmd0iOSExtxzpVp/FOyxnZmRvu3GM/MpoyXLm71go5z7wwCy1jHOJTLrb+G6kpG8ogcwHUGCXbSgoPi1UrhHLt/jx1LVKnZVhM7ePyqNSh+IpP7wwyjNWC6Qw1b1fcB4fEocUoipv7v2L3GpeujX/8fS54VbljfTYsKCfPltBoe2+SS47jASCO4iOjza9GTmxtQuTWfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XD+J+EGCpP9ET7XmJW/RbbLogMN4mAUEZ2TYMnrgXiE=;
 b=JTPdWV6qOEdsVyJ8bSB4mSnWB5KHW+iYUhwANqcXh6PcQVU0sfksaBCjum6DQ6uCdw0HIMcWK9BhZ/dawCc2UitLRCz7Zot+gs37ecR4fBu9K10aPjoOmslgB8waxgsa7x+2oYNx/yMEne0ztpI2StvDKRFaqB3GOhPcp4dDtwkHKNqiin264XJklrhBzCiaYaRocTFTW/psITfuMJl7/cG31t1iRmkbiZgPhoaaHHjC6pMOTsaGPKmQbhLOIjRVpmpbmlQ/AMVqFn7v95TabaPGu1+oBgrcWt9TNmV/eFafVH27Vt9EsPcdgQBeZ+XgCSTOpbbYozlmEYO1F+sD/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XD+J+EGCpP9ET7XmJW/RbbLogMN4mAUEZ2TYMnrgXiE=;
 b=5HsDov1D0WP9koYe9b3r6aQ6PFPvQk+ITjyxJ+7ONkZxLpnorv95GEE77Z7DEFVplzDPRiOMywbsgrXLWljs8AybmbRWIzSCFzce/eebl7VovPenkL76fQHqrIiBiJXwe4vYZtyADTOf3lgR8KLUaIQj2pYhK5an4ISjLxIDdgVSSCz/F3DMkZs63yJJfjvzgzV5wvDQjI7Gt/9IyyXn+y4IvBadFUAuTWIk6YMwikbiNl+gyuYZ1VqzjzbvuTn5zNShKUmryfSSPy3u02hEhd9NLBcUCObySyVgfipjxgbfH7zcKErquUAqjMtu10QRGf8wiyQMMDvadrvV+uFvvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM9PR08MB6721.eurprd08.prod.outlook.com (2603:10a6:20b:305::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Wed, 24 Dec
 2025 08:24:23 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9434.009; Wed, 24 Dec 2025
 08:24:23 +0000
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
Subject: [PATCH RESEND 01/19] net: mdio-mt7531-mmio: fix switch regs
 initialization
Date: Wed, 24 Dec 2025 11:23:51 +0300
Message-ID: <20251224082409.1347373-2-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 78f6242b-0df6-44d7-bfe3-08de42c5d820
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|376014|52116014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w0sOREpGrTNgD6xLpwcV6HI+ilW81kvwqQw52q3rvdL/gP5loOGtP7MNacIO?=
 =?us-ascii?Q?6LbMYLmXDF6QIsAxcgD2kLujQuooQPkOkvEJzdEviwS7vGIphA/GkwSLa0/i?=
 =?us-ascii?Q?We5q0ZFRSEy7qpY1OUoHwGNHTgVOEpAV6PbePzgrmYnVmdlg+17h/GvDE/yS?=
 =?us-ascii?Q?4DAM18K5szaRpcNlHVHXnh3yU44cEdJz7ZSCy7I86JJD6ctb+OFnDSpXI9Ns?=
 =?us-ascii?Q?c+M/7Pru+mG7ZvzVa2ljOXKXpv+239r7ATgGAa3277WoehQiclhNgQA+DDqu?=
 =?us-ascii?Q?3qgf82ES6DJikM/udusOH+ZDCIj74tZJ1rafuHCtERu3BV8YkXleXTBTzVM7?=
 =?us-ascii?Q?BmTYzJ+hLVdA+dmm28AIKmHdacAZHbFlc9eEjaJFRdPrSraoxqU0eOHLH9t8?=
 =?us-ascii?Q?ENmwmLKQL/74q5KFd7flJrpfWTbvwHXiO/FCfCGX0oyx0sjNOn+rBuArxqIg?=
 =?us-ascii?Q?+AxxUJ9hz3gHFdWZloGjl4skEK2Z60uLqgX79APolSSUs2GrtBxnYtTpMLOS?=
 =?us-ascii?Q?ZGe/CBQfJO7lAswSP3dbNHDsulyeltWIicSZHqj34/ifkn2DRvlpRwsV9Bkc?=
 =?us-ascii?Q?8b/IAGXREeHbap18nyPLwxfd7ZvzvQ88+u1jMFrcrvmFAKwCJccxYolUgZoc?=
 =?us-ascii?Q?jkJm+V4JUSF0+XqmS4ehaIJtvQ62ebQknzIy8CIsUv5cAWWsFNiwFwYWfJmJ?=
 =?us-ascii?Q?WwiB4M645iD1+A6tKamLz7jFxpqfKBr06rsbi/yccmO0BQOs2li0ngNELlX2?=
 =?us-ascii?Q?S6KVGX+XtL3fxdF9yu9wOAFsSWTztBkX0Hg1MOVB/sXy8+CraddSJwReMB7+?=
 =?us-ascii?Q?rTdRLSxscqBAAJjcn2G8KFyUpPBIByUUzNQjCgOMtfIZhqRmJhTPoqTlNHCL?=
 =?us-ascii?Q?xe1HUFvW2TrTwtHPhplPFtW3DX4bAI6egTDcJcJcrEfIWqjN0UYV6vRniQFE?=
 =?us-ascii?Q?fC558pu1DaXKtwBhYfl5jSDHE0BjRnhoN90At5LLl8DtmELYqhRVITFfIeiL?=
 =?us-ascii?Q?FHDB/WFQSrsqnltOCD8oebqy61C6Na5J8GFUmnedfo2QJRDH55PvEaxGeZXk?=
 =?us-ascii?Q?6WNJlZ4+t8GNDUHl1lZzLb3DsJn1FwDAGzUwUjmFyXPzggCJMV9GkrOVKv3Y?=
 =?us-ascii?Q?WSZ2Avbfj3VeipGhxNFNqGTVfmCex63AlVteIupdXBKd3TDiAY35SrFkrOCV?=
 =?us-ascii?Q?OyCYhtZNwRJ0WwcnMNYFYg+xYd+Jh6Lt79G60gJs+sSrPUPN7mqlQ89FcxWP?=
 =?us-ascii?Q?2/Lt/47Vku14495D9JEUGaIjiVsSyMPDsu3HpXNyliYJNtGcS7rcXFrh8oAl?=
 =?us-ascii?Q?hsB6EifCfAkLWHZjdO0FFdktUf907eUnQ4oEa/Qk1qBTezMbxmtyVirxpmJr?=
 =?us-ascii?Q?638IHtLivZT9DvqyNCNC0bv8giErcXkLeWIJLQy9nsl88lM3uVYIGW6F8Ghg?=
 =?us-ascii?Q?yfgRa0iulYYrS6e/uUD/HZLYWELe4BoLxP8SN6B5IMpo52nO7dEzdXSaN8Hq?=
 =?us-ascii?Q?zM0S3RpRaP7HR0GDMjfUpC6PK0d7rordk7CduN8tIYiRflM3XvfLR/bvxQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014)(52116014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qdO7p++UAziVAUmEltGZQNuqFnHWxrvG4+1/98BVhOuY7wEECLc7weTOTzni?=
 =?us-ascii?Q?+9LuyJiQSFZ9JsMTcWJbjdGkb4O1ZHC9SdDzRZe07HRThlUGfjSPE6RPknnM?=
 =?us-ascii?Q?ogQzMsfoUJKCSUx17K9fwfPOGqPgZNVRZIodkWkaguZiTsV6irVzmJllSEyj?=
 =?us-ascii?Q?MTk1gVPys4GdTOXW2yaH/6T/8iUOeBtB8v5GZt7A43oclikcKuoeORSvT/KL?=
 =?us-ascii?Q?vV7DNkxLXy6sb/9P6AaNmgkbMoimosOC8vYIRCiSZNf0q568Q5NeTJSLTHrc?=
 =?us-ascii?Q?xdDkGUmFTEyjChDeJiuij+YjInVesuAJJIsaEku+HgXLoHvaazKyRfScNoXR?=
 =?us-ascii?Q?0/ceDrxCnYkpslJcLWdRtwihlUDfX0AGM3r7TI5gj0DLsKPsW2ldcrRr46tS?=
 =?us-ascii?Q?B/EBHxBK9OEPZuvJwqbazZ/BX+PXzYY66bUEqDkCI4PwqOhUhSAZooqSDq/M?=
 =?us-ascii?Q?FeWCFpvNSjIKf1pQHdisJt9hyi4FDNS/mqHH93U5FF4oro4SfgXQvuOV6cJb?=
 =?us-ascii?Q?Kzd6mU/M2hgTgbbOi8hNRqxhJ+Yei7F1HtAD9CyQW/zK3V5n7nQDiQBmtgj+?=
 =?us-ascii?Q?3J2Cwbd57FsV18wGGnAScFljrdu2dDTZOU2HGq42EqvLAmEW5UG/CV2mkg0d?=
 =?us-ascii?Q?xEU8TWC7ZhP+4MRpdVeIBqlPne/iidM9pSrTsZNNc1fngamBYLtt2qCGUX8V?=
 =?us-ascii?Q?x6tEEbqlSLm0AmSOM32Fw8xupuHlINRtjlevCOizDGwON/mKJJUvTAQfrOFM?=
 =?us-ascii?Q?rKJQ9R6Pz7Mo35J1276HRenXiUZ9ssx1XDUU1Rv+EHM8ifQQ894lelQC6RcP?=
 =?us-ascii?Q?gKJ/IXeJeN9GgnQzT/Ix06L11mi6eai5eSpPZX5/nDtYOT+KV3Wp3TOCV6Wu?=
 =?us-ascii?Q?cn6iC1jMjg34/tbxwYO2Ey1l7+ndsAzcxYcOD1Z5mAu7rctCg7+zeQoww+vo?=
 =?us-ascii?Q?PnwM3i4k7/tozPmvs7dBZvN2EOBPjYXjpHQMGaZZF5SUNtlkPic86suncnBe?=
 =?us-ascii?Q?9q4TlJugQ/5h3ns7u/QuQ9uYDZHGSFeFzHdNW2H6hOL/cb/thp8izZbqG0Xk?=
 =?us-ascii?Q?WoHkvwsTzY2ttsZDJ7mAsRJ2PlmBQQucZEg4el2q67bohYOR0f/o9xecCAIP?=
 =?us-ascii?Q?5o6SlfucfwBtfiyuaa8qMT0DXkU5t/fnWlzETGp9mCHFXWcgQtvZyTHZCH8k?=
 =?us-ascii?Q?A7mH9fIPisInXvoDykzbbtkQwP324+XVVgiWBofmw+pSJIyVtPskyGJm+BNs?=
 =?us-ascii?Q?Q1u2K1tmUmRAHNZcI/qNUGuMNUqWRBiAB9BvLf7fhFoAXiakvzoe8ofuSy/5?=
 =?us-ascii?Q?DMhOsWc9kw/qpOlaBFU/1TPzcUiQe8y+9aREHQ+lc8Xt+0T/6FyCydfj52CW?=
 =?us-ascii?Q?SWd32l/Kfd1+YG4Q9ZpaLydOiy568dnpfr2eMZwa7zoUxpC6oDVQbx69Q8An?=
 =?us-ascii?Q?U9NJywbWEQ7w79VvqPOMgsfwwkWARMgsZfc1hzPTWOBOXqQdpMemmSAXfdqu?=
 =?us-ascii?Q?3T5erVRjOGP88YkTh6E5gJ2w9p7fz02/hleluOqtRmYIae3ome96VN04JYE/?=
 =?us-ascii?Q?lC64zOIzwwbepzDNZVwrp/whRapz0MWzf/aIgONERzmFj4YLkvRoVOV15nIj?=
 =?us-ascii?Q?8cBf2itYQ170OMfwt9HNavxRJdRG3CtSTlvKP7dcSdfny3CQgNN+4kq7veay?=
 =?us-ascii?Q?5YPyIYLlvqL5pzG0dtx124q+guHsAu1f6QdsCaVybguZ1bjTmqLAtat+R4ge?=
 =?us-ascii?Q?h4wq79EGFtrgKivjsqApZtV93kGWPhk=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f6242b-0df6-44d7-bfe3-08de42c5d820
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2025 08:24:23.7445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RbZP+onEjBjhWpIrHC/2i7umG+n6sjKydq/PKNeEBEo9Y3ROv92Ez7+azn2M2Mam6oBQQEqFyAa2aZgf3ScDDwEzKpBxZypVCftqInea//4=
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

mdio is a child node of the switch, see example:

  switch: switch@1fb58000 {
    compatible = "airoha,en7581-switch";
    reg = <0 0x1fb58000 0 0x8000>;

    mdio: mdio {
      #address-cells = <1>;
      #size-cells = <0>;
    };
  };

so to get a switch base address, we need to lookup for a parent node

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/mdio-mt7531-mmio.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio-mt7531-mmio.c b/drivers/net/mdio-mt7531-mmio.c
index 3e325ca58da..5a0725010f2 100644
--- a/drivers/net/mdio-mt7531-mmio.c
+++ b/drivers/net/mdio-mt7531-mmio.c
@@ -151,8 +151,13 @@ static const struct mdio_ops mt7531_mdio_ops = {
 static int mt7531_mdio_probe(struct udevice *dev)
 {
 	struct mt7531_mdio_priv *priv = dev_get_priv(dev);
+	ofnode switch_node;
 
-	priv->switch_regs = dev_read_addr(dev);
+	switch_node = ofnode_get_parent(dev_ofnode(dev));
+	if (!ofnode_valid(switch_node))
+		return -EINVAL;
+
+	priv->switch_regs = ofnode_get_addr(switch_node);
 	if (priv->switch_regs == FDT_ADDR_T_NONE)
 		return -EINVAL;
 
-- 
2.51.0

