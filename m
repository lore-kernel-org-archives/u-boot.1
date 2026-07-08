Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAFE2C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 12:42:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D319284A9E;
	Wed,  8 Jul 2026 14:40:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="kE43+DsP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE7F484118; Wed,  8 Jul 2026 03:13:53 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FA8C838D7
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 03:13:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iEQCudU5Rb/rz/mzCt/cHuJLxAzE0/+R5vup/7fkhvxkOa+cv9u/FNOVBIix2szV8mkPWvqmruoNUWnJWjCcd4w9vkmqiMQXGsKQSc1jP9IK92U6f3zwtsHhMO2g7V0bMzJn9BNFa0garJTgtBppStMu4a4L3UfwuLCYD52Ajd5S8AeabLc+slRZ5clCjC6aPrUuYKqp8l6li17nSG3thCJo2cRqVMoQQztpWi9XpC9PvSeXMCn4hteK8HfdHX7ByqZORlbg9hwMkj3c5vYJDn7pO0TTmNBf1oMu2K8vdpZmQy0pedeQDe9AedIDtE5n39EZzW8EKQ3JtiQDjMYfhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STd0ONaheOAq4/eOXR+uFpCX1WEVTCptXnzdOg0LtAc=;
 b=GLVX/5sJeLj8RqLM3UPMn0WaO9tp0Rl5j3lFdAfw6z9ebMNzI35QCwF1Somqdr++stgkWRbc+eydbNfztY+vKqcD73Ump329Xks3uPR2ozusqDHIkhEWeyGjugRSu07OoKpc3yb+nQwq+hTxAIpaUpl+QwgSub8etJwEbv6DpLk7KHzf357D0qjBtLn7ZSZtdSGa20LZpv+LKx/48OqA7bHMJ4j/WoZF5Ny6GyQtM8s1ZvYIJj6+WA6aGGml+djQ4doZSHpdAAVaTf1iV3dtM9dhxl10Tgb6r6nIYTSDIEnk9L0qXlHM0Jovldb9DxRYbODSdThyw1tvwEzmA6faEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STd0ONaheOAq4/eOXR+uFpCX1WEVTCptXnzdOg0LtAc=;
 b=kE43+DsPuKRDtNrINALCleTa56aLjldW2mLdKJiSRCgDqGQZqmVOMVLSR/FhgNjpCJeG8bpWPlCo4mEzhx7GiFetlafIOHkRL9+9ZkaP3iCt/VGerGbWZNZQT4XIRGOF1pJCwL+HDJ35l4CkFB3WZurp3Sbgn5BeOv/3N4V68nX9UqxRAH6+WvAUVb3ATfFSL08En3jsdlcC1G5hYD257/75z/q3/OW/F3KgdpefUX0X0hvt0fcnaflvXqa/EfV7b+UM2ihkTPgR9R2024Yuy3mMeHMnSoBtx7wMIf+3nsJMNcVc8xspD3B1zvQxQX4BIfvxxPlU4zsoui//BZ3J1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by MW4PR03MB6473.namprd03.prod.outlook.com (2603:10b6:303:120::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 01:13:48 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%6]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 01:13:48 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH 14/15] ddr: altera: n5x: reconfigure DDR when mem-clk handoff
 changes
Date: Wed,  8 Jul 2026 09:12:27 +0800
Message-ID: <20260708011228.15613-15-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260708011228.15613-1-chen.huei.lok@altera.com>
References: <20260708011228.15613-1-chen.huei.lok@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0062.namprd03.prod.outlook.com
 (2603:10b6:a03:331::7) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|MW4PR03MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: dcf342a3-ce28-45f7-7719-08dedc8e29b9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|18002099003|11063799006|55112099003|56012099006|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: ruTkxg+Gtd360cHfDmZ7gsmZyKWpD5C16i50Mzy+qY/AqA71vZhzF5TFdkpx2XVkhxONiCkKoVwmTxBadJYhWkXTBqlMCsTlCb9KU01KZsgEBWC1LIY2WkIDjOnoBon+PfSDjPujBJ4k4iOBhX5eZWCqvfbhEqouDSbBezCRLzWBTHcGdhpqL1nsUo3FVL+Upqq/PSV1AgeGUc5IU1ZM52R1vY7jorRGOlQQwr01F0vVWU8NB/p/mVy1eAGBdu4KPy/Gtqrpem5eKS4bCNbkPEYgMsnskIuUE5q3SjPJ2dJJpnP6y5O6EFxyjuquTfpJks1FrbjG4IfOTyI+UE4tujG2jLRSLrt8kNRFwRABSuNZRzHCMyftMsiqMYwyAGwMQUHIAvFdSZVrw8d+1pp+t79j9SrJjIG+yjDh6t1mzUfPe2gi2yPFa6numaIChR0snz8AlzcvUZA7Z8q7D973o5urta0Wpq5v2joQI0vOCN2u6w9xAR6NVScuce6/BCgv6qdrHXM8o9lgGcVBLCqzT9a1iUV0IFD34wIxjPyLS/hOHGszVIy9CB4yHFxgwuJeLKlBfmknCs8gDv0sjP7IIqQRi0u73GYMpHOLRAIh63OdD0z265GsQvkmdxr4qQlLrHUb3S14P/kArtuWrp3kq3yVNeIBzXLyygEKh/OvGoU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(11063799006)(55112099003)(56012099006)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fzqF3yG4HaRjzurpkZy+ZRpb4yKeZRotw/+0BWprw7GLtpeYDDExHjqV7GIx?=
 =?us-ascii?Q?mp50Iym3dwOvhFL3yyAsK/7N4zLNuCTjFOcCWO2M1OFv9I6jB2LuVd2H0+cV?=
 =?us-ascii?Q?T9KA3ihZ2JBFBpCL3sQRP8PlB5yK0t/2ri3qGroGJVTk93se100+kZm7LmOE?=
 =?us-ascii?Q?kwsOLUDTX3TsiePvio1BK+QJvKE/vH3DemZPCukaPHtyuvzNVPOOYGmua03f?=
 =?us-ascii?Q?SQ3EnZCmX3R3dRMXWj21/mA1v44jhG/KxCWl/3U/E1DDvIeWZZci+H9JBdzK?=
 =?us-ascii?Q?LcoY3YHZz5oaNKYVOdJL1KcJ9Aa2gJU297ZpL5oSYK6SfZVAuqFV+c+qGvV6?=
 =?us-ascii?Q?vreyEOjTEIqV4PEdQCP5uTZIe0Sj6GloL2r2kBuw3mDQwRAfjEhx3ConHaFn?=
 =?us-ascii?Q?svLIsOBpCf2V7oL6pq4M7UtKA5RO9h2aGUGM3dFRPHKkPeky0G8Y7DvBiRew?=
 =?us-ascii?Q?KTZQokG6HtM/2AvpuV0i6w6b6lnCTy7oe4s5esYsSPKSUp9DOcfgUmcj/55w?=
 =?us-ascii?Q?SbjzR4XGKx5/xSyEJfQdSaeEz4pjNNh06dJYG3ind4UYND8miXxdqn+lcKLc?=
 =?us-ascii?Q?yYWlFiE340BQCqt53rDV0D31/HXMjeaLimeyMxQ37AmXpTVb3JpvlwW2JQz5?=
 =?us-ascii?Q?XnHf00H5n68nliJjjXR3pkz3SlooDn3fHgCBJ8TKdEab5OBoSkO9hojb7Bvq?=
 =?us-ascii?Q?63r8DNGM9Dk9DlUvlV3e/jSjbnQ2fk4qTCMI4i1aSGg8KgMc4JRlhmpgAXtQ?=
 =?us-ascii?Q?Z0KICpyNe/wUhfCZlU8LBaFKEwip2Buw1I0cLFb+cYsg7jL9IstlYBT3u+fO?=
 =?us-ascii?Q?mIqtP6c9wxutKL5URWo6PLdaeee34/0RWxLMHrAKx/v6NB8Wt3xSTJtk0D0Q?=
 =?us-ascii?Q?EikBrDgjN620q6O/AfwxGzlkSzSPgCDydsxBUHiDBe8QT0IWm4vWf48MJdkL?=
 =?us-ascii?Q?FOuh/swlY2D8JcW1auT1c8xZ38ByvITyxyI/d+WiRx+ljBe4SkK0aMQKlEii?=
 =?us-ascii?Q?nbtUDtaNmJd0NZ4pQC10KwOqFAUSNVVLe3ZO7oABg8Egj4dn4YAOiqVFnFYI?=
 =?us-ascii?Q?xECDKdbSETfg1eWVxob/FwqkVn7q6Bp8A2JxGbteUrUS/kI6MtBDivtUDqdR?=
 =?us-ascii?Q?ejswyGRMBIYdXRHjlkZ/YPATQz73F2UL/45jNW2P8YpCSnaEKdIgNB9nki1V?=
 =?us-ascii?Q?Xlbfd1jNT/4QR3oF10QWG0+rK34aF1ja4GxxC4GynwCNmuhxvXQi7Jjb6F7P?=
 =?us-ascii?Q?0F7TxgSg4aUtdoUnL8Wa8JA/vYzVOz9WeeOVgrZF3R40XHB99MT6bzngioI2?=
 =?us-ascii?Q?Uo1xVibQWS/dGUdo+KhIHPIQ9vmDFikC4AGjRN+MbWSoI/PSsmS16xc3ZVV1?=
 =?us-ascii?Q?Xtn/hUJGFdQFQNx46g05l1vwBwACK8D/Oo3sl/TlVLWJ04zBRkBSYnxiAlEl?=
 =?us-ascii?Q?j/fJ2N0rnlVHzWU1OtslWARz5KBRXccWcEaE60Q6r6AkjCMVbN7ip2DepKLB?=
 =?us-ascii?Q?AB8kZEFpJMUoUKG8UPnE/0toa6WZ63hjp4ukMOR6+ClajPwqhX6dysRgGaPF?=
 =?us-ascii?Q?Cs7SzFRll6Ah4vbCacmvaO5Uu29UeP3TB5pYoGi2MBm3ZEvF9rNxM3Xa95cT?=
 =?us-ascii?Q?8I+2+6csONpbqvYi/6RPMj6k0DK/Mip+GvHBunrUYV6N5gX5v41Kw8aIW5Ll?=
 =?us-ascii?Q?GlMG+RAMq10KS6lZr8yTTLkDJKDc28aS85XRsYCjvAufTz2vJQ9GzY8j4mp3?=
 =?us-ascii?Q?5BF3/YrxE+/M2UpF7j/PTiKDg4JsTPo=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf342a3-ce28-45f7-7719-08dedc8e29b9
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 01:13:48.0116 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JYW4oCNkaVUhZtBL4ReqQ8A0foTT8qLyqJ6XexBCeE7KsJBJfzITxWfBmubfVQYsjpC+0oS3+ZQ9rH6Ewfqm52TSLSP8A5ySR+yFBAyxyWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6473
X-Mailman-Approved-At: Wed, 08 Jul 2026 14:40:34 +0200
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

Trigger a DDR reconfiguration when the memory clock values in the handoff
data have changed, so that a retention restore is not attempted against a
DDR configuration that no longer matches the running mem-clk settings.

Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 .../mach-socfpga/include/mach/handoff_soc64.h |  1 +
 arch/arm/mach-socfpga/wrap_handoff_soc64.c    |  8 ++-
 drivers/ddr/altera/sdram_n5x.c                | 59 ++++++++++++++++++-
 3 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-socfpga/include/mach/handoff_soc64.h b/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
index ae5af1f0100..0fb43acc98b 100644
--- a/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
+++ b/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
@@ -47,6 +47,7 @@
 #define SOC64_HANDOFF_BASE		0x0007F000
 #elif IS_ENABLED(CONFIG_ARCH_SOCFPGA_N5X)
 #define SOC64_HANDOFF_BASE		0xFFE5F000
+#define SOC64_HANDOFF_DDR_CLK_HANDOFF	(SOC64_HANDOFF_BASE + 0x610)
 #define SOC64_HANDOFF_MISC		(SOC64_HANDOFF_BASE + 0x630)
 
 /* DDR handoff */
diff --git a/arch/arm/mach-socfpga/wrap_handoff_soc64.c b/arch/arm/mach-socfpga/wrap_handoff_soc64.c
index ecde90f76f4..bd1160f55bc 100644
--- a/arch/arm/mach-socfpga/wrap_handoff_soc64.c
+++ b/arch/arm/mach-socfpga/wrap_handoff_soc64.c
@@ -27,7 +27,6 @@ static enum endianness check_endianness(u32 handoff)
 	case SOC64_HANDOFF_MAGIC_IOCTL:
 	case SOC64_HANDOFF_MAGIC_FPGA:
 	case SOC64_HANDOFF_MAGIC_DELAY:
-	case SOC64_HANDOFF_MAGIC_CLOCK:
 	case SOC64_HANDOFF_MAGIC_SDRAM:
 #if IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX5)
 	case SOC64_HANDOFF_MAGIC_PERI:
@@ -35,6 +34,13 @@ static enum endianness check_endianness(u32 handoff)
 	case SOC64_HANDOFF_MAGIC_MISC:
 #endif
 		return BIG_ENDIAN;
+	case SOC64_HANDOFF_MAGIC_CLOCK:
+#if IS_ENABLED(CONFIG_ARCH_SOCFPGA_N5X)
+		debug("%s: mem clk  handoff data\n", __func__);
+		return LITTLE_ENDIAN;
+#else
+		return BIG_ENDIAN;
+#endif
 #if IS_ENABLED(CONFIG_ARCH_SOCFPGA_N5X)
 	case SOC64_HANDOFF_DDR_UMCTL2_MAGIC:
 		debug("%s: umctl2 handoff data\n", __func__);
diff --git a/drivers/ddr/altera/sdram_n5x.c b/drivers/ddr/altera/sdram_n5x.c
index f7a26e07cf0..bfa08f62ad6 100644
--- a/drivers/ddr/altera/sdram_n5x.c
+++ b/drivers/ddr/altera/sdram_n5x.c
@@ -38,8 +38,9 @@ DECLARE_GLOBAL_DATA_PTR;
 
 /* DDR handoff SHA384 attribute */
 #define DDR_HANDOFF_IMG_ADDR	0xFFE44000
-#define DDR_HANDOFF_IMG_LEN	0x1A000
+#define DDR_HANDOFF_IMG_LEN	0x1A200
 #define CHUNKSZ_PER_WD_RESET	(256 * 1024)
+#define MEMCLK_HANDOFF_SIZE 0x2C
 
 /* MPFE NOC registers */
 #define FPGA2SDRAM_MGR_MAIN_SIDEBANDMGR_FLAGOUTSET0	0xF8024050
@@ -1106,6 +1107,28 @@ static void phy_ocram(phys_addr_t phy_base, phys_addr_t phy_offset,
 	}
 }
 
+static int populate_memclk_handoff(void *handoff_base, u32 *mclk_table, u32 size)
+{
+	u32 length = MEMCLK_HANDOFF_SIZE - 4;
+	u32 offset = length - 8;
+	u32 handoff_table[length];
+	u32 i;
+	int ret = 0;
+
+	ret = socfpga_handoff_read((void *)handoff_base, handoff_table, length);
+	if (ret) {
+		debug("%s: handoff read failed. ret: %d\n", __func__, ret);
+		return ret;
+	}
+
+	for (i = 0; i < size; i++) {
+		mclk_table[i] = handoff_table[offset + i];
+		debug("mclk_table[%d]: 0x%x\n", i, mclk_table[i]);
+	}
+
+	return ret;
+}
+
 static int cal_data_ocram(phys_addr_t phy_base, u32 addr,
 			  enum data_process proc)
 {
@@ -1391,6 +1414,11 @@ static int cal_data_ocram(phys_addr_t phy_base, u32 addr,
 	size_t phybak_num;
 	const u32 *phybak_p = phybak;
 	u16 *data;
+	u32 memclk_table[4];
+	u32 size = ARRAY_SIZE(memclk_table);
+	u8 *memclk_hash_offset = (u8 *)(SOC64_OCRAM_PHY_BACKUP_BASE - SZ_1K);
+	int ret = 0;
+
 	struct bac_cal_data_t *cal = (struct bac_cal_data_t *)
 					((uintptr_t)addr);
 
@@ -1425,6 +1453,17 @@ static int cal_data_ocram(phys_addr_t phy_base, u32 addr,
 	};
 
 	if (proc == STORE) {
+		ret = populate_memclk_handoff((void *)SOC64_HANDOFF_CLOCK,
+					      memclk_table, size);
+		if (ret) {
+			debug("%s: Memclks config Magic Number miss match. ret :%d\n",
+			      __func__, ret);
+			return -EFAULT;
+		}
+
+		sha384_csum_wd((u8 *)memclk_table, 4 * size,
+			       memclk_hash_offset, CHUNKSZ_PER_WD_RESET);
+
 		/* Creating header */
 		/* Generate HASH384 from the DDR config */
 		sha384_csum_wd((u8 *)DDR_HANDOFF_IMG_ADDR,
@@ -1455,10 +1494,28 @@ static bool is_ddrconfig_hash_match(const void *buffer)
 {
 	int ret;
 	u8 hash[SHA384_SUM_LEN];
+	u32 memclk_table[4];
+	u32 size = ARRAY_SIZE(memclk_table);
 
 	/* Magic symbol in first 4 bytes of header */
 	struct cal_header_t *header = (struct cal_header_t *)buffer;
 
+	/*
+	 * Read and generate the hash for the Mem clk values and store before
+	 * calcuting the HASH384 generation before Image.
+	 */
+	ret = populate_memclk_handoff((void *)SOC64_HANDOFF_CLOCK,
+				      memclk_table, size);
+	if (ret) {
+		debug("%s: Memclks config Magic Number miss match. ret : %d\n",
+		      __func__, ret);
+		return -EFAULT;
+	}
+
+	sha384_csum_wd((u8 *)memclk_table, (4 * sizeof(u32)),
+		       (u8 *)DDR_HANDOFF_IMG_ADDR + DDR_HANDOFF_IMG_LEN - SZ_512,
+		       CHUNKSZ_PER_WD_RESET);
+
 	/* Generate HASH384 from the image */
 	sha384_csum_wd((u8 *)DDR_HANDOFF_IMG_ADDR, DDR_HANDOFF_IMG_LEN,
 		       hash, CHUNKSZ_PER_WD_RESET);
-- 
2.43.7

