Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 176C7C28B2F
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 05:36:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3072817EC;
	Fri, 14 Mar 2025 06:36:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="oqUFD+1G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D45980F9C; Fri, 14 Mar 2025 05:09:28 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9696B808A2
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 05:09:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pnm/BWiCo7HGxIaRoYthjCXdXaS7/+gMoIZxp5LqkuKB1JjrX6clMsdzJWQfi90tle0ODnEfkxHOJMECk2rM3Bxon2Dy/OYOPMozCjLHEq6YZb+4LvVbqOJdp3KF6zhRFN7ee5nHLO5/2YxnB//EvNkGe8dEoU0utZkXqVcZc8xHbw0vAOoo0rrdlmFggPxEVmeNwc9vAiBlbKXvDXoCDyB409grl0KBT5ralv0ax3hFbC7YWxNisTBd34afhy/c0DvCieMqpz9ew28rH7Q7zrlfECLOijkSqQ2EOcX7ZGhj2JDGYx0LqQsCqHg7n6HKETINv/lf33KTc/DQGIj68w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMl7Ld30kP6pLdAC0eNOsqhV6mLCw897ZW2dL9QvzpA=;
 b=LLvYa3acRvqhfWynhkzh02Lt2FI/4+ZiNJSOp4KEO4BI9fMwxjCQpUtZ3iUg0qNEn7s0ZlpS90M/bgqQQnrIF1Yl90YaPD2kzNouMkjYYztq5kwQqFuIUQg/GG/8EN0qeNmc6ecFwEYrkj2kxuctnh+BcUiPBLguJHktoVOEofe2olktY9DDyEiDnsRQQoPbek0nQYsg6XIXnw2Wjz8b6OGZ0LGPbeHluYZ2d0R7lat85dSUlbzm7hvVXCwF1UxZAFXrI8NaeK/+3I15c3Uq63lH21/P9RepnrurYC5jqRpRw0lPRVCoejrhGLqmqlZLsMS/2DFmep6Fo2G//2e5lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMl7Ld30kP6pLdAC0eNOsqhV6mLCw897ZW2dL9QvzpA=;
 b=oqUFD+1GmQpffy76uUzhUUhhWEbdkBULycqHLaShi6dt7bGdEBhmsj+DTGiyhpspj/gHk/+tvsEDwTIz/weXwazOCpSlDtyjIvixQI56paDnwQP66te8qIb0K63s6Ef3hRAG/xyjKNLMhg7d2XECdIRkT3GVmOwVooMdrRj/PMI+2DGpPB7QbfPotaxRvZJINKoyNvMzgcawzU2z5cCZrYYL8sbrQhjaZGUFV1sNd7jUaF0LGVwHrRQSP260s+0B6TLDyP9u/lvdljO5lzXNGeZ0GUurUteH3YzEPls4CcSLyyCcHb/0c1zqnHL5cpbQD2TbFHjuOabitroz1+u7Dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN7PR03MB4387.namprd03.prod.outlook.com (2603:10b6:408:3b::30)
 by SJ0PR03MB5757.namprd03.prod.outlook.com (2603:10b6:a03:2d8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 04:09:21 +0000
Received: from BN7PR03MB4387.namprd03.prod.outlook.com
 ([fe80::35a4:cfc4:3214:874]) by BN7PR03MB4387.namprd03.prod.outlook.com
 ([fe80::35a4:cfc4:3214:874%4]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 04:09:21 +0000
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
Subject: [resend v2 00/13] Add Synopsys MIPI I3C Driver support
Date: Fri, 14 Mar 2025 12:08:49 +0800
Message-Id: <20250314040902.43621-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0184.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::9) To BN7PR03MB4387.namprd03.prod.outlook.com
 (2603:10b6:408:3b::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR03MB4387:EE_|SJ0PR03MB5757:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d30aeb4-5da6-4364-0c61-08dd62adff0f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Mld3SU9nNkMKSP/LjXAzD34JU8cEPPjKFyMiB29oDlPm7/3k/sdasKzYlVUc?=
 =?us-ascii?Q?ye5vV99IRCYQX5qd6YD1jc89QJBu9Q4yP3X/o5c//+Ri1kimA2efrzve8JHJ?=
 =?us-ascii?Q?4OPSqAjxQhlokdBJg+O4kXo2wyzCX9YZCUuOvQErJo3tJAAebkaP7J7dMNDw?=
 =?us-ascii?Q?24L0ZKaJdfQkSf8Q6TLelJhqx7KJm0vdYYdvw/lyFXYTDPp2aCYH2JHPQM1A?=
 =?us-ascii?Q?9d4/3TPEBQ9rVibH7/fZLIt3VVvcB/6Z6X2B/TCPLX8ctDxxDttLY0FGEFbk?=
 =?us-ascii?Q?o7xgIrpxpdkvgV9pHFjgoEFm1TDlHmPbC8c/nJYU7eTNIII6qzIM6+2T5QxG?=
 =?us-ascii?Q?cxrCNjhC3yJR2HngDep2qiD7hLVDEA0Xav+8TP4yHjS3GDNFlwjhASguZcao?=
 =?us-ascii?Q?YyZ832/Tk+2mlIV/z2z8nTTEx5s54Y3MH0cJQ/mvRBWyGRqjmB0ebzwUvfIR?=
 =?us-ascii?Q?I2Rz3pAL3euyGngJUJU67vFsq6/0bwj2G3P/gcAI67nd/g7+4SUcnvUTPHuI?=
 =?us-ascii?Q?XFmD7sSjMp/YsqeFaSEnOt/IUq6HW9SPUhvsb7/HEfF1KiSUPG85atFlB+Nj?=
 =?us-ascii?Q?Hm/nzxCSsm92nIrQ4bt5mZuF1GSY8wGG6SI4bv78FgiOcB1TVbBnnPcvfvyU?=
 =?us-ascii?Q?utTOtv4/UANTHXmpizYk7mH0IEmeaiCw/BWuz5PU+jqVw0FMu+PWrJslOmTU?=
 =?us-ascii?Q?Pp2CyfVHE9zGFmqc0uxQDtmkeGWLrJzpXHNkol6Bbo6ewJXes/Op6KZXtbwm?=
 =?us-ascii?Q?ARIKD+gd4V6zoAcPYZBiRSS+Q3qVQZ9EvFc9L3rsjQ0Lz81ad6lPamV1l7xF?=
 =?us-ascii?Q?Djq2cWlaJyBXNqRTAQxKI3XMEg7mvE7oIQsHmxD8+jaMQ5riFsOge9nY9WYg?=
 =?us-ascii?Q?Dr9JrNsPo71OrAu1aQbMTfB09yVcFSesLyZW9+U5yhSaC+5m/1WSkspVz8vd?=
 =?us-ascii?Q?OaI6GonA7LCB3+stNly8T6KUK1TXngs3SJn2MOCxdcoFoJ2842KAAlWXnw5/?=
 =?us-ascii?Q?ACwOxO4z/zMvvMIn1uJON4f2EmytMPe0Ky9hKj+pXS/Fes6FZWwM6LlftJbj?=
 =?us-ascii?Q?TmK2n6mpc/OBPbhQ9ZLymB7/1qI1ww55rGoS6Kf+YqEzRaj3bsvEjMz8n5CK?=
 =?us-ascii?Q?eDlZH3J+uWYYnwHu88MaLnv+I9nGpkEAhzZjHincGV/EZa6yd0vGvyVpqFh0?=
 =?us-ascii?Q?XCje2irv6xb/lZSCSYG1zjZBEQ9Z5HkB+JRuDx96gDnr5LWVibJ3YGPMiGQe?=
 =?us-ascii?Q?C9+yFazq1+rEpvYJtBluV07DbCe6ZOLCJx0XYewc983GjFcIQQa9Cu2xm1PC?=
 =?us-ascii?Q?nUtl+RsB3PFTlL7kFe9eOAPnlX2RRAtzCWbAgz6a2F6fI0udnfrl3ifH+Zm9?=
 =?us-ascii?Q?U71tt72yd55H5RnDJqo0welCi3zO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR03MB4387.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eNnOAxEPOeyDwP2aQyr5aiTrd1XBJ7IR75u9ahmq+DxV8k+m5+IQ+AdOuKhg?=
 =?us-ascii?Q?S4AO4EGX1SnrSmY3BKce9hwOaPUn7qkflDPwnQ3dg+fnIzzDnb95n2W8eujc?=
 =?us-ascii?Q?h5usP45pvd6ViCUH/5YIJQ9VL2y17NxEv64eJ8RoBe+wWzP/pPKhqBD9yqEb?=
 =?us-ascii?Q?ZBcKJtaLUh+Wap02pBJbleED8FcD0ickSk00veCaSmDClMVjC1aAedybxV+0?=
 =?us-ascii?Q?Yq9BW12+kMZQyqr+/kGJbOT6hPHbwDBzo36wL9EACLLSa7BrwNAcEGMKpsQK?=
 =?us-ascii?Q?SFjLx5b/rSgAyvUfRrpJLQqxxk+joOer6LPiU9GCImKMlfguoPRvitQ6uG48?=
 =?us-ascii?Q?UwcYow25rV9UcGvUggXmOgNEUrzXZDU8ONP6irzCbPZcSTFGmOs+3GOODEHR?=
 =?us-ascii?Q?VrxwIp8KhDMS9oI1t+UxrTI5VbpCqmjlGVlf7otx0q5jrUMf9jMxIe8JuC3G?=
 =?us-ascii?Q?PtfFvLvmFS7tip4CXKRkdiqJYPAp7jQTBQ8sTSyGCaBxs4gR3B8M5Wcr0Mho?=
 =?us-ascii?Q?7vVc66l1TURTXYRGryMq3OclADPprZEXaTpWk9RiP4Aq6MmI6CxTvObiHdPX?=
 =?us-ascii?Q?vndOUkmZmiJaPxzIFGEOwmhhiu1ZT57MbXhEf4MrJl3qrNTNwlzyfTeJhnN1?=
 =?us-ascii?Q?bad09Ksvd9Y2t9ddzlVwyYX6Iyqit6wuaP5pDBqg+sisO6C+S6EeN5ZitwFU?=
 =?us-ascii?Q?HfRHGzUnTwqzDiSh+2lJcKhiEYO6VyqGubzKNSfxPe1Odc70+PUSmBye7V/3?=
 =?us-ascii?Q?8mwbuss9Hk9j9+6rfz1aDtuBq5eN0G5ORrlThAN7hzH3rfd/Ma0g7RZd39bt?=
 =?us-ascii?Q?HzpWagT9monjKl48ua/z9ssLOci0Oz7i7W5FjR99Vcnz6xTylWiJldp+Sgth?=
 =?us-ascii?Q?AR6xQuYlfBuGwTluDi4vKKe1md3zYEfvHgETg7R+2aeCAEz/nOA/TEWmxED3?=
 =?us-ascii?Q?+HT2Gg8qC/Q81Big7l1V7SvCRACHtmeO7j59ejxi7a+JZzcPifl/wclZ30W5?=
 =?us-ascii?Q?NHmqvH3aWcWP023PkUIXqIZathvAKExnRhMrk61WYtmHSZq5xE2akJKZa0Pz?=
 =?us-ascii?Q?fM0OixA/rlvVQuZS/KmqP0/dv92XuhMq/myyu1luwtB7c4fE+PqjT+8Tonxd?=
 =?us-ascii?Q?5zKixqHFvDjLCBUjuAatLmmY1YHdENzas3gHQnDLNviWsHlYBzbjSAZ/17Je?=
 =?us-ascii?Q?tsq1O9qkFmB4jn35jmqg4hqUxPwpqP9T2h9Gg52bcQ8KlibK7m6dR3h1rPgl?=
 =?us-ascii?Q?y0aH+maUWhyuni+H7e9UNSn2+Z2wJvRzTvlAVZe0I30hSizBIrrxh0uL0VJu?=
 =?us-ascii?Q?IieKhmOXSdnOxh8it1YStW437YOkeQT9D0iygabfOfSTWzj03u4Od/HLkKGY?=
 =?us-ascii?Q?Uci1GhucKDTRE7nWU/upBt/hmjn0LBTjlCFGRRiTlPrpGA7X04L2xfZMX45L?=
 =?us-ascii?Q?PU42hw7BZEoiCXqCrIZLoxdQxTL4kpNMeTZ6NVzfHjZKgrGN2exzYUrPibQ6?=
 =?us-ascii?Q?akDtVi66ePWm4Nd7ipkpFzXKKN9BcQAuejEaXy5FZp4yoZ8aJRkyGqBcvs7h?=
 =?us-ascii?Q?mLY8ieFumvmtJn3o3WUMR33zgpmPuNRi6fH0Cy05nbrecpW0tMp4F0XeuYHP?=
 =?us-ascii?Q?Yg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d30aeb4-5da6-4364-0c61-08dd62adff0f
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB4387.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 04:09:20.9312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VDUngi5amwEw/zy23ObJwVP4ZIF0wFL9EbPv6Wy1WR4U9PPwpV195sgFrUtKdBJvyu11cs6zKM4m5FnLX1mwDOcMo590PyZMYyxlKNJtaPI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5757
X-Mailman-Approved-At: Fri, 14 Mar 2025 06:36:33 +0100
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

Dinesh Maniyam (13):
  drivers: i3c: Add new i3c uclass id
  drivers: i3c: Add driver for MIPI DWI3C
  drivers: i3c: Add i3c uclass driver.
  drivers: Enabled Kconfig and Makefile for i3c support
  drivers: i3c: Enabled Kconfig and Makefile for DWI3C
  drivers: i3c: Add i3c sandbox simple test.
  drivers: i3c: master: Enable probe i3c without slave device
  i3c: master: dw-i3c-master: Fix OD_TIMING for spike filter
  cmd: Add i3c command support.
  cmd: Enabled Kconfig and Makefile for DWI3C cmd support
  test: cmd: Add simple test for i3c
  configs: sandbox_defconfig: Enable configs for sandbox i3c
  configs: agilex5_defconfig: Enable i3c configs for agilex5

 arch/sandbox/dts/test.dts          |    8 +
 cmd/Kconfig                        |    6 +
 cmd/Makefile                       |    1 +
 cmd/i3c.c                          |  193 +++
 configs/sandbox_defconfig          |    3 +
 configs/socfpga_agilex5_defconfig  |    3 +
 doc/usage/cmd/i3c.rst              |   98 ++
 drivers/Kconfig                    |    2 +
 drivers/Makefile                   |    1 +
 drivers/i3c/Kconfig                |   25 +
 drivers/i3c/Makefile               |    5 +
 drivers/i3c/device.c               |  262 ++++
 drivers/i3c/i3c-uclass.c           |   38 +
 drivers/i3c/internals.h            |   26 +
 drivers/i3c/master.c               | 2072 ++++++++++++++++++++++++++++
 drivers/i3c/master/Kconfig         |   11 +
 drivers/i3c/master/Makefile        |    3 +
 drivers/i3c/master/dw-i3c-master.c | 1058 ++++++++++++++
 drivers/i3c/sandbox_i3c.c          |   58 +
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
 30 files changed, 5652 insertions(+)
 create mode 100644 cmd/i3c.c
 create mode 100755 doc/usage/cmd/i3c.rst
 create mode 100755 drivers/i3c/Kconfig
 create mode 100755 drivers/i3c/Makefile
 create mode 100644 drivers/i3c/device.c
 create mode 100644 drivers/i3c/i3c-uclass.c
 create mode 100644 drivers/i3c/internals.h
 create mode 100644 drivers/i3c/master.c
 create mode 100755 drivers/i3c/master/Kconfig
 create mode 100755 drivers/i3c/master/Makefile
 create mode 100644 drivers/i3c/master/dw-i3c-master.c
 create mode 100755 drivers/i3c/sandbox_i3c.c
 create mode 100644 include/dw-i3c.h
 create mode 100644 include/i3c.h
 create mode 100644 include/linux/i3c/ccc.h
 create mode 100644 include/linux/i3c/device.h
 create mode 100644 include/linux/i3c/master.h
 create mode 100755 test/cmd/i3c.c
 create mode 100755 test/dm/i3c.c

-- 
2.26.2

