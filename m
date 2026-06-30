Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10490C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 12:51:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C93C84AD9;
	Tue, 30 Jun 2026 14:50:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Kupv8YDO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD01E84A48; Tue, 30 Jun 2026 08:56:35 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1110C84979
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 08:56:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A8Q8hU9KRPo46/mLtx6U/gOy4gH2QV1a3dJ11xV25tukcgbmRXEWQI3k06cGPp2h4No3w6WOqAeTWzHGLtwLvKImZ5K2PBoSFufIEidGGUS8LYCQQXdPAUjhdkn3N6EScqq53w7ZOunr7/gQqQUscj3nhUi1HKfZhOJVx2IV9dDmqkcPsWu+RGwXYgpDi1y+e/23lHxzj6ivkFj90eKzVOHX0Ye4VMJpAhmum6G9BaRK2KBAARLCiHxZg/trp8UXa89NmHu3LIAZo4WMB1BcQXbpndblig5JPGJGIAzDb0Qp8FCUP+KHAJJ/fcADdrrIFVgrkmuC+pVGg1gUgtCVZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7n06lmEh76mnafBeJphzLIBlh45X8ghlDIwAc66qEM=;
 b=w5FFCIDjfK5BEIl4pxPiMH14Z/AZNJMC5LoxA8154sMOurJ8nBSAfVoN5wWbPbJjGc1YP12klboNJEeZqko/DzBCQU84GBxk5f4CNXjfl32V2VRflqYMTderAxnruWQ+1hA2i5Ke4JL0DhGzrQWk7TjgIf2zYeVLVmaWZmO2doS/JLa3g8CQdpp2jZFoMYoiSdShu7E2LYM2frfbcKNGlHAuC1wa2qgVt0SEo9k6WsWKvgsvJ6PW5O982jSBE1ZbD6rj0OtfwjxQgult/15gnnSzbZ4jYf0wQzqMgcORvjekUyYh4G0kxbfdcPBtDF98XkAIA8lwKvkByAKoidxwoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7n06lmEh76mnafBeJphzLIBlh45X8ghlDIwAc66qEM=;
 b=Kupv8YDO7oKza0vEEFpFGsgRk+1GmCsOeAKwLyUx8Fv1FabL+5Cr/H3jxCe9GxABIAlkjzxhu8EGp7mLWQmPKOIVafZkrrBpTa3QZRFuoUds1nwStSzL2VMRNPBa9Nf66Xm3F/6GIqyLrPa5n7hurzMg/mqvUApAJymGymsl0xkKk7hwXFVhGPkCurCJiVIDmBFxTp4xrQg0PZ+JM/lb/2hAKPOghoXUlq3vNxXwg3K5rsnk3M08HIJ0RnpD3UehlB91U1I+sG8kn1EmcTT5fnEEPb7nKQyfalPnLNOUH8UbZ23dJDtPbUzNoT0mqX1ZreYYNSBNM0xaAGzfqlBCmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by MN2PR03MB5085.namprd03.prod.outlook.com (2603:10b6:208:1ab::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 06:56:28 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%6]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 06:56:28 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de,
	Marek Vasut <marex@denx.de>
Cc: Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Dinesh Maniyam <dinesh.maniyam@intel.com>,
 Chee Hong Ang <chee.hong.ang@intel.com>,
 Chee Tien Fong <tien.fong.chee@intel.com>,
 Chin-Liang See <chin.liang.see@intel.com>,
 Dinh Nguyen <dinh.nguyen@intel.com>, Jit Loon Lim <jit.loon.lim@intel.com>,
 Ley Foon Tan <ley.foon.tan@intel.com>,
 Lim Siew Chin <elly.siew.chin.lim@intel.com>,
 Teik Heng Chong <teik.heng.chong@intel.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Peter Robinson <pbrobinson@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Kory Maincent <kory.maincent@bootlin.com>, Anshul Dalal <anshuld@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Fabio Estevam <festevam@gmail.com>, E Shattow <e@freeshell.de>,
 briansune <briansune@gmail.com>
Subject: [PATCH 4/8] cmd: socfpga: Add rsu command for Remote System Update
Date: Tue, 30 Jun 2026 14:55:20 +0800
Message-Id: <20260630065524.27680-5-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20260630065524.27680-1-dinesh.maniyam@altera.com>
References: <20260630065524.27680-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:a03:254::7) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|MN2PR03MB5085:EE_
X-MS-Office365-Filtering-Correlation-Id: abb32260-8cf3-4980-8c2a-08ded674b592
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|1800799024|13003099007|18002099003|11063799006|6133799003|22082099003|56012099006|55112099003;
X-Microsoft-Antispam-Message-Info: zgtKg9DaW5KDY8SRDi4N/qe5illTIffS4TFVsiNQ8JiW2KbREQ+QFtNro50AcigkLgH5+V0q/tq/TXuwQ2ZV2Qyi9GDhP7VyeRYGuef1l4zcSmZ11FnEjkPNfmiLCnrxSMkAQI8+jdqF1Qav9yMIwiOoYSgmYNK4eBD/Nndt7oY69qJL3gZEk+pFveFfI/JrKPiZXcW4lBDBFtF5UVWJrNVCbZOik+Ptd2uAXHiIFXZf5wrxYWJA6W0Y9+DTRIKWUWGsGd+oYo8hrxbqZhIFamTRSTowmMt83p/Q0jU9TaQzcET+3X6naHcxt/7Dqw9el3YZZ4VA5Dj5nlTgeuY0MtjQUYajlZn9c0AYB7pMJkYcXL22lDqdou0F3DCksK6SNkrQLKuK7nZJheuKoQ4x52xpClHw689q9ARAn7OuRbRF6IgNqsunsXRDWDFXU/pTkmuknQfL5NEkJcKCs8e0Lnyqt1BnfKbGOnmhJXKCDcMxx8ZO0ZIrs8MJXOWztTO5Ev4/ipGbxGd+3r0iuNEHMrng0nUKbmYf9sJyNE4rDigtdQJej2H1vbSUB1pWvoXyUFZBc5lOKAxeJYo5VvRaYsNB+zd3U5R6yh/1zvY07qc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(13003099007)(18002099003)(11063799006)(6133799003)(22082099003)(56012099006)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DQuMl2NxiPQsW4/fY0oQ7qI8IjcX9SLcGGYj1Qy11fh1c4X+Dx83SLXifVTb?=
 =?us-ascii?Q?PSrvci9yg32WtuZ9MMQdxmWVz6g0aH41D0be+P+suq0oG323xtZzyfHwTVvV?=
 =?us-ascii?Q?Ga8dqbkg8D9OosQV6otkeWmgDwo6c1Yu3l0ZbAgDC+2Ff24Xe7RGBcpJ3rRq?=
 =?us-ascii?Q?uokwVz/9ws8DaLGD+9exYu3V2jsknYW8LeyjVVgSZJRxSlwklc2ld3Jk1DUS?=
 =?us-ascii?Q?rEqEQl99tBIUxivF7LmFew3ThSsQYSqKxYuEAmlfsQ9/gFayS+mXmh5OdojX?=
 =?us-ascii?Q?tMJ0/EtcEk/tZcn8MMznSjUTZDs7OB5rN1dyjrCgUTrcVW2GUu2T5xGugTtM?=
 =?us-ascii?Q?ux9rlgUqee0pxjvnQ3PkuV6Ty1KFtCdJRkrCmRZhcLZF19JLHssx5GEF+uuD?=
 =?us-ascii?Q?2aQeQreJhUVYQaIbjKYvv7GYeeWvjzslJ7VjGc6cj6ahZey/Fv6QKYn2c6aZ?=
 =?us-ascii?Q?KRiE9Okqa0JC0+p9U2Nq9TxvAg8YGHreiNpchs8FgdBV9mEQ9bNdsSSwX72V?=
 =?us-ascii?Q?/9I8h7eebKnoKIkPUFeHFSXXElUGzA1xE6EFxw2aj9u1yuZvdMAKCPy6q2E3?=
 =?us-ascii?Q?HrlbtWWP6IpKS+jRkYwf7Qg2AjDttvJtsq2hpemIHcF73IiKtc2eEDbWljgC?=
 =?us-ascii?Q?emIt2u53d5C2JyfsjomH0HI3Hu0av38y2xOALgJe6utlsSnJDo+aZfrF9kfu?=
 =?us-ascii?Q?IO5tcEeC7zvvgwhJz+RFUW17wRD5/7t7RFdwmNCfevzKiGtcT/bZ+5OrYc2S?=
 =?us-ascii?Q?v73+fQkBY73zFvE5Voq/DPoi3wFlcmW844U80urrX6YJdfakz2d+q5e5dJ9y?=
 =?us-ascii?Q?nL8v1iN+4iaWm4lnnqzSG9UfeUoaLKAqlxt816O/+Pk1xHZCgVUpp3X5jFq/?=
 =?us-ascii?Q?VqLJzoLjxZdD8cXpM6WOsBvRCQvpo3ZpYnlV5Mv77389STt8Ahc13WrNkumE?=
 =?us-ascii?Q?XEDUHdqvGOCZ+8d4uP5gHCi6sFMEAF/7EniZIBsK2CuNpwDUb+NnuURbgJ2B?=
 =?us-ascii?Q?AVASSB3TsHQ0s4YWUv2kpgYXvkhKJTzeTUk0i7HKNel0fpYDhbONe/r2cPC7?=
 =?us-ascii?Q?0xV4Y8F5fE8b0Qdsumk2uoqxpQZDuOWxFBNifgHiTUXuiYr2m4jQXDQjvlFy?=
 =?us-ascii?Q?6THcK123uxxq2C11ybGfYjuUGATQydj3jyUORCDB6vBp+phAKEI5qV+aC3kg?=
 =?us-ascii?Q?TF6+jxdX/NdklPk0pFQWfmZDnQQ6dK0DhRAuQsQHVVFKzpwi4yPtxqfCB+os?=
 =?us-ascii?Q?zPMinFHi92/rZzDSQ9v8MFdtNJ6LYoalEIVjXD9bXnYkGRqdmQKoEmv9VvUI?=
 =?us-ascii?Q?4ooaG6vC1x85OkuIW14IOlzpXXBSNFjoT/9TiOXwl2iriKsPW4FCudh2gN0o?=
 =?us-ascii?Q?lvQpDaRJtZukFdROoXo6Jd+jUV60v2sVtaLjkWac8LYuRXqEOdNgUWX5vlrk?=
 =?us-ascii?Q?B1QSdChYDmrxi7nahHaMz3xvPlb1MYrEpTXLtINhouffxbIC0RWmEFgRktYk?=
 =?us-ascii?Q?K+7lcpa5TOdhk93y/z+01iqMo1EXkaCBWOFNWwRQATlvNPa/a2ZtBRzH/DDP?=
 =?us-ascii?Q?RwaBNZmhMC1bLO27U2RC4Gugpox0wi+Tz5OGL6YsYZvEiltxvc66tLY97Mz5?=
 =?us-ascii?Q?5gzo4EdGWKnlD8x2KuYjOe7LtxfldnuAZntZAp5DYfCNPYXJib6DrdrJVIah?=
 =?us-ascii?Q?x/0XLaIwlYw7kBKIrBV0TSEIeUD/t8pMdD9FetO7tzwUsGzpJnl2Q3G+mto3?=
 =?us-ascii?Q?tm7qYA5ZFQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abb32260-8cf3-4980-8c2a-08ded674b592
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 06:56:28.7189 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iwvVQjauDLIliALaMPiZYIhdpdijg9T0NFN3onfvIJbPcHyMecnCqCbtQ6XxREjVpvCOCy2VhBKyzXXezabgVy1OIee+CWFrC2/tV/iiNL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5085
X-Mailman-Approved-At: Tue, 30 Jun 2026 14:50:28 +0200
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

Add the "rsu" command exposing the RSU core library to the user: list
and inspect flash slots, manage and program configuration slots, trigger
firmware updates, query DCMF version/status and max_retry, and maintain
the sub-partition table (SPT) and configuration pointer block (CPB).

Add a sandbox unit test covering the usage and argument-parsing paths,
command documentation under doc/usage/cmd/rsu.rst, and a MAINTAINERS
entry for the RSU files not already covered by the SoCFPGA globs. Enable
CMD_SOCFPGA_RSU in the agilex5, agilex, n5x and stratix10 defconfigs.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 MAINTAINERS                         |    6 +
 cmd/Makefile                        |    1 +
 cmd/socfpga_rsu.c                   | 1048 +++++++++++++++++++++++++++
 configs/socfpga_agilex5_defconfig   |    2 +-
 configs/socfpga_agilex_defconfig    |    2 +-
 configs/socfpga_n5x_defconfig       |    2 +
 configs/socfpga_stratix10_defconfig |    2 +
 doc/usage/cmd/rsu.rst               |  208 ++++++
 test/cmd/Makefile                   |    1 +
 test/cmd/socfpga_rsu.c              |   59 ++
 10 files changed, 1329 insertions(+), 2 deletions(-)
 create mode 100644 cmd/socfpga_rsu.c
 create mode 100644 doc/usage/cmd/rsu.rst
 create mode 100644 test/cmd/socfpga_rsu.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 571af196465..ce248c58b4d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -169,10 +169,16 @@ T:	git https://source.denx.de/u-boot/custodians/u-boot-socfpga.git
 F:	arch/arm/dts/socfpga_*
 F:	arch/arm/mach-socfpga/
 F:	board/intel/agilex-socdk/
+F:	cmd/socfpga_rsu.c
 F:	configs/socfpga_*
+F:	doc/device-tree-bindings/misc/altr,socfpga-rsu.yaml
+F:	doc/usage/cmd/rsu.rst
 F:	drivers/ddr/altera/
+F:	drivers/misc/socfpga_rsu.c
 F:	drivers/power/domain/altr-pmgr-agilex5.c
 F:	drivers/sysreset/sysreset_socfpga*
+F:	include/rsu_console.h
+F:	test/cmd/socfpga_rsu.c
 
 ARM AMLOGIC SOC SUPPORT
 M:	Neil Armstrong <neil.armstrong@linaro.org>
diff --git a/cmd/Makefile b/cmd/Makefile
index bbbdfcc4ded..647f83a6263 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -90,6 +90,7 @@ obj-$(CONFIG_CMD_FPGA) += fpga.o
 obj-$(CONFIG_CMD_FPGAD) += fpgad.o
 obj-$(CONFIG_CMD_FS_GENERIC) += fs.o
 obj-$(CONFIG_CMD_FUSE) += fuse.o
+obj-$(CONFIG_CMD_SOCFPGA_RSU) += socfpga_rsu.o
 obj-$(CONFIG_CMD_FWU_METADATA) += fwu_mdata.o
 obj-$(CONFIG_CMD_GETTIME) += gettime.o
 obj-$(CONFIG_CMD_GPIO) += gpio.o
diff --git a/cmd/socfpga_rsu.c b/cmd/socfpga_rsu.c
new file mode 100644
index 00000000000..47d28bc7d08
--- /dev/null
+++ b/cmd/socfpga_rsu.c
@@ -0,0 +1,1048 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Altera Corporation <www.altera.com>
+ *
+ * SoC FPGA RSU console command (Stratix 10 / Agilex family).
+ */
+
+#include <command.h>
+#include <limits.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <rsu_console.h>
+#include <vsprintf.h>
+#include <asm/arch/rsu.h>
+
+/*
+ * Strictly parse a numeric argv[] value.
+ *
+ * U-Boot's dectoul()/simple_strtoul*() silently return partial values
+ * for "12xyz" and wrap on u64 overflow without indication; either could
+ * feed a malformed argv into slot tables or pointers. Parse digit-by-
+ * digit so we can reject both, and allow a single trailing '\n'.
+ */
+static int rsu_parse_num(const char *s, unsigned int base, u64 *out)
+{
+	const char *start;
+	u64 result = 0;
+
+	if (!s || !*s || !out)
+		return -EINVAL;
+	if (base != 10 && base != 16)
+		return -EINVAL;
+
+	/* Accept an optional "0x" prefix for base 16 (matches U-Boot usage). */
+	if (base == 16 && s[0] == '0' && (s[1] == 'x' || s[1] == 'X'))
+		s += 2;
+
+	start = s;
+	while (*s) {
+		unsigned int digit;
+		char c = *s;
+
+		if (c >= '0' && c <= '9')
+			digit = c - '0';
+		else if (c >= 'a' && c <= 'f')
+			digit = c - 'a' + 10;
+		else if (c >= 'A' && c <= 'F')
+			digit = c - 'A' + 10;
+		else
+			break;
+
+		if (digit >= base)
+			break;
+
+		/* Pre-division overflow guard: result*base + digit must fit a u64. */
+		if (result > (ULLONG_MAX - digit) / base)
+			return -ERANGE;
+
+		result = result * base + digit;
+		s++;
+	}
+
+	if (s == start)
+		return -EINVAL;
+	if (*s != '\0' && !(*s == '\n' && s[1] == '\0'))
+		return -EINVAL;
+
+	*out = result;
+	return 0;
+}
+
+/* Parse a decimal slot index into an int, rejecting values > INT_MAX. */
+static int rsu_parse_slot(const char *s, int *out)
+{
+	u64 v;
+
+	if (rsu_parse_num(s, 10, &v) || v > INT_MAX)
+		return -EINVAL;
+	*out = (int)v;
+	return 0;
+}
+
+/*
+ * Parse a hex size into int (rejects > INT_MAX); a negative value would
+ * be treated as a huge unsigned length downstream.
+ */
+static int rsu_parse_hex_int(const char *s, int *out)
+{
+	u64 v;
+
+	if (rsu_parse_num(s, 16, &v) || v > INT_MAX)
+		return -EINVAL;
+	*out = (int)v;
+	return 0;
+}
+
+/* Parse a hex size argument into unsigned int, rejecting values > UINT_MAX. */
+static int rsu_parse_hex_uint(const char *s, unsigned int *out)
+{
+	u64 v;
+
+	if (rsu_parse_num(s, 16, &v) || v > UINT_MAX)
+		return -EINVAL;
+	*out = (unsigned int)v;
+	return 0;
+}
+
+/* Parse a hex u32, rejecting values > U32_MAX. */
+static int rsu_parse_hex_u32(const char *s, u32 *out)
+{
+	u64 v;
+
+	if (rsu_parse_num(s, 16, &v) || v > U32_MAX)
+		return -EINVAL;
+	*out = (u32)v;
+	return 0;
+}
+
+static int slot_count(int argc, char * const argv[])
+{
+	int count;
+
+	if (argc != 1)
+		return CMD_RET_USAGE;
+
+	if (rsu_init(NULL))
+		return CMD_RET_FAILURE;
+
+	count = rsu_slot_count();
+	rsu_exit();
+
+	if (count < 0)
+		return CMD_RET_FAILURE;
+
+	printf("Number of slots = %d.\n", count);
+
+	return CMD_RET_SUCCESS;
+}
+
+static int slot_by_name(int argc, char * const argv[])
+{
+	char *name;
+	int slot;
+
+	if (argc != 2)
+		return CMD_RET_USAGE;
+
+	name = argv[1];
+
+	if (rsu_init(NULL))
+		return CMD_RET_FAILURE;
+
+	slot = rsu_slot_by_name(name);
+	rsu_exit();
+
+	if (slot < 0)
+		return CMD_RET_FAILURE;
+
+	printf("Slot name '%s' is %d.\n", name, slot);
+	return CMD_RET_SUCCESS;
+}
+
+static int slot_get_info(int argc, char * const argv[])
+{
+	int slot;
+	struct rsu_slot_info info;
+	int ret;
+
+	if (argc != 2)
+		return CMD_RET_USAGE;
+
+	if (rsu_parse_slot(argv[1], &slot))
+		return CMD_RET_USAGE;
+
+	if (rsu_init(NULL))
+		return CMD_RET_FAILURE;
+
+	ret = rsu_slot_get_info(slot, &info);
+	rsu_exit();
+
+	if (ret)
+		return CMD_RET_FAILURE;
+
+	printf("NAME: %s\n", info.name);
+	printf("OFFSET: 0x%016llX\n", info.offset);
+	printf("SIZE: 0x%08X\n", info.size);
+	if (info.priority)
+		printf("PRIORITY: %i\n", info.priority);
+	else
+		printf("PRIORITY: [disabled]\n");
+
+	return CMD_RET_SUCCESS;
+}
+
+static int slot_size(int argc, char * const argv[])
+{
+	int slot;
+	int size;
+
+	if (argc != 2)
+		return CMD_RET_USAGE;
+
+	if (rsu_parse_slot(argv[1], &slot))
+		return CMD_RET_USAGE;
+
+	if (rsu_init(NULL))
+		return CMD_RET_FAILURE;
+
+	size = rsu_slot_size(slot);
+	rsu_exit();
+
+	if (size < 0)
+		return CMD_RET_FAILURE;
+
+	printf("Slot %d size = %d.\n", slot, size);
+	return CMD_RET_SUCCESS;
+}
+
+static int slot_priority(int argc, char * const argv[])
+{
+	int slot;
+	int priority;
+
+	if (argc != 2)
+		return CMD_RET_USAGE;
+
+	if (rsu_parse_slot(argv[1], &slot))
+		return CMD_RET_USAGE;
+
+	if (rsu_init(NULL))
+		return CMD_RET_FAILURE;
+
+	priority = rsu_slot_priority(slot);
+	rsu_exit();
+
+	if (priority < 0)
+		return CMD_RET_FAILURE;
+
+	printf("Slot %d priority = %d.\n", slot, priority);
+	return CMD_RET_SUCCESS;
+}
+
+static int slot_erase(int argc, char * const argv[])
+{
+	int slot;
+	int ret;
+
+	if (argc != 2)
+		return CMD_RET_USAGE;
+
+	if (rsu_parse_slot(argv[1], &slot))
+		return CMD_RET_USAGE;
+
+	if (rsu_init(NULL))
+		return CMD_RET_FAILURE;
+
+	ret = rsu_slot_erase(slot);
+	rsu_exit();
+
+	if (ret)
+		return CMD_RET_FAILURE;
+
+	printf("Slot %d erased.\n", slot);
+	return CMD_RET_SUCCESS;
+}
+
+static int slot_program_buf(int argc, char * const argv[])
+{
+	int slot;
+	u64 address;
+	int size;
+	int ret;
+	u32 addr_lo;
+	u32 addr_hi;
+
+	if (argc != 4)
+		return CMD_RET_USAGE;
+
+	if (rsu_parse_slot(argv[1], &slot) ||
+	    rsu_parse_num(argv[2], 16, &address) ||
+	    rsu_parse_hex_int(argv[3], &size))
+		return CMD_RET_USAGE;
+
+	/*
+	 * Reject u64 addresses that don't round-trip through ulong so the
+	 * cast to (void *) below cannot silently truncate.
+	 */
+	if (address > (u64)ULONG_MAX)
+		return CMD_RET_USAGE;
+
+	if (rsu_init(NULL))
+		return CMD_RET_FAILURE;
+
+	ret = rsu_slot_program_buf(slot, (void *)(ulong)address, size);
+	rsu_exit();
+
+	if (ret)
+		return CMD_RET_FAILURE;
+
+	addr_hi = upper_32_bits(address);
+	addr_lo = lower_32_bits(address);
+	printf("Slot %d was programmed with buffer=0x%08x%08x size=%d.\n",
+	       slot, addr_hi, addr_lo, size);
+
+	return CMD_RET_SUCCESS;
+}
+
+static int slot_program_factory_update_buf(int argc, char * const argv[])
+{
+	int slot;
+	u64 address;
+	int size;
+	int ret;
+	u32 addr_lo;
+	u32 addr_hi;
+
+	if (argc != 4)
+		return CMD_RET_USAGE;
+
+	if (rsu_parse_slot(argv[1], &slot) ||
+	    rsu_parse_num(argv[2], 16, &address) ||
+	    rsu_parse_hex_int(argv[3], &size))
+		return CMD_RET_USAGE;
+
+	/*
+	 * Reject u64 addresses that don't round-trip through ulong so the
+	 * cast to (void *) below cannot silently truncate.
+	 */
+	if (address > (u64)ULONG_MAX)
+		return CMD_RET_USAGE;
+
+	if (rsu_init(NULL))
+		return CMD_RET_FAILURE;
+
+	ret = rsu_slot_program_factory_update_buf(slot, (void *)(ulong)address,
+						  size);
+	rsu_exit();
+
+	if (ret)
+		return CMD_RET_FAILURE;
+
+	addr_hi = upper_32_bits(address);
+	addr_lo = lower_32_bits(address);
+	printf("Slot %d was programmed with buffer=0x%08x%08x size=%d.\n",
+	       slot, addr_hi, addr_lo, size);
+
+	return CMD_RET_SUCCESS;
+}
+
+static int slot_program_buf_raw(int argc, char * const argv[])
+{
+	int slot;
+	u64 address;
+	int size;
+	int ret;
+	u32 addr_lo;
+	u32 addr_hi;
+
+	if (argc != 4)
+		return CMD_RET_USAGE;
+
+	if (rsu_parse_slot(argv[1], &slot) ||
+	    rsu_parse_num(argv[2], 16, &address) ||
+	    rsu_parse_hex_int(argv[3], &size))
+		return CMD_RET_USAGE;
+
+	/*
+	 * Reject u64 addresses that don't round-trip through ulong so the
+	 * cast to (void *) below cannot silently truncate.
+	 */
+	if (address > (u64)ULONG_MAX)
+		return CMD_RET_USAGE;
+
+	if (rsu_init(NULL))
+		return CMD_RET_FAILURE;
+
+	ret = rsu_slot_program_buf_raw(slot, (void *)(ulong)address, size);
+	rsu_exit();
+
+	if (ret)
+		return CMD_RET_FAILURE;
+
+	addr_hi = upper_32_bits(address);
+	addr_lo = lower_32_bits(address);
+	printf("Slot %d was programmed with raw buffer=0x%08x%08x size=%d.\n",
+	       slot, addr_hi, addr_lo, size);
+
+	return CMD_RET_SUCCESS;
+}
+
+static int slot_verify_buf(int argc, char * const argv[])
+{
+	int slot;
+	u64 address;
+	int size;
+	int ret;
+	u32 addr_lo;
+	u32 addr_hi;
+
+	if (argc != 4)
+		return CMD_RET_USAGE;
+
+	if (rsu_parse_slot(argv[1], &slot) ||
+	    rsu_parse_num(argv[2], 16, &address) ||
+	    rsu_parse_hex_int(argv[3], &size))
+		return CMD_RET_USAGE;
+
+	/*
+	 * Reject u64 addresses that don't round-trip through ulong so the
+	 * cast to (void *) below cannot silently truncate.
+	 */
+	if (address > (u64)ULONG_MAX)
+		return CMD_RET_USAGE;
+
+	if (rsu_init(NULL))
+		return CMD_RET_FAILURE;
+
+	ret = rsu_slot_verify_buf(slot, (void *)(ulong)address, size);
+	rsu_exit();
+
+	if (ret)
+		return CMD_RET_FAILURE;
+
+	addr_hi = upper_32_bits(address);
+	addr_lo = lower_32_bits(address);
+	printf("Slot %d was verified with buffer=0x%08x%08x size=%d.\n",
+	       slot, addr_hi, addr_lo, size);
+
+	return CMD_RET_SUCCESS;
+}
+
+static int slot_verify_buf_raw(int argc, char * const argv[])
+{
+	int slot;
+	u64 address;
+	int size;
+	int ret;
+	u32 addr_lo;
+	u32 addr_hi;
+
+	if (argc != 4)
+		return CMD_RET_USAGE;
+
+	if (rsu_parse_slot(argv[1], &slot) ||
+	    rsu_parse_num(argv[2], 16, &address) ||
+	    rsu_parse_hex_int(argv[3], &size))
+		return CMD_RET_USAGE;
+
+	/*
+	 * Reject u64 addresses that don't round-trip through ulong so the
+	 * cast to (void *) below cannot silently truncate.
+	 */
+	if (address > (u64)ULONG_MAX)
+		return CMD_RET_USAGE;
+
+	if (rsu_init(NULL))
+		return CMD_RET_FAILURE;
+
+	ret = rsu_slot_verify_buf_raw(slot, (void *)(ulong)address, size);
+	rsu_exit();
+
+	if (ret)
+		return CMD_RET_FAILURE;
+
+	addr_hi = upper_32_bits(address);
+	addr_lo = lower_32_bits(address);
+	printf("Slot %d was verified with raw buffer=0x%08x%08x size=%d.\n",
+	       slot, addr_hi, addr_lo, size);
+
+	return CMD_RET_SUCCESS;
+}
+
+static int slot_enable(int argc, char * const argv[])
+{
+	int slot;
+	int ret;
+
+	if (argc != 2)
+		return CMD_RET_USAGE;
+
+	if (rsu_parse_slot(argv[1], &slot))
+		return CMD_RET_USAGE;
+
+	if (rsu_init(NULL))
+		return CMD_RET_FAILURE;
+
+	ret = rsu_slot_enable(slot);
+	rsu_exit();
+
+	if (ret < 0)
+		return CMD_RET_FAILURE;
+
+	printf("Slot %d enabled.\n", slot);
+	return CMD_RET_SUCCESS;
+}
+
+static int slot_disable(int argc, char * const argv[])
+{
+	int slot;
+	int ret;
+
+	if (argc != 2)
+		return CMD_RET_USAGE;
+
+	if (rsu_parse_slot(argv[1], &slot))
+		return CMD_RET_USAGE;
+
+	if (rsu_init(NULL))
+		return CMD_RET_FAILURE;
+
+	ret = rsu_slot_disable(slot);
+	rsu_exit();
+
+	if (ret < 0)
+		return CMD_RET_FAILURE;
+
+	printf("Slot %d disabled.\n", slot);
+	return CMD_RET_SUCCESS;
+}
+
+static int slot_load(int argc, char * const argv[])
+{
+	int slot;
+	int ret;
+
+	if (argc != 2)
+		return CMD_RET_USAGE;
+
+	if (rsu_parse_slot(argv[1], &slot))
+		return CMD_RET_USAGE;
+
+	if (rsu_init(NULL))
+		return CMD_RET_FAILURE;
+
+	ret = rsu_slot_load(slot);
+	rsu_exit();
+
+	if (ret < 0)
+		return CMD_RET_FAILURE;
+
+	printf("Slot %d loading.\n", slot);
+	return CMD_RET_SUCCESS;
+}
+
+static int slot_load_factory(int argc, char * const argv[])
+{
+	int ret;
+
+	if (argc != 1)
+		return CMD_RET_USAGE;
+
+	if (rsu_init(NULL))
+		return CMD_RET_FAILURE;
+
+	ret = rsu_slot_load_factory();
+	rsu_exit();
+
+	if (ret < 0)
+		return CMD_RET_FAILURE;
+
+	printf("Factory loading.\n");
+	return CMD_RET_SUCCESS;
+}
+
+static int slot_rename(int argc, char * const argv[])
+{
+	int slot;
+	char *name;
+	int ret;
+
+	if (argc != 3)
+		return CMD_RET_USAGE;
+
+	if (rsu_parse_slot(argv[1], &slot))
+		return CMD_RET_USAGE;
+	name = argv[2];
+
+	if (rsu_init(NULL))
+		return CMD_RET_FAILURE;
+
+	ret = rsu_slot_rename(slot, name);
+	rsu_exit();
+
+	if (ret < 0)
+		return CMD_RET_FAILURE;
+
+	printf("Slot %d renamed to %s.\n", slot, name);
+	return CMD_RET_SUCCESS;
+}
+
+static int slot_delete(int argc, char * const argv[])
+{
+	int slot;
+	int ret;
+
+	if (argc != 2)
+		return CMD_RET_USAGE;
+
+	if (rsu_parse_slot(argv[1], &slot))
+		return CMD_RET_USAGE;
+
+	if (rsu_init(NULL))
+		return CMD_RET_FAILURE;
+
+	ret = rsu_slot_delete(slot);
+	rsu_exit();
+
+	if (ret < 0)
+		return CMD_RET_FAILURE;
+
+	printf("Slot %d deleted.\n", slot);
+	return CMD_RET_SUCCESS;
+}
+
+static int slot_create(int argc, char * const argv[])
+{
+	char *name;
+	u64 address;
+	unsigned int size;
+	int ret;
+
+	if (argc != 4)
+		return CMD_RET_USAGE;
+
+	name = argv[1];
+	if (rsu_parse_num(argv[2], 16, &address) ||
+	    rsu_parse_hex_uint(argv[3], &size))
+		return CMD_RET_USAGE;
+
+	if (rsu_init(NULL))
+		return CMD_RET_FAILURE;
+
+	ret = rsu_slot_create(name, address, size);
+	rsu_exit();
+
+	if (ret < 0)
+		return CMD_RET_FAILURE;
+
+	printf("Slot %s created at 0x%016llx with size = 0x%08x bytes.\n", name,
+	       address, size);
+	return CMD_RET_SUCCESS;
+}
+
+static int status_log(int argc, char * const argv[])
+{
+	struct rsu_status_info info;
+	int ret;
+
+	if (argc != 1)
+		return CMD_RET_USAGE;
+
+	if (rsu_init(NULL))
+		return CMD_RET_FAILURE;
+
+	ret = rsu_status_log(&info);
+	rsu_exit();
+
+	if (ret < 0)
+		return CMD_RET_FAILURE;
+
+	printf("Current Image\t: 0x%016llx\n", info.current_image);
+	printf("Last Fail Image\t: 0x%016llx\n", info.fail_image);
+	printf("State\t\t: 0x%08x\n", info.state);
+	printf("Version\t\t: 0x%08x\n", info.version);
+	printf("Error location\t: 0x%08x\n", info.error_location);
+	printf("Error details\t: 0x%08x\n", info.error_details);
+	if (info.version)
+		printf("Retry counter\t: 0x%08x\n", info.retry_counter);
+
+	return CMD_RET_SUCCESS;
+}
+
+static int notify(int argc, char * const argv[])
+{
+	u32 stage;
+	int ret;
+
+	if (argc != 2)
+		return CMD_RET_USAGE;
+
+	if (rsu_parse_hex_u32(argv[1], &stage))
+		return CMD_RET_USAGE;
+
+	if (rsu_init(NULL))
+		return CMD_RET_FAILURE;
+
+	ret = rsu_notify(stage);
+	rsu_exit();
+
+	if (ret)
+		return CMD_RET_FAILURE;
+
+	return CMD_RET_SUCCESS;
+}
+
+static int clear_error_status(int argc, char * const argv[])
+{
+	int ret;
+
+	if (argc != 1)
+		return CMD_RET_USAGE;
+
+	if (rsu_init(NULL))
+		return CMD_RET_FAILURE;
+
+	ret = rsu_clear_error_status();
+	rsu_exit();
+
+	if (ret)
+		return CMD_RET_FAILURE;
+
+	return CMD_RET_SUCCESS;
+}
+
+static int reset_retry_counter(int argc, char * const argv[])
+{
+	int ret;
+
+	if (argc != 1)
+		return CMD_RET_USAGE;
+
+	if (rsu_init(NULL))
+		return CMD_RET_FAILURE;
+
+	ret = rsu_reset_retry_counter();
+	rsu_exit();
+
+	if (ret)
+		return CMD_RET_FAILURE;
+
+	return CMD_RET_SUCCESS;
+}
+
+static int display_dcmf_version(int argc, char * const argv[])
+{
+	int i, ret;
+	u32 versions[4];
+
+	if (argc != 1)
+		return CMD_RET_USAGE;
+
+	if (rsu_init(NULL))
+		return CMD_RET_FAILURE;
+
+	ret = rsu_dcmf_version(versions);
+	rsu_exit();
+
+	if (ret)
+		return CMD_RET_FAILURE;
+
+	for (i = 0; i < 4; i++)
+		printf("DCMF%d version = %d.%d.%d\n", i,
+		       (int)DCMF_VERSION_MAJOR(versions[i]),
+		       (int)DCMF_VERSION_MINOR(versions[i]),
+		       (int)DCMF_VERSION_UPDATE(versions[i]));
+
+	return CMD_RET_SUCCESS;
+}
+
+static int display_dcmf_status(int argc, char * const argv[])
+{
+	int i, ret;
+	u16 status[4];
+
+	if (argc != 1)
+		return CMD_RET_USAGE;
+
+	if (rsu_init(NULL))
+		return CMD_RET_FAILURE;
+
+	ret = rsu_dcmf_status(status);
+	rsu_exit();
+
+	if (ret)
+		return CMD_RET_FAILURE;
+
+	for (i = 0; i < 4; i++)
+		printf("DCMF%d: %s\n", i, status[i] ? "Corrupted" : "OK");
+
+	return CMD_RET_SUCCESS;
+}
+
+static int display_max_retry(int argc, char * const argv[])
+{
+	int ret;
+	u8 value;
+
+	if (argc != 1)
+		return CMD_RET_USAGE;
+
+	if (rsu_init(NULL))
+		return CMD_RET_FAILURE;
+
+	ret = rsu_max_retry(&value);
+	rsu_exit();
+
+	if (ret)
+		return CMD_RET_FAILURE;
+
+	printf("max_retry = %d\n", (int)value);
+
+	return CMD_RET_SUCCESS;
+}
+
+static int create_empty_cpb(int argc, char * const argv[])
+{
+	int ret;
+
+	if (argc != 1)
+		return CMD_RET_USAGE;
+
+	if (rsu_init(NULL))
+		return CMD_RET_FAILURE;
+
+	ret = rsu_create_empty_cpb();
+	rsu_exit();
+
+	if (ret < 0)
+		return CMD_RET_FAILURE;
+
+	return CMD_RET_SUCCESS;
+}
+
+static int restore_cpb(int argc, char * const argv[])
+{
+	int ret;
+	u64 addr;
+
+	if (argc != 2)
+		return CMD_RET_USAGE;
+
+	if (rsu_parse_num(argv[1], 16, &addr))
+		return CMD_RET_USAGE;
+
+	if (rsu_init(NULL))
+		return CMD_RET_FAILURE;
+
+	ret = rsu_restore_cpb(addr);
+	rsu_exit();
+
+	if (ret < 0)
+		return CMD_RET_FAILURE;
+
+	return CMD_RET_SUCCESS;
+}
+
+static int save_cpb(int argc, char * const argv[])
+{
+	int ret;
+	u64 addr;
+
+	if (argc != 2)
+		return CMD_RET_USAGE;
+
+	if (rsu_parse_num(argv[1], 16, &addr))
+		return CMD_RET_USAGE;
+
+	if (rsu_init(NULL))
+		return CMD_RET_FAILURE;
+
+	ret = rsu_save_cpb(addr);
+	rsu_exit();
+
+	if (ret < 0)
+		return CMD_RET_FAILURE;
+
+	return CMD_RET_SUCCESS;
+}
+
+static int restore_spt(int argc, char * const argv[])
+{
+	int ret;
+	u64 addr;
+
+	if (argc != 2)
+		return CMD_RET_USAGE;
+
+	if (rsu_parse_num(argv[1], 16, &addr))
+		return CMD_RET_USAGE;
+
+	if (rsu_init(NULL))
+		return CMD_RET_FAILURE;
+
+	ret = rsu_restore_spt(addr);
+	rsu_exit();
+
+	if (ret < 0)
+		return CMD_RET_FAILURE;
+
+	return CMD_RET_SUCCESS;
+}
+
+static int save_spt(int argc, char * const argv[])
+{
+	int ret;
+	u64 addr;
+
+	if (argc != 2)
+		return CMD_RET_USAGE;
+
+	if (rsu_parse_num(argv[1], 16, &addr))
+		return CMD_RET_USAGE;
+
+	if (rsu_init(NULL))
+		return CMD_RET_FAILURE;
+
+	ret = rsu_save_spt(addr);
+	rsu_exit();
+
+	if (ret < 0)
+		return CMD_RET_FAILURE;
+
+	return CMD_RET_SUCCESS;
+}
+
+static int check_running_factory(int argc, char * const argv[])
+{
+	int ret;
+	int factory;
+
+	if (argc != 1)
+		return CMD_RET_USAGE;
+
+	if (rsu_init(NULL))
+		return CMD_RET_FAILURE;
+
+	ret = rsu_running_factory(&factory);
+	rsu_exit();
+
+	if (ret)
+		return CMD_RET_FAILURE;
+
+	printf("Running factory image: %s\n", factory ? "yes" : "no");
+	return CMD_RET_SUCCESS;
+}
+
+struct func_t {
+	const char *cmd_string;
+	int (*func_ptr)(int cmd_argc, char * const cmd_argv[]);
+};
+
+static const struct func_t rsu_func_t[] = {
+	{"dtb", rsu_dtb},
+	{"list", rsu_spt_cpb_list},
+	{"slot_by_name", slot_by_name},
+	{"slot_count", slot_count},
+	{"slot_disable", slot_disable},
+	{"slot_enable", slot_enable},
+	{"slot_erase", slot_erase},
+	{"slot_get_info", slot_get_info},
+	{"slot_load", slot_load},
+	{"slot_load_factory", slot_load_factory},
+	{"slot_priority", slot_priority},
+	{"slot_program_buf", slot_program_buf},
+	{"slot_program_buf_raw", slot_program_buf_raw},
+	{"slot_program_factory_update_buf", slot_program_factory_update_buf},
+	{"slot_rename", slot_rename},
+	{"slot_delete", slot_delete},
+	{"slot_create", slot_create},
+	{"slot_size", slot_size},
+	{"slot_verify_buf", slot_verify_buf},
+	{"slot_verify_buf_raw", slot_verify_buf_raw},
+	{"status_log", status_log},
+	{"update", rsu_update},
+	{"notify", notify},
+	{"clear_error_status", clear_error_status},
+	{"reset_retry_counter", reset_retry_counter},
+	{"display_dcmf_version", display_dcmf_version},
+	{"display_dcmf_status", display_dcmf_status},
+	{"display_max_retry", display_max_retry},
+	{"save_spt", save_spt},
+	{"restore_spt", restore_spt},
+	{"create_empty_cpb", create_empty_cpb},
+	{"restore_cpb", restore_cpb},
+	{"save_cpb", save_cpb},
+	{"check_running_factory", check_running_factory}
+};
+
+int do_rsu(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
+{
+	const char *cmd;
+	int i;
+	int ret;
+
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	cmd = argv[1];
+	--argc;
+	++argv;
+
+	for (i = 0; i < ARRAY_SIZE(rsu_func_t); i++) {
+		if (!strcmp(cmd, rsu_func_t[i].cmd_string)) {
+			ret = rsu_func_t[i].func_ptr(argc, argv);
+			/*
+			 * Some helpers return negative errno rather than
+			 * CMD_RET_*; normalise so a failure cannot kill an
+			 * interactive shell session.
+			 */
+			if (ret == CMD_RET_SUCCESS ||
+			    ret == CMD_RET_FAILURE ||
+			    ret == CMD_RET_USAGE)
+				return ret;
+			return CMD_RET_FAILURE;
+		}
+	}
+
+	return CMD_RET_USAGE;
+}
+
+U_BOOT_CMD(rsu, 5, 1, do_rsu,
+	   "Altera SoC FPGA Remote System Update",
+	   "dtb   - Update Linux DTB qspi-boot partition offset with spt0 value\n"
+	   "list  - List down the available bitstreams in flash\n"
+	   "slot_by_name <name> - find slot by name and display the slot number\n"
+	   "slot_count - display the slot count\n"
+	   "slot_disable <slot> - remove slot from CPB\n"
+	   "slot_enable <slot> - make slot the highest priority\n"
+	   "slot_erase <slot> - erase slot\n"
+	   "slot_get_info <slot> - display slot information\n"
+	   "slot_load <slot> - load slot immediately\n"
+	   "slot_load_factory - load factory immediately\n"
+	   "slot_priority <slot> - display slot priority\n"
+	   "slot_program_buf <slot> <buffer> <size> - program buffer into slot, and make it highest priority\n"
+	   "slot_program_buf_raw <slot> <buffer> <size> - program raw buffer into slot\n"
+	   "slot_program_factory_update_buf <slot> <buffer> <size> - program factory update buffer into slot, and make it highest priority\n"
+	   "slot_rename <slot> <name> - rename slot\n"
+	   "slot_delete <slot> - delete slot\n"
+	   "slot_create <name> <address> <size> - create slot\n"
+	   "slot_size <slot> - display slot size\n"
+	   "slot_verify_buf <slot> <buffer> <size> - verify slot contents against buffer\n"
+	   "slot_verify_buf_raw <slot> <buffer> <size> - verify slot contents against raw buffer\n"
+	   "status_log - display RSU status\n"
+	   "update <flash_offset> - Initiate firmware to load bitstream as specified by flash_offset\n"
+	   "notify <value> - Let SDM know the current state of HPS software\n"
+	   "clear_error_status - clear the RSU error status\n"
+	   "reset_retry_counter - reset the RSU retry counter\n"
+	   "display_dcmf_version - display DCMF versions and store them for SMC handler usage\n"
+	   "display_dcmf_status - display DCMF status and store it for SMC handler usage\n"
+	   "display_max_retry - display max_retry parameter, and store it for SMC handler usage\n"
+	   "restore_spt <address> - restore SPT from an address\n"
+	   "save_spt <address> - save SPT to an address\n"
+	   "create_empty_cpb - create an empty CPB\n"
+	   "restore_cpb <address> - restore CPB from an address\n"
+	   "save_cpb <address> - save CPB to an address\n"
+	   "check_running_factory - check if currently running the factory image"
+);
diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
index 530eb229f3e..9e7f8407b7b 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -57,6 +57,7 @@ CONFIG_SYS_PROMPT="SOCFPGA_AGILEX5 # "
 CONFIG_SYS_MAXARGS=32
 CONFIG_CMD_NVEDIT_SELECT=y
 CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_SOCFPGA_RSU=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_I3C=y
@@ -84,7 +85,6 @@ CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DW=y
 CONFIG_I3C=y
 CONFIG_DW_I3C_MASTER=y
-CONFIG_MISC=y
 CONFIG_MMC_IO_VOLTAGE=y
 CONFIG_SPL_MMC_IO_VOLTAGE=y
 CONFIG_MMC_UHS_SUPPORT=y
diff --git a/configs/socfpga_agilex_defconfig b/configs/socfpga_agilex_defconfig
index ba8dc821add..6e705ff0312 100644
--- a/configs/socfpga_agilex_defconfig
+++ b/configs/socfpga_agilex_defconfig
@@ -48,6 +48,7 @@ CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_SYS_PROMPT="SOCFPGA_AGILEX # "
 CONFIG_CMD_NVEDIT_SELECT=y
 CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_SOCFPGA_RSU=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
@@ -70,7 +71,6 @@ CONFIG_SPL_ALTERA_SDRAM=y
 CONFIG_DWAPB_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DW=y
-CONFIG_MISC=y
 CONFIG_SYS_MMC_MAX_BLK_COUNT=256
 CONFIG_MMC_DW=y
 CONFIG_DM_MTD=y
diff --git a/configs/socfpga_n5x_defconfig b/configs/socfpga_n5x_defconfig
index 3b3916e676d..7ad3b53cb6d 100644
--- a/configs/socfpga_n5x_defconfig
+++ b/configs/socfpga_n5x_defconfig
@@ -43,6 +43,7 @@ CONFIG_SPL_TARGET="spl/u-boot-spl-dtb.hex"
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PROMPT="SOCFPGA_N5X # "
 CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_SOCFPGA_RSU=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
@@ -65,6 +66,7 @@ CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_DWAPB_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DW=y
+# CONFIG_SPL_MISC is not set
 CONFIG_SYS_MMC_MAX_BLK_COUNT=256
 CONFIG_MMC_DW=y
 CONFIG_SPI_FLASH_SPANSION=y
diff --git a/configs/socfpga_stratix10_defconfig b/configs/socfpga_stratix10_defconfig
index 7b04859dec7..7f7958627e8 100644
--- a/configs/socfpga_stratix10_defconfig
+++ b/configs/socfpga_stratix10_defconfig
@@ -47,6 +47,7 @@ CONFIG_SPL_TARGET="spl/u-boot-spl-dtb.hex"
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PROMPT="SOCFPGA_STRATIX10 # "
 CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_SOCFPGA_RSU=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
@@ -70,6 +71,7 @@ CONFIG_SPL_ALTERA_SDRAM=y
 CONFIG_DWAPB_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DW=y
+# CONFIG_SPL_MISC is not set
 CONFIG_SYS_MMC_MAX_BLK_COUNT=256
 CONFIG_MMC_DW=y
 CONFIG_SPI_FLASH_SPANSION=y
diff --git a/doc/usage/cmd/rsu.rst b/doc/usage/cmd/rsu.rst
new file mode 100644
index 00000000000..b15b6e86184
--- /dev/null
+++ b/doc/usage/cmd/rsu.rst
@@ -0,0 +1,208 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+.. index::
+   single: rsu (command)
+
+rsu command
+===========
+
+Synopsis
+--------
+
+::
+
+    rsu list
+    rsu slot_count
+    rsu slot_by_name <name>
+    rsu slot_get_info <slot>
+    rsu slot_size <slot>
+    rsu slot_priority <slot>
+    rsu slot_enable <slot>
+    rsu slot_disable <slot>
+    rsu slot_load <slot>
+    rsu slot_load_factory
+    rsu slot_rename <slot> <name>
+    rsu slot_delete <slot>
+    rsu slot_create <name> <address> <size>
+    rsu slot_erase <slot>
+    rsu slot_program_buf <slot> <buffer> <size>
+    rsu slot_program_buf_raw <slot> <buffer> <size>
+    rsu slot_program_factory_update_buf <slot> <buffer> <size>
+    rsu slot_verify_buf <slot> <buffer> <size>
+    rsu slot_verify_buf_raw <slot> <buffer> <size>
+    rsu update <flash_offset>
+    rsu notify <value>
+    rsu clear_error_status
+    rsu reset_retry_counter
+    rsu display_dcmf_version
+    rsu display_dcmf_status
+    rsu display_max_retry
+    rsu restore_spt <address>
+    rsu save_spt <address>
+    rsu create_empty_cpb
+    rsu restore_cpb <address>
+    rsu save_cpb <address>
+    rsu check_running_factory
+    rsu dtb
+
+Description
+-----------
+
+The *rsu* command provides access to the Remote System Update (RSU) feature
+of the Altera Stratix 10 and Agilex family of SoCFPGA devices. RSU lets an
+application boot from one of several configuration images stored in SPI NOR
+flash and recover to a known-good factory image when an update fails.
+
+RSU is implemented in the Secure Device Manager (SDM) firmware and in the
+on-board Cadence QSPI flash. U-Boot talks to the SDM through the mailbox
+(or, when running on top of Arm Trusted Firmware, through an SMC call) and
+accesses the flash through the SPI-NOR framework. The flash layout is
+described by a Sub-Partition Table (SPT) and a Configuration Pointer Block
+(CPB).
+
+The command is bound to a driver-model anchor device with compatible string
+``altr,socfpga-rsu``. The node carries no MMIO; it only holds the active RSU
+low-level session while a command runs.
+
+Slot inspection
+~~~~~~~~~~~~~~~
+
+list
+    List the bitstreams (slots) available in flash.
+
+slot_count
+    Display the number of slots defined in the CPB.
+
+slot_by_name <name>
+    Find a slot by name and display its slot number.
+
+slot_get_info <slot>
+    Display the offset, size, priority and name of *slot*.
+
+slot_size <slot>
+    Display the size of *slot* in bytes.
+
+slot_priority <slot>
+    Display the load priority of *slot*.
+
+Slot management
+~~~~~~~~~~~~~~~
+
+slot_enable <slot>
+    Make *slot* the highest-priority slot.
+
+slot_disable <slot>
+    Remove *slot* from the CPB so it is no longer a load candidate.
+
+slot_load <slot>
+    Request the SDM to load *slot* immediately (triggers a reconfiguration).
+
+slot_load_factory
+    Request the SDM to load the factory image immediately.
+
+slot_rename <slot> <name>
+    Rename *slot* to *name*.
+
+slot_delete <slot>
+    Delete *slot*.
+
+slot_create <name> <address> <size>
+    Create a new slot *name* at flash *address* with *size* bytes.
+
+slot_erase <slot>
+    Erase the flash content of *slot*.
+
+Programming and verification
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+slot_program_buf <slot> <buffer> <size>
+    Program *size* bytes from memory *buffer* into *slot* and make the slot
+    the highest priority.
+
+slot_program_buf_raw <slot> <buffer> <size>
+    Program a raw (non-decompressed) buffer into *slot*.
+
+slot_program_factory_update_buf <slot> <buffer> <size>
+    Program a factory-update buffer into *slot* and make it highest priority.
+
+slot_verify_buf <slot> <buffer> <size>
+    Verify the contents of *slot* against memory *buffer*.
+
+slot_verify_buf_raw <slot> <buffer> <size>
+    Verify the contents of *slot* against a raw memory *buffer*.
+
+Firmware operations
+~~~~~~~~~~~~~~~~~~~
+
+update <flash_offset>
+    Tell the SDM to load the bitstream located at *flash_offset* on the next
+    reboot.
+
+notify <value>
+    Notify the SDM of the current state of the HPS software.
+
+clear_error_status
+    Clear the RSU error status.
+
+reset_retry_counter
+    Reset the RSU retry counter.
+
+display_dcmf_version
+    Display the Decision Configuration Management Firmware (DCMF) versions and
+    store them for later retrieval by the SMC handler.
+
+display_dcmf_status
+    Display the DCMF status and store it for the SMC handler.
+
+display_max_retry
+    Display the ``max_retry`` parameter and store it for the SMC handler.
+
+SPT/CPB maintenance
+~~~~~~~~~~~~~~~~~~~
+
+restore_spt <address>
+    Restore the SPT from the image located at memory *address*.
+
+save_spt <address>
+    Save the current SPT to memory *address*.
+
+create_empty_cpb
+    Create an empty CPB.
+
+restore_cpb <address>
+    Restore the CPB from the image located at memory *address*.
+
+save_cpb <address>
+    Save the current CPB to memory *address*.
+
+check_running_factory
+    Report whether the factory image is currently running.
+
+dtb
+    Update the Linux DTB ``qspi-boot`` partition offset with the spt0 value.
+
+Configuration
+-------------
+
+The command is available when ``CONFIG_CMD_SOCFPGA_RSU`` is enabled. It depends
+on ``CONFIG_ARCH_SOCFPGA_SOC64`` and ``CONFIG_CADENCE_QSPI``. The driver-model
+anchor device is provided by ``CONFIG_SOCFPGA_RSU_DM``.
+
+Example
+-------
+
+List the available slots and inspect the first one::
+
+    => rsu list
+    => rsu slot_count
+    => rsu slot_get_info 0
+
+Program a new bitstream that has been loaded to memory at ``0x2000000``
+(size ``0x100000``) into slot 1 and make it the highest priority::
+
+    => rsu slot_program_buf 1 0x2000000 0x100000
+
+Return value
+------------
+
+The return value ``$?`` is 0 (true) on success and 1 (false) on failure.
diff --git a/test/cmd/Makefile b/test/cmd/Makefile
index 8d6932f1176..63e1302af00 100644
--- a/test/cmd/Makefile
+++ b/test/cmd/Makefile
@@ -48,4 +48,5 @@ endif
 obj-$(CONFIG_CMD_SPAWN) += spawn.o
 ifdef CONFIG_CMD_ZIP
 obj-$(CONFIG_CMD_UNZIP) += unzip.o
+obj-$(CONFIG_CMD_SOCFPGA_RSU) += socfpga_rsu.o
 endif
diff --git a/test/cmd/socfpga_rsu.c b/test/cmd/socfpga_rsu.c
new file mode 100644
index 00000000000..af9f16567c9
--- /dev/null
+++ b/test/cmd/socfpga_rsu.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Tests for Altera SoC FPGA rsu command (usage path).
+ *
+ * Copyright (C) 2026 Altera Corporation <www.altera.com>
+ */
+
+#include <command.h>
+#include <test/cmd.h>
+#include <test/ut.h>
+
+static int cmd_ut_socfpga_rsu_usage(struct unit_test_state *uts)
+{
+	ut_asserteq(CMD_RET_USAGE, run_command("rsu", 0));
+
+	return 0;
+}
+
+CMD_TEST(cmd_ut_socfpga_rsu_usage, 0);
+
+/*
+ * Malformed numeric arguments (non-digit characters, overflow, trailing junk)
+ * must be rejected by the subcommand handlers with CMD_RET_USAGE *before* any
+ * RSU state is touched. This exercises the rsu_parse_num() / rsu_parse_slot()
+ * /rsu_parse_hex_* helpers without requiring a working RSU backend, because
+ * parsing is performed up-front and the rsu_init() call is never reached on
+ * the error path.
+ */
+static int cmd_ut_socfpga_rsu_bad_slot(struct unit_test_state *uts)
+{
+	ut_asserteq(CMD_RET_USAGE,
+		    run_command("rsu slot_get_info foo", 0));
+	ut_asserteq(CMD_RET_USAGE,
+		    run_command("rsu slot_get_info 12xyz", 0));
+	ut_asserteq(CMD_RET_USAGE,
+		    run_command("rsu slot_get_info 99999999999", 0));
+
+	return 0;
+}
+
+CMD_TEST(cmd_ut_socfpga_rsu_bad_slot, 0);
+
+static int cmd_ut_socfpga_rsu_bad_size(struct unit_test_state *uts)
+{
+	/*
+	 * slot_program_buf takes <slot> <buffer> <size>; an INT_MAX+1 size
+	 * must be rejected with CMD_RET_USAGE (would otherwise be silently
+	 * cast to a negative int, which is how buffer overflow bugs start).
+	 */
+	ut_asserteq(CMD_RET_USAGE,
+		    run_command("rsu slot_program_buf 0 0x1000 80000000", 0));
+	/* Garbage in the size field. */
+	ut_asserteq(CMD_RET_USAGE,
+		    run_command("rsu slot_program_buf 0 0x1000 qqq", 0));
+
+	return 0;
+}
+
+CMD_TEST(cmd_ut_socfpga_rsu_bad_size, 0);
-- 
2.43.7

