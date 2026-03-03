Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85D1EDA68D
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 16:00:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA0C6839DF;
	Tue,  3 Mar 2026 17:00:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="oNEoBQzg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50F9083F63; Tue,  3 Mar 2026 17:00:36 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44FF3838BB
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 17:00:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mQ5OfkUXk0NiNBWRQP85UU3c9WCONOhmK/RN3K9bQyA2ODBtvUA63DxS8gXFTMpniqK7d8hCfgZ3YO1hxHkhUgw3sWBlNlDLvSt1e4y2MRS38aDodWrKONpd4z2i7wUmDFxLzkhkmxTNavhjSmXQG4e1cUKzO2Oxl2wybxJYdJ2Rmp9yBJmR5gelTpV2gXnJPurswR5ZKt1Z8fZ0sFjQcRd+IOyFD+GTKi1EHK+BPGseade6bs68siih9SLEEOa5nV8WTLAZRf6zqp9C4IlH4rCClaGFzcollYFhFFbsjOuCk+6l791gkewYwMYp+jhHGrlTydqwYS7QqJexZXJU6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUXdZg7ioXLFo3/ln4at4catxgWCE3K/vflGUAgA884=;
 b=oLpZ5wGGkWT59y7ClqHlywS1ll1VEUCvkU8Pr0MNrROTSqZR4utdUVTFMLgdYCoENyXO8HoNg+4aHXgU4L8/8ifYT5mAR2aJa1gVa8H9f5/VBWc3cmQyLz+mYnByuYv3LmWrQCv1OadK5F5eiXo6mL+bp6HiXlMAht4rF26j+BculA2nJHiS/3465DIGyavFcPGXp2LSe5bHFTcDzJn9MsN/kZY2HjMsgc6dEcsat76I2SjyQqEfwUuHRjqVPiLNTNtljQjRCey1EFr8Qx7QIs61Gz3/X/FSA4kDrXtEWNhe4Flo23iwBP+H2an9LOqgyYCJJ76yFjWAEdGe5p6xSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUXdZg7ioXLFo3/ln4at4catxgWCE3K/vflGUAgA884=;
 b=oNEoBQzgHSO40hfo5DwQYle0EEfPk7pfi1TMlxRbgBy+iZZsW4aofa9PdF4hTY32JF/k0zfq8JnmIDcBy73yIt9Vomdlo5reLP752m6fCvHvRDXIYZhUH7LJVU71oyJnSKkLvQ0+lO+795jzFtJRxP0Og0G2SZgP1w/X5pDqC1Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by VI1PR04MB7008.eurprd04.prod.outlook.com (2603:10a6:803:13b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 16:00:30 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 16:00:29 +0000
Message-ID: <35da4878-a939-4cec-9433-dce1baa97191@cherry.de>
Date: Tue, 3 Mar 2026 17:00:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 15/16] binman: test: Move remaining test files to
 test/entry/
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Neha Malcom Francis
 <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Yannic Moog <y.moog@phytec.de>
References: <20260226234802.345968-1-sjg@chromium.org>
 <20260226234802.345968-16-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260226234802.345968-16-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0209.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::30) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|VI1PR04MB7008:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b0cc9f3-abd8-4b1d-4dbb-08de793dfe09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: f5d5zrrXz3iMen6AqEau1ssK8lcBAD0ADzhJQzQ0rWzE1DhRIcJl8gqMupuNoc5J9NAbD4BjYz4vw2f1TcHgos03mTOUGmglSD9EzR5eHlWO0cvrv3gbYFkl6qC41x7+Xghn7ZjUjg3XRkUDQTo8qYBuaWKLe9cKZx6LyP8NaItXjk8dk5Hi1SbpG7h5CoTYoiH756pJrh8UG75Y/XfzGzJMs5r8ENJamJbPieRgglxeb8FKH4zB5UWuxLgtqqTRck0LWMS14f6Fd5DzKRwtoh8cDia8WUTz/6bgPl97WeqojZQeWVMJEoKTHzO4Ei+7CxZFRouqY7a7cLTO5zIcMyO61rFhEMjBq60JBQGbRg3m42EmGKYc3IGAOiRIRPUVFejw9y0JtAWLRvHiQkxd1cR+mOzYqkR9KEoAJYLUOQmtXZ2DVgvMII40uptxiQNNjIXZ8p4lFdAD/ASscvbUets9xCy89bfF5Xtt257LFMk9f8Bw/vh4nBbmeZlw3xwd85DN6Ff6TGCYI9bc3GJW+TW8OlYmHW29G9gYu5TEKLUs/JN0/L145KtO56PDl4oI+xiByJekIJt64TMJ3kCYCv6Uee3dei3vO8vN97mXhUL1YyZB6j/6ugzHxycl1ZtmQ1tn+idYo3tzEkRFEwQHuErntMqQvMLAnqMmcZn/LG70fd3DJOi0WqFgeuqERSDCfKU9NzX9RgxcKJErao0ETLVUUCSJ/rLKNvdQrR3Ut9M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZENETFFMdVV6N2c5Y0FMTHFadlhsQ3VJTlZremw2NUNYSE56SjFyamxQay9B?=
 =?utf-8?B?SWlBcHRwZXRhVWR4R3B5azRRVTFENVNRNHQ4TG9ubWxmVkhvSW43cXdrWGNP?=
 =?utf-8?B?RmVqREtzbkJIWkp4WC80Q25qQ3p4MmozZi9LN0Q2Nno5VmxBbjRRaDcxT0J2?=
 =?utf-8?B?TjZ0MFpRMEJnQzVhNk1KL0NQZHBMRGhPc1dpNDRqdmoxVGx2U3lBeWJRbkRT?=
 =?utf-8?B?cEhlb3UrZlRaTEdHMmE0SlEvSnJFdnhvRFZlQnFoKzR5Q2k0RnZmVHkwSWpN?=
 =?utf-8?B?RE80QlhnTWJtSE5BZHpXb3gyYUtUWDlXelZ5VktXdSt5Mlo5ZkdQREF2Mzls?=
 =?utf-8?B?QmdSVVRqUTU2MEphU0V0ZzZBeHBiWEtGMHFVYnBjZHNFdkd0UnVlR3BHSnpI?=
 =?utf-8?B?cTRyVDh5YjhBQlBuUVVpVXBPeFp1b0ZCTWR0VG5ybFNEWmtLb2JNT2h4OERT?=
 =?utf-8?B?VkJzb3dLOUt5c09oQTEvOFdadHUrNXJXc291VWhoK0xKOHhsSnpqQzhqc0dS?=
 =?utf-8?B?UnlGV1hrUTRIODZoNTBXTDNMZHlwMURqUW1JenZqajJ2TUc3N2dEK1pQckth?=
 =?utf-8?B?RUdUbVl5TFcwZWxBU2tWa0RtNEVhNitDODFhNUFpSUlPNEJ5WmI2VzJ6Y2ND?=
 =?utf-8?B?aEJPd1BKY0daSktnYmIxcXMvR2NpbVdjOGJhbWQ3dmFXUlBQUFJRVXEyZWs3?=
 =?utf-8?B?QkdhbmYzbHRrYURTRDFXWWN5dEpwdzhLMG9Ucm9uczNldERybmFvOVQwdnNu?=
 =?utf-8?B?cXFlajhWcUwxKytJdm5CMFphSVNieWxUZnQ1MUVpWTVtelVRQ1pYYnhBN0gy?=
 =?utf-8?B?MkJDcjVWY2VjWFJ6N2VaUE5jS3ZrU1hSU3BqQjlzODdHbEtWTlVEY1kwKzZ3?=
 =?utf-8?B?WUdkKzhXMXJEQS9LRmVhVUxaM3d4OFhWOTVYTFp4aEZrS2xRYU5oWFRZZ1lB?=
 =?utf-8?B?a21iSXhENHlldWRTQWxLSkNHQTRqL01uVUtHYmJDNlFGQWNFSnFYWVRuTGc5?=
 =?utf-8?B?eERWbGVWS1g2eEwvd0d0MTNCUGZuOTVUOWhZMkwwMmlVbHNyaC9WWHl0SXZs?=
 =?utf-8?B?UjZ5Rk8ybTBvSnJaTWc1S1BySXRKUHpRVzFXQWhFSTlYL054QUVBVndUMm1y?=
 =?utf-8?B?bFJnODZuWkc2Z2tTeXhGOHhZcW5JcUV6RW4rYnVPek5Zek96cm9MczRoRmJN?=
 =?utf-8?B?Z1pqQ1h2REozSncyUTF4VXQ2T2hBMldrOFM4dzRvQnc4M0RCMFJCeGVyb05E?=
 =?utf-8?B?NFZXTUp5Q2hacDFVQktaQVcvbmRaMjd6TlZDMGVsT2h6K3J6eUZyZU5sQ0Za?=
 =?utf-8?B?cVNlbW5EK0R0M0tvaXRHL05hSWhmLzZ6OENBd3ZyWm0rd2ZEU2FZN2UzWWJi?=
 =?utf-8?B?em1mUDNnamdLcWFVNlU5L21SOUJHbkVaeVFkQ29oOFBjTHRwbWd0MjhXTVF5?=
 =?utf-8?B?QjdHOE1vbmNWUkM5ZVJMdUxMY0l0VnJYbnJ3SGIxbGZUSU5VK0FKaTdxbE80?=
 =?utf-8?B?azgxcFRGSkJacGRnTWtVa2wwRmU2ZElZclF2dVoxR21HQlgxVU5UenRHNTRL?=
 =?utf-8?B?cWxoelNrQUwraXpUVURqNWhmcnlkMHdNOXBEejhyN0gxWHJEcm43UVZVdXZa?=
 =?utf-8?B?UzVoaEJOZnlpTXI0bk5ub0ZMaEN2V21qREhUb2pNcDNrdysxc1VHeHhSVXMy?=
 =?utf-8?B?MldMR2JFbEJvc2lhN0UxU2Zuc0I0SDZpVXRvWjdxSFZZK2Rxemh3TC9SV3Rs?=
 =?utf-8?B?ZGk3alhCT01UMFl6UTJ6NHlSSHNQbnlJVGloWlN0QkxwZ0ZpL1diT0xZUXVl?=
 =?utf-8?B?WmtyZkZqdms3RldqSFAyM3lrNFhHeWgyNHNBUDlHczRPM0d3dktIRHllTTFL?=
 =?utf-8?B?T3RUOUtoOHhOS1dSa1B6M0lNNFFzdmNvQm41UThMS2FjZWtlSkhJWjdpeFVq?=
 =?utf-8?B?T09HOGtKSVBPMzVPeUxxQ2F3RExEVitEbmEreG8rUytBd1NyMnU2VUF2QUt3?=
 =?utf-8?B?MVRIazQ0OE5CbnhSZ3NhK0w5aTRCbmtJNmN3WU9Kam5nOElQYjlpT3NuL0ti?=
 =?utf-8?B?M1NwdHFmL3VURkNGdHN3WjVoUFFGczhDdTA0NUVxalNBU0Y1cUwxN2ZSVXZ3?=
 =?utf-8?B?RG5xVWVSKzJxSVlVR0g3TlBtZVVsWEdSSU8xNDA0Ri9yZS9xN3U4RSttcnlk?=
 =?utf-8?B?WTRmK3hNK3ltbmJXWHVVNGxVWE13MFJUK1BseXN6c1ZDWnJjRHdlRVpoUWNx?=
 =?utf-8?B?OVQzMUlkQ3Y0NG5jMVBtbU9JS3VwWUowRDVrTkZ4Z0t5L2xaRmo4UTdSVlFP?=
 =?utf-8?B?bGZCSUNGT3g5YUVRY2UxUVFTUFpDV29kNm8yVE1MZzA4MWhzQk1EUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b0cc9f3-abd8-4b1d-4dbb-08de793dfe09
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 16:00:29.6487 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JaEgGJPrdGYxkpJ4r0jL99qfibkG+Qd9wRoEydFrfCde9KPLJs/tEBSb2uNyUdj13RfMyhqVUuNrJ+gzR+trRhgsV6P3JJsBNKyxrzXciiE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7008
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

On 2/27/26 12:47 AM, Simon Glass wrote:
> From: Simon Glass <simon.glass@canonical.com>
> 
> Move the remaining 60 or so test files into an entry/ subdirectory.
> These cover general entry types and features: entry args, fill, text,
> env, compress, replace, template, collection, ELF, overlap, listing,
> sections, symlink, TEE OS, and other miscellaneous entries. Drop the
> numeric prefixes and update all references.
> 

What about files/*.dat, blob_syms*, key.pem (seems to be used in 
security/ as well, but duplication/symlink should be fine?).

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
