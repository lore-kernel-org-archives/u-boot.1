Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF06C87FCA
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 01:26:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5847F83DA6;
	Mon,  4 Aug 2025 03:25:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="DYm11Rhf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40F2483DCA; Mon,  4 Aug 2025 03:25:24 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6E8F83DA8
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 03:25:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vD1w134F9ChNr+DGQzMewsGEVW8bRFizk1wPl1jRf9by9686UDUinf4grMbeDfOH+Be9/41Y9qQoQEgOQC2OlREc5BLi0DzWyI+AcIkjr/uKoKTH134kNiic6Qk+bj1yBlexTn8uY46WMh9xfX+jm6nqvm/MVRt9MFR0xWN6hFs8CKmzMdWKARPueat8Alk/GfNK9IRiPvuFVExil9lHZ2IvC7/VDITzvJ9PGbLwfJQmUG/JHHCX/mhzFcNCXQKAgiTWzZotaKh1WK1lbu+CGyQOOzPYH7AN3eNt1EkYl2Iamm/LnV/lw1ntJaefOSmJ2tXJ7xIKJ7SFdzBiCTWpyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4LWqMqSZmdjLDcju95o0gR5XFSRWXCHIYMRpNrBkHXY=;
 b=pdftL0zALd3xY8eyRJnLm2PDYt0JGIbvjpqv9rkAOL3g53mw4bqmrCEBBOuW+d9kY+0VJSKEzXPRJK2xzLQWDsmm2e7A0eypZG6xtZiyw5cMxYlbHn+ghSVmuhvN1aIlUCctqhisQix+d1Su1gNpAZt8YoYHCsiBcjliC+lpX8fm1eBYhWvfkLYR15xUq61iDROS0zGaAqYQhvZIOM33D/l366Q1cz0RLDPPWTLR2V7SD2NR6vUrFdWHfalKqiCGBbPswc0twgNokglevWoo84/XyO5nWBizeJBpYrkZRd4loNCtcImz6iHQc/sMv+liDYLTnvTCpIkY7sLTc3iveg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4LWqMqSZmdjLDcju95o0gR5XFSRWXCHIYMRpNrBkHXY=;
 b=DYm11RhfGupqgiDnQ6E7aQ0VMZhLf17bY9MkpRqMKSDoQ3n3UWSzlycnluTY9SuTOZxEJSE/f2SS3yqtVoLJ0LWpiGnt8nji6cqWFZlBNcHzZwdww4ZbsoC87Lhap7z+9yVh8uE3iVLU4rWTGfYB7TMpslbmxN5eeBJxf5b+XK5xn0rm2HhmTc7Q2Kh8QtL9O5CTS4Kcm/nYF1tOb0jQSey7NDMEXLQThnr566zcbzQLnAYXfPvH9msx3HFGbIsKXsP9+m5AEJ3CBYdjYXjHI0WStPaMcJSRYRZsnouUqK5vzUwC7kZE1n4aTopbThl8GkBgYm/+gly9KJXQd7RkpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SA6PR03MB7973.namprd03.prod.outlook.com (2603:10b6:806:42c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 01:25:18 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%3]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 01:25:18 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Naresh Kumar Ravulapalli <naresh.kumar.ravulapalli@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 06/34] arm: socfpga: Enable ASYNC interrupts in Agilex SPL
Date: Sun,  3 Aug 2025 18:24:33 -0700
Message-Id: <20250804012501.21811-7-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
References: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0035.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::48) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SA6PR03MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: c8c981cb-3436-41e1-ed07-08ddd2f5c5a6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wxjkhGRV8BmEC6E/CgTa1K9DEu242gnnbmjlyPbOpWukBhN4dZaG23JMYZe+?=
 =?us-ascii?Q?BlGqI343DkMONJStUyFbR1TjeMSAAp0dClaf7jB9DLyCeuvfc8L12pWzxZg0?=
 =?us-ascii?Q?WeQtpN9E7r+9IEutoguumet1vhzdneLowRELj+sZbvJZP4M7kqbvB5KUQxZd?=
 =?us-ascii?Q?lGGZiJstjSVj7YhQDYPUy4tuBkGmm/2cXii+9jvNEsJay8KhCjNDTJ6mdyLo?=
 =?us-ascii?Q?UP1tpnpboDPhTM9gdl8v6kBlR5AFBzxBT2QDrZZvTWIZXVTx7emncgcX9a3B?=
 =?us-ascii?Q?u5P4s8/yBSaHX/bwCRe6JW8CTa/MEVIc18cOrSyUOeG8QMG5b07W7DNvU1Kl?=
 =?us-ascii?Q?2auB88UoP7KuP5dszVW2WXTDJ9l5fo1sy3ZWm2sIZtv5FG0qyy40J82BnEsJ?=
 =?us-ascii?Q?hhTNkTdkG7hQ3jwVIxeXAwwSGfWBDkamw42/nODhv2DHvGE3s5+Y+N+GwnGy?=
 =?us-ascii?Q?taQ0NUilb29RMIkHaVrmjhJLeUW76q3xneVtLrg/G8BPrE7uMZD83BAkCTJo?=
 =?us-ascii?Q?aS6Dzn33aHPoQZRR5ITNTS4DU/s/X/A2APvEkNt1pA9klNEnnPrGCh2QTRDg?=
 =?us-ascii?Q?Bq6qFjMSXJjpyz2u5J7y4XNJ5dLKpDgWCEES0U8WVBNTuHCUoD+sQDaV5Q07?=
 =?us-ascii?Q?dHXiYtk1BCv8vukLazN/t5pC2lToW/iWO3YEGO49PhbRxdZ2XsvoWMgTPiqP?=
 =?us-ascii?Q?9mr/IL7YUIiBHrT38+0+IjZ047YRuETjQb4Tur3u7EtsuSxuGNh3N3/IYcBq?=
 =?us-ascii?Q?rqMmdlcf9kRY0kHfAaOUT2vw4v4yOPim1OHd/vyohHJx167H+I9VjWm1xHQy?=
 =?us-ascii?Q?spqBcBzw6H5HH2R+xu/+cOU4iAurO/uzOPavEYnSwJ7+/YHDpfUJCKCDy7EO?=
 =?us-ascii?Q?/tA2Tr/W4dxFhMfSRAEdEB/PGmQ9iAvBEbwKv6/Mkbj+Tu5U2PezT9r0O7Ll?=
 =?us-ascii?Q?NDeGLdAKbfRnmM3Fzha8kEmiUvnGVaLh5ieTuLeVh4rAhZPVdAb73Kk+lyOC?=
 =?us-ascii?Q?NhtPZUCaxZnOfU5rQLZM6PMjgXWMbWw9mHPh4pZh3V6k21aOZ/oVsiRNAbQM?=
 =?us-ascii?Q?dY2YbwqpxiSx44H6X+WOv0bgxFPD5LAfyJ+NfGP5goFrLdL+A5P3JyLU8b15?=
 =?us-ascii?Q?4jshuDl2aL/cb9nQ38aFJRYdVwXLcILYr884ChFZ/hi+TNNHwn1RLjPXSqdB?=
 =?us-ascii?Q?cwM9oK8KQgqJh1cF/GGN3tbq3x2fSF/h+I1/ul7jZqIIDxDjdSVZPHYPLhyn?=
 =?us-ascii?Q?RjS+vt6oR5VnfxcHLaFlQZxJ2pP5EZT3GIGV+S8s5TZ6fR8b/XTSXmnMH6yo?=
 =?us-ascii?Q?4hrxUQWYg7T+Z9xgYc2sdZZUZizSI8O8a2P/pGWVNX7AJzF2dXHqmgfFoV7Y?=
 =?us-ascii?Q?V1XTTOb6KEBE0vCbFCCVz+YkK+WEOAsNb+Kli3NULdpzwi9rojjt7/eUckjd?=
 =?us-ascii?Q?fRtVrkJtTmc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0OyMqfraKAG20AvH0gvla94EN2oO4xCSoybp5P5LIgw/fpwggW8hLVGWvs2n?=
 =?us-ascii?Q?6WeBLcSP2uPLFHpBPfVESnPsuoKpfncpiDFmIFb5r5QGimb1+iA88bURLqe6?=
 =?us-ascii?Q?GZrUS68QT7zcMn6lt9ffwaj5cATmwTGRL0Pn/6iCqY0KAy+BNMHTdB+QCd8D?=
 =?us-ascii?Q?jGvT/n50UgsBvyuE3WlJ2v8OH0FkqFl3Ympn601tiCZ/Rf57baEknHboof1B?=
 =?us-ascii?Q?J0yc5AsZBS5zbs7tIyLJo4mjL6VyfTOmc63rcm+Rk4YGq4MnYlzF/Q3Bx9A8?=
 =?us-ascii?Q?RQJndMmn95FoFz65sScTFrjUcRJfWFDxOkohpv0roH99z9zW5CG1J+fAJCBw?=
 =?us-ascii?Q?W3F8n14dlmMpuwLWwF6uT5SrZXLSe7mPiF6Ulf9x8AhGuyErpS+3Gq3ykRCh?=
 =?us-ascii?Q?hgu0DGNI+jmmDFT24H0vcVnNYr3n2xsB/oIat/7QMjdDyrO5MKCynz8IH7Kg?=
 =?us-ascii?Q?0fUdKPy849Wklv65Df8E78YiEoD74cKWM8+0Z7ee3PgW4eI4QB0fw6218g+X?=
 =?us-ascii?Q?aP7Vbs8N8MlmPGjbEJm5w3Cgsce9IRHjdiM3fL6vX51GcRm5YhwV5GSTkZ2B?=
 =?us-ascii?Q?oBgeq0L5iTg8z3IJtjEM9Ix3sExxwO9ugUkVxztWUWa0rda7dznX2eRZZqoh?=
 =?us-ascii?Q?2fgzA8jRxcKm6Z2fJ2p3tZ+5ci+0vOJ1SEo+bBaLzvhYRD5JEr1kbzW28yEs?=
 =?us-ascii?Q?NS3gEcqGkqTCifH1rbGTqBtXhX9Ss0gsbEeiUCa6ghpjC6wDJhjjQYKwr+Hg?=
 =?us-ascii?Q?q9UdMjLSc1tzcjSqu/B7fnFOjskaxdsgsJMyt9/q0EjfIktUsSQn/W5dQyck?=
 =?us-ascii?Q?UfXQtyrDWtx1yJHCWmon9p2/90p9IE5Rc+kAdz5z9roTM/ejzF+qAYtALc4V?=
 =?us-ascii?Q?gffVpKb0pbhWqE37sFqNprzpniNCUBwQzQpAYFo9ts9Ty3SeUILAkLwPR7uv?=
 =?us-ascii?Q?qRNu1fEsVgawCgUZKVKMn8KG7EG8XF70e6TfgCo+Eo6YtcR/W4XR9bUPNfED?=
 =?us-ascii?Q?8f/a6zXBA+Xmkb0m4EadhslmUJqR9YSzj6uqUeMMQqe673RkFWePdxDB5mY5?=
 =?us-ascii?Q?G80ONvKas1WWxoQjH7MbF0fsLVIkq4UklJ8QJd37oU1NpCqaPH6pivT0K5yS?=
 =?us-ascii?Q?9WFR2H4HLADPDOy71zW0oAvtu00NYgtPyjNjQqPtgS9bgQNRC4tg853SN5OO?=
 =?us-ascii?Q?94+Pr+eJmO9VwzZuxI6qGloIe6bO3iidDk7U/ob6r+VsqRlMwukPf2blPORE?=
 =?us-ascii?Q?V9cceype2wfYvfKLHu9hAemKxvv0zqMSCTtMPOAnfJKJ78fxEVUOj7KI/3r+?=
 =?us-ascii?Q?qIzxwI+pcyhormxTmU8qkCV7hHcBUaMXXLyrKOADSwZxZsF5bRKtpLXeHpb/?=
 =?us-ascii?Q?tETBoOA5hZyOINWILKVf9PF633gX6P24bgV2M/IC/SiPeFVqOCxi/Y9hEiMB?=
 =?us-ascii?Q?HFe/qbfdFuaGtgq64QO8HDAA6To2OSHlgQK1iIs9N79DP5buYPOtzShBCUCI?=
 =?us-ascii?Q?l4/gvVPjOwNTthv4zgpXaoeN+dVeSaraCM8wNLV/sYXtuLHtInGy8KeIqKgF?=
 =?us-ascii?Q?OqeP214RLRm6QNhWCBi//muwCg150aA+D7znYtCV2vxzqo/WPWDLlMpKwTHN?=
 =?us-ascii?Q?1g=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c981cb-3436-41e1-ed07-08ddd2f5c5a6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 01:25:18.3257 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R3UQ3V7UZff2R11orHfZkXphVmSNhhucvaeArgIJTdBBlepKxo7iWKCW1ycNhgKgLdrLygvAjgyrbXd7kX17t4Cx7OmHHzqNmmn38cYIWgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7973
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Asynchronous aborts were previously masked at SPL
entry.

To ensure early detection of system errors
such as ECC faults or bus errors, asynchronous aborts
should be explicitly unmasked by clearing the A-bit in
the DAIF register during Agilex SPL initialization.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/mach-socfpga/spl_agilex.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-socfpga/spl_agilex.c b/arch/arm/mach-socfpga/spl_agilex.c
index 322a7ae6fc8..c2956264bc0 100644
--- a/arch/arm/mach-socfpga/spl_agilex.c
+++ b/arch/arm/mach-socfpga/spl_agilex.c
@@ -43,6 +43,9 @@ void board_init_f(ulong dummy)
 	int ret;
 	struct udevice *dev;
 
+	/* Enable Async */
+	asm volatile("msr daifclr, #4");
+
 	if (IS_ENABLED(CONFIG_XPL_BUILD))
 		spl_save_restore_data();
 
-- 
2.35.3

