Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F3D3C83F26
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 08:47:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B759831BE;
	Mon, 28 Jul 2025 10:46:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ifX+3dh8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 175A982F00; Mon, 28 Jul 2025 08:57:04 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::625])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FCC482F8E
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 08:57:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eiW4dGUDEaElKtLVWnreHxGopk4u8U9bXc2fNgdRt5fbmfMXiTGPOi4v6MzSA5hdub3lnWLvYtuNVa4PPezeKvYhnJXbPv5aNOlw20UJSRo9K0UpVVIlK5/AEbu1bE792DTIyAytN0hj0CsRXpNpd6Ho/JR3bOS88RZntC4PF0hQoacR+O4jTFpL3+BRk9TjArt4mDC5m3OXzrV0EiqWUXg54V0K93M3UrlhBZex2gZLKKukxN7DF8inFCkxo4lyPnQ3EwjILJOtpLbhlHLdJ9Tu/OhVCDIfrSTiza0ejmAEU4DQxJBjvci81RxDLNFSObfdW+aTVrKevjcmKNeUVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OtDFAJygkc9b73XrQKbHD3dLP0XAo367x/NKJdD4Ecw=;
 b=jBJdUY6v2dFUiNMXfYTtOJBoXafu1UOFL+IMex4w6AZM7NJxcYoeerfJoBnGjqo8TLBKdZAukBQ7Q2nfq0scaoJZKomDJ/nFe3aR/lbfdhUV1jfeUe1I7YFhWBH8tvLNJtzkl74WDKhAB3QeQIUjNLDqzrgujzYifuDjrZDJfsmbkrWHtJVyaQnabulEvec0FKCiqFs1OpZ6X4tqgxeQuKOHxPi7DpNIeH0JL7f1Q97+hOQ3cRAummm0W/pqJ3bPBf1FRFpvTdbrddsLl2fLUqMWQiLW7vCm6CxEemQSYXCpO+WFFS96JVnqElnCyk9liIBBKz+Z+sW+auYqKVGoww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OtDFAJygkc9b73XrQKbHD3dLP0XAo367x/NKJdD4Ecw=;
 b=ifX+3dh8Oa1ubJMWK4OgNDpgTYVMGgMJc4Zfbr7/ilXMElJd+ChMWdkWG98EaSAcR6czdoldGNQ5iznVgyJTYfwo3bzzfx2XNtED6YGCK7f21wqXGPpSy2DQ04uzJupz0hF8+8DS6QWq6M1NpwSO7+Pqr8e4VYXP92jLH5VqphSwEXIk0VIZ6BcYErOlDanC7+ZGUARaEGfHzRgnNd9KJxX1oNkOW8OS3T6LPlFC1kk3GIkiBayDFvfKWJefDvYjmYhu0IOX0XFQrkyCD8RngB8UBzh3YWVN7RBLn1399E7FI5rn2lOiu2m5vTJhSiF73xmsWeHpqL5l1bDYX7mCuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by DM4PR03MB6128.namprd03.prod.outlook.com (2603:10b6:5:397::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 06:56:59 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.8964.024; Mon, 28 Jul 2025
 06:56:59 +0000
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
Subject: [PATCH v7 05/12] drivers: i3c: Enabled Kconfig and Makefile for DWI3C
Date: Mon, 28 Jul 2025 14:56:05 +0800
Message-Id: <20250728065612.6039-6-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250728065612.6039-1-dinesh.maniyam@altera.com>
References: <20250728065612.6039-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0057.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::32) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|DM4PR03MB6128:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b5aff4f-7c5b-412c-9439-08ddcda3f288
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AFBTbS4AoHo5Q5tVuvLH+hl8mzflGFLq62MMi5Jr11Y2TqTPB2AOJ/MQB4cJ?=
 =?us-ascii?Q?YkrxQLTuoeD0TEsvcIvK/X2fvQp/AyZGGrHOtuSSghVWT122hJsCJBVEt1es?=
 =?us-ascii?Q?OGQfxmnqi5oGw+KynESWecUjkOkURhkzJRcI+/AiblXpzUBYaWsj2JCrgvl2?=
 =?us-ascii?Q?jdMc3L0val/fcNgQPjVATvqC6DIAeAmEUQmKnb7uxAEwQ6UQb/CtSboAPlOF?=
 =?us-ascii?Q?aO9OTSAMf6GMAYhpyANngc4crDxNS2ZQ75gH3iuBPiFDcjiDLDhRWm4dVind?=
 =?us-ascii?Q?Mr7aVkR660meKAkyt02dfG5kGKpFxuYlXwaaIl7TT98mUg7mJfyOYwVwSfrr?=
 =?us-ascii?Q?MpVuVHGIMmnsm0ZDEUbNotE/nWw7Nr9gAa0Q7WKGF9GaTQaCCl/CwCwdQhFe?=
 =?us-ascii?Q?9YOZ/px82F5afhirnEYNcc3zxxzXnJPq7ycHC2jzrCp3m10EMHfyfSXcqEth?=
 =?us-ascii?Q?ikrtucVBXJPHX6kkjTpZei/rE1esilsirt5iispxr5v8JCQzBV8dOfIycOlQ?=
 =?us-ascii?Q?E1FtazYmgyPa/BqL+L2rOc9lJyd9zQbAt2eTEfxSUgwPFsIqsAekJD1cySF7?=
 =?us-ascii?Q?fAbpDZ4kYoOTsTocKIBHUJ+xbPMKhHpnbl0PDULsN8wo6xfbpkXUztUSnBCE?=
 =?us-ascii?Q?F2jArHSTYyqF7NoJTJzJAKpnD6CFuPTKqwvYCgpAVYuoYiUyGosnsNOr05A1?=
 =?us-ascii?Q?8tcC8+8lyo+IjoyNVdwYoDzJc+JxJUPqGLl6cIpQRVPQytA0xIduetRwAlRJ?=
 =?us-ascii?Q?FYJxkuifmpyQtL/AC6Z/gOtj58nz6LSSHIvETwibRxL+mySnBzn18rNzRsXu?=
 =?us-ascii?Q?wqT60cYebdtdRm7t95D6j+MwB/jTCqaYlfN+vbxxWHiMCsz0PA3fWXaT7IoB?=
 =?us-ascii?Q?DkG60ABgqYCPKcSxxsx8uhdssmyqvJcpop3E7rK0rWZbxh+w39E47QxYHl6z?=
 =?us-ascii?Q?q7A00aae74IOiUcsW0xXRpsrLVIZ5jxZm3ssP+phLkFoNrxxqLsB8v8nMNvF?=
 =?us-ascii?Q?PFP7XSHgFuaZhiTLji0/fsy66NJD72XbJoxj8Yngh5I44jmTa5GYn3F1Ez0h?=
 =?us-ascii?Q?V4M3hhbeXB7uUVs5tZ9v9oDsUAxFaplqkclvfvOQtgHxfj4LEwqwIZtZ33ul?=
 =?us-ascii?Q?UW956p7seLZLNPa6Gc0ecOfBiQpNWYSdmzin29IKOg7TQ5gEq4szu67ltLZY?=
 =?us-ascii?Q?TIUAmJtuP1yS6mckrrfm4EAT+gzW1QcbXGH/HUTwy05IhcA84HSDNJzRZ1lC?=
 =?us-ascii?Q?Qy2SSopBp6h1Y9JdG9dGhO5Bgcr+eUM3uZOAd9RHeRZgPrrCeuxOZykJkOyl?=
 =?us-ascii?Q?cT4V6OGlZrBeZfW/JfxNY04PlFQY4JxzlFPekPjzVnet7m71MtPzLhBUh+/u?=
 =?us-ascii?Q?tAxCEiBfnBUIK7+lzIs9CAvHhc4CwQlM1XJFtz7ELSWoTZn8PcPWofpuYvCh?=
 =?us-ascii?Q?4QeSVUZF6g4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xn9ZhvVz9/VWEOhRLiKP+kLvY7aLZyU8pvn0Ip7ff5Frsoiz3jxGvwWHFM7w?=
 =?us-ascii?Q?LfQIlRWiiqkAhGDshC2UyePbyHmb00h8uAjsfTkmFzzy9hi+Z7RQpgyZCOKX?=
 =?us-ascii?Q?2UHvtszyVvBoYj8VF2zpMsDx7zaNaaTsfXclMYJ1nFvvYsl3EbAbYoS/fvUH?=
 =?us-ascii?Q?to6tPXYThRVmNzGANWTgq/Acp+Sk32iKij+45/z3Rh2p1ZfcA1LCjK5SCbom?=
 =?us-ascii?Q?d/8s4TCGeSCSusrixC5VVZTxP2hMUJk2Hur5BmZZ+Yi0Nx+u8LxW0aZp0PYA?=
 =?us-ascii?Q?ROiembEeWtstKzFEuwLPAS4n4SUNPrT75wEvm6cQ3VYEy15liC+rsXLo1dG6?=
 =?us-ascii?Q?6rByDhspylQklE7Edx8d9YRbk3GpbdmL7xh8beSYBBwCJWt6xSlL0Dp4k2ai?=
 =?us-ascii?Q?FiX9GEjouyuvcscaof3DGjgeF6XjKhXdHKvtPhtdwwWRSVJu2ZWF7FpjFz0h?=
 =?us-ascii?Q?n9oclVLcLr6NscL1f4RKaU4NEHJEwsShpMtpkT6v20B62oMsV7ugBEOgyDMH?=
 =?us-ascii?Q?2gUVIhd8CbJmEHOL1VtM7iQWmJwdiYRxUqV7aURbIxXcBMwGv9hardJo7ytS?=
 =?us-ascii?Q?YGLVOKmXADciNBjVSUB4+K3i4Bf2dPKTpZYArJvWClVok07r16DJgSKRq4N0?=
 =?us-ascii?Q?vbJrM3nVCi+5n/6i88ttjpOQxdD3lZVcZmtm58g2aJaL5RVaVkHEeJmVy7lr?=
 =?us-ascii?Q?W8ARoalS24LjJFb+fmnNyV7E85mBYr44s3EMFHYNsCgZxw1THCEcbd6A3CX0?=
 =?us-ascii?Q?cJgWITRSn6sN9he9E1mAp4lCh2LdJAxhWQH8+SxH+JnswCV3S+ZmeB3eqkVh?=
 =?us-ascii?Q?ZrJ24BvlN6Z/LfvX+ekShs/KOiD85yJZlsmFb88W/33Scp/Q5gWsaqXY6OWA?=
 =?us-ascii?Q?INU+TReWppxUao/BwKGymbiE7F3b8Cq9PBUtdDAEN/2ACSUO3V2pDbnw/4r+?=
 =?us-ascii?Q?vtw2Q9n+fc4GEYQwlzJ5WVM52GTswj/bQIVseYEs18S8BdzBI4NpPgQiEf+l?=
 =?us-ascii?Q?Xazb+45uDIVRa8LAh2f8nbbhK15+iX9opPvdEzKLzJjE00k6je6JFPAsWsmu?=
 =?us-ascii?Q?8gsH6NpV9EeXgQ2NoJlycy/43I8qfN9sB2HqgWcrTjFkyWgWP7v6Gq4syWgZ?=
 =?us-ascii?Q?N71189+AKU9ZHiQCgAV+QXSTqwG2VguRaJRS6aSbZK+wmOd3A9QfuwDFosf7?=
 =?us-ascii?Q?Z6um71GARM7RQpOE/QiAipx2Yjlt5lN+8Ao5V9kg7wWUc7Gioa3OnZy5Lqn/?=
 =?us-ascii?Q?CZRiQpS5b2X573CglLSUg8DjZa+HgNz72HGdbPZDV5w+VzM8XHMhFAtDbbrx?=
 =?us-ascii?Q?rJJ7x1pJC2HfqJkEXOaelpUQOWB9ABnXI1k4J93R4zky+i8bWfjcZhQslhD3?=
 =?us-ascii?Q?6cKe6j6t4GvJp0oeSc0tYKXgneSLIOSvM475dpNKXALNwO3Bw9v1xqbTyUbf?=
 =?us-ascii?Q?ubTjqoAmX/rq2AxBYc2qcEfji7JjGIwF4cLpCu5//+HyZg4gKBYkrLjZX8We?=
 =?us-ascii?Q?FuYnrYhiEpPQeifnFd/TCYw8Bsw/uakCC/ug9gmfyNVwYBNnzGTBus2b1P0X?=
 =?us-ascii?Q?yS5OEw+98HY0jqfJ8g4LB7/MGEmu/hrAyxe8rJZGRLSgH328AeuNG1+/8w9f?=
 =?us-ascii?Q?sg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b5aff4f-7c5b-412c-9439-08ddcda3f288
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 06:56:59.1604 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RGLCjVng9nKmdwAvlISFOOBlgSdmdRaI9fE1bm4ZtUt+HeXNDz0VuBKCxFK1dI9udwBpv95L57C7qKpuxNJYDJp5+7w4IMD3glpeQ48pdSY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6128
X-Mailman-Approved-At: Mon, 28 Jul 2025 10:46:50 +0200
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

