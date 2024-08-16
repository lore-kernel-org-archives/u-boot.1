Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C74C531DE
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 11:11:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A20B889C1;
	Fri, 16 Aug 2024 13:11:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="R+vhqy3h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEA4D88155; Fri, 16 Aug 2024 13:11:19 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C76C88AC0
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 13:11:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wFepvOaz9vViN3Z1QXXqe11+InGLOeamoLchdvAhEwanNpi81/GIOm/DnbeafjHuMMRjb8ZXErf5+VbPfs/Fmyt+cT1yc7nc9XvRBZDziXMN0ydEbUY7EGghujCFyXpRJflC707/64kgnHgIBThrifJZ21MEwPbxczvLFf3r/ztulsZxioy9c8ZyniVBlpNQ9NH3qahTXOResifrq+CYAW6ZC9jo446seMKnLFX2ySSaLY9KSbtur1uwKt+zXCOw20ztHKLXm5cCDE4obK3n0G4RYHMyj+iDo26q2CyHc6ksl0gDdHnhiTR900CidbRb99rU+xgpw9tBOJrY8WCgqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2I1kpllmKx7SSoJBj7v1xtTdJiUJJy5EaLu2/nKB2PY=;
 b=mFyLQEnMLWDyFYasMiA9HrylDrr7ReTtF7ukqm+7G9M39StEX+v5gSqXezCuclFlFUqyf95yGeSyKHQcgMWe0TH+TS+3kGQ9qr6pn3CuXFCDlgDIc6FRKw4bkaBkHkMnYszCLd11SzHg3ZiH+FaJqJIEwKgQbj02cX2b8F5j4qts/MBeOogfi22FaWgZYzwHRGv1+TgcI5vyflwgFr9PsqTMOMlGWyDAbq9hiYTfdlxV++9hrl/M8FE/mXp79XfJ6qHbkmvDAe+9o4+6DwQfDkQSBNWqZK3Ut4n5XXRdXNP6D4az0hzcf+1mSwSf2PiG/W8K37R5FUP9WS8q0sBp8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2I1kpllmKx7SSoJBj7v1xtTdJiUJJy5EaLu2/nKB2PY=;
 b=R+vhqy3h7/AhG97roCfjsVLlwSjGHkNnSEMvaudUZ0QLdvg35etNIa8rCVhvCgyqWECzN262QifyaYDV5iQKqusl1er9+9uA6tsQcy7UCCN//E6Ei7hNbjX20ivRQmAgCcTwjTIBN4fxf7l4ZyKYwSLyuRHTIE6Ff0MB/em2/+lBsm9gvt5cSYVZMAwQ3YW43zdWfmhtQ8KmB+9FXDmP706K5eSMU1uEdGNgKJXtS66ZNiNsguv4gFQy2f233Qqx7mB7pACqdfK+1qhWyI1YJJ/099+h82vNDKtWnP9gSWtSMog+2INhv9pYsQBZb5MOBkW+YtbjU4B4qYnrJ47Geg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by PA4PR04MB9663.eurprd04.prod.outlook.com (2603:10a6:102:261::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Fri, 16 Aug
 2024 11:11:12 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%4]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 11:11:12 +0000
Message-ID: <59884e68-8099-4b53-8983-bf8fe2bd5e48@oss.nxp.com>
Date: Fri, 16 Aug 2024 19:11:03 +0800
User-Agent: Mozilla Thunderbird
From: Ye Li <ye.li@oss.nxp.com>
Subject: Re: [PATCH] imx: ele_ahab: Add HUK derivation support
To: Mathieu Othacehe <othacehe@gnu.org>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>,
 Sean Anderson <seanga2@gmail.com>
Cc: "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
References: <20240813063243.24249-1-othacehe@gnu.org>
Content-Language: en-US
In-Reply-To: <20240813063243.24249-1-othacehe@gnu.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0124.apcprd02.prod.outlook.com
 (2603:1096:4:188::9) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|PA4PR04MB9663:EE_
X-MS-Office365-Filtering-Correlation-Id: 21918498-1600-481c-aaf6-08dcbde422f7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OGRJWTROQm9nUG5XeGtEZmxTdzJsUzh1ZzBQQjBoM0RoVFovVWxlU29mVTlN?=
 =?utf-8?B?NTRTSHJxL2FVakREVWRmNVdncTNjWjdJUnRUYmFMV0Z5ckE4M2tUWVZXQmtr?=
 =?utf-8?B?cDRhTU5vM042NkpYV3VGYjQ0b0N4bWdGY0t4K0d6c3dkRFpEVnFJbUdaSjN6?=
 =?utf-8?B?YkNKQXVMbys0Vmt0dkM4ckV1MEdnQzN6ait0dDJuZ2o5WWNzaFRIZUtVOXkw?=
 =?utf-8?B?elRoOWNKd2hZb0FxMXpaWWNkSjM4QUVxR2IyUHdJMkoxL3pyN2NWcjEzeTUv?=
 =?utf-8?B?T1A0VGtoVG9YVFZxWmZZUTk5OTNsLzBzVzVKWEVqSFFUYlpHd1ovd0xqTDNo?=
 =?utf-8?B?elpFSHdpem5vVkpGY280MGVCZW8zaUg5ZFZtOHl3cE1yM2F0OGRHa1hsZEhr?=
 =?utf-8?B?ZVpTTjB4RkFINk5TUjRDSXdwc1MrUjkyUDBDK3QzcG1IRFdMREkxbWhoSUVx?=
 =?utf-8?B?REZwNlU5V3VUVEJrcGxueGh4cmQ4cjkxZWRGbVNpeXZQb3hNS1luV0ZrdmJk?=
 =?utf-8?B?aTVJMVBPYlp0K2RWWVkvZ2E1aWllOHdIWlVRbDJCYTlka3h3MENJRUgyN3g0?=
 =?utf-8?B?Zm9YMEhmVHJKTzNNKzV4WXJaUTV1N1FNcWZoeDlRMFpOVFpxQjhoVXI3cmR3?=
 =?utf-8?B?dXUxYXVuMTFwOVczRDR0aDFla0pjN3lpY1FFVXJZWS9aMWdELyt0MjJLVWxW?=
 =?utf-8?B?cHQ1VVl1V2c0a2VIYk1XblRjdXMvS1JwWnVVUkthdzljRmFSa0tnQWJiWGI1?=
 =?utf-8?B?ekFKZVFSNUFqRmJrdE4zakpqNzJrYzJrYmJEVDVRdk9GWFNzTWdEMlRnSUVy?=
 =?utf-8?B?b2w3Q1hqNUM4elQvalFVclRESW94eVFUSU9mMmNSdW9aZ1pRRUtUU3VFenhl?=
 =?utf-8?B?ZWFqbThRQzcxbitzL2l4eWtraUhDRjB3eDdwcVVWQVI2WnlNMEhBYVdNaWcv?=
 =?utf-8?B?clVNWnMrdHZZUjR4SVAxTzRNVTdHbFROenpXK3I1c0tReVo5SFNUc0VKMmpZ?=
 =?utf-8?B?U2ltR0xYK2pUM3c4eVdUczd2dWF5Sk10YUZrSklpeDArWlNoY3h5RDYvQ3RJ?=
 =?utf-8?B?Wk1jWW44SGJScGx3TkNLUm5uTWZrMkpzL3VPWUlpQ1NQc0NRcWcyb1NaU3ox?=
 =?utf-8?B?L1h4dHZUQXBiNUxJcFoyekpKeUxiMDNDUkMwZEUzbUx0Z0w1UUMxQlRMcTlH?=
 =?utf-8?B?TjZIeTJZcGlGVDQrZk9DYiszS3VreEk2THJpMzZSVDJRM0tNckpWNHY4RlRL?=
 =?utf-8?B?cURjSFZta3NLMmx2d1lOTTA0M042bVpDQllHUUY4V0Npek9ia0tORHpFVGpM?=
 =?utf-8?B?T3ZSY0MwSjVPeHlJcytqcTBnUjJURVp3eExvRThiN1lGOFd5UUQ3bDJlWGZ6?=
 =?utf-8?B?a0JiQWgrQTgyUHZmWUppeXEyNjBVU28vcUYvalF1WTVZdWhNbmZ2ZnVMekhW?=
 =?utf-8?B?L2xkWW5zd2VEdm9Bb2ZEdEViSVhnZEJ4NEpYWnlVY3hTNStaYk9PTzAvY2VV?=
 =?utf-8?B?WjcvMm5JRkhHTDZ5ZTNxVUNJTTdBQk50TGpKMlV4UzN3U2pvSmY0M2hNSFBS?=
 =?utf-8?B?TmErR2JyV29RcDBZR2ZCbkZuZTZWb3F3MXhBKzZxWHV2R3NvcFdLL3pweGpO?=
 =?utf-8?B?UDZxWW5ycEdsQVg3REYvM2lOemIzejlEVGZnVDZBc2w0TDh5bDZaQk1XbklL?=
 =?utf-8?B?ME5mdHQvNXFITU5Ra0FwVzZoWEhFMEhoZi82SWNIcFlUQ0ovS2J0Mk1QV1gv?=
 =?utf-8?B?ZThRbHpsNU40a01KL3V4MktKNk1JbGhUMXVYcVRLVlphUEFUQlVTZkZpWkFQ?=
 =?utf-8?B?aDJjekVsd2dNTEJNNjBydz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bURHbWhUU3pvUWhTYW5rNW5naEtqYlBqbGpCVDJWK0VFSUVueUhxdTBUd01s?=
 =?utf-8?B?MGpjMzN1RWJ6RHN1RExPM0lPNHFqVGFoaDN6Smp1b0JsVXZMZzA3SjBvYzZI?=
 =?utf-8?B?bUFJSFZtRThxempTSFRzNEwyTVpMMGlHWnlBVWZRSVBtVVB6VmRNb29UQVUr?=
 =?utf-8?B?WEZjd0VFeUVMOGVBZ2dUd2psYllDSHZUdHMzeFFvS3NZeTB5MXNrd3gzVkhD?=
 =?utf-8?B?ZEJKc0FTcVI1YkFNSmk1UEwyN21IdFZFRlo2aFNBT0pKRzlieEhINEJic3h0?=
 =?utf-8?B?TlA0SUhJYW9kMTRyN1o3R2o4eXQ3dkV1Mng1RWdGeDFnL2dZcEhCbU1zdzhM?=
 =?utf-8?B?Tk9WZStjUHFMSElyYy9jL2lVeXVYTU1YbnNhb0JvUzRnNnh3OGppS1J0dUxP?=
 =?utf-8?B?RGZsaEtXK1djQWZjaDdVand5NjNtOVFiejgyS2xHNWJBZE1HS3VENHRRTWlL?=
 =?utf-8?B?WktrYnl5QjcwNHRheGVJSnFxeEVzU1JmeUN0RmI4OExDaWhOdFNid2lDUDRR?=
 =?utf-8?B?MEh2VGxma3BrcjU2R3NqU2Z1SE9tRm01YWpWMVhtZTZzUG1tVUdpQm1ZcHVQ?=
 =?utf-8?B?blhBaHZYSnBrc05kSEdya3k0Y2pOdXh1amJqdUp5dUcxcUxFKzlFa3YxM3pS?=
 =?utf-8?B?L0h2YzRSWHFUZ0N4ZEswYytneTcwV0tEQTI5bnd6Mk5hUTNTNjBWaG04YXJj?=
 =?utf-8?B?NkFNUjlrNEdXRlY4bFJLc3dNci9WSlRGY3haMTVWeEVRSUpsNzdLV3BMd2JI?=
 =?utf-8?B?Z0pYWERMNXBFeDlXWEJvdDg3eWdxS0xkcy9NKzVTVWZRV0lNNnUrL2VsYTdO?=
 =?utf-8?B?ZnB5eTBqLzBVckFTSEs1VHhhR2owNC9qR1B3Rm1TQmViZmJRdXlJSlhxdGxP?=
 =?utf-8?B?d1NFQVE5bkZsVTJ2QlFBM0VmK3RIWG1QSVEzUlU4VHVrdzQxMVpsYXphOWdn?=
 =?utf-8?B?dkRLRTBBTXV1NHhZdHBWbUtzVUU4KzVKdVA1b3Qvbkx0VE50Wi96cEh6aDd0?=
 =?utf-8?B?aVpmMzVoNzU5ZDRmQ0dWOFJyVml1VXFjK1hYdWluTCsyT2FaWkdQLzZqa3hZ?=
 =?utf-8?B?MlZOWkR6UG9kTzBYN3p5d2EzbWlsdkdXckxTVzcvSzA5OXpwcVJmV2dqeGNa?=
 =?utf-8?B?L0liRzRkQnBFd3piWjI0R2g4aGxSL2hwYnpmQ21RNnQycmwzcUVETGRvSUxl?=
 =?utf-8?B?QUpPY2E4QlIxbWJQY2hKVGYzVHBnWjh2eEhRSmw5NzN2RWNxYW9TeTkyaDcx?=
 =?utf-8?B?TWI3WUhYWVVSY0VVMkpjUm4vSGdWZmN0L0hGTkU2MWxrUUpaa01IdlR3OWFj?=
 =?utf-8?B?NHgxdEdidStEYldIYlIvSVZQUlhSRFBGamhyeXQ0dU8ybXorR0VvQUdmeDls?=
 =?utf-8?B?YXI5ZVVZK1prNHhqSVJ1ejRjbU0yZ3RiSUZrQVBJRmhyTEFrV2lJME1VOUYw?=
 =?utf-8?B?b3VGbXN3KzZLcmwyVGF5OW1ETW4weG1IS05LeWZvNDY1TDRDaGtCT25oQ053?=
 =?utf-8?B?cDIvbm9SZ1p1S3NoSFFqV1dXK250Uk9tQStHNzFxMkVwWjNhNVZtdGpDOHo3?=
 =?utf-8?B?RDdmdk5GNHpHUUk2TUVvMzN4aFNuRTU2bzBFaVc0Ky90NUcrTlpGcnY0N2FN?=
 =?utf-8?B?MWRRa0x6RVFRblJKeTVwNlozQ0huanN0NCtuOTNJRWVmTGpMUWV5TWc5bVNM?=
 =?utf-8?B?TDZFV2RIeVBTRUhTb3U4aU40WEdTUjNndnAxOW5DalFTMVBKZ1ZrbFFpS0pY?=
 =?utf-8?B?YTdkUFZWV0RldHVja2RjYTlja1N0U1dIblRhaENLZm1BcytFWi95cUtlajlT?=
 =?utf-8?B?MkZFQXZRVzBVN0V5c3M5RGFSeDRKVHB4Q1J3ZHNqYm5rUzNpdWhxMjNlN2Fm?=
 =?utf-8?B?TTJidHBxR3RpMEh6VFRwbzNYR1g3M09rdGliQTVGOUNLZk5rWGpZNWNNRWtF?=
 =?utf-8?B?U0tsdjBrMnpnQnVkeUdWMHlvcEdpZW9VQzlNeGMyWGdyNUpjSzUyRVozcjlu?=
 =?utf-8?B?VVo4NDFibDVXWFg0ek1CTHhmbGw4THBLckNEelhYSFg5RzlFWEFMRUNWWWIw?=
 =?utf-8?B?UldJbGhkc085T0dOajNwUGhCdTJXZGlsYmFabnBOeDhJSENDOHVoSm1RT3Nm?=
 =?utf-8?Q?cIP2jAPjR+qg9RKExs83NZUyd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21918498-1600-481c-aaf6-08dcbde422f7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 11:11:12.0185 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hkpmrylTGUdr0fDDYYkIk4X0p14+VDZPAfssFHe2YVFA2xe/yw/Ui3j9Q95zSDAN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9663
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

Hi Mathieu,


On 8/13/2024 2:32 PM, Mathieu Othacehe wrote:
> Add a new ahab_derive command that derives the hardware unique key (HUK)
> into a 16 or 32 bytes key and stores it at the given address.
>
> Signed-off-by: Mathieu Othacehe<othacehe@gnu.org>
> ---
>   arch/arm/include/asm/mach-imx/ele_api.h |  2 +
>   arch/arm/mach-imx/ele_ahab.c            | 31 +++++++++++
>   drivers/misc/imx_ele/ele_api.c          | 73 +++++++++++++++++++++++++
>   3 files changed, 106 insertions(+)
>
> diff --git a/arch/arm/include/asm/mach-imx/ele_api.h b/arch/arm/include/asm/mach-imx/ele_api.h
> index a29b849d903..490292ab023 100644
> --- a/arch/arm/include/asm/mach-imx/ele_api.h
> +++ b/arch/arm/include/asm/mach-imx/ele_api.h
> @@ -26,6 +26,7 @@
>   #define ELE_GET_EVENTS_REQ (0xA2)
>   #define ELE_COMMIT_REQ (0xA8)
>   #define ELE_START_RNG (0xA3)
> +#define ELE_CMD_DERIVE_KEY (0xA9)
>   #define ELE_GENERATE_DEK_BLOB (0xAF)
>   #define ELE_ENABLE_PATCH_REQ (0xC3)
>   #define ELE_RELEASE_RDC_REQ (0xC4)
> @@ -143,6 +144,7 @@ int ele_read_common_fuse(u16 fuse_id, u32 *fuse_words, u32 fuse_num, u32 *respon
>   int ele_release_caam(u32 core_did, u32 *response);
>   int ele_get_fw_version(u32 *fw_version, u32 *sha1, u32 *response);
>   int ele_get_events(u32 *events, u32 *events_cnt, u32 *response);
> +int ele_derive_huk(u8 *key, size_t key_size, u8 *ctx);
>   int ele_commit(u16 fuse_id, u32 *response, u32 *info_type);
>   int ele_generate_dek_blob(u32 key_id, u32 src_paddr, u32 dst_paddr, u32 max_output_size);
>   int ele_dump_buffer(u32 *buffer, u32 buffer_length);
> diff --git a/arch/arm/mach-imx/ele_ahab.c b/arch/arm/mach-imx/ele_ahab.c
> index d02316ed6cb..e1946467468 100644
> --- a/arch/arm/mach-imx/ele_ahab.c
> +++ b/arch/arm/mach-imx/ele_ahab.c
> @@ -625,6 +625,31 @@ static int do_ahab_return_lifecycle(struct cmd_tbl *cmdtp, int flag, int argc, c
>   	return CMD_RET_SUCCESS;
>   }
>   
> +static int do_ahab_derive(struct cmd_tbl *cmdtp, int flag, int argc,
> +			  char *const argv[])
> +{
> +	ulong key;
> +	size_t key_size;
> +	char *seed = "_ELE_AHAB_SEED_";
> +
> +	if (argc != 3)
> +		return CMD_RET_USAGE;
> +
> +	key = hextoul(argv[1], NULL);
> +	key_size = simple_strtoul(argv[2], NULL, 10);
> +	if (key_size != 16 && key_size != 32) {
> +		printf("key size can only be 16 or 32\n");
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	if (ele_derive_huk((u8 *)key, key_size, seed)) {
> +		printf("Error in AHAB derive\n");
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	return CMD_RET_SUCCESS;
> +}
> +
>   static int do_ahab_commit(struct cmd_tbl *cmdtp, int flag, int argc,
>   			  char *const argv[])
>   {
> @@ -681,6 +706,12 @@ U_BOOT_CMD(ahab_return_lifecycle, CONFIG_SYS_MAXARGS, 1, do_ahab_return_lifecycl
>   	   "addr - Return lifecycle message block signed by OEM SRK\n"
>   );
>   
> +U_BOOT_CMD(ahab_derive, CONFIG_SYS_MAXARGS, 3, do_ahab_derive,
> +	   "Derive the hardware unique key",
> +	   "addr [16|32]\n"
> +	   "Store at addr the derivation of the HUK on 16 or 32 bytes.\n"
> +);
> +
>   U_BOOT_CMD(ahab_commit, CONFIG_SYS_MAXARGS, 1, do_ahab_commit,
>   	   "commit into the fuses any new SRK revocation and FW version information\n"
>   	   "that have been found into the NXP (ELE FW) and OEM containers",
> diff --git a/drivers/misc/imx_ele/ele_api.c b/drivers/misc/imx_ele/ele_api.c
> index e0ec22c7abf..0eaf51e31c8 100644
> --- a/drivers/misc/imx_ele/ele_api.c
> +++ b/drivers/misc/imx_ele/ele_api.c
> @@ -1,12 +1,14 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
>    * Copyright 2020, 2023 NXP
> + * Copyright 2024 Mathieu Othacehe<othacehe@gnu.org>
>    *
>    */
>   
>   #include <common.h>
>   #include <hang.h>
>   #include <malloc.h>
> +#include <memalign.h>
>   #include <asm/io.h>
>   #include <dm.h>
>   #include <asm/mach-imx/ele_api.h>
> @@ -528,6 +530,77 @@ int ele_start_rng(void)
>   	return ret;
>   }
>   
> +int ele_derive_huk(u8 *key, size_t key_size, u8 *seed)
> +{
> +	struct udevice *dev = gd->arch.ele_dev;
> +	struct ele_msg msg;
> +	int msg_size = sizeof(struct ele_msg);
> +	const size_t seed_size = 16;

Please try to pass seed size as a parameter, not hard code it. So users 
can set different seed.


Best regards,

Ye Li

> +	u8 *seed_aligned, *key_aligned;
> +	int ret, size;
> +
> +	if (!dev) {
> +		printf("ele dev is not initialized\n");
> +		return -ENODEV;
> +	}
> +
> +	if (key_size != 16 && key_size != 32) {
> +		printf("key size can only be 16 or 32\n");
> +		return -EINVAL;
> +	}
> +
> +	seed_aligned = memalign(ARCH_DMA_MINALIGN, seed_size);
> +	if (!seed_aligned) {
> +		printf("failed to alloc memory\n");
> +		return -EINVAL;
> +	}
> +	memcpy(seed_aligned, seed, seed_size);
> +
> +	key_aligned = memalign(ARCH_DMA_MINALIGN, key_size);
> +	if (!key_aligned) {
> +		printf("failed to alloc memory\n");
> +		ret = -EINVAL;
> +		goto ret_seed;
> +	}
> +
> +	size = ALIGN(seed_size, ARCH_DMA_MINALIGN);
> +	flush_dcache_range((ulong)seed_aligned,
> +			   (ulong)seed_aligned + size);
> +
> +	size = ALIGN(key_size, ARCH_DMA_MINALIGN);
> +	invalidate_dcache_range((ulong)key_aligned,
> +				(ulong)key_aligned + size);
> +
> +	msg.version = ELE_VERSION;
> +	msg.tag = ELE_CMD_TAG;
> +	msg.size = 7;
> +	msg.command = ELE_CMD_DERIVE_KEY;
> +	msg.data[0] = upper_32_bits((ulong)key_aligned);
> +	msg.data[1] = lower_32_bits((ulong)key_aligned);
> +	msg.data[2] = upper_32_bits((ulong)seed_aligned);
> +	msg.data[3] = lower_32_bits((ulong)seed_aligned);
> +	msg.data[4] = seed_size << 16 | key_size;
> +	msg.data[5] = compute_crc(&msg);
> +
> +	ret = misc_call(dev, false, &msg, msg_size, &msg, msg_size);
> +	if (ret) {
> +		printf("Error: %s: ret %d, response 0x%x\n",
> +		       __func__, ret, msg.data[0]);
> +		goto ret_key;
> +	}
> +
> +	invalidate_dcache_range((ulong)key_aligned,
> +				(ulong)key_aligned + size);
> +	memcpy(key, key_aligned, key_size);
> +
> +ret_key:
> +	free(key_aligned);
> +ret_seed:
> +	free(seed_aligned);
> +
> +	return ret;
> +}
> +
>   int ele_commit(u16 fuse_id, u32 *response, u32 *info_type)
>   {
>   	struct udevice *dev = gd->arch.ele_dev;
