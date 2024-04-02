Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 041D9C6FD1F
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 11:26:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78613880FB;
	Tue,  2 Apr 2024 13:26:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="CQDOfUxW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3ADD888094; Tue,  2 Apr 2024 13:26:13 +0200 (CEST)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on070f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::70f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1062988118
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 13:26:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXjjObOn91Dzfs/tVYen1RsQpB9UIvJBKNDfUUawHQbDk4nLuBUSfP/y4AGBLBJ0WLWSziZXnTH4FgaOY2KT7XARywOhrkiAESmldQZJ8PwQsvocMlTIsLEO9xbCJNYHt4G/buDY+OB9aMti/kRptmSqoF6YPJQa7d4uVwktBMBGlJjFVmrAWlDjSllvrbIF4ozLez4S/y4Rn9DVF984lr0H5xjK2Xbt2tfZTSOeVX2L19a4VtyJRs1YKbJ5eZ1+QsookIGfXcSE95Ng9zY4gjblhkdZzjL4Bs3OiCljTHHIRKJw3VXYwQv5K8vNpIAJVn5dCU/3Y3W2irsX6rxqkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFVIe2lj7AYaTSO7sm+5dqmUqcqemlf6wAMC2njA1lU=;
 b=GMGKOk5AkpsN0fAuPeGBf7MZJXCiItZcg9E/TZWn15aMnh6/WUwGbZoyRZCguNkiX/2gTnAKsua6dCrL+9/DgnQrmej6dKP73aO7mxb6efE5PHvGrDsfkhTpWkFAd7oT3dLt2SPy03PosMnza90SUDF6gryiLVw66lJd2J9cSSgBs0OBEKfJj8KulxYFZtLO6sL8IaJwWqk3NpNPqj+vVOkYlBZa6YuKZmOH5pPMekG1cLI4un7KTxgg3Um4tN+9O/DOgfeA1QLr5vnfsg6UYB3DISUp5tLwlCBP/3gTNDs96ZpmYcWZgkI8eHP60GUapcHlrkjF+glryu2WjlbJrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFVIe2lj7AYaTSO7sm+5dqmUqcqemlf6wAMC2njA1lU=;
 b=CQDOfUxW5tBlmGiqTbSIpWx3j6zmimUxIIKXUTIZdmFvU/QdGpm6gUulASMPhhNsX0mbcVjSCSej42p0OKx5wJphcABQuhhkzMn4NyXEF+XqkCKcDwiLFMV8WRoWMvO9ZWJkfchqdeWeK7NMMQp1jkxXbOx1/ZOVvSBxATovx/tc7kh6NKwQa/mM3q2b4tAPszLaEDBHxe0Y5xG7cnodDpdw1AjtRSRyv03TFLvdnWeyaU+aZb32Tgb6cG9R4y1R0XE9IQ+cwGg1mMhRqo3Vg707OzCnXXaWe7aDSY0GXrGXe1yCaxFhgztB1ytreanlyhB+CuSc7ASbUhFz4Bk8PA==
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by DBAPR04MB7430.eurprd04.prod.outlook.com (2603:10a6:10:1aa::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 11:26:07 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 11:26:07 +0000
Message-ID: <60726dc4-4952-4e60-bdf1-f5e14cacf0ff@theobroma-systems.com>
Date: Tue, 2 Apr 2024 13:26:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] net: dw_eth_qos: Add missing \n in error messages.
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Ley Foon Tan
 <leyfoon.tan@starfivetech.com>, Marek Vasut <marex@denx.de>,
 Elmar Psilog <epsi@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de
References: <20240402083934.42733-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240402083934.42733-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0024.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::18) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|DBAPR04MB7430:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: axe9a5OP1xzVXZUPTt71bPqYBIAEEhck2ogZCtEhH8N+zRJutnG2ZMAi1l5VQA+Wp8vWDiuDvS0tmdN3ujh+sSgf3c8SSAYd4Ds0FiTjTl5qZcBmCZ5497+z2axxPSooNhRG24zQNrcLhUmPB9Dl3K7sMin20sKxDYpBBbaNJzhjmbdXl0SV0nDSIe0OX0KvtGhzyb59j779446KwnO2A75UaS04XaP1FMbXdLRjsTdve/NoD61HKEXVQzLcRLRMqdxrQRdMkg0jHGcGo2PvYR4ShpwyIaD8lbnIhZh49AOr75+SRu3kRH85NLsjz2EmVdoOF+oG6J1GCsxXq1J65HBNSfFheJ0w0Y52lKNMTwEgzqLHRTJ/mzkdKStJGS35dI6EwB3aKMd6Cvh3waa+fBf725AA4ksKOeY0wv/TADxzXU5pSvJ6f9dQJjy9MEzJteYDCH9z1pH5vnk2Jjh+g6B/+JYFOUBJ8FjRdXpL4KCL2q1wAQct8ITwQWrrLxSk9FkAX1Iv8LCej4+1ojCe6ORT9WxA6rFO/VnVj/8ceq3YaGVWO0CTOxvCJPJcd4psv8nkr3ysUAsa5tq5HQ2/vFvxjSiv/v9XlxCsmrKAX01weFi9dNq5RBiz4tpawr6rlYR039bSJkZkqYQfg8K3cSVMAUf8zHGNUvptnUCC9tw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(7416005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3ovVDBxdUhiOHJ2Z3ord2NqNllpaXlyUU0zcDZacXNBaE85MGhQbEFLc0tk?=
 =?utf-8?B?SVM3SlRKWW1Vb0R5aTF5WVNLcGwrQURDWEhQZ29pRGJqcG9ocWNoUTR1Zktu?=
 =?utf-8?B?MDg2d09hWTlEK240cGM4dkw0N0NPUXZrU1Zubjh2UGE4eW50N3VsWU9xT2pK?=
 =?utf-8?B?b3BkQlh2UU5lRHZOdFkwbVhoY0JZbHVLKzNJQjA3c2NQVlU4OUdPcGZ6RHJL?=
 =?utf-8?B?Tkw3SGFGK0syT2k3c0phY3RMdzFOL20yUTg2bGlUZ0Z2VGwyK3ZvcWVTdXFa?=
 =?utf-8?B?ZkUyUk5RMjAxeDl5OHkzRjd4MUpMVnROVklwWEFQdG9nK3diSkQ0WlYxbVlr?=
 =?utf-8?B?TWZEZ09YdDJEVkNEWGRJVyt0RWJMWnYreU1rV0RmT050NnpibFJ4OVFlS05N?=
 =?utf-8?B?UDVWSUM0a0E3bDVBcWNmbUxuR2hWL0c5ZjZ1SDd0VjRYUTE3bmxUWXFiN0Fs?=
 =?utf-8?B?blV5emxsc2h2emU2V2RHWmJ4QWt5ZGxpQ1grSmYwR2ZnbUZiRjNTK3ZEeEVw?=
 =?utf-8?B?WTJ4S25wSGFvelhqNHBFUjc1d2VRRHk3cS9JNzl4VSsyc3hwUlpseTcybVow?=
 =?utf-8?B?ZXBuMEFKeFQ1Sk9tQVhTTkpyaGhLcTNibkNCM1h0OG1kWGYxWFBYd2lnYzRR?=
 =?utf-8?B?ZDZFdVpyV3RNRnVWMU0rQW1IYnEwdVdoZlBPeXlKQ1FxZnNNcGIvSDRqYTdz?=
 =?utf-8?B?U0ZOMEVYSVFDT2M0Zk50ZVNlN0VST0wvMFdDN2tSU0t3SVBwa1p2NldMWGtk?=
 =?utf-8?B?NlllTVc5Y0V1aTNGZVVkbXkyTldxdlVJRG1Hall1Yzh4YzZSdFZIT3JVdGdY?=
 =?utf-8?B?U2syYkRNMFBkREhQTldnSE9WRVc2SWlpVklOcFNvbU9yUVk4T3Y1WU1Fd204?=
 =?utf-8?B?dEFqZVVUbzhZMHN6ZWo5WUovOUhrN3ZvV0N4ZUdBOVlYY2MvUE1sT2trWVYx?=
 =?utf-8?B?M3R6ZzVvT3Z2RXNtZEN3ZHJPK3BWdlhFNjFEYitPV2pmREFHcHN1K0llVlgr?=
 =?utf-8?B?MmFvaWJkRmFhM2JDdjh0cE1tdXY2b3gxYTQ0elcwOVYxaXVob2JCWllNbkh5?=
 =?utf-8?B?WllQQlh4bVdRSll0RjNYd2RYNXhHSm9GSDk3RXhQckFKUEE2US9OMXMvbk15?=
 =?utf-8?B?U3E2ZmRteDlwYlFjdEF6Y2l4ZTlMekZYdEUzUWRYeWdFQjhMVTJiV3lXRDJ4?=
 =?utf-8?B?dy9leWFvb1AzWjZkVnhFbjVTbHg4cXlVWWFZV2hRcm9IOFJYMFdiLzhveW1l?=
 =?utf-8?B?WHNsRFpCZmRMKzZHa1lDejZRTUlKS0J3NHpyNlZpZURYWXhab08vMHYrVDZo?=
 =?utf-8?B?U3lQZGhyL1FRSFVqSFp1bzM1ZUt2UDNyZ3Nkbms2U09sSFJ1cEVCRTQ5dExN?=
 =?utf-8?B?NjlSOXREaHR0QWFpMVhhbGNDTFpXNnozdWx1b0hiN2p2ZXYvaXdSOXNwNEox?=
 =?utf-8?B?Q2VkMzg3b2k3dUFpQkUwd0VwdUZVMGxLRDM3WXJoNy9TWTJBQWo1K2V2NXMz?=
 =?utf-8?B?aDhQNWJSd25jRFkwUWxWa29VOXBvbEtISHVpY3Rzd1NDWUVZK0c2VUp3TVJv?=
 =?utf-8?B?Q2pmL01CMU1uVEtqaEN4Z3RJd3o5K21RVUNPWThDWW9sVzVvYTNUMkdBUzRv?=
 =?utf-8?B?ZnJyZC8yalU3bkxDZTRQOFZJbDZGbGRJd3lkR1R1SXFUYUlRQjVOTVZqQWNt?=
 =?utf-8?B?MTBleWY0SGFvekhhSnM3TFh0b3JRUW1ibnFBUHZXbEhvYk5ldUdod1VSNUxC?=
 =?utf-8?B?b3R1RUdFTUd4NVdwY1hQTk9MTFJNalVESDJFcnJpRncyQ3VyTUpuQ3p2RTlP?=
 =?utf-8?B?WDVlWTVBZDhXcFlHa3BtMUNMcjRoSUk5MUZtSkV0WHd5VVdXQ0hueDdqS25O?=
 =?utf-8?B?V21SVDA4YmJ5WjV6TXFNNU5LQjB6cm1hR3lXbzkwbCtUeHpzTXBHQU5MV0lL?=
 =?utf-8?B?cVhLR2ROVC9HUitaTWFTZEpvR3RIbG94S1YzT1F1bzhtMW5UYzNaWGVxVHgv?=
 =?utf-8?B?MlZaZ3MxK09ZL0NNYTBSQy9Vc3pZdHVwaWlvM05ZbC8rNWNZTFRESnpEaG4x?=
 =?utf-8?B?V25HTjVqK01UR0EzSDF3L1h6Z3dxRWhIeDR5ZFZWYy9pMGpaandGU041SXVj?=
 =?utf-8?B?KzF6Y2k0NjdJTHViU205MmVLYVZDVVJaVDVHd1BQK1lwQnVZSjVRblB6ZW1Y?=
 =?utf-8?Q?SVIFmDjv/oteXLrE6yugDnQ=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc12080-7011-4a25-4176-08dc5307b09d
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 11:26:07.5699 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VojqhzAHSRhqj4q5IoDM7MIA4dfFSO35gKT6u+uBtQDhVtXUzse9Tr43NXjlbarL2/5xJEWgWZcqXhnZCtJAzAqUETbvmEtE0fCs+YsfZj8agUjAnzVb6SWKdnAbk8Cf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7430
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

On 4/2/24 10:39, Heinrich Schuchardt wrote:
> Missing line-feeds in error messages lead to output like:
> 
>      phy_startup() failed: -110FAILED: -110=>
> 
> Output like the following is much easier to read:
> 
>      phy_startup() failed: -110
>      FAILED: -110
>      =>
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>   drivers/net/dwc_eth_qos.c | 108 +++++++++++++++++++-------------------
>   1 file changed, 54 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
> index 9b3bce1dc87..1b4d0eda887 100644
> --- a/drivers/net/dwc_eth_qos.c
> +++ b/drivers/net/dwc_eth_qos.c
> @@ -159,7 +159,7 @@ static int eqos_mdio_read(struct mii_dev *bus, int mdio_addr, int mdio_devad,
>   
>   	ret = eqos_mdio_wait_idle(eqos);
>   	if (ret) {
> -		pr_err("MDIO not idle at entry");
> +		pr_err("MDIO not idle at entry\n");

What about using this as an opportunity to migrate to dev_err? 
(considering there are two GMAC controllers on RK3588(s), this would 
help identify which has an issue :) ).

Cheers,
Quentin
