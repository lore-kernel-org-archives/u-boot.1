Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF40CAC5B8
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 14:32:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7297183D0F;
	Mon,  6 Oct 2025 16:32:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="QJDBBhNY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2B3F83D13; Mon,  6 Oct 2025 16:32:47 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8BBC83BD2
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 16:32:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ENb4Mn9DXnagTJ2jXaIQu/iw6D3Cx8Z+TjQxCAWO2B7dP4KlzgGhK3ovNTLhYFWQkUPj3AXM+KXDT+E9NKSXFbsqzHkyKgShImlc9ETxnI3v30UucGUy1tOe3FHhDjWuu4Om077cjvPmqFgh5WmnkkSawHZigpQnHb0gLzA5w0IEai8c2O0cF954zr8zLdji2konAWdeoNID2l3Zu8U1fZz/H8vyxd89BUQgyQzaEZuLT3Oc7ISZK5hs+h2o9ml/ijIoHe2v24WtxGpKydgz80txlxYaclp90QIUKloGjYNtMDhWk6cWdoKtzdYUvDr1aNxXZXxgx1aut0F7c1SpKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xtDPDXCX0FVl4DgTr2dWxBjwfpFdUChSEu9RsNK0D0=;
 b=Ix2s+IprDve+BrfiyjX7BB+fe0RRaQ7b8S7NjSGAjgo1N4Uexqne0Awg6owZLa9QytGKhv4A3uD7tnz2WUcnL7/pkKLH5+dxXbrAIQAsjtDcYvrRECWq7UZcpDl8dCXRKhwtMTkdTHXZ0Em05e+fFJq0DYQ8AWdiqSBayiLylUChijXwglLZGjVDot8v2kXd/rGuhm6Y25PyQ1WVl1po0xKxrE5SA30apaTcud2N/dj/ZDlBbiImqrpyoknUmRi9N5dfRCU4ez9Lwx05/vpVCzREltKFekOn31MB2iO+f+oe5OPdjMtGb+bR/E68PNvOdeF3Xw5Jhf7CX5D8t0IekQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xtDPDXCX0FVl4DgTr2dWxBjwfpFdUChSEu9RsNK0D0=;
 b=QJDBBhNYGuozphwjtyTP+22NluBfWUfKKKRbaPfgIJkD45o9q8tLMwvKxNwScvXFDz62hHdAaPlM9R1+3LSkDpfR8QfwSSz94mq2SL0rKAEUxN8UC5L9iU2qYNdYTNtjear+29zgdelpXNoyN0HQLIw1A0KuUT7tYDFGtIs+ALI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB8788.eurprd04.prod.outlook.com (2603:10a6:20b:42f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 14:32:40 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 14:32:40 +0000
Message-ID: <8a8c818d-c4cc-42d4-b0ef-0c9ec8f565b0@cherry.de>
Date: Mon, 6 Oct 2025 16:32:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/squashfs: Ensure memory is freed by using unwind goto
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, u-boot@lists.denx.de
Cc: Joao Marcos Costa <jmcosta944@gmail.com>, Tom Rini <trini@konsulko.com>,
 Andrea della Porta <andrea.porta@suse.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20251002-fs_squashfs-v1-1-d72e624dd056@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251002-fs_squashfs-v1-1-d72e624dd056@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::7) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB8788:EE_
X-MS-Office365-Filtering-Correlation-Id: ec8cc5a1-7380-45fa-79c8-08de04e533ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXR0cTJzVEZ5SWZjY2J3TVFCNmZlWTNPaDA1bmtPRUgweGp6YUJMSHJEdktt?=
 =?utf-8?B?U0xjWlhRRG1zMUkyM3pxQUpZamFOTnE4Wk5NdTZUSE1YUzFnYXAwdnNwQjJT?=
 =?utf-8?B?eERJb2RLMUN6cDhCcmh3TGZLNTlwdEh2bjkybG1wUHRYT3dDSEIwVHk4a1g4?=
 =?utf-8?B?by9XNkcvQjFpMGpIdGE3a0p4Um44bWtmbXNxOHJCS0doUXJleDNDenN6Q1pn?=
 =?utf-8?B?Zjk5QXFpczhIK2luZVRRWmNGakppNnZONnJrUkNXT3RnVjgwMXBOamF0ZkNQ?=
 =?utf-8?B?UE1VMWNiMGJtTlRhRENNMk1uK05ETmIrNHlYVU5QU240bktMdDFIOUZSelBM?=
 =?utf-8?B?cG9hZTdNT1lqTVo0ZHZsYUZ0SkNBMGRLWVhOUmlESTc0eVhhVVVVOXZmakdk?=
 =?utf-8?B?d1hrSVFISVIrYkVJVldzL0Q0Nkx2UHR3S05kMTRWRzd5ZWdyMVBoYjhDOU9P?=
 =?utf-8?B?eWRtYVpSakR3Z0FDQWZGdTBBRkR4TUZVYmp4Ynh1czdwWlQrQWpGU3RUY09r?=
 =?utf-8?B?UEcxS2xMdDYyblRqOGljZmZYRjVlTldDOUdDMVRmR3NPTmJnbXBZV3NGTTlF?=
 =?utf-8?B?eHRzTGpZaXJTcEpaNHRybEdKb0IvaTZUUFdXMURZODNMd2tUaEUySFlqN3pw?=
 =?utf-8?B?c1d5dUFUT2FYY0ovczllWlBHMVZtYWRIYTI5ZEg3V1pLN3VFTnd1SjR5L291?=
 =?utf-8?B?cWVVL1J3WnQ4ZzJnL1pFNzhRUkJIN2tGdnVzU0RxNkUyQ0Z6SWpnVGNrSmds?=
 =?utf-8?B?OGh1anZjZm1kOUlSN1JHcU41UlZBWmlJenl3V29uK1A2KzNlTnZZaytGOXhz?=
 =?utf-8?B?RndXcWYxbGhUMlc2R1NlcE5IWEk0VWxIeXhVWnREcjF5eFo4aDBPYytEWkV4?=
 =?utf-8?B?dVZESWNBN1c1M3RKRklha1RRQUpTdU9xQVFSZVg4TXhQcHEyR3ZGc1ZkMFJR?=
 =?utf-8?B?VEtxdlVYUnNZYjJybEF0YXV1eUpRZmtEbWFSRlBUMjBWSHo1K3FIVkE2ckI0?=
 =?utf-8?B?K1hnQVBRWE1HZnlTMm9pYk8vZm5HbythOXRRd1BmR29sM0NKbFJFbFFnRHVK?=
 =?utf-8?B?WUhZRGlNczFqekZWZmQ2cWluc1pCSnBISjloaVNvcmd3KzlnSDRNOTEzNkNQ?=
 =?utf-8?B?Ulo2a3pObGI2M1F3eThVK3piOEZ4ZURWSEZVY2N2MzI1N0o5NWRmNkJWaXZt?=
 =?utf-8?B?Z1EzbjNYY204LzZlOWZNai9adVVKWU8rQ0prVGZ5QzI0KzFQMFdlZThUNHlN?=
 =?utf-8?B?MWc2c3BiL1hLTStTNzRkN1hDRWxKMTRvQnIzbTNnRFlYUVJENUYzdjlmKzJE?=
 =?utf-8?B?RUFQTm5GYUI2dVdBSk9wSnA1YTRlRXNJRUZSUE1JM254WGNFbzlaRVdScmRZ?=
 =?utf-8?B?WWp5aGpXUlA5ZXJaWGw0eFNTQWtibjFQS3dZTUtjZmJvODYyN3pwYVRDa2pk?=
 =?utf-8?B?YTdOTjNOZG5oZFNNL21FaXVWa21YL3FteHRxZFpZZzNNcDFjaVRXdFRTS3Bk?=
 =?utf-8?B?NitTV09sbVNKbk5zcE5VcHNlYlU2dWQ4cll1UzJ6eE1NbFZKYjJHSWYyekty?=
 =?utf-8?B?bU9GUUk0b2dHREJBRmVHSlFvNFNucVZqcklMQjZMQVg0T3A0L1VuODVXRE9z?=
 =?utf-8?B?NTB3dlhKWWU5dWdnTzhzVWpTQWpyZ0ZQV0k2ZlBtamoxRzRjbDBEUi8xNkdk?=
 =?utf-8?B?ejMwTlFkcytuRlQ4dEVYbDlOOEQydFRsYmNSS2NRdTUxZjl3VzdIazNpTUxx?=
 =?utf-8?B?Yno5ajdyT3NMN2FvQjZad3l2SmJjWkllSFZlTTdiVmhwTHhCOUdoZU5ONlM0?=
 =?utf-8?B?K1NJQkJpZVpjam5adVI2SDYvVlg2elUzWDFLNTdWd2F2Z291WldUY09GSTht?=
 =?utf-8?B?TWUrRjNJR2xLS21Ta0lOeVI1dWVHV3dXYnVXNzlHcVAyRmV0Vlc1TmE0cjlJ?=
 =?utf-8?Q?/edb63maqipl3a49lgnHqdbkoEvv5AqI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXZvOSt3aHMwRU1laURNZkRueElLY0ZjY21KdndKRk8ySVBuQkJiRXdTdUFG?=
 =?utf-8?B?SVJab205Y0N0bHMzV0RZSXVyb2V2dGkzdkZwQllpSk80djRNOU9FZE5qeUZB?=
 =?utf-8?B?Q0pPd3VGOEtEanpuKzV4UHkwbGJrR0VOQWVzSU00a0REcHlWdGQ2UldMNWNP?=
 =?utf-8?B?NjBFb1NHU3BFTitsK2VZbHplVTRTMWtmdGxXRWdWOERPWmFCd05USEZtVGt5?=
 =?utf-8?B?YWFlNHlielNtS3FYcCt5OFZiOGxpbS9PalRuUlRRM2xRYSs3TktjcENIaWRn?=
 =?utf-8?B?N2pVOHdOSHFhQ0ppVUpIL2ZteEJJMU5ybkRBa1Z6dm9SOVpuSHNjTGRRQ05J?=
 =?utf-8?B?WStKNTlITUEwRzFORVZHTXN5V3lNV1ZiaCsvL0VtejlTRXB6Ri9ndFVKWEdG?=
 =?utf-8?B?YjFKK25PTFlSbnBzTE83bzJkQnNsSUxWZ2s4ZXVFOU8wbWh6OEJvZ1VUeUlE?=
 =?utf-8?B?NHVRT0tZUWIvWnNMQnZISGZzeVJEUFJmaE5BRnJvK05vMC9jUklqQ01HOHpD?=
 =?utf-8?B?TjhnajJLbVdUd3RZMUFtVmtkWlh0dVhLeVlyUG9Oa01NeTBkVDRRSFJFSFkv?=
 =?utf-8?B?WW9za3JBa05pRUcxazhmN1lGdWF1a3RhaWFESS9RTlNOdkFtRGJWRHhGc1VC?=
 =?utf-8?B?SkNzWTRMRXc4TnphMU9jUXVyTFJzdWIxdVFCbmtjVWVTTHl3dXEwK0lNa1Vz?=
 =?utf-8?B?N1d4dDVmUWcxU1ZjcExWbFpGS21CWVhHc1cyNmgwV1VKZ3ZoVjhFUWx3UDNs?=
 =?utf-8?B?bHE4cTcyTXRERUpKZjRPa28wTjgyRzkva0JyQ2U4cnN6aGg5MGdhbW1SbVpT?=
 =?utf-8?B?M3hxREdSNERQdFp1ODY4TVNsRXNyb0JsK3BtckVNUjh0VU1pSWc1c0NiaTZL?=
 =?utf-8?B?SDdxNk1KVXJUR0FDOEFJdGNtd3hEU0FRNmVCcEpzbFRwM3hIRXlFUVY4TDFF?=
 =?utf-8?B?aXZ2VzcvdmxBeW9HOUIvT0JGZHcwWTVvd2VQRFVmWkNqKzM4cTlFUGFZZDNJ?=
 =?utf-8?B?ekExWWtmbmhTbmxDUHdqRGxsLzgzdmJGbjdQem0xelBrdStKdThQbTNXdHlZ?=
 =?utf-8?B?aGRPcnpzaGQ4UWN3bWs1NDdRbzFIMWFTMkJyZkN5NGFnNjkwQ0NBSkxWWUZz?=
 =?utf-8?B?Z1ptVmRLOXFGWWdPbnZHeWFWZ3JnelNNNW9wREM5QVlZaXdmcW1uNENXSTcr?=
 =?utf-8?B?QVJZK3ZQN3Rram5rRDJ4SnkvMkFlNGJPNFpQa04xKzhQa0VoSm9BbTZjc3d3?=
 =?utf-8?B?b3QweDUzK0s4bzg3V2FRbGUxZTVpT1BPeWVaTGttaEN2U1ExOHRuSHQzS3Vh?=
 =?utf-8?B?QWF6NDA5RG90MFo4TU5lRFJrT1ZyMjVFUG05Wm9RTngzd3RTWW05SGI2Y1gz?=
 =?utf-8?B?eWsyZytMdm03QjFPWHIvZFNZSW96Y01HZ0p0R2NEbEJ2SzNORzNkQVowYTRH?=
 =?utf-8?B?TFpqSEUvcVRscnhvMEIrYWt5dEZoTk5iS25LRHdJTjZmSFZBakhEMTd5MG9O?=
 =?utf-8?B?N202R0NBQWQ1U3RONmlzNG9yRlJnNXRsTk5nS1kzMDJTQlcxWVJHdC96OW1o?=
 =?utf-8?B?R25rdEI4WDFqWlZjbzBvbnhjRVBSWTV3K1pFOFVLNGhmT0w4aFhWdVY4dEs3?=
 =?utf-8?B?cDRWclBvNEhERXoxbXl6UUFnVktrckhXOEJueTQxVVFXNEhwUmNheHZ5cDF4?=
 =?utf-8?B?Ryt1OHVjWnNFbHRlMEgzYS96TCtYMGhVZFNQT3Fqc09Qa3ZKRXpiNmlJakUv?=
 =?utf-8?B?VlE3c1lxMGRyRGdxdkQ2SWZ4b2tlSURHeisvQW1ITEw1aGxoNjZYY2tKVW1j?=
 =?utf-8?B?STlkOXA5UkMvblhtd0Z1UFFKaDBDVlBZQkFESGdnRGdWb0J3YmhWMnI4Wk45?=
 =?utf-8?B?dmhrWDE4MXYwQlRlUVhNaWNmck1VRUVuUTB2N3RPeERhdXY3eXBjaVczZGl3?=
 =?utf-8?B?c2E1TDBIZlZZc2dpTWpyZWM1UmExQitsa1V4d2diWDhTalVFa3hxRmZZWk1C?=
 =?utf-8?B?cE9keTg5NDBZaUU1Y0M5ZkpaK1ltUC9tdGVsZFNKa3lVV2o0ZE9ZUjk2K09n?=
 =?utf-8?B?YWVMTENlUGlnOVo4VEY3S0xNbjQ5VmxONVhxa0JtRldmcGpsRFhWUE9JTllw?=
 =?utf-8?B?YkpSd0V2bmVNOHNudlVqblh5TzRYNmRiVUJldGFSVVdobnNVSTV1Wit3aEdU?=
 =?utf-8?B?RWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ec8cc5a1-7380-45fa-79c8-08de04e533ec
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 14:32:40.0250 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ktmhrg6q3rEX6rETUOR/f84cwDaGuUEUacOtWUJ5aHSf/LnkqPhoZdumrgCDL+0z95ed1ph61icd1Lqhu9RJ1kF/RofWyBVj3c1n52+bCF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8788
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

Hi Andrew,

On 10/2/25 12:36 PM, Andrew Goodbody wrote:
> Returning immediately from sqfs_read_nest is not consistent with other
> error checks in this function and can lead to memory leaks. Instead use
> the unwind goto used elsewhere to ensure that the memory is freed.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Acked-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
