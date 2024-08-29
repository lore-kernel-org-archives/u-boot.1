Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 752F4C7115B
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 01:33:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33EF888AC0;
	Thu, 29 Aug 2024 03:31:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 669FD88B5D; Thu, 29 Aug 2024 03:31:25 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20716.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::716])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3987888AD2
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 03:31:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wj+rSqIz79+sR+/WeyXXTGZ488boqYKA5DPKw0YKHlLKgO3lzT/dw4FhsnbvYPSPH+ae+vvauZ1iFftabuyRu0Aa9//rtSGR11XswHMjScledoMCndGGaM/EalQfseqsFeWvVRyst5i8pV7x7usE1wZQs6Sv2Lih2ufNrh1bDTjwnc/tCK3Y17X8ZvLKMhaI6Otr9jCmgJXfg42exiEeKURrsEkaV4HBTQZqdAfjwDE77TUhlm03wH8rvt8qiCNuWzHnSBzjqOkgFz4+3yExOU/kLxh1erbYTPq2PwBdmzsHZv2DImPT3IbhN4SGx3XMDV9Qe03BfvTv11e0VMV0kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8MQpOesbuWwC/BS+SGpdalIf4L5iGzSwGDhaQHOsVM=;
 b=mBLqpPdDFh4d3uUlak3rbkcEtpvq30DZHAaL7Do/b6v4eRaXKNnUpmobkEBqTlpzmYma3RtFN1k8d+p0DE86kunsY+E5FxMrVd/O7JN2t9T+NPI+n+dEcTuZ8W2LjvZmrPmcJkta4S4iAKTt+OBXtwCV72SeYUV5GIDBhSnN2jf3a96kFmeKs4MzHMbJeATDEJPtahxyWcTyjQnTFdjsPn4KevCpsltmKNEUR8oFSC59X53/OUwU1BLKEBoDP96/L05C9EwLanao8OhKvLAd/tzDXm6uX/Cvx7ka7uUgdremdSWy3koh1a9ItHcZWNhl5z6PCULKSKW5C2Y7geW5PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0574.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 01:31:19 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::3f35:8db2:7fdf:9ffb]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::3f35:8db2:7fdf:9ffb%5])
 with mapi id 15.20.7897.027; Thu, 29 Aug 2024 01:31:19 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, E Shattow <lucent@gmail.com>,
 Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v4 9/9] MAINTAINERS: Update Starfive visionfive2 maintain
 files.
Date: Thu, 29 Aug 2024 09:30:58 +0800
Message-Id: <20240829013058.6178-10-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240829013058.6178-1-minda.chen@starfivetech.com>
References: <20240829013058.6178-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0047.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::14) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0574:EE_
X-MS-Office365-Filtering-Correlation-Id: bf0f9e22-7e50-4f55-313a-08dcc7ca4852
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|41320700013|366016|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info: nsHk9ZhRKXGToRiSwA5R6sYkd9XRStP2QS/r+HlOB8pdltu828eTHghAv6RkAm4bERnUYUrqflOJcqhKSikm4Ey7U1/VkqGuaV/CBZYGs9vTl7InTd+GeD+rQmRkHqqfPNzNWUHCHF5y4GLUsBlZFu3V55oodTJKbFRML9mrN0QZ72mqFOiUKYUZfVi8226Vxoek0GaLwMxXZYdYce0K6U9VanMPZBW2MzYf8yQPkSIsnAMZnPmdzspW53SZK//X4rG8ws2dyJarCBTXgm2G6vqq9nVqAd301ODYAgn6Lb1C6xPv5CKjuT1ZOqXYkTVTing9lm6WZbLMbd2s8gMMhLFWayYfuGUbKQWvalq2y7HFaaHor3IHjXXr6pEUlNBYZ2QVNq+WD9FTiFwz7D49mNYRdfFEjJJLh/ypJMuOlHsviWPumEo+7twOrKLGE1k+BkMpMkTBXjkcSnmKESsuUgIeWnM261RtmUA91BhNSJ7vdVxodc6I5pJ1ZabWmTN9ArXK83OW1p1ZJWFEDB9cc948tampeaXttU+4wAYwAVZ0aqW34HqDOJ0a+IHjZq28qecoWPiTxNp1EePpIOEZQJQkn9gl5kZCSt3eBwtoG4gYyshBUVh/28Eud0j7bm3DwopeoevsiES7TUDH8QJ3NQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(41320700013)(366016)(52116014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FfZX1U2HPClZOg3veISu653lsvdR4b2/t4fFMwl4HP9Kj8j6os9hA5pVHcXB?=
 =?us-ascii?Q?/46iQ5/sLbFu0MB6ECIRmdUp201oK4/EJyi9S+vkKuY4xpOLUWqlvpi92vKO?=
 =?us-ascii?Q?TnJb/cH5MH22eT9KqH4Sp98jaHBwXk//4KmyeGHeqwRTFag5Xuyqu/fzZC1b?=
 =?us-ascii?Q?6P2KSxzKulbryxtLw8ta7haC4hRb5lY6TwhtB9HCf3SzjYCUSA8fjbBkfxXa?=
 =?us-ascii?Q?/QGWwCSjuAhh2cxikTetoRxZluObQwcknfb3OS92rrsdie/dBxRnaZhKKF05?=
 =?us-ascii?Q?/oJ993jCcVcIVncp2cfwd6fzoiDqhyA7oVMPHIVrmrtXhtYJuRwg/Twifm57?=
 =?us-ascii?Q?Cwk9WscvMZOHApxbRUYCkevuuN88rSxSyt1o31BexylOmusbvskRTyXeghbn?=
 =?us-ascii?Q?zPKY9/cYNGnO1Qu1BIQSTZEnlcguOVwIJMariDgZA9L72kXHjNgnNf2cIgCj?=
 =?us-ascii?Q?brUNudodHUhwqdhqqRpdU/wMkNG8TsmhBdRmLXw+Vbz0SKTO0VntyFxhxdUY?=
 =?us-ascii?Q?g5CG/g/Naa7sj/E/XRF3fvNgTuhVDONdmsxYOS58wSsc9tYvT78msqrT09P6?=
 =?us-ascii?Q?sCXN7T59Bch6Fq3XzUcmh4CQPzRof3u3aTQbjRsxeRVJ0jSDNchBLK+CQ2Q0?=
 =?us-ascii?Q?cvUJ7BaDM9tUXV6gKcTPLIa7mBb6Qt1sHbp/QUm84kX7qNF26cU1H/6WuU6o?=
 =?us-ascii?Q?irANObDSFd47gwHRM1/8OtEmyFewtNSwlO4LIFDhjKycc2n7giqJT0VQWEgn?=
 =?us-ascii?Q?Pw2ozaNCad6pA9E2OhVdx0jpFju5ZzljF66Uxn+ZLQgL4PqfhvRgemkVS0u5?=
 =?us-ascii?Q?C8OPSMFufzEF89bPlNyGwe9bP+SY9soWPzktYZ3C5jNAQkJ5MPEcoMb0Yu/l?=
 =?us-ascii?Q?UsQMo+95PcxvRVCh3ey+7vM7GpkJt2Uv2SFA/w09tEGNiy0NlVF+jsadBhVG?=
 =?us-ascii?Q?ZtChWSGHul/2ncyrBkD6Z0snHU0T0XD/Z6VQMpeJgtD0a+fhm5jfiGewJcN3?=
 =?us-ascii?Q?yBqO8yA3vVTRvIOn/yUNTHRXUxaf4XZCaPr1XyhgNS1jUByr3NlH+xFPJqDB?=
 =?us-ascii?Q?k/nImmegSLaAZbcyr/TSSOmXV97Nyw88c/eNElFg4XFJcOgSMqrozP6YBFNL?=
 =?us-ascii?Q?UWNc0OeQ35hGrJNHNQ9LWEaPDvnwnLIwcDKB4iX26ZTMqEEVNbf+LNcLqfDA?=
 =?us-ascii?Q?Fjh/s4Tvib4kcjmHKRMECMTo/9JLn5xdLJVT07BC6TyR4A04cZUAqu80aCCr?=
 =?us-ascii?Q?e+1q857Z6vWRpAOv6hYKViMH6K6org9vTx9EqeOzDIwErD7fGVEpmAoTAUAp?=
 =?us-ascii?Q?Ytny5WqXaeX08qdvre7XcBVcOqSTGanTRgRAIUFoshbOj+J6BZHR+fkQpbYa?=
 =?us-ascii?Q?OdRWi5fY0HV6OcfO9jrb88yh4XMEhuAU9nVFVOATpsy7Yp3zxLlgm7PCYZbr?=
 =?us-ascii?Q?/bXxlp/lXBf5p8ffV9+xOXr1DNfNRa4K7E920HQBp9wOrG3w5BYW9fFy/8Bk?=
 =?us-ascii?Q?0myfDcXdfhXlw5An6Drqv7WBASGLfhq5rS4DIjQKyh3xk0yGeunNEUciR703?=
 =?us-ascii?Q?bx+oYPYqJTpW40ZI5f6gUro9pZTTjEUxgidGbdQ/pgZSv/qYqsRNyWnVGabG?=
 =?us-ascii?Q?9Q=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf0f9e22-7e50-4f55-313a-08dcc7ca4852
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 01:31:19.1895 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i42julQahPq2lzoIkDowcXYMh0XeUHlwoGEoztx55qdNZ+fFMQdYDTTzm3nye9BiUuuyS0zqHBoS7eKqNgABeGlBLqiaNlz7VlQB7WEOFb4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0574
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

Add USB related files to Starfive visionfive2 MAINTAINERS.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Marek Vasut <marex@denx.de>
---
 board/starfive/visionfive2/MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/starfive/visionfive2/MAINTAINERS b/board/starfive/visionfive2/MAINTAINERS
index d7f638f9b4..1faf83f581 100644
--- a/board/starfive/visionfive2/MAINTAINERS
+++ b/board/starfive/visionfive2/MAINTAINERS
@@ -6,3 +6,5 @@ F:	board/starfive/visionfive2/
 F:	include/configs/starfive-visionfive2.h
 F:	configs/starfive_visionfive2_defconfig
 F:	drivers/pci/pcie_starfive_jh7110.c
+F:	drivers/phy/starfive/
+F:	drivers/usb/cdns3/cdns3-starfive.c
-- 
2.17.1

