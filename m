Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B122C5DF9B
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 12:28:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0103140666;
	Mon, 24 Aug 2026 12:28:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OMknbh0yXGSy; Mon, 24 Aug 2026 12:28:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787574525;
	bh=R9a8wwh5ONWT8/ARqZvNFSWcM86CoapP+CBrwOaqRUo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SciF/umBO55wmdk8YgcAAvApnmLbwNdT3hDRS5Zz1UcecIYLGBxW3fQ6O1xEkSney
	 aLmby3TfCiVIsML4RmXGElQUTpGuVOdUhsi9IH9ILVdB2T+eQMU4Ir35Ru0YSCxkvl
	 TPVvOKe3Dcujme4Lc/bipkr9BkaqnzcD2bNVXWVItlTl/m/3OjtDDd0V33ZTBWz3hw
	 gcuj42++0zDg05dwORY8sZn3wD8AFIHxhdBHzDzfgymeNKW4Us1qVXv5ch2v1F1jbd
	 vI0HhnGOq8YChJQNjbydygA+KudQ3zzzrE+/WUxMVDXSewfKXL2cb5IYYP1pPTXAi/
	 yorlubbwRLt9g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 73B0840633;
	Mon, 24 Aug 2026 12:28:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C1F12279
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 12:28:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A82CC40097
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 12:28:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 10IMgQtL7tQc for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 12:28:44 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=vladimir.oltean@nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=KR4j5Efp
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A151F40029
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 12:28:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MdhdzyU6fgpaPUwsZXyp2PeUWrPvIEvvkXx9J5l/E1/nMB2ZCQ1X/Ybugr7F5K3kHSa4XMDDlXOJaFD7GOZgE8aCzCH5PgecXQQT56LhbL745cU78yBF3yhPfkQR+rEsZwuy33zytOxeYnliW2f+EVd0SGkpNrBFDUcs3Tlsjtubc99TpSLnPdXjdzxrjgFyEh4LnaHlH7yhObaY++JtGtjwpZxunlOCuEMCmQWgYyjbMGtyKSD+3CNgUNCSoADZpbUdezbojzTKK0eDRxzAorvqei2iXxAs5/Rb4E4lStgB4DeuIQmnoehg29b6RCHO6PmLkIie3KFNEdH88VDhyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9a8wwh5ONWT8/ARqZvNFSWcM86CoapP+CBrwOaqRUo=;
 b=uNIZxMt4A+4H3hH1yG1f3ftLb8BZg08/nYGi/wCTCD7UxXo+6qlZJNQd6sAmQnyezhXihSF6TWce7Qwd4NlKRKF3N9ZLB8NxQGmomfajs+y3wey55Gr3nYdh2hy0Z/ijqNBVQagtH3sYqAdcRsyA+O/Y8tBfEQkBmEztebbhe0CEq9eetc4/JXiBj5nfyA1N+opYrEi0akzs5DpiZ3x/DqFoRCsI7IvFqPjLk2H7mG2zlI0iqgX8GK/oQyO55os7AoSyH1dWTrmP08lpWaoxK0FIeqHiUbE7Q/1iJgnJVtS9QaIequtRwtCGImPVdH10Z6G5OVTzAMm454XdSUMK0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9a8wwh5ONWT8/ARqZvNFSWcM86CoapP+CBrwOaqRUo=;
 b=KR4j5EfpTP7NZ3jdAuAMkX5CFbBjRmIwQE1c9/7/9WEO1oULYd6U+/zvmaTrUajBqq5EenGPWtW1+lyZQKilKIthnU6m2mzMuH44motDiFL0nE4pBnuI+yux962tRCbO/0QEFvysmsmgZ6gds1QpNJOzbByU+5Qfw5emi9mD1Pgs4UebdXsarKG3xh26Zn9HRtWxRHbyF6D1aZZiRc3syso9XAkXgmHk5Ozc4ZgKUGclOsgImKhVwylOoGf9OqG1kf4o8PeKpBdumAIlLb++L5OZZz/Iy+nPsu7es2uyhMXT4OFskVpfAWTYlq0cwLk3C1tQc1/yfsD89xnxFyN2dA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by GVXPR04MB9879.eurprd04.prod.outlook.com (2603:10a6:150:11c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 12:28:38 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 12:28:38 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Peng Fan <peng.fan@nxp.com>,
	u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/6] Fixes and usability improvements for Layerscape QDS
Date: Mon, 24 Aug 2026 15:28:19 +0300
Message-Id: <20260824122825.95712-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0431.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::19) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|GVXPR04MB9879:EE_
X-MS-Office365-Filtering-Correlation-Id: 33d1348f-95e1-47c2-ffa7-08df01db38af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|23010399003|376014|1800799024|10067099003|6133799003|3023799007|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: DWbx93d5/+JwkHa/6x5LyFqzVrdfJ75H1aTeJENqbJAqBsW+OcXdv1m1xJ0JBZcwwxIuRL08pSlhWmwNCPuM7y5rlQ12Hw00rXCJi8E7c8U2T5Z6qs6slRLV0SY4tNbnTt5J8Dl5CUMYyN0/qHEFb7TEOK3aj/CdsfOeEZE76OhH9X2zfskfgt7fuMbq1WP09p/GavNCq5UUiEoX3Cyn+36Fk0nUzOnXxwz+tyXIGDh5NhSqRCAimlYeULtNgTzqBbQ4uKVZI3Al4ZV+W8jEVWaclwlcUnURL6AZmIYeZ9fb7ALVZj6N7+SJKKneyCjLDld7J6VIKmimrMo0vBDACj7wqywwHvPqYpILsY3QJWQRpj2IsoNA3iGEnZco5Q2EQrOpEzxA9fry7jgNnHC5P0sEqH28P8ZLTjkdH0rJV/90S/fO9o3xqHK5H0jcRAl/efsaRrJXGb2MBXRwG0eMs8t+tVbS0HXc4P3UehqfK9tqaoLevn1t41wqv8bBtrczF2vP+oubAhR7p7yOZ8tBEuMyvPHqVeJifns6/oGfjWo4o5S/KyWLQETbl4Pmnjaq9Y4htFJ4/9tZWNfAkrvXJ1p654vn2t66PbQqR2olVrslOUV8kCQHaUdLOhkCcAT8kjz379ViiPivdHNRvIfgH5rh/Q3alMtK2mUidi5D4i4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6900.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(23010399003)(376014)(1800799024)(10067099003)(6133799003)(3023799007)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qg9cgATyl9/vBt0kaScepi2Ra+506pXxisjs2VI956o0gFSp0kZw9hhBniEY?=
 =?us-ascii?Q?xyaWxDaGqu+empwtfn3pP/7v2QoO5Rd+lTqgtqibJXIntp05zwYHspxITwl6?=
 =?us-ascii?Q?S+3XQit4mvNCOlw0zYJIqr6WBbVQdxCbVghiiOHyjKt1wv9mPeIi2fdy+IGP?=
 =?us-ascii?Q?3FM3eFknfksPi5WIOLj+O9tEI92ikux/Rg+QrOgiYqQx1n4jdymAGVuntI3n?=
 =?us-ascii?Q?yfpugU3C2yI2+/Soh+fUAsiOgR3Opd6UZKGQo8cAN9u1koazI1NSoOZD38/f?=
 =?us-ascii?Q?WqesUgCCap0MqwTukQfYcgNZv8zNBXpbQ0WJ8qW/YmIuX52ija741AYbpVdg?=
 =?us-ascii?Q?rXZC8SvMj1ISeWt3npfo1g50w6PtWBYxFO8AhLOBM/QfycKtk2OWTTYqsyWv?=
 =?us-ascii?Q?K36MjM34j2pJnErU50Spr/L1ZCj0cxKnZgU7kPXcVjNXfrM42iwogd9hT6f4?=
 =?us-ascii?Q?PAoK8Olzuy4Egvu1zkQIT4+ggFQyVsaPP1r8IfHxy0XZMO9ZwyNXvxhNaSsv?=
 =?us-ascii?Q?4OrAZGkMA+MCdJet2xZmM7KpKjCoaZ161GvHr5eC100Ziwi3XKbqxeMckx2N?=
 =?us-ascii?Q?SCaGM+T1ovILqOSIvnP6NXLxu6AAWykY2mGTO25MIH8cUGjRTYyipst/kw42?=
 =?us-ascii?Q?FkPZtDnk/91lLmk9uCmqAQ2DrxPfMaqiB0qlLSXw/yjq2Ibw7STdBAZ7w13X?=
 =?us-ascii?Q?VA5DZouNdTnVMw9KibeiP5wxfcHNQiYGqHTChGKozfE/AORFV/op6AWzZFjs?=
 =?us-ascii?Q?yDcdkJk2/7bM9LucIzRCYmNE9bE1tYkbf1bdDcgeD27+mbodClaJTQ9qXmTo?=
 =?us-ascii?Q?mfXocjqqYgyCVP5p7xYMVFhNMeS5pKTpIbwY0T6huvFf4JC1rsLL8nRo2vse?=
 =?us-ascii?Q?Jp7ddpG1G4a0BBABV4sIFgVvUumSSCs+aDUGMh9k3/S2aUPfjahhdxHz03Rt?=
 =?us-ascii?Q?TdEZu+3nmT5OgEa49cu7pIlARY0hRqf7UqRqlLhHRmPH8awNtun/Rvpn8CoA?=
 =?us-ascii?Q?O2rH32Qcg7Q5jkLwY5IN1lAiJIcheLL/ADDYiJtn3+rH8Dam7uot8Kct8Elt?=
 =?us-ascii?Q?i/vzRGJqifCxzDF1bI7WISmwmHwnSuxgLrFVSQgjXXoRe1Fl4XW//FnMwMa+?=
 =?us-ascii?Q?ha0A9Fu4u1EwhR2Y/t+9JnZLvC8PUZLxE1tTpkzXBYUpBUkp69oxw7WRalVt?=
 =?us-ascii?Q?uvbkQPeXHmSmuaapL5qvyeyHpqViR7B53J5+fV1f8oT6/La45z1PVbEw2xCp?=
 =?us-ascii?Q?CIQoLtw2sSyvNYaubf5H5J+hO1WyaMD9IBvJcYwQ3B4fHMR4/dLCFLDJ5ocv?=
 =?us-ascii?Q?uXOtqB8WYolLlYK11xwL8rwaMTSolCFvV+eMXeD4UVKqbWApQEH32NHs+eSB?=
 =?us-ascii?Q?bw4ePGmX5egbuWncYlZ1bec3/MrcYxfkbHPb4XkWD0vz50Uo/dL2MyRyhbfZ?=
 =?us-ascii?Q?u2ipYLkxOexH1ADtZ58YnpKmXzdc59x5X+AiEQnxZ01Zw9fh7JyXdMPGHUQH?=
 =?us-ascii?Q?Qv/oF5OEXbwrK9rp6n3d46Ri6a9c+NJBtmCE9UnPXPxX5MjpbGIn6Ms90TeA?=
 =?us-ascii?Q?zyRsCZuWXR7546sDXz1sVWQTy+qhu+O6R2zz9gKWR5pGj+sxRno/0ZjA31AO?=
 =?us-ascii?Q?DGUnXMkqriN2SDPpenyy7dsbQuh/GWnerKSZwWUuSAStBAhjZOhb5alQ5OJ0?=
 =?us-ascii?Q?/8AsZsWaKha1x6EBGIHxEQaUGbB+fDUYYfxM5N5+EJpgSk9TfTaIvhfM/uGX?=
 =?us-ascii?Q?+UrYR2+4Kp+UWqFAIkh0VjCwnk7YfsA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d1348f-95e1-47c2-ffa7-08df01db38af
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 12:28:37.9634 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9iTWNM5+cCD7jRgzjD6kdavvNu1uoja9O0qpEYKOTjjGMhSJCdBz/lq1rEqNDR1YtJAp43Mo49WvQeb6ws+YYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9879
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

The set contains an assortment of defconfig changes to Layerscape
boards.

1/6: The LS1043A-QDS, LS1046A-QDS, LS1088A-QDS and LS2088A-QDS are
non-bootable in the default NOR boot configuration, triggering an early
SError before the U-Boot prompt.

2/6: saveenv is broken on the LS2088A-QDS in NOR boot

3/6: usability improvement for all Layerscape QDS defconfigs: enable the
"fdt apply" command to be able to apply overlays.

4/6 and 5/6: usability improvement to increase console input buffer
limit for all Layerscape boards, and remove some core limitations.

6/6: usability improvement to allow *some* Ethernet to be used on
LS1043A-QDS and LS1046A-QDS (not on-chip DPAA, but PCIe NICs).

Vladimir Oltean (6):
  configs: layerscape qds: disable ENV_RELOC_GD_ENV_ADDR for NOR boot
  configs: ls2088aqds_tfa: fix NOR flash write failure
  configs: layerscape qds: enable OF_LIBFDT_OVERLAY
  configs: layerscape: drop CONFIG_SYS_PBSIZE=532 override
  common: kconfig: raise SYS_CBSIZE default to 1024 for FSL_LSCH2/LSCH3
  configs: ls104{3,6}aqds_tfa: enable PCIe Ethernet

 common/Kconfig                                 | 3 +--
 configs/ls1012a2g5rdb_tfa_defconfig            | 1 -
 configs/ls1012afrdm_tfa_defconfig              | 1 -
 configs/ls1012afrwy_tfa_SECURE_BOOT_defconfig  | 1 -
 configs/ls1012afrwy_tfa_defconfig              | 1 -
 configs/ls1012aqds_tfa_SECURE_BOOT_defconfig   | 2 +-
 configs/ls1012aqds_tfa_defconfig               | 2 +-
 configs/ls1012ardb_tfa_SECURE_BOOT_defconfig   | 1 -
 configs/ls1012ardb_tfa_defconfig               | 1 -
 configs/ls1021aqds_ddr4_nor_defconfig          | 1 +
 configs/ls1021aqds_ddr4_nor_lpuart_defconfig   | 1 +
 configs/ls1021aqds_nand_defconfig              | 1 +
 configs/ls1021aqds_nor_SECURE_BOOT_defconfig   | 1 +
 configs/ls1021aqds_nor_defconfig               | 1 +
 configs/ls1021aqds_nor_lpuart_defconfig        | 1 +
 configs/ls1021aqds_qspi_defconfig              | 1 +
 configs/ls1021aqds_sdcard_ifc_defconfig        | 1 +
 configs/ls1021aqds_sdcard_qspi_defconfig       | 1 +
 configs/ls1028aqds_tfa_SECURE_BOOT_defconfig   | 1 -
 configs/ls1028aqds_tfa_defconfig               | 1 -
 configs/ls1028aqds_tfa_lpuart_defconfig        | 1 -
 configs/ls1028ardb_tfa_SECURE_BOOT_defconfig   | 1 -
 configs/ls1028ardb_tfa_defconfig               | 1 -
 configs/ls1043aqds_tfa_SECURE_BOOT_defconfig   | 4 +++-
 configs/ls1043aqds_tfa_defconfig               | 6 ++++--
 configs/ls1043ardb_tfa_SECURE_BOOT_defconfig   | 1 -
 configs/ls1043ardb_tfa_defconfig               | 1 -
 configs/ls1046afrwy_tfa_SECURE_BOOT_defconfig  | 1 -
 configs/ls1046afrwy_tfa_defconfig              | 1 -
 configs/ls1046aqds_tfa_SECURE_BOOT_defconfig   | 4 +++-
 configs/ls1046aqds_tfa_defconfig               | 6 ++++--
 configs/ls1046ardb_tfa_SECURE_BOOT_defconfig   | 1 -
 configs/ls1046ardb_tfa_defconfig               | 1 -
 configs/ls1088aqds_tfa_defconfig               | 4 ++--
 configs/ls1088ardb_tfa_SECURE_BOOT_defconfig   | 1 -
 configs/ls1088ardb_tfa_defconfig               | 1 -
 configs/ls2080aqds_nand_defconfig              | 2 +-
 configs/ls2080aqds_qspi_defconfig              | 2 +-
 configs/ls2080ardb_nand_defconfig              | 1 -
 configs/ls2088aqds_tfa_defconfig               | 5 +++--
 configs/ls2088ardb_tfa_SECURE_BOOT_defconfig   | 1 -
 configs/ls2088ardb_tfa_defconfig               | 1 -
 configs/lx2160aqds_tfa_SECURE_BOOT_defconfig   | 2 +-
 configs/lx2160aqds_tfa_defconfig               | 2 +-
 configs/lx2160ardb_tfa_SECURE_BOOT_defconfig   | 1 -
 configs/lx2160ardb_tfa_defconfig               | 1 -
 configs/lx2160ardb_tfa_stmm_defconfig          | 1 -
 configs/lx2162aqds_tfa_SECURE_BOOT_defconfig   | 2 +-
 configs/lx2162aqds_tfa_defconfig               | 2 +-
 configs/lx2162aqds_tfa_verified_boot_defconfig | 2 +-
 50 files changed, 38 insertions(+), 46 deletions(-)

-- 
2.34.1

