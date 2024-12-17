Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09919E7716A
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 07:41:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39A68801CF;
	Tue, 17 Dec 2024 08:41:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Mod138tz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01ED68020C; Tue, 17 Dec 2024 08:40:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FA02801CE
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 08:40:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734421254; x=1765957254;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=8mO4yrsn8OISygoTephpaKisf6MjyzCyLaTC2vAfnOU=;
 b=Mod138tzTZsLYdIh5bS+J/moZlBpVHsFuMv6kwCHwJlSEpSXiIWT2IJZ
 sbnqi7QaZkCsPA3YbNM7CxnD3i6aQ7KcfTvDmobqlMOXLdh/ek1petWDR
 bIEUJVacIrbKDk9mDXZ1FPxnXMbptg0VB4kvax5C7MyMuvqEzRVhDNwpR
 HTVvLYTjbJDicwCkXcHs8p5anh84YUudPfyFn2kpxb39eRuroH0fzSYPw
 frS3Avdd56P8FBJHKxLQD7BVKfx+v+pn0uIOp+vCWULlH7Re5tqWPUWGV
 dbfJ5kX+B1yXcNM8SKN4UbCdAvWOeC31UMm3ilvwvXnnaMWGir5768C65 g==;
X-CSE-ConnectionGUID: a4coHhaeQxKsYqvUHTLyQg==
X-CSE-MsgGUID: x5PSLVP/QPuhsdPZMg9mGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="34870268"
X-IronPort-AV: E=Sophos;i="6.12,241,1728975600"; d="scan'208";a="34870268"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2024 23:40:52 -0800
X-CSE-ConnectionGUID: 2YsozuOpTcWd+MN3PAT/rg==
X-CSE-MsgGUID: zwSmQ/CCSy+d9/9IQlEd/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,241,1728975600"; d="scan'208";a="97334565"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 16 Dec 2024 23:40:51 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 16 Dec 2024 23:40:50 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 16 Dec 2024 23:40:50 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 16 Dec 2024 23:40:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SzJXCPjM0F/3hMKi0iLRfFk68veTM+NkdVxKnqmhzahsR2b1CeqCGDqnYbmveB08ysbnSOERlhXM3xHiTq4hxGciXsJoARds+mo30UbW6ImwLq4r0m9/UyD+5wcg8MGWOHG7/qiWEyZMS0GvnrDwuna/pb51KT9/TDYECrFRYdlVBtaCwhq7j8+XQ/E9mffD9sDB2aNwqy/r1nUijYB5mrPab9x2S6UFQtGm+ym5Mi9vtEO6QqcIkoI1T1NMz7BbKnRc2g3NmCW5hPx/cy4EWeX9zaf/VPfhyxDCBS0X1LBmzcdLjayRqIPVCgFewNN5u0kAZjkAkE4sQHuuGFF8HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mO4yrsn8OISygoTephpaKisf6MjyzCyLaTC2vAfnOU=;
 b=MnVvh0eUP130NYTQCw0Nho0kJa7fPGShzu0D+jTHQ3qJk5JZBwrJCqQ1+h5+1niTKcK0M/ayHYnP3gOXxU88KcZi8pj+fw/xS4VcsOfZVXGN55UdZvDPkcXn1EUf4qOrjcgR9BV/KJ7ihyttEW5dlPmYgYikHqFgVJ3YfgZnxGAkxGHh/CWb+odpIUBmF9uCPd5VpxcvIrfT6blUW221VeJu2o+l8aSAro85oTSK6p43KLydT6tLfKL1gVQYM6TILT788ZgGBVCOSFi3PIFslDaiAGZpOlK4dEywspI0utkU34S4J9yu3Z+EFuhpjTXZKlDo6IP5L5XqE/OF4aKxzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5366.namprd11.prod.outlook.com (2603:10b6:208:31c::17)
 by PH0PR11MB4821.namprd11.prod.outlook.com (2603:10b6:510:34::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Tue, 17 Dec
 2024 07:40:35 +0000
Received: from BL1PR11MB5366.namprd11.prod.outlook.com
 ([fe80::f073:1e46:c7ee:df9b]) by BL1PR11MB5366.namprd11.prod.outlook.com
 ([fe80::f073:1e46:c7ee:df9b%5]) with mapi id 15.20.8272.005; Tue, 17 Dec 2024
 07:40:34 +0000
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
Thread-Index: AQHbRvdcQWgz78qVlUqpVYczLsrbnbLj8XAAgAYr1NA=
Date: Tue, 17 Dec 2024 07:40:34 +0000
Message-ID: <BL1PR11MB5366537A8281795B152B69AD82042@BL1PR11MB5366.namprd11.prod.outlook.com>
References: <20241205092315.25060-1-dinesh.maniyam@intel.com>
 <CAOf5uwmPuQOsfXFPZ6Y35E5dWq=bYJNtKRRyVv0Md+ugiPFyPA@mail.gmail.com>
In-Reply-To: <CAOf5uwmPuQOsfXFPZ6Y35E5dWq=bYJNtKRRyVv0Md+ugiPFyPA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5366:EE_|PH0PR11MB4821:EE_
x-ms-office365-filtering-correlation-id: 52566676-184d-4f43-51c0-08dd1e6e1792
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?aUVVd3VkWGNmdk9xSHE1TjFmU3FPaGViWUU0TGcweHU5RDd0WFg3aVRBR0Fr?=
 =?utf-8?B?SmRtNyswR1QrZlU1UzJnODdhSmhvM0FEY1J0VjZ3eDAzeE1PQ1EvUXNUdnJI?=
 =?utf-8?B?dHl1ZUdXRnNMWFN0d1ZrbGxpUHFJaEJPdmxDVzVkTmlaTWJ0UXBaRkdiK3Ji?=
 =?utf-8?B?VEk1MzhTREVzUXd0RXMrandoOTBTazdEck1mVjNhV2VBT0dHaUtVeFcxcGQz?=
 =?utf-8?B?cWgrZUhNR04rSUZRa29MR01TNlR1Q3lZTFJFOHN3OFBlYW1ad2V6SnBNTjVr?=
 =?utf-8?B?ZFdZT2xZYUszZEJ3MSt5WXAxOEdJTEJLa2JhT3B4bUhjQnBOZ0pGU1dmY29z?=
 =?utf-8?B?bi82dUZ6TCswYS9OUEM5SWpkKzdPTklyTE9XZndGdVNnUk9hQ0tIWHRCRjZQ?=
 =?utf-8?B?cTlGVHl0aCtJK0huUXZoakVoODFBbXFla1N3UjF4YVJuRmIrdHVkQlF4VS9h?=
 =?utf-8?B?RTM3bG5uUkt4aVRzNmZoS2djcmlyRG0rQjAvNjRNbUYyRlVrMjBtSytPTGpr?=
 =?utf-8?B?TlRuQ0ZMbkZkWXZsOHN4eTZaSm9qZVZ6WGUrRVpWbk4yZTNUZXdoRlBQWHgv?=
 =?utf-8?B?UzZDM1A0SU9xTmwzYi85YmRHR2N0a29uUzl4NDR1WWdRd0Vmb25SQm94TWpL?=
 =?utf-8?B?TnVqWU5IWFhwZHlhVkdNVVkzR1VtazhuSHZvYVJQRFdVWFdadDc1OXlYYlh2?=
 =?utf-8?B?di9NVkljaGQ3TlFyTktWK080aFd3VGR6LzZzd2l2ZlBxWS9RTEQyd3loMnVN?=
 =?utf-8?B?N2t3MzZzMGxZUm1QMmRCL1pyUnhjRVRJTVlNMGdZUXRPUW4rVUVPN3Q3SWFK?=
 =?utf-8?B?OHlsL21nUnlJS1ZSM2lVUnI0WjV0SUU2K2ROM0tNMmVHbFJjNkdEVHdBZGov?=
 =?utf-8?B?aDRZUlFYVVpMSXhkdW53THc0ek5KanFGRXhPbVhFSjczWUVCZDlqNWlOdlpk?=
 =?utf-8?B?UDJ4TUNIdCtyYU41NWszcWZLUHJ5Q1V6T252djNBd05tK2ZYb296Zk1OQ1gr?=
 =?utf-8?B?VWxzNWN4N2NvTnM3SlhCeG9BOVU0THRoV2lCMGg3RUZDZXR1VWx0UjZyUXVF?=
 =?utf-8?B?cFNtWVhaeFdrQzYxL0kxTmlmblpidG1ham0xWWU2VEd4cUlTRzFCZWYxZVdT?=
 =?utf-8?B?Z3FMeVdHalhZUy9XbEhJWUNuVDNPQzdWV2xTRWMyY2cyNFArNVFaVytmRzN4?=
 =?utf-8?B?WTA3Ry9KaUxEVHE0R2Y4ckI2ZTNIYUtrRzAwbXNycXFuakkwbGtuSlhxRGtr?=
 =?utf-8?B?b3FUM0xrdTlFYWNseDA5TFYySGordTlMa1QvNHRzVy9vRWFVSmh0S2trd0xi?=
 =?utf-8?B?a0pBVkdDODhXSFNORXVrbTlkMFVOUk5jRnNFcWVHdFlGUkhoY2VuaFhQRFVZ?=
 =?utf-8?B?ZmgxTWY5d2k3NmlUc0ZmSHB4UlhpdXExY3EvOGNiN0JNNFdZendhaEo0RGhj?=
 =?utf-8?B?VHB3Tmg5MmE5anJNaTlDbDdQbWpITEtvVG03MVZXSUtWTW4zbzNJNVlKKzV0?=
 =?utf-8?B?MWo4cWUxU3R6ZGh3TmlXeWo0ZDJKVloycW53UTdkV01UbkExRnkvS1NISmNt?=
 =?utf-8?B?VDNOS250R29Zb1ltdnJuWHB3MjZlNXNSdUtId2xQWEJoR0dKUnlIL2tOemJj?=
 =?utf-8?B?UTJEOWVoSXVFajNFenRnbG5jdjIyblpzUXVIOTBtR1N5UFJDMEhPUWgzNUFV?=
 =?utf-8?B?ZmVDTWtLVkhhQ3Jsb0czZUhoOVNHd09oQTJJTnEwS0IvVDNFSmRCN0NpMDUx?=
 =?utf-8?B?L09ob292bXY4MVRubmhFNm9HTDU3SUJOR09YOGNqSm9KV2xBZ1VkZ3oyaVhM?=
 =?utf-8?B?akVOQkFsU3hDeTA5Qm42OVFvQ1ZhR0xWNGtISGdvQnlBQjh4cGE1Z0d1U0p2?=
 =?utf-8?Q?34VoZpq3EcoMG?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR11MB5366.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjBHZ0FGbnZIbE9oVENNZGplSnZGNkw3WVlKM3BNMUxGbDlMelN3TU5sendh?=
 =?utf-8?B?QjZ2dFZIclR5RnoyOElBVWV5Z3NNUzVubitzYWVSVlNTQk1LK3pORWhpRWFi?=
 =?utf-8?B?YUliWUhrb1gwQnlBR3NtSlc1NXNkYjd3Q3NTaXkvVGFuOUdkTkI0TU4zQVJt?=
 =?utf-8?B?MVl3cUNkZHpkNzlIajlsaW9tcjNyUEh5a0h4c095VEVIYXlBQ1AvRWxNeVZ3?=
 =?utf-8?B?TGlIdTJ5WDA5U1BsU0ZVZnBZWUhSWm01d2RvWURvdExybElnQ2k0MlFoNDl1?=
 =?utf-8?B?K3o2N1JIWUNxWmlwRFJoSXVOcEdUUGpQbm9XdEw1YjNBSk1iajBlZlcrMloz?=
 =?utf-8?B?Yy92NGtyUVd5MWQ2cXdGNDFSbkNKQXNYQU1iVVB0WWo4VG92dDZuY3dVcnhj?=
 =?utf-8?B?amxNdGxsWU5OVzlSL3BUS2dNblZpRmlWdHh0RnF1cUU3bGliZmtMYzIzaGd4?=
 =?utf-8?B?cmlOR28rbjVUMFczSTUxYzh5ekdicUhKS0Q0U2ZRREFUNVNkSldGSk1RNVcy?=
 =?utf-8?B?aWVBS1hZemZYUy9iM0N2aStLN2Zmc3A4OWptbDZaNUs4alZZaXUvR1pCRkZr?=
 =?utf-8?B?U1J0Q00vV09yTkhVOWQ5NENoV2xjTVVQZkZSUzFaVXlpSjJ5eEpwbnlYa3ZL?=
 =?utf-8?B?Wk5rL2k4QktaZ1FkN1BjQkZxUDNqdElKWWMyYmU1cWNxZWFmWXJDYThMN3dJ?=
 =?utf-8?B?ckQ2eDJJR1ZsWTdTRkFoVzhzZzJhUmkvbzZPQWd3THVTbTUrcERqOW9RNU1q?=
 =?utf-8?B?TWNEZndsZmJ1RGhHQmlGRTRzNTZ6QUhxTDkwUjFROEE4azRnbmlSL1c5UDJZ?=
 =?utf-8?B?dmVCOUpuVnRHV0FJY0xaR3c5OSt0eFAyMzJIeVlkS3p4TW8xT2dHRE5ta0ZD?=
 =?utf-8?B?bDRYS3E1YUZnUyt5c3B6aHpMblI1UzNRcmhXWmF0VEtjcTY2Ums0M3VPK3VG?=
 =?utf-8?B?N3JnaHlyWlpBbHI1ZWswbUtBa0xlb3NrNjg4ZDFRQ0J5OXJJSTM3LzFpdWJJ?=
 =?utf-8?B?cXc3cjlNNW1uVjBibTF3STAyeVBoTTdDbC9rbG9ZOWJIWHZBZjRaV0I0dDNh?=
 =?utf-8?B?R0lPQzBRVk5jMXVUNmxWZld1QUNNcmtTb3V1WWhnd2VhcnovNkRkeGMvQUpQ?=
 =?utf-8?B?amNHcVROQ25lZGZsQnhGZE1XeGdpNUhtSDd3aW9HMUhzVWM2U0FrUWhqbitp?=
 =?utf-8?B?VjdPeldHZ1FGQjBHaDFqQjJPUUs0UmcvWnJWTnBHZlVDKzFXWGc2M3dEN0FV?=
 =?utf-8?B?Q2Z2NjFMay9UYTlDNllYYjlVTE5peTJYOEFYUlNkbGVHRnB1b0NQUjVVekFu?=
 =?utf-8?B?SGU2bnhLMDA5STVYdEVxVU1nRnVBWUxUOERvMnJNOGpocjh0UzcxTHlkcGN6?=
 =?utf-8?B?b3VMSVNsVUZVSkgrSi9vcW01UmRCWjl3UkFQM25VeW4ya2ZXZ2t6cnhOdHJw?=
 =?utf-8?B?a01QOVlJWGFaTEtueG9nV3U4eWlhRFZSd2wvZE1BVHZZRUNyK0ZWMkdlbGQz?=
 =?utf-8?B?aW5mdEEzMXRVbExJNHVpZ2RPNHY3L1lGclVKMno3eTNNYnU1M1lENEZ0OGhN?=
 =?utf-8?B?ZGovTE9vU0h4eVZmWHFhdFduemd0SmtwMm1GM1dkTzhjVHNDTmhtdDFPTTc0?=
 =?utf-8?B?ai9WMzEyRnY4NTVJOTVmck5vZFVJSTcvei9Zb2Q4bm9ZY29vZytkY0xqWGNL?=
 =?utf-8?B?RHgwdjh6R003TTVnY0NIVTJaRTZpU05TOVNWRGdVMGh3eUZhWUovV3BYZnZ6?=
 =?utf-8?B?SG16Y2tlVy9mbTQ3eWs0N1BYMFV3U2p5OXdWQ0piOEo0R0oxQmN0bTM5ejQ2?=
 =?utf-8?B?bUtSQnJZT1l1VHR5aUpwT0prWHY3aGNMK2pMVHUyV21oVjRHamFLZkMxV09S?=
 =?utf-8?B?L20wak9GL3hGRXhhU0NnUUljR1E4QU51Q0hOcWJsY2FaZTNHZXBsYUg0K2dF?=
 =?utf-8?B?NHNHYkpIblhzWnlKcWxONk5zVnZTTDdYc05MT0JNTnByeExqWTNXd05YT2lh?=
 =?utf-8?B?SG5CSjkrc2VqbXBaMlRrRUxwdU50NUszZXZrRWEwMDNOVjdRK1duT2ZmRkxC?=
 =?utf-8?B?dUxSUmF4MjMrbHdVNmlnTGNZd3BFWTd3eVU1UCtIUlJVNExyYlEyU0dNR1hw?=
 =?utf-8?Q?f+yE5KcyC5dQQByIWchPEWY8y?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52566676-184d-4f43-51c0-08dd1e6e1792
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2024 07:40:34.6638 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WFXdGSXAn5jO1VQ5oUarV8aEfg4k1Cke9RCoqggXA0JxzuRk6VY/qjUaIgqYcA7CXwj2ziTV6FK3J9NV5sEIsA1WcoDauL5pmPAP3BKASvQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4821
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
YXksIDEzIERlY2VtYmVyIDIwMjQgNToxNiBwbQ0KPiBUbzogTWFuaXlhbSwgRGluZXNoIDxkaW5l
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
IFJlOiBbcmVzZW5kIHYyIDAwLzE5XSBBZGQgQ2FkZW5jZSBOQU5EIERyaXZlciBzdXBwb3J0DQo+
IA0KPiBIaQ0KPiANCj4gT24gVGh1LCBEZWMgNSwgMjAyNCBhdCAxMDoyM+KAr0FNIDxkaW5lc2gu
bWFuaXlhbUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogRGluZXNoIE1hbml5YW0g
PGRpbmVzaC5tYW5peWFtQGludGVsLmNvbT4NCj4gPg0KPiA+IFRoaXMgcGF0Y2hzZXQgYWRkIENh
ZGVuY2UgTkFORCBkcml2ZXIgc3VwcG9ydCBmb3IgSW50ZWwgQWdpbGV4NQ0KPiA+IGRldmljZXMu
DQo+ID4NCj4gPiBUaGUgTkFORCBkcml2ZXIgaXMgbGV2ZXJhZ2VkIGZyb20gdGhlIGNhZGVuY2Ut
bmFuZC1jb250cm9sbGVyLmMgZnJvbQ0KPiA+IExpbnV4IHZlcnNpb24gNi4xMS4yLiBVLUJvb3Qg
d2lsbCBzdXBwb3J0IHJlYWQsIHdyaXRlIGFuZCBlcmFzZSBOQU5EDQo+ID4gd2l0aCBDYWRlbmNl
IGRyaXZlci4gVGhlIGRyaXZlciBmdXJ0aGVyIGVuaGFuY2VkIGluIFUtQm9vdCB0byBzdXBwb3J0
DQo+ID4gTkFORCBib290aW5nIGZyb20gRlNCTCBhbmQgc3VwcG9ydCBib290IHRvIGtlcm5lbCB2
aWEgVUJJRlMuDQo+ID4NCj4gPiBQYXRjaCBzdGF0dXM6DQo+ID4gSGF2ZSBjaGFuZ2VzOiBBbGwg
cGF0Y2hlcyBleHBlY3QgUGF0Y2ggMTkNCj4gPg0KPiA+IERldGFpbCBjaGFuZ2Vsb2cgY2FuIGZp
bmQgaW4gY29tbWl0IG1lc3NhZ2UuDQo+ID4NCj4gPiB2MS0+djI6DQo+ID4gLS0tLS0tLS0NCj4g
PiBQYXRjaCAxIC0gMTg6DQo+ID4NCj4gPiAtIHJlbW92ZSB0aGUgInRoaXMgcGF0Y2ggaXMgdG8i
IGNvbW1pdCBwaHJhc2VzDQo+ID4NCj4gPiBQYXRjaCA0Ow0KPiA+IC0gbWlub3IgcmVmYWN0b3Jp
bmcgb2YgY29kZSB0byBtYXRjaCB0aGUgc3RhYmxlIHZlcnNpb24gNi4xMS4yLg0KPiA+DQo+ID4g
UGF0Y2ggMTQ6DQo+ID4gLSBBZGQgbWFpbnRhaW5lciBhbmQgIiNpbmNsdWRlIiBtZWNoYW5pc20g
Zm9yIG5ldyB2YXJpYW50DQo+ID4NCj4gPiBQYXRjaCAxNjoNCj4gPiAtIGxldmVyYWdlIHRoZSBl
eGlzdGluZyBuYW5kX3NwbF9sb2FkX2ltYWdlDQo+ID4NCj4gDQo+IEkgaGF2ZSB0cmllZCB0byBi
dWlsZCBidXQgaXQgZG9lcyBub3Qgd29yay4gSGF2ZSB5b3UgdGVzdGVkIGluIGdpdGh1Yj8NCj4g
DQo+IE1pY2hhZWwNCg0KWWV0IHRvIGRlcGxveSBnaXRodWIgdGVzdCBvbiBvdXIgY3VycmVudCBw
bGF0Zm9ybS4gDQpPbmx5IGNoZWNrcGF0Y2gucGwgYW5kIGxvY2FsIGJ1aWx0IGhhcyBiZWVuIHVz
ZWQgYXMgYcKgbWV0cmljIGZvciBlYWNoIGNvbW1pdCBiZWZvcmUgc3VibWlzc2lvbi4NCkFuZCwg
YWxsIHRoZXNlIGNvbW1pdHMgYXJlIHBhcnQgb2YgdGhlIGZpcm13YXJlwqBjdXJyZW50bHkgcnVu
bmluZyBvbiByZWFsIGhhcmR3YXJlLg0KDQo+IA0KPiA+IEhpc3Rvcnk6DQo+ID4gLS0tLS0tLS0N
Cj4gPiBbdjFdOg0KPiA+IGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC91Ym9v
dC9jb3Zlci8yMDI0MDkxOTAzNTUxMi4xMzg1NC0NCj4gPiAxLWRpbmVzaC5tYW5peWFtQGludGVs
LmNvbS8NCj4gPg0KPiA+IERpbmVzaCBNYW5peWFtICgxOSk6DQo+ID4gICBkdDogbmFuZDogYWRk
IGNhZGVuY2UgbmFuZCBkdC1iaW5kaW5ncw0KPiA+ICAgYXJtOiBkdHM6IGFnaWxleDU6IEVuYWJs
ZWQgY2Rucy1uYW5kIGR0cyBzZXR0aW5nDQo+ID4gICBpbmNsdWRlOiBhc206IEFkZCBzdXBwb3J0
IHRvIHJlYWQvd3JpdGUgNjQtYml0DQo+ID4gICBkcml2ZXJzOiBtdGQ6IG5hbmQ6IEFkZCBkcml2
ZXIgZm9yIENhZGVuY2UgTmFuZA0KPiA+ICAgZHJpdmVyczogbXRkOiBuYW5kOiBjYWRlbmNlOiBB
ZGQgc3VwcG9ydCBmb3IgcmVhZCBzdGF0dXMgY29tbWFuZA0KPiA+ICAgZHJpdmVyczogbXRkOiBu
YW5kOiBjYWRlbmNlOiBBZGQgc3VwcG9ydCBmb3IgcmVhZGlkIGNvbW1hbmQNCj4gPiAgIGRyaXZl
cnM6IG10ZDogbmFuZDogY2FkZW5jZTogQWRkIHN1cHBvcnQgZm9yIE5BTkRfQ01EX1BBUkFNDQo+
ID4gICBkcml2ZXJzOiBtdGQ6IG5hbmQ6IGNhZGVuY2U6IEFkZCBzdXBwb3J0IGZvciBOQU5EX0NN
RF9SRVNFVA0KPiA+ICAgZHJpdmVyczogbXRkOiBuYW5kOiBjYWRlbmNlOiBTdXBwb3J0IGNtZCBT
RVRfRkVBVFVSRVMgJiBHRVRfRkVBVFVSRVMNCj4gPiAgIGRyaXZlcnM6IG10ZDogbmFuZDogY2Fk
ZW5jZTogRmx1c2ggJiBpbnZhbGlkYXRlIGRtYSBkZXNjcmlwdG9yDQo+ID4gICBkcml2ZXJzOiBt
dGQ6IG5hbmQ6IGNhZGVuY2U6IFBvbGwgZm9yIGRlc2MgY29tcGxldGUgc3RhdHVzDQo+ID4gICBk
cml2ZXJzOiBtdGQ6IG5hbmQ6IGNhZGVuY2U6IFVzZSBib3VuY2UgYnVmZmVyDQo+ID4gICBkcml2
ZXJzOiBuYW5kOiBFbmFibGVkIEtjb25maWcgYW5kIE1ha2VmaWxlIGZvciBjZG5zLW5hbmQNCj4g
PiAgIGNvbmZpZ3M6IG5hbmQyX2RlZmNvbmZpZzogRW5hYmxlIGNvbmZpZ3MgZm9yIG5hbmQgYm9v
dA0KPiA+ICAgZHJpdmVyczogbXRkOiBuYW5kOiBiYXNlOiBBZGQgc3VwcG9ydCBmb3IgSGFyZHdh
cmUgRUNDIGZvciBjaGVjayBiYWQNCj4gPiAgICAgYmxvY2sNCj4gPiAgIGRyaXZlcnM6IG10ZDog
bmFuZDogc3BsOiBBZGQgc3VwcG9ydCBmb3IgbmFuZCBTUEwgbG9hZCBpbWFnZQ0KPiA+ICAgZHJp
dmVyczogbXRkOiBuYW5kOiBFbmFibGVkIEtjb25maWcgYW5kIE1ha2VmaWxlIGZvciBDYWRlbmNl
LVNQTA0KPiA+ICAgZHJpdmVyczogbXRkOiBuYW5kOiBLY29uZmlnOiBSZW1vdmUgU1lTX05BTkRf
QkxPQ0tfU0laRSBkZXBlbmRlbmN5DQo+ID4gICBkcml2ZXJzOiBtdGQ6IG5hbmQ6IEtjb25maWc6
IEVuYWJsZWQgc2VsZi1pbml0IGZvciBjZG5zLW5hbmQgU1BMDQo+ID4NCj4gPiAgYXJjaC9hcm0v
ZHRzL3NvY2ZwZ2FfYWdpbGV4NS5kdHNpICAgICAgICAgICAgIHwgICAxNCArDQo+ID4gIC4uLi9h
cm0vZHRzL3NvY2ZwZ2FfYWdpbGV4NV9zb2Nkay11LWJvb3QuZHRzaSB8ICAgMjggKw0KPiA+ICBh
cmNoL2FybS9pbmNsdWRlL2FzbS9pby5oICAgICAgICAgICAgICAgICAgICAgfCAgIDI1ICsNCj4g
PiAgYm9hcmQvaW50ZWwvYWdpbGV4NS1zb2Nkay9NQUlOVEFJTkVSUyAgICAgICAgIHwgICAgMiAr
DQo+ID4gIGNvbmZpZ3Mvc29jZnBnYV9hZ2lsZXg1X25hbmQyX2RlZmNvbmZpZyAgICAgICB8ICAg
MzMgKw0KPiA+ICAuLi4vbXRkL2NhZGVuY2UsbmFuZC55YW1sICAgICAgICAgICAgICAgICAgICAg
fCAgIDk4ICsNCj4gPiAgZHJpdmVycy9tdGQvbmFuZC9yYXcvS2NvbmZpZyAgICAgICAgICAgICAg
ICAgIHwgICAxOSArLQ0KPiA+ICBkcml2ZXJzL210ZC9uYW5kL3Jhdy9NYWtlZmlsZSAgICAgICAg
ICAgICAgICAgfCAgICAyICsNCj4gPiAgZHJpdmVycy9tdGQvbmFuZC9yYXcvY2FkZW5jZV9uYW5k
LmMgICAgICAgICAgIHwgMjQyNCArKysrKysrKysrKysrKysrKw0KPiA+ICBkcml2ZXJzL210ZC9u
YW5kL3Jhdy9jYWRlbmNlX3NwbC5jICAgICAgICAgICAgfCAgIDU5ICsNCj4gPiAgZHJpdmVycy9t
dGQvbmFuZC9yYXcvbmFuZF9iYXNlLmMgICAgICAgICAgICAgIHwgICA3MSArLQ0KPiA+ICBpbmNs
dWRlL2NhZGVuY2UtbmFuZC5oICAgICAgICAgICAgICAgICAgICAgICAgfCAgNTI5ICsrKysNCj4g
PiAgaW5jbHVkZS9saW51eC9tdGQvcmF3bmFuZC5oICAgICAgICAgICAgICAgICAgIHwgICAxNCAr
DQo+ID4gIDEzIGZpbGVzIGNoYW5nZWQsIDMyOTMgaW5zZXJ0aW9ucygrKSwgMjUgZGVsZXRpb25z
KC0pICBjcmVhdGUgbW9kZQ0KPiA+IDEwMDY0NCBjb25maWdzL3NvY2ZwZ2FfYWdpbGV4NV9uYW5k
Ml9kZWZjb25maWcNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRvYy9kZXZpY2UtdHJlZS1iaW5k
aW5ncy9tdGQvY2FkZW5jZSxuYW5kLnlhbWwNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZl
cnMvbXRkL25hbmQvcmF3L2NhZGVuY2VfbmFuZC5jDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBk
cml2ZXJzL210ZC9uYW5kL3Jhdy9jYWRlbmNlX3NwbC5jDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0
NCBpbmNsdWRlL2NhZGVuY2UtbmFuZC5oDQo+ID4NCj4gPiAtLQ0KPiA+IDIuMTkuMA0KPiA+DQo+
IA0KPiANCj4gLS0NCj4gTWljaGFlbCBOYXp6YXJlbm8gVHJpbWFyY2hpDQo+IENvLUZvdW5kZXIg
JiBDaGllZiBFeGVjdXRpdmUgT2ZmaWNlcg0KPiBNLiArMzkgMzQ3IDkxMyAyMTcwDQo+IG1pY2hh
ZWxAYW1hcnVsYXNvbHV0aW9ucy5jb20NCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXw0KPiANCj4gQW1hcnVsYSBTb2x1dGlvbnMgQlYNCj4gSm9vcCBHZWVzaW5rd2VnIDEyNSwg
MTExNCBBQiwgQW1zdGVyZGFtLCBOTCBULiArMzEgKDApODUgMTExIDkxNzINCj4gaW5mb0BhbWFy
dWxhc29sdXRpb25zLmNvbSB3d3cuYW1hcnVsYXNvbHV0aW9ucy5jb20NCg==
