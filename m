Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C241D1358C
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 05:57:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49F5E881FD;
	Mon, 28 Oct 2024 06:57:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="McUqQOS1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C678E88F71; Mon, 28 Oct 2024 06:57:08 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::604])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C63388811C
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 06:57:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+gqXqxD91jN8lD5fSWcN8BOrnwxbGZa40I6QFrPIER+HhKO9GFHPLaj+g6tu9Kw3cH1GwWkoZeSXEkAknQtrm3VM9jOJX2nDddY3E5ImcWNsOxbPJwbT4K99qvxJ/0pvtWD5dN//NDPihkJlG0Zm+XP5w/3FJCBgQmn4jrZ86xxhFLVVgTSz4TkuaeeNldLoTTnxTmdAdeltDPOgudJ7YhC7IPhicBDiu6j1bjgw9o74ze8ULn9fiPOLiTqYpxmkoBUFwgATFgTMxgeKIUA3CWKBfCuDBgK8e2FTINbuTti2xgbOdVkHBDfwhFLqtUSOg5LNefjR1of1exGB9LOsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYKmjv1AeoD3hMfe48qg5A7GRRnRR/nCIFW5KTn8U7o=;
 b=NEgsiHXwOyvgiCqDp06hWp0c+H4mFg+T4jZjuMWKIbZ1p0Ennd+H+WMmUB1AEb/s+gxBOQAfqRcf9hd+xg8yo3iHrQMozsqNgWrUY20bcbk+UQZ1SN0cQvZrxnJej/H9ceDTUGuwT3F4iUCLvEWm2BIOQWqRQQzyER6bHH4Sok+7phB98W4sqDnLrN5gZn9eDRhWEZCBMdnXWpuACtN6rwJ/0Gcugvb0OPaHt5enTEpqO+pCJIsatmaX7BTk57cnSov6Wmtv/BUg8Xa6wxuApH65onjW/RDl1dG4+gKNdTF9r14/0lMCXlHY+m8rMRewY2OpEG5ObxpVJ0UPxrNCiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYKmjv1AeoD3hMfe48qg5A7GRRnRR/nCIFW5KTn8U7o=;
 b=McUqQOS1vQTMoS+cmaMSxybart2Y3osxJYCpK8noBgI3LoMnLF0bNZ+6SuGJqmEFHF1hxmvujWd8JEILDbDy/ZPFNpDAJ9Zhc6IKZGlvKeL/ve7Ts0xgCxMq2oip3a+8dOmDwHSfHswsKiZvYWG8HT25Dc/QLJhHkV1jTCXuEX0DZ6kanHBrpErqMAMRJSz22DMC1w5dbuQNMr3sY/BEZTFPgJ6KA2wYKJSNV5K4rgfE7YitYLpKXCzup1KixhV9+bUqKj40Efr47BmEMillZVNS2uTP766kayUwo/EGA4m4tHlP+fodsjlgd01PPE0xWtpDEvCvebD1IPQsVCFqrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7802.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:64d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Mon, 28 Oct
 2024 05:57:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8114.007; Mon, 28 Oct 2024
 05:57:02 +0000
Message-ID: <9403aab1-7d2a-4fa0-b2e0-974fba21e749@siemens.com>
Date: Mon, 28 Oct 2024 06:57:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/13] smbios: Fill UUID from sysinfo when available
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>,
 Nishanth Menon <nm@ti.com>,
 "Li, Hua Qian (DI FA CTR IPC CN PRC4)" <huaqian.li@siemens.com>
References: <cover.1729577070.git.jan.kiszka@siemens.com>
 <9e440edc2a6bdcb7d768d277dd6afb02ab941ecd.1729577070.git.jan.kiszka@siemens.com>
 <CAFLszTitiTcf6HF_3FAxreBDOw8CFSekf_MHEzPcqwzj+b+bPA@mail.gmail.com>
 <a7031021-c8b9-4bbd-8089-c35a4d4e7ee4@siemens.com>
 <CAFLszTjxD+DjGYUd+o3mELCctOnJZO6U6FSkSjr1su7iVTcmpg@mail.gmail.com>
 <6bdd212e-2a70-4c32-a463-c83cbf7bd0c7@siemens.com>
 <CAFLszTgDPYkoc-F2cdMHy2hKb85+zVRdACLiB67ptTUUU+gwvw@mail.gmail.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFLszTgDPYkoc-F2cdMHy2hKb85+zVRdACLiB67ptTUUU+gwvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0155.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7802:EE_
X-MS-Office365-Filtering-Correlation-Id: ccf765e5-187f-4cc8-06b0-08dcf7155820
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U3k5UzkybmtDSkVsRnAwZUxnMFJ1Rm9taG9mL2lWRWZCcE9jVWRnYzNkRnpE?=
 =?utf-8?B?YUNHVEYrUGhBYldKYTQ1bjNuTXFkenZUNWF1em9QbWJJNDBmVjVsREN6aWdy?=
 =?utf-8?B?MGUwM0RoNjhIZzBNOWlDK2I5anNrWEt2NWNxV24rNGtkM0Y5bHNsYmk3c0Y0?=
 =?utf-8?B?YUNLblRzSVhXUkJ6emovMVJXYzBqc2FCdXNKaG0vb0VLdnNUZ3h2cjB0cjFJ?=
 =?utf-8?B?T3J3REZXZ0NOVGxwUzdHdXZvSVFUbHh6Y2xBSXAyNmRLWlFIdXZQUzE5d0cv?=
 =?utf-8?B?Q0pOZlZ5dld0bkNvaU9UQ0tWdVpSakxsRnNKeWsyVEd1bk1ZVTBIK3JQeTBO?=
 =?utf-8?B?aTFvdlpTbnlBTHpPL1BYbG1CTlh4TTU5cjg3TzZxQUhDYzNjWVB5aEpwWEt5?=
 =?utf-8?B?RFNyQWZUZzRTa2tnaHc0Sy9lWGJ0aGU3NVFtKzdneTkwZmtQWGpkN25BUjM2?=
 =?utf-8?B?ajl4UHY5TmtvMHBuZ0hvSURqaGlkYkYyRHFiREhDTkFPZ0Z4MGd0VE1vbzlQ?=
 =?utf-8?B?WEUxRDNwRDdPS3dqVnVlSk5VR3U1Tm9PQzVOSTRhVi82cUtOdkkxVmIzRlgz?=
 =?utf-8?B?QU94OVZSUGVwV1djTlNwcUI0UGtobFE1emtmemtqOVFUR1YrTHk3bDBZL1JR?=
 =?utf-8?B?aEFxWW5WSXZubE83SzYzcWd6TDVrSStONmprUXFYekhpVFZ1VFdxSTZsOS9X?=
 =?utf-8?B?WUV3NXlkZnJ0TyszeUFBbTJrcFI1SThWcGxDNUp3emxtVVBnZTdWZ0dxeVZU?=
 =?utf-8?B?dkpXVnYyelRqa3VhL09MNG9uc1M1M3RzT1ZHelZCRStLRlJFQ3BXQnh1S1hx?=
 =?utf-8?B?VjdtQkczUWk2aUs2RkV6MTdqK0pDcDdRdDhMZ0lRWDV2ajNwV214d3dhQ3hv?=
 =?utf-8?B?N3BmZ2wwTytwSWs0QXlLdllwM3JmbGp0d2pKVzFZVXJRWjIxYXFNN1haZ0h0?=
 =?utf-8?B?SEE4c1ZKZXBCZy82UW0ycmhaRlVnTURyUTcvaHVWREoyMUF0UEcwVzV4QlpD?=
 =?utf-8?B?NW1PSy9UUXdTNXRONzJCdFhaQmNuTjMyUGdxM21Id0FXWHVVOUVPRDIvY0Fv?=
 =?utf-8?B?SVlja1BlT3NzYWJPQUZ0T2E4aXpxS00vOVlkTkNOTm9NdEZPaEFZMHdUNVFP?=
 =?utf-8?B?RGdTeGNyYk1xdUJCRUdDalhrMk4vZXJwZW5yQmhhRGpNQU1semY5b0VRRmEv?=
 =?utf-8?B?ZU13dll1akRGZVViY1lRMmIvZjB5ZzZ0VXpOaVZDY0FYdDF3bW1hS05WMTNa?=
 =?utf-8?B?UlFyd3hsMmJQbzhDK1RZczNyT2EyRjBpYWJxU2tpRDZjalAzYnd4eGRFL203?=
 =?utf-8?B?aUtpTGJhMXdwd1FENm5EQm4yVStUVk9pV00rZkIrZHlscEFHVnAvNFFUcGdk?=
 =?utf-8?B?Z0cySk9VSE9GVFhldGpJRGlYWjdZVVhYK202UkxqVVhKWE96R3ZGekI3NmRH?=
 =?utf-8?B?OHVCSW45a2FnYW1icGNoY3ZxeUpKcllNNHZCMmNIOFR5eHFON0xlam5LaVFp?=
 =?utf-8?B?N0VadnRPOE9SMTlFbk9nZWlsQU10dWlFUE9aTlBtZEEvUkUzT01zcmRhc3ZX?=
 =?utf-8?B?cWtielM5c3RoSzJvVGRwRzFrK3dKQkFJdW01THl0eWpUeGtGSzJYNTBWYXVL?=
 =?utf-8?B?RmpNTUlrZDcyc1Q0cjJkbnFEWFZDcnE3NkpuS3FhTG9HWm5taVk0SjY2U2tK?=
 =?utf-8?B?NEdYbEY1djJCb3FVeDEzeStMaWJwYmdvUjBCbTgxMXBTNXhMWTVMTWR3c0NF?=
 =?utf-8?Q?1kxeprWZzkq/aRR3tBsT94V/MENCH3UYRxJaKEk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnZnSGRYQmZPYnlmdW51dHk3R3dQRWhJMTZic09OSVVWeGFWbTFOaEZRbU1V?=
 =?utf-8?B?WENFbHdLWlNpdWxxUnB0VHdUUHIzL2lqa05RUUhQd3pVNTVsZjlodG5HSENw?=
 =?utf-8?B?TzBSc0MrSlM0NkNHd3dlSUZ1ZzZJMFlMRmJPTG10cjVvUnJLMkRETE1CNnVw?=
 =?utf-8?B?NHRTT0ZvcWtxS1BFN3NtV1k2eVlpTmdVcDJ4bWNBWHdmamlEUjcvdGpJSkdI?=
 =?utf-8?B?U3dUNGlKQjVhemZNNmlwT21UZ0tUSWQ0SVg3azRzOFdBRFpaWDdSL0dWNksy?=
 =?utf-8?B?a3YxNGJoK1J0N1VjWkJKK0IzdCswU2JvOHFVWm1JQVBhYXRoM29HS0hQN2o1?=
 =?utf-8?B?MU5YUzJSTHgrWjExTko5dnRnYnB2U1NnbXZUZXBYakNlc1p1QnJQbVExSWc2?=
 =?utf-8?B?WitSeTVBV2wyUGJyRVNhR2VOd05iUnU4SHg0aE5BOElmZDJWVlpPQXQydHh6?=
 =?utf-8?B?amdickdtcGNEV2p3NFRNTUVHZytYZFVhL2d3TkhWa1FJaFlBQisydDJJQWx0?=
 =?utf-8?B?R2JPT0ZFclVZYUI0L1pHRnNXN3ZHMVlycFRPSG4rVjQ2YktzMXE2OThJUVQ4?=
 =?utf-8?B?OFYzNjdwNnU3QytSaGtwWGtFbjQ3QS9JV2FIeWtVdmRGcXRXWE83ZkxYaHpn?=
 =?utf-8?B?SHJCQXJIeklETHl2UTd5M3BZOXQrcHpaczVRRE42bGhOTWJrREhZdDR5R2Rm?=
 =?utf-8?B?TkUvSGNiSUFkSVh1QVM4MUJYelEyRmUzWW0rUzBMZ2xjYnE2eE85YlA3cjVy?=
 =?utf-8?B?TVk1a0kxZzFlRWU3TkFkMnNtWXJnNGpka05DVTBlZjFkdm5uY2pESllhaGxs?=
 =?utf-8?B?WVFDV2VmMVhMZEg5c3QyOERpT0V4bmtwLzhuUzNOVzlXZlJIM3k2RnZNb2dO?=
 =?utf-8?B?dm15djh5RkdkNkM0cFFlbyt3emhWK3FjT0pxM3p0NmFCVWN2YnIxNmY3V0ZK?=
 =?utf-8?B?WFhBV05SZDFoUktjRTNzcHZmdVc5VkUvOUVJWlMvQzdGbnRUVjZOZTFjbzhq?=
 =?utf-8?B?emVLaG5YckpJVSsydDhYMzFXNkxlMjBrOFJjNmRHa1FjclNKaTMvN2ZnL3NY?=
 =?utf-8?B?TVg1M1R3VnE0U2VUMkVVMVliSEJTT0x2dHF4RlFRSTloY1ZYQnpHVURzRWI4?=
 =?utf-8?B?dmVYR0NVb2x1TGpFeldGL2VaVUg1SzVnRHRyUC9oY3FsUEF5WGZwbDBWM0VR?=
 =?utf-8?B?eEJlS3Q0ZzkzSU5HbFBDZFY4b1Q1U3lsM0dncGJYa2FjQlN2UzVIME5EZm5s?=
 =?utf-8?B?anEzcE9JN1A3VThsRU5WWTRSc2lJZ1BMMkduS0I0cWJvZmJSaytHOUdEZ0g3?=
 =?utf-8?B?ZENwWmllcnl4UEd6aklQUDZNODZzSXZzditxQjhiZzFrbCtqQVdsM01XZ0M4?=
 =?utf-8?B?a01YcytZRUJPb2NYQ2drRVZWNy80Q3UxNHlEaDR0UEVaUW5qUXArcWxhQVVr?=
 =?utf-8?B?dFFRTXdGNGJBR0pYdGY3VHlXMFJoWjBHb2xtdHZtcUpXRG44RG1oTE9vbGdR?=
 =?utf-8?B?Z1RkZS91RGFOOWY4dWd3SVdWRnVrR3Z6bEFIZWh5QTJNbWswbnZHUkZScjNC?=
 =?utf-8?B?bVNhMlNMMWRmcTB2dTJYWW9ndTh2Umk1b1RJMXcwOXBQRHhaWUJka2YzQzZW?=
 =?utf-8?B?dnFJdDU2UGh0MGJYK3g2UE9zdXpNdXpJUzRNbE45WVpkdFNLbHI0WC82NG56?=
 =?utf-8?B?Vm9NazdnaFd4RnZQbm5CV0IvMUFxNHhQV0ZoVWpjRmc4enRBTGlnSXJCYzZr?=
 =?utf-8?B?NXVWSkNHMFpjMytqOURiWHVTbk84WklBbXlCc1hPeHJkdkJsT1k0Rnh5TVVu?=
 =?utf-8?B?RmpYWkU0YU9oTGcyaDYrTVhxcHhUNk5vYXJid3FxZTZFdWNJQlVtR2VZekJr?=
 =?utf-8?B?cGloMXB3Si9DQ24rR1NSRFBBK0xvb0NISUJlZk92MmZCVEdQQjVVT0MrK2F0?=
 =?utf-8?B?VHpLUzFaMS85bVErZnlORU9LL2cya3VlSUlyUDFkaXNHY0l0ZDVhZ2d3ekJ6?=
 =?utf-8?B?NDM1akl3TUd3ZnY2YUFXNWY1Tm4vWStGaHE2c09kZ1YzTFBBQ0VoVFQ2bnc4?=
 =?utf-8?B?T3ZQYVNKNjFoWFpHTWxIUXpWR29IZ0I2YXZCa2M1NHRVY3E1bVFWQm00MFBZ?=
 =?utf-8?Q?Of1l+BQaW99Tc17kYvChgF0rH?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf765e5-187f-4cc8-06b0-08dcf7155820
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 05:57:02.5756 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fRAUON3GwV5vg4+7GkBw6Kpw4yjYB2gg2pub8Zv9wE4owG8nw02vHznLve18nGSad3N2jYfc22KYevERMEIpig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7802
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

On 27.10.24 15:56, Simon Glass wrote:
> Hi Jan,
> 
> On Wed, 23 Oct 2024 at 06:14, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 23.10.24 05:39, Simon Glass wrote:
>>> Hi Jan,
>>>
>>> On Tue, 22 Oct 2024 at 21:41, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>
>>>> On 22.10.24 19:00, Simon Glass wrote:
>>>>> On Tue, 22 Oct 2024 at 08:06, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>>>
>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>
>>>>>> Allow for the sysinfo drivers to provide a system UUID to SMBIOS. Will
>>>>>> be first used by the IOT2050 boards.
>>>>>>
>>>>>> Based on original patch by Li Hua Qian.
>>>>>>
>>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>> ---
>>>>>>  include/sysinfo.h | 1 +
>>>>>>  lib/smbios.c      | 4 ++++
>>>>>>  2 files changed, 5 insertions(+)
>>>>>
>>>>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>>>>
>>>>> What is this used for? Would you mind adding a comment for it? Should
>>>>> mention that it is a struct uuid
>>>>>
>>>>
>>>> What exactly is unclear here? The System UUID is a part of the SMBIOS
>>>> spec that U-Boot just ignored so far.
>>>
>>> OK, well that just mention that, along with the data type.
>>>
>>
>> Now that I look at your data type comment again: It's actually not ok to
>> misuse sysinfo_get_str for transporting this. The UUID is not converted
>> into a string by the driver, it is rather returned raw and may even
>> terminate prematurely if containing some zero. We need a new
>> sysinfo_get_bin or raw op.
> 
> Yes, perhaps just sysinfo_get() to read binary info?
> 

-EEXIST: "Return the sysinfo device for the sysinfo in question"

Jan

-- 
Siemens AG, Technology
Linux Expert Center
