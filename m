Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A45DC369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 11:35:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D12C182DA1;
	Wed, 16 Apr 2025 13:35:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iWwY3las";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07B7B82DB4; Wed, 16 Apr 2025 13:35:49 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2406::60c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1C7882C96
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 13:35:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lTeArgRAULFBq352gKEWEa/yRJrOOJtzRRSiirKrafDFGxO/bgfks2hOqWB04YJGT3Tn1Pd8eQoa8+RKt58SmRaDHpsqZJmN9pU8siFk3Fzo0bSiOSEhLkFasJb6TCeWhNtEbI6XVrkRLmGSv7y5zIhgNjGNJaWg/MmdOwx2ZiNCruRT5mHg3OQuSZxwYebsaGKOYsR5Qxd9Bsy6Fg7KTrHRo+xN+gdqT3M5ob766OU2bQW6xQ5A5IBd6Tbw5aMtIN+TGS1LATBr2LdRpwwbrX0bWbcdtP6n2Vyo+ivzPlTsfeR6DIWJyaXh6jf7LL+Skw2RUHcs/agheHME+Fh7+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YnIy26swi5mkVYScwavZaRKKMJsjXE23jkF27eA6gEA=;
 b=q8xX3Mmk0H/PsJ5L91mdtH4415Te5AosIQKYCrjq76CZrBrPJwmh0Nlr2326QWKTGgHFxzy16Hg6PPpzGaIVMg6YPBLuvkGTplL0cZ/MDefORaJyW+w1oL7q4TekFAZgiYLaLlZxLHhHpzjbf5CWzqsRvtb/LYSIXqTAEHErX5WsBqXr6nS2MYz67RNQWNoy3RsgZYdswhhZ86Vl1EJe5D9Kq4SkFP8q5uL19lN35aeVhJ4LL6txADVQDyV9TOz4zJ4eK5uDiXLmI/kpc2mHL1wo0VOew3OExuC94ftwcEKxPIMbUXULfwlgXe84WN9+Vzgbi5EYENc+djMVRgu9Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnIy26swi5mkVYScwavZaRKKMJsjXE23jkF27eA6gEA=;
 b=iWwY3lasiJ/U1UJbw1tF6uM91cD+XAykCHeeCVb9nzLRRGfK/s1tev+eKTDseMr4kMGSZEdFXfhy9bRySikjqOyNXM94zqf9ZlpGodvoSq1vx6pKMdzxADLlET9YhIpdc6AAtVpMzx3J+izd/QMr0zgg/0TG6Y651bI/sVyCMtk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA1PR12MB5671.namprd12.prod.outlook.com (2603:10b6:806:23b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.28; Wed, 16 Apr
 2025 11:35:44 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 11:35:44 +0000
Message-ID: <39266820-2565-42e2-a4b7-53a2705824f7@amd.com>
Date: Wed, 16 Apr 2025 13:35:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: Remove UARTLITE from defconfigs
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Anshul Dalal <anshuld@ti.com>, Fabio Estevam <festevam@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Simon Glass <sjg@chromium.org>,
 Srinivas Goud <srinivas.goud@amd.com>,
 T Karthik Reddy <t.karthik.reddy@xilinx.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <86b100692101089dd8d9a8eed45461e8855384bc.1744270698.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <86b100692101089dd8d9a8eed45461e8855384bc.1744270698.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0063.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::10) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA1PR12MB5671:EE_
X-MS-Office365-Filtering-Correlation-Id: 478a9534-37e9-4f64-c744-08dd7cdad2df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VmVKVnBmRFpOcFRKT0lLQU8rSHhFT0hOVUhMaTdZd01uQ0pvcGdZOHpNU3Fa?=
 =?utf-8?B?dUM4cHRvS2VwR1NIV091QXJicld4T0M2V29CcGVNd3hrdU5ySFl5TTRMdGg3?=
 =?utf-8?B?d204bk9TSTRiR25vaHdVeUZWMXp4Ym9FZEJGY3IvdDZDZmVKd1VzelVmNW0v?=
 =?utf-8?B?M1ZSeGt3T1ZCVnYwTWRuOVZsdXE2MFVIYUYzYjc2TUwwNzF1UFhKUHlDK240?=
 =?utf-8?B?Mkc5VHlJV1RYQllUZzNISE1vQmJIR0FQZVhSTTVNeHRRL2lNMkV1ajlaVFd1?=
 =?utf-8?B?QU10TUE3b3QxOEhOOGpwUHRWY2NrTml5dEk0MmMrOWJjVjVPS1pXdGx1Y1lE?=
 =?utf-8?B?dEYvb3hPZXJTY1pEUXA0Mzk3Z1VTMWRSZjI3VldEaVBURXRINlM0SVIxaTM1?=
 =?utf-8?B?RE9pM3hLMWd4YUEwL2ZTKzRIRVE0TXNpZVlSUE1lS2VDS3RpSnJFUlltWC92?=
 =?utf-8?B?UzJSVjdNZyswK2JveWZXVVlxK1JSVXhsNUhCTklnckU2REFDTGVOZ3FIUmYz?=
 =?utf-8?B?Skx2WGlHR001SXlNRnZ2WlhFaExmNHVUbUhlbWx3MmxlZUhMVlJPaHJua3Ez?=
 =?utf-8?B?eFQvV29xai9tT0Myb3Z4U0NhSURaaVc2bkhnNXZQakV5cDY3VmFaTG1ZbGxn?=
 =?utf-8?B?b1FPYlBMUlpBaWVWMXI0b0RCMExmN3FMYjl6YWdqWHZvZmM0RUFqZEMrRktw?=
 =?utf-8?B?RHFhaUtuNmhLWm9ZZmlHL1lxYnJvVUYvRGpQaWxyN1JSakpiVXJSSndZZ2Rq?=
 =?utf-8?B?L2NiMFZ0a3RjblRDYS9oeUZXTE5KRmNFMVFBVE9VYU5BWDFaWXhxaHlxSTNO?=
 =?utf-8?B?aDlJOEo4a3pHSXMzOGFGb1cvTzJLbjU3ZFYrOGx2WXFxcE9KcUEzd2ZjNGdy?=
 =?utf-8?B?eFgyM3pZSDd5MFNvaXR0S3haUGs5cUtMOHBnTElVc3RUYksvU0hsTnhlTnhv?=
 =?utf-8?B?cStVVWplUllMVzVRZk1KeitEVGE3YVhuYWY5TmFYem1uVFRMVWFudStYbHpO?=
 =?utf-8?B?dVBPNkdDQXkvMDg3dHFDMHlWSy9HNHdjelBrOHE3K0ptQUloYjcwcFRJaUFV?=
 =?utf-8?B?K1VuWGlLOVEyU0Mxc3ZHRDNxdFpPL3pGQ09La2UvMkFScE5pbkZ4blgxc1Zt?=
 =?utf-8?B?cVJ2bFBBcG5nSkhZUWl4UXZ5YVgrUTl5amEwR3poSk9heCtEV2hUWjg1SjRq?=
 =?utf-8?B?eFArQkd1a0xUdWZSei9iVmplOVRpMkZTakpHMjJ4ZnhJMXpwcDM0di8waGhm?=
 =?utf-8?B?M2NQcHdkKzlpV2M4Rm90dW5pQS9wZ1FpRzhsT2gxdTlDaFhEd0p5QnpiMk9n?=
 =?utf-8?B?OFM3RURkbFZkQjR0QlhZTVIva29id0dVRlA2SHpKUjJiK2IzaHdRejdpNlhQ?=
 =?utf-8?B?ck5TZGo4Vk1LSWtDMlRyRVNTUVFPR1d5dlg4dmJWbFB0cmV4b0NvUTNqcWRL?=
 =?utf-8?B?cmc5ZzRINE95WVNXRlA0aGhieVhRRzNISjd4dGJSRkxOTXM1MmdOOFpra0NS?=
 =?utf-8?B?N2FiYzdmVGUzMEx6a2tvVnZ0cTRQak8wdmFXTWl4MVYxK3Axak80bTlnQlNk?=
 =?utf-8?B?dHAwZitaems2T2hOcUJxbFhaeTY1Z25heUdGOE0rSmtQVFFkL3RkRUJuVUJs?=
 =?utf-8?B?cklueC9CQmdyWmQ4bStZdmhQWXVabDZ6RStnRmxtTExqdnFlSEh1YUVyYUUx?=
 =?utf-8?B?dVd4K2plUm41OVpvczFQVm1jcyswdUxkU1Z5NEJHSzdESmJEZXREZDFHeHRC?=
 =?utf-8?B?eVE1MTZtbXJOYTB0ZEZlOTVFcXM2UGMwejc0MzJFOTNzZ0U1dFRuVjBwNUxI?=
 =?utf-8?B?VUxCSm5hMFh2eG82c2pTQVBPYzl0UW1iS3ZBTHNuWnZHcHJ1TGpDWEVkbzFU?=
 =?utf-8?B?ZlBxZSs5MDVmbkVreUVWL1lzK2NHdkQwMWtaSkpMNmp4UzUyaFJVbm5mVEZY?=
 =?utf-8?Q?2Yo014jq39M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUdweXpiVVVZcGdnZlNiS1hmRENrdFIzdEcwK0hJYnlVWXNqcVRHem85WXV5?=
 =?utf-8?B?Q0xCOTR6WkEzMUNDRlJHbk41ZDl2Z2RML29nYnZmcExMaGNRQVFoNmwzMUNP?=
 =?utf-8?B?N2ZieGRTSUQydmhLUmRNb3dOTEVrMW8yWEdzcEkxSmk3UUpHY2RneFcxV1pF?=
 =?utf-8?B?Y2d1TnFueDI4VnZGUWtmeHR4ckxEL1JycnBXOStxOWhhWTFHMm9NbTlGRGFh?=
 =?utf-8?B?VURWWWNFYTJ5cWpuWlFUZ2t1ck1NR0xtM3R5Q2tDTFFaY2ZETDVpdFpVZkFQ?=
 =?utf-8?B?Q1B2WllTSldnZDB6OW9LajFoN3dudzIzRVhVNXI3aHJpbnJXc1V2dTBYY2tt?=
 =?utf-8?B?OUlpNm9pT3dnUFg1ek9lSGRnYkMyK0UwS2tBTHFoL3VMdHJlWFhuNmIvWDdr?=
 =?utf-8?B?T0hwUHBhWUJHR1JCUTRSUk1ra0dJOTlYejFiMmVyZzVvN1R2bVMyamhudDdz?=
 =?utf-8?B?SGZDMU9iRFJIU05aMlpLUTMxeWZwQ2FzR0VvWk1CZHZjc0FIQnowcnMwUUFO?=
 =?utf-8?B?WCtub0FuZU1udUV1RmxSWGdFMTJkZGxyZDdTYjZyVFV2NzJVVXFwUFE3c1VT?=
 =?utf-8?B?akdBWCt2WklkUUN4SFNMVW1TQnNGWkM4SVZORVQwdXV2YnZZcnVMNWZBbEps?=
 =?utf-8?B?OGVwRVRRQnVZZWVOcTNPYjNYdy9Gclljb2JQZk01MjduQUEvRXZuazl6TTc0?=
 =?utf-8?B?OUVLZlUweWQ5bmNqRjZBZDFHdElHSjdUeFZOUGtRS1hQZmQzeXpkc1h2WTJR?=
 =?utf-8?B?ZXJodG1JUjlhNCt0R25ya3NMS1ZTMnBPRk8rcXhRUVk1bW96VHRkRW41UG5m?=
 =?utf-8?B?NlFyczFrMUdmaEIzeFZsUTFGY0NLOWtTbGt5dldVaWt4b2g3NDc0ZEszMFdu?=
 =?utf-8?B?MkdUUHo3OG03SE5WVVNJNW1wVkZoOEpZODJzWVhBRTBWVzZ6a2tXVVlGcnNl?=
 =?utf-8?B?SnU3SUFBc2dxODBxODhiYkJOemVsVHNGNUtCUjViTE4rcGsrUWFBV1VEVkF4?=
 =?utf-8?B?UENYeGhpb2ttWi96NUQzT2dsTWJUZDl1VmdvQmo2Y3dWUlJkNjlmcGlwV0ty?=
 =?utf-8?B?amQ3Z0ZwTm10MjluOFNUOE93cVZlRGowQ2NmUUp6MCsxbVloVmJGL2ZoL2o4?=
 =?utf-8?B?UWpoSjI4U2E3eWdmSWlGaGlta3FUd2hpUWNFUE9iamE1TEVkbGkraVpDc3N3?=
 =?utf-8?B?ZHRiNktYUk5VbkdIUm1SOTVWSk1WaU1BRjh6UDJkbTRLTENabVlWd2UrdGRH?=
 =?utf-8?B?eHJRZEw1Sjk2M0VvZTJNVkllWUF6dEJyM1ZjU2ZieVBTWkJkRkFsbzMrVjJy?=
 =?utf-8?B?MWQ2aWpVcHJiWTRrWmpKK0VLd2ZTYzFVNkZscFRxQWhMVnQvMkdlenN2UU5J?=
 =?utf-8?B?WUFnbWlUQTUwMVU5SXlEaUtkaUo1b2FHY1FaNG1ZbFdKRWdBK2lmcWpyVDF4?=
 =?utf-8?B?U0UreU1PcXd0VGhraDZxQnpmSEM2Ny8wRFJUSU5lUk5MNkVwZXNLeVJYclEr?=
 =?utf-8?B?SWxoQUxTVmdrTVUrMmlDbEtUaCtHK1Z6b1JKQkgyb1Q0ZUtOT2lLMFFPV1Jo?=
 =?utf-8?B?ZTZESEtrUW9kVjJZMStwVnJnbzU5SGVJRUZJeXhtcm04MGFzcnF5VnJ2NTNL?=
 =?utf-8?B?dXh5K2w3N1dxVDNtMFNNYWRDK0NhemlBZmhvSkRzdVh2MTRiN2J1WDBrVmtW?=
 =?utf-8?B?alFzczRqZmp6V0Q1TDdkOThITmYzVjNmb0gyZG9xMDlFQ1lCTjdrNFFUN0dk?=
 =?utf-8?B?eG1oU1FueHhsTk9ZaEloS2tMRUxOdWRRZm44ZXRLaHEzZTBCeUdBUEVPNWFF?=
 =?utf-8?B?a1VOdEFjYXUzaG9jeVovQ3RkNEhseVlLUHhEd1FrcVRraDhUUlV5bjFkQjdv?=
 =?utf-8?B?TkVmTURmNkxFaERLQTBYenNyaFljNUtqNlRFVkkrOFNoTXAvQWNqTU1seGVS?=
 =?utf-8?B?dUpkcVdPbThBL2xLQ05iVW1raVlQSVY5QmExaG9RSVVGYUFydG42Q1J3MnBx?=
 =?utf-8?B?Y3krMTNnSkpoSnNVSlJzckI0SjNOM0F1enA5clBwYkJVekFYbnhERmpWZ2Zk?=
 =?utf-8?B?M1V1cjEvakU1TXM4a0IwM2QxZUtWcjVDamw5SlkzUnc3NkZTSTNRN0RoTEZJ?=
 =?utf-8?Q?JS9SY2MrdaXeTZHGnEUyRPbMu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 478a9534-37e9-4f64-c744-08dd7cdad2df
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 11:35:44.1346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sY4uISyqs4zPnkvbNCNRaXNmIhtTF7ejkbHSE4ILyOlFcP04RaCPnQJiedKTnyTs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5671
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



On 4/10/25 09:38, Michal Simek wrote:
> Remove uartlite serial driver from defconfigs because is not tested or used
> on ARM based platform as console.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   configs/xilinx_versal_net_virt_defconfig | 1 -
>   configs/xilinx_versal_virt_defconfig     | 1 -
>   configs/xilinx_zynqmp_kria_defconfig     | 1 -
>   configs/xilinx_zynqmp_virt_defconfig     | 1 -
>   4 files changed, 4 deletions(-)
> 
> diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
> index 4da31b5c1194..49dc9bb5c4d3 100644
> --- a/configs/xilinx_versal_net_virt_defconfig
> +++ b/configs/xilinx_versal_net_virt_defconfig
> @@ -123,7 +123,6 @@ CONFIG_ZYNQMP_POWER_DOMAIN=y
>   CONFIG_RESET_ZYNQMP=y
>   CONFIG_ARM_DCC=y
>   CONFIG_PL01X_SERIAL=y
> -CONFIG_XILINX_UARTLITE=y
>   CONFIG_SOC_DEVICE=y
>   CONFIG_SOC_XILINX_VERSAL_NET=y
>   CONFIG_SPI=y
> diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
> index baa4b8e412ea..ba4519ce3037 100644
> --- a/configs/xilinx_versal_virt_defconfig
> +++ b/configs/xilinx_versal_virt_defconfig
> @@ -133,7 +133,6 @@ CONFIG_ZYNQMP_POWER_DOMAIN=y
>   CONFIG_RESET_ZYNQMP=y
>   CONFIG_ARM_DCC=y
>   CONFIG_PL01X_SERIAL=y
> -CONFIG_XILINX_UARTLITE=y
>   CONFIG_SOC_XILINX_VERSAL=y
>   CONFIG_SPI=y
>   CONFIG_DM_SPI=y
> diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
> index 16cd8c3921c6..ae79f1017013 100644
> --- a/configs/xilinx_zynqmp_kria_defconfig
> +++ b/configs/xilinx_zynqmp_kria_defconfig
> @@ -187,7 +187,6 @@ CONFIG_DM_RTC=y
>   CONFIG_RTC_ZYNQMP=y
>   CONFIG_SCSI=y
>   CONFIG_ARM_DCC=y
> -CONFIG_XILINX_UARTLITE=y
>   CONFIG_ZYNQ_SERIAL=y
>   CONFIG_SOC_XILINX_ZYNQMP=y
>   CONFIG_SPI=y
> diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
> index abd1e1bb574b..29aa5891b230 100644
> --- a/configs/xilinx_zynqmp_virt_defconfig
> +++ b/configs/xilinx_zynqmp_virt_defconfig
> @@ -199,7 +199,6 @@ CONFIG_RTC_EMULATION=y
>   CONFIG_RTC_ZYNQMP=y
>   CONFIG_SCSI=y
>   CONFIG_ARM_DCC=y
> -CONFIG_XILINX_UARTLITE=y
>   CONFIG_ZYNQ_SERIAL=y
>   CONFIG_SOC_XILINX_ZYNQMP=y
>   CONFIG_SPI=y

Applied.
M
