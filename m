Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1DD6ECE57E
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 22:21:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DD4088E3A;
	Tue, 10 Sep 2024 00:21:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="004KNtzS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF9D488C31; Tue, 10 Sep 2024 00:21:31 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2070d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::70d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4CD488E35
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 00:21:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RjImYgJpctdwBBgp9PIYrQPnTYOQWppYR2fSztZDPL1HFmPBNXBZgYV0fvb8LLOGyKCqCd9rrhDVzjy7r3k/YmEXR6/MKsjc8iPrfgfOHBHLsymOppjIlB4FI9SU6h+BtQr/JTClx1OzB2yl+ILH1dOIdtOc04n3r0+qu1h3SO04r5dh8FvOohyQ+hMY+P5gdkYq2QiwZXgqDHGQ70M6ZI6PCnf6rXAlbhsEJZLIDRbRO+/KozOF8m88nkx8+N/3WYhbbWTMoJCJLboJI71QSmc4WeUo8pJFFQ0iSvSLXtYlwivHa64NNF6eNof1kjhS9iww9Ggl2zzgfHu2OWx/gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9+FKGJB42X0d1n3FS5MlD62PdFz5IT2ryw1AOhEHmo=;
 b=gVb3ePrssQe87cA6HjsqkKQGrPSq7MowayzBk/NKujI8sxpD5ZyieTnAeL4FTq4Ulw72OnK8fqeVdbi5YmFs5Y2+zM7bWRsB1MEmufF2iskIEziZoCHb5C9M4GugpKJu+VrDOwrT1u2+IopWX7N9e/rR0q36H3JeDlrfFFgZpXHExwVzcDZvDSy3g502wNWXYr0eLMjXU0eR5XbvoelYSoktAf7GtAvV+wtQyX+8yq372WYsizP9NAzHdM1ONtn9RAf5cYPuUogK+7hEU7JPKMJu2Y2pAnnCyx+qvmDI1BOPooNYgxektGT+D3PBK24/S9piqLsLVLLfwpqolZPPcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9+FKGJB42X0d1n3FS5MlD62PdFz5IT2ryw1AOhEHmo=;
 b=004KNtzSpSoqprASfnInJ+jCAm+NW583u6HvBRjQgL4/g8vhub5UbJh7sqJ9stLcofiiDQbyHlXh9Rimrn988MjTkSsl66JYvFm56/dPO3tNAA+GqznFHY0gLix8pvpFtWe4cHBQ4HP2aCrYozebQyYcHKF7+hRhuXdWKfGRhRK28QDaNUTHGLB7WcKTlOfL0hy45cwzA66Ua7iJ96LPphtDhPsZLSbpG+w0kKieUmHb/7ItRUhfNvm/Xg+3SnJNrG2wnEEEMpdGrn4p4jRGgkeT66DX6AEXT1Rl0NyrzUsnQh3Kx3vwOc/NnJ10PJJi220auscp6tLl30SiU1u7fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9935.eurprd08.prod.outlook.com (2603:10a6:10:401::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.15; Mon, 9 Sep
 2024 22:21:22 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7962.014; Mon, 9 Sep 2024
 22:21:21 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Anand Moon <linux.amoon@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, u-boot@lists.denx.de
Subject: [RESEND PATCH v2 0/3] cmd/mtd: add missed featuries
Date: Tue, 10 Sep 2024 01:21:09 +0300
Message-ID: <20240909222113.2562703-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::13) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB9935:EE_
X-MS-Office365-Filtering-Correlation-Id: c3b30a71-b232-4bcf-762c-08dcd11dbb99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|7416014|376014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2eRQWAVwSBVPBSdrEMEjYnFBzhuh8Tg/Og0V5TvOrOjYhkcgaM6mIu6iR6i5?=
 =?us-ascii?Q?FGCE0mXFvSUbqsAa0GXJ8iNPfwBR6LGkUCR6H+E8sWTWRAZhMmIlfh0GivL+?=
 =?us-ascii?Q?+PkSa7Rlv3ufoAQ48U4kFgCP9sqBnf8lx/g6+6TpzZAKCoJE2KLo7E6BOcnW?=
 =?us-ascii?Q?EmlnqOzyEscfulus+9Y2HIFglKunLEWn47capjXlZ6LdSU73iMCEiPCSYoXJ?=
 =?us-ascii?Q?J4ay2gFM63wq3p8DDUVwwa3+w8fJoA6unzRHyY9L7ztm9isGeBa0sonzeNS9?=
 =?us-ascii?Q?SZSPGt9kEGBiwFjfb+TI4VyhBdEtmT2Kc73T94HF2KA4Tmbyr9gkw2B2DryE?=
 =?us-ascii?Q?cBjtwhcvALNXqvkHlJMA7EoLRnbS7hsxzY1pjHPwXv7TnHCrkwfIFi6YiQc2?=
 =?us-ascii?Q?kJVSSlhtDksBQv6aCTCMYAV5XgM/RlC3+uyHz/zc9n2Bkh0o/U9m4LqrhD5l?=
 =?us-ascii?Q?DCgB+Isg6O5ylgpq9gTa82LPFqYuYfKPyOlViE2Xwupat1TUx1Nj/KMCF1EN?=
 =?us-ascii?Q?9yNkzwPLdPvh2nN/acH/B/CPMq/ktdgRedLgRPAJqEBsj8WP3P1hUpIAgjJO?=
 =?us-ascii?Q?WSWzEA00/DKueyvIumGZgVvhqSLd2Ta4Z9RE6rFYqm9kqhpJtSwUHqM8utdx?=
 =?us-ascii?Q?hsTn0wQcOmMR2r7Fxu4geu0bQMBSO/9Fg4ojaEbv9ysmry4F+FfUX0aHLW5R?=
 =?us-ascii?Q?HHaN/rWWuZ6H0BagDa/RRF0xBnwo4pwu0FDj9MoEYvQKb3EOxKxJQH/I5FwE?=
 =?us-ascii?Q?/BRcfTAH5Ym0ePVS33/QrzP9+xMManaFfZLx5kbHnaOHEnYSgVlfC7GAPHN8?=
 =?us-ascii?Q?zNQZCC9O3cLFRT4jXdmlzi6pSuZrAmV7wd/nBysuN4Ss/sTb3kiPiwdUcKYV?=
 =?us-ascii?Q?imLbk61psNzw8Uu2eeHIFZvt31pUAMdd2A0X57PbuCLC6Lufd2PwNkv6EtIH?=
 =?us-ascii?Q?ezY6xhVHLq2mbFSkGdabQliIAljqwqOBg1JfU4Rvm0bETQt3BUDINuE8vAYN?=
 =?us-ascii?Q?sbaaNVd6eKk0QUY1JYMvcb4szHAQ5DLYAYVS48iToIvDENJ9v8tmEPMka3ps?=
 =?us-ascii?Q?zjQatA6qlKWEUxRpb7vHfqcTTZ9eCKZn/XG211IEEN8V/TGyqjEjyxA1wPa3?=
 =?us-ascii?Q?4BrPmiaKUtxc4jvHH5aJPYdYH7qmlYd+m1QwTa1/cqBzgYox9u9bs0wzar1b?=
 =?us-ascii?Q?yv9lQma77oGrgze7GhuzpOWEL16GeGTHUWkg311ndHDb0te0ITcLakM8sHy8?=
 =?us-ascii?Q?PXNXwxY7mySdYhHGdODNdH1lUiaPcR7a7EJ3j9RlgHNzMX/E+JszCCWWYI6r?=
 =?us-ascii?Q?uDeOM5UbaovDMbMzLiX2kAMYKxaHe5OU32+k3LJv88yAemP/c9Vd2D9FJl7/?=
 =?us-ascii?Q?juOakOGv9o1mWnvjrjmjkBM9N77fxv7KsDlZgynudbeKO/F/JA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tIoM9JbdWt9Vm/Ky5RQKC+YjKXtuvW6mCHOPrpDBUZGnDScod7mczUZc3FWR?=
 =?us-ascii?Q?zXUJgS7X7BphSlQnYIJG7TmW1EUG0Sut1BfD9eA8A9R0KwLyuvgH3vIbYa9L?=
 =?us-ascii?Q?fnKHaKHYd6IVqYsvZq4INWQ0A+1TW2mx3tTv2GwJanAJ7oNIGaN8CM9mxyDz?=
 =?us-ascii?Q?CZkrHy64EiDjqSQ6k6Gq9Y8NVQkND/GVoR54YrpCq/h02hIarq2Itji2tSJv?=
 =?us-ascii?Q?4S+8JdMzzIPCCoRjqTVjLAYwU4quKf5mcOVwKwoXK7lWXoZmiOoHRv3F4FZs?=
 =?us-ascii?Q?xUyt5iL+R5UA2Te56cvxvG29taM1oiwzHAkmBLqILpg2DaQ7J6nyr0UWE0/3?=
 =?us-ascii?Q?wc6tUOBl9J7Sat1i3uZEchpPzKjFeYVa7gzVbE1qoFUuTKikQxz7m8+vH0da?=
 =?us-ascii?Q?9MBIj28hhbmup/iPy46SRR+XNYuPXc3HVbcON85+LVP7t7U7X9awxvggolle?=
 =?us-ascii?Q?kjG/szB1gFGQOZDQPtKyJlLG4eBeiKeWQHR8YU73hXAGC+nthMupp2g5aSKX?=
 =?us-ascii?Q?AvNrkc8UWh4PWCqN9+9rozuSqcxaXgj4Zg1I3XKsR0u8BE6V4DPprkW032x3?=
 =?us-ascii?Q?PxBrpmHrwwHHw1qgJV5L7JRU9OXIwQ1qpleNAsXUtvfvWLA3e1o7yfHdRCZz?=
 =?us-ascii?Q?LIYb3+xxu33Jc7RmRJsBci/2yEA2zTHIxzjmpeqS3h23LgL0kd7clF39rMYw?=
 =?us-ascii?Q?R3kf5nwz84Xz/afFgDUzIaFbaRe35BlhZAhrxrX2aFZov4VAi31Lv3p5PRTJ?=
 =?us-ascii?Q?zAy70Br+9jytZ1m8+7TPFPkJ6vCYsIlfMrwdIbRa+2MswnFS95K8bFiwKf9W?=
 =?us-ascii?Q?BTSY8+k1Loe5/+kq4JemHQfq5miKiKihjDoG4/eIIPdSR4edrUT3iCh5gfDS?=
 =?us-ascii?Q?Tby9w3611swLnyGgjiHErfAiGCVpZ4EmRtstacdIFjY3MqWSLgSzv81RYAv9?=
 =?us-ascii?Q?ui+SBFd1J9j+ajTrRHEVH2STnhlfHfgL4jn0/jRmf0Z6jrv27pCrMHPyQ/Ue?=
 =?us-ascii?Q?iXe3Z1sqN1WoxYB+7OTayzCrHdc8mhnS8dIAfLhOEL8fQ535whhNWIranZKw?=
 =?us-ascii?Q?ATh/JXB6BSo+cAWKZR8uNm/5LQnbkOfZSW4vQbJ/tG7cV7X+nuzvLTpOK/iG?=
 =?us-ascii?Q?htQswqWi45VH5neH8rJCCz2J2jqGI4fE/hNQ92bjk4OLEPhPAiMn97sC/vin?=
 =?us-ascii?Q?tmVyAWVyOTtitZOjw7dFpk7E3utlPGgonsKQYNroB/mWzqIbkPutaBKA4gXZ?=
 =?us-ascii?Q?GGpS+UH4UsULnXrbLsLs7VBQQ97qmiyhZYZrUVzM0zjOWyz0lKZYkZik1vbX?=
 =?us-ascii?Q?cWxNG23IpuXDonSm3noKQ3H0WMXSucBvI1K+3wgBL5cfoJWiMe1/Mf/JR+4I?=
 =?us-ascii?Q?50x/0kaPCRj1/kAz978g9RW1AB+BMNEtr123qi5sALBRMwHOzHJdKdJ7yceA?=
 =?us-ascii?Q?1DTE8gxwJhWC109df6RL87DcVeAmaAyn+G/7TD3KjTdcvrvWRh6Wa4MkKyBa?=
 =?us-ascii?Q?PiWxJZxNo8XtmtNgLVjlN2RgdmJDzquC+dcwCgVenl2zBmL3geCRnvXDaOPt?=
 =?us-ascii?Q?6lgtF1cst50eiTXE8y+K/qDHtqzTmIt1y99qHuQ2cXTI/bHtvnvqFWTye2a/?=
 =?us-ascii?Q?Aw=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b30a71-b232-4bcf-762c-08dcd11dbb99
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 22:21:21.4895 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28VmUpVQabbU6BsTzLIfsmXy5vQDtlmcEB4fVve7IvIf5bQmg0ZfYZUjiR0KWevxkviyzHzFWP1BAHC+A+l55vjqSYHYnU4HFKC4lFyWud0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9935
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

This patch series implements following subcommands:
 * markbad  -- mark block as bad (copy of 'nand markbad')
 * torture  -- destructive test of flash blocks (copy of 'nand torture')
 * nandtest -- non-destructive test of nand flashes

v2 changes:
 * add cover letter

Mikhail Kshevetskiy (3):
  cmd: mtd: add markbad command support
  cmd: mtd: add torture command support
  cmd: mtd: add nandtest command support

 cmd/Kconfig |  18 +++
 cmd/mtd.c   | 457 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 475 insertions(+)

-- 
2.45.2

