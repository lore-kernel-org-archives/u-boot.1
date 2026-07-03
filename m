Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC7EC43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 11:56:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7788849F0;
	Fri,  3 Jul 2026 13:56:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="MjLgRQ6z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7145684A0A; Fri,  3 Jul 2026 13:56:46 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BF85849BA
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 13:56:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x2qNVW2knuxGyWh9C6cAzNaLRk3rxWQpKBwXVopKwNJoqMt7rl415mIKyh49nut5IBbxvVz2/Cyh+aI1/2l27v4hwub+ypY2nQX0cPcPBbIaTFw0M8qA4cEWgvIk2wvWKX/UGW9vqAKaqobxHfR0S3TdwCp2fE9vjgQ8PgpCkOPfQ8/T3xCYAso71m+AEbZVKl7/IsFUdGy6ksLN6Apbth+yBIcuFo+C3Ic2LeIBj7G+lYoCu8fDP9/WEkYZiZs78NhTRw6U3OgUDZAFkrb8WV+TXcu7Av3Lt6bo1H+2EgN4+VyLnL8X3ay9KV87ucmh7fqRmcLEsLKf557Ra/sBzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKkDxC4PLS4DeJwVH08W8UwdSA0mtfQrrlFq/H8Z9b8=;
 b=S4XSSd9jYE/p2kRCfFo77VUOpsCwIejoLaxnpftHMU2MjVhEQvWkclxnyEc+ijZQaIJtb0v2hCOE5b52F9yHrA9+AuDKfvnJEJTylnAla763x1gXOfB7uFdPJj/uCQviggUhP9BcsCtPWsksP2tQF+Q162oSEtjI4OTHmL0Vtfx9WaC+f1FSSSKeQHttBt80HXwdNNaZD06jFCiH8V+h9qV4WqCBiL3y/bdlmuH4uN8ywvMphbOe4Du9TQyYrjiU0BPb31bRq+JGvPN0V7ST/kUPqSOi6B3rK5kYB/iF2qmYoIjPqiWhzNCvhwZV/msBRCHhZ6l19AQUzBDLUHYqEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKkDxC4PLS4DeJwVH08W8UwdSA0mtfQrrlFq/H8Z9b8=;
 b=MjLgRQ6zG69zoBMcVZ9nbReZhVE+IDqXi0LVd2x0U/uutqwMnBcBmOJhzJXnzj7rrtacJljNnCHHqRZW1eaatrnJit79AB/UtTxdkvSzi+ozuSgFK6QHn6cLR2iMYSVzJbw7txtR2++LewL0Sv++SZm/LIyiAmaj+3Ucy6ugcubHRxrwWabXYb1aHc5VvEXN1M8wcyzd1/3/J+c4xC5VB80noq5/tFyUmU4OE9yLHBXAAqaqKxZe+0BYo21HWVn96T5MwHQ/nM5yeCKP3+NxxwZU+V5uXyKG9P74E1DwjDQ3lxwt0KF4DlStVxzeK5MBm0CEDevRSDxBnkot+RRmag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PAWPR08MB9448.eurprd08.prod.outlook.com (2603:10a6:102:2f0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 11:56:40 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0159.018; Fri, 3 Jul 2026
 11:56:40 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Stefan Roese <stefan.roese@mailbox.org>, Simon Glass <sjg@chromium.org>,
 David Lechner <dlechner@baylibre.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Michal Simek <michal.simek@amd.com>,
 Sean Anderson <sean.anderson@linux.dev>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v15 01/24] watchdog: renesas_wwdt: #undef field_{get,
 prep}() before definition
Date: Fri,  3 Jul 2026 14:56:04 +0300
Message-ID: <20260703115627.2317120-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703115627.2317120-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260703115627.2317120-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0194.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::18) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PAWPR08MB9448:EE_
X-MS-Office365-Filtering-Correlation-Id: 0db8dfd0-035d-44d7-2052-08ded8fa24d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|52116014|366016|1800799024|921020|38350700014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: R4RBaoGu7twz46ME46NCC6GPkQ68UAGr2fMnh9wpbVLohQqBst2uQUgp4+8V0cPygSC6N93OOaCFKdDg+Bh1TD8HVby9c4+4YgYIOjwTQQ5mkFlqmu4eoqh9KumxnF9xrxk4TSKeh8RB/5JdBQ8t9jzkr7KR7AhnviuGDK9EQ1qUeowiH+8D49JPk8D9FoLxK5pKr4mhvzOGnj7MkTaE6ysJtt+wuFJswwGeOHHtvDYkdcdmQptQHOlJe6XlMLrUv8Q3QC88HqsW2wHlYQSbhi1NObxQedNWLV3s2CgztrbYTJl2HRh72n9zQyjfCwGMc7FOqQ4zV1L6hrsBzu9htx9Y2mia9CGS5RldBa+shTK+HxhDjQdACs5bkST4wLBRVdS+C2VZkhoV5z6QZgCaYqO37b0ifPYjehNBzXfpL0KoN4Mf+onZH0oVWtSDrlVuXqfQ2e0FL2O1c6nFD/SWrau2WKjFM6tyJAI4RLnem18s5lIXhDY9uO0QS0/LGDj6e4WsCdk0rwXBB6aCP/nNlKZbEI8QZw+TEnH2zPCNZVeQSUqYr6qro+EgcnNhMgVZPgkeVx43ZsoRt7bXhvxCQXDhoRId66xTwqBbtnC0g2buF3qpsR5iqwUCR7aDIhCCaulq0YfVp8upD1vr+CTUYkvfb38s6SoggY1LaJs4zIGmb3IJ1htVg0sCDzW7YFXpMfwIbZhdTWK0H5y73BwqhxW6PvnbzWSeJPSbXlUav29OmELXdPrqw/zoudiznAce
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(52116014)(366016)(1800799024)(921020)(38350700014)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wFzeS4CTtdMZvGjqeCxaVQHgEoAc+vs80/N3XgH9bcLx6NALOZ1g1j0QCzX8?=
 =?us-ascii?Q?79GCt2I6frr6sfkC9ooLv6Mg7Zt+kOvJXkEMhmcO4Qa4Di6cdvSOFodWJ550?=
 =?us-ascii?Q?1SX71gYTxmT9mDmtWjGxyCLUnkiQ0aOXwRuoxj8jOG20omBUMaA/b/ZpR9i9?=
 =?us-ascii?Q?VoqENBzslMLJN1OsTs2m6zs+41UE5fd3UwXHwnNRYY6LOI8H26t1wUzJ1NVq?=
 =?us-ascii?Q?svEKLHOf605LsSyyXjE27QEVNG64oR5OD3B0fhVG8bD9Ulw2OFpOQCh3duh/?=
 =?us-ascii?Q?fFBw0AEQj0NFgEXJweRrMbhFm5Km9zA58Z4uY9td6RbKQLFW+Wh1rVhLDbcN?=
 =?us-ascii?Q?NUTOhccdZfvBBO7YxBFbtCpaHsTWJmclxWW6B7h71PAlTZB2UUnxFxh7ECj7?=
 =?us-ascii?Q?eJO5PrQxL1g61YfgHrKzHbCTbrXx+xxtKNsaky5o+Ze3A+ozhHfJdrQ/glr6?=
 =?us-ascii?Q?ztdkyvALOEsYfzZbc7y44b4/jIeE7HA4t6e9yVabVtu+B2Vz8j9bImR0kXaL?=
 =?us-ascii?Q?/owCpp2yF79pyFMMqc9oFiZpwOpL0WihKck+Pz2qX0CCxBsmNWFPtx/+VeC0?=
 =?us-ascii?Q?GRzfGtxdp12rlGkLlxGfKEpM/rvNYqyvpbtlEV6TqbQLhaiM7kPwF5dev7zX?=
 =?us-ascii?Q?YqNYSkqPiHYpWVYjpFWoTVOdMJrb65iCJq69jAdcTK9OrxghpNWAV8miubqC?=
 =?us-ascii?Q?LljAX9jCbgedt8U4EPCnoP7jUwPjX/gs0WBkbXkASu1UNfDnDfnCxSuVTI0z?=
 =?us-ascii?Q?UTrR6BxZfVCc4J8kXPcYq3ZJoMCV3HDNSg4pkR79+XMJA7Ei81b2bwiTTnFd?=
 =?us-ascii?Q?XcIxiN0gtEA4N3lqJ00HiVeS9F6os/x7gdJgCHy0LUl143qPAWv/s/p+QtXu?=
 =?us-ascii?Q?sIkPKQJOEhhcJDlfZYgojftE1toFvJTyPTZemnEfQyvwKeT1Lb5b4ZhgXLZN?=
 =?us-ascii?Q?yR147pOhXdITQ7SVnF0ZVdSY1VtBkuzNKvujQln/MrAXzt9RoXce02md6xTB?=
 =?us-ascii?Q?mIL/mXIwexeTcm9EKglN4dq34pt9EGQV5j4k4NaCk0bci0xwEweppLRYcp+E?=
 =?us-ascii?Q?oNw/XdX/nldM4kc7HWOs8HY6xxkn3S1z9HGVc2P54cMFtDRPjHueeVWmJpfY?=
 =?us-ascii?Q?194D3Zx+lUT9euKh3Hj5QEJLd/+MJPV2lFFtt4qM9MfIyrVJNsKeI3c0PtJj?=
 =?us-ascii?Q?uoX+ezxO0VaZGkk63PPQd6ot9Rf2aUvHTL7waldiKycfPJPPaR1EPNitgnyp?=
 =?us-ascii?Q?jdKJSAhNeoMcvKVL4JV+7rBT3sufzT787Y4EeVskunhBno53gJkaWISwJNVq?=
 =?us-ascii?Q?9iCzrJ7Ip5kIoBpllLVg8RmJEC9O3tzcx/C/RCZ2c8z+c0zSinjDjVSccRtk?=
 =?us-ascii?Q?NfLBC/JHB4hN+I8pWR4bEzcpMKStlG98G3XuMQwxSWh8ruu84bfi+qr0LU9a?=
 =?us-ascii?Q?hJCb//J3yO0T7v9pVxaN11wX81KZtI0pKWHoxdeLPu/maaI34Ae5ybjarqV8?=
 =?us-ascii?Q?/Yzp0GhLQ2/arDs39Otx5GQZ2TdYa5FqNYDuiiOzOXpCANHJeeFn0wC83Yv+?=
 =?us-ascii?Q?jlTruKYZ0ffP3c7atCijMhpRSUE+A3iSOmAOVNxJph9Qjy66zo8N7zv3Ek9M?=
 =?us-ascii?Q?P3H2eJcNc3V7+v162o4jMQ/Fc4Ub9BibX/13nZvNutoyF0CqBDFCsYLQvaTI?=
 =?us-ascii?Q?8bFipI4x1f/ESNAcX8SghGb1QWSFfLXGZBsd2DUZRtFkBHKBUcDq0LrxIBxF?=
 =?us-ascii?Q?Av4Rr6pms0gnMBrppTGL2zt8mpEGZKo=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db8dfd0-035d-44d7-2052-08ded8fa24d8
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 11:56:40.6768 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K2Nrj3THawGSX7E4/XPyrQMjhgWlz0b1Mdm3BcfVom833pxfxlloXg9BLBKT4RvKGXdqUnxXxaKM1Y5oxN0XJxlz/9JW2om4OVkcvIidKvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9448
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

Prepare for the advent of globally available common field_get() and
field_prep() macros by undefining the symbols before defining local
variants.  This prevents redefinition warnings from the C preprocessor
when introducing the common macros later.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/watchdog/renesas_wwdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/renesas_wwdt.c b/drivers/watchdog/renesas_wwdt.c
index f6f508c95c2..92e639a91bb 100644
--- a/drivers/watchdog/renesas_wwdt.c
+++ b/drivers/watchdog/renesas_wwdt.c
@@ -13,6 +13,7 @@
 #include <syscon.h>
 #include <wdt.h>
 
+#undef field_prep
 #define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
 
 #define RSIP_CTL_CFG4		0xc0
-- 
2.53.0

