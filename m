Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC132C54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 07:09:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A1B382B2F;
	Mon, 26 May 2025 09:09:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="klXNRUsB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4378982CA2; Mon, 26 May 2025 09:09:06 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::605])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6366782B26
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 09:09:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xc+nMMeAkmQJJMTKJQZTg6z2ak/f9RF2K1NBTtAKxwX0waGLmMbChmWl07VxvAFi+Fnef8cLUZjBRPM5VrRKT0PDnS4/USMNlnUMoorVW+ADDcM5fVXvdu9M76U0+cKTPZszw+IEspM8YAXl3oKcOO7gw1Wb1lhVgcg8TshX4seKIkcYo4Sx4vIy95SB68uqc+BQ2mCYK7ofVa6JkKUsP6KlmvSR6DID+UG0OaCrte2r7Hw5s4sQV8CySnzATKjvymEpm94ib+4vQdiQBYW2HLN40jFDiErX9sXwqG6Psy1J8gQPXwy5ysA4pNt5MrCqHe9t6TyeclJReEatyAEonw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWUuJgZ+eKE0TpJ39A3qmipWTavsousde1OOCJ63hFg=;
 b=vT3EPVez2Bdv7NdqRGl1gU5RRE9hKHgRzyEadkrrQ8S+XtEifQSbr2KICuXBz02eo8l/sUEgFmjMLw3fBEMHd1nSe/RnHKFFLZ7qbP0xn2TBC01HPkS+3k+IOgYDrkYwm8LbnqCs9WNBgbXdRM08V6Nkhd/Rjbs1dcP2QoCH8GX5RB6xzOJWTh1GMpcrFetSo1WgOdzvuDYlkG4vWSDvM5gDS5WsZ6HTjAAjd3+STZWCwfQ8nm6F6ol0RNGcUrDGLK/RdHGk28PSJaYSXRk57qi+N1wKdUApSaE3GHSM58pBBfyGkZs10XUYSV3glp2AJcx7kvoOzTdELQG9MTqi5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWUuJgZ+eKE0TpJ39A3qmipWTavsousde1OOCJ63hFg=;
 b=klXNRUsBwMAtaewqIiAzp7Pr60VA9R11Vkde0sEE+rEDSdyArsNzf1FvYHp3qOjiAF2xCBi3o88efBV9weTUytm56ZIYXPKCj9j6x8MeE0guAoNqa2na39oboMl9oC1RN4a+GPzSJisahJpQuVg1jllUluZdkju0ScWovJSpL48PL1842Zl2PakjJsXZ+uRfAJsi94bpP7XBOasLAS0Ia0a5DyXzE+9sM5+ZfjpL4CSV2aAukdivmWRjCdTQcNjvFoHL/7Hxp2uVv4J07dtSHn4ZHef0LFJXvtHJ0dGLelgh+vintNuWkVn4WHRgRL8EzkItrcJeWuGEsY4qjYngoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9934.eurprd04.prod.outlook.com (2603:10a6:102:380::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.23; Mon, 26 May
 2025 07:09:02 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 07:09:02 +0000
Date: Mon, 26 May 2025 16:18:48 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
Subject: Re: [PATCH 11/13] board: venice: update model representation for
 venice-flex
Message-ID: <20250526081848.GE19264@nxa18884-linux>
References: <20250523172018.4164647-1-tharvey@gateworks.com>
 <20250523172018.4164647-11-tharvey@gateworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523172018.4164647-11-tharvey@gateworks.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SGXP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::32)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9934:EE_
X-MS-Office365-Filtering-Correlation-Id: edca65c3-8166-4771-ace9-08dd9c2431d1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p9n4tQeREncrrzPaO5zgp8iJ8kwB3LJGLhIE2owMpion8tOGGilrJT7VYNR2?=
 =?us-ascii?Q?pNP3E6FseTj5SLCvT0BLeI4nE67mRkFscuFh2qDVL4mWFcvaQbNXwolZcg8y?=
 =?us-ascii?Q?w70VJNnvOsyd8IIVrU7SGebl4PmAwG9NgKk02OIIeKlvCy9MffHZ0ekopFXz?=
 =?us-ascii?Q?QR+xoHtCPbEAz8JtisRcFCOQRV9G13zyncktVTdrr9iS+tu9gGG/3/qXPrNe?=
 =?us-ascii?Q?DA3TKq/eZ/ZwisKs7+4T8enGtVn9ShsN7BImLqyGyk9Op2IDGnJG1dtwPW6P?=
 =?us-ascii?Q?qM+PLESSZd4zLIAmJ8S1d3OGi63WHtyyHstXLSc3A3N7EV5lI0YIRo5FEtOr?=
 =?us-ascii?Q?BIRbHvG/B6nixvl02PY8RpVkfbmq9VuQIWhnCDUBJV+/82Iv7A4YsXc3oq0Q?=
 =?us-ascii?Q?H/TvkGnnUP/d9sQw6Al1cukZwl+VLNyCYKmHMZZNPHWBlM6rEO0F8ORmI9Em?=
 =?us-ascii?Q?B+/GM88iadM0o7tQMGUQstiLMmgz794z2aT4hG3RlgZ7jYPPl6v3QlYduBbg?=
 =?us-ascii?Q?iMva+BlHYgsvfCr2AnmI6ts6WJ1jHu0txsacJ6Wj21Gz+dg1ZPxDHKqkINZK?=
 =?us-ascii?Q?v2ctyYLprTdWNgT5sUxulsSnbzLxaWf7ozdupVuQ/tkRjbxf+BZiCks2ZAVF?=
 =?us-ascii?Q?HQZcOIcSsMsdnWgjrhgSOR50h9z9pUc5G8zvCo18gsbwOGIT4aRJcQdiMoBS?=
 =?us-ascii?Q?ck6In9H4tE1gwxs+Hip16Pr3Ui34lFcKWnRp0apqKKwsTjQ2xyOH7w7vIwBf?=
 =?us-ascii?Q?7ARzESdpE2azv89il4q4H0B4SZqc6CH6Z/v8jAsBSU91jp9RFxzi9npY7OM4?=
 =?us-ascii?Q?LbA2ZPor+0wtpxEBakWIUU8xaD+UV9tB9FqEh20qtK/eN+CexcSU49rZMKxE?=
 =?us-ascii?Q?8I2/9o3+2x6CnuzhpVD758acdtNUm1a8S4Qm22/VurKSBrxCzwhNe9LKjI/u?=
 =?us-ascii?Q?bfFWtJNDREWOP2Alqcc+KCy27/qPkfIv1i2s3qef3Hq2f2X8UtRTNJ8l3FOR?=
 =?us-ascii?Q?O3tgdb7yvjXC6WPH0wXNPAi4Wcy57FuU76RyJNVqx1uBBvgORVkyO0PiSx39?=
 =?us-ascii?Q?IrrctmXeDoYbZCOKRRZIWcb75OJuENM61kfJo94qRHe+um71IzPTvqQhuXb3?=
 =?us-ascii?Q?nZIDAVXIgKaVi1tSKU8vMrDGNerUOWKukJb8HbcrLySZGJi/STDAC4gUvTnN?=
 =?us-ascii?Q?OLai28sqjfmTjXiO7mXZRpTbU8aCPMsEMn8SaJHRevWEua+NtdImAqnnCphB?=
 =?us-ascii?Q?qMNnZmv1s+KlHr7obNovvjqT47uXrCdt9iDnmEI+1T+m0FdlAnss92L35aV5?=
 =?us-ascii?Q?G2MViQdgKU9ULhi3bV/2qohmblfeZdw0CscKVt+x0D+JtrSBg2UVOJbJj0uQ?=
 =?us-ascii?Q?AvCoINtC8Hpa3IStZN5WF67X5UQ9/XUng4EvGvSmZEwiQfM6CCpSRQkJhhAP?=
 =?us-ascii?Q?rMFiv7RqM4rfp9lLKRaLJZU1+jUgHmvpqD/rqV4hGjm+rryXbpZH0g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kDbNkTzbIQ6jChgJNo+QPpGxHKa49eZ2AlcRTTe5SErFg/qaiqq3b4LVfuJR?=
 =?us-ascii?Q?XdiSTjxNP9vQ76nRot/7CjX2bNz5Q7Bym/OAUrZHaGqdYMDjNQTXenVdGier?=
 =?us-ascii?Q?3zQedjXaSNANUbFJIeGXqqW2hRvOTtJyR50TVDWsWAYL6yg2SrwZkkGC7mDw?=
 =?us-ascii?Q?vIwsXqj4xFj02+vZgdTSbFEhMa2QP+Rn1KG6raEhCixjr+1vmdq1eX1Inr2N?=
 =?us-ascii?Q?kiW/QGQlgX3ogC4MWYheRZeMketCYuTlDoCqHiECsUEV32lGaQpo8vTPxOOl?=
 =?us-ascii?Q?7fX046BlIHtmWQ1EbWcfkxrFPPsYGimGaQYL4uS7R7VUTLDVUKqOOul16y9S?=
 =?us-ascii?Q?oQ1Z3K2i0x67iZQxdTOBRJPPGUMiRehRnEI9Wz/ZW88COQJmHFTyxK+TlCxh?=
 =?us-ascii?Q?cbMhRk5l2P9F/gyZWwhNaRvft1UOnqWus2j6kqH7JVw5o5BHNV6NOu0Rerr8?=
 =?us-ascii?Q?kORZ0IegUIOEgCvhs2hgFMj+uwYHRxWYKdUfArBxy+Wb55MCAXjhTz9I6kPx?=
 =?us-ascii?Q?u0owzvzlHrmbR1DXZ03UcM5yAQ+xr/Ms26B3eIl2ZdXctJCiVTQXG0ebdoY8?=
 =?us-ascii?Q?t1MAr4XuYYX1gdMAsCUPPElUquXxFUhNS+uGRbwFmvFJNNzd7LAusxPQl4sr?=
 =?us-ascii?Q?oJzc/2aqmQ0zltb4+xJt7xUfJICc83YZUtQV4UKK3JN+Tp2/L8tSnBpzgb/c?=
 =?us-ascii?Q?y0zFd2LUo8YF1KzeIxBRgr2h2wA11gcRzCem/8vSKOzZyYMI9OVRC9pKOg1p?=
 =?us-ascii?Q?P/emCL84fxzgENmHe7GLBDCfcQhsPZoIfNMpvnCM4VDwtE9+wRbCDcfRgxcq?=
 =?us-ascii?Q?gn6Obk+5Mkqs8F8iQAOL9/3wsswsrychAQ9E4FyT3vDieMBAVp2yPUbvafn1?=
 =?us-ascii?Q?sgpfnZkIUEeMrIroZHFJG8fSnU0lH2LKA34ZSY9z59uP495ZDMh8qTS3BOdh?=
 =?us-ascii?Q?/Pw2MMbTuAmxu3v7MNDkwVY8cVVFPzwHU2ZbRo5z93USey8LUvz214OqUooO?=
 =?us-ascii?Q?vAh+zAl6rb50vNUVaEY+A/WtzSINOahyilgFVS6DjtBE2lqOVXcrqMDrxQHV?=
 =?us-ascii?Q?qrjiZ22PJRx+ObLJBdE9g3+t4CoQpvVuf4U2QX14CT9wsJRWSdtUf803LsPH?=
 =?us-ascii?Q?10uujFrviaz4hfIUNZUumwLDiNO2oe3a00cPHez9FI/odaJGJH9fipqZRjdM?=
 =?us-ascii?Q?GmN7Vm44XxO7B5MUohFONI7YYeEwpM+htr1ZXcsDMqRgzwM88ercNTgg1Nle?=
 =?us-ascii?Q?di4L9EVyGzeN1rmpjDfU1sfWF+fS8yAwAICL2xq5eHkFLA5tO8znNdTmutTS?=
 =?us-ascii?Q?DkGTcj+D8WZL9erTxbSCtw4roXVThfge8ObBKDeS55TcpsX5ZleMQt+t4ZPJ?=
 =?us-ascii?Q?baFDYF1lZrKLx4hIL0PUWgBfP2tbqfOZzNWyDS/f+SdCrcY2u7T1CQKyT57p?=
 =?us-ascii?Q?EzGVZn0MX67EI7cfZ7Zx52+gfnRvN74uYy/I0/fW4fkx0fnVt6EMnzeYaGpX?=
 =?us-ascii?Q?bcfmXuTWxa99uWdR8glgZSYL5VemezKJ5BMEDFIE7e6IGcolMf/b9qEPo+H1?=
 =?us-ascii?Q?VNQCn5LyY/TpmZYC4E+ZtDnsOhuQ+8/7fSuOJiPw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edca65c3-8166-4771-ace9-08dd9c2431d1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 07:09:02.6470 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NT4+x1fsDe55K+wsSljJiM7YM3CG5xh432Fk6jJqnOXfOY9BZ+hKUxHGdL0f5G2TAa8kilej4o775KSrBV3VZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9934
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

On Fri, May 23, 2025 at 10:20:16AM -0700, Tim Harvey wrote:
>Update the model string representation for the Venice-Flex product
>family (GW8xxx).
>
>Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
