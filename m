Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C395DC61DBD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 04:31:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C35580AF5;
	Wed, 26 Aug 2026 04:31:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sBcgG6mMMdJU; Wed, 26 Aug 2026 04:31:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787718681;
	bh=DTqTbNS/xg3SvMbsQ5TKQSM1fJcMYxlHfxIOLFiNYpk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=wuTajIfiLdJbvEL8xHqMBPec7s/eB0DLETjBuvtnNnATE4nr3vv+ivEd9G0ZESH1C
	 1DPbRJ6vCGJ8PmJeS609XM00FQC+4NOVuh6YNJItnLtunnsCEPZFXsq6kW5KKexkO3
	 aWx3EefO4WPGxd5SnWVSsGwR+3S3AaVuR1N8+5w8cCjk9QZAOM9Eh1VXDi0Fjx9Oa9
	 iUmfAdYcyFO/9TyOlHEVvUjYPHOf4hCayn2gdtUn/EVLJPbkK0tDYmyOIPDBDO6cLN
	 n/2wioFlz782ewKbzViUKnTfojZJUcm16JizBxzekY/g5+KMhf0I+udqMi6WoZvx9Y
	 /qEhBETccK+zA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8007B80AE3;
	Wed, 26 Aug 2026 04:31:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id F4028396
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 02:53:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E606F80C36
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 02:53:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aox0j9p4Sg79 for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 02:53:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::5;
 helo=cy7pr03cu001.outbound.protection.outlook.com;
 envelope-from=tze.yee.ng@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=A9yyCqYP
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F0B6380AE6
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 02:53:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AHBgFkfw/wHLU+2UrcAv9XVEvo+m5a4a9s9ZyXqgRTHgTNF67gbN897BvsXiXG8ib3UJWG9W0Ps9loQCf7wg+SacvbsKtslf/OHst11aLRTBtekrIaNLefbkcT+ab/DPE8m/UHuBN8oTtaXOWPuynVGMhFE0bDs95LdjYfFmlJ8aR4seX5fbWLWHdKDSPgni4DU34RyJEG4icXBeFCJZJFBsF4fjPgFepWZUacZwKAgWStYH8b/NvVW8taKT5xNSjo1ubedkEkmFb8DibHYeFyFTbf3iIbr1oUjYN5n+/UFIQPhAzIsPIWZPI6n0TX0REj7Z0Li9hlfyv8DYwpzaqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTqTbNS/xg3SvMbsQ5TKQSM1fJcMYxlHfxIOLFiNYpk=;
 b=ajACV2207j50w7T9Ngof/mvqzfYqyRy+q8eL9zPh4QmDMG5YiUEpXQfme+jyf8aFlsGPGP+kUKndqyJAc/qsDNyE9wVBAg8olt9B3VYIOJqd968R1TEqTubkQdx0TiRCpirwa8NZJsRW3+eyHmo6IthnM8KRRVyTot/GZsh1ycAqhIQb3vjEsifzsvfuoMOfB32CPqgpzMaF2+P1L022zKLvbmRnzJRZYwRp/Gq1XNNt12J10ZZ6nEH5e2U2g/1BhKLvfVzzp27bGJdCJvvuC8tOxV5GjJXDa/D1FGfxHYQWvWDR7y6AxhL/F/E2ooxbSy/yilKbXzEHdKRNsyrWmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTqTbNS/xg3SvMbsQ5TKQSM1fJcMYxlHfxIOLFiNYpk=;
 b=A9yyCqYPkneLTn2BptvuTBPsn2/PGcMIvcgQb2tthmHO4Jg34llZ5RsmqKgEr+lZesfdcRhKJxeJueeVt3RV9zy3wMYmQClZdK4PDFxW6OBR4uz4WFAme7ta8cxsOmD6LOMpi7FcA8x+HCHh25xO34o36FEjeY1DcBu1FiTWXoPNdfVlKQZxZ34TRPQk0tP25ArFxn3PzT6SIFCBVg82an+gYAFCOuB4bcNp1Jz7WkYWo24Wzvik6Z5WUY3jit8o/sxIzgeLh5k3q4ElFgr+IwLFEyEjKBUe6mkAwE3C2zp/uedR+BvvBCggrJhNh5mb/kcFXUa1HOVbcg/4eTC5Gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by SJ2PR03MB7167.namprd03.prod.outlook.com (2603:10b6:a03:4f5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Wed, 26 Aug
 2026 02:53:10 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%5]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 02:53:09 +0000
From: tze.yee.ng@altera.com
To: u-boot@lists.denx.de
Cc: Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+socfpga@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH 0/4] mmc: sdhci-cadence6: harden PHY config tables and enable
 Agilex5 UHS modes
Date: Wed, 26 Aug 2026 10:52:59 +0800
Message-ID: <cover.1787710268.git.tze.yee.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0083.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::28) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|SJ2PR03MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: e672ae04-307b-4d0c-1c25-08df031d296f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|6133799003|11063799006|10067099003|56012099006|18002099003|3023799007|55112099003;
X-Microsoft-Antispam-Message-Info: MeHl+13AHZp9OxrXiwNoWqxf+5tMTwYmPRDMNgzFuN6yOnAcPKfvA9m0gPL5u4aUZ101ARL5yZdxUrxyJ1triHdCHb5uFYgtZ0Mex4I3Z4Ae+wkLcn+hOt9TNmLpXZRD/CRHFvyvdBBZtnOpPZWy7l46868I1ADmhrLpMTa30xsmii1gPJIpMO0ZkUBRh4rB6BAxucvpkDf5ww6wELUoQeBKMoJMoMxyW77yeAMXe5dgK4kI/+1NDF+M00BElw7k6lat+mlV7HzEmmt03+/urZoFEUymA/hnNiSNwSWAyrvL1RPmE4ow6pxo9tM/Pk5psLJj4CQeG4FYaK3PdvfC1f9B14wvkYTKug4VrVe73EVw6e+4kPLL+aMu7Qt5QEu1ZnjJEZiyskBeJJX1yMBrTDVNWAVv8B8pBecN+TPnY4bLMUNxA22gqy8iGoTaj+lULQSbybgE+TxXOelpnynmMIsOiCsYE79v83Ht7NE1BLCLTkUx+X74P3YBV4Vqkfu8mP+FozGqHlyObmRnqI7AQgSdcIpQHIYSmNDOho5xvWfNLW1nQXoqaSdxSEfgZH0unuJwoEEc9Pm+Ji8U1gJmPKGEaW/hSd9BLJRv3xju+H0gffv1sPAVVfE5MxYXlZAHB6cakTFbBLJcxD/U8rchekAI5KZLtCP2EGG3GDd22mM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR03MB5950.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(11063799006)(10067099003)(56012099006)(18002099003)(3023799007)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NyMIkMFJjY+Y/S4+imnu7fM3q3kFcZ5MPJCOZt2we5U204+qd84Yzyo92eWT?=
 =?us-ascii?Q?KM3ap+89PCM54zlrRKkuckXhPYoo8+kDYnW9SZ3BkcKm67yM5OSDc+j+Y7MS?=
 =?us-ascii?Q?boli4CKipH23Lkwd2pRQ/MvEiojxezxEMMUad2ps9GyZ/lg4pFz62eeN62a7?=
 =?us-ascii?Q?iJQx0UXQDAr1Yi9hPwU4irlXrtm/qJV4Xgn3EN69lWE2UiK/cB+NMQnxL+ul?=
 =?us-ascii?Q?C1uu52dSgwM1cLn82zkgbKKgV9swtED8ZR/xFfd5XANNKl71/7YrJqEW1AwD?=
 =?us-ascii?Q?74J2GWxk7obVDsXiKIywHb/IjuKGQL++wZJUZfEZ1R9abrGmqHNzzt8Loxtv?=
 =?us-ascii?Q?cdZbR+1MUYvT85HtMu0Yh0XvCPOzCGUG4EnjG4FTqfleBOTORtY6aWcVbACN?=
 =?us-ascii?Q?9RAv2C7X55fbTkzYyiSSkPDwx5BIEf/eH8rGx48R/pQ784TmnbzN2cwoVSgU?=
 =?us-ascii?Q?iGC/Bzx8//7qi60kJo+J0kziB4PiDR+e9H7pDgBwegdqadLe+VWJ/FZdLpMD?=
 =?us-ascii?Q?bQwNnimuFVL7YzDh4QXxjY948jD2mD7KwQPNqs0TNfV7nxtek2ieKYx8HDj+?=
 =?us-ascii?Q?+gSaQYJVeO2RkkSCx8qM/Cpe77rkM/lGvXJRxNxjv74VYW3vcc+So6iAe/sp?=
 =?us-ascii?Q?o1Sq8wSS816hgzghoSBss4M7QtamxinaA+YpyR3gXVCwpzfjdt/pc+aBXAdM?=
 =?us-ascii?Q?bjevJZQTGjp6b9kNO9zsPvr20V2RAROY5yCPZbDzwI0fGnjGMeWFTYu+vJIe?=
 =?us-ascii?Q?z0+GMvOZKm9S9l7f7PpYDc3onCzlANj+JOh65X8J1EAWPefxyXLkB49tHplS?=
 =?us-ascii?Q?cVH3cB5MUVjAmPyjmiY/usinWLdlDVsz3jObAdMjco9uEGgkEZnG98Az9pGX?=
 =?us-ascii?Q?z6PgPZ+7ANRsy7hPtgvbfxzSLxlSSlQ1r0v9NWP4RvrBJnAaZbn7BJMCekDJ?=
 =?us-ascii?Q?VCbsN4AiF5y8MoDJjAzt5a7MJu5zKAFEYh2StnPha94E2YIQ2gFbUsloxPxA?=
 =?us-ascii?Q?oMS8zRVlw5jDFtHcMRLOOoPfyLeukV2GUyONEIArZKkU35QthBFjOyRR5Riu?=
 =?us-ascii?Q?zIUqGuVnRsJjWE7bt+EHBtA4bt89TupNReY7Ps9r9flTiXjU9zWT2f8iRQES?=
 =?us-ascii?Q?p+LoB9wi3LFpghO0Xvql5q08adAE2Vs7syaOKcbgWAXGxSQP818UeZWjZVvB?=
 =?us-ascii?Q?/BHf3OfOOS+mhrbvS5VW7LbtIbnvbpj6oADn9EnxDb0lcG/TWu1fr0bccq94?=
 =?us-ascii?Q?m77rgjRHxKVyfvd2MngYFvI0WWfjYV5aNvDElJ0V+lriqyZkJ6UzZn7KCF35?=
 =?us-ascii?Q?0kvxEJjL4Ys2t4Wg1T+pzd9q7sLg4TkTPKhyD4vBijn4g+VhgTOfayj8EIT2?=
 =?us-ascii?Q?pXi26BebZB2/DjUtALiuq29s1WBTt5IzZfCr0nc9Pj5sjCqaWYnN/IlCMJsc?=
 =?us-ascii?Q?J5mayZrnaxlqVtWJzB/ye3s40rIswbCjdGR0abAGHRBhCEgxc1Cr3+MZRwxd?=
 =?us-ascii?Q?1xcjiUOM27HDN8Fyy6H/2Urc5FYl6Wyl2a/p+UuuJEs87T8fXWEs2/hQM7t2?=
 =?us-ascii?Q?c48Lzp0VEexzzbHY33PSKD1qO39Fvacuhbbx31s5ILgEWwwaQk8g8dArZPr2?=
 =?us-ascii?Q?EWJb0aenftaRjZDNWFILxovVSNHDvjdvPdgaM1wEhbxh3tIqcwbVoHBmz6TN?=
 =?us-ascii?Q?vwmZe7jMvkm+GGe/7VbOurOyBlF/Nh4vExx4V6UoGEiVYbCIUM+AsQAO9RSx?=
 =?us-ascii?Q?b+U2NVf9Lw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e672ae04-307b-4d0c-1c25-08df031d296f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 02:53:09.7179 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z0wNLCPEqQkuHB6uI7e4wKMb2ZWq+hplTpzOxdxmEcDmxLQZa4mM/D4Qpm4x2NCr04PSwEUP9QF4k2KPxIS6FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7167
X-Mailman-Approved-At: Wed, 26 Aug 2026 04:31:20 +0000
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

From: Tze Yee Ng <tze.yee.ng@altera.com>

This series hardens the per-mode PHY/controller configuration handling in
the Cadence SD6HC (v6) driver and then enables the UHS-I higher-speed
modes (SDR104 and DDR50, plus eMMC DDR52) on the Agilex5 SoCDK and its
013B and modular variants:

  - const config tables + per-call copies, so device-tree overrides can
    no longer mutate the shared defaults and leak between controllers;
  - named enum slots for the PHY/HRS config tables, so reordering or 
    inserting an entry cannot silently reprogram the wrong register
    (no functional change);
  - program the PHY control register (0x2080) per speed mode, with a
    per-mode / per-board device-tree override;
  - add the SDR104 (emmc-hs200) and DDR50 (emmc-ddr) PHY timing for the
    Agilex5 SoCDK, 013B and modular boards and advertise the matching
    sd-uhs-* / mmc-ddr-1_8v capabilities.

Dependencies
------------ 
The driver patches (1-3) apply on top of, and depend on, the fixes 
series (series=519635): 
  "mmc: sdhci-cadence6: fix PHY programming reliability" 

The HRS05 posted-write flush and the post-adjustment settle delay from
that series are required for reliable higher-speed operation.

The device-tree patch (4) additionally depends on two Agilex5 board
patches still under review, as it extends the .dts/.dtsi files they add:

  "arm: dts: socfpga: Add MDK support with external GPIO expander"
      - Tanmay Kathpalia (series=16401)
  "arm: dts: socfpga: Add Agilex5 E-Series 013B SoCDK variant"
      - Dinesh Maniyam (series=32177)

Tze Yee Ng (4):
  mmc: sdhci-cadence6: use const PHY config tables with per-call
    overrides
  mmc: sdhci-cadence6: name PHY and controller config table slots
  mmc: sdhci-cadence6: configure PHY control register per speed mode
  arm: dts: socfpga: agilex5: add SD/eMMC UHS PHY timing

 .../arm/dts/socfpga_agilex5_socdk-u-boot.dtsi |  13 ++
 .../socfpga_agilex5_socdk_013b-u-boot.dtsi    |  24 +++-
 arch/arm/dts/socfpga_agilex5_socdk_013b.dts   |   4 +-
 arch/arm/dts/socfpga_agilex5_socdk_emmc.dts   |  13 ++
 .../arm/dts/socfpga_agilex5_socdk_modular.dts |  20 +++
 drivers/mmc/sdhci-cadence6.c                  | 136 ++++++++++++------
 6 files changed, 166 insertions(+), 44 deletions(-)

-- 
2.43.7

