Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A385FC02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 16:25:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 405B280BAF;
	Mon, 10 Feb 2025 17:25:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="J5d0KQFg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACA3B80AE6; Mon, 10 Feb 2025 17:25:29 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::620])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4AE280AE1
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 17:25:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OsSjFy2CIM0xCFVyVO5lUJuBIb08U+jX5vrGP4675jraDjaMgW9eLnSkSlQhjiKs4ePysgm5RI21hZsiCiUaMnIXnWA5SGnS/nhY0S+mQ7Y9UaOPNdaBWQfQIUh0yQg2CnEQ/v77RtylJUKZrZUS868K2lXaPGIK0q88GQDoP6oK7a4ID97UKjiNOXvodnUJXXAyMGpH9yS9+/YkRlIDsV1ZlmgCfVRWH/4M5Z4kJJsQFsrTtEp++T3HM471ZxlBHTce78xc5vMRR+qQ9t64IPrNvN6kxK9kzUIOcJuA7OSilmUXi2S7YoESscMIz8oB6uvAl+2nw4f2YO9IF/sKyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2o4Za4flQE9V8C/e7+qz+B07KnDQ3aeeeEMKH6AGwP4=;
 b=Fi1T0HdXTsIpbJIuIw0CSvNYdmeKt+nwp+V2EGyhA3se2z8NpGNz5RIjxHaGkE7CO51V3N/eFb3oJzyXw1eOjMHlyUGgYR/zNnZQkyQwGqKf/GJhDrmffAzquBPqnpMKR/RLoP2ZX1iOwobpZANFuTZiAVNd2PMKJ98QCEHUuDn9PHKgPFKlv3HRhVpvS1GFQ6ESup3IQgOEHGkDGH8ABFhVIJnpyhd9LxszZcUjTEUQzh4r0nAIGpPI4SJ5ANTs7G5P4METjn9O7c7uwUswiBoE5QaogaHEArM7y/1Im3UUjYt++nYKsxWFoTkg6JW5FkHPEIjpkGNI6pkPJOUu8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2o4Za4flQE9V8C/e7+qz+B07KnDQ3aeeeEMKH6AGwP4=;
 b=J5d0KQFgxD7hePngJTiXcS+XZkltA/5fn23384iPivHCIgNn4vtSLhmeP6oDvBcqmel8hEZoczzOofiqG7PmROodpicFfRJ2AifvJUTWWJmU5rKTt2u2XwZlg2CSzeP+m6j9hCWEO6EpUWJvvmTjFOp890s72lZjwZ5vlu6z6ds=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA1PR04MB10652.eurprd04.prod.outlook.com (2603:10a6:102:491::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Mon, 10 Feb
 2025 16:25:25 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.8422.012; Mon, 10 Feb 2025
 16:25:25 +0000
Message-ID: <fc2c6f06-98d9-49d3-9ce5-46dd675e8846@cherry.de>
Date: Mon, 10 Feb 2025 17:25:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add 'bootsource' /chosen property
To: Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <foss+dt@0leil.net>, Ahmad Fatoum
 <a.fatoum@pengutronix.de>, Heiko Stuebner <heiko@sntech.de>,
 devicetree-spec@vger.kernel.org, u-boot@lists.denx.de
References: <20250205-bootsource-v1-1-95f4ba69ac27@cherry.de>
 <CAFLszThr_vLbhU7A0_0VTLCGW03k6NmtxLVoW7OzrtxGFertZg@mail.gmail.com>
 <fb6792e8-97c5-4d0e-8ded-e73ea3a7513c@cherry.de>
 <CAFLszTg9-jMk0PBBSEVT=FonzRUNJOQ5NBMdDYUihWS8NkMhbQ@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszTg9-jMk0PBBSEVT=FonzRUNJOQ5NBMdDYUihWS8NkMhbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VE1PR03CA0011.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::23) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA1PR04MB10652:EE_
X-MS-Office365-Filtering-Correlation-Id: 335e5de9-cbd1-4c1e-4619-08dd49ef85e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXVuSFdyaTBpU2FDdlVHMVp2LzhrN2tieUVJcEk1NnpVOFE0aDIyTklwZFBS?=
 =?utf-8?B?M09WYVh4N3kvMWFBREhXaEdaU2RKemFqdVl1K2dneDExY0FNRXcvQ1paZ29Z?=
 =?utf-8?B?T2pMUUZjVWtsbzlrUllVQUx5T240N1VUQi85R1EzdjJVQmw5NnhUTUxTZk9k?=
 =?utf-8?B?QWF4aTJ6TklTUFNmSCtZN2wrcjdHZnpERllTUzZPUTRWMjhuOTB4Z29zeDhv?=
 =?utf-8?B?cGViVDlKZ2ZZU05tWnJCMXlRYVNiejBPNDQwejdZdWMwTXd1SEdXTDlhK3o1?=
 =?utf-8?B?dVdMRnlZYUg1SDJFRXJWcnB5TE81c1NmSE1sQ0s0YWlKMmIwNGdDdkFhcDhB?=
 =?utf-8?B?WXdJRzI0aTdKOVV4eW1vVGFKQ0dQd1ZhS0wyOU5POFFkYlQ4RzIyZmY2ZHcv?=
 =?utf-8?B?emRkVDM3NXc4Z1c1Q3dtSVJmYzJLVk1ZWDhDWVIxdVFvOG8yTEZaaWt5cVh1?=
 =?utf-8?B?dGJTL1gyeklQUEVLM25jLzNneFo4YkV5NlQwT0MzclFtc0ZZUlN3MjFPRGEr?=
 =?utf-8?B?a0FBeUZBSVpOcDlKZzdJVmJkR0lXc1l0dGJmd1dwaTZqekhMVXZiV01JeFZO?=
 =?utf-8?B?cnRlNVhYdCtBbHY4Y2N4QjZyOEhsZWZDd0hFTHNNYjZocmV3WmZ1YytYUndG?=
 =?utf-8?B?eDdFM2xDQXkzQVhpRW5KTnBNR2RKRU5Mck55RCtXOHREMmgrSklKdmlqRDgx?=
 =?utf-8?B?OXMrWnJ4TVlVK3ZRZ0pxQkt2a1g5OWtrYktBb0FUN3Z3ZU1sZm5UdjUvMGsy?=
 =?utf-8?B?N0ZFdk4yWHV2NmpkaWR0T09ieHR6OGJOTFc4a3UyRzVhbkRsYldLMElNdVI3?=
 =?utf-8?B?SlREYnlQK1JpdCtYbWtBSnVGSTBQSDlkV0VnZ2lSa1hmeDFaT2poUUttQk51?=
 =?utf-8?B?LzFzQUh6LytoL2kvQ3BKbFFiMy8zMFZMM0l5dVloc3hxQnZzZDRMTlV2dkF4?=
 =?utf-8?B?RmZBY3BpWjJzNCtSek80OWNHeVkwK3VwQVQwWnBGWWUxUFFQUUhURk5Jckl0?=
 =?utf-8?B?NlFhZmtoWnA2Q3ZybmQrRE9lQW9udCszWjFHYUtncFNzWnU2SEt0QU80Qlk0?=
 =?utf-8?B?K0l4aTVKKzkyb3dtdkNRMDZmTVZkRDNBc2JtUDgwd0RMZFBZeUZlM2JJRTFp?=
 =?utf-8?B?NzBkZUMzSGpLRkVTUzJuVk9wTUtZbFozZnc2bUF4SHJpMEJMclVhendMb2lV?=
 =?utf-8?B?WGtpb1NZOWRLc1ZzUWxXY3FZYjRQYnJmTFVSbGlrZ3BnOEs0dGhZbmlaMm1U?=
 =?utf-8?B?TDEzOTNRbnF6bVl2a2toeU5qdkdNT0JURXd4U3B4aVQydlpOUEFQSU5QbmFU?=
 =?utf-8?B?T29UNXo0ZkhtOTZXZW1CNGtFcTY2bEpaQjM3QWJ5ZmFWM1VhZWZUb1F2eHBB?=
 =?utf-8?B?WUM1bCtEdnYydmNRSEtLT0tEeU92UG53UkJJTDZBYjU0MWJiYXkxWlB3cEJZ?=
 =?utf-8?B?T2VwSkxjbElXR3NKL0lyNFAyc3dWWXRFUU1iVDRNVUN3WVpNNU5ZdE4velAv?=
 =?utf-8?B?Y09sWkt3T0lQWUxLZE92MlhibGNieHF0OFNwbG1NRjBKRFovNCt6Rkw5S01W?=
 =?utf-8?B?QUlUcEk5cDVtK1BXMEt5VEVwdGliOE13UEtpTG5TUE1aRzR5SDlTZ1VSWjhz?=
 =?utf-8?B?Q0RSUDNMMmZrcnJVMWtCYVdCVkZSUUNZRkVBWXBFeFRMRis1bm5XQ1BlOVVK?=
 =?utf-8?B?TDVpN2VIZSsxWEYwVk5Vd2wwcmpUOG1ERE1vQ1pUaTgyUkFGSUhJYm1JcHpm?=
 =?utf-8?B?T0RvWDBMcEs0bWp2U0hWbXVscXRmdFMvQWJQY3BZU1FPSWpTVE9tSkpiMjR2?=
 =?utf-8?B?L1l4WjVpMHdadkpaSVdieXpwOStrbEFYOVkvNUxyVDk4ZVBDWlBFQU5KL3hS?=
 =?utf-8?Q?tVbFHZY2TzN0Y?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXkyOW5iTTFtMkFraEZNTnprYXJrWWh2eHMrUlBndEJoM3A1emxMSGlzbGxX?=
 =?utf-8?B?bmIrUzJMRGlZTzVZWU53UEEyd283NHdreDVEdlNSTllIQW5tOWtLeU5ZM2ta?=
 =?utf-8?B?alUyMFJ0K2NpQzQvZm5mQkhtY3BGMWIwUUlrZnhBaWVGbTlOOWU0QUJmMG50?=
 =?utf-8?B?L240emMyWVh5T1pTQlhnakZVbEVaVWdFV0xYcUFYRllONy9uKzRLb2ZmZStO?=
 =?utf-8?B?VnNXVVlxeHRVeEVwejBrUCtXU1VDS1dzakpaYmNra2czSHZocTRXZlQ1V1R2?=
 =?utf-8?B?NmlMOXVNRXlDaUtqWGtTUXlhN2M5YTZiNU5PTWhlKys5eUUvNGpYbVVrSFlj?=
 =?utf-8?B?czlCVlJrUFJSZFcrY3orVElMZ2pSeXZKVFlFSG1IcWRwU2VzaWQwdHlNUjU0?=
 =?utf-8?B?ZDdpdUJ1WU9sV1dSRFVvdGRVZ24ybWJNNDBoQkNlRnNCSkE4alFJdEp0MFJv?=
 =?utf-8?B?Z0VQTytrUGNnTVRjR1NsRHY3T080OEJBZi9vdXFWclowU2xhOHkvUytZSEJC?=
 =?utf-8?B?UzZzVGxHZjA2NWt1OW5TR0pCd3d5anMzL1d4eHY3MWJ5bVNlNFNkWTREOEZl?=
 =?utf-8?B?QWU4MFJuQk00U29oblE4K2JOZVV1cEtBTWxGN2pnd2YvdUJZMXh5aUsyZnVX?=
 =?utf-8?B?QWhsWFg0YUV1a3VHOCtKeE9lVzFWckkrbytBMTV3L1A0K3FuZ2xCc2VmU0VR?=
 =?utf-8?B?R29NdHRBazlGUjg0TE9Ra3FZSmIzT215Y3YzUi9JaVVSL3JDTFcrU0FmUm9N?=
 =?utf-8?B?REtjSVh2RkFDTk5ZeCtiay9YbFJXekxuQnY2VnYxSWFpcGhnNDc1SFpiTlFw?=
 =?utf-8?B?eVhxYjQyMnY4Wkh3NzQ4WWhvYW9zajdJbUJtY2dPZ3dQN1N0VGxYcEVjRlVN?=
 =?utf-8?B?c2graXBqdUZmdmswdER3TTAvc1laR3pPV1hoUUl0MHIvakRXWXVCNGtoUmI1?=
 =?utf-8?B?UGE2bVlHSHVMR1RVVjdsamozM2dDbzNHVFNkaHJhM3RiZGZtRjBaMXUzTHNi?=
 =?utf-8?B?dGl5MjlJSHBDR2g2M01DdnladUtydFV2ZnN6bEduNW8yZUhTY0E0bWlBOEJj?=
 =?utf-8?B?bXIzY1g4TzdlUWxLd2poWHlDTm9uV2pzMFA3NE1UdWdvYnBKSGhJZXJnbzlL?=
 =?utf-8?B?djlwVHFHa21QVHh2UHkxRnRleUswbGMzMFEzcXVZemJBcHNJcFlFQVN2eFpJ?=
 =?utf-8?B?eGdGakVEY2s1OXpZbDFtRHNKUXVzZ1NsMWt2bUNFRnZaT2o0TlVDOGsydlRS?=
 =?utf-8?B?YkkzWjhhVERKVzRTa0V0Q3ZZV0I0WkJIRldMZmVhRHFIRytuWjQ5NkVPVFpG?=
 =?utf-8?B?MHdaUzNKTUk1c3g1YkNhYlBVcjY3T2RjU1VpZXFmNldmTU5uR1ovTVBMZDZk?=
 =?utf-8?B?Z0pjSHp2Vm1Da0pwaEQrRDZRNXQwN2lOTFcxU085UDA2MytLSmtRblM4REFY?=
 =?utf-8?B?RTVUMWpTaGpGbkY1UnNTekxGMnZYTXZjTXVXbUIzK3JoaW9WQ2ZtcU1tQW5u?=
 =?utf-8?B?K0xjVlY0RWFyNFVkRVFQUVVoeVg4bkY0aUw1RVpNZXhKOW5Pb1QyNlluRlNm?=
 =?utf-8?B?VkV6L1Q5NFU0WWtFUXRqSkRNcGNYMVlnRVdNbGlydHE3dSsyNGtQbmExS05z?=
 =?utf-8?B?V2tTYUFaUjNaVlJoc1QzdXFKMjQzRmdNVDB4bVJGdWNVdjB4dHp3WmF1ZFQv?=
 =?utf-8?B?YzIrL0lNYWh1QWI4dG0vNnZZV2YvNEhTVHAvdVlDNTFIRFhKVFJWZXRSaDQ0?=
 =?utf-8?B?cE9pM1ltdkorMks4czEzWGNiTVg2WFFFMng3a3dzK0ttUExQY1kwQWhlSllS?=
 =?utf-8?B?NEZFVncvTEU4VkFHdDVJSnp2TEpYNVQxMzlwZW9rS2pPS0xrRStTTENjZnlQ?=
 =?utf-8?B?TldCclJyeXF6MEhubkxkVytYbTJ1UU5qV2RucXBUVUlYYTZaWXFwM3g2TzMz?=
 =?utf-8?B?WjJXc09SRkdGNFVSR0l3dmxnZEFmRUpqazc5WitsbFZ5Y242UDF6MkcxRWN0?=
 =?utf-8?B?V1pFVGlCL0dEZk1pUnV4Zisyci82YVRtbXZjR2hvYWQxMCt0eHIvQVpoc0tu?=
 =?utf-8?B?b2FEdHh0YkFyUFlGK09zL2Jaemx0QjI3ak4waFUwNVNWaUROcXFOYm5WbVBq?=
 =?utf-8?B?TUcvQkVqelNDVUhjRDF0OVhvTVNpZUVoWW15My9EejZEZUo3NWFFaTNQRksv?=
 =?utf-8?Q?b35to690paUxh3uH9mHof+g=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 335e5de9-cbd1-4c1e-4619-08dd49ef85e2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 16:25:25.0195 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NnCx2PSK9CGtE6T4le41yfZ9gcle9dc3AVQib/S0BIcezd4EABvM+vcVzALeWFYAD87XZL3GZLVudfSZGPB3ym8n1HLB89oQFDF4mlHsLUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10652
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

Hi Simon,

On 2/9/25 3:28 PM, Simon Glass wrote:
> Hi Quentin,
> 
> On Thu, 6 Feb 2025 at 08:46, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Simon,
>>
>> On 2/6/25 1:33 PM, Simon Glass wrote:
>>> Hi Quentin,
>>>
>>> On Wed, 5 Feb 2025 at 02:12, Quentin Schulz <foss+dt@0leil.net> wrote:
>>>>
>>>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>>>
>>>> Bootloaders typically can be loaded from different storage media, such
>>>> as eMMC, SD card, SPI flash, EEPROM, but also from non-persistent media
>>>> such as USB (via proprietary protocols loading directly into SRAM, or
>>>> fastboot, DFU, etc..), JTAG, ...
>>>>
>>>> This information is usually reported by the SoC-ROM via some proprietary
>>>> mechanism (some specific address in registers/DRAM for example).
>>>>
>>>> It would be useful to know which medium was used to load the first stage
>>>> of the bootloader. SoC-ROM shall be ignored and not reported in this
>>>> property.
>>>>
>>>> This can allow client programs to detect which medium to write to when
>>>> updating the boot program, or detect if fallback mechanisms to
>>>> unexpected medium were used to reach the client program's execution.
>>>>
>>>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>>>> ---
>>>> Bootloaders typically can be loaded from different storage media, such
>>>> as eMMC, SD card, SPI flash, EEPROM, but also from non-persistent media
>>>> such as USB (via proprietary protocols loading directly into SRAM, or
>>>> fastboot, DFU, etc..), JTAG, ...
>>>>
>>>> This information is usually reported by the SoC-ROM via some proprietary
>>>> mechanism (some specific address in registers/DRAM for example).
>>>>
>>>> It would be useful to know which medium was used to load the first stage
>>>> of the bootloader. SoC-ROM shall be ignored and not reported in this
>>>> property.
>>>>
>>>> This can allow client programs to detect which medium to write to when
>>>> updating the boot program, or detect if fallback mechanisms to
>>>> unexpected medium were used to reach the client program's execution.
>>>>
>>>> Note that this property is already set by Barebox and I'm planning on
>>>> adding it to U-Boot as well, specifically for Rockchip SoCs.
>>>>
>>>> I have some doubts about the wording, especially in the case of
>>>> hypervisors or chained boot programs. I'm not entirely sure what would
>>>> make the most sense to put in the property for those scenario.
>>>> ---
>>>>    source/chapter3-devicenodes.rst | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/source/chapter3-devicenodes.rst b/source/chapter3-devicenodes.rst
>>>> index 8080321d6e60d6b1e86c81af86c6850246a0223b..defd1a46e4ffaa4bb085306b5e153d38b740ac66 100644
>>>> --- a/source/chapter3-devicenodes.rst
>>>> +++ b/source/chapter3-devicenodes.rst
>>>> @@ -456,6 +456,9 @@ time. It shall be a child of the root node.
>>>>                                                           the client program. The value could
>>>>                                                           potentially be a null string if no boot
>>>>                                                           arguments are required.
>>>> +   ``bootsource``          O     ``<string>``          A string that specifies the full path to the
>>>> +                                                       node representing the device the BootROM used
>>>> +                                                       to load the initial boot program.
>>>
>>> Could/shoud this be a phandle instead? It might be more efficient.
>>>
>>
>> In terms of size in DTB, phandle vs string probably much more efficient yes.
>>
>>   From user's perspective, I'm not too sure?
>>
>> /aliases does use full paths for example.
>>
>> Having a full path allows for easy consumption, just cat
>> /proc/device-tree/chosen/bootsource and you'll have the actual path.
>> Otherwise, we'd need a special tool for that I guess since it'll return
>> the phandle number and then you have to traverse the tree to find which
>> node has that phandle number?
>>
>> Also, I could imagine some scenario where:
>> - a boot source would not be available in DT yet (though we probably
>> shouldn't write it in /chosen/bootsource since we wouldn't know the
>> proper path to it), e.g. USB loading, this is usually done via a
>> proprietary protocol and/or tool (e.g. rockusb/rkdeveloptool for
>> Rockchip) but no USB support yet in boot program or kernel (that was the
>> case for a long time for RK3588 for example and I still have at least
>> one device without the USB node described yet).
>> - a boot source would be available in EL3 but not EL2, so does not make
>> necessarily make sense to have it in kernel DTB for example. If it's not
>> there, can't have a phandle.
>> - a boot source supported only in boot program's DTB and not kernel's
>> DTB, we probably still want to provide it to kernel's DTB even if it's
>> not a device node in it.
>> - a boot source doesn't necessarily have a label (though we could use a
>> full-path phandle I believe &{/some/path@1f000} probably works). That is
>> not uncommon for SPI flashes for example.
> 
> Well I'm not sure what we are defining here and which programs will use it.
> 

I'm not sure to understand where the confusion is wrt "what we are 
defining here"? Can you please clarify?

Used by whatever and whoever wants to have some specific logic based on 
which medium the DUT was booted from, e.g. software updaters, distros or 
CI tools (labgrid in my case)? If your software is assuming the DUT is 
booted from eMMC while it is actually from SPI, you may think you're 
updating (including security fixes) the SW while you're not.

Throwing ideas right now, but this could also probably be used by 
fastboot/DFU to know which medium (e.g. MMC, SPI) to update by default 
instead of using one that defaults from the env/bin. I have no 
experience with either so maybe that's misleading.

> I don't really like the idea of mentioning a boot source that is not
> in the device tree. In fact that's one reason why I believe it is
> better to use a phandle, since it enforces that. The RK3588 things you
> mention sound like things the vendor should fix from day one, if it
> matters.
> 

There is no such "full Device Tree support day one", especially for new 
arm SoCs. We still do not have USB-C support on Radxa Rock-5B (it's on 
the way but still), the introducing commit was made more than two years 
ago already. I don't understand what's being suggested here.

> If the boot-source device is not in the 'kernel' DTB, then why have
> the boot source there? What use could it be? This seems like having an

Informative?

> alias to something that doesn't exist in the tree. But it could also
> be used to just have "my-silly-device" as the value, with a magic
> meaning which no one can figure out.
>

That's fair.

> Re not having a label, we can add one. Yes, fdtdump does not have the
> schema and doesn't decode phandles, although I suppose we could teach
> it some basic things, or add a new tool.
> 

If you don't use the same DT for U-Boot and the kernel (which is the 
case for all Rockchip-based devices as far as I know), a label may be an 
issue, especially if you don't keep the symbols in the DTB. Because then 
you need to guarantee that label X in U-Boot matching node Y in U-Boot 
also matches node Y in the kernel and not node Z, so you need some kind 
of hardcoding/mapping somewhere in U-Boot.

> So overall, this seems like a balance between short-term convenience
> and long-term confusion.
> 
> To me, the strongest argument for paths is that /aliases uses full
> paths rather the phandles. I believe that was a mistake (it caused
> problems in SPL as it bloats the DT), but I've not looked at what it
> would take to change it now.
> 
>>
>> And additional argument for full-path: Barebox already uses that.
> 
> Were there discussions with that, which could be used here?
> 

@Ahmad, any piece of history you'd like to share here maybe?

What I can say from glancing at the code is that for Rockchip they do 
the following:

Register a bootsource type (e.g. MMC, SPI, I2C, USB, etc...), a 
bootsource instance of that type (e.g. MMC0, SPI3, I2C7, ...). The 
mapping between what the ROM says the device is vs what it is in the DT 
is done in their Barebox-specific DT via this custom prop in /chosen:

barebox,bootsource-<bootsourcetype><bootsourceinstance> = &label;  # 
à-la /aliases

This gets read and resolved and then inserted as

/chosen/bootsource = "/some/path"

into the kernel DT.

> Anyway, if this is the way you want to go, I think it would be useful
> to add some of your notes above into the binding, so there are some
> rules around it.
> 

I'm not sure what classifies as a rule in what I suggested, could you 
elaborate on that maybe?

Cheers,
Quentin
