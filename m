Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A342EFCE064
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 12:21:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3271383AA9;
	Thu, 26 Feb 2026 13:21:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="a0Sx3q3K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9639B83E88; Thu, 26 Feb 2026 13:21:04 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B09BB83642
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 13:21:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLbhNWWg6h/Q0j42qBHF2C2Zs0wsqTkbfxPQAacN3SgAthRpFLw1AvTgn5LZ6WyPiICaHmpa6tmmzVtXbMiwVSF4AASqoNbB2sLw6LO34tqM1I32tmmmFTNT4Q7fRkLcqnpZLqL1eK8SvMin6XJg7jSHprSapJJptM2i/I4hiCBBw/G9orWpxjrFSeMJC8hVkm+kEx2So6jd6/k8xRejiHhUpnb+X+HOKgxA68RR+baOLE2+EPuNmYhzoPzZYh1Qiw5HGq8etovpILt5VbC97KMGh2eSQZN7iPmoXclz0G7iTt3yflnJFOOs0U+W5BpQKjWyz2L9kDDsaj+pgnin6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8AkMXSNI0WznYpyKOo2kWzw9MIkcV0Hj2F3QbUBE8E=;
 b=vV5/MBdwL92N6YlUWb4HXFqSVw7Xsq5X8U4AUHFpdP9HRow29Z1DLnKnoM/WBHQN72+PVoze6rOL4e87zZV8gy//LCnUcIPENU6aMjdr+lC7mawBMmLwIturV6omO7tClv4ed+y9LxstHlXHYORPXmxVSosOBSTjbw4KtAnTKZh49Mkwa78vpL5HEJ2UxNVfzwJTdj5dvwV9s306HclrloEmDcYz0YPyH+elGTY+3sYcMuGZC7bKdDM4ITK6gIc4p2hq0fziUYSv//aElZTe7oZlcM4KfgJS8gHWAeXFKMGj/0fhcMHMHIqyne3aWbFrcxWC8y1zXWEzL0Hmd23NsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8AkMXSNI0WznYpyKOo2kWzw9MIkcV0Hj2F3QbUBE8E=;
 b=a0Sx3q3KnEVXmrOzweiAFJJCQvXKkiWU2gpFCZ5LrP61TQZEh2jophvBqh2NpS45u8b+jvUx+m78skF3ZwviO+NReVV9jsxLzL2+OmGSFL8GCVYJK1giPpbvSuDUphyt+QHM/udwTY4mzcM7VDTZs+YxQoReLeTHGZPi5z+PxrA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AM7PR04MB6885.eurprd04.prod.outlook.com (2603:10a6:20b:10d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 12:20:59 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%5]) with mapi id 15.20.9654.013; Thu, 26 Feb 2026
 12:20:59 +0000
Message-ID: <f1b475e5-d1ec-42ce-a631-b00082def79a@cherry.de>
Date: Thu, 26 Feb 2026 13:20:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] x86/apollolake: don't select non-existent INTEL_PMC
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260225062301.46540-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260225062301.46540-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0066.eurprd04.prod.outlook.com
 (2603:10a6:802:2::37) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AM7PR04MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: 5da5dd28-d5ad-4034-dad1-08de75317feb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: DseZa2+qrMZbSMxI7HHgkeqXlvSizFdtI5zR2AYfCifsTFEAnHzMVAhqNuav1YYsuSpruHKoUZtf2Hau2vWjBb7Wqau3K5yW2/U4/hsC5kIVvPDpn1vOEQelyiVOeMmIrIBG4Zsp3Ms8NI/6CuouDcqHYFc13fThDDKmX0FWLMPN5NhW36rjQJpvzjZ3Abmvn1zadHnEDIfFjBxOLgugfu+s7duUTLEjj/KqDWGxAoUb6sP69acJFP72doqisVod+nhnfjO0Wqt6S+rKzuW7dwdmDqFhiX/+Oo1ybRmw5z8nMC31VXQueZ9AbuxFXYem8hhSpn4X2Z7o4TqPMQlqXAtWJlxbvELt8XJLDappJStnhM2s3uVJ79pML2DS3u921aOhx1JpnZLS20SL0NWbxu2iR6Ad6PfRCEhMdqMNdS3mA6x4SLE9LzHuAPv00Oxvezidm69VTXB41ZPn+Fch2dbIkjXYH4CRF6XPLU3G87RfyqMxcpK2fduodAAJrF9rIzyXrPGMLhqYm+Vb3vgBCS4KzVzZ/ANRP9D6oZnamIPSNU+h9SkT3AOzfn10QjlxQNW2WxZnVl4gXIOm4r2u/XAYa/W25EjazMrOoplZ1/swsZdKgIZj3meqb9MIWN5aD2LL5LsMhSQPgaNsTHo5B03vXaZ7Q5krSO21+ry7Lc69hVhwQZMAt7NGHtSHlDOSeWQp3PVBxkfJQcCgIB8GZKlzi/bUpdWCwfVdErdX7Lg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVIrc1AvbjRTZXlQT2svL3VEL3RHWjNtaTNYdDBycTE1Wk5KMVdxWkZmUmZ4?=
 =?utf-8?B?S1Z0RlpjN1o5WnRHaWEzSzFpaUp2YW1rZ0hWakdjWWVTOWh2dGw0SDNNZWxF?=
 =?utf-8?B?S0hXcjVmUEJucmxGYklDNVcyWTlZN0xUcVZzbmFCVjhFY1h3V2RZTFJYMmVD?=
 =?utf-8?B?TzlmOVZmNDlDZ3ZtWTltYzBjbUR3SDVQcjB2V0lpbWFvTFE1bHZnZE1kOTRr?=
 =?utf-8?B?ZjdnYXpRT3h3YUhlV3lpZTV6dElKWjJKNll2THlRcmZicGpGbE9oZzBLMXpz?=
 =?utf-8?B?VlR1SERVZ240WVFXOG5yQlNPeEFhSmdnK2RTVFJVNWlPWkpBbXJ4VkUwOTVM?=
 =?utf-8?B?UHNEK0JHcTE3bmV0cmsxclU3TjlJVytNUGZNTWFrRnVRbVNtNVR1Sld4eGJH?=
 =?utf-8?B?M2w4RjNaZTBMWGZJYnl6L1NxOThrSG1FYnhkdlhXR2Z0Rm01TGZHd3RoZm5Q?=
 =?utf-8?B?aStDYnowOG1POFRXT3ErNTd6bnFOc0VVYlp6Rk1wdi9aVHRjTlhacm1tRjhx?=
 =?utf-8?B?UWQvbHpJcHVxVUlXY3d4R1pKS2NjcVc3WjYyZjg2NmRQV0FVNWlicCtUakQ3?=
 =?utf-8?B?NlJMOVFqOFkvU3BLVDFxOWtQNXphQUY5ODYyRkNtSEk1Qk80QXBCSDdWV21K?=
 =?utf-8?B?SHR1Nk5lT2dSVDJPcXcvWDN1ZWxhdHNFdkRVdkhBbGk0ZFNvUGNzRTZ5ZzVN?=
 =?utf-8?B?aHkxQnBYSVd5NlZnMHIxRkJvcEtxWnhjcHVranVJVXhhaFYxTFllOXpwVnlV?=
 =?utf-8?B?Qlo0SHVGSE9FaTVrV04wcTcvNTdRczlLWlJHWi9lMjFDWFJiakZ6cEk0TUsy?=
 =?utf-8?B?cnlNWVU3Qy95UFFuT054aFFEZmNycEFXaXg5VE0xVDRvZ29QVGIxdTdsTGtF?=
 =?utf-8?B?TS8xVFpkd0kvTDV3YVBlbmMzeUJnVkNGMGpHQUJpcEVWZTZueWg5V2FQb1Nl?=
 =?utf-8?B?VnRlNHQ0QWd5cUFVa3dyM1BwVUIyY09FNkk3R1luNjk0UzBDcW81R3J4elh3?=
 =?utf-8?B?MGZEUWN6bnZUbHZLRHJkNDhJL1AzRUFmUVhHalROVXZTWFlJS1ZZS1ZRd2Jn?=
 =?utf-8?B?R3ZwNXZpYjBUVHp2VmRGcUY4VjQ2KzE0cFJBeG1uY0xpZm5qcnFJM0UzK0Vq?=
 =?utf-8?B?b1kva1V4ZGcwTFQxZTVTUE5tQ2F6M3F5UFJQMzBxS1puTGxIbk9SSzlWcHlC?=
 =?utf-8?B?TzJ4S1dxRm5kNXFqRThHaVBIS3NYcWtEdjJ5WVh2UzRZSFgrYVFyTm9yNHFm?=
 =?utf-8?B?bnYzbGVYNWRvSGgyWVFLdG5ObCtzWllsQTVETnlpa2MzdFJLN0pRQnlVWWV4?=
 =?utf-8?B?UGc2b0dyY1A0cFdGdWFoa3g4OXczdkEzdityc3prUEFNeDJsR1BoOG1McGZu?=
 =?utf-8?B?WU42bkkzRnJKN3MwcVQ4VFovSjQxemc4bVNzQVVhY1N2VUh1SGIvRHJTTTFL?=
 =?utf-8?B?QUh6ODR3NEMvNTh0OHZsdS9uZ2hETGlVQWtYWUNCS2ZqWVM0N0M4S1ZsS0wz?=
 =?utf-8?B?NUYwaFhpbDIxNkJpYlFyTzdLK1FDRjZYODRCT0N6ak5ubzlCa3F5R3RUNTU1?=
 =?utf-8?B?SEVUb3dGd3ZlM1NSd0M4RUs2UUlLS0R5czZraUErTUpCU3BxSDh4ZUNCc3Mr?=
 =?utf-8?B?akFpMk1DQVJOMjVqOHF4dXZyM3k1Y1QwYkE5dlJmRGhacStLMk1mcE5aL2hI?=
 =?utf-8?B?ME90ZWlqLzZ4WE9DNXFpQWREQklLWXhJdHZIczQwcmZKMXY0cnpIaUR1Zlh6?=
 =?utf-8?B?S2ZySnk5QktqSlkzSXZMYjdpS211ZUY1OWVKYWh3dElDbko1cFNBbGNkWGJR?=
 =?utf-8?B?YzJ2L2xIdjNpTC90c2lqRSt1VWdCbW0wN3VoeVJ4TFVpc0hJU0JZVy84WTd4?=
 =?utf-8?B?ajZyN050b3JMOVc2UEhRWTJVbXZzQTB4Y3NpeXBNdmV3L3lXVVZXS3htSW5S?=
 =?utf-8?B?YUxnUW9DTkVhTzhrQVNodEFxOHRxVUtiSXVjU0UzalA2OFErMHArSlAvTDg4?=
 =?utf-8?B?YitBaU1YS1NoKzYvZU96bWx3MkNuNmt0MVRGMHN4Q0pUVHYrK1JIeStGUzFi?=
 =?utf-8?B?eG9TcTVGbzdtK2VSNlB0YTZNaDZhMU5uVWhFUytISGlVK09QbWdBYkR0WjNq?=
 =?utf-8?B?RlIvVjNJeWxlV0ZYU1FzVWFYTXI1dXBTSFYwcnpwUUxxMjNPOGcyc1dNN3JZ?=
 =?utf-8?B?YUdpT0VNM1c1ZDd1UXd0OEVsRm1TckNrR1R0NzlqcEk1UjZwV1I1V3MwNkla?=
 =?utf-8?B?MDJEQVlJMXVxSThEY08vYzVoKy9HSkd5ZHRxNWg4NCtPN2tZRTN6MHRLZThI?=
 =?utf-8?B?NXFEelBOYzd1c0c4ZTRDWTI1OUtlMmtRazFTTGVPcTVkbzFMT3JNRGtLNjJh?=
 =?utf-8?Q?0knpZLpH7epLJk1M=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da5dd28-d5ad-4034-dad1-08de75317feb
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 12:20:59.4633 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uEw6DMNmVtU9vq7PzjphbEYI2gnj7Muv9B7veX6rEKz/T31iVXDioYC7nT1C37qDhKlXFO7Q6Up1CIhtgJ8MvEcs9uIWaV/CoJBTkGNRdHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6885
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

Hi Heinrich,

On 2/25/26 7:23 AM, Heinrich Schuchardt wrote:
> Symbol CONFIG_INTEL_PMC does not exist.
> Don't select it.
> 

Fixes: 1fc541931461 ("x86: apl: Add Kconfig and Makefile")

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
