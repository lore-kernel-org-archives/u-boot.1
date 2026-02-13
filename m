Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1FDFEDF160
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 13:24:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D41B083AA9;
	Fri, 13 Feb 2026 14:24:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="iE4x3gTW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7B5F83DCA; Fri, 13 Feb 2026 09:50:12 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8856480FA1
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 09:50:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fcLwKsuzhRKpxdhsT+P5bZrscT6oq8gQNKjodfZx2gKyOA1odCR4kZrpuXvbaWQRMEkt0WOGCh/UPUiiMRfR9F9HKHTwrTPgMErLmAig1kLjJ4NbvHAsEaZwseILWMlNNefyJtXnteYQKRKBYpLkEsOsViSRTBchRX/1wb29m2fxVL9iOI0EDW1PDiLtsc+uztVFfb590+JmVsaJliojOc6Yb6XHOuZ8DaZvv6bfY7Pbd1qcsEReyq5gsDwOJPai3bb6ZELsymfrrCqn47I4KMRLvVJqyNCWhtzmgAcXSsiG4k250Zy9jyNVrFdeTevLqaS6VQjXXcAYC0/VgPaa+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qqpZSTiZ9tgk+C77GC6TaA2SpFAxpGiKyAWL5Xm0Ko=;
 b=UO0ku9XYhZ2NguUC5r6o9cVn405qTt/i9DMFFgLOX8yF+qAqIIUDtJz8OiqWvdXg4N9xCI2emrkfaC7WmKwMzgwdJtH1nvGz+5BagBF9suamPMbPXVnpbhMPBtWOORS6jSMj7YCiRzRDDLAT9W//2uGQxzQouAQEMsClUWhoKKRVjQeccZH2VLPXEx5ViJU5PLyaHxOJ6uf2ONx865M3DD/RB+hB3P41h7Dmyrtjv4QhpLUEC000/t4DiXbv9nzg815N4s+/fr8Gveg3bCCV/o34o+SmJ7ZNkwf7x0LmIOOdtCbmWzkjnDSo4Xwx5hc/fxBmiSoNIOQ4fM2QnIS/aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qqpZSTiZ9tgk+C77GC6TaA2SpFAxpGiKyAWL5Xm0Ko=;
 b=iE4x3gTWAizmfBJc/faCHNfLpsXgMoK1b66+62ygeAVbhmA69Tqt9GKO52wnJuG+2W94mW0Hj60tYwRKFJ7QrsLWxcRt4z11cFLpUPXFXpoBpSvMJAdu3NvWhipiIO5/DSffBYpoqaA3XONMyuowbMEzdwFT3CVd9ST+mlY0jewDeHPMEWZWnrTTUEeQVF109ONw6cMSlwqYgNdtLrQB7Qy2g1nKLdbXP5NhYzGgiMPiY8m2DWDd0yBqYTKUsZztJvU276YDmRG6vNVOXj+VisVWvxa0K95TSJv/8mEHOKMD40IPvGUAR6dIEuFM4NUdWeSCpZ+nKi2+EgOSKVpwrw==
Received: from CH2PR15CA0009.namprd15.prod.outlook.com (2603:10b6:610:51::19)
 by DM3PPFB96542C9E.namprd22.prod.outlook.com (2603:10b6:f:fc00::e45)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Fri, 13 Feb
 2026 08:50:07 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::fd) by CH2PR15CA0009.outlook.office365.com
 (2603:10b6:610:51::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11 via Frontend
 Transport; Fri, 13 Feb 2026 08:50:03 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay1.compute.ge-healthcare.net;
Received: from mkerelay1.compute.ge-healthcare.net (165.85.157.49) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Fri, 13 Feb 2026 08:50:06 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id 87F1BDBCE0;
 Fri, 13 Feb 2026 10:50:00 +0200 (EET)
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
 Mario Six <mario.six@gdsys.cc>,
 Michael Trimarchi <michael@amarulasolutions.com>,
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
Subject: [PATCH v3 0/6] Enable the IPUv3 driver to use CCF
Date: Fri, 13 Feb 2026 10:49:49 +0200
Message-Id: <20260213084956.1031000-1-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <"aYtUi1WdLPLEnv2X@zoo11.em.health.ge.com">
References: <"aYtUi1WdLPLEnv2X@zoo11.em.health.ge.com">
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|DM3PPFB96542C9E:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2d8617e1-aa0b-48b2-73fd-08de6adce334
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B2EgboRr1Dm6fWrTsjVybSWPPWkTdrdCxWzhmAUWJgQq9n8Xlwe9K8Kq/Yga?=
 =?us-ascii?Q?xHBeX0hpkqoDQRcNFE70/O3s8QgYwjY2GzfWuj0KE1ZT8zzbyxRiVuhEyTpO?=
 =?us-ascii?Q?Bz7uO4N6oJm0r+Ia2c5Iq6XcCPWlgLOQWQjDsEhZzheYbJBsYgzbAfx+/gOq?=
 =?us-ascii?Q?9oK9VSvcauI8/9LQhI5EAwpE6BN/cFkmqoQpcW/mGwMJsUuXg7TPQLOtriSF?=
 =?us-ascii?Q?+FSViWooSmUkm9xvA/RW4UTWIy32gmQbL7OSpR2A27Y2PrP85k2cM7UDYoMq?=
 =?us-ascii?Q?voeCJbHkP+St5GoR+sv+xVp22POsBK9aVKkHYN/Nqg1HiHpZ9643MJg7GJJo?=
 =?us-ascii?Q?zFo71cr/1ORBlaRQymR51aRu+pDRB5uaT4C1BKZOAo14ONYJHl+jothnoqaT?=
 =?us-ascii?Q?cY9+vkQwIWwUpQBoWs371jWDQCY5QhVqm0apq8Vdm6f2mgL5u1JE5y1HuWzH?=
 =?us-ascii?Q?qS1WB3qTU1BdOupj2qw1JyMOY63MWnVdVd3hvLXNJLOTuGCtx3u1a039dBym?=
 =?us-ascii?Q?3Xh6/LCbmSsxqPMuEfeJlp4xjYSzQwm+cmOBiYaLkHupaSBvsC5dieNLCS0o?=
 =?us-ascii?Q?P85EAMTJPMnoAUE0o/5M8vF0cB8YyICGb214uz0AKVgniJR2r8FBP+HpkHUS?=
 =?us-ascii?Q?dtz0Npos0AQo5Zd3oq8DEKSfdEEIESPYCyFZhyiuwAQW6joBSigeXT7MCSKF?=
 =?us-ascii?Q?ihSgf1jxm02t9qQmlIEHRkripRBI3lbpT3Jn58NW/5PV82PAn9AOOkYcC6hg?=
 =?us-ascii?Q?/2NTcXOz+EVAhaOk95KECrpnXE6CVEVt6/UDbpiV0uSr3B1ufW+Zt6rx3vF2?=
 =?us-ascii?Q?1Csj0ANrKXMWe/W/KLzgUvEhJVLGL2sbIobqhJ6iZ8mRU0FYislX0zkd3XnP?=
 =?us-ascii?Q?bXZmyEprHNpa0vgj39Vy5syVAIwRX/itSVAB9ZgHcjkW7zAe3bZU/H3Aw1EB?=
 =?us-ascii?Q?w5pOV4f0oiUoZW2QQIRRLGLbqogGiC98CLu6tfIoPOmfG6m5fWTy4GCMlMBf?=
 =?us-ascii?Q?ST9P54L3e6MIP4rDBxYR+gMHoNodDpkRjWfKTICm0/A1Ol2LByGAxcnhOziJ?=
 =?us-ascii?Q?XwBXFMM1oFt6rsEwar7kGIMaz/JfIbU71exPqcG3X+A3YAl/n7uLhDCjt0w7?=
 =?us-ascii?Q?Q93liYd6CWa06sY8rMpDictWqCp6AaqmpO1uA9BCb0PsgaAyWrTenXGa4z+k?=
 =?us-ascii?Q?Tfpsvvv3Bs+lWPE5MhpJxWYAGfNj4GqwLqwaBchMGG+vKnSia6rMibcOh3VW?=
 =?us-ascii?Q?IZpsyJ2+i6FpPVr+2npJL6UUN7IwkMQ2qhUtAoL6kkIahyFhzec5LudbUzlY?=
 =?us-ascii?Q?ZxcwK4ZjT0/2OfJwGuU8JLu10M3auB3BDskUvmIFoJsI5kXAusXHOHBlNtX+?=
 =?us-ascii?Q?ggpJ8B06/Js+OAvDHj6r3AcIyRgx6q0vRtrURQZT5IFzUn+UQjb+PFE/IJNZ?=
 =?us-ascii?Q?IhyFbIRz2JJ1XR9Kf6UxQCl2CZf8yKco7L2R1GQtCPUp/ZgmwUharuNGg0rG?=
 =?us-ascii?Q?21e3S+eZufHUIccjdv/AOit/zzr9lj0xtcvZ5Cuo1Iw+vZUwB+ZDJvonmkTH?=
 =?us-ascii?Q?u5DNfJSfZEH/RMd9H/T9HXpGouXk7qKN/3d6FiuvwKSHzr4qLPGvtYCmTge0?=
 =?us-ascii?Q?OKLocp+KzFEf0WydP0jtpOjh+wiDokxf/UUoDlceLh9B5BCxKbOrfcynyvO3?=
 =?us-ascii?Q?6mBb2g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mkerelay1.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lLHgCmTiVSF1Vg6XRzzB91LgrwYXG606ihGzWhXYihnFAJkB6tPQPlBtPDaZlADWxJaKdgHhRgn8VunVqEFYMk55bIwOkjR2ji2sqLPe1oyZ6d5lKBDtpy97X2iOwJ+JlHc1wgdzZ+VVVJXPJScXdWDKBRYnjQ8N+z5Jho/ere1fKN8s4Rvlz2as+Cm4iCElmpRjH3jaAJn0K6UfwWcJHqtly1mdsLdTIgmzFRvmKhDfBwM/PwmGEpaFsjiDngKhiq66jDfThh6EPTPoDgmuShK2GOfqztlO9cP7wYPQ0s3bXkqnpexFVwrHNU+olH+cjp5hc6UpPBteo2t3enndcXeiXkmCow5MmRRMEoJdD9OrUbte2Y/YROHuXM1tcoCY2UJaOP16GLvLY2vJiVSTL8BbNUXVcFaLHObjMqKlDp9R+l2Rxmg9ByLZPk9cS8P2
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 08:50:06.9243 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8617e1-aa0b-48b2-73fd-08de6adce334
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[mkerelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFB96542C9E
X-Mailman-Approved-At: Fri, 13 Feb 2026 14:24:08 +0100
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

Changes in v3:
- Fix commit message
- Added HDMI clocks

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
 drivers/clk/imx/clk-imx6q.c        | 424 +++++++++++++++++++++++++----
 drivers/clk/imx/clk.h              |   9 +
 drivers/pwm/pwm-imx.c              |  48 ++--
 drivers/video/imx/Kconfig          |   7 +
 drivers/video/imx/Makefile         |   1 +
 drivers/video/imx/ipu.h            |  60 +++-
 drivers/video/imx/ipu_clk_legacy.c | 310 +++++++++++++++++++++
 drivers/video/imx/ipu_common.c     | 371 ++++---------------------
 drivers/video/imx/ipu_disp.c       | 142 ++++++++--
 drivers/video/imx/mxc_ipuv3_fb.c   |  17 ++
 11 files changed, 965 insertions(+), 427 deletions(-)
 create mode 100644 drivers/video/imx/ipu_clk_legacy.c

-- 
2.39.5

base-commit: b5213bbfdcb1812be510427857827ee8becb9f8f
branch: video-imx-dm-clk-fix
