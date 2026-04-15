Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FFD4FA0C22
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 04:11:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0E518421D;
	Wed, 15 Apr 2026 06:10:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="n4LkG+em";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE21B83936; Wed, 15 Apr 2026 04:03:14 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCC2083BC4
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 04:03:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tze.yee.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=scHhp2Un53g2LpzEB6hdOmgbWV5r58H3+Za0rDI/iW4QXiM4/4Ghx0TK7MG7EDY/qjin/k3SmE7BXpFX3xbreAUn+AEUPOYWMX241wJ368qOClU8uBUlXjj4wMiPLExZhjo7n1zu5ncnGf/iDAHk3lKIfEYSwMLO3QQnfF039shP7HY3VpZXZ+PXdGMhAuDnbb9M7Ifuarejp33Iew4RlbFVzvnkFOetCAv0Bp1+uSr5ZpBrBuLBi5Ed3VQi5hFuxpP37IoHktARvSmN4M5A3ZNACXVVLyiKXodiVKCSPPyIiEk+luzJm/MD8lmfXe0Rp7R8RxKv+CkIgX46pxj/yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=469dKHT7mEvnzoJerpPDTIXEsO8spIKvt14Nmx3Q7Dg=;
 b=mptLlXMKRg/rm0HDkr8LEvhgUXMleStPqXalENbtdP9WkieuCBbtwOKjkmcG/VofL8lYV3bVBZxaB00HPjQRqbsg88hsCbN1Xl6LChhwpWgAkkppP/cu0H3xC/ov4H+yHetAo5Ch+orM5W2YWqDAr/1iEouYeDMJaAFQ20hLfvfBBEZW+hs/jE0YSE2gpbwldnhfyryJqREasV73gSNPCsZArvm22S7wo3mCbDnB41AXAO+LbC4mlvTXMl6kfOM9iqgodp7u2VLBTm0MsAipdlSoDBt6idZVo9BDAe9WTKomjBah9wAIZ7P5FwXCdqEwfWeooGieUun6pmc5xcNcpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=469dKHT7mEvnzoJerpPDTIXEsO8spIKvt14Nmx3Q7Dg=;
 b=n4LkG+emibiIrHXmLHiS3FojG15eb/CwTVZbS6Zv7W4vcwzxfDiKfZQE94MFL0TVijtBtrdwN7ZN3y/6ipTNtXn/ZmeZXozJJ+SQSk4TIS+t8fZuDsfFeyozZdobnTEktQym5DMPfpts2d50B57l/laA2jXsPLCZobDndb4ie+Brlj2P4NjauufFVw7K+YSXzA8zZflZwyfzSd7VrcC1i3RdF5E7U2FjkJu1Xc9gr6D48WwGjVrxwo+acNtv6MXC63t24a1Smf3Hk7W1QFInC6C9fkMK5Yrvhwl8RMZqJwY2USmimeXojapj7CyJGteYfJEjZKJmEHHs5CFtPiPepA==
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
Subject: [PATCH 2/2] arm: dts: socfpga: Remove SD card properties from Agilex5
 eMMC device tree
Date: Tue, 14 Apr 2026 19:03:06 -0700
Message-ID: <90dbe9fa1a16de9299987105e38cc29b5cb3d18d.1775640837.git.tzeyee.ng@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8f46c17c-875e-4ee1-d70d-08de9a9323b3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: EPgDF/cFdpEweE+GkRIjUapmpNK0dNan/vH+uLTgLF/j4OHm5/U1RXqzy1A7es13aFmki2CMuwMctUH2Pj3q//2nVUXm5eZeLtYDtYiFSHKykpFD3HJ6D8EVSwDlnSr1wzCRbs8xlFsFXVzv6ntSzFK+bYXToOOx0cIKemMmRf9ufNlSfDxd0tl+RZ7szFMof3UYG/QLPlWiuo9pLNHZ3OKi6aDQc5swkQM3HYpuIVaPruR41PACp/5Z2jGoQ4AWdHSJvHpsPNdZziHmSS/Tjk4fIaglCBzsnBFn8Mo91k+5MSpD4ksZRJnZRtkcXgU5pOP3mYd2skGU8u2LI8Q6b+TQPBnmt2WqiVSqVJ2l3hF6rZYzQEGqHdcqPdM4WCR4IJ3VSeQE7vBsW2xH2H6xwHhIFnoH04lLqpvJAjKj9cDS0GGqALMa/8AtjU2hlLAHCkdJm1Z3YSlGbInG/pVtATdNqElh/CrWikJ8+j5z7gwxg40ipKJZm6fqw+xpfXG63dgVBFRTds5yBo8s+GKFQ0SmC4TF6dqalXhopyvhfNFp807s9PvGsy2Ip/uVYqOGVqVr1McBSes4c4uO/AcKCCg4CsCY1t2jT+v/aw1+L4UlJlwmgRXLu0q7I6I7g5kScMtCNs167wkOrQ0VAWiXMwZ8fgfoGFKVd3Xr7BGHA+rdQGQzlVzrHXUlrlo3Jfl9zOnvU4vgEgSMPjfSpu87xInFH/r5vEXVhpLLdXC4GyI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR03MB5950.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a520MjLjgZsbWsp+P8sS+xfqeUmqRboEgmdvUIiYkO/fp59qJDdzvYiynOf8?=
 =?us-ascii?Q?yVPeuL8M7zKAEucflX3WJpVg9eCd/BGC9kie2ZrMSEbrBvhlN+hI5XdN2vt5?=
 =?us-ascii?Q?YTcrHAc1VLmr7hRlR9KQb1vTietLsPa8HRV4TK10LWqGISUGY6Tju2NiudA5?=
 =?us-ascii?Q?tH4yMJvdZuGQRIXN3Hh3VrCIMQHaOX+rI4btE7+l1jBSlt1xxv1LKFRz6XCQ?=
 =?us-ascii?Q?csDmW4G3VxDPYrUzEgF5r88sO1f5w2W1NO4nImoAeTbeycifLYlZCX2qrIBx?=
 =?us-ascii?Q?9G4hhSXg8UvEa+ciuQ5q1gQ406LJjm061ZiMo2XAgy6auTEODobF39RNsEA3?=
 =?us-ascii?Q?jzZMaToEwtDy1e1Heq/JDPEXF9bcY02CHJ8cv0tZndabyfwe3xYJfDXBRH3C?=
 =?us-ascii?Q?T4H+4jb2RPhQ81nR8dscSUP2p+JZ81wnXPBKavv4K1GbfI4iP7R+wb9jsctp?=
 =?us-ascii?Q?jxHTutGujbTu8A54laGljy+VfgJJgkuWWv6KLdW0DSvKVttifjMpZ7P0WqUh?=
 =?us-ascii?Q?JbBLR8gTOYy8dH+yz7wXXbAOgA8KG5fym+WKFzDnRwgoEnvyftdwnbe6XhXp?=
 =?us-ascii?Q?GrCArK4PTVaqlVKvzHTUr8zC4iu3DA6L4Mo7UCSsVxNtLzAR8IdWCxf++XRq?=
 =?us-ascii?Q?+pbSI9pgsiUTQS981U6X6kmRfiugBXXDVzGThRB/yBpa4R07jnZSVw2EdioR?=
 =?us-ascii?Q?O4Ocyfj0RDkTOAXUQfyifD4Fp7QVAaOUybbLqF/MYrTYc5DSYTAioS0UsJyw?=
 =?us-ascii?Q?JSsEEPPY6M0gpjAXsyrYA0OyEHjaEkcdlKVX6KpEAPsB4VbD2OSTJuVe3Unh?=
 =?us-ascii?Q?LnX26PEvJ+Z+M+IsueZjiKKZYCTjXw58gTytJN2b1FSLA2yVwLT/0nDh/7N6?=
 =?us-ascii?Q?mTWQUQ7x/cqhBgpWnRrM140ngPXBP1Hab/WJ/JIgHGJA/18mqQfjoDjvJCC4?=
 =?us-ascii?Q?C1xrnAzYkyedheiOjR0n2iP1KTIoaNQF0Kt+WNPZ9kv6f/1b0lQLH1UYg7FP?=
 =?us-ascii?Q?N4S5QbMi8TFp0MArE9XPFyRuZtuAS+Rx1B82IEBfW35VswbDY29L5Nih08r3?=
 =?us-ascii?Q?yCpgNHEm3enu5sAigitmGSUcWmbciIBc/fziO0k0G4G9EYpEpgThjGnNPz9K?=
 =?us-ascii?Q?Es9xkV3R5+9x7+dGuWIzHlqulJsfjDfbNbReGMWm4XUu9sU2piksN4ZJ9AWg?=
 =?us-ascii?Q?LGpQF88o36CAkRneTAZkJaUw2maajvsIuvTL1yAHCjSxGcKWCuv0aqIrR8CN?=
 =?us-ascii?Q?H1pBk0VRMAQ38ipjOnb8IhCNVCGcXfbgGlOWBcecjpq/pjNqAnuWL2g5uPbT?=
 =?us-ascii?Q?r+HHXG11uYCsCCuvGorBbcQb4hLHMWWQLQGFbHFqOuLgxzpKVPCcrEA6yHw2?=
 =?us-ascii?Q?2XscCXetAc6RkWS6EsHTJ6ZAhgNiviPJcQpLUlnT7XHsvJm6bb+cIR0Dkqrr?=
 =?us-ascii?Q?fOhG8N6gjcTaXowgvI+FOhxaKlcogX1VMTldUZ/ZLJPKWeHZFRCwxPNxyKR8?=
 =?us-ascii?Q?Mqvs+SV/eKah3CWETKWf+D/OblUYzZK3JrJO2UDi1fT24U6vD4SYncFd8eO1?=
 =?us-ascii?Q?/gCE0eT4yxNg8DD2cDNR9YLaaWFy67F15+WABPBE4cf7n0F2zLnMCGvtYad2?=
 =?us-ascii?Q?qU+jApGP5/y/kxcYD87uOemVSHrHnYr1k5r0y/TRdDAij0+HmY8yfTikLnea?=
 =?us-ascii?Q?QNzqJh4ZK6qtAQxAEGgUO1jXVcW95d2OllO4lgsu4JA3omSI8iIlOw3rhb+h?=
 =?us-ascii?Q?M+zM+GQoJQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f46c17c-875e-4ee1-d70d-08de9a9323b3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 02:03:08.4134 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: inL1bfK82Pcaw0wsBqdbHoWgHhZ3ElT6vZlFtdjMlPQe2nHxQIXM2j/7e3FUSl2l2DIWIw+TmzN87ho7zXMljA==
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

eMMC inherit the configuration from socfpga_agilex5_socdk.dts, including
the SD card properties.

Changes:
- Remove sd-uhs-sdr50 and sd-uhs-sdr104, which are SD card speed mode from
eMMC device tree.
- Set SDHCI Capabilities bit18 to enable 8-bit embedded device support.

Signed-off-by: tzeyeeng <tzeyee.ng@altera.com>
---
 arch/arm/dts/socfpga_agilex5_socdk_emmc.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts b/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
index c06781064ca..f1e8b737e3f 100644
--- a/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
+++ b/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
@@ -18,6 +18,8 @@
 };
 
 &mmc {
+	/delete-property/ sd-uhs-sdr50;
+	/delete-property/ sd-uhs-sdr104;
 	status = "okay";
 
 	no-sd;
@@ -32,7 +34,7 @@
 	vqmmc-supply = <&emmc_io_1v8_reg>;
 	max-frequency = <200000000>;
 	sdhci-caps = <0x00000000 0x0004c800>;	/* SDHCI_CAN_DO_8BIT */
-	sdhci-caps-mask = <0x00000000 0x0000ff00>;
+	sdhci-caps-mask = <0x00000000 0x0004ff00>;
 
 	/* eMMC legacy mode timing configuration */
 	cdns,phy-dqs-timing-delay-sd-ds = <0x00780000>;
-- 
2.43.7

