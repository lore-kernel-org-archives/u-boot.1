Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F08C87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 12:58:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3F4880FA1;
	Wed, 30 Jul 2025 14:58:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="L9mSXWfu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACB3881D6A; Wed, 30 Jul 2025 14:58:35 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 824ED80C93
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 14:58:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rE8sqU4rkkahbNSeWixAqwXFG5GjLBnzGVeDFCl7WzDu1TugXGYmIGG1VcT+HJ7PMeNdnu/4Z0SmP0JEwB1EvyirM1wBuMZM4wR80PW5PTq/Dz6X83IH3DeNicfOlYyAijt+xMqjkHU5Lm0odeYtVyJbKgfkiJtw7D4mETgEMoek/terE9h+CQfr/5cVZqF6cnaP9eCcyDC5dNY+eOLfIwOH6fkYfdIFYzzBSYgGN5oDZZdZyrznP4Nf2xDwawC9ugcZjtB0DO0BM9Bnz4XmicVZNkHSdz/4cR1T494etigEBJIV0z7OulqvYNwUEZbh4a3l+y4pvGkSsnwFANdOTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQ2velQBoc711LklLF+8FGB7ibduPWh6YgMC8ZMmv6s=;
 b=Nnvkvf5gpz5fvmqrlDKMF8HyXXD3kIpLL8Vy9AvLhVaC6eciYs2Pmi/8GfwqmwHSx4SBR9uHl5yFdLzK7NhqNAePIa9r7ODGWl6dliL0XWUvgVdzU9sWAJDHt7/TpyLfmqMjRHoDVSNeU8oL6sNn8+dxgRod5MBBbEUEBpm7NuM+mP94VZjBhTMCaXKkyno0sX7NwWllCAesQqTTb5EcXeiS1PB51V6tmq5L+RIYblQa8VaCwPPU4bINocPs0hGU94Jsgw5Rwi9q7ErNWEujYeCB4F+ArymvD0cVf0i5iPGB4KqHcIqN3rL0xFA5nVk/Z4G3mgSj5qRYX5gRWCO6Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQ2velQBoc711LklLF+8FGB7ibduPWh6YgMC8ZMmv6s=;
 b=L9mSXWfuGjezaRp7DtyyZnRSoSP9j/5F5f0XnvpLXwvAxm3nHoQziKUQhSftR6oB1A7sbeMKZpA57nkj6PxeAZkKncrpjex9NkU0zeKBvCSUqrtG0z1bj47dIILzXj6cCE9GICpfl16kgHAiQW+X3vRGu9iQ3uGu4dAgX6VPF2Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI1PR04MB9978.eurprd04.prod.outlook.com (2603:10a6:800:1d7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Wed, 30 Jul
 2025 12:58:30 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 12:58:30 +0000
Message-ID: <3f34945e-9e4f-451e-85eb-5a5e4e5cd265@cherry.de>
Date: Wed, 30 Jul 2025 14:58:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] Kconfig: typo restict
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>
Cc: Paul Kocialkowski <contact@paulk.fr>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Trevor Woerner <twoerner@gmail.com>, Marek Vasut <marex@denx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de
References: <20250730125427.587976-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250730125427.587976-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0199.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::7) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI1PR04MB9978:EE_
X-MS-Office365-Filtering-Correlation-Id: cea4880b-f9f6-417c-ec39-08ddcf68c830
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SzRzRmZEVnRDcXFTTmlyZzN0am5PTXkzeVV0Y3l4ZTVwV29oK0hNSzhYMGRK?=
 =?utf-8?B?R09YNnNZVUw4VHhYakhIUmt3WExYbjM2WmlxTlBIZkZEeW9kSXIzTzQxU2ti?=
 =?utf-8?B?SGVQUDBiVENiZjlHNW5MbEZSNjUxaCtKNC9Ldjh1d1R6cUNPeDB4R2tNZ3ZE?=
 =?utf-8?B?bUJ1cTFaUWNpbVdoakRVMFk3TUI0K0pNMFBSVUpPenVoYTdJbStjUVFHeVFY?=
 =?utf-8?B?UDFmcVBodjNzemtSZWNVSzFBeDRzVTdSdDRXK1BmeXA3ckRCQVY3TjA0dzBH?=
 =?utf-8?B?UDhIRHZNN0V0VThsYnhtd3lnUHk4YUFoK1VIYzlLRXU4VlVQekpOcC9DRmgz?=
 =?utf-8?B?MjhVTlBoaXNka0ErTThaVHcyOGxxU2l3eE01Qjh1REtsRm81WWZwTk5zUXNz?=
 =?utf-8?B?aTg3STFlY0FuRU9FVUNkNjVPUlNFaU1GOTFlMnNKZmgwOHY1a2daZ21FRXBh?=
 =?utf-8?B?VEFMT3BRUjhOUGVzU05qeDM4RzcxaU1peHMxcGNONlYzMGJOVXhqeGFNbEVS?=
 =?utf-8?B?T0V5OUM3d3pENnFQNXRNV3BGWFdUMXhOeDdMb3A5Ly9CR084enZFU1o5S0pH?=
 =?utf-8?B?ZkNJV0Ewc2RIK05oVVRmaEp0eW1NRzgrL3NJNFVBQ3lGZ0RnSm9wdWNXU3Jy?=
 =?utf-8?B?eFM0M0RoalhuMFpiVmpKSTRLKy9La2FiMGE1OUw5ZjA0b1FUK0piRTAvUG1F?=
 =?utf-8?B?RlluUkpIZlh4VUQzZUhNUXZKT29ud1J0c2dBUXFqOEtpZDhFblVGOXVmeUpG?=
 =?utf-8?B?cHFmenlVanBGVkg1RG90UTVwT3hEcUg0UUV1d1AybGhQNzl4NzRCN3BPbC9u?=
 =?utf-8?B?bUp6MXAvT3ZzblB3aFk3UjMrR2xBNk55WE11aFV5bTBVZ3NEQXloQ3R2cnVa?=
 =?utf-8?B?bkFMbVNEK3MxNzBrRkxGTG9WK29NOHJHelJSM3RHaGcwVkZpM24wK1VhYUFX?=
 =?utf-8?B?THVWeThIS21YL1A5RC9FczFkZ2x1U1FXR0JxNEx2b1IwS2pDUWEvMlR1YkZp?=
 =?utf-8?B?NDZ5YlhuNDEzWkdyUmZzQmRzRVM4WURWZnE4TmZiTlZyUVRCYVB1WEsvUG10?=
 =?utf-8?B?ek84OGx4enFUM1FIYkh4UzNkOXBqMTRtWDYwbFFSR20rZHE5aGh2eFVOMkpW?=
 =?utf-8?B?S3VINjBnWS9FcjNQR29XMG1oNjZCazR0aW1tUXdIZ2Fmei9GN1BvVXhRT3BU?=
 =?utf-8?B?ZUlIK0hWVDcraDVJTVdCekpUN0JMVEFyL0NRdHRRM2hGYjFmL1RtSEFkaHhv?=
 =?utf-8?B?MTdja2F5cVd1OXVNWmN0U0ZiUEtFRUNPcERmOTQ0bHJBWFAzREtiamNvbHpr?=
 =?utf-8?B?UVNEeGwrVkFhTm9UVjBCWW9QSGhuZkw0S01zTzgxZ1c5Y3oyY1hyRSs0M2xy?=
 =?utf-8?B?N0I2bzdSYWtmZVcxd0FJWm05bmVqNHdLOS9ZV0tmS0V6SXY3ak9UQWFxYmhD?=
 =?utf-8?B?UW5vTXZsTWlySis0N2VTUmV3SGltTCs0dUU2QnBTVVdMdzRySGlXSHpWL29Z?=
 =?utf-8?B?eHdaOS8rcVI0RzlTWVMrVFh0MjlHcGtiUU1naDBmUzhPK3QwWVRqTWU3a3Jv?=
 =?utf-8?B?WGtQdnFlOEtLU2RLaHBIc2duaHRCZFNzZjFHN3Jma050SExwdlVvZVFtT1J5?=
 =?utf-8?B?a0RNand2R3dFYjRvejJJdEZHOFd5aDdCSjFKWHVZMWhUb3NndUJ1TkQvMlBF?=
 =?utf-8?B?KzJXUG5rSVU0N1dOM20wdWJ4b3JmVHBZV01qNlpBL2tuMWxybC9nY3JhODFJ?=
 =?utf-8?B?R2RxS0NGUzduT0hDeFpMeXBXaUt5a1hxdWZHU0l0RVhTQVVBQUo2UVF1Tzds?=
 =?utf-8?B?ZWZXaE9FSk5MR2J0dUtmTWVpVzVDNE9MU0xKR3h5WStjZnNIcmdIcngvYWxG?=
 =?utf-8?B?c0FyVWlab2F0bXBIdUNHQnVkcVhmeko0OU9yMkNnUGRYbHdLbXpYZEFnNzhO?=
 =?utf-8?Q?+9Z5b1L4J5Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emw5OE9hYk9RQlpxbnAzMjZyNXpHdHFLMUZMVDMxMWsvRnRPZTJpbTB5YWpB?=
 =?utf-8?B?Q0J2ZGRZUldiTFRuMkdJdDAxN3Q5cm83d1p6emFkTmNnaUs2dVVjd3pMU3lz?=
 =?utf-8?B?TjRwNkJTRGx3Y1hoR0p2UnJXTU1sMnJtNzFlTWpVeUg1QXY2bFQvQm01eUtT?=
 =?utf-8?B?d0dDL2hTcTViem1zRzFqTVM1K3RvSkI3WGVua1p4Q25zVTdNOUpOcytqYUxM?=
 =?utf-8?B?aDBlbll3NkV4SnNBc0t3MzVUcDlFOEhjQ2wrUHN2N2FDQnY1MWZVb1RMMnVB?=
 =?utf-8?B?SmQ1MTdVejByeStUYmwyVzY1bmc3cnZQOTg1MXNQb0xtK0hobUlVTldBZGNP?=
 =?utf-8?B?dUt6V2xvK0FHT3ZzMlFZR3VSWnhaUUlBalQ0d3pqRW9CMWlUVC9ZQ0VEUCtL?=
 =?utf-8?B?L2NrRUF3TnV6QU91MGg0UW5rdmxmSndRNnVuZlFlU2l2YzFCMlovbjVVWXlW?=
 =?utf-8?B?clI2N3RRTnhRclpXUHk4U3BLRExSZU9xb2gvcmw3akdEYlpMZ1N2ZG85OVVC?=
 =?utf-8?B?ZktFdmJ6NnhFYmFEUk9QWEJ1Mi8xT1d5MXBUS2hxekhHeURiR2ZKYmlrYk1U?=
 =?utf-8?B?QUhQNktzL1NwN05qOEdtKzJ1eWJnZE4wd0ViSkFWazQyTnFqTGtNMC8yQTBC?=
 =?utf-8?B?VUNaUFBiR1VmYTh2TXlndThxK3FaUjhPeUpQalVWM241NFU3V2t0SVhZUTVp?=
 =?utf-8?B?RDZ0UlgySnpyN2p2ODJ5YTZJdmZWS3VyK2tIRjhmdEh0eXg5VTdGRW5lM0FD?=
 =?utf-8?B?S1k1QllCVjZVWWVKTXZWai9HR2JZNGY2cnZpU2N4eVYreDJLeXFDKytCS2x0?=
 =?utf-8?B?SFVhS1ZKSDlMUkFZUmxva1lqT2pmeGZjdkN0WHd3UUZWbkVYSXY1NGxUN256?=
 =?utf-8?B?UXZ2TXJnSGRCSllyNEZaNU1CL2pCRWU5TVZNbFBXdk5abDZlb0VjUVBHMkZx?=
 =?utf-8?B?OGRmbUxzZm5RQkZSVVl6NzFDN0pJTGpCaG44UU9scWtnVmJtL3Baa0x0OGhx?=
 =?utf-8?B?YzZyTzF6YklZMEt3QmRKaGlYVENmbjNlZ04vczVOdHV1Yk9rOE95S1BISTM4?=
 =?utf-8?B?ZEFxQWY0T1dkdHRpeHRZZUVINzNlT2hncEt2enJGT1IzRklWTDZTUnlhaEM1?=
 =?utf-8?B?eTFtR2FGak5xSEVFL3g5Wld1VnlkNzBzUzgzUU1MSlJLcGlQai94MjAxYVMy?=
 =?utf-8?B?Ulc1eEZTZlpLUTZkYWIrUElnRlJESGZyTlRiTXVZNi9OKzB3YjNZdllLZkFD?=
 =?utf-8?B?cGNOMUE4SytETE5rOGJvMnk5c0Z4ak9vdkRIMU5nUTQwdExBL0NnVnVPUDBW?=
 =?utf-8?B?MlhXTFRHL1U5MHd6ZVlOUjFOM2Y3OWtLNUhSa1BReTFMNXdMOWFKK2liR2Rz?=
 =?utf-8?B?ZE5iL2V1OFN5OElFczFpSkZLUm51UTlrRGcrbUthWmxQVjBISE8vZWdQYkZU?=
 =?utf-8?B?ZE85aFBwVlc2eEEzcll1amsvOFhMNkg1VVBJVElUeTlsVnJwelVJYW5Qb3VT?=
 =?utf-8?B?eEptbGI5Nk0wSExGYTdubktEdHVGTGtOd0FmRWVvSWtVR01oQXo0bkpyeUJl?=
 =?utf-8?B?SE1zSnRteE4wZnBXZkdPN3dTZC85WDFhc0s4UmhxeE9TbjVYY2lVUFBibnpM?=
 =?utf-8?B?WXFNR3QvS1gyRG1KTU5RdUFRbm51Rm9vNHZTV1lmOXFQSXBuVGU0dm95Mm5G?=
 =?utf-8?B?aENHZGpxUVUvbVF5d0dOTDVxQ0E0Y2ZHL2VsclVIYlZkci9QKzVzS1UrZVNY?=
 =?utf-8?B?WGt0TmloVmxlZkt4MmV6TG9qeTZmVjdiU1dIc3BrT0RzZE4ySnlKVWlUMU1q?=
 =?utf-8?B?cWwzc2V2SUhBakdZaDhZSWdKMHBXbkpDSHI2MlZGcHFOblNNN1ZRZ2JiVzMz?=
 =?utf-8?B?YWNucHQ2RVk2ZXdtdmo5RW1acHUxWXo2VFlTVERlb0I0SksrcDNoeExBbnZL?=
 =?utf-8?B?bkx5Uk1LTE5qZGlUdVdwL0ZYUXdzZ2VsOE5ZcWdzekhCNXBYR2lqenVyV0Ny?=
 =?utf-8?B?dHFIODdvZHhkclc1TEFmNm5CbElkU0t1SWRpeUJoNTJFWExLNEFySHJtRTNW?=
 =?utf-8?B?c0RmdDBEbWlXVjE5bzVOUjNlcThZNWdrNTdTRG5HZ0dkTTZoK0hGaFN3Ui85?=
 =?utf-8?B?bExXUlNvZTh5TUgzQm9wR3RkRHp2b0NVQUc4VE1NTEVzWGFSUElZZHpmTDBs?=
 =?utf-8?B?TlE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cea4880b-f9f6-417c-ec39-08ddcf68c830
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 12:58:30.1050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tti6i/A6YLnSJzBUuUD0XdyDaRRQjOn3s76vqCb/rNcJm0XsbLaXl60n3OLelicolzngUwUEZkiAUYvK0KQg0w4H5pPPpOOHln2CZGFEBEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9978
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

Hi Heinrich,

On 7/30/25 2:54 PM, Heinrich Schuchardt wrote:
> %s/restict/restrict/
> 
> SPL and TPL have separate options (plural).
> 

Looks good to me.

Wondering if we couldn't add which options are to be used for TPL/SPL 
Would that be TPL_MAX_SIZE and SPL_MAX_SIZE maybe?

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
