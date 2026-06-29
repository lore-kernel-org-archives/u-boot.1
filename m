Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBACEC43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 06:16:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE35F841F2;
	Mon, 29 Jun 2026 08:16:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="JyYIsY4u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B753B843B6; Mon, 29 Jun 2026 08:16:29 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0582A84105
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 08:16:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r/i6dgorCbMxN63YXSqGO+UpRTOJ2E6Rjj4K/5Ec/Pac6EpIKBq8usruvcrFD9tBkoTMZiz/kzrXxhUtZ9GmhYThw2HUubS0BaZHSATItZ7nXfhCSqWkT3ddbonpH6mYwpXt54Dd+pFrN/alMUvwUgxJJae7EfNX4afOevUDjPVozmpmdIg/AYk3Dh4R+dyEtj4RDImm9QryivYl1nwmTLitYmc4lJiX4FwjYDetKmdDV/7uGgEjl8b/GLIENJqDY27eye6WHeqTy5l7X7NiBhEzw07lq069jhCSgn8ZOlrjkbE+qBficl6by7/iXAZEvf3MqpbhfIjY5dWjH5vLcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gy+HEUn0kP2CG/wgn9RsdT08KtLj1GaD1Bq40ijtAw=;
 b=FoLNQ1ZEKkwMtzmoJhHRoYJydigSCyt0347qUQFCWQNnrEyUQzfrYRlF8buksgVOebRhKgiyPCMy6ipYoWssi+k4W9RHT3Q3WnOFoIBWR095Te2VD2703uiqvB92kboYyDhBbLJYUmGB3KlGL10WvyeJTMsRXWyAD0B+XVEAV70E5PbMlJ4JVYTv35l4HXIbn4kBv/Z/d/Jz9LAZLs6LHRYUbZiU3rU0lKsfa+nGIEx3ou1BsR+IezZuenjh5tk4cBNsDWo9p7BoCAoU6z8LUh9gq+3GpjVnOPpPOqWXXZ1E4KSrh6Te6r0MNTWlVIv8IIPpc323iq/+RIh4PvuO6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gy+HEUn0kP2CG/wgn9RsdT08KtLj1GaD1Bq40ijtAw=;
 b=JyYIsY4uLIjjDPZ+y1SUa+cNChZtXRl9oqCST3cwIRKBC8/jSJ+RudfbWsh2DEjW0uWIWiFPYPcvQzJ6lXTzdHMKd5na8kGMqVVmT2qIMr6/guX/1HaX1vOqMuopz7hyYxyNebhcqzlGLegE56A8G3BpivgW8D8jWZ5tE8pRfqovBFioBcIgCsVL0IUBxd3P4QTftQ5GS1GJcNUc3MYjaKyFTAFB8LPYsTMyndDnFJus/CdzyTN5I148HuXx/OCSPGk6t2krL43zE5EDP8m93b7iBhWQn4fBqRlEepK2n80dLg4bEFkauv2OreCeuMZXTBAvzhEpVbcOSg4LFMTaxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by BLAPR03MB5618.namprd03.prod.outlook.com (2603:10b6:208:294::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 06:16:23 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 06:16:23 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, trini@konsulko.com, marex@denx.de,
 Jaehoon Chung <jh80.chung@samsung.com>, Tze Yee Ng <tze.yee.ng@altera.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Subject: [PATCH v2] Revert "mmc: sdhci-cadence: trigger tuning for SD HS mode
 on SD6HC (v6) PHY"
Date: Sun, 28 Jun 2026 23:16:15 -0700
Message-ID: <20260629061619.4268-1-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY1P220CA0041.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::13) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|BLAPR03MB5618:EE_
X-MS-Office365-Filtering-Correlation-Id: 409e15c6-f15e-4716-e582-08ded5a5f1c5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|55112099003|11063799006|56012099006|10063799003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 9mhu0K4x0h8ehmLmf6JW1ENLXGgLU9i3CHpaG/8HslNA/0g5ntCQBu0is3WLF+HwHH325fOqt3JtxLI0wJuZXnrUn7AuTOzsQl38EL3jKnvDfSiqWF26z3emRvNzNoNcExda+INE1v1VgmVh4DUnFUxze/X8fbBo3QpJGk9ESTc79jeEyMJ+Wykezi1XckSRS1ljkBhdb8bXkG02wHFb8ynpKZFDt+l7OzrnM1RIVRR++2F6BBN4sNhQ5t0XSiF8vSU+7TmmrFDyJs5RYVBKSNbkrFoven46m9RW2fvOhYJh/XYruX58oRVSZT1PUgULkng07E5wS+cUooiQwhMK+pizXeb3GFinXKd9HfzV/RkJWtlEjosxL/j5gU91O3W2s+hoTvqcpPPlt4jvNYesHCV83zHkDXdw2KCsGYhM6ZQUcCAhslYU6rmNRzfPEM4xikWxsGjhKEGWaIj86iKU8rL+OFSBNKPu3pXBxPl52QeAZQnF0XXPGadOBnnf7GTO85jaVJP1beFz8yE+xTlO0OVxKxHMnX3qsUI60SluiAegDufyup0WURrRNnBRsu0RQgPcp5JlVob5XsVuJLlx+SUuZo73dUHmi+C1Vgy2DzYsjajv7iH+pimfE/qm2MfxcHmG6av3IAmmJez/PGlnqZglSavQPIIkxg6bEqM3wJU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(55112099003)(11063799006)(56012099006)(10063799003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmQ0T0ZaL3hTUnpHc0NrVXM0ejdldWNxM3o5TENBRDl6WW1SQ1dsY001aUIx?=
 =?utf-8?B?ajF1cjZINlNGelZRa1NRZUk5UWhCVmttSlJhSUJXS210a1ZGTUw2TkFRaW4v?=
 =?utf-8?B?M1JySlp6dzViRjZseVJwS1VlRlFUVUpjT1FzOUZDT3U5UVpIMmRSZ2RlTzJV?=
 =?utf-8?B?ODlYMUFkSjF1c3hMVll6K1BSSDNhZ3BsZGhpc2Z0bFZPcWZ6NEUrS0k2UlBE?=
 =?utf-8?B?SENGOGhKYnJlWDI4OGkveGMzSjJ0QytQOStlTWJ4TmNCbHBpNE9UWGNXS0Fp?=
 =?utf-8?B?NGVWTU5WTlRucWV6bDNEeVA5Q050TFlFK0g3dTZ0Ukx5ZHlrV0c0dEVBQVRj?=
 =?utf-8?B?QkZCMU9FQ1ZBRzVjNEpBSXdBOUppYzJlNzdub0JoaEhseXZ1Z1NZV3BsNmxN?=
 =?utf-8?B?TzI1a1U4ZUl1N2xuekxXT01CdHVsYTVXK1hSbXlYUzVXS2dLeXNlUCs3Nytw?=
 =?utf-8?B?LzBBVm51eVFrVS8rUzBHODRnQlFlL2NCN0pJR3o3WHFhRmhsaHdTbTdVUG9C?=
 =?utf-8?B?dWl5NlFCNkxkQXlNSGJuUUJ3cURmTW53cG8xTlBHWDBoWlo0RXgyZW1tR0kx?=
 =?utf-8?B?Tk1vZGpCY0E0WjM4SHNyaFFseVNJQ2VSc3BwRkhJU1NZaC81YWpQZDdialA0?=
 =?utf-8?B?M1hlcnU1aHQ0MXE0OFVuME1zQ3ZsbVlaSXlRdzlONzF1Tk45dW85VE45c3d1?=
 =?utf-8?B?eHRTZVFrMkR2eHFieWpOdUJtN2hNTUxCbVRWQ1J0OHRIWFBTY2lma0NFS00y?=
 =?utf-8?B?OWZkYm9mNUprZ3Q5TmJacmVheWVTRUNLbk1OZExCdGg5V0NrWjlCcklqMUlp?=
 =?utf-8?B?SmRDZ09qNDhUY0NCdS9rTkJIK2dJZWtKV2t4VnpQYlZaWXRaODM4N3lYOEpx?=
 =?utf-8?B?aVNhYU8yYm85bmpLRDROTmVKUTFnSUx0NkwxZm42dFFGQ0F6d2FVMFJ5OWwx?=
 =?utf-8?B?MEp3V3JhNXN3U29GVmFhMldWYWlZUFkxRjdpRjNZMDIyZUQwQnF6WXRCSDdn?=
 =?utf-8?B?LzErRm94TUxKNFpyNkIwbkQvcnNPaW9IZWZqT1V1S0RCR0diNjIvcUxybWxk?=
 =?utf-8?B?c1k4N1cwaVUzc1hZVlR4aUQ0Y2hieFc4MExpUzVNTDZwdHRhZVdGNWxXT0RO?=
 =?utf-8?B?eGZ1UTN2MW45WE1zS1NhdGhMR3ltQ25lTkxTT2p6aHFzV2dPUkZZTzZUdlpH?=
 =?utf-8?B?dGZzQ0FJcHpXV3ZselEzcWRWaTdscjh6ekp2SjU0TUpXNWgzNnMyNW5tRjBk?=
 =?utf-8?B?ZWhwSzBGc3AyRW5wVkkwdWx5Q2J2UlRtNEtJSUhEOVBIMkttRlF3QUZEaFNE?=
 =?utf-8?B?RXl0akhKWnQ4elNJVzZ4dG9mZUN6M05lQU5rc2VUMVVuYU0xaVBsVUxJQ1Nz?=
 =?utf-8?B?NTJnaVRjRVBvd0toSElrTjRjb3NNZVFlbnI0QStRTVFsSWliVDdXY2V3NXcx?=
 =?utf-8?B?ei9sVjU5Q2wwTjVUV0owampycXJpNjZTN0I1b08zaG4zaUFOM2wyRDhNaVoz?=
 =?utf-8?B?MVFwL1lORFVia1lIVjlBbzR5cGZvREZma1RPUTQrWTd1ejk5MEdkT2YwR1ZF?=
 =?utf-8?B?OGJFN01SNHJMdk9oV2dBVk9rMVdmRURkTDZyMU9kVHR6bm9CR2wvcnVZcjJi?=
 =?utf-8?B?OHVQOGFnRmhiVjQ2K0NZenpkZnVrQU11K2FmZkhNM3hsSVVGQVErS0hRTHha?=
 =?utf-8?B?ZFVnWVZjQngzVGNFa1NNb1RJeXdFT0xhTW1LNlhwMHhOVGI4dFJad1RpUXBq?=
 =?utf-8?B?cnVsZlYvdUhQTEI1UEl6VSthOHd5TDA1eEp6SkdYcTZRNUhKdHpVYmxHNEtE?=
 =?utf-8?B?U3NiV3U1blF0bnYxZU9zYUF2Y2FBdk9XZlBPb1M2YWJManRuTkc1ZHBPM3Zr?=
 =?utf-8?B?YUJIM2liUE14ZElYd1JDeFFTV0tzaHB4QUMyU3ZZb3E0VkFBdjhjcGRUZC9h?=
 =?utf-8?B?VHdKRm04YTRPVXArQWtmcnEvMTdBSXYwN29lc2tYaWRSb0lybGxSazhWSnZm?=
 =?utf-8?B?bkJscmxUaXdLT1VYV1pvSVZSL09sd05JdnhFRWhweklsZWY4VGdYVXgyRGVZ?=
 =?utf-8?B?TEVDMU0raUpiTUtESDJld1NBYW9WZlBKNnBrbjVmdG1iRzFJV0NnN0RXY0xw?=
 =?utf-8?B?UENoVlNXdkZpNmNZb3U1NWwyekNmbjdTbmJ0UHJ6UEt5MzRleUo4dTEvVTlC?=
 =?utf-8?B?eXlRYXpSdXJNWEdqcXFHK0hZdk11Y3laZWpjY0pKRExOM2JERHFNbUlYK1lR?=
 =?utf-8?B?N2puN1o2dVZTcmhTN2pzcGxBdGw5Rk5yS0RlOUZWeVFQS05ka2FXdHpyMnIz?=
 =?utf-8?B?WVFyNm1LQkU1eHkrbGdMSzVsazNqUkpkNE9RUXp4ZC9TbFgrQ0gyY2dWRlZ4?=
 =?utf-8?Q?negd2TfPKlIM2xAo=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 409e15c6-f15e-4716-e582-08ded5a5f1c5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 06:16:23.6945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LRlh6p14f3rSxvRyRn70Ue0xWDNOMqlLoNeZtH+GEmaiAnFtVn1ftCArpvdzrNaoajyVVvBXK41c/jVWn8U3TBduZdkXedyidHH0/sIGWuM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5618
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

This reverts commit b42c67188c14 ("mmc: sdhci-cadence: trigger tuning
for SD HS mode on SD6HC (v6) PHY").

The reverted patch introduced several issues:

1. Non-standard tuning trigger: The SD Physical Layer Specification
   only mandates execute_tuning for SDR50 and SDR104 UHS-I modes.
   Triggering tuning for SD High Speed mode is outside the spec and
   is handled via a non-standard set_ios_post callback rather than
   through the established SDHCI framework tuning path.

2. Non-standard device tree property: The patch introduced a new
   "cdns,sd-hs-tuning" DT property to opt into SD HS tuning. This
   is not aligned with existing DT bindings and bypasses the standard
   MMC capability negotiation mechanism.

3. Incorrect tunable mode allowlist: The sdhci_cdns6_mode_is_tuned()
   function includes SD_HS, UHS_SDR50, and MMC_HS_400_ES as tunable
   modes. According to the Cadence SD6HC IP User Guide (section 7.5.2,
   Figure 18), tuning is only required for UHS-I SDR104 (SD) and
   HS200 (eMMC). SD High Speed, UHS-I SDR50, and DDR50 only require
   a PHY settings update from the pre-calculation script, not the
   tuning procedure. HS400 transitions through HS200 and reuses its
   tuned DLL value with a partial settings update. HS400ES only
   requires a plain settings update from the calculation script with
   no dependency on HS200 tuning.

4. Tuned state management outside the framework: The patch manually
   tracks tuned DLL state (tuned_mode, tuned_dll_slave_ctrl) and
   restores it across PHY reconfigurations. This duplicates
   responsibility that belongs in the core MMC tuning framework and
   adds unnecessary complexity to the driver.

Reverting to realign the driver with the IP documentation and the SD
Physical Layer Specification.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 drivers/mmc/sdhci-cadence.c  | 108 +----------------------------------
 drivers/mmc/sdhci-cadence.h  |   5 --
 drivers/mmc/sdhci-cadence6.c |  45 +--------------
 3 files changed, 2 insertions(+), 156 deletions(-)

diff --git a/drivers/mmc/sdhci-cadence.c b/drivers/mmc/sdhci-cadence.c
index a76f9e8d6bd..5bbc18dfa51 100644
--- a/drivers/mmc/sdhci-cadence.c
+++ b/drivers/mmc/sdhci-cadence.c
@@ -39,9 +39,6 @@ static const struct sdhci_cdns_phy_cfg sdhci_cdns_phy_cfgs[] = {
 	{ "cdns,phy-dll-delay-strobe", SDHCI_CDNS_PHY_DLY_STROBE, },
 };
 
-static int __maybe_unused sdhci_cdns_execute_tuning(struct udevice *dev,
-						    unsigned int opcode);
-
 static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_plat *plat,
 				    u8 addr, u8 data)
 {
@@ -158,93 +155,8 @@ static void sdhci_cdns_set_control_reg(struct sdhci_host *host)
 		sdhci_cdns6_phy_adj(mmc->dev, plat, mmc->selected_mode);
 }
 
-static __maybe_unused bool sdhci_cdns_sd_needs_tuning(struct mmc *mmc)
-{
-	struct sdhci_cdns_plat *plat = dev_get_plat(mmc->dev);
-
-	if (!IS_SD(mmc))
-		return false;
-
-	if (!dev_read_bool(mmc->dev, "cdns,sd-hs-tuning"))
-		return false;
-
-	/* Already tuned for this mode */
-	if (plat->tuned_mode == mmc->selected_mode)
-		return false;
-
-	switch (mmc->selected_mode) {
-	case SD_HS:
-		return mmc->bus_width == 4;
-	/* Add future modes here, e.g.:
-	 * case UHS_SDR50:
-	 *	return true;
-	 */
-	default:
-		return false;
-	}
-}
-
-static int sdhci_cdns_set_ios_post(struct sdhci_host *host)
-{
-	struct mmc *mmc = host->mmc;
-	struct sdhci_cdns_plat *plat = dev_get_plat(mmc->dev);
-	int ret __maybe_unused;
-	/*
-	 * The SD6HC soft PHY requires runtime DLL delay calibration
-	 * for SD High Speed mode. The default PHY_DLL_SLAVE_CTRL_REG
-	 * values (READ_DQS_CMD_DELAY and READ_DQS_DELAY = 0) do not
-	 * provide sufficient timing margin due to PVT and board trace
-	 * variations.
-	 *
-	 * Tuning is performed once per entry into SD_HS mode
-	 * (tracked by plat->tuned_mode state). The calibrated PHY delay
-	 * values remain valid while the card stays in SD_HS mode, and
-	 * leaving that tuned mode clears the state so re-entering SD_HS
-	 * triggers tuning again.
-	 *
-	 * This must be done in set_ios_post (not set_control_reg)
-	 * because the SDHCI controller must already be operating at
-	 * the target bus width, clock, and speed mode before CMD19
-	 * tuning commands can succeed.
-	 */
-
-	if (IS_ENABLED(CONFIG_MMC_SUPPORTS_TUNING)) {
-		if (SDHCI_GET_VERSION(host) >= SDHCI_SPEC_420 &&
-		    sdhci_cdns_sd_needs_tuning(mmc)) {
-			ret = sdhci_cdns_execute_tuning(mmc->dev,
-							MMC_CMD_SEND_TUNING_BLOCK);
-			if (ret) {
-				dev_err(mmc->dev,
-					"SD_HS tuning failed (ret=%d), using default PHY\n",
-					ret);
-				/* Restore default PHY settings and avoid retrying in this mode */
-				sdhci_cdns6_phy_adj(mmc->dev, plat,
-						    mmc->selected_mode);
-				plat->tuned_mode = mmc->selected_mode;
-				plat->tuned_dll_slave_ctrl = sdhci_cdns6_phy_get_dll_slave(plat);
-				return 0;
-			}
-			/*
-			 * Tuning succeeded. The tuned_mode is already set by
-			 * execute_tuning(), so the tuned value will be preserved
-			 * across subsequent PHY reconfigurations.
-			 */
-			dev_dbg(mmc->dev, "SD_HS tuning successful\n");
-		}
-
-		/* Reset when mode changes away from a tuned mode */
-		if (mmc->selected_mode != plat->tuned_mode) {
-			plat->tuned_mode = MMC_MODES_END;
-			plat->tuned_dll_slave_ctrl = 0;
-		}
-	}
-
-	return 0;
-}
-
 static const struct sdhci_ops sdhci_cdns_ops = {
 	.set_control_reg = sdhci_cdns_set_control_reg,
-	.set_ios_post = sdhci_cdns_set_ios_post,
 };
 
 static int sdhci_cdns_set_tune_val(struct sdhci_cdns_plat *plat,
@@ -292,7 +204,6 @@ static int __maybe_unused sdhci_cdns_execute_tuning(struct udevice *dev,
 	int cur_streak = 0;
 	int max_streak = 0;
 	int end_of_streak = 0;
-	int ret;
 	int i;
 
 	/*
@@ -318,24 +229,7 @@ static int __maybe_unused sdhci_cdns_execute_tuning(struct udevice *dev,
 		return -EIO;
 	}
 
-	ret = sdhci_cdns_set_tune_val(plat, end_of_streak - max_streak / 2);
-	if (ret)
-		return ret;
-
-	/*
-	 * Mark this mode as tuned. This is critical for both driver tuning
-	 * (SD_HS via set_ios_post) and framework tuning (UHS_SDR104, MMC_HS_200,
-	 * MMC_HS_400) so that subsequent PHY reconfigurations restore the
-	 * calibrated DLL value instead of overwriting with DT defaults.
-	 *
-	 * For HS400, tuning is performed while the controller is in HS200 mode
-	 * (mmc->selected_mode == MMC_HS_200 and mmc->hs400_tuning == true).
-	 * Record the tuned mode as MMC_HS_400 so the calibrated DLL value is
-	 * preserved across the HS200→HS400 transition.
-	 */
-	plat->tuned_mode = mmc->hs400_tuning ? MMC_HS_400 : mmc->selected_mode;
-
-	return 0;
+	return sdhci_cdns_set_tune_val(plat, end_of_streak - max_streak / 2);
 }
 
 static struct dm_mmc_ops sdhci_cdns_mmc_ops;
diff --git a/drivers/mmc/sdhci-cadence.h b/drivers/mmc/sdhci-cadence.h
index ea517491860..7101f00b75b 100644
--- a/drivers/mmc/sdhci-cadence.h
+++ b/drivers/mmc/sdhci-cadence.h
@@ -7,8 +7,6 @@
 #ifndef SDHCI_CADENCE_H_
 #define SDHCI_CADENCE_H_
 
-#include <mmc.h>
-
 /* HRS - Host Register Set (specific to Cadence) */
 /* PHY access port */
 #define SDHCI_CDNS_HRS04		0x10
@@ -62,13 +60,10 @@ struct sdhci_cdns_plat {
 	struct mmc_config cfg;
 	struct mmc mmc;
 	void __iomem *hrs_addr;
-	enum bus_mode tuned_mode;
-	u32 tuned_dll_slave_ctrl;
 };
 
 int sdhci_cdns6_phy_adj(struct udevice *dev, struct sdhci_cdns_plat *plat, u32 mode);
 int sdhci_cdns6_phy_init(struct udevice *dev, struct sdhci_cdns_plat *plat);
 int sdhci_cdns6_set_tune_val(struct sdhci_cdns_plat *plat, unsigned int val);
-u32 sdhci_cdns6_phy_get_dll_slave(struct sdhci_cdns_plat *plat);
 
 #endif
diff --git a/drivers/mmc/sdhci-cadence6.c b/drivers/mmc/sdhci-cadence6.c
index c8b42532e17..ca1086e2359 100644
--- a/drivers/mmc/sdhci-cadence6.c
+++ b/drivers/mmc/sdhci-cadence6.c
@@ -173,30 +173,6 @@ static void sdhci_cdns6_write_phy_reg(struct sdhci_cdns_plat *plat, u32 addr, u3
 	writel(val, plat->hrs_addr + SDHCI_CDNS_HRS05);
 }
 
-static bool sdhci_cdns6_mode_is_tuned(struct sdhci_cdns_plat *plat, u32 mode)
-{
-	/*
-	 * Check if the given mode has a valid tuned DLL value.
-	 * Only modes that support tuning (driver or framework) can have
-	 * valid tuned values. This prevents the initial state (tuned_mode=0)
-	 * from falsely matching MMC_LEGACY.
-	 */
-	if (plat->tuned_mode != mode)
-		return false;
-
-	switch (mode) {
-	case SD_HS:		/* Driver tuning via set_ios_post */
-	case UHS_SDR50:		/* Future driver tuning support */
-	case UHS_SDR104:	/* Framework tuning */
-	case MMC_HS_200:	/* Framework tuning */
-	case MMC_HS_400:	/* Framework tuning */
-	case MMC_HS_400_ES:	/* Framework tuning */
-		return true;
-	default:
-		return false;
-	}
-}
-
 static int sdhci_cdns6_reset_phy_dll(struct sdhci_cdns_plat *plat, bool reset)
 {
 	void __iomem *reg = plat->hrs_addr + SDHCI_CDNS_HRS09;
@@ -283,18 +259,7 @@ int sdhci_cdns6_phy_adj(struct udevice *dev, struct sdhci_cdns_plat *plat, u32 m
 	sdhci_cdns6_write_phy_reg(plat, PHY_DQS_TIMING_REG_ADDR, sdhci_cdns6_phy_cfgs[0].val);
 	sdhci_cdns6_write_phy_reg(plat, PHY_GATE_LPBK_CTRL_REG_ADDR, sdhci_cdns6_phy_cfgs[1].val);
 	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_MASTER_CTRL_REG_ADDR, sdhci_cdns6_phy_cfgs[4].val);
-	if (sdhci_cdns6_mode_is_tuned(plat, mode)) {
-		/*
-		 * Use previously saved tuned DLL slave control value.
-		 * Note: 0 is a valid tuned value (e.g., optimal tap at position 0),
-		 * so we check both mode match AND that it's a tunable mode.
-		 */
-		sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR,
-					  plat->tuned_dll_slave_ctrl);
-	} else {
-		sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR,
-					  sdhci_cdns6_phy_cfgs[2].val);
-	}
+	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR, sdhci_cdns6_phy_cfgs[2].val);
 
 	/* Switch Off the DLL Reset */
 	ret = sdhci_cdns6_reset_phy_dll(plat, false);
@@ -353,9 +318,6 @@ int sdhci_cdns6_set_tune_val(struct sdhci_cdns_plat *plat, unsigned int val)
 
 	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR, tmp);
 
-	/* Store tuned DLL slave control value which will be reapplied via set_ios(). */
-	plat->tuned_dll_slave_ctrl = tmp;
-
 	/* Switch Off the DLL Reset */
 	ret = sdhci_cdns6_reset_phy_dll(plat, false);
 	if (ret) {
@@ -365,8 +327,3 @@ int sdhci_cdns6_set_tune_val(struct sdhci_cdns_plat *plat, unsigned int val)
 
 	return 0;
 }
-
-u32 sdhci_cdns6_phy_get_dll_slave(struct sdhci_cdns_plat *plat)
-{
-	return sdhci_cdns6_read_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR);
-}
-- 
2.43.7

