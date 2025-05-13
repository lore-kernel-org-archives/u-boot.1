Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37060C3ABC3
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 12:29:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86E6482ABA;
	Tue, 13 May 2025 14:28:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="QnA2sTxx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1DDB8091A; Tue, 13 May 2025 12:20:36 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::621])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6038D80AE0
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 12:20:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IC/dUcF/q5wviKkFct0RSnRKBX45jYftJ3T5KWkw6IOTXfB9Zn1BkyZWs2o3gxuxiJQZaiHIB/j5ZVpM5/rFSDaeCEJZBsdOT0mTFRVp6LRhWIyCb+TuVkx93RwuCcThasIv3BNcM87xPAW8nvLZdL7RZWmCzCkmohgFri2KBxR1gmzvuS5HfFIjgErV9BlvDbqRp/SIP9nFToqhddX2hW937ftMotNKeSmqDxzYrJh6wdzZ7FmmBPDw+tLzStaZs6Z/yw5snAqPLJRrquyoI2ae9rqCImC5dUqJiJNMoKsQfU+dTLtVhTHvHN/eGf2UvyuAcqLOiDlvTW6UNOg33g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SW27zN9PoyjiypBfo0s3b1pmT6IAMSJ7RuQ/PsD/Ecw=;
 b=tkDL3CQMev5mSABzZl6q4baHwwDP06XHP/cOflXxbIT+YYQGeBysCbSO8mVdX5FRXoLPTMUky73OzaPI7OQ9YJCdj9RgHHN5nxTV7lanjdT3lN1Z8GMQDT0YvMhUb+Y5fDK4CM/Gw/jFXLkJQvOuhMNWfSuC6Xf4qVOs9Y/vr3PzMVziUH/tDoeLx5R7GUQ+/XT/uMaYwON7yBhcobfyA+RLW6ySQ0sQuMAmU0Q5YlxTosA7SP4Zhjd/7P6Hy4MNPMDXbgiETwWssBUxLliccurpUObh6jitz+uJZOjbWQmNo5IfVl5lTSAhLeL2oXDMoDA/4bqeJpQnNmp785asxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SW27zN9PoyjiypBfo0s3b1pmT6IAMSJ7RuQ/PsD/Ecw=;
 b=QnA2sTxxdhXQVorXZAthAg8SCMY34ZOdAO/uArRbVq9pN1e3fqPLwBWWQI5SXDBq2YGFGFCyh9WUT4ZzgXWp8wqdeV6kk5P67spN/wohfDPdh3bJ7B21dVrPQ/FPlEGotXB6fFtJzhFfu2oBeqZmNIczm2LRZyCqIawPO4ZUgQtlbgIORwJVfQBrqIj/zyMntn2qvmGFT8nc3KKAaI5av6N8AUkZZTDUhDpm7I6W/HiqhOISI01HS8i+YjHITjxQwXEvvEfIKhHXVBIaDArQvR9jAvOVIOHc8LonUZ++WTbzPtR2PyqdE1Enn8HIsm1etsmCT0BPKCr+68551mhozA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN7PR03MB3410.namprd03.prod.outlook.com (2603:10b6:406:bd::11)
 by BN8PR03MB4979.namprd03.prod.outlook.com (2603:10b6:408:db::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 10:20:32 +0000
Received: from BN7PR03MB3410.namprd03.prod.outlook.com
 ([fe80::bf20:122e:c7a8:10c]) by BN7PR03MB3410.namprd03.prod.outlook.com
 ([fe80::bf20:122e:c7a8:10c%5]) with mapi id 15.20.8722.020; Tue, 13 May 2025
 10:20:32 +0000
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
 Jit Loon Lim <jit.loon.lim@altera.com>
Subject: [PATCH v5 05/12] drivers: i3c: Enabled Kconfig and Makefile for DWI3C
Date: Tue, 13 May 2025 18:19:06 +0800
Message-Id: <20250513101913.30880-6-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250513101913.30880-1-dinesh.maniyam@altera.com>
References: <20250513101913.30880-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0219.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::14) To BN7PR03MB3410.namprd03.prod.outlook.com
 (2603:10b6:406:bd::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR03MB3410:EE_|BN8PR03MB4979:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cebc3a1-9245-4444-7d1b-08dd9207caae
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4Cr9uwVl8ksTX+bTcw8VTKRGLPbB8ZXu/hIsksmYWQ8NiiCVnTAXS5RCMPIb?=
 =?us-ascii?Q?XyYgyFQxhzso06tNizQsIou8DuIis4Wi5V1/wvO9aGBVHrdUlsKiNbL3xezZ?=
 =?us-ascii?Q?Jm3Gq05qrCtPvbVin4ET9V2JCtqIYVkB/bf9kXldh/zrfQqq+Lh3n7Xbqfd9?=
 =?us-ascii?Q?2bzSrq9ZkZU3BTVSEW2czkUMFuzwK7Fe6FgifqqDxwD4fWdyW1mjx4aralVF?=
 =?us-ascii?Q?vTIfTP9LbDEs6blG1uegSjpiBD7eD/KqcPcO8CqPiUieL9amxQzRexLnUfTm?=
 =?us-ascii?Q?qdfkyW9s1cswAgANaC3YxsOZ+p/6pD42uxHoeNjJhib2XHW46KI0P/uJhYJg?=
 =?us-ascii?Q?snHEobmF1dItQ7l0/K7S2jhe46BOOgm6zP1Bpsx2pvgf8PUmofircmb0g6ne?=
 =?us-ascii?Q?v+O4bR9JdgrHSQ3ciC6M/5AI6N2h9y9+vbB2E4YZQrYzZTkX5RLlC+Hc04C5?=
 =?us-ascii?Q?IjenLSW1URrE6y3jtD9D8OZAZU2i/u35vNs6zM4Ys4Ry5rz6t9l/grcfOszs?=
 =?us-ascii?Q?VwDXqo09FC75TNvtZ+18LuzPhWHyxe1KYmqp5FrDL9yW12ed3iZC1zc8A5ub?=
 =?us-ascii?Q?2ZTRF9Lt/PVBYU59wwQ8hLJxVMsemNKzfJBzx0JAnPYPG5uOv3PK1L6Vd3g6?=
 =?us-ascii?Q?QMcitJB1idwUBjeeImF9KjSCHZ5DTcbh7W/Yvufq/sNDO9wFUq90Rh2WtosS?=
 =?us-ascii?Q?RaY8VBBr5ZtOIxBxB8xOPGj/MepsO+2cswl2jzDQGBS2N3zjcqzlwUWz3TZt?=
 =?us-ascii?Q?2wVQoFob4q65w2g6aeaQqGDCfTEE2TVmMPe8Lcdd+6cXfSiumSLMBchrcGV5?=
 =?us-ascii?Q?xgX9MYL28z6PwkVuSuCdk/esrL7bDnglAoRSEr/TcM3twANiHDYNMY0qutk3?=
 =?us-ascii?Q?ywP3sKuISuTe/JFL0XjyLtZ5xjNmScLtg4WY61JCpVH6keYo/W0ZtABbjL3m?=
 =?us-ascii?Q?yyIJFth9aocSCP2i6KG5VW+q/TTSi/Ra54gNhSCtTl2ar4w0LuRoWgWj6A6q?=
 =?us-ascii?Q?+hI4nz0jXb/kZA9BxsgikjKGBFmDU4EhCDWvKrIkkqX3OGS97geJiG1rC+nS?=
 =?us-ascii?Q?jnJEFuXjs6/uwsakLYUrZshH76j60tGaMpXmA5vESYyjciwWrOb1+iEYDe6O?=
 =?us-ascii?Q?uxcsFA3XNO2uAKg5FBvY44Rh0O0Bk6oWLyzG9/H+HJgxDUelKlDMKETaBxWF?=
 =?us-ascii?Q?J4NHWbKr+1rfBRxXzZR3DW9y3zg+vHU+Tgm5jUcP2KRgUlMlqJ8SyOdFqojM?=
 =?us-ascii?Q?+Cx2o5uL4pJU15/Jhps4W2C2MDFLtIHXinUOmoxWTDHG5TwwRy/+hKDqOlSe?=
 =?us-ascii?Q?oBbm71YPj5VkwCCWAXZfig8X78i37w5P2qA5Lxd0/RIK8bDNtpVClAxxR+N7?=
 =?us-ascii?Q?72aOH0g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR03MB3410.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T/j6MKy40IKcZqo/QjUq7yl6NKV/xi/J+HhFhN7g3iaVJZuD/za2/2OAaFa6?=
 =?us-ascii?Q?vZGwAi/ZjQjOKJ0GMGNySCdOgDqK9mBtyx/l2JAoXpYbA9gcZRsXbYDMVCWf?=
 =?us-ascii?Q?5SQF+R3b9q7vIlFc2V8RPosRdCl4qlQixY2sUGCVnMZfqpsXHrxBX/nJeV8W?=
 =?us-ascii?Q?JqfE3K4Er8YYFefbebZllBpjzSDpbDPQ6qP50SxI2u5kox8BFVZuOSO9Iygk?=
 =?us-ascii?Q?KC7xi1IyyZCtitA9/V6FwHJ3qhO5W2YBXb1DqbKG1/Gst5y6boSZE3lhYZU3?=
 =?us-ascii?Q?fw8MenaEx8oqwnCl5m8Z7OUFmiXKMxOHambLQbhi7GCRBTn1RkoLFHbK8sVt?=
 =?us-ascii?Q?yqtWx7kv8x75gfGgNtT+iRufUe8B9OIbatB5xzKSrvsW9O14FhkrjRNFWrJP?=
 =?us-ascii?Q?pjAJxfoZF9B0iyIOJCkJEXHDjPxXmg8nBPFLsFugoB4n4quzqH84TqxSLb2F?=
 =?us-ascii?Q?Q+Ny1E1ATIehA4kaWU1bmLMrQ+RxRjG/mhxTOp1HZTKA8P+eKYd9tu3kYjXC?=
 =?us-ascii?Q?tAbeUWau79KfDUpqinSKmySYNG4eIFNNjPtEPKwq+zex/HKi1FHC5LeshaFA?=
 =?us-ascii?Q?4OX8WbJVOIUc3WA1B+tQToGxDX8DaE/1AbScGOWfl8jVIQGO9+q9Lh2/fAWx?=
 =?us-ascii?Q?DZxq/cn14hePhDhHt0x7Xwx+hrp3SkpUpMA9JvCTzC75QwwhGAEt0MJx7w4B?=
 =?us-ascii?Q?SrB7G+mxYBsQvSmzyV029aOfk7WdlqL+UMOrdEC6eE9pLqsywtDh8Vv9JEGd?=
 =?us-ascii?Q?zo70BdSaeU9jbmzNXIzDXxvBey3VFFQ3NOiN+V4QYPA3j0JdqHfTdVPokegP?=
 =?us-ascii?Q?P/cz35ZGKXRCYAsIT8uXjT+d/GX9TLAdkzsJVJLn0gvKT77BtW2z18I0gWcb?=
 =?us-ascii?Q?mOkQpWvu6H7uAbw8+rgtPW4pG1Ea2gGpJmWdntTvpiUX1yhMwhoAzcmUxQw2?=
 =?us-ascii?Q?JuszagYMwI0Tka0CAyxTWJPRgHdRJKoVShOXVX0HF5mCLzxcpVd8lv8taRGI?=
 =?us-ascii?Q?KPFor+jjg9rmJSx2kW3XlEFAOBSp4zl2vjz/HfrVXux7Bm1auJ0SsPo03MhY?=
 =?us-ascii?Q?3GNG7rW09+UZtm1B+xRgm3J0jreu153Q+q+VRYvOSrAgFAtaXMNnreaonqCA?=
 =?us-ascii?Q?6Wx3t+8aKzXYLSvIao6eJpLnbmqBIedY75DTEoYZaeTq6YhGzGk7iqiHoHsh?=
 =?us-ascii?Q?fIWZZiqKnFCVm9jGil8kmJnwWuXFAcYZQB5EW8HBgyOo3XY/EjGWSn6L7G3E?=
 =?us-ascii?Q?lJa7f06TyNHDUUboxJeu58w6CL8HcxUHy1IO8QyRLs5Bz1I6yvWTVKuVLyD/?=
 =?us-ascii?Q?n8etB/K9wDfJ2GKTLJtdxEt77m5f9tkwnpa21CoC343Qim6+4GWW1cVXKTqB?=
 =?us-ascii?Q?tVoOtbZof03lvg3/SUhkju33zmrXbxvcD4datM2oBtHccwIeDD8A1mlr2Q5w?=
 =?us-ascii?Q?fazj3WdJgqAO8bFhKR76tRZpKPBXDy9BEl3XZYkspGo10iFydj2jSe+LSGZA?=
 =?us-ascii?Q?0FgHALaEp0vjwj4QjHpdVyDf7mCr5tvHBZ37fPeZaC/AgSdq2telIktOkfbU?=
 =?us-ascii?Q?mevCKx0eGdm1m2u40obC+jxnsF4bqT+9uH85TbQ6NEDGN9Zuv+Air6FGZ4zL?=
 =?us-ascii?Q?Dw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cebc3a1-9245-4444-7d1b-08dd9207caae
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB3410.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 10:20:32.2520 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lz33bNOef8qjV3O3kWoA4BmpBiRM1dCij3Sa1a04CQAgGtuyYk6q9YnjL46Up029NpeI3CrKoKJ5Fc9saS/NtzsU5/QNmL2fH1GGQz41+Ks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB4979
X-Mailman-Approved-At: Tue, 13 May 2025 14:28:49 +0200
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
2.26.2

