Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01A1CA0FF9
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 07:48:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A9B983487;
	Fri, 29 Aug 2025 09:48:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="00IEFEDE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 552E583559; Fri, 29 Aug 2025 09:48:51 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32A0D83447
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 09:48:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JITROE5PwdqSLHHJ2kFJtYQwuszkWoOgXjLqehaDXHLTmZxbQwv+GzcHIOTYK99NaA0MD87PNQNcl2M5bqjkxlylOoNtTsDxAbHot1uftIPhN86gT5TXifo/T/OTK+B/TEMYV5mhWMcuxNM/kJGMePC89apc8tz63X6/PlyutzvAlAUgo1zt9nwSqU09cwJl9YaUdJXqKpJ04dLvfqroESVAmetcBk0RCRMW+/C6LW5TaeUov/zwvemWJMEz/2NSynqmcfMTtWOzXZ3RWKpswZ2E+rhnyW1aBQUlEv9CDFdhOPQ+7c3G4OD/qLLC0489G32eYHdzcBw6/WlqanFGqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gIgPLoTQpfu4XqlytUsj+W0bslrm2wVRHv3LGGNkJjs=;
 b=RTxLgUQZwWV5spDNVx63GAkcl0+uQn3xeoo6BZPJJoxhOSmH4gcY7+X3Lay8CbbvzgBm5383/RohS4e1fnC4YBdB11kksSzV+4UCsx0MwPAgrmrLb27sa8GCoSZo8yciuiX+6kL+gRj7DDNv0SRXOKX7erSDrQaxE6f5Nj50/gIl9JXOpATPDMnpVxASsqA4S75xmp0XfvMJOoY3nSRE3nnuXiM0kdip0Z7LgOlV+wtysRhV391C8NxnwXWFYITLq6+f7TZ5PphFUGhFIkSMVSOIMuBE68sEW+yvs1tx4NVZY7pAGPT4k83ggQHzZQ69GBUBPrpi0f79CluCZ9P28Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIgPLoTQpfu4XqlytUsj+W0bslrm2wVRHv3LGGNkJjs=;
 b=00IEFEDEkUDVOroUhZEw/FN3ONP7YNONnxBQnqSuqwkIlNPXqwxsfUHm7D4NBG8qdZqnQPTtknJ2ZSE+kIPEsTyB3mPmAe6d69P7RrZ5EhTJHuwk1qmz4sBB17TH66rCd0FfBM3IT493060NwEJpcVf0lhL7POHY2nyqfSdLPkKyxsxmOPL43TSad69vEyiHXVTHfJo9lEJrxx7kxsDWx8JhxKQzIVtUIb+vtn0GTaDuUmkSceJM41c0HbiuPAlA8P9zeu0H0eTom9sndbK5Ib3u7adSflthjx2sFQq3Lhvz76WiGeUBDhn1+sauZuHdVEC8BkQxJWswdkKqQJ8v4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB8320.eurprd08.prod.outlook.com (2603:10a6:150:b5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 29 Aug
 2025 07:48:45 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Fri, 29 Aug 2025
 07:48:44 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 0/2] cmd: mtd: fix benchmarking
Date: Fri, 29 Aug 2025 10:48:34 +0300
Message-ID: <20250829074836.2894264-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <87tt1r6api.fsf@bootlin.com>
References: <87tt1r6api.fsf@bootlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0311.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::18) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV2PR08MB8320:EE_
X-MS-Office365-Filtering-Correlation-Id: ab6b9bd4-e614-4055-51e8-08dde6d07aab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TWBInr7bK8W1r1RtvkJsXF7TKJ29yEsimHR5MFAZUmet1ew6no3xL5h9a3tk?=
 =?us-ascii?Q?8zLUuqmZRtyr1knF2RvbJYSx/ml2H+FL/Yi46CiLHwwvB9XQgxsmd7cBJQxl?=
 =?us-ascii?Q?/yhDsKRhHA651JgfYk9YCpOHNo53vIQGHnUApPaJBjOmmXAUuncVclBbmFhq?=
 =?us-ascii?Q?1u/N8pyRZFuZ2vHTLX6kYnU4rDdTMcb/QNOvg1no5XrAQqJcXlXW75e/pq+r?=
 =?us-ascii?Q?nfw2Dsbnr1avUaX06qRlgxtj/kEA6NLJpzeIq3xd5xDFQR8SS9Xbt9Y1NBqo?=
 =?us-ascii?Q?Eakm1gZmaWhhvzrQXr5xMDnu8IU1ZPkEkI5uaInX8grnWs76Ntd/x4Ys9ofo?=
 =?us-ascii?Q?9jwkuDzdhBExlMdOmt3o9lYhTGDssL5cwOQAN9fBk/m1R7jedeoYVzUcuINl?=
 =?us-ascii?Q?VJ5ST5eTm13MrJUc8s3piJA7P5ykVTSOJIMZv3SkZfHnoaL2uM6mx9uEhBRr?=
 =?us-ascii?Q?Kwc+aJL52roLSh244yzbuMOWl9JKkimxmykyOedu53kpEyjYz260X2IP7uFA?=
 =?us-ascii?Q?rzgPp/Kmp1DvPYi6NOSz1RxDWideX7bmk3qUOSMYbGUHPbKGx/jC38saOepo?=
 =?us-ascii?Q?71z4bhgY4G5MuUKCjSy57HgfksCajBToTkjeWvwJtJNpU6JSh67Di7+FNh12?=
 =?us-ascii?Q?fFbd8t9xY52XZhUIJfXdYvK6/vVzvKrlZPYD9bR4MKZHb5J/z6qk1K0wKgzv?=
 =?us-ascii?Q?O/j3RRWcsQdTd42jXFimqncUUnaxW9Fo3XmxoNqqLD5d1epXIXQS98sfD5kZ?=
 =?us-ascii?Q?Xq3t3/Epz5qF7YPouFNowi+DQZKJNqztMgEx4F6rR/VBN7ZJ9ydIEEbEXw93?=
 =?us-ascii?Q?sSyB/5+Qy1npvQYeq3OvKr3TXMhUSEL+hxR2zQSTl7fhJujjDDiRgmb9Cje1?=
 =?us-ascii?Q?AXLWwNLWnVOyWbPzUdtGSWb2bMnh86Y2sj2UIozRHt5j2Q7WOeW0j2uBQpJq?=
 =?us-ascii?Q?AmF6f9Li75YYrRYJ4Pz2dF/WEC6SvsZmZgLHFjskujQE7DyE9Zr253S0FJaD?=
 =?us-ascii?Q?xXVpQxIhtb3EDDywae5xRyg6tgPQ0g3cUa+WxtK0cGRYYQ6i/9WRTvEyI+vt?=
 =?us-ascii?Q?JkOiyKXgywdqNbssSXlwNq2bDHLv3zuH4nkqAhpR3g2Z3VnEEKE5dX3DYXPF?=
 =?us-ascii?Q?9DumoOWPnB1aC6Y2TxOgM781c80aEWuro7+O4pTAtnMUm+UviLibPYoLbzIz?=
 =?us-ascii?Q?SqweoO56pxLxjGjTsCSl3Bb5pdNctZ2rLorKnm+WHuCcRuxrzdLXWe6+FVr4?=
 =?us-ascii?Q?WX2uT96tqk4qfWkYkSi+wuJbEaqVq1g1YSyCnq+orjqgkmCfvsuRxvXxzNa5?=
 =?us-ascii?Q?1l2CkDFp2a3x+f4WYLBRtsN3i+Mn8qWdOZBEYSQDr2YlWcO3FJ1vw366Uvhs?=
 =?us-ascii?Q?taLhYkDEwKSdWFsQ4ghPt0eqeG1LNLfnzvvjcV0MBsyexesYygssjuAQBMHi?=
 =?us-ascii?Q?g9qAMh3qHFRM0kOY9L/ED7PO9iBle54ob5vsl56JApsEUFgGMHg+RQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pC4Hl17T93AjqFkr+7sbVakVU66PqDmyWKWspPW6tRirjTG2pmk8NUnCVOGj?=
 =?us-ascii?Q?F/7rkByGaOVupV522vXWi1RLPucJbU1q6p3urOoCEU91T7mZ3Gi1N23MCwwQ?=
 =?us-ascii?Q?N3GiT3aTUEIZ5v11DpB2hywxUMQGnDDKFo8tyo2Vr7opGoUwnp3Y+vb1k82f?=
 =?us-ascii?Q?cK2e3b+dtl4+Owr4z+QRtOrpGp2FcKYJ1xOUpKRKVdyoHl0ghF9Nhp+ZRYVQ?=
 =?us-ascii?Q?H+bHLmkzFcJhV/tq3L9lHLIcExNGLhbZVQ76Kdf/vMyHbHyQkOiEOBT12IVs?=
 =?us-ascii?Q?5tUW6WCcyYbgnKIL9bBsWMGcP0C7dFlfpgHz36rTI0xGqgXoCSOvEjR7zI9I?=
 =?us-ascii?Q?YOyUsxtTK7tGgvlf+kaznspvh0TU41yaJnT7qFna97/kemaE5ZuSHMgmdNc5?=
 =?us-ascii?Q?zeBzPJzPlXnb14aYkxG1fgXTWiZs9NPGSxUsZhjAYId8q62Y4Cg5nQh9vOIn?=
 =?us-ascii?Q?0PosgdAA5e+ut0Pk4OI+viknBJeFxu+L/raAeW+XHFHhSACFuuq5EuawUIoB?=
 =?us-ascii?Q?i6KV5URabxWmofGZNXI6KSCHeuvm/el4v8RNW1jcQ/JYxxH4jHRKOklquzn0?=
 =?us-ascii?Q?/DU0Ar4ppNiRxqcy/swyDZtKthF+6aOgk4H9jCdzYTQBO/v/D0MZoqeuRPbJ?=
 =?us-ascii?Q?gMJcwZHQMfbSnTboUGJqD9RZaTR3BwNjdkKqp2fOXbPG+mZwdIR1gxS2w9AY?=
 =?us-ascii?Q?X6xT6CpyKkTG5SXd0B0GKWwDbIin1UA0x6sfKb2eCuhpG2jpH4KIoIj0c+Ta?=
 =?us-ascii?Q?guMaMC0nIrlDP4QhOrF9aTVXe5rBMsfjXU+fzA4CgzPocFXnRRKmmbkqc8xy?=
 =?us-ascii?Q?AdsRiBi3IsxHKSahWmXVl/EWb7ydeGceNZTgbNSPgJFp+L9c3rEfjh2U/MRg?=
 =?us-ascii?Q?gNUkoYyMQoI+EO+LXClEbMyZYPZCclDlEL3WMTjFUubE/xQC2cZYVWgYvLAr?=
 =?us-ascii?Q?bhdZ8qnzaUfPUu1458+H3QBSws9JhEyaM6vV8uO39Euun6ixidAabSOzbUfq?=
 =?us-ascii?Q?mSST26F/XRfJrCZCVJkDcJItY9hbChZJJSkGp9T9hDxlkw30pVZkerSSUb2P?=
 =?us-ascii?Q?oIT9fNq35XpTYvM1C86E4t+ZkIgIx485qWfMUpfzpXj3iq+Qb55ILHWo6qju?=
 =?us-ascii?Q?9CB3fbeQLXCYqovGUixWLaoQEsvg9ApK7+XqJH3a+ifPJpuvUhbR1WiZqEes?=
 =?us-ascii?Q?AdrQxYP2uE/yCVwBn8SSMIOTNdLJNgNBoHNejS79kA0V5YdyFEv5CEWoYJb7?=
 =?us-ascii?Q?BBOZRX1+GXh6ut4hrvs1V/CrxVhewKaQmYU/kev/GTCx9714vP44h9qFORQ4?=
 =?us-ascii?Q?dsPxaUxg7OMziAczszjnT5x0OQ2lGtG4ZMtCzWzdNIj+f1agEL/5JNw2kghX?=
 =?us-ascii?Q?wG4blkQOCkyHaDd325Ub0wjaMjufzO+UsKEsdR+S76UWnaRxKfD8k0R3CkBm?=
 =?us-ascii?Q?0mLWJTzv4yQJ9o/Oq/0a+DiB7Gq7dqI6ilcX0yD3ytWBHsf854gFLrZX8R1f?=
 =?us-ascii?Q?JIB5hz/Ks+5RbA4TlYnsP9orcnGrxpTm4Fdup1yXh5YrHquYFx3CbQummyhn?=
 =?us-ascii?Q?JPLR3DJH04WoTfAFb7ef5pDZR5ms4f2PWRKoZ+zKLw0S3ZvYa+a5rYnFdgwd?=
 =?us-ascii?Q?PaqraR411xQpRhOgdoyLDZQ=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ab6b9bd4-e614-4055-51e8-08dde6d07aab
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 07:48:44.6756 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FfF0oXJYPIGd9c5mgkIQBx6JiPgws7CuLbJotisR5A6ccJLMqvC5f5GWW6GU3CVMcipgzcfF1l5HIyIgRHFKkf40j35VvCQ83hW1GKLw3wA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8320
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

The patch series fixes speed calculation for nand device case and
updates help to refer benchmark option presence.

Changes v2:
 * update commit message
 * 'Fixes:' tag was added
 * calculate speed a bit more precisely using a 64-bit math

Changes v3:
 * split on 2 patches
 * update help for 'mtd write' command as well
 * format help for 'mtd' command to align device names on the same collumn

Mikhail Kshevetskiy (2):
  cmd: mtd: fix speed measurement in the speed benchmark
  cmd: mtd: add benchmark option to the help

 cmd/mtd.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

-- 
2.50.1

