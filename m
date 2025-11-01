Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD7DCCF9FE
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 00:48:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39F2983C34;
	Sat,  1 Nov 2025 01:45:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="mAE3H+dK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2183583B71; Sat,  1 Nov 2025 01:45:37 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 218F583BF1
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 01:45:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CgYyrXJhXkgpUHe0bdZm8H+Nt/JnfmSOCkTdt/PMEd6gPuYmTIszk+yJxWPDxNxKaX3eEqFXzyBxzbR/83wKUGH+MEHq+ujr7NPfuUL2Zt7DT10ZPRO4plzKrHLOO6KYX3Xs3sHdZPRkN11X8gtqMmx0QYUqSQcj1wNYTIqZpvaIyCbb5RQyJeeZtioK8vN/aKesHvgl73AJXUH985IwX5cXLMkXYnCkHjoOYsaI6sEfyy7hmn5ScVZHWbOE5TKrjUtO9HSPd6xs96QP84a/ftloF4jfUcRdjMDTOEDtZZK7axNKj+CTazdvxJzkpAZjLBpyuDn8yrpnXBcuKXKNOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8jBzjQ+tM4k/lUvuwy46XN65TWDsHW+mP8xxSyEvxE=;
 b=kl4VwoKDuqlFt6KlZgZXxtzKMXrFQ/jNqGyMWy+jBcF9jxaqqbTBlETwXDMEZNXubUPxCTIxcNIXGe5/T7ltATaU3PceFxqNhZDPYaxQj8v1VgKAtE0Rp6edocd5NWhIA1glUD8Y0qBLsJMMCvwQdi6phz8Xb5Nc6EUl5pZIizHuu1poLFJG8lnKPW5QKke0Ij0N2yRf8w54AdXkkvD/AhfjSazqfFinDZazvbuRH1cHNeF6T6O04UEc+OAlRVeelRgvPAGwVTO+5zEfbT3HlLTEwXHbU9iwSds7jo6F5D5FD3RXWuWMWBiIlQ8DVaR7td1RoYlI9/iKzFQboOPgIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8jBzjQ+tM4k/lUvuwy46XN65TWDsHW+mP8xxSyEvxE=;
 b=mAE3H+dKSQatikTJIGUn8YBN/T1aN8GHTPWp8Nc4maYWN35NHyidkZk4tACndB84SzrSqxICXQLf/C7OGskwmV96gMBlgNaUxh6Pz3xRjvMCxcQiFwZztOZov6IX+aS2WL+pyp4oW61wZV/CYaIcuNDTiZ0XgHP2v3Fk3mfdz5/a2w3aruYG86r3309Cd6D1ogcnbutzDdA63FVOHU3UOKMiwsArgMiyRwtl9FZYe5FL7ropstMXmSLnLxzaW1DyzgJ0q9h7wSix6IzOP6LcQ/7dQlyJFP/jZEs1m+M3y3F/P0Nz7SvtlvEhlInSQAeI//8hOQcGCeHjm1S8NiVa+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS1PR08MB7586.eurprd08.prod.outlook.com (2603:10a6:20b:472::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sat, 1 Nov
 2025 00:45:30 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9275.013; Sat, 1 Nov 2025
 00:45:30 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 17/19] configs: airoha: en7523: enable ethernet controller
 support
Date: Sat,  1 Nov 2025 03:45:01 +0300
Message-ID: <20251101004503.2379529-18-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251101004503.2379529-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251101004503.2379529-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0283.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS1PR08MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: e1fabafc-ad04-4a2b-e15e-08de18dff546
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/3Op+5WXfNEAN4bddPXhD3PYUuyqfzWBKowsfx36DenKo+ktv/lICWYcdoQS?=
 =?us-ascii?Q?Tq2M5/e5jqHFpEqjFeew5kslv4j0aRqpmtClL6jC6vCDuhCTzT5NNOM2cfVk?=
 =?us-ascii?Q?rNkp3X7ieamaX9iZaEONKXuAaqZnvvvDR11F/VTO8/QeEXuHfZaX1dfeEAT2?=
 =?us-ascii?Q?+PYol7tmmOlWDnhBSHUljhZdMGHMNaKX96olqmou2iufWwPA8jdzV5yFFVIP?=
 =?us-ascii?Q?m5MKDmzaQ9EbIy/Z83vVdcaxUfPSB9YudTnm91WVaXdODyMJJU/BLMHLXSVo?=
 =?us-ascii?Q?cBOt3Cm0w90jc87pX6Xk6DdsxXMikh2AGYA/DCSAdFNXL9QHuX/ZKYA2GaXZ?=
 =?us-ascii?Q?+fS9XfViQMU4KPLVKfYCqnveHeQUCOXijkGChCnNYs6B0+5A8jT6QIlYuDvf?=
 =?us-ascii?Q?SVplYb5xssBGVeCUkU9//qyYJz5ZEq4amBHEatMWZUiHjM2gJpNxJTKX9kvc?=
 =?us-ascii?Q?EL0BADK6kW3KhigR1ncQMzwhQMCG4YTAx85gef3KQBPRU4RnLxjuQPx/epPi?=
 =?us-ascii?Q?ctjVEMTiJhDVBVFbjwfUZjVsW8LaLHOKgufQLTtKAUN96hoj1nleWspVqrch?=
 =?us-ascii?Q?ywoCMBUTSK+241g12wS08BdfVHndtLlh6hjiZp/zI5xh/dayDEK4gZCkoA/c?=
 =?us-ascii?Q?qclv4wEiurXXw67VATT9EkbUBVPnCqOG/GUYgINaN7uVCY37Hh85Bo/cDEa3?=
 =?us-ascii?Q?kCSPbYuyXxVuzLIFqbDvVHv02epcjCapCx55HjMR5utYPzkXbrWLXuY/qxQW?=
 =?us-ascii?Q?278z2vtxyT9q3pWkJvRMBcOhLaBeq0sOPJSXBPBRdGGxFaHBaRRS+bZ+flO0?=
 =?us-ascii?Q?ueZjTuTfOjouAce4qr+TnlS4yNy/MAxp4zTdxP0OQlbN6LbfbW8GQDukA5Nl?=
 =?us-ascii?Q?R8eXMWWAmBJcnbzE0I4x/sUFIL2/OaxVWw3VxqKAuuAGo0+BFJqANyKUIMmS?=
 =?us-ascii?Q?Aw72R7X6Vd2URhiDbyd7nV9j1+NZw4FmT6/yC7iLZlaVlh85hwlaJOR8UCF6?=
 =?us-ascii?Q?9o+A+/w6rltuYLXA4DPBNzUO4kCx+XN3ECfU1Zoq32RFwm1rTUF/IVnA9DlK?=
 =?us-ascii?Q?EYHll/SFLHM6BAXsjmoP0PvQ0n3cPs0VrBu/giolMLKTozP8L+ROvNbTfcvF?=
 =?us-ascii?Q?8YmM6HXsMLo01BvbZhgSS/3aNlCaS0Y78tEsbmqGZr/CmQB8WZ0Ok9IpAT4w?=
 =?us-ascii?Q?vnq1JCM3oAspvGsHlczUrQL4ynAAWeiUHd5qJRQ4AaIsw/QezacTCqXW/Kb+?=
 =?us-ascii?Q?Rut3zwyXs+bFmYhxsYF20qnB8fAvFHdOuGlyv+8VycYSu8EG9lVJaV0b1I8P?=
 =?us-ascii?Q?LOwPnSmXc6evkrrgShv+ahKUqnNK1z7FqKwYnPBo9VRa6fGcYAvuW3m/Bs3L?=
 =?us-ascii?Q?ZzjE4kmVmXz0IjIMC+j/Aun70UG8U4R5hmhPyykYqma/jcDEvWRvUeS4CGtB?=
 =?us-ascii?Q?rOO6R0+zOMKs070PKIcqo53LrIRJ+KsnGZjT6w/L4WRc3cbAAhphMirTFgfT?=
 =?us-ascii?Q?LhwZ+rcJiRd0o86MQ8DBAiYvtFD4pOLpYvdG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8/+XmbePQXOjALCzlVxMgsdW4gcgMztH5voNOygM5+N7mprPP11yorUbdo+v?=
 =?us-ascii?Q?eJMxgaTYa8iKDDcbUMdsrN+bRb11C0j+3jkmIWAVswYybT+u2g/D3VB3U+BJ?=
 =?us-ascii?Q?jNoEwAZmzO1JwHHZs7QUVN0ZVluRKQc5x6OFNTCcJHcVgDVOvdC0YRR1frn+?=
 =?us-ascii?Q?lPIttvIjaCxAKxHMjdNKfEXZXuv93HUeZ8uDBREplpiWn3DrfvF5N3hWRMWm?=
 =?us-ascii?Q?vopfEigSLxexxRboS64ayyeWlssrSFMkFD4OBTkPpPSenYGpEtS1lavzO4GF?=
 =?us-ascii?Q?YplAYYelHKOoFqM176PSaahPDQKb0aVETGutLQALUOO0tvLkt3jcDEKWbOzr?=
 =?us-ascii?Q?5m8djLbsFX5ovFGfa9nBWTRplDThihsS42C0tb65FwUWWO/P9IKYodFm5o8T?=
 =?us-ascii?Q?Q2aGdzmzBILrAzldpgk7oJLv63AXVO05qqPNiot9Eor4RQbZc0+mGSFCX9r9?=
 =?us-ascii?Q?Ow6nKdvjODHF/BYIepXEl4zBlf/YNMuPFkH1iaAS+0GZaq9exRiGaOhQm6wy?=
 =?us-ascii?Q?kwN+PTO/I540q+uBZ4pdcXSWE9XOMbqfxzyo8eQQ0hzum+/K4gtvXP+5/0j1?=
 =?us-ascii?Q?KrhKlotax2AB+ETzaspoSUY9k4u4fi/C7Nt8TrJXENbp/bomcTkKvS/NxPsV?=
 =?us-ascii?Q?C2NzI5ioMRf80I5YOyH09BEidAVlROj1SvJPhdG1+/fdRAfGurqzpdtUDLdg?=
 =?us-ascii?Q?/ka8dxDXlyW18KepYq6MTTkIzJj0QgE6hkuZVxYE2DtTpW39AXXPIgs6nV0l?=
 =?us-ascii?Q?tcZsyrYXJnSKpxJkK8Cr3Xjgg3LTNT79vwskSSV3r6LHs00RPer7rBPkERMM?=
 =?us-ascii?Q?RWJxS6w9KBB7L/owT4EFBl4S5vwpW8zG7LCE/DNRvhQbF3+lMl7CDQ2dwE/V?=
 =?us-ascii?Q?YSlJdBRbZX9/JKj/w37E5EYYwS4WrXLALe/+lziD6iz33rpMzD8vN8MzU4Na?=
 =?us-ascii?Q?+z61oRv+Yvy3EWKk9i4kPa9ZRTZPaclEnzHhhzpD8I1dxuMIFb+2Ltota1TI?=
 =?us-ascii?Q?jZj/FhnrQrD3oigB3c/2pfupehztGW/bB7a+6TdPc98D6SrsQfQt3aAQVPGh?=
 =?us-ascii?Q?+iWFBm6ci8MkOdeMKJlCZ8QVZSNPon05b82u8hIeQX4M5+KNG5u0vfT7ckDL?=
 =?us-ascii?Q?ypDwdBo/lzNQkL8l+QrOX+OnR8wsbsl8LE9GSj4cjD7TB0zFVsC7cvcPAyEt?=
 =?us-ascii?Q?qS7TrGnYRZEbOTVG6cSN6clH2rgW+hsMQk1Mc9TKmkVw4l3lXkBM1bETIBKX?=
 =?us-ascii?Q?AUfUxjOL4Ya7r6aTHuNPVY7wOi872chbYtodHFsSPIhugpW2d5Py74ZZS+Iu?=
 =?us-ascii?Q?Z0xXC00O5Ays+nNsr938vuA9zjEaRCXR61PakyEBQuAf0AQbXiWAykW+F4Sz?=
 =?us-ascii?Q?sNBGGzSEmV2AHizzoyr63soeQyiYFPYMQTeuPulFhrvrl2nCfOrzk2xZf1g4?=
 =?us-ascii?Q?5wQnf1G0hU239TtvyjxauWVuNNV456yd0Qpxpy9vL+aX0o84Nk/B7FIfKQJG?=
 =?us-ascii?Q?U6/+e7GXS/cEoCp0/7hDtxbxNuKxFM1Hys6BLLG2H39Vravys4iERMViE/r5?=
 =?us-ascii?Q?/klr1XO5INOfnpdzbemUgjf4F0xLdzHrNccgVyVMMTv5+OSfQf8uq2FW74XG?=
 =?us-ascii?Q?6/LPnQNu2Z/anlhAclU134E=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e1fabafc-ad04-4a2b-e15e-08de18dff546
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 00:45:30.7436 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7FiUMYnSGsYJbt/nPlTpWNbG4xF6BnT0uq5D0LMTM8od+G97jGliBqMVcsilfkrlW3Q/UmVNzEDkm1TjtMRwSAc/RpuYSzF0DIAfqfx/aus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7586
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

This patch activates ethernet controller support for en7523 based boards

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 configs/en7523_evb_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/en7523_evb_defconfig b/configs/en7523_evb_defconfig
index 2a57f50e851..11b7e85f731 100644
--- a/configs/en7523_evb_defconfig
+++ b/configs/en7523_evb_defconfig
@@ -51,6 +51,8 @@ CONFIG_LED_GPIO=y
 # CONFIG_MMC is not set
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
+CONFIG_AIROHA_ETH=y
+CONFIG_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
 CONFIG_RAM=y
-- 
2.51.0

