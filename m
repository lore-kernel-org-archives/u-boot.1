Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB99D41C14
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 10:07:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6EBE83D0C;
	Thu, 11 Dec 2025 11:05:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RCvbAQuw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84BAD83CAA; Thu, 11 Dec 2025 09:26:29 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013033.outbound.protection.outlook.com
 [52.101.83.33])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C4CD83C7B
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 09:26:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZaJyM1VTPqxbtTef22T7DVpfdNiTYtGKzGeBZYmK8KgTW1IIcc7S5Ry3B25wyCVkHQY7I5bqAfkZv2uroJQwPPpFDbxprgXKpPzzTTVOhnC6XuajEpTYd3wnV+wZOOo+TWwHr6Pcr+vP0NTvkcd4qaJnInbrgnRcZoV59m4hTb9JpELWMw5AXyPtyA53t4OjqXWHzqDFkLays1kWT/IV56P9UrCgNcWNGe4qjTuvmMWVcDnvgGprOE9GkB9ZysElVG9hpR68Oqyxh/TYhUcvBAK/XZPqulpBtnYIBpVh4zRzpapCTZ8lOXf+qPYRjHCMFZDjXkJbVNGp/lx7sYxuyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxWXom01+tnu+SecycwbDWTg1waFlSRdMhtVoM0q+hk=;
 b=yc/860TGfVkyrORz/bub0Pex/q1mpVJJ0KYizG8h3jC7ZxWgIiPv4snnSq8kHX2JmjVZnpAw1kIEHryUc8IxeieKoDemLGudW5GRR338wNBC8ql4bota00V+E42PmFNW0VDG/pH3vCWbd4vmA2tBEIco5k4AzmtXQPvYIgRnAjhRBNlTZk/OGE1r+0yUG5q9qUxyyx5kgM5OMLI4qzN8PsZXjrXSw/HA4qAsNVSb0LiQG8U+LdSqB39MTTLoab9FK3wmmse/9SwVXUiGwW9e8S/ZODv0A3NHvXvOgAG+h8RMWoTnU1bdqLAIETxkeK5A3mU8WLEtXRz5to1wG8P/3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxWXom01+tnu+SecycwbDWTg1waFlSRdMhtVoM0q+hk=;
 b=RCvbAQuwcVVfK0YYEKoRUlorCNGSBXpia0oremmVkcyU2HsECnaPus2fWwtdICgxAAKlcPFP1ZP7jHakcnpRsLVK4GkSNMQyHFZVd3lPxKcFd44tyW+KRFcyf6bLT71RKxELeAWro3+Yk1Czxw59z5ns1gz/DrhTq30EpeOIjLKohu8OLq/rY0YvI7S/I7tTQ9RgJ+CAjrqPMjYumoc1IczelfjuARYrcwiHFxkZjYdnRudqTV8TQE76VNCtBNrvPYJUjlNfvaECdokGIjf/e0USC6x31pTbQQ8oUIuLjCZC6nWB9wRhC/cOsx0Ga57ZGRLfQSmrOXftR672jo5RlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB8316.eurprd04.prod.outlook.com (2603:10a6:10:246::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Thu, 11 Dec
 2025 08:26:12 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9388.003; Thu, 11 Dec 2025
 08:26:12 +0000
Date: Thu, 11 Dec 2025 16:27:18 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Julien Stephan <jstephan@baylibre.com>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Ye Li <ye.li@nxp.com>, Dragan Simic <dsimic@manjaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, David Lechner <dlechner@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Subject: Re: [PATCH 1/3] power: regulator: common: remove unnecessary debug
 trace
Message-ID: <aTqAZt7v95CTyVo0@shlinux89>
References: <20251210-power-regulator-fix-compilation-v1-0-c58f01e0a5c3@baylibre.com>
 <20251210-power-regulator-fix-compilation-v1-1-c58f01e0a5c3@baylibre.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210-power-regulator-fix-compilation-v1-1-c58f01e0a5c3@baylibre.com>
X-ClientProxiedBy: SGBP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::30)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB9PR04MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: 98222803-81d3-4e62-3519-08de388ef1cb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6mEhHxqLn/eC2sn4P6R5Uhv0hqJzquBSyOiN22m04S/CC4ehiAfNR02V3dfZ?=
 =?us-ascii?Q?jtogSc9hK2GkcJ1JBlkMr29NjExJKyjeX+V9yHuWmxBSWEeTD+BWmFSImapL?=
 =?us-ascii?Q?yjkHtqGtypB054BbIQakxxWo9n9b9bvGhJuGRG1uXJiSqRQGQ/IRzhEII8zw?=
 =?us-ascii?Q?iI+CSVONwD2fyBkrTyTpNGlmcbqMkCFEZSyiZuTXJVcckhZ9Nbw+MdSk8eXF?=
 =?us-ascii?Q?E/9ug7HmiBvZ4pDQ2xqNLEKjPvUFZZwvqPM0+P4lz2g4yyEhFY9TTedcGiwX?=
 =?us-ascii?Q?Y+r0aMvZYzm41tkZ8ej+9kePelO3do8wwo79FLP+2kOcYckitbhn9j+LcKpR?=
 =?us-ascii?Q?g2wOcW+J40/2MFCuc32Z5jzN/zqZ5ptKhpc/3i/UMiM4d5x98tkKuwOSs6ut?=
 =?us-ascii?Q?FEtqXckoMRUT659VqOzaRDjd2mJhi8jgnBX53QYyPJVe8vwnDkAOf9rQxw3B?=
 =?us-ascii?Q?F1JiP5Dg3JPYOzrs7XDP1ILqO6STqZTE0zfkGydQ8lQ2rMiY6zDhzQ+pvBsj?=
 =?us-ascii?Q?I03Yw2g1/Qu34bxUUKU/cB9400bh9BNEIHOrscECFMD/6KkTjKUF5pzA3AA7?=
 =?us-ascii?Q?Ku2USVNC7DYk0RdSs9S3iMvUCPkKz/wqMqVTkS9s1s6TKh0ZpF3Ct6hSNr81?=
 =?us-ascii?Q?+C8mPCaLZc3ZXXnBIYeI3PWM24ZxKN7KORf9Uo6WD+RBnf+ZX/niT5xiCR7g?=
 =?us-ascii?Q?y1Iu5JNII8wSSDB+TT/psaHmD5Ld1xNb2BMVQnZKDYGmTj7nhRBkdd+KUcc5?=
 =?us-ascii?Q?WR729hM4sFz85ko8fKHC5wThCKr/DGPYIzzN/4KnXJg39nzXefv3+tY8JpIE?=
 =?us-ascii?Q?7WNFNWwh2gJzEUz/URg9FxspCiixQOwGuyp9xvawYum75PZV0o9XgmQMqw1A?=
 =?us-ascii?Q?A8Lf68aeML2wljuHjsd0g71Nm3bZiheCLF9SP+4CzHZMP4T3U68wWI7XyqL5?=
 =?us-ascii?Q?cZPZdGMt0jJ9gRBL5VT+Va0p1FnJrHJQ+ubYty8ZGgOIXBM70motVIoFaLhU?=
 =?us-ascii?Q?lm+f/U1Z8mk4Y3cg5NHotzUHE4vrs9cQuYdYOR535jb1YE2FpjI2NaMaaII/?=
 =?us-ascii?Q?JjN8GCjXReYSnvgF06LUwO1K84gZy9Q+NCjZ9jgoguWN6PQ7S1V4+11ykKDB?=
 =?us-ascii?Q?JPPqILQCaUY3RuxNq9kbSt7MTmryr1x2fOPCAGHk4SQlmarGkpy2hPTuCHda?=
 =?us-ascii?Q?xrox06lsHtnyYxjj7okYIofLvDUwZcuZ6f9BfVpQff/JNWmmSrOiHjuC2P8h?=
 =?us-ascii?Q?EGNGVq37PVdSpTJIdJyWRdX1t3+4LA39QO/GAwYAOevOg2U2CUT3HJcI34Ux?=
 =?us-ascii?Q?mawLALctoMCtiXEP3MT+kAgo2oHjTu9rG+OwRTqKLRA5HEmXAFesIrwKQc2m?=
 =?us-ascii?Q?MRreHm0HJr0NrFR4XD5EKZhWQrCBLqI2NDKHfqHLnjYwnfXz6HqvE+6z20zt?=
 =?us-ascii?Q?9KAkfp9cVXo9Af6c4AB8zL53zubYk0Ec2aZElhijnEE1vsQF2Svi9VVoVjAy?=
 =?us-ascii?Q?YFWE5N5/B9pwlBF2zHnGTcRWO+rTgo2Rx6N/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(19092799006)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hSat89etCfDJGeqKsd618dtv1wCxb1s/hwhRV2c9wrtLCqjLm6v5LiFgnyUZ?=
 =?us-ascii?Q?ikd0dTfzPy+jab+Yzlyyr1/0raqcJlESXP9xe2RE4cnZ4hkC6GoTcExY1hSd?=
 =?us-ascii?Q?FqY920JkpTh+TwmUs1k0jZtyGdxR22lklTkFeTUIHhj8+rlUwK/MKpgeHj3i?=
 =?us-ascii?Q?1nw/V6ZZR8rdykK1kolTfbf3VIKX9gC60i7+RpJTmNLUkMO0Ag2sXDre93AD?=
 =?us-ascii?Q?o19DgDx8qcLeJznYVuFo40I7Y6qRI3x2tzwL7cgM/Y5gyLnkVjxENr0VIBVT?=
 =?us-ascii?Q?25U2jsObXwmkNf5HBqAJ5sI200janTo0Rq6473k8sZQR7jwe/ZA6mpdNomm6?=
 =?us-ascii?Q?m0LCLqc4DlgblxESz9NxRZzjfTPQ/iW/zjCwL1fStZjg7q/4hLqEsCaZatJo?=
 =?us-ascii?Q?/LYEmkT82GBQLMfLPn9C/TC/SQYOKNzDf7cupe6TkhpqQ23DpmpdtUMHT8mv?=
 =?us-ascii?Q?C0v2aMf4Pk7ANMyQWTzkYK/u3W934I2XGk8jZRJjpMbFyPTYPtcS1COI4U49?=
 =?us-ascii?Q?ZztMk+s+weRgTABeWu1pZLkPtckXYPHVmsoNv8S2O3IsoANCGeXJC+xYOT+l?=
 =?us-ascii?Q?pVKVwznCJHj7K7Ea4VAfYAEtJb/55oA3Hg8QSQAsiVCpp8iT65FcaDWchDXJ?=
 =?us-ascii?Q?KPYvREKdQ4EDJwKb7TqcILmzAXg9h1Q1cA6GV1zCRRxDKvcGsvbHc8oIWlw/?=
 =?us-ascii?Q?/4JCKfuwO/Gn7yY1FdgtRkc5o2Ql5d9d0Hd6vWGfzClLWXz5ugpoCcV7Rly6?=
 =?us-ascii?Q?SemnmIMzalULDxJfYKnktjb/tnQLJKtP6BZ0P3i3LaRr02DsJgW7l+POlTvu?=
 =?us-ascii?Q?2DujmIE9zvfr68DXty9CZdxqYuCZzYwcmnfR24gfDK83I7yh3s8fLU8mqy8P?=
 =?us-ascii?Q?+csrlBB7UKu4+zO6zEV0Rxlm5wTDGEkLwAJd0SH728+g0e6wF6UoWr3vlT1w?=
 =?us-ascii?Q?D2NDvPSQfFPmuHJdZgtsJvWXn2IHmA+yUgwVoxWwmGtFsJEuVXoh9iYxvNS/?=
 =?us-ascii?Q?XIpndC2kCLfT7enbQUN/62XxFba4E3aU0govs2krBg9cbwi4DZ/zJBHUxjiQ?=
 =?us-ascii?Q?Hbuamka84LjGJ4d4pOb8gUmD7pwO2INsnOEo6kwSgDNsUtEbB/g/ATdSIWrP?=
 =?us-ascii?Q?lPzFPaPZB8MI/yDnnrWbnIupawPN/IKfFcxCFO7lU7UsagWQsEOOLSoGWExR?=
 =?us-ascii?Q?/hsNi4pL1CeJ2P03tdzS73sfsoOPglHaSbcELSXIzgZoWLy0HOXAiTdtCSpr?=
 =?us-ascii?Q?vwma0wEzK4g2WjcecG5JoO8NKebkk7u/r81gehJvzBmmi/gNa6l6znxkiISj?=
 =?us-ascii?Q?mNtrG7pjk+fE7DhLQ2iGKyU9fuVHXrWWQb39Y0ND21LB0ATO6ukQjsYbEmoU?=
 =?us-ascii?Q?4pXtkN5SP9XhKJ3WggGM0g/nnVMhD33GO6MIQN5QfOI0A1lZgXWG6J6AoVdA?=
 =?us-ascii?Q?yVSzIxAY0kbx9Ji4LPduA50cUjziDOEKSmeRBz1HSGqDluSy7XhhOhrXNzP4?=
 =?us-ascii?Q?L2aYBLhg/yXL2ld2e8RYwIWN8472D4kI1ZvBVIHQGKp9L/l1IYd6/lWgAxHG?=
 =?us-ascii?Q?oVL4PtY45MhZeDaqnjRM3PTCcU5kdutQHwqU8nxL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98222803-81d3-4e62-3519-08de388ef1cb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 08:26:12.7745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UTJ0WHXjIrcY/u+TJr8cSFzEiw2IRzrMoPAGcNvlz/DizxhbWqNSc90zh/V37ZIQH9EDdTvggPBp6V/RCrvz6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8316
X-Mailman-Approved-At: Thu, 11 Dec 2025 11:05:15 +0100
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

On Wed, Dec 10, 2025 at 10:24:22PM +0100, Julien Stephan wrote:
>Drop the ftrace like debug() that checkpatch --strict complains about:
>
>  WARNING: Unnecessary ftrace-like logging - prefer using ftrace
>
>Signed-off-by: Julien Stephan <jstephan@baylibre.com>
>---

Reviewed-by: Peng Fan <peng.fan@nxp.com>
