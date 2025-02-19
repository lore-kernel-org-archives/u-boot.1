Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22AA4C021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 03:06:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BC7C80A46;
	Wed, 19 Feb 2025 04:05:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="NvxLEVeA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD13280C8F; Wed, 19 Feb 2025 04:05:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCCD7809A4
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 04:05:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739934355; x=1771470355;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=2y4igGDoDESck3DFTm3M+YLVqnJfcp/e14otqkHflsY=;
 b=NvxLEVeAb4tVijXPvecnH47ukY1xIRn6TGNCK/HGx0yrGqPuw7KMD/Nt
 VjglBCVjH6Xbnej6tuo9Hoijn0SFVDO+TmfU6KoC/V8CfTpsgXiPpW61h
 G8Mo1vMpOhVMhj5j5WzEY+stzWm7BSHTMoRu30+Hg3yfMCjsAtBuhVaS1
 lfev8gQ0UcqyS/FAS5EnFAapYqdkc66PcrIQIw7rf6NckOxhPMcHcX+Xh
 VsOIqQeS9xTcqJCVMJrnT9jWfvObk9d5/6w4LNklGf5V3AfDJPSi5j6Ia
 re2gxSJPrLKjhIdLKyV/lpItBRRkrwGypapotv/HheSeYkgMaEaQWTeSK g==;
X-CSE-ConnectionGUID: f/gum7NPRsG7q6JaokqUuQ==
X-CSE-MsgGUID: K4sG+dQ5SjOFrFbwFylKUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44573769"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; d="scan'208";a="44573769"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 19:05:53 -0800
X-CSE-ConnectionGUID: ZtNjGiVtSpO3IlpgGlyZhw==
X-CSE-MsgGUID: 7xGnp0jASw6654HmcDQHKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; d="scan'208";a="114764171"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 19:01:50 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Feb 2025 19:01:49 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Feb 2025 19:01:49 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 19:01:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x7YfLliCRJCJmKQv9Ge0X/8YPf05U4yE1vjwiKceNv3SeDZG6PwWtDMOnHpZkI9fuOU3Jgi95QHYihoBbzSAMZcNywmKjz2gctLtSQshGY2tXKMyUYkwaf1kfdN0HboLtyDUhh9XHpYIYdsBp/Pq9ZhC38S05MuchK/Eo6pX7DYJ709JR6R2b3MVQCq0RYnIs7qhMYAyDfC0eF8fJ0sLe+JlHHPa72Mf8SPxBmF9jhIOSmJLsDDauRnBcLwuYqOCc7S5crH2Q1Qpv5tQClR4S/trZIunEq42hzwHdCi/wn/ADYaRuwW3VxUC29B2/UI82w1hdHce7I+8/6NpJtkZ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2y4igGDoDESck3DFTm3M+YLVqnJfcp/e14otqkHflsY=;
 b=guR7iODmoTOzG2JLeWTuyKU8WKvBfttOzsMiFftfTfn0z+mMquzo6Nhhzgo80BRcgTs8eWmJrDeFnpZMV3vmpXORrDLYWhlp+ILt5fuKdLtx/1HdlBT3NBhMcmP3XeAB064eq2tZYU3OOTjQPd9ythvqd8JMM9N9FHFWfw7u6csR2nn00Dayu4EnC1T2+JlWJYwVM/FCmOSYUDytWV8+luHR4WPx+j5T0zRyj+UDbP22bhC9T4uKp1C98g/+NpQOeRPjvRmeTLMOmYfCqcCEaoyrxfPVZ3B8I9VP8YSyyTReR+gNV3D14fZ5QlW1hv9Hv6dwOHa/Nm6Qne6BkC93lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5366.namprd11.prod.outlook.com (2603:10b6:208:31c::17)
 by IA0PR11MB7281.namprd11.prod.outlook.com (2603:10b6:208:43b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 03:01:45 +0000
Received: from BL1PR11MB5366.namprd11.prod.outlook.com
 ([fe80::f073:1e46:c7ee:df9b]) by BL1PR11MB5366.namprd11.prod.outlook.com
 ([fe80::f073:1e46:c7ee:df9b%7]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 03:01:45 +0000
From: "Maniyam, Dinesh" <dinesh.maniyam@intel.com>
To: Simon Glass <sjg@chromium.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Marek <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, Tom Rini
 <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jerome Forissier
 <jerome.forissier@linaro.org>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>, Dmitry Rokosov
 <ddrokosov@salutedevices.com>, Jonas Karlman <jonas@kwiboo.se>, "Sebastian
 Reichel" <sebastian.reichel@collabora.com>, Wang Jie
 <dave.wang@rock-chips.com>, "Meng, Tingting" <tingting.meng@intel.com>,
 "Chee, Tien Fong" <tien.fong.chee@intel.com>, "Hea, Kok Kiang"
 <kok.kiang.hea@intel.com>, "Ng, Boon Khai" <boon.khai.ng@intel.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>, "Zamri, Muhammad
 Hazim Izzat" <muhammad.hazim.izzat.zamri@intel.com>, "Lim, Jit Loon"
 <jit.loon.lim@intel.com>, "Tang, Sieu Mun" <sieu.mun.tang@intel.com>
Subject: RE: [PATCH 02/10] drivers: i3c: Add new i3c uclass id
Thread-Topic: [PATCH 02/10] drivers: i3c: Add new i3c uclass id
Thread-Index: AQHbgbDh50XdhMmck0asLn2CDeqknLNNDtiAgADiaRA=
Date: Wed, 19 Feb 2025 03:01:45 +0000
Message-ID: <BL1PR11MB5366944DD2AA81EC1E5BFD9C82C52@BL1PR11MB5366.namprd11.prod.outlook.com>
References: <20250218025705.50051-1-dinesh.maniyam@intel.com>
 <20250218025705.50051-3-dinesh.maniyam@intel.com>
 <CAFLszTia6BqKtNbfvbio0Q6WnznkzSjWuMzpBHyYi2D54NFVzQ@mail.gmail.com>
In-Reply-To: <CAFLszTia6BqKtNbfvbio0Q6WnznkzSjWuMzpBHyYi2D54NFVzQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5366:EE_|IA0PR11MB7281:EE_
x-ms-office365-filtering-correlation-id: a9cb01c6-be1d-494c-14a4-08dd5091beaa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|10070799003|376014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?WHVubUp6UEk4UlB1djZoU3BaV082aExVUXN0TzU0dVBSZ3cwWDJUeC9hOHI2?=
 =?utf-8?B?RG1QL043aFhveFZENzZGcCt1YzZVVmFlcHhPRFZMR1p4a0YvWnVtNmpCeEJh?=
 =?utf-8?B?aUhlL0EzUHdsdTVTUDhoL0p6Ly9JUGxrVHN0Szh0REFBQTdra0RrU1BlT2U0?=
 =?utf-8?B?R0U4MFlzM0lSUWMrYitlVi9jSUhZeXF3dlRhL0RERjkwQlVyYm9FMmNiUDFx?=
 =?utf-8?B?elFkV3JMazZyNHRxNWpidWVUZ2ZTWk9EbXQ4bTRDUXdOZitKZFpCbXRTaXBO?=
 =?utf-8?B?alFaLzJtVzMydmIzaGZoMklvSUhJNHA4a1pTNmN4M203ZDdSZTZKRDg0K2w2?=
 =?utf-8?B?ZXdDdDN2Qis4Wnh5MVhmbHFEcUR1Y0J3Q21pdVB6cFlLcmk1blFrSDEzRTBG?=
 =?utf-8?B?eTNyY1JCcFNTUFpIVXY4NTFCS01pMnd0Umo2b0dmTE1vSmZmRTNmcVIyd1ZB?=
 =?utf-8?B?dzU1Yk5nSkVzU1JKS0VVYTlYWGZzS0kxeHpRU2U2bG92azJMSlNZTTdkb2dY?=
 =?utf-8?B?clEwWUNyamM2TU9OYTFiUDRpeVhWVWthaUJjbm5vUjFtUTZKYm1JMDZnSGdK?=
 =?utf-8?B?VXBxOEVxK2xIdUg0TDY5UkpVMWJQWU9laTlhTzhkckV6SDV1THYxd1VINXEy?=
 =?utf-8?B?cml3cWcrTlFtWklTd2haN1hqYk1IWmhKNXFJejBZYUE5bVI0NHIzT3lETkZ2?=
 =?utf-8?B?THRKUUVrUDlZTFFwQ0xyUWoxSGhyN1Bya3poK3k1SlVtZDQ5TW56Vmp5UUtI?=
 =?utf-8?B?ZU4xZ3diYXY3WVBXbldvRzJwUHUwS29GcTEwNHovTTZlVy9neHQ3elVHZGh6?=
 =?utf-8?B?KzlLa3J3bFZrdkE4SURVSlBvajRmblRUQWZ2dmRlWXZPNDFETnhsOGUzSHV2?=
 =?utf-8?B?RThZK1BzdFpMTGhKdUw5aVlJTmRxNEhOeW4wdUgvcWM0ZnNxbUtSRjM5a296?=
 =?utf-8?B?c0MwQ0V5VzdobVpDVDRGcGZ0TVdQT0l6L1VpRWlxN0NGc05tbkowV0hhbGY5?=
 =?utf-8?B?SXIvajlDc3VVdnhLeXNLU2U4L2hwM0ZRQ05rMFhXR0xuNVNOb2k3YTU3dC9U?=
 =?utf-8?B?Ty9zL3M5VEFzV3NkZ1BnUnJRRFY1dHUwNGFWQUM2bU5BeWJabnFWRjJkRjZk?=
 =?utf-8?B?cUp4UURNOFY5YXRFMTVWTVZ0cjlSSXZDbHZwSlhndm1JQTV3YVBWeW5mQnQ1?=
 =?utf-8?B?R3pVUGIzdUhEZUxOdmJIakRra21NdGRCdkI5TjVudEVTK1RMWUdxek1COEpB?=
 =?utf-8?B?Nkd1MjdWbGdaajVRdFdZaFFpZmtjK1FBN0IzbXhST3d0Z2pUNXh3MWtqTFJR?=
 =?utf-8?B?cGxzblF3VHFaTlhQaUk3c0RVbnpvamxWOStYQzlWMHFOdFZQRTQycWlaUGxh?=
 =?utf-8?B?djRmL1plS01Kb01uYm0xbjRLTTkwdmwrOW8vYTlqODBNWE93dmdCUHcrYTRv?=
 =?utf-8?B?U2pVS3NUc1d5STZYNWlhKzhrZTJYU1g5SFY1TzAzd3M2S0JPZytod2Z6RklC?=
 =?utf-8?B?S2tRSkpaRzRTblFCZ3JaMDh3bEVlWG9adnVWU2pXZ2ZsZnY1bERUQ1VET1pa?=
 =?utf-8?B?Q2pGa1prTWwyd2plM2VJNFBHczlBTmwxSThONkl4dTlmZ09jQUlwZzhaY3pr?=
 =?utf-8?B?eWNVbm9zSFVMaUZ1YkRqZlFzRXozb2hkbGNRdTdBbEVnNlEreHFSdmFlTENW?=
 =?utf-8?B?R1RMWGpGanVLbnhEdXpEajBURFo3YkI1bG05RDFtZDBuaFRGT2tRMk5lbCsz?=
 =?utf-8?B?N05PWDZCVE9jUEVTV2NFTmxnb1pLaUxsVWxhTUtZUDR4WEJyZnZYenB5c3pX?=
 =?utf-8?B?QzQxV3ltdS9ZcFEyYTRQOEJhaE5nOVhLS2Y2VjliRG5hM20rc0tMS2QxSUJh?=
 =?utf-8?B?WDJCRitqQXhwSFI5M2xEZkVtWks5MFVkOWlmSDBTQnlvOXBSa0F6K0F0aks0?=
 =?utf-8?Q?79aMI5rbE0ti+yHI3R7MsUbm2fOJuVX4?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR11MB5366.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(10070799003)(376014)(366016)(1800799024)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlFWNDJLQkgyelV0UFhsbFhXQVovSTBRdFZzNVluVVFyaTFiK0ZhNU51bXUr?=
 =?utf-8?B?RlZDeHJROEtMNUlLZWplNGpWZUdDWXg0eHdjWTRsVC9yNGpvQmNObUVreTMw?=
 =?utf-8?B?bjVONHRjeE9zbjQ3OFpPTCtRME9kUSs4akJHald2Y1JMSzNqMElrV2dsK2xQ?=
 =?utf-8?B?YllaNS9lUmdTQkhjNExWTk9EcWl5WnIyREFrUTlwdzFQU3FvQmdpR1dKc01i?=
 =?utf-8?B?Zi9mUlRHdk9qWERmUVpxQmJ6NlZNbCtrTk1Vemo3YWd3dVQzQW14Z2RFQ2NP?=
 =?utf-8?B?N2paR3luNmJtaFNLZlVHaGFwUjZ5Vk5hNnhhemhWaTdPZGtkR0hMUzdtUDJ0?=
 =?utf-8?B?TWpLMzdydCtJSEhyNlAxRGNWcjJFaUxyTmxYY1hCQ0RLN1JROVJOU3ZicG9J?=
 =?utf-8?B?UFJySUpIdHk3SzZIUlo1UGpjdFRSUmFRN2pmWUtqNk9XaWVzK2FxaUM3di90?=
 =?utf-8?B?dFRoV3pEV2R3TzdHZ1lxdytDdEljS3hLVlZEUFNYRlNLdjZRL0NHVmt2bzEr?=
 =?utf-8?B?cjQwTi9XeTBkSkQ1MUFzL05majViSFFZWWF1alpXK2VXQk1QT2I4QmZKZ0Zv?=
 =?utf-8?B?RUJScXg1UWFIQXVRd3crdDZXVS9MKzdmSUMzQXVwb2xuVGVkaUFkVmlPSWNV?=
 =?utf-8?B?Sjl3WDllL2ExMEYxa3gvQjczaVVGaWZnNXVIcUtkOFNTWVRSLzV1U1ZVSEht?=
 =?utf-8?B?WUZPS3hkSXIzcGsrdDJyanlYNW1nRlpQWG5KTno2QjJRQ3ZPeXhSRlQ3QkFI?=
 =?utf-8?B?dGZ3UGFmN0oxVWVyZHVsTEFqUmZLSHl1dXFHU2lyVEloYUdsWHl5bUNHT1FO?=
 =?utf-8?B?b1p5UFZ0S0hmd3dLMmczMTF1L0RlOGF4dHhEcUJUeTJ1MFNpd3VTc2JjYkRR?=
 =?utf-8?B?ZUo3V2ZIVHJKRkV3UnJyNVBFdFFOTjhHN3ZTM3crbUZ4bDFLL04vSi9sWWNE?=
 =?utf-8?B?UTd6VlZnaDFheXlFcktJWVgxOVNXTUdOT01wWkxPampkcFZGQ3ZobUc1T2NQ?=
 =?utf-8?B?Y082WFIwWUVCODRDTVJjQi92eXVtMEpRQWdKNVBCYkRtZ21QM1RFcjNmeUl3?=
 =?utf-8?B?VldkNmtEZGdUS0RveUFRT1VaYXVmUjRHMnJQNFdlWWFLWEZEZnJZczNmeE1S?=
 =?utf-8?B?bnBWQXZjVmJnYXpHWWo1dFMzS1J0anJONWdGb2p1YVAwK0FTa21ZM2d5Ylkx?=
 =?utf-8?B?QXJ1bzZCUzVBaTM1YkFYdW9OazdYYjJnSmdTcDQzbHV6RjhPR2ErUU9NeEpH?=
 =?utf-8?B?L2ROaGNCWlM4R3hMN3ZNQ0wySlVHM3piVzQ3MG5LcDFrckxwOFR4NmZuNW1W?=
 =?utf-8?B?U3V6K1hLRXVscGwwcFk4WTkwQzM5QTVLY3A4blVJNmx2Qmo2VDZReWdFUFBa?=
 =?utf-8?B?c1d0RDhpTVI1NkdjTTJ4a1NkMXlWZVVSSlgyTWVQdlRTYW9xZHdKSGR6Z3FX?=
 =?utf-8?B?VHIzSG1YS0w1aTVnUnNYUVdvYmlkUkowR2JVVFRCQzVvNTV4akg4SmVNRURM?=
 =?utf-8?B?SWtLa3QwZHJRUjdVQ0taa0dnOHQzNG1QRzBEd3VzZDM3T09Kc2k4MFVvRFFG?=
 =?utf-8?B?VzFnbm1ONStWcHJ6dDU2ZkFRd0lnS2gyaThUNWt3WnBnTmRrNHVpd0xtV2Z5?=
 =?utf-8?B?Z0VrcnNqK2JSMjBIcjJYR3FHSndnbDdnMlAxMU8zb094WXQ2RjZLR1Y4b3Z4?=
 =?utf-8?B?WkpSQjFkZkFYbW9hL1BvdzVZREgwcXpkKzdXcjdHWXQ3MzRJYjFZMGh0UXlU?=
 =?utf-8?B?L0RYbzlxelA0U0EyT1NjVDUvb3BUalhPMWxaMmtQeHU2ZXl3OEJOYzF0U3Zk?=
 =?utf-8?B?YW9JcDBKdUxEQ3RpdWtKNE1MNHdDR0Rock9zZGE3YTJNUDh5WXdMbmoyQjky?=
 =?utf-8?B?SlNNekF2eUl3NDRjbGJCYXo0TXU4d1orWE01dDFxS1Irc3hFQ2NLVXQ4dWUx?=
 =?utf-8?B?QzEvYTVYcWFCSzFSNElWeGtzYUhLaGlMcG1DSXo2NFZqUERERHByL0xrcDQr?=
 =?utf-8?B?bTVTTDNrNFg2KzVTNGo4d3NWZlFCUUI5VFhURnNad2wzTEplQnp3dGpRdnBz?=
 =?utf-8?B?czlxUzFCV0R1a0JMVEczRjBYZjZvTXcwd1ozNXZBV0U3T3FpazlTMXVOVXBR?=
 =?utf-8?B?YW10d01FakQ1RGNqNFM4NGpLV2c4Sk9QSFh3SFdyWkwxQWMzM3Y5MU0rTnB2?=
 =?utf-8?Q?y7nLHgqRecmiiC24iBxvWcoIbFYFr+vB770qsPA5oIb/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9cb01c6-be1d-494c-14a4-08dd5091beaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 03:01:45.5372 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZE2aqwrixTsxsopE2wAzInEa5WaDjcIXw6Ztog7ZlKL6ExD0huCtF0i7VMEB+SPBfOv51Nck9r8tTUEHZTbFohxHR9KegZ6D2yd7YLa5uX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7281
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2ltb24gR2xhc3MgPHNq
Z0BjaHJvbWl1bS5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIDE4IEZlYnJ1YXJ5IDIwMjUgOToyOSBw
bQ0KPiBUbzogTWFuaXlhbSwgRGluZXNoIDxkaW5lc2gubWFuaXlhbUBpbnRlbC5jb20+DQo+IENj
OiB1LWJvb3RAbGlzdHMuZGVueC5kZTsgTWFyZWsgPG1hcmV4QGRlbnguZGU+OyBTaW1vbiBHb2xk
c2NobWlkdA0KPiA8c2ltb24uay5yLmdvbGRzY2htaWR0QGdtYWlsLmNvbT47IFRvbSBSaW5pIDx0
cmluaUBrb25zdWxrby5jb20+OyBJbGlhcw0KPiBBcGFsb2RpbWFzIDxpbGlhcy5hcGFsb2RpbWFz
QGxpbmFyby5vcmc+OyBIZWlucmljaCBTY2h1Y2hhcmR0DQo+IDx4eXByb24uZ2xwa0BnbXguZGU+
OyBKZXJvbWUgRm9yaXNzaWVyIDxqZXJvbWUuZm9yaXNzaWVyQGxpbmFyby5vcmc+OyBNYXR0aWpz
DQo+IEtvcnBlcnNob2VrIDxta29ycGVyc2hvZWtAYmF5bGlicmUuY29tPjsgSWJhaSBFcmtpYWdh
IDxpYmFpLmVya2lhZ2EtDQo+IGVsb3J6YUBhbWQuY29tPjsgTWljaGFsIFNpbWVrIDxtaWNoYWwu
c2ltZWtAYW1kLmNvbT47IERtaXRyeSBSb2tvc292DQo+IDxkZHJva29zb3ZAc2FsdXRlZGV2aWNl
cy5jb20+OyBKb25hcyBLYXJsbWFuIDxqb25hc0Brd2lib28uc2U+OyBTZWJhc3RpYW4NCj4gUmVp
Y2hlbCA8c2ViYXN0aWFuLnJlaWNoZWxAY29sbGFib3JhLmNvbT47IFdhbmcgSmllIDxkYXZlLndh
bmdAcm9jay0NCj4gY2hpcHMuY29tPjsgTWVuZywgVGluZ3RpbmcgPHRpbmd0aW5nLm1lbmdAaW50
ZWwuY29tPjsgQ2hlZSwgVGllbiBGb25nDQo+IDx0aWVuLmZvbmcuY2hlZUBpbnRlbC5jb20+OyBI
ZWEsIEtvayBLaWFuZyA8a29rLmtpYW5nLmhlYUBpbnRlbC5jb20+OyBOZywNCj4gQm9vbiBLaGFp
IDxib29uLmtoYWkubmdAaW50ZWwuY29tPjsgWXVzbGFpbWksIEFsaWYgWmFrdWFuDQo+IDxhbGlm
Lnpha3Vhbi55dXNsYWltaUBpbnRlbC5jb20+OyBaYW1yaSwgTXVoYW1tYWQgSGF6aW0gSXp6YXQN
Cj4gPG11aGFtbWFkLmhhemltLml6emF0LnphbXJpQGludGVsLmNvbT47IExpbSwgSml0IExvb24N
Cj4gPGppdC5sb29uLmxpbUBpbnRlbC5jb20+OyBUYW5nLCBTaWV1IE11biA8c2lldS5tdW4udGFu
Z0BpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMDIvMTBdIGRyaXZlcnM6IGkzYzog
QWRkIG5ldyBpM2MgdWNsYXNzIGlkDQo+IA0KPiBIaSBEaW5lc2gsDQo+IA0KPiBPbiBNb24sIDE3
IEZlYiAyMDI1IGF0IDE5OjU3LCA8ZGluZXNoLm1hbml5YW1AaW50ZWwuY29tPiB3cm90ZToNCj4g
Pg0KPiA+IEZyb206IERpbmVzaCBNYW5peWFtIDxkaW5lc2gubWFuaXlhbUBpbnRlbC5jb20+DQo+
ID4NCj4gPiBBZGQgaTNjIGdlbmVyYWwgdWNsYXNzIGlkLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogRGluZXNoIE1hbml5YW0gPGRpbmVzaC5tYW5peWFtQGludGVsLmNvbT4NCj4gPiAtLS0NCj4g
PiAgaW5jbHVkZS9kbS91Y2xhc3MtaWQuaCB8IDEgKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2RtL3VjbGFzcy1pZC5o
IGIvaW5jbHVkZS9kbS91Y2xhc3MtaWQuaCBpbmRleA0KPiA+IDI3MDA4OGFkOTQuLjFkMjU5YjQz
OWYgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9kbS91Y2xhc3MtaWQuaA0KPiA+ICsrKyBiL2lu
Y2x1ZGUvZG0vdWNsYXNzLWlkLmgNCj4gPiBAQCAtNzgsNiArNzgsNyBAQCBlbnVtIHVjbGFzc19p
ZCB7DQo+ID4gICAgICAgICBVQ0xBU1NfSTJDX0dFTkVSSUMsICAgICAvKiBHZW5lcmljIEkyQyBk
ZXZpY2UgKi8NCj4gPiAgICAgICAgIFVDTEFTU19JMkNfTVVYLCAgICAgICAgIC8qIEkyQyBtdWx0
aXBsZXhlciAqLw0KPiA+ICAgICAgICAgVUNMQVNTX0kyUywgICAgICAgICAgICAgLyogSTJTIGJ1
cyAqLw0KPiA+ICsgICAgICAgVUNMQVNTX0kzQywgICAgICAgICAgICAgLyogSTNDIGJ1cyAqLw0K
PiA+ICAgICAgICAgVUNMQVNTX0lERSwgICAgICAgICAgICAgLyogSURFIGRldmljZSAqLw0KPiA+
ICAgICAgICAgVUNMQVNTX0lPTU1VLCAgICAgICAgICAgLyogSU9NTVUgKi8NCj4gPiAgICAgICAg
IFVDTEFTU19JUlEsICAgICAgICAgICAgIC8qIEludGVycnVwdCBjb250cm9sbGVyICovDQo+ID4g
LS0NCj4gPiAyLjI2LjINCj4gPg0KPiANCj4gV2hlbiB5b3UgYWRkIGEgbmV3IHVjbGFzcywgcGxl
YXNlIGFkZCBhIHNhbmRib3ggZHJpdmVyIGFuZCBzb21lIHRlc3RzLg0KPiBUaGVyZSBpcyB0aGUg
ZXhpc3RpbmcgaTJjIHRvIGZvbGxvdywgYnV0IHlvdXIgdGVzdHMgbWF5IGJlIHNpbXBsZXIuDQo+
IA0KPiBSZWdhcmRzLA0KPiBTaW1vbg0KDQpUaGFua3MgZm9yIHRoZSByZWZlcmVuY2UsIHdpbGwg
YWRkIHRoZSBzYW5kYm94IGRyaXZlciBhbmQgc2ltcGxlIHRlc3RzIGluIHYyLg0KDQpSZWdhcmRz
DQpEaW5lc2gNCg==
