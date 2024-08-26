Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD782C5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 16:46:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B2DA88A30;
	Mon, 26 Aug 2024 18:46:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="BHzbUA+B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FB7388A12; Mon, 26 Aug 2024 18:46:35 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::606])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBB538852A
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 18:46:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S93PFlzXDNDQwDbR/1uIEY2cOUtnCW66fYIk3QT9JY8/EkhOpEDCGYRMYbf+FwCH4xQ6NJaPyIGieMm2RmWCchK4pZQUxx+z4gPfyiY3sxucuQqdlC2OgWZvLa+AM8yozceEuoQGJlJIDNy+pY/wpwC/kU7sNaUf8Za+6b8yVtODCRmk0F5SuHmUz1G3XosvP9a+EVxGcUkMFKuLMEp5hZmxDpBpGVgmoFZWP/96MtVqMgdQ5bC8I966rQY1tbwb8jvFwLWLIQIwFxcAZDuBa8yAh40+7xtI+bWVK5v17UMpk5qDSgopHMHRQaT9k/WLr26vbQULiidQJHL/uT0oUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBwehxbOQeSraIDFyIyahOr5DtZ2h7/B97g+C0SoxZ0=;
 b=Iz5yktLu+hLSY+3/502v6zIXtCvQUsBr0hxXMUkUkyFnUVI60QA8zKu/HhjwERrXDAbj9QwNnghuHb+4lvd/nKCghX32++v1noqc5xJbYjjG2NxkNIAEDxq2cP5mUrNf6kABUp1ZbTM9rIGG2DxMo3XCAXt3Rm3sW5SjHXFQ8SZrTZHXKNN8Avtcv9tjUcCPHMVUIsnlRkGOfeyCQ1f/54O3iATDka/I5zg/u7yw5mPILhHGnrD7hJtr7t1zE0/J1vTnFMwDl0lvG71ATkbExdI7d9/18Nbw09WjdhZs+1Sgopp9UByUXRVdDFNPD8gWYBiUGGaehMwUa7Ljmf7Zmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBwehxbOQeSraIDFyIyahOr5DtZ2h7/B97g+C0SoxZ0=;
 b=BHzbUA+B4xTM2dW12Z7wgJwzNNE6rNBB88cCL6oP6krmqJAcYL86l3bDBEm6x8jWaYkdmBALHA4LvBUhIiL4niM4CcDABrOT6ocp+wlPYF/wpKTSBvJOdu55XeKwvln6YPWwx0WnEnGOVJo12zi/Qx3e8YzL0jg5mDbIUYcu0Ng=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PR3PR04MB7228.eurprd04.prod.outlook.com (2603:10a6:102:8c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 16:46:31 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7875.019; Mon, 26 Aug 2024
 16:46:30 +0000
Message-ID: <71e211ae-4acc-4a0b-9014-dfe35a2d74cf@cherry.de>
Date: Mon, 26 Aug 2024 18:46:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc/develop/sending_patches.rst: Clarify when to use
 which branch
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@linaro.org>
References: <20240826163917.2786791-1-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240826163917.2786791-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:22::20) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PR3PR04MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: 20851d1b-863e-4072-eba6-08dcc5eea2e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M05CbXFzN081WFdpaWdvZmF6RnJMb0VGZGppdjl4c2RSRUgwYzYvdno3NTU3?=
 =?utf-8?B?MkxTN0ZmTG83QnczS3UxZzFsdHp1T2Y4UFp1TGRQVUFSdm1qUWZJYmMzek5K?=
 =?utf-8?B?Vmw2Q3JMcDhLQlU0Rkg2Zjl0WTRVQmY4SlN5S1NPM0RDcHBCWEVUU0k4THBF?=
 =?utf-8?B?c1lidVIyMVkxMFdVbVJLa3lEQXh6Rlh2VFJEYjliZ3VhUk9kOE10ZjNEdkZ1?=
 =?utf-8?B?SmU0ektNQThWQlRuTnFlZnZaaW9uVktxbXhrelhJNFBxc2dHMFZVcUEreUhG?=
 =?utf-8?B?TGlhR1dnSTdWa3drMVJRVmFETXpFVlNLKzhKRHV5MWc2b1AvM0NRT1FVWmZM?=
 =?utf-8?B?QkFkVCs4M3cwK09CeTVoeTlndmxLRXozVEpRbWxqQmpWRkREY2tIdEtOaU5I?=
 =?utf-8?B?MFZEMXpLVms1L2EyK0ttQ2RmazZmbUNoZjgwVTJCZWdibkhoQUxIVmNxVm01?=
 =?utf-8?B?K0gwK3dhdDZmaFNXdUJVQzcvU2MvOHNWY054ZHdGOUIrOEVsWUQzRnM3Sjhz?=
 =?utf-8?B?M2NGZVk3YW44M1B2OHZnL1ZZckdFdWF4bGRXL2VZU1liN25EVkU3YUtwbTU2?=
 =?utf-8?B?QXIxblFIZFRhdUtFeGNZczhhUDlCalpKV3U5UjBFNnAxb1VtNVdLbTljbmY1?=
 =?utf-8?B?dS9HeC9oNFhaSlFUZE81aGFuLzRsL2llajFaMkg3NDZVTEVCMTZEQ1hqQTJL?=
 =?utf-8?B?RkN4SXFVY2dqdnc2ZEdXUndpV0MwbmY3TTBLaWJob2VJMDQ1aFFSZ3BtZGRN?=
 =?utf-8?B?MzF2Q0djcDNURVhPQWRrWVhRcXVGaXh1Tlpya255TTV1Y00rMkVxOUROZmEr?=
 =?utf-8?B?VEp5N0Zydndmbys0MXpiTS84RzJMdnhRNVU3UjQ0V3RPQUlQMmFoL3lkVDJ3?=
 =?utf-8?B?eDc3UWRjQXJEbkpTUWdKUjV1M2NGcFRSUS9zNGVwbW9SWWcwYXJwVW1oSlBD?=
 =?utf-8?B?ZVVYR1EyNGVJQktzVHNQOTkzaXlOcDY5czVYaGJZMmJGcXZFLzNWdGJyTU1x?=
 =?utf-8?B?Yi9wZmtWWHFvSWZYeWRPSzhPYWorSUxneEtaTjU4TWRrQWh6cHBIMlluWjlC?=
 =?utf-8?B?RDBIY0hqWTJYcERjYWZPd095OUhRR0JqejBvMmNYenBnSm5TZjdEUzJtcEpp?=
 =?utf-8?B?aDBUczVaQ2JuM01pY1ZjaGNDd0tMMDk3ZVFNVGJab1NwbFdxTTlDTWpsVnAr?=
 =?utf-8?B?OUM0dWlpbVc1a0ZIMXhud29XMnVwUjR5cHgxK0xDeXlwOUJUTzIwYldpTjB1?=
 =?utf-8?B?ZjBkdzhnTFkrVGg4VWJSNXIrdS90R2wrVzdZSG9xUzRENFQxRDNIaTUrS1ox?=
 =?utf-8?B?OEtBWWJjcUJQUUsrSU90WVJDMm50MFd4dE9WcW1jY2UrMDZWUTdFSVNIMDN5?=
 =?utf-8?B?aXBTU3Y2NVRibmdvbk1lN1BIaEVMOFczeU9lZE5Udkd2OThONlNoZ1NpUy9x?=
 =?utf-8?B?ZHFJK2Y3T0tlOENsRW5RRk1HL0owM0tFNnY4K0duT25MOGxBWENTUjNZcFA2?=
 =?utf-8?B?ZjZIcGtEZFBxeEYwVVJ6TVh2MkNQamloT3RucHREclVhRjVyWXJYK21VL0ox?=
 =?utf-8?B?OTZpeTZFblk1ZkYxZi90K011eXlrY1NxR1lkMitKcjVsajh5WTdWWm96Vllo?=
 =?utf-8?B?SVdyWmFjeEtnY3J3OGdxVUpZSmE5b2NMem9jbC93RG9WdTJtaHh0ZlNtcEw5?=
 =?utf-8?B?OTE2OURPTlp2V2F3Q2FGc0d6T253RFNJUm9XQlAwQ2gxeU9ha2ErZ1daRU83?=
 =?utf-8?Q?x4iaW7TwFiJhWX+Xm4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzRxKzBzVDhBQ3JUdFprdENlZGJCcWhXZWhlY3ZzbkVNQXlpTkpadnkwd0t1?=
 =?utf-8?B?NUsxZjRsZjRiTFFTNjNCaUdzQkd2eElYdXVOWmhCMTY3UWNJY0RyVWExTFFr?=
 =?utf-8?B?RGFGQzJmYk5wOEMzdlJNV2VheEpIbnRISHRYN1NFSEczaWFvLysrb1VCWDc1?=
 =?utf-8?B?U3JPVFdRa2JMemtmUmt0Ri9lbGFpSHJnOEtScDNtSkMyaDZQR0Faa2JYK296?=
 =?utf-8?B?enBCY2ptOHVaaTU0N1A4TXpGKzN2TzZ2eW1CQkxDMUVQeTVQK3J1Y2VRWUtO?=
 =?utf-8?B?L2d5MXVQSkF6OWxHcUVNOUlPMS9URnEyRk8wM3k4dHZ3WTc5TjZXMGx6b1R3?=
 =?utf-8?B?UVh1aWwvSnBWd3NnV01hWHhuK0dRenhwYWtGcEpkY0M0VkR3UlR2UjgwNjJP?=
 =?utf-8?B?USs2YU1mQlNHUWhWYVdGY3FQM1BCQllZK3puV3BIc3JBcldFR1cxU1ZITzBL?=
 =?utf-8?B?dnpWbk5URk5HWWdkMnhHZUFYMkdNT1duYWpNYmFLMUlhUWw3RTZUOHUwemxh?=
 =?utf-8?B?azU5Uk9TSmhNVjY1Z3FPc25GVjNWSzBsMVFkUmhwZG95b3NYNVJ3SmxpaUNZ?=
 =?utf-8?B?dzBFQmE0NWRETlIvV1FDMEpjeHRCcHkrUmFvZHhvdldQMzM4NlA5NHNTeWx3?=
 =?utf-8?B?TnRBZW5GaGh1cWNmVW1DUHEvWjA3NkpjczdUcktwN3p4MFc0OE5uRFFlVFBD?=
 =?utf-8?B?MVNHSjRMdDZEWldsRE5JbGRpRUxDVXd3T0JxY2ppelp3UmdIZG9TbnkyOFJO?=
 =?utf-8?B?RS9UQmdvZC85dGdQSDJ2R0tkaDl4Vk9MUDFDN2hEblB0SDIvVVlkU1p6bUdr?=
 =?utf-8?B?ZHhkRXVMSGp6blkvRTdSR01RL1dlUW1ZUlNDRE1XZ1RHcFBjV29sR0xCbUZC?=
 =?utf-8?B?bVRDTVQydlNSaGFyVWJzMnhtdnArVVAvcTBxcDFGUDJNUGtQVTg4d1ZUa2Jp?=
 =?utf-8?B?UXVlRHZQUTIwdlV5aDlLK0NoRkxOOUpVNlVDc21icFBrRTZ3UngzK0EwOUh2?=
 =?utf-8?B?MGdraDErajE2KzBWYnRMcnIxcE5URll3eUZDcWhzUU42ZEtYTWlva29jOGh0?=
 =?utf-8?B?TUJ3UDFCM2NXRnl2a0dmWTBsZVBBclUrZEFKVkVOYUYvdEZMMWw4bWw1OCtq?=
 =?utf-8?B?dFdCRzU4bGlibHlMejJ2UWtGZS93dVd1Uk5MdWJWNURDVzdmeVlQb3k1NUtD?=
 =?utf-8?B?OUVBeHVENG5hNDFnSWxRZzBMUHJ5bWpsaytPVm5RZ1A3YTlpTGFZUkRyZ1NG?=
 =?utf-8?B?ZmV5Q24zRWU2S2lRbVhUOUt3MlBBRzRONHJETG1MR2E1MXl5QlBtVDlvUDZX?=
 =?utf-8?B?c1VSQmNQVW1PUnBGRFA2SjJ1MDE5MXNvSXNZYk5KcURFK0lMbWlnRnQvdlRC?=
 =?utf-8?B?WlViU0M1ZUowK3VuNThRTmc4VTJEaXpRSkxZQnZkNUNwbmdZa1ExS2M1bjBz?=
 =?utf-8?B?ZkZpOU4zV3RQcllrcnpNekpWdnBtMXc2cHFEWGJTTXVNNUN6TlJyeFQ3TXZD?=
 =?utf-8?B?Sit1TDd0eVZNS1YrdHZmOHNZNFpsSmh3V2x4ZzVGRTZXUS9PSk53MDZBZEdv?=
 =?utf-8?B?ck9pbFhCZmFqZHdoeVZjbkYyVnZ2TVRtaEtOTmFVV0pGY3JoU21MdWlyYzlP?=
 =?utf-8?B?V1J2RzQzVXUzbzQ4MFJXaWJSZ0Q1MDZzN205bEREaHhRd1MwRDRRTmpMM1lw?=
 =?utf-8?B?ZURLc2FCdm1jaXpQUnZMaFNNekpWdmJZejlqMVEwemJaaDkzRi9qaDR2TDIx?=
 =?utf-8?B?d2tQY1JuUjc4UUV0WlNvSkdZeTAveFkrUmZuZGR6TWYxYUlFSE9nekdKNFdE?=
 =?utf-8?B?eGJYRzVPd0VNRCtxOHB6VktWcjZvTmlVa1BhN1hBeHhnYTJBbGhaQTJnTXRM?=
 =?utf-8?B?ZCt6RWZ4K1A0SmdRYzNjYUlaL3YzdVdlZ1NUS055VFNFS3huTGRsOHgzcWZC?=
 =?utf-8?B?QnplS3E5LzM0ZUpvMTBGTHQvTEdPWWVTQlBvY09OZ00rSXJsZ2ZLc1NJQVhR?=
 =?utf-8?B?NjA4NlFKSzREQjJ5NFUzNGFZZWwzRk5XWi9FKzhiU21uU2RqQ21rdXNldTJh?=
 =?utf-8?B?WW5IQWdhbHI4RU1EMkxTL0hMcFhlMWFHVHYwRzFMRmUwMXhrU2k0dk9IdGJC?=
 =?utf-8?B?R0lNcFltR01VeHZGLzdKZmNHbzU2bDd6OVlHOWZoait2bWk2MXZuUHkyNWVk?=
 =?utf-8?B?OVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 20851d1b-863e-4072-eba6-08dcc5eea2e4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 16:46:30.9166 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6VZS+wJIj8EbPSqIQzbZKgx0+pYn3xeHVCP9zzrqC7FqJUg3XAkIksm8MtuiHKIe/VYolzlgkw51J15yN/Bpg+YpwWggdizdRIgRVGNCqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7228
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

On 8/26/24 6:39 PM, Tom Rini wrote:
> The previous wording on the paragraph about what branch to use when
> submitting patches did not reflect how / when the next branch is
> currently used. Reword this to note that master should be used for bug
> and regression fixes, always, and that next should be used once it
> opens, with -rc2.
> 
> Reported-by: Jerome Forissier <jerome.forissier@linaro.org>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>   doc/develop/sending_patches.rst | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/doc/develop/sending_patches.rst b/doc/develop/sending_patches.rst
> index 3f25b1d0466f..82efb717b179 100644
> --- a/doc/develop/sending_patches.rst
> +++ b/doc/develop/sending_patches.rst
> @@ -74,11 +74,13 @@ General Patch Submission Rules
>   
>   * Send your patches as plain text messages: no HTML, no MIME, no links, no
>     compression, no attachments. Just plain text. The best way the generate
> -  patches is by using the ``git format-patch`` command. Please use the
> -  ``master`` branch of the mainline U-Boot git repository
> -  (``https://source.denx.de/u-boot/u-boot.git``) as reference, unless (usually
> -  late in a release cycle) there has been an announcement to use the ``next``
> -  branch of this repository instead.
> +  patches is by using the ``git format-patch`` command. For a patch that is
> +  fixing a bug or regression of some sort, please use the ``master`` branch of
> +  the mainline U-Boot git repository
> +  (``https://source.denx.de/u-boot/u-boot.git``) as reference. For new

Please also remove the tick quotes around the link, it means we cannot 
click on it anymore as it's basically "verbatim". Maybe in a separate patch?

Looks good to me otherwise,

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
