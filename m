Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAABBD4A617
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 09:22:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 005C483015;
	Fri, 16 Jan 2026 10:22:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="E0ZZClRT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73A5983623; Fri, 16 Jan 2026 10:22:15 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D410E82BF2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 10:22:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mGGW+mYBV3jwRwZ3n9kvhcAbSFbWeU1Xi008y/OQFFKSjFylDxEuA6FVfbOFxKuEMtqqBtcJ+rvEw/APr3ksPZKP6w2Efgt7aBdF6UNllsPgPVNPUPxOVmTM4yC8+YWd4PQ4jhwSM2c9nu18l1vjWazsl3n7pKqxuEIfbltLILBk3+lLrYRl8t+AFjAGMsKVjaiTgZPHaQLXZNHTR+cWhQgRUM/VCYU0tUwL05zSfseVkp3gSJvrUAbpMuQhYyw67KyMzmvbX5c1DDDVOqtRo9sSl7CRXd5Ve+rtzRREiuKkZ9yYUsZzLTj6VQTkqsKAPDT369QlmXMy+HGjJMaO+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5hJRbZg18SDRGw/ezHjlGRi2UFoPrQQgxtWridGW5g=;
 b=xLx2iYfZghVi4+DVuYI7eR3AbqxWdwSJ0O2nwL9t3da3pNuosOvmt5/TFD0PL6m6ehTs0JdeYRWch3E+To/3WtOKWRUnBhfldUy6oN4//1IrWWUFayJJpYWELt5zcE8I70Na2zMCJPuqkdE9o7LE8tberFj67dXyJ3flF1J68P13lI2/5PJYuPHbLg19HSV8cUFnIEQWafpZf6lo8sm28TuX+HTr1xqmU0GPP3HyS7Z2q7cqZlyC4K1DYRk5iSzxSJfG6yycMUHxWuU06iuTJVjVwK6UiVMO8rKjZi9zb3AyVATTCd4B9OvloCo63yps3sFqhc3XX57Rwieoe9FxWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5hJRbZg18SDRGw/ezHjlGRi2UFoPrQQgxtWridGW5g=;
 b=E0ZZClRT+d587nPvzzYIlGFjet4PtF0SSVbHeAEypG1tGWoZ6baOYZYyRGIZlf9PvwRr1fL0aQgHiXhJAWiHfDlmppj3JV0o9IUP5CE0FIY37SalbK6t7wOSzCjx4q96Jgr9+TV4poqHLBJo7tnYQ0acjlvoYwZz7kvaUHvWd+M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PA4PR04MB7965.eurprd04.prod.outlook.com (2603:10a6:102:c9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 09:22:10 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 09:22:10 +0000
Message-ID: <b1295a47-aa22-4cc3-a110-ddbc565def9a@cherry.de>
Date: Fri, 16 Jan 2026 10:22:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] rockchip: Add initial RK3582 support
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 FUKAUMI Naoki <naoki@radxa.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
References: <20260107230747.3552391-1-jonas@kwiboo.se>
 <cd629f5c-f69d-4b87-908b-aa323c78792e@cherry.de>
 <64c4723c-c5af-4800-8886-b06c1fa8bb8e@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <64c4723c-c5af-4800-8886-b06c1fa8bb8e@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR4P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::11) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PA4PR04MB7965:EE_
X-MS-Office365-Filtering-Correlation-Id: 73c43607-dcdf-4fda-5594-08de54e0b9e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|10070799003|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dUhiYk41K3VRdFRHU0lxTG45MFJTc3Vlbzd3ZUR5Nnd0dzBPWjkrQWtpYnJH?=
 =?utf-8?B?cjB2SmhmTC9obnRMY3VIWjhoWEMwdjFaMjkzVkZRNWU3dStGd0dNbzBLU1F0?=
 =?utf-8?B?SzBnN3ZUWml3bjRJdDk2Z0pCRFpERGlFdnlySWFkQ3orK3N2S2lhbmdqaGZs?=
 =?utf-8?B?bWpWSlFkNDdDbFZMMDFYQUZiR2ZwQ05STE1VaFRWbktoY3lENXBaOEFtZDJD?=
 =?utf-8?B?MXRoVVF4WWdxZG5jM2FDdEJ0Z1ZkOUkraUZrdXdDSlpTNUhYTzJjcCtNMHkr?=
 =?utf-8?B?bGp3OXUrT0lRb3JFL3dqY0xRS2d0aFhwd3lsQjZVT2Vnbm1WbDRwbktoeVI3?=
 =?utf-8?B?ZWRyZmtEc3M5YzlZNmRaMmRabHR2MTdYR05ZZG83UlNCcTZkMWJybjQvamIr?=
 =?utf-8?B?Um4yTVl1SjhLOVFycDdwV0hFM0liWU9ROWFud1lNQjdlYTZCZFd2d3RtREJC?=
 =?utf-8?B?UTMxVEx3V2I1NE1KaEJURnhhQ3k3YjZ4eHA4eGszNW5WMVpLdERHS1BVVGFv?=
 =?utf-8?B?c1pOM2pqemNoYjJVWEticWZEa0wxUWVXK0szNTZEUEhzZVZUUGNLU1lXbk8y?=
 =?utf-8?B?Y3g1d2lySEpqWVRsN2puTGNzaWhnWmwvZURTS3B5S1NYVFNBQ2dkZDNIbTMw?=
 =?utf-8?B?OG85blpJcjREWTA4dnNNZHlwdm52S2crd1l1Z0YxV2Q5S1lrTXFJeXk3b1ps?=
 =?utf-8?B?dDZFd1RaMnZvbW0vSE9KNXp1cTc1eGZydWpoeE1JaWVhSVNNdHlidVV5bzRK?=
 =?utf-8?B?MDh2cVlBRElQMlZiSElXSlM2V0VsZ1FjMWliT1MxN0pieWp6bW55MUVrcTUx?=
 =?utf-8?B?ckprTWxlQnNzbW1IQ3lVc3h0RC9TMGwwKzQ5d2tSSVJtMmljdXBEZlNOS1lO?=
 =?utf-8?B?K1RyYlRtTHdnem4yNDJpT3Q4UEdXd00xQ0F5TW9VdnZ5V0FXVy9WMTlsb3hi?=
 =?utf-8?B?bWczWGVHaW5YblMrRU1FWHhKOFlGS3NDOHRXemhRWHBZUVgwMWIzR0pXSW5N?=
 =?utf-8?B?c1lubUM0NkFlSVhOVGkzUWFjUHhIdXhGWGtza3puYzFIYkY2S05DdjNLRVk5?=
 =?utf-8?B?Y1JTUEY5d0pTanBseXlwQ055RmtPUyt3U1hBR2k5cTcxcUhxVUJTZUJQUFBH?=
 =?utf-8?B?K2tQS3FVTjYvb0Z0R2xERW1lQmNoVkpsdms2cUljdUR2a0tYa0FhVEc4QWdN?=
 =?utf-8?B?RXVPT1VXajRCZDBZKzZIdVVIbjRNTUovenA1WUc1UEFNTnhML2RFdzJFRzNF?=
 =?utf-8?B?QmY1TnNkZWdEYmxRNTFEMlV3WGR2dWErWGxUeHdkdytGMEM0L1VqWVJqNi9W?=
 =?utf-8?B?bkRVck94ancvMUltWHB2WjJxa1Nhdm15ZnFPOTFkYzVSeE5OdldKa2xhVUla?=
 =?utf-8?B?YS9hNkFTQmY0NHVGNFZXemF0SnIzM3hzZ3huMGlQeHJoQ3BBUnhQQnR0Y2xi?=
 =?utf-8?B?ZGh3Z0cvWnlzT09vVCtTQkZHV2NCSllzcUZzSUNjRzhRRFlaTXBoeHkrVjJH?=
 =?utf-8?B?N1dSUDJOUDhYSUp2SHgzcWkwYVJlSzk1alN2d3QvZjY5RHdYVXNxaGVxUDl5?=
 =?utf-8?B?OEw1NkFKYkU0RzBqc3RQUjNqTTlRejk0Ny9NSmdqdDlGTUVwUDB6dkdhWUQr?=
 =?utf-8?B?RnFHWHFMbXJLOUJSc3ZzVjl4dXJ4NTV2OGpSV3BJUXE0MVNIM3ZkREhXOEtm?=
 =?utf-8?B?SHlPVlFYWGVlR3FFTGoyTUFESVN2d1pidTVxYVpnODFhMyt2SmtrUUJGU2I3?=
 =?utf-8?B?andtVExmUDFiMWN1eWhBMXFjY1JKaFVZMExPUXBzT0JCL0pDZlYva1NpSlhy?=
 =?utf-8?B?SDhhWlpXUGxqajlVdy9PQ1FQdTZlaTBlZForVHhQa0xzbUxQTHFHRGMrK3Ur?=
 =?utf-8?B?c0ZmR2FQUzNQRnNtb2NCNzBGeWNvNlZsTHdmT0RncEFOSGpLd0ZlaHYyZloz?=
 =?utf-8?B?R1c2M2d1Y3dkYnhkbklCRGZZZ2cycGl1U05xK0hmU1Jqa2twQzNlOStIaEU5?=
 =?utf-8?B?bDc4Z1RxelA0VmdFZ0NMMksyenhDeHJKTG9leG95bzlyTzNxa2daTlFjZDBk?=
 =?utf-8?B?TUU5ZEpIZ3A5TnRTUmJJck1UWnN0alBJVTZMdm8xYUY1VGVydTVKTlhBOFZR?=
 =?utf-8?Q?lj8k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmVSQ0dNSnkxT1drVWcybzJ3UmQ2UzV4cWt1c2JuN1oxQUxCbWVQSC9DalA5?=
 =?utf-8?B?d2dEMDIzb0FtcGZ6V0doNVg5K0wycFRHV2tZYm1tNjJVbzQ0K2dVNktXQWIv?=
 =?utf-8?B?NlVidTVQRTJNeFpsV2ltdnpzOG5IT3cyUFV1cm1nSnFxUEVrMFBMeGJqZ0Q0?=
 =?utf-8?B?ZUZYTU1reHlyYVJoMERXWXpRdUtWR3NMbFBEb1JVSzh4Zy9MS29ldE1hMWow?=
 =?utf-8?B?R1V2Q2FUUkRIaENhUkdGOXZMa0gzbnVmQzRGd2J0MDAwZzJMWldXNkxqOU9u?=
 =?utf-8?B?ZnJyYTNoQVdMZTdreTZDZDc2WDNLL2ZqR2hOcGhZenU1dXBlam9tTDRnVWxR?=
 =?utf-8?B?ZHZRYldoOERzaW5GSnZRRlhMQ3BYNnYxNTl4Q0NmMm9lV0xVNU9ZYWNpMG5K?=
 =?utf-8?B?ekhnbVZuc2JMTDFkNC9xT2wrWGNrMWVTWGRnU2VwRUt4VnAwYzRYaXMzc0RH?=
 =?utf-8?B?cjNveDhYdHVZTzNXeTAwb3NTUm94Y1BNaWVnbi9jUDlJc2xiNHNNSWxYTG5G?=
 =?utf-8?B?ZjRjejdISGJyWmw4c2JjV0pQZE5MVlM5RGZ3STdzd1FEb0FiL0UvQ0tHQUF5?=
 =?utf-8?B?cTV6YTBSSkJqejRKb29oNlpXWXd5ZWQ0TjhEbzVrNTRqR01oMUxmVG5iL0Ez?=
 =?utf-8?B?NUptYXkrTTc5YVJwY2NKR1BsL1pjbnVXRmZOVitobzZZVWJmOFp4dU5sSUY5?=
 =?utf-8?B?N0lmZElXVGVpTjZxd2s4MWxZQ2lxdDhNc1EyTWM1QmZDbnVuRldvL0lrazFZ?=
 =?utf-8?B?RlB3ZktpN0RCRE5EUnFBV0hoQVI3M2ZhSUs3STVsTnFQSVNlTVllY2dpRWNx?=
 =?utf-8?B?RDlRTFFtRkxxRnZvd25IMFdWQXE3bURoaDBCdE1nakY1eHlaVGxiTHg5YUtk?=
 =?utf-8?B?eW0zSElOZGxQUGNRLzk5U2Vra1RFQnJ5VkVNeTR4UlBITU5EcURISTIrMzNP?=
 =?utf-8?B?aU1nV0pFZ0F5TU1iTVZhVG9nSEpDRHdrN0gyMEk2Qys0SFRLdkkxd2lLbVBv?=
 =?utf-8?B?Z0NOZHF1RVNqVklDbFdkdDdGSWZXSUJHdkJyckJzZnBIOXdNaFE5bnlzTE1L?=
 =?utf-8?B?UUx6eG9EckhURTB4SGoyUkpWQWVnYlNBZkNjWEZham5SRTJ2RXBsODBxVUcz?=
 =?utf-8?B?OW1QOXJGRHdIV3hlNUdEUFllZklkUG0xQXp3SXBEci9rbmlLUmxyVHVxS1Jw?=
 =?utf-8?B?dzhEUVFKVmZkUHE2MHNJQ2ZWbkRnTG9TdDVPRVB3NWwxaHFhVEVjV1h2TS9m?=
 =?utf-8?B?Uk4wVlNxSURhb3NZN0FydExwSnM1U0k2TDRnL3RtemNOMi9QNjdZd2w1a2t1?=
 =?utf-8?B?VzhRVkgzc3ZPelptcFVUSDlOWlRKZmQ2SVJIWHdoT2pqT3lYUkhWU3RmN2tG?=
 =?utf-8?B?SzRMT2o0L1BubDFrcm1sbm95UmVRbWFnQW9teThuTmE2a1J5TEZYcklWMnBv?=
 =?utf-8?B?R2E0M1VrcVJiWnU0ak5wUHZ2b2JvK0dEKzRtVjRBOElKOXE0VytLUjJDbEEy?=
 =?utf-8?B?L21Wa0dvVEpKR2tsTFBMaU5HOUFlN2RxN0pzeWFDQ3pZSkJRdUsrc0VmYkhN?=
 =?utf-8?B?VktjL01HL3pKT0xhWkF5NG5zaHprazh2RHpWTTJkd2hWNmw5TW1DVGxzWjA1?=
 =?utf-8?B?ak5TdEdjc2xENDJXU29kU3RNYjMrc1YyOTNJQWZvY2g0Ym9YbWpxaW1BUGM1?=
 =?utf-8?B?dXFpbmZlWUFmMklhODMzNitUQ0EraWdzRG5sb0pRb256SWV3ak9RREZVSWtE?=
 =?utf-8?B?aGp6VnpLOWtmajEzbUlvbC85bEcwbFdHUGJHZktmQmEwSGxYeExnbWI1RWln?=
 =?utf-8?B?NkhaNExqVnlTUk5uSGFvTVFTZFh1aHBJdWNLN2h3N0ZUY0tCTWFhNmxETTRQ?=
 =?utf-8?B?VkE5WFR6amM5djFhWGpyM0tYODE2U3Q3VXQvUVlkRFJBZDR1NXhvN2J5TVVP?=
 =?utf-8?B?SDIxUDRzSnZ1dVMvdEl3RVlSMUFFUzk5Tk1mcDF0aVlPR1VLQ21QZXJIWFlP?=
 =?utf-8?B?TDFpdXNXRDR3bHNOeHBhaDZoaGE3MEdnM0ZOLzBHRzZMbGVGME9ndVoxaUpn?=
 =?utf-8?B?NFRqc0VUTVVJVkQraXBzanFYVHlNbUtmSUxZZyt1Z05TeHFhM3dhTGVoOTZQ?=
 =?utf-8?B?VmlJaHliTUJKNEpKQnNJSUtTanR4Z3k1Sy9zTEpyWldJc2hxZHp6VVZCUXRX?=
 =?utf-8?B?aXBXcURKVkNMUHBDeDh5cWtUcUViVXZxL3pEVXV1QkJscEZRcWpHU2dpRlM5?=
 =?utf-8?B?VVRwbjBQYTRQK3dRRDFDR2xNOWN3UFNGQjRiYmxHNlFKV2V4eC9nbGVNVlEx?=
 =?utf-8?B?b0IxZ3czMFZpWmM5YjlrdnBzVlFnYjJleDJWaFJZKy84c1VJNXAzQnE0OURw?=
 =?utf-8?Q?xD+0KmquRDWPrAZIMIpST1cAV+vFII6FfjBxi?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c43607-dcdf-4fda-5594-08de54e0b9e8
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 09:22:10.2610 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CPf8U6gjKNmcOqh9Rx0WxoliaIw3DBpibhgw50GlTCTVmmj6vZwirOCcowQD6KS8kvEmzbgdXMq7uYDsEpaczG63YUrVoXcjn05JogBGFLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7965
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

Hi Jonas,

On 1/15/26 7:46 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 1/15/2026 11:34 AM, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 1/8/26 12:07 AM, Jonas Karlman wrote:
>>> This series add initial support for RK3582 support. The RK3582 is a
>>> variant of the RK3588S with a few ip blocks disabled. What blocks are
>>> disabled/non-working is indicated by the ip-state in OTP.
>>>
>>> Compared to the vendor U-Boot variant, this mark cpu, the gpu and
>>> vdec/venc with status=fail instead of removing nodes during DT fixup.
>>> Linux skip cpu cores marked as failed staring from v5.17-rc1, however
>>> the GIC driver will generate a harmless WARN_ON that safely can be
>>> ignored. A patch for Linux will be sent to skip the WARN_ON for
>>> failed/disabled cpu cores once this lands.
>>>
>>> It is recommended to use rk3588_ddr_lp4_1848MHz_lp5_2112MHz_v1.19.bin
>>> as DRAM init blob RK3582, listed in latest RKBOOT/RK3582MINIALL.ini.
>>>
>>
>> As opposed to what?
> 
> The release note for rk3588 rkbin blobs [1] list this DRAM init blob
> version with:
> 
>    New
>    - Add RK3582 support.
> 
> So this remark was a hint that users should use a DRAM init blob that
> has proper support for RK3582 when testing this series.
> 

Ah, then something like "or later" or "since this is the first version 
with official support for RK3582" in the commit log (and doc/board) 
would work for me, what do you think?

> [1] https://github.com/rockchip-linux/rkbin/blob/master/doc/release/RK3588_EN.md
> 
>> I see there are 2 DDR bin and 2 eyescan DDR bin in rkbin, but I'm
>> assuming at some point there'll be a newer release so we need to know
>> which to use.
>>
>> I'm assuming what matters is to match what's inside
>> RKBOOT/RK3582MINIALL.ini? Can you add this to
>> doc/board/rockchip/rockchip.rst maybe?
> 
> That is something that is true for all SoCs using BL31 or ROCKCHIP_TPL
> blobs from rkbin repo and a topic I think is better suited for a
> separate documentation improvement series.
> 
> Something like following could possible be added.
> 
>    When BL31 and ROCKCHIP_TPL blobs from rkbin is used it is recommended to select
>    the blob referenced in RKTRUST/<soc>TRUST.ini and RKBOOT/<soc>MINIALL.ini.
> 
>    Something like following can be used to set the environment variables:
> 
>    .. code-block:: bash
> 
>          export BL31=../rkbin/$(confget -f ../rkbin/RKTRUST/<soc>TRUST.ini -s BL31_OPTION PATH)
>          export ROCKCHIP_TPL=../rkbin/$(confget -f ../rkbin/RKBOOT/<soc>MINIALL.ini -s LOADER_OPTION FlashData)
> 

Oooh never heard of confget before :)

> That is similar to what I use in my build scripts :-)
> 
> For this series I will however include something like below in a v5.
> 
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index 217694de0c92..022f8f2f20c0 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -329,13 +329,15 @@ To build rk3576 boards:
>           make roc-pc-rk3576_defconfig
>           make CROSS_COMPILE=aarch64-linux-gnu-
> 
> -To build rk3588 boards:
> +To build rk3588 (or rk3582) boards:
> 
>   .. code-block:: bash
> 
> -        export BL31=../rkbin/bin/rk35/rk3588_bl31_v1.33.elf
> -        export ROCKCHIP_TPL=../rkbin/bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2736MHz_v1.09.bin
> -        make evb-rk3588_defconfig
> +        export BL31=../trusted-firmware-a/build/rk3588/release/bl31/bl31.elf
> +        [or]export BL31=../rkbin/bin/rk35/rk3588_bl31_v1.51.elf
> +        export ROCKCHIP_TPL=../rkbin/bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.19.bin
> +        [or]export ROCKCHIP_TPL=../rkbin/bin/rk35/rk3588_ddr_lp4_1848MHz_lp5_2112MHz_v1.19.bin
> +        make generic-rk3588_defconfig
>           make CROSS_COMPILE=aarch64-linux-gnu-
> 

It'd be so much better if we used your confget command line so we don't 
have to keep updating this documentation (which we fail to do most of 
the time I believe?) whenever a new blob version is available, don't you 
think? Can be in another series or commit, I don't mind.

Replace [or] with # or
to make it a shell comment so that one can simply copy the whole line 
and paste it in their terminal.

Cheers,
Quentin
