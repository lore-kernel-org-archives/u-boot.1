Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A60CE7A81
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 08:10:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76EAA86BE5;
	Mon, 25 Sep 2023 10:10:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Kh9w5lEz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 016D986B96; Mon, 25 Sep 2023 10:10:10 +0200 (CEST)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on070e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::70e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B235286B76
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 10:10:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVlKE0kCeyhtLj30Oma+a90mgUuajicth9wD0XidEm0Xopqm9HpykXv7Jjfg2ToBuvrPstiNU5/SrPCmWsbDm7lWU5Azvbwuybv1u/kUKUUFYLlV0eRCfyANhyf8dtCXep1Ryoge83YJYIm7b6/mKQQcjJxEWVBraJCzXA7DQITOBrzwR9BVNpB3u4x33R8vQ1m+/PW7Gpvk1hfimWhU0Xvh6JKcV7nrLfTRg3IYHN3rBXI11/y587sBFkufp/SGkXUyxmiAZJ1RWtzh4NQ/zrEHHugM2sPyooHvAM8RckgOAa171AulJQf0SJi7Zch2d1J5S1Oojz/oZhNZ1i6g5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHUgtcTVJQMVdnJXjTUYKq7dF7ZveZo6b4R63Keol48=;
 b=boAlT5h77M1Ur+2T563sPMvmb2UwgdzoDDhEeus0X8G9EW3Aby7eNlkvQydcCjsVo1foSPtGJiFEjOsm8UFvzj7SIFAE2czKEZWfkMgdn0Whi7HnSHy7tllv4Onz2TLRkj9/I3HgVAgJ0uLsiQH4lRs75Dy0JBEEDihejlnWNCyyQRjiqki7wC7e+Y5mauKmTCMSyzAhfDMtdHrI3QvVGQ1AXB/cXtwX32WDvRSarW/zYhKIhywoq7U6eSIporIvXAJc3BjymXZsjE1XtIdIFeeTGCXZ1nZT72z0oex1dHO54gJiIDutZbDIfdgXq+NBokvBzDhmH8QnDzMBsdLWLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHUgtcTVJQMVdnJXjTUYKq7dF7ZveZo6b4R63Keol48=;
 b=Kh9w5lEzHtN5qQnezsrxfFWhkjOAPcaweG4+rpeyp0sBjiYGGtqGxQTy7pkh+6ZhRz1me1ys1V4N1em1hhO0ds6VlE73OsxCZ1TzbD72jA+C0gMy/j/nvBXr3fOoCNRE12GMxXY6s4xq3OY5fLLPPNVJ0wKy3oD+G0x0xXdjoA4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS8PR10MB7399.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:614::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 08:10:05 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:10:05 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@denx.de>, uboot-imx@nxp.com,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jan Kiszka <jan.kiszka@siemens.com>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 0/5] use .dtso for device tree overlay sources
Date: Mon, 25 Sep 2023 10:09:04 +0200
Message-Id: <20230925080909.365098-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.37.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0007.eurprd04.prod.outlook.com
 (2603:10a6:208:122::20) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS8PR10MB7399:EE_
X-MS-Office365-Filtering-Correlation-Id: b85078f3-a775-44da-528a-08dbbd9ed36e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NmI4KGJauaPzyNNwzhTKZv9rRJa/DKPCkz1nVPM8OD9m5or3G85X2v4S7e7rkOP4SI4SVuAa2tC9Kg6TkVGYZ1rB4DTdRBIQGapKeM9CMTlbUSSCCCvRh9M4q72h5TYxQHPLxlLJcOL8OVwF7+BQtxCuzZ1Ffs1tTn2qQ7uGUxlWkyuV3Ic6Hqi9NGRXuN0rLXojFAVkTEjVbVCBMrFe8sWFsVYriHOL44SmK35z3SlPCcuiUvjMdJTO+sJBghAY4eMNdYb7uFI3vPnepGpIV9PKrxct5rYb4USHOXCucjlAG30qIqWQ/GCM5mJfe8KJ/5W7dbdYZr1rohJM3n0l1KBUB9uEJGmeRJ9LvkiYcaoq7i4veK4dJRgm0d+T0IEUruJYM6aUKOsejMUAMNoE9ugfoLad+tapmQ1EQwrjbLOBnFyoLJ/GHTENtFaz/B8x/XZ7pfmgNjipXThkBu7yPCTWMzlvGiiJ3ztYGaRCo9jUBOjqzyYYzk2nMvO/jtqAmoipAhbKvjypidrKAWymIyO4UKfoljwD0ym84E8ratdZqLHCOC7uW21y826C+zLxOfB13Xy+d/YmnDtYxjq8VNfg1WRALpLuikr1GaU20kSNzanrmxx3D+4TarDx8sU+xbndTSjCU9bwoOzdJfHg4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(39850400004)(396003)(366004)(136003)(230922051799003)(451199024)(186009)(1800799009)(86362001)(36756003)(6486002)(6506007)(26005)(5660300002)(52116002)(6512007)(54906003)(66476007)(66556008)(66946007)(2616005)(316002)(6916009)(41300700001)(44832011)(1076003)(107886003)(478600001)(4326008)(8676002)(8936002)(8976002)(2906002)(38350700002)(38100700002)(83380400001)(142923001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o1Eu0NFlWBUwY56dGlFngDZOdpk+r+1Y1uzl8IQTpjS2kjcKQkk427Lw8ysp?=
 =?us-ascii?Q?yycTvi2WeOl7fyBS2rMmdEr/NEXpadRZYFdCjd3Q/rjRdXsJIz2vpAoQPiiu?=
 =?us-ascii?Q?GRB5nlZiX3aCgyWbDlNjDPr9DVEbGWMD+vP41uOXoap/5+msC8YIfhdUHWoE?=
 =?us-ascii?Q?z+R950ACkCmRDko9wFFa2+vnHdNZS2SW/72LhpQijg4y1njgzZjvrABVUxuu?=
 =?us-ascii?Q?WTFXtjWtiD76GsyTWHBJBiQe+2kVvm95fVRL3KDuxBPphpb5Z39JBUaaf+5l?=
 =?us-ascii?Q?mh+RssEDg1uRa9/u2XZF5t9dg5R33yqx5sLKnLOGFFpvwvT4pTUPV2erXLGZ?=
 =?us-ascii?Q?NEUvkeKt1ayoMFgTrHIxRR3eSDILYsz35ext2F7VG/wspZzwGLAIPy+9o6r5?=
 =?us-ascii?Q?bS2mcCd+xfwGClM2HSURqzy/0mM9cQ00XOd/q22MA/aEgsNq3R1cejSXPSqX?=
 =?us-ascii?Q?ziz+wSahuqfONovWYMI+wRGL8fIlkizOjT0W6Hl/mBTkivpZXgfi6DGUQGUW?=
 =?us-ascii?Q?94xo4QiL2cpnVNnqSUdUKy7Lf9jxDRuxJDovtwRUfSo1E6R4dlfOBbrO6D4b?=
 =?us-ascii?Q?FkqO+JmK9yVAkKca9oFvwZo2azj8Jdk5novK6yO24PwTNF+5lWKR2lE+KA/1?=
 =?us-ascii?Q?+Yp+EAaHqJj0Oft9nR6LjrGTSh5S5Kg5AG4BpcUjxxOxEFgpbo1Q4JznBCcf?=
 =?us-ascii?Q?uNfH9xYI8GGchLQtD2sNQasvSbsR67FhgLhUeZF3wnM8L6MYUyvDGuasZIOz?=
 =?us-ascii?Q?pn6oQ9aBi6g/OrAldEIDU0NLzvqhP70pEBmRXsCPOun2WHLxeedIsyGR0PG1?=
 =?us-ascii?Q?t8pYHsocxwyRzfMK9fvQtxSSl7p2MFKJ0jKm+sUFNgisJIedhKWfxZxzgfKa?=
 =?us-ascii?Q?McX+CkwqleIQVpafYEpb40Ah4O+4jRebGtB/gBBTK5mSwEQmZNbRPRz7ZT2J?=
 =?us-ascii?Q?9X3C7SeSW/ErjMhsokJXApnvpcUShfy+OI0zRwEECf5nYtwasnLvxVz3MaIu?=
 =?us-ascii?Q?T0tcUpchBj/9dJDJPC3P+uOVMyk0/iAQvZz3yjEhKYZ4191pFljqYN4TgoKJ?=
 =?us-ascii?Q?Prv9GNt3enr1Lgbj/TfDbCwzqbF1481sgVDfN9nItdtrkDfOcO1EGRVK0HaL?=
 =?us-ascii?Q?2vxOR2kf1aovOiPlVQ7wyRw3fCUj1Q44BwNCD/04sayYUZELj8ZjkM7aqlvR?=
 =?us-ascii?Q?70EbuhT29gnVthEeZGnim1le+QOTtD5SPpSFZvv4w0QizP5S4Y1xdlgy1hvz?=
 =?us-ascii?Q?9oON1HzU4lArvy7ix8LTjD/ZVDqa/TeHn9XCjP7P5VMApX4E3a7L4l4ANcA9?=
 =?us-ascii?Q?+TdF7NEur5F5T52jx2nSL7mNAXJTqUaUW1/j1Ka14hywvg391jGCwnhTVqtm?=
 =?us-ascii?Q?dE8X6g4YV1fQgQP3jy9N7BHqyAFeoXyFHXK77q7ZFEjugH2jGw+r86vKJ98M?=
 =?us-ascii?Q?xtQUUFWLhjdmEMbpl75TBlcryWeQUvhEoI6zTIjvUM4EaQXrfAugwTho98I7?=
 =?us-ascii?Q?d/sHz1VX5Fh8lcKztHbshLgm6oJuTIUAg6nDvSpebb09DEhahq4I97pJXi3z?=
 =?us-ascii?Q?gwZSyR9/6uFtqj/R9aX5rr65OkLNKNd04Jn0LHvRBWFgMW1O7OKPVX/Tx75w?=
 =?us-ascii?Q?lw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: b85078f3-a775-44da-528a-08dbbd9ed36e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 08:10:05.3928 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BC2eXp//AMHnrzov3UUUNHzz2yjRnAYL+YN6iNcR07NwBHy9wzCLzQoWlGlttjQV1SwKLz8WfAdX34gGCIh5mTNdVo+Bu8EBRKqp8XnnF34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7399
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

All device tree overlay sources in the kernel tree have been renamed
to .dtso and, since v6.5 (commit 81d362732bac), the .dts -> .dtbo
rules is gone from linux' Kbuild.

Let's follow the lead of linux and do the renaming, and sooner rather
than later to reduce the amount of churn.

This is not quite complete as there are some files under test/ that
still need converting, but as they currently rely on being compiled to
.dtb (in order to, in turn, be applicable for the .dtb -> .dtb.S ->
.dtb.o rules), that's a bit more involved than simple renaming.

Rasmus Villemoes (5):
  arm: dts: imx8mm-cl-iot-gate: rename overlay sources to .dtso
  iot2050: rename overlay sources to .dtso
  arm64: zynqmp: rename overlay sources to .dtso
  sandbox: rename overlay sources to .dtso
  doc: use .dtso as extension for device tree overlay sources

 ...iot-gate-ied-adc0.dts => imx8mm-cl-iot-gate-ied-adc0.dtso} | 0
 ...iot-gate-ied-adc1.dts => imx8mm-cl-iot-gate-ied-adc1.dtso} | 0
 ...iot-gate-ied-can0.dts => imx8mm-cl-iot-gate-ied-can0.dtso} | 0
 ...iot-gate-ied-can1.dts => imx8mm-cl-iot-gate-ied-can1.dtso} | 0
 ...iot-gate-ied-tpm0.dts => imx8mm-cl-iot-gate-ied-tpm0.dtso} | 0
 ...iot-gate-ied-tpm1.dts => imx8mm-cl-iot-gate-ied-tpm1.dtso} | 0
 ...imx8mm-cl-iot-gate-ied.dts => imx8mm-cl-iot-gate-ied.dtso} | 0
 ...k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie-overlay.dtso} | 0
 ...s => k3-am6548-iot2050-advanced-m2-bkey-usb3-overlay.dtso} | 0
 .../{zynqmp-sck-kr-g-revA.dts => zynqmp-sck-kr-g-revA.dtso}   | 0
 .../{zynqmp-sck-kr-g-revB.dts => zynqmp-sck-kr-g-revB.dtso}   | 0
 .../{zynqmp-sck-kv-g-revA.dts => zynqmp-sck-kv-g-revA.dtso}   | 0
 .../{zynqmp-sck-kv-g-revB.dts => zynqmp-sck-kv-g-revB.dtso}   | 0
 arch/sandbox/dts/{overlay0.dts => overlay0.dtso}              | 0
 arch/sandbox/dts/{overlay1.dts => overlay1.dtso}              | 0
 doc/develop/uefi/uefi.rst                                     | 4 ++--
 doc/usage/fdt_overlays.rst                                    | 4 ++--
 17 files changed, 4 insertions(+), 4 deletions(-)
 rename arch/arm/dts/{imx8mm-cl-iot-gate-ied-adc0.dts => imx8mm-cl-iot-gate-ied-adc0.dtso} (100%)
 rename arch/arm/dts/{imx8mm-cl-iot-gate-ied-adc1.dts => imx8mm-cl-iot-gate-ied-adc1.dtso} (100%)
 rename arch/arm/dts/{imx8mm-cl-iot-gate-ied-can0.dts => imx8mm-cl-iot-gate-ied-can0.dtso} (100%)
 rename arch/arm/dts/{imx8mm-cl-iot-gate-ied-can1.dts => imx8mm-cl-iot-gate-ied-can1.dtso} (100%)
 rename arch/arm/dts/{imx8mm-cl-iot-gate-ied-tpm0.dts => imx8mm-cl-iot-gate-ied-tpm0.dtso} (100%)
 rename arch/arm/dts/{imx8mm-cl-iot-gate-ied-tpm1.dts => imx8mm-cl-iot-gate-ied-tpm1.dtso} (100%)
 rename arch/arm/dts/{imx8mm-cl-iot-gate-ied.dts => imx8mm-cl-iot-gate-ied.dtso} (100%)
 rename arch/arm/dts/{k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie-overlay.dts => k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie-overlay.dtso} (100%)
 rename arch/arm/dts/{k3-am6548-iot2050-advanced-m2-bkey-usb3-overlay.dts => k3-am6548-iot2050-advanced-m2-bkey-usb3-overlay.dtso} (100%)
 rename arch/arm/dts/{zynqmp-sck-kr-g-revA.dts => zynqmp-sck-kr-g-revA.dtso} (100%)
 rename arch/arm/dts/{zynqmp-sck-kr-g-revB.dts => zynqmp-sck-kr-g-revB.dtso} (100%)
 rename arch/arm/dts/{zynqmp-sck-kv-g-revA.dts => zynqmp-sck-kv-g-revA.dtso} (100%)
 rename arch/arm/dts/{zynqmp-sck-kv-g-revB.dts => zynqmp-sck-kv-g-revB.dtso} (100%)
 rename arch/sandbox/dts/{overlay0.dts => overlay0.dtso} (100%)
 rename arch/sandbox/dts/{overlay1.dts => overlay1.dtso} (100%)

-- 
2.37.2

