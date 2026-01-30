Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B205E6BF10
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 22:06:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B8298456C;
	Fri, 30 Jan 2026 23:06:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="a/qq4Yem";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34BFE84572; Fri, 30 Jan 2026 23:06:47 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DD8B8455B
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 23:06:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KSGRBaZBFlqOGRL4RtgjjIw37oPsDepWBaOmC9qVGVqelcUbhgLipjBip3hSsWDwNOlcE7b3fEVJCn2lkveqIvVWQ1qxrH0n0L0lWrcyLO66npYW5DN9mUgnHDD4viaCpjoVqGjeRgHDEdrk7++RTqm26C9C6zoNRIbsVis9MYuj2/Oo26mZGKFZNvEk/hnUpdbMnFdLHsyPOyLE3qAAgzZ3G77zavnLb4ULqcWRAPRCKV410xdkbRT/Nf2rZAKWKQQ/em35BH3j71SMgWnU3HkTTZgMyhZx77NjgFuEtnMr0o7vcyAqqPTHoBVSmB2RdgG4rh9oml+LDQU+95dQLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xolYU9/T4YOg/JSFQF0GO+9Q4g7hYbv5S0x41heW6xM=;
 b=RQOyKIeZjevbnPQqakwN24ofUwuzSfhksaQg81RQa3Yz2bBGuGID1acOrvYkdOKlb+JTDzqR8FRndrEwkxnKLwJBMO8wBpKJHqAsNU9xPrdvkcQ3fE14aevbcT3nqPzoiYUj6EEJeW4BAt1RKlsQAbwsKlPqi45Q1BTFCdL+85gdvu2zpw5yj64Cx3w5Xe7FsI8hZouf8k4yU0fEcpjfHILp/9qsagYbzwpiW2OcwVmAC0f4Rwe2NF1V5EUvsuQA4Tb4/Ltwfa8Pj93CFPmVpQgBp93gCdVPq8lQUD22LEU2Uol922Em0Zb+Oc8373s4PQ8w2y6NUtWqHcPeBvgaZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xolYU9/T4YOg/JSFQF0GO+9Q4g7hYbv5S0x41heW6xM=;
 b=a/qq4Yem9POLmNEkZmjmjub4X6YjBKZHiHLjKRYgtFTKz7Qgi9XwtjbGfF/8z58QWk1/YYdMZ6+iUNNJ5WU+1yZYjZRopPqzeKo1hW8WTJQMyInN1Hqr/5yNv08EKNjT6xduNLYv2/L1qAhkNHj9NihwEBL/8As8W7OrXgbf2Q6WbRBLeX+NRUBw1jClxAXmafnrXR+hpZ5JGEcg5y9c5dqoIRAVsOdlVMciVVFg0M0L0eJ+sm716B5AQYDUmTEfcv6j919AxQEADXDbGkgxOdbL5N+hke5uVaUq1bCtD7I8kvcGaU2yiRf0H51D3sPj1K/85qAO5wSfCrTuiOCT/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DBBPR08MB10697.eurprd08.prod.outlook.com (2603:10a6:10:52a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 22:06:41 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%4]) with mapi id 15.20.9520.011; Fri, 30 Jan 2026
 22:06:41 +0000
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
Subject: [PATCH 0/7] net: airoha: mdio support for the switch
Date: Sat, 31 Jan 2026 01:06:22 +0300
Message-ID: <20260130220629.4040550-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0002.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::7) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DBBPR08MB10697:EE_
X-MS-Office365-Filtering-Correlation-Id: c0674f4e-4290-491d-c062-08de604bd8ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|52116014|376014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Kjexb9E8NF2mhwsEafPi+ifjNtN+t9jwSTEArffGp4R3TM4nnH5N8gWyowFC?=
 =?us-ascii?Q?KM9d9J667A1wRxjUFQNdSsZQ6maUVSdBA8wHoFRRuQa7FheQljQmXVXbdh1+?=
 =?us-ascii?Q?I64M4eATw2gJ0y3bcgNC/lgMD3BME0xKuoC7vFIeJvY1pSkYVuo1tSC1Sd8B?=
 =?us-ascii?Q?Ve7jDk3gbDH1tVzFmFQknsJAmCxQ+kIX/4pHpJXcnDov/a7COMoFIcXFs5P5?=
 =?us-ascii?Q?msCgQ5mvXd7u+D8iw7eZqdfDBMieAwv2cyr/plt0cdZtoLVopJYI3mQPXMwS?=
 =?us-ascii?Q?pygsHaOv+sL0wUzCtFqaZ+bWuE8ODZ8jVghTRHmYfbSRHaNhbrAfDEs4oRcY?=
 =?us-ascii?Q?fLD5jYoZTwFW09UPMO2klNxvZDNiwzRwoTogx/dQ06Y/gPsI2joq8jMKvD5E?=
 =?us-ascii?Q?OiPbslXAxxYw38u3s31Vz/S3smdS5z9CKlgfq+SYhjPeL74LoiRCyMPYRSS5?=
 =?us-ascii?Q?/0DF4E9oPRIgYgYyjnNWU6HzxAtACD5fXBKGwMNDU2iXKbnUqA2wRY2Hf9uj?=
 =?us-ascii?Q?47O4xvWsWaGKr5+BwAIvye/fT0dDQ4Uei8rLpRzxVsIN8vj5ZenNklDFnMsD?=
 =?us-ascii?Q?0ma9MPTUUq4IgdA03VrPE7heyv+KeDmWMWCtRDkymsH8gs94dw1yweUn3fPN?=
 =?us-ascii?Q?1QrpwKCRXT3DlJlJG4UHPy1PW4EfSZgAjjOSadtyiLU7/kO37tT7xQtHXiwY?=
 =?us-ascii?Q?zXVpHDYBE8mw1QP8SNoFNfbNCrwRBE0GTRfRS2olTKDJJ7W8gSiL0dTvanWV?=
 =?us-ascii?Q?p0N3jbd/PTbvthC0OIMOobjITSgx/p6SjpuK5kGIHM6X6aYHDrSjlnCi9T9M?=
 =?us-ascii?Q?CiMn2BFneC7KLRjkUeg0ouGZ8yhW5Xa5t229HZCEpXeipyCOKedFU5zv7FJX?=
 =?us-ascii?Q?25cHX57Yti1enmN2GmoxiKlqNuDuGFFVF89Wsgf+/PS13+xvZ8n0aCmNJaiJ?=
 =?us-ascii?Q?5rK0DHSds3Fni9ysSS7AT5ozXmIYHPFvJrltaImDJLiWJfC9sXNCDWWocNwd?=
 =?us-ascii?Q?NH0AUo9EsP+oqE4zY+eYEk58DgOcSkWYHlcGOpsBfISl/hCqri7m6sOpt6Ks?=
 =?us-ascii?Q?8X1jD8EyciWzQVJGRyAx6hbrEBvorwmbvyA/uGy9fXmmvS7OLxQfR4lyb+dX?=
 =?us-ascii?Q?MwWrSAuJxiOJUmUf0lVPA2Rzy+eNC/kSsVg2Rc945RcvV6P9CNHL45xHIULP?=
 =?us-ascii?Q?H3Y3va9g6N4dt55ufWq+8FwpRTXUUDp5l7p8Kg/QJtFigKU0BP3sKdqI6BI+?=
 =?us-ascii?Q?5Kf1lO94BYgUig4AlZ/RcNxolQXNkqZSn9eL4q4gjuMbz5EoyVda7qZ2DW+x?=
 =?us-ascii?Q?tLbgz/eM80bwrb1AtGX9t0/5tygo9v/as9qB3tUtS9UX/AHelT9RAiLDHIN/?=
 =?us-ascii?Q?rU9+gEpDLBCus6F6EUdhyXg0VTGJfqNXmReUVfn2V7I+55eapnpsuEFAodAm?=
 =?us-ascii?Q?/VHnBq/PQAkA9Ayp67JobvApR9NWlCS3Ne2xxnm74vkjQDJOyAbnvqvmj92E?=
 =?us-ascii?Q?nWlXmwjfdfJ7/Kw/MTW8nLJzmDlm5k47LYgjoUmRUd2GbaHlxGmgG70A0yyX?=
 =?us-ascii?Q?XdYd0OhWtnkfgOi3wq10VHdAjTF0RAAXZ4jE+ujjZwCSRchISHRIrLr+aB4c?=
 =?us-ascii?Q?ZXl4lIC17pQZ6QKGzdPPNENYegTUOwcYwrMYapp6/kYh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tgxg1BsRZq5sEfGJQ9JafKj7k2BXzk48XnM/TM//mx4apL1iz877BawR+8Tw?=
 =?us-ascii?Q?NiPvcLShaeY0Mah0TJ8fhSvL3Yvuz8ZKrsDrAK6CQnO76arb8e0gfU6NdrSj?=
 =?us-ascii?Q?hUQu1jAeA/4wYFPPLZa0UeI7fviFQMnbwRWlzF9sd+8v5NHx8Yx1m6TcnqJ2?=
 =?us-ascii?Q?gogEPG9LTvfTwAbXn0iGF8MUR2V6TbtbhPo4xgTYo+LprSqBz3ChReKepKjJ?=
 =?us-ascii?Q?U86Yg7Sv+jQ5Xfel1ZGzpR1pXBlkAb3KEl7ih8sL0ftgt+jhpB/19gGzecZq?=
 =?us-ascii?Q?NgcP/tNkMRgnrQ7ylcP/Zcf+w808dAb//q7nmkI2U/9J8Ezyyq/cym193N3w?=
 =?us-ascii?Q?CgeSmLJb7GGCBo58TdR98Ijj6CduUS+GyF++ZfroVp3z+nva2c1qVNQI4exc?=
 =?us-ascii?Q?4UVvQJgeIlSH5B+sgS9UEoPKhRMK3ECU+6oGcqyopPxacqEoIQVhn4vuht91?=
 =?us-ascii?Q?9bKaV+TdCHGGBpRe4BYppJXMQUakopiKwgKqRIrzZY8kV3sLcMsNsqlc9itT?=
 =?us-ascii?Q?yRsk71QxpfZkdnkdvfdyghcAQtePZlgPyRRUElsCtgS8Mijf5nVzZG2qlcZ+?=
 =?us-ascii?Q?ca5i9MxqB/+73DuQMsUniXyvUj3Z6eZyIK3kxVNBK5gf7xGW+dcmOS2RzUuN?=
 =?us-ascii?Q?/k63GRZTyanL1V+BlHkOIkkX4UIYX/MhOVe1RFYgnMNA2Jkj1uWkaOeY5ZWk?=
 =?us-ascii?Q?wy93vlog3KGRNL5AUrzlGkp6QM2Hzr/k/80XvA8P0VjHo6dn5F8apfTt4pt4?=
 =?us-ascii?Q?3r4HD5tOJJcnlwQtHia1cHOPP4cJtV5ygx4w8XvQXrDEh9t7J2ybjp0Kb6VF?=
 =?us-ascii?Q?Wor3E5PhQwspxNeK/Xwiufo9zOsSV9Z7vYHbVkN4HHKmk5c7No39UUfmwmtp?=
 =?us-ascii?Q?+rXOPBVqUdGhnDiKE8U2driqhDWbquM7U9V9Gu4qiS2+0DUC8ryJPsN888od?=
 =?us-ascii?Q?jgQkV05EBn5c6HGTZU6jUpYrBpK9L79Ws1/bwsOmWQcVTsAVZPQgz7p7hLeH?=
 =?us-ascii?Q?8WGZfSRDfoQ+tXTm8aZzoA1LLAAHmqI4mrBFaDpvY8EQrMxm7W7gnDo1oyT1?=
 =?us-ascii?Q?Sk03zd2218GE0x8Rkxw1LHItH8JNZu9tL0STVGM0QaKbYP+QI/Ga3VUeGVlV?=
 =?us-ascii?Q?NtvwMf5TcxUWdKlUsvplvSeXwsjm8xmD0LX00Mn0ePVlmTjDvQB9x08vxkI8?=
 =?us-ascii?Q?ySzfKEr4hfANavcJpLOcj8I7cp5irvuy1XIMcUC3zNkDUN/PhRyDVsFLkeHj?=
 =?us-ascii?Q?iFolBJIAZ7dmyw3vo8YuchMT1W2fxsZSKkJqC+szHe5qzGGzT71iezy53kuQ?=
 =?us-ascii?Q?Kg9bYWt4aUzJJZ22x7C/kaAEVAuivsQfvoz+SF0UzFeks3OdysWoNpfFM4Gq?=
 =?us-ascii?Q?0lNw1tbzzsJoNGC/dBPe/0oYtZHZxu8nOSy6ZOTuCiFZuzKWBjXLFwQjnUJz?=
 =?us-ascii?Q?luu7aKUQiTaTRplmX5C9ScZW0Ef1/4miGINneXe0RokTY0xsSaAUSXI182jK?=
 =?us-ascii?Q?PQduv1EdwV7NMFBKmsiWliZ3lpqz5LRwABsiCnGhnHkcfMmT5usRCmUbTqrL?=
 =?us-ascii?Q?2ha5cWc8Sd3yfHI78sdLWK91Xs2vKizTV7uJvEzfkfLGnlIyoJ7tRlGr5xgp?=
 =?us-ascii?Q?OpWNa3s9F9hl0Ny40mb4g0DUA1vSQ3aJbyG1kqq0P+VOSzWOy4y3fmLInzX9?=
 =?us-ascii?Q?fXAQITcRHu4GwrnkiTIj+1bXewU3M49+L2V/imFT5f/zffBFG8eXyJSdn9o7?=
 =?us-ascii?Q?joRsM1Px/jw6uXHYHy9tTdLnS1sVK2k=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c0674f4e-4290-491d-c062-08de604bd8ec
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 22:06:41.5054 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: efXNBmohT7QeZO/xp2YW0tceD1DFSRrRa1nQc57ozxDwVKKIPBtaW3r0MYD8tzPZlGOMmsXRGkmQicAo2aOiLfXpRhk1mI+fXJOTcAbzgyc=
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

This series of patches add support of internal switch mdio interface.
The series can be split on two parts:
 * fixes of existing code (patches 1--3)
 * make switch mii/mdio really working on airoha (patches 4--7)

Mikhail Kshevetskiy (7):
  net: airoha_eth: fix mdio binding to switch device
  net: airoha_eth: use proper switch node for en7523 case
  net: mdio-mt7531-mmio: fix switch regs initialization
  configs: an7581: add mii/mdio support
  arm: dts: an7581: add mdio child node to switch node
  configs: en7523: add mii/mdio support
  arm: dts: en7523: add mdio child node to switch node

 arch/arm/dts/an7581-u-boot.dtsi | 5 +++++
 arch/arm/dts/en7523-u-boot.dtsi | 5 +++++
 configs/an7581_evb_defconfig    | 3 +++
 configs/en7523_evb_defconfig    | 3 +++
 drivers/net/Kconfig             | 2 +-
 drivers/net/airoha_eth.c        | 7 ++++---
 drivers/net/mdio-mt7531-mmio.c  | 7 ++++++-
 7 files changed, 27 insertions(+), 5 deletions(-)

-- 
2.51.0

