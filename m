Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE8BC83F26
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 07:04:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E8DA832FE;
	Thu, 24 Jul 2025 09:04:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gr6HgAZ5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90AC98360D; Thu, 24 Jul 2025 09:04:31 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::60a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3918383297
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 09:04:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G+6CQUD294NT1jn9DXx6hFqZZZU8n/SG7XpnDWjk7vNJr0l1GMcm6oMn1mFg2i4aUk1ZAslpuQKwYmnuL+cIQc4z3e/mqoi5cxYqXNaFrtZFZQWzRylpj3buGTbw8CyXmmsUdYTPPhCUq0Uk8bWEL78X5LQ/pWhAequ8aD/JaJnTgxF21Y/R8Xqz63tAMsONO0AVapaJK6mgCk/NqpyUI5YIfKbmi0rP7GzVR8NDvNzQSpSPaM1eKrESky1lz4cGoBwGOh/uQi2xyWiJD2l+wMclX/iXMMZLRVrmAxHsx5snEByGQHe/sLHHR0lE+rSM/0ColVZs7/79FgOF7UX7pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lrbg9SlnScsCTGm8iFyHj9g4/SfSFhTb9dbSxeGRmaU=;
 b=uFVi+Kh7SCQHhsimxoTKSaAKPiIgOqpPzoS3szdDzsg6CAMWTUCEaP1JQ6GIUKDL80VJSuC4D+blgvLgh7I5Xh6m3NyU46ZbdtiuIw+O2yXqSGkaMgiEkBh53YJgZ0jpbgeJxk7Ol0xBWD7G2fSaQfowsijxL+dNTIfT3R3408I/HYBRzSIFdGGm7sfgJWMhtTQ4Jo0qqiStBHkwB0TQScom/6nFrcDk2wbgv82xBqs3ZF3q4QQBFdxvfGvRBC3shCvhTVXSpB71Ce2HPxeZ+xwxmW0VvTKfO5y/f6Aim0sMkftdR4lWcaAQrxbQM6QZ/eLNrH9OPmWMrJFcHvLE1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lrbg9SlnScsCTGm8iFyHj9g4/SfSFhTb9dbSxeGRmaU=;
 b=gr6HgAZ5Gt48heDidQ7yIyMPNOqKffLMMq9urjH83vFm7iriIlv6gq7IYUwO4kZa/g0md5V7Y5tk8W/1T+qvZ1hX7pjvKy0Wz1WSu7iaMpyRF86FRENxkGAM+oMqdZZvs0mL5gKX3/a9tGOlLlKSJQ1Y2Q/X9zga4j4YTJJgH/k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS2PR12MB9661.namprd12.prod.outlook.com (2603:10b6:8:27b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 07:04:26 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8943.029; Thu, 24 Jul 2025
 07:04:26 +0000
Message-ID: <4e30e9ba-7d7e-4725-9c17-ed3ba06e9a15@amd.com>
Date: Thu, 24 Jul 2025 09:04:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "spi: cadence_qspi: Fix odd byte write issue in
 STIG mode"
To: Prasanth Babu Mantena <p-mantena@ti.com>, trini@konsulko.com,
 sjg@chromium.org, alpernebiyasak@gmail.com
Cc: u-boot@lists.denx.de, venkatesh.abbarapu@amd.com, vigneshr@ti.com,
 u-kumar1@ti.com, n-francis@ti.com, vaishnav.a@ti.com, s-k6@ti.com
References: <20250716070407.2082524-1-p-mantena@ti.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250716070407.2082524-1-p-mantena@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::8) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS2PR12MB9661:EE_
X-MS-Office365-Filtering-Correlation-Id: 812374ed-0394-4baf-a483-08ddca805332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGhWd2JXRjZhVnlUSHh5YWRReWpoV21CemtsbG5EV0d1ZURsMFNJN0tVbDVz?=
 =?utf-8?B?alFTTmU3NHlDQm0zcDZhWWtmOW9pQ1VCTHJDNms0RWYyaHFIaUl6R0pIdDdU?=
 =?utf-8?B?K1RpczNJVUMvMlo0Vm9leTVsSWlaMktuYVlrdWJOVC83Y1F2WHdoT2JrMjVZ?=
 =?utf-8?B?S3BGdWJZL3ZCa1ZuZWlSVzUwVzY0V1h5OVc4WXFJYVB1R0FJYzVzNnFNZWVa?=
 =?utf-8?B?TGsxTlIxMnVETjZSZTVndUJzLzU3TjM1YWFFLzc3UmMyQ1dMWWI4UFI4Z054?=
 =?utf-8?B?eXZMK3RYdU5rWHdSRE9uT1hIc2pqbDFiMVFtMW1IaWV5S0dMWmhVOG10VHkr?=
 =?utf-8?B?NG92d1hibldnYzBDNWwxQWg2TG84NjMwNGpJYjg3ZUE0MDhpRFNmMlpGZUlq?=
 =?utf-8?B?SU1BcDJ4Uno4SGNLbnl3dlI1cHVtZHJKbWVtNWhad0Q4N1h5NzBENEFPMVBN?=
 =?utf-8?B?UlNvL0I1YllTeGxmNzBrZkUvNjQ1VzM0VTBmRy95RDF4bHp3SjhmSkVnL2FN?=
 =?utf-8?B?STZzaUhOQmxxUVkwNThVS2dSNVBaeDZwS2VpYTViQ0JpMWpuR3dxUUVqTjQ2?=
 =?utf-8?B?YThzUmJsS05CZmlWSUxiSWcydGt3VVgyajZPb21ZRmdQRVppTGcwRXlUQkFm?=
 =?utf-8?B?ZUFiOStLY3B4Nmt1Q05SSWxNNXBIYmpPTVNGTlEwT0plb3dIc3I2U2J3em0w?=
 =?utf-8?B?MXNOL00yaTNHQ0lYS3JYNlU4QUY3RDBPS2VPQVB1UVZPb2srdDFnRWtYcGRn?=
 =?utf-8?B?eEJHVTJYMHNidU1sTVVZelBLYU0vb1F2cjhxZVNwTFJaOTk3SG56UWhTLzdZ?=
 =?utf-8?B?RVI0bVVvME55L1ZlSitXc1M2Wm53UU84bmZ3NjVFL09ZaDVaQzVqSFBCbkd6?=
 =?utf-8?B?Tlpyd2NaV1JGNWFSV1ArNzJYb0docGxkS0diM1M4M2hmdndUOU1ETXl4NnR6?=
 =?utf-8?B?bExyb1Frb3IvZU01ZWNNUCtYYUNDMHNLYi9Yc1JBUzQyMkJUaTlSOFpQT24y?=
 =?utf-8?B?UDB0TndUSUtrSnQxelJDcnVYeHhRWnRjbnZEeStOeGNVczFudldweWMxOHZ1?=
 =?utf-8?B?MTFSV2E0aGFwV3RkL2daZWxuS3NhbEhKZjFFUnZQVXJZVEkxOURacElsVHcx?=
 =?utf-8?B?bm5mZmwyOW9GYm9rQ24wUkFHRDY4MlN6TVJ4WVBFMGpVOFlFeG1pT1dRUjNr?=
 =?utf-8?B?ZWFBcWRQTFBzM29BNnRoajdTUW1PTzR3NjgzZSt1NS9NQ3pYRXlSanMxYUNn?=
 =?utf-8?B?TmJ4MXBDc1FZL0RDa3FYZXJsTzRBTUV1NHBwZVBsSVc4dVBkWFMzSnpIZHhO?=
 =?utf-8?B?QW94VHJ1TVQ1YndFaUtBWVg0bE9MSXJnclRQbVJmTU1HZUFFMzNZZzY0ZGVr?=
 =?utf-8?B?M2xsMG0xcnRuSVlpUU15aWV5V2FOVmdORExjTGlYK2ZoT0NHS1IxZzdJK0tO?=
 =?utf-8?B?b0Ztb21kdGl6TWk1dzdyUUJUbHk2U0FQU2JoSXNiNmNHeUN1bldrWi9FSnV1?=
 =?utf-8?B?Mlp0K3NuNW9mN2dNM3M1VWNaK2YreXB1WCtXVDNRSXZRanZ2TjQ3TjNGTVFQ?=
 =?utf-8?B?MTZlOWc5RlJpbFIzR0lMTWxtQlFvR0pwTXNpY3BKY28ranZwUjl6ci9LL05L?=
 =?utf-8?B?OHlmNVRyMThOY1VTdW9QVS9maW4vK004bTUxeE1hYUxQNE9LdzBQM3QrYkxv?=
 =?utf-8?B?VFdYSFRXTjhnclJlbUgxVE5CYVY5Y05CZkNEREFrTnROZHU1Uk1GNGZib0xO?=
 =?utf-8?B?QVpkam9ha3Q4a01mc3hRdjBTdVZlVTdWSnFYcDJEenRocWdURUIwQ3RjdWJT?=
 =?utf-8?B?NmZva3FPd0RhdkR3YmRpWXNQS2hEZVRLcnF4WXBUNGcyYTEydkY1aFlNWnM4?=
 =?utf-8?B?SFBFdWc5aEdvcGFBR2Z6YVMyMXp2UWkvTXhGTVlnMlJkc2c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHRsSm9UaldtSzNoS3djU040dkZRNnVPZ2VVZmNsNy9ZS3BBdGRHSFRpZ2xm?=
 =?utf-8?B?Umk4T0ZpUnl3S2o4SFcreHRZaTcrbTJlZ1JxaFI4V3dtd0hzeDFmczVoM1VZ?=
 =?utf-8?B?U3FWV3lIcmNlRGZjVVVWL1h1ZlZhZ2pOamo4Tis1MlQwR0RWR0tTaFlRTjk4?=
 =?utf-8?B?WDViVEd6SkVjSlVZT1VEWVpnNzdYM3k4bVFyTkwxZS9MdTUxRU15UnB3amho?=
 =?utf-8?B?eDRNWVNTK1FkZHRrTVhGSmtFMVBxL0pwRXlKa21nY1ZJKy93cHlCOUxsenQ1?=
 =?utf-8?B?WDZsNUpGRDIrY3haYmgxTm8xcEE3QmZpUFFsdWN5Mng5blh2NWdjazBqYUVT?=
 =?utf-8?B?VUJTcHZjSzVSeTBuQlpLSzZCOTVBYXJEZ2ZaTkJLR2V1a09ETldVMVRyWklC?=
 =?utf-8?B?UGZhUjQ4QXNieHJJZnFWa3BoM1pHWWk5aEduTTF3dVpvVGtiT0JkTFk5aURk?=
 =?utf-8?B?TGJ6VGp3K2xzcjltVi9CcnFQaER6V3ZqSkJrRVpmUnYwTUFydE1rOHZSYVVK?=
 =?utf-8?B?SkVqTXQrQlV6VlRUZVpweHBNVXBFQkVMZHZQRHhMQXB1QWE4YUNpQ2pXWito?=
 =?utf-8?B?bXdvdEhSd3g1SHMydDJ0a0VCT3J0Z2VrcFhwZnF1N2VDRjhOcGk1UHFDNGRy?=
 =?utf-8?B?blVkNXVPQTFON1NuaTQ2UTlYT2tOeWhWUnl4MzdXM1FWWWdPRUl6L1pJTU1I?=
 =?utf-8?B?UmVPV28yL2Z3cGU1R0dZMFJyOVJhSUpycjZvSTRmb0UrVFFNVERFb2ZGV2J4?=
 =?utf-8?B?SHlsNG1wTlEwdHpsYlRMTnBudDB6YUhUWXIwTFJZcy9HcFFqbVBsYzFEenV0?=
 =?utf-8?B?R3Bsd3JpaXNZVEVsYU1xMmhoUGF1eTZZVUZrS1gwSnVTbDhtZ1JvbS9SOWRY?=
 =?utf-8?B?YmFRRWY5OUV3S2t0UFVoTEJVOWt2ZnNxbUovRnhNT0RUL2tRM1Q5RHhxLy9Y?=
 =?utf-8?B?K25zUS8rL3psZllBSWE5T0tIamRCV2w0RUNlOWg0OEFMUjNrOEhSOTFuWWFM?=
 =?utf-8?B?dUh5cWU4aXl5NGduVSsvcXFyejFmdG1ZaXl2WUF6ZEMzZmp1QUwya3dtY0NB?=
 =?utf-8?B?ZmwwL0NTV0NFb294THlKNWVXQzNYcmRqcTN5VkdmVms0a3NxSnBWOURKS0py?=
 =?utf-8?B?dnJoVHZYWlRqQlAwNGtIZWRUbUFZSjZmRnlncG9LYnFXbHRWK1N5aHVkWWJY?=
 =?utf-8?B?RzUwYWFHczJMaDl2U1lSekJyOFQ5a0JiM1YyY0ZtbVZFcmU2d1NuUlJHZXVz?=
 =?utf-8?B?WXBMZW9zRlNWSmdGTW9HZ1h2a3BoallGeU0zNEFPbER5eUhONHhmMjRqTGdZ?=
 =?utf-8?B?T2hTQ3h0NWw1UWkvdUpLazhwZ1c1elJVOUVZRDJ2TXVlMTdVU1JiV1pmekVV?=
 =?utf-8?B?eHVSR2dhY0QvZ001WGpTR2VwNnJOOGkvNDlzQlk5VnRKNUVoRnFjeU1qZ3Bi?=
 =?utf-8?B?bG54RDlKSFZvdmg2cFVCUzRBeW5VR0ZMdStSTlZCaW0wUzYzLzFlM3ZUZ3J2?=
 =?utf-8?B?NmgzTWl6S0xITW15YjdlYTg3MUp2anBkM0N1TEFwYzRNanJ5REQ2N28zY3ZP?=
 =?utf-8?B?dG50SUtvRk9kUjVFOFZ5NnNScTlKTGxyQ1F4YzBCS0V3cTlUSzBZdUZDYnNU?=
 =?utf-8?B?TTNvZmRWWmNQVi9ma01wZ2NBRzM3eUZCTFNpQlU1RWp6Mm9LSEh2ZGNFOXR1?=
 =?utf-8?B?d0FPYVJQMDlEMUh6cXZvYis2bTljY0ZMQUtIUHFjV21VMHR0YXdaTmI5Qm81?=
 =?utf-8?B?RVFLa1psVFhOL1p0SG1tQVpZRU9heVBYbXlHblNkTllyVW41eDdvTUdBeVo5?=
 =?utf-8?B?ZUVWZm5lWVhnbHNmMDNVQ3lPdHJPVm02dUNXRGltTHdUUFYwNy80VGRWNWt2?=
 =?utf-8?B?cUNNZUIyaDlxZ2I4d3lIMVpSQ3VVNDF0L052VFc5YXRXWng4QXJCelpIZUxE?=
 =?utf-8?B?eWt1bzRHc0tKZFN4cDI2SVVpVkRjck5sRU9ZTWczQUlVeEM4dDF2KzJTdkNY?=
 =?utf-8?B?dXZEQ0lOam5IRTYxTVZ1NEQwdFlHc1NxcTFJM0FJcEFQd0t1OEZlOVVlSzJj?=
 =?utf-8?B?Mm9hT0wyaXJKeC96dWR3S20rRkZvcHJycy91TXRCdnJ3Rzc3V2FncWFscDg3?=
 =?utf-8?Q?4jchYfmgCCNa22ZWKfH3XZ3VC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 812374ed-0394-4baf-a483-08ddca805332
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 07:04:26.0211 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GozLKRpWDjysk/mRDVeigLQYxVYHtVZs1u/wDsag2o7geC0RJjJOCyivyyXUFONp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9661
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



On 7/16/25 09:04, Prasanth Babu Mantena wrote:
> The buffer that is being used to write into the flash needs
> to be handled properly with padding of 0xFF. The place that
> this is done can be at a more generic place like spi-nor core.
> 
> This reverts commit cd9123507003e07b13e61d72e14e493bb338e827.
> 
> Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
> ---
>   drivers/spi/cadence_qspi_apb.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
> index 6f89d3add5d..4696c09f754 100644
> --- a/drivers/spi/cadence_qspi_apb.c
> +++ b/drivers/spi/cadence_qspi_apb.c
> @@ -558,9 +558,6 @@ int cadence_qspi_apb_command_write(struct cadence_spi_priv *priv,
>   	void *reg_base = priv->regbase;
>   	u8 opcode;
>   
> -	if (priv->dtr)
> -		txlen += txlen & 1;
> -
>   	if (priv->dtr)
>   		opcode = op->cmd.opcode >> 8;
>   	else

Applied.
M
