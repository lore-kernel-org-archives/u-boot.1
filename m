Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4FBC83F09
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 13:01:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D077383123;
	Tue,  8 Jul 2025 15:01:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Fi70S6oi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F1BA83280; Tue,  8 Jul 2025 15:01:08 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::617])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 294DC830B4
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 15:01:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M804dzi/IsPkW71mKaWriJc1IYqWDcFY8CvcUtcyKk7GJFA2+g8ZB1v7SAQTZzYb6y4ZouvMzzBc3Os2LCHDE+XYl2hH93sk38ivEW9hSedTEZr9kAQZBco1ULwYHp4YXuVmeXgh1RPO8TZCCdS1ZPuwVGwjiEjNmFQIDRpmoM2bkz0p+fdS8GfhQIDc4ujz116kzGN57CbPyiqITiIeKNHTitRgbxDJY2EgYnA7PbVgOpe/AgKpeNg2giDdWQAY5ARVPATc6ErLnvdlF/7I/M2qT4zi7MFDe43rdT0bQ6X/+rswWUUruL0HL5+dl0QFJM4eeaE1o7bshp8nkgccqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9DTvMvDsw3UPA9yAVWm6SjYi37Ike6bXJjiHkrJbd5I=;
 b=OUVTh1r9/x8jtUliVpUOhooZ7tW7Oz4l9Iu74Wcob49AUjIr6ZfB9swmeuiNU7imwcifBUFB/t74KEoOU2bzwTS8eweBnnAQ1McNw1Bv9Fi6OAlEu3tv0qFQBuQzUFr9hADajL0l4QP0t/zzHf7JXqZuIzyPxcA/Su9pMdrqg4kTHwtbmrvFFAcMV/6IxTMDSxMe6FvXRAg34I/PjvMgKrNa6N9MWWHVaAYIwKgSHKXuJGK6uq34UqU1KLldtPK+7DUVLCXdYuc+eSF+aONbEhGljbUJt+b2Jkqq4ijMOmMYfnTWqZXK4c2myXBWCBv557LPnBhLaP3chB5MLsyyLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DTvMvDsw3UPA9yAVWm6SjYi37Ike6bXJjiHkrJbd5I=;
 b=Fi70S6oiTYLf0aYSQftbl6OqRM1lbZOcyzk23wmli1+UrPLeaNyXyzaaLQNvnLB3jyQ+oMi23GmTIXD0WbxFVSmHSn7SDpKKBrMFPHiLwv5dVrelurGNgAn2BqJSso/LGEJDyQVb716hASx4MEXUJqRUWwNIxemkLpwJglNAiHg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CY8PR12MB7537.namprd12.prod.outlook.com (2603:10b6:930:94::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Tue, 8 Jul
 2025 13:00:59 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 13:00:58 +0000
Message-ID: <af896fd8-5649-4913-936b-e6fbb82f7087@amd.com>
Date: Tue, 8 Jul 2025 15:00:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] config: versal2: Update timer clock to 100Mhz
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com
References: <20250704090920.678557-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250704090920.678557-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::19) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CY8PR12MB7537:EE_
X-MS-Office365-Filtering-Correlation-Id: 360fa5fb-02d9-48e9-025a-08ddbe1f7bd6
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?elFCcm9RQnVOaDhrU2FkalNVZEtuOFQ4NkdRQlBxNDNaRktIVngyUDNqbkl1?=
 =?utf-8?B?a0RqZEFyYkJKUHFudnZvOVNNMGh5ajdQaHF1MVc0MWRnNmRHeUw5bEZDWWhE?=
 =?utf-8?B?dWF1YURBTEpPODkwdXhIbVFvTlRMZ1hIbmpabzNxY29NUUkrR1FsVmRGSHVN?=
 =?utf-8?B?K21ZVDlkVGl6TXZubFdTT3I5NzNjL0RtVzkrK29RMnNOOWxyK2plUDU5U3pN?=
 =?utf-8?B?WlpNMTZRMXZyYnlHT3JLR0ExUmZzc0pHeHhrdEhOMWJrK2VIb1BPOFV4U29Y?=
 =?utf-8?B?QUtwcXZWN1IyUk5HblFmNXlJUUZlODVWa1FQdmJpTU1kLzN5WFZsUVFRcXA4?=
 =?utf-8?B?UzlqOHBQR3FIeGMwNndJeVJNSWwveml6RGprRVFZS1o5clA0cmlTSGxOUk5n?=
 =?utf-8?B?QW1VcS9QQisxNUg0ZHRIVW41NzdJV0dGMW1EQlRncGtGYUVhNno2VDhqbXUy?=
 =?utf-8?B?dXJqT1Bvb0tPanFHQ29WRHFPeUwxc2Vxa0dmNzc4V3N6UWNWczl0ZytHR3o2?=
 =?utf-8?B?UVFXS1ZjeThuY0p6NVdVT05ycGU3WlkrY3FTdU00aC92bnA0VGZwdkljdUFm?=
 =?utf-8?B?Q2k3TFNXUjY3T1kxMXdPdTRpVFduRThiRGozekI1T0J3bmxMdE9NblR1UkpO?=
 =?utf-8?B?UU1SbGJzY09ieFp4bGhKb0EzWXlBald4ZEg0c3IvWjYrOXpMMXBVUGpYRk5Y?=
 =?utf-8?B?eHAwTEZjeHAxMFgrQzczZi93eGcxVzY0Z211R1ZwZTFwUG4yKzRLQ0Z2WjJw?=
 =?utf-8?B?ckJib2t2NFFDSytkNEp2VXgyVnQyU0NlNEVVdTZuQWkxOUUyQ3IrRThGbG1m?=
 =?utf-8?B?ZGxSNDNORHZVVzRmVHlGZXRhSTcxNnFORWw1SmNNWGxoRkZwRVJBdVRRakVX?=
 =?utf-8?B?SU80dU9ZN0hEMTdBekVRUGpTSk9iSDcxNVpPZ3BGb2dmajVFK2VpQ2w5TWhM?=
 =?utf-8?B?c3VLMkUvNVlaTkpPUmZmT2N5MmxHaHoyaE92ZHZGSlBvUWF1aEQvbUY4QjNq?=
 =?utf-8?B?M2tmYjI3V3hwWWVrd3FpcDJ1eFhuSENNNGR3eXpkWXhoeFBzem1xUXhSeWZv?=
 =?utf-8?B?d2hvTE5nRU9vcFhiM0xhUzV4Wk9HT2lIQ0RlMlBhd2F4dmh2Njh4bW9LYml2?=
 =?utf-8?B?aURLb3d2aVNXK05OcHQwMWxHQjB3N1BsRk4wUmh4em82MFlwNTk1cyttTFlC?=
 =?utf-8?B?UDlPMmovZ0VtbmJVVmVUTXE5Z3ZBb1NwSVF4ZFJOWGlsSlZGZFhzTkc1Mzgx?=
 =?utf-8?B?T1F6b2M3anoxbDA5QXlUNXNXTmd6MC80em5MeGRBTXd2THlwNmNwUG5LREUz?=
 =?utf-8?B?YUtKN09qWHl3NGQrUGtxZkt3VFF1MGdoVUFES3puK3Q0YXFCYmtNK0hWTGJW?=
 =?utf-8?B?VDVFeWtrTi9jaFhuSmE2M04zcXEyQVlLdHIvME44QVdSL0hnRGRBZm9ZNW5J?=
 =?utf-8?B?UE5oQ3JPMXFHUEcwaW1NMGtJeVRWUjFHaExJTC9mT0JQUU5tMzFmTHFCMlhX?=
 =?utf-8?B?ZFh6L1oxNVdaTTJvelNOcnJFdTlZZWt1WE5zRFJxeDBJWm51S3dCbkFqZ2NS?=
 =?utf-8?B?UWdQOExqNWZMV2doRENaczZSbWt5ajJwYkxCYnhNWVlkSlV4UU1OY3VhTHl2?=
 =?utf-8?B?V1RFanFEcUZ2aVZpVExnS1hNK053SzFTMDY4R0FWZ1MzV1E5b3doSlZMVDhN?=
 =?utf-8?B?M3Rob1dQVTdvYit0WVF3ZS9OWktrUXVXT3Zpd3hpOHFrQnh6UGw1aVFTYXRQ?=
 =?utf-8?B?eW1kalhjQ01NbG9mcHlDekRTT0F5SlRlMThQZjhCa1QzMkxQWWVFREVaQkJs?=
 =?utf-8?B?eTlNdEk3UUMzVGFQS044YkV6alNJczBsNWFmSzl6M0dMd3QwWEJpU3JFajFQ?=
 =?utf-8?B?RWluMmVGQllHZDdYSml2YXdMZXZsbFZSY3M1dE1LVDNua0Z5V2s3YkY0THZX?=
 =?utf-8?Q?5NFOQtz0jcc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkFHNCt5MHhKM0tMZ0FlcWdCeVJ0ajNYRjBQMmxkMDV1SWVzajZWelJLaUdx?=
 =?utf-8?B?ek9ZUDJYRG9qT1UzVkJWVUxJbWFRWGIvZ3gwTURUZzlHNnpEL1hWVThmWGE1?=
 =?utf-8?B?UjhxUXlhdVE1cld3WVR1VHJDUDBUYnI5SUVrdGMvMXdLb2pBTUVROFdUYjE1?=
 =?utf-8?B?M2ZRVmtYSVpMZjRlWS9VZG1oVkplR1N4cVhCQ3hoelh4eXl3NnlvWVV3K3V4?=
 =?utf-8?B?WTRNOVpKQlBZN1lncDJEcUg1cGhkeU9KYkdqUXJ6TzgrVzlMbGphc0pkK0gz?=
 =?utf-8?B?VWR2NE9hRlBPM0VwTWZvbnhUbS8zdWZ4TncvSk1yN3YzdnB1T1ZBaElQcDlT?=
 =?utf-8?B?WVppRVg0OFIwdnZoZFhYcFZOKytIRkhJblhYVnNmNW5EemNlajZ5SVEvYk1C?=
 =?utf-8?B?K2MzT3N0LyttOFhQOHN2elRSR0V6eUJidEVaZ0ZEa3JTaGVUTG15TUJTWGth?=
 =?utf-8?B?QUxEU0dMc1NOQ3NYUUtncmZvYVhUMWVzSFBCc1M3QXlaaTNzWDROTjc3UXJn?=
 =?utf-8?B?Tll3ZEloOWFNbEcrOUNjUGlRNHdYcnFkNzNYY3BBeE54d2M5enl6NXZhSkVZ?=
 =?utf-8?B?SFFJaXF4RUVBUk1jRzJ4eFhwMlFPZTNBT0JvYkhUQVM2YnhTaHF1VVNLcUZT?=
 =?utf-8?B?WitER3ZYdkIvK084ejE4UFdaRXJXblFObG1iVVl2RDBCdGFmcFdyMkhRQnZv?=
 =?utf-8?B?Z0I3anp1NUhyL3B5YTZGM3d3c1IxcUZzSEkvS2dWbjhSYlhmY2xDMmN5bEdC?=
 =?utf-8?B?Q0QveVNhS0lpaUc4a3JoSGpPKytVY1hDV1Y2ZzVpQ0hvVDJNa2RpbWRqWDhG?=
 =?utf-8?B?LzdQcUtDeWxyY1dyRy82b1lZd25ML2pWQmJEV2E2NWg4RDl6NXBFZ2J0Wktw?=
 =?utf-8?B?K211REFiTkJrWldramhRSDFNT3YzekQwVmdrdlRLemlJbWY1U3EwNEo0TmZ0?=
 =?utf-8?B?b08wSGY4TmtyWlpIQjVIdEJiVHVuUlBOb3hkdFF5SnpNRUh2dS9xS0h6L3hC?=
 =?utf-8?B?M1FqQnNRcHBFelF0ak12LzJmekIrTkJyT2RWazN3cEpyUFVvbzNjVG5rdHQ5?=
 =?utf-8?B?a0xJbFVWRndJMHo4L0RoSkZVdk5CeXQ0YnBCQ25pWEV1OGFPOFlTamJNbFlM?=
 =?utf-8?B?TWY1bG1GMVpBT0Nhb04vODAzQnF1aGpxOENTVFRZYWtDa05WbnEzT0FDNEE5?=
 =?utf-8?B?MnRnOXhsYzNTendSQmN6UlNzaDI4elNOWnRYTVJsRGtoT3hPdjZrajNwME5l?=
 =?utf-8?B?UjJXWmtPVmRPeEtFeGQrMzZSVmxTNFYzY2M4d2V3UUxRckxSV1hWVk5jRTdu?=
 =?utf-8?B?OXJFTlhhZmwydW1BME1PWFgwYjhuQ0o0UGdTNTRLQTZwdW5ucFVjTmx1cExI?=
 =?utf-8?B?UG80R0NFandyeE1mQ3k0SThkbEhhL2lRYXlJWXFDZ2ZlRVVIVzFaSTlsUzZp?=
 =?utf-8?B?ZmxVV2hWazZuY0RhK0hsTWJCWnVnR1pYNnJSeUI5aE1WeG52UjN1dDFwOTQ2?=
 =?utf-8?B?VkcrWmM2Zll5aXA2ajgzUGFkOFkzYjZGOXV4RytWY2dET3pYL0NYTklTZVRw?=
 =?utf-8?B?VWJLR0FYK0JFMHZFQjZEK3NLSmd6TTg2VlBwQXY5UnhCMUdwOEo0eXEyRUg5?=
 =?utf-8?B?OFZCeUxnalhHNzRXOUVGUUtTNFMva2toUUIzMUNxakhCbDNrRGIySGpkUGU5?=
 =?utf-8?B?QTR6eXJJM2ZxQVVNMjdScUVaTUVPT05xZTdEUGQ1NmkxRXFzVk04ODM3QXpM?=
 =?utf-8?B?L0d4QkZWTFZUNTg2QStuWjZnOW9Vanp5UFB2dUFIekxjMy9KcWUxaHFQS3ZB?=
 =?utf-8?B?Z0J6SW5TTEpBSzFTS0pmd2MwSXpoUUxQUmovcFlEbktFMnlycE1ZRWJwTDRJ?=
 =?utf-8?B?dHFHWjhtMnY3OEwyQXNKVExFRWVKZmRSWFVQczBST0FBSmdOeWprZ1RWRTNY?=
 =?utf-8?B?YStxNUlVOXJ6OU9Hdnl5WlZBZGg3bitOZ01kMVpaUnQ5SGhNaXRUOXhKMU5N?=
 =?utf-8?B?K29PZEpGVDNBR0UyTzd3Vi90RnVmS1FxUU9zTDNDZGx6MjVaN1UwY08rSlJk?=
 =?utf-8?B?STk1NlNhT2huMnhCbjdDL3dYYVpYZlBPUkhIN3liYlRzSVJOSzkzV0ZhMDFK?=
 =?utf-8?Q?phnWoE/zQPZGCdabEEbz4fjVD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 360fa5fb-02d9-48e9-025a-08ddbe1f7bd6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 13:00:58.8736 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rDNxw1hIGpqSMDVEGAXwE2kQd7j5bdZ0p1dVs9uVhdqyZfCXRAa/iQALYTGRxRb6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7537
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



On 7/4/25 11:09, Venkatesh Yadav Abbarapu wrote:
> U-Boot timer clock is not updated when it is migrated from
> emulator to silicon. Update CONFIG_COUNTER_FREQUENCY to 100Mhz.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   configs/amd_versal2_virt_defconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
> index 15ac0211828..052d637649e 100644
> --- a/configs/amd_versal2_virt_defconfig
> +++ b/configs/amd_versal2_virt_defconfig
> @@ -1,5 +1,5 @@
>   CONFIG_ARM=y
> -CONFIG_COUNTER_FREQUENCY=375000
> +CONFIG_COUNTER_FREQUENCY=100000000
>   CONFIG_POSITION_INDEPENDENT=y
>   CONFIG_SYS_INIT_SP_BSS_OFFSET=1572864
>   CONFIG_ARCH_VERSAL2=y

Applied.
M
