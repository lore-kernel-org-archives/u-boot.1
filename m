Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 197FBD358F7
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 10:54:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F6C383F59;
	Thu, 29 Jan 2026 11:54:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="B7meBOm4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ED1A83F20; Thu, 29 Jan 2026 11:54:43 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D0F683B43
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 11:54:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oip3lNZ41DH/sVM34a1I6XwbrBgAnA/ykZlEgvJwjApL/NeVyZQIXkDQefgydmtuut3dAegXU6x4Li2cMGd7t/tthjPLlkI8S94uChjNgUXzUzeaRTchBsMdj1MhHToHt7WFXuhRO3euT/0N4bJAXtzO13FJYCAYBHHY9cPxqZiUpujM6VKMnu1gtEhPbM9OxBKBBkmLI5IM8TjV0r6yVUKi4MPAJwrhSnlxZoC4ZVJjgC/9jVjaAbbcBMKwCW/5zA+KZfWWo7UEiLW+kUYSLaiYIHfsQkhSsWh0XVb/EWso78Cdt1lGGNFUqL7RYWC5MAH4l+pZRFAz3VboV8VSlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOv2foZYBsk4O/M2uyHEn7920xr1j4sKvRepf/qcGtg=;
 b=r5aPNbuFJ9ysjKCo0Bil1hJ2jU4yNCZ+QMiUa6T2Ubdpnhut7Oorcaif1y+wVrw+Qh0cZ8TeIyVuQkfKq4i3txcHc/NGGOmyu3s9aBXL+b7avLZ7qVAOxuMgpLxWwVx2a00ZqRqbUSymqNCJ57ko7T3QT/YE+n3SY+yxt1ZYZpfd+hCcNOk0JU/tmMZU0ad+Kuj7+PGYmsPMnyGgUavrLLKyMkXgrgr3oJ24bgcGOOjIagcbWvHB4ALxSgCb2YjpL7IBD37J/hUC7RE6W2D/wnidTkOv3qkwBEhl5piZaxxta6HZBuQOT64/nHodaKGxjogqRh2gA6xA9nPAMuKaRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOv2foZYBsk4O/M2uyHEn7920xr1j4sKvRepf/qcGtg=;
 b=B7meBOm4Kn/imOzshYfjKSZnSp+cYYeQ3P1c15pyK/CD02pXKuqxawf+UPIlm/Xn6KighHwjSfzo/v8+7wqf71JtdQ5pOR52Bud4xdd1tFWjAc78hyYoV/ST/hQuLvmLcbt7ooYNi8a8xkqgo+b0bioBfiasqkRgzgSr37pi3I8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AS1PR10MB7936.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:471::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 10:54:37 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 10:54:37 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 0/2] am335x: failsafe bootloader update
Date: Thu, 29 Jan 2026 11:54:31 +0100
Message-ID: <20260129105433.2624686-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPCP307CA0001.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380::11)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AS1PR10MB7936:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c4e05f2-1eab-4bf4-291d-08de5f24cb8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GvpjrlujjxUBYvipgod8rwoy2EZEGPhMXy3n50x5jzgAMFB5iqfSTWU+dtaq?=
 =?us-ascii?Q?z0GmBOBnp1Ob/81yRyQuAcFuu9n4WMMzu8Rcf2/iBkWcMVGfCT0pjkgEGAih?=
 =?us-ascii?Q?p6DmOm9KHmxU9uixZTgJQoSTnBTzIo/9jIjBuNLR7aiweaup3rc6tS+JEQHt?=
 =?us-ascii?Q?13aYZvFf49WvRSnyVVrBkvlaccqd2peS98ptEXogmxLbJvZVIj3ys0ocgQP6?=
 =?us-ascii?Q?62Z2Dzmr6GT0g2R++EIA8l0E5s+yQbAA3yrArfpvshskDb3cqVbT2Qpd2DJ9?=
 =?us-ascii?Q?QKRSRLIeRz5mODykV66/1iWOB/KmtI8iSRRlzH2Za0PoiDPgLKlbjO9Eva4B?=
 =?us-ascii?Q?VnMUVFTMoIdDiIMh4oysC3Bt8FYMDv35dFC5QWFGP0C1+r8jrXEduXwy4rlL?=
 =?us-ascii?Q?dcLHs+RDmjDxWwWO67UtDwIKVWn8TMPNElAyWnpnmQ+w8KKfe3xCre1v1G5z?=
 =?us-ascii?Q?gqmC+j2b9a+Ut1U51aULbkHlCkWix0KI5iqrdGvwMh14ayF9NYM5Xr10vA3c?=
 =?us-ascii?Q?yqRqemAJLZo8oII1xLVQGk+rQU7aolcq8MHtS0LUSvw96h44QmKQUG1fdYMt?=
 =?us-ascii?Q?mdgNUKHMcaqgHiT6GyE0id9kelMDXZ1JRcmgPytOByOpBOpfeUZtuF9AcSKV?=
 =?us-ascii?Q?uj+ykjfa2JOCm+N+yL8v6btmF0IS+VxUE3s4E1gA8L5uszNeCM0f9CZEZc3u?=
 =?us-ascii?Q?LoCvbfYljaX7hNu320T+CrMsPdyp1EvjnA5WtfFOWKusoXsJeH5oJCHl/Cap?=
 =?us-ascii?Q?ff/qRtEQKfB93YimC0sMaRGiEZcesY6QQ8jnh5elZ+RFcJy4ywQfu5u+MN9j?=
 =?us-ascii?Q?7sz08WyXZ3Zbp7cdsdm3CveJHU7qHsnT7sPoJnH+IffTZBiMiomOa89a5IG5?=
 =?us-ascii?Q?/nKRlvOQ2OCl8mvpldFztXVDxdZpxpC2nnjAKgqAbUuxoqeMDQLKw0dJ7XP4?=
 =?us-ascii?Q?Yvp0UVn82F9ctTDoi6lnYrzdfYpqvYYFpIq6/dh2kZrUQD1isqaPITVeKUcS?=
 =?us-ascii?Q?xv0XfMgJB7fs6IfNmgwASAb3YITqaD5120uOS0vRQnVgso3ak7065UihULkj?=
 =?us-ascii?Q?gGJZNilJoi7qvBeiVmxfykpUK45BUpCBlFkw5ryuGlqlikrU4mTevS/u0H2/?=
 =?us-ascii?Q?RNR3iI7ry0BGWhPftAvLgc/zOem9isN02hEmd1xZgvr8QNKUrrA2hRyszo6k?=
 =?us-ascii?Q?PHBrNmB0ZEYPzhhnIKA+TKATYv6cEIEa9fajvR25s8wpklFqhARKEf6WIxQO?=
 =?us-ascii?Q?l0Gpsu0j/kM69WE4uhvko1LufwE4VGBr1/D6ByhJMKW+560AcsOCD39/u0c8?=
 =?us-ascii?Q?yS1Lhp37SoF90+NUeo5tO03errY2XNLwqc9V5YFDA768V0t3Kk/JDKKHUqY9?=
 =?us-ascii?Q?rdH2NWbQcmieJVefOBhLP51iWCF1phBOlWtIotqv9eonBa8mWodz+hAehPT5?=
 =?us-ascii?Q?4ebZvPfEPG6ptXBZFy6ilCpUz5ZkZWeGz0ym0GD7FFQr3K4QiKciiTK48LRC?=
 =?us-ascii?Q?ii+lApsmc82RCPDt//xJXGHXuwGJKrKZzkVzXhdX0+tQerd17rgKA3m67l6M?=
 =?us-ascii?Q?KjntN5t0zPVqQRDy3r9j8RRVJTKtnI1zYeirSnHESfHuzAlVmh9HoRukltYk?=
 =?us-ascii?Q?pC+WnWlwHEdmdHifd6ub4aY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iRb6DrJkV89a9kbIyVVdZXlA8oJzqGLkCKJRSXSJ6z9juVgWuwBv6AdO3FlK?=
 =?us-ascii?Q?9WnagtX8ssQOgoIffEPLu7kGd8AslUWzYgaCAMwKpXZOhtEi5le6NindsEiP?=
 =?us-ascii?Q?l4fUNbsnuCOEAcuVMdPpk795CHbbBnFEnJ5K0atafyFMz9yd8MltAy7tCm/d?=
 =?us-ascii?Q?MZUxsm0P44DtUBG4f7ihPlOqGa3Z1Zk+FFT2FJS+kRXkNrnSd2tuSM/w277f?=
 =?us-ascii?Q?Gv0nejpEpgs/U0oka8G9lCYX1Uf3qA0JyAdexaojxlVBQoEV0MK9PiefqSth?=
 =?us-ascii?Q?i3OyMcl9Zu9bzXk22RfjvYL0HqKO7Kp5hj6Vji8RJlkzIGPkafJ1SJwkrF3t?=
 =?us-ascii?Q?JS3bVNIbQMKM+8jctMvSEXsxzrMEgsA1q7lyXwxr5SDc6/ldgVXa1P5NXnSE?=
 =?us-ascii?Q?Evwl09sRyQbO6GHsmRakRhVccFT+R8ecxq9W3VJt9w1EU0wmJauM6cApGYM3?=
 =?us-ascii?Q?cPnEjPiGe92QGQv8InG3lK/qPIGwXd5Lxdw0tsIMEzF16+EPilBvv/2QXx7S?=
 =?us-ascii?Q?8Ua70AcI6JBmREsvbs7lj2wddp2srB88sX80h2cgzB5RFF0dZl8AEd07+Jwv?=
 =?us-ascii?Q?MXI5jErfwUGFJNNnYxH/H2zUBVvzYy8HulQBQnPdak1s1XKVg7wXP3VIXbo7?=
 =?us-ascii?Q?z3Efigzh4lTMoos1Dt/y+mYSN2wfXfvw9BlFbDC7sJXxIG1E789lX4tIa8og?=
 =?us-ascii?Q?0q/i9zNXhMht/CzAGFZBZ7eepHsrCufV/DmjN6SeBEwUrUy6Jonqvdyhi2FJ?=
 =?us-ascii?Q?hAPfcSYnV+VE4yMiQBAnrgfOKkv96Wp6ISF1+BxmW7vqn0usUutTpX0wfPSg?=
 =?us-ascii?Q?tRGM4ZDvfxri7VBV9AONQyHgmKBIPRkmv/BTI2rxD6E9uJBkBihewf8B4kd5?=
 =?us-ascii?Q?wpTAjk8ogFFN95EawIQPNZ+NxrIEWkIJUn87ZZDeBDNALbX10eUO7zIdyhQT?=
 =?us-ascii?Q?adwZ2DIIECHq07qb4TQ6gxvr5sbLigHDw0kU36z8bm4mNfSZKNs6NNWFbyFI?=
 =?us-ascii?Q?Ry0wdSeslZDzeX3W+ZJRrmGFw7ZQUIVWOE606udrsNTXtjVtaLSf4hPEwRFO?=
 =?us-ascii?Q?o0Pwu6uCj5NAtBJW6GYytS4JdQMQHa2xD5/c3PNF951RJtTSiMLKzj6ubbwc?=
 =?us-ascii?Q?ok9M/cMRoQO+q1dvWsOWRw2u5YBJHYmE+ce5hwxVF18sF0fbsS2svd8OLZq2?=
 =?us-ascii?Q?oCIGrFoGQPN0Fq9dGmvzbtbyVNdACXS6YUrOHon22Zto2bvc3yh6IIISU8bl?=
 =?us-ascii?Q?MgiWR/9dhNpqlECUSmAjFzSqP1BbNnoPxrGV2GMcczGndmXHcHdhc6OFRmV9?=
 =?us-ascii?Q?eLtJ8b1+l7UmrNVemqcgFHgNHHGlX0fHLCvRBafERu1DrQYyLCeEU/rhKR3P?=
 =?us-ascii?Q?836sAu6ytVneLCeuzquTG1f7gSK/NDW7kfdlsZAKX9OLNdMF+6INLuweO7/d?=
 =?us-ascii?Q?5nIa3pzdw0DaLW7EvhjgcQByOvSbIBVjVtHSoS3kwIDZE2G5ptG8N8XZyZS0?=
 =?us-ascii?Q?hMzQvkY9zGGhbkBxXR4sdfAGuN/dqEn2ZOnvzFZlLb+rKwOUrLVFKDUkUrKz?=
 =?us-ascii?Q?/zwIXHdqaPvvCgUlZML9mzvaM3qevW5dHoLBy6xzYIdTnUhZNKv72/gQFXjj?=
 =?us-ascii?Q?1VotLpdY4GluLMGQGrrvRQIEmRESgeMNAqI4nCvY8M7ndcLKD7m/JEitRZNa?=
 =?us-ascii?Q?Zh8M/83m477qjzTTutYSVVzG7OI83VAHXnArHgkg4S21NwHUBvv69EEsVXHK?=
 =?us-ascii?Q?UF1PiL7MAuztqcVQQSdKsooY4jCAkaA=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c4e05f2-1eab-4bf4-291d-08de5f24cb8c
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 10:54:37.3155 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oXjmukoQ+OhR0Ehxrsf74NQRgZrq1E1inAqOht6rv5EEnQhvLTTQz901LnYOz5z5khYjLPN9/iSNxnLna0p0jjC8HnQjtdFYcyKdokPJXiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB7936
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

Make it possible to update the (whole) bootloader on am335x robustly,
i.e. so that a power failure or random OOM killing of the update
process or other interruptions do not result in a bricked board.

The order the trial bits gets set is somewhat odd, but is clearly what
happens, and somebody else trying to reverse engineer the ROM code has
observed the same thing: See the TracingVectors.ods in
https://github.com/sjgallagher2/am335xbootrom .

v2: Add patch updating documentation, including a sketch of shell
commands that could be used for the actual update procedure.

v1: https://lore.kernel.org/u-boot/20260122131728.1551365-1-ravi@prevas.dk/

Rasmus Villemoes (2):
  am335x: add support for loading u-boot from multiple offsets
  doc: am335x: document use of CONFIG_SPL_AM33XX_MMCSD_MULTIPLE

 arch/arm/mach-omap2/Kconfig       | 37 ++++++++++++++
 arch/arm/mach-omap2/boot-common.c | 31 ++++++++++++
 doc/board/ti/am335x_evm.rst       | 80 +++++++++++++++++++++++++++++++
 3 files changed, 148 insertions(+)

-- 
2.52.0

