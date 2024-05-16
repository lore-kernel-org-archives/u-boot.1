Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF75C25B79
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 07:53:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B193880A8;
	Thu, 16 May 2024 09:53:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="WZbUd26t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C16A88077; Thu, 16 May 2024 09:53:32 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0183F87FC7
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 09:53:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rxpj7V0u0XKVGKZg92xeo1JUkj0fOiQBkeL+1s0PWassGYk7vMLaWIL+phC/1cFC+4GgQnYrxVMUEkoZazqfV7ffWJO7yMgfyohL3b0kKSdJtwx5Y8cNkcKzOPGq7u1v/1pm6OIxrPKst9+dfYlmqRQ83wMQL34Y34HFwNV9W9ZHFHEy3IFysInC6IwO5T+ocFmhqh1IBSkLRXujhdVi5t05X2c382pz3xIoODVowKboug8uY9faOSEdeuCeInxa7bglSHmUbZFeB+1KBWKhxOtmwJ9FULoEMjw3ythfMibwMV1n7YUYDLdOzhhOSGqAdUJRraVzj6k4SQxtFod5IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=csRG/LZba/k8hkj0Or2zBknlhFxR3QuScGIxG5lu5nk=;
 b=Lc+aaaDzrcit5LIRIYAnf8bvYn0KcqTxebKZNqgE2Gtf0vy2xVUhcl2tYGgMU0EkRGe5ySlmIEtyvzoEXZCgSJZfL+B4IZ0SeD+Z0MMPy1v34RhumdYpSzjS2sm8lblL/8SUoWKIuhGl2LatKb8v27E9B2zwMpG3knSpECfAEddp4rSnx8PpBJBltAp7K2Vxbzscd6zg3n67uyR3YDBDmJsfbOHeMKfb7M9hnT2+X64BVSOJZAA98fNtNxOnu4dfBi2o4u5AFlfvcCXE+qx7MMgfPW512dGxL5AwmBdFcntaK4H9JHy8jkvlKBM7qMFjUQWut2AZD8D0nbj1bC3fuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csRG/LZba/k8hkj0Or2zBknlhFxR3QuScGIxG5lu5nk=;
 b=WZbUd26tKGDwpvzP4zm11Pzbd2HDJIVmv8h/KiHJrxdOtuYUPRikRvo3MSv/fWp4bnnbqM+EYvdBpEsi3gQrGMdXsp2CZqD/QF99F+pNc4ZdjuSfDNP/ywtkTCDZ2K7DKDNsl3VLPwgRiJGiU5sOm7qQdRSFsvMEbTIzJF4TQvM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS2PR10MB6752.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5e7::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Thu, 16 May
 2024 07:53:26 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7544.052; Thu, 16 May 2024
 07:53:25 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v2 0/3] cyclic/watchdog patches
Date: Thu, 16 May 2024 09:53:11 +0200
Message-Id: <20240516075314.1548051-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0008.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::30) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS2PR10MB6752:EE_
X-MS-Office365-Filtering-Correlation-Id: e81ad307-238f-443b-5c0f-08dc757d444d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|366007|1800799015|376005|52116005|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rMw6GztrycBCop1CAdGjY1cLkxxAjdMEL5iXicAB3JScRjsTcehzkbESkxkx?=
 =?us-ascii?Q?UzUm7OMd+H9HpEUX3aQ9IDxPEOqVOyZVD3ffj21kQXrDu6W8qf993R2Pd4em?=
 =?us-ascii?Q?iw6/W0a4cMxioUfKegAMdFj4eRScLJ3RmyerQoyjdPeBIUqvzIaDDOi16Vp2?=
 =?us-ascii?Q?1uFEPI/9ytVcQ9wZElhVOy3J5AdXKnIE7gFdl2r33UPnxOEOpmXUASXoc0ce?=
 =?us-ascii?Q?THGutQJnxkUwDpSSDw+VPVuDKjjXXXkgjwda7zopbHKfuIXHzLTjhuFQMQKC?=
 =?us-ascii?Q?XyfVJuHMUM9Ajyq69Md3G/j0ovj61eCUxR1536Rytf7VmF2AdF7WbtrmSEz5?=
 =?us-ascii?Q?lccZRZMe7h+UivR2ttTetjDcsfu53CggmTO/e7+QnQBvs7teKA8bTFtGbZEi?=
 =?us-ascii?Q?CQLzVYhTfiUN5YpLsrsP9CCG9cScXw0tsEmPJOS2urvy7lV+wNiTKOiQxxcv?=
 =?us-ascii?Q?r20S1/QYqERhtbP3JYbeaYF4RwPfrsOQbmXw2WBNJEZsoHaqKKYwuZGQhv66?=
 =?us-ascii?Q?QsPs24hyl+KvymvPCgwccwhpt6nyQtHulrrl/nBR9GAZmknCP1Rrt8DVFm1o?=
 =?us-ascii?Q?83bO71ONlVO8l7yvGa1bYZLMMU9hgl4PZ43Sz6JwIItR0GlyHmEms9+CBUfd?=
 =?us-ascii?Q?JDsDwOgXm2klMRnyvvvjmp0hE7otsPS/CpssFuuU1u44UAZyChjR8LymoRxd?=
 =?us-ascii?Q?IRlFAwKX3UtG8Ygc4DjYz8ESwbyMPCKgShd7eD1ZVFu65NCt5R9USnWfFrR8?=
 =?us-ascii?Q?OLRHHpWeWR/8Qk3r4aRmiw/ptL5iua4V8UWpiupqPtnGbdrpJU4Y6nEcGRXF?=
 =?us-ascii?Q?KtGfwQcskNugeJBoap2AP/6o5K3L7UawAKJuluHwOdSv8IzfE/xXG404kRv4?=
 =?us-ascii?Q?wWJhzmN26xW8JdXazJElvP5siUQvqDscQH0s/tRATkzkZ+hoeo3YBk4Hd2Uw?=
 =?us-ascii?Q?ctndVt4RfLXust/6N/x/XbzQHZ0A9JZSiAnXqixYFlu2Smswj+HlDRxLXa7i?=
 =?us-ascii?Q?dIYgSYBMoWNfvIeXtgEfJdCpBXW4MObOJ+gxgfwsxQJRXUwqXWfQaXRKn1cJ?=
 =?us-ascii?Q?NEFmN4oI6Ovf1yLD5H+X0OKODxVip2lPZNVRGd3pf/EEgvETfqvg8fmKsPlg?=
 =?us-ascii?Q?+bpWz/RY3AEgzZwDHzpN8cgDrawhQBc0ogZuYykSGjYJIgjoiZMIBDB/xToO?=
 =?us-ascii?Q?HGaYdFJJ5E/t41EZBrSJwWgjSDDarrq3jAT9xcai+WB94jLh9z5oGY9doZqU?=
 =?us-ascii?Q?Tmz8BqtEpLNLPXvnEnVQLogqg1zpEkNtBUlSfampzw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(52116005)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K0tzanZQFF4KLlpbVejCmLBzXH2NLXE1cFldjE9oH07cpEKuS37iZS9kDeyW?=
 =?us-ascii?Q?m7FbFBvWSggYAmZqN7tJBOf6vkS3s1sUzSg//xQRZd86QIK67kcW1dPwdFfy?=
 =?us-ascii?Q?SXG2vD8vPxO0h+CUp/MscmsNEl5ieUzwh0B2uEJNX2mFFyv/RthhDu93CNEu?=
 =?us-ascii?Q?CuxbSAR/6NvSAPm3A8yyyUAG1eNQT2REhsuljTo1Wil72cHEnFdv9CKq13MJ?=
 =?us-ascii?Q?k8nqo+lIErvIxmb+nYIVhdvzaQBRFXjdZjXh2Ggss+htY0BshXpDOjDYIAbC?=
 =?us-ascii?Q?Mct68aNSoxUlZDbI/7uyqsuazb5j+dJmtCvSKkHe6RiZRJOdaIgx5ALgHpWw?=
 =?us-ascii?Q?wbRM8wPLI6Hb2xZN9LQYxlVKfInRf2q9YyT0lVz6FTf2QNCe9CdhMdEN7KJ9?=
 =?us-ascii?Q?xSe6heDtA8O2tQhiZZ01UUFd7Q4lOXp8YK9InCGZn7FQbXDnsvI2HSM0tgoX?=
 =?us-ascii?Q?zGK6/f9LBcYO7KRb5txZhJqmDP57ByuyqKoDgJxyiS/3ZLLkjRkFHNALzJG7?=
 =?us-ascii?Q?vtAwOwCCDWDZjQddGHE9OPS+h2yyo/OksGE9h4T2purAEDVDcDg3yABjSm5/?=
 =?us-ascii?Q?dx/Q+MzX0y5KHdJfco08cWuMl0GwD26LBpV4AvOyCfW1uUBoGk5/XM2JLQDI?=
 =?us-ascii?Q?zkWRAkvg/wDAKvVNYqw6ubsAlF1XmzGIWtfG1/d6h6LmWjGtpqajWTiQc0AH?=
 =?us-ascii?Q?B/6YWcuxoVlmb1ZLHZDP/o/x0Zka2YCTaPp+39wDrrK3KO2HYJe0hkgS1fp0?=
 =?us-ascii?Q?Gk9QEO+gB8GHmJyD2VeYNfNKJwS0fK+HAyIJC0AtQ4mfHjqYuhMghMZzeen+?=
 =?us-ascii?Q?TBxZcbxMS2xUcPNQRhadXWc0oyalr61nfEX19gfEDOXfdBNfmydotVH1pJtd?=
 =?us-ascii?Q?k440N6Cq2aI8zLdHLznnvdGSWipTkdnjLrrbxWxzdhyAcFlSTsdarRCEUPeX?=
 =?us-ascii?Q?92s0HBgR1G5jF2tY/UJz0OBSDzwuRaTnJq0QRdeyOp7yIj2vsGiukYzwwxTA?=
 =?us-ascii?Q?ab4EAQC5WHcSoJPA3H5q1rzjJbdgjWxbICzBZM73SLLH9FCCdNLMwayi0XNr?=
 =?us-ascii?Q?qT+QqmIzRr2wkpN8mEsL4KST8+hl5QEQ9y/7yW+ZeZOqvhzjJELkU+cOH0mJ?=
 =?us-ascii?Q?lSCrxXVYGWOM57KSb2CLWOZZqJg4lOFgRpXSnV1awWAdN6XJ0tARS85B6RrJ?=
 =?us-ascii?Q?VwaRIBGaZAYt/8GHPISsvFaRjjd92oDLm0cLX9kLW/+sq8z3PwML2T7X/vSA?=
 =?us-ascii?Q?9MbScr5NBLaJvsEN12RFGpuJAQQMemcRVdoig4iAPlqPvi8ttntJoobKZ4hZ?=
 =?us-ascii?Q?dSLC4mM0dx1Atia+YAyx/gOcvqtjoAXJCKuNzP2fDo9nxxNB49hiHMg06i7t?=
 =?us-ascii?Q?Wk4bylEW6lA7UujHXUf33jScop2U+xrxzzkuU7qEqGKjK2ZkKm121n6vIvwY?=
 =?us-ascii?Q?f7F7kixRg/TfJpXDlmEsO4Rm9FHKLiEsK8z0WDVg+96vmv11T7b6IgXSNo6l?=
 =?us-ascii?Q?ga5Kug7cBn89OMEGJHYNEeGs7MQC7IyxtlFCLkE162e9Yw2w9Ig/7arU29pK?=
 =?us-ascii?Q?BhTn8ZXy4gYpdaqgVk9L5n3meBXKBV8DoMoQm30qZ36H52VyfpLjayKmEbI6?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: e81ad307-238f-443b-5c0f-08dc757d444d
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 07:53:25.8760 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: snT6gGsWX9gK4HQFmKSoUPF+CQmyFTrO9X29KqVLXRyGYaPWdr0GGxGC/5pySh+FlUD605jLQgWMaCS86W8hFHrO89cYGk685AEuIdlaopE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6752
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

For now only compile-tested.

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
 include/cyclic.h                   | 36 ++++++++++++++--------------
 6 files changed, 71 insertions(+), 74 deletions(-)

-- 
2.40.1.1.g1c60b9335d

