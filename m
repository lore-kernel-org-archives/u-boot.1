Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AEB2CDE000
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 21:20:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3B93847C3;
	Wed, 24 Jun 2026 23:20:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DScf+ZJa";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JsdBV76q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 530F884A06; Wed, 24 Jun 2026 23:20:15 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D998849CB
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 23:20:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65OJs52E1056094;
 Wed, 24 Jun 2026 16:20:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=Z4dbLNxauxjWuGiauO45qWGtW4zoQVgPo+HzDcljV
 Ks=; b=DScf+ZJazPk8dgL2ESD+hmu/Buy5wqlfapOqLPLAuWpqEcBWkfcuNpDGR
 aejngNxB+ZsyY/LqFj/qA3CMm75JOGii8lcsvo5s485SHUMaBM4k0pvejdvBzhG4
 hJOIzig61q/YvwwDqHh+fyNQq7t028vVFYbIG390BmRiyVi3ok3HypWTLZDkq6w8
 7I6soS5cWqWitykXsDjX9XzcAzeySnREWdppQlWu7w98j58dzMjex2PYp69P6Zl3
 MKwjFvqqgqtM9x50y0TAEnVFBhfVzr05TjRE0ykP2MJtQ+2/SMR5GY6p9/vbs55N
 8VeQBrugsq/VNK9NfB4WVMdz/Brig==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11010065.outbound.protection.outlook.com
 [52.101.193.65])
 by m0380145.ppops.net (PPS) with ESMTPS id 4f0e5ybu6d-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 16:20:02 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pn6U37SC3mtokrdsaTx5BzY8P6NI2TxrdMFjMRzCsD6TxEz90VIKaY92Ok5u14g6AUmgXoSnP3wsESdZLAWX3AofrQL9QIqnXITzuhmOvi7ABSed21Mv1RS3zDj+AalG329EcmspEt4EF53VJOUnrE3uHP3NKhDRhnyHwfd2C8RLc0iXHJSQwyfByNzEWit2hw155jxV7/PtVFDZ1pAps5bzjhQRJ+ZF7NO+4WHlmKEXJm8G5QVqIeQjAXpd0hvi0a8Xdsm9SDwMogfPdGj+hEooFmgKBF4/IQAYnqgFjBdyIcpXyPp/Ib9NCVR9EoZnjguyL8LnhNybn5YWPfD9pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4dbLNxauxjWuGiauO45qWGtW4zoQVgPo+HzDcljVKs=;
 b=uq0QPYQes3eAnY7sfzMD00WS9GqEQynmGFultHZlM8j8J5QJm3d18t1AV76opznsAb+4nQsE27yn1nwqfK2xWdl9TLosSVQeCLjdbJuCsZxgzkY9tJ7Bj+z3Kyd9ovJQbc2obHbbHcF8O1eLhulPGsiJ2vqIzyCr9v13l/XqaVdB4YmMPPqwQhiaa7QuaIkgMbsMa1EjPcCPUfEDeKUBOwkX5cT9v8lTDbYAlcgnKEQ7XH5S7ddrSne+uMvVUhkpuaNUBFuiI/NSatFpZ9AojoKr2mXT9u7SOG/1dmn6z7Ho/dUD8mMuAnlN6C4nj1Aai+50bkI3Dvp5KH9WPh8nfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4dbLNxauxjWuGiauO45qWGtW4zoQVgPo+HzDcljVKs=;
 b=JsdBV76qw294XfrblIg5lQozFUg2TrCqsZJAWUY0aeEmP45qVLZ69pOkr0gh4xsHkzxYB96xr7dEL2E9zcMn1LgltZG0K4I8mlJL15DmcSCg17bvKNMmBB3p/4pxhy9lGYGK0hBERwIYHAEHsgaKGADdJUPPOASQM7ki0h5lOOw=
Received: from BN9PR03CA0527.namprd03.prod.outlook.com (2603:10b6:408:131::22)
 by PH8PR10MB6525.namprd10.prod.outlook.com (2603:10b6:510:22b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Wed, 24 Jun
 2026 21:19:56 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:408:131:cafe::3a) by BN9PR03CA0527.outlook.office365.com
 (2603:10b6:408:131::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.14 via Frontend Transport; Wed,
 24 Jun 2026 21:19:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.0 via Frontend Transport; Wed, 24 Jun 2026 21:19:55 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 24 Jun
 2026 16:19:51 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 24 Jun
 2026 16:19:51 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 24 Jun 2026 16:19:51 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65OLJprF1851589;
 Wed, 24 Jun 2026 16:19:51 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv3 3/4] k3-am62-pocketbeagle2: add support for 1GB variant
Date: Wed, 24 Jun 2026 16:19:48 -0500
Message-ID: <20260624211949.327905-4-rs@ti.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624211949.327905-1-rs@ti.com>
References: <20260624211949.327905-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|PH8PR10MB6525:EE_
X-MS-Office365-Filtering-Correlation-Id: aef685bf-0aa7-451e-e0f6-08ded2365654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|921020|22082099003|18002099003|13003099007|3023799007|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: LDv9g0og5gEcQerC00/6niEYxdjAB5Kjvh+xiBZ+F+yVcHl01Efe2v9KNuUOZVkHUmf1izHxlUCLP4URwqih+gjBqDak7WxMEK4ckIOIuYshjUh8f7LpNMz8xZ155YWWpKoXK42LuHnlM7QmMu64DGgrzmvFZlVl+ImX4VGK0QvChGKwR3KW/8EP0e2evWWBV8/zqCr5aNvxp8F4GZvKAJ8670YWPATh3z+qWRtTt/+HngOgFAjXR+L/umrcwnuRuhI2//NEoAYWBWcRLCLs8J/u19wvo+D4fX5tPtyrF7ezvvi3O8MusqTr/YHLIHvUcz0ttOOAIpaBcSHNcqtfGYPV5O8XjPYCz2/zt3kiYRtFgLilS4CNbqabyWQLfI9iEqCjYV5guRP4yCv6nGx/ypW7ZQtrQdJ3QNL10PHzERcVEjowIBBGcceS1jQcscHIAwoG2ghI3k98spYl6R1RjOgj5MdGgXmJnc5RDmKU6RkMC2HknKaFkfdUL7LpKJh38exZaNrSs7ZpGZ/5Up2kS9s/j+9thA1+OhNV7pMlTyVCc4is5zZqSR9sJs38FAQMZCOA0d1/YVoVx1BDvbIaH61mXXgbh8i0ECbvuLvCnvcvhNb20WxzNFQHf/rvyPIoj6MHMXYhnUh34riMX37L0+rBK5bLiUj8I7diwe4gx22+zag/cHF4BD7B8cCum+Sv
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(921020)(22082099003)(18002099003)(13003099007)(3023799007)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bTjk4gtPzsg8kTZc97iZ4AMLfR29GBSu5u24dJ1UmFUIIg/TQ1zJQtc8mSgZAzR+J3q+C3YAJ8dSVKLv4C4Bm8+TmQ7yHzZ5CLXQwPKIJMB9lc3/RB4ggoYxpuA7pZ1SUpjjYAoM3uZArt/cPvEoi2rTJDQwELuQEbIORLm6CtuyKoyaSrO8Q0zXGYZX13iQ7B+AJxicCZRlNMP/AOb0bUvQtmm/LPrQUj8R0mve/GsRbq1gkip2SoIqgWkW/MfNDOTqxdE66TppuzqR2ry0vVaa3wZLR/L7ErsJd+lDH2L/m4en+YEdfQ0yq9w5ZNPNefAiM55SjytXTcBx+0tEaDgaL3DwYPMmyjn7jvsJ4M9TXqnAdgiAnlYedslPwnBiIAB1jA2e/3T+JaCaxE7aXy+4jPUc8vLT/ygj34uMdIgZW30da1+bgM09XgE6d3Pj
X-Exchange-RoutingPolicyChecked: azxSRQN+RXvZ7lvsuuuhEjnw02bqz04UWv/cTeB4aR5NuUC3U9murbIweKAe5T9Nl7h8i+vE1UM/m26JPWlW2PdHQkaYHsmXje6IZJdYiKSRTQQYQWWm8ZiyI2Sa8ezFLNaRDS7zfnoqDtqLyxVh9N9TMO1dMS+Utrdsg3z91i7YWh4VG+rWajvheaTVWjJtq2PaYImM5xi8Xik+Tn2BqF3lJRdGj9RRhTvw5XMf7S3QUuEvPU1aY8TIF5IbRh+zNcZnqOPUlO3kdS2zXOnaYk/ku7567klcmUb8pA4hR4xOXEw7khwrqP72lF3uJDL7W+FhBMZE/sYoSbV2xEhNPA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 21:19:55.0401 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aef685bf-0aa7-451e-e0f6-08ded2365654
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6525
X-Authority-Analysis: v=2.4 cv=R6cz39RX c=1 sm=1 tr=0 ts=6a3c4a02 cx=c_pps
 a=wAiiizkMq93U2JYT/wsFEQ==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=lLZmtIKjAAAA:8 a=NEAV23lmAAAA:8 a=fGhLjsSNAAAA:8 a=sozttTNsAAAA:8
 a=mb9bpXRMdmiVFoUIA2EA:9 a=q5Nj8NTjyn2D8kUwajRn:22 a=LYKFdyShAPKLkGq8p7WX:22
X-Proofpoint-ORIG-GUID: V8LF6vVGzy-aBNMwzxN7knJfsAhr78Gz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE3OCBTYWx0ZWRfX6q3y2ZZEIwXr
 KMLm1JMBXnzt2R8dvRjV/TYke2BmgZruZrcnG263cQOZ6/sOj11tb4bt+3eSLkRu2zBIJALlBJJ
 7cpdQBI+VQaX4/CEN19MIOgMefJEbP8=
X-Proofpoint-GUID: V8LF6vVGzy-aBNMwzxN7knJfsAhr78Gz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE3OCBTYWx0ZWRfX1pKOaIQvk3e/
 +jxws3dY6w1IEP7CxRY3kXvDSB8Snu/VXq9TXMF0JaILeHt7cU2zZah+TJ/h1Epk7Kwp4VCd6ES
 LD7YRskhwPu2/qnzYyy+dmSaBXCfWibUR+qXLRVnyY1pG/wveG35afOlvcwbsnsdjX3eHSyQQAW
 b0IkoIhtPVyjQzHVYMOQcryEWVN/1BGFRJgk/OG9LK+nMSb5SGxsjpjW8Oi2xTV+3E62eCRoZAw
 P6Dy29+asGaWAvOnZuBTqP+/JjZ/3fqP6SRHw46l7GHntNcEMvoIVwgWknmrQBD0BrQLbM676iD
 zCVSqOTooLT2mK6fMrZc2cD3QOdk2bY2SEV4bBpX2PWVfaF3Rx9hA+WZxXByYjJneqB+MdOVMQD
 pLX6Su37AfgZN3R7qF8zOVo+wMVyFh/+C3xGP8kZT5rW6I+SVMRt5zjqf4TRxMOXwXf1IV2VaHp
 mO+YAidOtMBbwgIb4dw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_04,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240178
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

From: Randolph Sapp <rs@ti.com>

Take Phytec's current DDR fixup functions and utilize them to
dynamically adjust for variants in the pocketbeagle2. There are
currently 3 skews, two of which are both 512MB with the same memory
configuration, and one which is 1GB using the same CWL and CL settings
but a modified density [1].

Based off of Bryan Brattlof's patch [2].

[1] https://mm.digikey.com/Volume0/opasdata/d220001/medias/docus/5411/8G%20Bits%20DDR4%20SDRAM.pdf
[2] https://github.com/bryanbrattlof/beagleboot/commit/fb2f022e27427e990d7a33fd001ffb571e13cfc3

Signed-off-by: Randolph Sapp <rs@ti.com>
---
 board/beagle/pocketbeagle2/Kconfig            |  26 +++++
 board/beagle/pocketbeagle2/Makefile           |   2 +
 board/beagle/pocketbeagle2/pocketbeagle2.c    | 103 +++++++++++++++++-
 .../beagle/pocketbeagle2/pocketbeagle2_ddr.h  |  50 +++++++++
 configs/am62_pocketbeagle2_r5_defconfig       |   5 +-
 5 files changed, 184 insertions(+), 2 deletions(-)
 create mode 100644 board/beagle/pocketbeagle2/pocketbeagle2_ddr.h

diff --git a/board/beagle/pocketbeagle2/Kconfig b/board/beagle/pocketbeagle2/Kconfig
index e957b8e8377e..a361fcebfc1d 100644
--- a/board/beagle/pocketbeagle2/Kconfig
+++ b/board/beagle/pocketbeagle2/Kconfig
@@ -12,6 +12,7 @@ config TARGET_AM62X_A53_POCKETBEAGLE2
 	select ARM64
 	select BINMAN
 	select OF_SYSTEM_SETUP
+	imply TI_I2C_BOARD_DETECT
 
 config TARGET_AM62X_R5_POCKETBEAGLE2
 	bool "BeagleBoard.org AM62X PocketBeagle 2 running on R5"
@@ -23,6 +24,7 @@ config TARGET_AM62X_R5_POCKETBEAGLE2
 	select K3_DDRSS
 	select BINMAN
 	imply SYS_K3_SPL_ATF
+	imply TI_I2C_BOARD_DETECT
 
 endchoice
 
@@ -58,3 +60,27 @@ config SPL_LDSCRIPT
 source "board/ti/common/Kconfig"
 
 endif
+
+config POCKETBEAGLE2_AM62X_RAM_SIZE_FIX
+	bool "Set the PocketBeagle 2 RAM size instead of detecting it"
+	default false
+	help
+	  RAM size is automatically detected through the device revision stored
+	  in EEPROM. This overrides the detection logic with a fixed value.
+
+choice
+	prompt "PocketBeagle 2 RAM size"
+	depends on POCKETBEAGLE2_AM62X_RAM_SIZE_FIX
+	default POCKETBEAGLE2_AM62X_RAM_SIZE_512MB
+
+config POCKETBEAGLE2_AM62X_RAM_SIZE_512MB
+	bool "512MB RAM"
+	help
+	  Set RAM size fix to 512MB for the PocketBeagle 2.
+
+config POCKETBEAGLE2_AM62X_RAM_SIZE_1GB
+	bool "1GB RAM"
+	help
+	  Set RAM size fix to 1GB for the PocketBeagle 2.
+
+endchoice
diff --git a/board/beagle/pocketbeagle2/Makefile b/board/beagle/pocketbeagle2/Makefile
index 3d42c160716e..dd529fe6d75e 100644
--- a/board/beagle/pocketbeagle2/Makefile
+++ b/board/beagle/pocketbeagle2/Makefile
@@ -7,3 +7,5 @@
 #
 
 obj-y += pocketbeagle2.o
+obj-${CONFIG_K3_DDRSS} += ../../phytec/common/k3/k3_ddrss_patch.o
+obj-${CONFIG_TI_I2C_BOARD_DETECT} += ../../ti/common/board_detect.o
diff --git a/board/beagle/pocketbeagle2/pocketbeagle2.c b/board/beagle/pocketbeagle2/pocketbeagle2.c
index 291a1c6c3db7..8463d82ef9d8 100644
--- a/board/beagle/pocketbeagle2/pocketbeagle2.c
+++ b/board/beagle/pocketbeagle2/pocketbeagle2.c
@@ -17,17 +17,118 @@
 #include <dm/uclass.h>
 #include <linux/sizes.h>
 
+#include "../../ti/common/board_detect.h"
+#include "pocketbeagle2_ddr.h"
+
 DECLARE_GLOBAL_DATA_PTR;
 
+static int pocketbeagle2_get_ddr_size(void)
+{
+	// check config overrides first
+	if (IS_ENABLED(CONFIG_POCKETBEAGLE2_AM62X_RAM_SIZE_FIX)) {
+		if (IS_ENABLED(CONFIG_POCKETBEAGLE2_AM62X_RAM_SIZE_512MB))
+			return EEPROM_RAM_SIZE_512MB;
+		if (IS_ENABLED(CONFIG_POCKETBEAGLE2_AM62X_RAM_SIZE_1GB))
+			return EEPROM_RAM_SIZE_1GB;
+	}
+
+#if IS_ENABLED(CONFIG_TI_I2C_BOARD_DETECT)
+	// dynamically detect the config if we can
+	if (!do_board_detect_am6()) {
+		struct ti_am6_eeprom *ep = TI_AM6_EEPROM_DATA;
+
+		if (strlen(ep->name) > 11 && ep->name[0] == 'P') {
+			/*
+			 * POCKETBEAGL2A00 (am6232 512MB)
+			 * POCKETBEAGL2A10 (am625 512MB)
+			 * POCKETBEAGL2A1I (am625 1GB)
+			 */
+			if (!strncmp(&ep->name[11], "2A1I", 4))
+				return EEPROM_RAM_SIZE_1GB;
+		}
+	}
+#endif
+
+	return EEPROM_RAM_SIZE_512MB;
+}
+
 int dram_init(void)
 {
 	return fdtdec_setup_mem_size_base();
 }
 
+// logic after this block assumes that there is only 1 DRAM bank currently
+#if CONFIG_NR_DRAM_BANKS != 1
+#error Unsupported number of DRAM banks!
+#endif
+
 int dram_init_banksize(void)
 {
-	return fdtdec_setup_memory_banksize();
+	eeprom_ram_size ram_size;
+
+	memset(gd->bd->bi_dram, 0, sizeof(gd->bd->bi_dram[0]));
+
+	ram_size = pocketbeagle2_get_ddr_size();
+	switch (ram_size) {
+	case EEPROM_RAM_SIZE_1GB:
+		gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+		gd->bd->bi_dram[0].size = SZ_1G;
+		gd->ram_size = SZ_1G;
+		break;
+	case EEPROM_RAM_SIZE_512MB:
+		fallthrough;
+	default:
+		gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+		gd->bd->bi_dram[0].size = SZ_512M;
+		gd->ram_size = SZ_512M;
+		break;
+	}
+
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_K3_DDRSS)
+static int update_ddrss_timings(void)
+{
+	int ret = 0;
+	eeprom_ram_size ram_size;
+	struct ddrss *ddr_patch = NULL;
+	void *fdt = (void *)gd->fdt_blob;
+
+	ram_size = pocketbeagle2_get_ddr_size();
+	ddr_patch = &pocketbeagle2_ddrss_data[ram_size];
+
+	if (!ddr_patch)
+		return ret;
+
+	ret = fdt_apply_ddrss_timings_patch(fdt, ddr_patch);
+	if (ret) {
+		printf("Failed to apply ddrs timings patch: %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+int do_board_detect(void)
+{
+	void *fdt = (void *)gd->fdt_blob;
+	u64 start[] = { gd->bd->bi_dram[0].start };
+	u64 size[] = { gd->bd->bi_dram[0].size };
+	int ret;
+
+	dram_init();
+	dram_init_banksize();
+
+	ret = fdt_fixup_memory_banks(fdt, start, size, 1);
+	if (ret) {
+		printf("Failed to fixup memory banks: %d\n", ret);
+		return ret;
+	}
+
+	return update_ddrss_timings();
 }
+#endif /* CONFIG_K3_DDRSS */
 
 /*
  * The U-Boot stack can collide with some dt reservations in the 512MB
diff --git a/board/beagle/pocketbeagle2/pocketbeagle2_ddr.h b/board/beagle/pocketbeagle2/pocketbeagle2_ddr.h
new file mode 100644
index 000000000000..c144dbafe059
--- /dev/null
+++ b/board/beagle/pocketbeagle2/pocketbeagle2_ddr.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * DDR override logic for AM625 PocketBeagle 2
+ * https://www.beagleboard.org/boards/pocketbeagle-2
+ *
+ * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#ifndef __POCKETBEAGLE2_DDR_H
+#define __POCKETBEAGLE2_DDR_H
+
+#include "../../phytec/common/k3/k3_ddrss_patch.h"
+
+typedef enum {
+	EEPROM_RAM_SIZE_512MB = 0,
+	EEPROM_RAM_SIZE_1GB = 1
+} eeprom_ram_size;
+
+struct ddr_reg ddr_1gb_ctl_regs[] = {
+	{ 317, 0x00000101 },
+	{ 318, 0x1FFF0000 },
+};
+
+struct ddr_reg ddr_1gb_pi_regs[] = {
+	{ 77, 0x04010100 },
+};
+
+struct ddrss pocketbeagle2_ddrss_data[] = {
+	// default configuration
+	[EEPROM_RAM_SIZE_512MB] = {
+		.ctl_regs = NULL,
+		.ctl_regs_num = 0,
+		.pi_regs = NULL,
+		.pi_regs_num = 0,
+		.phy_regs = NULL,
+		.phy_regs_num = 0,
+	},
+
+	// industrial configuration
+	[EEPROM_RAM_SIZE_1GB] = {
+		.ctl_regs = &ddr_1gb_ctl_regs[0],
+		.ctl_regs_num = ARRAY_SIZE(ddr_1gb_ctl_regs),
+		.pi_regs = &ddr_1gb_pi_regs[0],
+		.pi_regs_num = ARRAY_SIZE(ddr_1gb_pi_regs),
+		.phy_regs = NULL,
+		.phy_regs_num = 0,
+	},
+};
+
+#endif /* __POCKETBEAGLE2_DDR_H */
diff --git a/configs/am62_pocketbeagle2_r5_defconfig b/configs/am62_pocketbeagle2_r5_defconfig
index 90e577e8ce16..82919d559d5e 100644
--- a/configs/am62_pocketbeagle2_r5_defconfig
+++ b/configs/am62_pocketbeagle2_r5_defconfig
@@ -14,7 +14,7 @@ CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="k3-am62-r5-pocketbeagle2"
 CONFIG_DM_RESET=y
-CONFIG_SPL_SYS_MALLOC_F_LEN=0x7000
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x8000
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
@@ -41,6 +41,7 @@ CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_EARLY_BSS=y
 CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x400
+CONFIG_SPL_I2C=y
 CONFIG_SPL_DM_MAILBOX=y
 CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_POWER_DOMAIN=y
@@ -72,6 +73,8 @@ CONFIG_SPL_CLK_K3_PLL=y
 CONFIG_SPL_CLK_K3=y
 CONFIG_TI_SCI_PROTOCOL=y
 CONFIG_DA8XX_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_OMAP24XX=y
 CONFIG_DM_MAILBOX=y
 CONFIG_K3_SEC_PROXY=y
 CONFIG_SPL_MISC=y
-- 
2.54.0

