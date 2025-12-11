Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92542D41D69
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 16:36:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28F868367F;
	Thu, 11 Dec 2025 17:36:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="O2Cqk6HF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FA6B839E8; Thu, 11 Dec 2025 17:36:40 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF9608367F
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 17:36:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZASO+JLfc6LBCI0lBQKWfJECbSu7hw0oWhFMYiwdFa9hPZ/YV1gBDiDeXJV4mvA/aJ82YZctA93JAi4DLCOWfnhoSTFiBg5IAWd4oPGhTT4InvMAuTjksU9DbAPI0FpHllqcBs6PEUIy5PZZfDf8wb0tsxBBMg146kzKwuXfpmhYCUafU+hFBk4lWfQ2g9zA31621M4lyMzX74F8XGLUobw5vChDMfdSxcYo6OynddaFFtWpXLVD3RePOgU7x/p4yil4w/S/vOFtr9o/IgrJLyvdi5cfN8Z0SdIpzPOHHEp/R8CsGCOFEmNMKj+H83kx34ycmdGH7AnWE13dF7sS+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9CP0P94qvipQOkMCi/dTU9p24vtOBa18cqgXhnFSXqg=;
 b=VfUkxva28pe9GcdPk8eba+85AeP62Uj7EJxFcaxEIhS3j9ZSNNieFMx5RQKa8wxJroLY9NmoVjCY/MGsWgqFNfmRMVBDiLV0qXK9n13Bic/vT6H0e2baB/0chE3/EhFW5whYJNEXan4zN5BY3WW0krTze8k6U2e1xxllKGOYdEyStpeu5957n1G+yz2ZTA8x0PCgccz0dWvHp1xSF9uAdzjCEPXi5m3LsWTXtiOtF3vJcg3jZwzKG4qu5y1toj/RBFfd0CLF2brDkUsindQf4CttOn7MBrJRCevCyJLf+V32ug7OTjJw3wfTCCq8UCtmuvsFjjRH3LO2WFp7t648vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9CP0P94qvipQOkMCi/dTU9p24vtOBa18cqgXhnFSXqg=;
 b=O2Cqk6HFRPg+c7JfaH3JH9sxiSyHZ4gM9R7amM9n9jKmDHzXZ/pfdHgVbI5ggpxtcchS8fMbpAH7j+vwyC7nOMy3hjxu7I1BJW4zoo5Qtu7wjI/s3TuMHU5ndAweb6B3sdUOHnpSFZRx23OWFo9AdfgzsZkX4t8p+gvl4VYJuxm3gMHhFSq2mmxfDk9vP3v8jd8YbL0xHJ3Puwi/o2cG/rxpOtpoTaEvwGaZjBHUX2T/ICpIOaSQei+Co2xVb/h+RZQiTKVrZ6Hg4jlEjT8zsIyetAdElnitD35jD5c8749hk2zzsZm+PSVVEMxZkdlKzOwVaawYODQ8KzYtzack2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6660.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:86::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 16:36:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 16:36:29 +0000
Message-ID: <0fd50c36-c780-468d-9d00-304946eb28f8@siemens.com>
Date: Thu, 11 Dec 2025 17:36:28 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2] configs: socfpga: Permit EFI booting
Content-Language: en-US
To: U-Boot Mailing List <u-boot@lists.denx.de>,
 Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0204.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6660:EE_
X-MS-Office365-Filtering-Correlation-Id: e4f19e5f-5b37-4794-a61b-08de38d36fb2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1lkVnBNME85Nzg3SUJpaGw4UW5jRkJMY0VZMWJxbUhhZ25PNWVLV1pjWjlT?=
 =?utf-8?B?cGt0cjY2Vm15NDh2L1NCcHFNRVFpbHFhVlZtT3JVdXlJTE13bloyY3BLUTBt?=
 =?utf-8?B?UmxEdk03YWR0eVhWcXFzc3VCQlBCdlBmVVdXRHFEaTFrYit3N1V3WE0yN0l6?=
 =?utf-8?B?Q2RyZDRUWVhLdHVmQ1M1WXJoS3JVSkRiMzJBaFBNZk8rMEpydWIwR3YxUGhP?=
 =?utf-8?B?eEV2Y2NPeCtleTRvK2pIczZGMmgzOTZZdzRaejVtbWhSaTNDYm4zeFhjNnQw?=
 =?utf-8?B?STkyRWJMTE5oQ2NrTVN4OEtKbVA4VW85eU5hWlFDbFBrcXdFeGJVcytRU1Z5?=
 =?utf-8?B?RjVLSUhyYVlGNlV0R1RseWFHSXNBN2xhRFFHL3pCb3hXWDVHRWg4WFQxUXE0?=
 =?utf-8?B?V2NiTmFIbFNnWTIxelB0eGVQK0VNODJORUpLSlBQazVzcWY4RDFPSkxhd2xz?=
 =?utf-8?B?RHk5RmhWVFN2VmtmMmFtVGZmSjBNUWswL0tLT0IxZ2UxRDU5TnlNdTJsQk04?=
 =?utf-8?B?RnpWUTZ2bnBxdVoya0NDQ0crY2M0UjBTSEtTU3RUNGpuN0ZEbGtRRjhqeHVI?=
 =?utf-8?B?cEtUNGZkWnpEUXhNU1JTQ2ZxNUNmaUJXZm9zMVdQUE5DczVVQ0NmQmpiOXR0?=
 =?utf-8?B?WmZiS241a2xHSVNBQWUwN0FZTHd0SFJ4RE92WFFJM243K0oyejlRdmg2NWhw?=
 =?utf-8?B?ZG9UdjlzaXRDV0lwczkxb1l2Q0NNZWpDam5jRzdNYjJzdXppOFFQaDNrSWhE?=
 =?utf-8?B?N01KbG5zUHRnU2pCeVVRL0VkNnNtZG1lMTNOTDZBMEFHV1dOZXYzWkg5LzlH?=
 =?utf-8?B?RmcrQUN2ZGdiZ2dBd1ZMOGp0TGtaeThQVnNndytVSWFJSlJjSHFyRUQvamVH?=
 =?utf-8?B?ZjdlNEVKc2N4NldmMFZMZ0N0SkVNZFBYR3VaSnlWNS94b0xGMHo5RXFXeHp1?=
 =?utf-8?B?MEthMTlJQ2ZmeDVmMlN0UldLK1ZDYmdlMjlTclR3cGd4cHNyamovVDExVGZD?=
 =?utf-8?B?YUVKY3k0R1FHWTFEOWtnNzg4dE1VZE1vd215RTR5VHNiVjFaZnFrT0V1NWhH?=
 =?utf-8?B?bnJyQXJPdEFCRTA3RUNxRWx4Qmlta3RKZmVSK2RjQ3dkTmNyb2dIMStKcVpy?=
 =?utf-8?B?bG54aE1Ta3l5YS93L2NvYWx2SW9Mcnd6YTVNZ045RmdkN2ppRThZb1lBRUda?=
 =?utf-8?B?RHdwOU1yODA2N2NmUlhXVGRSN0RmYTlYNitOTjBodmJESWE2VWZlVmxyd3JX?=
 =?utf-8?B?NytXSERlVGNOOWdrTkFxcjFibFlJaFBFRUdvb3IvV3d2WTRWNkNuaHlHeTJi?=
 =?utf-8?B?alVkSHBYRExKTHBPU0hYbHE1MzAzS3hkK0hVMjZGdDRHT01qWDVKaTRHL1pK?=
 =?utf-8?B?akZlVmpRV1IvOGM3OUptOTFOeGdwTWszT3F1MDVwY3A5a3plQXZxbjkwaWZv?=
 =?utf-8?B?eWJRN01VMm8xMXN1ekxCbjVYMDJ6TUlQcUdnRHBxWmtad0Q1UGw4MkZhN05L?=
 =?utf-8?B?NXdtVmpMcmVGNDl1UzllanMxYmNsQ1VEK3RIZjhic3ZyaEZCLzZLQTRFTzZq?=
 =?utf-8?B?dlo5U2xCcFJaMlB0YmViUjZaaGJydHVEdDUzRjVnemhhRWNIZ2tVODFTTDBN?=
 =?utf-8?B?cTd3WklFVitTMFFpVVpTR0F0ZkhJRWVzZHE0K3cyWmVBdDlXZUh6Yzl6NnYw?=
 =?utf-8?B?VFdFNm9pM0Nxa2IyRktKUHIxbkQ1blM1YVJkMTRieWN1dGY2dXplYncwbFEr?=
 =?utf-8?B?bG9pRndNUDhmR1VxRGQ5Ymk4bWVmWDJDeGhBa3NnbUZBeXNjVkF0bU53OG9i?=
 =?utf-8?B?cHFtUUxLMGRjMHRIMDR2cUtyRmV0VFBQVHRqaktKc1ovMlVsWWlNalBtVFdL?=
 =?utf-8?B?c3NIMGRUTGVFRDNHWnZHSFRSbldwNWpJQTloblBHMjVMMEdVUEhmYjBMOHFF?=
 =?utf-8?Q?A2qN4gNdMJxAzWE9q3jZvit21y6mVHGL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjZSUng1dzZVY2Nxb0llR2Z6MmlSbFJXbFltRUp4UkJqVG5NL1JLajM5TnNH?=
 =?utf-8?B?NWo0VS85Zlk2S0lrWkxicmpCTUl4V0kzVXA2R1phazBkSnNrZE9iRE00Zm5P?=
 =?utf-8?B?ak41WFM2d0c5VHEzZyswanpaWHRZcDFQd01vUU5FUFNBTWVrTjF1Zm0zbUpl?=
 =?utf-8?B?ZG5HSkZGWkJTbXFhUExJTmRMUkZqQ21vQWtSbjQyNWVwdGxFcVVMUUFRZ20y?=
 =?utf-8?B?R0ZrdVl2V25mZXpUWEpBKzVEZWcvUnA1dnJlS1FJQ3JRY3U2ejBzTjd2cllr?=
 =?utf-8?B?R3pqKzhzZENITmdHNC93bjVhaHZVMS9tQzdxZ3BNSHNaMUhmbUtjdzM0WG9u?=
 =?utf-8?B?NWcrdG1tUnEzek9WTDhFVjRuWjFEOHNDTXJ6TWVTa2pnV0FwTk9jZGJQYlAv?=
 =?utf-8?B?NGpMSUhyNGVwOUxlenBIRDRheXF5eUdKQWZQcDNMSXBLcU90KzEwZzZQdk84?=
 =?utf-8?B?L3A2S29tRmhvWDY0MFltRFpXdENGOGppQW80NkFhV1F6MDFVRHp6dFRJOHcy?=
 =?utf-8?B?elUrWWRnR1lYSEU5UWkxMHg3RnVqcFl0KzliTjAzaTBPNndVQUMxZWswbVhO?=
 =?utf-8?B?RW00bzZYaG9UN1E0Qmk4RDdLZktaWFVVWmt3ZUlIUnBqWC9Pd3B0TnNzYm5F?=
 =?utf-8?B?OHJ3Mm1naWhmSXNDRG4xTUlzaTJWakRpbVRNeWN6dVJMZWVKM1hoNnJxV0lR?=
 =?utf-8?B?QW1BNDlrdGFkRkhXd2Q2MkEvZGVuOFZxOWJPT0RLNWg2UmJrNDhST2E1Q1B1?=
 =?utf-8?B?bDBvYmxxbzJyejZvaTV2cCtKMUcwMUZ0TGo3eXhUZUhyRnhBRUk5SGxKRXIz?=
 =?utf-8?B?VWx1M21UbFhLcENoa0dyVE9wQjBuZ3Q4aHo4OHBRcC9aZHhqMjE5Z3pWYUQr?=
 =?utf-8?B?dHlReTJ6T2lrUlIrTzR2bzZNT2NvamhMdnd5SisrWkxNdUZkSDZJUDYwMUND?=
 =?utf-8?B?bk9RejE4bEhuQnJYV280RlJ5VGZCQXlONlh3OHh0NkVlRjhOK0pUREF6UTFU?=
 =?utf-8?B?Z28wQ3RvUDNhVDltT1hpd1JSd0dqbVJBUVFUZC9JNkdiZEJmcjM0L08vUWpC?=
 =?utf-8?B?OVZ4cTg4UFF0cy83UmRJbkdEU1hCWlEyMThxNVJ2Ni9RUXdqVEtWY0l3Rkgv?=
 =?utf-8?B?RWE2a1h3SURZR3pqdkZYY1hqZHpCVXV3N254N1kxL3VWS0xTZXBDeXFUejNF?=
 =?utf-8?B?bDRGcWdtZmxvWVpSY0JqdU9QVkFEaTc2dVBmend2eHF6KzRyY3ZUbWF6SGJw?=
 =?utf-8?B?UnN3aDBhOVZPVzF6djQ0OWJreitmZGpUK3NmSHo4OVQ5OXZ1L3lNMnpiK25U?=
 =?utf-8?B?aWgrN0NCQ1Vna3FIc092TUxCczJhdVMvM1ArdTlzQjdSMUl2a0dDc0dnbXI1?=
 =?utf-8?B?RjBsdHZ0STZ0R0EvV001eWxSS1E5amY2UjhwdHBvZTdMbHhXL1NCbG5Db1c3?=
 =?utf-8?B?M0U2QzZBdFVYLytFTVhBdWZlNi9oMk1FR1M4SzhPWmtNR0pydE1WNmlWaURE?=
 =?utf-8?B?bFhSNTAwL1NhYS9oenIxYW4vMmlkSVp1M0phb0ZGRzJsOUNSSVdLNVRmMERT?=
 =?utf-8?B?SDRHTThDQ1lkeG5aa2doQ2VseEtKU29ycXIyZ1NKUlM5djFMNzcyUmROdURn?=
 =?utf-8?B?a0NYNmJmNm9sNS9RWTZKV3R1V2VuU2pqa1hkaHJyajh1K0RzRU50SGtMak84?=
 =?utf-8?B?WFFpcEdZZlhzbTYyQnJvSWNvSU9oNGpsZWF1SUNhSFhJUFhXUEk1Mlc0TURV?=
 =?utf-8?B?TmpPclJhaVNReWxYMkVaQjJVNm9lcHh0UW5xQURCYW5lM081cHZkM2VRTGMz?=
 =?utf-8?B?NjFiT051NTFGMFFtMnA1U00yMVBkTmNrd3J5SElPTmRsSkRrUUc0R084VUcy?=
 =?utf-8?B?eVI2SG9lTzNLampmd3V2dGJ6WldxUURtSk1UMWFNUjZZbGNLSytUWHcvaGIy?=
 =?utf-8?B?bVNqQm1uL0xqejc4RDgvL0xWWTl5RUthczdXMy9zaWZUUStNZnRJM1JhTVh5?=
 =?utf-8?B?NFV3Y2hORlY0M1I2a3p5a2FCM2J6UEdHS2s3SEZ2ZVVobEF6WVdieExGRjkv?=
 =?utf-8?B?dDRHcWUwMHBRTzN6d2RTTWtNbEJ5NVFpRUlEL1hNVXNYNGszczJ5Qjc3Q0JF?=
 =?utf-8?Q?xGY4cW4klCNjmWMCOYKHNShK8?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f19e5f-5b37-4794-a61b-08de38d36fb2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 16:36:29.7744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zZaIhOAQ5q3JJyZKvd8D/JD5RHv0M2xYbjlmNBTVCfuxlAiOZQYlljDyqxdpiEJSSB9hV8yB6hApz42qal9S/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6660
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

From: Jan Kiszka <jan.kiszka@siemens.com>

Commit f369e1564cf4 turned those off because the SPL size grew too
large. It also argued that those boards would never support EFI booting.
The former is correct, therefore keep CONFIG_SPL_EFI_PARTITION off.
CONFIG_SPL_ISO_PARTITION is default off. What is not correct is that
those boards are limited to legacy boot - you just need a hybrid
partition table to make both the bootrom and UEFI happy.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - use Kconfig to keep SPL_EFI_PARTITION off

 configs/socfpga_agilex5_defconfig       | 2 --
 configs/socfpga_agilex_defconfig        | 2 --
 configs/socfpga_arria5_defconfig        | 2 --
 configs/socfpga_cyclone5_defconfig      | 2 --
 configs/socfpga_de0_nano_soc_defconfig  | 2 --
 configs/socfpga_de10_nano_defconfig     | 2 --
 configs/socfpga_de10_standard_defconfig | 2 --
 configs/socfpga_de1_soc_defconfig       | 2 --
 configs/socfpga_is1_defconfig           | 2 --
 configs/socfpga_mcvevk_defconfig        | 2 --
 configs/socfpga_secu1_defconfig         | 2 --
 configs/socfpga_sockit_defconfig        | 2 --
 configs/socfpga_socrates_defconfig      | 2 --
 configs/socfpga_sr1500_defconfig        | 2 --
 configs/socfpga_vining_fpga_defconfig   | 2 --
 disk/Kconfig                            | 1 +
 16 files changed, 1 insertion(+), 30 deletions(-)

diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
index 64f2f1bf115..20fd1e237c9 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -67,8 +67,6 @@ CONFIG_CMD_WDT=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIMER=y
 CONFIG_CMD_UBI=y
-# CONFIG_ISO_PARTITION is not set
-# CONFIG_EFI_PARTITION is not set
 CONFIG_OF_LIST=""
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_IS_IN_UBI=y
diff --git a/configs/socfpga_agilex_defconfig b/configs/socfpga_agilex_defconfig
index 1c3664bc0d7..eb99392f0ea 100644
--- a/configs/socfpga_agilex_defconfig
+++ b/configs/socfpga_agilex_defconfig
@@ -57,8 +57,6 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_SMC=y
 CONFIG_CMD_UBI=y
-# CONFIG_ISO_PARTITION is not set
-# CONFIG_EFI_PARTITION is not set
 CONFIG_OF_UPSTREAM=y
 CONFIG_OF_LIST=""
 CONFIG_ENV_IS_IN_FAT=y
diff --git a/configs/socfpga_arria5_defconfig b/configs/socfpga_arria5_defconfig
index 3c860f97ae9..88ef2eb0c76 100644
--- a/configs/socfpga_arria5_defconfig
+++ b/configs/socfpga_arria5_defconfig
@@ -44,8 +44,6 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=ff705000.spi.0:1m(u-boot),256k(env1),256k(env2),14848k(boot),16m(rootfs),-@1536k(UBI)"
 CONFIG_CMD_UBI=y
-# CONFIG_ISO_PARTITION is not set
-# CONFIG_EFI_PARTITION is not set
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/socfpga_cyclone5_defconfig b/configs/socfpga_cyclone5_defconfig
index 992abdbfdc4..0485d20260c 100644
--- a/configs/socfpga_cyclone5_defconfig
+++ b/configs/socfpga_cyclone5_defconfig
@@ -45,8 +45,6 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=ff705000.spi.0:1m(u-boot),256k(env1),256k(env2),14848k(boot),16m(rootfs),-@1536k(UBI)"
 CONFIG_CMD_UBI=y
-# CONFIG_ISO_PARTITION is not set
-# CONFIG_EFI_PARTITION is not set
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/socfpga_de0_nano_soc_defconfig b/configs/socfpga_de0_nano_soc_defconfig
index 6564cbd03c6..3b021634bb9 100644
--- a/configs/socfpga_de0_nano_soc_defconfig
+++ b/configs/socfpga_de0_nano_soc_defconfig
@@ -46,8 +46,6 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=ff705000.spi.0:1m(u-boot),256k(env1),256k(env2),14848k(boot),16m(rootfs),-@1536k(UBI)"
 CONFIG_CMD_UBI=y
-# CONFIG_ISO_PARTITION is not set
-# CONFIG_EFI_PARTITION is not set
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/socfpga_de10_nano_defconfig b/configs/socfpga_de10_nano_defconfig
index 4fabd63f2b4..941f9e9f3bc 100644
--- a/configs/socfpga_de10_nano_defconfig
+++ b/configs/socfpga_de10_nano_defconfig
@@ -42,8 +42,6 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
-# CONFIG_ISO_PARTITION is not set
-# CONFIG_EFI_PARTITION is not set
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/socfpga_de10_standard_defconfig b/configs/socfpga_de10_standard_defconfig
index 1c9ecbf2bc8..d2b0274249b 100644
--- a/configs/socfpga_de10_standard_defconfig
+++ b/configs/socfpga_de10_standard_defconfig
@@ -42,8 +42,6 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
-# CONFIG_ISO_PARTITION is not set
-# CONFIG_EFI_PARTITION is not set
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/socfpga_de1_soc_defconfig b/configs/socfpga_de1_soc_defconfig
index 52ed0ff7ffa..f97b3a4055b 100644
--- a/configs/socfpga_de1_soc_defconfig
+++ b/configs/socfpga_de1_soc_defconfig
@@ -42,8 +42,6 @@ CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
-# CONFIG_ISO_PARTITION is not set
-# CONFIG_EFI_PARTITION is not set
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/socfpga_is1_defconfig b/configs/socfpga_is1_defconfig
index 45d3b2f0807..4136d22e90e 100644
--- a/configs/socfpga_is1_defconfig
+++ b/configs/socfpga_is1_defconfig
@@ -44,8 +44,6 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=ff705000.spi.0:1m(u-boot),256k(env1),256k(env2),14848k(boot),16m(rootfs),-@1536k(UBI)"
 CONFIG_CMD_UBI=y
-# CONFIG_ISO_PARTITION is not set
-# CONFIG_EFI_PARTITION is not set
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
diff --git a/configs/socfpga_mcvevk_defconfig b/configs/socfpga_mcvevk_defconfig
index bff0c41336f..db288a2cf05 100644
--- a/configs/socfpga_mcvevk_defconfig
+++ b/configs/socfpga_mcvevk_defconfig
@@ -42,8 +42,6 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EXT4_WRITE=y
-# CONFIG_ISO_PARTITION is not set
-# CONFIG_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/socfpga_secu1_defconfig b/configs/socfpga_secu1_defconfig
index 5fe35fe6eb8..552ded52873 100644
--- a/configs/socfpga_secu1_defconfig
+++ b/configs/socfpga_secu1_defconfig
@@ -63,8 +63,6 @@ CONFIG_MTDIDS_DEFAULT="nand0=denali-nand"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=denali-nand:512k(nand.4spl),512k(nand.uboot),128k(nand.env1),128k(nand.env2),0x1000000(nand.rec),0x3ee40000(nand.ubi),0x80000@0x3ff80000(nand.bbt)"
 CONFIG_CMD_UBI=y
 # CONFIG_CMD_UBIFS is not set
-# CONFIG_ISO_PARTITION is not set
-# CONFIG_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_REDUNDANT=y
diff --git a/configs/socfpga_sockit_defconfig b/configs/socfpga_sockit_defconfig
index fed1dd83dc2..6dec5758fba 100644
--- a/configs/socfpga_sockit_defconfig
+++ b/configs/socfpga_sockit_defconfig
@@ -44,8 +44,6 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=ff705000.spi.0:1m(u-boot),256k(env1),256k(env2),14848k(boot),16m(rootfs),-@1536k(UBI)"
 CONFIG_CMD_UBI=y
-# CONFIG_ISO_PARTITION is not set
-# CONFIG_EFI_PARTITION is not set
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/socfpga_socrates_defconfig b/configs/socfpga_socrates_defconfig
index a08c7c0d9e0..3bfb05fa419 100644
--- a/configs/socfpga_socrates_defconfig
+++ b/configs/socfpga_socrates_defconfig
@@ -44,8 +44,6 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=ff705000.spi.0:1m(u-boot),256k(env1),256k(env2),14848k(boot),16m(rootfs),-@1536k(UBI)"
 CONFIG_CMD_UBI=y
-# CONFIG_ISO_PARTITION is not set
-# CONFIG_EFI_PARTITION is not set
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/socfpga_sr1500_defconfig b/configs/socfpga_sr1500_defconfig
index 7744ff9a888..814b4e8ce1d 100644
--- a/configs/socfpga_sr1500_defconfig
+++ b/configs/socfpga_sr1500_defconfig
@@ -51,8 +51,6 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=ff705000.spi.0:1m(u-boot),256k(env1),256k(env2),14848k(boot),16m(rootfs),-@1536k(UBI)"
 CONFIG_CMD_UBI=y
-# CONFIG_ISO_PARTITION is not set
-# CONFIG_EFI_PARTITION is not set
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/socfpga_vining_fpga_defconfig b/configs/socfpga_vining_fpga_defconfig
index 396b7a9715d..f698b86e59f 100644
--- a/configs/socfpga_vining_fpga_defconfig
+++ b/configs/socfpga_vining_fpga_defconfig
@@ -58,8 +58,6 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=ff705000.spi.0:1m(u-boot),64k(env1),64k(env2),256k(softing1),256k(softing2),-(rcvrfs);"
 CONFIG_CMD_UBI=y
-# CONFIG_ISO_PARTITION is not set
-# CONFIG_EFI_PARTITION is not set
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/disk/Kconfig b/disk/Kconfig
index b0bd02539ee..a58717bda30 100644
--- a/disk/Kconfig
+++ b/disk/Kconfig
@@ -142,6 +142,7 @@ config SPL_EFI_PARTITION
 	bool "Enable EFI GPT partition table for SPL"
 	depends on  SPL
 	default n if ARCH_MVEBU
+	default n if ARCH_SOCFPGA
 	default n if ARCH_SUNXI
 	default y if EFI_PARTITION
 	select SPL_PARTITIONS
-- 
2.51.0
