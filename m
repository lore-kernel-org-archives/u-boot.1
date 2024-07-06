Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2838CC3814E
	for <u-boot@archiver.kernel.org>; Sat,  6 Jul 2024 13:38:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15C98889F7;
	Sat,  6 Jul 2024 15:37:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="ZPEYRE6+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA4BE88360; Sat,  6 Jul 2024 10:46:54 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::609])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8480788444
 for <u-boot@lists.denx.de>; Sat,  6 Jul 2024 10:46:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6w8N4zuObAQgQh0hby/4SiHoK3LJNX7CItss1AfcUWB5jXAjBlVOdg3anm3l8RbHLCEbNk8IduDm21y4ljtG3OnqRRVV8MwwynocE+eyteV4KC8iNvVMlxeMJJ/CrLZDOysmMcGHnUb5YB/HO4anGUVbZtiLKZwUS9pmTYAFM/rD3naZqV1VL7T3wmPAVz3rNlzMLEl6zrKPdmU0fOZ/tg5g90qEMz+u/6IYuWqBDzEiWEFJKsf/VisM3B+u1yA0tlf14IKxTpUpNtt+fFsGKVu0MEvBgNjTtyKYGiTWGvns//voqrEpggUvgMsRc6zDnwZdc1lXfWEOOIUzfMGHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UTCW19uzDSdt386bQ5bYCECs/lgWr5dpfrpV7JMNeA=;
 b=DzBnXCXBKMqju25KcWms7Q5gvu9LVQbIMQ0HvhRDVvLEOp8TFrPlFs2mkLL5KZGcQhDG6ZAIdlwTz/aPw2nqO80IFu3+aUsfKa4iRrprccyesu5zkxTyO3EoOwMXVo2eoLUaz7KGDlmyahgRdl1tzjhCJc82TTJDryBsSR+c1pETwxMi6GhmpqkvrmFvd38KtiZkYduXOOngYFyZfLsAonFCNai2Gt73eJqpnj7mvUizUOX2NovGSy7zDsIT1Y3ufuPYEDkg1JZTzbCV+3Tx6RsmEmPDrVKY+BkqcPX5tDmHa5uuMWHyDl5Y8d85aH2/5OqRnY7YPXqYBHC4POJgPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UTCW19uzDSdt386bQ5bYCECs/lgWr5dpfrpV7JMNeA=;
 b=ZPEYRE6++lITTjmnAra/3pMK4iJ2XAUMPryanxnKfeVJfR106NqDJrB5KunLpi7WHy5nvdXTZe5+cRlWCw5eeinZy/514oKLQvWYwnOV2NoZunu1NAujZYz23UV6ESQh4xbInZ7iZ85TZ4yflCVwITSyv4UdEihomK/YBykKz0E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by PA2PR10MB8818.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:426::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Sat, 6 Jul
 2024 08:46:50 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%4]) with mapi id 15.20.7741.017; Sat, 6 Jul 2024
 08:46:50 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de,  Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 1/5] arm64: dts: imx8mp: rename DHCOM SoM overlays to .dtso
In-Reply-To: <1d920ebf-157b-48ac-8dc5-9f27519af0ef@denx.de> (Marek Vasut's
 message of "Fri, 5 Jul 2024 23:10:21 +0200")
References: <20240705202954.1149590-1-rasmus.villemoes@prevas.dk>
 <20240705202954.1149590-2-rasmus.villemoes@prevas.dk>
 <1d920ebf-157b-48ac-8dc5-9f27519af0ef@denx.de>
Date: Sat, 06 Jul 2024 10:46:53 +0200
Message-ID: <87ikxioqki.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0065.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::19) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|PA2PR10MB8818:EE_
X-MS-Office365-Filtering-Correlation-Id: 6529f89f-c40e-4de6-d3ad-08dc9d982d80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d8I2S6rB/qLwDFOO7UijHHLdjhFCcLUsap9Kv2PcFX4wkx11lbAg+22PjA6b?=
 =?us-ascii?Q?Xh6h5wlf1lVk1SPaE80zDjRYH/IKptmq5mMkO0oRnEsJpC6QQDV6D0UYvoKY?=
 =?us-ascii?Q?TfC3+ae7wUdOQ2+xb/HAGs0tMKhZBpm/2dVIJFMsh0esX8XzD/22K1jnDAgK?=
 =?us-ascii?Q?+ibkt+62inoQ856taWZOJRTYKegQtASHaS1NGKer4X8qMishvvM0OkhUBTMr?=
 =?us-ascii?Q?JoiZPY/KCbJsGEWfAXny3MQABIM2hb8LVLn3vtGDSyWL0nZriUq8pS3SptJi?=
 =?us-ascii?Q?rbRmo37CLXFpyvM8HBq3PdJcz2Vi1DemuAgwfYonoxrp+5wx098fos3y8uyh?=
 =?us-ascii?Q?cawvv2NqqqzTnKedq82N1HM7oeCmbgQto504BM/OfxJHuqFQY7moGGuOP14S?=
 =?us-ascii?Q?JC7kPk/rN5ZjrnIROAQnEsHcwrVP+4g6J1nY+lDVzgishg0P8K9TmIE2cWhR?=
 =?us-ascii?Q?W+cvO12gOtt9gGvWgdzIsx6kvWz41h+7s0GbwUjI385k0Lik+7aoPTC5PDqW?=
 =?us-ascii?Q?5uqCwqJuID69Y+OTwK4oUzIhg30BXPv9P38M7mmQPV4spjQrSvikpOetGHuw?=
 =?us-ascii?Q?IuyYIKv7E92pFEPZV8A1gcZpkeQ74sByouEruHdVGmRbMEbk/dLOnZvte7+/?=
 =?us-ascii?Q?KaVu5bn4MGER/dGEk/YM4mahuimbcFOoBV6gSx4zTx0jvWQUzc0Z/8FiovDE?=
 =?us-ascii?Q?nXvhssP9lGaQ+qLwwkiKfW9MqB1lid2xZ4UlEIRLi7YmPkjR2fJsPlbhH6ta?=
 =?us-ascii?Q?s+TZerC2PhscR1865m6DdLWj4FLnofle3pLrsYk062l9ZbDPsf64VStPXlMr?=
 =?us-ascii?Q?5UI02QURKFhgYkoLdNdioXlaahgoe1e0GqW1tJYEw5ZmMw+7ty2w9mXPMDsX?=
 =?us-ascii?Q?rZ2baF8g7J67gOtPUZHE6MOpOfCCcs4ko5e/DXo1heg+MxhLJj5vCF47UxGo?=
 =?us-ascii?Q?QibHqCwTNCIRHtkGLjo37DBWpKiBkHQFznUFdZkDP+MTMGCd+jsahKLI/q7m?=
 =?us-ascii?Q?nypNZoMW/GFgEhB44rONKFUWywgLmRvyZ69JAnh/82nSeOFvJTOk0M1EE3/f?=
 =?us-ascii?Q?kQU8Mx7sCl8QyDeTB7RYF7vxCOzC25fY9aeCzOZPU35oJ85durPHhRWGsX0O?=
 =?us-ascii?Q?7bMH6YOr4aRwiBmUFhNivwsdTVNWBeNJWUjpTA8WkxO7jYHVIjWBCcEubYKH?=
 =?us-ascii?Q?teEWqp0CQGl2I/Qq1YoeCFUmN2ps0eXmPXJ9TlIT6fOGKp3xLt2VFhqyIDjf?=
 =?us-ascii?Q?bvxAq2I66Pc6OrvCcXwS/4gnDe0cafcNph8bGv2NRZb6r2hpkpjQN5Mn56dv?=
 =?us-ascii?Q?XftztE6vRhGjxZyeA3xAA4Lz4BbqYXeUVlBn8AKEYriDGhGcPLzlm8y8pV+q?=
 =?us-ascii?Q?aPkcMSWEwCRQITT/7HCM0f8M5l84giRgNG+9CHPFW/2pw30VFw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a0iA1ZqLqGc5bGAchOOAkEXYlkGFa+e6jJtpi9/K5GwNoX0gZxDW+fylYalD?=
 =?us-ascii?Q?p3y9fc0p8EaRuZwvoybjvexCJoR2IMVL62gWjCmAkPfyPZrdWjGmQcBYJSli?=
 =?us-ascii?Q?y37xaAwcMmq3gFbTcdg4dR+Xegg4FC3+Pkf3DVdxY23/sL6HYX2s9CrdGMnx?=
 =?us-ascii?Q?VlvE9sGFk+Y8mCqrTglYXRJ3fymQgaqxCsAkC53mUODY4dYZxjjpmo3u1dE8?=
 =?us-ascii?Q?BVIxYQLblGpTKj6fNOCA8p/pkpqVB4iymzmiFQwNk8UO4wmuWWXQobixntoc?=
 =?us-ascii?Q?uMdy8clyPz8qExFbetoHWychIFBSmEdQJ2A9MYtBcAUEAQ4HundwikgkZ0T5?=
 =?us-ascii?Q?f5i+C9k8heiVDQNeshBTfQzJSMKTa7+wjw3c3E3wSisF6jp1woCv+/QmhCyY?=
 =?us-ascii?Q?4p2X23Jd0x4+a+Yq7bnvtXCgS84RcdKMznbflt1pqoZa4A5vhpI1DGWFttJz?=
 =?us-ascii?Q?pkBpqC66mYotP7bfH9BPzmrfbDbyNouey1aXHIZq2LzLiqjSXFr7Zwv54lHo?=
 =?us-ascii?Q?83JcRAlMXnln/LWUari2PclNZiFb7R7Fy4n1S6WqtpDTDE710OQ+KGlA63HY?=
 =?us-ascii?Q?EZACIcl5Y9+noX9fH7TXYLSJTsO1aDtkWPHifZEAWuam38S2P/rQHatz/tRb?=
 =?us-ascii?Q?IVIgPghUKcMuWf7EwnVFcpjuFNThuCahi2cleJcpIC/3ikSRNNNYMKZoyNNj?=
 =?us-ascii?Q?W7bXG1s22wT532rFKg6LLEj22hZNMu3795ozV+v/BLFa0CDVHr/xpiXJA03T?=
 =?us-ascii?Q?2cdWT6f+DvK+ojkz5ykfeNlsFo7Qn0wDJNoxFojG/e2q0+Z//PbFkwbVPS9s?=
 =?us-ascii?Q?NeKbILQdcS2sQdwNOrrdqz3QWam4wAS6/S8GFzzjlojXWnMZJDf/pMTn5AKC?=
 =?us-ascii?Q?A7UVy3gpbqmpjOIBKCXj5d5Wqp5RlA+xaxgiKcJ/N7b9BM62ABDJxuQ5C1UE?=
 =?us-ascii?Q?7BwrUrnddeBJlszuQVoRnSEujRDQDl4ppOr7ESIHSc0XuKil8v0kNUsqpiUn?=
 =?us-ascii?Q?fynWms04K+O6G+kWNrIYLPX8q/uD7gAZNuSpfCwc2wElV10c3kivCVPigbjm?=
 =?us-ascii?Q?SPX6d3RN8xOwIYhV5DOqpwXbfXDU2TfQefSOzwrKum2/QvRPicB6hSGK4bE4?=
 =?us-ascii?Q?HoQfYr+k5CDU3a7rNFnSq+k5s1kptqxShOVUFgGJri4OqeZn99l0I/zh3n2/?=
 =?us-ascii?Q?7uFdV/9QrrYaXf1e6DcM5AmJ1W83VR+lh+csCS9KcyNdlX/y+3eBCm+8m5Cy?=
 =?us-ascii?Q?bOMvXzo/EishG58RQvfV2aAsgcq2pguUXZ1/RBn0K9zwBBS+vXaI53kuMW0N?=
 =?us-ascii?Q?4IafWt2xx/SOlzpxUtO29PiOyS/rLjRSrJDcY1dpLksIGHEMHwRDT1v3bORg?=
 =?us-ascii?Q?0cyVDGVr6uPfXXjjMNgKXYuvMRhoxWuvVewxXoYNrVerPciKEcZwnGHzwYRE?=
 =?us-ascii?Q?gzb0nlTuxK5HDHOGcy8x/alnzbVxDimFRquVZcg3f0OpxGIQRWv31kd3ywcH?=
 =?us-ascii?Q?qPGolvxc1Xu9EMUjhGu4rSsaxjPxxCMRI1hg6nZdJ9HtoFXdglCDYlS21ewh?=
 =?us-ascii?Q?MfqVOrQ5WPhyLHT7O8LleEYlJuJzhvSzzDmRkxL+hnPMslMfQMw3OiSXParH?=
 =?us-ascii?Q?fg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 6529f89f-c40e-4de6-d3ad-08dc9d982d80
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2024 08:46:50.5106 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aA26YhJLr4Yv2Rddsz0FdFVkPRPp1MRWYLQMpMOceWJohWObWATsnxP4ny3LhsHShcRH/LHiI/zSZgBtSJWyGae2hlYHbZJg1nhx6oECnv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8818
X-Mailman-Approved-At: Sat, 06 Jul 2024 15:37:18 +0200
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

Marek Vasut <marex@denx.de> writes:

>>   ...om-overlay-rev100.dts => imx8mp-dhcom-som-overlay-rev100.dtso} | 0
>>   4 files changed, 0 insertions(+), 0 deletions(-)
>>   rename arch/arm/dts/{imx8mp-dhcom-pdk-overlay-eth2xfast.dts => imx8mp-dhcom-pdk-overlay-eth2xfast.dtso} (100%)
>>   rename arch/arm/dts/{imx8mp-dhcom-pdk3-overlay-rev100.dts => imx8mp-dhcom-pdk3-overlay-rev100.dtso} (100%)
>>   rename arch/arm/dts/{imx8mp-dhcom-som-overlay-eth1xfast.dts => imx8mp-dhcom-som-overlay-eth1xfast.dtso} (100%)
>>   rename arch/arm/dts/{imx8mp-dhcom-som-overlay-rev100.dts => imx8mp-dhcom-som-overlay-rev100.dtso} (100%)
>> diff --git a/arch/arm/dts/imx8mp-dhcom-pdk-overlay-eth2xfast.dts
>> b/arch/arm/dts/imx8mp-dhcom-pdk-overlay-eth2xfast.dtso
>> similarity index 100%
>> rename from arch/arm/dts/imx8mp-dhcom-pdk-overlay-eth2xfast.dts
>> rename to arch/arm/dts/imx8mp-dhcom-pdk-overlay-eth2xfast.dtso
>> diff --git a/arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dts b/arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dtso
>> similarity index 100%
>> rename from arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dts
>> rename to arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dtso
>> diff --git a/arch/arm/dts/imx8mp-dhcom-som-overlay-eth1xfast.dts b/arch/arm/dts/imx8mp-dhcom-som-overlay-eth1xfast.dtso
>> similarity index 100%
>> rename from arch/arm/dts/imx8mp-dhcom-som-overlay-eth1xfast.dts
>> rename to arch/arm/dts/imx8mp-dhcom-som-overlay-eth1xfast.dtso
>> diff --git a/arch/arm/dts/imx8mp-dhcom-som-overlay-rev100.dts b/arch/arm/dts/imx8mp-dhcom-som-overlay-rev100.dtso
>> similarity index 100%
>> rename from arch/arm/dts/imx8mp-dhcom-som-overlay-rev100.dts
>> rename to arch/arm/dts/imx8mp-dhcom-som-overlay-rev100.dtso
>
> Has this been even compile-tested ?
>
> I think you need to fix up this:
>
> arch/arm/dts/imx8mp-dhcom-som-overlay-eth2xfast.dts:#include
> "imx8mp-dhcom-som-overlay-eth1xfast.dts"

Argh, sorry. I thought I had had the CI chew on it, and I did, but I
somehow managed to not see that it had failed.

Not only does the include needs fixing up, the file itself should also
be renamed. I had just done 'git grep /plugin/;' to find candidates.

Rasmus
