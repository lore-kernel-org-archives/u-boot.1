Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17135E9B24E
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 10:09:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F41C83DCB;
	Tue, 24 Feb 2026 11:09:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="k7tJAUKc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6005383D8A; Tue, 24 Feb 2026 11:09:52 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57DE483DEA
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 11:09:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.delaunay@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cc3AHRJxwExcPOKD+nNXzgH/Zm+/scG6QKv9XeDWrpODuTxFJu9zg0NUUhuYkZ2vUpvukshu8fLy79FSuVJjPb4+Dq8m1bHK4BVCJelBwFc4X5pBBP9M3pnNtFGiSf2Jv3Asksea9BCRa9DlKarLNHrl3HfaJFJuox0YZnUrgyZYfL3MB69FNFhKHNIy/sy7sJsQbAULJVjgWyHImvGUHAiWiH6Ptsyo0T7yUb2HAzyPshIHS9ntLcPCS4fAK3eV4602ZqTrd9zHrtYvgil4qNKB2sGaQU1/25U0zuM6qKHbUyz0AJ6KTczZUdbHwms6/ny9EpSUN5/sdIEWpXPxFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHEXULq/wATXF1cDc53g6m2iLkX5zMDzGGAPegYmXnw=;
 b=kxKEHbnWlJOrewptnGJ5MZd92YrmTCqYHytq07AIlBmRZdIjFI/8dA80Jp5B5AUKTjLGI2K0EhxEzHaUYmHOiJYRltyl3OMn1YN+r02XPtD344203bDtDNUQDw9lizaQH8q5HAEPtbhBc+osmns0pgWhCgzLXmsBjKlA3TgVeNQRIsA0cmtJ3JQ+fBLJqX2qWDvH/UZzAo1SdLCupdGEJp+YV50RXdSketQV0rYa47w3y8vWlhWqaG0sdiiVXhRmx0+1HiBNU/2o9Vt+Merjs0WO6+u0sfZTt/jc9xsgcrEfDJjf6seUhyUJDE8fQ5nJYUAtU/HJ2DTw3oLWdElcmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHEXULq/wATXF1cDc53g6m2iLkX5zMDzGGAPegYmXnw=;
 b=k7tJAUKc97KR1dWqgGl5a8gHaFxEFi8kDEC8vR59GApVY6iZSO+rHZvldQ7WNOBV+gl0J5wa8yTMPagVtA7C6asXJEb32wT5I+bgJkPEtRs+9U/VoyVA93+p8qAmfz5cgHmxWBH+YO3hsuAFaZrqsqhZzO5JTka1RgnU8xiMn9VoQBQsAfYU5cK7uvp0C7agQ0OO8wcQWw5f7eubOvt6WTqSuDy+Gry7tPtvzCiqKGx3sx5nP3jVNKGRHSDihdF4U/+JypOWheH5OcVnDT/Oo4/q4gaInGMfvbWkESiBLouL+Rj76DzoTN2NjIXfsSCxLxJbodq+j22l4sCjEgGX8A==
Received: from AS4P191CA0003.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d5::18)
 by DB9PR10MB7289.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 10:09:48 +0000
Received: from AMS0EPF000001A0.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d5:cafe::15) by AS4P191CA0003.outlook.office365.com
 (2603:10a6:20b:5d5::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Tue,
 24 Feb 2026 10:09:45 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS0EPF000001A0.mail.protection.outlook.com (10.167.16.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 10:09:47 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 11:12:03 +0100
Received: from [10.48.87.244] (10.48.87.244) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 11:09:46 +0100
Message-ID: <1b4e87c5-1637-49d8-b6de-79f84bf6d5da@foss.st.com>
Date: Tue, 24 Feb 2026 11:09:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] stm32mp: stm32prog: Remove fsbl_nor_detected from
 stm32prog_data struct
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Jerome Forissier <jerome@forissier.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
References: <20260205-upstream_stm32prog-v1-1-578f2d835d2c@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20260205-upstream_stm32prog-v1-1-578f2d835d2c@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.244]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A0:EE_|DB9PR10MB7289:EE_
X-MS-Office365-Filtering-Correlation-Id: 19920eba-b056-4f25-b6d1-08de738cd754
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SHNSTGowVUVaUDY5bkh6R1BhNnZjOUtET04zWm0zak0yM0p2YStsMVVhMVBp?=
 =?utf-8?B?Um1KdE1SKzdZUklhbFBMUkYrUUR3enVnNkFEVXltT2tLSEZsZ1k1SGtNbGw3?=
 =?utf-8?B?cWpzRVBRMlh3eFZNalRxb2h3bksxbGpJVmJoUENpb3hZalJUcUhBNjdKOFpT?=
 =?utf-8?B?VFRpdHRrazRXUi9iaVRQMWdBbFpLS1RrRk1xVnJGZk0wR3hVUFFFZ3YwQzlu?=
 =?utf-8?B?V1N6Zk56SDlGM3AyNkMrSkxnRXVJcVBYQnRyWGM1aEVEU3RjdHZCOHRKUGpM?=
 =?utf-8?B?bXA1dnBFalcrdkpmWkppYUk5TEtST2hTVW5zMXFVbEFQRWx5OGlGT2pLMGtN?=
 =?utf-8?B?Q1FNZ3ppMzh4Q0poUFZyRm9tM1puOTZYSWtpa1hDUTVUY05aY0JVTzY1NmdE?=
 =?utf-8?B?ZERNTEplRW1vY3c5R1VzcWREeWoxMmprRkE4MHhSQy9ybHhuWjhHY0kzMVZt?=
 =?utf-8?B?REYrZFBGZFdrUWJ1em85aHZJNEZHLzlYVXR3bktUcWdTb1hLZm1rTGZ3K3R6?=
 =?utf-8?B?SzM5eUxPajNRQlNmWHl3azQxVVMvbit3VlRZV2JqbXlYUjRVeVRsTGNSc0x0?=
 =?utf-8?B?RU9udDlsRzUyOEdaVzBQUmllYXNweUswOFhCUlYyQzNZQWM1TCtSZTZjODI2?=
 =?utf-8?B?dWtvNUI5bzk5bVBlVWN4QTFyMjRoQ0xUTzJxVWVZajh0WDI2ZVlodXlLQ3JU?=
 =?utf-8?B?SkordDVBbE9tREF4b2ZiV3plcWQyU0hKVUtLZEpQVW1mNjVLZnVSMitUVmNS?=
 =?utf-8?B?QjlQTXh4Q0R1OXlJOUhtNjd0cEg3S1R3QlJlYmVIYnBlVlp2OHQ5RUNTVmV4?=
 =?utf-8?B?SHd1RVpFbXNtMTRsM3BuZVJwa0V4cXVRZ0JLVEpONWwxLzIxdUlLZ0U0QzBO?=
 =?utf-8?B?cXV4N1dqRHlFODJVbmdocG9sSmx2YjhLdmdFVVl4eVkzNDdSb1F6M1pVcVNF?=
 =?utf-8?B?Y0VMalBJR1pTLzdkaUxBMkhTQ0kwSEg1bWJ0L2F4Y25lTTJXNmlGT0xTdWdx?=
 =?utf-8?B?a2cyUk5QM2pUeWNpMzdHYk9IVXZLcjZwazlpUW9qTEFJalpqS2xWbXBYc1Fr?=
 =?utf-8?B?cnBtbEZkcElQYTlaUEZ3a3lXV3Y0bWJLckJvTGJWUll1bXJpd3pONFRVKzdF?=
 =?utf-8?B?cjg4TzNhay82ZHpUZWVscHU3cmEvNm81d3E0cVRaTlNWUjRrbDVHYWI2WlRm?=
 =?utf-8?B?bEF1WVhVdy9vN2RaQjJwK2N4ZlpPcGFHRjBtQm5oOTc2YTBaNElwQUthbG80?=
 =?utf-8?B?ZTdudXk4VHpqcTNZdnQyVzRsR0Y4S2lBMWtIMXdXcUtoL1hZMzMrRmxUcGw3?=
 =?utf-8?B?dFUvZkwwdy9DdzVoWVNka3FkbU9pVkRYWVRNWFhlQ05jTnBYRFFVWENqZHZv?=
 =?utf-8?B?RCtrNUJWSzZmUnAzWEdDaWpVRTZBcXZ5b0EwYWs3T1RYTDltYXFLYjhORi9L?=
 =?utf-8?B?NTgrWitSUXlEVUpvM09XbFFoUXM2OXg0V3F5bmxXMHp6WWUyZ2VyejNNZUlC?=
 =?utf-8?B?MFNscS9ydEx3S0F4UDZJb0J4ZlQvenJmSk1wQzE1SkEzL0JOUnhUQzFXM2ZP?=
 =?utf-8?B?SlE1ejFUd0VlWnEvakJlMmd4YmdFUG8wTWRicjViK0t2eVVtaHZkdUhjWS8w?=
 =?utf-8?B?L2pPNTVTeXFFKzV1UUZUVXlkN1IyYlRnUHVmUjVtL1JmM0JCWFZTUEVjLzhv?=
 =?utf-8?B?RGxYSlE0djJTQjFEdE1oQVZvSHUwWTJUdXNheTh0NklvalREZlRndStxWDMw?=
 =?utf-8?B?M3FLdjhBUnlVQWt4ZUN2VEcycExTMU0xeEZEV2x2ZEc3U3NTRCtxWFRFbGdF?=
 =?utf-8?B?OThTSFIyUUZuVXRQaUVNMXpZUVBkLzJTandlSVlyY0RzK043bVI3bis0MU5y?=
 =?utf-8?B?N1pJQVBlb1lWK2lmay9OalJndXN6ekFhMkVQWkdyZWpkYjA4aFVqRXFrZU84?=
 =?utf-8?B?bVJ5WlNOdFgyaGRMTTNuTDk3ZFhVWVBtaEw3R2JsYzVUT25rd3dDNUZ1MmNn?=
 =?utf-8?B?bGw1N1JaRFFQVlRRSHoySHFRdThtOTdWMVMvZFI2dWNpS0xNL2FwRExkVmVD?=
 =?utf-8?B?ZVFUNjhseVVzL0QzWk82cjdiSnR0UGdBRWRYZ1BVaytTR3dSdktWV3NKTW9r?=
 =?utf-8?B?Wk8zZXhWd3NOb2ZnTXhPMVBPc1VHZGkwZmhnNDZIRnc3SnhnaVo0NFBVaEha?=
 =?utf-8?B?MHdSM2huRCtNeEh2S3VqWUUreWdRaC9zZmR2OGUyZXRBNmJNK2s5MEdsR2VU?=
 =?utf-8?B?cWc1WXYvTDNTQVYyN2E5NUF3Q0tnPT0=?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /aokAPGQgglsT8cMEJEiucRnGg2pWArehTre/inJC7XQmxgtiWtLV50CtwRntIwHAcF6MhF73gq7DdKo1CnYjAAxXp2pfSvNBzZ28hFO8lbxsWoLywYPnKJ7Btx83Hfn4AfkNcq6zu3HAWcqN3j/koIBv5YuapO2hlpGwcvhI/WJFYecaHMl6Z2Oslt96MHP1KNT7YwxSVe6+fnyGKLFOeCW9WAb8nLhITTAqnPQwnw0Lv3srhvF5y/sLQQ+hsqodpViAQx79xCh8d2YQlr2ZuB82WxE6JHaCcPadwfTctIRtf6uQSufdJXfysZlV0POC9YY0Oci0fZLwGT5BMD8GHiu6CwGSHV9C/wnLzUKIg38OIzNJjV+I6gOqQRukdKdydtukdQ5wvULJGJ3t0yBIO5xmM1zKtDYf7FnsWuXBywiCs+uwdhwf+uBnEEopev9
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 10:09:47.7660 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19920eba-b056-4f25-b6d1-08de738cd754
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A0.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7289
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

On 2/5/26 09:50, Patrice Chotard wrote:
> No more need to test if a fsbl partition is present on NOR when booting
> from serial or USB. Now MTD devices are automatically populated with
> partition information found in DT. Remove fsbl_nor_detected boolean from
> stm32prog_data struct and all code using it.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>   arch/arm/mach-stm32mp/cmd_stm32prog/cmd_stm32prog.c |  8 --------
>   arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c     | 10 ----------
>   arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.h     |  1 -
>   arch/arm/mach-stm32mp/include/mach/stm32prog.h      |  2 --
>   4 files changed, 21 deletions(-)
>


Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick


