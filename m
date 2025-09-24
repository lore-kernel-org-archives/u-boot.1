Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B57CAC5A5
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 04:20:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AECFC80107;
	Wed, 24 Sep 2025 06:20:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="GzLM3fGB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05AD98341C; Wed, 24 Sep 2025 06:20:50 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11E12800D7
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 06:20:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yxt2KczrHFStohbFa2v0h/OsKrMJebX+nli1B6dg3+96VkTNvoIChi8geT44y7sRm0A19oTkOuAv5XUBQCkX3HakVL/otILCE2K/G39FaMZyAtzoyGFzsronOjrsr8nz7It9MMcEr3n35/nyWWfzeuv3XIrVDSMJLoL2dFOix1VcPrOOUpa/jQY07nN7r17uuiV9qQm6Kr79zczjfxFkywrlZDDkhmEupVhAujRkZIXgrkIEBYnk2+VQ+rMI4J1ed0pcVJBXfw5f2RhcS+VzsXOriWbkT+p5tKHiE2Jc9+9bvpi6ni9YJNg7ka7DfSwQ0QR8w/FKTZ3AKEp0AQpFFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyu87XirP908folMApb9bi5bRwCWEd3f3LJ0UyP8VHk=;
 b=lyavUI0TUVsteTJ/OhzB2sxQnJ3KFeQ+okqH0KdgWBZXCL3SLXaSNeyG08ijSAm69rYa2pO/gyShh8lVXfs9GJAWVNSKWiooLyQJ4yfhiN347O7JULEAIsWpI4YDqCtQRYiSRx6bt5Cy4KcYk8YMj6cG5eVFhb6CiOBwnB86En0dwAVTf0liSsU9PZTUuywD/dZlHRW8t06RNXINW3dYKu2BY+cEXVTohfs/TybimuIhxBWUt2rdMMI1dTmfjSv1Q4dxISKF/6jyf4ALcPN5aoKABT5fmtZS8/CK/qj0y7k+BwCoWhI8JDcMomKh02oLh/cm4T4J6TbvWYBFDmc3Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyu87XirP908folMApb9bi5bRwCWEd3f3LJ0UyP8VHk=;
 b=GzLM3fGB8S9xuaKs6aNLc7wCPH6zAfaTW7JkBA7RGq1XjJ5AaRgahk1aFnlpmT1y9UClE7GJbBZyOo1nDbfnu5liaQZz7RmH4IEaPU19f2QVHADYKg8tCKbmxO+E9RaKOhFcJXdfsZF+oT5ZHzsbFff5SICPRtcH11oixkW0mSTsU2LqkGZRcTmm2uQ4M8LPdIqGSe0LAnHpXovH2+IpZnvdokHsBgLepPqymSuFN8oKvVVP6lAYpMfnaLZf4AOYXbZN7iENK/GuCdEZ0TA4HpBaJKifpFezrfu64PYQtfQ7LqR+AmJYYIupvPk8US6P6ZZXKZMvAlQ0ftOgwSgl9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAXPR08MB7552.eurprd08.prod.outlook.com (2603:10a6:102:24f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 04:20:43 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 04:20:43 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH RESEND v2 0/3] cmd: mtd: improvements
Date: Wed, 24 Sep 2025 07:20:30 +0300
Message-ID: <20250924042033.1873771-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::11) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAXPR08MB7552:EE_
X-MS-Office365-Filtering-Correlation-Id: 050711c1-cade-4d4e-bad2-08ddfb21b99a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|7416014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UdPDBkONsY/qSMyn9QlCUOt+wExX9CmIaL+755jV65proJhepBMneKHGY0oL?=
 =?us-ascii?Q?kKZdtS95pLwqkYg2ggwaKNK8J5NSew+BZN9oSHU5uuZSSc6tlu6pRckqHTZz?=
 =?us-ascii?Q?jipIqE+UnMGb6e0tQnZzROrhnP1+lYbBrsUbeNUdFpDl4rTLh3YzmfG7anw/?=
 =?us-ascii?Q?jPjHreNafBzUN5zxFnL/V4JRb7Z9P35Lqd2eDhLoL0SgWvXsQZ5mOzcZ2itk?=
 =?us-ascii?Q?IiuaQvr+5qjrUlz28IN5jFwI5yjkNvLxxS1VfbDL2yWiOTiP99iRGGenAg/W?=
 =?us-ascii?Q?SGOOaQBFqO1mslO7FsTqEwq8RjopgICDwgOMvP8CKr5GJFYNZ2jp0YgyXaLs?=
 =?us-ascii?Q?sSJ0iXNpDmNRvaMXdjY+EjUjOhU2eSTa58hkdzV9JBn8V5MkmhOZSkCGAE05?=
 =?us-ascii?Q?BvRdxcp2BM/DMGlfc2cXreu7xCpB3bg5wmfkss4CwcQCSnNm5rmeMZ2kEzWO?=
 =?us-ascii?Q?T9zH80XpI1qI6+MtwQlFIEeBTA1JgG0I0FBSxql/PoiB29d04WrabnXaJdZ9?=
 =?us-ascii?Q?El0PGcCzpObhdQR1LtntIBSZZBJTeSnyLhhEu8Wutk88DQJYA1TIomnOKjR2?=
 =?us-ascii?Q?gpVSGG2CI7JS0U9s8MkooFfFHmvxrJMj0Q7T6muug4Ho4t/XYJDTyXZlSIut?=
 =?us-ascii?Q?huxDDDfFI+1TjTyL4pqFczriqEKeSQWA2MTxa3f1SxModWTr37PTHKToQnEL?=
 =?us-ascii?Q?RzMlff5pyNRhot+d4K6tV/4N9IC9+ARGVxnpqTSp+OMWjBcwgmzJzaKPQdmo?=
 =?us-ascii?Q?xsrigaRhDCBktj7G8F6txm7wFTePgAjhaq6ORSzEnz8zFbvSyBmGII0g7s3p?=
 =?us-ascii?Q?dzp8PubZPmP+fUIS3BOEKw8Q2cmyRouEBEo1mfONcv7gszYisvBVd54Zd9tD?=
 =?us-ascii?Q?iZGfPgCFSvyj6pTg7rqn9KbMCWxKiD7pCt6FW9o+2jj+QwsCsmFGxj7rgNxd?=
 =?us-ascii?Q?3j+ZnofuKJcK511N80qBmLMSq9COgfUsSl4ksR/wwfA3OUP9kWLMNwx0kWTj?=
 =?us-ascii?Q?DaZpZM5vhcoiIT+Y2E6seFVgOPW5zzP5+oJJVpl19a99zd/kduoDy5yTQtiw?=
 =?us-ascii?Q?mGR7kV87cxek6ipL2p0+vp+twZafkxSU92AfTddFmOfkHaTAs1lFN4jXVWOo?=
 =?us-ascii?Q?iMrkXTO5e74RORWtc5K1J651dyWkQbnL5wzgkCh/W1tSCvqvPbKomtbSqfDu?=
 =?us-ascii?Q?1LXshNJam5bW/N/kzQ1aSR0UJUaF+eO9IAIf5j/och1wz82LytUNBFf/HaCs?=
 =?us-ascii?Q?EDu7ITCaMG4aQcDNg/irQvPrqPj2e51fh9QF4MKt44qb15STuLJmlOopEL3X?=
 =?us-ascii?Q?fAjo/Lv98VRFFuCjh0fWYuQ/xWUnFURhg4AAsPnu+dYmsW+mDWGRrkyKqzD5?=
 =?us-ascii?Q?uhSsPtwF2tocvTD7kJ4Lbvq+QA+jTEdaQI62w3ebwyycEdOF8dMJxLYoprF2?=
 =?us-ascii?Q?dbH9bMLKXH42TrhrmVPw5Oo4OPgc2WqoKUK8dV1eVydJNEgP53fGEwin1Ifc?=
 =?us-ascii?Q?442B8dWUaR/Vzkg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(7416014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Adg5CrCZCBghFFFhTpBa4N78X4ztY3TBaBmfShIncCMvgyJQpD3dGzxPKNi6?=
 =?us-ascii?Q?oMwJjQJavp/YXUMGa/bmvgOYa3gSsS1+RIBJ/vwKovELpGuhRFSL1QRHGLbL?=
 =?us-ascii?Q?GBpPH4HQYWgTCvxgbk2T+o9Qy2UilGq/LQ03lIVw68D44hTa7ZRiuvMXW4kO?=
 =?us-ascii?Q?imuIBNgZsT1n5N4ab9DiVeQotka/63QMQOUEIPtxaqjMxrET+Fe6N3Df6aMt?=
 =?us-ascii?Q?7IxJKn++B1eJUKY39894UnyJo0XfHdAfFGDCoUfqA4ZsCdpkt/65w9OkVHXT?=
 =?us-ascii?Q?IAL+h2Ljko5xfSdZQT8UJ59RenWGyC9eEHsPwKS6oXB4DPZKhFt5zYeOy2Pz?=
 =?us-ascii?Q?y+KwjZiLjUgBQGrQAL9GIOSHbWlwIfldvPSNp27ZVCiyYf/EoGlkaKS4s1aU?=
 =?us-ascii?Q?AIEgVfO6AwWmY0HXwNfSCU4zfdlkl12OANKBjmIxuwfaWuy8d8u+D2MoRyVe?=
 =?us-ascii?Q?sFcbhpFpGDpcOybuK+DuZa81yiY0KIWiMXZCTviigmO9o7AElymHnrCofriC?=
 =?us-ascii?Q?5H+Ulp0EHcdVdtZ2W77Vq2GQ1bjKRNPuNAxVhfaxoXsuEdvpcxctSDieYI/3?=
 =?us-ascii?Q?whSnTEM+eYbJuPx2BfiE08MNaM0l5WfS/67jUHqpVPazgkZVHMFp4A7b1eoF?=
 =?us-ascii?Q?a/HoYHjR4M35me83iL3WsRhNAc3EMXDuT4K00HQxcXRaXV/A5/dmWJ09fHqI?=
 =?us-ascii?Q?jbUZXQ0sWKeNj75T9/FNbXzXpMPkfoZO2rVX8nKPRuPrncCr6SLn/FydTH5e?=
 =?us-ascii?Q?X9Ks3NWEI0mxOh2JJ+5ZmURLKAhrKqKCp3sKb8SyVKaqAumSL7Zps9k21bku?=
 =?us-ascii?Q?4a4c5QGV6btNadYJlfPL9rhdG9VKSqDtIh9hwL4r6WVhe4YmuprSVZuoQQzx?=
 =?us-ascii?Q?a1Yeohrf2wGllUL1lJgAi2VDsYHSTx01iqKR9l+xyGDL5ExiXP/O1gP76uwu?=
 =?us-ascii?Q?1/jyrlmmcx4FpYkscesZ4PFgmxoxfh01Y1lzzap7g1VL9Z/3Zb/3Br6PegWb?=
 =?us-ascii?Q?hO44/eAuGEkQNcZs+ZKip5sepHbY+OtGYsFfpREgDm91tO7tbQxp0uIPZwIm?=
 =?us-ascii?Q?pP3HSEw7UboJGh4bOMoJtPzIGYKErjG6ufF6wxvCKMGWXusCQtbix4cVwXUS?=
 =?us-ascii?Q?2EATxRVFaALYgxxPZM2RsIQkmoDOBQXaQclZOheC7WP4ycWhaHDHeFlzKOVS?=
 =?us-ascii?Q?kdc6NyqYePr/CyjPZha8dK49ZFdJRTxrMNZOBQmQLwg/i9g/zw2Bxx6OqnsV?=
 =?us-ascii?Q?V9fh4+EtR3tVlW80ZUkJsXrfaU4ro+tfwdYyp9NyFZvdFhWhiLc+F8Lp9Ufi?=
 =?us-ascii?Q?P3FkAq/qFYPuWoG2K4B5OH8zQUtBYcJoIcK+gTMXWOHqef6xycE9eP3Ee7Ps?=
 =?us-ascii?Q?2DGTvK+OCE5aAWaj5+Ych6rjdEm0pN9D+AxnbZI+eqwGv1di/EAg7lzjLmoq?=
 =?us-ascii?Q?xgojCCIE3ju3DXdrcY/3nUgMorj7NtUUDmDVGJKLxHW3aslfg0yEb1X6Q57p?=
 =?us-ascii?Q?DP37Xt+hq4F8eZyt0DRG9uKY0TgQhOuWyrJOprAnW4yAPGOICrDMNGeikRO8?=
 =?us-ascii?Q?uap+1EHnkwM1bDkz9abOqkhpt5gkL3BZDZf5EHkEd6MN+YvifVyb/HfEGDlb?=
 =?us-ascii?Q?mQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 050711c1-cade-4d4e-bad2-08ddfb21b99a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 04:20:42.8756 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LS6DZ2mhKavckJp9RYx4gdfO6QbW7zEIOTxcnb7ly2I+TwYd38zx9I3qTRcSAnQTfqW0tbadEz7waB5JasERrtgBbHqeoabuLqHdxKzKhz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7552
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

Some nand flashes (like spi-nand one) are registered with mtd
subsystem only, thus nand command can't be used to work with
such flashes. As result some functionality is missing.

This patch series introduce following features:
 * 'mtd markbad' command (clone of 'nand markbad')
 * 'mtd nand_write_test' command (clone of 'nand torture')

Also a new command 'mtd nand_read_test' introduced. It produce readonly
test of flash. It's mostly usefull to:
 * check general flash state,
 * check the correctness of returned number of corrected bits.

The were no any activities around a patch series for almost 2 weeks.
Seems the patches were lost, so resend them one more time.

Miquel Raynal, could you confirm message receiving? I am afraid that
these messages could go to your spam folder as my other mails.

Changes v2:
 * added detection of the blocks above ECC bitflip threshold
 * minor cleanups of 'nand_read_test'
 * comments of Michael Trimarchi was addressed

Mikhail Kshevetskiy (3):
  cmd: mtd: add markbad command support
  cmd: mtd: add nand_write_test command support
  cmd: mtd: add nand_read_test command support

 cmd/Kconfig |  38 +++++
 cmd/mtd.c   | 457 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 495 insertions(+)

-- 
2.51.0

