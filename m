Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF41EA8108
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 12:42:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F19C83D9F;
	Tue, 10 Feb 2026 13:42:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="U2qEGHq6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF19783CBD; Tue, 10 Feb 2026 10:00:57 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90B1B83CEA
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 10:00:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TfuI6wxf5OPe3ddw7/xuzU6kTO+DcMdxkcpDhOT25OyEh4e7+++HybplBKM4WJoCs9Wi8e1x6YMQ8tXr8ohrysDKoLxdH3ROk4ulV4wJRHBQNwxRPAthXsKT6FJiW04SocLZxWPuIP/wz3FtdiAKneHNsQdfzpRfwlnaBwcU1pR6z//WazIkWbf0Bc98nMsE3Bwul3DNsy3lLHJ5BM3XFs5JeMY9DDFSMREiVYGMJZEFEMpPkRfGodBQUgdoitNqIMcCJuwyPON9eaWS2jBqmgA1abeZjQfEfLqv99qt0urdgUQR2BNjIq1y63HmbKcqCcFWCgYMt+jGSbR8I/Hmzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kk7KxGDnELiOPhMlmnr5j8QtJa7bH+owPyG5IJBLrl8=;
 b=EgXn9pFBujSzCDDuG9oCqo3YSRrfaFHSZLI1UyJeQImqYkcUeg9pFZCV5xIyHRTwz5D2O7lN74bZHueRO5tMyBn5qRGbCowb5dkVhAKo1RAp/cawK/4yuF3I7rnnfSCwj4YmosHqZX6nA2Y6me8cGRXMjRKjxvBz3unj6yzz0dUffLJpTjEkoemgkNu1MmYPI21m9m1XTMNRXdENZzJgNdWNheCys/BIm8SG92FZIOT19VVQFwnQ2bMc98KvQ5rNYhMjkAmWcVVYNx30CGfJVCVQ8x3nI2h13/wHkGOaxLl2BubMiTm5TPrEc/5xEIHGry6xvMTATPJNJ1fve/pX0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kk7KxGDnELiOPhMlmnr5j8QtJa7bH+owPyG5IJBLrl8=;
 b=U2qEGHq6q7HaMLldMSlY8FTuXBIcn/FmnSW8Xwcz9S9OXd5N9iaNC5n3nc+KgVgc3+WTbYX6ddcWOD2vN9iHTc/a14m8DQVyN2QgUEMWYPJ4V6/FBWxP+dDg9hj4pZ59IaBtSPQDb13pXyMogMEls62p//lmwDPejkKOdpa2Ljq6/MkkqlZ1gzzJTWIiEVOeCJLgcMUEg2AGpUNSadVo8ruMqzpiKFw4XEd9/rJM2eAYU3Pqns5XpV54NI+4mFyxNeMxB1dJTdVTStB4QrhL6OUbeqdNk4GQNEZtynwwI0GxgHjME1refbHsKA9Sa6i0L2QmpCjdxNp6Xc3scWyIeg==
Received: from BYAPR06CA0060.namprd06.prod.outlook.com (2603:10b6:a03:14b::37)
 by DM3PPF0A7785735.namprd22.prod.outlook.com (2603:10b6:f:fc00::e07)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Tue, 10 Feb
 2026 09:00:50 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:14b:cafe::e) by BYAPR06CA0060.outlook.office365.com
 (2603:10b6:a03:14b::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Tue,
 10 Feb 2026 09:00:49 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=atlrelay2.compute.ge-healthcare.net;
Received: from atlrelay2.compute.ge-healthcare.net (165.85.157.49) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 09:00:49 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id 1794FF882B;
 Tue, 10 Feb 2026 11:00:43 +0200 (EET)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: u-boot@lists.denx.de
Cc: Brian Ruley <brian.ruley@gehealthcare.com>, Adam Ford <aford173@gmail.com>,
 Alexander Graf <agraf@csgraf.de>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Alison Wang <alison.wang@nxp.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Andy Fleming <afleming@gmail.com>, Angelo Dureghello <angelo@sysam.it>,
 Bin Meng <bmeng.cn@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 David Zang <davidzangcs@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Mario Six <mario.six@gdsys.cc>, Mark Jonas <mark.jonas@de.bosch.com>,
 Michal Simek <monstr@monstr.eu>, Miquel Raynal <miquel.raynal@bootlin.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Peng Fan <peng.fan@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ricardo Simoes <ricardo.simoes@pt.bosch.com>,
 Scott McNutt <smcnutt@psyent.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Stefano Babic <sbabic@nabladev.com>, Thomas Chou <thomas@wytron.com.tw>,
 Tom Rini <trini@konsulko.com>,
 Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
 Wolfgang Denk <wd@denx.de>
Subject: [PATCH v2 0/6] Enable the IPUv3 driver to use CCF
Date: Tue, 10 Feb 2026 11:00:22 +0200
Message-Id: <20260210090029.728636-1-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <"20260205141332.2515996-6-brian.ruley@gehealthcare.com">
References: <"20260205141332.2515996-6-brian.ruley@gehealthcare.com">
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|DM3PPF0A7785735:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5bf47d2e-9bbb-49c7-3d31-08de6882e352
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZSqcH2j9QJuBlInYbvaP1aiu+fiUfH8fi0YcbOqAc6vC3co7Nvr4kUgIxUjS?=
 =?us-ascii?Q?ZfetTG9Np67Rh0lffCpgNAtF2EuHd67LzuimSuGYrPuSJfVDiR28jXDaDnUB?=
 =?us-ascii?Q?qs/mL1a+dxJqQ9RkCShlEUB/ALKVLxiRFu/2SBkUa2E7rG1swOSlQtAgcFEN?=
 =?us-ascii?Q?jzCgHv/bHZKlQIDtwLMvca9Fdis/Bp8kwmnNQ9xoSQ3QMUt7GVFAN+GK/3cz?=
 =?us-ascii?Q?0DgKh0RXyVXjHB7ucykDYWJQL1nPaGKiBlrhZYC8otWTJiLSJVk2KIwhBoZm?=
 =?us-ascii?Q?lTy6ObSfj2tFpC6clk0Pgy/fAc5jrzLsTRox9lGbYbxO/iTmV7SM22DfxNpp?=
 =?us-ascii?Q?x3TAJXitdiWaOGHgOqXMQbXUqz70jNNMG0UUNC6Uc4MZ3hqvQnRK1FQaDrNZ?=
 =?us-ascii?Q?XW2m1MXuoy74ZdM6cGoIBUEJz/HX7LjBbe0iH/HyVzBEjf2gz/B/0P4YdCqF?=
 =?us-ascii?Q?a3OaNic2m2Wi0GaMtmW0cjfxQnHjRMW96JLsqreN/dctvq1WDsQf5jpUscDr?=
 =?us-ascii?Q?/dI0YKBQNIte4b8RdMufzqa3tYC43DIKgjWWqarRGRs2ie4MMwkbVUOK1Wr1?=
 =?us-ascii?Q?pKkPFj/ZxWRCS4Ijuze9fg4fv269Mm2d7leXqFACukWjN8jktNeq8PnSOPrQ?=
 =?us-ascii?Q?qmfJDc5rEDq39wJi1ynzAmxt9Q2rdezYVhg3dBqaUwl0ZJKkYtUaFj230m4a?=
 =?us-ascii?Q?4d0z/E9hHogzEPWduvnlqU42xBsq9ksmZUq/NWQ0tjqh3JVJvR/0gYv2LDMZ?=
 =?us-ascii?Q?kGz0wmLSf7/P7vj/zmFTzZvCXhvhsjmMA4W0vTcdN/bPlYctJP0xmfsBE9yF?=
 =?us-ascii?Q?XhaMQziWxt5CXL8MGbC4IsydHhWcELY8CQ6XG7BQCKUG+MZI9u97YL0ZUnx+?=
 =?us-ascii?Q?BJWn+MpyjoIh7acPauC9EoPx03WgW2n77l6XCy5FzGQ04OG1OBBu4+zz/pEt?=
 =?us-ascii?Q?v6xN9EYC/3AGDTlR9RpXY/7FAvugw297ANoVlISP+mNDy86vJZH13bQoYf1D?=
 =?us-ascii?Q?rlmQ9zpMqFd3nRBL+8E8a271rEF7dHPkBgVnRo/vMokB74XAKeCLwAx1rhyD?=
 =?us-ascii?Q?EQjo4gB1Fn72lBnvKLsl8QNdn54hSwJ8zXscS8k80kS3TFOQJp9kOwcwXNZg?=
 =?us-ascii?Q?zKfRP/RyAXtOQgH/0QfvCjmdjvGWRTsoa8Whvd8iXkZ7l7Og/+qcb24qX8wc?=
 =?us-ascii?Q?c/06uPJ7nESr3fsgN4o6BIkzJuZ4pEEZ0QUXeQiuHoUqonkUYotB+X3L7Tle?=
 =?us-ascii?Q?MN8YbYBPfPUj9oOGwB3EYhfDAl1nd0rUUiFYaXOayei4JxkWRbVZ6mhKyH/P?=
 =?us-ascii?Q?5SZ64xsyo3wJtiUJQRGinodfU84xau4CPE45q2ACXSK6ZGQf11jpjYUQ5OJ6?=
 =?us-ascii?Q?nkabCQaoX+jAexYeCG/NZqXgCZg00hAua/nYlUNP4oOkVUMjESgbdEZA/IFf?=
 =?us-ascii?Q?aB3tF/fUa+ypJPenrs0qbrHtc9QQRhKLHvzaAMeoW2FDrms8fVY4l7sNvWHX?=
 =?us-ascii?Q?5m+MumzXbUL6YDos2zY2KEWAW8+h0uafFmewn2gagPmchFttUPRC0Ob2EqNV?=
 =?us-ascii?Q?y70O5lyr3+qRtIcbFUMQu/JoK0rdzXRsAqvX0JMArgBl65OEI2y0nbjNxRw4?=
 =?us-ascii?Q?5Q/2dKz93TT88Y8KjRD5nTp+p+3IfNUPb2ZgncwCrAkMETS1o6n6wNltGkM7?=
 =?us-ascii?Q?n2okmQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:atlrelay2.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ekXcQO/ezROoYNDi3C23BNIdN7rPb2RSOWLMBQPJM6SsNkDxgolUr+ERGH/fs2gGOK9KIYFgUtkJnzAKF1Dt4H1TcXd+KJ8HhJhYujL4pEMWI9I+Koa0aB7jEBLimoTkvM8oX/Y8+AN9wioMLWj8RTO5Xi7xDqWPDrDGfqlPQebYO1nK74v3+cqMFrmtmin8w0GDdLxgLdCGyOGrUCXGpcoNRBVAhbaYwEumMYAVIBCTIadQrriTtjt7tJwnKz/nHAxeBqpvhfxy/hdwkgoMKDSjFPfIzfmMD3n0elt/aUNmDuesI+dFyn3PEWA9eRvrysYpZDOAW4E7R1Hl8Uzt8CzTFCet2G0iHd4LSvtgNQsD4I1nbQ4upom944ya6FV0JOILvkmEmtDZMBvBiTd8VWuI4yYJfTLrhA35RBIt5Ehbw6pZTo2KmrLiS/AyWGU3
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 09:00:49.9920 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf47d2e-9bbb-49c7-3d31-08de6882e352
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[atlrelay2.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF0A7785735
X-Mailman-Approved-At: Tue, 10 Feb 2026 13:41:53 +0100
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

This is a continuation of an earlier series to enable the use of the
common clock framework to set the clocks used by the driver. This gets
rid of some conflicts, most notably commit bfc778cb93a ("driver: pwm:
pwm-imx: get and enable per/ipg clock using dm"), which would cause a
linker failure if CONFIG_CLK and CONFIG_IPUV3 were enabled
simultaneously. But, more importantly, this is how things _should_ be
done when we have CCF.

When making these changes, I considered adding driver support for the
LDB, which might have been a cleaner approach. Ultimately, I decided
against it since this is an old SoC, it would have required more work,
and in the end, all we need is the LDB to supply the clock when using
the synchronous external clock mode. I **hope** I got all the clocks
right.

Please let me know what you think!

Br,
Brian

Changes in v2:
- arch: imx: fix incorrect shutdown call for inactive video devices
- Removed DEBUG define that was missed

Brian Ruley (6):
  arch: imx: fix incorrect shutdown call for inactive video devices
  clk: imx6q: apply clang-format
  clk: imx6q: add ipu and ldb clocks and dependencies
  pwm: pwm-imx: enable ipg or per clks only if CONFIG_CLK enabled
  video: imx: ipuv3: move clock code to legacy
  video: imx: ipuv3: use clock framework

 arch/arm/mach-imx/cpu.c            |   3 +-
 drivers/clk/imx/clk-imx6q.c        | 410 +++++++++++++++++++++++++----
 drivers/clk/imx/clk.h              |   9 +
 drivers/pwm/pwm-imx.c              |  48 ++--
 drivers/video/imx/Kconfig          |   7 +
 drivers/video/imx/Makefile         |   1 +
 drivers/video/imx/ipu.h            |  60 ++++-
 drivers/video/imx/ipu_clk_legacy.c | 310 ++++++++++++++++++++++
 drivers/video/imx/ipu_common.c     | 371 +++++---------------------
 drivers/video/imx/ipu_disp.c       | 142 ++++++++--
 drivers/video/imx/mxc_ipuv3_fb.c   |  17 ++
 11 files changed, 951 insertions(+), 427 deletions(-)
 create mode 100644 drivers/video/imx/ipu_clk_legacy.c

-- 
2.39.5

base-commit: b5213bbfdcb1812be510427857827ee8becb9f8f
branch: video-imx-dm-clk-fix
