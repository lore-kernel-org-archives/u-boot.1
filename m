Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD5BCD98F3
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 05:41:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D63CD86B5D;
	Wed, 11 Oct 2023 07:41:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="GpK7Ahkq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3729586B74; Wed, 11 Oct 2023 07:41:20 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::60d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C865086B57
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 07:41:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFOUaDnysrl/13UI9UjJjq6Yt4i6ymdSRWWvJOJikKbsF8aFLUlYl9GA2edQWeCIeMrEokdOr6ir/op7u9aSdT00zTVSgjvTTDultKqsDliE6GdqiX39ztl802zrpJoSSj4MXoa+jZZa5er4gO3TGMIdERC4L9j/0bVU5y7gxNlQZ68Y3JrAdLEdTyloH0AohGxUkb5FtMKSWxYH7CQlctK8YgnHdrobwwxVHkLpq0pN5ikgrmtIp8La9AyY4zjPQWE8mSKQPg7rW7IBgWNq+KmIlvBpUsbTi9z9LwWIF49O9HjIhnsue5NFakhonVM+R6j1hRgY68vOWldiyG8YsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJutdned0qV23jwbegmhWejs0yaRvfxbBt4NQ8gIjco=;
 b=A95TjWsJROzBu0igrPFAi3WnphiV35crRbGSiJJB3FYuFC8b1WpbA56eZK6QmYUoHfFXRuxQ6TofMD2D4Effl+U3X/0vVFO3a/ks6PABEHYmqPN+8aog4xRM4MU3Ja3xcPaXV1cMcFlqnYVH51lsCuUgtMnyQ0w8+06U8RLbu98T5AJUuP08THCOwC800Cx+Ceh4WwJBbXYmV2WTtMTP50i6+Eu148shH4GEtObGn/IVQncK39Ejudq4iBsb85QM96s1NtE+P0UtMmFFXgDvpu02O/dqW2rOi0q/JeRYUX4AUrn06kIauD2HfeJ9QtCCbBzniu4pC57GfisBngCDkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJutdned0qV23jwbegmhWejs0yaRvfxbBt4NQ8gIjco=;
 b=GpK7AhkqsDf9a6fioUwLcpVGuYiT8L1c6HqpPHKRYV7PbXgBRVd1Vtz/InJFb1Gb5GHepDXg5YpT9UsBKKV2cWIPvdY9+/9zBdwfdRS5CsYr8y1VUnsW8xlATjy+jFQEtWPktaDy/z/NRtqK5NZoYoJGnH1IP5jDc0LL6+DyzQA=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9292.eurprd04.prod.outlook.com (2603:10a6:20b:4e7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.41; Wed, 11 Oct
 2023 05:41:15 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6838.040; Wed, 11 Oct 2023
 05:41:15 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Tom Rini <trini@konsulko.com>
CC: "U-Boot@lists.denx.de" <u-boot@lists.denx.de>, Laurentiu Tudor
 <laurentiu.tudor@nxp.com>, Han Xu <han.xu@nxp.com>
Subject: [GIT PULL] please pull fsl-qoirq-2023-10-10
Thread-Topic: [GIT PULL] please pull fsl-qoirq-2023-10-10
Thread-Index: Adn8BOdW+lQoJaiTQxS7kTw2K+HvDQ==
Date: Wed, 11 Oct 2023 05:41:15 +0000
Message-ID: <DU0PR04MB9417C7029385E9026624DB9488CCA@DU0PR04MB9417.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS4PR04MB9292:EE_
x-ms-office365-filtering-correlation-id: 363987ed-4a2b-416b-6450-08dbca1caf7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bqxI5qqpQmEMSs4S2WrZbJFaDnWceJHXYkv4RSTWAxO30Hcrk2p9XW5CqGqnVf6HGBjK4hQS0+NT1p1qmULK17MUUO4I0INI+R5FchiILPPUeBnKXTS8AiTWhibqFka1TouHP3J6hDfEJWPy/zmT5wE+J2UXJcDNIFZJfmO4NQUcxIj0ymqao1IeBU8Cmp0EoNCWTxVv6PVoBttiiEo78MX6P7V2zhq3lZTc2JtCNhlseYCC7Cg1irZ6zn5VmLFjs1lxMbcMfobIvG7Rqhi8k1QkbJsj+xD8h8T9cL+kjZTohQ+tUks66PSvfNeKIhXokoPzsR8XuNqPhEO+9j2+N+wyEhh8NY3M0VySRNOdwJx53r1q8B26lH80r1o+f7ALP9ZqEWaRjqwn/NeByttIKzCM2c/DCx4cg/Q77RcQBme+jQTFbD0Gi+88jLAupE1YSV8/HyCZ2vMK/g+rMht9UtA23kFg72w/WwX+MStlNA6To10Pt/pXetMH+u3w2F5DG/AvZkpDb8fN8iJ9HrOC34AQgKYnspOKWO1eCOv0B+Xs68x60wxMh0+/j4+yz8c7QY/fB+TWKdPpv/bp4xVg4qG0NqM+sWf1TFMRcA6rmek=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(136003)(396003)(376002)(39860400002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(4001150100001)(9686003)(6506007)(7696005)(71200400001)(26005)(66556008)(6916009)(122000001)(76116006)(33656002)(66446008)(64756008)(54906003)(478600001)(66946007)(966005)(316002)(66476007)(38100700002)(38070700005)(83380400001)(52536014)(55016003)(2906002)(30864003)(4326008)(41300700001)(8676002)(8936002)(44832011)(5660300002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eoG+05/6NNg6Tr1k0KRzywLsOqkXuMo/05DcCIl1E7vIwlV1ZFJT74jypyJt?=
 =?us-ascii?Q?C1W90+zj3K+CmkcRsmi3z0t04Ste+QXsMAqUZgeePf6oqsOT5zRLdDOkBR6w?=
 =?us-ascii?Q?KuQyNdZ8FOFyuTbCj+AMX+E1piFQN8UEn//oqvpyjasW/nkdLev11Ozh7g0h?=
 =?us-ascii?Q?gQFWRlbbAMzWVhPsYYZMBKw0ziIAd7XtXFGL9rQeW9xksLkS6sfOH/JnrBXC?=
 =?us-ascii?Q?lnJ/whYlCXAoT16RBQmONYa8iFjOkYp5UL046zacPytAj3msXirv+QAz2wP2?=
 =?us-ascii?Q?grYVatcPghVABwSp7hBPbtcHtk+0ms7CjL/nwwEg48OWMlOK7y8aLMbcgfVH?=
 =?us-ascii?Q?wM+YJ0qTDMdMSyCpAuOc/d+gJsuFra78dXI4v/gbdJwu2UDVGBaLNOYVZJS9?=
 =?us-ascii?Q?hzt+dbKN1hj8RytH9snv/2g2BuvJ/GZSCYa6s5+mQyyiRgqNmwgh2galJlOC?=
 =?us-ascii?Q?CVhyMhBG5WzlOKvRKZJqWjFJdYe8pyTGFLFSXhwOZbXwfbXbaZcHShiJmfer?=
 =?us-ascii?Q?iLCOJllfdxknEjnrWu3nsz2jt0qkrnmnyTNqatH3kjQx5hvy1mGqtVF+iJ/K?=
 =?us-ascii?Q?PJI5+fxY/XN7wmFAk0TBKMzyikNC0awhU472utG9ha+5gJ+0Xpug+uY3vOP2?=
 =?us-ascii?Q?TF/gZDbhitAOU2jBcULPR7MPMAjTPTsIbq8Eal06XbSP/yegiDFjcU6KpXgK?=
 =?us-ascii?Q?WR44VfgbfCVrpHgZJOID7FrrAcRJZoINtUxyu5r2V8g6eNEbwODu3qIPXize?=
 =?us-ascii?Q?AiF6mudgmFJTWeRny9uULfuHbdntkReQS9ZgBbdZJwtBd8qMg+1v2dmX77vB?=
 =?us-ascii?Q?TFeOR3qxsjKObI/9a8JJI6F9Mu/C++i1kuhvUIYKsWTGhm5ceITQsrqAsS5e?=
 =?us-ascii?Q?Th/1S1DLKRW+pAnRiGhBLcmRHtL4dROsKI8t6+4jVKO599lV+s6e8mfTrfoR?=
 =?us-ascii?Q?yF+gsKxeJOI7xiaRRvsSU7iLTrSh83+dQtD16CWTu6jD/J3agMsg+RmBSjfi?=
 =?us-ascii?Q?P1m+tqPO12Ha1sB2eTwSw8faBPJC2BaCTSkwsFIhNhdanM25DjOzfsJVspLD?=
 =?us-ascii?Q?LeI7VgjCzkNnrZ9S9oShthTAlpTnlvTdWTT6Qw4hMDPMvzQ8jMOp18wFr4LN?=
 =?us-ascii?Q?Ap6SXPyKVOkHQCIGv5etmNWz8GXzu9PHrUN8ytgS0GqKrIniOp3CDY1GuATn?=
 =?us-ascii?Q?CPSsGWyMaMjMovMsI3YC//2Dgl3qZQXkR1I20r5Im/f0+XUI8pY96qLVdPeX?=
 =?us-ascii?Q?/vXelGPKJgRLdxfyWEbD3YtYMzgbdcraXq4DiWn4oFD8y/y32mZ4y1IDm4ks?=
 =?us-ascii?Q?/5i3A38Af1u3duwSy7jfUsucnAapdJVi1NvHGJCi62SGSsA5QojAzORLbH7H?=
 =?us-ascii?Q?U/XNFxHjJZhm5OyMEhX8hVNTvfCD2J5N41a0uvTEWZfiHrqHazJS7H/dDBoM?=
 =?us-ascii?Q?YJ7ECGUYMhgYUlXQr5ZtHjWYU1b29B97YmjWj6Au3fbEtIAzoZMswJmBoB1Z?=
 =?us-ascii?Q?0iXovwq9AKVpBbNH4AUse92/egXfDEGjTS1glTb3+g306y/NlgLcuIl1AEhN?=
 =?us-ascii?Q?gNoAMRhE5XMu/5He4tA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 363987ed-4a2b-416b-6450-08dbca1caf7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 05:41:15.4718 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LjxbutPiFf4byzwdeUnmsE9zUMxuOW5YrVGrSv+4pbnejdvttXd6SVFHXH7+4PCKJNagumE/+XLCKu+pmodIBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9292
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

Hi Tom,

Please pull fsl-qoirq-2023-10-10
---------------------------------------
Drop legacy PPA secure FW support
support for MC reserved memory
reset the FLSHxCR1 registers for nxp_fspi
---------------------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq/-/pipelines/1=
8067

I merged the patch 1 [1] and patch 2 [1] into one patch
[1]https://lore.kernel.org/all/20230822150334.15703-1-laurentiu.tudor@nxp.c=
om/

Thanks,
Peng.

The following changes since commit d9bb6d779b69c2548891e568e5e2a23e1b7eedaa=
:

  Merge tag 'u-boot-rockchip-20231007' of https://source.denx.de/u-boot/cus=
todians/u-boot-rockchip (2023-10-08 09:58:55 -0400)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq.git tags/fsl-qo=
irq-2023-10-10

for you to fetch changes up to 131e44c5448fb0ba9f8b6084cb848a84d729b2c5:

  spi: nxp_fspi: reset the FLSHxCR1 registers (2023-10-10 10:13:51 +0800)

----------------------------------------------------------------
Han Xu (1):
      spi: nxp_fspi: reset the FLSHxCR1 registers

Laurentiu Tudor (6):
      configs: layerscape: delete defconfigs using legacy PPA secure FW
      fsl-layerscape: drop obsolete PPA secure firmware support
      armv8: fsl-layerscape: make some functions static
      drivers: net: fsl-mc: add support for MC reserved memory
      board: freescale: ls2080a: declare MC reserved regions
      board: freescale: ls1088a: declare MC reserved regions

 arch/arm/cpu/armv8/fsl-layerscape/Kconfig            |  60 ---------------=
----
 arch/arm/cpu/armv8/fsl-layerscape/Makefile           |   1 -
 arch/arm/cpu/armv8/fsl-layerscape/icid.c             |  12 ++--
 arch/arm/cpu/armv8/fsl-layerscape/ppa.c              | 284 ---------------=
--------------------------------------------------------------------------
 arch/arm/cpu/armv8/fsl-layerscape/spl.c              |  34 -----------
 arch/arm/include/asm/arch-fsl-layerscape/ppa.h       |  12 ----
 arch/arm/include/asm/fsl_secure_boot.h               |   9 ---
 board/freescale/ls1012afrdm/Kconfig                  |  11 ----
 board/freescale/ls1012afrdm/ls1012afrdm.c            |   6 --
 board/freescale/ls1012aqds/Kconfig                   |   8 ---
 board/freescale/ls1012aqds/ls1012aqds.c              |   6 --
 board/freescale/ls1012ardb/Kconfig                   |  12 ----
 board/freescale/ls1012ardb/ls1012ardb.c              |   6 --
 board/freescale/ls1028a/Kconfig                      |  12 ----
 board/freescale/ls1028a/ls1028a.c                    |   7 ---
 board/freescale/ls1043aqds/Kconfig                   |  16 -----
 board/freescale/ls1043aqds/ls1043aqds.c              |   5 --
 board/freescale/ls1043ardb/Kconfig                   |  14 -----
 board/freescale/ls1043ardb/ls1043ardb.c              |   5 --
 board/freescale/ls1046aqds/Kconfig                   |  16 -----
 board/freescale/ls1046aqds/ls1046aqds.c              |   5 --
 board/freescale/ls1046ardb/Kconfig                   |  14 -----
 board/freescale/ls1046ardb/ls1046ardb.c              |   5 --
 board/freescale/ls1088a/Kconfig                      |  28 ---------
 board/freescale/ls1088a/ls1088a.c                    |   6 +-
 board/freescale/ls2080aqds/Kconfig                   |  16 -----
 board/freescale/ls2080aqds/ls2080aqds.c              |   6 +-
 board/freescale/ls2080ardb/Kconfig                   |  16 -----
 board/freescale/ls2080ardb/ls2080ardb.c              |   6 +-
 board/freescale/lx2160a/lx2160a.c                    |   1 +
 board/traverse/ten64/ten64.c                         |   1 -
 configs/ls1012a2g5rdb_qspi_defconfig                 |  69 ---------------=
-------
 configs/ls1012afrdm_qspi_defconfig                   |  67 ---------------=
------
 configs/ls1012afrwy_qspi_SECURE_BOOT_defconfig       |  72 ---------------=
--------
 configs/ls1012afrwy_qspi_defconfig                   |  72 ---------------=
--------
 configs/ls1012aqds_qspi_defconfig                    |  95 ---------------=
---------------
 configs/ls1012ardb_qspi_SECURE_BOOT_defconfig        |  77 ---------------=
---------
 configs/ls1012ardb_qspi_defconfig                    |  77 ---------------=
---------
 configs/ls1043aqds_defconfig                         | 107 ---------------=
-------------------
 configs/ls1043aqds_lpuart_defconfig                  | 109 ---------------=
-------------------
 configs/ls1043aqds_nand_defconfig                    | 138 ---------------=
----------------------------
 configs/ls1043aqds_nor_ddr3_defconfig                | 108 ---------------=
-------------------
 configs/ls1043aqds_qspi_defconfig                    |  98 ---------------=
----------------
 configs/ls1043aqds_sdcard_ifc_defconfig              | 135 ---------------=
---------------------------
 configs/ls1043aqds_sdcard_qspi_defconfig             | 124 ---------------=
------------------------
 configs/ls1043ardb_SECURE_BOOT_defconfig             |  99 ---------------=
----------------
 configs/ls1043ardb_defconfig                         | 100 ---------------=
----------------
 configs/ls1043ardb_nand_SECURE_BOOT_defconfig        | 124 ---------------=
------------------------
 configs/ls1043ardb_nand_defconfig                    | 128 ---------------=
-------------------------
 configs/ls1043ardb_sdcard_SECURE_BOOT_defconfig      | 124 ---------------=
------------------------
 configs/ls1043ardb_sdcard_defconfig                  | 126 ---------------=
-------------------------
 configs/ls1046aqds_SECURE_BOOT_defconfig             | 108 ---------------=
-------------------
 configs/ls1046aqds_defconfig                         | 110 ---------------=
--------------------
 configs/ls1046aqds_lpuart_defconfig                  | 112 ---------------=
--------------------
 configs/ls1046aqds_nand_defconfig                    | 139 ---------------=
-----------------------------
 configs/ls1046aqds_qspi_defconfig                    | 101 ---------------=
-----------------
 configs/ls1046aqds_sdcard_ifc_defconfig              | 139 ---------------=
-----------------------------
 configs/ls1046aqds_sdcard_qspi_defconfig             | 128 ---------------=
-------------------------
 configs/ls1046ardb_emmc_defconfig                    | 122 ---------------=
-----------------------
 configs/ls1046ardb_qspi_SECURE_BOOT_defconfig        |  99 ---------------=
----------------
 configs/ls1046ardb_qspi_defconfig                    | 102 ---------------=
-----------------
 configs/ls1046ardb_qspi_spl_defconfig                | 130 ---------------=
--------------------------
 configs/ls1046ardb_sdcard_SECURE_BOOT_defconfig      | 123 ---------------=
------------------------
 configs/ls1046ardb_sdcard_defconfig                  | 122 ---------------=
-----------------------
 configs/ls1088aqds_defconfig                         | 112 ---------------=
--------------------
 configs/ls1088aqds_qspi_SECURE_BOOT_defconfig        | 107 ---------------=
-------------------
 configs/ls1088aqds_qspi_defconfig                    | 108 ---------------=
-------------------
 configs/ls1088aqds_sdcard_ifc_defconfig              | 130 ---------------=
--------------------------
 configs/ls1088aqds_sdcard_qspi_defconfig             | 128 ---------------=
-------------------------
 configs/ls1088ardb_qspi_SECURE_BOOT_defconfig        | 104 ---------------=
------------------
 configs/ls1088ardb_qspi_defconfig                    | 105 ---------------=
------------------
 configs/ls1088ardb_sdcard_qspi_SECURE_BOOT_defconfig | 124 ---------------=
------------------------
 configs/ls1088ardb_sdcard_qspi_defconfig             | 124 ---------------=
------------------------
 configs/ls2080aqds_SECURE_BOOT_defconfig             | 108 ---------------=
-------------------
 configs/ls2080aqds_defconfig                         | 109 ---------------=
-------------------
 configs/ls2080aqds_sdcard_defconfig                  | 116 ---------------=
---------------------
 configs/ls2080ardb_SECURE_BOOT_defconfig             | 106 ---------------=
------------------
 configs/ls2080ardb_defconfig                         | 107 ---------------=
-------------------
 configs/ls2081ardb_defconfig                         |  96 ---------------=
---------------
 configs/ls2088ardb_qspi_SECURE_BOOT_defconfig        |  96 ---------------=
---------------
 configs/ls2088ardb_qspi_defconfig                    | 101 ---------------=
-----------------
 drivers/net/fsl-mc/mc.c                              | 110 +++++++++++++++=
++++++++++++++++++++
 drivers/spi/nxp_fspi.c                               |   7 +++
 env/Kconfig                                          |   2 +-
 include/configs/ls1046a_common.h                     |   3 +-
 include/fsl-mc/fsl_mc.h                              |   1 +
 86 files changed, 130 insertions(+), 6098 deletions(-)
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
