Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BCBC5B543
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 10:53:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA84480E9A;
	Tue, 10 Jun 2025 12:53:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="iTcnGn1r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CC2082B07; Tue, 10 Jun 2025 12:53:50 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D1B78070C
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 12:53:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQzfQ4z9veYnP4s5BV71wghvGnqRSuMFpiLe4JJRzOhnyCzR8PJBE46DejgnNqEl3PM5+GVEGhsoI/HUuqNfJ7VMZVH6kk7Pz/c7n28kbFPIRQNpSnFIF+kYZm51vz+0NrsDrdbiyrvr13Suolo1BGJPAY85FieRwCZid+eWOJ+hdaW7KufBuK7fR+Kqm0F8PcPM/SSKQ0i0+OZzVwI5f/h2bNvhE6MZSryGnd/ogb2W60Ak8+t9hi22GtX6/93HXJ1aZ5vccgCyHQJSUmvNWYug0vqdn5yxF62SSXYcTgq3V34rZg6gB2bMHbE+ZZ4YDRvdlZ/4kBV1N5f9DY/PWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXJGgO8N7EFFoECfuQYaTy60cfGWfqsygqn6mSEYMg8=;
 b=kAAzglg/AMjpTkxBI0gNo9q3DblkjCk9W0Q2wFX566ChXW/fueeECZ2DVHY/dTnTwWUaAmv6Iqxx0zfHM7JHeVIB/GUbSkHNaIN93EvORS+e7FWZzmD6LtiTOj6ljxkrb/zhpl/sL/ugJx9AAd8kagh2zWoCHo4jR+Knz/jLTrGUAnTLlxffu6oUa5yy8r/3Y+2BqP8PoO6yD8OJGBsdfhJs3jWZ/QhRYr5Ihdeg9+aFf4bbM1ia3ZINw3KpX13Ovkzv2ibtYyUUuWJ3bu1C7KKtmyjFFPPvRzsonI7M9c0pTFQ3WuTJCtkzBmyZbEBa+2wSbjDde6DXq/OPDIauKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXJGgO8N7EFFoECfuQYaTy60cfGWfqsygqn6mSEYMg8=;
 b=iTcnGn1r9oDzukFePu+S6Lxh95UHaX4Ka/+ueVqKc1J/wnleyxqwJD3piXYrSy/ltdvoSS7F+d8dnA8a/qZxe3stgV9Cj/VnzWUOrADBzjIPBHfJ9oXvdkFe2J31Q6rWC1WzU9PZ1au+FS8NmmNs7Mhbj9DMEjjXPmdMM/JFv1w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA4PR04MB8048.eurprd04.prod.outlook.com (2603:10a6:102:c4::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Tue, 10 Jun
 2025 10:53:45 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.8835.018; Tue, 10 Jun 2025
 10:53:45 +0000
Message-ID: <7240ff54-a730-4f86-9ed2-8ca242ab8388@cherry.de>
Date: Tue, 10 Jun 2025 12:53:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] pylibfdt: correct license information
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250607113218.208923-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250607113218.208923-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0365.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::8) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA4PR04MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: ddd246bd-51b4-4427-6e74-08dda80d1263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXYwUkF1ZVdLTGR6R0QxY3FCYjBjYzdVbXhZOFljeTYzMHhzL0R4ODRsM3Zq?=
 =?utf-8?B?cjVRYUgwZmFtL3VSMVJwZmJrUXN6OG1yUVdQNko3S1FpeThuUTQ0QzBYbGox?=
 =?utf-8?B?Qmh3T2NlUmNNSkdwNWxmcUZBZXVic3dsVjRZMEViSy9kaWY3UDc5M3MzN0F6?=
 =?utf-8?B?SWFQT1lhbnZKY2RzZjYwUkZFeUVuREM5ZE4rMmU0NGxvV2h6UFY1S3lQZWow?=
 =?utf-8?B?eit6dStqbVZoeHpObC9DM01DRTl3MUhhT0luVWtIblVUWHVsZXN5c0ZiQzJG?=
 =?utf-8?B?SUFxdGZJaFlyZisvTnZoNTlEUWlLcENpYVNqbTBYWE8rblFYMFhXRFE4VU9p?=
 =?utf-8?B?UENkODlLaFdVMGVaN3ZaK3Vhc3ZHNUplbXdqdDIxdWM1dkIxUjQvd2RqYW42?=
 =?utf-8?B?TGdRVld2ekhVNG5xTFM4Qk1VcDhZak1NTE5EV3U2ZEFXeGp4d29ua2ZKalQ4?=
 =?utf-8?B?VHMxWUw4c2k3Q2NyUEowY0JadFNlS2pJenRZV2J1RnNEa0w2MVpSZS93Ymx0?=
 =?utf-8?B?TjBwOW1mZGYxUE9TSFgyQkN5bnVBdlFLb0pjM1VPblFDZFFRS04xYURRVnZI?=
 =?utf-8?B?SS91U3gyMUE2RUlnRU5aZ0NtWVAvRXZETFI4VjRKa0VUT2UxWkNGc3VSVStM?=
 =?utf-8?B?R0pIN1dwWkhHdXdiNms1cFRjWVRQV2orVCt4NEYrdkMzaTZ3VlVvWWVtdXNT?=
 =?utf-8?B?aEpNdU5zdGNpRzN3Zi9TejhuaGZKZDhGdW1jTlh2eHM1QTBocW8rS0ZmRGRT?=
 =?utf-8?B?c0t2YzdQS3VSYjhTaDRBMEs1dzlVNzY4UU9aMUlGeHl3dFhLczBqUlA5eFlz?=
 =?utf-8?B?dFF6bGpyTlIvdFJ3VTdLbkM5ZStLMDF6NUhPTTlLclF6eEtkckEzczF3NjNl?=
 =?utf-8?B?TURLeHpHS01FUnpKY2xGTmFXcDB6cVRkVEhkb2kxcDBDQ2hvb1h1K0U1eGJ0?=
 =?utf-8?B?aEhOR3UydFBiOFJaakd4azUycnozUjlvenlzbEZBdFRpZ1A2bnhTVTZLQVAx?=
 =?utf-8?B?aFRFQit0SU00OVkwR1prTDJaVXVuYytMS05QWXR3dDhpN3pXYUxKMFl4TUIx?=
 =?utf-8?B?UjJadVFqMXBxWDhqc2NYTUJiUklBWDNQMnp6ZmFNY2QvbHIyQUplNGs2d2lY?=
 =?utf-8?B?RTY0SXBjWHlNMy9ORVNvcC9tM3VMVXBVMWZhY2hHL05vTURiOHp4Ulg1ZHlo?=
 =?utf-8?B?NWpIZ0RDS2tIMGZIRURtV0lSbHVmaEMvUTRDL2xIRmEva2pQNm96NmE2NGRz?=
 =?utf-8?B?eHczNkNCcjJXU2N5YkljeHRDcm1uUEJUUUVyOGZBTS9SbFdjMUk1NmxqU09j?=
 =?utf-8?B?U2YzTi9WTHhnVG9nUUlTL2hJU0JIb011bHVmbThHcWs5a29maEpUM2E0VVJM?=
 =?utf-8?B?UjdKSUVueDhsL0VHR1UrelR0ZVZnYzlpcDc0Nm5Rd1IvMWtZMmFScWpBcThm?=
 =?utf-8?B?MHZwbUJuMHFqMXZub1dSRVhUbnBHdHJnclNkTUhOU0ZHVWROS0Z1OUNDNyt6?=
 =?utf-8?B?ekZrME43YUU2TzZOQ1R4SEhnQ0oxK3g2OC9wRzdJQU9nakEyckI3RVR1aHlL?=
 =?utf-8?B?bUx1dHBKS2dWYlAyNG9kcFIybXNvMFFGb1VldGFyNWpXSy9PODhVZFR5SmJV?=
 =?utf-8?B?eGU1UUdPMWhKTlhVMGREeGJTK1Eyc21rQWhtcGJxYnh2Y0R6UUxOY3BERUVN?=
 =?utf-8?B?TG9McHd2UitXWFdoMWtjaFhhUncxSlZUTVFlVEdkVVplSjZ5NVMyeGQ0dFpJ?=
 =?utf-8?B?Z21RRVYvSkpHVm5sYjN5bzZFMWc2clRuWkN1bDU3bVRmRW1wTDhqL0dqSzRV?=
 =?utf-8?B?WElhVU5CR3BFaHpsazZ1Qk92SExFcFFLZGw3b1JMNnZtNTFCVFJ5Rk1hNXds?=
 =?utf-8?B?VTJtMURDMkJJMkFUZTdibTBkeEtVQVRVbnIweWg2cjBMV01nR2grK0tpQkcw?=
 =?utf-8?Q?b/Oi2AyM8Ag=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDVKRUJBckdEOTJMYmRnSit2VTRyYVNUQXFYQ2ZjUTZMSmpPR0g3K1Vvck9Y?=
 =?utf-8?B?OXVZVEl1bHEvNnRJSnpZcnFWMi81R0wzaktsQmtCOFhleUtIRUdsZ1k3NXdi?=
 =?utf-8?B?Q3NZV3V3ZFRyZmFkU1QxbnpIYmNiT0xFNllsVlIrTTQyU21GcXd5S2NhdDBH?=
 =?utf-8?B?UmZuM3dEVVZJNEpKOFFJN2g3RW4rZ2ZqZ3FocVVqZG8zcWVGZnBObzAvdStB?=
 =?utf-8?B?M2NqNDFzQ2pQLzE1NmFzelRpMS81Q1FSU0ovcHQrWWFWU1hwNFBKZFp2a2FO?=
 =?utf-8?B?a0lZcUFTdHZJaE1qbGVIRWJTZVZwdEFDMlBnS1RnSHVIcEZnRlVpQUxQYlda?=
 =?utf-8?B?VS83UkxqUUFoL29KVlppVEg0WjhEazEwQjJuS040NzJZUUc4T3hTeTByWlJ4?=
 =?utf-8?B?ZWMvTWNGeFdaM0hWWXdzb0xtanNLMUZBRFFnaVFMb1M0RXp0YVNSRldTL21W?=
 =?utf-8?B?MkFLek1CaGEwRnFlK0dtL2ZDdUJaeGppcVlkTU1XS1I4cjVuUnRZR1JsUUpz?=
 =?utf-8?B?YUxLMnhvRDd4dHJtaG5sUCtPYWJDMkY0d3p0L1RTNlhRTXB3Q0Zpd2VOS2V4?=
 =?utf-8?B?WVlHRk5sKzRZb2Z3clFuNG5UTGZTRGtqN256Sm5mSmxnaGhtVnZMSXhqNnlx?=
 =?utf-8?B?TlBCL1ZIUFZxMGtxZmt6YkVaOTBaTU1XblQ2eDJnWStUbDZCQjRxWXNpYlJI?=
 =?utf-8?B?Rzhzc3pmbDdIMGJRSHhmVHA1bXRJaXVrRHUzT1dvL0xqNHR4cW9ScjBmZVQ3?=
 =?utf-8?B?RmxTWW91dXpvWGN3Q1JJWWo5cXJKTDlrTWF0QzBjdUJ0ZWtPcTRncGpSYVRu?=
 =?utf-8?B?RVhzcFNGa0QrOCt1WEt6WHYyRlFWelJQVU5xM0J6anc5WDhOVGY0R0Q4QUlH?=
 =?utf-8?B?eXRzU1VFQnV6WHNVaGkyRVJ1THlGSnM5MFNnb3E2N21vY3VDRmZHK3ZzWlRM?=
 =?utf-8?B?QU1FRGFRSmc0cThLdzk2ZTlUYSt0aGNCZmFVb21WTGhSR3lucVRsRWkrbXNQ?=
 =?utf-8?B?U0d3aDlXYVZ2WkdNLzFFUnArVGRiMWdjUCtHdVJYbXFDdVVkMEppQk81YlVM?=
 =?utf-8?B?Q1RZTjd2b2lpcHpWMkMvTmVvVWpta254aWE2Y1RzTUJuYjRGTjhUSm5CU0RB?=
 =?utf-8?B?WnRxNWpxcDhuOWtpUDNZNDRIQnRYRkpBOUIvOWxhL3p3bUY3bStaOUtDWVhL?=
 =?utf-8?B?UzJGUG1MdHphTzE2dG5mSDlMTVJCRWxzWDYwTG8weUQyUm4vTDE5aWVjY0dx?=
 =?utf-8?B?aGZVbGg0cGFkSnltcmNmdTVTcEpLMGRJN3dDQ1hVd1lGOWRzRW14dFVUSVF5?=
 =?utf-8?B?RHpvZVl5OTlyalpFempWZUdpaGJNdWZjOVVLM0VXbUxsaGlkMVV5NHBxNVBJ?=
 =?utf-8?B?UnRRWGU3ZTMwaklqS2k3YVF2MU5EUzdBZjRDSVJPTzc4WUFiYVR0bVNhcFdF?=
 =?utf-8?B?dzZlaDB0NHFkdHVSZVZtWFZGQ0VpcjVaMXNHRG1sOFFxWVVTWFpzR1BPWlNQ?=
 =?utf-8?B?amZjZHBUU3p2NWdLTnJ6aFZzZ3BaSWlPcGc1N05kRDNMQzFZNEREQ2VhZzd5?=
 =?utf-8?B?anlkZTg5VG1HblJNWXJtbFFndWxUcE5ja2hxL2ZFM1ZTaDNOeitDQXloSlp5?=
 =?utf-8?B?TlVndmFOa0J0MnMxdjRrVnUwaXZGY2xtWERsMk43bWJZV3g1RzdpWkNjOHlQ?=
 =?utf-8?B?Z0RmZTIxZE5uM29KZXVsTVF4N0ZIa2x1TDBEZ0J2RVJsSCtoeGo0QkVGV0xS?=
 =?utf-8?B?QlhyQURHYkU0Vjd2QnFpRVVsNWZLQzVKVEJ0N3FFM2ZZU3R4QlZrMzBidEp2?=
 =?utf-8?B?YnRWQ09Sdjlia3V0MVk4akVNdXZpZFh6VWdwcnNxS3RRYjlsalgvQWhsd24z?=
 =?utf-8?B?bXBvWU9XZTlTbTF1SW15K0J1SUJ1UWNWWGUzK0NMaXAvcXRtbmlJaVFNdno2?=
 =?utf-8?B?d3ZhYURrSy9iWVM1SlBjcTdvWTNLRDVZa0xZMkNVMEdvTVdMMnROTlh4YVYw?=
 =?utf-8?B?MjBNV0FIamhuSW9TeXNKcGJWaGJ2azVPVzFuTWxCYlZMNmVqVm9OQ1JvVVRH?=
 =?utf-8?B?bm03Vm9YeEV6RC9VZjJkSlhJS0x4ZmJrYXFIVm14OXpudTJYMWJ0VHJtNFFm?=
 =?utf-8?B?SDdHVDlOZWpvYVI1TE9QanlvRm95dnhlNGt5R1g4MlplaE1sUlpCMnNQUXBR?=
 =?utf-8?B?N3c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd246bd-51b4-4427-6e74-08dda80d1263
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 10:53:45.4442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zoUi4Z2qiNpqxESwPUINyyZT68GoXwab1nWHW3boGMUBYLAgNYdWJ3p1R7UZ2E+qJg7oGAC+CFgdk6o2GdjcgUiO9Z2u/hlhTlGU4pHJWP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8048
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

On 6/7/25 1:32 PM, Heinrich Schuchardt wrote:
> Setuptools 78.1.1 shows warnings:
> 
> * Pattern 'GPL' did not match any files.
> * Pattern 'BSD-2-Clause' did not match any files.
> * SetuptoolsDeprecationWarning: License classifiers are deprecated.
> 
> Cf. https://packaging.python.org/en/latest/guides/writing-pyproject-toml/#license
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>   scripts/dtc/pylibfdt/setup.py | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/scripts/dtc/pylibfdt/setup.py b/scripts/dtc/pylibfdt/setup.py
> index c6fe5a6a446..487e669f524 100755
> --- a/scripts/dtc/pylibfdt/setup.py
> +++ b/scripts/dtc/pylibfdt/setup.py
> @@ -158,12 +158,10 @@ setup(
>       long_description_content_type="text/plain",
>       url="https://git.kernel.org/pub/scm/utils/dtc/dtc.git",
>       license="BSD",
> -    license_files=["GPL", "BSD-2-Clause"],
> +    license_files=["Licenses/gpl-2.0.txt", "Licenses/bsd-2-clause.txt"],
>   
>       classifiers=[
>           "Programming Language :: Python :: 3",
> -        "License :: OSI Approved :: BSD License",
> -        "License :: OSI Approved :: GNU General Public License v2 or later (GPLv2+)",

This is an issue though, as it's supposed to be replaced by the license 
argument to the setuptools.setup() function and we aren't matching there 
(though tbf, we weren't already matching :) ).

Also, I'm not entirely sure BSD is unambiguous?

I would suggest:

license="GPL-2.0-or-later OR BSD-2-Clause"

to match the SPDX-License-Identifier at the top if the setup.py file :)

Cheers,
Quentin
