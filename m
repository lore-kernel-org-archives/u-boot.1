Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3223BCA0EDC
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 15:04:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7179983980;
	Thu, 14 Aug 2025 17:04:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="oOAh8YuY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9E238398C; Thu, 14 Aug 2025 17:04:43 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1CFB8393F
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 17:04:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p5VLnP8hF1U6usgPMI0I60Scgg+u+AZgc3kUSTf/xG1Vrr0cPeyRAFZymx/kWscSU5+74RS7xzu6Tt/ZWSHIfsrYB4AaM2K2UM5IeU1v8sJD8/AQ37gvvdpX5042bANgF9l8OHQSp+Ihiw5ToBI2cR1OpcyfdHbU9k4oKNXL7LpLBIAUgJn8zKdiLd5kAD8CmXioi9rgvvY96EYYRtMpkVGKywVB1Y74F/5s66SXWMX4Dj2uoBRfQr5ixsiYc4XTqaZjVtKvq/OSu6ymiK0t5ULFFLRceH5Vx7vvYM5lPZ3W8Wua+2Mzhb+UR53veQGvj0yhOykhOy3wxTtaJfQzMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJ5En4MB3WAnhVjWFcNQ5YBCzZFVz2DnfPVjXwedz00=;
 b=KKwXP7UM+IncfrcyJUajYbdyakCUTAZCgfXQ0LpFik5z1FMizYguz1Q1ocaulC3zt4MVOeB1PpCxEv5rN5JS5Xtv1wIKCoMaqdC/iOVL3n4VpxKJ9+ZFvk+ug7bQaG+Uku6AYxfk3fVCUosNwQ9ZvDu5KrOq+MbqDSz9U1GrYGqIAHg1D10vV8iv96EhP0CLq14hbSsdnfz6KfFMrnUFNADFuK7yEkbDpQYSrTHrg0lcAhvxZ3erhOSXLqLgSKWTclR+MLQnHTypJDOnGEpRkYpJp7sLBktD2dqgQG09Q0qOaJaIPjHGYsavcO+MyZXjMW5gPB098gOsq3m6UC6Oww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJ5En4MB3WAnhVjWFcNQ5YBCzZFVz2DnfPVjXwedz00=;
 b=oOAh8YuYYkcFIsOXXayYuYguAna06oHu/yJxyYz6ZR7vW/V6244k1qjUsAIZrh6+DuvMa3LEgHBEdHlVKCJEbKj1KKlmgl2NAbvhh7Xy//jjAjvZfgJ28GfoLtUq4by5XN4Fjke0/ay47APvUf0XCk1PuRt8qijShVUv+GS5yn1+2Hq6sQjkeJ+dCeR4OGeAFGirl2XsNdImRKfP85ATRDqRvrDNZTbPsaX4UqxDFtZO9X4A3K1oeuCf5QRdBVCdhdnmek0YmwxL8+/ydUxYvxwtRf3BDx4KQdZMBEYNVc+wH0SI5QWx70eUqlZ4BWu2FZLSEmVm9kuHJPTmP4hEzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB8214.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4c9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Thu, 14 Aug
 2025 15:04:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 15:04:39 +0000
Message-ID: <64ac6205-8d5d-4cdf-b3da-993fffe0b174@siemens.com>
Date: Thu, 14 Aug 2025 17:04:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: CONFIG_SYS_EARLY_PCI_INIT for PCI-attached eMMC
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Fabio Estevam <festevam@gmail.com>
Cc: trini@konsulko.com, u-boot@lists.denx.de,
 Mark Kettenis <mark.kettenis@xs4all.nl>
References: <cdfbaad3-e9ed-4678-9a65-c3561537d600@siemens.com>
 <CAOMZO5D+1v-721g5nE3NFQ4igrBHvF0rWs6Jkvm-Jo+R0QXKwA@mail.gmail.com>
 <87h5yakqug.fsf@bloch.sibelius.xs4all.nl>
 <CAOMZO5Cmgs3zUxdy_PRtE85pJLzG5=_1kReezFfKX6Xv05vHdg@mail.gmail.com>
 <8adf6ea6-e1c6-4dc2-b692-222381a02eb9@gmx.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <8adf6ea6-e1c6-4dc2-b692-222381a02eb9@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0192.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB8214:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fa4fe63-aa50-447e-5e50-08dddb43e416
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VFVSSkwveXd3Y3lLazN6TTZKODdrdE41TGtpRHRhR1hGY3hoU3MzamRWZTM3?=
 =?utf-8?B?OXBleWRCWTFFaTJ3Q2R4aU92NUMvSGNWR0txWWZ5eGcyWmlrbE1QeWNsYytt?=
 =?utf-8?B?ZVc3aXJNVzQvN09xZllZYXpRREJjTCtqWjJnU0VaVU1CSFZDV1FXOHhjMXdl?=
 =?utf-8?B?OHhuK1doV1M1N2JvZ3U4Yy9jSHgwUEVSR0tIL0NsNEtxZmczVnptckJrVUo2?=
 =?utf-8?B?bHNqOGRSYkJ1TGRUMUFqS1NQV2kzb2E2bW51eElYYjRHYjZ2RGhIZXhJenRP?=
 =?utf-8?B?R2JVU2gxWnd2WDN5OHhEWUgyNDlZcWgzaURFcFFWRGVmaG9sVlVyTW1ia1Qw?=
 =?utf-8?B?dWZHWFZWUkttVlZiTnRkM3FKZjdDbmx6TExVWC9SQTV6dHlWSjBxTGREb0Vw?=
 =?utf-8?B?U3ZPYmRNZll4MkdORnhYY2VLQjVDaEk0MzhpU3J5cGVPem5VbTBCUlNtMjZx?=
 =?utf-8?B?RHM0S1dJeEpzeVlYcnFhQ3hEbGozN0FyVjVuMzhMTWhkMUJCOFI4bllsQkpY?=
 =?utf-8?B?V3ZZMnp4U3d5d20yWnJEWndJVVFFYU8zc1NPM1o3cmh6Z3JDZ2h4cmZuTHpN?=
 =?utf-8?B?NnFJRng3YkFDSDV0dzcwVVZ1WlJrS1J5eVA1amJUZEwrOXF4RFNQZlIwbWJ4?=
 =?utf-8?B?OWJDQzFiK09Ua1FvMEtIRWFjU3RPeWVVcGNGOHNKcmxGL2FyR1Q0TjVUQUs1?=
 =?utf-8?B?NWtsQll6WnlvY0d0UDE1UzNBUDE3b2JxSTR2ak1uQjFGMlJPa2lxU0JQQzNh?=
 =?utf-8?B?WTFNMXJOS21QZXlIYy9VSGt0eE9rdmpEODVLV2E0aGhLd2NVNS9sL29pU2Z2?=
 =?utf-8?B?UERkc2RRRGh2cUh0R0FGQnlOS0l0VU53WDZJdndPLzgrVVhySExWeEJVQzlp?=
 =?utf-8?B?d1JVVEkvVEljL1FDc1J3WlM1cEVEZlRET2RFZ0l5TW9Xd3ozSXA3bUY2bkNh?=
 =?utf-8?B?OUdHZkVmaURINVRyblBOK2dPUUVlazJJV2xvNGc2NTV5UWY0N3p3RFNWOFgv?=
 =?utf-8?B?Tk1JZy9Dd0psTTgvMmJwZHVUZmdQK0orZVJITlkrZURGOG5xY25NZm1oQlRm?=
 =?utf-8?B?M05IZHZXWlBxSWsxeHMzRUtmNXNZT25VQnJ5ZEt4T2V6UWpVUEc1WktoRUJI?=
 =?utf-8?B?ZFB3dlJDRzEyZG1GSzcwV1FyOUx2OFpqTWdlM1pySXBOZ3BhM3RvM2pBaURp?=
 =?utf-8?B?am00Y0N5QzEwRVhpZmNBek5LUEtHcFdqSjJZSmRjMzUwa1ZpNkNWUzVZQklO?=
 =?utf-8?B?N2NuUUNsQkVMeURZR2lQL1hiTzc1VGJkc3lGSExwQ0pWOGNOWUpHdGV2WGhh?=
 =?utf-8?B?cmZPa3A5UWU3TmlIR3BZbTlEa0xsdkc3bVBacmQrNHdSYld2NlVzQTY1c1RY?=
 =?utf-8?B?SXAzdkhmTVFHbVBQcmR4bkZTS0lic2pJQk1Jb3BoSWk1djNsZGh3RXRhaFA3?=
 =?utf-8?B?VjQ1UU1FNGMvSndpbGt2TmtScXlBdnNuN2Z2SjVnbzYzWFRlUUlReEdmUkdK?=
 =?utf-8?B?V2VxTE5qT2VPOEEwRVRJL3NSLzZ5N2dlUVVYNUVJbHlCQWt4UkZJLzh5SDlW?=
 =?utf-8?B?ZWw0aG1YQUtTN1VDakR2bXlKNVZnZlpmMEwyM0lYNDBNcHhoQU44L09FTDhz?=
 =?utf-8?B?TXJjc2YrZHduSEJtOC9CdldGOEo0TC9JTGMrUzYrYk1PLzNBcVR0WGxFVDhv?=
 =?utf-8?B?bVlHMDh0aUV2TEwrUVg3QWFLVVRjSytHODY1eGpjUnR0OU9KRzgvR1FnU0hM?=
 =?utf-8?B?blFGNEZHWVhNbmxTZWRRNlgycnNTSnpKc1NvME4zN0pSNXJaSXJ1ek1SSlUw?=
 =?utf-8?B?Zzg3YmZnYnU0ZmNzUm9wamNiV0ZHRUsrdmxMVnRpYmE3YlhIRlg1eVh0OWxr?=
 =?utf-8?B?bFhVN2VjeTA0cVVmcncrdjhGcnRWeFEyb0poYXR4eDNNeUE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTZGMkl2NlNoWlBlb1hrdjF2UU41eEgzaFI4VkFTMms4T2traEhNcit3ai9B?=
 =?utf-8?B?Z0c0cG9kTHZ6cThtVDdsUkdRWDR1NDdGVnBLRWxTNWhmMUZzb2NzdHUxZjY2?=
 =?utf-8?B?S0tkNUM3dTFyWHZiRFM4bFBQM1dEeXJtNjRVS0JBYm81dGNibjJnVDFOVGpm?=
 =?utf-8?B?MkVqbnl3SG5odmdIM29meEQwZXNpdEE4SS81VTJLcWc5WWM2N1RJNzJHeWZk?=
 =?utf-8?B?WjJVQURzVXZxaE1PbkVueGZGUllXWVhDMkVIbVJhckhMWVA5ZkxBTTBaanhB?=
 =?utf-8?B?M1hQeWlVUmx5ZFRwSXJPZjNNQUtZTkJieVVEcmNzcVFlN3R5OTBET0Jid05L?=
 =?utf-8?B?dTZFWWUvUUxpd3F2TG55V2crNXNldWcwUHVPTFl1TnFXUDJNMTU5ZWEzdUpn?=
 =?utf-8?B?Q3NpWUxpckFaQUp6S3dqSnVIbXV0cGVIQUFCVytVTWRxRUZaMko5Vk90VGg4?=
 =?utf-8?B?RmdQbkpTcnNwK1RGV1dPR25INllkK2hvc1JFL2tCVmVvdVBYdkNlK2svMDhJ?=
 =?utf-8?B?Y25tWlkwY0x5WWpQWFU3RjhSUkJCNjhFRExJNVk0OXhRRnVzUDR3Vm5EVVNU?=
 =?utf-8?B?R09zOG1OZ3MwT1NHd2xEcjZ6UTlKTi8xQm80OGdjYy90UldYVk9PU0FVTVRv?=
 =?utf-8?B?a2hHTlRFaFNmY2hEbGRFdTZyRG0zb25JMHg4YmlYRnRUQnZtaHdQWFFRTWpi?=
 =?utf-8?B?YklDdW42MFVZbXI1R1ZJUmdnSnJjMUQyQTE0NGVjMElCY0dUU1hGclhNOGtt?=
 =?utf-8?B?b3FsM2RsT0M0R3dLRDRFYndQZWVVbjZRQkpLUitEbklhaDBOZHRKNDFEQzhX?=
 =?utf-8?B?TXE0b284T2JiVGp3RG83ZGJGV2trMnNsaENXOHFOa3JJUlFVNnE0Mm4vQnlx?=
 =?utf-8?B?QWdNWkNpZlk2VC9zc3Q2OU9VK2szZ0hldHNHaHFSRHpiLzFiWmxLdDR0Tk5O?=
 =?utf-8?B?LzlWTGZYdHFrM3d3Lyt4Rm5lU1dZc0tLdldvc2h3cHVYQkVubC9DUk5Cb09t?=
 =?utf-8?B?OUNYc3gvSUxPMlRnMlRvd2J1dEgyWDluWjBPckhBOHRiT2dCb3kwOUU4bEJ3?=
 =?utf-8?B?d3FRekw3Y3E2Z2FzdTBjVkxpQVZGdWcwaGtIam5wRjRidkhlek1ZRlh5Qitw?=
 =?utf-8?B?TmNIa2wycWZKdkc1azB3bHo2eEhNTWtUNDYwL0l0TGhmL3lqa2dKVlp3bG0w?=
 =?utf-8?B?U0V3Z2Mvc2QyblJVUmwxWS9jVXp6bUprWGcvcFkrNW9lU2UwS1dWM2U0UWdm?=
 =?utf-8?B?K2piUkp6L0xWUUxoZ1ZTWXRrWGJNVExlR3pqODJ4VzNJeVVuTkEvdFdwM1ZO?=
 =?utf-8?B?S2VQb3FhODZxVFduTEhHZ3BFODdPYjFJcElVdXlVV05iUlJZMXhqM2ZvM0k4?=
 =?utf-8?B?MTRERW1rZHN0YWFSbVJQb3ZDMGFjdVI4dWMxOWcyWkR2blA3UWIrRXFlZXBJ?=
 =?utf-8?B?T2wyUis5VUxjVjdKcGJhNGpDYVNkbGMwYk94Rnp0aWdoUlBBS29uMWl0QTFO?=
 =?utf-8?B?aGN6dS83UUtXVllGN0FHMmdCWCtGeDF1NmNnQlNjdktxVlVGTzlEU0E3RHkw?=
 =?utf-8?B?ZnNmbEJNb3lnLzJBMnZzdS95cVBXV3FnTlU5MTF5VUxsWUxRUWZUYVRLRVBq?=
 =?utf-8?B?dXY1T2k3SmoyZWIzSHVqcUQ3SHluaUVtWGF6dXlnM3hKL1VBNy9YV2VWOGNR?=
 =?utf-8?B?cnhud0JoM29IN092T0NTNlhrSDNmY0FjajdRSStlSkRUUCtsWXBybCsrRm1r?=
 =?utf-8?B?MjFRM2JlQ3ZjTjEwTGhKZGZUaWVac1ZpaTlzc3hxaWgvZTZtN08vYitlN1Bq?=
 =?utf-8?B?QjU4WjNLT1lYR2pkTXJscmYzbE82UmtWWWx4a3JtM1BtK2dNVDVQZE5DeUUw?=
 =?utf-8?B?RThYVHh5Vmk1cmdNU1pZRnNRM2MyNE9RRTBEUWFmeWEwQjZxOVlmNm94dXB0?=
 =?utf-8?B?cDFKcCtWMTZYZlIzVVNvSEpONHJJVlVhdzNFQ0dGZXByL1VpZTdWbjEzalNv?=
 =?utf-8?B?MzBQV0NwelB5TDFZR3EvYTlBMDU0dUptR3RVTVUveDlKd1ZnVzk0U3JqNHFM?=
 =?utf-8?B?djlocWlKM0hyRlNoT3pud21YRTBsMVk4bVpmNGpoZm5LVDJ6c2ZnT3RUeFU0?=
 =?utf-8?B?V2o3clp3d3ptVHlXaEh2aXRxYnNiQ0ZVczBzUmQ3KzBQRFVqYy9RamxpR21z?=
 =?utf-8?B?U1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fa4fe63-aa50-447e-5e50-08dddb43e416
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 15:04:39.3430 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RiqleOXgxmioGvP1SeoTc+1FamroYGlWxrZ+LZ/uWWeZ6cJpEMbPjL0aNEVeaVqURyv7ENOWz9hkz/ctmmqjMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8214
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

On 14.08.25 16:10, Heinrich Schuchardt wrote:
> On 14.08.25 15:27, Fabio Estevam wrote:
>> On Thu, Aug 14, 2025 at 9:52 AM Mark Kettenis
>> <mark.kettenis@xs4all.nl> wrote:
>>
>>> Not without removing the 2nd pci_init_r() that is conditionalized on
>>> !CONFIG_IS_ENABLED(SYS_EARLY_PCI_INIT).
>>>
>>> That would require some thorough testing though; I certainly wouldn't
>>> be sure calling pci_init_r() is safe at that point on the boards I
>>> maintain.
>>
>> You're right.
>>
>> Maybe we could solve it with two patches:
>>
>> 1. Convert EARLY_PCI_INIT to a Kconfig symbol:
>>
>> diff --git a/common/Kconfig b/common/Kconfig
>> index a2f653f7e722..9119a1c0869f 100644
>> --- a/common/Kconfig
>> +++ b/common/Kconfig
>> @@ -824,6 +824,13 @@ config SYS_I2C_EEPROM_NXID
>>
>>   endchoice
>>
>> +config EARLY_PCI_INIT
> 
> Please, do not rename the symbol.
> 
> %s/EARLY_PCI_INIT/SYS_EARLY_PCI_INIT/
> 
> All configuration symbols starting on CONFIG_ should be defined in
> Kconfig. Only CFG_* are not Kconfig. Something must have gone wrong in
> the conversion work some years ago.
> 
>> +       bool "Enumerate PCI buses early during init"
>> +       depends on PCI
>> +       help
>> +         Do early PCI configuration _before_ the flash gets initialised,
> 
> Highlighting is not supported in Kconfig.
> 
> %s/_before_/before/
> 
>> +         because PCU resources are crucial for flash access on some
>> boards.
> 
> %s/PCU/PCI/
> 
> We were talking about eMMC, not SPI flash.
> 
>> +
>>   config PCI_INIT_R
>>          bool "Enumerate PCI buses during init"
>>          depends on PCI
>>
>> 2. Select CONFIG_EARLY_PCI_INIT in the defconfig
>>
>> diff --git a/configs/qemu_arm_defconfig b/configs/qemu_arm_defconfig
>> index d5890bf87fb3..a0d03dc19d0b 100644
>> --- a/configs/qemu_arm_defconfig
>> +++ b/configs/qemu_arm_defconfig
>> @@ -28,6 +28,7 @@ CONFIG_USE_PREBOOT=y
>>   # CONFIG_DISPLAY_CPUINFO is not set
>>   # CONFIG_DISPLAY_BOARDINFO is not set
>>   # CONFIG_BOARD_INIT is not set
>> +CONFIG_EARLY_PCI_INIT=y
> 
> %s/EARLY_PCI_INIT/SYS_EARLY_PCI_INIT/
> 
> Otherwise looks good to me.
> 

Ack. Fabio, will you submit those two then?

Thanks!
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
