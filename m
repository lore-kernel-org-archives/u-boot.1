Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2913ACD13DA
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 04:29:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B67B484669;
	Tue,  5 May 2026 06:29:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="OsiHP/T1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BC7984866; Tue,  5 May 2026 04:36:16 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBE468483E
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 04:36:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tze.yee.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ggi1FIaugPtrG06FroinmaFeUw00qHlTMwUM2aJ+HjljjZSpMA83u0RzGyZkLVR/mAeRZ8XEQ8pdFmflLT5dGwZAVctiu25UoeLqabDCbVDgZuU5XRQTASQbQFAWn1DkvcjkS3Xwbg+qlshn/qkBvMqDqLqA7CInE5cJRIAvN8VkuGpOVYT8El1Yb9TA3PqJeoUcmtdSaf+NTeGNe+Y2FOAiQ6/0DTvoPUoxt7ubZc9egaagLcfBqmahOTl96n+AybnAJY1BLRhhqJH/ueZK930t1ZF5DS0nAR2ceVqO3M0CCsu4n21LNoMp/I5SsAkor5MX+Se/rL/4bsH3FII5ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ZJcln2/5pITlpkXF3nAwEpPVOfE6NaQpiJUtEAEHdY=;
 b=cslj7+vZd0zC638ExP6nZde+GQWHLZo8paJiRjlXkAcrt5MarE2pOPxo/6nnXlu6jbVotqigX/MDAOqk2wXKm5vR4KiO4x9iwfExLFqjZfgWKltRN+XnVQeNtaU6GokUCZwT5j74hkRNTQeYvglNc5aRXC4mXZpWLp5Q6NYj3peEMAK94OjqplV7CMXikquVXjXQKVQQv0OD04JDBKcl4/5FtJnUAIEUewYyhc2bDemfl1mx5Hc1ilraou1m3g+EHsKizYBQK7W1mIxrIk448eLr7q2Fww4nSRcD5tPZjAQUAcPJ1k4aOIdqxVDBrYerLiMUtHt9Ovt9OVQvQMDq2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZJcln2/5pITlpkXF3nAwEpPVOfE6NaQpiJUtEAEHdY=;
 b=OsiHP/T1dqBrkHQ5Jx/ugBwoe0+CLAD9rOK7oPO+omlnah0edOC7yy6AlZK40BcFEDyovRucmnlcRZHyZHcG+6n1PGTy8BCfZf3/kSafJuqXJbcDCK9WZ2KIb2AWhvQYICrCm11riXfe+sietn95+FLQVushlX1mYNpysCXDB6ltmKG/rM6pNP6caOk7lhIyiMB3R9JJf50TVdG6tCSv6t4zAUdwv1Hm2ANePiF3hZa/kzEC1xgjUtyDZ5Wpc6nkdX2sAnvCe3BmTFfjenGgVDn21npg2+AH0o8IHetxgEuQqE9/s2RR3Yg/DMGLZtXiLKzaIZCmUY9eh4IgIPMozg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by SJ2PR03MB7095.namprd03.prod.outlook.com (2603:10b6:a03:500::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 02:36:07 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 02:36:07 +0000
From: tze.yee.ng@altera.com
To: u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Tze Yee Ng <tze.yee.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>, alif.zakuan.yuslaimi@altera.com,
 Boon Khai Ng <boon.khai.ng@altera.com>
Subject: [PATCH] mmc: sdhci-cadence: trigger tuning for SD HS mode on SD6HC
 (v6) PHY
Date: Mon,  4 May 2026 19:36:03 -0700
Message-ID: <f385cf516e8a75fff5c90aa9e54f8e54044f0dd9.1777947009.git.tze.yee.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY1P220CA0044.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::10) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|SJ2PR03MB7095:EE_
X-MS-Office365-Filtering-Correlation-Id: aa607d84-0557-4718-bafa-08deaa4f0f44
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|55112099003|10063799003;
X-Microsoft-Antispam-Message-Info: lxUtet8hGHjFB+1Ne7JuG2PL53O5tjlD3qCBIVQKn1CdgC6DLY5U1pNHnFmEK4Tk5HqJF8a3Nj75KBsyPMDxySJZtMjhlu56YZkKvAvPa8WKDadOMF9E/v8qb2jf9qzWLIkspIiNLTiTZu1sb/2tyE8Mw76pX99u/V/dQIlGQ7iqT60q1yQCzLUjFXY+Rtt1EnNeZXTZPEzkGVGCE8SW9x7/3UEWFAmVeJ2WU9KCtGlaIFAOmH8VswuiGvoZ97xUo6Li4Z4xABgL+UYYqEDs1K3rzFk+4Hqgt61miDq59to8vJzprN2cmDt7kN1x7Mgjon5hJKmsDtTJCHF2DrOXvyDhBAVTaKcH+tBpqCAO+GRp0KuW3G1ioEvbnShc36/vWAPn3oECXpeQzAEJPPrnWHU4jdTE2AaOT5TEgJBrAMwctPUpVnJVa2lkfc88xukM5MJ4XupzH2rraznjwnBlQXeK7wT+Jo0bQdOt/k9/rvOFcKSodiuBo8wpLtmzBEPySGB/GyC5zR41lPONgUyRF7GftYlB3zzPs+bjtBjCQcRarcuOo5DIPns134EIrTNe7IxtKE+ALZdRQbXsOwQgJsTpkQZnjOh4f4eA6uyQMGuF3lwyhC9dTaAJc3mqHLgIoI3tKEWhoc3Vc/PUKXNSLKAdTQ6GLaA3K1lt6Ktdoy+ukGDJf3Ky4XyF0sD815I5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR03MB5950.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(55112099003)(10063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0RYQnJRdXNkRE1zY2trRmFtV1QySGI5WkU3a3RrTUlsalJPT1RWcFYwOEto?=
 =?utf-8?B?MXJEQlhHRzZ6TGRwT1M2Ynk5dlhRcmZ3ZlkyK211NzJLa3B5dzVKWkJXY05X?=
 =?utf-8?B?N2w2dUluaklCeHBReGpHeU82bURWd1NON3lyNkh4WEU4ZU1OVTdEaDVZUUZp?=
 =?utf-8?B?dnNoendreEtVTWpyVkNDMDNXWEwzYjZZdlNFcXIwbWxsUGR5bkxYaDNnM0hi?=
 =?utf-8?B?VEdpaXhqaGxWT0JleGhaTUxua25NOGRlMjMyMWdWVHdXYm44RG0zUERMNWtK?=
 =?utf-8?B?MENkR0hBOXRsNkVZN3ZVVzRueEk5Y0JsZDRTVG4rVEQ3dHZOUWN3SEtOSExG?=
 =?utf-8?B?am5OekxEbm5sdEZQaXlWQTdqSHBuZHJZM0g5c1F5TDBkck9xU2xLWGZodjF2?=
 =?utf-8?B?QndMSTM5N0tCYU5YVERQMk1zZkp4RWtVaEYwZkpyN2MzQmp3Y21Qdmd1N29G?=
 =?utf-8?B?TERXcnhINTZXckU1aW1XTldoNVZOdSt6S1YzMUVUUWxoNEJMbmZCNFFnRGJ3?=
 =?utf-8?B?VFVQNEVLcHhDQTVDOWRNR0kyV1N2WTRVNHZrUjNtQ1ZJb0E1eHYzbnFxRXMw?=
 =?utf-8?B?aDJUTFlYZGNUcUxHOGtwb0YzemMwQkwwdk5IMUhQeHlUaVNkVk1obEduYXMx?=
 =?utf-8?B?ZDFmUi9uTEYwMHlkaVMrQlRNL2ZKbXc3b29YWWdHOXo2SlpKWHN5MFNBd2lR?=
 =?utf-8?B?djdLTVVSZ0FtMXJUWFQwajNPdUloUTZvUk5lcDhrd3pXZUkrY0xmTDlEUXRG?=
 =?utf-8?B?RkNzY3p0a1ppZnlWWVd1K2tTQ0JQYkFQMlh2R3IrTncwZVcvTEdHZXJ6S0Jq?=
 =?utf-8?B?K2tCcWJwMXFLV2g4eHYwb09YUU1lQVp6dnEvS0N0VExOTCtSUkZlOWhCR0hi?=
 =?utf-8?B?Nzl0WEdHcmgvR01Da1c5UVRuMjdKUWV3aGhHS1AweTlUMWhScHFueGw0dlNn?=
 =?utf-8?B?Q1VlU0FqUWp6aVZ3aHBqOUt5S1puMjRjWXlSZ204K2hHbXlXYlpFamttMEVr?=
 =?utf-8?B?VStmVWZzektXbEpGTnRYbnM4Sy9pUEt3NjUxdk15VnZDcnRxRUpzUk5FeWdB?=
 =?utf-8?B?Ym9uWmZEQ0E4bzBFRnVDVlZ3Z05WcUpPMncxRExCZ0RRZkpLRVdHZzVMd0tL?=
 =?utf-8?B?eHczZFo5ZEFXWHV4RkhtRzBKZmRDN0Z4aG01a09vcUFXTjB6TnUzcS9tZ1Y0?=
 =?utf-8?B?cFNWNmFvTENxMlZRNWM2VjZUOVc1eFdVTE92bmxJdFY4L3RPNFo0c0dGUVQ1?=
 =?utf-8?B?RzBUSzhuZndJbTRwZ29TWHhCTERXRTV2QUZxV1FXdENTdEY5YytlaEtkU2pk?=
 =?utf-8?B?YS9JbXNGSHpIRmI4QnljbkZOZ3VxOGZpaUlscWRkSWFsYm54TUhrZGIyRC9r?=
 =?utf-8?B?TCtBbVRtb3FOV3VtZDNRNmFyRDZIWDZlOGVURjFYQldhN21IejlaTW96TzRB?=
 =?utf-8?B?MUpNc2srd1puaHVzTTdvYURBOEE3ZENOeUNUUTdkYWhuSUUzZ1E5UmgvNWZx?=
 =?utf-8?B?bGIyZWhhaVR3VVFQenV6WTErdkdDQ3pIcXNGcStrRWc2Q1M2MGM5NWhYZGo2?=
 =?utf-8?B?bVBUTE1HSEF3VTY5NHc5dnJxMVgwSjVsZGp2THdVSk5rb293ZUZNU2tIaHdJ?=
 =?utf-8?B?K3Y2RklmSm1BNEhSMmQxQzAwOGFTOTl0Z3JZcitSNFRKMGViUm9qcldQNWZZ?=
 =?utf-8?B?TFNpRGpJemZJTFp6MVpYa0JGc3g4MXN6RGZzYkpHR3FoRHBYT21nOU1KNnpT?=
 =?utf-8?B?RW1VQVJLblcyMkFXaUxkVUZrZGtxN2JTV3VmZStMbXY1eE1Fc1lTSFJMclJC?=
 =?utf-8?B?b1JMWk1pVXFZNURFdkhQdGdrYTE1NGY2MUE2b2h6UHU4c2Q5SE0xamxpYW9P?=
 =?utf-8?B?UDdEdEtVL1lMR3luSEJTSWZ6VUtyVW5DMkJsVEVYT0Zwb2I0aDE1TnhYVjZR?=
 =?utf-8?B?RUpiak5yRk9RUWNveWRLOWwxL1JQTng3Vk9SU2JvTksxZ1RBMjl4RUFtOUpw?=
 =?utf-8?B?bkZCYUI5Z3dIWjZBbEZCS1VGZXZCamF0NXh1bndCeXJ5YXozaFp2RFFESlVO?=
 =?utf-8?B?ZDhEelRJZnpVcWF5cnAyUFRibElBZmVqVEI4N0pKcGJHUjM2VEdzaWQ1cnRV?=
 =?utf-8?B?UHRyRkhOZ2puVlM0RStmak1EYzZuMmRwWHJZNENZQTJ2YTg5b2xQSWFmeGln?=
 =?utf-8?B?S3UrYW40QlpkK25TNVp2TTloNWhnQXgvakRXT2F2N2lka2lsd3drc240ckRM?=
 =?utf-8?B?RngxT0RhTndyMERLa2pmOHI0ZzU1VXdtS2hRU09naWxTbm1NQ05WT3ozMmRB?=
 =?utf-8?B?ays1K05JUGlDVFBxUlJTN2VYbUxrZGNnWnR0SG5WRzhNQVdtVUtlUT09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa607d84-0557-4718-bafa-08deaa4f0f44
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 02:36:07.1021 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Sqr1fY7VDr9ZOvbI6Kzq0nflDqTqD4rL+tBGta6NT9TOYLr2OG7gU7vEZKXp+OtThVTI8n2coAqE3FSdCyQ+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7095
X-Mailman-Approved-At: Tue, 05 May 2026 06:29:02 +0200
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

From: Tze Yee Ng <tze.yee.ng@altera.com>

The Cadence SD6HC (SDHCI spec v4.20+) controller uses a soft PHY whose
DLL delay characteristics vary with PVT (Process, Voltage, Temperature)
and board-level trace routing.

A static delay value programmed via device tree for SD High Speed mode is
insufficient because the optimal sampling point varies per board, SD card,
and operating conditions. Runtime calibration is required.

While the SD Physical Layer Specification does not mandate tuning for
SD HS mode (only for UHS-I SDR50/SDR104), the Cadence SD6HC PHY
requires runtime calibration of its receive data delay line to find a
valid sampling window under constrained clock conditions.

The tuning is triggered from the set_ios_post callback because at that
moment hardware has committed the new bus width, clock frequency, and speed
mode to the controller registers. This ensuring the tuning sequence runs
at the correct SD HS operating conditions.

The tuning is gated by a device tree property "cdns,sd-hs-tuning" so
that only boards requiring runtime calibration opt in. When enabled,
the driver performs a 40-tap DLL sweep using CMD19 to find the largest
consecutive passing window, then programs the midpoint into
PHY_DLL_SLAVE_CTRL_REG.

To enable on a board, add to the MMC node in device tree:

    &mmc {
        cdns,sd-hs-tuning;
    };

Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
---
 drivers/mmc/sdhci-cadence.c  | 108 ++++++++++++++++++++++++++++++++++-
 drivers/mmc/sdhci-cadence.h  |   5 ++
 drivers/mmc/sdhci-cadence6.c |  45 ++++++++++++++-
 3 files changed, 156 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/sdhci-cadence.c b/drivers/mmc/sdhci-cadence.c
index 5bbc18dfa51..a76f9e8d6bd 100644
--- a/drivers/mmc/sdhci-cadence.c
+++ b/drivers/mmc/sdhci-cadence.c
@@ -39,6 +39,9 @@ static const struct sdhci_cdns_phy_cfg sdhci_cdns_phy_cfgs[] = {
 	{ "cdns,phy-dll-delay-strobe", SDHCI_CDNS_PHY_DLY_STROBE, },
 };
 
+static int __maybe_unused sdhci_cdns_execute_tuning(struct udevice *dev,
+						    unsigned int opcode);
+
 static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_plat *plat,
 				    u8 addr, u8 data)
 {
@@ -155,8 +158,93 @@ static void sdhci_cdns_set_control_reg(struct sdhci_host *host)
 		sdhci_cdns6_phy_adj(mmc->dev, plat, mmc->selected_mode);
 }
 
+static __maybe_unused bool sdhci_cdns_sd_needs_tuning(struct mmc *mmc)
+{
+	struct sdhci_cdns_plat *plat = dev_get_plat(mmc->dev);
+
+	if (!IS_SD(mmc))
+		return false;
+
+	if (!dev_read_bool(mmc->dev, "cdns,sd-hs-tuning"))
+		return false;
+
+	/* Already tuned for this mode */
+	if (plat->tuned_mode == mmc->selected_mode)
+		return false;
+
+	switch (mmc->selected_mode) {
+	case SD_HS:
+		return mmc->bus_width == 4;
+	/* Add future modes here, e.g.:
+	 * case UHS_SDR50:
+	 *	return true;
+	 */
+	default:
+		return false;
+	}
+}
+
+static int sdhci_cdns_set_ios_post(struct sdhci_host *host)
+{
+	struct mmc *mmc = host->mmc;
+	struct sdhci_cdns_plat *plat = dev_get_plat(mmc->dev);
+	int ret __maybe_unused;
+	/*
+	 * The SD6HC soft PHY requires runtime DLL delay calibration
+	 * for SD High Speed mode. The default PHY_DLL_SLAVE_CTRL_REG
+	 * values (READ_DQS_CMD_DELAY and READ_DQS_DELAY = 0) do not
+	 * provide sufficient timing margin due to PVT and board trace
+	 * variations.
+	 *
+	 * Tuning is performed once per entry into SD_HS mode
+	 * (tracked by plat->tuned_mode state). The calibrated PHY delay
+	 * values remain valid while the card stays in SD_HS mode, and
+	 * leaving that tuned mode clears the state so re-entering SD_HS
+	 * triggers tuning again.
+	 *
+	 * This must be done in set_ios_post (not set_control_reg)
+	 * because the SDHCI controller must already be operating at
+	 * the target bus width, clock, and speed mode before CMD19
+	 * tuning commands can succeed.
+	 */
+
+	if (IS_ENABLED(CONFIG_MMC_SUPPORTS_TUNING)) {
+		if (SDHCI_GET_VERSION(host) >= SDHCI_SPEC_420 &&
+		    sdhci_cdns_sd_needs_tuning(mmc)) {
+			ret = sdhci_cdns_execute_tuning(mmc->dev,
+							MMC_CMD_SEND_TUNING_BLOCK);
+			if (ret) {
+				dev_err(mmc->dev,
+					"SD_HS tuning failed (ret=%d), using default PHY\n",
+					ret);
+				/* Restore default PHY settings and avoid retrying in this mode */
+				sdhci_cdns6_phy_adj(mmc->dev, plat,
+						    mmc->selected_mode);
+				plat->tuned_mode = mmc->selected_mode;
+				plat->tuned_dll_slave_ctrl = sdhci_cdns6_phy_get_dll_slave(plat);
+				return 0;
+			}
+			/*
+			 * Tuning succeeded. The tuned_mode is already set by
+			 * execute_tuning(), so the tuned value will be preserved
+			 * across subsequent PHY reconfigurations.
+			 */
+			dev_dbg(mmc->dev, "SD_HS tuning successful\n");
+		}
+
+		/* Reset when mode changes away from a tuned mode */
+		if (mmc->selected_mode != plat->tuned_mode) {
+			plat->tuned_mode = MMC_MODES_END;
+			plat->tuned_dll_slave_ctrl = 0;
+		}
+	}
+
+	return 0;
+}
+
 static const struct sdhci_ops sdhci_cdns_ops = {
 	.set_control_reg = sdhci_cdns_set_control_reg,
+	.set_ios_post = sdhci_cdns_set_ios_post,
 };
 
 static int sdhci_cdns_set_tune_val(struct sdhci_cdns_plat *plat,
@@ -204,6 +292,7 @@ static int __maybe_unused sdhci_cdns_execute_tuning(struct udevice *dev,
 	int cur_streak = 0;
 	int max_streak = 0;
 	int end_of_streak = 0;
+	int ret;
 	int i;
 
 	/*
@@ -229,7 +318,24 @@ static int __maybe_unused sdhci_cdns_execute_tuning(struct udevice *dev,
 		return -EIO;
 	}
 
-	return sdhci_cdns_set_tune_val(plat, end_of_streak - max_streak / 2);
+	ret = sdhci_cdns_set_tune_val(plat, end_of_streak - max_streak / 2);
+	if (ret)
+		return ret;
+
+	/*
+	 * Mark this mode as tuned. This is critical for both driver tuning
+	 * (SD_HS via set_ios_post) and framework tuning (UHS_SDR104, MMC_HS_200,
+	 * MMC_HS_400) so that subsequent PHY reconfigurations restore the
+	 * calibrated DLL value instead of overwriting with DT defaults.
+	 *
+	 * For HS400, tuning is performed while the controller is in HS200 mode
+	 * (mmc->selected_mode == MMC_HS_200 and mmc->hs400_tuning == true).
+	 * Record the tuned mode as MMC_HS_400 so the calibrated DLL value is
+	 * preserved across the HS200→HS400 transition.
+	 */
+	plat->tuned_mode = mmc->hs400_tuning ? MMC_HS_400 : mmc->selected_mode;
+
+	return 0;
 }
 
 static struct dm_mmc_ops sdhci_cdns_mmc_ops;
diff --git a/drivers/mmc/sdhci-cadence.h b/drivers/mmc/sdhci-cadence.h
index 7101f00b75b..ea517491860 100644
--- a/drivers/mmc/sdhci-cadence.h
+++ b/drivers/mmc/sdhci-cadence.h
@@ -7,6 +7,8 @@
 #ifndef SDHCI_CADENCE_H_
 #define SDHCI_CADENCE_H_
 
+#include <mmc.h>
+
 /* HRS - Host Register Set (specific to Cadence) */
 /* PHY access port */
 #define SDHCI_CDNS_HRS04		0x10
@@ -60,10 +62,13 @@ struct sdhci_cdns_plat {
 	struct mmc_config cfg;
 	struct mmc mmc;
 	void __iomem *hrs_addr;
+	enum bus_mode tuned_mode;
+	u32 tuned_dll_slave_ctrl;
 };
 
 int sdhci_cdns6_phy_adj(struct udevice *dev, struct sdhci_cdns_plat *plat, u32 mode);
 int sdhci_cdns6_phy_init(struct udevice *dev, struct sdhci_cdns_plat *plat);
 int sdhci_cdns6_set_tune_val(struct sdhci_cdns_plat *plat, unsigned int val);
+u32 sdhci_cdns6_phy_get_dll_slave(struct sdhci_cdns_plat *plat);
 
 #endif
diff --git a/drivers/mmc/sdhci-cadence6.c b/drivers/mmc/sdhci-cadence6.c
index ca1086e2359..c8b42532e17 100644
--- a/drivers/mmc/sdhci-cadence6.c
+++ b/drivers/mmc/sdhci-cadence6.c
@@ -173,6 +173,30 @@ static void sdhci_cdns6_write_phy_reg(struct sdhci_cdns_plat *plat, u32 addr, u3
 	writel(val, plat->hrs_addr + SDHCI_CDNS_HRS05);
 }
 
+static bool sdhci_cdns6_mode_is_tuned(struct sdhci_cdns_plat *plat, u32 mode)
+{
+	/*
+	 * Check if the given mode has a valid tuned DLL value.
+	 * Only modes that support tuning (driver or framework) can have
+	 * valid tuned values. This prevents the initial state (tuned_mode=0)
+	 * from falsely matching MMC_LEGACY.
+	 */
+	if (plat->tuned_mode != mode)
+		return false;
+
+	switch (mode) {
+	case SD_HS:		/* Driver tuning via set_ios_post */
+	case UHS_SDR50:		/* Future driver tuning support */
+	case UHS_SDR104:	/* Framework tuning */
+	case MMC_HS_200:	/* Framework tuning */
+	case MMC_HS_400:	/* Framework tuning */
+	case MMC_HS_400_ES:	/* Framework tuning */
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int sdhci_cdns6_reset_phy_dll(struct sdhci_cdns_plat *plat, bool reset)
 {
 	void __iomem *reg = plat->hrs_addr + SDHCI_CDNS_HRS09;
@@ -259,7 +283,18 @@ int sdhci_cdns6_phy_adj(struct udevice *dev, struct sdhci_cdns_plat *plat, u32 m
 	sdhci_cdns6_write_phy_reg(plat, PHY_DQS_TIMING_REG_ADDR, sdhci_cdns6_phy_cfgs[0].val);
 	sdhci_cdns6_write_phy_reg(plat, PHY_GATE_LPBK_CTRL_REG_ADDR, sdhci_cdns6_phy_cfgs[1].val);
 	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_MASTER_CTRL_REG_ADDR, sdhci_cdns6_phy_cfgs[4].val);
-	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR, sdhci_cdns6_phy_cfgs[2].val);
+	if (sdhci_cdns6_mode_is_tuned(plat, mode)) {
+		/*
+		 * Use previously saved tuned DLL slave control value.
+		 * Note: 0 is a valid tuned value (e.g., optimal tap at position 0),
+		 * so we check both mode match AND that it's a tunable mode.
+		 */
+		sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR,
+					  plat->tuned_dll_slave_ctrl);
+	} else {
+		sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR,
+					  sdhci_cdns6_phy_cfgs[2].val);
+	}
 
 	/* Switch Off the DLL Reset */
 	ret = sdhci_cdns6_reset_phy_dll(plat, false);
@@ -318,6 +353,9 @@ int sdhci_cdns6_set_tune_val(struct sdhci_cdns_plat *plat, unsigned int val)
 
 	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR, tmp);
 
+	/* Store tuned DLL slave control value which will be reapplied via set_ios(). */
+	plat->tuned_dll_slave_ctrl = tmp;
+
 	/* Switch Off the DLL Reset */
 	ret = sdhci_cdns6_reset_phy_dll(plat, false);
 	if (ret) {
@@ -327,3 +365,8 @@ int sdhci_cdns6_set_tune_val(struct sdhci_cdns_plat *plat, unsigned int val)
 
 	return 0;
 }
+
+u32 sdhci_cdns6_phy_get_dll_slave(struct sdhci_cdns_plat *plat)
+{
+	return sdhci_cdns6_read_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR);
+}
-- 
2.43.7

