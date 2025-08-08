Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81648C87FD2
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 10:04:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9974846B7;
	Fri,  8 Aug 2025 12:04:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Acjox2ds";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58DFE846BA; Fri,  8 Aug 2025 12:04:33 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::61e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 675B1846AA
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 12:04:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OOggtuBo9NxXykW3R6HGqZ9ypGakdCciBb9ovfts8xg8uVyxWPHyLt7CaG6eKy7uQas/sjcEA0aYrcPqBxKcx82ZNK4OU1qyJMa7nPPsNV5tHgX9TF84shtfltgVh2+9WG36fDc07q7QhT3IM8rWheUO2Etp3u/cNlkkK5M81rD4LyV4W5kIAV0PvSbOW4pMgd4otliQykHTmM8J7/aZcO3rkwQZm03FwATJoI/WM+U+Z1UF1A2fBVttocm75ZglD6Rdw+aDBtEeLJEcUQ2f91/KQ5l3nldt7yxH9t4vQoI303tOoNn0+b1oL263S5YITly0kluihHYNpRIV96X0sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5K3DvznPjrhdt2VIqqNoE7RaAUKIOJcgSJQW0z33klQ=;
 b=I5/GmZ1ipLbioXGA2Mwc0GB/XQMfQXRTMnwcA9vqTyfprtd8UACuFupB3Zx+K/052WR8ZfSFJRmEcYwG0XYm4KETYZZRnf8aeP5Y//v2hF7YaoA0riKmv6ofoz0i1Q4FruBXx5cJvS03S7gR6dSB/jMWj5AstUFH6CpShxhunPzk3RA3+ReG3lRWC0cgkPdiAWUQRvv/GDyZgT8XUO4uiVFRS35yiE6mS0ESpXkEYwpvXDHqldrY84HQFJT4FsJ/Fls2AlIHtwNWV9pmUTV3yQTga3E172PsEp28eGU7gj/VA0kZFQqSi4iU1CWiU9LxzjwpHfOx2ivtu51mdxQvjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5K3DvznPjrhdt2VIqqNoE7RaAUKIOJcgSJQW0z33klQ=;
 b=Acjox2dsjONtOBdkpCmbGxoRe6amG78f5rmNf3I0J0EUgkmh56wHJXoz7tk6MGhVXG0UczZNiAc7WPiVV14E3sBz/GQoAIRS9XqaioemcQdm1NDWEQAdlgIR/AufROqnhWeJUnSFuf7d/JT/2OFgt9bdw0CQM3zOyjQS6ZkiXipT1kEHvpS/idVB+WP2XqyoO1lMZF60lT3DrS5Hhm+KXgcDbEGi/grjHAYVvzRhQmbDnpJFoRSDfVjjfUiB+GUrpl+dmqfOHWzp87wKiDBkOuGfAyaik5bCXKEr94HFOXjaI117cdhkTZPleuRvgBOOm0jXYmTiGW3rQyAuZY+l7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by PH0PR03MB7113.namprd03.prod.outlook.com (2603:10b6:510:298::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Fri, 8 Aug
 2025 10:04:26 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 10:04:26 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH 4/4] arch: arm: socfpga: Configure USB3 System Manager
 registers
Date: Fri,  8 Aug 2025 03:04:12 -0700
Message-Id: <20250808100412.9320-5-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250808100412.9320-1-nareshkumar.ravulapalli@altera.com>
References: <20250808100412.9320-1-nareshkumar.ravulapalli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0163.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::18) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|PH0PR03MB7113:EE_
X-MS-Office365-Filtering-Correlation-Id: d011e714-d933-427d-a3c2-08ddd662f4c4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WdKoDNXwN5Xtci1oHQMguMeFv5doU482vBTd6h/mePKUi8IVFzIgD6jTeYPf?=
 =?us-ascii?Q?PyGGqecTm5xXQOesLYsontYNIvAXZsIg5RJL+JEnf/PaF3V5Ex+2nr+KwdSm?=
 =?us-ascii?Q?N8vL3PJI3eNLKdBgj92RLB+6wj6V8rZqGPNUBW6mPJfeeEMffabFjJBtXzjN?=
 =?us-ascii?Q?NJNEh+Ubq7vdkYsvvw6L4X4+wgkb/oMYCD1EAehl5O9iq4m+Ze4ZwgG+onTD?=
 =?us-ascii?Q?UYjkIknbO1KblcTF7pV3oKWc0R4MCmlglYKrYhVosC1PHNi+1CCQ7ATMrIv1?=
 =?us-ascii?Q?PLDfGGonCzsE6WkyVmxjpvjz9GYaEzM7zJhe9xQ0qi0FqBogSO+XtA8VtijM?=
 =?us-ascii?Q?BaX8luKwP/4xxIi5HXYG2r3uYy5vswiFn4BKgc6Ccpg/XW2lEvBXtZzHTTob?=
 =?us-ascii?Q?IzfVQNrw1C0ijJhXATZ7euQdyMGtC4GOmurv3chy7zU/Qnyu5slbvtDngCBb?=
 =?us-ascii?Q?UVwzg5OjaVuF7TeacZXaZtBbdwiXblyrKUkrBEMe59EduL3Cm7w91++ZFEx+?=
 =?us-ascii?Q?eKTOElskA1bdeIhvmQ3ZfwPs0qm22TBykGemdIiE1bFM4+kMa1ULqPd0XAlJ?=
 =?us-ascii?Q?DU7Utg1CI3SRGMXnq8YtGGBSMLeDu1CnQDZAYG/DAZUhkfUPZu6M6+in2hRj?=
 =?us-ascii?Q?ADkCRjQWBh1rabL/Ex7ldezCKhVBySTnMQhBr1XZ6mGpBH4/vS/Pz+fX7Fis?=
 =?us-ascii?Q?RE+ao/YRN3wrAEBogV0BnEdxyGrtdI76wseOAOKJtOZGZXeWj8kWKygXFjWe?=
 =?us-ascii?Q?5a+gG6c/rGXSUSvSY8kIkX+5frm5aPuM1BHqZS3tANkpVYaBwSqzSjHLOcAE?=
 =?us-ascii?Q?udcbRG3JLwsoH6ykChSo28x8QfwuzFHuvr5d1MWscrMUxwgcRG04ROZYJQ+4?=
 =?us-ascii?Q?2rDNrMC1/F+9EYKXLjp2es0/meQlDD0Sh3J4Y/ERNuEZABB4YTkB9reNz0r5?=
 =?us-ascii?Q?uUkr1nodm7OG1g810JscjmNYhizyBWc7XJNaQ1w0nrv4Ji/2G4xUKXacFS8Q?=
 =?us-ascii?Q?J78Jq4of7PsJ5F5eDPbPAv3vgsqlkcis1Jtsf1ihUqLd118DO1cZbvd25oTM?=
 =?us-ascii?Q?xIDEv7gMKucsrA/Kmb4izrMOy1PKDbBt/sV/PTxZC7nkoPTtJgcqPTnQvBqe?=
 =?us-ascii?Q?K3oAOb2yz8pQMf/LBaG3VzCUEwYTJpkpR9IlbbwksUoh0VwRwZM0znChT5Pr?=
 =?us-ascii?Q?NOy0SRby+WZb8NfvYGfoGLB+ITHWWFxvUo1GJUwgDq9AO/r/ItkyZ603E/sW?=
 =?us-ascii?Q?UG2B+MK/BQo3YbQZl1O0YHmD/TS8Hw48jc/aEXKx76kzWyoSa0tZJiU19w0P?=
 =?us-ascii?Q?qAi/utS5okp6DHy79ENn+1O4tvbx1cOV/VlKntGcqD31fLmhQB0wZT6GuYVm?=
 =?us-ascii?Q?c4vu8NI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zDvyXGkDL4aqcM66yt9GOX8xHOIraZ4yT1kXVJTaapoztkwGIrBh72fIRqv5?=
 =?us-ascii?Q?kbNyO2KKUSPGWshVre0lBwlEwMFS6BmZPbtgtSOoNytZFaXx6QDUOi5ch9pa?=
 =?us-ascii?Q?PeDrRvqmTrfpu/FVL7008IAG1b6cM9kpomOgsFgR9uPnCb+Vvu2Gnxc+79Og?=
 =?us-ascii?Q?TSPdhBQ/Qu5duyUGljBJfzWAATKsWj56etLVD7GzjWewTryIHHKJKzQa157U?=
 =?us-ascii?Q?9astu/8OVWkx6sXIVk/wLfgeJ5tXwiucnR6k7gndZXNuSdO5S4JwCWhcO0Ay?=
 =?us-ascii?Q?4Szi71dlf67S3pj+NquFWTS1Ud/QYW2hmt1HGw/upgncMMFcwWBFRijJpvAK?=
 =?us-ascii?Q?Ay8mgFGNJB1OBaxW8NneFH0P107InwS5TBU9Ht5n+OSTFGwKOPbXwpwl6+EJ?=
 =?us-ascii?Q?gwkvU3I4gD23DJZDSuFnYXmgl+FBA6oBdc7OxWbpnpEHQ6JhP9+Hv6so8Yrc?=
 =?us-ascii?Q?dVbMwegZTfcF9H0JkOYVzoSss0Mvn14uALb/A0LU1SRa5xPejeMwyZsqRXNO?=
 =?us-ascii?Q?X/i2ilPWWS4dOU6CA9wdDYwsvAJwXHPVKrZl3QIlzX//X3Ee9WECtKaAmkdz?=
 =?us-ascii?Q?j6jNMRmoa1qYs7ljIFNLtS0PpqpusA125i4a6SWs6PT5tG73OOW5UD0798jM?=
 =?us-ascii?Q?gNYLWUQ5A/qHm8vNOqAGb7d6cdsqRoj1A94ZBfDlry7tJpW5JtB89Tk3PqTl?=
 =?us-ascii?Q?mqG6bd/x388G3MhhFIUn2042FRjzWSvqYH81+ZTlu3aLrDMZcVUDidPmd8We?=
 =?us-ascii?Q?rKJhAANlsaEzTySS/1DFI0uPSCTLS0IEL2VyNajp3KDf379dBn5SduacRM6j?=
 =?us-ascii?Q?bZ2+tvYuHmHsDR9rdjqQMostuuJdYgO+lRFrZZujJFi3zlnKKkD690trelJx?=
 =?us-ascii?Q?Lb1X9b7Oj80oDGGyohMaAyqa4sxvrBs+ObyfRYJiMkd3nZEmveV/PlApP0qA?=
 =?us-ascii?Q?Dv56MoKl+Y18m97KcsALExhNmVNkirRvvSZ6wD94utGUh9hCUxudzMkOwP13?=
 =?us-ascii?Q?Tq0pWDJZTLr+CmrcrXEuvpFpyB9lzoTOnb1dr3mHs4LC6I15o5vcKV4XfKBX?=
 =?us-ascii?Q?eHUX5Y1ZHZ2AiaU4uxY90zm69hGrBxXFmZPqzd/IpvRqLsJfm7Pm99qpeKcz?=
 =?us-ascii?Q?gQb8LXNscIkd9Prz6VXRWWIv7nuIzGImq4a1dCt9nGMWKVTXNbvJZdefbVLL?=
 =?us-ascii?Q?AVLUgPsXG/YtarvKhGtG2orUPDFmk0G0oilnJIehtuSJBsc8SsHCaU2eirG3?=
 =?us-ascii?Q?xybP4VpeothsP1qIErJlcDJo57quvtpMEtguRKSS8exnSf0J0ET3zFlifudU?=
 =?us-ascii?Q?XciF8A5atmEIFOvY5Mg1QwpFyoIN+IKV6Sdga5NED1kG9ZkprF8qZjUQAmB7?=
 =?us-ascii?Q?a7b1j3BUdOiG/QHOp0wBbvx/eLEGiXXSBinIbsWWgluVPXJji0OZaCZLa2tz?=
 =?us-ascii?Q?27oVmNZB3O9tlOMjUdZ4LVLrUBSqU0E3AUU73cRA302iCC7D/qm/X0Zrl9kX?=
 =?us-ascii?Q?nLmcAbfAfymZ1KgwU5kqnkAGHxmjQY0DehIT/lJspdRWB9XSZT4l+B6qUSji?=
 =?us-ascii?Q?9DiGhYpfPtjHcN+C0x69XMryoRNnOZnHLTQr4C0Qlo2JL7amEzwkO8PFvdoN?=
 =?us-ascii?Q?UoiTaMtL6zxf/lZ4Bdm00nc=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d011e714-d933-427d-a3c2-08ddd662f4c4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 10:04:26.1587 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dUpuawLHhty84B3/j5xA4WpyIqpHQW8Yfg/Z4MwsZZKDa3khpjHWl3M+lN9CCKHNezQwJ17YZb2QUHIf8f0b8qIbjivTUrzI+nqAOGudHHE59IK7NzJqR0cYi2V+2Saw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB7113
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

For successful reset staggering pulse operation, reset pulse
override bit is set. Port overcurrent bit 1, which in reality
reflects PIPE power present signal is set to avoid giving
false information of Vbus status to HPS controller.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 .../include/mach/system_manager_soc64.h       | 12 +++++++++
 arch/arm/mach-socfpga/system_manager_soc64.c  | 26 ++++++++++++++++++-
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
index c2ca0a50e35..8a7d47bee44 100644
--- a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
+++ b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
@@ -33,6 +33,7 @@ void populate_sysmgr_pinmux(void);
 #define SYSMGR_SOC64_ECC_INTMASK_CLR		0x98
 #define SYSMGR_SOC64_ECC_INTMASK_SERR		0x9C
 #define SYSMGR_SOC64_ECC_INTMASK_DERR		0xA0
+#define SYSMGR_SOC64_USB3_MISC_CTRL_REG0	0x1F0
 #define SYSMGR_SOC64_MPFE_CONFIG		0x228
 #define SYSMGR_SOC64_BOOT_SCRATCH_POR0		0x258
 #define SYSMGR_SOC64_BOOT_SCRATCH_POR1		0x25C
@@ -47,6 +48,17 @@ void populate_sysmgr_pinmux(void);
 #define ALT_SYSMGR_SCRATCH_REG_POR_0_DDR_PROGRESS_MASK	BIT(0)
 #define ALT_SYSMGR_SCRATCH_REG_POR_1_REVA_WORKAROUND_USER_MODE_MASK	BIT(0)
 #define ALT_SYSMGR_SCRATCH_REG_POR_1_REVA_WORKAROUND_MASK	BIT(1)
+
+/*
+ * Bits for SYSMGR_SOC64_USB3_MISC_CTRL_REG0
+ * Bits[14:13] Port Overcurrent
+ * Bit[12] Reset Pulse Override
+ */
+#define SYSMGR_SOC64_USB3_MISC_CTRL_REG0_PORT_OVR_CURR	GENMASK(14, 13)
+#define SYSMGR_SOC64_USB3_MISC_CTRL_REG0_RESET_PUL_OVR	BIT(12)
+#define SET_USB3_MISC_CTRL_REG0_PORT_RESET_PUL_OVR	1
+// BIT 1 actually reflects PIPE power present signal
+#define SET_USB3_MISC_CTRL_REG0_PORT_OVR_CURR_BIT_1	2
 #else
 #define SYSMGR_SOC64_NAND_AXUSER		0x5c
 #define SYSMGR_SOC64_DMA_L3MASTER		0x74
diff --git a/arch/arm/mach-socfpga/system_manager_soc64.c b/arch/arm/mach-socfpga/system_manager_soc64.c
index 4b42158be9d..88d538cdcda 100644
--- a/arch/arm/mach-socfpga/system_manager_soc64.c
+++ b/arch/arm/mach-socfpga/system_manager_soc64.c
@@ -1,16 +1,36 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2016-2021 Intel Corporation <www.intel.com>
- *
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
 
 #include <asm/arch/handoff_soc64.h>
 #include <asm/arch/system_manager.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
+#include <linux/bitfield.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
+#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
+/*
+ * Setting RESET_PULSE_OVERRIDE bit for successful reset staggering pulse
+ * generation and setting PORT_OVERCURRENT bit so that until we turn on the
+ * Vbus, it doesn't give false information about Vbus to the HPS controller.
+ */
+static void sysmgr_config_usb3(void)
+{
+	u32 reg_val = 0;
+
+	reg_val = readl(socfpga_get_sysmgr_addr() + SYSMGR_SOC64_USB3_MISC_CTRL_REG0);
+	reg_val |= FIELD_PREP(SYSMGR_SOC64_USB3_MISC_CTRL_REG0_RESET_PUL_OVR,
+				SET_USB3_MISC_CTRL_REG0_PORT_RESET_PUL_OVR);
+	reg_val |= FIELD_PREP(SYSMGR_SOC64_USB3_MISC_CTRL_REG0_PORT_OVR_CURR,
+				SET_USB3_MISC_CTRL_REG0_PORT_OVR_CURR_BIT_1);
+	writel(reg_val, socfpga_get_sysmgr_addr() + SYSMGR_SOC64_USB3_MISC_CTRL_REG0);
+}
+#endif
+
 /*
  * Configure all the pin muxes
  */
@@ -18,6 +38,10 @@ void sysmgr_pinmux_init(void)
 {
 	populate_sysmgr_pinmux();
 	populate_sysmgr_fpgaintf_module();
+
+#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
+	sysmgr_config_usb3();
+#endif
 }
 
 /*
-- 
2.35.3

