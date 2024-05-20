Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 672BCC04FFE
	for <u-boot@archiver.kernel.org>; Mon, 20 May 2024 13:33:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B4DA88229;
	Mon, 20 May 2024 15:33:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="bUZ4o3Fd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50A0688124; Mon, 20 May 2024 10:36:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DC7488685
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 10:36:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tingting.meng@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716194213; x=1747730213;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5ZlLvSAHi3cHV5IE79K3YafeBNPKHD/5AhCH8fPsX5I=;
 b=bUZ4o3FdjAvHQ8maFdVCoq/lxngN4y50nv5yq4TmlXUmXfq30keKxB4D
 ViRMG2zODkCvXhMw3aamPQTgCJM4aH+zz9I2akoAUrm9+aw31h/gtAl/7
 KOev8li69tmPd5ZsRpdJ0nU2SRIwKFE8MNrVatS7szSNff5vq84lkzaYN
 OlWDeN0M8SNjD3tPRDH9fncLtjJ4mCALC4PzdP52xbYEvwRHl43dfUBcp
 FN0mIFf7K7662H93NBUEREYPChukk3CQvCSoh8eUqBPKNzohBqzVgKxL7
 eivUWPCbTnsX0VD1J+6RKW0TnMiS+OVBiLupIs2tbqEdUBg6sIgCMRfyo A==;
X-CSE-ConnectionGUID: 30G/NPX+SvWkpKOvkk3H3w==
X-CSE-MsgGUID: HD5yaLePSSmUephA3YRTSg==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="12480321"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; d="scan'208";a="12480321"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2024 01:36:51 -0700
X-CSE-ConnectionGUID: 0gbAztpLRRONpUsbmUhRMg==
X-CSE-MsgGUID: bOs4PNVnTSa9AtR/6r4X6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; d="scan'208";a="55696135"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 May 2024 01:36:50 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 20 May 2024 01:36:46 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 20 May 2024 01:36:46 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 20 May 2024 01:36:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HPrBHLEvWd1UyO++5WJqM+FDl6Wy+zf3VmC05aEyMbZPX7XsDvYD738LPQlVnnqMvaki2rnGVJx7TpKeudLwacnPb2OKYhPn9HjhWB9JfrAoxxS1cz+Kspp0bTQmfGSWyAe9KvM3DoyysLHhsKdR8uA4WzqOJN6qInuCb3QqljgPYqcZ+mmm0hiPhcXVrkxhE9Jslu8C7AloX0BUN4GaKBUuAidNHWg7nEiBZ/vziL65ojtvmORlDWRUT6ejVw/FRCN/wzF7Zi9GbdBPlLonMaQ8837huEC+iKctAHaPap+AhIl81fl7lhEGJSkSkthSNwhWx4cCGcDZcCge8pIziQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Z2MNXlyEJ2wCv5k6MFpdv03yU7tiAGzjqE1Oa3gmyw=;
 b=IdaRNlB23zTWKjpafiFtsBOdUwtyxF8iurRlJRO+hvWxG5aVVRZ6ZNOwHlhONwMIEJobvbF4i7SayKkNrdm0/3ESdcueTRGpDg/8H97f9uRnM07Ze2CCqxoclY8q0CE8K0R382cBG4DjxkbeDbKYTVHcfSvAPEICIOZY8efHl1jOGFPF7UHgfdyM4yUi8ZMXG2rd2WN7iTNq0VYYX0FkERygNlUqWcGiSPaNmEnKghb5ObSi/Dfzf5UGXdRpB3U9fwPFqIXuJqSZiHjowQ39OJ0d3bnI6Ub3fbjJbXA/MlzzOdFyRvE7U5AjSA06jBsJfT3jxbSYitrLbHkEFZQ2vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB4877.namprd11.prod.outlook.com (2603:10b6:a03:2d9::19)
 by DS7PR11MB7931.namprd11.prod.outlook.com (2603:10b6:8:e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 08:36:43 +0000
Received: from SJ0PR11MB4877.namprd11.prod.outlook.com
 ([fe80::c314:4647:3665:a5ab]) by SJ0PR11MB4877.namprd11.prod.outlook.com
 ([fe80::c314:4647:3665:a5ab%6]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 08:36:43 +0000
From: "Meng, Tingting" <tingting.meng@intel.com>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Rayagonda Kokatanur
 <rayagonda.kokatanur@broadcom.com>, Marek <marex@denx.de>, Simon
 <simon.k.r.goldschmidt@gmail.com>, "Chee, Tien Fong"
 <tien.fong.chee@intel.com>, "Hea, Kok Kiang" <kok.kiang.hea@intel.com>,
 "Maniyam, Dinesh" <dinesh.maniyam@intel.com>, "Ng, Boon Khai"
 <boon.khai.ng@intel.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@intel.com>, "Chong, Teik Heng"
 <teik.heng.chong@intel.com>, "Zamri, Muhammad Hazim Izzat"
 <muhammad.hazim.izzat.zamri@intel.com>, "Lim, Jit Loon"
 <jit.loon.lim@intel.com>, "Tang, Sieu Mun" <sieu.mun.tang@intel.com>, "Lau,
 Wan Yee" <wan.yee.lau@intel.com>
Subject: RE: [Agilex7 M-series Platform Enablement v1 01/16] arch: arm: dts:
 Add dts and dtsi for new platform Agilex7 M-series
Thread-Topic: [Agilex7 M-series Platform Enablement v1 01/16] arch: arm: dts:
 Add dts and dtsi for new platform Agilex7 M-series
Thread-Index: AQHaqBrwg+do0RV3HEOBfm1T7yfAebGbh80AgAREpHA=
Date: Mon, 20 May 2024 08:36:42 +0000
Message-ID: <SJ0PR11MB4877A04FB053793133F5BF6AE0E92@SJ0PR11MB4877.namprd11.prod.outlook.com>
References: <20240517052701.12949-1-tingting.meng@intel.com>
 <20240517052701.12949-2-tingting.meng@intel.com>
 <20240517150800.GI2568172@bill-the-cat>
In-Reply-To: <20240517150800.GI2568172@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB4877:EE_|DS7PR11MB7931:EE_
x-ms-office365-filtering-correlation-id: 45480f57-5f68-487c-c483-08dc78a7fa0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?uaUnCaO9BZ9lXfRnCsmpSpG1vYPXJSN3XdbOvMcBvRYnFlfcqL/c+4MgAjbi?=
 =?us-ascii?Q?IbkHeJ/6hnnFEYpNBnFo5Dwemm5WTC/pzTevudyziYPVT6BlVZ/JqGuL72C5?=
 =?us-ascii?Q?7XP9XhoZKYlAR9ClIfXYhT34AuCHWFhqZz6Jglre+wN86f6OAYEh9U3OynVa?=
 =?us-ascii?Q?OHH0LSbI2T+5iX1a8FH+PrexUuv7TwWu3E1AQjbDln1wFhNMfUq1Utc1wh/u?=
 =?us-ascii?Q?6DYdNGI2nFYkJKuj/YpkNtFLKhdqHmiLicsBJL/m7UeOP9NeLrh1uFYLmpSA?=
 =?us-ascii?Q?RMezm2zFY93LL35Z9r1onTXeNprA62UGDKzkV0dzGiJrBKYk3dFig1O5mYbz?=
 =?us-ascii?Q?E/TWMHrgHcqu55vHZzPjsMov8srrEkFpaHhMRv5UJaNw8ayNhlzYM6Czdx3Y?=
 =?us-ascii?Q?DlLCiLUQDIfb8qNRlxlq0MoYZn3/K/ReXF71zWVczOIMMAXSP0ng/1htJNy0?=
 =?us-ascii?Q?i9snRPRVW/YLH+H7TpgmsbEDwU4Dkgm3IsitGYmWuhyIDcW6S8d/S2DYT1IM?=
 =?us-ascii?Q?l5xuvrbZVct8LAf4TC09Cnk/9O208CREJhusaq7VowP7ihOs6tiGjvvbYTiv?=
 =?us-ascii?Q?P6VfjomRlXoppNnlhp2V84qfdkivy5NWfAzJ9652CUfP3pWELQYXKVZxK9P/?=
 =?us-ascii?Q?02vARWPkMI33BBlPiy8mtAd4yAgJd4RislHRr++0Z36OTo8kHqX8Gm9ashAB?=
 =?us-ascii?Q?JJdJUgov5m63ymTaAEA16buoXohFNp/FP/QJfvU3AVACtnHxQf3HoF8MFBMX?=
 =?us-ascii?Q?aP4AUW/hRUJ/2z3bD12Lko/Cz+PnadldoY/8NzedrxzLGAmGLzXEmwdF3XFh?=
 =?us-ascii?Q?oyXxtyUZdiTYFblEW4dFNCTAxzXxOuBQBWUJhEiU43H6uvufgKIlja3X85QT?=
 =?us-ascii?Q?pTw6YBHfbR6NHKd/1Cb26w8DT5hp40ij2aSKoLqopy4JeFCancsxjoJ5SOgF?=
 =?us-ascii?Q?zzs85YhGKwb+2+6CmvER8OgGXVoYw4eXdZxcgauzJBvF8bHhPo2lfVvLzTw1?=
 =?us-ascii?Q?He7MHFZr62lrCxC/edwKDFqmQI4rn0iqndmaIdtdJE6xV3rECUmS6koDEGzR?=
 =?us-ascii?Q?VgYRYaRXIdAniCn+0TpQnt43+gn9tAMFhYvhg7U5AHJH6VwaKEJqYkf2uUaC?=
 =?us-ascii?Q?vltz3U3BmXigwwf8HintbapPzYHENmDbwCwO9N422pWM10Ng0+Zvfi7xa0s1?=
 =?us-ascii?Q?Q5uAvKsx7zwKF9ygzrqUkRsjCC9V+D4Tvmy7M+cTzBFTeqDDsEsNcb8d0M0I?=
 =?us-ascii?Q?3JYNX63Nmby82TrKzR+CZ5OCpRlRebaS9w5AA3D2iEsM26Ep8CcL4zA9NT+9?=
 =?us-ascii?Q?XpEUNqtdN0tYNr9/hJW1O6ltBYI1T4dNbnAsPk9SULd5CA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB4877.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UKkYV+0P7JR0iweFmRrG7o9WIt91aRTg/x1fxo6H2rgJUoc9jKvxeqonx/09?=
 =?us-ascii?Q?zBgsDX3ckTC8JvsDnyqoq9wFd4On82F4dsdOcuQvYK8r+nOuhY7slitIUHHn?=
 =?us-ascii?Q?mp+IYz0dYmvxQRMmcFu/ifOVG4zwPvCMGwtMwinBAYqdTKaR8H3pQH0Lah3x?=
 =?us-ascii?Q?WuzxxndPIyXuK1n1hwhIdiRhoSfd2KhOxDj1ztsWe0Tppa699FEbvVyVtJRk?=
 =?us-ascii?Q?uK8edzJB69w4SRuaps6X+QCNyzgCyJW+DTCAdr4M+5K8zz4u4MrK1m6NzCE4?=
 =?us-ascii?Q?HbLfBHDBSFmpuzvCl48tDah4qBWPyqRx0xAmqSTHotSJGEC2EkgjpeqPuHIm?=
 =?us-ascii?Q?4WCTTphcG2qMjwDKpBjJ+uSTeyOMBaqOfcroC/Jzhd8Iytcixzd12C3fP+O3?=
 =?us-ascii?Q?02G7ivlCDViMSXjbWvugNMCRoEVnKH8701bhLyhCpZs5WtvOBGzZs8EATZui?=
 =?us-ascii?Q?NsccODsJk1zzbKFe6KLFm4X/fGDWmEgbGbtkqPtYAhyviF9vPdjWSo13fuiA?=
 =?us-ascii?Q?6BfPOvPbOHJn1l7xQitw5Il7hGWIw57z6Y/i7123GOt2AXFyIVMLNpYl8Eno?=
 =?us-ascii?Q?/l2aLoOLelIbrQfHZN1Dhu4JlzCviCmzm6Rre13+gdPIRDwx5+N9c4xQZJ29?=
 =?us-ascii?Q?EIAwKqVLD0E0AHCInE02ZnU3sO9wx0OB6OebIvZ6KDFcXn4D2smV9ZH8Tqxz?=
 =?us-ascii?Q?W4y7DXW0y7RId0tIQz9No2RyjZr6yBydfFP/2KvMXfNMNv8mZfei1sDMJGoZ?=
 =?us-ascii?Q?jtZW1x1yvL5s2SGNEbbb5ePPtSwyLz8rhsP8pn6qJ9RYdthSYrgkD4G2qPwu?=
 =?us-ascii?Q?fPW4lCA7lvA8QuuysG20yP8CMaTDseUFWn62ysFHoBJsq82IlVf2iQuG/mVW?=
 =?us-ascii?Q?748tpNY4dPY1kcZkwwTyz28x9FfyYZcmd9EKUwtyv9FA+fcbk4PbvQTF3kS4?=
 =?us-ascii?Q?QMSxLgPgxhqYs01NYnYeYJTwwmWp+RV+9R87P8PDVhwTqvocTv5Cs+Dl+XyU?=
 =?us-ascii?Q?RkKfd6srN9efXe49oxpbHX3Aym0/0WfKVbjJvnJJ/GE3qDSzW/LVShmdrBB7?=
 =?us-ascii?Q?LF95Y9Ecj1Wkk9BvdWwmbkQIkccYC3b+AAXSoOiZqOhg2seCe+oaT6C1Smdw?=
 =?us-ascii?Q?wJn9Gf/xfmAYZoEB5L1OjBn6S0P3AVGoN+3dxacBj1YF+WO/G+uWDA/7iniG?=
 =?us-ascii?Q?QpX0NMROyDaN2lIcg4uBEJWtFNKZvJWcqxL6sepWyUEwrkMcoUpnVaBnpwEb?=
 =?us-ascii?Q?5kPXIVzCoAXWPojCZ4FS8PUFc4EknZ26ZXHF78jQkPQRl41lIk8FQ+3ApZfs?=
 =?us-ascii?Q?ectE+XNIJSD0Z4DitmfF5UvPd9IIY9T5AgrGmvPR7akm5wh2VU5++69rqiNL?=
 =?us-ascii?Q?r6OrKGXDl/n9BCNqAQ9C9EYCIdJc0ZuAR282wJeOqkSrEjqNZkRK3TOf2/cG?=
 =?us-ascii?Q?/voqOoO3gLc2ohuIV5NzfeNUfKNQXdSd6NBmA+39KuKdF7rdw9VDKyPvd+VD?=
 =?us-ascii?Q?QQH0pd+9accNHknWwRj8qArLXKfVCjaubpVU9BBfg2bncNBar1mnAgvLE+uI?=
 =?us-ascii?Q?5E2bVb99Nnv2yfMKDRt+wh4x0pCFVuIiC+VCZyIn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4877.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45480f57-5f68-487c-c483-08dc78a7fa0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2024 08:36:42.9546 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jaN5xfWdUtu9bOxU7ZomsEcIOMV1WLOe7lp78TZ12k4Lc7niWkxnuxPcK3FpZXxQt5voJUeckL6QeEwrijilZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7931
X-OriginatorOrg: intel.com
X-Mailman-Approved-At: Mon, 20 May 2024 15:33:14 +0200
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
> From: Tom Rini <trini@konsulko.com>
> Sent: Friday, May 17, 2024 11:08 PM
> To: Meng, Tingting <tingting.meng@intel.com>
> Cc: u-boot@lists.denx.de; Lukasz Majewski <lukma@denx.de>; Sean
> Anderson <seanga2@gmail.com>; Rayagonda Kokatanur
> <rayagonda.kokatanur@broadcom.com>; Marek <marex@denx.de>; Simon
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@intel.com>; Hea, Kok Kiang <kok.kiang.hea@intel.com>;
> Maniyam, Dinesh <dinesh.maniyam@intel.com>; Ng, Boon Khai
> <boon.khai.ng@intel.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@intel.com>; Chong, Teik Heng
> <teik.heng.chong@intel.com>; Zamri, Muhammad Hazim Izzat
> <muhammad.hazim.izzat.zamri@intel.com>; Lim, Jit Loon
> <jit.loon.lim@intel.com>; Tang, Sieu Mun <sieu.mun.tang@intel.com>; Lau,
> Wan Yee <wan.yee.lau@intel.com>
> Subject: Re: [Agilex7 M-series Platform Enablement v1 01/16] arch: arm: d=
ts:
> Add dts and dtsi for new platform Agilex7 M-series
>=20
> On Fri, May 17, 2024 at 01:26:46PM +0800, tingting.meng@intel.com wrote:
>=20
> > From: Wan Yee Lau <wan.yee.lau@intel.com>
> >
> > Add Agilex7 M-series dtsi and dts for new platform Agilex7 M-series.
> >
> > Signed-off-by: Wan Yee Lau <wan.yee.lau@intel.com>
> > Signed-off-by: Teik Heng Chong <teik.heng.chong@intel.com>
> > Signed-off-by: Tingting Meng <tingting.meng@intel.com>
> > ---
> >  ...tsi =3D> socfpga_agilex7m_socdk-u-boot.dtsi} |  37 ++++-
> > ...x_socdk.dts =3D> socfpga_agilex7m_socdk.dts} |  66 +++++++--
> >  arch/arm/dts/socfpga_soc64_u-boot.dtsi        | 127 ++++++++++++++++++
> >  3 files changed, 213 insertions(+), 17 deletions(-)  copy
> > arch/arm/dts/{socfpga_agilex_socdk-u-boot.dtsi =3D>
> > socfpga_agilex7m_socdk-u-boot.dtsi} (50%)  copy
> > arch/arm/dts/{socfpga_agilex_socdk.dts =3D> socfpga_agilex7m_socdk.dts}
> > (63%)  create mode 100644 arch/arm/dts/socfpga_soc64_u-boot.dtsi
>=20
> Why can't we use OF_UPSTREAM on these platforms?
>=20
> --
> Tom
ok, Tom, will convert to OF_UPSTREAM





