Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EE0D6C281
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 18:38:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F191892C6;
	Tue, 19 Nov 2024 19:38:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s+G3xdKX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B8588954C; Tue, 19 Nov 2024 19:38:26 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::610])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 768E388E42
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 19:38:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ybwz6ppnEwyL9QgRtM0d4tpHzOoME3/AM2OBvqS5Rpk9QTnKH8i+1k9+hu80XiB4NvrIVvQRnJLUxCp9gsgbKupFCkBoy/Of9KbaU7WLhcQcevzs1IznOtbU4CCEn9T6exWzGHgnYcTTqjOzhSsMT9FHCIIsbXXSv8cvA2k0KVahF1N5X9tP4FEOt9vv8pBjND4sNBjLm53kSIHWves0fQLg/uthDhdU35ny7CcN8KT2a1UtaidGjvgUgJg2uV70qaKFfdpXnajbp5FOfyAYpu/rxAdzEIdeBlesjjGqNaV15EBFzvGvKUh9R8or/8TqIPivvCua/MJemjPG2nPSBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+i4dVtiqR/Fg3CuxtgAVykrLFBBa96fKFAi41tyYP8=;
 b=QHeEMzD+wSzIwAyDbXHFl5Zn2M1TioLeqNhLGxtnn1nlwny9oBlqyMOaRUXRW5BMmM3XXmRKCXVub+m8LKq5cf8sK6fSb3FpiUHdGWK2awqq2DP6iRIpAGcbmnXxr0C039QhX2RMGulMMAw9pQP/TxRxrWx17w1EHigcbhf3FhPqR3A8yHn8C1RMktR2ParqskD/fAzPPFk/LjdRGxN2ZrxjtvhJsD+fupcMCiJvTk3XKGqRIss9SsQOP6K8r9hP35F2cLZI2vN1QySDUJXKCUMicu8jsybHpyT4nv+6Gc1aLDh5YKVaoFAdt/fRNtgnTOP948q2NoIki6uLv/zQwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+i4dVtiqR/Fg3CuxtgAVykrLFBBa96fKFAi41tyYP8=;
 b=s+G3xdKXyXPow/4eMQ+hbw71BsqJca5wezl4NAtvNi7w8fIEGr1Dsmqe0jwxijXk6s3xwPNBYNkwlpx5Hv83SNHI4PDl8/mPgvdTjvHymcPwNRgGgliPhCiNK5SOeHkUZ/7uEIObERtjUY2CGSfK/sNP16QlQFAEZXYuS3QbzqU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH8PR12MB7422.namprd12.prod.outlook.com (2603:10b6:510:22a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 18:38:14 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 18:38:14 +0000
Message-ID: <cae706ea-b4b5-4b35-886e-58896564f777@amd.com>
Date: Tue, 19 Nov 2024 19:38:05 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Michal Simek <michal.simek@amd.com>
Subject: [GIT PULL] xilinx patches for v2025.01-rc3
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0095.eurprd09.prod.outlook.com
 (2603:10a6:803:78::18) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH8PR12MB7422:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e7dd2e2-a8b3-4783-6429-08dd08c95398
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NVExam9RZVJUcERPaUNKc1grci9LalNKQTA3UlVuQmt0eDNWc044ait0b1lo?=
 =?utf-8?B?b2g2MHpZY3NSejFOaTg1L2NCQmd5QVhYSUxzRGxOdlZXcTg0Zms4Q0xxQ0hr?=
 =?utf-8?B?NVBKeG9na0NjYjBKRDVVVDQ5bkl0SnQwdktjdHlYdldQZjJ2L3F1UWtQNW1B?=
 =?utf-8?B?WDVQZytFS1JJK08zMDQ3cnA3bFk0b21FZkFUaU1ydUVZYlRIQ0t2RndFV1BV?=
 =?utf-8?B?WVNVOWN5VVlvTDdKR3pEUGp5OTE1eDhLLzdQSy9vbHZPdzZMSTg1NFJFNW4r?=
 =?utf-8?B?SW5ZZmhaUzlEYmxLckk5d3Q3OXlWdFE4QkVvU1pyams0ZDBaMENNMlRjYUtm?=
 =?utf-8?B?SFVtTHVHU0FmU0o5WkNncFp4RnNMUkFLdFYrZWt6L0xDdDlOUmZCL1RDdWJy?=
 =?utf-8?B?WkZCM2NSUHk2MENjOTd1d21TdTdDMk4vSUtJdDNMR1R5eDBaTUFzaWN3MU1u?=
 =?utf-8?B?VTVKT21HV0ZDNExvRmw3TCtHR25MdkRkV0RRMHI5dFZqcVR0a0VzSzRQUzQr?=
 =?utf-8?B?YTFJRUdvT1RENFRRWWk5b0QwNngxVHdBbGlFY1ZyaWl6eFdyS21uYWRNMkdx?=
 =?utf-8?B?MFpYYUl4V2NRTlRXSVFPZWp6eFUrUXJQVGpHMmp4Rjl6dExUT1JaTjRReVB0?=
 =?utf-8?B?Z3hCdEZ1NERNZXZrc3l5ekxxT3Ezd21ldFk3QmZuQ0NLNEFMYmhtWDNaMWo4?=
 =?utf-8?B?UE1UbEdSem1BZmhGMEJzSlhNQTNHcGRyYjMzbEF4Uk5XSWpjOXpZSVVIZkl5?=
 =?utf-8?B?b0hKb1hJSDZaWFhsZnhuelk5OXNrT0JhckNQVW1ESTFCNUVBdVora3htbm1Y?=
 =?utf-8?B?b2hneTRkSlQ3NFBhQStVS0tldnNPN2ZZdk90UXV2ZUFlSTIyMU81QkhmVXc1?=
 =?utf-8?B?VU5Wb3lIZ21VQnN3R1JKcllIM0NOMVQ3TytTUlFkTUlLV1U3Mk5YOHdIQmli?=
 =?utf-8?B?NUg2bTBHMDI3YlVsQUxhUStBU2hPM09Ja2VqeVZtRU5sVmprdm1zdnFJTzJG?=
 =?utf-8?B?ZDZrQ2JyeEpqNXVGOVA1Z0Z2YlVhSlJ2Vis1N0NFUndOdFFPVkNDbHRsWUd3?=
 =?utf-8?B?RCtwTHJpRFVxNkFXVklLY1hXTndPeTU2UjcvWGJlcktPSStXc2VDOXRrQURq?=
 =?utf-8?B?Vm10ZC80QXM0anZtOVZyYUg4MUd1MXpiQmlWd0hYS0JJQ0w1N3NGdnlEam5Z?=
 =?utf-8?B?VUJienJkYmtSODVxRGpVWnVuQmVxVkhzU0tWb0JkdmNocGF3WFRTRmFqZUlO?=
 =?utf-8?B?QlIxTHgvTDgrK1V0Z2xyeGs2NHV0eXB1VWh4WXJpQStVNG1IMHVPVDNRajZz?=
 =?utf-8?B?c0ZhWmh3TnQwenYyVjZuRFA5NTBDUUpyNHRkcFlQelphaVNUczNkNm13M1NS?=
 =?utf-8?B?Zk9FVWpTaFpKOElhazg3N0dHMXgzR3U1anRGbG5qTERyQkNsdndoOE9IQWRI?=
 =?utf-8?B?SUpKYndPS3N3N1IyWEFHNzVYQTU1SUR0aGpaYUpzRzZMWWxSTUp2N01KK2hV?=
 =?utf-8?B?a1FMaHMxY3B4TTF5UmxnWW1FekJiRWFNZ2ZBcG9xaDBZYmxESjVzbWJCVHBK?=
 =?utf-8?B?Zk82MERLK0tIVG5ldmFTQlljekdseVhJSEwwZ2V1WDdTM2Rtc2hqUmJ5Z1Mv?=
 =?utf-8?B?dERBUUtqNDhab2RQNWdBWkRoTlU1QWdVbHY0dm5PdWV0ampRWUtjb1JYTUpz?=
 =?utf-8?B?Y0RZVk1hS2NZTU8wV08zTUNiLzI3QXB3d2pHcFJTek8yUHRndGZkQzdOYUlM?=
 =?utf-8?Q?MZr61uzrL12NA2Yl2cJqGIQXnZymDxZgMtcAtfB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3N2dk5zUjhlanlnYlRjVXBQVFQycmdGREI0Wm41bDdjZ0Rsb0VNbnAvaytE?=
 =?utf-8?B?VE85ejIxT1J1YXpHNlE5Uk9EaHNrcEtlYXcrSGlSMmh4amZ3SURhd1g5UW16?=
 =?utf-8?B?bTRpaUhtcTc5NitFaGdiRVV2ZzRpMFFGdnRFQ0p0bElsVnd0RmJrOEdGa3Fz?=
 =?utf-8?B?ZVppWE9sWVB2YWs0a1JIOXdTU3lYQzBWdjFGQUhsRUxSd2s0ek9SZ0VKSkJB?=
 =?utf-8?B?bGlSWXZzSm9GWXJNYWc2cXhrY1ZBd0xBZlQzV2d1SkNJMjRrTGZvbzR2TmVY?=
 =?utf-8?B?RVlNOTIzV3MyY0lsZUdKVXBHQUJJYndRRUk3ZVJnUjJLam1DejhoVmFEUUpB?=
 =?utf-8?B?aDBKOWhRVDR5Q29zVDFRcS9RR3hjNUlyeFdsSnc5bkJiYXFtUUdXZ2FqWS8v?=
 =?utf-8?B?YWFxVzhnTVVlQXhSanlBeHc5U21Cbk5yc0dsR2JZQ1RsQXYvK0ZhYUR4VFFB?=
 =?utf-8?B?bnEzaWhROXVoU1E0VWZiVlB5Ky8rNENBaUNxcUZMcXkxRG56Z3NYbmlPcUlr?=
 =?utf-8?B?NU1kLy9nblk2VlRxRnI2am9CdVgvR3NxM0ordDBlZ2R6UmpkaHg4Q201WHRl?=
 =?utf-8?B?SnZSZUJxTW1NclpZNkhaeUh0RGE4RmFWLzdXcVFQOU1SZGRXUWI2Nmx2eDVV?=
 =?utf-8?B?U25neWh3OHBiTWxZUnRwOW9nN0s0cTBnZDVuUXVvNlZsMFRXd3Z5OExXdEVi?=
 =?utf-8?B?L1VPeW0wT1pNQkhvU2VIVEYxbVYzK2Frd2tpdTN6UWpMRzkwNW5OSWdQYnJQ?=
 =?utf-8?B?SW16NEVobW1jc0gyems4M1RDaVVCMktEVStLdm9sc0VrbG5Qdy93NldtVTl0?=
 =?utf-8?B?a2pnclpGL1NwY0lJcy9tWnpJc3d6QVJXNlRnUXBnRm9yclQwcy9MTERKYXFU?=
 =?utf-8?B?QWJLWGFZQk1IbjhaSXdJc0M2NExQTmJvWGY2WGpyYVRNblRka1JyazF1MjJK?=
 =?utf-8?B?WEgycGQyZ3RXems5THN1R1pKT1dpajZQS1NydTl3YzdwVzdpM3g1a1hOY1VE?=
 =?utf-8?B?T25URTNuMUlDY09WcDhLRVBoNFV3UVdYZVJnbFlNZVpwcmVHQ3RhK3FnZ0lQ?=
 =?utf-8?B?cFFtYjQyUXdMMUplUVFBYTZ6a0l3R2QwdXVDckQ5QXkyMVIwTHhYaDEwOVpj?=
 =?utf-8?B?L2VoUDgxcG5XdjROa29Zc0g5YzBoZm1ycFpWdmcyUlkxSnpFaFdkOTRZblJj?=
 =?utf-8?B?K3JTQ0k0M2FhL3RpSVE2MkM5cy9pYUdOQllGeVRyM3VBWVBmTndtc1RNa2M4?=
 =?utf-8?B?dFBMaGVNQk8wdnBiT2pvUFZTWTVHRUZNOG9GdXN0WGg2K29GQTR1bmh1MkxG?=
 =?utf-8?B?Tzg3ZzAwN0pEekFHU3VubFdmang5K3dzY0dyRXBtNXJxZDJvOE1qODEvczIx?=
 =?utf-8?B?QzRrMEpUTDg0NS9YSGxhTnJuKzl4RHJMbmxGMEN2MXoyclF2Y1lwVVcrZnRn?=
 =?utf-8?B?UUsvSUFkSDBhVHFvaTJka3pZTG8yanlkaHdQbXBDbVZZK3RxVlpzYjdxV0hE?=
 =?utf-8?B?T00vZzJnaWp5YXMyNlNnQy9ZMlBRM0s4WVliMW9YSWtNb29aZ01Gd2Naa3dQ?=
 =?utf-8?B?VEU4OHJqN0NkOXpzTW9QVnJaUTRvWm54U1lmbWNxb2dMOUVKY2JzMjFrSU1u?=
 =?utf-8?B?cEp4MHk4Z0pjV3lSbUdxdnVrMFIvZjYzakpkaWI1MG0zUWE0M2ZWckRkTytt?=
 =?utf-8?B?OWVNRXdYQWp5YUgyNjhaZDYzOFlqdGpEYXlUN3NJK21RTTd2dGtRNUp3TENM?=
 =?utf-8?B?Q3lxNWpKdC9COExGeHlEeDVhY0xKdStJSFdJRmZyTW1JM0E3dnZzVGJ6eUp3?=
 =?utf-8?B?c3JsUkRwZWtVK0JqelA4bDRkTVZ3ZFlsL2krb2RZbTd1Q3lrU1ZVTmJKV1Np?=
 =?utf-8?B?ZUxCRUsxejkyWUNwWi9SNzVOY3JGQUJLVlR6cEFac1ZBVUZ3ZU15U2hPb3Ar?=
 =?utf-8?B?cU10dDV0aW1PNk4yOGFnRU1mYlhkWkhhODZ2OElVeHQ4TnN3aitTWkF5UkdM?=
 =?utf-8?B?c3JpeEptNlNPQVVwZVR0U0NhaWV6ZEZQdml5ZHp6U3J4OFVyemZySnBnQUho?=
 =?utf-8?B?VHdUTUNnSVhqbVM2NEc0aUtLbjJOekYxZ2MyOTd6MFNCdHBTdGc5TzRrdW0v?=
 =?utf-8?Q?j+c2Axawh0+cLs6UCgrCrrhlT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e7dd2e2-a8b3-4783-6429-08dd08c95398
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 18:38:14.1445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KXlPZ15v4y18oTJ6z/PFq5vIoUszKptnivG3ZORn+iphXa6uhiULPSATsg9vdY2U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7422
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

Hi Tom,

please pull these patches to your tree. Crucial part is Sughosh series which is 
fixing issue on SOM where current code is ignoring reserved location at the end 
of low DDR and u-boot is using for itself instead of ignoring it completely.
In past this functionality depended on LMB which could be also possible to use 
in this case but it is cleaner to make dependent on new Kconfig XILINX_MINI symbol.
RTC fixes for SOM also preventing RTC drift on Linux where emulated RTC is 
replaced by physical one and started as the part of boot sequence.

The rest of the patches should be easy going and I will send another pull 
request for binman support to next.

There is one pending issue which I am discussing with Sughosh related to
commit eb052cbb896f ("lmb: add and reserve memory above ram_top") which may end 
up in another patch to fix logic around ram_top calculation in board file but 
better to apply current patch and fix it if we find a proper solution.

Thanks,
Michal

The following changes since commit cca05617a8f585f3a98a8fa82f75cc68a530d771:

   Prepare v2025.01-rc2 (2024-11-11 10:07:36 -0600)

are available in the Git repository at:

   git@source.denx.de:u-boot/custodians/u-boot-microblaze.git 
tags/xilinx-for-v2025.01-rc3-v2

for you to fetch changes up to 383fc2f50166fded0571d41baa7826eaaa5dba97:

   xilinx: Introduce XILINX_MINI configuration (2024-11-19 15:57:56 +0100)

----------------------------------------------------------------
AMD/Xilinx changes for v2025.01-rc3

microblaze:
- Disable JFFS2

fpga:
- pass compatible flag to fpga_load()

zynqmp:
- SOM RTC fix
- SC(system controller) PMW polarity fix
- Fix ram_top calculation with introducing XILINX_MINI
- Fix RPU release command

versal:
- Enable capsule update
- Enable soft reset and Micron octal flashes

xilinx:
- Align Kconfig regarding SPI_STACKED_PARALLEL

bootcount:
- Add new zynqmp driver

----------------------------------------------------------------
Michal Simek (7):
       arm64: zynqmp: Configure SoC RTC on SOM
       arm64: xilinx: Rename SPI_ADVANCE to SPI_STACKED_PARALLEL
       arm64: versal: Do not define do_reset() if sysreset is enabled
       arm64: versal: Enable capsule update (SD)
       arm64: zynqmp: Set default RTC device at start
       microblaze: Disable JFFS2 support
       xilinx: Introduce XILINX_MINI configuration

Padmarao Begari (1):
       arm64: zynqmp: Fix r5 mode for cpu release command

Peter Korsgaard (1):
       boot/image-board.c: boot_get_fpga(): pass compatible flag to fpga_load()

Saeed Nowshadi (1):
       arm64: zynqmp: Fix pwm-fan polarity

Sughosh Ganu (2):
       common: memtop: add logic to detect ram_top
       xilinx: use get_mem_top() to compute ram_top

Vasileios Amoiridis (1):
       drivers: bootcount: Add ZynqMP specific bootcount support

Venkatesh Yadav Abbarapu (3):
       spi: cadence_qspi: Fix OSPI boot issue
       arm64: versal: Enable defconfig for Micron octal flashes
       arm64: versal: Enable soft reset support for xspi flashes

  MAINTAINERS                                      |   1 +
  arch/arm/dts/zynqmp-sc-revB.dts                  |   4 +-
  arch/arm/dts/zynqmp-sm-k26-revA.dts              |   1 +
  arch/arm/mach-zynqmp/include/mach/hardware.h     |   2 +
  arch/arm/mach-zynqmp/mp.c                        |   4 +-
  board/xilinx/Kconfig                             |   9 ++
  board/xilinx/common/board.c                      |  29 ++++
  board/xilinx/versal/board.c                      |  43 +++++
  board/xilinx/zynqmp/zynqmp_kria.env              |   1 +
  boot/image-board.c                               |  16 +-
  common/Makefile                                  |   1 +
  common/memtop.c                                  | 171 ++++++++++++++++++++
  configs/amd_versal2_mini_defconfig               |   1 +
  configs/amd_versal2_mini_emmc_defconfig          |   1 +
  configs/amd_versal2_mini_ospi_defconfig          |   1 +
  configs/amd_versal2_mini_qspi_defconfig          |   1 +
  configs/microblaze-generic_defconfig             |   1 -
  configs/xilinx_versal_mini_defconfig             |   1 +
  configs/xilinx_versal_mini_emmc0_defconfig       |   1 +
  configs/xilinx_versal_mini_emmc1_defconfig       |   1 +
  configs/xilinx_versal_mini_ospi_defconfig        |   1 +
  configs/xilinx_versal_mini_qspi_defconfig        |   1 +
  configs/xilinx_versal_net_mini_defconfig         |   1 +
  configs/xilinx_versal_net_mini_emmc_defconfig    |   1 +
  configs/xilinx_versal_net_mini_ospi_defconfig    |   1 +
  configs/xilinx_versal_net_mini_qspi_defconfig    |   1 +
  configs/xilinx_versal_net_virt_defconfig         |   2 +-
  configs/xilinx_versal_virt_defconfig             |  13 +-
  configs/xilinx_zynq_virt_defconfig               |   2 +-
  configs/xilinx_zynqmp_kria_defconfig             |   1 -
  configs/xilinx_zynqmp_mini_defconfig             |   1 +
  configs/xilinx_zynqmp_mini_emmc0_defconfig       |   1 +
  configs/xilinx_zynqmp_mini_emmc1_defconfig       |   1 +
  configs/xilinx_zynqmp_mini_nand_defconfig        |   1 +
  configs/xilinx_zynqmp_mini_nand_single_defconfig |   1 +
  configs/xilinx_zynqmp_mini_qspi_defconfig        |   1 +
  configs/xilinx_zynqmp_virt_defconfig             |   2 +-
  drivers/bootcount/Kconfig                        |   7 +
  drivers/bootcount/Makefile                       |   1 +
  drivers/bootcount/bootcount_zynqmp.c             |  47 ++++++
  drivers/spi/cadence_qspi.c                       |   7 -
  include/configs/microblaze-generic.h             |   2 +-
  include/memtop.h                                 |  22 +++
  43 files changed, 387 insertions(+), 21 deletions(-)
  create mode 100644 common/memtop.c
  create mode 100644 drivers/bootcount/bootcount_zynqmp.c
  create mode 100644 include/memtop.h
