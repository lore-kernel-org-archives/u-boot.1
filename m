Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78B4C021BE
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 03:07:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1773A80805;
	Wed, 26 Feb 2025 04:07:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="g7IQGGNR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1C828081A; Wed, 26 Feb 2025 04:07:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1E7980786
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 04:07:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740539239; x=1772075239;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=eIJy7rGEuE+ns0IPgJW5+JCA/boH3qVAY7IIoIHb72Y=;
 b=g7IQGGNRyutGytIge6Ul6t81N1NmtRg0KS6PY3Vg+YJTjzlFTEb9m/0h
 nLgVIzxPD1ahthQuSN9XrWBdSBcs/fc3W4GJElVuEXKKC9p9ZO6yj4pjV
 FGx534DMl17WeEYYwZoxOogfimjhfUaLF4RFQb72T9YQdOm5yLvZGWjI8
 qGtl4c7WvsClo/o1LuWRk05pblxsnR76exH1lnFphyf0UEAFFN5tHHpGt
 UXev2e7h15/zmwS+wrp2sPAz7xgh/QaVtTKe4jwNWh4O7DXgAcEaj6ben
 CdixdKEAJ4P6r8MsD13K0uPWtz2ZZh4mVdeoBuo8caTivvPitx2iW9AQ7 w==;
X-CSE-ConnectionGUID: wRa7ivkTTJOKkhE6iER+dw==
X-CSE-MsgGUID: zhaRtE+0SbC9iaNV9WwuVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="52370255"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; d="scan'208";a="52370255"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2025 19:07:15 -0800
X-CSE-ConnectionGUID: W110RpXfQmSs/PCfqY2hxg==
X-CSE-MsgGUID: 8+3Tuv0WSbqWrkfjGraddQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="117064845"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 25 Feb 2025 19:07:16 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 25 Feb 2025 19:07:14 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Feb 2025 19:07:14 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 19:07:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0+Y4yiWSr5w3qyOhX1h6jBGRhcJ7iBrimMmyw2sy9VCCFZg8sdjhLvz4IDEQwCNXsdjkMc3WttH776Ia+qANrtnsEsETvUR1a2qLiYM9Kc0ploZH4OEYXdfBLB2Sm9BEhs6dls4ZYlStIfC70x+5TQKqDPe8x/qftrg8wQhQqufpa0JekRUP5JzmlgVt5yLveJK9nkrUysm+y4EuXgLEvJfaM26hGYQDfy+mpCO50hGXkpTuApCWt5jU8CZyTTx33LDTlO8kXDTHrDbrbnjchfFblTbnCZji/MqpYmHfPHB67PE363JIrIYRNeRthVsCCCpoOOplN+/7NRURyOeNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eIJy7rGEuE+ns0IPgJW5+JCA/boH3qVAY7IIoIHb72Y=;
 b=RTlLFxNzsISQdnSW/O0rCtwLQ6s9xMMM5aCbGXYoOHeSv//COCe688Ybpo7nqd2YQiIxTYL1pZHnYvaC+OUogJsv9LddGY3D6zBHEQO1RpWcpvwO5I4zskW2daAVbaKSNVdxZpt6f+9hofiEVqlAP77JmdRI4wDpYAW7gAh+BcHwLSOQJkQ7dZq92/JofN0/Vsv7FPykwsstNJrfkTkxMRt7NRcQSwClDtK0j6SinNzUcwOOlDmRN5Ig17pgKQnzmgf2FdNk5XNMuEpzNfl0sFL9FKlqjYddBhHrwc5KdtWgpSoTO3TyvsM1pPzJ+bXqE1DbLH+rAH+qdpMuXAEU6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5366.namprd11.prod.outlook.com (2603:10b6:208:31c::17)
 by PH0PR11MB4888.namprd11.prod.outlook.com (2603:10b6:510:32::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 03:06:59 +0000
Received: from BL1PR11MB5366.namprd11.prod.outlook.com
 ([fe80::f073:1e46:c7ee:df9b]) by BL1PR11MB5366.namprd11.prod.outlook.com
 ([fe80::f073:1e46:c7ee:df9b%7]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 03:06:58 +0000
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
Thread-Index: AQHbRvdcQWgz78qVlUqpVYczLsrbnbLj8XAAgAYr1NCANxKuMIAGbQMAgB2B8NCAFEd60A==
Date: Wed, 26 Feb 2025 03:06:58 +0000
Message-ID: <BL1PR11MB53664EEB18F054D076056F2782C22@BL1PR11MB5366.namprd11.prod.outlook.com>
References: <20241205092315.25060-1-dinesh.maniyam@intel.com>
 <CAOf5uwmPuQOsfXFPZ6Y35E5dWq=bYJNtKRRyVv0Md+ugiPFyPA@mail.gmail.com>
 <BL1PR11MB5366537A8281795B152B69AD82042@BL1PR11MB5366.namprd11.prod.outlook.com>
 <BL1PR11MB536639809DBC02823E22549B82E62@BL1PR11MB5366.namprd11.prod.outlook.com>
 <CAOf5uwmP_u49=axD9Hod3aYLDBNn4Wzz4Th7tK+UsFoCEE23Dg@mail.gmail.com>
 <BL1PR11MB5366817B981311E11F8F745682FF2@BL1PR11MB5366.namprd11.prod.outlook.com>
In-Reply-To: <BL1PR11MB5366817B981311E11F8F745682FF2@BL1PR11MB5366.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: michael@amarulasolutions.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5366:EE_|PH0PR11MB4888:EE_
x-ms-office365-filtering-correlation-id: 94e8daa7-9f59-439c-e722-08dd5612a252
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700018|13003099007; 
x-microsoft-antispam-message-info: =?utf-8?B?QWhqdXRKcXVWZVpSaDhSNUpZWVNpTlVJbm5TWk1vWlpGanhiQjF4ME10RUNI?=
 =?utf-8?B?QlNnVldkMitmL3FRZjFHU1dNYUJQZFdKOEFQaThZQW8zc3dNVHRyUjIxRHMz?=
 =?utf-8?B?UU9sZzcvZk1rNStqZmhwS08rVXEva1l6VWwyMEl0eUU1UngxVzMyYXpzSmVC?=
 =?utf-8?B?aTZNaHhNQXp5bzNHTjlNdGFWdmE2bWFodTBVeS9qQlprczBINTVDemdTcUJy?=
 =?utf-8?B?TGExVzc5S0Vuak1xKzNhZk1KbTFwWG9vbXpXZ0p3TWF0OHgwbEc0dzF5V0hm?=
 =?utf-8?B?QU1XTGF5Nk5Obm1Bazd1NS9BSjVRVW9rbCtYaGYvWlJKQzJwbld2Q2xsUkhB?=
 =?utf-8?B?eE83RC85WTFjL0xUQitScW9oV1BBRnkwdFNvZmQrQUJ6Z1ZvY0tOamZ0eTdU?=
 =?utf-8?B?Nzdzd2k3QkIwZ0VqSnVIRUVNekljRDRDaXIwL3VBQlYzZjM2NlVMNEt2VERP?=
 =?utf-8?B?QkZHbE5VcEtKSWs4Zm5ySVB1ZDZ4NjRpRTk0ZDlHNGZzSngxMUR6czRNR2F1?=
 =?utf-8?B?aFFwTlZUSVR1MlBySUU4U0ovUEdxSERIN1ZGeGZRd1N1T1Ivb05mVnpUbFlW?=
 =?utf-8?B?aFEzajRmS0dVZ1VOL3ZIVHZLV1pRTytHc0JlWTBrM0VpRFlOZmxKQmE2L2h0?=
 =?utf-8?B?b0UycU05MXFYL0MzdzMwc2RwYkM0Unp4WlVMRkN5UTM3TU12WnNHYVF1WnNu?=
 =?utf-8?B?WERQL0VRRTF0QlJneDZ3S3MveGd5ZUdPWU1ZMnhpQ1BxNVYyNzc5WWdYS2ht?=
 =?utf-8?B?dzE1VHlrbG1PZktPQlFCeWMzcXg2TDVENXdPR2I1R3c5VU5ZNm9Pa0hQcjQy?=
 =?utf-8?B?bkY2aTFrYllScnZMN1VzcGViai9wdVovMWlhZ1d5b3YxOXBtZHNQSU9WeThi?=
 =?utf-8?B?azZ1VmNQQTkyT1dqNEhGblN6NDBibUl3ZkJKZ01PeFdMdjRHZFQwMDNDYjc3?=
 =?utf-8?B?Und6TEhmMTVXV2RlSThUUTJkWFpqNzFqSEZrSDNNRDYvV2VnYTE0RVptcUpx?=
 =?utf-8?B?MzBJWVpwVm1XOXN5V3BlQ21JNmhRaDJqM3FxOVBNY05hQTNLd0U3WTNXNHRu?=
 =?utf-8?B?OWt4TjFuWEluN1VZdElCZzJFVWloMVdXQzFOdjVTQUVyVk1QYks1bGZ5a3o5?=
 =?utf-8?B?RDNBWm1oVlk4M1NPVE54RTBaeWhJblJXKyt4U2tSeHRWajJLcGJZWDV5RlNr?=
 =?utf-8?B?dVBYUEcxNlRybytwUjA4a1NENmxMdmgyVnMyNWdEMzE3UUVQcjZKQjNWTjNQ?=
 =?utf-8?B?OXJ1dFIxQXROMlVYdk94Q2loZWcySlJ1WEtVMjFkTGcwM2NBYllic1E2MDJ1?=
 =?utf-8?B?U09JY21rRDBsUjF6L3IzenNNekRKS0NHQzQvRVhDUmhISVY5T0hubFVPUkRp?=
 =?utf-8?B?TEoySUZwQndwTnhBOTdvOXFPem01YlVxc2llZEFhMER6aWgyUWtRT254V29h?=
 =?utf-8?B?R2hWVUp0WXk2VlplQnZGeEZYYnRONUxwcWVTblBXZ1BDc0RWbHl6RDVZYXVx?=
 =?utf-8?B?QVBnTThVNm4yK3BFZHAwNFpPcnNjUFh0UkwyS2dxbFRsQzB5blRKczFiL0Ft?=
 =?utf-8?B?K3FvUGlvd0crbHlzc2dkSmVJak85M0ZMZGo2bDZMZ1hxbXpGMnJFVlRFQ3Rh?=
 =?utf-8?B?NkQzcmFNVC9CZmlYWkNXcHF5c0x6MlhkRHRaZHVDWmw1NnJxMGZpWXFEaXlt?=
 =?utf-8?B?OE0zSWM2QkZ4L0dOa1B2QmQ2VnVJM3p6ZWw5UHpWVDZrV0NIUVIzblV0cXdn?=
 =?utf-8?B?VUE5T0xNc01YTWQvclRFRjc0VnRpYkY5ZElSQXUzbUtBR0ZCSnBicDJWUHQx?=
 =?utf-8?B?RWVJRFBnKytzc3VncUpzMHRtUGJoVzRmRFdyQWtMdWNRZGU4Qzk0VjcwRC9v?=
 =?utf-8?Q?o/N/WMcNn+KDc?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR11MB5366.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(13003099007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3ZlZ2wrTVN5TW5XSzAxZ2s4Zm5obUROUmpRQXNBNEpqQXhxc3V5NjNHZFRY?=
 =?utf-8?B?Z1hTTVVXM0cvR29VenEvN2JWcUNnaWtEcC9DTnRIeVI0L0c0Z3QzaUJCeE1p?=
 =?utf-8?B?NnVyUzZTeFVLNXBLNWRDbzN3L0xkSVJHQkdNSEx5RG5vNkZjTTl0ZGxRendz?=
 =?utf-8?B?RU93WVR3UVZsc25GQ0JSc0tQOGlJeGZkVG9DdDAyWHNtKzdzVm5XdmVqeTVk?=
 =?utf-8?B?THlhYi9ydVpJNDg1TCt6RmJIdWNUWU1Lbm50bXFHQzBsV1M0VFZTcDB0R0gz?=
 =?utf-8?B?SFVCTXVyaERXRWRwUmZYY0EzZDBobmczdXhCMmNxdmJQQ0MwdWtKcnU4SzNM?=
 =?utf-8?B?OXRaTVF6anIwQVNKYmVqaUhJQUdGNm1CQTgwYTNrQ21oT01GKzA5S3IvaXlw?=
 =?utf-8?B?OW5XS1B1VFRZMnc3QUw3a1F0ZWFGWWptcHRRakxvMk1OaTBTSFZERDI1RnFq?=
 =?utf-8?B?bytWK2dvMjBNM1F4NDlvQmwxcXZiM3MxMXJWYXY1SDd4MmcwSHJWS1pyeStR?=
 =?utf-8?B?V2xQVHhLMFpTRzJKRmNlRkR1dzU0K016a3d6NEQ3Vk1DRUFrdWlKay9EcHlm?=
 =?utf-8?B?TW9LcU5menJ5VmE0eFVJV1ByRHJNOG4rb2FFUkRjUE1wK29YQVFQYUcvM0pw?=
 =?utf-8?B?bCtoMG1TQ2ZYMDVCQlFpeURuZ1VyUGtBY1p5NnZ0ZHQrMWFGZ1J4NWpkbEE3?=
 =?utf-8?B?VkwzVWdScnFRNzA3ejI4QXVWWVAvYnVudkdGSE9vUFNzRlNoa2R2SFNWODdK?=
 =?utf-8?B?ZUxMdWNhWDNpcHI5UlNaUzVHTUppR1ZZY1kzcWl3TXBweElsei9TQTlSZlk5?=
 =?utf-8?B?SVhLUlRRb05YVjVWVi9rMEdTVzhEQ3lzT3BZUUxaVllFZEZRcnRHRnExMUFF?=
 =?utf-8?B?SVloN1FBc1VmUWJuNkF6RzZmZytTUmZ4K2ZDcWVWcDNmQXg3MmNjWER4NUZG?=
 =?utf-8?B?R0Q5L1RLRFFLQWg1cGl5NjBKaTJweEJPRStQclFWNlc5Q1pGa3lJV2lOQVZI?=
 =?utf-8?B?UXVGRlNVSHFKYUNNWEtteVRjNGFkeEx2c3JyY29PTDU3Zk05MDZLeUZxNHNv?=
 =?utf-8?B?NmxBQlZVdU92bWhFeWRjazl3WnFIeGxKWjhGbHZIaFRVSDFWdVdRajBuOURU?=
 =?utf-8?B?ck8zcjFIN1Q0ZlhUTkZHcEI1QndTdytFdCs5MHpIZXJrSUVuNElLQlk0TE9M?=
 =?utf-8?B?MERFOEIyMnU0YW5tQnZQUFlpRlpXN0R2V2Nvc3RJMnV5TnBtMVdFc0hSM0Ft?=
 =?utf-8?B?QWxpRHdqbmswa2ZOWnNmQWtSWjRnYkVqOC9adlJNRW1JMGs1eHBIQlJVOGFw?=
 =?utf-8?B?blJEZWRMWmtadUk1V0NWT1htV2hZSmtRUDlaUG9mWDlMR1Y5dEVoQnZvd3Ji?=
 =?utf-8?B?K1VTbW84RFdZay9VdnlxUmUyU1BXSXBDQkRxekNCeUhBd0p6OXU2eTgrK1Rr?=
 =?utf-8?B?eUh4aHBmWTV1TDRyb085S2F3b3ZoYWxUdFg5R2o0S1V5c3Q0Y2I0UUpmQ2lG?=
 =?utf-8?B?UEpkd1B5dXhIVFJyMGF6UDN3T0s4ZkJCeWNtN3oya1grSXg1UFdKcU1MUzhN?=
 =?utf-8?B?aDhkdUZ6bnpWQ2k0MkZuZVFISy81clBLeFpiMlVZVEtseDdQSUFveEoycnRI?=
 =?utf-8?B?SWt6N1YrZTZWcFNieHVWWmdna2t4Vm91a1FzT2w0MnBNcXdwelVXM0Y2MGlt?=
 =?utf-8?B?RXJTTmxzRXpjOTg3WFlXdmZPVXFFU3hhNXVOSGtmTjBQZWV3M2lTS242M2RZ?=
 =?utf-8?B?c3ptQ0FobFRXQWs4TnlCREpTQ1lNamg2VlFNZ0JFcjRYOFRRbmYwUkNnM3NP?=
 =?utf-8?B?SklPU1NmUXVGQVhsWTMzRlFyREZ4bDl2SkZYeE1mVDFxbGI5blZPOVNkTStW?=
 =?utf-8?B?R1FnMTByeWszUFhIS1NHRCtNb1d6TWE5UzRmS3J1bVF5b2VJQWlKMHB4dlEz?=
 =?utf-8?B?K2FEUmM2WE9sYy9zSmhacEdVZHZQdjVIYjhkdXpCVFVSRThZVTR0bUN4OUpS?=
 =?utf-8?B?L2l1eUZTTWptZTdZSkxINkR4eDhiUnlYTmtUYWxianpNR2ZBUXhNNVRUZnVP?=
 =?utf-8?B?K3FZYTRjaURRYmFwUXZOYjh5bVB4Snc3SmpvY0JYR2xIeCtVdkp3cTFUcjNR?=
 =?utf-8?Q?XvdtW/EZGYP7NsdiT1mvgcbDr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e8daa7-9f59-439c-e722-08dd5612a252
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 03:06:58.9101 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I5hxnQwj8CcBS7idbmuQ5TyC76eZ1nTaYuQLuvHggSKymtMOlMpegL+N0H3yenSlohu8ibLNISQfA5762Zkw2LEY6byAL47CiaOOCjXXgzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4888
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

SGkgQE1pY2hhZWwgVHJpbWFyY2hpLA0KDQpNYXkgSSBnZXQgdGhlIHJlc3VsdCBvZiB0aGUgQ0kg
dGVzdCwgaG9wZSB5b3UgYWxyZWFkeSBydW4gdGhlIHRlc3QgPw0KUGxlYXNlIHNoYXJlIHRoZSBs
aW5rIG9mIHRoZSBDSSB0ZXN0IHRoYXQgeW91IHJ1biB3aXRoIHRoZSBwYXRjaHNldC4NCkxldCBt
ZSBrbm93IGlmIEkgY2FuIGhlbHAgdG8gc3BlZWQgdXAgdGhlIHJldmlldyBwcm9jZXNzLg0KDQpU
aGFua3MNCkRpbmVzaA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1h
bml5YW0sIERpbmVzaA0KPiBTZW50OiBUaHVyc2RheSwgMTMgRmVicnVhcnkgMjAyNSAxOjE3IHBt
DQo+IFRvOiBNaWNoYWVsIE5henphcmVubyBUcmltYXJjaGkgPG1pY2hhZWxAYW1hcnVsYXNvbHV0
aW9ucy5jb20+DQo+IENjOiB1LWJvb3RAbGlzdHMuZGVueC5kZTsgTWFyZWsgPG1hcmV4QGRlbngu
ZGU+OyBTaW1vbg0KPiA8c2ltb24uay5yLmdvbGRzY2htaWR0QGdtYWlsLmNvbT47IFRvbSBSaW5p
IDx0cmluaUBrb25zdWxrby5jb20+OyBEYXJpbw0KPiBCaW5hY2NoaSA8ZGFyaW8uYmluYWNjaGlA
YW1hcnVsYXNvbHV0aW9ucy5jb20+OyBKb2hhbiBKb25rZXINCj4gPGpieDYyNDRAZ21haWwuY29t
PjsgTWljaGFsIFNpbWVrIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47IEFyc2VuaXkNCj4gS3Jhc25v
diA8YXZrcmFzbm92QHNhbHV0ZWRldmljZXMuY29tPjsgQWxleGFuZGVyIERhaGwgPGFkYUB0aG9y
c2lzLmNvbT47DQo+IFdpbGxpYW0gWmhhbmcgPHdpbGxpYW0uemhhbmdAYnJvYWRjb20uY29tPjsg
SWdvciBQcnVzb3YNCj4gPGl2cHJ1c292QHNhbHV0ZWRldmljZXMuY29tPjsgTWVuZywgVGluZ3Rp
bmcgPHRpbmd0aW5nLm1lbmdAaW50ZWwuY29tPjsNCj4gQ2hlZSwgVGllbiBGb25nIDx0aWVuLmZv
bmcuY2hlZUBpbnRlbC5jb20+OyBIZWEsIEtvayBLaWFuZw0KPiA8a29rLmtpYW5nLmhlYUBpbnRl
bC5jb20+OyBOZywgQm9vbiBLaGFpIDxCb29uLktoYWkuTmdAaW50ZWwuY29tPjsgWXVzbGFpbWks
DQo+IEFsaWYgWmFrdWFuIDxhbGlmLnpha3Vhbi55dXNsYWltaUBpbnRlbC5jb20+OyBaYW1yaSwg
TXVoYW1tYWQgSGF6aW0gSXp6YXQNCj4gPG11aGFtbWFkLmhhemltLml6emF0LnphbXJpQGludGVs
LmNvbT47IExpbSwgSml0IExvb24NCj4gPGppdC5sb29uLmxpbUBpbnRlbC5jb20+OyBUYW5nLCBT
aWV1IE11biA8U2lldS5NdW4uVGFuZ0BpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJFOiBbcmVzZW5k
IHYyIDAwLzE5XSBBZGQgQ2FkZW5jZSBOQU5EIERyaXZlciBzdXBwb3J0DQo+IA0KPiBIaSBNaWNo
YWVsLA0KPiANCj4gRGlkIHlvdSBtYW5hZ2UgdG8gcnVuIHRoZSBDSSB0ZXN0LCBtYXkgSSBrbm93
IHRoZSBzdGF0dXMgPw0KPiANCj4gVGhhbmtzLg0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiA+IEZyb206IE1pY2hhZWwgTmF6emFyZW5vIFRyaW1hcmNoaSA8bWljaGFlbEBh
bWFydWxhc29sdXRpb25zLmNvbT4NCj4gPiBTZW50OiBTYXR1cmRheSwgMjUgSmFudWFyeSAyMDI1
IDY6NDAgcG0NCj4gPiBUbzogTWFuaXlhbSwgRGluZXNoIDxkaW5lc2gubWFuaXlhbUBpbnRlbC5j
b20+DQo+ID4gQ2M6IHUtYm9vdEBsaXN0cy5kZW54LmRlOyBNYXJlayA8bWFyZXhAZGVueC5kZT47
IFNpbW9uDQo+ID4gPHNpbW9uLmsuci5nb2xkc2NobWlkdEBnbWFpbC5jb20+OyBUb20gUmluaSA8
dHJpbmlAa29uc3Vsa28uY29tPjsNCj4gPiBEYXJpbyBCaW5hY2NoaSA8ZGFyaW8uYmluYWNjaGlA
YW1hcnVsYXNvbHV0aW9ucy5jb20+OyBKb2hhbiBKb25rZXINCj4gPiA8amJ4NjI0NEBnbWFpbC5j
b20+OyBNaWNoYWwgU2ltZWsgPG1pY2hhbC5zaW1la0BhbWQuY29tPjsgQXJzZW5peQ0KPiA+IEty
YXNub3YgPGF2a3Jhc25vdkBzYWx1dGVkZXZpY2VzLmNvbT47IEFsZXhhbmRlciBEYWhsDQo+ID4g
PGFkYUB0aG9yc2lzLmNvbT47IFdpbGxpYW0gWmhhbmcgPHdpbGxpYW0uemhhbmdAYnJvYWRjb20u
Y29tPjsgSWdvcg0KPiA+IFBydXNvdiA8aXZwcnVzb3ZAc2FsdXRlZGV2aWNlcy5jb20+OyBNZW5n
LCBUaW5ndGluZw0KPiA+IDx0aW5ndGluZy5tZW5nQGludGVsLmNvbT47IENoZWUsIFRpZW4gRm9u
ZyA8dGllbi5mb25nLmNoZWVAaW50ZWwuY29tPjsNCj4gPiBIZWEsIEtvayBLaWFuZyA8a29rLmtp
YW5nLmhlYUBpbnRlbC5jb20+OyBOZywgQm9vbiBLaGFpDQo+ID4gPGJvb24ua2hhaS5uZ0BpbnRl
bC5jb20+OyBZdXNsYWltaSwgQWxpZiBaYWt1YW4NCj4gPiA8YWxpZi56YWt1YW4ueXVzbGFpbWlA
aW50ZWwuY29tPjsgWmFtcmksIE11aGFtbWFkIEhhemltIEl6emF0DQo+ID4gPG11aGFtbWFkLmhh
emltLml6emF0LnphbXJpQGludGVsLmNvbT47IExpbSwgSml0IExvb24NCj4gPiA8aml0Lmxvb24u
bGltQGludGVsLmNvbT47IFRhbmcsIFNpZXUgTXVuIDxzaWV1Lm11bi50YW5nQGludGVsLmNvbT4N
Cj4gPiBTdWJqZWN0OiBSZTogW3Jlc2VuZCB2MiAwMC8xOV0gQWRkIENhZGVuY2UgTkFORCBEcml2
ZXIgc3VwcG9ydA0KPiA+DQo+ID4gSGkgRGluZXNoDQo+ID4NCj4gPiBPbiBUdWUsIEphbiAyMSwg
MjAyNSBhdCA5OjM54oCvQU0gTWFuaXlhbSwgRGluZXNoDQo+ID4gPGRpbmVzaC5tYW5peWFtQGlu
dGVsLmNvbT4NCj4gPiB3cm90ZToNCj4gPiA+DQo+ID4gPiBIaSBNaWNoYWVsLA0KPiA+ID4NCj4g
PiA+IEFueSB1cGRhdGUgb24gbXkgTkFORCBwYXRjaHNldCA/LiBJIGNhbiBzZWUgaXQgaXMgc3Rp
bGwgdW5kZXIgcmV2aWV3Lg0KPiA+ID4gSXMgdGhlcmUgYW55dGhpbmcgSSBjYW4gZG8gZnJvbSBt
eSBzaWRlIHRvIHNwZWVkIHVwIHRoZSByZXZpZXcgcHJvY2Vzcz8NCj4gPiA+IFRoYW5rcyBmb3Ig
eW91ciB0aW1lLg0KPiA+ID4NCj4gPg0KPiA+IFdlbGwsIGxhc3QgdGltZSB3YXMgbm90IHBhYXNz
aW5nIHRoZSBDSS4gSSB3aWxsIHRlc3QgaXQgYWdhaW4gdG9kYXkNCj4gPg0KPiA+IE1pY2hhZWwN
Cj4gPg0KPiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gPiBGcm9tOiBN
YW5peWFtLCBEaW5lc2gNCj4gPiA+ID4gU2VudDogVHVlc2RheSwgMTcgRGVjZW1iZXIgMjAyNCAz
OjQxIHBtDQo+ID4gPiA+IFRvOiBNaWNoYWVsIE5henphcmVubyBUcmltYXJjaGkgPG1pY2hhZWxA
YW1hcnVsYXNvbHV0aW9ucy5jb20+DQo+ID4gPiA+IENjOiB1LWJvb3RAbGlzdHMuZGVueC5kZTsg
TWFyZWsgPG1hcmV4QGRlbnguZGU+OyBTaW1vbg0KPiA+ID4gPiA8c2ltb24uay5yLmdvbGRzY2ht
aWR0QGdtYWlsLmNvbT47IFRvbSBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+Ow0KPiA+ID4gPiBE
YXJpbyBCaW5hY2NoaSA8ZGFyaW8uYmluYWNjaGlAYW1hcnVsYXNvbHV0aW9ucy5jb20+OyBKb2hh
biBKb25rZXINCj4gPiA+ID4gPGpieDYyNDRAZ21haWwuY29tPjsgTWljaGFsIFNpbWVrIDxtaWNo
YWwuc2ltZWtAYW1kLmNvbT47IEFyc2VuaXkNCj4gPiA+ID4gS3Jhc25vdiA8YXZrcmFzbm92QHNh
bHV0ZWRldmljZXMuY29tPjsgQWxleGFuZGVyIERhaGwNCj4gPiA+ID4gPGFkYUB0aG9yc2lzLmNv
bT47IFdpbGxpYW0gWmhhbmcgPHdpbGxpYW0uemhhbmdAYnJvYWRjb20uY29tPjsNCj4gPiA+ID4g
SWdvciBQcnVzb3YgPGl2cHJ1c292QHNhbHV0ZWRldmljZXMuY29tPjsgTWVuZywgVGluZ3RpbmcN
Cj4gPiA+ID4gPHRpbmd0aW5nLm1lbmdAaW50ZWwuY29tPjsgQ2hlZSwgVGllbiBGb25nDQo+ID4g
PiA+IDx0aWVuLmZvbmcuY2hlZUBpbnRlbC5jb20+OyBIZWEsIEtvayBLaWFuZw0KPiA+ID4gPiA8
a29rLmtpYW5nLmhlYUBpbnRlbC5jb20+OyBOZywgQm9vbiBLaGFpIDxCb29uLktoYWkuTmdAaW50
ZWwuY29tPjsNCj4gPiA+ID4gWXVzbGFpbWksIEFsaWYgWmFrdWFuIDxhbGlmLnpha3Vhbi55dXNs
YWltaUBpbnRlbC5jb20+OyBaYW1yaSwNCj4gPiA+ID4gTXVoYW1tYWQgSGF6aW0gSXp6YXQgPG11
aGFtbWFkLmhhemltLml6emF0LnphbXJpQGludGVsLmNvbT47IExpbSwNCj4gPiA+ID4gSml0IExv
b24gPGppdC5sb29uLmxpbUBpbnRlbC5jb20+OyBUYW5nLCBTaWV1IE11bg0KPiA+ID4gPiA8U2ll
dS5NdW4uVGFuZ0BpbnRlbC5jb20+DQo+ID4gPiA+IFN1YmplY3Q6IFJFOiBbcmVzZW5kIHYyIDAw
LzE5XSBBZGQgQ2FkZW5jZSBOQU5EIERyaXZlciBzdXBwb3J0DQo+ID4gPiA+DQo+ID4gPiA+DQo+
ID4gPiA+DQo+ID4gPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+ID4gPiBG
cm9tOiBNaWNoYWVsIE5henphcmVubyBUcmltYXJjaGkgPG1pY2hhZWxAYW1hcnVsYXNvbHV0aW9u
cy5jb20+DQo+ID4gPiA+ID4gU2VudDogRnJpZGF5LCAxMyBEZWNlbWJlciAyMDI0IDU6MTYgcG0N
Cj4gPiA+ID4gPiBUbzogTWFuaXlhbSwgRGluZXNoIDxkaW5lc2gubWFuaXlhbUBpbnRlbC5jb20+
DQo+ID4gPiA+ID4gQ2M6IHUtYm9vdEBsaXN0cy5kZW54LmRlOyBNYXJlayA8bWFyZXhAZGVueC5k
ZT47IFNpbW9uDQo+ID4gPiA+ID4gPHNpbW9uLmsuci5nb2xkc2NobWlkdEBnbWFpbC5jb20+OyBU
b20gUmluaQ0KPiA+ID4gPiA+IDx0cmluaUBrb25zdWxrby5jb20+OyBEYXJpbyBCaW5hY2NoaQ0K
PiA+ID4gPiA+IDxkYXJpby5iaW5hY2NoaUBhbWFydWxhc29sdXRpb25zLmNvbT47IEpvaGFuIEpv
bmtlcg0KPiA+ID4gPiA+IDxqYng2MjQ0QGdtYWlsLmNvbT47IE1pY2hhbCBTaW1layA8bWljaGFs
LnNpbWVrQGFtZC5jb20+Ow0KPiA+ID4gPiA+IEFyc2VuaXkgS3Jhc25vdiA8YXZrcmFzbm92QHNh
bHV0ZWRldmljZXMuY29tPjsgQWxleGFuZGVyIERhaGwNCj4gPiA+ID4gPiA8YWRhQHRob3JzaXMu
Y29tPjsgV2lsbGlhbSBaaGFuZyA8d2lsbGlhbS56aGFuZ0Bicm9hZGNvbS5jb20+Ow0KPiA+ID4g
PiA+IElnb3IgUHJ1c292IDxpdnBydXNvdkBzYWx1dGVkZXZpY2VzLmNvbT47IE1lbmcsIFRpbmd0
aW5nDQo+ID4gPiA+ID4gPHRpbmd0aW5nLm1lbmdAaW50ZWwuY29tPjsgQ2hlZSwgVGllbiBGb25n
DQo+ID4gPiA+ID4gPHRpZW4uZm9uZy5jaGVlQGludGVsLmNvbT47IEhlYSwgS29rIEtpYW5nDQo+
ID4gPiA+ID4gPGtvay5raWFuZy5oZWFAaW50ZWwuY29tPjsgTmcsIEJvb24gS2hhaQ0KPiA+ID4g
PiA+IDxib29uLmtoYWkubmdAaW50ZWwuY29tPjsgWXVzbGFpbWksIEFsaWYgWmFrdWFuDQo+ID4g
PiA+ID4gPGFsaWYuemFrdWFuLnl1c2xhaW1pQGludGVsLmNvbT47IFphbXJpLCBNdWhhbW1hZCBI
YXppbSBJenphdA0KPiA+ID4gPiA+IDxtdWhhbW1hZC5oYXppbS5penphdC56YW1yaUBpbnRlbC5j
b20+OyBMaW0sIEppdCBMb29uDQo+ID4gPiA+ID4gPGppdC5sb29uLmxpbUBpbnRlbC5jb20+OyBU
YW5nLCBTaWV1IE11bg0KPiA+ID4gPiA+IDxzaWV1Lm11bi50YW5nQGludGVsLmNvbT4NCj4gPiA+
ID4gPiBTdWJqZWN0OiBSZTogW3Jlc2VuZCB2MiAwMC8xOV0gQWRkIENhZGVuY2UgTkFORCBEcml2
ZXIgc3VwcG9ydA0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSGkNCj4gPiA+ID4gPg0KPiA+ID4gPiA+
IE9uIFRodSwgRGVjIDUsIDIwMjQgYXQgMTA6MjPigK9BTSA8ZGluZXNoLm1hbml5YW1AaW50ZWwu
Y29tPiB3cm90ZToNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBGcm9tOiBEaW5lc2ggTWFuaXlh
bSA8ZGluZXNoLm1hbml5YW1AaW50ZWwuY29tPg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFRo
aXMgcGF0Y2hzZXQgYWRkIENhZGVuY2UgTkFORCBkcml2ZXIgc3VwcG9ydCBmb3IgSW50ZWwNCj4g
PiA+ID4gPiA+IEFnaWxleDUgZGV2aWNlcy4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBUaGUg
TkFORCBkcml2ZXIgaXMgbGV2ZXJhZ2VkIGZyb20gdGhlDQo+ID4gPiA+ID4gPiBjYWRlbmNlLW5h
bmQtY29udHJvbGxlci5jIGZyb20gTGludXggdmVyc2lvbiA2LjExLjIuIFUtQm9vdA0KPiA+ID4g
PiA+ID4gd2lsbCBzdXBwb3J0IHJlYWQsIHdyaXRlIGFuZCBlcmFzZSBOQU5EIHdpdGggQ2FkZW5j
ZSBkcml2ZXIuDQo+ID4gPiA+ID4gPiBUaGUgZHJpdmVyIGZ1cnRoZXIgZW5oYW5jZWQgaW4gVS1C
b290IHRvIHN1cHBvcnQgTkFORCBib290aW5nDQo+ID4gPiA+ID4gPiBmcm9tIEZTQkwgYW5kIHN1
cHBvcnQgYm9vdCB0byBrZXJuZWwgdmlhDQo+ID4gVUJJRlMuDQo+ID4gPiA+ID4gPg0KPiA+ID4g
PiA+ID4gUGF0Y2ggc3RhdHVzOg0KPiA+ID4gPiA+ID4gSGF2ZSBjaGFuZ2VzOiBBbGwgcGF0Y2hl
cyBleHBlY3QgUGF0Y2ggMTkNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBEZXRhaWwgY2hhbmdl
bG9nIGNhbiBmaW5kIGluIGNvbW1pdCBtZXNzYWdlLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+
IHYxLT52MjoNCj4gPiA+ID4gPiA+IC0tLS0tLS0tDQo+ID4gPiA+ID4gPiBQYXRjaCAxIC0gMTg6
DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gLSByZW1vdmUgdGhlICJ0aGlzIHBhdGNoIGlzIHRv
IiBjb21taXQgcGhyYXNlcw0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFBhdGNoIDQ7DQo+ID4g
PiA+ID4gPiAtIG1pbm9yIHJlZmFjdG9yaW5nIG9mIGNvZGUgdG8gbWF0Y2ggdGhlIHN0YWJsZSB2
ZXJzaW9uIDYuMTEuMi4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBQYXRjaCAxNDoNCj4gPiA+
ID4gPiA+IC0gQWRkIG1haW50YWluZXIgYW5kICIjaW5jbHVkZSIgbWVjaGFuaXNtIGZvciBuZXcg
dmFyaWFudA0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFBhdGNoIDE2Og0KPiA+ID4gPiA+ID4g
LSBsZXZlcmFnZSB0aGUgZXhpc3RpbmcgbmFuZF9zcGxfbG9hZF9pbWFnZQ0KPiA+ID4gPiA+ID4N
Cj4gPiA+ID4gPg0KPiA+ID4gPiA+IEkgaGF2ZSB0cmllZCB0byBidWlsZCBidXQgaXQgZG9lcyBu
b3Qgd29yay4gSGF2ZSB5b3UgdGVzdGVkIGluIGdpdGh1Yj8NCj4gPiA+ID4gPg0KPiA+ID4gPiA+
IE1pY2hhZWwNCj4gPiA+ID4NCj4gPiA+ID4gWWV0IHRvIGRlcGxveSBnaXRodWIgdGVzdCBvbiBv
dXIgY3VycmVudCBwbGF0Zm9ybS4NCj4gPiA+ID4gT25seSBjaGVja3BhdGNoLnBsIGFuZCBsb2Nh
bCBidWlsdCBoYXMgYmVlbiB1c2VkIGFzIGEgbWV0cmljIGZvcg0KPiA+ID4gPiBlYWNoIGNvbW1p
dCBiZWZvcmUgc3VibWlzc2lvbi4NCj4gPiA+ID4gQW5kLCBhbGwgdGhlc2UgY29tbWl0cyBhcmUg
cGFydCBvZiB0aGUgZmlybXdhcmUgY3VycmVudGx5IHJ1bm5pbmcNCj4gPiA+ID4gb24gcmVhbCBo
YXJkd2FyZS4NCj4gPiA+ID4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gSGlzdG9yeToNCj4gPiA+
ID4gPiA+IC0tLS0tLS0tDQo+ID4gPiA+ID4gPiBbdjFdOg0KPiA+ID4gPiA+ID4gaHR0cHM6Ly9w
YXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L3Vib290L2NvdmVyLzIwMjQwOTE5MDM1NTEyLg0K
PiA+ID4gPiA+ID4gMTM4NQ0KPiA+ID4gPiA+ID4gNC0NCj4gPiA+ID4gPiA+IDEtZGluZXNoLm1h
bml5YW1AaW50ZWwuY29tLw0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IERpbmVzaCBNYW5peWFt
ICgxOSk6DQo+ID4gPiA+ID4gPiAgIGR0OiBuYW5kOiBhZGQgY2FkZW5jZSBuYW5kIGR0LWJpbmRp
bmdzDQo+ID4gPiA+ID4gPiAgIGFybTogZHRzOiBhZ2lsZXg1OiBFbmFibGVkIGNkbnMtbmFuZCBk
dHMgc2V0dGluZw0KPiA+ID4gPiA+ID4gICBpbmNsdWRlOiBhc206IEFkZCBzdXBwb3J0IHRvIHJl
YWQvd3JpdGUgNjQtYml0DQo+ID4gPiA+ID4gPiAgIGRyaXZlcnM6IG10ZDogbmFuZDogQWRkIGRy
aXZlciBmb3IgQ2FkZW5jZSBOYW5kDQo+ID4gPiA+ID4gPiAgIGRyaXZlcnM6IG10ZDogbmFuZDog
Y2FkZW5jZTogQWRkIHN1cHBvcnQgZm9yIHJlYWQgc3RhdHVzIGNvbW1hbmQNCj4gPiA+ID4gPiA+
ICAgZHJpdmVyczogbXRkOiBuYW5kOiBjYWRlbmNlOiBBZGQgc3VwcG9ydCBmb3IgcmVhZGlkIGNv
bW1hbmQNCj4gPiA+ID4gPiA+ICAgZHJpdmVyczogbXRkOiBuYW5kOiBjYWRlbmNlOiBBZGQgc3Vw
cG9ydCBmb3IgTkFORF9DTURfUEFSQU0NCj4gPiA+ID4gPiA+ICAgZHJpdmVyczogbXRkOiBuYW5k
OiBjYWRlbmNlOiBBZGQgc3VwcG9ydCBmb3IgTkFORF9DTURfUkVTRVQNCj4gPiA+ID4gPiA+ICAg
ZHJpdmVyczogbXRkOiBuYW5kOiBjYWRlbmNlOiBTdXBwb3J0IGNtZCBTRVRfRkVBVFVSRVMgJg0K
PiA+IEdFVF9GRUFUVVJFUw0KPiA+ID4gPiA+ID4gICBkcml2ZXJzOiBtdGQ6IG5hbmQ6IGNhZGVu
Y2U6IEZsdXNoICYgaW52YWxpZGF0ZSBkbWEgZGVzY3JpcHRvcg0KPiA+ID4gPiA+ID4gICBkcml2
ZXJzOiBtdGQ6IG5hbmQ6IGNhZGVuY2U6IFBvbGwgZm9yIGRlc2MgY29tcGxldGUgc3RhdHVzDQo+
ID4gPiA+ID4gPiAgIGRyaXZlcnM6IG10ZDogbmFuZDogY2FkZW5jZTogVXNlIGJvdW5jZSBidWZm
ZXINCj4gPiA+ID4gPiA+ICAgZHJpdmVyczogbmFuZDogRW5hYmxlZCBLY29uZmlnIGFuZCBNYWtl
ZmlsZSBmb3IgY2Rucy1uYW5kDQo+ID4gPiA+ID4gPiAgIGNvbmZpZ3M6IG5hbmQyX2RlZmNvbmZp
ZzogRW5hYmxlIGNvbmZpZ3MgZm9yIG5hbmQgYm9vdA0KPiA+ID4gPiA+ID4gICBkcml2ZXJzOiBt
dGQ6IG5hbmQ6IGJhc2U6IEFkZCBzdXBwb3J0IGZvciBIYXJkd2FyZSBFQ0MgZm9yIGNoZWNrIGJh
ZA0KPiA+ID4gPiA+ID4gICAgIGJsb2NrDQo+ID4gPiA+ID4gPiAgIGRyaXZlcnM6IG10ZDogbmFu
ZDogc3BsOiBBZGQgc3VwcG9ydCBmb3IgbmFuZCBTUEwgbG9hZCBpbWFnZQ0KPiA+ID4gPiA+ID4g
ICBkcml2ZXJzOiBtdGQ6IG5hbmQ6IEVuYWJsZWQgS2NvbmZpZyBhbmQgTWFrZWZpbGUgZm9yIENh
ZGVuY2UtU1BMDQo+ID4gPiA+ID4gPiAgIGRyaXZlcnM6IG10ZDogbmFuZDogS2NvbmZpZzogUmVt
b3ZlIFNZU19OQU5EX0JMT0NLX1NJWkUNCj4gPiBkZXBlbmRlbmN5DQo+ID4gPiA+ID4gPiAgIGRy
aXZlcnM6IG10ZDogbmFuZDogS2NvbmZpZzogRW5hYmxlZCBzZWxmLWluaXQgZm9yIGNkbnMtbmFu
ZA0KPiA+ID4gPiA+ID4gU1BMDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gIGFyY2gvYXJtL2R0
cy9zb2NmcGdhX2FnaWxleDUuZHRzaSAgICAgICAgICAgICB8ICAgMTQgKw0KPiA+ID4gPiA+ID4g
IC4uLi9hcm0vZHRzL3NvY2ZwZ2FfYWdpbGV4NV9zb2Nkay11LWJvb3QuZHRzaSB8ICAgMjggKw0K
PiA+ID4gPiA+ID4gIGFyY2gvYXJtL2luY2x1ZGUvYXNtL2lvLmggICAgICAgICAgICAgICAgICAg
ICB8ICAgMjUgKw0KPiA+ID4gPiA+ID4gIGJvYXJkL2ludGVsL2FnaWxleDUtc29jZGsvTUFJTlRB
SU5FUlMgICAgICAgICB8ICAgIDIgKw0KPiA+ID4gPiA+ID4gIGNvbmZpZ3Mvc29jZnBnYV9hZ2ls
ZXg1X25hbmQyX2RlZmNvbmZpZyAgICAgICB8ICAgMzMgKw0KPiA+ID4gPiA+ID4gIC4uLi9tdGQv
Y2FkZW5jZSxuYW5kLnlhbWwgICAgICAgICAgICAgICAgICAgICB8ICAgOTggKw0KPiA+ID4gPiA+
ID4gIGRyaXZlcnMvbXRkL25hbmQvcmF3L0tjb25maWcgICAgICAgICAgICAgICAgICB8ICAgMTkg
Ky0NCj4gPiA+ID4gPiA+ICBkcml2ZXJzL210ZC9uYW5kL3Jhdy9NYWtlZmlsZSAgICAgICAgICAg
ICAgICAgfCAgICAyICsNCj4gPiA+ID4gPiA+ICBkcml2ZXJzL210ZC9uYW5kL3Jhdy9jYWRlbmNl
X25hbmQuYyAgICAgICAgICAgfCAyNDI0DQo+ID4gKysrKysrKysrKysrKysrKysNCj4gPiA+ID4g
PiA+ICBkcml2ZXJzL210ZC9uYW5kL3Jhdy9jYWRlbmNlX3NwbC5jICAgICAgICAgICAgfCAgIDU5
ICsNCj4gPiA+ID4gPiA+ICBkcml2ZXJzL210ZC9uYW5kL3Jhdy9uYW5kX2Jhc2UuYyAgICAgICAg
ICAgICAgfCAgIDcxICstDQo+ID4gPiA+ID4gPiAgaW5jbHVkZS9jYWRlbmNlLW5hbmQuaCAgICAg
ICAgICAgICAgICAgICAgICAgIHwgIDUyOSArKysrDQo+ID4gPiA+ID4gPiAgaW5jbHVkZS9saW51
eC9tdGQvcmF3bmFuZC5oICAgICAgICAgICAgICAgICAgIHwgICAxNCArDQo+ID4gPiA+ID4gPiAg
MTMgZmlsZXMgY2hhbmdlZCwgMzI5MyBpbnNlcnRpb25zKCspLCAyNSBkZWxldGlvbnMoLSkgIGNy
ZWF0ZQ0KPiA+ID4gPiA+ID4gbW9kZQ0KPiA+ID4gPiA+ID4gMTAwNjQ0IGNvbmZpZ3Mvc29jZnBn
YV9hZ2lsZXg1X25hbmQyX2RlZmNvbmZpZw0KPiA+ID4gPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0
NA0KPiA+ID4gPiA+ID4gZG9jL2RldmljZS10cmVlLWJpbmRpbmdzL210ZC9jYWRlbmNlLG5hbmQu
eWFtbA0KPiA+ID4gPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL210ZC9uYW5kL3Jh
dy9jYWRlbmNlX25hbmQuYw0KPiA+ID4gPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJz
L210ZC9uYW5kL3Jhdy9jYWRlbmNlX3NwbC5jDQo+ID4gPiA+ID4gPiAgY3JlYXRlIG1vZGUgMTAw
NjQ0IGluY2x1ZGUvY2FkZW5jZS1uYW5kLmgNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiAtLQ0K
PiA+ID4gPiA+ID4gMi4xOS4wDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4NCj4g
PiA+ID4gPiAtLQ0KPiA+ID4gPiA+IE1pY2hhZWwgTmF6emFyZW5vIFRyaW1hcmNoaQ0KPiA+ID4g
PiA+IENvLUZvdW5kZXIgJiBDaGllZiBFeGVjdXRpdmUgT2ZmaWNlciBNLiArMzkgMzQ3IDkxMyAy
MTcwDQo+ID4gPiA+ID4gbWljaGFlbEBhbWFydWxhc29sdXRpb25zLmNvbQ0KPiBfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBBbWFydWxhIFNv
bHV0aW9ucyBCVg0KPiA+ID4gPiA+IEpvb3AgR2Vlc2lua3dlZyAxMjUsIDExMTQgQUIsIEFtc3Rl
cmRhbSwgTkwgVC4gKzMxICgwKTg1IDExMQ0KPiA+ID4gPiA+IDkxNzIgaW5mb0BhbWFydWxhc29s
dXRpb25zLmNvbSB3d3cuYW1hcnVsYXNvbHV0aW9ucy5jb20NCj4gPg0KPiA+DQo+ID4NCj4gPiAt
LQ0KPiA+IE1pY2hhZWwgTmF6emFyZW5vIFRyaW1hcmNoaQ0KPiA+IENvLUZvdW5kZXIgJiBDaGll
ZiBFeGVjdXRpdmUgT2ZmaWNlcg0KPiA+IE0uICszOSAzNDcgOTEzIDIxNzANCj4gPiBtaWNoYWVs
QGFtYXJ1bGFzb2x1dGlvbnMuY29tDQo+ID4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXw0KPiA+DQo+ID4gQW1hcnVsYSBTb2x1dGlvbnMgQlYNCj4gPiBKb29wIEdlZXNpbmt3ZWcg
MTI1LCAxMTE0IEFCLCBBbXN0ZXJkYW0sIE5MIFQuICszMSAoMCk4NSAxMTEgOTE3Mg0KPiA+IGlu
Zm9AYW1hcnVsYXNvbHV0aW9ucy5jb20gd3d3LmFtYXJ1bGFzb2x1dGlvbnMuY29tDQo=
