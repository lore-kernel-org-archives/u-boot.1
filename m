Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA681CF58E0
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:30:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 318CD893D7;
	Fri, 20 Sep 2024 09:30:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="KpZlFriz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8ED30893D7; Fri, 20 Sep 2024 09:30:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 707A5893A0
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:30:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726817449; x=1758353449;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=65lAUnPUYLaPqMmUI4HlzrExo+vBFE2OlWg4MH2/Qy8=;
 b=KpZlFrizmHb3v3uo6LOa9sRr5yNboMvzDrZdHyRdR/h9zoX8ZynR89ox
 aJom+w1SHUAqLyt3c8vA0XX8H2hr35E8W1cmpOSZKKNhfWH/7M7adcv/Z
 eTaPJhdDQTLXxT3XG/icrC49d8hhhINg9Op17GvBV7j0xXZYLyy0s/KXV
 y80g26plGw1+kgvgrozObDws9DTT3/Un5jrjh8Q0LmSVPUTf3yI2OPx39
 SeRaBSYo7b9OQ5C7bAZl4ew+IeDVmSgSVYfdZEob44v0OUM/yDBVMD/7J
 9B6NY3e67oosbZdMhdK7r0MLsBBSzPr/v50e8JYGMQRJD7d0pLwgTUuNn A==;
X-CSE-ConnectionGUID: 3EGmgJV7TR6a8Uu7JmFtdA==
X-CSE-MsgGUID: PHM6BMk1Ro+1zGq89r0AEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25932599"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; d="scan'208";a="25932599"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2024 00:30:47 -0700
X-CSE-ConnectionGUID: BHvZFlejQGCqHBESEDOSKw==
X-CSE-MsgGUID: z/WuYcmcTYCTEz/rn3dcDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; d="scan'208";a="74751243"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Sep 2024 00:30:47 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 20 Sep 2024 00:30:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 20 Sep 2024 00:30:46 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 20 Sep 2024 00:30:46 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 20 Sep 2024 00:30:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w8IgKaltEkF+biwM3KqflZPr08iPnW1Jgh30sJOxYnGT9OHyGUHuD0oBbzVhykWqJ2mV3jSeWAWx/Jd37k5s98fk2iPjyZvBy1l1+h8H3Ofpv7HQXX7O+qD59MnKcy3XcpXK+R9LddAJasQNE1xIItvE1PgBX+VgsuXPN0+OpaP1R4s22otydwkyY3mg2OYA61xt42wMQrfoPBNxCdC+FPA7vR52k8Al8ex299biA//S6XSFijY/S/mzQSszuSW80BuWIu5AtK2OrWa7JlWRMH8SCbYKzm68o9tI5PHu5LrqmaI+WS9VZoMokBpkXjb3PhZ3RSnBzKN1LeOZb+3LRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65lAUnPUYLaPqMmUI4HlzrExo+vBFE2OlWg4MH2/Qy8=;
 b=pYQeH69CJ2QL8Ww1erdT95mOJG4clUyGjIZZr1USrlvxo07411cDqDXSLB1hrGvoj4U5r4EKK0bLC/yrreUJBhIa4cmR/mec8m0B+/ONdBhwj5jwVu+Dcx1DCKNycA5PYjYYXPwt/cCqMlX3n3Ut5ZoG5vFOGqJaqyHs/nDG+IO1CNGqcnx+jq04oVIMdQnhl8fPHWrB/2NkWCPGP00eWDIyiwNPvOH4sgYyTTXSGqY77a5fwMjZ5U24mvhOsHDGE05vn5wRspKLMGRnR9xC67mHVX3VZhuzfIFQbqVORgOX51kVapKjMtREzKjTFkRSckZGRK+wlxgVkq74tjPz4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 IA1PR11MB7920.namprd11.prod.outlook.com (2603:10b6:208:3fc::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.22; Fri, 20 Sep 2024 07:30:43 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe%5]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 07:30:43 +0000
From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
To: Simon Glass <sjg@chromium.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Marek Vasut
 <marex@denx.de>, Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, "Meng,
 Tingting" <tingting.meng@intel.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@intel.com>, "Hea, Kok Kiang" <kok.kiang.hea@intel.com>
Subject: RE: [PATCH v1 00/20] SoCFPGA: Add Boot Support for Agilex 5 in U-Boot
Thread-Topic: [PATCH v1 00/20] SoCFPGA: Add Boot Support for Agilex 5 in U-Boot
Thread-Index: AQHbCys30mphpo3NOk2nEGuihBpLPrJgRlMAgAAAxoA=
Date: Fri, 20 Sep 2024 07:30:43 +0000
Message-ID: <DM8PR11MB5592D559F55DD3B25AB79C8CD26C2@DM8PR11MB5592.namprd11.prod.outlook.com>
References: <20240920070242.20884-1-tien.fong.chee@intel.com>
 <CAFLszTgN8uTDBfLixYY7pMRsU370t++OiFweqYYZ119Oa=bdRA@mail.gmail.com>
In-Reply-To: <CAFLszTgN8uTDBfLixYY7pMRsU370t++OiFweqYYZ119Oa=bdRA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|IA1PR11MB7920:EE_
x-ms-office365-filtering-correlation-id: cdab9822-f322-47ea-589d-08dcd94622df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?N090VUVSZ3NvR0Q5K3ZDVDJuQnlVOG1zUFg2bWhjVDhWQ3FINVc2djhGMitN?=
 =?utf-8?B?dklBZ2VHd2ZsOHNSNjlBdzB4VlUycXM3bzFleHlzNDN2Znk3S3dJSXVWeTNM?=
 =?utf-8?B?VzJkWE9jTjB6SGdlL3ptcjNKT2g1WWdrdjdTNTNKeTBTWm8wOWZJa1VHcHNV?=
 =?utf-8?B?N1IyYzhOOGF0YmdyR1ZRckN4NVlzWDlsTnU4OEhrNlpJRVVjQU1pMzlKMnFp?=
 =?utf-8?B?TFhaN1Fpd0U0Z0EwOGtCaElRMlloUHJFMW1SV0xYTFFBcTI4dWM5aEdvVHBj?=
 =?utf-8?B?SVRtKzVUcGcydnlQODV5aXR2elpIeGdSa2xrZGxkejFOYitqS2hDVjd1RGdC?=
 =?utf-8?B?YzFGSDBXOTg5QlFnR3dsVzU2MXd6bmFqeG5UaCtkZm1kVEJIeU04T25jb3ht?=
 =?utf-8?B?UkJxTW8yVEd0blNWc1lPUDZrUk9IbUpCUW55cXRKbDl0Ym10TFdHd1NWQllj?=
 =?utf-8?B?aU5qOGd3cU5WT3N1YlJpTm1hbEJoSHlDMk5KK2J4R0JJNGhrakpMeFVtVzdP?=
 =?utf-8?B?NTdqbFFNc25MSVlxazRSS1VBbG85a1Q1R1lvTVpOMHZmb1JYbjZkc1NzTlVG?=
 =?utf-8?B?c2NMU0lXekU0NzV5b2NETU1tTHB6UTVWbEl3ZTFsYUNJdWVVSWtuQXJQQVlk?=
 =?utf-8?B?TC8wSTlMTW8xbHlDdlROZGNYOTBmaXhZRGpKZHFtSHdKWGptL0ROUFY5L05C?=
 =?utf-8?B?bi9ucnUzbjNyWVJrZFF5RGNMOGxFM3pnbDZ2TDZFQk1CUFB5eTRqdWthS0hC?=
 =?utf-8?B?dGt3R2JnYnpIbjkvU2pEWmZ4THJoTmVhK2hidDZIVFphajAvOXVHOHRqQ0ow?=
 =?utf-8?B?Z1FSMitBRDdjSzJnMFR0K2NxRnNFZ1FSdXVwNHdxVlkxR3pUYndsQ0grK20z?=
 =?utf-8?B?Q2MxYjdwU01aaXY4R2wzcVpsVGVrSkI0Tk1wT2wzNUJ3VlN6L3NTSWoyNmd2?=
 =?utf-8?B?REFKNVJrdHdBSkYvVjFPb09LS3JNMlhlTW5aZEk0a2kxUEdyUHZnWnkxdzY1?=
 =?utf-8?B?anlobU1ONUpHM0o2R3g0aWtMSnBJUHVIUjlHMG9FQWVpMVVIcVptMEE2R1VZ?=
 =?utf-8?B?ejA1TTFVWFpYeTlGQ2NpMWI0WEgzMVVHRUl4QmMwMnZVb0M4NXdwZDhjakU2?=
 =?utf-8?B?S1VOMk1iVzVmVG9JWS9yL0xiQkpNS1VSbDNZV1dKR0NNUWZUb2N6ekUyWTVP?=
 =?utf-8?B?Risxa21YYll6NkM2cE9vcCthOUNhZzc3VWM4UEc4ZFZoUG05RzFrVG9Rblhv?=
 =?utf-8?B?dkFGbnF2OHpYTlY0Tm9GSldrS0ZtM3diZUZTUFJjVngvc0h3MDEwbTdEY1dD?=
 =?utf-8?B?MWdKcFdqUWc5elVOS3NXSUI1TEhDN3dpenlQcktuZ2VGcGhKTExuMjVlVklY?=
 =?utf-8?B?WmdrR0llTnczUWs0TnhBdW1ZazQ0RnBvckVQU3VsMFVxK3lONS9HclRaMjB1?=
 =?utf-8?B?VStlZVROWC9USTNEZ1VwNHNlbWhFbUdaUHVva0ord1EvR1p6MDdjbTVkVXpk?=
 =?utf-8?B?Yzg2dGdud1NMeXhBZ1hPcnlmMEhTS1Bnd2VLaHRkRE40d2NxYU1xa0xXSHhs?=
 =?utf-8?B?eHFLMjZUa0JINmJ0YTBzK2lSSk1lV2I1Smova2FzTG5vMUJOcDhKUVVhSGZH?=
 =?utf-8?B?ZzR5Tk9JRDNHdzYwZjE0Z1h1NzdjSzhzVTA2Wml1QlZlUG1kaWppSDIrRFV6?=
 =?utf-8?B?K0RKZXozR1pud29JSlc5RlpyMmlDZ0lMTXU3ODF0M1E4cmtJTHdXZHFKQ21H?=
 =?utf-8?B?QmNtcVJZak1nd2xCeC8vM1F0YkJSS2E2UmVIYWJ0N3dBY3RLLzJNeFViYUZt?=
 =?utf-8?B?a3hKdzJjN1l1V1FXbyt6dz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5592.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emQ4UE56NnB5MkFDcktEaHZuSXJpcm5qZHZ2ajllblZ2V0ZJSnpzTGpkdHpC?=
 =?utf-8?B?Q25kZkswRjNkdTkvRGtCTnJTdUwyOFVFYmE3S3RKS2tyUERJOW15VFBmRFgr?=
 =?utf-8?B?R0N5UWM5MXdOLzN5S3dpWGJueVZMQUYyQlJxRmpsUGdaSU55ZTNtWC9ERjJo?=
 =?utf-8?B?emtRenBCbUpxT0NWK2syRTFwYUhGeEJFRlJ6YzcwbXgycCtmbDBYZUpPY0JC?=
 =?utf-8?B?cnFFTGlsU2NoblJZY0NiZVdYV051azlab3k2bWkxTThwVWlMRFMvNTdFRjVP?=
 =?utf-8?B?VWFPN3dSdlNod1hsWkFLV0JJazF2ZzAvK0NmUDQ0S01zSHdXaVhhc3EyYURB?=
 =?utf-8?B?eVkxYWdNQmdWZk1peDlyRURDZVdFeXl5QnJPUEM2SDhZSExvMWZSQStiSWY4?=
 =?utf-8?B?dzhiWmM2OXlibk0vZEsxeUE0VUVGS01VWDM1WGVsa0VuU1ZwVVk4N08xMzZs?=
 =?utf-8?B?L2VENUpleGhpd3B4WUJYNDVqR3NHcEFNRnRPa0lmRzBsd2pjU291TXc5eWow?=
 =?utf-8?B?OG1HUmJrcHlUOVNVZ2FncVB4akZpUFpYSlpTeGdNdkJEMVJvcmhCem1PdWVp?=
 =?utf-8?B?QXBuUVVVVHBWOHdBcTRWU0NjYzJLRHhCMlFXMEhnRk1LYUlJaDNQN3FwdnZF?=
 =?utf-8?B?MDNhMWxvd0FudXJ4OTRFeVlmOGVkWmtwYk5SYzA5OFlXd3FCaEJLbkpHYVBZ?=
 =?utf-8?B?aWg5Q01IMjhnZTl5QWplRFFFaXN6Qi8xZi9GbW04aVpZSW1tZlNqcHhlMC85?=
 =?utf-8?B?cW9IY2RWQjEyOGd1bDFFSjQ5UlBiTDNzYXFFNkIvSUxnajVubXZQQlZxdGFt?=
 =?utf-8?B?aWJqU0lVdkViR1o1YTR4c29Ddk5jcWM0WC9HU25PT2pucEgzNjF6aWE1d1pF?=
 =?utf-8?B?aHhkNCtidWRzVTBiZU1qZ0NESnlHOUVtcUoyZmlycEs3Rk1lQjIyOGxOdEFN?=
 =?utf-8?B?c1NFQkxybExkRy9KNkkvK1pJeGxsN2hTNGg1ZEpxUzNjUGs4Y2didXVabDA0?=
 =?utf-8?B?UkE3QjJzbUtJdjRHQmM3MlBuTmFwSUxheHVqYmFYRTd0WmNJVEdxV05iWWRr?=
 =?utf-8?B?UDJNNEVGM2NJdWg2NmZTbE1QT2FDVkc5RXZsRTdjSWVIQVZpT2c3dFArQlRK?=
 =?utf-8?B?dzBkNjVhbzdsNFlhbjJ3OXRydnFDUm9RRnNYcC80U2lMQ3FXaG03MFcySDJt?=
 =?utf-8?B?b2dweE1mamlCdno0UGE0aDhJVUxwZ3k1dU4xLzJRQU1sbDFVVlVSdGt4Tmw3?=
 =?utf-8?B?UzJhM3NSN0xhV2dxMXZldkFzajduWkNaUlF4SitjY0pyNG5jeGZhNDV5bGVX?=
 =?utf-8?B?UkVYVUpEVEdzTWpyZXJ5U3BMOGFPWU5oeDNNbldRaU1vQkY1SmJlVDJoVFpP?=
 =?utf-8?B?ZXVCcHp1Szk3bWIvQ3pxVG56UDZoUmhWeUc0R2NWVUlJdWJHVExHRGVlNUc3?=
 =?utf-8?B?UVd2ZlJGRFdGNEF6VVFJUG1SMUdrNFEyZVNlNVE5MlV6dUtvK1ZzM2V6U1BE?=
 =?utf-8?B?TWt5Y1pvaVg1NUpQUjVVcW9PcytJcTUrUUhIekdJTkFuNVBWMHA2QWNYMFVw?=
 =?utf-8?B?LzR6NTZxRnU5S1hwNGJiSnd3OCtqa0tQQmZhMW5SWVNrQklXME5tcUtWem1P?=
 =?utf-8?B?L3AyUWR1REFYUmxlZlFnS2hXUEFIS3FyQ1RQdGdHR0Jma3RkVit5Y3NibTBC?=
 =?utf-8?B?TlVoc0V4NnFaeE15eXRPWmhnWjM0UEl2VU5aelgra0ZGK0g3SitWV3JOVTNv?=
 =?utf-8?B?SDZDYjRiYkFpcWh4Y01INTRBVmM2anl0QXhCL09CSXd0YkxNWGlzSWpZK3lU?=
 =?utf-8?B?a3lFOVhGWkt1TEdxdG5wQnpLamhRd29DUFpIRkFpbXF3d2hQRTRDV3RYWFhn?=
 =?utf-8?B?b3J5UzN2MGtadkp5d2RoUzd3L1pEZVFKSlAzTGkvVmxXcUpUTTNsQ1IxcVFE?=
 =?utf-8?B?M01tclY3MEdqdCtiUE1GQnhPUlEyODZNcFlVczBNMXVYZENPclZ1WlVJSVoy?=
 =?utf-8?B?bC94cUtGWWMvR2w4YmFSaWNsTXQ1VHUwWEdRSHA5MURYUzNmV1Joc3JiV2VB?=
 =?utf-8?B?Yi8zMXhSZjdnK0M4a1ZrQm5adVNzdDB6anR2MEpIeXMzc3lZcW9VN2NOU003?=
 =?utf-8?Q?tVLBOupvMQE+757+uGncuHUA2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdab9822-f322-47ea-589d-08dcd94622df
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2024 07:30:43.5275 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jIvzrfwhlTzXdPIYGUjpsOlvt7TgUOvmKy01qPXFyrgSCR+pT7uZVMB4UJAr2QcOWWV4FLJlf72dedpoCgQ8dqd29GzOrn4gAEmChgxTqq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7920
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

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2ltb24gR2xhc3Mg
PHNqZ0BjaHJvbWl1bS5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgU2VwdGVtYmVyIDIwLCAyMDI0IDM6
MjYgUE0NCj4gVG86IENoZWUsIFRpZW4gRm9uZyA8dGllbi5mb25nLmNoZWVAaW50ZWwuY29tPg0K
PiBDYzogdS1ib290QGxpc3RzLmRlbnguZGU7IE1hcmVrIFZhc3V0IDxtYXJleEBkZW54LmRlPjsg
U2ltb24NCj4gR29sZHNjaG1pZHQgPHNpbW9uLmsuci5nb2xkc2NobWlkdEBnbWFpbC5jb20+OyBN
ZW5nLCBUaW5ndGluZw0KPiA8dGluZ3RpbmcubWVuZ0BpbnRlbC5jb20+OyBZdXNsYWltaSwgQWxp
ZiBaYWt1YW4NCj4gPGFsaWYuemFrdWFuLnl1c2xhaW1pQGludGVsLmNvbT47IEhlYSwgS29rIEtp
YW5nDQo+IDxrb2sua2lhbmcuaGVhQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2
MSAwMC8yMF0gU29DRlBHQTogQWRkIEJvb3QgU3VwcG9ydCBmb3IgQWdpbGV4IDUgaW4gVS0NCj4g
Qm9vdA0KPiANCj4gSGksDQo+IA0KPiBPbiBGcmksIDIwIFNlcHQgMjAyNCBhdCAwOTowMywgPHRp
ZW4uZm9uZy5jaGVlQGludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBUaWVuIEZvbmcg
Q2hlZSA8dGllbi5mb25nLmNoZWVAaW50ZWwuY29tPg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBzZXQg
aW50cm9kdWNlcyBib290IHN1cHBvcnQgZm9yIHRoZSBBbHRlcmEgU29DRlBHQSBBZ2lsZXggNQ0K
PiA+IHBsYXRmb3JtIGluIFUtQm9vdC4gVGhlIGNoYW5nZXMgaW5jbHVkZToNCj4gPiAgICAgICAg
IDEuIEJvYXJkLXNwZWNpZmljIGNvbmZpZ3VyYXRpb25zIGFuZCBzZXR1cCByZXF1aXJlZCB0byBl
bmFibGUgQWdpbGV4IDUNCj4gPiAgICAgICAgICAgIG9wZXJhdGlvbiBpbiBVLUJvb3QuDQo+ID4g
ICAgICAgICAyLiBJbnRlZ3JhdGlvbiBvZiBjYWNoZSBjb2hlcmVuY3kgdW5pdCAoQ0NVKSBpbml0
aWFsaXphdGlvbiByb3V0aW5lLA0KPiA+ICAgICAgICAgICAgaW5jbHVkaW5nIENDVSBjb25ndXJh
dGlvbiBpbiBEVC4NCj4gPiAgICAgICAgIDMuIENsb2NrLCBmaXJld2FsbCAoY29uZmlndXJlZCBp
biBEVCksIFNNTVUsIGxvdyBsZXZlbCBpbml0aWFsaXphdGlvbg0KPiA+ICAgICAgICAgICAgc3Bl
Y2lmaWMgdG8gQWdpbGV4IDUuDQo+ID4gICAgICAgICA0LiBJbnRlZ3JhdGlvbiBvZiBtZW1vcnkg
aW5pdGlhbGl6YXRpb24gcm91dGluZSwgaW5jbHVkaW5nIEREUiBzZXR1cC4NCj4gPg0KPiA+IFRo
aXMgcGF0Y2ggc2V0IGhhcyBiZWVuIHRlc3RlZCBvbiBBZ2lsZXggNSBkZXZraXQgd2l0aCBRU1BJ
IGJvb3QNCj4gPiAoVUJJL1VCSUZTKSBhbmQgUkFNIGJvb3QgKFRGVFAgJiBBUk0gRFMgZGVidWdn
ZXIpLg0KPiA+DQo+ID4gQWxpZiBaYWt1YW4gWXVzbGFpbWkgKDEpOg0KPiA+ICAgY29uZmlnczog
c29jZnBnYTogc29jNjQ6IGFnaWxleDU6IEVuYWJsZSBRU1BJIGJvb3Qgd2l0aCBVQkkgLyBVQklG
Uw0KPiA+DQo+ID4gVGllbiBGb25nIENoZWUgKDE4KToNCj4gPiAgIGFybTogc29jZnBnYTogYWdp
bGV4NTogQWRkIG5ldyBzeXN0ZW0gbWFuYWdlciBiYXNlIGFkZHJlc3Nlcw0KPiA+ICAgYXJtOiBz
b2NmcGdhOiBBZGQgc3VwcG9ydCBmb3IgYWdpbGV4NSBjbG9jayBtYW5hZ2VyDQo+ID4gICBsaW5r
ZXI6IEFkZCBTUEwgbGlua2VyIHNjcmlwdCBmb3IgU29DNjQgZGV2aWNlcw0KPiA+ICAgYXJtOiBz
b2NmcGdhOiBhZ2lsZXg1OiBBZGQgbG93IGxldmVsIGluaXRpYWxpemF0aW9uDQo+ID4gICBhcm06
IHNvY2ZwZ2E6IEFkZCBoYW5kb2ZmIGRhdGEgc3VwcG9ydCBmb3IgU29DRlBHQSBBZ2lsZXg1IGRl
dmljZQ0KPiA+ICAgYXJtOiBkdHM6IGFnaWxleDU6IEFkZCBIUFMgY2FjaGUgY29oZXJlbmN5IHVu
aXQgY29uZmlndXJhdGlvbiBzZXR0aW5ncw0KPiA+ICAgYXJtOiBkdHM6IGFnaWxleDU6IEFkZCBm
aXJld2FsbCBjb25maWd1cmUgc2V0dGluZ3MNCj4gPiAgIGFybTogZHRzOiBhZ2lsZXg1OiBFbmFi
bGUgWEdNQUMNCj4gPiAgIHN5c3Jlc2V0OiAgQWRkIHJlc2V0IHN1cHBvcnQgdG8gU29DRlBHQSBB
Z2lsZXg1IGRldmljZQ0KPiA+ICAgYXJtOiBzb2NmcGdhOiBhZ2lsZXg1OiBFbmFibGUgY2FjaGUg
Zmx1c2ggZm9yIHN5c3RlbSBtZW1vcnkgY2FjaGUgaW4NCj4gPiAgICAgQ0NVDQo+ID4gICBhcm06
IHNvY2ZwZ2E6IGFnaWxleDU6IEFkZCBTTU1VIGluaXRpYWxpemF0aW9uDQo+ID4gICBhcm06IHNv
Y2ZwZ2E6IGFnaWxleDU6IFVwZGF0ZSBDUFUgaW5mbw0KPiA+ICAgYXJtOiBzb2NmcGdhOiBFeHBv
cnQgYm9hcmQgSUQgYXMgVS1Cb290IGVudmlyb25tZW50IHZhcmlhYmxlDQo+ID4gICBjb25maWdz
OiBhZ2lsZXg1OiBBZGQgY29uZmlndXJhdGlvbiBmb3IgbWFsbG9jIHBvb2wNCj4gPiAgIGFybTog
c29jZnBnYTogc21jOiBBZGQgbWVtb3J5IGNvaGVyZW5jeSBzdXBwb3J0IHRvIG1haWxib3ggY29t
bWFuZA0KPiA+ICAgYXJtOiBzb2NmcGdhOiBhZ2lsZXg1OiBBZGQgU1BMIGZvciBBZ2lsZXg1IFNv
Q0ZQR0ENCj4gPiAgIGNvbmZpZ3M6IHNvY2ZwZ2E6IHNvYzY0OiBhZ2lsZXg1OiBFbmFibGUgWEdN
QUMNCj4gPiAgIGFybTogc29jZnBnYTogc29jNjQ6IEFkZCBzdXBwb3J0IGZvciBib2FyZF9ib290
X29yZGVyKCkNCj4gPg0KPiA+IFRpbmd0aW5nIE1lbmcgKDEpOg0KPiA+ICAgZGRyOiBhbHRlcmE6
IEFkZCBERFIgZHJpdmVyIGZvciBBZ2lsZXg1IHNlcmllcw0KPiA+DQo+ID4gIE1BSU5UQUlORVJT
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMiArDQo+ID4gIGFyY2gvYXJt
L0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ID4gIGFyY2gv
YXJtL2R0cy9zb2NmcGdhX2FnaWxleDUtdS1ib290LmR0c2kgICAgICB8IDY2MCArKysrKysrKysr
KysrKysrKysNCj4gPiAgYXJjaC9hcm0vZHRzL3NvY2ZwZ2FfYWdpbGV4NS5kdHNpICAgICAgICAg
ICAgIHwgICA3ICsNCj4gPiAgLi4uL2FybS9kdHMvc29jZnBnYV9hZ2lsZXg1X3NvY2RrLXUtYm9v
dC5kdHNpIHwgIDMzICsNCj4gPiAgYXJjaC9hcm0vbWFjaC1zb2NmcGdhL01ha2VmaWxlICAgICAg
ICAgICAgICAgIHwgICA2ICsNCj4gPiAgYXJjaC9hcm0vbWFjaC1zb2NmcGdhL2NjdV9uY29yZTMu
YyAgICAgICAgICAgIHwgIDY0ICsrDQo+ID4gIGFyY2gvYXJtL21hY2gtc29jZnBnYS9pbmNsdWRl
L21hY2gvZmlyZXdhbGwuaCB8ICAyMyArLQ0KPiA+ICAuLi4vbWFjaC1zb2NmcGdhL2luY2x1ZGUv
bWFjaC9oYW5kb2ZmX3NvYzY0LmggfCAgIDQgKy0NCj4gPiAgYXJjaC9hcm0vbWFjaC1zb2NmcGdh
L2luY2x1ZGUvbWFjaC9taXNjLmggICAgIHwgICAxICsNCj4gPiAgLi4uL2luY2x1ZGUvbWFjaC9y
ZXNldF9tYW5hZ2VyX3NvYzY0LmggICAgICAgIHwgIDEyICstDQo+ID4gIC4uLi9pbmNsdWRlL21h
Y2gvc3lzdGVtX21hbmFnZXJfc29jNjQuaCAgICAgICB8IDEyOSArKy0tDQo+ID4gIGFyY2gvYXJt
L21hY2gtc29jZnBnYS9sb3dsZXZlbF9pbml0X2FnaWxleDUuUyB8ICA1NyArKw0KPiA+ICBhcmNo
L2FybS9tYWNoLXNvY2ZwZ2EvbWlzYy5jICAgICAgICAgICAgICAgICAgfCAgMjQgKy0NCj4gPiAg
YXJjaC9hcm0vbWFjaC1zb2NmcGdhL21pc2Nfc29jNjQuYyAgICAgICAgICAgIHwgIDEyICstDQo+
ID4gIGFyY2gvYXJtL21hY2gtc29jZnBnYS9zbWNfYXBpLmMgICAgICAgICAgICAgICB8ICAxMyAr
LQ0KPiA+ICBhcmNoL2FybS9tYWNoLXNvY2ZwZ2Evc3BsX2FnaWxleDUuYyAgICAgICAgICAgfCAg
ODQgKysrDQo+ID4gIGFyY2gvYXJtL21hY2gtc29jZnBnYS9zcGxfc29jNjQuYyAgICAgICAgICAg
ICB8IDEyMCArKystDQo+ID4gIGFyY2gvYXJtL21hY2gtc29jZnBnYS91LWJvb3Qtc3BsLXNvYzY0
LmxkcyAgICB8ICA4MCArKysNCj4gPiAgYXJjaC9hcm0vbWFjaC1zb2NmcGdhL3dyYXBfaGFuZG9m
Zl9zb2M2NC5jICAgIHwgIDEwICstDQo+ID4gIGNvbmZpZ3Mvc29jZnBnYV9hZ2lsZXg1X2RlZmNv
bmZpZyAgICAgICAgICAgICB8ICAgNiArDQo+ID4gIGRyaXZlcnMvZGRyL2FsdGVyYS9NYWtlZmls
ZSAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ID4gIGRyaXZlcnMvZGRyL2FsdGVyYS9pb3Nz
bV9tYWlsYm94LmMgICAgICAgICAgICB8IDYxMyArKysrKysrKysrKysrKysrDQo+ID4gIGRyaXZl
cnMvZGRyL2FsdGVyYS9pb3NzbV9tYWlsYm94LmggICAgICAgICAgICB8IDE4NiArKysrKw0KPiA+
ICBkcml2ZXJzL2Rkci9hbHRlcmEvc2RyYW1fYWdpbGV4NS5jICAgICAgICAgICAgfCAzNzcgKysr
KysrKysrKw0KPiA+ICBkcml2ZXJzL2Rkci9hbHRlcmEvc2RyYW1fc29jNjQuYyAgICAgICAgICAg
ICAgfCAgNzggKystDQo+ID4gIGRyaXZlcnMvZGRyL2FsdGVyYS9zZHJhbV9zb2M2NC5oICAgICAg
ICAgICAgICB8ICAzMiArLQ0KPiANCj4gQ2FuIHdlIHBsZWFzZSBwdXQgUkFNIGRyaXZlcnMgaW4g
ZHJpdmVycy9yYW0gPyBBbHNvLCBkbyBtYWtlIHN1cmUgdGhleQ0KPiBhY3R1YWxseSB1c2UgVUNM
QVNTX1JBTQ0KDQpUaGUgUkFNIGhlcmUgbWVhbnMgZm9yIEREUiwgYW5kIFVDTEFTU19SQU0gaXMg
dXNlZCBpbiBERFIgZHJpdmVyLg0KDQpbLi4uXQ0KDQpSZWdhcmRzLA0KVGllbiBGb25nDQo=
