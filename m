Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB14C36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 15:09:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8F8981026;
	Mon, 24 Mar 2025 16:09:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="oc63rGZ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E5FE81F6B; Mon, 24 Mar 2025 09:39:59 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170110000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c102::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B50D5801CF
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 09:39:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VrWiVEHdAXV3co7EnGJ0AnGIw2eKdS3mFk6b6wL9VTKC0FtvqyRrhdEZOpOd+hq05WfBi5Add4SOY8JoGOMrwpYspv3qf49fNdfLzz0J3KnSSqfkfaEoKfkBoncL7UKxINCIIl1p+ysaT+P0D2fz21/W9KN44nb01tENYoMtaRA6KTWFTh3+wZMMuseKv9cvUbxpp8++HkCH1KHZRoUzsfg0QtGKWXL/069tHdiqY5z8ElCO2WDEWPpL59zYwnS18FzMZ+TGu9Qxj9L+Pajp3HvoIeX3VQOnl7KJaM5Ip1qKtTva0Gorp97QGZOPQwwSDU/18Gv3JFnikYvHmV0ceQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CjaYljlbQAumhcj5OcbEPjRaOya9TEv0zdIqw+4PE4E=;
 b=iUg3CG3k/LxWW/j9sf2gX/j33hsFImNE5vBmzgOA1DhIwMmIzjr4a6jTaObmwKAJjofOvXYGxhJ4odro8xeTFJyf7CBkRpdiH42V4vsU1KsOWKcP4G9H+9fsUhUhDFG+3MPiTMF7ZPxcIt8Qzh4WGaAG/G7r7Y2NUa3RkFsBRE+Mc0Skp3vOBHySTURaWYWU78w6WS1esKp25cJcSqyB8WQSwLNSvdv/DYd8nYw+Or5MtLF/flTobyViCH7g7249oCX8ziqE7aGJZ2psQGSF3trjebPPNijZ+TdK46uYyMFKxDQzA3ijQx6ZoZpzw2xKoTEnX/wTG5xM4+7bjNWbdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjaYljlbQAumhcj5OcbEPjRaOya9TEv0zdIqw+4PE4E=;
 b=oc63rGZ2U48tCEVMcy0omNqHXQkWb7RFZyNmmgP8u33Loo3OH8qVZ/zsTFZxJXm5OiC7cgoxYMTPvVbuP3xI9MMVv9u4KUBQnU9J3x+aVrUqOQwdV1PbKuOTdlLUyFog7ieU7d1NOjuMdv/geoiiMTq11G1JiQCoFhWjHYFT83hJCb9e1ct44OhRem/lQ9W3qtJWyi3vrG26wVDMNTtTqMgbMk/FVqyfJINhI+Fmn8TjT24SJQtgJ5mQJSiH++GdcPWDcJBn82gPzGHEBdX8qBjWxg5kiZkfwcPMwI9MzKAt1erGwjO9kX2GR+V/EUwT5UPKLpxHDROdEoGcBJaKhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA1PR03MB6370.namprd03.prod.outlook.com (2603:10b6:806:1b5::16)
 by MW5PR03MB6958.namprd03.prod.outlook.com (2603:10b6:303:1a9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 08:39:53 +0000
Received: from SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03]) by SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 08:39:52 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Sieu Mun Tang <sieu.mun.tang@altera.com>
Subject: [resend v3 00/12] Add Synopsys MIPI I3C Driver support
Date: Mon, 24 Mar 2025 16:36:52 +0800
Message-Id: <20250324083704.26259-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0106.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::47) To SA1PR03MB6370.namprd03.prod.outlook.com
 (2603:10b6:806:1b5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR03MB6370:EE_|MW5PR03MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: 08b1ecdb-04e3-46b7-190c-08dd6aaf720e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mJIgHlMG1PZRagwnLiWESgITfaVxKi6XClBhtjnHfwxNlwG7qCvROaNLfDuR?=
 =?us-ascii?Q?U2Cc3jUxNNcS1uVBcoR0+o/Ez4grsuSDWDFelSgYdc/f9Rl9LvqDUhGzn6oF?=
 =?us-ascii?Q?4YRKCSjfQxhbqpD93HYkAQ1u1s6wTXJuRJQlbg9LTp2bcbq0wPP040/NceZC?=
 =?us-ascii?Q?POXUI+5z2Lf8jyJybI3Fy7q9HzZ4MSeWDA8F+r2Wbz330ulxyZg5f/wyRWuk?=
 =?us-ascii?Q?gGTSbGIPw69uwFfQ56O3py1Y+UDmMiZtitqtJ8yivLt5QZ+YpMEBtE/4mpDV?=
 =?us-ascii?Q?qbxTLkwBpFV3b2otTbBDpoFAqZrgBbd6OqbLLx5TfHtMPPLz5Gn6/VHD3n4G?=
 =?us-ascii?Q?Q6rINWWJmog1KBNX9XyrjqRsP7V+5E7SEOPy2SOo21m3GdJJDL7w68m8Ejpw?=
 =?us-ascii?Q?vSgiD6dFhF2jVnBkmqCjo/rm28iHh2Txl4DCe3ZKzDWuKfhtqzqiODbK/8c4?=
 =?us-ascii?Q?FAOe6OTlgejJKK/SGppd/bmY9Ztj1QqJ7rxWzt9DZA+2/ujrV5aCclMAHzD/?=
 =?us-ascii?Q?lC55KWK2X3vzcSwN7CMO//xyXeEhc01H3yIZLUH870T4/6jmvzRK0vyDg04H?=
 =?us-ascii?Q?cBVBoPgm0jY93bxYDVx821cPpx9kfrrJvlrH8Mqm7S19ja1S3VyQsIyrVY2M?=
 =?us-ascii?Q?wyVOny6WdoYteU8WyC2lxrdVEMeQkC5hfyjmO2tkJld/AbniIV7wW4A54BBC?=
 =?us-ascii?Q?R0K9PVYLhO9C6a/QdPA+rjYydfMtJrj/FzXI3MZ+b0YSBWCD/Rkf//11sHMH?=
 =?us-ascii?Q?kTEFb7uLk51NwHE13iL4kjNDP7yC8TqUUhbJ4szR/VWFoYbs5x7IlZYHtaWS?=
 =?us-ascii?Q?Xd00HlEY9IbFOoVZhG2em/KdWwnLWSUoz1px5fzv2oTX3rog3JObWLrkGqdT?=
 =?us-ascii?Q?JYYUNWIdShcl0R8UU5HOp4kHzBe6eNaXH1RuBAmCFiSyBWa7QMjFjQyLhn3w?=
 =?us-ascii?Q?hIjaU6F8UxlC9YO1cCYaiulF6Hx3ibsXshUZWqphH7AacZFLiRqfFNpemqIY?=
 =?us-ascii?Q?9U0wJg5dtIU3GwdgMx3uZCGFDT3466L7DLkerXbjYnOHJdbLnhGbYDBLXwgq?=
 =?us-ascii?Q?MdG0hUzF8rNJkJUsbeY/jvyia6CZXVWkx7s3nznH+dypa2Rjlt9Ix0kX+5oq?=
 =?us-ascii?Q?HlkVv7ldZDCQ4nty9Qljll2nflHRseeSkbz1HuvMbC/g8CwY205d/3Q6BYtX?=
 =?us-ascii?Q?+BKNv6J89pkOe1dxD4ppduNSOczcchLL2Yj+4+1KgKQu1ligBKGsVcjm28ix?=
 =?us-ascii?Q?I2jZkcxX7KVC+eBA0P/Ds+FmuOxKWcQZ5k44Wgf7wFJVZ+E3aF/MY4z8uE9X?=
 =?us-ascii?Q?SXVM8vZaHs709Pmzv3TAJYAJrbo+PjuBpNwtFEJe0jLInkOjvoSL3wzOI7aJ?=
 =?us-ascii?Q?WHGG8IZ/MJFM2SqRF8r6qSEYlsr0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR03MB6370.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RJvIg3Ep2R0hKNczIu+t+5kGMFW3QSyZCYOMvk4gnQqjKkP31NhILLKRASiV?=
 =?us-ascii?Q?SANUDcZ75hQhCSONNDpRQoR4PTTgATJ2NZkbVSNr795KhY0g59+tOC2pWUWD?=
 =?us-ascii?Q?w/ykeg7ED0hWnh6JtqZEHtqNOUbNdj6T/0jFSLQUOcmTsFY8q3Nd3D28Pw4H?=
 =?us-ascii?Q?3hz/qQJMFw2KvF81VczcBH/wZ4ZfaKKb4a8Q0CjSQqACaeqAU40wURKwFSPJ?=
 =?us-ascii?Q?hghMj6tGFnRDETH7h10coGkf2aPOX085RfYgWqboMbfCpOeBCIuZfOPY1vHX?=
 =?us-ascii?Q?yAaAe/3PwMZ4cACpSB0uriNQigdoyyKxRmdtcVcoAqbvXdZ+82XpyJoVbiow?=
 =?us-ascii?Q?3JDTrCBJXDVPoWfA+ISfdrUijML5K1ajm41xVrf8LBkV4pCCVkREtg1s+9rp?=
 =?us-ascii?Q?4jGdG5sWD632ZZw4YQkKZ7S8GD4YnLcegjkMD6emtcID8QXLs8BklN6Q7aw8?=
 =?us-ascii?Q?TKINNOqTVTMHEcBHs9/sStoWsJBEnMAbm4zN0rhbbFgVDrdUTJpx/dCKaoPZ?=
 =?us-ascii?Q?u2qCcsJjjq8TSwsJsqgwbMRoUZHdOXknaNhC+0Gwvo/8Sns30udx3Q5Yr3BM?=
 =?us-ascii?Q?sCdJV1cJbyi8A93UcaESVnqpznsWN2TJNEcOaAvZ0aNQtw5/8mPjU3VGtOHk?=
 =?us-ascii?Q?FnGroQ2jNu1l8t94WiwIOorYrF2rwvW8lWXS310WyM2oDqeFktm9sVEHWSn+?=
 =?us-ascii?Q?z30vFZeNlkN+z3ce5iKsOkXFvaur5r/3QFVLJVwxDh2Hb1YhYPqRpm4+Jx90?=
 =?us-ascii?Q?OGWBvtaveOySImcBuCuLgGaGbgOSNXBOS9X0QwkzSA98kjOQ091TOVbK+ioG?=
 =?us-ascii?Q?fyhNFvGf949NFifU39vOvqxwDMQE0tCxgiaBT6rLQL2Hm0T53IByblyP4Rqz?=
 =?us-ascii?Q?wNMFTfKrc+eke0Y2/Vf9mstmgvFqb7xCW82svbVC0N7c67MMYCEO4/WfH3OQ?=
 =?us-ascii?Q?OdxXjX2jbo0AYzlME3besbOoAsyHTDbNHVUQ8fUg4G749CwW7ezyz+lB9fS3?=
 =?us-ascii?Q?RXGl/vV97yLOOdK1JNo+kNpuYj61qQuM8XCyya7aO0eRYpdBsqrln42UHcc/?=
 =?us-ascii?Q?PpB6DXXuKv21CJGq1hmoOcOHHgLgEmcZP1gQFAuUYfy5HSL2fwABaIh7SPcm?=
 =?us-ascii?Q?53BoMew9YumQn1BcS7uBzL4mPqLfen2LD3drxkBgwtoPPwagKZVxzAhF6KfT?=
 =?us-ascii?Q?cduQzzl5uV8r7D6r8U7jMeOBbq5XCI4pi6uv52ryGZnvQouOlXZY4dg2P1W1?=
 =?us-ascii?Q?sMNfzeC4BdroGbt2KSNTdGydBbOKnuzwob5LSKr/O95qm/CWhba3NzJd25Bm?=
 =?us-ascii?Q?FqQnhxoFGigNbt+vxeQ1qArHyHjKuLBg70Wbk4qWvGXPT9a3jsVPj8bI0+jW?=
 =?us-ascii?Q?1wdXyFYTqMj1j5Z/vU4W+sI8jpuI3vHi1FBJA70XRBqBi8cbeAUKG0gK9nfP?=
 =?us-ascii?Q?APS8b+PD8NT1aHKxNW/CaedoWtU8mhdSpSwr+ANI2xgeHB00MXZfI1WPRHSl?=
 =?us-ascii?Q?d51MNI7tupm00X9eFFSDbx8MkVX14jMk+6uIvIvzRj4ZBQWAqpQ91hymRNZ0?=
 =?us-ascii?Q?IfVC1fHHm+O1IPFVd/1Qx7nkpczjEhtw/K72lf/agK53GywfDRr4TPo4R7Tw?=
 =?us-ascii?Q?/w=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b1ecdb-04e3-46b7-190c-08dd6aaf720e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6370.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 08:39:52.5263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7wSO0EZqBtP4uWO+MIkkc0Nlj7X1XyUmBLhPSGkI6IL5LnLFmQ5PbFlhn6GBlOhcMUhYcPR5qaQQenrDx+U0NoN2q4VY7H7aACMbzYZwse0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR03MB6958
X-Mailman-Approved-At: Mon, 24 Mar 2025 16:09:48 +0100
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

This patchset add Synopsys MIPI I3C Driver support for
Intel Agilex5 devices.

The i3c driver is leveraged from the master/dw-i3c-master.c,
i3c/device.c and i3c/master.c Linux version 6.6.37 LTS
And few header files included to be
part of the migration; i3c/internals.h, include/linux/i3c/ccc.h,
include/linux/i3c/device.h and include/linux/i3c/master.h.
Additional i3c uclass driver and command files added to support
i3c read and write in U-Boot.

Patch status:

Detail changelog can find in commit message.

v3->v2:
--------
- Squash commit 10 to commit 9
- Resolve index for new files to pass the checkpatch

Commit: sandbox_defconfig: Enable configs for sandbox i3c
Commit: agilex5_defconfig: Enable i3c configs for agilex5
- use savedefconfig

drivers: Enabled Kconfig and Makefile for i3c support
- Add maintainer for i3c

drivers: i3c: Enabled Kconfig and Makefile for DWI3C
- Add empty lines for if/endif

drivers: i3c: Add i3c sandbox simple test.
- Removed DECLARE_GLOBAL_DATA_PTR

v1->v2:
--------
Reorder commits.

Added commits:
- drivers: i3c: Add i3c sandbox simple test.
- test: cmd: Add simple test for i3c
- configs: sandbox_defconfig: Enable configs for sandbox i3c
- configs: agilex5_defconfig: Enable i3c configs for agilex5

History:
--------
[v1]: https://patchwork.ozlabs.org/project/uboot/cover/20250218025705.50051-1-dinesh.maniyam@intel.com/
[v2]: https://patchwork.ozlabs.org/project/uboot/cover/20250314040902.43621-1-dinesh.maniyam@altera.com/

Dinesh Maniyam (12):
  drivers: i3c: Add new i3c uclass id
  drivers: i3c: Add driver for MIPI DWI3C
  drivers: i3c: Add i3c uclass driver.
  drivers: Enabled Kconfig and Makefile for i3c support
  drivers: i3c: Enabled Kconfig and Makefile for DWI3C
  drivers: i3c: Add i3c sandbox simple test.
  drivers: i3c: master: Enable probe i3c without slave device
  i3c: master: dw-i3c-master: Fix OD_TIMING for spike filter
  cmd: Add i3c command support.
  test: cmd: Add simple test for i3c
  configs: sandbox_defconfig: Enable configs for sandbox i3c
  configs: agilex5_defconfig: Enable i3c configs for agilex5

 MAINTAINERS                        |    7 +
 arch/sandbox/dts/test.dts          |    8 +
 cmd/Kconfig                        |    6 +
 cmd/Makefile                       |    1 +
 cmd/i3c.c                          |  193 +++
 configs/sandbox_defconfig          |    4 +
 configs/socfpga_agilex5_defconfig  |    3 +
 doc/usage/cmd/i3c.rst              |   98 ++
 drivers/Kconfig                    |    2 +
 drivers/Makefile                   |    1 +
 drivers/i3c/Kconfig                |   27 +
 drivers/i3c/Makefile               |    5 +
 drivers/i3c/device.c               |  262 ++++
 drivers/i3c/i3c-uclass.c           |   38 +
 drivers/i3c/internals.h            |   26 +
 drivers/i3c/master.c               | 2072 ++++++++++++++++++++++++++++
 drivers/i3c/master/Kconfig         |   11 +
 drivers/i3c/master/Makefile        |    3 +
 drivers/i3c/master/dw-i3c-master.c | 1058 ++++++++++++++
 drivers/i3c/sandbox_i3c.c          |   56 +
 include/dm/device.h                |    2 +
 include/dm/uclass-id.h             |    1 +
 include/dw-i3c.h                   |  252 ++++
 include/i3c.h                      |   67 +
 include/linux/i3c/ccc.h            |  385 ++++++
 include/linux/i3c/device.h         |  286 ++++
 include/linux/i3c/master.h         |  698 ++++++++++
 test/cmd/Makefile                  |    1 +
 test/cmd/i3c.c                     |   52 +
 test/dm/Makefile                   |    1 +
 test/dm/i3c.c                      |   34 +
 31 files changed, 5660 insertions(+)
 create mode 100644 cmd/i3c.c
 create mode 100644 doc/usage/cmd/i3c.rst
 create mode 100644 drivers/i3c/Kconfig
 create mode 100644 drivers/i3c/Makefile
 create mode 100644 drivers/i3c/device.c
 create mode 100644 drivers/i3c/i3c-uclass.c
 create mode 100644 drivers/i3c/internals.h
 create mode 100644 drivers/i3c/master.c
 create mode 100644 drivers/i3c/master/Kconfig
 create mode 100644 drivers/i3c/master/Makefile
 create mode 100644 drivers/i3c/master/dw-i3c-master.c
 create mode 100644 drivers/i3c/sandbox_i3c.c
 create mode 100644 include/dw-i3c.h
 create mode 100644 include/i3c.h
 create mode 100644 include/linux/i3c/ccc.h
 create mode 100644 include/linux/i3c/device.h
 create mode 100644 include/linux/i3c/master.h
 create mode 100644 test/cmd/i3c.c
 create mode 100644 test/dm/i3c.c

-- 
2.26.2

