Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 632B9C3ABD8
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 15:27:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E44AA8006D;
	Fri, 16 May 2025 17:27:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="EkT42Pwl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 580DF829E4; Fri, 16 May 2025 17:27:24 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::61b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6133A80050
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 17:27:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vgymkjj0ZQE6REbN37QJSM2KNq3+U/oiqyEWeSha0npnvILeYWTm9e7iEHn++6qFQ6v7Ju64NanDDuA5mo8hcgtt26M/Zbqq/Njpk1MNf4poHbQaLY6lKobPQkq5EyBIykfXnS9POeoX6t8VLOdynUJNWAm53pSSVPsk/6CF3Q0Hk+rNU+lhHOmUR8WuIJNw5lY+I9w+14Idi1qktV6rlhRUkFJbICIEH1zrZnJSR7wt1S2MDEJZ1YCh8rIwYoEC7+zMWz7PgHAfa4ENJy/Sb5Sp3FaTyeY/kfr/7WvhrAItu1moQVtEgvU/cZTydxmHBlOLWqxhpVSSIJM+MazfEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8S/9fF5KqNiknyKZbanRlDbC+EiN2ya90lZ6q+rNqQ=;
 b=lQVN1vDVd62s5KsYF8511CbUhjlYNZQIHl3fpFheVbrV2GSYxzloEktmZGz2xYICQUF5ibWYm9B0pKmL8u/FQxkZR9jhTETUAyJDHcNfEuXiKFQmPxQ+tBhQp5F1D4eL9amuPNKxgFD57JSs5zV2Bh2zCACKgxjcnRXCPSzs664AahOVT1w+JBINMtAcpC9gRUy5p16Dn2F7DvqQKOFZgZuaHZeaKs8celRhNt8fEgVhOD5Ub1sAPvH0NjBzlT+1WgkE1eD1HSJDkPsMjHrX7M/wxc3hZAZ60bUXhER9xctfTSQGERzrjFzhRw8HfwCHZn/q+xqQJMuWGX9ynZ/o6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8S/9fF5KqNiknyKZbanRlDbC+EiN2ya90lZ6q+rNqQ=;
 b=EkT42Pwl5rz+jwM7k8k4ek8SkA8nfgVb1JGND4HgHCdrPsmXGyA/ENRfztSKYuXgUW3Z0yDe66xkUctncbfdEdvJKsfFtrRMtYMUl3BFwIbpHwggaH7lsiCUpXKbOo9iD7dnNznIVwf28EnnbCL7pncW63noR16W4SUVKRNAn3E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PR3PR04MB7210.eurprd04.prod.outlook.com (2603:10a6:102:8f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Fri, 16 May
 2025 15:27:20 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 15:27:20 +0000
Message-ID: <64515b97-1e4f-4e58-86aa-1cd5dc3de9ec@cherry.de>
Date: Fri, 16 May 2025 17:27:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] debug_uart: Replace debug functions with dummies
 if CONFIG_DEBUG_UART is not set
To: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de
References: <20250515-silent_console-v4-0-dec6c8391f01@thaumatec.com>
 <20250515-silent_console-v4-2-dec6c8391f01@thaumatec.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250515-silent_console-v4-2-dec6c8391f01@thaumatec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0304.eurprd07.prod.outlook.com
 (2603:10a6:800:130::32) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PR3PR04MB7210:EE_
X-MS-Office365-Filtering-Correlation-Id: beff9ba6-bd77-427d-3827-08dd948e2606
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WUVqa1pNQlIyck9vSGVJTjhENWYyNG8yb2drcHhYNXNaa1lnMFBDZmNuTjVY?=
 =?utf-8?B?OGdUVm4vZkVELzJidjVHOW9GdHh3dzQ2c3JJOGsxWmlKWEt2UWdXRklBZXBh?=
 =?utf-8?B?MExrOHRCQVAvY3YwbXNJb2tBT1UwaFUxdGVQc0JMMS9DMGZCU2FVZFNzejZp?=
 =?utf-8?B?Zk1sajQzcUg2NDFzYUFQOUNhaG9LS1Z2V3IyQm5MUVlnbHB0S1lHYkl3SDJt?=
 =?utf-8?B?VlNuNlU3RFRBbmJ1dTlKN1Yrc1F3K3hKdnVJZGg2Qm9jRHAyTmJ1QzJ1VVR3?=
 =?utf-8?B?bG91OERaK2hrMzc5dmhkR1NoT0Jhb0VvYnkrTjZUVzc4V3NHeHpTd1gzMENy?=
 =?utf-8?B?UHNNVjdGRkEvNFJJNFpaV2tIS0dvd1NHWW0vczVpWCtMOENJM3RWQlVpMEE4?=
 =?utf-8?B?cmtudWlla1BIek5vUjdjbEdCRGlqVjJWNjAybWplZWdFem8yRXoyd0c5bThr?=
 =?utf-8?B?OXdsdmhvcGFROTU2U1hCUmNtQmxTL0krRlJIcC8rZzZnVERvNkIzYTF3UmVV?=
 =?utf-8?B?cGZGLzFQdXpYdklPVDJyUDNJUlZwNFZIaTFOVUdGSVNGdWx0SytJaDAzeTlw?=
 =?utf-8?B?TVM0OVVTWnJLYUFKTElDOWp5RDZzd0JvVFlkM2U5UGttT3JtaGJFYjZ2c3pR?=
 =?utf-8?B?RGZJV251OU05NEt5MEU2bW1QOUVuUTdVTTJJbUp3Z3lkend2dHhKYTE3SGZt?=
 =?utf-8?B?Y082QzBaaGlBRW52UGFQdGlWQk12cG80eDhJZDJvaEZGelQxRDlkVExhYjdJ?=
 =?utf-8?B?dnFpTlBTK29QOWRHNklOeXpaWGhrdC92TWJUOWVDTVVhZUIyZWNwY3FyRkMy?=
 =?utf-8?B?UDMrdVpxMTBMckdLZ2Uxd21ZcTA0aUFHSE1QQjNNOVplUnpRU2VnZzEwZVVE?=
 =?utf-8?B?ZGxsbWo0T3VUaDhGWUVaa3RTZlJKYmQrSHUwSnlXa3FCWUdvblMxc0xNcjhB?=
 =?utf-8?B?VmpyUThFenNDS2x0eVlxWjd3RWRxQTNQc0VpZDZnaEsrTTFoRWQ2NzlCTUVD?=
 =?utf-8?B?b21ScFB4a04xK1R6Znd4b0FQTXJoaU8xYTR5Tk9iVEF4SG93M2Zlb2x2NUlC?=
 =?utf-8?B?RGt1RGxtbHAxVXpBQlRwRVdEdHZtbWQyTzUrbit6SGFYdTJ6bFJZbFNWYXpM?=
 =?utf-8?B?Rng1eWRDRGhxYnFNQmN2L2hqYUJaR1ZpYUl6VDI3N0hmdkMvWE1IcWplYi85?=
 =?utf-8?B?RHV1SnVBZktEU0RnOGMyRUY0U1FZbVZJU0t6TS80ZTREVnZKeFgvbFREeG1i?=
 =?utf-8?B?Rmp3UklhK2xNeFpnUjZhMkFTUTRQL1kwWDRmOTFGdEhKS25EZ2dGZ2JGR3NK?=
 =?utf-8?B?bTU3b2NTK1NNSzJ3RHFSaGhaM2EvQlBHNUlWV2t0bU8ybFFRaWlqTFhESVZi?=
 =?utf-8?B?Y0hqMWNsL0dPSFVEOUJFMk9hOTA1Z203VC9KTjZhZ1dLYU5kQjFEU3RCSzFv?=
 =?utf-8?B?YWpCcGVnMUVsYSttV2M5SVhBSGdBNnE5KzdNRU1GNGxkc1VxZWxOTzJDT3JG?=
 =?utf-8?B?YmpDYVk2UitEeGlFS0U4WDZKL0E5U2RNblkyRG9xMWVUWFFGbDdxSk9RTTJL?=
 =?utf-8?B?RHFrc1hWNGhLU29CZkUwRGJQN1JnRTVidnl0bU9mbVNkeHI3aXNmOHhTa2pE?=
 =?utf-8?B?Uzl5ZE5FRjRPVzZweWE0TVJONGtUSUVERFlzbFVmWjdJenBzSzBGN0tEQ0hO?=
 =?utf-8?B?czdRcjhBQStxanZocGh2ckVBUHhBbmFncWs0aE9LL0taalNZTkkwL2h6S0JQ?=
 =?utf-8?B?aXBXQVNNaTNDUk16YmpKZ25OZ2RndzV6cUNjTVdMLzlOYXlRUkhZZkhGelNs?=
 =?utf-8?B?UjdZQ21vcW8xUXVxUDF6UjBuYjV3ZTYwTkM5eUQ5a3BRVE9JMTRtTlo0VHE2?=
 =?utf-8?B?S2daajdlVkpHVy9uU2xYZFdoNUluWjNna29ESDNDb3F1Z3ZONFpFYWRXekdo?=
 =?utf-8?Q?4ducfUzVqXg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnU0aGhHaTRMQmloVVByRStuSndTR2N1SmpVN1FiUC9STWQ1NEszOTVYTjRW?=
 =?utf-8?B?WGVxc25EeUVRNGZ3ZDF6SzQyQmN3dHBYaWRLOUpaTHRrbkV0VlB0bEhLTnUz?=
 =?utf-8?B?OTRhZ1NaRVp2SVd3UElkdkFFSm15djR1RzA4TmxGaklxV0Z3aEllZTgzUjFl?=
 =?utf-8?B?UG9FbzEzT1hrZnZ5dEVWTmlvbm1UYnlZS1JQazh1ZEkvZ1c5SFdKNUhTclN0?=
 =?utf-8?B?SUtydWVtc0QyQzBDTGlERTVkKzRuY3lpQnlxQW1FbXlZeDRLeVVLczFUVTdM?=
 =?utf-8?B?dXRQeWhHUW9UTTZWQm9zUXVsY2FqRVBzUlYvaEV1bjdlU3R0NERhSGlrMUZ0?=
 =?utf-8?B?dndTYzNXYjBkUUJHLzYrWE5SRzFuMVpmV3Y0bk51dENBbVdiZmZKMmRITm5P?=
 =?utf-8?B?cld3OWdzc0Mvdyt3QXFXOUxuOWdoM0o3WG8yVGkwWjVyM3d2QlY1MWoxZUNP?=
 =?utf-8?B?MXphcDBJdWNpNlk5WHFkTHRNQUNtRE9pUGQ4V1dmL3NVWjFOaElabk95MEhI?=
 =?utf-8?B?REdJUnc2aHlpRFh5QmdTOHFnTVJqamQzUkhhSUZKUFQyUThuN3NsT2U1RW1L?=
 =?utf-8?B?U0RORngwV2xaeXRWRU44TVdxNmcrN2J4bFJNT2lCY2g1R1pTeFZKRE9lNm0v?=
 =?utf-8?B?VnJMdnJFQi9IdGVXSFZ0VjVFWlpmV1Q0RlpsUXZLd2xjTE8zU0ZPc0VxOVpE?=
 =?utf-8?B?d3k5bjcvUzlHZzNOL3g0aEV1NjdOMnlZVGYzU3BHVGNtc1ZibHMxbCszUHZK?=
 =?utf-8?B?R2F3b2dyN3VnY0Y0Q203bTIvcUlMNS9aVlVIN043eHdLNURaNDFyMTlrQmdu?=
 =?utf-8?B?b2dKalR4b1BOU3BCTDdnU0h0MFd6K2c1NGpHb0tIRlhUNnF0eDZUVTZoV0dJ?=
 =?utf-8?B?b0c2RWdyREQ0YSttUHNXQkpnZTZCMERIT2JPaEJ1SXJGRnRxTFN2a2huSE0z?=
 =?utf-8?B?cWc5cmhLbStRYTVYdGpXZjFMN3ZuZjhrL0pUMXFyaUxPd1dTQWlzSUF6cXI5?=
 =?utf-8?B?WnE1NGVJVE1OSVYyaGh1ZTFxUE04SWdHazVIZjNLd1QzQWxJKzg5eG5Ua3hQ?=
 =?utf-8?B?QUdabzJ2YXZ3VTN4R3ZFc2NKdDJSRERzZWNXaUoyTGs1SWVOVlMvRUlPNXQ1?=
 =?utf-8?B?SEkzWlJjRGgwR0xFSU5Sb1hSU3FzelE1SFpmWnJaYlpPUkVRMVdrSWRTN2hQ?=
 =?utf-8?B?blRoR3JBaExRZDlQQXVIdkRoZXJ2UUtqWU11d1kyNEpEZkNaYjhQOTFQYS9R?=
 =?utf-8?B?TTd0UlMvczU5YnZLTzY2UE5MVHltZHoxM3h2ZUpZNXJXdFQ4ai9nRmEyWEtu?=
 =?utf-8?B?c2ZJZXVsTVdlbnVlaURLOVMvbUFVTmE2ZTFLd1p2VFFXbVhySkEyb3h6T2tZ?=
 =?utf-8?B?TjN6Zm5vaEFIQW5oUDlIZDhRcE80OTVIR3E4MDNvTW5ZdlBRZFVxQURuTUsv?=
 =?utf-8?B?SjIzS0dXM3J5SG5OMk1KdnI1a044SW1LalNJczNzWTZUQ204VERoVWJ6UUYv?=
 =?utf-8?B?TEppc2RkbWZuNnpNQVpDb2pZWVRFRUwxTnUzZW5RbWhJV0FMb2FNZU1hYWtl?=
 =?utf-8?B?WElHd1o0L25hMFB0ZmQ0QXQwS2ZqTTVBMjh2cXdlU2Z6cjA0SXdIV1kwTmhr?=
 =?utf-8?B?T2ZaNXBkaHdWdHpxRXdrSTUveHBZRlhpRU9UNHduNWdXankrdmJWVVovNmdv?=
 =?utf-8?B?alFqaE5TMnQ2bUdLaTBmVmRjYlppVmlCVDZ0L2wwWlduNDhsdmtMYTgyRW1M?=
 =?utf-8?B?L25nTVQ1R2hTekYydzV4WmpnbHZzdVBXMUNudE5NTEpGcnpDZGZDbm41Qm9p?=
 =?utf-8?B?Wms1R04rV2EramNwcGpxWC83Rmo0eTdaRFhrR244SW9iazZ3VE01UWduRFFx?=
 =?utf-8?B?WFVUVlhManV0aEN1TFJidXRMRTJpMGhpL1pXNjdzTDF3M1V1eGhwYU8wYS9H?=
 =?utf-8?B?NlE1NmdXemN5Qy9ZUWs1N0JKQmZlejJZNG4rOXpNaWRiK0VyRHFXYlJHaUdG?=
 =?utf-8?B?bXRCUFY1VExNSkVXUzdTTHNiQUE1TDZ3VmwvYW5ZTjM1aVpKVmdrbWs4MkRB?=
 =?utf-8?B?UWVXUDNtM3FmV2VnOWRqMUkyRW56UnJOcFlSc3N6UW1PSFp3TUdKSzJQSE9n?=
 =?utf-8?B?SjdjWjZHNTZUZGZ5dW51MnphOWNZcWhKd1I1OFdXVlk1UnRlOGo4NjczZmJB?=
 =?utf-8?B?bUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: beff9ba6-bd77-427d-3827-08dd948e2606
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 15:27:20.3597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X9orkcK2oBPv3195MYumRjxIibhulNIRsP9avHFaqW2BJW6ybCkM+qskejricoyjWs8gbwnzBTILw4KY4YGF72SGdRn6NgvJWVGxocnGf4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7210
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

On 5/15/25 5:55 PM, Lukasz Czechowski wrote:
> In case DEBUG UART is not used, define dummy macros replacing
> the actual function implementations that will not be available.
> This allows to compile code and avoid linker errors.
> Redefine the DEBUG_UART_FUNCS macro if DEBUG UART is not available,
> to avoid compilation errors.
> 
> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
> ---
>   include/debug_uart.h | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/include/debug_uart.h b/include/debug_uart.h
> index 714b369e6fed..4526dca24ac6 100644
> --- a/include/debug_uart.h
> +++ b/include/debug_uart.h
> @@ -128,6 +128,8 @@ void printdec(unsigned int value);
>   			(1 << CONFIG_DEBUG_UART_SHIFT), \
>   		CONFIG_DEBUG_UART_SHIFT)
>   
> +#ifdef CONFIG_DEBUG_UART
> +
>   /*
>    * Now define some functions - this should be inserted into the serial driver
>    */
> @@ -197,4 +199,17 @@ void printdec(unsigned int value);
>   		_DEBUG_UART_ANNOUNCE \
>   	} \
>   
> +#else
> +
> +#define DEBUG_UART_FUNCS
> +
> +#define printch(ch) (void)(ch)
> +#define printascii(str) (void)(str)
> +#define printhex2(value) (void)(value)
> +#define printhex4(value) (void)(value)
> +#define printhex8(value) (void)(value)
> +#define printdec(value) (void)(value)
> +

There are a few additional functions that aren't redefined here:

_printch
printhex1
printhex
debug_uart_init

any particular reason for not having included them?

Cheers,
Quentin
