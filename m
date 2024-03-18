Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F6DC54E58
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 07:17:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78A8187ABC;
	Mon, 18 Mar 2024 08:17:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ADPYi35Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A44387D2F; Mon, 18 Mar 2024 08:17:32 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A98587ABC
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 08:17:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710746250; x=1742282250;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=pO0kHaR5E6z2rLF1E0hZnoYGg45jrIRALP4puIoBA7g=;
 b=ADPYi35YWGAZX+3GJ2L05RT6WyuRcpjOdA2xGSDMSqM+sVomBo721+59
 OarvpS6YKo8tPqaAl3S5N9KbjYrv0u0tFWimq+MHeCTFN+u5TCJqL9ftR
 KdlN4dy6YTDgIwLNO5ri4WJWYi3YovTvgPyHgH32gJcx1jipML1E68nc7
 KmRmLSFXohUJjt8XwpB91OLbqEAL6ufHKYDJs5nwhjU/cQull8LkX1zRU
 Y+YwdHVIZCASFKJq4+LcXcjx9EubWFJbPa+bZNrxcKoQxBYRCrkhEAjbM
 yMKpM9ZvBJdjOXxZTdLh7K4guNvjTZzKhGnIiLPrXm1E42jiOsSfZZ+K5 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="28022079"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; d="scan'208,217";a="28022079"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2024 00:17:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; d="scan'208,217";a="13414909"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Mar 2024 00:17:27 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 00:17:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 00:17:26 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Mar 2024 00:17:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AOThI7sy2tYw0tFsnZpxmUHPOBpqGfTbRViv9PBzhdgA8cX0ZvMpspfwUmhiCWdNrLaVeWz0+zHsIzMDMYluFtgiY96bvw0yPYXahN/KEv1BmAM2oilEnk+TjNULvwViQV0XM0y94SyYoUgBgOt81rK5c5mjYNxemmqHmEux9X0XmWkSzzT81stWeVS8h0yq8/6BstEBWjiB2JCK7YEa8yCbrlQbx6ZkgNc4q+w6CdiRtan9gnzzXR0EV4n/t+X5bIJVC+VfbKbNb9mO+G206gLKOpU7mG9v/OaCllLXiwuf/qiVsl/pyz6GcDYcBINL/SPA9OIk8iz8lQeAmGFbSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKBndeJFcxD3ytZGr5dL36deQBWsknDEDobCOEISCg4=;
 b=JMA+k9PiblE/gUWSg428QD1GXtbtPVK1ZpaYsJnpW+a2J/HjbYgvdkOkf5Mz+B3VrZ6ZOphYJW08jM8DBaSwfYWIBt90rGM1qcp5UGHP5NaLPhJ8mTFkjBts3C9Gfd0nlgl6pAiB1jFkYr1ALmW5PEHKR9y8B5vCbpq/FTgcVdEpgxavUeSvYpcyMrJXu2WI0t/U1x8gQsEr8NH7GzYTwGXmUlgWJuN1LHk1XuOvzU9Uc6yLt96OwA4WEpmkXLNC9rn11LAbaSLai9y0y9yVz9Nz1D1II1crZlIx0FW4XaKHFmcjoZiNKmC8biPiTPM0cab3fUALe1psq+7dXcvmXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 IA0PR11MB8420.namprd11.prod.outlook.com (2603:10b6:208:482::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Mon, 18 Mar
 2024 07:17:24 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::2b63:5b44:7f2c:ed49]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::2b63:5b44:7f2c:ed49%5]) with mapi id 15.20.7409.010; Mon, 18 Mar 2024
 07:17:24 +0000
From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "Vasut, Marek"
 <marex@denx.de>, "Hea, Kok Kiang" <kok.kiang.hea@intel.com>, "Lim, Jit Loon"
 <jit.loon.lim@intel.com>, "Lau, Wan Yee" <wan.yee.lau@intel.com>
Subject: Pull Request: SoCFPGA changes for efi-2024-04-rc5
Thread-Topic: Pull Request: SoCFPGA changes for efi-2024-04-rc5
Thread-Index: Adp5A3hlvzxxdemOSe2nfpHsvJxD3g==
Date: Mon, 18 Mar 2024 07:17:24 +0000
Message-ID: <DM8PR11MB5592FA8A7E0B0164296FD4ECD22D2@DM8PR11MB5592.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|IA0PR11MB8420:EE_
x-ms-office365-filtering-correlation-id: a822073d-a492-412b-ad4e-08dc471b7585
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ihl8E1SFIc8jCou6K2Q7P+GXoLpdF2cKbnwrWIs6NwF/dFrC2wsO37XoFTMf3m5Axb675LM5Hi5GwXv0f6uL0ZQqVgbAv7ZXDaOin+FvNkxKxktzhwDl3mqOl3ZYQbar1u8Bh4SzoAVfsWjQJA/ocRdzOuCRmEEFNkWZBCsmb8V9mhmdKwkk1iLDnk+LWz0opLRd9LWV5OhQNp1eHFV342L5ybwC2i3GY1fRflGylazEU5KZ906R0dkzCf/zq89MbktIwVl5WlBdkr7ZSrn0kxkuk4yGgfhvO/b/OXtnZq4J7rsNE+IYj9mQzDmrZPA8DbKTfyhgR4Pdn32FTmNPjYJd0hYrH1HTSiYZyOckdExghQ+kgBtfEBkJOO0+SeCbmooY20NxnM7/0isJB4bB8B7fjd9/rpTH4B9RChWq9xC3Bh2WJ1uav04QTJ49znVokBzgn2vtfBaxOF4URGwcBdSQqcFzOW+1eJIlSB2Q1eRu/Ja9HnCG7gp05g3XnQvcs18nXOMG/zJS0iNXmC2Nsv4YldYcsKamqe/jpfazLUqsYi5GlETQak/uJzn4933u+Yu96Q0I4SjY2yRT1zlXVuSh3akUzfYkS/kl6Z/CDoVibzuXhscaKiygqi785zFhjx4nUyRcddFCzb2acb6pxPZ0cOjwOVZPiI0QwhnisP4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5592.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TKVcKCr39zLs3HCKH2vy/cxTGQaxFkFlAwhxuQhB2NN1prOV70VaB9cBt36U?=
 =?us-ascii?Q?WpOoumcNXVI4HmNWaV4ge7rtr2x2S+YvwKxWT1thta6ga2IhaBi2zCDoH+He?=
 =?us-ascii?Q?nOE9FjmjuGZfjFZiU6Z/OXl4tyrJljSfgGrKv8ri3RhcSPNtME08m3ZZhFxw?=
 =?us-ascii?Q?c0qRWtCSWsU5FnL0SbZmKMHxDyynpdsc08Luy/AHTGl578upsaPc6/VmrYBO?=
 =?us-ascii?Q?kI+BWPEHo/eVxOBe7Fi5eMaWNRjDtzDijFgLpX+XbVFrDi3xf8nTD6Ki6wGe?=
 =?us-ascii?Q?dCkST7EaWGd1uO8ixo+qIn7KvaZCQibTlQP6RyiE9WrPCilkykBTQB+ucLsa?=
 =?us-ascii?Q?pnFpyF/4SREtrQpffgM9S4sOt8kBqZydZkTcpt9lwTaWBsSHPM4OeQ01xxxp?=
 =?us-ascii?Q?YLmGzDB8wWl2hYzWOovuOkNqn+mseVJb9cBRyjCQFo+b8XvqAslYqU46E8Am?=
 =?us-ascii?Q?yfJeTARWCwkD4zwgrqecZrCFhkoKfSqOAPvRMwVd7bTORVYJYkEI1EJWYYxH?=
 =?us-ascii?Q?pPkT7qLhSWrNTfizZFFIrs9WcFD05svhBypRLLS/lRvLjNIsi7qoXsOWH3lk?=
 =?us-ascii?Q?oA4f75UmC4Dmjdod0Ec0MZJ4tLOySqYbExFj3rQjtpcoPeg3qDSmNd/jhGPu?=
 =?us-ascii?Q?ES+XlkdnEjmMdO3Cy1GPpnsVi2ASRCewYxsJib1QlJldJoTjCRgFm5zaQNbp?=
 =?us-ascii?Q?sjnir1SI39SnYAVY5Ev9DPPeSgQIHz/P/5l3Pz7pmosXhj01mnHgoHFXzmIv?=
 =?us-ascii?Q?65GfFOJ9odF+i7vER5V6t+1XOOerMYaVjWWqQ3O7/oWBnNnzb7C39UbG8Es1?=
 =?us-ascii?Q?dznHoNXDXv39vv+cf4FcJezn7X8+7zfNcHqPrycT09CypONnDVGvAVrO9qsz?=
 =?us-ascii?Q?p3Ck33g9b5d3DiDc/ow6uTgTUCvGC+X6a7DXeSnloOSu4WKjy9C7jh2NjkiP?=
 =?us-ascii?Q?PWx/qv0rO0ELiXk7lDuSS2ckitgyvR61Oa56QaNsqj6nALXqpDkfi/nudit6?=
 =?us-ascii?Q?V+0GgW/ogI3h9O6A0jaH2rjUU+6ZKSj9HtNqLvZFxMm1U+e3+QWBpVMd3BV2?=
 =?us-ascii?Q?no2dousFc6ll0RYqKSehdPB19jM+y4YI3nMSQqhzX1N6qHt2LhfXQk2dluig?=
 =?us-ascii?Q?5W/ehNK14vVDA9osONe4di+irOX88KvBGPq/ugUrX9GuyoO6l+s1yRxQag6c?=
 =?us-ascii?Q?r6JM9p9j/QDL54Fp2RN1d6nuNXYyyDBM5U6i+HiWgzkGB6J4B27x56JOjaRY?=
 =?us-ascii?Q?vzuoWopJjk/tkze+0kFswz1o7rileT1fqEYEJ9UkkBJCu2ToYj94A7+t2SC5?=
 =?us-ascii?Q?/QIzJFKsjTyynNkCRrQe/mMfeHfylltRzHVlFaXuo+Ls+izkr2zjkq0rW5G1?=
 =?us-ascii?Q?Aw6KecZK6SHhlAQoRoYJezCBOqdOUm3lj7HDdo8tWABU2DTzZKu4S7DfjIWE?=
 =?us-ascii?Q?GCV7GIQn4b/8NsOGMd84BvGiJdYFxUenWZ31B/lc24KA1OG3VPKNISakEood?=
 =?us-ascii?Q?CKj8XVaO8kYVe2oAUEHOJRjNuHsgxVj8lMR13S48pOvCgGVGHQymENLpcGgI?=
 =?us-ascii?Q?7VHtGstDTiwBWg+7WzPellBSu95onfh05sJLXn0H?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a822073d-a492-412b-ad4e-08dc471b7585
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 07:17:24.0874 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KcoIiz/5ukaXrtuFCfYy3lGn7LsIYivHJjBzAsJtlqiEi0c8d1DlC4vj2rLi2OKK3OBYh+VexsVbmQwKWvx1LTV+n+rVMYzxT5yyVW1ZnTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8420
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

Please pull the SoCFPGA changes for master from u-boot-socfpga, thanks.

Best regards,
Tien Fong

The following changes since commit 86fd291a7990af84e96808f48eff2219dd4ef496=
:

  Merge tag 'efi-2024-04-rc5' of https://source.denx.de/u-boot/custodians/u=
-boot-efi (2024-03-13 20:39:46 -0400)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-socfpga.git 386fca6896099=
4ece0d9da8a69a14495b5f1aedf

for you to fetch changes up to 386fca68960994ece0d9da8a69a14495b5f1aedf:

  arch: arm: Agilex5 enablement (2024-03-18 14:45:47 +0800)

----------------------------------------------------------------
Jit Loon Lim (1):
      arch: arm: Agilex5 enablement

Wan Yee Lau (1):
      drivers: misc: Add socfpga_dtreg driver for Intel SoCFPGA

arch/arm/Kconfig                                           |   6 +-
arch/arm/dts/Makefile                                      |   1 +
arch/arm/dts/socfpga_agilex5-u-boot.dtsi                   |  71 +++++++
arch/arm/dts/socfpga_agilex5.dtsi                          | 575 ++++++++++=
+++++++++++++++++++++++++++++++++++++++++
arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi             | 124 ++++++++++=
+
arch/arm/dts/socfpga_agilex5_socdk.dts                     | 163 ++++++++++=
+++++
arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi                 |  38 ++--
arch/arm/mach-socfpga/Kconfig                              |  19 +-
arch/arm/mach-socfpga/Makefile                             |  14 +-
arch/arm/mach-socfpga/board.c                              |  56 ++++-
arch/arm/mach-socfpga/clock_manager_agilex5.c              |  89 ++++++++
arch/arm/mach-socfpga/include/mach/base_addr_soc64.h       |  38 +++-
arch/arm/mach-socfpga/include/mach/clock_manager.h         |   4 +-
arch/arm/mach-socfpga/include/mach/clock_manager_agilex5.h |  12 ++
arch/arm/mach-socfpga/include/mach/handoff_soc64.h         |  25 ++-
arch/arm/mach-socfpga/include/mach/mailbox_s10.h           |   1 +
arch/arm/mach-socfpga/mmu-arm64_s10.c                      |  59 +++++-
arch/arm/mach-socfpga/wrap_handoff_soc64.c                 |   1 -
board/intel/agilex5-socdk/MAINTAINERS                      |   8 +
configs/socfpga_agilex5_defconfig                          | 116 ++++++++++=
+
doc/device-tree-bindings/misc/socfpga_dtreg.txt            |  80 +++++++
drivers/clk/altera/Makefile                                |   1 +
drivers/clk/altera/clk-agilex5.c                           | 745 ++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++
drivers/clk/altera/clk-agilex5.h                           | 284 ++++++++++=
+++++++++++++++
drivers/misc/Kconfig                                       |   7 +
drivers/misc/Makefile                                      |   1 +
drivers/misc/socfpga_dtreg.c                               | 115 ++++++++++=
+
include/configs/socfpga_agilex5_socdk.h                    |  12 ++
include/configs/socfpga_soc64_common.h                     | 143 ++++++++++=
++-
include/dt-bindings/clock/agilex5-clock.h                  |  71 +++++++
include/dt-bindings/reset/altr,rst-mgr-agx5.h              |  80 +++++++
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
