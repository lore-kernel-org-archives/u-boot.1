Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9DBD41C14
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 10:08:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C19583D3D;
	Thu, 11 Dec 2025 11:05:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HZ/uj+MF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 949FA83C9F; Thu, 11 Dec 2025 09:32:24 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC75D83C7B
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 09:32:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=neS6TDkU2pUY2Nz5KnQ+alwiFhMU+QRvXfQidYScXuHj3hUrQtlzXwfu1IZHKGBc4uGfzI6KTZbJpjq27iJ2Am2VVCRf6089DIzIPNYQBCkESkOcVpfLBZwKvytfG90NmdWxezLWEecIgdMA/ew3IAyTtmQp7Cwtxesdpl4Tk53nc6uHJ9vFPILRJZ/YkYzJrg7l8DNoHplkSW85sMyh1x2K0luFTFycuTWSmBd/+ngZxuV5h1TPgXDH3gJokiwKmpfbLoEpVRuRiqd/69Be1OyKE8wdgoS4CYLo/q42bah2MQat/UhCQZRLdQXkjejfMSEMY3yDt1wV2cyVym7AZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HW9B6dg4jd0wJq+EzKx/VnBTRAkX53Wi2G5tTszaCSU=;
 b=MEShv/fnT89QDDfPhcqOvufIL0uSiziAphDzmhtD7TJ/Qy12KQRhXvLe7oCZ3UR4uBu8G6riAi6LP04gI751XJp98ebybMLFEqJBxNs235JkvhAEpLMhE2QpqP9TLY3eMeHRNm08EADnGyXXVAIV2pOoF6AqIPjEVwJuKIZr/PHz0qDOYL5Q1+93DgIFUFqtayeM0aKBPnT64EdNpM6bmBpv0YqYpWqDPrbhCN6EY58FyFEotDnVzZgFyPdeNJdAgEaqDoUg7KjXqX4OVO6jYbgHBn8s3UDhdYYsTok1d5CrE36jvp8mghGUVQP2HR46CgNlubr4EN1awuV/ntMtEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HW9B6dg4jd0wJq+EzKx/VnBTRAkX53Wi2G5tTszaCSU=;
 b=HZ/uj+MFqQcNpY6zSK7qMOMvZNCLGN8QgiBVixzpw2Pq5MaiyRzi2e/RflcPlblwuCVa1iefDvvEzxIeiSd5rdtahY4nRfzo8FAJCaoC+XD+/0OI0z/WRa+z2qDG134ZsW9WklmMvxDtpKgB6gf75s3dWSG1UWkQRGn49yNL5n4h/0yZiqK7ypC2lZEIRVjHiooNgSsBCka++0NXaQvt6BEDGleTmJL8N+9b8r2P/0IU47EbLoGs3Bk+3+Ye5ahvSWHgv07VkdilT2OmUjT3pZhwQL7+M1VlgEtvB+RX0ulkDxEDWSzLMgi7dSh5fn1cW8lxq6d/vJB7yqf3iPhidA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8797.eurprd04.prod.outlook.com (2603:10a6:102:20c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Thu, 11 Dec
 2025 08:32:20 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9388.003; Thu, 11 Dec 2025
 08:32:20 +0000
Date: Thu, 11 Dec 2025 16:33:31 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Julien Stephan <jstephan@baylibre.com>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Ye Li <ye.li@nxp.com>, Dragan Simic <dsimic@manjaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, David Lechner <dlechner@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Subject: Re: [PATCH 3/3] power: regulator: common: fix compilation issue
Message-ID: <aTqB2w9VSK/V7wbd@shlinux89>
References: <20251210-power-regulator-fix-compilation-v1-0-c58f01e0a5c3@baylibre.com>
 <20251210-power-regulator-fix-compilation-v1-3-c58f01e0a5c3@baylibre.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210-power-regulator-fix-compilation-v1-3-c58f01e0a5c3@baylibre.com>
X-ClientProxiedBy: SI2PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::13) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8797:EE_
X-MS-Office365-Filtering-Correlation-Id: 1db6c8e0-1770-40ad-583c-08de388fccbc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|366016|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JmsMgSnxa0JFPNI/QMh4mxpkccf0zwtiqbNegpl6vTu7lm8f/iDO+KfT/iRd?=
 =?us-ascii?Q?c2+kBeEwSkbXcDaPCVY6HLsDUFgqzhsN+j3U0ebwt4SJ2Thz3wnhnX0gVOA+?=
 =?us-ascii?Q?Ldt/KBNKGnucMJGY5ItOCL8l5K0PfTHOgx9wQH9R3E8bAkwoIqHJwtFc4tAb?=
 =?us-ascii?Q?PGxAvrfwOqOjjdpazu5Z/V7jGnI4taPUCEHOvggJSD4CwTryh8M4EJ/R53Eh?=
 =?us-ascii?Q?ZZnEXQauccip3+6D3YHRD+hehBhKzk8gXfaOpyhidxWzC6UTX6dhNXvF0xRH?=
 =?us-ascii?Q?cYYe6xIvRv0iPjTM/ImXik7pj2KHlBy+aOLr556CA0SsTgudVWu36SaYuDlm?=
 =?us-ascii?Q?nxD19El3s/6FVEoZffIXEG7CT2ukUEHK2yvYcLQaxW4rZRdqGm6tgh8JgcwK?=
 =?us-ascii?Q?ycGLPxxOL2ezvaqqU/Jc3nWJpBFLZM071UFKg2PJfsXfUx3vqSdRKxHZSAuX?=
 =?us-ascii?Q?MtafiuOnj/rFjdsOEbX8ZXeh1cdjomi+UwAX3v4lX76i3fkJWr7ykV0zTk4Y?=
 =?us-ascii?Q?Txs/FZrOF6ucj9yzyQI/gZiEX7hCKuQxaDAFzhJOe9JNC/kZya1CLuSpGxm1?=
 =?us-ascii?Q?PcnkTNazDD2b5tkm5730CNF4pSr7vQb/SbtHt1EJWiUPlVMdQFNUNutP+hq1?=
 =?us-ascii?Q?aZjJfrI437vZSFBuSJ+rT3wRHXaX7px76TXC1hOBDmg1UdK6B2a73cdvcsy0?=
 =?us-ascii?Q?ASwAav0pAMwpARUW7+OXDunLQZf83hVWsx8dujvwwICgR4ouWoav0lK+ULnY?=
 =?us-ascii?Q?xDAUBGT3wyXuDlSxqvBhmN7OSzpV95fDgT98998DEHx7LXZ1Z7uW8q9n/MvZ?=
 =?us-ascii?Q?sjc4OTUE1IFpyjpkajpZ1vnEgoWuxh13wJtIa9tIXdllnWsTT0/gonqOafXZ?=
 =?us-ascii?Q?FMv4WE/7f/8JZYDXVcleFbc4hZe5EG+vLt76PhZHGJWSgnnBY796yUBDL8cI?=
 =?us-ascii?Q?qVPCIlnzFH4gYheLZS3Kexo7B7cKDMDyNxeZM0f6ouILK4qPV8J6wnXWNawZ?=
 =?us-ascii?Q?2VoL7aNaYz0b8IvTu2y9fCZQZbldC0tF0bjcSSMX732BMIdszTGS8QhX8YOL?=
 =?us-ascii?Q?36zVewXjH86PNV5dcIGFp7HK2+/Nc1TESa2aB2C+y1bhSyRDa8CMhAY+fXNH?=
 =?us-ascii?Q?ggX2k38zyA1OhBpd8H9jveePRwfgOQb5ui23C9g/h1dAiGow/pDYRshSKVSy?=
 =?us-ascii?Q?UogAd5Oz+M4EssEGCb7qpfigBGnZiLDoeVznCzZKTKQ36XGTNyvCxsKdRzQq?=
 =?us-ascii?Q?esDOYXX+DWc9tZEKzgz1ulR/ahiGWSgr+6cmmIPbXb7tYhfuXHT+RQphx6VJ?=
 =?us-ascii?Q?ZIUWuNhSdyktd7gZfC9ebZCQVA+W2nh3fwk39x0T5zv4kORGJHU3FNe9s15K?=
 =?us-ascii?Q?ILdf1/6ZH0eBjUZebGsGwiQTJPiFhEv3zLSnlJ9Qaje8/WCF43XBAPF9+tho?=
 =?us-ascii?Q?+Xpx4VqHQP3eVxRO9SjVWnFUraT8c+ozMuqxx6kGDR7825zfsanpXLPGA3/M?=
 =?us-ascii?Q?JMn4xFtxXJ70O3zfSWmwJxhntCvVOV1ShWW3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(366016)(19092799006)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P7jFrwVrKp2XlGfd9ELrWsaxQgY5rcdbQwlWjgrgdbCXC5zd60k96mmlRVss?=
 =?us-ascii?Q?9GSDu7Qqjniy9z1hsfwgipXXh2D2q8Jh53CF02ftcKwvAHd33mA61068xWGD?=
 =?us-ascii?Q?AIjuW17arKwWRPbUAKjKj2mnZBfLPidZAtMd7oSHnur0m5gJQdqsWcaHq9xa?=
 =?us-ascii?Q?pxBVJFWUqi7GiaFdx2ftGnbYndnzVPST5XH7awIhHgrQbz4MsFfZcy1niUJ2?=
 =?us-ascii?Q?QD+Ny7umytIoyUS87RUlt+EIi8htJgZwhyvPyXtKBm92TwsWPLuhvk02Zrr6?=
 =?us-ascii?Q?ATAE0+hF70RZOz0i9EoaR47y1+z5CuH+yHcrtjrXMZhUlnwll0CVudZmUmyD?=
 =?us-ascii?Q?z8Fxxf9WCgC7roTAbFFwWvQ4xr1IN4OZx+ScG0NpZ43MTLL7J3fa0AztGbvU?=
 =?us-ascii?Q?zoAaqrtxNQ8qMBB2UevK4ZiaTtyYS0nBySrBXz2plfiaQYySG47D+YxpFdH7?=
 =?us-ascii?Q?3kkHJYEZzGh8y/Eh0CM5gAVcnyk94Tfz7icPecjFnmBOHX7UKFb1jmSVanK2?=
 =?us-ascii?Q?HSDo0h0t2FiroJZyPXGtfymA1wOCWcLaeVrw5QORmyhsqCNI8M06Xv1wh1vw?=
 =?us-ascii?Q?62QoRo3NQcVFfWA/OMqeKKlkcPPXoLtnRMzSp8p1qP+AE1bxMU1S2WCGztim?=
 =?us-ascii?Q?sx8l2NSJImILZRsgCdAET1oMgEMSwdMt0+OIEp6mqtaYRTgsgdbQ8qoQugw7?=
 =?us-ascii?Q?emIH+MHKm4Bp6PjyrkoKqrz0JdFfZ9A+SpQbk0vXhWLYYhc44lGHzW6kE/gE?=
 =?us-ascii?Q?Xa5tC84V43rFoXCe7CgJa0zY5ZW1oSjlCXeyPIii5U230k1rm7LnibLdqv/D?=
 =?us-ascii?Q?tjG0XFSianQuPQid4ivLW60mUTbH/o+RB6Oe9c1qP6ytNSj+3h/qc1RAEED6?=
 =?us-ascii?Q?ZiWN8opWizc2yb83LaiweXdfCsO8PDB9gLMz6ltN7y3gNeHEi7Hpkwmds04n?=
 =?us-ascii?Q?uPGxBCoSspcQoMWwQlNJAQ7msCKVpD3mNr/DA4HFKL7BndzzuodLDzJArWjB?=
 =?us-ascii?Q?0zTfrd8VMH8XdcgQPHYMxy8TZPjir+aYYqdvgqr6h5V9606f/HcJhWeF0tfx?=
 =?us-ascii?Q?ly1vALfBrD0J6HXRdasFGuz7osSr3jiZ2ULjhKZOdVEniyos3Np2phTNRFD5?=
 =?us-ascii?Q?4KzGd+DYMlhSdo8lrr4V2KITrbzI0oQktmvhi9hHoDVVhFrSiunWxCe9RZ1A?=
 =?us-ascii?Q?qtmRLs9MuwU998303onJcNIO/xPY6SP0qyMBhQF4/7gk3OUDgm6hy2tIypnW?=
 =?us-ascii?Q?bikAm6KiAFjxCEFnQHSnVk8HR3S2L8z5JbU/BZC5spbt3iQP8BjBhr1w1RZa?=
 =?us-ascii?Q?ym9uCcr79Jt/leuuL17NSfox7UjpYg7aPi2RWsIAY7c7FgvMyMrmXyBcyU9P?=
 =?us-ascii?Q?C6Q8hV3y+IPwOsYDhJgEQbD7pzkdllw+g5R98DIq7+Xpg95P2vYbp+C1rZ0/?=
 =?us-ascii?Q?vuxWEl2AUejd/lbxTLI6Nhq7rtj8OuVRIZa2ztbYCCQc0tLFIMQ8JkgTpRPU?=
 =?us-ascii?Q?YJ2YgiXMf3gGRqJhgs+ZCTqamd/JIKGNBkBPIvo0SnWB6Z+gJ9hto2w1nYy7?=
 =?us-ascii?Q?ZzJvkM73wrLjZObKpH+ajA5ogCL2W6qswEawEMU9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db6c8e0-1770-40ad-583c-08de388fccbc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 08:32:20.2023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZAdEPAP4vcFs5S0iRdj2LK9ZE5GfYro/M3VxNeYC4LygYG86v54pmC4+bgPEXskf9lGM9pGGbSauGoJD8k3kWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8797
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

On Wed, Dec 10, 2025 at 10:24:24PM +0100, Julien Stephan wrote:
>If CONFIG_DM_GPIO is not enabled, compilation fails with the following
>errors:
>
>aarch64-none-linux-gnu-ld: drivers/power/regulator/regulator_common.o: in function `regulator_common_of_to_plat':
><...>/u-boot/drivers/power/regulator/regulator_common.c:30: undefined reference to `gpio_request_by_name'
>aarch64-none-linux-gnu-ld: drivers/power/regulator/regulator_common.o: in function `regulator_common_get_enable':
><...>/u-boot/drivers/power/regulator/regulator_common.c:57: undefined reference to `dm_gpio_get_value'
>aarch64-none-linux-gnu-ld: drivers/power/regulator/regulator_common.o: in function `regulator_common_set_enable':
><...>/u-boot/drivers/power/regulator/regulator_common.c:92: undefined reference to `dm_gpio_set_value'
>make: *** [Makefile:2029: u-boot] Error 139
>
>Since the enable gpio is optional we can conditionally skip these calls.
>
>Signed-off-by: Julien Stephan <jstephan@baylibre.com>
>---
> drivers/power/regulator/regulator_common.c | 88 +++++++++++++++---------------
> 1 file changed, 45 insertions(+), 43 deletions(-)
>
>diff --git a/drivers/power/regulator/regulator_common.c b/drivers/power/regulator/regulator_common.c
>index cf98998579aa8a3cb7f09dccd2124207a58d8b00..fcf19253e048995fdcd952a48a6976cf86991ca8 100644
>--- a/drivers/power/regulator/regulator_common.c
>+++ b/drivers/power/regulator/regulator_common.c
>@@ -27,12 +27,14 @@ int regulator_common_of_to_plat(struct udevice *dev,
> 
> 	/* Get optional enable GPIO desc */
> 	gpio = &plat->gpio;
>-	ret = gpio_request_by_name(dev, enable_gpio_name, 0, gpio, flags);
>-	if (ret) {
>-		debug("Regulator '%s' optional enable GPIO - not found! Error: %d\n",
>-		      dev->name, ret);
>-		if (ret != -ENOENT)
>-			return ret;
>+	if (IS_ENABLED(CONFIG_DM_GPIO)) {

This should be CONFIG_IS_ENABLED(DM_GPIO)

>-	if (!dm_gpio_is_valid(&plat->gpio))
>-		return true;
>+	if (IS_ENABLED(CONFIG_DM_GPIO) && dm_gpio_is_valid(&plat->gpio))

Ditto.

>+		return dm_gpio_get_value(&plat->gpio);
> 
>-	return dm_gpio_get_value(&plat->gpio);
>+	return true;
> }
> 
> int regulator_common_set_enable(const struct udevice *dev,
>@@ -65,47 +67,47 @@ int regulator_common_set_enable(const struct udevice *dev,
> 	debug("%s: dev='%s', enable=%d, delay=%d, has_gpio=%d\n", __func__,
> 	      dev->name, enable, plat->startup_delay_us,
> 	      dm_gpio_is_valid(&plat->gpio));
>+
> 	/* Enable GPIO is optional */
>-	if (!dm_gpio_is_valid(&plat->gpio)) {
>-		if (!enable)
>-			return -ENOSYS;
>-		return 0;
>-	}
>+	if (IS_ENABLED(CONFIG_DM_GPIO) && dm_gpio_is_valid(&plat->gpio)) {

Ditto.

Regards
Peng
