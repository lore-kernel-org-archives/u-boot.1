Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E673E7717F
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 13:43:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CEED8917D;
	Tue, 10 Dec 2024 14:43:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4KZuBqNh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F88389380; Tue, 10 Dec 2024 14:43:23 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::60e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD57B8915D
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 14:43:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9bq96jSlIloyZ5hitb3bQZImV2H/9dXKb0sHIg5XlzsWrpUbkRGy+b8JHabxqOQkyNlDrfjlCNprfE80ISTraAXy1LOjah9dcwRK9lrvgjgAys+DJxBXWCjlMz/rwMhiLSsnXFDdX8e+YzkN/oKlcSz6BPsKkzErQ0GrcLM963xbO0pFPEVXQueBTrwfDQedynHkAn7MHtztyltyhd9tcQR+b/rH01QrkDiaBxmFtHCSg+GeJvdpwvdIfn6CftCC7CNYiHhtJsg/U8nV86w9t86bbIn/SzcgFpsv0htvK0Rb/7Sjp9oUv9phRKLNUDMvK/gNAnTwfpksRJZnt+d5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWRZ3vMVfNNVAqK0xKnA4fKRFLIsIWe/AVnOh3U9Wt0=;
 b=ssnUNQ6VoY7ipKKppT9buxYFlG4FlSdXmBsC/JSCgan4l6W1GdIPCkHuStK+f3+wJMH9AbOtAWCGazoH0+20HtvsETU/t6yOxzdazILvQYlrZcv3eQlyJF8IZkxlZaTR3TWNRXQ4mJsOAPwLXdlB3hpZgO1jsfd9JHeo2HKaR43FZhlAu0coDP3Emn5Znb47hoZpPbki8BZUYwYFJdWkW3hjV3Zr21GtDOLe0U592+korI6aTE3xrJLfVczqrstTwSRWlexJ/iO6Ew3lJ0T+tD8MG09kzKZtEgU7Q/wccLO6lakh2UcPmVsYHOxMRzAy2za7HIypF1ZjG3HcbmhsOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWRZ3vMVfNNVAqK0xKnA4fKRFLIsIWe/AVnOh3U9Wt0=;
 b=4KZuBqNh1qN4tG4uxqkWtt5bhSJII0CCSbqZsnYTAsBMub6CcKYnyTXDacoxbsRDfpt2W11mUF49mBsbk9ja/AHjs7epqchx3ag0Oe72OPViUIN9o/gX3PyWlwf6cu6u/2I8dfQrhLmxL78u5sF018XM/7nsATRJhp5yzsZ7R1I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS0PR12MB6581.namprd12.prod.outlook.com (2603:10b6:8:d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 13:43:16 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 13:43:16 +0000
Message-ID: <16bf2762-768d-46dc-85aa-3e4b32fd1e78@amd.com>
Date: Tue, 10 Dec 2024 14:43:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] common: binman: Calling initr_binman() when
 BINMAN_FDT
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, git@xilinx.com, neal.frager@amd.com,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
References: <cover.1730452668.git.michal.simek@amd.com>
 <f79dc1fbf796dd5ad290f6080608ee68d7652cfc.1730452668.git.michal.simek@amd.com>
 <CAFLszTiWOdsS8=pm7aSvyC2QYiXbbsciz2yb6s9YPV1FeFFrgg@mail.gmail.com>
 <2ee46698-87c9-47e3-8951-41ac3c50331a@amd.com>
 <20241209153216.GJ2457179@bill-the-cat>
 <CAFLszTjb23qYBS2YDWjTJDFtJ2OnZZ5OQG56i9DBu_NeUT=FzQ@mail.gmail.com>
 <b5145a88-aea0-43c1-8fa0-fe533bd9d169@amd.com>
 <20241209192340.GV2457179@bill-the-cat>
 <CAFLszTi-NsvU=UP2Ze7NH4iGRKtG1Ja9Z5pFig+52LNJRxqd-w@mail.gmail.com>
 <20241209200818.GW2457179@bill-the-cat>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20241209200818.GW2457179@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0041.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::8) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS0PR12MB6581:EE_
X-MS-Office365-Filtering-Correlation-Id: 8490975f-4865-471f-e308-08dd1920994c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NVN3OGNpSDJkbWZWZTJ1b1VsYmtvQ3hQT3UwMmpHdi9TSWNTNmR0cmJqelFm?=
 =?utf-8?B?QWIzazN2dnZkU0pRQzdHRE9nalEvLzV0Vzh2RjJacVk5L0tHVUlGUFJqZ3Yw?=
 =?utf-8?B?UjZ5b3VaTGlZcFhZN09mSXY4Zi9YL2JQNVMvRlV4eFpkQmt1VHVNa3hXNmx2?=
 =?utf-8?B?bHNBamNrSEw0ZzFINDBVNU1PVitBSHNHMkpKblQvZXFkSHZrdlFaakNlYm5M?=
 =?utf-8?B?eENEdmQ0OFBZM2FaZ09zNUlrU3VHUTdXMEVPcjRpQVpyWiszQ3NDd3AyUW1O?=
 =?utf-8?B?cENKRm9kMUVTQldlZ01nVnl2ZDVVMDhUelo3TmdkckVQNEwxS3NmNXprbEdU?=
 =?utf-8?B?NU1kOTdEZzY5bGpyTTVRVzVFQmVQQ0ZQOHBudFZxUllNQkdKWTcxQlZETkdp?=
 =?utf-8?B?Y1IxcXAyWFpIWmZqc0pOaDBVRjJTSWZqWXg5anZVdmIwdDBUbWJIekFkQTZB?=
 =?utf-8?B?N3E3NitSYjd3OEoyc2g5QlBCalVidUs0UFk0azJwTXlXSkxoM1NDWk1JeFMy?=
 =?utf-8?B?YWY4emFTMG84aGpuaWcrZXNtbmp0S3dOSDVVSm5QVEkxN0djSzlZMDJMUUhm?=
 =?utf-8?B?L0lpMFZoWnJUVEtCaHFjQkxjbGhIVDdiYkZ0dWlkb1BDVk93NzFFL0pLcWs3?=
 =?utf-8?B?dG4rbWY3SUxNVkUyWWJYV2hPWGtma3RFSTJ5bEtScGlmWHF1OUc2QU5tR2l0?=
 =?utf-8?B?YlVoZUhsV3pjVm40eVhwc3RIOFFkdUsyajlRUWlvNVN6dWtWbzZWWk9KSkNR?=
 =?utf-8?B?enJQUnYwT3lsQWY0cXo4eHZvbFFXK2YyTTBVemMrVjQzZlRIcGdmaFZha08z?=
 =?utf-8?B?a09GYmZESWdCZ011czE0N2pqMGdHUDBLTnJmODU0MjAyeU5zTTBYRm9LTkpZ?=
 =?utf-8?B?b2R5K25udm80ZmlxZmV3VW80RmVNVWRnZVJnNC9ZcXJ5MXNCdXlJakVBcWxY?=
 =?utf-8?B?RTB4M1AyYnp4emRCbkRXd1NqRjdrZE5Jdlplb1J6eER2Szk0QlNIWWpxTTkx?=
 =?utf-8?B?eXc5SXJtUDFwY1pwM0JIclN1eTdiZS91MThYRHBhT1dhdHllQjJ1dDhIZC8y?=
 =?utf-8?B?Q1cydEpOUC9BZCs5R2hJL2sra2tnblltRVZFandlcjlSR3FkYmJTTDIzRHBh?=
 =?utf-8?B?a2dUbVI5ZXhiQ3NmNUREMjFpNDVIcWN3ZkZzYnhrUVVPcUJKUU1CN3Y3UFlC?=
 =?utf-8?B?WU9FUkJ1ZysxNmF5QXIvUGlYU3lCblpnRXhXRi9GVTU4RzZxT1IrVU4vRERI?=
 =?utf-8?B?d1BuY0hjYjlmRlFBemF4djJxSnVMb0hFSmdjWVZ1d3BNN1pvVVNnVS9EQUZJ?=
 =?utf-8?B?aGdOTkVlTThEVWxTS1RjRDdUQ3NoaEd2ZDV0S25CeCt5eERKYi81dC8vNElQ?=
 =?utf-8?B?cUJNSGVNOTBMQ1RmTjFSaHVMUUFGanBxMDMxNGtkSzBOZGgxZTlyNWdsbzVu?=
 =?utf-8?B?QUtFaTdxa2s4ekd4TG5HZEUzbzNQc1JmcWVLYnBUQjhBWEpheVA3MzM4VG1G?=
 =?utf-8?B?MFZINU5mNHFvb0E1b0hmbmFlN3JkdGJBLzVwUkdxaUR3OHVFM2ttamJYcmRI?=
 =?utf-8?B?cDAxV2NxWnVmYVd6RnBQRTlDZ3ViQTFyRFV2QnU1RlV4RHQxNWpWeGd6UXlF?=
 =?utf-8?B?Wm9vSjQvZnBoT1RjUnF2NHhUOGFURkdhckxHMjR6YXBPam53L1FYVmh1dmE4?=
 =?utf-8?B?MFVnOGl6bnJwQnRBdW8xNitnSDBKNi90aWcxKzZKYllreDNRbkVsMEJ5Nzda?=
 =?utf-8?B?N1lhT25lWVV5QzZkN1lUUEx5N3JnZEFLcVVoKzJtODdFT2JFdk5EN2plbzJv?=
 =?utf-8?B?VXloZzJQVnlscis5blNFQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vi9ybE5FZDBXWkJ0YUZJaFNkQ2VuVjE0dTBQZS9KWklreUxmRkVMdVZoVVpa?=
 =?utf-8?B?RmczWDNNOTQydGVIamdNSC9VUnRvM0R2UnJUaURCVUVTcDBxeWY3RytnOTJ0?=
 =?utf-8?B?c2VJUG9iWFg5VmlkVUFUUmZDczhmeEhLM1lGQm5xYkI0QkVubmtOK3N2UzVE?=
 =?utf-8?B?dUpIVmwvOGZMWmsvbTBxM1AyYUt3ZnYrN1ZPOE56WDJDaTJQTGh1c1RxNE0y?=
 =?utf-8?B?UmRhd1RhbWhZaWhqcHQzY29sZzBveVdNUUQ0S3VlTFhobGFsbnlkalNlZ3du?=
 =?utf-8?B?K1Vqa0JocTlrelJhZzVhUHlKNTY0bjROa1hWTE5LK3hOWkE2UTdOUkFLQ2do?=
 =?utf-8?B?RnpzVGNCNUtrMVRNVmE4V282NURIUFVTOUhZTVQwYzBDMU9ISm1ZdzRMcVBJ?=
 =?utf-8?B?RitSSVNVSUF4UHBjUXlZNDFIMTFHTUVKaWVqcGtVdTFwY3ZRcGpvZG9SUnZX?=
 =?utf-8?B?cEhtNCs0OGpldjk2bVpYM2FIMUVId0NCZlJlaTFpUmFsN2xibHRQL3Yveit4?=
 =?utf-8?B?RVB4Y05CYlg1d3ByMktzMmJGbFlhWVdGOHAzdUtodVpiU1d0ZW1NR0l6Smp5?=
 =?utf-8?B?OVp3aVJnaGRqNDE5UWRJV1FsOUFWMTZIZS9kS2h1K2xsUFh1cDlJV3RLaUU5?=
 =?utf-8?B?THUvOGJjL0d3eU9sQTV3OGkwdS9obmJqcG9rbUNvbE5ZZTB3OVdyNWtmTXF0?=
 =?utf-8?B?Mks0aVB5Vjl6ZE80MUZmcmZBSVBnWXdlK3JHZWVMY2FOSnFXdFBVTWZGRWtO?=
 =?utf-8?B?MkhzOU51d0VqSzFhZmxmQ1I3d0pUVWlTdjVHMjNqRmc0Vi81WFliWDdEY3o4?=
 =?utf-8?B?VTlnMm5xWVd4REtwbFRqTWtZYitUVGZoQTRwL0MwY09pUzliNXlFWnhTd0ZR?=
 =?utf-8?B?bGV3Q0J6aVJMS044Y0lVVE8wRlZYMHVUQWZOZWcwanNvb3REREt2Mm81MDkw?=
 =?utf-8?B?R3FPWXFHSHIyUzBHVko0THRSdEhQWnNlWWVsUHkrRkJuREgxRWYyb0JDY3BR?=
 =?utf-8?B?MDJ2VnhBSTBiU2RMK3lWZkhJQlIvUkxBR0h1ZGpCMFVsSFlGTUVsR0NSUWd6?=
 =?utf-8?B?VHlzR2tUQ21LMzMzNWlQeEdkcGRYY1NtTzJibmxwejR5VEFmMWMyL3JvS3Ev?=
 =?utf-8?B?bmppZFRJWVM5dDBpRktkU1I4dWw0dWtIbHJrWlVhZnJkRlpoclFMVzRGZTI3?=
 =?utf-8?B?NTNNQ3dnSEp5VVRweXJKVCs1R2NlM20wcmwraDVwWTAzcmZRcFNJclhBRlcw?=
 =?utf-8?B?TWNld005VVR0YzZXWlVaQWtKd2hwVS8xZXZWZ3NQdVV2TUNLeWkwdzhyaFpo?=
 =?utf-8?B?bzVlZlUrS0xIR2JNWWYyS3kyOVNrM3ljODlZMG56ZktzZkZoYlRlSFA4VEdZ?=
 =?utf-8?B?LzVVdGIrZHpJTGNDN0M0K2Q4VXIvQ01FaHY2VXkxRmVuRXpUOHZEMlBSbDdB?=
 =?utf-8?B?bEJxWHNVdHRkN2NJNWRvUUZxd3Z4TlNDUVdoNTZhOEJwNmFkdWltbGRPQ1I5?=
 =?utf-8?B?R3JUS1JDa0NhdTVMTm94VTNIbSsvQ1A1TTRXb2oyWTRqWm5MbHJXempsOHM0?=
 =?utf-8?B?cW9relFWRkphTHdrZ1VQUGJKQ2lIZXpOUGI1MkFwSEZMMG80V2w5a1UzZW9p?=
 =?utf-8?B?VVpQWDBBTlVXUTVrcmpoaXdsNUtRR2Q5OUJaUVFGZzFtQ1UyU3paOWpYSExu?=
 =?utf-8?B?V2pBZkZGdU5iU0hROHpvOTU1bjJJdk5PVXFmaG82SUo3OW5UMkR3d0RyRm1o?=
 =?utf-8?B?dUVmZ1BsT2VDUnhGNk5Na3o5NWhyWW5Ka2JjbVdMYnFhUzVBeWNvdkRJcVN2?=
 =?utf-8?B?cEFjeXRaRXBWbnZNZnliS2RKdDN6QzR1b2Y1cGEzZ3RkN2xHaTVYQ08rSnFh?=
 =?utf-8?B?bmJhRnV0b0ppQjlpRWV6L2dCcGZvU1Jrejd5SGdYUFFxNG8vQlYxTWV2N2JK?=
 =?utf-8?B?NUVOdW1YTlc0N25DMmpLZG92eUgvTlAvZVNaTjlnUkp2NnA0bE1BaVpGRVBO?=
 =?utf-8?B?aEZmZURtZVN1dnB4VUpiT0pnVXE5WDBZMjhDWEtKTVc3cnBQSjdFRmQ2ME00?=
 =?utf-8?B?cGxCcDRXSVNESWdKRGppYUN6TFY2Zkh2YnRQdG5qTWswSzNQNHVhekU5Tllt?=
 =?utf-8?Q?SOdYGbzv0iA8Ib+Xoa4ioRbYQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8490975f-4865-471f-e308-08dd1920994c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 13:43:16.2498 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1VZrLaeo1MMgStZBJSParjpamZUQgnLTRgNeLotBp97I2t8keOYyVN1OhlsTeHVC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6581
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

On 12/9/24 21:08, Tom Rini wrote:
> On Mon, Dec 09, 2024 at 12:27:31PM -0700, Simon Glass wrote:
>> Hi Tom,
>>
>> On Mon, 9 Dec 2024 at 12:23, Tom Rini <trini@konsulko.com> wrote:
>>>
>>> On Mon, Dec 09, 2024 at 07:34:34PM +0100, Michal Simek wrote:
>>>>
>>>>
>>>> On 12/9/24 16:47, Simon Glass wrote:
>>>>> Hi,
>>>>>
>>>>> On Mon, 9 Dec 2024 at 08:32, Tom Rini <trini@konsulko.com> wrote:
>>>>>>
>>>>>> On Mon, Dec 09, 2024 at 04:26:15PM +0100, Michal Simek wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 12/6/24 20:20, Simon Glass wrote:
>>>>>>>> On Fri, 1 Nov 2024 at 03:18, Michal Simek <michal.simek@amd.com> wrote:
>>>>>>>>>
>>>>>>>>> Calling empty function when BINMAN_FDT is adding +64B for nothing which is
>>>>>>>>> not helping on size sensitive configurations as Xilinx mini configurations.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>>>>>>> ---
>>>>>>>>>
>>>>>>>>> Changes in v2:
>>>>>>>>> - new patch
>>>>>>>>>
>>>>>>>>>    From my perspective there is no reason to call empty function. It is just
>>>>>>>>> increase footprint for nothing and we are not far from that limit now.
>>>>>>>>>
>>>>>>>>> ---
>>>>>>>>>     common/board_r.c | 7 +++----
>>>>>>>>>     1 file changed, 3 insertions(+), 4 deletions(-)
>>>>>>>>
>>>>>>>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>>>>>>>
>>>>>>>> This is a bit odd, though. Do you have LTO enabled?
>>>>>>>>
>>>>>>>
>>>>>>> yes LTO is enabled. And there are other candidates like this.
>>>>>>> Is LTO able to fix function arrays which is calling empty function?
>>>>>>>
>>>>>>> (without this patch)
>>>>>>>
>>>>>>> 00000000fffc0eb4 <initr_of_live>:
>>>>>>>       fffc0eb4:   52800000        mov     w0, #0x0                        // #0
>>>>>>>       fffc0eb8:   d65f03c0        ret
>>>>>>>
>>>>>>> 00000000fffc0ebc <initr_dm_devices>:
>>>>>>>       fffc0ebc:   52800000        mov     w0, #0x0                        // #0
>>>>>>>       fffc0ec0:   d65f03c0        ret
>>>>>>>
>>>>>>> 00000000fffc0ec4 <initr_bootstage>:
>>>>>>>       fffc0ec4:   52800000        mov     w0, #0x0                        // #0
>>>>>>>       fffc0ec8:   d65f03c0        ret
>>>>>>>
>>>>>>> 00000000fffc0ecc <power_init_board>:
>>>>>>>       fffc0ecc:   52800000        mov     w0, #0x0                        // #0
>>>>>>>       fffc0ed0:   d65f03c0        ret
>>>>>>>
>>>>>>> 00000000fffc0ed4 <initr_announce>:
>>>>>>>       fffc0ed4:   52800000        mov     w0, #0x0                        // #0
>>>>>>>       fffc0ed8:   d65f03c0        ret
>>>>>>>
>>>>>>> 00000000fffc0edc <initr_binman>:
>>>>>>>       fffc0edc:   52800000        mov     w0, #0x0                        // #0
>>>>>>>       fffc0ee0:   d65f03c0        ret
>>>>>>>
>>>>>>> 00000000fffc0ee4 <initr_status_led>:
>>>>>>>       fffc0ee4:   52800000        mov     w0, #0x0                        // #0
>>>>>>>       fffc0ee8:   d65f03c0        ret
>>>>>>>
>>>>>>> 00000000fffc0eec <initr_boot_led_blink>:
>>>>>>>       fffc0eec:   52800000        mov     w0, #0x0                        // #0
>>>>>>>       fffc0ef0:   d65f03c0        ret
>>>>>>>
>>>>>>> 00000000fffc0ef4 <initr_boot_led_on>:
>>>>>>>       fffc0ef4:   52800000        mov     w0, #0x0                        // #0
>>>>>>>       fffc0ef8:   d65f03c0        ret
>>>>>>>
>>>>>>> 00000000fffc0efc <initr_lmb>:
>>>>>>>       fffc0efc:   52800000        mov     w0, #0x0                        // #0
>>>>>>>       fffc0f00:   d65f03c0        ret
>>>>>>
>>>>>> No, but maybe Simon would prefer if we marked all of the could-be-empty
>>>>>> functions as __maybe_unused and did:
>>>>>>           CONFIG_IS_ENABLED(BINMAN_FDT, initr_binman),
>>>>>> etc in the list instead?
>>>>>
>>>>> Yes that looks better.
>>>>
>>>> But we are talking about using macro inside array at best with using #ifdefs.
>>>> Or maybe I am not seeing what you are saying.
>>>
>>> No, nevermind, sorry. I was hoping that:
>>> diff --git a/common/board_r.c b/common/board_r.c
>>> index ff9bce88dc93..c18997446dfa 100644
>>> --- a/common/board_r.c
>>> +++ b/common/board_r.c
>>> @@ -610,9 +610,7 @@ static init_fnc_t init_sequence_r[] = {
>>>          noncached_init,
>>>   #endif
>>>          initr_of_live,
>>> -#ifdef CONFIG_DM
>>> -       initr_dm,
>>> -#endif
>>> +       CONFIG_IS_ENABLED(CONFIG_DM, initr_dm),
>>>   #ifdef CONFIG_ADDR_MAP
>>>          init_addr_map,
>>>   #endif
>>> @@ -632,9 +630,7 @@ static init_fnc_t init_sequence_r[] = {
>>>   #ifdef CONFIG_EFI_LOADER
>>>          efi_memory_init,
>>>   #endif
>>> -#ifdef CONFIG_BINMAN_FDT
>>> -       initr_binman,
>>> -#endif
>>> +       CONFIG_IS_ENABLED(CONFIG_BINMAN_FDT, initr_binman),
>>>   #ifdef CONFIG_FSP_VERSION2
>>>          arch_fsp_init_r,
>>>   #endif
>>>
>>> would work, but the macro doesn't evaluate how I'd hope it did and that
>>> just blows up.
>>
>> You should drop the CONFIG_ inside the brackets. Also, you need
>> something like this, since the comma must not be present unless the
>> option is enabled:
>>
>> CONFIG_IS_ENABLED(BINMAN_FDT, (initr_binman,))
>>
>> If we want to do this more generally, we could:
>> - convert more things to use an event (then the cost is just 4-8 bytes per item)
>> - add a helper to initcall.h to make it easier, e.g.
>> INITCALL(BINMAN_FDT, initr_binman)
> 
> We should probably just do a follow-up cleanup to, as you note
> 	CONFIG_IS_ENABLED(FOO, (initr_foo,))
> 
> I don't think a more complex macro in there is worth while, but saving a
> few bytes overall here for free would be good. We can figure out later
> the cost/benefit on moving stuff here to events.

I have sent RFC with this here.

https://lore.kernel.org/r/9786c6124c959ca230dd2c23e8da794680f09867.1733837980.git.michal.simek@amd.com

There are likely some other steps should be happen on the top of this because 
there are some entries which depends on more symbols. Also some macros are not 
converted yet to CONFIG_ (CFG_) and there are functions which don't setup any 
dependency but should be there.
But likely this should be done with steps.

Thanks,
Michal

