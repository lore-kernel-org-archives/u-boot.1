Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D460EFF8864
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 05:12:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 655BD846E7;
	Wed, 29 Apr 2026 07:12:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Pce3wp+9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EAD284701; Wed, 29 Apr 2026 07:12:23 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24920846CB
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 07:12:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4JrABTORG4TRTB4EUGCNcaGyuaQeedDGyjsq9bgN3LEPQpIMteKBsXfxzr3WaroBrlQPfPB6lR515nxbfsPyejsMgbSZYJ4vYJH2VP5xxf3g3MZOCzMl0k01GasdjA+x5/3DLCskIU28OWsFZs6E6mINd0X+agdIobYQxtbTxv8k1NnA/M/VyanaV9r06E9rdEPYw/Dzgr2k0xCZe78j9EMh7T+K+tHlcJjYTOInKuSvXsguaz6NQIifQvPfKRG7xXMDO5Sv7wFVvLbIxISUTwjHA4Fch8ZJ7Z8Mh6ufQMpKkM6KHeniFVPXSZ11kUnE1+41eGh7UOn1x6XpDch7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIuHBQkgqd64K2y0Q3Lfim31ptJXrfmLvOb000ZVWK4=;
 b=bATS72OXJuL76c69eSrSZP2TcMNEuQhJcRB9reW9F7oy4zHZ3JxFKUoXs/GoEUjN16rtWrv5Uwh5hBz9cJsw4145YrDF1MKQCieA1JbBO/7fMdEwBQRp4uebBSIs9vUxz0oxl3Lirf3Bi1ORlxu/EVM8tXh58U0CRcEA5nWsxydokdW7Al8cPcqos7Y16/yBCJURlWy1ewE5McGoGHvyNEAcaFuBHCGek9rOo2l9EawHutQs0T3YW4qYP9XLlRNhoYduAoJzp9nJl5xckKL+Q1WO0pZJ8hW7e9czJu06Ag1bsrWupCPexmQG6/NkeOFupt0Wxo7IV1atW/33Zi6GUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIuHBQkgqd64K2y0Q3Lfim31ptJXrfmLvOb000ZVWK4=;
 b=Pce3wp+9VpNIWNwQgzHN1KEzh5G4R/XD3XPnmeo/mKHIevR9uorVlpRA/av6dIduKwHnc5ubSIVDojs35FONigei/mGdf5SVbtqqvXH4OHYFyH8VbrdiG9m42C8G5bvo0aXIs4/SCl/GbVLN+LbFkLtFMvVAnJp49RhpPvunDSAlCrOX7VprbbT9wAZ0ENOTbe3OdPYfB4ZIN6oW/cDpD28EqFSmAsuRp3gq2pTUqrXEsV8SjycO4loOv0SreS7sPfpZpT6kU7zAPnhcuKAopM/DmO+AG+6i1wkUhQiCw8hrzQCBYSoTWin8agdNC3jey5W+hzqAMfkPRymzIUm0uA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by DM6PR03MB5259.namprd03.prod.outlook.com (2603:10b6:5:245::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Wed, 29 Apr
 2026 05:12:18 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9870.016; Wed, 29 Apr 2026
 05:12:18 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Dinh Nguyen <dinguyen@kernel.org>,
 Heiko Schocher <hs@nabladev.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Peng Fan <peng.fan@nxp.com>,
 Wojciech Szamocki <wojciech.szamocki@nokia.com>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>
Subject: [PATCH 3/3] configs: socfpga_arria10_defconfig: Enable I2C as default
Date: Wed, 29 Apr 2026 13:11:18 +0800
Message-ID: <69a41eff6ce34bda3b39a6b8340968a1174f7a93.1777439293.git.dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1777439293.git.dinesh.maniyam@altera.com>
References: <cover.1777439293.git.dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0064.namprd03.prod.outlook.com
 (2603:10b6:a03:331::9) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|DM6PR03MB5259:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c15b0ce-2da0-471d-c4fc-08dea5ade23c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|55112099003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: dNK9bZPQjnMJm9/VtleANQ8t4RDShLpT863mblychoTICMP0Q6VnMYMTWhgmjLw1dTKLj2D/w0zOp/2LCPe7EdMdXBEh0vokTxhNCb+CBo+gaLle1iVKRp0G7S0NDxfgwtrliPnZYYUqkBRtbt3+IxOOby2KtnrABE71vqur39SwPBtkxygJOmQIrXL3CGFPeu0jjDbc/4LTGUQiSXLymfQbwNn0RFq/XKLON8PCjONN/MirvWK49LjkbM3SPR0tqb0Fj1TnRzcjyXJRHhECvYQx/r4ye71ti4plUTgklnXAHl82TEcPN64oWgipH7Ve61CY35PfLFeHxpYgFb7Zz5w8VkNaJ/am7pgqSTrhz0caqPn3cL4WRjQwOfcTCkW0dgrLPuympgcVWkD2FigQygKggMP8UmhWOmefOLYeSexOLQMH3J09bLWU/jC5468/F/McPP30/pCqUSGwUJSgqQqb+Jt0BpC1txJ8TvI2ETUddmSvnae+D9K8uoOrcnLLaEH+Eg5IHRTZWJ0UgxNjMhjAMLgk5ZHuWuvtEvLLzkjO5JWJVKC2cRdKD0nO+afebSMDyWHu9eBWnGE/O8GSRdq66u4zI0gBM9jFPeow6E4f6WYJKSkXZby+uM1HmXJLHr9DUGnJm7q6OazHXGd/bzr18rQTeGkLu6VPPFN2lC8BezlNJUL/6EzXsiDb8tL14/1KF+jYeJkkg1jP167QvN271REvDYBao043minjAcw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rk0qMl8VysoxkG5oc96Ed4HGl79eLo5JEVYHnTrhNZp2xjGXkWV3Q3zv/pmw?=
 =?us-ascii?Q?dZGqzeYDMLCX1gGkMTcJB0P2YnvctKW93hd7ZBGcK0mD9eQeQIyThBJ7B1/M?=
 =?us-ascii?Q?JFu7z36ktk50FcHQ+es4tdYpOJYpWMenFsk5pKT5A6f9oVoSz5eAELfPuzxq?=
 =?us-ascii?Q?gxEDS2896fgJfSgXoKZvRLUfOraGK2c4zvBD/gtGkWXphbgUFAhHnQxd72B0?=
 =?us-ascii?Q?Gcx+giqp0AQ2UdWGjVIFmFYU3X9MQMkKUVKvEejBNCicy2VcDRC/TxjWuW7W?=
 =?us-ascii?Q?JJhqrMPEuvy0iKyZtoI8MlcPiEWSZf7A9FUR3HNeJn4sPpf6drPKuTEVIuLZ?=
 =?us-ascii?Q?kjp7WCc5XcBU/dgw7N7lSfLPidxsy0RNxFHG7rH5IbZse/LC1gRE0o0MKAZ3?=
 =?us-ascii?Q?epZGud5jcJ7JciEvn8/qmqmP1Pzca1/lkeqeQKqoJSJOpTqA3YdhaLmqPqby?=
 =?us-ascii?Q?DfB6P5lzm4Khw2nlSgTLf/8QJmv4sS58EOB3I4Uo1c4DwsLQjmYdWk/qLomj?=
 =?us-ascii?Q?JZJxY8Rv90TJTAYyNAGGHasw1jjZ3BZGXu6yIrKh4KLI4/cJK42I3rWxL/Qo?=
 =?us-ascii?Q?ekYDSLZTTH0XmREDb6DgQuVr/zJ0cdjCfcqR3BzFRk5JDJ/f/O1QQXuUSToK?=
 =?us-ascii?Q?3C3acGa3PLMatD7Vzf5IDnsworlozFjdmojE4XmyBmBgjcc5RH0elFGnqSS6?=
 =?us-ascii?Q?Ke9g8Uu9CuwXcVVC08R0BB06M/JAkqIBWkGIVTQuxGwmdc8O77oeDfm3DteN?=
 =?us-ascii?Q?lucV3TQLfm2ThHzAI9AIigenaqiHxIQEeaABj5llR+xxIotgYHCgMck/rXwg?=
 =?us-ascii?Q?wWgnIVCG6ZR42clNWb/eXPxMXVntkORgai8Dn7eeFAnMb84v8wc3jDHFbFEU?=
 =?us-ascii?Q?fXkBX37gctGIS3h4H4yAStL2WhBnj/w2UWE5VZw33P+wNr4YYAjcTpG9Dk9Z?=
 =?us-ascii?Q?a5gNU6ncpkS3iIg/knJ/Gj0x+0dViY+fm87oyarT6ZesS8MugzfjW2j7ecVa?=
 =?us-ascii?Q?fTTHBPuGllKiIQsxyHREZSfIiiRKTBo6R3yF0TZjK/U3CgRflujiROlEmzHs?=
 =?us-ascii?Q?tcz19pYKt+ftcMuo93ED8dP1LPerkz4f2mw3QzklihOlzi+1un4rxZhe0E3V?=
 =?us-ascii?Q?vgeoq8ZwYCXjFnHiS95rJ56CZYccHbT79du3w3ef+IIdPNjHbxIGb/PIIBGC?=
 =?us-ascii?Q?Z6jcogKGtIrcBU5ELNHxoS3BlIxnMPjZFiT5K9AaO0ZSYxShTGczTQ/VFwQ0?=
 =?us-ascii?Q?derxCsYYShtN45xKgI9TJNA0rzcabd6CjdAwh10RSNXsKiVvWvcqBShwYTEf?=
 =?us-ascii?Q?YmKcv1RrtzLxggAfRreAZSnlqLZoyuude70a3nUrDfl2svelvr5bu6pKdEzS?=
 =?us-ascii?Q?thJRrO+SH14upIByaXwVudoo6NtJFvMpXD1thj8oj0dv6trUOJFowGitITPs?=
 =?us-ascii?Q?ed3r7jl+3Bq71R5b4bWcrF6W8+i0kCO8yvB84U/zDZprLxI41tTGr57cniy0?=
 =?us-ascii?Q?fMRgE+WTscLMZCTsqo8abZ1vL8O50bGUsoKokkodjVIicWd8MX1MkrbEYXFc?=
 =?us-ascii?Q?wcDq5/QarWBqQqQJJ/mHmmclBL5rg8SGzcv5BPX7+eRhG2THZ3UnUvAxWPqh?=
 =?us-ascii?Q?Z8bzeeysTGy+Kbt5vmhPyCCV7sa1yPu1bm5CmtjLM8ylLiX/Nj0iPhyjUIK3?=
 =?us-ascii?Q?ULHDUbKs9MCfPfMDXDe7uJclSOatrvqcODRAAoRlhtRRVplzCWCrrNSS4Zp5?=
 =?us-ascii?Q?cmHRgsrBnTGrsfv3cXzm6+gfvFcy7Rs=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c15b0ce-2da0-471d-c4fc-08dea5ade23c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 05:12:18.2569 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RCi+9SUOmVzX6Ki1o/1WUmwwe/n819JbZWbq59ioFR+7gVU87T25Q7x8aAlLP71yBswe/M5P0qR8WKvUXhUW5EXude1ocdSoNceq3K5N16I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5259
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

Enable I2C as default for Arria 10 defconfig so that this driver
can be covered by U-Boot's regtest.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 configs/socfpga_arria10_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/socfpga_arria10_defconfig b/configs/socfpga_arria10_defconfig
index b32f40ae408..56f5c20f87d 100644
--- a/configs/socfpga_arria10_defconfig
+++ b/configs/socfpga_arria10_defconfig
@@ -41,6 +41,7 @@ CONFIG_SYS_MAXARGS=32
 CONFIG_CMD_ASKENV=y
 CONFIG_CMD_GREPENV=y
 CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_CACHE=y
@@ -52,6 +53,7 @@ CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_DWAPB_GPIO=y
+CONFIG_SYS_I2C_DW=y
 CONFIG_FS_LOADER=y
 CONFIG_SPL_FS_LOADER=y
 CONFIG_SYS_MMC_MAX_BLK_COUNT=256
-- 
2.43.7

