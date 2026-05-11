Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE77DCD37BE
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 13:09:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43C3D83DC9;
	Mon, 11 May 2026 15:09:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="FRbK/gsS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5273283DC9; Mon, 11 May 2026 15:09:46 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA87483F14
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 15:09:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hTGXvC4XapnnlZPLsFHx1tIO+X103T3dfPLRH/wIQ9lbNqYaeyv2AnQBf+PgIEmUORh3Mqca0783Bhn5H4hJVeXFBpawZhjfI2kcmS58ZqmhDR+GJnSGku0TBRIV8TkncgEpD0bWDTA1raL5MWgz6smt+F5maPv+/gKL7L0rcVdhVjD/AHH4TwXM50OyBtrT/5MSwSJ81a94XqRjYcv3JsHMSAZj5acbuY1fwFy1bFtEvoq8wb5MaJd5JaU8L16CsKVKCv0xNYmqplamW9ZH1SxGTwR8vYS04jvlsLYTz95YqWxr4ulFecTY5z8yrbDSrC8ey8S2aEM2KQUdu3h03Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JjqGoc1JnHO5tPIdL8Sj5zPOebPKtJQy46Vhsfqdd3w=;
 b=P7IhC9Y0+nUL0wLRVovTLstydAPB6f68VlYhFow2hyTGGROhZHKEFoe7KlDyQjumaE9R9VCvcJStvYWc43FJBjVN+WMYRbA2rIZk3+0FzjrbmfXgRrGFVxBdGGj1oi7Bl8qHyndR/s6W/v1qEdEBmSFQPsXPUTYaCFVD9/Wml/0bfl2NTCfrYXFONj99WWbW4aeoyrW+AXfBIwYsdLtc5RxHhzibEfNimYFfkhx3adO1RRt+Ci3jWJRByFo1SzUSavkZvg/QlrMyeOcgFSCpoDdRBiR7IPESvKVYcEdSY4iczjgaAkhOS2iIBbOKl8PQ3ttZS2/Ht6sMpUr3UAv5kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjqGoc1JnHO5tPIdL8Sj5zPOebPKtJQy46Vhsfqdd3w=;
 b=FRbK/gsS1pz3w4sae0UYEbmHRRvY+NheNvE4m5FR/yDZDreBPv/92W4SMTz8oLPMFGUQ7Qsyu/FZxpm6EoOnDJUyjK9EiOkGO6sj1HUB9OM5CJPD52Vybbm5qULBZjqSrwRkMt4oQuwsx0zpkOvCFHn9vEDtyJSO7BY7p9nVAIU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AM8PR04MB7971.eurprd04.prod.outlook.com (2603:10a6:20b:234::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 13:09:40 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 13:09:40 +0000
Message-ID: <af2cd29f-8767-424a-ac01-4603f50a9ceb@cherry.de>
Date: Mon, 11 May 2026 15:09:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] board: rockchip: add Anbernic RG-DS
To: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de
Cc: jonas@kwiboo.se, trini@konsulko.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org,
 Chris Morgan <macromorgan@hotmail.com>
References: <20260510211713.68312-1-macroalpha82@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260510211713.68312-1-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA3PEPF00000519.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::672) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AM8PR04MB7971:EE_
X-MS-Office365-Filtering-Correlation-Id: 101ed0cc-bf13-4d64-f93a-08deaf5e8f72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Fz3/upRLlkuGVXFi7hOldM/H/bYdQ+oRlmUzmNi6G0HRkdHOPs34RSsT4AYz9Hks/WIZVZTw7xdaTtrER1A4acjJtjpF0Svxx+QiYhfDYLuc06nDi0YnhEMIw6SGa76NJVdJi6w9c6lTZoDYdcXAeJI5ohpzoX0UXV13lS0rsrHNC2BI0DTVyaFWezXcnJ+UXGGaefwhYRJCF1iHebbTjFtivZiV4U4NdfSCC7D9T1PWZ4ytQO8UceOkmhUBCLiUg1sohNt18fDdsTkNNm/Eq7xMEAzSZH2FlWAU4WH/K1+Gt9zLSAn/oJO6k4SLVSLinACLz9hsLSicUWzAYyub7djFv7IpnCvqS5ujsakRJG6CwfDZb+fFKFbF31uQ4o8o6p2ExZTZ8NaD0ADBDveQXqGl+688u7vs4Y82Bdn0/T8Mc2APLu/yFakkU3tfCmKsaBsQMj7vwKPy3U3qlWD8c1cUpLIziA4InIxbo4/JVX7U33YlvsjoLJ3wfcB4DSi7XhqbpHRdZkNY1Q3dq4FfMlDqXZTPXDj5HpPntSSo+88OjGWT3NvBsv3ZVlAIHJ0KwWCLl3z/e+WLAZku60ChXNsEslMi9pYtSJMLt5RUBYBru/Nbi9aIFd/k6vGSiz9wBWw4BORtgF73fB80nKsNPw1jlhd1p+hr2sO6w/E6b32utyeDxAn7CBFkxg2qslCu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(11063799003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGg3WTVRaEl0OHRlc09KRXRqTjVKNkVRY3BoQ0tGUDdjYlJ4czI1UzFFQ3h2?=
 =?utf-8?B?Q2hCL2VNdXFFVEVtY2JIWm9OaXVPQ3FrTS9qZU01OXh4SVZUYk1XNFYzTUhO?=
 =?utf-8?B?SlhDb2szRUp6eVVCcm9qTlZnbnlWUkRUNm9XQ09TOE9VYzJRRit1dUg4ZW1o?=
 =?utf-8?B?NUs2Uk9xakJFZlN2ZkxoSmMrQkZIcVliMUdEQ2pOZmJtZmtteFdVOVVQK1VB?=
 =?utf-8?B?cVVVckd3akI1VHdPejdsVW85OFN5M2t6ZDNHcFd4V1VTa3VhbWJRL25oUXdy?=
 =?utf-8?B?MnpDUThXWEJXS250TFJZb0tpdStzaXZDVDFJbmlhRStZUUdxb01qWFZvYlJK?=
 =?utf-8?B?Wnd3eEJXNUJITkRuTUVnbWh4SThlMmFxeE5RbzRJSThDT2pUZlZia2tHU3Jp?=
 =?utf-8?B?V0QyRlIwUStlZi82czN6ZEN5SHNEQTBpV3FFOU1KSlp4S3RKYUJaL3VnRjEz?=
 =?utf-8?B?QXMvUmJ6NU53NXZ0M1ZZbDNoUHZLTG9WOXhYMUZvN3FGRHd0OW9aVkw1dHIr?=
 =?utf-8?B?bk05YThGRy8vbjhKOTk4NUx2UUhGTVJvR3RFR1NQNUdXc2k1V0R4VkgxV3k5?=
 =?utf-8?B?VFovNWluYmM1N3VmenBTaFY0Ly8ybVZsbUY3dlBmYnQyampSL28xZDJ2YWg0?=
 =?utf-8?B?OFIycUxwbnJLSlE1S2drbEdKbzN5RnhBNUIzMUZ5c1lsaFlSQmVFbEpXM0tW?=
 =?utf-8?B?c1JmOXh4N0FpZy9GbWdWS3hZNThDRWtQMGprYXZkU1hMcGxpZWxIUEd1QWg0?=
 =?utf-8?B?cmdPVFM0REpDeEwrbGpJNElIcXFqYXcyV1FidUhkVHhZcHNTNTVxWlg0c2NX?=
 =?utf-8?B?bEJWM2dDVVpCbjE4SzNrNGFKSFdFOWM5V2gzQTc0TzYwZ3RtU1hYS2hLVjRW?=
 =?utf-8?B?YWVBVTRWNlRuN3p6MHQ3RlRTbVhFQjhpT0xiSTRRdzU2b0RWRDdIOVlMRWFJ?=
 =?utf-8?B?NXlVTUVhUFU3L2tEeDErZ0dZejduWmhWMWJwWXIrK2l0K1pNNEdXNzgxdGIy?=
 =?utf-8?B?UG55cmpRNFg2b3lTeXRQYVdFeFFabUxYdEJOMklFbXo1S1VaQWtSL29SN1p4?=
 =?utf-8?B?TjJvSHcxR0R4R2ZoSDNuSXJzUlhFeUh3WmZnMFFHaEpLeE9OTUE4Q3VSaldN?=
 =?utf-8?B?UEUreitRZEN5N3RxZDBmVTd0UW5ETWJwank3ZjZjbXhWTmdaRFBsZGllOWV3?=
 =?utf-8?B?b0lQdURlU3lVeWI3L0NDUmp3NE9Ha05wZ1lWNVE2Rm1KK0F5Nm1LYlBGOVo3?=
 =?utf-8?B?Qkw1b1RiN2NlSERRc2FwVUlDYy9FQ29YWEl4eXJKSUl6a0lzQzgrY3F2RWJr?=
 =?utf-8?B?WFRDOHNhUDZMZ28xcmRuWGVOUTBXZ01VcHNzTS9EelVuWlJlYWp4L2NjUVI3?=
 =?utf-8?B?dktLRmRwMm0vZWlkSUo2ZmJXQWU4N2RvZEV5ZTV0UExiNHBpbW5WMTZCZEEr?=
 =?utf-8?B?R2Yyczk1Kyt1aGp2VmZ4R1Ftb251VTlIRnJiSFNMYnlJRngvV3ZZVnUweEtn?=
 =?utf-8?B?ZjFkdG8xKys4YVhER2Y5L2RHc1BLc1JXTEVlcFRpejh3SHBaQWFRTEdacXR1?=
 =?utf-8?B?TWtNN0NVNmdQK3dYRzF6YmVFWUFBRDdpTzNwQTl6UzV3ejJtK0RhbGRVUWFE?=
 =?utf-8?B?UkVWc2FxYk0wYVcwK1M0Qkl5MzdWWGdFaGV3SWxNbjJhWE1SQnllbEtqdFBp?=
 =?utf-8?B?VTUzNTI5NG15NmpkTlhQTXpGZTBlNkpBTHZsUW1ObGlZbXBxVVlSQ0ZtWUZN?=
 =?utf-8?B?WXJQU1ZIaUx6UE90S0tXWXB6YUVzYW9LcFpEWExjSUtKSHRvZ0ZpaGVmVGZy?=
 =?utf-8?B?K0haYThhaDFucXFoYWJ3RHBkd1h5SWc5T1MzS1VuWG5uTzhYYnQ2aGgvOE5F?=
 =?utf-8?B?VElFdGNId21MZ2xwc3FPL01xbXhkVnMzOUhURUF5TmxVcWdmNFdlYXQraFB6?=
 =?utf-8?B?eWMrYXlJQWg1YjAyZ3VROHhBY0xqQzkzMUlFUi84emlwTW9DYkQ2cnI3VHRZ?=
 =?utf-8?B?UWNGV3NJb2VFR2Z0OGVBdTBOVi9Ib3gzdXJBaHdNKzFGWVZlWUVwTXFORGFl?=
 =?utf-8?B?YU53UU9GbkhTcW1pOVFhVHZoRW5wL0ZLa21qRWphcC9CRTZMaFpSOHYyUkxU?=
 =?utf-8?B?bER6U3hjTEt0Q1VrOU5PNGZKeEViUmNMaERnTGdxQkJ0M2R6VkVrVGgyWkpr?=
 =?utf-8?B?Q2twVTBkdFFoMDNrbkFrNjRxZENPNG1LMFdhalBoY1pKS2t0TTBXY1RZeXNj?=
 =?utf-8?B?TDlHM0tPNVNiaUlqQk5rZjdKT1lBSGhMQjRSODgwSnB3UkJLQ0RDakxQZXQ3?=
 =?utf-8?B?eC9Ga09VaHEyeU12Y041TElvT1hjREZPSmlLWDNDSVovMjR6UkRDZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 101ed0cc-bf13-4d64-f93a-08deaf5e8f72
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 13:09:40.3719 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4AcON0uS37R5YGPr2WSVkL+EEhZ4IGvAZLlLsMkeOkhnbAWYvQAH02eE3/jJJIBtMEdIJsmi+ftgizgxSMA6/t5sO//CNjFZz3LT1A8FRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7971
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

Hi Chris,

On 5/10/26 11:17 PM, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add support for the Anbernic RG-DS dual-screen handheld gaming device.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
