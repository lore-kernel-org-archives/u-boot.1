Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD80E63CBF
	for <u-boot@archiver.kernel.org>; Sun, 25 Jan 2026 20:24:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6663583DA6;
	Sun, 25 Jan 2026 21:24:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="iPT8uBTO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1551483D3D; Sun, 25 Jan 2026 21:24:06 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBF3683D7A
 for <u-boot@lists.denx.de>; Sun, 25 Jan 2026 21:24:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XiBKSgBGlx9mV/7fzfvweyZs40+T1M+DMEsZhlGlkoEMbdMZE87k5eCpOGZci6zPsWsSaRb5cDDMZvg5C0PhONr+a7s2+2U+ydVC260NooIihMB4BxOCYFL+14DNVCZzESYhr9By4zhPMGIcHexkkE170nHZhaiRyi+AFDM0OXwLJztN8NTZDDKeryZjJ9PdMKJ/XS7mn8OYCkZVpKqtPWTlio0aLXuMEwCIBle5VsmK6VHgsbEMFpslgyV03CQWcVVw6r+XoM+rRwKz/BRfTj9ibmZ+/7fi6djX/zingdCtiqRWUOdp0b+OI1jF698bcMYW57NYINL4ibTuugtUjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXPs4vvHLg7kZJeWnLqMa9Agd1qEqC0BP0AiINsscYE=;
 b=qCdx4KsjHDymGNyG9jqDxCrfQlw6imkhQoYpzUPfTQljjHfR1He2GIF/iTGFYH2pd4J1H+fKGwRl1W7R+S4zMI3c2HFyDPsgO0DGsttsrooIKCdaAyup3/AmuN4D4Ea06wSGA1homPIzUGHMrxR37KQOFabH/1LK8PGhKiFgAR/Sr+WvhVf7hWVZSYDdvpv0hBrE9Bn4ONEAiG0nuuPW7bA1L4rbqv5O9ln5eFFaYbQAh2KHNHb+/qG7DFNGiJ/rKinILz+j0zyllBTP7/ysiGq5insXgCOxWhyiI/wsg6mm+lES2QHOYXP3BN9k9KAMAKyDRTYS5sgTBRooXxiqZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXPs4vvHLg7kZJeWnLqMa9Agd1qEqC0BP0AiINsscYE=;
 b=iPT8uBTO82QYa2Zyv9MqLWojz6zH+aYXrP3xpDSVyxeXgkxOh6n9QfqRofKUbQAFj76fVtk82sdsAm5TwMlDQnQ0TAx0vl3iSJkKQICSISU8N0da4/sFoujZmDGU3sX0VyZ/XUJAhC5KmYC49A5sUmuDuaS5thDd55jVYvnTrF/nP+D44b0O5qdtk/JagJqrCTDlEygoJrT4uuIhnfD3DTAw12H4dIsQS+cvhP855TE3MwJIUoFEwVh1O/hcavQJ/7bhisYPMYY0lIakrmf3I1ZQ1Sc5lIusA9zf4VbsB8X9QZi2VRvnoBn/iNXukiWcop/ioQAt+mxgIQhOCqyT1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by CO1PR03MB5794.namprd03.prod.outlook.com (2603:10b6:303:9d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Sun, 25 Jan
 2026 20:23:56 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%5]) with mapi id 15.20.9542.010; Sun, 25 Jan 2026
 20:23:56 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 marex@denx.de, tien.fong.chee@altera.com, tanmay.kathpalia@altera.com
Subject: [PATCH v1 3/3] arm: agilex5: Enable eMMC HS200 and HS400 mode support
Date: Sun, 25 Jan 2026 12:23:29 -0800
Message-Id: <20260125202329.12738-4-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20260125202329.12738-1-tanmay.kathpalia@altera.com>
References: <20260125202329.12738-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::18) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|CO1PR03MB5794:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eb4e296-bdeb-426f-e7f3-08de5c4faa24
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|366016|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?My4MH24hz7EQY+FDVEuwJqy5Qs2EGSKc9VdGl9N2ATFuVIkXX978cCGPJR+U?=
 =?us-ascii?Q?dA/318h11Fw5uR6qqGZAhWwvFkOl2EO2jdmDALC0xrrYuxZ5P6rCbQbyufWo?=
 =?us-ascii?Q?7QNtxGmtkyeX3ZoLB2hoxzkYFnEdJDr0xdJurosL8AZxMvoWk13C+Qp/Pwhz?=
 =?us-ascii?Q?987WJRv3OpwkcdCjAx9/Ns3I9lufcEkTqJkSyJ3SKgZ2+2dLp1wSddvJYY8J?=
 =?us-ascii?Q?tkOfUmwykWBvd3ZZt1M++lrS8X+7I48CFC9crDvwoOHf+eZ1z+W8fBRJI8VI?=
 =?us-ascii?Q?jvYJx/hNGBnc72dAJpon+UcI2R40LA76mSgY6gVP/XrYWJcFChbJj/KBAbGk?=
 =?us-ascii?Q?Ye+TayinIC1rpGavbAtrKmNW9dsuAjZ7+IyyJv2o0EVMv9NnnBTlDFTl5XFB?=
 =?us-ascii?Q?zh6DUEHksG4T/4lByocp7L059Y3PFmfbM/lAX82WlnMqttye5nFbg+/XfrEm?=
 =?us-ascii?Q?9YvGhNMh6MwyHZXD1iXTvujT1kVZUOqjfZ+I55SUgjM4bBYfGDwEqjVhwNMP?=
 =?us-ascii?Q?YzFIk7aq0rsphdfDoFMPr7+eCf0vw/S25c6lQ/ToWsavVDUEhspaNbmvYr1G?=
 =?us-ascii?Q?AIqzDdJHJ9ifqN7LojNXphyR9K7Ss7kaCMIgjRakuHC6hDs7ZRblTmZMcmDR?=
 =?us-ascii?Q?sV6NlWJg4aq4huNHx2QaVQuRFXt9OKePw6VafAo7g5tkzVGOn1hzWAbityeE?=
 =?us-ascii?Q?iH1uJU6Pr4Rb5heohFwdgYARJn/lpXqyLTI5dFnFr4n7R2DXK1+KxHSPvATC?=
 =?us-ascii?Q?xig4wQeIUn4yOyjcaODkA90S6dTKVMI2vZYwHE3dvA9flsJhgxe58NtNNq6u?=
 =?us-ascii?Q?dPNRE619PQnxZhYVx88gDtQ1955JwPncT+YOyvVGf8dYHGNsvjoFVBCLJ4Yp?=
 =?us-ascii?Q?Hs9VLffpbeO6x0SaqaUoXYExZ2XNhPd3tuaMQL2eddgMuumeSdnqtT2J/d0i?=
 =?us-ascii?Q?2LXpzJlrVMualQbRsUi7KH2J5vLUrd9N13GzNiXLaFLvPo+5QdgtenZBLpvU?=
 =?us-ascii?Q?HiGDvrQ10eTyaAL6zxtpxo7cCwfiO1UaAYZYXvn7UhxhiBxVcwL1S06LPdWj?=
 =?us-ascii?Q?N3FbH+XLvCtzVCCaIC9FEcVmZiziAmYqxvh9Bb4YbdCSvdOaQ51K6lu0pMVO?=
 =?us-ascii?Q?0a4Hsjbz4E/rkGZZLzhwcHse2fyty70obJCjvyVawRDT/HKoF4xc9BOkItvL?=
 =?us-ascii?Q?VXP3O7+SA32LXdp9tnm6NvB3SNB4WjUWYI3B/tw7KWwW8RuS+fyUqXY/y93E?=
 =?us-ascii?Q?ySDj/UB2gLBn02/hz4mnoBNKNE8Yb2GZ30I+3H5WmK4c5YKjXcjK/6z5MSTc?=
 =?us-ascii?Q?KAMqZyGGP5QJcQ3pE0qnEGhGJUBW80/OLQ2Z70pwayMzkEVRxHs+qMaMKAHt?=
 =?us-ascii?Q?FOddM1lVjsyOCoK1iSM7vn9/XmiDW36OVnT8sZicC7MLFXnRzQkC1okoeIXB?=
 =?us-ascii?Q?D+/j7vfu2dRDlItWYZ6QONp7Fp6IJt+2mxG1OTnb1uYHSmS/SzD575w0Oboa?=
 =?us-ascii?Q?59fp0aw8rAC3cGpQFq3tiSY+l/y7rt8wOQhN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kVAjKEvrehX+4KjhkY5gkLnTZYrZcjYn1wWcZytLeBlwbBiMA0BfTSKxbtfn?=
 =?us-ascii?Q?udL+NSKnkFPZQYjB0hMObMys6YLv4Je+OSgMusWB/YS3lhKFrfjuSbaeEXMA?=
 =?us-ascii?Q?PVtQygkKq1kFjkn+nn3Ko31VKSzbmCzIFn2kgMoaYUrqnn/lF9bsza2SI4S1?=
 =?us-ascii?Q?+ob5hUTWLwkMCVMU2pWletI2ttnep3MqcTdAVf4drg1zAl6Rb9FoJ9/0YCHD?=
 =?us-ascii?Q?p6I5fjwe5JB5Bu0LNTMSpdgl/VLLxLaoitVDIgbKHendxXxg/+cga2FUPuNi?=
 =?us-ascii?Q?adRQ0pr9XDjhm7dPpJC1HBOU1cridkHWGkF3gO5yPi+6oU1ryk8sWhvKt2vg?=
 =?us-ascii?Q?RV62FMgjmkd6NAY8bf8ElFh1sG7CjKzgoLPNM2gRpGZ+xXZgEZgP7i2Nkn+k?=
 =?us-ascii?Q?gF25qpcU0Qyl26NwGuNR/f4D68UqggHPQSqiIL/9iKhZIfDcrEWnbGIe7hHG?=
 =?us-ascii?Q?qhkAJuOtpr9jHTPWuZGvX5NUNKPCDT/+K/7+ODipZkqMYo8n1L/rODrtYBJi?=
 =?us-ascii?Q?NKKsph7UFYRC1MmJMYdfHjlMYYUEWIaCQn1fr3CLHCzXGEOHYmfMGJjdXSkW?=
 =?us-ascii?Q?uITRTQGbCDDPZ5gRtREAtgIsCNU6j0ymbnh/RU0TGA2FeMyO5gt1/1IgpLkD?=
 =?us-ascii?Q?1VzgjmgZ/xyZnQ9ZTwdD/vqqc/dHLSi8MprjQuhvWVYAECK6Xq4CBl5HpP7B?=
 =?us-ascii?Q?Q5az6vn1+BUh6+379IykmriEQif8NEpjyjHUweWOA88LYYc6Si+i7ljH32Ca?=
 =?us-ascii?Q?xVx8QRWfjiUSeUBDxQVM6c+cvfR8p4XNaKPvXxh02Q+wl4V2EQAorqu2sgxR?=
 =?us-ascii?Q?KsNitNPPr0mDVnwp3w/Ot0D5GuQWzfaaxBMBwcYol4RL/fI3lqv7Nw/zXGUB?=
 =?us-ascii?Q?B3Xe1WYMmp/vlYKVtE7CfatIEizjp8rL9LVFSX0uf8Gd+xsd5ogWEkNq1UxB?=
 =?us-ascii?Q?cPVOkEyeWXgT3fc5lkMuow2mnC1ElvQ7br3gE8OiTGEaS9COWhPbgZ9SQNRN?=
 =?us-ascii?Q?4NEhQFEUigrLNIFBhzOF/+yX2m9s05VaQh/2SvBXlsYM6E+xWJQZU9IpTZF6?=
 =?us-ascii?Q?XsadIjL7NdIc+nWhOdhtc1N6c/VcFGptVGHoADPWJWiO/0/K6P+GmvWYRn1i?=
 =?us-ascii?Q?fx6n5CQ83CvFXE5RHgTbNLohqHHB312B8PsMUvOa3ohZ2Fs8DBm1//U4LuqV?=
 =?us-ascii?Q?m5ybkFux+b1ndGPcCBxzwioQ1aoTO5IoaizBQR4gr5RULJUMCGFJVzzk5aVl?=
 =?us-ascii?Q?rjD6vJnXY+iupWDPkBobzrSuDpSrkoMEZiCAonugGMVuJIy8ScTiz0B0CL5w?=
 =?us-ascii?Q?kcflhvsNDZ0rIhu/e5/dlprXJcVNkFvH1USD4HcL6O3wSiEfwYCAKVVFFfTW?=
 =?us-ascii?Q?GnUpecAB6fV7N0ULYE6D8tDSU2d2Xrx4tGhB6S+Nbi7C0gSbt6lELglUUE8y?=
 =?us-ascii?Q?3303N4bhwGMqlGoX9zoD3BAxqnbBZCj/8QZ3wQqnwMEC6/xdhj1Y+0sz3WLj?=
 =?us-ascii?Q?WUD/MQ7qVmvAB4xoLqoOhLJY8PXTlKspmLjFqSxnKhj1y/MwzboswDO/mdj4?=
 =?us-ascii?Q?wfjiN/50TwA/5dIxTN7oCSa2PQNhs+K2YFIG63Ag8x2wKwycQ6O56xrYhvr3?=
 =?us-ascii?Q?N77t7SQnCatNGmQrtFRbt/SmYY/9QZEN2csDMw5wDUIRRC6PDhybIwvJzxhx?=
 =?us-ascii?Q?ynJa/siTxSkQPZAXRhIA309/b7TMc0DoGJLDwzs91J5RuCc9OmCU6IBDfRuP?=
 =?us-ascii?Q?iaZpoWRvfTpiOTN+pghb0Z3n/80Etuk=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb4e296-bdeb-426f-e7f3-08de5c4faa24
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2026 20:23:56.3659 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2gEcd5gWkDD02to+7H2tX7lfaXbKQDbbfUDik02RmcOYjz9OYzxlrzmJ7KW8XkCrK4iwGtqUyQC+AMK0mTUACXGCUuSO5l4oetMPPCoqezA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5794
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

Enable high-speed eMMC modes on Agilex5 SoC development kit for
improved storage performance.

Defconfig changes:
- Enable CONFIG_MMC_HS400_SUPPORT and CONFIG_SPL_MMC_HS400_SUPPORT

Device tree changes:
- Add mmc-hs200-1_8v and mmc-hs400-1_8v capabilities
- Add sdhci-caps-mask to mask SDHCI_CLOCK_V3_BASE_MASK bits
- Add sdhci-caps to set 200MHz base clock and 8-bit bus width
- Add PHY and controller timing configuration for HS200 mode
- Add PHY and controller timing configuration for HS400 mode

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 arch/arm/dts/socfpga_agilex5_socdk_emmc.dts | 28 ++++++++++++++++++++-
 configs/socfpga_agilex5_emmc_defconfig      |  2 ++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts b/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
index f6848c373cd..49b4a85783c 100644
--- a/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
+++ b/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier:     GPL-2.0
 /*
- * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ * Copyright (C) 2025-2026 Altera Corporation <www.altera.com>
  */
 
 #include "socfpga_agilex5_socdk.dts"
@@ -25,11 +25,15 @@
 	disable-wp;
 	non-removable;
 	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
 
 	bus-width = <8>;
 	vmmc-supply = <&sd_emmc_power>;
 	vqmmc-supply = <&emmc_io_1v8_reg>;
 	max-frequency = <200000000>;
+	sdhci-caps = <0x00000000 0x0004c800>;	/* SDHCI_CAN_DO_8BIT */
+	sdhci-caps-mask = <0x00000000 0x0000ff00>;
 
 	/* eMMC legacy mode timing configuration */
 	cdns,phy-dqs-timing-delay-sd-ds = <0x00780000>;
@@ -46,4 +50,26 @@
 	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-sdr = <0x30000>;
 	cdns,ctrl-hrs16-slave-ctrl-emmc-sdr = <0x101>;
 	cdns,ctrl-hrs07-timing-delay-emmc-sdr = <0xA0001>;
+
+	/* eMMC HS200 mode timing configuration */
+	cdns,phy-dq-timing-delay-emmc-hs200 = <0x10000001>;
+	cdns,phy-dqs-timing-delay-emmc-hs200 = <0x780004>;
+	cdns,phy-dll-slave-ctrl-emmc-hs200 = <0x4d4d00>;
+	cdns,phy-gate-lpbk-ctrl-delay-emmc-hs200 = <0x81a40040>;
+	cdns,phy-dll-master-ctrl-emmc-hs200 = <0x4>;
+	cdns,ctrl-hrs09-timing-delay-emmc-hs200 = <0xf1c18000>;
+	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-hs200 = <0x90000>;
+	cdns,ctrl-hrs16-slave-ctrl-emmc-hs200 = <0x101>;
+	cdns,ctrl-hrs07-timing-delay-emmc-hs200 = <0xa0001>;
+
+	/* eMMC HS400 mode timing configuration */
+	cdns,phy-dq-timing-delay-emmc-hs400 = <0x10000001>;
+	cdns,phy-dqs-timing-delay-emmc-hs400 = <0x680004>;
+	cdns,phy-dll-slave-ctrl-emmc-hs400 = <0x4d4b40>;
+	cdns,phy-gate-lpbk-ctrl-delay-emmc-hs400 = <0x81a40040>;
+	cdns,phy-dll-master-ctrl-emmc-hs400 = <0x4>;
+	cdns,ctrl-hrs09-timing-delay-emmc-hs400 = <0xf1c18000>;
+	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-hs400 = <0x80000>;
+	cdns,ctrl-hrs16-slave-ctrl-emmc-hs400 = <0x11000001>;
+	cdns,ctrl-hrs07-timing-delay-emmc-hs400 = <0x90001>;
 };
diff --git a/configs/socfpga_agilex5_emmc_defconfig b/configs/socfpga_agilex5_emmc_defconfig
index 9254ab92e0c..d2d359cd1d4 100644
--- a/configs/socfpga_agilex5_emmc_defconfig
+++ b/configs/socfpga_agilex5_emmc_defconfig
@@ -4,3 +4,5 @@ CONFIG_DEFAULT_DEVICE_TREE="socfpga_agilex5_socdk_emmc"
 # CONFIG_SPL_DM_REGULATOR_GPIO is not set
 # CONFIG_DM_REGULATOR_GPIO is not set
 # CONFIG_SPL_DWAPB_GPIO is not set
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_SPL_MMC_HS400_SUPPORT=y
\ No newline at end of file
-- 
2.43.7

