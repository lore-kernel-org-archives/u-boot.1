Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9BF1C4725D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 09:31:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA5D487708;
	Mon, 22 Jan 2024 10:31:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ghiRwICJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03BFA876AE; Mon, 22 Jan 2024 10:31:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDB3E87645
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 10:31:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705915866; x=1737451866;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=0a9/1FWZn9ZtBaE0FVnEbe+EjRhTZKcDJrVH1fS8umg=;
 b=ghiRwICJ2gqjgq4A/+uE9y1rMY2gS+rV/6ijAonAnmbJPwzLxBvxNb5b
 9jkH6EUO3+01CPFWaW7+S8FIb8F8Z1tekq9yILKgRriq160eonm+lKlta
 5Gqx9wOuJO8CR3x382b8XpqIYNRAjEKTOgtIUUAUdYujollcS3cocI8fl
 NcXOYQZOQTIg5XJ+xPDfpyLlNApoEBpKJ9K2tVGhRd9n1wemqEr2OgHRQ
 pxfNTzggw2dJAXmtT7BSs3xcXza4WEb1KV4mXr3cQtX3szODHC+8FOTrZ
 8NhpMth9C2dI+h/e8FB/KYabVrjr61lKsvQhTjJI8F1SfKkwPQZKFKGwF Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="400805986"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
 d="scan'208,217";a="400805986"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2024 01:30:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="778533093"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
 d="scan'208,217";a="778533093"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 22 Jan 2024 01:30:45 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 01:30:44 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 01:30:43 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Jan 2024 01:30:43 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Jan 2024 01:30:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWBudHdV3G/iEHeRkGyaWc5gi5ihJBNHCpo5GYbG/NrK2LvlANJnczY2EKNP4K0Y95vJI71E927Ubai3gszOf4emwx4J5gOQpqWeMN/tPXttZNtds1aY931yJqcjmTWAEF4D0jS2iU4GeYY/6Ju7lQOEbpNL22msrXdD3Oex/tFAPt2ZMWlwy/lb3iIuyHYij1ALaHsY4jNwBgKqoByhFbXNFGbLBtK9F8ianm3Dn6NPwqGYEhl1h6Yil2uvMHu9PQn3z/Xiz7R5x+Eh13KwU9altfYuK7Mq3wNDFE9BCHInbYx35HkVWYsj1GbK0uaFIRMUks5vtMT5KzHPENjA2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMBJ/QoUSbQKLwd7XRrGnxZDxJJwQwDHHsbiVvwsOP8=;
 b=GnakpE9LN5dqcE5JU/mGOtX3Sn32twUJqR2aYwZNZCnOWZ/uyKL1gx3OcWRyHksEm4A9trB5P13Q+QsSw/mvfTMPcHEXBjNab3ymPGtbkONPBKn7j4sNoOTTKw12+2GZNSxEKMcBZA/go7jyxG4Q47CBzWbsxVfGnIWyf/tbNh1r6AgaupFhhRGe7HtMdkU6RfrTY8rktRl70WGKFY1lQpXcyHDHhEXHYJKvYAlYouHnFrgGK/UAgU7XXGoRYiFZRBC3e920ASgMzAlpSIadT5bu/XEqYytNhUWcJzY+V4u4NCBRL4udqH+vCPJY9iQpi74Fo6IjcGZkG58eqU6VSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 CY8PR11MB6865.namprd11.prod.outlook.com (2603:10b6:930:5f::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.32; Mon, 22 Jan 2024 09:30:40 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::e293:879a:787b:a663]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::e293:879a:787b:a663%5]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 09:30:40 +0000
From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "Vasut, Marek"
 <marex@denx.de>, "Maniyam, Dinesh" <dinesh.maniyam@intel.com>, "Hea, Kok
 Kiang" <kok.kiang.hea@intel.com>
Subject: Pull request: SoCFPGA changes for commit 3c9bb8fbdc77f
Thread-Topic: Pull request: SoCFPGA changes for commit 3c9bb8fbdc77f
Thread-Index: AdpNFYhK4gWXpeBGSTW3w5IisJD83g==
Date: Mon, 22 Jan 2024 09:30:40 +0000
Message-ID: <DM8PR11MB55920154289761E48681A3B2D2752@DM8PR11MB5592.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|CY8PR11MB6865:EE_
x-ms-office365-filtering-correlation-id: 05321c58-ab8e-4307-4dda-08dc1b2cccc5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2BCnvlSP1nLrZg7pQeHYLeZJFgichxFWVJeG1v3sEPj8bn1MH5T1376MN6JeLjU+k72AjEt2M2vVWhZKkQ+nI5ndiJMejLZelSLMswPUd+iSc+F5qJbDqrItVp7IAUVQawuRa/OheUbTrLJIe/+npGWGH3CO5EfW/hqBz+o7tM5Tg6EMheo9jvMcH2ODECsh+ffHLhy0q1UbQvA4zPjeIDmkQD57YAVhZZnCLSJV1L1nShibXslZ8uy2dob6JfZOKKDEpCMBBY+Q9bH6KcsYS6bocp5uTkJsdPU1i+TakhP+aLnwOFozeJGiXglEITKZ4IxMo8spdZSnyEYSWHE/D2ULgMzrqYmnqAJObHPN2qxYLS+wckxeeTUo1ZGhM2ZlcmtNNgCXrJK42gCGGGuKmMsICD/YG4DNUUpnmFndTGyaF2Fceh/nkThEJa2sCEvIwzDKbVU/2RXxo3rHfzXye0iC+mghh7WopHoB4IeleLEzlgkU7NjDzvPDEBgDIsHlnaDSIVeSdTXunK3y9wxQrrSryWAjjjXbZ0XG4ePH68+AXc88XHTuDMlywpiMuY/kapXe9EqBfSiOQBx6JXPIQ7/yHujKNbHovBe0uzeoAaiME95CGcCb2cPXoe4E4+hZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5592.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(346002)(136003)(366004)(376002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(7696005)(107886003)(26005)(6506007)(9686003)(33656002)(71200400001)(122000001)(52536014)(5660300002)(9326002)(4326008)(966005)(8936002)(8676002)(2906002)(83380400001)(478600001)(6916009)(316002)(66476007)(66946007)(64756008)(66556008)(54906003)(76116006)(66446008)(4744005)(41300700001)(82960400001)(86362001)(38070700009)(166002)(38100700002)(55016003)(98903001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lq7UAvveyeJPiK3gV+5G0BnMMenvAKFsJxolWnOVSoCaLSR9wsBRqWScYVsw?=
 =?us-ascii?Q?UcbbhxesHdj3+lOjSpS6e50nEVDsOoyer6ydOWwBroZrd/qqxg7jTfVfNtVH?=
 =?us-ascii?Q?OobKHDYBpcdPxmIm+GNvX4t18S3lPYV/oUUtuD6+6OYtAU4YQInycx7W3IsH?=
 =?us-ascii?Q?uJhwRQBP4NoMMGfolbxmsQ2rU82SgazEAmYy8ShEUkqtxGaIzEpris1pHoLn?=
 =?us-ascii?Q?WBgBO7bVRV+ymGQ3YjMD1UAcuxRcxndA/xqyfJWWnEGaR+HHHd3T/QXBSs3r?=
 =?us-ascii?Q?JF5uwP7yqLDb/4o52CNCbIc9F2xtA1sE/hH71PN0V2BjVaSK2Yi7XQmZ+a/D?=
 =?us-ascii?Q?iblR9u5ls87hLB19vd2CEz106Ll1tyiyCSsenFL5fq1I8E92BKt8nieE0G2K?=
 =?us-ascii?Q?H5yIPQMe96tGS6EytG8Vp+yAiJczYMC0FZnj9OookW36WZnzk4NehwmZYbeO?=
 =?us-ascii?Q?TqaYb7d3rCWotBvERz05KjKhnLC2yMACDFB2HYBihx0xQrOjQnk1IHkpWBWu?=
 =?us-ascii?Q?nHbjnNolst3JI3/W2YOygPnEWuMr1yvEX/TZawKzmYsHNH34KMOs+NZFYxNT?=
 =?us-ascii?Q?mo1E3K+q6jU/3yuo5KlXCnIg/QOCWRFL9voBihNltQr/+c4hj9tqJ9JZQ+r7?=
 =?us-ascii?Q?Wr4BgQGxyNrcErP9Pc2Aw/YMfknobGTUKDNLz+le/YzVcAjzCTbF1kA+P+6H?=
 =?us-ascii?Q?1MabrIUXpbbBwaXUxLZ3vf/L0Xx6GCJAu2kPOXI2yJRNvWga0DNhS4LBnUFH?=
 =?us-ascii?Q?FQYgqpu7GQgRlIg6+wwXTF8MUS69eTUI4orjmpEPhRiuJHMtHm15DMeT0hX8?=
 =?us-ascii?Q?jODSX/VpHbzs/UrdTZkS4PjdCDSFFIRO8rT7Abw4yqSaJ97WtDtcXp7M8Keo?=
 =?us-ascii?Q?fYl36hXtpo2uYnB07yR54lEFESa8Cs+6u7hvGYMBQmBu55vbOoQdIDTaL2F2?=
 =?us-ascii?Q?JgohYC692M3frLMQ+5SU30dw+BSLd+x7l5MydVWm0kmGTShtckYE/uI958iO?=
 =?us-ascii?Q?T79mWLjCPqBkUNkUMUw/Dl2oFBZZ+YAbOwGbC/u63ZWL/+7vSKM8oS0GlmWq?=
 =?us-ascii?Q?iP0LU8+lJB1ymSdcvNm1SV/rBUXGMTHZDOxRbgxpZGryWQXiacVy0FJCiICA?=
 =?us-ascii?Q?uAYbQFt+WSttTDh1Hf6SV57F0T4fWM/nk7cpGKVRpWneVxtc4+WPI6ezOJsJ?=
 =?us-ascii?Q?hRAdQ0ExasihTXuZQYjTovnuvuSpdXm5pS61xFDLkfKDrGi1fBVcjxxBdBkV?=
 =?us-ascii?Q?99nKOBh5eVTAAKf/7vCrdF/SzNKhIOqr7yMvEkV73SDlHXYmJLFXVnHkDw2x?=
 =?us-ascii?Q?xHPWWWiBUok/oGrrK6ICDz/+QK5VTQE+lexfv7wGsELWcJ6Jzx7PYMz3+wYA?=
 =?us-ascii?Q?nauNl/NUVguecRDOoap1ZNocBYaMve/kShtC34zy+1l2nG4o4kbcwL775ycR?=
 =?us-ascii?Q?U0wto7bfDdi3X6/TTJuq90lv4y6fyGCed0w62cKKok/WSxfTs26nu3C8XKw3?=
 =?us-ascii?Q?koF0sPnddbzy3fjvEMqiMDshqhS1ph0v3RpjYcZvP5h26Oeh9Lcde3eOFnNY?=
 =?us-ascii?Q?LKUoiTL6EOu+rv8E31MiVkq6dhpvQLOBbKePfd2O?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05321c58-ab8e-4307-4dda-08dc1b2cccc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 09:30:40.7736 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s2sKURq6hHch1Hu7hqMTJy3BsYtaZd82taA7qkLR3Q29l1UtkXTqkEEhLDEjSFawedcbaK6e0muMJFCcrx0p7w3G09iFhgn2Lez6xT2EGSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6865
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

Hi Tom,

Please pull the SoCFPGA changes as shown in below.

Best regards,
Tien Fong

The following changes since commit 3c04fcf3137d5f694d52b8f355373e4baabe5f78=
:

  Merge patch series "k3-j721e: beagleboneai: Fix USB" (2024-01-20 11:39:13=
 -0500)

are available in the Git repository at:

  https://github.com/tienfong/uboot_mainline.git 3c9bb8fbdc77f6bd56e97597d8=
75d8965db3b96c

for you to fetch changes up to 3c9bb8fbdc77f6bd56e97597d875d8965db3b96c:

  arm: dts: agilex: Increase reserved memory size to 32MB (2024-01-22 16:51=
:29 +0800)

----------------------------------------------------------------
Dinesh Maniyam (3):
      arm: socfpga: stratix10: SPI clock support
      clk: altera: n5x: Fix MEMCLKMGR_EXTCNTRST_C0CNTRST to bit(0)
      arm: dts: agilex: Increase reserved memory size to 32MB

arch/arm/dts/socfpga_agilex.dtsi          |  4 ++--
arch/arm/mach-socfpga/clock_manager_s10.c | 17 ++++++++++++++++-
drivers/clk/altera/clk-mem-n5x.h          |  4 ++--
3 files changed, 20 insertions(+), 5 deletions(-)
