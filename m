Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C858E74AE0
	for <u-boot@archiver.kernel.org>; Wed, 24 Dec 2025 08:25:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AA4284213;
	Wed, 24 Dec 2025 09:24:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="UA0R9068";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C6C284212; Wed, 24 Dec 2025 09:24:43 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D063F841D2
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 09:24:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qxHsNEzL9vcpujqTlzwkoz15Rut5rvQ8QIDq/A7XIBQPIKzsCiC9YRptOZOx8r6t9JCZAIAvk15UiABrbVHzIRuI6eJJpX5opi+Q/eMw4R7bEqmPqUkWF/I8Z3kOCKUyGg1M1pQ5geQwz3X0B6+h7BTbi2A/A1V8aQ0TrtCrF/YqabYdqfhDaIca8tnhsbD0rjKqb3eT82GmxLnWvCDytlLWG5U9PHzl80adSPtM1Rr462yKxmSOkfOVL1urDtN3VZGKLFMKdxU3uQr30rOQOcmWWnvMLHlShsfeFj+QYQpVa69EBUXEYMDUJ1s2hpxJ3HEjFPRwLnXXCbaEcOTNrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IP0k6WowTuJhb5tNllSwegm2NL7rF7fx5QdENGDcjgE=;
 b=JL//2CpLcQ/a8TytzSDChxTZpmcWv/PYrE9CvVjWF2R+2MrQM/3T33ws8e4sgHjdjpyOXF1itzbrSJXItNuVD9H7eW175h3jTWuBfJExilngd1Sr/+TjGiK8ROVjupFEulddTE8fnk4SlpYxazzKKlXXd44k+Q9laFLqyspX/62o+1BhJtLZ0aQvkxHTb0mC1CRtPN8R47G+opgGAvTm0Pppbd35NzWCck6tJIbjy/ys6wiN8FMnAFhreMq6J55RD5HUXboRBq76wWPq6owkUxbCReVr45lRzg8MPOOVNOPGfplphXpueSelTyDhZKggSjpn8ktc2q5kUUVHEscquw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IP0k6WowTuJhb5tNllSwegm2NL7rF7fx5QdENGDcjgE=;
 b=UA0R9068IbWkTWsE/XS+NcpG1y8odnHYXdK+FIxrzbnsl84eqORms5YmpBF5/8kKfdG1GJvK8SqL6OBUAE8iqVkBM6iS17fmhS85fHmaWA+nuDy7I/Cn2aJ3tcoGdWh48mDlH1V/wazRmQfNbTNP232fIsKgZWMDUJ2GMiG3e/zUsAWCvte2RDKg0reg9Red5J/rdVpexqxG1WOtiAFFqFWXdCXdYaY7IeptjMRVO5Itvnhx8sKfVyCm3qWTjSxotkKoOSCi4wAFV4sozKutufDwsy/Hee8CGB3N0oz5YYG0Bv9YrdXpOhxqKWsNyGuMUbeWcT5j5cZmaahdPyVtog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM9PR08MB6721.eurprd08.prod.outlook.com (2603:10a6:20b:305::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Wed, 24 Dec
 2025 08:24:38 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9434.009; Wed, 24 Dec 2025
 08:24:38 +0000
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
Subject: [PATCH RESEND 06/19] net: airoha: init switch before GDM port
 initialization
Date: Wed, 24 Dec 2025 11:23:56 +0300
Message-ID: <20251224082409.1347373-7-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 7f82c51f-09c9-4527-97f9-08de42c5e0d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|376014|52116014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7SHAatf6egNVKBkDn8RfEIY6jnkTNndsGQoWX3vAv10wfR1ZrCc5ruuqIfml?=
 =?us-ascii?Q?NuunIOkNqOfw+Z/dwZNzy3Vctf9Qi9K0lSQdTYQedt9a0SF148O4FEolNcN1?=
 =?us-ascii?Q?p0jQFpY8LVfG2hbG4W5PUpcY42YhJXIOXe/D+81UOxMeG0S2RGiFscKNscSd?=
 =?us-ascii?Q?P79tD6N30TqzJXm2fGoVRJqmOBxz2jTXpMKmqa/h8/h5Ktzea0lMu7jJNHUN?=
 =?us-ascii?Q?8QL5dXrV4r0op36SOg9MQpd/qTM9dpXWR9KlU8nQY7C1bZ1yx6+fY9L7jaH/?=
 =?us-ascii?Q?zgeAlEQOMFAkUt0lFy+nCb+iX82tykI7J1Dph3whmC1qnalQLsk26HW5yawH?=
 =?us-ascii?Q?VId9epkdpWjbfxv3aqYCc5/lwPKpR6MfC4PEscnUgzLgZAIyZB/372d/MJ8P?=
 =?us-ascii?Q?yuq7zcS7z3dkKH4GQ4gkcu9mQlROW3DeMvtqEbfOB8YdLsB7ZBnF5wpfrgLI?=
 =?us-ascii?Q?lcNDV8RJwAda+kNGqrxfPiSxfQ2ehxmLf1URJFoq4b+9yOaONNM0yYnycc0b?=
 =?us-ascii?Q?r6tehom2Wdk3z5mhgRu3fDzNW4dicuwbimXHbUIFJ54WTdVfEhO6Wjvz1Zqs?=
 =?us-ascii?Q?HvOawYdampmfZHFGIPh+JAIi5st1BfdoMIbHZLXh2bbuQ4bLigNBm2DAR520?=
 =?us-ascii?Q?l/T/cjdZJrnOUymMr/xLONw3n+0U8NmKaonctR2eX9sHL8BBLNHeVkT+Bk/b?=
 =?us-ascii?Q?jJsdaVs/Aj/j6OF67W5YPRTSYlh8XXc/bl7wvWgwF8wWMI9BbO4QOXg/euhb?=
 =?us-ascii?Q?IGRTX1wdj9AjAPQ+vtnS9BY9m4sbypBrcYUBhXmllJiIJ8Q7FfnFaGUZn+iX?=
 =?us-ascii?Q?5zI+6QgSFQVeLdO1BFqwJQRqQ6dxwFTioERxVOA1N6XIzbc0rN9pDOd2ghAc?=
 =?us-ascii?Q?pAu/QDWpRtf9ozscpdzLyUF9EQapagFuBJHQUyaCaURR9Lct3tbtiYexOQ5n?=
 =?us-ascii?Q?CeGagFFjyK0YTN1W3bmDQJ8dUxQh/J4QYnsfiBi6YfnumruwoBjqS/SVUFLn?=
 =?us-ascii?Q?xbkX6YsiHVS6zoFyg+I/H/sQ7U7kjLawk1PW4hB/z9ANwnBeqMZ4bq7pBT9Q?=
 =?us-ascii?Q?D5pG2MABYhfVLtOWo4F/9cHnxkXSAhivcdAhBRmrfb2IZz0MYWzMgf7KaQ3j?=
 =?us-ascii?Q?wxkZvmHUxnlyr5d3XmhawDQ77uM/GswRGQrTrco4RpgnkHw5QvkatCWISvt2?=
 =?us-ascii?Q?NzItKOrdcybSBE25D5pETdY7bBKyao96VJff4dd1X90kN83mhS4A9IMIaWX6?=
 =?us-ascii?Q?h6fYiDYhowZQF7Tr61KTwBL80ci5MN5dGef2oEzr6Q1PsH0iq386diOtMfs7?=
 =?us-ascii?Q?glQaMfIBl5VTBZdEF2Q6wna99i7h2yuU7CPsMvst/ii9S/DcWDaBNZ6mtMrQ?=
 =?us-ascii?Q?j0a25v0lUgWLNT0cXzuicPBwzQhvRp0PMELsHKl8mBzerARWS+QW5ArxN0oT?=
 =?us-ascii?Q?MFQSYo2VnV6/HtToRDX4+kojEktKkCEeH9AYE3Hyi5n8EbNg31CaoKv8kFrb?=
 =?us-ascii?Q?BhxpNHg9gX+oILey/ffJuV5U4fjZJjqARudF1XX1CMHcrlDEoLrpQf7U6Q?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014)(52116014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PD+4XbgKgb7y49KUBep9OSyQOSuvAAW2Pkv7nCaqfvGTkHp72CW0UQ89afVQ?=
 =?us-ascii?Q?i85FNo0pGAUV88mrzUY3m0gEIxOha4FmNJSwuIrIOI7awk/ItjUnQ8BsloTS?=
 =?us-ascii?Q?X3RNrbHXBEvCywqpm7DP+4mr2+ZCz+PCl59mwOgnYOqDHxYu2SzKiAxCmQf+?=
 =?us-ascii?Q?HINz1L6d9PJG4hv2jppPfDAYDb4BpY5e/cHDABI7SBF1JDn1YBbkUAum9QDX?=
 =?us-ascii?Q?gko76caqsTrEnJTf5S/WUzi7M82jtK1bL2SyCSZhFxC9THCigkPdk22rlu6I?=
 =?us-ascii?Q?mxEx3wwhAnTT9OoUqyVwL05aB+i+k/c4sPbUYtM5log9KU5B7fvscaqsRTpk?=
 =?us-ascii?Q?iaGHo4DBDyCqd4BibbIkCu0Ft1nWyqOSPOQpQ8dl/0UIjmH/iFmba3qBJ2QE?=
 =?us-ascii?Q?M3Cp5lVQ5cBPu689pcbpsxfo5W93gXYD55E8e4stiYNpocoHUgoI/21ESzNP?=
 =?us-ascii?Q?zyY/G89r8GMTXplvTIi5y7vwjqwOaHF9yi6//DEvJ1YyG9AviXpl1D+SteGp?=
 =?us-ascii?Q?FC2fXvIr6F20CSfPPx/n6TXRZT89pc82ygWZCcfnCnuNk/9sJVD9Yk/kfYvl?=
 =?us-ascii?Q?ZMOluksRsU1nDgiDSKckWfV3CU6h+NuOf79R+JMum7fRLgDRGMxz7qfcPpMc?=
 =?us-ascii?Q?vjywp2Q3pvpcbL9YsmNcpKQSH8UJrpgQ3WARFDqFvdFhpm75O0uXClLSQ4qU?=
 =?us-ascii?Q?1C60BoAiYgq7Rk4qpxuF8q2/YgaaZIdtSSwqVRQe4J96nBodNLe3ffWgzfjB?=
 =?us-ascii?Q?MCiv2m6ir9pmG0Ovi5kRO29mkATe2nvvZRc3le9zbITkMCFpFsLUqk98ZRnf?=
 =?us-ascii?Q?wrhc0RBHcS3yEyskSQO+TORz1NizEEEGUkZEAndwNVte3m6UryX6Q3Qw6Xmh?=
 =?us-ascii?Q?SSCabPruICSGbdxxOe+XCIXldcnuc4DhKwqO1AecNYdwp8QRulISRSz0XV1B?=
 =?us-ascii?Q?sb6rW57CG7zjfG3EEY2vxIj66SZ4auDCDAFwtF7LEnGhtxgrvzolZ0GnEWZf?=
 =?us-ascii?Q?k5bu8Qyc01HyJG6slXDLieVPTMCTPzfDCvnJrqmA2j3XpouDfZwMeeei06zh?=
 =?us-ascii?Q?wHBlvTG9+mvlN8k8LJaG+mLuAZKhfz2EhW7P2ppL77pc9vzcso8+8UWUvUZo?=
 =?us-ascii?Q?9Q55C1U6bRyWZKIZRdhIdvig92MqjG8tNLISkbnYFy4SBOVcrJmreVisYsnd?=
 =?us-ascii?Q?tQi8xLiThzqLN3rn5waKCTn9IyiRzxWAmmbQJP13IRiET516lcIE9JSs+Acu?=
 =?us-ascii?Q?g/ArheN/i1nltyxenXMufgMdqtnrnWOJkP6OpQlcpAU0qu3E7N/8xunwqTbl?=
 =?us-ascii?Q?9nbL7+MVNwO7zUbr3t2RKNSxHqJBm1TWhz5hWmYj5VfnGEQKERKxhUI7y1DJ?=
 =?us-ascii?Q?EGqVjYXhwH9bnJKCoSP+8nq9ucW1nX4L/19CWturlndXgrav8X8Vsw6V5swD?=
 =?us-ascii?Q?PYZVZSmZ6Q57h/uHckugGV18eceWFNSNqvYUzL8xh6QwacWr6ZxYVl0Fv/wt?=
 =?us-ascii?Q?MsdPlBvR41gYXmscThi0m+l+fs4xn7d7oB8QVVYh3YQoPLFPg7DyR4j7WC9M?=
 =?us-ascii?Q?ZdAHGZ8UhAkABAkaPuZjfxK25TOQPyYRJ1i0MCVEv7uUg25qdtlJGOnc7f6v?=
 =?us-ascii?Q?YcsmvIiO5H0AJKSSQpZNMMwO6s2MLsFTveqf1zhxh6DFerWKZ2ODEktzrVSp?=
 =?us-ascii?Q?F6zc/P63Z98/cvFM2FmaCjhhFWElqQZo9cwqSeV/F/t2YDt+P/2J8ZVsV6n/?=
 =?us-ascii?Q?WhPXS9GG5SHvNJ1O8gS8JygLTCFTp7k=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f82c51f-09c9-4527-97f9-08de42c5e0d3
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2025 08:24:38.3306 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ppM6xeuFHgnmu6LRtlpX6zXXqt1CLvGh1eHsBNrg9qeSGBA1K27JSiuQ8hHnMBaYxaM9qybvfg9hbOktsm+YjaGTcaZTPS0McysRTfKsLek=
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

Call airoha_switch_init() before creating GDM instances, so if
allocation of GDM port fails, early created GDM instances will work
normally.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/airoha_eth.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index b1256866046..7f984f56dc8 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -861,6 +861,10 @@ static int airoha_eth_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
+	ret = airoha_switch_init(dev, eth);
+	if (ret)
+		return ret;
+
 	ofnode_for_each_subnode(node, dev_ofnode(dev)) {
 		if (!ofnode_device_is_compatible(node, "airoha,eth-mac"))
 			continue;
@@ -873,7 +877,7 @@ static int airoha_eth_probe(struct udevice *dev)
 			return ret;
 	}
 
-	return airoha_switch_init(dev, eth);
+	return 0;
 }
 
 static int airoha_eth_port_of_to_plat(struct udevice *dev)
-- 
2.51.0

