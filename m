Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C2EE77160
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:06:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC78D89669;
	Wed,  4 Dec 2024 00:06:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="aO39LEy9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F2A089669; Wed,  4 Dec 2024 00:06:03 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20729.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::729])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E5408857C
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:06:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gGm8xUNfudm9wRmjeMW1tTvu5MZNHF40P42/S/VC70qifPisZRUidKbmjX6iuR/UlGrGHIvH1CkltuhZYA/jLjNzyeTTV93Y9g9AW2CHWwvV6AaQLOM9nIvMxCSg6Ij/Q9BanHnNQxDSDOi8t2OBSEVD6WB7igfgFt6Vxc/KvdJWj3oIExsvGGmMEV09jNVfOdz5G+nxRTQZ80UCJg5GpcD0X0ZsaXi5Z7+cRigIsPTtBYPtO44BPg4T+7GNXBifOQQ0Hbj7Y+uwKxDMah16cTFWtIE25c3yD8Mym4WxoKRvmvNpj4XDZpDS/M/jpLPW8FPEhQBySKKiYC8BzYQi1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQTiUgS53ESYz6vDTFlxUcRHPVfaI4lOk+aduiQUhbs=;
 b=X1cG/BoTaCqCi5gktGtExpaWmZJ618wZBsymqebwwCNA1ARH/Ab6yUH0kDM3SyXCZ3i3IL/nZ+ZVG46Y5TdmmRN8qnLOGLciP0s1wqv3vENOHxDabYOBQKV6hjQLT9LcG6WYkHJN+q1k395ZHgwRKp0X/8BOE+W8DhRqBkFuanQcLHa9VIl4Y1m6qM9MT7flT2j1wwEuPsAAquf+Cocf0b7YDbY/RR5nPf/dYVyJ8faKhuIoiwAR9F3ag93+nDPtPaT94e1iPfyAsKLnw5pqucFYzpzlmHzoXGv8qOjhaWyJ6oIy5BdYn9ocnW4I11WZYRyLKulbaIs1PFAOJDCE7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQTiUgS53ESYz6vDTFlxUcRHPVfaI4lOk+aduiQUhbs=;
 b=aO39LEy97ypPJJjPpTq8NCSwlVAnoBXTkwHyAAWbLmf78W7isA80MNjZByMXG+i7OEnD1YppF5SDS+UCWOSGWGeIvpGFJZaaL6khI3uCTcdDK8Eh+hkg7Z+x4anY9dQFNH/ss/4JW5q53SdkSVeIYURr94KcfZlW0i7eZHFWjuxG7YasRui1ieenSEzG2FJfV2je2JcXXXY0vbPI3aifxjt18/tY9VtQ//DVwPX06zTswISTLrE7uHQ3RXCAAMc+CIcWWmlbfk2TLdfu2ZMtkn+kTnDosheH+vWbmr5MX8YgapxLfIDVk1t91xkB70YByr5mNimaTv9yMy+yiYdt5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM9PR08MB6066.eurprd08.prod.outlook.com (2603:10a6:20b:2d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 23:05:59 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 23:05:59 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [RESEND v4 0/3] cmd/mtd: add missed featuries
Date: Wed,  4 Dec 2024 02:05:48 +0300
Message-ID: <20241203230551.2677602-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00014AEF.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::31d) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM9PR08MB6066:EE_
X-MS-Office365-Filtering-Correlation-Id: 472ad56f-12eb-4a42-b748-08dd13ef0ce2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|7416014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wmJ3hL3ZMvR9vyOvJedvjvs/KRba+aTCL0pdWYyIHDYXvr9tjhSiXKIvMb4X?=
 =?us-ascii?Q?5ANIfB+HeIt42xRVkcU7tSsAMxhLqKxmdTHn6PDLAmUwpQ3vrjFqePNetjKw?=
 =?us-ascii?Q?5hybWN0CKGQJ3kFOz81RUTFaiWJJkdCvXmBOUVKMB1/YmzjIBJEHdUXpze2A?=
 =?us-ascii?Q?bwY3HRLXomlLPdl+sOMqwQ1okpQQPQVFSh9vdkNuSGclEFlIVs1XdAECR8vU?=
 =?us-ascii?Q?lqWCet/q1cdnmggUHjJI1gQAgPrQn6NlqJ4Ns3JRwDe65iH3shb32gf10Zo4?=
 =?us-ascii?Q?LWztepLMZSTC/uH8MuRax0VpIIYXyQCUq+/Zgl33r3mCZRGqIH9qb7wtTRCZ?=
 =?us-ascii?Q?iWve2XdKz0T8kb4jUr+o90DhEgOjRVn/HmF1XZJGGtWtcUoi4Me78byuFkOQ?=
 =?us-ascii?Q?rdEQBnmrF/GbZQqvjml78cdOODX3VPYgy0bQVEzivL6SgrvDQoi+XPEfK3YD?=
 =?us-ascii?Q?XqWuYfhwTBkNiOfMtEmChimvxZ1cvcoPN720pm5yRGNcFuP9g9cs/TXmF7Cz?=
 =?us-ascii?Q?RXqfmgXnntDCHT7Bq4U8iHWeph204dz4DNjzAcuyajDXV+thrXlSXJVMbPWP?=
 =?us-ascii?Q?pnpoqsXU83XKrHOBfjAP/ZX8s/LmQ49dDgiJp8kmbkPY1RCdvCggPOY2AcPF?=
 =?us-ascii?Q?ONVKb6WP71W6uI7MzP3mcW93e4hIonMlcA/zUX+OmXT618Ssvmugwxp5sPbR?=
 =?us-ascii?Q?CdeR7Y6bnhMHmHYvVuWnx8S01fRb4yEsGAnxyrALw6c7n9o72bVlHLFCg1cB?=
 =?us-ascii?Q?i0QDyQsaAT/o7q3nF31+WnYQJuvdEOaRhcQRq1ZlaBPVv52ePrj5xsOFDSlm?=
 =?us-ascii?Q?ZMtXUO6/YkQh1oI/2ap06JDJBEmG1H+CS2rXoMWsZGgWfgwRTuD0axG+K7bJ?=
 =?us-ascii?Q?ruDlb8n5dX+mpPI+Qd3J0jMsHnQ0lDBEG1gaqnIrUwU45wPBlB5EjEPmCVv3?=
 =?us-ascii?Q?WR26P9gKgciFiz9ORQRY71MhaECt8+i67NtpfeO+FXy7eAXyoWMdNmYiSJqW?=
 =?us-ascii?Q?slw7ElnFjfJAZXwdm/nAsjwqz8Kow0nNqqapfo5/DCqy4wc29+WW9Rtg/f8R?=
 =?us-ascii?Q?wl6GiK/mEGFXRtYYiLrAbwd5LeWI8iNmU5XT+MJ6WGENLjKQWD7acOg+LGXM?=
 =?us-ascii?Q?BrU8rwyHvFwpnUYCp1l9wJgUxP352oX91IW/5j9P7kbpPAd0hcADS9DJDLv3?=
 =?us-ascii?Q?R4GYofIwXS5hlQKF3cn2PTXNq4QGYJOjaI9EFp3GUKakU8hGFiEeXusV1bG4?=
 =?us-ascii?Q?lk0yd6OweDjBaNyWblw1iSDdr9cW/PWXNNlZ6QC2e2mlmo9Ixxh2wbg5/G+K?=
 =?us-ascii?Q?9XM5y/m1KQwzo8CfXXWRhdsN/F1UOTAYDUsRekP/B/vtWcah3ixbDc77DE9A?=
 =?us-ascii?Q?glpis238FFn1wiENo1wPlgBvaBwY8Wbr7s0e2CCpHIjzZoKCyw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?llnjb6L5yRo3PDTUMEivI1T07dQSeazDyz3P5auE9NGUn3C7bjwx1G4U23oZ?=
 =?us-ascii?Q?lMR1+ExgfTozseHNpDbNGQlkv9KL09F2kdNQwKHgxZhYv/cyTLVPOT+gY6yM?=
 =?us-ascii?Q?/9pGD8d+IYqdkFqmXRwBA517V2cPX9sAJEABJXrLssiR5oUGyqRIhK3nJyeI?=
 =?us-ascii?Q?LhtENO+c3BeAwYN/V9SHvW/CZcBpi2Y0777fpCkSiDqTM3UCqeAe+E21thU/?=
 =?us-ascii?Q?KuaoXUpCBiEeq6fQN7hSB8YbTSURca2gE6LZ+VWJzIAdMvKnRdFzO/K1CToO?=
 =?us-ascii?Q?YO9k1qiF5/aCMhVwnQvhpRy3erKuws06MW4RE5XuaDcGjbKQhlOvZLBSo+dQ?=
 =?us-ascii?Q?TbAinqzcKtWhaHbiEU3uJw4dMIDCZbshWCyvJ0CY02t+rjelEuQ/r6mNWKrG?=
 =?us-ascii?Q?9CUk2da4BOrk57a6GhdEKUcx1fr4DWzfdcvNT45dot4Djg15Yf6MH2ffT7n0?=
 =?us-ascii?Q?rkWafxRTWtUy7Plh+Lo01G9Xz4qDEer2yYdtnqbBNj7g4gp6DAdvxoK6T6M1?=
 =?us-ascii?Q?NXNP5I3xPe2IsNxp/cTXnMpu6OeyF1aI4Fh92UoZf+P5AGM5HtdM4dI/vfv9?=
 =?us-ascii?Q?phVTssgX37FiYflw+jvEUbOvvUaznY6JV+DP43rIcXv89aFGm3hpWS+0A+Xo?=
 =?us-ascii?Q?EfutGA7CKSksswHOmCI+gT/HiUIMwmtS0IhX0/N2zhaBLdtfOhqrm+fL/tfN?=
 =?us-ascii?Q?XonVPbzzM1MHIXD4iXn30O/N5Nxie6F1pfuanhXwhBoWRBiOWlba99e8rB+z?=
 =?us-ascii?Q?+Fnb1j5PnvcFALi07ex6OTXaw8/riACfwnPhdrmeo0FR7vxrFJciiibqt1rk?=
 =?us-ascii?Q?gmXvgUX92kFGRT22VJpYVpXtawmqT1D8x4oB/ZD1Rk3yQuZv3La8W1JKJgQg?=
 =?us-ascii?Q?9otT3EB5qmMprFsxELgAxDndOhK1z/D83W7p/6yfGporIFJLSVpTBPa74+tH?=
 =?us-ascii?Q?bk5F5qxhSpK5LP9/mnAdTFvDpRb75IjpuQmrfyIKrNeeoL9a4stcGwA6Wimo?=
 =?us-ascii?Q?NiEHusJdf82Bxe+gsOtIEmug/WHmMJ+B9fspYX/fRMT5bYg3py2sNr5Wvclh?=
 =?us-ascii?Q?086IJxtoNFo7f+F61gXCCG9oTyeIsIoxKMg+KSGlf//b2oADXVkaf6TzQpVx?=
 =?us-ascii?Q?DS4w9a3yH0QFEww2I7moMNiEt2/Ni0tXnTLQ3lfgNw5Jj7T3GrVMOws2d07m?=
 =?us-ascii?Q?q0rGz4UL3/g0nQYVN4xcb7pUYlnHAxAdxpppSgWR3JxTRTzq4DjWbUftkAdZ?=
 =?us-ascii?Q?JIsAH+x6MpyKP9PPDItY7aRQsSMEQOUMF1fJLb1cNDJjrQgGm4aOX3lCMz/M?=
 =?us-ascii?Q?K7hxAnrC40HXh1oqOpvMijaobddFp+ubCNdCmC9BZbIio1rE5ceGlXtJT3um?=
 =?us-ascii?Q?Bt0gsAlei3fbTTPqsYksrcs6BpkmCHBibZB8nHimpYwLjACklkkYiGyUblNp?=
 =?us-ascii?Q?0UDP2iWctftsXaCCtJ1uPcAOQf2DrZOsnhAfQX84zNz4Z20nIMhPMHL/kQog?=
 =?us-ascii?Q?C9X1LFHvHuV6hXtWFCVyOD/5aqe/0YTqp46AgiCJ/ZAW3Q8qEqyJcTvTgeGM?=
 =?us-ascii?Q?9ClcVMF8sIZxBUXVPd/CG01pyD1uF7CSOalxf3i1SV/JT6tY2OatH28vr4PT?=
 =?us-ascii?Q?xlOLhqy4115pH+D1rQC55Oc=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 472ad56f-12eb-4a42-b748-08dd13ef0ce2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 23:05:59.2397 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 03gukDDR1bRomiUQ5notQrHaMQYQSkfKNwIxl/60DMBJKQbtJr5cHuNSSCIZoPeOKrCg/GU8vUQ37Q+HYqQFP/UrVm7cCBWgV550d+IMXWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6066
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

Some nand flashes (like spi-nand one) are registered with mtd
subsystem only, thus nand command can't be used to work with
such flashes. As result some functionality is missing.

This patch series implements following subcommands:
 * markbad         -- mark block as bad (clone of 'nand markbad')
 * nand_write_test -- destructive test of flash blocks (clone of 'nand torture')
 * nand_read_test  -- non-destructive test of nand flashes

Changes v2:
 * add cover letter

Changes v3:
 * rename 'mtd torture' to 'mtd nand_write_test'
 * rename 'mtd nandread' to 'mtd nand_read_test'
 * improve features description
 * code fixes suggested by Heinrich Schuchardt

Changes v4:
 * fix missed renaming
 * replace '#ifdef CONFIG_CMD_MTD_*' with '#if CONFIG_IS_ENABLED(CMD_MTD_*)'
 * improve nand_read_test output
 * use do_div() properly

Mikhail Kshevetskiy (3):
  cmd: mtd: add markbad command support
  cmd: mtd: add nand_write_test command support
  cmd: mtd: add nand_read_test command support

 cmd/Kconfig |  38 +++++
 cmd/mtd.c   | 452 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 490 insertions(+)

-- 
2.45.2

