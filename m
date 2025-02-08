Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3172C02198
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 12:23:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16B4680805;
	Sat,  8 Feb 2025 13:22:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="j2LmYVHr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EC2F80819; Sat,  8 Feb 2025 13:22:58 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20703.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::703])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B5AE80756
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 13:22:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josua@solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aXZ59Cwex1aCDNBmZIZ554SJ990VrvZDVwerQhyeq35jlWsIkVUApVU8w3gskwZvbgGzEJzeIAUCdwR+jpbl1XV+BRKgYJgXOGNdoM1Ybh8I3+m+QvSJ3zWpPMPiSOWc6El61UYaCdEUY1FS0cbQwQcMI/bYKJcSbV4WNnBkDKQzQ6tw42sDiO3bwr6tILhjTbNyZly71vOKgPWQ4txwXn5xQukQLS9SxwkzWXnfCDa6EuhEGNMTS07pqrjUgA1axvZn9ILgz95p2ptNQ3fMeaJNCDlJjh6bUmzewZpdpGonWPhTG/G/puYl0GteqlQNCnfODf7G6ajhfgtLAwW9SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIGxWMBGMHKiArjvqj630AxUjRoli9bj86oV8mPwb2s=;
 b=tR5yqKqG7GhJwjGgFdT/idX8M0MAWj93bIN9rMhUjO7yWAV65QHAdwnoKZj8JfbGiTC0K/rEpef3LlDAX7m82T8S279IVPFCAot7qPjOkhlHnUplhAFxw9WcoRkHG5xvm5Pj9y/fh9HZ9YbbwZbAWVUvQvOY+gqXbKnzlved97wyvBoz4OhBuETcUkvMVm3J9RWl1x1r/h46d8M7H+cPHgXOyRBUvK7c2DGlHGOOBgWNfB+pfRhr02kSEqaJ8kOXNi6OU48tHjQmdC72FmmI9Zi2eUEw35ERYYutoKjPr1xrJLtlXW3WmZ5JjepXhCXdhqCvQFl4/BjGbyBp3IctRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIGxWMBGMHKiArjvqj630AxUjRoli9bj86oV8mPwb2s=;
 b=j2LmYVHrotcxRNf8rWnE8v70yqJw/NVJtRM7P4TuCJudknm/Ma1W7HJYbI/AseV1Z+0XKpUAbFcwCTw6nKYplpEO00zQT5S2A0EAVZgunajDClUBWGEuPFj/bn4T0D4N3VSvlQlFkFNUTzVH6uKrDekkgir5g7pgl1Toq+iJZKc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AS8PR04MB7815.eurprd04.prod.outlook.com (2603:10a6:20b:28a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Sat, 8 Feb
 2025 12:22:53 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%6]) with mapi id 15.20.8422.012; Sat, 8 Feb 2025
 12:22:53 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sat, 08 Feb 2025 13:22:43 +0100
Subject: [PATCH v2] configs: clearfog,helios4: disable sdhci sdma
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250208-a388-kerneladdr-v2-1-17c01313eba2@solid-run.com>
X-B4-Tracking: v=1; b=H4sIAJJMp2cC/2WNwQ6CMBBEf4Xs2Rq6Ba2e/A/DodBFNmJrtko0h
 H+3kngyc3qTzJsZEglTgmMxg9DEiWPIgJsCusGFCyn2mQFLrEss98oZa9WVJNDovBeFpjK2bU2
 Fuoa8ugv1/FqN5ybzwOkR5b0eTPrb/lz2zzVplUP+oPtdhR36U4ojeyXPsO3iDZplWT6tZ9pYs
 gAAAA==
X-Change-ID: 20250207-a388-kerneladdr-23438bb34215
To: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>, 
 Dennis Gilmore <dgilmore@redhat.com>
Cc: u-boot@lists.denx.de, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: FR4P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::20) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|AS8PR04MB7815:EE_
X-MS-Office365-Filtering-Correlation-Id: e7d4e3d5-b945-481c-c709-08dd483b4fad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RlZxa2o3b1dDaDhkenU1YXdHZXVmb2V3a29YOHVKL0ZOM2FOckpDTFBiQXVZ?=
 =?utf-8?B?bS9YT1BkYU9uZE1sWHpBSUdOZVVNZ3RzQ0haVWYyK2VsaWFOQjRHZUVsNkpx?=
 =?utf-8?B?emZFQysydEc5TmQ0ZnB2V3R5MlBxczRzVGFQTC83ZTNMTUdEbG9VZHF4MEpE?=
 =?utf-8?B?Vy9sSzBLVDIvNkU4WVdEdVExUUsxSGpkWHJyOUFvY2ZwaXNYdXJ3bWJ0Z2pp?=
 =?utf-8?B?VTV0cCsxTHZlZ3BCY3kxMUlxbmZFUmE3MldlS1hmM3NBQ05QZ0EzTCtzU0dP?=
 =?utf-8?B?TTl4M3JBNFNoaUlrelNNR3ZYNmlLMUxMQUpVbGtLODlWMTJYMkdhQk4xbnlJ?=
 =?utf-8?B?dmQ3cnZTcFRDSkVnbGpUVXNtSnJ2bndZZkZtQjcrMWNDUlE2eUNjUExWSGRW?=
 =?utf-8?B?RzNralI0QVdyVVlEdFRGc3EvK3hJV05MSGl0K29vS0xmNFc4UTJsRVpEUWo4?=
 =?utf-8?B?RER2Zkw5aFU5OUVwbUlVN3JKZlg1MGxQaEdkL0lyVnpUSGE2ZkczUkczVmp6?=
 =?utf-8?B?SVFudGVJQWpveFR2RHRqbVVZRGI1NExtMnAwdVdndWJXZXY3b0Q5OHlPT2Iz?=
 =?utf-8?B?Mnl4a0IzL1NvUGRjTWdKcVdsRWUrTnpxS3prNkFIU2lsMDFHY1NtaFRPYWl4?=
 =?utf-8?B?dUsvL1hBcDNHelNSK0I0aUEyc2h6SklrUE5HdEZOOVlqYkZhdnh6N2dWNk9X?=
 =?utf-8?B?ekZHc1R5K1hnUzlOQXFEOFJZYWlRaXgwS0pHWk9UZTVqNWVZUnlPMmtDd3Vp?=
 =?utf-8?B?K2d1V0F0cGxTQ3ErSExodjhHZmIyNE51K20xRGJXZjJnbmlPenNYTndTZjNy?=
 =?utf-8?B?VEk3SllEa1djYW1UUFhERktrQXRpUE9oaGhkYTZteUxtY2h5dk1scHg2eWhp?=
 =?utf-8?B?WUVpMXNxajdtRERsL1l1TTBkQmxacndXUkFGNit6TkNPbXpSSjVKWFZGekF6?=
 =?utf-8?B?SlptaldJdzd6cUtZL0M5cmpWNUxUd3RlQ2hzVTk0NERTWVlBNHRBcnlCTUtK?=
 =?utf-8?B?b1R2YTgxTXVabTg4U3BqWi9ZVkhJNmpaSUdZOTk4TC9PV0dGck5JeHc2QU8r?=
 =?utf-8?B?MTAwTi9RMi96bE5YNUlFbmFQTjNIVnZzcEMwRUtPUXpmc3EvRWhxdTF4aFlW?=
 =?utf-8?B?Ymp3UThseFpCTlV5WWdLSXAvVHF5dnJtYituWWV1MklCYStINXJ4eTJ4Qmky?=
 =?utf-8?B?dEVFbWFSK21qVHNqbUlXcktqQk55eGRxZ0NWbllzVHVYdEZIYmlzSWxqK3Jh?=
 =?utf-8?B?bGV1N0szbXdZc2MveWpkUkVibDBNMzNGZzFYRElobEV3Qk0rckpVTFBlMWx3?=
 =?utf-8?B?eExmOGhURWF2MExEQll4Y3dLTUtwVmczZmdlc3Q2K2xvU2R5TlllYmV3YWpH?=
 =?utf-8?B?SnE3enRuK3Y5RGFEbkhjbEkvbFdLVUNCUWtTcVhkOFVSMGl2R0UrNlFqKyta?=
 =?utf-8?B?Zmg3VjlmVS9zWjBQU0x6bDZuemZ2a05aUSttcE5JZ05sbnhjU1NEakloNERa?=
 =?utf-8?B?a3FHcURRNnBROFZxQkkzUnc1N1drNE9kL0RHSkNObUdFd3UyeTYrMEFMd3gy?=
 =?utf-8?B?c2JRb3pReloyYXlSYStQelBOWnE2Y3RUQTBnQlVGdXFjcUpJYmFvZVREa3hp?=
 =?utf-8?B?M0EySEwvMkJlRkQycXVhVTRKb1h6b29IQ2pxV1JQcXp2NnYydExnR3NxWkxJ?=
 =?utf-8?B?Z3VYd3IvclBINkdiMFpzYWJNRHhWTm55TFY2Lzg2ZmtObTNaWjRkR0FwRU1Y?=
 =?utf-8?B?Z0UvcGRvenEySzRvUFUrQ3pJYk5zWVZTLzkxbHlSV29TbEUyUXZUc25wQ0Yv?=
 =?utf-8?B?VjBiREN3diswTTRBRUFtc0FWeDhDNGJWYXcwM0IzT2tlS2N4RnpHU1VFTkVW?=
 =?utf-8?B?K0RwOTk0a0ZwZVhtaW8wN08vOWFZQnZ6bTBRTmVLSXpUMjBPWmtaYmZnN2ZG?=
 =?utf-8?Q?0ezK3i08zpBDZBvfgWaupbIzwP+6mJ8k?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB7586.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUNEUkhSVmlpTTFWSmVXKzRJTXRaWEtzSTRwTTBVNSsxZFRTTXVTOWFxemdx?=
 =?utf-8?B?RTRKVDJkTlhxM0J6UnBDZHhYejdmNkJwbWtQbWpnSjJmVm1zcFV1YmZRRkhm?=
 =?utf-8?B?Z0JaZXY1R011M0U4MXRQSVVraVFlTGpSSDY1MW83cUJueDNLSjJ1R2dlaHJI?=
 =?utf-8?B?NEdxU05IdzBFa004cXF0c2ZSNVhtb2NTbDVQZFN3anNKYjNUSXUrdjl0Tmha?=
 =?utf-8?B?SHVUU0JQcEpMeWFoamR2TWNiUHVzVWgrMlQ2eGpROGFkVFZKZXZmYXVLckd1?=
 =?utf-8?B?MnR4SmdhelRkcHZPQ2N6cFBkeHdYejVNaWF4LytHWTRRTTBLaTIwVXd4MDJR?=
 =?utf-8?B?dThBa1hvUGdqZDY3UTNUUWhZdTdMYU0xVlcxNEpuRm1BRnpDUzRpR1Y0eTky?=
 =?utf-8?B?bTBXSjFLVVhxQnZPcTB1ZUdRWHRXSlUxdzcrdTQ5ZjZKYWlqQ1JEeW9YSVNN?=
 =?utf-8?B?VWdPMTJtK3kzeFB2Q1FKVkpqT0NOZkc5S1BNaDB1Smc1QlVuMkpwdmRDQmpR?=
 =?utf-8?B?K2dTSG4vd1gyanFVVXRITmwzRjU1ckJ5SmF0bEl2cmdSOG1hSytjeGxyMDRp?=
 =?utf-8?B?TDBZbVZRWUtGWVdLcVpSNFpmNC9qVnVtR1VPVEV5S2J4LysySVZTQ3VhaWJR?=
 =?utf-8?B?Zy8wOE5LQ0oyMXBxZkhzRW80V3pmMnpCOTRqNGxrdGZab0Z0Z29vMkhTc3Ey?=
 =?utf-8?B?aUN1TEMrWklQNTd4dTdGV3FNaEovakdWaVFjaVhON041bU12MXpFNHRBblpO?=
 =?utf-8?B?MmJzU3V1ekxpeG5YTDJ6aVRUdUlaMmN3UFZlRmZjRlU1VmxpR0RjZ1JneDhs?=
 =?utf-8?B?SXFBdmpCNjBDdkwrRkc3aThFV21KK1RWdTNvdG1kMkV4TjNtMWdGaWl5eFgy?=
 =?utf-8?B?WHNaaEhYM2tnSW4rbTVXcG0vRGRCRmUwdG1BY01tTG0wWnE3TmJWZitPL0Rn?=
 =?utf-8?B?QVVVTkdDUkFud3MxdTZlV25CMzV0TUhBOURkMTAyZWo2WEp5QVZnR2o5NG5m?=
 =?utf-8?B?Mm1YOXFHQ0hLYk5QNkY3NFZkbUdYK1ZZaGt0UlBKVDVrejY2RW5QUFA4RDl5?=
 =?utf-8?B?aUtwWUh6SzZCN3U2M2RMZEdQYzZHTVdzQUl4NkpOT2tydjRRdDVqbHc0QXgw?=
 =?utf-8?B?eXJ3YkxyZmNsTDhjUzEwNE1WdXpnZnpscUEwUE5JdTVTdWVGZG1GOGtwZ2Fu?=
 =?utf-8?B?RmZ3b0FaZnNPSjk2N0NrWWFaL2VZSzZmaFJMeThmYWI1VDUzams3cVhWZ3Bo?=
 =?utf-8?B?bWhmUWE0Z1loYXUvcyt5QVlodDN6T29KNGtzakF4TW5YbU81cjlKQUgrUCt6?=
 =?utf-8?B?cTFuUEg2dERmZ25rb1pxOHl6Qllxcm5memFxdU8wdDBkRHNyOHZoWFM2WGFQ?=
 =?utf-8?B?S3h1aHhoY1F2RlM4cnpNbjVyL1AyTnhuR1ZBdVdNL3Rhb3ZLcndqbGFhUTU5?=
 =?utf-8?B?U2oyWU10bkRnVGt5RFZ2b2xwOFNKQWVTSUFMS2dyRFVrMnRMWm92WUlENjQ2?=
 =?utf-8?B?Y0NrQWNReWtDUjdQYWhiZXFoYVZzNWV4UHdLUzNJalJnRVoydk9wa0tTZDgr?=
 =?utf-8?B?dUJRR2dYWFFvZHQ3dVNPZys2MHk5MWl3V3Z4SENlKzdiUlNqUFppZ2E1UWwx?=
 =?utf-8?B?S0FDNElQckh2ZStQYk01SHRFWXNCdHFUSXFLYkhYU2JYMG10dDNBWjArTzNn?=
 =?utf-8?B?WklLWHRpVHhhZFFyQXhTWXpMOGFjWG1iUTJ6Qy9sS1hjbjArTHhGN2psMFhE?=
 =?utf-8?B?L3BHR2hzT3RHYlZlc2pZTVlpRWtvZVdpTFg2WVpCV3JEZUJLTkdHdnNETjkr?=
 =?utf-8?B?RFBVTXIwVVBOL0c0YzdNU3libzVXSzFPd0gxYUJhUHVtVXNuRVdndDhzVU5T?=
 =?utf-8?B?bkRWc0ZBLzRneWQ2amVPUi9waS9Qc0NSNFNIajI0L1ZCdEpxYTU5YTBUU2xU?=
 =?utf-8?B?L05PM2toMUlWVTdBUkVrYkJoOG9VRjFJZVZUaFdkaTNxdUF2WThqdk5XUlVC?=
 =?utf-8?B?Q01rSEk5bWtZTkdNZU5kM2tiMjlYbHlFT1hBRzZ0bUtjZCtJZHdNOUZFZjBS?=
 =?utf-8?B?UEZvTzBBTXZnUk5ON0l3VDN6dkhGMXp2bDJWV1RaMU1xbWsvNlNNLzA3TUlE?=
 =?utf-8?Q?bjeDoywRI3kv0XeYrYbiNmFEU?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d4e3d5-b945-481c-c709-08dd483b4fad
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 12:22:53.4219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8jU9MMVxhK481kQhqOxt8jOhpFEOSEpoSDGZfQpIWqkMV/5RP1WEF026reOR/nMYj+KLC4IWLlJsRP0aMlRVvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7815
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

Testing has shown that loading large initramfs causes data corruption
where the kernel image had been loaded to.
Debian 12 installation using a 17M initramfs boots fine, but the final
system with an initramfs of 27M obscurely fails to boot with bootz
reporting "Bad magic!".
Inspecting kernel_addr_r after this failed boot attempt does show
garbage in place of the expected zimage header.

The problem seems to occur on armada 388 only when sdhci sdma is enabled
in defconfig. Other armada boards such as turris omnia did not enable
the option.

Remove sdhci sdma from defconfig for now as a workaround.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Changes in v2:
- changed *all* a388 clearfog_* defconfig files
- Link to v1: https://lore.kernel.org/r/20250208-a388-kerneladdr-v1-1-1ed91f642c2d@solid-run.com
---
 configs/clearfog_defconfig      | 1 -
 configs/clearfog_sata_defconfig | 1 -
 configs/clearfog_spi_defconfig  | 1 -
 configs/helios4_defconfig       | 1 -
 4 files changed, 4 deletions(-)

diff --git a/configs/clearfog_defconfig b/configs/clearfog_defconfig
index 6f6597c5331f4aadf827b40a8f2864722585fda9..a139d7cb463167f59931fd4a151a309c29ba3a44 100644
--- a/configs/clearfog_defconfig
+++ b/configs/clearfog_defconfig
@@ -60,7 +60,6 @@ CONFIG_SYS_I2C_MVTWSI=y
 CONFIG_I2C_EEPROM=y
 CONFIG_SPL_I2C_EEPROM=y
 CONFIG_MMC_SDHCI=y
-CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_MV=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_MTD=y
diff --git a/configs/clearfog_sata_defconfig b/configs/clearfog_sata_defconfig
index 491a27321f9c52af3bd28da546b7065b0aaf38e0..b927532a8c7e99632aa7c45cb809115be9524e04 100644
--- a/configs/clearfog_sata_defconfig
+++ b/configs/clearfog_sata_defconfig
@@ -61,7 +61,6 @@ CONFIG_I2C_EEPROM=y
 CONFIG_SPL_I2C_EEPROM=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_SDHCI=y
-CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_MV=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_MTD=y
diff --git a/configs/clearfog_spi_defconfig b/configs/clearfog_spi_defconfig
index d3de1657c09ac8afb7655094d88b649f711e36b7..85be40db48536ca153d0dae8eda69532745b5526 100644
--- a/configs/clearfog_spi_defconfig
+++ b/configs/clearfog_spi_defconfig
@@ -61,7 +61,6 @@ CONFIG_I2C_EEPROM=y
 CONFIG_SPL_I2C_EEPROM=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_SDHCI=y
-CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_MV=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_MTD=y
diff --git a/configs/helios4_defconfig b/configs/helios4_defconfig
index 2778cb7dc8680191155582da14a21b6a521fdef1..baf7c9396362fd9f6a8e527e27e8ad75a1fe643e 100644
--- a/configs/helios4_defconfig
+++ b/configs/helios4_defconfig
@@ -60,7 +60,6 @@ CONFIG_SYS_I2C_MVTWSI=y
 CONFIG_I2C_EEPROM=y
 CONFIG_SPL_I2C_EEPROM=y
 CONFIG_MMC_SDHCI=y
-CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_MV=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_MTD=y

---
base-commit: ac3dcb0c2710c4917d93d6d2eb34dbfb00516bc2
change-id: 20250207-a388-kerneladdr-23438bb34215

Best regards,
-- 
Josua Mayer <josua@solid-run.com>

