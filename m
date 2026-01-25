Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C5BDE63CBF
	for <u-boot@archiver.kernel.org>; Sun, 25 Jan 2026 20:24:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2756883D6C;
	Sun, 25 Jan 2026 21:24:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Rm/4WNod";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8A9E83DA6; Sun, 25 Jan 2026 21:24:05 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54BBC83D3D
 for <u-boot@lists.denx.de>; Sun, 25 Jan 2026 21:24:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vGvXGBJKb9Vv4xWMAfROsMNrTDz0eED5+JSbgNEP3cZn5QssZCb6+t214oHDG9pOQzV+p82/uE+ntuK9ufjElGmSFvhWgURF+V6OgdCQGAUP26fWAIvJqXnSm90JqjJ8zSN8HOvDIM+4THkNvuD/ixjp9fisdmy6KXITZPFV5l6WenMpKmcwpPLkk7krBzGianTMo+BpWXPyeN9aI9SOWFKWdKy/UP6Im9X06Qkrm8975a2YcP1mZhl6YNv3xiYvwzMTA22USM6YGMzxuC8onaDHjEL+bnbyCfIfgkUYENf7wKBSRAiYdvAKVXw1yrRQnDjU+1L3ozEvEy+U/YhLdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9wT31E1E8weBot8386KPuHBbNMwPAOnh/mW8Oe86iZk=;
 b=hCELJsRj9p/W0MbH7bS+KdK4Jo1WZ2gDVTCitpPc3w8Kf/jlPHLdSuSwmJaww/Q/GcVxgVWSSsPNNAEk7I3SzdiVUdX7UkgnNtqAVFDl6aB2e0xJOIpDhOT0ovtL7VDUy9q0OZDuSUa1eAs7dL/oiA8HqLSMYocjQz5sUe8VW0jiKE+dLxwjdVpWqmigApNnqD0M3AgjF4UuJGyff/s2EoPxUG9YZsNEQbEBqFLiBJB6wRZxuOfUU6zNnde9+H3AHRw+GneLMhj+hD4dj7LghPoP/5rb1N/W8ghCEmvZSOfjtpICHdecYXjrAElXPyvTGSiKucZ3bnIMUuqn7bYA8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wT31E1E8weBot8386KPuHBbNMwPAOnh/mW8Oe86iZk=;
 b=Rm/4WNodK9OLlHzeMINq6ckzKjCla54SXj4q2y2e1P1Mx+satywMXmsPzGwhyvQOcjW1sr2H3x29IJkCpNgvyqKJ+ik2BEwEyRVeeZYli5kBWlAGUlmSh3XKLEwF0NmdG/IkKt+czxiNxYYds2e5/tY8ymxRTnAdDoaznt+XHUyJutgf1NWvVJaehpnjWAOCy0tz+uczuvrVW2DIPusD/yjhVcsJfgTGPDvK+TZ7P1cpf6xkNAvn+hJFBF407IMzZ1dj/I7Jh/VJRnleVYYfYq+uDqlI0Xv0TazuUgiJkxbRB+q9o9i6Qtztjj6aUrMW1nZqdiMqAtBWagJqwOq+Ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by CO1PR03MB5794.namprd03.prod.outlook.com (2603:10b6:303:9d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Sun, 25 Jan
 2026 20:23:55 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%5]) with mapi id 15.20.9542.010; Sun, 25 Jan 2026
 20:23:55 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 marex@denx.de, tien.fong.chee@altera.com, tanmay.kathpalia@altera.com
Subject: [PATCH v1 2/3] arm: agilex5: Enable SD card UHS mode support
Date: Sun, 25 Jan 2026 12:23:28 -0800
Message-Id: <20260125202329.12738-3-tanmay.kathpalia@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7819e0c1-9b78-408f-b4fa-08de5c4fa9b0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?32sQCFSDZcLj5qos2aP9BGnpIT5B1D6nDg9OYKZMp7DfGbFxvJfTOdPCWGBP?=
 =?us-ascii?Q?qEQB8uPuNEe1GshCJv+avzZd8AoN6KVeQIGX+FfcoIG/A88GqImjCxn62HqD?=
 =?us-ascii?Q?uab3++2VD4BUQam9sgUmWe+08kRMF4095sZRV15BqqkBp+/YKGGkYvIov/10?=
 =?us-ascii?Q?1ZUeVAga/g5WXDGAc1sHsAP664tyzQDFsvoiXy/doaPsTMMn0ch1CDMT3QDH?=
 =?us-ascii?Q?5fdXsX9QrwCjNwNWOxZGKUDvaLZgkLG4la6Q2OFu4rMfxO4QGceCNR8t7Gkh?=
 =?us-ascii?Q?ThX2VXBuZ2268Z8RFpv6oSfrRTJYEwISPRbm3Yn6Scyk2ZPMNWpaGALiNang?=
 =?us-ascii?Q?hUII74IR/dyBxFWL/veJ5IhJV9+ZkVlYL3jcCTgh2XjOO09eV+k1VDQVSkes?=
 =?us-ascii?Q?z6Nzs/q/NeqrmMhKicZ6IH0WNhNqRo3b1wsz1iLi8z9/9D3VIZ6duJKnSdau?=
 =?us-ascii?Q?QaRjgJJVOy0dHayZCS0NdeXW3CtkWhPw2fGIRBLGHn5Wmsievuluf1lG9H/y?=
 =?us-ascii?Q?DzrkBnKYX9BgF2uAFQAYMPsI5MTmChvRrhZEbmC4PObSCvcDhuF/Elm2ENFv?=
 =?us-ascii?Q?3iHHLYsU0meU9u8svsUgBuyKjasXoKUG8mxsSOkUdKWJSldTjs1pn6dET+gZ?=
 =?us-ascii?Q?WF9ss8OXR82D7h2oGOAbP0ERZuGGoX7Z8T/C49DbxUY7qmC+NQ0w156ZU5dJ?=
 =?us-ascii?Q?DKSsZD28Px/Ho3B4yX9y2nCilU5DuYcunRNP1hexmP8PMmic5vQUtI2ostby?=
 =?us-ascii?Q?SBWgdyxIzAuQuD9WVIR/qCMNk6r1hM/aD65j+tr8/A4FqUC+kZKdn6+micMa?=
 =?us-ascii?Q?YGAzQW+Cg2cYDaADZK70+rP8hieoqWqTXula1P9ygOUyLpZnRhp3Z97nLBmN?=
 =?us-ascii?Q?OlVCA87PuApnVdFvBFXuJlMrRr2XjzMz2xXPzd6PCObYXh7jwuzXNBVfudaz?=
 =?us-ascii?Q?6mbKW7Vguk4uL2AAnQnYvX7mnp59rXYntmkLHYBdd9yQ4vh0qCH2T+aBtVZ5?=
 =?us-ascii?Q?Z+Ap4OZNTR3mfj9n0Zbb4a9Za7OECondDDfz/KhouTYY3ZC9+kqiDJ86tXJD?=
 =?us-ascii?Q?fYMaPqJQUyq7ijq3gFCVyxG7mOEHH4PsxEH0bO4NVS5aaSNKH1KROY1Krl9h?=
 =?us-ascii?Q?lUPdmRybssAwGB215JppJT9JigHIs6IOmTu5pklwQutGW3G4KqJ4UVstErT6?=
 =?us-ascii?Q?MztiBTU2DhAq5YgXaRjsP3hD1HsDDthyfzLgGfrUdeBlEL/kcTSYx6cjXtla?=
 =?us-ascii?Q?8CEryBAY57ga5iDinA6Jm5CHVazpf0ajqgUOwPNPUEd7sqAGsiF6ldEk5aCz?=
 =?us-ascii?Q?OYpoZDZY0uv1JeAQY7/B26i5NUIJucRmtkabCE1TUwWhuW2+ce8tbhJo2Dko?=
 =?us-ascii?Q?bXUlWWjkCbGWKuPqm0TGaMtSSkGVLJN5LUWEgrQKPbvfy0pKHHI1CYIuLr4O?=
 =?us-ascii?Q?ALlC+plzwCQ9GgHODYovyYoW9UM9KWS5tugU5b5QYI6w0sR9wUsoXQvcNSaL?=
 =?us-ascii?Q?DQHt98y3mr4Xjya7PMe+uW4SH9wk/3g7U2AOIepMllX2Y6xComyPwGuHk0UA?=
 =?us-ascii?Q?sjeOmMweBIjju0eRbA4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1Pr+wgxjKLHr4Iv3sTBEZtvZIyxezKsmUIaPdps6WCj1/TlkEk1H9feKzZrs?=
 =?us-ascii?Q?gwjXOA45c1pcVaD72dWnTtqMF9JXHthcop4dFz1AT6GSQpbv4YhcS93Kuh2C?=
 =?us-ascii?Q?duS211ki6WFBr1pYml0U3jm59qAOnPGcfsYm8jymi7PsGLJzdDRsslIMb80F?=
 =?us-ascii?Q?uCvAZ5NJEw34inEwBKEocLYCRlu0dDL70ATtZoJ4479cCg0OacbCToAqKyT3?=
 =?us-ascii?Q?fgtRPofj+oA+vf2kZM1YReAwkVOoWKmhd1fcyYytry/WdePdQ/R9bSz71EA0?=
 =?us-ascii?Q?FKp7qVW08ZxtQtOtIc50MSJKBTAb+pSzLPOC/zBmURh2itpuHbqRoAKgapVX?=
 =?us-ascii?Q?JxHAxThw2g/IZNWKKKrQQ8FuUbQPQlIL3ycYrtvzbbUzaGaAsm/Gl4ehLAmC?=
 =?us-ascii?Q?HPyt02YDSa60BgiDbgj42jWcJANfx1UqplQw0PrwYoCBJdFsZraW3XHGb3pz?=
 =?us-ascii?Q?LBUnpombwCxfuzPT2IRDKn1clZBHv6D4aVaA6VW3bRRvSISqbuR6/ne+DlUL?=
 =?us-ascii?Q?a61HLhjIypek3JSytWnWD94jjJXCyeyAt/ifFdhJch28nxqsSI8e/HHhT/UO?=
 =?us-ascii?Q?dKkrWw9d5GfBfQf6n8VFrmAhUCjiYLsq4ZL0RHCtpgKe1ujbAvzTdcw/I70v?=
 =?us-ascii?Q?lWIEVOe2J1kTsqgJK/R69g0l3EEpGxBGbiK9bmUEem6TT1tdFY1c5ScgeNI4?=
 =?us-ascii?Q?gi3qVH1oHAC+q8ZE7fcDTuSqdHXqRRRCB/ZOZhrHJcrEyVQIZrVmMu108zI0?=
 =?us-ascii?Q?mOoMMMNIstE2dpY2Zx3ljLSFYFkFizeDRFx51/syrKHquzPf2mFoW4g5AfCH?=
 =?us-ascii?Q?Omm4bvQo9BrmANCZoALQMecLJ9mGpfGGjLTBLmay6rvBRocwSKG5/D3cqeyF?=
 =?us-ascii?Q?EeJ5H+tQ/vzjWcjM6Ck6Z4FpGDLuA27EI1dZGqGSmxmRBt5LBi2Ut3hP63p6?=
 =?us-ascii?Q?j0q71tRfnTRhQYlFg219k96ybF9qxHYwF+lI+4U2itJGLfYBBTmzNnhVcnFe?=
 =?us-ascii?Q?PNWHSDIGiQaVaWqmRa0x6wism7Dje1NVkhnVekm2uamqLTkfpV5WyTnNnfro?=
 =?us-ascii?Q?68/qrY8DJ236ZyzJa8BYn9GF+DttVAY/aZwfg6j2pUd79+7575PqlUInizz4?=
 =?us-ascii?Q?ZQigfos1d6JQJ/+jIgH0uauzjumuHJG9lG9UqR3gtZ/MDTpT7JZ7yuN9osFS?=
 =?us-ascii?Q?o3EGSMtaSoQiaDqSL+zZKhOwN20tkpITOikz3i1BaalKYI/L1OCGMynaVD7Z?=
 =?us-ascii?Q?707KOSNNhv6/t7NbPInot9dN/p+5x4QDW5XLW7SMS8U5OjkRgiL1l077IgPb?=
 =?us-ascii?Q?qufMXMRLStGMz5IqN4F0plcuSe8v3EbCfG/Ct1acWliEvZ4RFKfQlopK9SUA?=
 =?us-ascii?Q?qQAidJRZN0TRWLhHVoIco/7Is1EZulP/8E0008aXDZz9VhuBHi/0psA6tSKR?=
 =?us-ascii?Q?Vum3dExxoOSSWqUtWzzhWFoLWcbB8wWjFEx6FLDeXmnuOEIoKB5fV2H9E4y5?=
 =?us-ascii?Q?jSwWn/vA1z2zKe8A2UG0pGCzOKlAaezFvPz+u3QSScMzg/1GTanRLZsfKiEY?=
 =?us-ascii?Q?ZEnwpnvarOnJk/+/O1o3rUs3jU7sWrgvYbzxK3dKTFoCO2sZmgWiLSrt8xDC?=
 =?us-ascii?Q?PrwAn/Zi2yUa7EOrPtnnTOJ5TrKsWBOCwB3aGooI0Tqj+WwjH5SGtIyuujxt?=
 =?us-ascii?Q?okD2++G6WyHsyrxwX5n8atNzGaWrwFn6Uuk2R7AJ0hMCtvV8iz9z371AuEf9?=
 =?us-ascii?Q?xyz2jAgWGK4MFmHgfIQPCzTTUh1fm+g=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7819e0c1-9b78-408f-b4fa-08de5c4fa9b0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2026 20:23:55.3798 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aUcjwQ9boaTcwc3VlnEvGkxlUl8MCemwqbzZs+Dyvec9cs60RASwDSbYeilrXHq3uXAHVDgSLg3KMaE3xdaOcr8W54B+6jQHoOZsAi5Ohhk=
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

Enable Ultra High Speed (UHS-I) mode support for SD cards on
Agilex5 SoC development kit.

Defconfig changes:
- Enable CONFIG_MMC_UHS_SUPPORT and CONFIG_SPL_MMC_UHS_SUPPORT

Device tree changes:
- Remove no-1-8-v to allow 1.8V signaling for UHS modes
- Add sd-uhs-sdr50 and sd-uhs-sdr104 capabilities
- Add sdhci-caps and sdhci-caps-mask for proper capability reporting
- Add PHY and controller timing configuration

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 .../arm/dts/socfpga_agilex5_socdk-u-boot.dtsi | 25 ++++++++++++++++++-
 configs/socfpga_agilex5_defconfig             |  2 ++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
index 417575fa0f0..48348261c60 100644
--- a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
@@ -110,12 +110,15 @@
 	status = "okay";
 
 	no-mmc;
-	no-1-8-v;
 	disable-wp;
 	cap-sd-highspeed;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
 	vmmc-supply = <&sd_emmc_power>;
 	vqmmc-supply = <&sd_io_1v8_reg>;
 	max-frequency = <200000000>;
+	sdhci-caps = <0x00000000 0x0000c800>;
+	sdhci-caps-mask = <0x00002000 0x0000ff00>;
 
 	/* SD card default speed (DS) and UHS-I SDR12 mode timing configuration */
 	cdns,phy-dqs-timing-delay-sd-ds = <0x00780000>;
@@ -130,6 +133,26 @@
 	cdns,ctrl-hrs16-slave-ctrl-sd-hs = <0x101>;
 	cdns,ctrl-hrs07-timing-delay-sd-hs = <0xA0001>;
 
+	/* SD card UHS-I SDR50 mode timing configuration */
+	cdns,phy-dqs-timing-delay-emmc-sdr = <0x780004>;
+	cdns,phy-gate-lpbk-ctrl-delay-emmc-sdr = <0x80a40040>;
+	cdns,phy-dll-slave-ctrl-emmc-sdr = <0x4000004>;
+	cdns,phy-dq-timing-delay-emmc-sdr = <0x38000001>;
+	cdns,ctrl-hrs09-timing-delay-emmc-sdr = <0xf1c1800c>;
+	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-sdr = <0x20000>;
+	cdns,ctrl-hrs16-slave-ctrl-emmc-sdr = <0x101>;
+	cdns,ctrl-hrs07-timing-delay-emmc-sdr = <0x90005>;
+
+	/* SD card UHS-I SDR104 mode timing configuration */
+	cdns,phy-dq-timing-delay-emmc-hs200 = <0x11000001>;
+	cdns,phy-dqs-timing-delay-emmc-hs200 = <0x780004>;
+	cdns,phy-dll-slave-ctrl-emmc-hs200 = <0x4d4d00>;
+	cdns,phy-gate-lpbk-ctrl-delay-emmc-hs200 = <0x81a40040>;
+	cdns,ctrl-hrs09-timing-delay-emmc-hs200 = <0xf1c18000>;
+	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-hs200 = <0x90000>;
+	cdns,ctrl-hrs16-slave-ctrl-emmc-hs200 = <0x101>;
+	cdns,ctrl-hrs07-timing-delay-emmc-hs200 = <0xa0001>;
+
 	bootph-all;
 };
 
diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
index 5fbc49b2307..8a3f9563af2 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -87,6 +87,8 @@ CONFIG_DW_I3C_MASTER=y
 CONFIG_MISC=y
 CONFIG_MMC_IO_VOLTAGE=y
 CONFIG_SPL_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_SPL_MMC_UHS_SUPPORT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_SPL_MMC_SDHCI_ADMA=y
-- 
2.43.7

