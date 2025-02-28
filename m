Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942A1C19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 04:02:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A593807D7;
	Fri, 28 Feb 2025 05:02:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="BYkvE4mW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8F5D8083E; Fri, 28 Feb 2025 05:02:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 199EC801FB
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 05:02:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740715321; x=1772251321;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=EY+SXMWHUyro2+qXzgXTYRnG7+f85C+sjG/MyYJ4cEM=;
 b=BYkvE4mWE3NvLBrbB32hrCh3P5mJoCoUXIJqOUUKJrFVo+wWmO4r6cuY
 V0ImYmpox5PAgdddrexu7r0H+LnreKmPy1VnhbZkM/52DzMiLGY3oVTlN
 WturH6ogNnLtQvKJuMXGZVmMKl7PekhoNCWJLy3sZerS46NxxLg6uitF5
 fn8UkHVnMfeSbR21jR5Whlv2byLy1zgrPBNaItUwXY1Qq+al5hOlWMOIP
 YrDp6C9DzwJL5hd8c9+NFDOIyHqOO0olSxVASUX7M+btIbQVbGVPhfl4I
 W7ML0hS0wyfC5SuhUeQVW4+PaeGjmtE3NeaXe8s4mir2lD0ZHcCiYNoVU Q==;
X-CSE-ConnectionGUID: N0eVT3DWTAmW8OIZEfKDbA==
X-CSE-MsgGUID: mz1V45TQRdeFCqC/4vdLDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="59046768"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; d="scan'208";a="59046768"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2025 20:01:59 -0800
X-CSE-ConnectionGUID: uCcBTLOXTFy/p4cXSN14pQ==
X-CSE-MsgGUID: hW+oEdvIRO63C520bQ+c1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="121349700"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 27 Feb 2025 20:01:58 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 27 Feb 2025 20:01:57 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Feb 2025 20:01:57 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Feb 2025 20:01:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hK4lHIzAn+dqPV98Hem75ap8ZVvkebKMiDudRZbqMtRqc4WjA2NptRvAEm1B/AGfbEZS8lUhSAnd1AWdOYvUnuRMSr9I+pBtZQkGhVLOaoU6xgXU6+wgnmsfcbZD82pIwi4aIegrWCBSyl4igWtW5xYX8kqISacmNRiQccNWzw/uo6AhmF4oANWUF8/iKRRNXkGW7eq+c6sRSiNyVjna+Xd4lMTARkDB9JzGiGfwjcZDBmm0kNerqI/F6sntOWQrKEPq51b1dMy4UtrkGyeS1EpP4nvJSiH/I9vgohG5wk7wTDIKZyejug4DrHXkqAkNT9VX7dlSwCSsQrHXVShIYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EY+SXMWHUyro2+qXzgXTYRnG7+f85C+sjG/MyYJ4cEM=;
 b=w8CvMJjylkky90imBHLmD7jNsJPM2+7Sz6PKeRUGpJWc4BXoEC6ORQDhEZ3kNQHGZYkRntfqZk3WnrDti2d2GIgL9jdFcDYbXq8w2r2YFFmmMBUv6GTPjxqinB2nxCenLg0dpaHmgf4emyKBt3Ald+MIR+kmMhAH7Pj7Fs7iEePZynpMEQKhgDbX+1w06sjxBo4BvlP5+fKRLW+eM0pSnLPBZSO/zGS93AshO044VPW/Q+j5Db8cnF/DyaCUw/HJefGnyDjVFxVaWFVdbktRRjL9kUYIm0oFBZKvS1JoreLddYTBwKDiutG8XjmxXqhyhkS12FwjixBX8AVaFBvNSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5373.namprd11.prod.outlook.com (2603:10b6:5:394::7) by
 SJ0PR11MB6575.namprd11.prod.outlook.com (2603:10b6:a03:477::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.25; Fri, 28 Feb 2025 04:01:24 +0000
Received: from DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::927a:9c08:26f7:5b39]) by DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::927a:9c08:26f7:5b39%5]) with mapi id 15.20.8489.019; Fri, 28 Feb 2025
 04:01:24 +0000
From: "Maniyam, Dinesh" <dinesh.maniyam@intel.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Marek <marex@denx.de>,
 Simon <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>, Dario
 Binacchi <dario.binacchi@amarulasolutions.com>, Johan Jonker
 <jbx6244@gmail.com>, Michal Simek <michal.simek@amd.com>, Arseniy Krasnov
 <avkrasnov@salutedevices.com>, Alexander Dahl <ada@thorsis.com>, "William
 Zhang" <william.zhang@broadcom.com>, Igor Prusov
 <ivprusov@salutedevices.com>, "Meng, Tingting" <tingting.meng@intel.com>,
 "Chee, Tien Fong" <tien.fong.chee@intel.com>, "Hea, Kok Kiang"
 <kok.kiang.hea@intel.com>, "Ng, Boon Khai" <boon.khai.ng@intel.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>, "Zamri, Muhammad
 Hazim Izzat" <muhammad.hazim.izzat.zamri@intel.com>, "Lim, Jit Loon"
 <jit.loon.lim@intel.com>, "Tang, Sieu Mun" <sieu.mun.tang@intel.com>
Subject: RE: [resend v3 17/19] drivers: mtd: nand: Enabled Kconfig and
 Makefile for SPL_NAND_FRAMEWORK
Thread-Topic: [resend v3 17/19] drivers: mtd: nand: Enabled Kconfig and
 Makefile for SPL_NAND_FRAMEWORK
Thread-Index: AQHbiGpg6/x4KnuGf0OEj4ma0YfhQrNbrKQAgABqTRA=
Date: Fri, 28 Feb 2025 04:01:24 +0000
Message-ID: <DM4PR11MB5373F5322F7554073B29508182CC2@DM4PR11MB5373.namprd11.prod.outlook.com>
References: <20250226161833.53689-1-dinesh.maniyam@intel.com>
 <20250226161833.53689-18-dinesh.maniyam@intel.com>
 <CAOf5uwkKE-W0pPMB50rBs3Fa7Mdh75zU9nYNG2DpNLqjrp=ORQ@mail.gmail.com>
In-Reply-To: <CAOf5uwkKE-W0pPMB50rBs3Fa7Mdh75zU9nYNG2DpNLqjrp=ORQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5373:EE_|SJ0PR11MB6575:EE_
x-ms-office365-filtering-correlation-id: 876d07e7-1d68-4f78-b7a9-08dd57ac9177
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|376014|10070799003|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?U1pYekhNYUt1YTVhaXVMcGE4WEZucG9TR0hMWW5XRmZpd0dUS2VoZjJTaTNy?=
 =?utf-8?B?RTdDMnB5K2F3M1lXNi9QVXlDWndsZ2JVeHNickNxWVZpYlBZd3kydW9QbEMx?=
 =?utf-8?B?RzhLZkhRMUZIK2ZQNGxpb0xlUWdLSTRYVU9vakRoeGtWSFpGUzYwVTM1RnY2?=
 =?utf-8?B?aDlIMWE5elBLNVdtOW9DaGZ4RWNGT2ErMWJIME14Z2tyQXk0TUx3K3UyYzJY?=
 =?utf-8?B?R1BSVTZ5UDJWQy9aYU5wY0d4RWh1eVBxUUgwRzdERlExZlVJRnRMUHptQW1K?=
 =?utf-8?B?OVJkWXhXemhsZklSeUVJYlhpeEFNR3Nnd2c0eXA2Ri9xK0thdzVjcTBLTnda?=
 =?utf-8?B?SjA4TzNTc0s2QmRpQ1k3NEJGMnF5TmN6K2pmY3JiTVg5S0pLeTV5TnlqQ3Js?=
 =?utf-8?B?cVk0Q0RCRjFGYVg4WG5kRThJOE1hZVluQ0E1Y2dsTmJDaFlKbGZhOWhwSVFR?=
 =?utf-8?B?QmRCNGtXUzZJSnVkYU9aY2tqRGhTK0d4eU9LcXBHSTNIYnF1cmUyaVcxZEpP?=
 =?utf-8?B?RjZ0WjVKb2Qrakk2M29vWnoyTWpOSENHc2lQQXp6WTd4Z2dnc2kwdE5sZXl1?=
 =?utf-8?B?WkVwUEFKOFBRbVlFNnpUajlyZVNITHErTHpMVnU1N2RxUkdtT2RUNGQveHpK?=
 =?utf-8?B?akpnbDNRSExrUVVXLzVtYmo3bmM0RXJHUGNlZUd5OG1RalZ1Z1IvWVEzWkRv?=
 =?utf-8?B?cVh2N1llZ2hURTl4QnZGSWFHT2p0S0lsYVkvdGJKN3hLODA0KzZxcnJqT21G?=
 =?utf-8?B?Z25iRWxvbTl1K0pxKzN0bi94K08xNVY3S2NvN1ladm81a3FwdUtpZnJTMHpY?=
 =?utf-8?B?a1hJU0U5eTJyMUJTK1dCeDBxVkpCNURLNGZ0MVQxdUU3ZWRSSUk5aHZSdGRG?=
 =?utf-8?B?MXFVaW1WWWhLN3lodklQbnpDMGx0eU5rTXoxa2ZRaTFuOUw2UWJVYW9nUlE4?=
 =?utf-8?B?RW92d0k1NVVDZ2xySnF6aGNPTFQyM0tqenZVSnBmTk9IY1BONHkrUHZiNHpZ?=
 =?utf-8?B?WHQ0bmI2bGxpZWFUbVRvakdsbTZ5dkxQbFROYzRDU0w3TVFVMTl6dmk0WWND?=
 =?utf-8?B?QkxlRERPVGJpbnJub1BONEx6amYzUWRJVzZpbUtUWEJOb2lxd3JJdHoxSm9k?=
 =?utf-8?B?UDI5blh5UTh5dWtwQ0kyaHdNUzVaMGVPRE9ZbktxK293dTlmRWU3RnAwYWVM?=
 =?utf-8?B?N00vUmVVdnA2bk9NcSswbTk3STM3blRZRVc1d00va3VKNStkNzJhTkxTeEF4?=
 =?utf-8?B?dUNnSmsyZmtEbmhIci9oMENiaGphNE92cjlRN1NVcGNCRytIZEs4N1NWUGRZ?=
 =?utf-8?B?eHdaVXo5RlIrV3lUWEZHY05idXRqUzUvOUd3ak1EbndyalA2SzA5SThKa3cv?=
 =?utf-8?B?eW1zZ1ZKalRKYlMrM1dmUkczS3FVcjFuZVMzbjdVZXlOeEtNMjEzL0g5cjVW?=
 =?utf-8?B?L0Z2L0RoSXd3Sk5yV0J1d2NCTkZTVlhoUlpjQ3Zxc0xmZU9SUnJ0aEdQd1NP?=
 =?utf-8?B?WWsyVFdCM2t2djRNeGFSaVByUGhXS2g0R1pFbFZTT3dSR25zSUlwSzRENzcz?=
 =?utf-8?B?MXpIZ3Z4QnlxM29zVVlMNGpTVUkwWCtCcm0xUWQwOGlFZ2JiRzBFcXozUlFL?=
 =?utf-8?B?Wm9jM3NwRkVNTWxMOGtJVHNjM1FaYzBTcFpCZVpmSXJtaFl5RFIzU2RYTWJP?=
 =?utf-8?B?eUtUeGdqbzZMNnJCb1BOYmpCZ0ZKVytQcEJFdVZtSFRZa1hCZnRwV1hRWllN?=
 =?utf-8?B?ZHF6U2pHaHEvRTRGZ0JkbXlpNStuSFNlT01vWE9iNGZyRU9rYnJPeWtDL0lu?=
 =?utf-8?B?MDhqM2Q5WHdBcjIrU3cyZVY1UnJBQTJKd3FHcFhtRHdmVnNuRXNKTGZtQ1Fx?=
 =?utf-8?Q?mcp7qW4ROXUCw?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB5373.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014)(10070799003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?em82TU4wZys4bGk1amFoTzZaVSs3SGhZMWpVODNaaDRJYWNuSDRpSjczMUNy?=
 =?utf-8?B?YkF1SzZXdEtlVktvMXIrUDh2azJlakIxcDBQUVpkMUN6T0FnUHZkOVlhTVd2?=
 =?utf-8?B?Nyt3c05BdXhhSk5zdDU4VnBGcG5oSGhFSTd3UkcyKzNVblQ0RWc1OUdQcHlG?=
 =?utf-8?B?Z082T2RodEFCOFY0M3dBQmR5QTVEWVFmRU1JR3NMdVFtc0JzOTZTMnAyNWo4?=
 =?utf-8?B?TUxHaE1WRXB2VXhGRHVYcHhZQmpPTVNhd3ZzNGE0ejdLMWRNSWN1RWhtWWwv?=
 =?utf-8?B?RElLUDZodmxXMUl4UWpkaUFQZnJTUURMRDM4TUIwYmtsU2VLaXFsdHJDLzM5?=
 =?utf-8?B?a3d5dVQzcVduZDBVYnA1MDBqR3hzNGQrUCtLbXBxMytHYTF3NjAxWlpuRnR6?=
 =?utf-8?B?RmpnM3dST0E3Mi9pVlhkMzkzaGFyL1luUGtxR2Zkd1g2Q0h5c1ZtelRNbFk0?=
 =?utf-8?B?SDVneUJYekl2OGMvZFMwR3BrQ1BWM2RxbEhTMllpVk5iS29OZnE4SkxmWmVM?=
 =?utf-8?B?a2M4ZEI4RnNNR0tsTS9Ec0k2WXNOWjhnWG0vL2UrVDIzS0YzY0d5WFArekpK?=
 =?utf-8?B?cFNoZkpMckF2NktreWtZNHR1VStyZ1Zhc1piZ2l0RmxIbDdDMDcyamJuRzBa?=
 =?utf-8?B?a204VEVhbU5IY1plT3l2OU9EcWg3MGNwN0NUQTJkUFZjaUZoaWozWDFGUFNs?=
 =?utf-8?B?Mkt5YUFwSzFQdzFGS3V3bEtTQlppbGdLS3crMmJOdUd1Ni9GZ2JCcExvT1pk?=
 =?utf-8?B?QlExTnVzZHN3RFhBMzRtZVQyeENzQjdRM0RRc0plSUtUdWhIZXlsSUxRaU84?=
 =?utf-8?B?Ujd6TzFsVDRZR2NyQWxOUE4xOTc0bnZPTmlhOGhzZEFSbVBnVm5rdkpkTDFl?=
 =?utf-8?B?ampsaGNxbGttMWc2VXFsWlQzbnlDZUNPem1vZ1VrNzh5TzR1M0VMT2hFZlNN?=
 =?utf-8?B?WXV6S3JpdTdQMlF0S0NKOTlvVnhiT0lBRkk3LzNNWWJ3Tlk2RDVRM2dER1Ew?=
 =?utf-8?B?R0hjeGxpQU1lTlpWUUtRSm9nQUp5Z3p5ODhCMktVR0l6N2dxdkVKMEZtb3Bu?=
 =?utf-8?B?RzhDSjdZYTZvdDNIZWlOWUI0c3FBem5WREM2UkhKRnp1OEtDY25YUXZFK2Ru?=
 =?utf-8?B?eThkWU1pM0cxK2xzcmU3OEEybmYzTGZhbEQrbTd0djdXT2lwR2pMMlpFb2E3?=
 =?utf-8?B?YUs5WFVweXorSEY3VDhHd2Z4bmg0ZFpqRnBCUHB6Ym1HRmxHaVQ0cVJFS2Rt?=
 =?utf-8?B?L25TVjdqYThndmNyd2tmZFdpSC9PYkg0c2NIREdiMC9BN2I1YmpLQU83RDJL?=
 =?utf-8?B?K3ZrQkhFNXdLYjhNYlBNZXJLUmdRWFByR1gzUDEva1c1ekIxR3M2TW8wWnll?=
 =?utf-8?B?MFBwQWRlOC9ON3RiTGowNnR5UVRnd1NYTHBsNWJLS21UK2VidVIzK2QzRDlt?=
 =?utf-8?B?bndsRHhvQjF0Qzlna08xdkpmM3BzNlduaVJyT3FTZE9DS3hZVlBHdkdlTXpO?=
 =?utf-8?B?UElmVnhMdjBxeDB6SjlIY3UwQjN0OWJDWllCRUZ4TnhXa0dzNzM0bUxiWEdD?=
 =?utf-8?B?N2NIL2c2M3FOYXFBTHdWMnl6Y1ZtbUdyY2FUWTQrVmN4RTJQb0ZQWUJzOW9J?=
 =?utf-8?B?elF3eGg4WVhWTFkxZk90UFlUVUxaRzYzRkUwNlMrUGQzaDlmNjdEd1FZeDBj?=
 =?utf-8?B?L1o3Q1FnVC9QSVJBQXZVbWJ3S1pJZFdzVVBRakJhWlVnNnR6ZGFEbjBtdGlT?=
 =?utf-8?B?WkJZb2RyVy9BNnJReEJaTHEzeTY5SXVibVRPc200K0Y4b01mekhjNnYvNFBY?=
 =?utf-8?B?UXlxL01QUW5xaGk0TlB1NExWZWxXU3ZFbEd2Z2lxK093N3Z2SXJ3UVh2Qmd0?=
 =?utf-8?B?VlNUUmNyVXl3dGNYRnl6RENnYjB6eTZpRXNWaTVNMXdZT1ZWZCsyQU00Unc1?=
 =?utf-8?B?VFhVZXZCT0R1TXVkTWV5cVN3bkF1QUFkZ0J1czdmUzhneWhZRjFZMTVVSWVZ?=
 =?utf-8?B?K0YvVXdBSXoyWmx4aWE5YVZsWDdacHNVeStUaWpidVN4QUtjRkN3Q1hVMm1p?=
 =?utf-8?B?MGtCRXhGNUpSVjVscUlOU3hPb3Z6dm84TE42aU12Sy9adVNJQlppK1Rrb0xO?=
 =?utf-8?B?N0ZZNXpEWEhsSVBYSitQcy9WRGNlUTJRSk5NTnBLZnRrK1p6Q2hLaW01eFA0?=
 =?utf-8?Q?CdLd+Fin3Uxgn3He6q1YyNeRgeM//rBm+wjTuM8MUS8H?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 876d07e7-1d68-4f78-b7a9-08dd57ac9177
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 04:01:24.2947 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bPes+85HHrBWYMZmSurN0k+Ys0BV00TXuFtDR5RCmzBYmBK8NjnlM0q3WbOAjjMFF+Eflt4uecJNDDk/qohaXTtRvxX6n1KgI52s5YKSoK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6575
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWljaGFlbCBOYXp6YXJl
bm8gVHJpbWFyY2hpIDxtaWNoYWVsQGFtYXJ1bGFzb2x1dGlvbnMuY29tPg0KPiBTZW50OiBGcmlk
YXksIDI4IEZlYnJ1YXJ5IDIwMjUgNTozMCBhbQ0KPiBUbzogTWFuaXlhbSwgRGluZXNoIDxkaW5l
c2gubWFuaXlhbUBpbnRlbC5jb20+DQo+IENjOiB1LWJvb3RAbGlzdHMuZGVueC5kZTsgTWFyZWsg
PG1hcmV4QGRlbnguZGU+OyBTaW1vbg0KPiA8c2ltb24uay5yLmdvbGRzY2htaWR0QGdtYWlsLmNv
bT47IFRvbSBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+OyBEYXJpbw0KPiBCaW5hY2NoaSA8ZGFy
aW8uYmluYWNjaGlAYW1hcnVsYXNvbHV0aW9ucy5jb20+OyBKb2hhbiBKb25rZXINCj4gPGpieDYy
NDRAZ21haWwuY29tPjsgTWljaGFsIFNpbWVrIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47IEFyc2Vu
aXkNCj4gS3Jhc25vdiA8YXZrcmFzbm92QHNhbHV0ZWRldmljZXMuY29tPjsgQWxleGFuZGVyIERh
aGwgPGFkYUB0aG9yc2lzLmNvbT47DQo+IFdpbGxpYW0gWmhhbmcgPHdpbGxpYW0uemhhbmdAYnJv
YWRjb20uY29tPjsgSWdvciBQcnVzb3YNCj4gPGl2cHJ1c292QHNhbHV0ZWRldmljZXMuY29tPjsg
TWVuZywgVGluZ3RpbmcgPHRpbmd0aW5nLm1lbmdAaW50ZWwuY29tPjsNCj4gQ2hlZSwgVGllbiBG
b25nIDx0aWVuLmZvbmcuY2hlZUBpbnRlbC5jb20+OyBIZWEsIEtvayBLaWFuZw0KPiA8a29rLmtp
YW5nLmhlYUBpbnRlbC5jb20+OyBOZywgQm9vbiBLaGFpIDxib29uLmtoYWkubmdAaW50ZWwuY29t
PjsgWXVzbGFpbWksDQo+IEFsaWYgWmFrdWFuIDxhbGlmLnpha3Vhbi55dXNsYWltaUBpbnRlbC5j
b20+OyBaYW1yaSwgTXVoYW1tYWQgSGF6aW0gSXp6YXQNCj4gPG11aGFtbWFkLmhhemltLml6emF0
LnphbXJpQGludGVsLmNvbT47IExpbSwgSml0IExvb24NCj4gPGppdC5sb29uLmxpbUBpbnRlbC5j
b20+OyBUYW5nLCBTaWV1IE11biA8c2lldS5tdW4udGFuZ0BpbnRlbC5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbcmVzZW5kIHYzIDE3LzE5XSBkcml2ZXJzOiBtdGQ6IG5hbmQ6IEVuYWJsZWQgS2NvbmZp
ZyBhbmQgTWFrZWZpbGUNCj4gZm9yIFNQTF9OQU5EX0ZSQU1FV09SSw0KPiANCj4gSGkNCj4gDQo+
IE9uIFdlZCwgRmViIDI2LCAyMDI1IGF0IDU6MjDigK9QTSA8ZGluZXNoLm1hbml5YW1AaW50ZWwu
Y29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IERpbmVzaCBNYW5peWFtIDxkaW5lc2gubWFuaXlh
bUBpbnRlbC5jb20+DQo+ID4NCj4gPiBFbmFibGUgdGhlIEtjb25maWcgYW5kIE1ha2VmaWxlIGZv
ciB0aGUgU1BMX05BTkRfRlJBTUVXT1JLIHN1cHBvcnQgaW4NCj4gPiBhZ2lsZXg1IGZhbWlseSBk
ZXZpY2UuIFRoaXMgd2lsbCBpbmNsdWRlIGFsbCB0aGUgYmFzaWMgZmlsZXMgbmVlZGVkIHRvDQo+
ID4gdXNlIHRoZSBleGlzdGluZyBuYW5kIHNwbCBzdXBwb3J0Lg0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogRGluZXNoIE1hbml5YW0gPGRpbmVzaC5tYW5peWFtQGludGVsLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgZHJpdmVycy9tdGQvbmFuZC9yYXcvS2NvbmZpZyAgfCAgNyArKysrKysrDQo+ID4gZHJp
dmVycy9tdGQvbmFuZC9yYXcvTWFrZWZpbGUgfCAxMCArKysrKysrKysrDQo+ID4gIDIgZmlsZXMg
Y2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bXRkL25hbmQvcmF3L0tjb25maWcNCj4gPiBiL2RyaXZlcnMvbXRkL25hbmQvcmF3L0tjb25maWcg
aW5kZXggYTk1MTVjN2I3NC4uZDZhYzczMDIyNCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL210
ZC9uYW5kL3Jhdy9LY29uZmlnDQo+ID4gKysrIGIvZHJpdmVycy9tdGQvbmFuZC9yYXcvS2NvbmZp
Zw0KPiA+IEBAIC04MzcsNCArODM3LDExIEBAIGNvbmZpZyBTWVNfTkFORF9IV19FQ0NfT09CRklS
U1QNCj4gPg0KPiA+ICBlbmRpZiAgIyBpZiBTUEwNCj4gPg0KPiA+ICtjb25maWcgU1BMX05BTkRf
RlJBTUVXT1JLDQo+ID4gKyAgICAgICBib29sICJDb21waWxlIHRoZSBlbnRpcmUgTkFORCBmcmFt
ZXdvcmsgaW50byB0aGUgU1BMIg0KPiA+ICsgICAgICAgaGVscA0KPiA+ICsgICAgICAgICBTb21l
IGRyaXZlcnMgcmVxdWlyZSBhIGxvdCBvZiBmdW5jdGlvbmFsaXR5IGZyb20gdGhlIE5BTkQgZnJh
bWV3b3JrDQo+ID4gKyAgICAgICAgIGNvcmUgd2hlbiB1c2VkIGluIFNQTC4gVGhpcyBvcHRpb24g
YWxsb3dzIGNvbXBpbGluZyB0aGUgZnVsbCBOQU5EDQo+ID4gKyAgICAgICAgIGZyYW1ld29yayBp
bnRvIHRoZSBTUEwgaW5zdGVhZCBvZiBpdCdzIHJlZHVjZWQgdmVyc2lvbi4NCj4gPiArDQo+IA0K
PiBUaGlzIHNlZW1zIG5vdCByZWxldmFudCBmb3IgdGhpcyBzZXJpZXMgYW5kIGV2ZW4gSSBkb24n
dCBsaWtlIHRoZSBpZGVhIHRvIGhhdmUgaXQNCj4gDQo+IE1pY2hhZWwNCj4gDQoNCkkgYWdyZWUu
IEkgY2FuIGRyb3AgdGhpcyBjb21taXQuIA0KV2UgYWxyZWFkeSBoYXZlIGNvbmZpZ3MgdG8gZW5h
YmxlIHRoZSBuZWNlc3NhcnkgZmlsZXMgdG8gYmUgcGFydCBTUEwgbmFuZCBidWlsZC4NCkhvd2V2
ZXIsIGRyb3BwaW5nIHRoaXMgY29tbWl0IHdpbGwgY2F1c2UgYSBjb21waWxhdGlvbiBmYWlsdXJl
LA0KVG8gb3ZlcmNvbWUgdGhpcywgc2hhbGwgbW9kaWZ5IHRoZSBzb2NmcGdhX2FnaWxleDVfbmFu
ZDJfZGVmY29uZmlnIGFuZCANCm10ZC9uYW5kL3Jhdy9LY29uZmlnIGZpbGVzIHRvIGluY2x1ZGUg
dGhlIHJlbGV2YW50IGZpbGVzIHRvIGJlIHBhcnQgb2YgdGhlDQpTUEwgbmFuZCBidWlsZC4NCldv
dWxkIHlvdSBsaWtlIG1lIHRvIHJlc3VibWl0IHBhdGNoIDEzICYgcGF0Y2ggMTY/DQoNCkRpbmVz
aA0KDQo+ID4gIGVuZGlmICAjIGlmIE1URF9SQVdfTkFORA0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL210ZC9uYW5kL3Jhdy9NYWtlZmlsZQ0KPiA+IGIvZHJpdmVycy9tdGQvbmFuZC9yYXcvTWFr
ZWZpbGUgaW5kZXggNThmZGUzMjcyZi4uMGEzMmUxODRkYyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL210ZC9uYW5kL3Jhdy9NYWtlZmlsZQ0KPiA+ICsrKyBiL2RyaXZlcnMvbXRkL25hbmQvcmF3
L01ha2VmaWxlDQo+ID4gQEAgLTMsOCArMywxOCBAQA0KPiA+ICAjIChDKSBDb3B5cmlnaHQgMjAw
Ng0KPiA+ICAjIFdvbGZnYW5nIERlbmssIERFTlggU29mdHdhcmUgRW5naW5lZXJpbmcsIHdkQGRl
bnguZGUuDQo+ID4NCj4gPiArbmFuZC1mcmFtZXdvcmstb2JqcyA6PSBuYW5kLm8gbmFuZF9iYnQu
byBuYW5kX2lkcy5vIG5hbmRfdXRpbC5vIFwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgIG5h
bmRfZWNjLm8gbmFuZF9iYXNlLm8gbmFuZF90aW1pbmdzLm8gbmFuZF9hbWQubyBcDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICBuYW5kX2h5bml4Lm8gbmFuZF9tYWNyb25peC5vIG5hbmRfbWlj
cm9uLm8gXA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgbmFuZF9zYW1zdW5nLm8gbmFuZF90
b3NoaWJhLm8NCj4gPiArDQo+ID4gIGlmZGVmIENPTkZJR19TUExfQlVJTEQNCj4gPg0KPiA+ICtp
ZmRlZiBDT05GSUdfU1BMX05BTkRfRlJBTUVXT1JLDQo+ID4gK29iai15ICs9ICQobmFuZC1mcmFt
ZXdvcmstb2JqcykNCj4gPiArTk9STUFMX0RSSVZFUlM9eQ0KPiA+ICtlbmRpZg0KPiA+ICsNCj4g
PiAgaWZkZWYgQ09ORklHX1NQTF9OQU5EX0RSSVZFUlMNCj4gPiAgTk9STUFMX0RSSVZFUlM9eQ0K
PiA+ICBlbmRpZg0KPiA+IC0tDQo+ID4gMi4xOS4wDQo+ID4NCj4gDQo+IA0KPiAtLQ0KPiBNaWNo
YWVsIE5henphcmVubyBUcmltYXJjaGkNCj4gQ28tRm91bmRlciAmIENoaWVmIEV4ZWN1dGl2ZSBP
ZmZpY2VyDQo+IE0uICszOSAzNDcgOTEzIDIxNzANCj4gbWljaGFlbEBhbWFydWxhc29sdXRpb25z
LmNvbQ0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IA0KPiBBbWFydWxh
IFNvbHV0aW9ucyBCVg0KPiBKb29wIEdlZXNpbmt3ZWcgMTI1LCAxMTE0IEFCLCBBbXN0ZXJkYW0s
IE5MIFQuICszMSAoMCk4NSAxMTEgOTE3Mg0KPiBpbmZvQGFtYXJ1bGFzb2x1dGlvbnMuY29tIHd3
dy5hbWFydWxhc29sdXRpb25zLmNvbQ0K
