Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84850C54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 07:48:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0481C82C57;
	Mon, 26 May 2025 09:48:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="gdHuZuNx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3843F82C96; Mon, 26 May 2025 09:48:26 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::611])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 229BA82B18
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 09:48:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LdP341CzfHhgLghNqn1E2lwoh+GTe8sG96unTq1gktwayz0m7bEfgEaMdv+j2iXlYiVyuvtejGvMK7hmiIDWoK8QK46dlCabswgtLoslhiFtwxn3G4RKCb9X+6DrVZjL+4AjVNMOwei46KX75ALkrKDlwFj/X+ftNPTZg8H2Oa+9nPaysH9/Jk5bxPsztHLIlhxSYIvzJD+sjSH5bcEVXQi2+Ss4UBrnL+43t9EBcsYAGwVB/tzNeGDWe1GkJrxuRTkYAbkdzX6bvFWr5xlpgqjKJ4NRw0+f1mwBKVnak6aiy5Y2dj2xu4C5qUqRPVz04X47OiSj2CM7HOW+vGjQkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wg8aE4NkPLTiK5QQvm7DvFk82H3ionTaumPvi8hjDnE=;
 b=CiAXqez/qvrns0Kb4h8U/NBW96yL8F1yJs+lgiAskiijAPrf0+VhMCeM8xuitNslnDzwlZUNMi6/3fvv0/B8YTYGU1E0HNaAb7EaOkFF7f8lfwx+IQxP6V0cSTp2IbKM67VJH3pB+doJjqVnsNb+yW6Z+9JTxLZ9IUCW+X72kZTaoqIZWP3cEFKLatds6FWm2qUahVpANRHecRVouXNL7cTUQRqhF6SFnmibLWaor3bEj6i5Sz1mpXKs8f/PnWjM1IkN34Ncwqzq1Ck1EHQ38y67ka29Eb4qA7s2YdJAOqLfwjWJtJab++TH4hI9afsUum7ZlTbDCP8btUD272mAZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wg8aE4NkPLTiK5QQvm7DvFk82H3ionTaumPvi8hjDnE=;
 b=gdHuZuNxRUAkLjQQBUj0YlaUCrT9cRa9jPYLjbJujC5J5ZbPUZ4i4xFVzxI+oGFynI6D1N8t+zkli1JdqOTjmHbdP2ZuMez1yyJ9G2MLc8lZgpQ50tVaaapEVNvRbZaBXdinAI/1P1x3R1G1u0qyQ+dcrL/ZilbJLjXYaumm0pc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB9593.eurprd04.prod.outlook.com (2603:10a6:102:24f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Mon, 26 May
 2025 07:48:21 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8746.030; Mon, 26 May 2025
 07:48:21 +0000
Message-ID: <97e69b7e-0ecb-4d30-945c-d2c32438149f@cherry.de>
Date: Mon, 26 May 2025 09:48:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bootstd: Use -c flag with bootdev order
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Julius Lehmann <lehmanju@devpi.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
References: <20250524054245.409399-1-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250524054245.409399-1-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0125.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::23) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB9593:EE_
X-MS-Office365-Filtering-Correlation-Id: c22ea864-e93c-4912-a3f3-08dd9c29af75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0ZzQmp4NUJnMU94ZEFOUlBxOEIrTXRJbldkc0dxbXdnSk5sNTdyRjM4clRi?=
 =?utf-8?B?TE1wOTRuVWpSNnpicGRIWVRlV2c1NXNqWWtMMTVjdUxCaUx4TTdJb1FIeTcy?=
 =?utf-8?B?bnpCNW1lSDVoRTdFbFdISTMvbWo4Qlp0cno4NGhsbm5IMWErK3dldnRrTHUv?=
 =?utf-8?B?MXQxeW1rYzJQVkJ5SUNXRjZCalZ6T29zTmNSbTk1bXRDM2lINW1TcTFUK0hv?=
 =?utf-8?B?Y0ltVWNoaTNoaUQ5eE02OW42ZnpMQ3N1bkJqYStiMUFadWlHaDNvQ0JQc0cv?=
 =?utf-8?B?QVU5NU5GZm9WeTdGdVR6Rms5M2tVSjZPVnozR3kvZHo2OW0yenhtQi9yMGhB?=
 =?utf-8?B?Q2tmc2gzN0M0Mi9weGxXVjlmeTlCYlZlZVlHcEN0SGVaUlNUUERHY3l6aE9P?=
 =?utf-8?B?Mi9QTjVmQnhQQXBQaHFmYW1weXFKOUFBcVQwQmNQMWR6TlREemFmUVZCOFVm?=
 =?utf-8?B?MEVsdTMxZnZxTGhaM1R0OUhYWjlKRWR4aWdmc3BFU0hOZkVxaVpQZnJJYzJG?=
 =?utf-8?B?VHN6ZXpLQ1ZMTFpPU1YvTktyWThDK0thSjFpbUwyeDI0bmVxWmNwNURNS3o2?=
 =?utf-8?B?VDhGcFFLZGpUYkFTSGxXMGM1cGx5Nnc1a3VCN3NaNnVSdEs4K1dLdUZsbjlr?=
 =?utf-8?B?M2dnUmFtQ2tHb0JGNndZWThCR040UmpwVWdwRkhlb0JhS1RtY1RiOWEvVSt0?=
 =?utf-8?B?a1pxT1hoNWhKM0djakEyNDIrY2JKTVBzd0ZpamdGYkZPRURIVGRQaFh6S3Fw?=
 =?utf-8?B?V2paZm1xOWU3anUwNEF2MVpvU1p2Qjg4YTZIZjlmbk9LdEVpbm9SY2ZFVEI0?=
 =?utf-8?B?Q0JvSUtrK1RBbkFVOXVJekdrMitldm80VUdPMW9mcXBNblg1YUtRcXZmL21G?=
 =?utf-8?B?eEtXMHN1TENsQTBmRWd6aVFUMnk3UktWclMvOVRQWHZuOHFxZWwwZFIyVjJK?=
 =?utf-8?B?UlRMU0JhTmdlVkdyV0xlNkJEU0l4eUpzckFjdXBxenpLMVliWXJjYTlKZ0E0?=
 =?utf-8?B?N1Q5NzVyTnlYdFJnLzhxZzJFK0Jvc1liVXZYSGZWRi9XcjJDUXQvL0llcFAz?=
 =?utf-8?B?V3FtOS84UkJrdjdrd3JWeWY5OUZjWGc0dVpKSkI3K3VPY3hhNTJkazVWYU5G?=
 =?utf-8?B?dFBxM1ZobVJ6Q0kzQjZEa25HNWEyd3Z3TGVZNWsvUXIxUldjZFVWWmFzMzh4?=
 =?utf-8?B?WkhiYXdQMzdodHpZUTZSYkNZMVlYbWx6ZUtCVDd2dkttUnN2bFZLOGZ1c2wz?=
 =?utf-8?B?Y2hqaXBMKzJUVWtQSWxGMGRLNTVpU3c0a0xRQ0dFbEZQKzdXbHZXQ25TTUJJ?=
 =?utf-8?B?UnRMVEgxOFZQVk8yV2lMZklrWjA2c1lkaXRGa3hCQmplaGZMVWt0Tzlrc0JT?=
 =?utf-8?B?d3dLdlVIR252WDE3VVEyYTdBVnhzaVZGYjZFT3lpZG02UjBZalliRFVmY0hK?=
 =?utf-8?B?VlIwYzhGSFdHSkdrNVQxMzJ5WDRhUzVXUWozME9ubTB5ajNBbU1PdzBNeUpP?=
 =?utf-8?B?Q2hrRHNmY2htLzB1N21la2lWdW9rMENsSm9iWkFHWWdONmlUN0g3aVQ2SCsr?=
 =?utf-8?B?eHVnc2VlRWE4c0ZJQWN4Mm93S1F1VnR5dElacm9NQzhpZ3JGcXcrV3cvU3dB?=
 =?utf-8?B?YXhmUFpqb0VZaE84VDBvQS9NS1c4dkVsWEtZKzdHb2ZXMCszUGlNdFdKZyto?=
 =?utf-8?B?ZEp1bnQ4SEF2dU9tZ1dJSFNGVUltRTVaR09WcTh4eWVnZm1laWhUSFBhank0?=
 =?utf-8?B?dXJCaHYxSFF3YWxUbUg4dmI3Rm9zdzBYTE5rZ3NzRnlTMHQxTVNlNDgwOWpa?=
 =?utf-8?B?dmdqOEJ6YXFiZFlORUgwREdkSFIwb2MzUnltZE5TSEMrL0JiMjgwY1AzU1E1?=
 =?utf-8?B?SXVPcDc0Y2RRZ2lhellQUlhvTmtFY1VEZnlBTDQvdEFJK2c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDhMSmxQd05mRlk5Yk9mWThEdklBYzNwNFRXM1dlZkpSaHVNaWl1NFQ0S3Qw?=
 =?utf-8?B?d0dLWEZHaDQ3TjRDcXpjdmVtcE5VVGFJYW45d0cwL1RPeGp4ZXRmVnpxamxB?=
 =?utf-8?B?cC9LeGZjQVhBdUFtK0VqVExrRHF0V2NYL3FPaDYyOXIxQWdrZk90dHhWMmo1?=
 =?utf-8?B?a0dDbnZjWW9BWmR0YmhyYTd0bWdUdDdWV2ZzY1FsbnhyNU1FS2NXZExkKzBm?=
 =?utf-8?B?bFZXcjBPamlpMkpBSk1IUkg5ait5K2pIelZteWU5dTZ0NUdmNDEyOTFqVDZB?=
 =?utf-8?B?Snd4QkpYcGpVZXZ6WElaZ05OajdNS1ZtZnBXanNQOEpLaFRWMWE0ajZ4a2Vo?=
 =?utf-8?B?Q0xLT1c1VU1CVGZpM1pxYktodEF3bUVsblU5dGdpa1JmWU5IQVVXblFQbGo4?=
 =?utf-8?B?SGlTMWR0NXBEUmhRNmdSOXRZR05QQkdGcXA5NyswOVptQzMyeUxUUHR1UXhy?=
 =?utf-8?B?RUJZdkRFeFV3VkRGclYycmw1Q0RsOEhTNnB1eXJia0VrRVZubTZCeExNMld5?=
 =?utf-8?B?SkM1ZVVubXh6bzdHSUd3d2NrNndPZDdwUW5yZlZrNkQ3N3BTSEV1dVBZV3V1?=
 =?utf-8?B?YTkyb0FWSFBmVUEyNVNmSUIwMWtrOEsvS1lQRW1WVW9KYmUrK0M1ZkZJUFJW?=
 =?utf-8?B?OU5FYkNMYjR1Sys3ako2Kzh1bWFpeitqTzhYWVhSZU1oTUQ5TFhJcFN5VUJk?=
 =?utf-8?B?Y0dYWVEwZUNEWmtRTzBuR0lka0hlb0NheUYvZ2daUTdSREpoMVFKSy8vOVRY?=
 =?utf-8?B?cktNRS9zZlo1d01mN2RSQWVaMStna09kd2swUVB3Wlh4WHdpOFFXdHVzUkY0?=
 =?utf-8?B?SlR3NWYxTFIrYVUrbHZVRkRYRVBBalNQYi9pbEc4bEFLekN4MERBYWc5ZEQ4?=
 =?utf-8?B?TXBKbHBGVWMvU1pISi93SElPMTJHdmZlSmUrS2Q4dUxBbEpGSXdENXdGVWlr?=
 =?utf-8?B?M3VNNFFxbTdrLzZ6ZEF6SHFJOXpLRHNISW5OY1kvZll1VzBwYmt1b20zZE9z?=
 =?utf-8?B?V2tibjhRQ3FDTGdlY3o4YlFDRUVGZ1d6ckxIazl3cVF2aERIc1dXTEx2QnJi?=
 =?utf-8?B?Qk03SzdRemJRNnZ0cFpheWNFSkQydnIybUx5a0srWFVXTk1zVzE0QTZCZkNP?=
 =?utf-8?B?M1hNY1RWUWhiT1RPMTE5bmJIdVFQYjY1LzVMOHM3VXdOSnBMZVJoQmRrYkJi?=
 =?utf-8?B?WHJGUUFIc2ZxQlhiNzJwa0c3eVRzK2krQUpTY29OMk9LL0lwaXVqS2FJNDk3?=
 =?utf-8?B?akxqOVB2RjA1K1UweDh1SGtzUVRJeDl2aWlUd1hUZE5ub09YSmowSHV0b3hG?=
 =?utf-8?B?cVFha2JGLzBmQWNzRSt1WVJBQWxObXJxQUh5NURDU013QmhUcVMyNDY0aWts?=
 =?utf-8?B?WUFZdXh5Zk5sMmZOc0ZDcEQzcGJ6cDFBQW1qYlVhaDFVM3BVREY3NmtxSGpk?=
 =?utf-8?B?NC85Mkc4UGw1MVJzZVdRMGVIQkJQemNhbThISTZRTVB3Qk1UR2RHa01ySW4y?=
 =?utf-8?B?eG8wSXMwNWlGQm9sUnJPODdkY05CMlZoZGxISThrYmZHRDY1eWVCVXR4clBn?=
 =?utf-8?B?Vk9YUmh4Skl5YlByNEZFTEY4enM3Q3pUR2svc3lFc2llQVRmK2ErN09zOU00?=
 =?utf-8?B?aXV1eVcyUnZMWVZjenc4VUFaYnJvd05WYnNJa2Fyd1cwMWZHdWFKQWhJaFR4?=
 =?utf-8?B?STV3RXdqcmRqZFA4Y1p6LzhxcWUraXlQd0dkUUJ2b1RRR1V3VmFxcnp6Zi9Q?=
 =?utf-8?B?c3doN1RjaWxpZUtsTGdIaGdTQ1JmMC9JYnRzbCtleFA1UGN2RFBGMkxPRFdt?=
 =?utf-8?B?VE9ZMDhoQi9GeHhLdHhvQ0ZLTnBkemhVSzhxVGhnczJtYzJZZ1NwdFYzdWQx?=
 =?utf-8?B?bVdrTS9ZT1dhOHFURUNkSlJLQ01KQytTZEhXNUF4NjFISDhsVU5iYUEvUVpH?=
 =?utf-8?B?MTk0OEhiWTZpaHRJWGsvckRLaHJmRTkycFpKWWVrcll6dGoxY0lINWdoUGhm?=
 =?utf-8?B?NEtBNndGQ2h1UnJUdnNYUzlZSzg0Wm84Q1N1U0UwQjBUcHNWZUQxUEdEa0dK?=
 =?utf-8?B?dWR0RlBaRHZVWDBlVjh2TlVqMUtidzZPNUxZTURSdjhTa00yUTNZNnExR09i?=
 =?utf-8?B?N1BmRXNRU0RwSjlsUm1UQ2l1bVpqdEIwUy8xeVVZUi9tNThYU000dVN6QlNX?=
 =?utf-8?B?N3c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c22ea864-e93c-4912-a3f3-08dd9c29af75
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 07:48:21.0010 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: swjXuqGSQKV5DXlyDDR0jUJzZKN3E4qbg8WZUayCiRou9JLAUqUBbxFS1XEeQcvldeafuj2+Feju1DDUVyYXApS/oeNvD9Xsgzns9sV9v+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9593
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

On 5/24/25 7:42 AM, Simon Glass wrote:
> Update this command to use a -c flag rather than a special 'clear'
> argument.
> 

I don't see the commit which adds the clear command to either master or 
next branch, so maybe just fix that in the original commit before 
sending a pull request instead of via fixups?

Did I miss something instead maybe?

Cheers,
Quentin
