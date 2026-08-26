Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F6FC5DF97
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 04:31:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 49C86605E4;
	Wed, 26 Aug 2026 04:31:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0KRaBF5qOaTO; Wed, 26 Aug 2026 04:31:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787718683;
	bh=CTnCgX3MnsLLqJwgirVwwSRKegIlvewEweFQRo4ZrfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FB2Ww8YHw1EhMehjWuLx+1Nn64LQepW76HkZc4bqNJz0magNW8cnxyk8rJIYPGOsm
	 2vCCXS6l5b5EGi6UURcQmBZNn0KgRMRPapDUjT0Q48x3cgFyo3nWVV1JEbkeq/xUR+
	 G3+077JJFxKR2JQ9NwOQwgwAQEFsyB9rRN+uEOAbt47335zMdjG5/6rTQcqRGgUihY
	 9PzSAIfROmAsgQrt6iS8WCTOZQUjO4AfP+fGSzGlNfk5WvC8w2rqIbipYIFMig7Yhl
	 6Shu60cZheTCUvC998MP2MFRuI/N0/w6CgDyCZjP1YiymC0VQ3cftSt9ggRVUPjnLp
	 Z4sDEyK1DFkSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4262A605F4;
	Wed, 26 Aug 2026 04:31:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4C9D9334
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 02:53:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3F10C40068
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 02:53:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gyFSFnM3ZJDm for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 02:53:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c000::1;
 helo=byapr05cu005.outbound.protection.outlook.com;
 envelope-from=tze.yee.ng@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=d4bRxDMF
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5A67E4000B
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 02:53:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oA7aOBoK1xdpFsoxff5HRQ9urm+zP02FeNFUe1LaZrNjG3tzKsrMAJ7PpebDrLR9XTQl9DinLEaUCqiBWIkgn7ZI/2qF1pzUEaiLzbMMzLKn45WOblIfdM0s9iXUvm5S2e595tiZBnVP/FwQx4mN9ZVBgvUk8X9BNTEwtoMcUwANOP7PCjDpS1HhPq5Xi2B0SGvbd0SEV96svZh3A9bXy3VhQyydJ2wdvVGSQMgysOEqkSlZDpyh1KhtNzMrW6mL9/FtDcno26E3+6BGAWqPYMT3tFf0QB4PbUlftZAO/4RNidFlp53A2jSIePTF/UIP9SUACkTzINfxBG7XgJwsuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTnCgX3MnsLLqJwgirVwwSRKegIlvewEweFQRo4ZrfA=;
 b=Mc2HstAOvkDMFyPLLc9N+wSBqrxTqhyRc1eKKi2RqkktimCgak1E/IOaEqYaak+9kk0Fl9gOYgjWOeFe4vr5H8lnWoS1rOE1zfy8HU82qA6kiOmRCE1VxMuLae8ktKy0VB/ScrpDBC0RBmT0EKu19yIDV3P30CkgwngvsfYzNuwf02LPxVr/pDr4muQd951nxW+KDBUnpR2Vylm0Ldr6rlddRwH15UiRinRnpcpHdsFZo2xx19mAk4RBUF1ibgOyUbzf+MXuGXs15fvB6hk3IfAG7qzEK9NO1+mrNvbgMRWLAYA2BORRi/EiZ2vX2gtGps/Ki15s4g3dTxMLWyGkAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTnCgX3MnsLLqJwgirVwwSRKegIlvewEweFQRo4ZrfA=;
 b=d4bRxDMFRR4W3VmcOSn3wv5g4WIdlEI56USEZ9pdS4vuJSifUkJT65C+Fy8SRmKE4PW+WSATO+DK8Q8+hKwLPJymHg34T6NVEvqyJu9TytyCABK+39klwwBpGM+s24sjPI270lBVIqMMfHvSz5/3lry+UJWfBEuKAhe+m7bYJzxrnBmwtVMzI+6/8FJHtAS8JFJmftA0JkCtWoVLbMwdRg36CEHCX3u3rTjN+86RyHvfTivd3bnGaKgIxUBEADJIYOFt4oaovjUTpWoiFOrLc6K0JWn+7PlMJWWKGS1ANMBfXS1G/t8qAAsAD6PJgy3xTKphakxx9NCl5ydWRfJNjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by SJ2PR03MB7167.namprd03.prod.outlook.com (2603:10b6:a03:4f5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Wed, 26 Aug
 2026 02:53:14 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%5]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 02:53:14 +0000
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
Subject: [PATCH 1/4] mmc: sdhci-cadence6: use const PHY config tables with
 per-call overrides
Date: Wed, 26 Aug 2026 10:53:00 +0800
Message-ID: <7431866da9cda49057125df1b28986f04d63e168.1787710268.git.tze.yee.ng@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1787710268.git.tze.yee.ng@altera.com>
References: <cover.1787710268.git.tze.yee.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0083.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::28) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|SJ2PR03MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: 61cdc2c8-8b0f-40eb-20a9-08df031d2bc6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|6133799003|11063799006|10067099003|56012099006|18002099003|22082099003|3023799007|55112099003;
X-Microsoft-Antispam-Message-Info: BpEUGq1TZyjtQCIBgOwd5msgRW0WpWX9poHcOmGJv4UAOxuxxNG1HoWnRDTZl/vYpswxgcPwjVX4GDcHDB/yHYuQTYsTjX9o5MKkrpGqAXsG38s6i+sim/hnBh2II+QxfKgvNSKLb1FNV2gKcBSlSj11f2rFjbudrkRC19ljCvqtW1AQNNLr+HSCWN2uMwrbbXByjXSrT8+DWMFwZFHkG6mfa7mti64NN1F8zPSAcWbY+5xXsIiQ7ZCjmOnM0X3s8sALEX2lsJUGlUiZvk7pbX/bunqm2seNk/eUyuZA4D5Osn2RLqh+IXVKC2v2K9MGy4g0XTG0f/Jx3HozJkGFyto79RoE4RVPXWE7b8/6IoE/cNARpi9vpwbwv9r7AhjFXHwozmmn8+meqlQ1K1m6GZbZpkL+uw2h73GtQUo7a2F6tThbdZEJnkOGSuVHiSjXoNbqb5LMLJqIphVF9LExnlJG15Uo1ZGC+A0U4IcRE2Qu+HzAqEeMRuoLSgMas6ZezcFhtvA9MqoxQghXzZclI5LemAER7lsH68NvuNP+4QLlYTBFdpPYxe1krL0ioF7ybW604JoCuv5zZzz/iCVE2tPyD80QyyobvRN2KgUy5IkJUwwNNQusK5DChR+568axFQmlONgHZijYaaDIyCFZ3hg5JKgXH3K4uNW3srcUEBQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR03MB5950.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003)(3023799007)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LNEAzvT45Sl0wOZKJY23fKgehiMP11x4Q7YvoHn+m7dqGLL+mBrfmOT0Vx9E?=
 =?us-ascii?Q?qunW1E0DxZI5xGaR1QFrg6ULzt+Tw5wM7GDE4XxszZSz439NKuOZ2CJl/1Vh?=
 =?us-ascii?Q?fSlPlFxyaqQEe/EulRKQFegVUWG3VkAieWGFBQlvf0hAiRnVvqCnyvbXFSBH?=
 =?us-ascii?Q?abx0BTBMxnSnNjph0pSMZDKjf8RO2nArbYMvGvSsHKtbC05HtSXs2Y6fanDe?=
 =?us-ascii?Q?bUBuMnYdsp5UoVRmhf9F21k0b1MCYTmalNUlIqfCBTuEd2F95t7kCAXtX3Qr?=
 =?us-ascii?Q?5XYthT60IXQ4R+9FyfqhuGXPh7T27Lk0tNuzUlg9rEecnSRrKyL2rd7+Yby7?=
 =?us-ascii?Q?bxFP3QHDiz53RFvsVNV+4d8iiuc4T0zbz5BrYyqQYdyA7xNBHoSds/NgMgQr?=
 =?us-ascii?Q?uroyHo+mzgjY6S+CCkNHIC/bFgty6ucY2AwxZjY4LShVlRjQ5FPgXjw2pbC3?=
 =?us-ascii?Q?MqxRU3HdlgWHZWN4/lJ/XXn7JUJj+whUUBJDzUsuoL6k6XJGKWCMl6VK13oH?=
 =?us-ascii?Q?HVHev142/c07H9992SdOsKm2lbZLSzhMdPXk1HlSpb2x1n9VPGSPxtXPrahI?=
 =?us-ascii?Q?0JUdReJJNA2c4+pEnUhUukG5IFprXq/OoNXJHcdkxGPAUyA709v7DbuiOMrC?=
 =?us-ascii?Q?5fA8fZYy67Lw4Wj9C7j9pbpx+wJDa8OMqeiO5LTEbL772VVhK00DLrvQGJnG?=
 =?us-ascii?Q?tAXQks6PQWvhAE1q1A+DroUHtMN1Bl1tu2sFA8TfT428gyJDxjlHG03UQX7d?=
 =?us-ascii?Q?33QApHiuJ8hkZ9rjOnrUqyRVHcY16YV3nOaAQ4V6kaQu6d4PAwwtfBKtNYOd?=
 =?us-ascii?Q?OfiHyVlIQAdlGm+qC/JErGgnFOv3qwl28j6ceagma/Zr/wq0TVFfhGqKbhyg?=
 =?us-ascii?Q?8isyHIZ3HgpBOIGqgg6gTxDUeus0JeIp1r4EcCFpnmMjtinxaLIBWYUGj11a?=
 =?us-ascii?Q?qKp9eTh/68NCmkFCrCVcoMSAkQ5YBbvrXB0sXGNJ+6ZGUNjlGMCWbiTwzllf?=
 =?us-ascii?Q?r5Saj9U88wiqCk3uOcTD50JQ5pcgAzKXW4hd3FwPtKNOPJeQZth3N4jXHNu0?=
 =?us-ascii?Q?JkP3D0Smj4g44sr3F6D55lXTAu2VJ+wIaY7+RV+QGpwPysME7sBmC3D1v0cK?=
 =?us-ascii?Q?K1H8Jt6/EtiPSTFow0+8Rqa9LuAowNld4xibGAJ0VeiPkd5QikScBeV5R+no?=
 =?us-ascii?Q?NRmlGlr4peCjgO4LDsuPcqx9HoLZqyZ1wmHy0MXP7IzvD7N78z3rs/gVojEY?=
 =?us-ascii?Q?J3YK03SnaVwA3GFdBdP/CiGo767A+ASAMBFRfRLC1w6uIlWaRUVxPnNvuGSP?=
 =?us-ascii?Q?zjqr2DiFdHPKqskPFBYnD73pcuKkW7Dd7Q2eO0QI84hcHaLZ6Y3jHzcBoury?=
 =?us-ascii?Q?W3L1B8fPV48D+Dh5VFfOpjuQhvFx6f4ZntNlsy6MqMq5n7pVENKd/+bDsM9g?=
 =?us-ascii?Q?npsEYKfoPzUYX+pZ0f6ocirjcxghfSRbIhWWiBa47Fy58kUVmLzLLU45ioRN?=
 =?us-ascii?Q?gIWjzHIrIPll9IASM8Ykqcsa5rW3BoUUXSDZS5lPnXPqPurW2LVj7nO6QhdP?=
 =?us-ascii?Q?MKfXU0bUqDi6D3S3RU7jjxcRdewlXNis/TkPJRyHcbKIKIcCypJuuO6iZ8Wo?=
 =?us-ascii?Q?XmHGyoQTzwBp/raqqRUz89Txv8r80/sszszGJMWxoQ+yeia3fu+nBcs0LlLq?=
 =?us-ascii?Q?EymcoobpO2+yRVep0MbO3S3ffL4scHFU5k/kzG9SlV7SHk3NkRRGZfFg3XZJ?=
 =?us-ascii?Q?Ez8GxMjALg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61cdc2c8-8b0f-40eb-20a9-08df031d2bc6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 02:53:13.9078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q6wWCA66gku2daztNtl9XY/DhkZdXFBEQP21BeUgeexhkVm70ptnsZnQ2h2R3qaT6DIMvLtvkRjQqhem6EmonA==
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

The per-mode PHY and controller configuration arrays are static globals
shared across all SD6HC instances. sdhci_cdns6_phy_adj() read device
tree overrides directly into these tables, so DT-derived values could
leak between controllers, and a missing DT property on one controller
would silently reuse a value programmed for another.

Mark the configuration tables const and copy the selected defaults into
per-call local storage before applying any device tree overrides, so the
shared defaults are never mutated

Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
---
 drivers/mmc/sdhci-cadence6.c | 88 ++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 39 deletions(-)

diff --git a/drivers/mmc/sdhci-cadence6.c b/drivers/mmc/sdhci-cadence6.c
index 407eae96dd4..1ff974ecd44 100644
--- a/drivers/mmc/sdhci-cadence6.c
+++ b/drivers/mmc/sdhci-cadence6.c
@@ -72,7 +72,7 @@ struct sdhci_cdns6_ctrl_cfg {
 	u32 val;
 };
 
-static struct sdhci_cdns6_phy_cfg sd_ds_phy_cfgs[] = {
+static const struct sdhci_cdns6_phy_cfg sd_ds_phy_cfgs[] = {
 	{ "cdns,phy-dqs-timing-delay-sd-ds", 0x00380004, },
 	{ "cdns,phy-gate-lpbk-ctrl-delay-sd-ds", 0x01A00040, },
 	{ "cdns,phy-dll-slave-ctrl-sd-ds", 0x00000000, },
@@ -80,7 +80,7 @@ static struct sdhci_cdns6_phy_cfg sd_ds_phy_cfgs[] = {
 	{ "cdns,phy-dll-master-ctrl-sd-ds", 0x00800004, },
 };
 
-static struct sdhci_cdns6_phy_cfg sd_hs_phy_cfgs[] = {
+static const struct sdhci_cdns6_phy_cfg sd_hs_phy_cfgs[] = {
 	{ "cdns,phy-dqs-timing-delay-sd-hs", 0x00380004, },
 	{ "cdns,phy-gate-lpbk-ctrl-delay-sd-hs", 0x01A00040, },
 	{ "cdns,phy-dll-slave-ctrl-sd-hs", 0x00000000, },
@@ -88,7 +88,7 @@ static struct sdhci_cdns6_phy_cfg sd_hs_phy_cfgs[] = {
 	{ "cdns,phy-dll-master-ctrl-sd-hs", 0x00800004, },
 };
 
-static struct sdhci_cdns6_phy_cfg emmc_sdr_phy_cfgs[] = {
+static const struct sdhci_cdns6_phy_cfg emmc_sdr_phy_cfgs[] = {
 	{ "cdns,phy-dqs-timing-delay-emmc-sdr", 0x00380004, },
 	{ "cdns,phy-gate-lpbk-ctrl-delay-emmc-sdr", 0x01A00040, },
 	{ "cdns,phy-dll-slave-ctrl-emmc-sdr", 0x00000000, },
@@ -96,7 +96,7 @@ static struct sdhci_cdns6_phy_cfg emmc_sdr_phy_cfgs[] = {
 	{ "cdns,phy-dll-master-ctrl-emmc-sdr", 0x00800004, },
 };
 
-static struct sdhci_cdns6_phy_cfg emmc_ddr_phy_cfgs[] = {
+static const struct sdhci_cdns6_phy_cfg emmc_ddr_phy_cfgs[] = {
 	{ "cdns,phy-dqs-timing-delay-emmc-ddr", 0x00380004, },
 	{ "cdns,phy-gate-lpbk-ctrl-delay-emmc-ddr", 0x01A00040, },
 	{ "cdns,phy-dll-slave-ctrl-emmc-ddr", 0x00000000, },
@@ -104,7 +104,7 @@ static struct sdhci_cdns6_phy_cfg emmc_ddr_phy_cfgs[] = {
 	{ "cdns,phy-dll-master-ctrl-emmc-ddr", 0x00800004, },
 };
 
-static struct sdhci_cdns6_phy_cfg emmc_hs200_phy_cfgs[] = {
+static const struct sdhci_cdns6_phy_cfg emmc_hs200_phy_cfgs[] = {
 	{ "cdns,phy-dqs-timing-delay-emmc-hs200", 0x00380004, },
 	{ "cdns,phy-gate-lpbk-ctrl-delay-emmc-hs200", 0x01A00040, },
 	{ "cdns,phy-dll-slave-ctrl-emmc-hs200", 0x00DADA00, },
@@ -112,7 +112,7 @@ static struct sdhci_cdns6_phy_cfg emmc_hs200_phy_cfgs[] = {
 	{ "cdns,phy-dll-master-ctrl-emmc-hs200", 0x00000004, },
 };
 
-static struct sdhci_cdns6_phy_cfg emmc_hs400_phy_cfgs[] = {
+static const struct sdhci_cdns6_phy_cfg emmc_hs400_phy_cfgs[] = {
 	{ "cdns,phy-dqs-timing-delay-emmc-hs400", 0x00280004, },
 	{ "cdns,phy-gate-lpbk-ctrl-delay-emmc-hs400", 0x01A00040, },
 	{ "cdns,phy-dll-slave-ctrl-emmc-hs400", 0x00DAD800, },
@@ -120,42 +120,42 @@ static struct sdhci_cdns6_phy_cfg emmc_hs400_phy_cfgs[] = {
 	{ "cdns,phy-dll-master-ctrl-emmc-hs400", 0x00000004, },
 };
 
-static struct sdhci_cdns6_ctrl_cfg sd_ds_ctrl_cfgs[] = {
+static const struct sdhci_cdns6_ctrl_cfg sd_ds_ctrl_cfgs[] = {
 	{ "cdns,ctrl-hrs09-timing-delay-sd-ds", 0x0001800C, },
 	{ "cdns,ctrl-hrs10-lpbk-ctrl-delay-sd-ds", 0x00020000, },
 	{ "cdns,ctrl-hrs16-slave-ctrl-sd-ds", 0x00000000, },
 	{ "cdns,ctrl-hrs07-timing-delay-sd-ds", 0x00080000, },
 };
 
-static struct sdhci_cdns6_ctrl_cfg sd_hs_ctrl_cfgs[] = {
+static const struct sdhci_cdns6_ctrl_cfg sd_hs_ctrl_cfgs[] = {
 	{ "cdns,ctrl-hrs09-timing-delay-sd-hs", 0x0001800C, },
 	{ "cdns,ctrl-hrs10-lpbk-ctrl-delay-sd-hs", 0x00030000, },
 	{ "cdns,ctrl-hrs16-slave-ctrl-sd-hs", 0x00000000, },
 	{ "cdns,ctrl-hrs07-timing-delay-sd-hs", 0x00080000, },
 };
 
-static struct sdhci_cdns6_ctrl_cfg emmc_sdr_ctrl_cfgs[] = {
+static const struct sdhci_cdns6_ctrl_cfg emmc_sdr_ctrl_cfgs[] = {
 	{ "cdns,ctrl-hrs09-timing-delay-emmc-sdr", 0x0001800C, },
 	{ "cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-sdr", 0x00030000, },
 	{ "cdns,ctrl-hrs16-slave-ctrl-emmc-sdr", 0x00000000, },
 	{ "cdns,ctrl-hrs07-timing-delay-emmc-sdr", 0x00080000, },
 };
 
-static struct sdhci_cdns6_ctrl_cfg emmc_ddr_ctrl_cfgs[] = {
+static const struct sdhci_cdns6_ctrl_cfg emmc_ddr_ctrl_cfgs[] = {
 	{ "cdns,ctrl-hrs09-timing-delay-emmc-ddr", 0x0001800C, },
 	{ "cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-ddr", 0x00020000, },
 	{ "cdns,ctrl-hrs16-slave-ctrl-emmc-ddr", 0x11000001, },
 	{ "cdns,ctrl-hrs07-timing-delay-emmc-ddr", 0x00090001, },
 };
 
-static struct sdhci_cdns6_ctrl_cfg emmc_hs200_ctrl_cfgs[] = {
+static const struct sdhci_cdns6_ctrl_cfg emmc_hs200_ctrl_cfgs[] = {
 	{ "cdns,ctrl-hrs09-timing-delay-emmc-hs200", 0x00018000, },
 	{ "cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-hs200", 0x00080000, },
 	{ "cdns,ctrl-hrs16-slave-ctrl-emmc-hs200", 0x00000000, },
 	{ "cdns,ctrl-hrs07-timing-delay-emmc-hs200", 0x00090000, },
 };
 
-static struct sdhci_cdns6_ctrl_cfg emmc_hs400_ctrl_cfgs[] = {
+static const struct sdhci_cdns6_ctrl_cfg emmc_hs400_ctrl_cfgs[] = {
 	{ "cdns,ctrl-hrs09-timing-delay-emmc-hs400", 0x00018000, },
 	{ "cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-hs400", 0x00080000, },
 	{ "cdns,ctrl-hrs16-slave-ctrl-emmc-hs400", 0x11000000, },
@@ -212,65 +212,75 @@ static int sdhci_cdns6_reset_phy_dll(struct sdhci_cdns_plat *plat, bool reset)
 
 int sdhci_cdns6_phy_adj(struct udevice *dev, struct sdhci_cdns_plat *plat, u32 mode)
 {
-	struct sdhci_cdns6_phy_cfg *sdhci_cdns6_phy_cfgs;
-	struct sdhci_cdns6_ctrl_cfg *sdhci_cdns6_ctrl_cfgs;
+	const struct sdhci_cdns6_phy_cfg *phy_defaults;
+	const struct sdhci_cdns6_ctrl_cfg *ctrl_defaults;
+	struct sdhci_cdns6_phy_cfg phy_cfgs[SDHCI_CDNS6_PHY_CFG_NUM];
+	struct sdhci_cdns6_ctrl_cfg ctrl_cfgs[SDHCI_CDNS6_CTRL_CFG_NUM];
 	u32 tmp;
 	int i, ret;
 
 	switch (mode) {
 	case UHS_SDR12:
 	case MMC_LEGACY:
-		sdhci_cdns6_phy_cfgs = sd_ds_phy_cfgs;
-		sdhci_cdns6_ctrl_cfgs = sd_ds_ctrl_cfgs;
+		phy_defaults = sd_ds_phy_cfgs;
+		ctrl_defaults = sd_ds_ctrl_cfgs;
 		break;
 
 	case SD_HS:
 	case UHS_SDR25:
 	case MMC_HS:
-		sdhci_cdns6_phy_cfgs = sd_hs_phy_cfgs;
-		sdhci_cdns6_ctrl_cfgs = sd_hs_ctrl_cfgs;
+		phy_defaults = sd_hs_phy_cfgs;
+		ctrl_defaults = sd_hs_ctrl_cfgs;
 		break;
 
 	case UHS_SDR50:
 	case MMC_HS_52:
-		sdhci_cdns6_phy_cfgs = emmc_sdr_phy_cfgs;
-		sdhci_cdns6_ctrl_cfgs = emmc_sdr_ctrl_cfgs;
+		phy_defaults = emmc_sdr_phy_cfgs;
+		ctrl_defaults = emmc_sdr_ctrl_cfgs;
 		break;
 
 	case UHS_DDR50:
 	case MMC_DDR_52:
-		sdhci_cdns6_phy_cfgs = emmc_ddr_phy_cfgs;
-		sdhci_cdns6_ctrl_cfgs = emmc_ddr_ctrl_cfgs;
+		phy_defaults = emmc_ddr_phy_cfgs;
+		ctrl_defaults = emmc_ddr_ctrl_cfgs;
 		break;
 
 	case UHS_SDR104:
 	case MMC_HS_200:
-		sdhci_cdns6_phy_cfgs = emmc_hs200_phy_cfgs;
-		sdhci_cdns6_ctrl_cfgs = emmc_hs200_ctrl_cfgs;
+		phy_defaults = emmc_hs200_phy_cfgs;
+		ctrl_defaults = emmc_hs200_ctrl_cfgs;
 		break;
 
 	case MMC_HS_400:
 	case MMC_HS_400_ES:
-		sdhci_cdns6_phy_cfgs = emmc_hs400_phy_cfgs;
-		sdhci_cdns6_ctrl_cfgs = emmc_hs400_ctrl_cfgs;
+		phy_defaults = emmc_hs400_phy_cfgs;
+		ctrl_defaults = emmc_hs400_ctrl_cfgs;
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	for (i = 0; i < SDHCI_CDNS6_PHY_CFG_NUM; i++)
-		dev_read_u32(dev, sdhci_cdns6_phy_cfgs[i].property, &sdhci_cdns6_phy_cfgs[i].val);
+	/*
+	 * Work on per-call copies so DT overrides never mutate the shared
+	 * const defaults, which would otherwise leak between controllers.
+	 */
+	for (i = 0; i < SDHCI_CDNS6_PHY_CFG_NUM; i++) {
+		phy_cfgs[i] = phy_defaults[i];
+		dev_read_u32(dev, phy_cfgs[i].property, &phy_cfgs[i].val);
+	}
 
-	for (i = 0; i < SDHCI_CDNS6_CTRL_CFG_NUM; i++)
-		dev_read_u32(dev, sdhci_cdns6_ctrl_cfgs[i].property, &sdhci_cdns6_ctrl_cfgs[i].val);
+	for (i = 0; i < SDHCI_CDNS6_CTRL_CFG_NUM; i++) {
+		ctrl_cfgs[i] = ctrl_defaults[i];
+		dev_read_u32(dev, ctrl_cfgs[i].property, &ctrl_cfgs[i].val);
+	}
 
 	/* Switch On the DLL Reset */
 	sdhci_cdns6_reset_phy_dll(plat, true);
 
-	sdhci_cdns6_write_phy_reg(plat, PHY_DQS_TIMING_REG_ADDR, sdhci_cdns6_phy_cfgs[0].val);
-	sdhci_cdns6_write_phy_reg(plat, PHY_GATE_LPBK_CTRL_REG_ADDR, sdhci_cdns6_phy_cfgs[1].val);
-	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_MASTER_CTRL_REG_ADDR, sdhci_cdns6_phy_cfgs[4].val);
-	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR, sdhci_cdns6_phy_cfgs[2].val);
+	sdhci_cdns6_write_phy_reg(plat, PHY_DQS_TIMING_REG_ADDR, phy_cfgs[0].val);
+	sdhci_cdns6_write_phy_reg(plat, PHY_GATE_LPBK_CTRL_REG_ADDR, phy_cfgs[1].val);
+	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_MASTER_CTRL_REG_ADDR, phy_cfgs[4].val);
+	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR, phy_cfgs[2].val);
 
 	/* Switch Off the DLL Reset */
 	ret = sdhci_cdns6_reset_phy_dll(plat, false);
@@ -280,7 +290,7 @@ int sdhci_cdns6_phy_adj(struct udevice *dev, struct sdhci_cdns_plat *plat, u32 m
 	}
 
 	/* Set PHY DQ TIMING control register */
-	sdhci_cdns6_write_phy_reg(plat, PHY_DQ_TIMING_REG_ADDR, sdhci_cdns6_phy_cfgs[3].val);
+	sdhci_cdns6_write_phy_reg(plat, PHY_DQ_TIMING_REG_ADDR, phy_cfgs[3].val);
 
 	/* Set HRS09 register */
 	tmp = readl(plat->hrs_addr + SDHCI_CDNS_HRS09);
@@ -288,20 +298,20 @@ int sdhci_cdns6_phy_adj(struct udevice *dev, struct sdhci_cdns_plat *plat, u32 m
 		 SDHCI_CDNS_HRS09_EXTENDED_RD_MODE |
 		 SDHCI_CDNS_HRS09_RDDATA_EN |
 		 SDHCI_CDNS_HRS09_RDCMD_EN);
-	tmp |= sdhci_cdns6_ctrl_cfgs[0].val;
+	tmp |= ctrl_cfgs[0].val;
 	writel(tmp, plat->hrs_addr + SDHCI_CDNS_HRS09);
 
 	/* Set HRS10 register */
 	tmp = readl(plat->hrs_addr + SDHCI_CDNS_HRS10);
 	tmp &= ~SDHCI_CDNS_HRS10_HCSDCLKADJ;
-	tmp |= sdhci_cdns6_ctrl_cfgs[1].val;
+	tmp |= ctrl_cfgs[1].val;
 	writel(tmp, plat->hrs_addr + SDHCI_CDNS_HRS10);
 
 	/* Set HRS16 register */
-	writel(sdhci_cdns6_ctrl_cfgs[2].val, plat->hrs_addr + SDHCI_CDNS_HRS16);
+	writel(ctrl_cfgs[2].val, plat->hrs_addr + SDHCI_CDNS_HRS16);
 
 	/* Set HRS07 register */
-	writel(sdhci_cdns6_ctrl_cfgs[3].val, plat->hrs_addr + SDHCI_CDNS_HRS07);
+	writel(ctrl_cfgs[3].val, plat->hrs_addr + SDHCI_CDNS_HRS07);
 
 	/*
 	 * Wait for the PHY/DLL to settle before the first data transfer.
-- 
2.43.7

