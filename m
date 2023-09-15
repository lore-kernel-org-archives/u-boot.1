Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8802EED61E
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 17:51:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD8BF863DD;
	Fri, 15 Sep 2023 19:51:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="PDuFqChp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3261186504; Fri, 15 Sep 2023 19:51:05 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2072a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::72a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9102B864EC
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 19:51:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4DABZ4M3vyKbdqsqlnzV0ZurZsfR+hMLt+sy9ltEge7CHivaqKxYJ7ADFjNpOdb56c5cFz4ICCZDLGjhgqYkTflOxhQsK3LhbAiP3cNQWt7MfSEaS8CEtQybLNesB2lMiMgpXX/CJtiJSswUI9SHZFCHdrqiEgp8GScJv0aZMeCUwghbB+wIPkx53zWJ2PoABGBMyQqOgizhzqEOilXJlt7zy4/CKnYY97sMUI66k4YUG6QRQIk5Qnrbh8Z4owTi+EvB0s9pDnH9Ug/LyMuD1ZgKlogrLj0UZwBZInvKxW6CbsEaaXZiCds77PLtv4mHFAQNFrC1fVugkh8SSg1zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2DddT8dUFMxduwEiPvzivl7NyaIzBbHGPfhvS1xYloQ=;
 b=EbzbJoOe0Wq8mrCsTSQVxcRcOX8+D1uZcKXTDg0mXuEjp7a32wg1Yt5l+i/MOvX6s1vvfe0eJMs1KlXPCIx11EMS9ToP6WtYi41FE6NcYrsM9giHMv218pv8MxqVhKmaTXJYALYDvMjRB8ZUfWGYPgz30kjn+JQq/JToJLA/TREfCPaQi/3GgPJ0emxliuY3Ru8RvfEGsVzo4sBBCvrho4oHQbaoPKjGO9cq/OwT/Q1/NsW8novQ1bXO+SeKgA9k9jCDCG0Hf6GD2PTHGs5B2Xz4KCONa/78I6oh2Vf60wIBs7wsNFbOKfZwoYngzsjq+o+7Gi7dtuH4Lbvh5T38Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DddT8dUFMxduwEiPvzivl7NyaIzBbHGPfhvS1xYloQ=;
 b=PDuFqChprDZYzZ/iJtWtnBJeX/atB4eP3zAoiHOC37n+mmG4ab1cwflVOzqV/2OJJG1I4JunLzLKSDh9Oxr3jxPpVo3YjzQ5W4BmlxJkH95CPULm1WcdY3R/GKYe0BSnPd/FI+VVfwF6LT+aK0cY/c3Hk7iGtYVp0LfqHEhxQPU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AM0PR10MB3970.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:155::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 17:51:00 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6768.029; Fri, 15 Sep 2023
 17:51:00 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 1/2] spl: make SYS_SPL_MALLOC depend on !(SPL_STACK_R &&
 SPL_SYS_MALLOC_SIMPLE)
Date: Fri, 15 Sep 2023 19:50:49 +0200
Message-Id: <20230915175050.4109711-2-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230915175050.4109711-1-rasmus.villemoes@prevas.dk>
References: <20230915175050.4109711-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0067.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::34) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AM0PR10MB3970:EE_
X-MS-Office365-Filtering-Correlation-Id: 1566ad96-01c6-4aaa-2e14-08dbb61452b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qi0VXo604IoYFR+dBXtrFycaTvby6lTRX3vQUUKng/34waMOK0oxTXln204BlqWGs0lH0Q9h+gtD9ejiuwbw4EceAiJUH0hWBbBTuX06ALsPLJxSXK40PAT9ZnmeTcCcr6wE98+D3VB7cwSxS80sIQ0Oot6G1A4n5sMCwIMBO3YEBpWUmPh/Mj8rLc17/7eouGazJFnCa098jBINGbJzHz1XnAdJjJj50oigchmMkW8GnP70LjcTEULX2JvK6mX9DIdGGLAUdlWS88JKQIzkp8fJWJJWAK6wfrKMkEatpUQbV9WuxroA4rjTIr8p8F4iElBs75tD8vCymsbSs4c6mY1QYqZd0NlR7KsZiveMHvpbCoitMrtqJcnmjD0JRSxSX2TPYKIgTwVR9T+A60g1s2bKWA/4mz+1HkYWdYfPJPOZPqyw8/h+E1kW2q6Hy2eYS1OCu77Q5qH1XXf/3RLvcTQkQ7SYTRijflcuyQ731CHCVkYZtPu3JUVdzqEfMaqf9gckmcaDSTmpL7rAgCO6XyzyzyusAZv+oEILQqhKg9RI6smWbtWffvZzM2v6iZGczksscTLx12A+EzTNiHL0aTolPCHphWvC9rWanoq0jbzGkK5LtN3Ky2jrbQmZxVtZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(346002)(136003)(39850400004)(366004)(186009)(1800799009)(451199024)(6512007)(6486002)(6506007)(52116002)(6666004)(83380400001)(38350700002)(86362001)(38100700002)(36756003)(2616005)(107886003)(1076003)(26005)(6916009)(66946007)(66556008)(66476007)(54906003)(316002)(41300700001)(2906002)(44832011)(5660300002)(8676002)(4326008)(8976002)(8936002)(478600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?154gM/TEYb48vTJqoSEDgXGPd35tGmQHR6ZObS4lZVJjUqOCmcxWSgGoNqJR?=
 =?us-ascii?Q?WKpqrOd9EfMNYNnB8I636GJX4qLH1jvqL56Xb2tZkVYRONGpnlj9N7LPX+fO?=
 =?us-ascii?Q?4twcyksGkYjX2pznnygfPsB+yJHCv1XxQjMHGin7Gil0fFv0vxLlVXY+Pp0i?=
 =?us-ascii?Q?KQ5+BY0DYjBHrAafOdT8Bd+2xgNd6XVnKZkRg3V/l71S4y5vkVJyWa2e7Ntq?=
 =?us-ascii?Q?ZBLTt7mdElEmImVXiatkNmkIaYB3rLnq4KA+O4vAEBOaHGKq8wuVkWlizO9V?=
 =?us-ascii?Q?ftI6k2I3enSmhWtzXxl/0Xw/zvGm3KH3UUt+n3uFvSj3P/zd/Dbh0Ze/S/5V?=
 =?us-ascii?Q?HMdG97EnyyS6hYXd8wsOb4aiJBSVqYMfsFD0EtaGh5IrpLg+7p/OgK5sqrBS?=
 =?us-ascii?Q?u6vvQ05S1BkKMG6BF88gYLt6z2fr47PI2h6Iiv15eAQ2XTj3z/uRQfi6IDVZ?=
 =?us-ascii?Q?G4cF5DhC1nlgD2d4kdb/htN5gvpld1YWPimjZedOIRXnzKahUmJheiGNup3g?=
 =?us-ascii?Q?hLIGFF3wro7eVaJE3hzWePu9HLzy7yPcqCooUNNc8YtsoKbXYx7DW5Dbe9Rn?=
 =?us-ascii?Q?6OL3nYX0kCyk4FQFFlaA5L8/OusFcQmt0HWSwjruGbUD3g3M/+EGZVsTub1G?=
 =?us-ascii?Q?ygx6WIzAaqYEC5h8eiMaqV60f8I6G/TG1MeE2K/MMae2LfwJB84HqXAclB45?=
 =?us-ascii?Q?tIB9k+YgIdzfVdoy2cqvcTmfa4YFavmJUnYNIROakQ6yXZoHxW+nGFD4zH4P?=
 =?us-ascii?Q?X5+vPbIM9u5NhOEuAE1DZjrU6Nw7c9meT2lCvCTnBH1GMfK7zk/kPivp5QI5?=
 =?us-ascii?Q?+Q7Y/n2IIh9wWR9sekY9HhJCvI1BLz10m2O3RS2NajsMAHp38GAQxAXS6A9Z?=
 =?us-ascii?Q?5wA6G1M7LyAerGgi4ChgKvt7KMZa7drTmNhuBOPqTc59WBzxQ+pFJ0fIX3M0?=
 =?us-ascii?Q?gdsJszF03mgRkc9+PGpOLLPZm8pvIffNjkl9Xre6sjba50QidOWnk4jQoVAo?=
 =?us-ascii?Q?Oqn2HB5cO9BfyZj+hTNJZ/JOzwBTuEXLLFYtwV87q166dkqx7wvlyPQvJ8y+?=
 =?us-ascii?Q?vraG6/QANH1hjgQ9EOebqBWmcsju0N9q8ERZGSJ+SmtR+vca0YrifUqO7Fkf?=
 =?us-ascii?Q?fVEqi/FQpveci/Cvkb2MimSPRcpnZU8lF62LAfCYNv8hZnL6ZMB9gyu/hjUV?=
 =?us-ascii?Q?Nku0lv1BiV0X6l46RTCkxyZ9Q7sp4G0n+7yoKue4FbVUUzKMbQ6eQU2poKrN?=
 =?us-ascii?Q?pVJEM1gXMox0hj6ifXjp4nFDa4lPoSyvqIgab8+DB/6Jbc4wkqLm8pGcBs/R?=
 =?us-ascii?Q?XIHtyXCheK8zK6JGnuVZmCajvUKn1FIHmGmewQiY9Q3UsIB8WKNugEBw9EHo?=
 =?us-ascii?Q?iP6OoFLLn5pbeSwQjFkbARZMf9LrxhVRqdwuycBSEnwqhQ8A214pwh4FaURv?=
 =?us-ascii?Q?y8qMx13ci8jrof0yL1+bUbRohBSXVDvlKBaShjuqoSjfn8oD0oBkekMs0Hym?=
 =?us-ascii?Q?ukD5IMlEibMfs7j71y0akNrsmUmR44UOYmlDAYPImYLScFoFY1eUuuvemP/5?=
 =?us-ascii?Q?6lRHKV1u919FfoS7uVfMh3nF3HZEIKUlREPu//+nLkIccP0MUcj7Eo102duM?=
 =?us-ascii?Q?SA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 1566ad96-01c6-4aaa-2e14-08dbb61452b0
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 17:51:00.6872 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eAnANaxyHksR3NkQT+JKyaQMKCfibPgIwERUkKen5YOBSb27sVHdhTMVROwdGo8aiDUKy1bXK8RGnM7om1PpAQZ8XLqR7omKDtFEMy43E7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3970
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

Currently, one can have both SYS_SPL_MALLOC=y and
SPL_SYS_MALLOC_SIMPLE=y.

However, while the former does make board_init_r() in spl.c call
mem_malloc_init(), that has no effect at all, because that just
updates a few bookkeeping variables, but as the linker map shows, the
latter setting has (as expected) caused most of dlmalloc.o to be
garbage-collected. That is, those bookkeeping variables are not used
for anything.

IOWs, with SYS_SPL_MALLOC=y and SPL_SYS_MALLOC_SIMPLE=y, the value of
CONFIG_SYS_SPL_MALLOC_SIZE is irrelevant, and one still only has the
small, SRAM-backed, malloc arena available.

Now I want to change that so that the mem_malloc_init() instead
updates the gd->malloc* variables to point at the SDRAM area.

However, there's a small complication, namely when SPL_STACK_R=y is
also in the mix. In that case, the "simple" malloc arena is indeed
updated to point at the SDRAM area carved out of the new stack (see
spl_relocate_stack_gd()). So that case works in the sense that one
does get a "large" "simple" malloc arena (of size
SPL_STACK_R_MALLOC_SIMPLE_LEN) - but CONFIG_SYS_SPL_MALLOC_SIZE is
still irrelevant. Once I change the mem_malloc_init() logic, this
would then break, because the gd->malloc* variables would be updated
again. Also, it doesn't really make sense to allow the .config to
essentially specify two different SDRAM-backed malloc arenas.

So since CONFIG_SYS_SPL_MALLOC and its dependent options are no-ops
currently when SPL_STACK_R && SPL_SYS_MALLOC_SIMPLE, simply forbid
that combination.

Simple grepping suggests that these boards/configs are affected, in
that they become a tiny bit smaller, and the defconfig will need
refreshing:

  am62ax_evm_r5_defconfig
  am62x_evm_r5_defconfig
  am64x_evm_a53_defconfig
  am64x_evm_r5_defconfig
  am65x_evm_a53_defconfig
  am65x_hs_evm_a53_defconfig
  iot2050_defconfig
  j7200_evm_a72_defconfig
  j721e_evm_a72_defconfig
  j721s2_evm_a72_defconfig
  j721s2_evm_r5_defconfig
  verdin-am62_r5_defconfig

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 common/spl/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index c5dd476db5..fca9ada337 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -405,6 +405,7 @@ config SPL_SEPARATE_BSS
 config SYS_SPL_MALLOC
 	bool "Enable malloc pool in SPL"
 	depends on SPL_FRAMEWORK
+	depends on !(SPL_STACK_R && SPL_SYS_MALLOC_SIMPLE)
 
 config HAS_CUSTOM_SPL_MALLOC_START
 	bool "For the SPL malloc pool, define a custom starting address"
-- 
2.37.2

