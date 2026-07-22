Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DF1C4452B
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 01:53:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 653CB80D8F;
	Wed, 22 Jul 2026 01:53:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J2LflRgdrCE1; Wed, 22 Jul 2026 01:53:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AC13980D89
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784685184;
	bh=YHw8NY2yBGwDAw8JdOQD2mC6zRNjfg+ntDYkEDZJiyc=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=eBJvAreb+tT4uIe53XgUlg4HZuShKNwHPjd7OoBKEm1QETtDaxlBRH71XPkMqoNfT
	 qnzbGSXETrIpvLgWOaoShnTy+AhuomUSo39uKPxH6WOi0I8TwL9jJT2CCpe2/abVPD
	 MGefusdUnUBMOgpae/ohocCZKIvCAWLmTUPfPxFTVzuHaoa1yWIFUbfNMdyoQ8ZyF0
	 OHa1nl/AOHUmHGM07uuegWAPYew4PRbkW1N98pywXfTkTE7rQSf2xgFbD/HQXtWPKz
	 ot7O70fZcmf+qCR3c1lBMpjApYY6FsxP4DERQvON+kwyX2x3dHm9MIy/Knx7X4TwJ7
	 9286tsO8ZDxTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC13980D89;
	Wed, 22 Jul 2026 01:53:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9269B313
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 01:53:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 844AE40738
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 01:53:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zpdj2l4s3lNH for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 01:53:02 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=alif.zakuan.yuslaimi@altera.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3079B40632
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3079B40632
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3079B40632
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 01:53:01 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2BC2848BA; Wed, 22 Jul 2026 03:52:59 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DACAC84659
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 03:52:56 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q57trOcf5ElGzdrEyw6SawKA4N+QxgSWPqc9MAvuO/+CZHeL8f+wJy7/OOBNGUVAVCA3I6Ul11xJJH6po9gMDrwgIcVRhaT2AsibFgz9VrKt6qfEkIbthVTamj6wValiTbMoxb/QZlZNLWIJlp9WgJaXd5H/BpaTtpoc/PtyZApsOA5Ng+2VqemVTFch/YKVRSTdCzELvrh0NriqcuaH/yYgJRwlYLNOyXNxdnU9tWnDhPB7MzKxUyXaLAL7LiQAfMdveKyesjZqcp1mDpRB8shBE6i5jeJ6r+oUzBycSGHSwqE3Yxiz8Or0ocA6O4Jf0ico8hZjCLWGI7LIn+Kweg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHw8NY2yBGwDAw8JdOQD2mC6zRNjfg+ntDYkEDZJiyc=;
 b=Y1WSmH+LgH7F6JGAe5rA2CZ0HCIbw6Rn73QFDCB60XMzaidNDG/55+LuWsFJI8NEovrLKp25kA6XlZW8+/LyvDlNGAOZwnwKT1XCnt3wG+1CMeE2wwV5e4qdov9J5mSCHYLYTwa9tEc2qRO70jk3LqU+/PCGqQyvQCTOfB5zYc6DDdn/rEI0ETDXlV07CrSLxMTgjU6umdFuBtjrUS2VpsjxrfJUbYjlz4tZtRU0pVzOY6UeiwevoUIwvcDKtVx26ZvG9aaGuqDYVzJ1iZ3LKSrbVM/KcAOOq4pYmNi7QpwqCit3BWgPuv9TK9jrXZtpCtck7M3was6P7PDf8/Cffg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by MN2PR03MB5294.namprd03.prod.outlook.com (2603:10b6:208:1e2::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 01:52:52 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0223.017; Wed, 22 Jul 2026
 01:52:52 +0000
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Yao Zi <me@ziyao.cc>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH] arm: socfpga: Update Agilex7M SPL data save and restore
 implementation
Date: Wed, 22 Jul 2026 09:52:43 +0800
Message-ID: <20260722015243.16481-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0009.namprd07.prod.outlook.com
 (2603:10b6:a03:505::6) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|MN2PR03MB5294:EE_
X-MS-Office365-Filtering-Correlation-Id: 45ac35b1-172d-4bf0-8388-08dee793f10a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|56012099006|10067099003|11063799006|55112099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: bfhBW+Ay+qntfh75DLYkMuH5N5uMm7aIutarxjw2l9/mEQZSnCeoIq9/BxEn2XYx65X1vDfLPP5MEx+3MhgP/fy+m695ERgPhwyXcscSDgkKwSzCgk1/9TH0iMIL4gwuAO8jN1RS50SRDthLf1DEF4Qhqn3aZuFi48mHt5JhAqFWxGolmmfv3/IV7OFixakeHYlNC2R1bnfZCFlZGig4UnZyL0MLBPBVPchVX72qCt4pMUe+HFXOdAdkRttcKvsIiMWCMNIqgixfSyGU40lB5WvAmIPlbhe2ueI0SQFe98CN1SEhRuioM7VCiLbP9FQv9SnCGEPIY5j93Hlo0govWBBEhSZDfdSc091ezwejlldewZrdBTs0mXQpbPtq0U98Rr5Kn6mwTvQf6oOCQZK8agKtxo6m4WPsTl9vGgL/tppi0vBGlreXjLMFRqWK29xKDp8hkVPhwBwRupSnePSz3lA4GpIr14S57MMv0F5KKEEBO0RCqiPfiTDrJ9euGG/pvOORe0NHahyEL+5jhw7z07Dbn6w9hSfbJ0kFqcMvttMefjxs1X4SshfH+RxiPBysxeGmf25ITjQz4zv9/U9KS0899qJpii03fq7AJIVzoUOLDaaXZ4Rjd6jB4sFy+twsc/mfO2bWJ/A+LY1itXEs97VoarPSYL33qY9HhGPMbJM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(10067099003)(11063799006)(55112099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?19JEbX4u+ZUHx9bcddInWTzuK3ucWoM2SESFMyaeH19c31I1K0PBw2qb7Wsi?=
 =?us-ascii?Q?YY+SVT7HIJdOqPCFkjkQOsmgggfkCZcDy9SjuGT2Bq6PIiVK7uWWpTnSq3wc?=
 =?us-ascii?Q?gEMLuQCS/O0nWBZ2LjjZC8zQ2BSBO+aK7Mmky2h6C53ZCs8tiNQIA1Go5bHp?=
 =?us-ascii?Q?Umeju3+DoH/XcbPE+HuIE4NzSVbeW8vWZQ5lPG7dYBW0nB7qHl21E67L4Oyn?=
 =?us-ascii?Q?ki08rPM6clfRnfeM//+rd/3+wACXhsvPdIeWlPwIv1eNVqrTUQwRX4Fviszu?=
 =?us-ascii?Q?xXOHS2ZHrhx8sZhRKrnbC3f4aUzlmHhYlY1Q4clPSxbhBOjFEtaBRJFdoSvY?=
 =?us-ascii?Q?kuhdViC5JjH+Bhn+dTUdChgtmIXikqSM/jJ5ybKhTqXTh5sP5d6ESlkjwUIV?=
 =?us-ascii?Q?lugijNOzgfHTKKy83iwUn0YWeoAafi12ggiiqT+M9YRkOdVt7jywJ+b+bxZ0?=
 =?us-ascii?Q?WFucP0jVM9bstfz3rKvijrCq7cHtb9g0AVqnome9FH2YNVAgAn1GhDcXucgc?=
 =?us-ascii?Q?BIQr3evQt5KoMxyt3ecQBIFpBnQ43iWv4vsxs9z6qSKTk1m4mCnfsVdSTHlY?=
 =?us-ascii?Q?gQvKg2F+Pxotbz5KILZ9uqvZEHEPVzIf6HgbSxzdiWn2YcxE24ucQtYkfhvh?=
 =?us-ascii?Q?8x3Do0CloS96u1JJDFKx46/uMGPMhbEY3kde+3dk5Atow2Gk8358ImoMwSRl?=
 =?us-ascii?Q?8sqiVHlpGqx2EJ/uY7WSls82LbzGHpmzlO6MVLLrgqrlcwvEMBkik2lpy5wr?=
 =?us-ascii?Q?eQMqWkhEeDDEYjn3CDvK9cHHdTwQG6BnQbqcevHzAZ+2/y/fTIc6thA53Eyj?=
 =?us-ascii?Q?6igyyTqCE/HuUFk9lRwkIXReK2j2MMLvD9QAmVj8XO3Y7HFxBxrjoXyt0mpD?=
 =?us-ascii?Q?jZJEGN+JMWlaJW4zMl4NiKyJkrEUsczCTblWijZoej97YNhBpP1LJSHZHoI0?=
 =?us-ascii?Q?1Ab8qsb81iBG6ZMKX1xtakFNT3J72zsXC2Ufuk0x+hH38B+hnrHPlow39K6e?=
 =?us-ascii?Q?DXcU+S6Ma52lFj8hvWLVT1toM4UcbG4wTEN/bbXfkaH0u7jz4PV9hVa7t5/B?=
 =?us-ascii?Q?j/eaNJ0zz5+JXtNOg9Zn6YVHHFdNHuWEuJFvrejPZyQZFhym0uUBmjZCBLHS?=
 =?us-ascii?Q?qxMxzAJYaiejHj2oi+sWkD5pgh7lYI2z3VU4JLK+HO2io9aYNMIhNEf3B8v9?=
 =?us-ascii?Q?NFmyMxgJu8nct8g5WyCfbvK122cwl3npVCMklJrhtdLHScVgrlNNljbPjfMV?=
 =?us-ascii?Q?2wW3iTgoPra8bwT0yIeJ1rc1qHc+GNjS6dnVGsi4AtL4tR7qrhJb4qTpd5M2?=
 =?us-ascii?Q?p76X/cVnsnt7nSlG0MKQ2Xt4zb7BAqyHZbBeev2k7xcw6dsxJVbE0QRpHNsa?=
 =?us-ascii?Q?dQ85PK9R7Af+jodW72kcXfRe8PLUvJUtTedvSFEvlS2AaVSp7HMM6HAdUcJ6?=
 =?us-ascii?Q?wLZiVgBsa/V8CPVP8p9Jw7FRGNL7Hm0bKLvrjaFzhyv9B/xI+Z3tpAP3iu4R?=
 =?us-ascii?Q?nDEegoCwtZ/M1fE+Sh1aKiBvU6jEJ/DTF9wZQsVLZRhb4zGUzAm83LN/iopQ?=
 =?us-ascii?Q?UZnaA71Sit7wJcmwOXzw8pfulkHm+wBZAEA2jW3ikBO0jF8SN1nkwyQOXOig?=
 =?us-ascii?Q?Iq5VzpCaQ/kUnMyzlfoKCYWd5rjpyX9Y/Wcw1uPG0EhEdJOO46QUpNy3WDUl?=
 =?us-ascii?Q?aljNcCBCEFGwy75WafJlBx+auLMRQgqImNfA5w62wQtuHhlZ9N4J70VwRhvF?=
 =?us-ascii?Q?R6N+oL6JWjR4ARwf3srtaVmRikP7pcg=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ac35b1-172d-4bf0-8388-08dee793f10a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 01:52:52.7563 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pgxW0Alkkvr0sDLbWDDeya3aX/pV2YMEwYIWYdiXlaqZs9eEmGzJdT7SatQWgrk4C/lWiUVkiDup6qh7PuYt5bv0m8qkhFNOp3HiZ0FVoRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5294
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=altera.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHw8NY2yBGwDAw8JdOQD2mC6zRNjfg+ntDYkEDZJiyc=;
 b=iOTya8pH0xf+IW0C29Wg/FvWsmotZ6NEC+ALwflbVDQc1UrI6QQMRqyha8WXJ3DzE667IbPE1pnktttRPTWl7lgzb0xsIin0i8Ex6oeJc2YfvCZvMrPtqPi2aiwdoq9KHArikZxqWLojYDAQnVSxL/6jlA5rofuyMHnS6xdFRLE1p//Ibe7XPkT+rE/0Pq7VRw9gOCMFUAYHYQlP/UQh8BLJ06yDu9MnYk1bMs2EaI/LWWIzp0pSphyhvIDcB3IkCTzRN8ZugVDkB9jy+XORwJ3DWG4/FpS4hvVdVJacekj4xnfxkO/W6eQuHJhp81395XFklAkLb2F0PdfIFlQe9g==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=iOTya8pH
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=altera.com header.i=@altera.com header.b="iOTya8pH"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Alif Zakuan Yuslaimi via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: alif.zakuan.yuslaimi@altera.com
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Enable backup for data section to support warm reset in Agilex7M SPL as
no SPL image would be reloaded in warm reset.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/mach-socfpga/spl_agilex7m.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-socfpga/spl_agilex7m.c b/arch/arm/mach-socfpga/spl_agilex7m.c
index 7371202a712..93f148f2b39 100644
--- a/arch/arm/mach-socfpga/spl_agilex7m.c
+++ b/arch/arm/mach-socfpga/spl_agilex7m.c
@@ -20,6 +20,20 @@
 #include <asm/utils.h>
 #include <dm/uclass.h>
 
+u32 reset_flag(u32 flag)
+{
+	/* Check rstmgr.stat for warm reset status */
+	u32 status = readl(SOCFPGA_RSTMGR_ADDRESS);
+
+	/* Check whether any L4 watchdogs or SDM had triggered warm reset */
+	u32 warm_reset_mask = RSTMGR_L4WD_MPU_WARMRESET_MASK;
+
+	if (status & warm_reset_mask)
+		return 0;
+
+	return 1;
+}
+
 void board_init_f(ulong dummy)
 {
 	int ret;
@@ -28,7 +42,7 @@ void board_init_f(ulong dummy)
 	/* Enable Async */
 	asm volatile("msr daifclr, #4");
 
-#ifdef CONFIG_XPL_BUILD
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_RECOVER_DATA_SECTION)
 	spl_save_restore_data();
 #endif
 
-- 
2.43.7

