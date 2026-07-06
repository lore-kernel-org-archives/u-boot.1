Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A3CC43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 06:34:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CFFB8488D;
	Mon,  6 Jul 2026 08:34:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BwUH8JZk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1AEC848BF; Mon,  6 Jul 2026 08:34:10 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA9C5846FD
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 08:34:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pZpJVF1yX9HsminLOh7cBYFr6+tHmpvBprg+9kZhOhi2mdRfe5Mb5Zdd2gVYQbD1V+KLnVetE5P1N7GHw+YTvP4fLXX2zmDL+m4ocSt47ro8SbH08PjnU3/MJXHlmJI9tIo03HdBQWfBTPpKEOnuwmLXsTGHyOlRJFItkVEU8if3ijCxvcxPJbLwfDwaKYA0BXnYRkhNzxxPag/kuGS9/Ef23VUAOAA/8orOnBV07FfKR0x8zV6qyfdl8ovm7Yt8B9CzqpNYtInBBRyLrsLvzHM07A1rVARMs2Yz4iFK/YQHPzavsBKRe28I3ZQcLeZkrcZHuM7nq7bwHHM0bGhU/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2JggKfHeSoWNGM2/Yeq6/VQ3NxszqTC2gkVVr6JTeI=;
 b=KXBH+0idjhjjb5jDK5Q/ViLDr3Aqd0EfloAxxzit/n2UOWV+ZFUHuA5pcAxV6nLNb/W3fIcNaPBYcMPNT1LxQlzg39a39DM+mk9eDwLc9wjTbLz8ALVyKMIpsB8yMc6o2JD4XxirGqg3yfM9NQy3WpqHslhhcg/I8Z81CBg7JD5FcaXcPd8cVlQyLy+k4VVXXYIsOAjG7aCqZdMbUUEmOwMEpOhGuRPAvxLb5Rb8Ufw8stkNicw9LesNFkptIXRYucpmchD+MiQya0TIDqiPt1UJ0mwXRGbkAvvFkzzlxJ7oLGomqw/f9Yww3W6a/TjoVk09vBV6Jc9jt9Vdy0Dm3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2JggKfHeSoWNGM2/Yeq6/VQ3NxszqTC2gkVVr6JTeI=;
 b=BwUH8JZkp2KURWONL3dj/0y8jcIAADSvBFuvPQ+Asvt6TTqsu3lB35iMmJU0DM4B+K8ryLnOvFRlW4+Z5Wr1I51iibfeyLAY1+0vnPWEdagAMjzaX0GH0b17Cj8Iv2dqsyEUyu972zg01fcpD1kp3bHbqJmaPph2N/QqD2foN5ijcT6JORrgQAgASlapsq0ObFfTrv+GZW26YH3zYFLxUGZ8ps+XbiCDkN9ijPPbdyhfLZcivcGnFNs3LtW5KYL/+QJqLqgUlp0/6FSREJv9zp20G0WNHIPqSheOLuOgYbX10NNPrUvxPT7zEeRccULGl3QSWG+IWi2fVjy4HrhBJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AS8PR04MB8835.eurprd04.prod.outlook.com (2603:10a6:20b:42e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 06:34:07 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 06:34:07 +0000
Date: Mon, 6 Jul 2026 14:32:52 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, trini@konsulko.com,
 marex@denx.de, Judith Mendez <jm@ti.com>
Subject: Re: [PATCH v1] mmc: sd: fix redundant 1.8V voltage switch on cold
 boot with UHS card
Message-ID: <aktMFN9B5hbUCwBV@nxa18884-linux-1.ap.freescale.net>
References: <20260514185411.20884-1-tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514185411.20884-1-tanmay.kathpalia@altera.com>
X-ClientProxiedBy: MA5P287CA0105.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b5::7) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AS8PR04MB8835:EE_
X-MS-Office365-Filtering-Correlation-Id: 317b1a7b-b17d-4ed7-dfdc-08dedb289476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|19092799006|376014|18002099003|22082099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: 4kFLgGfBf23PaNgpmkw01RehK0dw637Jh8fkttTLaYRO0s+2iV/RZR0ZPdxbLZjBSk2ebifhh+TNMxkQJnIMS8YU9mYCSyDXWNGXWtbKQRlC4CN14d4AUNUHYFuBN8ayerR1ZxWUW7vucuOl+fFTgWwEzHTQ2qtbHHc6JOqGGyJ1Tk14wP3ylLF4ENUcnc1DYF4/m8S0FujWdxJpi3MBRDn2Rm6oWTZSqZ8bndjrQKURGCb2t/MIajLq9MoNwX7oW110m0ycX+ZPCMvcbPWXNUnvQq1bcrrBmdmWZDt4bgO9q1uLrkB2fnfBsfumMgIyq0Ihe/u6U9JMWRKSQ8CZEdHozleTLoCK80CN7zBVEg1cVHNgz1EYFIleXxzp2l7i0+Jc226Z8HxYszKlSahe5DZtpuodubt6E7334EzjaNCgAOzxim38YVMmyveT7zAae7njkEZddtErCvDrYqdnQaeJp7aqJ7PctHMaYiOkgGV2bQklVDG/uv8B74akcE2UduHWJjMjOq3K61qjvOKVO2801YAii+db3G6X0ZH3ILTT7vFohyS+fJQLg9cn8WZP8l3XwCJImSlot8PN51aga2ZUgUrILIcajfbV9tjeZUSSdHwjcFb/pQ2SuegTmpKqw34XNbfT5/F7J4I64j2qI4gjsDYlxOFW+AqKPWsijQ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(19092799006)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gzyG2v1vuBMt3J0KgtkrOW/uScnLz/MGZCKvn1xn3HPowKvFaIIs1z/QZUp5?=
 =?us-ascii?Q?JaWcELPsk8LB5+Q4V9lOrao7IpnTkdL72BJayY20z9S4EFYS3ctzxM5+7i9K?=
 =?us-ascii?Q?QEZcUZBjdbkWMhlNmPeIu5AOWRVa0WqCnuIwKbagDtkCgCBh5SyuAOTMKwOI?=
 =?us-ascii?Q?JYPuNCUQ4sbpA2PARtyO0I0od7mHoMvLeoVvaAa/CANtGHdpHhpb1mxyO6HS?=
 =?us-ascii?Q?M04o6AO5I68vMYXj7inB9ZkBR1uTdrNi9mAqPcfBrkzFUyLhYtqNUT6xvbYv?=
 =?us-ascii?Q?Q/rBJM7oHJxRi87+Oc9o3Z6za0ar61YU/4PUDg84bTHOn4Kz5ulv8O0gEk1B?=
 =?us-ascii?Q?mOaZCoEILPBKJyJ8ZuVzvXoBtD844s1Xz6Tf5Q6ke2TwcRiaQ8OkpAE5w6Eh?=
 =?us-ascii?Q?asXnPIWpc0JO5UX6UKoCx6UiiAos0bpWDHJkdDtj1aWO3fcrpi4g7ToQGVDi?=
 =?us-ascii?Q?EeI0IHKl63u9bGVh9qJk+F0A++kq3VH/gXxJ1YNNn6nv3CUQs39nw2GOpv5T?=
 =?us-ascii?Q?DzAaVrjILfLdDTVTHbLwHE6d5SnBunELduWmyC08UVi3jMLXNXQf1Re91mB9?=
 =?us-ascii?Q?1ozJdNDPfAFAl87bGdgw3uiRDixCacozoYXB/9xVUOBh5sdbtK7yieC0Nl2D?=
 =?us-ascii?Q?bNLWrT7qg3dmQYh14ByyNShzZMLwIShcVqfy81AXr77QcCUetpDUtRiWBeWi?=
 =?us-ascii?Q?tHTsjCOM3wZmUM/bF4FyrCo1Tcc8Tt2vzzRnaq4ksgpDqCWo4Aav5qFRyTep?=
 =?us-ascii?Q?y/+YGLLFcRwUWsVBzSphImPJUkHXEUhg1RLO8M2UGWDQC8B/1HT7sg2lhEDd?=
 =?us-ascii?Q?gz/31s3lIfcazQO8Z3aXuPE5DjewUuZqGKZeUbyEt3do6oGIj1YiPYjyqQta?=
 =?us-ascii?Q?1aoRItBPZSj+zv9BNMZIqsM79XSiirMFoYMbkje+YqUH/O1tWYnFBzK+AuP+?=
 =?us-ascii?Q?UnEXOwM81C8anXGD7G2ctb1Nz9TSo4QR59mEydh4qNUD1vfWIAZZ/iBcLS6b?=
 =?us-ascii?Q?yNq58qos0Xhr2n14NIsyjfPDn1Ju4E69PL5DYa85l9Z7dn+LimwlDltlFyFT?=
 =?us-ascii?Q?CGiVoJPJ78KRpD2gZ02+4k+IZIHFSNVSqlE1ZGdgzhql+uiJXi9gNYpfsdTm?=
 =?us-ascii?Q?u2xeoUfZ9ZqeBwkW8iLvVSd/imSnLqA0+G+2yfhzZMewoz8SX12yD2gpE1iC?=
 =?us-ascii?Q?ijc8/eLCUP3sSWovkjHzXV0fmmfKhRm7avtK3KscYLG9kCQteF55rP+qQPsM?=
 =?us-ascii?Q?+kEZAHeDIdM4vnQji9/kmyN9g/8E8FdFiJVBdVwLz3rIaxAVfGO5BhdL+HBP?=
 =?us-ascii?Q?fenlzGrTcn3d+IDets16jh6dcOdjF+DAOzYnAToOCN9IdXghauVoawFkA9Xt?=
 =?us-ascii?Q?KwfpZFluqSic2t6p6wHYYi8oZbAd0SKoIZTLIXX555gF3LhW9JkFAMHD66rZ?=
 =?us-ascii?Q?VwB6ItIlmrb23/6ooK2ppHQklUyFEe6Vcy5fS8w2tdTk0HODdLjqsG8DUzH9?=
 =?us-ascii?Q?2wbokToMyxjM7H5HSUDNH7SsKOBjPE6QUh2WG8CXI4Ynlcuf1ugodFxkMmFE?=
 =?us-ascii?Q?ipnSFEWa9VW8oLqwHY7PKX1CHC53T/oOYwIRT3CJQOUasrmqUTFSYoFcvtAa?=
 =?us-ascii?Q?fgK5vycEhivLWVvR27fPS4SNNkXbhxdCcSXhlVmwulcQihx2jfR1o8QiKcZc?=
 =?us-ascii?Q?ERnJ32UIw+DyT0PMa9o/X00UH/xRVcOdGbA+UEh7WKOqHer5XafuFJlIIT/0?=
 =?us-ascii?Q?wt9deIvsiNL+MLOUcQlB5c03TEmTllIHR7CG48q1AV1Tl5aInUW0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 317b1a7b-b17d-4ed7-dfdc-08dedb289476
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 06:34:07.2259 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xUxNHY1X22dUUHW78tcpSB/NmyUQ5FxKF/n13HvN4Iui6th6Fk1Noh8EnGHvYXlPGy989yCFYK/AReCamgGAOg/pEdaxihkbE+5IxoWMvhjSr2e+3PA68Gl9KY7xgy/8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8835
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

On Thu, May 14, 2026 at 11:54:11AM -0700, Tanmay Kathpalia wrote:
>When a UHS card successfully negotiates 1.8V signaling during normal
>initialization, the host voltage switch is performed as part of the
>ACMD41 handshake. Without this fix, the warm-reboot recovery path
>would fire again immediately after, switching the host voltage a
>second time unnecessarily.
>
>Add a check so the recovery path is only entered when the voltage
>switch was not already performed during the current initialization
>session.
>
>Fixes: 906ee6785b1c ("mmc: sd: Handle UHS-I voltage signaling without power cycle")
>Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

Applied!

Thanks,
Peng
