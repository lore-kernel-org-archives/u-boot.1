Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3BDFC021A0
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 19:00:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA72880F5C;
	Thu, 13 Feb 2025 20:00:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="fB8Ng3pA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 627C080F62; Thu, 13 Feb 2025 20:00:29 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::60d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0739680EBD
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 20:00:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MRV7eBUahUuGlFUV5VRf6wSVriU00cFRz9m83P1eX4P56TqvpU3vb15VR7DI2tK/AxQy+hqx1oC2U5O9wE0ApNvzzupJBcvxNkCuACMu5tVy0yGsxiQW9iZjboebCgVXDwJ5bLP5xBam968FGpZ5xw82jEzFx8SSKxv1tGj4ao1hKczrgU/RsDrS/vPgfnHwMVznxXq4BsDAOjrwG6JdkyRNrFOd0BROZhd24rd+gkWSlNdQGTSoxQiDUQTPdatIjoDZznarFPtYrXh96RgaZm4bzi+MFqfxWsSmIvcjdt+Ktk+zmeZUBgcdfN9KNq8m8vL4QuXVUUWcEyJiUKkTLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vpC+9Yh2TM6CPRCRzqClSnWIZouhVJCODRoUpQU/xjU=;
 b=O+A7Z6nG004dFNDIuWwEx0s0u6UesCvOj3byaQ2zuK1iTTfiRTE+VfUU5exV+oVcvnBvgHXMl6x19oCy5sCfX7aNEddj/t0ch42FNR+sBTIRGq5Ay2pWeNCSts9+tPyGG2goA/lYl716ZPpChvu9I9M+/09faDckBE/v6x5r5Xr0dY9dwDrkxu4FbhmJWS5j3ie7JV8Tg5gGMz8olKgRnDAVRF8drwI5aH+KJtSLbjCRfd1y29KEXrzpm/MwcZ3hZeaE3vH0A3uzVk4db6I7XBcs0v2jOZLSAQzf002WEOAYvQL/5n9jh0EHNqU52Ky4WC3GxvNI2jTBAJNnuwm4tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpC+9Yh2TM6CPRCRzqClSnWIZouhVJCODRoUpQU/xjU=;
 b=fB8Ng3pAzPpN6DoB7K9NmPwzD56eeETs5jlzyMY++Va2sJM4xNJcok2sCz/PgMZ2UUHUTcpLYWG0s1pF0qgG1kaFP9hyZyW6nqlQRWp14/SvlHDkvjtt3YGlRvAy/k2k+l47K4bnODzpWs2Lo/O5XWyrh0FGPwVJsCBuL0tHOhux5eGb3daMXeXr4S1WfG+qn3HStk/lDjOFdFhmRRtkOxPaQiCCzWTzLFypemI1ayfQhcYhUgS07XYKIvWm4kY/B0fEoKzGyHcy9mHvwYuEoQK6xcBLRLhtAZNuz7nJJ+WAhB9jm+X+EtBsyp23V/384gja7tAly0U4bdLoxsdnMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8904.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d1::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.7; Thu, 13 Feb
 2025 19:00:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8445.008; Thu, 13 Feb 2025
 19:00:25 +0000
Message-ID: <1d3da61a-e523-4969-aa3f-f9a1da433c7b@siemens.com>
Date: Thu, 13 Feb 2025 20:00:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] board: siemens: iot2050: Use sysinfo for board
 initialization
To: Baocheng Su <baocheng.su@siemens.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Nishanth Menon <nm@ti.com>, Li Hua Qian <huaqian.li@siemens.com>,
 Bryan Brattlof <bb@ti.com>
References: <20250210130544.2781284-1-baocheng.su@siemens.com>
 <20250210130544.2781284-6-baocheng.su@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250210130544.2781284-6-baocheng.su@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0007.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::17)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8904:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d328c45-2604-42c7-98e5-08dd4c60ac6a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Mldya3hucXlZbEU4Nm95NlNJL095VXRDMC9qQlFpYllzYXdUSjJSaWlRUzE1?=
 =?utf-8?B?RTVLcDVBTmxDQm5Hak1RSGF1aEwxdWYva21meE5XWGhOQklITVRzTEJnU1h6?=
 =?utf-8?B?Tk1veVVJcVAvRk5CUkRJTGxrdG94cHFQUDlDeUdqQ1FIMVJ5NXB2SjJxeFZz?=
 =?utf-8?B?U0pXQVlJcXNvSVJ6Mi9IVExzdi91OVBQcjgyV2xBekxZWHgybWYrR3MvMStu?=
 =?utf-8?B?d3FwYzc4aUNYL2pxMU4rSU15Wml5UHo0eXNITG5SRnJaZEFUNFlqZjZGRE4z?=
 =?utf-8?B?a3Q1OUdaUVpiQmMvanhkelhGT21sOWlZYXQ5TEhqRDZIdjlORERMQ1JkYmJp?=
 =?utf-8?B?aCtWZGdscGxrSzI4MTc0dVdDeFovR3l4ajRSc0p6RE1zVFRNTURQeVFZQlJH?=
 =?utf-8?B?dVNBN3MwdjR5V29hVmV1NFlOQVkrNnVBUUVTQlJxRFBqRGN3S3BQZEJibmZM?=
 =?utf-8?B?eTNoTmRMUTlCR3kxRnhScTJVdTQ0MXFPMkM1c3VCSXllbjdZYnhCcEJyeGRl?=
 =?utf-8?B?cUZxbFJuVmVPcGRDZGpRTWsvaFlGK3VCM2lIZUpnVEx3SE0zTTViUnV4Y3Jo?=
 =?utf-8?B?NDBsZlVxbGpqY050WXZNcUVEZyt0d2diU3ZjbFZORWJQcUVXcVpidFJYUG1j?=
 =?utf-8?B?M3g0NGlLWEp0REtWSm1OVzdtd3NuZFVyUTNWK0UxOXc3dGdGY2FYQm0vamZX?=
 =?utf-8?B?Yko3SVgwbU5hUmJoQ3hVWlJMbU5ROCtyeTFGSlJTY2FOKzBzZHlyeDVkYk0z?=
 =?utf-8?B?QktOUjBKZUVBb1AzanJZTUM3SXNlVmk2bmJnTjRnaWJKV0psYUVvR0lsTmlh?=
 =?utf-8?B?VHVHRnhSUUFtR2FmU1RpY1BMUlR0RkxoL0U2WWIrN0hpL21wcTA1VU44Nng4?=
 =?utf-8?B?UXhTTmpRUjFtdnhGT1B1SVZDLzNhUllOZnhLbk9EdjRCcEpOVUp3UnhFUlFx?=
 =?utf-8?B?V3VuL0VPcHVmUDJlK2tjL2dMOUVLTnpXSGhYU1F2dk9ubENTaW8rK0diVE5R?=
 =?utf-8?B?cUFZN2gvWkVPS0xwRHRjbngyVjI5aGJHUzFVNk9leHBocWltZklHZEJ6WHhQ?=
 =?utf-8?B?U2pWOUhPRmJ1N244TGY2VjFGd2htNjNsTFlTVk8zVEpNbGtHN0gzcFdseUtt?=
 =?utf-8?B?eEdCRlF5OWlBSE9laDIva2pvRFdOaUdtSlJkTGpYY0NCL0x5L0Q1TDlNcTU1?=
 =?utf-8?B?em14VzZLU0pKYlpKOTAwUUZ5R21wem43Z0tBeEVobFZDRG1uV0djQWtwMnYr?=
 =?utf-8?B?ckg5Q01JTTVzTWRtNzRWejR4TUpLWkhRamhjZHR6bGVRRUxHdDNoUWtjOGpX?=
 =?utf-8?B?VnZTUmJheUY2TExwemNIZjIxVDEvYXU5TGJRUG92V0ErZnQyNWlQc09Obktw?=
 =?utf-8?B?QmU3Z1VsbXArRWh1WmRZUWxKREZ5M3Bjekw5SHRUTEttZlFjOTBBK1hINWVL?=
 =?utf-8?B?dEFtYUQ2ZGNWdlBBYU4xbUQ5VEtTR2VHNUFTVnAxczIxb1QvRXBaekJidWtz?=
 =?utf-8?B?K1VXNU8zL3ZzZDNvTjdmcDBkK3BEajdpc3NrSnkyVWpCZ0xSNmtTOFQyaHpl?=
 =?utf-8?B?M2FLSFhYT3BCcmg5dG1HTkJtUnFFNmhqVG9BY1Q3am9IVStTWnEzUlFLT2F4?=
 =?utf-8?B?ZXhvOGxuRW9HVnM5N2xqeUJ5TmJjbm82V1ZQUDlzTEJJVEhDOFRzMytCUExy?=
 =?utf-8?B?eDY0QzZwVG5zUUtpV1B3YTVEODdtZlFocDViamw1VnVFYUVpd252VXJSUnFt?=
 =?utf-8?B?UEZyTGFlUlBSVWVFUzNEa2tNNEVwRkRiMDFvSjBWanl0bzV2WU5nTnBZMUx0?=
 =?utf-8?B?ZTJTLzhVWkhFWWgzOXZtWUpuZ1VtaUxUVmwvOTJ0dHFmd2t1L1VwN0pBTUR4?=
 =?utf-8?Q?TXM4iwcvYoi2m?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTYxbGpOeUd0dDhCVGhRM3dyKzduUm5SNjFsdExVR3JyOVFnaEpsU1Zobm1k?=
 =?utf-8?B?RmI0ZFpOZ2ZWLzdsWERSOFc4aG54T1BZK0VMZTlDOS9RdnY1SVVuN0RZYVEw?=
 =?utf-8?B?MWFkTkZrSmltMHF1V3ZqTEtSNVFPdmpid2RjbHBFMFRrWEJ6Mjl1UFVuQ3Nu?=
 =?utf-8?B?OVlqT3NlKytCV05OdCswVEk4aFZtMjAvU29UbHkxREU2TzB2VlBtWnFHWDBS?=
 =?utf-8?B?NWQxNzl3SVJwRmtQR0d5UXRZcWtpSEFLenpGaElnMGtCQzNQOW9sbDlkRlNH?=
 =?utf-8?B?QnNpS1hoc1ZxeTlEL1dKS2N3MG1pbXI1RzgzbDQ4Z0k4V0lQS3BJai9pc1Vm?=
 =?utf-8?B?akxTU1hYaEhGTU9sRERZMlhIS1pIWUV2cjk1WXBnT0ZsL0pQVXNWMG5HYmdx?=
 =?utf-8?B?aFFFdHZYamY4ZTJ2WDc5eUhQRzJLZ0kzSkVrZzd2MTdPUEFEazZyTHRoRVB2?=
 =?utf-8?B?S1ZpNEpGMmp2REtJSnd0UDkwWmcxcXRMSG1WVGhoSkFxTGJtcmlIdVRlODNk?=
 =?utf-8?B?dlJEaEhNMmwxeG9HSk4yUHN3T1FoOXhHenVUQjlCcmlONnFJVUpoaHk0SjZt?=
 =?utf-8?B?WW5uV2xIejYxelhQSVdaa0IrMm5uTTRwaWJ4a0laTGZ6OXJFbUk0T3RUTTZl?=
 =?utf-8?B?QjArTS82cC85dDh1bE40R0JheXd3T3RzUjVpek82ekpoSkkvNHhrNlNob0xL?=
 =?utf-8?B?azByUHd2TStRNjVLMTJaNXJmOFkxRzNiaWs3MStDVVJ3aDVHQVY4djg4ZjQy?=
 =?utf-8?B?RmRvQlMxNmVnemNQRDhsUmRXclI2TmkwTU5HQk90c1dlZkdpUUpzclZQN29w?=
 =?utf-8?B?Z1Bpczc5TDBYN0Y1LzlGaXhMWGxTNkZGYkswRTBoYXNyQUl4b09PM3BqZ3k2?=
 =?utf-8?B?TFhtaXBoY0dwdVg5UnMvTG9xQ3ErUm1ENjVzRE9JSXl5WDNra2lKcDJhSFU1?=
 =?utf-8?B?aDJTM0cxRGh3bjBYY2hJSS81VG9BL1RoMmZKUEpJUzMrbVQvSnhaVE0zcXh1?=
 =?utf-8?B?azdDYzcyNnZmRS9DL0h0WWt3TU9uUjNSbVh2UUZTanNlOGYzaE9PelM4U0t0?=
 =?utf-8?B?dHBZVEZyNnVLVVpIWUcrOWJxNThoOTJQN3FrRFV0S3pOa0gyQ0I1RFE0dTRx?=
 =?utf-8?B?YmgzS28vaHdvNjRlQlhjelVvdmovNDY1TGlJYW9vNnFkUURpazcxRUdOd1Js?=
 =?utf-8?B?cThyNFFhS0pFMGo2YWRBNGFoRnNIOHBEUXdxTzZuOVFheWNSbmFmSk1abTZ1?=
 =?utf-8?B?NFhudkdsYUNEanZwOWdBVW14ZWtWZks3RkJseTVQVmNHamgyTzd0SHJCazds?=
 =?utf-8?B?a1pvcUxjWjgxT3JPY0xyZnRtQU9PbEg5bDBBQm1VWnRUZklOSXVMa1VQQXdk?=
 =?utf-8?B?QWhNMDlOY0lCNjlpcVJQdFpjUnpzZnEyMi9DWmNhNmxtTGJGTGN5Nk5Md0Ew?=
 =?utf-8?B?THB2SlgrOG9NdXVkRWxyUDhzZ3FLMy9KSWEzbEs0TFlrUHZRMEJJa2I0d0pi?=
 =?utf-8?B?THFxMGYwdEYvcGg2Ty93Y3VGcTd6bWgvMFBWZVh4Ly9sbGl1RG1pKzlNTWI5?=
 =?utf-8?B?Y2lPbGU5RkdQU056ZlVVcGY2YVZKTEVQa1N6ekJub2xDeDR5MnhocFNVUENU?=
 =?utf-8?B?SUk1S2xsNXEzUWNBVWxKTzhyNnJtTVpac29LY2VxRzh3bHRsbTRhT2VON1ky?=
 =?utf-8?B?VnVnUit0NlJhTmZtTTgrcEVleVFEWDRHNVpPN2VEWnNFR3J1UEZHK0poaHJP?=
 =?utf-8?B?ZnlUOVRvK0dGNDlic0ZpY2h6aHZ3Mll1WU1NZEw3V0hiSmtIZjRMcGh0T0JP?=
 =?utf-8?B?TjhVL0R4UElkRjVBNjc1emw0dlZod2hDdmViTHJKeHJmMDNWSjFOc3VRck0w?=
 =?utf-8?B?ZEJrSEdjWFFOSUIvUjcxckg5QTNjeHBmWkVVZnU5c0NwUHA2VVpRa1ZlbXo4?=
 =?utf-8?B?dmNKc2xkSDRSb1RxNzA2bWdnS1hjekEvQk1rQnY2endqMTQwM1dIQmYvQmZL?=
 =?utf-8?B?K2FqRnlGWU9YSVkyS0diKzBHbE9mV2I3MU5rTEZZUHVnWTlEb3ovazU0Qkhy?=
 =?utf-8?B?ZWZTMlUvQXBYVU90emFHWUkzK3pRQkdLdTVzNUVWdGlXdXZTaEQ2S29wSGJ0?=
 =?utf-8?B?SVBRRUF1TGpSeVNzU0V5NDJLU3IvUGN5S3ZOb3ArY1I5WE1MN25VNFhuQ0RM?=
 =?utf-8?B?RXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d328c45-2604-42c7-98e5-08dd4c60ac6a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 19:00:25.1477 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lKCgsIeixV4AQIzwG8pOSmKAjTXtn3qKMxB8UwjMYUsE/8fT0WU7L2WSIKMwUWsJs7K3hcB33xRElk+5herETA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8904
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

On 10.02.25 14:05, Baocheng Su wrote:
> Drop the info structure parsing of the board in favor of our new sysinfo
> driver to avoid code duplication.
> 
> Signed-off-by: Baocheng Su <baocheng.su@siemens.com>
> Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
> [Jan: rebasing, split-up, cleanup]
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> 
> ---
> 
> Changes in v3:
> - reworked to align with the sysinfo driver updates
> 
>  arch/arm/mach-k3/am65x/Kconfig |   2 +
>  board/siemens/iot2050/board.c  | 142 +++++++++++++++++++--------------
>  configs/iot2050_defconfig      |   1 -
>  3 files changed, 82 insertions(+), 63 deletions(-)
> 
> diff --git a/arch/arm/mach-k3/am65x/Kconfig b/arch/arm/mach-k3/am65x/Kconfig
> index 72a8298aebf9..056ae118c9e7 100644
> --- a/arch/arm/mach-k3/am65x/Kconfig
> +++ b/arch/arm/mach-k3/am65x/Kconfig
> @@ -35,6 +35,8 @@ config TARGET_IOT2050_A53
>  	select BOARD_LATE_INIT
>  	select SYS_DISABLE_DCACHE_OPS
>  	select BINMAN
> +	select SYSINFO
> +	select SPL_SYSINFO if SPL
>  	help
>  	  This builds U-Boot for the IOT2050 devices.
>  
> diff --git a/board/siemens/iot2050/board.c b/board/siemens/iot2050/board.c
> index e6bedc389173..d827f728a08c 100644
> --- a/board/siemens/iot2050/board.c
> +++ b/board/siemens/iot2050/board.c
> @@ -25,28 +25,7 @@
>  #include <asm/gpio.h>
>  #include <asm/io.h>
>  
> -#define IOT2050_INFO_MAGIC		0x20502050
> -
> -struct iot2050_info {
> -	u32 magic;
> -	u16 size;
> -	char name[20 + 1];
> -	char serial[16 + 1];
> -	char mlfb[18 + 1];
> -	char uuid[32 + 1];
> -	char a5e[18 + 1];
> -	u8 mac_addr_cnt;
> -	u8 mac_addr[8][ARP_HLEN];
> -	char seboot_version[40 + 1];
> -	u8 padding[3];
> -	u32 ddr_size_mb;
> -} __packed;
> -
> -/*
> - * Scratch SRAM (available before DDR RAM) contains extracted EEPROM data.
> - */
> -#define IOT2050_INFO_DATA ((struct iot2050_info *) \
> -			     TI_SRAM_SCRATCH_BOARD_EEPROM_START)
> +#include "../../../../drivers/sysinfo/iot2050.h"
>  
>  DECLARE_GLOBAL_DATA_PTR;
>  
> @@ -117,6 +96,8 @@ static const char *m2_connector_mode_name[] = {
>  
>  static enum m2_connector_mode connector_mode;
>  
> +static char iot2050_board_name[21];
> +
>  #if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
>  static void *connector_overlay;
>  static u32 connector_overlay_size;
> @@ -149,37 +130,57 @@ static void set_pinvalue(const char *gpio_name, const char *label, int value)
>  	dm_gpio_set_value(&gpio, value);
>  }
>  
> +static bool setup_sysinfo(struct udevice **sysinfo_ptr)
> +{
> +	if (sysinfo_get(sysinfo_ptr)) {
> +		pr_err("Could not find sysinfo device.\n");
> +		return false;
> +	}
> +	if (sysinfo_detect(*sysinfo_ptr)) {
> +		pr_err("Board info parsing error\n");
> +		return false;
> +	}
> +	return true;
> +}
> +
> +static void get_board_name(void)
> +{
> +	struct udevice *sysinfo;
> +
> +	if (iot2050_board_name[0] != 0)
> +		return;
> +
> +	if (!setup_sysinfo(&sysinfo))
> +		return;
> +
> +	sysinfo_get_str(sysinfo, BOARD_NAME, sizeof(iot2050_board_name),
> +			iot2050_board_name);
> +}
> +
>  static bool board_is_advanced(void)
>  {
> -	struct iot2050_info *info = IOT2050_INFO_DATA;
>  
> -	return info->magic == IOT2050_INFO_MAGIC &&
> -		strstr((char *)info->name, "IOT2050-ADVANCED") != NULL;
> +	get_board_name();
> +	return strstr(iot2050_board_name, "IOT2050-ADVANCED") != NULL;
>  }
>  
>  static bool board_is_pg1(void)
>  {
> -	struct iot2050_info *info = IOT2050_INFO_DATA;
> -
> -	return info->magic == IOT2050_INFO_MAGIC &&
> -		(strcmp((char *)info->name, "IOT2050-BASIC") == 0 ||
> -		 strcmp((char *)info->name, "IOT2050-ADVANCED") == 0);
> +	get_board_name();
> +	return strcmp(iot2050_board_name, "IOT2050-BASIC") == 0 ||
> +	       strcmp(iot2050_board_name, "IOT2050-ADVANCED") == 0;
>  }
>  
>  static bool board_is_m2(void)
>  {
> -	struct iot2050_info *info = IOT2050_INFO_DATA;
> -
> -	return info->magic == IOT2050_INFO_MAGIC &&
> -		strcmp((char *)info->name, "IOT2050-ADVANCED-M2") == 0;
> +	get_board_name();
> +	return strcmp(iot2050_board_name, "IOT2050-ADVANCED-M2") == 0;
>  }
>  
>  static bool board_is_sm(void)
>  {
> -	struct iot2050_info *info = IOT2050_INFO_DATA;
> -
> -	return info->magic == IOT2050_INFO_MAGIC &&
> -		strcmp((char *)info->name, "IOT2050-ADVANCED-SM") == 0;
> +	get_board_name();
> +	return strcmp(iot2050_board_name, "IOT2050-ADVANCED-SM") == 0;
>  }
>  
>  static void remove_mmc1_target(void)
> @@ -206,33 +207,43 @@ static void enable_pcie_connector_power(void)
>  
>  void set_board_info_env(void)
>  {
> -	struct iot2050_info *info = IOT2050_INFO_DATA;
> -	u8 __maybe_unused mac_cnt;
> +	struct udevice *sysinfo;
>  	const char *fdtfile;
> +	char buf[41];
>  
> -	if (info->magic != IOT2050_INFO_MAGIC) {
> -		pr_err("IOT2050: Board info parsing error!\n");
> +	if (env_get("board_uuid"))
>  		return;
> -	}
>  
> -	if (env_get("board_uuid"))
> +	if (!setup_sysinfo(&sysinfo))
>  		return;
>  
> -	env_set("board_name", info->name);
> -	env_set("board_serial", info->serial);
> -	env_set("mlfb", info->mlfb);
> -	env_set("board_uuid", info->uuid);
> -	env_set("board_a5e", info->a5e);
> +	if (sysinfo_get_str(sysinfo, BOARD_NAME, sizeof(buf), buf) == 0)
> +		env_set("board_name", buf);
> +	if (sysinfo_get_str(sysinfo, SYSID_SM_SYSTEM_SERIAL, sizeof(buf), buf) == 0)
> +		env_set("board_serial", buf);
> +	if (sysinfo_get_str(sysinfo, BOARD_MLFB, sizeof(buf), buf) == 0)
> +		env_set("mlfb", buf);
> +	if (sysinfo_get_str(sysinfo, BOARD_UUID, sizeof(buf), buf) == 0)
> +		env_set("board_uuid", buf);
> +	if (sysinfo_get_str(sysinfo, BOARD_A5E, sizeof(buf), buf) == 0)
> +		env_set("board_a5e", buf);
> +	if (sysinfo_get_str(sysinfo, BOARD_SEBOOT_VER, sizeof(buf), buf) == 0)
> +		env_set("seboot_version", buf);
>  	env_set("fw_version", PLAIN_VERSION);
> -	env_set("seboot_version", info->seboot_version);
>  
>  	if (IS_ENABLED(CONFIG_NET)) {
> +		int mac_cnt;
> +
> +		mac_cnt = sysinfo_get_item_count(sysinfo, SYSID_BOARD_MAC_ADDR);
>  		/* set MAC addresses to ensure forwarding to the OS */
> -		for (mac_cnt = 0; mac_cnt < info->mac_addr_cnt; mac_cnt++) {
> -			if (is_valid_ethaddr(info->mac_addr[mac_cnt]))
> -				eth_env_set_enetaddr_by_index("eth",
> -							      mac_cnt + 1,
> -							      info->mac_addr[mac_cnt]);
> +		for (int i = 0; i < mac_cnt; i++) {
> +			u8 *mac = NULL;
> +			size_t bytes = 0;
> +
> +			sysinfo_get_data_by_index(sysinfo, SYSID_BOARD_MAC_ADDR,
> +						  i, (void **)&mac, &bytes);
> +			if (bytes == ARP_HLEN && is_valid_ethaddr(mac))
> +				eth_env_set_enetaddr_by_index("eth", i + 1, mac);
>  		}
>  	}
>  
> @@ -288,7 +299,7 @@ static void do_overlay_prepare(const char *overlay_path)
>  	return;
>  
>  fit_error:
> -	pr_err("M.2 device tree overlay %s not available,\n", overlay_path);
> +	pr_err("M.2 device tree overlay %s not available.\n", overlay_path);
>  #endif
>  }
>  
> @@ -362,8 +373,15 @@ int board_init(void)
>  
>  int dram_init(void)
>  {
> -	struct iot2050_info *info = IOT2050_INFO_DATA;
> -	gd->ram_size = ((phys_size_t)(info->ddr_size_mb)) << 20;
> +	struct udevice *sysinfo;
> +	u32 ddr_size_mb;
> +
> +	if (!setup_sysinfo(&sysinfo))
> +		return -ENODEV;
> +
> +	sysinfo_get_int(sysinfo, SYSID_BOARD_RAM_SIZE_MB, &ddr_size_mb);
> +
> +	gd->ram_size = ((phys_size_t)(ddr_size_mb)) << 20;
>  
>  	return 0;
>  }
> @@ -405,18 +423,18 @@ int dram_init_banksize(void)
>  #ifdef CONFIG_SPL_LOAD_FIT
>  int board_fit_config_name_match(const char *name)
>  {
> -	struct iot2050_info *info = IOT2050_INFO_DATA;
>  	char upper_name[32];
>  
> +	get_board_name();
> +
>  	/* skip the prefix "ti/k3-am65x8-" */
>  	name += 13;
>  
> -	if (info->magic != IOT2050_INFO_MAGIC ||
> -	    strlen(name) >= sizeof(upper_name))
> +	if (strlen(name) >= sizeof(upper_name))
>  		return -1;
>  
>  	str_to_upper(name, upper_name, sizeof(upper_name));
> -	if (!strcmp(upper_name, (char *)info->name))
> +	if (!strcmp(upper_name, iot2050_board_name))
>  		return 0;
>  
>  	return -1;
> diff --git a/configs/iot2050_defconfig b/configs/iot2050_defconfig
> index 934552bcfd24..2d5f18e5bd40 100644
> --- a/configs/iot2050_defconfig
> +++ b/configs/iot2050_defconfig
> @@ -140,7 +140,6 @@ CONFIG_SOC_TI=y
>  CONFIG_SPI=y
>  CONFIG_DM_SPI=y
>  CONFIG_CADENCE_QSPI=y
> -CONFIG_SYSINFO=y

Maybe you just skip enabling this in patch 4, then you don't need to
remove it right after this again.

Jan

>  CONFIG_SYSRESET=y
>  CONFIG_SPL_SYSRESET=y
>  CONFIG_SYSRESET_TI_SCI=y

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
