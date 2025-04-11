Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA653C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 08:15:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8462483F9A;
	Fri, 11 Apr 2025 10:15:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ABxzsnXW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1045983F9D; Fri, 11 Apr 2025 10:15:23 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::600])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD7C183F85
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 10:15:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jGqehfjuZ8aHsSyt0Mct+JJrF8VTEK9fZZ6EnEYg4H+3Q5p9HOCiHKo42W6yCSUWNNqhmAsTIwfV64nvEGcxI0073zhRorn6EOVhoUNGG9LRlANzpl0ltP/aklmwLyPsXcJsLfRqa5eBQwRV/nVQrYGDTg4QdqD+OpQuXjm7waZaK53rpaTz68HIVq/suxrEE2olxexmO48ljJeYVloB+CLvdpoTVJLay/LfkqEUTv2gP+Ox26nYWXQF79snotb2E+gniZRhkWx1jdK1dLRP7LaVYN7AVsUSwQmVgh6kLtcXqehgP1xWq/fopMjTNrfGn1Ka4WRSMFB44sXDPXFclA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgCSjqMByRnn9N3ZRO7aVafrHa+0hhqjLKdklzdfFzg=;
 b=TB/CM6l+uqHxs/7y3e2M7vGnWFg19Yi6yKmQqgywA9uBc1XDXPo10QZMN/D758GQUMbiScSsDJr+M+TGKS1tbkQUgeT/CUFxQWY7PtOzyQJFM9O3hUpafL2zOg+IsnUtoZdvrxd2OQmlANuif9+YaTMRvhp/dCTPSeOMWLX6ttcEk1CBIzNy3YC+G+FUK14RsHSMvCLDmcB6QX8VNAlZ4jE6s4Wyzo/V8ULACNVar3C9/LcH5bqsOtPyZEuYtdWnrNKCfzYQsJmWrTmxdoNGyZxYSu2hLsDVV/WvhxNtDP2HeA4UB4k5Qkz+pti+EIAIKVcK3l4PPncAFYRee1xPTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgCSjqMByRnn9N3ZRO7aVafrHa+0hhqjLKdklzdfFzg=;
 b=ABxzsnXWCDqp0HEB29QJp+O9oBQHgSiLBsnJCw/bn9UDmaFKjKIU26xwCuTcmG/+Vpu+QYmWcq2RXSvMr97Xu6VPHQfrUTwwzeQ4Aa9dwuAI0rgNezEasR6rLW9Xb0H+2N/GrDVN5xSfBGlqOdg/otBu+pPbb2CoviXP7GGBw0wOekdMtHYbkbL51cimL3DXe5XID7vBbldUndG1Em6pJV6hD9lrbcOns/upWCbVp8ITRY1Hk+4CX7h8W9tDZb+kIMm3fd0AH/hF2Bu/RK5QEyojytAhUsOwaMRVRCy+2SJAFcXFr8cVG/gJz//2UTf0orQi3XguRmPq+SRNo5/qsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PR3PR04MB7210.eurprd04.prod.outlook.com (2603:10a6:102:8f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Fri, 11 Apr
 2025 08:15:18 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8632.024; Fri, 11 Apr 2025
 08:15:18 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: marex@denx.de, trini@konsulko.com, festevam@gmail.com, lukma@denx.de,
 seanga2@gmail.com, sjg@chromium.org, sbabic@denx.de,
 alpernebiyasak@gmail.com, alice.guo@nxp.com
Cc: u-boot@lists.denx.de, viorel.suman@nxp.com, ye.li@nxp.com,
 ranjani.vaidyanathan@nxp.com, peng.fan@nxp.com, frank.li@nxp.com,
 ji.luo@nxp.com, jindong.yue@nxp.com, Anton.Gres@ifm.com
Subject: [PATCH v9 20/20] Makefile: add some files to CLEAN_FILES
Date: Fri, 11 Apr 2025 16:07:03 +0800
Message-ID: <20250411080707.602371-21-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250411080707.602371-1-alice.guo@oss.nxp.com>
References: <20250411080707.602371-1-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:4:186::17) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PR3PR04MB7210:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fc065e2-6b5f-4668-fd8d-08dd78d0feb5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7416014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8jll+SyhVHpWS/hHf4mVpJZewZTlT+lMGUpwsrrjocXr/vl9gYUMI6hp/WUD?=
 =?us-ascii?Q?6nm00c2ps1JQmSuYLi/O8kHuM+Jo84eMII2B2/mPuzhYtvHbkZ5N32cHb1UM?=
 =?us-ascii?Q?NMnujmkN6giMTKbZT61jYThnZnn1g6Ylpo02dTJZUQ0c8WFmXZVC4iX43oPZ?=
 =?us-ascii?Q?rX8M6cAg7q5BFCgTm3lXWW6smNlG1rKcye3XtS70biyfwGyjQ0MRmK1OtsVY?=
 =?us-ascii?Q?lzkyt+cXflOwFoJBPiFfNjlel9z2jALpqBKcBYxpjHpDqn8hHlOgwJDr0lGA?=
 =?us-ascii?Q?Q2FM5nrz01+cc+sRw6N2Ti3uOyNBnIPlFRrWvZVZwjRgu2nynCBpmCIWyvTR?=
 =?us-ascii?Q?F3KqhDBdmMomPkp4jKB6kBeiWaTq1B5270hRLCXJl1EIIgQpt+4y826cHVJe?=
 =?us-ascii?Q?PROdLo6i2BS9IrLgwCCnMMUBED0tcsj+Kdfx0lX4G+Aic3wO98DoA+23b2yK?=
 =?us-ascii?Q?jiipD3nxdSgvfyH4XQwm3vsx2UeLpFcy3mi93Z6buHix3icapEWQhfmSJmTj?=
 =?us-ascii?Q?WQJlyMNKb9rqTNfCkKV0mw+XLmJGbqUQyncGfgSje4nSXnDrpBLmJtalzGw1?=
 =?us-ascii?Q?RGJMFfbGLXADConQ3LVIyrzh57f7ge3Df/Mr69ZDV4C0UcIrQoRl68ApHVvK?=
 =?us-ascii?Q?+VJAty96AX9wqDl9Rpxd72dCjPWr9+hc1fM7hnE4eLTrEsRKeLFZ6gYxknBk?=
 =?us-ascii?Q?TV1z+f8p++bm5FP+lMqXktUsTRcH1L0fbsBytkn9SwLLyM0AVfT1ddrdQCYO?=
 =?us-ascii?Q?xW+IHirlVRz6wwhpfT+/rOqRiLkRr9edUu1PCgDaNzJECAscCg5rsaJ3fOFN?=
 =?us-ascii?Q?jJzfeLSZpZz2BgDJABAyIokyj5biQ5gZDCyLM2xAEm/hAXt4jNEpXQkOwze/?=
 =?us-ascii?Q?DKalUT0vT1RhU1UQz/a7XJCryq6vSY0sUDknnOcNEORW6HibObUXfeucWxXK?=
 =?us-ascii?Q?AfJetMiC9YpR4XR+FnshOYTjwsJ+4wILkkfzs+W1G03dQnCMFoawPClDblah?=
 =?us-ascii?Q?VOZ6BPkiKAmapDkd5/6669Vs7KSfekAWtqeDg/09qcIQa82B5JXreMxx1Mfe?=
 =?us-ascii?Q?XuXxNME6BPsF23MPEMtUAQHFo9RGf+gbrUL3417V9XqaJP+HPjF3sT3I8Uwh?=
 =?us-ascii?Q?WUqm+StmQmXYjeVT6I15EKaz77KI6zcyXA2FylqHx8PHfLsR/30zfyKWHX+x?=
 =?us-ascii?Q?PziXxSO2D/kGf65Y8wtpHso2fg37oR3Y+abS90QjZexiBwK6tg6W6fN8CE32?=
 =?us-ascii?Q?fa/h0gTHLnfHi+kUEHwgYDr8ifHpuZGxc1rk6ElGMFcMGD+kALuN+p1tt1rg?=
 =?us-ascii?Q?R8se7gokxAJYTVQDR1zvMdNRO9AIQg9OXF8V2bDkYK1sh0qvPAd9Wz6LA2PZ?=
 =?us-ascii?Q?oB0LXq7pMy5ORm2sYnMy1Bbek6eUCmk52pxw0NeQsw3n8i1mEkWlocagdRef?=
 =?us-ascii?Q?wAtjU1fCs5z426xbAj0xLcKyOwq/eWbJY+r4NvHLZZpQaNGBltkOsQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nDYI6e21P+Ski8Fx7unYIbi94wSrfj90oGRKwQ+QzWs3HnQU1xVgVeI3ZeYw?=
 =?us-ascii?Q?7PP1GxW7y/Ylbxiqcs/sKsumX/ALtJmmSXWGUcDvX7gcDsYzobqDrVB0MKR6?=
 =?us-ascii?Q?3P2LzH/6ywD2k2MNsvUx+HdIGns+yVCe8GkX7kv68GVPfhz0y98EjZkmqbu1?=
 =?us-ascii?Q?pvELcsZPFpDTGDKvRJY2HYTTKeWbFggGuZuLl66nfEnJOENdfKWPC8NvW3su?=
 =?us-ascii?Q?4NSyceSMmFQC4kxmHhuTQZqi9+Ab4v2KIP9jZWS+MBCiDXhAqWfBi2xYwWhZ?=
 =?us-ascii?Q?teQjHMWbgFpuCiHdDdZsZQ3t5LKL5VjQT0XdAnutKuuadfKIc2NVw3AH6qpW?=
 =?us-ascii?Q?74xKIsGZARodaVi7TEEVJyJBIHmH7OgrVCEqfB15ON5GUghJmO4PY6vJWqv1?=
 =?us-ascii?Q?EL+Zu1W/g6tLDtKmT3TbwTG1OwtPlhE0YEJu0KoJkGrMScacDpmbqgmGqur5?=
 =?us-ascii?Q?vuelPbsHSzSCDjXeC9dEMSREJYwlZFfxGqlLcptydlhxWNy5rLKwECsBN5Kr?=
 =?us-ascii?Q?VfimEBZDvv1obO+Yrey3//ZZvhXohCJ/xCuFm/C1wOCqlR9cjGDfTHYVlKAS?=
 =?us-ascii?Q?El2+LR/F5M0wNEqb0Ir/bW7Y/A//oFXss+pFh+iYr+Vkz1JPRqzCUCo0HiQD?=
 =?us-ascii?Q?1yyQ4j3wS+gZsMxoXyEtGzs6cH3Rco4cZTIJJfO6Q5uUEc++tO0e6d6X8xgm?=
 =?us-ascii?Q?wH8rcPOwFBpmB3f2dGzX4NILyvOfjOoTKWIQm0vj7svdeuIVvpKWiehj+s4+?=
 =?us-ascii?Q?u4ZdkFYJ9OcorOXg0rtyRy7zriJlb3yv3IoEdJgSYBw8ZBqXGvSzpbzL5U9Q?=
 =?us-ascii?Q?o+5gHBCF3SYM5HV8Ek/y2y+btnJFEiHUA7NDpU+mcJRbzsHlgcEWaLx56tXP?=
 =?us-ascii?Q?ph2WBiDdL6781DK7MB+U/kWYOhVwmyuqBQketUKKezeMSL61JAMnPGuC3/f/?=
 =?us-ascii?Q?wQzqYC/n9Xuug2cX4chCA788BdWM9bz4/mjLgohMJ1ctq/xezzCB9myyOeLO?=
 =?us-ascii?Q?02R9MkqWs5dmegBTkRFstg5yEjfpqx8bDOfYY40hocsOcPsd8JwbFicqphEg?=
 =?us-ascii?Q?zibQnMw/k5PTzBDKA/N00rK88R/DuNefa+Xg7YEqjRp1LA5zjTadCAknPI3D?=
 =?us-ascii?Q?B23xKPuzF2p5mW/5ZYcns5vVrXw5pDUSXJ2u1OXDjIkA96QVD9VyLKG3su7S?=
 =?us-ascii?Q?inFZgtERJDsMKxOHZx664H1n9784MODJJnisUd6nGzdUrqd+HKjmIBh30oqV?=
 =?us-ascii?Q?0SlD/Vzsj+5FEpX74lZfbx/UmsKUZrR3F2WvtEu4Lms30J+6TGP3edlLkW7I?=
 =?us-ascii?Q?2X+V2UpKdGAVb/QqEkpRE2U/xJkIs4W7cDPSr8KhUV1uTCv7rg9JZPwduKng?=
 =?us-ascii?Q?qdo1Xn/NoriCZkEE9GpzZQip4JSC7tDbrriXfOLMzpaggUNHoukUCg3a4XXO?=
 =?us-ascii?Q?sc+Ah25XcdQZ89Xe0fNPv9xfYKmb3JcFtiKcvPpPJ14zfDyU/D84Y2fRQFsJ?=
 =?us-ascii?Q?Hw9QTVL7GJ8PoNnDIXUPHwKLQN75EFM0DlBjQYFdwgnrh92BPltCg/r23BXB?=
 =?us-ascii?Q?wcr9giY2kdjYFeFY9d/9MLNb28kHeUPdd6OCEXhf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc065e2-6b5f-4668-fd8d-08dd78d0feb5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 08:15:18.2234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 462hfd2gaSXTmbvoB6fO8T0h4QPSSYZ5ZWyE/SSBI8ZuAKzTW6BBdy7CP+be1YngsuH7E6EgzCG3dMGgiymUOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7210
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

From: Alice Guo <alice.guo@nxp.com>

When building the flash.bin of i.MX95 with binman,
mkimage.imx-boot.spl, mkimage.imx-boot.u-boot,
mkimage-out.imx-boot.spl and mkimage-out.imx-boot.u-boot are created.
Add these files to CLEAN_FILES so that they can be removed when running
"make clean".

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 1024ac33be7..0bd2b962bc3 100644
--- a/Makefile
+++ b/Makefile
@@ -2231,7 +2231,8 @@ CLEAN_FILES += include/autoconf.mk* include/bmp_logo.h include/bmp_logo_data.h \
 	       itb.fit.fit itb.fit.itb itb.map spl.map mkimage-out.rom.mkimage \
 	       mkimage.rom.mkimage mkimage-in-simple-bin* rom.map simple-bin* \
 	       idbloader-spi.img lib/efi_loader/helloworld_efi.S *.itb \
-	       Test* capsule*.*.efi-capsule capsule*.map
+	       Test* capsule*.*.efi-capsule capsule*.map mkimage.imx-boot.spl \
+	       mkimage.imx-boot.u-boot mkimage-out.imx-boot.spl mkimage-out.imx-boot.u-boot
 
 # Directories & files removed with 'make mrproper'
 MRPROPER_DIRS  += include/config include/generated spl tpl vpl \
-- 
2.43.0

