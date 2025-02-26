Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE9A1C19776
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 10:54:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4422D801DE;
	Wed, 26 Feb 2025 11:53:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="VNX959lj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C71E80805; Wed, 26 Feb 2025 11:53:58 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::604])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 065BC80077
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 11:53:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j/fqMA6FyFKnju3eVH6c3uYRN2JGZ8xkEX2KrGsGLPcO1fjH4eNx9BZsOWpQoeWXzgYjaojPfLOgKPEwuXMs3At4z3U0a9lRE0V2EGK4pwp3iOF7INGC3z5/WNtWOsm8eFPbvpUSW2EsKkWbuh/o17M4j52/DCGCcQWm2IhNx5of4vEb2knzeh2GKSmtj6UTNwUqUxBlKEZQonng4kvj+4YCWfUAVKblKPVk94x8y5z7iCDGjEM/ZMMZmuDbx5cokGl9WE2CDj+eAa3lXuMS0lbaYDRpzhwpXxUzw9aqoTiy4oT8Ml1IciOwn/w88iR9mdBuzuO5DnVl1yWX3o5Ozw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnkQDGsUCfh6rBehII/T0oNfkoGAUdY8AV4WcL7Lo6Q=;
 b=GK/QlONuLHhhU8YE1N1jo845m2+LQK5R5Btx4Q59vBmUzRV0bKVRIcswUBw+x5fhM/UaG9NHjZlLFGd79eFHmiiePz+yTBvzhRNQlmZ8ktyxI5R4Wmt5n8OS+2u4DTtN5r+YvbIoUZK5Zdm3QIHC/4ehwmScgkiF0I+oJggMZIde5Rt4S14Gfk47oFYqX6Si/DeS4Y90WJ3Jz5G+pY2xRswhPieB5buQu4Vj2UZn6GF4QFzZxoGie2DIWMpkSeTw67UwlPsB9HowCrPCcj58ZlRTFShUCLmhKiXeK8sxzZlH8sjjnwb+M9DCD3Bs4qxLwgyB+wqY+dccGMYTWR0Ncw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnkQDGsUCfh6rBehII/T0oNfkoGAUdY8AV4WcL7Lo6Q=;
 b=VNX959ljIZ7gcMrmTC9eUMl4F02Poa5iU8TFqeARgPjWfRB2C4sLAagm9mWbRKw0+6Z1h5yAOq/ipzFVLxSRwmGwiJuCNAUZ8fKZlR55xZKvaWiU+BSu3dlepxMMVxhBrdP0SD9dvvlcv/QEPw/ssqucXYu9Nmcg/U3Gc+qJLt0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PR3PR04MB7227.eurprd04.prod.outlook.com (2603:10a6:102:82::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 10:53:54 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 10:53:54 +0000
Message-ID: <b98194df-a613-459a-b28c-7ecf5082433b@cherry.de>
Date: Wed, 26 Feb 2025 11:53:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2 v1] Propagate bootph* property to all parent nodes
To: Moteen Shah <m-shah@ti.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, m-chawdhry@ti.com,
 n-francis@ti.com, vigneshr@ti.com, u-kumar1@ti.com, a-chavda@ti.com
References: <20250212091820.213895-1-m-shah@ti.com>
 <445f7dd4-d445-41a2-ad0b-f0c2002f3f1a@cherry.de>
 <5ea8ee8e-1643-4b4b-974c-627f1958edd8@ti.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <5ea8ee8e-1643-4b4b-974c-627f1958edd8@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0357.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::18) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PR3PR04MB7227:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f80d09b-d036-4b74-a9c7-08dd5653dc87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aXRmRjZHbm1maTJSMStHUzBLRlVaVkRvaElhV1NBT3lhMDVqMnpDRjBmTEVK?=
 =?utf-8?B?NlQzZVJReWZONDNOUUNSeDZjV3dyY3g2aWNhZ0Q3bSsvbTRuR2ZxbjhIK3N5?=
 =?utf-8?B?VkhJaTJZYjJySU5JMzNiWGVheHY3L3k4cVB2eU1JQTFtVEgzdm5wZEZrUXJL?=
 =?utf-8?B?Rm54Vm1Yc3NCa0NmTTZiMEwyRThEdDE5U3JzOHdCekNtSlp3bFlLM2U2Zlpi?=
 =?utf-8?B?NU9pNXk3OG8yMlMzeG9UZnVPOFZDZldBTkpnVnA4Ly9pTnBGMW1sRjg1c3B3?=
 =?utf-8?B?YUJnSGlEM2wraW84Z09LakJZeVRzRkczQlIrM0RBa0FONEZsM2FqSHdOZm5t?=
 =?utf-8?B?NzZib1g2UjBvcjJ1c3I2dW90TVVhb0t2VmZubU91a3NpRW9lUkQvVGV4eTRu?=
 =?utf-8?B?SDk2N29TRkxPRnRjKzhEaEZhZHFoRS8xU3lhRnB2czE3SjdGNnhlUUdCWFJq?=
 =?utf-8?B?ejdsMks1aVVTZ3BVbU5rVWp3dU03YXF1cXZtMUs4UXdWbUJZaU54OEZlY0Vu?=
 =?utf-8?B?cjBIVXNUZG03Mjdjc0tkZmZXMnV5TjRvd3ZQTFhIcnhkbHlKcHUwZG1aeXV6?=
 =?utf-8?B?M1NjeFYwN29Ea09aV0NWMFEvdWtFWmhkeTVqaldsb2pHcHgzQzBhQW1MUDdn?=
 =?utf-8?B?eWw2ODkrOVNaRG1xbFJTeHlnYUI0NExBbnVqUHJHTy9UYnNVOVlaL0dJS2Zy?=
 =?utf-8?B?WWxLS1RUVzR6VmwrdlplZ3JrejJaeVJUWE1CcnBkNzJMTWFWZ1haTkwrUWhy?=
 =?utf-8?B?eTRKRVBZK1ljL1JTU3hIOC95YlN4TEs5WEVKSktaMU5XUGJKZE5uYXh4TXEr?=
 =?utf-8?B?NXRrdUMyQTlmanVkb0RqandNMVB5SjVOTndlNnRzNUpQSTdNdUpjR2JxaGs0?=
 =?utf-8?B?WFpnK2JRZStFZXB1SWJkdklMdUtYdlNuc3hSaHVPTC9Kc0ErTFN5alE0MmRT?=
 =?utf-8?B?Uy9Jd2lULzhIdUxXTThraXNOVklmdGcyZFdRUmZwREhrWEhBaWJCd0RDWmNE?=
 =?utf-8?B?YURPWlRtcmxGV0VQVVUraWJKMTVjQS9McS9qVVBDdTZIR3JFUWlPMldtc2pU?=
 =?utf-8?B?NUMvbUdya3EyZXRScjR1TFFYVXlCckU1aHJkbURnQ3FQR01SQzVseFl0bGpI?=
 =?utf-8?B?RHFxUlEyMHhTVW50TCtvc1FoeE5tb1dnT0p4dXgyb0xDQy9yMDhaRTMxNlVl?=
 =?utf-8?B?R1lpcG9OSTVpdThvRjcwbXB0THhTbzV4SHNOWUFWbUpTWS91VC9VelpySmUx?=
 =?utf-8?B?ZUxyeEhoYVk0THBleHl6YWkzc1RVZk4xdThScjVtaTR4cnRrT1VQR3BvSGVK?=
 =?utf-8?B?M0YxY0d2ZmlKQ2cwaVFGcHFITUVOSXk2cFJDTG0rUEJiMkNxWkFyQlpPOUFw?=
 =?utf-8?B?WjVzR2kvR1hPSkZGejdpcWtIemRvYWNVSTJiK3dFbzk3MWxlSTRIVzFqbVl4?=
 =?utf-8?B?V0dBNUdheFFYUnAxUUQ3dU4rRFhvVWdWTTBDSDY5VjFZc05DNlFzWFlwd3ZO?=
 =?utf-8?B?cC8yZlUrcE02NkZJbzNDTHoxZTF2di9kZ2tZOFBNU040bGdneWhCZGRnemNG?=
 =?utf-8?B?S0lkc3N5bTBCU1VESlIxcUY1ZGxoTHA4cjU3V0swTHhmanFMSjhrTUtjQnJI?=
 =?utf-8?B?anl4d3ByNVNiODlBRjBoenljbkVJVFROU3BTSExGdE1Jdzl1RlFLQUpVa0hM?=
 =?utf-8?B?WHFqTWlrK2dSTlAyZXFBTy9sUW5KdjgvK1V0R1Y5SVpKS2tPNDZFdnBBY2Y4?=
 =?utf-8?B?ay9aTTlMMFJoN2dMTk5xbENPRmFHbmJrL3Y2VDdOS0M4eTFicmV2TVJlbm5I?=
 =?utf-8?B?OFBlb1dibEdvbTNQYjl1bGpVZUdjcHBtQkh0S01mVWoxbXpoSEVtSTdNZEJS?=
 =?utf-8?Q?Bu6nqo6jGO+CF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3N0elk5dG93Y0kwNytoenllQWtnbjJVb1RobjJXUzYxZ3JoQk1HTHFGMlBj?=
 =?utf-8?B?ZjhPSFRqYmhMQ1cvNFNyRlVEWXR4ZFBtbG81ZktqeE41d2JLeEFaczU2SmRT?=
 =?utf-8?B?eUw1c1JXbUtiTzBSR3diTlRtUHNYYjljSklxbGZsUENBa2U5OU91TzBVVmlX?=
 =?utf-8?B?V3hCb3dqTDk3dGZJZDNxclJNWkZjNVhUZlhEZ0VhSFJGT0g5ZmJJNTFwekFH?=
 =?utf-8?B?NWFaQUFMblZ1bUZYWWhMK3B6cVlaMjlTN1JBYi9TTDVEWVo3S3RnbUpzZzEw?=
 =?utf-8?B?Rk9Banl6NTlPZmhTWU9nY09HYVJxcVp0WDVnMEpsUDFvMC92djFQY1Y3Z21k?=
 =?utf-8?B?WHRVR2JKZDBlc28zMXVXSUwrRUMxeVZKcDdZdE9xYnVVQTJvdWExK1k4SVM4?=
 =?utf-8?B?VW5qT3lJVlIvM1pwb3k1S0ZPU1IzalZtdk8rS2h3QlJoV3hEd29uaUxqendS?=
 =?utf-8?B?cHJxUFZvZ3BjVTNHVS96Tjg4RUpPWm1LejVYMGgrT3k2VHg0UE40NzA2Q0Fj?=
 =?utf-8?B?WlpYNXl6Tm5HeXJXLzZiSCtvRWhJQzFpbmRkTllGQ2s3SEZpRlgxY3ZEVVlw?=
 =?utf-8?B?N01nbzBma1YvMjJZOEdlZTBnMDZTMTlTR21pQzhDcUhMSlBtNEhlZy9DdXBp?=
 =?utf-8?B?Z255T0tDa3ZUaldlZEw4Qm03R0lERHRxSStZNmIzMnpvUUVHejA3dXpzeXln?=
 =?utf-8?B?MXozQUxQMXV5ZWV5MlRVT3cyekMrTFg4WWZjYW1BNzMrQkRNRXg4SXlkS25r?=
 =?utf-8?B?UnIzSm5FZU0xVjFrRlZiZEtTTkRGZE1zMWpKSFNTeTNtcm1PU2lZcjIxQnkv?=
 =?utf-8?B?QnZBZzlTdUlRYjMySFRCcnNWNy9GdGZqSDJFYlZGaGpWSERsNmVrcngrSXNu?=
 =?utf-8?B?ckUyMlErVUtBZnNXZkVlZ0V2QzI4YjFHOXAzWk5wQ3dpWTIxN1pScGxkVG9H?=
 =?utf-8?B?bHRhR3RjUUxpL29OZFVrOUpOZVRHdnlVRUNvcnVicUYvcUlIV0NML1E5NmFK?=
 =?utf-8?B?aEYrQTh5L2owNUhZSmlJSmpVbFNrRmpNMVAxNnh3YUVYYzJFZ05qZStRb3F3?=
 =?utf-8?B?NEFyMWpUb09FVG8yQlIrRFB0TkNYYjU0UjczTjVoWDdhcms4SVBBWmdheWpI?=
 =?utf-8?B?ZC9haXh3NHVDak9GbnBOOTBDeWYzM3V1OUw4eUtUb2E5Y1E1Y0cyTWdwVzZ1?=
 =?utf-8?B?YVdoK1dVTnRwYXk0QzhoWS9SbUZXbG1uOGY0NjRnNGQzYXJ3TXZTb080V01p?=
 =?utf-8?B?WVFwQ2JNQWVxa2FBZ01xR3owR2w2bFBYSzdHRUlkNVBNa3dCaUxuV25mRHVY?=
 =?utf-8?B?dDdFdGVoNUc3dHlhOG5ZbTVXNEFVT0hOUkdmaVlPN2hlQ1NMSlcrNzJndGtu?=
 =?utf-8?B?WFdzaHk1aGYreERxWFRaRzlsNmh0Mm9idlNjTlZTaitPRkxBeG5rNjh3bXhq?=
 =?utf-8?B?RTNPcmxLb3dIRzM0Nm4zeE9GNDAyNFhqb1BJWnFaT2FHRWtJWlNOdy9QLzQ3?=
 =?utf-8?B?MXJJd0gwUE1wYkFjN3p1bHlBcXFwZjJlSzFwL3JrZ1dVZ3hzb0lHZUdxakpM?=
 =?utf-8?B?QUtoMGRMQWRSNVRBSnF0WDVCejBWOUtseGo5ZnpNaHZNdG43SCtjaG93bHFw?=
 =?utf-8?B?aGxzZUJXOVl5VGRqdUJlTWRNc2JoeWV6ZVpxYUV4TDFydmJTQjk1ZHorOEF6?=
 =?utf-8?B?UEJ5dXlwT1ZsYjJNTWcxRVhaZDc1NkljVGlBbXgrZ01scDlxSFd1MDJPWUJo?=
 =?utf-8?B?cUFKckc1ZHFzTE40REJmQndnUkdITVRGMnMxZ3BBUHYyVmtOdzVoR1k5ZlN1?=
 =?utf-8?B?TXF6ZVFBSm44T2ZqL2tld29ScmgxRkxrODhGRHQ1QnFJYkZqUHF3cHI2TCt4?=
 =?utf-8?B?N3p4R1hBbnVVbXl6bHJ6Wjg5VTdyYlk5UVlLOWIycElUUTZBK3BIZVJORW9H?=
 =?utf-8?B?eEEvM1RFWEtkQzRjWk1lQUVRemN4a3hHS0h0WWNWcm1oZEVZYytrc0s4b2hQ?=
 =?utf-8?B?eVdXQ1VaRVBBOW9yUjlEK2loUWYza1VKRFlFclhBdW9kaUsvM2ZhSnJ5a2Nv?=
 =?utf-8?B?MDl5RkNiYk9NR2tNYUZHOVdvaitYYy9EOGcyNXEvRjFJZXViRXpkdGxlMTVq?=
 =?utf-8?B?dDVXdEN2VDBsblhrMHNjQnRCZkJlVFdmbHVQNFNCWDU3eVVwb1FUcGRabzdW?=
 =?utf-8?B?dkE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f80d09b-d036-4b74-a9c7-08dd5653dc87
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 10:53:54.0458 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q6V0z+m5mSeuKupNdIN3Fl2vC8XB37mPJGvrpjFguCuqiKF1C63srYSIR3KTajL6mR7I4OVlk9M1B0SsH89nD7L7jCaQ6uK7wL3QvzFUTHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7227
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

Hi Moteen,

On 2/26/25 6:57 AM, Moteen Shah wrote:
> 
> On 17/02/25 20:32, Quentin Schulz wrote:
>> Hi Moteen,
>>
>> On 2/12/25 10:18 AM, Moteen Shah wrote:
>>> [You don't often get email from m-shah@ti.com. Learn why this is 
>>> important at https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> In the U-Boot pre-relocation stage, if the parent node lacks bootph*
>>> property and the driver lacks a pre-reloc flag, all of its subsequent
>>> subnodes gets skipped over from driver binding—even if they have a
>>> bootph* property.
>>>
>>> This series addresses the issue by scanning through all the subnodes
>>> of the current node for the bootph* property and propagate it to all
>>> of its supernodes, ensuring that all of the applicable drivers are
>>> bound and probed prior to relocation. This series implements one of
>>> the solutions mentioned in [0].
>>>
>>> Since, all the nodes which are not having any bootph* property will
>>> also be traversed, we will have to incur some overheads in boot time,
>>> hence protecting the feature under a config.
>>>
>>> Boot time overheads:
>>>      Baseline: Upstream u-boot
>>>
>>>      Patch test: Baseline + remove all bootph-all properties from
>>>      *-u-boot.dtsi except the ones which are supposed to be probed
>>>      but have no bootph in any of its subnode.
>>>
>>>      J7200 delta from baseline  : ~100ms
>>>      J784S4 delta from baseline : ~350ms
>>>
>>
>> Pfew, that's a lot of time. Can you tell us what's the delta in 
>> percentage from baseline? Because if your system is usually booting in 
>> one minute, 100ms isn't too bad :)
>>
> 
> Our system's boot time is about 2.2s (J7200) and that of J784s4 is 2.7s 
> (owing to a larger DT).
> 

OK so respectively 4.5 and 12.9% boot time increase if I'm doing maths 
the right way, that's really a lot :/

> 
>> FYI, I believe we've been hit by this issue on Rockchip but cannot 
>> find the thread or patch right now.
>>
>> For TPL and SPL, the Device Tree is parsed and looked for appropriate 
>> bootph properties. Any node which doesn't have a bootph property and 
>> doesn't have any children with a bootph property is removed from the 
>> tree. However, the bootph property (if only present in a children 
>> node) isn't propagated (meaning the node doesn't get the property). 
>> This is done by fdtgrep.
>>
>> The issue is that for U-Boot proper pre-relocation, the whole DT is 
>> taken and only nodes with the appropriate bootph property is probed 
>> and children nodes do NOT count as opposed to the TPL/SPL case.
>>
>> My idea was that maybe we should rather propagate the property, at the 
>> very least in U-Boot proper pre-relocation. This does mean we will 
>> increase (by which amount?) the size of the DT in U-Boot proper 
>> because we would add this property recursively up the tree from a node 
>> that has the bootph property for U-Boot proper pre-relocation. This 
>> **could** be an issue as the DT could be passed between stages and we 
>> would then hit the size limit. Sadly, I didn't take the time to look 
>> into adding support for that in fdtgrep nor will I have the time to do 
>> it, so take this as me sharing my wish list with you.
>>
> 
> Thanks for sharing this, the size increase this patch introduces for 48 
> such bootph-* tags is about 1.5KB's, we can go ahead and bind the super 
> parent to bypass the part of adding the tag, but for the next parent we 
> will have to traverse again down the DT adding in unnecessary 
> traversals(considering a case that we are 4-5 levels deep in the DT).
> 

j784s4-evm/u-boot.dtb is 131616B
j7200-evm/u-boot.dtb is 88368B

so 1.5KiB would mean respectively, 1.1 and 1.7% in **DTB** **size** 
increase, not sure how that translate in terms of boot time though.

Reading Tom's notes from the meeting a few days ago where this was 
seemingly discussed, I believe the issue is that the kernel wants the 
bootph- property only in the child node. But I assume this applies only 
to the DTS, which would be fine with this build time propagation of the 
bootph- properties to node parents recursively. Would the kernel also 
want the same limitation for the DTB?

Cheers,
Quentin
