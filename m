Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 061D3D1CA19
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 03:45:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D76E188F95;
	Tue,  5 Nov 2024 04:45:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFC1888F41; Tue,  5 Nov 2024 04:45:00 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2070b.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::70b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6080C88F68
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 04:44:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cc86pJt1iJbyTer41NIPi9APYgzYR52W4sdaYC6PYyI01x5OEbU06AcauEwgXvC0pqfTPc5lBpcCltz3BHXEkkIIe6JJy4ZVJCftpf3glPuuUCI9m67N6VLL+e/1P0uhXkaTP8yduiJE8JdUuIx6aE9R7CCtSFMIhoCBu/Dtm9SmNwR6BejeIH2fRFSflJsSLVp1H+0FZWvlHPEX8gV+DEH/CeJ27T3weNAyzH7EuNOS8UqYGHke/Zd/39F7jW4katEbVZOgu6mxmgpfAnyrXjsROtvh23A37yaNoPXSk5hFiXp9g5vhDe78KaE52htyL/ymRjaPW1LjNKA8Cfog6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgNZfR1PuDY2z8jdY1MjEYueLSLuR9eybV9t+jy32Rg=;
 b=Xk16iZS0npihwEFz0muj0rLLNh4hfMWZ2iZpg8u2UAvXInZQzSpSjqJLVq3bEtXVA6uSHGon2hkAGqSCD6Oa+S+cIsB/9wKNyTDSSXAOviUioGys6CSMCWEmq+Xwr+fU743IicAwZ1DFP3Umo0koTqI7ON3UzXPDcozEJi2EdNa4Oqo8kuwNkXAYoaYEA1K9cnoyGb3mmUhVkUe6EgLtG7Z1dauooEv78jDZRRB8PfGtpbR+kg61+Qa2Kz+knYw7vWsv+zeNnyeoKyvUwinjjELFNEZpAhe+1RNu4XBn/e6RhlrQbiHnw11qFd4MmANBfViMZefJ2x80tWbFCjAI9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1145.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 03:45:04 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8114.031; Tue, 5 Nov 2024
 03:45:04 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v3 01/13] dts: starfive: Switch to using upstream DT
Date: Tue,  5 Nov 2024 11:43:16 +0800
Message-ID: <20241105034328.56439-2-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241105034328.56439-1-hal.feng@starfivetech.com>
References: <20241105034328.56439-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0021.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::30) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1145:EE_
X-MS-Office365-Filtering-Correlation-Id: 22917fea-7860-4f60-a7c5-08dcfd4c3bba
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|52116014|41320700013|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info: HxHGNXB95jcS72UBo1HAuznQuhHngFd9C+T4rnzj/RO8Ax1MOGRvPg6/HKpEzf1aDTkKHnUYoSQpfp2/qyltXM5ccM71lHE1unZFhHWMBHyeEkycO9y4wPn1q61pnruFBggx/2MlMM37sBEOoVqwCWSo+8hK9WO8BIHBJWhP2Ji4z2EyFoohOU6ONfNkewHHkaGpiTvlhUXTcPKO3bog3mvnKg0aSEBANrcrzQkh5VvGrr7r/LVKfsY6nHk9KVSrkOO9eTiWKjy/nB262qeejZJsirjAz8I2QK1eKaQqaB3/1uL3yOyCPZzPySItKqdWFybHe0vYpeWICpULDCQIxP8wUGV1Ivl1HaML52Dlv714L0/PkAiXCSTSTGqCCQI87PyO0uY4GMk7qc3/7b+eb4BTvCU/vsLB7pTYDyT/pn8TtgKrIi0rGS3e5k2DnzFR+YcJ6D25eHbxnRw5k7+GRzw09g3TSSol+pk0G/m8ypx3dG1uzPfJxrHUgSvX6/lufTBW3pbSnfUa/cNKCGtDaOGNeDiV2ue6HibXQFKFy+EBpZeC9U6/fKSnb94fosPkJWnu/jyG3G+FvTLsRNm5X5VMzTLBPWd9PQsjGPMg3tRv5vKjZKxOpsBhbpBDaMMdJZU9uc1xAECNp+GSWB7EPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(7416014)(52116014)(41320700013)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t6mLgTb0GRFA/+IijYiBgkMPSukDPrTkGAKhnwBGX97RpxnLfjyankko5tjO?=
 =?us-ascii?Q?w0NCqjuVv7LQSBU9JKPtp9AFQ5RdOyshiUZPCK5u0TwW9rTtBq3DJU205+P8?=
 =?us-ascii?Q?3k14UcnOD9j5aniiEOq5Yh58igskNnkkmVNUdzujNANkQFMf+tt0Gw3KuOXP?=
 =?us-ascii?Q?7XBQflo9suiFvE2BVj0JEqFS++7KCKhoF8JSl0Zn+S/2t0jpkhIuQjvJBrm9?=
 =?us-ascii?Q?EDdAVL/nOPF4gR5mc6YO/b+imLI50YdBPXQlyGHEgRYoJCOCUFfFqIz5x8/7?=
 =?us-ascii?Q?d0FUSFC02hc1TNO+IihH3ILRidLS1qTJddHrp2jXBwM5CmmnRB43ate/BigO?=
 =?us-ascii?Q?QC4PRUFLgvn/9SzPPytyoBWUTNYrGOAtlBfY9JFA+7Yj1fEKKJ6DLZfDOnZO?=
 =?us-ascii?Q?UhuXqLgS55k7/uqwV4Wu0sGNaP0W6JOaGADsKsSvIclRxUHf8hfCNdgUXsXs?=
 =?us-ascii?Q?dYjhxkUW9Jj0on7KLAPChenIA0F1umYWHZptbPvRIYXb+8gDMI7XXd0nHOrx?=
 =?us-ascii?Q?U4ovUtvDAT2yg7t0RFnLDTaQrAJSkU37Y8Rrg33rW5ejI1UB3KnlOQqY84ye?=
 =?us-ascii?Q?d094yx6N7hovOFqle1BN0/JlztY8QYdKJCUaO4AZPAV7Xzlno81dEO9RpF/Q?=
 =?us-ascii?Q?bpfPR5pozggp/rJziYWO82PguyvSvGkRl4RpYMcmvfJGfBNJzYiJiOAsemRf?=
 =?us-ascii?Q?V3/jGeCGGmbn1/DRLi9BPnhZMFT5wLIA2OFcr+FJ4v3Fu+5zmTWoaVnp3BbS?=
 =?us-ascii?Q?kmGAh2mCd/7n+KDok7NuMrELMgdq69ts8CNzq9+YqvwXSay9RMkqdUcgl2eK?=
 =?us-ascii?Q?oe1CJcaYOhdNjy+DptmrppPCspZIbty5qFsBrTL30Dsokic/jhbEVBh1slBl?=
 =?us-ascii?Q?HPU+gfQBoAY4jrHXaMSIj+rwPCdQUGUrV2HwwYMK6YTbsXE4JISTqkA3yEU/?=
 =?us-ascii?Q?U+foY6/v7mUgbUROJJB2RRuy2Z5DUGCvflAmcMnUw0e5mh07Ju5VxZ0fdtKq?=
 =?us-ascii?Q?BIVlnNlt8+8PG744j//MHVDyr5eblDw3IJ1QJ6Jcj849CMF30QCEbgli6k5s?=
 =?us-ascii?Q?hKaJATlaA0ccTVYC/4XtbG7X/nYGtEwk0w5fLYBw8ERHYlYMrTZgMrw2eNrR?=
 =?us-ascii?Q?ZLPKVVh6Y+XWmLj/z6ki9HRVP7hHWZeHGcyWUwosFsp4SULrhUdHymFStiwO?=
 =?us-ascii?Q?kpjyrLYfHL7qIoeoroJruo1HvW92an/76qEytKhOlu3j0rHUTXK1Xfr+6ckD?=
 =?us-ascii?Q?qLnpgsINJkt2NtlTEvN6ujVR24FxBLiu+UrxsM7606YSOl74dhGKkgJpH69D?=
 =?us-ascii?Q?9YhvZDxLD3OD8PnBY5+VSFMQhzd3ZaUMKok5WxPRUP7NxLktqI4/9UHUkbUT?=
 =?us-ascii?Q?AbGFmX5Wm1tMk8WAkS1LVCT066ny1nulH2219YQ7xWzsRPRQzAFgwDbTL6GW?=
 =?us-ascii?Q?bF0B3RXcfT8s4bAV3ucf5VGpL/HdNxw23QIskoqd7FXeqR0q7h1l0rFHUDwM?=
 =?us-ascii?Q?cMpi6cKFe84NttyVQCtHOJXeuFYyJWK3+if0dJsnZi+UK0Me2cldmyjJTLqd?=
 =?us-ascii?Q?vChFkqVizQ3Y/VeVsrFsEwY+AO6G/mfFdQpHetaQ+gNPJjl4nkYOzoJ2ZmrX?=
 =?us-ascii?Q?pg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22917fea-7860-4f60-a7c5-08dcfd4c3bba
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 03:45:04.1986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o+QHjrsJF6+7VKB1XQV0A1tQwgh9XaMFPBJludzk1Q0CC3GoP0MkgLwroN3zwyF3acElIBryVPE/J2p4p3hZ338KAOYvzBOzSSniRl6TPhY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1145
X-Mailman-Approved-At: Tue, 05 Nov 2024 04:45:33 +0100
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

Enable OF_UPSTREAM to use upstream DT and add starfive/ prefix to
the DEFAULT_DEVICE_TREE. Rename jh7110-starfive-visionfive-2-u-boot.dtsi
to jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi and set
the v1.3b device tree as the default device tree.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 arch/riscv/cpu/jh7110/Kconfig                                   | 1 +
 ...boot.dtsi => jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi} | 0
 configs/starfive_visionfive2_defconfig                          | 2 +-
 3 files changed, 2 insertions(+), 1 deletion(-)
 rename arch/riscv/dts/{jh7110-starfive-visionfive-2-u-boot.dtsi => jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi} (100%)

diff --git a/arch/riscv/cpu/jh7110/Kconfig b/arch/riscv/cpu/jh7110/Kconfig
index e5549a01b8..9904a60ddd 100644
--- a/arch/riscv/cpu/jh7110/Kconfig
+++ b/arch/riscv/cpu/jh7110/Kconfig
@@ -19,6 +19,7 @@ config STARFIVE_JH7110
 	imply MMC
 	imply MMC_BROKEN_CD
 	imply MMC_SPI
+	imply OF_UPSTREAM
 	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
 	imply SIFIVE_CACHE
 	imply SIFIVE_CCACHE
diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
similarity index 100%
rename from arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
rename to arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index c3508926d6..5257e64a79 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -9,7 +9,7 @@ CONFIG_SF_DEFAULT_SPEED=100000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0xf0000
 CONFIG_SPL_DM_SPI=y
-CONFIG_DEFAULT_DEVICE_TREE="jh7110-starfive-visionfive-2"
+CONFIG_DEFAULT_DEVICE_TREE="starfive/jh7110-starfive-visionfive-2-v1.3b"
 CONFIG_SPL_TEXT_BASE=0x8000000
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
-- 
2.43.2

