Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FFCDCCFA1A
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 12:38:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6E3383A79;
	Tue, 11 Nov 2025 13:38:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="BxNXi218";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D554E83B7E; Tue, 11 Nov 2025 13:38:18 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C12838334F
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 13:38:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HW1dLrMD4Om9BdqCRNGkWTHWeMfOpl6+npu4jXT9JF6cr9vKKlKa2e8oTDMjjuse5XyDAjndIAbT71ThDihJix6fs6bYmHy6xVxE6lmsfcQFgDGJmOfZEzMdJn2dp3yr/AkO7A+klCTe/NT87WcZZI8Aga8uBw/FJ0s6ew88j4aPy2ywFAfpG0qkGOqWjmNoLhcqxvIz+EbRI3fH6V0Gy0YhclmhpiCmzs33NGNiK4Whse319pr/4U7eWqaVyJprhJ5Z45E6PZ8yLWjDiTIKNbY8NEJei/kPy9p7cPufLjzStdO0pvODf1iFCdl+GuPLf7A7alLVokdLTAWPozw5VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBYjr5/9KZYRzt4YplvPtVJEa7Y5kP7UjqEJIlYsEnk=;
 b=AJBsSFu56HsPq+Hp2zxui9wjK3zPgNAfWGEp6NCUqvf2Oxk7MG4uitTj0nnU1QG0VVv+2ib6sQmfWnSUc2NNSR/kRi4Pkxk+kqwW+KhxCGLPGDM/MDl5iPnW96cAKdC2lgMd8NLTyKKCJ0D/JQeGcTCcsY+zux2bWZ1pH5oOAZ+zLGy5Y1PIr9fhUm+BRsgKGZt7TcDX5yubqoicdyHQ+M/YvORP2gquhWzVbkOfan+CFDpTBBq0wEdLNB5z/+xD1GQ62XJhFViDSGeKHMUDPj4EiZ/Tize4BZsarnNmygNGZPwfSli2PDk00XG/pBZ3AozGMNnI+cToKsrdwxqaiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBYjr5/9KZYRzt4YplvPtVJEa7Y5kP7UjqEJIlYsEnk=;
 b=BxNXi218JYYIhCkcdmdS1Oo2YAKJe7yQGa/VV5OiYgdR8wFeMUvj9rsNYNDEn1jJGSNDlBBfpB0Fjm4z2XMydzjzjVA6aMyWqt8ieYFm6shujWAQNA5fPEB2zJ9Y0N0WAiKxGlRNMZox3hHywQbFVB7T0RxWW2ySIgjb/fQ9XQT5Up6MnTM0neUEDZcHu+13Fv4osPgirP6YpeOObsb24zpQvTGiydIeUAejyKFueM8rBNI2vZMGspyDoq27HQTy+JLvu4Bhg6+1ZoZaVtI4inRnhaOYJUbnTmQL5m/li3Fo/ysOn9hodXwK/a1NOJc8wyEBjP+Fx3w+/Iq2nfMhUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by AM0PR10MB3649.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 12:38:14 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6d2d:1b1:a857:461e]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6d2d:1b1:a857:461e%5]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 12:38:14 +0000
Message-ID: <ae7084f3-9df8-4e69-ad6f-5e80df9e4237@kontron.de>
Date: Tue, 11 Nov 2025 13:38:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm64: dts: imx8mp-kontron: Fix USB OTG role switching
To: Fabio Estevam <festevam@gmail.com>, Frieder Schrempf <frieder@fris.de>,
 Tom Rini <trini@konsulko.com>
Cc: Stefano Babic <sbabic@nabladev.com>, Sumit Garg <sumit.garg@kernel.org>,
 u-boot@lists.denx.de, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>
References: <20251111102904.157931-1-frieder@fris.de>
 <20251111102904.157931-3-frieder@fris.de>
 <CAOMZO5Do9AdqZ+j4Kpp8qU21mQ6yBNuvi614n_Q4-Uzebf16eg@mail.gmail.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <CAOMZO5Do9AdqZ+j4Kpp8qU21mQ6yBNuvi614n_Q4-Uzebf16eg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::6) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|AM0PR10MB3649:EE_
X-MS-Office365-Filtering-Correlation-Id: fa79a9e6-c336-4e00-b665-08de211f2e53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHlLUjEvTE00bHBqK2JIQmlsSkxDcGVFM0xsRi9BTk9pU1RwTEsra0IxQ3Vx?=
 =?utf-8?B?N2hvSGlWNGhlb3hDN2RqYXJzYmNFMjFxa2xtalkzZTJmaUxzSWFXZG85TGFt?=
 =?utf-8?B?OUJFWWtEWjRJWXV6NVUwclhCSmpqMlR1ZDZ2cnBjcXJiQXJKL1E4NzdlampB?=
 =?utf-8?B?eSttMXRaUVRKUVBsSkwyMG9YR0RvSTdncjV0V2psR0xvNXJDWkRHVVFHdDFO?=
 =?utf-8?B?bHM4bVJkQmFpbmpzbFFZOGx6SWM4UHNHUkE5QzVXLzIvL3JpWDhwM0dDcGJX?=
 =?utf-8?B?L1YrTzVYZnZLM1ZwREJCTEJIMlFtVFdJRU5yN0pKcjdyOURFTGVtcnNKQXBo?=
 =?utf-8?B?dkY3VkhjK04xNHpnRzNiTDVhMVkxdlhrbzBGU0FZTlhDUm0yYTJTbEVXb2xt?=
 =?utf-8?B?bi94V1J2V3hENFV0MTRkNk1JVFV3QUJUcVE1UEJVbFJSRnk2Y3gzVVRQaTlP?=
 =?utf-8?B?YitLM3NYK3RmU3FzZEFNemlZaGIzcHo2MWNpU0VwZ080Q0tLaUlLSGN3Z1Yv?=
 =?utf-8?B?NHRKYk54bkd3dXpZOTRtTkd5NXdLYzIyMzY3QisvUWhEOGQyOXp3YUlQeWV1?=
 =?utf-8?B?VWRyYnQ3V0xPNDhxdG5LOTFtYklpazBhOU1MbTEvWm11RzYrNVBnd20wVTYz?=
 =?utf-8?B?aFdVcGdUNys1SkhLWVduUWFnaFMxeGpUazBBbEJOUHJQZUN3dGZ4ZVhDQkVP?=
 =?utf-8?B?dkFRRFphRUpENUdqUi9LL3dDRzNYMUJXVEI0aFdjNWlWbXo5d2V1OENtV0xN?=
 =?utf-8?B?RFozOUFPQ3RiaE8yZXo4WWVpUDNXUnhmTW1pVXFLSVFCc0JXOCswZHhaM0w2?=
 =?utf-8?B?aE8za3dSN2N6b0tCQnNQcENxY2djSUhncjEvZnFRZ2NXdzZJWGpvNjZsY0FT?=
 =?utf-8?B?RzMvUnc5SFo2amNlbm9xMjU0WDJZQTdFdVFWdUJjMXFDVlRVeE5uM1JPcXVs?=
 =?utf-8?B?TXc1WlVOb2F2VVZoQnkvT09Odi83UEtnV3NVQStrVkxiMVNQMnR2MU5ld3Nx?=
 =?utf-8?B?R0k0WmgrRHM5Rnlod1BsMzNTSmpPQ2gwemtTbTBLeEpNdllFYlpQVUpSQmlK?=
 =?utf-8?B?MFJUaXIwT0k3dU9PSThreEtpbkNYaTFRUzFEU0dnTmUwTWYzWW1oZ2orVG1O?=
 =?utf-8?B?SFFzTzJlNVlzZE9wSmpCVWJwenlwYzh5eXJwRFUvSDAva0JkWDhaamNzZGZo?=
 =?utf-8?B?enNtem16WExIeDlDMjRkMGJTd2ltb3h6d3krSXpzRGtHdGdVTlRsN2ZOZnVB?=
 =?utf-8?B?cWl2b1dGL21SNnZTMEoveGM5WkZoOWpZY3JoQUFRUEZZQmdialB6SzlDcXMv?=
 =?utf-8?B?MkVJYnc2NlZ5Q0M2aktMYlJPZCtrRWQwdGpWQ2VEeTNpampvcDQvSmliSVVI?=
 =?utf-8?B?TkJKT1lHYmFmK1VFSFJaVVpYaXlIdkpuTWZyUFF6aHJXcWNrMnQ5MUlkZ0NM?=
 =?utf-8?B?Y2xiempZVnJ5TmovM3lFTzIrN1R0NGlzZVdCN2xNWFNyTmtjWnhnZW52SjJ2?=
 =?utf-8?B?T25OY3BOeG44M2dPQzd3SlVLVWMzeFB6bDVud083NjRGMnFUeFdMMENtY0Y1?=
 =?utf-8?B?OEdJem1yZVJLVWdiSGF3V2JxTWswTnBvWWtCRHkwOWRyQUFCa1MySmtPOVQ0?=
 =?utf-8?B?aVhmRElyTkdxR3NINXZXWHN2eDlQN3BLVEZ4UFZwTkNvRytOL2tqcUY2eEZ4?=
 =?utf-8?B?Z3UwOEQ2WDN4TTM4L1RENzdrRjJWMXI1SXRuSVR2QkJuTHlSRGlGQ2o2WlhG?=
 =?utf-8?B?djVkL1VxN0Q1V2RiWGg2WUZpTSttb3lLRzI2VnhiSzQ5TENFdExHRkJ6bXky?=
 =?utf-8?B?NTUvOFR1bms3VzVkM1A3N3dyTkZ3MldUM2lPbTFySGxUeXo0TTdjYW1QM3dD?=
 =?utf-8?B?aU5oMWM1U1ZGMnB5K2c2Rm5yUjZDKzhwcEIxS3ErYkkrZWsxbHJnVGlacnZy?=
 =?utf-8?Q?49oV1lfQrwwUvinwtdnnWSg6CUvQbKyF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTVObGNiWlA4YjdlcjgyVlR2WFowVkdHRnpXb1ZxU3RFNDUyd1hscGViaDkr?=
 =?utf-8?B?ckpZVllpR2d0VXNWQXJaaklUSHBPdGVua2ZPNjZLZmg5YStHcHFpcHk5SlNF?=
 =?utf-8?B?dkhNWTVmZUdSL0N4REdQVSsxYm5vZHpKdENrRHRnYUNObGFzaVNwZ290OHpN?=
 =?utf-8?B?RmV6RVlzWFByL1BQT2dzMkNnc1FFdjBPTzVQb1ZrR3pjL2ErVGFQSlZDb1VZ?=
 =?utf-8?B?MGNvbzVhT00xY2pHZlVLeGhtYjNMYnZLNWg0WW5iODVEUlZKMHBjejZyWTcy?=
 =?utf-8?B?YllwRkhHZGplSjN0OVhyWkQrMGJKR2d3WitGSXBtbmhobGorU1ZvVkt0L0k3?=
 =?utf-8?B?TWEyYVd2ekU4dWdvdWRoUnZaYTZ0Ui9wbW1Sa01iMVpVaTREbVpVeFdUNnk1?=
 =?utf-8?B?ZFJJL0dGZmJFODNXS1FWRnlpS1dwYXBjemhBZnhKekRZY3lrVjVQY0czalZi?=
 =?utf-8?B?TXN5eEhWS0k5NG0wMnVvOVlwNmRQWS95WENoSC91ajVmRjRTQkR2TjFUdFlB?=
 =?utf-8?B?VzNQazVFZzhBWEpZb2dMVWdQZUdSdC9vQ3Fja0kvNWhOTzFUaGYzaUM4aU1S?=
 =?utf-8?B?c21oZXpJT29wTEZDdzViSHRFZmVMdURGczBtVFNKRTlsQkY3SmRkZ3gvWXBW?=
 =?utf-8?B?b3pZMXVvUlNHSm4zZEpPaW9oUmtDZ25ZZnRYd1JNb0hsaXFyaTNVUEsxMU16?=
 =?utf-8?B?ZlNiUFlFamdiSDdGM3FaYkhmd3BCN1RySGlhWmhXSFRMRVF1UjBmaHlMM2I1?=
 =?utf-8?B?ZEFuSW9qVkMrT3F2SysrY2hXY1NkVFBlQS9BaXBvOTRwRVI0YzR1eDBkeTJ0?=
 =?utf-8?B?VUN5aTNPNDZpL1BVcm96Rm1nS0lob0M0U0lnc0JMUEdaTlpWaEpsdDBJZEYr?=
 =?utf-8?B?MmNtWmR1MUFKbHJMTlQyMnV4ZWpDSUFvQTVqeTdUTFF1UVFWNFdEKzlRWGFv?=
 =?utf-8?B?YVNIWHdJeHJyenRZQmdTVEl6T09hQ0w5WVBWYUU1V3g1MVNVbCtOQTArZWE3?=
 =?utf-8?B?SzFJUDJydno5NDFKbnNlanhRTUUwcEtEZnhIWW1uZXkvOS9YV3VXMTdLUE55?=
 =?utf-8?B?Yy9hN1F3cFJLK2E3MGU3dE5WTWZqenp4TnRDNVU1OWt6ck1mMU9ZbXJ6SXBN?=
 =?utf-8?B?M2x5Y3gvTTBpcXh6MjlndmZYNUg2TjQ4VDBFVElSOUZTNEVnbDZPMDlqT21Q?=
 =?utf-8?B?a3F4WVJtTnM5QmJlVkIrK2h3aFFQM2NFNmZxSlZSaEZzR1hRNFNpTUJBRnBj?=
 =?utf-8?B?VFFIYzZwcDhITFdaSG5CVUNRT1A1YVliaHp0MHRQTnNuM05xOHZhYUUvQkJh?=
 =?utf-8?B?RFk3clpvY1ZJMDJHc09CcWUzMml4QTNwNSt2NXVrd1hrMDFsOTROekFuSGI3?=
 =?utf-8?B?YkVOZG05VmdSTEpCeStNODNwYWdIS3hBallRcXAzVFNoS2gxQm5NWW1KakRp?=
 =?utf-8?B?Z3NzWGZ0UUtla2NqQW9WVEcrT0xKaTN4VW9ONGtON2x4S2Rma1FVSVY5WE01?=
 =?utf-8?B?ZytWeGIwZXZsZGxUbVQwNkcwM2ZsWEFlVmttZ3dCRUkrVzZoUmgwNlNMaGhN?=
 =?utf-8?B?emE5d3RzYlkxdE1paTU2cmtJUW81Z2JkUDhFVFZ1M2MvdUV6czd1bmI2KzIz?=
 =?utf-8?B?MUhNYzdmOTNVcTRhWTFvVzZUbUlJUktpZnBrdjFvWVp3R29ZSWY4elN5c0k4?=
 =?utf-8?B?TVJ2eDhBVTVRck43QkZEdnVtSXg3RmtmZWNodDYrM2Z6Z1FPQ05zdWx3cFRQ?=
 =?utf-8?B?SHZJTmlaU3pqK1ZwUTd1V0VMcVZGd1NDbEdjVFZ3dVovTlBUWitkSzJpMnY5?=
 =?utf-8?B?Q0lWQWZ6ZWYycW9RTUM2RXRMSzVIWWRBSUtVRHZDSzhTR0Foc1dHbGRESXU5?=
 =?utf-8?B?djdzS1BRUTZES0gvZlM5bk00YUtTSHdmVXhvREpIallaN0NBUkpmTlNnQVRa?=
 =?utf-8?B?WmlRL0JGUzBQVFduZjN0alpQbEo0SisrUnhhSXNVcFFma3crSVJOMkw4ZUQv?=
 =?utf-8?B?dXZtc2JzQ3A1ZW5CUHRLWFBSK3Znd09VaDZ1djF6R29TUkpmSFJBR0haMUxF?=
 =?utf-8?B?S1YrNm51R1BsbEVRdy9kL0NTdkdkWkk3UzEwL1Bjck9LN0VNS1N4V0RBRHVT?=
 =?utf-8?B?clNjSy9SYmdsWE9JK0RKSUh3OGtzNGJ4YkJqRHNBcGpNTUJKdWk3MlZxYk9D?=
 =?utf-8?B?bHc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fa79a9e6-c336-4e00-b665-08de211f2e53
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 12:38:13.9981 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1KgsFywuBP2af6nQFbwGP0l4f8Dt+MY1xEsEc6bIBTXShC/QvSHte0tDpoO3HbDJaqcG8e6PlnWVvFmqGvcMnfIH47H/mGQMalblGLW958A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3649
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

Am 11.11.25 um 13:20 schrieb Fabio Estevam:
> Hi Frieder,
> 
> On Tue, Nov 11, 2025 at 7:31 AM Frieder Schrempf <frieder@fris.de> wrote:
>>
>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>
>> The VBUS supply regulator is currently assigned to the PHY node.
>> This causes the VBUS to be always on, even when the controller
>> needs to be switched to peripheral mode.
>>
>> Fix the OTG role switching by adding a connector node and moving
>> the VBUS supply regulator to that node. This way the VBUS gets
>> correctly switched according to the current role.
>>
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>> Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> 
> Is this an upstream kernel commit? If so, please mention the commit ID.

This is picked from current linux-next. I just removed the Fixes tag,
because my checkpatch and get_maintainers were complaining as they
couldn't find the commit hash in the U-Boot tree.

> 
> Tom,
> 
> Should we patch dts/upstream/src or modify the -u-boot.dtsi until the
> fix lands upstream
Both would be fine for me. If applying to dts/upstream/src is not
desired, even dropping this for now and waiting for the next sync would
be okay, I think.
