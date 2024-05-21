Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A90C7C25B75
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 08:47:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1C11880A8;
	Tue, 21 May 2024 10:47:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Ciso/D+R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF60088149; Tue, 21 May 2024 10:47:10 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9FE488027
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 10:47:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ej6H4i+Xk3/VGpSBoTdUgYjnRADbdR5RJ97JSdO7CoHBL8I8GD1tmBdPq3q3ywtJIr7o5vGNNWpRms7rzODHCUL1t0fsruA6yF5HvCl2hz4p4nfjSn0GnZwFwrO48zfPsS/UsVztqsb3YORllhh5wJehf1vPZF3N4IJtPVRxHXuqlp/oTYepvN5dv+yguiN60D0HqYPXg+9blTraOul62CMMLpvNSA1RB2MqVBWOymgJ+2Dulz2MvaYYhUCaqG5rvNQxM8CJtmZYvIr/O6DLxVZ4mXcVlNSEkw5cx2fHQudfeOPprunOd/hbNoqT1uzZgKK7jYAgKwfQBG+CGzNwOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/uijchBW0Guywgkf2wRnPwdt4xYZ3p7GXQUILXANpU=;
 b=I9i5LExMDH5z5HzMHozuac6iAn9cQ4kC8zvGTy6mmLtSky8EYRSs9ZLJoW5m2kFJfNQcToNOXQXRRT8Cz2fheGef2nqVoDa15MB0SRsaEhT92HIRIT/CP5RjjWZIJf/+r0uSUylm8MsiPlzxxyCEJEf/MoKeaiaEKyCthobbdpHrQc7qXCb31kaCtc5ukxtvlj6shvOdMJmideVbBln1sR1e7k5rc8vbfjwCbnj5/ryHsEY9Mu835pgEc0ESiQ4qhWsE4XfB+ksVTIppJDVc5JhIEBRBjQ5H8jEqnze+5uIE8XZEIX47H49+nlVhDQnaI6+PbtlHwdegQcLAQQ9CIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/uijchBW0Guywgkf2wRnPwdt4xYZ3p7GXQUILXANpU=;
 b=Ciso/D+Rxe1we5w8KAZBx87hivJX60GULMCFLAVDScjYoCy/UigOfv4FbyB07AP7GGDYEUJlvYR53P8v0uGDSYDBxp4CVkmZ2tgK022DFuWfzDnID8z4lslPazqN9yRl5n9IHzH9El0zzBwp6Y5G64RjNKGLfW+Grn203AiBaXk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DU4PR10MB8709.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:56c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 08:47:06 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 08:47:06 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v4 0/3] cyclic/watchdog patches
Date: Tue, 21 May 2024 10:46:49 +0200
Message-Id: <20240521084652.1726460-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0056.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::29) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DU4PR10MB8709:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bc843f9-c96d-45fb-a672-08dc79729837
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|366007|1800799015|52116005|376005|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yQuWCWgQ9HzT6tLt9D7H2Lv6iNR86RGoaALfkrr9d/BrV8MyaV7pMTJvtF96?=
 =?us-ascii?Q?Z+h0j/wk2D20NjUs8M9r7uqZbEdCL7vy8tT/BYg0tyr73kRdLE0PhZhLN0SS?=
 =?us-ascii?Q?6unyxrEkBvhXASTekfgSEFJdJBGZAJAoinddsbEwkFWEAgCqaO4Od1nCldW+?=
 =?us-ascii?Q?Ws5e8SJoA4phcRj/EmMNATssUFLsvQBChMOB8s+l0gcESR9ysLH/Q/TzuFvY?=
 =?us-ascii?Q?UGogq3W6EOh4xvISP7d49bNXq+1vRpaN6H/tOD/s6KzEu5TzK5MecIxidsRh?=
 =?us-ascii?Q?ud5RD8q6jqxjlMGI7cNvHeL/j7z7uAqQkzg+jDtzamgCMejtxJBBaxw1e4TK?=
 =?us-ascii?Q?TaLk1rQUvR1qgI30zMkZBaYJpvWlbR3dSv3JIB7E4yyr1/SIdfShI+GepRfW?=
 =?us-ascii?Q?XguGVgMyyOFiEBAjfScl4gmHVzYDLgbMj6NqaHv8nvfW2Ngihkzd4heVi2Vx?=
 =?us-ascii?Q?lD1Jtuml69Kuz4DcfesVPu1OXlRqhqWNhCSADfNTGI5oBc3PkOvVt0FOXf5V?=
 =?us-ascii?Q?B5sYcV4PhDbtu3MYc+3TtK93mCJPc7ZcmbfnBoqVSNsBFT3FKmOr2q6AohRJ?=
 =?us-ascii?Q?Yfs7f7DomE1F3l7JiSt2ZySKIwmv/c8H1f80sWRHlNe4R4nwzCxY5zQ4aWpU?=
 =?us-ascii?Q?M6ksvULwBQKuIDVuQ48l6Fikx/fLnUBumfYCqgDtHebysgxns5CMiGe/iVWe?=
 =?us-ascii?Q?VlpAAMzJn4mWhobf5Vr2fBHTkKkmpxEs92TEh7ARwqm+MOmQyuIEHbET74/p?=
 =?us-ascii?Q?EK9XWsNJH5Au6NmQbAj5TSpCUSN0V9vVsv0a+b+PNEGCKd5GoHNvOQIjxXJX?=
 =?us-ascii?Q?Qjxc3wzqnrAYnxFB8m2qxwuDSOf4RnK916TFj5X0847ysggoaJFzBMr5XvfE?=
 =?us-ascii?Q?0mGfBSGRhMFnMfj2MKrE0OoPsqb6agt1orfAm8Pkrz2H/kjxrTeIwn63DKTw?=
 =?us-ascii?Q?FVLnUAz5OeC8rl5ZIPFZnwScywyqN8K4SQw1hyUFvUDoaCAlWwpEIfFChAZO?=
 =?us-ascii?Q?BiBLsfrce0tEAmTjZGGV5WEUa06Nch1jwVf5ZC/XUyOtGozXJdt/GdRwCmdP?=
 =?us-ascii?Q?SJlxuyqajo7u2NfrikI6qlVtopw3jArVB9k6lpWsWLcClBAJzS/4vIFkERZe?=
 =?us-ascii?Q?AlcI5bhKhg9oq0RhwYDrFKxRdQ5x1H2eIM7p9FNCoti9APGBT9kaYyRV2p6Y?=
 =?us-ascii?Q?uHA9dyeNqIa9fdpWxvi0dCVCxhS1hMDENznEaikobujtkVp2FCq4RvX/CjHY?=
 =?us-ascii?Q?4f60xEUX8CWyqowVRXRh+VgXamOd49OImupL69hYMw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(52116005)(376005)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MrA29ClarJ49WOqhHbbfbar8+NWaDT4kGYF/4hKidpmUQFgiMdV0IWFUHMRg?=
 =?us-ascii?Q?J6pd59Nr+Xzvjw1KyvKMHzg6zVEnabuYxgBZ13whAmHgcQEZFQ8Yk/Ok6xZT?=
 =?us-ascii?Q?5mPI4J+o0JBVbP7Lb0DjZ6kOADCd2tVwyk2l+PqgVo7oKKsDDMxYWZmSIc7X?=
 =?us-ascii?Q?lQ5UP7ckU+7ZpRwLXfsgxf19wrFBl1BKz4w3O7QjbmY7r9rfZrxfnZp8ASfP?=
 =?us-ascii?Q?msZv8FkY2+ofxJszAeAUderJCqZqeW0FlEQB/7cSnWedvqOcmYO2Jk0RkbMt?=
 =?us-ascii?Q?qNjaKUtcBbEq3o3xUMypCXklpc/lqgdC6b2rJIpp7UvKdOEqNe9qQoXL3OGv?=
 =?us-ascii?Q?wt2teHyNWhMSIcmXzFeNpJmLY3g61Z9BRcjhym6N6cqVUe6RFzsD4ouqHExh?=
 =?us-ascii?Q?FBR9VtVfFe4IztAswyRIyq+cxU5G+Bkkxn9DQ1taTIcMedro+sBSm5oLXLFU?=
 =?us-ascii?Q?Neb0KbHzXxPUbbwbLeZko0AKyufpWKBAbePDJJR9jBMp4hnE8LknSGq/LLIQ?=
 =?us-ascii?Q?SS2nlSOY0ApnCcA4yKdniVezIjTdeokmS/dPBnhwQr5zAySlSnvBDCE5TPMh?=
 =?us-ascii?Q?uJYF5N1J7vYD1YIczTtaT5jQHXRGfhPafVpjtbPYzJyr7BcR5plOKs3FSssj?=
 =?us-ascii?Q?Yc/aUm5tAJv+z57+1g2jvJBJGwCNwFmhvFf6rFJhZtLdN6gi8IiXsHxcf/Qy?=
 =?us-ascii?Q?V9e7/T2uQlz+TRtpt8PiPIKkZqmE+JaR89MWD/4B9Mx0x1WfDe9jMhRjUQAe?=
 =?us-ascii?Q?taGSH390m03nPHnVedOLfvGgyEPzmPe8dU+Ji2ldNkuwtK39cJg7n4QyHtbS?=
 =?us-ascii?Q?M9ANCamLs5BhPc+xZZbLKacI43dYZer3fUkug6VfInhZfrJ9l1sMpqsALNlG?=
 =?us-ascii?Q?x64M+trigaUiye/FAyyOn+P8UkNOL9iQTDQvH2BD6+wqVZIn7phLHuPGMUE9?=
 =?us-ascii?Q?nbRil9ssY7Pn4vT5F19wO1n/sQm1504qp/Ssg9HxbcRcZLZCRyy2o0YqkkSn?=
 =?us-ascii?Q?VgVvlIsvjg5s8q9j9JG/z9ci9UoM/VRVE1zJLvwKMmOE4FZp+ZheuUUn4na8?=
 =?us-ascii?Q?6kr0SC8lsIxhfCZ4dJPV1HT7HPh3UQlQoRERgcSg9JOCfSs6djFNo8Hl8mPG?=
 =?us-ascii?Q?fCIL0Olxo5SuehwL8H1PNk0aVYXU4RwXqTCGUubLEsSsaqupI1US7v4CKVOE?=
 =?us-ascii?Q?EL4OM89kwKcfo8F4W9VlPtbSeiiitklBeTypO7Wq7sa+bzAzdyvW9GJP22+U?=
 =?us-ascii?Q?siSBbYJdA3J3G/tMwMuajJRlg5cu4/3vqw3MjUtSR4rtfUQrwP7Lq4iwJA/I?=
 =?us-ascii?Q?qFMVIiYSy/hjyZYLTPwgRX0zRZVdkt5ZIiBWxv8KR1hdqPSiG4YrtgBie3L4?=
 =?us-ascii?Q?KSi9ykgQx2U289d7lIJ58BKlvJl9f100PqMm/KwEFEaq7ZA/Tw9Ik52Qv958?=
 =?us-ascii?Q?Y54QjrPqD3vcj5Dwq0Wsuu5LaDwq2AOS+rGU0GLJ8+hL6U4OZd/BUaBhimtk?=
 =?us-ascii?Q?+0/FC9jsUE5R+T6LZAOMspG9+tuQDpLqN8uCPCmNLZOV/R10E//mQ4q7KHfx?=
 =?us-ascii?Q?csd0rC9bhbeflGF+brtOOs6LSVdOkvRBPER479VX7N1YK0rBwUKLXfWKptNr?=
 =?us-ascii?Q?Sw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc843f9-c96d-45fb-a672-08dc79729837
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 08:47:06.8002 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4GlzNtWkBzvjIx+QQvLktNfSfqXNLjltywEpIkjyyuvd0bZ2uf1nwZgIsETDELD0R5GJaD5PqTwMqcgJXU+fW/T2ToCUBI9+U1zkQv4QHyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8709
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

A bit of a mixed bag. I've been wanting to submit something like 3/3
for a while. So when I stumbled on Marek's patch
https://lore.kernel.org/u-boot/20240316201416.211480-1-marek.vasut+renesas@mailbox.org/
, I got reminded of that plan, and I think that patch could be more
readable if we adopt this model.

While actually doing those mostly mechanical changes, I stumbled on
two separate issues that probably want fixing regardless of the fate
of 3/3.

Mostly just compile-tested, and now also checked that at least the
sandbox test runs succesfully, and that it builds both with and
without CONFIG_CYCLIC.

v4: Make sure there's only one definition of struct cyclic_info, previous
versions failed to move the full definition under #ifdef CONFIG_CYCLIC,
breaking builds with !CONFIG_CYCLIC.

v3: Also update the unit test according to the new API.

v2: Add R-bs from Stefan. Fixup whitespace in the doc/ part. Rebase
to current master (676903c1b97), fixing trivial conflict with
301bac6047c8.

Rasmus Villemoes (3):
  cyclic: stop strdup'ing name in cyclic_register()
  wdt-uclass: prevent multiple cyclic_register calls
  cyclic: make clients embed a struct cyclic_info in their own data
    structure

 board/Marvell/octeon_nic23/board.c |  9 ++++---
 cmd/cyclic.c                       | 12 ++++------
 common/cyclic.c                    | 24 +++++--------------
 doc/develop/cyclic.rst             | 26 ++++++++++++--------
 drivers/watchdog/wdt-uclass.c      | 38 ++++++++++++++++--------------
 include/cyclic.h                   | 37 +++++++++++++++--------------
 test/common/cyclic.c               | 19 +++++++++------
 7 files changed, 84 insertions(+), 81 deletions(-)

-- 
2.40.1.1.g1c60b9335d

