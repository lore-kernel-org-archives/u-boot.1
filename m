Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6A6C43602
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 05:58:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BAA284C92;
	Thu,  2 Jul 2026 07:58:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="3ZzQt6t7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C86E84C95; Thu,  2 Jul 2026 07:58:14 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6ABF284C87
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 07:58:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJQ/W4MChRYRMfuqwaMKZmTArNFHX0fKIrdXqtkmcwSTtXyP6uIVYmy1Ok7n+NUVyYyJ+GAyw4/7Y7FS7Bg6G/TnGKl+01EtSqWT0N5hr2hDB3gBI6xPUisU9HO2HKkcl2KCBXHaeK7KKfbGc83Blq3FrkEAl01vSoEcFmEh87NGOEB6H9BbuXFSijqacn6IiWvCSVtsY7QPFUU3J6XFwux/fhZP2tXc3sDXjfyksqGjiRmGS0EVFUxAXMZT9i3sqOv/Xlrp3kcQ1K0C5TGkyMaEdTAitzZ/qqN47k4LVJd5AshiTA8qf476eRx6grBlFisVL+8C3dqAqQQG99SMkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0EmJUwBoQPFFX+PRDewXE5hwESVNNQnTOolKvYkMkqc=;
 b=IOUvwIEekuYmYdojWwUd44nOW5UvF7bxaYSGjx9+m9NevW6AOOB34IobBPvjn9KKbdRSneLpmDNNFpk6hXQFRQsexI3JafOTvx0Mj4i0znhMg8Hsj26MBCkooLk8ZFxG0i8UT9rJ8vMjpK4CVCGkNCrt8TSOpydjroJ9cWiryDy22IuAld0T5EPFFOVdct8LUZ2il5uvKvbBaW3KqCz4ST4hRZoo3Sf6f/lTjJbzcShtnkWmfe8zWnZJvyGwfGthv1xYHnKKUY2AFtWG/M2eCi6JbnmBtKBUGExeYjZEgrz+5YGRfgOuJJFhVzoFRAIZ6IgRNndxDuo/p94Ktp5gQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0EmJUwBoQPFFX+PRDewXE5hwESVNNQnTOolKvYkMkqc=;
 b=3ZzQt6t7q1JpBz214NvIhwSXE1o47/k6nmwTC+s8qNQtFZr9HBcUO2uXl2OKZwqhY8Movzm0lC+Bf0sR+4Yk+fYa2I8oEqvSaMvc/VTIzZ9tJWbbIYI2pU3/kV0xPHsqz61NKO5N0Cmu/rEArjZs6nX1X9v2taa7c3n4zffSdZCdbcU/MOQoUkDnsLhmx+0cbr+0eJP0Cd2LatXBZGJUy2FVAP+41z2mMXCG4nMhRtGOImF06rG5PLsnI70FKt8XIhPG5gI6eINMEVs476ZU2ilqYm9CuwrpigEg+4SXfUv9mavB7FtQeaYuiOD9z3oPt1DBhLd1aaGYW+8KgcJCdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DBBPR08MB10433.eurprd08.prod.outlook.com (2603:10a6:10:52f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Thu, 2 Jul 2026
 05:58:10 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0159.018; Thu, 2 Jul 2026
 05:58:10 +0000
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
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v14 06/18] net: hifemac: Convert to common field_{get,
 prep}() helpers
Date: Thu,  2 Jul 2026 08:57:32 +0300
Message-ID: <20260702055744.2164975-7-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702055744.2164975-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260702055744.2164975-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::16) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DBBPR08MB10433:EE_
X-MS-Office365-Filtering-Correlation-Id: c6cfdd96-ee88-4ed1-016d-08ded7fee545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|1800799024|23010399003|366016|921020|38350700014|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: xCbqiAV30+021IOM201Dd26q4JUWvUZTG1yyN6ixPsSdK+TaU+9o1DUl3SFSnqs5BExBHMsjvoTJIn66X3ernpNgHU7txjWSIR7VHUe10Vf3xk1wi1DYTQPoU6iQbqy2SoS/Qpnd+xEeSqGMUlGXjCDGzIdqMDZAlxumzyQWy4ZiDUVl/95YMZvFZ1dExYA7fxqhjuXHbkbH9qpC6nCjDYNLc/3iBHIupYQg5QCppsGPd8SKFG5qOnaTboqnP1ckGv75Wh21S7Huoyh3S1mXo8uloHv+pyPa+r8N9eNuu7PPVTyg3RPvE+5pQIEcYsyQxy6nKXdGLyRV/tnejmshqVzcBOm1F3lhLmI1yE6DQv5jHAE7DAP4qwJ8RCi+cEm1WZB9URB2bCYWr8xYL/8rqm0tdCbFTo3uMH/yhdu205rPHEUvfJcLBv/dexCw0J33F/aTTpSFtgerYhsZWXqWe8V7HaEYyTJ5rfRLuYccPNXIk7w/E5zf0ztK24epu/8MbMpZshWn8ERhDQH44+GKKgrVINyQXM9tCtapeJRh+PvfxQvlTxZ6D6S3m9sl3yqkW1h+q3UPw7H72y+r602E3gxSzv4L51jjcgWkeYHGYtLlHvye+q9ik25zPF/CNbRNGyhFymuXW33UxGyExtJ+Pj/okagsarGT65gUKQktjE85bkFWAhMV1vjz5Wl1zWzeu+mlKg6Ffko71beC4zuYkJnEKq/G4W+54qd4fsrak2jTQrAM1mcv7q3zXuQJT9Ve
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(23010399003)(366016)(921020)(38350700014)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VnAjioG1WHXUQwUbiZKO9e+17AqPzvgncnwv4GMj+dFfQPcGypnlpvWNaabq?=
 =?us-ascii?Q?zpoBABUA93XtBWsNe9JAPgLWN/UayF/+oA+GGxYrTve2cZTuZ6MntpB9ezxU?=
 =?us-ascii?Q?GlQfZfOFEqIrUxCJdIhdm/ib4lIWGlrv0HHcyqi1zapQL9u0Vy5mUK1jRNCn?=
 =?us-ascii?Q?F9VxkaI7NwfAXZR03YFhsZmH5F18/h7RppkcCCQ2ux176EtQAVqhSqMRLse1?=
 =?us-ascii?Q?RAnVWiRYg8QqHlFtmGrIb+NmGjv8Eb410VNsIzs0/P+r/iRBGS20zc2kXwHJ?=
 =?us-ascii?Q?MGcb7/x8oLvapEFAjzJj0/LrpiBHUdgF798dMS0KDOIXnHFSAxv/Eov14ilp?=
 =?us-ascii?Q?Oz/5wm2Z2DtqtFjlfSgXqDQGrThzNMV0zbVfoXZ+zWaDMnKeyyllFma/JDgJ?=
 =?us-ascii?Q?tdqbbz1kHFi+ZhKavaqJBnjCOGmC1KKGKBN2GIlhWo438jpJduJ3+XUCtSCS?=
 =?us-ascii?Q?Z1XO71VDgdCjXYbAnPnIZ4x4YveM1M+4EhBTQrDoRqrk/lpFA9m3H70HowuA?=
 =?us-ascii?Q?nl55D2YY0qWvGNUaQXhNFdStc0Gn4BTfZyc648o2bsZ9mw7xVIE5ZVVZ4Rep?=
 =?us-ascii?Q?wrmm5pliDO5Q9MzGjpaVQotuZc/qOmeyCrT9//JLoA+vco3WX9t8CGKmnTp6?=
 =?us-ascii?Q?AsEUgfHBqlwOfPjpJbqR9wmzDc3esUXl1ufDAXnxZF/L4uoUUxqCzL4XYxDD?=
 =?us-ascii?Q?/D7ErQZbg2sEcu/usEGLI+QDJ3qWl/XPG4LDhXBn4+noH5WIK8Q4tMX1Vexl?=
 =?us-ascii?Q?HR9ZutbGf5KE56w62or0s25vw81VTVFWY3QyC4f1L+ntuZfXJipYxj7MNjWb?=
 =?us-ascii?Q?wLi1W6h1Ivl/HfwYJFXlYa4PL32hrwX9VKIlkpiAqVE5fu3UGScGMLUQfTyS?=
 =?us-ascii?Q?dBakTo68eKDHoGoDcUirsSP17PxcFgn8pr7ByvDWQCrWxnq1neDfzn06AqwJ?=
 =?us-ascii?Q?mVc7K3tH50Hzi55FRXaz+nMZEBsfYazN7gCDg6SMuUO1++zoVuOGH1YReDnX?=
 =?us-ascii?Q?zzQAoclsjoYlo4s7c0K7eoA24mafOOT+9NSpOQJVQBT2BmxdbXTtoIsKAAV+?=
 =?us-ascii?Q?v+soU99L93X20fTjeUFkG/gkJQeTCoX8Aa2mVoi+prHpNT+TfQ6w50W0oYLM?=
 =?us-ascii?Q?Ge/Sf412EJNgc+LP8rQEbBjSGkwZT5O29d2duHM9Cg+IsByTUIeCRa0cpNKI?=
 =?us-ascii?Q?peQpwejKtW2tGnTS5LI9NwgDox7VX30AFeQ6gNF2ZnjU8C7Q4oTrRjwxYscr?=
 =?us-ascii?Q?KhV2XEbaewVbb22BVN6c9JjgsvLzzU2TdHpogC3PzTYycYygaDuB0hwt0CMh?=
 =?us-ascii?Q?Z1bRtWQmZUWTXNGNi03qBcKYr5Ab+VR8bOzjw/BYa3pDrtba/iMUio+DQDTo?=
 =?us-ascii?Q?oZbvCejwADZWcwZmIWe5WjwUs+bjuCN2HweBy7Ajj6eiz83O6Aru31wOG3k4?=
 =?us-ascii?Q?iZKWeLGJ49HNVrlZAnNSs5+jA7ikXYBOubQMVdCaqop3Sc6RkRzMltPbWf1b?=
 =?us-ascii?Q?eibw9ErzItqPEAJavu5269ddZ3PBUtnoiE+JcYAMi1yQ2T2r29GbhDcB8utE?=
 =?us-ascii?Q?2Rpr+ln2L4szOmr4uiTpexg3RaJhdq8a5Y3hulTHOxYh0Xt6cC/hfbuq4c4U?=
 =?us-ascii?Q?08BCNHrwArfmkgV/KEpiRPmw1QHq0illJg1VH3YxxCzS3ouIc0BGuDP+GZVD?=
 =?us-ascii?Q?lMHMsKoO+f76DHUE6s2+yP2+wnH4L4qb/KU4kVAHvwKgedx2pck+PhOd3CTH?=
 =?us-ascii?Q?koUFrZ3vz+jQu8L78xjb2AYM+AaoBQI=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c6cfdd96-ee88-4ed1-016d-08ded7fee545
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 05:58:10.2850 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1N0IbTwfZeeJ8wANDmuYcA+mCyaLOgwF/d9i8f9HyXVKBLi/z1UrxTerPpCKDmXzoxgTSyh0k7MoIrlJa9fT4i/zVpjaAgLVltHKrN7E66Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10433
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

Drop the driver-specific field_get() and field_prep() macros, in favor
of the globally available variants from <linux/bitfield.h>.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/hifemac.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/hifemac.c b/drivers/net/hifemac.c
index 62182f922f8..7dda8cb8815 100644
--- a/drivers/net/hifemac.c
+++ b/drivers/net/hifemac.c
@@ -401,9 +401,6 @@ static void hisi_femac_get_strings(struct udevice *dev, u8 *data)
 		strcpy(data + i * ETH_GSTRING_LEN, hisi_femac_stats_table[i].name);
 }
 
-/* Non-constant mask variant of FIELD_GET/FIELD_PREP */
-#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
-
 static void hisi_femac_get_stats(struct udevice *dev, u64 *data)
 {
 	int i;
-- 
2.53.0

