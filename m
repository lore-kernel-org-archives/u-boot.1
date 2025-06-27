Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA28C7EE31
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 14:50:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19982806D8;
	Fri, 27 Jun 2025 16:50:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="UrV8emzI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37E2E82B34; Fri, 27 Jun 2025 16:50:12 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE0718006D
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 16:50:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iI/T9aFaW09fPVm3+kVDARwvdjJDRNui8CjO8NEz1i2Lu7N3gX2sfzadtgYICy5tDg2VApNASbULOl2qpvUdTVN6LTGtV1kwe0WbG+ZeEx8/jk0vNkhOtACuYuFdA8ryh67unoXrJH5ztcuYAAlYFFGm8OuxR5ANluL5K5dZXCzeRT7JUDF+FzKvfGdio1Gk55KzVT8xo8TxyvohQKy3Tt8zcVdO20//0n6pvAOtjqztCXDXGjDx6gR4t2xMSd6Erkl2nHl8SlCZpyeD1nAEa+b+DOhhidrKNw6fjcP0hRK/XOndDUUuIRhXB9tZmLofaEjy3qUUwvd3yruYo7ta2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVJV+P9n4gmqlqYxKhLG+5RF2HlCYnXyt2bbSRVeTfg=;
 b=Gmu6jmZlJD06H6VIkEYDU48RJFilORvRDtPikJmkgG+r03ZhZfuvKLl3KeJYtfMHhQ3a6Ek2IkMHGv6xmKBc9nSkO7frcBTkQca+pXG7h2IdUlh/CWm2e9OUfqbi9nNa2SQqZFdGmzKXa1Ed/474haG0OTyUrNzpHTSGX330SG9zKmsJ6BWkCJT6x+N5iEJ9367M0WmWvRiecy16R/UYRm2ysvHUlaG/3P09wEfxKjxk09KSj2bpEHeGPmSgqGO3D7urAF6XWWALMOWoBb00FDKy0frdwqxtYcbg0LeBOHE4yus2lxds5D6V+pvqmyXS3OJFh13YRxESnHobQ3OjYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVJV+P9n4gmqlqYxKhLG+5RF2HlCYnXyt2bbSRVeTfg=;
 b=UrV8emzIX63ODcEqx1dB0gTIO9+e/sm1FG5j/o8yxeEjiS3si7cX5tP+PK/K6hp03MLAljOIL2dlZtiY3bbaWThBtbFLHRhtMKaDzJZV1JKBS3EXf9hwLlYj4e1NcBSf7j2NKW6+w5t7q/GWCpN3C1YwARQ/g05Z3ICI1IMhLb4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI0PR04MB10419.eurprd04.prod.outlook.com (2603:10a6:800:235::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Fri, 27 Jun
 2025 14:50:00 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8880.021; Fri, 27 Jun 2025
 14:50:00 +0000
Message-ID: <ed094775-23e6-4fb1-9272-540256d46719@cherry.de>
Date: Fri, 27 Jun 2025 16:49:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: board: assign up to 3 static Ethernet MAC
 addresses
To: MichaIng <micha@dietpi.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
References: <e76dbe98-2fa3-4d1b-a452-aa88a142c5cc@dietpi.com>
 <2beda42f-68c4-4fc3-8b84-ede6e452c4c7@cherry.de>
 <5aeeab0f-cbaa-4b25-9baf-37e2b0e5e9d1@dietpi.com>
 <7ab1deb6-5ab7-4544-805f-f2e1e139d045@cherry.de>
 <647c2f92-344f-4feb-8979-93b1d6574193@dietpi.com>
 <0c822158-11d7-4a1f-93f8-22043c807bd9@cherry.de>
 <3a38f9b3-e8a1-41dc-b770-0af80b8ebc09@dietpi.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <3a38f9b3-e8a1-41dc-b770-0af80b8ebc09@dietpi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0043.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::6) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI0PR04MB10419:EE_
X-MS-Office365-Filtering-Correlation-Id: bc9bf17d-c517-4d51-fe5d-08ddb589e422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y3JUYTNpT1NvYXR0Q2lZVXNwUm5OeWlhY2JzWXBQRlNqSDBGbS9vVGNOaTVL?=
 =?utf-8?B?WjJiVTBveTJjb2xNTnlpV0E1dDFHZ1hvRFBvZkZYWDFpQk5mMEJsRDcyMTN3?=
 =?utf-8?B?SXZTWjNkMWpDZlRuY2Njak1VOXltRm1UeWhycVJpSE5CRVJlMGtiZ01TK25H?=
 =?utf-8?B?bmxBTDZsZU1yZlFHWjZQQjZXR1dzRmNrUFg2bWRROEMvcmswdHU3Vmx1eXE5?=
 =?utf-8?B?SzN5c2srbHVPSldwSDIwZ3BzMzdPSFBaM2xFak15eDZiR1BoSlE1MGRSWTlu?=
 =?utf-8?B?RU40enlnQzZudHp4WmQzMnNWOElibFU4UG1wUDBmSjZKMVZOTjltV3VHQmtW?=
 =?utf-8?B?UVdKd0tJbTZXdzVwcTByVlRPMXBRUGpEWHUwNWIrOGh4eEZyUXVXWDU0U0NT?=
 =?utf-8?B?a1EyWkJSMzY5cXdZNVhQTXZuSllCdWM2N2F4WmpCLzg2SjFBRGUvUzY2VTJi?=
 =?utf-8?B?Nm9IdXVTYjhHcWJWWHBBN1VqWkNnNE9WZzdISCt3eWtoQ3VkNllLT3V3aFZ6?=
 =?utf-8?B?NDAycjZzQ2xNUlRHeDFzMkFWUEdtOHhCT1RYck5pYVNMYnJwQXJQa3V2cUJH?=
 =?utf-8?B?Y09nbUk1QUJtaEg3QnlUdC9vWlh2SGNET2FZV1JWRGlkWldteVRLSklVZ2w4?=
 =?utf-8?B?VVB0YWdEdTlEQjZjbXlybmpMbXFVQkw4QURoL2hoRmF3NEUwa1dXYzlIU2Er?=
 =?utf-8?B?SFA3em00TmR1cXBNSThEK3J5ZitERVh1c01XNG5GaE0zQzhXUXZoc0ZmeDQ0?=
 =?utf-8?B?Yjh4MG0wMXFrU3B3eU95YytZazNPN2xTVW1xcHhkSHY4U0Fqa0xEWEZyRlRD?=
 =?utf-8?B?REFoWjQ4YjRicXJ4cDhLUml6ampka1hzRk11V3BaZW5XSWhSQnlKMnVNbUdC?=
 =?utf-8?B?N3E4ZDJXTEFXUnpXM3VLTFZVSGxpNExSS2JOODIvK1NiZnd4cmxSZUFORTJp?=
 =?utf-8?B?bG8xMWlJemhmT041d1U3bGJtT09qdTJYMFVzV2RXNzdyUFhvTmRjSzdpdjln?=
 =?utf-8?B?cUlRZ09FN3RsNVJJQWdldUFrb3NXMnFvalZUTFNxQnFBamEydzhITEk4emR0?=
 =?utf-8?B?cmZmNk1yR0dkVklvVnF0ZnJFaGZ6N2NabTBYSW0ycmFTNktkRmpMN2pCMlRl?=
 =?utf-8?B?UmcreUVDYWd4S1NFaVU5STliNS9LeXNzMG95OGJhTHQvWG9KSFA4NVQ1dXRM?=
 =?utf-8?B?UE1ZakNwUEdQMmJBaHdxeVIrZ1NOMFVhOFV6ZlpEWi9oNXlwZ0sySW9YMjFx?=
 =?utf-8?B?SmFzeEpBa2x3K3RJU0hZRmkwbXdISUsyVWt6NURvTmluMUdzYnQrV3k2YlZr?=
 =?utf-8?B?VWhaUFRZTkpNMzBDNnVvR1RyVVd0VjhBbEpxMlJNa0FtQ3pMMlM0Nk5vUGlI?=
 =?utf-8?B?TFMxZ1lVY0p0TGpMeHRVVTJGdUFWMWJoRHR0SDZqbktLeEp5RjV5YU9ITC9k?=
 =?utf-8?B?UEJjK3FKVS9zSDBTNFZCR0xmTXNvY1Vnak5RWHVFNGxDYkMzL2hmcVBrN0Rv?=
 =?utf-8?B?elpqR1ZqM3JBWFloOGx5OFp5ZU1FeTB5YmVldEd6Y0pLTFc2Q2lkLzk0aWZa?=
 =?utf-8?B?a3k2UStqYit5UEhhZDBHZ0tNRitxNnpQeUhYaHkvZytOU0plTklzaStjL2JT?=
 =?utf-8?B?NXF0NVZlN1BIclRJOXFYYlpDanVmcU15akZwOS9idGc4YkRLTzdsYWZEK1Y3?=
 =?utf-8?B?dnplNmYwSGZnVzBUSlpKb1VkNzJjYnJKcmVMeGJFRk4vTDNRT2JqQjI4OVI2?=
 =?utf-8?B?d24weFRwa04ra0lhZW52dVFPS0dhSkc0UVRpSHJNTnpzL2RsNTJ2MXR6WGU5?=
 =?utf-8?B?dExzVVArOCtxNDNZZzFUME1zKzJBSnR4VUt0UWlSSEtraUQ4bHZEUWhXd1FS?=
 =?utf-8?B?U0pyamdVSllWdHJHbTB5enlBSVJTYVJaQklzTFQ4ckw2Vm9Wc1BZaGRtZUNs?=
 =?utf-8?Q?9Wz58mAEQpo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXh1RmEwdEVnUEU2RVRQaG1FdHZQcGQwWllwaUFJMlc2bXpDd203Vkp6VVBF?=
 =?utf-8?B?bW80VzYyYW8wb3B1QWcyWW5JcjRYWVhmcVMvTGFleTFTeHh5UExLZnFYRmVx?=
 =?utf-8?B?SmY3UG0wbGFhNmlueGZoRUxmamJtMGMrbUl2OE9vU0pZYjN3a2ttSS9McmtU?=
 =?utf-8?B?bkcrS1R5M0hoRkErc3RyenhKOHZJK1lJNzE1a25QdnpqRVZsdFhubjViUldy?=
 =?utf-8?B?UUg1VnlISFNhQUU4ZTBnN1REVmlSbHZyOE1OTkVXZEl0UnErZzFhbzBrVDZj?=
 =?utf-8?B?cjlyS2Z4U2t1Nzl3RmhtdWQzcUtpZ0gycm16NG9wUGVVazk4Q2U4SGR4NndM?=
 =?utf-8?B?WVVPalRxV1RPQm1Nd1JZR0NSaTRZS3EzRGVmWk9oYnU1QkJFekIvQW4wc2JS?=
 =?utf-8?B?UlI5RjM3WDFMVDlFMW9jZXlVKzJQWkwvV0NGQUIvTE5RQWFJK2t6TkdsRE9N?=
 =?utf-8?B?Z2xPdnE3cDZJeTM2alhFK2VTQ0xFM21GNUVKRi9lMUdUQnVRSWRKNU5ZNEho?=
 =?utf-8?B?U0c1MTl1MkdLV1lQOFljUzlhZGdLdm0vcVExUTdWRkVTbzg1bm85K1hOYVUx?=
 =?utf-8?B?QWRkVHlWd3lsQ1pnSEIvZjhPVHNlMmJQMThpWVZkSnd4bW9XNWpUQTdEQ2R4?=
 =?utf-8?B?dDBDc09hRE05U3paVzMyeHlUV1d3cGpLRDA4a2xjU3pxSW1NK2hTb0Zrc0Rq?=
 =?utf-8?B?Mmo5ZUFTNVYxUkh1RGE1QUFPN1NOWW52eWhnczB5bXF4bWVONHdmdi9UYjEy?=
 =?utf-8?B?Ym8rcTh1ZU4yUU9oTXN2aE01L3NmclRSMUlMZGJsNnpvN1Q4RVB0TXBPVGor?=
 =?utf-8?B?UlBHY0srTUV5STZPZDVLbkFJWWNvL0pWak1KK05BYmllcnJFSk1WaFBSb1hv?=
 =?utf-8?B?aUl1VmxzS01uTG9GdFFiT0cySlR5MVRrOXBmSVFQaHJZdkQ0dEk2WG4wdkEv?=
 =?utf-8?B?NTRiQlV4dmJYT2ZLckFnUmJLNHJidzE2YitEbndZWGtoV2NnL3g0VUJreGN3?=
 =?utf-8?B?WTdmdWpsa3NBU1JCNllqTkJ6MXBBWWl5Q2tZL2NVQjl2TEdSeUpMN1o1OXJN?=
 =?utf-8?B?MGNUVEU1UndIOHR2aVRPWlpoTkhvUm1pbjlCUlBaQnZXWnJCcVR2ZFphR0d4?=
 =?utf-8?B?bWxWcy9VWTNqKzZrWll4LzEwNmR3cCtmSnZETEhScVAwS3JGSzdaQXFwM1NG?=
 =?utf-8?B?R2xPd1FoWmEwWUFBaXV0SWNmTzhhQ0hVU3dkQVJpVUF6VUxZRTNpSG10NXc4?=
 =?utf-8?B?VHZKR284dFdBRDRBZXRsZ0p3TGpqUDhPN3hFY0x5ZGpZV1VIWWNXVUdwd0dl?=
 =?utf-8?B?b2JlZ0ZMQmhrTi9OYmQvNlMrdlhXQlY3WnpEWmxPVE41L1gyallSODhyOE1L?=
 =?utf-8?B?Mm1hV1paOE94UUttMlMvWFBjTTN4a0FicERqeDA1MHBDNVVpOURvMWk0QkZu?=
 =?utf-8?B?MndOa2cydVdnTzBjcUJLK1BGdUlzTFZLTTM1NkVDUncwSEhOWDZmOXZqcHZZ?=
 =?utf-8?B?V1d6UHBjQitySHlScis3c2g2RzJHWFRkTEV4ajI5YWhPYkpNcEt6N3FkWno3?=
 =?utf-8?B?OUtzL3ZKNElibHA5VGxNdFJRVWxEU3I5dmtRZ3hKbE5qb1BZeVZqV2VyNTN6?=
 =?utf-8?B?M2twYS9zZW1EMHRBQXBrSTBvK0JKZ2hsVWNNTG9PVGEzZm1JVmdCc0pUUStJ?=
 =?utf-8?B?Y1pqNVZyMWhkRE4xZmt5dko0YTdkR2xyNzNLWXVGRHFYeTliSDRFM0ptRmgv?=
 =?utf-8?B?QW5KSUNNcnIxVXJhMDlPVGIvaTVaQUZjUzZ0ZTh2YjlmRjZCNldUK1NqOVF4?=
 =?utf-8?B?YTVHeXQ5YUo5WldsQW1TU3Y1WmVkVWJYWGE4WFFCd2U3cklhTkpsNUxMeDJ4?=
 =?utf-8?B?cXFyaTIxOVRmbHdMVktBdmwyclJaNEprNHdsUk1wMXhlaVl2MkxGZWVVNjNJ?=
 =?utf-8?B?RW4wYkJDbS9zdFdZS2FPL0J3R1h1blRSQ1R1dFpTZ3o0cmJ2UlovNUw4TzZq?=
 =?utf-8?B?QUVFVStaZWVzZlI0YldjaUgyRU80cFFoSXkvY0pxQ1AyQzFIYmhJOXVFTnN2?=
 =?utf-8?B?ZXl4dEJ0T2hzU3k5a3dRVm0yeGk1UHc4WS83T0w4RjM2KytucVNORThZeUNO?=
 =?utf-8?B?UkNsU2p5cEprMTlCZDdQVTNFUjF2Z2VjRHJaNDBCNjFPMndhZUFNbE16TlUy?=
 =?utf-8?B?VEE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: bc9bf17d-c517-4d51-fe5d-08ddb589e422
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 14:50:00.0509 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bhbtwQDtE6CidrPyfugkHstTX8Uk8PQwW2I1iM2AA9x/ZOyZx5dWT/4ZvcLvxtKOegmurHhdMKsnSzQj5+xjvfUpOfnCU2Kxr3fpzCJeLpo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10419
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

Hi Micha,

On 6/18/25 6:24 PM, MichaIng wrote:
> Hi Quentin,
> 
>  > Please keep the ML in Cc.
> 
> Was too late for me yesterday :).
> 
>  > We currently have 137 defconfigs for Rockchip boards (git grep -l
>  > ARCH_ROCKCHIP configs/ | wc -l), so not sure 3 is a reasonable 
> threshold :)
> 
> I mean just for us/me, coding efforts and maintaining a patch, it is 
> easier to do it right there, where it is done right now for ethaddr and 
> eth1addr already for all Rockchip boards, instead of creating overrides 
> for 3 particular boards. I hope an additional eth2addr is fine for now, 
> until we found a better/more generic solution.
> 

Up to Kever, no strong opinion on this.

[...]

>  > Not sure to understand what you want to do here or what's the issue 
> sorry.
>  >
>  > You need also eth*addr for use in U-Boot (if you do PXE, TFTP, ping,
>  > whatever involving networking) so it makes sense to have them in U-Boot
>  > DT as well.
> 
> U-Boot assigns those variables to ethernet aliases on its own device 
> tree as well? Would be reasonable, but for me this is minor. At least I 

If DM_SEQ_ALIAS is enabled, I believe so.

> did not hear from a case where someone was complaining about a random 
> MAC address for network boot.
> 

I would imagine people be surprised if the same device operates under 
two different MAC addresses depending on which SW is running at the 
moment (U-Boot or Linux for example).

> What I aim for is U-Boot assigning static MAC addresses to ethernet 
> aliases defined in/for the kernel device tree, better in a more generic 
> than specific way, so it does not need to be changed again each time a 
> new SBC (with new SoC) with multiple onboard Ethernet adapters arrives. 
> Adding the aliases to the kernel device tree is then a different topic, 
> not related to U-Boot, which I however aim to achieve upstream as well. 
> If U-Boot syncs these back, it allows static MAC addresses for related 
> adapters in U-Boot phase as well, of course.
> 
>  > U-Boot may point to ethernet1 in kernel for example, in which case MAC
>  > addresses may all get swapped between U-Boot and kernel. This is
>  > theoretically possible, not sure how likely it is to happen though.
> 
> That could happpen already now with the often at least 2 aliases 
> defined. I wonder whether it can cause issues with PXE boot etc. In the 
> cases I know, a dedicated dtb is shipped as well, and I am not even sure 
> whether the network connection remains the same between U-Boot phase and 
> kernel phase? In any case, as long as any new generic MAC assignment 

I would assume the kernel to be reconfiguring the network stack while 
booting anyway, with renegotiation and all, but just a gut feeling, 
nothing to back this up.

To sum up, not much against this patch except that it's not ideal to add 
an environment variable most boards don't have a use for (but probably 
so is eth1addr :) ), and I think we would benefit from some generic 
implementation to set random Ethernet MAC addresses based on ethernet 
aliases in DT.

Cheers,
Quentin
