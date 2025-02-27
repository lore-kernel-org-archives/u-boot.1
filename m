Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7956C1B0FF
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 13:48:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1544C80FF2;
	Thu, 27 Feb 2025 14:48:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="nQ7cBkJ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 754DF810EA; Thu, 27 Feb 2025 14:48:25 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20708.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::708])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F30DB810F6
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 14:48:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7jpwvyE94OlWNsj3bTz5NvfZ3FS4up2suanLSzymqxlc5YraaCbZPFtYVJREjeE7fF7v0W7zkze3oVSAaN5i6gh4gihBsivwuH43kLK1w5Imt4L/5EqItLdvKCNBFhEv+BXoWUs7OpheIVjYMrYQzw4WrvkTqEJb/weZRPDNev39qBXfSXp6U+54Xhkkxr1yU1QjDOeMHNf0ZKUKrqnlIyF9kRjs+R9oiCYM1a9+B1BuuJ2AljVsEEO5Ur0BW5g66AAxUssQASgD00rtbfmO+eVhsPzh5GTo7I4c3YN7GqBkBg8Nm3uWw7J+CfqWwF8FzQElEtqRpZAIc8UHAlJ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfkX8v+R8v5TfFy7fpHujiYIK2k3GdCwJO9RGhUQPZw=;
 b=xAFcC2dvjf1WMTNqkSNM4Rkour0ivip0TXTTiIg+EB24izJYyiAFKNEtYArokNDgl9K08VuB6gSSqKbdA3By+jnn6L1si+ABxzAWWg8WhQkzMpz9PJ78NulUo3HFFAKmdd33T8OcrGkMLWVZzosinnGNJ1OivG0/o7KmiGdXybgJL3ZIqUA0E0xRa5ITxi/+Zmhlj3Edsh5jsvLPOFGmv2n2zBHE2kr5hu+lRxcuPjMenxtk5ZEAzYJ3b/tfZT4j1unDY9LZ54W2dlrVZ1VnCDSH6k4acbqy5WObqSFpYJW/MTKWB7jKU7MHcClOnoh1LP8Mj91P8XdWEATgOG2+UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfkX8v+R8v5TfFy7fpHujiYIK2k3GdCwJO9RGhUQPZw=;
 b=nQ7cBkJ+g374Lc0gvBpjeKSZwX4LfXmBYXOHaO8rvarh6T8URSEfS63lj0lpJJO2C9NLzgcjSLlVkMMYvawSV0cZ8bDAIfl64vquXQ9C9amdjVkqJpbOlHKkQoJxApQn2PtC2uIbG5sP2CQzl9zhNHENHAldpQF8jAHmrqYvwuFrD893NxJ/Z6fiBS2zGOjZC9bt+NFoKM7ICFndp9ZTxq0XEVU5V44QgGuw/E/pIVmqrstE35bymsNc4+E4G3raqgRnSUjFIoGNzjb1nWNwWZRdaaxA5fN1sSZXRMUWkhud9eQkqsTGwSgFT0jJwc6Lv1WzHoo7H4aD6fvriC+LyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from VI0P195MB2484.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:248::6)
 by DU4P195MB2618.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:571::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 13:48:19 +0000
Received: from VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
 ([fe80::24f:8371:2871:5981]) by VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
 ([fe80::24f:8371:2871:5981%3]) with mapi id 15.20.8489.021; Thu, 27 Feb 2025
 13:48:19 +0000
Message-ID: <37556d15-0334-4239-93b1-784b0c4c3592@phytec.de>
Date: Thu, 27 Feb 2025 14:48:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arch: arm: dts: k3-am642-phycore-som-binman: Add
 custMpk to overlays
To: w.egorov@phytec.de, trini@konsulko.com, u-boot@lists.denx.de
Cc: nm@ti.com, n-francis@ti.com, d-gole@ti.com, upstream@lists.phytec.de
References: <20250211064205.45087-1-d.schultz@phytec.de>
 <20250211064205.45087-2-d.schultz@phytec.de>
Content-Language: en-US
From: Daniel Schultz <d.schultz@phytec.de>
In-Reply-To: <20250211064205.45087-2-d.schultz@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0044.namprd18.prod.outlook.com
 (2603:10b6:610:55::24) To VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:248::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0P195MB2484:EE_|DU4P195MB2618:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d7e36b7-d50e-421b-c662-08dd57356476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|10070799003|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TlprN3dQSHo0ZnZ2RUczaGlBYmp2K25KU1MxVWw2VjJyNmRTQ0o0WDVRMjlT?=
 =?utf-8?B?K01JNlJsYnlla3RJK0QwSzE4SVFSKzRSNHMrcWFlV3FOajlEdVpYenVXc0hl?=
 =?utf-8?B?b0VGRG9kUHF4UjVtNWRIaVppYkF1S0JCVTRsZ1JLUzE1WGFJRFZDTWJodENE?=
 =?utf-8?B?cC84SlRackUyNkhyZ25KTEs1cjBNWWlNYlFWbXA0N0ZjTXJOZlRtZ3pqVTRa?=
 =?utf-8?B?UEU1Zkk4aXdxd3J4Z2tiZCtWckxxU0VkRnNvOFZWdmNtekhTb0hpVzY5TzNS?=
 =?utf-8?B?NzBxdXgzVTAveW1zWXNPeG0ybm90aFFxUTYwS2l5Sm01ZTB4eitWUERDbmhk?=
 =?utf-8?B?aEpjVnhnMk8zcXhnNlhURnFtWUZrRkFieWFIUGM0NWNZV2h3WXZaakc3ejN4?=
 =?utf-8?B?bUlPWmVYY1JCOTZ3d01PdzF3VG1Ha0lLbGc0RzNNSlNlVnNqMEErYW9JYjFl?=
 =?utf-8?B?TVhpNTRsNnB5M0YxTU5DQ1NlaXRlS2NXTXBIZkZ1RzZ0L3RQejUzZUZ0VFd6?=
 =?utf-8?B?L0tyZzVRUS9MVDF5SWVvRUdVZVRVWUo4cWJRT2c4NVlIbFZ3SDJxb25BdjIy?=
 =?utf-8?B?dmNieWdGYmxTSElRb1k3QkVISGxSV08rWHNmTlJBdVJlQnZKTkdsZERKdnZs?=
 =?utf-8?B?QVJaZUtuOTl2VkliNlRrSWM3Q2dBNFg4ZEpRaXRhR2FZTTM5UG5qMy9lVWZw?=
 =?utf-8?B?OTVmREJ6WTQ1QU5BVDYzNWtxUjZIcVB3VW9oWVl4WXpCT0hrWlhHTlZKbGVy?=
 =?utf-8?B?T1lYVFNxcktRVU5IWlpxZG5JUWMveis0R3VEWDhHc3NKbU4rajRxZDQ2STJy?=
 =?utf-8?B?NXM5UHZ5SFV5SUdrYXMzQW0rNkNhdm9JVy9pK1M0a3NPaitpZDcvVkI3OGlj?=
 =?utf-8?B?SU5WdjlRY3lPTUNOS28yU2t2TmdLeU9JVkxOR0Z1blovSm1uTmdnbEFYQ3V6?=
 =?utf-8?B?aC9CVm5kV2FGQklaWC95UERYZHFudTUyc3BLRkF1bGE3dnljZ2g3cklzQnFY?=
 =?utf-8?B?UnZMWjM4L05XRlRJT203ZG5wWFYyUjJtcHhiNE1JMDhhLzVzRXE2N25vN3Yr?=
 =?utf-8?B?TVE0NUMrSDUwS1hjT1dWOVpSTG5TeVBkZ2tBeC9mdHk2NXRWQ3FNQ0thVnlL?=
 =?utf-8?B?Rnl6UC9oQlpQaEJoUmloa2psakpFUjgxWjE4a2tCVzNqSWU3U2tmNWMzTEUr?=
 =?utf-8?B?SWpuM0ljWGg0NUlJVXpPK1NqN09OMTAxNmo5cDNwOUVQUnkvUzNxUWw0dkto?=
 =?utf-8?B?ZDRzRzJEbTZXYXVPai91anQ5T1hKSDl2L0NhRUNtUkduV0kwV3RSSk1iOW4r?=
 =?utf-8?B?Z3Vmd3A5NnMrdk1jRVV4WnhhYkZrdXNsYXdLY0EwNDZ3YUd4c2oreXdDN2l5?=
 =?utf-8?B?dVl5dndEbWExc3dzeXF3R1Z6SVBOUmRLQ2YxbHdTQWZDc3Y5cmZPMjh1Rnhn?=
 =?utf-8?B?Q1RwMEF1dC84ZU40TkZ1L2grVC9Qd2t2MHExOUJZTUpHYmdQdGNsQldNVHNP?=
 =?utf-8?B?eWowMUtPdUlwcm9SVzBRelhRdk9aV2JBUmdkVUhxMlJ1ZS9xbVBVRDJVMHYw?=
 =?utf-8?B?RnhEZFArVGF6VFEvVVA5dUowQW4rMnU2MnVhNHJlbkxPL3BJMFhybGd3eGov?=
 =?utf-8?B?SkdwS0I3M1AyWDVKUlYyeTR1RnkxZC9BUE1HV1RwakhCcWpaNHRpR3EwYmF6?=
 =?utf-8?B?ZXBCYm9pRk10REJOWXFab3RuT1V2TzRKdHBTY3BxZ0RoY0xsUzM5SnlJbFR4?=
 =?utf-8?B?VW9zMUppWU1uMnZodWZhTFBuV04yUUhkeGhJNGdVYXVjaEtvMW1RcWVNVG5j?=
 =?utf-8?B?L2o0SFM2SGpiWHI4SGZsMVBFSnk3MzY2a0RXVmE0MmxCd2ovc056V2hzWXlm?=
 =?utf-8?Q?JzxlwFzJppgPv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0P195MB2484.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjdmSVd3cHJNcEdJdU9PZVBzeG9iNUthZThjUzVXamU4bllGMDJrY1UxSTZy?=
 =?utf-8?B?ak0xcU5hc3QxazlBWHB5WUJYYXRvYXJscGNJdUEzNmR6NjNpUk9vKzhHWTZh?=
 =?utf-8?B?WWVVK3RjR290Wk04V0hqMlJmRE1ISGdaMjV0elc0ZmoyRXBTZmMxL0lpeWo4?=
 =?utf-8?B?YXU3Sm1SQ1MrcXRLTjdmdlRlTVJQbVRiRjZmSEhKalBoT0J3M2pUZlByS25C?=
 =?utf-8?B?YnA2ZzA2ZnlUMmVSTjY5dGI5WUYvNFJNNHJ2ZW1CRlpQbE44N1plTitMMng2?=
 =?utf-8?B?Z1hiZ09YbFhibkhZNnFJQTN6R2IvQkdPdExBRSt0VUk5aFlZVmt0aDh4eVVx?=
 =?utf-8?B?ZU1VNzNqNW9mUjVqMFdvS3J3ejh5eWtNZlBaS3FmNkpielFqK2wrNDdQVndF?=
 =?utf-8?B?R3pVbjVYWW1xcWpnRHJjSlIvemtqK0I0S2xkRjZ3NlRFU2JCR2hVb0FWYW9T?=
 =?utf-8?B?eHBaUWZLcUo2bnhETkVURlNXOFk0NXNobklvbzIrNUZxeVlZMllzZEplY0hQ?=
 =?utf-8?B?QVpoMnJHVXhZVE9GMmcxZC9tWWo3bm1WT2dIcjd1UDNnUmQ0QWF5MlJ3eHY1?=
 =?utf-8?B?cXEwaU5rdjJpMnUrUnRZcEZ1MWxYVUZhUml5VVBHcXRGL3prc0wrQVlxeWpB?=
 =?utf-8?B?TERBZWdxR2NNSURGL0xzYUNnb25rb0dkM0VEZzJBUGJFbmdDckdJSXpyMTlB?=
 =?utf-8?B?TjFuL05jR3RZOUpRN0ZtMlhYTnV5ZU5zbWkreGVoT09RNDc5T2dTWUozSFN1?=
 =?utf-8?B?M25zRnowVWFkaTY1SThzd1Fzd0tkU2NGbTUvZU4rYkpiUStqNFk1eHE5cDZq?=
 =?utf-8?B?VHRucEwyUmZXejNlTVM1NjVQWlNDREl2THdWZWljK0NqU3N6SWdpbWRWL0F2?=
 =?utf-8?B?enFiUG84a3ZkUm1pK1NZeGNlcGROUlBrZ09vdnViTnJ1UG5FZm9pU3N4VHRT?=
 =?utf-8?B?Q0hyZlNEMmw5aUlNMEJ2Y2ZrZnNRQ1RIYkNSY0VhQ1JmaGV2RVFvVXBiUEtQ?=
 =?utf-8?B?ODVDTUxqQllBSjRHNXBneno4d3pLL0VwMHVMbnlhT1UyaXRSZFJtUS91eXBX?=
 =?utf-8?B?SSszb1NYTm5ZNFk3Sk92VnB2MzRnWmJCZXd5dGtoeUFjL21HQStXQzZxT0FK?=
 =?utf-8?B?a1VnZTMwSTQydjdhWGp5ZGFzcG43elQvYUp6Tk4rNFFLcCt0ZVRiVU5TSEFQ?=
 =?utf-8?B?ekRtcElpWGUxU3E3ZC8vZnN5ckRHZjltOUkvTHI1TEtsQ2N5UTVPUnU3TDRj?=
 =?utf-8?B?c3hqWGJvYUtVTnpENkdsdjdTSGI5RXo2QUhIOWVsWHl5QlpJRlVRU1FZZVBi?=
 =?utf-8?B?MEI2WHFlR1l1MDhXWElXcEFscVJNNWRmS1NnMWFsZTZVeWFWTFcrUTdMQzlF?=
 =?utf-8?B?eTMzRlgwc1dndWI2L1hFNVk0WEM0cklpaDFaSXJkYm9IWU5CSnI5Y3ZRbzd4?=
 =?utf-8?B?N2VjWGhZbzFwSjR2eWsrc0pnNnk0UXcyMTJNSjNjbUZUNWFrblpIbTBJSUFv?=
 =?utf-8?B?MjZKeVV6ZlNlalFpcHp1RmpkM3dRWktVUW9ycHZ0VFlCUHpXOTVLTXIyTmYv?=
 =?utf-8?B?LzArTTl1VVJMeWpTTWo2ZnB1bFpSRHFtak43VW01QXlzdjlXRUJIRDRoVU5U?=
 =?utf-8?B?dGZVQWVQT21RUk9KelhlYjVSWGtuYkVPKzVQTjZ0L05iYXFaVjRlQWowWkp6?=
 =?utf-8?B?Q2t6M1VPVGNNVVVkcGRjYk1JQmU5dnFJQlBMMnpNWDhZWTFWRzR4NEZXRGVy?=
 =?utf-8?B?M25SdmVDUFNHSUVyc20wdWtyVjlYN3pBdjVpSXZ3M1Y5M2hDVktvaWpNaXkx?=
 =?utf-8?B?YTJGMVlSVlNkVWs0Vy9WbGNBaks0dGlKMjd2OUFGSFFXbEtlS1Y4Nlc0TFhJ?=
 =?utf-8?B?NXlEYTVnMmdRbXVBMDJGcTU3akc1MW9PVnkvaW5SNTBpbXZGNFpzZ0gyUFZt?=
 =?utf-8?B?RDNuK2srYXExWk1HZGs4K29rS0V2d1pUS1p0UFErdDR1MEx1QkwwdkhVcTJF?=
 =?utf-8?B?aUh2eXZOQmR6RWFKZndkdHYrN2EyeVZYVzZ6ZG5UUWhLbzJVQnBKdEVGSThK?=
 =?utf-8?B?enZiREQ4TE54SGcwZDNnb3AwNnZoa3hVU1Y5T01CaHRlMHZOdlZQd0J6eTla?=
 =?utf-8?B?Z0kraVlXc0NwYnZjNXJ0RVBTYk15dlBqdlQycW1HdkNsTzFDMm1sc09ESGlJ?=
 =?utf-8?Q?o0qy0wwgX239dJUwUsxccq0s+Ab+tKOFeGDlD7FMWXAp?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d7e36b7-d50e-421b-c662-08dd57356476
X-MS-Exchange-CrossTenant-AuthSource: VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 13:48:19.0134 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SdDHKGMWPDOB9fMIJxE5GTssyxpyi8B6ARFLhhrvqXyv+QeD8zK4KOalWHLU3pWNeZ0FJA9rL7/W0ubzeAZxDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4P195MB2618
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

I don't know how strict you're with the upcoming release candidates, but 
would be great if these two patches still can make it into the next release.

Best Regards,
Daniel

On 2/11/25 07:42, Daniel Schultz wrote:
> There are some device-tree overlays with missing entries for the
> keyfile. Add them to sign all images in the U-Boot FIT image.
>
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
> ---
> Changes:
>    v2: Removed keyfile definitions which are already defined in k3-binman.dtsi
>
>   arch/arm/dts/k3-am642-phycore-som-binman.dtsi | 28 +++++++++++++------
>   1 file changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/dts/k3-am642-phycore-som-binman.dtsi b/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
> index 3710564cd4a..5228eed19bf 100644
> --- a/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
> +++ b/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
> @@ -363,8 +363,11 @@
>   					compression = "none";
>   					load = <0x8F000000>;
>   					arch = "arm";
> -
> -					blob-ext {
> +					ti-secure {
> +						content = <&am6xx_phycore_disable_rtc_dtbo>;
> +						keyfile = "custMpk.pem";
> +					};
> +					am6xx_phycore_disable_rtc_dtbo: blob-ext {
>   						filename = "dts/upstream/src/arm64/ti/k3-am6xx-phycore-disable-rtc.dtbo";
>   					};
>   				};
> @@ -375,8 +378,11 @@
>   					compression = "none";
>   					load = <0x8F001000>;
>   					arch = "arm";
> -
> -					blob-ext {
> +					ti-secure {
> +						content = <&am6xx_phycore_disable_spi_not_dtbo>;
> +						keyfile = "custMpk.pem";
> +					};
> +					am6xx_phycore_disable_spi_not_dtbo: blob-ext {
>   						filename = "dts/upstream/src/arm64/ti/k3-am6xx-phycore-disable-spi-nor.dtbo";
>   					};
>   				};
> @@ -387,8 +393,11 @@
>   					compression = "none";
>   					load = <0x8F002000>;
>   					arch = "arm";
> -
> -					blob-ext {
> +					ti-secure {
> +						content = <&am6xx_phycore_disable_eth_phy_dtbo>;
> +						keyfile = "custMpk.pem";
> +					};
> +					am6xx_phycore_disable_eth_phy_dtbo: blob-ext {
>   						filename = "dts/upstream/src/arm64/ti/k3-am6xx-phycore-disable-eth-phy.dtbo";
>   					};
>   				};
> @@ -399,8 +408,11 @@
>   					compression = "none";
>   					load = <0x8F003000>;
>   					arch = "arm";
> -
> -					blob-ext {
> +					ti-secure {
> +						content = <&am6xx_phycore_disable_qspi_nor_dtbo>;
> +						keyfile = "custMpk.pem";
> +					};
> +					am6xx_phycore_disable_qspi_nor_dtbo: blob-ext {
>   						filename = "dts/upstream/src/arm64/ti/k3-am6xx-phycore-qspi-nor.dtbo";
>   					};
>   				};
