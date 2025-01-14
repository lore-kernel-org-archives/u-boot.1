Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3474E77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 15:13:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8112C8060C;
	Tue, 14 Jan 2025 16:13:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="gGpHQ/QS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C16E80657; Tue, 14 Jan 2025 16:13:11 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::611])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9482B8022E
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 16:13:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C1CwfAWwqjoKcCUzawNXJEn/OP0z6GC+8SneUM66LLe6KqtoIFoCdSU+JltlEwg058cbHzewZWmMXPnDUTpYKDTUuupaNGbwqJfUnMdk5f8QoFLufexs+AML6X3gF3cDe0k7wUf/ZuHHAUSnouAOamw7klMAyjtjHXsjCFbnd9VUidiza1SDIjSHzGn7xym1uh4b22LGrW9sWYhEAHwfky57rdetFb3mfrhy2QqacdNWpJXxHzeicJhIigg9Uu9yUXHxTizdJogDfRiHd9BEJUGFd2fcxbom29aafamZijyrSoHUyMj6dbTrxNFk5h8XR0r+0jheGxVE7c2laWlHZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBcAU1R/4HnYf3GGPRZGXWFWlgVQcqSQRPq8Doo5kVg=;
 b=bV8KqWglGogTc0ipiYpJRRiwGYq3eLycxx411/1zOWArxjvLFTXA4I50zuDT6Swq2c519AZ0KexiA8ans/Q3iEhwcbiupql2dKEylEmpntTiofSgeGX1yRB0cqUdHmST4ysZ4a/2gQ6YPA2IZu9CV4347JDn5NnRe53D6l47s6DZLuFyYZzZ/iU7XVzy1We0vnERZOmWXPGl7+rtcjUtgEXz+jraqjHX5IhR64AmTTG+fcsRb8+nwb3xydSbBSPBKKo4hMdXSEIVBJyvIDJt3FAcvLrUYgHYAXarK801Em4AEFSDZd7lMsnjSS1qufUUfr07M86m6DwfxomXquJD7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBcAU1R/4HnYf3GGPRZGXWFWlgVQcqSQRPq8Doo5kVg=;
 b=gGpHQ/QSGo2hpri2nBdUIx1CRiSD1+iV9KWyeHXJQ1ZadG/YPWNRho6ZRLOV7SqDMGztbm9bDco6MZhKG0+z6/y8KmPrhngSpgRSPt7ovk2WY836XcVxiRpWP9ijU2I64bXGh6KtW67Wl0D7U7V2rRnUlcMF/maLyoyWfAxIYeE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU4PR04MB10840.eurprd04.prod.outlook.com (2603:10a6:10:58a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Tue, 14 Jan
 2025 15:13:08 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8335.015; Tue, 14 Jan 2025
 15:13:08 +0000
Message-ID: <a1572755-9853-4941-ac0f-3a30bce768a3@cherry.de>
Date: Tue, 14 Jan 2025 16:13:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] pxe_utils: Allow the FDT to be missing
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>
References: <20241220040120.3245610-1-sjg@chromium.org>
 <20241220040120.3245610-4-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241220040120.3245610-4-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0152.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::7) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU4PR04MB10840:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a0d9636-90ad-47c4-4c21-08dd34adf3b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UDB4VXNaWjd4TjNaZVg1bTJtb1lGNyt2SWhJM2FmMmNGTkdXaW44WGRFQkhE?=
 =?utf-8?B?aEdzUjRyNXVtcE1JTlRuWFZyOTJydnFid3VSeU94QkV1TWZDSmhnRE5OQzM3?=
 =?utf-8?B?ODBheXpEbmJ1cUZMa3dqZUI2Vm1HRm1hckRvcXc5TU8zOEJLRTNGUUIyN3JP?=
 =?utf-8?B?Y2Y0YmdxME05cUVSdFJEUDZkcWt6TnBjczBZaXRCdS9UOC9DdGowT2RMNERI?=
 =?utf-8?B?cU51K0FYY1hLSTVCekYwUjMvMHIxaXEyVVJDZ2dUbmxZOUkxVk9LUTlzVndB?=
 =?utf-8?B?NXo1TWErQTc3dnJEWWJtR0tzYjZmNGMxTUxZY1A5NzZGZUY3dkhaa1NCaFNl?=
 =?utf-8?B?U1NsUWFUTUFhRGpaaUtyRzd3VGMvL0RKMFpocEx4UDB2WkpITkwxMEFEWFpU?=
 =?utf-8?B?YjNBckROLzdkUldxS3BRVjZkc3lkczh3WUpTa1ZMNFNWdk56b0xPY1Z2SGht?=
 =?utf-8?B?M2tGQ0t2L3dWREprWmNDNlc2OCtkRnF1YTZJeGp0WW5ZTDlmSkJUMCtmMjhq?=
 =?utf-8?B?Snd3WGlZdTlxN0F6WnJYcW05SnBpdDFBWDgrNW9vNkVkMDUyRm8zRUltVEZE?=
 =?utf-8?B?Z1dKTm9ZNUZWc3VnU25ETmFJeUhSa1NuUUZ3cmVCMzRoMjM5ckhacndYckhs?=
 =?utf-8?B?blVObTZ3MTE2K0VSRjlhRzdjekIzYzI5dHNkVzZvd1Z2MjZnSlJmS3NPRGtr?=
 =?utf-8?B?WUducUYxN2Q0YlR1dnNZb1h1eHB1UFQ2RHVZeDdCdkZkbHF0ZTR3REtCYXNq?=
 =?utf-8?B?azA0MUphMkRIZEttZEJtREJkTlJMUG1HTVJId1ZBVkRCT2JpUkRibTQ4WVE5?=
 =?utf-8?B?VjhJSXlFQkI3KzRMdXRMQXNYdkxTakVaSTE2UzkvMldwU0s0MHFldS8rV1d4?=
 =?utf-8?B?WFFtVlJYUDhNK0ZkMkdpZDlQOExDRGZqRHF0cEFkRDh2VGNNMWdTNDVBakFC?=
 =?utf-8?B?L3laZlJVdHY4aTR6NUFSQk8yS085WXo0Z3lJQ1JnOWd2b2t2TEt5cXd4ekRy?=
 =?utf-8?B?OFhZaWhlMk9LaWR1UnhpaXhZWHZEVHlSVlhlZTQrZDJJY3lkckYwck96eitM?=
 =?utf-8?B?bnB5anB1cFJyREFidXBIWWFZTGtiRG1CUDlHbHMyMGw3S2FRZUZHdkVNbUta?=
 =?utf-8?B?ZmFyalFIeisxZ2FXQmZIcmFPOHlrQ0JHRUVFSUlEaSt5Y2o2aFZJU3ppOTVv?=
 =?utf-8?B?V3hFSW8rYkNhanlxNkVSY2NuOThpdFVvZ0taL0FobVJvNlBrYVBnN0RxWllR?=
 =?utf-8?B?dm5NdjVxQ3EzSDVhWXZwOVNQSXZBTXFTMmtMZ3hFOUdVdVA0NWx4QlhhRkFV?=
 =?utf-8?B?S3pqbGRaRUIvYW5qYkVxajZiQ1dndFNaMUcvTDMveStqTGhHdllZNkN5V2dR?=
 =?utf-8?B?a0VpWWRrKzExUHdpaHhCWDdlTUxlNHdsVVozVG0rNlhwRytZMG9nSHhkMjRS?=
 =?utf-8?B?N2VrRTBpUE8vSzIyR2x4VEN2c1R4U2wzOHZ0blJ5am9PS1M3QUlDMVNjWVlp?=
 =?utf-8?B?SEJCTERUditNblZwbWw3Ym52c24vTGlYaHpGSVNUanJZY0w0T0xkdURqT282?=
 =?utf-8?B?Y3p6cDQ5eUtZS2xHUitoUG41T0JJbXFpem4xdzVvMlBvK3ZjYnQvU3hVekNL?=
 =?utf-8?B?Z3FlRU5TZkZ6Mnptb0IvbTBrQjhFdHNMb2x3V0lhMlc4MHUxdkp6c0xIVno3?=
 =?utf-8?B?YXJkZEY3YlZuM0RqbW9jVlhDbWJXbUkxSFZPT2dUR0FnY3JVc3I4TkJDYlFU?=
 =?utf-8?B?R25TeW9uSmg5WnVDV0R0WkVPL3ZubW9sK1U5TFNidS9qTjY5QXRkMVBRZGds?=
 =?utf-8?B?RGJVRDdpTWJqK0ttVkJsbklNVHBhMDVQM1YwcTVlRlhvL0t1SE1QdklZVjFX?=
 =?utf-8?Q?zYgp+oU4Panrc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHBBbmZNNkJjQXRMZDZKVXJ4Qzl3Q1Z4RTBmRW1STEdnY1RpSWVCVUhQN2JO?=
 =?utf-8?B?OW1ZUlhVV0dlL0EwUVJFY0lrdHRYZFQrdVJpMmhjKzV1b05HREh5TTYvRnZs?=
 =?utf-8?B?dVBuaGNNdWptdVJ6d3ZHTkFUT0xsdCtXbytVSVJiZmFzTWtya0ZsTGdVcnho?=
 =?utf-8?B?L1VJclAwRUdWN04rRTZsa005MjRWem0xV1RkNzVKWEdpRFBWTVVqNXhTVVNy?=
 =?utf-8?B?ak9GUDVhUnZCbWEyWWVmS1VmdjF6Y2E1NmwwbS93MXhWMUdTR3hZaHhzdVkv?=
 =?utf-8?B?OU1HMjFGbm93NGtnTExnWnNzVHNsQUR3bkZJOUgyV2dwZDlkdTRDNlRueWU0?=
 =?utf-8?B?WHlCMGpTZEFMb3FrQWhiUkRxVHcvZnZJd00xNVdEYTRkanZXcUFWdlVGUGpo?=
 =?utf-8?B?V2FXWFVCR0F6cW1MOTRPcWVVNjNUTmVQeXRSdWt3SUwyNzUwMmFuNEFVUkxZ?=
 =?utf-8?B?Rm51Z1ZVTzFPNHovOU4wVDY3WkxYbXRwbTd1VlAvZGJzTGxTZWVaUkJJV3R3?=
 =?utf-8?B?NGlaL1BLanBpY3NJMVVYZDZ4ZTVPV0tobkUzbXBScElEdEVSRW8ydEtkZGxQ?=
 =?utf-8?B?ZFFvajh6cFc2TG5wcHpqRjQ1UDVnYzhnN29CSlJ6MWJFTDREWWZZdHdtSml6?=
 =?utf-8?B?NkFoQlBnRWd3NHpKK2U2cUdiNWJHUFUwcXBKZGk1RHdqV2V0YitVODM2NkdS?=
 =?utf-8?B?MUJpQkJHeXlsOFFibjJ3NW14MGVYa3hEYXlUMktUNEZFdytLbm5leWRsTld1?=
 =?utf-8?B?UlovMUlaYzFsMVZMMStCay9KcVRkek5xeFQzK2Z3M0VLV0l6aVhyRW8vNGVs?=
 =?utf-8?B?WS95clVPV00yWVVTQWpZb2Qrc21MWkFqZHM3V2ZOazREQUdaYVJIQWJnSDJB?=
 =?utf-8?B?N3ZkNlRkbkhERHBITm1SMDlZR0drazlGSzhpVFZGU2pXK2p4RjJpWlI3VVFy?=
 =?utf-8?B?RTBRRXJURkYvcGdjclhxWVJsbUNGWjdtck1uYW1PTFpRRTFNU055Z0lUUHFE?=
 =?utf-8?B?VGNHZEdITDhQOWYzM1RncWwyTUJCdDlzeXNGKzAzcVRPUWFxb0Q1Z2g0ZjJU?=
 =?utf-8?B?cTZqdW9HS3lqbjdxREw4QWV0eUp4ZGgvVGE5byszdXhpVHBxamdMT0UybFdK?=
 =?utf-8?B?NmJuQTBIUXcxMlB4aUdVUE41VE53R3V1b01oTUc1cXJNVzFDb0k2RDNmdDRl?=
 =?utf-8?B?dnhDT0c5cmcrRTgyQXpHVS84ZXVHZnp3WVBwSUVoZ3JDdVd3bHRtcVQ4ejBF?=
 =?utf-8?B?MXdyY0I4TzE5aW5PWlBDdXIzWXk5MlNnNEJlSS9VNFhoeU1sR2N4elNYd2Nq?=
 =?utf-8?B?U2hJVWZPZnFHWjByRm10NW9QOU9VODBEWVV5bnZsSXBVN2NDMDZPR1BscHNz?=
 =?utf-8?B?U2xlYnM4S0F3eGoxdzl0RVYvTCtsWEk5YUtJWC9qNHR4WXh4K1poUWF5NnVX?=
 =?utf-8?B?Ulg4Q0tVWGw3c3NObjhkalFUL1F4QlAyZTdBNjRwMGcxOUVTUWZERG9XR21G?=
 =?utf-8?B?Ym1Ib3JuR09QWkI2RU9mQUR1cG9IUURTQzVDcEZYYlBIQTZNeG13a2hmckFv?=
 =?utf-8?B?Y29QTGZpZmVkYnRpcmN0OU5velRkanc0V1JteUdxTE9Ga3UyRlAwN3pibjZv?=
 =?utf-8?B?ZTA2NExQMjZ0eUZHcVRpZWZGakExd1QrQkdpeHg5WUlyVWk3RWx2dnV6aHpo?=
 =?utf-8?B?OUkvR01aK25SRFZxY1ZVSUlpVkxPMWg0cUhIYmI5OUIzTU9yZlUzQUxlYVBN?=
 =?utf-8?B?MlllYXYvdWo5UTFMalRBUVUvbkxKdWR2U0lEdlA4U2gwMzJYU01FRnczZG11?=
 =?utf-8?B?dTZ4QjNOL3g2N2ozeURVS0VGZXM3K0k0eGQ1R3BYOU1SM1laSzFYNXJVTGJz?=
 =?utf-8?B?ZFJUQjlGeEpkS0ZVb01xTW45L3F1cnlZRGx5RFJ6cG5YaWpGTUhPREpUdFlT?=
 =?utf-8?B?ejBVbElhLyswOVBmQXoxckFuRE5oc29QeTRUQlFaRnlJbW5sSlFYdW9LU05S?=
 =?utf-8?B?NWpoQTJYeVBiNjJ4TElvWkJVOEc4NE9LZ2J0OFVndURMd2hLRmtjaFNGODBF?=
 =?utf-8?B?eHAyZjZCMGlWZjhWY3RQb0xncUVkdUpjVUlMSUhsdFM5d25VUHVEa1JlZi9B?=
 =?utf-8?B?K1dNZHpwN2lXTHJRaE1tbVhSNkhoZjdWekF0a2FFa3c3aURGeHArWmhCOTUy?=
 =?utf-8?B?Y0E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a0d9636-90ad-47c4-4c21-08dd34adf3b2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 15:13:08.0599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 26ytN5xWdsb3uxxDmEqmiGqNR34PbxR6PNy5DW5l+qfqLLX5xYevGGr0WoUOWPlvwj5yS8NjxqCWbsBuszGllRTVMECaWc4pHQKb9BAkZMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10840
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

On 12/20/24 5:01 AM, Simon Glass wrote:
> The devicetree file may not be provided, so avoid a failure in that
> case.
> 

Can you provide a bit more information on when/why this shouldn't be a 
failure? I assume likely x86? or Aarch64 with ACPI instead of OF?

Cheers,
Quentin
