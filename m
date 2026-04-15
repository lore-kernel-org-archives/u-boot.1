Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57864FA0C22
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 04:11:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6385884206;
	Wed, 15 Apr 2026 06:10:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="a7pMxxBZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 668EE80086; Wed, 15 Apr 2026 04:03:13 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6301E839D5
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 04:03:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tze.yee.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qC9qzucauotGqDEuM4701YHd5trcYOuk7MFIj8X31sUv7aHaj01v6qCQlRWw+wyImImnxNwyKI29xPbFrhP6ORMizyt+InPuetn+J9OlmKoklpxdZVrcrcMnqp2aN+vyQpxw5sKhv91zzMW4nbFQb9mg9Y9mKaFXSx+9m/jnZOEBo1mOoaKhoQkEzNPFHFVV9p0QcMmF02mEmJiyNBJuPxRge/bJIUUUfC9ILlXup4YYEPHUuAkmmFuorN8BJLhIacpHEni7oX8ovXk5OzOAf72cZlUQ7eM92e72PMnNprRjeqSynAzbEYkDbIi42nl6UPNix9vpjNDPrkG41ipa3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDz/nEsgvYQR/soZoex+nIMt/c560uXLhvF1GkEZfSY=;
 b=iQJ5dDj3fKMTL4uoqcl53SPDrq7OZRa+PAMVVLUpAMyURsQVgFPyZo1ibqtqal/NQjOoqDbkykoh4UUA1gRhc8inPH6kfltpha5mdC4mOCwLbPAdSupo3oza+n7JMoYsUcBKA7Dmtd0xP73rwvxeazePCwkn4juNmW++Ofre5I3X04bcSnVYbmtQ6AeTwi/VgxVKubAAocgaODzB5Irek2bUMzOUDl3RlIRS3WaNidETD2EY2BR+U5zetv6qnFVj6dYSnCwtXiNfJevhXxq6Yd6qZhz4z4s/m1+4UoLFyMmPAPlxDXfE7EaHFYFnL3WO0WfQvThcqefXqBzZiKnPRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDz/nEsgvYQR/soZoex+nIMt/c560uXLhvF1GkEZfSY=;
 b=a7pMxxBZMtIcbO7CQv6+VNN53fc8U3pyg0cjvsRNuFoaWB4dhODSRt6m0W2VgRC++S+7nxdKzcK2SaBrcFTaWfc26H6UHgu/n12wZlMpT5/fBSsYcJKf15evR0qfbA5jmkS2fhIxFJfQhg7xzJE9cD7qiioTfiqf1wvp+s2Hrwm69wPR3BHcpyqUUD6LzBr99Gcn4UxtRvvyxdOcWdNfvmgOruAhC3AIfhNtTrdx0u+JOBIWvm3loarE6oDAFaqHa2ksSqj/E0raOUPx4s3Rzeb6hHYierl+EcOd3fLo8Eaj0bF6vzNbo0QLugU5z/N3rk1gZiFlO5BGtPnuzmXPiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by IA3PR03MB7596.namprd03.prod.outlook.com (2603:10b6:208:508::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 02:03:09 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%4]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 02:03:09 +0000
From: tze.yee.ng@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 1/2] arm: dts: socfpga: agilex5: Move mmc node differs from
 base board dtsi to dts
Date: Tue, 14 Apr 2026 19:03:05 -0700
Message-ID: <a6845b1f4d723521f3092f7da8a2b5e378cd8c6d.1775640837.git.tzeyee.ng@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1775640837.git.tzeyee.ng@altera.com>
References: <cover.1775640837.git.tzeyee.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0053.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::28) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|IA3PR03MB7596:EE_
X-MS-Office365-Filtering-Correlation-Id: c2f217b3-91a4-4d38-b2d8-08de9a93237f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 2E1zfe5EBD+f9hvrbZUO5c+AwPQU9QpjfNbWBVRVEoJlysk75S/0xmn5ga4V7Pau0t3mpUzoncwb8G7i+ZdvLoRYfQ1/7jUJTh49r8KzapllhVmD+8EBe8MIHSp+/fSD9x2wl7xK0KEleJ8JqQ+FnCWIwtHTZhzEI7sg0pLmDfB2n5lJLrryyaHPqeS9J6jnPGBfz9tiepm3jK19qWQRABcP1uIYEE+yM1LQtd9pylegJVB608t1YpVwjMXjeVjsZu/l69jSvqwzwTYYmo+HxrfHi1/gXT4KPCLioUH9UbwbKQvwqNGDj4j97UdRBOyvfZ7ba3VQECAenXz2eLm8lz+/praVIVCrm/ikMeLP55cQegmOeaww9Q+mg0w6mcaL/FZ6nrYXqOkafcyqmpfWGvFos7FACsCSegvZlzfDAeIgjC+p7msdjEHnLd4RdquJcRMYNRz0O1xOG/N0lHcCM3Mfuvs3zGCTZhfPXiiDMUk2F9z4CwSoLBiHa2vMMSg+OQ3kPYsGxIx4iQNkjhx+ukhCdqPZogxuK1Bwp0aaA0TzYtr3USgq9lqfePoYyBkl1+tCyP94LfxSUATOJyLZ8YbOQhvbVN2O1z5qNauedQPNSY/UziOJtalEPXTpP7FQ9qi5W40FIm8IetOEJ53uEFB8mnohpd92QKUvyzU7v+1Gs4v0lY+uHJcBXiHWejUQICBmJxC43BgQKxj/eA7ful8V65vSX3IIAPOEmSd/He8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR03MB5950.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WibvixM/97PbO4YdM8Pz5mUCGrd2s16xtzXWZGUDhFL8yRatD0JRWPW38/9t?=
 =?us-ascii?Q?mow1Lj8LaUIKfpf8XXefkochabxWtxmEjLSwbHOZUsueb+h6BDVALs244SCa?=
 =?us-ascii?Q?Fa3NENnOvylreQNsn2xysfwQus6DLnwKOgS3JWgwYLtQywFaFfcE6pRN/sPY?=
 =?us-ascii?Q?GNhIRxiyBbBP+npGaCt3iqyUKtpl2pg3WCc/RtBVJrDgqfgMN6qrhZ5CffgW?=
 =?us-ascii?Q?3ZCHxass1Ef7cvzkkvnI3AfZa7JwlTwsVhJGjoTIz8ypd5Js8qltMqpK5N0d?=
 =?us-ascii?Q?uKVO/UDFK8doU79KRs3Gtr3/2MDBMmxA6W+mm4wG6L+RG2F7h5n9t/6oyO7c?=
 =?us-ascii?Q?5j79ly6uA2IlMoO5zC8nWZi88O4CTj7BmigGTPZD44MVSJ2kZncP9dFRuAtN?=
 =?us-ascii?Q?5++jXfB9OzuvoyZMt3naPMtoMBb/0/I6NLx08iHo1y5uxuyBNwT/L5HFvucd?=
 =?us-ascii?Q?oLZpeKja42AL5jNREkDNoIArS7N2Vshh2IpxbFR2z0aV9SjEr6VDWv5a+9bq?=
 =?us-ascii?Q?9l94ri0FbHGdrTEYqk0cCENSsJkMBPHVj+FLD7KPoy3PpMEsVb4a/N70x7o5?=
 =?us-ascii?Q?wx7SQUq3sxE0eCG71FnGBQgGEw8Cvr0TRlH2nYWw454CnTdMSNZJdTV63y2b?=
 =?us-ascii?Q?cGH6n47gI9c15r3UH10xDvZ4YkKxKEI/ZTYkg5WnCi7Ib/x7HabauDQCllBR?=
 =?us-ascii?Q?KutTjNnOeS8y81E1MLwLhoNt8Bfkppk1dWiuudJQmbUpKssU0kPorr6+Ufrt?=
 =?us-ascii?Q?+JcPglu1EQIOQWWV6lj25fPhQLju1j1xe7zkfPN6j0PfSfoRf2jgIWs3eMWE?=
 =?us-ascii?Q?FNNygYlwDZ4rc3fC3o/Y7I7jXB32kgUPp1m4cFhhspkD6hpi+2AFcScvKlmk?=
 =?us-ascii?Q?in9geak7p6OtCw71t9Vy7YrxVFNbjYJQiGmyym7p8GBlRT2G4yGxO8PaX7La?=
 =?us-ascii?Q?FM5hldsO4wGNYxHnz6l1FrsRbRSnb7XB54JAatzQq1MN+Alafz0g6OhwUTKy?=
 =?us-ascii?Q?obG/R1VXpE9t0ljP7yr+JYgW5+JYbweeY0OHxGJx2HvZlap8CFBJZd4u/Y+T?=
 =?us-ascii?Q?OyGvd3q2Q2QrlxkoKwQZqH6k7KxkS5uaS43rCWi3g0cXX9CXAU1/Ul5noEZZ?=
 =?us-ascii?Q?czhAaddlxYoS5Ch6N/1JmzamD3mrPZwJQ2zTqWWNYqx8I4OHf412j+YnpDwZ?=
 =?us-ascii?Q?cqThhBoRYvpvpscAHHTnIEWAuGqFuIfl2mvPlGpA0m6iuF1yqbCfaKJ5+5Kx?=
 =?us-ascii?Q?HuanejrCMnmqagGMeYlEnMqwZemf/K/mpF9iXU/lGk+CEc6Ua0JlMhB1lV/R?=
 =?us-ascii?Q?1LUgF9Sw+a5stEroc/EVdpq+XLfgwKcFwbd0CN5cFCdNm2svK0ybHtmvh1uS?=
 =?us-ascii?Q?M4alSvXzMOoFuk7h1ODTvBSndUhx3UCzMgeSTgKIDNv+wPL+ODfpfQknQFi2?=
 =?us-ascii?Q?AXCqIrSkhWgWVdrluABKxtiJ5j/e6sr5pwUwlgvV8iDyZVbKQ0LNIXBvlxrP?=
 =?us-ascii?Q?JRNGUUgpb64y/iL6rBP+zpdIrcjmR5so3qQbNhTgEueSoptyUxaFR4wt5M/M?=
 =?us-ascii?Q?YwLlJ+YJ1SFldjhhOeoEUlskTnyoc1aonRKtFGzSwZuYc6FZ2iwSYIRGrsfm?=
 =?us-ascii?Q?AqWB4hA/G42a89prmZ3K5A42YspWBzBsjunT9yBQokQ70MrxLGIX6EtpfSTM?=
 =?us-ascii?Q?fvoLcXWhBicifohCZ3lKihYSZy/hA4neb7iHSQdFAWJ8qu8kNUfl5PWg8wBD?=
 =?us-ascii?Q?LK5PT8tFkw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f217b3-91a4-4d38-b2d8-08de9a93237f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 02:03:08.0958 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yIarYJHSbjDECIxk36U3WvSY4pWosW5/l3p72pjGtebsK6KFUzx5Btbl99oe8URAnLG0+hS/L7Ikg5lKzi9y+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR03MB7596
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

