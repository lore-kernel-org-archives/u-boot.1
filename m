Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281DCE7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 15:26:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C5DB896C8;
	Mon,  9 Dec 2024 16:26:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZBHIMdPK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3AAF896CB; Mon,  9 Dec 2024 16:26:34 +0100 (CET)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::60a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87ED5896AA
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 16:26:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ecuOvHpgPf2sARFqx59usp8YjQ8WhfgTCMT4qqOWovcdv/8+Cfud0XmVWgHM1+pS5q6DXeBpAbu+QwW2nRjml3TT0b0uzh4+G46jTs9H8La7xNuEYWH7Hr0XtnNrbz+5KoT531W3ZKCIThWUcNoLLlwaBIoNQxEEE3IpNcpowDU+P7/k45Mc7gIEI8cV3qBl74NUMUDwAvYW2wxURJdI3aLPbUvYDRr04PtmiaONvRyKQMWfvxF3RAgf7IuzEhzNuKUrWVTLYqsyU6HClNQ/6LhEgB5V2hjsq8L/z3ZBGcG4cOsVR5FhThS8WNIxqt2ZbMLrYBlo2jkIZ62NybaF2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OeIkNRMGe99x1muBm2wDr3tNLTvTvgV8/u8kXwsQ538=;
 b=EHjiKnfvEDCcpYalTNm0DeuFvhwWqanDMAps/UXJ3Z/1cotnCWM22YST4rKkyW0eiMwq1OiQyv77QN0XC/u3DKk+j16SMB1bVaOOxAfweJ/2Vgcc2g8RmXP9LdGWaTOkZOgWhZkgjBUqdUnf/dHoGAwqCGVv+Ill/FulT6vT8CAdeSruinWB9tBQiKDODmkePn1Z+2iYiltewuO6B1OjIjnrl8VLz0jrGUkSjCdSFW1Blqw+TaEO3TbhMjz+J++rvGeY5WsjNUwFQ1V4qmpVfSKW7sAd+nJQC9pWVB+Q8blZAEvdleWiamTfAUNz3b9U4H/NmtCvYZwOKZRCClYxHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OeIkNRMGe99x1muBm2wDr3tNLTvTvgV8/u8kXwsQ538=;
 b=ZBHIMdPKNy+Q1zVTRKHa9AJskv220lk3o0BIUYnjrPcJz0keLizl+rEbxJmvgSLfEvxuUvoD6QdWlgmlIQ6I6WPy+T+cTOD3ll7SKcwnkhvSKIhwnAtPVuqAd3ge2+fp/ZYZLpbK+K5rd5HhMIztcJ4fTSl2mUvpAqhcCd9qMg4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB9125.namprd12.prod.outlook.com (2603:10b6:510:2f4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 15:26:27 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 15:26:26 +0000
Message-ID: <2ee46698-87c9-47e3-8951-41ac3c50331a@amd.com>
Date: Mon, 9 Dec 2024 16:26:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] common: binman: Calling initr_binman() when
 BINMAN_FDT
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, git@xilinx.com, neal.frager@amd.com,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
References: <cover.1730452668.git.michal.simek@amd.com>
 <f79dc1fbf796dd5ad290f6080608ee68d7652cfc.1730452668.git.michal.simek@amd.com>
 <CAFLszTiWOdsS8=pm7aSvyC2QYiXbbsciz2yb6s9YPV1FeFFrgg@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CAFLszTiWOdsS8=pm7aSvyC2QYiXbbsciz2yb6s9YPV1FeFFrgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0065.eurprd04.prod.outlook.com
 (2603:10a6:802:2::36) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB9125:EE_
X-MS-Office365-Filtering-Correlation-Id: cd193f22-90b1-47a9-fec5-08dd1865d8e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RERDL3B0bkpteWU2ZG1uV2FlMmZIazM0MXZUMmJiTUt4d2JtVUJPcGpqaEZB?=
 =?utf-8?B?YitvOTV5bnNRbi85S3NIQ0Y5UWVKUVpyNi9XZmJGcjVWMVFlUVE4d0hZODFZ?=
 =?utf-8?B?M3REUmJCcURjVFV6OHBXSFBVT0UyNGdTc1liQVpNOXRNSmIwcWpud3pTQnNP?=
 =?utf-8?B?NElCS05wU0NzQ0xKelo4Z1VieHBwZ3N0SDNjYVJjajA1UHVrOU1LbGNUUUR6?=
 =?utf-8?B?eVJWSExwczFSdU5ZYXVCa0pqY2pYY1JGU05ocU1vVU1RSHFlZHhOQVVobmsr?=
 =?utf-8?B?ZzRFMEJOd0tOcHpUSlVIMVFtVTNRM3dtUU5XTjZEejFXVWY5bVU5VjZKbGlk?=
 =?utf-8?B?ZzlrSjNTM2FOcWpXdHZLWUNLcnVrakQ1eFJ4NWl2dUxVK1o0NXduYjdWRWE2?=
 =?utf-8?B?ZjRJb3hZUkZLRUt3T2FoNSsyNXBlL3htdG5qWUs5T2tCbldScTF6aWRDR2R1?=
 =?utf-8?B?Rk42dXdsVUR6Z2F4YWxlU2lUc0ptTU5QUWdIRlY1N0ErOFVoYUlwWW00R2o5?=
 =?utf-8?B?UXhIQnFOMzNGYzltTW8yZUxKMGtVRWl5a0dsVXlSV0t3bVR1d3NVUXhrUGJN?=
 =?utf-8?B?cVFyWlNXTWlVQklaRkE1Y2lJSmdEaEJzelNxa1dxN3dFVEFrVDF3N2FGOXNL?=
 =?utf-8?B?SFNTRnNWVE9YNnczOW50T21URFpuOXBVcllUdUxZcWlrdWpjWUhVdzdVbmo2?=
 =?utf-8?B?VWoyN0l5dTBGb3o5a2g2d0FlSVdRVmZWNktTbFFXZWVqcUVzOUxjdWo3c3dP?=
 =?utf-8?B?dEs5TVA2Skx3R3FGeXNhU1J3OWx6WDhUTjgrWnFlR0FFdjd3R2M0NmlQdEFn?=
 =?utf-8?B?T0ptdzlmRUhBZUxMa1hWOEEvVDBlWjdkZmVRK2owS1ovRlZmekZZSWtENHBJ?=
 =?utf-8?B?WDJkQzFWL00wY1lhN2ZXZDFmSTNEdk1uTFl6SC9aN3ppeXZWWW5MMnhtN1g2?=
 =?utf-8?B?blhZM2JwWGZJR1lRZmwydGdENTdvUEw2eldXc1JSVThQekIwRWg2MStRZkZm?=
 =?utf-8?B?dHNRQ2M3VkVsYStqT3R5cnlUejNKT2lvMU4rUGRvb3l2QlV1eTFkcEJ2ZGRH?=
 =?utf-8?B?dkEraVVySlJPOXYvbXJ6bWdwanRTQUZmV1lIZHNXVUFUdWNrbWN5VlZmN0Zh?=
 =?utf-8?B?Q0ZackNTVmRFR3BLL3BqRDBNejcvUytCSjFiWllyZGcxTFFSTjRpU3pGR081?=
 =?utf-8?B?UW4xUC9rUE1ZM3BLV0tWdW9TTDA3VnN2WW9PODNsTXdkU0VQb3FEeEh0VEpV?=
 =?utf-8?B?bmlEbXhtdmtEQXh0ZC9hSTlPaFBobThHQysvT0RqSkl5cFA4QWQ0MFNpWXJ1?=
 =?utf-8?B?VmhJeU5odmg4UXlkSVdaaTZWRVIxRmhzbWxSUGxZNC96VndSM2lIOG9CZG1t?=
 =?utf-8?B?ZXV3NVpxT2FkTTRoVzkveHk2VC96TmkwVS9yTmpLUWJPQmhIWUtqWGZCQUVS?=
 =?utf-8?B?KzBKd0h6aFhpWGFrbmp1YjliQ1cySW4wSkpqWDN6N1E5MXdnNS9IdDkwcGFS?=
 =?utf-8?B?S3RVSjduZDdHbHQ4YVQ1Q3pacHVzYVRSd3piNVZDcVcwK1dkSVMvYXE3c3ZP?=
 =?utf-8?B?N1hSVk5LaitCNGRFWG5hbVBTZGx6VHBVT21td3VreHhBakJIaTNVOFRqdGNy?=
 =?utf-8?B?bUhQaFVoeVMvZGhMQ2FRZnlqQ2MwVkZHQnVIMmtBd2tBY2ZsMEpOQjhva3pa?=
 =?utf-8?B?cVhZNjJONHRaSmlVWFM2S1JqSTNTSWJ6bExkUVVtQUJ3aXNuRy9PK1QvN1VT?=
 =?utf-8?B?bzFxTkxjZWxMOC81Z2M1ZERhVGlzMDVVTStLU2xNaENSV2VDcjlublVJV1RI?=
 =?utf-8?B?TUhqU09mNHgwaEp0NXNmdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekpWeU5VemVjUkU5b2o3SVhpOHVnSlRQd25hdGVyQVNkRlhFZDJPdWlKL1J3?=
 =?utf-8?B?Q1V0WXlXTllqSStiTDRjYzVoMk1KZlJLZENGdDhrcWxVc1QyTEpxWWJReFQ4?=
 =?utf-8?B?dlRiZlJSbEwrL2IvK2FJTjVBbm9LSi9jZEdDaDdLUXcyYUhvWnIxRUJwRFk4?=
 =?utf-8?B?TStvM0xobjFOSXhuVWsvbzNwU0ZTbkpFeHB5MGZvQlJQejFJZlVPbnA0YnVB?=
 =?utf-8?B?Y3Y1c0NhZURmZ0MwelkzcnV5RnlxdGpuUGxkQk85NG1RU1pQVzYySjB1NG5z?=
 =?utf-8?B?NmRzL3hWcWpDSDNheFZGbmZCeW82WURKd3YrenR3MmU1TVRKQW9nUUxUakFS?=
 =?utf-8?B?TlZVUVI5ck1ZMDNsR0R1a0dLcEJXUDlyNitOckhPSVZrenBtQXgyVmN5TEpS?=
 =?utf-8?B?cWZpdDhteDhOR3ZFWG85OU1heEtLRkhqMnlmalYyNU0ybFVSbHU0SUp5eXJB?=
 =?utf-8?B?T2Z6VG5zR0FPTlc0Z0FPR3NrOExYdTZ0cWtrWGpRTXYzUFdQbkp4ZGVWQVZ0?=
 =?utf-8?B?SWxDSVNxajE0c1pVTlc5bzVMaVdnVHdZb3N2bDh1cXdFd2VkMW5PcnBhL2tO?=
 =?utf-8?B?ZUZKNWNIN1ZDTkwwZ3BzVzByWTFZd0R6QmdnYURPK3RTSWdOSDVWN2syMmxM?=
 =?utf-8?B?aWlpdkxtVXduaFRxaXh1WGxoWGNsMVE5T0ljTnZseHVIKzNSV2hIN2wvMmZn?=
 =?utf-8?B?QVJaY0duVmUvZU5ITjBRazV3a1hvWkZhSTVPamNuS0lYdDhJRUhmUG81K1F6?=
 =?utf-8?B?S051eTlNdkVKaXFXVHJqV29sNnVTN0hoeVV0NEluU1VlaHZLTmk4RkpHUEJx?=
 =?utf-8?B?c0ZMelgrbWVmRE53T0lReE56K2Vtdm4weVN4Ty9jTnpYZkZxRlphVThiMThp?=
 =?utf-8?B?TE5WMkZ6TWJ6dHRLdmtmUXM5YUs3bWRGYitQd1hMeGlyYUxLUzVzaDFVUXlN?=
 =?utf-8?B?MTl5WnFMWjhXdXNPYkxtZThzNkF2R3l6QWUwNjFCU1pkczYwOGhvUTB3S1A4?=
 =?utf-8?B?Z1VuOXQvZERCaDQ5cFhvalBibGZ0aWlyS2I5a2dXNkxXblBkM3JMZ05mYnhP?=
 =?utf-8?B?RzUzalFUd3lJS3U4Sjd5REVXSXlZMFJGSHlGWEo0WElZTkw4VFQ3WGt4TFBB?=
 =?utf-8?B?VzV5Sm9INGIwQVVlMUk5TXBObUxHK2lHdnpOaE1vTlh5cjdwVWlSdWRrZS9O?=
 =?utf-8?B?eitCTGZOdWpoZS9Xb1BSZk5tMjVnTE9nUTFxSmtpWTg3T1d2eXlTaWVKUzZB?=
 =?utf-8?B?b04yRmJlVStoN3RzQ2JiMFlhU1RQM0tEandQYnF2aWVkR1FOSGUveTRrRy9S?=
 =?utf-8?B?ZUtWSUx1NTlsYklBNDlralFZekkvUGo4NHNDa2tvSWllZ21meDVkTlV4bkdQ?=
 =?utf-8?B?cTJjQWJJOUtjYm9qcnhyOG9OVkZYd3AycnhoQ3pSRU9pbyt2QjFDUkF1emxP?=
 =?utf-8?B?WFBGZVdQTFJxdDkySnVJU1h2MXZPN1lyeWZTOVk2Ym1hVWs2WEpKT0pTdnZK?=
 =?utf-8?B?Z3FUL2hBbW1DY0k4cDBHL3dEbXNzd1Y0aUNMT1pVZ2NlN3l1RWFQQ1NoSFFJ?=
 =?utf-8?B?SG5vd0NPM3liNDVrZEppeVlsRkUzRGhnMTBxQnJCNVh3c04yMkU1eVVDblRl?=
 =?utf-8?B?bmR5RlRITnNrMTYxWEllaWJ4NWtPMEl3V0JmZVRPUHBjdEdUTjhLTHZ2ZER4?=
 =?utf-8?B?dTltUjI4SlRqaG1HSUUzNUJrRHVUSkt1blFReDlVWkdqalJXd3BOQkZhQmN4?=
 =?utf-8?B?SklwU1lUdmRZWkJYdm9VdjZLTXNnb0lNV2VUUmZJem5rd0dQbVA2bTI3UEtN?=
 =?utf-8?B?a08xN1pTbVpSRzdKd2h3VDZzTU9JY3NjZmhuVFBPRWZVWEhGOEFTVUVRaEw3?=
 =?utf-8?B?S05EVDJQTFdSUWRRUGRDT01OeFE4QXpkWDk1RHJqU2ZaRHdmRkg1TWpZZ21q?=
 =?utf-8?B?L0ZqU1V1eFVqVyt1ZUhCSXJpYTlMSnZ5Z3dyR2psMnRhemtYZjRVN0czUXBV?=
 =?utf-8?B?YWNVcHVsa3hUYUNSODY3cmE5ZXpkaWtqTFFUZlpIUkNDNGhVeENoVEhQNGx6?=
 =?utf-8?B?ZndDdXZybkIycWhHU2ZRMUJmUHArRkJUcGlyVGwxSVEyK1FjclVLNVp5b3Bk?=
 =?utf-8?Q?onmKDMTVdYOR4vOBZAFJ1kFOs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd193f22-90b1-47a9-fec5-08dd1865d8e7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 15:26:26.8941 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 32fMSmOiNbGq8ohw1Cl2td384cdDoKQ948jYHpGD5/CT1LF1kdXk4YIvXikmbJy/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9125
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



On 12/6/24 20:20, Simon Glass wrote:
> On Fri, 1 Nov 2024 at 03:18, Michal Simek <michal.simek@amd.com> wrote:
>>
>> Calling empty function when BINMAN_FDT is adding +64B for nothing which is
>> not helping on size sensitive configurations as Xilinx mini configurations.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>> Changes in v2:
>> - new patch
>>
>>  From my perspective there is no reason to call empty function. It is just
>> increase footprint for nothing and we are not far from that limit now.
>>
>> ---
>>   common/board_r.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> This is a bit odd, though. Do you have LTO enabled?
> 

yes LTO is enabled. And there are other candidates like this.
Is LTO able to fix function arrays which is calling empty function?

(without this patch)

00000000fffc0eb4 <initr_of_live>:
     fffc0eb4:   52800000        mov     w0, #0x0                        // #0
     fffc0eb8:   d65f03c0        ret

00000000fffc0ebc <initr_dm_devices>:
     fffc0ebc:   52800000        mov     w0, #0x0                        // #0
     fffc0ec0:   d65f03c0        ret

00000000fffc0ec4 <initr_bootstage>:
     fffc0ec4:   52800000        mov     w0, #0x0                        // #0
     fffc0ec8:   d65f03c0        ret

00000000fffc0ecc <power_init_board>:
     fffc0ecc:   52800000        mov     w0, #0x0                        // #0
     fffc0ed0:   d65f03c0        ret

00000000fffc0ed4 <initr_announce>:
     fffc0ed4:   52800000        mov     w0, #0x0                        // #0
     fffc0ed8:   d65f03c0        ret

00000000fffc0edc <initr_binman>:
     fffc0edc:   52800000        mov     w0, #0x0                        // #0
     fffc0ee0:   d65f03c0        ret

00000000fffc0ee4 <initr_status_led>:
     fffc0ee4:   52800000        mov     w0, #0x0                        // #0
     fffc0ee8:   d65f03c0        ret

00000000fffc0eec <initr_boot_led_blink>:
     fffc0eec:   52800000        mov     w0, #0x0                        // #0
     fffc0ef0:   d65f03c0        ret

00000000fffc0ef4 <initr_boot_led_on>:
     fffc0ef4:   52800000        mov     w0, #0x0                        // #0
     fffc0ef8:   d65f03c0        ret

00000000fffc0efc <initr_lmb>:
     fffc0efc:   52800000        mov     w0, #0x0                        // #0
     fffc0f00:   d65f03c0        ret


thanks,
Michal
