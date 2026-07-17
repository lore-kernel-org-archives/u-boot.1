Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCCD5C4451C
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 13:59:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 197A284E78;
	Fri, 17 Jul 2026 15:58:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="doy/BxP6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0022384E75; Fri, 17 Jul 2026 15:58:47 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1471784E64
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 15:58:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AYgQ3uawt1gjOVJL/Ib0+L2IBmiBDreazdgFKueUpWN0k3Dn7P4ifUg/etP0VMN9m/Y+FLGsYGMe8FBquItfMF9/ZbEi3Sb8SQvqo69Lsuup8QqVU6bxGiJl7/GpicbhUweKPPQmBiUuG0yyqupEMcdplz9m3bKSnQ5jPvC7x95J16PQjoJgmY0/diRTpghxIpTaB08tIYwAcvgYzEUsomwIsFvTfPBM8UGnvRG+1tv4ip6eSN9uUngCyXYHpWpTyDiZ4IMNKO5hsERe/DhYe4ddNUZnOe2SPYLb0ddteFpzI0LDexaBEk2kXw6c3/65X09XePaNq+9H/0VC0Vs0+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzMNaWchWUNOqIgBuNaY3ma3kAnm4hY3U1ovw2ta/oY=;
 b=s92laRWl6Cm/QWKWfr1Uy49AgbtMyn4xSmI6xlrqfU7UL4N5m3kmSXHXiuuoMyOEWnZvGMW08ASEkoeROP+APbV53aDyAPJpV6vwb95AjMDwnA9JG4GQ9Au22T6rwq/1tOgMYSaMQoUSOXaEq3YCvvsjcvsspX4DNIHC+OH5561AFIS+gScxMYSoStdLOHlbOCBNgq5X4zY44V79C3ymFD3s/z/p/DCvuxbnUAT0AE+LhgVXN2hh5T6mC87iCp+d3lOKqr1DcRCYuQfapxTo4JBGBXBV9roUIPvp78HdfB6ArFlafc+UDqKh2zUynnHzSwBNCDW252YHKkiUdv030g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzMNaWchWUNOqIgBuNaY3ma3kAnm4hY3U1ovw2ta/oY=;
 b=doy/BxP60hzEP/HRxFua/vsQa3P7FGFPvFkb7V/RJrP/He+anUe/MWjMEjYKywCL56qMJ4+BGPsy1K8djUpJdPaU4INBuISiyZW6VfiTkk1E/rVTLrysAJ9BTrGj84sv90E9+3XhSLy8vN5rWEuw84ItnRT6oMpIjbZNdakhuA0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AS8PR10MB7426.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5aa::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:58:44 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:58:44 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 5/7] k3-binman.dtsi: add empty distinguished_name_template
Date: Fri, 17 Jul 2026 15:58:22 +0200
Message-ID: <20260717135824.2142135-6-ravi@prevas.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260717135824.2142135-1-ravi@prevas.dk>
References: <20260717135824.2142135-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF000239F4.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::2a6) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AS8PR10MB7426:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d5a63f3-a84b-4287-e300-08dee40b841f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: dXafsVE3AcJITISyElYcD868su/hWo9z0kjsgyFT5l0kLkbay+MUqPdQ2VkAZxRvNzsikGAHWTgHquvsUvo7UPbeGI6FhPH5AkgJlztMU2reshdylh+VGRnv7L7Fz9b2Hs6gjb26/gLZY0qr4HhabQ+voy1BahQ2S6GKtgLm/jXMj+23/wY/BSq1d4QodmcpVnorrH33B18htHkebTGL1NOv3MDmO1YRrutlAm7a028kGCgmqB0F9T8UVPffjrYkB6j+LC93UAx8i2aePZZXlT/9LwuorOUcejeMxtJAn3k7bxce/nvcr0T55wcHm9WCUhWZ9QGu1PupYPgOsmubJxqkug+xGFoM2HGqB2KMBvEJDO3EAqTi8l2em2iB51Y0xJ1DFLhLskMZ5/hKAbkxRl9VNFxYb7o629HqsVgAM0Gt46gru/XO//2/lz9ldiPQY61hbdu5MAklT7G0Y+nzjunq8NxNRuM6DvPpefAz81siVXeHT9/vqi1S3m6Z8FZyV3i7IkfJ8NuptHM1B7nnV7SxJGpbEPSFcGQ7QQDAUDJQle2utOU+fI/I+dtwaSEURF4tCjlfz6OVStV3pZQBuRSQ7q6qMSogz8EQudzEUkYHK5OM5IG1THq+YprLFpGYWfF6zDcbpNbgYX3AK8cIbQwgIBRfgLUiNgidi2F9B3o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n2vMiJabEgG9ZewpGexbWqYO/OevAamMsqdwd8GmdHnIMzRo29JNdGOHBRBF?=
 =?us-ascii?Q?YVoF/bjb13e41Aos6eey6ln0i6v+s6CECRApBY8EwP3EbBGptRuOnrivcjw4?=
 =?us-ascii?Q?RfHwm1Cvz5rwjsKdHIBfMp5PCur7b2skU311GClG/QJgQGEw/GccPdyoF8vF?=
 =?us-ascii?Q?5evaMKemb/sujD2n6p7QuGgrKm9e8PGH8DVcy1U0RIdoxuBq+rzqCrV9nYLv?=
 =?us-ascii?Q?umcfsrsPjs8spMP6ZPq7Eh0NVh23DSCkswPERJx4B0dYSA9K9Ai7xhXyvTYW?=
 =?us-ascii?Q?L1QkSGfKQJCJLhJCTMBacseY08I1wn+znTKfgMwgSoqHIEFfE0Ij28IPZa24?=
 =?us-ascii?Q?p6ggDeAIyhweOHRxeu3Ss93ZE3gqvYN/7XD3uaS5KKpdg6Kb4vgaE8krd7hS?=
 =?us-ascii?Q?K0XDWxBYIi/bsNSuSAn+uNwptyrg9hw1D+G53VWp8c/j4UknIpAGOeAJzLvT?=
 =?us-ascii?Q?A7+h1oKVuXGoA07CqqWnY7HOayA5M33URauGkFx2V/36JxSdfhECjq05G2j8?=
 =?us-ascii?Q?PRQqSW/Y3E2+BnrURBQNx2cn7Wlck3OKpusmHVmYERA855aV4AnVmlF+kjLi?=
 =?us-ascii?Q?y0zDv9pHm1S7u68Z1pkm54YGR81Zh5a6NZ5ckf7GdMiXKfx5apzlJ9gUgbeh?=
 =?us-ascii?Q?4GZrt7cbFEIKyofMl1rCnf4UU0bd/kCVn16eg0DfxvwtVZbxv9tdaUuFH1fB?=
 =?us-ascii?Q?ySEm1+H7ssPd9NZ49ZuuIDnu9tAWBFO2A6bVlIAjD5BpocTtPkpT9/EWjp6e?=
 =?us-ascii?Q?+Nv4/Y443IRaAO14dT0ULswwsMwPWi8BkpYiw93PCZZDXShjhmHq7EVaL0Wx?=
 =?us-ascii?Q?X8BS3iWVlnZO3u5cSksjmF1k9yQIRb0ri4LSNbPr94IC4e7UR2s1QGA14r7C?=
 =?us-ascii?Q?8FjCR4u/OP3wHwF2PvtRrL7vH/xqeMb3m09XnFebiQGisIgTB3vMaMGmW749?=
 =?us-ascii?Q?iU2fchmVApX0IN/5CXsdPzotWq8QvQcV5j7SamcLwEj89LhcIBehyGns2BcH?=
 =?us-ascii?Q?wquK3OSGXwBxpsWjaUtMn2Ccvuqjfj8fBBbTnhXuuvi4UlwU4gKMWWyk/urS?=
 =?us-ascii?Q?UfS37QTlr1hpHQl7PUD0LNPzvUmRS4PHYgskwe8EsL+nFRLcUozGYoCZA8jD?=
 =?us-ascii?Q?j/0U7qvBj3vx657RJNw47ejZbE+CbzxZOUibxwtvsi9o7EwUhZ2hrYVfiWz/?=
 =?us-ascii?Q?uLsEOs9rw5xFoFSkrNKKOWW7iqxzbCGhSxuJEF7iE2MhJjxOxH6QYnJo4cYT?=
 =?us-ascii?Q?TPCPu7NL5EGfdqvw19fVgBnaRu+SoK7PpFtfErowmjCYE66Hpwy96QTvcUI5?=
 =?us-ascii?Q?atb3eGWXWEtJsOsvcP8KomPbFDmY3YgSJejEphFyLKG72h7quHnEaiSy+eRQ?=
 =?us-ascii?Q?0IHh5pb04WCRjrr6YYbVw6+Nogtd0AK+X56JzIk+vx/hMs82k9kAkm+L6BhO?=
 =?us-ascii?Q?mlBZQvs2Np2/u8I1lckVBw1yZvbV5h7mAH7Z+Y751FF5wKSXLIYkmC5ONgaq?=
 =?us-ascii?Q?SPOa9HLQNpTiPT5BB4ejBihfg8U7AgJI5fegf5h0k7gIw4Un44CPRFLa8bJF?=
 =?us-ascii?Q?J1ki5LRqF30e0tYQcOe5Yl876GWQhbTqSolpgS3zbEqOOnuBR/jzVa1BZ9G9?=
 =?us-ascii?Q?BCGFzB3PEZhOuEGbYCzNoo+ttfCqsqV0pWeSLlWd5dq0N5LGTiUHSrqSWnaU?=
 =?us-ascii?Q?h2ujpWbJhhC4vn3L+wNnSnBBT+ptnT2vCSAjnfA+zetfk5oxrhwqeymJQzHx?=
 =?us-ascii?Q?0K9mHs14uQUi3hGES2UQz2BXar1CS+c=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d5a63f3-a84b-4287-e300-08dee40b841f
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:58:44.6579 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m8AtU2KcbmdQjGmcxFmI6d+MNa/CIQAxBK4cudVy9uzkQ54tO+UEKqzvWV0R6sJNnbsHR188J+6rPgm+UGE0ybKsUrjLQbtS5WnTliMeeqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7426
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

With the previous commit, "binman: x509_cert: allow and parse
distinguished-name subnode", it is possible for downstream boards to
put more appropriate values in the req_distinguished_name section in
the certificate being generated than the hard-coded TI
values. However, that requires adding a distinguished-name section to
each and every ti-secure or ti-secure-rom binman node.

In order to avoid lots of repetition and make it easier to just add
the information in one place, add an empty template-dist-name template
which we can inject in every such binman node. That makes no
difference for existing boards, but makes it possible for downstream
boards to simply do

    &distinguished_name_template {
        distinguished-name {
            C = "DK";
            ...
        };
    };

in their -u-boot.dtsi.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 arch/arm/dts/k3-binman.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
index 69214bb32fb..2c9e5b619b7 100644
--- a/arch/arm/dts/k3-binman.dtsi
+++ b/arch/arm/dts/k3-binman.dtsi
@@ -29,6 +29,16 @@
 	keyfile_template: template-keyfile {
 		keyfile = "custMpk.pem";
 	};
+
+	distinguished_name_template: template-dist-name {
+		/*
+		 * Empty, but allows downstreams to inject a
+		 * distinguished-name subnode with appropriate
+		 * contents from their -u-boot.dtsi, which will
+		 * propagate to all ti-secure(-rom) nodes including
+		 * this template.
+		 */
+	};
 };
 
 #ifndef CONFIG_ARM64
-- 
2.55.0

