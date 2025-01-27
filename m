Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DBBCC0218C
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 09:55:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05B98801DE;
	Mon, 27 Jan 2025 10:55:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="IJ7HHwbl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5660800B3; Mon, 27 Jan 2025 10:55:41 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::700])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51DC780FF7
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 10:55:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cO1UbhUdQGZnMIc0/RGOf3wxIzBlItMqGEPPH+PCL/x+TR6QIw5YQDlwgU3mqHguVWDGVxSnAq1NkgDzOvHNJzevIbbpZsj28FlE3IKL8rrQvA9faqiuqeo71TmU48nL+UY9b2vsUCP1g68reDy3Vd180vupxX8SdeG1CKRPa5gz9ceKTaIT71+BszhA0nVtfiYyxY09AO8rjSOsNX7p4Zbg5EvEIeKmwMpL049bnT0jtD+DaRp26G5nv1Bv7ETBxkQa2nftHD+8vBbbRU5qePRVKA6Ey54BgRH+oOEbb65bG2K6pLOC3hW+AYPJhF+iPBwqaPgb7ieaml1zumSo/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjivtBJqQ5L+SevuiJZZOUPSuzdbk4+eJkPgkC/UwuM=;
 b=vb6cqNFqT9+ibvDeuvJbkIH4XujafjjA6BibpdOhstuGGBLK20+JkflpkCYU9r0vKQcJnqbaxsnVmv7LwosHNHAXWSDUEXG7ybQyokK8TrqzGDoQm+hkdLy5zTjRPQLVoUAl2VJ5mo4LTM5vingJDIP+kJ7+dkQi46BAc3XQAKsh11udswNJugLhbHOkTLtVx6hecAYDJsYxNsCdWzlxWlOnuGPk7pZF/2DylLWNxsk2Yq68aBrJpvZ9gxhVNbm8FQTS1ynVRiDtNyyTBQhIiNsDXJwYaNkmq9pD0K6H0f3ifYtPdIvn995J5jFwhumeoK7b8zakihpfzjIb163OJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjivtBJqQ5L+SevuiJZZOUPSuzdbk4+eJkPgkC/UwuM=;
 b=IJ7HHwblHtXrDNLScTsM6cyWWRv/p5VOouF4b+LOpHmnvPog0cs+mdMxdCY0RcO2/CO1OIB/fyOaR9J4YSPaFWut3fKx+0kVjLwCeyqm271ZJRL7zR5LmfPnQW6hS6loCpzkrvsdL8f3za2d3T4pDqCTtJSuZcjw8XG3JhjkgwNoQpT8ARF/vfp19QNUFbdKgA7x6EjcS/TwfBtNZTrQ52WDJnbnZjkazOl7+tzNSgy+MlartwBtVrpXgWw/RSe3VVynfNr5afP9rMrONZOvMfiWeIP1V/pBhl2Zfw9vhjuCAbvhh/xyqpf0geVSAt7B1u7brhvYZV2tvm9dvn47Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by AM8P195MB0900.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1e9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 09:55:37 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%6]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 09:55:37 +0000
Message-ID: <ce9af92e-3766-4f88-864d-7310e91be8ce@phytec.de>
Date: Mon, 27 Jan 2025 16:55:31 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] board: phytec: common: Add product information to
 FTD
To: Daniel Schultz <d.schultz@phytec.de>, trini@konsulko.com,
 u-boot@lists.denx.de
Cc: d-gole@ti.com, upstream@lists.phytec.de, y.moog@phytec.de
References: <20250123144350.846527-1-d.schultz@phytec.de>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20250123144350.846527-1-d.schultz@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:820:c::22) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|AM8P195MB0900:EE_
X-MS-Office365-Filtering-Correlation-Id: b2648578-d5f6-45c7-5ce1-08dd3eb8bfd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MkFnT21sbTdSQ21QVUt3Qjk4dU53VFVXSGRsbGhDZ1BZTzVUbGxyKzErZXIz?=
 =?utf-8?B?a29Pd09aSTBuSVN2S2tUN0l5VVdYWThUcUZsdytCZnBOU1FtYW9yVzNXMys2?=
 =?utf-8?B?NkdrcFRRekwzNDhsS0lzOVRhZG1yUy82akttVUh1b1pmS2t6ZDJrTzNoZkVm?=
 =?utf-8?B?L3o3cmVUYmQ3aHp1bVQzaSt1Y2ZiRmMrTmR5My8xUW5YNHFEaVN6UkZZN0Y0?=
 =?utf-8?B?c1VVVS9aaTd2bXlhNXZqdFpaSzliRWVETjZJUFYrOHNpUFVFL2JnTXJjbU9y?=
 =?utf-8?B?dGt0TGpzODlGQ0NHNEJVa1RmMEtuRXMwb3oyK3o4L2RScXVneW1JTldjL0Z4?=
 =?utf-8?B?Z2tzaHNHQ3FKNjFtTXJwV0dhV0ZOUm5aMXNHTU1KeUtHYzFFTndRYittOVZT?=
 =?utf-8?B?VFFaRDBFTEFzWmxwbVVXQ3BvMzV2bThnNEttWERLQ1dCUVBTT0RLaG4rYTUy?=
 =?utf-8?B?bTJLdlBCZ2c5VDgvbUxuclgzZ09DZEpOd0trek9CT0oyMzRIcmJablhENlVY?=
 =?utf-8?B?ZEczUis3R09XTlovSmNrNlBxdUtqWFRRcXZqbkk5aVliR21ycnNicWxkTU9P?=
 =?utf-8?B?YWtMUVRmVEFHTmxaVmp1ampRbzhOdHVlTlg1OVhSY1BRWExkbHp1Z285alhS?=
 =?utf-8?B?UG1Oa1pwL2QrYUN4Zkx4aGN6WXJUYStsNEQxRU1CdFdWbXMvamhEYWlRcXlm?=
 =?utf-8?B?aGFNUTE4M01UdjlxRnVGS1BwN3UveWE5QThvRkQ2NDRnNDM2L2VidEI0Z1ZW?=
 =?utf-8?B?UkU4V1JZeWFDRVpZUVZ0aGxVaDM1MGlXcVNLWUdRTjZ1ODl0K0lEVFRXWVlG?=
 =?utf-8?B?SllyL1pvbkxKbFdnc0F3UGhVaDJGUjZtdHRTd1BrdUNaTGRSMCtrT2ZGamhv?=
 =?utf-8?B?Q1hrUGgybnZvWjVwR0RCYzRrN0p0cnVWRE9sM3A1RnBIUTBkNGsxMzBsV0lz?=
 =?utf-8?B?QUJ6MElGRDczc3VldjhPcmsvU2lNV0Rua3I5MmdkS1JTYksreG9ZLzZlclpw?=
 =?utf-8?B?c0dQdkY2T1BkZk51bHlYdXlXdGltZmgyZmtzbnh3Mm1rN2I3WEpUSTh0bmN1?=
 =?utf-8?B?ZHBBQi81TFBrVG11eVdFaktnaTlTVks3WC81d3JBZkZXczkwZ2tNdnZPY2lX?=
 =?utf-8?B?a0I2SlNzVmpRQ3V5OVdMS1ZzbjdLTDdtc3pTMTIwVkpMTTFVcGJsRTdSajZZ?=
 =?utf-8?B?UlJpL2RkYnIvT2pzWWZheHhXb2puVk45ZGZzUlRmV2JMS0EwMFAxS0lYcGtW?=
 =?utf-8?B?U0R2dzFDYno5TWN0OXdTYTJJNEhHU2dFM1BZMVlEck9TcmgreWMzMFp3ZCtr?=
 =?utf-8?B?WjMvMGVRNUIxWHQ4Ymc1SklBU1NLYXM2d0ZDZTNyb3o1TjB4S05iejByUFE5?=
 =?utf-8?B?UmphTHNJM1pqbllZTW1lRlNvYUVxTVFYNy9FUGxuek9GNGdqTXZGYldPQVZo?=
 =?utf-8?B?d0N6VEVHdlc0a2NuWGd3czZkVEpVemZpQURlOU1JRzRvNUEzNXpHbEdaenl4?=
 =?utf-8?B?MDlGeStaK3NKYmIyOE4vcWNWM1hiSlNxa0JWcWU0b0diOGlWNEFCUi9RcEVV?=
 =?utf-8?B?eFRORVJwcWRzdHd0QjhRL21pbVFoNGxxUWc4OGorcXpCR2xudHhiNERCS3hG?=
 =?utf-8?B?WlVIQ09VelE1SmdWeTRaaEhNV2dCZzVsUy9pVmNVUDVzdGVKUlhYeUdFSnJE?=
 =?utf-8?B?aUxjWFF3cjh1TElFRWFsR1RHbk4zMmlraDBqME9GZlk5RUl2NnJOaVdaMVVw?=
 =?utf-8?B?c2k2WUJzWGxDU0J2V0l5a1hXUnhNc3FhbTMvZW1QaXZYMjYrRytmRnc4Wmpj?=
 =?utf-8?B?RkZ3cnprSnloZTdxSkVlWjJFMGFHbFhuc3I0Y1lBMjBkRjdaSEpPczFKZllV?=
 =?utf-8?Q?Uqt0CFw9AUU6k?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjJRRjJZWm9iSUdmUkpqUXFyQWU0d01nMzlod3F1L2VjanZKVTRKUGdLWGsr?=
 =?utf-8?B?N1FCby9hM1NNT3FaSFhBdlBaYzhmZ3dhdGJJTXdTMERYSXRqaE1DV0ZreW9S?=
 =?utf-8?B?Z0JibEdmSHpJQ2JXQmVHQXd1Y056WDB6RDh6bklVTnJ1ZjZLSFV4amluL3lR?=
 =?utf-8?B?OWpSL0FJY25tTkwzcEpiNGZaUWRERE5wTEN5T0Nxek54RXgxWDNiWjVBc1ZO?=
 =?utf-8?B?WUdRMXk1V1dqOW9FTXJQOVB1STUwdWJ5RGxDN00rK1pLelcyaEtibkNIMnli?=
 =?utf-8?B?Q0NKWnVoMHNvUms5Q08yNm9aRmdMVUxrYUFnay9vWWZZTzYzUVJWYXhmV2w1?=
 =?utf-8?B?KzVBZ3RFWUh4NDMwcXZVRHlzSk44VGhYMW4vUTNRVHBhMGRydG9mT28rQjdK?=
 =?utf-8?B?R1BsTFFxNEJ3ZzBmeEQySFpZWDROcVNSdVdkMHdSVjhZNVZMSktiLzZoc2h6?=
 =?utf-8?B?YVExNFJtQ3FRS215bFhTRDNaOEN0dnZ5VnMyMThYZjdVM0lwRWhleHpyUmY3?=
 =?utf-8?B?bllBakY1VGtaYjlwN1lDN0RzNm43elFUNVRzMFhPeGN3OFJQellIRkRCQ0pr?=
 =?utf-8?B?ZElISnppbzQra3pMNVR4YU1xSlFFeC90S0M4Y1pXc2xsdkNlSkN2emhPNzRC?=
 =?utf-8?B?cEhvR2Y4WjZ5bFVScFkzR3paYzhFQUk3eVVTbUlRODdYek5zcWo5K1l1Mloy?=
 =?utf-8?B?UFU5eVhWNUs2MllCanFJQ042UTZ6Q2ZtVktYaG1lajVhZ0hkWE1EdDEyZ0NF?=
 =?utf-8?B?ejVzOGhadmJheEhMUTVSckQ3Z0NBbEFSWmhKS3VpYnVlaHJvMExCT3hCclI3?=
 =?utf-8?B?NkNZMCs0M1FBTlJjeGdDaFFWN0VwYXpmQWYwSXR6TFgzcWZvNUwwZzNKL0Zt?=
 =?utf-8?B?OW9sMDMreG03MGJ3RGdrQS8zQk5tQkR5MjN4QktVSVl1NUcydXg3bWN3WVNC?=
 =?utf-8?B?TG5DZjlxZkE1WDFrOVpaQXd4TS9JM05welBJcVNESTVpK0JBWi9CZVUzZnZy?=
 =?utf-8?B?bnB1b1dEWEQ0dXdDTlVSanRTWXNhaGtxUUk0VG4zWXo2K0M3WE85Y0NYd2NQ?=
 =?utf-8?B?RFpGWXY5UkVrYzBTenNVcXpIcTVpTEpBWTA1eVBvMVY0amNlVjIvS1pGdC9Q?=
 =?utf-8?B?VG5Yc1VyR2FYM0xFTXB2OERsanJkMlBmUnc2Qm4yWWl2NVRMcUZGRlJSeFI3?=
 =?utf-8?B?UExvVlR1NDQ5NForSzlKb2lZZzZteVFYMWlNVWhTbGYyeXFacm93ZElJMENK?=
 =?utf-8?B?Zit2VjFpcnovWUNRb0dXOHUvMzBkeDRBdDRwU1AwOEhlN09jcmNiam9pMHpH?=
 =?utf-8?B?aml0ckhNendDc09vS0cvdTIyVjA4OHcveXJzVGpHZXJYYkZDRXY4Z1QvaVNw?=
 =?utf-8?B?S2J4UERvallGTjcrTkpFN3pBZnYwTXZjRll1WmNjOHhRUmNINmhzODVJTGRX?=
 =?utf-8?B?dG9uTDhOWEdPdmZDL1IxSVBhTjVDRnlzNzUwWWVQUjVRM293dFVHSUpCRFgw?=
 =?utf-8?B?bVNkbDYwOFJQY3BYNUdCcExTVHBuZ05zQzJrNit1U2E0UXlvRCt4Z05mYnl1?=
 =?utf-8?B?RVZuR1BXSkh1UGVlVXdHRFpRSWlZZ2w3N3RFc3N0KzlrZCtqM3hja3BtYUJT?=
 =?utf-8?B?RlZYb24yK3UweG5qTS9Seis4L1lnb1ZpUnAwN0xINFFsOXJiRDIzK2NScGRF?=
 =?utf-8?B?L25IVzlDK2JST2FzTzduVW01aWszSmlPQXRsV3JXV0RzRFd0WkxSN09UTExT?=
 =?utf-8?B?NWxtQXpFUlNRdUtUcVQ0Rllic0RQNEY4Nm9zUjBVbGlvM0xZdjd2NHJnMmNI?=
 =?utf-8?B?NUNBTnhJclRzcnFSbXVWSThmVFE0L3RtVFQ0TllYam1uS0F5WFNDQ1R5Qkxn?=
 =?utf-8?B?eitONjBHVHIvMk5FYUQ2dWRSdUNkTjhWZkRvaDFBS0hZdC9KYzk4TnI5NHQx?=
 =?utf-8?B?M3Q5Yld0eFBSSWtwaHQ5MkFDOVREWFIraWJXRmk5NEowVmhIc0lYMWRhV2tM?=
 =?utf-8?B?VmxCZFlMVDNyTTZMYlBpMEE5U3RBSVQ2S2h4Zi9lMEQ2dzJQVEsydlJPQWRV?=
 =?utf-8?B?aDJ6OTVXYnBJK0JlWkVKMmdNMjhtSWIyYjhKSnZlSXpsekhxYytLdkdIL3pO?=
 =?utf-8?Q?8PptJjDUbLQLb0tmHgw0buUvL?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b2648578-d5f6-45c7-5ce1-08dd3eb8bfd6
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 09:55:37.3176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jZeYuH3mbrSSqDOeXrVsTXfGm9fVNiejodj862kUOIhbRUxK7QAL/k5gIGuonKJEtosORiXoFj8yTrMvcQXi1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P195MB0900
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

Am 23.01.25 um 21:43 schrieb Daniel Schultz:
> ft_board_setup inside the board code allows to alter
> device-tree during the boot process.
> 
> Introduce a new function for the PHYTEC SOM detection
> to read the product name and part number from the EEPROM
> content and include both into the device-tree as
> * phytec,som-part-number
> * phytec,som-product-name
> 
> This function can be called from the board code when those
> values should be exposed to Linux.
> 
> This patch also updates the phytec_print_som_info
> function and changes the output.
> 
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
> ---
> 
> Changes in v2:
>    * Removed 'struct bd_info' as argument in function phytec_ft_board_fixup
> 
> Changes in v3:
>    * Removed not required check if variable data is valid in new functions.
>    * Moved '+1' from string length definitions to snprintf calls.
>    * Define more string lenghts to check snprintf result.
>    * Return -EINVAL instead of -1.

Reviewed-by: Wadim Egorov <w.egorov@phytec.de>
Tested-by: Wadim Egorov <w.egorov@phytec.de>

