Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F51CF34C3
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 21:28:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A73588CD9;
	Thu,  3 Oct 2024 23:28:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="ljbqSHOr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA00A88B2D; Thu,  3 Oct 2024 23:28:10 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07D6588CD9
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 23:28:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rC/6prGyKaPKykB84nx7rjfO+aAG1pTsFjPC5QAQaXvFFDw/FfcICHllehDtnxDDrlHHWscraQMjOMXv/WuSODNbX7mTbU/l2GlwxpcN79jv4mIZWqR5vJaSkwARyMvEfeFhuOOUgIivz9YFVQzLHmh9qHWOPVDbfk50ELrOsvAFZS9x2PSz+BXYC9ggf+we2AXvijarYH4Mfo+fPfCGUpsN+G2K8E4cgvTF5j5P70aUiMb1BBl7tQ9eon9u4rXQK0qbv2GXdxMuM0Dww9eAJNyXWZ7MfsmoGd7D1syTb14frSfSA3dBg9OyVvNzS6EGNhuusok0SE9/xjbl+1ik+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=756TNvB/rE9NuTWmVQSsevqh90NvUwZchemG+Ncd6Uo=;
 b=JeG6VCR1JV5VTvmV6LXAfPlvw98lwWG8hwdyiyNktTSf7xwunFE4bPMtT38sTBDTtwD5osS2m/XUeJWId93kW1W8JvCIl1Ya4hpKZFkzXHJL/7Qw01JPc6VHdOsRsZkYX2KwS19G/svnH5xWhrSsifDen6ta7qkIZpDOmnzjiw5n+nxTgdyuaV5azX0gE3ukgxa+z1vcu5S3PCb9uP2SZxmwUFX3qbIw1iZpq/0O0pjfxJ8eG7Wek8Ji12HSvX8bF9kC4zmfIaYC3dwLVMb/5E+jYIDVnA90SfUGoVYH4ntBS88Cjk3MDWBV3ANEJYkMW6tdrQ2BIwiqY3qw7wdaNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=756TNvB/rE9NuTWmVQSsevqh90NvUwZchemG+Ncd6Uo=;
 b=ljbqSHOrBdFMQ3aHiKBoQDNbu4QYR3z5fqaO7TW44zoKwGc4OlhQK27db98LVT3p7sXwtXoj9DNOHvIvp3lVYgmQTLxiHKQAJmeLkApWEhIXr8hxmi2xOtttZs6khBi/GcTmASldpWgTB/WL7fx5Kb/vhFJ0J01NxQNgiXDtHKc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DB9PR10MB8118.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4c5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.9; Thu, 3 Oct
 2024 21:28:05 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.8048.007; Thu, 3 Oct 2024
 21:28:05 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 00/13] disentangling cyclic API from schedule()
Date: Thu,  3 Oct 2024 23:27:49 +0200
Message-ID: <20241003212802.3810-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.46.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0045.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:b::8)
 To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DB9PR10MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: 08151e9c-9e1c-4398-d0a3-08dce3f24497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P8md/6uRKE97IoAQqzyozTTiZ9izEMcYyDqjFCSXPWqozrCT8rbkaDuN11eI?=
 =?us-ascii?Q?YAOP0KDscWpA/1CxyDKftdHKRw0Q1+NDQKfTOd856WOUQfO1WWhTNvQ3dY5B?=
 =?us-ascii?Q?NTAr8YTdJUh2T8I48c1fUX28tgErq4SdOFzGxlpCXb6fCgWZSTODK7CEBCYd?=
 =?us-ascii?Q?n8lj+6Zokmv3box2sDU57c2vPgxDt0uNsO27BLb7Jqw+FZcVOpcdZZOO3GbU?=
 =?us-ascii?Q?lgpyd2l6JSMMDKQ2/qPO4XQ4Br1MBwJUxHuS/OZJJG1fepFVB741CnyNjxfi?=
 =?us-ascii?Q?gTuLVLUAU0OzBj27lgvmr62vSAINAcNyEYZUKun5DvexZb1BomBTPNwwDNcw?=
 =?us-ascii?Q?ULdC+IoXFyEzXwIt+wiclLguwpn5m4hNXRkJzkLqFInHBcHyG0DmsuINm1Om?=
 =?us-ascii?Q?OHh7g7Kvd4EvmXKkGoxp/npaxnOKWpan/yO7JrPH5D0ippRvrhUkuwqfhsb7?=
 =?us-ascii?Q?JWZhebgU4Ajni/9UhQbSJIv3FdUMx+yXf5wkxrd4cq1eXi1TT1pvgenIH3ll?=
 =?us-ascii?Q?0S8hEOkycigyh3pURdfpO+9e9zovKQWgeabVv9JqAJcfYOsBosSCfT/S1yHd?=
 =?us-ascii?Q?NeCIYVc85y2hiaPwI+cFBFTBefP4EFrNuYrwvI1qvDShWCATE/9FtrMbArRB?=
 =?us-ascii?Q?0XjCvXACJxAcOXR7d534CoEii9M22p77Dn4+ny5iE/bg5MrusIRD/OjZtmTU?=
 =?us-ascii?Q?zvAwkOIqqCHgbBUg0Pq5itaHyyD2i2zjCPYxnOMC8ZFkBrq4niA115PIjxDC?=
 =?us-ascii?Q?iMjsWmnwHZZR4jXTJQm8Fv+S2iIsAl41KhjBMq5hMSgCKOwSdtXtG4gasAjO?=
 =?us-ascii?Q?zhHdv6uqW+ooaLBO7GOJ62KDk1OI4hHRZA2fENswIcpyxoMgv/fF/Wlmw76N?=
 =?us-ascii?Q?LGK59Z4tuxMuUSHg0W7+Zt17qvgrJsItJSOwJoR8zOc0imvxU4uflKLvO2gq?=
 =?us-ascii?Q?IIMTjoHVyBezwH2XtT46R4NEx0rKlB/l6KzrCHY/qOJZNEAzKHWmiGEITfci?=
 =?us-ascii?Q?J46kHu76C4GqrPn7Tm6Bi2jDYs/OL4mdgHPHQQc12oE6a40gpFC0XU13P65R?=
 =?us-ascii?Q?3Oh8hEMgnWb6cy8PALFCTyrnlRZJ1avn1Knxgwj7S869XCMmrpqhFGS5a7Y6?=
 =?us-ascii?Q?9C1glG9R3YRuG/pDr0f5Btf9rcO3YUDfhZwr8vu90US4KYudpTZt1iCaUdHK?=
 =?us-ascii?Q?s+RpekA6n7+VTC/NNNh4lcOowwOGKoU+H8VuM9dgS742v9aoxrT0omvrOGc/?=
 =?us-ascii?Q?AqV+zblwjSLu7fro0zNadvNUQ3QjYikVWIL8AJTaZRDlZn46jfF55E9lNv7L?=
 =?us-ascii?Q?xKTCqeg+nK5KmFyccR6GYX+WYuScBqcgQEx7abeOM78IhQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jSvAobaem/m3P9hy+qltErXyP/sHF3SbkIkv7mNktC/mt4SPUY51lMuQFERG?=
 =?us-ascii?Q?emiZE3v9guR3IkRej4lRb2f6HqnKB7AfIUa+fqCSz7dfnYMasSuGswStMmKW?=
 =?us-ascii?Q?9DGW7Z3A9IbekGt/aApE2znYWdZ25Y1NVml8pGMJZHVBygTAMzXE8ICLX/32?=
 =?us-ascii?Q?ouih/soOC0h/4oageCVf09MnJjjXN7sFWtgVg4Q3DscnUj4+lK9E/XU6bAep?=
 =?us-ascii?Q?pOs+Ca/KWCHGSqwPbHH3usL+HoslogW10aXQP3a2OjqqrOkcXlJ5b5bSUP6i?=
 =?us-ascii?Q?Irj+kE91nfhNbMEt9Z7RDIRDAWzmnB8VHWg9TFB3BhuzHPlJ0UWkKv63JEpL?=
 =?us-ascii?Q?hSAtLX6XQnU3mMqRZdTg93PVbWps1z4Hc12u6BuTi+IR5QRJ92I8VvWFD1lH?=
 =?us-ascii?Q?EuDmLwWTq1lOywfPXnsAw7yOPng0h+Xd2350sp7K5LFehn651Q7uF9hbACWs?=
 =?us-ascii?Q?D5uoRhZh6RYBFGQETfEotsEufAJjHFwLQWYfPRqB75B3wMMiXbutV75r2PU0?=
 =?us-ascii?Q?85noBIxoQaa5jKtO6WM18pjf0nHK6Rn7fMKO7jGCSWQglrmEyol/U9/mmLL/?=
 =?us-ascii?Q?68mKtCWR8RydJOjk46iZ+tg2N1X5jWiBG8oV3SBtutIuOqsUOpY5CJeii/2Q?=
 =?us-ascii?Q?RZaGWacQ5n+OvuklDe02kyfC8Hlc7N+Wp9RT1S5ObAvTOIEzBPOl0FQXl/9k?=
 =?us-ascii?Q?oYVdJjPVE5vM9pyi4a+d9LMtDkVXemKZsDYDSfAXLv+/tX67GiI4luo1qgBO?=
 =?us-ascii?Q?NXlsI8GgQJba9D1Wnhyws8Pr1WkGnabqan0GDEUP5ShL5OA8dZK1kjNKy/1z?=
 =?us-ascii?Q?eppYlfswxx59Y0MFW6PVzL9YVT8ywQhifY5KcBBhFdnLttnXd9mkyZ/VCfl/?=
 =?us-ascii?Q?6bRSDb/veiToe2SE7W9nYv42ud2eAy+Tk37By6kFpcMzUJFu8h0yAc5SUlMd?=
 =?us-ascii?Q?9UHll3sCidx1FOr51CFUqAbSR+OwVHqnhsfKe71qxJztNRNrp2FLJ1CpO9od?=
 =?us-ascii?Q?op1dlCDQmkCOzK3vp/H1EVTlp4nT3gsaDWff8AHQ8afKOCTtB65rkxL9GCiY?=
 =?us-ascii?Q?WubMaxv0rWzCQMLkXV8c10JCH4B2qwkyCRtqB5TcAVi4npl054mfHuaGEdpK?=
 =?us-ascii?Q?l4Ik7bBuc2ljhpQCPDcqYNI2StnOhltJ2GFY7DC2Ykqk1ye30zuBvNKuYgWd?=
 =?us-ascii?Q?HLmMJYZZFSexI8d4sG2Wlxu18Agf6OCxjcbzTfVH0kak0bU5KrDmtHCTS76v?=
 =?us-ascii?Q?Ncz9LWQsOy+2LU04r88PGwwNWLG4XABZ98nshn2QiCRoro8nYgXZaJVESKnR?=
 =?us-ascii?Q?l95oTbsYuu4jxOIP6sd468804hY20jXoghuRqXH3cax6Jv6l2JJXeUm2vS3n?=
 =?us-ascii?Q?3A865y/9S9FtFpHb1RvGyEBd9bUyLnLv6Ck1rsdJWZmUwMwMxLf2lHKcmRXD?=
 =?us-ascii?Q?CjaaozVHCxQAqq5eZGjJ60ursXuKHSw+PLUty76eZCyG0mCaWlO58gozpd75?=
 =?us-ascii?Q?j+7QwhSMKCH9dSUpqYsieBwfjhz/gbeY0DhNO0gB6cRYH3NF5Fr1BtCJYm12?=
 =?us-ascii?Q?TJK7qkQzkTKho/0fQDNpoB7wIHy10Ovt8hypjHyZVz/Au9EMIjOquFsmNpJK?=
 =?us-ascii?Q?vQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 08151e9c-9e1c-4398-d0a3-08dce3f24497
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 21:28:05.3848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OxDoWSvOltDdVgS1qN/pmFqCJwoo6FSxh87KGT2i4B5OtoFhe4HYUBVQYcVQ2A4JOhmkF+V3HjFXt1ywzCbVSpoGBArzbSmqdhyqQSGrEbU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8118
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

These patches are part of a longer-term plan to properly deal with the
HW_WATCHDOG vs WATCHDOG dichotomy, and getting rid of the legacy
HW_WATCHDOG concept completely. As part of that, clean up which
headers include other headers.

While schedule(), the artist formerly known as WATCHDOG_RESET(), is
obviously called all over the tree, very few TUs make use of the
cyclic API (cyclic_register etc.). And there's really no reason at all
for global_data.h to include cyclic.h - except that some places
implicitly rely on getting their declaration of schedule() through
that include.

So this introduces a separate mostly trivial header that just serves
to declare schedule(). Then we can get rid of things that include
cyclic.h just to get that declaration.

A next, mostly mechanical step, could be to change almost all includes
of watchdog.h (which most TUs that used to have a WATCHDOG_RESET()
invocation has) to u-boot/schedule.h, because again, most of those TUs
are not really concerned with implementing init_func_watchdog_init or
need to call it. But that is for later.

CI seems happy: https://github.com/u-boot/u-boot/pull/673

Rasmus Villemoes (13):
  doc: cyclic: remove reference to WATCHDOG_RESET
  cyclic: introduce u-boot/schedule.h
  led: include cyclic.h in led_sw_blink.c
  m68k: asm/ptrace.h: include linux/types.h
  fs/cramfs: use schedule instead of cyclic_run as callback
  test: dm: wdt: replace cyclic_run() by schedule()
  cyclic: make cyclic_run static
  watchdog.h: change include of cyclic.h to u-boot/schedule.h
  lib/sha*: include u-boot/schedule.h instead of cyclic.h
  i2c: rzg2l: include u-boot/schedule.h
  ddr: altera: include u-boot/schedule.h
  boot: cedit: include u-boot/schedule.h
  global_data.h: remove unnecesary include of cyclic.h

 arch/m68k/include/asm/ptrace.h    |  2 ++
 boot/cedit.c                      |  1 +
 common/cyclic.c                   |  3 ++-
 doc/develop/cyclic.rst            | 10 +++++-----
 drivers/ddr/altera/sdram_n5x.c    |  1 +
 drivers/ddr/altera/sdram_soc64.c  |  1 +
 drivers/i2c/rz_riic.c             |  1 +
 drivers/led/led_sw_blink.c        |  1 +
 fs/cramfs/uncompress.c            |  4 ++--
 include/asm-generic/global_data.h |  1 -
 include/cyclic.h                  | 24 +-----------------------
 include/u-boot/schedule.h         | 24 ++++++++++++++++++++++++
 include/watchdog.h                |  2 +-
 lib/sha1.c                        |  2 +-
 lib/sha256.c                      |  2 +-
 lib/sha512.c                      |  2 +-
 test/dm/wdt.c                     | 10 +++++-----
 17 files changed, 50 insertions(+), 41 deletions(-)
 create mode 100644 include/u-boot/schedule.h

-- 
2.46.2

