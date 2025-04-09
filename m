Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F761C36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 07:14:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5160482998;
	Wed,  9 Apr 2025 09:14:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="bBGfwPPa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FAF8829CD; Wed,  9 Apr 2025 09:14:32 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20707.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::707])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34D538283E
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 09:14:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kiJi921BG2QItiHK7IIUOdNY5XEsGE6EHwSY9Ub9SoJ0tncZgj/Q0FbePRCm39ILo+bl+ZhY5xS8vQJHJ7GJimlYyVHKqAkwvOfrduzqkc5ANZas3YLhDm+7Jd60Xxjp3Y4CRyp1UTszsKBixz0CiaHTyvi1R0kdhv7KreTWvyslKf/VhMQaKBB07JpSLHkESYjrEsYp/DfLtSZJvwgf5SwjQPF8By4TAOpGi4tqZozrKTb8sG1/EDiJhvrqPqrDoIOhKeHiqpNgjGeK5SbHK98azYtGQM7miauGT1BJzCS4UcJ5tDC7xoDZd1R9Mrk1lMMF84dsj2TdOH6RKVViSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54PaxH2Kll8VQbFSMxqf7rveiaUdWnFQrZDHmFLr9f0=;
 b=FDGMktQL8+YUkysKKTC0YHpqpcODYqb/N9Pcn8Z+LR08ui+ktqtp6Zb7XhK+sn9M9vmt/eQ6IvjhTcTRkk/7oI+ns9ljZ1eC00/4ttLJnmdaIbJOTlPeGPLodt/nkh7HeKIr2/zCo9atvZhDDnjip02bPgSK4zB7VI121jrGFfStELBmRns8tnDbgoP7J4KpShFolDS6ciONXTKczOtnm7USqgFB5F48JDlAe98661CSD3wu0cPTq73lFcFXKZA4BcSZlio02/bEwrYm/TX7tmkMcj2bGDAS7vY+FOZNUHkZu+06VNIXjdHdnV83eVbryMKXS5PDhu49usiCFzOJFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54PaxH2Kll8VQbFSMxqf7rveiaUdWnFQrZDHmFLr9f0=;
 b=bBGfwPPa6XBpovrNp0JELemyY6CxOW1ntaIZX40bZW1Xs228Ja4SU3y0qlpKyB5KD9sXcG5MOgbg09nRlm8DeBQ8ZRXhJXigFn+C+2h0k5ygqIiFUJXFn3qwOOIS82/ik3o2Aj1rzeLFsIoqOoD/SOIQT6DHEVvCyf/kL3Adc8j9/s1EB6IZYE9DH1y2ZeOeawWDmtqRiBrBEw5jmmKrIRAXh7OSO8+ybvybIx0/1rjgdmPu5GvNEW3Cpv59/EWH6z7m84n8UbioQD+6PcwJb0encuUFw7ciY4R+3U2nBMpHDUuD2V/5aiZmjxRLO+TxvjdDV/H0HctYRbhT2D1nNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from VI0P195MB2484.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:248::6)
 by DU4P195MB2593.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:563::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.46; Wed, 9 Apr
 2025 07:14:27 +0000
Received: from VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
 ([fe80::24f:8371:2871:5981]) by VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
 ([fe80::24f:8371:2871:5981%4]) with mapi id 15.20.8632.021; Wed, 9 Apr 2025
 07:14:27 +0000
Message-ID: <013931f2-281d-4aaf-9dae-a620dcde1623@phytec.de>
Date: Wed, 9 Apr 2025 09:14:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mach-k3: common_fdt: Fix Label Issue
To: Neha Malcom Francis <n-francis@ti.com>, "Kumar, Udit" <u-kumar1@ti.com>,
 trini@konsulko.com, bb@ti.com, afd@ti.com, u-boot@lists.denx.de
Cc: upstream@lists.phytec.de, w.egorov@phytec.de
References: <20250407060711.3160366-1-d.schultz@phytec.de>
 <92ee150b-1873-4856-a3cb-8e9d6af78c33@ti.com>
 <80256fa7-0903-4d89-a5cc-b521283cd17a@ti.com>
Content-Language: en-US
From: Daniel Schultz <d.schultz@phytec.de>
In-Reply-To: <80256fa7-0903-4d89-a5cc-b521283cd17a@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR16CA0065.namprd16.prod.outlook.com
 (2603:10b6:907:1::42) To VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:248::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0P195MB2484:EE_|DU4P195MB2593:EE_
X-MS-Office365-Filtering-Correlation-Id: 709d43ec-0294-4f85-930d-08dd77362a32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|10070799003|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aXVVWFdmY01hOUo0amhRdCtTa0dNb3VSVk1VOVVVV0Q2UHZ1RDRIRWFwaENH?=
 =?utf-8?B?K1FNYXZ0a3NvVjhEOWNZMXpLRXkzSGtSS1R4WWpRMVhKeHZqai9ZQUg0TG90?=
 =?utf-8?B?OThBWFdEMFlRbG52Q3ZGM290cDFmUTR1cGNjRm50cU91T01RWW44YmI4Rmly?=
 =?utf-8?B?WHlQMytXajd4NUtqNFNSQTkzM3ZyUFZiRjdSd2FXS21NVXcxamJ4c2RNY2xl?=
 =?utf-8?B?UWJyZm9BcHpHQU84MmxiTEFrSCsrRXFIUEZiakxxWE1ZRlJKZFd5a2ljaDl0?=
 =?utf-8?B?M3owbUNzN3l4Y2dVbTNJYjBBek9lcHZUWEFDWVFpQkdzV3hZQVo0Ykl0NENl?=
 =?utf-8?B?WEowV3BHdjhaTlR6WlltcUJrOG5uYlZnc0pNRkttei9nL0V6T1pGODl0ckZ4?=
 =?utf-8?B?VkM4TC9Wblhicncya3RuVDZKVXBnNGh4SzZ0TFJva0IydU9KdE1tTTJoaTJv?=
 =?utf-8?B?UGp2UHBiSkJLNzNnOHkzTVk3NHdkaGg0STNIWWVIeHl5ZkdaM3grQ05lN1kv?=
 =?utf-8?B?VlFacWJHMGpSRk1SOUF1dkVDcTFtQ0Z1OTNQdW8xV0ZwZDhOZ3JlaG5ZMU1m?=
 =?utf-8?B?ak5MWi9namJaT1N5K3dibEUvV2Q1SHZ1ZExzRU1VQWdMY3RISmt6MTJaMC8v?=
 =?utf-8?B?OEErS1BvUWxtOS9nOVI1TE9PSDdqMWFZYldUZHZDMUQyUGNkUzZaN05icXFj?=
 =?utf-8?B?UGNiMER0dmRKTW5HelZnODhiUzFPY1dWL3dERm9Wb0g2NFBjY2pJUkpZYzh5?=
 =?utf-8?B?MUFacXgzcHUvUjM3Rm1jc2VGc3Y5R1ZEdWhyUFJNWnYxOWYrWTNTWm1Ed2Fx?=
 =?utf-8?B?QllKVGxiTUs2dDdvbkFrbVlLTlVIZU85dCtDTkN4dzR4WlJGMVhUVmtWQTZV?=
 =?utf-8?B?NW9IYUJkT1VIWlcwSC9kblFWSjUrcUJSL2V3Y0pMSXd2N2NvTHhoMDlhVVl1?=
 =?utf-8?B?Rlc3am1UTWJCKzZaWndDTzV4Q3RSdjBPd0ptck9RSjJqcThBZmxPUjkyV292?=
 =?utf-8?B?OExWbTBBdkdQRzlOMitnTk0zRkpwbXhUeW41SWY4NTZiblROM0pWVEx2TSs5?=
 =?utf-8?B?OEhHT3RFd3NVRmttRW5VWWRaTU5TM0p3UGlrYTF3Si9VMHNpUkFpTndrOXo1?=
 =?utf-8?B?bytRNXlyK3Nkam5aQUJhRlZCVHNlaEJadFhRWFFMSWdIZmdvMFAvMGJKQlo5?=
 =?utf-8?B?d1lIVDd6OE9yRXV1Y3l5NHJ1dVFETmxkUUxjSUc3UXR0bGFvMHF0YUNUTUxl?=
 =?utf-8?B?U29TNXk3c0E0REkrUjdyOHYwMGcySWVwZFNpZGZXRUhhdmlNUXlPam9QY2RV?=
 =?utf-8?B?UmtBdksvREttd1ZFRk1oQkdaQitMeHV1alVXZ21SR1lLRURyblh4WHUxZXl1?=
 =?utf-8?B?Rmo5b25LVzAwZldHclZ4a2xSdFhBc1pZNkdvalo4QkNocVpSNnlPb2VBSDVl?=
 =?utf-8?B?VWdFczZGTTdRMnFrbmo3RVJzUHBmUGJPN0ZDd3NZMXREV1ZDTDg0ckowdVAw?=
 =?utf-8?B?NlBnVnZQNk8veGlrRkgxQm1wKzc0RjNWVXExbHRoZTJOUDlSa0FZOTNSSWtN?=
 =?utf-8?B?YXpMeGdTbHNrSFhmbFkyYlB6cm8yVG13ZkdDcXdISUJwaVV2UEpsMzgxcHJh?=
 =?utf-8?B?ZU52RTZ2c2ROMEZYY1BDK1pVNHNUU2lvMXhlOGZNdXJUek1qLzRDbHlzZmxa?=
 =?utf-8?B?UHFVSitWVHB3V1BCSG5ZZkh6WThNMjJhNmY1cmVKLzJudlJnRlFnZVkzc3Nz?=
 =?utf-8?B?a01TQVEyVUdYOGFlaU9SeDJjWnQxNmtsaE9xak1lY2hYMEUrV1J1eGpmVHJt?=
 =?utf-8?B?OHhRNW5PbWk3SXVMMGdQNDZnWjdzRXJHNExia3FzYWEvV1ZvZzFhR3JsOTRZ?=
 =?utf-8?B?Q2ZQVHRmNkJ6NHBTTjdOYkZ1TkNiYXQ5Nm03OEhscExROHRFUzkyQVBJM1Jv?=
 =?utf-8?Q?+pmOAFyL65c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0P195MB2484.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFkvamdpY1VDZW54OTFPY2hReG1RUzJrL3VlSDRobHZCZXE1Y2JFbVY3eUc1?=
 =?utf-8?B?aFM4WlN2dHRtQzYyTjU5R2M4NWJUU2FBSEJMOGhZelgvdDJ2TG9YbW1XSWRs?=
 =?utf-8?B?ME5lMDIxcHE1QWU0aTZpR2MzRjlzQ3p3TmEwZnN3eUxoNnlhR2V2OFdmRUdw?=
 =?utf-8?B?UWtJd1pSaVFLNnp4dmlLdmEyVFBseW5qMEFzVU14U3J3MDBrTTJPUEtNbFl4?=
 =?utf-8?B?Unp3WUcrd25WUW5Ia09wZWk2d1hUSFpzUjJtOGpIT0VwZ0VjcEphemg4c05y?=
 =?utf-8?B?NFN5bFlrZDFNRVFwQWp6amFBY3ExbGthMXY0ckZtQjhFbTB6cCtTdVlyZVpZ?=
 =?utf-8?B?dCtLcVBmcVY2bHJxREcyZVUxN3VlUTQ3WGFvQVkwbFhyZU9DaStGVk5XTzAz?=
 =?utf-8?B?Uldldlo2aUhKY1RicFBEMWVEOFQ3MitEMFpFYWwzNFo0NGtsSWNHSWtDWHpl?=
 =?utf-8?B?Ukh0dnRtaGwyTHBMbExaWnJGUDFDcktoWXJhb2Q3Qmx2Zll2MmFsakNabkxr?=
 =?utf-8?B?ZzZsNlpBSUpNOXowSnNzVWVVQjV1MXp3TERqMUFWR2ZsUGk2M25uMDA2RHFq?=
 =?utf-8?B?aThGTjd5TnBjNlc3dmNMVVN0NWR3WkRSWVNFVk9BTnRvcmFLbWdaRzdpZzhm?=
 =?utf-8?B?cEVoUHZyMy9waS91UGRjTmQ5UFhpM0JrekIyc21HcUh3ampEdVpRbnIzWi9K?=
 =?utf-8?B?dmQvZVRwSlErckZPQXd2VDBOakpPSFQwS1FNaU5meXVWUVFJM2hmaXpUazQ3?=
 =?utf-8?B?Mzhna2EwYWczaEc4Z2oyN1lkTWtrMHRyenhDaWxaZkNDNEV6RnBzNUpuSHlq?=
 =?utf-8?B?MndxMUtXd2NtRERLam5hbFFJSUJxNmlpSDU3UUNUajBhSGdJbG9VYVkvVS96?=
 =?utf-8?B?REM3SW9Db1VkcE1OSXZwVE5ZOFRwY1JVbC9sYkdmMVVkbGR2TDFTeUl1VC9Y?=
 =?utf-8?B?emI2blpXNUtQM2lsb21jaFZ3Ym1iYjZtaVVQTGhEcU9Wclh2VHdGQ2l6Q3U0?=
 =?utf-8?B?M3hPLzQvc3BWcENpVGorL25IbUk1OHg2ZzhOOHQ3VXRkV1JpaTNYRGFkaDJn?=
 =?utf-8?B?TDE1dHJMYy8zaWxVRU8zM1RicUt6cnY4TC82dE5lTmZSalBqN1o0bUN1Z2tN?=
 =?utf-8?B?aXVybHVyKzJKVWtCWHN4K2x2K1kwOXM5WUkxOGZ0R2YzU3k2eDA4S0hJNXhu?=
 =?utf-8?B?c2tzSFhFNFBsVDVGSUdRMGJJWXJtazMrUXBYcHRMd0J2a1pxQUZTSDZjWFNQ?=
 =?utf-8?B?eTJUUStOZ1NMQ3Q4Z2cwUXd0aE9JNjE1WTdWQUw1blpYamdvNExuWnRvQzBK?=
 =?utf-8?B?bWdvTmVCV2srYUF1a0xTTWUxSXNkQ1hwMUtldDdFYUk1S1R6UThnWWU4Z3Ux?=
 =?utf-8?B?c3k2amZ2RjN5QUZlbG5wOUkrSmkycmRTYVc5bGZFVmppSHZ0S0tkeS9SRkUy?=
 =?utf-8?B?ME5WbGhJS3FWSFBSYkc0VmJtemlkekU1SkxRYmdIWEtlbG41aE0xTks5NFh0?=
 =?utf-8?B?Ujd3a2VCRTNMNHdXa2k2MEFYOVBwMjg4SEF3Q01FU1FpcXJNM2l3ZHJVcWlz?=
 =?utf-8?B?QUFYWlYxVnc4YVV4Tyt3eFFUSnZFbEtDeTh6SlI2ak53dkt1VTdudW5UcC9T?=
 =?utf-8?B?bE1rMVVLdVc4dHQwT0paTDlxWFFZdUxqUy95QWJJbWJKTlJROG1HbWE4NlFY?=
 =?utf-8?B?a3RXdTRZS1dwdllWTUREWTBZZ1UzS3ZDd3J0aHduZFBPMHJCY0d1OGNwZmxj?=
 =?utf-8?B?ZFJYZ3QxbURtaEV3VUdLNTdLdGJmbXJOdHBVVFo0M01JM0x3d3FRUWcvZlVP?=
 =?utf-8?B?SXMvT2s0Qk5HYm4weG9vLytvK2E4Sm9tdnBpNVJlNkdMOUZvQmt0N0lVWFRC?=
 =?utf-8?B?dlQ4V3J6N2JFZ096a28xd0xnK3RpaHAyWEtBQlVCMSswRjh2SEIycXZiZHlG?=
 =?utf-8?B?NE55MTVvWjZqaVRvTlBNeFIvS1FkOHFDTlI3V2tKSkdvTkFKcDBMb08rWUxH?=
 =?utf-8?B?bi9GNTlwVk0zYzc4RU1KaFpnRHdlRG1KN2VOMEZNcVB4Tmt4K2xXbmxLMDlN?=
 =?utf-8?B?c29tcDMyVXJwWHFGVVA4Q2lySk00ZEhoTmZzeUQvY1ZSUGdIQlYrVVcyYzI4?=
 =?utf-8?B?UlhHSzJTd2VQWkJuOHQ3NGNpMFlXc09wVkkxbjFEaFlkS0YvMUNaQzlsenp3?=
 =?utf-8?Q?ojUV5g7faio71fe0nhuZ5uE6RKqW1w8XwoHj6YcpvYeu?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 709d43ec-0294-4f85-930d-08dd77362a32
X-MS-Exchange-CrossTenant-AuthSource: VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 07:14:27.8026 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2lkasK9hrUZjDwZuNia/DUhCRyK6T8afhTKgHuHSbnCLi5ETgi1RrRSaQ2QlUDvl4IFXikrVGa6hqTMGojrvoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4P195MB2593
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


On 4/7/25 10:26, Neha Malcom Francis wrote:
> Hi Udit
>
> On 07/04/25 13:51, Kumar, Udit wrote:
>> Hi Daniel.
>>
>> Thanks for patch
>>
>> On 4/7/2025 11:37 AM, Daniel Schultz wrote:
>>> Labels are not allowed before declarations. Add a semicolon after the
>>> label to introduce an empty statement. This will fix following error:
>>>
>>> arch/arm/mach-k3/common_fdt.c: In function 'fdt_fixup_reserved':
>>> arch/arm/mach-k3/common_fdt.c:156:2: error: a label can only be part
>>> of a statement and a declaration is not a statement
>>>     156 |  struct fdt_memory carveout = {
>>>         |  ^~~~~~
>>> make[1]: *** [scripts/Makefile.build:256:
>>> arch/arm/mach-k3/common_fdt.o] Error 1
>>> make: *** [Makefile:1919: arch/arm/mach-k3] Error 2
>> Is there some specific compiler option you are using, Sorry but I don't
>> see this error .
>>
>> i just build sha id e458e103d4f5fb7aaf13e744c65916ab3ba4a18d of next
>>
> I had run into the same issue when I was using v10.1 of the Arm GNU
> toolchain, moving to v14.2, I no longer see it.

I'm currently using "aarch64-linux-gnu-gcc (Ubuntu 
9.4.0-1ubuntu1~20.04.2) 9.4.0" with just make.

>
>>> Fixes: 096aa229a9e ("mach-k3: common_fdt: create a reserved memory node")
>>>
>>> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
>>> ---
>>>
>>> I'm open to other suggestions! This is just the easiest way to fix this
>>> compile error. BTW, master is fine since 096aa229a9e is only on next.
>>>
>>>    arch/arm/mach-k3/common_fdt.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/mach-k3/common_fdt.c
>>> b/arch/arm/mach-k3/common_fdt.c
>>> index 361b0c0b31b..7178918a12c 100644
>>> --- a/arch/arm/mach-k3/common_fdt.c
>>> +++ b/arch/arm/mach-k3/common_fdt.c
>>> @@ -152,7 +152,7 @@ int fdt_fixup_reserved(void *blob, const char *name,
>>>            }
>>>        }
>>>    -add_carveout:
>>> +add_carveout: ;
>>>        struct fdt_memory carveout = {
>>>            .start = new_address,
>>>            .end = new_address + new_size - 1,
>> My suggestion will be to move this struct at start of function.
>>
>> and change only size here
>>
>> carveout.end = new_address + new_size - 1;

sounds good.

- Daniel

>>
>>
