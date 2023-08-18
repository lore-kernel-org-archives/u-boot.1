Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3D4C71149
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 13:44:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53D7A86C7D;
	Fri, 18 Aug 2023 15:43:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="TIPWmqMX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FF2C86D8A; Fri, 18 Aug 2023 15:43:58 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC91486AC8
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 15:43:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=laurentiu.tudor@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QzmTgSUHUallP36gKdAtaJhQuL3Xiq2FbnaP585Z4C9eWnxSDrx2fzJEINvPBUDKvd5TpnFNyZaRHhHY/RBpQxgBn/LalBbYVoXkWFqF9G6Z3+zPkS5mRwo5r2i6DVShxm3w6a+BWf4C/P2v+00Iambecio6PNvcYu7HqVUeuzOwPoW3Qzatv8S6ybEpBp82EXKIWe3gfABzaz8rnv/kXMHTD7H8RBcQU7ef1e8roEDEzwPQKBqTBzasAOu0XfBWCe3F//1b8ygDuz0Sw/lc5IJib7Q4PwzevpD+aKAYBeaVXkr/nDSZbUgDdac2i/3DSdzQPL1RDRqU7ii4iMUfpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h46JxvJNqvafI2LGYoWVCnEeg+aUUkKz+S4veXuVZdM=;
 b=DeA66G+Vei23clVP9jfCplp5RCSIAwn3xMhiRyY77OIlrouQ4ajSbIW+c84CI2DJ5mlPX/ilpMQVX20GbZ4hhOnvze5sO317eR3bJav+nItibHH5TZ921S9np+83U6shGbBnl7YuVjtSzLp2vEEa61Ig7aDl7ZUE1meujd8cGTUZ/PUAedW2B1KbVZce7+f/tMbKsdjps4JqPQJPiPDeionyl2C1XeXayRhDbmBiMIfmWgLwhQ7RiyKJWkig9hV1gf8LO//ipH0Spi7f9G3MA1tmWoZe12q96CsxSz0s2WbA+EA/slde08ptu7EPTO2EaGUK8k/MHHKTxM/ziebpgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h46JxvJNqvafI2LGYoWVCnEeg+aUUkKz+S4veXuVZdM=;
 b=TIPWmqMX1B2j3kLNQ6XQe3cAgZIo6kUVEi2aqohZcCl+tkLcArbvjU7LidcHR/4I0CMifmgA15niTniRUeBcLBpiluNVn5xPuc/r2ASJWEykoX5VfRDxfoKhuFvIfJdvzehb7bG8uU2sztv3pNPgwuhuu6Z4CaXgul23IM0MsEE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com (2603:10a6:10:368::16)
 by AS8PR04MB8309.eurprd04.prod.outlook.com (2603:10a6:20b:3fe::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.32; Fri, 18 Aug
 2023 13:43:53 +0000
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::179f:1c4a:4573:acb9]) by DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::179f:1c4a:4573:acb9%4]) with mapi id 15.20.6678.029; Fri, 18 Aug 2023
 13:43:53 +0000
From: laurentiu.tudor@nxp.com
To: rajesh.bhagat@nxp.com, pramod.kumar_1@nxp.com, andy.tang@nxp.com,
 mingkai.hu@nxp.com, Ashish.Kumar@nxp.com, priyanka.jain@nxp.com,
 wasim.khan@nxp.com, matt@traverse.com.au, udit.agarwal@nxp.com,
 joe.hershberger@ni.com, peng.fan@nxp.com, sjg@chromium.org,
 u-boot@lists.denx.de
Cc: michael@walle.cc, camelia.groza@nxp.com, ioana.ciornei@nxp.com,
 vladimir.oltean@nxp.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 0/2] fsl-layerscape: drop support for obsolete PPA secure
 firmware
Date: Fri, 18 Aug 2023 16:43:28 +0300
Message-Id: <20230818134330.12509-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0012.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::18) To DB9PR04MB9380.eurprd04.prod.outlook.com
 (2603:10a6:10:368::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9380:EE_|AS8PR04MB8309:EE_
X-MS-Office365-Filtering-Correlation-Id: a13e6c9b-998e-4fad-1342-08db9ff1297a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kcT4SbhNgaccx80tVUSVote9l4c2C2j5nmXYKD7iJoUlUE7MYuXQ122DIixJQTkYu1eiVZva8ZWfRK6BOINs3hGDFom8+SSCCQiJeuTK7PhWSXsjH9dK4USlO5SoEi9vLL7wcS0kVwkQq+2D0/ZVHixMuaAYyCdNQKzY3OyKogsk08TrpZI7NqjVDPsRevMFn+0MxxuTBh1xWQgnGj4SROihKcGjkIcTRMA6ZOTJD7wd6WVl1C6Dh2Y88hA9y43VjEnk1I1mlxPgf5v0kKKwddc3yySwyRqinjPpzxNGjt6UyYBjHtTKSk/R4z0t98vrv9FQqy6fKsR1gcYzuXPGhyMSE63WEXD4r5WBjAdxAcwLETyheG5uLiAD5D8pwgEwO91MdhqEWEGM/RYPISm/f3tPn1GbZggofa6LzWi0DyXgHdW/16ai1gBiYx79h2EsrJ+uRKYwgL/29mlM3tHwIcMVhA3K/LBlPd9gwSP/0yWZQuNqOap+42NGRCiAjybeEOoqD2eilNTijNVo+Xxaf13s+XK0o1mfSju4CNIWg72RIjBjOKMj+33XmgwqDaAQ6peI8iNDv4E0DmSvO/5LSPTG+4br2c38thGVQR0M7m5JsgaKDTEoNi3+yWwwI+Zo1LQ/dP21ACaS+r/JkVgszA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB9380.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(136003)(376002)(396003)(346002)(1800799009)(451199024)(186009)(6666004)(478600001)(8676002)(8936002)(4326008)(66946007)(66476007)(316002)(66556008)(6506007)(6486002)(41300700001)(6512007)(9686003)(38100700002)(38350700002)(921005)(52116002)(26005)(36756003)(1076003)(2616005)(5660300002)(2906002)(86362001)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vzpHNCvCQ0AxoXHszZqhKNk2sKPA5er9R+k8sXGBrHPYaEA3XkKRQf+PYz2P?=
 =?us-ascii?Q?RbpF1I1Kn6kPsDWcfUFuFrUaT0Jun9/ViOgpS7oE0bZ0AkHQxxKVlSZHjxd2?=
 =?us-ascii?Q?zwv7z6bJQCOtrq2J6WhOvhiJb4hOI3b3oyiJSipayPALcWgG+yuP/RQG5C8V?=
 =?us-ascii?Q?UULlmlkepPXPH1dhVWm8y04KMBuCcUiqAqL+ly+4K/6VMtmgAjVOegzbkKpE?=
 =?us-ascii?Q?y1TNG/d7XIzM0f5EZrs1ARNP8+7y4Wu9Rj8RnHXGLYA6tV/GHNvNgR7MBFqD?=
 =?us-ascii?Q?osm9EV7Pgfoa6GN80Zk/BZ0iUSTN79g2Nmei3It59pkUDyaqQzlb9rdYomvp?=
 =?us-ascii?Q?VLbR5tHH/UaCSNPh3S+XCu32zV/Uuamq/wb3R8x9fj7U0AdpOaGRAx0D8Ldh?=
 =?us-ascii?Q?5URfBIoXFj7I+HRVFACUgF8zyyHqNaP47jtKvhRAt6xy2vkkSUpHoX8ZAGJZ?=
 =?us-ascii?Q?VYJfUhMpa8Zq0QtwhO6dJWmKdMfEnPjV0jVwQKQ0rc/7gsM8+w6rP+3jMe6F?=
 =?us-ascii?Q?2F93cUbrUh3eymyWNm9nqON3jOtG9DqcYnte2xymWumRfsHsCh5gmH9h8PZr?=
 =?us-ascii?Q?NlOOT8GelB/U1dVmBkbi2wkJ/KMVnus4KPMzqryiTXKiHiLimoD7OVfh1szH?=
 =?us-ascii?Q?sBqzSvdTH9/BxT5AUZznnR/ZKpdjfm5mcH74BI4uqVLa0HnoGwsE3fIxTs4a?=
 =?us-ascii?Q?DnBXo/B1nSGtAz9kG3bf+4bzwWG6U8JlysHfMGSDa+njR0A8M12j6etQvfv3?=
 =?us-ascii?Q?gNJgbVAmnOiMN6EsI+ZJXzE5F2iKILp9jdsfwVYee3BT3rEr+usUc1YzhpHX?=
 =?us-ascii?Q?lpulR4osH2r6YVvIOS10IejaekLSXdC7UmKLxHW+gdI7SEZ2msHwDngvEEYo?=
 =?us-ascii?Q?E8FJeKWqJL0lrfsTwg0UW2Dqok66EJFEF9yyP4Wlm0pgnnl5pXjxVcDc5Lbn?=
 =?us-ascii?Q?t1cOVpX3MMU5paIjdCzZBRCDVXDQyGupzGPf8wsCJ0goruFigq12LjbgNU1o?=
 =?us-ascii?Q?OqhaCk/NJHGv+0ibRenHiw+q09DWvFuIG9Zd+wzfM+ayKVuQFXMP2pYRySw+?=
 =?us-ascii?Q?L7AWKbxLOnlClHKFJ5BJR5x0hVMxZfJbITByFikqYErrvtoGc7Xt+e8+U80r?=
 =?us-ascii?Q?kVz7Q3PMyDaHVPKv3VW/Gie308Nk7n7wwdS9Dm1864jdUAsJ6Y5KT/EXgqTI?=
 =?us-ascii?Q?KtCj0Ww516Ge56M/l6Guvkvq/Xtuf7UapR9rzMJjokZW3Kpx8QSW4aJ6KYnt?=
 =?us-ascii?Q?AMCfxMdJVw3aPhIb8onh8pcSqeD1jv02qldKJh1thP9jL43CQNBx0ITAqtwI?=
 =?us-ascii?Q?s9P+66dI4yEk8DoXbQj8u0u/qZzy2AZAHck2mEK9vJnp2VsoLSS3XFQs8Cm8?=
 =?us-ascii?Q?u0yx89NBGduwLFOQbMKhhQDFu6zPcXjZsurxwbQNuVF3V3S8T1+vW6FIjt1m?=
 =?us-ascii?Q?qb2Ls7iSt/lWKTCTFmZPMjjKJN4iQS8/fDaB2x609kZV7CUaTWjNKWEcIpAo?=
 =?us-ascii?Q?NNi1RVfRf+o7kSLFFhwXpehwDp5CsBd/aeN7iax1L4kc9ykrC11AUCfi7r9t?=
 =?us-ascii?Q?/bORCFOKhACuaF7uoXH5kart2i+gNUW78rHDoMRY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a13e6c9b-998e-4fad-1342-08db9ff1297a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9380.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 13:43:53.6228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2J3r2O08MH8rI6qbMyS0FUoMWpY7+kR8rax03h+03GGExDtx/astTTvtSxZQLyKMxr5XkrNz9oV5uAPzDeuqDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8309
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

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Support for this in-house secure firmware was discontinued long time
ago so remove it. First patch deletes the defconfigs that use it and
the second one removes the actual support.

Laurentiu Tudor (2):
  configs: layerscape: delete defconfigs using legacy PPA secure FW
  fsl-layerscape: drop obsolete PPA secure firmware support

 arch/arm/cpu/armv8/fsl-layerscape/Kconfig     |  60 ----
 arch/arm/cpu/armv8/fsl-layerscape/Makefile    |   1 -
 arch/arm/cpu/armv8/fsl-layerscape/ppa.c       | 284 ------------------
 arch/arm/cpu/armv8/fsl-layerscape/spl.c       |  34 ---
 .../arm/include/asm/arch-fsl-layerscape/ppa.h |  12 -
 arch/arm/include/asm/fsl_secure_boot.h        |   9 -
 board/freescale/ls1012afrdm/Kconfig           |  11 -
 board/freescale/ls1012afrdm/ls1012afrdm.c     |   6 -
 board/freescale/ls1012aqds/Kconfig            |   8 -
 board/freescale/ls1012aqds/ls1012aqds.c       |   6 -
 board/freescale/ls1012ardb/Kconfig            |  12 -
 board/freescale/ls1012ardb/ls1012ardb.c       |   6 -
 board/freescale/ls1028a/Kconfig               |  12 -
 board/freescale/ls1028a/ls1028a.c             |   7 -
 board/freescale/ls1043aqds/Kconfig            |  16 -
 board/freescale/ls1043aqds/ls1043aqds.c       |   5 -
 board/freescale/ls1043ardb/Kconfig            |  14 -
 board/freescale/ls1043ardb/ls1043ardb.c       |   5 -
 board/freescale/ls1046aqds/Kconfig            |  16 -
 board/freescale/ls1046aqds/ls1046aqds.c       |   5 -
 board/freescale/ls1046ardb/Kconfig            |  14 -
 board/freescale/ls1046ardb/ls1046ardb.c       |   5 -
 board/freescale/ls1088a/Kconfig               |  28 --
 board/freescale/ls1088a/ls1088a.c             |   5 -
 board/freescale/ls2080aqds/Kconfig            |  16 -
 board/freescale/ls2080aqds/ls2080aqds.c       |   5 -
 board/freescale/ls2080ardb/Kconfig            |  16 -
 board/freescale/ls2080ardb/ls2080ardb.c       |   5 -
 board/traverse/ten64/ten64.c                  |   1 -
 configs/ls1012a2g5rdb_qspi_defconfig          |  69 -----
 configs/ls1012afrdm_qspi_defconfig            |  67 -----
 .../ls1012afrwy_qspi_SECURE_BOOT_defconfig    |  72 -----
 configs/ls1012afrwy_qspi_defconfig            |  72 -----
 configs/ls1012aqds_qspi_defconfig             |  95 ------
 configs/ls1012ardb_qspi_SECURE_BOOT_defconfig |  77 -----
 configs/ls1012ardb_qspi_defconfig             |  77 -----
 configs/ls1043aqds_defconfig                  | 107 -------
 configs/ls1043aqds_lpuart_defconfig           | 109 -------
 configs/ls1043aqds_nand_defconfig             | 138 ---------
 configs/ls1043aqds_nor_ddr3_defconfig         | 108 -------
 configs/ls1043aqds_qspi_defconfig             |  98 ------
 configs/ls1043aqds_sdcard_ifc_defconfig       | 135 ---------
 configs/ls1043aqds_sdcard_qspi_defconfig      | 124 --------
 configs/ls1043ardb_SECURE_BOOT_defconfig      |  99 ------
 configs/ls1043ardb_defconfig                  | 100 ------
 configs/ls1043ardb_nand_SECURE_BOOT_defconfig | 124 --------
 configs/ls1043ardb_nand_defconfig             | 128 --------
 .../ls1043ardb_sdcard_SECURE_BOOT_defconfig   | 124 --------
 configs/ls1043ardb_sdcard_defconfig           | 126 --------
 configs/ls1046aqds_SECURE_BOOT_defconfig      | 108 -------
 configs/ls1046aqds_defconfig                  | 110 -------
 configs/ls1046aqds_lpuart_defconfig           | 112 -------
 configs/ls1046aqds_nand_defconfig             | 139 ---------
 configs/ls1046aqds_qspi_defconfig             | 101 -------
 configs/ls1046aqds_sdcard_ifc_defconfig       | 139 ---------
 configs/ls1046aqds_sdcard_qspi_defconfig      | 128 --------
 configs/ls1046ardb_emmc_defconfig             | 122 --------
 configs/ls1046ardb_qspi_SECURE_BOOT_defconfig |  99 ------
 configs/ls1046ardb_qspi_defconfig             | 102 -------
 configs/ls1046ardb_qspi_spl_defconfig         | 130 --------
 .../ls1046ardb_sdcard_SECURE_BOOT_defconfig   | 123 --------
 configs/ls1046ardb_sdcard_defconfig           | 122 --------
 configs/ls1088aqds_defconfig                  | 112 -------
 configs/ls1088aqds_qspi_SECURE_BOOT_defconfig | 107 -------
 configs/ls1088aqds_qspi_defconfig             | 108 -------
 configs/ls1088aqds_sdcard_ifc_defconfig       | 130 --------
 configs/ls1088aqds_sdcard_qspi_defconfig      | 128 --------
 configs/ls1088ardb_qspi_SECURE_BOOT_defconfig | 104 -------
 configs/ls1088ardb_qspi_defconfig             | 105 -------
 ...1088ardb_sdcard_qspi_SECURE_BOOT_defconfig | 124 --------
 configs/ls1088ardb_sdcard_qspi_defconfig      | 124 --------
 configs/ls2080aqds_SECURE_BOOT_defconfig      | 108 -------
 configs/ls2080aqds_defconfig                  | 109 -------
 configs/ls2080aqds_sdcard_defconfig           | 116 -------
 configs/ls2080ardb_SECURE_BOOT_defconfig      | 107 -------
 configs/ls2080ardb_defconfig                  | 108 -------
 configs/ls2081ardb_defconfig                  |  96 ------
 configs/ls2088ardb_qspi_SECURE_BOOT_defconfig |  96 ------
 configs/ls2088ardb_qspi_defconfig             | 101 -------
 env/Kconfig                                   |   2 +-
 include/configs/ls1046a_common.h              |   3 +-
 81 files changed, 2 insertions(+), 6094 deletions(-)
 delete mode 100644 arch/arm/cpu/armv8/fsl-layerscape/ppa.c
 delete mode 100644 arch/arm/include/asm/arch-fsl-layerscape/ppa.h
 delete mode 100644 configs/ls1012a2g5rdb_qspi_defconfig
 delete mode 100644 configs/ls1012afrdm_qspi_defconfig
 delete mode 100644 configs/ls1012afrwy_qspi_SECURE_BOOT_defconfig
 delete mode 100644 configs/ls1012afrwy_qspi_defconfig
 delete mode 100644 configs/ls1012aqds_qspi_defconfig
 delete mode 100644 configs/ls1012ardb_qspi_SECURE_BOOT_defconfig
 delete mode 100644 configs/ls1012ardb_qspi_defconfig
 delete mode 100644 configs/ls1043aqds_defconfig
 delete mode 100644 configs/ls1043aqds_lpuart_defconfig
 delete mode 100644 configs/ls1043aqds_nand_defconfig
 delete mode 100644 configs/ls1043aqds_nor_ddr3_defconfig
 delete mode 100644 configs/ls1043aqds_qspi_defconfig
 delete mode 100644 configs/ls1043aqds_sdcard_ifc_defconfig
 delete mode 100644 configs/ls1043aqds_sdcard_qspi_defconfig
 delete mode 100644 configs/ls1043ardb_SECURE_BOOT_defconfig
 delete mode 100644 configs/ls1043ardb_defconfig
 delete mode 100644 configs/ls1043ardb_nand_SECURE_BOOT_defconfig
 delete mode 100644 configs/ls1043ardb_nand_defconfig
 delete mode 100644 configs/ls1043ardb_sdcard_SECURE_BOOT_defconfig
 delete mode 100644 configs/ls1043ardb_sdcard_defconfig
 delete mode 100644 configs/ls1046aqds_SECURE_BOOT_defconfig
 delete mode 100644 configs/ls1046aqds_defconfig
 delete mode 100644 configs/ls1046aqds_lpuart_defconfig
 delete mode 100644 configs/ls1046aqds_nand_defconfig
 delete mode 100644 configs/ls1046aqds_qspi_defconfig
 delete mode 100644 configs/ls1046aqds_sdcard_ifc_defconfig
 delete mode 100644 configs/ls1046aqds_sdcard_qspi_defconfig
 delete mode 100644 configs/ls1046ardb_emmc_defconfig
 delete mode 100644 configs/ls1046ardb_qspi_SECURE_BOOT_defconfig
 delete mode 100644 configs/ls1046ardb_qspi_defconfig
 delete mode 100644 configs/ls1046ardb_qspi_spl_defconfig
 delete mode 100644 configs/ls1046ardb_sdcard_SECURE_BOOT_defconfig
 delete mode 100644 configs/ls1046ardb_sdcard_defconfig
 delete mode 100644 configs/ls1088aqds_defconfig
 delete mode 100644 configs/ls1088aqds_qspi_SECURE_BOOT_defconfig
 delete mode 100644 configs/ls1088aqds_qspi_defconfig
 delete mode 100644 configs/ls1088aqds_sdcard_ifc_defconfig
 delete mode 100644 configs/ls1088aqds_sdcard_qspi_defconfig
 delete mode 100644 configs/ls1088ardb_qspi_SECURE_BOOT_defconfig
 delete mode 100644 configs/ls1088ardb_qspi_defconfig
 delete mode 100644 configs/ls1088ardb_sdcard_qspi_SECURE_BOOT_defconfig
 delete mode 100644 configs/ls1088ardb_sdcard_qspi_defconfig
 delete mode 100644 configs/ls2080aqds_SECURE_BOOT_defconfig
 delete mode 100644 configs/ls2080aqds_defconfig
 delete mode 100644 configs/ls2080aqds_sdcard_defconfig
 delete mode 100644 configs/ls2080ardb_SECURE_BOOT_defconfig
 delete mode 100644 configs/ls2080ardb_defconfig
 delete mode 100644 configs/ls2081ardb_defconfig
 delete mode 100644 configs/ls2088ardb_qspi_SECURE_BOOT_defconfig
 delete mode 100644 configs/ls2088ardb_qspi_defconfig

-- 
2.17.1

