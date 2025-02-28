Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48EF9C282CD
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 11:04:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF7498110C;
	Fri, 28 Feb 2025 12:04:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="MRoR2mfW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A65681111; Fri, 28 Feb 2025 12:04:04 +0100 (CET)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4203C81100
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 12:04:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rKOlRHx0fs2Nfp6lb1O4w2cuOcJoCgF+TJpprDXWZHRNHg1fDv9Z7Xt0034/D8S/rodJ5m8NLnU0X+kmqdMZZwPPQCPKTym3eRcy42qL2uD2rByPJ8vjjNS9QhPXwEmChLmx28PGAS/JVBAq8+GXZq+l1mSreCt36NTWM/GWCTxaMUAOqJWjA9rvac+gdati6cb6aU8ay/+hEiUD9/Fvkt6eQkvPcC7BkhCmjeBO/CeGciVX/ZeVXZ1zMRzKAGo6lw7h+fQLCG/EgW82CASuSGXFPTwwakXPb/AGH8JeW96XM2LaZdFYwq+wfwNPkxSgGxmCqlAdPkeQOCYuuJhofw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEzzlACGQlZDIQh3pLZBzflqv4ESkZT91/+kzCHty8U=;
 b=IMeY/R3E9z6Rrp//jC7O2SoHx2WD23V9lirg56hiBwhIaueAHbXvxjmUi6eAWkLXyhNMUxg48NrCpbCm+Nq5mCR8bKVeFT3VPikeYYvW6nl/XdGEcXLN+eg4tzdbUui1EKWjTA5FlXTf0q8s2ewA8wSdlPsmKW14Vog/HIt4Nyc0GMxiHo4j443vS8lWNh4WgU2YNWWfDID8aXyYbyqA71QIKDYotNpzAd9Is+sBcZReh30XyLPbpYcQHZIkvWc2WRCGHfEZyXHvIB+MHNyZrOWAt7crjbr1hQblmX5HsV8PRtOr3agjvsWups7X0vVEuCXLVz1VeQLmnpOBNvKVpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEzzlACGQlZDIQh3pLZBzflqv4ESkZT91/+kzCHty8U=;
 b=MRoR2mfWc85LsFde/bhvkSElhN4+4ExXoBwTK+Y90hKaH/2ondXeqA3pPcrZwmIBjj4ph8pwF6xu/8jpNsfcoy2w5xL45e5xVZUOS4PkaXhrlSJ8C/abZdJSR4seLxfEPwBIKRxzmOUGCPYIDjyNcQzobYY1BygIOH/C+MxZcEI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI1PR04MB6974.eurprd04.prod.outlook.com (2603:10a6:803:133::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 11:03:58 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 11:03:58 +0000
Message-ID: <82953044-5f64-412b-84e4-382eb694bd0d@cherry.de>
Date: Fri, 28 Feb 2025 12:03:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2 v1] Propagate bootph* property to all parent nodes
To: Simon Glass <sjg@chromium.org>
Cc: Moteen Shah <m-shah@ti.com>, u-boot@lists.denx.de, trini@konsulko.com,
 m-chawdhry@ti.com, n-francis@ti.com, vigneshr@ti.com, u-kumar1@ti.com,
 a-chavda@ti.com
References: <20250212091820.213895-1-m-shah@ti.com>
 <445f7dd4-d445-41a2-ad0b-f0c2002f3f1a@cherry.de>
 <5ea8ee8e-1643-4b4b-974c-627f1958edd8@ti.com>
 <b98194df-a613-459a-b28c-7ecf5082433b@cherry.de>
 <CAFLszThGNW-XO93MG7riBkSG==8K7vYO5Z0TkB46AWcS+SdB2Q@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszThGNW-XO93MG7riBkSG==8K7vYO5Z0TkB46AWcS+SdB2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0368.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::15) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI1PR04MB6974:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ccbd4c5-3e7a-4f69-b192-08dd57e7996d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eSsyTkZQZVZpZnRkeXBvdzlGWjA3cE40aGdDZHNRRk9nR0tkaFdJS1RtQ0M4?=
 =?utf-8?B?a082aGtnRkdCeWJLRGhreXBsNzFLNjdDQi9oZyt3WUNKQUhkcFFDR2lhRnpC?=
 =?utf-8?B?NFVZRW1adVpHb0FlS2QrcitpN1ArQysvNCtaTzNDSUZOS1prL1BXVTZaM0ox?=
 =?utf-8?B?MmtuS2RXZEQ1ZWZpTzFHcTZ6ejY5L25JVDZrUStlUXJ0d3VsSUFLcGM1YTdR?=
 =?utf-8?B?eS8vQ21PMHRZSDJGTlpHUWhlRTdkUUp6NU4vN3JNQnBKSzluWTg4SjY3UXVi?=
 =?utf-8?B?Z2lSOCtsOXVjejVmc1lCL25rbW5jU2ZWcFVPY01kM0cvbDVsY2R4Z21Ua0Iv?=
 =?utf-8?B?RWIxZ25GTW5ieEQ3NWtrUFNWT2lpN2w1RkJtSzg1Q3BQOVhhNi9QU2twWjly?=
 =?utf-8?B?TzB2SURXMTNVYUR5YnRMK1hqM3A1bzgrcnl6RzNKK3pIMFQ5S29pZnZGYWUy?=
 =?utf-8?B?ZHlWTFZLZHFoM0IzZ0hGa05ZdGo4TUhoeFpncW9MbHpTUzZVQVJhVWxjZVFK?=
 =?utf-8?B?QkZINEhDT2FDQWZRSXZxSGtxYmlKeWRTTzlKc0VSdnpDSHVqY3NYR0FMQzNn?=
 =?utf-8?B?S1d0VTJ1SzROYmh5UzNETVdFaGlxcDVxK0tyNmtJRGlBc0s2NGwyTXczTUtX?=
 =?utf-8?B?RTk3MGZtQTlnZE5YVHBDS3A4RW8vSkNUS1JhRFJ3RnUwUjVlZkZoczVXNDR2?=
 =?utf-8?B?cm8zUmVoWHVXOXdWYndUQ0RqYnNtdzJjVE1IMTAvR3lJTGNaVUoxdXFOQlU5?=
 =?utf-8?B?bXczblBLZy9aZi9qeWJwWVBwOHBGeFdOQXVqMDdndDBCbERLRU9Xd3NrMFBJ?=
 =?utf-8?B?bWdVbzNrL0J4aUdadTZlVzVUZ09ITG5UYjNQVkFUNkRuNEppZlJRdEg2a1Iy?=
 =?utf-8?B?bkN6b1RuMEtOaHVqRGVmd04zaXgxNTEvR2JGTjZxUEJJc0hBd1lrRXIrdXpo?=
 =?utf-8?B?bTZSS05XbXlraTh1b1hXeUJrbGRVQnN1MkpWRm8zbWdVSmgyK2cyVmJ6YjZP?=
 =?utf-8?B?UnNHaXdHNHpsVkg2VWtGTnVYaWkwQ3MybnVUTE9GZEVMeVh4OWFvc2NPZWNO?=
 =?utf-8?B?aHhtd3hLWjRsMWNWYVBlV1FPcEpnRnVPMEVJbS9URGhUUFVTeVhOc2paN2Zy?=
 =?utf-8?B?N0MvY0xURlVKQ2tlUDV6U1Q5VVNVTmxSbmVucFduK1hZMXYxMTFONkpYcEdZ?=
 =?utf-8?B?aURGQnZCYW9hZ1p0dDF3VXloRGErd3FmUXh1Y2JiaDJ1VDR1S0pLc3hmc2ZB?=
 =?utf-8?B?UkZhRUQ5aUk0THBqWkVIWVpsY281SXNDbjRCR0tWWitpWGtieENQMUNQOStM?=
 =?utf-8?B?OUdkUWhxYzBwRkJqSFoyRUtTazJuajRta0hNcFNubWF0VkhvVzc1VVc2R0l2?=
 =?utf-8?B?c21FMUNzV1V3clkzNDFsdkVhdmhMWXRZaE56dU5uMG5YSHJBMlJpRDVpakcy?=
 =?utf-8?B?allzR2NKWW4rejlEeW1ITzY0NWo5UFJ1NzBPWm1WdGV0VGxTOEJnYURlTURI?=
 =?utf-8?B?N3NNWjlBTkJiMmtabFY1SE54cW5SWG81V3U4T2gzWWRJenVKUmZtdjkvSUxk?=
 =?utf-8?B?N2Z1SGsycWpxUUpFZ2VIYUZzdVhPMHZJUlZhMlZkL0hTdzVEWFJ0MUs1SmZ6?=
 =?utf-8?B?dm16N2QxVjdJaWpObXpIRVNJaEp1ejA2cmgrUWRVQnpUZ3liWlJIY3FYR2pU?=
 =?utf-8?B?bGRNS2doZjVHZlpWQmFIS3ZIVE5zVHdjWFRTSFprS2UzRTdwa3BTcTFhVmVn?=
 =?utf-8?B?cTVkbkV4T3NOQTdBM0gwd3grRlpmQ1lFMExIdTM2TWdYdTV3cWtmbVo3Z3NQ?=
 =?utf-8?B?cG90ZzZJVFJldXhFZmZJK3ZRNnFhY0kxWUlwdU5jQUF2bW4zbEJ0T0FyeU5L?=
 =?utf-8?Q?yuRyvXl17qGfw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OExOZEIwaWlteXpLeThMUXVFUHB5S3JXdThzL2hoVkFBM2JrTUNydnhFbCth?=
 =?utf-8?B?ZEVVZ1owTWROaElaNDhpMlFSTnlJK004TG5sR3BQK2dJSzBEa2gydUdGSjRL?=
 =?utf-8?B?d3A0aWE4MHFkNzJSZ2FITkM2RkdyMlhlb1p2bWVOcFpsV2xsWlBrVkg5bUZx?=
 =?utf-8?B?L3JPRVpBYmVxeGs4WXU4dU9NMjBzbnQybWtUa0IzT2RSTUlabWFRdDVDQk5E?=
 =?utf-8?B?Wkk1L2RvWTVYWE9rVUM0eHNOUWt5R0lFYUxDL1hwRlhNZ1NudC9FbTU0M01p?=
 =?utf-8?B?T3dGRFdsS1UxazJDMWRJc0RnNWhxaTd6ZmU2T3haaEFRU1hYWmRQRzU4UlNr?=
 =?utf-8?B?QjJGNlgwZmJNWWpnUlZKVmE0ODY5L3MrNjNacW9PMUFtT0FmYzBYUmFtNlRn?=
 =?utf-8?B?eFVyQmtvRDEwNXJQakZmd1IrRjBRdkpoekFMbWFlOFpmNTZ4S3hTTGtOSlhG?=
 =?utf-8?B?a0FjKzBVdSt0Q1hSL1lVYTFRRmZnS09veFNVb01JaWNKa1J2STd2M1NxdTZP?=
 =?utf-8?B?ZFpRWkFpZGRtRUU3Zm1KVmYrYnFrSWllZlBCQWpwWWh5YkZJRHBJNnVrVmlG?=
 =?utf-8?B?U0N6bHprT00rTkJHVzFnMnp3Vkc2WnFHajBvV01uS2xhbm9Rc2hidDJLbVI4?=
 =?utf-8?B?NnBsOStyYVE1YUplU1RTSTlkdlVzdTUzTDJwekpyNHVXaUhGcFFZOXJlTmJo?=
 =?utf-8?B?SDg0MTFsL0Y4c0FiVEVvZmVhcWF3TUN0QW1QYVBHSkNkSFJIdkhRU203b2Mr?=
 =?utf-8?B?QXQwdG84V2xvUEdGRVY4d05yWFZNSE41Nktuc0xHalROQ3dwTFdxWjZZQlBE?=
 =?utf-8?B?eWhmOGhzK09vc2g5WVVpbUk5S1FwQW5sTkt3cTlaVW1jcHVQTEhKRDJUQTdt?=
 =?utf-8?B?d21JdDlzRTBmRlQxanI4S1hCRjk0TEFXM3RsVHhQUk93aWt6TFZKZ1VQSG5L?=
 =?utf-8?B?ZFNjYTNGRElLTnhibmRBQmNTZjlnYjNwWm5zcElaOENFYTF5M3BpdHBNYzZu?=
 =?utf-8?B?VW9NMHFNRHNJdWNLU0tsVndkR2FzZ0JMdUNjTW9sMXNSMCsxUCtodXU1NnBJ?=
 =?utf-8?B?dXBvY0NyUlNadVYyTU5yZ0ppYi9NREtLaWJjUkJjeEpqVXBVR0w4eTFqajFV?=
 =?utf-8?B?STQ4RW03b0NvYmF1eHdtRjQyN0ttVUExaS9taVA0d1gvcGRSNGlYN0hsUUZv?=
 =?utf-8?B?eCtNUDlSQjE5TFJQNFZLQzhLOXovVDNnUkRUUWxkdEV5Z2grNktmdlBTbE5S?=
 =?utf-8?B?dmFxUHdCeW41UWpVd21QU1lreGZhL1JXZm1hWDc4VThTNmhoT1RtUzFsUWFT?=
 =?utf-8?B?R1VwNVVNMEpQOTd4NVY4U3Bwa3lLYkxua1JQWjdyUm4vWFhnUzQvODJaTm0x?=
 =?utf-8?B?M1dDK3FUSUk2NUtHbDBvek5aTE4vQzJMT2VKMGJNdFFKNlc0TVI0ZElkOUE3?=
 =?utf-8?B?Lyt0MHIyNHZXUm04UWJXTFdscmQvWEl1ZFE3NFNqK0taS2RDTDIwRmdDRWti?=
 =?utf-8?B?Zk1CUlFrcy9TUjhxUHlJNDJtMFVERHh3UGc1VkErbUdEenhwRTVUTjQ2dlRm?=
 =?utf-8?B?Z2RSNTNpTG1EUXovQzIycHZWTFl4eFR5UjMzaG1HREd4ckxDc0dvTm5YZksv?=
 =?utf-8?B?cXB1bHhGSXJXTUttcExPNndpN3p2SW5kWjZOL0UvWEh4bmM2Q1dyNGMxMXNK?=
 =?utf-8?B?dkJHeDEvaXdWb3FoSHM1MkQ3VGZsbFJPcjFnTGliL3ZlTkRzMjlRVGx4UWh2?=
 =?utf-8?B?U2ZEekFKMG81c1dYQVhkQjNZaG9JbTJrMy9tM25FTFJqRkJrR2l6enp6Wk42?=
 =?utf-8?B?aStpeWl1cjFCUS9tL1JwQVZ2L3hua2lKN3F1Z0xQdUVoa080UjhMYkVGbC9K?=
 =?utf-8?B?SFpuZVpSRkhIWW1wdSt3UHFXOG1PVXJia015RCtqL2NuZ1NmWC9OSmxuVGd0?=
 =?utf-8?B?Z2RrQ2xIQURHQW9RVitUWjZXZGE5RXRrNlZQTElPQjRuWGpCaGZHcDEyVkhs?=
 =?utf-8?B?LzE2NHhhT1Q1SmI5dlErYUl1UFVLMEdramFPVFN0WndSM2FCcFJNQm05UVhs?=
 =?utf-8?B?NGhHeGYzTHUrOXM2TTFhYmxNWlNKTXRIWCtLTGZkWXVVZm94aURSRU9FQ1M4?=
 =?utf-8?B?Yy9VMUJzOGJyd2J3OEJ1MlVrYm1BNjQxUDlyVEZLUktaS2pwWDMwS1RsRW8v?=
 =?utf-8?B?NkE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ccbd4c5-3e7a-4f69-b192-08dd57e7996d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 11:03:58.1391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r2CLu/2qvZ+sPxSr2lbzWsioWzD+/a7ZU8lF90Ars4LRdqqmHDc1r2lv+Eg3mariTZlxiqegqxJ9SxET9TtXlVU4Rx0gGD20AuykhEAwgzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6974
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

Hi Simon,

On 2/27/25 5:24 PM, Simon Glass wrote:
> Hi Quentin,
> 
> On Wed, 26 Feb 2025 at 03:53, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Moteen,
>>
>> On 2/26/25 6:57 AM, Moteen Shah wrote:
>>>
>>> On 17/02/25 20:32, Quentin Schulz wrote:
>>>> Hi Moteen,
>>>>
>>>> On 2/12/25 10:18 AM, Moteen Shah wrote:
>>>>> [You don't often get email from m-shah@ti.com. Learn why this is
>>>>> important at https://aka.ms/LearnAboutSenderIdentification ]
>>>>>
>>>>> In the U-Boot pre-relocation stage, if the parent node lacks bootph*
>>>>> property and the driver lacks a pre-reloc flag, all of its subsequent
>>>>> subnodes gets skipped over from driver binding—even if they have a
>>>>> bootph* property.
>>>>>
>>>>> This series addresses the issue by scanning through all the subnodes
>>>>> of the current node for the bootph* property and propagate it to all
>>>>> of its supernodes, ensuring that all of the applicable drivers are
>>>>> bound and probed prior to relocation. This series implements one of
>>>>> the solutions mentioned in [0].
>>>>>
>>>>> Since, all the nodes which are not having any bootph* property will
>>>>> also be traversed, we will have to incur some overheads in boot time,
>>>>> hence protecting the feature under a config.
>>>>>
>>>>> Boot time overheads:
>>>>>       Baseline: Upstream u-boot
>>>>>
>>>>>       Patch test: Baseline + remove all bootph-all properties from
>>>>>       *-u-boot.dtsi except the ones which are supposed to be probed
>>>>>       but have no bootph in any of its subnode.
>>>>>
>>>>>       J7200 delta from baseline  : ~100ms
>>>>>       J784S4 delta from baseline : ~350ms
>>>>>
>>>>
>>>> Pfew, that's a lot of time. Can you tell us what's the delta in
>>>> percentage from baseline? Because if your system is usually booting in
>>>> one minute, 100ms isn't too bad :)
>>>>
>>>
>>> Our system's boot time is about 2.2s (J7200) and that of J784s4 is 2.7s
>>> (owing to a larger DT).
>>>
>>
>> OK so respectively 4.5 and 12.9% boot time increase if I'm doing maths
>> the right way, that's really a lot :/
>>
>>>
>>>> FYI, I believe we've been hit by this issue on Rockchip but cannot
>>>> find the thread or patch right now.
>>>>
>>>> For TPL and SPL, the Device Tree is parsed and looked for appropriate
>>>> bootph properties. Any node which doesn't have a bootph property and
>>>> doesn't have any children with a bootph property is removed from the
>>>> tree. However, the bootph property (if only present in a children
>>>> node) isn't propagated (meaning the node doesn't get the property).
>>>> This is done by fdtgrep.
>>>>
>>>> The issue is that for U-Boot proper pre-relocation, the whole DT is
>>>> taken and only nodes with the appropriate bootph property is probed
>>>> and children nodes do NOT count as opposed to the TPL/SPL case.
>>>>
>>>> My idea was that maybe we should rather propagate the property, at the
>>>> very least in U-Boot proper pre-relocation. This does mean we will
>>>> increase (by which amount?) the size of the DT in U-Boot proper
>>>> because we would add this property recursively up the tree from a node
>>>> that has the bootph property for U-Boot proper pre-relocation. This
>>>> **could** be an issue as the DT could be passed between stages and we
>>>> would then hit the size limit. Sadly, I didn't take the time to look
>>>> into adding support for that in fdtgrep nor will I have the time to do
>>>> it, so take this as me sharing my wish list with you.
>>>>
>>>
>>> Thanks for sharing this, the size increase this patch introduces for 48
>>> such bootph-* tags is about 1.5KB's, we can go ahead and bind the super
>>> parent to bypass the part of adding the tag, but for the next parent we
>>> will have to traverse again down the DT adding in unnecessary
>>> traversals(considering a case that we are 4-5 levels deep in the DT).
>>>
>>
>> j784s4-evm/u-boot.dtb is 131616B
>> j7200-evm/u-boot.dtb is 88368B
>>
>> so 1.5KiB would mean respectively, 1.1 and 1.7% in **DTB** **size**
>> increase, not sure how that translate in terms of boot time though.
>>
>> Reading Tom's notes from the meeting a few days ago where this was
>> seemingly discussed, I believe the issue is that the kernel wants the
>> bootph- property only in the child node. But I assume this applies only
>> to the DTS, which would be fine with this build time propagation of the
>> bootph- properties to node parents recursively. Would the kernel also
>> want the same limitation for the DTB?
> 
> It doesn't matter to the kernel, since there is no restriction as to
> which nodes such a property can be added.
> 
> I like the binman route as it lends itself to further optimisations in
> the future. For example, we might provide an ordered list of node
> offsets to process before relocation.
> 

We already have bootph- properties for pre-reloc, why would we need an 
ordered list of node offsets to process before relocation? What's the 
idea here?

> But we could also have an algorithm which maintains a small list of
> node-offsets which have been visited and have the required tag, so
> avoid constant re-traversal.
> 

Why can't we use the same behavior we have for bootph- properties for 
TPL/SPL in pre-reloc, why do we have to have a completely different 
implementation there?

In the worst case, we could have a separate DTB for pre-reloc too, 
stripped down the same way it's done for TPL and SPL for example.

> Ideally, pre-relocation, we should not need a lot of drivers, since
> SPL has done much of the early-init work already. Perhaps a UART and
> not even any pinctrl / clocks / power?
> 

I can tell you I need the storage medium used by SPL to load proper to 
be in the pre-reloc phase of proper for everything to work properly, so 
"just UART" is not good enough for me.

So, SPI flash, SPI controller, eMMC controller, SD controller, pinconf, 
pinmux, clocks, ... c.f. 100f489f58a6 ("rockchip: rk3399: Fix loading 
FIT from SD-card when booting from eMMC") (yes the commit is about 
fixing FIT loading, but see the end of the commit log).

I don't think it makes sense to have an automagic solution that decides 
which nodes should appear or not. We already have bootph- properties for 
that.

I feel like I'm missing something from the big picture, can someone tell 
me what it is :) ?

Cheers,
Quentin
