Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049D1CEBF76
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 04:53:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74AA5889DA;
	Fri, 27 Sep 2024 06:53:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="VbYblhmD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A935988966; Fri, 27 Sep 2024 06:53:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A60B889DA
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 06:53:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1727412801; x=1758948801;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=RQX5rQXGyJ5pWkJCDA01PVt+PR+As+NwCTCt+4zjtfE=;
 b=VbYblhmDZlS7du+RdOtUodaovs7PGa7dG/O7GHeH+f1ENtYSEVOlNWdv
 DXxNNXTAmOSCpfEcTUbu47n85d0VkJSLVMqEbZBb7MdQdABoYqZZKtEo1
 XuI7PXISVVW67BGnkuSOh0nzyKvPjtTmLULkKeEtjbiZuy00m7voaZD/J
 YdQL9Lt2iWR/tydbq0Dd/kc/DOuw3SboqLCq5sw1X32gl1CKDhthaZSHk
 tu3v4FFqtbO1eAKu9yAurTATRDShB4mKgAhQ+G36uw3TI+8AErTvRrSU/
 JgMmTiv1lwuQAJMy5YXm15fR7DPbwzFbAFlCxXbxhTt2qtI+e9p9o8eXe A==;
X-CSE-ConnectionGUID: lVV3t/fySlCtwSe9Bjn7lw==
X-CSE-MsgGUID: qIj0OpxdTCmZN8Hj4kWl1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="26678427"
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; d="scan'208";a="26678427"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2024 21:53:19 -0700
X-CSE-ConnectionGUID: nvUXqIM1T3SJER2BP305DQ==
X-CSE-MsgGUID: dbMpih6rRqudLn1nZONvzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; d="scan'208";a="72395114"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 26 Sep 2024 21:53:18 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 21:53:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 21:53:17 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 26 Sep 2024 21:53:17 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 26 Sep 2024 21:53:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TGdi8tcPC0ZCvJ45M2hc7QCIUAJNMTjUjNtqU1T7dWMWUKtXBE5RdByO51Q/5YzFo/ElUpeBLde2sSO8W0Nelrb2APyloY7LoOoJRxQT7F/28csVwrDe+0bvLV2lU17ub7bDSmMhy9ffKSFykObRlsZmZAxnhjF5ZYtCQeOHeUs6Zngu9LqfBtxY/u16nMSkN+sUlMouJL/wRBo020536yWErwwZj6gMnIXUJ0JlDJAu/klGonk+rqt/7kH74kl3A6FaHM7Dyk1dpKRRTX4iE7v52BYc5jAU5rq3lE/g/1/64gWF9bnY1CmyeiGrL3AS5KiEaEAOmrfEv5HfM2PE6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQX5rQXGyJ5pWkJCDA01PVt+PR+As+NwCTCt+4zjtfE=;
 b=OGdJIuFbdB5gkYKW3y678qHAifUbtyAByiliIMWX1OF8I1yLtJxlfeD8j55HN47a9tz+Q+DsPn2i9xDd5BdCBbQ2FE9fCjLelULmJuurq3paIUSOAC2XUbUKfHemY55mwXlbQjGYmyNqw0KAXknZVTDIiig8ztWKSRXub6PrE7qiR317rDGesqXe4ZdU1A9HgbaCu6aHG7EQT3HYmBSnUESU/uVBmqcC0K+npO3i75sBBHz3cmS0T1BUcxiPMNBNwZgHLZwujGC5k5V0QROrBKMlG/96hfHsgBDJpRR03TY4vfTN81R8rzFyRcHrMLPuc6V7boZ+KG2B0wf+GLa2+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 MN6PR11MB8148.namprd11.prod.outlook.com (2603:10b6:208:472::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21; Fri, 27 Sep
 2024 04:53:14 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe%5]) with mapi id 15.20.8005.021; Fri, 27 Sep 2024
 04:53:14 +0000
From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, "Meng, Tingting"
 <tingting.meng@intel.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@intel.com>, "Hea, Kok Kiang" <kok.kiang.hea@intel.com>
Subject: RE: [PATCH v1 04/20] arm: socfpga: agilex5: Add low level
 initialization
Thread-Topic: [PATCH v1 04/20] arm: socfpga: agilex5: Add low level
 initialization
Thread-Index: AQHbCysxcBsr3IIvwUKhOtjjWPaLTLJiQ8QAgAQDArCAAQMWAIAAt5tAgAB7MwCAARslgIABGzCAgABoUIA=
Date: Fri, 27 Sep 2024 04:53:14 +0000
Message-ID: <DM8PR11MB55928A4EF236219CE4D02D6CD26B2@DM8PR11MB5592.namprd11.prod.outlook.com>
References: <20240920070242.20884-1-tien.fong.chee@intel.com>
 <20240920070242.20884-5-tien.fong.chee@intel.com>
 <9cc437c8-59dc-4e78-82d4-8ef479ca9ba1@denx.de>
 <DM8PR11MB55924FDB9E2C081EE97216CCD2682@DM8PR11MB5592.namprd11.prod.outlook.com>
 <19445387-1b9a-45e9-84f2-c6de0487ce34@denx.de>
 <DM8PR11MB559230887920D1150E8F9591D2692@DM8PR11MB5592.namprd11.prod.outlook.com>
 <3aa8bf84-ea2e-4485-8a2d-e1af9d483c98@denx.de>
 <CO6PR11MB55854FEA82DE5B61948975F2D26A2@CO6PR11MB5585.namprd11.prod.outlook.com>
 <e0f1877a-c3e4-49dd-aa42-b92c2262f6df@denx.de>
In-Reply-To: <e0f1877a-c3e4-49dd-aa42-b92c2262f6df@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|MN6PR11MB8148:EE_
x-ms-office365-filtering-correlation-id: 5728c1b5-8ee8-4a0b-50be-08dcdeb04b9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VkxudURib05NQWJFRGN2bFN5VitOanp5VzI0R2J3UmFOWmhRWFVBak1zVWVn?=
 =?utf-8?B?eXF5cE5DczkvSWhMeWxsdW1aQTdoMm5ieVMvSVlFLy9jbzl0YWRSc0tXbmdV?=
 =?utf-8?B?WlNYTWFRdUVmN2NobFZsazJvMkRUNCtWQ0FCcXRsT1FMaW1NbEd6RnZpdE5j?=
 =?utf-8?B?ME80THB0N2FSVERVNnVnblh1cXVpZEEveUhTdlBOdXVTWWwvSWtsTmk1VXRo?=
 =?utf-8?B?K2lSdE5JOTh1aWdpOUR2SHcvd2VtOEJKdEhlSWlUOHBDRUd0Y3Z5b1IvMVM3?=
 =?utf-8?B?UjF5a1VXcTh3cHQrcUxtdkU5Z3ZDb2JHK1I5ajNiYTFFQmNNNGsvN1NaWk1F?=
 =?utf-8?B?cFhxR1ZjV1B4c0pUNHNrVEJWeE1pTzBXT1I4MlVRd0VqcTRwNG5JcDlKNUpv?=
 =?utf-8?B?OEE5NHAvVjA2eU9Fa3lIMUo3TUUyQjA5NzAvMzdsZEpKdkhiQUZ6cEsrS2pH?=
 =?utf-8?B?ams3ckJKYWJyOS9DWXMyUnJ5ZlpQand3WUI5V21ZRTY0eFZCWnFsbmwwYW4r?=
 =?utf-8?B?cGdycXhlNXhrVnc1bmxYd0s5cXpOajRXTGpFSjNRbzRDWjB5MGhYY2xqV2xT?=
 =?utf-8?B?WjYweHZoQmhENG13Vm5mbnFlam5KRzk0TlVNUUdWYXVoK2o1Ky9GSVhsSWpp?=
 =?utf-8?B?aGFhTUo5MTdsMUtXVTFJdXU0dHJOdVJKY1VYYjB6OFR5Yng4cGVRL2t5YW42?=
 =?utf-8?B?eGVzZGpLUnBEMmVVYkNzYVNDWDNUbm84OTBGeEpTTDQxSllUQTE2a1FEWTlz?=
 =?utf-8?B?VjNpNGsyQnp0NFZBS0dYUzhIUnF2UlMvd1FWM3VtRFZiaTNGMk81Q2Vma0Z4?=
 =?utf-8?B?UVRERHpRWk4rWFdoYlpNbkxSV2k5RktXeGVUSGg3dVpRNzllalk5cUM2UVNG?=
 =?utf-8?B?dWhjTVNybmV4Q3RDa0xmRTMybElRZjY1TFBVUEVYTmJQcm1hdDRnY1hjcGhX?=
 =?utf-8?B?bFJNNWM3V3V0WVVWQjA3TFdJQ0RPMzlTTW5maXVXRlJyTHlwQmhxSEFlcXk2?=
 =?utf-8?B?cDZZQ2ErSGdoS2R6VmtJODZuS0pBQXdGSkhzMlhrVEhrZmJ4NFM3Zm11cHI4?=
 =?utf-8?B?WDh3b1U4STdRRzZlRVdqVjJ1R2VvNHZUOU1lQXlaTE9HWk43djltMUpuZkhJ?=
 =?utf-8?B?QXBYRVE2RVJ3aXdsSzNoaXBZdnViS3kwc2FoRU5qZno4M2dCM1pLbkFWclpJ?=
 =?utf-8?B?Tno5cUpITnAyc0JkVkVyYzhuR09kUTV1Um5mMkxvZEwzMWEzSWRkVVdwSXRj?=
 =?utf-8?B?dEFIa1JmMWlUejhRK2RlUHFMNUZ4c211K2J3Zis2YWFVbjVhUURheFdKaUVk?=
 =?utf-8?B?VFNBY0cySThRR0hWV2tsdjVseExHeVpnNldETmRaaG5jdW9rZ1hnaHh0T09H?=
 =?utf-8?B?NUEzMTVPQUFaakx0TTNYblM3akJxK0RxTmxiOVcycUMzaXF6RUV3UllsZytD?=
 =?utf-8?B?SlZjWVBmTUU5ZkVnL2QxS2IzL1BGaUFNLy8rMmgzMjRwcnBIMUs5djFJalBN?=
 =?utf-8?B?a3ZPcnJRY1BORElENzNheldLOXJqMFA0WWtCbXNyRktQNWpwaVJQOHNFSWJV?=
 =?utf-8?B?L3RjTEg3R2ZvK1UwNng0NkZCdmZaaCtJQ0VZK1JkWnhIU1NuMk1PUjdoN2p2?=
 =?utf-8?B?TVdQNDhvdXMxeUkwcnBpZEt5aWhZMGJoOURvWUtOdjREaUc2ZnRVQnZKRkRx?=
 =?utf-8?B?dyt6U0wzbDZRakM5QXlwR0l2WHg2Q3Vna0Ntcjc4cjNLU3NOZytLc2xsYlRs?=
 =?utf-8?B?Z2g3eWJQSTcvWXZPZEQwMFlnZzhJdWsrd05mcGFxZ21DUlBCdDFxY3VPU3Jm?=
 =?utf-8?B?OXZpN21QbWpZQ1VFbC9Fdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5592.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2ZvMHNhdmRjRFFmT0hYSTc3RkIyVndHd0FqZEJGR0E5OVJ6ZUFXZGNpL3VM?=
 =?utf-8?B?VVA3czZDN0JqREhURzZPeVEvWW42YUJmb2dYNkJLMVN3YlVrS2wrQUViaUts?=
 =?utf-8?B?dlJJN09zQ295aUJLaHpoT2RwclJGS0ZZcGthNjdxdXhYZTNia2wzWjJ0alRP?=
 =?utf-8?B?UE1uNm9ZbDZaU2JjUkJyMGJYSjZtV0UrZXAva0E2SFZhNm5CSG5aOWhDNXZW?=
 =?utf-8?B?WHFMVk5GS0hQSnFiVUZ6MEt3YVYvbVNYVDhRZklNdlBrNUNEaW9NUC9qME1G?=
 =?utf-8?B?V0hCVWVqWEF1ZWJCa3JROUlya012b0tsRFVjRXNTamVBQ01IR1pyZGNGVHdt?=
 =?utf-8?B?NFdROHVJT1l4WnU2ZnhoNEhoUmNmMlZxZnowV204eGcvbFcvWVpHelNONFc3?=
 =?utf-8?B?ZWJqT0tXMkJBcWxPWEpHZGh2cFFZbjlJSFMwdDU3cmVjVDFwVTQ0K3Z0cEhO?=
 =?utf-8?B?WVdyNmpxZWZGOUYwajI1b2sySFVBWFE1dGR0alhiOFpMTWczYnM2VU9DV0FS?=
 =?utf-8?B?Vlp5U1lmbE1zS3FlNldFTkZNK1Z4REl5RDE3dVJxMTBYaUk3SGpTclV4dHFk?=
 =?utf-8?B?TDdwTW5sajA5eWo1a0p6aiswS29ycDF6Q2NUa00rYnN1MXBVUk5EVURmRVdo?=
 =?utf-8?B?Q2Y0a1ByNkh1bFhhdEo4WHlvUm9wU3JWbTVVZWFORWpBSkRLc3Y5ZU82NFlh?=
 =?utf-8?B?NmQvS3BIVmxBNnZ2MDJNZFRmNmdnSkI2MUEwMVB4ZVJoMlhFMkEvTUxBZTlm?=
 =?utf-8?B?Zng4c3ZCMUNZSXd4QUlrdi9KNEZJZ3hiN1RlRktXV01GUmZZdnVvNGhUUHh5?=
 =?utf-8?B?Z2dnMWJ1MzErNWJsY3p0Wm5vVzlSejByV2FmY25pN3JsVVI5clFCaU5mMXo2?=
 =?utf-8?B?U2FkZ29IQVRKNVVYMGUzeHAxZzllTzRScnpXaFF3Y2FPQWc1QWdZSmdWSlVx?=
 =?utf-8?B?UW8zMVlDcUw5MnFKcTJXV3YzWjB4NVJqbkpXVkYxTTBKZGZUY2tVWkN4dUY2?=
 =?utf-8?B?RjZkdk5abkozK01FU2ZyUGYrSytaMTBQNW5NSlk1YjE3dG9GZEdqazllKzhR?=
 =?utf-8?B?YXA1ekVrSjVhUmUrMEd4c1Jpbi9QWDVQd3lTam5oVDFMYVN4SnI3RXlXTk9p?=
 =?utf-8?B?VDdJOE8xL3g0OGhLYjFkekd5Znhha1lDSGNJTXpQSDVIb0JzZHd5L01oQXJt?=
 =?utf-8?B?QmdNdFJlV1Q2NFlYVUJnSmY4M2RwN2tkVXNUTlJrbE5JR25pZnBhU0lvbWhB?=
 =?utf-8?B?TmR5VnkzZzlNaFhJTzRKK1dibEFWRUhkUU94TFY2ekVvNXZQUUsvQUJoSUFV?=
 =?utf-8?B?aG41WVhxSmZhYUJ5Vy9wbHhpY1pHTEw4amNTdXNENE5GN0xEbXBMdlNuclhu?=
 =?utf-8?B?Nnh6SmE4blJKTWtSRXlSeGV6ZStaamF3OUxCYjFHbnFsTVdBMG5YMlhJZGJj?=
 =?utf-8?B?Mnd1T2NYTWR0Wk1JdWZjNVcrTUlSWHpMSkg0cllOaWxGN2F3UkhpWk5BZENt?=
 =?utf-8?B?T04veStZWWRCL3FJY1RSc3B3M0IvUitLZEczZ2RXNFZoVm5RSWhPNWFRaEdt?=
 =?utf-8?B?VnBtVWZ5VFAzSEZkNHA4UktjOUsydWhTTVRCZnZLLzk2WXllNncyNUhUZTl3?=
 =?utf-8?B?T1E1RzJFZ1BOVytKU0tTRFNRNUROMzZYdnpSUS94TTFsZWxsMHlyd2FUemdq?=
 =?utf-8?B?V01nRm5YSkRhVzh3bnFvY21jZTlSR3NRbEtyTnRyNTlPSjhmRHlsMXg4Um0y?=
 =?utf-8?B?SHdCbEtDRStCWjdJc1kyNzNyVFFSbE83WkMra0FrNnJoNmc0V29FZlhPWWJS?=
 =?utf-8?B?eW45Yy9nRkFWVEpDU1JtMDJObkRrNFRpQm5ya3JCdkFEVGM1NXNVNWFPZjRn?=
 =?utf-8?B?NjhMTitFZHowRll4RUN5V2JrRmgzUWtlYkVlcmdJWmIyUk53ZDA2TlBZaG9Q?=
 =?utf-8?B?bWo2RkplVWNNVXNZeWVKNWY2QUN2R3FYS2h3YXFTSFN5b1ZlMHlXOTlObkhK?=
 =?utf-8?B?MWk3OEZrUlloMnBFZm9iaXBJVVB4Z3U0WHg4MzZpREExSHhVa0JuK29JTG5T?=
 =?utf-8?B?MkFucEQ5YnRzRUJvUlEvZC9VYndIbjNCc0FDRDlpREJnN0pGTlhTM3c0aW5Z?=
 =?utf-8?Q?oIgMcA6yxxHbsCCDqzCW3gKjy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5728c1b5-8ee8-4a0b-50be-08dcdeb04b9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2024 04:53:14.3840 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OKFAlXXQDbSuQY890V2q4+a5YjOk4E0xQW+NHeGhIjt655Vc4RY7U9ZCk99XYEuGyMdV58Xcj7kazu2NtXJHz/EgCxC4IQmpTz4fAUbixao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8148
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

SGksDQogDQo+ID4+Pj4gYXJjaC9hcm0vY3B1L2FybXY3L2xvd2xldmVsX2luaXQuUzoucHVzaHNl
Y3Rpb24gLnRleHQuc19pbml0LCAiYXgiDQo+ID4+Pj4gYXJjaC9hcm0vY3B1L2FybXY3L2xvd2xl
dmVsX2luaXQuUzpXRUFLKHNfaW5pdCkNCj4gPj4+PiBhcmNoL2FybS9jcHUvYXJtdjcvbG93bGV2
ZWxfaW5pdC5TOkVORFBST0Moc19pbml0KQ0KPiA+Pj4+IGFyY2gvYXJtL2NwdS9hcm12Ny9sb3ds
ZXZlbF9pbml0LlM6ICAgICBibCAgICAgIHNfaW5pdA0KPiA+Pj4+DQo+ID4+Pj4gTWF5YmUgc3Vj
aCBhIGRlZmF1bHQgbG93bGV2ZWxfaW5pdCBmb3IgYXJtdjggY291bGQgYWxzbyBoYXZlIGFuIHNf
aW5pdCA/DQo+ID4+Pj4NCj4gPj4+Pj4gV2hhdCdzIGNvbmNlcm4gd2l0aCBsb3dsZXZlbF9pbml0
KCk/IEl0J3MgYWxzbyB3aXJlZCBpbnRvIGV4aXN0aW5nDQo+ID4+Pj4+IGVhcmx5IGhvb2sgZnVu
Y3Rpb24gd2hpY2gncyBsb2NhdGVkIGluc2lkZSBzdGFydC5TDQo+ID4+Pj4gSSB3b3VsZCBsaWtl
IHRvIGF2b2lkIGR1cGxpY2F0aW5nIGxvd2xldmVsX2luaXQgZnVuY3Rpb25hbGl0eSBhcw0KPiA+
Pj4+IG11Y2ggYXMgcG9zc2libGUgLCBjb21tb24gbG93bGV2ZWxfaW5pdCB3b3VsZCBiZSB2ZXJ5
IHdlbGNvbWUgLg0KPiA+Pj4NCj4gPj4+IFN1cmUsIEkgY2FuIGFkZCB0aGUgc19pbml0IHRvIGNv
bW1vbiBsb3dsZXZlbF9pbml0IGFuZCBtb3ZpbmcgdGhlDQo+ID4+PiBjb2RlcyB0bw0KPiA+PiBz
X2luaXQuDQo+ID4+IFRoYW5rcy4gVGhlbiB0aGUgcXVlc3Rpb24gaXMsIGhvdyBtdWNoIG9mIHRo
aXMgc3R1ZmYgY2FuIGJlIHJlbW92ZWQNCj4gPj4gYmVjYXVzZSBpdCBpcyBwYXJ0IG9mIGdlbmVy
aWMgbG93bGV2ZWxfaW5pdCwgSSBob3BlIGEgbG90Lg0KPiA+DQo+ID4gSSdtIG5vdCBzdXJlIEkg
Y29tcGxldGVseSB1bmRlcnN0YW5kIHlvdXIgcXVlc3Rpb24sIGJ1dCBJIGNhbiBzaGFyZSB3aGF0
DQo+IHdlJ3JlIGdvaW5nIHRvIGRvLg0KPiANCj4gSSBhbSB3b25kZXJpbmcgaWYgc29tZSBvZiB0
aGUgY29kZSBoZXJlIGNhbiBiZSBkZWR1cGxpY2F0ZWQgYnkgdXNpbmcgdGhlDQo+IGdlbmVyaWMg
bG93bGV2ZWxfaW5pdC5TICwgaS5lLiBpZiBzb21lIG9mIHRoZSBjb2RlIGluIGxvd2xldmVsX2lu
aXQuUyBpcyBkdXBsaWNhdGUNCj4gb2YgdGhlIGNvZGUgaW4gdGhpcyBjdXN0b20gbG93bGV2ZWxf
aW5pdC5TIGltcGxlbWVudGF0aW9uLg0KDQpObyBkdXBsaWNhdGUgY29kZXMgaW4gYm90aCBjb21t
b24gbG93bGV2ZWxfaW5pdC5TIGFuZCBjdXN0b20gbG93bGV2ZWxfaW5pdC5TLg0KDQo+IA0KPiA+
IERlY2xhcmluZyBhIHdlYWsgc19pbml0IGZ1bmN0aW9uIGF0IGxvd2xldmVsX2luaXQuUw0KPiA+
DQo+ID4gLnB1c2hzZWN0aW9uIC50ZXh0LnNfaW5pdCwgImF4Ig0KPiA+IFdFQUsoc19pbml0KQ0K
PiA+IAlieAlscg0KPiA+IEVORFBST0Moc19pbml0KQ0KPiA+IC5wb3BzZWN0aW9uDQo+ID4NCj4g
PiBDYWxsaW5nIHNfaW5pdCBiZWZvcmUgbG93bGV2ZWxfaW5pdCByZXR1cm5lZCB0byBwYXJlbnQg
Y2FsbA0KPiA+ICAgICAgICAgICAgICAgIFsuLi5dDQo+ID4gCWJsIHNfaW5pdA0KPiA+IAltb3Zl
IGxyLCB4MjkNCj4gPiAgICAgICAgICAgICAgICByZXQNCj4gPg0KPiA+IFdlIHdpbGwgbW92ZSB0
aGUgY29kZXMgdG8gc19pbml0IHdoaWNoIGlzIGRlY2xhcmVkIGluIG91ciBwbGF0Zm9ybSBkcml2
ZXIsDQo+IGFyY2gvYXJtL21hY2gtc29jZnBnYSAuDQo+ID4NCj4gPiBUaGUgY29kZXMgaXMgbmVl
ZGVkIHRvIGJhY2t1cCB0aGUgZGF0YSBzZWN0aW9uIGFzIGVhcmxpZXIgYXMgcG9zc2libGUNCj4g
PiB0byBzdXBwb3J0IHdhcm0gcmVzZXQgLyB3YXRjaGRvZyBkdWUgdG8gd2FybSByZXNldCB1c2Ug
Y2FzZSwgd2hlcmUNCj4gcmVsb2FkaW5nIFNQTCB3b3VsZCBiZSBza2lwcGVkIGFmdGVyIHJlc2V0
Lg0KPiBJZiB5b3UgbmVlZCB0byBydW4gY29kZSB2ZXJ5IGVhcmx5IGFuZCBiYWNrIHVwIGNyaXRp
Y2FsIGRhdGEsIGxvb2sgYXQNCj4gc2F2ZV9ib290X3BhcmFtcyAuDQoNClRoYW5rcyBmb3Igc3Vn
Z2VzdGluZyB0aGlzLCB3ZSB3aWxsIHRyeSB0aGlzIG91dC4NCg0KUmVnYXJkcywNClRpZW4gRm9u
Zw0K
