Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7FCBD2505E
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 09:32:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62EFE83D13;
	Mon, 12 Jan 2026 10:32:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jda0yaEh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA66F83CBD; Mon, 12 Jan 2026 10:32:45 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C211783D13
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 10:32:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=popoMZS9HxzzagouZ+y4kWP6wzAEq9qzmWnPsn3PALLr7aTCRlCGNisRsjg4F0vYXs4S5af3DEEI8jW5j9ATR0PmcmI4IbHVIkGYz/d4gBMiZECg7fin8cxpoYmiukiQecnf6QGlfcThNXLBCCKvGery6LcIuM/MckHb5sCGiGdMFX8rEUEVaXp9xOJqYeZMnpcUcwIc45rWoK/wnwpyWYjHs02n1baJjM9JW3OeSthqCiEerssyW1efBPrxMO97KOkplKRiJqXB1Y+88gTh/cb7hbhvhSBA+HM4RDgaDmdBtGl4YILa2CYZ5102HvHkx7RVqRHSGVSvgiI0E0opdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xV+JUJauR2o0GsZeJ0v67oG9/xdXy3WywOhNUenNwSU=;
 b=ceiGQ91aKkJ5jU1mo0DhXNBQBARZhcicXLAM+bl8zri7PRS32ncn1IqsMi0NYp3zySCD271824a0HLRs5DXKVeALxDEvnemvXMkGQzU5qXN2g/weldy1DiyfOB+qunsASe6JnHVuHwgkAC2ZmIT7wLZZ3mo+Atf79R0cb61HwdjULTzAkWh4jy9mIKiskJhxqekPQAwXDah993phGrKrIS10QH8zkvVd3k/k6iSce/HtTdwcouAU4boC9R7bHYe/yPWEyt1iOmWGmM3P30cJwlaUvPGmnooQyv2LZphO1qrJJFAeHAijB4MuNFQ22gwTOPoAUhXN7SAIJx5JNp0pkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xV+JUJauR2o0GsZeJ0v67oG9/xdXy3WywOhNUenNwSU=;
 b=jda0yaEhXN2bLwtDraqe+O6mgCBJzoYUj1xbC6vyxYesBgYHfhtux5r0MilHpjZlbqWl/CIrwm4FPNEdaUXKiJKot6TWipXHTFtQ0BH5miNuzg2xDkPiCz5Gk72CLIA/EBHWBD6YDXHlgF9NuRCISO1n0NRiZhRKV6lNs8x8eOg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH0PR12MB8029.namprd12.prod.outlook.com (2603:10b6:510:26c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 09:32:40 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 09:32:40 +0000
Message-ID: <3b5ce5a5-ee61-46c2-90e7-2648035c9380@amd.com>
Date: Mon, 12 Jan 2026 10:32:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] board: zynqmp: allow env in fat/ext when booting
 out of qspi
To: Neal Frager <neal.frager@amd.com>, u-boot@lists.denx.de
Cc: ricardo@foundries.io
References: <20260106123729.1483656-1-neal.frager@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260106123729.1483656-1-neal.frager@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0293.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::28) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH0PR12MB8029:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f950b1f-d966-413d-81fb-08de51bd87f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1VJUVZ4VWZiaE4vQXpGbSs3dVFVN2VQNWdlelpsK0trR09rUWtZaGZibkpE?=
 =?utf-8?B?NXMwRG5VZUczdklRUzFjeFYwY3ZienNla0prZGc1cjdaMEt0dFZ1TnI1eHFD?=
 =?utf-8?B?VldpcGR3Y1B6K0kreGg0QWFzYWN6YWJwT1RjUnIvT0V0M0t6Ui92dDdrdnAx?=
 =?utf-8?B?bCs1aDlIRGZVWDU0TVlDeDBtYUZtdUNxMmtIRTVYUWRJTU1TQ1dOaXpJaXBU?=
 =?utf-8?B?T28yREE0WExLdjdUMS8vOGJKejdHWkVWM09GaytGa1lEQkF5ZFI1UVovRXdz?=
 =?utf-8?B?SkdtbDNPbzY3RGFCdEN0MENCOTIza1hvZ2xPamREMWp1dWhld05KdEY1dFp3?=
 =?utf-8?B?SUE1UlEwUHhBalVoSjFyOHlHczRpcXgzTUJreTl4Sit3OFJOWEI3ZEpDSWQ0?=
 =?utf-8?B?UHFhWU1wYWdrd2RFTEF2Z1ZGYWlJeUd2c2VEeG5qL2dLdDE3RUFtZkVuZmw0?=
 =?utf-8?B?YkUvSWdpanlMcExwUldSUnh5WjdkRHdyZ1FBUFJ1WHBxUEVqaEl1VjZxSWtm?=
 =?utf-8?B?Y3BHdXdhSGxJeWVQVEpsR24wRlpiUTVIYkhXbUhaMjBmdGd6N1RDdE1hQzVB?=
 =?utf-8?B?RHQwdnlXenI2WmU2T0pqZlI1bGN5eFc2REZFL3dWeGJzL0NvRzBLK2lxejJ0?=
 =?utf-8?B?dUFEWlhmMlpJVDlIa01sbWg2MDVMQWM1TFVlNm9IVXF4Y1hHcnJaRDcxZGVZ?=
 =?utf-8?B?eS9MLyt6SmZEK2Q0eXgvVERlajd2aXIzZG9pSWJhejJXcTNxZmFjNkExRkJ2?=
 =?utf-8?B?UGVnS1NIVVIzeGxCZ0VTaGpNUUU0dmFVeDFFTlNqYmNpcmtvakVzV0w4WVl6?=
 =?utf-8?B?OElYSzZ0aWZnL1k1SC9OdzF5b0pNcTN5RjVtOXcvUEJvZ3gzZkEva3E1WHVq?=
 =?utf-8?B?V0pGd2hVb3JVZVhaMFZGYXhaSmV4U29WVnJKRlFLU3ZEWkdRRmJNUXJhdVhj?=
 =?utf-8?B?Snl6a25mWXBqeGhpbENRTmRpNndTQkd4dy8wUmlsV3QwRXBIK3A0N0N0ek5n?=
 =?utf-8?B?RUp4UEM4TFVHWDFNcGpKQjlZVDloN3hEY3pQbDFmWVMrKzgzY0JMVHFNcGpK?=
 =?utf-8?B?RUJQeXEveTNwWUJKOWRjWGFNMkZqWk5yUjBid2xONWlQYjZ5a2g3TGc4ODdh?=
 =?utf-8?B?cEYrMEF1MDZMQTFpNjc4cUlPcXJmR3lsM3ZPWUVxaUF5ckVmT2FDL2QwNUV5?=
 =?utf-8?B?MkxtaXE5WmFmRnNjQU5MYUpCSjBXM3hYNEZ4WTFJZzU2K2E3cU5tWWxReGpN?=
 =?utf-8?B?TkUrbEJ0REZuY3lwazlJdHZjZFVhN3dXQ0ZsSWd3OGlpZldidzBiQTNxS2lF?=
 =?utf-8?B?eExWR2VER3YxRytiYk1qL1VKbnhoZEhsbEhiQTVxQ2JUd2dkOWxqeURWY2x3?=
 =?utf-8?B?K0UwME85YXkzRE94TU5IdzB5T2RpK21HbEszU1hYSnZ1K3hBbEwvN1h6bmEx?=
 =?utf-8?B?QmNvdm80RXkvVW5zeDlBbUN2a29DVDM4ZFljMERleUZOWGJwNmhDRHZtdjNP?=
 =?utf-8?B?VktuaEl1OHpwU1JRSVNUZ3NZMDMwR1NKRno3SXdXWGgwMDU1cHBHa1VJR25T?=
 =?utf-8?B?UDFQZGJLQmJiS0VUV1FFTCtEMUUzQnU2c2tsUmpjV3FGUGZQMXJRQlR1QWxE?=
 =?utf-8?B?QUJrUW85YVZZVkNHY1loQTd6cVNZcWdEWmF5cDUxVnNJRVBVMWpwdFh3WEVS?=
 =?utf-8?B?dVVGYTAza1JQSnlSbmFNS0NvZUc5NmtuLytaZDZmQ2lBaGpSL0hVVXM4WjlY?=
 =?utf-8?B?VmYwVk1yQk5LNWVtaHYydXRlcWlLRklKeHFyV2RtL09ycVQ4L3ZqWjg1d2o5?=
 =?utf-8?B?ZG9KN29WR2dNbitmK3cvZFcwL0tUZlczWUtodlRHWjl3L1g4eVFjSktjdzhy?=
 =?utf-8?B?UVVTb3k4WFJrMVJteXJOR1B0dUhJcjFvQ2pDWjkwdDZjdTg2VE9LUHB3bmRV?=
 =?utf-8?Q?mFrm2zhtv3rdA0MZvROq67FgRkUFtFzp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K01nOG1hemhMZytuNnRWcHFuNTdCaWZZVTFOT2VKSnYzNUxjYkwvR3RlRmMy?=
 =?utf-8?B?T2p3NjZubGZkSTFBaDdlOFVKT2pQaWMweG43TzQzUGtwVTZ2S0xxSDcvYXdH?=
 =?utf-8?B?U3kzL2o3YkdIZ3hzVEZNdUhna2VMaWdneDJVSVdWb1BlUklaN3o4SG9nb0lE?=
 =?utf-8?B?NEZuNW5YZ1IvVDJ4Vzd2bE1XWkNyMjd0OWVidnk4TmYwRTlQQ0tsR3lQaXZr?=
 =?utf-8?B?b3pmc3FUZGkrdXJNcm1FMDRFTUUzcThEWXVMM1R2YjgzOGNOUVExbzFYM1Qx?=
 =?utf-8?B?cDVVZmFVZ2I3eUdHemRSNTNGYUUyU0N2NWk1cC9LZFYvTlV2Z2ZYNmVoZ1M2?=
 =?utf-8?B?dXJQcDBXMHVNSCs2RGE0WHpwdzdaT0Vuam5nUHhuaWdaZEZrZWFrSlBtQWVh?=
 =?utf-8?B?Y1Q4SDBMcHdtalRQZ1JRb1NHZHF5RjAyNzBmWCtsVjltWVNRc0Nmd0xvUVhG?=
 =?utf-8?B?OVhxVjhrNW4xc2pYclZJVVFhT2FsYnJtekJXcTJ2MnBPanI5RE5FSWFwTWJu?=
 =?utf-8?B?V1RhMWtVYjFmM1BvbXcycGN1WEFGV0JuSzVsUUZiK2s3Vk84ZWhsWjZmaGpv?=
 =?utf-8?B?ZE9oSGJoKzF3MlNGam5rcXY1LzV4NEFVMndqSkRGSnpqd3pLTFFnQ0FiUGs2?=
 =?utf-8?B?aGZJRHRvN1hiV1hsdjg3dlBSKzJITXpJeGdFRmVKVWl0QWN0c2p0aWlkUDd5?=
 =?utf-8?B?V2pDRjZNdWlMRWZEd1FWVG1FQmtSVWRSM3hzMHlQTSsyT0t6SVc3UUpWNExW?=
 =?utf-8?B?RCtrbllPYWFkT3J1N25HdzZsRGwrRHFQWVA2eXIyZXd6UzFDUlg2RUd2SE9D?=
 =?utf-8?B?Vm9VZ0tWVHorTzdCRk9ZQjN3aisxTkxaYm5vRVgvUlJCVlFnMEZZMlg1ZVZO?=
 =?utf-8?B?NFhPNWJoK2VtTEdmaHVsRXlEOXNQSTBuMTQ5MTFDK0ZsemwrR3RuQUdEWmwz?=
 =?utf-8?B?SVNCQkttUkI0enNBU2NKVWNXckc4YVowZWRUSDM5MnhNMm14d3VScFNnczhy?=
 =?utf-8?B?b2NaWnBpbXZCN0c2V1JvTkhnL3ZMWWFnTmF1aE8vTWFsWm95T25adlN1RVQ1?=
 =?utf-8?B?UGU2NExHTGh4Si85WFNBNFlPTUwraVZLbytvaXRNbnRQV0tUbFlqTGR6V3ZX?=
 =?utf-8?B?RHRLSWRKNGQ4dmhQOEszMjhIcElGdjVFQlV0RWNxbnZBYXdYeVNxZUFKcXE0?=
 =?utf-8?B?aUVTNWtNQ1JEaWRpV1ZLT3FEcHFPWTZiT2pXek5oN09kcGVUejZuU2c5U1A0?=
 =?utf-8?B?T3AzY2JENkhhMHJyNmVYbGdleVpLYk9VOUNxUGFJRmtxeTQxdlBtL3pEcjVX?=
 =?utf-8?B?WVF2R2EwTWttVlZlQ21KY0FvV01jMFBQeGhoa2JVYmdNYjNDeWtkNUdMdlUy?=
 =?utf-8?B?aDdyMjJVWXoyTWRiWnh3MlJGZ096cXRQVDhBWkF4aWxpMXhINUlTbjVuWHZ3?=
 =?utf-8?B?NUtMN3ZLZXE1d1BYTWhDQXRDTEFEdnI4RWdFK3hwN29OTUFoSXZ1UEVtb0lB?=
 =?utf-8?B?YVFEa1dEdTE5c3dleVo5cHhYODZFeXlDSFlkUDRVdVRkSVBhYmZEUmN2TUpL?=
 =?utf-8?B?eit0VWF6K01raHF3OWhDZ2x1bVkwc3BSRjk3RjBsU1FKTTA0eEcrVHM4QU9R?=
 =?utf-8?B?ZWFQOHg0aVR4Q1FmOUFIMjd6V0tvbUhkWnVqQTFTUmVuYTNhUEFWUi9kMHhx?=
 =?utf-8?B?YlltVitvdUNuVlFlZnpwUkZPYll2NjhnY0dZTXFNVGxYcUI2RXgrK3N2Q2hi?=
 =?utf-8?B?SjdlYUYvL3U3T2ZNRDk3dytHQncxTGN5bHhsU2w5U3I0N3d2ZUNrZWJlUVR4?=
 =?utf-8?B?NE5rd2VQcXY5VSs1UGM4Q2kzSW9JR1BaeW5lR1d5eDhsZmNrb3VGdjhPUTBV?=
 =?utf-8?B?bVovRW8yVDRtbHVBVXdwZ3A5dnhaWnJxOStCTnpkZERMVTlLY0QvRkdSVGNh?=
 =?utf-8?B?Vi8xaHdXZFFjQlhDR1dkTFZucHo0N2JWNVZ0OW00Qm9veGxBTzlKbkVRMlVa?=
 =?utf-8?B?Ujg2NmJ4bW1PK0VmSno2SXVIOG43Zno3M3VHTE4rZXEzZzRCSFJwdHE4bUQy?=
 =?utf-8?B?dHVOM01wNFVJaWNjRnM3MXl3djN0M3Y0bVYvSnZpNElXa2F6OHhoZmlsWVQz?=
 =?utf-8?B?NmZDY3IzeGV5VnROYm56Wlg5dzNqdU8zSzBEQ1VmNTVzeFp2eGwyVHFlalRt?=
 =?utf-8?B?elNDYjJ3RWJVRlFlZi9vaGNOeFQ3S2hJbXhaNFZmQnJHSkYvTDh6akk5YVl2?=
 =?utf-8?B?anNmUjVqQWRHak9sVk55WlJjSXhoWHAzcHlYY1hTQzNBNmdTamFaaC9NR0Fs?=
 =?utf-8?B?bTBzQ0RNU1g4T0d1eVZaN3ZhN3Nwb0dHSmtNM0Yrd0hCRU1nOE1TQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f950b1f-d966-413d-81fb-08de51bd87f4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 09:32:40.5777 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EEDd+xHU5lpncIsLJ7sH7opNWbmVqu1+mbBg5twOfHXfzKLriHoxUPQV14gfrxoT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8029
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



On 1/6/26 13:37, Neal Frager wrote:
> Allow saving the environment in fat and in ext4 when bootmode is qspi.
> 
> Signed-off-by: Ricardo Salveti <ricardo@foundries.io>
> Signed-off-by: Neal Frager <neal.frager@amd.com>
> ---
>   board/xilinx/zynqmp/zynqmp.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
> index 3b28ba62374..769e52bcfb5 100644
> --- a/board/xilinx/zynqmp/zynqmp.c
> +++ b/board/xilinx/zynqmp/zynqmp.c
> @@ -628,6 +628,10 @@ enum env_location env_get_location(enum env_operation op, int prio)
>   	case QSPI_MODE_32BIT:
>   		if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH))
>   			return ENVL_SPI_FLASH;
> +		if (IS_ENABLED(CONFIG_ENV_IS_IN_FAT))
> +			return ENVL_FAT;
> +		if (IS_ENABLED(CONFIG_ENV_IS_IN_EXT4))
> +			return ENVL_EXT4;
>   		return ENVL_NOWHERE;
>   	case JTAG_MODE:
>   	default:

Applied.
M
