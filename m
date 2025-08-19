Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ECBDCA0EF5
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 08:36:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E15881FEE;
	Tue, 19 Aug 2025 10:36:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="f7wamNm3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A808F82BF6; Tue, 19 Aug 2025 10:36:29 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78B8D80FA1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 10:36:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OTvzwazcTlE1xdpCp+tFKqtIMGiFbbg+6Px4AeXBXrk51413vyd/1IPFp/36IMLW9INaRYgUTtyBAHU9j+/nIUtMCcno6XPuvsMhngVvIGPmPyXTGGAS7yxoc6No8ps+K+tpE/rO8/cVNxvSRSETrm7izHtUspGVxIuvOPTJQTaP1lDfYX0LMfk4S4sc4FKSugy3xOlJD0Rv6zLLY8aDmE6BHcXhbabXAklPUHEE8nmI3WNwUqPk0WkI2ZRTdTOw94Rc4WIT1w5YuoF9YTk7o+0PU/gSbC4Uu5wnlxTNTFni4PPAUzgQSf3G108BisJ7ZGjrIoCn+F8fgxaz3JdbWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97wM85c01jWvAxKwzDcPYS15MrbhsNjPe+B18I8EjWQ=;
 b=L2S2WW3o7PkwrjpUeRu2iwE3J2q8GR/ajkLGdYFlP+c6IvtZ3jqcZPWbp75S3HIvHAXzBaL50S7LHKhMfTNBn3ksNvGKkuI79ii8xN0ZjM+JhT3f2l1E3He3Jj6l/pUMMTg8ECBa7Wc5qfcpZJrn62TJa5Kkl+Rp9k9ZzfbNZHy1hiHQtQ7IeBHEdfLm2Sni02u5+H0VZVMtX5GeTvf9WWFQgxxJLVlj4/SYW3gSw2uXl1suHIMhCP4WQyBLPIz7AM36n9vi8H54NSmLCmPq53W7fEm3Yw2/5a13IGgO0vUDyjoO4LNgDurS5ho+/S23EOTqIYrRW2UEllJ3NqXqQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97wM85c01jWvAxKwzDcPYS15MrbhsNjPe+B18I8EjWQ=;
 b=f7wamNm3hMvjDvmJJn6tl4yP36Ii3ILMWO2fGB5vEy0z4g8cq2aI63pvlPFMf/yupSllMRW4E7qW7CEBJP9e2uUoz6cxWYRjB0KvaGEcx4q7PVy5nC3KVu/tSwm0hF9ngvTzqiKBiyf4mMqrj+MrqmiBtS3H+ks6qzNYRSaS58g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA1PR04MB10986.eurprd04.prod.outlook.com (2603:10a6:102:489::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Tue, 19 Aug
 2025 08:36:25 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 08:36:25 +0000
Message-ID: <527f5d00-646f-40bf-b73c-5877129d9e56@cherry.de>
Date: Tue, 19 Aug 2025 10:36:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/libfdt/fdt_rw: sync SPDX-License-Identifier with
 libfdt
To: Max Merchel <Max.Merchel@ew.tq-group.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot@ew.tq-group.com,
 Masahiro Yamada <masahiroy@kernel.org>
References: <20250814120334.235081-1-Max.Merchel@ew.tq-group.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250814120334.235081-1-Max.Merchel@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0244.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::13) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA1PR04MB10986:EE_
X-MS-Office365-Filtering-Correlation-Id: 8357bb45-f0f2-478f-2d84-08dddefb7bed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXNXOHpxVENYQjd3bkNOWjVodVQ1eVdiRW5QOTE2dFlMN3dkVHRjRjNNL21L?=
 =?utf-8?B?VWhCZU93MVVSSUdzMkpUZjlBcVNmamRJMHczRUxRV3lRQTBIelYzckZVL3Rj?=
 =?utf-8?B?U2VmMElMMTdCY2svSDk2YkZ0Vk9vTU1LYWdUblhiRytzUG5velFMK2hIclNZ?=
 =?utf-8?B?WjdmdGFSWVgzVzlnL1ZHU1JBVURCVE1yT3MwTlkxVy9EU2lydXE0VXR3dmow?=
 =?utf-8?B?Q1lxdGQvbE9mY003dFRwY0EvUDh6MUh1MVk2VUwrbTIyeVQrNjVGUm1ma09Y?=
 =?utf-8?B?VWNaSXdSZGVUK3F4NGd0VVU2OEg1TXFyN1J4bXdDVlQ4Z1BXeFBIZkZiY2FJ?=
 =?utf-8?B?dXM4ZXZQOVJNaWlEK3hRNFd5LzJHOFl6eGdyOG4rcVh1eWEzbUVqbzZhWlRp?=
 =?utf-8?B?Ykl3aUlFNk41aVhDWFZTUWd6MzVHcXZ0YVVnd0RMYzB5QVBpQ29HK1RtSGEz?=
 =?utf-8?B?a3NZUlB1WXNWV05wNVJQelFKbThTMFB0bXBWelgrMVlwNm5WNzRnSGFGNkFD?=
 =?utf-8?B?UFZoVnRnTzdxTy9OQjl0T2kvcEJOVFNYeFBpUlhHQTJQRnFjZ2VIOEp0ZnF3?=
 =?utf-8?B?ZmZ1S3pOaWNUU2NzME5NeVJFTHBXcGhXUHFYL1R2eFV5bUhzWVVOQzE2TjBY?=
 =?utf-8?B?dEwrTXNPQUR0ZHlHZ0xxQXdITmY3WFZHc1FocVA0b2RrblZtNkYzMFZXZkNt?=
 =?utf-8?B?dWpjWHAvRG1tRmEzb01Scy83ZUR2NjN1MXZKOWx0T2JCNDBCZTJEWldWTlI1?=
 =?utf-8?B?MGJheEl2YlZFSTVTVStTdjkycHNFYjFBN093dW8rZ1NuakJHalRZenp3OGo5?=
 =?utf-8?B?VmdKM2ZteUhmc1ZIK1VmRUVWdkQrb252L2QxbnJvcm1FMnVSSC9tc3dhRkRC?=
 =?utf-8?B?MjJRc1V2dTc2TTNpS1ZHV0lSbjlYOXNnaC9VckhYanpOSVREK3NqMElzUnpm?=
 =?utf-8?B?cGhKVk50Snl5Wm8wOGxrOEVSOW82WUF0ZzYva21XbytTWXpYM3d5Q2lGaC9w?=
 =?utf-8?B?SUQvbE5nZXNsbnhEaGZDcFdpUS9UUTEvbmRxWDV6OW1oWDFpdkptWitUb1NX?=
 =?utf-8?B?Vzh1WEdsenZ1UzRQb0w2azU1ZXdGczAvNE5VRU44di9XTzJ3a3JBUVdidDI2?=
 =?utf-8?B?YnBDQm15V0NxUEdqOEJCNEZnMzM0WDZITG56K1ptVmsxV2dOYnk3ZGxGM2k4?=
 =?utf-8?B?N1Vmb0h1NUFBVldscHZiUkMrOSs4bWlMNEdaWW1hN0xLUXh3NnlYZDVPVkFL?=
 =?utf-8?B?bThPLzA2SjZFNjVMaXE0TE9URytjOVRBVEtVVy9xUVFDcXlTUzVWRjRCak50?=
 =?utf-8?B?ZUhORG1SYkxvREN2clR2ODMwU2pYTGg2Z01vL1dkRnpRNTdIRkdaVmIvbDk3?=
 =?utf-8?B?ZUJ1OC93UEtVMVkyMmtkRHNGeUVXbEpjWTh3V3YyM0FKNi9LQnRUb2RybHBn?=
 =?utf-8?B?VlJjdGcvZDk5T0Q3Z2t3MzRhZjc1SXNDdmlaNEZEWFE1WVlibHhVbnl2TVB1?=
 =?utf-8?B?R0w0dzYxQjVZRXg0TnJCcTlQN1RZMTZBZ0VlcHUzaS9pYVA1NWVJVEJycEIy?=
 =?utf-8?B?VkFlVmE4Mk9wOVY4T2VNTWllSVdReGVFaSttZ05RNlZWa3BJSks3aDlKSDBM?=
 =?utf-8?B?eGRMaGVqSU9uYjQ2eXZTQy9SQzUycFJOdFJUU1ppYUV2UkhZck8rZU54dG9Y?=
 =?utf-8?B?Vzh3MU11cyt0L2tHdEVWakFyOUhFRmVPZVBIWnh2SDZDK2pyQjA2aUF1M3FK?=
 =?utf-8?B?dzU5NjF2Q1VIdmJJcFk0dko5NDhmWkhYZGNaQmpTYWJkeGMvUGZZT212OXJl?=
 =?utf-8?B?aTJZSWU5SW1jSGZLTDFMZ0RZR0V4NDJ2KzBvcE9pai9GTXl4Y3pYcHZ2RHJ2?=
 =?utf-8?B?OVNqdHJPY1hsUEtUNDg0N2JxUTVpZjNLMVByWks3YjRlUHNibTZqdFFnV2Zp?=
 =?utf-8?Q?qQW9N5VOW0c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWZZVVBFS25ISHJ2ZFQySmluaGRSNGQydEx1ZU1pcXU1TkVPem5DNVlPMEp0?=
 =?utf-8?B?MWFONHhDa0syS3p0aUd2eVo4ZjlyVkRIWVJkVzBoSUtQTUFEMXNJWUFlN2R6?=
 =?utf-8?B?ZlM4T0xKWTRmKzFKb3VZQ3VmSnc1L29OQUhYSXhrd1NkajZ2K3R3RWl1anVh?=
 =?utf-8?B?SHdRR2I4cld6R0dIU3lXZmNYZm1kaS8wYStPZkw2N1N1TGZzaGFJZGlDd0Vq?=
 =?utf-8?B?SXhNWXA4NnkzdXhZNXRlOEV1d2wyUmNWRkRKUlUvci9HY09sSTQ3Q01Pbnpw?=
 =?utf-8?B?VzRTZXgxTDhqUnRrUThNOFVaUDdwcXBtbERNZXhrdGQ4MkRpYTkzbk41aW90?=
 =?utf-8?B?Q3poYWFjKzc4QkRrb2RSazNrYjBmZnZsMThrL2ppNGYwUlk2OEVHbXBLS1ZW?=
 =?utf-8?B?RjB2Ym5pM0x5WmEvd0s1U3FBdFRrakRld055NzNLYzF6ZmozSXA0d0ljcGRl?=
 =?utf-8?B?c2dscEpEZmMyeG8zQjlZZU9xR09uZlFtRXVMTHF5UGlYOUVxd2xOSkwxU01R?=
 =?utf-8?B?aDJ5aFFtM0tjelhpbFRIbHliZjZwNnh2NGowRFRqUmh6Z2RmaW1RRUtSdC9R?=
 =?utf-8?B?TXpYSTM4V2NnYVBDeU5XRkFxdm1uQlNKNHRRc3AzMG5ENFFCaEx2Nkg0L09G?=
 =?utf-8?B?eWM4VW5wbHBQTHNBNHp5YW1TNjMyMGREYzdlRGZjOC9qcjBETDQrU3lTUWZk?=
 =?utf-8?B?bmpiL1YxdTdpT1RwdG85a3Ixd2RNSldpcElUSHgzQzRYQTlLWW9DRklrWVFn?=
 =?utf-8?B?cUh4TDRYMkZWUGZFUG14eHN4Ym5OVVpQbTJFRXNZcC9zY0hiOERMWUFXNGp3?=
 =?utf-8?B?dUsxemxEazhQdk95Y083NGpSQnVncWFJR1k4U1lxZnAxdnZid2pHRzRpb2Nh?=
 =?utf-8?B?Rm1XbloyMUFUVFBCM3BNY2RncHlRV1NDVU9vRW00SnQxdHpQb3BRbmlKZTA5?=
 =?utf-8?B?d0JlWGFjbHd0MUplZ1ZJV2JidVJFUHVDYldxWUwrajVDa0t6SGM5MGd5MXdU?=
 =?utf-8?B?UmNvT3p0UkNnd0sxWmlpZVlCQVYwQUZNdU9aa1ZSaWI3VE02dTViQzVjQUZH?=
 =?utf-8?B?cHFwMGZUMGdpSmN4T29yc1FieGRZd1dtYS9TWkNYTTVHRnE0NC83OUMrYTdQ?=
 =?utf-8?B?L2x6eVZtdnl2Y3BMT0ZRellpRzJZWm5VbDhrVzVRTjllNlNMT3V6Z0p5SnJa?=
 =?utf-8?B?VU8wbHpLbW5HMy93b0R2MWkrMDJRTFl1UUdrT2Zkbk1YOXV1emZLaHRXRlR3?=
 =?utf-8?B?eVhxc0wwVmlkNlhZamdkczJORzFQVDB6bVI1TFI0M091QmtXV3UvcTQ3bVpD?=
 =?utf-8?B?dXhXL0paUW5BeXhvb3lhY1JLNnVSaDJkZVBpczBqb3NSQWhQK2UzTTRwV2c4?=
 =?utf-8?B?d3R6MFFFcDFZUE1TUm0zV2NoZzFkRjFMVUZQUlhXWVBqM1FzeVJVWHZhRUwx?=
 =?utf-8?B?eEh5R0MyZFRNOW9yNmJBK3VrNUFUdzNCNStuanowS1ZJeUN0azNtamFhYVVF?=
 =?utf-8?B?bEx1SXBlZGNza1dNRDFWa2UrbDNaNy9aWk9LT2w3OHR0VFlaajlZbTZRUXk5?=
 =?utf-8?B?TGV1dW5uQjA4UnFDMUhkdjBtUWVxb0NpYjZDWVZFZXgrNmVoeXNjdWt1eEhp?=
 =?utf-8?B?N3dTbkpmbGhsMVlmWStVTUdzRmxzV0dDeHJXZ09vSE1rUE5UUmJvKytaWCtY?=
 =?utf-8?B?S1pDWExDS2dLNnJsbUplSCtOc3VzeEx3R3Vhb1pGenNJRVFPVzVXeGtvWFow?=
 =?utf-8?B?YW1RNDVZQ3NkcWp3RHQ1VjRLamxUMldSYVU5MUZ1UzN5ZXEyUFZ3dWlrb281?=
 =?utf-8?B?OGtMQXpKZXVsQWYzZVVTbGlmMzVudXRYYWcxSFFTR0RBYjlxM2tPbmovWEVv?=
 =?utf-8?B?RHhlOXY0dHphMjBCaVJzSlFORzlyY0pQTDdpbFpQSVVxYkJ5ZlErcTMrRGlV?=
 =?utf-8?B?SGVTWDk3c2xuWUF1b2hBcW41d24wNHNiUUgzRVRrTU9pbzMxSVZPcDJmVExD?=
 =?utf-8?B?Z0xPZDJ1YytFbUhtUFluelFiMHIwNld3TTBmSHBoYXliRWphMlE0cTh6S2Uy?=
 =?utf-8?B?SEsrRm5tTHV0UGc2NmpPUUo0bWZyRXMxYTZBNDF0dXBnU1Avb2F1QVE1U3JC?=
 =?utf-8?B?c1dFSkxvQ2FwWUV1Z3J2cG13SkE4bVFpS1VuV3o2aUJUSnl6WkN5UXhKTWhJ?=
 =?utf-8?B?czhOWUgyS2s0WWRkRmJtenJVYWgrci83d3RKMlRpeXBFa0U4cnd0U3h2b3By?=
 =?utf-8?B?YWVER3R5Mkd1QnNUcVYrRHQ4NjNnPT0=?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8357bb45-f0f2-478f-2d84-08dddefb7bed
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 08:36:25.5445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DWI5eyP1f+QzjAkwxvD2Fkle8B2taTMLu99llLBc9wTmJVzhGAJngHl07p2wqGbXR7lOxaUj5RPr6dAGhour3IdqKRl45VTrNvLlgWlitOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10986
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

Hi Max,

On 8/14/25 2:03 PM, Max Merchel wrote:
> [You don't often get email from max.merchel@ew.tq-group.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Currently, the terms of both licenses (GPL 2.0 and BSD-3 clause) must be met.

BSD-2-Clause and not BSD-3-Clause.

> However, libfdt uses OR to allow the choice of license used for the project.
> 
> [https://git.kernel.org/pub/scm/utils/dtc/dtc.git/tree/libfdt/fdt_rw.c?h=main&id=739403f222420a2fade2f939d001f51da473b6af]
> 

Technically, the written code isn't part of libfdt and in a separate 
file from it. However, it was actually part of the libfdt_rw file as 
imported from dtc, under the same license.

libfdt_rw initially was released under LGPL-2.1-or-later but got 
relicensed in 2007 to GPL-2.0-or-later OR BSD-2-Clause. According to 
db405d1980e0e3bfdd629399d1dfe457f1f32646, we are in sync with 
v1.4.6-9-gaadd0b65c987 which is much more recent than the license change 
in 2007, so this seems fine to me.

Additionally, I believe the mistake originates from 
35084760a9f492f29434020b64f1db339bf99a23 which forgets to add the OR in 
the SPDX license identifier while the verbatim license language clearly 
states it can be used under the terms of one or the other license.

It would be better to have Masahiro Yamada (added in Cc) confirm that it 
is indeed the intended license since they added the code back in 2018, 
c.f. commit ae9ace7089d2167cbf8a69a29705049ae11c8eea, but this seems 
correct to me.

Please fix the typo and add a bit of context to the commit log as to why 
this is a valid license change (because it actually is) considering the 
code doesn't actually come from the dtc source repo so doesn't *have* to 
follow the license from the original libfdt_rw.c implementation.

Cheers,
Quentin
