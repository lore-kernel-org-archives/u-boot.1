Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC0BCCF2C1
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 08:49:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F8C180B98;
	Mon, 19 Jan 2026 09:49:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="baXwRj4D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DCD98313B; Mon, 19 Jan 2026 09:49:45 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6835E800AE
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 09:49:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DRSh9ShBGHax07BJzhC59Cl3taK6Q8f2Tum76NEuRfG/8H6aUoYNrwnglY5QXayX3tYE5cqdc8phzXuOKpUPR3uvop34mjAUcVb85AcgSBo3l94u35nnbqgXzrwBwA4JhizIxkGkGTUS13ln6uslYAZETD+68p0Nd50vKPQcQ2qm8whxNIGAoZVYBFfv1MuJnuv5E14x8s1EnHKicq9KOxFINjLe9Csej/wo5aKJR5We9DPBXaCVZp2dZGhBOHzeu86l7fSooXEqP+YHgxrMisK+MwDqQnGVmS0o0Z5DFb0igfl5lB278jApHmX2wqzQRciFfgPtlYEfJFiMD06EDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VlD1hxIf22Q2LW87gJ+Q/jxhEpeZOYoZ3lMmrqIATJk=;
 b=FvNxaaMZrzVPKTsD1gtrGzByLnEjOK1BYzRAqvLqVWDTxaI83ke3EPpNp6XuGyJLQvlsYtvZKFHtAKjzVTzCjgj1mNVBBoFuq9Je5TBXlS1T8LCrL/EmyOF/RsU8+U81LTgu/MbvPy5pOeCTWE/Vycerwif/Xp/YL+Ava7CYCe61cN6IxncpTZf6DfUwgzsYJMFByQo3UMh1IqT5xS9ZmteQi66ElXMctJwgnbn6H9dNhHBLoueIJFm2ARmrhHqOtBrxFV5DvgNh6SvHVsK+gojhfc049FpT0AW6kUr/lafFJUD6ERr6Wt/xB/6ccT09GddLTLTkhNcdjdk7hJ4G1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=nabladev.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VlD1hxIf22Q2LW87gJ+Q/jxhEpeZOYoZ3lMmrqIATJk=;
 b=baXwRj4DAuYPhiCKMjjqiph614YejGH4FMvGqR16wg+ezdXOFjAgsg6Eo9GcFbqa2ycqNKbvoIGTVxYoXwX7ICnFSqntcrnMZYy2UyviLhPIax6/78NSk3h6LFtb69RKo6me0HNmEKssV3/fyP5b6WBzlZKCyIGf9Jomqsia4emP8PkSr92FwBMV2AsYAsP288TLG8nYPD+gYEFCrT2xgU6I1ZmZx9TPy+C4cptWdssjuxg25yj2KqHqgMp29o6nTWe228ZWJmtNWcAu0sg4zdbtAW+pZmBCgwlLz4l2haOguLXdfEvTzXTOQglG0fansrCxs/Of3yiYGbhQaZ9n+Q==
Received: from AS4P190CA0012.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5de::12)
 by AMBPR10MB9817.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:730::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 08:49:41 +0000
Received: from AMS1EPF00000041.eurprd04.prod.outlook.com
 (2603:10a6:20b:5de:cafe::ca) by AS4P190CA0012.outlook.office365.com
 (2603:10a6:20b:5de::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 08:49:43 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS1EPF00000041.mail.protection.outlook.com (10.167.16.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 08:49:41 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 19 Jan
 2026 09:51:09 +0100
Received: from [10.48.86.129] (10.48.86.129) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 19 Jan
 2026 09:49:40 +0100
Message-ID: <fce4a08f-38ca-4514-a4a3-280bdc81ff6e@foss.st.com>
Date: Mon, 19 Jan 2026 09:49:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: stm32: Use CONFIG_STM32MP15X to discern STM32MP15xx
 on DH STM32MP15xx DHSOM
To: Marek Vasut <marex@nabladev.com>, <u-boot@lists.denx.de>
CC: Antonio Borneo <antonio.borneo@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Tom Rini <trini@konsulko.com>,
 <u-boot@dh-electronics.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20260108021645.518220-1-marex@nabladev.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20260108021645.518220-1-marex@nabladev.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.86.129]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000041:EE_|AMBPR10MB9817:EE_
X-MS-Office365-Filtering-Correlation-Id: ce53dff5-f9dc-4cf4-b006-08de5737af82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bG43UXBRSmNzVkhyUmhjd0ZTb3hOSS9KQm5tQjZzL1ZLeWt3NytLZmFFTVVZ?=
 =?utf-8?B?RWttOXdtVEFYZGlrbU8yN3pFaVB6UGdUYW05dnhTY3h6dXRTTnhkaTAybHkr?=
 =?utf-8?B?Y0ZaVUttMmJUUHllaWJ6dDFpNGE4MjNkbitxVnNETGJKL1cydlQ4aGZxNUxl?=
 =?utf-8?B?cTdPanR0bzRTTS9PaU5SOW94aTVFMXpKR0pHSE1Jc1F4Y2pZSmZLMVFqWlBI?=
 =?utf-8?B?OWhHQXdiMzBLek5pVGpBaW9OTERQVnJ1N3hYSW1jWjJsc3BNajlzWUN3Nk1L?=
 =?utf-8?B?VmxMTkRVbWFzQ2xYdm1hK096YTB2Qm13TXhHSEo1UDNpZjdBb1FReGNRNndv?=
 =?utf-8?B?OFNaNXpNUU1yN1JwZzMyVFdTbGVjRmxqTWZuNjIvQVNHS08wTGRRSjNZaDZ3?=
 =?utf-8?B?ejhpS3Blc1BZVE5ncElSbzlQaUdvTDJYK0RHMll6aWFxVkRjaE56NFRkSTd3?=
 =?utf-8?B?d2RNMkw3K21hejBNZ0p3ZmRhbHdMeHkzRXVyWDl2WDc3RHFkWXNNVXBCbjdo?=
 =?utf-8?B?UUx3ZUtaZGszaW0wT0E4WVlqNUdPL3l1cDVqMEo2a3BhUGtHOUNqeUJ3MUND?=
 =?utf-8?B?U1FVS2hES0FEUjNzRWp6V1BNUDRrMDB3QkxqcUdiVGlBRDZmZ0hhM1lQRHBB?=
 =?utf-8?B?Zmx2SkFIMkp3S1JwUmlBamsxY3RUejBhYUZ6K0JIOElGSWlDQUtTcGkwRENm?=
 =?utf-8?B?dmRsVVVJNE52OERpeTVJT250NjNLaDBoTm0wbk5xNTJHUzhmc0R5U2puZFd1?=
 =?utf-8?B?MzhBN0hjNWl6MGVmOVlmMGhiWmU4MGhROVNiaWwrODFQenFQNjRjRTlGV0xx?=
 =?utf-8?B?enhpZUl4NWlwdEYyTjdnbFFxci9VTExWS1lpdnV2amd2eDhzQ2Jjb3hHWmlJ?=
 =?utf-8?B?OHVjMG44Z3ozYXMxL2F5bnVsWDgzNDNiM25maG9IS05Ydk51c2QvbHZLdEFK?=
 =?utf-8?B?Vm9TWUlsR2dabzQvWGNINzVjd2RVNnFhOVAxWDcvMSt5NDVqRmZXVk1jMGYv?=
 =?utf-8?B?YVIyWWoycEd6azBmOU5lR2NJK3JUeS9vT0I0MVp0Vjl3RTloamhKRVlzbVdC?=
 =?utf-8?B?L3laV1UrKzRvMkdqZU8wNkVGSFdpVlVNbGlBNmh5VC84bzBGNkpNL2F6dktr?=
 =?utf-8?B?MW9iaHZlaG0zMG93dWFnV2VEMXdyMjdCUDhsQm1td2NIbjlwcDVhWTQ1dGpz?=
 =?utf-8?B?bmgxSXZXVHZFSEs5alBKQXVuTmVBaFYrZEtqbThxWmdtRVl5TGxhMUVkV2hv?=
 =?utf-8?B?bDlZRUpoRVpWdURaNUJXNmJlVlZlTzN4WlJJdWxUVzZSNmVYeWdZdDhoS25U?=
 =?utf-8?B?ZHgyblR5Q2EzcTJSNmVycTdVaUxQT01iNjFRbzBXT0x0ck5lR096cVRuZHh3?=
 =?utf-8?B?TmN2cklwV245MGIzanFyckRBQVhtN0ZQNDA0MlBUZkYwTXRQVVJLTUIveUQx?=
 =?utf-8?B?dUNVTjJ5Rm5ScGhrUThFSGU3N1A4by9uU3hhc3R3SldHY0s3amdnTnZrZGFG?=
 =?utf-8?B?TWMvRG5wQUNVQTluZUFtbTVndGlhR3dWZ2tGb1RZd2ZHaUVFQnB1TWxrRGE4?=
 =?utf-8?B?QkpzUkUvTm9ZZFllSVlLekdoZzFJWFZmS2dRa1J4NWtFMklKK3FjUTIwR2J1?=
 =?utf-8?B?SjF5SnUrQTJIRmdmUDN5RXROYWU0MUtKK2prZDNjRWptMG9RcXgwYXNaaTg2?=
 =?utf-8?B?aENRRzNoM09nV28zU1h3WEt6MGRtQXRGR2ZWTHp5dWtBOUNaQWVQamczU0I0?=
 =?utf-8?B?Sm91VFRWVHc1SjZ6Y3grWjIyNDg1VldPZWc0WmJnUjVITjNJVENBcUdiTkln?=
 =?utf-8?B?dk1KZlYybkdGYjV4SnpxVnpUZS8rNUJIMmhLdHgrMjN0TWQzdVhONS8vNU5u?=
 =?utf-8?B?MHBiU0hKemFicXZNbDFtc29NajR3am1OOURoRi8vR3hBcm1wck42aDZRSVFR?=
 =?utf-8?B?M2FFMERWakxob3MxMEVuWmxtSWR2QTJ5MnhMcUFDQlhyVzNNSTFjSkhGY1FJ?=
 =?utf-8?B?T2dEYmZEWTcyazZoWEcyUG9ELy9OTXFQeE40ZjdMSHRaRVVMajdLcUEyY0VO?=
 =?utf-8?B?QjZpU2JZMHkyN2Z6T3l3YkhVZTlCeTVLS1RPNmpOQW4zRkZxQ2d5MzBOdGdl?=
 =?utf-8?B?bzJnL0RNOGJKNlNqY3gwWkg2QWxRTmdsMUhmTjhLaXdQNVJwVERCaTZneG5x?=
 =?utf-8?B?NURnd29ZeW1vaCtYek84VGJNZXQwZnl3aWV6Tk5CeTloVGsyTVU5OElVRndD?=
 =?utf-8?B?ZzlIMlAwemFra2ZhekRIOXlPSGt3PT0=?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9P+JGOx02UyLSOByZ+dJJPEhyBtiOl0ByxNPb3bxPWxPyxZfJOEoZeZm7Mbk8ydK5Boaa97Pw3kr+NMOPSRFiBvsipGcI3+e6q1NslyebBwzHu/S4Yqq6pxbbsqXzl1Sa5yu/KrhYpyYs5F7yMCobnHjQu4Ix39y8Ol66sFiNUnAooRCLH5f5F7I/s8U5oqDYFX/ZRdFd+/BfZMMOBMfVeNJQWYZbpOjoZE+J7r7nrHQIq9L6uRQqH0v3Tro0cWiKutrgWhWid0VcXDVX4S9IWGLNlZM7ZGjXTjw5qJG6c6RJT8c52wiA5AXN0ptEANB4lS4Lh7hiCWH5GW+jVh0uJiPOg0Ac6IgDShcKfYrX8/++M5CIXPaXvDvav7XICsWcjAW7nCdWrevuLY2hyoR7//S86Qty8BUJ6z0cqXeQ6p45823ojSam0Dm5Fc+VnI70GXnoc5uMAKhXswkC/wnNb+aNCmh7oN60pYKLUQ8D0Mh7jI2BH5AgQhX0N4TRXnBP+81oLm0VbWyg2LrMUlTvYUFp1z3vP3NITz1v73JRfO5iKrWyjpxNu4pIq9/76hNiSTwEr2fP/U3gVsTwz0G4dghDkL0pzvmFtXQ01GAxABkk5xb7ggaZpFpmbuCUku/l5/NAfaLXOeHZLVx+KqqQ9w0EUjHoNttThT5ohlEUc/EvAD7+kM8LdkTsORHvqPE
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 08:49:41.1682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce53dff5-f9dc-4cf4-b006-08de5737af82
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000041.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR10MB9817
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



On 1/8/26 03:16, Marek Vasut wrote:
> Use plain CONFIG_STM32MP15X to discern code which is specific to
> STM32MP15xx in DH STM32MP1 DHSOM board files.
> 
> Signed-off-by: Marek Vasut <marex@nabladev.com>
> ---
> Cc: Antonio Borneo <antonio.borneo@foss.st.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@dh-electronics.com
> Cc: u-boot@lists.denx.de
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
>  board/dhelectronics/dh_stm32mp1/board.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/board/dhelectronics/dh_stm32mp1/board.c b/board/dhelectronics/dh_stm32mp1/board.c
> index 55526189d5a..90590d14941 100644
> --- a/board/dhelectronics/dh_stm32mp1/board.c
> +++ b/board/dhelectronics/dh_stm32mp1/board.c
> @@ -314,7 +314,7 @@ int board_stm32mp1_ddr_config_name_match(struct udevice *dev,
>  			return 0;
>  	}
>  
> -	if (IS_ENABLED(CONFIG_TARGET_DH_STM32MP15X)) {
> +	if (IS_ENABLED(CONFIG_STM32MP15X)) {
>  		if (ddr3code == 1 &&
>  		    !strcmp(name, "st,ddr3l-dhsom-1066-888-bin-g-2x1gb-533mhz"))
>  			return 0;
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
