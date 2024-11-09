Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95374D5E361
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 09:19:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1D2788E14;
	Sat,  9 Nov 2024 10:19:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="COAuUj50";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18E6E88B0C; Sat,  9 Nov 2024 10:19:20 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::61b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F24C788E14
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 10:19:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sUf8vQinfbORi3Y8gf1jkjLS+GVsSjwuEC8bZC2xtUfpinf7YPuXDohooLmMgb2XBnltM/TzldentsP6sWPY1dxYljedI0wPrhLH8RWnFO+sik2eZ0KYQ+z3OqIVic8v25CQxFlRgNcQ0xeMPAeUw7cm++5Q/bSrKqiDXWKEuJRMP64k9xSXNKOvY+bgKl7L13XFBKm/05vAPkd2Sx1hrCUtsG+hJQqPqakBBpLjd03iImv+NRLLZpvC4XeXOORs7vj6pbAU0Lgko7Wmn69QfY/hhZNJAffFNfwPMJVvX3qK3C/KqRLx7tc66vH7bgSLh2RvAUeuTPFvqG9mC0MzrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZT7Y1yYeLqvm+C+urzsNdo7G1H7VMCMr7GrpKbgyWN8=;
 b=xI3+FsGZFNf9F8HbrhLG/8bW+DSGAbw53RyxhvL2ouCX6NyzWtp2YJY623YLAJk78nsk92d243g1wykutMO+iC1d8DLFNrYEgLcWSujuzF+uYMYdZrtN3hzqxJmJoKnmLp7rw8pCY9In6KxIXZkQO4nsVMIdsBzrBmgtKlZy/SYV4H21MkKtl76NUd8U3OlTjhKiCIcxBaWVMy9wOZKvLcS75LbLxxBqjnVCIXl1E50RV6AXjyQs/M/CRZNbdEXTDwWwDL2ccoYEHkn4dRvM5rI3b2aTt8EsX26BTxuBYfIkZzmS1JTzTZ2CuzkSs8xW3L6spS4a/WKsbHZKQ5M5og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZT7Y1yYeLqvm+C+urzsNdo7G1H7VMCMr7GrpKbgyWN8=;
 b=COAuUj50+UFPposDWr1Nn4fvngn0IqH5qhglE6Ph77wq+e8oaErLEe1kYdn2gUIac+pauO1waJqEcD+iaV9YBjYD6tAbhDRpUretwo354qp+V+czMrhOQeU9LsAux6XZPQFeau9qntjJ1hjS529YbNx5DJwUCDDXvauncLPHTKWh3XHjXrhmexh6vkHajkgAdSBDtou6Sao1DybCT8vTk5D4C5LpxnsiJREIOSc/EfOjWCPaUaPBTjOpE7so+Kv9lkcMx0Lvba986kPzvhG1mFbzPwlbyQU3JH8wzka0FEVNlBu3T7lOzHrltWe8BdAHjvFJAVzGyLxENP98p4u9kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3146.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:11b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.11; Sat, 9 Nov
 2024 09:19:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8137.018; Sat, 9 Nov 2024
 09:19:16 +0000
Message-ID: <5fc8bf39-148e-4c0f-8ab9-cba665ed3bfb@siemens.com>
Date: Sat, 9 Nov 2024 10:19:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: rti: support SPL (or re-start)
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>, u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>
References: <20241108211506.1348528-1-alexander.sverdlin@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20241108211506.1348528-1-alexander.sverdlin@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3146:EE_
X-MS-Office365-Filtering-Correlation-Id: 54f4ab75-f6c5-4111-afd0-08dd009f951f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eVJCWXBPcmJ1TTczVHZkdnY5VHJGZEtCVmIrQ3VOeFRDeVoyODFtZ3JuekFr?=
 =?utf-8?B?YVpDK2lQRW5QOVN5U1R2cGxJNjB1dmdWdlBrb0dBZTVQNGdPcnl3ZEttVldI?=
 =?utf-8?B?MmVaWEdQVFlheXNmTGZQL1lEVWY3NDR2TEV4RzVWQ01zRU9mOWJhdkxHQnV2?=
 =?utf-8?B?UjFjUFRUK0Y5WDRJSm41bTdhRkk2anNyRnhKYlh4T2hPOTJmUTVIMzdUT1dH?=
 =?utf-8?B?cHBTOUxVV21CdWtaTFQzbC9VUjk5bXBiYmtSbTJwVWx3eHFoTVIwVXE1Vm54?=
 =?utf-8?B?NTBNd1NXbHdDeGUyckQ0MmJCb2F5dXVobVhORCs1S2FDSy90SWtqRTE1V0NQ?=
 =?utf-8?B?T3IrRE5xNTcvT1NBZ0VlVDNITjduekp1TFpzR01SeGNzT00rM2IzdHM1c1Fs?=
 =?utf-8?B?OXowR3h4aVJ5anBuTU9FQzB4anQxQ1ZsTHhpTFU3aTBhQTBnbHZ3MGNvL05s?=
 =?utf-8?B?eVFBUnp2UFFsb2EySmhMME5GWmV5QVcwRDlXYXVEL0Znby84RkNPS2hSeUZw?=
 =?utf-8?B?WVo1a0pPR21xa0oyVEQyK1FEN255VDgwR09Kb29tTDIwanY5QUFvUndLcllj?=
 =?utf-8?B?T2VLNFlVSVpMZll4am1UN2FzeHYwTVFuSnJoaWZ4dVk4Ylp0YlAwb2QrbXg1?=
 =?utf-8?B?aFpZRmZNblBRYUxJdy9MaUpoVEl6d1ZqNlVodVorNU42aTcxUzNEWFFocDJG?=
 =?utf-8?B?OW9RV2djTm9NSzBMNmNzYXRxUDlGVVFoemoyOGhZTEdBQ0NUdXNjQlFrRkpY?=
 =?utf-8?B?dTlXemRiSmh3WmtWV1pVUTRyQTU0a0JqMlBldW1ETklId3kvdDd4VEpWZStD?=
 =?utf-8?B?b2w4N3VpQ1k0elAzeDB0byt6aWxSckZMMllpNlp1OTE5ZFp1S2dJZ0ZTV01o?=
 =?utf-8?B?MUtTZXpsTE4xQkFxTUViRGxBSGJXQ1ZSYkNXWm5BU1JWaXNqVDhPbGkxQnJp?=
 =?utf-8?B?bGFSelJLM0p3QysxaUxiNG8xZngvVENhYjVST3lESVdYVzBhcklma0VpOTI0?=
 =?utf-8?B?TmJWc0VnMmFzN29TZ3oxa3FlT1JWK1FpOUJ4VCs1SkZlOVlsbjV4cmxSK1hJ?=
 =?utf-8?B?MlRKdDBHNHgvTk9QNVpOdmZaekhZMmFETjFEcEU3cUtXODR4UXprYmpYWDhh?=
 =?utf-8?B?YkxoV1BPRWM5Y0RjTmxFMS9iRFVKanRvWkhKSzQ3VDRscFZRYjRiLzJZdzRM?=
 =?utf-8?B?MGo4L2ZEWWU5alJJNUNheVY4cTB3VkFBWTY4QUowVmJJNC9ibTQrZENjaGZu?=
 =?utf-8?B?SFJTblpwYnZGM2REcTFlc0tFcnY3Z0d2NXlYajh0Y3RXZjJRc2wxNEw2UkNP?=
 =?utf-8?B?OVBlZ2VOaUlpSW1ZRjlTWmdkTUVBNWJ1enRua0NqdGNYeWR5U25EdkYvckVy?=
 =?utf-8?B?OSttK3VubVlaV1ZaVE9ZRklMa0YyVmgwb28rSkdXa0ZvNHFEc3ZPWlhKbW1V?=
 =?utf-8?B?RnV5cWlpMFBnV1N0aHBWZUZkTG1OWnVDUlhqVExCWmtMbVVYU3hpQkE1MUhn?=
 =?utf-8?B?RlNONWNBejZ4VEFrdVVlekhTUGpMbzNOaHpEZEsrQngzQjdPTGhPV2Y1TkND?=
 =?utf-8?B?ZGUzZTBRTVhTUEFiTzlpdjdTVFI1T2VVTzRUWGJDZkhBd1R2MWIwQVFwbU4w?=
 =?utf-8?B?ZjVuMklKcEluM3p6bnhycDArdk9INTNpeE4zUXZjdk10eVU1SlFMSExranJV?=
 =?utf-8?B?UDF5eVJPby9kWkoyL0lEbENnR0dqTzhMVFFxQ29ZeUJhcGdtMDlENUtuaEVV?=
 =?utf-8?Q?I7zp3JyOHWIF7YFlfg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MG1NVlFxdEIwajZzbHRzTFFGdS8wc2hIcDNiMG1iSitzSnlwN3Z5STJlMDM4?=
 =?utf-8?B?Y3A5OHdoUEh1dEZPZVVxa1pIMVdQR1BQQlpESUN0VXdlU2FWRFExaDZLWm5k?=
 =?utf-8?B?MnFkVzd5RlZneEpFd1E1enBqZWEyN1FOc2ZCWjJPdHlsQ0QzNVZ6YjQwSnhZ?=
 =?utf-8?B?NkUvMUtmRkVzL1FjdkhHQVBndE8zM05qcFVsRytMb1BGMndObHk4dzMyZFNk?=
 =?utf-8?B?SkFNVFhmYjBwZGtvNVU1TlAzRzUyT2ExQUxmcVU1WHFwVXo1bURscXpDYU96?=
 =?utf-8?B?UHJ5NHdJdWxzVExuOC9Uazk4NzdJSzJCQVY0clYzMTFsZzJDVGlmYW5ncXA3?=
 =?utf-8?B?dzlzM2hPZ2hCaDI5eDNmYTgrdGxzRlhadFJORi9zaERpYmZ6SStmRE4xRCts?=
 =?utf-8?B?TGh4bWJYRzN2K0NBVk9zem9sK2g0K2hBc2pSWE1xTWRyRHhwNmdHbEtSZXhL?=
 =?utf-8?B?NGdtR2t5ZVNZazNUc1p5cldjelVDZmY0TVlhV2JrLzRQb3d1d0lyWGk2d1lX?=
 =?utf-8?B?bFNlMDZML01rditnTE9mVVAvSEJFL0ZzUkd6ZTAyYm4yZ29zRGdieDdaVGJ5?=
 =?utf-8?B?S216UkF2Qm5PQXlyZ2FjdzkwVjlOMmhQL2Yrcy82TmRYcWtvU1ZGQlJrWjk4?=
 =?utf-8?B?a1pab2ZUbm95dWNha1psbWNEOUtQZDlrdHNpRGplOGdzK2pRL3ExUGpZdy9W?=
 =?utf-8?B?TzdVR2hMVHgrMVExVDVRa3B2MFpHRDh5UkprTHd1a1JQNFJpaFVGUXdST1pw?=
 =?utf-8?B?YUNFelcxdXRtU1JobXFibituZ2lMZEFKdjc5bFVzV3NjLzgxVzZJZTl5YlJm?=
 =?utf-8?B?b0l4c2dnMSttUUxkbmxJMENiM3RtYjdSd2tHaUdUMnhMeVNUbCtCVityYzRa?=
 =?utf-8?B?dlgzQis1NkVndjcxaVNOR2dhc21sU1lGaFR5RWF1TUxGSS9JeDVuS1RlMGdx?=
 =?utf-8?B?UDRWMkFCMElaNVVwTFhsaHlneUNlcE04Nm5LMjhOaEVyVE52aTlUV0I4Szlh?=
 =?utf-8?B?TWhFZnQ2NFhuTzhrUnVnYUh5T3NYSzE2aFJIcjdiSTJrOW84V2gzanVZcjJZ?=
 =?utf-8?B?ODQzL01VT3o4Y2pnMTd0VkJndFcwTGpUWTMyZEJ6ZVFQc0RwSEpTa1EyNUtO?=
 =?utf-8?B?UXBFQ1BmL3p1VEZaQUp5aWF5dmhRVkJzYU1ONWR3Q1dMamc0WEtCcmJ4M0Jt?=
 =?utf-8?B?THRFZjg5Y2JXUEU4b2YzaEpwcm9RRTNpMzNPTE1peHRCbXRhcnF4QzMrV0pY?=
 =?utf-8?B?TTNkYm1SVTVSbndxZ3JkZk1Qb0QxY2VMWWtyOGxWaUtjVEpUWXlXSUJaa2Fq?=
 =?utf-8?B?Yyt2aVZaQWJXaVphNVdZYUtNTEY4d3dzZER4cnBqbVJKcWVmdGhEbWlvTjVP?=
 =?utf-8?B?clRTRlpFcXlEc0JZQkRRU2V6UXlJc0NGcVdFcDhUK053YzExN0NjcldxZWZn?=
 =?utf-8?B?alE5Z2tSUDVBZUFIOVhnaGJtVlRVYlA5VThDZVo0eDkwQXVMNkkxdGVJMGIv?=
 =?utf-8?B?eCswS0t0eUZQUzNFYmllWVlQTkgvQlAwVGdoKytsZGRRN0ZRZmlUckV6NDlL?=
 =?utf-8?B?bHQzMUdtY3lLQXcyWk0rYUtXS2xqYWpFYjNWQ1JwMHQ3TWg0SlBtNHhRT2gx?=
 =?utf-8?B?bDdFc1NaMVVrM3Y2eENrajJGSldYR2ExUm1hZU1XR3dMaGVVVXp1aERYS2hF?=
 =?utf-8?B?TGlWRlh4SE9LdDB6aG5MbzFFV1RTUlpnTjV2cVlVUkZPN2F6dElNbkZ1SVYv?=
 =?utf-8?B?TTJuZzJaM1F4NE12aGRRRlVhSnd4ZEJ5KzVuR1hIT1BSbHdlK2pMMHVMcDZ3?=
 =?utf-8?B?cDdLeTdWc3k1R1M5VytBMi9qWmlBaGRPUlY1R3NWQ09hTnNSOVlTSUZnWXZC?=
 =?utf-8?B?emRKeWttanpXNFh2OTVXYXd6Z0poUHEzOVZRQ04vNVVGdmN3bjZYNzR6elNt?=
 =?utf-8?B?NTA0M3NrbE4yU3hqVXFIZDZwUnNVRXFpT05nZHpOSG10M1RRakV5Z1hzdlVq?=
 =?utf-8?B?VGVrakloRDFGUncxNjljNy9QZVh2RnpPZ3RLYUpDUUZycENtaGtYUHlKY1V6?=
 =?utf-8?B?aWFJR2hkM1JPVTVCRE9xazVZaWorNGY3UnYvTnlhc0JqeGJQMTNyYXFhbDJH?=
 =?utf-8?Q?UuAAV7G91RBA5gmhmyPU5LyCr?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f4ab75-f6c5-4111-afd0-08dd009f951f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2024 09:19:15.9990 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ISIS0WZyoU5IHluFeSGid7vJ19h26FFJsdeMIil2HLUqXs/N8meOMR6Uq2lgFK+rxHrJUfDEJ6rhSylwvEksoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3146
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

On 08.11.24 22:15, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> If the RTI watchdog has been enabled in SPL, enabling it in U-Boot proper
> fails because it can only be enabled once in HW and never stopped. This
> however leads to a situation that wdt_cyclic() watchdog trigger is not
> being started any longer and the WDT fires at some point.

Nothing against this change, just pointing out that, when a watchdog is
supposed to monitor a complete boot, you normally don't want it to be
triggered anymore before that boot is complete, neither from the kernel
(watchdog.handle_boot_enabled=0) nor from U-Boot
(CONFIG_WATCHDOG_AUTOSTART=n + script-based starting, or skip in in
proper when started by SPL). Anything else always comes with the risk of
running into a logically stuck boot that happily pets the watchdog until
eternity - and you have to ask someone to manually reset your device.

> 
> Allow for WDT re-start by not bailing out if the [previously] configured
> period matches the one to be configured.
> 
> Enabling in [A53] SPL has been tested on AM62x-based HW (where [A53] SPL is
> responsible for loading R5 DM firmware and not this driver).
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> ---
>  drivers/watchdog/rti_wdt.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
> index 99168d0cad03..320c5ca19e0a 100644
> --- a/drivers/watchdog/rti_wdt.c
> +++ b/drivers/watchdog/rti_wdt.c
> @@ -131,18 +131,19 @@ static int rti_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
>  	u32 timer_margin;
>  	int ret;
>  
> -	if (readl(priv->regs + RTIDWDCTRL) == WDENABLE_KEY)
> +	timer_margin = timeout_ms * priv->clk_hz / 1000;
> +	timer_margin >>= WDT_PRELOAD_SHIFT;
> +	if (timer_margin > WDT_PRELOAD_MAX)
> +		timer_margin = WDT_PRELOAD_MAX;
> +
> +	if (readl(priv->regs + RTIDWDCTRL) == WDENABLE_KEY &&
> +	    readl(priv->regs + RTIDWDPRLD) != timer_margin)
>  		return -EBUSY;
>  
>  	ret = rti_wdt_load_fw(dev);
>  	if (ret < 0)
>  		return ret;
>  
> -	timer_margin = timeout_ms * priv->clk_hz / 1000;
> -	timer_margin >>= WDT_PRELOAD_SHIFT;
> -	if (timer_margin > WDT_PRELOAD_MAX)
> -		timer_margin = WDT_PRELOAD_MAX;
> -
>  	writel(timer_margin, priv->regs + RTIDWDPRLD);
>  	writel(RTIWWDRX_NMI, priv->regs + RTIWWDRXCTRL);
>  	writel(RTIWWDSIZE_50P, priv->regs + RTIWWDSIZECTRL);

Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>

Jan

-- 
Siemens AG, Technology
Linux Expert Center
