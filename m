Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8761FD3569F
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 05:32:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96F8883C67;
	Thu, 29 Jan 2026 06:31:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="EPNpvVfX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BBA483BB1; Thu, 29 Jan 2026 06:06:01 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CB9583C23
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 06:05:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tdi4bGNJ6J7MHugBuN28JurqzJQuZrykoh4f9bbp2UeRgZGT6rmlE8zW0QY+Lho2Y0+2P0g6n5K5LH7r4lRDaSa7TzbNCgYRFp63VxCK+mbR676Ov1+hdm9vCZFTF5VJFhiBvmGQpodnqQ/auRmAqp+wcv7TAbY5QcXDPWqATCKRt4xKdOQ6YtsVhF0f+3592yUULXMFs3ASO4Cvy2xB/DpxLVWPZUjToavpqdyzpbH7gL0u3WCBDGZ33Nw+833HQELCedDFOj3AML3m823AWnvPS5qTKApfEsvgTkwlHXNUnOnIYqmkkeOIzllXSDOA8AOJF4vLScNVPJNo/RbaeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UqlBZ8tYpsPXy+QtP4LcG/OSZKv+8xBb7167lJRpmE=;
 b=iNrF3Ro0KgOIAblk/jOdHeXVUPOUXMl2mr1ySMgVAyIZ59anIJZJD6ta6kfAr5goRR/W39xaHO8k5V8ubnV4B7wfmVS0wVtt1SYBf5FUehS+hMvZE+lF4dwxa9zfYpZb9IUBwfNfsN/h8JQ/sUPVvqglXaJQCT3zflpyHchQusGpvX/fpf3PWvbQ8KZ2Ud49lMm/rxaYysDiZEuvjNAz7utRjx+8EXVeK9s6yFQruKCSxOcCNBqv3RNe6GM5gpuwETROE4jCyckRehYHFdrRQnO00MDzqGzSx/4AjQ701E1k6dZdtL+32JFZyHiLkcHT4Mxb0gaF0vtyWWFlX0LzaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UqlBZ8tYpsPXy+QtP4LcG/OSZKv+8xBb7167lJRpmE=;
 b=EPNpvVfXz+1MiB9E2QJ1b1+cZu+Se/2MrtnjfhG3zAAS77ogFhZ6Crc6sm3nMx3DtyS7vRbyhd1yNnwMtbVe6UyyvxJI18HBVXRpDK0eAwetaBQhRlhYLcKIAZlwW7QEeyjVrj+UJGfNKqTzGrMR4uZNljX9TlrFCS5njRDR/mkMy8S7GyE+psj6qn1WgaaJf2b/UuRyMh7yKiqxsX2Wxhlklnjf5kIOGPQXjHHpfuwJ+LSJ4nIC86q7XeEcYUdWkCLQD196Ii6ikPvZigKzuK72xCYh7E4cKOtcsenFrTHLpRnDPihovGOxCXkXAO7jHv5PbDw0sBI27EQgN/gh2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by DS4PR03MB8422.namprd03.prod.outlook.com (2603:10b6:8:325::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Thu, 29 Jan
 2026 05:05:56 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%7]) with mapi id 15.20.9542.010; Thu, 29 Jan 2026
 05:05:56 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH 3/5] mtd: nand: wire SPL NAND MTD loader into SPL build
Date: Thu, 29 Jan 2026 13:04:44 +0800
Message-ID: <20260129050446.8858-4-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260129050446.8858-1-dinesh.maniyam@altera.com>
References: <20260129050446.8858-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::13) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|DS4PR03MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f1b317b-fb35-49dd-1cf4-08de5ef41582
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gE1ZQ6s5HgnTAKN+bvr2Sv5PnpTnWqzsxdeypp2Ad06s28U2wFz8HSouwqy5?=
 =?us-ascii?Q?Wb7iaKYyPot9wZybBVxYwn9y/ZpxY8V4BrZqhSunLgsYxoc0/0uwPPynPlgK?=
 =?us-ascii?Q?PXIlBcX4AIFf+aURN9Mpffaeo2WJp3EStM1b9LC/z25CsB/H3bIMzcaQ/h0k?=
 =?us-ascii?Q?/12TIClrTOaft7wrHB5aBKrJqtBDUTv2c3oI9Fw4Mr/gz/2YuxAMaYljiDad?=
 =?us-ascii?Q?kjmvD+mxOicfQYxhD/Rt1yGWSbnXPVEKYXOLOwFFkUSPOxnDL5VDP5iiGnqa?=
 =?us-ascii?Q?Ya/1tuxts3meqgjlDqMCfOnYQOJHNPgh7F8gW6mD3tgjiL21g/u/U6XqPrDb?=
 =?us-ascii?Q?VPII3aR5FpHmS5wOgggDMv9iQb8FLekt/Li9IQkKW1Eds8KAsVSZqmWT1Yvh?=
 =?us-ascii?Q?VPZ0506ZHh9qVE/2e876wc6vvFfnBB/FMDto6e0SMOp3EaMg5/MJWdr9xqgU?=
 =?us-ascii?Q?PbpZ5fmPL1BPpQ7StBTNch+5bV0Ojy0kBK2mH3Vdg0VEW92xQizwpddm+N38?=
 =?us-ascii?Q?MjFZ4YadlLwwnqShSFgDERPwMPgdL4FO5n1m8S1SCTwn9qqIYvtonBHcnP15?=
 =?us-ascii?Q?0BkbSzCc7grPQyjoQHUc9AoTc0a/XYppvm9/TlOhqjLc8VwQOiU9G3WQhUFh?=
 =?us-ascii?Q?IckY9m5vtRhUzNGWEtIMwB5AZogwru032H7gRXyHKnE2Sc1rlYlVNei1I1Ox?=
 =?us-ascii?Q?ojhm2whDvhct1MlZUFVmik/QToZ22x+NUdGOYfHcPj+1HVO1HFx/gi2Dm7bg?=
 =?us-ascii?Q?rvhJKRcbNn2K93yJdsYQtpVeB9U7EQio4z2Ou9kT8n0fZnSsTqPiO7vdq2b3?=
 =?us-ascii?Q?zaJkz6vaKqolPvDQJq/8aiNnD5JDSKkz7K6dbSiuD7hlB/Qs1Y1UIK01Kw6U?=
 =?us-ascii?Q?wfr7Bzy05cRV+wdXabssAwlhGuNzayFVlRsZm+CjFgICuRWn02nXDXz+sgM3?=
 =?us-ascii?Q?2/bCiK1XC8uBmhOOLsnA+RXyVJNnZ9JV/otn9oeeEkgxEBEqVXydejQPmRor?=
 =?us-ascii?Q?l3R3lwiM09sx8oh9crRY+T+8EkoFWaCvhbRJCfxK9lnFCfLqttabMcs63Rep?=
 =?us-ascii?Q?rvyG2Ce4hl2eua/WfqMc2shSA86aD9Wm/J3iWevisK7511lwqjdQV7MlflIW?=
 =?us-ascii?Q?6PqpNbaj2zIDdUWW+YPtpdhbjQrBKgKEXvVvffbpfGnjLQWcXCUDg/i7AIWs?=
 =?us-ascii?Q?sV/tXoHRYzfPLaGlBsrlDCfQ2/0jfGHJK0ggYNb1jBwnqd5tCYuRh2wZVpkc?=
 =?us-ascii?Q?g2EIpN18gQi9k6Zic8O2caS4h4KQsD785B3AtZfRkcZ1+erBLFT82zMV9R/a?=
 =?us-ascii?Q?V5LbpuaJsZz8HyeVKLmC+7k0g2zCS3Y17lH8sXyZh6+HF84WLMFoo+SQBPtV?=
 =?us-ascii?Q?8fr2fFNTNEg6vlkR9GWW9Z6LP2WZI+acAjvR2D39OUCWx7dpia5LeOGm3FtJ?=
 =?us-ascii?Q?HkcNwU2sf87UNQ2iBHwzKfStTECX1VGF/7ItsPYXpLjMXAHr+THshZEu6vng?=
 =?us-ascii?Q?zqiTBQWqt/TXJXjfqorJAySc77LAT45jxl60Sbkdt15q0D8tV9Nifdsa4FY4?=
 =?us-ascii?Q?HzzqjQA7b9F36HeHLFs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KgXzSIIK/IvJyW/0un+R3ness72Jj+RLBiFbSbxsRCQKXA5PqN3lHCgybsb7?=
 =?us-ascii?Q?OhSTzmMA8Q1ms9qi2Nnz7giu3ugV8x5h5UZv6GnVu2eB4x15pj6i4EQpmpca?=
 =?us-ascii?Q?mdFn2/fygloDLlWbjmmt/dmTIukUVc8vtRi+1zytsHTwW5YblQFy7Wmklvc2?=
 =?us-ascii?Q?XiTcSa+gx+tIqmdRKK8/1ypkCnK+zG8Memf7X7HktJUVUa3p3FzImRTzqmMt?=
 =?us-ascii?Q?FH65DtZ8IRwZ4YqklOdCs9OMYfXXD7buKuxL2o81BtwBaIl2Su/CEmYHnJMg?=
 =?us-ascii?Q?6MWQv+SkCIeDxVq6s/oo8zgO3/GJi2PuY52VsYqpIAiSsS9gQpo2RyOe2OR/?=
 =?us-ascii?Q?v3bTsTWJHzLt4Q5ppVGEX499Ml6taGFg2V84HjkFbJdCH5ntK89OK10qYg27?=
 =?us-ascii?Q?hs0TEW1ealARdpxRSXgKlaT9Zy3V0YWLA+8UN+Kw2+gQSQpTvu0fhNsxNKWU?=
 =?us-ascii?Q?8Sc1gM5AfP2TB06RypUKi/eOPyxffW3fWPET31cNIDO2lAaB2FhqE4dlPeOC?=
 =?us-ascii?Q?e7FODHop2T4GZ+2618wfnqsfUcuD7SdbsEOEviAeUVqGfkr4XHjZyPA1gdE1?=
 =?us-ascii?Q?0gwMhYGwz9eAuCr4/Xy4q/h8Y1EeKmnxS0Ltt9QS4X5ItORlDswR6OdJMjD2?=
 =?us-ascii?Q?0fNDzra0/WEHQbejDMMAc1358BWy1DoUgOv1ADm8l9kRKIKoOWYxwWMViIC9?=
 =?us-ascii?Q?XZv8HFGn6IX+j/oYDxIuiTBPBPsc9GtsHNpCZdO29ZTE/aA8Cs3nZf+DmyTO?=
 =?us-ascii?Q?EkbE3N0ClK3vvYVYomZxwm3lrwlmCPjPK3GbF8nB/MjU47lYwySz2rogLft+?=
 =?us-ascii?Q?zyg+ez3M1BxHtomx11+DMaEoylrDOOJ+u+wx/OgiA4+Tvml4yvWmTiCdEx5b?=
 =?us-ascii?Q?zWi9JhYMb0Wf68lbspZq9O9wWkJsNnAMoT93EvNjUVVD8aKK3lfjh+3ZKdKP?=
 =?us-ascii?Q?WQTbJsUDaCW00krheinauPyszyrxp62RGDqYGBt+WV/C/HwUhXsEX7WH0HB/?=
 =?us-ascii?Q?K0GZ6Z3AUeBIWDtq4zTdok2nVxtD0ZUKOQLStvDMumJuysKEftIYmTL0OQfM?=
 =?us-ascii?Q?VTYcYCKwAFhp3/VxRE2DGkUwaKb+/aX02zuR4uf2a+pI9OeD0TChBVQOQIrZ?=
 =?us-ascii?Q?iKT4bElAq0+7M4cSwo0wPut+d+IaC4pMiyFYvQs3m8XWnkAffnXKk5vquMTW?=
 =?us-ascii?Q?pMsJEZqLtWIvWVDGz0o2IrjiIkezLAHbc28Zbz4f5FW54Zq7dfEgrLD3rnUm?=
 =?us-ascii?Q?mNY37NmEeQjuyD57+K8hNpZt23/jUDITAqvApev8H7G/cA9jiu7lekmvfhKx?=
 =?us-ascii?Q?Jw2Wluwb/7d0klXRAmMc9Oxtv9nHaYVAUsu4owT8jbkjmQ2JSoxoRLLzjron?=
 =?us-ascii?Q?TmV9HiQDcwjStRORyEaGFe33kWDysoPshDNNutGe2I4/+jsQ5/kbnyjhjlku?=
 =?us-ascii?Q?U9T11D0kt8cmV69qeBGs2KeYqd/w1xbTDoXYr1L0Txdevf4scwFHOWqtX8d7?=
 =?us-ascii?Q?+cyGW9EgJCcv5jPZV1utFYORRdvj+tUp1kJh5j9//DBuKtzpi3d48mA0x3G2?=
 =?us-ascii?Q?r/OmriMpkPkWfeYYGk2W2rDYr7D2u+5jMUQf5YljLiInd60liTTpKXNNAYmA?=
 =?us-ascii?Q?X/EYiy7pf9NxrYZ6LSwFPuL9Ac7nKmZGarCihlRA/tDfzucxducpOjThjEeZ?=
 =?us-ascii?Q?e/Z8F/cyGVMOcsNb2QsAXBz5cojhSuWJf0CKzTDeTpugK4INXko25lif892u?=
 =?us-ascii?Q?HZ0Oz3YLeTr7FeYwoDmEPkU53xCd5cU=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f1b317b-fb35-49dd-1cf4-08de5ef41582
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 05:05:56.3062 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Hk6IIdwaj0e1vcr5Rh82Ob8liHcoMiV01/XqHieb4JPn35ljRejhnhtH41L7TGVoejw7Hg2j++w85VXHeR9LNZEh5rvQsuXoYFyZ3Y9wrw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR03MB8422
X-Mailman-Approved-At: Thu, 29 Jan 2026 06:31:37 +0100
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Wire the generic SPL NAND MTD loader into the NAND SPL build when
SPL_NAND_USE_NAND_FRAMEWORK is enabled.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 drivers/mtd/nand/raw/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
index 76546a6287b..51a3b9a2aee 100644
--- a/drivers/mtd/nand/raw/Makefile
+++ b/drivers/mtd/nand/raw/Makefile
@@ -12,6 +12,7 @@ endif
 obj-$(CONFIG_SPL_NAND_AM33XX_BCH) += am335x_spl_bch.o
 obj-$(CONFIG_SPL_NAND_CADENCE) += cadence_spl.o
 obj-$(CONFIG_SPL_NAND_DENALI) += denali_spl.o
+obj-$(CONFIG_SPL_NAND_USE_NAND_FRAMEWORK) += spl_nand_mtd.o
 obj-$(CONFIG_SPL_NAND_SIMPLE) += nand_spl_simple.o
 obj-$(CONFIG_SPL_NAND_LOAD) += nand_spl_load.o
 obj-$(CONFIG_SPL_NAND_ECC) += nand_ecc.o
-- 
2.43.7

