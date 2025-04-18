Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD94C369CA
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 13:52:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E8B38321D;
	Fri, 18 Apr 2025 15:52:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="DSnE02ua";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B0B083253; Fri, 18 Apr 2025 15:52:06 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60F048323A
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 15:52:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fxlolB1amngM102KlwCGfmvW3ze5Jtg483ojLj72Y7IPrzNiUAARx6N86ELKAu7jnV35A5y5bv0imnMTbBPpBSEjDC08fcTyuTXJFJXJH4cLi+5JkXh9S+0LPYZe2c7+3cJJvhbvyz0B8F0erQBznzNGMv03hv+YMcW5qzzsgV52E//cxy5P0hcFFByAHwjpdAEJmI9eOFFjM4I98HF0ZKEMIY0llH4NvFdpKuwIclEB+16RfmCqHpzLm4op/y395PMIla+U5MpFaAS2XKuvkbrWkeaIjDxpC6/AJFFoGXWKbf/FhrOLVlS9qcjeYByOp1YJfDp6acefEdfkK6BOaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSdHlyz72ShoOQHCyaA1UBH/GJCxbTIGN+rd4Oo59ak=;
 b=mgNFGH7lLZGBSNr+/oDyWHU3f8rHROPUNjSr4tNWT2E1bATxWrWU7r9xvcoplr/Qaaq34jb+eENWvUvSisj1+UlCpGseN936q5SL4jSjFkz0SC2kShl7XIjjRfbGDmRzHOZMAWJq1p9ksTrVcg3f+gcw4QQndAqOh7WAKHG8vk0oqInksnMiXZyVpj/4ytEZeY3HZ0CfbrWQ2ZKZMNsV7vUZMPpt2KNUliVlxDzQZMeUoXfTAlQkYI3mCRw6AMCKdnyBgewkTZviv0eAPHr/HWQg0DGgRpGLNrbhaMM8xcu2NVlHmA7PiOxKnxGhqobV0EV39sgCEhF/GuJhhFEITg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSdHlyz72ShoOQHCyaA1UBH/GJCxbTIGN+rd4Oo59ak=;
 b=DSnE02uaZDNqUfYF5NSILG4wM3aRcTgfCxSeN3U8ql8vDkEv7NEpd58evNsQa3K6F9RHTq/lVw1XSd2MDsKiFM9xMU9uFD4drZGQrVxATiYxu4sLamDaQuxoZWkSRHTfmM1L9jzsrPCFBO0nob0k7xjfiuMfL6mgH6nxYD2jpPc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by PA1PR04MB10359.eurprd04.prod.outlook.com (2603:10a6:102:449::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 13:52:03 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%6]) with mapi id 15.20.8632.030; Fri, 18 Apr 2025
 13:52:03 +0000
Message-ID: <dc5c81a0-2d2d-4d6a-bfc1-189d7f08cbe1@cherry.de>
Date: Fri, 18 Apr 2025 15:52:01 +0200
User-Agent: Mozilla Thunderbird
From: Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH] tools: Fix potential memory leak in aisimage.c
To: ant.v.moryakov@gmail.com, u-boot@lists.denx.de
Cc: Maks Mishin <maks.mishinFZ@gmail.com>
References: <20250418081958.12818-1-ant.v.moryakov@gmail.com>
 <20250418081958.12818-3-ant.v.moryakov@gmail.com>
Content-Language: en-US
In-Reply-To: <20250418081958.12818-3-ant.v.moryakov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0332.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::18) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|PA1PR04MB10359:EE_
X-MS-Office365-Filtering-Correlation-Id: 6910552d-0925-471f-a872-08dd7e803302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VDlMWHBmcmFhclZBWU5NbW5NRTVkaHkrOXhybHpJdWdDYVBhc2lYdTNzVXND?=
 =?utf-8?B?KzBhVjlJTEtmaExJNElGQmZudzFMT2JubHZocGdMV3VpNjVGTWtxcXUrR2wr?=
 =?utf-8?B?TXNiZUxPVXhBSkFLM3RSRjRNZE1EUElUb2NtcGY0NUJ4eVRXNnY0NVF1L3BX?=
 =?utf-8?B?bUl3VVprS042LzA0MVZIaXFXZFFDdmRNdThqWEZPZnNzVWFVcUI4ZHhySk0z?=
 =?utf-8?B?d055eTROSk5yelIvMldVTFBzNHJFek9obGNBaVV6bHlxUmFJU2F5a2syT0ph?=
 =?utf-8?B?Wm1tWHJDQ3prZFJnVVRJV3pyWEVGUTd4ZFlpSEJoRThWQ2NkMlAydzMxT1Rw?=
 =?utf-8?B?U293M1FyTUpuMFVQN0U5V3BQMUZLU0lyZ3ZUanZLakNmMjRVRnNJeEFaTm9q?=
 =?utf-8?B?cWxpNzA1Vnc1RHlFY0Y5OUhTUGZ0Z1FFNVBkYS8yNkFVQXNwc2lENi9ydi91?=
 =?utf-8?B?VzhmZitVL01kdktQNnNZaGxRNitaWGZJU2E1dzJKbHEyRDdjV0g4aXJuWU5m?=
 =?utf-8?B?UFZGR3RYTjZWc0ZRTk9jSVJaM3dXODRuTmJibFpsZGh6NmQycU5XVEJ1NXdU?=
 =?utf-8?B?bnV3Um1IRU9DVmxubkVHU212OVVjbDE5dnRibnlqTElDY2txYm9zcWdpb2hv?=
 =?utf-8?B?cXUzVTk0WUwrOVBETU5OM1Q3VFh5dDNlV2JDQ1NCRGtIekUzK2hTNlVjZFpi?=
 =?utf-8?B?RXV6eU1QTzk3cjliMC9OWFpmWVpLK3NYWWNsY2wvTEdSODB3cldSVklzTVYv?=
 =?utf-8?B?NVQ4U3NhV3hncDNBYU0raW95S0lBM2RqTThLM05VdTdCaHF1T0QvNkJFc2dO?=
 =?utf-8?B?S2ZjbjV3cU5DVnBXVE9uUmxYZFlIaC9tSVlzWlpzV1p3UjJ6dFJIelU1NEJt?=
 =?utf-8?B?ODFLQXNLV0pzSXFPRm96dXp6QnlhVHJ4dlR2RjVieUs5NitVSk9rWFBFTU5L?=
 =?utf-8?B?VWlia3FyVmFHNnZZa0hlN1FHSTVQVGJkem1yT2IxSThtdFVaNEtkYTJwenZY?=
 =?utf-8?B?bHpONkFXdERZZ0JYYWIrN3ZTZ2t4UHY5MHY0bCt3d3dVbXMwVVVmN042TW81?=
 =?utf-8?B?MDE4alJNWWZER0JlazBqVDRDZjJRTWtoeFg0Nzk1U1UxNjZTbWErdkRJVmx4?=
 =?utf-8?B?cEh6dkdDazl4bXpSM0dPN0VUdDdoQ095ZkJ4Nkx4cU1YRTVibERmUUg4TjV3?=
 =?utf-8?B?d3JNZndnQW9TbjVYTjRLK1IrUGoyVVl4L0pOQ0xuSXRUM2NCL0hpc3dhczBs?=
 =?utf-8?B?K2NhN0pyT2VBTkJwNEJoaWc2ZDBSdXVvbldrcWVOTjVjbkpnUzg0Qk5Rczdt?=
 =?utf-8?B?Q3o5TU1hOUhZeGFtZi9xU1pZY21pakhGdGthK0VkNGg2YzB4Q2N6Z0M1dXNp?=
 =?utf-8?B?N3pmNkJldVUzV3MySUZTRG9zVHZEZU8zaUVUMFZDZ0RXaFNOWi8wVmpaSVlO?=
 =?utf-8?B?UWUvcFprTnd2bjZMaXZZMmdFR2tQZE41REIvT2xpWnFaci9wQjAyV0I5YlNo?=
 =?utf-8?B?L3EvS2kzOGxkMTA1b2wxb1RudlVxSGJMZVM0VXFBZ3Z3VktneHJpSElxbkpN?=
 =?utf-8?B?UW5tTUJyUTRhTjYydUpGZExQcXIvWWxQNno1a05OVWNGdjU4THJIb1dpY2Ro?=
 =?utf-8?B?N1lhczR3Umt1QU5oQU80UkI3ME1XZXV1cUhGcHp1R0NGZ3FYZ3lKVlEvaTNn?=
 =?utf-8?B?Q3ZMMjhwU0R2ZW9pMXlGTkFUMXFYa2FISkozQnErbEpvMnJ0eVhYeGpacmRS?=
 =?utf-8?B?cWJOaEQ3ZHZYbC9PbU53bWFyT1EwRFZKVlBCNk5QLytuVGJkLzN3a2Z0L1JW?=
 =?utf-8?B?TCtWUHd4NHNUcnFUbHl6UXpxNEl6YkMzejIvYmRFRFY0bEhtQWZUdGhZaU1q?=
 =?utf-8?B?ZjVOVHl5ZnVXZHBsMDVYWkFwUkJ5M1dqSG9LaUdNU2lUT2ZhZXV4c1FQazVZ?=
 =?utf-8?Q?lQz84dWBhxo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RU9obDVhcGJWVTBGR1l0b0NnQzBvYkIwSEtYRVppN3h3RWdLTVhpaTdITDFO?=
 =?utf-8?B?ckpVaEpsRHFndkFIWDV1SUpmYUtqTWFMRG91SVRBSWJ5amxMcThWK0VzWS9L?=
 =?utf-8?B?U0RlV3dncXlJaUR6UFJKZ0YwK29IRG5sUlV2WUJTaW5kY0VwamZUd09MR09F?=
 =?utf-8?B?dFMrcUluT2M5eFhCVHkvc2g0bURsbTlXRFZ3d0J4V3FtUnYzYXNiVjVlVGlB?=
 =?utf-8?B?VllzMlpKNHZaU2hmN211NnNIK28wSWkxMnBvZ3NRRXNaMkRxV2w4MER2cEVB?=
 =?utf-8?B?MnhTNCtpTnNXcWpPQWhUNndzMEpsbTlEZkVJeDhXd1h2TUo1bUJmUVdZeEVM?=
 =?utf-8?B?bHI0enduNFpwQTVuRnRzWTV5QUh0L2Nub1VJTzVIU2ZYNHZDNjJHMHhZVlJZ?=
 =?utf-8?B?UTNDQ0VSOXJvdVBnWmwybVNHdjRkUW9US2NYZEt3SGVjNkZrTnhnS0RDRzQ0?=
 =?utf-8?B?S1BYRHJRNGprRTZ0cU5ONXcwU1VuV1ZrZmlQNnErQW1TQTZxVWJ4RlFUZTha?=
 =?utf-8?B?NzR3eTR0Y0FRZ2FKeGt4T0twT1kyRzBDcmN2WFlsalkrV091QlpBU0JhcG5w?=
 =?utf-8?B?OTcrMFpsWmYyWVJPM0pHa0ZXWktKc2NTWmxvdUtENGQ5RTFHazVpKzMrVVlG?=
 =?utf-8?B?SEo0SW1vOFE0MlNiRkVUaEF5ZDRKczJSUzdRUVdxTGk3LzRrVllkR3BNS3R2?=
 =?utf-8?B?elE4WFhTeStWQ0FHSXBQL0JUcXpTVGpNaXltL2tGSFBSdjJndWxEZERQQjJk?=
 =?utf-8?B?UWVpMFlSNjdDSjkyN3dORXExZUdNakwrcDFTd2JxOTVkQURmZVBxRFpnN2ln?=
 =?utf-8?B?Y0NoUEpsWkVnait5RkNxRFUxV2dNYy9QS09ibndtY2d0d1hGUlZ4ZzA1Q25x?=
 =?utf-8?B?NFBLQVdsY2RPd0FFNVhZWjd3ZzhoY09YdmM5dE14dkJJZTJqNHN0c1lHUFNX?=
 =?utf-8?B?d0VIRml3STUyUnhEYzhBdEg5Vjkzdjd2WXJCdm53cWxWMzNRbklTYTRBdHpq?=
 =?utf-8?B?UmdUNW1IWUE5RFI0UFNLUG4remF2czhQV0ZGWW1aSCtJeHMvUE9WOWJyRDFo?=
 =?utf-8?B?WUZ3L09LYnFnOHBCZVJyeFJzUnQ3VDVyUGlnSnZXZjRGeUtaY0JOdEVBK3Jk?=
 =?utf-8?B?dkZWbW9xeEVGNFQ2N1k0K05Fb0VkSjNiT2wyY3VXR29HYzNVKzZ5WHNHWWln?=
 =?utf-8?B?aDJNUEgzYXRXQS9lZFprUWdFK1U4NlNQMVJOL0h5MUhPTS85VVhPQ0R4bldW?=
 =?utf-8?B?RE5TS0VuNXJBeWNTSzBQU2J3ZndOc0dJMzhFTDAxUVJjN1pJc2FUWm1xUXpY?=
 =?utf-8?B?aUt5UnpTQVJWMUtZV1YvTm5tZ0M5NmgrWk1GOEpGZEdyYUdNczM1RHE2RVBQ?=
 =?utf-8?B?d1JvYnpRL1cwakV1QUJjTXN3dnJNakdTcVdDbi84d2NCK1VyV2pMbjlSUTE1?=
 =?utf-8?B?dFNjSjNhQTU2RmF6Z2dndXUzUDBFMSthUmNaQTVNcFpOcElLbFAxZWxPNlcy?=
 =?utf-8?B?REM0Zi85WDVNaHM3VE00Y0w0TXNieldiTmVHb1YycGNwTnNlajJVNE84LzM2?=
 =?utf-8?B?NC8xRnozQTV4L040MzBVbnQ2R0w3MWMwa3g4RXFIVm9HVXhRRVFLYXg1dldo?=
 =?utf-8?B?L2xLUkR3Sm5CVXE1bUwwVUpESzRKQWcvWkVLcFEwVlpLRHlGTjUzYm5GZ01t?=
 =?utf-8?B?bEZBOUdkT0gvUmhBakVGaHRxekMxTHBhTDVnbUdWWVNKbGk0d3JLaUlWWmlx?=
 =?utf-8?B?UElQRVRzcnIwU2xhOWgyVWQ3b1Q1Y05PZjVmeVpUcUQrY3FPblY0UThhekI3?=
 =?utf-8?B?SHp2UHlIWmVRam9WUDNUcmt0UEtwR21hTllmVE43VzhvQUhieVBOaVJvOC9y?=
 =?utf-8?B?RFpROTlSczMvQ05CTWkrQS80RkJqV1pIaWdpWDdXekg0QXFlM2NORTkzZGc1?=
 =?utf-8?B?ZlVMYUFqem50cU9EMG9aRzI4ME9XTDVvMzdldGtmbkNYMldDZTR1OUFrbGtW?=
 =?utf-8?B?eFp6azMrWUo3NTRHUG5yMHIzVkdKUzB6MG5nMTJLOW0yNmZGaVp3ckpXL09u?=
 =?utf-8?B?T2gyODZ5ZWoxOXlsdy8wUlZ3V2pnZEtuZXVEdFFKMTJlVW9qZ1lIdDZQTU1o?=
 =?utf-8?B?VzIxcXdzczdWTUNRY01SMWpoaTdDM0FyVHdMODM3dkRTc0JNWFNTTDhsRUJY?=
 =?utf-8?B?T1E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6910552d-0925-471f-a872-08dd7e803302
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 13:52:03.4001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q/Vzb82ymyfiWzO2eSqDn06qHVw4zO2u/js/72tRdFkTt5Tpn/Kv7RniU5ztOUK3xMjW+jBvhGHcy6WCjoIfGoHNdxt6Llrn0ThDmP4J1Uk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10359
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

On 4/18/25 10:19 AM, ant.v.moryakov@gmail.com wrote:
> From: Maks Mishin <maks.mishinFZ@gmail.com>
> 

We don't really like empty commit logs, could you please provide some 
information on what this fixes and how?

e.g. here you could say something along the lines of:

line gets realloc'ed in getline() so we need to free it.

> Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>

Same remark as other patches in this series, are you Maks? If no, we 
need an additional Signed-off-by, yours.

> ---
>   tools/aisimage.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/aisimage.c b/tools/aisimage.c
> index b8b3ee32..6091c8d5 100644
> --- a/tools/aisimage.c
> +++ b/tools/aisimage.c
> @@ -346,6 +346,7 @@ static int aisimage_generate(struct image_tool_params *params,
>   		}
>   
>   	}
> +	free(line);
>   	fclose(fd);
>   
>   	aishdr = ais_copy_image(params, aishdr);

The change seems fine to me though.

Cheers,
Quentin
