Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8FEFCCD193
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 13:15:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 095C582E34;
	Mon, 20 Oct 2025 15:15:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=legrand.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=Legrand.com header.i=@Legrand.com header.b="khI+bns4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E93C831D6; Mon, 20 Oct 2025 10:30:53 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D70582C84
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 10:30:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=legrand.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ronald.wahl@legrand.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IB6jTBWZOYj1+orK+MpEPrS6/lz2i3mtxBNf6PAPiP8mD32wqazqk4tNO1OWk8uGPvMBapyKmqvHvrB2LqbBJoBYTCx4IqqpP2I3Cg2T0baBJy9I4iHAQONRt5jO8yFf1QvD0MZ2a9/TTvBIPRz/0qaYwomGCsIX4luu8MkjeynGp9F3tzDjdZ2bZIeNnPgfdu6fTNXKDSfKmVPqpiFYO0Eqw9EOqnlad2f6riB4cM1HxWS9mtgHu2bOOc9IaKVNiiIjIZjonc3IXPpQu6PHVh60Q5s5Zuge1bh4+iPXUFXmgYdjLoGKGqPZtSqahWTjXk5a80b1YA1q1U0VK8s7kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tp+3tt+Hg5AjwOIRUdZ4MC6BqQwXNnmg1uG13V2KJmM=;
 b=nI4uuMOOoy+UiRWepFL05UnHmTF4hWXww1FwKmvl1TiKFmv5bd2xLcd65KS/1cNV8Wer1xlBI9I+QiQWJKiPvsCFFbfFPk912cvS0NR+SO5kgaMAXz98B4BhcFWMhem1XzvQjC4qI4gORr2NYoR33mYGXEK5CY8gps9JAE4FQW1dmb0mgBYY1pSu68QQflfxakuHMkgoH8J1vpcQDPSbWDbdx1bK0WSjedfUdi0xUbMidCHMoLDuctvIFnDW2TXhASNTBAAbr7weCD7uGlePKj0v2tjMsn+AcnvFkLyVsKBgx6w04NecTdqKeTz/BRephtuw6dvWsObFIjBiLEX/Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=legrand.com; dmarc=pass action=none header.from=legrand.com;
 dkim=pass header.d=legrand.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Legrand.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tp+3tt+Hg5AjwOIRUdZ4MC6BqQwXNnmg1uG13V2KJmM=;
 b=khI+bns45FUr1x0NuF9AYnu7NOrBZGd+aEIEgGdRMBTUMJZsqgYgHJ64oKj95Q6PtNhvkZV56iS6uEEwYT5MNIASM8YejS8LaUtQQ1n7OSLAYlyXkYrX+Wmmbz2xYwTLt6pHwk/berZrZLV+j0ySMYUbJoYdIoJlN7gtBZZehpQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=legrand.com;
Received: from DUZPR06MB9057.eurprd06.prod.outlook.com (2603:10a6:10:4b2::18)
 by PAXPR06MB7566.eurprd06.prod.outlook.com (2603:10a6:102:152::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.14; Mon, 20 Oct
 2025 08:30:47 +0000
Received: from DUZPR06MB9057.eurprd06.prod.outlook.com
 ([fe80::7883:195d:c189:373b]) by DUZPR06MB9057.eurprd06.prod.outlook.com
 ([fe80::7883:195d:c189:373b%6]) with mapi id 15.20.9228.014; Mon, 20 Oct 2025
 08:30:47 +0000
Message-ID: <2b3d068d-4888-4594-a75e-6c2729bf28c4@legrand.com>
Date: Mon, 20 Oct 2025 10:30:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] spi: cadence-qspi: Remove cdns,is-dma property handling
To: Michal Simek <michal.simek@amd.com>, E Shattow <e@freeshell.de>,
 u-boot@lists.denx.de, git@amd.com
Cc: Boon Khai Ng <boon.khai.ng@altera.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Naman Trivedi <naman.trivedimanojbhai@amd.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Prasanth Babu Mantena <p-mantena@ti.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <6205c6585589b423692b6ed063506b4c51c04c77.1760006086.git.michal.simek@amd.com>
 <3949b231-b62f-4fac-a078-bd066940420f@freeshell.de>
 <b21e8dc3-7ec7-4fcd-a0ef-1d214fc8a1e9@legrand.com>
 <d710f2d3-4044-4a64-a85a-2650b3ca6238@amd.com>
Content-Language: en-US
From: Ronald Wahl <ronald.wahl@legrand.com>
In-Reply-To: <d710f2d3-4044-4a64-a85a-2650b3ca6238@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::16) To DUZPR06MB9057.eurprd06.prod.outlook.com
 (2603:10a6:10:4b2::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DUZPR06MB9057:EE_|PAXPR06MB7566:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d0940a6-6ca0-4cfe-0dca-08de0fb2f7f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y2o1bmdQV21TVjhNK2ZsancyaURiVm1lVFRqaitsd3IvZE54bkttOGg2MFpu?=
 =?utf-8?B?NDBDM0k1ekRBb2RKRlBQS3llTVlwWmRmK013YjRpcWx5aEFtTkx6dG1vK2tz?=
 =?utf-8?B?aTV1ajRhUlE1SlJWUjdwRDF2TEExaUhZSmxPamJienFLYTdzOFJ4aU5Ed3E1?=
 =?utf-8?B?Tk5lbmpyNnNMU1E5dXVUTzZZZFNyQkVZZnJVeC9hYnNIMUtQOFhlMFBrZHNn?=
 =?utf-8?B?QWRMZE9ZZEZjZTZWcjlHWHFDd0x5TVhQazJjdU9zOTY0VTRlV2cwOTFiQXRa?=
 =?utf-8?B?RFhEWkdDUUgvK3FXT1lBWlNheW1SamhXKytVMDRJQytWcW84Zk1aaXU1OFdX?=
 =?utf-8?B?QllRVkxDQmpyek5LUUJ2WUJFMENrY1ZnaVVOcEQzV1AvQlZHTjdUQ2RIcytn?=
 =?utf-8?B?QU9hWTFtWVFVaTRSUzg0dXJtc0pSdnBjNS96L1RRSG45WnptWUJZMk05eWRQ?=
 =?utf-8?B?VXlNN09kTHVzby9XUU1OSFJKU29mSENtLy9Da3VqYkVNamJiaFRuRDE2UVBZ?=
 =?utf-8?B?Smt5c1p5M1Y3c2VGVE4ydmQ0YjJCRnRBeUtDb29aUGZxeEt5VWFlMmdCWXlH?=
 =?utf-8?B?N2Ruck5jTzZaL01NcGJFRVR1WjQ2aklzMEsvM3hlNW5hd3YvZGwxcXZiQ2Q3?=
 =?utf-8?B?eFdzYnlzclRpVUk1LzhZVnphTjRMOFAvakkyRTl4elRqNVBUWGRTcDg5Z1kx?=
 =?utf-8?B?TkZGbW1tNlc0VXI3NUxxdlVnVXZuTk9DNlpkc04rb01qeCtZbEd4UzNIT0xq?=
 =?utf-8?B?elhBdE9KVGZBdDBWTHEwdFFZNWFjaStVUmJzNDR4WFpWWGN1c2EwSGNBVndK?=
 =?utf-8?B?eFZ4U2xEd1lpQUlSL0RDZW9TLy9EZk5aNzk4YXV4NG5lQytVdEc2c2gyUjVD?=
 =?utf-8?B?WUJjSC9OSHlzM3FMbWZ4TittMlJCOERWVUpGSnBYcHZ6LzM5d1BUQ0p6WlZv?=
 =?utf-8?B?UzZMNVV2L2xaTHlaRFNJT0x0R01HdFl5UlNyVEJUSHk3R0dNSHBJOC9lb2Q0?=
 =?utf-8?B?dERJc0xURmJXUVFXcnA3VE1Td3VLanJuWEJ2TytpcVd3M3QxeVd6Q0d4ZGNl?=
 =?utf-8?B?Y04reFNYcnFFVTJPdUpINDRGaWxsbi8ybS9FYUsxVWFRbHQ5TENuN1o5OTEv?=
 =?utf-8?B?bXFBdDhnSVUvcXloZmNkc1pRMVg0VnpQY3NRb2h1dmRCeWlVczFsYUlvYk5y?=
 =?utf-8?B?SmZXV3BLbzU0cGxMRk9WeTJHdXZjNTJUZWNINGJNWk5lUldWTlFoWGo3ckMw?=
 =?utf-8?B?U2Fwcm85VTkvUnRKcUsvRkEyME0wNHY4NjJhWm5Lek5BVDhsT2owajNhU3B0?=
 =?utf-8?B?em5TRDdScW94TGhoeFRuODIvZ3N4SVF4bmxEbThNdVF5cDZyemhvN3FPbWVN?=
 =?utf-8?B?aXVrM3JZcEFJTDdqdmVYV0RWWWt5YTNwS2RCUVJMYnppeldkRFcwcVd1dkdz?=
 =?utf-8?B?Z0pIQ01CUHBCaDBodVdBdzNmYURTV0tkYzJUR24wYXNlbHRCcVE0U2FtN0Fi?=
 =?utf-8?B?RmFFVUZ6V1Z0dkJSMXpxbmJqQmVMMVAzbGU1eGg2SXIyMW05SWJEcEdGaVcw?=
 =?utf-8?B?aEJyOW5tWHA1L0taZ21XeC92K2xTSTF4NnpUZkJIZ3VWZ1hzZzZTUzFLUC8r?=
 =?utf-8?B?Q20rNVJXOG1MOVYvZ1ovVVpXNkphWmZCa3BCQWdLQjNuQyswTW5wd1dZcDA3?=
 =?utf-8?B?dEQyTXVPYTQwMlg5bTNKSmVNalk4ejQ1b0c5UDNnMlEwM2dJVWJtVFp3Zi93?=
 =?utf-8?B?aWdYd2JnYityanFRV3luMjFYTnpwZ1ZWc3NBNnhaaU5GWTA1SU9rWjJOTmJE?=
 =?utf-8?B?MDl3MzJNejRraTJDNnU2MW9LajYyZ3NiZHRibE1vY3IzUUVmOVZkd0p4Qk9X?=
 =?utf-8?B?dFhCYXpvb1hNNXd2WVl6OUhkWG90VCtxeW1DQjFoQ3gwdEE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DUZPR06MB9057.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1NXV1ZRaEtwZ003R0hvTk9OdkxSR2VxcXFkMEN2TmI4QndGeDYrVkpCdzky?=
 =?utf-8?B?VVZ3WU1Wem9Fa2ZWTVF2ZzJmZi91NTJzY2NobmQxOG5xUk5NNFQzeEQ2YVdr?=
 =?utf-8?B?ZFE0UFhxRXJFenp0VTZqdDg0emlaNjF4T2MwQS8ydWJrdWNRaXJMY2FPMTh3?=
 =?utf-8?B?bDZPS25HRXJhbjFIdmxvYjRUZnVLd0dLZFlBRUZFUUN5dEFBNjVSZ1ZCREM5?=
 =?utf-8?B?K3l5c0lzb1dMcWdvaXBqTzdyQU9Fb1o0QnVqdXZtNFNqZWtLQmZZQjhuWWxo?=
 =?utf-8?B?M1ZyV1d4V2RhZHNlNUcrUUhYK1YxV1VhSzhxTk8rckNzRkdvQlZQVHFLUGdI?=
 =?utf-8?B?WnBxdjRpdC9qdVM5Rzh3WjJ4bHBnRVRXSVFNalBuQVNZMC9BSkNyZVlLQXgr?=
 =?utf-8?B?Z3BCa1BmN3E4VERlVk1XbWFZVEY4RUQydW1RRCthN2p5S3pWR0o0OWRnRWlw?=
 =?utf-8?B?VHNNQmhLL09BQUpFeER0YXdCcEJMdldHYzlQSG5uS3B1REd4eHNQejllQ3ph?=
 =?utf-8?B?M1YraHR0alhmd054NW9yajhDY2FuNVkvYk5qQWxQb01LYmNCbUJvYlJib0w0?=
 =?utf-8?B?cWR5eVlRTjl6L0Y5Y0R4a1R5Mms2SVJpenZFdm5US1RVc2tsdWtXZ3Y2emVa?=
 =?utf-8?B?VWx0WllwekVJazBWSEVMd0NUazl0U0xyYlN1ajhZaU5zYlpwZmdURFpRN2VQ?=
 =?utf-8?B?VGs5Qm9haGR1RzJ2OHN6WlNpMWpzcjI1MkFmSEVhOHFjbjRwSkJGdkFCSTAv?=
 =?utf-8?B?QTF6WGx3VlJCVFI1UUYwaElQdjNQcDIyM2xvM2ZNTFR1aC9zYklxWWJMazlU?=
 =?utf-8?B?YWFNOGppR2tzSGRoejJyc3VEUWxOQ1IxMUxTZXY4K25JUFJseGlMOGxDd0px?=
 =?utf-8?B?L1hVN2Y3b0drN1RtZFJHS2hTaWorc3MrcUtCUVpia3grR0EyTHRxUElwZ2NB?=
 =?utf-8?B?d085bHNPQjhObXEwdXVqRUptSE80N250ZmZLUlg1VnRGeUhRVGxnUjJNdWtQ?=
 =?utf-8?B?bHBzenFQS2tzU3N3WnJ2QVIwVGVDekloRTNCcHM4RVhHNUVuZ0U2NmU1ZFVa?=
 =?utf-8?B?dnBTdnlLVVF3Z0xNelVkdEFlVWF4VWN2aW5uRnkzeTI2T3hVNjJMUThVZmhn?=
 =?utf-8?B?Z3ZsTzc0QTZtUWYxZm91UE9nWEVPcTUxQnFSYW5Ldml3MzkvWm1sL3NvNS82?=
 =?utf-8?B?ZjlzTXNZN25VVUNxenE2WHRBWndzSWh1UGk1UXZ5bGc4cUVaNDM4Q1cyRFRN?=
 =?utf-8?B?VG0zYkswTzR1S1JVamZoVVV6TWUyOFZjMER2bXFDcmludnBUTHowWG5oVFpT?=
 =?utf-8?B?RVdlS21wNWI1ZjVVQmo4bjVQNll0YUY3SDExT2VaQmczcVFiZHkzdE9KT1E4?=
 =?utf-8?B?N1VXSC9RSmNoQzlMOE1ZTUpPbXRndFJ4L2Vma2VJcFNWdHdrNkNxWlIyanBT?=
 =?utf-8?B?eVBqZW53bTlJUDcrL0VPWW01akN6REVFWTdQdjlRRTIvOTcxM2ZFUmMwdzVX?=
 =?utf-8?B?WjNhUFdtMFNnUVdzQzlpdVQxeVREN2RLd1h6ZFFjWC9KUlpwVHpvOVNiZWFq?=
 =?utf-8?B?eFlMZFU4Q1dWd1JjWkNvaWk0dWJna0pydGhaUkkwQTRvSDArWWdLWGdaWSt4?=
 =?utf-8?B?VXg3d294ZnZmZVB0K1JmZzBJWGtqeVAzcmtwdHRsZW9Vem5zaXJmSnhFUTJr?=
 =?utf-8?B?QStIUE5LVDV5bEZRNTNlVlJpQURtNEFFYmNUQTVkWnU4clQ3V2kraHR6T042?=
 =?utf-8?B?NEtUQjhZWnJBZ21MSEhLWnpTbC9JaGRrUGdMaUxNbFRxTlh3bER5QlN3Tnh0?=
 =?utf-8?B?enVvajloWEVPaVZOeEQyaXR5OVhGV2Q1NXF5SHJBWnl0OStoMHVycFc1WTJI?=
 =?utf-8?B?SEJoQ1pjU25YMjM0bFY3WU5XYSsyRXk4dWpHT3pEOFR6MkRLU2cvbDlIK3gr?=
 =?utf-8?B?eWJQMEFZK0RPSm5XRFJYWElNVGNrVTByaEkySEVjSWhKZTY3VnJyS0FmQmhn?=
 =?utf-8?B?ck5LSmtOaExZN2kwbExkYlBVZTVjSzNKZkpOWlN6S3FobW01cFBYNG91RHVo?=
 =?utf-8?B?NWxpM3NIVEFzREJSMjM3SGI5Y1QyNnVpWnh3aFY2WGI2ODUwQ2ZkUTRNVnh3?=
 =?utf-8?B?c0FFMGh1ZGlOT2NIVVhETkhCcUxEVDYwV0F6YXZobERVV3Focmdsa1Q4TWwv?=
 =?utf-8?B?SFE9PQ==?=
X-OriginatorOrg: Legrand.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d0940a6-6ca0-4cfe-0dca-08de0fb2f7f8
X-MS-Exchange-CrossTenant-AuthSource: DUZPR06MB9057.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 08:30:47.5010 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 199686b5-bef4-4960-8786-7a6b1888fee3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kU99VpTndKm0+bBEJ4GRDwMzOgJv+h9EmYlWI4Bm6A0dERZim7POYQoCHSUNuHJ3IIlnBFHLnRCfz6Ae/lKpJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7566
X-Mailman-Approved-At: Mon, 20 Oct 2025 15:15:13 +0200
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

On 20.10.25 07:51, Michal Simek wrote:
> [You don't often get email from michal.simek@amd.com. Learn why this is
> important at https://aka.ms/LearnAboutSenderIdentification ]
> On 10/20/25 00:36, Ronald Wahl wrote:
>> On 20.10.25 00:03, E Shattow wrote:
>>> On 10/9/25 03:34, Michal Simek wrote:
>>>> Remove cdns,is-dma DT property handling. Property is not the part of D=
T
>>>> binding and it is also hardcoded to value 1 in all DTs that's why
>>>> remove it
>>>> because none is also testing value 0.
>>>> If there is any use case when this configuration should be supported
>>>> this
>>>> patch can be reverted.
>>>>
>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>> ---
>>>>
>>>> Changes in v2:
>>>> - Remove other functions which are reported as unused by gitlab CI.
>>>>
>>>> v1: https://eur01.safelinks.protection.outlook.com/?
>>>> url=3Dhttps%3A%2F%2Flore.kernel.org%2Fr%2F&data=3D05%7C02%7Cronald.wah=
l%40legrand.com%7Cedf1107fa8c143a9738c08de0f9cc246%7C199686b5bef4496087867a=
6b1888fee3%7C0%7C0%7C638965363122564250%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1=
hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ=
%3D%3D%7C0%7C%7C%7C&sdata=3DwloMzuMKR6AGQHJ%2FMurQdgiZrPsQkHvsewR5%2F48TsZM=
%3D&reserved=3D0
>>>> c6a5b4bfe565668eb3299d5c5a5548a2163b129a.1758786568.git.michal.simek@a=
md.com>>> ---
>>>>   arch/arm/dts/versal-mini-ospi.dtsi     |=C2=A0=C2=A0 1 -
>>>>   arch/arm/dts/versal-net-mini-ospi.dtsi |=C2=A0=C2=A0 1 -
>>>>   drivers/spi/cadence_qspi.c             |=C2=A0=C2=A0 8 +-
>>>>   drivers/spi/cadence_qspi.h             |=C2=A0=C2=A0 5 --
>>>>   drivers/spi/cadence_qspi_apb.c         | 119
>>>> -------------------------
>>>>   5 files changed, 1 insertion(+), 133 deletions(-)
>>>>
>>>> diff --git a/arch/arm/dts/versal-mini-ospi.dtsi b/arch/arm/dts/
>>>> versal-mini-
>>>> ospi.dtsi
>>>> index eec2a08e7c70..6991f6a51db0 100644
>>>> --- a/arch/arm/dts/versal-mini-ospi.dtsi
>>>> +++ b/arch/arm/dts/versal-mini-ospi.dtsi
>>>> @@ -38,7 +38,6 @@
>>>>                num-cs =3D <1>;
>>>>                cdns,fifo-depth =3D <256>;
>>>>                cdns,fifo-width =3D <4>;
>>>> -             cdns,is-dma =3D <1>;
>>>>                cdns,trigger-address =3D <0xc0000000>;
>>>>                #address-cells =3D <1>;
>>>>                #size-cells =3D <0>;
>>>> diff --git a/arch/arm/dts/versal-net-mini-ospi.dtsi b/arch/arm/dts/
>>>> versal-
>>>> net-mini-ospi.dtsi
>>>> index 1c94b352dc97..d2d5ec8e5cbf 100644
>>>> --- a/arch/arm/dts/versal-net-mini-ospi.dtsi
>>>> +++ b/arch/arm/dts/versal-net-mini-ospi.dtsi
>>>> @@ -52,7 +52,6 @@
>>>>                num-cs =3D <1>;
>>>>                cdns,fifo-depth =3D <256>;
>>>>                cdns,fifo-width =3D <4>;
>>>> -             cdns,is-dma =3D <1>;
>>>>                cdns,is-stig-pgm =3D <1>;
>>>>                cdns,trigger-address =3D <0xc0000000>;
>>>>                #address-cells =3D <1>;
>>>> diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
>>>> index 599596f9f087..849bd930edf0 100644
>>>> --- a/drivers/spi/cadence_qspi.c
>>>> +++ b/drivers/spi/cadence_qspi.c
>>>> @@ -210,7 +210,6 @@ static int cadence_spi_probe(struct udevice *bus)
>>>>
>>>>        priv->regbase           =3D plat->regbase;
>>>>        priv->ahbbase           =3D plat->ahbbase;
>>>> -     priv->is_dma            =3D plat->is_dma;
>>>>        priv->is_decoded_cs     =3D plat->is_decoded_cs;
>>>>        priv->fifo_depth        =3D plat->fifo_depth;
>>>>        priv->fifo_width        =3D plat->fifo_width;
>>>> @@ -348,10 +347,7 @@ static int cadence_spi_mem_exec_op(struct
>>>> spi_slave *spi,
>>>>        case CQSPI_READ:
>>>>                err =3D cadence_qspi_apb_read_setup(priv, op);
>>>>                if (!err) {
>>>> -                     if (priv->is_dma)
>>>> -                             err =3D cadence_qspi_apb_dma_read(priv,
>>>> op);
>>>> -                     else
>>>> -                             err =3D
>>>> cadence_qspi_apb_read_execute(priv, op);
>>>> +                     err =3D cadence_qspi_apb_dma_read(priv, op);
>>>>                }
>>>>                break;
>>>>        case CQSPI_WRITE:
>>>> @@ -412,8 +408,6 @@ static int cadence_spi_of_to_plat(struct udevice
>>>> *bus)
>>>>        if (plat->ahbsize >=3D SZ_8M)
>>>>                priv->use_dac_mode =3D true;
>>>>
>>>> -     plat->is_dma =3D dev_read_bool(bus, "cdns,is-dma");
>>>> -
>>>>        /* All other parameters are embedded in the child node */
>>>>        subnode =3D cadence_qspi_get_subnode(bus);
>>>>        if (!ofnode_valid(subnode)) {
>>>> diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
>>>> index 879e7f8dbfb8..10c4ad14cc05 100644
>>>> --- a/drivers/spi/cadence_qspi.h
>>>> +++ b/drivers/spi/cadence_qspi.h
>>>> @@ -223,8 +223,6 @@ struct cadence_spi_plat {
>>>>        u32             tchsh_ns;
>>>>        u32             tslch_ns;
>>>>        u32             quirks;
>>>> -
>>>> -     bool            is_dma;
>>>>   };
>>>>
>>>>   struct cadence_spi_priv {
>>>> @@ -261,7 +259,6 @@ struct cadence_spi_priv {
>>>>        bool            ddr_init;
>>>>        bool            is_decoded_cs;
>>>>        bool            use_dac_mode;
>>>> -     bool            is_dma;
>>>>
>>>>        /* Transaction protocol parameters. */
>>>>        u8              inst_width;
>>>> @@ -292,8 +289,6 @@ int cadence_qspi_apb_command_write(struct
>>>> cadence_spi_priv *priv,
>>>>
>>>>   int cadence_qspi_apb_read_setup(struct cadence_spi_priv *priv,
>>>>                                const struct spi_mem_op *op);
>>>> -int cadence_qspi_apb_read_execute(struct cadence_spi_priv *priv,
>>>> -                               const struct spi_mem_op *op);
>>>>   int cadence_qspi_apb_write_setup(struct cadence_spi_priv *priv,
>>>>                                 const struct spi_mem_op *op);
>>>>   int cadence_qspi_apb_write_execute(struct cadence_spi_priv *priv,
>>>> diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/
>>>> cadence_qspi_apb.c
>>>> index 4696c09f754b..58be017720bc 100644
>>>> --- a/drivers/spi/cadence_qspi_apb.c
>>>> +++ b/drivers/spi/cadence_qspi_apb.c
>>>> @@ -667,125 +667,6 @@ int cadence_qspi_apb_read_setup(struct
>>>> cadence_spi_priv
>>>> *priv,
>>>>        return 0;
>>>>   }
>>>>
>>>> -static u32 cadence_qspi_get_rd_sram_level(struct cadence_spi_priv
>>>> *priv)
>>>> -{
>>>> -     u32 reg =3D readl(priv->regbase + CQSPI_REG_SDRAMLEVEL);
>>>> -     reg >>=3D CQSPI_REG_SDRAMLEVEL_RD_LSB;
>>>> -     return reg & CQSPI_REG_SDRAMLEVEL_RD_MASK;
>>>> -}
>>>> -
>>>> -static int cadence_qspi_wait_for_data(struct cadence_spi_priv *priv)
>>>> -{
>>>> -     unsigned int timeout =3D 10000;
>>>> -     u32 reg;
>>>> -
>>>> -     while (timeout--) {
>>>> -             reg =3D cadence_qspi_get_rd_sram_level(priv);
>>>> -             if (reg)
>>>> -                     return reg;
>>>> -             udelay(1);
>>>> -     }
>>>> -
>>>> -     return -ETIMEDOUT;
>>>> -}
>>>> -
>>>> -static int
>>>> -cadence_qspi_apb_indirect_read_execute(struct cadence_spi_priv *priv,
>>>> -                                    unsigned int n_rx, u8 *rxbuf)
>>>> -{
>>>> -     unsigned int remaining =3D n_rx;
>>>> -     unsigned int bytes_to_read =3D 0;
>>>> -     int ret;
>>>> -
>>>> -     writel(n_rx, priv->regbase + CQSPI_REG_INDIRECTRDBYTES);
>>>> -
>>>> -     /* Start the indirect read transfer */
>>>> -     writel(CQSPI_REG_INDIRECTRD_START,
>>>> -            priv->regbase + CQSPI_REG_INDIRECTRD);
>>>> -
>>>> -     while (remaining > 0) {
>>>> -             ret =3D cadence_qspi_wait_for_data(priv);
>>>> -             if (ret < 0) {
>>>> -                     printf("Indirect write timed out (%i)\n", ret);
>>>> -                     goto failrd;
>>>> -             }
>>>> -
>>>> -             bytes_to_read =3D ret;
>>>> -
>>>> -             while (bytes_to_read !=3D 0) {
>>>> -                     bytes_to_read *=3D priv->fifo_width;
>>>> -                     bytes_to_read =3D bytes_to_read > remaining ?
>>>> -                                     remaining : bytes_to_read;
>>>> -                     /*
>>>> -                      * Handle non-4-byte aligned access to avoid
>>>> -                      * data abort.
>>>> -                      */
>>>> -                     if (((uintptr_t)rxbuf % 4) || (bytes_to_read %
>>>> 4))
>>>> -                             readsb(priv->ahbbase, rxbuf,
>>>> bytes_to_read);
>>>> -                     else
>>>> -                             readsl(priv->ahbbase, rxbuf,
>>>> -                                    bytes_to_read >> 2);
>>>> -                     rxbuf +=3D bytes_to_read;
>>>> -                     remaining -=3D bytes_to_read;
>>>> -                     bytes_to_read =3D
>>>> cadence_qspi_get_rd_sram_level(priv);
>>>> -             }
>>>> -     }
>>>> -
>>>> -     /* Check indirect done status */
>>>> -     ret =3D wait_for_bit_le32(priv->regbase + CQSPI_REG_INDIRECTRD,
>>>> -                             CQSPI_REG_INDIRECTRD_DONE, 1, 10, 0);
>>>> -     if (ret) {
>>>> -             printf("Indirect read completion error (%i)\n", ret);
>>>> -             goto failrd;
>>>> -     }
>>>> -
>>>> -     /* Clear indirect completion status */
>>>> -     writel(CQSPI_REG_INDIRECTRD_DONE,
>>>> -            priv->regbase + CQSPI_REG_INDIRECTRD);
>>>> -
>>>> -     /* Check indirect done status */
>>>> -     ret =3D wait_for_bit_le32(priv->regbase + CQSPI_REG_INDIRECTRD,
>>>> -                             CQSPI_REG_INDIRECTRD_DONE, 0, 10, 0);
>>>> -     if (ret) {
>>>> -             printf("Indirect read clear completion error (%i)\n",
>>>> ret);
>>>> -             goto failrd;
>>>> -     }
>>>> -
>>>> -     /* Wait til QSPI is idle */
>>>> -     if (!cadence_qspi_wait_idle(priv->regbase))
>>>> -             return -EIO;
>>>> -
>>>> -     return 0;
>>>> -
>>>> -failrd:
>>>> -     /* Cancel the indirect read */
>>>> -     writel(CQSPI_REG_INDIRECTRD_CANCEL,
>>>> -            priv->regbase + CQSPI_REG_INDIRECTRD);
>>>> -     return ret;
>>>> -}
>>>> -
>>>> -int cadence_qspi_apb_read_execute(struct cadence_spi_priv *priv,
>>>> -                               const struct spi_mem_op *op)
>>>> -{
>>>> -     u64 from =3D op->addr.val;
>>>> -     void *buf =3D op->data.buf.in;
>>>> -     size_t len =3D op->data.nbytes;
>>>> -
>>>> -     cadence_qspi_apb_enable_linear_mode(true);
>>>> -
>>>> -     if (priv->use_dac_mode && (from + len < priv->ahbsize)) {
>>>> -             if (len < 256 ||
>>>> -                 dma_memcpy(buf, priv->ahbbase + from, len) < 0) {
>>>> -                     memcpy_fromio(buf, priv->ahbbase + from, len);
>>>> -             }
>>>> -             if (!cadence_qspi_wait_idle(priv->regbase))
>>>> -                     return -EIO;
>>>> -             return 0;
>>>> -     }
>>>> -
>>>> -     return cadence_qspi_apb_indirect_read_execute(priv, len, buf);
>>>> -}
>>>> -
>>>>   /* Opcode + Address (3/4 bytes) */
>>>>   int cadence_qspi_apb_write_setup(struct cadence_spi_priv *priv,
>>>>                                 const struct spi_mem_op *op)
>>>
>>> Your patch results in corrupted SPI NOR flash writing from U-Boot on
>>> starfive_visionfive2_defconfig target board Pine64 Star64:
>>>
>>> a040578d8270ed8788d7663808ea63ce5ffd7840 is the first bad commit
>>> commit a040578d8270ed8788d7663808ea63ce5ffd7840
>>> Author: Michal Simek <michal.simek@amd.com>
>>> Date:   Thu Oct 9 12:34:48 2025 +0200
>>>
>>>      spi: cadence-qspi: Remove cdns,is-dma property handling
>>>
>>> Steps to reproduce with Star64:
>>>
>>> 1). Set JH-7110 SoC RGPIO configured for UART BootROM loader mode
>>> 2). Power on and Transfer U-Boot SPL by XMODEM as prompted by BootROM
>>> 3). Transfer U-Boot main by YMODEM from U-Boot SPL prompt
>>> 4). Having `(cd $HOME/build/u-boot && python3 -m http.server 6789)` or
>>> similar for serving U-Boot SPL and U-Boot Main to save some time with
>>> UART transfer:
>>> 4a). wget $loadaddr http://host:6789/spl/u-boot-spl.bin.normal.out && s=
f
>>> update $loadaddr 0 $filesize
>>> 4b). wget $loadaddr http://host:6789/u-boot.itb && sf update $loadaddr
>>> 100000 $filesize
>>>
>>> Repeat steps 4a and 4b, note that each time all bytes are written and n=
o
>>> bytes are skipped. Written data is wrong and device unsuccessfully boot=
s
>>> in SPI NOR flash BootROM loader configuration showing wrong information
>>> to output.
>>>
>>> Please follow up with your analysis of why these changes have this
>>> effect.
>>
>> I guess this is because the committer didn't take into account that when
>> a DT did not mention the property then it is 0 (false).
>>
>> I assume TI K3 hardware is affected as well. So I think the patch must
>> be reverted.
>
> Are you using cadence-qspi in non DMA mode? DT property shouldn't be
> introduced
> in the first place that's why it was removed.

cadence_qspi_apb_dma_read is only implemented for versal HW and otherwise
a NOP. This does not mean that DMA is not used on non-versal HW, it is just
implemented differently.

- ron

________________________________

Ce message, ainsi que tous les fichiers joints =C3=A0 ce message, peuvent c=
ontenir des informations sensibles et/ ou confidentielles ne devant pas =C3=
=AAtre divulgu=C3=A9es. Si vous n'=C3=AAtes pas le destinataire de ce messa=
ge (ou que vous recevez ce message par erreur), nous vous remercions de le =
notifier imm=C3=A9diatement =C3=A0 son exp=C3=A9diteur, et de d=C3=A9truire=
 ce message. Toute copie, divulgation, modification, utilisation ou diffusi=
on, non autoris=C3=A9e, directe ou indirecte, de tout ou partie de ce messa=
ge, est strictement interdite.


This e-mail, and any document attached hereby, may contain confidential and=
/or privileged information. If you are not the intended recipient (or have =
received this e-mail in error) please notify the sender immediately and des=
troy this e-mail. Any unauthorized, direct or indirect, copying, disclosure=
, distribution or other use of the material or parts thereof is strictly fo=
rbidden.
