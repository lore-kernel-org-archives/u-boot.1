Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DFB1C369C7
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 04:59:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6985983041;
	Thu, 17 Apr 2025 06:57:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="m6GiBS75";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4FE782F75; Thu, 17 Apr 2025 04:20:56 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0B6282CBC
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 04:20:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YFHu06sFFVbsYz3CpewTVet4G50lrJ0utg2AATRuvYoGcOmL6CmVpz/u/z7cB/xvADw2aqFwFsQjUuE/utXS99YEFoHFBEXv0XrPJSWYhZ7S9RnEmMaRp9ynIyLPkCDjRT1QShGY/KD/svYZyCaJS9/swCglsKNZnzGnI3zZiiyaHB4fNf+eJxxd6gkJO347VPIubrRrbH/O8j7255W2yFXFZQsRzgnb8zHUMcwKpRT431okpmh82s/DI/W8SKn/hJ5bFVjqSCptbIc+wmY/FdwDK6HOjfM6jKqqg8UM3Y3GNMladyYB/wqvM/Ij00q0IkEkyk/nWR3OJ72wxAnvYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVVSGD1ofmaYVBq6Y0Lx8x2581dT1Wn6SWTLRFi+Er8=;
 b=iRYW0d2oWK6jwfZy+Cp5wJf2H99pFEAMYfBuhlj0Ov3akcTrI3bakQnQ3/OYRtxd7ZvFZldFL4N82UiODe6mXWZ0RVeTgh6L6ekWknVzkFNEhTnpxNpDneIEUxIJDBXXL6qnluYrGlpaDtpR9nnRmSF3/f9bEQ3Yy/tbkmH1Xu31EdCl6p14UeitpAsiwTvY4LMZ3yglLWYlXrbqXdUkGtynSF7k6qFliXIvjk8+uV5A/aESEB2ETntHgaxFHLFVe06tXAL6CqLb1N3huQ/X3cA8z34Sz5A77p1E+AGUcZvcfgm7+DPdyp8mjklHncUvDjEPXEYUoecvp8Pbak5lgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVVSGD1ofmaYVBq6Y0Lx8x2581dT1Wn6SWTLRFi+Er8=;
 b=m6GiBS75jnMfkIF2uZCBwiHCoF+Vtlex6e39iJMgUCAlema0XhlGoTEuj/kJxWYzvjkH8lZ3bDfhPp+d2T9+763gRgRTu/zp4eBMVm81zpARNdE9cqDeEgoA2AQ9aKrNCBN+pE3j+1NlrDerIj+/aY/fXQwQ/DUbpS52S6uNG+yK3ndtPUAI7PS0Ktx+P5e1e6+XgZLdHI5gt6CdbITTs8FFo6J/VXEtATkbqp0uLAgZXzexnL/6v3ttq8JUfcPnV9Qc0kVmg05RLANp8WScBqvMPpsSXTnNW/9W5sax1TdRmflTlRakAlWMs9qRzqxwqw8a8ZXMbWANy3goXXD5Vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA1PR03MB6370.namprd03.prod.outlook.com (2603:10b6:806:1b5::16)
 by PH7PR03MB7414.namprd03.prod.outlook.com (2603:10b6:510:2ef::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Thu, 17 Apr
 2025 02:20:52 +0000
Received: from SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03]) by SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03%4]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 02:20:52 +0000
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
Subject: [resend v4 12/12] configs: agilex5_defconfig: Enable i3c configs for
 agilex5
Date: Thu, 17 Apr 2025 10:18:40 +0800
Message-Id: <20250417021840.6212-13-dinesh.maniyam@altera.com>
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
X-MS-TrafficTypeDiagnostic: SA1PR03MB6370:EE_|PH7PR03MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: 07401bfe-c764-4c2b-2d4a-08dd7d5679b8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J8WbFkXfRzQfZqqVDXLaJqYw6JkPlK9y5ei6Ja2OsAEbc3bgrA/iwX1NbD/U?=
 =?us-ascii?Q?nBZKR1jVWbkuXmkWLPYHf0BXZvONrJolOvIe+eHYA3J9mTQ6NLLgW/2X9yXk?=
 =?us-ascii?Q?/1mHfpe8NbP9ZglvbSuWNWui+YaTv/xujxBBBRqof0IEWneddnhrQ4zHNeRp?=
 =?us-ascii?Q?tZNz3bIl1SfnzAtJ/nIanPk3BL73LYJFFQ+TjOAZDPg6za9vmlr9r2CrGdR4?=
 =?us-ascii?Q?YSzZ7Fn8SU2Lc8Hv1C0pm01hBOtpT2w0TUWYLFZMVla/miwkZkGWCuaoNIEg?=
 =?us-ascii?Q?ktTIzEJPyhT5PnxiFKOjhI3IppOxwUCkHWJ1BfV6AawlO5iNMYCxrhhPrkdh?=
 =?us-ascii?Q?+y9um9maH/eVWLYa6ovpJho+UOOQ0ch1CcBggKqSqRBWxmv/j4K1aL5v6mo5?=
 =?us-ascii?Q?7jPDSvl5i/XGBrfomYX8uznJm/OfOEjBNYMqbUgcXRoy/8ay/jI0X44TJMkR?=
 =?us-ascii?Q?BeQrJ3pNllivS444NWeFJQk7TpnNFxbx8XIeB4LiXEmrqN52vC636NfkuyFa?=
 =?us-ascii?Q?cr3OdtWXnk061PSGWy7x7X1U0JdBvfJKxHMnhPbRBR8YpuDGQRIk+Eb0SFVr?=
 =?us-ascii?Q?tVaPBB4A/1VIjuACWl0HVVFn7nLqmSuim06GEn4rF7h0H8zV7Ls8flshrJPr?=
 =?us-ascii?Q?Cm1z+UTAVACWq3ZtU68s9hDlk9D65GngqVyFk9FifN1XVE/sBFnHR0UY11aa?=
 =?us-ascii?Q?MwYOIY6pBuLUAcL9otVWGKGc3rVd2ZeXpHuYOpm/+TkyzdUXXmNJKjoVeind?=
 =?us-ascii?Q?VUDqv+fA3bTk12GdbcTj/QsCXicPH5P3RZCCrGIl0cIHPkiR3NrMBhs46ziO?=
 =?us-ascii?Q?/eYzO/J8CMVV/PQSiCjzC4ebRPE2IZHh15bsNrt3RJM6U6lVOoKsKxC/CFuV?=
 =?us-ascii?Q?ecjIVIQYOjuQNPUSHsQG5VJSGrf+5gmYARSkM0uxERtdcbr5BQHg/eay7YDM?=
 =?us-ascii?Q?GMLVNIDEoIgVcx65WwEKdZ17eykdZdWL89zSIfL6ZzNl21xhpb0T94d0de7f?=
 =?us-ascii?Q?Cup1JSGO1FH7mAIpteJDkAvQ6RAuQt5fHZ/dXtEoRKa0faTWXTMfrY5SpdKf?=
 =?us-ascii?Q?n6OkYowyQBN1FZTv90JR2+g+rKJcDi6Ykyhvkwt6N/EaJoV5q1ZJkSfoQhIT?=
 =?us-ascii?Q?JN5KYqwmelcTImqSCEjf2edkUNulMN18qVlC/x7SJrCR0Rgz6/H5bIw9QZWW?=
 =?us-ascii?Q?B5lDxY1qSHBq7qwrGdE44ZnsZGa8tKnyVUnKNW5ZwancIT848cwX65fl0fIZ?=
 =?us-ascii?Q?VYW+4wPJfrhMry2OeurlfP4z6tZeHv3J+D8YA0+IBId+Ky/LJpTBtfe9udUQ?=
 =?us-ascii?Q?+3BZVcwuAR1jPFt1bCOpf5r8XP1/iRrIemo8srLIEb7hYiEz0kVjQgVsyvNv?=
 =?us-ascii?Q?mVdhQBB9EEVNBPGhL3705djg27A9w400CtUpMrOeNBD/e8v8QWYTuKNeA4yC?=
 =?us-ascii?Q?0Ple7CfMIMw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR03MB6370.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bonQU6HKKDllMgPDmHTYRrQSdhf0j6JoELfHgsmSja70QPeCD1AacPWuqk3o?=
 =?us-ascii?Q?zNBzQf3ybt+HEr0Y37KzLtytPm6u+vCID0eQmIkwk5QVh71znrNei6O32ieF?=
 =?us-ascii?Q?6rzx0UOvrfImIQ+J7RK62Q1BgEZ591fe/TaV29nrfN/eZ4LNolJvD8DbcpDo?=
 =?us-ascii?Q?h7XA0yFmcALFmv/wb2I8JKSW45WSesm1m9oF7ZPqIVUjlYsqSTYzubE4M0KY?=
 =?us-ascii?Q?bX2M6Dp0QAOB9wFg7fHVLLQNHJygoPIVze3X1wIadTnhjPRK4mi63hqoauMB?=
 =?us-ascii?Q?kYrNFUKPq0Qpmis5HawXK4N4WDyfe6AjBirIV/0lW4WLxq//9LVl8sPT6PVm?=
 =?us-ascii?Q?kAf2exr+/66NN5VxsIwGsN+1nRhqYmrc1yOtvYnMLMcYQCSZJgsuBgIji2r3?=
 =?us-ascii?Q?g6UQZeQDCgfa8CwrpLcPVLX0UsnDCsaoIn5wLtHcYR/kARcmi6YTTgMe+CFJ?=
 =?us-ascii?Q?Xejcjk8jIPf2cyNqxrRNxbl6XgjvjK3gZE1qiaR6SKCpRi/na/g/os14OCOh?=
 =?us-ascii?Q?xol+oexAd5MjAvjcIgkJX2w2feWGxzf7bFisnKPkoz34wV1CZ8TA0xBOWWF5?=
 =?us-ascii?Q?70i7OCRCY1DdEP0uywvdITd0g2eCjf3cE5otjft27xpn2czmRRZLZCM6I08K?=
 =?us-ascii?Q?yGYAGSx5vNeikPv/TBtgIsF5qsEJJYJeWr5a0eBsVdV8nKE2LeGRCjuc2nfZ?=
 =?us-ascii?Q?Hzct8kEp4wFzibvyRDHrGMAXkzgRXBVFQyOpN8U7yBWhY97Q7Qey/21dAV2x?=
 =?us-ascii?Q?dzS0gDnMxBZ1CWDA/3DjL0hd2KdTcTj1k7jXxYQXgKZ9TbsAcYnBsTjYqmBF?=
 =?us-ascii?Q?AU2mroJQlzIfeJqLk9cB0X3E+A44Br9l2XpY3R69F4R7glSkeq1C2PXcRtU6?=
 =?us-ascii?Q?kfajHaID4lzEFjvyip5ozkkw5sTMD4mHKZLicmBo5Ljs+Ik++RCHNxI/ylj/?=
 =?us-ascii?Q?WvQD/xVjSGudU7mtj9u/nttNUJ46uK3r2xGhiaDlRhysUpFEbfIVq3G5mwGu?=
 =?us-ascii?Q?7aMtn32A2cmmmROtCgelU/n8wlF8+rGFCQ4BkesE1VOLmN4ww2XQwMuC4y2o?=
 =?us-ascii?Q?VkSlrVKtitAboJIw5/nwvy3YAnNTBJfCjS8XvxXlrtVysOW0GBUJmXmx5l2q?=
 =?us-ascii?Q?0kt0elqz7zOPK1/CXzbHq4ouXcVNQMFadb0Bg2UirpWzgChxLmoQm8r6NUgf?=
 =?us-ascii?Q?EyR/bPdQNuFOJC2g8WCffYwSlnu76fansiDKuciSzUnd87oT3/eCUE40YHoc?=
 =?us-ascii?Q?ncRNIRUCU8Oif1ljUPwsRRgAoVAIYU1jl7sGGBMgziDDgpnjTcj/G34L40sd?=
 =?us-ascii?Q?aQQExgVTDx1vCdpwXj1Tg+sPxI1uQLyg6yINWh2X/jW53DvjpJyVQeEOURq7?=
 =?us-ascii?Q?eGH9un4mUIbHLL3q/WttFgz8dXRPeTJOsEsV5n8nUAF5koh83K11LQnt7ey1?=
 =?us-ascii?Q?zWV3NPPH81nrTiMjQtokvOW9Y0DarSd760pQ6q5drs6Yf+LINbk0jT6Cyoaf?=
 =?us-ascii?Q?Gl1XhvpYJ7+3fDA5pUM2FnvMEo/nJGoOmFeCJOixO9DlB3ivYi2YB6eXzczq?=
 =?us-ascii?Q?b6FUmjRxrt7wFm0ND8yEN9VkGSGMFjjfp9gCzfmjYhk2kinwdeVJgO4GPmQt?=
 =?us-ascii?Q?2w=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07401bfe-c764-4c2b-2d4a-08dd7d5679b8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6370.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 02:20:52.1980 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dGhR2At5pw3XR4vMfrloCIaOJCh3Ddddj6GO39DCSK9XSTeRepaQmF5k0rpLIgVNki+DNYchRpopX8/it0trz9uVJSiRS3hS+LbXSBtMpk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7414
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

Enable configs for i3c in agilex5.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 configs/socfpga_agilex5_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
index 8577ac610c2..87febc9f4ce 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -44,6 +44,7 @@ CONFIG_CMD_NVEDIT_SELECT=y
 CONFIG_CMD_MEMTEST=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
+CONFIG_CMD_I3C=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
@@ -66,6 +67,8 @@ CONFIG_SPL_ALTERA_SDRAM=y
 CONFIG_DWAPB_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DW=y
+CONFIG_I3C=y
+CONFIG_DW_I3C_MASTER=y
 CONFIG_MISC=y
 CONFIG_DM_MTD=y
 CONFIG_SPI_FLASH_SPANSION=y
-- 
2.35.3

