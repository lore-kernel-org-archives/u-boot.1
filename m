Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E00ADCD342C
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 04:52:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A971484877;
	Wed,  6 May 2026 06:52:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="va/JULVZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75E228493F; Wed,  6 May 2026 05:14:53 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D3478490D
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 05:14:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tze.yee.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tkREXhkD5u3WGb4Av3ClKDlHXgz3EghOkjxW9cu9uaJm7fkcMNR9WDxE6sgUm5P39lX58tCkMNJ47euX5flCCmN7rKmqXHiIezzGq832riSaJT0ky+N4sLzlsOwVCwIzsNg/THhflYn4eTf5vNRbLlY2oBQ/+q6gldMzCKMGXn83B5Wxys8jRQ9G3HGIXYj3Ej73122gLUq4H/ldt0FyisunCo4v7bZKHcjyswnM++HbB4Vn4za14JwGfNEI7sWTpEgI+brZH82A2FYGSY4H5Hy5hk10jpMbBxe68yDjbzDua0c4W5CzXtdp3lJxQ4xbH7ezTL6IQVA7jm/bVJmu8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RgiNVsRZWY9IgX/jBOj5p6BnXVHbjdm6/waEXTEJZ0o=;
 b=EbzDcV3w2UxMpBsRVkOki21ZV2kRdQUWT/kps2zRI+nIz0cg1dbxJ5W2f8hJN1Owu2rWQQeysjCfuBXRnppNXsrXVjb1YjpI8++odY3fev0LvOJkrTR5X8rNP/kQAthz0GO3sbvDxFdXmfxkYyTIV10DQn00jtC44W/071phdBSkz4T2SsBuW82cNPZErj14j0n3ey4TpGbN+i0ShVmUHQ3bmKuwsJBsG+i+zhhf+Cd9iW2jaUvxy/jG39B7LV0rIcG7aYLb9u5SMLCCK52sZNfUjTor2PjcS4ToIgbWJ9qHMeDzpjLO0GI9+ICGRTn5zwJUPqtBzp4AFXG4hj4W8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgiNVsRZWY9IgX/jBOj5p6BnXVHbjdm6/waEXTEJZ0o=;
 b=va/JULVZ/J26wkfZeAQ/Z90DnFf2NTKAOYx2I1MmYn7J7DGsRSHPrPth9io8klwnUDOjgxicgy72hFgTPWqXfLNUYouCG5MwvTYAQTb6bDWxKInv9aKqxg59VnLtBxfU94dzo8v224z2I0Bm/QOu/fHmXJ5J0V/mGP6heJSCLk/y24euvOHUDR7u0j2Isbf47qr1Q2Mk7HpCYk2fxdwRPD5EfAadlyFv6oB8IuMVWPzpKTmGugG0Hnw/phiAkiEwxnCuxZzjrvN4Q1dSPBEvKqv88g63Eo9tnziV/D05EPQEdydCOfH72sxWJurFhWX5rGRaHBcQ0Nrs6Q2KIETvwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by DS0PR03MB8246.namprd03.prod.outlook.com (2603:10b6:8:297::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 03:14:47 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%4]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 03:14:47 +0000
From: tze.yee.ng@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>, alif.zakuan.yuslaimi@altera.com,
 Boon Khai Ng <boon.khai.ng@altera.com>
Subject: [PATCH v3] arm: dts: socfpga: Enable 8-bit embedded device support in
 Agilex5 eMMC device tree
Date: Tue,  5 May 2026 20:14:44 -0700
Message-Id: <d37a55490954242118fbf1e9c4c58fb4e20096e7.1778036424.git.tze.yee.ng@altera.com>
X-Mailer: git-send-email 2.19.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0119.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::34) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|DS0PR03MB8246:EE_
X-MS-Office365-Filtering-Correlation-Id: 70f4b965-2a76-418c-fcd6-08deab1da0e2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|18002099003|55112099003; 
X-Microsoft-Antispam-Message-Info: 8yjioOnfvTWZ8UmquWieCKqdrmX8wy3dDFs3Q5ifSofvZ5v8hty7g5DgXFOEFklj5v/nNgogM5uQ5sohSnQAtcadoi+8ZhfutV3V8ITV3R32ACZS1uKHPG7ib5ShxTnr0NZSiU71rFJ1VDsBoX3pHlSCSNI/03YrWDQz6AwsRj+gdzqUb6WJMsCH8gjetAZejKPnNwuxottERQHZNrkxK6YyL4K0+CgJ6ItJtTjAhhCbrvXAewt743GQ4DMcf8EVH2yB4Zv+s0XKkJdelu3jedUSPGuXuplWwKoAfIx/slPj+HHhpW9aWAzNmHoOPsvDQYKOi/2NNroCU9Nxyp6ooNsd46WdHParUQ5AsqLMtIq1ozcLLdMnKFRlmmLBNMhb6VkN/MjUPT2DR6k97q1phNvzX/FTvVheM8O8GLOw0/k7lKgTkvjC7WoA70INk3S8qOs/E/bzWlrGmjUPbG+zPwmWBNawPzRAm1DKcDnlTeE+ocDo+RQokPnNNxEpqgryAcAQP0mEUoebLENlHjfI/nZPBkM2yyf3HW0SFbGSrhpIT7kpT99WgRSJVlCSwIT97rG71C9dbBOew5GR4w4VuKZNuaqcBcXFr4wNvOV3QR3s/zfqXTHmV+lXQjfoOci2hHk5oeY/4DqVsriVVH+D7ap+eKuAJiHOOWT2SHC585Cy8gKUb+qChG6G7geoDW2g
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR03MB5950.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DGKdgiOS+vbkCuswq2SKSWIbPFqenzFst3FtbWW10K4z4cB7N/JcsXlxyzgM?=
 =?us-ascii?Q?lsecRTzDt7gGfQl7gUEqd2UbUZLuFfidAzUP1PhLgly71KzX2FRga0akDvz2?=
 =?us-ascii?Q?1uSxSi7U9n6ljzliIZ+DRAksxyXKfrugcx3C9OTZV1mx1PR/Q7T4O7XvTBE1?=
 =?us-ascii?Q?cASSem54ChyD425mgN0+f7Mb30+jaGxG+xUu3qYR4ZQI0pvn9q+lMFIr9kPm?=
 =?us-ascii?Q?2XvyQM/AJe/qdMMEGnO+NZsbOHFOJ/zBQXRcPkakqy8QoVSBwxeApAV87xN9?=
 =?us-ascii?Q?OZZ4ydqzZ0wDaFEAXfn/ZE5wEuOmbpZm4RUuCtIJrbF+c+fompXLc17AyIjV?=
 =?us-ascii?Q?/xBDqXt1+3rUXAVQW2EtWk4yJ5Byhd5CGxs3ZmUkdP7JnCU1Q6FN30ur0Ea6?=
 =?us-ascii?Q?A6j+bM19mV8gQoAqPUYSVjm5HvImerxWDEnJZ89apE6WbtRhKpXDgOBKUb0P?=
 =?us-ascii?Q?wcjf5/835NNky472VtDFm4D2+wRKfD8um0PWyJ8UlGSWQ2GUhdHU/EjNfHno?=
 =?us-ascii?Q?PIynoHg2MyceSOUCzcW/J1YM1g0GSxO+aXuJ78/csMl81ntwfvsMpbOVKLAI?=
 =?us-ascii?Q?WmIiweu8ZgxFn2QXI8xuCyUYFDum1gCpx4itF9TWMSEo1gUFpmOvxba6PF51?=
 =?us-ascii?Q?T0KFEQQSxckyrjiHNyvXxV/tfQ/qX3QrxhTTmucfpuh0UD72UKPmBzPo+Vw6?=
 =?us-ascii?Q?9VMM79OZ8SNfybWGAKjCpiqyLKtu7VCAL9CDAJquuNvezNhcwXplMmcv8vwK?=
 =?us-ascii?Q?FqG0xp3MxM1+uIL9rcTQ3GUaGm7mbiwieLM3W/gRVVW65mzvAcxMDOPQ+Rw7?=
 =?us-ascii?Q?JCmycGh8D13KiPBp/V9W+FkfoCaOzQPAFkpLyYoxHwpJcPBu40ZU/rxfENMl?=
 =?us-ascii?Q?WAbWZV/PB8VnWoMEO136ISC5RDn3DSJrDDyiYgxIC77JoA1N0eAJHLbMe860?=
 =?us-ascii?Q?tnLuUkJ3AP6lSb4/2Xw3pqdelhIM92RaDr/crsB8/a7hKa4vQmZRpeoUqz4K?=
 =?us-ascii?Q?rsyqYwt4zJqod35cSQJLwgRPqMumRX+z9Qna1bZV/XIz0X7+/8OdBPgzwxcz?=
 =?us-ascii?Q?r+UeqAov6iuY+hCMrIVVqDtFVaTmYMVlznfWZvWf9ZxMwersBu2H8EQxRsZe?=
 =?us-ascii?Q?eo8S62rI7HdvpQSWvbWFBPP/JOTKW8+ERdUpIXIunuXU+njSiNn2y6FBFp1/?=
 =?us-ascii?Q?BfZchrIgJLwVfWx5/6ae2rl6KiKGZ2U4/2Tx4fgVSEZi61+41J4IpctjqLP9?=
 =?us-ascii?Q?zAOVRnXsHFWb5k+iqWiKmf1shj2ElASMijqhjyA8g3fE3S+isH80P/yCCERP?=
 =?us-ascii?Q?ouc4VMpSfX8Tpry3rBoaiZWhe0ub2e4w7So12enaPkkOEBPozRD9/lVS7Xur?=
 =?us-ascii?Q?TVWsAUTnlTfErLv/GCJTgAa76qVnctT1PbjFDMQ7MRjtRwpUrtFh/yHHMt5M?=
 =?us-ascii?Q?PGXH2jEmoOjjYUbwGDUhv/7jHRhKaCdxyZi7j4IbD1z4y2fVJtD/H+r8D/3o?=
 =?us-ascii?Q?uJ1kIXReMkD2vnIzJYkGT4ZL5jPaA5dilhXHBtIaqVUJ1rEoAukNR5Jtn0Dp?=
 =?us-ascii?Q?RLa964crNHZ6bh0HhvJ1VI9hG6ADwrtb+peGL3W8cAP6UKbsnLz3OTHvm0Xw?=
 =?us-ascii?Q?d6z8ldC0ojVnsSIji+zeKL1nj2tsu+nw1haiHZCLMdMisyYwxFej+Gz0Pf5i?=
 =?us-ascii?Q?GCX5kHUXsh3PiSeasqLMDrdVvm3B3OQNOJVmUq2YILhQMjIanEC5JUkSFH0i?=
 =?us-ascii?Q?RPKPGpKMsQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f4b965-2a76-418c-fcd6-08deab1da0e2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 03:14:47.7395 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OMRGKQ4V80XDKokwNR7urDowoxfla7saW+XxtKpv0t5LQw2aZG5nvedXZt5m0uoI6QvyTYNQeR32YAqEQXIY1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB8246
X-Mailman-Approved-At: Wed, 06 May 2026 06:52:22 +0200
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

From: tzeyeeng <tzeyee.ng@altera.com>

Set SDHCI Capabilities bit18 to enable 8-bit embedded device support.

Signed-off-by: tzeyeeng <tzeyee.ng@altera.com>
---
Changes in v2:
- Remove /delete-property/ sd-uhs-sdr50 and /delete-property/
  sd-uhs-sdr104 from mmc node
- Fix wording in commit message
- Update commit title

Changes in v3:
- Dropping the patch 1 as it is already applied to master.
---
 arch/arm/dts/socfpga_agilex5_socdk_emmc.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts b/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
index c06781064ca..52aa92e4292 100644
--- a/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
+++ b/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
@@ -32,7 +32,7 @@
 	vqmmc-supply = <&emmc_io_1v8_reg>;
 	max-frequency = <200000000>;
 	sdhci-caps = <0x00000000 0x0004c800>;	/* SDHCI_CAN_DO_8BIT */
-	sdhci-caps-mask = <0x00000000 0x0000ff00>;
+	sdhci-caps-mask = <0x00000000 0x0004ff00>;
 
 	/* eMMC legacy mode timing configuration */
 	cdns,phy-dqs-timing-delay-sd-ds = <0x00780000>;
-- 
2.19.0

