Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D242FC3271E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 07:58:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D11388444;
	Mon,  8 Jul 2024 09:58:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c5oGD39d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F4126884CC; Mon,  8 Jul 2024 09:58:49 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::631])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42FD9881DB
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 09:58:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RYMdcs6erLLEMlksReeU1W0e81XSpnaUPwx7lyuUBZdGtKFed2YNToTDfsk5IXkhLYwsd+RMZzLJ9RyDNZrGJ5NKujNuy1CdQuAcpFxv23RqkUulNTaG3tuo1qq9L94B6yx5xK0ebLenZgjfI2oXhjlo8Ed6+Q/kHm587SmEm/piztCuFFDORojhm93vm8tRBTNa8dTakNvXub5N7/xavPjaY5h+24DRJkVxWb61f0EOFpEL4l3yAZEiiH0CbR807GgrHoNlYYwTK1SVdA4DLejOMlnFCiUVmXQpGFfVAtxjLBK9k9Ri+t0TMlwKr7uxAXlilELvdq/iiUeeSyn4OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obY3CtHbw/MMLcfYvIoNdlQ01/fcLO/TFDQR/FQCSjM=;
 b=dVjeU9VNixyaVj9jMwRntep2zcg41fepUwaUr0EZ2g92zLQAvHUAvmTSrANcupq66sZA34N65QQeR//LGfs9X9L0Qb/eDK+4EAxa7p9Gh+HPs4HlndxL0eVJMbebCgrtJQ6mybhTHFXrz8bdWPYc70uGsG1hpee+oUB4lSjviwKOWeyhtnr0SQfWIq6TEZh5yG/nGa9gdSwIrtepfGpq36e1+VbLeT4XIzk0z7j8fRYTFEKkHDL58aIs5j3lfwQnsgwRmGIQoBqPpmfWiPLYv0poaRqa7dc145ATFxXa+ShbNPz3XzpAd3zXxSzCgxHGIMz7iVFWHwEhU3uqvZhauA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obY3CtHbw/MMLcfYvIoNdlQ01/fcLO/TFDQR/FQCSjM=;
 b=c5oGD39dOGFq0HMhuv4pZ3yWJ2XxtDQBT204j1V43WNLb/7xMJIlqnJTyUXw9rZfFyM+JhOvOcO5JGx5sRHviTjIBvcIjidwwxyJsAxLNO1Vceu4Jx7GjZpIrzuXNZL6olwEAKswxGp0DGIcGCBVotT3pxVMLCCn+3JbMVBZUwA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SN7PR12MB7021.namprd12.prod.outlook.com (2603:10b6:806:262::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.31; Mon, 8 Jul
 2024 07:58:43 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 07:58:43 +0000
Message-ID: <03cdf568-7be3-446c-a1f4-daa8d55af0ef@amd.com>
Date: Mon, 8 Jul 2024 09:58:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "zlib: Port fix for CVE-2016-9841 to U-Boot"
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
References: <20240627154909.3536095-1-trini@konsulko.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240627154909.3536095-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P189CA0025.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::38) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SN7PR12MB7021:EE_
X-MS-Office365-Filtering-Correlation-Id: c241b318-9068-4fce-e996-08dc9f23c9b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WmtHYVZHQWpyaEZkSEdHVkV3eW8xL3cwcWNQMzRRc1FjRWxuUlg4Tk9GMTQ4?=
 =?utf-8?B?UHVXTGtiZFNlMkgrY2NWbnF6V2VtOTRrcmUwSzJPUGFVN1NFOU5qM3FZNHdl?=
 =?utf-8?B?Y09QWlJ3V20xT080dFFUTzVkcUlWTVp5U3NwWUtpYXBVcWhpbW5VQlJCKzUr?=
 =?utf-8?B?Q015Y2V2NXpQZW8vYm1RRXZCRHZKZ2tVM00rbEVSaCs1eWhabjRQOG82cjJH?=
 =?utf-8?B?VFYyZDljMjBoRHdkVEdFSmkxSTY0TndINFhuMk1kT25SV3lYWmQ3USs0dmky?=
 =?utf-8?B?UmZPT3FRTVdnWHMrODNTOFdlZWlGa3Q0SGZ5dmpneTVqYUxBejRlRm51Mk5D?=
 =?utf-8?B?QktOd3c4MTNpL2RhMlYyc2ZIRWpzMnRGMlp6Vnh5eDlqS2dHT3RuWG5iWkhC?=
 =?utf-8?B?a2t0c0o2Rk5Pd3JKa2xIK0RybldOd2w4azI1dmsyRThHY3RmdXJNUUNxbyt1?=
 =?utf-8?B?VHpTUlhRRlk4VnRtRmZpdURWbDdWVm5HdHdBS2wyWUFpS3BtRzNHUENqRUF2?=
 =?utf-8?B?aEVMUlJlQnAzVDBNTnBnTkxwbldhNFp1Rnp3OWgycVlEZ1IxUTJzWmo3WWFX?=
 =?utf-8?B?ZGVwU3ZiNTMzYUpZSDdoamRHY3h0KzByR25GeXhmK1ZmSy8zZU4wMEVUVXJX?=
 =?utf-8?B?SGZsbytkWUcrdUZnN3Jia2M2elkxOUkrZU10c09QMzNSWUF5cVVDd0xtUWs2?=
 =?utf-8?B?dnRrY1RHaVpScnZuVDhDYWdhcm9vaG42NVNxVEVKT2NONC9PMWpsQ0I2cC8z?=
 =?utf-8?B?ak1DNlFITUU2OU1YYkJVY0JwMlZGZXB5ai9OY2x2V0pzU1d5OHI5SzF3UHlQ?=
 =?utf-8?B?VlBWRHljV3g0dU5XSElIS3BDOWlOT0UraDNLdDIreXF5Zkl3NE80OGdJZ0ZQ?=
 =?utf-8?B?aFN3V09FNWhHdzhMK29rcVdOSnFtK1oyNDdqQlVVckhKVVZGaDBoMkpvZlJR?=
 =?utf-8?B?RDdCNmxlK0k1WjEyekkzMCtVaGw5aEJvZC94dDNRandwc3k2QktnZ0srZXZi?=
 =?utf-8?B?OGZQdGtob0lMQi90WHJHaXBxaWJQNHhHMEF1bGVGZ3NuT0pTNzhFclUwS3lp?=
 =?utf-8?B?MEQ2OEFwWFY1eHBBWEFzcVVNYlBkYy9BVVpSS3dGUFExdWRYVlVSb1A1anFX?=
 =?utf-8?B?WGxmc3F1ZTliazNaYks3Qm1kSFJQZy9tcHRmRStWY0JTUWQxSC9wcE44TVpN?=
 =?utf-8?B?NVNsK0tSbVZER1lxMFV6d0RSeFBtU0ZCaHVDY2k0MjVXUHhMeEE0Z3FjY25C?=
 =?utf-8?B?QStVeGtJQWM3ZE5YZXphVktEblM0OXRxNjkrMGlLUWJZYjBMRHljait6YlVF?=
 =?utf-8?B?NHVKWHllZUg1S2JTL293aGhxMmpQZGIxY3V1M3hsNHlWOGUrd2xsdjA4Q3cy?=
 =?utf-8?B?UW9XSjRSNm9uT21LY09Od3ZZaEtpT1lzUDgzdUVuOEVsVGpEQmdqZGNNWE43?=
 =?utf-8?B?SFoyYy9iNFBwbnI3all2R2NSZEdnRER3YS84dEhES0lIZHdHYURvakZiUU5V?=
 =?utf-8?B?YTF4dHJ6QXhGR3pmTUpvV2l5aHBXVERTY2E5dExhTWtYWDYzRWRFQngwTEVt?=
 =?utf-8?B?MEpqS3I5NHBvNVR0T0xRbkxIWjUxdkR4bitGZGovL0RqakhvYnJYeG1tSGNI?=
 =?utf-8?B?SllrM3FlS1ZRZVVKSllLYnBwRnVoUktBT3YzR0d2a2RqdnphQ2R6Qm43dUxm?=
 =?utf-8?B?cWNwWkpCMTg2a05LaUJFR3VId3gvVXZJS0I4ZzIvRGwvWkwwVzJhVUREQnQz?=
 =?utf-8?B?VjYrMnd5Vjc0bjNRUHBvTU4vdVBQTzQ3S2w0a1Jrc2tEcUNPYy9Kb0N5TlV1?=
 =?utf-8?B?RnVTSUtidjMxUmFseDEvdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eldwTzJIU0FxRi9QdkEvVERHY3pydnpGbXR2K05QWjZnSndyMCtuaWptV0tG?=
 =?utf-8?B?VE51TWNkRVlWSDI2dVhEQWMvemRnZVhKMk1qVkY2NHBnMGg4eFNQSlFGRDRM?=
 =?utf-8?B?VUhuY3RSM0Rxejdoc1ZYbzJ4RTREa1NJM1U1dng5UEdLeHRIUTRySE4wQllv?=
 =?utf-8?B?U2FLMm1UOHA1aUtVcmVtVEg3bCs3cDNQUmZ4R0J4VHVDcjlNek93bzBBUlpu?=
 =?utf-8?B?S1RiVDQ2OFp6cDhaOWI0M2pWQ295QVNoa1ZDekQ0eElDdUVOOWE0ZzlCZnQx?=
 =?utf-8?B?dUh6aDRFeGFleGJRM1l2MW1nbENWUjk3NHZlNnFPd2FUYkZ1UGcvcWI2U2hp?=
 =?utf-8?B?M1JQeElLaVlJME5CWnY1U0h4bTlKQWdScGVpbGNTSkkxOUFlNTBxYk44OCtK?=
 =?utf-8?B?RldSSVRPVXYvV1F6cTJ6U3hkRDdPM0VNWGtBeXFZeGplUVpqZEoxU2Y2bnNR?=
 =?utf-8?B?VUU1bUpoRE5UQkNFZktCZktQVkNFSmo0bkZYSVRUREVHZ0YvaXd3UkV1OGZJ?=
 =?utf-8?B?UUFZUVMyVGFxOTR0RDJQVFhuTFJtUll1L3AvMzlzaVd3QXpUajlyenBFM1Zt?=
 =?utf-8?B?TjRtb1NQVitVL0ZCa2JQTUJOUENnY21USFpiRlUwT1NaTFJlREhNWTVSQ09F?=
 =?utf-8?B?MWNPYTBjUnNDRkNseXZQdjZhdzZiTzd6MThsNnRVRittK1M4RzdUemRxNTgr?=
 =?utf-8?B?YXVLRWV1TzlhYWphNkt1bnZ1aG5FUkI0eTYrSWlGWU0wellENmpLNUNsWk9B?=
 =?utf-8?B?Nk11QmV2Y09zdHYvN3ByL1ZlSjVkcEFkaVlFd3ZwWmlZQnBDUXR2aTBqb2Nn?=
 =?utf-8?B?N0xQYWpCcTRYR0ZxR0ZLNXdVcVVVcHNlbDJiU0ZHS2VMdDlaM1cwVXFtYk11?=
 =?utf-8?B?akE1UXg4ZVpNdHZNV251SXUvVEtsemhOUUdjYURhUkV1YjArYXo5cHdyNTR0?=
 =?utf-8?B?MGpsOGV0S2NpSVlQbGZZWmRyZkVFUi9kNC8wSTd3b05TNU96NUs4THUydWJw?=
 =?utf-8?B?dVExVkt2S1dETytDemhCbzgxVVdpa0RSV0s0VzZTQTZlSWpHMnNNUEF2MTdm?=
 =?utf-8?B?VEVLZHlmK1BheFVQWXRNbmQvYnllZS9kOVVlQzN2ekMrZzNxYnFFQjZjT1Jr?=
 =?utf-8?B?ald3ZnZFOGRCQVhDaFFlQ2QxS0NBazZwTUpqUXcwL2JoMWhiZ1ptTlhBVSt0?=
 =?utf-8?B?TnNkU2RlQ1lDV0J4OGVtZ0xXdFdsVFYxQ2s0aXJRcE9HRGNDMmpYZTM2Zmc5?=
 =?utf-8?B?NkNaNGhPcWc5RUh5MzQ2SURPNWVoTHE1WitlQ2I2OTdmNVRlVFlpc241Vm8z?=
 =?utf-8?B?Rk0rVmtPd0RGNEZ0QXUraE15U1FCTjRTYnBuSzJmT1MrdEIwYWJyT2ZKcTA5?=
 =?utf-8?B?K2ErcHVmSHRMMHpBSUlZaDBEUk9pcEVXSHF6NmlseGV2MHk5UDJPNm1FSGl3?=
 =?utf-8?B?cVNaWis4bUFjQ05YTVIxbGRKQ25qeWVmaTVGTHVndCtlek1FV1NjUzNnTXE4?=
 =?utf-8?B?Mkh6TjJOSEc2Q0c4elhRMjZVaDg5TjBDSExmQ01sa1dLSGhuNVhFTklQcGow?=
 =?utf-8?B?UVBCS09EWTlqMzZxTmt5bnBJcklzS1JTZzd1bFpXT0tNY0xGT2JsQVFVSEZX?=
 =?utf-8?B?RTYzMG5YN05OT3FkRm8zTHZzbTVPcW5rRDdKSjRsbHhSOWEwWlh6RjZGWE5n?=
 =?utf-8?B?Wk9FZ2dSRDdaSWtSQU1hVWVFdVpxK296MHcxUWZhMnlVQzZBeGY3alZzZ2NM?=
 =?utf-8?B?RGl4WFAyU011TmorUjNzREI0dmdaUHRsZC9keC8rdnF2UUYzREJLU0NMZXZJ?=
 =?utf-8?B?ekZNejdJYzVrMWRQTUVTc2hKamxmNERMYllUc3lBSFdVV0QrQ2lNWTZZb1hv?=
 =?utf-8?B?ODVYRDZFK3QzTkNRcVUzbVRzOXFQQVNTWnVxQTJBNWF1VklNdk5zQ1JvTVp6?=
 =?utf-8?B?TDZML1NSVTZuWjA4U3I5TFgxMFVpeVdHcnZ0eUtEWVF2b1lwaWpUSlZ4MnFQ?=
 =?utf-8?B?T1BWZm13Zzdaa2c3NTBpVVRoT0RMTU95UDhyanRqYS9rYUJtbUZ2SDBXdzgw?=
 =?utf-8?B?dXNtb0FwUGdkTVp4dXpSQUVrR2JUaytwWFdJYlhyMTIzZGJhRXorNVYxd0pS?=
 =?utf-8?Q?d144wCgXVwHP7yG7DSpX1SY4v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c241b318-9068-4fce-e996-08dc9f23c9b3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 07:58:43.8770 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJIp2QGRWlri54ozVzZ0iWyb1iKlSI8NbQ0Hq/HUmGRygZxq49MublzuRn28CKYR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7021
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



On 6/27/24 17:49, Tom Rini wrote:
> In commit 340fdf1303dc ("zlib: Port fix for CVE-2016-9841 to U-Boot")
> Michal brings in (correctly) the upstream fix for CVE-2016-9841.
> However, when upstream was fixing this issue they also removed a
> necessary optimization for some CPU classes as part of simplifying the
> code. This in turn leads to boot failures on the platforms as they now
> take too long to decompress images and so the watchdog sees the system
> as stuck.
> 
> The long term fix here is as Christophe has posted, which is to restore
> the optimization. Given the nearness of the release, what I do here is
> very similar, result wise, but less so, code wise. This is a revert of
> Michal's commit _except_ we only allow for post-increment in the code,
> thus keeping the CVE resolved. For the next release this commit shall be
> reverted and then Christophe's patch applied.

Sorry I was out and sorry for problems. Good to see this patch.
I pretty much think that long term goal should be to use upstream zlib
and sync it up regularly.

Thanks,
Michal

