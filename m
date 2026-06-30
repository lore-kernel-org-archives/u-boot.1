Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A51C43602
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 12:51:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E8B284A6F;
	Tue, 30 Jun 2026 14:50:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="HDyWaP1o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D49B84A48; Tue, 30 Jun 2026 08:55:54 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFBFA84979
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 08:55:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nafHHUakqu/TF2rbzFj4v9uIPP0To2wPHrx9QEP2EFKlH1Fpl+rm+2yQEhZ8UqB1v9duMuA5wzWGVgYmgGgFtbIdzaD6o5eonbvRNiJmDXbiO0EZT8p7PGhdEVg6q0I0QRIblz7mQ0W0bCX+YZ26/bEcdygJiCjThDw3nHAsOXQl5chWuC5pkwZ3ZrZW3F/jh/zsFx5VyLXgdYHOzJZXcPh+vJbsTB4coe68BFxke6XNfleNit3pFDHTxYtHAJTSQdidceAHtsTlUZdFGYygY43v+6W4KuPxar5cc7ZKqUNdKUfEy6mkR2yF/+PCl2d7n+SIhAnk0aZNzfmhzes2rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8paaXXgPG1t2UjwWoff0+NAuQOB3TeNwjt71b/6hHfs=;
 b=q9U2RbVQWXdCznlH2lmuWgwqH/uZueGsfov7YXRU/BUX0xjcYAgjM2lJhNkQT3E3f5X9kx1e3TSeOyQNrXmPu9GphGWYjDn0bFC1TSuuyz6ZvDv+yzldJinabP+HZEouR9xLQUrgDsym/2vJZzLxkvjlfqC2Tn3PgzU34HjvHM6g07IYZXsLlE88dUXIAAt/I8TwqDWXbBRn2xgrpqljGzIlWUcoBRDvywTOmzGbiPcmtfm5KWx4qWu8CXI88qB6DA91j8lE8t+VEMz/bfggrMCM63baq4sxbjqVlVLqSgjkTWeHjf9blh45YX9LBhD6RFsbRvXZLWazkxtW1pHPgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8paaXXgPG1t2UjwWoff0+NAuQOB3TeNwjt71b/6hHfs=;
 b=HDyWaP1olqBQk5DMTfWcnbuhXjVdJVx5JRn9jxLO74xX3glIkkNsAsSVjUGxshKgyiUesC+W3ol3HjCm/I4p2A9i9NXCxu97g/mYhfWQtzDhbk5wgbvyZj3xEL3BkGUpEsTK5kzQM5DH2lTJ2ZzZJ8y0z5aNY2baoeceW3EvHI+wKyJTwmAqtR2SkqXDoQ4aG60/qZtumUwbWNoikPTlIylFXFHZqd9I+4gpcc2XfvzayRQDVjB294L3rA7mV5XVue0CkK81wwmDrJSzPtTxtR27KbgLT1243infhMwA1gw4r3KEiNEzavqnKETKzaNDnoWQRQMJ23YGBJn+W0Lq8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by DM4PR03MB6064.namprd03.prod.outlook.com (2603:10b6:5:393::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 06:55:48 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%6]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 06:55:48 +0000
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
Subject: [PATCH 0/8] arm: socfpga: Add Remote System Update (RSU) support
Date: Tue, 30 Jun 2026 14:55:16 +0800
Message-Id: <20260630065524.27680-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:a03:254::7) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|DM4PR03MB6064:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f1a52d0-6396-4327-0ff2-08ded6749ce3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|7416014|3023799007|6133799003|18002099003|11063799006|55112099003|56012099006;
X-Microsoft-Antispam-Message-Info: slpV2SBeQJontWC+OlVRXFSY3CGiuycWckKvaA64epXLfg+ccibwRMWibc1wKWEYwxLqWDs2pgrg5pY19A7MRxY92EtY5jLP2Z5bKF9Gd6xdWXzB1o+ou17o7GuhBrS5bqpkQq4pZEXrtXYL3pVi7YjrSCY4yYxX4DXqhNFqE9C/V+eEjn95bwEfvXaUDB+Yc+4eeQMDGk6+WMdLgWfmnuAY0+pfJK1fZtu42uGCHxxDEJ2k3Ja76XZKn6+W2LEartRuFDZdR5I01Hrb1vSUR01vTwsXxmN2PIgnjW+9oq9b+uVBg35R2pmqtABmfD25QGtOLS2FjUXzqCfmWRFC2d6UbrMJBcUMHQJHkdmAtdUnFqTz+z414152OXzcZoHtD4peP2ezWCPNn7q8Dl3Got5H42l3zA7UWSEO1V5KWxc8gOzLSKrs3H8AmJ0Nq+Ppxr5ZpfwGpK1/U4VcI0TX09HjPvDbz6rAci1+Epx6JCOhGnUNiFHVg8VhYUNONAAcxc9AGrLLpULFvyBsUJqZbmHyc2nO/xCCS5C6BnM0WVSxzNtrHN58FR1FZglRNpgF5czfDkxqK03jlSc9YqvohUs5v4BBmFrdEouQUCrlDqiRuGL1s7mh5rC5WVsL/IUIDLw6oo+SOtKIhP0Kk+ze87zvKJVZsiKrIHLB7EOp3GI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(7416014)(3023799007)(6133799003)(18002099003)(11063799006)(55112099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1HcYyL3XEu5FLbnM2gD//wKUZ4yQvAcyvy/HVNo4FSthXFwzYAQn3P3LSZ1y?=
 =?us-ascii?Q?+vfZ+S8NJXLAnaskKiTY8PMX3XR6kzNvKXU0XZcZHItRlSqKtkaDL1ScRJw+?=
 =?us-ascii?Q?Ssckdkee2t1IRweDLVc/65EV+rCVanTAV9Pdqfqey6d477j0qVDlwOfaTS7G?=
 =?us-ascii?Q?goXFKJAXwlx5RuJMORbL8Dz/tLgurjCqg9QgeeT3vC+8Mzl/vucRxpUQSqKA?=
 =?us-ascii?Q?J4zOtliS9dEGaZSzgFPq32jDt1bTYEi3IIo7jZpgPsJRD6p9YUZVyJH7tgdY?=
 =?us-ascii?Q?eFuaFjBZD9hcMxOBsYeFL0s6AnNyVWWGqYdAtkGX5TiRfecAsrxpql8zzBKP?=
 =?us-ascii?Q?/o7tvvnxrYLRgbXcc+qp36XcIa6ob75wa0+AJL3CBOt7hA19MX1DyYd86dVf?=
 =?us-ascii?Q?JjoSWCxoK7pzuEpd3BrDDhbEwkSumxSvYLEZYSd6u0WLIwXpOOGn2CP2vHAh?=
 =?us-ascii?Q?rBk1eq89CR3dSzIcSFLIBlvflO6CHBhiaTpNqPs74SEsTbd0WjK8Q8Sv3Rhx?=
 =?us-ascii?Q?otwF88YJafXdCvBMNJLH7Zt5xRVdCFE58N+eNQv4p7YdRTdAV4vQyJBnZ32q?=
 =?us-ascii?Q?p5vOlgw0up87WVGt5nlrDmzMsYN40vHt0YF4LPZzMlzZ9kyXiH312vEnwND4?=
 =?us-ascii?Q?cQFfrFj3NMhyuGjLttCn+jLn6b5fJqH93y19hmskvmKRSpe6Tvz1jJbniaTd?=
 =?us-ascii?Q?lTBOKN6QtCm1IBWKhRnD5Iqnij2o58OeeqdLnsocEJhKPRXAJXK9wHLWFhfC?=
 =?us-ascii?Q?DL2/gLMr0MJGqdzhb5fI/YSThW5Wj2SD9NwhcYqkQHmuJPViabtfAqgJ9HKm?=
 =?us-ascii?Q?23BlLiKQyys9j36BMiQVbL1dU2T4HSR745TA5Ntah9+jGc8f2iVF+a41IJv/?=
 =?us-ascii?Q?rx6FzKQg9SCzOhBcwi2wjeJRjoMzuwIKKBOWsApfeTDFTOFFhHoprU5krN8N?=
 =?us-ascii?Q?t7irq3BV7aY6wez96QyGmxxFKqeLWbAXYOAJvN8N8pJgIVKs4narDSMr0REx?=
 =?us-ascii?Q?yD6c+LL2hbYwVEzyv6BsHmGfCu7yDvKN+/Z1e/aDKHpD1KP2xjYztEUhvlLh?=
 =?us-ascii?Q?wNCTj4PidjVQaYKzyp3n8/v+i5K1u53M0nj21JkzDEub1X5pUYxx2DVVyDto?=
 =?us-ascii?Q?zr4oNUkCR0rF1zex4kt1UIuEcYTJ+FL3yzb1rQRBSNv58PHiGlxVhdbuqEtv?=
 =?us-ascii?Q?DUIaLDXVisiQPFXKdsxX6BYy8eKwlkE6aD+QatYL+T7zvAB0FYFzsbD1pHGq?=
 =?us-ascii?Q?7d8ycDZ0dQShiCwBw7MlDxQkouwh3pzwyCEjrcs2rFBtKDOeYT5qzJ+2yl1V?=
 =?us-ascii?Q?jJIhyL2sg7wjMcmsAZVqTSz7v0f26C3nQjoyN5AgZZp2Y7Yen5+LwFIZK5Zf?=
 =?us-ascii?Q?yWQM31BQ0+gcQ3HoQhJ3BB/a/MsiosT901axvAvNEiB8Z7FjA5GWMtu3gZw9?=
 =?us-ascii?Q?25vUJ7o+SN2iZuKDJ7vWxykBnoM0/IvJWQ/KwywU9cVgx4FWLnRDtOfBwjOA?=
 =?us-ascii?Q?RnQA6livaXsv7ANJRUZn6+m3beZ+mcojBwvnL6qxD3Ai7VQt2Fyp2stNh1jh?=
 =?us-ascii?Q?EDBKzhwKJvkPgSdewoByRdZvKTG7RImSYSxuMjylJMh8TZ/Lv6ihwfsXqvqz?=
 =?us-ascii?Q?SIM9mxeRpQy4oW8vKiWldDXVlxi2ZLTafYpIAyGYpxgge/CIP+Kj85kgNTCp?=
 =?us-ascii?Q?OJK/3+UXRoZ/b524/3xqsF9RDKQXRB3VRvQr2UN9agWn3hytILaenyzI0FYi?=
 =?us-ascii?Q?mx/HYl4Drcq5JslkztSyTEJS5eBwwRE=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f1a52d0-6396-4327-0ff2-08ded6749ce3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 06:55:47.3911 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cJ6RNm+hOI68gvfCyjx6d8YjtcOoB1K2rMnxyrxgIWwADf3o9Tv+cTbuFdQTkBCWmKTfXLQ1RzVkKqn3heYE4sCF9caPd2HNpVnplDpJZ0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6064
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

This series adds Remote System Update (RSU) support for the Altera (Intel)
SoCFPGA SoC64 family (Stratix 10, Agilex, N5X, Agilex5 and Agilex7m). RSU
lets the application boot from one of several configuration images stored
in QSPI NOR flash and recover to a known-good factory image when an update
fails. The flash layout is described by a Sub-Partition Table (SPT) and a
Configuration Pointer Block (CPB); U-Boot talks to the Secure Device
Manager (SDM) over the mailbox, or via an SMC call when running on top of
Arm Trusted Firmware.

The series is structured as small, individually buildable steps:

  1. mailbox: the RSU SDM mailbox commands (prerequisite).
  2. The core RSU library (session, SPT/CPB handling, QSPI low-level
     backend, SMC client) under arch/arm/mach-socfpga/.
  3. An optional UCLASS_MISC driver-model anchor ("altr,socfpga-rsu") so
     the RSU session lives on a DT node rather than a file-scope variable.
  4. The "rsu" console command plus documentation and a sandbox unit test.
  5. Multiflash support (RSU spread across more than one QSPI device).
  6. SPL multiboot SSBL selection and SSBL fallback.
  7-8. Device-tree wiring: the DM anchor node for every SoC64 family and
     the boot-partition label used by the label-based partition lookup.

The generic env/SPL hooks (env/sf.c, env/fat.c, common/spl/spl_mmc.c) use
weak functions that default to existing behaviour and are only overridden
when CONFIG_SOCFPGA_RSU_MULTIBOOT is enabled, so non-SoCFPGA boards are
unaffected.

Built for all SoC64 defconfigs and verified on the U-Boot CI (world build,
sandbox and qemu test suites all green). checkpatch reports no errors.

Dinesh Maniyam (8):
  arm: socfpga: mailbox: Add RSU mailbox command support
  arm: socfpga: Add Remote System Update (RSU) core library
  misc: socfpga: Add RSU driver-model anchor device
  cmd: socfpga: Add rsu command for Remote System Update
  arm: socfpga: rsu: Add multiflash support
  arm: socfpga: rsu: Add SPL multiboot SSBL selection
  arm: dts: socfpga: rsu: Anchor RSU DM node across SoC64 families
  arm: dts: socfpga: rsu: Label boot partition for label-based lookup

 MAINTAINERS                                   |    6 +
 arch/arm/dts/socfpga_agilex5-u-boot.dtsi      |    4 +
 arch/arm/dts/socfpga_agilex5_socdk.dts        |    2 +-
 arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi |   16 -
 arch/arm/dts/socfpga_n5x-u-boot.dtsi          |    4 +
 arch/arm/dts/socfpga_soc64_u-boot.dtsi        |    4 +
 .../dts/socfpga_stratix10_socdk-u-boot.dtsi   |    4 +
 arch/arm/mach-socfpga/Kconfig                 |   43 +
 arch/arm/mach-socfpga/Makefile                |   12 +
 .../mach-socfpga/include/mach/mailbox_s10.h   |   16 +
 arch/arm/mach-socfpga/include/mach/rsu.h      |  419 +++
 .../mach-socfpga/include/mach/rsu_flash_if.h  |   96 +
 arch/arm/mach-socfpga/include/mach/rsu_ll.h   |   94 +
 arch/arm/mach-socfpga/include/mach/rsu_misc.h |   65 +
 arch/arm/mach-socfpga/include/mach/rsu_s10.h  |   46 +
 arch/arm/mach-socfpga/include/mach/rsu_smc.h  |   14 +
 arch/arm/mach-socfpga/include/mach/rsu_spl.h  |   14 +
 arch/arm/mach-socfpga/include/mach/smc_s10.h  |   37 +
 .../include/mach/socfpga_rsu_dm.h             |   18 +
 arch/arm/mach-socfpga/mailbox_s10.c           |  141 +
 arch/arm/mach-socfpga/rsu.c                   | 1210 +++++++++
 arch/arm/mach-socfpga/rsu_ll_qspi.c           | 2402 +++++++++++++++++
 arch/arm/mach-socfpga/rsu_misc.c              |  854 ++++++
 arch/arm/mach-socfpga/rsu_s10.c               |  459 ++++
 arch/arm/mach-socfpga/rsu_spl.c               |  388 +++
 arch/arm/mach-socfpga/smc_rsu_s10.c           |  188 ++
 cmd/Kconfig                                   |   11 +
 cmd/Makefile                                  |    1 +
 cmd/socfpga_rsu.c                             | 1048 +++++++
 common/spl/spl_mmc.c                          |   24 +-
 configs/socfpga_agilex5_defconfig             |    2 +-
 configs/socfpga_agilex_defconfig              |    2 +-
 configs/socfpga_n5x_defconfig                 |    2 +
 configs/socfpga_stratix10_defconfig           |    2 +
 .../misc/altr,socfpga-rsu.yaml                |   41 +
 doc/usage/cmd/rsu.rst                         |  208 ++
 drivers/misc/Kconfig                          |   16 +
 drivers/misc/Makefile                         |    1 +
 drivers/misc/socfpga_rsu.c                    |   30 +
 env/fat.c                                     |   64 +-
 env/sf.c                                      |   33 +-
 include/env_internal.h                        |   11 +
 include/rsu_console.h                         |   14 +
 test/cmd/Makefile                             |    1 +
 test/cmd/socfpga_rsu.c                        |   59 +
 45 files changed, 8088 insertions(+), 38 deletions(-)
 create mode 100644 arch/arm/mach-socfpga/include/mach/rsu.h
 create mode 100644 arch/arm/mach-socfpga/include/mach/rsu_flash_if.h
 create mode 100644 arch/arm/mach-socfpga/include/mach/rsu_ll.h
 create mode 100644 arch/arm/mach-socfpga/include/mach/rsu_misc.h
 create mode 100644 arch/arm/mach-socfpga/include/mach/rsu_s10.h
 create mode 100644 arch/arm/mach-socfpga/include/mach/rsu_smc.h
 create mode 100644 arch/arm/mach-socfpga/include/mach/rsu_spl.h
 create mode 100644 arch/arm/mach-socfpga/include/mach/smc_s10.h
 create mode 100644 arch/arm/mach-socfpga/include/mach/socfpga_rsu_dm.h
 create mode 100644 arch/arm/mach-socfpga/rsu.c
 create mode 100644 arch/arm/mach-socfpga/rsu_ll_qspi.c
 create mode 100644 arch/arm/mach-socfpga/rsu_misc.c
 create mode 100644 arch/arm/mach-socfpga/rsu_s10.c
 create mode 100644 arch/arm/mach-socfpga/rsu_spl.c
 create mode 100644 arch/arm/mach-socfpga/smc_rsu_s10.c
 create mode 100644 cmd/socfpga_rsu.c
 create mode 100644 doc/device-tree-bindings/misc/altr,socfpga-rsu.yaml
 create mode 100644 doc/usage/cmd/rsu.rst
 create mode 100644 drivers/misc/socfpga_rsu.c
 create mode 100644 include/rsu_console.h
 create mode 100644 test/cmd/socfpga_rsu.c


base-commit: 77a48fa272161df9b778ffc09af814eec11cddd2
-- 
2.43.7

