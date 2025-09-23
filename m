Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62300CAC5A7
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 02:17:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AE9F83445;
	Tue, 23 Sep 2025 04:15:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="aHV+bEXy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD95A83445; Tue, 23 Sep 2025 04:15:53 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4820683211
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 04:15:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hjl6a67zvjMR/cpgwbh/FwKTBMtF+aqWb9+9NCydYOT+ewEq/3Tkm9/rUn/y1pt8M4fcuI6js8XtBaFZvpwssenRYiE5SVV4+fNBXQuSNpJyigv7n9dpz0xumx+8abEz06c7Ov7PNNYQu7mgfVU95P6ylFZRK43ebYbJnfDmneF6CyO/Z9zbV2nN0LZVTgS9rROW/vsa4yor+o9UIchboOcxwUt54+2xR7YKJ0zrQOIuh4LyDeDdAQDC5IaQyZGcxpXBLpaOM1qFlGptsuDpVykoVKSzs03/6UmdeMWaUVoTOKRbAmnWjyn4eQev+OHd770IK3VSWzyHqe8foA9zgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xo36rI8CJO/MlRHnfm0FrZRoAfXZX0sHdxB0sjf6c4=;
 b=QCt/p30UFepoHae3arEbampyA3SNhOJF8ScE4NGGlizpFGYQn0u3qgotFTO6RTwFyZikSkUC3ddUmq/vTp5t9uCEh+2UFBC8kXOrkm08CXkj4bI9HhBQ86K7XcHC1F6OyEYKZl/j0xZPLdZfqhufLB73xwjW1Crd82Ha1krHDJL2paPWwOyK5jdvNaCP72Q3uGoxs5+UUkfzAhpbECPkrtPb2f+Cf2iyEdp/yb+3VkY1BJZNnRbHQV0JOj26LRACwJn6Q4MkWXjr3HpA0KA84oT35kn/TozNJW7E+8o7QnWlMo/7T/npLguHTUisn3wJtedybHDMINIUTmgw5NJ/zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xo36rI8CJO/MlRHnfm0FrZRoAfXZX0sHdxB0sjf6c4=;
 b=aHV+bEXyBe6ma8zDRL4lPqjXEGclQYFjttYG4Z0rrGdT388MLuzGVCmeXWtWV2eAqdhxyNUROXID534SwrLdS7MoGw39Q9DnwY6xx1hfBjkHCPuCZuOkN6G8mzdmpi6MfR/Tjlph7SRiGLLhn5rr2YGz/uNLPqXn/NHoPvGD2PD2IdhhOpuJ73iS4Q3n+U5+ekX55lv42Ceccq5eYpl1pMe9cWRa6SmFvT2OUhil6Qfulz2RJS1NNIhcIZEVG6pVRQ/G1Eg8zmxbBbugdG3H1VhlXa4FpD87sf+WUIBHAmi97n0hblPkZ3yauHUHnhFvIFOzK6nIc1xB8hwKq0j8oA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI1PR04MB9835.eurprd04.prod.outlook.com (2603:10a6:800:1e1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 02:15:49 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 02:15:49 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Tue, 23 Sep 2025 10:15:04 +0800
Subject: [PATCH v3 12/12] imx94_evk: Add i.MX943 EVK board support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-imx94-v1-12-cb3b65169048@oss.nxp.com>
References: <20250923-imx94-v1-0-cb3b65169048@oss.nxp.com>
In-Reply-To: <20250923-imx94-v1-0-cb3b65169048@oss.nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI1PR04MB9835:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c76f1ee-5657-4170-5463-08ddfa471cbd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|52116014|13003099007|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SndhemFnbUZ2cmtqQ0ZUbHJHNHF4RjRVTjFmbGh6RVIwNkliTlYwVDVCS09G?=
 =?utf-8?B?UDhPYjRPY0JpWmlYOFZ2T2hTTzY0WkE3eWVoTFZ4N3JmSnB1eEx5dnRCSUE4?=
 =?utf-8?B?NGU5RkthZTlIYm5hTEVGNjFSbllUTGJ1QlZ6ZjRnd3Z5NlF4TnV1dVh6amJR?=
 =?utf-8?B?QVZzaGQrVFhiZ3RXQ2h4bmR2V1RXdkswd1FpeVJHNTN6MnVXSkU4Ym0zUCti?=
 =?utf-8?B?dVZMVXJiSG1UUDdqdE56bTVEaUtTVUs1ZEtmZ3JaWW81ME1QWTQ3a3huWC9R?=
 =?utf-8?B?N1M1V0hyaEVSVmRPdU5rbjRncWN2Yk03OEh1UC9SdGtJUElldzNwNWF5U3dp?=
 =?utf-8?B?c0JhdGNMRi9tNCtJdTJtVnZWMDhJaU1PRmdwVkVmTmQwTFc1TmMrMUhVcFZp?=
 =?utf-8?B?NWdpd2UzdEVScG9jOUFmNnliUWhOMUxkTm5SUUNtZlV1ekpieE1UVGgvc0do?=
 =?utf-8?B?NDFsT3VMa2FCMnhubTNUb2pUa3M2cE44SDhwWTd1emRzb1lZRFlWS3FDVjN5?=
 =?utf-8?B?bUZOTHdRQ05jNFgrMnI4QmhZVmhGUWc0SnlrQjkzbmRkUmw2d3pXd2g0QVhC?=
 =?utf-8?B?N25jdXBFeVdBRGFrdTVoaDN6Tkt4bTJBRHJkTWRJenV0ZGFHZTlGaGhFSlc1?=
 =?utf-8?B?VEpTWCtWWXN1NWd5cXFOWGdRTERtQUhXaGQ2QkV0WVM0cWM4b1huYWZOUEt1?=
 =?utf-8?B?bG15czJXUXlKTUs1VjBKUzRYWGlmYnNvdW01TGFvRlhKUWdOcFVGSU4vT3ls?=
 =?utf-8?B?YnpVMDJWdjVLZ2ZCdHRzakp0cnVnWDZXaER2TEpkaHNxMHA4WFplNkU5MWp2?=
 =?utf-8?B?SjU0Yk50NWhVbGFTQ1U4Q0x4cm5qNExSZHlqanZ3VVNEVTl5LzF2dUE3M1BL?=
 =?utf-8?B?MWlXcVhDaDlCeXF4T2p2MFB6VlFyQXh0QWJSQ2IwWmh6U0VPK1pLZjlsVUx0?=
 =?utf-8?B?VngwZzA0OFRzRWRMN3RzUC90VStCSUt3akRoZHhrV1kxaUh6MjllRmRHdDly?=
 =?utf-8?B?Tk9lMGRCWFVLOThlZFV2N0U1SWpqQjN4MkxvL1lVYjVrcG05Nkl1Z0xqaGc5?=
 =?utf-8?B?L2dZZURjUm1WZnVRRXRtQldUeFJ4aGpMUU9SM1ByVWppYytUbGQwa3RjbTc4?=
 =?utf-8?B?NXBYaWZtQnNVMHR3M1BsQ2pLK1FyNlF1QnhGbXE3aFVwczVhRzNxbGJnby9k?=
 =?utf-8?B?R0Z5c054TCtqc0hqMVJub1FUSnU4Z0tWVFhvMWxlMGo3L1duOXFGR1pKTGtX?=
 =?utf-8?B?RldKUWd6M01PVnpOSG9oeit3SUpmS3N1LzFyeHJMRmVVK1J4ejQyUDZsQzFM?=
 =?utf-8?B?R3FlQkhZd1RkS1NtNXdtN0dibjdOclBPNktUQ3NtVnNyYVl4MUZyWEsyeTdp?=
 =?utf-8?B?QzYyRmVxWWg5bTFybGROZW1jSjhIbGRwR0libXJjaXFPRFZGazY1ZXd4SDc2?=
 =?utf-8?B?aGFlL3Y0NXpnV1lvTlArOSsvWXovd1NBUFhVZUpVeU0rTkpqYSt2TTRyb21q?=
 =?utf-8?B?azFCUzhGcDFlZ0lkayt4UXE1UDluWlNGYVhWemFaYzlKbjlkTnlYZ00zVkln?=
 =?utf-8?B?SWxFY3ZpY0h6TitIdmwzYXlub1luaVArM3ViVlRvaytCQmxnZzZPOXlsSTZ5?=
 =?utf-8?B?WGMrck9KVXdIR04zZTY2SUIzUVVEV0s2UWp4ME44N2NVVWo0YnErUVNNRlNz?=
 =?utf-8?B?SjlTVkVPYUhDZzE4Zlg0bkxCNklqaVIwYXg4NktiZ0xEbjVoTkZyL0Ntems1?=
 =?utf-8?B?UUw3a3lLRkxHRUNCOHFJditFd0cwbkRRYkJ2NjdOT0RKdDErbm5hMkFRY2I5?=
 =?utf-8?B?MWNuNDVISVZnU0x6TFZyVE9hZTFyWnlFRUtxQ1BwMnBDcHdGb3RORzRTMWZz?=
 =?utf-8?B?NUd1R2xOVFhuSjdVdUJ5Yy9pN0dIY0JFeXVEZW5DRWoyOWJvaEJYSDRJcUI4?=
 =?utf-8?B?SFZva2dqK24vVHhXSlZPYVg3ODdDbm9mTDd2OXg3OWhWN2Myd3haMXFJWHRu?=
 =?utf-8?Q?SlJCPJOhCIbGdEcIIo7ghqJ5+rWYDo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(13003099007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUdITXVlWnRnZVJHMS80VEVIRXNjcTViSCtMbitsSEEvZXpTbWhWUFZPZS9N?=
 =?utf-8?B?U1N1aWUyOHdWRG95MDNxVGlVYUc5aUgzNldzYmtCWjNVcGt6bC95eUV5dVdQ?=
 =?utf-8?B?bHZuRmEwSHh2VWdsNUU3eXN2Wk9jRnZIc25Kc0d2QXQvTWxKVStoZ09ESjYx?=
 =?utf-8?B?QkdrcVQ1OVd2R3FFWU9yOTVpU3V5cXI3ZjFualRnTHdSVEhTNERFSzdqbG1v?=
 =?utf-8?B?TzIraDRMZE1FTGxSME42eXgzeS9xb1lFTHh2bjhxQVVaaCtSVTgxeGoxYi9P?=
 =?utf-8?B?a3hmaDROSTY4bFMxMGJFOGVGN2NTMytBN05ESytOMkZCczhyOTcxQjlpcDE2?=
 =?utf-8?B?ZWlGbXhLN2laT21uclhCRTlUd28yd2tRNWMvZjBxUjNrSXl0bEtUekNKRVBG?=
 =?utf-8?B?YldqSExPTWk4VlVuQjh3UWtYUVdWQTlUajk0bnR5aHRXMmQ0UW5hZWo1TkNR?=
 =?utf-8?B?all3aVZzRllDT2M3TEVHRmJkZHRFbHJnZU0yeU0vNUNMamJDK2F6R0lTWko1?=
 =?utf-8?B?RW1udUZDRTI1SmR3ZXFSTGh6eVZIakFjTkw1YVJ2S2ZlcHJvQ3BNQjB2ZXdX?=
 =?utf-8?B?b1k3TFpRbzFXaGJSV0k3YzlZRGpHRUtHUUE4N2RJVUN6aDNSNTFpY3k3TzBy?=
 =?utf-8?B?clVXczdzT3paYVpqOVNEZGpQV2tmSFpUdWY5ZC9oN0tTaE1OTTNwTFpuUXo2?=
 =?utf-8?B?SUc0dVRHbWFpQW1xdXAvTHJhSzFLY2sxcGsxWElBalBpSERPcitIMVBvRjQw?=
 =?utf-8?B?STFuZ21tOXltNXY4RlJueTZ1cXlmakwwY2JuTlRTVVJKSXNmaU9hWjBxSkQr?=
 =?utf-8?B?Z3ZlVFBjRFFkMlJKREc2b3hjTStwV29XaGVyVzBmQWZGOGh1MVUxaGZCVU9m?=
 =?utf-8?B?dldiRjNDMEY0WWZIdmdiS3dpZHdvTkZ5MjhnQ3c3MDBhcUtKd0NkSUo1dCtV?=
 =?utf-8?B?NE40d01XMFFrR3h5SHZJcHFic3pSalpnYnlIQTVObk1iTHN5NEYvL2cxZ1k2?=
 =?utf-8?B?YWRISTBDc25hbSszTnFXZTl3M3ZYUlVhZ0hSRHhUMm5rSnd3ZHNhUSsrK2JY?=
 =?utf-8?B?THVtTVZTTW1hVHEzUC94OFJYcEltekpMR3RuVC92c3lyZmV0eDhsK2I0eGxS?=
 =?utf-8?B?dDZxWDY0dlhnQjVEK1pwQ09CdUZ3OGtLeWlsOVd2MDZmeWljZ2FXN1NITHVK?=
 =?utf-8?B?V2NBbzM3aU8wbmlaZXR1SG1qZFcvdG5sRTF3bDVQakRTNUdTZzVEZDJsQTRX?=
 =?utf-8?B?WXRaSWZ6TU95Sk5hVG55aW9jUHR3OGFXOEZ5K2RHNmR5UXpFVjF2aGpFdHJv?=
 =?utf-8?B?YzZ0d0hZaElTZlBSdm5aS3ZVeHNDN2h5S1N1U0xtZjlYS3B0eTh0V1A3MjVO?=
 =?utf-8?B?STFmeEFXa0JFcW9LREtsdktzODZ1cnJaMm9XdzJNamk3ckVkRnZkS1BqK0g2?=
 =?utf-8?B?R0RVeWpBcm5HeGhodVRVZjhlT1RGQUNrNkprd3FGM0JkVUlDSWFFYlUweEtP?=
 =?utf-8?B?dHdSZmkyb1g1TnJKcU9ZVzhhTW1qTzB2NnBhelRlZkhCYm5RUnhYT2lvRWVR?=
 =?utf-8?B?RExSVVJOM3JUSHJyWUxRaUl4aEwrUk9TdTc2SGo5TFp2Y2loSUl0WEJyQ1pL?=
 =?utf-8?B?cnJSZXcwS2NJbVVDN0JZV0hIR0lsME0wbmluR09sb2xWcHBLZW93N3pMSHhB?=
 =?utf-8?B?UDY2VkwwdWhNMStQdzJKeFBaV2s2WWhrL2Z3SDZuQ3k0NnlpS2wzUkN1T09R?=
 =?utf-8?B?OVJNTWtCeE1hNTFCcGNrazJlRkgyMnBVSmtkQ0xTTnphL3ErTDB0QmJ2dmdU?=
 =?utf-8?B?S0FsSXpVZms0WElUMEVmalNZMWpwUlJBWlN6eHRuaENCTlY0bDBKRU1ZK2Zs?=
 =?utf-8?B?MmNZY1ViYU5aMEZmaFpJc2tobFVZMkl0cWNWR1ZxU09lRitKdDQvRStqQi9L?=
 =?utf-8?B?MnhQMEVFRllNODlIN1haMU90NTk5VWFyU2ZIS21xd3M2bitiT3d1Y0J2cm5h?=
 =?utf-8?B?R0kyekcyZnRCOEJrMEVpTG1PS1ZoTnpqaUhzSGpyakl2UnhKcGl0Y08yakZN?=
 =?utf-8?B?bmVINHZkcHBjU1VEVVFVZDczZXRqRnhlS1pZenEyUnNpWDNsaWNibktEcWxO?=
 =?utf-8?Q?We0x2XcG3NT+Pw0ICkkjY9MtN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c76f1ee-5657-4170-5463-08ddfa471cbd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 02:15:49.0588 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1RB5uK0TRvPoTd8YN7b86az0qRdHK+zYbeDf4N63FVM0qfuAfaLPQjIQ307pz7S/L0SRhSGgVdQRMtep9x7+/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9835
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

From: Ye Li <ye.li@nxp.com>

Add board-level code and defconfig for the i.MX943 EVK board, supporting
multiple SOM variants: 19x19 LPDDR5, 19x19 LPDDR4 and 15x15 LPDDR4.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Acked-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
---
 arch/arm/mach-imx/Makefile              |   2 +-
 arch/arm/mach-imx/imx9/Kconfig          |   8 +++
 board/freescale/imx94_evk/Kconfig       |  12 ++++
 board/freescale/imx94_evk/MAINTAINERS   |   6 ++
 board/freescale/imx94_evk/Makefile      |  11 +++
 board/freescale/imx94_evk/imx94_evk.c   |  41 ++++++++++++
 board/freescale/imx94_evk/imx94_evk.env | 100 +++++++++++++++++++++++++++
 board/freescale/imx94_evk/spl.c         |  81 ++++++++++++++++++++++
 configs/imx943_evk_defconfig            | 115 ++++++++++++++++++++++++++++++++
 doc/board/nxp/imx943_evk.rst            | 112 +++++++++++++++++++++++++++++++
 doc/board/nxp/index.rst                 |   1 +
 include/configs/imx94_evk.h             |  24 +++++++
 12 files changed, 512 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index fa2cdaba144..1efe690e876 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -223,7 +223,7 @@ endif
 
 ifeq ($(CONFIG_ARCH_IMX9)$(CONFIG_ARCH_IMX8ULP), y)
 
-ifneq ($(and $(CONFIG_IMX95),$(CONFIG_BINMAN)),)
+ifneq ($(and $(CONFIG_BINMAN),$(or $(CONFIG_IMX95),$(CONFIG_IMX94))),)
 SPL: spl/u-boot-spl.bin FORCE
 	$(call if_changed,mkimage)
 else
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index f2011448c23..48f458fa55c 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -106,6 +106,13 @@ config TARGET_IMX95_19X19_EVK
 	imply BOOTSTD_FULL
 	imply OF_UPSTREAM
 
+config TARGET_IMX943_EVK
+	bool "imx943_evk"
+	select IMX94
+	imply BOOTSTD_BOOTCOMMAND
+	imply BOOTSTD_FULL
+	imply OF_UPSTREAM
+
 endchoice
 
 source "board/freescale/imx91_evk/Kconfig"
@@ -114,6 +121,7 @@ source "board/freescale/imx93_frdm/Kconfig"
 source "board/freescale/imx93_qsb/Kconfig"
 source "board/phytec/phycore_imx93/Kconfig"
 source "board/variscite/imx93_var_som/Kconfig"
+source "board/freescale/imx94_evk/Kconfig"
 source "board/freescale/imx95_evk/Kconfig"
 
 endif
diff --git a/board/freescale/imx94_evk/Kconfig b/board/freescale/imx94_evk/Kconfig
new file mode 100644
index 00000000000..a4237244ace
--- /dev/null
+++ b/board/freescale/imx94_evk/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_IMX943_EVK
+
+config SYS_BOARD
+	default "imx94_evk"
+
+config SYS_VENDOR
+	default "freescale"
+
+config SYS_CONFIG_NAME
+	default "imx94_evk"
+
+endif
diff --git a/board/freescale/imx94_evk/MAINTAINERS b/board/freescale/imx94_evk/MAINTAINERS
new file mode 100644
index 00000000000..95309430734
--- /dev/null
+++ b/board/freescale/imx94_evk/MAINTAINERS
@@ -0,0 +1,6 @@
+i.MX94 EVK BOARD
+M:	Alice Guo <alice.guo@nxp.com>
+S:	Maintained
+F:	board/freescale/imx94_evk/
+F:	include/configs/imx94_evk.h
+F:	configs/imx943_evk_defconfig
diff --git a/board/freescale/imx94_evk/Makefile b/board/freescale/imx94_evk/Makefile
new file mode 100644
index 00000000000..ca31602f6ba
--- /dev/null
+++ b/board/freescale/imx94_evk/Makefile
@@ -0,0 +1,11 @@
+#
+# Copyright 2025 NXP
+#
+# SPDX-License-Identifier:      GPL-2.0+
+#
+
+obj-y += imx94_evk.o
+
+ifdef CONFIG_SPL_BUILD
+obj-y += spl.o
+endif
diff --git a/board/freescale/imx94_evk/imx94_evk.c b/board/freescale/imx94_evk/imx94_evk.c
new file mode 100644
index 00000000000..28d512ac5f3
--- /dev/null
+++ b/board/freescale/imx94_evk/imx94_evk.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include <asm/arch/clock.h>
+#include <asm/gpio.h>
+#include <asm/mach-imx/sys_proto.h>
+#include <env.h>
+#include <fdt_support.h>
+
+int board_early_init_f(void)
+{
+	init_uart_clk(0);
+	return 0;
+}
+
+int board_init(void)
+{
+	return 0;
+}
+
+int board_late_init(void)
+{
+	if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC))
+		board_late_mmc_env_init();
+
+	env_set("sec_boot", "no");
+
+	if (IS_ENABLED(CONFIG_AHAB_BOOT))
+		env_set("sec_boot", "yes");
+
+	return 0;
+}
+
+int board_phys_sdram_size(phys_size_t *size)
+{
+	*size = PHYS_SDRAM_SIZE + PHYS_SDRAM_2_SIZE;
+
+	return 0;
+}
diff --git a/board/freescale/imx94_evk/imx94_evk.env b/board/freescale/imx94_evk/imx94_evk.env
new file mode 100644
index 00000000000..2baf1bbadcb
--- /dev/null
+++ b/board/freescale/imx94_evk/imx94_evk.env
@@ -0,0 +1,100 @@
+#ifdef CONFIG_AHAB_BOOT
+sec_boot=yes
+#else
+sec_boot=no
+#endif
+
+jh_root_dtb=imx943-evk-root.dtb
+jh_mmcboot=setenv fdtfile ${jh_root_dtb};
+	setenv jh_clk kvm.enable_virt_at_load=false cpuidle.off=1 clk_ignore_unused kvm-arm.mode=nvhe;
+	setenv jh_root_mem 0x60000000@0x90000000,0x100000000@0x100000000;
+	if run loadimage; then
+		run mmcboot;
+	else run jh_netboot; fi;
+jh_netboot=setenv fdtfile ${jh_root_dtb};
+	setenv jh_root_mem 0x60000000@0x90000000,0x100000000@0x100000000;
+	setenv jh_clk kvm.enable_virt_at_load=false cpuidle.off=1 clk_ignore_unused kvm-arm.mode=nvhe; run netboot;
+
+initrd_addr=0x93800000
+emmc_dev=0
+sd_dev=1
+scriptaddr=0x93500000
+kernel_addr_r=CONFIG_SYS_LOAD_ADDR
+image=Image
+splashimage=0xA0000000
+console=ttyLP0,115200 earlycon
+fdt_addr_r=0x93000000
+fdt_addr=0x93000000
+cntr_addr=0xA8000000
+cntr_file=os_cntr_signed.bin
+boot_fit=no
+fdtfile=CONFIG_DEFAULT_FDT_FILE
+bootm_size=0x10000000
+mmcdev=CONFIG_SYS_MMC_ENV_DEV
+mmcautodetect=yes
+mmcargs=setenv bootargs ${jh_clk} ${mcore_args} console=${console} root=${mmcroot}
+prepare_mcore=setenv mcore_args pd_ignore_unused;
+loadbootscript=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${script};
+bootscript=echo Running bootscript from mmc ...; source
+loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
+loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
+loadcntr=fatload mmc ${mmcdev}:${mmcpart} ${cntr_addr} ${cntr_file}
+auth_os=booti ${cntr_addr}
+boot_os=booti ${loadaddr} - ${fdt_addr_r};
+mmcboot=echo Booting from mmc ...;
+		run mmcargs;
+		if test ${sec_boot} = yes; then
+			run auth_os;
+		else
+			if test ${boot_fit} = yes || test ${boot_fit} = try; then
+				bootm ${loadaddr};
+			else
+				if run loadfdt; then
+					run boot_os;
+				else
+					echo WARN: Cannot load the DT;
+				fi;
+			fi;
+		fi;
+netargs=setenv bootargs ${jh_clk} ${mcore_args} console=${console} root=/dev/nfs
+		ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp
+netboot=echo Booting from net ...;
+		run netargs;
+		if test ${ip_dyn} = yes; then
+			setenv get_cmd dhcp;
+		else
+			setenv get_cmd tftp;
+		fi;
+		if test ${sec_boot} = yes; then
+			${get_cmd} ${cntr_addr} ${cntr_file};
+			run auth_os;
+		else
+			${get_cmd} ${loadaddr} ${image};
+			if test ${boot_fit} = yes || test ${boot_fit} = try; then
+				bootm ${loadaddr};
+			else
+				if ${get_cmd} ${fdt_addr_r} ${fdtfile}; then
+					run boot_os;
+				else
+					echo WARN: Cannot load the DT;
+				fi;
+			fi;
+		fi;
+bsp_bootcmd=echo Running BSP bootcmd ...;
+			mmc dev ${mmcdev}; if mmc rescan; then
+			if run loadbootscript; then
+				run bootscript;
+			else
+				if test ${sec_boot} = yes; then
+					if run loadcntr; then
+						run mmcboot;
+					else run netboot;
+					fi;
+				else
+					if run loadimage; then
+						run mmcboot;
+					else run netboot;
+					fi;
+				fi;
+			fi;
+		fi;
diff --git a/board/freescale/imx94_evk/spl.c b/board/freescale/imx94_evk/spl.c
new file mode 100644
index 00000000000..341b165b3c8
--- /dev/null
+++ b/board/freescale/imx94_evk/spl.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include <asm/arch/clock.h>
+#include <asm/arch/mu.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/gpio.h>
+#include <asm/mach-imx/boot_mode.h>
+#include <asm/mach-imx/ele_api.h>
+#include <asm/sections.h>
+#include <hang.h>
+#include <init.h>
+#include <spl.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int spl_board_boot_device(enum boot_device boot_dev_spl)
+{
+	switch (boot_dev_spl) {
+	case SD1_BOOT:
+	case MMC1_BOOT:
+		return BOOT_DEVICE_MMC1;
+	case SD2_BOOT:
+	case MMC2_BOOT:
+		return BOOT_DEVICE_MMC2;
+	case USB_BOOT:
+		return BOOT_DEVICE_BOARD;
+	case QSPI_BOOT:
+		return BOOT_DEVICE_SPI;
+	default:
+		return BOOT_DEVICE_NONE;
+	}
+}
+
+void spl_board_init(void)
+{
+	int ret;
+
+	puts("Normal Boot\n");
+
+	ret = ele_start_rng();
+	if (ret)
+		printf("Fail to start RNG: %d\n", ret);
+}
+
+/* SCMI support by default */
+void board_init_f(ulong dummy)
+{
+	int ret;
+
+	/* Clear the BSS. */
+	memset(__bss_start, 0, __bss_end - __bss_start);
+
+	if (IS_ENABLED(CONFIG_SPL_RECOVER_DATA_SECTION) &&
+	    IS_ENABLED(CONFIG_SPL_BUILD))
+		spl_save_restore_data();
+
+	timer_init();
+
+	spl_early_init();
+
+	/* Need enable SCMI drivers and ELE driver before enabling console */
+	ret = imx9_probe_mu();
+	if (ret)
+		hang(); /* if MU not probed, nothing can output, just hang here */
+
+	arch_cpu_init();
+
+	board_early_init_f();
+
+	preloader_console_init();
+
+	debug("SOC: 0x%x\n", gd->arch.soc_rev);
+	debug("LC: 0x%x\n", gd->arch.lifecycle);
+
+	get_reset_reason(true, false);
+
+	board_init_r(NULL, 0);
+}
diff --git a/configs/imx943_evk_defconfig b/configs/imx943_evk_defconfig
new file mode 100644
index 00000000000..27230ed3207
--- /dev/null
+++ b/configs/imx943_evk_defconfig
@@ -0,0 +1,115 @@
+CONFIG_ARM=y
+CONFIG_ARCH_IMX9=y
+CONFIG_TEXT_BASE=0x90200000
+CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_SYS_MALLOC_F_LEN=0x10000
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_ENV_SOURCE_FILE="imx94_evk"
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0x700000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx943-evk"
+CONFIG_TARGET_IMX943_EVK=y
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_SYS_MONITOR_LEN=524288
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_TEXT_BASE=0x20480000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x204d6000
+CONFIG_SPL_BSS_MAX_SIZE=0x2000
+CONFIG_SYS_LOAD_ADDR=0x90400000
+CONFIG_SPL=y
+CONFIG_SPL_RECOVER_DATA_SECTION=y
+CONFIG_PCI=y
+CONFIG_OF_BOARD_FIXUP=y
+CONFIG_SYS_MEMTEST_START=0x90000000
+CONFIG_SYS_MEMTEST_END=0xA0000000
+CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTCOMMAND="bootflow scan -l; run bsp_bootcmd"
+CONFIG_DEFAULT_FDT_FILE="imx943-evk.dtb"
+CONFIG_SYS_CBSIZE=2048
+CONFIG_SYS_PBSIZE=2074
+CONFIG_BOARD_EARLY_INIT_F=y
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_SPL_MAX_SIZE=0x30000
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_LOAD_IMX_CONTAINER=y
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x93200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1040
+CONFIG_SPL_DM_MAILBOX=y
+CONFIG_SPL_POWER_DOMAIN=y
+CONFIG_SPL_THERMAL=y
+CONFIG_SPL_WATCHDOG=y
+CONFIG_SYS_PROMPT="u-boot=> "
+CONFIG_CMD_ERASEENV=y
+CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CRC32_VERIFY=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_FUSE=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_POWEROFF=y
+CONFIG_CMD_SNTP=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_EFIDEBUG=y
+CONFIG_CMD_RTC=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_GETTIME=y
+CONFIG_CMD_TIMER=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_HASH=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_NOWHERE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_SPL_DM=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_REGMAP=y
+CONFIG_SYSCON=y
+CONFIG_SPL_OF_TRANSLATE=y
+CONFIG_CLK=y
+CONFIG_SPL_CLK=y
+CONFIG_SPL_CLK_CCF=y
+CONFIG_CLK_CCF=y
+CONFIG_CLK_SCMI=y
+CONFIG_SPL_CLK_SCMI=y
+CONFIG_SPL_FIRMWARE=y
+# CONFIG_SCMI_AGENT_SMCCC is not set
+CONFIG_IMX_RGPIO2P=y
+CONFIG_IMX_MU_MBOX=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_FSL_USDHC=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PINCTRL_IMX_SCMI=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_SCMI_POWER_DOMAIN=y
+CONFIG_DM_REGULATOR=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_RTC=y
+CONFIG_DM_SERIAL=y
+CONFIG_FSL_LPUART=y
+CONFIG_ULP_WATCHDOG=y
diff --git a/doc/board/nxp/imx943_evk.rst b/doc/board/nxp/imx943_evk.rst
new file mode 100644
index 00000000000..651db08a0f7
--- /dev/null
+++ b/doc/board/nxp/imx943_evk.rst
@@ -0,0 +1,112 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+imx943_evk
+=======================
+
+U-Boot for the NXP i.MX943 19x19 EVK board
+
+Quick Start
+-----------
+
+- Get ahab-container.img
+- Get DDR PHY Firmware Images
+- Get and Build OEI Images
+- Get and Build System Manager Image
+- Get and Build the ARM Trusted Firmware
+- Build the Bootloader Image
+- Boot
+
+Get ahab-container.img
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+
+.. code-block:: bash
+
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-ele-imx-2.0.2-89161a8.bin
+   $ sh firmware-ele-imx-2.0.2-89161a8.bin --auto-accept
+   $ cp firmware-ele-imx-2.0.2-89161a8/mx943a0-ahab-container.img $(srctree)
+
+Get DDR PHY Firmware Images
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+
+.. code-block:: bash
+
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.28-994fa14.bin
+   $ sh firmware-imx-8.28-994fa14.bin --auto-accept
+   $ cp firmware-imx-8.28-994fa14/firmware/ddr/synopsys/lpddr5*v202409.bin $(srctree)
+
+Get and Build OEI Images
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+Get OEI from: https://github.com/nxp-imx/imx-oei
+branch: master
+
+.. code-block:: bash
+
+   $ sudo apt -y install make gcc g++-multilib srecord
+   $ wget https://developer.arm.com/-/media/Files/downloads/gnu/13.3.rel1/binrel/arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
+   $ tar xvf arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
+   $ export TOOLS=$PWD
+   $ git clone -b master https://github.com/nxp-imx/imx-oei.git
+   $ cd imx-oei
+   $ make board=mx943lp5-19 oei=ddr DEBUG=1 all
+   $ cp build/mx943lp5-19/ddr/oei-m33-ddr.bin $(srctree)
+
+Get and Build System Manager Image
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+Get System Manager from: https://github.com/nxp-imx/imx-sm
+branch: master
+
+.. code-block:: bash
+
+   $ sudo apt -y install make gcc g++-multilib srecord
+   $ wget https://developer.arm.com/-/media/Files/downloads/gnu/13.3.rel1/binrel/arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
+   $ tar xvf arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
+   $ export TOOLS=$PWD
+   $ git clone -b master https://github.com/nxp-imx/imx-sm.git
+   $ cd imx-sm
+   $ make config=mx94evk all
+   $ cp build/mx94evk/m33_image.bin $(srctree)
+
+Get and Build the ARM Trusted Firmware
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+Get ATF from: https://github.com/nxp-imx/imx-atf/
+branch: lf_v2.12
+
+.. code-block:: bash
+
+   $ export CROSS_COMPILE=aarch64-poky-linux-
+   $ unset LDFLAGS
+   $ unset AS
+   $ git clone -b lf_v2.12 https://github.com/nxp-imx/imx-atf.git
+   $ cd imx-atf
+   $ make PLAT=imx94 bl31
+   $ cp build/imx94/release/bl31.bin $(srctree)
+
+Build the Bootloader Image
+--------------------------
+
+.. code-block:: bash
+
+   $ export CROSS_COMPILE=aarch64-poky-linux-
+   $ make imx943_evk_defconfig
+   $ make
+
+Copy flash.bin to the MicroSD card:
+
+.. code-block:: bash
+
+   $ sudo dd if=flash.bin of=/dev/sd[x] bs=1k seek=32 conv=fsync
+
+Boot
+----
+
+Set i.MX943 boot device to MicroSD card
diff --git a/doc/board/nxp/index.rst b/doc/board/nxp/index.rst
index aa7d857346d..670501164b5 100644
--- a/doc/board/nxp/index.rst
+++ b/doc/board/nxp/index.rst
@@ -16,6 +16,7 @@ NXP Semiconductors
    imx93_9x9_qsb
    imx93_11x11_evk
    imx93_frdm
+   imx943_evk
    imx95_evk
    imxrt1020-evk
    imxrt1050-evk
diff --git a/include/configs/imx94_evk.h b/include/configs/imx94_evk.h
new file mode 100644
index 00000000000..f93c3c4e4a8
--- /dev/null
+++ b/include/configs/imx94_evk.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2025 NXP
+ */
+
+#ifndef __IMX94_EVK_H
+#define __IMX94_EVK_H
+
+#include <linux/sizes.h>
+#include <linux/stringify.h>
+#include <asm/arch/imx-regs.h>
+
+#define CFG_SYS_INIT_RAM_ADDR	0x90000000
+#define CFG_SYS_INIT_RAM_SIZE	0x200000
+
+#define CFG_SYS_SDRAM_BASE           0x90000000
+#define PHYS_SDRAM                   0x90000000
+#define PHYS_SDRAM_SIZE			     0x70000000UL /* 2GB  - 256MB DDR */
+#define PHYS_SDRAM_2_SIZE	             0x180000000 /* 8GB */
+
+/* Using ULP WDOG for reset */
+#define WDOG_BASE_ADDR          WDG3_BASE_ADDR
+
+#endif

-- 
2.43.0

