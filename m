Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C71CA0ED1
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 08:30:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 088C1802C1;
	Mon, 18 Aug 2025 10:30:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="L8ht2Z9N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DFB4803DF; Mon, 18 Aug 2025 10:30:05 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16F6E8006D
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 10:30:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XFI9PTLeCw1b4gAIXNNZGmWCW2pIuBHxH0pyjND5jp5JrAKSoRBtzkGCBHE82RbMblF8+TQAylEi0RjMv7CXARGBpiY387QiSFMg8kPSCCNp9tvlgyebDVlTuYmW313CaEn/YUg1lDkaAJqWfO8bzqymDRcpLnJIb+Qt5wuGTSOFE3+DeRI8uGS6OjUYP26EHhhWOXnivXrtA9FQ/xvsaEd8Ae20xBGXjyEo/q0zwUlmwHIebxbJGJxYkGntYpWrVqYLiFPeh3PYKbHL6I2Y3gkS1WOByT3x1GlDBJmnXoygHvdYwtgDSfZjWjw21pX+qWeJrzqM9gBk1Msqyj3kUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwwCt6YZl608piJlaLbs0iYzj05stiwMYtaOpQQQqkU=;
 b=fw5B+TTVKf1pPCZF08vYwMyKPXcDBDwljjrYW1WWjdst8IFf6lf2fFhhdr6MtWB+EICD5GurHW49y+TlcKtHFriLpcznWqmRwaqEwJlRMC62XPDhpFTh4Ze+C6gNvlYHzLOMb7fVej2WUVrgrCDnp1c/jHTn+fTvtY2laMjM/b7w9tOK1uHcBJt8xc6LXYvGdjNoSODbnVwflD9rWywbVAO2WTktonFohiuo1HPhjEB02fmQ2tf6NP7GGKGIBCciw7GYpC52Xqt1nnZTKw9VzjJWb9DZj6GlTZU3whI2Mp71nK2McFujEa4SQvmqeCd9Jwaavn/YaoxJRQx8WPi6Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwwCt6YZl608piJlaLbs0iYzj05stiwMYtaOpQQQqkU=;
 b=L8ht2Z9NhUR+PJLctUu2DhBoquLIJh1+xQ6NzP21CIhTC3MdhgpujpdZXa3lIZj9q0io5ImxG9GmxyT/AQV4GIxl6AzZ1Qo/GOEErVqCbTt80/jZ8OKc4y+Kh/5TpZPzydR2aSDpfPR4Iz4gGI6mj6OfIfRJOUl6UkJ/1wuPDtNeWIQq3FpM+0ZcPeteOm4DDPcFK9QQqD75MGB1JtoIkRyf779D+cixunCBgsnxyU6QIDVHr+4llyIZ94FqreuvA5aE32pnX7xYv3JsDGF89zM0uaLe210o0irrGSHQ9iybEUUkOCxmiT729TjyxndO/sB51CS9FDF7DmgPnuwCIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AS8PR10MB7157.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:61f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 08:30:00 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9031.018; Mon, 18 Aug 2025
 08:29:59 +0000
Message-ID: <db522d58-66e9-464e-8224-0ebf70c415a5@kontron.de>
Date: Mon, 18 Aug 2025 10:29:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/21] mtd: nand: Add a NAND page I/O request type
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Chuanhong Guo <gch981213@gmail.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
References: <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
 <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
 <20250813234314.3945708-4-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20250813234314.3945708-4-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0365.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::8) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AS8PR10MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: da56b313-3c61-4a31-a77e-08ddde316b34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dDI3N0hTMmUzNU5PRWU0WkdETWpvcFZWTS9jMFFwOFVRK2VhdXJNYlhyU3BG?=
 =?utf-8?B?TUZrUURIYk8xbWh5V1VFTEZLYzNJQiszSlI4R3BiR3VWK0pCRi9JTWlLY0tx?=
 =?utf-8?B?TjhNUVJHWE9MSEVmcEJnQUJVcnYyaEdTMHdJcGFVWi8xcnFCYTU0Ujhaek1l?=
 =?utf-8?B?TnhGMmF4czVPaldHVGNiY21ZQ1FTLzZwY1daSVVRSmhzdkFDck9GY3B6Q2pq?=
 =?utf-8?B?V093WnExYjNWMjRjMTVLVTFleWRzWjdscHRQR09nSlJWQjdEWkJvajFOUENL?=
 =?utf-8?B?MkxNK1RyOWdCYk1RUVlrTjhuZGg1MjVvMXVBZVZBeXZSWXhIaHZPZ0JYNGh1?=
 =?utf-8?B?cGRXU2VoZE9mYkFTb3I5ajdjQWRLbkgrQVNwRGF2Wmkyd0ZQZVAzcGhETUlS?=
 =?utf-8?B?dHdnZFZyTTdQUVdvY3UvWU85YWZQN1IwaFVHK0lxZXVBUnc4R0kzRSs1cUJh?=
 =?utf-8?B?UEdIMzNVcjZRRGtidzZzY3FPK3JPVFIzVWVLUldRUVBtd0JNUUdXRGFqd25l?=
 =?utf-8?B?ZmFPdEVzeVpEYUJVRlU0VjR5UWI5eUhTL0JYbXE5ZCtzSjI0c1BZVmZyamFD?=
 =?utf-8?B?cXdldFQyR0F2VjQ4ajZDTjF3aHVkcWtJT0laUFU2OXJDSm95eHpwOFVQR0tv?=
 =?utf-8?B?V2VSeDVSRUpKSUpOZHJ3QTlDSGgvWldsQllUUi8vNEVVcGFDOExSc1pSV1RM?=
 =?utf-8?B?alhHR2ZjcFBMcXZ1YnFZOHFFMndwdVpTeWJqK2RQTDJBbVJ4NUpVMnJOOFAw?=
 =?utf-8?B?MzhZL0N5MGc0MXUxZDZaN1V4ckdPbG9lUnZaT09nSFAxMVIzMG90ZEtLMUt3?=
 =?utf-8?B?TTJmaEhJNDdFSjQ5Q3VyalltcTBBbnlOUXNNK0hyZGYrS1FLa1pkOGdqcXVF?=
 =?utf-8?B?b1kyYnZtQldOWmlrMm5pRFdyNlRPZ1BMQkl6dG5ob1NLNWRHOExHcDh5eXNk?=
 =?utf-8?B?eGdEQ042eEtSYU94azJRanl0RnBhWGtkMzlZcGlmOWZuZzk0Y0l2UDRyMlpG?=
 =?utf-8?B?M1lEMlFXUWZXQmlqd0JiblhJb2htVHNwcTV1Rllnd1RNYlBvdWpySWJtelA1?=
 =?utf-8?B?Q0pPaGd3dWRPZUU1MTY5SWpCbnVMVjd2S3Y0cXJNRHZOYVJldWpUT3gyTVho?=
 =?utf-8?B?V2l3ZnlBeWVaYjZkbit4eExZaEFoWFFGR21hdjhIUnJBVVRCZVUvNnNZcjll?=
 =?utf-8?B?MWgwUXRHN3lrSDcraXM5Yzg0MnFUOE5ZeFRmdUZZMFJOeUp6bmp1ZGJhMitC?=
 =?utf-8?B?ME1PS0JMSlVPdlkvQlpPM05kc09rZTFsSDF1R01laDF3QlpFeWFxQlZXWmxs?=
 =?utf-8?B?YXBsOEVFNlJPNzBmQlBlcUE3T2xTcXcvQmRZMk4wdWRVaENPSUVuVkgxeHY3?=
 =?utf-8?B?QlZUZlhrTnBpR2hMdnV2SHdSeXk1eFExRzU1dmh0SlZweTdJZmhKOWZCdW9r?=
 =?utf-8?B?MmNJWWZwK1lVZE10akp2Qm9FeURDUTVCMHpOS2VVczljOVFSSTA1RlgzVnJo?=
 =?utf-8?B?WSttVzNXRTA4TzB6dk0zVjlyUWYwQlZyMzNJTG50VllndVA5MHVrYWVQNTFQ?=
 =?utf-8?B?RTNuVnFvSlBqSnNQNXNFOWM2U2MyR3VZK1gweFM2U2FZemZFZVdxSjJuTnFC?=
 =?utf-8?B?aVdhZ0NTek0vT09WUGwzNXZsS1liMjJUOExPUDczaE1WWjRYeEEwaWxjR3ZT?=
 =?utf-8?B?NkNpZzh1am53MzZXMytWSW9KMzBpcElWQmlSRW5lVmd4WUNiTkMzYkJWbk5p?=
 =?utf-8?B?R0F5bDZnOGlXdnNjTXo0cXp5WmJBOUZGL2FDOTdQT01PL1pPRFd2TWN4aFN4?=
 =?utf-8?B?Y093ZGZ0RmplUElZZkNMUzE4UDJMV2tzM09waFhjR1pZUGtwV282akI4SWh4?=
 =?utf-8?B?a0NBby80YitpdWtuK2E0RmF4Yk93dW15aVNpODVnNisrbE5JK1BpcjU2blFL?=
 =?utf-8?Q?DT6b1hsQQSc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXJiS0hKN3YyRjFKNlk5NzNRaGtDcnJVaVRjWVh4K055S3NXV1VHZStoWmYw?=
 =?utf-8?B?V0FlRG1HeE5nQ3RnOEN0Vk5HTW1nWWhwU3ZhQXVsZ0I2UHZ3c2d6aUJLeHo2?=
 =?utf-8?B?Sm1JeC9kenA2c2ltaWVzR3F6Wk1QVmxZanlWY3lXQThZS2d6VWRnaEZNR1lH?=
 =?utf-8?B?djVoVHorM3BBaUpobCtjYWtlUlZwemhXVE5XVDNkZkVBb1MrT21TcDVSUjBi?=
 =?utf-8?B?MllBSmhyOVJLR1F5ZzlVRzdISTJZVHprUE53YUptTnZ3YlZOMVZRQ0IvcWVD?=
 =?utf-8?B?TnBpdWFVMmFCZ0FqRGRQKzhOOFhGZFpwR2tTdFQ1bnBiWXArVENvVkh3WVc5?=
 =?utf-8?B?Qjg4OG9CdC9xN2JFSEFDRzRMbm56TEpQZjViRXBLeE9RcW9ibjJySzNwMFZD?=
 =?utf-8?B?UStDZEFkaXhhV0RxdnN2WnRHUm55VndUSzRQOGN6NVkzOThLRnY5L2t2Ynlt?=
 =?utf-8?B?cWZUQXJBcFF3cHQreUdPMGVCNDYzWVQxZ1EvTGRzM3pXTS9MNE12ZTZVbFpL?=
 =?utf-8?B?QWc0ckhxcm15eFJTWmtjL2NNc3lMM2FYUlYwRTN3bkJBekkyRFQ3ODRsckpF?=
 =?utf-8?B?RFJ0N1ZMU3RTVjlQMi81YjFrNkEyVFBEQjd0cjc5Nkx5NXZVL0ZPeXhlWHlz?=
 =?utf-8?B?TFJTMXJUbGk1elcxdUkySmt1WThseHh1UThLb3pRdXFCRzlMbnRyRmhxSVRL?=
 =?utf-8?B?M05id2VhMHY1YU9QYjgrL3dvVW5MWkRKR3lLMVQ0U0pPUEl5RXByY0pyWmZv?=
 =?utf-8?B?UGxxbkU3YXBzUUNkN21QVUs1THhTR0JKRkdwYk0wTUllbVFQV28zVE9VZXp1?=
 =?utf-8?B?MGdkbFN3blNUTThjL0lTR0dkMHg2MHdwOW91eXZrVkRvSW9PR3FqV1hMTWlh?=
 =?utf-8?B?UTdtZDl5MVdBUnV1RDQ5cFVRcm5SeUhHU2huMjBKYytuTlBoNjQwd25UODIr?=
 =?utf-8?B?d25rV1RNb09HR0dCRTRIV1RkRlkzNlM4Ykt5a0FEenArRjROWnZWTFVGYm51?=
 =?utf-8?B?a1BuejZrYXZVOEtvYUZhalhSSGUwZG1aWDdCQkpxL2xXZzdBcS9mUXl5eldw?=
 =?utf-8?B?QVY5SEloTWFiUCszL3RRM00ySlRqWG1tOGJHQUpSQTFjOVFxeGh2N3VkNjJC?=
 =?utf-8?B?bE1GbFh5OUFxbTRJdFZoQk9oamFsamNnR2lwanlZMWt0eXgveHZNV0gxenE4?=
 =?utf-8?B?aE93TEpGSHNvMjVTMFgzQXl6TG1QNDE0a2ZRN2d1YlduUGI2NWpkUUdwYUFT?=
 =?utf-8?B?MmJCb1ppQ3dpdDJCQkxwRWNrN0tyVHpkMEJmVU96ZlU2VzNicGluQ1dsWTk2?=
 =?utf-8?B?bW4yRWdXVytEVC9xTmcxOWc2Wk5HaDBZc3FQVTkreUVsSGhwRHR2SUExZHg5?=
 =?utf-8?B?TDBSU0d6UExlT1B2NnlubzU3Q2tpMlowSzl1SjgwdnlLMXlMcTJzalNybWlW?=
 =?utf-8?B?NVZDVUpIOFJ4dVJwQms1TzhHa0xyR2JMTWp4K0liWGpmUlN1WXVpK3A5S3dX?=
 =?utf-8?B?OFJySVBJUW1qWWdVdTlydXpQdG1KZVFvY0xZcGVuOUhWbS9SWDhMRFdsb0pS?=
 =?utf-8?B?bXU5ZnluNisxNVFjQzl3aGxPc3Z2TGZ6Y296akJLN3ZVY2psR2t0cDZUNTNE?=
 =?utf-8?B?SE4yWEZqRzR1cGhTK25iVU12Z243Vi9jenJQcXEzcUdicG9MTW9YelR1SDM3?=
 =?utf-8?B?bnFLVVB0QUpkdjVMOWgxcGM2T3BYN21wVGVpcTBjZFJNMEJQMTRSL3FZOHlY?=
 =?utf-8?B?UmM0WlJ1VUZKZHJmamFQTEF0NnRXbnV3NXhHd1hmNEt0QytpVmZWRjNtWTQw?=
 =?utf-8?B?THJseDNodWpDL3dhTmNDeWVUeGNad3QraHRiQ3BCdlRiOGRRYVBNZ3RRTVVs?=
 =?utf-8?B?UVY2R2xaYzJYYlowR3NMZm1jS0NMLzdiWEVvamJ6bnE0VmM0ZzV3UjNrOFRS?=
 =?utf-8?B?UjlnVlhOUnpZTGRkQ3RBbERRV09jZFVPc1FXcGRMcVF0MDVJRE5tVUVaaExY?=
 =?utf-8?B?WHF3a3Y5Vm94b3VTajRSZW9JVE5ZUStGUGgrVTFJZ2NJaG0yL0xKUFMrdUFV?=
 =?utf-8?B?b0VTUmphdUtnN05peXJXMWsxUmphblZLUHU5TEZMTW1KR1RaRFZadko5aXB5?=
 =?utf-8?B?UGp0Z2x3c1dldDhZdWNLU0kwOUpOR3VmU1F0eUNOQWQ1aFpZVVVFREhCOUtY?=
 =?utf-8?B?UXc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: da56b313-3c61-4a31-a77e-08ddde316b34
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 08:29:59.4100 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ce2VNjADyWrNfbziRowO5MTeg0snVlokWT8Rjqj5UU00UtnNaaPERZAohE+Yds5UipLWEjHlMQJtgwnb1VNi4vqFALUB+lj69ZlCefms8g0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7157
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

Am 14.08.25 um 01:42 schrieb Mikhail Kshevetskiy:
> From: Miquel Raynal <miquel.raynal@bootlin.com>
> 
> Use an enum to differentiate the type of I/O (reading or writing a
> page). Also update the request iterator.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Link: https://lore.kernel.org/linux-mtd/20200827085208.16276-5-miquel.raynal@bootlin.com
> 
> This is a port of linux patch 701981cab016 ("mtd: nand: Add a NAND page I/O request type")
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

AFAIK, the tags should be all kept together at the bottom of the commit
message. If you want to restrict your SoB-tag to the U-Boot port, then
just add a small note (e.g. "# U-Boot port") at the end of the tag:

###
[...]

This is a port of linux patch 701981cab016 ("mtd: nand: Add a NAND page
I/O request type")

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Link: [...]
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu> #
U-Boot port
###

Same for patch 4, 11, 12, 13, 14, 16, 18, 19, 20.

> ---
>  drivers/mtd/nand/spi/core.c |  4 ++--
>  include/linux/mtd/nand.h    | 18 ++++++++++++++++--
>  2 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index c1b8b9627f2..d8abd03e919 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -523,7 +523,7 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
>  	mutex_lock(&spinand->lock);
>  #endif
>  
> -	nanddev_io_for_each_page(nand, from, ops, &iter) {
> +	nanddev_io_for_each_page(nand, NAND_PAGE_READ, from, ops, &iter) {
>  		schedule();
>  		ret = spinand_select_target(spinand, iter.req.pos.target);
>  		if (ret)
> @@ -575,7 +575,7 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
>  	mutex_lock(&spinand->lock);
>  #endif
>  
> -	nanddev_io_for_each_page(nand, to, ops, &iter) {
> +	nanddev_io_for_each_page(nand, NAND_PAGE_WRITE, to, ops, &iter) {
>  		schedule();
>  		ret = spinand_select_target(spinand, iter.req.pos.target);
>  		if (ret)
> diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
> index 651f8706df5..0afdaed5715 100644
> --- a/include/linux/mtd/nand.h
> +++ b/include/linux/mtd/nand.h
> @@ -80,8 +80,19 @@ struct nand_pos {
>  	unsigned int page;
>  };
>  
> +/**
> + * enum nand_page_io_req_type - Direction of an I/O request
> + * @NAND_PAGE_READ: from the chip, to the controller
> + * @NAND_PAGE_WRITE: from the controller, to the chip
> + */
> +enum nand_page_io_req_type {
> +	NAND_PAGE_READ = 0,
> +	NAND_PAGE_WRITE,
> +};
> +
>  /**
>   * struct nand_page_io_req - NAND I/O request object
> + * @type: the type of page I/O: read or write
>   * @pos: the position this I/O request is targeting
>   * @dataoffs: the offset within the page
>   * @datalen: number of data bytes to read from/write to this page
> @@ -97,6 +108,7 @@ struct nand_pos {
>   * specific commands/operations.
>   */
>  struct nand_page_io_req {
> +	enum nand_page_io_req_type type;
>  	struct nand_pos pos;
>  	unsigned int dataoffs;
>  	unsigned int datalen;
> @@ -613,11 +625,13 @@ static inline void nanddev_pos_next_page(struct nand_device *nand,
>   * layer.
>   */
>  static inline void nanddev_io_iter_init(struct nand_device *nand,
> +					enum nand_page_io_req_type reqtype,
>  					loff_t offs, struct mtd_oob_ops *req,
>  					struct nand_io_iter *iter)
>  {
>  	struct mtd_info *mtd = nanddev_to_mtd(nand);
>  
> +	iter->req.type = reqtype;
>  	iter->req.mode = req->mode;
>  	iter->req.dataoffs = nanddev_offs_to_pos(nand, offs, &iter->req.pos);
>  	iter->req.ooboffs = req->ooboffs;
> @@ -687,8 +701,8 @@ static inline bool nanddev_io_iter_end(struct nand_device *nand,
>   *
>   * Should be used for iterate over pages that are contained in an MTD request.
>   */
> -#define nanddev_io_for_each_page(nand, start, req, iter)		\
> -	for (nanddev_io_iter_init(nand, start, req, iter);		\
> +#define nanddev_io_for_each_page(nand, type, start, req, iter)		\
> +	for (nanddev_io_iter_init(nand, type, start, req, iter);	\
>  	     !nanddev_io_iter_end(nand, iter);				\
>  	     nanddev_io_iter_next_page(nand, iter))
>  

