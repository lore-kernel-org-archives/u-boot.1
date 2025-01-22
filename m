Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4DDFC02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 05:37:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36938801F5;
	Wed, 22 Jan 2025 06:37:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="d9lc4/9u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E5D7801F5; Wed, 22 Jan 2025 06:37:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B30D80137
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 06:37:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737524226; x=1769060226;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=fdzWFkR8uIO3f0Q01sScbwRrBDMTiKRYAyH1khkB7T8=;
 b=d9lc4/9u3H0kC+2gftaawsizM/W8doJWxoUehpDW64ugA+7Jqkao8rgV
 RL8dW5pGeRV7bIQPtLFQO/jihFbyWJXfp4UNfocVkOhxNBwRZC2h7l8KY
 GnDxdYHDFSt+H4LzPNwjFEQtT2F1qqOohkkXs37T7X3lbN9cQBqIRGVPt
 rWVNmkw2+gUkl3c9m1X/vPvON84fYE98ecR0OZ6+B0HviPeVV1g8ApsY7
 +ICSa2qD2Jf4Zu3aNMyhllE1rIjzpLBIBN+RFrZjbeVXY+RDHXVmBY3dN
 R8zvq7tcV7J/3iwxj88m5xJFJyixSOk+tllfXUwqscwdfA9igRLeQ8Ryz g==;
X-CSE-ConnectionGUID: kZnEyNdzT6igX444eLOsRw==
X-CSE-MsgGUID: Jr9wsJOVSMWaE1dxc34NmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="63320692"
X-IronPort-AV: E=Sophos;i="6.13,224,1732608000"; d="scan'208";a="63320692"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2025 21:37:04 -0800
X-CSE-ConnectionGUID: erg0E6b9Q3eDcQpsHlNx6g==
X-CSE-MsgGUID: XhFIUXtpTxqWsO4hzjfVBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,224,1732608000"; d="scan'208";a="107562322"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 Jan 2025 21:37:04 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 21 Jan 2025 21:37:03 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 21 Jan 2025 21:37:03 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 21 Jan 2025 21:37:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JD5YwfnVWimrvSa4EQtziivWEGb2LUfitCffLGMp5Av9QA8QeNhYOiWj9tbatirUUmIdIGmjFIXBdXFiS5oIw8TSTf5t+8SwkT4iMn7KCIEmIIkMePTd6m/SWJnWT0kWlSs/QCy/ST2GZRiKmCat+Aw6bNlxjp5B3QgAOmeHESZpgn2rPb3MAZsU3cmowAj8LFxy4P8vlcvgTunsYYd5FCaYMblvzmW4xVvqQss0F1woRp0NsGHjNpSR4KYVr2KGRLNZdHCFpn+GXqGAhZQ5OCxwpSFlU1VTYEb8RkXH6mUe85VUsmG+GiC90jt96EgzT8F3dqxIln0SOVSLgS+ndw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8+9xD0JuTXG4W4WTTuf+HPZiGsw2Jytj26ojk8VbBM=;
 b=nDFtNsCuEjEXVmMFd98+fMWNkIfLlSxPtNhy02egqVJ/wVJ1S+A4t8gS5L4IVx+Yvf7b0ODXCbAYYBfaYyKWQ/wB2kyxcZSg+GF6Z6giRyUi/E1GlToWb8V1bMO6OicTc/RncfqlajZZo2fgnW57KI+Gwn/PyA5s2UsbyZD6Mn336bDnu5njqWbcjrwvniMVc2UCC7sVzoa7Cg4afMjOxTGxp7HPWXO2bKBbl/bKE2aPPtRF7EEUGMhgqmto0K406UUXxO9MLhCe1EPN9K1I/bA9iH82vN8WdXugWdrMGNQ6A7HOxdwjfL+56WtPcnDaxcA9bMic98Tf+rEOqVqr5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 SA2PR11MB4890.namprd11.prod.outlook.com (2603:10b6:806:117::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Wed, 22 Jan
 2025 05:36:20 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe%4]) with mapi id 15.20.8356.014; Wed, 22 Jan 2025
 05:36:20 +0000
From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
To: "Ng, Boon Khai" <boon.khai.ng@intel.com>, Uboot Open List
 <u-boot@lists.denx.de>
CC: "Hea, Kok Kiang" <kok.kiang.hea@intel.com>, "Maniyam, Dinesh"
 <dinesh.maniyam@intel.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@intel.com>, "Zamri, Muhammad Hazim Izzat"
 <muhammad.hazim.izzat.zamri@intel.com>, Tien Fong Chee
 <tien.fong.chee@altera.com>, Kok Kiang Hea <kok.kiang.hea@altera.com>, Dinesh
 Maniyam <dinesh.maniyam@altera.com>, Alif Zakuan
 <alif.zakuan.yuslaimi@altera.com>, Boon Khai Ng <boon.khai.ng@altera.com>,
 Muhammad Hazim <muhammad.hazim.izzat.zamri@altera.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Subject: RE: [config 2 support v1 1/1] net: dwc_eth_xgmac_socfpga: Add support
 for distinct mac-mode and phy mode.
Thread-Topic: [config 2 support v1 1/1] net: dwc_eth_xgmac_socfpga: Add
 support for distinct mac-mode and phy mode.
Thread-Index: AQHbaKcMsjfTBUKvS0mQU/VKNYByNbMiS9EQ
Date: Wed, 22 Jan 2025 05:36:20 +0000
Message-ID: <DM8PR11MB5592D0801F3E703CF128F2F9D2E12@DM8PR11MB5592.namprd11.prod.outlook.com>
References: <20250117061402.31985-1-boon.khai.ng@intel.com>
 <20250117061402.31985-2-boon.khai.ng@intel.com>
In-Reply-To: <20250117061402.31985-2-boon.khai.ng@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|SA2PR11MB4890:EE_
x-ms-office365-filtering-correlation-id: 11656057-2c8e-40a7-b241-08dd3aa6b343
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?DXwJZuWViiB8MxjoC8uOghBGpG7AEL+892Snqcl7d2nfmJEbI86hHPhLzwH+?=
 =?us-ascii?Q?2HutFenxptbu3WqYEADJeaKhvjPUt0N0XDs+mJdrV6ghrtQx8f4wpnzznMhg?=
 =?us-ascii?Q?heiE6T9zMh7K3cImNmh0X8WlBmw3ZE2a2QsNf1hjGqN7JmZCll0n30g8dsyv?=
 =?us-ascii?Q?rcvanxkCwZ+uGvHrYagRDMDjlvOsM/W5OJwTmoYahYWTmogqAt34puiDk/fC?=
 =?us-ascii?Q?+aNnN31ZuZv92oLakt5f6p+jjOf7PrhWwtqy5ZXW9CwwBZPK8+u8bVwN7eec?=
 =?us-ascii?Q?sde+LFpQxseonjjhfmaOsODmlIS8IUOj888MbNMP/CHSRAfGkWurQaW7/u31?=
 =?us-ascii?Q?lDDcos5/2Mmb/B/4lUVId2ZGpg8beJZng7CV7K9thDuHvKcZR0rE4BTMKiJn?=
 =?us-ascii?Q?3ASqWhbWnYByuXKsx1ZoUvYvBV5Cgsr0KATVSz6NS3mgg69h8UyaogxtD3oq?=
 =?us-ascii?Q?n54wRrOC/JWrYSVX+cimPMs47v2F+DIl9O4s7zPNUFtsHKkXiaogqJEUhxrl?=
 =?us-ascii?Q?fiVi8enXYTSdvwi32t9ZFTyw//nK+vNu22+ryHemfEkYDK5Q+al478IBdL54?=
 =?us-ascii?Q?Rr17arqkbH3/VL91dP28mMPNE//bMFBysW2xZrJyob+Qg39/ZwX0LbJKM4G7?=
 =?us-ascii?Q?nX2vx+DFPbdBOvKmV93egLgDuHmCsJHd1YT0/tZEjxLHvR/2nCIZMNCNy/pp?=
 =?us-ascii?Q?hYXNgeMn3bCf6lOQuOckHyFGevj/GEup2wWDlfNquuInOXCW0UVXAlhWMlQa?=
 =?us-ascii?Q?NQj3iVNGipxqydg1JzmqkWCrTIWM07c6zz95OpSaSc6MMxIzPg8ttMciqQYD?=
 =?us-ascii?Q?ZywzR+ZRg6rtKvCZrbUXlTs0k1pjp+eHdQH/5EhIav0GmgsWarz0EwUZEVMP?=
 =?us-ascii?Q?3crDhVUC4u4NkfIRMHG/5NWieaiNaz9mvu1DsKYp/Jq0fWW2MGzHsiSRBvHl?=
 =?us-ascii?Q?S0CAJrDLV9Yxn/AIoaTVwumud8ZaHOeF6pDVd21HC548J7wyr+pBOR8p9GNh?=
 =?us-ascii?Q?NZTJ/eYT99AQsgiQTxMs/TYu7/lu/H64hIWcZmK310j5r40/X+ZbmOmbgT1g?=
 =?us-ascii?Q?4Hao9+3349dz1I34rnH0pa3hV+Y/qVmNqqaq2Q3EBfexwVvd9ucB3Ch5Q+eX?=
 =?us-ascii?Q?KCfK8RKdoII9Yg3YJCwCTCEURVkP0om7qQVStay6XRY6H2IfoVc57/m2UU+O?=
 =?us-ascii?Q?Zmthyau2ZWFSaxlNIC6EoMHvOcEA6TuDCYzVHhn+CwAa5RtbjNIbVt2LiwUN?=
 =?us-ascii?Q?gy6LtPyrgQTDtqQiTdRbomTySasYzaGiLzSbXHakQncUcMpQoR8WBZFUiUFx?=
 =?us-ascii?Q?kAmXlE270vP78TKm6OOTaXgOww9YETFWaJz+NXVWND30CB13Jb1+R8o3dG/J?=
 =?us-ascii?Q?jj2edJ40Jlty8Py/1ehNKQDUPpmZOaHUbhkxYOz8xIdT5nO41B2HDIEjJMSl?=
 =?us-ascii?Q?wOXgxiJaeYCjChDplz9nOLU9//OeS4n4?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5592.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DIDdka1hmzbnrFsDzlGji1GJ778fmenSAGT083Kyzcj9g9Xr/7HIXsLo2PYf?=
 =?us-ascii?Q?9jwZ6glhGQeTlOzZ83E3mzxxnVB573VgRVfc48+v3BlkiQIsZKN1X0Ut861o?=
 =?us-ascii?Q?IRNscxFfswqxGbNhseHlqV6e7giZ7cczIHqw7UhKR5CWQ+K5WL8Guoo+RAMa?=
 =?us-ascii?Q?rDVQWJdBOwfBt6y9ZJl1QqG4iYS8HwFNT9lsD543twEyURScM7HCxlAGQLSM?=
 =?us-ascii?Q?uS2yNkIgTtqpkf/T2s076LrpixtRRqRmOxOUp9ym3Wj+O7WIL5kfuOm6U1Rc?=
 =?us-ascii?Q?eNd6bYO3wKBcgNkA/ZAMUdr3c2LYJMlPm2tLZCT/Z7zEE7isM+dR5/32aTcn?=
 =?us-ascii?Q?jdpbWICc2b7yCZ+xLMMSja9z80Kr2RU2KMheYSbCeKTsxf9RoG1Z3N9BdzVD?=
 =?us-ascii?Q?J829NqXRl5z6FKB2GFvENwG9lq7cw9qNgbB7c1/KyIddxZx1H4fVNPxVJ+cA?=
 =?us-ascii?Q?5C3MpvS0j7kIvNUrhePtyUGl0/yGEiADW6PCUX954bzPFCweT7wG+gGPeL8H?=
 =?us-ascii?Q?G8FoVPPnqqtc7ShRtnPK6eZhMMl7YXn/onPL2K3Ip798CjvalluQavWtwQmb?=
 =?us-ascii?Q?7CoKcj35+Ez+HzA4C4rqrS8mm53Hv8kSeFpZAweoIrFyt33V4kJ+zRw4OBQw?=
 =?us-ascii?Q?Hz8kU8eyoGGSwAaeoAgE7QEZ0jjdZqdXjfXbtq3zTYpP92oa1ghMVWG2WFwg?=
 =?us-ascii?Q?wWApooMdIsvcenWQ7CPGGsiL6kpkTftgdjgXtCPTlroATcw3hHTa3O+UH0up?=
 =?us-ascii?Q?jmpDSIGqKgPS76SRAY7Nl63HBNy4UZthF2O/lcf9cC5ofTaCC4I+1QK3lO6t?=
 =?us-ascii?Q?KrKigjdX5VENsvn+Y3Tk0A3O95HIohy2whN3DANUdPDU/C9LmBj9LNoy0yCx?=
 =?us-ascii?Q?quA9UJjnDD+eMQ0dF+KSjPWVrXsC0PK49awBV3xRcI2tVlFXDXzNdjfZU+bx?=
 =?us-ascii?Q?IIiCyX4YLjl4qtgqZIRC4deF/V2pLyElU7BPaH5jWalrf3V1VMuiz8V7oX5C?=
 =?us-ascii?Q?TyhbO/ClHRvLSOAp+tgbcUpIXXIjkKE6bkeBoXmkub/M80RFxjsMV/UjKmDv?=
 =?us-ascii?Q?kfYN1C0O4LhKBHfVo5cLyAlDy7ueT121QIwv+3QxhDUNbaaNfmY/XQaKgW1R?=
 =?us-ascii?Q?usYOo1rDmXfOpL9/fo4FHtnaMshbMKKgswnx6XKYjqIThDI+BDShkfcreSXU?=
 =?us-ascii?Q?YaX/zc8V4YRqAn3F1iI3oE/9brk8aeYFivDjfzDU0ox5iPYWR+xhpNdWN4un?=
 =?us-ascii?Q?jhM/p5v1b0i0/KDMfuMIc9t3cWG1IBAaOqYJc6Aqj0jEbzGyxWNP+N0gzNq5?=
 =?us-ascii?Q?JIedT8QQE9Nny6uvQrkbSRvdeu2BDm5t84nQBN85fwWlWbtTkyLsi7sQJdxa?=
 =?us-ascii?Q?c6D6Xe8PoqUWJplHZOuOp6b7CCGdnMDKk2QYRi24cdLg3H1E3tNJTSL85Yz9?=
 =?us-ascii?Q?iFWTd6zEPX7C/q50kmrtpCZjTo28QpXVyqkLrzQ57H+SPL9Xgb8A5IHJbx6P?=
 =?us-ascii?Q?mnH3SOlg9/6hFyZnDUKZVLL4xrBF5KZ8jnDnna5CvZwFv7CcZkqNB6xfksBT?=
 =?us-ascii?Q?SwHBqfDwcVdrfmgOyKvDCcKIPsB/cf2Tv/T+Xcc1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11656057-2c8e-40a7-b241-08dd3aa6b343
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2025 05:36:20.2682 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EBrGF8t76PICnNnKHKrDmSm4XG1DolTzQk4S9e8hF6AXG8oHX1kIAv6HiocqboAWg/n1oeItv9HFPeheFbsOsXOhPcZURs5dRb5tKQgGcVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4890
X-OriginatorOrg: intel.com
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



> -----Original Message-----
> From: Ng, Boon Khai <boon.khai.ng@intel.com>
> Sent: Friday, January 17, 2025 2:14 PM
> To: Uboot Open List <u-boot@lists.denx.de>
> Cc: Chee, Tien Fong <tien.fong.chee@intel.com>; Hea, Kok Kiang
> <kok.kiang.hea@intel.com>; Maniyam, Dinesh
> <dinesh.maniyam@intel.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@intel.com>; Zamri, Muhammad Hazim Izzat
> <muhammad.hazim.izzat.zamri@intel.com>; Tien Fong Chee
> <tien.fong.chee@altera.com>; Kok Kiang Hea <kok.kiang.hea@altera.com>;
> Dinesh Maniyam <dinesh.maniyam@altera.com>; Alif Zakuan
> <alif.zakuan.yuslaimi@altera.com>; Boon Khai Ng
> <boon.khai.ng@altera.com>; Muhammad Hazim
> <muhammad.hazim.izzat.zamri@altera.com>; Joe Hershberger
> <joe.hershberger@ni.com>; Ramon Fried <rfried.dev@gmail.com>; Tom Rini
> <trini@konsulko.com>; Simon Glass <sjg@chromium.org>; Ng, Boon Khai
> <boon.khai.ng@intel.com>
> Subject: [config 2 support v1 1/1] net: dwc_eth_xgmac_socfpga: Add
> support for distinct mac-mode and phy mode.
>=20
> This patch adds support for configuring the ethernet MAC mode
> independently from the PHY mode on our SoC FPGA board. Specifically, this
> is necessary for a scenario where the ethernet controller MAC is connecte=
d
> to the FPGA HVIO with a different GMII interface, and the FPGA output is
> routed to the PHY using a RGMII interface.
>=20
> To support this configuration, a mechanism is introduced to handle separa=
te
> MAC mode settings, ensuring that the MAC controller and PHY can operate
> correctly with their respective interface modes.
>=20
> If mac-mode is not defined, the MAC mode will default to the PHY mode,
> ensuring compatibility and proper operation between the MAC and PHY.
>=20
> Signed-off-by: Boon Khai Ng <boon.khai.ng@intel.com>
> ---
>  drivers/net/dwc_eth_xgmac_socfpga.c | 26
> +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/dwc_eth_xgmac_socfpga.c
> b/drivers/net/dwc_eth_xgmac_socfpga.c
> index 87fb7e887e..07315f289d 100644
> --- a/drivers/net/dwc_eth_xgmac_socfpga.c
> +++ b/drivers/net/dwc_eth_xgmac_socfpga.c
> @@ -29,6 +29,25 @@
>=20
>  #define SOCFPGA_XGMAC_SYSCON_ARG_COUNT 2
>=20
> +phy_interface_t dwxgmac_of_get_mac_mode(struct udevice *dev) {
> +	const char *mac_mode;
> +	int i;
> +
> +	debug("%s(dev=3D%p):\n", __func__, dev);
> +	mac_mode =3D dev_read_string(dev, "mac-mode");
> +	if (!mac_mode)
> +		return PHY_INTERFACE_MODE_NA;
> +
> +	if (mac_mode) {
> +		for (i =3D 0; i < PHY_INTERFACE_MODE_MAX; i++) {
> +			if (!strcmp(mac_mode, phy_interface_strings[i]))
> +				return i;
> +		}
> +	}
> +	return PHY_INTERFACE_MODE_NA;
> +}
> +
>  static int dwxgmac_socfpga_do_setphy(struct udevice *dev, u32 modereg)
> {
>  	struct xgmac_priv *xgmac =3D dev_get_priv(dev); @@ -66,12 +85,17
> @@ static int xgmac_probe_resources_socfpga(struct udevice *dev)
>  	struct ofnode_phandle_args args;
>  	void *range;
>  	phy_interface_t interface;
> +	phy_interface_t mac_mode;
>  	int ret;
>  	u32 modereg;
>=20
>  	interface =3D xgmac->config->interface(dev);
> +	mac_mode =3D dwxgmac_of_get_mac_mode(dev);
> +
> +	if (mac_mode =3D=3D PHY_INTERFACE_MODE_NA)
> +		mac_mode =3D interface;
>=20
> -	switch (interface) {
> +	switch (mac_mode) {
>  	case PHY_INTERFACE_MODE_MII:
>  	case PHY_INTERFACE_MODE_GMII:
>  		modereg =3D
> SYSMGR_EMACGRP_CTRL_PHYSEL_ENUM_GMII_MII;
> --
> 2.26.2

Reviewed-by: Tien Fong Chee <tien.fong.chee@intel.com>

Best regards,
Tien Fong

