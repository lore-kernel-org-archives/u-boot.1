Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BEB6E6BF3B
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 22:07:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AFC28458A;
	Fri, 30 Jan 2026 23:06:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="UOHVOaoS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E9958458A; Fri, 30 Jan 2026 23:06:54 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3920684581
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 23:06:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f90r0YwT8wkyT0MNLpkAa5VKlPgEn2b9w/BsT5S9gutzOTiNyxZKzNdUHwof2jaUK0UvtoGZViPaIzu7iyOX94OAvBX73XQJeBM32Q7sxufmS77C0sRj8nqpa/rR1UL8PIi7eOnMB/xIMso/gnn4vjtd/halKvwfUa6bOu+nPlcQ/ajgw33EBEakreUn9RtPHONzEZKObqmt/n7/VVIwlkfNCRmAk/mvfkoD+aK0bEiL9cVxaWO3V9OMODzZz0v1VAM3Fh+0i4t38CmSZ4XBpn7Wlsr5PwZfIJ/sqJpmk3q0EKkI1VEMxX0fbylk1GJg7lXv2YCV0F+im49fi5Wm6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9edsD/gDGw78YrzUmyf83KZeMMQanbRwap1H2YM8D4M=;
 b=oHtg3OXGLFGhddTeWdflIVBJ/f483C/CGRgyu5J2copWfyWho4eJm6XDMORqW+jBXJzcBndzIGpHridfE5WDePzCorHZN6mwpNkFaoF5rPhWU42lXpQSP5hhUCF36IYVOBQ8yuUsuUASLLjFIlGUfLQeens82FCoEVkbEw3c6fRv+Op+V0LbpiVAovZBvn8/CNM7HeJRzSiXwsygAMaDvgV7RorA8QEKBnVgkmLu+hWuKsqB00dK3awItIB1EdaLRC0TJZ6SQVARKdGNVy3OUP3pR0vNo9pyUy9ji/5/TGtOtdqIefUQ3CbRa7NeaJyyG5XzUsqiIEQSltGmBldRWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9edsD/gDGw78YrzUmyf83KZeMMQanbRwap1H2YM8D4M=;
 b=UOHVOaoSJs+N0pfheF1pcg8c1FJDSSUxmu1HcyXftHVsnCdbd0IKOJHpfXG9UARLgK9nCGmDrPYbAmts7oMwI5eL5/ZXrWA6Tf9ccPd2H69eByXp542L6Tf8CdhHz64aqLY3TrMb9rqN8N2aiLxbVed7e7x4nply+WZAHIm2sRdBM3LDsFmqDp4ga1imtXM71wyMGo0sQgh1S53R4u5yDSu/9qAQmpaIYSkNVQvVnhKIou0QIM0a2XQ2Qg7DThdXDf4mjULex+WC+7AUS5pBfSf4+78vdDGUruFwSDjDT4SMXNhTK4q+uu0FM1WMZxSTS2fKGEUWqZzBvFXZKwVYaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DBBPR08MB10697.eurprd08.prod.outlook.com (2603:10a6:10:52a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 22:06:49 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%4]) with mapi id 15.20.9520.011; Fri, 30 Jan 2026
 22:06:49 +0000
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
Subject: [PATCH 3/7] net: mdio-mt7531-mmio: fix switch regs initialization
Date: Sat, 31 Jan 2026 01:06:25 +0300
Message-ID: <20260130220629.4040550-4-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 9742d476-a78d-43cc-2662-08de604bdde4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|52116014|376014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?26wgG2feYr32g0ov9+r+FJKSLp3km64kzQ5NchfhWZenrcEqp48zqljkr6vI?=
 =?us-ascii?Q?1CsYd3xFZs+LSWxpraloqy8Z0kAtPznF9DCKpTkx804rsAsgZyEjqIMa7pio?=
 =?us-ascii?Q?SEokIiuMQ2pGTOeohmLilNPLunh8tCzpnsfBKrZOvrh8R1aekHwjQfxD2SHM?=
 =?us-ascii?Q?hB9y6ycJ2IqTk92vbYPJqjNhbl1b63c5X52dEvsrdpqwjpnZOWvY3+Mnmkdn?=
 =?us-ascii?Q?dVzV+xlKodnVtHOJkYxvmZPm4FRp1s8qXZvwbPYYvIgC9qxw8NYgFI3fFDy0?=
 =?us-ascii?Q?WZGxLgqwC6YoHgtz2hPjk3Rm6tN3TVRQB0yfAaXHwP/mrkIFs9YfYhkY/sWh?=
 =?us-ascii?Q?/RfxyfgpK4IID+pZQJjq7GO3Oc2psQlIjLHKtrs4t9h7XB62F18Pt6/xi+FH?=
 =?us-ascii?Q?/YS3seOxG0zCC/pRb5wMLOWYTzyqFQRJvhTCx4odySKTe9dFsTMM+e+hwsSo?=
 =?us-ascii?Q?uX6QJgrwBcoM6Kg4tDpDWaGp2E5589bdzKLtb5EpPSy8ht4xc7s4vRbEBrmt?=
 =?us-ascii?Q?YE32MXNXZBj3T4sQWMUco4Ghp1u0OhrUhgh5CU40xQDIl9GENOLt2AL9VMxC?=
 =?us-ascii?Q?timG2o6Js1ALrceyDk4O0lcaJw9LMuT03Kw4s3KYuYj0Uz5Bo4E4x+mSX8cr?=
 =?us-ascii?Q?gF6Ay3BQlHwGfo1/HrBNMZip+s3pB7EdBBF0gETVwHkqkU/6A2j1PUtQp2q2?=
 =?us-ascii?Q?Tn9HlePcSRNjepc4hFtRA5Nal63kKHg4vXJ8+cLltytOevx8tZpn+yLRR/Gy?=
 =?us-ascii?Q?n6vEyuGJokhd8neO0I3e0VCzrjwYO3nFc+dtoY8k9Ikko+NoC/sREdnRvlJb?=
 =?us-ascii?Q?Ntdt6PH6ySXFePqTgTStYHtSByEKfNgvGz6r3w5idx9775Wc8MyDJFzGiiB/?=
 =?us-ascii?Q?M98rBKi4A/V0fsfYQ2ENFgxh1gJg4D4batniqB08HW83k+92pVHvAu2IfoFD?=
 =?us-ascii?Q?j8tjmHrsWhYD4aTVTwQDok1+KowLqIvrRszZ2xWtx2nnvY83c6Oyok8ecED1?=
 =?us-ascii?Q?8V1QA28Qj9QbaNjLjGW5CYZnNRqJXJwKmSML+n6wheSwrTxyVhFvYJEKccZn?=
 =?us-ascii?Q?zNowcYlUv2YH9Hh+vRJvibyD6EKSSBMUWacrgBY9hfrWAiedgXqFGX+HsWif?=
 =?us-ascii?Q?JG8+AZWSq0JCis4+IyaFKSBJp5KI8G8vt7uMFK4+6gcfLDlt65FH7MfF8TXU?=
 =?us-ascii?Q?3m8hNEOuHfyYRkp0OYDc4vyCbqdwkmBdO+fnFBiNHRXCpYbk4KwBW7sg9fZh?=
 =?us-ascii?Q?IkopJVvAR5GgZSS/oVhDKdUTCzPdparNY5KbZBsDHIH2l6pfvv5xqNXIDjoQ?=
 =?us-ascii?Q?e4zC33gQs7cl+8AfVN51YuMd8+zMIuWW6sy3m0/PUlq3aG3vF3U85SpwLhUK?=
 =?us-ascii?Q?9GLGDVMFW0OeEQaRYk2/1UgbIMes79WYNt2qlDHnSByNVX20Y+MHeE/nGtau?=
 =?us-ascii?Q?DM9B6cDmyL+KeUtAUHmCvbpprVheMhCI3MNZIXZNv2gxlsKY7LGw3ii8L98o?=
 =?us-ascii?Q?+9xSARHi//puX4ITGQ241RehV07O3Fmdxx8fy9HSpJY3/A2V9nlrB7O/FX5x?=
 =?us-ascii?Q?d4/V1/Mei+oCUyHc+hXx8q2/YRvPGMru2phGt8VkqZb8QogibMLVQKoiJWmo?=
 =?us-ascii?Q?L3VUO8QFp0bzV8zrUbx0tkk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+eSExAEVH9Zh7wghMk5KBcBhVkiQCjH8AJRiwiwQs50H+6L+B+3aqSLQVzK4?=
 =?us-ascii?Q?h41Yn2OW9i0WYBgqAGHJNp1jmlf1YjDFsrSC2133IyMQOSklp7v6Hg4Gb59y?=
 =?us-ascii?Q?CBkEW+BHLud2XhQtJh0becO4nYuwiv296kFBzCKxfpjF08frcCO/RQz8LuuD?=
 =?us-ascii?Q?5evqN5JT7ful0Czf5uKqbgZnBzL1PXCkmSIJBEPhXQWi2E5/yPl58fiJXF69?=
 =?us-ascii?Q?+vwbg1YBxFAcXYUcxSka9hSUBor/MMr8lT809vfrW5oS9gkUF/7cCRtVj9I4?=
 =?us-ascii?Q?492o8TcyIWRyupPtXHXxQ8Nz4P6851wTAycCS7H9AxdqTNn+TfXColz3rBkd?=
 =?us-ascii?Q?WwX1UttkO2++r7tzYMAqVZI5JI6Cqn8lIYx2FqISghSgxfS7DDfVFse7rmjp?=
 =?us-ascii?Q?VLrQAn26lTWWQ14V5Tij38SeKnG6adQo1vpybbo8rLYKKIoANvMT0VEkGBmE?=
 =?us-ascii?Q?UHIFp9AxCYINfKCtUoBen9U8mx6guqNxq75fO9bH3dV2JnKfndNcrpmetZvs?=
 =?us-ascii?Q?gJkmt4SZ2wRFkG28c0VymwDvp1q4+GMeZsOMAL9X8MBQcGD0VtIfH/ZQYEsc?=
 =?us-ascii?Q?wja7d2Ky5epJGLJ9cpkcXzUwbwnmXGghKj7wTJhBriJVhxPjiu4SFwKX//Zv?=
 =?us-ascii?Q?Ms80b82iRV2KyltTIlTbh8z+KFLW89CUKT0Xctgcz4QULkKhXpm5CoZidJh/?=
 =?us-ascii?Q?PiRevBQB8wX3GHpstzvwP8zHVgv7e2NGUX6BGkOzgiSjXIqGZY74Yj5oSheX?=
 =?us-ascii?Q?eM3jCfg2dHcBaV6yJxO2qHxCrPT86eIV5HF21gxnCIR+qnEVuSsBN3LAmjnK?=
 =?us-ascii?Q?yRww/sQmg8nG+tzYfnbGnjj0Rib1Az0IlTnH5ZfGVVRU8vmXULglsNYUSzrC?=
 =?us-ascii?Q?uBKk0B0sggXBX42NJAI+9e1fO8iG3mA/2fXy26MuFL+v0jgBm9xIYfvRbwiM?=
 =?us-ascii?Q?j+SnmI0NhP/9nXv1XJJcLxTsnGGF27z5Q7QXHFjAy6YIUGd5qj1a+SdHk52u?=
 =?us-ascii?Q?1la3S2PEd1pLD+ViImk5xFCgdZdzJ9/cTrfH3Ipm8/RGI6uWNxbghrqBCE6s?=
 =?us-ascii?Q?AP/SouURNyH8uL7M3hefGN1zdEvX+biO2TiqCkZR1V1tEZqkE3r8hJJPvPzf?=
 =?us-ascii?Q?pqYZ4VePOuIqYPAYKISuon23bi3Lricrdn2XRph8DCMXObuR2lab1sZZHNyx?=
 =?us-ascii?Q?qGJupJDCEvUJiAgKVzMA/3Dy/jJtwn9iwMP7xExXBkEkkooj2tYFm9BbrzV8?=
 =?us-ascii?Q?YMBypX9bjwJUJnIfs5GOCSOfWpg5fJ8Gm7NlnYVOlOI+paanPmuWOg2dZoeq?=
 =?us-ascii?Q?RXSVMw2tU2VBTvPg5z5u6GStn8p+IwELP8mJGdr869/Ru52OXsO1vHIYD31t?=
 =?us-ascii?Q?GzEOYhY42dmH1sN3RQLjCh3DSLrmFGJVZdJyGyo8l8CJnLqS/8VMoLA0XsZJ?=
 =?us-ascii?Q?xC6N8biZB7M3V2KHMvVokSnJE03CBYF/0+/rvT+A1Jf3xcNbU7t4k9els1DQ?=
 =?us-ascii?Q?n05D+1UO0dM2LikLOyfyqJxJe8ndL4+r1IMx3Cz3mQPwxy9FeyyDbO/pZ8xN?=
 =?us-ascii?Q?c+fYWaSvv0saHsW4DB3tMFVxZCqLI1l1fuZnqnLlgkJZc4hs7CGMUP+UlIep?=
 =?us-ascii?Q?BLi0ytrwcy0+rEQGsAQXoOv6h5XPJLfPHzOyOcGwCuunpJyheUflbFEf67rQ?=
 =?us-ascii?Q?VMhBekciWwPPrfZJ/vsSDTcX1Jmu53sCWrCJYeNvEXkUFaDmXYfyaDr8H1kv?=
 =?us-ascii?Q?Wr6XOhhwtYKAmJSffHFR0+O2881HI10=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9742d476-a78d-43cc-2662-08de604bdde4
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 22:06:49.7064 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YZ9roAe+KVBwY63g/pzJGvzAWTcew0kPhj7n4aDsXgmpLER5eiqHeeIYBjzRtvvwXxN5a1n7hPy5vJwbbeNEG4mhyq+EldlYfQU44qEKwzk=
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

mdio is a child node of the switch, so to get switch base address
we need to lookup for a parent node

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

