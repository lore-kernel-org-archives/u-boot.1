Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E7D0C27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 14:10:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DEB488271;
	Mon, 17 Jun 2024 16:10:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="O6dkzU2s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D1198829B; Mon, 17 Jun 2024 16:10:20 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20705.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::705])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26FCD8819D
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 16:10:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTBB5dvjxkVA3F4KoGWFGeITtBnCG4K5Q1f/kZ1AlGfVUiUmUa0HfkQgQu258D1RMn7gBRqwM7S7h5ZL/KMqxl9dYUf0/7eVhK9OG5C61pPtQu24xWxKNV7gDP8nu7r59RVrDp2YPTtxm5Np3fHPYsJrvyyeLpQKrV9CgB5JWqNTF2PS6RMtJOp7Y4Hcq1nGIZDaouhGSGlLLNQ3mJXrcAckrN5ngbC23Ys/3KGfrYSR/fl3M4HLBP7JqDWt6Fw0KhypUj84Gwc8KdczKJC6TakDgWwSMGXAMiPYF6ptmmcVSqZPA+MIoJj6m2DnQjSzMUpbbdbOdH5YoYcBpXTnEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FvynB/zcWjiALU4zQiOrpos6rjU3rOo1SuZpzaZvfeE=;
 b=SxgrY0ZWlh1JKnrL7JEBy8OeceBZlYGddaeagQ2U/5rdAkGRUBN3WPfukuIJ1gVtu0LioRduq/ZDBndaxAgPoV6Vk2olLI+kK3Rb28VimJS75SR7dd0aCZYFvd5ib+kx3IrlRURy43OCU1GGS5OKj9/AtkL9kXyLj6iWz4CxAr3DU+y7uzH0qccGg9uvET91jjhaeH0Vf0C39+ySluuhj6JKAJA+aTl/BVw9DFYpahFrtQX39g8E7wHpsfNRyd4AZcPzp3xcQMp2Fja+g8BLOxcykytduU0fXRxmKglIT7YM2lOU9NEQ6LRFDeZknE+qv7eSg2X2BZe5cJiZEgQyXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvynB/zcWjiALU4zQiOrpos6rjU3rOo1SuZpzaZvfeE=;
 b=O6dkzU2sPqcxhnTAkK2wSzMZDLi/dYI6AHhz9oEwmjhgpVnbrxJfsQ91ZWXvBpYXZRaIBpb7YrXRdgILnxMUpNIYipTMLwxqbI0ZfFArypItxa3b9heYEV/UeZ59cpRdJaoBLIcXXxqsZZtQa2cPZwgGh0hRi5vLUwhfJZo3h8A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by VI1PR04MB9739.eurprd04.prod.outlook.com (2603:10a6:800:1df::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 14:10:15 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 14:10:15 +0000
Message-ID: <46be03e2-c456-4842-9dc3-9a3f975d9980@cherry.de>
Date: Mon, 17 Jun 2024 16:10:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next v3 5/6] power: rk8xx: properly print all supported
 PMICs name
To: Quentin Schulz <foss+uboot@0leil.net>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de
References: <20240606-misc-tsd-v3-0-728d721c464a@cherry.de>
 <20240606-misc-tsd-v3-5-728d721c464a@cherry.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240606-misc-tsd-v3-5-728d721c464a@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0043.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::28) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|VI1PR04MB9739:EE_
X-MS-Office365-Filtering-Correlation-Id: fcc07968-34a9-4d18-ff1a-08dc8ed735b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|376011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NTFLT05xWWV1U3VpUklLbDhRcVpxL1R3VE96bEVPTFBMMXFtOGJPNFhKYXl1?=
 =?utf-8?B?dG5sQ1FpMXl5ZnNrTTN6NmxMZjNXTEhkcVNFRDErV2Y0TUNmQ3BXeGZNY3hl?=
 =?utf-8?B?SWlXQndCb0NtTlh3RVE4aEFRQ2JGZjhOSjcyRFlmbUU5d3VVWnhwRTRaL3pn?=
 =?utf-8?B?VlBMWWM4dEJKSm5ON2pRc3lhVUJRWEoxenJneWtZV1BqazNlcUljMzFGT052?=
 =?utf-8?B?OHBRRjlnVTRKSkFXMlFBcERCNkxkQXI0Q0t1TXdTVTdoRU1SKzRPc1pPMHZi?=
 =?utf-8?B?RUVTMVZGZGdFZU1XTmtSS1RvUGNrSHo3SS9sMlgvM3dheEV1ZmNtdUtLMnJS?=
 =?utf-8?B?ZElPZ2puWlJSTit1dWJhUUxaTE1YL3FEeXp0Skx4dXlxRWJnUTJTdGtvbzRk?=
 =?utf-8?B?V28ycy94RXdkUjNxVFNIbVpEZ3pCcCtaaG1UZDFxcVpPZENRaStDeUhVQjFH?=
 =?utf-8?B?UkgvVVQzTC8yaTZUTy9nZGlhUHVETlBQODdnMVBJVW1VaXI3ZTlFQmc1dVQ1?=
 =?utf-8?B?bWhiMHFsWkpxNE5QbDQ3ZkJlaG13TGRiMXRlT0JjRXJrL0tIbEJQVXVGbE9E?=
 =?utf-8?B?bndJaHQ1SXp6TmoweGczd2locGFxc2dXTVVFUUZBZVFhY0FzQXFQL3NqVEhy?=
 =?utf-8?B?Y2VjdzV0QThlRGFTUDZuNHZ2Q28zdnZVTDJnbGNEcXRLbFp6L3I1bUt0Z2Y1?=
 =?utf-8?B?WDQ5QWpzZVorRTFYRTlKUGgySzVvRCtsbmg4UndZcFo0aHZ3TVUyS0ZBSVFr?=
 =?utf-8?B?b2gzNU9GS2hFUDRkdVRCd0xKSCtMeXBvRFN3UCtqNi93NVgxRmlSZU5SbUNU?=
 =?utf-8?B?VWJ1eW1sak4zRGZybVNGWVRGeS9OSENGR1RqVVJXY3Q1Z3VFc09lblpQTHg5?=
 =?utf-8?B?QWtFaFBWcUY1YXlvNzN5TnFnYXVaQS9lS2tnRS9YcS95dHdvNFVpZEZqejNO?=
 =?utf-8?B?VWxhV2VkYy9VakpiZzQ2VFdOc0pleHVjOTIrMEllMG5tdFpYOWFZWGlYYmhE?=
 =?utf-8?B?UHh3Z0hXN1JHS0o5eEdyU3ZDTDFWeEJKYnF2SFFBcTdSQ2d6b3M2T1FVYnNj?=
 =?utf-8?B?eTJxeWp5UktTb1F6RjVhb3Q3K0orRGRaa1FJR3dCVEVJdnh0ZGZsMm1oU1g3?=
 =?utf-8?B?OXpadE9uV0tHUWo4TDM2anFaclY2bVloQ2NjQzdYZ1plQy9kdlRKVHg0V01Z?=
 =?utf-8?B?MHUzaEMyTE9QRFhlUlFPdlJyYlo5YVBSYlZBMkJveXI2MEdpWTJ1Ri85SklP?=
 =?utf-8?B?VjcrbGF5KzV5cTdxYW9JVlpGLzZ0Q2g4Y242YUwrQmx5ZkxsVUhVTnJGK3Z2?=
 =?utf-8?B?YTFhRXoyZ05JcVN2OTVpN1dtam9sSWpCUUEzMnA0VmQzTXkzWkV4Y0NWZkRV?=
 =?utf-8?B?eE1Lb3VDWHJESEhENkptK0RiR3ZGd3A4MTF4K0VadXNFeHRobzFRWCs0bm56?=
 =?utf-8?B?SkNpeFFnVWM5aXR0VS9pYy9rbVBoZXR4TWlqdUR1eGFpc2I3cWtPT0k3NE1i?=
 =?utf-8?B?MTlPQUMxTnlrY3RwL2g3VlNxb3B5djNCV0JKUUFjTGVvUTBjb1pPRzlpR0RB?=
 =?utf-8?B?ZHdKbDBYQTltUTR1d2VlZnEvVTM5bzRnbnl0MThXSU5KNXlRM2lkamY4NTFw?=
 =?utf-8?B?UnQyNzFYSDJpZkVTdDJRSS9jbUttclRPZDlDdnQ0NVdpR3VsVmVCcWFkVUR2?=
 =?utf-8?B?Ni9LbFZkd3NmVEVzMzZuTGNlQW9yTzN5RWxPWllPbnFSbXZocVl5dEU2WmRu?=
 =?utf-8?Q?UazvPJVY/7rzca5n9mLAL2TOkob7IPB0FTjP++8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(1800799021)(376011); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWMzYnZwVFZBOGxqRmxaWWJhSERmUlJIS3luMWVBeklxQzduaEZmdzRqM1Mv?=
 =?utf-8?B?aUNkNkNSa0NyUWVlcEVGY2FsVlAxM09hM2UzWjhYRm5PaWdWNWdjbDF6cm9E?=
 =?utf-8?B?YytSWmlBb0JLMERicTYrZ2x5alIvS1QxRk1PbTFPT0t5Tm8vaUcweXVzSVgv?=
 =?utf-8?B?T0YySGFLUjBSankxWWo2NzlOM0FtMTZhcU1vT2hDMG5vczY1YjJhY09PbkMy?=
 =?utf-8?B?M1pJdXByejAvUW5Xanh4OHBJbWc2QUg0akszdjNwL3gwd2tsSE5kQm1VYUVq?=
 =?utf-8?B?QTlvK29nUnVVWlV5d3FSd0J3RnVrSXRjc0xaUWxVTjVrUHpLYnRlVFpQQUZ6?=
 =?utf-8?B?MzBKQkNyY3dVSHNqcmx1MDFFSkxCZXp0ZkE0S0xXR0s5UWNHaEZ2UHNNT0Ft?=
 =?utf-8?B?bDRnYm4rQVZuL05nNTQxL0gxTWVseGFkRTEzMVJRQ08wWkJzVHdKVVh3Uk1R?=
 =?utf-8?B?NmhqRktnZGhWNVUyd2sxeXdhTmkvTEo2U2VhRXlNNTRYc05Kbzg2dGZiREpl?=
 =?utf-8?B?aGYrNUl2ZnZWQjRQVXRMUlhhOTZaTEZtaW14UjNUb0RsNFpTNEhIdVovcll4?=
 =?utf-8?B?cGVJNElJd3kyNGV2Rmt5L1p6YUhncVVZcmtmWFRMRzFiM3VJY1NXZHU4UFJX?=
 =?utf-8?B?eS9QOCtiYVJTWDZCVm13aCtHTEhZdE1TalpjWmVudDV2L2FJTEQzcHZ6SzNF?=
 =?utf-8?B?TnhvbFBTMWFoQW5ydk11L1ZlcHB0Tzl3ck5ERTkwdjRFdXJVeFc0SjRMbDdB?=
 =?utf-8?B?dmZoTFdNb0pwT2EvVHNHOTA4T09HV0NvV3d3L1JvelVSOXdxbUN2TnB3MHVs?=
 =?utf-8?B?MStOdStkSlgyeGMyTjBtOVZnem5FQkxNSVVIT0xuNkdZbGhpdlVGNVBrRkQw?=
 =?utf-8?B?ajREYVg1R3pCTnc5TmtQMVFEWHFnQTEwcmZwTm10YWRvZzZTRVFhbDc3Q3pU?=
 =?utf-8?B?b3pNb3BnQmJHZUphMDdzSlc2S1J6dyttTmV6bVc2SVZMZzZlWHh5RStCZDFY?=
 =?utf-8?B?QXV1dDVsL1ZnOE9Idlg5NEZoS1lEdjVNSnRNdmxzUUEwQnBVbERjK3o4bDl3?=
 =?utf-8?B?Y1YrWDZ2K1R0SkNyWE1VZlQxWnRHQkVUZFRyUC9WWGFkR1diVXRBbHRMVkt4?=
 =?utf-8?B?OVlEQW5zdGhHeDY2eTk4dm94bFhQMThlKzFYYnhMN1IwSmRtcU51bUlyYmYv?=
 =?utf-8?B?WGZLWWdmT3UrQlRhYlBRV0huUnZzMmVUWnRqNmdSd0xNc2gyOXRVNFdHSFox?=
 =?utf-8?B?dVNHY2U1VDJFT0NxSkVjcWhtVE92bFBzcFRDODFibVI4cUhyc0hrU0s4V2E0?=
 =?utf-8?B?akVOYmRIdUxvNWlQMkJnb1RUYXlwRU1OVC9YT2tLZ1doRUdpM3o5ek9BV3NN?=
 =?utf-8?B?UzhUZTBZVmF6M3V6QTdEakt3UHhCMzVnQUdIOEpJMTZYVHVTRHVsRTk0ZGFZ?=
 =?utf-8?B?UXA3MUxudExkMHRqUlh6RUcyTG5OUkpqaTE5QW1qOFAyeTZpWVlCSVA1RWQw?=
 =?utf-8?B?M1M4V1BwZDc4K0x4SS9HT0RSWFUzdHQ4Yi9aalBaT2txYzMzSWhrV3FoRita?=
 =?utf-8?B?b3lOOG1lWUVVdUZzVDVlNWtxQmZKKzVwUlJyMnhpN0lDa1VkVnVySXBhVGdL?=
 =?utf-8?B?bHNObnZUbitWcW5vajV0T3NsazZoZXV3NzFqY3Y1NllDM2YxMytML1RRbzNl?=
 =?utf-8?B?QkNqR3pGd255cWwvZWZ6MnlBT3ZhQzBZNUtUSnVkSXBGb2JTSG9nL3hUcHdC?=
 =?utf-8?B?dFdCeHFkcmxDTTlvc09MV21jNy90Sk8wUnVEZ0pTLzdwMDRjR2IwN0p2aEZ6?=
 =?utf-8?B?V09DaG9CSHFNNjdoZXc3cTFXWk9mQ1hzMW5RcG1Sb1QyeXB6cVNYTzR5S1ZX?=
 =?utf-8?B?MTFaaTNaaFFBSGJNVlpUMFZXRkVNZ1IzZ1l3QkJQb0JkVEl6aCtHU2lsRkhr?=
 =?utf-8?B?bHl0MlRDUGE3c2V2VGt5dThrR245QlVvU05kbkcrZWVzcGpDZysvL2sxU2tN?=
 =?utf-8?B?SVBLU1lYTGk2RDFlMTJaSTVtRGVxcE5pN0tCT2M1bWdiT1JRY0srQWN6aUYw?=
 =?utf-8?B?SmNSMTNyT3FEalp0S1dOeFhtMjYwV253VmtuY081NmtsZDZqZGFYQjNsekUz?=
 =?utf-8?B?TVozUFArc29VWXZOT01VTVRvU04vTWJ4ZGRzREdUQ0RTUFg0TTVrV2RCcFYr?=
 =?utf-8?B?S0E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc07968-34a9-4d18-ff1a-08dc8ed735b6
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 14:10:15.3005 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6qXlI9i0TLzOU9wslUklVPLq6LW0QZFRp1mk9d+LNlUTPm+TBXnZGQD1XNt15nN5xRIIDfa4wMeQOWDRM+AcRcf7iE/djoJsphzvnRVaKlo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9739
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

Hi all,

On 6/6/24 10:45 AM, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> The ID of the PMIC is stored in the 2 16b registers but the only part
> that matters right now is the 3 MSB, which make the 3 digits (in hex) of
> the part number.
> 
> Right now, only RK808 was properly displayed, with this all currently
> supported PMICs should display the proper part number.
> 
> Additionally, when the PMIC variant is not found, print that value
> instead of the masked unshifted value as all PMICs we support for now
> have their LSB ignored to represent the actual part number.
> 
> Tested on RK806 (RK3588 Jaguar), RK808 (RK3399 Puma) and RK809 (PX30
> Ringneck).
> 
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>   drivers/power/pmic/rk8xx.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/power/pmic/rk8xx.c b/drivers/power/pmic/rk8xx.c
> index 12ff26a0855..617bb511e4e 100644
> --- a/drivers/power/pmic/rk8xx.c
> +++ b/drivers/power/pmic/rk8xx.c
> @@ -6,6 +6,7 @@
>   
>   #include <dm.h>
>   #include <dm/lists.h>
> +#include <bitfield.h>
>   #include <errno.h>
>   #include <log.h>
>   #include <linux/bitfield.h>
> @@ -277,10 +278,9 @@ static int rk8xx_probe(struct udevice *dev)
>   		return ret;
>   
>   	priv->variant = ((msb << 8) | lsb) & RK8XX_ID_MSK;
> -	show_variant = priv->variant;
> +	show_variant = bitfield_extract_by_mask(priv->variant, RK8XX_ID_MSK);
>   	switch (priv->variant) {
>   	case RK808_ID:
> -		show_variant = 0x808;	/* RK808 hardware ID is 0 */

This line removal is actually incorrect, I should have left this in as 
we cannot use the same logic as other PMICs for RK808 as it returns 0, 
so 0 masked/shifted is still zero.

I saw that Kever has already sent a merge request for next with this 
patch, so we have two options: reject the merge and I send another patch 
for next branch, or Kever cancels the merge request, I send a v4 for 
this patch and Kever sends a new merge request? How do we want to 
proceed with this. I have a feeling the additional patch is going to be 
easier for everyone as 1) it's for next branch, 2) isn't breaking 
anything except some info message, which was already wrong (but for all 
non-RK808 PMICs :) ).

Cheers,
Quentin
