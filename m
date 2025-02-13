Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60768C021A4
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 05:17:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D898807C0;
	Thu, 13 Feb 2025 06:17:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Efq695lS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E6EA80A55; Thu, 13 Feb 2025 06:17:55 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E14E800B3
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 06:17:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739423872; x=1770959872;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=2YLAttiATjVQfXHKjuOBKYB4IgZqoIrAvVqMwKVTEaQ=;
 b=Efq695lSh9KO1QQmt3d6N+sJntJy6L+KcbFTEDh5gNdw5AzYwJljANnm
 U5uIGcvAvL31cOUPIqiuOmBsFvwHlqto4Al8VI6NSZ2V9qrNQ5xrJ4Ot3
 +OFDLHP40Fr/1dzIOssaJglNufQusCiWCiTOd/qBB7ZHeHvZmC7KLG1ZN
 H4ZCemv+XvTINAg6kMJFxlVHRjL1gCM6ZrUaUKAPLicwFQBLzPxMu5Wrk
 kvm1btCHOqV9zMIBde1CpsFnM4d3XARkoLwSWswwwGuykd/eqvOXyJsCa
 mfz8T9c9hJVioCcaOJgepZtm9PKWw0sdDz/cowzZDrgGzJXSH5DtiwnDI w==;
X-CSE-ConnectionGUID: 5uRAbcjpR3OdRYLfuiHe5Q==
X-CSE-MsgGUID: q5HlCOi7RgGZfDADIlyUVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="40373348"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; d="scan'208";a="40373348"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2025 21:17:49 -0800
X-CSE-ConnectionGUID: gkJhP015TO2obO+h5ML3Dg==
X-CSE-MsgGUID: UWd41yRgT3Wl7kjMAWrTvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; d="scan'208";a="113030462"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2025 21:17:47 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 12 Feb 2025 21:17:44 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Feb 2025 21:17:44 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Feb 2025 21:17:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHzUQnwMSqHh4t1F0CJf36DWCUwifNigPmOfJb/Pqhiru0glCMiOq5Dn4LY4lYkKtWd4cVjAqQ35RQ92WAwGWHW+fgXF/wwSWPqqT7qtirvr20jyHmCOBb02Y1VDXFWgwpxxzRdJ0P598DQ/VsEx+q/73emNoZRP48DFQAN7bpUA9PGXGWVIgod5GJCshEdBT6rr64QNzvlAL6o0EJYQ/Dlkv/u/oFOfsJFzxS++bTp6rape31rZvJdSxb31UKX26WyVP8RCD/NZMgeFoepZmDrTtTi70f1Osjg4q8oW+pS93fyB5nKs2ytKTfHN7TECFeObbjyHiS3o1pck1xHlfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2YLAttiATjVQfXHKjuOBKYB4IgZqoIrAvVqMwKVTEaQ=;
 b=I+NZHT7d7lPKd+GN2e2WeP214AKi47jrI4CKzEoi727flNhH2q6iRIYbwoilAS3FVkTH3ZMIom730p23gOiM1ZB/n5bOEWLAFqiD9h5Me/rvtkCXmtcR2sE7IQSAbAjL0hGuS1Dxr4isv4JwmEzDArAmozkYCqLZRS+WN697BXMWtbU/VqPDgAIlauZ5OovGYURfW8Dvg1jTgZE7GI3Zv3y6xKx+W8UzofzdLWuHWK3wjck12BkW3eiSxBbGj5P3Q3+oR6aklMUSsEOcoW8juWA2agt3bqVe009vjabJogtXfcNKoRoxgUB8Ptr50tg0QaXAoFSV4W3qvZkNhyHp1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5366.namprd11.prod.outlook.com (2603:10b6:208:31c::17)
 by PH7PR11MB8572.namprd11.prod.outlook.com (2603:10b6:510:30a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Thu, 13 Feb
 2025 05:17:00 +0000
Received: from BL1PR11MB5366.namprd11.prod.outlook.com
 ([fe80::f073:1e46:c7ee:df9b]) by BL1PR11MB5366.namprd11.prod.outlook.com
 ([fe80::f073:1e46:c7ee:df9b%7]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 05:17:00 +0000
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
Thread-Index: AQHbRvdcQWgz78qVlUqpVYczLsrbnbLj8XAAgAYr1NCANxKuMIAGbQMAgB2B8NA=
Date: Thu, 13 Feb 2025 05:17:00 +0000
Message-ID: <BL1PR11MB5366817B981311E11F8F745682FF2@BL1PR11MB5366.namprd11.prod.outlook.com>
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
x-ms-traffictypediagnostic: BL1PR11MB5366:EE_|PH7PR11MB8572:EE_
x-ms-office365-filtering-correlation-id: c09accb2-27e0-4b70-f816-08dd4beda530
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|376014|366016|7416014|13003099007|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZmxXc0g4NmphZ0tGeXhteE5BN1lja0ZWeGxWRGQwTkgzN2hmclNxa3FFMXo0?=
 =?utf-8?B?QWl2L0NNVHlpMGFBQ2o5ZEZadHlzTVZ6MzQvSmFSRUNxd0U5blFhamdiUy9q?=
 =?utf-8?B?U0Z2Skp1cTQ1cmxSUmQrbnJONHFEUitTQXZ0Uk14WkJmNGlQQXNTeHhEZ3Ju?=
 =?utf-8?B?b2l2ZjUyN01DLzlyS1NJQ05rRnBlOHZsazRheHM4SVUzSStMWUhuWkNFUFgr?=
 =?utf-8?B?bDF5anZkYnZ3M3k4YTlmU2Rva2Y3UVNldXJnOW0rMm5ibGs0RS9ZZnUzOVFD?=
 =?utf-8?B?TFRhMGF5ZzVYSGNXK28wL1RhYlcya0RPY0s3cDQ2UVdmV0Q5NTMxZE5lbkp4?=
 =?utf-8?B?Ly9hbHZrSExEc0ZmVGVRZzVXa1Y4aHZmNnFMR0ZQSjNRY2JlakZmeEFGdmJW?=
 =?utf-8?B?VloyUndkY2lqRU41eDZqcjJCRE8vTmdWY3pHeGZ1N3RsRkZiNUdlWVNYVWNF?=
 =?utf-8?B?NXJrKzNRNWVsR1orK0tFVEQyL2hPbE83OHR2RjBQY2p1Z2J1bnlGVmFhU25w?=
 =?utf-8?B?SGY0QXBYMStnYlZLZmxhY3JZWTRUbFZTR0VlcUVpMGZDYy9yVHM4bkVSNUg5?=
 =?utf-8?B?S3c5TVAxdXlXT201ZW1RY2Z4N3lTWnFwMEVOMmtlODhuZHMwZm9PcDJ0UHFM?=
 =?utf-8?B?c0cwNDdBYlhnV0VIL04zNGVxQXVIK2QyYjZlYVB0cFBvSndoYU1oUkF0NXhX?=
 =?utf-8?B?STVvNE9rTW1BaEpCVU5wSWFBelBPV09oc1UwR0FRaW5xalQxYnRNbnJTTmEx?=
 =?utf-8?B?K2hRaWcwUkR0YWp2Q28wUjdCeXZkRjRNV09TVkFBQVg1SHdpZUY4dlN6N2NG?=
 =?utf-8?B?blBSbnplcmQ5WjBqbXloMHVFNDhueEJtcmc5YmR2WERSc05qWTBORWZuQ2ln?=
 =?utf-8?B?blBZYnBLMmJNQVhMZnU2VTRpb2U2amNyTFUwRlVxZU8wdG1Sb0gxa0FwVi9n?=
 =?utf-8?B?R1dlVksyQ01UMmd4OWRxZkhJZEoxY28wbENpVWgxM21vUWR1aXVTTWhmSXlF?=
 =?utf-8?B?SkRtSXRQUExlcFFUZGRyOHNSOHM1ZDJVQ1dnckVDQnpSd0FIbEpHYiszSldX?=
 =?utf-8?B?VVBXRlR1LzlpenQrMXV6WXdZUXNzN2pVVTY2dzZVNzZBNFVyYWM0MXNFMjll?=
 =?utf-8?B?MHV0cWJYOVhCaGYrM3FpZXhZa0dIek9SNXNiQmZ1bFlDOGxhcVMvbnJhcFBN?=
 =?utf-8?B?djlMQ3JubVUxUmg3WGdwRVVqZnp6czByUDc1aERHbTEvNjlPdjg3YllESFMx?=
 =?utf-8?B?d1pqakY4VFhNQnVpVS9lQnk1Qk5QVnJjUm9jNjZrMm93YnhhK1gzUjVMeTJY?=
 =?utf-8?B?Q3pTRGV3OHZIZHh1S3hGdFlFYlhSOFBYSyt5K3Fpc01oRnNPRWN4N1RacjBY?=
 =?utf-8?B?K1RMNjlDRkxjWXNlUTlocU5pcGJZUmc3V2J5YytYSWhhK3ozSUJVY0VKa1Na?=
 =?utf-8?B?Ryt3NUhyT3BtQ2dxcTVZWStvRkxTOW5yVHp4UWtpc0VHem45UFF6U0RFM0p3?=
 =?utf-8?B?Z2hCT3ZkTnlEcjRPU09yWndaSWZiMzVwSVBGSDM4UWp6UjhBQkR4UVB3Mmty?=
 =?utf-8?B?eTVPcHJXVXRWdXlEY3o5TUR1VEJoVjJYU2c4cHBZUHdqeUtXNnV5eXFRTjRs?=
 =?utf-8?B?UVc3NEc5WWJBV2VmMkJNVFN5NG5ieVF4b3dsY24vUE44SG1qd1hUK0tPbkRX?=
 =?utf-8?B?ZGtkcWNKSUZNZlNQY2s1Z010OGpHTzVuL2s3SWFTZm1CeXg5UVRwZkpoVVBr?=
 =?utf-8?B?VjMybDdoQzE4WlErZTdOekM0cStTYjcvOXo0cmNBaFJDMDN3L3BtZVhSbnp1?=
 =?utf-8?B?T0czQytwYm5LcHhvWmd5WDEvazlGY0JSVjF1Z0M3U001NVd3bHU2OWwrSjNU?=
 =?utf-8?Q?yk4OLGT4wRaZ7?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR11MB5366.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(7416014)(13003099007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3ZMUGZHZFp2b29Dd09HVGpkYnVLQ0JBOFd6VnB1Z3Q0ckgwemxOUjYwTXB4?=
 =?utf-8?B?akpzdmZ4NDRJNEFITExuTnVqOFRNY05uWjB5bmswZEp4M1lpNTRhR3FZcUtQ?=
 =?utf-8?B?WUg3N3NrKy9KWTJMcExPcTlVM1FLQ1Zqc2w2Sytjb3Btd1pXeTRlclhKR3VZ?=
 =?utf-8?B?QVNqT21ob0V2c3llV0NEK3JPVE9ycXpzZnVJQndmOFd1RVlJQnMvNCs3cGpX?=
 =?utf-8?B?NUpmL3o0UlJJOFN5YytPVXlzS295VS9keUtsbTZQZGdEQWJ0VGxXaHVqRU0r?=
 =?utf-8?B?Z3lCcnJpRlJiWUZ4WHdiNTJkMEp1Q2tXTDNVaWduMytCeDFQUXVzc3M4ZVhW?=
 =?utf-8?B?YnZ0eE4zYU5tWiszRCt5NWc3YWthc2RQaE9KbUowWmdFUEorUlRqYy9sMkp6?=
 =?utf-8?B?YWFBSlk3dXJQNm52Wjk5RkFQSThSdEhRb2tlZ2N0U2hXd1NGTWdsWE9FQjlz?=
 =?utf-8?B?WERnbWpPb0dESnJONUFkT1IwTUJoaHYwTENvazMrMGw2UlhoNFJ0WG9OQXNW?=
 =?utf-8?B?UVg3ZU15eXE1UGZjdDNaRytaT2dHeVBUR1BpS0ttd25RaDF2cnhVSEtya1FO?=
 =?utf-8?B?L1NQUDZIbWkxNDlxRFBlcDZ4Z2s1T3hiTWwzSHcweE9yR2FheENXRE9zbmN1?=
 =?utf-8?B?VEJ1M25DdEFyWHFVTmZHZXQ4MWlOcTRhYm5GbWNkQ3IxRFdJMHVrdlhMbTZn?=
 =?utf-8?B?bTJydDNua3R4d2p6b0x4bFMrMHFoME5NRzZoTXZxYkFqY09sd0xkaG12NUh3?=
 =?utf-8?B?TlltREMrSE1hc0JPR0Ivb2VPV3JRT3NGbTBhaUUySW9sKy9yLzJOcGc3Ymdv?=
 =?utf-8?B?K1phT2RqdkdlT0hqaHpBQ2s5VnpaKzBFSzlvbFZaeW5JNXZ1R1cvOWlqdGhP?=
 =?utf-8?B?cWlQWmZVZkx5SURhaWhJU0MyTGI5alcxUElJQTRtaGorWk5OQUo4WTNUOFp1?=
 =?utf-8?B?UlZWTmRaYmFiblpuSHQ0MURPd3BLejY3aVo2TGVaZDFLeDBjUzdzUnBHSWVD?=
 =?utf-8?B?NkVGNEc2TmJpMGRBZVNyVFlWNW03RE5UYzh6Uk1TUXovV0VUVmE3T2w1VE5m?=
 =?utf-8?B?aFVydEQ4dzN6Z09IK1lpcVNDZ1IvNHpIVG1RYzRMNkxjMmRINEdSY0Z2djQx?=
 =?utf-8?B?MmtPc21CYmRDRE81RjFPTE1paS9TU1VRZzBXTHhaV0xaMmZHS3dxSlYwRStD?=
 =?utf-8?B?dW14aTdQR1pSeVRjSTZ0dnJiNFNzWkNwc2R1b1NvazFLdlc3azN0R1lEZ29t?=
 =?utf-8?B?OUduR2xWMDJDOTVaQ1pwVHdFTDEvZFNVdUtXVkpTMHRzWDltSmtXNHF6cTRQ?=
 =?utf-8?B?UklzcWd3TWQzZkI2Ty85UEh1Y0ZpWjgyZlMxVFJsL2xobVRyNzRuY21EU3Zs?=
 =?utf-8?B?VU1PbllTODBGSlA5YVpHQjhkZlV5dVdMaUc0OHNnSkhvMW9CRGdYVWJqSTNt?=
 =?utf-8?B?Q050WjI1QzFnUXp5VWRXZU8wWWJhVnRManV0SnNrbnFEd25jMngrVXo1eGlS?=
 =?utf-8?B?ZzJ6VDQvbnFpWWtyckFIL29ZVDV2U0J4UE53QmFBK29IWmsvd3AreHEvZTAy?=
 =?utf-8?B?b3lyUmszQ0NlT1JvYW1Pb3lCMktwZXVWWWVkS3dvY215RzhEQjZpbk1VRC9t?=
 =?utf-8?B?ZnNPYlc5ZFdTcG5WQWVUdldZeTByUnc1cUp2NTVRMGlWa1d6L21obG9xS0V5?=
 =?utf-8?B?VVlkb3c2TGVmcGpDSHVxOHEwYjNvV290aGpmaGFIOWtQMWMxdENBTVBEMWxR?=
 =?utf-8?B?OWxLT1F6OGhNdy9VNExBb2l1S1RBbndZV2ZOT3NxU1ZIeDBhZFRCdlNWMVQ2?=
 =?utf-8?B?T0hBRVJPTEdsem1OT0FRd0tlZjd1ZnJZSGs1SGliU0NlS0dxYTV2cHVkWmpY?=
 =?utf-8?B?NWF1Z1pzWi9SbEY3b1VzaFp6bzJrL3lpMVFuQVNUdUFSWXFYcG1SRVdlSmc5?=
 =?utf-8?B?eVVtaEhHcjlCS3JDSytzbHc5YTV0MGkySVZ3VGdRVWxmR3hZUlprMUxURk15?=
 =?utf-8?B?L0NIQmo3MUNUWVluN3BWSDlISDZERDlyU0hXZ2ZzN1dUaWZ4bDNQU1RMT3Rj?=
 =?utf-8?B?MjVRRmRBc3VGZzFwTEsxd3BlUFBWbW9XRmkvUHQxdjd0Rys4cGswdXNkK1ZZ?=
 =?utf-8?B?OVpvU2xxRGxZWTJnRVhiaUtCWEJUb0pkSUtVbG5xbDM0MzhFL1lSSjF5MkFr?=
 =?utf-8?Q?8/uyQHy211TBdvYqu5/+SryA8sn2g2wRKsvOn2zGtabB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c09accb2-27e0-4b70-f816-08dd4beda530
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 05:17:00.6790 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nuhbKyGQMklSksaeYXn4ZbQiYIVv5NTXh87QP5Qtxu6ZzRiuYt630LRBo/v0sJ00NDwqiLi81u4pDusvzKpL0ao3+MhtvfbF0nyqMWGLl2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8572
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

SGkgTWljaGFlbCwNCg0KRGlkIHlvdSBtYW5hZ2UgdG8gcnVuIHRoZSBDSSB0ZXN0LCBtYXkgSSBr
bm93IHRoZSBzdGF0dXMgPw0KDQpUaGFua3MuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogTWljaGFlbCBOYXp6YXJlbm8gVHJpbWFyY2hpIDxtaWNoYWVsQGFtYXJ1bGFz
b2x1dGlvbnMuY29tPg0KPiBTZW50OiBTYXR1cmRheSwgMjUgSmFudWFyeSAyMDI1IDY6NDAgcG0N
Cj4gVG86IE1hbml5YW0sIERpbmVzaCA8ZGluZXNoLm1hbml5YW1AaW50ZWwuY29tPg0KPiBDYzog
dS1ib290QGxpc3RzLmRlbnguZGU7IE1hcmVrIDxtYXJleEBkZW54LmRlPjsgU2ltb24NCj4gPHNp
bW9uLmsuci5nb2xkc2NobWlkdEBnbWFpbC5jb20+OyBUb20gUmluaSA8dHJpbmlAa29uc3Vsa28u
Y29tPjsgRGFyaW8NCj4gQmluYWNjaGkgPGRhcmlvLmJpbmFjY2hpQGFtYXJ1bGFzb2x1dGlvbnMu
Y29tPjsgSm9oYW4gSm9ua2VyDQo+IDxqYng2MjQ0QGdtYWlsLmNvbT47IE1pY2hhbCBTaW1layA8
bWljaGFsLnNpbWVrQGFtZC5jb20+OyBBcnNlbml5DQo+IEtyYXNub3YgPGF2a3Jhc25vdkBzYWx1
dGVkZXZpY2VzLmNvbT47IEFsZXhhbmRlciBEYWhsIDxhZGFAdGhvcnNpcy5jb20+Ow0KPiBXaWxs
aWFtIFpoYW5nIDx3aWxsaWFtLnpoYW5nQGJyb2FkY29tLmNvbT47IElnb3IgUHJ1c292DQo+IDxp
dnBydXNvdkBzYWx1dGVkZXZpY2VzLmNvbT47IE1lbmcsIFRpbmd0aW5nIDx0aW5ndGluZy5tZW5n
QGludGVsLmNvbT47DQo+IENoZWUsIFRpZW4gRm9uZyA8dGllbi5mb25nLmNoZWVAaW50ZWwuY29t
PjsgSGVhLCBLb2sgS2lhbmcNCj4gPGtvay5raWFuZy5oZWFAaW50ZWwuY29tPjsgTmcsIEJvb24g
S2hhaSA8Ym9vbi5raGFpLm5nQGludGVsLmNvbT47IFl1c2xhaW1pLA0KPiBBbGlmIFpha3VhbiA8
YWxpZi56YWt1YW4ueXVzbGFpbWlAaW50ZWwuY29tPjsgWmFtcmksIE11aGFtbWFkIEhhemltIEl6
emF0DQo+IDxtdWhhbW1hZC5oYXppbS5penphdC56YW1yaUBpbnRlbC5jb20+OyBMaW0sIEppdCBM
b29uDQo+IDxqaXQubG9vbi5saW1AaW50ZWwuY29tPjsgVGFuZywgU2lldSBNdW4gPHNpZXUubXVu
LnRhbmdAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW3Jlc2VuZCB2MiAwMC8xOV0gQWRkIENh
ZGVuY2UgTkFORCBEcml2ZXIgc3VwcG9ydA0KPiANCj4gSGkgRGluZXNoDQo+IA0KPiBPbiBUdWUs
IEphbiAyMSwgMjAyNSBhdCA5OjM54oCvQU0gTWFuaXlhbSwgRGluZXNoIDxkaW5lc2gubWFuaXlh
bUBpbnRlbC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gSGkgTWljaGFlbCwNCj4gPg0KPiA+IEFu
eSB1cGRhdGUgb24gbXkgTkFORCBwYXRjaHNldCA/LiBJIGNhbiBzZWUgaXQgaXMgc3RpbGwgdW5k
ZXIgcmV2aWV3Lg0KPiA+IElzIHRoZXJlIGFueXRoaW5nIEkgY2FuIGRvIGZyb20gbXkgc2lkZSB0
byBzcGVlZCB1cCB0aGUgcmV2aWV3IHByb2Nlc3M/DQo+ID4gVGhhbmtzIGZvciB5b3VyIHRpbWUu
DQo+ID4NCj4gDQo+IFdlbGwsIGxhc3QgdGltZSB3YXMgbm90IHBhYXNzaW5nIHRoZSBDSS4gSSB3
aWxsIHRlc3QgaXQgYWdhaW4gdG9kYXkNCj4gDQo+IE1pY2hhZWwNCj4gDQo+ID4gPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogTWFuaXlhbSwgRGluZXNoDQo+ID4gPiBT
ZW50OiBUdWVzZGF5LCAxNyBEZWNlbWJlciAyMDI0IDM6NDEgcG0NCj4gPiA+IFRvOiBNaWNoYWVs
IE5henphcmVubyBUcmltYXJjaGkgPG1pY2hhZWxAYW1hcnVsYXNvbHV0aW9ucy5jb20+DQo+ID4g
PiBDYzogdS1ib290QGxpc3RzLmRlbnguZGU7IE1hcmVrIDxtYXJleEBkZW54LmRlPjsgU2ltb24N
Cj4gPiA+IDxzaW1vbi5rLnIuZ29sZHNjaG1pZHRAZ21haWwuY29tPjsgVG9tIFJpbmkgPHRyaW5p
QGtvbnN1bGtvLmNvbT47DQo+ID4gPiBEYXJpbyBCaW5hY2NoaSA8ZGFyaW8uYmluYWNjaGlAYW1h
cnVsYXNvbHV0aW9ucy5jb20+OyBKb2hhbiBKb25rZXINCj4gPiA+IDxqYng2MjQ0QGdtYWlsLmNv
bT47IE1pY2hhbCBTaW1layA8bWljaGFsLnNpbWVrQGFtZC5jb20+OyBBcnNlbml5DQo+ID4gPiBL
cmFzbm92IDxhdmtyYXNub3ZAc2FsdXRlZGV2aWNlcy5jb20+OyBBbGV4YW5kZXIgRGFobA0KPiA+
ID4gPGFkYUB0aG9yc2lzLmNvbT47IFdpbGxpYW0gWmhhbmcgPHdpbGxpYW0uemhhbmdAYnJvYWRj
b20uY29tPjsgSWdvcg0KPiA+ID4gUHJ1c292IDxpdnBydXNvdkBzYWx1dGVkZXZpY2VzLmNvbT47
IE1lbmcsIFRpbmd0aW5nDQo+ID4gPiA8dGluZ3RpbmcubWVuZ0BpbnRlbC5jb20+OyBDaGVlLCBU
aWVuIEZvbmcNCj4gPiA+IDx0aWVuLmZvbmcuY2hlZUBpbnRlbC5jb20+OyBIZWEsIEtvayBLaWFu
Zw0KPiA+ID4gPGtvay5raWFuZy5oZWFAaW50ZWwuY29tPjsgTmcsIEJvb24gS2hhaSA8Qm9vbi5L
aGFpLk5nQGludGVsLmNvbT47DQo+ID4gPiBZdXNsYWltaSwgQWxpZiBaYWt1YW4gPGFsaWYuemFr
dWFuLnl1c2xhaW1pQGludGVsLmNvbT47IFphbXJpLA0KPiA+ID4gTXVoYW1tYWQgSGF6aW0gSXp6
YXQgPG11aGFtbWFkLmhhemltLml6emF0LnphbXJpQGludGVsLmNvbT47IExpbSwNCj4gPiA+IEpp
dCBMb29uIDxqaXQubG9vbi5saW1AaW50ZWwuY29tPjsgVGFuZywgU2lldSBNdW4NCj4gPiA+IDxT
aWV1Lk11bi5UYW5nQGludGVsLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFJFOiBbcmVzZW5kIHYyIDAw
LzE5XSBBZGQgQ2FkZW5jZSBOQU5EIERyaXZlciBzdXBwb3J0DQo+ID4gPg0KPiA+ID4NCj4gPiA+
DQo+ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+IEZyb206IE1pY2hh
ZWwgTmF6emFyZW5vIFRyaW1hcmNoaSA8bWljaGFlbEBhbWFydWxhc29sdXRpb25zLmNvbT4NCj4g
PiA+ID4gU2VudDogRnJpZGF5LCAxMyBEZWNlbWJlciAyMDI0IDU6MTYgcG0NCj4gPiA+ID4gVG86
IE1hbml5YW0sIERpbmVzaCA8ZGluZXNoLm1hbml5YW1AaW50ZWwuY29tPg0KPiA+ID4gPiBDYzog
dS1ib290QGxpc3RzLmRlbnguZGU7IE1hcmVrIDxtYXJleEBkZW54LmRlPjsgU2ltb24NCj4gPiA+
ID4gPHNpbW9uLmsuci5nb2xkc2NobWlkdEBnbWFpbC5jb20+OyBUb20gUmluaSA8dHJpbmlAa29u
c3Vsa28uY29tPjsNCj4gPiA+ID4gRGFyaW8gQmluYWNjaGkgPGRhcmlvLmJpbmFjY2hpQGFtYXJ1
bGFzb2x1dGlvbnMuY29tPjsgSm9oYW4gSm9ua2VyDQo+ID4gPiA+IDxqYng2MjQ0QGdtYWlsLmNv
bT47IE1pY2hhbCBTaW1layA8bWljaGFsLnNpbWVrQGFtZC5jb20+OyBBcnNlbml5DQo+ID4gPiA+
IEtyYXNub3YgPGF2a3Jhc25vdkBzYWx1dGVkZXZpY2VzLmNvbT47IEFsZXhhbmRlciBEYWhsDQo+
ID4gPiA+IDxhZGFAdGhvcnNpcy5jb20+OyBXaWxsaWFtIFpoYW5nIDx3aWxsaWFtLnpoYW5nQGJy
b2FkY29tLmNvbT47DQo+ID4gPiA+IElnb3IgUHJ1c292IDxpdnBydXNvdkBzYWx1dGVkZXZpY2Vz
LmNvbT47IE1lbmcsIFRpbmd0aW5nDQo+ID4gPiA+IDx0aW5ndGluZy5tZW5nQGludGVsLmNvbT47
IENoZWUsIFRpZW4gRm9uZw0KPiA+ID4gPiA8dGllbi5mb25nLmNoZWVAaW50ZWwuY29tPjsgSGVh
LCBLb2sgS2lhbmcNCj4gPiA+ID4gPGtvay5raWFuZy5oZWFAaW50ZWwuY29tPjsgTmcsIEJvb24g
S2hhaSA8Ym9vbi5raGFpLm5nQGludGVsLmNvbT47DQo+ID4gPiA+IFl1c2xhaW1pLCBBbGlmIFph
a3VhbiA8YWxpZi56YWt1YW4ueXVzbGFpbWlAaW50ZWwuY29tPjsgWmFtcmksDQo+ID4gPiA+IE11
aGFtbWFkIEhhemltIEl6emF0IDxtdWhhbW1hZC5oYXppbS5penphdC56YW1yaUBpbnRlbC5jb20+
OyBMaW0sDQo+ID4gPiA+IEppdCBMb29uIDxqaXQubG9vbi5saW1AaW50ZWwuY29tPjsgVGFuZywg
U2lldSBNdW4NCj4gPiA+ID4gPHNpZXUubXVuLnRhbmdAaW50ZWwuY29tPg0KPiA+ID4gPiBTdWJq
ZWN0OiBSZTogW3Jlc2VuZCB2MiAwMC8xOV0gQWRkIENhZGVuY2UgTkFORCBEcml2ZXIgc3VwcG9y
dA0KPiA+ID4gPg0KPiA+ID4gPiBIaQ0KPiA+ID4gPg0KPiA+ID4gPiBPbiBUaHUsIERlYyA1LCAy
MDI0IGF0IDEwOjIz4oCvQU0gPGRpbmVzaC5tYW5peWFtQGludGVsLmNvbT4gd3JvdGU6DQo+ID4g
PiA+ID4NCj4gPiA+ID4gPiBGcm9tOiBEaW5lc2ggTWFuaXlhbSA8ZGluZXNoLm1hbml5YW1AaW50
ZWwuY29tPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhpcyBwYXRjaHNldCBhZGQgQ2FkZW5jZSBO
QU5EIGRyaXZlciBzdXBwb3J0IGZvciBJbnRlbCBBZ2lsZXg1DQo+ID4gPiA+ID4gZGV2aWNlcy4N
Cj4gPiA+ID4gPg0KPiA+ID4gPiA+IFRoZSBOQU5EIGRyaXZlciBpcyBsZXZlcmFnZWQgZnJvbSB0
aGUgY2FkZW5jZS1uYW5kLWNvbnRyb2xsZXIuYw0KPiA+ID4gPiA+IGZyb20gTGludXggdmVyc2lv
biA2LjExLjIuIFUtQm9vdCB3aWxsIHN1cHBvcnQgcmVhZCwgd3JpdGUgYW5kDQo+ID4gPiA+ID4g
ZXJhc2UgTkFORCB3aXRoIENhZGVuY2UgZHJpdmVyLiBUaGUgZHJpdmVyIGZ1cnRoZXIgZW5oYW5j
ZWQgaW4NCj4gPiA+ID4gPiBVLUJvb3QgdG8gc3VwcG9ydCBOQU5EIGJvb3RpbmcgZnJvbSBGU0JM
IGFuZCBzdXBwb3J0IGJvb3QgdG8ga2VybmVsIHZpYQ0KPiBVQklGUy4NCj4gPiA+ID4gPg0KPiA+
ID4gPiA+IFBhdGNoIHN0YXR1czoNCj4gPiA+ID4gPiBIYXZlIGNoYW5nZXM6IEFsbCBwYXRjaGVz
IGV4cGVjdCBQYXRjaCAxOQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gRGV0YWlsIGNoYW5nZWxvZyBj
YW4gZmluZCBpbiBjb21taXQgbWVzc2FnZS4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IHYxLT52MjoN
Cj4gPiA+ID4gPiAtLS0tLS0tLQ0KPiA+ID4gPiA+IFBhdGNoIDEgLSAxODoNCj4gPiA+ID4gPg0K
PiA+ID4gPiA+IC0gcmVtb3ZlIHRoZSAidGhpcyBwYXRjaCBpcyB0byIgY29tbWl0IHBocmFzZXMN
Cj4gPiA+ID4gPg0KPiA+ID4gPiA+IFBhdGNoIDQ7DQo+ID4gPiA+ID4gLSBtaW5vciByZWZhY3Rv
cmluZyBvZiBjb2RlIHRvIG1hdGNoIHRoZSBzdGFibGUgdmVyc2lvbiA2LjExLjIuDQo+ID4gPiA+
ID4NCj4gPiA+ID4gPiBQYXRjaCAxNDoNCj4gPiA+ID4gPiAtIEFkZCBtYWludGFpbmVyIGFuZCAi
I2luY2x1ZGUiIG1lY2hhbmlzbSBmb3IgbmV3IHZhcmlhbnQNCj4gPiA+ID4gPg0KPiA+ID4gPiA+
IFBhdGNoIDE2Og0KPiA+ID4gPiA+IC0gbGV2ZXJhZ2UgdGhlIGV4aXN0aW5nIG5hbmRfc3BsX2xv
YWRfaW1hZ2UNCj4gPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBJIGhhdmUgdHJpZWQgdG8gYnVp
bGQgYnV0IGl0IGRvZXMgbm90IHdvcmsuIEhhdmUgeW91IHRlc3RlZCBpbiBnaXRodWI/DQo+ID4g
PiA+DQo+ID4gPiA+IE1pY2hhZWwNCj4gPiA+DQo+ID4gPiBZZXQgdG8gZGVwbG95IGdpdGh1YiB0
ZXN0IG9uIG91ciBjdXJyZW50IHBsYXRmb3JtLg0KPiA+ID4gT25seSBjaGVja3BhdGNoLnBsIGFu
ZCBsb2NhbCBidWlsdCBoYXMgYmVlbiB1c2VkIGFzIGEgbWV0cmljIGZvcg0KPiA+ID4gZWFjaCBj
b21taXQgYmVmb3JlIHN1Ym1pc3Npb24uDQo+ID4gPiBBbmQsIGFsbCB0aGVzZSBjb21taXRzIGFy
ZSBwYXJ0IG9mIHRoZSBmaXJtd2FyZSBjdXJyZW50bHkgcnVubmluZyBvbg0KPiA+ID4gcmVhbCBo
YXJkd2FyZS4NCj4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+ID4gSGlzdG9yeToNCj4gPiA+ID4gPiAt
LS0tLS0tLQ0KPiA+ID4gPiA+IFt2MV06DQo+ID4gPiA+ID4gaHR0cHM6Ly9wYXRjaHdvcmsub3ps
YWJzLm9yZy9wcm9qZWN0L3Vib290L2NvdmVyLzIwMjQwOTE5MDM1NTEyLg0KPiA+ID4gPiA+IDEz
ODUNCj4gPiA+ID4gPiA0LQ0KPiA+ID4gPiA+IDEtZGluZXNoLm1hbml5YW1AaW50ZWwuY29tLw0K
PiA+ID4gPiA+DQo+ID4gPiA+ID4gRGluZXNoIE1hbml5YW0gKDE5KToNCj4gPiA+ID4gPiAgIGR0
OiBuYW5kOiBhZGQgY2FkZW5jZSBuYW5kIGR0LWJpbmRpbmdzDQo+ID4gPiA+ID4gICBhcm06IGR0
czogYWdpbGV4NTogRW5hYmxlZCBjZG5zLW5hbmQgZHRzIHNldHRpbmcNCj4gPiA+ID4gPiAgIGlu
Y2x1ZGU6IGFzbTogQWRkIHN1cHBvcnQgdG8gcmVhZC93cml0ZSA2NC1iaXQNCj4gPiA+ID4gPiAg
IGRyaXZlcnM6IG10ZDogbmFuZDogQWRkIGRyaXZlciBmb3IgQ2FkZW5jZSBOYW5kDQo+ID4gPiA+
ID4gICBkcml2ZXJzOiBtdGQ6IG5hbmQ6IGNhZGVuY2U6IEFkZCBzdXBwb3J0IGZvciByZWFkIHN0
YXR1cyBjb21tYW5kDQo+ID4gPiA+ID4gICBkcml2ZXJzOiBtdGQ6IG5hbmQ6IGNhZGVuY2U6IEFk
ZCBzdXBwb3J0IGZvciByZWFkaWQgY29tbWFuZA0KPiA+ID4gPiA+ICAgZHJpdmVyczogbXRkOiBu
YW5kOiBjYWRlbmNlOiBBZGQgc3VwcG9ydCBmb3IgTkFORF9DTURfUEFSQU0NCj4gPiA+ID4gPiAg
IGRyaXZlcnM6IG10ZDogbmFuZDogY2FkZW5jZTogQWRkIHN1cHBvcnQgZm9yIE5BTkRfQ01EX1JF
U0VUDQo+ID4gPiA+ID4gICBkcml2ZXJzOiBtdGQ6IG5hbmQ6IGNhZGVuY2U6IFN1cHBvcnQgY21k
IFNFVF9GRUFUVVJFUyAmDQo+IEdFVF9GRUFUVVJFUw0KPiA+ID4gPiA+ICAgZHJpdmVyczogbXRk
OiBuYW5kOiBjYWRlbmNlOiBGbHVzaCAmIGludmFsaWRhdGUgZG1hIGRlc2NyaXB0b3INCj4gPiA+
ID4gPiAgIGRyaXZlcnM6IG10ZDogbmFuZDogY2FkZW5jZTogUG9sbCBmb3IgZGVzYyBjb21wbGV0
ZSBzdGF0dXMNCj4gPiA+ID4gPiAgIGRyaXZlcnM6IG10ZDogbmFuZDogY2FkZW5jZTogVXNlIGJv
dW5jZSBidWZmZXINCj4gPiA+ID4gPiAgIGRyaXZlcnM6IG5hbmQ6IEVuYWJsZWQgS2NvbmZpZyBh
bmQgTWFrZWZpbGUgZm9yIGNkbnMtbmFuZA0KPiA+ID4gPiA+ICAgY29uZmlnczogbmFuZDJfZGVm
Y29uZmlnOiBFbmFibGUgY29uZmlncyBmb3IgbmFuZCBib290DQo+ID4gPiA+ID4gICBkcml2ZXJz
OiBtdGQ6IG5hbmQ6IGJhc2U6IEFkZCBzdXBwb3J0IGZvciBIYXJkd2FyZSBFQ0MgZm9yIGNoZWNr
IGJhZA0KPiA+ID4gPiA+ICAgICBibG9jaw0KPiA+ID4gPiA+ICAgZHJpdmVyczogbXRkOiBuYW5k
OiBzcGw6IEFkZCBzdXBwb3J0IGZvciBuYW5kIFNQTCBsb2FkIGltYWdlDQo+ID4gPiA+ID4gICBk
cml2ZXJzOiBtdGQ6IG5hbmQ6IEVuYWJsZWQgS2NvbmZpZyBhbmQgTWFrZWZpbGUgZm9yIENhZGVu
Y2UtU1BMDQo+ID4gPiA+ID4gICBkcml2ZXJzOiBtdGQ6IG5hbmQ6IEtjb25maWc6IFJlbW92ZSBT
WVNfTkFORF9CTE9DS19TSVpFDQo+IGRlcGVuZGVuY3kNCj4gPiA+ID4gPiAgIGRyaXZlcnM6IG10
ZDogbmFuZDogS2NvbmZpZzogRW5hYmxlZCBzZWxmLWluaXQgZm9yIGNkbnMtbmFuZA0KPiA+ID4g
PiA+IFNQTA0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gIGFyY2gvYXJtL2R0cy9zb2NmcGdhX2FnaWxl
eDUuZHRzaSAgICAgICAgICAgICB8ICAgMTQgKw0KPiA+ID4gPiA+ICAuLi4vYXJtL2R0cy9zb2Nm
cGdhX2FnaWxleDVfc29jZGstdS1ib290LmR0c2kgfCAgIDI4ICsNCj4gPiA+ID4gPiAgYXJjaC9h
cm0vaW5jbHVkZS9hc20vaW8uaCAgICAgICAgICAgICAgICAgICAgIHwgICAyNSArDQo+ID4gPiA+
ID4gIGJvYXJkL2ludGVsL2FnaWxleDUtc29jZGsvTUFJTlRBSU5FUlMgICAgICAgICB8ICAgIDIg
Kw0KPiA+ID4gPiA+ICBjb25maWdzL3NvY2ZwZ2FfYWdpbGV4NV9uYW5kMl9kZWZjb25maWcgICAg
ICAgfCAgIDMzICsNCj4gPiA+ID4gPiAgLi4uL210ZC9jYWRlbmNlLG5hbmQueWFtbCAgICAgICAg
ICAgICAgICAgICAgIHwgICA5OCArDQo+ID4gPiA+ID4gIGRyaXZlcnMvbXRkL25hbmQvcmF3L0tj
b25maWcgICAgICAgICAgICAgICAgICB8ICAgMTkgKy0NCj4gPiA+ID4gPiAgZHJpdmVycy9tdGQv
bmFuZC9yYXcvTWFrZWZpbGUgICAgICAgICAgICAgICAgIHwgICAgMiArDQo+ID4gPiA+ID4gIGRy
aXZlcnMvbXRkL25hbmQvcmF3L2NhZGVuY2VfbmFuZC5jICAgICAgICAgICB8IDI0MjQNCj4gKysr
KysrKysrKysrKysrKysNCj4gPiA+ID4gPiAgZHJpdmVycy9tdGQvbmFuZC9yYXcvY2FkZW5jZV9z
cGwuYyAgICAgICAgICAgIHwgICA1OSArDQo+ID4gPiA+ID4gIGRyaXZlcnMvbXRkL25hbmQvcmF3
L25hbmRfYmFzZS5jICAgICAgICAgICAgICB8ICAgNzEgKy0NCj4gPiA+ID4gPiAgaW5jbHVkZS9j
YWRlbmNlLW5hbmQuaCAgICAgICAgICAgICAgICAgICAgICAgIHwgIDUyOSArKysrDQo+ID4gPiA+
ID4gIGluY2x1ZGUvbGludXgvbXRkL3Jhd25hbmQuaCAgICAgICAgICAgICAgICAgICB8ICAgMTQg
Kw0KPiA+ID4gPiA+ICAxMyBmaWxlcyBjaGFuZ2VkLCAzMjkzIGluc2VydGlvbnMoKyksIDI1IGRl
bGV0aW9ucygtKSAgY3JlYXRlDQo+ID4gPiA+ID4gbW9kZQ0KPiA+ID4gPiA+IDEwMDY0NCBjb25m
aWdzL3NvY2ZwZ2FfYWdpbGV4NV9uYW5kMl9kZWZjb25maWcNCj4gPiA+ID4gPiAgY3JlYXRlIG1v
ZGUgMTAwNjQ0DQo+ID4gPiA+ID4gZG9jL2RldmljZS10cmVlLWJpbmRpbmdzL210ZC9jYWRlbmNl
LG5hbmQueWFtbA0KPiA+ID4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9tdGQvbmFu
ZC9yYXcvY2FkZW5jZV9uYW5kLmMNCj4gPiA+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZl
cnMvbXRkL25hbmQvcmF3L2NhZGVuY2Vfc3BsLmMNCj4gPiA+ID4gPiAgY3JlYXRlIG1vZGUgMTAw
NjQ0IGluY2x1ZGUvY2FkZW5jZS1uYW5kLmgNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IC0tDQo+ID4g
PiA+ID4gMi4xOS4wDQo+ID4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gLS0NCj4g
PiA+ID4gTWljaGFlbCBOYXp6YXJlbm8gVHJpbWFyY2hpDQo+ID4gPiA+IENvLUZvdW5kZXIgJiBD
aGllZiBFeGVjdXRpdmUgT2ZmaWNlciBNLiArMzkgMzQ3IDkxMyAyMTcwDQo+ID4gPiA+IG1pY2hh
ZWxAYW1hcnVsYXNvbHV0aW9ucy5jb20gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xw0KPiA+ID4gPg0KPiA+ID4gPiBBbWFydWxhIFNvbHV0aW9ucyBCVg0KPiA+ID4gPiBKb29wIEdl
ZXNpbmt3ZWcgMTI1LCAxMTE0IEFCLCBBbXN0ZXJkYW0sIE5MIFQuICszMSAoMCk4NSAxMTEgOTE3
Mg0KPiA+ID4gPiBpbmZvQGFtYXJ1bGFzb2x1dGlvbnMuY29tIHd3dy5hbWFydWxhc29sdXRpb25z
LmNvbQ0KPiANCj4gDQo+IA0KPiAtLQ0KPiBNaWNoYWVsIE5henphcmVubyBUcmltYXJjaGkNCj4g
Q28tRm91bmRlciAmIENoaWVmIEV4ZWN1dGl2ZSBPZmZpY2VyDQo+IE0uICszOSAzNDcgOTEzIDIx
NzANCj4gbWljaGFlbEBhbWFydWxhc29sdXRpb25zLmNvbQ0KPiBfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fDQo+IA0KPiBBbWFydWxhIFNvbHV0aW9ucyBCVg0KPiBKb29wIEdlZXNp
bmt3ZWcgMTI1LCAxMTE0IEFCLCBBbXN0ZXJkYW0sIE5MIFQuICszMSAoMCk4NSAxMTEgOTE3Mg0K
PiBpbmZvQGFtYXJ1bGFzb2x1dGlvbnMuY29tIHd3dy5hbWFydWxhc29sdXRpb25zLmNvbQ0K
