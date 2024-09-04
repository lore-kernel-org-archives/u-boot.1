Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45B5CD3431
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 08:09:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C02188C1C;
	Wed,  4 Sep 2024 10:09:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m+e2v+CH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E98BE88C8A; Wed,  4 Sep 2024 10:09:17 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::625])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E32EE8876E
 for <u-boot@lists.denx.de>; Wed,  4 Sep 2024 10:09:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mX7qsXxwTdZP24Fm0oBYW/W0Y6K3VyTOHPr0hfyoognYoMPsIEiAYrEenB7jhvNeROrWM7kya5LHD+a4K/K1AUlSmeOkWxKlXpUkuaD82ZHbIqoNL2KWJE0cUUa9HvvFia2lOIyT/KGmd04599qSpKOiOm9lPEajcZlBUkBCDpZs103dWFXGzhlBokurokYtbuM7bJGJbs/FioSFsa+9KbF0kVJbIw+58sQ0jZbWXp7xA3n2gwbCuT1hKTF8ifb6K4uT6GfOnIY1boXaVa3UVmMj/xRj67k4SCqjfvSl0fhX82VVzKMXQ1gLAZTSG8yEx2Ocr1lfD2a7c2EYoQUo/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkkhuXbEu85z0cwX6Jk4zR1QyhK3tdZsT6mGJqjLxW4=;
 b=IJZBCDbsfTWXi8JW3vWRCauHueQ3q9TIFvHcwxFQQFCSMjjlX43dXUR6km1LcUDny1R6R64x/XW7jJ3ieTglxt8bxeEaRa4ZkZm2QYXWW734QGCZxFmycHUEpb1omFfysii3t/TyC7GP5DpziW9XLyLAPusaCIMk6Ut+zDBrhr9TV7Zxi53q/PQ0oKUIWwjEnMsVEn9DQ9F+d99c2RuK3hy9TZxz/yTO2PeoFNohLoL1MkE26ALMrs355w5wnzdwrZFEdpfsJjWL9YOqQT9cMGWTgRpyl14NuT6dc6pIqAb6qqu8f2kOJbd64uyDDhhj+Q1joTOijh3whLRUFkMZlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkkhuXbEu85z0cwX6Jk4zR1QyhK3tdZsT6mGJqjLxW4=;
 b=m+e2v+CHBQI89+k+u+baqWOuuzXGJC3r8UQcr+4xHl6UzGCqA1gFrK2t2bBNuFaTmzaikD46uZioVkzrGu9VdihJqZIegEkxmrH4yWZKX8UHMwnI6fNYwxnxIeEdtTZtaI4aJsy/WCFuSvlhxJvlfy2ly7j1tG4s+ZjaUrMElP8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CYYPR12MB8889.namprd12.prod.outlook.com (2603:10b6:930:cb::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 4 Sep
 2024 08:09:13 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 08:09:13 +0000
Message-ID: <4af1e372-4527-4bf1-9822-1d69bba88a2b@amd.com>
Date: Wed, 4 Sep 2024 10:09:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] fwu: add dependency checks for selecting FWU metadata
 version
To: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20240830114057.891069-1-sughosh.ganu@linaro.org>
 <20240830114057.891069-6-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240830114057.891069-6-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0006.eurprd08.prod.outlook.com
 (2603:10a6:803:104::19) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CYYPR12MB8889:EE_
X-MS-Office365-Filtering-Correlation-Id: ca520f0d-374d-4ecf-1943-08dcccb8dc9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OU1qaksxR0wwV3ZCZzdHME40SEF6aFkvS2Yxcm9VM2VNeEh3ZnN0NmIxRjdp?=
 =?utf-8?B?bS9GcEQyRmkxQ2lVOXBvMEJPUzBpdjQ0Q01GRllxZGhXbnYxbmE5MGVBZ2R1?=
 =?utf-8?B?S0gySDBKS01MVlQ0MzRyUFpabXVoZktQZmdnejJnMlZ6T0dBMUJoaVpqMUg3?=
 =?utf-8?B?TDJWaWVkaEF4SkJNQ3lhWjFMOVFNZjZkc2MwZGUwOEYzNjZqalpIUTl2cFlk?=
 =?utf-8?B?eHQ2VXBCbzlXSkF6S21SZnNiUWNocmk3UWJHTisrb3pKM2JJUllhUERjeWVj?=
 =?utf-8?B?ZDFJZFZZMVJtaXpVcVo1Tkl3UDMzd3FVeVN3NmhEQmJBaDNrRWF1SkxNSFc3?=
 =?utf-8?B?dmNTZjE5MERvb0V3YWx0emdjYnZpR1poY1NiOWFkRWJ6K3dkN1NHL3htK0tT?=
 =?utf-8?B?NFNoK1ZXM0c3SlpQTmZSRjNnem04U3R5YnFtakZsS1BVQXQ2SU41WXFjTjQ2?=
 =?utf-8?B?ZXJkYyt2V3VWalNvK3owMndvMFpEMk5XSzMyRXFXWlhGcVZqZjVLZkhyMlE3?=
 =?utf-8?B?R2Fpa1kzSkJmdThDMGxHSkphSDl5cGt1QmdmNTRabDZIaDQ1aGdSOG9vYlhm?=
 =?utf-8?B?bE4rM0V3dGV0RjlYOUVEMFZ2MGFqZ3hmYzNCTk9uSU03QU8wM3NpWDJjNWhz?=
 =?utf-8?B?UitiU1BjN0tyU201eFhIRzFpcWhER1FlYkxCYVMwL2FwZm8wbmtwZ05mWThY?=
 =?utf-8?B?TFVkWnZTNVFuQisvalNMTC8vZlRHdWtIdUdNeVR1K2hYZm1PeC9ISjRrdmRD?=
 =?utf-8?B?NEZwS1I3bThHbEFXdEQ4STdNZWNON0hnNG1aUlc3czRqQmFydVVJWUVjS2xU?=
 =?utf-8?B?UFVSKzZCVDdkNEhRWjdhTkxLVmdPc0hnaHY3bGJodWJoVFAvNTk3bHF6d1JS?=
 =?utf-8?B?Zy9iLzV4NG9rVG1aVHM5U0JsZWdmVHJjQ1dqbno0RllzWUxTVVBHYTZmamRn?=
 =?utf-8?B?SjR2em9pcFp5TDk1YndXQTZTQ1B3anpXVTcrMC9iRU5kYk91aVdNdzFLclFI?=
 =?utf-8?B?aWRwSjRuVSsxclVVSUJyNTlJNis1L2xvdmpyL2hXclorTisvcW1mZUplMTN2?=
 =?utf-8?B?V2Fwd3crQ0tmZ1k3cWpXQ2lKSEcrNFJSdDB6QnFXTXI0NE56cnR5UkNwcmVu?=
 =?utf-8?B?Qm5SYUIxQnVPTnV6aitmcmdVWFZrTW0xZXNVc3NwZGUyNHV1anV2ckMvVzZT?=
 =?utf-8?B?T3dDZGc1SnZta0JVQnBZSnVPdklDcEpXTnN4WnNveHY3aWxwTVk0SFI2K2Fm?=
 =?utf-8?B?NXd1UlVyd3dxd0pRY1ROUmJNMUczZExqbmdwZXZ5dmx1K2tFTG9jdk16cnpq?=
 =?utf-8?B?VlAxVFNqWGN1Q3NZZUhqN05VSHhDQXAzYy9Hd1RtRW01dmdTbkdvY1RhMVl4?=
 =?utf-8?B?UnNTSGhQNFBCYjQ1UDI3Q1pTUlFwZUlTaFhDVkRPQ1pqSk43aDY4MGt1cGF1?=
 =?utf-8?B?VzBDU3llMytyTlJJL0twSXZVM2NSeTNnVjRZWkcvbVFMRUlQdnhVaTlJTDYz?=
 =?utf-8?B?UTlaUTQ5TmliVW9mZ09iZFRQSFJOeGE3dUZxYjA4ZlBTck5PUWJ2cVdkKzJ6?=
 =?utf-8?B?dTVuSWprU3JPMEh0WGEyUkY3NFVydGNGbFBMMHNCOWhtMXV3MmVVdlluaFRT?=
 =?utf-8?B?SEhNQmZnQkVyVStYUW1DbHdUK1d6bVFoZFN2bUhCOFBtUzNIQjNPZnQwdDRH?=
 =?utf-8?B?TWJXV0Q1NysvUDhHMkxpMkZObElnK3ZBcTBPd2hPQis1UkNSdUl4YlZoNkNk?=
 =?utf-8?B?cUtXdkhESk1KbnBGeE00M1BQWEpyUlIyMDVkTWtJWmc5Zm40YzB0NjhZSU5p?=
 =?utf-8?B?M29Ta2NSMFk3UkpPVzVQZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2dPZUZtMUdYMU5KL0NNYmtoRlBoYTJqS3Q3ZHFqM1k1N3pHdVdqK3FDT1dR?=
 =?utf-8?B?Y0JIakl4M0F1djZ4aEdmdzFETHd4TXpVQm5qdTlkVFVTTlJsNytheVpsR1VR?=
 =?utf-8?B?d1VLZUswM2FIQkdOWHZzWXJOelpOekhUUzJNTW1rQWs4a1lwNm9RVEVycm1O?=
 =?utf-8?B?b0tPTmdUWHIyaEM2UWpBN0NGRG1lRW9weHQxbVhja3FPenlhTlN6cVltVWVL?=
 =?utf-8?B?NDhCeFVHejRZNHpWVFZ1ajMyaWlDd0JkQ0JpcUp5azZ0ektldGxvWUozTTlQ?=
 =?utf-8?B?WmFVQUtiRnhETlBGVlJFb3RYMCtKelJlbXB6VW5qZ0RLMjN3ellNL0NYRjBO?=
 =?utf-8?B?RW5WcklYeUJBOFJGUllmRlJzWktjakpDUGtrRWdsZE5QTHdGM0FhSEhpeTJK?=
 =?utf-8?B?UnJWRUd6cDJ0N2NNRkphMWNLZlFabEZCa2ZlY2Y0YUdOb2ZDb0loQWcxK2Za?=
 =?utf-8?B?WndzbzZiSm9nVHRMaG1IT1dUdFdQR0dtalNzWUNuRmozaU5pT2daMTdHSW11?=
 =?utf-8?B?eGdaRjFiZ3g4MDJPaVNOdUpDQ0kxWWJJM011R3BKT2NkRTNzckVwMkRUUEVk?=
 =?utf-8?B?T2xoU3pjUnVNMG0zL2U5cDg3T2RJbHN4cUMwT1ZCbDVWNzFxYTZNTGtXdGto?=
 =?utf-8?B?Z01nUVpVdzVyTDUrYitWbG16WEJ0Q05UWk9tcDh5RXdWbm9nRVc1RW5FUS9z?=
 =?utf-8?B?QVZGUWlteEo0d2ppSHlSYkgrTDEyRUpiRDVuYThPQ2Y5WDNNRm1KUUlDUUlU?=
 =?utf-8?B?b2R3UUgxL2Q5dC9wSVhKVVZPWW1Ua3NTUXRvQTJUUU0yNUduQ0RxTGZKbm5P?=
 =?utf-8?B?TFc1V1ZRdWltdCtlNFRMVDRoc2xRT00rNndOYWppNnZnaUdqK3RUbWpxWHI5?=
 =?utf-8?B?WWE4VHN0L2FuMFdnSHFscERkRTc3Yld6Rnoxb1dsRWZqbEhnSTVla2RQaTBU?=
 =?utf-8?B?M0UyU2xQVzlYUjhHRDZEM0p6eVJPNVozTmdhVkt6QnBMcXpEUDJOZzhwNC9F?=
 =?utf-8?B?SnVwVXZsYmRrejlQY3UrSW9RdEc0MHZGOE05TlVnTU52TWhvUjFiellXWkU1?=
 =?utf-8?B?L29hK05GTW1LVWx4SEhnT0V0aVR3cG82MDJ2dUhkUnA2eDhXbFU0ODVzMGlr?=
 =?utf-8?B?azdmMGVtM21OV1JWdDdoeXVxZm5SZWdRRGJGQ3Z0R0JFVktkK0NDNGVGeitB?=
 =?utf-8?B?OVRWS0tDZEY0MjNhemhubzc1dEdGa3NDVjBmdWJrYi9pYU5TMmJPckpQZTdi?=
 =?utf-8?B?T1VobEdtbXZnQm5PekQxTDJ5TmhuY3ZVcjB3Y2VUL3c3RnFVbWgzUURCQy9X?=
 =?utf-8?B?cFc3cVEzSURtbEdUaW5FYm93cjFjaFowaFUrRWs4RlRvN3dPSHlDZUx6bG9J?=
 =?utf-8?B?TWJDMVBnY0hIM2U1OXVCVGZmM0tDS2dGZEJncWFkeDVpbjQvYmhaS2NMeTMv?=
 =?utf-8?B?K0tnS21mamluSmpJR1B3MDdKaXlySXpVSURNcFhmUDJMZHRGeE40d2NodzM4?=
 =?utf-8?B?NGF6ZHBmZmNkZFVvbnlvVmVWMkpnM1JJVnBkb3BsUlhWT2dwUzlEZ3NCNUJz?=
 =?utf-8?B?bVZyVVBHQjFHWFZLRGJjUTNHWGkraG9sajFSNUlFcENGbWordEN2YVdvbU9v?=
 =?utf-8?B?UXpxbWZQazZFZ2I3amh3cHdyNFRFVW5KTFRNQXczOU1tcit0c2JuZTRhRkcx?=
 =?utf-8?B?YU5MTVVCR1Nad3NqQlpKMXVUMWk2ai9Gd3o0T3JVcXVMTFlPcFdKaVlXZjlz?=
 =?utf-8?B?MGF6MkhaaHQyYjlYOUV6dm5NaXRSR3YrK1NMWUF0TG1wVGIzdGFkemNCT09t?=
 =?utf-8?B?SEMxU1dtUFVlUUF4M3lma1djSEtudkhNbDFvWU5WanBsWEdhbGZMTnFNOTY3?=
 =?utf-8?B?ZExhN3hCODlPOHFoditzY21yaTJhb01ZUmtMQjRNc21xOU85OU1hWlNWZkg2?=
 =?utf-8?B?V0ZZSERmbnBHdU9PY2NOVy9KNkE4WDFDNGZLcFY2d3VWMEZBV1NERW83UmxI?=
 =?utf-8?B?MEdWV2RwYU50alorSlp3NEEwZ2dRSXBZVzV6ai9vOXpyTUhVUENQNk9DR21r?=
 =?utf-8?B?R05TVTI5MFpHVThKam50bVV4OGdtTVhVTzhSN01UQzJqc2Z0SkJreWVmbXZq?=
 =?utf-8?Q?rcYeOrm7lELFIMTIOtPhYEZ4p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca520f0d-374d-4ecf-1943-08dcccb8dc9b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 08:09:12.9291 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ZwirOb+W/ADKlsb8xhnb0Ivfoma6ZUmYEBv/Th5XJwS6d9ubybezimak+PJ5JE+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8889
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



On 8/30/24 13:40, Sughosh Ganu wrote:
> The FWU code supports both versions of the FWU metadata, i.e. v1 and
> v2. A platform can then select one of the two versions through a
> config symbol. Put a dependency in the FWU metadata version selection
> config symbol to ensure that both versions of the metadata cannot be
> enabled.
> 
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>   lib/fwu_updates/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/lib/fwu_updates/Kconfig b/lib/fwu_updates/Kconfig
> index 51b7fbbefd..a722107c12 100644
> --- a/lib/fwu_updates/Kconfig
> +++ b/lib/fwu_updates/Kconfig
> @@ -40,6 +40,7 @@ config FWU_MDATA_V1
>   
>   config FWU_MDATA_V2
>   	bool "Enable support FWU Metadata version 2"
> +	depends on !FWU_MDATA_V1
>   	help
>   	  The FWU specification supports two versions of the
>   	  metadata structure. This option enables support for FWU

Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
