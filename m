Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1966C021BE
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 07:19:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31EC6801FB;
	Thu, 27 Feb 2025 08:19:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="gxwfVNjn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 827D6807FB; Thu, 27 Feb 2025 08:19:52 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB136800C1
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 08:19:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740640790; x=1772176790;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=158oK8RAMPULimvcRnx3mqrxeqlcWhIHd/8gZLVc+6I=;
 b=gxwfVNjniuex9qm6jRJAWYyt2c984FNkcMHqd+ih8bB1hiKS8Yk3sEg/
 cpECmg5pLh5J3wYayJ+ShOkKmPHiRF+ha68ijIJeMtTetGFQdSF09rGti
 C8w2NL/kVBF3M2+lhZeisg2z5lrw74l/2Fx9xQVlbMyrNzgA5bjZTGarR
 /E+kogPK+Wxm5Q64p8hn0yMBmT/wFAHcQUNK0lmVg6OjhpNuN5uvf/ej+
 Un4IStFSCaHvdcRMbuRHzRrW9/IP4YxqvMy+STbyYBdn7rcdYEJW2OKRr
 Y7cYArAOi5Cx4BKqcI8ieR8WD2iozRy3MwFoW6SlLPKiwf0Wfy4i7sVvy w==;
X-CSE-ConnectionGUID: hFX6nkmuSUqtGLdfzN7suw==
X-CSE-MsgGUID: U0+wH3yBSM+Vr+xyhMi8XQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="41369304"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; d="scan'208";a="41369304"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 23:19:48 -0800
X-CSE-ConnectionGUID: nQQ2ti0/S7Ob95spjZR3wQ==
X-CSE-MsgGUID: BZNYRsO3QWapbubH/UMIIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; d="scan'208";a="117587074"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 23:19:46 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Feb 2025 23:19:45 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 23:19:45 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 23:19:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EZ2zb3/OkyBndk2HArN5/6JEcqzvz0T1h29r1i2SwlSz0AUM3nmRPfAYZGHmpqYzEX6+hyJfq0j/HV2i0MxHaKnR0lidYeeUsxHC/c54s3fA3tD1G3K3jpE6tLcrBAnktNCYC+uxLUP9WEKR8Z+4KjgwsnedYy/MCr316ycfvr+pcbY9vkIxGL5hQwcggKthIndK9WWGqmSbWDExOcwFpIllte62IlVr3W/ix35KRWAX3x/lqSzl94KGe6xJY+yC5crp/o82inmoQuQGplrON0rSXXPB7jhBDOJXV4AvUgdfkRqTNDTb0mz0lMbPKH7RmewWcfBkbN3In+NW37cc8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=158oK8RAMPULimvcRnx3mqrxeqlcWhIHd/8gZLVc+6I=;
 b=ay7pkw+0w5izl/ww7S49LtnrLbeDASa/RAiH1tTfy6tCmXbtBdvZHGpH1VzRpaHADjATf0oHNMPTs7bmYZANsXDdPVZEuQZkqubpnxmwB8EgbIXgn9CAs8bGJNwzSjvaT42BppJSo9XZ04d0Xe5imxQSzMPvVbt89XI51mDQGRIu3LXwisYmw+KzX9XpY0OeqN+nrLG2cTXPGJ3H1Ca4vSpBtl8HZ4TRodTQ3EidEl+/XZx+qtuCiJO88MibisBkYAHsfMGQbju6I8i5tLfAG40w9fzbcmJdhs54bHLDC4Kw/bmuMUN03vEkBL8cTodO9VVfDdsoXzCB0C7frEh2BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5366.namprd11.prod.outlook.com (2603:10b6:208:31c::17)
 by SA3PR11MB7609.namprd11.prod.outlook.com (2603:10b6:806:319::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.21; Thu, 27 Feb
 2025 07:19:43 +0000
Received: from BL1PR11MB5366.namprd11.prod.outlook.com
 ([fe80::f073:1e46:c7ee:df9b]) by BL1PR11MB5366.namprd11.prod.outlook.com
 ([fe80::f073:1e46:c7ee:df9b%7]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 07:19:42 +0000
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
Subject: RE: [resend v3 00/19] Add Cadence NAND Driver support
Thread-Topic: [resend v3 00/19] Add Cadence NAND Driver support
Thread-Index: AQHbiGokuJItREvckUOfj6aKeqZHHrNasjeAgAALQ+A=
Date: Thu, 27 Feb 2025 07:19:42 +0000
Message-ID: <BL1PR11MB5366A416815F15738B0F850382CD2@BL1PR11MB5366.namprd11.prod.outlook.com>
References: <20250226161833.53689-1-dinesh.maniyam@intel.com>
 <CAOf5uwn+OAqHL9SkZsR+YzctT3mNxOh6GXaqdN1i6ByOzVnSAA@mail.gmail.com>
In-Reply-To: <CAOf5uwn+OAqHL9SkZsR+YzctT3mNxOh6GXaqdN1i6ByOzVnSAA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5366:EE_|SA3PR11MB7609:EE_
x-ms-office365-filtering-correlation-id: b6ad7746-ae45-4786-a866-08dd56ff1b28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ZVlwWmZsMSt3eisvanFWdG9qZGxISjhwYVp4bTdsd1M3NnRjb0VCcHRyNUpy?=
 =?utf-8?B?VytIblFvU01hRzZ3VEVweHkyVnFUUCtPbGcrUS9zUzMvWERZaFFseS9UZ1My?=
 =?utf-8?B?OGN3M04yVzhENmdiQTY2Um85VEk5L1JlbnNMMlM4TkxaTUlTSEJBVVFCajJa?=
 =?utf-8?B?K1ZLTVVtQXBic09hamxQVGpFSTNDZHN4aDVYS2x2MVVaTmR0bERYc0tJYTNp?=
 =?utf-8?B?NFZGbHpvVkxiU1NzNXN0dlZWOHFrdGFGTlVrcHY2Mk5mMlBQYUgxeUM4SU1l?=
 =?utf-8?B?TFRaNVZtTmhXcEZhZmpCNVpJVm5aVE1KMFJDQStxa1ZvRzFWSXRyemhHbGgx?=
 =?utf-8?B?R0x5aTBsY3p3Z09YS1pIL2pjSFZVeE1PNFB3VHl6NlE3WXRFYzViVkQ5Vy9o?=
 =?utf-8?B?NnVJTEJPY2lPUlRxRFN2dFFETGlBSyt4WGFLNkVsWWFsemRFcXNYeEdaanNO?=
 =?utf-8?B?dDJ6WmNhNGduZy9mdTlZeXFINTdyY3FBK2QxMGtBRkI3cUhTaUVmT2xFdytT?=
 =?utf-8?B?aUpSdzVJWEFuQnNhNlJobUV5SU16MURxdFpuUHZOTmRMQXdkbzM0RjcxdEli?=
 =?utf-8?B?enErc0NqMklsd29pYkZrMSt1cVFyaFllRldManJyOXN2aGprNCtWWkgyL1Nt?=
 =?utf-8?B?T2RmWFNvSlA4ajVCSnA3bGw0dVhha0dCeEVYcFRNME5aZ3JJQkc0a0QxYnQ3?=
 =?utf-8?B?UENOU2xkVXBhSUcxbzA2UnZzQldXd3FlQ1VpMlFlZ0toMkxlS3Ayd3hvQlVT?=
 =?utf-8?B?OXE4VkF6SVlnMkNwdmdVY21lVW1WRkl5VUFnR2lqMWdHQlpQVlZYYlpOQzU5?=
 =?utf-8?B?SWIwandqYkhNWkQvNEdKTWE1VmN5NkZldzRvaFBDZ0RnOWw4TnpTTDI5ZmR0?=
 =?utf-8?B?UUx3K2t3dGYwY3FHbFNTODduOVBXdFlkQUFsQ2lrTENvQzRzb0pOMUE2ZDJW?=
 =?utf-8?B?akdXN01iWjgwUE1OVkJwTURPMm96aml5UjdLRGgzL3JoaEtuWkpzK2gwRzls?=
 =?utf-8?B?VFdaUHlaenVPK0V2amE3Z2VTTkxPQjV5YXQwOE5QcmFKcll5aWRMWXJLUU41?=
 =?utf-8?B?dVBlT1ZUQ05PLzhWV25iZVFTWFNtNWhEb0FvMC9aOXF1VGczQWNwREtnWDBI?=
 =?utf-8?B?VzVVQTh5TTE3MmwzMzd0bVpnWFJHN2VKS0IvZVZsUlIrbDNLSmtwM2p6Q3BB?=
 =?utf-8?B?YWRlQnNzRHc3S2JoU0VDUzZTV1JldzAralJNVm1kQkdYUGU3WC9PVzlFQ2tr?=
 =?utf-8?B?U0hWZU00d1BoV3dWU2tSNU5CSlFobWd4R2RXZXdhWFd6V0lOSkl0ZU41aFFV?=
 =?utf-8?B?YnBOUm13aE1JNFpzbE0xUkR5UUQrVjdSaXFDZitXM0hkVUpVczE1V2JiT0kw?=
 =?utf-8?B?c1JLZXliQnlIVmtjNE5DenZLbHVjTGpENURjM2V2RFFBNVRVaUpMYWs2Z2J2?=
 =?utf-8?B?bGU0d0xmTk5Gdk5GYWl6eVd3REtEbU1pTVdqWVlCeERzQkVJdnpCRFFzMHND?=
 =?utf-8?B?c3U0VzVBOHgvZlFSOGRtQVpTMkFOeE82WVBtLysrZ2FGbitkWXhOTHlqZE5h?=
 =?utf-8?B?TEVaUHpiTjJlemhaTElvelFkRlpMT0NBQitaakR2V1VzanlIQ3QwT0hNVFBm?=
 =?utf-8?B?Q0ZqbEc4eHRPeUJPL1RLZTQ3ZWxBYkllaWNjUCtwTFhFVFNCeWk3Q2lWYUhJ?=
 =?utf-8?B?Z1JROE9CVXVhYW8wY1pOSlZBcEdkUHhWOWNuT0hvdDdKdWlSdCtUTncwdVp4?=
 =?utf-8?B?UXVVVUxVV29aWTY2Y3BYMWpYcElGTy9EelJxK2ZxQUNFUU9Gc0VXVEFVbjht?=
 =?utf-8?B?LzJZN0lhb09NS2hVOTEyUy9odjR1UjNVa0NiUnM1T0pTMGh5V09HRkl1VmVL?=
 =?utf-8?B?ajE4YktOcFdHbXlDek5GSXRNQWNZRWdYcG9acVVDQjV5Qnc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR11MB5366.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?am01c1h5M1RKQ3FyM2pkNFNUSDhMbjExUUFQcFQ1MmNBeC9INjU1dC9qc1RO?=
 =?utf-8?B?T1VBdzA0SE9Qb0szMHdmdXlKSEtiaTU2STI4b1V1QitLVC9KY25tbTF3am5J?=
 =?utf-8?B?YXgrazhGNlBtZHMySFVGTFN0OEp5K3ZuZWhPVjlyY3pDdFZqcU5XaXZxc0p6?=
 =?utf-8?B?MjZURStlOUZBdElhekYzVHpsNHhUWWpFSEFUWk1NZlhhaUJpMUxPRG9hNGwr?=
 =?utf-8?B?YzZrNVhjNzNSb2Q5U3N4SVBuS1Eyb0dlOC9Id2pvN2NRNzREaUR3bW55ckFH?=
 =?utf-8?B?VDlrTkFsQVEvSTQ4cmx2Tzd6M0F1K29sOWFKVDZFMjJseTljd2JVdy9RbmRG?=
 =?utf-8?B?d0NkTUhrYlBkVDdyV25tQ1dJVXRoSVVrT2lka0F0L1RPbG5ibkNtc1d3cjU0?=
 =?utf-8?B?RnNlNWU5M25XN2xwNnIvbG5ZNktSYTJKbHg5WXQzWkNNa01nM2xaNzArR0JF?=
 =?utf-8?B?b2lqRVFlQ3o5M0JZRldwYnJuVnpVREowYmkydWJTWjVLaTJDc3kxeWZkR1FF?=
 =?utf-8?B?MHBMaXN0VExQNS9Iek5NaTcxenlqZmRLb0hCR2hQVEs1QTF4cmw4SVYwTzA3?=
 =?utf-8?B?MlFEUVdXRFVtN2txWUdZeDltVTE0UVhxYWh4TE9BZ1ppbVl6UHo3Sks5TU85?=
 =?utf-8?B?QWpKRmVZOWdEeFJXSisybytzSGV1SUh3WktWdnRLbkRXZHRGZXpSNTRGZmY0?=
 =?utf-8?B?NkpLQUlpRThPMHNvcUs4cDhpTjUzVm56cFVCcVozblNTcHd6T21UbXZzVDMv?=
 =?utf-8?B?ajFVTUl6OVdKVGxEVUMyaG9TT0hUTGFseDhYaEVwNENLejVKZEw5eVplRGYy?=
 =?utf-8?B?alNRSERXT0xUaHRMaUQydDczQUNPT3RlM2lvTHkzK3ZsMEhGWkF5VncwUDJa?=
 =?utf-8?B?cVZleTVhTHV2dUhETElVclFwbEloVk4xai9USXZCL0l4YS83L3MzZlJRUU5p?=
 =?utf-8?B?N21jNmpkTGFuQ0lpN2ZEWGFMalNDWEtOdnh0UVJoVGRMWUJudHRqVkh3TUNp?=
 =?utf-8?B?aHppUm9DU091QndpckRsR01QMGU0b3lWb3BtbTUrWW0wQkFxaGJLSi85UTVy?=
 =?utf-8?B?dklBVlFiRWswTGZUUGJWU0E2OVpsTzJ2bEgyQXNGZHBlTEkxcFp3Y1NqSkdh?=
 =?utf-8?B?RWcxay9ZcFZPTUFNYUEvTWhENG9aM3VVMmk2RGczc3BDVHg2eTF2VVk4ZTZp?=
 =?utf-8?B?Zm9TbHluN1k2SXVPbkJxVjYrenBkOWE4ckw4aXBqVVlLNk44QnZnOG1NRzQ0?=
 =?utf-8?B?Zm9BTTkxSU84VGxaa0hmMXRFSGI4QlQ5WS8yeHNLdzAzYW5Db25SRHhEU1kr?=
 =?utf-8?B?ck92T2pCbm5rVnk5MFl3dEJYWXhpOG9ENlo2OVlXNDFVV3dPSzIrU1ZObU1T?=
 =?utf-8?B?UWMzbExXNGgrWk5WYUFDS2ROWXBqOGdxZWlJWUJ1WVl1Nm5MSEFhVHB2Ukp2?=
 =?utf-8?B?L25XandWSFREaExjQVNlMzM2ajVXeDJYKzRlUS9aQU1kemJoNXBPUjBCR0Zw?=
 =?utf-8?B?ZEI5bFU2ZnFmcHUwbVV3VnRhOFZRbTRHajRGQm9ZNW1KR2R4cDc3MEc0czFY?=
 =?utf-8?B?NSsyK3dhcTR1Uy92cWlIWGxKLzhzR1VsSk5LZFJGTWFJYUR0V1FYNVY0K1c0?=
 =?utf-8?B?RXlkeFhGYXZ5eGdBWUF1WUxkUzdUSVMwVzhrTU1EaVJNV04vNXU5WmtKT21H?=
 =?utf-8?B?ODY4VUJYVzVGY2plRytpQmZrSUNPeWJqL1FvZllsM0MrbnZxbldHZHE4eXJx?=
 =?utf-8?B?aXBBL2FsRFB6K3VUSW5tcUJpRVpIcFRMSTV1R0pxckVSVUJ1c1o1cXhsYlpZ?=
 =?utf-8?B?Y3BuT0crZjZsaWlCTDFibzZ2WFRkKzVqUUY4ck1Jbyt4TUhmVXdMZ2FGaHli?=
 =?utf-8?B?R3FCZ2tnUG5LRWw4bVNaQTZKaWYwTy96S1FMUEw2YkRWd0JUd1ZNaEZYeFF3?=
 =?utf-8?B?bDBzS1RRNkh1UDFQL2xVb1lacFhiaE5SRG9CeGNFREh2cnpwYStCVXZNaC94?=
 =?utf-8?B?SDZrMzdIUWpCRHpNWlFSeGQ1QzhiWWMySkN1STZuWlV4ay9Tb0k1REtYRGFz?=
 =?utf-8?B?ZjdPS29KaVVCM2t6U1VQUEJBT040czhIYXkvd2dxM050V1JCYVRiYm1KNS9L?=
 =?utf-8?B?SEpkemRFUVJnZmpiT1JOenVHRVNTQUk1ZDBwYVJpemVrUTFOZTBOdGtFdDFU?=
 =?utf-8?Q?m558yOONq8Vh/dy8cw8itc7PbcgwgQ+SWFKjBV0UprpC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ad7746-ae45-4786-a866-08dd56ff1b28
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 07:19:42.8728 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H86J7yQKJgMvDskTmggUBYveZhSdP5P0lF4JrHNwIn9N8A77Xr6Sk0zlEl63vTKzPfZblKVDnn3OTAB4jVPZv8YUx0HJUlUqMXvHj/rsLWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7609
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
bm8gVHJpbWFyY2hpIDxtaWNoYWVsQGFtYXJ1bGFzb2x1dGlvbnMuY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgMjcgRmVicnVhcnkgMjAyNSAyOjM0IHBtDQo+IFRvOiBNYW5peWFtLCBEaW5lc2ggPGRp
bmVzaC5tYW5peWFtQGludGVsLmNvbT4NCj4gQ2M6IHUtYm9vdEBsaXN0cy5kZW54LmRlOyBNYXJl
ayA8bWFyZXhAZGVueC5kZT47IFNpbW9uDQo+IDxzaW1vbi5rLnIuZ29sZHNjaG1pZHRAZ21haWwu
Y29tPjsgVG9tIFJpbmkgPHRyaW5pQGtvbnN1bGtvLmNvbT47IERhcmlvDQo+IEJpbmFjY2hpIDxk
YXJpby5iaW5hY2NoaUBhbWFydWxhc29sdXRpb25zLmNvbT47IEpvaGFuIEpvbmtlcg0KPiA8amJ4
NjI0NEBnbWFpbC5jb20+OyBNaWNoYWwgU2ltZWsgPG1pY2hhbC5zaW1la0BhbWQuY29tPjsgQXJz
ZW5peQ0KPiBLcmFzbm92IDxhdmtyYXNub3ZAc2FsdXRlZGV2aWNlcy5jb20+OyBBbGV4YW5kZXIg
RGFobCA8YWRhQHRob3JzaXMuY29tPjsNCj4gV2lsbGlhbSBaaGFuZyA8d2lsbGlhbS56aGFuZ0Bi
cm9hZGNvbS5jb20+OyBJZ29yIFBydXNvdg0KPiA8aXZwcnVzb3ZAc2FsdXRlZGV2aWNlcy5jb20+
OyBNZW5nLCBUaW5ndGluZyA8dGluZ3RpbmcubWVuZ0BpbnRlbC5jb20+Ow0KPiBDaGVlLCBUaWVu
IEZvbmcgPHRpZW4uZm9uZy5jaGVlQGludGVsLmNvbT47IEhlYSwgS29rIEtpYW5nDQo+IDxrb2su
a2lhbmcuaGVhQGludGVsLmNvbT47IE5nLCBCb29uIEtoYWkgPGJvb24ua2hhaS5uZ0BpbnRlbC5j
b20+OyBZdXNsYWltaSwNCj4gQWxpZiBaYWt1YW4gPGFsaWYuemFrdWFuLnl1c2xhaW1pQGludGVs
LmNvbT47IFphbXJpLCBNdWhhbW1hZCBIYXppbSBJenphdA0KPiA8bXVoYW1tYWQuaGF6aW0uaXp6
YXQuemFtcmlAaW50ZWwuY29tPjsgTGltLCBKaXQgTG9vbg0KPiA8aml0Lmxvb24ubGltQGludGVs
LmNvbT47IFRhbmcsIFNpZXUgTXVuIDxzaWV1Lm11bi50YW5nQGludGVsLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtyZXNlbmQgdjMgMDAvMTldIEFkZCBDYWRlbmNlIE5BTkQgRHJpdmVyIHN1cHBvcnQN
Cj4gDQo+IEhpIERpbmVzaA0KPiANCj4gT24gV2VkLCBGZWIgMjYsIDIwMjUgYXQgNToxOOKAr1BN
IDxkaW5lc2gubWFuaXlhbUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogRGluZXNo
IE1hbml5YW0gPGRpbmVzaC5tYW5peWFtQGludGVsLmNvbT4NCj4gPg0KPiA+IFRoaXMgcGF0Y2hz
ZXQgYWRkIENhZGVuY2UgTkFORCBkcml2ZXIgc3VwcG9ydCBmb3IgSW50ZWwgQWdpbGV4NQ0KPiA+
IGRldmljZXMuDQo+ID4NCj4gPiBUaGUgTkFORCBkcml2ZXIgaXMgbGV2ZXJhZ2VkIGZyb20gdGhl
IGNhZGVuY2UtbmFuZC1jb250cm9sbGVyLmMgZnJvbQ0KPiA+IExpbnV4IHZlcnNpb24gNi4xMS4y
LiBVLUJvb3Qgd2lsbCBzdXBwb3J0IHJlYWQsIHdyaXRlIGFuZCBlcmFzZSBOQU5EDQo+ID4gd2l0
aCBDYWRlbmNlIGRyaXZlci4gVGhlIGRyaXZlciBmdXJ0aGVyIGVuaGFuY2VkIGluIFUtQm9vdCB0
byBzdXBwb3J0DQo+ID4gTkFORCBib290aW5nIGZyb20gRlNCTCBhbmQgc3VwcG9ydCBib290IHRv
IGtlcm5lbCB2aWEgVUJJRlMuDQo+ID4NCj4gDQo+IEkgaGF2ZSBqdXN0IGFwcGxpZWQgb24gdG9w
IG9mIG1hc3RlciBhbmQgdGhleSBhcmUgbm90IGFwcGxpZWQgY2xlYW4uIEkgY2FuIGZpeCB0aGVz
ZQ0KPiBjb25mbGljdHMgYnkgbXlzZWxmIHRoaXMgY29uZmxpY3RzLCBidXQgSSB3b3VsZCBsaWtl
IHRoYXQgd2hlbiB5b3UgYXBwbHkgcGF0Y2hlcyB5b3UNCj4gZml4IHdhcm5pbmdzIGxpa2UgdHJh
aWxpbmcgc3BhY2UuDQo+IA0KDQpNeSBhcG9sb2dpZXMsIGJ1dMKgSSB0aGluayBJIGRpZCBub3Qg
dXNlIHRoZSBsYXRlc3QgbWFzdGVyIHZlcnNpb24uDQpJIHdpbGwgdGFrZSBub3RlIG9mIHRoaXMu
DQoNCj4gQXBwbHlpbmc6IGR0OiBuYW5kOiBhZGQgY2FkZW5jZSBuYW5kIGR0LWJpbmRpbmdzDQo+
IEFwcGx5aW5nOiBhcm06IGR0czogYWdpbGV4NTogRW5hYmxlZCBjZG5zLW5hbmQgZHRzIHNldHRp
bmcNCj4gQXBwbHlpbmc6IGRyaXZlcnM6IG10ZDogbmFuZDogQWRkIGRyaXZlciBmb3IgQ2FkZW5j
ZSBOYW5kDQo+IEFwcGx5aW5nOiBkcml2ZXJzOiBtdGQ6IG5hbmQ6IGNhZGVuY2U6IEFkZCBzdXBw
b3J0IGZvciByZWFkIHN0YXR1cyBjb21tYW5kDQo+IEFwcGx5aW5nOiBkcml2ZXJzOiBtdGQ6IG5h
bmQ6IGNhZGVuY2U6IEFkZCBzdXBwb3J0IGZvciByZWFkaWQgY29tbWFuZA0KPiBBcHBseWluZzog
ZHJpdmVyczogbXRkOiBuYW5kOiBjYWRlbmNlOiBBZGQgc3VwcG9ydCBmb3IgTkFORF9DTURfUEFS
QU0NCj4gQXBwbHlpbmc6IGRyaXZlcnM6IG10ZDogbmFuZDogY2FkZW5jZTogQWRkIHN1cHBvcnQg
Zm9yIE5BTkRfQ01EX1JFU0VUDQo+IEFwcGx5aW5nOiBkcml2ZXJzOiBtdGQ6IG5hbmQ6IGNhZGVu
Y2U6IFN1cHBvcnQgY21kIFNFVF9GRUFUVVJFUyAmDQo+IEdFVF9GRUFUVVJFUw0KPiBBcHBseWlu
ZzogZHJpdmVyczogbXRkOiBuYW5kOiBjYWRlbmNlOiBGbHVzaCAmIGludmFsaWRhdGUgZG1hIGRl
c2NyaXB0b3INCj4gQXBwbHlpbmc6IGRyaXZlcnM6IG10ZDogbmFuZDogY2FkZW5jZTogUG9sbCBm
b3IgZGVzYyBjb21wbGV0ZSBzdGF0dXMNCj4gQXBwbHlpbmc6IGRyaXZlcnM6IG10ZDogbmFuZDog
Y2FkZW5jZTogVXNlIGJvdW5jZSBidWZmZXINCj4gQXBwbHlpbmc6IGRyaXZlcnM6IG5hbmQ6IEVu
YWJsZWQgS2NvbmZpZyBhbmQgTWFrZWZpbGUgZm9yIGNkbnMtbmFuZA0KPiBBcHBseWluZzogY29u
ZmlnczogbmFuZDJfZGVmY29uZmlnOiBFbmFibGUgY29uZmlncyBmb3IgbmFuZCBib290DQo+IEFw
cGx5aW5nOiBkcml2ZXJzOiBtdGQ6IG5hbmQ6IGJhc2U6IEFkZCBzdXBwb3J0IGZvciBIYXJkd2Fy
ZSBFQ0MgZm9yIGNoZWNrIGJhZA0KPiBibG9jaw0KPiBBcHBseWluZzogZHJpdmVyczogbXRkOiBu
YW5kOiBzcGw6IEFkZCBzdXBwb3J0IGZvciBuYW5kIFNQTCBsb2FkIGltYWdlDQo+IC5naXQvcmVi
YXNlLWFwcGx5L3BhdGNoOjE5OiB0cmFpbGluZyB3aGl0ZXNwYWNlLg0KPiAgKiBDb3B5cmlnaHQg
KEMpIDIwMjQgSW50ZWwgQ29ycG9yYXRpb24gPHd3dy5pbnRlbC5jb20+DQo+IHdhcm5pbmc6IDEg
bGluZSBhZGRzIHdoaXRlc3BhY2UgZXJyb3JzLg0KPiANCj4gQXBhcnQgb2YgdGhhdA0KPiANCj4g
cHBseWluZzogZHJpdmVyczogbXRkOiBuYW5kOiBFbmFibGVkIEtjb25maWcgYW5kIE1ha2VmaWxl
IGZvcg0KPiBTUExfTkFORF9GUkFNRVdPUksNCj4gZXJyb3I6IHBhdGNoIGZhaWxlZDogZHJpdmVy
cy9tdGQvbmFuZC9yYXcvTWFrZWZpbGU6Mw0KPiBlcnJvcjogZHJpdmVycy9tdGQvbmFuZC9yYXcv
TWFrZWZpbGU6IHBhdGNoIGRvZXMgbm90IGFwcGx5IFBhdGNoIGZhaWxlZCBhdCAwMDE3DQo+IGRy
aXZlcnM6IG10ZDogbmFuZDogRW5hYmxlZCBLY29uZmlnIGFuZCBNYWtlZmlsZSBmb3IgU1BMX05B
TkRfRlJBTUVXT1JLDQo+IGhpbnQ6IFVzZSAnZ2l0IGFtIC0tc2hvdy1jdXJyZW50LXBhdGNoPWRp
ZmYnIHRvIHNlZSB0aGUgZmFpbGVkIHBhdGNoIFdoZW4geW91DQo+IGhhdmUgcmVzb2x2ZWQgdGhp
cyBwcm9ibGVtLCBydW4gImdpdCBhbSAtLWNvbnRpbnVlIi4NCj4gSWYgeW91IHByZWZlciB0byBz
a2lwIHRoaXMgcGF0Y2gsIHJ1biAiZ2l0IGFtIC0tc2tpcCIgaW5zdGVhZC4NCj4gVG8gcmVzdG9y
ZSB0aGUgb3JpZ2luYWwgYnJhbmNoIGFuZCBzdG9wIHBhdGNoaW5nLCBydW4gImdpdCBhbSAtLWFi
b3J0Ii4NCj4gDQo+IEkgd2lsbCByZXZpZXcgdGhlIHJlc3QNCj4gDQo+IE1pY2hhZWwNCj4gDQoN
ClRoYW5rcyBmb3IgeW91ciB0aW1lIQ0KIFBsZWFzZSBsZXQgbWUga25vdyBpZiB5b3Ugd2FudCBt
ZSB0byByZXN1Ym1pdCB0aGUgcGF0Y2hzZXQgdXNpbmcgdGhlIGxhdGVzdCBtYXN0ZXIuDQoNCkRp
bmVzaA0KDQo+ID4gUGF0Y2ggc3RhdHVzOg0KPiA+IEhhdmUgY2hhbmdlczogQWxsIHBhdGNoZXMg
ZXhwZWN0IFBhdGNoIDE5DQo+ID4NCj4gPiBEZXRhaWwgY2hhbmdlbG9nIGNhbiBmaW5kIGluIGNv
bW1pdCBtZXNzYWdlLg0KPiA+DQo+ID4gdjEtPnYyOg0KPiA+IC0tLS0tLS0tDQo+ID4gUGF0Y2gg
MSAtIDE4Og0KPiA+DQo+ID4gLSByZW1vdmUgdGhlICJ0aGlzIHBhdGNoIGlzIHRvIiBjb21taXQg
cGhyYXNlcw0KPiA+DQo+ID4gUGF0Y2ggNDsNCj4gPiAtIG1pbm9yIHJlZmFjdG9yaW5nIG9mIGNv
ZGUgdG8gbWF0Y2ggdGhlIHN0YWJsZSB2ZXJzaW9uIDYuMTEuMi4NCj4gPg0KPiA+IFBhdGNoIDE0
Og0KPiA+IC0gQWRkIG1haW50YWluZXIgYW5kICIjaW5jbHVkZSIgbWVjaGFuaXNtIGZvciBuZXcg
dmFyaWFudA0KPiA+DQo+ID4gUGF0Y2ggMTY6DQo+ID4gLSBsZXZlcmFnZSB0aGUgZXhpc3Rpbmcg
bmFuZF9zcGxfbG9hZF9pbWFnZQ0KPiA+DQo+ID4gdjItPnYzOg0KPiA+IC0tLS0tLS0tDQo+ID4g
UGF0Y2g6IGFybTogZHRzOiBhZ2lsZXg1OiBFbmFibGVkIGNkbnMtbmFuZCBkdHMgc2V0dGluZw0K
PiA+IC0gTW92ZSAmbmFuZCBmcm9tIHVib290LmR0c2kgdG8gc29jZGsuZHRzDQo+ID4NCj4gPiBQ
YXRjaDogaW5jbHVkZTogYXNtOiBBZGQgc3VwcG9ydCB0byByZWFkL3dyaXRlIDY0LWJpdA0KPiA+
IC0gRHJvcHBlZCBiZWNhdXNlIHJlZGVmaW5pdGlvbiBvZiByZWFkc3EgJiB3cml0ZXNxDQo+ID4N
Cj4gPiBQYXRjaDogZHJpdmVyczogbXRkOiBuYW5kOiBBZGQgZHJpdmVyIGZvciBDYWRlbmNlIE5h
bmQNCj4gPiAtIFJlbW92ZSByZWR1bmRhbnQgY2xrX2ZyZWUgZnVuYw0KPiA+DQo+ID4gUGF0Y2g6
IGRyaXZlcnM6IG10ZDogbmFuZDogRW5hYmxlZCBLY29uZmlnIGFuZCBNYWtlZmlsZSBmb3INCj4g
PiBTUExfTkFORF9GUkFNRVdPUksNCj4gPiAtIE5ldw0KPiA+DQo+ID4gUGF0Y2g6IGRyaXZlcnM6
IG10ZDogbmFuZDogS2NvbmZpZzogQWRkIFNZU19OQU5EX1BBR0VfU0laRSBkZXBlbmRlbmN5DQo+
ID4gLSBOZXcNCj4gPg0KPiA+IFBhdGNoOiBjb25maWdzOiBuYW5kMl9kZWZjb25maWc6IEVuYWJs
ZSBjb25maWdzIGZvciBuYW5kIGJvb3QNCj4gPiAtIFJlbW92ZSBDT05GSUdfT0ZfVVBTVFJFQU0g
aW4gb3JkZXIgdG8gZ2V0IGNvcnJlY3QgZHRzIGZvcg0KPiA+IGNvbXBpbGF0aW9uDQo+ID4NCj4g
PiBQYXRjaDogZHJpdmVyczogbXRkOiBuYW5kOiBiYXNlOiBBZGQgc3VwcG9ydCBmb3IgSGFyZHdh
cmUgRUNDIGZvcg0KPiA+IGNoZWNrIGJhZCBibG9jaw0KPiA+IC0gUmVtb3ZlIGNvcHlyaWdodA0K
PiA+DQo+ID4gUGF0Y2g6IGRyaXZlcnM6IG10ZDogbmFuZDogS2NvbmZpZzogUmVtb3ZlIFNZU19O
QU5EX0JMT0NLX1NJWkUNCj4gPiBkZXBlbmRlbmN5DQo+ID4gLSBEcm9wcGVkIGJlY2F1c2UgU1BM
IE5BTkQgaGF2ZSBkZXBlbmRlbmN5IHdpdGggU1lTX05BTkRfQkxPQ0tfU0laRQ0KPiA+DQo+ID4g
SGlzdG9yeToNCj4gPiAtLS0tLS0tLQ0KPiA+IFt2MV06DQo+ID4gaHR0cHM6Ly9wYXRjaHdvcmsu
b3psYWJzLm9yZy9wcm9qZWN0L3Vib290L2NvdmVyLzIwMjQwOTE5MDM1NTEyLjEzODU0LQ0KPiA+
IDEtZGluZXNoLm1hbml5YW1AaW50ZWwuY29tLw0KPiA+IFt2Ml06DQo+ID4gaHR0cHM6Ly9wYXRj
aHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L3Vib290L2NvdmVyLzIwMjQxMjA1MDkyMzE1LjI1MDYw
LQ0KPiA+IDEtZGluZXNoLm1hbml5YW1AaW50ZWwuY29tLw0KPiA+DQo+ID4gRGluZXNoIE1hbml5
YW0gKDE5KToNCj4gPiAgIGR0OiBuYW5kOiBhZGQgY2FkZW5jZSBuYW5kIGR0LWJpbmRpbmdzDQo+
ID4gICBhcm06IGR0czogYWdpbGV4NTogRW5hYmxlZCBjZG5zLW5hbmQgZHRzIHNldHRpbmcNCj4g
PiAgIGRyaXZlcnM6IG10ZDogbmFuZDogQWRkIGRyaXZlciBmb3IgQ2FkZW5jZSBOYW5kDQo+ID4g
ICBkcml2ZXJzOiBtdGQ6IG5hbmQ6IGNhZGVuY2U6IEFkZCBzdXBwb3J0IGZvciByZWFkIHN0YXR1
cyBjb21tYW5kDQo+ID4gICBkcml2ZXJzOiBtdGQ6IG5hbmQ6IGNhZGVuY2U6IEFkZCBzdXBwb3J0
IGZvciByZWFkaWQgY29tbWFuZA0KPiA+ICAgZHJpdmVyczogbXRkOiBuYW5kOiBjYWRlbmNlOiBB
ZGQgc3VwcG9ydCBmb3IgTkFORF9DTURfUEFSQU0NCj4gPiAgIGRyaXZlcnM6IG10ZDogbmFuZDog
Y2FkZW5jZTogQWRkIHN1cHBvcnQgZm9yIE5BTkRfQ01EX1JFU0VUDQo+ID4gICBkcml2ZXJzOiBt
dGQ6IG5hbmQ6IGNhZGVuY2U6IFN1cHBvcnQgY21kIFNFVF9GRUFUVVJFUyAmIEdFVF9GRUFUVVJF
Uw0KPiA+ICAgZHJpdmVyczogbXRkOiBuYW5kOiBjYWRlbmNlOiBGbHVzaCAmIGludmFsaWRhdGUg
ZG1hIGRlc2NyaXB0b3INCj4gPiAgIGRyaXZlcnM6IG10ZDogbmFuZDogY2FkZW5jZTogUG9sbCBm
b3IgZGVzYyBjb21wbGV0ZSBzdGF0dXMNCj4gPiAgIGRyaXZlcnM6IG10ZDogbmFuZDogY2FkZW5j
ZTogVXNlIGJvdW5jZSBidWZmZXINCj4gPiAgIGRyaXZlcnM6IG5hbmQ6IEVuYWJsZWQgS2NvbmZp
ZyBhbmQgTWFrZWZpbGUgZm9yIGNkbnMtbmFuZA0KPiA+ICAgY29uZmlnczogbmFuZDJfZGVmY29u
ZmlnOiBFbmFibGUgY29uZmlncyBmb3IgbmFuZCBib290DQo+ID4gICBkcml2ZXJzOiBtdGQ6IG5h
bmQ6IGJhc2U6IEFkZCBzdXBwb3J0IGZvciBIYXJkd2FyZSBFQ0MgZm9yIGNoZWNrIGJhZA0KPiA+
ICAgICBibG9jaw0KPiA+ICAgZHJpdmVyczogbXRkOiBuYW5kOiBzcGw6IEFkZCBzdXBwb3J0IGZv
ciBuYW5kIFNQTCBsb2FkIGltYWdlDQo+ID4gICBkcml2ZXJzOiBtdGQ6IG5hbmQ6IEVuYWJsZWQg
S2NvbmZpZyBhbmQgTWFrZWZpbGUgZm9yIENhZGVuY2UtU1BMDQo+ID4gICBkcml2ZXJzOiBtdGQ6
IG5hbmQ6IEVuYWJsZWQgS2NvbmZpZyBhbmQgTWFrZWZpbGUgZm9yDQo+ID4gICAgIFNQTF9OQU5E
X0ZSQU1FV09SSw0KPiA+ICAgZHJpdmVyczogbXRkOiBuYW5kOiBLY29uZmlnOiBBZGQgU1lTX05B
TkRfUEFHRV9TSVpFIGRlcGVuZGVuY3kNCj4gPiAgIGRyaXZlcnM6IG10ZDogbmFuZDogS2NvbmZp
ZzogRW5hYmxlZCBzZWxmLWluaXQgZm9yIGNkbnMtbmFuZCBTUEwNCj4gPg0KPiA+ICBhcmNoL2Fy
bS9kdHMvc29jZnBnYV9hZ2lsZXg1LmR0c2kgICAgICAgICAgICAgfCAgIDE0ICsNCj4gPiAgLi4u
L2FybS9kdHMvc29jZnBnYV9hZ2lsZXg1X3NvY2RrLXUtYm9vdC5kdHNpIHwgICAgOSArLQ0KPiA+
ICBhcmNoL2FybS9kdHMvc29jZnBnYV9hZ2lsZXg1X3NvY2RrLmR0cyAgICAgICAgfCAgIDE5ICsN
Cj4gPiAgYm9hcmQvaW50ZWwvYWdpbGV4NS1zb2Nkay9NQUlOVEFJTkVSUyAgICAgICAgIHwgICAg
MiArDQo+ID4gIGNvbmZpZ3Mvc29jZnBnYV9hZ2lsZXg1X25hbmQyX2RlZmNvbmZpZyAgICAgICB8
ICAgMzIgKw0KPiA+ICAuLi4vbXRkL2NhZGVuY2UsbmFuZC55YW1sICAgICAgICAgICAgICAgICAg
ICAgfCAgIDk4ICsNCj4gPiAgZHJpdmVycy9tdGQvbmFuZC9yYXcvS2NvbmZpZyAgICAgICAgICAg
ICAgICAgIHwgICAyNiArLQ0KPiA+ICBkcml2ZXJzL210ZC9uYW5kL3Jhdy9NYWtlZmlsZSAgICAg
ICAgICAgICAgICAgfCAgIDEyICsNCj4gPiAgZHJpdmVycy9tdGQvbmFuZC9yYXcvY2FkZW5jZV9u
YW5kLmMgICAgICAgICAgIHwgMjQyMyArKysrKysrKysrKysrKysrKw0KPiA+ICBkcml2ZXJzL210
ZC9uYW5kL3Jhdy9jYWRlbmNlX3NwbC5jICAgICAgICAgICAgfCAgIDU5ICsNCj4gPiAgZHJpdmVy
cy9tdGQvbmFuZC9yYXcvbmFuZF9iYXNlLmMgICAgICAgICAgICAgIHwgICA2OSArLQ0KPiA+ICBp
bmNsdWRlL2NhZGVuY2UtbmFuZC5oICAgICAgICAgICAgICAgICAgICAgICAgfCAgNTI5ICsrKysN
Cj4gPiAgaW5jbHVkZS9saW51eC9tdGQvcmF3bmFuZC5oICAgICAgICAgICAgICAgICAgIHwgICAx
MiArDQo+ID4gIDEzIGZpbGVzIGNoYW5nZWQsIDMyNzggaW5zZXJ0aW9ucygrKSwgMjYgZGVsZXRp
b25zKC0pICBjcmVhdGUgbW9kZQ0KPiA+IDEwMDY0NCBjb25maWdzL3NvY2ZwZ2FfYWdpbGV4NV9u
YW5kMl9kZWZjb25maWcNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRvYy9kZXZpY2UtdHJlZS1i
aW5kaW5ncy9tdGQvY2FkZW5jZSxuYW5kLnlhbWwNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRy
aXZlcnMvbXRkL25hbmQvcmF3L2NhZGVuY2VfbmFuZC5jDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0
NCBkcml2ZXJzL210ZC9uYW5kL3Jhdy9jYWRlbmNlX3NwbC5jDQo+ID4gIGNyZWF0ZSBtb2RlIDEw
MDY0NCBpbmNsdWRlL2NhZGVuY2UtbmFuZC5oDQo+ID4NCj4gPiAtLQ0KPiA+IDIuMTkuMA0KPiA+
DQo+IA0KPiANCj4gLS0NCj4gTWljaGFlbCBOYXp6YXJlbm8gVHJpbWFyY2hpDQo+IENvLUZvdW5k
ZXIgJiBDaGllZiBFeGVjdXRpdmUgT2ZmaWNlcg0KPiBNLiArMzkgMzQ3IDkxMyAyMTcwDQo+IG1p
Y2hhZWxAYW1hcnVsYXNvbHV0aW9ucy5jb20NCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXw0KPiANCj4gQW1hcnVsYSBTb2x1dGlvbnMgQlYNCj4gSm9vcCBHZWVzaW5rd2VnIDEy
NSwgMTExNCBBQiwgQW1zdGVyZGFtLCBOTCBULiArMzEgKDApODUgMTExIDkxNzINCj4gaW5mb0Bh
bWFydWxhc29sdXRpb25zLmNvbSB3d3cuYW1hcnVsYXNvbHV0aW9ucy5jb20NCg==
