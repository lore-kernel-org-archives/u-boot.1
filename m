Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE3CEC5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 12:29:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 71B1380E11;
	Mon, 24 Aug 2026 12:29:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pl8rTVYZY6H5; Mon, 24 Aug 2026 12:28:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787574538;
	bh=9+CqtSOhg7w+GmKM1TUO1/GH+EJzLnF5x3TpMHa/IH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oJ1xjWyQ+kMcRiw6C2/Z0t5+ViwP2zibm41SanVIWNnmSjjjrtEIksyfq9RG4csV3
	 mXTzSbWGYYyGeorBJGYJ4xqajQBO9NdVbvzC3bFMulLt7SEzn2F1ePgek6zaNkl/rq
	 ngV2FJKUTKP9m6jYXdLUFakBxj57CTvK1lfUV9yV1plpj9WcsdCg0k+dpjOj/Bc+yx
	 UD24Qh7bi+p3rp7w6BzKY8xqSZVgxoUkcMHAOU6jvNko6i/JCXseK447FjJaXW7RNc
	 1IWcCKwpqhB+fd0Q8zXksGMozri8+a7wD5lf1uc7soNU7qqGaPD17tbNGXScqRbdki
	 86IJhKEmWJ5Nw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 297AF80DF9;
	Mon, 24 Aug 2026 12:28:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B486B386
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 12:28:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A68A560659
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 12:28:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zVeOFkfjDC5g for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 12:28:51 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=vladimir.oltean@nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=N6znIt2s
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CC3C960650
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 12:28:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IfTDgD+QLGDaX52GSuwpofi30S0VdzK8FOSKaGmSPhPIiO/PnN+NOcb/UW1vJ/rgLYnDcUqw5qnwYuKmEvtmQcp08V1gy260GGlFVquC5JG4jTkGkeaNgsR2IepSBmMeTiAtFDXZZlrA+Z0n0UtJv/x8GVQFLCMH8sNv+e1Wr+7eXzM5NIhBxv3JOjc8xI2GXfYSaUJmsFwpI3YpFf2I4YOYiE/GqaEF7zR1M14preJEQaXZZBmSrjjnEFHnGCDACBmGIKI5MvKTIEK05Vw4+1hEwxygVBW2X8JkCyLEp8ElfNPcQ/NXY4gvktt+sA0O8BePcmA3gejtbU3HLP9rvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+CqtSOhg7w+GmKM1TUO1/GH+EJzLnF5x3TpMHa/IH4=;
 b=T514fijW25z8c3xvGhQylcKgfWGHbep+NmteYdgbcZlsI34YxQry6mQgXHTS+bu7cZkSk7QsYo/kmI3tFjGx1JJiwiSw21W7DfNaZsKlAtsyOlvYmOUkAorJyc/B3Y2h5KS16VQMwdLsiw6BPxqNG69kUUa8SKkVlBkF/KXM0zO9ypSZw/xmlJuIK9yXirfTIvTHwT8NMouoYw/v8PXPDxDD1cFK8AGR2y2NvLsHOg/NmSiEQBCP4fI6VElTsXZhfbn4lf+FkRgjhoom9rB3lhqxYtnfGMnqmfO+fGOICrbgObaC2UsINO7xb7zDic/cPBbKTAzftN9UEXxbM0nmBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+CqtSOhg7w+GmKM1TUO1/GH+EJzLnF5x3TpMHa/IH4=;
 b=N6znIt2sOKLseXcNhbPbRTLeix3qmmxuebWSO4dknb1G2+p/8L3Rv78/vkXI9aH7pJRbdiQ+zTYRJhIHRVzGlRqgpX5OeXX/7gzK6i4Xlvkz3iDV8XokKka1fWnBacQZqLA0ezU1CnuaH9AbReDs5uz2rPy/vAXoMGv18pdftAZnGwumDXZU3neiHVv3TcpRfweNVAURf+VBwcrk/l9ylHh9ydf37nqV37jRVbMbIdsP5jdTkbJIW1ooosNLVTACJ6l8LnQr+MJ/FkyajNjzDt1c+2NW1kceXMmHsxlWtY9o9PKhdV4aDj6v/u5QtSDEd7vTpV7MqDVFfG5yo+Qjxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by GVXPR04MB9879.eurprd04.prod.outlook.com (2603:10a6:150:11c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 12:28:45 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 12:28:45 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Peng Fan <peng.fan@nxp.com>,
	u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/6] configs: layerscape: drop CONFIG_SYS_PBSIZE=532 override
Date: Mon, 24 Aug 2026 15:28:23 +0300
Message-Id: <20260824122825.95712-5-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260824122825.95712-1-vladimir.oltean@nxp.com>
References: <20260824122825.95712-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::20) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|GVXPR04MB9879:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c6c7236-cd78-4ae2-09a8-08df01db3dd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|23010399003|376014|1800799024|10067099003|3023799007|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: BWePcvTwNJS/xsAGU8Xqt72V9tCsmJY3+6ParfY08pKvWZxrxJrO73I/dW8hpBcc4LlduzdM5+Dif3vmD3cPc1HteqltD1Rm9M+egsvElmnhlTLIPKsXyCN6qj6G/9JCjNzQJFL1dYPSxEXk68UDoilVrWusZ9Ktey4HPetr8QIN+nryKxnYC07iz5OTPyUIdCHjQzpXZjbvelw9Tzl6pMcC9JpGEhVZxYFmskPxFZV2snk8H4ShqnAenbPk4Jit/xJLCFbaSC/l+h2QGYG497gfBuSpP90o286/UafrgjCFUE6q16Xo8kWvZwEMVhEzXFkra1B1nS/FSnmFq6xuWLW9hjWRhIGhJe+kVS8wev96msP2KQh6Gyx4mo/XYRjFHDpS+dnEiHFGlXmQxDhLXnLQ6C+dwuLh/Kft4rr8IDxtgl6Ijd0rOtQFzBnF88qbAYLVm8K+GBFmnk/fSt4bWbNB4011pnfSPahiN2vAa5luDLp3YiPF46S+zKRJvTlcID4G2iNrj4mmOfXY9558PNVt87D6E21lOzxtYcMwwfDXAhhpeZrJ5xo0xJJHrBuJ8JLMrWuRIQtRAgzTfxgcZYcdEt2Z8Sq9SZ9X4O9g7Ax/LLQxyvyJWH3ZW1xUjacHTE/WYLwwD9NJAJMW7lf7pkUYULWNdqJqIe3k1IBg8jQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6900.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(23010399003)(376014)(1800799024)(10067099003)(3023799007)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iBVC4BqpgBlD0mAXqF9zixMnlCgsW9pqZgI8gkjCo9RFrk1p9J6IgjVfiSHK?=
 =?us-ascii?Q?MB3pjLPf+hN2J9Fo53qF0fBsbbkhvAnyc2Lr0jYcmiIGxPyvi4m6gVEC4FEf?=
 =?us-ascii?Q?r+5Jpqz/9a46/kw9waU+GnIxEndShYqqdnYkuNZzi9BGHkJboZD/F/xgRR8/?=
 =?us-ascii?Q?Q4oIh6rS2cgH6HfD379nu/+p0WDMm7l1rxA8OZgo75wH1bSL/rKYmR4n5fkf?=
 =?us-ascii?Q?icP5+vL5qffUkbnF7qRlqkZh8MaXZsV5u4xYGWGi1h/Ub1jCHa4Eq+CrioT3?=
 =?us-ascii?Q?92dH2F6OHh+VmdgO9g8EXEY2tiG01SQIzqfchulGr4kiCoAie02ZiKKl+EES?=
 =?us-ascii?Q?K86r2WfD3XICzWvcKlYcHpA9Y4GbBfqgNki367ZymtzyUh3920bE6/PVPfQ6?=
 =?us-ascii?Q?+LAMsrxXjlucbPkAD1ev0ZFeffwC8HTBKheBla7INd8NACWyGRv5fPtVCCak?=
 =?us-ascii?Q?EK03W/+vnIAa8Uf5FW+yFGpZViedHzi1d8YERoPBOc8/dhGNUtDvu9a9TyUY?=
 =?us-ascii?Q?VG2vbrHnLJSAShvLmzc5reI9UKgK+VhpbANul3v/pTHWHqleBbDunY6T6NQt?=
 =?us-ascii?Q?X2U4V5Z3VcIqQ2Ej58fLcEC5N3lcmGUlWLz8i0ZiKWHQcx2+cwg9t9hz2swn?=
 =?us-ascii?Q?RNR5SFNazJrKOlJFp6HeqawTmBDBxN9+wr76gfrbMO0TSodgAli2Fz/dv59X?=
 =?us-ascii?Q?kbJwEX3g+dN+S25KFaogiUyTkzVdiGixAk1Lslzn2m72RX2wwiy9adUS9H/B?=
 =?us-ascii?Q?GBqScEeo92m4efiGPGg/ZoYKvflop80T+iPs2NXyoMmqhI8R+uSzZyD0OLpu?=
 =?us-ascii?Q?EnVJC9naBX0sRu16dVeueyR1fCaX+4bc+WdztLMcNG4NpiGFs2mYu6bioVaN?=
 =?us-ascii?Q?vIqFUqyCfe+Chsj/MlbOQkKtT/rETuGOWO/qQ0Ktv+xCJqSDVYQ2XwLNwdwq?=
 =?us-ascii?Q?NaPZ5RxXa/n+RX5yKtWm+NOa7ouxKt1IrjumInMr+Zmlb6RfV8qJmvizVqig?=
 =?us-ascii?Q?QCRfwHEs/REDqxD38IfPKdk9zBjfhf/kupTv8gawTArJRCRkQ8VgDl4WcP5i?=
 =?us-ascii?Q?Nfynq+YW7RilXja/eS6XOV+reYtgeJlGONBIUCslsknzAhpz7k89uX3kRoai?=
 =?us-ascii?Q?4BrfiHRiwkiFr+XVGMBh3fVSvOsJR/suqEnZJbmx8jf5UB+Z5oodg84RZV8A?=
 =?us-ascii?Q?b+FS0JkSeDRmPeqBRG/5AeGAswLkPFDTN7wE3yLXpqD8vXrvLEtG/qs7b/4z?=
 =?us-ascii?Q?ALGidFTKfJkVXBAl7ZJaRkBP/y8iWveqi6j6lUbhQfOltHi6+CPMy7BSRlte?=
 =?us-ascii?Q?Ri46p5YXJuqOorHJNYydefb/p09mEZbPUzZ4sbRCNyRACMu7Iode3Q3mzNmu?=
 =?us-ascii?Q?kCHYASfNKYDDukWt73TJl0G2iicKGN/+ztmxUUbR7mGmpztmWTYKt5jOnnJ3?=
 =?us-ascii?Q?wXal5CJJTQxRGp5fLeAn+sgbLPsBjY3l5azcR0RmA7vt6XuMAxgtBRxetEYj?=
 =?us-ascii?Q?IHGPBxR7vm5rKlVfKFnZlJn8eku3CODQcwtTIPLQven78e1y2qiIiFXznSNu?=
 =?us-ascii?Q?LxGfJ4zb1f3oCZlM+HKwhN8vWoCeYcHCdzrukngKwcHyDuOfGyYiXAtwHJIA?=
 =?us-ascii?Q?AQfoBAKQnVWrISt9z34LScqBZxsqHLRg2v2jVnKqqzbAYZP1njwZ58Yc9YuF?=
 =?us-ascii?Q?QrySa7hUF9bVCYqs1Yb9Z0iAvGOLETPUVluOhSryzuky/XCw/byeQVdUiQZq?=
 =?us-ascii?Q?OjM/Sbp9vw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c6c7236-cd78-4ae2-09a8-08df01db3dd8
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 12:28:45.8703 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u86kkdWtpg1tBvXWkDTBPS9WksJVvqX2n/wKd/EL7WjZERHLpbkHKEB04CyL8+l72axqR12VsDiViQmFGexaog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9879
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

All Layerscape defconfigs (FSL_LSCH2 and FSL_LSCH3) carry an explicit
CONFIG_SYS_PBSIZE=532, which was set to match the 512-byte SYS_CBSIZE
default that applies to those SoCs (512 + 20 bytes of prompt headroom
= 532).

The Kconfig default for SYS_PBSIZE is 1044, which corresponds to the
generic 1024-byte SYS_CBSIZE default.  The per-board override of 532
was only necessary because the FSL_LSCH2/LSCH3 CBSIZE default was
lower than the generic one.

Drop the explicit CONFIG_SYS_PBSIZE=532 from all 40 affected Layerscape
defconfigs in preparation for removing FSL_LSCH2 and FSL_LSCH3 from
the 512-byte SYS_CBSIZE special case.  After this commit SYS_PBSIZE
will be 1044 (the Kconfig default), which matches the upcoming 1024-byte
CBSIZE.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 configs/ls1012a2g5rdb_tfa_defconfig            | 1 -
 configs/ls1012afrdm_tfa_defconfig              | 1 -
 configs/ls1012afrwy_tfa_SECURE_BOOT_defconfig  | 1 -
 configs/ls1012afrwy_tfa_defconfig              | 1 -
 configs/ls1012aqds_tfa_SECURE_BOOT_defconfig   | 1 -
 configs/ls1012aqds_tfa_defconfig               | 1 -
 configs/ls1012ardb_tfa_SECURE_BOOT_defconfig   | 1 -
 configs/ls1012ardb_tfa_defconfig               | 1 -
 configs/ls1028aqds_tfa_SECURE_BOOT_defconfig   | 1 -
 configs/ls1028aqds_tfa_defconfig               | 1 -
 configs/ls1028aqds_tfa_lpuart_defconfig        | 1 -
 configs/ls1028ardb_tfa_SECURE_BOOT_defconfig   | 1 -
 configs/ls1028ardb_tfa_defconfig               | 1 -
 configs/ls1043aqds_tfa_SECURE_BOOT_defconfig   | 1 -
 configs/ls1043aqds_tfa_defconfig               | 1 -
 configs/ls1043ardb_tfa_SECURE_BOOT_defconfig   | 1 -
 configs/ls1043ardb_tfa_defconfig               | 1 -
 configs/ls1046afrwy_tfa_SECURE_BOOT_defconfig  | 1 -
 configs/ls1046afrwy_tfa_defconfig              | 1 -
 configs/ls1046aqds_tfa_SECURE_BOOT_defconfig   | 1 -
 configs/ls1046aqds_tfa_defconfig               | 1 -
 configs/ls1046ardb_tfa_SECURE_BOOT_defconfig   | 1 -
 configs/ls1046ardb_tfa_defconfig               | 1 -
 configs/ls1088aqds_tfa_defconfig               | 1 -
 configs/ls1088ardb_tfa_SECURE_BOOT_defconfig   | 1 -
 configs/ls1088ardb_tfa_defconfig               | 1 -
 configs/ls2080aqds_nand_defconfig              | 1 -
 configs/ls2080aqds_qspi_defconfig              | 1 -
 configs/ls2080ardb_nand_defconfig              | 1 -
 configs/ls2088aqds_tfa_defconfig               | 1 -
 configs/ls2088ardb_tfa_SECURE_BOOT_defconfig   | 1 -
 configs/ls2088ardb_tfa_defconfig               | 1 -
 configs/lx2160aqds_tfa_SECURE_BOOT_defconfig   | 1 -
 configs/lx2160aqds_tfa_defconfig               | 1 -
 configs/lx2160ardb_tfa_SECURE_BOOT_defconfig   | 1 -
 configs/lx2160ardb_tfa_defconfig               | 1 -
 configs/lx2160ardb_tfa_stmm_defconfig          | 1 -
 configs/lx2162aqds_tfa_SECURE_BOOT_defconfig   | 1 -
 configs/lx2162aqds_tfa_defconfig               | 1 -
 configs/lx2162aqds_tfa_verified_boot_defconfig | 1 -
 40 files changed, 40 deletions(-)

diff --git a/configs/ls1012a2g5rdb_tfa_defconfig b/configs/ls1012a2g5rdb_tfa_defconfig
index 32a710ce726c..34ef697ba251 100644
--- a/configs/ls1012a2g5rdb_tfa_defconfig
+++ b/configs/ls1012a2g5rdb_tfa_defconfig
@@ -23,7 +23,6 @@ CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 quiet lpj=250000"
-CONFIG_SYS_PBSIZE=532
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_CMD_GREPENV=y
diff --git a/configs/ls1012afrdm_tfa_defconfig b/configs/ls1012afrdm_tfa_defconfig
index fbdeb970a75a..2706658562ec 100644
--- a/configs/ls1012afrdm_tfa_defconfig
+++ b/configs/ls1012afrdm_tfa_defconfig
@@ -24,7 +24,6 @@ CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 quiet lpj=250000"
-CONFIG_SYS_PBSIZE=532
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_CMD_GREPENV=y
diff --git a/configs/ls1012afrwy_tfa_SECURE_BOOT_defconfig b/configs/ls1012afrwy_tfa_SECURE_BOOT_defconfig
index 3cd8993cc814..09ebd2a9cdbc 100644
--- a/configs/ls1012afrwy_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1012afrwy_tfa_SECURE_BOOT_defconfig
@@ -24,7 +24,6 @@ CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 quiet lpj=250000"
-CONFIG_SYS_PBSIZE=532
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_CMD_GREPENV=y
diff --git a/configs/ls1012afrwy_tfa_defconfig b/configs/ls1012afrwy_tfa_defconfig
index ea45d639f367..fb8cbac788b6 100644
--- a/configs/ls1012afrwy_tfa_defconfig
+++ b/configs/ls1012afrwy_tfa_defconfig
@@ -24,7 +24,6 @@ CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 quiet lpj=250000"
-CONFIG_SYS_PBSIZE=532
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_CMD_GREPENV=y
diff --git a/configs/ls1012aqds_tfa_SECURE_BOOT_defconfig b/configs/ls1012aqds_tfa_SECURE_BOOT_defconfig
index 8a7547aea224..f30d989d3c10 100644
--- a/configs/ls1012aqds_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1012aqds_tfa_SECURE_BOOT_defconfig
@@ -29,7 +29,6 @@ CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 quiet lpj=250000"
 # CONFIG_USE_BOOTCOMMAND is not set
-CONFIG_SYS_PBSIZE=532
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_MISC_INIT_R=y
diff --git a/configs/ls1012aqds_tfa_defconfig b/configs/ls1012aqds_tfa_defconfig
index 9d5d88e75e9c..7bc9e44d8e79 100644
--- a/configs/ls1012aqds_tfa_defconfig
+++ b/configs/ls1012aqds_tfa_defconfig
@@ -29,7 +29,6 @@ CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 quiet lpj=250000"
 # CONFIG_USE_BOOTCOMMAND is not set
-CONFIG_SYS_PBSIZE=532
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_MISC_INIT_R=y
diff --git a/configs/ls1012ardb_tfa_SECURE_BOOT_defconfig b/configs/ls1012ardb_tfa_SECURE_BOOT_defconfig
index 67960f2dc93a..6e9faeba8581 100644
--- a/configs/ls1012ardb_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1012ardb_tfa_SECURE_BOOT_defconfig
@@ -26,7 +26,6 @@ CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 quiet lpj=250000"
 # CONFIG_USE_BOOTCOMMAND is not set
-CONFIG_SYS_PBSIZE=532
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_CMD_GREPENV=y
diff --git a/configs/ls1012ardb_tfa_defconfig b/configs/ls1012ardb_tfa_defconfig
index eb6a06212444..150185983a14 100644
--- a/configs/ls1012ardb_tfa_defconfig
+++ b/configs/ls1012ardb_tfa_defconfig
@@ -25,7 +25,6 @@ CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 quiet lpj=250000"
-CONFIG_SYS_PBSIZE=532
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_CMD_GREPENV=y
diff --git a/configs/ls1028aqds_tfa_SECURE_BOOT_defconfig b/configs/ls1028aqds_tfa_SECURE_BOOT_defconfig
index a97d628653a3..79562890d1a6 100644
--- a/configs/ls1028aqds_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1028aqds_tfa_SECURE_BOOT_defconfig
@@ -30,7 +30,6 @@ CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 ramdisk_size=0x2000000 default_hugepagesz=2m hugepagesz=2m hugepages=256 video=1920x1080-32@60 cma=256M"
-CONFIG_SYS_PBSIZE=532
 CONFIG_MISC_INIT_R=y
 CONFIG_ID_EEPROM=y
 CONFIG_CMD_GREPENV=y
diff --git a/configs/ls1028aqds_tfa_defconfig b/configs/ls1028aqds_tfa_defconfig
index 49070a40bc31..1a90386f42b8 100644
--- a/configs/ls1028aqds_tfa_defconfig
+++ b/configs/ls1028aqds_tfa_defconfig
@@ -32,7 +32,6 @@ CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 ramdisk_size=0x2000000 default_hugepagesz=2m hugepagesz=2m hugepages=256 video=1920x1080-32@60 cma=256M"
-CONFIG_SYS_PBSIZE=532
 CONFIG_MISC_INIT_R=y
 CONFIG_ID_EEPROM=y
 CONFIG_CMD_GREPENV=y
diff --git a/configs/ls1028aqds_tfa_lpuart_defconfig b/configs/ls1028aqds_tfa_lpuart_defconfig
index 82cbbe081e31..5961fd643ba6 100644
--- a/configs/ls1028aqds_tfa_lpuart_defconfig
+++ b/configs/ls1028aqds_tfa_lpuart_defconfig
@@ -31,7 +31,6 @@ CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 ramdisk_size=0x2000000 default_hugepagesz=2m hugepagesz=2m hugepages=256 video=1920x1080-32@60 cma=256M"
-CONFIG_SYS_PBSIZE=532
 CONFIG_MISC_INIT_R=y
 CONFIG_ID_EEPROM=y
 CONFIG_CMD_GREPENV=y
diff --git a/configs/ls1028ardb_tfa_SECURE_BOOT_defconfig b/configs/ls1028ardb_tfa_SECURE_BOOT_defconfig
index a8c7c89c9d31..aefda5c9e6cd 100644
--- a/configs/ls1028ardb_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1028ardb_tfa_SECURE_BOOT_defconfig
@@ -31,7 +31,6 @@ CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 ramdisk_size=0x2000000 default_hugepagesz=2m hugepagesz=2m hugepages=256 video=1920x1080-32@60 cma=256M"
-CONFIG_SYS_PBSIZE=532
 CONFIG_ID_EEPROM=y
 CONFIG_CMD_GREPENV=y
 CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=5
diff --git a/configs/ls1028ardb_tfa_defconfig b/configs/ls1028ardb_tfa_defconfig
index ca19d6035ee7..4e15e87624f6 100644
--- a/configs/ls1028ardb_tfa_defconfig
+++ b/configs/ls1028ardb_tfa_defconfig
@@ -33,7 +33,6 @@ CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 ramdisk_size=0x2000000 default_hugepagesz=2m hugepagesz=2m hugepages=256 video=1920x1080-32@60 cma=256M"
-CONFIG_SYS_PBSIZE=532
 CONFIG_ID_EEPROM=y
 CONFIG_CMD_GREPENV=y
 CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=5
diff --git a/configs/ls1043aqds_tfa_SECURE_BOOT_defconfig b/configs/ls1043aqds_tfa_SECURE_BOOT_defconfig
index 4957d7c0208f..7e8d98c78404 100644
--- a/configs/ls1043aqds_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1043aqds_tfa_SECURE_BOOT_defconfig
@@ -40,7 +40,6 @@ CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 mtdparts=60000000.nor:2m@0x100000(nor_bank0_uboot),40m@0x1100000(nor_bank0_fit),7m(nor_bank0_user),2m@0x4100000(nor_bank4_uboot),40m@0x5100000(nor_bank4_fit),-(nor_bank4_user);7e800000.flash:1m(nand_uboot),1m(nand_uboot_env),20m(nand_fit);spi0.0:1m(uboot),5m(kernel),1m(dtb),9m(file_system)"
 # CONFIG_USE_BOOTCOMMAND is not set
-CONFIG_SYS_PBSIZE=532
 CONFIG_MISC_INIT_R=y
 CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_IMLS=y
diff --git a/configs/ls1043aqds_tfa_defconfig b/configs/ls1043aqds_tfa_defconfig
index db8a4e299973..e8fc4c9c1b57 100644
--- a/configs/ls1043aqds_tfa_defconfig
+++ b/configs/ls1043aqds_tfa_defconfig
@@ -41,7 +41,6 @@ CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 mtdparts=60000000.nor:2m@0x100000(nor_bank0_uboot),40m@0x1100000(nor_bank0_fit),7m(nor_bank0_user),2m@0x4100000(nor_bank4_uboot),40m@0x5100000(nor_bank4_fit),-(nor_bank4_user);7e800000.flash:1m(nand_uboot),1m(nand_uboot_env),20m(nand_fit);spi0.0:1m(uboot),5m(kernel),1m(dtb),9m(file_system)"
 # CONFIG_USE_BOOTCOMMAND is not set
-CONFIG_SYS_PBSIZE=532
 CONFIG_MISC_INIT_R=y
 CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_IMLS=y
diff --git a/configs/ls1043ardb_tfa_SECURE_BOOT_defconfig b/configs/ls1043ardb_tfa_SECURE_BOOT_defconfig
index eb4c9a4e2539..7a7b0f1e2328 100644
--- a/configs/ls1043ardb_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1043ardb_tfa_SECURE_BOOT_defconfig
@@ -32,7 +32,6 @@ CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 mtdparts=60000000.nor:2m@0x100000(nor_bank0_uboot),40m@0x1100000(nor_bank0_fit),7m(nor_bank0_user),2m@0x4100000(nor_bank4_uboot),40m@0x5100000(nor_bank4_fit),-(nor_bank4_user);7e800000.flash:1m(nand_uboot),1m(nand_uboot_env),20m(nand_fit);spi0.0:1m(uboot),5m(kernel),1m(dtb),9m(file_system)"
-CONFIG_SYS_PBSIZE=532
 CONFIG_MISC_INIT_R=y
 CONFIG_CMD_IMLS=y
 CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=5
diff --git a/configs/ls1043ardb_tfa_defconfig b/configs/ls1043ardb_tfa_defconfig
index bb50990fe020..1c47cf006aa7 100644
--- a/configs/ls1043ardb_tfa_defconfig
+++ b/configs/ls1043ardb_tfa_defconfig
@@ -33,7 +33,6 @@ CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 mtdparts=60000000.nor:2m@0x100000(nor_bank0_uboot),40m@0x1100000(nor_bank0_fit),7m(nor_bank0_user),2m@0x4100000(nor_bank4_uboot),40m@0x5100000(nor_bank4_fit),-(nor_bank4_user);7e800000.flash:1m(nand_uboot),1m(nand_uboot_env),20m(nand_fit);spi0.0:1m(uboot),5m(kernel),1m(dtb),9m(file_system)"
-CONFIG_SYS_PBSIZE=532
 CONFIG_MISC_INIT_R=y
 CONFIG_CMD_IMLS=y
 CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=5
diff --git a/configs/ls1046afrwy_tfa_SECURE_BOOT_defconfig b/configs/ls1046afrwy_tfa_SECURE_BOOT_defconfig
index 5bcc9091fd03..2a8863a57a0e 100644
--- a/configs/ls1046afrwy_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1046afrwy_tfa_SECURE_BOOT_defconfig
@@ -26,7 +26,6 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 mtdparts=1550000.spi:1m(rcw),15m(u-boot),48m(kernel.itb);7e800000.flash:16m(nand_uboot),48m(nand_kernel),448m(nand_free)"
-CONFIG_SYS_PBSIZE=532
 CONFIG_MISC_INIT_R=y
 CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=5
 CONFIG_CMD_DM=y
diff --git a/configs/ls1046afrwy_tfa_defconfig b/configs/ls1046afrwy_tfa_defconfig
index db6790352d11..a7f7f038e8fe 100644
--- a/configs/ls1046afrwy_tfa_defconfig
+++ b/configs/ls1046afrwy_tfa_defconfig
@@ -28,7 +28,6 @@ CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 mtdparts=1550000.spi:1m(rcw),15m(u-boot),48m(kernel.itb);7e800000.flash:16m(nand_uboot),48m(nand_kernel),448m(nand_free)"
-CONFIG_SYS_PBSIZE=532
 CONFIG_MISC_INIT_R=y
 CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=5
 CONFIG_CMD_DM=y
diff --git a/configs/ls1046aqds_tfa_SECURE_BOOT_defconfig b/configs/ls1046aqds_tfa_SECURE_BOOT_defconfig
index 9717e85465eb..43699af49a1b 100644
--- a/configs/ls1046aqds_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1046aqds_tfa_SECURE_BOOT_defconfig
@@ -40,7 +40,6 @@ CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 mtdparts=60000000.nor:2m@0x100000(nor_bank0_uboot),40m@0x1100000(nor_bank0_fit),7m(nor_bank0_user),2m@0x4100000(nor_bank4_uboot),40m@0x5100000(nor_bank4_fit),-(nor_bank4_user);7e800000.flash:4m(nand_uboot),36m(nand_kernel),472m(nand_free);spi0.0:2m(uboot),14m(free)"
 # CONFIG_USE_BOOTCOMMAND is not set
-CONFIG_SYS_PBSIZE=532
 CONFIG_MISC_INIT_R=y
 CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_IMLS=y
diff --git a/configs/ls1046aqds_tfa_defconfig b/configs/ls1046aqds_tfa_defconfig
index aaff575c6b18..31668b74af8e 100644
--- a/configs/ls1046aqds_tfa_defconfig
+++ b/configs/ls1046aqds_tfa_defconfig
@@ -41,7 +41,6 @@ CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 mtdparts=60000000.nor:2m@0x100000(nor_bank0_uboot),40m@0x1100000(nor_bank0_fit),7m(nor_bank0_user),2m@0x4100000(nor_bank4_uboot),40m@0x5100000(nor_bank4_fit),-(nor_bank4_user);7e800000.flash:4m(nand_uboot),36m(nand_kernel),472m(nand_free);spi0.0:2m(uboot),14m(free)"
 # CONFIG_USE_BOOTCOMMAND is not set
-CONFIG_SYS_PBSIZE=532
 CONFIG_MISC_INIT_R=y
 CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_IMLS=y
diff --git a/configs/ls1046ardb_tfa_SECURE_BOOT_defconfig b/configs/ls1046ardb_tfa_SECURE_BOOT_defconfig
index 3b8427d80c89..5cfa67202276 100644
--- a/configs/ls1046ardb_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1046ardb_tfa_SECURE_BOOT_defconfig
@@ -31,7 +31,6 @@ CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 mtdparts=1550000.spi-0:1m(rcw),15m(u-boot),48m(kernel.itb);7e800000.flash:16m(nand_uboot),48m(nand_kernel),448m(nand_free)"
-CONFIG_SYS_PBSIZE=532
 CONFIG_MISC_INIT_R=y
 CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=5
 CONFIG_CMD_DM=y
diff --git a/configs/ls1046ardb_tfa_defconfig b/configs/ls1046ardb_tfa_defconfig
index 2e4b5937dfee..62ce430901f4 100644
--- a/configs/ls1046ardb_tfa_defconfig
+++ b/configs/ls1046ardb_tfa_defconfig
@@ -32,7 +32,6 @@ CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 mtdparts=1550000.spi-0:1m(rcw),15m(u-boot),48m(kernel.itb);7e800000.flash:16m(nand_uboot),48m(nand_kernel),448m(nand_free)"
-CONFIG_SYS_PBSIZE=532
 CONFIG_MISC_INIT_R=y
 CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=5
 CONFIG_CMD_DM=y
diff --git a/configs/ls1088aqds_tfa_defconfig b/configs/ls1088aqds_tfa_defconfig
index 65521d4208c2..0184c20cf590 100644
--- a/configs/ls1088aqds_tfa_defconfig
+++ b/configs/ls1088aqds_tfa_defconfig
@@ -35,7 +35,6 @@ CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 ramdisk_size=0x3000000 default_hugepagesz=2m hugepagesz=2m hugepages=256"
-CONFIG_SYS_PBSIZE=532
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_MISC_INIT_R=y
diff --git a/configs/ls1088ardb_tfa_SECURE_BOOT_defconfig b/configs/ls1088ardb_tfa_SECURE_BOOT_defconfig
index 6c0e9078d2f2..6e2d9884c4bd 100644
--- a/configs/ls1088ardb_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1088ardb_tfa_SECURE_BOOT_defconfig
@@ -33,7 +33,6 @@ CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 ramdisk_size=0x3000000 default_hugepagesz=2m hugepagesz=2m hugepages=256"
 # CONFIG_USE_BOOTCOMMAND is not set
-CONFIG_SYS_PBSIZE=532
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_MISC_INIT_R=y
diff --git a/configs/ls1088ardb_tfa_defconfig b/configs/ls1088ardb_tfa_defconfig
index 7d9e2d9de0b6..e04a1800d607 100644
--- a/configs/ls1088ardb_tfa_defconfig
+++ b/configs/ls1088ardb_tfa_defconfig
@@ -35,7 +35,6 @@ CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 ramdisk_size=0x3000000 default_hugepagesz=2m hugepagesz=2m hugepages=256"
 # CONFIG_USE_BOOTCOMMAND is not set
-CONFIG_SYS_PBSIZE=532
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_MISC_INIT_R=y
diff --git a/configs/ls2080aqds_nand_defconfig b/configs/ls2080aqds_nand_defconfig
index d57dde171c8e..4d99509166e6 100644
--- a/configs/ls2080aqds_nand_defconfig
+++ b/configs/ls2080aqds_nand_defconfig
@@ -37,7 +37,6 @@ CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 ramdisk_size=0x2000000 default_hugepagesz=2m hugepagesz=2m hugepages=256"
 CONFIG_BOOTCOMMAND="fsl_mc apply dpl 0x580d00000 && cp.b $kernel_start $kernel_load $kernel_size && bootm $kernel_load"
-CONFIG_SYS_PBSIZE=532
 CONFIG_RESET_PHY_R=y
 CONFIG_SPL_MAX_SIZE=0x16000
 CONFIG_SPL_PAD_TO=0x20000
diff --git a/configs/ls2080aqds_qspi_defconfig b/configs/ls2080aqds_qspi_defconfig
index e49aa2343d6f..daa1a040aa75 100644
--- a/configs/ls2080aqds_qspi_defconfig
+++ b/configs/ls2080aqds_qspi_defconfig
@@ -28,7 +28,6 @@ CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 ramdisk_size=0x2000000 default_hugepagesz=2m hugepagesz=2m hugepages=256"
 CONFIG_BOOTCOMMAND="fsl_mc apply dpl 0x580d00000 && cp.b $kernel_start $kernel_load $kernel_size && bootm $kernel_load"
-CONFIG_SYS_PBSIZE=532
 CONFIG_RESET_PHY_R=y
 CONFIG_CMD_GREPENV=y
 CONFIG_CMD_EEPROM=y
diff --git a/configs/ls2080ardb_nand_defconfig b/configs/ls2080ardb_nand_defconfig
index 86ab21af634d..1a1e7b365cf6 100644
--- a/configs/ls2080ardb_nand_defconfig
+++ b/configs/ls2080ardb_nand_defconfig
@@ -42,7 +42,6 @@ CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS1,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0600 ramdisk_size=0x2000000 default_hugepagesz=2m hugepagesz=2m hugepages=256"
 CONFIG_BOOTCOMMAND="env exists mcinitcmd && env exists secureboot && esbc_validate 0x5806C0000; env exists mcinitcmd && fsl_mc lazyapply dpl 0x580d00000;run distro_bootcmd;run nor_bootcmd; env exists secureboot && esbc_halt;"
-CONFIG_SYS_PBSIZE=532
 CONFIG_MISC_INIT_R=y
 CONFIG_RESET_PHY_R=y
 CONFIG_SPL_MAX_SIZE=0x16000
diff --git a/configs/ls2088aqds_tfa_defconfig b/configs/ls2088aqds_tfa_defconfig
index e2e8c843dad9..089b038b2f84 100644
--- a/configs/ls2088aqds_tfa_defconfig
+++ b/configs/ls2088aqds_tfa_defconfig
@@ -29,7 +29,6 @@ CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 ramdisk_size=0x2000000 default_hugepagesz=2m hugepagesz=2m hugepages=256"
-CONFIG_SYS_PBSIZE=532
 CONFIG_RESET_PHY_R=y
 CONFIG_CMD_IMLS=y
 CONFIG_CMD_GREPENV=y
diff --git a/configs/ls2088ardb_tfa_SECURE_BOOT_defconfig b/configs/ls2088ardb_tfa_SECURE_BOOT_defconfig
index a11f66940220..9762fb1dc45e 100644
--- a/configs/ls2088ardb_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls2088ardb_tfa_SECURE_BOOT_defconfig
@@ -33,7 +33,6 @@ CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS1,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0600 ramdisk_size=0x2000000 default_hugepagesz=2m hugepagesz=2m hugepages=256"
-CONFIG_SYS_PBSIZE=532
 CONFIG_MISC_INIT_R=y
 CONFIG_RESET_PHY_R=y
 CONFIG_CMD_IMLS=y
diff --git a/configs/ls2088ardb_tfa_defconfig b/configs/ls2088ardb_tfa_defconfig
index 6a46523249fe..df305e6ac367 100644
--- a/configs/ls2088ardb_tfa_defconfig
+++ b/configs/ls2088ardb_tfa_defconfig
@@ -35,7 +35,6 @@ CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS1,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0600 ramdisk_size=0x2000000 default_hugepagesz=2m hugepagesz=2m hugepages=256"
-CONFIG_SYS_PBSIZE=532
 CONFIG_MISC_INIT_R=y
 CONFIG_RESET_PHY_R=y
 CONFIG_CMD_IMLS=y
diff --git a/configs/lx2160aqds_tfa_SECURE_BOOT_defconfig b/configs/lx2160aqds_tfa_SECURE_BOOT_defconfig
index 196b5203a929..95c01ce28f9c 100644
--- a/configs/lx2160aqds_tfa_SECURE_BOOT_defconfig
+++ b/configs/lx2160aqds_tfa_SECURE_BOOT_defconfig
@@ -33,7 +33,6 @@ CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyAMA0,115200 root=/dev/ram0 earlycon=pl011,mmio32,0x21c0000 ramdisk_size=0x2000000 default_hugepagesz=1024m hugepagesz=1024m hugepages=2 pci=pcie_bus_perf"
-CONFIG_SYS_PBSIZE=532
 CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_MISC_INIT_R=y
 CONFIG_RESET_PHY_R=y
diff --git a/configs/lx2160aqds_tfa_defconfig b/configs/lx2160aqds_tfa_defconfig
index f5cbfbcbce79..6a53b7e9549b 100644
--- a/configs/lx2160aqds_tfa_defconfig
+++ b/configs/lx2160aqds_tfa_defconfig
@@ -36,7 +36,6 @@ CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyAMA0,115200 root=/dev/ram0 earlycon=pl011,mmio32,0x21c0000 ramdisk_size=0x2000000 default_hugepagesz=1024m hugepagesz=1024m hugepages=2 pci=pcie_bus_perf"
-CONFIG_SYS_PBSIZE=532
 CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_MISC_INIT_R=y
 CONFIG_RESET_PHY_R=y
diff --git a/configs/lx2160ardb_tfa_SECURE_BOOT_defconfig b/configs/lx2160ardb_tfa_SECURE_BOOT_defconfig
index 81a9d791c872..80f8bf4e3d8d 100644
--- a/configs/lx2160ardb_tfa_SECURE_BOOT_defconfig
+++ b/configs/lx2160ardb_tfa_SECURE_BOOT_defconfig
@@ -34,7 +34,6 @@ CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyAMA0,115200 root=/dev/ram0 earlycon=pl011,mmio32,0x21c0000 ramdisk_size=0x2000000 default_hugepagesz=1024m hugepagesz=1024m hugepages=2 pci=pcie_bus_perf"
-CONFIG_SYS_PBSIZE=532
 CONFIG_MISC_INIT_R=y
 CONFIG_RESET_PHY_R=y
 CONFIG_CMD_GREPENV=y
diff --git a/configs/lx2160ardb_tfa_defconfig b/configs/lx2160ardb_tfa_defconfig
index 4e9e59e6c905..c42380bd30dd 100644
--- a/configs/lx2160ardb_tfa_defconfig
+++ b/configs/lx2160ardb_tfa_defconfig
@@ -37,7 +37,6 @@ CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyAMA0,115200 root=/dev/ram0 earlycon=pl011,mmio32,0x21c0000 ramdisk_size=0x2000000 default_hugepagesz=1024m hugepagesz=1024m hugepages=2 pci=pcie_bus_perf"
-CONFIG_SYS_PBSIZE=532
 CONFIG_MISC_INIT_R=y
 CONFIG_RESET_PHY_R=y
 CONFIG_CMD_GREPENV=y
diff --git a/configs/lx2160ardb_tfa_stmm_defconfig b/configs/lx2160ardb_tfa_stmm_defconfig
index 65b832c89ecb..c9ac596bcff7 100644
--- a/configs/lx2160ardb_tfa_stmm_defconfig
+++ b/configs/lx2160ardb_tfa_stmm_defconfig
@@ -38,7 +38,6 @@ CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyAMA0,115200 root=/dev/ram0 earlycon=pl011,mmio32,0x21c0000 ramdisk_size=0x2000000 default_hugepagesz=1024m hugepagesz=1024m hugepages=2 pci=pcie_bus_perf"
-CONFIG_SYS_PBSIZE=532
 CONFIG_MISC_INIT_R=y
 CONFIG_RESET_PHY_R=y
 CONFIG_CMD_GREPENV=y
diff --git a/configs/lx2162aqds_tfa_SECURE_BOOT_defconfig b/configs/lx2162aqds_tfa_SECURE_BOOT_defconfig
index c8696505eede..758f324dd2a9 100644
--- a/configs/lx2162aqds_tfa_SECURE_BOOT_defconfig
+++ b/configs/lx2162aqds_tfa_SECURE_BOOT_defconfig
@@ -33,7 +33,6 @@ CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyAMA0,115200 root=/dev/ram0 earlycon=pl011,mmio32,0x21c0000 ramdisk_size=0x2000000 default_hugepagesz=1024m hugepagesz=1024m hugepages=2 pci=pcie_bus_perf"
-CONFIG_SYS_PBSIZE=532
 CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_MISC_INIT_R=y
 CONFIG_ID_EEPROM=y
diff --git a/configs/lx2162aqds_tfa_defconfig b/configs/lx2162aqds_tfa_defconfig
index 838935d859e4..4dc099c5f088 100644
--- a/configs/lx2162aqds_tfa_defconfig
+++ b/configs/lx2162aqds_tfa_defconfig
@@ -36,7 +36,6 @@ CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyAMA0,115200 root=/dev/ram0 earlycon=pl011,mmio32,0x21c0000 ramdisk_size=0x2000000 default_hugepagesz=1024m hugepagesz=1024m hugepages=2 pci=pcie_bus_perf"
-CONFIG_SYS_PBSIZE=532
 CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_MISC_INIT_R=y
 CONFIG_ID_EEPROM=y
diff --git a/configs/lx2162aqds_tfa_verified_boot_defconfig b/configs/lx2162aqds_tfa_verified_boot_defconfig
index 80a6c4a63e24..8313c71fab31 100644
--- a/configs/lx2162aqds_tfa_verified_boot_defconfig
+++ b/configs/lx2162aqds_tfa_verified_boot_defconfig
@@ -37,7 +37,6 @@ CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyAMA0,115200 root=/dev/ram0 earlycon=pl011,mmio32,0x21c0000 ramdisk_size=0x2000000 default_hugepagesz=1024m hugepagesz=1024m hugepages=2 pci=pcie_bus_perf"
-CONFIG_SYS_PBSIZE=532
 CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_MISC_INIT_R=y
 CONFIG_ID_EEPROM=y
-- 
2.34.1

