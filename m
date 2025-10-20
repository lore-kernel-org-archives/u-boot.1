Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6018CCD193
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 12:11:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CF4A807C0;
	Mon, 20 Oct 2025 14:11:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="RaSrRUgn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B19CB83211; Mon, 20 Oct 2025 14:11:19 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F471807B1
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 14:11:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DGoVPmzb9bbO2oQ9Qbhc0a2PnOgzAXI1MjPVGR2UWBryHQst2klV1jA1/pGMaF/hIOZPCdF9p7Rb2SUDIrd6ueg3NPpDj7tc2XTMxN+Tjwpx+lie6Lefn6/c1pq6QZ8BpReTwGp4BwfjabWxb65o1up2y23DKgalVa2HQpkHscvxgd5wzQbRi4AnJuulHegD6stzTF1JaMaWWgllpXOoH0JU1E+zxVMlBYrYQ22QHeKRyltXLEpOMwU45igB/Hr2LxOtmVoZtCdHMh3dnlhDb+oBZc2qTfqzUvt0+3jc5OQxrNs2/sfB08UYxtoWKMIzljG+ismhyaPWR/FktsxLvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MulWQ1Cq5an8YyRjawNekrfAH1v1scjQzXR1yNBT8kk=;
 b=Yw2P3ys3xUW5Yi3GpIYhwyY3dIUtMKmG6B2uLBMVFyst5w29MhuKx2R0ZfiB4AGWZUriiyuJc9klfzKoCLxuX+4IzpLsQadzq2zcHnNi8xdE//SIOLDjqxPfZgkJ0z7Ymr723cQWqF3MgkhIPknlyLaQ9oejVq/fbYxgVu0l/1LmThHyMRcDq9pRn9aZkeo6am96xcnqhKfAun3QYMLK4eLfPParsWTpBzyeaBbcKuDXOwAJBi+rTjFcBJkqrDzeQuSep+vXeE/hvn2MvbQiA2LMzViTBNJ3IlU1KNJ7JoQbG8ug53qg9gBUxomU0DCqQFX5VMAM/deQl4tAItyReA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MulWQ1Cq5an8YyRjawNekrfAH1v1scjQzXR1yNBT8kk=;
 b=RaSrRUgnFKeR76hNfs8Jjopijfk0Wxl62w3meCabXKQ5q94RxSns0g7CZBitFmq9rRFydCL+vjn7XhOog+bUFuSdo0VF7UtC4Mc4GVgmtXSw6QTgIL94ZXGnmtibFJncRCnFZ+kTMYein/btYBcDhZ24UwpEk14dbNhLgARSgoQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DU0PR10MB5924.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b4::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 12:11:07 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 12:11:07 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 0/2] 'part name' subcommand and some robustification
Date: Mon, 20 Oct 2025 14:10:58 +0200
Message-ID: <20251020121100.1742812-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0037.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::27) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DU0PR10MB5924:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ef0ec5-0bc3-4622-9750-08de0fd1bf69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|366016|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Vqvaw0Lx1JpjdEIQfRk/qyEX8zU7I5avNkksTFfva/IAaUJiKs3NXHpjgdWj?=
 =?us-ascii?Q?bnq9eS+zMF6/U+yHFN9ZKBpwqjqMgr89ydPf8HvJBjtX3lZhjVnlwmtuq3dT?=
 =?us-ascii?Q?XQZfpRI5tClpHINYz3S6pJok9YnA5pFNKnbYmArU0pjw485pSIxmErFq4p0L?=
 =?us-ascii?Q?CqISE+HMZIP+tjwd20QIZbmcEkd0mP6sAAoKdqnG9noa+jU/ZCo/sq8Xy5Mh?=
 =?us-ascii?Q?f765XAcU+MW3jYR1IRByv/9otf1bZJYulYy3FVEStLdxO5h8lElonRcHdLOW?=
 =?us-ascii?Q?FikQuBBl68JVRByus1rwNdVi0iVZE+mnZZe3Ei09zbJDRIGLnOeZkuJA2yiC?=
 =?us-ascii?Q?sWwypIKJ08N2Z66xhh7rstKUK40yLgXufbe1DTqDGsGMuTs9EilldZmcFqkL?=
 =?us-ascii?Q?Ud1VuAJawdPTsLvNdZCDk28Adv71svUuqpEz6h3qGLuF9M+nsqs3mxCE7vzJ?=
 =?us-ascii?Q?H9iIkXI40dyxdd/RwQBtALoOwgjFupYmCmPrSdlcb3vcrw7Gt6xSDKUbqp6R?=
 =?us-ascii?Q?PGyvXmtYuqv/QPzEMSlG+68nzXM1uqw1U/ljQk6wTa58vFKQyrNY4wRJqwWf?=
 =?us-ascii?Q?1j3IY8OjFdqnx+NXqPGLfV0Zf+8vQZfc54xmkqqKDTOLh0NiP3YSbGvdlW2E?=
 =?us-ascii?Q?OxBkVOum3uxcrwy0DE5yeU6/KutrcVPz3LUvZ4YggD4cZdpsIdPLyPhxPimv?=
 =?us-ascii?Q?nuZ4KiY0bjQHJj8iCH89rs1fwlr27ox8PdTMMSRA7hwCi6I0NR7gOS8K6AlP?=
 =?us-ascii?Q?Qjct06ddL5SAAcXmpWhzXLjyA8n6Wnnc6vt0OxJBsVrcUz5SJkhF9iPsV7t/?=
 =?us-ascii?Q?R0Kfqx2nrkRBiajk9X5pH/yBWGfadQvUBeICzYS3Opqmypo7vy9hk0jSHN2z?=
 =?us-ascii?Q?DCBWSRwn2yCU6I/opmStxTQMJBkr1fo3TKsXawboht5PYVf8muzxcFESae1U?=
 =?us-ascii?Q?PQicYnfwq+exqAxGfKOJrlKwEg4pkXtcoQOlLEFapjvFipUY5kOj9yXzpSLq?=
 =?us-ascii?Q?67FCATQE5w20PF9LYLbjHK+fL+SxDrVfWFwJQneljwqcEZqH3xE71uCyGTt9?=
 =?us-ascii?Q?7Z4Y4pdFYcMFXCu7gRej4e4Q+qBBv+6mr8Ht3vp/62enFjn/5sxh7+6oApv3?=
 =?us-ascii?Q?/ZNQCIx5Eozv6uff6TYE6/tWCv2Rz0QOHajB9K8oE0D16iiBWjgDTc8UJVXY?=
 =?us-ascii?Q?lJ6+DrUruTkNTMF9BA9NKeASLClKKmmi7gQyiI459hcXr9su7i5FV+2i2Pmk?=
 =?us-ascii?Q?J+kK3UUdQ5IulYTKCU7QI7kg8/Z0etz35lqH45xAWNc3Ijr/M0hSJ6Zs3X/X?=
 =?us-ascii?Q?hL4Hn1F7+Q6HOiCYI8zRlOpgXN9RmHGQVtUPhjjv/xbx2TmbkY55OHTkqi9H?=
 =?us-ascii?Q?iBqUxauZTQNX1qHkq6ciqEn0CoZKBMRaZSDg/ZAICAlCRq26QmcVogIdfkUh?=
 =?us-ascii?Q?h3trwFY9pbpcbDJXYsdifEDDt5hoTJ3r/qLH9WK+JxcEjyalXpbIwkWfNJ2T?=
 =?us-ascii?Q?wfV4nEaC3LFUmw+gkI6PjKh4sG9334gPEzQW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DbamL6tTuOutwCKGiTNgpe7ul624phphdE5Pb1D6+LDrK5jxynWNmDdmUtNn?=
 =?us-ascii?Q?T7aRV5g8tra9fEErzfiftzYppno3jLx056tXajiB6uQiLuhS1eo8hNWrtt1l?=
 =?us-ascii?Q?cH5oxi+VL0DzqzNEAhRsN2+D4J3aIdls8oPL2g75pE1zJ/5/ch6zqPIrWo6y?=
 =?us-ascii?Q?xcjkb+Iu0arsUgEX5HFjFzAhQgT29rSMW0H8qBVQGzDDOcreTwYgq2sflhcD?=
 =?us-ascii?Q?NXDW00BqaAy76lpPgjckmwOD2lF9Yx/nDSprzm7ZJGGFvjDTgJerX5mHZxd0?=
 =?us-ascii?Q?ERTJnhsDV/A8p/FPn2SA2+LJa4V3X+4MG+KZi6brC74TET1lzbp3qmpToqV0?=
 =?us-ascii?Q?JGzFHPbRHWgrRBaUbF8SwkPmXh/TFOyrM8EvI/4jdnQAm22Fsmyxu4pDAd44?=
 =?us-ascii?Q?IKqaqgqpYyQNDhxrD6j0Cv6kcTOp3SD9upBWVgkLj8PfSqW+FBDAEkwq8vGZ?=
 =?us-ascii?Q?CLOMAuSjdXvTHByOV+SBgCZSn6QbDrlwmdFSN+/Acya+pTcrbEwpaXgr4/dy?=
 =?us-ascii?Q?Z4Y+c23pEw4MtR+8ilURYGUTYscOPLXmp8crTW3Floi5I0l6bYeBxRSU4/yK?=
 =?us-ascii?Q?b/qd0dT68NU32TtQGOoahfPqRaZ0kqtwJrCwW1l+i4DtOqm8GznRNv1o0OE2?=
 =?us-ascii?Q?G1Kz7oawSdbYObYrguy4FuGp+hKpwe2Kb81ovkFRxGLk+pTNIalTlCtd6Lol?=
 =?us-ascii?Q?FnOLPwzjlZaZNxANcb2wIJzUZQt6t0KCgA7RQBmfFz5Q6Jx1WjwWwKlttVIl?=
 =?us-ascii?Q?4vLZaYjxAuTsjb3Is134EMRd0fQgjxzeoKicigyiY23nAgF4zPACLhlVMpDH?=
 =?us-ascii?Q?JASzsk3sbCDu0kbxr8RR8gOUBN30bArxkBEfTWV9qggKWu/cLKbOKLOR2Xmv?=
 =?us-ascii?Q?blBD8ftMFOg0DxDVCkCPBpbAgO1Qx6QK4m49yPvvIRaY5Rgq0cSVUwBbB7Gj?=
 =?us-ascii?Q?n5IUbI9FRY81EWcE5RyGSbPIKDfIniaHNg5e6+aTf62c3r4o1fwZM2uBp7qh?=
 =?us-ascii?Q?K0pxfcinFW+OdNssl5AqxgFBjG89sg9BlvroI26iBWmy0beTF0IRLw0cjrMv?=
 =?us-ascii?Q?Hz8WDdTxLg44yZf+0OjyZ17zTuRTLuaHBcyvZX3Srglx+JmXrD/TJMj3VOD5?=
 =?us-ascii?Q?gduG27RsmWlPDy8a02VMtGhTuIzDtyYSdCjH3pjhRCEcxdPg+qH1V8Yb1AXU?=
 =?us-ascii?Q?lPTkfqtgpsPjlsDiopmwShljOE+8/xzBv2PIbHmb7J5IPQl0kx5o+nKAQEmu?=
 =?us-ascii?Q?XckHuOM4WD2hK6wcYNibG7I6AB1e8GcmrAzyChkK6Ut3if4RfzEG01a4J50c?=
 =?us-ascii?Q?hjO0dNtdkRbxPHft+HxZPllyzi9VuQRGKPRFX5j/P3gNjpq7HXcbjYr1I4wO?=
 =?us-ascii?Q?qeCzkWgfrtAgr6VWSsxooghUqqZ4f5oofaW1kYjMQ45JAMUOftanpksM+p70?=
 =?us-ascii?Q?K0beaCDq8b6sbmYZOHFMvyh+PxBNEakv6ijDXKkJ0Rh+jlUnjVf0llq+epSf?=
 =?us-ascii?Q?UC5lvkD6hKC1FpsWnzO2nJqQz6iQfTFfMzp/vqxeXeA5l2PpKK1q8hGP0LRe?=
 =?us-ascii?Q?eff720A7TefeaXW7rhvMmBVfBd65GvtcTZGwymMqa044SO8gNp06qw2LIxCN?=
 =?us-ascii?Q?Jg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ef0ec5-0bc3-4622-9750-08de0fd1bf69
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 12:11:06.9021 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQp6lIClzXzApivWX4PqBGJ/bjPEGAEjya4YeTv/2PL+vOTQuWTMNG4iiRVWvGD44t/E3YFxu7rRKuI2cBdD5CmCDMYFlTwUgL9ebukEZ9o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5924
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

Implement a "part name" subcommand, mirroring the existing "part
number" subcommand.

In the discussion for v1 of that, it came up that there's a bit of
inconsistency in how much and what one can assume to be initialized in
'struct disk_partition' after a successful call of one of the
get_info* family of functions. The new patch 1/2 tries to consolidate
that by making sure all ->get_info invocations go through a common
helper that at least always initializes the string members.

Rasmus Villemoes (2):
  disk/part.c: ensure strings in struct disk_partition are valid after
    successful get_info
  cmd/part.c: implement "part name" subcommand

 cmd/gpt.c              |  4 +--
 cmd/part.c             | 16 ++++++++++-
 disk/part.c            | 62 ++++++++++++++++++++++++------------------
 doc/usage/cmd/part.rst | 13 +++++++++
 include/part.h         | 16 +++++++++++
 5 files changed, 81 insertions(+), 30 deletions(-)

-- 
2.51.0

