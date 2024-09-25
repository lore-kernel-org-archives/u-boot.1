Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6DC0CF9C71
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 05:41:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81AFD88A43;
	Wed, 25 Sep 2024 07:41:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Lig9XkTt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD4C788AA7; Wed, 25 Sep 2024 07:41:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDAA58897F
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 07:40:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1727242835; x=1758778835;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=2qpDMkJvy/Q0bC9rJZJuAtjD9va67et6PMY49kv8c+4=;
 b=Lig9XkTtmYNJpLQoDBg9sfIE+J+98CWW5LiIc2KMjChXZxUBqwExlXK5
 JYpUMJcl22J84Ewp/FupHFbY4Xaz//HLTKRU52S0MXwJefU9Br9IXReGe
 jMTg+zEKrWxAbvkQ1Bb6xGyuuea3i0OHQd9kHGeGhYfXwcBAWd3FQSoph
 wCbX4DfGVavohWvtdAn13YPak/XUPkfAJZERnvXRYfmi+V8iS7EUZIi4g
 Y8l7HdYBTz/xYKQwdaxY1PAO+7CM6/wb794+9Ik/Wt8pG9AuedNEe6LCW
 FbXav5VE9exEJkvWNPFxKzA5uodQVi/XA0YxclHOPfBeaOgKuovibh+8P g==;
X-CSE-ConnectionGUID: B0SpKoI1Rwy71TXM7V3mSg==
X-CSE-MsgGUID: siYRGCZfS/mDeaMvg9JsQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="26456997"
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; d="scan'208";a="26456997"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2024 22:40:25 -0700
X-CSE-ConnectionGUID: L2RIbZA4TAyYL9M78XUrhg==
X-CSE-MsgGUID: DXaMlChTQs+L8klp0CU2VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; d="scan'208";a="76452113"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 24 Sep 2024 22:40:22 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 22:40:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 22:40:18 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Sep 2024 22:40:18 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Sep 2024 22:40:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m7AzqBhLK+b1NlBdSpg/mI2j3Cal3eMxuMbT6ZklMpJBsZnP/07CTSE/VK7w1FQnyzH+SohpxIALLWr9QK78cPDLpP9sSgLImGJNG6pvgZmGeJthm9UChkXEqJ9jsKf076P23Hw8iEPsbV+eL6LWB3XhZ5Gkv8O01l9/WZZJAdMcTsfSNJ7fG6V/vkh8lZUea+aR0ira84cDBoIoDbbqLKYqMFjd6Ag+8tzC98L0WlQnKUJWocOgaY0UpjK0BTOV1KGpywDRnNz6F7Rimjj7qMqCHm0jJLrmlr7pFmgcssrXLEH8gFlSWvBRJqpCljMGYzVCeIEYl4c8I/gq0cnchw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qpDMkJvy/Q0bC9rJZJuAtjD9va67et6PMY49kv8c+4=;
 b=YQqRAw5qcZVUdl+27YUkE++Olk0CI66zyD3clcXUWkwrt4bZ8AV26QT3pD45LQ9a0/BwnBfMyuZMHfGwAfHzPMkxCg3b2lEV11tMmGSI/qWboiDpb/O/faZFRr0js4eWztTQldyKAv6MzQBT2klsHotNDZZPtcpjpgUFsLkNeSo7ML70VKDlcVkCrDzJEkGC9SUwJFzAPxDdCuAxULIjOeWB4CiS+2JihBwdKZn1BuGGk5U2KeFHkTa878v6b6coBeKL16rF15KQPYc4w+Z/Dh9R/P5nMIUH/I37H/gmPkYbAwSwrHloiDBtxbc6HeNPpAj4EhgQbs67yrZysJbt0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 SA3PR11MB7415.namprd11.prod.outlook.com (2603:10b6:806:318::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Wed, 25 Sep
 2024 05:40:15 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe%5]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 05:40:15 +0000
From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, "Meng, Tingting"
 <tingting.meng@intel.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@intel.com>, "Hea, Kok Kiang" <kok.kiang.hea@intel.com>
Subject: RE: [PATCH v1 04/20] arm: socfpga: agilex5: Add low level
 initialization
Thread-Topic: [PATCH v1 04/20] arm: socfpga: agilex5: Add low level
 initialization
Thread-Index: AQHbCysxcBsr3IIvwUKhOtjjWPaLTLJiQ8QAgAQDArCAAQMWAIAAt5tA
Date: Wed, 25 Sep 2024 05:40:15 +0000
Message-ID: <DM8PR11MB559230887920D1150E8F9591D2692@DM8PR11MB5592.namprd11.prod.outlook.com>
References: <20240920070242.20884-1-tien.fong.chee@intel.com>
 <20240920070242.20884-5-tien.fong.chee@intel.com>
 <9cc437c8-59dc-4e78-82d4-8ef479ca9ba1@denx.de>
 <DM8PR11MB55924FDB9E2C081EE97216CCD2682@DM8PR11MB5592.namprd11.prod.outlook.com>
 <19445387-1b9a-45e9-84f2-c6de0487ce34@denx.de>
In-Reply-To: <19445387-1b9a-45e9-84f2-c6de0487ce34@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|SA3PR11MB7415:EE_
x-ms-office365-filtering-correlation-id: c36fefc7-7483-406f-1e80-08dcdd248888
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?M1RrWjRUNkorek5JVUI2cVNIdzJ4Y2ZBTStGaFJ1dkNGU2N1QUNhSURPYTJX?=
 =?utf-8?B?SkdHMnpTbTE2ZUFub0VOM0JKT3NGbUt4WkJzcS8xMk44ZGtkT2Nlc1ZKUklL?=
 =?utf-8?B?NEZyYkpvYWEwM09lOVd3VGsvcVMvVTNUYzluNm5tVjNGZERCemtJV0Q5ZlBl?=
 =?utf-8?B?VnFCazc4cGtCTE82OVN2TmpkWTFDT0pzVzhZN0YvRjZSOGQ4ZGpGK2dhVTc2?=
 =?utf-8?B?WWdPVStydDh3U2dMeWtXbU44UGIwZm4zUlI1MmlMOVF0b3NhVEFVYUd1dGhC?=
 =?utf-8?B?UGNFd2UxdFgvQVAxNUFRR0ZXd055Y09DZWx2Z01NR1pHNDAyUUZSbkV4Wkkr?=
 =?utf-8?B?MU5KODFXSDhKOFdGVXJUcCtjbmNScExoZm9HV1lnaVgrYU14VWlnd0p2R0Mx?=
 =?utf-8?B?L3hVeGlmd1loQk1WVWxsVEVIU1hIZ0w4MGZnb0RwcEtyMkNXTmxpZEEzc2Nw?=
 =?utf-8?B?cXZReFYzZ0FJTkRGL2p6S3VUSDdIZTZ1QTFCUDhVTFkwdFRNWmo1cmhsdGRV?=
 =?utf-8?B?LytQYytEbTJaenN5WDNJbURPYjBXMTJZaG1maFhtSktERnJ6Mzh3ZzZhM21G?=
 =?utf-8?B?eFlrZkllNnBESzRnMnJkdVFzUXdjcHhKUjdRMzhIVW5LWVM5bzdFS09DL1FP?=
 =?utf-8?B?WnNBYVl6cFJ0Q1JnR1NqVW9SRHBuZHJKVjV1M084WG8raWNMcDlsQUZRUmlq?=
 =?utf-8?B?WVpBc09OMTN4N3Q0dUk5U1hQbFM4aWI4cnBUaEhiV2VoM1dZNHV6R2l2blYz?=
 =?utf-8?B?ZVl5NUdWbHIwTWk3ajlmQlJDREVLUmMzOC9JRWlHZDdCY2srZHJ3WjE4SktP?=
 =?utf-8?B?MnpqNndFZG53aUtYSkozbWVPbXUvcCs0bEtyRnQ5SVZmTExpWnBYVE5iK3VB?=
 =?utf-8?B?UWRMUEJ2ZVVWS25NZzlmcW9XYjhDMWJYWXhEd3g2WGJyVGlHSDdmaXhVeXMv?=
 =?utf-8?B?QWF1Vm1zTmZxYTFJMnlERlU2VTJPWHBRWnB0V3FlUkZXb29DaFB2b2hlQ1FP?=
 =?utf-8?B?Q0VkVnltSlRpK0tsTUtueElheEpubjl0MFZHOG1ReG02UGRFOGZaZ3RLdzls?=
 =?utf-8?B?d1FJWFBnUjJQWVBaY3VRZmdhNHc4S3g2MG5pVFMxclNmZmlmZjgvTVhhdGdJ?=
 =?utf-8?B?VXlxcTZVS3pRVzFGQWN1ZmltR2ptMktaWXhIeUlub243b1QvTkI1bTc1ZmxI?=
 =?utf-8?B?WjBzbDByT2YxYTJEdmZqMndmSWVxMndVSlpDMURBazJXUDJxMnR3Z3M3blo1?=
 =?utf-8?B?ZE9YL05KOUZNUmQ0K1Jvd1ZjRDRYV1FUVTY2Y200bnlnVDlraU83YlpET2tw?=
 =?utf-8?B?NUpEcnNvMmVHQUlsM2Y2eXBiWExUWjJyKzlsR0dmNW5VZyswUlhJOXZhSUdk?=
 =?utf-8?B?Ny9CcXFYamtndTAwRDhrZmRvSi9mTlR5bU9ESWgzYzY2Wkp2aisyMXU2b0Nj?=
 =?utf-8?B?NTh2dllkM2NGWTRHWXZYK0I0WG9XR0I2eGxZR2czUXcwWmFaOUlCRkRhVWZw?=
 =?utf-8?B?ODJ0Q09tWnQ0RExQOEJiWitmaWF4OG5zK01oQXg5NVR1dWRaR3A3V3ExYXMz?=
 =?utf-8?B?cWlTZmJkSFl3Z2dKR1pyUkZFZHpQZUppQkRYQ0J3bE90SVp3bVUwRnFtVkFi?=
 =?utf-8?B?NmtlOEl4MmNYL1pVRktPVWh6akVyeUdISmt0S0wzUmczN1hqeTE0Uk5uZTJi?=
 =?utf-8?B?d0VKVUJHUGt6akQwWU1FZGlYdTY4eEVna29kRmE5dUJjTjJWRUREa0kvM2sy?=
 =?utf-8?B?VVJlZVVMeHlNSGQzcGpncGZDMzNkTXZvVE9CMXd6MEcveFZxTVNjL1JhRndF?=
 =?utf-8?B?TDhUbm13U3pnanZERW43SWRPS0ZGNmY4NTdza1V3YXJKb0RVNHFTVkFmeUZy?=
 =?utf-8?B?aTdiWE8vNHJodXNnQVN3Vi8yU3NEWnlCKzY5SWJhdHlEQlE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5592.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXNFRVZab3hUZzlEcmFDc3cveFljeU55bnI1T3ptYmc0c0xZTDJFZFJqK1c3?=
 =?utf-8?B?NFhHT3pocEg0Z2UrRG5FcFpabDJFSVRyaDV2SGY3ZUhYL29IRkFSL1JMdGRn?=
 =?utf-8?B?ekVqVExzaEV0R09zZ29WZ2FSQm8rWDdmVTFPOEFzeWUrZm5GSHcxV2RiWjJ5?=
 =?utf-8?B?MGFhTFFmb1ZFdE5RdEtDRW5EQ3hpN2Y0QnhNYmhZdnIwNm05NG9XWDBteHg1?=
 =?utf-8?B?YXlsRkFjWklIRXZ3NFlJK2hySkxjK0c2Z3EzSm84VmxhVTVISCtLcld3NUZZ?=
 =?utf-8?B?Z2dyeDZsdEx2enZwcHdvamo0dUhxbE13aytZS3doZUUyd1NLeUZBWFpQd0py?=
 =?utf-8?B?QmpvTzc1b1o0KzZDcXdjdks2UldtWlFhY1VZRWNFUjZUeVM3ZnBmeGFZeldJ?=
 =?utf-8?B?eC92N3pqd3g3NmtBKzlLbFVlRlM1Y2d2MUpSd1ZCWTc4OU1LSHhEb1NUN3JB?=
 =?utf-8?B?YWkzb2tBMmpkNXFMR2VMdncydlRNc2tLOTFGdGpTZ2VTMko0MEpueHNnblR5?=
 =?utf-8?B?Q2p3cHRHSUdJTHBFM1dmUjJGVjNsTGt3QUxjTVh5REZKNmZDSnU1TUxyYWdV?=
 =?utf-8?B?WEYxOUpkQk53cEpUMGl1RVJ1WTYvT1BnQWd1bUc4TXZJUTR0UG5nSEZXODln?=
 =?utf-8?B?cXNCNTB5QXVhSFExbmxaTUcvTWVXeWtxY2dzY3dmalNMdW45VjhuVEQyOGJw?=
 =?utf-8?B?ZEFDVzhGZG82dmRxSStzbVZqdGpqcm5ZUG5Fb1hhZzFUVWdMM1Joc0VHSnVN?=
 =?utf-8?B?aU1YaXlEQ3hiMFdvSHF0Mi9kdDhkRlVsQk5EQzVqZHpVRGVEbkN0dUNQSTQ4?=
 =?utf-8?B?YTBVR2I3aEpyZkdrencrMkJERmp1M0UzeUVlSlFOaUswVWJvcjE1bElCcUlO?=
 =?utf-8?B?KzB0VW1QQWh3WDNHdFQwcWllUlA2V3FoR3FTTUJ5a0hkb1Bsem5OYW91ZHg1?=
 =?utf-8?B?VysvR3h0NjlxTi9yYWdPbUNvdnYwMWIrcmFZYy9qRkpLdGZXWFlHN3RiL3lm?=
 =?utf-8?B?K3RMclVabWZ2aXVRZndlWE8zZ2JYV29RNlhQQ2dnM3QwUmRRcUcxNDA0YlU0?=
 =?utf-8?B?SjA3TU1qdTRQRXFrSDZjTVNJYkFyN0xPYUd1NGRPQmlKQWYrU3JhMU96eWx5?=
 =?utf-8?B?Vm5VNW1jYVB4VHBNMUtKd2txRnFWbUJlY3VoQjNMdXlSV0JSTldhU1NONG1F?=
 =?utf-8?B?NnVzc1RaUU5oSlNZTGVzRkc0NUNyTEFPZExUVnB2VjY5bzBNYlhBMGpFOE1z?=
 =?utf-8?B?TnBCdGw2aGdzUW9IbXhySjVGbUVGbnVMQVhSMTBtQWJXM2pUTExHbGowWG1o?=
 =?utf-8?B?SkErNVhQMnQzM3BpalJnbmhRSzdyS0tJN0ltTVdjWEZIVVZrMnUzdEkvWGxC?=
 =?utf-8?B?ZzlyYkNEaGxDeHg3cVhBMUVEOGxWandJQmQ2MnpESlcyNXdtV3dYSDRoSU12?=
 =?utf-8?B?T29oSU1oZzVkaDNFd0daK1JDQWF4cUY0dGFtejJtN3JlM3A3L0tFK1FRVFp1?=
 =?utf-8?B?cnU0TnIycDJVZGs0cm16aUxacEJVTGJFeU4zYjNqNklFMU1WVlROTFFEVVEz?=
 =?utf-8?B?MWNTNDViKzlWbW9jcm9YU0dPOUQ2RkdkMzFTVXp3bElKaXBsMytqQXdlb3Jo?=
 =?utf-8?B?Y3Zadm5mMTJaUGh5RHBIcjhLN0J5U1Bocy90QVRHRnhaTEdHby9jYUVnb3NU?=
 =?utf-8?B?OFgxeTNsdVQ3QllDRXhvYzFrZmlMNGRwZzAwNVpSejZUUm5PZDQ2WkpiWjJ2?=
 =?utf-8?B?RG9tb01YUnpmd0svdDdHLzVnT3B1M1ZETHV2UHlhWjNreXJiSkU4QmVidTNI?=
 =?utf-8?B?UzhaODh0Mk9Za1poeVg5VUEwdmVreEI2M1pSTWRCeGR3N1JrdFZCYXVIQnlr?=
 =?utf-8?B?ckhtY2lrZGFjaEtIZlhoR0hKMitqWi9qV2I3WWFNRUVFVXdZUjVXdzduMUF5?=
 =?utf-8?B?SUE4TnZaelBpRjNsd205Mkt1WkRZYnpBLzhJc3Vwa3FIQUpOYjZucWpyUWFX?=
 =?utf-8?B?MVpSTFJ0Y3hwRnVoRU1NU01JR0prTFNwVThxUE0vYUxnam5ZRS9vVVUxbitI?=
 =?utf-8?B?bnQvN0NhWm5MUTJMamlPeWQ5VkxydE9FbEtpamYxd0NPS0NHSmxaN08weXV2?=
 =?utf-8?Q?Ii+ped6JP92X7ik8j1A1Nn565?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c36fefc7-7483-406f-1e80-08dcdd248888
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 05:40:15.8742 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ERRVQ3DDTfQfKqfXScD1EaX2EnZhhacWugsjDqoMO4zm1KJxZfHKI0qsNXR4kaLjm8F5HFyIiG8iS1MWvyQpxKJYmR6ZrUHqNybme20ImxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7415
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

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyZWsgVmFzdXQg
PG1hcmV4QGRlbnguZGU+DQo+IFNlbnQ6IFdlZG5lc2RheSwgU2VwdGVtYmVyIDI1LCAyMDI0IDI6
MzIgQU0NCj4gVG86IENoZWUsIFRpZW4gRm9uZyA8dGllbi5mb25nLmNoZWVAaW50ZWwuY29tPjsg
dS1ib290QGxpc3RzLmRlbnguZGUNCj4gQ2M6IFNpbW9uIEdvbGRzY2htaWR0IDxzaW1vbi5rLnIu
Z29sZHNjaG1pZHRAZ21haWwuY29tPjsgTWVuZywgVGluZ3RpbmcNCj4gPHRpbmd0aW5nLm1lbmdA
aW50ZWwuY29tPjsgWXVzbGFpbWksIEFsaWYgWmFrdWFuDQo+IDxhbGlmLnpha3Vhbi55dXNsYWlt
aUBpbnRlbC5jb20+OyBIZWEsIEtvayBLaWFuZw0KPiA8a29rLmtpYW5nLmhlYUBpbnRlbC5jb20+
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDQvMjBdIGFybTogc29jZnBnYTogYWdpbGV4NTog
QWRkIGxvdyBsZXZlbA0KPiBpbml0aWFsaXphdGlvbg0KPiANCj4gT24gOS8yNC8yNCA1OjE0IEFN
LCBDaGVlLCBUaWVuIEZvbmcgd3JvdGU6DQo+IA0KPiBIaSwNCj4gDQo+ID4+PiBkaWZmIC0tZ2l0
IGEvYXJjaC9hcm0vbWFjaC1zb2NmcGdhL01ha2VmaWxlDQo+ID4+PiBiL2FyY2gvYXJtL21hY2gt
c29jZnBnYS9NYWtlZmlsZSBpbmRleCA2N2M2YThkZmVjNS4uNTNjOTFkMWQyYTUNCj4gPj4gMTAw
NjQ0DQo+ID4+PiAtLS0gYS9hcmNoL2FybS9tYWNoLXNvY2ZwZ2EvTWFrZWZpbGUNCj4gPj4+ICsr
KyBiL2FyY2gvYXJtL21hY2gtc29jZnBnYS9NYWtlZmlsZQ0KPiA+Pj4gQEAgLTU4LDYgKzU4LDcg
QEAgZW5kaWYNCj4gPj4+DQo+ID4+PiAgICBpZmRlZiBDT05GSUdfVEFSR0VUX1NPQ0ZQR0FfQUdJ
TEVYNQ0KPiA+Pj4gICAgb2JqLXkJKz0gY2xvY2tfbWFuYWdlcl9hZ2lsZXg1Lm8NCj4gPj4+ICtv
YmoteQkrPSBsb3dsZXZlbF9pbml0X2FnaWxleDUubw0KPiA+Pj4gICAgb2JqLXkJKz0gbWFpbGJv
eF9zMTAubw0KPiA+Pj4gICAgb2JqLXkJKz0gbWlzY19zb2M2NC5vDQo+ID4+PiAgICBvYmoteQkr
PSBtbXUtYXJtNjRfczEwLm8NCj4gPj4gQ2FuIHRoaXMgYmUgd2lyZWQgaW50byBleGlzdGluZyBl
YXJseSBob29rIGZ1bmN0aW9uLCBsaWtlIHNfaW5pdCBvciBzbyA/DQo+ID4NCj4gPiBJIGNhbm5v
dCBmaW5kIHRoZSBjYWxsZXIgZm9yIHNfaW5pdCwgd29uZGVyIHdoZXJlIGlzIHRoZSBzX2luaXQg
aXMgY2FsbGVkPw0KPiANCj4gYXJjaC9hcm0vY3B1L2FybXY3L2xvd2xldmVsX2luaXQuUzoucHVz
aHNlY3Rpb24gLnRleHQuc19pbml0LCAiYXgiDQo+IGFyY2gvYXJtL2NwdS9hcm12Ny9sb3dsZXZl
bF9pbml0LlM6V0VBSyhzX2luaXQpDQo+IGFyY2gvYXJtL2NwdS9hcm12Ny9sb3dsZXZlbF9pbml0
LlM6RU5EUFJPQyhzX2luaXQpDQo+IGFyY2gvYXJtL2NwdS9hcm12Ny9sb3dsZXZlbF9pbml0LlM6
ICAgICBibCAgICAgIHNfaW5pdA0KPiANCj4gTWF5YmUgc3VjaCBhIGRlZmF1bHQgbG93bGV2ZWxf
aW5pdCBmb3IgYXJtdjggY291bGQgYWxzbyBoYXZlIGFuIHNfaW5pdCA/DQo+IA0KPiA+IFdoYXQn
cyBjb25jZXJuIHdpdGggbG93bGV2ZWxfaW5pdCgpPyBJdCdzIGFsc28gd2lyZWQgaW50byBleGlz
dGluZw0KPiA+IGVhcmx5IGhvb2sgZnVuY3Rpb24gd2hpY2gncyBsb2NhdGVkIGluc2lkZSBzdGFy
dC5TDQo+IEkgd291bGQgbGlrZSB0byBhdm9pZCBkdXBsaWNhdGluZyBsb3dsZXZlbF9pbml0IGZ1
bmN0aW9uYWxpdHkgYXMgbXVjaCBhcw0KPiBwb3NzaWJsZSAsIGNvbW1vbiBsb3dsZXZlbF9pbml0
IHdvdWxkIGJlIHZlcnkgd2VsY29tZSAuDQoNClN1cmUsIEkgY2FuIGFkZCB0aGUgc19pbml0IHRv
IGNvbW1vbiBsb3dsZXZlbF9pbml0IGFuZCBtb3ZpbmcgdGhlIGNvZGVzIHRvIHNfaW5pdC4NCg0K
VGhhbmtzLg0KDQpSZWdhcmRzLA0KVGllbiBGb25nDQo=
