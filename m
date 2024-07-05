Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF12C3DA41
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 12:11:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49A8B8899D;
	Fri,  5 Jul 2024 14:10:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="SQ2LHhw2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E743388986; Fri,  5 Jul 2024 14:10:45 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2070f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::70f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 185F38898B
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 14:10:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtIHlhh1VXBrY7+E6YzBrM6Q/r7g+h1Cv5+BhHuzj7PiBUV+9gJ7iiZq9McBsHjyuTfYFCWbz0Vt4dhgJeMGcuuhixpP/fQFMCOD3SBdwr1mv3uiZgjv3owdwDu9i/TLThknGB4fA+IzGrm072PTrih4bUWvKkWKEaFimaemATJ6zc8QhU+nH2sThCI4kpzlUXLAD4a24Rhi5v3oMXtnIU39g1TN8iik22Jse6xP7zTXWLWruZdFEFowK1qLtJigZ61j+ILLnURdmZ7xqclsvpbrHBxmy60Y75R5ntn23fbD5+8OH659hQOlu5kFyoizGDaKzGVi8JlW/Ocf8e2cwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5Z2ZQsiZA31C52b1cCw/EqWHziDo/ZIFBpFzk7ijrI=;
 b=PA2f9mEyT8iUO3xdPO/9QFwbWYFK1/nbZow6B9KuNPr4zwy3t8bkkxC7Ha91h50e8fzcx+RAVlscvOcCS3b7z/QfUVxQKEOcN+f3OdIATV8hyUF8fsi+r5j+uiFQX3/P+alzymqIOSmOXK2UIDoitnrF4O1KGJQ0YyVC+DwUwdM+zcFTDUa+l+W8jjUBhl829bG+5RGI560AP9+dVdtA9WeqU6PWnU+DAe0lIw6FIjklEspB7zJAZrTVMlTKoP6r297lUTcf//2E1ER+H918q+6Y3rXPRNXF8HSdefl+Yh7LcVFITMkI9K3CdfpyjtWPER7xJnDHn+0jGikIvilQKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5Z2ZQsiZA31C52b1cCw/EqWHziDo/ZIFBpFzk7ijrI=;
 b=SQ2LHhw2K1fnoB2Vjgj9mrXTUwmGtT2L1q7Fou8WkArZDX3Rs9d4BF7FiPUS4KqGMfh8zNZXKxtarAqjBUx6WPDw7kzrdpyvR37RIU09iFFueUUOsp6ANwGEeQ4Pudny/fbJlq+r+N00S01lr7XHT0mbY6LanmUIRQ3tS/cYZlauArL9a+NaTYTM1dpKYDZOo+a+7bH2I6PLMdcQqhTxOn5xEqUX1Mr2guvyelCEN7UYnfzZ6tae8MijLATtPPCkOGHGMFFRVBMc8QuiRjHsWoQE8+weKr09AXpIUdjiyKG+IcKAuzru6kPwHa4N/yVfYdHHLyMyie1YIpB0IwvxYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV1PR08MB7315.eurprd08.prod.outlook.com (2603:10a6:150:1e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Fri, 5 Jul
 2024 12:10:33 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 12:10:33 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Christian Marangi <ansuelsmth@gmail.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 0/2] led: implement software blinking
Date: Fri,  5 Jul 2024 16:10:21 +0400
Message-Id: <20240705121023.2266479-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0060.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::11) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV1PR08MB7315:EE_
X-MS-Office365-Filtering-Correlation-Id: a8e95ce6-6b75-43af-c160-08dc9ceb78ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aJTUXa8vu4tbB6B7giDYnicsnsTIshVRz+ZGAIIBW7RpVq39jDYbnT+8LXVW?=
 =?us-ascii?Q?WN7EorEF+aUHNck/OWJtKQC9uvvcnRWiI7MtX1IUcrvH1qX1W3rOW0YzpF2K?=
 =?us-ascii?Q?fbO+ZV9hqdoCUOQA308YDDRvqHOnjF6T9UoEWUCOJU7SfSd0CeejuZX0vO2h?=
 =?us-ascii?Q?jhL1yd3GUOeoWFBBaX9JuNeMaZfbksADlkacfAztrikTjdtO/ylLRqVdVuux?=
 =?us-ascii?Q?EwrTWDFX3Uw84/zy0szDcGchy31DYt+4PvxgliTrW+5XJf5Ug45Yxjv4xPuf?=
 =?us-ascii?Q?UhIa62UxGcgn0uUQI6VJaYMlqnH7x6mi+znRbCmAVzLsKF80kJNpddqW5kT2?=
 =?us-ascii?Q?5LgPnaAAXnCyPBItO1K148Fj/0euAuoORODnGKPasRrQXlHxDLx3crZAG202?=
 =?us-ascii?Q?P1mSBOf9bm/ZLgm1SiY2dkS6jnKdK6W2JOise5KAmynRQ5N/JxOuEbtOwRKB?=
 =?us-ascii?Q?F12YIKX4VpwmBdLxMihMkTR5JXWWZcsyWnWCFb697xagABtkhsG0KUI5zUYT?=
 =?us-ascii?Q?1/wojFdFB557j8fx4jlKMuGH2k05aWIZDUcIyqWCx+m+y7yf/e+BmV6x90jX?=
 =?us-ascii?Q?FdrxzLyrOjhq2qfl37ZrFh8LId02vG1XFyC5byw+kKBckYIUb1fDhsDYSOqO?=
 =?us-ascii?Q?AbQAkx9bYX1j5qqpxu+YxWD/9Ids14amDldB2gprNQTs7of/FOE4wVHdAZJD?=
 =?us-ascii?Q?WM2+w9SdGddl+K9dk1PopXXOgEEI+mMVa0+0y1czCO4o1whqvwN/euzqXwzr?=
 =?us-ascii?Q?ZBvJMWJn2lE8cEi33A2IvQNXsIqE8uC3ZpAc7Ir1X+wHCpTpFsOqvEsXZPli?=
 =?us-ascii?Q?Qick8huc5lbR7L7yvXib87t/Pe5pcm6ZPlZU+XDb/aAAPWIuJ7meO3CXGIvn?=
 =?us-ascii?Q?4qWo4sXsCYDOhQZ22+TuU28bwDKetvtHPYG0Ixe4a4OIsDgwHC/+K5lJ2HV0?=
 =?us-ascii?Q?oxldJsczf/eW63qoGGgkqMyd4rvZDDdLW68hIdEsapzDuUSaFmz5+BewJi6v?=
 =?us-ascii?Q?z9yFU4PKvqQm9S08D8Ior4sJoo/Wy7crZN0lSNBJDMBtJNPc8ms2tqwh88UP?=
 =?us-ascii?Q?44Hbnwm77O+Qx9f4GzTVb3fBzXAcZ6sZm5ZAUE0xQZW+UfZDc8NxSrhMuezZ?=
 =?us-ascii?Q?TdTCObr7U+Bada+IJgbdymOOOggb3QeR2Mls6wZu0ivPGqZ4/JJvZFNtlE3Z?=
 =?us-ascii?Q?r9jRRGjHZfVUDVqobmrF2qiycnr2xzRb7CbZkG+otnLVIbH/U51Wy7+Dk6Ip?=
 =?us-ascii?Q?fVsPsd4cyJzx9zSN2XC0Im9MbU10RWTqQVSKXC33SEKLGJ6QGaMjC/GBLiUQ?=
 =?us-ascii?Q?oduaRNmKroPjR+j+tag3ZWcHii6riDrq8ULurqXsV0C6cM0lSn5kYUtEiM1d?=
 =?us-ascii?Q?b9MjsvCYihx6Lq/VPkz2jbBzTHe92PaQubkHRG1Je8lIkNhJ9A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?db0kKcGDH00W1MOD0uCm/eo1u5yPeBM3Iuo8b11rEHsCBrkZ8V+EXzMwGlHG?=
 =?us-ascii?Q?fLni8RseS7s4lUEjj8DjPBrRMHHinc8FHMlU/t1uoWcjbl+icy0uIkoYawGk?=
 =?us-ascii?Q?z0UgKJ3yNIOrZ5CLefE2WdeNpbofW0onGKmMdZv/O61yITfeTCNSy4qaFWRw?=
 =?us-ascii?Q?3dqMJH7R9v16zqff8V20f7PtJ1jgOSri2RU0Mp+vEqV7ekL8Y7ywfIZCqVk/?=
 =?us-ascii?Q?409tyEPvU2V2zYEGcHEV1/ztneHkB8izHwJfG5sg0IRWmt4F4cVHK+oBuDre?=
 =?us-ascii?Q?iIsboig6oUgduaonUp6R+qk5/Zq0EVrmLrYa7YxYhksY3OrwuMI4yKG26Fy+?=
 =?us-ascii?Q?Y4ewgwF7hWTVpanxm9r/ad4iJGzyF0bDXsAJ+zBpqIpGsCKmTPzmYuVWvp0p?=
 =?us-ascii?Q?yNdn0t1w/rAqW7wY5n+5ct1KneYfc7TtmiMlk4EmbuPBzEL2ik0o3vh/mJWW?=
 =?us-ascii?Q?A9szTwnNDp11P+IMAQKqrNx0XMPmONQw1VGQkcQQyC4R/5yu2uh5q5ynV5tz?=
 =?us-ascii?Q?VHRlEar5reLb04tbZZ2EZWir7GrxBVtTdXWttv4FyedZbvtf+hoCNQf/G4fN?=
 =?us-ascii?Q?KqTNyBcfy15IZJ5uME3G9V0p4weaIFRzEs4t1ldYREmjCg75esVeumqYEdFM?=
 =?us-ascii?Q?69O0ct4B79XXtcdWKd04jRGEomcYb5tAWWnhAss1jgCipE4geOVo9w+k1zkD?=
 =?us-ascii?Q?Ig/GX/v1UWbm75vlzuzhhs9Hw2yZBKsf5Ep+lnaEBov5FOxk7WLVY0xDlTAn?=
 =?us-ascii?Q?kMmOSKXhMNzOMm/eaAAB4RQWSHR8vW34e01Z/RbWZdvN6e6DAcyNUbfNNU5L?=
 =?us-ascii?Q?0couuAwlcmyc3X6uX/9hJVXVYSbF31aWQDzPPYV4bKOvKalskYZcd+cPkRkE?=
 =?us-ascii?Q?1jPFgTHIYjJk2TrCxTGFBZfnqkWqSUjubbcTDfcRpcnQ9d2V4PLmCpcBSlj7?=
 =?us-ascii?Q?A+bOIlXgHWtKThl9VdLbVATLd53RZJaH5LRpkuLMKyQoRcDcZvAz2ZjR3wGd?=
 =?us-ascii?Q?jhdFow4uKOT2RvU49iHoM3MMFPQ/LnIKeHPIj/AO6ewcVcguWyyRc9YiuPMV?=
 =?us-ascii?Q?lGAEL2bFd74NlB6VBxl7KR9tmhcu90F946rD0hYbRQFr393tULpIxLd4dpCb?=
 =?us-ascii?Q?IW9GswzqNwhX0I+hQ3vMCSeMV0KIaKjRlyMYurrllNrh43pt86ZVxWvzDP9F?=
 =?us-ascii?Q?m18/zN0ZoU9Ltop6QyOQ3AuuNh2kizbg6kpwvPMoXDzxKD4BPQY+3dZsN44f?=
 =?us-ascii?Q?T+yZJMKTlasnTvcFPRVSLl/PGdnXy5jGTr6+adBLrHK1KEmGQpxxa2kMdOuw?=
 =?us-ascii?Q?D2h8iexbUgHKNkMwhqTLPuvpM7fWSux3u8FyUfRe4x+88cuLbHMO4I1AqLgT?=
 =?us-ascii?Q?4G5GcwW49coRzcrxuNyLJW6AXd1oJetJaod2bZCI4g65DrNylVjJAoI8+FdI?=
 =?us-ascii?Q?hAWVm9vuKPmu93ajqwe6Bdll1B8NZpBIx0pzuyCPxqI4e89wIBFmIz1xcivi?=
 =?us-ascii?Q?+mZ5X3FaFcHUtMVZ2j4BTTv45dqXT+QZ6AZgncHE1SuQ6fnAOn2GqFdNEsXV?=
 =?us-ascii?Q?WuN2ig/XvHBc6bPFODhw4jcpLvlmQtDKoeWH435abxZY+AixEJugd2FMKqOw?=
 =?us-ascii?Q?ww=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e95ce6-6b75-43af-c160-08dc9ceb78ac
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 12:10:33.7380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QsOft0X/lPyxRUtwheWjTPS1IrMPeR5GYLfbicrmEvDaZNLoGw+uzoeUXV71oA6XlmeIgP9veQNGdCFFUiREpXLtt5hfQpBdfx5ybBNukX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7315
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

v2 changes:
 * Drop sw_blink_state structure, move its necessary fields to
   led_uc_plat structure.
 * Add cyclic_info pointer to led_uc_plat structure. This
   simplify code a lot.
 * Remove cyclic function search logic. Not needed anymore.
 * Fix blinking period. It was twice large.
 * Other cleanups.

v3 changes:
 * Adapt code to recent cyclic function changes
 * Move software blinking functions to separate file
 * Other small changes

v4 changes:
 * refactoring of led_set_period() function

Michael Polyntsov (2):
  led: Implement software led blinking
  led: Add dts property to specify blinking of the led

 drivers/led/Kconfig        |  14 +++++
 drivers/led/Makefile       |   1 +
 drivers/led/led-uclass.c   |  50 ++++++++++++++---
 drivers/led/led_sw_blink.c | 106 +++++++++++++++++++++++++++++++++++++
 include/led.h              |  17 ++++++
 5 files changed, 181 insertions(+), 7 deletions(-)
 create mode 100644 drivers/led/led_sw_blink.c

-- 
2.39.2

