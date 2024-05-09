Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8655C25B4F
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 00:47:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5EA788463;
	Thu,  9 May 2024 02:47:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="IFlCOqpm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A83568842F; Thu,  9 May 2024 02:47:29 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2611::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7E37882CE
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 02:47:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbdHQn5K4AcVMF6xvhlteJeSbogBbRoVjawDqd9HWHdIkBFaUpGP9FS7Zpgac4zd3ppApi3swBxmUOiXT5dJoIEAF0MNmKyPMBo9Y4Bgw7PlpE1Nc785ht+KX7Vg4CjsGhJSTVfNPV142Hq2jgxt7zKbn99Dqg+/mIekoGPXz+en9m6aAs3mcqmci5eP34amI0BBdu5FdyGIbUAOZLniQUJ4qr41EvAZj5nG/RAQRL/tfYlPDLrAOY3soh8K9HTVU7k9zK2xpJsvwJRZytchWdjDJa69IWI8w1E1iPZyTNDkeO4RkHaLL7H43tUqJ28CVsKe3CNL6l8RdHpSFml6mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBC2EAIDv1668ntQvEBHEFbYqMrWVJudeaxYnjJbNK0=;
 b=I27QGf8ko+98uCQHdnaIvWaznMRsgDchtQt6GGq4IVrELOVzUGuk6u5D8x4t+bpQ6AYltkEVi1YLnnBoQDOqX/yi5/MPFc25IVrnAAnZz9884E+DBcvYYFayYDgRs7T3F+3BGPo0gbzEiJlNeAuZGkkrtuLaYWRFEKV4PRR+M1fW3hqL3o+9Fq6SOrv7WmuPNKLLXd29pPsVbyI4QJpdqc1KvKG2PqDA5FsvzncC0+P5/EGGI/kDGfN3JHaWoT30EkOYxIt740KkeCjzWr8Vyg+5x5KCYwzrWKWA8+0UfQA8KJw7baVrU8ImGonkqmsgEawGc5rFG+EtbBCxickaRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBC2EAIDv1668ntQvEBHEFbYqMrWVJudeaxYnjJbNK0=;
 b=IFlCOqpm32ek5IV7Xp8nhu8I4k54Cf2MmDeF0S85pEbRe1m7v/CKw5w0pKXa3rwlskhfqSriBRXX4y0SCMpTh0Ha5NzbHsFaDc1RqhWCGaXxSCQHrORDmioj/YCDXFdnYYcZQ1RqXdseho/a/gIY5UtPug3NhsDt+Gepiga87hk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS4PR10MB6063.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:582::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 00:47:23 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7544.041; Thu, 9 May 2024
 00:47:22 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 0/3] cyclic/watchdog patches
Date: Thu,  9 May 2024 02:47:11 +0200
Message-Id: <20240509004714.1394547-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0105.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::14) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS4PR10MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: b78f1d65-8f69-492e-a097-08dc6fc196b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|366007|376005|52116005|1800799015|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lqcovfMUnEeEMXGDKtp94n9Gzej170LLAVgbZv3DYQtj8M/5EjojhqfUlXqD?=
 =?us-ascii?Q?G5gsx7ETAPgvmUEqk+aAfE/4WqDzE6L1UTQMAGXAMpCwE1LMP0oOoSTXfJHj?=
 =?us-ascii?Q?kF3qZtBI48y9GDHvz5wZGadkeJCgVToXka0JQ/TAooHy6P2/lUeGeyz1LYNh?=
 =?us-ascii?Q?PNq+bTZCvTwhjQsd8eTJVA6aGG0wbYXJvB7eycxx8bn2j0k2DgJ7vacABxNW?=
 =?us-ascii?Q?BC8C62LlMDZKBZhuOyhnEim6OeAlMNRUd4c202qSOUT5GXr1H1jUiYlOpP1p?=
 =?us-ascii?Q?sGgCsdS8OW8FJ/ivwRFgA5eU3lArbi0zis0IaHnvbeVfwbuAAhj4KmJVkgjM?=
 =?us-ascii?Q?doBRQVYVEqONzHoILNA90A2GV3mnKhnUr/hyHWEws8t93j7rawRIEyGH132d?=
 =?us-ascii?Q?KEX9EaHq6FBY5EOoe6X8sk0krJ0vmSCzeY90HAjsWItwBrcAgbdC78zHiiYp?=
 =?us-ascii?Q?Z9IebD8zn0kSB3FAVK8juwi1kN7ZGmma1xuMm7jYbjG4o/kdO/A/Lye2Kujy?=
 =?us-ascii?Q?WxDvbATT9Ga4g7ZsGuoVnYP41jrfH+oUxiON989t9kvNEM3wlsfHW3Ad3UXb?=
 =?us-ascii?Q?XDkH7Tg1mGK0GhyPt5snbPjbvgWFJUW8A0fsQExk4lRNbw9rVjeSNffJLI6S?=
 =?us-ascii?Q?TzUJlPJUz95vyqC/Ac41Z18LvOLfIWfz7w3hOz3iw23na9+8RpaInotdZxrM?=
 =?us-ascii?Q?SSqzcNqQhf90FB4Aj8DLWidB5BAntOjcUL2rGBKfyyy/e7j7PMjHU0AglvU9?=
 =?us-ascii?Q?4rohoctx9TUoWp49I98IHFrzufBVbd9ZIWaSuOgTn8mwm/kHzPnJmCELhhJq?=
 =?us-ascii?Q?4ss3fVnZ4lxRvBOUVEpxtslwwbyJH3/cHrzgDJO9vNFU5LkogCatgbF4wq1L?=
 =?us-ascii?Q?HI08cR/t8akZMjrESf04MFWphh135Ees8qYx9S7IKOORCj0A7dbsvYXVQ9IX?=
 =?us-ascii?Q?8/Svhyp8h38P1Sqa1qBJ1xg256r+xuxtF9vIvcxAQ/kYlRWH9Gdqd4+GlaM9?=
 =?us-ascii?Q?Ac/EvMkAtCzFg/79JDWqeJMUf66qAvAIKS7jEJceu6w6MwVEY6mxdbA9C3Vj?=
 =?us-ascii?Q?KE8nOl7USSm4M/iqOUP7oMho20BXwJv636k7g6TI2Pz1M+UISIQnsor3ahcZ?=
 =?us-ascii?Q?FLk/21kHSKq0fqbwfScEDKRJAWOK3rVf9Dh1lKfInTKAw05/m7BvQGAl/hjt?=
 =?us-ascii?Q?AlBlM1w3y5qpoC+OqXhE9ithhB/qRYkgRKVS1c8DkpTdeCIS5KNu5Wjc22UV?=
 =?us-ascii?Q?4lckVKCK4n3Qpqq1gfN7X0MXwoGvWp/epDFaYHj/LQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sHnpfVzmrDTchMSP3ayOBjx0ivjwTmGhJuV3qsk6R1Pj901kwVFuJHsacrTk?=
 =?us-ascii?Q?I2acdA6p0hIpj0paH6e4sUY2Abhuc4Z+B6UyW4/w8VNh108QpIJkke/5GlzD?=
 =?us-ascii?Q?CT1mcFG5eB9ZgQKb6ax47N0qKUT55cJ9CVzhvzPPtiRBhOzICTLkR7Cmm0td?=
 =?us-ascii?Q?kpLbCDDb9iOwGF0r+I9PAadn7SRK68ikdMp4NyLQc2fu3VKbuoO6fCqA2w1e?=
 =?us-ascii?Q?K/vrv5eEwMcYHEfpJLlkOi8nSh3Tu0uB/07aWB6nitD9I681s9riznI3/4tk?=
 =?us-ascii?Q?oTuZ+G01Ts/WqDa4LChw3HTfPg5JE/eBl+wdTljqWYNJwZDu+ASW0PLPyai/?=
 =?us-ascii?Q?wZcCHxbDUa7vVhXrUOT48cLB0+QzD3Pi0+S8m3B6TQQGwipgb6/yEAiEfIwC?=
 =?us-ascii?Q?50mgZEX9+qW3W+IN/tmnTEyaGjLduSqFfP7uyUR6UbokpilIPOOvnrfipR3J?=
 =?us-ascii?Q?ygyVMSR+WzVtF8uOJr0eDuy+E92sttpVAIQY3IVZ8JupC+oRff2upoiVnJ5J?=
 =?us-ascii?Q?VgT2/BQwnNlj0DH1nNdJcegWCwoa2HdcOY+zRTSZuOvWCBu3dq6OG9Quw2K/?=
 =?us-ascii?Q?hscG/NQ5WLb+ZVqSy87z5QfAOyaBwwRPqdOCMabm01HbRvwQJtZ/dKWjuXi1?=
 =?us-ascii?Q?h9SRlgfWo+MiNfCkwt9pGoNivp9ZGGQXHltdNtFZpo52cId3ZCrfa7Nbbcfb?=
 =?us-ascii?Q?PSyiYn7iKjLHBDmgC0A3GuC3UXfM/B+BlNzMhIKeLppSBEBkHTy0EcZ9wh2H?=
 =?us-ascii?Q?WWWu7/UyCKFvuIANlNrHYU1XWBhOxKrxYvHmZJjETpeCdsTkMN4tMCZX+XXg?=
 =?us-ascii?Q?7mRGe7Ch+vlLKiaO021e352IdIcMu0e9x9Fr0/yrlErjd7tqaLN6il2dhBko?=
 =?us-ascii?Q?FRVvgOiTJnKL5l1eozhj1VpqBLI6j1fVR4W2IwXCHVESTFRgChNVsv2JTyLV?=
 =?us-ascii?Q?ovreoyRV2Fkn2GBVsDkXhP4XoJ2+J40Ls1sqiZ5WqzCoIXPIwQSXhUoRFcfO?=
 =?us-ascii?Q?IYOSEJQ6t2MZ5tGiFBeBnoU+k32mRzlBhryQyVPIXkY/zbQv/SaC2nt2JHMY?=
 =?us-ascii?Q?oah31qjGIsFOkUZnzGOGyNpeKbAm9JrDmNpxSiO6LRWYnrek4K88+BcADZ8Y?=
 =?us-ascii?Q?Vls4lPZDa5S4I/2WXCEJqxcd2SXImWAI6+GcTaoHAh4zNalxpsq7lrCkI5oB?=
 =?us-ascii?Q?Cq4RuMsk6LCsqWunCljkz3FRdkWN/Dz9CK+LVd71r39ACi8+csm69XqawERk?=
 =?us-ascii?Q?YcPxgUpaq9yJQuJRxb7JmOaFc960UEssRvwnNYIG0somdNabVZhC1Bem1yjs?=
 =?us-ascii?Q?XBbthvYcM4llPx6pJZUjSfXLg5Qfqnz7Dp/4keX+YPUHVA3F4ebAZ6wlNIRl?=
 =?us-ascii?Q?hBnRY2KqXrY6yHMzYz395R5zZ+imqs6XRhnskkwlH/BEGxSeIvc+hKu0332U?=
 =?us-ascii?Q?J6Zh5ujxdbxzEIbuj2QNL0Air12GTafRa88qlN3HIykkA5r8k/kAxv7KDsbh?=
 =?us-ascii?Q?qQplDnZfDdfdgxVjunMGmSDBHcggVxCTPr1LIEo1HOVjWekxUrJXGyXVMmrR?=
 =?us-ascii?Q?lmS9umtU5vTb+UMYsyDE+veCQ6UFHweZPZJxm6poz7iW0zUUvH+thZmbYlG9?=
 =?us-ascii?Q?kw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: b78f1d65-8f69-492e-a097-08dc6fc196b2
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 00:47:22.8803 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jhqShPskiCIeVsy/LkL4OH6GMFHsGl+Z9+RhfAOnDbiAINgMewG1P9mXH5aquXUVbAueHsGJUFPqAX9ypxD76kjTl+P7adKoLPmq6JP/+AU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6063
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

