Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E1BCAC5B0
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 06:49:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52CF78344E;
	Mon, 29 Sep 2025 08:49:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QCJj8gAA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69E3A80819; Mon, 29 Sep 2025 03:34:12 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84A71800B1
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 03:34:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=the1mHpmRyADovnGCRMMt57SCsATDDuegkwJ/5+ZWWlxsxF3d8+YILl7odPFTZjloHXZJuFQ1tzhkeEZrqcoarZmK/gn85Y0sWZiYF60Lf97BZSH9EGkKcL4gB/EkJZdIInN9k+aJP3pyXBgJrAi7T/cQRLlhLY/IsJWvuaEtAhoiQ2GSsYGyk3p43mdDnLbkDr6lt6+LRK4RFd3b73ymkdP1mbTMBXxg7Ns15Tv0vuw/dQc4HNGv7hE5jyE8ljFPPsHz1S0+Se3FT4zYpRNxFxs9oYg+X3/RZvIj/ZtvBx4II7AycH915jsPuZYIm5KDzv+2TciUMl5N2mdBH98Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LK5wLXqk6t7Nrrg4++ghW7L8rl6yXF+LKn7BiIvnWOI=;
 b=vZG+KTOuivUMNYahxV84+BO0YLGst68MDf2ezm+uRnGJHiHKVZG2kxzuaak0PZ/QDVJHhZ2Gwxmok5HL+xdDNFYaxBDVuLnJxxwvPYd5JZj/Qlbc2QL5lidoy8pHAkmdySJcSRSWuRwYyQf6yptYzDr03oePWTP73MiQGiY1bz5L5zUntYNO6l6cn2lk/AH7qTkPaHQic+WeBLCHQMJ2fF9Igb8/cetP/7yRALxDui8DJkoefWpTsIfwNjS0hEH4QioVHaQKNZl85PksIQxkjKoXpUlkyFanxtSxukQC9RUvNgPq3Ij5cKW4ocNVKFotOmOHBvbpVV0GKPWlwXP8cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LK5wLXqk6t7Nrrg4++ghW7L8rl6yXF+LKn7BiIvnWOI=;
 b=QCJj8gAA4gd5VGaL1njJgQOri7BJP7osXxBm0HdyWPc9rn1IKpstgcsqWsAIcXqUy2PtEb56NQJ1QTANpQRxTS6xf86njIHm9ZA6rHTwP1J6D9HUdIdFMkdpNK7ZdTbKMDYLbvMB1Jffaw8izGAvs0xJJ2A43ZaAiUnUOqj9BXTaHTIRRQuFk8Cs5Yrn9AbCeCS2WX+lhGqflwqdlmJKzGVMlLcP33p3RzDFBmUeEr23dJk8c/7HibMEBCqY00jXkxHCR0717CXXS9B7gUG4hnN8N4zfyNkkILzSVRQL1mwtGA6FBCGMdi5omOcwUAQrOmeVieuBW41WuRHfZIm3ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10780.eurprd04.prod.outlook.com (2603:10a6:150:21f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 01:34:07 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 01:34:07 +0000
Date: Mon, 29 Sep 2025 10:46:04 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] common: Make MMU_PGPROT depend on !SANDBOX
Message-ID: <20250929024604.GD4184@nxa18884-linux.ap.freescale.net>
References: <20250926153130.3680817-1-trini@konsulko.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926153130.3680817-1-trini@konsulko.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB10780:EE_
X-MS-Office365-Filtering-Correlation-Id: c931a794-1f28-44e5-f820-08ddfef84844
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Uxmtm7wQHn6QbDPY+9vvIkimoYiv56JnVoMRtlROT/+kmZYpmvx3vTpj+sF7?=
 =?us-ascii?Q?8rCCvkiJlKXuP3qvQfsS67ITOriHT+OUiQ4hBwOmQj+vwxxtJQ/gj/b4cPuc?=
 =?us-ascii?Q?sqn0BaWSwyKyXbcJLYSd1/abepDfrkGOFmbxADC4C/cDRA01h15zsCqviNPt?=
 =?us-ascii?Q?MqPuHDkfU37F0ai2LXq7RJExS2Vb4ZWAmIgbu8kYq0MkozetlDDyki4cXG2R?=
 =?us-ascii?Q?ufNcoXpolPcCMXlceXODBt9D/p2fYeEiMr6OhZPL7qi6hy3nZv2IL6HCuSq8?=
 =?us-ascii?Q?8mNLkjxMUVbipUoHQ9J41wDzBjn7EC3g7N16w3XiLeEh55MegjPY1TRsNMce?=
 =?us-ascii?Q?OyVwwRVLyOgvfeJrAJMJVqW6mdPPFU6lgwgABlztAJC8Ao9pNW3Fz1ibxKqj?=
 =?us-ascii?Q?+/ARH4ARDAtFz5uY+DROXSmim47/PWtodMrTkPp2+y2ODyM1nV1+6MLTycIY?=
 =?us-ascii?Q?MPCQVOV3yY4qK+PwBxmCMtWDKeGednNmvZW+5vlofveOCvG4MyE81EE34Fx5?=
 =?us-ascii?Q?0F+b/PzErqhx6g7qLWftW4WIF1cMpH6M3avQA8gIFP5fxH7EETi7k86oms6t?=
 =?us-ascii?Q?2SDcQwhMgKzRV1Z8Q5jQIifKJc9BeY8E3P5Qw2cbAV4EqQW5//xH3MHg+i1O?=
 =?us-ascii?Q?HP4mU0Vi2tagSL2Dg6j7UUIYJAI695CH1/5KBJEsmD7y4MkNY21xONQKNq5m?=
 =?us-ascii?Q?xpoermJ8NXYvxBXBF7FeDmCGS77JFVCXAyE5zRMl64zTESop74dwEvSRYY/g?=
 =?us-ascii?Q?aLXwj01+G5zPUvQbrtvQ4cjmshpD+myWBzW2z0UNYDHuzWaGYgWVg4u5/CHY?=
 =?us-ascii?Q?/t35tGd2B27zeOVd7/bk7MTVcmueyA2mcXZGB3X6HLfqziH+wV0z3hTkR26S?=
 =?us-ascii?Q?hrpAAkmVL7qrytlhNeEmvoP/xrj4LQqsfK3EsO2J0iNj2j3b6U/grTJle5OC?=
 =?us-ascii?Q?ELWpoJO9WP/wRkibRXaNCFzllN99XKSwLH8sVDgqavmsWZyjikk9HSjH5uA9?=
 =?us-ascii?Q?l9CCw8arY1FV+UzSSek4fo3Zpk6hcGbNbct+BmaVvUqM+KPp5QyPmI9gETOe?=
 =?us-ascii?Q?Ds6fd4yg/gqsT5OJf6sUDH+Y0bzjtAOwzXEGxMGz3zBqiz+7y992FPcVC9Zd?=
 =?us-ascii?Q?UOYvSfhcpdZlRDz2GedjBCIXun3EOxJ24PoT6lK1zGKpLi3ZFVNSh/+nzHu1?=
 =?us-ascii?Q?9FOpb+GdkuyQqSDcR50fbC3a9XBGCJb9cM6+Okk28Lhpb124DW3er/rJ3IHk?=
 =?us-ascii?Q?iL1LinZ6B28v0xI5G0KpVryBC3v5yFDiMDfceEw35zlew1iCvFtRr/63N79w?=
 =?us-ascii?Q?APf4VyX6rFg/QDoJ6kmgOunpx4/211mDZFfGEWWMz1p6vjLLSwiWYLyO0k0/?=
 =?us-ascii?Q?aw/COjGHjn3bzdbshph1Vnp2gxndwe0tMKJwob7owOXJQS50NyUAmiNhpwXR?=
 =?us-ascii?Q?hrjlF71u3n/ZzQA2yY0qmpgiTwcC6dXhBxg3N75GTHI3QI2nFdbfPDBH+tcA?=
 =?us-ascii?Q?fooS60AMLVh8A/LUOL+Cf407suUrXZl5vDCS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(19092799006)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PIu4H8mzNoOFZnM4am2DFtheEcmpvdmQPseTnO+Fxtgt2odPQP8848maQIuD?=
 =?us-ascii?Q?o6w3/7HPZES2BdE6TKeyi30S2hcUH1ie3HeV2gkeYyyTrkGsImB+HavIjpTS?=
 =?us-ascii?Q?QIa91hYzCBDRVkfE7sS4/VE7Z0Sqrc1WdouHjFPG0YTH5741ZCJJi6SLGebX?=
 =?us-ascii?Q?kdddwvD+b3zPqmWM4Qvb64XqYmB1LwKDxNCyfpR8KslilTLD6yX1bqEEXEHo?=
 =?us-ascii?Q?C+r4gSCIEdm6JvsRWL6/c3U9vXPQQBt1yfWFEqhK5ofQ3qD/z3iyX/meF9pS?=
 =?us-ascii?Q?R8YiY97W092WbwOaF1XS02bs8Ecj/3lAv6WwNK7bGgVlI239v9vwOoW1Tbex?=
 =?us-ascii?Q?8A7rbBcjYaBm+s7tcJah0ZskMKSBjnIdz9pPMbeHQ3pRu7kIMhDNQgrCQb0q?=
 =?us-ascii?Q?XjIf3kljbRzlMx1M4p1X6UIoMpdxVuYt+F3VtHRge1PdiZqlcZGLh1zdyWna?=
 =?us-ascii?Q?4gkiPhNBRzckx8riOXLcC/xYIVC4E0qm58KiZWu2/vlbF6QDRJNrI6gTkXjt?=
 =?us-ascii?Q?1Z5C3OTIMyVEq8zcvZHYGzncrbbV10tAwWzkVEg4rb6ZUY2lPWcLuQL5/npD?=
 =?us-ascii?Q?jwSo6j1dR1+x02WpdDBOaqVten1H3sHzoWuEd/XOox8jhtV9mWXvpSxtP3VE?=
 =?us-ascii?Q?VXcpLY6kLJ9KhPOShrNkVy+3AKhfaljfF9IoaneJYmkDlFrcPGVy9ahXYWUZ?=
 =?us-ascii?Q?uFb+CpRDM+HRMTTz6Y+fpw91q34X1t5SlEgdTDOFdCL+Z3eEGAXMegWaJmcF?=
 =?us-ascii?Q?Jq5kpCkkLjCuij+iB7DNlG62Wkdt8Zmvd7yXYW3xECWLbrSUiBsiLSq+71hH?=
 =?us-ascii?Q?b9zzxR4iX5rPHx5iJUfBcjZjeEoLS8wHKq02SranaxicEjJqwYA9Ojl5lnPF?=
 =?us-ascii?Q?0L1S/l2akZ+ZXLIGF520UcXwjc6uK/WNIwZGWp9E4v4d4LF3surMur5nmht1?=
 =?us-ascii?Q?MSrjVzg/c5Kid0sxGxEVr1W0gj4vX26Z1UjbqgcuIOXDKl2S9qoFqXJhzxeQ?=
 =?us-ascii?Q?1nQKl/ZfhP/amJWq7wUSPHRdCjQSvJOWxnqTpaRxEOcaiZ+RRLxtVm/Gchnm?=
 =?us-ascii?Q?iDsXZa3SG2lVAyR2cE0b+TdR6lLmjLb3IBaFHEvP9C2B6XJcb0lWbiAMdbh9?=
 =?us-ascii?Q?/fF5NV6k6QDr29kbJbQ44I5XMGtrUGTZCthdlq3d/mFpijRtBYjcX0U4IKJz?=
 =?us-ascii?Q?RjQ92LT6WXSYXnZe+vjd19ia6bqX4UJ50evN5hClDzKHJ7mQt6dHxeFizc3R?=
 =?us-ascii?Q?SW4tDkl3zLV358VF7L3ug2flbYbzv9caUyUUaAl00z0KZmQfyrZF/nZ2VKEK?=
 =?us-ascii?Q?OqK/KUJn37PTtZDfIknS7yPBDDXVADeJwreJImaIE5SvfHXVT2hBAy6hoW7b?=
 =?us-ascii?Q?i9Px40wALjFtnrL3uhZCYlLxhTQoI5ytbaawfvRLXow+IRjJvNRoWr9X5E7u?=
 =?us-ascii?Q?NWgdL1p3EmXRfGbC2G+0f7sYdGg9fd+gSfQtYaLV3KSse6PUVy8JYWYQLnBJ?=
 =?us-ascii?Q?lW9ZXxGQ08HakNSEE4IpErCMnoknbGFfaCsWMlI13FICTlsWi1i4rnvSO8ky?=
 =?us-ascii?Q?9Wh/ZfVupaltEu40Su3bBjA/6oVTbAEyAFg6K+cF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c931a794-1f28-44e5-f820-08ddfef84844
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 01:34:07.6181 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cfoWC62tAjH9rlq9AhnwjQqjMdUoK+aTQK9EOjInDdj7TQxyM0L2SjxkKU4vpRQdPiUYiuvF6dJE+kpQs93dmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10780
X-Mailman-Approved-At: Mon, 29 Sep 2025 08:49:07 +0200
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

On Fri, Sep 26, 2025 at 09:31:30AM -0600, Tom Rini wrote:
>While MMU_PGPROT is currently only functional for arm64 it can be
>extended for other real platforms as well. It does not however make
>sense for sandbox to enable and create dummy functions for. Make this
>depend on !SANDBOX.
>
>Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
