Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C75F8CA0FE1
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 08:33:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23FF381E13;
	Mon, 25 Aug 2025 10:33:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="jQBYcQOw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D8D082DA1; Mon, 25 Aug 2025 10:33:52 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::61f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9634A808AF
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 10:33:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9R7qw2mFndfBWFufU5OLHWtDbaOoF+t6USqZRYwphVNO81OhyepH2Q+foQDilClupHVpOZJ6WSTtuwF9jPyi4E3Qwzfe+17cedjD5QMJ1EfKEv/kwBjzM0Fnv1Pudb+qtZjbpZAzQCT0EPjP2QvB+52FowL4nfJ+O1l8pFd33cdUkS4Xu7+r4HbcCdQbCnIzsDCvmWxBWBG55yLsjdrVZTRzSCo0HdY3nIWcsTtyhlOGXne01Uy76fkjS/uSzy2DLSJmMzE42Vgj5C9nMIFsWzcos/Be0AWYU0fG64IfJSvwYmh9rhKjK2W9c80wQdxT4EVHx3U0a9d3NL4pHndhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cekjR0q1bZbjJqkZopOzyPFxz67kqkllDkH6iLC6lS8=;
 b=n5eqx/8ir7hTLZ3rrsKEbgpi3DqsIuFF8d8QT5QCzOyVhGMDZ4LkTMS+iqnJ6rUm6s+D2sSG96HVz6Xb1KvdtC9GX/12MJGrIwDLPTddn0fXQROueESDkOcppmHGiFVKGvEHcn/FIBoksoFokNcM60hxGzmiIXwwzqa3WGQSyhBC107KskE/6A7PvERxlCSlK9OqzC+Ez4934JmvF8UonIzW1UdnHQTU1LQWXfkt4HXbLisJZkLOxyUvD75rl+GyCwDo6uLC/n0sSkGrjqPGY1OfiC3dQXvn3GxZ8wWzZJQpxBfwL/HkLdEGpGDC0nCs6sATrNBBJtkNyur7hD9VXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cekjR0q1bZbjJqkZopOzyPFxz67kqkllDkH6iLC6lS8=;
 b=jQBYcQOw9ng+CT4mq1diKra65l/J28ZYjdjWFqyLfmvzZD0dHA9RrFAF9CgRm5rawfrAo9lcPZ71QY9pzlD8MkdUcHNbFEyCqGkvX9NRcZ17/G+A7QlITdNIwFwuZYh/4s1J5xOOFimur+Aqt6Fz727/y+nZjiYbuWv9jF25dhBkglay91YrKyuGQ4r3W62td/4XMtVWVIbA++NhvCIwKlT/hYhFQbmL8uPveh3EfZdpVbsAZoGW+RgWx8Wg7Jr2619MzyrIUGaZa9lHmE+Gq/ovmcav06l/p0NN6iYtz93Zx0QLaogQCSWpLWQq57lSmP/GjnsfAcrBPEMIPzemIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by CO1PR03MB7937.namprd03.prod.outlook.com (2603:10b6:303:271::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Mon, 25 Aug
 2025 08:33:46 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9073.010; Mon, 25 Aug 2025
 08:33:46 +0000
Message-ID: <f25f3eb5-78f7-4074-95d1-9cc5650dff3b@altera.com>
Date: Mon, 25 Aug 2025 14:03:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: clk: agilex: Correct EMAC clock source selection
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>,
 "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>
References: <20250819043743.8000-1-nareshkumar.ravulapalli@altera.com>
 <LV8PR03MB813799171F17A527BC37322AA73EA@LV8PR03MB8137.namprd03.prod.outlook.com>
Content-Language: en-US
From: "Ravulapalli, Naresh Kumar" <nareshkumar.ravulapalli@altera.com>
In-Reply-To: <LV8PR03MB813799171F17A527BC37322AA73EA@LV8PR03MB8137.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0018.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::18) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|CO1PR03MB7937:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ad298ee-ae81-4110-ad4b-08dde3b21b59
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|13003099007|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1lLcjlHYUpWM3NCZFdpOG9Wd0VHbWdJUnEwRnJrTE92ZkZ3S0s0Ly9LZGpo?=
 =?utf-8?B?ODNCSHZENm45T2VSQVgvbEdhMXkvR0t2VWIvWWp4M3FpcWJkeFhMMUMvcll1?=
 =?utf-8?B?NGVtVktMeU5xMzEyZHRGZndodCtnQXJBYjg4dGJ5VUtjd29HNDdOSDQ2akZ0?=
 =?utf-8?B?cmF1MDRoZk9DdHhmb1puekFSOWhnOUROWUFpQ1NqcGV0OVU5SDFwNjQzRFg0?=
 =?utf-8?B?dFRXZkZTNGc1UnZMQkJ4N1RWY2NiOGdqdmI2TWlpbG9qQVFUM21MN0V4YlJZ?=
 =?utf-8?B?ajlEeCtXTU1jMG5FWUdaZ2dlU2lKWXJSb1kyK2ovdGRjcUxTdVoyTHQ3SE4r?=
 =?utf-8?B?cjNSek9MV3MvVHRVK0w2QVpGNmxZMEh1dVNJRkNvU2xOSXRPMnBiYnkvYWt1?=
 =?utf-8?B?cllCbWlrZ2RFeGtRUytyblo1N0k2Z0ZuNUV5WVMweW5OSDkxRHIzTGo2L25m?=
 =?utf-8?B?KzNzMlNhSk1DbEl0WmUyMzJGYS84RDd6dG5qY2FVQURtVFBiRXdkbXNlc1ly?=
 =?utf-8?B?Nm5SL21Ka2hJS1k0eE81SExoWlI0VXB0dm4xNVIvb3p2TTBoanJ6cUhJaTkz?=
 =?utf-8?B?UmNDYlc1SUN1T0prMFVXWWRHMXU2K0c3M01RSVVqWjdYdnFhQjNMTjkwNmVv?=
 =?utf-8?B?NEYvL0ljaTRvTTI5aTcyUUEzalAwekZ2cVVaODR6dU1LZEVpMjVSWk1nSHds?=
 =?utf-8?B?dTB0ckFKRy9iZktucENvbHdSc2xPd09ieXB0bU8rR25veXdDY2oya3hYT1Ax?=
 =?utf-8?B?VThTclI3UE9oVkJNZi9tMHFIcCtiMUxFNVJFaU42MFhHQllPQkwrdXBLeEdS?=
 =?utf-8?B?QUpLVXQ5Zlg0ZE9wYUxJSEZ2ZnVxb2wyQmtVZ2NRRjBmT1hkMTV2cW9lVXVS?=
 =?utf-8?B?bk5rN1A1Qi8vUm10VUh1YkdZR3FhMGlyOUxhRk02bm16MkxQMy9yNldocXBF?=
 =?utf-8?B?SGRZdTlwckt3NjVLZlJabUI2ZVE5OXowbEtvZ0d2MjFkejUrTU90QlNYejZG?=
 =?utf-8?B?RFFEU1NQMWxXWDdiOFRTVTl4VzJQUCtBQXBEYk5OeXFqeTdUNHBrVm5DSklW?=
 =?utf-8?B?cWFQWTk0MkJaWE1uZ3B4S3B0RDNxYkRLK2NmMWZCWHovZ256cS9CWjVYSE9O?=
 =?utf-8?B?SVQzZ3lIUmNDQ2tOYW1PaGUrclRXZkorVFI3NUk4Y0tES016ZTRZRndxSlVm?=
 =?utf-8?B?RnhZNWRzNWtwL1ovS0w5U3BVWnAybFZtWlM1Yk9udVVVTU5aRWYyN0QwTDIz?=
 =?utf-8?B?TzIzTTFGc2tpaVM3SjNsZ1UzNjV4VHhleWxXeU40R1hpaG04NzM5WkRwM1BR?=
 =?utf-8?B?MU1kVklRcXl1VkJSRWhyWTVnMFpuMlVWaUZQWVkrcFNEb3VCUGEwY2FML2JW?=
 =?utf-8?B?OXBxcU9EQW9lK0NCZGhjK3dXc0I3akZRcW9DaHB0T2E0Q0hXbnI0cDVOWjgw?=
 =?utf-8?B?TlNQdUNBRldSMUNTQmpSanp6ZEJBeFpscFJNZ0hlRnVmdXliSnFSME5CaDdZ?=
 =?utf-8?B?V2pkK21xK0I3QjJoU1dBQytVeDFzRWNPcGJnTklqd2VJVXJNRjdoT3pEckV2?=
 =?utf-8?B?Zi9kYkNxT3dvbW01eFppaVBuOVVzTVR6NlByTzFrZjNhTHVXMkNvZ0t6RXBP?=
 =?utf-8?B?Z2RVeFhMYnMxSS9JSlJUQWdwUERqNVlEWmdnVWFYVGpJUXgrTDgrU3d3b2dE?=
 =?utf-8?B?QUJhTGx4eE15enozbU1WN3c5aW5WSHdydGp2VVNGWTNQMHQ4QjE1TEplc1Bj?=
 =?utf-8?B?ckxranluaVFXZkpvc1pTRjl6cW5ZVitvUGF2dm5qd3hEbmZjVW9tdnhHWFhQ?=
 =?utf-8?Q?XlluDk9TqsUePvu/PokwF3wBSDrnhBBoUFV6A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(13003099007)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bll2UEhhRzhWUnJ1dHRKTjRoSXdZUnpLOG8zV0Y2dmJMR2V2ZlJ1R3BNR202?=
 =?utf-8?B?cDg2Sy9vSDVpNUgzRzRtcS9JYzdqYUlDbVBValJMaFdTTDhjdmwwN2hqRDJD?=
 =?utf-8?B?cGwraGd5elQ4VlhobmZhRzJmaVp5UlR1aUxwTVMxcEp3d3Y1V3gvQktscVhR?=
 =?utf-8?B?RlJ1L1Byd3VhQ0toc0tBeWxPUlRwQ3UyekQyUFVkRHgvMW1iVXhzSVNqSVB4?=
 =?utf-8?B?YUhZNVNYaXg5SHNnb25hY25ZQ20xWWlVS2dQTW5kd0F2RUhQREpCZVFBN0g2?=
 =?utf-8?B?QmZNL2lyVW1pK3BmVExZbWV4bjJwWklvdm9namhVd0YySC80WVNmUzNLSkJW?=
 =?utf-8?B?NythN25iZVZUT1VEQmRzUnNwMDFHZXhwb0tYT0pOTVlwekZ0K3BMYlZkM0lH?=
 =?utf-8?B?cXJUOXV5S3UrdEd6L0lGZVQ1b1lkdlVWV2FWZmloZWs2WHFLNnE2aWM0NklK?=
 =?utf-8?B?RXk2MVhaenlVYmFmUU14dzF4ckhyNmlZV3ErbVY2SjVWUVlRS3BwbjVHZEdl?=
 =?utf-8?B?YWNFN1FYcTcycnBwQjB6eHllRHVKL2RIQ1FFYnRqTk92T0Nqa3o2MURDeVJO?=
 =?utf-8?B?dlRqczNkTkNKUFNRWnJkT0V0dG4ybSs5QjdIVEZqUXI2RHBabGplQVIvcG9s?=
 =?utf-8?B?MTFOTVk3TEc1WEVFeG5pY1JNQkpRVERUdWdEV2NTY3I5QThSRTNaYWhHbU5U?=
 =?utf-8?B?RXdnVDZRT0NrSGxUZVh2MGJPbG1XTDhGSEhCaFdzajdxMVRmZ3ZUbWVoV2hC?=
 =?utf-8?B?aHdxV25idm16ZWJTZWxXbjJQNW94OWd6UGpkM2FuRHRkalBHTEVZRjR5T1Fs?=
 =?utf-8?B?eHBDTmZPbEh6RVhsTnpLYy96VWdSR1ZyOFdxVUJPK0xiWEp3aEthUGpXb0Fi?=
 =?utf-8?B?bXN4dFlpampLd0JkNWkyMmdxc3FMa0lvWGpIZENlNXBQRGZyNk9aMXBMV3lZ?=
 =?utf-8?B?WVhJaXd3ZjNLWHFrVkVoTkliNi9LU092cHpOTHpPeXhpRXlHRzlkRmRVQTF5?=
 =?utf-8?B?cjJQcTdWQnpIU0pKMGluM01JTW0zOGo1bHFKa2JOYlF2WEpOdUFZdWFoc2R0?=
 =?utf-8?B?N1ZkUVBCbGVyWFdCNW94L0RGV2xMeGxHQUJaZlZMR0R4QTE3S21MSE83Uk04?=
 =?utf-8?B?M0ZYM3dPTFRJam1vRzFzb05sNFl6SWhmbGN6T29TOGg3K2xsdVpSR1F0RmZn?=
 =?utf-8?B?WHZyUVZtWlhHWlFPQjFSWk0wYUlyZkRxNGM0d0xaYk11dFVRM2l6d0pHTVBw?=
 =?utf-8?B?dExmUVloZGR0b0dSUzFLQ2pPNHNWcFZaQ2pjMVV3eWpkMHBuYWRNVktKbkRZ?=
 =?utf-8?B?RTIzT2tWRWhSREJRaGdVbjVVM0NXL0g4UVFhQ3ZrN1JiR0hEczF3RlIwczF0?=
 =?utf-8?B?TEZicU5vWmc0RmdKUzBRd2czaVlEQ1dYQ28xU1RsYnVQV0FGb29kUW9WZTdn?=
 =?utf-8?B?dUVxc0pPUUxyM2lISE0vMDRFMmhKcXVuVG5QbjVEQlFnamFlaGkrUGM3dm96?=
 =?utf-8?B?NmNTcmExcWw2M1ltQkU2ZGY5STA4UE9WK0NnTkxnZE9tK3pRcytrNXpIQlpT?=
 =?utf-8?B?eWpxWEtrS2xhNStIV1RVZTE1SWhPZ1FDVk9wRE9nUHRuaTBBN20zQzdMVzFN?=
 =?utf-8?B?aVlOSUNBNWxubHJ5M0l1Zjc0cDkvOCt4VDNud0sxMGR6UDJ0Mnpsa3FIUlZn?=
 =?utf-8?B?QU5tcmlrWGVTVTV6bXN3UDFDV2NxWUZsWVh3VHNCcy9pZ3ZOMzhHUXc2R2pX?=
 =?utf-8?B?cjlLU3pOek4xdlM5YXF0czFHMm10QWtoN3U3b05iYkxTV28xRlZGUEprc0JS?=
 =?utf-8?B?RXJ1THkrVVo2R0I3RG92MzBtL1hnVHZYV20wbzByN1FVYnhCdlE1MUJJRHMz?=
 =?utf-8?B?NG1wd2ZURFdWVUFVbk9CTE16TnNvaTI5eFRaazR6UnVsU0hoV2tsVDJReC95?=
 =?utf-8?B?SUZhelVaRVdwR1ZLZ1RjT2RKZ2xISEJiNWpMb3Nlak02bjh4SEl2Qk5SejJX?=
 =?utf-8?B?c0pGcHdZb0NKcDBHeERRN3B2bFdoU0tnd05zTWErZEVxUGFWV3kwdk1jSm9W?=
 =?utf-8?B?Nm5mK1JDcmZudm56YmVIOTZPVHJ0MG5od3pDZVk4R09hTnRQQUtFSzQwazhU?=
 =?utf-8?B?M1ljZzltc1ZkY2NFcGZqcHM4c0lKSHZLMC9GR2VkQ1VPbnVFc2tTZWVIQ2hz?=
 =?utf-8?Q?DauQuoFZYn5tsSo8xYrL0j8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad298ee-ae81-4110-ad4b-08dde3b21b59
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 08:33:46.4724 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XqiAikjUeZCrHEI6xG8yBwn9FArm/K6zj7kMBGP2BU3dlILq4SVgb7zG0KUceAIfLAYOnl9oCZGR91LvdYrYFWlXey0TkdCXo8QxHjho97OilzMVxGUvWfBQMm1ZVsFS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB7937
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

Hi Tien Fong

On 25-Aug-25 1:58 PM, Chee, Tien Fong wrote:
> Hi Naresh,
> 
>> -----Original Message-----
>> From: Ravulapalli, Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
>> Sent: Tuesday, August 19, 2025 12:38 PM
>> To: u-boot@lists.denx.de
>> Cc: Marek Vasut <marek.vasut@mailbox.org>; Simon Goldschmidt
>> <simon.k.r.goldschmidt@gmail.com>; Lukasz Majewski <lukma@denx.de>;
>> Chee, Tien Fong <tien.fong.chee@altera.com>; Sean Anderson --cc=Tom Rini
>> <seanga2@gmail.comtrini@konsulko.com>; Ravulapalli, Naresh Kumar
>> <naresh.kumar.ravulapalli@altera.com>
>> Subject: [PATCH] drivers: clk: agilex: Correct EMAC clock source selection
>>
>> Fix the incorrect bit masking and bit shift used to compute EMAC control
>> which in turn is used to select EMAC clock from EMAC source A or B.
>>
>> Signed-off-by: Naresh Kumar Ravulapalli
>> <nareshkumar.ravulapalli@altera.com>
>> ---
>>   drivers/clk/altera/clk-agilex.c | 17 +++++++++--------
>>   1 file changed, 9 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/clk/altera/clk-agilex.c b/drivers/clk/altera/clk-agilex.c
>> index e1ddd02f356..967d8a41272 100644
>> --- a/drivers/clk/altera/clk-agilex.c
>> +++ b/drivers/clk/altera/clk-agilex.c
>> @@ -1,6 +1,7 @@
>> -// SPDX-License-Identifier: GPL-2.0
>> +// SPDX-License-Identifier: GPL-2.0+
>>   /*
>> - * Copyright (C) 2019 Intel Corporation <www.intel.com>
>> + * Copyright (C) 2019-2023 Intel Corporation <www.intel.com>
>> + * Copyright (C) 2025 Altera Corporation <www.altera.com>
>>    */
>>
>>   #include <log.h>
>> @@ -515,14 +516,14 @@ static u32 clk_get_emac_clk_hz(struct
>> socfpga_clk_plat *plat, u32 emac_id)
>>   	/* Get EMAC clock source */
>>   	ctl = CM_REG_READL(plat, CLKMGR_PERPLL_EMACCTL);
>>   	if (emac_id == AGILEX_EMAC0_CLK)
>> -		ctl = (ctl >>
>> CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_OFFSET) &
>> -		       CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_MASK;
>> +		ctl = (ctl &
>> CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_MASK) >>
>> +		       CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_OFFSET;
>>   	else if (emac_id == AGILEX_EMAC1_CLK)
> 
> Using FIELD_GET()
> 
> [...]
> 
Noted, will make the change.

Kind Regards
Naresh

