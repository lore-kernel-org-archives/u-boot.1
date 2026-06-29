Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A536EC43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 05:17:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85BFF843B6;
	Mon, 29 Jun 2026 07:17:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="C48hnbgE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84757846A4; Mon, 29 Jun 2026 07:17:53 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78E2E84105
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 07:17:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BB+vq+uoX63rfBa7wq3t3p2F7sVLeJu9uunlfHjBEAEQxC2yVQwh47qCul+WDmzc3LDenOYOKJybmE4H3yW6gTvC9N+9le/lCM6/EOMZrk4ASar7qEedj7fv7GOWo8freDZ0ezlwW/mzlMKgweefO/Oh1R1gtfmMQs1gWGQgASwZ+XLZP/uRv3/9DpQ4X3MuBzeh+FVCmSicXJkLBsTep+okIlpmRkDxCSbjtVkM2PN6d2QwRKCVPXula7nv9B3uQCuBsUIgZkJtbRLu2uATXjEReUAW28LtcxJhfVynGICKMskHwK0JOYibOJP/TCB2WOZdysUXm0TzdCtO1qTjLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6sZPwZLMOpM0MNP/2/Og39kzuNbe9Z7Jp/DKeKN8UQ=;
 b=qhS7qdfWY8BxAJnScBfLsX9URYOHY2zONKEcyndpbcqvdOC3Ia5o4ZOiTYipq6ZMdgnbRWo1U1WLveyN0yXy1Q3KrIS5bISZrPO11oMb9bGGrLowOd8C0F1Z+s2FTElwz3GFgocwRayd9jAY7xXbC9q7jncHsw390gOVpYgRKwBlEzJjXgKl0FWkrJkIcMrKumTWs3FDBh9xgSoAYWhItHpoD6tjcqRgfXy511J1M8PxHCkFYB1mGePzi5QvMG7fD/n7C3p9VzpDwymQ4kt5/NTrYB1QNOcQIoxsn52Ww4pDhIXEEMJvz5g6ARTXYDTBBW+jmjd0Z9k2YEnNGn8yQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6sZPwZLMOpM0MNP/2/Og39kzuNbe9Z7Jp/DKeKN8UQ=;
 b=C48hnbgEeqD6yvCc/vQlvuK+H3F1TFtLroAVidIstJ5i1RZKyqbzFkmnEU+ZL+lNt2IySzid+syWm83Gij308wjJYlAQoSBcfsiVeG5YWJsqa/P48db1rhq0MP1pFjiF7Z+S05QTP5Y0dPvE2DrK7GoVfu0aHe6SUX/2w6DgoIr0Ok5IcusSl8zQHJ5IBEKTbCWHnkO3Vp5TOgmN3AYqAPlyQ2eMdL3mJXFCk/mbV3js9Jct37OXMiyJjZ3vSlZwKDIeZxlY73ukd4ThfieVUvQ2fbIqHQ4xyiBRxgsawUgroDZWwMQJhgJlAR554wsn4tjjHnwGwkHVISmSuEggQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AS8PR04MB8466.eurprd04.prod.outlook.com (2603:10a6:20b:349::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Mon, 29 Jun
 2026 05:17:49 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Mon, 29 Jun 2026
 05:17:49 +0000
Date: Mon, 29 Jun 2026 13:21:11 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/4] power: regulator: Add helper to set voltage within
 an acceptable range
Message-ID: <akIAx9umMKvjMTgs@shlinux89>
References: <20260628102527.1247889-1-jonas@kwiboo.se>
 <20260628102527.1247889-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628102527.1247889-2-jonas@kwiboo.se>
X-ClientProxiedBy: MA0PR01CA0090.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::19) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AS8PR04MB8466:EE_
X-MS-Office365-Filtering-Correlation-Id: 359c53aa-0bd8-4b95-9ba9-08ded59dc310
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|23010399003|1800799024|376014|18002099003|22082099003|3023799007|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: EL+8hsg7N3HbSuOOJjYhB7Fry5P+ghnVHY62bxVbVup0yJldfqHVoS3iS+pp9q9NP7l0TVF7PfCtxQ/BVUNE/SJSZ1fDgHm98rrmFkCbNHpA1VjCnO6KYFJ0/s4y9dLlddBn7UAgHQTx2Lx2DyOfw9xRZNQ/JNtLoXbRffn+Sei2QyV2XSLcYs1XOEsTJD148BGXT1CI+UZgwu8+tULhfzXTvBlFVyyGzglXfcWOdmsudtIN2L4qX+ks2fS0/QLT8NSG2Xr3FWptEIr4nAqCA8KkL221DeyWqKh62whASPPV183AGhXgHvFRuapJRcOjtBu3upKd9ndzMPj1CC3gxEbHsjpmV34k2GF5gKojJ1DLM31otFFi+fXyLMveptWODSGyhYpi04ChbplcYrq2DnQazRD4CqnG4B1UbjwsNvJGfT860nkpaEJJTQ4jKGBtFTKX7BHLdA2tyBs1lDZEuFH+5I+WPzkgTJGoH6ieY/FMRqBYjncndbzFjJUyIiKAr2QKz8EBU7kmZBwruKUcBwb5DIoZZnvXrDsi3huXrpawlZj7RuDgnX+zqU2VnVcZjUbH2Rr3bYGhbcZGptfdaaYANAQnFW6a3XjZ6ybvjtFbrYIjzzEiPOf05noYfvL5C4A9HQwJ84WGg3IznC7V3XoJx8cyi/xK5b+1yHssirc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(3023799007)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TA6+aEZfyIqgnF2OaeB2Sij5ayjaj1GxLCMk1yEIPWte/V0ZoKtgjLvQuDRP?=
 =?us-ascii?Q?9aVRh3PogRtNs0OYRE4GrY7HBXh2fyjEaRDAo+heFEd583Y1FtLKoWLHSYXn?=
 =?us-ascii?Q?973fMjcVKIqbfqPpJOTX5ZzJN88KQAiV1lKVmqwxGA9ET8+xAUGnabae07wt?=
 =?us-ascii?Q?HRkUgyorJ7XKXrLxG663+N/H7swxvpiSMTVJFtaQTteCrzJHJZ8qIsM6HHar?=
 =?us-ascii?Q?F3bVXOI33I1tZvw69lQBCyD8QqVCXWVzU34K1gb7WivP+u14w4Pn1hmGkhsg?=
 =?us-ascii?Q?oTh/E3m2LlSVamyPWgyk9jVQ2Y0p7Jfd8czHJ8KLHCn6Kz9EobV6nsjybqPQ?=
 =?us-ascii?Q?tVQxgnQkbV9kArJCnEyFb/GjlUNXyj3hfN9l5yEORB1+vNn3MXt8PvPdVBgl?=
 =?us-ascii?Q?rjjxeTq66fCX441J7dlM0osJkr9gXKTlX/Tp5m6UVT3pnRRW1b2x3VeCSSgU?=
 =?us-ascii?Q?qOEsMhjjDcWz4+jlODEFha+ezHD9d1D59XvYbAparep4vfj4mkbn+aX/4dxo?=
 =?us-ascii?Q?GJdyi+RCsL33dzYFEsRSOrC/xgjqVPxoOoo5htV8xovokC/dqxCsgIR1qEuo?=
 =?us-ascii?Q?0LCUtWdianq3MrZlKcHyi55x7sLmNp3bIDNTl4D/KVEA1ZzH/6udp8mCPh+8?=
 =?us-ascii?Q?VsNWibY2N3eRI/K50YsRuHy0+yKZDgt3MCgUWoybH/LrdvaBMpu2XYMm0lv0?=
 =?us-ascii?Q?a5c8UguZ5AJuh9Lde0LYSjlfadz2JJV4BIZAajuvaQd0yuuPGcQEFVPK4087?=
 =?us-ascii?Q?sw5gyIlvlzFeSGHhXi6YnF6p65Vu7D38j6rYZwpiwGGKynUCJwi8GuloQFWD?=
 =?us-ascii?Q?XpAYWUBwPAQ84gm2jXk+5q/Ejkj+GcWDSumYxZRhPBXWAeTVEMeSkLS/NL7D?=
 =?us-ascii?Q?NA+O3eajemrx1WtPnRAqEYagMh6yYz+yS+hkfYuvBf1++IO12p2yi/t7re21?=
 =?us-ascii?Q?RD8vOwpF4ZS5RLz10zU8IAGNTwh7RSVe6omYNEB5jjh29IhnfszEj9Q/FZPd?=
 =?us-ascii?Q?pgXQ3aUjB/HXafki1o1IJGThDC13NVjz3g3MKr/LAH1NvUqEyBFlnMYIhh9K?=
 =?us-ascii?Q?OIVdHHofd0FExnWHFioJRlv6ZvvfpCDmAdhHjISYWF755wS/YcQaKY2JJ4SH?=
 =?us-ascii?Q?8o1+x2YI/D2xwIWp4wCESHYjlQ24ZT7TBRLeihs6cCgQ6WsH9xXtrUQVyd5K?=
 =?us-ascii?Q?reAefksXN4SR9q3/7pCshbf/m2fUTjqSbiP/H3nwSEPAu5HnBFV+BuZY4AXc?=
 =?us-ascii?Q?gNhZm+MtMCjdAy6SShDSZDwueQ1IKT+bWQLUS/a709eS1W7lkrhKOfTodrrO?=
 =?us-ascii?Q?ICCUR1MaaCw2ZRS9L0HbqsYF9T4hIVDDtEj/iysPSv0UUDmhnsMRN/xaM8Wt?=
 =?us-ascii?Q?0d/YikVxH8IWtXl81dW86aeZYK3qYYJOWfcSpau6WjlBugpLI70VUScWOfFk?=
 =?us-ascii?Q?KnZLv63EPeGRwfdVsr0lYK6LO/wCYlGta36q06Bn+Rk9iqNh4knSDejsUSxf?=
 =?us-ascii?Q?wx16HnBKjrx5Lsup6SwJTPa5kvLgf28kMLsdzbBJmuYbKB2lfQUbTOJPyA58?=
 =?us-ascii?Q?NTPYLSvdcPsBBa+FndDMpjGJ/7if0J+cb0qje4cfcXkwuixG7VeVYuJSVcv1?=
 =?us-ascii?Q?TDIDEbVLGVr7rk5hoQOAOmXCtGPTZxZH+DEqjt24BnMnTl6lcmoXKmjIMMiB?=
 =?us-ascii?Q?FFH3NvBPcP+0SzlKp0NquonVhtGpPEi82fFuIsRsGX2uujW18+jAmgw40kgz?=
 =?us-ascii?Q?/wGfoDprjdwwfDXx8YIHSsJDvLz6rgrEpSmd+K3xfMwvujZlz124?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 359c53aa-0bd8-4b95-9ba9-08ded59dc310
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 05:17:49.4541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TzqpEuNqr0XKWueXy9BXA3fdKMmfr18ifwCql3Uv3g5ba5QPjJZxt6N9AsW4biWPElOGLK120oihHerKSeUE95fHujdTghR3bWIrmywb0C7nGXjz+RpofIb/LQ223ACj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8466
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

On Sun, Jun 28, 2026 at 10:25:23AM +0000, Jonas Karlman wrote:
>Add regulator_set_value_clamp() that clamps a requested target voltage
>to both caller-provided limits and the regulator constraints before
>setting the regulator voltage value.
>
>Return -EINVAL when the caller limits cannot be satisfied by the
>regulator constraints or when the requested range is invalid.
>
>This helper will initially be used to set vqmmc-supply voltage within an
>acceptable range according to SD Standards, i.e. 1.70V-1.95V and
>2.7V-3.6V.
>
>Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>---
> drivers/power/regulator/regulator-uclass.c | 27 ++++++++++++++++++++++
> include/power/regulator.h                  | 12 ++++++++++
> 2 files changed, 39 insertions(+)
>
>diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
>index 1c7f75a9338c..0f5ba51ad6c2 100644
>--- a/drivers/power/regulator/regulator-uclass.c
>+++ b/drivers/power/regulator/regulator-uclass.c
>@@ -111,6 +111,33 @@ int regulator_get_suspend_value(struct udevice *dev)
> 	return ops->get_suspend_value(dev);
> }
> 
>+int regulator_set_value_clamp(struct udevice *dev,
>+			      int min_uV, int target_uV, int max_uV)
>+{
>+	const struct dm_regulator_ops *ops = dev_get_driver_ops(dev);
>+	struct dm_regulator_uclass_plat *uc_pdata;
>+	int uV;
>+
>+	if (!ops || !ops->set_value)
>+		return -ENOSYS;
>+
>+	uc_pdata = dev_get_uclass_plat(dev);
>+	if (uc_pdata->min_uV != -ENODATA && max_uV < uc_pdata->min_uV)
>+		return -EINVAL;
>+	if (uc_pdata->max_uV != -ENODATA && min_uV > uc_pdata->max_uV)
>+		return -EINVAL;
>+	if (min_uV > max_uV)
>+		return -EINVAL;
>+
>+	if (uc_pdata->min_uV != -ENODATA)
>+		min_uV = max(min_uV, uc_pdata->min_uV);
>+	if (uc_pdata->max_uV != -ENODATA)
>+		max_uV = min(max_uV, uc_pdata->max_uV);
>+	uV = clamp(target_uV, min_uV, max_uV);
>+
>+	return regulator_set_value(dev, uV);
>+}
>+
> /*
>  * To be called with at most caution as there is no check
>  * before setting the actual voltage value.
>diff --git a/include/power/regulator.h b/include/power/regulator.h
>index 4011fb1d254b..a48bb3a5a1db 100644
>--- a/include/power/regulator.h
>+++ b/include/power/regulator.h
>@@ -315,6 +315,18 @@ int regulator_set_suspend_value(struct udevice *dev, int uV);
>  */
> int regulator_get_suspend_value(struct udevice *dev);
> 
>+/**
>+ * regulator_set_value_clamp: set clamped microvoltage value of a given regulator
>+ *
>+ * @dev       - pointer to the regulator device
>+ * @min_uV    - the minimum output value to set [micro Volts]
>+ * @target_uV - the target output value to set [micro Volts]
>+ * @max_uV    - the maximum output value to set [micro Volts]
>+ * Return:    - 0 on success or -errno val if fails
>+ */
>+int regulator_set_value_clamp(struct udevice *dev,
>+			      int min_uV, int target_uV, int max_uV);

A static inline stub in regulator.h #else block is required.

Thanks,
Peng
