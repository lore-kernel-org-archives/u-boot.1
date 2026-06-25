Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0AD4CDE002
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 08:09:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 721F2847C8;
	Thu, 25 Jun 2026 10:09:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="tvQf6ESU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B06EA84949; Thu, 25 Jun 2026 10:09:48 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D05B84704
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 10:09:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i9QWAZ2YAjKXwqXStWBzlOejik7aq8egPPW3UhsnQyW6yRMV5u6O83zgyM/RmxhYZg98o7ThikE4bBgI1zUhAQ1yoRTU34/uYuJ+CANy7CyNEwLBy/BaVnhcafUbCc0/dFS1ZgJ4FUTmmQZ8pnkx5/2vxKzypGAIqXJGo1vDLwn82gRoK84JSrIxyubK9h6y7Ase4+IPmpU6Qccr1lXrLpNI4/uJ62/NHasanN9ElThwViXex3AAh05kDYRgM8nEUl/zSu7MOq70gsGiGoot0820E0AYvgeFkQfSrCUPfPgiyQuIqGBApDC7V0qKP7ME+rs0lx5QW23oITrvUM2Vsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjOHXpHuIbtI8T32mDudQHLXQ/LFeQ37wH6stn1qYGs=;
 b=DKRB1IaL1A3LgRsJr6U+qE8AiCnVpoZA5Can25XxzVdRPihLb52mGJVagVr1+PKhmpCLw51fz/dFQUnbovn1EZuYYedRkh1WjNMputaFcbwE5ryZ0xVwgREMlNuuCu+81R7E0xeLSto1Xkqwk/MEJAOGb9tmn9lI5k5uNK6mvTWwMYJp0XYMfAq3Z7IFb3KuOQ4gMTMPBw98SDf+6Mtg8ZxGHLgPllhB1GDz8q16ETOHM2ZPfi6qm55vbB0L6bp1MlUYWjk2K/hIVrm3GbIZRu0ApQLYnphXU9YB8MmVcrcblBQaLjowW1giOW3Q6DRKSpAoMWW1VGMfS0cqbUBwLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjOHXpHuIbtI8T32mDudQHLXQ/LFeQ37wH6stn1qYGs=;
 b=tvQf6ESULnbO0rwitwdC2672SqPYFxDDfC5hnfb0YsUvYeBojr04Fk1iEjDiv7YTOMC3ahmAsRnJvOWrOglUs/+ScbdUNZ8EuYkSDP6RPrk3AOHobEKlp/bSbDuZDyl20bxSkx1gM4FHL9EE6nPekZI69/Ubtzs3g94mpyyDHytrfVsuNHKkSVkLkeHjDiN6TZAcUpD6zOUqTIHd7e4NLWFRiYhFtZANaL6D+MWINQ1EmKT4M86sfTVF02smSDfiyF2GuKru//sX8GJe9TlomDxKJk7YrlCZjfMYUYs6y1SNiAnZVOqs4UIdTQ5ANHlGr35kiTa4/oHB1aCSysHcWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by SA1PR03MB6545.namprd03.prod.outlook.com (2603:10b6:806:1c4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 08:09:42 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%6]) with mapi id 15.21.0139.018; Thu, 25 Jun 2026
 08:09:42 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>
Cc: Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>
Subject: [PATCH] arm: dts: socfpga: enforce MMC fifo-mode for high-memory
 access
Date: Thu, 25 Jun 2026 16:09:02 +0800
Message-Id: <20260625080902.17289-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0169.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::24) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|SA1PR03MB6545:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e476236-3481-4d2c-b8f1-08ded2911c41
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|18002099003|55112099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: rnCi4E7nkltz8f19EIliw0Upzr9gRwArnbpOuAv84nsxN94EZdCZT7dp3DcpK6Y9bkiI+2nzrIBit3XGvRea5aKJVMVNhOVuuCPPpf13OgCq6VmW1r3tdFB4IMSXppBFpt95KZvPBPnZ3Tec6znwHTHj24SPNsfy8wAba1NDP6nbq39UF0Z4AiaKHuqck8gHlaRmLQvXux/FWIKR/68IB4akwsbjKQ2udefRj8axM8zW4V6yJ2ClRTI+0anrVssF3UxPWOK1HIvvFa09i6GsuNTguWpWwW4CUANvH2C/6IrezzfH+BI+jTDGwzsotNk1Veew9TPC6uZfkH4/BvtiT6RMpbZYYHezSZz/AAo1l3WJOMZnKnwwoNS4dLS+t4wUTQ42aaPVNisM4kOhqRI/WRr6pJkIhsY1vOot4BJGVNoScYAsLCTBzNmMi4cfhXjM+iS2MwivXmWYJF2Ts84LPp/bOOAcOnM07dXDe/pFtLid+EufjzxtWC6V8hgl57Jm/bj+j8NY+XLKK7IwDO60fY+q/PSHPvwRURF29LY9TCQY7BKG6hUKGH4mZSI+/0IQmgTu2min5GfSvTiQu5B38+rV46qc6MWM83ckp9n9j846Dgh8pcD/m1YAMB7EgPNjF2V/AJuACyzl8CfYWeYT6Gx26VP/fMg2lgIQsYqEWKY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(55112099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z6zQhMJ3Yj3Vx0JZaB5l40L9PAhhryVyUBn1POqtw0HzTLJrht0Y8e2A8k3f?=
 =?us-ascii?Q?gxFuxQA86KCoEKbU5AHDBeIR2cBFIaGyAzuqRp5BmmilUF3VJSUjcmicuYQf?=
 =?us-ascii?Q?oqynQq39x+a9Tf42v2H+9cXaCZ3Ya/SPbWwIVz+C//f7L+R4NtvcGvTfwJHk?=
 =?us-ascii?Q?0mFn8eiDRsOgeSIuAgFH1yix0oZo8gEBnWK+ej5HCj1ofOjVaM+QWYEytByu?=
 =?us-ascii?Q?iegSB+QkHbTX4Y3u/6COM5QJIglk7Mv/2lbwKp2MJ6Q1iCVZlfgYpQ17LqbE?=
 =?us-ascii?Q?UAri0U00GsLdfPPw0Hzw0AKOGqdBmc3buXx+MPDW/d5pUGaGmVHJK+lfSytC?=
 =?us-ascii?Q?VGKNySfdjjqZdhipBoDfuljMYbE8SfabJ608XKrA/BcpEr2ea07SRpzbc8r5?=
 =?us-ascii?Q?FHqErR6kZfHJgCvfenmTiou6ngLK7oKe2tb4aaWbCA6mtmR9FGrdts0r54s5?=
 =?us-ascii?Q?2kcMGlsJnKodjgFxurfiqqjL0o0R9QIEsbTNgTTtABBOXDKIb4V3XUwG3cqd?=
 =?us-ascii?Q?ilt/B/zB4b/kR4QgPHhxx2PSGnafIEK5IK3lJlfFV630cvnIGeRtozXf99BI?=
 =?us-ascii?Q?BBNJuCfpXUoduWr2zBjYSEn9tVRvgd5kP/uGXKVY/Q6jygKcIk4p0rqSoGSb?=
 =?us-ascii?Q?F7mOfwye9mjkUMr0eOdXo4ciHxzzKQ7yz6cYcxGcXwfg9fuezvFVRFW61ks+?=
 =?us-ascii?Q?5zDf/n1ERGS/1CsdvWefUGEbooYUZcGtuZN2RVX5vWMyxdT+lftfodQ1p6eS?=
 =?us-ascii?Q?oUxmJmSG7YIY3lcFyqp1Wd8qkNIDdYKplzV+hP1x1kzD0eh/RVPPWDiYXcCp?=
 =?us-ascii?Q?5tQZ7pXd6UyuPfl4n7xC87Mo42fp7/Y/0ZKsQ4VuayOp8S66VnxluZLFTfPe?=
 =?us-ascii?Q?2WJPz14PfO2HkTMNg/KI9jVifclDegWvSsmbrb8w0tDQ6TtbrR8ene1oAHcz?=
 =?us-ascii?Q?eGE8ASol4i+EMRlDnEnZg35Y4mzOP6U7UulDsmbr4kBvefHVz4223ogfmOe5?=
 =?us-ascii?Q?MjRuc6oJ5Avy+CC3Q4UBX22gITq0PA0jBWf1woNZhKOA2kIattnLN54NNoP1?=
 =?us-ascii?Q?r6lg/E1/N4akMDw0QzpMlwj4j6xbP0jLRNRLoVwU3d8+FKSQMjtrxs4nx7/0?=
 =?us-ascii?Q?76qBlo4HDj/UetHKV7g4Pn/cT0Bsz/Qk7FkHuXRF5zTS7M9Y/VKud5F7JYjD?=
 =?us-ascii?Q?W35VIKHKeTVu3COqm+JmK5qvvBbsMvmfTr+rNFLqiS20KcOPzfwXkKYZ9zQQ?=
 =?us-ascii?Q?EP8vQIMdTh7J0Dc44mRSPCPGDmRdneDgxoYAuOUb3YarhZIHHOHnEqbEwAbF?=
 =?us-ascii?Q?fN5Zr2Yxwz7oeyapTo25ouh/x5HJVd9qAtR3VX4PL7J5RsEInWi1nexwitH7?=
 =?us-ascii?Q?E6lqAwZin8fTCExsBXkA65mNEkVqH95RcZ/UzZ4lIY5t/TGRxlxXJBKYJlee?=
 =?us-ascii?Q?Uv2eDowghYGcGsz5VOpaiGof5zDC+71DBCf3p0rSwgHxld8WhRqe+QZ4SoXX?=
 =?us-ascii?Q?LfSf6kH2Kl8/zVLXjx6Bk+wqJNsUXVmU4jsTyCvA6NexqERkKKgaBmVHAZI+?=
 =?us-ascii?Q?D6+VtAGlXHrDvLb07Bsp02cqeXoom2R/z5xk8sGtImKncNpJVI9Zd8qJUxuV?=
 =?us-ascii?Q?PDJyrxE0fzX3XROZXWNeArqcMql+hMN1vw0+JpJSxVzJdik5Wy28tUue3GZy?=
 =?us-ascii?Q?dPhniHniHzezxYWGE317364bDmWH+0IQ8Q9vsJbFyTmGHqttktnSinqUBU1M?=
 =?us-ascii?Q?kM3BxrZjYenAfwqjdlO2f8RoTNW6Bns=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e476236-3481-4d2c-b8f1-08ded2911c41
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:09:42.3845 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aXmkS3QQ+NwkHeQ6th53qIv/Bt5N+E1vOfo8yEIW5/TEMJ5kP0uSakVyfF2+F1vmnBRO1XEipiqTlTY9nwAmL8XC2fEaSPn8/AuwS++coaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6545
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

DMA-based MMC transfers are limited to a 32-bit address space and can
fail when buffers are placed outside low memory. Enabling fifo-mode
disables DMA and allows U-Boot to reliably access MMC data from both
low and high DDR addresses using CPU-driven FIFO transfers.

This avoids future failures as the .wic image size has already reached
the current threshold and is expected to grow further, requiring
increased use of high-memory load addresses.

Applying this at the SoC DTSI level enforces consistent behavior across
all SoCFPGA-based products that uses the dw-mmc driver
and ensures reliable MMC access as image sizes increase
and high-memory buffer usage becomes unavoidable.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 arch/arm/dts/socfpga-common-u-boot.dtsi       | 4 ++++
 arch/arm/dts/socfpga_agilex-u-boot.dtsi       | 1 +
 arch/arm/dts/socfpga_arria10-u-boot.dtsi      | 4 ++++
 arch/arm/dts/socfpga_arria10_chameleonv3.dtsi | 1 +
 arch/arm/dts/socfpga_arria10_mercury_aa1.dtsi | 1 +
 arch/arm/dts/socfpga_n5x-u-boot.dtsi          | 1 +
 arch/arm/dts/socfpga_stratix10-u-boot.dtsi    | 4 ++++
 7 files changed, 16 insertions(+)

diff --git a/arch/arm/dts/socfpga-common-u-boot.dtsi b/arch/arm/dts/socfpga-common-u-boot.dtsi
index ddef9a2896d..934f2bca505 100644
--- a/arch/arm/dts/socfpga-common-u-boot.dtsi
+++ b/arch/arm/dts/socfpga-common-u-boot.dtsi
@@ -33,3 +33,7 @@
 &sysmgr {
 	bootph-all;
 };
+
+&mmc {
+	fifo-mode;
+};
diff --git a/arch/arm/dts/socfpga_agilex-u-boot.dtsi b/arch/arm/dts/socfpga_agilex-u-boot.dtsi
index c0f932d0e11..3e98288af0e 100644
--- a/arch/arm/dts/socfpga_agilex-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex-u-boot.dtsi
@@ -104,6 +104,7 @@
 
 &mmc {
 	resets = <&rst SDMMC_RESET>, <&rst SDMMC_OCP_RESET>;
+	fifo-mode;
 };
 
 &porta {
diff --git a/arch/arm/dts/socfpga_arria10-u-boot.dtsi b/arch/arm/dts/socfpga_arria10-u-boot.dtsi
index 2ed532ffb54..a5244706bad 100644
--- a/arch/arm/dts/socfpga_arria10-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_arria10-u-boot.dtsi
@@ -53,6 +53,10 @@
 	altr,sysmgr-syscon = <&sysmgr 0x4C 0>;
 };
 
+&mmc {
+	fifo-mode;
+};
+
 &i2c0 {
 	reset-names = "i2c";
 };
diff --git a/arch/arm/dts/socfpga_arria10_chameleonv3.dtsi b/arch/arm/dts/socfpga_arria10_chameleonv3.dtsi
index 988cc445438..d5ec609d98d 100644
--- a/arch/arm/dts/socfpga_arria10_chameleonv3.dtsi
+++ b/arch/arm/dts/socfpga_arria10_chameleonv3.dtsi
@@ -73,6 +73,7 @@
 };
 
 &mmc {
+	fifo-mode;
 	status = "okay";
 };
 
diff --git a/arch/arm/dts/socfpga_arria10_mercury_aa1.dtsi b/arch/arm/dts/socfpga_arria10_mercury_aa1.dtsi
index fee1fc39bb2..a5134557f1c 100644
--- a/arch/arm/dts/socfpga_arria10_mercury_aa1.dtsi
+++ b/arch/arm/dts/socfpga_arria10_mercury_aa1.dtsi
@@ -65,6 +65,7 @@
 	cap-sd-highspeed;
 	broken-cd;
 	bus-width = <4>;
+	fifo-mode;
 };
 
 &osc1 {
diff --git a/arch/arm/dts/socfpga_n5x-u-boot.dtsi b/arch/arm/dts/socfpga_n5x-u-boot.dtsi
index e27a64651e1..bb97412dcab 100644
--- a/arch/arm/dts/socfpga_n5x-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_n5x-u-boot.dtsi
@@ -92,6 +92,7 @@
 	clocks = <&clkmgr N5X_L4_MP_CLK>,
 		 <&clkmgr N5X_SDMMC_CLK>;
 	resets = <&rst SDMMC_RESET>, <&rst SDMMC_OCP_RESET>;
+	fifo-mode;
 };
 
 &pdma {
diff --git a/arch/arm/dts/socfpga_stratix10-u-boot.dtsi b/arch/arm/dts/socfpga_stratix10-u-boot.dtsi
index 3e3a3780469..109ca41ee5c 100644
--- a/arch/arm/dts/socfpga_stratix10-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_stratix10-u-boot.dtsi
@@ -6,3 +6,7 @@
  */
 
 #include "socfpga_soc64_fit-u-boot.dtsi"
+
+&mmc {
+	fifo-mode;
+};

base-commit: 70fd0c3bb7c26d42f24d10145dd5f3168ac92eac
-- 
2.43.7

