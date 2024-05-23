Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02680C25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 14:51:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76D9187FC7;
	Thu, 23 May 2024 16:51:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="iwFIshQB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1AE2884C9; Thu, 23 May 2024 16:51:48 +0200 (CEST)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on070f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1e::70f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8FD387E83
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 16:51:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1I/nUsOElclKSB1joVwNNPVGYYUyQ5oXb/NwXm1WskZHofUPNsHLli/yNMQDGcBoBOk/e9EGQn0eSjfpEUFZyxrsbdH63nBdHjdQ4gq7c35tngsmyLgtrereI9FPXqpfilrP8ZmoM0QwSrrL5JhI2HUKxsctvUumDDKeH3e0G6g5uf2MQ+y2JEvMHJaSFGZJb3xG12Xk6zf/bHqoMykdRXgJDbWnK97Z2e+ThEDnN3TRCInRKN/xhZHf0LRd6+gFo762tsDFpMkNDOdxMp6HCWP1bCbhiJYqW0Tijor86RsyCt7UYCaBz84Igg1snFK2CCct46vWgUj2TPMnsfR1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tP5bYzQVw/1/jqppIcWaln4mqRLy5cWm4ghUMWuauyA=;
 b=nYcaKfTCQkGQBHMBmaYoQdGTfl6YMEH4+bsiI4cV+ePWweJSTIcgukhREr2EY5kMtL9bDJKJB0NfseiA+Bo7B8sqQLsKTx12PNEyxYUGJohJNuBnCAjyfHzN0y9frw6rVR/nfaLGg1Y52fMANZBXCnCPXWZYpo/m6hjVDloQOE+huIlC+JULar+jfUFUkBCxTyoyLu0tIeIeERZ154IDKACO4oV9H1qRoItlwRfvkoGy7pgMZmxTZlTql7TZnh+RuhKgLADkb6ZvZfz/pgiCQ1/wBU9kb4Q+lL1dpN+9fOEFwV/DsS9mxdzYkGl1Hvz7KFlSGgbp2YckJ0BO0H+qQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tP5bYzQVw/1/jqppIcWaln4mqRLy5cWm4ghUMWuauyA=;
 b=iwFIshQB/cL3bViEiQlml6aqYG68bfIho/vA2zzK/iDe+4gwuq5BklfYCFO8OW79kmYNmYLco7xt5L1xQBSGwGNqJfamS7Hdkp9qlTranIrDUn78dZaXw9KvZ0XJRAxfeXrZbgavnMS+8J9CQcckFqVXGchsiCfU+mZqMa0Quco=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM0PR04MB6578.eurprd04.prod.outlook.com (2603:10a6:208:16e::11)
 by DU2PR04MB9084.eurprd04.prod.outlook.com (2603:10a6:10:2f3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 14:51:45 +0000
Received: from AM0PR04MB6578.eurprd04.prod.outlook.com
 ([fe80::b0f9:e7f8:2613:eefd]) by AM0PR04MB6578.eurprd04.prod.outlook.com
 ([fe80::b0f9:e7f8:2613:eefd%3]) with mapi id 15.20.7587.035; Thu, 23 May 2024
 14:51:45 +0000
Message-ID: <97882c25-21da-4669-aff5-0ec3b57231ff@cherry.de>
Date: Thu, 23 May 2024 16:51:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/42] mmc: dw_mmc: Remove unused version field from
 struct dwmci_host
To: Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini
 <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
References: <20240522233135.26835-1-semen.protsenko@linaro.org>
 <20240522233135.26835-3-semen.protsenko@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240522233135.26835-3-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0005.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::28) To AM0PR04MB6578.eurprd04.prod.outlook.com
 (2603:10a6:208:16e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6578:EE_|DU2PR04MB9084:EE_
X-MS-Office365-Filtering-Correlation-Id: bc97138b-3216-416f-752e-08dc7b37dda4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TTNHNEFYNlNjTVg2ZUkvUWwweDN6NXFOOUFUT01pbDVTSjh3NytwYlRUd0JF?=
 =?utf-8?B?VHYydXoxVjh0Y25aRmlyKzNZNG9sbVZsSVlRYmFXaC9sWnpldUUwSUJsZjFa?=
 =?utf-8?B?OHdkTnVramh4UndwSlZsbmdRRjVYaVBlWHZJdXdBelJXcXFtZXQ4My9BL2d1?=
 =?utf-8?B?VmFpb1V2aHNNSStCY1NTMDJ4ZXNLUDJnekVISWVDRjlibWtBZUNKYlpGMytw?=
 =?utf-8?B?NjdwRDd6bXlIMmdWaEJyT1FmMTJiUm8wZGoweHQ4VTJIZnA0MmFPZUYzT0Va?=
 =?utf-8?B?bUtsMWFaaGNEbS9lS1NvbGdJNUc2ZEt0eDlWNGlCeUlBVmN4dmNsODNTZ1hD?=
 =?utf-8?B?TlJZTnVpZWlyRjVVK0g2SmxqOXNLZk1SaUlwZ1RrQk8ycmRmS0VTd0UvaFV6?=
 =?utf-8?B?d3dPeHFJRkVtc1o3MW90ZzFQYmwxaHZEV0Npb3pEZnJvK05KWnhxMHpISUha?=
 =?utf-8?B?UkhqbEdlVlVhT2Rla1J6LzROdWpGUWI3ZW5Zcy93UWFyWm41OVdWOXgyNDdB?=
 =?utf-8?B?N2txZG9zODJHMi82Y1BML1prMzVRSmNScTY0VnRMbHIweGlLTENMZngrMmNw?=
 =?utf-8?B?d3pIUU5wMVo0T05seGd2aHlrZ0x2MGdiN0JZMDJaaVcrRlhYTUFYNWZhN2VV?=
 =?utf-8?B?NW1saTZoazN2dHV1VWFmUmkvOVlXeFY5MUYzclpSaG5raVlKU0JITnNNZmpt?=
 =?utf-8?B?czJUbEhUZVVvM0tCcFBaYmtSb0Z2em5YeGNraGpwTCtKUTlhbG40Umdhd0Ns?=
 =?utf-8?B?dVFMTkxyaitDRUYyTXc5czY2WjRKcHpaZk00My9pYXp0SGR1cmtCeFBxbkRr?=
 =?utf-8?B?L2JNeWJuTGFVS3Ria0hXRXdHTWRNa3l1UlJKQmpJaythdDkwY0Z5b083ZzZ5?=
 =?utf-8?B?MzUyLzBTZTUyTDA1WHFnRFVUbjFaQ0hrcmM5QXVTa3pDOGNVRVlmYWxZRkp4?=
 =?utf-8?B?ZWg3bjI2MThadEtBTjlERUNBcndmQjhXZXVtTjVEcjEzZ2VwNGtKdWZsK1Yz?=
 =?utf-8?B?VnpuUVV1RkhFRDFtMUZoUTFpV1Zhbit4cU0rSkJJamp2VmNFQVljOVRvNVoz?=
 =?utf-8?B?b3ZZdDlHK0REd3hiSmtQOVRoSFRpcmNubVY0TUpKdkplMzFrZEJLL3h2QUNF?=
 =?utf-8?B?RXEvTVJMcTMwSXMrWXBiSkZRTXRJQk9wYUQxMmFmMTNZZFBPRFJ3d3VyS1VO?=
 =?utf-8?B?WXVERjhRc2syak5OcCt4QUpDV0JkUG1RMmlzTlcrNFNFWnBKT011b1duZitE?=
 =?utf-8?B?b2hSN0ljNXAwVlFhMTdUWEhkWDJVd2lJcjJpbUJ6bE1KYVAyYTBTSXhkQjJP?=
 =?utf-8?B?akNlRlgxNWh1Mi94ZVNTaXVkM0JKa2xhUjlqZG5vKzJIUFdENjZFV1FFWC9h?=
 =?utf-8?B?QjhyWDVVQXRRemt4ZHc5T0d4eW01a21paDBGRGRnMG1LaU92K3JnYWEzK2tw?=
 =?utf-8?B?YVQyQjJoM0JGaVFySFZmaGRqSHM5N2h4WUdtZmFsMFRsQU1IUVNVcWc5QzZh?=
 =?utf-8?B?VlhxdFhYYUhRUFFiNUU5VW1iYzR3bkxGMFB5L0p4YWR5dkxFRGw5K2hld2dY?=
 =?utf-8?B?VW14bnhIOFZhcXFDcUM2VDFYUFdWSU4yRWZrYzgxWkxxcXhMMzA3SjJSQnYx?=
 =?utf-8?B?T0RPN2p2UFd4WjBwby9TMSt5L2xmbE4wQnhzd1l0Vi9kVEtHeStXb29vUnE5?=
 =?utf-8?B?U0t5SUFZNzdXd0k0VVVhVnVDV1JYdDRucmRNZHV1VHJab0M4R0Y0R0JnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6578.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkhqeVlZVXRQdVBhUzZNOFB4NTNOV1o3NDVGWCthczUrOVA5eFZINFVCVWps?=
 =?utf-8?B?SlJYUHNNSHlqbDhzbVp3YktmTkVvNmp0K0JieUttVXh2RjVQcXRWRlRJT2VL?=
 =?utf-8?B?Q2Fiam1BckZNRjlHVmFUbktaUmgyUzdiRUx6VXN1dSs5L1VVOS91ZFdkUW50?=
 =?utf-8?B?aHdINy9ZL3d4ZUxBOEpUZjdmMS9OWmY2ZmVsZm16V1RLcEtIM3VYeC8wdXpv?=
 =?utf-8?B?Nk5DYlZLM3FsV2tPMTM3dTRGVzd3MnVuckdEMjRyTkZMNEtzZzVGTmdPWFZE?=
 =?utf-8?B?cWIyRzBYVU9zbDNzd1p6YlFISW5WajFxT2J4b21jWC9TbWVUcWVsTkFoZ205?=
 =?utf-8?B?ZlBZZERUaDY1UUJRWDd4b0NnSExJVkcyR1N0TUNnUkQ1eDVlQ3hvbUt1TENn?=
 =?utf-8?B?SS8vcmxTeWNPWFhpbHRoNUptWEdBVXV1YXh4V3NvMm1TeEdWUmNQZHNiaGtN?=
 =?utf-8?B?NS9SMWdOam5pNWR1MU9aS3lLbEw0dE5xK0d0M3d6Qyt1dUZiU3ZwWUZqRGg0?=
 =?utf-8?B?d25yL1R0UnpPZ0tMTGg2UUVIMEVNaGN5OW9UVlA1TElMVlc4NlhsZVFEbmM1?=
 =?utf-8?B?dm43YTRKa1c5MGtlVWFZVTgzQVFLc1JTZjN1NWVtT2pjWHpqSnpJd0JjWG5Q?=
 =?utf-8?B?Tjg4a3hXam9zTFlVUytnMXY2Ty8vQW1MZVNscSt1Ry9OV0xPaGhXNlFoekpC?=
 =?utf-8?B?d2R5NE4xOE9FdFgrOStHanp5S0ZmYUNNajlxRTZSLzdrNE5iSXVkSFBZUUtC?=
 =?utf-8?B?VlZ2OEcwZ3pYK0lUaHJvTHJ2bFZCSVVpQVBkQkNSSGc2Tk9lSjNwRDViTGNK?=
 =?utf-8?B?NzB3ZlVuc0w4dUs0ajlJdDdqaWFsbFVMU0pIWnFBeVczcnhiWmRIQ3UyWFBR?=
 =?utf-8?B?VzYzZGdjeFhxMnBxUWlLZ1VYZktySDBscVVpWWlteWVFeEpXUFFCQllEOUxI?=
 =?utf-8?B?dzU5VFhhcHVENXlwbC9BblhSVms4dHB6QVJtMGw3YkdXZDdnR2d2ZnA1OGxV?=
 =?utf-8?B?SG9Bd3ZzVy9JS3dBNWMyd002M3hTN2U5NE9sVFJLRkhwQXBDT25FWjNCdmpY?=
 =?utf-8?B?aVpXWEhEdjUwaDM0RTFsMTM5cFY0aDMxK1YybzIxUDhqNkxDQ3RPZk4vb0Rz?=
 =?utf-8?B?WmI1U3RtVzdZYWt6Z3pUNnM1REVrQTJwNmF1NHV4KzdXaEpGcnI5MWUvQ1g3?=
 =?utf-8?B?MHdtQ3JPUlBaR3V3WnlWV1Jrd3cyaUhXQ0owblFqZHFsVE5uc1hmaDNEMUFy?=
 =?utf-8?B?emh4anFDWUNmUmhwU0N0WkVISis1NlVVK0x3NDV5dVdmNnNmRUlYbDRURnZ5?=
 =?utf-8?B?eVZxNkgvM0hEYXNVVXhXc3pKeFd0REd6TFFERjlnN2hlRnpSdEV0TXp4Tk14?=
 =?utf-8?B?UlB3YzV2VFdsWURnQVlQaFZtd25KL2U2M0FKeGdUelB3bFNERmd6eE5lcjhI?=
 =?utf-8?B?Rm1yMU5KT3F1VmMrNGNiYVU3SkJ2bDY3Y1d4NTF1S3ZBVTd1MDZyMXNpMlF6?=
 =?utf-8?B?UHFkc1pveitoWU5tVkdoaWpKUEM0U2p4SmxTanBBNkNiNDNIQlhEbXIvdXk0?=
 =?utf-8?B?d2hML3BnNDlNUmRYVHRkT3ZOOXdMZXlIeTU2NFhveWFkUStuMjRVN05DT25t?=
 =?utf-8?B?alJvd1o4bkk5aWMrNGkxUWVnTHRYQWlMTWdqWU5Wcnc0bTVaRDRORFNYTHll?=
 =?utf-8?B?MlZLT2Q4MFpSY1lpSjF3MTQ2TzlwbHBPWE94UndtdUhXWEFTWmNhZ2ljRWsv?=
 =?utf-8?B?bG9RSGdSS3FRSHhxRWIwK1BlNk90TC8zQlQreTBwK2dDSzBzdTdUeTZXTERY?=
 =?utf-8?B?VU5ZWEtjNlZLRkZOdU5JNVBzN0Y0NCtDZHRDSEpKcEpLclA0WEpNYnBFNXZG?=
 =?utf-8?B?L2IwdUM5MzZiLzR2eEJ6OXhnYzNwWjVrcytyNWtVRklJZ09Sakg1cnZ0blk5?=
 =?utf-8?B?bmJxWk1LRG5DSjlkSExiY0pnRlp1MisxK01UdjVMNnlMYWR2NkVRc2pnYUpT?=
 =?utf-8?B?dUQyQ3IrYms2YmhkM1VFU3NLRmV4VDIrSmdoQmRsZm1xV3JMeXhkOGVyOWJk?=
 =?utf-8?B?OWMzekNnVVlLN1o1RzNWeFVnNmF0UldydnBQaS9MMEhiaW4wQmJlVCsvT0ZH?=
 =?utf-8?B?WVhSWEs3azQzVTdOcTkyeEFvMjczWS9FeXNURFlQTVZoVWo1dmJNZXZ0MFp3?=
 =?utf-8?Q?n5zW3yycgmNEwkiK4rYaZ0c=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: bc97138b-3216-416f-752e-08dc7b37dda4
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6578.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 14:51:45.3701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2tN0/Ax2On7hMg/YCELbKEjWUJQCaIK5oF7D5mVo/ElhXvgZ97huTEymHcX0AeM3Xr0Y76TlJ4vSyb4TeXe2JVH9Od9KUXrzYrmnykx0Bns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9084
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

Hi Sam,

On 5/23/24 1:30 AM, Sam Protsenko wrote:
> Nobody seems to use it, so just remove it.
> 
> No functional change.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks,
Quentin
