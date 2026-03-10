Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99CBFD2D74
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 13:16:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78CE684113;
	Tue, 10 Mar 2026 14:12:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hXAmLRMm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5869F83981; Tue, 10 Mar 2026 12:44:15 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 766ED83FA7
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 12:44:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simona.toaca@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wz2hi8XP0XGZjJzuZb4ZHsz77mndaThhQkumv3D2YOsnKLQwq3ZL46NiMtYnbvF8nEBBh4kEv1uy9MWLVWdOaQKioCDmLH1VcSWB/loSkljZ/YC0hIYQQNSeYLymYGk1JP/0+G6TvZTEfEg7SZkgP/4QzgcaQbz0Uv5giF6DejT5FoG+k9/V1NKndeodDy9GyqcdPcPuhAchvdxzUceqdgqirq+0pOYjwOKmmIzByT/YGS/7E0/DO2ANgz3bpXOwUDRZ6ImLrriNm45EzfFvlaDETh5qR6hJ75K/VD/KK01EqNxDJOG5pPtJ2lR3V+B6zBS5ipChA4JkcTcJYHtUcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gx1Up+oTabniSbXDwWoxx4osKHZibfZjIRFO0ORYssc=;
 b=HzK0FxFFzPZV2Gcp7doioNv4oieBhh5UVQ4yxiOKCkNRd91rnEtRIvlMUMehcxB712DsPIanHjbmspx3tYwf1BkvyP++hi4ySZnLISP3YTW9UxkZXs/2lknU/ktjT0M7a8QJ1j3tYT8cByRbJXwHdM8eYH721qdq+G+DyVItAxGne5HHAJEx9u+YPsjAfNZ4fqeq7e9Hoi1vsvbyW/Nwp8ukt0/vANN8jfXWFM/m8Roopu9FZ+PAmdE4F4Ayh0SB6bCeWoJ/NSkuxB0CwmBuSfyvlUglPcKdTEOddOziomV7B7u/fV7vwV150mz/3liy7bxFKmiy1YRg6ltGSbqq7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gx1Up+oTabniSbXDwWoxx4osKHZibfZjIRFO0ORYssc=;
 b=hXAmLRMmjp0mmaAvsxx+0fkzP0dz6UWBNTAELq1B6kWvnKAs20KP7lTdzhlGydVGKJn92dfJB/7vBXxGqtrKwf3ekyJJsUV/31QPXaj313MijvwuHKzqHig7XlqKCqN8L73slnch4lMIKYC9Pp0kTjT5x6EaUi6bqRzX3Ew7GPOI1kx5hN60l0F7SMGAnEeClOZCc+cumJBqf6+q3Iw0VudDB10nPqpfqx297+v90SRbJ/Wv8z3wj3obM5HJQezHl0WZi+AEiLXVJzRebnD0lKXnqcMbjqxcR3APALMwVEUftGahv9pr9sJkUU0fEi9ZtHT682zxTS/qSxcnywJsqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com (2603:10a6:800:306::9)
 by AS8PR04MB8753.eurprd04.prod.outlook.com (2603:10a6:20b:42c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 11:44:11 +0000
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7]) by VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7%4]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 11:44:11 +0000
From: "Simona Toaca (OSS)" <simona.toaca@oss.nxp.com>
To: uboot-imx@nxp.com,
	u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, ye.li@nxp.com, simona.toaca@nxp.com,
 viorel.suman@nxp.com, marex@nabladev.com, ravi@prevas.dk,
 fedor.ross@ifm.com, sebastien.szymanski@armadeus.com,
 joao.goncalves@toradex.com, ji.luo@nxp.com, semen.protsenko@linaro.org,
 sjg@chromium.org, tharvey@gateworks.com, ping.bai@nxp.com,
 qijian.guo@nxp.com
Subject: [PATCH 5/5] doc: board: nxp: Add Quickboot documentation
Date: Tue, 10 Mar 2026 13:54:24 +0200
Message-ID: <945f1fbbb192e62824e7950869eaa8ffdb04bc4c.1773137310.git.simona.toaca@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773137310.git.simona.toaca@nxp.com>
References: <cover.1773137310.git.simona.toaca@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0002.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::7) To VI0PR04MB11917.eurprd04.prod.outlook.com
 (2603:10a6:800:306::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11917:EE_|AS8PR04MB8753:EE_
X-MS-Office365-Filtering-Correlation-Id: 1263ec4c-646f-4a65-0e86-08de7e9a5891
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|7416014|1800799024|366016; 
X-Microsoft-Antispam-Message-Info: Q3vbkOaZM3eAw6LavMLDKHXq7kg/9CkRCF0ic1nD+x/QMstJuv2rOaEx/+xGZK4e6ogY0mqLSk2JXwolDeljB2lTyU572TYqrUg2jcDbNG7NgSmIWl21lwyL3LWrnjSbKthjUezRBFH9rw8ZDI8JzLshyW0Im7c4/ZgyS/aFbNTsOhWcxbAntCSLIvHO/+ILjBzElEFXBKkgivgZO0mkqKgzDMMHcs7s/J1liqNKYAk52m0ueU0TS8L/NEvNhO1wmC6rZiyA7e8e8SW2S98nJW4mII2QbDBRHXmONYhHlF8/kRfoQ0VzYX5K6DOx4THnz/EoGov6PGoMWgG8MFxLbVRywuZa4xJvoHZO4VqeNFTqdaCg0oTe0GMJ9vhJj4rdUotiRYjFtUGQXbDt8gmXnzIkDZOSGkMo98VxVnOG1oEoPNDzlFfug0LyL52za8aeN4eJQZIoV/HwxQbWiQ6dIbsTFNK4dWLqsHdwCCDMZyJly+Y5LAYy9T2A/7JUvG/SuVzLMTYrITBfKNPHc3vFf1UfIMC8y6cuY6ATzYsm3gvzAwmQITZLydJQfjV10ngG4X0W84VIMperN6Bf6TpNCzRV/W4Z5Iabyc0sq8kxjSxrIW+cFbChWy3EVfOfkmVsMFmn1w1nQ5cTffSzXBwds8JRX+3wFrhNBE7jM7adiM1a85tOLqQkwHIDsprA+iDz9DeZKScoon8P+Jx/7tPrTXU1BopwFDk+pKqoB5JFx/M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR04MB11917.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(7416014)(1800799024)(366016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bleqwmabnr+SFJ0gddEV5u9HH/fSeY10MBnE0gFUCWMuR8havR5nli1gughK?=
 =?us-ascii?Q?OGumXRSfjOo8kZgNMKdbb1oBk0VJ+lMoaVc9lriF9Sbb9HqAW7YX+erL+52+?=
 =?us-ascii?Q?9AOJdLcMh+/Cl0vHslTLQGFRV9Fv3zE0oPWERSDRQg5ctKTW1aGV3odrBhDJ?=
 =?us-ascii?Q?DumGK2MZcLtjMiZ56wAvQO4Yc51gya7yLLzRYuEwZVaW3XU9zMnrNx6hdQoG?=
 =?us-ascii?Q?NwvGLOX3hy3nrO7gUTbuzRHOvJW1VqUpX9t1OtJox+NwxzBEPN27gsCLvB+N?=
 =?us-ascii?Q?16PDdOUMEXE0Xnd9nU7EuEqCQ/2SgnXn51wEnzuAXXlrNuM5TA4iCQd0L4OZ?=
 =?us-ascii?Q?jE2K+LuS80frV9JHEl9lTEohrQ5//wYooo/MaVM9u20wBxju0ubnw+2M6cIo?=
 =?us-ascii?Q?TxUomNfqLWbEka3c40SYGCaxuc9pUTa9MF7bGtMzS0MOYNpfe7O0DsO0tKCC?=
 =?us-ascii?Q?VqLI7AbMSVLHOhBjON3KmKxSexrncqTDtQPE5sHNs1hHfO8AIRYqOavXdFGp?=
 =?us-ascii?Q?QSHicoXtUPdfWTQzdzCXlaU1bOwfnDaGX9MACTTgVPJjjhKB/ja7H0bnTbug?=
 =?us-ascii?Q?pIYNMKLImqV3cVhuCZuGvZ9I60wvNQYf/M5jmAUzQhKBK1iHh7wEadbwLLwH?=
 =?us-ascii?Q?mli0KekYJkTYx2PjV1LxhEcdJc+2LmQoPT8DyJErK/d2C1Q1aUeUC61QLu3a?=
 =?us-ascii?Q?wdBaXz+P3N5MxgIcMeGVh58qI32SuF5K2Dbyxifjn4o52bih+VaYKVtdHEZU?=
 =?us-ascii?Q?4U7Ujl+JaOW4Z723gkM3KtFNy/BZEtgdhJ9cAJ9OM7PEujZqPx79iMkTv78f?=
 =?us-ascii?Q?sO+nRtIjqW7y4739Xy2knSO3jsGQJ7eEb7IboHdtDDZGRkQwFYIeMsUtq2Dt?=
 =?us-ascii?Q?vR9nRAZ7s1dmsjxTyabStFO1xhJcsBxHwQpw725EmyDgTGnwZmxOCEhpYhlP?=
 =?us-ascii?Q?gFlu6KNy0BFTzWy0pSb/iNNncvsv4VFVv0Pue0jJXfLqUfevJy8kEZfvv1ze?=
 =?us-ascii?Q?CK2BiQx1zvnC5zS3M1X29u+n9XiYnOwP0GF5hrsmLdEMGm6Z9jsz3qbXQFSf?=
 =?us-ascii?Q?pySPBNUgvCxSpVdePhDhdotKEZmcC6yy5V61oM6WdqhGeKarS71095AiOsyK?=
 =?us-ascii?Q?jp43WTpYqhN9IJiRuLBGDjUnJhrLutC3UKl2nmsTgOZAtK6XgFm9SYlFENNw?=
 =?us-ascii?Q?VZldP8VknU7YK6gqSvWrYY/QE0RQWoF5i5QkQUAs2u//z5L0aNRFnrIk5p7a?=
 =?us-ascii?Q?APr571YLgZRds7kn3UbgzSSkyVsNSm1qXB3eBy+QQPWF+u+YYFfN84K42Q7f?=
 =?us-ascii?Q?BBFRAhNkzJKk0cKPmWk1dKHO44fdlubPUwUI6l9Gc31KbNCVpl6UZal/Ys2A?=
 =?us-ascii?Q?SJVo5c1M0GFeUAajA4QzVJ407ONoEecTaEWONME4veg7eG5eaQBmFikJWNKm?=
 =?us-ascii?Q?LbpP2dFPBrghDdhMGJRGd16kfjdBW+C2AMmUgjX6JW1GqVUJGP6pgxjEIIE9?=
 =?us-ascii?Q?04cDF4d256XImgw/uA+qO5QHsAVsMLTTYVbDeNzMwXGHmbxQXFaNmu2/XeHt?=
 =?us-ascii?Q?LLuJ4l8+ZdhGIMSEVywwnANUDoPxGW52/YzVYq/Ef20xAAvlGes5ZihnP4cZ?=
 =?us-ascii?Q?/MiIMpOJchg5e6NTqDEr/BbbQ4D/217y50YNH0XK/4EtymdlKK4m4igGNND8?=
 =?us-ascii?Q?uz5v0ZJ+pCME/+62zkygUoibPYEyjHErxLoBzmKWStKMWW93cEpE54AyKebn?=
 =?us-ascii?Q?188zbqO5Jg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1263ec4c-646f-4a65-0e86-08de7e9a5891
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11917.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 11:44:11.0905 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 11rd1TqnVF/w8+dgs9tFCvC8NQqZyHu+YH9gznPWD+cv4YFr76s7lGCOspNFunZy2jpteos3HmObsFM/DcqZxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8753
X-Mailman-Approved-At: Tue, 10 Mar 2026 14:12:35 +0100
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

From: Simona Toaca <simona.toaca@nxp.com>

Add instructions on how to use U-Boot to save
DDR training data to NVM.

Signed-off-by: Simona Toaca <simona.toaca@nxp.com>
---
 doc/board/nxp/index.rst |  1 +
 doc/board/nxp/qb.rst    | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100644 doc/board/nxp/qb.rst

diff --git a/doc/board/nxp/index.rst b/doc/board/nxp/index.rst
index 01d3468a47d..7e3e5e29880 100644
--- a/doc/board/nxp/index.rst
+++ b/doc/board/nxp/index.rst
@@ -29,3 +29,4 @@ NXP Semiconductors
    mx6ullevk
    rproc
    psb
+   qb
diff --git a/doc/board/nxp/qb.rst b/doc/board/nxp/qb.rst
new file mode 100644
index 00000000000..ba673ecff24
--- /dev/null
+++ b/doc/board/nxp/qb.rst
@@ -0,0 +1,33 @@
+.. SPDX-License-Identifier: GPL-2.0+
+   Copyright 2026 NXP
+
+DDR QuickBoot flow
+------------------
+
+Some NXP boards (which use OEI - iMX943, iMX95) support saving DDR
+training data to non-volatile memory, which is then available to OEI
+at next cold reboot. OEI uses the saved data to run Quickboot flow and
+avoid training the DDR again. This significantly reduces the boot time.
+
+There are 2 ways to save this data:
+
+1. automatically, in SPL (by enabling CONFIG_SPL_IMX_QB)
+
+- this will save the data on the current boot device (e.g. SD)
+- other configs specific to the boot device need to be enabled (CONFIG_SPL_MMC_WRITE for saving to eMMC/SD)
+
+2. using qb command in U-Boot console (by enabling CONFIG_CMD_IMX_QB)
+
+- supports saving on the current boot device, or on another, specified device.
+- if flashing via uuu, the command can be added in an uuu script (boot device needs to be specified)
+- after save, the data in volatile memory is erased, so saving can happen only once per DDR training
+
+::
+
+        # To save/erase on current boot device
+        => qb save/erase
+
+        # To save/erase on other boot device
+        => qb save/erase mmc 0 # eMMC
+        => qb save/erase mmc 1 # SD
+        => qb save/erase spi   # NOR SPI
-- 
2.43.0

