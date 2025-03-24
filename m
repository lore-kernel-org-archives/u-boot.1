Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B9C0C36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 15:10:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DC9481D6C;
	Mon, 24 Mar 2025 16:09:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="u5oiULWv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F78E81F28; Mon, 24 Mar 2025 09:40:32 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9EB2801CF
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 09:40:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rHAMQnBLxZBwDwzAXrTm/c5/lvcxibqbKoId5HtvBZru6CmgFfCsAAFVkc0qOhpn8yqZuQPQPwaxWR3i2HPZS6amHIanSjfsgqSX1/0+rcxB/nt8Z3yV+Bpdm0dH444npuVQzfiTcWui1XzG0LzSxp0Oq0BYxdfo8inEsmpwofnDOavIii1Cxp6XNjk8OIElofyldiRmLikjZ8CUThwPbWjgWjrFOMNbkSS5tcUEXqyb3oNe9uEyCEX5+4KqhrFmi0cEbHNxFwvdSFsXt3jDs2sjke9lMvyC6HkhKVQ/qIm8NZEgzix5NoHg919pbowpYfP7fnxystbq3jidjdyUpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SW27zN9PoyjiypBfo0s3b1pmT6IAMSJ7RuQ/PsD/Ecw=;
 b=dk4MCz2DSI4My3++QpKsjTLjsJ7yZWQD/4hO/PiPdWEzq4+SbFv1MrEU+ajM6VXXXqul8FrI7jGrlXiEhrgeACePiOO+jjwHbLYUMUFXpRF/hqegvlpSCv/ryGlUJfpMPhkrFTU/KDA5HSqhjGiOatCslNY40KdIu2BK8b0GvkYoreffYfL/M3B/gcYQmg1l0g6Uor0eW93kqrfgFKoQDS2HVrllG98qjp7AiOXmf8gj3n1RpFOw3TPlWD4mfGOOW6RZfJcB6JajKQ5BU7h0v+LU43+R/y0uBz6TutixJHh4WTsc/n4XLrLPPMFKvc6lWj5ssI4GUayCK3NLR+1PyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SW27zN9PoyjiypBfo0s3b1pmT6IAMSJ7RuQ/PsD/Ecw=;
 b=u5oiULWvjk1F+CKa9FESipOGyeOi29Qn2vzODrGEs7E5zKCHo6EwoMYfHsxNh8MG3hE0L3Sa4xPvCseS92qsEEylt9BiYh+M7rRsYb0HiAA28CUR90S2/of6zQmCvhn2aR492SXmJd6rBhPBTV3PHWbvY1h//P1OnBPctGLIW9s163IkXehRXsceBGJeH9FxqYAgZNtjrzwWRx8EhJN3r3CpjSaaRXg0wWRqo6BzxcbwaYd3+GCqz3duWi79SEm3iE+Sxu3ol0Jmp8eoXGfR4uWNs9E45qodqikXxxHATf7J0IpD6RQTIXCqzVG2dWL4wtwNJ0/KyumrWkgYmGuueg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA1PR03MB6370.namprd03.prod.outlook.com (2603:10b6:806:1b5::16)
 by MW5PR03MB6958.namprd03.prod.outlook.com (2603:10b6:303:1a9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 08:40:27 +0000
Received: from SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03]) by SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 08:40:27 +0000
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
Subject: [resend v3 05/12] drivers: i3c: Enabled Kconfig and Makefile for DWI3C
Date: Mon, 24 Mar 2025 16:36:57 +0800
Message-Id: <20250324083704.26259-6-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250324083704.26259-1-dinesh.maniyam@altera.com>
References: <20250324083704.26259-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0106.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::47) To SA1PR03MB6370.namprd03.prod.outlook.com
 (2603:10b6:806:1b5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR03MB6370:EE_|MW5PR03MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: 153e287a-05d9-46b4-868d-08dd6aaf86c9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mLGRWicPDTuD8HYrWdZBpoGk/a321TGY9fYgNwurLA0Sr+y3Y0o0uRRBQmJ1?=
 =?us-ascii?Q?+G+qssPB/HPbah0XA/UOTL3Ikcr2wE2OSz7E8n2t3382oZqKvCh9B1xiBYaI?=
 =?us-ascii?Q?TW1Ai2M7AsGNtm3DtjsHo9S/HC8l5UBtRAzQtcm74rpKLLed5qlzSz9O6avq?=
 =?us-ascii?Q?SO4ld7r1pT/edji8d8rNmgEs9Qv4rD4FkpylieNTQK6/Qgke8eubam+gwjrt?=
 =?us-ascii?Q?jD8X6Gqebl4AHOcKvUmLt/kY75iK0v7WFBsytuzMLCb/L5+e1k8lvytK2jsO?=
 =?us-ascii?Q?0P9uqMcq0f+Fd+EWKofpAsd9telXmXPuW7+2jN2v2JJbbPA1YBVu9Q386EJ1?=
 =?us-ascii?Q?ZY2EfB5blXLCWz7YCAH+254n2aHmmMd6XN0aIjcMDipn24uW5mb/sEGl4V6J?=
 =?us-ascii?Q?uMxkiH+KaTaWMELgZVJFRmN0t4kYpQBLOIcOJwGZmeYYMPuUBDglDSPwKOn6?=
 =?us-ascii?Q?2UdcvFjs/WfWVNrNARX1ypN4qHcO3AfTTCuuAwt43AgcdJwUI6HtrJzARmq8?=
 =?us-ascii?Q?NUCV9M3On4Oqq53BOTDJA9F7UYPXKhiZjL37n76pdrGL3ME001M743MiI4nI?=
 =?us-ascii?Q?1GoEGOGsRWIlmGox4IfWstGKxpk2XkfRomhlgCB9bQHoP/I4QGixQids+xSk?=
 =?us-ascii?Q?+GvR4KNBg6FLN8xLpD4YU1kDvE7WT4Ria4QmR6yUYyXEtnSlpXq3G5bfrcu/?=
 =?us-ascii?Q?Nvt2ssWkL7kshbQ4migeIz1HXhAA7fhBGafaKr/6gAc5RZ52cVpooaGNH+zO?=
 =?us-ascii?Q?mnCp1rYSQgZtWoqqoLpOzkyB9YinyIg9UYrVOYVFOfhez5+k7CMaXyGxj0lz?=
 =?us-ascii?Q?BH5m8UoiU4+KoX/b4U5Z9BawyPEMp4MW2TZD3HepZ0q9NY2lmuJ2hRJbynyb?=
 =?us-ascii?Q?y4TZUJurItp73CNImuId/842N6nHaLleJrvrZGTAmo73lubaNSRcRttA6jAt?=
 =?us-ascii?Q?d1pBH2+/b/1GwBnSG2zwucG3nn9kQ+NuVi/EeaMZjcPH5f8R1q01lsl+GlF/?=
 =?us-ascii?Q?OuB+uODMs3tPqwROBvnRCyfHXeYv9TpyDDoXr+IC7xtV3RJMv5h8Gh4ROO+J?=
 =?us-ascii?Q?SDoR6DOOYM/tP0QJ+keRnsw8DdGwJtYI+WviNwY+Ai1l8H567fg20gWBi3eh?=
 =?us-ascii?Q?eZMBOmQNf8BvPqIjGHfFiX5v+mE0vWkJRe0hPNy3+xbfKlmiY+1yk6LelYhZ?=
 =?us-ascii?Q?vsqDKjLnGipinURBeMv8LBJvzXJa2KgsGc6UZja8geB6lX3XMhzZDP/Tu/U9?=
 =?us-ascii?Q?6rlQ2sdJ95l7P6hxJ2QQAXSBZZOiC3bKR3dHkbjmExO3QRh1GR1bz47YAL9Z?=
 =?us-ascii?Q?y0nhQgnHLG+nziryhnndaVrfjao/G0RCDa8FNPbFe5aqGg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR03MB6370.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FYBwYn1Lvi3uJFegiyR3r8mn6YOE7FVTSBQvdChUuJvHfZ5+MhpafqBHQGCs?=
 =?us-ascii?Q?Hxva4txVrH46dpF1c6vf8a4TnjPKbsHsOeG3Prm0xvjd9zZTsk/z5l+obBK9?=
 =?us-ascii?Q?cVeiNqCiyby+WRVG3gTnJGFzQheEPe3/uf2DSQgmhWK1etpcMpHzyK7Nw2Hk?=
 =?us-ascii?Q?MZVH5bPhcPXLm3XMCs4Ty4flKqG/No+ELol+PDud2ujd1hTf/BQr28hre7+9?=
 =?us-ascii?Q?GnH6zbmQrnFFs3Ojx90nZdOLxEEHLJP2+UeR/IhPEdkOW3iwHzeB3Jin661U?=
 =?us-ascii?Q?r5u+bix3/K7U5RvUruCgq5EK3+pR1nj8sBL9DMZpl0sd1TGjXhoQxSbRFlDD?=
 =?us-ascii?Q?Uofc9VigUlEe1Tsl8kaPxAJh6maIUtY1K0RxADB4AirL148W8wsqVCfSNqgE?=
 =?us-ascii?Q?RdLTCECQQ4/Z4WbJUSsM6jNf6Hc+fXbxDYye0eOeNbNcCoahm6u7LCF90EIP?=
 =?us-ascii?Q?0I0eVFVthzjNKH2I/NZSZnfsSfK3ThWJtjBQGVOqWFsg55rSEKxWcZ/FHXp1?=
 =?us-ascii?Q?36U4F5s6XohjtY52OZTchOM+GRQwMOk8yVqUMP2zMkFOm/MOdkKfdNurKU9r?=
 =?us-ascii?Q?23YQMqvxbs7hkMDPwBqV0SquHNVFmrkTQaG/D/WpxarECzQ+bCWRasg2jIdg?=
 =?us-ascii?Q?+oI+XSiKEXxPoP/EjwSs8YVR864rsBLVYUO4Aicox5fHHhzbcgczZVr7F+k5?=
 =?us-ascii?Q?nWBMsjN5Il+Gk/2RIlJCPi8NxXenSasPca68F0MrEWr8VN+emupum/GUDdo4?=
 =?us-ascii?Q?4Owa6hlLANAI25cKVZHbizi6rl1vIWLRBKPF+8U8Mq5xaWthlt0rHtZqkaUn?=
 =?us-ascii?Q?FKO2qfeNPxbiGSXPK9d++w+8p+ruQxVEdk+6ugnksS5Ot+haqmRZ7YsYbWEP?=
 =?us-ascii?Q?vKK5MKQIh1aCrbtwNjs6Ry1D590RkFBWQ0ihG062p7F81UhcS+EAnYQzTW05?=
 =?us-ascii?Q?/2Z7FEvdgP+PZoTApiqbtlH45xLhzL8gB7512xmGMm3qSBHNju/VjbAOTRcJ?=
 =?us-ascii?Q?6u0LXD6ZmkV4j1N0mkxYH1I7bk8vEoSi+9a7Ns6thReXWzbX18121zY2256f?=
 =?us-ascii?Q?UecUaHjMGWUG6CMBKsJdgUPacvaKcarRBYWXlE66N8DtkDX6i2srzrMLuTSh?=
 =?us-ascii?Q?ZpCgcJuNgBvfR1StOqLu2v3CsVrPuAr+WQaai/G8p4c63nv2M5yENNZRMBPa?=
 =?us-ascii?Q?lphSFLJ9cFDe+1kDCvwWJTq2c1KgSHV5/OFb1bNj+VKqfSFjo6NMNREHIvuc?=
 =?us-ascii?Q?vHje7UXvDyQZ6hiJLEqOK3Tz33B3wItbrvwC2UaVLv0FDVUvOVoDmKJGxsj4?=
 =?us-ascii?Q?1yqMqW0KoxFXK0cew1pjjsPNAVtW5n2v0Rpza/PXGRLAfTIufdz1z/dPBNip?=
 =?us-ascii?Q?x71PYMhbLuh65T7iu6WdAmhQfkL2IMyXp6lMFr+DivXlLQ7BjkNP4xxcRwYK?=
 =?us-ascii?Q?bpYKiiX+I+A9Hp2QhDFSHJZTqV7waBQUMdtDklTsS5g3g0NmSLbJVBaYXU+l?=
 =?us-ascii?Q?/m5HdbuKADv+2YhUo6FS3kiCZP2XOFgi7cJlpM1lwT+wMgFS8M3Z7d6iTffz?=
 =?us-ascii?Q?9qnGEfNqhXWWS2ChAr7WzBsX43ewE+yMk2b2lZROSy2aSzL391lqRuY3L5c2?=
 =?us-ascii?Q?mg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 153e287a-05d9-46b4-868d-08dd6aaf86c9
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6370.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 08:40:27.2407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jdk1RqRK9hLbiF9yQt53CXOyXDiI4eTRutOkWSUWChElhQw3SqS0cciZa6xvaAvtDe4yQ1aTT2E372nLZfW3Y7nX+8dlMnHSHd/vt9tUkRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR03MB6958
X-Mailman-Approved-At: Mon, 24 Mar 2025 16:09:48 +0100
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

