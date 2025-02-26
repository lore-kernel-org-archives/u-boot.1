Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 474F4C021BF
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 03:37:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72A6680805;
	Wed, 26 Feb 2025 04:37:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="X7MCVrgb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7712F8081A; Wed, 26 Feb 2025 04:37:50 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0CC7807EE
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 04:37:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740541067; x=1772077067;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+MxD5FqhnnLpyfQaQ3boLO9Yf4YbFqSrjlH609BYy7Y=;
 b=X7MCVrgbj83ajSfgSomeAawQUHmKwz53pptnajkZcGbqr3vbzyYnk0ze
 SSJ/1uO4I4iUoVI+V+9kcXmDZW9bd568BE4avPTJYrBGxSnKWeFCKo4Yg
 oKteETjcSsyp5lUik8KBv9v7m8feUBMdFeavpBoVvYS2pLs1TZEUnwy4r
 SrluOkHywuysMAdG8RiG8eqNn3nxYePuHlYhNeZvdWjAF4y0BOQuKS1Ch
 D41vPrFeCuQtTx1huRGOIbGHMqJZBS/OLDrdIdtfra4t9oOdC1BycxZSA
 QQ4pRu1SVhCKQqksuokgMtTnmIlWLR9R4a2ZMhEGt673AD72Ga0HoOUOv A==;
X-CSE-ConnectionGUID: qWqNXjpNRNqTtbDOf8iDew==
X-CSE-MsgGUID: gQMwi3P5TrehgpsE4s4GnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="52008963"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; d="scan'208";a="52008963"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2025 19:37:30 -0800
X-CSE-ConnectionGUID: BOSohOTBSOWd97iNTsZEvA==
X-CSE-MsgGUID: HdmgUDusT3OCRD9gpnNn5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; d="scan'208";a="139810100"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 25 Feb 2025 19:37:30 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 25 Feb 2025 19:37:29 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Feb 2025 19:37:29 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 19:37:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WvnZxhDp9Rchxd8FDMtLF2UNTtG+8DDrKEymdHUKQz2kt8lgr7RY+UFLGP3xYrA755zfx4+zcWsdYNFmjRdBFuryPcvG7JclTj/DRVqykyTiAyhOmDFVTtwteZlytlf+2NqFVp4rLXXxQ3w3tOgTnA6KpUzSSUo7AsaGjEHGgA0wWWZteOHIAnVfx9+9zXWJpnmf5m7vfi6mTNDKlfMIuDFIrTjOdxgsWtFdRlAu65qXtXz7Teq5Xgz80GmMGjYhoSADfZIqFaT3J/EbQgb3fGIvH1eRy/HnSQPoRGEVshm6YvpR17wnK3MXzTNMH2VKncO8Sip6pvkiRRFBGZxrlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MxD5FqhnnLpyfQaQ3boLO9Yf4YbFqSrjlH609BYy7Y=;
 b=PajFCMs+LO8R9F2/Gu2krLY5Azns2SVzlDXxoThjQxOEBvDN+MuKEm5nBOifRfGTZyoSH1o4qa9IX4kpiOdfbdKIk8WQe9A8RQiUw0AcnD2Zeppc5SWS3RdOsp69YuArDhhN1KFiiNPh5GTF7bbeab1q7uFE87LUX7InzZF+5Lf1Eq78m3LGJGFDIzOjvybyGlzur/I0MVwgeCy89NWiYSfioj5ohF7r0ECnyZ3xyc8wprGjKTLcFk+u7owMkY4Cui/j6foLKmZqkLewToVzpJlr7NIbBTpIBAVOrPJ1DP+rPaQKK2bUC091dUaPQ5ih/tiOeizYw1+Vdy3eH+q3Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5366.namprd11.prod.outlook.com (2603:10b6:208:31c::17)
 by LV8PR11MB8769.namprd11.prod.outlook.com (2603:10b6:408:204::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Wed, 26 Feb
 2025 03:37:21 +0000
Received: from BL1PR11MB5366.namprd11.prod.outlook.com
 ([fe80::f073:1e46:c7ee:df9b]) by BL1PR11MB5366.namprd11.prod.outlook.com
 ([fe80::f073:1e46:c7ee:df9b%7]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 03:37:21 +0000
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
Thread-Index: AQHbRvdcQWgz78qVlUqpVYczLsrbnbLj8XAAgAYr1NCANxKuMIAGbQMAgDHTXBA=
Date: Wed, 26 Feb 2025 03:37:21 +0000
Message-ID: <BL1PR11MB5366E83B40C89039B05C936C82C22@BL1PR11MB5366.namprd11.prod.outlook.com>
References: <20241205092315.25060-1-dinesh.maniyam@intel.com>
 <CAOf5uwmPuQOsfXFPZ6Y35E5dWq=bYJNtKRRyVv0Md+ugiPFyPA@mail.gmail.com>
 <BL1PR11MB5366537A8281795B152B69AD82042@BL1PR11MB5366.namprd11.prod.outlook.com>
 <BL1PR11MB536639809DBC02823E22549B82E62@BL1PR11MB5366.namprd11.prod.outlook.com>
 <CAOf5uwmP_u49=axD9Hod3aYLDBNn4Wzz4Th7tK+UsFoCEE23Dg@mail.gmail.com>
In-Reply-To: <CAOf5uwmP_u49=axD9Hod3aYLDBNn4Wzz4Th7tK+UsFoCEE23Dg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5366:EE_|LV8PR11MB8769:EE_
x-ms-office365-filtering-correlation-id: 5bc33ea6-c49d-47da-520f-08dd5616e07f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700018|13003099007; 
x-microsoft-antispam-message-info: =?utf-8?B?Z0doQXlxbHB2ZXI5STVQbktyUzdMekk3K1RqVGU3RjJZb3ZXS1RTMnZsUXFq?=
 =?utf-8?B?SzlXNDVhbnE0TnZ0ZTVXMG5VY005NzVUKzJ0bnVWeUZzRWlEVW0yVVZ1NE5l?=
 =?utf-8?B?bGhSRXJzTG1xakdleEg2Y1ZwMUhlaTMwL3I2dWc2Sm9CRDZzSkZ4UmNKNkNt?=
 =?utf-8?B?SlYvbTRvckZqaElpa1drMFZkYWc1RUFXQW92QlJteHJDQXF4NDNZdUNPT1lY?=
 =?utf-8?B?eHJiVHpEMDYrVmlNZ3hoZmwvTUw3THdmT28xbWdKR3lGTG9mWUFIZTBxczVm?=
 =?utf-8?B?Z2NYcXQyZWZnY3ZFZTBFSDl4T3RPQUFwd2FBZHA3bEVkMWlqcExxUDhHakZT?=
 =?utf-8?B?UjhMRTRaa1NqUG91Q2QxdisrVm9NZWo2R0FDemd6NDMwRXJoL2Q2WXRWam92?=
 =?utf-8?B?TnZWSHQ5VnpkL3l2emhpYnZaWktpbm5oT0VONWxrcERwbmk1b1BGL3h3K1Nt?=
 =?utf-8?B?Zzl6SXBINVQxeE5pQ1FLeXVidi9sUWpmSXpDZWYyN0FROFVCK3pRUTZrZzZ4?=
 =?utf-8?B?OEl5VHFRc2FMK1AxeUtodDlGL3AvRW4yQUo3SnNISm16Z1VKZ3dBbGIrL2pq?=
 =?utf-8?B?YTJydGIvSUdxS3RiOUdBUlhXV0VtVFFLMnRzb0NOY1lxNzVud0kybm13NXEy?=
 =?utf-8?B?SGh1WGlxa3ovbW1aeERkUFRNNDNtTzk1YU45VDFBYlphbVM0VUNTMlI5bHVk?=
 =?utf-8?B?ekxCTkpESGN0QmFWbkFlYjhsK3JCZHdWQS95UE84V2tXQU5seXNhcFhZNkM1?=
 =?utf-8?B?L0lHT0pET2tFM1JTb1N4ak5XOFVTSjZjd1NTbHBzS3lGcU44WTZYbnpPcFFX?=
 =?utf-8?B?cWRDTEJKTHJ4Tk56KytZN2pHRmlkZmk3aWloQXE4MCtSaWxaUU5tK0xzYnNu?=
 =?utf-8?B?Kzc3N3hzN1p1RjJxd3hNcGdwdVBqTFZRL0dmekhmVlRYZCtlZjhKSFdOY09x?=
 =?utf-8?B?R3NpMkt1T29pbXdVcTVqd2ZHdkpYOUJVcEdyZ05SdHVCVXE2SzIvcE15cEVZ?=
 =?utf-8?B?RlNaVU5xZ1FINEdXMkRtVDR0QTVBK0loNUhZR1BxYjFFcWM4KzNRZlpTVm51?=
 =?utf-8?B?KzZ4aklVWk94MXM3Y2ZEZXYxWVlTWmNmTWhGcGE3ZllYdDlJRmJmRkIyR1Vj?=
 =?utf-8?B?VXk0YldwTEg0b2kraVdnNldDSzFPZFQ3d2d1T2dkWGZzQTBxcnBwdkY5VU9G?=
 =?utf-8?B?d1owMk5vQkRVaTZFL0xHWGVReVh3ZnRBS01PM1I1ekdBYWZ4RnczQWh3YkQ2?=
 =?utf-8?B?SHh6R3R4Z2RsZjJMSXkwMzdvR1l5K2VyZW1MblVtUWw2WkdtWlhOSmU3SkFl?=
 =?utf-8?B?RWhsWFp0LzViUExoRlJGK3RSSmVpOFlBUkZGamhHNjBxK05PQTltajlzbkhx?=
 =?utf-8?B?NVB2RHJYdnYrUkNlbnpXVlFBR3h5Y3RXcHNoQzFVS1VnTndwV2g5OTRGNFRw?=
 =?utf-8?B?SDFwSmduSmZKaFZwby95TXd0RXRuejl4d216RURqSjlINmZiS2wvdmZndWp6?=
 =?utf-8?B?Mmc5WGVaOTZMQ2FIczc2emVQYTNQY1RuT1E5MzE3VlcwMkxpWWRvK3JLc1Ar?=
 =?utf-8?B?b2QrRnAyNDY3TU5nRGtjRUw3UlQyYnB2M1JMS2ZVOFpaYVNtZG4vREk5RndF?=
 =?utf-8?B?TXdPUzNhN1RGTUgrUFZJbVUwdWRnWUM3a29SSFlSKzArQlR3bmRiN0w3QWpw?=
 =?utf-8?B?N0hLNzRSQXJGSEMxVW5zWnB0WGdTRnpHNEVhS0g1MFVRNUh5ckV0dUE4Mk5H?=
 =?utf-8?B?cEhRZFk4R1lCNkQwVU5DemJmeGxGV3RqbHFvVHVyT29BeVRkYUdrK3p6Rzcr?=
 =?utf-8?B?b3lZYW1CRXFpWlBTcFpURDRQSWV1OEJBZyt3ZUIxd0xTU1hMNUQ2R09wa1E3?=
 =?utf-8?Q?pro53VTikfJ8d?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR11MB5366.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018)(13003099007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0p1SysrRXdKbXFyam5XVnRvb1VaVi8xVUV1aTBoMGRRUFozaS9EUW5jN2pR?=
 =?utf-8?B?a0tMb04yZEJLTVljak11c2N5RGtYKzlveFUvRUFLRlpSdm1FQnVRc3ZIZ1Bu?=
 =?utf-8?B?NEpoQ0NMMjVXQlgzSXUyRFV3dDg3NTBYVkF5MTR0Mi9hcFRvb3BxazgzVTBh?=
 =?utf-8?B?Vkp5YkJGWkRGdWoxWGNpRnFWcU54RnlkQk1qakZOdTNpNGwxMXl6NG5xdTBB?=
 =?utf-8?B?cU5JOFRtMFdyUm5IRUpRVXJVeXZMdEEvNnUwazFaendxVDEydzZxYUV3ejlE?=
 =?utf-8?B?QXc5RkNja2VNV3VVMHBiaW9VRG1QWWZvdjdEVmk1NEViYVRkRDZ3YTRyTDBq?=
 =?utf-8?B?dDQ4MEhpaW00ZTFKZW9KYzd1T1FnNUpVVDRQaTJMbStnR29wcnJMUy9odWFw?=
 =?utf-8?B?TkcrVkJZUWRFUE5CYmo1dVVyRGRDNEFKbDRxMW9MY21yRzhkR2V3YW5ibWRn?=
 =?utf-8?B?eGtiS0gyOUZZeWMwQytEZWJQRmZHbTdTY2ZHSGtNM0hZSngvMXJpakc4VG4r?=
 =?utf-8?B?VFpiV2NTcmlTeW5jcGFsRWtNdU1aL05DYVpBaXpEMjlvYWFDS2xNdmlSeUtZ?=
 =?utf-8?B?bk1rS2x2N1lJMG1VUmMwdmNDMXVtVnZUaW4vNDFVem1CVlF3bjNkUWExQmxF?=
 =?utf-8?B?bE5LY0gxSGxJc1N0bDc1TXI5dXhyb2tQN1Z3bTZxRGhiS3hUYXl3dzBNL3NX?=
 =?utf-8?B?WGljTjdySEwzVjhpekhzaWQyd2NoRS9xcHhJZzlDSlVPSHBTSVZ6SmpySjdE?=
 =?utf-8?B?TjNXYkZnaExWLy96bkpEendldU5TbFUwVDA3UDBoeFlMNXRYMXlqa0pXWFdT?=
 =?utf-8?B?aXlpdXo3VUtZOGdQaXV1SjA0MjZFU3lPUmNvOGdVVDhYU3VjQUlpVThaRFhQ?=
 =?utf-8?B?UWxwM0R1ckRKZHdISWNYQTQzWEpUN3lSdVd5VzZnN1hiWVArK0RCR0owOGlk?=
 =?utf-8?B?a2Z4RExyTU5COVo0bW9icWZvYS93WWhLUnF2VCtzV2N6UzdaUURWeVFaSGF4?=
 =?utf-8?B?NW1zSlUvcVFybCtJWE1HL2Ryejc0OUhOajZIV1JTUWYrWFlUdU8xeTkvUU1h?=
 =?utf-8?B?UXZMYythWVdZWVpuMmhTQnpyU3ZoamdxZmIrUWdzbStMMWU1dmxFeTNNaFJP?=
 =?utf-8?B?MFpzQ1RmOFFnZ3VVK2RVK2xBbnVHWXRjbGN4WnllMFMrOEV6Yk1qYk9CVE9P?=
 =?utf-8?B?MzA4SEx6M0UyWjdQYTlTRXNVTHlUZCtXeHhsZXo5TUVSK2hpY3ZTYUh4QnB4?=
 =?utf-8?B?TzNnU3RQbG43MGpEd1lLNGQ3VFFEb0VUbmNwMDhhb0RwRk01dVRFUXFsbW9v?=
 =?utf-8?B?Ty91VWt1dmF3SHhwR2h5Ym11MW0vdkFDRnpNN2NXenpyS2dqUmhERU9rYVJ3?=
 =?utf-8?B?NUtVK3Y1VkR6U2diSXVBNGZ2dWk3Z0JOR1NFVHl6QUZGYU1HaDM5aXd5UWw1?=
 =?utf-8?B?eGxYTnlTVFpnUm1OSlFRcWFWZEl6bVI5R3pOQm1rR0JmZzRkOGpvc1piYjRF?=
 =?utf-8?B?VGNCcHRFZ1IzMkFvUjlQYmFHM3IxdmRjUmx4TmVISTZ2NExBeHFyZmFyK0Y4?=
 =?utf-8?B?cFM0d0lLKzZqUmdtd29JcVIvenVlOWU5Y2hFVGw4UEk5K212aGlTaGFuek03?=
 =?utf-8?B?d1pJYUw0cURLck9scVRxZ2dxT2xoSFk3MW8yalZpZUtROEliK0FCWG1SRjdK?=
 =?utf-8?B?NFhSVndlaGh3dDlCSlFWMUptQnlFU3NPSWJ6aFJ4NGJwcUUzanVPUnZXS3pM?=
 =?utf-8?B?RXNKOTJqTW5MeTF3RFN3WGJIcDh3UVpXQ0FROE80YUI3b1NHWFVEZEhQUnpy?=
 =?utf-8?B?QzBpUlV2Tk1lVDVmbHFETzNvL09VL3lCbXk5aVlmUXNlM3J1Y2FQeU96QlV5?=
 =?utf-8?B?eHVXT3hLM04zWVd5b0VsZk1xZjZUNDJkSzM4K3RhRGFrSDBZVlk4cGkrbWpq?=
 =?utf-8?B?QTdxbnNZbng5cm02TGtSNnlYWW9MSUJ0SEFVbHR5L0U0TGlmTEhySnJGc1Bp?=
 =?utf-8?B?bGxqdGYvdjhmc0QwNG15RDdiL0ZLNGVHdGZ0YTc0U1hsczBKUmZLQ0lMS2JS?=
 =?utf-8?B?dk5TNFRDdUVyd3p4a2F4SXdFSnZpd1NFR1ZTeVpNblU1US85MUc5djBPY2xT?=
 =?utf-8?Q?EOvKtuuKDAcfc+BQURZTKY121?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc33ea6-c49d-47da-520f-08dd5616e07f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 03:37:21.2155 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lMLcPmryzid591t+DFC5HBf641H+LBiPXZvuEff1TdjVnsBIa1Z9rmsobFw0blFZEOGAYZgKVBAR0ZVAYL9bqdcjIxJPvazxtptdQg/q+F4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8769
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
bm8gVHJpbWFyY2hpIDxtaWNoYWVsQGFtYXJ1bGFzb2x1dGlvbnMuY29tPg0KPiBTZW50OiBTYXR1
cmRheSwgMjUgSmFudWFyeSAyMDI1IDY6NDAgcG0NCj4gVG86IE1hbml5YW0sIERpbmVzaCA8ZGlu
ZXNoLm1hbml5YW1AaW50ZWwuY29tPg0KPiBDYzogdS1ib290QGxpc3RzLmRlbnguZGU7IE1hcmVr
IDxtYXJleEBkZW54LmRlPjsgU2ltb24NCj4gPHNpbW9uLmsuci5nb2xkc2NobWlkdEBnbWFpbC5j
b20+OyBUb20gUmluaSA8dHJpbmlAa29uc3Vsa28uY29tPjsgRGFyaW8NCj4gQmluYWNjaGkgPGRh
cmlvLmJpbmFjY2hpQGFtYXJ1bGFzb2x1dGlvbnMuY29tPjsgSm9oYW4gSm9ua2VyDQo+IDxqYng2
MjQ0QGdtYWlsLmNvbT47IE1pY2hhbCBTaW1layA8bWljaGFsLnNpbWVrQGFtZC5jb20+OyBBcnNl
bml5DQo+IEtyYXNub3YgPGF2a3Jhc25vdkBzYWx1dGVkZXZpY2VzLmNvbT47IEFsZXhhbmRlciBE
YWhsIDxhZGFAdGhvcnNpcy5jb20+Ow0KPiBXaWxsaWFtIFpoYW5nIDx3aWxsaWFtLnpoYW5nQGJy
b2FkY29tLmNvbT47IElnb3IgUHJ1c292DQo+IDxpdnBydXNvdkBzYWx1dGVkZXZpY2VzLmNvbT47
IE1lbmcsIFRpbmd0aW5nIDx0aW5ndGluZy5tZW5nQGludGVsLmNvbT47DQo+IENoZWUsIFRpZW4g
Rm9uZyA8dGllbi5mb25nLmNoZWVAaW50ZWwuY29tPjsgSGVhLCBLb2sgS2lhbmcNCj4gPGtvay5r
aWFuZy5oZWFAaW50ZWwuY29tPjsgTmcsIEJvb24gS2hhaSA8Ym9vbi5raGFpLm5nQGludGVsLmNv
bT47IFl1c2xhaW1pLA0KPiBBbGlmIFpha3VhbiA8YWxpZi56YWt1YW4ueXVzbGFpbWlAaW50ZWwu
Y29tPjsgWmFtcmksIE11aGFtbWFkIEhhemltIEl6emF0DQo+IDxtdWhhbW1hZC5oYXppbS5penph
dC56YW1yaUBpbnRlbC5jb20+OyBMaW0sIEppdCBMb29uDQo+IDxqaXQubG9vbi5saW1AaW50ZWwu
Y29tPjsgVGFuZywgU2lldSBNdW4gPHNpZXUubXVuLnRhbmdAaW50ZWwuY29tPg0KPiBTdWJqZWN0
OiBSZTogW3Jlc2VuZCB2MiAwMC8xOV0gQWRkIENhZGVuY2UgTkFORCBEcml2ZXIgc3VwcG9ydA0K
PiANCj4gSGkgRGluZXNoDQo+IA0KPiBPbiBUdWUsIEphbiAyMSwgMjAyNSBhdCA5OjM54oCvQU0g
TWFuaXlhbSwgRGluZXNoIDxkaW5lc2gubWFuaXlhbUBpbnRlbC5jb20+DQo+IHdyb3RlOg0KPiA+
DQo+ID4gSGkgTWljaGFlbCwNCj4gPg0KPiA+IEFueSB1cGRhdGUgb24gbXkgTkFORCBwYXRjaHNl
dCA/LiBJIGNhbiBzZWUgaXQgaXMgc3RpbGwgdW5kZXIgcmV2aWV3Lg0KPiA+IElzIHRoZXJlIGFu
eXRoaW5nIEkgY2FuIGRvIGZyb20gbXkgc2lkZSB0byBzcGVlZCB1cCB0aGUgcmV2aWV3IHByb2Nl
c3M/DQo+ID4gVGhhbmtzIGZvciB5b3VyIHRpbWUuDQo+ID4NCj4gDQo+IFdlbGwsIGxhc3QgdGlt
ZSB3YXMgbm90IHBhYXNzaW5nIHRoZSBDSS4gSSB3aWxsIHRlc3QgaXQgYWdhaW4gdG9kYXkNCj4g
DQo+IE1pY2hhZWwNCj4gDQoNCkhvcGUgeW91IGFscmVhZHkgcnVuIHRoZSBDSSB0ZXN0IGFnYWlu
Lg0KSWYgZmFpbGluZywgbWF5IEkgZ2V0IHRoZSBsaW5rIHRvIHRoZSBmYWlsaW5nIGxpc3Qgb2Yg
dGVzdHM/DQoNCkRpbmVzaA0KDQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+
ID4gRnJvbTogTWFuaXlhbSwgRGluZXNoDQo+ID4gPiBTZW50OiBUdWVzZGF5LCAxNyBEZWNlbWJl
ciAyMDI0IDM6NDEgcG0NCj4gPiA+IFRvOiBNaWNoYWVsIE5henphcmVubyBUcmltYXJjaGkgPG1p
Y2hhZWxAYW1hcnVsYXNvbHV0aW9ucy5jb20+DQo+ID4gPiBDYzogdS1ib290QGxpc3RzLmRlbngu
ZGU7IE1hcmVrIDxtYXJleEBkZW54LmRlPjsgU2ltb24NCj4gPiA+IDxzaW1vbi5rLnIuZ29sZHNj
aG1pZHRAZ21haWwuY29tPjsgVG9tIFJpbmkgPHRyaW5pQGtvbnN1bGtvLmNvbT47DQo+ID4gPiBE
YXJpbyBCaW5hY2NoaSA8ZGFyaW8uYmluYWNjaGlAYW1hcnVsYXNvbHV0aW9ucy5jb20+OyBKb2hh
biBKb25rZXINCj4gPiA+IDxqYng2MjQ0QGdtYWlsLmNvbT47IE1pY2hhbCBTaW1layA8bWljaGFs
LnNpbWVrQGFtZC5jb20+OyBBcnNlbml5DQo+ID4gPiBLcmFzbm92IDxhdmtyYXNub3ZAc2FsdXRl
ZGV2aWNlcy5jb20+OyBBbGV4YW5kZXIgRGFobA0KPiA+ID4gPGFkYUB0aG9yc2lzLmNvbT47IFdp
bGxpYW0gWmhhbmcgPHdpbGxpYW0uemhhbmdAYnJvYWRjb20uY29tPjsgSWdvcg0KPiA+ID4gUHJ1
c292IDxpdnBydXNvdkBzYWx1dGVkZXZpY2VzLmNvbT47IE1lbmcsIFRpbmd0aW5nDQo+ID4gPiA8
dGluZ3RpbmcubWVuZ0BpbnRlbC5jb20+OyBDaGVlLCBUaWVuIEZvbmcNCj4gPiA+IDx0aWVuLmZv
bmcuY2hlZUBpbnRlbC5jb20+OyBIZWEsIEtvayBLaWFuZw0KPiA+ID4gPGtvay5raWFuZy5oZWFA
aW50ZWwuY29tPjsgTmcsIEJvb24gS2hhaSA8Qm9vbi5LaGFpLk5nQGludGVsLmNvbT47DQo+ID4g
PiBZdXNsYWltaSwgQWxpZiBaYWt1YW4gPGFsaWYuemFrdWFuLnl1c2xhaW1pQGludGVsLmNvbT47
IFphbXJpLA0KPiA+ID4gTXVoYW1tYWQgSGF6aW0gSXp6YXQgPG11aGFtbWFkLmhhemltLml6emF0
LnphbXJpQGludGVsLmNvbT47IExpbSwNCj4gPiA+IEppdCBMb29uIDxqaXQubG9vbi5saW1AaW50
ZWwuY29tPjsgVGFuZywgU2lldSBNdW4NCj4gPiA+IDxTaWV1Lk11bi5UYW5nQGludGVsLmNvbT4N
Cj4gPiA+IFN1YmplY3Q6IFJFOiBbcmVzZW5kIHYyIDAwLzE5XSBBZGQgQ2FkZW5jZSBOQU5EIERy
aXZlciBzdXBwb3J0DQo+ID4gPg0KPiA+ID4NCj4gPiA+DQo+ID4gPiA+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+ID4gPiA+IEZyb206IE1pY2hhZWwgTmF6emFyZW5vIFRyaW1hcmNoaSA8
bWljaGFlbEBhbWFydWxhc29sdXRpb25zLmNvbT4NCj4gPiA+ID4gU2VudDogRnJpZGF5LCAxMyBE
ZWNlbWJlciAyMDI0IDU6MTYgcG0NCj4gPiA+ID4gVG86IE1hbml5YW0sIERpbmVzaCA8ZGluZXNo
Lm1hbml5YW1AaW50ZWwuY29tPg0KPiA+ID4gPiBDYzogdS1ib290QGxpc3RzLmRlbnguZGU7IE1h
cmVrIDxtYXJleEBkZW54LmRlPjsgU2ltb24NCj4gPiA+ID4gPHNpbW9uLmsuci5nb2xkc2NobWlk
dEBnbWFpbC5jb20+OyBUb20gUmluaSA8dHJpbmlAa29uc3Vsa28uY29tPjsNCj4gPiA+ID4gRGFy
aW8gQmluYWNjaGkgPGRhcmlvLmJpbmFjY2hpQGFtYXJ1bGFzb2x1dGlvbnMuY29tPjsgSm9oYW4g
Sm9ua2VyDQo+ID4gPiA+IDxqYng2MjQ0QGdtYWlsLmNvbT47IE1pY2hhbCBTaW1layA8bWljaGFs
LnNpbWVrQGFtZC5jb20+OyBBcnNlbml5DQo+ID4gPiA+IEtyYXNub3YgPGF2a3Jhc25vdkBzYWx1
dGVkZXZpY2VzLmNvbT47IEFsZXhhbmRlciBEYWhsDQo+ID4gPiA+IDxhZGFAdGhvcnNpcy5jb20+
OyBXaWxsaWFtIFpoYW5nIDx3aWxsaWFtLnpoYW5nQGJyb2FkY29tLmNvbT47DQo+ID4gPiA+IEln
b3IgUHJ1c292IDxpdnBydXNvdkBzYWx1dGVkZXZpY2VzLmNvbT47IE1lbmcsIFRpbmd0aW5nDQo+
ID4gPiA+IDx0aW5ndGluZy5tZW5nQGludGVsLmNvbT47IENoZWUsIFRpZW4gRm9uZw0KPiA+ID4g
PiA8dGllbi5mb25nLmNoZWVAaW50ZWwuY29tPjsgSGVhLCBLb2sgS2lhbmcNCj4gPiA+ID4gPGtv
ay5raWFuZy5oZWFAaW50ZWwuY29tPjsgTmcsIEJvb24gS2hhaSA8Ym9vbi5raGFpLm5nQGludGVs
LmNvbT47DQo+ID4gPiA+IFl1c2xhaW1pLCBBbGlmIFpha3VhbiA8YWxpZi56YWt1YW4ueXVzbGFp
bWlAaW50ZWwuY29tPjsgWmFtcmksDQo+ID4gPiA+IE11aGFtbWFkIEhhemltIEl6emF0IDxtdWhh
bW1hZC5oYXppbS5penphdC56YW1yaUBpbnRlbC5jb20+OyBMaW0sDQo+ID4gPiA+IEppdCBMb29u
IDxqaXQubG9vbi5saW1AaW50ZWwuY29tPjsgVGFuZywgU2lldSBNdW4NCj4gPiA+ID4gPHNpZXUu
bXVuLnRhbmdAaW50ZWwuY29tPg0KPiA+ID4gPiBTdWJqZWN0OiBSZTogW3Jlc2VuZCB2MiAwMC8x
OV0gQWRkIENhZGVuY2UgTkFORCBEcml2ZXIgc3VwcG9ydA0KPiA+ID4gPg0KPiA+ID4gPiBIaQ0K
PiA+ID4gPg0KPiA+ID4gPiBPbiBUaHUsIERlYyA1LCAyMDI0IGF0IDEwOjIz4oCvQU0gPGRpbmVz
aC5tYW5peWFtQGludGVsLmNvbT4gd3JvdGU6DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBGcm9tOiBE
aW5lc2ggTWFuaXlhbSA8ZGluZXNoLm1hbml5YW1AaW50ZWwuY29tPg0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gVGhpcyBwYXRjaHNldCBhZGQgQ2FkZW5jZSBOQU5EIGRyaXZlciBzdXBwb3J0IGZvciBJ
bnRlbCBBZ2lsZXg1DQo+ID4gPiA+ID4gZGV2aWNlcy4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFRo
ZSBOQU5EIGRyaXZlciBpcyBsZXZlcmFnZWQgZnJvbSB0aGUgY2FkZW5jZS1uYW5kLWNvbnRyb2xs
ZXIuYw0KPiA+ID4gPiA+IGZyb20gTGludXggdmVyc2lvbiA2LjExLjIuIFUtQm9vdCB3aWxsIHN1
cHBvcnQgcmVhZCwgd3JpdGUgYW5kDQo+ID4gPiA+ID4gZXJhc2UgTkFORCB3aXRoIENhZGVuY2Ug
ZHJpdmVyLiBUaGUgZHJpdmVyIGZ1cnRoZXIgZW5oYW5jZWQgaW4NCj4gPiA+ID4gPiBVLUJvb3Qg
dG8gc3VwcG9ydCBOQU5EIGJvb3RpbmcgZnJvbSBGU0JMIGFuZCBzdXBwb3J0IGJvb3QgdG8ga2Vy
bmVsIHZpYQ0KPiBVQklGUy4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFBhdGNoIHN0YXR1czoNCj4g
PiA+ID4gPiBIYXZlIGNoYW5nZXM6IEFsbCBwYXRjaGVzIGV4cGVjdCBQYXRjaCAxOQ0KPiA+ID4g
PiA+DQo+ID4gPiA+ID4gRGV0YWlsIGNoYW5nZWxvZyBjYW4gZmluZCBpbiBjb21taXQgbWVzc2Fn
ZS4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IHYxLT52MjoNCj4gPiA+ID4gPiAtLS0tLS0tLQ0KPiA+
ID4gPiA+IFBhdGNoIDEgLSAxODoNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IC0gcmVtb3ZlIHRoZSAi
dGhpcyBwYXRjaCBpcyB0byIgY29tbWl0IHBocmFzZXMNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFBh
dGNoIDQ7DQo+ID4gPiA+ID4gLSBtaW5vciByZWZhY3RvcmluZyBvZiBjb2RlIHRvIG1hdGNoIHRo
ZSBzdGFibGUgdmVyc2lvbiA2LjExLjIuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBQYXRjaCAxNDoN
Cj4gPiA+ID4gPiAtIEFkZCBtYWludGFpbmVyIGFuZCAiI2luY2x1ZGUiIG1lY2hhbmlzbSBmb3Ig
bmV3IHZhcmlhbnQNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFBhdGNoIDE2Og0KPiA+ID4gPiA+IC0g
bGV2ZXJhZ2UgdGhlIGV4aXN0aW5nIG5hbmRfc3BsX2xvYWRfaW1hZ2UNCj4gPiA+ID4gPg0KPiA+
ID4gPg0KPiA+ID4gPiBJIGhhdmUgdHJpZWQgdG8gYnVpbGQgYnV0IGl0IGRvZXMgbm90IHdvcmsu
IEhhdmUgeW91IHRlc3RlZCBpbiBnaXRodWI/DQo+ID4gPiA+DQo+ID4gPiA+IE1pY2hhZWwNCj4g
PiA+DQo+ID4gPiBZZXQgdG8gZGVwbG95IGdpdGh1YiB0ZXN0IG9uIG91ciBjdXJyZW50IHBsYXRm
b3JtLg0KPiA+ID4gT25seSBjaGVja3BhdGNoLnBsIGFuZCBsb2NhbCBidWlsdCBoYXMgYmVlbiB1
c2VkIGFzIGEgbWV0cmljIGZvcg0KPiA+ID4gZWFjaCBjb21taXQgYmVmb3JlIHN1Ym1pc3Npb24u
DQo+ID4gPiBBbmQsIGFsbCB0aGVzZSBjb21taXRzIGFyZSBwYXJ0IG9mIHRoZSBmaXJtd2FyZSBj
dXJyZW50bHkgcnVubmluZyBvbg0KPiA+ID4gcmVhbCBoYXJkd2FyZS4NCj4gPiA+DQo+ID4gPiA+
DQo+ID4gPiA+ID4gSGlzdG9yeToNCj4gPiA+ID4gPiAtLS0tLS0tLQ0KPiA+ID4gPiA+IFt2MV06
DQo+ID4gPiA+ID4gaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L3Vib290L2Nv
dmVyLzIwMjQwOTE5MDM1NTEyLg0KPiA+ID4gPiA+IDEzODUNCj4gPiA+ID4gPiA0LQ0KPiA+ID4g
PiA+IDEtZGluZXNoLm1hbml5YW1AaW50ZWwuY29tLw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gRGlu
ZXNoIE1hbml5YW0gKDE5KToNCj4gPiA+ID4gPiAgIGR0OiBuYW5kOiBhZGQgY2FkZW5jZSBuYW5k
IGR0LWJpbmRpbmdzDQo+ID4gPiA+ID4gICBhcm06IGR0czogYWdpbGV4NTogRW5hYmxlZCBjZG5z
LW5hbmQgZHRzIHNldHRpbmcNCj4gPiA+ID4gPiAgIGluY2x1ZGU6IGFzbTogQWRkIHN1cHBvcnQg
dG8gcmVhZC93cml0ZSA2NC1iaXQNCj4gPiA+ID4gPiAgIGRyaXZlcnM6IG10ZDogbmFuZDogQWRk
IGRyaXZlciBmb3IgQ2FkZW5jZSBOYW5kDQo+ID4gPiA+ID4gICBkcml2ZXJzOiBtdGQ6IG5hbmQ6
IGNhZGVuY2U6IEFkZCBzdXBwb3J0IGZvciByZWFkIHN0YXR1cyBjb21tYW5kDQo+ID4gPiA+ID4g
ICBkcml2ZXJzOiBtdGQ6IG5hbmQ6IGNhZGVuY2U6IEFkZCBzdXBwb3J0IGZvciByZWFkaWQgY29t
bWFuZA0KPiA+ID4gPiA+ICAgZHJpdmVyczogbXRkOiBuYW5kOiBjYWRlbmNlOiBBZGQgc3VwcG9y
dCBmb3IgTkFORF9DTURfUEFSQU0NCj4gPiA+ID4gPiAgIGRyaXZlcnM6IG10ZDogbmFuZDogY2Fk
ZW5jZTogQWRkIHN1cHBvcnQgZm9yIE5BTkRfQ01EX1JFU0VUDQo+ID4gPiA+ID4gICBkcml2ZXJz
OiBtdGQ6IG5hbmQ6IGNhZGVuY2U6IFN1cHBvcnQgY21kIFNFVF9GRUFUVVJFUyAmDQo+IEdFVF9G
RUFUVVJFUw0KPiA+ID4gPiA+ICAgZHJpdmVyczogbXRkOiBuYW5kOiBjYWRlbmNlOiBGbHVzaCAm
IGludmFsaWRhdGUgZG1hIGRlc2NyaXB0b3INCj4gPiA+ID4gPiAgIGRyaXZlcnM6IG10ZDogbmFu
ZDogY2FkZW5jZTogUG9sbCBmb3IgZGVzYyBjb21wbGV0ZSBzdGF0dXMNCj4gPiA+ID4gPiAgIGRy
aXZlcnM6IG10ZDogbmFuZDogY2FkZW5jZTogVXNlIGJvdW5jZSBidWZmZXINCj4gPiA+ID4gPiAg
IGRyaXZlcnM6IG5hbmQ6IEVuYWJsZWQgS2NvbmZpZyBhbmQgTWFrZWZpbGUgZm9yIGNkbnMtbmFu
ZA0KPiA+ID4gPiA+ICAgY29uZmlnczogbmFuZDJfZGVmY29uZmlnOiBFbmFibGUgY29uZmlncyBm
b3IgbmFuZCBib290DQo+ID4gPiA+ID4gICBkcml2ZXJzOiBtdGQ6IG5hbmQ6IGJhc2U6IEFkZCBz
dXBwb3J0IGZvciBIYXJkd2FyZSBFQ0MgZm9yIGNoZWNrIGJhZA0KPiA+ID4gPiA+ICAgICBibG9j
aw0KPiA+ID4gPiA+ICAgZHJpdmVyczogbXRkOiBuYW5kOiBzcGw6IEFkZCBzdXBwb3J0IGZvciBu
YW5kIFNQTCBsb2FkIGltYWdlDQo+ID4gPiA+ID4gICBkcml2ZXJzOiBtdGQ6IG5hbmQ6IEVuYWJs
ZWQgS2NvbmZpZyBhbmQgTWFrZWZpbGUgZm9yIENhZGVuY2UtU1BMDQo+ID4gPiA+ID4gICBkcml2
ZXJzOiBtdGQ6IG5hbmQ6IEtjb25maWc6IFJlbW92ZSBTWVNfTkFORF9CTE9DS19TSVpFDQo+IGRl
cGVuZGVuY3kNCj4gPiA+ID4gPiAgIGRyaXZlcnM6IG10ZDogbmFuZDogS2NvbmZpZzogRW5hYmxl
ZCBzZWxmLWluaXQgZm9yIGNkbnMtbmFuZA0KPiA+ID4gPiA+IFNQTA0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gIGFyY2gvYXJtL2R0cy9zb2NmcGdhX2FnaWxleDUuZHRzaSAgICAgICAgICAgICB8ICAg
MTQgKw0KPiA+ID4gPiA+ICAuLi4vYXJtL2R0cy9zb2NmcGdhX2FnaWxleDVfc29jZGstdS1ib290
LmR0c2kgfCAgIDI4ICsNCj4gPiA+ID4gPiAgYXJjaC9hcm0vaW5jbHVkZS9hc20vaW8uaCAgICAg
ICAgICAgICAgICAgICAgIHwgICAyNSArDQo+ID4gPiA+ID4gIGJvYXJkL2ludGVsL2FnaWxleDUt
c29jZGsvTUFJTlRBSU5FUlMgICAgICAgICB8ICAgIDIgKw0KPiA+ID4gPiA+ICBjb25maWdzL3Nv
Y2ZwZ2FfYWdpbGV4NV9uYW5kMl9kZWZjb25maWcgICAgICAgfCAgIDMzICsNCj4gPiA+ID4gPiAg
Li4uL210ZC9jYWRlbmNlLG5hbmQueWFtbCAgICAgICAgICAgICAgICAgICAgIHwgICA5OCArDQo+
ID4gPiA+ID4gIGRyaXZlcnMvbXRkL25hbmQvcmF3L0tjb25maWcgICAgICAgICAgICAgICAgICB8
ICAgMTkgKy0NCj4gPiA+ID4gPiAgZHJpdmVycy9tdGQvbmFuZC9yYXcvTWFrZWZpbGUgICAgICAg
ICAgICAgICAgIHwgICAgMiArDQo+ID4gPiA+ID4gIGRyaXZlcnMvbXRkL25hbmQvcmF3L2NhZGVu
Y2VfbmFuZC5jICAgICAgICAgICB8IDI0MjQNCj4gKysrKysrKysrKysrKysrKysNCj4gPiA+ID4g
PiAgZHJpdmVycy9tdGQvbmFuZC9yYXcvY2FkZW5jZV9zcGwuYyAgICAgICAgICAgIHwgICA1OSAr
DQo+ID4gPiA+ID4gIGRyaXZlcnMvbXRkL25hbmQvcmF3L25hbmRfYmFzZS5jICAgICAgICAgICAg
ICB8ICAgNzEgKy0NCj4gPiA+ID4gPiAgaW5jbHVkZS9jYWRlbmNlLW5hbmQuaCAgICAgICAgICAg
ICAgICAgICAgICAgIHwgIDUyOSArKysrDQo+ID4gPiA+ID4gIGluY2x1ZGUvbGludXgvbXRkL3Jh
d25hbmQuaCAgICAgICAgICAgICAgICAgICB8ICAgMTQgKw0KPiA+ID4gPiA+ICAxMyBmaWxlcyBj
aGFuZ2VkLCAzMjkzIGluc2VydGlvbnMoKyksIDI1IGRlbGV0aW9ucygtKSAgY3JlYXRlDQo+ID4g
PiA+ID4gbW9kZQ0KPiA+ID4gPiA+IDEwMDY0NCBjb25maWdzL3NvY2ZwZ2FfYWdpbGV4NV9uYW5k
Ml9kZWZjb25maWcNCj4gPiA+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gPiA+ID4gZG9j
L2RldmljZS10cmVlLWJpbmRpbmdzL210ZC9jYWRlbmNlLG5hbmQueWFtbA0KPiA+ID4gPiA+ICBj
cmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9tdGQvbmFuZC9yYXcvY2FkZW5jZV9uYW5kLmMNCj4g
PiA+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbXRkL25hbmQvcmF3L2NhZGVuY2Vf
c3BsLmMNCj4gPiA+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvY2FkZW5jZS1uYW5k
LmgNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IC0tDQo+ID4gPiA+ID4gMi4xOS4wDQo+ID4gPiA+ID4N
Cj4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gLS0NCj4gPiA+ID4gTWljaGFlbCBOYXp6YXJlbm8g
VHJpbWFyY2hpDQo+ID4gPiA+IENvLUZvdW5kZXIgJiBDaGllZiBFeGVjdXRpdmUgT2ZmaWNlciBN
LiArMzkgMzQ3IDkxMyAyMTcwDQo+ID4gPiA+IG1pY2hhZWxAYW1hcnVsYXNvbHV0aW9ucy5jb20g
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiA+ID4gPg0KPiA+ID4gPiBBbWFy
dWxhIFNvbHV0aW9ucyBCVg0KPiA+ID4gPiBKb29wIEdlZXNpbmt3ZWcgMTI1LCAxMTE0IEFCLCBB
bXN0ZXJkYW0sIE5MIFQuICszMSAoMCk4NSAxMTEgOTE3Mg0KPiA+ID4gPiBpbmZvQGFtYXJ1bGFz
b2x1dGlvbnMuY29tIHd3dy5hbWFydWxhc29sdXRpb25zLmNvbQ0KPiANCj4gDQo+IA0KPiAtLQ0K
PiBNaWNoYWVsIE5henphcmVubyBUcmltYXJjaGkNCj4gQ28tRm91bmRlciAmIENoaWVmIEV4ZWN1
dGl2ZSBPZmZpY2VyDQo+IE0uICszOSAzNDcgOTEzIDIxNzANCj4gbWljaGFlbEBhbWFydWxhc29s
dXRpb25zLmNvbQ0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IA0KPiBB
bWFydWxhIFNvbHV0aW9ucyBCVg0KPiBKb29wIEdlZXNpbmt3ZWcgMTI1LCAxMTE0IEFCLCBBbXN0
ZXJkYW0sIE5MIFQuICszMSAoMCk4NSAxMTEgOTE3Mg0KPiBpbmZvQGFtYXJ1bGFzb2x1dGlvbnMu
Y29tIHd3dy5hbWFydWxhc29sdXRpb25zLmNvbQ0K
