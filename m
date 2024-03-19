Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78229C54E60
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 06:15:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B2A787861;
	Tue, 19 Mar 2024 07:15:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="PyytemWh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A477F83CF3; Tue, 19 Mar 2024 07:15:29 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9F3887861
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 07:15:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710828926; x=1742364926;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=jBh4VoSgMThaYTkN2aRn67cM9Z8/DiBBJeDdkRDq2n4=;
 b=PyytemWhh1/+sGx5GggTQFNLSiGU+Y0YdUjwFSOnglxIbWyecSqK+0LF
 wOjuN6YQDhbYrvqczKTGC9iNcJYwmxgfG7kbWETq9qVkPvaWn/G2TQ2Uf
 6uQD6gpHj+z/D4Qeo5C/D8WwMXpWlic6nHZg8wKgIpKxP9hpUeF/7hyZ+
 z12izjPuF0vCfWwlJXn2nm6SXfkiC2w3PGUWXABGuPcMcD3l5kM2zJjqn
 n9T8Hyj1NoRDVOIOpvjKxt5ZjKdTVHDX0316L1bScFSUknywIiPJ42DEn
 DKm7Dnw09FvXrE5yS0E/c4cv33rtBCJsr5G2bFPQNe+dHm0APMBclMdtN w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5512116"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; d="scan'208,217";a="5512116"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2024 23:15:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; d="scan'208,217";a="13748050"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Mar 2024 23:14:58 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 23:14:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 23:14:57 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 23:14:57 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Mar 2024 23:14:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCZP7KBo6/3MP7JgGo9XU64PJz7NmwX3pl+ryUaoLosVyWCTSIoK96sIzUiHaWO4kgQg9w6kFOtWiQf1HzvlSrgDCyPQW7hgDCcF/+IoeNXlDFAOLHEW1bAHCwr3kG1VoBXYQnp/m+HfipqoVuSEsLB7cTPMTR2gIWEt0K+9sjkWeXnRYMoauHfUUJa05V/l6tIB5IfE17WhS4Z0f1pMYkQqpjSRKxmN2r5WpMS1/cpPA8cEC/1k8r3Av9H6171TaQHA30JcFGEDXDICBAjiqEVmitqcG0CNJn/kRaZWqGduQpD0IO0/UY/vamiJMKhGEVYRTEEss7GeUQHUuTw3wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HNFKVdYQL0EOSQy2iFuXBpMgWtX8wlo+o7nKMlbrPI=;
 b=GnKxdJKN1LIhMctO7JpBK1MWWwhx87wvRnS3FNVExiBisU0ByaMmBLcTejwGLBKKbcMwv9Evg6HnTYnc/FUtecnwC7Z0olDc9/46PRUUPq0tMSbEpdHucqYoPU926gE6djUXlv40lNTwuSmSRAAs+OtUhuVcjDzOGifp8EA2pnLZa3xad0jFZHjYHK5AtiU1pE5puIRsVGN2MUzekQmgk+L9hk1cmN2e53q8P4tVSb9FlJfVb6rx3qkip+vXpNPVqke+fibQJ4TclMSul/9Z3ZDiEiz0IOOTJE7oQxk7p8lWIKaZhyF9SILzCwPaibDm27ZM9xPChBVMWpQM2YJBWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 PH0PR11MB7521.namprd11.prod.outlook.com (2603:10b6:510:283::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Tue, 19 Mar
 2024 06:14:55 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::2b63:5b44:7f2c:ed49]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::2b63:5b44:7f2c:ed49%5]) with mapi id 15.20.7409.010; Tue, 19 Mar 2024
 06:14:55 +0000
From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "Vasut, Marek"
 <marex@denx.de>, "Hea, Kok Kiang" <kok.kiang.hea@intel.com>, "Lau, Wan Yee"
 <wan.yee.lau@intel.com>, "Lim, Jit Loon" <jit.loon.lim@intel.com>
Subject: Pull Request: Please pull u-boot-socfpga-next-20240319
Thread-Topic: Pull Request: Please pull u-boot-socfpga-next-20240319
Thread-Index: Adp5wxvZOzfn5+amRU6hx28Iyb19HA==
Date: Tue, 19 Mar 2024 06:14:54 +0000
Message-ID: <DM8PR11MB559268178EBED61730BC04A6D22C2@DM8PR11MB5592.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|PH0PR11MB7521:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cCxUUlPatOPS8TW+lQDSPKwwaDY2jrKO97zEt+VdPC44BXKhlwPW2+1nctwrCZNMlE3N9OUVe6LnfoqCxbeVvrrFLLeK2P3AeZIIYQKZDzIEs7A6X9IVTDP4gWiOfzFWDLcKrUzj2YsJoXCnOKBPpekwcs/Z48Zdqh7j94zrqJhjR2z3JCmCrgsPD+x6MLddNLmw0ihsoHTbBa7JUX6IBaQi/dFXDiqG/ccdhHq/8VlTfm0q0L1vAc/ykE+PDKUhxXZkYgtJP9s/EbVV+sLzwPkcC+sYHb37osCDMfnFwf9i1UjfP3OVY67uAxex350kYH2g7qg7B6qgVdxLzfhZqvtgcFJ315jntcpnEw6nPe/HmX6Yh2a6fc91L49O9y3zgYLC1+EV6B4LfVkCNvfXcGD69VEXCF6fJIkMuzL7dXIRqzcQQ3VU4hYnTKpP+0TwF0xmkte6FjR+4NsiwTLklb/9j9DhWHZFIvY3+RRCChkVpawSlpSPzzItc3rzwOAukM5i5E3rrtBDmvk/NhuaS3CLdttRAZnWAPqWNiD4XmevzltHSHbJy8WvYPX81hJUvXxfQTJTjErD4Jng2Z8k0OoFKKO4oGcQwKXZ1rntlE8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5592.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h7x9xF986/s3GYf1Ki5vFeroU68qQ0dhFQTliz4gAFuHG4X6IgMNUnNLdS7z?=
 =?us-ascii?Q?fcR0PGhpRlC6ohB/BytuyiiOs8nlkhAqVA7kjlzrO7arznlJOb12TW9saceU?=
 =?us-ascii?Q?CT9IIpTeuUxkMgFjEBfwVgTzBMMWWkcYnwCC2UNi2vXi5hDwSM/BZguhi0dx?=
 =?us-ascii?Q?r5A7t1ByJBu1prQTV17H4t6a7/i5Qj2KsKIsFgrCuGTzxRvmFn14By/8ocqJ?=
 =?us-ascii?Q?A14QryMMS+vXV6py7BAnUHDNcuXXhRa0zTohQh6AQmDBXevrRTCHZeyLfdSy?=
 =?us-ascii?Q?dqe5nkTJ0C/SdWH31b/LbUocbN4UNwFtKJK6GiyQQfX3eHq0Pp3mEgSNZGkB?=
 =?us-ascii?Q?D45meIHMtqbINs+dGBNtdhGJ2i9bexDAb9a7hHOWg8Ux/BfgRX1NAttmjoiO?=
 =?us-ascii?Q?5DRTXmxO68j0faJ3KF2wiSeCDcsz9q6J9R/HdJTqHngdVs0Of3jM8f1NyqOJ?=
 =?us-ascii?Q?nbxgAqfea3WpsCITlG8UdE6kiSFvw7hdD6zNBOSOMgBzpTuMgiOm71PhnKCN?=
 =?us-ascii?Q?+sr/S2FiWxCRQF398irGurT8K61tBLH0lfyWb3QVUEFWpHCg3HvXWBbGKJWc?=
 =?us-ascii?Q?TZPM8lbd0iVVx+RRvn+UscDXYDW94BuZi78MJMex3F3mjGy+CpmhQg3E3Tln?=
 =?us-ascii?Q?4KGF96pRYhS82+BW5F9cKMJ4Et9jKE613c3dPhO/m5t8ssf7S+jzm2S9Pq5n?=
 =?us-ascii?Q?HSiuIt3KiyUaMoBPIpnJSBs0Z611UIbl0jtFkgP7cFG+F+SPiSt8VC+SdLkm?=
 =?us-ascii?Q?5UgZb9PgW3qQzJ/2C9Psvw32lkgE6TOF5543bhQaioKhxtjV3K0NGMHfgK8z?=
 =?us-ascii?Q?NUXO4vA7KOerhzoM2XsW2iRgFUMQPGh6auuh8G494XxCmhhRk1DONVLdYJ2X?=
 =?us-ascii?Q?Fkd0FZmAjd0qrMclnQWs/GOYsW93ck4UN1nc+cCRE4lZAppQu5cQRXJzMqYp?=
 =?us-ascii?Q?z5rcUgc5Q8w9CDHqM2wrKNYMF5q8+1Y+ZghOVpj79fU+CLt/CD28LWCOwUjF?=
 =?us-ascii?Q?+vdb10ffer4mTM2X6y4eEYTTRjllJV4OTC7rRyR5sQ/kgZSUB06CuMqqN017?=
 =?us-ascii?Q?0SNN1mohvB4ABwzh/msgUqcYSQF7BIu9216Bv/j9s8g9QKQaQrwji5ZgnMOP?=
 =?us-ascii?Q?066BB11GgFpgZQF7JNUDq2J8ZyJd7RerGObt4/WMg/bz67KDg6nUyb21LYti?=
 =?us-ascii?Q?l8Sa5GKqL5Ae7PpI+4W1H/yDTx/9WzjJsCxqKo2kVV1izhOiuRs93RYbhFsq?=
 =?us-ascii?Q?Qe4W7/GJlK9HzASoetvRlCa2siMYSNX8WOVkf79RaSUG8mRvmbUuh1Gggs+u?=
 =?us-ascii?Q?hLEEzGbFMvLXrtH9R2v+FGZc+591U9/dA+1E3QtCiWOWvl4OqLMWCrLm6lmn?=
 =?us-ascii?Q?1xq0orFtjXxXZ6DhfZLickkpB9vRsozHHG+n7yseaPVErhTG2petE0cm94GT?=
 =?us-ascii?Q?dvj1F5Xo+rYAJDzIHVbeXLbW9fCXo7q15S6RNNLxiumLbl4BngeFBJUaFrMF?=
 =?us-ascii?Q?xaLbfdI9u38u1Q2bQvwLCY9DM8z8ncBQpmSA/v05lMdk4CVcGCLV8jCrbF7K?=
 =?us-ascii?Q?KK/5hiLbjyAQMXTtpZnRo95eflUK9nxt4rvaSB1o?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f43f8d94-a815-411d-93e3-08dc47dbe54c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 06:14:54.9934 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nF1LIv67P3GXzk/Ru+teKPKnx6H8w7Bt4vlx7cjvKKg3ZXipOe3Ed4yfHqMExqE5H136VEBCXn7QY5sRn5bwXsI7yQRM28P0bnPTjNxzsO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7521
X-OriginatorOrg: intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Dear Tom,

Please pull the SoCFPGA changes for next from u-boot-socfpga, containing:

  1.  A new driver in the misc to register setting from device tree. This a=
lso provides user a clean interface and all register

settings are centralized in one place, device tree.

  1.  Enable Agilex5 platform for Intel product. Changes, modification and =
new files are created for board, dts, configs and

makefile to create the base for Agilex5.

      Build-tested on SoC64 boards, boot tested on some of them.

Best regards,
Tien Fong

The following changes since commit 86fd291a7990af84e96808f48eff2219dd4ef496=
:

  Merge tag 'efi-2024-04-rc5' of https://source.denx.de/u-boot/custodians/u=
-boot-efi (2024-03-13 20:39:46 -0400)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-socfpga.git tags/u-boot-s=
ocfpga-next-20240319

for you to fetch changes up to 386fca68960994ece0d9da8a69a14495b5f1aedf:

  arch: arm: Agilex5 enablement (2024-03-18 14:45:47 +0800)

----------------------------------------------------------------
Jit Loon Lim (1):
      arch: arm: Agilex5 enablement

Wan Yee Lau (1):
      drivers: misc: Add socfpga_dtreg driver for Intel SoCFPGA

arch/arm/Kconfig                                           |   6 +-
arch/arm/dts/Makefile                                      |   1 +
arch/arm/dts/socfpga_agilex5-u-boot.dtsi                   |  71 +++
arch/arm/dts/socfpga_agilex5.dtsi                          | 575 ++++++++++=
++++++++++++
arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi             | 124 +++++
arch/arm/dts/socfpga_agilex5_socdk.dts                     | 163 +++++++
arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi                 |  38 +-
arch/arm/mach-socfpga/Kconfig                              |  19 +-
arch/arm/mach-socfpga/Makefile                             |  14 +-
arch/arm/mach-socfpga/board.c                              |  56 ++-
arch/arm/mach-socfpga/clock_manager_agilex5.c              |  89 ++++
arch/arm/mach-socfpga/include/mach/base_addr_soc64.h       |  38 +-
arch/arm/mach-socfpga/include/mach/clock_manager.h         |   4 +-
arch/arm/mach-socfpga/include/mach/clock_manager_agilex5.h |  12 +
arch/arm/mach-socfpga/include/mach/handoff_soc64.h         |  25 +-
arch/arm/mach-socfpga/include/mach/mailbox_s10.h           |   1 +
arch/arm/mach-socfpga/mmu-arm64_s10.c                      |  59 ++-
arch/arm/mach-socfpga/wrap_handoff_soc64.c                 |   1 -
board/intel/agilex5-socdk/MAINTAINERS                      |   8 +
configs/socfpga_agilex5_defconfig                          | 116 +++++
doc/device-tree-bindings/misc/socfpga_dtreg.txt            |  80 ++++
drivers/clk/altera/Makefile                                |   1 +
drivers/clk/altera/clk-agilex5.c                           | 745 ++++++++++=
+++++++++++++++++++
drivers/clk/altera/clk-agilex5.h                           | 284 ++++++++++=
+
drivers/misc/Kconfig                                       |   7 +
drivers/misc/Makefile                                      |   1 +
drivers/misc/socfpga_dtreg.c                               | 115 +++++
include/configs/socfpga_agilex5_socdk.h                    |  12 +
include/configs/socfpga_soc64_common.h                     | 143 +++++-
include/dt-bindings/clock/agilex5-clock.h                  |  71 +++
include/dt-bindings/reset/altr,rst-mgr-agx5.h              |  80 ++++
31 files changed, 2922 insertions(+), 37 deletions(-)
create mode 100644 arch/arm/dts/socfpga_agilex5-u-boot.dtsi
create mode 100644 arch/arm/dts/socfpga_agilex5.dtsi
create mode 100644 arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
create mode 100644 arch/arm/dts/socfpga_agilex5_socdk.dts
create mode 100644 arch/arm/mach-socfpga/clock_manager_agilex5.c
create mode 100644 arch/arm/mach-socfpga/include/mach/clock_manager_agilex5=
.h
create mode 100644 board/intel/agilex5-socdk/MAINTAINERS
create mode 100644 configs/socfpga_agilex5_defconfig
create mode 100644 doc/device-tree-bindings/misc/socfpga_dtreg.txt
create mode 100644 drivers/clk/altera/clk-agilex5.c
create mode 100644 drivers/clk/altera/clk-agilex5.h
create mode 100644 drivers/misc/socfpga_dtreg.c
create mode 100644 include/configs/socfpga_agilex5_socdk.h
create mode 100644 include/dt-bindings/clock/agilex5-clock.h
create mode 100644 include/dt-bindings/reset/altr,rst-mgr-agx5.h
