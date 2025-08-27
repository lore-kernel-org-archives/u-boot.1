Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8922DCA0EFF
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 07:44:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A2C483192;
	Wed, 27 Aug 2025 09:44:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="LyDdJROP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 589B9831D3; Wed, 27 Aug 2025 09:44:42 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FD1383189
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 09:44:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SYq9OEen4Fk7m96qnF3olJn2fb911P3vNVyFFnQzzb0es1Vo+B/9noOv06vbjyzgzv7WfDbEEzNIswOyetWpmIczv1LbcRcS6ieUw5K9f/FPY8zTAbD0ezPUOX++z8j4xzgN/F1AoUDxap3+YRmcsKueCIMvoNO47gw3G9QlAG2Uul5TW7sEMqwdyrklBBLnws8CbKtBG0fy8p2XSRBiiRpXt2g4olBrC2nGvZi+vWH2Vqdx/wC72w6iuTmvlWODFkwIi4GXUv55nujwKwoCeAM5WV/Ytuy0+c0Ql7A4tGezPrcYP0Nzu8UoWgsRKvwWd/serej3whM5poSJufUz0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mXgTih2kjhnarkxQ015CACbjfvRJao5EhJ3MIHuoMc=;
 b=vUfYgHsgU6s9/wJHkmY4jEVY0mGh/F9ruWzyfMUuVanl2pLk81WKCKEhMdfBMBXqBdlbsOEN3WvNSuk7+l/cLXbSGbUmb3vam+sf8uOWhMdhmg92yX7pYh5YhVO1XAvmPP82cTHGsQqzDfBgXI2v82G7fhsZZMP9IYR5QGV9Y3Me3nr3NXpV4DuZNuU5IsMzKJHq857Nb8WZWDWTdEJZago6Uo1CcX/c28ftQ3ku3ZSAat0oVbb28N9babw4CxzpBmh/n7VoIenU4/PrF1P2YKSZeCCdLlyeb529VmV4Zetem21AAwttV8a+9CHoUKWoq8OZDSmQEBFQXA2TPDMVPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mXgTih2kjhnarkxQ015CACbjfvRJao5EhJ3MIHuoMc=;
 b=LyDdJROP6RYa+b67HCDGj09raS13usfen3YQeIonpaGNc7lsLROQjlmBZlCgvL6u2AmH5Ev91wYrmbvyHsWlJAsbw/JMZywOlNRXdJvtYjjfNZc7T9Kh9bod75DACiij9kCcWOly60s6s1ircD+h8ut/sHVfSHhE/JaF7GAEXHcPOXeo7QvAK8vL2/BMAcPYK+IFd0cbx2+2REsR/4IyVFPx9ugSuB1a2ckGGhRiQ8U6Byk3neM8vOjAAghAdvekUPlmXEAiPRcADj6nyK68TEYKaNA5ZCYB51EeH1IrIn7fOMl0XEH0yfmzhJ5phopgeAuHNByKdEiJRtTzj1So6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DB9PR10MB7578.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 07:44:38 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9031.018; Wed, 27 Aug 2025
 07:44:38 +0000
Message-ID: <2c469ca4-7147-4559-b10a-f137e82f3f27@kontron.de>
Date: Wed, 27 Aug 2025 09:44:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] power: regulator: palmas: Cannot test unsigned for
 being negative
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Paul Barker
 <paul@pbarker.dev>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: u-boot@lists.denx.de
References: <20250807-pwr_regulator-v1-0-42a4105336ec@linaro.org>
 <20250807-pwr_regulator-v1-3-42a4105336ec@linaro.org>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20250807-pwr_regulator-v1-3-42a4105336ec@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0316.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::16) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DB9PR10MB7578:EE_
X-MS-Office365-Filtering-Correlation-Id: b1630ee2-b25f-4a00-cbf2-08dde53d9367
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S3llNmRDYkNBdHA1cElRTDJJanUyK1NRcDFZUC9rYjdsSGpVSHlkdnNmRTI4?=
 =?utf-8?B?OVBsZlJDV09tdU04ZGthaUF0Rm9SVWQrZyt3bXFSVjhYYWNOdmZINWdzdXNP?=
 =?utf-8?B?SHZ1TE1abmxNZDhGb0FpOUtxd3hnaU1VcTV4dmJ4WWVIb242ZmhuSnZ4TjhS?=
 =?utf-8?B?RXgzSnEzZWVEdVpOUVhMdk9ZNG03QmJySm9sellpcnNlWE5MaGllTmxCK2lw?=
 =?utf-8?B?QXR0bFlGY2Fmek1aZDJnS1dqb2tnK1VCT0V0T3VWUzk1YXdmeVBRcytVQzRR?=
 =?utf-8?B?Tjc3WU93eEtsQTByL3hHc3N2Wm1IZlJCdFJ3Mk9XN0V0cTIvQmlVWE11ODVB?=
 =?utf-8?B?K3hKRnFQWDQyZGdNMjBLYm1QNkRKOHlUOWdpa2dsYlFJT1lNVTF3YlBxQjRH?=
 =?utf-8?B?bWtpejhwTnVUdS9XUWRPWndKZ1ZFMkYxd2Q4L0NxTkxJWjV3QTNaNnJybXNM?=
 =?utf-8?B?Yng5bnNKdVNrci9LL3R2WEh1S2NCM1g3UDRieXpia0NPeTNkcUFwNHdKUmcv?=
 =?utf-8?B?SzlBM2R5blRNM20wQVh3dDNJZ2d2THR4RmpweHFJTGMyWjBoeFF0eGtEOWRr?=
 =?utf-8?B?MEdNcWYzVVlHYk4wbk1TTTVtZ1UvZTdQcGhHRGNPeDg2cHBpczdCNHpVR0p0?=
 =?utf-8?B?eTFUblFOYkFRMVJHeWJ6OFdPaU9nelE3TktyTkFCRTF2andQNG1jUWFEMGtu?=
 =?utf-8?B?ZzdSYzVqMnVUVHl6bEdjOVFad1ZkOVVHTDREUnhlU3ZTQVN1VXp4VDhxSE9X?=
 =?utf-8?B?bUpXcDIxV0JZWWJoY2hXMlR2bnR1a0g1cjUxRjNNTUFXNzZ1ZnJqcHB3Zi9K?=
 =?utf-8?B?YUJ1NllFeGgwaGVjTk45NXV2TUg5bWtncHYzL1dndURJVFl4eU5rM2cxMmlq?=
 =?utf-8?B?L1ZwZHVBTXZNbkF1K01iZEtGNUtJdkduSy8vM3BveXQ1ZnFtd2NlQ2RtNDRa?=
 =?utf-8?B?dm8zSDUybzZtSCtwbHpxMHFEMEtDTDhRQUFTZHRKWU40dGJ6NmQxUzBxZGpZ?=
 =?utf-8?B?dGxNK0tmZjI5Uk93azc1aVBxUkQ4SnJ5RzRDTS9xMEsxcnhseEQ1MXNiOXlR?=
 =?utf-8?B?VjZSTkxONERBcktSOC8rVUtIWlc2S1F1UWlEOTBiZEFSZ25kL2FqcmFWTWNR?=
 =?utf-8?B?bzJaUXBrUHNTVWVsNzNwYi9tSEZUZnQwNnVWWHU5bnlFdnUrLzViMTB2ZU10?=
 =?utf-8?B?VzFuck83N0ZNYzYwdFZGUW9UbmVGMzcyT1lPOXB5RDdINDJzRnVURGpvcHRq?=
 =?utf-8?B?ZFRXcCs3ck9GWktMWmtjMTM2RUx1TlgrK1dSbHNKVUtiQnZnSy9LNDJYRWlw?=
 =?utf-8?B?VGllNTBhL3ozTGFUVHN5MGVaTlRrU05QUnk3VkRaWXRTSDJmeFdQQzM2QVhk?=
 =?utf-8?B?UEhkczYwQW5nWXFCdEpCRnBOMjUrT2lkTmdkaldvNHBncVJrdjdWRWgvaFhO?=
 =?utf-8?B?MzB6cksxRzJrK0FtbVhRb0JGalhrdUVkekJRMkFLeVpjK0VxSzdZSDhMQWNE?=
 =?utf-8?B?dkVSYVVnT2FLQ3llYWVwbkNaVWg1dTJQcEs5REtaQ2dXOUxpdzdoZG9mS0c1?=
 =?utf-8?B?L3dKMUJtanZqUldsWkQyMFc3ZjlmTnRPcXlMYzN2TnpFM0FaNWNURURxeXpn?=
 =?utf-8?B?Smh0RnZnSFlvSEhadXQvRXdaS0ZDa3YvbmdHNTYzL2FmanByV05lYk16L1Fh?=
 =?utf-8?B?cmcrdEpUcE1rRUQ4WHFmRUZFeFNnQlJXZWt6QW5Ob0lzVUVBL0wzM3FRNFI0?=
 =?utf-8?B?SnY5QVV3NWl4V0JwbzllYm1FZkFRMFlDaW1PNGpMSVdmUTdmQUtERllCekFQ?=
 =?utf-8?B?V0hNQzdvZ2I5d2FaejZoY3hvbXRiTzI4UXloT2JXVEE2ZElxcm1SZUJaa0hG?=
 =?utf-8?B?OW1uOTl4ZmM2OUtCTFloVGZETTY0bWxkUmdxc1dSMUNKU2FmdWVobitBMUVX?=
 =?utf-8?Q?NxYYG/ezlaM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDBaSXgySVVkMjIzLzhSQ1hFU284ejVCWStTQnp3Tk1GdkhLSG5mZDVTanJB?=
 =?utf-8?B?YWRMY1o3S0wxWUpYRXRBWXRrQS9nY1NkUDNlM3dvVytubUNYVlUzT1M3bi9k?=
 =?utf-8?B?OXh3YzA3TDlkckxCUzRReC9aOUhqc3p1QWZGaVJTUWFSK0F4QWQyMUVpRHJ6?=
 =?utf-8?B?VjEvL0Nqd2FpT0phMUxWeWRYWWlEd1NRbWtRUTZham9qTTdZR1FwVW5wZnlz?=
 =?utf-8?B?Q1ROZldVTzZPYm5KOHU5ZW01QlgxUG45aGhudmZHVWRXK3ptbEZMTTBFWlV4?=
 =?utf-8?B?S0ZGRWpNdWJUYXdCN1N6RkZXaS8yN0h3NkJkdHNYVzczdnJZY0o4Nll6Y0J0?=
 =?utf-8?B?NDE2TU90TU9RZlRFbWJWMDlXUE5zRS9UNm1rZEpMdEFrVCtyVUFaNHBVWkVT?=
 =?utf-8?B?TTVKakx5NkRsTU5iQzhKSHRRYzFJUlp5dmdHU0ZCSkt6NEVmZzVDekpLOVZx?=
 =?utf-8?B?SmhqcENxaWMxRzBKR0VXZ0tVaUVJb2V5WC9rL0lVV0N5WU55eXpaZUV4OFZx?=
 =?utf-8?B?TWZVbzBhVEFnbVV3SDhmVE4xMXRIbUh1akIycFYyeVhiNkF0dG02em5iMk1q?=
 =?utf-8?B?UGloRVkzSHVOV28waDdDY2p0TjdwLzBELzdRTDIrekRqNzFvSWR0c25FeFpX?=
 =?utf-8?B?SjlFd3BqczM2Y3NGYUJRVDhDK3hlOTVFSEpGZUpVZEg4Q0J2ci9Jamw4Snl5?=
 =?utf-8?B?M3lXMHFaTE5waUloT0NFZ2xWeWtRZlFEdVdoRm0rQXE5MzZ3QkdRTFpJcmxT?=
 =?utf-8?B?SFd2TU1OeU5nMTBCNW94d2t6VWhFL2tyZXBsMFpxdmJvT05BNGhSKzd1ZlBO?=
 =?utf-8?B?N1ZiNGo4eHZRZUVWY3JxRFVOOUhlcFhoTVo3TlhPLy80bnlqbHByTklTdFgw?=
 =?utf-8?B?SHN4L3NjeWp2ZTZ2SVRGTjE1NUl1WFlnT1A3RU9TYWZERnhDbXdrUVJEMUJE?=
 =?utf-8?B?bWxBNS9QSnE3Y1BhK051MngzWDhpdFR4eFc3MjhUSnVnbFJ1NUxDQlZHMnNI?=
 =?utf-8?B?Nkw0cW1iV0dPS1R1K0RxckE2TnVONjBzaU16T3hLZTN4Q2IyS0ppRzJsZHRC?=
 =?utf-8?B?T2R1K05pdzNnZVZuT2pobm9SVnpqaU1Femw4enc5Umx6K0VZTlRaV2lKcElp?=
 =?utf-8?B?RlBKV2R6dWZ6WXBRYW5nelNXd3ZUZ2RjTGJsVjRGTUNuN0ZiTXF2SEpJaEt0?=
 =?utf-8?B?c3Q4MGpqL1FIRlFwN1FjVHBvOHpmOGIrbTBhc05UUlNwN2N0U0R1Njk5Vmwx?=
 =?utf-8?B?ZWlUZEhJSmgwVjJuZTMyN0hDUFpmVExYQ01weExLQUhpbHlkOElOV2hESEdT?=
 =?utf-8?B?VTN2elFkOFJBbWZuUjRqQVRlMlR6SkZNaGgrN2ppWnptQ28ra1RGOWVlN0hj?=
 =?utf-8?B?U2MrMEVLcGV0bGVrUGtsdVl6c3FiVDU3VEk4R0hlQnEvT0lQTDliZ0pIdVhR?=
 =?utf-8?B?LzRobFlaTmhEQUNJTU5YKzhnM1dhMFgzUWRkbENRS1BYTURBZHk3K2pvSDNJ?=
 =?utf-8?B?Si82UWJ6QWhqeCtmbjhkVVlGczNqNmR5MHJxcTlnMUp4aUY3RU5OaXhEOWpS?=
 =?utf-8?B?dkhlK2p3cWFodVljTGpHbUJlM3JBd05LVDA4dmowNTJ2UkxlaFNYRW0yMzli?=
 =?utf-8?B?eTlHS3VScHQvdWJJZnpndi9XeUJUTU1BQlFiRlJrRzZDL2YzVFBXQlFaUUxN?=
 =?utf-8?B?RGtENE5paVRRcWlpVXIwWjZnY0UvdDJSb1lFTHA2OEFPL2V3VDhpcTU1SGZy?=
 =?utf-8?B?WnFIeUtCRTFiWjlUbVhmZ2NzWWdZTjFaNzBJN1JPWjJhYXBBSVpNVy9rNXhQ?=
 =?utf-8?B?UVR1cTJGUzl3YUluRGZGOFErbFVwcGN0bmVLK1RyamNNS0RKZlZYUnlIWnc5?=
 =?utf-8?B?NlNuRUhHNUNOUlJkTUtFd2kzUzlBbVZWMTdRVjFObmtBLzRibjhlZFJuRllP?=
 =?utf-8?B?V1gzUkNIRW1CTzRMVVJ0dWVra1hnSWZETk8vOUczTWZVZnE1L0RtYmdudTFh?=
 =?utf-8?B?bEQ4WXJtUzNSemZFYUt3K3JJQ2FVd0g1QmRnQzVkMTZKZ2JkTkpzQjlpTGEy?=
 =?utf-8?B?WEZmUExuZkR5amxnSm11TU52VHY3KzFCMURwbXkrZkQvTjdKRGtjYW5nc08w?=
 =?utf-8?B?cUllaWFaeXRRK1ZlbGNKS0U0QWM1YlZ1SWxJV2k3MzR1V1l0MHlkc05vNXM1?=
 =?utf-8?B?ZVE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b1630ee2-b25f-4a00-cbf2-08dde53d9367
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 07:44:38.7176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aHL8icAeemIRlqVHy2egae/tjWjK+jyCSPn8IPuCoK03BbMq5UyuHDBxOYLoLHO1TLneCtZ9sA75culRtUzBXxpzU49NwIZneOQTkAiCDhI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7578
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

Am 07.08.25 um 18:35 schrieb Andrew Goodbody:
> In palmas_smps_val and palmas_ldo_val hex is an unsigned variable being
> assigned the return value from a function that returns int. Change hex
> to be an int so that the following test for an error as a negative value
> will work as expected.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
