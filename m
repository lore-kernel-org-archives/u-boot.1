Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91217C3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 18:51:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AF22868CB;
	Thu, 24 Aug 2023 20:51:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="Yc0sqcBF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D9A0866D4; Thu, 24 Aug 2023 20:51:15 +0200 (CEST)
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-sgaapc01olkn2080d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:feab::80d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0AE68650F
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 20:51:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=forbidden405@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KO3EDTUg3w18mAlctB+Hw1NDEz5XL85WX5bza6OdNqUDt46fTMJoSUZnN70VjmxykvmPP6Ub5iCNFqLJbzJNdFVbRWemV/9eqKT9MMCjiFc13FBx9eo455nI61TV/wozDg133+E4E6Qx9e1kaMkWE9XqEbwHSqgswgReE2JG89TtRjP6uDKFsNqKHKDgpLwF7ax6XNwo8NEgFTjwuwic02MguzOBb2/zOVWLaD+6Q0C1cLdtaMdwybXB/wtiqu2+JK8HG98fdawcJi+C5fi523vbA/DVnHiD7igWscXvXDYF0Heo+PVLd3hGad2oBYDLq8nCjbtzYpxpThX8IKbBNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TO03WuWB6HP1637MFgzC6EoJdAMq5W/ilN3IFzxOqk4=;
 b=Gty2hQyTwFo4BwCEo1y9A17o6TEuZgAWIfw3CTVf+VE7wOwRjdnaDxwNsgQFyvAhYYgFmzykR/thWBeMRNUvfkw2FqjfbzwUOksTWLBl1bFfwEJJ/GqNUUqp29rTflL9xRoFWBagUHvsYhPMOlj8PG33E6GwYdvcX5V6hpBT6fAl1Lo8g7Ldf15f2wk8qnjllTM0fLwIqmbpMoJFcUXfxCasNMEJtgxcbLcNYP6pqxRPjuQWGSVT1PIiyn5i2gnAeUFEKIvYm2qZfe3Hh8KWd+l4mjteDMdOGiFqvJZtrgkrgsD0bjLrh363OsWBU7dN6XecoQbL/cmAfHhv16NMaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TO03WuWB6HP1637MFgzC6EoJdAMq5W/ilN3IFzxOqk4=;
 b=Yc0sqcBF1Cuh+97SrayNq6plozJmwO5j473tAzII/ktQoBBp+UyBHS1ISm9dDL1kM+6Ig2g7K9FvZXA5XXOJpLZURNgS6pMr1baytBCYdb6aBOJ9W631L0VeFzT4kB9oLgwvqBSqqRo8NXSfeQgaeNWPUrmd1KsZS53wz+JFSNDaP67dn9hukKiE9/2Pb5ff7M8pT29XmUi8A1lcFY7PXcQcJLrYRkuBv8jiUKcdekdyq1XvpNHxRK4Yj0qhiRqVyN9v8RWoTnIcivWNWp9TNFSP9Jo9jEOhGz1qLYWlzy1IndIXe/j5jr10JOkhotS9zODaf4VkjD3WpUYzOa2axw==
Received: from TYZPR04MB6321.apcprd04.prod.outlook.com (2603:1096:400:28a::14)
 by SI2PR04MB4252.apcprd04.prod.outlook.com (2603:1096:4:ff::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.27; Thu, 24 Aug 2023 18:51:08 +0000
Received: from TYZPR04MB6321.apcprd04.prod.outlook.com
 ([fe80::eb68:5e82:41e6:cfe]) by TYZPR04MB6321.apcprd04.prod.outlook.com
 ([fe80::eb68:5e82:41e6:cfe%7]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 18:51:07 +0000
Message-ID: <TYZPR04MB63219CAAE403809D2D5B5A5C961DA@TYZPR04MB6321.apcprd04.prod.outlook.com>
Date: Fri, 25 Aug 2023 02:51:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH RESEND 0/5] clk: A few bugfixes/enhancements for CCF
Content-Language: en-US
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
References: <20230818-clk-fix-v1-0-49ec18f820bf@outlook.com>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <20230818-clk-fix-v1-0-49ec18f820bf@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [OVed/ugnApSwIDbGxpV3h9cpr9e+Z04f/Kv4io1qYGs=]
X-ClientProxiedBy: TYCP286CA0141.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::6) To TYZPR04MB6321.apcprd04.prod.outlook.com
 (2603:1096:400:28a::14)
X-Microsoft-Original-Message-ID: <58e998ee-68e1-cced-4e64-4dbdff480a07@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR04MB6321:EE_|SI2PR04MB4252:EE_
X-MS-Office365-Filtering-Correlation-Id: b1ab227c-3c31-4f27-c40e-08dba4d3130c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4npPzpx3dz3HqQqLdsYLKTOa3ULxBlV+um3nMTPUt9iv6XGh1RmeM0XIUrFVygW1l5CdbES09lqq7noYqquoYdUpW295cfoiXTDJKw4J9auBL0KC8gwW7wIrN+C7U1xH6+ZTEC2oZxBzzQx/nuSgLNjh99eAzRX2PqDyhNjuRccT1ijeR+TtIhtgZtg+4IVJA5TLP0O0QuWT4bRK/jOlE0zk32/wZzsl9oPCF4gC+n/SX/+/TMZZce7hVqVba7afFJ2ziWTyqq3C+JyZZvrgHTSw8NotCYwM0JcfP5tOzWASoilD3fS69nPr6n1rmD2FpxQ61nGCl2LOYXTx9sxtkkmC1iwVABBhG9GcBUaZh9WRVDOH7nera3+YNw5krSHStxNyH5p9lHXWDiGDhjU1WioTiTbdGOxlNiXxGWEND2A9T5VRMeLe1hov0hC8KczGzoU/esUiZhlFRB29uPRg6tKXrgt9phpLxd06hDudKFKrLRMCQQWXx+f4r7G34pVHMj8PK0lONMo/lhMlmXXEQiSc+Q4hCBFniwOOTE/2GxoESf3OWHTORNUA7B/kIuON
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFFGU3BRV1ZKeDdpTm5NRTVoektOTjd1L2xJcmVMVC9zcm45dThWeThCekZN?=
 =?utf-8?B?bHk4dDlETDVlOHA2VUxVZFVXNXd6Nm1aRnBnWGVkWGlYZzY4ZU5UWUljY0xw?=
 =?utf-8?B?WmFkUm9WN1lCb3pkWTZFV1psRURVZS83dDV5MGF5YTkrVFpGK2hwdXdWcFRI?=
 =?utf-8?B?N1pmQWlFMk1wMGtJL2JCdW9jRWdZVWxOaktLUWFmWDFFYVdzdG82bWNhajM1?=
 =?utf-8?B?NEhrelRWRTJFbW8rK3NuemlNMkpWOGRTMDJGUHg3dm44OGNzK0pYWkhoSnRV?=
 =?utf-8?B?M0NnSGUvSnplVUJZMXFqR0xCbXpKdy9EQWRrQm1uWmQyY3FUQjhCTiszNng0?=
 =?utf-8?B?aVFkdFNFM3lsV1FtQkZtVWltRUhiNkh4RE5UV0c3OGVVa1N3SkFBZGxEZWll?=
 =?utf-8?B?VWY0eis0akhseFN6QWJuYmxhZlhoZFBvL0cwd2djbGpEYkt6MG5CU2d3WGEz?=
 =?utf-8?B?K1lFOVp5Zk0wV2VwaDBTUE0xeFV4UGtmeHpBY2VvYUczWHlyNUJ3SWJrODdn?=
 =?utf-8?B?Q0lQM2V3NDRBaUd0K1Qrd0RWM1EydHRDZTdjZ0dPWmdLR1FNd085cVNZMHp4?=
 =?utf-8?B?VVV2Sk1raUpMSmNaYUhTMERYTlNQR3c0eG1jbWt6RUxJUGNIcThQck9kMngx?=
 =?utf-8?B?c3hFQVp2clJGdE1wK1I4dDZjVlRld2NPdkU4ZGdKMnRzb1FqZW1yeFZnTmpG?=
 =?utf-8?B?dkRaVko5eDdQck55VHRoR1RTK1BGTGdMZEdhYy9CWHBZYVE2Nkxxemc0cDVz?=
 =?utf-8?B?bGZaaHN4dWRrcCtaWnB6c3dCQU5oNmplWnA0N2JBS3ZDVk1LSTNUblhOeWhG?=
 =?utf-8?B?OWxYRm5qeWl6ZDA1c00rVUdRY09oMVA4UXJSU3llKzNzOXhNNmVyUmZzRTFy?=
 =?utf-8?B?SjhyZnlpTlRNcEtmY0dLMHZ0WG1tMHlVYVkzaVU3Z28zMVdWd0NUdlArdDNn?=
 =?utf-8?B?aXhUR1owaDdUUW1rVmcwMEY5V2JoQnUwOVNnWnYxUlhuaWRLQ3AvbEFEYVZT?=
 =?utf-8?B?Z2hHMzg1V2hyeGxNTnI2WklySWg3QkpDRlk1WXJmd080TjByQmU5T2xWUTk5?=
 =?utf-8?B?VDVNNHF4bG4yd0xLSW5Fbmc1SGUyMHR6cEFDUi9ORk45cmdlZndGbC9TZVN5?=
 =?utf-8?B?RUk1Tzdjak9HbXZaaUNJUXJlVFhraTExcWlJcTB0TUpydUNVYTV6NHJiUHgy?=
 =?utf-8?B?Y0VxRmNSSWZPVlZuVW9HZlE2dWZxOXFORU1NcmhYdmlIZUNRUzlrcXhLWDhU?=
 =?utf-8?B?N3VOS3lDZHAwK2REYm5iQ3VFSldYczl4ZHl6cllOT3ZwdmJqbm0zMDJaN081?=
 =?utf-8?B?T0dMc08rbSs4SHVQTENkbkp0eFExY0kyaHVGbE9zUXlWa00xZWExUko0TDJH?=
 =?utf-8?B?eitkb2E5Qlc2cC9GZ085SnpNTTBmRmxINytPUnBNb0owS3dhYnFPYXd4bUZu?=
 =?utf-8?B?cmplQ3NnZ2xQLzV2UXEzM0NIQm5DTjJhVXU0MVowbDV4SnRvVG5NazVXUDFX?=
 =?utf-8?B?ZjJTMGpMcUJ3a2NMUktDNlJSYkIzNlZEYzY3NVRSQ0wzMTNuTU9qZXduZVhD?=
 =?utf-8?B?SjFIQVBKa0ppM0Jaa1QvZzhRZW5wbnRkRnd0VlMwR3hpQU5qeTI3clFtUmhI?=
 =?utf-8?Q?2zh0lH9CiEdAKOFxa0dXA8n4Ofr4+jrPHS674X9PR6R0=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ab227c-3c31-4f27-c40e-08dba4d3130c
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB6321.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 18:51:07.6222 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB4252
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

Why is this patchset completely ignored for more than half a month 
already? I have some other patches pending because of this one. Please 
tell me what's wrong with this patchset so that i can fix them.

-- 
Regards,
Yang Xiwen

