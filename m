Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF222C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 07:34:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 096738816D;
	Mon, 15 Apr 2024 09:34:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="GBlBvacI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 525BE881C8; Mon, 15 Apr 2024 09:34:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 958CF88157
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 09:34:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713166465; x=1744702465;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=FJjFlZ5BY3Kn+523esnbR9O6YuD4448FsVto8R8hDkk=;
 b=GBlBvacIir9n1MB/gh4iCJdypOEch4nvpRSPTuhBHYBV8elh5xpXnP60
 Apg4d+sYgQw3fC4Yga8HIIexVXYyGbI2BXFPfVsg1FGu4InnCtHRRfMym
 1KNbQNiwZCoP+l3Bpev7fKbLL5Dw+0bYgppcS99I8YJvOaZStVWYJM1Nn
 hS3jYpvtc0fdbKLhc4uz1OBOuA8lll9Wwsho+0v1aXkNaln3e+o7CkOGv
 wDyLtvJ3Dc0wqkXdBLuO2GVZ+KKw2chl42RnjAXK79fAWC+5e6zYh90YU
 MpkKoj26i60q3BPBsshsbyuDrC18N6dgq/X28mAulxZlc0fw+7UO8h67O A==;
X-CSE-ConnectionGUID: 6iLs3nBkTLSNkMJjgqSYdg==
X-CSE-MsgGUID: JC73TtxkRdaxr6Xho4GwmA==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="12386067"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; d="scan'208,217";a="12386067"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2024 00:34:23 -0700
X-CSE-ConnectionGUID: dmc9R36mQN+p0qYd9eHXyg==
X-CSE-MsgGUID: adSer6okRayPtT6p2eNjhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; d="scan'208,217";a="26250701"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 15 Apr 2024 00:34:22 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 00:34:22 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 00:34:22 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 00:34:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=moZ/3LvR1L0E7Z4OTAxm/5QXj9qjG8UOz7GZpF7gOvzPbwk8eE5dkI40dShLkGqQuYYnwHSKN8uQKU0XiqwW4kGGXQrGI0Yww0XTz+r5Mcf7+6OBXPcW7nMYd4neuVlLPF/yFPo1avfjW41OlbA8Pp4E1Q2JTJBhNNTwDuuHEE9EBlsV6IKnNIhO6RT6sZSlJW3b8zlK0z9564g63pZekJEAn+POpHQZLkeA63cymabuR6ooeaO9dXjVF7GEiBbhntp8WKflXpozg+1S3l/AID51sDaYgVK6ZPgfsUQQ2kzKh6bEI9yGWmfqFzEh62eQBbjM8tJ1efxnn94JmquAIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtHGjslZFzk8swzFV05OhhpirlzBeSo6mxtUdsG6ZcM=;
 b=Avgk3pPThP3c1LW400l6tUnwc9zO5yian99czUtCnOnHLKDQdVCAzzegrRdNKqHNKnC1x2hjIvgJsmFLpfsh2LfuusGvuIn2+89Wd0PZTeKXM820vHYSBV+ft0lifAJKzNpwSD90N9P8Ru5gAkGPxzrQHXlxDji5IHziJg43WxYyP7KdCm1aDI+lY29CsAOC0S7ubAPGyfF/GTkRu3Ga3R1OdGLl1M0M3oXFz7tadUI1tp9i/5A/RPvsI9N1PvnCE6t90KhsuS2NtJwhwdwkCMyrgdWvj30bgTd+kOzuyN61WS8EjGCZ5gA8RDQzUePdEoxgafVy30sIucX5vHGD5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 MN2PR11MB4742.namprd11.prod.outlook.com (2603:10b6:208:26b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.29; Mon, 15 Apr
 2024 07:34:20 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe%7]) with mapi id 15.20.7472.027; Mon, 15 Apr 2024
 07:34:20 +0000
From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "Vasut, Marek"
 <marex@denx.de>, =?iso-8859-2?Q?Micha=B3_Barna=B6?= <barnas@google.com>,
 "Lau, Wan Yee" <wan.yee.lau@intel.com>, "Hea, Kok Kiang"
 <kok.kiang.hea@intel.com>
Subject: Pull Request: Please pull u-boot-socfpga-next-20240415
Thread-Topic: Pull Request: Please pull u-boot-socfpga-next-20240415
Thread-Index: AdqPBoBLTEryk1nnQHq9HDH5d1wy3A==
Date: Mon, 15 Apr 2024 07:34:20 +0000
Message-ID: <DM8PR11MB5592D34AF6D95F4F105443B2D2092@DM8PR11MB5592.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|MN2PR11MB4742:EE_
x-ms-office365-filtering-correlation-id: c056ac6f-3f0f-4582-7678-08dc5d1e76ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ycTBcy70mVpKatQxi6A6vqdpYsDs7HGe3HXMtH61qR6rwYPTaL/L8PoLYjaCWZ2HGqweC5+tPsNHcaACYhF+j56ylsESYNBWB0LCeSeCM+eBkUyLaRCtccChk1x2vEsyRz5X8jhd9awwCAtX2LGqN3jEXbNGIEVAO1lckVI7s1orkR+RT79aCOr5xzuRy2aDfkpb9NkVbxJ/Y8ihkVesL9s2hxca+hMrnMYRfGt724NHceUq9hIdrU5sGFjqvy5xM//3Cy6byJ6tix2RxXQr6LCKHwec4UI4BU5PcPFa89lHM+xV2tNUYX3JCW5lmmkLGhDRU9TjdL76nfhH0PLZ6IsGXhEEBXeK8pVXfsy4bq37UsnloX8DrbwSlkeNgz+S4Ukjv+Pk8dRC1DqYSax0P4xN2OyoZ2AW9CPlDPbF56B3YDCNpFFb07ginLBhhJMfjDg9ZtP6gM3hzecJFYj3Iutn9lN0wGB/FYGMiYRd4zHxMmGXB+82IC8wUZRwXHtr0urtevA+TLC9feenbfayMA+tPDXxX2B9pcoEqLWOM3kt0j82qN+2BAYKGAOYTUPwXqs5+0xZDvzPHf35h8QyoIWm9bEJN7A69Tb3zuCisVUwbco0KH8NG/MawdmvAS3zXDAIW/2G6S1BMzUTwNb7Wtk5RQH7PmZgdxwyQJagHt3WYG8a1BjUx21puwvVYxsozCY0LxhTtgSkQ7T5hZ8Ji61krQNcSGqoQuv0s7qIfRk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5592.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?Gi9UtT2I0DCyDVAnftCK9D+0sbIYovUoRFt7+U0GqLp3RauTf308lsmcVX?=
 =?iso-8859-2?Q?nf7mewxXbOcSV7GsSiajtOw555gPerwOoWTbrBU+lWOLS+O0c6E+VuVWEw?=
 =?iso-8859-2?Q?7U2FPX3Ww1iRVakKM/AWckYZPPORBP/GB/Tc/H9mBVUYZqPYzgfCm53Ks0?=
 =?iso-8859-2?Q?+gjT9K5dM+TQUrGFVjipH8h+BosOCAr/hYcmwDdCoO5xqu4UMtfNL6Giy9?=
 =?iso-8859-2?Q?bZouDWKP6YxlDwpuDQlCC0JmqA7upqgfvwrWkzfpA1ywQ55ZH0MUpltXYT?=
 =?iso-8859-2?Q?ABLUiYz3t4OR9Co5cDGUJ4ZGh8w2QPpqVanqoLjECNYm9Y1T/6krTBOYKv?=
 =?iso-8859-2?Q?TOq+l0PyoYlGe+LVS64DxfFwKWLwYz79KvNJSd4ZzWD+XcDAHQ+7/Ija6m?=
 =?iso-8859-2?Q?RIiPWVU0w9O27ViXEu415p5RlhfDsPxFp+3bsg6gFTTSLgR+ZW4Hzj83KP?=
 =?iso-8859-2?Q?hADHfytOCcivfj1I4u24ZOK7qawO+0+F3g8BOO1SKYtu3sV/sqwmZw/WkR?=
 =?iso-8859-2?Q?+zOFX/Rp9sI+FiR90dP+2ZlvkDkQ08e6Im2F9gfXqbiZd+nukx74+kxlsw?=
 =?iso-8859-2?Q?YlTdISu8dt4UtPH0iPm2GCRJ1UZzzFT5B4EBJNCxRFZ2P+QDM6cXY3RoAB?=
 =?iso-8859-2?Q?wkLvgiY/f9oF+Vnm4lChfvVUEsry8DIfLuaxN2SubbYvUGUWdyqtKMEMO3?=
 =?iso-8859-2?Q?9PIpxSi/lEahz54LI3sPMGTmN6Rv2U/D14fMQ2KMwWFIPQzTHnFS0vKrxn?=
 =?iso-8859-2?Q?7FRb0M9l4iDxYi+KtEIBjP46rO4YbxChKHeGHZnBl2yzUi3gFbdZyGTcZh?=
 =?iso-8859-2?Q?mf8FJFsobXlMNpoMX/mpBKR56NnxbZF+W+1zKTAcgCdeiVxRlGpY9Za+gi?=
 =?iso-8859-2?Q?6Sxrn8GGVSgAaJSWcQqstq/ctLC27hkpWEmtDX71+NZt1Mx1fiSldFHTjv?=
 =?iso-8859-2?Q?IAwj855uc/ExDC+mr2/9pDVO9DmgqxpHnzi8rkKtz55fTLd2CSo6aLTILH?=
 =?iso-8859-2?Q?MjhMPwxc6GFwdfXPPtZY1MMedqxvUY/bkrov31bSf1ZSAJR8Bt0syr0c2c?=
 =?iso-8859-2?Q?ptcqxWJXn5uZ+iKJbsQGcI1g0Ry+JVfxGwFGqS2oj55DWOS6aLXjl2bOKs?=
 =?iso-8859-2?Q?hEl6+mEO7xPv1fVfv0BO7mrCO0IruRxI2JD9AQFSoZVLJv2Yc+yraZmtxk?=
 =?iso-8859-2?Q?P0h3mBxnIrFpHrep9523LqkGX4XXKI2X5//imYOCfxyTyGNZApVJMBLG+k?=
 =?iso-8859-2?Q?AnaSTM4Jgi7Z7QgzWzFUoS+MX9lcILlZLUH0AREsTYbMo6f0NUpjf//Hlb?=
 =?iso-8859-2?Q?DAbsNYomyezmDFOwcvpR9HX8YRhtu6KkTD9shvPZQlLHXcC26t58PL8vN5?=
 =?iso-8859-2?Q?WIIM4k9VQeelrfrvb0RWMtNz4yWWHTjMrXfiQe7Um1piefkaGwefosFLJ1?=
 =?iso-8859-2?Q?WQTiXuHvGN4o2jTLxEaRf2c0Kmhs5yHG4Na2RiCyt/qiD8yFRdtFoSEYQG?=
 =?iso-8859-2?Q?TkEe8di+3jGkDZd+aY9rAF+D7kBVxxC2QI1gxZCoP+geKUQrv5zJClMp+o?=
 =?iso-8859-2?Q?R/T3NnxP6x73+wKBBHtHFG0S9JqvC1pqrR7nEYo/hfIzjQQoQhCqc3oFdx?=
 =?iso-8859-2?Q?MfwP3B8+QX9WNwtjy0OWA0gXrsPq/r/XR8?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c056ac6f-3f0f-4582-7678-08dc5d1e76ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 07:34:20.0823 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HDEQCrXki51rNfiEhxEY+3JvPdqivQWhhnP2NzohFZtLfaJyOQXEWi8Ok/4BxOPpX8bHaeWq4mbLRpQBaJI2QEeD2XJ6rVKAEH/kGMfQlH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4742
X-OriginatorOrg: intel.com
Content-Type: text/plain; charset="iso-8859-2"
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

  1.  Add option to reprogram FPGA every reboot, enable this as default in =
chameleonv3 defconfig.
  2.  Fixes: Rename CONFIG_SPL_SOCFPGA_SEC_REG to CONFIG_SPL_SOCFPGA_DT_REG=
, so the driver can be built when CONFIG_SPL_SOCFPGA_DT_REG is set in defco=
nfig.


      Build-tested on SoC64 & SoC32 boards.

Best regards,
Tien Fong

The following changes since commit b03b49046af5dfca599d2ce8f0aafed89b97aa91=
:

  Merge https://source.denx.de/u-boot/custodians/u-boot-usb (2024-04-14 15:=
58:31 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-socfpga.git tags/u-boot-s=
ocfpga-next-20240415

for you to fetch changes up to 27ed98d491521a637f2b4468ac021511294f897f:

  drivers: misc: Fixes: Rename CONFIG_SPL_SOCFPGA_SEC_REG to CONFIG_SPL_SOC=
FPGA_DT_REG (2024-04-15 11:16:06 +0800)

----------------------------------------------------------------
Micha=B3 Barna=B6 (2):
      arm: socfpga: arria10: add option to reprogram the FPGA every reboot
      chameleonv3: set in defconfig for FPGA to reprogram every reboot

Wan Yee Lau (1):
      drivers: misc: Fixes: Rename CONFIG_SPL_SOCFPGA_SEC_REG to CONFIG_SPL=
_SOCFPGA_DT_REG

arch/arm/mach-socfpga/Kconfig         | 8 ++++++++
arch/arm/mach-socfpga/spl_a10.c       | 8 ++++++--
configs/socfpga_chameleonv3_defconfig | 1 +
drivers/misc/Makefile                 | 2 +-
4 files changed, 16 insertions(+), 3 deletions(-)
