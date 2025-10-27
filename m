Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 168D5CCF9E5
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 02:27:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EC8F80422;
	Mon, 27 Oct 2025 03:27:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XzlYD4DD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BA1A82E34; Mon, 27 Oct 2025 03:27:15 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04D9780107
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 03:27:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBcNqscu34pMQIie/3Be0jeug4NX48CyvYQ6U+ORLiVe83+46my+hsOyLPPwWSwXDz2hIbXP7d/DYRuwOm/Tp9r23OFHzLF/H/Ji/55/t6WmJMZsGBpGJ4tOOvsYUmmwNcBhS9OG0c4rLUvGYCkV0gmpjWChf30VCKUPvZ+OvsYbOD43inS1szqHEFd3hWNAPWtPMa2tIZaVjS63as3m5TAeDVmJPRevBQI86nJK4V46itbixJc5GIlryys7yMc5uvV1ZRmbY1CsNKd5Zvkn4/hj0lVPoeWeHqTK73k5KyBybybnyet/62BvjHHKIKMSxIzcFw1VcKzwDZ86+agbKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oksWbC0knhsQUHR7RhqzqsVziKjRLn8FvoRIv+F7h1s=;
 b=E1tSfEqFohEu5IEUOnppVLjjT2Cn8WKIX9M08QbhrRdtyDKJe/xZO32KQY0w/0KqP/bqEz1o5qUOjYR62FyVoiBnmymnOKs8Pl2vikaY3j09sKXlThe+3swsawbHSfSPO+pIs1nkrOx61bs1WpJoMv05Ft4QYbnc3ufrPr1BYQztAiAmpJuw/A+p4plY0d1EqHSkILg7Lc3Iv5DcU/6gVNwm2gmSAJpfQ2Nr3QOeh0Q7psfYSNAksOqPu1oXH2mRh/3sl/8mQSda3s2oq9D8b9vgT4zMj3M034cUQrWK+gZNdhiCVaVBKvha2aNVgTblN6yz41ko5OBikejkZ0z1Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oksWbC0knhsQUHR7RhqzqsVziKjRLn8FvoRIv+F7h1s=;
 b=XzlYD4DD38xa8uFN2pzzwPMXKyqBa4b2T3nTy8R7Bos4LQW9ZQ4KhvSScXdLryntpbrGiQ8kfUveTt7T5d6fP++e125vay+tfu1reJQO0XgkJPilzh/3dgkWbt99NR9roU4OLT39xzLrGjCIQqVcIfY3AHFGfatqq6vcMDdbrwgBm5KkdpuWzgkI2hQ28GqQvW//GYq3T0GUnY1o1lGSgcJ2ZI3HN18K4zB0Psdp31PA1z6kYeIhS0rzWgjgNepgyYpufsdSUQvuuscFmP5b0BdCiIsO9y+8YaW9ketqwdWrdMTk/TObAZ7b/yBU0yf42wwf+bArelwfs4neiUiyJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by AM9PR04MB8438.eurprd04.prod.outlook.com (2603:10a6:20b:411::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 02:27:09 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.9253.013; Mon, 27 Oct 2025
 02:27:09 +0000
Message-ID: <5ebba7e2-ae01-4ff4-a17f-66ddead1acd5@oss.nxp.com>
Date: Mon, 27 Oct 2025 10:26:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: mx6ull: init_bandgap regression
To: Fabio Estevam <festevam@gmail.com>, Sven <u-boot@schwermer.no>
Cc: U-Boot-Denx <u-boot@lists.denx.de>, dario.binacchi@amarulasolutions.com,
 peng.fan@nxp.com, ping.bai@nxp.com, sbabic@nabladev.com, uboot-imx@nxp.com,
 Tom Rini <trini@konsulko.com>, martyn.welch@collabora.com,
 parthitce@gmail.com
References: <bfe7ac62-0d01-45b5-9226-e1d425565d50@schwermer.no>
 <CAOMZO5C_8xacCJn9+KWC44nSuMWNCUu0c=YHsQvTH-+1yKawSQ@mail.gmail.com>
Content-Language: en-US
From: Ye Li <ye.li@oss.nxp.com>
In-Reply-To: <CAOMZO5C_8xacCJn9+KWC44nSuMWNCUu0c=YHsQvTH-+1yKawSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0044.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::18) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|AM9PR04MB8438:EE_
X-MS-Office365-Filtering-Correlation-Id: f8dde1ab-b7da-4816-8966-08de15005407
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|19092799006|42112799006; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dHRRVW9sYUgzUWlJUVVrOVBJMUpEQTE4UUtQUnRicm4zcVA3WmVsTDNVTzRs?=
 =?utf-8?B?UUIwcGFqb1hPdXNGZ0NralgyS0VkK2VnL3Y3R0s3SWQvemM2WFlwT3c4VURs?=
 =?utf-8?B?cXBIb3FFVUNtUXdMS1B3OGlsaFhQZmlrKy9tbEM4MmYyQWt1K0FsdEZ1RlM4?=
 =?utf-8?B?bm8rUmNYVFpNYmw5bTBqWG1KK245SHlDRlVKVnlKbHdHV3JYSWF5SENpeUdx?=
 =?utf-8?B?WnEyUVlwRmVlaFBROWpWcmhwZjF6RHF3VmVsQW1peXhJekxubGpNNjdRMDVT?=
 =?utf-8?B?NlM3TFZzcUQ3dXpCMVN0aEZjSmc1WTI3S2YxaE9iVTFtbys2N3FwWDdVRk1R?=
 =?utf-8?B?MjBublFJWjdlSkFJalRXZ1pHL1N1Nld4WTkzazRNbUEzTXY1blRSekkxOEN6?=
 =?utf-8?B?SWJOc0FJZmJXR1gya0ZmNGRDOWF6b28xOVNHSG5IaFhFa3dObEs4TVFlUjYx?=
 =?utf-8?B?cjZzMFhUVWdpTzJXRHdCWUUwclVkajF0RVVadSs5bldWaTdaOFd5aHE2SEgx?=
 =?utf-8?B?TFNjdHNrbmhBMWI5emJFR21sdnF1aVcxNGRRa0huekJTV2JkRVhrK25YSG9s?=
 =?utf-8?B?bnV2ZE8zcXZDTlpjTnFFZWQ3eWhvOW5qZmxRWVFEWWxOT3NuaGd2ZzFVSzhE?=
 =?utf-8?B?TDRXYXBDUmpJWWR6WWVQNDMyeXJNZzlNMVF3YlRqd2FqcDA3N0I5TUpJckJu?=
 =?utf-8?B?Z1FHUEF1cEwzR2VhK3RXK1FWdjQrSFRUbEhCTTZMc1d1Umc0UE5TbExGbXlR?=
 =?utf-8?B?dUswNjU5ZjRNSU5heDN5WTloOFh1ZWpBaUxRaHhTNXIxa2lFQmVoKy82UEdD?=
 =?utf-8?B?YTh0SWlicDhvY1BES0tmVlJ0Qk8yangwTWJqckdEVS9wZXdkTXNVK0NtQmZT?=
 =?utf-8?B?MTUvaFo3VXY5Z0VDQ09GT3lDVW8zUmsyRmFQcXJ0N1Y0VzR1RTlHc0Y2dzBt?=
 =?utf-8?B?Vk5SWEw2QW4yL2hhV3NoR0Q2Q2todG1zcGNhdnVjaHZIT1ZMQUlNVHlaTnpM?=
 =?utf-8?B?TmR4K1ZyWHBhQitiVGMrbEcwVHdrVlNoTWlRREcxVjgvT0JjbjlVVDhpcXBP?=
 =?utf-8?B?eXJSUlo2RzN3VHRNMFFPTnVsakVWS3ZVdHVKNE1tN0tma3AxR3JsQUtTeWJV?=
 =?utf-8?B?YTVZOERLK3RzTmZDK2phMkVyTHR6RWNIaURXRi9KamhudTBsemhJdmxrYk5o?=
 =?utf-8?B?UFd2UTFXVWlsRy84VzlTdzQxZjl5NTNDS3N3blJocjZNV3B0dGRDc1pSZnN1?=
 =?utf-8?B?NVk5cklCNVlNVi9DSVhma3JBbXo4dUVXeXBQUytSWEhDWEQwVG1lZVBDd2JC?=
 =?utf-8?B?RnVYbG9mRWRXTnRaUzRHVitTcWowN2hZM3ZwZGJaQmpmZlE3R0VhMnltZzdW?=
 =?utf-8?B?NmpMcmhJRlBycXRRL3kvOWw2K0p0b2xESytaNDYzMDJJaDJaaE1JUEVzYW9q?=
 =?utf-8?B?a3d4c1FFQitZdGQ1ZUJ0WEVXZVdpRWtnVjEzdHpaMVhRRTlIVmpwMTlSQ2NJ?=
 =?utf-8?B?aHdKYURabzE0bmJpc2k5ZC9teXhHeDJ1RmNaTGN5ZVgycVVjMjVMUkMvNCsv?=
 =?utf-8?B?dFpuUzN2VGJJMWlmZVoxWFRtd0IvRjBUSDdrRzhEWTRlQXcvNHpHZTNjenh0?=
 =?utf-8?B?N3dPOE8vejdUZHBZY3ErcnlHTThQVWZsOEt2SDVBS1ZBU2xEOEpVWU9NWWM5?=
 =?utf-8?B?UXZpSEluWGk0ODduSFNHOEo4QkZiTDhpNysxYXBLREhNKzhDcXhmeWJlSmpV?=
 =?utf-8?B?TGNUd1Voa2t1OC8vRjJNenpUelpJR0laclpZWmhrRUwrS285RTlDMWNraWgx?=
 =?utf-8?B?V0ZtSldMa3lNNWo3K3l0NVZrZ3J6Mm9mbGY3UGJHSWxVbXBNVnllT0xmemY3?=
 =?utf-8?B?VEo3L3JaRXVPMXk1RSsxbTJLYkZiZm92bDNWd2ZLWWVuaS8vd2VDODEvemNG?=
 =?utf-8?B?eHVBL2dnMy9JKzdkUit2NWlNOVFEaXBvQmVjVnd6eWcxdm45SkpNS0l6bTdq?=
 =?utf-8?B?RnBYUHI3REp3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(42112799006); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3phdmZ3aGFoaHF0aWRDOG9QZnA2OStINXJHeW5Gdm5vZ3VpTVd1UFoxVlpa?=
 =?utf-8?B?OUJ1dmhLakkrN3JUVTBBZEorS1UvMlRBdWg1cC9Bam5scm5XaEt5SnFuL3RU?=
 =?utf-8?B?ZXRlVU9sZDNwM2x1SlEzZ29ZMXd3ckpBQW0rcXJXcVRtUE92Zy95bHcrVlhq?=
 =?utf-8?B?ZlE0TmdrOVo1Z0JabDRMRkozSnBrYUJRVUEwdUVWMlcrckxjVnNxVTg3WmJJ?=
 =?utf-8?B?RlYvRkk1REVibGk5WlVtREJLdlJWWmVLVjhXN3BHZFN0cnF3dTAwMTR1b2Ri?=
 =?utf-8?B?K21uVDB0ZUtqK0xjRWtpTFJ0Y3ZydXJWWHlGMDBxOWVyZVRFZDNrajdqTUk1?=
 =?utf-8?B?ZHo0dzJyYlI0ZktMdTNuam1pbk5aNXkwZFB0KzF0WlRqb1RjNEVFd1Q2eC8z?=
 =?utf-8?B?NTZmYk1iVGZLcWt4ektoL3lkTVhlQXB3a2tBcVNJQThPT0t5ai9jalljWnNY?=
 =?utf-8?B?Q0xaMUpGb1dHUnZQZjhSZDNrekE0YURKZFRScFgvcFVHZ1U0QWl5K01Cb1BR?=
 =?utf-8?B?cEMyazliMDg1WllIT3dpdWJYbG9rODc1b1EzVW82TUVQTGgxM2FsN2NIcTdG?=
 =?utf-8?B?R0NkL1N5ZGUzd0tnck13R1ZabkF4SWdsT1UwOG9hNTRrMzBndndza0hvUmEz?=
 =?utf-8?B?N092UGdkMXFVV0owNFRjQi9vM0QzTjZqRDNPZVltY2N3RWV6cVc5bENRNjFO?=
 =?utf-8?B?bm5wdGViclpOSm5tYkVlV0U4ckVuR3ZsM1lmRWE5Qk0wMmkwaUp6b1lkZnZs?=
 =?utf-8?B?RUxZUHRyNm9JSjR6bDlHdlZmRllGZXZIYktoYU40L0d3T1QyVkM1YVkwajRQ?=
 =?utf-8?B?MFJuRTNXMEswUzFvTDFidlFsZmNETUErdGR1WjZjSTZMVkJYUFIyMXB3d05S?=
 =?utf-8?B?T29MeTBKampRblJTMFVPb3dmM1VWNTE0M1R2LzIrZzNSWDNONmtnZ3VCcVor?=
 =?utf-8?B?cWVXSmx2ZWh2ZHdCbGE0R0ZiQXhaVEZkdnZQQkpRLzhpL1hGR3BlZ0NxbEk1?=
 =?utf-8?B?UGFOQ0UyWGlnOWtWL2dYQ3JhRHkvSG9GRTZzR3U4RkMvQXF5eEtmc1MzZ2V4?=
 =?utf-8?B?WkRGeUVCZjN5UFd4bW12bUF5dUdPSTREdUt2TzRpZHJ6UmM3YUJwMzlLaGVt?=
 =?utf-8?B?cmNxdEZNbWtWVlhWT3NaYUxVcyt2Sk5iL2Zqc0JZM3RqRWFZYVB2SGFqUG4x?=
 =?utf-8?B?eUNEUlNzRU5nSkdDaEhPRTZnNEprQnBiRllKTHduSVFnYzFBVHl5cGNncEov?=
 =?utf-8?B?VjdteWw2ZytHc3dHZnhrMU5lU1A2WTVyV1d0MGpZTzBHUkt6dDVSaFNEY28x?=
 =?utf-8?B?WjF4VmJ5eWRSVUQrTjVISEh1VVBVQytaa0tJY0R1UzVRa3l0bTFsWVQvZ25L?=
 =?utf-8?B?TTJTMWVpVkpVMk53MG11S0JYQ1VuWXpXd3FFcFlGWkpQTytzMHI2R0ZkSi9Z?=
 =?utf-8?B?dUVuOHFSRVZEZy9tUFp4eFpWbmlyQ2tBUk56bzdESmREMjZyNzVhb2k1Rytn?=
 =?utf-8?B?c1JrUUVSL2JNbFF6bWlGR3RJS2YyNjJjYU5sTWI3VXpic29GY3BXMEpacEVF?=
 =?utf-8?B?Vy84NUFQUEFFaWNLcjdNSElUWjUxdGs5U2hjM0NNTGhPZzVINHZONlRzZ1hi?=
 =?utf-8?B?QmhjMHR4TTF0aCttQ0RTbzE4TzQwd0ZEbk0vd25WaDc0a0NLVVZ6R3Z4RVZ2?=
 =?utf-8?B?MTFSaUMvZlRqaXlIaGJVemMvTkpZTE5XdjZRUDFEU2liOHNPU0l4Wm01bEdQ?=
 =?utf-8?B?OXB4clJYNDhiRVpHdkpPKzQ5UzJBdVVtNktxc1ZGcSt0SW04aUtlNVJKaTRL?=
 =?utf-8?B?WGpZMFVTTHppdlNEYnRUOXJrUkxUeFhyNjdSdnNQa3M4SUF6T0lMc2FJRUVm?=
 =?utf-8?B?N2duZVI5elE4Wm9xdTYzTlhGK00vTHAwRzQ2WitiQ0VGNG5WekYwMWEvaUdU?=
 =?utf-8?B?WkViaWc0U1R4dXd1YXNDVUFjK3RUUmpLamF3S3k1czRJRmo2bndzd1ZDazBC?=
 =?utf-8?B?dzBrQjgyVGlrc21rK0pwVW9KK2ViWlBrTXk0UEtmRjJ1OUp6ZGlaczJRdTV5?=
 =?utf-8?B?TlhHVGpiVFNsbjlzR0QxSndtMHB3dTZUYitOOHAwbDhOSmE1OXY2NGxPM3lj?=
 =?utf-8?Q?SeCgDHRkwa5DazA//KX9UZvrA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8dde1ab-b7da-4816-8966-08de15005407
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 02:27:09.1899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fipwTWxOanZnNgayHjm77sky0Q5uRx6QiVporg6z8MxIzePCzJblpsIRCFmZ6gnt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8438
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


Hi,

On 10/26/2025 7:55 PM, Fabio Estevam wrote:
> Hi Sven,
> 
> On Fri, Oct 24, 2025 at 6:23 AM Sven <u-boot@schwermer.no> wrote:
>>
>> Hi,
>>
>> We make an i.MX6ULL-based board that is built around the Phytec PCL063
>> SoM. We have noticed a regression between v2022.01 (good) and v2022.04
>> (bad). We have also found the following tags to be bad: v2022.07,
>> v2023.01, v2024.01. We have bisected this and found the culprit to be
>> c1af358c ("imx: mx6ull: fix REFTOP_VBGADJ setting"). This code still
>> appears to be unchanged on upstream master.
>>
>> These are the symptoms: Very few of the thousands of devices that we
>> manufacture (< 1%) fail to decompress a large XZ archive once in Linux
>> userspace. We have not found any form of memory testing or other load
>> that reproduces this issue. Reverting the offending patch fixes this
>> behavior on the affected devices.
> 
> Please send a patch with the revert.
> 
>> Perhaps the NXP folks could chime in on the intended behavior. And the
>> mismatch between commit message and comments mentioned in the offending
>> patch.
> 
> Peng, can you look at it, please?
> 
> Thanks


I once sent a fix to revert that patch, but it was rejected.
https://patchwork.ozlabs.org/project/uboot/patch/1646721735-125430-1-git-send-email-ye.li@nxp.com/

Best regards,
Ye Li

