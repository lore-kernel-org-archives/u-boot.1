Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C918CF9C6B
	for <u-boot@archiver.kernel.org>; Tue, 24 Sep 2024 07:30:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68A4D88113;
	Tue, 24 Sep 2024 09:30:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="eQMWkejv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 417FB88363; Tue, 24 Sep 2024 09:30:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BAB588113
 for <u-boot@lists.denx.de>; Tue, 24 Sep 2024 09:30:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1727163027; x=1758699027;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=KcwnQFqKzBREs0fWySyKtp/69no18zAwc3IPr3CW/w8=;
 b=eQMWkejvysBIZYQnf0E8WARC4U2s67DZv+XhRm3Nl8ewPYVeFpKmSMm2
 5wEsGxKX0cgacRkTo/sKWJovIakAZlj9AS1SdJS8SWt+83b6dHhxwTwVX
 e0fYt6LTf2LzY4cwPjtvk2aiWXKLWBpTDrzgacIBe+OgCdkynlRhYDar/
 25xTIkHdlUAvB92YB0rUB9d0SjGo15tcW2QQDv2eL9mhOfM71VQmW2BiE
 1ml1WKFnfRMTMtWZZleZzKfvRPEAIJVA8Z2CPXkcN8s6bVkfmyrHtxfrZ
 XK2QR8gq/Q1OiUlk7gMKUQ+tIeafE/xLQkNRjcHt/xlO5j1N0Rg9NTjpy g==;
X-CSE-ConnectionGUID: MmK+DD1GSy29hQAxRcnSIQ==
X-CSE-MsgGUID: o7lIqFWKTcyKc96hdKCdbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="43658009"
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; d="scan'208";a="43658009"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2024 00:30:24 -0700
X-CSE-ConnectionGUID: BJ8Q3EF2ShuDgO1g9NMl0g==
X-CSE-MsgGUID: xFeXr9Z2TvqlQpL14pBQTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; d="scan'208";a="75852465"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 24 Sep 2024 00:30:23 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 00:30:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 00:30:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 00:30:22 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Sep 2024 00:30:22 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Sep 2024 00:30:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rfEbVm9u91BytzTItQUbw/GO3Ifg5OWUz33A/YxxRHdovjQIelCL9mF+zq2e3X13++t6m0ksVlwLvQdR7eehONxnEhTr3NeUIc4pTeU9V87QlTmSthFg2IcI3NI5YoMbQS5T63qE4cEDiY/zezA2lDkjkj9sROZWT7r5EmopzlurmnSPMwXkksC2D6pkqqwMjH3eXRSJQQeScrfIKikyqj/oUrOx4p4o5MfbiemAJmbqzUop+oSFBI7aPvhDh1y+A/0o/Ry0KT0XTAjIe2/hrcGeq8beXelV64C4+lidaMFhQVTG9+qafonY6Z4ly8CfHprE5tEevyAndJ1UqiBblQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KcwnQFqKzBREs0fWySyKtp/69no18zAwc3IPr3CW/w8=;
 b=OFLc71zAHwrjNEyhqDb3EgX/OA8yh3/a2hhDAFsCQpFcxrltxTMW9z1TWF9t+WVTCDZ4gnAuAJN1U9gJq/75kJaT3q6BEymtyHpk8S/xGr02TuQ7fX9VShM9aFa2jn10XitEhqeH3LklJc70bQjpUMdg5IYrn6RO59Y/pZZjLUhAXmgZXamrSwR/qM3Du9XarY0WVtlajpRaQ+odK4jHJ7NVV6QjAwuX/JCuYdTZ8DZ5+kvv8eJLzMTUTatjDsjqgOSOEyxmT0X8FJu4hgJVi7PLVLFDnPUvpVz0aULd/b+LzpsBQhK0uxkB2kDIxbwza9/QrefsXcw8R0C4+Ri1rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 BY1PR11MB8006.namprd11.prod.outlook.com (2603:10b6:a03:52d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Tue, 24 Sep
 2024 07:30:20 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe%5]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 07:30:20 +0000
From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, "Meng, Tingting"
 <tingting.meng@intel.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@intel.com>, "Hea, Kok Kiang" <kok.kiang.hea@intel.com>
Subject: RE: [PATCH v1 13/20] arm: socfpga: Export board ID as U-Boot
 environment variable
Thread-Topic: [PATCH v1 13/20] arm: socfpga: Export board ID as U-Boot
 environment variable
Thread-Index: AQHbCys9FWvd2cU2dUOFjgqu7143kbJiRRIAgARLsKA=
Date: Tue, 24 Sep 2024 07:30:20 +0000
Message-ID: <DM8PR11MB5592FDF77DDA601DFC2B92B6D2682@DM8PR11MB5592.namprd11.prod.outlook.com>
References: <20240920070242.20884-1-tien.fong.chee@intel.com>
 <20240920070242.20884-14-tien.fong.chee@intel.com>
 <e25d4ca8-16cc-4309-8814-ca4437ee86fc@denx.de>
In-Reply-To: <e25d4ca8-16cc-4309-8814-ca4437ee86fc@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|BY1PR11MB8006:EE_
x-ms-office365-filtering-correlation-id: 49fdf301-6c66-4217-6d78-08dcdc6abe8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VHJhVTA2RWJhMTJ1MHBkZ2poa3dDc3V0cGhvMkFnYTZEaGVKQ29vVnhHNCt1?=
 =?utf-8?B?TS85Sld1VjZaWlFQNFNmQmQrRFdwTTFTK1UxUlE1Zmk2NTRNTDJCbDlyMFNM?=
 =?utf-8?B?Y3ZZMitFc3ovRmtseGJoYjhCd1NsaXFUdjZ5OEtzSnVFc0dkbFgyVEJlMVJX?=
 =?utf-8?B?Wm53SnB5NW55MzdScFBkaHMyQ3ZvS3g2QzhBbXFMU1dCVGh2T2oyTWErbGg0?=
 =?utf-8?B?eHFqRXhXaWxHdC95cFZGTGZnOFBtanRPcGlCY0p6K1ZySW9JNUtDQTdPNUI0?=
 =?utf-8?B?OGdxVjVoL2RrT0hUekZPRXZqU1pQMlZFb0ZqWmkvb0pQRDZxQ3gzM0IwSGZ3?=
 =?utf-8?B?RkxnYXdzNldsMnZGVlVSdFY3RTZWZ1NYR2JkVCtWUENlMHBHQjNxOTIxWk9W?=
 =?utf-8?B?SXM2WHpPSlI3UWtMQWI3R2xxNHFRSWhSSEpldHRlWWxuQ0NZcWJDSGlBZW1Q?=
 =?utf-8?B?OUJNK3dHbldhNXByRnR3V1lpaUFvUGI3OWNVcXRNL2kwWHhRZ1NOUm5DeDdp?=
 =?utf-8?B?MHQvNmJCbU9OMS95eHR4WHdiRURsdDFicHJrbVZjcWZKbGdsR2taVUhmS2tT?=
 =?utf-8?B?THZ4YmdPSDdyOEdoYisxaUlscFg1T0RDQjBCYVp5Q1d2Wm1Mdk9YMkVWQ0VI?=
 =?utf-8?B?Y0dDTk5pUXNMeHJBWnJaZUxvbjgyTGNWQ2IwWDViSGsybzIzMWNmVWFRTXpu?=
 =?utf-8?B?ZzRraTRxSXhOeUhBZzZIWHJUU0lPNFpxTHpjVElkRk5DNVQ2RXVRNVY5enJB?=
 =?utf-8?B?c05KYnVoY3dtWWVBNkpWQlJNV3V3MFRWVE1HZWdWc2FicU5OL3d3dVlHdjdk?=
 =?utf-8?B?bmxpTjdaVTZJdTlhMHpha1RZcDh0VmFNMnNpNnp2MU1yZzA1NVRhQ1VTRnNz?=
 =?utf-8?B?Tm1yTTM3MnZSN3RkeUhtdFFUZW5vYWt2dzMwSkRXVTNBVGM2akZrK05uVkx5?=
 =?utf-8?B?WGZTOGxEcVJIRVJyMnNIVm5VbjQxVlR5RFVFd3IyRjZpYUJPc0phZkRuc2tr?=
 =?utf-8?B?eEF1UFQyWkFMbi8zUWZSVFNpYnZVbUNYeTYrWFh0T09GcXdJZ3lRSzRTc2p0?=
 =?utf-8?B?dGdVMHROVEpqWE1jZ3lhSUNyYmxnN2tZaHZlRFJSSC9TN09rUC82bUc2OTZ0?=
 =?utf-8?B?NVRZUjBZY3VPRTIvSzl0L1MxamREZUdPekp3QXY2VDZaWEhTWU41SVNKbFlj?=
 =?utf-8?B?SGUwbHYrNCsyYklBcUtlOWtsM2VydGRSbHJXRXFLdDROalhEYWpQdHNZaEhT?=
 =?utf-8?B?M3o2b2JhbFpuYmFxMGpOYWVEaVA0dDdTRUJlZTJvWVJCVVM1eWI1SXVzR09J?=
 =?utf-8?B?ZVBuaDJuUTJMcUJTUjdnVG5KYWNRTW5DWUs5RzRJd1VpSng4RFNBOGg2RFZ6?=
 =?utf-8?B?eWw5enp5dUdsVTE5UkxwbUJCU2pSbHRzcEtHcDZtblJYaFpPRkdYWnhNMDU1?=
 =?utf-8?B?QkkwZlZreUZEV1BHaHhQZTl3ZGlrdkxxMWxaT0JNOU5hUU8xSGhXSG9QdUFn?=
 =?utf-8?B?ckI3OXNoNklZME5sN05zayt6NmV0OVl0d3UwY3MwcXlKc2JjdDE3WDVLSU5G?=
 =?utf-8?B?Z1pHaFhvRVBhY0N4ZDArT3g5YTQzT1JibHRkeG5ISmpxR0JLYURPaUI0Sy85?=
 =?utf-8?B?RzdjK08rT0VyL1QrMy9uUThMbXRPUnlhU1AzNks1akZmUzNROWRrdm9DQzNH?=
 =?utf-8?B?bVNIWHoyMlRuTHdveGlwa3FrbkFJend4WkI2UFZORU00RktaUllvNDgwaUh3?=
 =?utf-8?B?cUl3VHg0Skc5NlY2MTM3ZnNRL05wa09hYU02U2J0ekZwWWdQQUIzcDRaR0NS?=
 =?utf-8?B?SjI4WExHemx0eHJUQ3I0UT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5592.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHVBMDBBSEpQUE55eGczZXc2NGZEdmhrT3pRZ0w2RXFhMmwxMlFKUFViUmwv?=
 =?utf-8?B?Vnk3UE1TZXNNeHdpbzA1TDI0QTlzZ0htdFloNGo1OCtPVnB0cS8vSm5mNzJa?=
 =?utf-8?B?QkUvYVBLZVZPeGJXNXFjdWErMG40UjF6WHdPMW1XTGt1QlRXM3FkVjJQdGpR?=
 =?utf-8?B?RXBBVm5KV2NrYjJ0WGcyNHJmaERhRGdVdzlLajJRSUhLVHZqTURkRUpuYjBl?=
 =?utf-8?B?SEV4dDRCaGo5OW93czVKYjNiWDVtNzA4ZmE0QkFMQzJUd0dPemdib0JRM0Ra?=
 =?utf-8?B?ZDBLeEU4T0NNbGxFL2tWOWVOeW9NZnBLc3k2dVQ5WmZvWXlRa1JsUkdxR0pV?=
 =?utf-8?B?NmtyUGZiZVpFcEFmdTB6WXRqaHJCV3dSRUxXbVlta254R1RrZUVxZXhobFc5?=
 =?utf-8?B?anlFR0cvbjRnUDg5S1FQR3FMZGx5TGtrVkFyUGwxYVpiS3FwSHhscFhxb2J0?=
 =?utf-8?B?U1h5bk5yMW9ZU3VMUFJKbXJKOXA5NGd4ajR2eS9jWVY1M3R2YVg0WjNhd01m?=
 =?utf-8?B?K2VOaE0rYjNjZXlmRkgrVk9hdHIrU1c1WUQzbG9HRVl5U01UYWtzQ2dIRWtt?=
 =?utf-8?B?SGFtMTFpNXhFUE16cmUyM2dUSG1lOUk0VXhFVEJtTTc0MTVPTnJvOFpsUFdE?=
 =?utf-8?B?eU00ZG5yRWZienBDN0tRT1dQT0djUnhzZmdyRU1BRittMFltdGkwdzJOYWpI?=
 =?utf-8?B?cWxIYlRoUFpxT2cvWTRaNkFrdmhHSzFlYW9iRnZ5WStjK0NUOFFBMEZIT2pv?=
 =?utf-8?B?ZkppTWhRb29JaVl5S2pwYWVtdmY4dW1uRHJyczBUSE04UHBzaXBqdVFxcGtu?=
 =?utf-8?B?UUdMV2pETFdhYUdYZnhxZ3Y3L0YvTWdVdmJnTTdHODM5c1hRcXp2SXJLOTVh?=
 =?utf-8?B?RXVqNGErZVp5cUFRUjlRSGVYeU82aTd6cWxzZVRMeFpZM1Vuc28wd2RQbGxk?=
 =?utf-8?B?L1pCSjNucEJNbmcrSG8xTGNYZE00Q2pDbG9pVUNKelhFOTRja3pKL3ZtbmtI?=
 =?utf-8?B?OTIvUkhrcVZUY2t0ay91SDhXSHlud3RnYXhocGFKWEp2WkplcVNUdmttUjJh?=
 =?utf-8?B?OVNXUUphYVRydXIwV1JTbVFML2RxYXZUeXJPcXR4blNVS1N0elpIckRhbyto?=
 =?utf-8?B?NUZUK0ZKdHFrQkxkK3RlNzF3MURmSFhnMnpJZ3NRR1h5T05WSXlpdm80TlBx?=
 =?utf-8?B?ekw2eWpkUWtTMmZ3a0E5akxJR0JOSFU0NWN2Mkg3aHlRNUJadEdxbVN2akdR?=
 =?utf-8?B?LzhGbk1vcWloZVl5Y1RiN2VCb0NTdHhjNzkrbjQ4emViWUFTN21jQmQ5cW9R?=
 =?utf-8?B?NEpLb3RrTEVIWlZxTGVMWFdFVXl0djNDa1lDQXFWcWFUQWc3c1VpTXA1TVB0?=
 =?utf-8?B?cWJGdWFCUVFidjRha1RJekdkVTcvendzRUdkT0lUUGNoYURVWE03cDZZMXRy?=
 =?utf-8?B?YmloeERiM0dST2NPL2JKdGR3Sk5hR3lPZ2M0T1Q3VHliYzNhWXM5SWxRWHoy?=
 =?utf-8?B?MWYyenZjUE1GVjFNNFFZbVIxTStXUEtZZG1ramhhN2tXaUtROHk3cW1DRGZj?=
 =?utf-8?B?VXo0ditWTE9WUXYwa0FJVkpuczkxS1d3MFdBUEVMNmYyWlpIWForK1gxN2Zp?=
 =?utf-8?B?UnpjdWRITVFjTkczc24wMUw1WEVUUU9hT05jZWdabERyejFmSmtLMDJZTkYv?=
 =?utf-8?B?YWVVTitVVWlCK2lXejM5Q2pGUHJQT3pZVUVyNEhhZnVFY3NoYmdZMDRHUXJP?=
 =?utf-8?B?azh2NzhTTUpXNFlUYU9MNHduZngvclVJdzdoWE5XNnZrOElXdzl1WFlHeWQr?=
 =?utf-8?B?VDVwTFhXdjJudlZTcko1ZTVlekNQVFE3S0tadG1TOHJpT2VZdmMwT1dJajhr?=
 =?utf-8?B?YmJrbFdweGQ3NjBXUWU1Q0ZkRTdIM0pSQ2lGQzBGdkgvNmYzbktGUnRaU3VZ?=
 =?utf-8?B?MjF0bGpBdUowODQvd1ptcThRMjFTeWhSaHNMeitSdFpsMWpUN2ZUaXRJbUFv?=
 =?utf-8?B?c2JwN3IrS2M2MXd4dlNZK2hCMDFvc3IxUjZkdjJlN2FCMnBNY0xVTzhSSmtH?=
 =?utf-8?B?aE4wbW0zbmYrN09EU29lMGtwZDI3cWUrVDZQbGFVV1hDeWsrSGR0WW1kbkxE?=
 =?utf-8?Q?CN0nlBzigZGN54enUJiZ8HWZ4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49fdf301-6c66-4217-6d78-08dcdc6abe8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 07:30:20.0872 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: poAxpLSraQs5DCvTyln9wtNQG48dvK9oUQdjMriRi75JxwU+LoEJaNN/QaOpkLg98sNgo4ycflNwbw2PEI+9qhXSS8l4jkPipVVnkSyHWfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8006
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
PG1hcmV4QGRlbnguZGU+DQo+IFNlbnQ6IFNhdHVyZGF5LCBTZXB0ZW1iZXIgMjEsIDIwMjQgOTo1
NCBQTQ0KPiBUbzogQ2hlZSwgVGllbiBGb25nIDx0aWVuLmZvbmcuY2hlZUBpbnRlbC5jb20+OyB1
LWJvb3RAbGlzdHMuZGVueC5kZQ0KPiBDYzogU2ltb24gR29sZHNjaG1pZHQgPHNpbW9uLmsuci5n
b2xkc2NobWlkdEBnbWFpbC5jb20+OyBNZW5nLCBUaW5ndGluZw0KPiA8dGluZ3RpbmcubWVuZ0Bp
bnRlbC5jb20+OyBZdXNsYWltaSwgQWxpZiBaYWt1YW4NCj4gPGFsaWYuemFrdWFuLnl1c2xhaW1p
QGludGVsLmNvbT47IEhlYSwgS29rIEtpYW5nDQo+IDxrb2sua2lhbmcuaGVhQGludGVsLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAxMy8yMF0gYXJtOiBzb2NmcGdhOiBFeHBvcnQgYm9h
cmQgSUQgYXMgVS1Cb290DQo+IGVudmlyb25tZW50IHZhcmlhYmxlDQo+IA0KPiBPbiA5LzIwLzI0
IDk6MDIgQU0sIHRpZW4uZm9uZy5jaGVlQGludGVsLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBUaWVu
IEZvbmcgQ2hlZSA8dGllbi5mb25nLmNoZWVAaW50ZWwuY29tPg0KPiA+DQo+ID4gQm9hcmQgSUQg
aXMgZXhwb3J0ZWQgYXMgZW52aXJvbm1lbnQgdmFyaWFibGUgZm9yIHVzZSB0byBib290IExpbnV4
DQo+ID4gd2l0aCBGSVQgY29uZmlndXJhdGlvbi4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFRp
ZW4gRm9uZyBDaGVlIDx0aWVuLmZvbmcuY2hlZUBpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gICBh
cmNoL2FybS9tYWNoLXNvY2ZwZ2EvaW5jbHVkZS9tYWNoL21pc2MuaCB8IDEgKw0KPiA+ICAgYXJj
aC9hcm0vbWFjaC1zb2NmcGdhL21pc2Nfc29jNjQuYyAgICAgICAgfCA1ICsrKysrDQo+ID4gICAy
IGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJtL21hY2gtc29jZnBnYS9pbmNsdWRlL21hY2gvbWlzYy5oDQo+ID4gYi9hcmNoL2FybS9t
YWNoLXNvY2ZwZ2EvaW5jbHVkZS9tYWNoL21pc2MuaA0KPiA+IGluZGV4IDg0NjBhY2IwMGQ5Li5l
NjJiZWEwMTdiMCAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybS9tYWNoLXNvY2ZwZ2EvaW5jbHVk
ZS9tYWNoL21pc2MuaA0KPiA+ICsrKyBiL2FyY2gvYXJtL21hY2gtc29jZnBnYS9pbmNsdWRlL21h
Y2gvbWlzYy5oDQo+ID4gQEAgLTUyLDUgKzUyLDYgQEAgdm9pZCBzZXRfcmVndWxhcl9ib290KHVu
c2lnbmVkIGludCBzdGF0dXMpOw0KPiA+ICAgdm9pZCBzb2NmcGdhX3BsMzEwX2NsZWFyKHZvaWQp
Ow0KPiA+ICAgdm9pZCBzb2NmcGdhX2dldF9tYW5hZ2Vyc19hZGRyKHZvaWQpOw0KPiA+ICAgaW50
IHFzcGlfZmxhc2hfc29mdHdhcmVfcmVzZXQodm9pZCk7DQo+ID4gK3U4IHNvY2ZwZ2FfZ2V0X2Jv
YXJkX2lkKHZvaWQpOw0KPiA+DQo+ID4gICAjZW5kaWYgLyogX1NPQ0ZQR0FfTUlTQ19IXyAqLw0K
PiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLXNvY2ZwZ2EvbWlzY19zb2M2NC5jDQo+ID4g
Yi9hcmNoL2FybS9tYWNoLXNvY2ZwZ2EvbWlzY19zb2M2NC5jDQo+ID4gaW5kZXggOTVlMWMwN2Uz
OWYuLmUzNGM1NDUxOGEzIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtL21hY2gtc29jZnBnYS9t
aXNjX3NvYzY0LmMNCj4gPiArKysgYi9hcmNoL2FybS9tYWNoLXNvY2ZwZ2EvbWlzY19zb2M2NC5j
DQo+ID4gQEAgLTYwLDEwICs2MCwxNSBAQCBpbnQgcHJpbnRfY3B1aW5mbyh2b2lkKQ0KPiA+ICAg
aW50IGFyY2hfbWlzY19pbml0KHZvaWQpDQo+ID4gICB7DQo+ID4gICAJY2hhciBxc3BpX3N0cmlu
Z1sxM107DQo+ID4gKwljaGFyIGlkWzNdOw0KPiA+DQo+ID4gICAJc3ByaW50Zihxc3BpX3N0cmlu
ZywgIjwweCUwOHg+IiwgY21fZ2V0X3FzcGlfY29udHJvbGxlcl9jbGtfaHooKSk7DQo+ID4gICAJ
ZW52X3NldCgicXNwaV9jbG9jayIsIHFzcGlfc3RyaW5nKTsNCj4gPg0KPiA+ICsJLyogRXhwb3J0
IGJvYXJkX2lkIGFzIGVudmlyb25tZW50IHZhcmlhYmxlICovDQo+ID4gKwlzcHJpbnRmKGlkLCAi
JXUiLCBzb2NmcGdhX2dldF9ib2FyZF9pZCgpKTsNCj4gPiArCWVudl9zZXQoImJvYXJkX2lkIiwg
aWQpOw0KPiBlbnZfc2V0X3Vsb25nKCkNCg0KT0ssIHdlIHdpbGwgY2hhbmdlIGl0Lg0KDQpSZWdh
cmRzLA0KVGllbiBGb25nDQo=
