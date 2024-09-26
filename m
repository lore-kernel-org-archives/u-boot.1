Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C7ECCFA15
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 05:43:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E736088C53;
	Thu, 26 Sep 2024 07:43:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="SDqoQ1Xl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 894AB88418; Thu, 26 Sep 2024 07:43:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5C7088C4A
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 07:43:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1727329423; x=1758865423;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Qe1cLMrB918E/bWn4U/qRs5Sw5gTeigzA8fBLjIl1xw=;
 b=SDqoQ1XlyG9q6NRJ06Kfl9p5Hac5aEpl1AH330Tf4e5Hw28v5fZgPcDk
 3FAG8z0ufiPsRbOJDYbr9ubLhut71LoyrSMi8EIOdr71pYkLK8Rt+2tm2
 HCL0fpWwW/USewGRBISmHQaiwMN1fDyWhgCOAM/eWs2J1IkvXrxR/JWo+
 19/0TdPV18DOxnYRtw9s7fvtI1k6aQP7c9kKYoDqd7oycx8ErWdW7Fc4u
 5c8FB3nk4lR+2Z2VqGDzkKE9z7GIjuwAE3QMtPzyEJsNqMXXqV9m286KD
 eo+v/H6mD17CiJSMwXgyIOuxTaPnhAel2rNtwk6zM459c/hyKUXSPYLZo A==;
X-CSE-ConnectionGUID: 5ng0YO1fSCulCPx6h1JIeg==
X-CSE-MsgGUID: 2IKk0E/4T9qqbsGZsgsXjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="26529141"
X-IronPort-AV: E=Sophos;i="6.10,259,1719903600"; d="scan'208";a="26529141"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2024 22:43:41 -0700
X-CSE-ConnectionGUID: sXFGlkzbR16PhrgKzvD9CQ==
X-CSE-MsgGUID: VwlJolR4SYSPWu1je+6k9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,259,1719903600"; d="scan'208";a="71682104"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 25 Sep 2024 22:43:36 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 22:43:35 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 25 Sep 2024 22:43:35 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 25 Sep 2024 22:43:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VWXFNZnFIN7YVqV9nSTROMnx2gW8hSgj20+pf8pzs/BL2eJ38v6smQLjllEVfa5v7lM+mEmTUQHp9R4u6WbFUwJKPTeGHyjf81K6kiUnydn2Rx44BJBorvfq6B9BT1ofbBzZ3C3rtlwHuww+DOBCl9nBEa6qkMImW10vAT4LA8uES3AM5j7Tc/Qul6E/0sHQU19P8eKOVY1loGfTaanUUIcyzMmbNAMRLVvVx1UA2cdMY8nLr3IhCrDI3Htu3hjm4ayZD1+0l9ISzHzlNUF/6MIpiWc+PBq3+53vbSgTNHGCWuSD8c4LYYG/yiqY3bgRRFWPSk4NSmxXTdiT+yjr+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qe1cLMrB918E/bWn4U/qRs5Sw5gTeigzA8fBLjIl1xw=;
 b=EeqXYUo+eXmuQ41SSXNV0AP7+mYTkTEbo/ZvrxBuVz+LOd6loW8Go3RciQ1gLcXuIGeO2Muj6YSgH/pgbwAQCNHikHytS04D2835MJPpCBYMKmFcApZ16MQ5+ZWZtlZN5tNXpcyaAqWDJY58GAb1Dr3pitY7BHGXphlfkAmf6rApXTcDwjK5M38jxn/rARjogY8jO1B9399S7poKZhPGnRs3jckfSSfJZEgU0osucZgu8ERmUcXez14bXCrnftmhqw1N01eN5b7bhGtiFFLA55j2swEMuFC9jj81Lphq/GotN02YXJU0DIdRsZKvCGCFYCNJ//9HfdMDSLlc6jxdRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5585.namprd11.prod.outlook.com (2603:10b6:5:356::23)
 by PH0PR11MB4887.namprd11.prod.outlook.com (2603:10b6:510:30::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.29; Thu, 26 Sep
 2024 05:43:33 +0000
Received: from CO6PR11MB5585.namprd11.prod.outlook.com
 ([fe80::dc6b:e780:5f06:b8cf]) by CO6PR11MB5585.namprd11.prod.outlook.com
 ([fe80::dc6b:e780:5f06:b8cf%2]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 05:43:28 +0000
From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, "Meng, Tingting"
 <tingting.meng@intel.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@intel.com>, "Hea, Kok Kiang" <kok.kiang.hea@intel.com>
Subject: RE: [PATCH v1 08/20] arm: dts: agilex5: Enable XGMAC
Thread-Topic: [PATCH v1 08/20] arm: dts: agilex5: Enable XGMAC
Thread-Index: AQHbCys595Xy+QfqzUelHQSJaf/ZbrJiRCeAgAQzT+CAANNsAIAAwW4QgABwnICAARqqAA==
Date: Thu, 26 Sep 2024 05:43:27 +0000
Message-ID: <CO6PR11MB5585C3524F99D4F4F9CADEEDD26A2@CO6PR11MB5585.namprd11.prod.outlook.com>
References: <20240920070242.20884-1-tien.fong.chee@intel.com>
 <20240920070242.20884-9-tien.fong.chee@intel.com>
 <92fa9c17-bbf4-49b5-8d7c-4b7d06f60736@denx.de>
 <DM8PR11MB5592C2455A4CFA9CDE0F6DD8D2682@DM8PR11MB5592.namprd11.prod.outlook.com>
 <5db7f491-e8f2-45d0-baab-fa309cb4db64@denx.de>
 <DM8PR11MB5592C49308440E5F902A4F1BD2692@DM8PR11MB5592.namprd11.prod.outlook.com>
 <749f6964-52be-4b4a-81e6-d351564d5465@denx.de>
In-Reply-To: <749f6964-52be-4b4a-81e6-d351564d5465@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5585:EE_|PH0PR11MB4887:EE_
x-ms-office365-filtering-correlation-id: 1628d677-6d0b-43a3-899f-08dcddee2571
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dmh5Q2ErcFg0ZWFKZmp4dG1lYndGSFk2QXNpUHpPMjZ5NlVkYUdTQVN5Y05t?=
 =?utf-8?B?a25Mbk5xQTB4bzVNU3M2d3Q1UVllK3poNFZaN21sTHNQZWkzKzcvVUhxMDU0?=
 =?utf-8?B?WEtyZWFsRlBLWFZ4dkpUMHpwZEZBRTc1cVZ1ZVFSbitQUXVQd3FHNkhhNDd2?=
 =?utf-8?B?R1ZoclUrMGxicExMYUhITVpBdU01MlI2dEVYUE5tZmhoK1Q4OWFRV0JkdjAv?=
 =?utf-8?B?ekNLK3cwOHhBMGVsLzJYU3ZJM2VRKzBnVDg4RGdyZEhPNG5nY0xIYVc5bmxE?=
 =?utf-8?B?cGxvTTZQenhxZkllQUdPajR6NlFNUHVHT0xKSFh2ZU1IT3cyditrM0UwNWFE?=
 =?utf-8?B?TFdkSXp0TnpRV0doYS9SK3BMaWwvN0tzbE9JYmQxSjVKdXh4bDJXK0pmaXU5?=
 =?utf-8?B?NWtYR3NkYjI5L1d5UU9XTllBWXgvSlpxbytVTFN1TnJBK082VGZya3EwT00z?=
 =?utf-8?B?RkFjT3pUeVU0MHEzN0xSaG1mU3lGV2RWUFdjc0RRdUxuTFpGSU1obitvNW9D?=
 =?utf-8?B?Q3lNZHBvcERMZmM0MVVLUkdaV0JyNHIyV3AwQjQ0Wm5DYStxK2gvejhGTXZR?=
 =?utf-8?B?OE5KWGY1N3dJUHZyeUpLWFQ2cmViVVUxSGdFMFpWR3JFaHB1UUlOMXQzUG9t?=
 =?utf-8?B?NFYvMlNlN2xKc3hxaW1vc1dGR1N4MHh1ODhwQm1RS2NuTThXbFhOUnVNeHpq?=
 =?utf-8?B?UVJmUC9CSWRtQkFyQzJobkM5WExlY0Q1N1J2ZkRNbjFmNVh3YmtDODFGajRJ?=
 =?utf-8?B?Z1VZbDNkeUt6aFRzVXNET0s1ODQ1NENWQi81UkZ6OVJScUNOV3V1VG54Yits?=
 =?utf-8?B?Mk1rWjdRRVNrWFE5NGlxSUhaN0VCWm53NlJWMTBzc1AvZU54bFdkNlQxeURG?=
 =?utf-8?B?Z0hHeThTSHd5Z2ZvdUxVR3R2RWhDSmxZU3JvSy9hZXJVb0xwY2ppUTdrbGs3?=
 =?utf-8?B?TjhoSW9SczEwREVWZEVjK2ZFUGwwYWpKZEZyaUw5dFEzVmdJb3hmZDZHeVBq?=
 =?utf-8?B?SmVJdEVZa3ZvTXdzc1h6TlF6SE8zY21ibUVkK2RwK1VuM1g2bWRLRTdFcUM0?=
 =?utf-8?B?RWUya1EwWWZhWnFUWUZWeTh3R05jU1V5REZ6TUZlSVJLT0Q3OGx2MmV4cmx2?=
 =?utf-8?B?bGpYTll3VnpwZGEyUGIrTzFuN3VTRTBNZ1EraVFxMFB6YjFiei9RajV3eGhi?=
 =?utf-8?B?OWlUUlBxbHNqaWN3Q1lSemorMnUyTS9lOFpzVEtTb0Zsa0x3OFc2ZjJ0Qkdh?=
 =?utf-8?B?ZHlOYmdFMEIvNjBPMWpQNnpQM211ZmlrdzBGMC84S0d6bFZuN3RTSlBQTWwr?=
 =?utf-8?B?KzlFcy9DRTNva3ZCa2RNTkdiVUJEZm9CWm13TEVGTEM0M3FBaGw5bVpSOHBE?=
 =?utf-8?B?T1ZTNTZqK09RRk94dnpZWG1QazBkQlh1SXpkczVvajFJMlQxa2VEUmtXS3hm?=
 =?utf-8?B?RFZxcFp5Wk1hZ014UWc2eWRBUzRLZVI4VWIwMSs1akRoekd1RnVBMGxSK1lD?=
 =?utf-8?B?THNPNVJVdmdqU1ZLUHdhZXJ3QVBNV0pOSDBtS3NSUkxLdjhFQSs2UEFxRmJU?=
 =?utf-8?B?SnZ5WWZlcTVtaGdsK2pkSXVCbDE3UTlEdm4xSkdOd2VWdTVwUWh5WTkvcXh1?=
 =?utf-8?B?UmMrZTJVck9hNmUxbXZpdE1aTkFQVjlsVGVBd0dBY0h4cTljRUd1SzVWaGhV?=
 =?utf-8?B?L2dxTVl3RWpMS3g1TXJjZ0JGQ3RBZ3N6ZmhUbm9Yem45N2Q1d1RqT01UTEkv?=
 =?utf-8?Q?6BWxRuUYgeFnI3O3bo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR11MB5585.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXVJVFVPbzZuQVFjTm9ONSs4Vml3aUdFa3hNZ0YvM2pjdzJWS2lZMnM1a1Fo?=
 =?utf-8?B?Nzd1M21LSkMzQzNKQmxZNjVkdHV6SlhXNWZoRHVMUVlnS04xQTcrMmQ5TlR5?=
 =?utf-8?B?cjJxc3dzZFV0aWlGS3YvWVhFbTRLUHlhVWVpdWFFbmVyK2syTVNmMkc2ekkw?=
 =?utf-8?B?K29Rc0xSSGg5TE52dkcrNWMwZlpkbnAveWlCODFkZ0oxeFhRd3FpYTRHbTRx?=
 =?utf-8?B?LzFuQ0F0Vk44OHkxa2pqUTE0U1NQRjI3TXo2ejExRTc1a21paDJFK2c4QnJl?=
 =?utf-8?B?Zy9sLzhlZmpSUzNxUkNRelZxT0J5ZnZxd0Q2RnMwUFJKdHZxc2RkTEhCMWtM?=
 =?utf-8?B?OHFMay9Ec3JxbklweUpINmNKTWJ5WDBocjhoSDd3aVYvOW5ZLzhhUjdtb0NN?=
 =?utf-8?B?dFgvTE1mc05kVm4xQWptNDhMNHVGdVV3VEMwVlpNOUg4QkdXbVdXaDNDWWYz?=
 =?utf-8?B?MkZNQWg0aVZ1OHlyRHFZN25aWURBRms5VkJzT0tYNjhiNm9SaGFlYm93NTVl?=
 =?utf-8?B?anUzNU5JQ1RJZERTdy8rMUlSSmhPcTBhcVVwRkk0MDhJbEpnem52bG9reG44?=
 =?utf-8?B?czQwd2ZhbjNvZW9ETVNERS96a3FxRzVoa25TdUQ2L1VMdVZKR3Vqb0hBUjM3?=
 =?utf-8?B?T0dKUHRFL2dXUm5oWUdoUTdrT09KQWI0TWw2U1JmRElDNWl5ZTg3VXg0emJH?=
 =?utf-8?B?OEFKQTV2V3VjNVAzMFF6YW5wWk9DdFM3S1ZZQ2dtbVdYbDEwaDU5S3BEMDI5?=
 =?utf-8?B?YU9DTG9lQjdHaWJ2SjJ1eHJqQlZXdGpwTmtTNjdRd01hKzFTd3M2WlRRd1Ax?=
 =?utf-8?B?ejRUR1hHUEpDdVJMVmhSTmlNblBqTlhxZk9wYkNNclRwcjN2ZzArMWE2NEdn?=
 =?utf-8?B?UkpkUG4wOHpPeFlnR2lRWE54dkoxOFRBczlBNm81RldQN2IrQTVBSTdKSWhG?=
 =?utf-8?B?STJOYzRmT2pVRE5qMDhwNkloQWZyS1R0a2Fuc2ErSEhjSjk0YmIvRTNyZG0r?=
 =?utf-8?B?Um1CMUFjQ1I2dUFNSVh2WVpOTTE0MTRYcjVkV2d1azVscFI2Nkpub2JOUHNN?=
 =?utf-8?B?YVhidnR0cGdnb203RGVFdEhyWnpqYWppbzk3ZVZyZW8xTUV4eEZjQkV0RGNR?=
 =?utf-8?B?b0pqc3h3aU4wVytuUnAxL0xIUVRlU3hYRk1IemZTL0hZNDY3UlVZcnFsdGV6?=
 =?utf-8?B?aVhReFRPc1B1S21NQmllelRVWExjTDQ5WGl2Q0IxZGJMU0hKcXBNWXRRTlpz?=
 =?utf-8?B?OXZTWkg4aGtMdnh0Q0VyQW1KamJzNTBudWg3RHMreVFka0NxS0xYVnNmOU1X?=
 =?utf-8?B?OVU2L2N3UUlVWDIxc25Sa1ZEdEVzN3E4VnQ5NUU1V3JjVE1pc2JmZlM0UVY1?=
 =?utf-8?B?ejFCcE1aL3NLOTZLRW5nblU4b1A4Z2NJcFZiU1o1ejhBQ2k0SGlweG5KL1Ji?=
 =?utf-8?B?Rkp4WUVvRVdFQlRJOVhMUmFIM080R3V1bVhjYzlucGY4QWJ0dVdobUM4L1JV?=
 =?utf-8?B?eEk2SWxQYnRjKzJFcDA0aHBlVzdDcG55Z2gwWStLSUJsZ1N6RmdUUHptVHhF?=
 =?utf-8?B?V1VWWTFaa0dUdFVvQ014a2plK0dwWmF6a1I5RHZERXNOM3hHRVY0ZUFrL0h5?=
 =?utf-8?B?YzRmcDh0V0pndkhHUTBIbUJOREtEK01UM2RpdFJlUmRoRUViVG5HTmtDMnVo?=
 =?utf-8?B?RkE1VGtpTFFFTnpERFlIaDAvSkVqY2FaNzZqVEhrNWNiWXMyTS9ZR0pJeWtO?=
 =?utf-8?B?TlFrTUk0bk1MOTZlT0JleGV2Q1cySExSVEs0aittRHEwY3dYMlF4eENRakM3?=
 =?utf-8?B?Z1hTeXVPenhZZ09YKzVWWTc1K013Tlh0U0ZSRkE5SDVrRERqbDBZRjZhTDFB?=
 =?utf-8?B?ZE1lZ3hVU1R0cUVzSDR1YzUzZW80T1piYmY1WDRtM21FS0FSMW5mWWxWR09x?=
 =?utf-8?B?VVVQQW40SEp5aVVJN3RIK1Z1bE1zMXpUSGJJRm9wSFZNYXRiWDgxTFdIcVIv?=
 =?utf-8?B?c20xRlhFb2YxSEx4UTZXcVNwQjBVQi9nVkpZZ2tvOWhJZEJuc044bndMRDl2?=
 =?utf-8?B?VElLTWFuQndWc29hZXJXM1A4SVdQQzBxb3pDNEdBVnEwODl6ZzR3dUhWcGFj?=
 =?utf-8?Q?CU0cZbSehwITpz9Rp7fILNgqt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5585.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1628d677-6d0b-43a3-899f-08dcddee2571
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 05:43:27.9387 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KvK7VZA5M309Tf9XTlhI4qiZeqGx3roxJgXINykl4wV4JVV7WJoTvzhEo96vu1SlzfmWulh1VHqLbnd8+wLJfKWEA22sFl+zc9LK4HOE5Cg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4887
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
PG1hcmV4QGRlbnguZGU+DQo+IFNlbnQ6IFdlZG5lc2RheSwgU2VwdGVtYmVyIDI1LCAyMDI0IDg6
NTEgUE0NCj4gVG86IENoZWUsIFRpZW4gRm9uZyA8dGllbi5mb25nLmNoZWVAaW50ZWwuY29tPjsg
dS1ib290QGxpc3RzLmRlbnguZGUNCj4gQ2M6IFNpbW9uIEdvbGRzY2htaWR0IDxzaW1vbi5rLnIu
Z29sZHNjaG1pZHRAZ21haWwuY29tPjsgTWVuZywgVGluZ3RpbmcNCj4gPHRpbmd0aW5nLm1lbmdA
aW50ZWwuY29tPjsgWXVzbGFpbWksIEFsaWYgWmFrdWFuDQo+IDxhbGlmLnpha3Vhbi55dXNsYWlt
aUBpbnRlbC5jb20+OyBIZWEsIEtvayBLaWFuZw0KPiA8a29rLmtpYW5nLmhlYUBpbnRlbC5jb20+
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDgvMjBdIGFybTogZHRzOiBhZ2lsZXg1OiBFbmFi
bGUgWEdNQUMNCj4gDQo+IE9uIDkvMjUvMjQgODoxMyBBTSwgQ2hlZSwgVGllbiBGb25nIHdyb3Rl
Og0KPiA+IEhpLA0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZy
b206IE1hcmVrIFZhc3V0IDxtYXJleEBkZW54LmRlPg0KPiA+PiBTZW50OiBXZWRuZXNkYXksIFNl
cHRlbWJlciAyNSwgMjAyNCAyOjM2IEFNDQo+ID4+IFRvOiBDaGVlLCBUaWVuIEZvbmcgPHRpZW4u
Zm9uZy5jaGVlQGludGVsLmNvbT47IHUtYm9vdEBsaXN0cy5kZW54LmRlDQo+ID4+IENjOiBTaW1v
biBHb2xkc2NobWlkdCA8c2ltb24uay5yLmdvbGRzY2htaWR0QGdtYWlsLmNvbT47IE1lbmcsDQo+
ID4+IFRpbmd0aW5nIDx0aW5ndGluZy5tZW5nQGludGVsLmNvbT47IFl1c2xhaW1pLCBBbGlmIFph
a3Vhbg0KPiA+PiA8YWxpZi56YWt1YW4ueXVzbGFpbWlAaW50ZWwuY29tPjsgSGVhLCBLb2sgS2lh
bmcNCj4gPj4gPGtvay5raWFuZy5oZWFAaW50ZWwuY29tPg0KPiA+PiBTdWJqZWN0OiBSZTogW1BB
VENIIHYxIDA4LzIwXSBhcm06IGR0czogYWdpbGV4NTogRW5hYmxlIFhHTUFDDQo+ID4+DQo+ID4+
IE9uIDkvMjQvMjQgODowMiBBTSwgQ2hlZSwgVGllbiBGb25nIHdyb3RlOg0KPiA+Pj4gSGksDQo+
ID4+DQo+ID4+IEhpLA0KPiA+Pg0KPiA+Pj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vZHRzL3Nv
Y2ZwZ2FfYWdpbGV4NV9zb2Nkay11LWJvb3QuZHRzaQ0KPiA+Pj4+IGIvYXJjaC9hcm0vZHRzL3Nv
Y2ZwZ2FfYWdpbGV4NV9zb2Nkay11LWJvb3QuZHRzaQ0KPiA+Pj4+PiBpbmRleCA5ZWIyMWQ2NTQy
OC4uNzVhYjA1MDMxYmMgMTAwNjQ0DQo+ID4+Pj4+IC0tLSBhL2FyY2gvYXJtL2R0cy9zb2NmcGdh
X2FnaWxleDVfc29jZGstdS1ib290LmR0c2kNCj4gPj4+Pj4gKysrIGIvYXJjaC9hcm0vZHRzL3Nv
Y2ZwZ2FfYWdpbGV4NV9zb2Nkay11LWJvb3QuZHRzaQ0KPiA+Pj4+PiBAQCAtMTIyLDMgKzEyMiwz
NiBAQA0KPiA+Pj4+PiAgICAgCWJvb3RwaC1hbGw7DQo+ID4+Pj4+ICAgICB9Ow0KPiA+Pj4+Pg0K
PiA+Pj4+PiArJmdtYWMwIHsNCj4gPj4+Pj4gKwlzdGF0dXMgPSAib2theSI7DQo+ID4+Pj4+ICsJ
cGh5LW1vZGUgPSAicmdtaWkiOw0KPiA+Pj4+PiArCXBoeS1oYW5kbGUgPSA8JmVtYWMwX3BoeTA+
Ow0KPiA+Pj4+IFNob3VsZG4ndCB0aGlzIGJlIHBhcnQgb2YgTGludXggRFQgYWxyZWFkeSA/DQo+
ID4+Pg0KPiA+Pj4gVGhpcyBlbmFibGVtZW50IG5vdCB5ZXQgaW4gTGludXggRFQsIEkgYmVsaWV2
ZSBvdXIgTGludXggdGVhbSBpcw0KPiA+Pj4gc3RpbGwgd29ya2luZw0KPiA+PiBvbiBpdC4NCj4g
Pj4gSXMgdGhlcmUgYXQgbGVhc3QgYSBwYXRjaCBwb3N0ZWQgdXBzdHJlYW0gPw0KPiA+DQo+ID4g
SGF2aW5nIHR3byBwYXRjaGVzIHBvc3RlZCBub3cgaW4gTGludXggbWFpbmxpbmUsIGJ1dCBnbWFj
IGRldmljZSBpcyBzdGlsbA0KPiBub3QgeWV0IGFkZGVkIGludG8gdGhlc2UgZHQuDQo+ID4gaHR0
cHM6Ly9naXRodWIuY29tL3RvcnZhbGRzL2xpbnV4L2Jsb2IvbWFzdGVyL2FyY2gvYXJtNjQvYm9v
dC9kdHMvaW50ZQ0KPiA+IGwvc29jZnBnYV9hZ2lsZXg1LmR0c2kNCj4gPiBodHRwczovL2dpdGh1
Yi5jb20vdG9ydmFsZHMvbGludXgvYmxvYi9tYXN0ZXIvYXJjaC9hcm02NC9ib290L2R0cy9pbnRl
DQo+ID4gbC9zb2NmcGdhX2FnaWxleDVfc29jZGsuZHRzDQo+ID4NCj4gPiBJIHRoaW5rIHdlIGNh
biBkbyBhIGNsZWFudXAgaWYgdGhlIGR1cGxpY2F0ZWQgZm91bmQgaW4gVS1Cb290IGxhdGVyLg0K
PiBBdCBsZWFzdCByZWZlcmVuY2UgdGhlIHR3byBwYXRjaGVzIChsb3JlIGxpbmtzKSBpbiB0aGUg
VjIgb2YgdGhpcyBwYXRjaC4NCg0KTm90ZWQuIFdpbGwgZG8uDQoNClRoYW5rcy4NCg0KUmVnYXJk
cywNClRpZW4gRm9uZw0K
