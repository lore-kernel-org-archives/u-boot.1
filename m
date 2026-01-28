Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3BEAD35688
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 07:49:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F169F8423D;
	Wed, 28 Jan 2026 08:49:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="iaG/vpK3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE5928425A; Wed, 28 Jan 2026 08:49:21 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28F818419D
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 08:49:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jeeucpQDDIJ0xDg0F9hhq8RxrDuSQPPCBtpwuPMXI+XufKr63zwmkVs+P2xBVnwenpI3Zsbq/dM44uCoHDGrIwGfQf5OxauxxCqz7W2VpoJSO1hIQApnELGSjUh6rXfJMs5l19aXjxIeV1gvBY+K5Gv2IMax1lsY0MQ2K6kBGvZFw3vVnJYAqdF79a7PtaykWxl6Qsjdl2LSwtYiXenp8eZ3H72OKlFuwS0GD2cBSLy6c8SnZUkdN9H0D4mrm8PNnmkpfUpAfFsdXtx45594Evs+rOdxmPN8ccWKW6H97KqIzFz83HLJYjYjyZGqNNy1mFREK1ivbe4tL+CP31bDWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4IR0ehLPUbuigvWY0tJvh7jT/exbBDd8lMhscJEsApI=;
 b=SVDYZKzWTFweEExT3kdoC7ZeNP2baNjVpV1+CLhByX2kfYifpdnrwkcb5VENHUnMLFY+nrBpXaCm6/xDtUvzALWxOgG1BvuY5SGy+MRQih1EYl9O+iX/r/nF9/9bajMyw1oG+NjEOTucI7e8zP9HbmFDF7fxPmEB/lNKY3/JP7SIY8SJ5hxy1jdarNdHvTfe5NlNvrKMrCNQ8Y9deih611Ytn3peYCX4XLh6hCJTXKfl6otsVPnx7VcKb3TNRvMNx7Cu9pQr5gUPTh1vUBhu0Z8rw6lx1uNTA44oyCxPTu3ABaBs5hF93oV/eE47o01aRe1/hVvovirK5HTcrjRQ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4IR0ehLPUbuigvWY0tJvh7jT/exbBDd8lMhscJEsApI=;
 b=iaG/vpK3Bk6o0XnU4PViA0c4ziBfPzzgtoeNx6I/HEkd5eMW1JSmtZcWxQHjJDGtCb/FluKwkhKfYXrZtRCgUpXa9HRdETs1rjMAEEnelgRx0RkmcwuSE0ziyBn9yiNmaiJnRmXEFPmG7hkiD5MauPTiWexIaWBOrCH7ACzwftkdAlYYbIuwwDSuswcdqltP1hvFevwG2RWmNE8W8/I6aJTXqItZdeTXSyhrhZsCBPr5zV6LKZUo1kj72Qu1BntvpMS7Y72wAugwmpgxqSCS7cOGoDWBjHezRN7e76gWoY8xLuRacqc0YRgJpNcK336NPXsfK1MkE2LEEgxcarSwbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by LV8PR03MB7374.namprd03.prod.outlook.com (2603:10b6:408:184::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 28 Jan
 2026 07:49:16 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9542.015; Wed, 28 Jan 2026
 07:49:16 +0000
Message-ID: <9cc56eb7-b396-4490-abe8-4e4ca673a25e@altera.com>
Date: Wed, 28 Jan 2026 15:49:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] Add CoreCourse socfpga Board AC501
To: Brian Sune <briansune@gmail.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>
References: <20260127144250.35915-1-briansune@gmail.com>
 <20260127144250.35915-2-briansune@gmail.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20260127144250.35915-2-briansune@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0195.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::17) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|LV8PR03MB7374:EE_
X-MS-Office365-Filtering-Correlation-Id: 22539526-aa79-4592-878f-08de5e41bc50
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zk9HZU4rb0FnNkc1L2lIak5DNWc1dDNpSkdJYStyck8zSG5zQ0FtVEVpTDhu?=
 =?utf-8?B?elRiTCs1V1lPTjZ6MjdCelQxM0pLMThhSUpMMFJjWnkwYTVTd1ZoNlZoM01x?=
 =?utf-8?B?QUl6QmxDOG9Tb1QyRzZxQXFFY29pYzI1TUxQZ2Vnazg4SFNNaTRKSm1YdURK?=
 =?utf-8?B?cktTTk83MkZEL1FibVg2VldiblBkOHhNUko1QU5kV2Zyd1EzbGZpT2FyTzJy?=
 =?utf-8?B?bS9XdXZhcG5XTG9SSms5MURQRkpUOVcyM0VuamtKZmVMNWsyajZzc1M4bHVQ?=
 =?utf-8?B?STlpSm41NWQxdjEzdXdVdndyblNsZVRjQzV1cFJzMldJUkFQbE1YWmtwSTMr?=
 =?utf-8?B?eU5zQjV3WTgyNEFtWkhPaGJ1c2FoTk12dXVDMjYwQlRVMVpUWlFWcVpnNllm?=
 =?utf-8?B?RzVtSVUwUUpacEozUi9BK3IzMEx3WDE5bWZZTjI3b2VscjQ2cnNRRmNsbUgr?=
 =?utf-8?B?QW5EYzlDQmhqcHRxdTZSa3o4bXlIM2ZlMTFWM0RGZ3cwbkFybFpVd25DZW9H?=
 =?utf-8?B?RzBoWEZ2RlR0QUFKMzU1SVVqcTY3UW54bXRmNlVLY25rbzlYQjFVc1dSSFYw?=
 =?utf-8?B?OUkvc3NzRFBBV2pPNjlEOTB2am95WjU2Y2pwbDJBU2t3MjBQbWU3ZzcvTXc1?=
 =?utf-8?B?NzhxdlNjaUZ4SDJZY0xsSHNmRlgzazBvamVrUWsrRy93SGhGdFY0NXpjRkcr?=
 =?utf-8?B?SDhJcGZPQ2hZeGxDUVB1ckJaSnBhcGJMVjJQL3VPbzFuTlBYdC9HN0xVWEQ5?=
 =?utf-8?B?cDV0TG9wM0hhTDBhMzFqTVMxbXhBSGxxTlFLMXc4aWkrallhQUdaMFd3YWtZ?=
 =?utf-8?B?THdKcXF3ZEt3dml1ZUMxRXVZOFZnMTUvSjI2NllKYVJDL0didi95dkZMZkN2?=
 =?utf-8?B?UXB4czk0MUR6ZEI3UjM5MTFPRGVJUTQyODcxazJoaU9tQ0ErWFIxWGZsek5G?=
 =?utf-8?B?QllLYUdqYks2alYyUVZGUkxtaUVCQWxPcThVMFYveDNPb1h6UjNZdTJUaE5D?=
 =?utf-8?B?eUpqN1JSUDdCNjN5U1lZOW5WOFJnNDc1UWcyem1ia1V3ZlJiaUxMUjRVTSth?=
 =?utf-8?B?YjBIZDdaR3B5WWI0VWkvZG5yUmZMN0RnRC9QZkpGb2x2Z2luWllsbSsrWGlH?=
 =?utf-8?B?RDJQRzBhZUZyZXZ5QmN6MEt1bnNFd3hGZ1BFZDd2b2RoMk1GR0NtYTRZaW1O?=
 =?utf-8?B?ZUUwUWV4OHdpdmdVelBFdlc2dGZaZ1JHN3plUmxRa0JXTDlvNHd1amt6a25I?=
 =?utf-8?B?VlE2OVdsbnpHQUJrSEVSTkdlS2RGYnZ5S2pWME1aVTcvYnZwNXBuMEFKTGND?=
 =?utf-8?B?TlpSMFlpWWpsN3BpQmVtUXFncUI3RGpKN1h3UDZqRTJKbjJDbGhtL3NXbFhr?=
 =?utf-8?B?Zlc0eHozbkhZaEFJY05QeGw2eXMxZElWM1RWeGtlVWJRK0d1OGlDWkRNRXpD?=
 =?utf-8?B?ZUJpemJMTUQ4ckFydFh4ang1eXphZDVDU0N6Qi90VjJjV2VZbnozTTlBZDhF?=
 =?utf-8?B?cjlrM0VPTjRUVmRhYXlvTVplakc5Y016SFd5MTJRTk40QUVSRlhkbDdLWGJZ?=
 =?utf-8?B?Q1lSbWVhYjRYdWJLRjVwZlJMTTBhejJ4MGkvdkNBYzZHYkVobTVlY080cjV5?=
 =?utf-8?B?cEVCSmlUaU9LWVJ1TGNMZE5Rd3kxNHovc1FsQ2NWRUQ5TGZlektQdXN0cjlC?=
 =?utf-8?B?SXNxaE1TMUJ2MGxqcVVKNk9rODh4bWRFVGUrNWxITUpWYmpPVkxXdnc3T2My?=
 =?utf-8?B?blJNcmIvakZXTTh1RGRXZ1V6VmR1dVFKSk1LbmxSOTJjY3NUYU5wNXBBekln?=
 =?utf-8?B?K1BTOExZenBCckxLUkhqMlByQnNjdUVnTmpoa3JqVGhmK3h0amh6RFEvQmdO?=
 =?utf-8?B?WVZ1WkFBdXo3SzIwMEhHOGNmcThNaVZnZ2RMR3R6c3pWTE16TmxzcGVRQXR2?=
 =?utf-8?B?WC9Vb1g1L2szaWFlNk5Yb1JTcEIzdVVzeEFmY00vcnFlODZOWjJqanZxdXJQ?=
 =?utf-8?B?SE5YV00wWDNUcFlqSDNCRDUxMG1xbGRKWGJ0NWtDTzVaaGRySkRzM0lEaldQ?=
 =?utf-8?Q?gdL2UD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWg2dC8ralNNR0NVV2pRb2l1dkE0cHFKWDJMM0JVTHM1K2dNSmcxYUhTK1h4?=
 =?utf-8?B?QmorN3hsYmJyQkZRZ0NMSHVTVi9WOWY4L1QzMHFiUkw0YTluUFRWYXlrMm4v?=
 =?utf-8?B?OW1DQXBJQ0RIZEVQaWcvNnZ3eWRRbWlCNlVvWjZwVmJMTTZKdnVJSmNKY2li?=
 =?utf-8?B?cjhMZ2dVdE83YjBvd29RUytNQmt5bndGK216VWJGaFJrUFZVbXZHY3RKU2ta?=
 =?utf-8?B?UzczMW1KVWhveE8zYzcxbzRFUndlSGJkZUFrUXQwZ1RlcmhxMXNJVi94d1By?=
 =?utf-8?B?dHhtNkZRVHZuM3ViS1dyYjRYeXBpMnJDSFI1U001RVArNkVkMDhuWVQ0Vis4?=
 =?utf-8?B?Wk5RZU0vSmg0VHNTTldzRFUzZ3l4SlJ0RlQ3dDFwQTdBT2c2cnN0NHlucTYx?=
 =?utf-8?B?b05VeVNTM0oxVWlmeWZ0VVVoZUcyeml2cVV1UTREZFNkTDhjcmFCbWpreCtE?=
 =?utf-8?B?VTZrZUhrS2t3S2V6M2VjT1RnaXFrQUQ4RVBRMkxOWHg5OWNVR0ljS1NyZ00y?=
 =?utf-8?B?TkZRVXJuK0VkbEFkalF5MVYvdVN1QjVPNXB3NHpOZGJZQitnM2hTZmNDQlJq?=
 =?utf-8?B?U0V3ZUxXZnczaTVNM0sxWkYyVnVEaU52eGVVY1E4MFF1d0tKK3dqSFJocmNG?=
 =?utf-8?B?WGIzUGkzczNQOTFUWXlrcTc3QnVENi9IUytPdTJnSE1oQlZJbVhtbWZhV1FC?=
 =?utf-8?B?MnpST2U3QXB6NG41S0ZseHozb01KM3JnaFV2UEdZSnRJOGcwdXdzV1FmZlJj?=
 =?utf-8?B?SXhYUFhqOXFqN0RpMThiUlFTSWNkQzFHd3FsWWJIWVdvN2doMmE2VEJMTjl5?=
 =?utf-8?B?MzlRbFhESzdpdVFaRVhYY3htdDVrdGM3NHdyT2J3V3FTVU82WXJtL09aTWV3?=
 =?utf-8?B?RGUzUDArMlIxWHkxV0gzdTFOMXBvZ0NmeVkyRjRuNFpPSGZqS21QYTR1b1RY?=
 =?utf-8?B?cDYrQkt2cTlQSTR3eXB4cytWTWVZclpJcFlUVDFiVEdtZFcyWXBOV24zYS9P?=
 =?utf-8?B?UThRUTduMlRYVWtqQ0JLQmNOSmJMMlM4SXNWY2xSc0JoaGVOcEV0enBPL1N5?=
 =?utf-8?B?MDZuQklWTTBYZlg5Z3Y5anp5bkJlbDMwM0RVK1RmYk5ldG5BSytFRnJybnVN?=
 =?utf-8?B?M2FQQjdlaGxtR0NaWVlwNG9mSXN6Y1I1Wi9PSWZmWVY1T0t0M2trRzROTUlY?=
 =?utf-8?B?ZXNuNno3MWJYU0IrR0IzSkkycnh1Tjd1K2orWVI3Qm11SXhiemJsdWQzdSs2?=
 =?utf-8?B?VFg1SENRM21obmUwVlBjTnF6akN5aUxzdUo4SEYwTDArYjJxMVR0cmJuVENt?=
 =?utf-8?B?MzlTOTNDRUdLTExaT1hGaDlYT1BpbXFKOUJxQndkWTBaRTJxYk9QQWlheDRh?=
 =?utf-8?B?NGNzNnc5S1R3OXQ2UlB1K2JMbjh0L1BHZ3Q1Vlp2RUdTWVhDRDVoY0NKdDQ3?=
 =?utf-8?B?MFM4YThmNmN5R09Rc2Y4dkhEa0lYejhxckp5VGc5VWIwc2hyVVljc3M2bGZw?=
 =?utf-8?B?bE5TaWk5RS9JeG9KZkYzcWc5b0RsM0dVaXVydkpSaW9LaDJGWmZsM1prNWFR?=
 =?utf-8?B?YU92TGVMZE5YZWVGekhGWS9zckE0cFZyM1c5cnNrdEc4Z1Q2Mm9jWnNBbE9T?=
 =?utf-8?B?ZEluenZSckphNjhYMm1jdE16QVZtZlVlTjRQd2p6NzlqODlWaFlGcTBsWmx5?=
 =?utf-8?B?M2N3dlBPa0k0dlN6dkNLU3RtOTNmQ0hIOGczOHlTVFV5TE5IYmRSTFVSOENH?=
 =?utf-8?B?eHZJRDVhSjA0VndIbHFyRjd3SE94KzhQZitIa21adFR5SWZVQU1ZWUNLRGhv?=
 =?utf-8?B?K2dqNUxRQ1FRVDJGYXVuMGs3M1ZlcFIrNVFSMmIwQ3o1Q2taQUxQdU5hYnYz?=
 =?utf-8?B?dDZpNXRmS1BNRVMrKzNNbnN0SVdFUGIrOGwvejlRZXZrNERLWDhIM0ovSlRo?=
 =?utf-8?B?L0FtZjlJRVlKaXc2enZ5YWRXYXRzeWtXUXFNL1JJWFdFWm5nd2VmakJ0T2hX?=
 =?utf-8?B?bE9vTGptWDJ6ZHRHaEcrclFiRGpKR2wxa0RxYTRGYUlZZEtnVjRKQUdTVkxm?=
 =?utf-8?B?RlJNNXJIbmtzSWRPZEJ6dThneTFFVU1lUTNuSm5US3JiVDcwSXJoSTdRZ1FZ?=
 =?utf-8?B?V2tzR0NPVjFFZTIrbDhub050ODlYRjFOUDdFMTJybCtUbVlnWFlVU09KUG5z?=
 =?utf-8?B?Qy9UNzM1S0RMamw3RkdWMk1zN3F2dzlVVDRiSVdYMm81WFVVbEVKdFIxblR6?=
 =?utf-8?B?bW1STHl6VytsandtemZjdzBEZDJtOVdlak1nYjN0TFJWVElWM3BSYUx3aE5t?=
 =?utf-8?B?a21UOTNTMUhxS3ZPMi9JcVM5QjJYa2RpcVd2UlZBL3dXdk1TVkdxYm5MMm4w?=
 =?utf-8?Q?/4Cc9QYCCVf6FLqs=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22539526-aa79-4592-878f-08de5e41bc50
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 07:49:15.9827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h+gCVrsNQDv6x972XIbcV8G/xkblkQx+/MBcj3E6eAizpn6iFkNb4c49E8i2hgObSgVIcvvoLy70EF41gCDmvjA4LoVMrHHW0ZT54W17IVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR03MB7374
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

Hi Brian,

On 27/1/2026 10:42 pm, Brian Sune wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>
> CoreCourse Altera GEN5 Cyclone V board
> do support different size and formfactor.
> Now introducing AC501 C5 to mainstream u-boot
> This is a UBGA-484 based board with basic
> feature. More info on [1]
>
> [1] https://corecourse.cn/forum.php?mod=viewthread&tid=27704&highlight=AC501
>
> Signed-off-by: Brian Sune <briansune@gmail.com>
> ---
>   arch/arm/dts/Makefile                         |   1 +
>   arch/arm/dts/socfpga_cyclone5_ac501soc.dts    |  85 +++
>   .../dts/socfpga_cyclone_ac501soc-u-boot.dtsi  |  44 ++
>   arch/arm/mach-socfpga/Kconfig                 |   7 +
>   board/corecourse/ac501soc/MAINTAINERS         |   6 +
>   board/corecourse/ac501soc/qts/iocsr_config.h  | 664 ++++++++++++++++++
>   board/corecourse/ac501soc/qts/pinmux_config.h | 222 ++++++
>   board/corecourse/ac501soc/qts/pll_config.h    |  86 +++
>   board/corecourse/ac501soc/qts/sdram_config.h  | 349 +++++++++
>   configs/socfpga_ac501soc_defconfig            |  85 +++
>   include/configs/socfpga_ac501soc.h            |  13 +
>   11 files changed, 1562 insertions(+)
>   create mode 100644 arch/arm/dts/socfpga_cyclone5_ac501soc.dts
>   create mode 100644 arch/arm/dts/socfpga_cyclone_ac501soc-u-boot.dtsi
>   create mode 100644 board/corecourse/ac501soc/MAINTAINERS
>   create mode 100644 board/corecourse/ac501soc/qts/iocsr_config.h
>   create mode 100644 board/corecourse/ac501soc/qts/pinmux_config.h
>   create mode 100644 board/corecourse/ac501soc/qts/pll_config.h
>   create mode 100644 board/corecourse/ac501soc/qts/sdram_config.h
>   create mode 100644 configs/socfpga_ac501soc_defconfig
>   create mode 100644 include/configs/socfpga_ac501soc.h
>
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 3cd762977cb..2210b44f9bf 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -469,6 +469,7 @@ dtb-$(CONFIG_ARCH_SOCFPGA) +=                               \
>          socfpga_cyclone5_socrates.dtb                   \
>          socfpga_cyclone5_sr1500.dtb                     \
>          socfpga_cyclone5_vining_fpga.dtb                \
> +       socfpga_cyclone5_ac501soc.dtb                   \
>          socfpga_n5x_socdk.dtb                           \
>          socfpga_stratix10_socdk.dtb
>
> diff --git a/arch/arm/dts/socfpga_cyclone5_ac501soc.dts b/arch/arm/dts/socfpga_cyclone5_ac501soc.dts
> new file mode 100644
> index 00000000000..0b32a574086
> --- /dev/null
> +++ b/arch/arm/dts/socfpga_cyclone5_ac501soc.dts
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2025, Brian Sune
> + *
> + * based on socfpga_cyclone5_socdk.dts
> + */
> +
> +#include "socfpga_cyclone5.dtsi"
> +
> +/ {
> +       model = "CoreCourse AC501SoC";
> +       compatible = "altr,socfpga-cyclone5", "altr,socfpga";
> +
> +       chosen {
> +               bootargs = "console=ttyS0,115200";
> +               stdout-path = "serial0:115200n8";
> +       };
> +
> +       aliases {
> +               ethernet0 = &gmac1;
> +               udc0 = &usb1;
> +       };
> +
> +       memory {
> +               name = "memory";
> +               device_type = "memory";
> +               reg = <0x0 0x40000000>; /* 1GB */
> +       };
> +};
> +
> +&gmac1 {
> +       status = "okay";
> +       phy-mode = "rgmii";
> +
> +       rxd0-skew-ps = <420>;
> +       rxd1-skew-ps = <420>;
> +       rxd2-skew-ps = <420>;
> +       rxd3-skew-ps = <420>;
> +       txen-skew-ps = <0>;
> +       txc-skew-ps = <1860>;
> +       rxdv-skew-ps = <420>;
> +       rxc-skew-ps = <1680>;
> +};
> +
> +&gpio0 {
> +       status = "okay";
> +};
> +
> +&gpio1 {
> +       status = "okay";
> +};
> +
> +&gpio2 {
> +       status = "okay";
> +};
> +
> +&porta {
> +       bank-name = "porta";
> +};
> +
> +&portb {
> +       bank-name = "portb";
> +};
> +
> +&portc {
> +       bank-name = "portc";
> +};
> +
> +&mmc0 {
> +       status = "okay";
> +       bootph-all;
> +};
> +
> +&usb1 {
> +       status = "okay";
> +};
> +
> +&uart0 {
> +       clock-frequency = <100000000>;
> +       bootph-all;
> +};
> +
> +&watchdog0 {
> +       status = "disabled";
> +};

Avoid duplicating nodes between the board DTS and the -u-boot.dtsi 
(e.g., porta/portb/portc, watchdog0, uart0).

Keep board-common settings (usable by Linux and U-Boot) in the DTS; 
U-Boot–specific bits belong in socfpga_cyclone_ac501soc-u-boot.dtsi.

bootph-all; is U-Boot-only and should be in the -u-boot.dtsi, not in the 
DTS.


Thanks.


Best regards,

Tien Fong

