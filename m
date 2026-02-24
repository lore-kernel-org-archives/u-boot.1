Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12214EFB81B
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 09:14:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4754083D8A;
	Tue, 24 Feb 2026 10:14:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="WuSLvGNn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E209683DAE; Tue, 24 Feb 2026 10:14:42 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0649B83642
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 10:14:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.delaunay@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNSD+D5J7T7O1vtmoZ3SwUKdeF0RgwB544cZeK0YRP213J029nZWzrpQHradlskuTcEP/4pdUHOyDnDAveb9eZCEM+iBiJKx83503P9JMUoVIkEJtwHCk2Y81lxM9HjSoOtNYG0V7l5qBbTI607EyJhqvHOJKxqhvVnfNVF0Z95xRLf3wjgEoZoCfc/5XDMhUPwv+b0hWAEYNegUlu2CC+yIkBchBUUDXde37to9if3k19DXDo8RV+/wjf0WWhlp6erTSg0DHcVyY8o/dyOytmcnnxC3GmQFoLTiI9PnrEFhe7ZzCdD1WWxJJGQv/J6Higy0AD47Sghz97RYCEcaXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDydfUkeeLBhchB2TIpjFlM/kypXGJxmiAbFYpsaA+s=;
 b=LDbNbeK0D3jZUxJXFZiJ97d7PL8+cmV21qgJP8vb7jhIa2l792zrUG3v1UyXNzbE/IAx7brPZzZlVnWo3hGVaAYfYvSKjqG1jSDFd/0XpQf70oA0OQYGZTUSzfI8cvlSJnq+bpyrQEXuq3cWnTEWmkIM+Op8lBYgLAT/OEgfGKHfK3qo3n0L3Jtgd0CT751tRCuKh9XoSm+rSe8GNoPd/8KwBAeDsbEvYTXwG4YtTG4fPb6gG8O5fQkiuhET2nMhigf2Px/jFShuWgc15INHMzFwQeKc6wEwQbJU/pxJCrVN8pkgmA6WNrCQDIYcorchR4BkRN3zERSdrPbcxm9k4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDydfUkeeLBhchB2TIpjFlM/kypXGJxmiAbFYpsaA+s=;
 b=WuSLvGNnpy64y1wmitHPssbS/0RanlvoVlK5bLJEHBhCuTJ8IqVtEb9sjwtCZBWLqTf/7TUJfyHU5ReOa425sw0KEJhxZgP8MWNZEIFFp8kSnqA0UHSXbfTk8oEsFLayKIGb6zII4NNfB7TA68PlKP1cM8YVFI00Q8gIM10FvfGg118iJtaUrdeZ2ZJGMQG7V+K4aiWCetenoWUi7Wf8Ufhi0em9Ov3ytsRijcKw5Atd+OT/mssCactcNXs/P1tb9P0eAESu3dMk1rnhzf3PhO+Rn36S7LB5eg8vzs5GR0Ctn2OrYHvl5Yg7+wwF6vZrHEulbmSwhNMYDF5eErpEGQ==
Received: from DB8PR06CA0061.eurprd06.prod.outlook.com (2603:10a6:10:120::35)
 by VI1PR10MB7635.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1c8::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 09:14:37 +0000
Received: from DU6PEPF00009525.eurprd02.prod.outlook.com
 (2603:10a6:10:120:cafe::9e) by DB8PR06CA0061.outlook.office365.com
 (2603:10a6:10:120::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Tue,
 24 Feb 2026 09:14:18 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DU6PEPF00009525.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 09:14:36 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 10:16:43 +0100
Received: from [10.48.87.244] (10.48.87.244) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 10:14:35 +0100
Message-ID: <4d58729b-8fc4-4fa0-bbda-733ecaad3934@foss.st.com>
Date: Tue, 24 Feb 2026 10:14:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] stm32mp: cmd_stm32key: add support of remoteproc
 firmware encryption key
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Thomas Bourgoin
 <thomas.bourgoin@foss.st.com>, Gwenael Treuveur
 <gwenael.treuveur@foss.st.com>, Lionel Debieve <lionel.debieve@foss.st.com>,
 Yann Gautier <yann.gautier@foss.st.com>, Nicolas Le Bayon
 <nicolas.le.bayon@st.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Yannick Fertre
 <yannick.fertre@foss.st.com>, Cheick Traore <cheick.traore@foss.st.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
References: <20260204-upstream_update_stm32_cmdkey-c-v1-0-d95374395840@foss.st.com>
 <20260204-upstream_update_stm32_cmdkey-c-v1-3-d95374395840@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20260204-upstream_update_stm32_cmdkey-c-v1-3-d95374395840@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.244]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009525:EE_|VI1PR10MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: 775f8433-4d34-477d-450b-08de738521df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d3Vsb2tpejd6WkN4VGlpRm9xRFJMRzk0bTA5RXEvcHdRU09NQWFMdllEY05J?=
 =?utf-8?B?Sno1dVRWRm1aVmNqcEFLUHBaL0xwVzNxSjlzWnFtOXN5YjBFa2FsRjhFRkxW?=
 =?utf-8?B?cUNPenFKbGdZbjhmOHhhMjRMenZVSk1YbmRTZ3VxeHhrdWNiUWU2NStwaFZN?=
 =?utf-8?B?RUV3a0I2NHQ5a2hHcDFlMlZKOS9yYzJrSmJCNk9scXZxNGQyaE9uYnRxNzVW?=
 =?utf-8?B?VGo1MVNUMHNxTEFWdkNMT0d0RFBZajdrblhOUERYaHdUUU5XTGR0TC8wMThI?=
 =?utf-8?B?dU9BYkRuY2RUL3QrL1FJY0ZmYnpXOVVnb2M0b0t5MzlPSWRKelZuN056d0NF?=
 =?utf-8?B?aFlBeUZ2SUVKMUMrT3FUYjAwWithNlZ2TGJXSiszRXZzUSsrclVYbURSSHNZ?=
 =?utf-8?B?UUJUVkNMK2FrTUZId2kxSmIxMVErcE8vem94V3NjZFJWRzIvMWM2TjI1SDYx?=
 =?utf-8?B?NWMvbjlzWFl0YmtXckRyRTJUcEZERDVjcThuNTlMZk10cDNNNG5aSzlBV2tK?=
 =?utf-8?B?YVE4aUdPREF4QU5WZUpNRjcrczUzR29tNlk3R0h2YVBldEc1bVlCMlNYVlE2?=
 =?utf-8?B?L3VXME5NWVh3aWZBN3BublVUUW9ucUJmYTdkUHFJSWRzL3ZtTFBOSFFpQ1du?=
 =?utf-8?B?dTBmQjFVSDd0d3pQUm4wSDdyWmVHVnh2Y2FCb3Jmc3FwWUtMd05nWmxZd1kv?=
 =?utf-8?B?ZTFMc3lONERjYTdyaXd5MTZXaVRHbXdqT0JsbE1PWjZtazB1eHZJbWZlUy9m?=
 =?utf-8?B?dVpMc3ZUZmlHQ2VZc0E0MndxTUV1a29FemJ6NjNBQW13OXZrUXdpWTNYeUxT?=
 =?utf-8?B?SWsxbVQ2MVlxdkFoQ3N6ZTVid0pHMnI0U0Qvc1JKQUpHcFhMeUVTS2dvNkZs?=
 =?utf-8?B?TFF2aUlPNWllQmFkamNKczlCdmNTSWg0ZFR1ckZLUlFlWlIzRHRjdWVCbW5R?=
 =?utf-8?B?LzQxWkhCQzRBYlY2cnNRMmxONXJ4NDdsTFJUbGh1VzdOZi9Pb1RsWERIbHV6?=
 =?utf-8?B?cEcrNFNzdTBvOWt6Z1A3QWJZQThReFE1bkt2MW1xNVM0L0RXTW1ralJVbUVG?=
 =?utf-8?B?R0VweWk0dnJkcTNVdUh5R1kyZEhuVkVBWGZmdktKaXJlUnFtbGMvNnZoK0J4?=
 =?utf-8?B?dWc3RktLY1liUmJXcGI3ZGdKb1BjTkdwSXFIbVQ0eDR2eXVtYm5qYXh0VFBz?=
 =?utf-8?B?M3FIMGl4WDNwcGNjY1JNUGhXdjNEbWZUUG1BUW5XUGtHUjM3bnhLaW4zcThC?=
 =?utf-8?B?OGUxTnlPUmk4OXBUQmYwZTFmV1dJTC9MVUF3L09QT0tNYm80VFRWcHFUblNm?=
 =?utf-8?B?R0dsV3RFeS9HQmlFQ3N5amk0MngxWWRjZWxFRlJROGZobzA4VGdsY3o1ZkIr?=
 =?utf-8?B?RzlyYmdsMXRxSjREMzRiR0NYaGJZaWExTndSTHlzSFhIUEVsaFBkTDllOXdP?=
 =?utf-8?B?NE9tT2V6YzdlazUvWGFGRmFBL1RLalRNVWRZdjk0bEUvR2xrS01CUzlaZkw4?=
 =?utf-8?B?eUdKeWdmWDk4YUh5UHAyTklWRm4yeWFDQnVRQ3hucVIvTnVmTytJZUVBbXN3?=
 =?utf-8?B?U2tsd0Fsc29zTEdubEFrZFRMNHV0TTU0Ty95QXlLUWFSUlk3TmUvejdRblky?=
 =?utf-8?B?ZTRNaitoVHdONmp6NDBRck4xZkk4elJvQnJCKzRXWWRqOWl0eU9GMUNNNnVn?=
 =?utf-8?B?RnNtczJKZ3BQUUliWjBwbFNaemNJNk1zVDBQSkFkN09wejZhY3JhbXNuTU52?=
 =?utf-8?B?dWZCUFlBaWRla0dKTTU1bDdjeTdxVWgwYms5T1ExREtIdEdxZllyc3QzTHhG?=
 =?utf-8?B?MnY4dExiMUEyT0pZUWRHOEhFTzRwS3h1TThUMzcvVHV1Vm5lbWNxOFVjQ3Jl?=
 =?utf-8?B?WENiT2hQNHZmZzNPdUZZL1MzVzlQRkVOMmxBcGUrbEUvSWdsbUF2cWNDbk1s?=
 =?utf-8?B?Ny9CSEY4TjNzOEpxVEltNmlIS3VPOEtjbU5lWkkwM1F4aERuOFcrbkZmcWRL?=
 =?utf-8?B?bW5OOGU4NHNla1ZLdE1iZVhpdUNSaWZXTlZJbjZod0NqUHRFUkptTmQzRGdi?=
 =?utf-8?B?a0l3V1FuVThjVVZGY0htNkdqR1VNWEVMOXU0RHozZTJoME1DdFZWWFFkUkpz?=
 =?utf-8?B?Y2FCVENVWGMwaTBaenNkZmwwMXdMaGR4Q25pRDRDMlVZR2VzUFlyU3NNTVo4?=
 =?utf-8?B?Y2F1TlZYSjZQUEo5cnpiVVptQUNmeTdHZzNreUE2cGJWWjZKMHFraG5CK3Nn?=
 =?utf-8?B?dDdWUHNxT0UvMEViMGd3YmtXY1dnPT0=?=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JkBhk5kzVzLllCw4NmwOLLCyJAeSGe/ZqlkkGkx1FQeJlGvkN3f3FEsRCJYPpyVjtMXMTAJdFI4qq5PY1xitNBzb7dyz6vEI2QTYWocTBj13IWFxOrtXPnyWm1BBt+lXFuVZZQ+5NIzpshfHcf5+c/1fMIlPrLPvJOwY6h4Mc0fuY9O3H43Wwqq3ysT7+EgrlHg9vgsKdVajC531Nj8UfkbaLN1SZCL2SXK7zCcYi0pQkw4VU0iE+RgO1v64/9p3SGdSOassUDtzOpP2LnyK7K4XN75GPfc9bx+sMKfVRYLY3iweDrCmoadBXKDEMTQHYI62Czm3fR8hPGjx74Gif+fxLkKAg7352Je8+tK7bIMUvU8S74ia2ziQmhhy2vaCcyn5qqSDxndlfulKp0uEOHbZCarqXBdEtfDx8wop9QOmahvi5H0JIyq4DktawFGB
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 09:14:36.8239 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 775f8433-4d34-477d-450b-08de738521df
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009525.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7635
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

Hi,

On 2/4/26 11:20, Patrice Chotard wrote:
> From: Thomas Bourgoin <thomas.bourgoin@foss.st.com>
>
> Add support of RPROC-FW-KEY for STM32MP25, STM32MP23 and STM32MP21.
>
> Signed-off-by: Thomas Bourgoin <thomas.bourgoin@foss.st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>   arch/arm/mach-stm32mp/cmd_stm32key.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
>


Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick

