Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA582C369D3
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 09:03:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AD68809D4;
	Wed, 23 Apr 2025 11:03:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="fXOOwPhQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A2DA80F9C; Wed, 23 Apr 2025 11:03:23 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E09F800D7
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 11:03:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YYWDBIyZL24wLTenY4qjynHOOHS5laTzW5tqFCiXr74nK6mxp+MadCTQHRrlfo25hFYKZaL4iqqBBJFk/zBl0PVjEwWKOGOO3Vl+7LhPDbSwJHORVNOrcRSev1Mz5pNfCA/pnYNaoWYIeMN3mP1wQktHTZHKkxrd8Cuy5dEV8ALCqD/GCTZCmny99EO0IUdpAPpRaOwK52DVRR4vTJbZOPktcVXh517rSIOoSMi0RAIxuE0Eg29OE4HLUdcfT7S7wlxxLKRKrxgu7zZaWtr8pDR5UV6agGYNrshtNf8VahoxbQbbjOL/pmeEeJCHb2oPHWQ1y8DXMru5wSGHklgFBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUefZPLTtFxtRYWTpedYInBm6qgGH14NHUSKpAMiKCs=;
 b=w4gRt761m8P53LEpY8i2/PFq0UnRe69hhw9TmpbTrSscaldckOE4Q2FP2hRYUNqGIm9FnZM1oNxuCt3j3QYLUJlIOhUYImVvzu0pSbG7FZBQ660oxsbS4BPHtQrUYapL5bH9jNlIGL16ceLTTcvRfMbPizbuUBJTDOOgx9AhJx8DdYM/T9MD2vYV+YmRPNPhEFepvLjfP0DL5jTAnIKMLw19O7xJ5lf/SjiYC01UicLzivcEQEKW/s+oxR6DzX19tfA5I8SIK8l+4X6YM0N58FFQXzbyT2zpNlwuRCnCj69vAxWlyr3qnKSfOKo/KpgpCX7k8dtRjfgXFnD+z3Mu6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUefZPLTtFxtRYWTpedYInBm6qgGH14NHUSKpAMiKCs=;
 b=fXOOwPhQRZli5/jvub73VJ62b5I0NqUOplgEBzzfvndgfYvWg/OGtpCCnAjh4/LnkO04Cb/tc2bbMCwgpg91fYY7BN94hbME220cJSHa/OMRBfd8m2BcpwTuFyyOu3s2LV/S/zD/+bcM3Fr0J6wlFQ513AGzd3DF9Tdhpkd7FfI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM0PR04MB6884.eurprd04.prod.outlook.com (2603:10a6:208:183::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 09:03:18 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 09:03:18 +0000
Message-ID: <3f221717-b5a2-472c-888c-cc8f777cde40@cherry.de>
Date: Wed, 23 Apr 2025 11:03:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Wiznet w5500 support
To: "Verdun, Jean-Marie" <verdun@hpe.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <DM4PR84MB1976607AFF39ADF74D9AAF7BD6BB2@DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <DM4PR84MB1976607AFF39ADF74D9AAF7BD6BB2@DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0232.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::13) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM0PR04MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: a5ea7d06-5bf3-4df2-6c43-08dd8245b051
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|10070799003|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RTE3SUc2OWh3TVVNTTB4aXQ5alVnSW5UWk01VWppRHRMVlNwOTB6Z21iYmp5?=
 =?utf-8?B?RnJ5QlVhb0g5NjRKQUM3am9ibkVKRUN3TVE0R3JkWEI5c2oxcVZnYzE0eFNG?=
 =?utf-8?B?YmRkQkExZGk1cm5LSjRxbGlRYTdzb21OVjNSYWtsYmI3cHNkNVBnWUJrRG9S?=
 =?utf-8?B?MHdadGsydFJWWitkVWl2S0J1UFdvZmFDV2p3QXRUaGFrZ3dXRFk1Y1BuRHJI?=
 =?utf-8?B?dEZJSjRxVTZTVkF5RkRGU01jK0FHcjNwSTh1L0RRZGtQTTVRT3lxcnI3V2FN?=
 =?utf-8?B?RmZUZDhmT3QyK1VQckZrK3A3Vm1iN2wzS09ySkNFZ0FCQ3BMYlFZYkFiMndP?=
 =?utf-8?B?RHZHYnhNN2Y4RGcvcGhpemxNdVZNTlRqc1V1OUZ5ekk5aXAvSkN1aWFPYk53?=
 =?utf-8?B?T01GMWwyYUhjL05zSFFYNGx3bklJK2FZVGF4MHI3OFA1OUtVcFZ4ckxESTlq?=
 =?utf-8?B?RHQyZG9GUkQwWVRDUzdVVW1jcFVFSDNaRTZOTmdJOGtNYzdlYzh4dmtpTzRR?=
 =?utf-8?B?ZkdMeFYyZkFqMVZaWTAxOTc5QTBpTEJzUFY1V09zdld0bGlIbWtsYnUvS1pm?=
 =?utf-8?B?WTdsb2FOcUtTTzd5YmNPVnNiTkF6dFpoTU1Wb3FrM3poWFhaNzNDZUlHRHBJ?=
 =?utf-8?B?K1pRb3NpNmVXTExYVlJqNm1GR3NpVG5PLzU1aUp6elE2T2V5T2o3OFhsTXhM?=
 =?utf-8?B?eDFlY015RlgwVzJNL1hMNXppTWQ5MHVsQTYrUjBNakp4SGpzNjdwYmhLNjFR?=
 =?utf-8?B?Tzh1S3M5VVNjUS9kb3ZFK3J2bTlvZi83NnQrdXN2SkF3d09OYmJsQWRmRWFJ?=
 =?utf-8?B?TFVFOXcvaGZoZ3d2RE9tT3l0T250VjkwUm5JZXIxQ2o5Z09jM0RVYlE2U1VP?=
 =?utf-8?B?T05HQ3l5MHRxeDVqZmdqSWdTUDd4YmVzL2NmN2F5bHd0cll1eEl0dEliRTA5?=
 =?utf-8?B?bWJyMXBiYWtFN05CZm9jT1QwL2pCWENlSnd3ZVBaRCs2c3RoTlR5VFl2Q3JO?=
 =?utf-8?B?SjljcFFZVWRWWmFzN1hzR1hZMmtqemU0cEpndVdBYmlXTHM0R0V1TGZZQzQv?=
 =?utf-8?B?QmNqZ0s3eHpwald1TG1xb0dDWDVCUmx5NDJPYTRTSDZDQ3dFN0Z3K2wxWllh?=
 =?utf-8?B?aTBDNzlua1VaS25RU0lSdGdxK0txcGpmdVJmSjlIZDlZWURFR3doNCtlT0F3?=
 =?utf-8?B?MDBpa1ltN284ZXNKci9vZUc0OEJVbDhCUExoWEpMcVFTenU5YWIreDJGTVA2?=
 =?utf-8?B?dndZTGZQTzF6Uk1ySUxYaU1TRDFzQ0k0Vm1ka3JVeGgva0R1QTdqZklnRFpZ?=
 =?utf-8?B?Uis0Mm5NazQ1dTl0UmM2cEQxOXVSSHVzMFRiN1RHcUFHbWdNVFBDMy8zQk9O?=
 =?utf-8?B?YUFzTWhBWmFGUFg2bTd1cTkzRGQ0OUZ2N0RrdHp0ZUw2NTNqV2tKaGNZTG03?=
 =?utf-8?B?anNuaEF4dzJ3QUUxNW5TcDhEQVJMdHNoN0IrVnlLYkpPOGxJaXRMaWdVbTdk?=
 =?utf-8?B?WVNZdTM5cTdiVW55Qnc5TjJYOTY0bG05bEJSOHBlR2U2YzJEckZVOTQzSW1Q?=
 =?utf-8?B?MW9yWGZVb0J6WVg4b1g2MzE0RjRKdU5qWXF1YWtIU250QlRWNHpVd2VSVm4x?=
 =?utf-8?B?VjIrUHNRYzhIL3UxNWVHdUxzZkpWdmhNa3FzbUdCZmFqMmFtK2pKZ3NyUi9B?=
 =?utf-8?B?N1JkSHNtSk1MTEl1bDBDYWo0RkcvUkkwNmxXdEtCUXFGOFZNd3FGbHdRWmow?=
 =?utf-8?B?TzI3N0pqRENOOGV4VmRjRkNmMjhPWC8vY3NqMGpza0s4MDhlaGw2OVFQcHJP?=
 =?utf-8?Q?qibYSXH5NKxwX18tAS9+AZbmQ6D1YBw6ABJrk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlBMSWs3cGViWEtLSEN3Z2lxb3Jsc1BBQmw3S3A4S3R2d09SWXFGUUJ2bVpv?=
 =?utf-8?B?ZHJEZzFmVXBoazdqMHllcDdwV3lYM0lKVjZGYThQbXRFb2NSVldxOEJ6R09q?=
 =?utf-8?B?emhKVFVpQXhKZ0R1T1hkeFkreW13QkNxeTUwMCswYlQ0d3pzUE1tdVlMU0Zp?=
 =?utf-8?B?a2VZZkFwUDhzQTBSdG9FVm96bkNNMTNkQjI1emRhUGVheDNqQTBPcXRBZFVi?=
 =?utf-8?B?c1QxSC9iMmREVEowb2JaVFBMV1BUVnN2U2E1U0wvTndkbHpNMmFTNmYzMDRY?=
 =?utf-8?B?dGVhNGlLbmVXeUdmeXQ5cGRQM01tbWI3QXFVNCt2ZThVVjMrNElFT0gyc1E2?=
 =?utf-8?B?YlBiSjVpUlJjRUVCcWxsOHlFaERCeENVcXZ5YW1mTnZxSCtOMk5seDAyTHlM?=
 =?utf-8?B?d1dUSU4rdWF1S0RuQ2xDSWtCWWNxOFhXcGUrdHpYRTJmS1JMWkhQVm5CWklr?=
 =?utf-8?B?bDE3bi9tbFBYdzZWOGxpeVZaSVYxcm10dlNJVUhjLzNxT0hoL09mRG43UFJp?=
 =?utf-8?B?bmxzZytJYXRKS2VBc0dMWDdGelRIRjRFMlRtU1RWS2Rvd1Z1bkpteVBUY1ly?=
 =?utf-8?B?dGMyZEdXNG84cjYvQ0s3V2Zua3pzdUtKOWdmY2lrNERDS2Fka1J6bzkxclhV?=
 =?utf-8?B?UEE4cG9zVUxxNkxvbjQrOExQMno5ZkI3ZTBrNUdmQkxOTzMvTDlpcTlnUzZE?=
 =?utf-8?B?d0pUK0VTcVpXVlFzQUNONkRyd0sxTS9FKzZ4NkpJOW9WdEYvR2JmNkZraDNZ?=
 =?utf-8?B?ckVnMUtTeUhXbTZoVDNkT2VxWmgwQjlSVG83YkIrY0dIT2ZlUjl2THcrU2VM?=
 =?utf-8?B?Zno1R00rbHFVU1VoWEkzVWxUTE80SzZkVmg0R0w4eTdKd212RFVlZ0dQckN4?=
 =?utf-8?B?NjJrOGJCUmQwRHhHeFRWbGN5N2lBYjdEWStyUFpITkZVWEp2M0VlbUt0UVV0?=
 =?utf-8?B?SjZLVEh4Zmp6VCtkZG5aM0tmQ1drT1Q2aE4wTTVqWmwzSmFwdHRXUE95bGJG?=
 =?utf-8?B?Y1RMUUNPSEl5NGt3b1BsSFdzOUxtUWJIczhHSUlYUWh3YlJrOG9VekY4dmVs?=
 =?utf-8?B?eTJ2SVo0ZVRkNjNmQVdwRDlYYUhRL0VVL1Q0dC8vc2RFeE5kekxLVmxJQzln?=
 =?utf-8?B?Q2drRDhqNGU5ajY2ZGFqemZhYldvbzNkUzMycTQyTjRHb0dRT2M5ejRzRjBL?=
 =?utf-8?B?NDAwamc2L2lMNEwxbXBobFJVWG50N0x0ZFFLNU9FaDRGc1l2SXdrNmkrTjZ3?=
 =?utf-8?B?ODFIV29SdXdnRDVNNFpNYWtxbjJzWVdzTkIvWGo0WnRVd1ZidHdKZDRPNWIx?=
 =?utf-8?B?djBzMGREeUVIVGg4UjN2Y3krdzJIZVlsR1Z1d29uRWN6WjZsWkRmOUEyY3A2?=
 =?utf-8?B?TTl6aktHa1c5MlZjSTVDZ2VTbjUrdXZTWmorbWR4LzdwN2ZmaEphY1VydVJu?=
 =?utf-8?B?L3UwMzR0Z3lGZXhya2F5TjFtLzh4QnF6cW0yMTlCaGNjZzJ3QjdYcUZCVW9D?=
 =?utf-8?B?VDRFNGhvVzF0UzA2b25zdWY3aDdOM2RpaUNyaTUzdGJLaXVtWkMva25pREdU?=
 =?utf-8?B?ZnQ2MkcxVDkzdjFyY3FDNnY0TjNoREFIdVpPTkNYejZGMFgzZHZtWEROa2VX?=
 =?utf-8?B?NzZIUDV5STQrRlNwZFc5aEpDNHZ0amxlWGNSSGlpVjEzY2xjbHZlWGNpUnA1?=
 =?utf-8?B?Z2p1dU9rU3M0ZlJITTJlUjMxbUM4WFBWcURlUjVVY3FaMC9nNFAra214NHdh?=
 =?utf-8?B?Ui9JQUpWalowd29qS0hjUkh3bEFDZFAvQy9Pd2g4RTk3ZUNhK3RxV1NuMVZQ?=
 =?utf-8?B?c056OE9Hc09qR0lLM09EbCtaLzNXRUxvbEhJMWJWSFJBTGdzaDBycWVNM0Nl?=
 =?utf-8?B?OUhtajZzckNtYlgrdUpscXV6dWJnRlJyc0pUTlVKcGxzenRpd0RhRFRKSTBX?=
 =?utf-8?B?NFZjek9OLzkwVDl3NkdCVzltNmQzSzFPeDFzMFVsdUNIOHlEU1JUNldTM3dW?=
 =?utf-8?B?ZmRYdlZvVnl1ZHJaUkk1V2tuYldtVTRZTFRhUEhKQUZUWGd1SWQ2cTZpR0xT?=
 =?utf-8?B?TnZ4QWpPNjJHNERLbDJSMHpHbkV0bmoreExab0ROWjA0OUhBWHBkemZPdVZh?=
 =?utf-8?B?c3lrOVUzRTZtZkVnNW9yYmltTDlTNE9YUVdhL1VFTS83aktEL2tHV2NZNnpa?=
 =?utf-8?B?RHlYWUNoZXB5TTNCTXBBekZYTE1lcmE1Ym9vMm9USFZMSG8zSnJ3aGI3Rmx5?=
 =?utf-8?B?WHh5T29HdDVSZWZMMGhyQ2kvRklRPT0=?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ea7d06-5bf3-4df2-6c43-08dd8245b051
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 09:03:18.1216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: spz5k9ubfcJBEoooxe+ubvf5o8TSpI/G7WxkHjxLfU+JszGwHYdaBL9zq733yWR43Ne1P4SF54JwtJx4OHXvqkADE707i/5beGZNMguHelw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6884
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

Hi Jean-Marie,

On 4/22/25 8:36 PM, Verdun, Jean-Marie wrote:
> [You don't often get email from verdun@hpe.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hi,
> 
> I have written a small patch for the wiznet W5500 adapter. (https://docs.wiznet.io/Product/iEthernet/W5500/overview).
> I am in some ways ready to push it into u-boot following approval from HPE, but as that will be a first for me, I just wanted to get feedback from you.
> 
> The wiznet device allows me to add a network adapter to deep embedded devices like PCIe board and boot them by using ethernet through a spi bus or gpios by using the soft-spi drivers through u-boot. Usually, such devices boot locally through a spi-nor or other local storage. I want to promote a PXE like approach as to ease firmware updates, improve security, and boot speed. The wiznet device can load raw images at about 1.5MB/s in memory and the u-boot is in charge at bootstrapping the second stage through the in memory copu.
> 
> I successfully tested it by using a raspberry pi 4 device through soft spi as we do not have a driver for it inside u-boot. It works at around 360kB/s compared to 400kB/s through the linux kernel.
> 
> Wiznet device needs in fact 2 drivers, one which behave like “PHY”  and one which is perceived as an ethernet adapter. Both needs to be linked through a phandle as to use the relevant xfer function to push and receive the data.
> 

An Ethernet MAC you meant I assume.

> So, my patchset will contain some work for the spi subsystem and some for the net subsystem. Do I need to break them down, or a single patch would be good enough ?
> 

Separate drivers, separate patches please. It's likely going to go 
through different maintainer trees. They could be in the same patch 
series though, to give everybody ample context.

Having had a quick glance at the diff in your U-boot fork, it's very 
unclear to me why we need an SPI bus driver (UCLASS_SPI)? The Linux 
kernel seems to only have the Ethernet driver. Is the w5500 acting as an 
SPI controller instead of as an SPI device? I find it hard to believe, 
but maybe :) ?

I believe you should only need the Ethernet MAC driver (possibly 
Ethernet PHY driver as well?) but built on top of an SPI device (and not 
driver), essentially just calling spi functions taking a udevice as 
parameter?

Look at drivers/power/pmic/rk8xx.c for example, it is a PMIC driver for 
an I2C (or SPI) device. Or for something closer to your device, maybe 
have a look at the KSZ9477? It seems to require I2C and SPI (but is a 
DSA switch, so slightly different than yours).

Additionally, we do not allow modifications of the dts/upstream 
directory. The patches absolutely need to come from the 
devicetree-rebasing tree, via the `tools/update-subtree.sh pick 
<commit>` command, so please upstream the binding to the Linux kernel first.

Looking forward to seeing patches on the mailing list!

Cheers,
Quentin
