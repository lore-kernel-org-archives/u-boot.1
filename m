Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D113FC87FCA
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 05:28:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95E3484258;
	Wed,  6 Aug 2025 07:26:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="auTEbDlq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5010283950; Wed,  6 Aug 2025 06:33:51 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::603])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F001A84233
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 06:33:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DDWDlgkDQGSCUnGZknmhBXu9wp6agdemiksy1xTDLuBdvqTQnsiDAsP7m+5/y7R2CdhEkDnHNpYeUU3KEYjQlDwMhZO/ScvQ4mTxMJqfxuLwE9firOgCNxjVx18KWuMVkeJEdHvsZlwX31XLiK7A2Zi9bR4uv6g8aD0xnzAwY/gVtwacFJ8XOKItDrQhs9dJIKrocya/11y5qb1FXU0vL++EZxRI+S8B9TcPA5ehNIqocOvfH+x1ydFcMfZwAsozjYvs0LqYiuvXyzX4ixKfBGww7wxagJgBTaOdT/AuDkKIIpLfIxKKSHseooxQTrHNwEPtbYeLp0wnPC6symcgRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OtDFAJygkc9b73XrQKbHD3dLP0XAo367x/NKJdD4Ecw=;
 b=vB7D8DJJ7nZb2pe6Fufa34UJN4KNzNoB+rBO2tlKzpaHrYdgImGzpZpeMHNshAYVoc7Lae+pwl07x0qMnx2ApQl1yMsHG21heMmSU8hgn1TVcTNT9imP3dKidHH+TWpq3UgPlbc1APLhfFA/ELHjF6FBPMuCdMb3g3gp8PpOgP5fxI1gDmd0tYCDbtFHHyuuj2IC8Y+uVCUyBL1J3wNyJ2swAuWd2dyax1+Tj+vCQVP1WFMa1RY7It+T1BQKAyvmwT1X1bCydqriP5j7r1+YniRSPIyekt1hlKCJuAaR95oo2fhZKAbpE5TxD+4HBowgJ33+eO6OvCwDjqRH944btQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OtDFAJygkc9b73XrQKbHD3dLP0XAo367x/NKJdD4Ecw=;
 b=auTEbDlqznuggbDUBucJnpDLwZkzpUU+6kQYbFz4dnLQMpOWixJYjkknS649zTSNVb6nMQ2RcYPUdTj9DTv0gR0783Y+eYJRzpo6CSnwlS1oZgnNO5LkHbIeQCp5JAm6T81XW/ynSMHbHFHkdEu8q1oztdgj0EvWBr6qe4b92Xa1SuF4OQG7/I+ZNgrRfyCcYTdQNEpVcLbNMOQv03iUSBnCC0Nf/DQ4s2Y91HKAz9om19T3EBG0HJrdZ21jyQpfOEQ21Hs9oNICzF/piLZWGRgKm7IEOtPEZfN5IKA2eeGF52Ap1kUCToudTIHipmA5TY3mTUs2qpLCqG7KpLbMMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by BY5PR03MB5202.namprd03.prod.outlook.com (2603:10b6:a03:220::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 04:33:36 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 04:33:36 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@denx.de>,
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
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>
Subject: [PATCH v8 05/12] drivers: i3c: Enabled Kconfig and Makefile for DWI3C
Date: Wed,  6 Aug 2025 12:32:28 +0800
Message-Id: <20250806043235.2260-7-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250806043235.2260-1-dinesh.maniyam@altera.com>
References: <20250806043235.2260-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:40::32) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|BY5PR03MB5202:EE_
X-MS-Office365-Filtering-Correlation-Id: 356e68c8-df0b-4862-a9cc-08ddd4a26880
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w3z9S9bqwkp6PVqSFkkCQJ/TRb0M/eCuwLZCipdM62NSZaGsCZ2tJBWPFH4n?=
 =?us-ascii?Q?+CGJx3lvKem76WktI3fP58EQquWsggrpxxElTKxqluZNg1XnnuBVSu7tTYak?=
 =?us-ascii?Q?tkMYAOOcEXbZFjU0jvdnibvIa2HULCptf4MCkPI0Uhmgn30z/sqr6lmEh00I?=
 =?us-ascii?Q?KS85B7UUVkjwg0NVl49YmStkv1jEx74l4KA0OGWX1kURfpYEBNRyBIWSeIEt?=
 =?us-ascii?Q?h/mvYm/wtouK2s9pIjxj156PUeqjWGStiSZQNUP285qImkeyoLLPRqqrL+pE?=
 =?us-ascii?Q?nGOa+/LzPLqlbfTD69ctd0NAjsCXaH+X/OJSsdVIo6ogJEs1WlBUEjntIm3e?=
 =?us-ascii?Q?NDkamvXajbSTNvM2xmzIy0eSTAkzlz7PrYxJS7Z+xUEIHd66KvnF/XRo//Xn?=
 =?us-ascii?Q?GNQcEXOccOhzMxvXhC3dcgg7gOyyEKi1H/qQUoD7xyXohqBjDMQlTx5kMZEC?=
 =?us-ascii?Q?qMfN/yA68bAcHV2Z77TyMGN0LceDTDeXkz9nI0Uyf0cHCJyu5IgCywfOXcez?=
 =?us-ascii?Q?ElyALS666ALfJohyGpP86o+hp+FLOpF5rEqoePYz/q6ztR2OlChjJ1j4aU6P?=
 =?us-ascii?Q?yxU7Mg/UqMwG7s2xEfz/ZJ2QwZIlqpHs3BoaaNKs9tPhzqv8hfeFmqV/H2uw?=
 =?us-ascii?Q?50Lh/vfNs+68N71ip5+7522RkFk+jT8u8IsbhSqVYcXuQwJ3nyEAJ+e9nlFk?=
 =?us-ascii?Q?InPGAUXdFCAabFJkr9b2EdI6d101dLza8jjluWGZwGQrvrIJSqtIiIBklVYQ?=
 =?us-ascii?Q?QceDIU8G2wjQM6NkWnfDvsoFei67CT/CwDp0eYpm9SoqdTxRZTtxGYNi7wfJ?=
 =?us-ascii?Q?MekoL/ve57vbNASPcuT62bXnkFx49su8rbut2UtsozuCTLSg4WxvlBfU5CiC?=
 =?us-ascii?Q?mrRMwDNMMxiNAidshHTeLmVzGP+55uT4AnYkqzi6CRC8H3zipa+J4vkRjVYh?=
 =?us-ascii?Q?FqL7onyehmtljMYs0oJQALuhDvPVbYAL/nso/V9ULYAZYJCHnt7wcOASPbu/?=
 =?us-ascii?Q?ceKai6/YVQTAAtZ84jYk+Mh18rzfg8cPI/JUXk9nbf7sBNLnzhd2l9krZZ3Q?=
 =?us-ascii?Q?45FWvs60592ksHKF/W3bjeHckhlMUiggcvk98N3V4YeWnRquhd1FGMnEjjYh?=
 =?us-ascii?Q?DUmxTq9ppeh5mknkq+m9w5lLGnc7JuF6IXTC81y9A8Y4w1uVtErTrp6SIEgc?=
 =?us-ascii?Q?AlPWjx3CpS+Yr6qh+w6LeMDtd53rnmDJ4R7KsYIQd8NVesZ/Vk4DEO/o7D9s?=
 =?us-ascii?Q?dRGYKd0VsE4eZO3jg9eLvq4xbc9u/3trywN7WuZcs7ns+8m/0EJ8oObP06Pc?=
 =?us-ascii?Q?FlfLnXlbKF5f8GmtTMoKRm+AtUtAnhbuSs6XQVkzVpJymgPcc/eZuJVVE4IP?=
 =?us-ascii?Q?8+QQRPByvkdv/DP//fPvHO28vbO1GXrypyeB/2CmB+Awt3iRejFJhoCsV3Kz?=
 =?us-ascii?Q?YeAPaSlT+GU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cq8qxAqxRzkYd2cfbLQRDTzwfhpb+OmfOQtF/08lasnw2Hdg/eHFXHGxAahn?=
 =?us-ascii?Q?v/LwrreH6gEBj9WGMO2RF8HPeYzOGpKvFv1AmewS7aYJkQZv+7SJiQNtUTQS?=
 =?us-ascii?Q?dyWALmK9fbenGzkWJy8f5ueVbLH4IM69NdRG35PrKbCS7dK6ylDbLoJMF7+X?=
 =?us-ascii?Q?MlsHN+kec11qK049Ard46tNQYrIXh3rlLyt3sbe2PJNFyyF9os1m40UjdIDT?=
 =?us-ascii?Q?tkRf2J6VUC4MpPRcd01xP4574UrVol/qyp8uSYoSCZOzozvMANgcq2IfyOPU?=
 =?us-ascii?Q?BRp6f9lwfjUJJiUwxhN33KgQdAgiOrgGUN5xjvJiIafyS1EAUMAc7fEIgbdN?=
 =?us-ascii?Q?tAybw5MTK1jnbuZacj0qs13Pw/GqalAGEU9jsKoc+T1rrQ0pTI0/mzgt4egl?=
 =?us-ascii?Q?0UinSydGjXsKVVMsVmmrSKumOSnO5q8Tt+Rhu4c5NsyS1KCPevV1EgbeudrJ?=
 =?us-ascii?Q?UP5DMKQQPA8y/tDoikibe1u8XoTyL+IxZYhg0gAMV7gk+0e9dgTI1KTWxihz?=
 =?us-ascii?Q?NeS2HMGM6v5/vRudoEecEs565BH5jvYONZX89Cl9RB5AU1O5cxnz8AEf73Jx?=
 =?us-ascii?Q?nXtlly9VM9Y1FL/xS+pT1tSOC9nDVS44ETqjV7yuY7iP/XnQt6ma3ts6Vz4D?=
 =?us-ascii?Q?Rh4kgf4OW5KXQdBa+i4Gxt7biL9WtMaLvqhhFMQ8DPVuMX6J5u8NZ2N9of55?=
 =?us-ascii?Q?zgLXZ2hCz5S+QVkXOE9KQtjsgWq3Ya8+jQPnCA94oxVcQUSAh1+Sg6YNrlVT?=
 =?us-ascii?Q?rApdLWJ5qmzezNRMhiM9g3PFTRyMlw3RleWYFyRfUKmTu1nHYsIUgup+PLgq?=
 =?us-ascii?Q?SgnWmp/3WjgdQeDFVfnqRSLhAHhOHgBVbb9QmwYaTLj5KV7gXjxxFFi/LpHj?=
 =?us-ascii?Q?KP/bCMsAiWKJVaZocemAc5gGpE/P/IanENJXACK+ieMsw7op+tZ+vn4BghhW?=
 =?us-ascii?Q?wo31BN2AWH+qtx48YhrZK+IgDfSgZXGDlKK8/jwGgvcGTGk0cOEc8HeCQXhU?=
 =?us-ascii?Q?memD7IWEVg2J/GICx0n89mQOOjJqCct8+wOKDNgY0HyQmJcK4gwH/F0IKE6K?=
 =?us-ascii?Q?X6JPcsGdkKhF+ind0hE7hVQ9MVtMtaqN16xqs1M+tSHlDt4ynuL3WmwagFaO?=
 =?us-ascii?Q?LorurIN+L7sMtRNF8x49gZWGXgp5sq91SR0LeXJZqh/Mf7hlh/U11Zra0eki?=
 =?us-ascii?Q?xCLa4Ix6X6Xb+R7fTqxL6Ogp4Gjy3o78Dj2tZzc0ZC8BeHy0GE5s4GzfnDpH?=
 =?us-ascii?Q?ZWqyMP8D2llZFPH1bGvYLpX1h/SYVooZ4m7GLwCvrr2t3J4ZrgEpkCy4TvGN?=
 =?us-ascii?Q?Yg+NCbbtOkSzsYexJB/3Z5Aqo+M6zsla0hLl12TmnKpYn9HlvzCJLXkMQvrz?=
 =?us-ascii?Q?frztIXcHTScKCFZp2a1wzObL/0rCwalxmjUHy7G9CWD74xvovAeG4QV06VTS?=
 =?us-ascii?Q?vTQ1TFZMk/9CnJkJ5g6ftlhJxi4epVw+gBFRkTH+vti/2ZYDZrFc6V58/UT+?=
 =?us-ascii?Q?rIQs+kPPQT+BeuZJWl0WCDsZOD7jnmSEOsdk/Lyl+5QmKX2YlT1bfrbCDNIk?=
 =?us-ascii?Q?SZUSlCXonRzAO2QKUeFbB3QXejhhPU/8HtztOAIVxdF8KUj5tAKlHHB2vcE/?=
 =?us-ascii?Q?9A=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 356e68c8-df0b-4862-a9cc-08ddd4a26880
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 04:33:36.3223 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TnMh7G12jUWh0yCeXyBpLS8YntjTToh+DbI4c8oqwSbO7CyzHSDX8Wnrh98mpQuVDauPYhEhkgitLlKhdfDDUWqbEmL/8MUvbq8B2/Te6CI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5202
X-Mailman-Approved-At: Wed, 06 Aug 2025 07:25:39 +0200
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

