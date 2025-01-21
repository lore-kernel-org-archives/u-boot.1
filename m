Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A8AC02182
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 08:39:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ECE4801F5;
	Tue, 21 Jan 2025 09:39:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="U9uCn/FV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32BCE80326; Tue, 21 Jan 2025 09:39:33 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEBE7800CF
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 09:39:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737448770; x=1768984770;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=elh2LSZEd9Aoh4TSGTtFnnNnNjSwlEK0J3FkE3XxFB0=;
 b=U9uCn/FVyd3rlCmFBOWYFf3jYFtUNiKekw9Eccza8Bn7EZKjhxFd+VAx
 8etE0xKerbs+LbQKWDGnobrHpoYVQA7lKYvCpLa5ZH/PfDe9QAzgFXM9u
 ZSFbIW2j+M+wvfEkl7Ol0xWP4fh6qk2LBDEK9C+8RKptYo1xdsbW8djCL
 naVOnjEvlKSfVT25RuKLl5wyNmNfqmuK/5bPizOCJwe2Zid5OJs1QmIcb
 GbRnWTh0Aw9gKBCANYX+QoNM9i6Ug+HdQ1ozK8+ekwQwOqeccJCKIYbPb
 1WIqZrNH5i9wEireie6gq6SRJUWYXzGFR9nQ3vWTdKtx6dwAVv/LMrDKR Q==;
X-CSE-ConnectionGUID: SI8AlWGgS7etJATJ4I7tIQ==
X-CSE-MsgGUID: 8kAx/QJWToC/QeBc0gAZPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11321"; a="37062162"
X-IronPort-AV: E=Sophos;i="6.13,221,1732608000"; d="scan'208";a="37062162"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2025 00:39:27 -0800
X-CSE-ConnectionGUID: 9LRRZjcwQV2wFbWjJ9lbDA==
X-CSE-MsgGUID: hd5nUzOtTv2mMYVvv8kRjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="130006449"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 Jan 2025 00:39:27 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 21 Jan 2025 00:39:27 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 21 Jan 2025 00:39:27 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 21 Jan 2025 00:39:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZ8LsbGiPftsiQQ4jpEv7zgh39LMzYXjYwsxmQHSqKaxFjtxnSuu6KThhArCvyH5G73er/s5VGTN3887ZlgcaumDwQDmNTWIQ015+srHSVVSFtFn0PwCBjpQliQxHgAJvG/xC/Q0Dwh2jnftxybBJTLwXjn9qoKrgyo4FBY2S35g1nJ//o/61u5oTWNJ77c2I/QtpNLaE3/8cIWsUgaWE6DMJ/1ecjs9NVDhu6b9sLkYbSNUdey0UWA9Le+wXfBDPPLjbca2Mp/YnIFkIdE89O0o5yj9SqortAhkQ0KEkEHDO7ti3/wp4BuNjcqHTviCRuaCvFy6GMwWOnkPSVqriQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elh2LSZEd9Aoh4TSGTtFnnNnNjSwlEK0J3FkE3XxFB0=;
 b=iWw2d1pWftH4aAoab+5tSgT4lyIpc2GzOgtkYm05sGw4XJPU1pgiQlt4ETZItp2Vx6PaQ3aelBGe0j0jYZSgAmT2rdpmCxBcIRnc74OEwsah9/HEJUT4Llw6aJJhDdFt534Olkw6lsL7hnq+OaspEQc+0JYnhl2JemORUh2jQMauHTUHYdOVd22mkvMM/GU6A3NAdTzPpevPrEVh1Ioka3TzhWuWnMhiHzG5loJIOGAkFA8CwuiN+9BkjAksMC7H3+MzcLZkI/bbiqdoTrXvrGzDaJPX7Ix3J+WiAinIJ0polzEFGdzOIXFYvFpCHHKAmWITrN74wABUQwhOI7A3HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5366.namprd11.prod.outlook.com (2603:10b6:208:31c::17)
 by DM4PR11MB7351.namprd11.prod.outlook.com (2603:10b6:8:104::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Tue, 21 Jan
 2025 08:38:43 +0000
Received: from BL1PR11MB5366.namprd11.prod.outlook.com
 ([fe80::f073:1e46:c7ee:df9b]) by BL1PR11MB5366.namprd11.prod.outlook.com
 ([fe80::f073:1e46:c7ee:df9b%3]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 08:38:42 +0000
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
Subject: RE: [resend v2 00/19] Add Cadence NAND Driver support
Thread-Topic: [resend v2 00/19] Add Cadence NAND Driver support
Thread-Index: AQHbRvdcQWgz78qVlUqpVYczLsrbnbLj8XAAgAYr1NCANxKuMA==
Date: Tue, 21 Jan 2025 08:38:42 +0000
Message-ID: <BL1PR11MB536639809DBC02823E22549B82E62@BL1PR11MB5366.namprd11.prod.outlook.com>
References: <20241205092315.25060-1-dinesh.maniyam@intel.com>
 <CAOf5uwmPuQOsfXFPZ6Y35E5dWq=bYJNtKRRyVv0Md+ugiPFyPA@mail.gmail.com>
 <BL1PR11MB5366537A8281795B152B69AD82042@BL1PR11MB5366.namprd11.prod.outlook.com>
In-Reply-To: <BL1PR11MB5366537A8281795B152B69AD82042@BL1PR11MB5366.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5366:EE_|DM4PR11MB7351:EE_
x-ms-office365-filtering-correlation-id: 2a599acc-212b-47a9-bae4-08dd39f70321
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|7416014|366016|376014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?U3BLN1RvUGgyUGE4MDVSVlNOZHR2QTQ4VERMVURnejVURldEeWVMWnRldHd2?=
 =?utf-8?B?TFQyTU9MT3Y1cmd5aHhSZnI5OURGZDBpeUFXZDJiQnhtS0FkWFU0aXZnNjNO?=
 =?utf-8?B?RXlWWW5VRzY4SGw2UlJZM0NkS3Z6RXJrKzhjRTM5bmgvWTNFRGJKdkdOVjhl?=
 =?utf-8?B?TUJrandZZEdSdGM1djBseXNsRklzVFcvaFA5ODJXZHE1Tkh4cDZRbVh3Vi9y?=
 =?utf-8?B?NHVFMDdJOEFabnNta29Ra3NmaGFzNnVsaFFLR0gvdnpUektKMTJvYTVxMFE4?=
 =?utf-8?B?dTcvV0lmclplWnh3REFVS0pPYlJHQlVIYlVSYkhiVVphMHc4cWszSlpNREIy?=
 =?utf-8?B?TVNlWmpZUThTeEhRemY1WURKZTBHOTZQeUdkcG1LVk5HWU8xbnBLaE1yVXl4?=
 =?utf-8?B?OThkYWNYVERWZjNJUExWQmloZmtNRXlGQlQvdDljSDBWaDU0RnRtMHZ1b2Yw?=
 =?utf-8?B?L2liRVRmYVlmb1llbkpQcDE5ekkycWN3NUUvMEFRS1Btc2ZUdnlFd2Nnd1da?=
 =?utf-8?B?Tzl3NUZMbkFqeHlkOVBWUHh6QXpKK1F2UzlCdXRYb0NscjN5WStKWjAzYlhw?=
 =?utf-8?B?bXZ6Y3dLOXV4eFFYWDRWWE5RM2U4L00zV2RHSWhPM1RCSzdIbUlad1pXVmF2?=
 =?utf-8?B?U1gwV3BhRWpWSjhhWnh3dG94RjlaOWYvVVdTdXBzQ014T1ZrR0dHNytMdnVE?=
 =?utf-8?B?cXJBeUJGM09POFZuMUg4TzlXQlBYK2M3ZWRQcjdUMnUxRGNnd1VSVjhBdkty?=
 =?utf-8?B?YS8zZGNFNjRDWU1OdDROSjNSdzVsNlVHN3VUVitwazNPSkRQZ3JpajlZMTM5?=
 =?utf-8?B?Rkk3bEp2clRRYzljV3VDZy91K0JnZzU1ZFhJUld0a2czcGNIem5STGlobjAx?=
 =?utf-8?B?cXZMeEQ4S3N5dGhjOTFKL0ZWdWJKc3d1cXFEUkEwYnNiZlU1bG1BV2xuRVB4?=
 =?utf-8?B?UjhsbVluRVU2Rlc2Y1paVk9ld0pYanlOVjNzSThMTzR4MXpCY0RXaGdYbklR?=
 =?utf-8?B?OEEya0Ryay9JclhqY3JoNU5KS0pPb1ZBeStlZld4SEY3V3NlbGFFa2t0U2Ix?=
 =?utf-8?B?OHZaeGZtd1RkSU9TZC83alMxQW5wUHZTZUpOMlhMNUVDR3ExYTdtQk9lS0V5?=
 =?utf-8?B?Z0kwYXdFQ3JScTB3WklLU1kyU2NTNmtyNW42RzcyNmxoWlVSWC9Damd4OFFF?=
 =?utf-8?B?WnQzNi8vT3Q1MU96SFRtQ0d3UGI2UHNWR1dOUFAvYWlyc1IxWFlEZkpkSno5?=
 =?utf-8?B?dUZMdzVWOXZ0TGJXNjdVS3lXZCtKYlVtYmNFTkVyRVdNMit4bS9FTFlPbXlh?=
 =?utf-8?B?c2ppeGRwalpHUmlQUFllQ2hIOUJ2dWVZemU4elgrZDcwNDcraDNaVmJNM2VR?=
 =?utf-8?B?cVZlRGdYQ1lYS1FvbFArT3BCQk9WSVovdmViTTVKNnlyMjBLSDFmajdMVy9r?=
 =?utf-8?B?dWQwcmNGSHljNXpORXgxYXJ2QTVYWkJKZEVVUnpLeEk0VW45MVpnRFdoOCtp?=
 =?utf-8?B?RTFYOGQxa2RsL1l4MFpxVmVJS1V6YXRKYUFqQzZGL0Z4b3RkYVEyNW9ybm9m?=
 =?utf-8?B?dENWbXJDM3g0SmQ3UU8xYUpzNjZKT1orVzlrTHZFdzkrM3dkQmV5L2hldXUv?=
 =?utf-8?B?dVJvT3VaNmNtMVppYmpxNHN5Wjc4OU1vV0dYVXh3dVNQdCt1TnpSUHE0eERv?=
 =?utf-8?B?RjJUY1hMcmVCcnYzSTNXN3BDTEJhVlhpMmJvWmRrZmpqN1BVaDdvQ1dxaHNq?=
 =?utf-8?B?V1BRMmZKMnZrbWdFV1ByK0FyKzhRY0lqMTlRbEVYYjlESVM4dEg1S3dWQlFQ?=
 =?utf-8?B?aGpRWjhrcGZxK3UzNVlNZmVldnovdFN4QVhsR3FsWVFSN0NMaXJ1TXV4aE5S?=
 =?utf-8?Q?x97C8CODKDpsa?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR11MB5366.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(366016)(376014)(1800799024)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGdEOVlrNmZpNzRGYUdXeFJlTTRYdVBPQUNJc3pzaW45ejFQcitpYUdLVVpC?=
 =?utf-8?B?WDQybkFmT3ZXdlBNdm9LUnA3VnpoTWRBdlNURFUwa3VadGdSbVQxRVpaVlB2?=
 =?utf-8?B?a0tFSjJ1TjF3aUhMZjc4WVo4bUViSXZUVW1jdTdUcmNqdytLTmNSMk9oZDJR?=
 =?utf-8?B?cHhrdC9WR1EwbjVtODNLL2hTVERSZ1RBRWRtaXZGcTNvZzdaMTVvSEZvYXZj?=
 =?utf-8?B?UmpIME0wU1ZreFlsSzlZaW1DTklvMUkvQTMxRjlnb3FsVHVQRCtCYzd3VVVU?=
 =?utf-8?B?SkpEMU0zd1pNOUg4c2Zsa0NsRTV0NTRTRnVwa3JUNFh2REJuN1Y1WHlsLys1?=
 =?utf-8?B?YU15Zi96cnE1NjNIRkNOVE1DU2VZMjVRTzVHYTUyL2tJcXAvUmY5UDFlZWM4?=
 =?utf-8?B?Q1hDTmdDZERkNWxQQVNScXdtcGh6UmhCZnJERS9IYThBM3pjdmt6MTJkdjZD?=
 =?utf-8?B?M013WTBjVWFOa2JoeG9NYWEvSHRLbEdCRFBQUGVPSEdkMzIzMzhuSk9GUTVN?=
 =?utf-8?B?SkEvWllSMGRwT2l2RDhvQzVxNG5XMkIxbDFodGh1VkNoY002MWUyZGVhZVZu?=
 =?utf-8?B?Y3lwZ2xFR0x2L1RpWUhJZkIzYnp5MVpOekZlbnZqVHdKcGNxZG8vQnRneVdH?=
 =?utf-8?B?SUliNGsxMkZKWEs3M21ZRkVqN1l6cjNaZ0Q3VjY0Z0tSMDZMeGRJMVBWQm9I?=
 =?utf-8?B?WUJUUlM0c2dtbjRjOE4xNm1wUVFTOTg5OWZGeXIzdnprbGYrdXl6WDlENGp3?=
 =?utf-8?B?SUJxaEwzcjdleTEvTlRSOXpXcXdIb0h0blRITzJJb01sbm5EUURGTUlXQmxr?=
 =?utf-8?B?YVdJY0ZuVitVMThzWmJCN2dzVjREY3g0eHpXYU1CMHR3Q1gvZjZ5MUlMejZ6?=
 =?utf-8?B?OTh5VXgrenduVXgxU05ZVEJlTUdtTW5aY2RNeEZqS01iV1VQUXBVaEhOUWhM?=
 =?utf-8?B?N1JLeUJGNTk0OEJoL1YwSlVyVVBnaGF3dFEvM1N3N1d1ZWxaTzZaekYxTklv?=
 =?utf-8?B?TnJPSmlBNEVJc3NiSE5obVROaTRLdXIxM1VCYTJnbGZlcUNsQkk3blhDRk5q?=
 =?utf-8?B?Qno4enBWZG91NHJuUGZQMTBVU1VMUXoxRlRjTGlHSG9aNHR5T0J3MFpSU2Y0?=
 =?utf-8?B?MlJOM0pJZUpEUW42SGlDWHloeTdSYlMxSzYyajdzMGlsbmI1bDNwOGEvRHlm?=
 =?utf-8?B?S2VkTTRGcUV4TXlyUktUVituSmp6c2ZCQms2M3FhQ2JjMGdKWkhiRE1sOHcv?=
 =?utf-8?B?enpOUUV4ME83eEgzMjI4YTltUHpyNlhIRXpWa0VlM3ZKUlV5NkY5U2k3N1pU?=
 =?utf-8?B?aDkrT0pTUUxRMW1KaTVobW1kV3dNQ2tDRmRvNlFiTFZ0WmxPMGQ0ZTNMN2gx?=
 =?utf-8?B?elV5Vk9mQTVEY2JYYUN5VzZFVGRHYWJJb0RheWxRMEpiTnJaek9LbUdKemNk?=
 =?utf-8?B?UXRrSnVEcjFNMWF6RzIyQ1lIb2lKMEswbitCU3FIR1pWWmUrUnBXUmY1S0xL?=
 =?utf-8?B?OUZ6NmFjbnpVbHJPWDQzNW1GcEl4b2lqWEQxTGYzQ3Rxc2ExVkpsZTc3bzBl?=
 =?utf-8?B?M1RmQmhKQTk1T2JYUGRXSkxpMDBMZ05jajRORXFLczdHbXcraDhoTE84NTgz?=
 =?utf-8?B?eWhRbWdlVHZhS3BmK0FTemVvekhCOVgwSzhYMGlEWFBCN21zL1oxaVFWM0NW?=
 =?utf-8?B?VUVHdTFoNFEyVVRUWFlJZjhLT0F4bHIrQ3ZDQ0pHbXNFYzFOU2tBM1VqdHNK?=
 =?utf-8?B?SU9HWk5kc0pEaGpwL0xURkxrbyszQW1ld2xzSFNQaEIrOXRwYjVDcWhNa2o3?=
 =?utf-8?B?aG9VQlFlUVVUZlZuREozOGNrYWtHN2JlUUR1OWNyZWFCQ0prRXFzUitFbXNV?=
 =?utf-8?B?TTI4WEdoZDVGN1dnRk41d3hpWmwzQmlPQkdPb2UwelNwSGNuSXc5dDlaM3Jt?=
 =?utf-8?B?eDF5d2w5ampvZGNJZHd3WXFDZHNuR0hVcldUS2xSV3RmNkpRZGNHN1V5enpH?=
 =?utf-8?B?bkNTNXpkaFV1bGdicUVPKzA0S1YyRWZQS2piSzVIRGtKZ0g0UDFmSzZaVFUy?=
 =?utf-8?B?QjZDQzVzTWtRL1lyVmFpOW9tLzA2d2g2OG56MVpZUHc3MHRmVElLd256UFUw?=
 =?utf-8?B?RnRJODZqLzV6bVY0ejFUWWlJS3JFL0pOYjBUOVJEeVU2QXhIQmM1ZlcxMWNr?=
 =?utf-8?Q?liBEBAj8pD9lYrbvNxyOG/EgKg1O9RPTF1fhUJEIk9St?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a599acc-212b-47a9-bae4-08dd39f70321
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2025 08:38:42.8200 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EEsKHRg7sbOpZWdVzy3cixO24HmQWpQvgNjx9ZHzyrdKzvGXc0Ik2bGrHebGU9OxomrXkFoWlll/AtU0pzMQhIzr5N0ESe27WN6BlYa0d1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7351
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

SGkgTWljaGFlbCwNCg0KQW55IHVwZGF0ZSBvbiBteSBOQU5EIHBhdGNoc2V0ID8uIEkgY2FuIHNl
ZSBpdCBpcyBzdGlsbCB1bmRlciByZXZpZXcuDQpJcyB0aGVyZSBhbnl0aGluZyBJIGNhbiBkbyBm
cm9tIG15IHNpZGUgdG8gc3BlZWQgdXAgdGhlIHJldmlldyBwcm9jZXNzPw0KVGhhbmtzIGZvciB5
b3VyIHRpbWUuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFuaXlh
bSwgRGluZXNoDQo+IFNlbnQ6IFR1ZXNkYXksIDE3IERlY2VtYmVyIDIwMjQgMzo0MSBwbQ0KPiBU
bzogTWljaGFlbCBOYXp6YXJlbm8gVHJpbWFyY2hpIDxtaWNoYWVsQGFtYXJ1bGFzb2x1dGlvbnMu
Y29tPg0KPiBDYzogdS1ib290QGxpc3RzLmRlbnguZGU7IE1hcmVrIDxtYXJleEBkZW54LmRlPjsg
U2ltb24NCj4gPHNpbW9uLmsuci5nb2xkc2NobWlkdEBnbWFpbC5jb20+OyBUb20gUmluaSA8dHJp
bmlAa29uc3Vsa28uY29tPjsgRGFyaW8NCj4gQmluYWNjaGkgPGRhcmlvLmJpbmFjY2hpQGFtYXJ1
bGFzb2x1dGlvbnMuY29tPjsgSm9oYW4gSm9ua2VyDQo+IDxqYng2MjQ0QGdtYWlsLmNvbT47IE1p
Y2hhbCBTaW1layA8bWljaGFsLnNpbWVrQGFtZC5jb20+OyBBcnNlbml5DQo+IEtyYXNub3YgPGF2
a3Jhc25vdkBzYWx1dGVkZXZpY2VzLmNvbT47IEFsZXhhbmRlciBEYWhsIDxhZGFAdGhvcnNpcy5j
b20+Ow0KPiBXaWxsaWFtIFpoYW5nIDx3aWxsaWFtLnpoYW5nQGJyb2FkY29tLmNvbT47IElnb3Ig
UHJ1c292DQo+IDxpdnBydXNvdkBzYWx1dGVkZXZpY2VzLmNvbT47IE1lbmcsIFRpbmd0aW5nIDx0
aW5ndGluZy5tZW5nQGludGVsLmNvbT47DQo+IENoZWUsIFRpZW4gRm9uZyA8dGllbi5mb25nLmNo
ZWVAaW50ZWwuY29tPjsgSGVhLCBLb2sgS2lhbmcNCj4gPGtvay5raWFuZy5oZWFAaW50ZWwuY29t
PjsgTmcsIEJvb24gS2hhaSA8Qm9vbi5LaGFpLk5nQGludGVsLmNvbT47IFl1c2xhaW1pLA0KPiBB
bGlmIFpha3VhbiA8YWxpZi56YWt1YW4ueXVzbGFpbWlAaW50ZWwuY29tPjsgWmFtcmksIE11aGFt
bWFkIEhhemltIEl6emF0DQo+IDxtdWhhbW1hZC5oYXppbS5penphdC56YW1yaUBpbnRlbC5jb20+
OyBMaW0sIEppdCBMb29uDQo+IDxqaXQubG9vbi5saW1AaW50ZWwuY29tPjsgVGFuZywgU2lldSBN
dW4gPFNpZXUuTXVuLlRhbmdAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSRTogW3Jlc2VuZCB2MiAw
MC8xOV0gQWRkIENhZGVuY2UgTkFORCBEcml2ZXIgc3VwcG9ydA0KPiANCj4gDQo+IA0KPiA+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogTWljaGFlbCBOYXp6YXJlbm8gVHJp
bWFyY2hpIDxtaWNoYWVsQGFtYXJ1bGFzb2x1dGlvbnMuY29tPg0KPiA+IFNlbnQ6IEZyaWRheSwg
MTMgRGVjZW1iZXIgMjAyNCA1OjE2IHBtDQo+ID4gVG86IE1hbml5YW0sIERpbmVzaCA8ZGluZXNo
Lm1hbml5YW1AaW50ZWwuY29tPg0KPiA+IENjOiB1LWJvb3RAbGlzdHMuZGVueC5kZTsgTWFyZWsg
PG1hcmV4QGRlbnguZGU+OyBTaW1vbg0KPiA+IDxzaW1vbi5rLnIuZ29sZHNjaG1pZHRAZ21haWwu
Y29tPjsgVG9tIFJpbmkgPHRyaW5pQGtvbnN1bGtvLmNvbT47DQo+ID4gRGFyaW8gQmluYWNjaGkg
PGRhcmlvLmJpbmFjY2hpQGFtYXJ1bGFzb2x1dGlvbnMuY29tPjsgSm9oYW4gSm9ua2VyDQo+ID4g
PGpieDYyNDRAZ21haWwuY29tPjsgTWljaGFsIFNpbWVrIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47
IEFyc2VuaXkNCj4gPiBLcmFzbm92IDxhdmtyYXNub3ZAc2FsdXRlZGV2aWNlcy5jb20+OyBBbGV4
YW5kZXIgRGFobA0KPiA+IDxhZGFAdGhvcnNpcy5jb20+OyBXaWxsaWFtIFpoYW5nIDx3aWxsaWFt
LnpoYW5nQGJyb2FkY29tLmNvbT47IElnb3INCj4gPiBQcnVzb3YgPGl2cHJ1c292QHNhbHV0ZWRl
dmljZXMuY29tPjsgTWVuZywgVGluZ3RpbmcNCj4gPiA8dGluZ3RpbmcubWVuZ0BpbnRlbC5jb20+
OyBDaGVlLCBUaWVuIEZvbmcgPHRpZW4uZm9uZy5jaGVlQGludGVsLmNvbT47DQo+ID4gSGVhLCBL
b2sgS2lhbmcgPGtvay5raWFuZy5oZWFAaW50ZWwuY29tPjsgTmcsIEJvb24gS2hhaQ0KPiA+IDxi
b29uLmtoYWkubmdAaW50ZWwuY29tPjsgWXVzbGFpbWksIEFsaWYgWmFrdWFuDQo+ID4gPGFsaWYu
emFrdWFuLnl1c2xhaW1pQGludGVsLmNvbT47IFphbXJpLCBNdWhhbW1hZCBIYXppbSBJenphdA0K
PiA+IDxtdWhhbW1hZC5oYXppbS5penphdC56YW1yaUBpbnRlbC5jb20+OyBMaW0sIEppdCBMb29u
DQo+ID4gPGppdC5sb29uLmxpbUBpbnRlbC5jb20+OyBUYW5nLCBTaWV1IE11biA8c2lldS5tdW4u
dGFuZ0BpbnRlbC5jb20+DQo+ID4gU3ViamVjdDogUmU6IFtyZXNlbmQgdjIgMDAvMTldIEFkZCBD
YWRlbmNlIE5BTkQgRHJpdmVyIHN1cHBvcnQNCj4gPg0KPiA+IEhpDQo+ID4NCj4gPiBPbiBUaHUs
IERlYyA1LCAyMDI0IGF0IDEwOjIz4oCvQU0gPGRpbmVzaC5tYW5peWFtQGludGVsLmNvbT4gd3Jv
dGU6DQo+ID4gPg0KPiA+ID4gRnJvbTogRGluZXNoIE1hbml5YW0gPGRpbmVzaC5tYW5peWFtQGlu
dGVsLmNvbT4NCj4gPiA+DQo+ID4gPiBUaGlzIHBhdGNoc2V0IGFkZCBDYWRlbmNlIE5BTkQgZHJp
dmVyIHN1cHBvcnQgZm9yIEludGVsIEFnaWxleDUNCj4gPiA+IGRldmljZXMuDQo+ID4gPg0KPiA+
ID4gVGhlIE5BTkQgZHJpdmVyIGlzIGxldmVyYWdlZCBmcm9tIHRoZSBjYWRlbmNlLW5hbmQtY29u
dHJvbGxlci5jIGZyb20NCj4gPiA+IExpbnV4IHZlcnNpb24gNi4xMS4yLiBVLUJvb3Qgd2lsbCBz
dXBwb3J0IHJlYWQsIHdyaXRlIGFuZCBlcmFzZSBOQU5EDQo+ID4gPiB3aXRoIENhZGVuY2UgZHJp
dmVyLiBUaGUgZHJpdmVyIGZ1cnRoZXIgZW5oYW5jZWQgaW4gVS1Cb290IHRvDQo+ID4gPiBzdXBw
b3J0IE5BTkQgYm9vdGluZyBmcm9tIEZTQkwgYW5kIHN1cHBvcnQgYm9vdCB0byBrZXJuZWwgdmlh
IFVCSUZTLg0KPiA+ID4NCj4gPiA+IFBhdGNoIHN0YXR1czoNCj4gPiA+IEhhdmUgY2hhbmdlczog
QWxsIHBhdGNoZXMgZXhwZWN0IFBhdGNoIDE5DQo+ID4gPg0KPiA+ID4gRGV0YWlsIGNoYW5nZWxv
ZyBjYW4gZmluZCBpbiBjb21taXQgbWVzc2FnZS4NCj4gPiA+DQo+ID4gPiB2MS0+djI6DQo+ID4g
PiAtLS0tLS0tLQ0KPiA+ID4gUGF0Y2ggMSAtIDE4Og0KPiA+ID4NCj4gPiA+IC0gcmVtb3ZlIHRo
ZSAidGhpcyBwYXRjaCBpcyB0byIgY29tbWl0IHBocmFzZXMNCj4gPiA+DQo+ID4gPiBQYXRjaCA0
Ow0KPiA+ID4gLSBtaW5vciByZWZhY3RvcmluZyBvZiBjb2RlIHRvIG1hdGNoIHRoZSBzdGFibGUg
dmVyc2lvbiA2LjExLjIuDQo+ID4gPg0KPiA+ID4gUGF0Y2ggMTQ6DQo+ID4gPiAtIEFkZCBtYWlu
dGFpbmVyIGFuZCAiI2luY2x1ZGUiIG1lY2hhbmlzbSBmb3IgbmV3IHZhcmlhbnQNCj4gPiA+DQo+
ID4gPiBQYXRjaCAxNjoNCj4gPiA+IC0gbGV2ZXJhZ2UgdGhlIGV4aXN0aW5nIG5hbmRfc3BsX2xv
YWRfaW1hZ2UNCj4gPiA+DQo+ID4NCj4gPiBJIGhhdmUgdHJpZWQgdG8gYnVpbGQgYnV0IGl0IGRv
ZXMgbm90IHdvcmsuIEhhdmUgeW91IHRlc3RlZCBpbiBnaXRodWI/DQo+ID4NCj4gPiBNaWNoYWVs
DQo+IA0KPiBZZXQgdG8gZGVwbG95IGdpdGh1YiB0ZXN0IG9uIG91ciBjdXJyZW50IHBsYXRmb3Jt
Lg0KPiBPbmx5IGNoZWNrcGF0Y2gucGwgYW5kIGxvY2FsIGJ1aWx0IGhhcyBiZWVuIHVzZWQgYXMg
YcKgbWV0cmljIGZvciBlYWNoIGNvbW1pdA0KPiBiZWZvcmUgc3VibWlzc2lvbi4NCj4gQW5kLCBh
bGwgdGhlc2UgY29tbWl0cyBhcmUgcGFydCBvZiB0aGUgZmlybXdhcmXCoGN1cnJlbnRseSBydW5u
aW5nIG9uIHJlYWwNCj4gaGFyZHdhcmUuDQo+IA0KPiA+DQo+ID4gPiBIaXN0b3J5Og0KPiA+ID4g
LS0tLS0tLS0NCj4gPiA+IFt2MV06DQo+ID4gPiBodHRwczovL3BhdGNod29yay5vemxhYnMub3Jn
L3Byb2plY3QvdWJvb3QvY292ZXIvMjAyNDA5MTkwMzU1MTIuMTM4NQ0KPiA+ID4gNC0NCj4gPiA+
IDEtZGluZXNoLm1hbml5YW1AaW50ZWwuY29tLw0KPiA+ID4NCj4gPiA+IERpbmVzaCBNYW5peWFt
ICgxOSk6DQo+ID4gPiAgIGR0OiBuYW5kOiBhZGQgY2FkZW5jZSBuYW5kIGR0LWJpbmRpbmdzDQo+
ID4gPiAgIGFybTogZHRzOiBhZ2lsZXg1OiBFbmFibGVkIGNkbnMtbmFuZCBkdHMgc2V0dGluZw0K
PiA+ID4gICBpbmNsdWRlOiBhc206IEFkZCBzdXBwb3J0IHRvIHJlYWQvd3JpdGUgNjQtYml0DQo+
ID4gPiAgIGRyaXZlcnM6IG10ZDogbmFuZDogQWRkIGRyaXZlciBmb3IgQ2FkZW5jZSBOYW5kDQo+
ID4gPiAgIGRyaXZlcnM6IG10ZDogbmFuZDogY2FkZW5jZTogQWRkIHN1cHBvcnQgZm9yIHJlYWQg
c3RhdHVzIGNvbW1hbmQNCj4gPiA+ICAgZHJpdmVyczogbXRkOiBuYW5kOiBjYWRlbmNlOiBBZGQg
c3VwcG9ydCBmb3IgcmVhZGlkIGNvbW1hbmQNCj4gPiA+ICAgZHJpdmVyczogbXRkOiBuYW5kOiBj
YWRlbmNlOiBBZGQgc3VwcG9ydCBmb3IgTkFORF9DTURfUEFSQU0NCj4gPiA+ICAgZHJpdmVyczog
bXRkOiBuYW5kOiBjYWRlbmNlOiBBZGQgc3VwcG9ydCBmb3IgTkFORF9DTURfUkVTRVQNCj4gPiA+
ICAgZHJpdmVyczogbXRkOiBuYW5kOiBjYWRlbmNlOiBTdXBwb3J0IGNtZCBTRVRfRkVBVFVSRVMg
JiBHRVRfRkVBVFVSRVMNCj4gPiA+ICAgZHJpdmVyczogbXRkOiBuYW5kOiBjYWRlbmNlOiBGbHVz
aCAmIGludmFsaWRhdGUgZG1hIGRlc2NyaXB0b3INCj4gPiA+ICAgZHJpdmVyczogbXRkOiBuYW5k
OiBjYWRlbmNlOiBQb2xsIGZvciBkZXNjIGNvbXBsZXRlIHN0YXR1cw0KPiA+ID4gICBkcml2ZXJz
OiBtdGQ6IG5hbmQ6IGNhZGVuY2U6IFVzZSBib3VuY2UgYnVmZmVyDQo+ID4gPiAgIGRyaXZlcnM6
IG5hbmQ6IEVuYWJsZWQgS2NvbmZpZyBhbmQgTWFrZWZpbGUgZm9yIGNkbnMtbmFuZA0KPiA+ID4g
ICBjb25maWdzOiBuYW5kMl9kZWZjb25maWc6IEVuYWJsZSBjb25maWdzIGZvciBuYW5kIGJvb3QN
Cj4gPiA+ICAgZHJpdmVyczogbXRkOiBuYW5kOiBiYXNlOiBBZGQgc3VwcG9ydCBmb3IgSGFyZHdh
cmUgRUNDIGZvciBjaGVjayBiYWQNCj4gPiA+ICAgICBibG9jaw0KPiA+ID4gICBkcml2ZXJzOiBt
dGQ6IG5hbmQ6IHNwbDogQWRkIHN1cHBvcnQgZm9yIG5hbmQgU1BMIGxvYWQgaW1hZ2UNCj4gPiA+
ICAgZHJpdmVyczogbXRkOiBuYW5kOiBFbmFibGVkIEtjb25maWcgYW5kIE1ha2VmaWxlIGZvciBD
YWRlbmNlLVNQTA0KPiA+ID4gICBkcml2ZXJzOiBtdGQ6IG5hbmQ6IEtjb25maWc6IFJlbW92ZSBT
WVNfTkFORF9CTE9DS19TSVpFIGRlcGVuZGVuY3kNCj4gPiA+ICAgZHJpdmVyczogbXRkOiBuYW5k
OiBLY29uZmlnOiBFbmFibGVkIHNlbGYtaW5pdCBmb3IgY2Rucy1uYW5kIFNQTA0KPiA+ID4NCj4g
PiA+ICBhcmNoL2FybS9kdHMvc29jZnBnYV9hZ2lsZXg1LmR0c2kgICAgICAgICAgICAgfCAgIDE0
ICsNCj4gPiA+ICAuLi4vYXJtL2R0cy9zb2NmcGdhX2FnaWxleDVfc29jZGstdS1ib290LmR0c2kg
fCAgIDI4ICsNCj4gPiA+ICBhcmNoL2FybS9pbmNsdWRlL2FzbS9pby5oICAgICAgICAgICAgICAg
ICAgICAgfCAgIDI1ICsNCj4gPiA+ICBib2FyZC9pbnRlbC9hZ2lsZXg1LXNvY2RrL01BSU5UQUlO
RVJTICAgICAgICAgfCAgICAyICsNCj4gPiA+ICBjb25maWdzL3NvY2ZwZ2FfYWdpbGV4NV9uYW5k
Ml9kZWZjb25maWcgICAgICAgfCAgIDMzICsNCj4gPiA+ICAuLi4vbXRkL2NhZGVuY2UsbmFuZC55
YW1sICAgICAgICAgICAgICAgICAgICAgfCAgIDk4ICsNCj4gPiA+ICBkcml2ZXJzL210ZC9uYW5k
L3Jhdy9LY29uZmlnICAgICAgICAgICAgICAgICAgfCAgIDE5ICstDQo+ID4gPiAgZHJpdmVycy9t
dGQvbmFuZC9yYXcvTWFrZWZpbGUgICAgICAgICAgICAgICAgIHwgICAgMiArDQo+ID4gPiAgZHJp
dmVycy9tdGQvbmFuZC9yYXcvY2FkZW5jZV9uYW5kLmMgICAgICAgICAgIHwgMjQyNCArKysrKysr
KysrKysrKysrKw0KPiA+ID4gIGRyaXZlcnMvbXRkL25hbmQvcmF3L2NhZGVuY2Vfc3BsLmMgICAg
ICAgICAgICB8ICAgNTkgKw0KPiA+ID4gIGRyaXZlcnMvbXRkL25hbmQvcmF3L25hbmRfYmFzZS5j
ICAgICAgICAgICAgICB8ICAgNzEgKy0NCj4gPiA+ICBpbmNsdWRlL2NhZGVuY2UtbmFuZC5oICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgNTI5ICsrKysNCj4gPiA+ICBpbmNsdWRlL2xpbnV4L210
ZC9yYXduYW5kLmggICAgICAgICAgICAgICAgICAgfCAgIDE0ICsNCj4gPiA+ICAxMyBmaWxlcyBj
aGFuZ2VkLCAzMjkzIGluc2VydGlvbnMoKyksIDI1IGRlbGV0aW9ucygtKSAgY3JlYXRlIG1vZGUN
Cj4gPiA+IDEwMDY0NCBjb25maWdzL3NvY2ZwZ2FfYWdpbGV4NV9uYW5kMl9kZWZjb25maWcNCj4g
PiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZG9jL2RldmljZS10cmVlLWJpbmRpbmdzL210ZC9jYWRl
bmNlLG5hbmQueWFtbA0KPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL210ZC9uYW5k
L3Jhdy9jYWRlbmNlX25hbmQuYw0KPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL210
ZC9uYW5kL3Jhdy9jYWRlbmNlX3NwbC5jDQo+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1
ZGUvY2FkZW5jZS1uYW5kLmgNCj4gPiA+DQo+ID4gPiAtLQ0KPiA+ID4gMi4xOS4wDQo+ID4gPg0K
PiA+DQo+ID4NCj4gPiAtLQ0KPiA+IE1pY2hhZWwgTmF6emFyZW5vIFRyaW1hcmNoaQ0KPiA+IENv
LUZvdW5kZXIgJiBDaGllZiBFeGVjdXRpdmUgT2ZmaWNlcg0KPiA+IE0uICszOSAzNDcgOTEzIDIx
NzANCj4gPiBtaWNoYWVsQGFtYXJ1bGFzb2x1dGlvbnMuY29tDQo+ID4gX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXw0KPiA+DQo+ID4gQW1hcnVsYSBTb2x1dGlvbnMgQlYNCj4gPiBK
b29wIEdlZXNpbmt3ZWcgMTI1LCAxMTE0IEFCLCBBbXN0ZXJkYW0sIE5MIFQuICszMSAoMCk4NSAx
MTEgOTE3Mg0KPiA+IGluZm9AYW1hcnVsYXNvbHV0aW9ucy5jb20gd3d3LmFtYXJ1bGFzb2x1dGlv
bnMuY29tDQo=
