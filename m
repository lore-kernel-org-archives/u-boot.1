Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91856D65530
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 17:12:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E10D389C95;
	Tue, 26 Nov 2024 18:12:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Fd8fTvGM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAC07896A4; Tue, 26 Nov 2024 18:12:20 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::600])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E5D089C9C
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 18:12:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PyXowS8n69h9dbU+X/dU7ll/koqwVZFfgnkNUIjKn0B0nbLLQwNAGW9Gq2jgo4/avhjRffibaY5nVsO6Z5JrTTxjVbrXMpTujjfRCOqQj9fJacBdw914oYbHK/tqIlXuOnvZuR4+PL4pAiYHI22TDxmN5Ij3Rm6wuO51gahF7uHApT5krR3XqMukk8qZLFvSpeF49Jl/q5VhcL/tn8x4wpzrwEKGxXKaJl1OViUsUPMyyTWuw5U87Kz1Xym8kqCaMf7+7BkeK7iHYGPRzo/F6Pe/pG371MpVRbSeXZ4hTv6kuA2BHBhMKnVKZymjggicfUxPplMgNoCTlZPb/a9O+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qD/e3J5f+rRAByjuH4JfetXHyUP2wF4c2ahhZjpWRjQ=;
 b=SQyqXkJRg+Y/eGRz4ju7FSRWEJb88H7L0qOTipqc8yHrywe4EytPEVO4DerWp9WLFicYKMXM63R7iTsyCtCpuD2/p4B7SD6CNddX94aKVcYjlzuxk7hlSAasOL97W0I3oVPmZG5/DsoFRZE1slzMIrEwe7nv1OWR6n7csgnHy6QX0/gVlNGcRWQQugK7FYFcAGyycyTDaPiUZ+rb9vjyRAc2c8UapfsvUCzU7qY+BX6+/LXyp2IGaTr8R/Kc2vP5tRVMioAjYA+D3jmzqM6woesJuEuIYlHJkLCsJVmdBh96UmDTZJnygZRhgB4k5yhcN+JlykuFhXr0UDnSk+3EeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qD/e3J5f+rRAByjuH4JfetXHyUP2wF4c2ahhZjpWRjQ=;
 b=Fd8fTvGMOzGwxtetcdMg/zBgB1JQQB63qQ34SsZMEi38zNs4Vz8zwl9N22+pD8cBqPtz1OJdjQ30uMYfYxSLH1mt7Tj5jyyCl0ZRq1+5qzuklZvXQn1qFlCrHSfFxn6rpo2MzvQnnw+JqLxMsmPrVOVtIk3Jh8MBAyLDMjM54u8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GV1PR04MB10080.eurprd04.prod.outlook.com (2603:10a6:150:1a0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Tue, 26 Nov
 2024 17:12:13 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 17:12:13 +0000
Message-ID: <b8824513-556b-4a61-b66b-f1a3445aee5f@cherry.de>
Date: Tue, 26 Nov 2024 18:12:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/20] arm: rockchip: add RK3576-specific syscon ids
To: Heiko Stuebner <heiko@sntech.de>, sjg@chromium.org,
 philipp.tomsich@vrull.eu, kever.yang@rock-chips.com
Cc: lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jonas@kwiboo.se, detlev.casanova@collabora.com, u-boot@lists.denx.de,
 sebastian.reichel@collabora.com
References: <20241121142731.1202209-1-heiko@sntech.de>
 <20241121142731.1202209-11-heiko@sntech.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241121142731.1202209-11-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0246.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::19) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GV1PR04MB10080:EE_
X-MS-Office365-Filtering-Correlation-Id: 42ca2033-ab40-4178-ae50-08dd0e3d789a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|7416014|1800799024|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VmZXOXYyR1lHTGV3QUlVRkcrL09zSEFWbElRNENTSk8vRS9hZlRUNUNocWlq?=
 =?utf-8?B?NTBIaGRiaXUzRVNueWRkVGlJT1N2bnZyZzY0US83TWtUZW5xRjlFSE9iVEVI?=
 =?utf-8?B?cDRaUURISGxlVHh0WUpQaTJqZWxlWk5IdXhOeVZDYW9mUDlGOW96SXpMaEZq?=
 =?utf-8?B?TEhqM0NZUjZ2bnV2NU5Walp0V2UyR1A3eWtycmk0T2FGSXRubjlZdXhMdVdC?=
 =?utf-8?B?Q3hGTmZRSHZNc1pGcW1Dd2JPNzZOZzhlbEN4dEpadENLeFJiWXVkU3FTQm55?=
 =?utf-8?B?WFRUaHJ6K0pRUUZGMVE0MGMrV2hOVXV6UmJWS2VyZVllS0xYNjVoY3pkUEZz?=
 =?utf-8?B?bVpwOVBRWHhpVWMycU9HY3JqRCtXWHNDOUVIUDBaelg1czRzRVRYaUlQaUZu?=
 =?utf-8?B?eGRQVytod1dIRi9QcklzWmI5aXFBSGd5UUxUWkVIQXdLVFhiM296b0dPSXl5?=
 =?utf-8?B?dnp6S1lkSkczdzkyQTBteUMxVEx6dE1XSmhxRTAvSzlFaDFJZi9PbFNTaDFX?=
 =?utf-8?B?aS9oY0kvNzlPckVPM3g2bGNsdDB0YzNqWTJLay9kZUZDZktMQW1PTklHUlBu?=
 =?utf-8?B?Z0JnZDR3U0ttdXp4MzVkdFZZTEMrMGZ0dzJCeTUzYnViM3owYW53dDBMYjlF?=
 =?utf-8?B?Lys5QTIxOWJtMnE1eGcxZnZ6Wit1alowY1NJQjMvZVFTSGttUllrbkUySTRT?=
 =?utf-8?B?L0FrVlFXU2FKNzRqOXNJa2gvSjdnMVlMMG9pdm9Od2lXb2ZRVzVGVFAxTm1k?=
 =?utf-8?B?K2YxZE5KRHp4WWM5UXdIR2prQktXQkt3b0lWT2N2UVZRM291R0w2OHE4OHZF?=
 =?utf-8?B?eTQvYUtnUVRqdldXMXl1dmhaSi92eVlKMzVvcTE3akNDUzNrbzdmZUVVcVJn?=
 =?utf-8?B?QWcramNRQ1hYaTVhbDExalNYcklvRXlBaEpTa0dUOG1vK2FGdTR5SWIwWlVt?=
 =?utf-8?B?K0pwQ2hxTVZ5c1dKVVRNY0taWFA3NGFDYUxib1FmUmVIdE9TR1JvZk9ZcHVW?=
 =?utf-8?B?L0JUNlpHN3JNVXdONk1NM2s5T09JQWw2K3FhdUVMWGNiZmdtUHpzYnpPQXJE?=
 =?utf-8?B?RlJLWklaMmFOWi9meEQ4WXFLa1pnSTEwdnp2QWJlNmlMMDlsZFlPKytnREU5?=
 =?utf-8?B?aHBFdjRwT2pLYndJRTVyaEhMY1Q1OFZnb2hFY0pwa1kxcHRMa09WbjUvRE51?=
 =?utf-8?B?UHlwZ2lQR1pPMk0zaGtRWGNhYUs2aFhoWldybU1oclB1SHJVbjlRMHJQeEM1?=
 =?utf-8?B?VGlFeTRGMnBEaTdiZU5iRTlJYTN3Z0lDb2hHeGJVZ1RvdUM5RmxvWnk3K1V5?=
 =?utf-8?B?eVpmbGxaSmcrZm1CRVRpUUZUTmszNlJWVmZ1Mzh0T2UwY1plSkFtakRFeUti?=
 =?utf-8?B?ek1CY3hJOFIyTEpjVEsrWGVlcHEvbTN4cGM3UU1GYWZxUzJSelNJTWdOKzhV?=
 =?utf-8?B?THh6MnZvNXh5VUI3ZEUzNDNCMTM4V1pXK1ZzekRNVG9FR3prdnl4Zko3bjYy?=
 =?utf-8?B?clpIWXlSNk15eVFCZFAzTmp5Y2dmRUFVYTZhSkZyT0xXMmxKMkMvdU4wbGRC?=
 =?utf-8?B?Vjgxc3dvelhxUVM3OHlIMDVmd1RVc09kRHl4QmpLdUc5RnpscWoxNndjQ1Uw?=
 =?utf-8?B?c0dscmN0UWJIcWdTNFNFN1RiaWk4ZzBKNWlXRURQN0l2SjZCSC9aZHJiOHk1?=
 =?utf-8?B?Ym9yODdIK0tPNXIzOE5QM3VXNzIzSUNHeHR4cFRFcmN6bnB4eDRhUmtrQWZC?=
 =?utf-8?B?WnNBc1A0a0JEKzBNdEw0VnB6ajNLWmE3RzZrdVd6Vi9GMTlYTWFBcDl4MEEx?=
 =?utf-8?B?eW9IaVJ0V3JDK05aM2taUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(7416014)(1800799024)(376014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aW1nTEIvbkYyRkdsazFjWGNhYkltY3BFT3ZnblJKZWRtaGI3OUV2Y3RTNDIz?=
 =?utf-8?B?eXhRSHducGN4MmIvSm9hQXlvd1RWbnNoK2VVdmFGTVF0ZWxmVG1GTUhKMjFI?=
 =?utf-8?B?Z2VEa21Qc28rZ2I1NWZqNHJXU2pwKzIxMG8rR1gxejZhcjMvc0c2TlV3UHRo?=
 =?utf-8?B?S0g5UktvVGp1UjJ2bVl3VzloT21tVWVseVdONGlGRDZnbGcrMVZSTHFHS05Y?=
 =?utf-8?B?bnNFQkZFcDhFb25DNWdHb2pMZkloVFNSU2FYbGtJbWpWamJ0aXNscTRVY1BR?=
 =?utf-8?B?dnB2cDdjSVZjVXdYb3NlZXpjSzJWNUNLejlnVFlDZGo4NlNjS3ZiaWR4REJ0?=
 =?utf-8?B?NnRGbE03cHQzS2hQb0RtSEQyNkc4Uld0YjZtTzZ3cFJFdEZia0N2OTFMK2Ja?=
 =?utf-8?B?SkFHbFhpV0oxemdXM1lOblM5ajFZNnVicGVKMXAvQWtPb05kNU1mdzBwdy9U?=
 =?utf-8?B?USt6QUVNeDl0bU5MYVFVNThZWWtRWkI2UGs2OVk5aFBrUGZjSkRJbnlVRTVY?=
 =?utf-8?B?NEdmL3ZxWkt4UThJVlA4em1TYVNscGxKajhRSWs4OHpLcE5TOEM5RnNuc1k5?=
 =?utf-8?B?VUVwTnF5eCtRcXZRSlhoLzlZR3BURWh4Vm42cE9JazBycllkdkxoaGg0WDJq?=
 =?utf-8?B?QlRuemtKMnM3QTRJUDB1WlZaV0l5NzV1VFhvcWlQaWRaNWlINzhZaGJvNmZx?=
 =?utf-8?B?WEFzamM1YjJ4eUowVjc2c2xqSWZBQUNMOEVBK1Z6VXArWW04VnRqNnlhNzdo?=
 =?utf-8?B?RzNCcGhubzZKRDBHeURlOE8raWFHZEdrT1lhU1dJSHJDQmhIM2o3MnZReGZF?=
 =?utf-8?B?S25mQU5EeHI3T3Vzd05scTU0OUxpZU5QQnRvYVltTVcrMTdKQmlMNXlDeWdP?=
 =?utf-8?B?enVEUUQ4WERQSmlBTmxhVUFGUmtsUE9WV3NHOEdTYVhGanEyU3lrQUpDdTRk?=
 =?utf-8?B?UVUrOVl3NG51NWx6SXFpYlI4OUoxZ2pPMjNJOFBkTEZydE5WMm1Id3Bsb245?=
 =?utf-8?B?WU12bCtmWlpPTXpTUmxjWnFuaG13VWFxNFlXK0hXMm42ejdlL2I3ZVBBUitN?=
 =?utf-8?B?Z1lsYlE3SWJOc1Q0SExKUk50SGZPdzVUejJDK3RacnRuSXRQOWI3cUdDYTZm?=
 =?utf-8?B?Z2pLb1NIMFhEc0J5SVVmWnZwUU8zNkVQdlU2cDRyOHFWMWdVRStwbk5VYmpn?=
 =?utf-8?B?N2FSajR1QmJRTzYvVFloVEh4T2l2V2tYTHRCSXdUSnE4UWpDMHlwQmFKc29P?=
 =?utf-8?B?R3lpc2V1SWptTlNrTmVKektYM25WenBjSlYxTmtiRzRUZFd2ZklibkxHNzBT?=
 =?utf-8?B?Z0JrMW5pWjhtMnZHWHQrd05ESzBWVTJvZUFoclBndlVpZDcyWUFoUmM0c01B?=
 =?utf-8?B?YSt2YjBaaFQwSkZIeXBLbUxQZUNjSGk3aWk4NWNxWjhGK0M5WWhxU052S1c4?=
 =?utf-8?B?bmk5c3pqYXZsSjNBWGM3UndRSnMyQVA0V3pJckNIWGt1R29WMk9UdGFBQ09H?=
 =?utf-8?B?RW1ZT3cyWDdtRksrTS90bTI3Z1V5Ymp6b3ZJQ2loSlgwd3ZheUQwM1diQ2Vz?=
 =?utf-8?B?Tm1RUUdIbGV5NzhxVjZ6ZjZic05seUdQalJZS2pJZkNKWU5xdUdrcGM0d01X?=
 =?utf-8?B?dHd0RnNGdVZaM3p3Ym9mN3M5UW5VMVNCdTZnVWRPUnh2TXlsMEVCa0YxSjJx?=
 =?utf-8?B?SE1hUWxaajZ2NkJhdFJSUzI1bm93bGQwT2M3ckdvUDhtUHlJenlTZGpYOEpw?=
 =?utf-8?B?NHFxNTJWVGhBS0xnNnNBTmVQdVBTSmp4UjNVcThtSFRrQmcrWTJ6SnBCYnNw?=
 =?utf-8?B?S2JaMWd5UUtHK3I3QXJNQWZEYTJBcU50RGNNc3NCb1JmTHE5OFpVbCs4bG9K?=
 =?utf-8?B?NG1RdHJlODBETnBmVkl4NFN6M3FGYnBFbnc4akoyQ2ZoYURlRkRsZmxJaXNr?=
 =?utf-8?B?VnRObFo4KzBpZVVhZnNUSFlqM2pxTm90VlNWQURIeW01eDNna1FCcDhmUGZK?=
 =?utf-8?B?TWtXTUsyU0VvQkYyeXJYRUNBSnp2eml4T25QN2UrRDlrc1l0N21LejQ2Y3Zs?=
 =?utf-8?B?OGdsdDNsOW8wdWZvNG54QjNlTGhjVURwUWFiNHFGVWRWcDRpbUg0bHgwNk1r?=
 =?utf-8?B?L3BPNUprYVF0YTdRSjhHUzJhRDJNb3VFa01QaEZyNGZIK2J0YVNMODBQQXd0?=
 =?utf-8?Q?2OuuYh5LM2XU7T0+qDGMcfs=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ca2033-ab40-4178-ae50-08dd0e3d789a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 17:12:13.7045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nCA6kKUQe0IXKP0fg0TT+swltth3710IuA0G2m2uZ9eY2PQCX7IwscraZhFpcjrITt5A+g2a1mN/BqtqoCOJZw8r60QVMzQGnLUlTWak1Rs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10080
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

Hi Heiko,

On 11/21/24 3:27 PM, Heiko Stuebner wrote:
> From: Detlev Casanova <detlev.casanova@collabora.com>
> 
> The rk3576 defines some more different syscons, namely the IOC-syscon
> holding io-controller registers and sdgmac holding settings for the
> gmac controller.
> 
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>   arch/arm/include/asm/arch-rockchip/clock.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/include/asm/arch-rockchip/clock.h b/arch/arm/include/asm/arch-rockchip/clock.h
> index 73e5283108b..82305ef17ae 100644
> --- a/arch/arm/include/asm/arch-rockchip/clock.h
> +++ b/arch/arm/include/asm/arch-rockchip/clock.h
> @@ -32,6 +32,8 @@ enum {
>   	ROCKCHIP_SYSCON_PIPE_PHY2_GRF,
>   	ROCKCHIP_SYSCON_VOP_GRF,
>   	ROCKCHIP_SYSCON_VO_GRF,
> +	ROCKCHIP_SYSCON_IOC,
> +	ROCKCHIP_SYSCON_SDGMAC,

We should really start migrating away from this.

I would hope that the generic syscon would be enough for us. The issue 
would be to migrate all

syscon_get_first_range(ROCKCHIP_SYSCON_*);

we use in the code by checking the DT instead, e.g. rockchip,grf 
property for ROCKCHIP_SYSCON_GRF. For DT-less driver (e.g. SDRAM), I 
guess just using a hardcoded address would do just fine? Like, I don't 
understand what this brings us.

Anyway, a topic for another patch series :)

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
