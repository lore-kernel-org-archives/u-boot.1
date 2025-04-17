Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6561C369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 04:58:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F03C82AAE;
	Thu, 17 Apr 2025 06:57:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Nt0bJC01";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 322D982F8A; Thu, 17 Apr 2025 04:19:42 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2406::620])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F90E82DB4
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 04:19:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dpQTk+gXYMfeHsYBeb+vCAU0G5mlvtDNDRbNKLNb4PNzIhWe4vDPFU3t4ITRKTb0CV9FYzV5wDiauh74KZS6s3yA6R/vIAhiT0Vr86I7aQvXBGllNaR9GGkakEJSKRqrm9Ug3M0QBe2rQ4CqyCCUAZ+eTXF8D8UC4rKkPYrrdHD4418vGxlVf1l2eO27LqEZpkSsUsYKrcwJ3ZqOwclgQxmknMOPGH6/T6Ekqzayn1A5KAek6tj/nK2jGEAIYeJlz+iMHCDXSd8uwoG91u2azxv92GhMpptHp2ugAjSdJ52DUkxI0QiaLKbFoZUeObX5j+9KPYPiYrHwSI0+XMIm1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pycb0149pvnjEeA3lg7JREnRc/Vexp8Sx5jbURhzWsI=;
 b=yZKdgTRIYfcseZSScrsdPDxb/LWefaAW9qeZaZVM6M7SsNF1APXVPx6n8e15L8Bx8x+B9gh1nI7uHDCVZ6O9cX2GDfYpcojaGnuRLCb6agg82oPm+3lirPdbwive6YixCvs3eULSOHN7bLe6V06fodinFKHe/UqT2sZFhXw8zvARVBrcqyNpSySlJrTMkZXvmjcoMxmkTEqDXg/kCzKN3x/BL0bVrslAJhtTvUVOtQPPQKf7DSZhYRRBj+Nd90ACGzE96+SjbVchOPoOriMYqS/fnzwbLBMXA0RHt7oovckFNUOImjP27mcZ2Zo4kLCJbwWWr/oQRdkSlEiZpFFfeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pycb0149pvnjEeA3lg7JREnRc/Vexp8Sx5jbURhzWsI=;
 b=Nt0bJC01ny/vushxBPYjfSQC1ELgomi8tD3zAfo6IRgi645n7n6qfG3mJqUFzq2jCKP5Dsb7PC/gT98bQXmP1B/h9zA03X5hzmPVuOD7XLCn2DAU0+OaSBzMSg8Vk+WwfAjS0Z0P7s0nNpQME5SfiZN86BegCa2KEVBxrueUVtw2C4wXwI3DX2jDUxEJGRCswztmgUdkAeUzUxnQ5eb9yOAtTzNeA7WscJd5DfNqtZRt5/zTUcSD9Ogprg4ZZUbPNTRPbzbQ4XWh9AeG4zOiMKx7HqnM1TkidNxhF2BIvdNFsDAh/5a9NquELh4atQ2RmKL3R3KWNqnBQ3k3TQk4Ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA1PR03MB6370.namprd03.prod.outlook.com (2603:10b6:806:1b5::16)
 by PH8PR03MB7197.namprd03.prod.outlook.com (2603:10b6:510:25d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 02:19:37 +0000
Received: from SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03]) by SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03%4]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 02:19:37 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Sieu Mun Tang <sieu.mun.tang@altera.com>
Subject: [resend v4 01/12] drivers: i3c: Add new i3c uclass id
Date: Thu, 17 Apr 2025 10:18:29 +0800
Message-Id: <20250417021840.6212-2-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250417021840.6212-1-dinesh.maniyam@altera.com>
References: <20250417021840.6212-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:217::24) To SA1PR03MB6370.namprd03.prod.outlook.com
 (2603:10b6:806:1b5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR03MB6370:EE_|PH8PR03MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: ac3b3469-612a-4e5d-a2c2-08dd7d564d3a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/XUBUgEhDRsW2jNFjsfwziCE5wluP4AlL0sfj9tNNgv7LpFwl7Dw6jfRe2UD?=
 =?us-ascii?Q?o/BS+00PmE1PO6R7aL2LEOczZS5ppgt0bI7UjkpG/DNcC+KwWnywmts7qLxa?=
 =?us-ascii?Q?w+Yt3pLImqCblMNdTaxArwLMt8y8EXAW2ev7+nmoMl1zTeQ6aDFTGmbxAP9G?=
 =?us-ascii?Q?nsPqLfnFSv6VqkHz1taat/MXaeVxUmNkHa9JhKtoQ3JWP4VaMhFOp5zqY8/5?=
 =?us-ascii?Q?y/INrxxLJeuGhcydoNge41Sajth6sT+Jcxqgr0GiLhxtOz+kqFebUiY5Fx6u?=
 =?us-ascii?Q?Eop7tM2aBMX7AZkjMnODoHb35lSs/K56mRnytj8BDji9eZxnOztZdcFuxtgX?=
 =?us-ascii?Q?GMJW4V5lGv1m3KJyl1QwAd3MBzjNsFjIycDn0vOo2XnRvq5aCnKj5juA1FLC?=
 =?us-ascii?Q?WNHr3w8U1hqFwEytMi5hzaLHP5k3PfzFsBT1KE+C3r8OyMwhglE+sbnz/zF0?=
 =?us-ascii?Q?5o9hbKpS3JLlAdp0LNnB0rGY50t7RKELZ7qPWrG5vu3/OhBZzdskYOu1BZOG?=
 =?us-ascii?Q?jFACjYy04WxFnM1wPKiPjRd0KiSKoOGwEru9TsKOeoj/Xnh7ZhNg3FBhTDUH?=
 =?us-ascii?Q?O0ISVJPjYebwsX2pA6tmSwMjvHsaKmXHEEdTwA5Y77n/zSCirOALGwtMY/Xq?=
 =?us-ascii?Q?q8+WbCNTwNidpxA3D/QXUsletYmC/5tC3qTHr6m9O9DpIc/zw+mSfEMSmD0h?=
 =?us-ascii?Q?7G6ajedR5cYnK572hQmSnMJMf9EcXaz8QKpfwwF3aYlrWpbl7+kFnm40UNSx?=
 =?us-ascii?Q?VFqXs1zLFGbn4lrxsekPXh6h2hbX5UXg4aA1WiZXatCvQwJf4hfKsHAuhl2R?=
 =?us-ascii?Q?m4fpansCqgdhnuljk98wG2w5twq4cj2Zr0/NQaaQjdQwxuUyhrjMeu+AtsWe?=
 =?us-ascii?Q?Lv5epeqO7F8tRuK+RtypzfMPbfBfGEBh7xJ8IFDapiwXNmJtxwJoIARlC05X?=
 =?us-ascii?Q?b3dVFKpxNuCAFF4zfYbxxXcf41SspYEE8Yibr8MzHPycc0KVk/uSFvw8k49N?=
 =?us-ascii?Q?7DHDTlTfr8Bvw5fzyM0nON2gSCczOgAzxjQar1Hs10gLKQfDxDkjEO9fMIaE?=
 =?us-ascii?Q?ypifLLMZqFLsyXGUeMR8q2byeoqNrI8ocEFhotWUDrik4NYsWpsAjyHQCsRC?=
 =?us-ascii?Q?eOhgM7/N4I2O/kZQUUqw2JHfL3hEtNAEKthSLRL/xa9CX2wm5/HaNmrYD9NL?=
 =?us-ascii?Q?53PEcahoozXOtw3s0lEtL8ZGCSCYthR/4jncaDIT86mSVLsjCWOXddgCEIyN?=
 =?us-ascii?Q?ovhC5wwOeD2KswFji0XfiCOLqRTbwGAeXCypEPxHz1RN0wMDtlagI8LmmZlF?=
 =?us-ascii?Q?AUHesxy7O7WmFpBrtFBPWtppe+LxCQITvCcS9l2/jjgZ7CvDFcla0vOZUPW2?=
 =?us-ascii?Q?c4ERVVA81nOFocuxZb58k8o7Y0gcYjyBg/S1+n25akVBwauOC3GT8SAPGInA?=
 =?us-ascii?Q?6j9EsYz0qLo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR03MB6370.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f3lNJxrnyF0j/EISXwo8+/PeywlpE7K2dVoNLwJR5+9W0pn99NBtNBhoqA20?=
 =?us-ascii?Q?mycRT9iKcIDRRPfxJ4TC5MsnI5IYSzfJn6/tYyyani3LA5dGxKyWqkf5nmDD?=
 =?us-ascii?Q?M6YNn83DVkxMVYK2jxaTCeoNZ76a5sl3OUMf1xOq2WnRt6eifRXdHkHCvbEG?=
 =?us-ascii?Q?sPHf9xaaiAtFF4ItndYaljL52dtTT/TmyhJJzB8PJfC7urOvZEKJs41Baafz?=
 =?us-ascii?Q?YTvetNqAW9e3C3HcJNmqlmVYFRSfuX2RJ3r6GMQ38gtgu4wFmqDuqYCyh0do?=
 =?us-ascii?Q?yuaLbxyaDrP961CTlTBbTIrqNSVyXOdtpGFetu24TpMethJZppGOjpE7Krvc?=
 =?us-ascii?Q?p1TjAw2Gzxy2g+YCg5/szUx9XtCwrlFp95mB0AGV7F6CrwiBBzWp04RZhdxa?=
 =?us-ascii?Q?Djro+ETvhcrO9eklgwZsbS8CfLbahiFGo+pzVGOS3wxm0ktgHgt9QGuZ/23k?=
 =?us-ascii?Q?y8HNIPSIJzBLbsYTTStbS/QCHIjELWXcKAplpMQZ+bCbhTrarRGuRguLkEqS?=
 =?us-ascii?Q?fyl5HEBWhfcBNmehP/rp4Y1GyhR0/sigYUAouL3H8+MGoRdDYU1E42ayX1CA?=
 =?us-ascii?Q?Jez4k/vgKRT+9IOqcaxQnQE6iGVqRZm4zmsTplfF+4V4DGLFer+7QrKF80yh?=
 =?us-ascii?Q?mH5U3R2BWOaFHprSqDQxKMzHz3FgB8pX6FgZ3Pgkl4iJSUi9vjdIdjnCGXAF?=
 =?us-ascii?Q?dr/QqTbsMJJo4BmUMEkWciCWkROqutr0tSgvYcCh6wh2QYhzg8jh7XvBL1mQ?=
 =?us-ascii?Q?ZxTuiR5CCuUqUbiuhIxW5z63fOCRE14hATGXqzfp7uEB74gmERYhM8qR/vOe?=
 =?us-ascii?Q?3U1mLS5hayKwNj3az2HnwEb6QEGLAEUCtR2VENGMstNLdPK+BmbmTWJ94zZG?=
 =?us-ascii?Q?Wzeznq91Hg/1kxAnhMuXDQI3MOuFjeu6/boMYOAPas+V9sQk+IesoMSdPot9?=
 =?us-ascii?Q?UDHPxBa7oPtCJ6P0p+TwXLzt52yZcxp0f3n63vbMvcp0ju/l+Sanh81SmUTT?=
 =?us-ascii?Q?lROBkwr/xh0pPiLURJH9JxE2qf/BoOTwlm30SFnO+vRFr64my0cbfeJoaXqS?=
 =?us-ascii?Q?mrS1oobDbDgeiXUwALIpr/QLV4vXa/DlFAoDRAb+iHeTRw0pmsq1yF8cjEj1?=
 =?us-ascii?Q?wUPsCTwsBNBKMiHcTnyOdg8/lfDgRC2w1LrKevirgFiaziv4df0/izdYzgiy?=
 =?us-ascii?Q?mZMJt2kNL6hvv7SC81NwCUiI0BWFjqLYAaUk7fjUUp9NjlZoqHvuxryBCPMq?=
 =?us-ascii?Q?caLev4GEFSEKCS06GZAwwRIKBaBm/ntympWOQs8Bb7NVF//SW/QH4I0RcJ9N?=
 =?us-ascii?Q?BBtgbIhL6Qz/tSwHD4Bhuzkyae4CHiaGKGgR1VvIwpdGDLibz/OixJXvBlLv?=
 =?us-ascii?Q?Mz582sr7AeQu4xtvegnHwR0a6uFEmYSdKRjqMOp1oumqFjINxYQBvIXOHsgs?=
 =?us-ascii?Q?ztblj79ge/ovIOBmPBbtyWCDBgR+DBj7zgFpdhNuhDBmdpNlEtp/9/M40Slj?=
 =?us-ascii?Q?UAL9nkvUFwzHc79C53z1cng/82KY5Cal0mHgcWG3zgBacv+S4Yiq0amN+KBg?=
 =?us-ascii?Q?tXNsyGVzFQWHwhCu6skelF8RI0t6gI8qbXSUPZoKOI8G5DfPJeD0wordjJ4u?=
 =?us-ascii?Q?rg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3b3469-612a-4e5d-a2c2-08dd7d564d3a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6370.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 02:19:37.5540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bYKFe2N3E/FdqLCHwpT/uTLbs6VhvGuAZJkJXAbOv7YU+REniGO/li0kLIPL6YnekFkxYWe4UZjExDzGHP1UbGZuQ+Fz9kCIM5NDZ555xHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR03MB7197
X-Mailman-Approved-At: Thu, 17 Apr 2025 06:57:49 +0200
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

Add i3c general uclass id.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 include/dm/uclass-id.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dm/uclass-id.h b/include/dm/uclass-id.h
index 270088ad94f..1d259b439ff 100644
--- a/include/dm/uclass-id.h
+++ b/include/dm/uclass-id.h
@@ -78,6 +78,7 @@ enum uclass_id {
 	UCLASS_I2C_GENERIC,	/* Generic I2C device */
 	UCLASS_I2C_MUX,		/* I2C multiplexer */
 	UCLASS_I2S,		/* I2S bus */
+	UCLASS_I3C,		/* I3C bus */
 	UCLASS_IDE,		/* IDE device */
 	UCLASS_IOMMU,		/* IOMMU */
 	UCLASS_IRQ,		/* Interrupt controller */
-- 
2.35.3

