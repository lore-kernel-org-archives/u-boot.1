Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D09D2F338
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 15:40:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C60DE803F5;
	Tue, 13 Jan 2026 16:40:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="C+j/xS3j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C79580B98; Tue, 13 Jan 2026 16:40:49 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5FBB80325
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 16:40:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8QMLrShJBxXjClTcA9stUWPZVvo5NNQ7maW3ZCgXOVvQaYwYKUQmqYxwksnSAwKEwpzh0igxrXjyvsvoz0R/tzQj1r5fMYzN1IPDYlWVgGBwj0lUXLfTSEykh6dlcHffYlQEhJ5Oa9O+nEMDErSKMRPvMKwIjAUvLN/4fllm1nPT7kFp0slYgHpijY/0vIwp8IxWpbFYlMQkvgRoolp3XGdjw7BDqvfHlmsqxL2tEomw3oyi36PfLiiXN3XEt1V0c7qSYcy2WeiE96W6++aT/TQnGz9lFncK8Mjp3zsAJV5h631yzcwqjnKfZpUziqbvWWiywoDdUCldalclBk36Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0IZXOWVL0frYtbit/BHRPhZxx2FdRiKZkxHDa48ntM=;
 b=rUeaXzsGgPDJ5NuBF3ixujg0xkT005i0hVxoMLxrT3YucoTT6BfWSyKv/Ecope5jgzIwBEV5ex9Ht+nEYU8LnO2Mtku9H6R96SKdMf9BWP21U61Zg/jZbG2xNnqN0EtnXv0IIGzxrpD9tl2WgW9jieaQPCXcQWbGNrOxWBgL8C3Ur0PmNLQHogwd/99gvJ+ahcvcckGEOlcsuO9vMGQIMj5aheW3ngI6ETsyQ4N06IPzQeRGoVDe6nBFrii0oXTOc6ibaT0JkOI6xdxSdeUKqN2jcnXcYjdwC0xK/5j2PZ29N6BD4/WaoQSmU26iwUBgLvWYhFKxalx6TZpC6+i9Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0IZXOWVL0frYtbit/BHRPhZxx2FdRiKZkxHDa48ntM=;
 b=C+j/xS3jtDnNtFZtDqOIvYTFL/9Ue+PWEaYurs2CoHJ0u1h3+q6iLqwbWteqz0FKHsz4j+pG4EQ9LMaONzdhQV9pjbcpbw65VU/X507NPUu4GL7BV/UpC8FIZgU/EwHP0I5PFEhwoWf5c7DSckEOHP+DkX1yM3Cxpw36aQvw2U0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DU4PR04MB11339.eurprd04.prod.outlook.com (2603:10a6:10:5ef::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Tue, 13 Jan
 2026 15:40:45 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 15:40:45 +0000
Message-ID: <4967e4a9-99f9-4b65-8777-627a7ac9b70c@cherry.de>
Date: Tue, 13 Jan 2026 16:40:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common: cli_hush: terminate all commands when Ctrl-C is
 pressed
To: Shiji Yang <yangshiji66@outlook.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Anton Moryakov <ant.v.moryakov@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Simon Glass <sjg@chromium.org>
References: <OS7PR01MB13834BB74CEC85C67277849A2BCBEA@OS7PR01MB13834.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <OS7PR01MB13834BB74CEC85C67277849A2BCBEA@OS7PR01MB13834.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0229.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::14) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DU4PR04MB11339:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b3dba8e-aec8-4b1b-c300-08de52ba1db8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWxSL3RiOU81NkVZd20wdjExMG1XbG40NzRqYVB6azZBc1VEcFg4MDJycU8x?=
 =?utf-8?B?WGlBTWk4NHJ1REVGMXhnaC8wNFUvQjdNdVhYWUlDdHVPN2hOM1BTT1hiWjls?=
 =?utf-8?B?S1Q5dFRiZ0M4ZHhTd1N0VFVCNWw2c21hdDdCK0RtaEdhMHZrR1RIU1kvK1pl?=
 =?utf-8?B?b3c2UnhiY1RQUG0wY2JMUFBlVDRMczFWRnhGNW9JeWRYSmNsYlo2OEhTNnFu?=
 =?utf-8?B?WTNqa2xXcFFxd2RMMVcvTWlYTnJvRFRvNEYyWHlna09PdGVHNzdpMVgvZmlL?=
 =?utf-8?B?RzMvVHJ3NEVJNVVqQVVwZEluREx4RkxuL3ZtdXNIcDRJTjBZQ2grd29MNlN2?=
 =?utf-8?B?dTlyalNDMUsrL0s4elJHOE9kWVJhRHBqelI3ZXJTZWNyUWFVZHdFanVqMlVM?=
 =?utf-8?B?ekZLNUZOQ3N3cmVtbHVvNDJndkpKRE9aeVk4QktGN3JvOVNsOFRzb1NjZEE3?=
 =?utf-8?B?MWJqMFp4RCtNcEVNMWtKekxWcC9mN3dvb3E3YVJnOGtUR1Q3R3NVL0ppb1Yx?=
 =?utf-8?B?ZjNCbDd5cFE5UUY3TUVCamdPZks1eUd2RmxKU3NuZjMvY3gyM094cjJRNGhD?=
 =?utf-8?B?RHNZemhLT2F5UFZxWlhVaU5HZm1ueGVsME4yY3N2d0Zab0o2Smxxa2RNTmI0?=
 =?utf-8?B?czhrVDFVSjV2VzdoUXJGZlluNVlGMGgxOForbWxyaURsRGdyRXovbkFIV3FC?=
 =?utf-8?B?YW9sZUdKaE9scENWMjZrTnNuV0ZvMWNBT0ROWGJ4L1cxOTl6cWljK1pZeGtn?=
 =?utf-8?B?UmtyRkdkTExZNlFZc1hSTVhuK2JWbnpLUEJqcksvMVNEbkZqZ1NKRS9UVHN3?=
 =?utf-8?B?UTg3dHhNc2xVN3UwRktnWk13cVFxbTZyeFJQNW5CdVBLbGFEV1gzclZwcGti?=
 =?utf-8?B?RTJtRVc5NEFJaWljSmNTdlVQa09xWDRVQXJzQVoxd0gzT1NkWFVyanRxajdG?=
 =?utf-8?B?bzBOUVJpdDB4aFdKMnMxWlR1dXBrNVdSL056ZTdLNUgxNmNnYVNqWWIySlZV?=
 =?utf-8?B?KzJ6Uk9PYllUVE5NWGJQNG91bE11dnQ1S2liSldEUzlHb3FYSC9uTW5NdVo0?=
 =?utf-8?B?WjY0emdPR3VFbjgvWFI0Qy81UU1ENGdIU1MyZTlCSHNlNm85YUZLM2xMdkpE?=
 =?utf-8?B?dHVMelYxQldsVmFuUWhaeS9yRGh0TlNCQStLejJnN2NiUlBrSzQwS2dTdFcz?=
 =?utf-8?B?Q09IQ2FJVm1DU0hDMCtVMFVzMWFKbXpsK3hDMlFXWW44UUVzOHlYWE8vZkVp?=
 =?utf-8?B?Ym1VNWVKMStwQUIwbHZtVzFUd2JsS1RhWmtQRUJmUzRLVTZkR09UUWxONXZJ?=
 =?utf-8?B?aW5MUHpteGxOaHlxOUVWQkF4Wi95RVh0NDVPRGs2cG1rOGRBRHMwTGpoNXhW?=
 =?utf-8?B?SHorRkNXWFk2OXVwRDJkNzV1Q3ZvdU52Mk9ITVFCcUdQZ3c3SkVTaWoxd1lU?=
 =?utf-8?B?NU9wUXVhVVNOOTl3Q3JZSDNHNTJkOVgwcTQ4SzNVZzd6R1hyWjdkMjRhMUI4?=
 =?utf-8?B?MDRPbENLMGVIREZFb2tFRWNMa3MycGpGTWJIVktpNEtkclZ2NEVBaWczZXY2?=
 =?utf-8?B?NWlOVVU2RG9kdUtYdmdwQ2IzT1kzMVllUDNFUjJ5RDVxYXluWUNjVXo3eG1Z?=
 =?utf-8?B?cGRianJjL0NKUTNIUTZGNTkvMXFldVJ6VElPZGRkR0c1UmdlcDArK3RmS0Ni?=
 =?utf-8?B?UDVBck1FQnFFc2pYWmhPbVgvM1pST1RlY2oxc3lGUlBsNnVudzB3S2pIL1M2?=
 =?utf-8?B?YXBKeEEvNTNOQlA1OEJFVE5vSDRpU2cvYkNRNjlwdk8xdTJMcW8zMXV1SjRp?=
 =?utf-8?B?bFZkRXBnU2x0S1J6ZXhqMHMyMFpCR1dUalFoY3RBWk5pdXM1V2IwajFESjFW?=
 =?utf-8?B?ZW1DYnFkMm5lOVdoOWxyUFVsQnk3ZlFDNWtyOG9jYUtuSDYwZmtzOHJGZVJH?=
 =?utf-8?Q?ZJYMsD1bE/iG61BRjzyIG2GVluK+4xdD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjdmQzRBU01qK2xpZHNsS0hycXRKTEEreHBtUEVIVTZjT0h6ZWdPVExYNTMy?=
 =?utf-8?B?S1JSWm5nTFlmcUw0WC8vWlo5Vy84S1poQk5hV0R4d0ZwOUdCYzlPOTJBeWVR?=
 =?utf-8?B?clNsTGZLeThjTUZDbCs1RzBtb3daMGhHZWptRStkOHRvSXI0M1d6S2lKY0ly?=
 =?utf-8?B?TUVuSldJTXpTMGhVWVR5TlQvV1lzZitOWDBMVHdYTE5QZ2RLKytDMHNPNjRQ?=
 =?utf-8?B?L3pPOUhDeVlnT0lUektrQy9WNUk2S3NRbzFBaEFCUVhoK0RYVXA5eWllOElZ?=
 =?utf-8?B?eTF6RkZMOGI0eEwrdm1pc3lGMXFsVDAzcW5UM0ZwMW5wcHNqUkhWY2l4OHoy?=
 =?utf-8?B?OSs2a3p5MStuNkJtZU96K0tWWXo5OEdKZWFTT0JmY1JUQ2JuQ1ZRdGpwUDVY?=
 =?utf-8?B?SE9pOVFwUGhoaXZyZ3dhSDNrNUh2aDlweGFhWC9FeXJkRGo3a0dSU0ZXUCtR?=
 =?utf-8?B?dGo2bmEwNURpOE5UQmxHU2plNzl1M0lCaVBWU0N4cFJvczBGZlAvZkJhUWhQ?=
 =?utf-8?B?SmJFeWpMWjhiYkVBUGhTbk1DM3dBbVZORk1ESzk5ZldCSnR4RDJkcDBKKzVm?=
 =?utf-8?B?aG85cnY3RmltUkRKSHd6aFlRQWMwM1ZhTUU3R2loSlF0OXZWZXdUVzhDK0RZ?=
 =?utf-8?B?NDJOY1dOV2JWSUJ2YUd3c25kOXA0NjJyVmp4cFpnZ3hMaHNxY1o4bGlOVTZP?=
 =?utf-8?B?c0NqL2U4ZWZiTmJ6WFA1NFphSUsvTkNuVno0YVdpcVBwYmN6Mk1lS0xMTlNN?=
 =?utf-8?B?TS9MZXB2SzdaRWhnVUV0ODV0bVZxSGc1Q1lQUDNXUTlZb29GdWhEaThCZnFM?=
 =?utf-8?B?YnNWVEhrNHdVb3paZzVBeTBCbjBERFdKdFpMY2tLNXNtQnkxTWlIeWNoNUhT?=
 =?utf-8?B?bFo5bDNGVW0vY3FtWk9ZL1ZPUFRVZWVFOGRFZnFlVUJGb1pTMVVySXc0SWpK?=
 =?utf-8?B?ODBsc0prWlJaejE5TjZnZDZLNTFKR2VyU2hCSTJMa2M1VXpaUEsrL3dwYWFT?=
 =?utf-8?B?NFdvYy9Rd3JYelhaU2FmcGxFV1YxTmhiYitZWWtuc0dkSGVnRkQwU3k1RlJZ?=
 =?utf-8?B?ck92WlBoRFNjNTFmQmVGYncxSVJXK3hKdTFMcVVpMit3WFlwUlcvS09Waytm?=
 =?utf-8?B?ZEgwREJtbHA5U3lCT1Q0RVJJTDB1aTdiZk5EQkVCQk0rbUU4aVRUVlNTejVv?=
 =?utf-8?B?WC9WK2dLWmxET1FVOHVEeW9NYWZpdVY1YkY0OXAvTGMzNUlwQVgvTlJ5Ryt4?=
 =?utf-8?B?emw3SHd2VXhpbDd1MC9NcFFGRzlmL2dFemltWk5TT3pwcTdLcmxOMng5ejZt?=
 =?utf-8?B?VTRaT2FreFlaQWFTU3VtaFZsbHdra0ZoaW5nd1AzOGhKd0xDMUtpaVVSV3Rl?=
 =?utf-8?B?c25ZdUdHSDd2QTYvSi9QOFZyRFVhME9KL3RHRDJua1FkQmRYYXVFeE9iMnJG?=
 =?utf-8?B?c3JDTFJxelR4VGNDOC9zZDRYdThuUmsxSXNIYjNPQnZxdks4U2w0Yll1cUNR?=
 =?utf-8?B?UkQrbEI0c0thVG1IbVRuYjdncnBoenlLZWN0VktYYXBhMjk0YW9NZlZFKzFC?=
 =?utf-8?B?eXZmRGRRSGtjU2M5TGkxTlBnQmZqRzlJSjBmYzNCNEphUEVEVno1ZWxhcEhE?=
 =?utf-8?B?VWJ5TnFZTlhhYlUrZFhOelVmNlpoUVdqNTVTVE1kYUcxbTNTek16RWV2Q2Uv?=
 =?utf-8?B?ZzM5QnhTZWxmbkFyRnB1QmZhYytJRmE4Yit3YmZ0NTFqVEpuTFBzaDdtdy8z?=
 =?utf-8?B?QmppRDY3RHpFbHY5ckNaZExTdGlrNzRLUDMwRnRGSzVOdWdkRzM5SGtTbkVz?=
 =?utf-8?B?OTFNcTNvWDM4Zks4d29FUFNqTjVXN2x3YTloeWhuYnVtNHZxbFZET2VSeTVl?=
 =?utf-8?B?RHNEUlZOSmR6VldGbXozZU9DU0dqRTE1YUZWUlNoanl3VmdyQVhFM1V5TFVD?=
 =?utf-8?B?WDFWVkhqTkN0QlRnV24zUS9PWDExRUtDRjltczBKQWdhNDlodStieUxWejNs?=
 =?utf-8?B?R2tLUms4SXEvQ1pVL3M5Z3NXYVB3bU95M1N2THpST3ZSMU5DWm9FRkt6dTcy?=
 =?utf-8?B?NVN4VHdVNWoxZG1Ld3h2UHF2TytETjM3UWVBcDBTeXZNbjlVK1hYd09jdXNi?=
 =?utf-8?B?Y1R2VmtDWUx0Q053SExVNkp0Sy96ZmV3VmhLZTA3RU1EbFhrSFV2Y1RKeUdx?=
 =?utf-8?B?SVdTR2JNeXkyK0p4eHp2ZEFRdkFaUUs1Nmh1QkEzMVdMWWpsMGpwWi8rZjFa?=
 =?utf-8?B?TDhDNVR5VUt2cGYxK25tdWh4QkNqZnpCWGd3TGdpTFpvWEdTYkg5YTB5Rk0x?=
 =?utf-8?B?WHJYbG03OFgrRHRTeDc3YVdrT2d6Q3FBa2tWZGNGV1NqaUJoMEVhZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3dba8e-aec8-4b1b-c300-08de52ba1db8
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 15:40:45.0141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P9T91JFDafMkfGE7YZREUIwbOcXwrpEEvuOcdv9FFj0Gh5RMqPntYZj72hZXdXBySWpzA/XCL6ypFfdoLGaTSBOCHIwaAj5tSVXuavpYOFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11339
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

Hi Shiji Yang,

On 12/28/25 6:25 AM, Shiji Yang wrote:
> Check Ctrl-C status before executing each command in the pipeline so
> that the Ctrl-C can skip all subsequent commands. This should be the
> default behavior of most shells.
> 
> Before the change:
> ```
> => echo start; while true; do echo loop; sleep 1; done; echo int; if true; then echo if; fi; echo stop
> start
> loop
> loop	<-- Input Ctrl-C
> int
> if
> stop
> =>
> ```
> After the change:
> ```
> => echo start; while true; do echo loop; sleep 1; done; echo int; if true; then echo if; fi; echo stop
> start
> loop
> loop	<-- Input Ctrl-C
> ^C
> =>
> ```
> 
> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
> ---
>   common/cli_hush.c | 21 +++++++++++++--------

I'm assuming we want the same behavior on all shells. So if this were to 
be merged, a similar implementation needs to be done for cli_hush_modern 
as well.

Any chance we can get a test for this in test/hush/? I don't know if we 
can send the ctrl-c keystroke (the pytest test suite can, but test/hush 
is C code...).

Cheers,
Quentin
