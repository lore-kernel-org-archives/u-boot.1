Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C04FFA0C22
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 04:11:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21BDA83BC4;
	Wed, 15 Apr 2026 06:10:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="umeymoeN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5531280086; Wed, 15 Apr 2026 05:18:20 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47D41839D5
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 05:18:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tze.yee.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L5snhQt+jrPxjgH1N9xf4SJVKy/z7g+6ELIzFWxOhC6GKjL0W19ow7cBHAu7NCzLs2GGWtgd8LWzb+YZk5p2AALs+8EZuLacuzFCW8t3i2jK+7PXKg/uBzXSeGIyp26Es43mDtVmRKOYy8z3zNLLgvHrcRZz02/fGP5J3LKFsWeUR3F4WX4RWJD5sEzd3cNPNUR6O3kZ4PUua6pHyAFnWuhsUgBoWm36NK1RQif6npJxmgF/1dhQnUOIVm6mcCA9II2P8zs0TbNdTBlPUBDSEBng9SZsHypwqE5Uqxi1otx90bwZuI6KgLlSpYoHJVCJidE+eht+1sFUQ+/TE1eSWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDz/nEsgvYQR/soZoex+nIMt/c560uXLhvF1GkEZfSY=;
 b=PSRJ+l6Lem0N2TnrMIj13Q7zdx+Qx248FqqIPE2/8t0UV3E1XqXCcg49pRdNlZnL5yUFb0UsOaR97prl7HLUlgfIjvf82J+n5LRqI/G5yfonXjgZQsyUMwTGm5pw0qNWgABsnwqZiw+8sYRpSSTXD17wp/C6X0D/6d33Z7drftZu7RwunDctm3DvPi8mYm9wA+tyTwXgDm2Uv+MYkblU72xEObvvsMoTkjP8Np2jCG2BWFGGS4fddUpHC8uezLUFa4fp03dzt0YP6OPq4LajF+Ml3Wxkyz3tIaDNeq7SRx70p+JzRZXMVu+k7vB8UwHCQEAZtt163NLYobIIqvUhqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDz/nEsgvYQR/soZoex+nIMt/c560uXLhvF1GkEZfSY=;
 b=umeymoeNvOx2F9X7YdSDrWbUH0JjOob5+sLv67+NQCVV7c36BVF9WdG7fSC5BbvmB4/GE8hVdezg3hE5YM0N5PvbZBR/4iHayIcbu8Sf6U/tsqNoUBKBGoHBMSG7U4deS70C+lFMWQxg0G2II4nPSjEwiFkZ4ocqYDmP+f7yyZeLnV7yQ3Y1mkG+cUSHR5PcVDFxgxi2WTgR3ejjOx3JLnxGxUd3CFSBYQg/k+cyZTfgHMeMQrdhylpg1EZbyYV/uIrVyexgtYUXl5IQ0Tqu9xiBpSFaQeZy1jVCrpNjI6U7wzGLZlTzH2MdT9y4fLlcblMwJrk0fucejZxDu4GBXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by PH0PR03MB6872.namprd03.prod.outlook.com (2603:10b6:510:169::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 03:18:14 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%4]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 03:18:14 +0000
From: tze.yee.ng@altera.com
To: u-boot@lists.denx.de
Cc: Tze Yee Ng <tze.yee.ng@altera.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>, alif.zakuan.yuslaimi@altera.com,
 Boon Khai Ng <boon.khai.ng@altera.com>
Subject: [PATCH 1/2] arm: dts: socfpga: agilex5: Move mmc node differs from
 base board dtsi to dts
Date: Tue, 14 Apr 2026 20:18:10 -0700
Message-ID: <a6845b1f4d723521f3092f7da8a2b5e378cd8c6d.1775640837.git.tzeyee.ng@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1775640837.git.tzeyee.ng@altera.com>
References: <cover.1775640837.git.tzeyee.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::18) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|PH0PR03MB6872:EE_
X-MS-Office365-Filtering-Correlation-Id: dccaf456-a131-4d7c-a608-08de9a9da157
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: wQ2/uepjO1QXGquuHoA09PKm1Z0Xf1gqcCPOtvdNegB1zGts2KQNg2WFPwninBYLtxGKHjnyvDAXpl2sNMXcQM56rB9/ZQHnMYPMt+TrCqflM6za2FJV4JQntXTJQBz13O5IIylY5EXjgTvk6Q+DFerFrc4qqCmSuFzMWGn5Z9EsLKdPgXyxFA9PDQdW6cnW8+D3ySMhwUnLR+hQT2wraDBWUOHmOyodB+t8uePyjRJ0Kxkh4qr7OBd3vdcfbfeVMPpC5wHgmShwMTmzTmRd4cAKZuz/D/0GVNpFYwK35HcZ4FjSRIjOuWTSvqvwscCKFJybzLvUXEsoA2SD8pKnB+BMsfgeD7xCW2FjfszAv9k8MNNInKIBMFPMbaq69t8NYDbdziHHlMdlioDKWE3D6oG2LYmoS7WDDGnXAacZfp7lggueVXzZStEItcvIoA2B9v8qgnUlEZRSce/b+EBF45sr7x2tIvS3TuWueXczwZsKb4rUm/IsFbwibOkmJNLtvdnuEKumD5f8Z7oxyvzEoz8CtSvQm9mRa6UWo/d2t+o8wJfJrVfpEtqAWaIMt4uXQsEQBGDijrHyX5MJ5lC5icyet+COoF7m1y35eL4+H1lyzHO59Ql7lp5ke/5uzpqVMpVb0l2cR9vhRh3qBdFnuLRxP50WaQCINZLPjurfRdtZMe2zRQoq82HqYFFanI+So8YccdKm7qyHzpKI16v3gccu8+5uvTPk8Z/8tX99VfU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR03MB5950.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4Tps8uRxib7PfJ23DHN2S84WGsJB+Xrbbs24IOWRkQcuDh8nxReug+u3hILq?=
 =?us-ascii?Q?w7GU/apu2JKYm7T154SYKUwn0SBPRG2NO8m9XykkyNWOGi0G8Q0DTH7vcZ61?=
 =?us-ascii?Q?lPjGzGMgTaB8giSZ7W0J09iqYsecGl6Jos0p6J3EzgMnHuDJHBqB76BnuGa2?=
 =?us-ascii?Q?a+tnvHkMYMjZy+yYVyoGwkMngQPcgVH6dY4Ue48mNrVJv5sJ+0yKJMyhe9xf?=
 =?us-ascii?Q?rhuhKZfBoUB1pn8rVYyKVs0CRITd/GnUmJZKLQX6xEVrTuGicM9dbRuygkxT?=
 =?us-ascii?Q?P37SVlnzc4HmXevVTQ4IeEfoCky9wUG5+Yna4Pah/2hiDPBuL/SMIfx4/BiM?=
 =?us-ascii?Q?LEIZLq2Y7wMZLCCB0LwryZ8Mxta86Lk46P2Yl/pcL0NWrk2VRfi1nb5ftOlg?=
 =?us-ascii?Q?Kqjz0ELS6yszsz/gkSzzZvHPLOs14pM48B+NjB1ceivOcwpvC5i4upqYEuiO?=
 =?us-ascii?Q?cdU10qczabzS98uSFVJKG7tw2Ps/t/GH4mGwr7W5a60eR2aVSk03ZN3hkZze?=
 =?us-ascii?Q?7+/Ou+vaWiM1xKRpjcnWaffMwwpDTvYuofy80Jp1nKd4RfLY0TGavhUWbrJk?=
 =?us-ascii?Q?oolVvUM5Tuf39VumTxPaAl7aEEdXmOSLcqG687Qno6GtD+h7dGv3sDXVPsHE?=
 =?us-ascii?Q?i4SJ9RudNp13BvgKpfxmXhTiCnCi54n9KuMwEuzLWoLX3R3TNDeV82pfaaSk?=
 =?us-ascii?Q?pZoA5EM6YpCEDaTrxsr4LewFlX19GyX2B6wJHdvf/ZQlrKX9fNAcTW3cjqcM?=
 =?us-ascii?Q?CX2Gu75IfwzO8WsEculNWA0ldVajQitGkGi+wik9aXI5SGjJS8PKITw27eaL?=
 =?us-ascii?Q?VRsXo58pnQ9KwG91EqaZqXX3icLQ+E9cCle15E1xlyr/sevcX4nDBttNLF9W?=
 =?us-ascii?Q?NeEBaCfGoFZ9/WYUUVOzRqs4DK4D2/9tbPJa83eJ3KZoRKpKIvRKxAo25LJI?=
 =?us-ascii?Q?y9QSV/i4BBxQOVWhxJk2fsqvUZZtmMWixwZNhqKRHe/cifLJXm8iwxE1Qqy1?=
 =?us-ascii?Q?5lVDf9fNG/w3zy8K05UIGYAIZJRhOru1MBM5A7hF4m9XvhsLh4VuwaWhE4av?=
 =?us-ascii?Q?ustV5CEzOvvW2ozO4YCOaC9RDMBZ3E8+oK3mYf82H6sUnaLIUIuzvJKsYMea?=
 =?us-ascii?Q?WZbj1Tdpv+gqupAJTwhN5+Xlp4Dj9bLGs7sDFMQ+7NiPfpL8kKct96tjzGa+?=
 =?us-ascii?Q?zVhXpFsiuZpPv0rG+yGyw02jeISjh1uskNvmLQYBOwiSwEsavpegWN91Pm6N?=
 =?us-ascii?Q?C64IiQBOlW4MFUIzYsYuhKyw/YhBLGKQW6129KlV2SjKzznZtSUrXpr9sJTj?=
 =?us-ascii?Q?mLanRZndxqNlJAZTlvAqFY2K5aLKSqVJjLKyRy2eZMFarihGNQ5l/pz/F/wo?=
 =?us-ascii?Q?K8vn8wo/tqkocQsCbnKXLhHfQ4CQoBu9FF32r7I2vPoa0/7m1Zx7A+C7RsQH?=
 =?us-ascii?Q?MrEIrT+9Z8tMQe/BwuCj93JTwuHF7SAbgeS9DbQbIRiH+zHDk+YHBt6hNHRn?=
 =?us-ascii?Q?lH1Ru/u7hP5beczf+ne97EHh4I0zpEmAQa2IiAy4go0aqRudvxCPYA2IxJ4u?=
 =?us-ascii?Q?8zhrl6s7g5uCbJj51606RnWR+OemtGShMJNmS8mtm7JZ9PQ8ZRp5Wo6kNS+r?=
 =?us-ascii?Q?dcoM+R1QlqSxsY+3I+DWxVjtIfKHqVFgtTjtwOOw4VBOED+Uan+8rPfJkWO7?=
 =?us-ascii?Q?Zb8/tpiuE8TyoWjkhaWADa2Kxwg8rKSS8+2z1lNdJskPURlOcSuWDePfJbFD?=
 =?us-ascii?Q?MtnZVV/Qlg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dccaf456-a131-4d7c-a608-08de9a9da157
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 03:18:14.2426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2hZu8NZrNIOOw26NNyCRxQN7hHObxoR838hTMhFya1OacLdFFZjRyfj0eoC47QBefi8KpcDGQtkzviXIaDKDTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6872
X-Mailman-Approved-At: Wed, 15 Apr 2026 06:10:44 +0200
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
Message-ID: <20260415031810._lWN8zjRV-mA_QTwhSCEwIguapOrMLJCI_NLPx_QYwk@z>

From: tzeyeeng <tzeyee.ng@altera.com>

The purpose of this change is to keep common configuration in
socfpga_agilex5_socdk-u-boot.dtsi and move differs to
socfpga_agilex5_socdk.dts.

Signed-off-by: tzeyeeng <tzeyee.ng@altera.com>
---
 arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi | 1 -
 arch/arm/dts/socfpga_agilex5_socdk.dts         | 6 ++++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
index c03f78b2fdf..23c616b1afd 100644
--- a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
@@ -118,7 +118,6 @@
 	vqmmc-supply = <&sd_io_1v8_reg>;
 	max-frequency = <200000000>;
 	sdhci-caps = <0x00000000 0x0000c800>;
-	sdhci-caps-mask = <0x00002000 0x0000ff00>;
 
 	/* SD card default speed (DS) and UHS-I SDR12 mode timing configuration */
 	cdns,phy-dqs-timing-delay-sd-ds = <0x00780000>;
diff --git a/arch/arm/dts/socfpga_agilex5_socdk.dts b/arch/arm/dts/socfpga_agilex5_socdk.dts
index 886cc89fdb6..cbb2bfbe3b4 100644
--- a/arch/arm/dts/socfpga_agilex5_socdk.dts
+++ b/arch/arm/dts/socfpga_agilex5_socdk.dts
@@ -74,6 +74,12 @@
 	status = "okay";
 };
 
+&mmc {
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	sdhci-caps-mask = <0x00002000 0x0000ff00>;
+};
+
 &uart0 {
 	status = "okay";
 };
-- 
2.43.7

