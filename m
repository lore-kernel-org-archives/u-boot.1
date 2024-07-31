Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802E0C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 04:26:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8E8188027;
	Wed, 31 Jul 2024 06:26:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="0eJLlHVR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97B00882BE; Wed, 31 Jul 2024 06:26:06 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B164C88356
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 06:26:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mxKIf3kzAY6QwBNb4ymqGVBpDIlKY87vxGIeGpBiLNWzQ0plUB1H5SIHY9dbbaJUIX2NJXqNY3kfeBnH0egLUFkyM18a+ftZz3TV88BUwFMzMELZ0MzjhVzoQnvsHGOZQmrIavEndx953juR1I88myM2pKI1oXg8+ZhTeA32VensQO/2iUJjNvZfIkArF3xRZJ8A6IdP3UZzE4QGnHYlbPzTjuJ7aBAbjjQuKwIAY6rLRn1ypbZ0GxGYN5fkkt7NqeVoSVHjhuL8A7+c87TppfkvHvHI1JaWFtWKawguihmlDlyuMUd3xt4aNg39kvTz0u3aBSsfvcakXD5ITf+Qzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVV4zV7rRxc82rvHTXOKPWgSEPnbxoyyAHNN+pvTp9o=;
 b=OGpwCHpilbOcpTxo07J4+rXq1N73etDgYZ52A/OGvE4jPUjSmeiUk+03Jg3tmcpIfbhPYApKx/pyrtaXjrVqi3NtySxaYY1KOXh6PuOqVTsAQyGTw4WOy097SldQKr4X+VBgdZJuqSAxkkLYYIew4w5RS9iPDKSdyhbMVJOZ54J6/LDDv2q3d5GEfnK6O/q+DtXG15YUGng/YNxs1XRqld9+/ubw1uiuCfiYfYyjHTVKi8wSKeBiI128JSMPJQMuGd/IxTlLYqqRmof2ZqD5815XvtUhDhBWCD7hjuXn7RBJbcqqhGe4MPIpF7T6rxZADDW+7CNo/BAhh2s03vPxkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVV4zV7rRxc82rvHTXOKPWgSEPnbxoyyAHNN+pvTp9o=;
 b=0eJLlHVR76oyIZ6yt1lvLHfK456R1DE5f51o36XaNPViAFwG6Np+FTqH3zuZJKAu+cNi5IkpO2zlMUC8TDOFp510MViHTUkrb4iDUZaKK7B6Csw0GW7ZMS40Ceffr93epImYmNreCYATkq27rONHvEOoKKvEGlpFN1ChR0+YRynrGxU/gQ0E61oAZGIS650aeefSNPSkxbHISTUVdCDXboFBIiirJ51qyZ0Z7P4/tTyd16uylEqrMRR+V9MSTcKbYizfroljzUSGNC4nuAz+D2x7jGqUlZ3nNvPRFhH2JA+QXIgG7hDX0zGuWi+qOqaok4mElw7WcU1/bZ5nlg67zA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DB4PR08MB8125.eurprd08.prod.outlook.com (2603:10a6:10:384::19)
 by AS8PR08MB9573.eurprd08.prod.outlook.com (2603:10a6:20b:61b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19; Wed, 31 Jul
 2024 04:26:03 +0000
Received: from DB4PR08MB8125.eurprd08.prod.outlook.com
 ([fe80::e9de:ca06:dae1:ef2f]) by DB4PR08MB8125.eurprd08.prod.outlook.com
 ([fe80::e9de:ca06:dae1:ef2f%5]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 04:26:03 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Anand Moon <linux.amoon@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 1/3] cmd: mtd: add markbad command support
Date: Wed, 31 Jul 2024 08:25:50 +0400
Message-Id: <20240731042552.3840459-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240731042552.3840459-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240731042552.3840459-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0194.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::9) To DB4PR08MB8125.eurprd08.prod.outlook.com
 (2603:10a6:10:384::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR08MB8125:EE_|AS8PR08MB9573:EE_
X-MS-Office365-Filtering-Correlation-Id: 37592e3a-ea53-461f-aff5-08dcb118e352
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bHM/BA+tkNJC8LvaNbFID1WDBLqRlfoLEj1nr3DPwB7ecY2esZOaFvnWN/XK?=
 =?us-ascii?Q?T+EV48Yr8OX0rDITQ2xrUHUlpsnIoeXdOThMsmlh821k5ViM0RXptUB+Frr7?=
 =?us-ascii?Q?D3oX2zi+ZGdlld0rPqUV0bWMeb1SiEKn/TKMI4rV9NE6FIvRXempviRuoe+I?=
 =?us-ascii?Q?6zcmUKo9D8ERjUvJ2nvEOjmPcjzi7uWw3mB0dJ606dpzvoWnFolo074AW44b?=
 =?us-ascii?Q?KaWLw5iDoZf/wBN+2McsIWpgEc3TKLXtjrce+cvYmMOXyZKu+oDL9yN4seK3?=
 =?us-ascii?Q?CFo9DMjhRFfylxMcbdDs77HYTmlicA0WwEzMGnEU9rNHmGRegvOQxGzd27ha?=
 =?us-ascii?Q?xoaUtp19pn2Y8TBV/taW50vqo9T3PTBrHcsQYorOAR1SjJ1Vq6murk40O2PY?=
 =?us-ascii?Q?/lG2PE02/KePdKyd6dXBIYnvSsCe9DISywvXXwjni1LfjDLWJHpZD+w+G2T6?=
 =?us-ascii?Q?0YX6A26QP0IlO7WfI/8eNTDob/Gna/9hy741jYnInlW00WxMgekm9KWUkusZ?=
 =?us-ascii?Q?k0vqVHQHNmv/za+DFl72QMHIKyegzqZUQT+Ge3fVQtIhVjlJdzG5ys+99vYX?=
 =?us-ascii?Q?zR9EhbVnP5eDpe8yjmi2EN1lcb32076PErF/t5kEeXCn4SIG9CUmBi1F3lRt?=
 =?us-ascii?Q?47o7DSsNxbPHw0omcOUqggOF/AaRX4THFvkoHBC5glA5cOK7eMvgPk/Y5g0+?=
 =?us-ascii?Q?O+NONoKdXcge1iXKXsytOQ4l9fY/278N4Sab23ZQjl20Hns3G+kmJRK0Q95j?=
 =?us-ascii?Q?p2yy6iEFOZ5GKaMwbv0shGwVdLnU5Pw2FS72AeZy9K8E7BT67KIOgP61nhB2?=
 =?us-ascii?Q?Q+5pddN+KX3U/NvvbsQjGrpyHxUSAb8XNonJY29kM6nZJ9bDuGQyEaBP0VB1?=
 =?us-ascii?Q?bIwxJUb2jgIAJNilCUL7nJfXlC/bD1KM/y7B6Ufze2hm6NxqxK5PxXKpmnOT?=
 =?us-ascii?Q?QLKNLLFZoOHDsJEgmsp0VrE+/2VTIivBOHTTSMseOxhC5Pp18zLdTagoiMAm?=
 =?us-ascii?Q?VAQpcNG5F1/tyPCeZ59sPqwquygmsDm5tmP0OM8Ysk6KEthrOX28mq97mRwb?=
 =?us-ascii?Q?HYNs2fhnACJv4Iyg8XhSpAxPXBVthNgRt5FwscAV2VcFUq+16Nbf7BGaY/EL?=
 =?us-ascii?Q?yWOdTl4mmUxZjAh54PoORGwc/WTmSLYkdmTF/MGeKWoMbpJgHi2Z4Gqugx9l?=
 =?us-ascii?Q?2mhzJAw0+GtmUMkZVjwIsN9Hb1u40pQg7UL6YlzkRvQyoWrsI/jIg/S2XHhD?=
 =?us-ascii?Q?FeI2ASxdoDMjDmDHTPg3auRyVHDTL8tZf0ALl4HZvWVUCXQSPag50Y1BnWzo?=
 =?us-ascii?Q?kdOff5soA9ThsODpZUK/oU/3YGUN0ihq2ZCiFidX5Y4RZlZ0zR0O6tBfoUFH?=
 =?us-ascii?Q?1SeMQRQHTqgOCErz0mCMglHoE0vr7m2ZrAG/TrtuDGBOC810PC2j1m7Djurj?=
 =?us-ascii?Q?UfPLIMiM7jw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB4PR08MB8125.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GA3dYA1L41iPGiqVMcMZghjpphhfJ6MCeLRBy/xdFK6W6QYxmW9fELpbPh5E?=
 =?us-ascii?Q?+UNS8FgtinU/rXiD+9kbC3r4E0nVHu5vLx43Y6ov/ynMkl6Wd6UBYd5gWVet?=
 =?us-ascii?Q?LWbPbMgHAXc65RU3OQCK5s98xiW+qYJ89+nAiEBhfmZ6Qv9Q0R6N4R/x4797?=
 =?us-ascii?Q?N42R1Fq1PR9wuuB6D6luRInk2qydeGgY4WfKk7jdf15QHKiPdu97uH+PXbhl?=
 =?us-ascii?Q?g6lVPb2iVeKax2BPUkkN/4RfHeXrnXmyLZIQ3Qwss8USlu5Dno9aMQeJZc2/?=
 =?us-ascii?Q?RnD7hLtQ7/w7V/VBmOTy8zfgPj94sy6zgOYjLvVLMpNMrWi/k5texL7QQj1G?=
 =?us-ascii?Q?elje3jimHmvlS/JR9O9VLrQZbueIp5goi33Vf8w0sqbJlH/bW0BhZJYQzwCJ?=
 =?us-ascii?Q?zizdbLDeGECGzBNnbsIEFPDrNekcU4ZlRs7uZKhKIFiBxNLHrzPquD+aFC19?=
 =?us-ascii?Q?2Li/PHp/CpqAmX2CryQCk27qU+NLMu2rAns/Vr1cffyQW2RR/S9PsWp78go9?=
 =?us-ascii?Q?Nd107oktpLyLRpC5zACmgvSH3gvvml3n2xykqXuFDQtdwxsxgxzk4sZZSqWy?=
 =?us-ascii?Q?AYcdfEtLsubimKpx5wSPrLsU/NrAe3MbC602fC8a3OEE7uZASYxs+7PwPMTG?=
 =?us-ascii?Q?F2ialCCx12KXCzK7jKJzi1CEKdz2vCkFqLlcQzpsJShknfQ67GIfQSTBbuiu?=
 =?us-ascii?Q?Jl1gqBhyNvRBnr8xAXsENVdRBR/caI50cFqhAZH+omGdBgCuAekWpg6p5bJG?=
 =?us-ascii?Q?BKuFmK9RcHCnLa+DfcZ3GXmQzeqDTlynhNe8IKZuVe6bFduG9vBLCqqi72pf?=
 =?us-ascii?Q?xwPSwlgH+LB4MUKFOL9sBv/QZlZJ7Kw+m0wre0bBWlSLI9+dU36+PpbvQ8I9?=
 =?us-ascii?Q?67lgRVERfxZKftOEGkOk8q20+6GZHuZ/ZSnvWCEPSwoay9A1U68q2q/UIC4y?=
 =?us-ascii?Q?vRn9xCq7tPfdafefBH5T6JWhLdJX69o9Oz/KZO6Lgn37HH+MWrokX657+5iC?=
 =?us-ascii?Q?ZblncrS7qtNUw04iR/qhZAM0O8o9lDSs1rkr4/KMVBVVFiRLS9R/P8KoaxSD?=
 =?us-ascii?Q?LbUs2pQuvsJJChAegtI7rVvwcAfW/UQmmpo5BxTpnjQMduyLtWltm0nYxMgY?=
 =?us-ascii?Q?FjjtWSfijwtUDH45ucY9U6/c8p+mn7gNFS7z0mPPGujQJjnZEZ835tf8E2vX?=
 =?us-ascii?Q?c8mAOQLXbhzl/5HgckKEPnW3i/ciV7xmfJeb1Xvw1jWsWflyuD9YmxBcYIPH?=
 =?us-ascii?Q?1UtePhOwyDPHQzMrH2VlOeYmBzxPfogLdwowim/XZuosRjtQtDqXQaS6Eru2?=
 =?us-ascii?Q?MUBP7R5ncqPqe23Zk2u5fEdMOWyM9iY/7UVm1RSG8goyxip3qDQ7NDZiKJ2x?=
 =?us-ascii?Q?XP7LyOfq8Nxe9GfnAwF/vhie1tinrfpfRQn1QbmqQLmms6JzTBLEBvKydrhO?=
 =?us-ascii?Q?fABi72RXQxbKwV3PNiLt0kCtNdZiOCYVVmmSmUN8PAXYoTNiyzm5N+kDirE2?=
 =?us-ascii?Q?Edw6lnxkbOUmlJW1AudfAfSTpg+exo7eK0yzHIXItgfOl8odpxmDpb8pMzn4?=
 =?us-ascii?Q?zJqVLseDjCGr58gAo8VtFeNrKa+jBBPp/hAg5tLjPk5a5L/0w4v1K1wieZkx?=
 =?us-ascii?Q?rw=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 37592e3a-ea53-461f-aff5-08dcb118e352
X-MS-Exchange-CrossTenant-AuthSource: DB4PR08MB8125.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 04:26:03.2273 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7dPEpxvfyf3x6YnmH/P7ejolGofjGzTVDPYe9M053AdeQqJVh7kXlwqesxUFMxbMUyeNz0fYI1MT9FGL7R8Qi2zqvwCb76dSeYuGuiA4Zok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9573
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

Some nand flashes (like spi-nand one) are registered with mtd
subsystem only, thus nand command can't be used to work with
such flashes. As result some functionality is missing.

This patch implements 'nand markbad' functionality for mtd command.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 cmd/Kconfig |  6 ++++++
 cmd/mtd.c   | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 978f44eda42..53ebafcb610 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1433,6 +1433,12 @@ config CMD_MTD_OTP
 	help
 	  MTD commands for OTP access.
 
+config CMD_MTD_MARKBAD
+	bool "mtd markbad"
+	depends on CMD_MTD
+	help
+	  MTD markbad command support.
+
 config CMD_MUX
 	bool "mux"
 	depends on MULTIPLEXER
diff --git a/cmd/mtd.c b/cmd/mtd.c
index 795aaa2b37d..45084d39d3a 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -691,6 +691,57 @@ out_put_mtd:
 	return ret;
 }
 
+#ifdef CONFIG_CMD_MTD_MARKBAD
+static int do_mtd_markbad(struct cmd_tbl *cmdtp, int flag, int argc,
+			  char *const argv[])
+{
+	struct mtd_info *mtd;
+	loff_t off;
+	int ret = 0;
+
+	if (argc < 3)
+		return CMD_RET_USAGE;
+
+	mtd = get_mtd_by_name(argv[1]);
+	if (IS_ERR_OR_NULL(mtd))
+		return CMD_RET_FAILURE;
+
+	if (!mtd_can_have_bb(mtd)) {
+		printf("Only NAND-based devices can have bad blocks\n");
+		goto out_put_mtd;
+	}
+
+	argc -= 2;
+	argv += 2;
+	while (argc > 0) {
+		off = hextoul(argv[0], NULL);
+		if (!mtd_is_aligned_with_block_size(mtd, off)) {
+			printf("Offset not aligned with a block (0x%x)\n",
+			       mtd->erasesize);
+			ret = CMD_RET_FAILURE;
+			goto out_put_mtd;
+		}
+
+		ret = mtd_block_markbad(mtd, off);
+		if (ret) {
+			printf("block 0x%08llx NOT marked as bad! ERROR %d\n",
+			       off, ret);
+			ret = CMD_RET_FAILURE;
+		} else {
+			printf("block 0x%08llx successfully marked as bad\n",
+			       off);
+		}
+		--argc;
+		++argv;
+	}
+
+out_put_mtd:
+	put_mtd_device(mtd);
+
+	return ret;
+}
+#endif
+
 static int do_mtd_bad(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[])
 {
@@ -773,6 +824,9 @@ U_BOOT_LONGHELP(mtd,
 	"mtd otpwrite                          <name> <off> <hex string>\n"
 	"mtd otplock                           <name> <off> <size>\n"
 	"mtd otpinfo                           <name> [u|f]\n"
+#endif
+#ifdef CONFIG_CMD_MTD_MARKBAD
+	"mtd markbad                           <name>         <off> [<off> ...]\n"
 #endif
 	"\n"
 	"With:\n"
@@ -807,5 +861,9 @@ U_BOOT_CMD_WITH_SUBCMDS(mtd, "MTD utils", mtd_help_text,
 					     mtd_name_complete),
 		U_BOOT_SUBCMD_MKENT_COMPLETE(erase, 4, 0, do_mtd_erase,
 					     mtd_name_complete),
+#ifdef CONFIG_CMD_MTD_MARKBAD
+		U_BOOT_SUBCMD_MKENT_COMPLETE(markbad, 20, 0, do_mtd_markbad,
+					     mtd_name_complete),
+#endif
 		U_BOOT_SUBCMD_MKENT_COMPLETE(bad, 2, 1, do_mtd_bad,
 					     mtd_name_complete));
-- 
2.39.2

