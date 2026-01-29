Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2911D3569F
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 05:31:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E842E83BB1;
	Thu, 29 Jan 2026 06:31:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="TX8r6ZSw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0797883C23; Thu, 29 Jan 2026 06:05:53 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45E6883BB1
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 06:05:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ht1zagIpNWwGU4uiiEtiae8xUY1il81p9ILs8PyCavcXQH0oq1ZpTp4bvXXOvMF7kPhtPMfynesRzaSFgAD+qxAADuhlmqikuBHvBfwk4sdz0qj4ws+wo37aEKdDY4K3MYNryLMFA6rI5ZqD6kURDe8sDpIPdMdfaD/fb+rg5KBizee2DePtSRAbbMl6l/qqx/i2F8sngSOWywAlo65HXgtpJdgNLBMF+rducKD+pth6iT/CIvzr3GUVBEC+XsAgORRLHozDdPdYJAetU/mHV56tcua9m+MkxCIfHQNNPxmE9rmpurw6ExeufHkiJORxMq14omnoWHLAEjhMcmaGIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jd2OcOfNcEuqLmwSRAHAx4zqObHI1NJlXD8ma8nluXE=;
 b=Ac0HC8Y5J1t/3YB3Ti/4kEdxxjOV+AA0hJhS6/kiW/t0AcXtZRUMI+ApcnrQloGzs0ripoUDvR3NCzohZJkyd0lhoptZJOCgtzny3W0oAsoyA5kdEFYB8p935ufxWs18y9FcfFb+yrYmcZx7htUO0AI+wSjWIwEzNHHaVgK3X2oj8iO99Ae7+YDmPvBXGIOH0PHVe8kETmbI8ETheIdAHAD86uDahJAUjjnWK6VEkjrwlv7vjNeVEdQ+JYXnbtZTmlwrzJucn+VJQ1n+zUUakJaeFKwyRxJeMIFst/suJihVeOROYUoRnZsN5qwQ9USrQdqNUYoR6OVgEpA336dtHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jd2OcOfNcEuqLmwSRAHAx4zqObHI1NJlXD8ma8nluXE=;
 b=TX8r6ZSwBo1n+fFNQlhLy+vb/Cs93E6rHsajxmCxtmgJGd/2/2djtJSd+HcizlOfBPrR/OOdTvb+sXM9mIWAVCiMHCMCdTgPbiaH6h+f1bE5BvEDZ2pIv92vd0N/SCwCV9Pmbds63laCZ0nxsweCBwD2vLG4NiPDuHa3E5iWEYRZbE81IfinOXWaGq9D4j3aKlG5ZlycGk3lrAnc+QNaeJU2of16sR5+r6HMgIK69w/eHFF5cetDt5jKYalgKk1Cc1+8/zwpKsC+CQgbF0aI1n8b5CM9fbUT2iMygvnfkLpslbMzVgZdmY1+Ffn0K5YA4TFhCE4YgOEeAME/nrUfBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by DS7PR03MB8219.namprd03.prod.outlook.com (2603:10b6:8:267::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 05:05:44 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%7]) with mapi id 15.20.9542.010; Thu, 29 Jan 2026
 05:05:44 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH 0/5] arm: socfpga: enable NAND boot support on Agilex platforms
Date: Thu, 29 Jan 2026 13:04:41 +0800
Message-ID: <20260129050446.8858-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::13) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|DS7PR03MB8219:EE_
X-MS-Office365-Filtering-Correlation-Id: f4231ed2-0aa4-4922-dc45-08de5ef40e04
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hYZNXLTLDy5WMnhP1MqhAP68iVm52xDBVc2qiUFv1n9H8DNJMXBfzDMMtiL5?=
 =?us-ascii?Q?6A96r9WR+3oRGhtTPnQ9E1NkkKvCtUf7oHK1XsdKLjSOH7KhYFTB/U//BeU8?=
 =?us-ascii?Q?OTVPaH5Yz8L/XlN/ZHd/W3WLGrzE7bGsZAlq2GNZqPpq5c8530QuQhghY9de?=
 =?us-ascii?Q?a3uW475DNhFU1Wu5g8iLrkSdAuyARdoX6JK1cUgPDvetCva0P/juWDoDsx2F?=
 =?us-ascii?Q?Vbue9QUZzgRn97tohLLOnFsw5wm00PPujarXScEjYVMJHH+X7LeXoLujKblU?=
 =?us-ascii?Q?eshp796uL/cz0ufWu4gdRfSPTej0eZ6o+jXCmTAXmfpY7sJ4h1wDNgPrantv?=
 =?us-ascii?Q?y8pHCm/GIgkQsyZY/Mwg6tmIUQRO5CUDqATBbjB9Z7gTV90wgRAIj6QLFvCs?=
 =?us-ascii?Q?ykYCUnr1G3nS33pFPLwIsqusWzEr5swsmw88SFVSRKtEzN97noUCXCOP1N+G?=
 =?us-ascii?Q?2vczR+UQyXP9l9vBDjcAwmlkppKy1hWR7tplZdAQnSvbD+hiQrD2xiIFzN2T?=
 =?us-ascii?Q?ADfRqhxx1/BYAAYwzZ2zKtD4vxtDdY+Um7l2N3k7h8iehdyFWCDRF6bDRxFI?=
 =?us-ascii?Q?ARWif51VYprUaljkacb3dUiKK/f8XgoCtryIl9hZa+avdLSHmAZNyKKOkTm/?=
 =?us-ascii?Q?QBdQW+UxhDHASkxrXMrR+j0bJhY/owf73zBpUxgrZt/8KEMVh1OseJM/6GmF?=
 =?us-ascii?Q?ek5LiJN9LP2ORXpC0yGZHtgCCrHeFxA0y9BvEZxGJRwAJMRHw8odHhjinMa/?=
 =?us-ascii?Q?+8D+0/x7ZW5so87oST7/PlTaTUJLEh6gun3dpMpZscmGJtt0axmoSilZLlD2?=
 =?us-ascii?Q?P9xG/GO/5CmbGN8MiUnOLPV/eVYpxq/z5to4kYq0n/6bzXy4wYvykXmQyWq3?=
 =?us-ascii?Q?eIJklqx+WcZEM+ORYXYqRxGH/GZb2BQfZjcYdgBBukze8rm4BA5tHUdiSjzI?=
 =?us-ascii?Q?tQxmmVKpnIf2tpp9FLHfy5AriVkU3nO+QnHwUtMU8xQ/rmb73TTb1ZV5kKbY?=
 =?us-ascii?Q?CRtvrZSH3e96khbC0ZTvTRteqAeoVD5u3+G8iDPxTcBUlnM3SSvKJ71iAnsj?=
 =?us-ascii?Q?zJqKMd7jOzZpRS168Px+T25NcCH/mesn08tBU2N2YIjanMTMJMfjzGyxTKjj?=
 =?us-ascii?Q?VQde5psXZ6AoA/zF6PcaaC3lMXSNdOfO65ZVOuk2RDdwqLQdHjdPdqXV5kwz?=
 =?us-ascii?Q?q+C7am+asxCNkoLVJC8dWDSv0+DhM5GHIQaZgV77WTg9d7nWgqMoGjptfKSS?=
 =?us-ascii?Q?8/8QYj9HaIDHgzQjJ9CLgMm7FriR09OsDwfEfd3wcdiF1khO4hXVNNS5Wszx?=
 =?us-ascii?Q?+mVgWlyK015QCP8//HqMlas9cdLJCy2Hyy/L2Ur/Grj0zXSqBsz9RDVcXR6Y?=
 =?us-ascii?Q?zVU02EunjfjjxIfsfAh/LXBHpHOFuMZBA46a3HWJmoz5oDQZ2W6hgoWwChCW?=
 =?us-ascii?Q?C/A1k6tjfBXbIPXOt8G7t2XSv/xRdBDrjTy1pcp+y190TakyoVz/CqvHDb9Y?=
 =?us-ascii?Q?tmg8NVJuMQmb8mfTm/GSw3/DbcuCAiLsJc1QOpoKkWhR9xKqxgAijKYifSzM?=
 =?us-ascii?Q?I9CnBKM4AGf5l938KNE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JR7bpauZj0kNGx/QsYZe7InrjL6blbmY1ueaQ+nWZiO2vGN47XlI5ogT+gVL?=
 =?us-ascii?Q?jjnSk/GpQ9YTInVbCbOfQdNFmE3sQan3CUWVssZVQbbvpcU9Q3IYogs7fT5L?=
 =?us-ascii?Q?n0KFiIb/mIBWvlqSK7JWFjqJAvstE+QMeAPrtiYsA505lhYcfWzx3aKvcrC5?=
 =?us-ascii?Q?if7d/ukpqfpGS+GI39aUCDborqIZD9Vx0TbP5WckCr4Uq3jYw2kiErLvMw8+?=
 =?us-ascii?Q?PFwzg4PmOHz6LUppsXQFLyPs8YjTY+bB+DAnmD3oVF4fImutysxfeWTLU+rc?=
 =?us-ascii?Q?4IzT5Ds1AKIaTSkLemVG2okg7F/M9u73qYLQi1d1zjR3zeGQETYGZVq49cld?=
 =?us-ascii?Q?d6Qqf4vACgpawzU3KFpp5vleBhZzjaWmaO6byWCzo1/6kAAfGwHSgkewWbjR?=
 =?us-ascii?Q?uH5iOKWRb90n2eRm9cEs198tx0rusaSDuinr3h/j8MLKTnVDyzIZ4v/f0pJN?=
 =?us-ascii?Q?tb1XiBA4EJQcA1Adm5Jt9W0FkSVI9rPspqkgeKwirpgNB6Q3fhWdC5sWahGT?=
 =?us-ascii?Q?Iew+0Lt3Rl+pf8a+0qx/XGt+TMF+/OAY/Lng18SHFYhwhn3i2QHxRGr44a7E?=
 =?us-ascii?Q?bGlGpQJMkiH8AJFq0N0g44h94SKK2blbZRiPprJ6OUCgPQOqXKFreLFvqoc0?=
 =?us-ascii?Q?bxIYrNZBf/t62DragAxgCUSe0wlmY5AlV1CLDGXrH0zvil46zXN9131zlA7y?=
 =?us-ascii?Q?HeZHq6fDaeLflgp6JHtyY1/0TqW++SfSGAzhDiLO5AeZq3tiJjD9B69xynCq?=
 =?us-ascii?Q?CNnqYNW752005AwhIdSiHLLQJ1NX5rW3cqdFxhK6yn4UgslJvrH1kABTIv2+?=
 =?us-ascii?Q?u6178grtBzQ81AjWLiRjgH1+cJdcVZ4LOoMDMWE+iJw5nqvqfY5c3rR6Yk/F?=
 =?us-ascii?Q?XewM1mejRO9co5gFunbZ8OO3fW8iYtqlLJt9gw6hzHBTeY4zJ9xyUhouNV/N?=
 =?us-ascii?Q?KOmMuqgXtn2azQvg8ibotHW0G3NKh06blJiZj9/Q7zWYH4BsGlaSBDLfoKZR?=
 =?us-ascii?Q?5sbVwVtTaag0WFKD2AoBuRJa5yI9SjpBhtBd3mnMJwK0R+tQphBJpb2eVOOo?=
 =?us-ascii?Q?9/OwlFUnyLdvq8TPSKSAsxBRvs6IICxVlglFXN9SPoU2d0ZgnHdSnIk/KeRC?=
 =?us-ascii?Q?3KsxBllKPdKCVTA2cvMS8BHPtPttO10/1t5fa/SpZjcDEJe9U6fnJrLLaPTC?=
 =?us-ascii?Q?0NsCVyDjRW/m74PQeW+b82Bj3FMdpseQBekqqS79bADfpUZqErTeWJxdZtF4?=
 =?us-ascii?Q?1Rcz7EevmNwiFLsQxoHljHl9rE9YtvEtyhhi9hSLeG8OOUGo00LxKWRGsCEu?=
 =?us-ascii?Q?wfr+84mVpBBR5C7WR27gwTqUtFjwlUW/umTsmAtJiP4C+Gdsx8F2szkOeFz8?=
 =?us-ascii?Q?Uyq2rTDI9ZR1ApskLnANwRSF7uEzSWpddSj9LzYY2HGcMaE1BTNwzxeIXyFU?=
 =?us-ascii?Q?jf16dSU6lPXoJ0ZoEXKNc/eHGqMX29XgVlD63Iv7WQteVC7NIDvlx5QwOnbI?=
 =?us-ascii?Q?65LAYrrWP6NWmhJ7FHwFQ7iOU9Nu06PVvxk7YYE3cKI7Urslw9kKoc+PnLTG?=
 =?us-ascii?Q?d63q2HMyU7V+mwLvaoZeTqeIgu1IIvT99LP1fkS/fQTkgR40GiG53zNY+141?=
 =?us-ascii?Q?U1XezMPKBoI+u2mtAfsZbjf4l5hlbd25mGsjPLQK4vAI9qELvQgEXwF3T1SQ?=
 =?us-ascii?Q?7BwM3KKtVccHvr4GTUmSSkt023aX9tu+VBStqZXKNK8btAJV61CvqHdrdzMd?=
 =?us-ascii?Q?re5VeHvu6ICj3mHn02Ma6m4L7MTK2o0=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4231ed2-0aa4-4922-dc45-08de5ef40e04
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 05:05:44.0355 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BcTM8R47XxQ2zdC2cHTenOGvOv+7kteZ+KhAjBpsQ0zqvsPcHoYydnDec1S2SN1/TWa8ec6XuJm6Ewy7ZfhZvisjGrJ80slUZ/WctAopBkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB8219
X-Mailman-Approved-At: Thu, 29 Jan 2026 06:31:37 +0100
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

This series enables NAND boot support on SoCFPGA Agilex platforms.

It adds support for loading U-Boot from NAND in SPL using the full
NAND/MTD framework, cleans up controller-specific SPL helpers, and
enables the required NAND configuration for Agilex boards.

No functional change is intended for platforms that do not enable
SPL NAND MTD framework support.

Dinesh Maniyam (5):
  mtd: nand: introduce SPL_NAND_FRAMEWORK_CAPABLE Kconfig option
  mtd: nand: add generic SPL NAND MTD loader
  mtd: nand: wire SPL NAND MTD loader into SPL build
  arm: socfpga: imply SPL_NAND_FRAMEWORK_CAPABLE for Agilex platforms
  arm: socfpga: enable NAND support for Agilex

 arch/arm/mach-socfpga/Kconfig       |  2 +
 configs/socfpga_agilex_defconfig    | 11 +++++
 drivers/mtd/nand/raw/Kconfig        | 25 ++++++++++
 drivers/mtd/nand/raw/Makefile       |  1 +
 drivers/mtd/nand/raw/spl_nand_mtd.c | 76 +++++++++++++++++++++++++++++
 5 files changed, 115 insertions(+)
 create mode 100644 drivers/mtd/nand/raw/spl_nand_mtd.c

-- 
2.43.7

