Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA1F606A327
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 04:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NRNi5ueX;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=qAGtjBUi
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BAD3640B1F;
	Thu, 12 Nov 2026 04:24:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QeB4IJUCi6pd; Thu, 12 Nov 2026 04:24:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AE40840B00
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794457484;
	b=m7GU3AQVD6znuXhizfzvDslE2xkLNW6PB9bCwntNsI7VNfh0R3FnLXwOlZ0bjIb3NYxS
	 LMQ3+sff6pt5GM9HWhCCyXWqw5sG0jDkse+jD5iY1T81iBvbE6puVjT4bwhwHSsXtcKKG
	 BIKXrAlO25A2Xav4U8xVfG7StT5CaT58PAZE6r+uFRYdN9lWnhJ5DOovFMKtWHGEXwgCY
	 bZI2EoiuYBdxOtEkW6txZkKF/wK8oVIkKUKNoZne65x4U+88VlDjb50bW8H6gk9d0zmol
	 ciTljduVxJ42kgaC7X+w25TfYQAOyoKXbA/b6TvkIuCAmkgs04fF4ognpaJPfXXAH/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794457484;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xFChufy5LxvchtFESbqoaAFU3Uz1BisEzaXL4yBcmGE=;
	b=iHiGhSdqRawvhWlpinXJkUveJjgMAf59gsA0IDX8/V8uhlz27CSnEeTO045vTuTEjm8+
	 sCZ7neCtm6QeuoQ19SRP6VtbVIvBq1yiCXwACa3ccZIBfKQyy7FAMQRIZBYIwaWX9X8C7
	 y+Un8Z6Wd4Hz+leK2eJTdFnNsVshcc114CEI+9ob39Cz6JCI7gh6apnSGHJjDJnKOUFXE
	 uT8W/Boq/TfGX+Tr893YtpdSc7h2WFFsh8fsGOXqxcGqtjjit36EKRSofSZfzVd3r+3ZR
	 MYsyEIVq4fuTDvRIGTqJQPzc6zqvp8RvIN3EZjp1WkidHaj1VS3MOW7YTcapIaQcexw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=processmission.com;
	dkim=pass header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=qAGtjBUi;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794457484;
	bh=xFChufy5LxvchtFESbqoaAFU3Uz1BisEzaXL4yBcmGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NRNi5ueXqhYRocRcROMJdH13P1BtlgDAuwxMoav0pKXwkLczP+lT34SQ/2c5epm3S
	 aUe43yf7ReRW/QcNdMR+BNMBugtM5s0zHbuRofYhYDDEwK1gP3Aj2xnyAYP2GWIpTF
	 xExH99PFZPnpPQn7l7NpUDNI/4Ak7sAml2QG5p+lN68ZIFvZYzHhfrzIYMx7HRZSIa
	 rQag4spgYoDluL+bqDPSMs9qOrbhqE5FkShJG1hRsCedNMiTXfmiZFKDbQghwzuLJd
	 sFImc4ed7ueIS+CZQLxXSSIKJcuSsooO/K8nyNkCi/PvNeePymSHq6cAUKxzHkzQ6s
	 BCgYHshac191g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AE40840B00;
	Thu, 12 Nov 2026 04:24:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A0ABC1A6
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 03:17:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8535140A32
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 03:17:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bg6aFlEF6FH6 for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 03:16:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0EAE240A30
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c406::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c406::3;
 helo=os8pr02cu002.outbound.protection.outlook.com;
 envelope-from=bin.meng@processmission.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=processmission.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=processmission.com header.i=@processmission.com
 header.a=rsa-sha256 header.s=selector1 header.b=qAGtjBUi
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c406::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0EAE240A30
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 03:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFChufy5LxvchtFESbqoaAFU3Uz1BisEzaXL4yBcmGE=;
 b=qAGtjBUiIKsn/nGen0sA4qdsk6orJNFkltsvClBEWaRiZ4wBvRo/snnoAXP4iSDT08m81Mo0K5Tz2ud/MFcPkt9Aaq9YrFsetZEe6/wi2Fx6s0yJCIxmc4Y29sKRns7xy2d4QrLH7oG/Krzgc4ZdsW4WQumKRBG8abcYX94OhHMAfjD7CsyXlDos/x3KHyvdO1E2nqFX1GEUwvbDLCLXv1pIOCsGki+7jnUNVRVH5VzBVyEXpvwT9OMEFnXjUsymXfUd2bQE5jlVeR17/JN1gko+jh2nNlJmORoY6QXnsRJU6iqnzES1s9NucOyPSq6cTUfXftDCqEhewmsSCCdApg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by KL1PR02MB7167.apcprd02.prod.outlook.com (2603:1096:820:116::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Thu, 12 Nov
 2026 03:16:53 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.012; Thu, 12 Nov 2026
 03:16:52 +0000
From: Bin Meng <bin.meng@processmission.com>
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [u-boot-test-hooks PATCH v3 2/2] bin: Rename QEMU arm* conf files
Date: Thu, 12 Nov 2026 11:16:33 +0800
Message-ID: <20261112031635.1739906-2-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112031635.1739906-1-bin.meng@processmission.com>
References: <20261112031635.1739906-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0365.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::12) To TYZPR02MB7121.apcprd02.prod.outlook.com
 (2603:1096:405:2c::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB7121:EE_|KL1PR02MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: 02fb071f-de95-477b-d180-08df406b65da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|18002099003|22082099003|6133799003|3023799007|10067099003|261026121527099003|261102123227099003|261009223027099003|261021121427099003|261021123027099003|261026140227099003|261022075727099003|261022105027099003|261022113327099003|261028144727099003|56012099006|261022115727099003;
X-Microsoft-Antispam-Message-Info: HhUZ4bJC0FV7lJBOslJkqnQYJmL/s8yrn/tZ3+1wHCzsDGuCcNVe7ujVDx2CuvOLYxS4rnIdbmnCZv2axMyIX3VK/FK7a6JxJGBWlNJXqqZZC8NjKsAc0qQeKLcSfgy2bAmpUYp2ibV4+KzUIveq8EJMpTrPRdGStSmNbKjlcQjU0PjmB6wncHe/ElAxTZhmK84FbgSByiovzqUhSD0sJf/eFh81dystq5MIXG/NjCItWSPl5bL+ld2ieYS31UZBQrxXCVguLWVz40SxZRTjp7phiEFf12yIvK+83oqG7eS7OyVAH1zmmQY2zY1BkrgFd7RwTGvaH+RawkMloV+hPyjuwnke+9Yfdrc2HoSlrD6N0xpkFbaXpzPobJxIwVgbgTWY9uWNUMKIVL6KEkSmRMv1MRd2xDRX7QArqjj4A8Y/bXbajwzw7yEeGxYGC0IpxeCmjEZbmVS0Veu+eKZkkzZMrKejVklJv9AibCM3YDungdaxQpvSejksMe68VLSN1gvV2cmriNkYMedAshWNSkI1nywFWrZ/Hmty2BYxu6FV3UJx62qvId2vey0NKDaOMSZBHpcLnahTIAsBrt7UaQ3NZSfYxDopSR7HOm3ZGnV6glbscNFZgM8bltzxvFRoeNCvmRvNkYcTIM8MQ8MJ/VwBZDeA4lZ/XDG4SSZToWs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(18002099003)(22082099003)(6133799003)(3023799007)(10067099003)(261026121527099003)(261102123227099003)(261009223027099003)(261021121427099003)(261021123027099003)(261026140227099003)(261022075727099003)(261022105027099003)(261022113327099003)(261028144727099003)(56012099006)(261022115727099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NzAzumcZROvjfCQ0NfDjB9GPabIuH/kf6nsGKmKyM1o7Tbeoy5sq2u+9kQs+?=
 =?us-ascii?Q?nxLq/CzzN7ifQkBrViaI/fBWkO8El1r8YtzjCsXEzBe1jpAwsC3gd2vyE7V2?=
 =?us-ascii?Q?QgYB+4+akH9wQTVyZlxX5sHjL9QWYCUY7OFe9HK9V7qmZDIIt9MogipCxBKg?=
 =?us-ascii?Q?3n4gI/a3sEM0Ti+7CjjHg4savIxeDkuG2KkKOmqCQWYi5yhOkfAtXOd5YjyE?=
 =?us-ascii?Q?CogSoWopV+6+CULARczQ/XW311PkjcdFfXTSYcpt0ozcgEDyMelS0224CRwt?=
 =?us-ascii?Q?aSDoUdxV2pU5AxRT2DZSP5O5glupWjhFWDEwSr9vVG8mVLOD3mcc56+EPea9?=
 =?us-ascii?Q?/UkC5+AneW7xN3PTD01OpyLeMOcpfcR0ypsid5Tuur7WztnW9q/IgEFHNWw4?=
 =?us-ascii?Q?auvsuKy1fyL0WFkxSPekCLBM1shr6z8wwXNgmYevma4wsCrhsEcNEZlzVoxl?=
 =?us-ascii?Q?12cwonQmd67tboQROGhk3cwohT6BoBB/3lvrWraZnuOc4bcMJEmfm4pUT1qx?=
 =?us-ascii?Q?HWoRX8gVLq+axeM/hcPO9OA9VdN/1tBcze0wAaodW0ciFsIfTGM64x7ZRCVu?=
 =?us-ascii?Q?3Rf91ujddAwaDGPE0Nw6LZY4/u6KBofAGQ6orr/fzfiY19B45PUye4biCmII?=
 =?us-ascii?Q?FNmV7xulto/p1ddL3rYGg7+uSdrdchdOLImDQxTV3aaE1GLjGl0C7nM/TN9s?=
 =?us-ascii?Q?SJoywfPbs362IhJ889OrEsnL67xfDRHkFaQiagZzWF8nSzOxTK/NWGslx3AN?=
 =?us-ascii?Q?/OuBdX9GmJ5l5nS12FYajdJPrMYvNhOGJ7LfdPQRMzfM7Zs9ErzfCtfD2cdm?=
 =?us-ascii?Q?osYQXQ14Q6Q/uxCwm7zd8QB4upImhf5q5U5qla+uZDJ3LRSg9Jz5Eb8tPZ7R?=
 =?us-ascii?Q?EQjSG3utHnTY7/EnM9kKxJB2zK2bNYCJj8o0qjEaACE7EOeDA/ye4Te5vE1w?=
 =?us-ascii?Q?nmXta++TVhp+zgSaE90O3xQ62L+3Hb9Xtdz1RE64JXgNFe07d6+eAMVfjN3Z?=
 =?us-ascii?Q?4d4yyjCQFj6/BPEaR5gFY2PAii6x494cm+mM4qePPZCzwT1vgjwK8ix7Cvph?=
 =?us-ascii?Q?UE5qjFbp+ZbCm0gmVN9mY0zTGqpWa0XIhnWPi6/JUYCFFMxtvpXl0OCqKJ/2?=
 =?us-ascii?Q?1tSJY7Bz09B3xmmsB2/G1+7k2YFS5sztAwEN5PMZFjR17TboCxl+uzQwfFnD?=
 =?us-ascii?Q?4gsJFIzal2EUjSeAtL5gSklcuDkHwto30o4OT8U6QKr4jmgD5iufQ84PoybJ?=
 =?us-ascii?Q?uxG4Y8rNOQo0dtmL9xPDl20atgIAunCDduXCBAwFEp6KAsXP/RRrG0jys46X?=
 =?us-ascii?Q?3DGNPhjEQ3fc0Aj0RFfUdiXweNIATcfL0HkZlw9rYT4Jnz70+Dn82tNIzpeK?=
 =?us-ascii?Q?NsF009W2u/wZp3HzqGH9RDDrgzkNFrIZiML7WCs/LTfukv0ww8vGtwUNHo4l?=
 =?us-ascii?Q?0TBWGBYFH17tlsIMffUz9GhtbcYNXdBPk/TToU+E9zARIrPkc5SSCSGR5H8Y?=
 =?us-ascii?Q?aNvT+z1S2R/xhEZY9aGBZhfZ37Xn9cqXqlbuTc8of7gYgHZN4xR10qlYfQVd?=
 =?us-ascii?Q?kS5MAof9i2LSKf070ZN1K89A17ptDoAjwwiXRjX+ambpEmvq4QiG6PcF6raZ?=
 =?us-ascii?Q?bxI4RquSGP3ixtcI/sBNbg9rCSyFRUJYwf+5x/+gvn5EEkLzzodZ9ecvnorx?=
 =?us-ascii?Q?AT4/0D4LLO1+AP0AmpEwc6yEFDz13tzYS/vKgykPcfLBRekfwQladqeDUo5/?=
 =?us-ascii?Q?OzwKJT8PZ+df//qF2JHnqssEmH6I4ko=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02fb071f-de95-477b-d180-08df406b65da
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 03:16:52.8533 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zAtM922yI6QMyHPJfHoE2JEUPh8Kyyf9ufgS7UCKcjfADTd/H5PAZuq829BN1OE79Y6LhOEhJAppPxVhN5zqlXgVRrXk7M1Bo7vMS1BjS1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB7167
X-Mailman-Approved-At: Thu, 12 Nov 2026 04:24:36 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Bin Meng <bmeng.cn@gmail.com>

Use a hyphen between "qemu" and the architecture name for the
"board_type" field in the conf file name, and indicate "arm64"
for the ARM SBSA virtual platform.

Keep symbolic links for the old configuration names in bin/travis-ci
and bin/ellesmere so that older U-Boot releases can still be tested.
This repository is not tagged or branched to match U-Boot releases.

Update the Labgrid U-Boot provider to use the renamed ARM defconfig.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

Changes in v3:
- Keep symbolic links for the old configuration names for compatibility

Changes in v2:
- Rebase on the latest mainline
- Update the Labgrid U-Boot provider to use qemu-arm

 bin/ellesmere/conf.qemu-arm64         |  1 +
 bin/ellesmere/conf.qemu-arm64_spl_na  |  1 +
 bin/ellesmere/conf.qemu-arm_na        |  1 +
 bin/ellesmere/conf.qemu-arm_spl_na    |  1 +
 bin/travis-ci/conf.qemu-arm-sbsa_na   | 28 +---------------
 bin/travis-ci/conf.qemu-arm64         | 45 ++++++++++++++++++++++++++
 bin/travis-ci/conf.qemu-arm64-sbsa_na | 27 ++++++++++++++++
 bin/travis-ci/conf.qemu-arm64_spl_na  | 32 +++++++++++++++++++
 bin/travis-ci/conf.qemu-arm64_tpl_na  | 29 +++++++++++++++++
 bin/travis-ci/conf.qemu-arm64be_na    | 13 ++++++++
 bin/travis-ci/conf.qemu-arm_na        | 30 +++++++++++++++++
 bin/travis-ci/conf.qemu-arm_spl_na    | 31 ++++++++++++++++++
 bin/travis-ci/conf.qemu_arm64         | 46 +--------------------------
 bin/travis-ci/conf.qemu_arm64_spl_na  | 33 +------------------
 bin/travis-ci/conf.qemu_arm64_tpl_na  | 30 +----------------
 bin/travis-ci/conf.qemu_arm64be_na    | 14 +-------
 bin/travis-ci/conf.qemu_arm_na        | 31 +-----------------
 bin/travis-ci/conf.qemu_arm_spl_na    | 32 +------------------
 labgrid-sjg/kea_env.cfg               |  2 +-
 19 files changed, 219 insertions(+), 208 deletions(-)
 create mode 120000 bin/ellesmere/conf.qemu-arm64
 create mode 120000 bin/ellesmere/conf.qemu-arm64_spl_na
 create mode 120000 bin/ellesmere/conf.qemu-arm_na
 create mode 120000 bin/ellesmere/conf.qemu-arm_spl_na
 mode change 100644 => 120000 bin/travis-ci/conf.qemu-arm-sbsa_na
 create mode 100644 bin/travis-ci/conf.qemu-arm64
 create mode 100644 bin/travis-ci/conf.qemu-arm64-sbsa_na
 create mode 100644 bin/travis-ci/conf.qemu-arm64_spl_na
 create mode 100644 bin/travis-ci/conf.qemu-arm64_tpl_na
 create mode 100644 bin/travis-ci/conf.qemu-arm64be_na
 create mode 100644 bin/travis-ci/conf.qemu-arm_na
 create mode 100644 bin/travis-ci/conf.qemu-arm_spl_na
 mode change 100644 => 120000 bin/travis-ci/conf.qemu_arm64
 mode change 100644 => 120000 bin/travis-ci/conf.qemu_arm64_spl_na
 mode change 100644 => 120000 bin/travis-ci/conf.qemu_arm64_tpl_na
 mode change 100644 => 120000 bin/travis-ci/conf.qemu_arm64be_na
 mode change 100644 => 120000 bin/travis-ci/conf.qemu_arm_na
 mode change 100644 => 120000 bin/travis-ci/conf.qemu_arm_spl_na

diff --git a/bin/ellesmere/conf.qemu-arm64 b/bin/ellesmere/conf.qemu-arm64
new file mode 120000
index 0000000..312f519
--- /dev/null
+++ b/bin/ellesmere/conf.qemu-arm64
@@ -0,0 +1 @@
+../travis-ci/conf.qemu-arm64
\ No newline at end of file
diff --git a/bin/ellesmere/conf.qemu-arm64_spl_na b/bin/ellesmere/conf.qemu-arm64_spl_na
new file mode 120000
index 0000000..112a3d5
--- /dev/null
+++ b/bin/ellesmere/conf.qemu-arm64_spl_na
@@ -0,0 +1 @@
+../travis-ci/conf.qemu-arm64_spl_na
\ No newline at end of file
diff --git a/bin/ellesmere/conf.qemu-arm_na b/bin/ellesmere/conf.qemu-arm_na
new file mode 120000
index 0000000..d103ff9
--- /dev/null
+++ b/bin/ellesmere/conf.qemu-arm_na
@@ -0,0 +1 @@
+../travis-ci/conf.qemu-arm_na
\ No newline at end of file
diff --git a/bin/ellesmere/conf.qemu-arm_spl_na b/bin/ellesmere/conf.qemu-arm_spl_na
new file mode 120000
index 0000000..aee911e
--- /dev/null
+++ b/bin/ellesmere/conf.qemu-arm_spl_na
@@ -0,0 +1 @@
+../travis-ci/conf.qemu-arm_spl_na
\ No newline at end of file
diff --git a/bin/travis-ci/conf.qemu-arm-sbsa_na b/bin/travis-ci/conf.qemu-arm-sbsa_na
deleted file mode 100644
index fea885f..0000000
--- a/bin/travis-ci/conf.qemu-arm-sbsa_na
+++ /dev/null
@@ -1,27 +0,0 @@
-# Copyright (c) 2024 Patrick Rudolph. All rights reserved.
-#
-# Permission is hereby granted, free of charge, to any person obtaining a
-# copy of this software and associated documentation files (the "Software"),
-# to deal in the Software without restriction, including without limitation
-# the rights to use, copy, modify, merge, publish, distribute, sublicense,
-# and/or sell copies of the Software, and to permit persons to whom the
-# Software is furnished to do so, subject to the following conditions:
-#
-# The above copyright notice and this permission notice shall be included in
-# all copies or substantial portions of the Software.
-#
-# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
-# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
-# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
-# DEALINGS IN THE SOFTWARE.
-
-console_impl=qemu
-qemu_machine="sbsa-ref"
-qemu_binary="qemu-system-aarch64"
-qemu_extra_args="-cpu cortex-a57 -smp 4 -nographic -netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device e1000,netdev=net0 -device virtio-rng-pci -semihosting"
-qemu_kernel_args="-drive if=pflash,file=${U_BOOT_BUILD_DIR}/secure-world.rom,format=raw -drive if=pflash,file=${U_BOOT_BUILD_DIR}/unsecure-world.rom,format=raw"
-reset_impl=none
-flash_impl=none
diff --git a/bin/travis-ci/conf.qemu-arm-sbsa_na b/bin/travis-ci/conf.qemu-arm-sbsa_na
new file mode 120000
index 0000000..ee88843
--- /dev/null
+++ b/bin/travis-ci/conf.qemu-arm-sbsa_na
@@ -0,0 +1 @@
+conf.qemu-arm64-sbsa_na
\ No newline at end of file
diff --git a/bin/travis-ci/conf.qemu-arm64 b/bin/travis-ci/conf.qemu-arm64
new file mode 100644
index 0000000..254e613
--- /dev/null
+++ b/bin/travis-ci/conf.qemu-arm64
@@ -0,0 +1,45 @@
+# Copyright (c) 2017 Tuomas Tynkkynen. All rights reserved.
+# Based on conf.vexpress_ca15_tc2_qemu which is:
+# Copyright (c) 2016 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+set -e
+
+if [ -n "${fip}" ] && [ -n "${bl1}" ]; then
+	echo "Both fip and bl1 exist - TF-A mode"
+	helper_setup="swtpm_setup --tpmstate /tmp/tpm --tpm2 --pcr-banks sha256"
+	qemu_machine="virt,secure=on"
+	qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/flash.bin"
+	flash_impl=fiptool
+else
+	qemu_machine="virt"
+	qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/u-boot.bin"
+	flash_impl=none
+fi
+
+console_impl=qemu
+qemu_helper_script="swtpm"
+qemu_binary="qemu-system-aarch64"
+qemu_net_args="-netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device e1000,netdev=net0"
+qemu_host_args="-semihosting-config enable=on,target=native"
+qemu_tpm_args="-chardev socket,id=chrtpm,path=/tmp/tpm/swtpm-sock -tpmdev emulator,id=tpm0,chardev=chrtpm -device tpm-tis-device,tpmdev=tpm0"
+qemu_9p_args="-fsdev local,id=fsdev0,path=${UBOOT_TRAVIS_BUILD_DIR},security_model=none -device virtio-9p-device,fsdev=fsdev0,mount_tag=rootfs"
+qemu_extra_args="-m 4G -cpu cortex-a57 -nographic -device virtio-rng-pci -d unimp ${qemu_host_args} ${qemu_net_args} ${qemu_tpm_args} ${qemu_9p_args}"
+reset_impl=none
diff --git a/bin/travis-ci/conf.qemu-arm64-sbsa_na b/bin/travis-ci/conf.qemu-arm64-sbsa_na
new file mode 100644
index 0000000..fea885f
--- /dev/null
+++ b/bin/travis-ci/conf.qemu-arm64-sbsa_na
@@ -0,0 +1,27 @@
+# Copyright (c) 2024 Patrick Rudolph. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_impl=qemu
+qemu_machine="sbsa-ref"
+qemu_binary="qemu-system-aarch64"
+qemu_extra_args="-cpu cortex-a57 -smp 4 -nographic -netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device e1000,netdev=net0 -device virtio-rng-pci -semihosting"
+qemu_kernel_args="-drive if=pflash,file=${U_BOOT_BUILD_DIR}/secure-world.rom,format=raw -drive if=pflash,file=${U_BOOT_BUILD_DIR}/unsecure-world.rom,format=raw"
+reset_impl=none
+flash_impl=none
diff --git a/bin/travis-ci/conf.qemu-arm64_spl_na b/bin/travis-ci/conf.qemu-arm64_spl_na
new file mode 100644
index 0000000..9a0d9b3
--- /dev/null
+++ b/bin/travis-ci/conf.qemu-arm64_spl_na
@@ -0,0 +1,32 @@
+# Copyright (c) 2017 Tuomas Tynkkynen. All rights reserved.
+# Based on conf.vexpress_ca15_tc2_qemu which is:
+# Copyright (c) 2016 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_impl=qemu
+qemu_machine="virt"
+qemu_helper_script="swtpm"
+qemu_binary="qemu-system-aarch64"
+qemu_extra_args="-cpu cortex-a57 -nographic -netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device e1000,netdev=net0 -device virtio-rng-pci -semihosting -chardev socket,id=chrtpm,path=/tmp/tpm/swtpm-sock -tpmdev emulator,id=tpm0,chardev=chrtpm -device tpm-tis-device,tpmdev=tpm0"
+
+# Uses image.bin which contains SPL and U-Boot
+qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/image.bin"
+reset_impl=none
+flash_impl=none
diff --git a/bin/travis-ci/conf.qemu-arm64_tpl_na b/bin/travis-ci/conf.qemu-arm64_tpl_na
new file mode 100644
index 0000000..556e15b
--- /dev/null
+++ b/bin/travis-ci/conf.qemu-arm64_tpl_na
@@ -0,0 +1,29 @@
+# Copyright (c) 2017 Tuomas Tynkkynen. All rights reserved.
+# Based on conf.vexpress_ca15_tc2_qemu which is:
+# Copyright (c) 2016 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_impl=qemu
+qemu_machine="virt"
+qemu_binary="qemu-system-aarch64"
+qemu_extra_args="-cpu cortex-a57 -nographic"
+qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/image.bin"
+reset_impl=none
+flash_impl=none
diff --git a/bin/travis-ci/conf.qemu-arm64be_na b/bin/travis-ci/conf.qemu-arm64be_na
new file mode 100644
index 0000000..3929636
--- /dev/null
+++ b/bin/travis-ci/conf.qemu-arm64be_na
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: MIT
+#
+# Copyright (c) 2024 Jiaxun Yang
+#
+
+console_impl=qemu
+qemu_machine="virt"
+qemu_helper_script="swtpm"
+qemu_binary="qemu-system-aarch64"
+qemu_extra_args="-cpu cortex-a57 -nographic -netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device e1000,netdev=net0 -device virtio-rng-pci -semihosting -chardev socket,id=chrtpm,path=/tmp/tpm/swtpm-sock -tpmdev emulator,id=tpm0,chardev=chrtpm -device tpm-tis-device,tpmdev=tpm0"
+qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/u-boot.bin"
+reset_impl=none
+flash_impl=none
diff --git a/bin/travis-ci/conf.qemu-arm_na b/bin/travis-ci/conf.qemu-arm_na
new file mode 100644
index 0000000..de0694d
--- /dev/null
+++ b/bin/travis-ci/conf.qemu-arm_na
@@ -0,0 +1,30 @@
+# Copyright (c) 2017 Tuomas Tynkkynen. All rights reserved.
+# Based on conf.vexpress_ca15_tc2_qemu which is:
+# Copyright (c) 2016 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_impl=qemu
+qemu_machine="virt"
+qemu_helper_script="swtpm"
+qemu_binary="qemu-system-arm"
+qemu_extra_args="-nographic -netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device e1000,netdev=net0 -device virtio-rng-pci -chardev socket,id=chrtpm,path=/tmp/tpm/swtpm-sock -tpmdev emulator,id=tpm0,chardev=chrtpm -device tpm-tis-device,tpmdev=tpm0"
+qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/u-boot.bin"
+reset_impl=none
+flash_impl=none
diff --git a/bin/travis-ci/conf.qemu-arm_spl_na b/bin/travis-ci/conf.qemu-arm_spl_na
new file mode 100644
index 0000000..1646ea3
--- /dev/null
+++ b/bin/travis-ci/conf.qemu-arm_spl_na
@@ -0,0 +1,31 @@
+# Copyright (c) 2017 Tuomas Tynkkynen. All rights reserved.
+# Based on conf.vexpress_ca15_tc2_qemu which is:
+# Copyright (c) 2016 Konsulko Group. All rights reserved.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+# DEALINGS IN THE SOFTWARE.
+
+console_impl=qemu
+qemu_machine="virt"
+qemu_binary="qemu-system-arm"
+qemu_extra_args="-nographic -netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device e1000,netdev=net0 -device virtio-rng-pci"
+
+# Uses image.bin which contains SPL and U-Boot
+qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/image.bin"
+reset_impl=none
+flash_impl=none
diff --git a/bin/travis-ci/conf.qemu_arm64 b/bin/travis-ci/conf.qemu_arm64
deleted file mode 100644
index 254e613..0000000
--- a/bin/travis-ci/conf.qemu_arm64
+++ /dev/null
@@ -1,45 +0,0 @@
-# Copyright (c) 2017 Tuomas Tynkkynen. All rights reserved.
-# Based on conf.vexpress_ca15_tc2_qemu which is:
-# Copyright (c) 2016 Konsulko Group. All rights reserved.
-#
-# Permission is hereby granted, free of charge, to any person obtaining a
-# copy of this software and associated documentation files (the "Software"),
-# to deal in the Software without restriction, including without limitation
-# the rights to use, copy, modify, merge, publish, distribute, sublicense,
-# and/or sell copies of the Software, and to permit persons to whom the
-# Software is furnished to do so, subject to the following conditions:
-#
-# The above copyright notice and this permission notice shall be included in
-# all copies or substantial portions of the Software.
-#
-# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
-# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
-# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
-# DEALINGS IN THE SOFTWARE.
-
-set -e
-
-if [ -n "${fip}" ] && [ -n "${bl1}" ]; then
-	echo "Both fip and bl1 exist - TF-A mode"
-	helper_setup="swtpm_setup --tpmstate /tmp/tpm --tpm2 --pcr-banks sha256"
-	qemu_machine="virt,secure=on"
-	qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/flash.bin"
-	flash_impl=fiptool
-else
-	qemu_machine="virt"
-	qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/u-boot.bin"
-	flash_impl=none
-fi
-
-console_impl=qemu
-qemu_helper_script="swtpm"
-qemu_binary="qemu-system-aarch64"
-qemu_net_args="-netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device e1000,netdev=net0"
-qemu_host_args="-semihosting-config enable=on,target=native"
-qemu_tpm_args="-chardev socket,id=chrtpm,path=/tmp/tpm/swtpm-sock -tpmdev emulator,id=tpm0,chardev=chrtpm -device tpm-tis-device,tpmdev=tpm0"
-qemu_9p_args="-fsdev local,id=fsdev0,path=${UBOOT_TRAVIS_BUILD_DIR},security_model=none -device virtio-9p-device,fsdev=fsdev0,mount_tag=rootfs"
-qemu_extra_args="-m 4G -cpu cortex-a57 -nographic -device virtio-rng-pci -d unimp ${qemu_host_args} ${qemu_net_args} ${qemu_tpm_args} ${qemu_9p_args}"
-reset_impl=none
diff --git a/bin/travis-ci/conf.qemu_arm64 b/bin/travis-ci/conf.qemu_arm64
new file mode 120000
index 0000000..fe3c34a
--- /dev/null
+++ b/bin/travis-ci/conf.qemu_arm64
@@ -0,0 +1 @@
+conf.qemu-arm64
\ No newline at end of file
diff --git a/bin/travis-ci/conf.qemu_arm64_spl_na b/bin/travis-ci/conf.qemu_arm64_spl_na
deleted file mode 100644
index 9a0d9b3..0000000
--- a/bin/travis-ci/conf.qemu_arm64_spl_na
+++ /dev/null
@@ -1,32 +0,0 @@
-# Copyright (c) 2017 Tuomas Tynkkynen. All rights reserved.
-# Based on conf.vexpress_ca15_tc2_qemu which is:
-# Copyright (c) 2016 Konsulko Group. All rights reserved.
-#
-# Permission is hereby granted, free of charge, to any person obtaining a
-# copy of this software and associated documentation files (the "Software"),
-# to deal in the Software without restriction, including without limitation
-# the rights to use, copy, modify, merge, publish, distribute, sublicense,
-# and/or sell copies of the Software, and to permit persons to whom the
-# Software is furnished to do so, subject to the following conditions:
-#
-# The above copyright notice and this permission notice shall be included in
-# all copies or substantial portions of the Software.
-#
-# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
-# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
-# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
-# DEALINGS IN THE SOFTWARE.
-
-console_impl=qemu
-qemu_machine="virt"
-qemu_helper_script="swtpm"
-qemu_binary="qemu-system-aarch64"
-qemu_extra_args="-cpu cortex-a57 -nographic -netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device e1000,netdev=net0 -device virtio-rng-pci -semihosting -chardev socket,id=chrtpm,path=/tmp/tpm/swtpm-sock -tpmdev emulator,id=tpm0,chardev=chrtpm -device tpm-tis-device,tpmdev=tpm0"
-
-# Uses image.bin which contains SPL and U-Boot
-qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/image.bin"
-reset_impl=none
-flash_impl=none
diff --git a/bin/travis-ci/conf.qemu_arm64_spl_na b/bin/travis-ci/conf.qemu_arm64_spl_na
new file mode 120000
index 0000000..18ae082
--- /dev/null
+++ b/bin/travis-ci/conf.qemu_arm64_spl_na
@@ -0,0 +1 @@
+conf.qemu-arm64_spl_na
\ No newline at end of file
diff --git a/bin/travis-ci/conf.qemu_arm64_tpl_na b/bin/travis-ci/conf.qemu_arm64_tpl_na
deleted file mode 100644
index 556e15b..0000000
--- a/bin/travis-ci/conf.qemu_arm64_tpl_na
+++ /dev/null
@@ -1,29 +0,0 @@
-# Copyright (c) 2017 Tuomas Tynkkynen. All rights reserved.
-# Based on conf.vexpress_ca15_tc2_qemu which is:
-# Copyright (c) 2016 Konsulko Group. All rights reserved.
-#
-# Permission is hereby granted, free of charge, to any person obtaining a
-# copy of this software and associated documentation files (the "Software"),
-# to deal in the Software without restriction, including without limitation
-# the rights to use, copy, modify, merge, publish, distribute, sublicense,
-# and/or sell copies of the Software, and to permit persons to whom the
-# Software is furnished to do so, subject to the following conditions:
-#
-# The above copyright notice and this permission notice shall be included in
-# all copies or substantial portions of the Software.
-#
-# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
-# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
-# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
-# DEALINGS IN THE SOFTWARE.
-
-console_impl=qemu
-qemu_machine="virt"
-qemu_binary="qemu-system-aarch64"
-qemu_extra_args="-cpu cortex-a57 -nographic"
-qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/image.bin"
-reset_impl=none
-flash_impl=none
diff --git a/bin/travis-ci/conf.qemu_arm64_tpl_na b/bin/travis-ci/conf.qemu_arm64_tpl_na
new file mode 120000
index 0000000..27c12d4
--- /dev/null
+++ b/bin/travis-ci/conf.qemu_arm64_tpl_na
@@ -0,0 +1 @@
+conf.qemu-arm64_tpl_na
\ No newline at end of file
diff --git a/bin/travis-ci/conf.qemu_arm64be_na b/bin/travis-ci/conf.qemu_arm64be_na
deleted file mode 100644
index 3929636..0000000
--- a/bin/travis-ci/conf.qemu_arm64be_na
+++ /dev/null
@@ -1,13 +0,0 @@
-# SPDX-License-Identifier: MIT
-#
-# Copyright (c) 2024 Jiaxun Yang
-#
-
-console_impl=qemu
-qemu_machine="virt"
-qemu_helper_script="swtpm"
-qemu_binary="qemu-system-aarch64"
-qemu_extra_args="-cpu cortex-a57 -nographic -netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device e1000,netdev=net0 -device virtio-rng-pci -semihosting -chardev socket,id=chrtpm,path=/tmp/tpm/swtpm-sock -tpmdev emulator,id=tpm0,chardev=chrtpm -device tpm-tis-device,tpmdev=tpm0"
-qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/u-boot.bin"
-reset_impl=none
-flash_impl=none
diff --git a/bin/travis-ci/conf.qemu_arm64be_na b/bin/travis-ci/conf.qemu_arm64be_na
new file mode 120000
index 0000000..1920017
--- /dev/null
+++ b/bin/travis-ci/conf.qemu_arm64be_na
@@ -0,0 +1 @@
+conf.qemu-arm64be_na
\ No newline at end of file
diff --git a/bin/travis-ci/conf.qemu_arm_na b/bin/travis-ci/conf.qemu_arm_na
deleted file mode 100644
index de0694d..0000000
--- a/bin/travis-ci/conf.qemu_arm_na
+++ /dev/null
@@ -1,30 +0,0 @@
-# Copyright (c) 2017 Tuomas Tynkkynen. All rights reserved.
-# Based on conf.vexpress_ca15_tc2_qemu which is:
-# Copyright (c) 2016 Konsulko Group. All rights reserved.
-#
-# Permission is hereby granted, free of charge, to any person obtaining a
-# copy of this software and associated documentation files (the "Software"),
-# to deal in the Software without restriction, including without limitation
-# the rights to use, copy, modify, merge, publish, distribute, sublicense,
-# and/or sell copies of the Software, and to permit persons to whom the
-# Software is furnished to do so, subject to the following conditions:
-#
-# The above copyright notice and this permission notice shall be included in
-# all copies or substantial portions of the Software.
-#
-# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
-# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
-# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
-# DEALINGS IN THE SOFTWARE.
-
-console_impl=qemu
-qemu_machine="virt"
-qemu_helper_script="swtpm"
-qemu_binary="qemu-system-arm"
-qemu_extra_args="-nographic -netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device e1000,netdev=net0 -device virtio-rng-pci -chardev socket,id=chrtpm,path=/tmp/tpm/swtpm-sock -tpmdev emulator,id=tpm0,chardev=chrtpm -device tpm-tis-device,tpmdev=tpm0"
-qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/u-boot.bin"
-reset_impl=none
-flash_impl=none
diff --git a/bin/travis-ci/conf.qemu_arm_na b/bin/travis-ci/conf.qemu_arm_na
new file mode 120000
index 0000000..7672322
--- /dev/null
+++ b/bin/travis-ci/conf.qemu_arm_na
@@ -0,0 +1 @@
+conf.qemu-arm_na
\ No newline at end of file
diff --git a/bin/travis-ci/conf.qemu_arm_spl_na b/bin/travis-ci/conf.qemu_arm_spl_na
deleted file mode 100644
index 1646ea3..0000000
--- a/bin/travis-ci/conf.qemu_arm_spl_na
+++ /dev/null
@@ -1,31 +0,0 @@
-# Copyright (c) 2017 Tuomas Tynkkynen. All rights reserved.
-# Based on conf.vexpress_ca15_tc2_qemu which is:
-# Copyright (c) 2016 Konsulko Group. All rights reserved.
-#
-# Permission is hereby granted, free of charge, to any person obtaining a
-# copy of this software and associated documentation files (the "Software"),
-# to deal in the Software without restriction, including without limitation
-# the rights to use, copy, modify, merge, publish, distribute, sublicense,
-# and/or sell copies of the Software, and to permit persons to whom the
-# Software is furnished to do so, subject to the following conditions:
-#
-# The above copyright notice and this permission notice shall be included in
-# all copies or substantial portions of the Software.
-#
-# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
-# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
-# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
-# DEALINGS IN THE SOFTWARE.
-
-console_impl=qemu
-qemu_machine="virt"
-qemu_binary="qemu-system-arm"
-qemu_extra_args="-nographic -netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device e1000,netdev=net0 -device virtio-rng-pci"
-
-# Uses image.bin which contains SPL and U-Boot
-qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/image.bin"
-reset_impl=none
-flash_impl=none
diff --git a/bin/travis-ci/conf.qemu_arm_spl_na b/bin/travis-ci/conf.qemu_arm_spl_na
new file mode 120000
index 0000000..5858acd
--- /dev/null
+++ b/bin/travis-ci/conf.qemu_arm_spl_na
@@ -0,0 +1 @@
+conf.qemu-arm_spl_na
\ No newline at end of file
diff --git a/labgrid-sjg/kea_env.cfg b/labgrid-sjg/kea_env.cfg
index a12bbd5..0072732 100644
--- a/labgrid-sjg/kea_env.cfg
+++ b/labgrid-sjg/kea_env.cfg
@@ -1161,7 +1161,7 @@ targets:
         login_prompt: ' login: '
         username: 'root'
       UBootProviderDriver:
-        board: qemu_arm
+        board: qemu-arm
       UBootWriterDriver:
         method: qemu
       UBootStrategy: {}
---
base-commit: 59437fd1c7a6a84da05efe5cefde47264f78dcbe
branch: qemu-arm

-- 
2.53.0

