Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E84C77B7C
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 15:30:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CB9582C2F;
	Tue, 24 Jun 2025 17:30:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="n0JoZZGu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5464782BCD; Tue, 24 Jun 2025 17:30:56 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A9E082BCD
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 17:30:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XGMWa2Yz4D+slvQnnzKHBST8uOKTHJ+oM69Eag8IFxMKPvgVAC5gHQSU0fAdj1Ey1EBr53l6I0xCQg6/sP+GlF2VnqzNrHAcKlgxvsBEXWYWqfyKftRAAQqaZxtTq2HMHbm//KxWemaO0wXj1KXF+tehXkU370ugGIzylzusO5eDXnBJaGQ24pdGmxN0B1nJo3MwM2ys6zaPZCW1sStK1WAU0NwOhXQbwzXUALvPGeYrGOhIiNlcCVncca4lIbDACh1VTnSjXFwotCOACPVwjnP8WjfifadJcwhV8SbHyWlqAVFfVecsUhEKahkHWpVqPfaETSLSoYTJh6zRmqVpzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZ0OcOfIzcDCmmgbeAzQG2mDMCh37blDHfrKafVL/bg=;
 b=H8LfetD1Td8EZGm2iDEnOtPAGGG4GRukiJvljMx8uyha2EMAVWLi93bqXTkcloIFaNrX4lowvp21BEoIXaRRuuqB02/DGNglEHXYMyuX1QtU1a+aKMA7HJrpQCxt4m5jWJMWU7NmbWFhsMw9PF4n0E5Df32KYbIIS/8FTkfW4v+ysskbbX5futFzFD8WI2HlX9p25IoeFoks1aHOrGvSgV1YUocuY3H08W15Eam+Pd3/UU9WJXxCppha1AziSEsDNS/t6r60nT5w7J24kYuzqOi+TRiJjz6v1rjcz5t89V1XIpGTXpCouLTZ7FIrwfzKhYtUhsVmG4E9WvfIyDdaRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZ0OcOfIzcDCmmgbeAzQG2mDMCh37blDHfrKafVL/bg=;
 b=n0JoZZGuTCLct8dps3KrITAo/XndnVugxG2217Rha/Yrujjjq4skmxJ23jXbhOIMRxmkAu0lyC4AZ0L5fQFo9P3PaUYhGpomeZ0VLumTPfU/anesndKPum9AIU0DN1BWj5UPoDxw3iViueNX4AFgnp5ymuOLwv89PdSp44xW1Cc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM9PR04MB8340.eurprd04.prod.outlook.com (2603:10a6:20b:3e0::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Tue, 24 Jun
 2025 15:30:52 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 15:30:52 +0000
Message-ID: <cfe20b86-4e97-4a4e-a69c-2b38ef8878e8@cherry.de>
Date: Tue, 24 Jun 2025 17:30:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] usb: onboard-hub: Use devm API do automatically
 free the reset GPIO
To: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20250610-usb_onboard_hub_cypress_hx3-v3-0-53f03dbc3017@thaumatec.com>
 <20250610-usb_onboard_hub_cypress_hx3-v3-2-53f03dbc3017@thaumatec.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250610-usb_onboard_hub_cypress_hx3-v3-2-53f03dbc3017@thaumatec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0184.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::16) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM9PR04MB8340:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fadc1c6-f0d7-45ec-d53c-08ddb3341aa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N0FJcWJLRHpWMHlwRmhwT2pjS0kvKzI0dVY0dm92LzYzcU1BMGJJOWlZeWRX?=
 =?utf-8?B?NHZ3T0dGK0hRT2d5SjRZU1lFYnpHV0NOSHNqeFZHZGw1TEFnRStmYU5oYllY?=
 =?utf-8?B?d1JmcC9wQjlQQW56MTVHWmgrbms2Wi9aZGxMT2t3U09TZTRjbFFCMXozT3Nz?=
 =?utf-8?B?elZDMlk4RTQ0N093N01ZaExXdnQ1ZkV0MkxHL1VSd0hBWFQ4ZEJFR3hEYkhB?=
 =?utf-8?B?b0dIQnY1Y0c1eUN4c3hxZkQ5SjNyMnNvRWFvU3YxQ05YUGd3RVUzSEdTZVdZ?=
 =?utf-8?B?YVVFUitJbTF5ZXA3VVBmTkhUQ243d01XOExxQ0gyYjE0Ykw2MlpFTDkvMlZa?=
 =?utf-8?B?Zy9uWjdueWF1cWhjazJOdWxaMXdtNFQ5RnNJbGxpZkxqcXFBdFIwU2Z1RlRy?=
 =?utf-8?B?R0pjcjVxaWt1SXRSY0VZaXpPNWwvQ3hXek1LT2pESTgyMkI2Z0M2bzM3SUlx?=
 =?utf-8?B?TkpvY2hISENWNUlKRkFpODhDY2djUWh3ZWxBR3c2TzFOemQzUDdvVHdqVWtw?=
 =?utf-8?B?Szh1RWx6eDlQQlN5K1JBaXhrMjhqbXBxMTN3bzQrbzlTSGVSdm9LUCtwOTIz?=
 =?utf-8?B?UEx6Y3pxdnlrTlBxYm1CaUowdXRLbElhQ2QrV1o4bk1PbVVadnZrQmJxdlRT?=
 =?utf-8?B?aHJQV0RYNHRYSHBhZUpMWUEyWTFqN0pwNkdRbXpWM0RLYmI2aEJPcFMrUHBz?=
 =?utf-8?B?dnlmS1l5U0NlL2s0Q29mL2xjb3pTRzhUY2lubTZRRVo0SEJIWkNuWVdEbVY0?=
 =?utf-8?B?M0MweVdBK3IxRk1QbVVMVHN5Qk9IT2hWcUJidmlqUUppZC96cWo4TzNyajlP?=
 =?utf-8?B?NnBnWDIxUzh0dkZadFFJYkwwMjF3SEovWkFqSk90ZmdXV28zZnA1VUsvakN1?=
 =?utf-8?B?ZGl5RkFTUWxZQzQ5YzlVSWdkem9TR1F2dkVkd3h4ajNsMDFmclUwM0JUalpa?=
 =?utf-8?B?RjNaQ1pZUUM3Q2tUK0lYbHRXR3dkdGUyNXBQdndMR0lzOC95K1FWZm9lWnVv?=
 =?utf-8?B?Rm83eGM0dnVPUWZLL3IrUWZjRXNSS015eThiZ3poVjdLQ2dabnBwZVRqUWRn?=
 =?utf-8?B?RytsUXdTR2x2dGhGTmwyRU9HQVdqclJBZGZLR1I2cTdSWnBZS05mYWVYREV0?=
 =?utf-8?B?SllTQldGRytFTTBFOGRGeDl2Sk4vZUxHbTR2ckpVcTRDZUlVZ0RaRFJIM045?=
 =?utf-8?B?OGJHN2JOelZGUXdaTFhoZzBWa0lCY1VVdUFaOU14aDhlK2huOURUekhHaUg0?=
 =?utf-8?B?c3k5MkN3alAzZFh0WTZvRlc5SjRJeGlMSzNoMlhsbkpQZWQ4bjJRL2UyQnhn?=
 =?utf-8?B?VDRFS2h0R0xUWEJlQXZZMG0zb0phNlRyc1JRaktOYzdsMEExeUQ4cFQzTWtv?=
 =?utf-8?B?d0pMM2FZdDNza1ZFWFBrVXF4bHFHU1JDN3RMbDhBY1BRQVU5RHRFemY5Z1Zn?=
 =?utf-8?B?dDBPSjlkOGNQRS9GNXpUcGs4UUVGTjhCODM3cXFJb1JnaW5yNCtTN3FQa1JX?=
 =?utf-8?B?UHZZQnRDcysrVEo3bXg4TmVrZDVieExyM05VcXpreEU5b3pCUUtYcG54eXZX?=
 =?utf-8?B?ZVRuL0psOWZ0VDFCcTBteXM1ckJndEQ4SXpTSUlWNENFT2daN3AwUVpTdWtB?=
 =?utf-8?B?Y3hmbnpua2Y3aDk5NFdTUERUU0hNdzFJdU1kWmFlTzU4OUZhSmdTOWFaSE40?=
 =?utf-8?B?aDlKM29PbkQxL2gyVm45ZjhsOTFQQnhhSFhMOXk0S0pvblpQZnFZamxoMGpB?=
 =?utf-8?B?QlJnOHd1UXY4RUpVaUVxdTgxSXEvWUxTOUMwWnREUGVSK2NnekkrSHhDaHFa?=
 =?utf-8?B?c2pEQXZIZ3hrZU9TemdnRFFTcldRaEN0UTVUV29rd3ZjcnBlMStSNUF5a0ZD?=
 =?utf-8?B?YkMwdkd3M1AzcW5xcTBqdXdLSWY5TlhpUVNJNDFLa3dRbUE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUZKMGlPUnIyYjRWSVpHWm1PSktYWElTQUR5VlBqaU5MdWxzSTAvUWJzaGxm?=
 =?utf-8?B?TGt2RHZvNGZNTzRVL0o5b1JSV2hWWlFiZXVjTVA1SisybThSRUFTbStGVGVh?=
 =?utf-8?B?MExqMnZmKzRJZTY3YmVjYm5VMG9aOWozVW5FSmhITTlEd2crczBpdm5ZZUR5?=
 =?utf-8?B?am9aK3lGSXExT2ZGZUpVbTlNb3dFSGNiWGUyWVlIc21TSVluUVlZbEpoRERz?=
 =?utf-8?B?VUZINlZ5TVpRNHk2NTJ1eXA1K2pGQUFTdWpGNmVmM0lGazIyMWloV3liNjBv?=
 =?utf-8?B?S0hpTEN5MTk3cnZ4OXZveU1UWjJiMlJCY05YWDdUWE1mYUNPT2dGeTFnNzIw?=
 =?utf-8?B?Y0ovM2JPUkJRcWVjS1l3Mkh2SmY1Z01Qd2dBSnpndWRYZjY1RHV0bUd0UVJY?=
 =?utf-8?B?aEdxU1J6S21MTi8zSDMwQ1pHTk5UNVU0QXkvTWNJaEYxYXBZTVJLbjRFOWZv?=
 =?utf-8?B?OGRadi90Z2thTy8vQ3o2cGxuZlVOMXN5SThiL09EemQ0Sys0NkxEazRsSm1Q?=
 =?utf-8?B?bmgxZXdIekVuQVZkZ0xCZzJsWTFiRXJQN2pJeXFPVlVNbGdiQzVYUmZxUGN0?=
 =?utf-8?B?QWNzYUszanRra2x2MzVFY2EyZUdKaTBPT0QxL1lXdHFGVU91Q1NVS2FaWVQv?=
 =?utf-8?B?ZnFrUTZPODRoTTJLSlVxV0JmM2xvYVJ2TnJWZGxBQ3RWSTlTc2V6bGFNcHZD?=
 =?utf-8?B?T1N6a2cvMmxNYjY5LzRQTGM5aStZdlNwSmNBZXhBSGIrY2JlUjlHUFhwTDdQ?=
 =?utf-8?B?cDAwcFdEakdFMXJLWi84QVdrY0QwVisyRHVoSFdKYjkzbnJSbCtQalZVenpz?=
 =?utf-8?B?cWN2bVNiUFVZb2M1b3FsSXVvNElJUU5LWEFJUTNtMGF4eGpKZEhGd1k3aUNS?=
 =?utf-8?B?a2lORHFiRTZFTmtBUldFVUF6ZjNjekNSUjBqVDVEQ3ZsVlZmL3NYTDF4WWRk?=
 =?utf-8?B?MkhnZ2hNRXdINFNVZnFsZFRPUGVCazUya0F5dHZMeVNNTE5qRk04RzBTR3dz?=
 =?utf-8?B?dlBzMHBGdlN2dGJnRmExRlNEZjZ5VzltOWRuUDhzMFJ0TVk4WXJocUh0OXNT?=
 =?utf-8?B?YWE5and0TWluVUZ0TlFRa1VvS2lQTWlPajlhbWVtRi9CejlNZW83eHBZK1ZF?=
 =?utf-8?B?dTRkQksydGw5dlZVeHoyV24rV3doVzNGcDIzd3hmSnh1S2Y0Y3NUZ25QTnZu?=
 =?utf-8?B?NnNEdUduci9XcGd6d3R2ZjZDWmxVVDVpMjd2NlB0eWdKekJZcmU4bEZZWDNo?=
 =?utf-8?B?SGJVY0FVZ0RNNGtpTlVKUExYV2ZxNmtxUVI0cmhiQzBnOFRLRWlNU3hiZWlq?=
 =?utf-8?B?T29hOUF4cmM0ODZRdDkzd1hScnJJTE1aSWpPQWJ4WlBsL1NOK2NxUkwvYWNG?=
 =?utf-8?B?Y2wwRWhuM2ZyU25CdlVtb0Y1Z0hjY25MdGtCUEE3Z01SS2plcjhyTUIvcU9R?=
 =?utf-8?B?WFo0ckt3Vi9JV2hCSTZZa1d5ZGJPNGhTdUxlVEs4SnViNG45K0crT2tjb3Rx?=
 =?utf-8?B?ak8rTGhYcEY2alB0NzY5ZFlLdzYzdnllNkxvRXorZDBjNXlvcnBJV0xkajhS?=
 =?utf-8?B?WXdMalFwdlRIMndkZkY0LzVjUlhyc01GMkgvcmpXZDk0N2ZTbE53RjB3Zitv?=
 =?utf-8?B?NFdnQWE0VEtRRUJIdG5UZEpITWEwUG8zNGtHbCswVFlmODV2aEU1TUVzZURY?=
 =?utf-8?B?NlVDaU5FRU92K0NBcUVjYTNDWk5ZTjVodXBCNGZ6MkpWeUkrT2xhTS9SbW9y?=
 =?utf-8?B?eUNDRjY5cHhtMHdhZVd6SUZncmlwV0w5Yi9Kb3ViQzlaT01jenpPbVFtRjVQ?=
 =?utf-8?B?SGtTR3B2bk9HL01ja09VeVpmVWpIVTcwRXMwa1p0aXVCRGEzZ0NvaHNnWk56?=
 =?utf-8?B?Y29YSzRKSlBJaGhLQS9aMVlYcHMwQVNrYUVkUnhGb1BPdEgwQURqQUZWUGdI?=
 =?utf-8?B?TVBSTFdDZ2Q5RWZaMVZJQXJwVWgwNXRXcUNUeDZiSDFxYjBYK3k3RXJVbXdV?=
 =?utf-8?B?VktNT1F4RzZnWlBYRWxDMWlqMEJ6aWcwVW1CZzRpTzhFSWhpRnRzTWo3dTIw?=
 =?utf-8?B?NTErYWV4M3c4a0l1SHRDb0VoZVdWZW5qWVFaRVJFckpmcWo0QVUxNUtFdUZC?=
 =?utf-8?B?S1ZvWGltWjhDVitkSitjVVRWblgwWlBDTnpRTGx5WDBtSkZOS2hTdVJWRDRh?=
 =?utf-8?B?SFE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fadc1c6-f0d7-45ec-d53c-08ddb3341aa0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 15:30:52.4324 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wxL47Fp+230c9hmIxadPa1lp9DuCHkUr8DwBg646NZPk41HX2B9E43aO3oV2qDuin62mOLIgY0Uers9qAsLryel24brOkbNqUkMN3zRcvz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8340
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

Hi Lukasz,

On 6/10/25 10:02 AM, Lukasz Czechowski wrote:
> The reset GPIO is obtained during driver probing by the function
> devm_gpiod_get_optional, which means the GPIO will be automatically
> freed when the device is removed. Because of this, explicit call
> to free the reset GPIO in hub remove function is not needed.
> To support the Managed device resources, the DEVRES config must
> be enabled, otherwise the devres functions fall back to non-managed
> variants. Set the necessary dependency to DEVRES in Kconfig.
> 
> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
