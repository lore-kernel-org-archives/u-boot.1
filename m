Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10984E74AE0
	for <u-boot@archiver.kernel.org>; Wed, 24 Dec 2025 08:24:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44ECB841DA;
	Wed, 24 Dec 2025 09:24:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="WqsC9ldg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3430841E3; Wed, 24 Dec 2025 09:24:25 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36EE2841D2
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 09:24:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mBf2/VOw52NK+1pO+G7JtXD95qZk9DpaCd/ir3Ig7hCIf0dGF/YJF51bSyyF9GslPRX0LAzlna74WW6YAIcdUy6A2hj/Iro3tYRxDGk6zdbm5BUoRrSly+9f8/KPphavtlTTxCc9NreVLAG9qiaOPL915qt48/Kh9VjZzXTwvolHtArGbqiUxXiGccDNR5IextmnwBjvju/2l9cAPYHnMuwB7C/ruprfrCQB1F7W+n9VovNRf/tDXB/RbgbOdyhvhBPuhjE3mvibVxGxCyZFBIG5jb/1CdKDTlqZRQpKf6iTnYXHV3GF1aPzTW/wj6AmWoKhPFuBQ+B5l0ql1+vE3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAFTb3Jcrm5P1p8+JUWDQtYjhkwkahwqWcehzD99faY=;
 b=EIcxdNwTMFg8qccxWz3i6Y6HKcHFs+9TlKksm3fmjaSqEsxjTsPISHuUiaAGLYRJsXLzJ+YFoM3No9IcCI9f7gVcuG2arXtEhWeksHmyT8zf9l9xJTqB5GxxvTnK3yy2rl/ywS+Z5WNtRk+w6v/Wc8S8B8VIe6w2XMNPz3JaDde1G1YIMK5JJJCbuEkDNH/k/SGAkQxIqDEa6IOyXIvjnG6LbscR9+HHDbpY+KXGNckxz+0yukZHyy9/umrIA4aC7SgJI5BRHS+GjNpmNC3fIbvRiXldXbxgobG7N411p7a0Hoal2hIDw4aFdkZ5RJysZE6NVcCYRL5bzXMTE4XNhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAFTb3Jcrm5P1p8+JUWDQtYjhkwkahwqWcehzD99faY=;
 b=WqsC9ldgUINAoOFLMkxNpj7MD+chD2VsNuW+QTsqOrW/3oUyZiZw4mDG9Ku2z7fDjrTBEx/z+M3fBTo3i79AyoVZuPqOK1TgIecLsUivDX1/uEXaPlPxqxQBf0LbY2CW3bZP7SirNBgcyruqu9debnzmKt8G/r3UkegQncxyMfJBQCR3SsDol9rCtSlmU2qg2zTcSPL9B28HVvhIm2NQ0G4oOTAPp2J12t72KTbE0TjNFZ79+ZSTh7UD3jnUsErjNyhqfc3AhkNTfr+uaTnabKzDnLTpQdqbic32d1dGTSqJ3NCDBw3Nn0IhfiL/T51xOLgOj/IekQg8OjdjyFk4SA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM9PR08MB6721.eurprd08.prod.outlook.com (2603:10a6:20b:305::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Wed, 24 Dec
 2025 08:24:21 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9434.009; Wed, 24 Dec 2025
 08:24:20 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <me@ziyao.cc>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Markus Gothe <markus.gothe@genexis.eu>, Greg Malysa <malysagreg@gmail.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH RESEND 00/19] net: airoha: PCS and MDIO support for Airoha
 AN7581 SoC
Date: Wed, 24 Dec 2025 11:23:50 +0300
Message-ID: <20251224082409.1347373-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::15) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM9PR08MB6721:EE_
X-MS-Office365-Filtering-Correlation-Id: ae0902e6-0444-4bc5-14d4-08de42c5d625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|376014|52116014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tzllPzgljFiGj1gAGg68PshjE/ysWNWQeYIzXxY8jDFWjbmE66ZDFt+2q3QC?=
 =?us-ascii?Q?nwdYyp0mKLICfSxh0nseGzyNB9igcssHsXou1y5vpFzPpdgdTkodZsZaoFWg?=
 =?us-ascii?Q?/stTf3SGYgVedDGAOYS+HDwwzkAydHO5MKIX6s/6h5qbUlLbAHYpL8F4tclq?=
 =?us-ascii?Q?hOfzsb4RkXjqhVOqPGCCcqOqvzpU+P1sQtSsW+53Wd4D2Aeo9042owaBAQXF?=
 =?us-ascii?Q?UOi6orMO+Z01OdcrI7IILXcmsspoc73gZZdI4RzbO6OvWcZCFA8IKq80rNLR?=
 =?us-ascii?Q?wOgvOKdlMpPZU1iasME4zAQxXs2rUlL3iT9Cb5SV2EO3qgUUmBfGz3RitDmm?=
 =?us-ascii?Q?QGl7RbgVwxh0oAl+95Sqp4y+2x6emo3aBi0jJV7dkcGU5pboWvyb2WwxlLuU?=
 =?us-ascii?Q?ivc99hKeptTOqFimsCd1rVoL5GaqA9JAs39I+LZdbysn/DoFLJIr1MZtFC/8?=
 =?us-ascii?Q?SHJOppHNWp6ZCbI7xV6QQGamawCa6H2q3M3/iqbtVG8b3jXFhKy8CARO9zuO?=
 =?us-ascii?Q?z7IS2zj0xzKjHFYTDCwWqpghimU0LDFrVaho9DY8jw0+TIR8Flv9OMaiBQ7a?=
 =?us-ascii?Q?6+c4R/zxSI1g/Qc51GWAzBYHrb++s97+iY3Akn7somI1Ve26MwXDNCyfByUS?=
 =?us-ascii?Q?jRRRfU920pytmhuWSpJTH4vWNLbu/uziq69dmm86V+GjNkzHoBsy0zzvRoCx?=
 =?us-ascii?Q?ybEWdshTveZn4XXm5NHyLOM9OW5xXeDRnAxO2Sopaeukz/JkkRRLpIkwWdRl?=
 =?us-ascii?Q?jFACjoCJfTYKn5W1TIqYaOlOs5PQYYLsyEtr3jR9ruin7p8/4ivtO94ft84G?=
 =?us-ascii?Q?gWGQHEVB/6GSSvNVTw8ta8A4FJUWmQta7RUY13xaEWkvKXD0xh6O9XbneBR8?=
 =?us-ascii?Q?2II+vuhRE3zHVZhPGYRWlIGy2H1l5Qlu29rsQcAfMTE2vbJ800R10PYVWrej?=
 =?us-ascii?Q?Zw2mjAZzBpv2y0Sf9j7+Dt/SUttKFizLFLfY7xE0o9ySEZOVdEm5rYfnSVSM?=
 =?us-ascii?Q?BEYs94jc/+tPdp9SsD1ZfNAl0FUesm0sCK2Kr0D+vPiI0SYYjmWd14YK8OmL?=
 =?us-ascii?Q?Ts63f/QM4aSRAi87cib5cjOi+QadWoT9BeIFBv2aXMIJyxHpMgP+Wf5vGi+c?=
 =?us-ascii?Q?zuzbhQAOVr/GtFvOjgFk8SuhW8jZ724BdhWpILT/9MtLTTxZb6G1Qz5jVRCb?=
 =?us-ascii?Q?/j2KxZpuVaeSOKvb5Tz3Kj4igAH/JkXCbMD07Ijhh8+b32+uTVD320rCSR9Z?=
 =?us-ascii?Q?Jg8yGTmOKcAp+2Bvr2ylx4JA+PXbsnIaBmov/6dEKmfFSp1h1/tikaPW702A?=
 =?us-ascii?Q?sZFZnY0w+GmFhINHuF7xViVUiqW0fwkGd+q+iaE1Z7v0ZTTkYsFcEwGIRwye?=
 =?us-ascii?Q?oc1s2qVIG0Ad0Lwv2IqSw3PU9D9uuzQewwMpoGbgO5Npgd0NWQB4zRnCZ34y?=
 =?us-ascii?Q?jAzdIyewFrVPFSnGaydL6CJu4ErafJZJnLUeq+7ENW738+LmNGBQswQqtsoN?=
 =?us-ascii?Q?fAyFrWAFsLs0R7diyu+33KVTtcCKQ/B9mzl0cwLvGu04O3h/hvVCXS71cQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014)(52116014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3kftt80+zMom4sUObDOZhDIKydvCnAWVnUHtjH5bsxZo2ywnB3uXzX+Cex6z?=
 =?us-ascii?Q?APMiF3y0EMlTM4WUYoIkeCb7cp6Z2bueNTytGniEEQxfkZXp/w3XT6xCHf80?=
 =?us-ascii?Q?tnFDcGfDEKnsSTjbxSQ8WVyTJhS8c4tG/K5BS6pSYfVkUjTSHk6/e0Kb3yPl?=
 =?us-ascii?Q?eplXviNPNnlH6+GnKRXgRquKm183Gm6nJ2Q/93OOy/y174EZtNHgAy9LwuJL?=
 =?us-ascii?Q?tWidiT01YWS+OATtLXV5b+OJmOTTUg/7pQhkR30EpXsSJs3L73IApTOyS0CS?=
 =?us-ascii?Q?xT0cnSBXgI4MkVd+sXvZ7oWpukcZEeuuHBHfMxEBWwxcYir7Fxb6Jx9t21Ck?=
 =?us-ascii?Q?UbRhOfU0MJ8CRf/1OpgPd6w0vma4EkIkWhgAnAoGWBB6TC4+TCu54DQmsyd7?=
 =?us-ascii?Q?i0oDTONM4T5chxocq4VNnbRLxt2Xtbk5hfwZxoam8z0K8hE2dH0ocpXysS6V?=
 =?us-ascii?Q?YUniOuX1rhpgn2yKOjqvGu0t6RttcQgr4gZPGRR75yiX+LptoY+UhQGcl4qg?=
 =?us-ascii?Q?z30wZ5eDGKUxwR/tIagCuQeWbKNwtE4Nd62Nj0c2rdE04D5Y9SruJuuRlCcZ?=
 =?us-ascii?Q?jO6A/bW+cO2cl3YTqzYHb2nT0xesFPD2SnS8JiVrr7sVjszU5md64rWDULyV?=
 =?us-ascii?Q?86ATGxGA9nvxNk2MP1mkbV/O5BMERt3IareKPMkOPnUFy8VV4CPuDKnrEjCr?=
 =?us-ascii?Q?7z0QOHipHS2e723omojLrhsuBneaGjVcvWZrpEUIKd4g2JE0CkfuH5hfrG27?=
 =?us-ascii?Q?5hSZJwelrsQG4Z8nMjVdM7vljI2ORnODwQ4Y9/QKm439eVud2Qg+td9CK0Tn?=
 =?us-ascii?Q?Xx8FyOoIeM4Gezx2326uCC3DnEwMaAhz6RLKsCqY6hnkL1wmY3KpcME9TugB?=
 =?us-ascii?Q?PmNecSNq+lg3PCTkUnyGmv9T2dWJkfUhd5q1jKpmMy0I5kLBM9EGGHHRQSq0?=
 =?us-ascii?Q?R6RZdwSobND5Wenttwgx7KuoPNGAtsGd0kFXmQZw6+ZhISVFr9XvtnWjPh/o?=
 =?us-ascii?Q?e4gPoKoh08ulNdLQL9/ud/zKBFPqbHGjYhwFaXRNQUfjXHuH6FdMrK3OlQZM?=
 =?us-ascii?Q?slz3h9Wy+YnEGh6t9lfAXP/1A+PKHP/WS6TSzdMSlus173Wc1c5Ph+0vBnDw?=
 =?us-ascii?Q?sqL5s8Dpy7j++GAmX/Jlg54ey6HQE0zvK7tCUIxqLmQmwj7RWZqukU7ys02e?=
 =?us-ascii?Q?UFa6Rz4Z+UFfLaDVoYpZ7+GoLBGIPy1pYYZCSzm1cPaKGSIcxTyhS25C75Fs?=
 =?us-ascii?Q?N475iq6SeO3HVlCFMkbn2YFP4wyqTNrXt8QnGdoSo8dOPf7WYapwNE74MsDB?=
 =?us-ascii?Q?u47p2ZMqSG6083dsS8ypRNPG5T0Kb5tLOcmB3mBXA6uu3uGV5FEK9cmqpZtv?=
 =?us-ascii?Q?YJIrgW0iIHAt9SevG4flKE4/Kq8/i30Oa7ZH7+xr4Ar3/0/xnZh74nYC3bGQ?=
 =?us-ascii?Q?bKu/eWIYC0UUkaCr9ex+jmFRGu0UcWrCfeVBt6hqnr4eNmSI+FyKMD0202Ah?=
 =?us-ascii?Q?epywrN2gPfknAGYYgf+ZDN2fzMZ4bhcDNB4zW58jm12NbQS9H19iS/VKAYT0?=
 =?us-ascii?Q?ibSna4co4rPb50HHpWUOGdolOp2z/MaQhCAP3fvD3nGfD2L28qhYzQZ77DIm?=
 =?us-ascii?Q?3YR4TM8AgWgmFnuxDSPG55QEce4jhiSboX/MGg5vnvyxxS8vynYPOQJCC0k+?=
 =?us-ascii?Q?54aI7eRJmYZblYq68RQu5GvrdF8FJcLuMaShNV56o1nvlTa5qn5KdMjHz28A?=
 =?us-ascii?Q?rJXq+WH4jCPyEDsINbmiZN+E+gZJ/OE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ae0902e6-0444-4bc5-14d4-08de42c5d625
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2025 08:24:20.7257 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+Up1bU4d9BWB9Iva2JCgxpFK9JAzG1MABK/L10x+H54+w795EwzUSXqK5vxFe/FRTvuTNwi61fx8HUtWiO0qQQX/jpaaotms8aikRiugPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6721
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

The were no any activity for almost 3 weeks, so I resend the series.

This patch series consist of
 * PCS and MDIO support for Airoha AN7581 SoC created by Christian Marangi
 * Fixes and improvements of the Christian Marangi patches.

PCS and MDIO support patches were taken from 'package/boot/uboot-airoha/patches'
directory of the OpenWRT-24.10 clone repository

  https://github.com/Ansuel/openwrt/commits/openwrt-24.10-airoha-an7581-stable/.

Original patches were created for U-Boot-2025.01, so the following changes
were implemented:
 * patches were adapted for upstream U-Boot
 * Airoha AN7583 SoC support was dropped (not supported by upstream U-Boot)
 * minimal support of Airoha EN7523 SoC was implemented

@Christian Please let me know if you have any objections against these
patches getting upstreamed.

Christian Marangi (8):
  net: airoha: add initial support for multiple GDM port
  net: airoha: add support for Airoha PCS driver
  airoha: add PCS node for AN7581
  configs: enable PCS for Airoha AN7581
  net: airoha: fill in support for PCS/PHY in Airoha Ethernet driver
  net: airoha: bind MDIO controller on Ethernet load
  airoha: add mdio child node to switch node
  airoha: enable DM_MDIO and MDIO CMD by default

Mikhail Kshevetskiy (11):
  net: mdio-mt7531-mmio: fix switch regs initialization
  net: airoha: allocate string for GDM port name
  net: airoha: declare airoha_eth_port as U_BOOT_DRIVER()
  net: airoha: do not call airoha_fe_init() from GDM port independent
    code
  net: airoha: init switch before GDM port initialization
  net: airoha: pcs: improve/fix building rules
  net: pcs-airoha: unify code using SCU regmap helper
  net: airoha-pcs: an7581: sync with linux code a bit
  airoha: add GDM1 sub-node into EN7523 ethernet controller node
  net: airoha: makes PCS support optional
  net: airoha: use mt7531 mdio for GDM1

 arch/arm/dts/an7581-u-boot.dtsi        |   76 ++
 arch/arm/dts/en7523-evb-u-boot.dtsi    |    4 +
 arch/arm/dts/en7523-u-boot.dtsi        |   18 +
 arch/arm/dts/en7581-evb-u-boot.dtsi    |   18 +
 configs/an7581_evb_defconfig           |    5 +
 configs/en7523_evb_defconfig           |    3 +
 drivers/net/Kconfig                    |    5 +
 drivers/net/Makefile                   |    1 +
 drivers/net/airoha/Kconfig             |   12 +
 drivers/net/airoha/Makefile            |    4 +
 drivers/net/airoha/pcs-airoha-common.c |  827 ++++++++++++++
 drivers/net/airoha/pcs-airoha.h        | 1220 +++++++++++++++++++++
 drivers/net/airoha/pcs-an7581.c        | 1375 ++++++++++++++++++++++++
 drivers/net/airoha_eth.c               |  368 ++++++-
 drivers/net/mdio-mt7531-mmio.c         |    7 +-
 15 files changed, 3908 insertions(+), 35 deletions(-)
 create mode 100644 drivers/net/airoha/Kconfig
 create mode 100644 drivers/net/airoha/Makefile
 create mode 100644 drivers/net/airoha/pcs-airoha-common.c
 create mode 100644 drivers/net/airoha/pcs-airoha.h
 create mode 100644 drivers/net/airoha/pcs-an7581.c

-- 
2.51.0

