Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161BFFED2FD
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 10:01:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96AC884166;
	Thu, 12 Mar 2026 11:01:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="akL9RwK7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF642841CF; Thu, 12 Mar 2026 11:01:18 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E15CD83F2A
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 11:01:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w0URXVgGDJbtDsKOBW04Z1icgFs+Cx4a8znSalW5g2luF5KnxOtmnV3QTuM/SeiCwZHUFnf2mzrmOnkZFZxvcy6vlN/weB/4SOC0Ie3KZODcf+zpm/TBcjtw3zQKzrnQfOkZbwg9BlUPBVPDIUIdwp9e1M3LNHwljYykrBzG1ef0zdN5+VMPOR+xcJt3la/BXSHmkDuT5y6CpagHupBDl17PbatCUvYGrnNkijZY2d0ofkql9GrXMx9fvzvD6mTI2DxkGQdyz+UjnDqAz0qnBY9S+XM/gPBU9nzY+OwdCPBrCE4KOl5AtbZtQm3/9tjYsyXHAOupjZQ8a4yTJJWdgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNzzjA4ClPp5y5Q4NuUrnX+wbr8zKn626BRwELsPnRM=;
 b=Y6VWIfArVrSyZLbgUDBnbe2IJk0YGOOktNplhxyXbCHhsPDpdrZzZ2K05G4+oA++1Oph+QJxxFUnvV4xp2mN53zaAU2VWOiRLKGPAplCRy7jppr48qsfExYokOWsX4ZqT0RV9mNrlqkEunXT2OVoisH3oaWVx6As9Loj+tyB7LfFiJ8GfZGFMKEEaMJ6uye5e7dhhQj6U0yat4gSwT3pIYzCV5D1rkw5efnNlq2cAZitCEJqPErW05UsHaLU2o6qqktGOgD5fFL0h6GpH7kDtWVRzI4Mu2sm3AYJv3jfE/GpRdxK/Poe6SVPbM+1anHnGVAyRcdpp8fVZmzcDTVmrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNzzjA4ClPp5y5Q4NuUrnX+wbr8zKn626BRwELsPnRM=;
 b=akL9RwK7RZs06H6VnV1JXooD5OBQRxfJxs7lsuG8NrK5R/Vx7BcPzlYTLj8KHceIA+KKKXeLSzJTfVuKflBn4/TUlnUMeZ8OfHExlbLP/VN+GEPhtpEZG323EvJl+27dy45LdCoF+GBpO5eo/pMPVhfuR0WjsUG3qSZjx6G1qac=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by GV2PR10MB6694.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 10:01:14 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9700.013; Thu, 12 Mar 2026
 10:01:14 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 2/4] doc: test: document [ ] spelling of test
Date: Thu, 12 Mar 2026 11:01:04 +0100
Message-ID: <20260312100106.702368-3-ravi@prevas.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312100106.702368-1-ravi@prevas.dk>
References: <20260312100106.702368-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPAP307CA0006.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:3::14) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|GV2PR10MB6694:EE_
X-MS-Office365-Filtering-Correlation-Id: 5db00dea-d73a-43a8-5b4f-08de801e4bbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: VkE9eTvnzk8AFp/u51hC0sBOu18siO7USwpAp4GaC/RetWGj3yaX894lQzuD0dqQBj7tAHgZyjslfqpHCkhXbCcqCj+OPWqPcZlyM9y3IYypmmSRKzRnt24Fk2m9gG4iJlIWfhPNJon9D5fCcuClvn0MulDdFEoWexH4qJ6xuQKsgNKb0pIM8N+BEH9/akiVq4DyE3eieEKbF7eCXpcD9MlNhviVDdluIUFhuCXKux/z1PgHndl8+kDIaSWy8IQf4LLDxU8/dTDFLObU5i+H6OewDRXTcQsQtDRuWPBxeen2R/t8n1JrmSHTJVy1x/ZVZN1F+wEbGyY/N6aNcXZe9ikJNSWvuQFtYAIiJUgMAwTdD3ZUX7dgs/8g7POytDe23ltW6c1MPr/H1j1dL4eSGWvbcqWn3KBeJrEP4C2i1q0aAP500xZ7ldd4+rxQiRmXJKzMMZKvWgW5KH35c/Knf4T9PCs3F0ZFIJsOhVX0ea+kZ5nCJQcUeWwrZIcCkie8c81gLXjBk2/Aoa4JTtKCaYH9GSyRyTyTtSQpONrTsS2Op3sYNifTZFutxE20w0HzPMZS6GBvngVoYAfVGw332F2oaUn/7u0AjiPWx6bf1UzRv6h13JKaCghA5NGBNGX9IRmRLzLKtCYAa30AeMbWMw7UuSOAp4m/mD0olp2TwxmNI0D5DWWxJamLoZviBvTs5CJn9xg9tbA6MajNfXG/PS1WvyAAS8oRNMKRVwn0uqx0/Vw8Pb1pdl141gY0zMafGSyx4VKvXxKSS832zBKagEy4YOebS77l5yAkZPFkKJs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vgYkCjEvwSLDiohb39+2CzkI5dR4zw5OxnqYeB3j1TMJfNY4TnKAdPIHFjPl?=
 =?us-ascii?Q?FfXZsP7Ewu9Im0mC0GOVDO5zlU6w/22otZHy3hblvIaUqLKcEa4rdhFbzitK?=
 =?us-ascii?Q?qidzASBLXNp5fLWrFYZATsDZmNkJ6w0EynIsRitsPEgqPWl5UKtqCPn2oF6n?=
 =?us-ascii?Q?m+R6unJpYLPYg04057Vb3/viRniQsOFbL1nGwSdvK5RLDZUUSE85h5f3lnDt?=
 =?us-ascii?Q?6Zb34vVEplPRAZRuUlaty3FvYPKlpYe5cAs4wW8TePhZ7DLKJEJXMvSb/sKC?=
 =?us-ascii?Q?ZQi8XUc2L6xVDpNNMd3FAzpJl2bqo+DVlMYOFzCdAR5MSYlHs8GGViXfI/sR?=
 =?us-ascii?Q?09K9zB2FGkkOXjkKUGYnTrVr6ZtuPzpSRwEjYbIBnziQBEmPzzheFO1LpnFN?=
 =?us-ascii?Q?bC9cfSZ8RcG6D4wkTS1Ks8n+KrSjMEtQROR+gk7gzDqjdORQMuvq0fp7OCzC?=
 =?us-ascii?Q?wDwJ0xmPORnwoCvOMiwZPMHgjjDbx0pBLvs4y3F1mwgMV6tL6DUGjJEJLJa6?=
 =?us-ascii?Q?R5FU5UFhI3IVCmblRDUJJfPwP/OjZxwpoW8I1m35mjhSwUg06SQ8CCKuH+4z?=
 =?us-ascii?Q?s6euTNM921dFJYhHy1vWrL6G/GOMoay+hXJz9TNN9Bb8r6m4GPHuebKGeXyV?=
 =?us-ascii?Q?01prwCEjazTlGodVRHP8wuOtMmKuFy+qBAVzFVnIsnCFxlXtu18GXp+Baqvv?=
 =?us-ascii?Q?AhmfBLWIKOIQVDerZmJTNzhRv8w2shV7OD/5vFITpiHMyQ+Aou1jUoF+UO+S?=
 =?us-ascii?Q?0V8TRv3XspuCRV3V0R+rNkyAizF81Vc7O3dhx4ZgU/XA3ZzMzUmpR5V5zTeC?=
 =?us-ascii?Q?g0TOLmgvQxIJuvmPfT0rxPi7Z3f2AI8RXMnQE0HzQeQSurCEIq0CepHITaMT?=
 =?us-ascii?Q?2pjOFYMs5fnHjzDbb1PluCKlEGy6isI6NEHrGSvBDGG3oKbqUzGdQxDvGAqy?=
 =?us-ascii?Q?OrFcLZTYstGRBqf0MjYTianaaffhDUNfsFDKo6hINZmvoNVb3Q8kJzP2hJgf?=
 =?us-ascii?Q?dgh6j9vYApUmHTcAi4YWEakSL4avVYCm/XkBWl5Fpa7XiXvPDdtpC4tygXkS?=
 =?us-ascii?Q?LBvlMZlvndGWa7R6nCuZra6/8toq/vBtIy2cYe4ol1KCg1H5phMeL0RWQfSj?=
 =?us-ascii?Q?zPoszRwUovFlJBCf9mWMua2q6hTlVfrJLjjBBfiW/J/21jn0cL+s90R3c5RY?=
 =?us-ascii?Q?ZE2B2nSZO3Zc/otfzllLM98afKf4jlI7OyEMbSJ/5rrE81XEcNuvbmtJ1EE4?=
 =?us-ascii?Q?ko2ZBA7Z9fP+xJiG5n8WvO3SmAL++s+kNr5gsAMHJnYFc9Sa6C/GBhdcKSpZ?=
 =?us-ascii?Q?bOEkSlRqIhekzYDiWrqehTzfMY7UxMPWFYGXan1hX9t4AlYlPv2iwyvko7VT?=
 =?us-ascii?Q?Tp8bdHLd6zHQAd4ejgJedm64VpCLSGcNqrUktOg6Lr7LrBCQ9T6bsTCqExrg?=
 =?us-ascii?Q?p24bvoZwRWfrCJlnE9c9mQOtHcFHY73guAXLchsY2zEunD/70Zi/1dTCC3Qp?=
 =?us-ascii?Q?xN+IVQcYxtStIqbEVVTQl/4vbvGdLB/wEUuOZuoAt1s38hXVdc7VzryH3p5u?=
 =?us-ascii?Q?oHtn6bXEANCLxBDoFt7R7vPS4sO4DLLWcHfGqpG4+ZpJWlSCwXjlrh1y2eLW?=
 =?us-ascii?Q?4aVU/jJ9IKkyZNvwm32WkXPPtKQUWBHVw1zLHvbQmnGJ1c66dUR/DhqkTuoX?=
 =?us-ascii?Q?V8t81n1F9v9sP4VWcdY2Tf6T5qNOmWpbCiGbIPVLcnukM+CIGd0Ea7vpEFul?=
 =?us-ascii?Q?1KZxhoBh4fGacwBW1XcIh9uUiyo+7IU=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db00dea-d73a-43a8-5b4f-08de801e4bbe
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 10:01:14.2906 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W+GYcEdW33/2gi2AcRla3C0fYYSMILsnIAhzvUAbzsKrKGQu1C3ceRzMc4X2Ah4dNIac/J43ho9fi8DNJTJgkskOHSJsWPyOTOn99W6pv/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6694
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

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 doc/usage/cmd/test.rst | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/doc/usage/cmd/test.rst b/doc/usage/cmd/test.rst
index d1379117fca..037a9ee1774 100644
--- a/doc/usage/cmd/test.rst
+++ b/doc/usage/cmd/test.rst
@@ -20,11 +20,14 @@ Synopsis
     test -e <interface> <dev[:part]> <path>
     test <s> =~ <re>
 
+    [ <test expression> ]
+
 Description
 -----------
 
 The ``test`` command is similar to the ordinary shell built-in by the
-same name. Unlike in ordinary shells, it cannot be spelled ``[``.
+same name. Like in ordinary shells, it can also be spelled ``[``,
+provided the test expression is followed by a separate ``]`` argument.
 
 Strings
 ~~~~~~~
-- 
2.53.0

