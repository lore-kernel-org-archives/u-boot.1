Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE2CC021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 16:36:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD67680FF2;
	Wed, 26 Feb 2025 17:36:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="MboJ/nTU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 475A480FDD; Wed, 26 Feb 2025 17:36:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F85F80FF2
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 17:36:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740587783; x=1772123783;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=iOxdSdhp6jS4cvZBo2SAqLxAYLYgR3qLOWkA6a6OrOo=;
 b=MboJ/nTU7ZbO3niu0pZ7J10ovdOOEQW0mTcEvNqBOLlqbP7pJpNtk2cg
 UIKN+Jnduy3taQZG+K2l+xU5bpJxQniwcrC48z5wYSrZkJ2v/Dt8TNOh8
 B1wQ9KzHQYOiWRMSzEvzbmwNwomN3rsyt+UkMazxM0LEunf7b4/r6Na5z
 kOC/ok5n6Nnr3dKAb/ULlyEgq+zXtH34UCXpLRqUwdbYJHOzzOwd1Lh6W
 ODLfzA9bM2L1da2DxmYYw5PvjDSH7UN4kZ2xEZrJtaRguDwFvP43XY1xu
 FN04h/QG5I25Q+IJakS3SUzSnLnw+wNpEuMjQ6vCEqXTVAzxZlXStShEj g==;
X-CSE-ConnectionGUID: ASLRNWk2SBeEgxzRhMGnhA==
X-CSE-MsgGUID: WGgvhuwVRTiD9xzPgqnImQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="41293035"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; d="scan'208";a="41293035"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 08:36:17 -0800
X-CSE-ConnectionGUID: 6lyfjOumQKu3UapnwwHwVQ==
X-CSE-MsgGUID: psu7lmoETq+7rPa7wvkhFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; d="scan'208";a="147574263"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 26 Feb 2025 08:36:17 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 26 Feb 2025 08:36:16 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 08:36:16 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 08:36:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r/PZUyv6yLjxMkyCXDKbbzr+eDoibalvSfWDJCy3eOb+wBXHslpnC3GSpo1Xa/kfJm1I3+zczHvrLDEyeY4fuvSxOnw6h+GmtwsqTxV2sKKlZO2nnxgYj3im+8xDOLorNqSvEUQJuE/Fgfw83f+g1sZU276IMpePuGcxIiRKQiD1j1UQfwkYstZZL5M/H6j5mMvaQzKGFI6+ECA5TQyeu30Pr7stkmdFuKWr7k6oDbgwx7X5HN56VIiYjI5fbRao1uXoEyiU/Ok4dplhubll9mRS2AHju/vl1Nj+XbORFGOS9CGg2DWd8wswP2sw4qTZk8GnTbMXgfqxWmLcXkM54g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOxdSdhp6jS4cvZBo2SAqLxAYLYgR3qLOWkA6a6OrOo=;
 b=NwsRivP9VzoX7Qip82WKjOsCgljN6nrFGWTGPkY9WBvrQ+SQ/iuLNGdmp0LCd9Mn21xK28fN3JbziRCR/iOXTwQDC7QXdQykAfyxlhc1qfcPcYCchsc0+rGEqY7J1b8+OlJeOrarAOFvuAyRvxM2dwM/+pOhnoueleyQIlxlyTH81kqbwWitLfR6XQFrC9gRFzC+Ckl8lVOV/oJ1ttNNLoDW9FhBVR5VSSEadaxMDVMmi9VU5wrYa2u88oAmgshEcYJWxk2MQJmPLtj4SF6/c8qu6ex4DWcHsQ2DvlSiX82gdGB0GSlmdtfosw61i0EJZUFBV/eXZfSpWUk6q+eYaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5366.namprd11.prod.outlook.com (2603:10b6:208:31c::17)
 by PH8PR11MB6801.namprd11.prod.outlook.com (2603:10b6:510:1c9::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.20; Wed, 26 Feb
 2025 16:36:13 +0000
Received: from BL1PR11MB5366.namprd11.prod.outlook.com
 ([fe80::f073:1e46:c7ee:df9b]) by BL1PR11MB5366.namprd11.prod.outlook.com
 ([fe80::f073:1e46:c7ee:df9b%7]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 16:36:13 +0000
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
Thread-Index: AQHbRvdcQWgz78qVlUqpVYczLsrbnbLj8XAAgAYr1NCANxKuMIAGbQMAgDHTXBCAANgwwA==
Date: Wed, 26 Feb 2025 16:36:13 +0000
Message-ID: <BL1PR11MB5366DE98806E5B38856CBB0182C22@BL1PR11MB5366.namprd11.prod.outlook.com>
References: <20241205092315.25060-1-dinesh.maniyam@intel.com>
 <CAOf5uwmPuQOsfXFPZ6Y35E5dWq=bYJNtKRRyVv0Md+ugiPFyPA@mail.gmail.com>
 <BL1PR11MB5366537A8281795B152B69AD82042@BL1PR11MB5366.namprd11.prod.outlook.com>
 <BL1PR11MB536639809DBC02823E22549B82E62@BL1PR11MB5366.namprd11.prod.outlook.com>
 <CAOf5uwmP_u49=axD9Hod3aYLDBNn4Wzz4Th7tK+UsFoCEE23Dg@mail.gmail.com>
 <BL1PR11MB5366E83B40C89039B05C936C82C22@BL1PR11MB5366.namprd11.prod.outlook.com>
In-Reply-To: <BL1PR11MB5366E83B40C89039B05C936C82C22@BL1PR11MB5366.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5366:EE_|PH8PR11MB6801:EE_
x-ms-office365-filtering-correlation-id: 2a72f443-77d4-470f-f894-08dd5683af18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|13003099007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?dU40SW5EMGM5dnMxbTFXbGpFSSszWFd0RTE0Qm1ZUTJFU3RkcXhsS2ZuK2Za?=
 =?utf-8?B?bUd4Tmphak0vUWJoMUJYdzZGeFBmYjZXd0ZlQ1JKSERNTkdIeXpINUJ3Z3BL?=
 =?utf-8?B?R1F5Tkl2bTNlMlU5cmw2MkV2N3JNVXZPSEdBVTNqU2o1THk2RXJ5L1U5U3pG?=
 =?utf-8?B?cHNXNTFPckF3clFvWkJEVkhhUnZFT05IOE9uY0NiVFNvOGtxRFRTYXJQKzdm?=
 =?utf-8?B?WDFGQnRlL2JrdVNBWWNOV3M3d1JpU1ZlTXZpNE13S0F6ZGJSOWtQYy8vWmJj?=
 =?utf-8?B?V05rZHN1bFV5WDlha1NpbHNDR1ArcjBPbzNnQU1jUzZOKzcrQ01JNnBNaTlI?=
 =?utf-8?B?aWlBV3JjUjNtM3Q0ZXZGV3hHdjJXZGdFRW9WR0dxcDJodWRjMDI5bkRVTWdW?=
 =?utf-8?B?NDNzS3IwR3htM2lNRmF4bHFib1Fub0hUendkRzlvRHhZWFJuNktaeXhDUlc4?=
 =?utf-8?B?WmZKdXBsa2l3L2prTDM4d2p6a01pMzBPMzZoMm4wQlRQMkQyd3ZYQnJKdXdR?=
 =?utf-8?B?Nzd6bXpxVHRIUVRUQjRXTjM4bndnSk54RTR6OUNINnJGUTZQSFdsL2pzUWVp?=
 =?utf-8?B?Z1Ayc1F0S05Rbk1vTFMzYWhVMWxNV3VKTTN6elNmNWJOYjN1bm9EUGZ1UmNB?=
 =?utf-8?B?Q3JtbWdjOWJIVmsybzRaaHNlMkpFYVhLS2NCQUdRNW5UU3BJNHROVk90NTVU?=
 =?utf-8?B?d3o4UUtmSFRVVC96RitPSi9EeHZOaE5aZFVnTUpXaDJqOG9LK1lXSWF6RUVB?=
 =?utf-8?B?S3NEYXdmMk90S3R2OXBaNHNYZFE5aHJCVWoveVd4RHBCMFFPQ0NDamtIeWxK?=
 =?utf-8?B?TGdrd25yM0FhQUdMR1lIaGNuN2dEK3ZNWVRFYk0wSHI5MVpvdWV5bVVJS0Vw?=
 =?utf-8?B?dC9uZnlSODQwaTVGT3F2V1pjaktUK05pZElaZ0JnV3BKNkhKL0syQWJ4VU1M?=
 =?utf-8?B?Qm1sWFFuaUxpVkZ5YllMTnBoeWxwSHlZVE9xT1dPYW5uMTJPZmlkWmpjRVlm?=
 =?utf-8?B?ZGdtT3l6YVYrRjVzNGJSYUFrS1ZMRGJGZzF1dFdwdTVjYnAvT3dPd2Y5Y1Vj?=
 =?utf-8?B?T1pkcnIwMm5vd2RiTk5RK2VZRCs3VXpLZWljeTRDbXlPYTNuZWtxQ1VGMG9S?=
 =?utf-8?B?dWZ1alVlMExGYUJkZ2ZDVmdZNzhOaTFmSFZ5YUJqWUdCdUFQVmQxcldQRW13?=
 =?utf-8?B?N3JQc0laa244SjY0aEREWERsY1JDU1RkRk9pWUZ4LzRXNDdmbTVoRzc4bnZD?=
 =?utf-8?B?ZDhKckFtQmtSK1lYd0ozOC9QazBoVSt0OWxvWmpXMGdvS1JVSytQUHpQcW9r?=
 =?utf-8?B?Nmd2RE5naC9HNHlmcDk0alRLV2tDcHU4NWd2dDEycU9JWklGQzR0QVlEVVdr?=
 =?utf-8?B?K2p5T24vcEZQeHlNWFlZUXRLU1hnRDA4QjZkUnpLaFNBVVo4b0VsaHhtRWl1?=
 =?utf-8?B?UWV6cXcveUdCbU92ckFCUmE0R2ZteXd3T3JLbTE4bU50NklZZkZSY0Z2K2xG?=
 =?utf-8?B?ZXBrcEt6NU9TMnVsMW9FQzd1aDZ0YVloNVF6R1NNVmNXem5vQnlkdHVWLzVl?=
 =?utf-8?B?aXlJQnJDTXhRVW9OaDB3TFJDNGpFZU1xejRPTGFzYjZGTUk1VmNVWFpvT0lD?=
 =?utf-8?B?NlYyeHlFWFI5SC9LM0p2a0tEN1FHL3hDT1ZsNE01Y08zL0RNUmdQZlZuOC81?=
 =?utf-8?B?WFg1cCt0ZVRkMlduSXNvcHVKVjI0bDRQcDhFbTEyQWFLZFVoa1hzNGVQdmR2?=
 =?utf-8?B?NnpWbmFMWGUrUXFEUE0rVTEwUDFKRTQ0dEZOY3lmYU43TjNQSy9CVUNlVzZS?=
 =?utf-8?B?Si9leEp6YnNKaUxRK0EwMXJTMy9zcG9HZHQ2NS8vZHRwaGZrNU9DeHlrSlp2?=
 =?utf-8?Q?96rhw7C1IvU4M?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR11MB5366.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(13003099007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3NqenRYVkRHZkhTVWRraXQ4RTViWWQ5MVprbjhjazFteWZONjFreStCTTY2?=
 =?utf-8?B?TE5VZ2g5aVBvTTBYYXhndkFBNXk0ZklMTUpsbDJDdEs0MWVzNFJOWHljYWNk?=
 =?utf-8?B?eDI5NkFjeG9SZFFqMmhnTHJmVjlXVGlVOUFzNFJVOWZVclg1QURZc29MbWZo?=
 =?utf-8?B?dHhGQVdGUTUyMHg5Zm55V0dnUnhHSGkvaHFRRGtuTXBhbkhjbTd3T3R4VkV6?=
 =?utf-8?B?T3UxSkx5RFhLMG5nNzNNQldxTk8ydEk3YVR0WEl6UHNsWEVwQXlsZWtCTmMw?=
 =?utf-8?B?a0VCaVpuNSt5dVRkZ3dVbHRmVDV5a3c1ekNjbVB2ZWRjSEMxUS9RZm9xVEdm?=
 =?utf-8?B?bWF2OGxIYkFUOVZQWGYvYkEzZTFndDNOOTFqSTdYQXdOQ0xCRjAwb2ZrWC9C?=
 =?utf-8?B?SnlBVEVFVU5DdlFmZ0h4Q3hGcmkrY3A4ZytHbFNLei96aHhWZlI0OFN1K2cw?=
 =?utf-8?B?dXVTMzltR0xocWMwenRmWHVOUXRVRHcya1pXKzZ6NTJKbUhTS1RGZGtRK1dk?=
 =?utf-8?B?MTl0K3hEbmI2em9SMUNJRlYrUTJUSWdhZm81UytzRSs1cVhxOTlUQ25SS1h4?=
 =?utf-8?B?MllLOEFmSG5zU25NS0MzOU1YZit3eFhUWEo1MGFDOUhmVWM3ZFBSbzdLeTZk?=
 =?utf-8?B?Qi9MSkszdms0cDFRaUVqQ3N1b2pKeFJSdXowMFRldG52eVJKZC9jbWM1cHJn?=
 =?utf-8?B?eWR6bWt2akdwTlhnSWFvaWxFMFdrRjF5clBabkI1WVAwcjhFL3ptdjRLRUk1?=
 =?utf-8?B?QnhESUovazFvKzhSd2syV0dhYWhqd2ovT0ZrcndqQmM3WmlhY1pBUWgzTlBz?=
 =?utf-8?B?Szh4bFlTSTkvc3Z0VGtUa2tMUXhPK09ZNjRxT2FpY2U5NnFPQzFueWtWZGVx?=
 =?utf-8?B?djlYWjducm1BWUl2K0pMc1ZUbkVmUzZmcVd4UXR4RFh1eUVreWpsYXFjZFpR?=
 =?utf-8?B?dUt0ZGxKWE82TEdhcE1oMHFTaFUxT21wRWx3S2s4aHE4R1U1MWxYR0hmc2xK?=
 =?utf-8?B?dWFldCt1S0JHc0NMNzhnRHpubzY5ZTBoYjFPSlBpWkV5OUltb0p5Q0ZKeTNL?=
 =?utf-8?B?YmZ3c3BHUnQ4Szl5YXhRdUtBNWhFelFCc0dJMEIxMmVVclZ2VktWZ2tCNlR0?=
 =?utf-8?B?dXhpYUNXWEdhKzRiNW5UcHNqTWErN0lsQTkzNG1YVE9mRzdWV2t0Y2xKRmZ4?=
 =?utf-8?B?SzZoeVRNUzJ1R3hHSVNCVHJwS0o4SnhEblljWUhGclRQYjZmdWFMQlBYTmVQ?=
 =?utf-8?B?OEtjVmw2SlY1WWMyck8rbFV2OFZYUGt0ZVNsekwzc2ptVlFtZ1Q0eGJoeDdl?=
 =?utf-8?B?SnBBaXIyRngxQVFJSjV3ZWZCUTdNWEVYemVNeG1McU0vTWxGbGd6dkd5U1lT?=
 =?utf-8?B?RnplTUszdWE0YzN1STBUMXlnS2UzdFZqK3pFSlNmOVYxWm16aGhmVVNnOW0z?=
 =?utf-8?B?Nk1iaVZQdTY0TmtuMmY1dlp4UE9Zb1RvNUw5MmViUUxrMjRzR1pRVjlKZk5E?=
 =?utf-8?B?QUJUZUZyT0RGV3dOaThhZkxZSHlZQlViZTNHWU02MkdyUVdIRHVEd0dGV3VN?=
 =?utf-8?B?cHRSZkd6NGV4aWhqSDZpQWMzbmRLRC96UWFrZHJrV09nYW9CQ00yWFZ2QzYw?=
 =?utf-8?B?V3hVY2thRmdydnRMRzAzNGdjYytZV1JmOEhWcG9JUEJ4V2xTVjJzcGpGTndu?=
 =?utf-8?B?WjBOR09QUUFIMnAvR3VaMlU0NWltcjl1cGpsbTlRUG1zcjFGTEFwQUJDaWR3?=
 =?utf-8?B?QVVsQ0NLZjdPYTBQTDFCdXYwOC9zVVlDYUxyZXhuNm1aNU1TcjMwR1luVTVF?=
 =?utf-8?B?ZEtYY3pTaGJoVk12MEhJV2ZENWZKdTVhZERIYVJIb0NpSm9tdmttaHZVMkJC?=
 =?utf-8?B?L0JtcnNMaWkveHk5SGRFRThFbjJEekhKSTErQXVKSGpEeGd3OFJKZFF6cFBo?=
 =?utf-8?B?NWlBVXNoVGFobWZIeGV6czF5WDFTZFJHWjgxd3Q4MUFZakd5ak4vam9HWUtR?=
 =?utf-8?B?NlZkZXliY3pIMVpoQ1hINVMzTytIRnYrU3BWbHM3Ujl2QzNKSERWY0NJRnFw?=
 =?utf-8?B?UmtYMmppRjlGRkF0eHluOG5zak9teitmY3o0L0dubDY1NlhXd0lORFlpR2s4?=
 =?utf-8?Q?nRqynF/orGpxXmbGmwEK+vK+3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a72f443-77d4-470f-f894-08dd5683af18
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 16:36:13.4458 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tvc/0FmpazRsor1rGwd/u1Wmd7VXADV8FdYCrplvcFP55Nf+Cjfs9CNkwEXGy6g2j9Um1NL7QE+DGOF/fnX6PC7QyaGMVbZ6enTOvJm7HAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6801
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFuaXlhbSwgRGluZXNo
DQo+IFNlbnQ6IFdlZG5lc2RheSwgMjYgRmVicnVhcnkgMjAyNSAxMTozNyBhbQ0KPiBUbzogJ01p
Y2hhZWwgTmF6emFyZW5vIFRyaW1hcmNoaScgPG1pY2hhZWxAYW1hcnVsYXNvbHV0aW9ucy5jb20+
DQo+IENjOiB1LWJvb3RAbGlzdHMuZGVueC5kZTsgTWFyZWsgPG1hcmV4QGRlbnguZGU+OyBTaW1v
bg0KPiA8c2ltb24uay5yLmdvbGRzY2htaWR0QGdtYWlsLmNvbT47IFRvbSBSaW5pIDx0cmluaUBr
b25zdWxrby5jb20+OyBEYXJpbw0KPiBCaW5hY2NoaSA8ZGFyaW8uYmluYWNjaGlAYW1hcnVsYXNv
bHV0aW9ucy5jb20+OyBKb2hhbiBKb25rZXINCj4gPGpieDYyNDRAZ21haWwuY29tPjsgTWljaGFs
IFNpbWVrIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47IEFyc2VuaXkNCj4gS3Jhc25vdiA8YXZrcmFz
bm92QHNhbHV0ZWRldmljZXMuY29tPjsgQWxleGFuZGVyIERhaGwgPGFkYUB0aG9yc2lzLmNvbT47
DQo+IFdpbGxpYW0gWmhhbmcgPHdpbGxpYW0uemhhbmdAYnJvYWRjb20uY29tPjsgSWdvciBQcnVz
b3YNCj4gPGl2cHJ1c292QHNhbHV0ZWRldmljZXMuY29tPjsgTWVuZywgVGluZ3RpbmcgPHRpbmd0
aW5nLm1lbmdAaW50ZWwuY29tPjsNCj4gQ2hlZSwgVGllbiBGb25nIDx0aWVuLmZvbmcuY2hlZUBp
bnRlbC5jb20+OyBIZWEsIEtvayBLaWFuZw0KPiA8a29rLmtpYW5nLmhlYUBpbnRlbC5jb20+OyBO
ZywgQm9vbiBLaGFpIDxCb29uLktoYWkuTmdAaW50ZWwuY29tPjsgWXVzbGFpbWksDQo+IEFsaWYg
WmFrdWFuIDxhbGlmLnpha3Vhbi55dXNsYWltaUBpbnRlbC5jb20+OyBaYW1yaSwgTXVoYW1tYWQg
SGF6aW0gSXp6YXQNCj4gPG11aGFtbWFkLmhhemltLml6emF0LnphbXJpQGludGVsLmNvbT47IExp
bSwgSml0IExvb24NCj4gPGppdC5sb29uLmxpbUBpbnRlbC5jb20+OyBUYW5nLCBTaWV1IE11biA8
U2lldS5NdW4uVGFuZ0BpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJFOiBbcmVzZW5kIHYyIDAwLzE5
XSBBZGQgQ2FkZW5jZSBOQU5EIERyaXZlciBzdXBwb3J0DQo+IA0KPiANCj4gDQo+ID4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBNaWNoYWVsIE5henphcmVubyBUcmltYXJj
aGkgPG1pY2hhZWxAYW1hcnVsYXNvbHV0aW9ucy5jb20+DQo+ID4gU2VudDogU2F0dXJkYXksIDI1
IEphbnVhcnkgMjAyNSA2OjQwIHBtDQo+ID4gVG86IE1hbml5YW0sIERpbmVzaCA8ZGluZXNoLm1h
bml5YW1AaW50ZWwuY29tPg0KPiA+IENjOiB1LWJvb3RAbGlzdHMuZGVueC5kZTsgTWFyZWsgPG1h
cmV4QGRlbnguZGU+OyBTaW1vbg0KPiA+IDxzaW1vbi5rLnIuZ29sZHNjaG1pZHRAZ21haWwuY29t
PjsgVG9tIFJpbmkgPHRyaW5pQGtvbnN1bGtvLmNvbT47DQo+ID4gRGFyaW8gQmluYWNjaGkgPGRh
cmlvLmJpbmFjY2hpQGFtYXJ1bGFzb2x1dGlvbnMuY29tPjsgSm9oYW4gSm9ua2VyDQo+ID4gPGpi
eDYyNDRAZ21haWwuY29tPjsgTWljaGFsIFNpbWVrIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47IEFy
c2VuaXkNCj4gPiBLcmFzbm92IDxhdmtyYXNub3ZAc2FsdXRlZGV2aWNlcy5jb20+OyBBbGV4YW5k
ZXIgRGFobA0KPiA+IDxhZGFAdGhvcnNpcy5jb20+OyBXaWxsaWFtIFpoYW5nIDx3aWxsaWFtLnpo
YW5nQGJyb2FkY29tLmNvbT47IElnb3INCj4gPiBQcnVzb3YgPGl2cHJ1c292QHNhbHV0ZWRldmlj
ZXMuY29tPjsgTWVuZywgVGluZ3RpbmcNCj4gPiA8dGluZ3RpbmcubWVuZ0BpbnRlbC5jb20+OyBD
aGVlLCBUaWVuIEZvbmcgPHRpZW4uZm9uZy5jaGVlQGludGVsLmNvbT47DQo+ID4gSGVhLCBLb2sg
S2lhbmcgPGtvay5raWFuZy5oZWFAaW50ZWwuY29tPjsgTmcsIEJvb24gS2hhaQ0KPiA+IDxib29u
LmtoYWkubmdAaW50ZWwuY29tPjsgWXVzbGFpbWksIEFsaWYgWmFrdWFuDQo+ID4gPGFsaWYuemFr
dWFuLnl1c2xhaW1pQGludGVsLmNvbT47IFphbXJpLCBNdWhhbW1hZCBIYXppbSBJenphdA0KPiA+
IDxtdWhhbW1hZC5oYXppbS5penphdC56YW1yaUBpbnRlbC5jb20+OyBMaW0sIEppdCBMb29uDQo+
ID4gPGppdC5sb29uLmxpbUBpbnRlbC5jb20+OyBUYW5nLCBTaWV1IE11biA8c2lldS5tdW4udGFu
Z0BpbnRlbC5jb20+DQo+ID4gU3ViamVjdDogUmU6IFtyZXNlbmQgdjIgMDAvMTldIEFkZCBDYWRl
bmNlIE5BTkQgRHJpdmVyIHN1cHBvcnQNCj4gPg0KPiA+IEhpIERpbmVzaA0KPiA+DQo+ID4gT24g
VHVlLCBKYW4gMjEsIDIwMjUgYXQgOTozOeKAr0FNIE1hbml5YW0sIERpbmVzaA0KPiA+IDxkaW5l
c2gubWFuaXlhbUBpbnRlbC5jb20+DQo+ID4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gSGkgTWljaGFl
bCwNCj4gPiA+DQo+ID4gPiBBbnkgdXBkYXRlIG9uIG15IE5BTkQgcGF0Y2hzZXQgPy4gSSBjYW4g
c2VlIGl0IGlzIHN0aWxsIHVuZGVyIHJldmlldy4NCj4gPiA+IElzIHRoZXJlIGFueXRoaW5nIEkg
Y2FuIGRvIGZyb20gbXkgc2lkZSB0byBzcGVlZCB1cCB0aGUgcmV2aWV3IHByb2Nlc3M/DQo+ID4g
PiBUaGFua3MgZm9yIHlvdXIgdGltZS4NCj4gPiA+DQo+ID4NCj4gPiBXZWxsLCBsYXN0IHRpbWUg
d2FzIG5vdCBwYWFzc2luZyB0aGUgQ0kuIEkgd2lsbCB0ZXN0IGl0IGFnYWluIHRvZGF5DQo+ID4N
Cj4gPiBNaWNoYWVsDQo+ID4NCj4gDQo+IEhvcGUgeW91IGFscmVhZHkgcnVuIHRoZSBDSSB0ZXN0
IGFnYWluLg0KPiBJZiBmYWlsaW5nLCBtYXkgSSBnZXQgdGhlIGxpbmsgdG8gdGhlIGZhaWxpbmcg
bGlzdCBvZiB0ZXN0cz8NCj4gDQo+IERpbmVzaA0KPiANCg0KQXBvbG9naWVzIQ0KSSB0aGluayB5
b3UgbWVudGlvbmVkIHRoYXQgeW91wqB3ZXJlIHVuYWJsZSB0byBidWlsZCB0aGUgY29kZS4NCkkg
cmVzdWJtaXR0ZWQgdjMgb2YgdGhpcyBwYXRjaHNldCwgd2hpY2ggd2lsbCByZXNvbHZlIHdhcm5p
bmcvDQpjb21waWxhdGlvbiBpc3N1ZS4gWW91IGNhbiBsb29rIGF0IHRoZSBjb3ZlciBwYXRjaCB0
byBzZWUNCnRoZSBjaGFuZ2VzIG1hZGUgZm9yIHYzIGluIGRldGFpbC4NClBsZWFzZSBoZWxwIHRv
IHVzZSB0aGlzIHYzIHBhdGNoc2V0IGluIHJ1bm5pbmcgQ0kgdGVzdC4gUGxlYXNlIGxldCBtZSBr
bm93DQppZiB5b3UgZmFjZSBhbnkgZGlmZmljdWx0aWVzLg0KVGhhbmtzIGZvciB5b3VyIHRpbWUg
YW5kIGNvbnNpZGVyYXRpb24uDQoNCkRpbmVzaA0KDQo+ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+ID4gPiA+IEZyb206IE1hbml5YW0sIERpbmVzaA0KPiA+ID4gPiBTZW50OiBU
dWVzZGF5LCAxNyBEZWNlbWJlciAyMDI0IDM6NDEgcG0NCj4gPiA+ID4gVG86IE1pY2hhZWwgTmF6
emFyZW5vIFRyaW1hcmNoaSA8bWljaGFlbEBhbWFydWxhc29sdXRpb25zLmNvbT4NCj4gPiA+ID4g
Q2M6IHUtYm9vdEBsaXN0cy5kZW54LmRlOyBNYXJlayA8bWFyZXhAZGVueC5kZT47IFNpbW9uDQo+
ID4gPiA+IDxzaW1vbi5rLnIuZ29sZHNjaG1pZHRAZ21haWwuY29tPjsgVG9tIFJpbmkgPHRyaW5p
QGtvbnN1bGtvLmNvbT47DQo+ID4gPiA+IERhcmlvIEJpbmFjY2hpIDxkYXJpby5iaW5hY2NoaUBh
bWFydWxhc29sdXRpb25zLmNvbT47IEpvaGFuIEpvbmtlcg0KPiA+ID4gPiA8amJ4NjI0NEBnbWFp
bC5jb20+OyBNaWNoYWwgU2ltZWsgPG1pY2hhbC5zaW1la0BhbWQuY29tPjsgQXJzZW5peQ0KPiA+
ID4gPiBLcmFzbm92IDxhdmtyYXNub3ZAc2FsdXRlZGV2aWNlcy5jb20+OyBBbGV4YW5kZXIgRGFo
bA0KPiA+ID4gPiA8YWRhQHRob3JzaXMuY29tPjsgV2lsbGlhbSBaaGFuZyA8d2lsbGlhbS56aGFu
Z0Bicm9hZGNvbS5jb20+Ow0KPiA+ID4gPiBJZ29yIFBydXNvdiA8aXZwcnVzb3ZAc2FsdXRlZGV2
aWNlcy5jb20+OyBNZW5nLCBUaW5ndGluZw0KPiA+ID4gPiA8dGluZ3RpbmcubWVuZ0BpbnRlbC5j
b20+OyBDaGVlLCBUaWVuIEZvbmcNCj4gPiA+ID4gPHRpZW4uZm9uZy5jaGVlQGludGVsLmNvbT47
IEhlYSwgS29rIEtpYW5nDQo+ID4gPiA+IDxrb2sua2lhbmcuaGVhQGludGVsLmNvbT47IE5nLCBC
b29uIEtoYWkgPEJvb24uS2hhaS5OZ0BpbnRlbC5jb20+Ow0KPiA+ID4gPiBZdXNsYWltaSwgQWxp
ZiBaYWt1YW4gPGFsaWYuemFrdWFuLnl1c2xhaW1pQGludGVsLmNvbT47IFphbXJpLA0KPiA+ID4g
PiBNdWhhbW1hZCBIYXppbSBJenphdCA8bXVoYW1tYWQuaGF6aW0uaXp6YXQuemFtcmlAaW50ZWwu
Y29tPjsgTGltLA0KPiA+ID4gPiBKaXQgTG9vbiA8aml0Lmxvb24ubGltQGludGVsLmNvbT47IFRh
bmcsIFNpZXUgTXVuDQo+ID4gPiA+IDxTaWV1Lk11bi5UYW5nQGludGVsLmNvbT4NCj4gPiA+ID4g
U3ViamVjdDogUkU6IFtyZXNlbmQgdjIgMDAvMTldIEFkZCBDYWRlbmNlIE5BTkQgRHJpdmVyIHN1
cHBvcnQNCj4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiA+ID4gPiA+IEZyb206IE1pY2hhZWwgTmF6emFyZW5vIFRyaW1hcmNo
aSA8bWljaGFlbEBhbWFydWxhc29sdXRpb25zLmNvbT4NCj4gPiA+ID4gPiBTZW50OiBGcmlkYXks
IDEzIERlY2VtYmVyIDIwMjQgNToxNiBwbQ0KPiA+ID4gPiA+IFRvOiBNYW5peWFtLCBEaW5lc2gg
PGRpbmVzaC5tYW5peWFtQGludGVsLmNvbT4NCj4gPiA+ID4gPiBDYzogdS1ib290QGxpc3RzLmRl
bnguZGU7IE1hcmVrIDxtYXJleEBkZW54LmRlPjsgU2ltb24NCj4gPiA+ID4gPiA8c2ltb24uay5y
LmdvbGRzY2htaWR0QGdtYWlsLmNvbT47IFRvbSBSaW5pDQo+ID4gPiA+ID4gPHRyaW5pQGtvbnN1
bGtvLmNvbT47IERhcmlvIEJpbmFjY2hpDQo+ID4gPiA+ID4gPGRhcmlvLmJpbmFjY2hpQGFtYXJ1
bGFzb2x1dGlvbnMuY29tPjsgSm9oYW4gSm9ua2VyDQo+ID4gPiA+ID4gPGpieDYyNDRAZ21haWwu
Y29tPjsgTWljaGFsIFNpbWVrIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47DQo+ID4gPiA+ID4gQXJz
ZW5peSBLcmFzbm92IDxhdmtyYXNub3ZAc2FsdXRlZGV2aWNlcy5jb20+OyBBbGV4YW5kZXIgRGFo
bA0KPiA+ID4gPiA+IDxhZGFAdGhvcnNpcy5jb20+OyBXaWxsaWFtIFpoYW5nIDx3aWxsaWFtLnpo
YW5nQGJyb2FkY29tLmNvbT47DQo+ID4gPiA+ID4gSWdvciBQcnVzb3YgPGl2cHJ1c292QHNhbHV0
ZWRldmljZXMuY29tPjsgTWVuZywgVGluZ3RpbmcNCj4gPiA+ID4gPiA8dGluZ3RpbmcubWVuZ0Bp
bnRlbC5jb20+OyBDaGVlLCBUaWVuIEZvbmcNCj4gPiA+ID4gPiA8dGllbi5mb25nLmNoZWVAaW50
ZWwuY29tPjsgSGVhLCBLb2sgS2lhbmcNCj4gPiA+ID4gPiA8a29rLmtpYW5nLmhlYUBpbnRlbC5j
b20+OyBOZywgQm9vbiBLaGFpDQo+ID4gPiA+ID4gPGJvb24ua2hhaS5uZ0BpbnRlbC5jb20+OyBZ
dXNsYWltaSwgQWxpZiBaYWt1YW4NCj4gPiA+ID4gPiA8YWxpZi56YWt1YW4ueXVzbGFpbWlAaW50
ZWwuY29tPjsgWmFtcmksIE11aGFtbWFkIEhhemltIEl6emF0DQo+ID4gPiA+ID4gPG11aGFtbWFk
LmhhemltLml6emF0LnphbXJpQGludGVsLmNvbT47IExpbSwgSml0IExvb24NCj4gPiA+ID4gPiA8
aml0Lmxvb24ubGltQGludGVsLmNvbT47IFRhbmcsIFNpZXUgTXVuDQo+ID4gPiA+ID4gPHNpZXUu
bXVuLnRhbmdAaW50ZWwuY29tPg0KPiA+ID4gPiA+IFN1YmplY3Q6IFJlOiBbcmVzZW5kIHYyIDAw
LzE5XSBBZGQgQ2FkZW5jZSBOQU5EIERyaXZlciBzdXBwb3J0DQo+ID4gPiA+ID4NCj4gPiA+ID4g
PiBIaQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gT24gVGh1LCBEZWMgNSwgMjAyNCBhdCAxMDoyM+KA
r0FNIDxkaW5lc2gubWFuaXlhbUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+ID4gPiA+ID4NCj4gPiA+
ID4gPiA+IEZyb206IERpbmVzaCBNYW5peWFtIDxkaW5lc2gubWFuaXlhbUBpbnRlbC5jb20+DQo+
ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gVGhpcyBwYXRjaHNldCBhZGQgQ2FkZW5jZSBOQU5EIGRy
aXZlciBzdXBwb3J0IGZvciBJbnRlbA0KPiA+ID4gPiA+ID4gQWdpbGV4NSBkZXZpY2VzLg0KPiA+
ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFRoZSBOQU5EIGRyaXZlciBpcyBsZXZlcmFnZWQgZnJvbSB0
aGUNCj4gPiA+ID4gPiA+IGNhZGVuY2UtbmFuZC1jb250cm9sbGVyLmMgZnJvbSBMaW51eCB2ZXJz
aW9uIDYuMTEuMi4gVS1Cb290DQo+ID4gPiA+ID4gPiB3aWxsIHN1cHBvcnQgcmVhZCwgd3JpdGUg
YW5kIGVyYXNlIE5BTkQgd2l0aCBDYWRlbmNlIGRyaXZlci4NCj4gPiA+ID4gPiA+IFRoZSBkcml2
ZXIgZnVydGhlciBlbmhhbmNlZCBpbiBVLUJvb3QgdG8gc3VwcG9ydCBOQU5EIGJvb3RpbmcNCj4g
PiA+ID4gPiA+IGZyb20gRlNCTCBhbmQgc3VwcG9ydCBib290IHRvIGtlcm5lbCB2aWENCj4gPiBV
QklGUy4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBQYXRjaCBzdGF0dXM6DQo+ID4gPiA+ID4g
PiBIYXZlIGNoYW5nZXM6IEFsbCBwYXRjaGVzIGV4cGVjdCBQYXRjaCAxOQ0KPiA+ID4gPiA+ID4N
Cj4gPiA+ID4gPiA+IERldGFpbCBjaGFuZ2Vsb2cgY2FuIGZpbmQgaW4gY29tbWl0IG1lc3NhZ2Uu
DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gdjEtPnYyOg0KPiA+ID4gPiA+ID4gLS0tLS0tLS0N
Cj4gPiA+ID4gPiA+IFBhdGNoIDEgLSAxODoNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiAtIHJl
bW92ZSB0aGUgInRoaXMgcGF0Y2ggaXMgdG8iIGNvbW1pdCBwaHJhc2VzDQo+ID4gPiA+ID4gPg0K
PiA+ID4gPiA+ID4gUGF0Y2ggNDsNCj4gPiA+ID4gPiA+IC0gbWlub3IgcmVmYWN0b3Jpbmcgb2Yg
Y29kZSB0byBtYXRjaCB0aGUgc3RhYmxlIHZlcnNpb24gNi4xMS4yLg0KPiA+ID4gPiA+ID4NCj4g
PiA+ID4gPiA+IFBhdGNoIDE0Og0KPiA+ID4gPiA+ID4gLSBBZGQgbWFpbnRhaW5lciBhbmQgIiNp
bmNsdWRlIiBtZWNoYW5pc20gZm9yIG5ldyB2YXJpYW50DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+
ID4gUGF0Y2ggMTY6DQo+ID4gPiA+ID4gPiAtIGxldmVyYWdlIHRoZSBleGlzdGluZyBuYW5kX3Nw
bF9sb2FkX2ltYWdlDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSSBoYXZlIHRy
aWVkIHRvIGJ1aWxkIGJ1dCBpdCBkb2VzIG5vdCB3b3JrLiBIYXZlIHlvdSB0ZXN0ZWQgaW4gZ2l0
aHViPw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gTWljaGFlbA0KPiA+ID4gPg0KPiA+ID4gPiBZZXQg
dG8gZGVwbG95IGdpdGh1YiB0ZXN0IG9uIG91ciBjdXJyZW50IHBsYXRmb3JtLg0KPiA+ID4gPiBP
bmx5IGNoZWNrcGF0Y2gucGwgYW5kIGxvY2FsIGJ1aWx0IGhhcyBiZWVuIHVzZWQgYXMgYSBtZXRy
aWMgZm9yDQo+ID4gPiA+IGVhY2ggY29tbWl0IGJlZm9yZSBzdWJtaXNzaW9uLg0KPiA+ID4gPiBB
bmQsIGFsbCB0aGVzZSBjb21taXRzIGFyZSBwYXJ0IG9mIHRoZSBmaXJtd2FyZSBjdXJyZW50bHkg
cnVubmluZw0KPiA+ID4gPiBvbiByZWFsIGhhcmR3YXJlLg0KPiA+ID4gPg0KPiA+ID4gPiA+DQo+
ID4gPiA+ID4gPiBIaXN0b3J5Og0KPiA+ID4gPiA+ID4gLS0tLS0tLS0NCj4gPiA+ID4gPiA+IFt2
MV06DQo+ID4gPiA+ID4gPiBodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3QvdWJv
b3QvY292ZXIvMjAyNDA5MTkwMzU1MTIuDQo+ID4gPiA+ID4gPiAxMzg1DQo+ID4gPiA+ID4gPiA0
LQ0KPiA+ID4gPiA+ID4gMS1kaW5lc2gubWFuaXlhbUBpbnRlbC5jb20vDQo+ID4gPiA+ID4gPg0K
PiA+ID4gPiA+ID4gRGluZXNoIE1hbml5YW0gKDE5KToNCj4gPiA+ID4gPiA+ICAgZHQ6IG5hbmQ6
IGFkZCBjYWRlbmNlIG5hbmQgZHQtYmluZGluZ3MNCj4gPiA+ID4gPiA+ICAgYXJtOiBkdHM6IGFn
aWxleDU6IEVuYWJsZWQgY2Rucy1uYW5kIGR0cyBzZXR0aW5nDQo+ID4gPiA+ID4gPiAgIGluY2x1
ZGU6IGFzbTogQWRkIHN1cHBvcnQgdG8gcmVhZC93cml0ZSA2NC1iaXQNCj4gPiA+ID4gPiA+ICAg
ZHJpdmVyczogbXRkOiBuYW5kOiBBZGQgZHJpdmVyIGZvciBDYWRlbmNlIE5hbmQNCj4gPiA+ID4g
PiA+ICAgZHJpdmVyczogbXRkOiBuYW5kOiBjYWRlbmNlOiBBZGQgc3VwcG9ydCBmb3IgcmVhZCBz
dGF0dXMgY29tbWFuZA0KPiA+ID4gPiA+ID4gICBkcml2ZXJzOiBtdGQ6IG5hbmQ6IGNhZGVuY2U6
IEFkZCBzdXBwb3J0IGZvciByZWFkaWQgY29tbWFuZA0KPiA+ID4gPiA+ID4gICBkcml2ZXJzOiBt
dGQ6IG5hbmQ6IGNhZGVuY2U6IEFkZCBzdXBwb3J0IGZvciBOQU5EX0NNRF9QQVJBTQ0KPiA+ID4g
PiA+ID4gICBkcml2ZXJzOiBtdGQ6IG5hbmQ6IGNhZGVuY2U6IEFkZCBzdXBwb3J0IGZvciBOQU5E
X0NNRF9SRVNFVA0KPiA+ID4gPiA+ID4gICBkcml2ZXJzOiBtdGQ6IG5hbmQ6IGNhZGVuY2U6IFN1
cHBvcnQgY21kIFNFVF9GRUFUVVJFUyAmDQo+ID4gR0VUX0ZFQVRVUkVTDQo+ID4gPiA+ID4gPiAg
IGRyaXZlcnM6IG10ZDogbmFuZDogY2FkZW5jZTogRmx1c2ggJiBpbnZhbGlkYXRlIGRtYSBkZXNj
cmlwdG9yDQo+ID4gPiA+ID4gPiAgIGRyaXZlcnM6IG10ZDogbmFuZDogY2FkZW5jZTogUG9sbCBm
b3IgZGVzYyBjb21wbGV0ZSBzdGF0dXMNCj4gPiA+ID4gPiA+ICAgZHJpdmVyczogbXRkOiBuYW5k
OiBjYWRlbmNlOiBVc2UgYm91bmNlIGJ1ZmZlcg0KPiA+ID4gPiA+ID4gICBkcml2ZXJzOiBuYW5k
OiBFbmFibGVkIEtjb25maWcgYW5kIE1ha2VmaWxlIGZvciBjZG5zLW5hbmQNCj4gPiA+ID4gPiA+
ICAgY29uZmlnczogbmFuZDJfZGVmY29uZmlnOiBFbmFibGUgY29uZmlncyBmb3IgbmFuZCBib290
DQo+ID4gPiA+ID4gPiAgIGRyaXZlcnM6IG10ZDogbmFuZDogYmFzZTogQWRkIHN1cHBvcnQgZm9y
IEhhcmR3YXJlIEVDQyBmb3IgY2hlY2sgYmFkDQo+ID4gPiA+ID4gPiAgICAgYmxvY2sNCj4gPiA+
ID4gPiA+ICAgZHJpdmVyczogbXRkOiBuYW5kOiBzcGw6IEFkZCBzdXBwb3J0IGZvciBuYW5kIFNQ
TCBsb2FkIGltYWdlDQo+ID4gPiA+ID4gPiAgIGRyaXZlcnM6IG10ZDogbmFuZDogRW5hYmxlZCBL
Y29uZmlnIGFuZCBNYWtlZmlsZSBmb3IgQ2FkZW5jZS1TUEwNCj4gPiA+ID4gPiA+ICAgZHJpdmVy
czogbXRkOiBuYW5kOiBLY29uZmlnOiBSZW1vdmUgU1lTX05BTkRfQkxPQ0tfU0laRQ0KPiA+IGRl
cGVuZGVuY3kNCj4gPiA+ID4gPiA+ICAgZHJpdmVyczogbXRkOiBuYW5kOiBLY29uZmlnOiBFbmFi
bGVkIHNlbGYtaW5pdCBmb3IgY2Rucy1uYW5kDQo+ID4gPiA+ID4gPiBTUEwNCj4gPiA+ID4gPiA+
DQo+ID4gPiA+ID4gPiAgYXJjaC9hcm0vZHRzL3NvY2ZwZ2FfYWdpbGV4NS5kdHNpICAgICAgICAg
ICAgIHwgICAxNCArDQo+ID4gPiA+ID4gPiAgLi4uL2FybS9kdHMvc29jZnBnYV9hZ2lsZXg1X3Nv
Y2RrLXUtYm9vdC5kdHNpIHwgICAyOCArDQo+ID4gPiA+ID4gPiAgYXJjaC9hcm0vaW5jbHVkZS9h
c20vaW8uaCAgICAgICAgICAgICAgICAgICAgIHwgICAyNSArDQo+ID4gPiA+ID4gPiAgYm9hcmQv
aW50ZWwvYWdpbGV4NS1zb2Nkay9NQUlOVEFJTkVSUyAgICAgICAgIHwgICAgMiArDQo+ID4gPiA+
ID4gPiAgY29uZmlncy9zb2NmcGdhX2FnaWxleDVfbmFuZDJfZGVmY29uZmlnICAgICAgIHwgICAz
MyArDQo+ID4gPiA+ID4gPiAgLi4uL210ZC9jYWRlbmNlLG5hbmQueWFtbCAgICAgICAgICAgICAg
ICAgICAgIHwgICA5OCArDQo+ID4gPiA+ID4gPiAgZHJpdmVycy9tdGQvbmFuZC9yYXcvS2NvbmZp
ZyAgICAgICAgICAgICAgICAgIHwgICAxOSArLQ0KPiA+ID4gPiA+ID4gIGRyaXZlcnMvbXRkL25h
bmQvcmF3L01ha2VmaWxlICAgICAgICAgICAgICAgICB8ICAgIDIgKw0KPiA+ID4gPiA+ID4gIGRy
aXZlcnMvbXRkL25hbmQvcmF3L2NhZGVuY2VfbmFuZC5jICAgICAgICAgICB8IDI0MjQNCj4gPiAr
KysrKysrKysrKysrKysrKw0KPiA+ID4gPiA+ID4gIGRyaXZlcnMvbXRkL25hbmQvcmF3L2NhZGVu
Y2Vfc3BsLmMgICAgICAgICAgICB8ICAgNTkgKw0KPiA+ID4gPiA+ID4gIGRyaXZlcnMvbXRkL25h
bmQvcmF3L25hbmRfYmFzZS5jICAgICAgICAgICAgICB8ICAgNzEgKy0NCj4gPiA+ID4gPiA+ICBp
bmNsdWRlL2NhZGVuY2UtbmFuZC5oICAgICAgICAgICAgICAgICAgICAgICAgfCAgNTI5ICsrKysN
Cj4gPiA+ID4gPiA+ICBpbmNsdWRlL2xpbnV4L210ZC9yYXduYW5kLmggICAgICAgICAgICAgICAg
ICAgfCAgIDE0ICsNCj4gPiA+ID4gPiA+ICAxMyBmaWxlcyBjaGFuZ2VkLCAzMjkzIGluc2VydGlv
bnMoKyksIDI1IGRlbGV0aW9ucygtKSAgY3JlYXRlDQo+ID4gPiA+ID4gPiBtb2RlDQo+ID4gPiA+
ID4gPiAxMDA2NDQgY29uZmlncy9zb2NmcGdhX2FnaWxleDVfbmFuZDJfZGVmY29uZmlnDQo+ID4g
PiA+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gPiA+ID4gPiBkb2MvZGV2aWNlLXRyZWUt
YmluZGluZ3MvbXRkL2NhZGVuY2UsbmFuZC55YW1sDQo+ID4gPiA+ID4gPiAgY3JlYXRlIG1vZGUg
MTAwNjQ0IGRyaXZlcnMvbXRkL25hbmQvcmF3L2NhZGVuY2VfbmFuZC5jDQo+ID4gPiA+ID4gPiAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbXRkL25hbmQvcmF3L2NhZGVuY2Vfc3BsLmMNCj4g
PiA+ID4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9jYWRlbmNlLW5hbmQuaA0KPiA+
ID4gPiA+ID4NCj4gPiA+ID4gPiA+IC0tDQo+ID4gPiA+ID4gPiAyLjE5LjANCj4gPiA+ID4gPiA+
DQo+ID4gPiA+ID4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IC0tDQo+ID4gPiA+ID4gTWljaGFlbCBO
YXp6YXJlbm8gVHJpbWFyY2hpDQo+ID4gPiA+ID4gQ28tRm91bmRlciAmIENoaWVmIEV4ZWN1dGl2
ZSBPZmZpY2VyIE0uICszOSAzNDcgOTEzIDIxNzANCj4gPiA+ID4gPiBtaWNoYWVsQGFtYXJ1bGFz
b2x1dGlvbnMuY29tDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gPiA+
ID4gPg0KPiA+ID4gPiA+IEFtYXJ1bGEgU29sdXRpb25zIEJWDQo+ID4gPiA+ID4gSm9vcCBHZWVz
aW5rd2VnIDEyNSwgMTExNCBBQiwgQW1zdGVyZGFtLCBOTCBULiArMzEgKDApODUgMTExDQo+ID4g
PiA+ID4gOTE3MiBpbmZvQGFtYXJ1bGFzb2x1dGlvbnMuY29tIHd3dy5hbWFydWxhc29sdXRpb25z
LmNvbQ0KPiA+DQo+ID4NCj4gPg0KPiA+IC0tDQo+ID4gTWljaGFlbCBOYXp6YXJlbm8gVHJpbWFy
Y2hpDQo+ID4gQ28tRm91bmRlciAmIENoaWVmIEV4ZWN1dGl2ZSBPZmZpY2VyDQo+ID4gTS4gKzM5
IDM0NyA5MTMgMjE3MA0KPiA+IG1pY2hhZWxAYW1hcnVsYXNvbHV0aW9ucy5jb20NCj4gPiBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+ID4NCj4gPiBBbWFydWxhIFNvbHV0aW9u
cyBCVg0KPiA+IEpvb3AgR2Vlc2lua3dlZyAxMjUsIDExMTQgQUIsIEFtc3RlcmRhbSwgTkwgVC4g
KzMxICgwKTg1IDExMSA5MTcyDQo+ID4gaW5mb0BhbWFydWxhc29sdXRpb25zLmNvbSB3d3cuYW1h
cnVsYXNvbHV0aW9ucy5jb20NCg==
