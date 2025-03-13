Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED41FC282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 10:15:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65454810F4;
	Thu, 13 Mar 2025 11:15:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Hett6qfe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD2C281671; Thu, 13 Mar 2025 11:15:39 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::629])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88DCF80F9C
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 11:15:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=axOlg+WYYcgsWiGGCzHOmdfNt4RxWHjWs0Ka0Pi5cZY4c/ph9w2PMXMtuzgBPFuCqTzxyZTsCz2ag/3CQR5c+0EyoouOdllCE/XRz4XND7NIcL1zHZtHDmrhpdb811KNqcTD/2aaSdje788MWOysksG2FLeFxS2Wdbh3Z9vTfvvojJoRacGkIfOHm28FJeGL9J6ZfoOVNmUltrhR/B3Vmak29Ka/HfoBHAzs+i/HPguxTVSYGnA5/tzTVIWXd5geqRXfhrtYlAKRy8aqHyce3txNUD+cOpoj9C+MyhYYJjPWhWyQzJA0QYXSouYpSSLHRxdpU+a/jK83MjodH7i3Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KfEEssyqjte9/hXKjRL6uRWunjYhtQspcfW/J/YTSc=;
 b=rr7f5Wmqj3m75NTDWlih8hN7D6+7gZDoLWj7cu/0Bq9lantoK7qsB6C6HG6YNEx8AWBiBKC8xUQOSwm/3xOERreqdYpc2jkI2mpK0vG5bHynlnf7aJK6Fujew+CBT4D3p5I4ZPz/UROjsP4Yhuq7X81zgPlyn4cL6CzoqtaOz31HXtT0BhisCYJE8vazXI+XB+9Y01Tjeb2oofhHXO0RLt6tUsodr1dE4LxOkoSYmqPN5XeGcmSUEc109aoTTECth43haIF7FiD8y7x+l3sleN6MN6dQapVnHMvF9Q63TzQk2HuFfs1bhhNfTca3grN51KwXT3FHeVTFdyVLV4yF+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KfEEssyqjte9/hXKjRL6uRWunjYhtQspcfW/J/YTSc=;
 b=Hett6qfeGmbYlnsHrvgH6dcvjyA+LW20BCgIVni2g9lH/BK+yH42Ez/qgrkfvJPcXNpJrS9uauxbm9Em3qIW3yh4LVy7xylbBYmS+15eSPMsNg1VnW/IL9EQKJ5mnueJk4piLR+tMleH1ar4IStkOctY/EA9H3AW2oj+ZSwhlo0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by DU2PR04MB8504.eurprd04.prod.outlook.com (2603:10a6:10:2d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.25; Thu, 13 Mar
 2025 10:15:35 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%3]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 10:15:35 +0000
Message-ID: <07042041-5793-478a-b66e-112d89c00688@cherry.de>
Date: Thu, 13 Mar 2025 11:15:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] doc/develop/codingstyle.rst: Add a section on
 conditional compilation
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250312010021.1671010-1-trini@konsulko.com>
 <20250312010021.1671010-2-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250312010021.1671010-2-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0207.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::12) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|DU2PR04MB8504:EE_
X-MS-Office365-Filtering-Correlation-Id: eea0cce5-7190-498d-d8de-08dd6217fed0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bXJ5Ry9xM1Rjbk10d0RDUkE4QmlRNXlENkRnY3hrV3NobGlsY1l5akIydGt1?=
 =?utf-8?B?NHhMeFk0K0NyK0JWMDB5bHp3d2xENEFFU2E3ZjJ1aVJBdlVVbXZLRzloOVNJ?=
 =?utf-8?B?Rnh6ekJDMzA5NisrNURscVBPeE9wQzdNdWtsRmN6b1VKNTdOOGlhblpQbG5p?=
 =?utf-8?B?S25kYTNBa0xXaEw3anRPcDBlSDdVdUhYT05GMlVGWWRGazZNL3VjMUZ1aVlr?=
 =?utf-8?B?TVFDdnhZcytoSzhJdG9ML3BkaHNrTVIvTEpMNGJpTS9LTWxPbHZXb3NoMnFp?=
 =?utf-8?B?UDhqSUdjeVJGQS9iQzJqMWtGM0ZuNWdIdlBybVFmQUlzbzRGejJQUlRpWFdO?=
 =?utf-8?B?VmdjcXlFUUp0ME9VcjhXOUJCWmRMMHM3cmxxcEdoOTlERTlXQTdjVWhSSWtE?=
 =?utf-8?B?bm1NdGp1Z1ArVGlxUldaN3ZUZ1pPR0w5U3V4T3R3MERreTl3dWxHeWdqRjc5?=
 =?utf-8?B?bEpWTmQ1bjRIT1RBbktNQlRkS1ZDSTIyYWlWazBtc3JBQkRQeGJUNldlYit5?=
 =?utf-8?B?MHJxZHdBbVpSQlREdko5aXVrdFNFWTR3QUFvMFFVbzZMakllTUkxbXdSZDBy?=
 =?utf-8?B?d1NkZloyZDEvcnE5aEE4bXl4alRzQUhDbnNlSzhRRS9RTi9POGxXRzBHSGdZ?=
 =?utf-8?B?WFdyL1Q1VmFydXNGTDFvd2FJMXZCUUlxbGFjL3VWOHBMNEJVcmZvcjY0U1Qy?=
 =?utf-8?B?Q2pDUURZN3ZVc295ZTlZbU1LVGQ2b1EwdlZ6TUs5MnMwVE1Cc1pMUCtueGNZ?=
 =?utf-8?B?MldYYTlSdzF6SU00Y2IxZmsrY2lHNDZPeGZLdXVxZWVReVNIN2VpQklJMFRY?=
 =?utf-8?B?NkpQUWNNTHNDRGJKZFoxMGlWN0Z4S0F5ejFpd20wN2xiWGt0aHBJcks4RTdD?=
 =?utf-8?B?aGJBZkxnZWtqOEVSUnlQQitpYTR0TVQyTXZnZVBLbjUzbjE4cEdmWCtLL09h?=
 =?utf-8?B?KzBCQ1dxckE0R21HMWFtZjZBdUtSdHliR1Q2K3dnSE8zckp3d1lqbWZrbEV1?=
 =?utf-8?B?UGIxdjE5ZUtvNEhVZXF5SGhrZzh1YWVCd081RU9nS1RlaUJSMDNWS2xMU2Fp?=
 =?utf-8?B?Q2d4cGlVVEpYVVBnT051TDFmSCtpZmtWOXVGODhJVXZFNjU4T3BaMnQ0KytM?=
 =?utf-8?B?R3Z1MGpGNFM1bXNTYWNSRVFXWXFzelF0Ulp2Q2ZYMlNwR3Z0NDI5MENxdWZE?=
 =?utf-8?B?OUV0cWI0Rk9DdVFYNmQyZVV4Vyt0b3N0c1plUTBMRGtIQ2lWUVBzUVJPbjJZ?=
 =?utf-8?B?UVhaaFJ0MktDSUx6RDVxRkxiRnBzdW4zeENWSmdLTVYvSng5Ukpxa1IwWTVN?=
 =?utf-8?B?Q3NCN2h0UzZ2VWlHaGtuY3FqQlRyS0ppRUJUY1FWeU9VNGZnV25kS09IRTVJ?=
 =?utf-8?B?c1hwdmFxbG1vc0xvM0llME5INmcyNWtteUtVOXF4VWV0RU9TWlhCYlZ3QjNQ?=
 =?utf-8?B?K1RaejczZUtzcllFcXVEb0oyM1BaNkEyNUVyVHJGeGY4bjEwR1FRNFhYdk9s?=
 =?utf-8?B?Z1J2b0ppQ1hBQ2gyUi9OY1FEY3g4TEMrSjR4ZEpUb3luWk53a3ZWc2pxSmNB?=
 =?utf-8?B?NXp5bWVIRFF4VUxHRW9wOWRPRURxZTdSQ2lLbXpuTit6c2lrQWY3aDZkbTBI?=
 =?utf-8?B?eFd3ZVV3SG9JeGNlcjVjcjNPMmtacUZzN3liNjJrWjFtdVd6WCtXUkl0d09S?=
 =?utf-8?B?R1l6RjN2VnE0SERPeThET0VMS2xObzMvSVI3NTQ3OWE4NUFqdDNibjZzQ1Rr?=
 =?utf-8?B?SWZncGN1TG95TFk2aFJ3WnRVeXM3WVEvMkp6UExodkRkK0w3WjhLbndWUjRY?=
 =?utf-8?B?VDZPVmE3NDhHeVByaUx1QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEtyaGhiTDU2NzJaSFNibjZIa1lUNDRFckJFT3IrRlhmZmZCUTFua1BCTEtj?=
 =?utf-8?B?VlJLbTRVVENBT1YxWnBzSkl3QXFrSXNIOFNZUkZsY21LWldxUExUNEsrWWYx?=
 =?utf-8?B?K1VreFhsMUxhUm0vcTNlWmlOTDA1Ni9uWlN1TmxSeE50OEtpc21qb2RGVjZC?=
 =?utf-8?B?K0JuZjFpMFJZNlBacVplOWl3UjN6THBLcmpuWHBSUHdGT2FaQStaQURCL3lH?=
 =?utf-8?B?akRlZDBmRGtwT2lrdHhiWmw2WkY4ZG4zUjRXbzVtam9ZaUZSTHpqd29YODFW?=
 =?utf-8?B?SkRnVmpYUVFobFBqRFUzU21PSlA0UXRKV0NuSko4ZHFqUlA5NkM2b2Z2R2VT?=
 =?utf-8?B?bFFNS0QySUdjZ2oyMVRIWTdjdEswdXU0QmFIQk1iRXIzRDZsM2QydENyOW8z?=
 =?utf-8?B?L3Q2QzF0OWVtQWh1TFJoU2wvaTZiekVLMldxUytqdms3Y0xVQjdWQlhiM21a?=
 =?utf-8?B?dlpUYmdDYXhac25jZm4yQ09DN3E5MEhRdUpNQmw1bXhzOGtaSmtGNFVyL1hv?=
 =?utf-8?B?YWl2VjArK3EyeUVkV2pQOS8yMzFzYTJ3ZFFFb2srOWVLKzhobkMyK3ZKT2xC?=
 =?utf-8?B?NDFScUtKalp3M05OSWdGbjdzMHliODM2VmVqRzZhdEo5WXBWd3ViTDZUL1N5?=
 =?utf-8?B?M2JOL044MVM5aFZsOE54a1dOUHZnSUZmTVB3eXFqN3ZDVkZsaUY4OU9Uc3V2?=
 =?utf-8?B?UVlOaXNuS2FSaklXOC9uLzY5UmN6cGYvNnFPOFljdGwzdUR1ZUlveE8rQ0Fn?=
 =?utf-8?B?ZGhUMVl6K3BqeC9JV3pxTG1rNTVwbFZJSnluQW1DdHk1OWlWWW5TVm9jM2FM?=
 =?utf-8?B?eTRtRkZtLzUwYmU3Yk54WTI2cFJLU21ObFpNcFd1cEhDeFBuaUJKcjdaS3dy?=
 =?utf-8?B?TEJxNll2VWFqVFEwa0duL2RuUE1EUE5uZU9LK2RLZGlSQUM5azlCYTE0SW9L?=
 =?utf-8?B?RGE0WFAzalZWaGFCclh4Zk9LOE5abmRlQTNVWmV5WElsOC9qMVY0MTR2UG5D?=
 =?utf-8?B?Nlh3TG5wNThkcDV5TFVFNHdDMTZ4bUZLNUh0UDN2THErcHFtbkVsM3FUTWha?=
 =?utf-8?B?S2ZpVkhadWNvZGJ3amZNNVdXa3RXQjJMSllsT1liRDFvZUpNMXdRRlRWd1Bt?=
 =?utf-8?B?QzlhdHpoN1lkOXUwTXQ2cVJWOE1WaDFPT3BSRFVkeDB1WFpQRGxqUkdtL3F3?=
 =?utf-8?B?aGp6VHFlUHpxVlVKb2V5US8wVkdhODduS0xFUXFlbWdtNGxtQ2d0Z3NYcnNV?=
 =?utf-8?B?QnNVRDQ2SEs3amM3VVFIejBOKzAwSkN6VUpucDRHa2EyWElzUXRjQXd2V0Er?=
 =?utf-8?B?TGVjT2N1RzJmaU01TDdjM2h2bENFd0NrTmF0cmQ2QzFBREFoZFZJdE54Q3Zl?=
 =?utf-8?B?VVNsTytYY3hhRGZLTkdKZnA0TVpBRW9XajJYLzBHSUZGOWhDRmZheE1hTXpF?=
 =?utf-8?B?MGdqbUorSkZ0dmI2a0lRdFNlMFROSHc3Y1pKcVR6MSsrblRhNWs3TXh6QXVR?=
 =?utf-8?B?aXNOSDJSZTFtaXRzaUdXdG51V05sV2hiSi9VcFQ0ZDVrckFRK3psSHpPR2FL?=
 =?utf-8?B?aHM4aDR5VHEybHpPcE5OZTNkYnBzYllEM3hNcEZEckNtUHBvdDlXc3BwWWMx?=
 =?utf-8?B?TUtna3E2NDdUVWRMdkowQUtFb3E2RTVDcFNodk9rdkZrcWtjdGRaY20yUmsw?=
 =?utf-8?B?SXA5Z1NYS1I0TEQxVWtDUTkzQis0TUxnTFRxOGVBZ2tQSzdpVk5TSjErS0Jh?=
 =?utf-8?B?RXpHZGIzYlk3WkxWdmRFUUxhbjFqVjlnS2JZdTcxQUljU0Z0ZllIZ2w5QTln?=
 =?utf-8?B?V2U0K1FMNmNnZER1bU1hYmhQY3djYjVGVUp0R29udmNacktGQlRnN1FPQ2JQ?=
 =?utf-8?B?K2QwZGo0N1FLK1N2T0ord1l1bllGVVdWNWRaZld5WnZXaDhVdlphclhEbkdE?=
 =?utf-8?B?Q0N6c3JLeFRyZFdvYlRvZ2RrVGhEcm9Cc1FsckFMWElwbTBGaEsveWU5cWxZ?=
 =?utf-8?B?ZVZYcURTUlM5cjhyblVxbVVQbG9jaXE1dllBby9uL09VaVNoeEp0UzY3V29B?=
 =?utf-8?B?VXZFcnRYaDI3eVU3cTFMU0VadGd6N3ZWVHorbGtuVFBsVjNSWGRUQnhzQksy?=
 =?utf-8?B?RXdyL2NTVFRla09sZzdGSWxKdzFGcjk5OXJ1QTlrc3lILy80V0Y1aTdGbGU2?=
 =?utf-8?B?akE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: eea0cce5-7190-498d-d8de-08dd6217fed0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 10:15:35.6611 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g8G9EbAU6lrkCtAV3bmYwmKimnV+NIUwyeQQuoOLrtIzaM+o7PGQttRiZJM/QfCBRD91A84M/ihjOgS/+7SsKbnyRFeUgsvr11L0EKa+hrE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8504
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

Hi Tom,

On 3/12/25 2:00 AM, Tom Rini wrote:
> In order to make a start on explaining how and when to use certain
> macros, we need to document their usage somewhere. As a first step, take
> section 21 of the v6.13 Linux Kernel coding-style document on
> conditional compilation and add it here.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Changes in v2:
> - New patch.
> ---
>   doc/develop/codingstyle.rst | 48 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 48 insertions(+)
> 
> diff --git a/doc/develop/codingstyle.rst b/doc/develop/codingstyle.rst
> index fa3cd6aec82e..7211e4e4eed1 100644
> --- a/doc/develop/codingstyle.rst
> +++ b/doc/develop/codingstyle.rst
> @@ -154,6 +154,54 @@ See `here
>   <https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#function-documentation>`_
>   for style.
>   
> +Conditional Compilation
> +-----------------------
> +
> +Wherever possible, don't use preprocessor conditionals (#if, #ifdef) in .c
> +files; doing so makes code harder to read and logic harder to follow.  Instead,
> +use such conditionals in a header file defining functions for use in those .c
> +files, providing no-op stub versions in the #else case, and then call those
> +functions unconditionally from .c files.  The compiler will avoid generating
> +any code for the stub calls, producing identical results, but the logic will
> +remain easy to follow.
> +
> +Prefer to compile out entire functions, rather than portions of functions or
> +portions of expressions.  Rather than putting an ifdef in an expression, factor
> +out part or all of the expression into a separate helper function and apply the
> +conditional to that function.
> +
> +If you have a function or variable which may potentially go unused in a
> +particular configuration, and the compiler would warn about its definition
> +going unused, mark the definition as __maybe_unused rather than wrapping it in
> +a preprocessor conditional.  (However, if a function or variable *always* goes
> +unused, delete it.)
> +
> +Within code, where possible, use the IS_ENABLED macro to convert a Kconfig
> +symbol into a C boolean expression, and use it in a normal C conditional:
> +
> +.. code-block:: c
> +
> +	if (IS_ENABLED(CONFIG_SOMETHING)) {
> +		...
> +	}
> +

We should mentiond CONFIG_IS_ENABLED here too, as this is probably what 
most people should be using in driver code?

> +The compiler will constant-fold the conditional away, and include or exclude
> +the block of code just as with an #ifdef, so this will not add any runtime
> +overhead.  However, this approach still allows the C compiler to see the code
> +inside the block, and check it for correctness (syntax, types, symbol
> +references, etc).  Thus, you still have to use an #ifdef if the code inside the
> +block references symbols that will not exist if the condition is not met.
> +

And I think this is a perfect example why we should follow the 
aforementioned best practice as this would not happen had we had a stub 
version of the function instead of the function just not existing? It'd 
be nice to give that as an example in the docs. Follow-up question: is 
there a reason for NOT wanting to do that?

> +At the end of any non-trivial #if or #ifdef block (more than a few lines),
> +place a comment after the #endif on the same line, noting the conditional
> +expression used.  For instance:
> +
> +.. code-block:: c
> +
> +	#ifdef CONFIG_SOMETHING
> +	...
> +	#endif /* CONFIG_SOMETHING */
> +

Applicable to the whole patch, maybe highlight non-English words with 
double tick quotes?

e.g. ``#if``, ``#ifdef``, ``.c``, ``#else``, ``__maybe_unused``, 
``IS_ENABLED``, etc...

Looks good to me otherwise, nice addition!

Cheers,
Quentin
