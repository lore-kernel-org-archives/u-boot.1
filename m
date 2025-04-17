Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A35B3C369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 04:58:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4269A82FD6;
	Thu, 17 Apr 2025 06:57:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="o+C8A8FE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DD8282CBC; Thu, 17 Apr 2025 04:20:10 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2406::625])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB29982F85
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 04:20:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IgAEY71WqRq2jxBrWPgoGTzjFwXSWGQlogLLJYgc/hWVBWIDIuyyqIgbs+Sv8WwDb2yRN19haOfnx86UgoxzWQpy+upqFknOM89dgEO/e8YDS/mN7jiFUbSa+XS/63IVtxQ9xhzz6iXa86oSooYSFZYecYFcvEjrmKUCsF5fkQ3EvpMzk4BRSbqjsmbmi1khdSVyWDbPVLU4iIYuNujiQ4Ye44yw4BJ9dDeV3jeHLQIi0/EssIvnJTLGO8L7ssdz4vWHu87zNwItYl/TUZVpuZfhZMB/LD1qPxFqeYyvanvRI1foIsc7SisodN2oq786MIt5HVn0y5YocyX5a8jbCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OtDFAJygkc9b73XrQKbHD3dLP0XAo367x/NKJdD4Ecw=;
 b=KR0omXo08XzaiKgPadbdysGT6pr02gghCA/CNYOlFmcbjso0ZZ0Wg7xENx9qWW6P9LudNRHPKehbOODQAFwWjFIoISX/bB/IFaGq7MNnnGD6pxHtj9NxKfLZn6syDqghdwF6UA3rMs/BE3ERz1bbz7DrCHViOMoKfTpEjiqAdHostJTMsFvegZA9WYS19m80h9OgOj0twYPi9FgDBOIvrjCO8xGeixr6+LM3aovDu92m3JY2KKGEd6aFwhj8EkM0n3l0C2c9rV3uRq/pIsbHjSPF6GeA0rJxzgh6ZCg3EFjv7A9jIaa8tWgmlEYXKdPAR11b+qXmZqzkULt8BnxALw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OtDFAJygkc9b73XrQKbHD3dLP0XAo367x/NKJdD4Ecw=;
 b=o+C8A8FEiPlBELx5HPNWJ7m3NHx4UMA9GNcm3lfO6jldcyjVgvMw8U1qIOwWVOoFFPOBQP6JpCvCEdH4xSnkprl11i4MVOgmewWK1YFnIadZpnJul7ETbw0topziIUc1IcakPvsYyM04FQaVkXaAgRWOoJybfMa5ieyZMTirf0fslSqPvsY4O3w74yK2YxYj6EDvv/07ZxKFVIFKyMx3CVC4f0ut6oe/v2K0BoKTz6y1DuuB3Th/G09fsMGiAvE9iU5/VIiPgRHoDim3g8Z6fkmj9M688QCt/ZTlvR0Sumk790noreg6aeWLmFaey1HHyu0w32ycfmHvetqJtOUqhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA1PR03MB6370.namprd03.prod.outlook.com (2603:10b6:806:1b5::16)
 by PH8PR03MB7197.namprd03.prod.outlook.com (2603:10b6:510:25d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 02:20:05 +0000
Received: from SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03]) by SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03%4]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 02:20:05 +0000
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
Subject: [resend v4 05/12] drivers: i3c: Enabled Kconfig and Makefile for DWI3C
Date: Thu, 17 Apr 2025 10:18:33 +0800
Message-Id: <20250417021840.6212-6-dinesh.maniyam@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: c8fcaf36-5e3c-46e0-0ca9-08dd7d565db2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M+u5MCtl/H4QDJSq7G8KNyh2Zyg27aPAhUU7RsR8Q01JMqLQ1tOlF4vB/sqv?=
 =?us-ascii?Q?B0koalnhq+iukYHyJoMeQN8AA5WqpLVsFodJ79wMlDP3pSMOycNZoMmH5H4i?=
 =?us-ascii?Q?Aouj+yL6bTVQt3nbzqFVgcB6nXj8JYcMJsZRec3WIM89WTNVYu9ZYon5wfXf?=
 =?us-ascii?Q?KrnVqMiqwJw1vUOCzsKLKvGylRSWHN8Fwq4t3Qr7CJEqm+4KVVAKmCkZgOEm?=
 =?us-ascii?Q?QnL9hIBkcpYgd4fHGiVQHUVUN01BtDpuNTljHGj7QIcOuNf1Bh2Qz0y/QS8A?=
 =?us-ascii?Q?YrxKXdI0AxkIM2HUwPQBpDI3s606EArSM6UVAQC2Xc4Cc1CuDVSUh6bI/nn3?=
 =?us-ascii?Q?GlNlGcncVrO/A0p1pS83fT86dKuPPTXv2/YKVuCjB1Dx4GGOBxl4/5Qozx0n?=
 =?us-ascii?Q?kAPIvzbXGPVZOYdDkPgCYYqjmpkxXrayqDiPCH3gOjpF2lVktZHZgcHwHiyY?=
 =?us-ascii?Q?SpIdPgKQDgqN2rAOKqkOS+kbos/6BK9QAyX6WuzWS3cq7yqteYxvO93pOI0U?=
 =?us-ascii?Q?74uhXxD8wP2hqYbjQ9AbdHPFwr2D0kXKG4c6C97jFE7YPNVP9ignpLcQWIaB?=
 =?us-ascii?Q?PNzhDUWePfgp6IP1nqj+Mvz7iNouSsBjcs62+f9iCwitAjOHotCmpDc8B7Wl?=
 =?us-ascii?Q?0mN51Jcui4lFcZtsAtURsyKbFdx5WS7VZVpRTKjxARVogMDV0LVALU1Cp3SD?=
 =?us-ascii?Q?y5n8W6q0Y7Cc4YwJDikVKNYfnU/4GwVFcssqlsmWv+PBWiiH49mCdDO0zcUp?=
 =?us-ascii?Q?fKQMZREbQJrYySjgNdkuJwQU2v4OCe+fVMTsYROYWHR0A8hzSdY+mGF6H7Xl?=
 =?us-ascii?Q?YpsS5bQfI0eiKWgcNJB+2DaxuSY7wfBaTQQ9BzdV3bU8MISkC8opQI7wlNCF?=
 =?us-ascii?Q?CVy003777Mj7ABcfJmnlTUwkjr5xffPbKDO+T7G1BuNSoRI8U7+DFPsZFXlX?=
 =?us-ascii?Q?WxU2V396MYyT/GmA6mYqdME+Y2QR6IO87u0gLAnVm9FZqo3dHE0vdiKYyf7r?=
 =?us-ascii?Q?9CnwuovqeIMfp9J8Iwf2gmtus6fbdJ5D/e/fVNp38JYly3SWL4WhthvhjKQo?=
 =?us-ascii?Q?Y4ALsAwq0gw6ePa2RAaf0Jj877UYLGXr3d4BMkbDx0THfKgvWLFQDYELAeeE?=
 =?us-ascii?Q?GBL4L4950V/uSv8RBpT+sOxwK5Z2aVtSazrEBG90lraHiVfHcolFgHCvUOuj?=
 =?us-ascii?Q?mpdKdmfh+vXAPJQqPgVLdYx4r44uuxqutA74VZnhmitMYOW0r/kTm47QmEEp?=
 =?us-ascii?Q?1de8MNIPPFOEdjPH9RACTLtwW/CilgrzdG2t4IJuT+HrpeW7TKNv90ZLOXvd?=
 =?us-ascii?Q?/PWW6YNiKfjBkGHOoz3ovD62tRUtGU74/6lIImdboOyIIWbV+Z670QV+z5+n?=
 =?us-ascii?Q?hhawkBM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR03MB6370.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rd37B00/VLP6yVWfd1BYy0JL5IQ5mkrmL8zUT0BoZyaLCxWNa+RPg64zVCsW?=
 =?us-ascii?Q?iIAy42tod8rrt+gSwh7Bnc2eWwfProbTu/MricrVz7GrNOTE33GJ1AxttEUb?=
 =?us-ascii?Q?hHWJsLT6TMKkIx+9s5CnQg9/GfZqF6fkQ66dNYWlb26TZRZz0iAkpLf1iiGn?=
 =?us-ascii?Q?59NSHwBP4qqFajgRI34PxTyY/8DOgb7OXdcOr5pP7CoWb72kfBM7+SroE2+i?=
 =?us-ascii?Q?hToiU7NUuOsEVTT8NEc1YN5QQ/nGyPEWyOVtjM7BxQEgZWisx78ae22I4+ru?=
 =?us-ascii?Q?jMCKbQuj6sXMPRWXUiX+RKXVsZtB23ZVaNdK3ck6q+t6c65b8hgBJxFv4gGc?=
 =?us-ascii?Q?BRt76tlg6wLr/z7gkkbBTj6R1Kg3+2dyQMZzCXg5aGxoVdgM9X1cDjBkOmNi?=
 =?us-ascii?Q?4HHuz5oZhzRS4r8NZa7/u5qce+TmrRFqxq2vHbFqCNydCjEsNxjE5ZusFK3t?=
 =?us-ascii?Q?j7/DvoiGNBWyi3ltdc1/DQXrw/YiE2CC7p41qHZlyCfE/6nnwZ0Hg0pXGUTQ?=
 =?us-ascii?Q?pP2A/3x00WuTGB0eaTayRFmSgQ5M8WRe4O9Q5Em1vxGGn2KphBtUNWr1aPBu?=
 =?us-ascii?Q?g82ThnVZkXWTPqWprxlwjuyoNfqcb9iZzmGh/YzgqANCAnnPPGL1BjooWup+?=
 =?us-ascii?Q?CGPPwxRYkbbSBP/dMaC5yBfTLJswWc7lh7H2P/5uyw1E7eYbgHcR4hV2DXmD?=
 =?us-ascii?Q?X9iYF7ab2B3elsYrGU0IIJeLBxc4rZUGJ1IICiBEqaqO+hgeGCB2Z4o4q+RJ?=
 =?us-ascii?Q?tor8rG6HHv7PlzI1uUmQCTsTb16WxX2z0XUHH2vm21x2cwltxdrH16b18zyQ?=
 =?us-ascii?Q?iTWN6/SFsULtGNj1iqwC8oitU9/n0YDdJNRzP8opFCaIrWb8qNiJglXhrxM1?=
 =?us-ascii?Q?feDkNciAaw7XGiIgyK9X5DlU6bxnBVC7sS2r0UJVKz/yBXonaLQwZDtUHy2U?=
 =?us-ascii?Q?0qFhGS6zPjr3+ibiN2O5DyE5ijgnXTXue+CC5JYiJZ3r/KtcsiPyc5YWltiu?=
 =?us-ascii?Q?tcXPOoB64WXgWHKU63Bf3OJ5lEuya+SujFkc4nGg6IgdpIYeWmATYx5omDAN?=
 =?us-ascii?Q?4aUtLZKRrKYTMjDQfM1S2b3OmAhvPzIrCrZDEfDHBfWvhOUbxrDb8g0WPxFU?=
 =?us-ascii?Q?Zi9M940UnBxgTwAf1C6f0e0BLqXCtDLYBBzwgcoKd0hb40l/LBaqMP3KVlh7?=
 =?us-ascii?Q?K1awaooDDEc7VYulVUieFeFTsXF4WfvzzR5yFn25w0ZlRTIHYrlp4KKXMFCI?=
 =?us-ascii?Q?iWTxpl7dF3vHdi52hvws2oeJaa02KI0dd7i9cuqPMwHAkFIn6of4u/PdAAsb?=
 =?us-ascii?Q?RpRGgZcsWH2BfH7dlZ+1CTaJEDdZjNhwqLc3k3qy8JYmG0rB6pttgcg0fxvh?=
 =?us-ascii?Q?x+zq5a857ZOYAg5cJeETI64hd1cgS64vAia7jSevUiUm2dMQ9NXGnHFKjCnv?=
 =?us-ascii?Q?R4Uh8bvf3f/rH3FDnr/QNma33xCxjgouQaAYdp1qBkjQImCUT0rd0XrkgMFb?=
 =?us-ascii?Q?BGKgDqxyk1J/efdwaEAwoMx2Xaky2I+OkwpHJz9UR+l9PUkpALcfHhCqp5Yv?=
 =?us-ascii?Q?/O6/jkfUDThtR1ofMLCWDl8lb0EO+WS65Yvb+4XtPTuM+Fqb0ACE4i0EJ2AV?=
 =?us-ascii?Q?wA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8fcaf36-5e3c-46e0-0ca9-08dd7d565db2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6370.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 02:20:05.1743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: unB64fAUKs8+5axmit/P2HfV9cTV6peac+qN8qPf2yzqkXXxl+sNVanUO2eVDKMzx9qaUqJ/Nc8SsTEKBYLxEb6nnXiHB/O0bXSzdlS8Ec0=
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

Enable the Kconfig and Makefile for the MIPI DWI3C driver.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 drivers/i3c/Kconfig         |  5 +++++
 drivers/i3c/Makefile        |  1 +
 drivers/i3c/master/Kconfig  | 11 +++++++++++
 drivers/i3c/master/Makefile |  3 +++
 4 files changed, 20 insertions(+)
 create mode 100644 drivers/i3c/master/Kconfig
 create mode 100644 drivers/i3c/master/Makefile

diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
index fa68612787b..d4451057de0 100644
--- a/drivers/i3c/Kconfig
+++ b/drivers/i3c/Kconfig
@@ -14,3 +14,8 @@ menuconfig I3C
 	  If you want I3C support, you should say Y here and also to the
 	  specific driver for your bus adapter(s) below.
 
+if I3C
+
+source "drivers/i3c/master/Kconfig"
+
+endif # I3C
diff --git a/drivers/i3c/Makefile b/drivers/i3c/Makefile
index 5bb44a8d64f..5ddc4743c86 100644
--- a/drivers/i3c/Makefile
+++ b/drivers/i3c/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-y				:= i3c-uclass.o device.o master.o
+obj-y				+= master/
diff --git a/drivers/i3c/master/Kconfig b/drivers/i3c/master/Kconfig
new file mode 100644
index 00000000000..22bb7c21ea1
--- /dev/null
+++ b/drivers/i3c/master/Kconfig
@@ -0,0 +1,11 @@
+config DW_I3C_MASTER
+	tristate "Synospsys DesignWare I3C master driver"
+	depends on I3C
+	help
+	  Support for Synopsys DesignWare MIPI I3C Controller.
+
+	  For details please see
+	  https://www.synopsys.com/dw/ipdir.php?ds=mipi_i3c
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called dw-i3c-master.
diff --git a/drivers/i3c/master/Makefile b/drivers/i3c/master/Makefile
new file mode 100644
index 00000000000..c7562f1aa33
--- /dev/null
+++ b/drivers/i3c/master/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_DW_I3C_MASTER) += dw-i3c-master.o
-- 
2.35.3

