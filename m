Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4918CA0EED
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 07:32:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD54A82E67;
	Wed, 20 Aug 2025 09:32:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ZFn16Hto";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7602182E34; Wed, 20 Aug 2025 09:32:30 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::622])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9E5282E34
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 09:32:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/O16p2IUrA75Q05iUnkFoW1iWY+ZitSD3BtCTVxUuucYHhwxHr0Ks87t5KBHG8vPcLTaUUPhC+KV5bOQMKmGn0tHHskSONa3U2FWOfAAW4BTfFTfMdVZJWT9HcYBETbmXFFfWMv1VazAxunO7/pRaKsfSSOb86zlAdutc8X1/h3YLxgAtg52KH65IDXnDTVzBv4VDuv17l6cAVRtXTG1GMkdh2OIxz1gzbiTjBOrMfeD9D1azE70EZ0pxX3Sg6NPVrfc1GyNIbDh2qaaToddWnfma10/bdAIK7GPm0ycLpBr1IdmMCQSC0nMavCb2+rWIzbeq/NlbJUx02wdReHLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AK7Qt8f64DBKnTpoZroLip4OamofbfAydIBGOYHrppY=;
 b=Gy1R3lyRAPZ73y0W6DHrLgNwWpJKP/UU9dbT0MCchZ93AUanGJdIvAenVutjU1qlDpw7PptpQEnGiCHkBbNoAidmTN76KTgfPbioGnRn1SXcX2h1vlMmVwl5pWzbsBj1Cabi1Tq44w6VtG9k9zN2ZTgZlbbx2BLbaQaZAkUErAC7m5cqlBUZ9DdO7dWWjacD7wG6mAizZelR23yCsyE4b3hAzZ0mYGmAidp/5pS1rppOUg00AFU/oORYe/qTcMRM4RsS2bq63Msmi4QeprmLnly1i0JAhG/mZd+RgXB+bL/6g/KlpFLYmPphytjMsAgJD220SZ+WmUMjrOY0os0TXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AK7Qt8f64DBKnTpoZroLip4OamofbfAydIBGOYHrppY=;
 b=ZFn16HtocQ8fLkGvz0QMiI8gmrtXYam4OaF5lummABA/sXPNyH/9sBAQy4N6KqUcx+zTWFZgmicuK7+9nLfwxcpVOdg1ViZf4VsxviCo/WoEUj58tUv2uuyZP+GpKqMRFKDZKztXAXEgYbiVkMa3UsfElASuboC0F7uYkh0Au9gjX3l/6ZFmv+uJ1N8A0JDwZFDt+dktinW2ZC+D1tH8a2ftlJdgxpeCYfDrf69S7OZ0eXQtOLwlO8E5mk++1i30KkuReX5IYtkCe+iAVxwm5weaoCDxm3WIPFJnrEBURQjnaX3SUaTTG1iOLmr7SAIuTISuxJGzytJEGiOulZlCzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by CH5PR03MB7982.namprd03.prod.outlook.com (2603:10b6:610:214::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Wed, 20 Aug
 2025 07:32:24 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9052.012; Wed, 20 Aug 2025
 07:32:24 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH v2 2/3] arch: arm: socfpga: Add SMMU checking functions
Date: Wed, 20 Aug 2025 00:32:00 -0700
Message-Id: <20250820073201.8649-3-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250820073201.8649-1-nareshkumar.ravulapalli@altera.com>
References: <20250820073201.8649-1-nareshkumar.ravulapalli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0348.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::23) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|CH5PR03MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: f53688d0-867e-40b6-22f2-08dddfbbb4b8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9GxKrJfX3LUXiuxMYinT/GYTkAEQcjfyz1CBMKkZrGA7L1PE2hYvzCs6ks7z?=
 =?us-ascii?Q?YgRgiB31unECOXXUPbMym/64hfAS6FjmkzoKrpTNVgZ0jt7Svk708bAM+6Ie?=
 =?us-ascii?Q?kgNqf2NxO6cEVGEDCXEetRePTIikG927i3ZthYFXQgQ+F8bccdBEozx5KbNg?=
 =?us-ascii?Q?kMtRCTEMX6ZITOriw0nUNm8+n4fSzsAw16hW8ypmp/kDcOgQEoz/gIFenufi?=
 =?us-ascii?Q?loiuR2Gx4KfZpcx2PDGlvDnWMGJ+40MPQ3+nmX9EbSYVZ1wtvIv7HFBAXO6f?=
 =?us-ascii?Q?qcFtVVUaAnsmrkIIFlAwkHDu5acf3VWlKncxjjFi/MWWYdoSOy4oJlfL4t0T?=
 =?us-ascii?Q?opZ+CaUK19jI2GXHrTHTvqHkvJMi8eJkiOP88/19JVeDiq/pvuRufz5vrH6z?=
 =?us-ascii?Q?H501vCPr5NYdsUeudRP5zsV58c8AnLXlBQv+GhWLYIbFO8JUY8CilgZUOkB5?=
 =?us-ascii?Q?bJxHTUqYLzoWa4Put37kpAjTtwpvPXcjgTdJa5b1t6GRPBS7ofesnvCAjPGx?=
 =?us-ascii?Q?vBvQLOeAfXcfIWh9AuV6VuJ5qZYl5VMIDGW0T+UtDjLn3aZTeRmDq5iLGiAv?=
 =?us-ascii?Q?YjIfphOfoLN9AxGsBsdLgYKfX9U+LaWH39DHlTSv2AseNROXYdZWv0IAk/67?=
 =?us-ascii?Q?uWL0JBcwA1t/Jr7GUJOGtu0mhebRKLMWFoHRZjG3FugmAocoEL2DfL1PUogB?=
 =?us-ascii?Q?OrRJynF6Y0pcb99T869dXIZk9puJ2pxz+YBWa8/b7GpJVJVad6SDmUVliPJD?=
 =?us-ascii?Q?PS1xGX5+prXlOXIttJGCf0QOfY/iXnaHtxTGpPl/KDpZ0Y/VDd1AudepztfL?=
 =?us-ascii?Q?NypM6woNjZOQeafSziZBv7Sq/ZDiM6XNPcagniyUntp0CVs2eEYHDy00vWkA?=
 =?us-ascii?Q?tVyPSZW7qNMkaF6xWsVjknZVmEMlgm1CuW4Sy9DP47x7QQG4p8bUjIpwNCeU?=
 =?us-ascii?Q?FdG1tm1vd1g/cow2W0+aHo97fJF7PzEf59MF/og8e67h5UUskMpvjgI4SWOP?=
 =?us-ascii?Q?Rq/wauAj17H2RE21VO59Jto4YKjtQwUiVXhrvKGaFPbmRwjf9GG8LwG3C89S?=
 =?us-ascii?Q?D4Mkn4jRc9voPln7DmGGMwDgklTg4fAwBmI1GfIOPYX+7RYghDCSPmW1+AWI?=
 =?us-ascii?Q?u9inMxjsT58Ru/yFE9S4ive/NS4Y8coAOB5tHAxWu9k999Gv2X+2R2ITTlnu?=
 =?us-ascii?Q?QK6a+xzqjNrE7o6e5zrCn/WOgDAM55iD2BgPfgEW8Z+EfQgLuLdmzpdWn5cz?=
 =?us-ascii?Q?kFP2uIJpVHRnshRz4t2TCCtiGeAgODReALVnpIHb9jUQplA3KmuDwwQ6rJ4T?=
 =?us-ascii?Q?+m/6ClFmD0Ee7o99UitmLWBHi+s5RW4ws68TW/4gMqtk6B1x3M+gjGx9p36A?=
 =?us-ascii?Q?/DLFc12RsdqEro5gVMAp5cw5CrMPqHs/5S/2Nw1/h8Axvw/YhWBsBCW7wZW2?=
 =?us-ascii?Q?q6WBAYTrCXc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3Nx8hBjWlkWT/AkKgJc6e8NHJkI046oYIeRyH77YFgo6Ydb31aVrSLjM1a29?=
 =?us-ascii?Q?IWbuXZ7nkb9cSGgJ50ifIcycABVRFDyDCUcSgFAJHmxgRebRHUz2nLD3rJ1V?=
 =?us-ascii?Q?ozutUx7J5Ym79xHFT25XzNrmSua8TwsS6URpkvzGnnFTjHZVvRUb9kXQns6I?=
 =?us-ascii?Q?9sSj/qvt2SZ5fz0q9Mn/o7GbHW6mIeK22YAzHyjLgJrPbM4524dovB2t1ZE5?=
 =?us-ascii?Q?DaDapn447a9p3Fja83g90XaZ+dZ12QI94hy5MXyXxQUNpwgKiUAoKkC2R1B3?=
 =?us-ascii?Q?N7uEfKEzaIZw/IY55Cge5EoPF2owKi46pXHodK+sWKT6evj3ok4NYkZreOvU?=
 =?us-ascii?Q?LqFQlI7omwlHkpOw5tw7NRlQURFasiB40cjyUmtZnpWOUQfT47V/OlH9aPhD?=
 =?us-ascii?Q?ha6+J0J2YFVgwx7k7nbs0NCsuoGnzo4AV/q1TD6sC1uDtW0zLi6jYrVVay9q?=
 =?us-ascii?Q?WGN9qy6V2vrEKiL41nhkaSvva9CQELVjEv3xUX3ByGnyIcQIX1AtMYm6uSOF?=
 =?us-ascii?Q?eqU1JeXUQQQu7djLu4ufOkdKFWwlqmVS3m2LukVCGQWGQA0gceHq5uXiHDoM?=
 =?us-ascii?Q?GpM6dFAdrlq9IEvHZYcp9GTJLyWzPAmd4cjPRqjoF2m8PhJdFnbhqGWszxT4?=
 =?us-ascii?Q?BeEuW8XDD77MDgGIn+o3Up0uhyqCLrjywHomepqc5CYVMHo7sO5XfmBOVvkQ?=
 =?us-ascii?Q?ozpdaLi3LKC4K8aYwutuytZ7PBPRAj9CM6NxZqk2XY4kHAP/B6AHWVBm96Js?=
 =?us-ascii?Q?xfefI6vJvutXoJ2wlZ2WXrgznEjy1CA2plIlh5tst1pT4ic7TGMLtOVrYKyg?=
 =?us-ascii?Q?Lf0a59IVesuVLA4MYw+1GtxSOOsacpnK9HFwdMqCkEabpy4Mc0+bltEmQeen?=
 =?us-ascii?Q?Zs9D07qorekMJ4bDlwkfK6tIry6gu9XFaA1LbVYtEFrZf/p1jX0HXiNe6xb8?=
 =?us-ascii?Q?sy5MKr9a+PZJOzy8mwyaMl7u1OtusGSJP7x2loQIHyqF9Hh2YObhpAVZeooS?=
 =?us-ascii?Q?H57bRXr9Y19XAcPiPm6ozBpRrLizJE+BH1edLbNVg8WFF7kcrkO+7EV3j1mV?=
 =?us-ascii?Q?K98Eiryg9onfXiGCudL3Y0kub18uALKoaHoyBy+H31Ii7X+YlsHVmFQQGPvU?=
 =?us-ascii?Q?k8G9iih92Ewka/ptRcmcEgyfC8DkvOENmwNFW8F8Gc6lK34djxdnuAYGSw8W?=
 =?us-ascii?Q?JlanYd3ZZcUBaU2BxxZu0JrLWCoaoTuahw154zPJVHmnH5RQzAUmvGOZKSSP?=
 =?us-ascii?Q?Ras1tO2dfRaPECXBo1L6D/avKMmQuJ0p/gtoVit+gqWUmCmoMC02JeGnyzFc?=
 =?us-ascii?Q?5TKmqVJlw3hAaB9qk3qLE5JwV1wt1g/owNFYDm1Ql/Bi1hsXI8PkXJI4nhcO?=
 =?us-ascii?Q?nJHCUpCC/l6IQTWtxrzKbv88f8Hs0I61dMcesBETaghZgaSDg9ygtYgA1lEy?=
 =?us-ascii?Q?uhYuND763SEHu5aosv9F548THhO2FnA6z2PHS8FUeS/IA0Td21ODK4/T09K2?=
 =?us-ascii?Q?x+gUai6sF8QThgBPJr136LlLizoPbDSd6UU+aQx/HK/0HTSfFGtugUFtxGQf?=
 =?us-ascii?Q?kTea+A+ScNp2j/JnSSXVLAuVwy+neHlt+2Nq6FzyaK71v4KqqnlTMBtwW1pf?=
 =?us-ascii?Q?I24Uo+oPIib069xf2RLtfhg=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f53688d0-867e-40b6-22f2-08dddfbbb4b8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 07:32:24.1517 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m3YYEfBJzx0z12I3Ws9Gc/KXC2tbT28LfSyJgJAajOeDhyikjYy/vz9fVm3t1Q5zTbT/iLyXApSs50OVippPmdJwt00i7KpUFVULy/HlicXztmlyfO8N6ScrofS6x2j3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR03MB7982
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

Add functions for checking SMMU bypass status and also,
matching valid hardware device Stream IDs in SMMU Stream Mapping
registers.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 arch/arm/mach-socfpga/include/mach/smmu_s10.h | 28 +++++++++++
 arch/arm/mach-socfpga/smmu_s10.c              | 48 +++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/arch/arm/mach-socfpga/include/mach/smmu_s10.h b/arch/arm/mach-socfpga/include/mach/smmu_s10.h
index 4a28b109b0d..209caa86e38 100644
--- a/arch/arm/mach-socfpga/include/mach/smmu_s10.h
+++ b/arch/arm/mach-socfpga/include/mach/smmu_s10.h
@@ -4,7 +4,35 @@
  * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
 
+/* SMMU registers */
+#define SMMU_SCR0			0
+#define SMMU_SIDR0			0x20
+#define SMMU_SIDR1			0x24
+
+#define SMMU_SCR0_CLIENTPD		BIT(0)
+#define SMMU_SIDR0_NUMSMRG_MASK		GENMASK(7, 0)
+#define SMMU_SIDR1_NUMCB_MASK		GENMASK(7, 0)
+
+/* Stream mapping registers */
+#define SMMU_GR0_SMR(n)			(0x800 + ((n) << 2))
+#define SMMU_SMR_VALID			BIT(31)
+#define SMMU_SMR_MASK			GENMASK(30, 16)
+#define SMMU_SMR_ID			GENMASK(14, 0)
+
+#define SMMU_GR0_S2CR(n)		(0xc00 + ((n) << 2))
+#define SMMU_S2CR_TYPE			GENMASK(17, 16)
+#define SMMU_S2CR_CBNDX			GENMASK(7, 0)
+
+/* Register groups for Context Bank */
+#define SMMU_GR0_CB(n, r)		(0x20000 + ((n) << 12) + ((r) << 2))
+#define SMMU_CB_SCTLR			0
+#define SMMU_CB_SCTLR_M			BIT(0)
+
+#define SMMU_SID_SDM2HPS_PSI_BE		0
+
 void socfpga_init_smmu(void);
+int is_smmu_bypass(void);
+int is_smmu_stream_id_enabled(u32 stream_id);
 
 #define SMMU_SET_STREAMID(x, r, w)	(((x) << (r)) | ((x) << (w)))
 
diff --git a/arch/arm/mach-socfpga/smmu_s10.c b/arch/arm/mach-socfpga/smmu_s10.c
index 50be049538b..c3230ce860e 100644
--- a/arch/arm/mach-socfpga/smmu_s10.c
+++ b/arch/arm/mach-socfpga/smmu_s10.c
@@ -75,3 +75,51 @@ void socfpga_init_smmu(void)
 	set_smmu_streamid();
 	set_smmu_accessible_reg();
 }
+
+int is_smmu_bypass(void)
+{
+	return readl(SOCFPGA_SMMU_ADDRESS + SMMU_SCR0) & SMMU_SCR0_CLIENTPD;
+}
+
+int is_smmu_stream_id_enabled(u32 stream_id)
+{
+	int i;
+	u32 smrg_num;
+	u32 smr, s2cr, sid_mask;
+	u32 cb, cb_index, cb_num;
+
+	if (is_smmu_bypass())
+		return 0;
+
+	/* Get number of Stream Mapping Register Groups */
+	smrg_num = readl(SOCFPGA_SMMU_ADDRESS + SMMU_SIDR0) &
+		   SMMU_SIDR0_NUMSMRG_MASK;
+
+	/* Get number of Context Bank */
+	cb_num = readl(SOCFPGA_SMMU_ADDRESS + SMMU_SIDR1) &
+		 SMMU_SIDR1_NUMCB_MASK;
+
+	for (i = 0; i < smrg_num; i++) {
+		smr = readl(SOCFPGA_SMMU_ADDRESS + SMMU_GR0_SMR((u64)i));
+		sid_mask = (smr & SMMU_SMR_MASK) >> 16;
+
+		/* Skip if Stream ID is invalid or not matched */
+		if (!(smr & SMMU_SMR_VALID) || (smr & sid_mask) != stream_id)
+			continue;
+
+		/* Get Context Bank index from valid matching Stream ID */
+		s2cr = readl(SOCFPGA_SMMU_ADDRESS + SMMU_GR0_S2CR((u64)i));
+		cb_index = s2cr & SMMU_S2CR_CBNDX;
+
+		/* Skip if Context Bank is invalid or not Translation mode */
+		if (cb_index >= cb_num || (s2cr & SMMU_S2CR_TYPE))
+			continue;
+
+		cb = readl(SOCFPGA_SMMU_ADDRESS + SMMU_GR0_CB((u64)cb_index,
+							      SMMU_CB_SCTLR));
+		/* Return MMU enable status for this Context Bank */
+		return (cb & SMMU_CB_SCTLR_M);
+	}
+
+	return 0;
+}
-- 
2.35.3

