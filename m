Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B58CAC58E
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 17:26:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3502D831A4;
	Tue,  9 Sep 2025 19:26:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="dT5pOni1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 442E0831B4; Tue,  9 Sep 2025 19:26:04 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D30B78319C
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 19:26:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NNzV2+I6PsSnC7Vbtaaf4ERPjrtzIvP4TZqQfN4KeSEjV6CSLK7F+/C59M6HU8PT4ciM/eMVQ5KXUYIOQUGfXG9p3yLSrWD30v4jU2ZRhfEtqXjWPhlwH4VooxMtVfE4SlQv4D+Qd3edeRWatcDBN+2AcikdaTp93eFX7Q7gW9xcCIYW/FjF3IgdM3+1SGqA1Q59kEdKhzks1eHqkY0AVHz2HPw/jVbeS408+T3eZvbSsOC3tgkYwPKaSBBsOTKPL+sdWpfSjMQpaySEqYCymwBzaNMTBPX3fzNJ9you7RlShRzUsNX0rEttTuijCcc24UWKTLVGx7D8QdiS8wnaaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9t552CwR452+XrtmExdlZ8CjtwztDw5Jav4XhgT9X/Y=;
 b=HuJt/9AaD8w/5zQrPniDWbzDDBuhuebgN2cNmj7AFgyWTFTEpF02xwHakW9y+LBxP+JMaG/mAl28oBpQM1YCEWMtFDWQWwm4B47AjCvyRyhzM1oTJTcUbVU6JPXZsarEUF2IDPJGAa+gEEBxCEh3N2DSbYLXo1qQn5YyvdEMgElcudTUsVunnbmaswQVIGTDhNtxKpjyboNOXiau1XbPvmMOOjKlw/nTheomUj18mhUtONnNN4dQrqPmvnuNAAXD69vDFnWSAWeUO/JxG05ByLZkW4CaywOW2lUqWTGMnKX9C/100qsWcmdOw0GChaD8B6CQJZXfiq+QpslJnW3X3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9t552CwR452+XrtmExdlZ8CjtwztDw5Jav4XhgT9X/Y=;
 b=dT5pOni1sZKtyXLY5f12SEFtOqBRByx8QTrzJTJuPVvTllT60hheBeuebfuBoTmRId7TJ3eCCvnhetBDwmUhJLTmmzMx6k/O0WD0BGNCmMCDL9TdMSga9iHLgzdC0VJbershnEnGB+R2ZO52T8b7DFRPLXNdBO4VSMVHX7MtPaeuFDxnk2cr3t/89fQDIZsjtRVOd/d0iHLUdbCYwze3h/4p10xnS8+Krb0d2nBzGSRwFZaqy8xA5vTI6j7j91EByhq3EO1H3mhwLITEMNAbhu9eIg6r4k/tIE6CdIz3AMRtOaGL6E5Jsi9Mk3Wmk0aH/E35P3TC0iIl/InXaCKEnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8660.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 17:25:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 17:25:53 +0000
Message-ID: <ae031005-e9d2-4676-a2e1-3dfe975cf45a@siemens.com>
Date: Tue, 9 Sep 2025 19:25:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tools: Do not generate logo when cross-building
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Masahiro Yamada <masahiroy@kernel.org>
References: <b18a4f45-77dd-4f78-ba6c-2e017abc98b9@siemens.com>
 <2cbe57e3-f7aa-491f-9896-93f85e8a7a41@siemens.com>
 <20250909145919.GX124814@bill-the-cat>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250909145919.GX124814@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR17CA0027.namprd17.prod.outlook.com
 (2603:10b6:610:53::37) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8660:EE_
X-MS-Office365-Filtering-Correlation-Id: 25622d1a-a758-4230-4c0b-08ddefc5ede8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWJkVG9UOW5IK2tjUWJJMi94QkYwV3RYUWZIUVB1RVdRTlZyY2JqOTBXRzlx?=
 =?utf-8?B?ZEJDU3JPZGF0SmlKWU02NnZJb081eGs4QUhza2tZZHQ0TE5UUWY5cVhnSUp1?=
 =?utf-8?B?dkczTjNXeVBNSWF6b1hCL0RFTmxla2U0VlpiVjBKcFhzeCtHeWluTjFDV09j?=
 =?utf-8?B?NG9UNGlwazhzQzV2aTBtRXBlOEhoclNlT2NqS2tpMXg1KzE0bHJodDVEaDlU?=
 =?utf-8?B?UU1qVms4SzZuYXlNd2xFWXE0YXNCZGR4bnhuSk5nTlh1eGQ3OUszbHgvWlBh?=
 =?utf-8?B?YWpTam1jbE01WUZLaCtsb3F3VUFQczVVaWFhbXVhdUNiNk9BekdFM3JZVUtt?=
 =?utf-8?B?b3l1MGs1V2trUnovRDRuanYzTDNwZk8vTmhYWFdWUXh3MmVvc0lucWd1TUZt?=
 =?utf-8?B?NnV3eUIyZ3VYNjBkNDBLem50SmxheGsxY0N2KzRLZUd3c0pBMVRPaWpMejFP?=
 =?utf-8?B?c1hOcEFlYWlWaUVMdzc2N3hqMHpzd1AvdTB5dTZuMjd6Z0RnSHpCam1IUEtO?=
 =?utf-8?B?V2JTRGhiK0c0VHZnNStYcEtIT1E2ZlNwNFo4NXRTdnN3cnhaVUlzSGo0S0xp?=
 =?utf-8?B?VGtYS2d4SlBoWC9mRDd5bjZzS0VDVHVxZ3NLY1M3NkhHR2JnYWFZMk9YMFd3?=
 =?utf-8?B?RjRtQ2ZHVjAwQ0ZMOVFlOXl3YzFuQWJvL2F1TVNCV0xVd3FEMGl5blJrQURM?=
 =?utf-8?B?WkFqR2dCRDNQdUJPMWlKWlg4d1FQRGxaN2VIeWQ4WkpFKzIzeGMzMWdSWkhE?=
 =?utf-8?B?RmlTNkowaFRNZml6dFMvQkpDUXdmZDMxL0hNTXdZWGdQVXVLcmovQjZiYitC?=
 =?utf-8?B?d3RCcUxrcE5wT1gwZ1BxZXNPc05SZ3BZQm5QZjY2TDBUdHF3U3h2RmlWenVC?=
 =?utf-8?B?SFE3NUdOcE1sOElxOFhCS2FRTzB3U2FKVVNXK0hBRU5IMFIrMklGeW5DMTB5?=
 =?utf-8?B?c3hGUTcyK1lLRjJja05LL0dzZDVVWU5NVVVzVGVSeTR5M1pOWUhUVGk2U1Ra?=
 =?utf-8?B?YWZqVWZHY0ZBNXlMZUk2K1VDdzBiM0t4MGcvWnMvK1FodTJ4OVFhVHN3VlVU?=
 =?utf-8?B?M292MjVFSnN0blpjUmttclZhRFdiY1FweXAxNkNrWkN6QnpuS3JHSkJud3Vi?=
 =?utf-8?B?T3Z6MFpYbk5vbXBaL1ltNWFoME1tMzJhL2FiV3FXbWliWEtrTkQxZ25pV3B2?=
 =?utf-8?B?R2RQOFIrN0l1UzlKdXhTM053bk8yTWc1K2FJYjlaQTU0MDJmMDdBVnM0LzNx?=
 =?utf-8?B?WHFLbnZmQ2tjMUc4d0hHVDJpazlHSnRHZndGRWNQUzFwcEtvaXZmeTR0TWlT?=
 =?utf-8?B?dkszcUJ6b2d6SW5Obnh0OXhNeUxtbFNSVmtRb0RtMUdEeFN2VTRGVTNUOE51?=
 =?utf-8?B?UXQzNUZjVWZMWUMyajUzdmNLYzFETmRmdUpwWkVERXhST0RGUFhHbkVoN1VF?=
 =?utf-8?B?VEl2TzRIWnVYY1hzNVNFZFJOMDJad1pPRDNmK001Vkk2a3JxOFVGRlFxSGtn?=
 =?utf-8?B?TnNjVFEyd2RDdkw3M0dNOHZ5Wm9oR3hwajZ5MGlKZVROUFplSUk2Q1pLNUVN?=
 =?utf-8?B?Zy9YQjlpZEJ1dDR0ZVlLbHhlTGZrR1YwL2RzZ1R1dU1hL1BBazVvTmNLTmxj?=
 =?utf-8?B?WGo2UXJtNU03WUVPUmFmMGkwV2JXV0xvNDJ1MlBNK3pYbWIrQjR3Rnd3cThl?=
 =?utf-8?B?TUMydVk0VDZDeE5QUTFQalpHWk9vdEl3UjNTSS9zU3ZVYWtPZ3RlZDkyN0g5?=
 =?utf-8?B?RlJLbmtjOUdTVzRnQTVkQk80dU9Oc0xIMy9YVStlMzRMcmZOZmdQT090b0dL?=
 =?utf-8?B?azNTN0FtUHl4bHV2cjg5dnRHSmw5cCt5djZoWk8xcWt1cW1pSUQzSnR4Z2hQ?=
 =?utf-8?B?bDlXZDNDM0VXbDR4bEpsczhVeDROdEgzZEoycFptNWZWZC91NDhNNFNLd3c4?=
 =?utf-8?Q?0oEjsV9aKqU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGNETmZzWlVVTDlZUnNTKzVhZGtiN3FKb3RWMHdHNllYT2xUNkZTOHptZkdr?=
 =?utf-8?B?WkN0Y1JIb2hTMkxsVDMvdjQzSFhKSFYxdk5lY0xjWWViZE9yZGs2MDBJVEtD?=
 =?utf-8?B?Q2duTGRRNFJTWXJGaHVoaUwrM21ONU0yTmdsN1J0L0ZiSGFCU2hnQzIxZEhv?=
 =?utf-8?B?ODF2UmhScG15cit2VWd2YVg2U3pjd21acTZxYmRRYWNHVkJwRFNwK2JVQ1FJ?=
 =?utf-8?B?aXhGZ09Wbk95M2I3NlB2cmcvY3RFVk1XaHY3TWd1Zk9QSjNoSm9nRUY3K3Jz?=
 =?utf-8?B?dXI0S3o5THlKOWlqeXhkMk5YVDhwMDdzc2VTSW96aHI5WnMzbVZybVhUUWlt?=
 =?utf-8?B?ckp1QkpUUFRXM1Y0akxtVFgxREJQOGVQM0lucVRpcHg5Q0xMb0RjQnljUjZO?=
 =?utf-8?B?Nis0Tm1ubEVIUmlGcGJPYlBwMkdRTk1HUHVSTnkzR0MxUU4vSXZEVGtreWNl?=
 =?utf-8?B?RlJlMmhYczBOTHEyaTFXd2F2alk1d1hqZ1MxRmhZZEx2a3RzaktJZmx3WHN5?=
 =?utf-8?B?WEFvdG5PSVpJTzBhN1g0clJWTE40aTFwT1F1dXcyUjRZS1pac3lscUQzVlM5?=
 =?utf-8?B?Qk4va0FZOWk3aGkwYjFOY1laTHAzNFFhUXVnVzBVUHdiR2djaEZZa2hQUlFD?=
 =?utf-8?B?eWJUelRhTEQrQzRIUndnalBhbU16NE9YU3kzQ25tYlRHQTZhVW5mVHppU3BK?=
 =?utf-8?B?ZnVhcUZvOU9kdHM0MGZYenNydE1EYXh6blptSVJYZXZJdVZtQkpnNVVDRUN6?=
 =?utf-8?B?ZUFsbzNxNWVGVWJFUGVhenFrUk5xOHZlakJEUFR5ZEZpMUZXS1F3R3RYVWpa?=
 =?utf-8?B?Z3RpNmErVFB6TmhFTE0xdS9CTUhDc3VwZVdnR3FScFJ2WVR3eVZwTDZYL3pU?=
 =?utf-8?B?MGlMblI4bmpYMlZkOEgyNkltK2QyM1N1SmlBTHFaMFhVRWkydFlaZUdjZzVV?=
 =?utf-8?B?ZFN5dTE1QjdFNXRtbnhYKzZ6Z2V5ajhjRlptd2c3TXpkcXlnMlJHbDdrNmlT?=
 =?utf-8?B?RDVhckY1ejY2OVhlNVZSc3FYM3dRN3JuUzFCN2FhVmhjalU3bHJnS2JmR0Mr?=
 =?utf-8?B?QXlZcTBDV2VkQWJSa0RjRHVQOWtQNjIvZUdRZlRHd0tVdWpuUWZVVkE5OU5D?=
 =?utf-8?B?NE9XYm5ZMnltMnNRUWplUGNtNzdqcHdLVy9WcXJHQmhmZEFlSmdURkorL3ov?=
 =?utf-8?B?V1dKRlJ5Z0xISHFKR0wzenFBMWxuZnpWcEkzNisyREhZUjBzbjlSazZraUhM?=
 =?utf-8?B?N2pyY2xyVmgxWnNSdlI3eDVsMmUyV1B5dWV0c2VOZDRiVk4vZitzVGJkUWhZ?=
 =?utf-8?B?ZW5TbjFNYVVYOHB4UzhVakNCdU9DeUtFVlExeGNoVE02V0h0ZlJjMWI0U3BW?=
 =?utf-8?B?RGJoelhtZWw5ekFlb2ZoNUZSd0NXNi80RW9xRUt2c0FoSTQzL1MrdFdEeW5G?=
 =?utf-8?B?RXJES2RSSzhYeVdLTGpMeGl1QU14alRoSFJoODJtbFdUSExTUGRkNWYyNVJm?=
 =?utf-8?B?Qm1vZWxmcFNScUtGbHpla2lSWG5LQlk4QVcxS3BPUVEzK0R6VW9xc3FIWkVw?=
 =?utf-8?B?VUZWcGpweUJyNDNRVkw5aVdBMVdDb094U0FVbmxXQ3BCd0tIT0wwSU1nWXpI?=
 =?utf-8?B?czFVdUpxRUl4YlN3M29DSFpWVTB2TGVTVXNaZVBabk1vb2RSMFBkRTF2cWNr?=
 =?utf-8?B?RnNFcXNhcVg0QlVvZVRUSGFRV2IrTkVBZ0FERjI1Y3UzYjhWalpndHMwdWlC?=
 =?utf-8?B?NjdGSUxMaUE3SzNRU25rcDd6SWxkVzlUc1BON2thVDZ5MklEMEcrRUZwdGV2?=
 =?utf-8?B?UTB1MEdWR2MyeUZ0T3lDQ3d0Tjl0N1NvYnRjK0ZhT0k1bEUwMEpTbTZUYUVN?=
 =?utf-8?B?V3ZHam9nUVF6MFIvRDZuRzZWRGVITkxnR244WlRMOE9WR0w3akJwODltUEpW?=
 =?utf-8?B?UG12czBXWkJpR012L25sendncEVhVHBrSGpCditFMk40MitIMVJncWxDWWRQ?=
 =?utf-8?B?eFkrL2JnNGprTnAzQldoUmJhL2p2R3dOOHN5R21XalRLdHI5Q2lpSlUvUElG?=
 =?utf-8?B?enRqZ1JYOVN2MGZEdEFxVlZNQ0xiK0I0UGZnQi9xN25kbG04N2lrQlk3L1dW?=
 =?utf-8?B?TmJyYS9yT0JwTG1Bd21uK0RQeHRIMmVRVjAvVGxLUTAvRmlZd3dsazhuRWp6?=
 =?utf-8?B?R0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25622d1a-a758-4230-4c0b-08ddefc5ede8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 17:25:53.8834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FLQJENM+GEZm11w37U0xe6m7UXmStCvpYlm12doYbl6SB00wH+0nA095OE5cKdDmQCI2htqKjvzWAn8S1BZPYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8660
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

On 09.09.25 16:59, Tom Rini wrote:
> On Tue, Sep 09, 2025 at 12:31:47PM +0200, Jan Kiszka wrote:
>> On 23.08.25 17:21, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> This cannot work (unless qemu-user is registered in binfmt_misc) as the
>>> tools will be for a different architecture.
>>>
>>> Fixes "make cross_tools" in case CONFIG_VIDEO_LOGO is enabled.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>
>>> Changes in v2:
>>>  - improve commit message
>>>
>>>  tools/Makefile | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/tools/Makefile b/tools/Makefile
>>> index 7eb17f92116..ae6a3052646 100644
>>> --- a/tools/Makefile
>>> +++ b/tools/Makefile
>>> @@ -333,7 +333,9 @@ HOST_EXTRACFLAGS += -include $(srctree)/include/compiler.h \
>>>  		-D__KERNEL_STRICT_NAMES \
>>>  		-D_GNU_SOURCE
>>>  
>>> +ifeq ($(CROSS_BUILD_TOOLS),)
>>>  __build:	$(LOGO-y)
>>> +endif
>>>  
>>>  $(LOGO_H):	$(obj)/bmp_logo $(LOGO_BMP)
>>>  	$(obj)/bmp_logo --gen-info $(LOGO_BMP) > $@
>>
>> Any comments on this build fix? Or should we somehow get the logo
>> generation out of the tools build?
> 
> I guess, why is this being built for the target, and not for the host?
> Generation of the logo image on the device doesn't seem useful unless
> we're actually building U-Boot, and in that case we'd be building for
> the host...

It is currently being built for both. But if you cross-build the tools,
you are way more interested in things like dumpimage or mkimage than
bmp_logo because you want to ship the former on the device.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
