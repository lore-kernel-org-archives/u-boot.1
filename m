Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B911C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 05:28:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD523846A4;
	Mon, 29 Jun 2026 07:27:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vSSFLXMx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA0C284832; Mon, 29 Jun 2026 07:27:57 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97B1F841F2
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 07:27:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DtmIsh96n7AQ+3D4Za4Dxwq6GHGGVrCro+vMi5FytDg1Dy3tWDPzjp94FpUNaCNgQt8+7atKuNxAqte7qN8yXH+BEVVB54P3C2ekbgJLRSiSJmE9edy69jBo2SZ1INMahkpnwSLDoiNS7uiCMFMUvYwj2Ml3Ye0oYLEKHSI0KjJpBgjbe9RsmxwFvtuEsTaKWMAZLPjoJYbf1HEfG2ks1c4tMoWLUaLQxnrVK0NxwLMxbbtEh2PDvklRvnG3BFrm4c3mUSThsNlwAfmZ8RQblm5RRB9LEth45Dpw6pQ4R+MTDKWF84cgOR5BR6HcqSZYTkozYYCbDDdLNE0Z2Dz0vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNM5cG0UlvT8TbVFOS+PFI596Nh/OebCMxrw73aeHFk=;
 b=LxCBy4/+NYQBKGgPhAgLtXnb6IErhzrRzHBjATJvFaB7LfiJ1+RDr8eTK0AlESThPZ1v8XAtr7pNL9nyV3l7aiNE4hgJ30ZKdo2pbFFLVS1G01k/1Yt2fCOtRhA5/05SCMlIY4HffKY8O4j7gTZZfiTPzai4ZJ5XiuhnkR4IPnMm3/xMvCM7qUxY4jj1L6SBvkvbEOkalePPrYTdEHG8Gz0iIAefx1wFRllox6pWSGKYuYkZ5B8TTAmGPwsHX1E3dApr/QoGe2psp3gtyTYCz7UVl6g3MTy8Xy7Q5DRAQSYVGPYfixyjCFOm7R7qUpmnElEh1cFk6GlzBXxSro+raQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNM5cG0UlvT8TbVFOS+PFI596Nh/OebCMxrw73aeHFk=;
 b=vSSFLXMxfOrlAFh7kkKR4f8lnMtSe+x/sVdiUmT8XOx8wtBYdcsxbg0hSKpbKB0l/4pTxyKrqMOY1q0xxQhX8lLi6jAIMRfbbRct53H3Ipo4MUGVAyWzxAiFYKxYeAtqocBZ0J9zXpi3lPXNjk6AK1zcfHxejeA/jxWdcY1IvroC8qdvvmSOdr6sMmljW617zRk4WDjhI5HII/MG+YL74HO8X8YAcHn9H9dhKQCGT9yw/4hMcGLqCwiqjH5zleeVWzh5LXU4JDBuRiLPPvIUWbWRnBnQnTB5bDta0kujQqdilRpiqwI5+M+JaqGoUufI/hrVL69dpkiY/L75IjVflA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AS4PR04MB9622.eurprd04.prod.outlook.com (2603:10a6:20b:4cc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Mon, 29 Jun
 2026 05:27:52 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Mon, 29 Jun 2026
 05:27:52 +0000
Date: Mon, 29 Jun 2026 13:31:15 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Kaustabh Chakraborty <kauschluss@disroot.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/4] test: dm: regulator: Add regulator_set_value_clamp()
 tests
Message-ID: <akIDI7eTiJIyuh5+@shlinux89>
References: <20260628102527.1247889-1-jonas@kwiboo.se>
 <20260628102527.1247889-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628102527.1247889-3-jonas@kwiboo.se>
X-ClientProxiedBy: MA5P287CA0179.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::11) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AS4PR04MB9622:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c0bf693-32bf-402c-f6a2-08ded59f2acf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|19092799006|23010399003|1800799024|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: w2PA+7rWcNplntqzz2J/+XvuLl6fgn6KwpmckBK2WY2jMczyxaXfjWJie/JDzw68K260RMiRwShfo2IroeTTmEuZXrYsM+PPjtXu/ZvKNfkL6kv7ObcutFug1rDLxL/yvCxMEyOhmqCEkQFX2UoOGAxQ56ZpsROs+Bd2mlbgheArg1i1HhbTkzAeXxdIA2u8KpecBl9gL/2ayZPjxh+S+CNGZA153cHwRtOLUCgSiW+wPJW/5E4ONc/F/Z1YiMVn572YaqEmcQXrOhV4nADlKl/Wjilv1LcvLUVtwEKjo0oJgtzKLDnV+JP2wvs4lWRz7xla+w3AwjCpjU2R+JoPrmN9dWH+c30MQTzXpITqef7tS0cQ21mqSOJAjyVBDtzrUWG00Anb62Xty6ji513cDyVMA92I4RwNeWU+5wEs0afOcXl23mWBpC9FsjmL/Wp68wzQDMpSB3hRp4jmtiCOX4OWE7Z0OseLBx9rr3kcMmUzJKFtAC0qHq7DRs45l8li7sFQuoTzLk4QGNfuE3NKmHuTi+4uH5E1M4zwKnE49vcMNAGYAiSOORj7hTLUAgIfsk/1NNmleWTRjAif1A9g+wQ/qy2ERPdklr+AUNapZksK3e4P8LfWIZX89ZEQ6/Z8C6eUfmVx7uDpTy025SvD4oKg4Nrvfp2ieiTUoxcpl+w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(19092799006)(23010399003)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3hqRqOfP0VkGI4DUvnxKUGqdKH5V08T+vTw1fYti6exyhOgNd6ZUQ52ZKiS/?=
 =?us-ascii?Q?uatRtoL6Lj3j37zLlNzF6Bvx8/NRCnPeZvlb9r1f/wvp08OI1wHVsBvY1P85?=
 =?us-ascii?Q?k6mg833iCHsRv9BRYYO4ZzN3qWETxPATrP8RsD70lWolE2K8MXDw1AQ8HzDH?=
 =?us-ascii?Q?ZBjFOtws0xrbFBsnZIwY9DtVWSD2LmBAac9wkm+MZkOWxITkyuHbVBnEKN/E?=
 =?us-ascii?Q?ZJZRKZmpOohK5Y5+HPGA957Mm2izbjwmsBoVpaYd6vNA6lZYHQEwzDujhBu0?=
 =?us-ascii?Q?0uzwsFHtC2Rr+JUL+GV7XZpaskiWearVfzpCHS8UpggxIW4UWgmH3jfXcqA5?=
 =?us-ascii?Q?dmMwpQRT06to3UTMZjyC8TwabpIFxg+miNEnAiM+YLcQcejUwz1kxK76on5Y?=
 =?us-ascii?Q?pTyyg2oIXB7KuZET1+1/lHK+iYKetwz+XNpuJ3RVxHEqXNRhvc5vMpPV6ARn?=
 =?us-ascii?Q?6miKNgNITq42VQ8nOnrlyRAQQO0GHxipK1eUetHhYqjBb0aQ6bu+4RdM7GvC?=
 =?us-ascii?Q?Cf8ElcUszAqGt5sTNBKQTcYkjrNId28/hbBhKMwHetO5iF0ZDgkZYxEYdR7P?=
 =?us-ascii?Q?hqLkXv6j5rtfHvhLNsVD5li8DRrSlX89iNyG8/VNcD5ptksMFaiX7Y7eJMov?=
 =?us-ascii?Q?0hxKR6LDxXZ9iOejlh0O6YvLTp5mi7Dgserj4WRYYNiv8lNQs2y+sfOKcnes?=
 =?us-ascii?Q?gVQwaeHI8TuuJkHx5NElvERt4G+4xR8lTZ64pGF5IUobvpjTmmYV4rJ1c5U5?=
 =?us-ascii?Q?h6hzSlnCcU0czjnsNKrg6Qqq4XyimerAgGsO6g0YRoVwJMmjGbtli2hCfdg4?=
 =?us-ascii?Q?k9KBdYtBPbVtKi/C0PYT0e0WBMKba8mSxwY2hcyenF1UqOlYx3dBnTXz48al?=
 =?us-ascii?Q?2dckOOxturrJE6EdGKqWgM+SoSKLp9jHU7x1KnTlxQqmT4iHtUDSVA9kN900?=
 =?us-ascii?Q?Na85DiBcuSeA2PuEHViDsy1/Z4ypNImi/z7YarEPzWFBtEcxzMLGNjfC9qWv?=
 =?us-ascii?Q?Aa1HSjteRyuA1Ynpd8mhyzk+Gy4OtO1POO0TSl0m6wvwiKkUm73t17c0S5WI?=
 =?us-ascii?Q?8dOQdYSaVrUhe4A8N5fAAF0EozNJceUScu/ABzL2D9l91YH2+PZraFE4isn0?=
 =?us-ascii?Q?rfQ0gZXSbF82SIhUzqn4/1QgClZgToUMJ6VZsin1qtit/nFB9o3oAv0+V9ST?=
 =?us-ascii?Q?ee7VY1QKqlrVErhPkTrp5mOtm6aamKwOACMZfv5lW7ZroaMIZE1R0/5U0EBQ?=
 =?us-ascii?Q?CfcVVAlaIoWRurJ+tjMtw7Ycf4716ocRqxrio9gxYjZfUp3teLJAHYJYbect?=
 =?us-ascii?Q?iKOPQLe4IFM/telf46hk+3YOB9ksV0Rj6fs3EyeEaZzcqrltrVVxV42nKnde?=
 =?us-ascii?Q?coaeyU0Y2rdRIuIutzrSdCrq2wgskIKNPh6jnEJXNyLXvgZ4+cY5FXi226Cm?=
 =?us-ascii?Q?MKsa4G7e9GCyJmq5j+zZy8yt1aTncHeXa6rkQerDwzwjQ7C6rfv0GEXnjhea?=
 =?us-ascii?Q?kwalZ3lLRmamXVGQM+36Sg6nPUVZM20503B5G/sF5zgnxqQ9PAkYOX7DUBHx?=
 =?us-ascii?Q?PlaspwGVHbbSdFm/FkiQNN/mo9wjmyPVTA2exCmS3mjkrTEbacuTI60W5za4?=
 =?us-ascii?Q?s6JG2o1EFPA258OwJtgQgucpA1miNaW3ZaWS1gadXaPZfQ7+fk6TlPQNjDE2?=
 =?us-ascii?Q?YBBQ5wYceGeJ5DNPxky4b0XoqUzjJiEPso2Zo2YLegKuD9UNPqxSrMjji00Z?=
 =?us-ascii?Q?tFzmCqzcjGlZo50nn061uNzYUyy1mqOydpc8rsC7OrpUvVnhRtIr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c0bf693-32bf-402c-f6a2-08ded59f2acf
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 05:27:52.8883 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dqUQfP9xT1eWvAHSJnAfmEYDsQJUR8NhNDGUgYRiasRcRTrpxAdPGVUWM0Fl/NsZgT9MOxIUxDiDbMgL3M3u3K4csQg/K6jSsDuow2elv+q896lzsbN5cv8uisXTItTM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9622
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

On Sun, Jun 28, 2026 at 10:25:24AM +0000, Jonas Karlman wrote:
>Add a sandbox LDO3 with a configurable 1.8V to 3.3V range and use it
>to test regulator_set_value_clamp().
>
>Test in-range requests, clamping against the regulator limits, invalid
>ranges outside the regulator limits and a min value higher than max.
>
>Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
