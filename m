Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D74CE835D
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 17:05:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A6C08900E;
	Mon, 30 Sep 2024 19:03:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D76DE88FBE; Mon, 30 Sep 2024 18:51:25 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on2124.outbound.protection.partner.outlook.cn [139.219.17.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE18A88F94
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 18:51:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FK3GTnnQudWxb/RrIASpkf6QHj0SZdRbMuO+uNXjVLt31YmwBx7e7qjLelgx7i/niqhQ1liDEtrpvIF/dc/Ynk/8EoyVgeRdZx6jQ/ajyDJDBItbLYBHX/S47lk7S/z9uFkZCVcCu/GUlVN6UOUMPoAWJ0BGSOCDGgnHM7hMBcAVzdoVxXcxHThsHp4P2wsoWVjgfbPDH0AvrLSB+jeS+D3VeouMCD5tpVQCOya1efgrGj3Mu8F5/051kJeZZ5CQAxFeT7aQZMuPeQIC7Chjqnv2GNL2hv/RD2N6IBRvYGNs4zvjqP9Tn276NKeCXL1HC5Fqr1QGdsbexiGgyL4uOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PyvJEJA6CFBRjv6UmKptULhET5MCfikhi5Rn8MSl7W4=;
 b=eSxIEwQZIGGRhvDYLcB2NyVzffi5oTTqK54Cnb80n8Ebzb+mi1O0hkOM9+jYuQQBzmzxIf3Mk+64+VDb69GdbN0/4QjFpVyqaJQSyc58/f0fa91YnH+h+Wt+spMcurzmdWyCj/+dV2TrG/IXvG0mqUcAgtgAvRLtiWoKsK5LO7aES0oxm8dgRMtKND5HxOOv5HAPbdHj/4Fl2GKMWyfuICI/+mhXw8TQUhPtoMk2KVdaBRlWslbUVYzSLM/eTe5u1vWoxpLY5PmI82YDvmhcEhtpl79v1MXFg7mQC4RVbmW4HzVG57Pf1H9IAT+pWbuKGOFlVGqhV4wCRmZ0UpeS5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1243.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 15:59:29 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 15:59:29 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Nam Cao <namcao@linutronix.de>,
 Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v1 01/12] Makefile: Add OF_UPSTREAM Makefile for RISC-V
Date: Mon, 30 Sep 2024 23:59:08 +0800
Message-ID: <20240930155919.111738-2-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240930155919.111738-1-hal.feng@starfivetech.com>
References: <20240930155919.111738-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0063.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::30) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1243:EE_
X-MS-Office365-Filtering-Correlation-Id: c6111be2-7874-43e2-2363-08dce168dda1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|41320700013|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: nVKWm4ucXnvUz9IRln8GkxW0OjWr+ouoyFtosndto3YRAKKqAsXO/MLh1ecR+kVaCF2vLyEL7/hk/TGogdyCfMWSQEcPPSi2B3nkHjai1i8M+fOd3NZAgvpFKnw4IbSSJdKES5HqBO5rcm+udD9FJOG8Bp9uAVJcpgz9bsRKgukclolSjqLUp1vHy0qavpZglK/aRV5wD9XBvzQgkkF0Y2k3315NBqYVfvQ19ME2LMybwbyPCrclhFbQGCLS+zkxyTZYCPsnzWle4u75xAdALbQ/ylLO+PCr8XAtQNUgWJDpZXHmLB8H03oJLnFTw/0F6PbEnqwFTOSHjm7tSpqbAXYDUCWw2zALaSFzMAl9LVm9lX+ULntmwhKl/s3iYDD+tX6WsxhJ5p2ggHutU//XDMsGrZUkO2Y/4E8y6T+D3dRa0e/ORGpLNxnzqBWHr8hK/w/bp5MVhAEasB2m09ekGjEfMAUAKw42Zv2XC07mVsMlWfZTYMfPOaaDn++ed2sWDxqvZZPaFJM4RqE4GY6INJNlehI0vZLkqO2iv6KqrUb4QbUeeZpTSJDlFlpK3aMWem1xmIqqyKadKmm1gaY4TPXNCaeAweK3jKIKymDqCBHvAa9gVNNNqGHswsiYiAbZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(41320700013)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cNIU1Hhlpq5V8AfvEzm64c++0iZ+HuwH1xCg/7nkbAZGpbm6Yy9XwGUSWDSn?=
 =?us-ascii?Q?vW6j3IGRmvlrdYtDw+SzjQcSbzaR2vdrXIRGqX3obdeFvz4vvm9qTCgEjk6I?=
 =?us-ascii?Q?7VX5BNslPziBu1vlymWMh2MNwwreOqpPk/JlaOLiBW+l2j4QdmDk4dLuJ/6D?=
 =?us-ascii?Q?BU6BJkzucH4fvKGXajwDeOJRkZzdVUrZlSxVuM1KjBS6+B9B2iFnQVlip6ku?=
 =?us-ascii?Q?RnWDyqOf0uE/DTMWM9gLqtcHB+16zQxvWB9Vw/+Es+SBvA/2ppysxt3IOXIw?=
 =?us-ascii?Q?oxZ/2ygTW/LJAnogRBBJQ3EG6vp+9M7e0eodk/CH/Ft9H087y2oKNRzxNZpp?=
 =?us-ascii?Q?hhsQPy0c8MbrSb1yfDuwYXdIGFVamZPQs4Ua0SLV19ZB8ZNXkxHVdjS8M1ZZ?=
 =?us-ascii?Q?aZ9F4BTYC9Wp/6xpJuqEZkT1r2t9GgU7o9E1bs9ly0NE7WBdbYFDEPOzMXvC?=
 =?us-ascii?Q?+RLDFtldiwOO9FT6o6lHpoRN7LsCFQJMxiLDKziocaAIkZgddLS+R2pPNh0D?=
 =?us-ascii?Q?Z36rsSv8Xu+ckUIHj1JGa87W5L8MCKNv6hLmuIMFkZUGw0YXHrkwWU9Mo5uP?=
 =?us-ascii?Q?4uuClo/4IuUHyz0X95HzvVFkUDn8XYSRdTjo0uYO8TzyW/zVBZbO+f8kmEV6?=
 =?us-ascii?Q?1WEU8zKGF2BTeb012Nrk+AuZPsX89K1OYF8qZE8NQ7DqEH84E5VYmD4wjaNr?=
 =?us-ascii?Q?+d2Z3YAlsmriGfoGZjsqV2nnAs+bU/nAn+rrAVOIzDjYDXmfatZGGpWTtJcA?=
 =?us-ascii?Q?RfuMfG3MTYGwnN1UZjyFmXrRuAIOrOChvzUr+PFR5dKhRTIDnSLNDJdovRmM?=
 =?us-ascii?Q?FBDScQ82iXBz5ZzUmJPM0zmejDZmCHc6Qurr4S5TKLhLVbeAP9v3hjk82d15?=
 =?us-ascii?Q?uztvJJQBCUP6rDySH/gn9LtQvx5kZL9lcD1Yn+p/qhNOv3ukNzxo234jxgEz?=
 =?us-ascii?Q?cFJQuuYKteAY6agOGgMN3Jy4E3RUGSbVuBy1NqO7PtIAArZbmoQ6FNfvJPw5?=
 =?us-ascii?Q?GIy8pu2EVASxp0fZtO5T0O8SpFjYPPE+niq9nLj2lHUazif8v/g8wQ1DvOoK?=
 =?us-ascii?Q?kDPWuJBzexQjPCQXLhZjjm5NduEJbpP1OUZJmYGkOCaiPCMtM6dXxXu6Nz11?=
 =?us-ascii?Q?DqaAYncGVUBSswf43FHxhJXkNBT9JvbOM+zNdNwplJ/QYM8ISQAvlYdujTTh?=
 =?us-ascii?Q?uyoSL9TL5Nk5sTvy77uBXf6dENZNUZVNbLmkN3Ph4rhulnw+DIiPd7Oliy9r?=
 =?us-ascii?Q?A2BzawbCsck+1lhLZgbnfhyA3wDzuG3Bk/1TZsQZDAf+gKGCAaT+JTrBKzO7?=
 =?us-ascii?Q?YzXXOaa3fIFMAw0Ja6nnw/+g7fx96HCIZ/PQ/fmUP6FnZDpFCkchyeFoz7K2?=
 =?us-ascii?Q?OwNRPpf3NCFA5Q5Dfy6ckcWVtrxpu7gXEq1c4W/ZAJ4jW3NFTqnO055ySd5q?=
 =?us-ascii?Q?X2z6DiV1otfSp8LiPiwWHYqRuFPVb6gh+d7CrylMac1xO4TivdSN09qgIaSy?=
 =?us-ascii?Q?ndVVoEWcMf5qYP+geG8XpiCgix1BcPiFbwfxtifiCnK/6+tYfwyTRl9PiX2k?=
 =?us-ascii?Q?p/PZeYfhZqXapbobX0Evi2Q9St8Uv8TNlR72i9CcS1pwfqRKVNE7eb3iYxJq?=
 =?us-ascii?Q?Ug=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6111be2-7874-43e2-2363-08dce168dda1
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 15:59:29.2005 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OcuirCa7i12tKyXCa/TsHby+cjfURjhaHZd8x/7odPkpsKeC7ahlKIkl6QDqoeKCodquYv5twRm1rnLM+DMyJOJ2SUVaLW/RL39GiiK5ulE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1243
X-Mailman-Approved-At: Mon, 30 Sep 2024 19:03:44 +0200
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

This makes RISC-V DT buildable with OF_UPSTREAM.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 dts/upstream/src/riscv/Makefile | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 dts/upstream/src/riscv/Makefile

diff --git a/dts/upstream/src/riscv/Makefile b/dts/upstream/src/riscv/Makefile
new file mode 100644
index 0000000000..e00b3190da
--- /dev/null
+++ b/dts/upstream/src/riscv/Makefile
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+include $(srctree)/scripts/Makefile.dts
+
+targets += $(dtb-y)
+
+# Add any required device tree compiler flags here
+DTC_FLAGS += -R 4 -p 0x1000
+
+PHONY += dtbs
+dtbs: $(addprefix $(obj)/, $(dtb-y))
+	@:
+
+clean-files := */*.dtb */*.dtbo
-- 
2.43.2

