Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 226DEC624C6
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 09:28:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C75E883E63;
	Mon,  2 Mar 2026 10:28:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="gGqnTS9m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD26583CDF; Mon,  2 Mar 2026 10:27:59 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FFA883CDF
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 10:27:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q94CdrebPh0YUhtg9VKXlYEEyizkyXNeyickbhZNINxUUxAWZ5xqYo2vjm/QNeHBW+kmn+zDt+1q7iQX07F8sKi2Ve1aFrDLjPBH4wKtg4Gjz/CLN1OctaKEjM7r66TETRNUSxHqPzif8UZZLZHWfE9umZ2iITSQQ76jwy5dEBFX1H0s86YT+k3aqOrPXX3C9E8PRdT6/2cUNy7CdMyYTkv4nO/kY7bsDQyynmZeQ+OHaJlJ9JiOcAOrPMs4T32wqN9aKrjvoZ3oq7OQYVERz0z163qwRBU1vAnKJ6JmRjRbYLR+Egb9TxWABFrFK6TZmYRAutICRBlLi6xXaqYO7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndQ2xjBX+rUhzHBZWb/i7FegoUOz4OzHNn3sh/yMz7c=;
 b=Q83W3CkWpGU5t2Fb2fcxOKEuicJ2rgliFTXrZX6TXDRsdYGA7VqQ7z9kttbBPJdyy6hz5+dIKaaAOc4wRnM4yVcz8vKiygW8o/BX+rQV7R7bgPo6t4fIOLORiZMTqrJ/SVr60FCAnSQSTOO7C7zbxZ2YQ/cZH8EGy0DFxcYX9aBiGPG2Ybrf1uGBWAKTbIJL1P1baQdu9YIvL9bfJcT0Mo5YraszUh8BusNtQnmYVYKqjxJyAgGC/x49rnZhJTctkaT1Ts1JW9Stf8uMGaHtAmKcw46NA+kLSHGwRfV03DZPKPXl6qFTFnwoXNTOkL9JCrxivkx8pQ07oSzRORayWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndQ2xjBX+rUhzHBZWb/i7FegoUOz4OzHNn3sh/yMz7c=;
 b=gGqnTS9mkMIQISpWpRa3Hx3Vy9KnkpHBvKd7VrSOdaNYkSeIpb/Pd3y0zMcCl/H1Hqj/s9tsl8wKN1qcVqMIj7ghl196w0U9FBSxdJpKRx+7qGNzCMpVtcBqerrphLn0WpUKM5mvIRehSIpJ8cyp07Fek+IQXyhd1YJeWmv3nq4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PA1PR04MB12200.eurprd04.prod.outlook.com (2603:10a6:102:560::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 09:27:55 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%5]) with mapi id 15.20.9654.015; Mon, 2 Mar 2026
 09:27:54 +0000
Message-ID: <b40a1260-81dd-4591-ae15-0b6f6c95c972@cherry.de>
Date: Mon, 2 Mar 2026 10:27:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] rsa: fix incorrect positive EINVAL in
 padding_pss_verify()
To: Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Shiji Yang <yangshiji66@outlook.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Anton Moryakov <ant.v.moryakov@gmail.com>
References: <20260228085121.3355465-1-aristo.chen@canonical.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260228085121.3355465-1-aristo.chen@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0234.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::18) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PA1PR04MB12200:EE_
X-MS-Office365-Filtering-Correlation-Id: c6150aa0-95fc-4f62-ec30-08de783dfbdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: /IapTRzmI/uWKvCJf8UXz8EhrtqGE0Be7i7w44dDK7q6c1y3ifM/gzUdECSfkCnz0wbkrojBsgEpLgmU/spe5NI1wC0yYnELHXkMMRgLNprXUiJqUocpfk5wot+O+QiIHxKupV9IP5/IJGdygQn5WxxtN2S7ey1UT8rUJKKzu3m64IMn7+5TXWfyj1UdSIEGHYPSg/CQQ2ngGQhBFPQ+Jziqmy+sdw96iwxGtP8xxm1lu4PU4Gr3CBbAAcCOfRn8prnQ7IOjRPTVKWjM5tFEG9bIWOcZqi5R8AmsqOt/Ncvz5VG0txcEtKlyXcaNx/nUjskGmb69RFl2OJlWGdPm6jU8OgWCal0TU6Wx1nLQ+Y3iWBnqotdz/xGYfQWnkD/sRemTFhQlA2yWSHqEdPHKDvNS2AH/7w+iDzUFpAcndn8vptSG7VLWhaHf20q1qNqE4cRyh6720qvKvA4lRSNUtmLLz+MTt5F8l5UvxyycHS4rd774ZNI3fgN7akWxW510LTQHaj/sZJXzKtTwSovtMUaQlq5iF3nqD0KUpVZJpR/KsVEiUW5KPwgeqpaSEiHu2ozkwX9jAfTmbNsq/tefuLoY2dPbO/97VEJmpKBnLGMOptHluMm6WAAZjSqcXuXY7Bl8QDzGoOIpDDtym5bAEMNbMbQwj4ec68JnlGwsSdJtPuXc4SVXxkX5dc8CY/6K
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3VqSDJxL3ZscTRNQW5idzYwV0tEWWVrVm9CSHIycEFPZW0vcCtRZGlaMWdF?=
 =?utf-8?B?RWVVZG1GazZPNUlwVUFWYTlmMlBKV1VLNmZ1UFJmN2xaa2JwcU1IQWtsUGtj?=
 =?utf-8?B?RzI1YnFHY1p3ZnY5ZmE4U1l2cmpmMncxQWpZaHpFdDY3VlhYTCtId3gwN0sr?=
 =?utf-8?B?a09DM0I4SVJTUGpZY1ZCKzFZeXNESzJldFArUGxBUm50TXZLL0RWTm9qSndN?=
 =?utf-8?B?YXhzZHlFc0hlWTJJbkpWTGUvQUNkZFRqaDBzdFF4eWVUaFJHQ1NkTVpDVzFa?=
 =?utf-8?B?cG9iY00yL0ptNTB0MXFReDNzajZqWGRSMGRTa0NXQk1YM2NvaENhOEY1MkQv?=
 =?utf-8?B?R3laRXFuVVRudmJBbll3MTRMVFl3emk5RlpoV1RSVEJ6aWNiS1ozM1lISUln?=
 =?utf-8?B?b0dnSFR0NWo5ZkZBL0lvUmZwUlFnYTNPQUlaeG5VNEJGNU5zUGFOS0V3WURK?=
 =?utf-8?B?V0l6a3hnV3A3TlZVTER1WHpyWWx3NnpHclV6amJjNWh2aTBDdDUvcUY5NTFu?=
 =?utf-8?B?NStqdnNadFJJanJLSzVYQVRsRE13d0s4MWlSL01UM3F1T2Q5eVUxbGFtZXhK?=
 =?utf-8?B?c052KzZyY0hEMzc1SzZrR2RSR1BiQnNvYmdFeXRqcVRZa3FMak81ZnAyb0Zn?=
 =?utf-8?B?L3NLaHpSVGZNMVJKTUIrSEgyVmcrWElKNnJTSC9CY0VZRmRXbXBNTjRMdGhr?=
 =?utf-8?B?Q1l4K3YxTFJBZkZyRUhEbCtkSzh0enMrcjZQbE9SZ1JRTXVhMjZsV3NNczZ1?=
 =?utf-8?B?dEpPU1FQVEtGM0d3TTNtTVJ4OVNxd1FDQ0hqSkErWUtOc1RJQk96SHhscUpE?=
 =?utf-8?B?UmgyUW95cy82dGlPTUpuOStJTDNFeVZMZVVVTGtWbVp1UHZFaGRGbDJnVDU3?=
 =?utf-8?B?YXdibW5XL0xmNmNjOExoNUE0VStTRHNYS0dYTmJLZDg4eVN6T1B2bWFWNVd5?=
 =?utf-8?B?VWhpY2g4NktzWWpHeklQVzJUdDR3QkduUGtVYlU5U1hXK2hRaysvRVVLQTV1?=
 =?utf-8?B?SEZKcUhDR2JIUTlLVUkvUFVlSjNGT0MwaW9EZ1hpanRiZVQ4QjVqN0cyTlhY?=
 =?utf-8?B?UDhYQlNVMXJQN2M5dS90UFlhcTByWjNPNmszZnR0b0R0QU5GOVc4aGd0UWM4?=
 =?utf-8?B?MXovT3FOTUxKeEQ5RVU5Znl5cTQ2VFhpLzVpSEt5Uzl6VkM5cW1sakZ6ZUVr?=
 =?utf-8?B?YUNrMktBK3NRZjNXZ1Z4VkdDYndWL1BJTG9UNkwwWjVVQ0dUNGticmVGSGI3?=
 =?utf-8?B?NFppZnhXRmVIeXZzK2pmanhVbytyamlINThBK3ZpQmJtS3B1QTNQSktoc29Y?=
 =?utf-8?B?Q053Rm9WTkJBVFhtZWhsNGYwNVVmcFhBTXJzNCtMNTJmR2lVNGtPZ21VZmpU?=
 =?utf-8?B?RHlmOFU4Ymh0TjkvQW93Si9NZDFtMFlDUmFOYnMzT1dzUDB4TzRBeHh3cmg2?=
 =?utf-8?B?ZkdIWHZwTHMrZnZNNHhWcU9IMnlsRFQrWFRMUzBWVjlEMGpVVkdzVXk3ZXZa?=
 =?utf-8?B?Vm9rMXBhUzBXU29yV1Ryb0YwcTRBdVBoYmxwV1FvbjVGQ0dOT3VtaHdhT3do?=
 =?utf-8?B?VWo2Rzl4S2hlTnJFbnFmWEQzSlE3NlZ2ejREVGlLYWdKeTB2ZnVXMmJTU1FO?=
 =?utf-8?B?bHNON2czcEI4UmpEdi9iakdBSm1sQ1MyeG1Oc0EwUjBFTjVyODl0dUg5a1pN?=
 =?utf-8?B?K3VjM0tnUDg1dkx5UmswK1RYd2d0cVJRcE9KSmRGZ2ZGaXY1UzA4MEtGZTFJ?=
 =?utf-8?B?Q093NG11c0JuWEpmMXRPcDRQZ1RBM051a29jaTJBTDBvTjIrL1Z2VWlaM3JZ?=
 =?utf-8?B?d3JtWjZ5RUw1NlZnZjVMSEN4ejNtS3A4R1FIV3pEd0ovRlNod3FMRWxOUXFK?=
 =?utf-8?B?OHdibld4R3E1d1NrRjFjMFZpbnE1aHZnSWxZcVFiNEg3WDdod3RNd0tkZUlp?=
 =?utf-8?B?ekZ6aDV5Y1FnWnh5VW5JazZzellDK0pUVTBOTEo3YTRtZG9XZ3c0UHNIVkFt?=
 =?utf-8?B?UTYrVFFTUTlBMzZPbUVCYTQyZjFVYm13RHMzOG9laGZmSVp3MHBsYnd6TzhV?=
 =?utf-8?B?NTlGdVpIdzVXNFZJcHVwa3l3a3N5MkZvZlBSMHdEYjdTSHV3c2lMRS9rWERE?=
 =?utf-8?B?cUdzUXJrbytuNC9tTGhDbGFhT3JUZmpOaExUZGU1UC9lc2RBSUVybWJnSzBq?=
 =?utf-8?B?RE95UjJWNnJkT3lIN05iRi9rbFJDU0RGQmJ1LzFxelI3bkJCalZsSHFrT0VK?=
 =?utf-8?B?ZllEVG1VZGlaMnphdlpGUFhxWFVROFBjaGN6N2Y3N1JHWGo3bHlra3Jia2ZE?=
 =?utf-8?B?WmluR2ZPRXdtRmdCVXpMVVZiSEZFTWlhZEx6RkF4SDd3R2NuQ3FQQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c6150aa0-95fc-4f62-ec30-08de783dfbdb
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 09:27:54.8333 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: esulzdiGQkt2dyxMOsoDQ5lH0NVcyBIVPmhhc/Br/BjsPrGvc+/V7uVOHfHNN//FhhZvRUn8uO79L0ZSV+6NvJGjwsB1qEkXtdtThZK8paU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB12200
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

Hi Aristo,

On 2/28/26 9:50 AM, Aristo Chen wrote:
> All other error paths in padding_pss_verify() return negative error
> codes (-EINVAL, -ENOMEM), which is the same as the rest of the U-Boot
> RSA stack. The positive value is inconsistent with U-Boot's convention

It is consistent with the function doc though.

> and is a potential bug: any caller that tests (ret < 0) to detect
> failure would incorrectly treat a malformed PSS signature as a success.
> 

They would also miss an error in step 14, since memcmp returns non-zero 
(but potentially positive) return value.

There's no documentation for the crypto padding verify function pointer, 
c.f. elixir.bootlin.com/u-boot/v2026.01/source/include/image.h#L1604 so 
maybe we should be explicit that it may return >0 for an error too.

The main question is, is there anyone in our code base that is checking 
< 0 for an error?

Cheers,
Quentin
