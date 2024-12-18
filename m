Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C88DE77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 17:24:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D558780269;
	Wed, 18 Dec 2024 18:24:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="cbDjXHl4";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cbDjXHl4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A6CE80274; Wed, 18 Dec 2024 18:24:04 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::609])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B560A80241
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 18:24:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Harrison.Mutai@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=qQ0JMdGVOQh6bqLNXNR65Szm6jDonIt/cXIUhYVV1OV7BVa2TY1ijNK3MTI7NyRE/oZdoOBDpIQYmAMxiPPa34bgqVQSmnMCrH/RicIvfwV170SFxik/caeSBXedG4TXJY8ruBn9L+q8JJ66jvoxK72eQQpkhwv+TYKSm69eAmb2/vSM3crwQ2n52I7SEW6YAAOe4Wzm8dpicaUFN05dB4rM1N0VHNdmYdce6DRJw2NbZF/QPxCvYuxLkxeRpTS0nsGa2vMdJakiK3s10J3xZqi8ZH1BJbj3zNhMjE/C2gIRhkQ8g91Dybxd/m4s3bXSNc+oIhX3rArE/guH9CxYfQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hkv+87bvnmtTEzZ/PuZR+LYAT6+LcFJJ37S+6g/JGck=;
 b=bdKr8eXAlk/rUXLT25BxkwPdtoJA1LWqLQIj07YQ9Iyu/v3iA8XDhsHkD3q6SucW6WZVT9AW6equc9bkA5FIOCogmeyZbL8eF62ly8c+y3dMUYbvGHMRI0m7ljom5j4MMIRMrN4SrpIsZQmO/h/WSllOfD0UcZHrl87Tz3oK/xkRth/jf1F/SSQG4teTrpdkl5nDwjV6aHHnmsdMDOqbu2YYgW0JEK0qzMfD+1JT6OrczpD4MJMV2OkHHy7KZkxmkkRzLHTIbkS2Bp7YY8UObHUv9UuFpz1GOjfppiepVh19RfyVsL+BdwnPlDKLauBU+oVW22jc8zvQkY91FEi0pQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hkv+87bvnmtTEzZ/PuZR+LYAT6+LcFJJ37S+6g/JGck=;
 b=cbDjXHl4ReuW6lsYZLRJztT/akRmF11gIRc4EJbGdMD9khoU/RiSS/jkzHvjOh6DY4r5fjqa+asgU4a6wSRGERnSF7KGQx6u1mdAXVJWbICM330WuD73Ta5a2p9MCw7GxJ+4QgpMNwpeVnMm06/xQbyNU3gY7ohp3FwZgYiWNjE=
Received: from DU2PR04CA0214.eurprd04.prod.outlook.com (2603:10a6:10:2b1::9)
 by AS8PR08MB7353.eurprd08.prod.outlook.com (2603:10a6:20b:444::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 17:23:59 +0000
Received: from DU6PEPF00009525.eurprd02.prod.outlook.com
 (2603:10a6:10:2b1:cafe::50) by DU2PR04CA0214.outlook.office365.com
 (2603:10a6:10:2b1::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Wed,
 18 Dec 2024 17:23:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU6PEPF00009525.mail.protection.outlook.com (10.167.8.6) with
 Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via
 Frontend Transport; Wed, 18 Dec 2024 17:23:58 +0000
Received: ("Tessian outbound 867970499bdc:v528");
 Wed, 18 Dec 2024 17:23:58 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: db0218a24b55b883
X-TessianGatewayMetadata: 4kz7VC69dtMC77BGMeuJU2wl6SeL0y1TsRocugRXlPowo19IODbXGuBDPi6NUfMtLLZLLu7t2mIJvgrO4AfdfvjBWekLiKVv0sUaRA2fsu0fufiLDZYzMUd+oYSYMl1sBgJy31QiEUHDhgzbpMdnQZTOJ84OlZnMkfxaZGh7U60=
X-CR-MTA-TID: 64aa7808
Received: from L94be0c378eb6.2
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 23D280B1-69C6-4C30-9840-4BD85A390B17.1; 
 Wed, 18 Dec 2024 17:23:51 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id
 L94be0c378eb6.2 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 18 Dec 2024 17:23:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vPmXE3KC9zflilwzhRp3v0UHmTfW2X909uVzI6yl3KdiI/7Lj67ggy7E6xmv7seFfsHvOcrzr0ybjXp8YJwx0pw1d5pNmTuA+fau8ep2peoBzx1TkejBbJEl/PKEhfdpaZgoWaaDlu8Z/rJUjqNpFlglHY9ept5uNsV9j5r9tdQKAJw1Fj+NMsqLvPS7lx/qEg7JZneqNuGU6PTlKe3jHyk2Z9wlr/IPhegY6GhMJY3DSxMqFEQA1ogV2SpD2nvsiPEo/zMo3uuBw9EzqUPeCW2O+HCrfyXixwgsZcwlF3dYW1OtroWq6fYCpUlmuj6BWzfenEdKoGxEvytO4ty64A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hkv+87bvnmtTEzZ/PuZR+LYAT6+LcFJJ37S+6g/JGck=;
 b=MRkSwGeRXlY89XG7FmcF3c2vsF7DhxKsS1pwh5UhsF+FjyI0lo/dnlEg9N5b418JO/2ti51PJTaouFThxlImX5dgfzJzobwTOG6eZlHhMQC9v0Ru4EA49Xpzf8RGRstrw20eIG56vxmaB6+s2UHFBG+O69v6Oo4AivrMhroMP4C1wVZR6Xkk+eygAMRLEpbM/MPjSu3gDgF85RPHfKS0/zM1/I7boMD5IT5id1P9617ABEF82X3z63Z/SF/F2rF1S0qzl3PQlrwORr5utKlHYuodjMiFOmBQYNOns1rjeHoKRAbdDEU1T7MDc3rep+lGLQh5BTDwXpIfVxkCJGrNSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hkv+87bvnmtTEzZ/PuZR+LYAT6+LcFJJ37S+6g/JGck=;
 b=cbDjXHl4ReuW6lsYZLRJztT/akRmF11gIRc4EJbGdMD9khoU/RiSS/jkzHvjOh6DY4r5fjqa+asgU4a6wSRGERnSF7KGQx6u1mdAXVJWbICM330WuD73Ta5a2p9MCw7GxJ+4QgpMNwpeVnMm06/xQbyNU3gY7ohp3FwZgYiWNjE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DU4PR08MB11188.eurprd08.prod.outlook.com (2603:10a6:10:571::11)
 by AM9PR08MB6081.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 17:23:49 +0000
Received: from DU4PR08MB11188.eurprd08.prod.outlook.com
 ([fe80::5926:9f0b:ea5d:24df]) by DU4PR08MB11188.eurprd08.prod.outlook.com
 ([fe80::5926:9f0b:ea5d:24df%6]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 17:23:49 +0000
Message-ID: <a41a8559-689f-49fa-a19a-2b1f8c4c62ba@arm.com>
Date: Wed, 18 Dec 2024 17:23:48 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] bloblist: fix typo in code comments
To: Tom Rini <trini@konsulko.com>
Cc: nd@arm.com, andre.przywara@arm.com, manish.pandey2@arm.com,
 u-boot@lists.denx.de
References: <20241218153933.37649-1-harrison.mutai@arm.com>
 <20241218153933.37649-2-harrison.mutai@arm.com>
 <20241218154803.GE1505244@bill-the-cat>
Content-Language: en-GB
From: Harrison Mutai <harrison.mutai@arm.com>
In-Reply-To: <20241218154803.GE1505244@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0059.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::23) To DU4PR08MB11188.eurprd08.prod.outlook.com
 (2603:10a6:10:571::11)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DU4PR08MB11188:EE_|AM9PR08MB6081:EE_|DU6PEPF00009525:EE_|AS8PR08MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: c14d78b3-545d-4814-acff-08dd1f88c209
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?Z2I0b25FYlNkaWhiUHRNSnpkS0RCaFNNbXRXOTBydUpDVGg1U0dVcjhVV045?=
 =?utf-8?B?dnJNVEZYSDBJbXJOc1JIVVJwSWsycFQwRUxWM0NzTnBjV2NwRzA1Yy9QejhB?=
 =?utf-8?B?cCtKSmNndzdldUgvMURsNGE3T1pyVjRRNk15Qk5CMjJ0QUlIbXlPbjRERWZ4?=
 =?utf-8?B?THNYOXNJdUltOUFCeFNWdDdoczNNa2ZaMnJ3OStuQngrTVcwdjRhV01QNnV6?=
 =?utf-8?B?ZXdzeWwyZ1NnTmxySUw2Qnp6K09CNGp3SlM4VW9GUUNsd0ZLTTNTRys5OEY1?=
 =?utf-8?B?c3pQOXJjQmVoRThyV1R5LzVtUFArM1pMcU85eWh6RnVlbWNsa2hIcWtPYkFH?=
 =?utf-8?B?dUg3T1dIdHQ1VzdqdXEybDJpeTduU2ZnMzgwTU80WHYzcW15SUlEcEU0T2lh?=
 =?utf-8?B?alhiWW5UaWxVWUJLaVBjSnBsbEIrYm02UkFabEljYXJ4K0NlbXBhYURNSkFo?=
 =?utf-8?B?NFl5dEl1R3pQSGZ1YkhtOUtnZlpqYkIzY1hLRVhoV0tuTG45SnZ6OWo2eVVG?=
 =?utf-8?B?NWR1L2FubWdZbFp2T01QdWxGeVFlSXNrTFVwZ3B0K3ltQkpIYzlBbXdFMzhU?=
 =?utf-8?B?U1ZjSGJBeE12c01xcDczamszdXNEbExnaXhkSjFtbTc2eVN6NGFveHRSaUNt?=
 =?utf-8?B?YlRNKzBnR01lbTFiaXErWFNEUXgralVWeVkzUFB0L1NwYmVWTDNnV1N1Zitq?=
 =?utf-8?B?VEpydnV5S3pTdGhrNktvQTJaS0Fjc2JXbXgvdzdQdFZLeFNLSWE0YkF2dGVM?=
 =?utf-8?B?MzNVTGhlZGV1ZmZ4VmV0aDZyeXdnMXNwV0lvZ21lSHFURFlFUkZ6cXJ6NHR5?=
 =?utf-8?B?azdzWkgvVHRlczRPWFgwRTB6ZFRNc1g5cDdNM1VKVGxObUhLMzlTMlY1QjFQ?=
 =?utf-8?B?bFJ5ZkJGTkdaWnFKMklDSXpsNVNHSUdwa0cwVGcvSEUwOTFVby9IUmJFcmlk?=
 =?utf-8?B?Vm84RmRXY0tmclFFWGdjcTZFS2JTdC9lczhRK2s4UkhjZW5XeWU1TkIvVzNU?=
 =?utf-8?B?UTFDVGh1ZWkzYlBjMkFVaWFUekVhZ2pDd1o5UEgxT3ZRbzhPRXNIaGJIRnAr?=
 =?utf-8?B?YllZVzRxN3Q2NFM3ME5zU0tSMlZDOUVQcVQ2QkVNaVpIcjNKZ1FXQTYxNGkr?=
 =?utf-8?B?L3ZnZjY0YkEvVldLS3I5ZFF1bFlqNlIvN0tNWWhrTlhUUEJCWWROWTZrRlRo?=
 =?utf-8?B?amIxSU1uSHdTcGE2ZWtQVFE5djJIblRZRi9qWjlIQTdxdUVkd2tmcVJmWlpM?=
 =?utf-8?B?L0Ura1hyNzRLdElkQzRieDFNdmtxN3NFY0VJMDNCaXRCSjl2VWpiNGpxUkRt?=
 =?utf-8?B?ZWxITGd6YndwZmJEZkhreXc1dnZZcUlVbGZNNVJsc0IvR29vSE5OOFk1L0VJ?=
 =?utf-8?B?Y2oyWmZDdW5paXM3Q2Q2ellBZzgxNlk0UnBaTG1kdmQ1U3F5dW43MTZtR0ds?=
 =?utf-8?B?SmhZZm9JemRqQStrcU9tYXo4SEl1QS9BUlNJdXRLWCtsalBObHNjVlN6Nmx5?=
 =?utf-8?B?ZmdSTmlNU0dYa3Y0MDVsWnhySS9zbndJSXU4Wms4cWZwSFgxV2xMRGI5cVlU?=
 =?utf-8?B?THZiVzVqY1dIRkc0M3krZTQzaGkwSzNacDg5VURocmhKRWhSU1h2WjRNKzRk?=
 =?utf-8?B?UW1QdEd3Y0JoVkhEWjhzS2IzcVkzV3Bka2lWTGhDWDlITlZhd0dPQ2t0N0xK?=
 =?utf-8?B?OUhDTWxiUU1NT2NrVkN1WGZiL2NsMzVBL2VONlhYQjNyNmdZTjdRQ1FNRkNk?=
 =?utf-8?B?d2pERkZTQ1hjcWRvYTczeTRXVUpzR0JCb1cvSUFubnRnUkh1S3ZPMzkrTGdQ?=
 =?utf-8?B?Rmpnd3l0blZhOE1WZzJ3cGZkSG1WKzA2RVo4ZGhmWXRUNnB4K3Jhd09ETjFV?=
 =?utf-8?Q?gqDLDyaka3B2i?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DU4PR08MB11188.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6081
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[2603:10a6:10:571::11];
 domain=DU4PR08MB11188.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF00009525.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3901f2ab-34a5-4ee2-d903-08dd1f88bc66
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|82310400026|14060799003|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WEpGZGY2N2d4SkJBOHp6dmZ1OGN3bzcrcnI4UkxGMVRhYzZTTmI3Yi9HKzgr?=
 =?utf-8?B?VzV5emhvanA1L3BYWWZHSTlNa3VlVW1UQmFuSEtCNGVQK3ZhOTBKbFZkNzRO?=
 =?utf-8?B?cXo5enZhdmRXWndVWGJ3dGY4Tm1jdlVZeVdPYncwaHdGbVcvOEc3SWw1bElx?=
 =?utf-8?B?UEFVaFZkcllKVVQ1cXJhLzBzS0hqaC9iTGRmTTVEZ3NSV3JQc1Yxd05KeHkr?=
 =?utf-8?B?UVBhZzBRWVFKY3NpUHZLaUx4MExCOGZnd0s3eERMLzZ3WUlpblhXT2FrZXBk?=
 =?utf-8?B?WWxZaTVGTUl2VndMN01xbUpES2dBTHhWeERIUnJNZ1BmY2RBTk9IR0xXaDhS?=
 =?utf-8?B?TWFOQzAwK2J2UW9KNXFIaFNKUGhWdG8wT2pqQ0dIL2lHL1RZaTJ4SjZ4UC9w?=
 =?utf-8?B?MmVTcDVhTVFGamNKaHVDQ2NQNnRhMXVhMExreEpzQWZUWGkzQzF0aCt1TFJP?=
 =?utf-8?B?VDk1RFhqUEZueFVpZkF1Q0xBeEt5RG5mWm5oVTQyeTI4M3Y5ZGp4c0kySjBQ?=
 =?utf-8?B?UzAzYjd4WWFLN3ZQZ056NGtUbmdMV1QyVkJGRnVxSzZCLzdZcHg5b3NvSUNp?=
 =?utf-8?B?VDRvWHdxYldnSWxGZk5OMzZYZEtOVjBZSGxiNW1IVEh2cTlIMEx2WjVsUm9n?=
 =?utf-8?B?bjh2SnByYU5SdUtORGZtRHEvOTR3ekJLeTM1U1ZXVU5TSXpRbnJLd1R1N2do?=
 =?utf-8?B?SmJ1UzVqYkFkaUZzeWorOVBhTVZBNlkzbUtYT0l1VldES1lZVElMcE1IT0Rk?=
 =?utf-8?B?eDNZM2ZMYzZNWURub3BzNlpnWlRibU9oM1RiT21HcEJVd2xvcHdSemVWZTgy?=
 =?utf-8?B?RnE4RytBbkZEMjFDVEJtL3Awb3pSQmtvWDRYWGx5M2pGOFZtUFZZclF6ckJW?=
 =?utf-8?B?ZFR5bjV0eHpWYjVmdEljUTl6cFB3MlEvcEpDVVJSOXFpR0EycmtQYXFXdWtB?=
 =?utf-8?B?bXlNelVEc1RWNCtrczR3d1A4TGJUZWxETDJua1EvRGNwcXl2cXhsVEl4Wjdl?=
 =?utf-8?B?ZTh0YWVTS01OdWtEZi8wMkVEcWZTcmdlZG4ya1FqWUljeU0zTERFc1NsWVp4?=
 =?utf-8?B?TThsMnRyN0RMSXhIckM2cDR3d3ZoSHc3NkN5c29kbHYwOGxock5BbmVBQjZn?=
 =?utf-8?B?aXNLczFXQ1BSMEUwd0pIQmZTYkxvalBRbUw2MVVwOW1WSi93UjJiOEJNNFY2?=
 =?utf-8?B?SGd2d1ZvYWY1aFB5WTBGc0J1ZEFlOU13MUlUeW94MnE0NE5BVG1RcUJBVHVm?=
 =?utf-8?B?cXdrbnBCVWkyV3M3dE1jdForTmptUEUybkhNTjEwc0wxQnFKOTkrWkE2S2hB?=
 =?utf-8?B?MEVablFJd05zbFNiL1c4K0FOcGhIb25jUjNyQ1Vpd2V5MjBud0JFeG1zZVBH?=
 =?utf-8?B?ZFVaUit3bkR1T3g3dlhuT1R3UXZ1d1hScGN6TjliM3dpT2g1RUprV3k0QXVz?=
 =?utf-8?B?dkg2dFBvNUZvanNYcFc3Vk5jVnVYdURqQ1ZnaFN2MjQwQkg1clJ1TWJzd2NO?=
 =?utf-8?B?REU3YTdJRDEvRC82eGtFM0dxZzFodmIrQ1NKMnFDNmRSdVNaSUxERnRnbXhs?=
 =?utf-8?B?cE1XMzBCWW5LeUUvdjhmYjRpWEU5aHRPRmVVdW43M3M3ZGgzU3pCTWF0VWU1?=
 =?utf-8?B?OE9hb0REZHRYNmFybTc3UGM5ZCtwVWszWURCckNYMzliYXkzYkg0TisyWWtz?=
 =?utf-8?B?cC85eHJ6K2cwNVUwUWxucnFkQWQ5TFhxVTcyYWtkcG9ndDV5ckx4UnBibldZ?=
 =?utf-8?B?bHl1UjR5TDBucUVIK3k4YXdSaDFNL3hsRlJBTnJYL3ZWNjdPSlFZOStGVUh5?=
 =?utf-8?B?U1JBL3p5dms1WjVqQjBaZldzK2dPUWVyU2VkSHlxSzF1anNqcThJNjlWTXBa?=
 =?utf-8?B?djhWOWJESFNnRVFHZFJNMVhhTFVadzY4T29sNnJvSktHMWo3a1BXZnRZOFM3?=
 =?utf-8?B?WDAweisyd1dVcXdQY1FIQzdGM1FYQVJVcHRoRXEySVlLaGZOcDlXcmZLLzVV?=
 =?utf-8?Q?nFmxYaz6Z2uvNCtPDzk1unj8HOP+X4=3D?=
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:64aa7808-outbound-1.mta.getcheckrecipient.com; CAT:NONE;
 SFS:(13230040)(35042699022)(82310400026)(14060799003)(376014)(1800799024)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 17:23:58.7905 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c14d78b3-545d-4814-acff-08dd1f88c209
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009525.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7353
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

Hi Tom,

Thanks for reviewing.

On 18/12/2024 15:48, Tom Rini wrote:
> On Wed, Dec 18, 2024 at 03:39:28PM +0000, Harrison Mutai wrote:
> 
>> Signed-off-by: Harrison Mutai <harrison.mutai@arm.com>
>> ---
>>   common/Kconfig     | 2 +-
>>   include/bloblist.h | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> Please add a short commit message body "Fix the two typos in ...",
> thanks. With that:
> 
Ack - will add in next revision.

> Reviewed-by: Tom Rini <trini@konsulko.com>
> 

I realized I made an error when posting the series and accidentally left 
out the cover letter. Would it be best to send an updated version (v2) 
to the mailing list to include the missing cover letter?

All the best,
Harrison
