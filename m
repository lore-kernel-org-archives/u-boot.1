Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABBF3CF9C6C
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 06:06:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1F5E8897F;
	Wed, 25 Sep 2024 08:06:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="jwhHSUyw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 352B988B0C; Wed, 25 Sep 2024 08:06:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E7AB8897F
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 08:06:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1727244375; x=1758780375;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=uaU87mr2l1bfwilffahMGjPDlnTSyZGDq3r3I377qWo=;
 b=jwhHSUywQEOrOTdvPfoFFnnxd9XfaXtqrj/QnviYxsTDnhayNE94fTTG
 SEcyLuhI8GqLZ2riBR1GUlWLK6fGRsc6O4LkZ9YfLXPpW4Glp4ea9fko8
 spWNeMEjTffYK1xYEBRxxG0ab2ZFa/YkyhNBwilcHRisWmxWnCP6fyJQo
 Hzb8V8m09y+coUxXkjULTngrbKhwL85nuYuabfSwjTQUwWbL43yVQdTdO
 zZDpGPcABll+UE0QYvUkDzEOzmNy3VWnVj5RzLcUB82eSTTyVvpD2FksA
 SANz9abvzexCnIIROQWBZF0+Sbv5VKtLzp4EseioDaUTdjLRlwJd6QZ7e g==;
X-CSE-ConnectionGUID: 60s+vwF0RjCumM43toPqBQ==
X-CSE-MsgGUID: HJGMd4lSQXORLc30bRn0Kg==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="43792361"
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; d="scan'208";a="43792361"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2024 23:06:08 -0700
X-CSE-ConnectionGUID: 2IMgKAiiSAmYbMKelL5lbA==
X-CSE-MsgGUID: qSgYc+dgRmiQ5ZgtjKzaLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; d="scan'208";a="109122226"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 24 Sep 2024 23:06:07 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 23:06:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 23:06:06 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Sep 2024 23:06:06 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Sep 2024 23:06:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4lLmEBBTrBx0yNt3gJMirfx7A8hmCMgOvrfSqk9zpkiDDclUdyurSvH9UuuZ4XltB1/yQKmgxQwKTa6Q1vN/SaLu4xznU54gZq93V4lSEyyWICo+t4lnb/QybDA+G7L7EwJRmyaFyIkoS/Cy1f3wbtJjOAcB6Qa6c2aBOSUh1WiAn29A/qeAu2UHymiBflYrm0fXpOCbKiREhUqhB9E0iOsvZ9szvvN0qzM58MDBEF7h7ReZKtHxw9tJjAs4hjc8j3urAs98EfxbS4Nvjzw+aO/awN9Oy4aqhT7hZ0b+SgjTlVg/WbS4xKE6eQwmOCKWciqzYirrDPQrCCX1HJw/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uaU87mr2l1bfwilffahMGjPDlnTSyZGDq3r3I377qWo=;
 b=getykn9r2BN8RtX9ea4T08XGMWE07qdqWKFA3VdbqtoSieDXdXirrCMhpYJOjP8gBoj46gM8mXnzhS6jQbGz8R00g8X40JdWXZFp8gshtc7MBPYdCfcZX4gJ8hSzF2Hdi//oH8NjWP70fpvTvmm+tUZ3cfPC58oV+c8Xle4L58/FZObFVG7f1Lnx6nB2cuhcWiEUIdEJlDQhxbDHi59B3Tz01CbzIQCEdcxf7uEIAxn7ueJ9DYpJWv/HrhohIdRYrtFduTqd1qDSibLhOedk4lOibile18nUfJARIIkTwZRp2MvwDUT+7L/rTf0HlpB/f9ABEMdcNsTojxYakr4IZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 SA1PR11MB6759.namprd11.prod.outlook.com (2603:10b6:806:25e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Wed, 25 Sep
 2024 06:06:04 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe%5]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 06:06:04 +0000
From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, "Meng, Tingting"
 <tingting.meng@intel.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@intel.com>, "Hea, Kok Kiang" <kok.kiang.hea@intel.com>
Subject: RE: [PATCH v1 03/20] linker: Add SPL linker script for SoC64 devices
Thread-Topic: [PATCH v1 03/20] linker: Add SPL linker script for SoC64 devices
Thread-Index: AQHbCys436r47VSYzkSeBHU6d0cYMLJiQ5AAgAQwerCAANa7AIAAv/aw
Date: Wed, 25 Sep 2024 06:06:04 +0000
Message-ID: <DM8PR11MB55925249D5D10BE76135201BD2692@DM8PR11MB5592.namprd11.prod.outlook.com>
References: <20240920070242.20884-1-tien.fong.chee@intel.com>
 <20240920070242.20884-4-tien.fong.chee@intel.com>
 <858854ad-bebb-4199-bd8f-a5807a2144dd@denx.de>
 <DM8PR11MB55923CF1E2F876C6EB68FC9BD2682@DM8PR11MB5592.namprd11.prod.outlook.com>
 <4f7c1b66-7ed1-4333-beb7-345639a3ff2b@denx.de>
In-Reply-To: <4f7c1b66-7ed1-4333-beb7-345639a3ff2b@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|SA1PR11MB6759:EE_
x-ms-office365-filtering-correlation-id: dfe2d0b2-d37d-47a9-a6e8-08dcdd282362
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?c1V5NS9kODlkTVhBVlpCUm1URE9mek5HeGlNdUZVSVhOcWJIYjNjZWhUZHY3?=
 =?utf-8?B?d2hiaUhMMGRZVUU3bHpNZi8weGJ5M0c0WVJZRHp0TmJxb0pYcWRBTWF6cHNK?=
 =?utf-8?B?dndIK1QvMEt1TmRvOXgzTW5ETytQeEludGsvSXZhMjIxZUROL0g5a3d1Z0w0?=
 =?utf-8?B?L3lUbWd4Ykk3NVJwNUZGcE1CUjQrbGFObDNQdVdHYS84U283Q1NnbXNqVEtz?=
 =?utf-8?B?RDNFcFFoVk83aEZucmQrZVU0N3lJK2xGZzAxWFdqVzc3cE55bVRxV2d1S2tm?=
 =?utf-8?B?em55UGJHKzBtUE1kOERwUEJpYVluWDJSL01MaktkK2lLWFZZYTFyY3ZJcVYr?=
 =?utf-8?B?QkRVZGM5SEdOWnEzRmpiZlVTNUg0ei9PaXBFOERXVDhZbW9IUjZPZFpHcWpw?=
 =?utf-8?B?T3A0ZGFHN3FtZFNZaEZ4cU5uMllmKzB3cS83d05CQVpCcmpBY1FVemMrZzlq?=
 =?utf-8?B?SmhZUHJuQUdLQ2NyS3ovT1JNU1ZiNVVZQjVzZVFKT1NlakZnNGQyS2Q1M3Zl?=
 =?utf-8?B?VFVCSGo5djhuSzE4MVN6MEE1S2xwSEFaR0dwQmQzUWNSdWxOVEEzaUhyOFI4?=
 =?utf-8?B?akZmbWxjOEp4QTdHRWI1WWdUZ1BORUtqdUY3cVV1TndOblNkTXlKbHJzdDZT?=
 =?utf-8?B?WmtYbmNLMHdiVTFrTzZkNEFtai8xN05DdUdtMEhmMkMzV3RLUDBzeEVGV2dS?=
 =?utf-8?B?cUs5TmJJQWxmK3hWcnZoUXpNemoySDQ3MUw5NXJYczlndFNsTjBjdUhSUzJ4?=
 =?utf-8?B?YWp2eWNwLzF3M1k3UnJYUmZpSlFhL2ZRcnRFczZvNkh0NnE3Y3BnNkEzUkhz?=
 =?utf-8?B?Z2tkMVZoc3ZNYkVFM3ZBQi8xNXMvbFNxWkxlWnEwZ0haNjAwRGhWM0I5Uy9Q?=
 =?utf-8?B?a0pycnBxUHRWRTE0bmtqVUQ1NW85UnljZEJYWUJSVkoxTlBQbnVvVlNOdHhy?=
 =?utf-8?B?Z2tGWVoxczBtb211cWFvZE9LcWlTWjl5eDcvL2dMbTdtenJLR2xMWWdnTjAw?=
 =?utf-8?B?T3hENHR0RGFrbVFTZVJvQjYzMHZzSE5CSExaZTZPcE1PZk9FeE02Z3cvQnB1?=
 =?utf-8?B?Vkg5dHJtVVByVldRbk5kd2R3ZnE4d2VHaVFrSUtLZjFoTGZnUVpsa3lFSFA2?=
 =?utf-8?B?cGIxeW12WTd2R2ZkYWNvc011Uk5JQ1B5S1YyWVdqbmJYSGx6Nk9FMVFxOC9B?=
 =?utf-8?B?QThzNllzNSsxcEQzb2NlcjY2aldJbDl0VFJnTk0rZURPbU1FTFZPRURCMGxY?=
 =?utf-8?B?bG9VdXYxdGFRVk9JS1hlOTcyWTEyV3VmL1dxcU04QndFcks3SGhPa09LYWhV?=
 =?utf-8?B?Vk83N3ZhUVhGQXQweGhCMytLKzlVOTMreEJ1WWRYZHc5WkxoUmVKQk0xdzJi?=
 =?utf-8?B?Ky9HMmZZQlZpcnQ3OFNhalhsRmEzZzgwN3lrcGNZeG9UQmJBaDA2cUdmWHRs?=
 =?utf-8?B?MjhDd0NGczFVT2ZWRW1pS01lRlluOS9LRzJzUDRBOFdlSDJtTGJRditFOXpN?=
 =?utf-8?B?K2RCRUw4aU5ONHNBaUR0VEkxbzZrdDVvNlgya3pWYUliZEFKQWlhdTUxSGxt?=
 =?utf-8?B?NUhkNkwrUWNYZkdmNzVUcmFUajIwUEVSWWtRQS9pUmE3RUNWYnJOaUVKVnVK?=
 =?utf-8?B?QWc5cWtiMWVuNGIzMGxuWkFkdlZyZG96cUs3UXIySzRrYytucndNODFSbEty?=
 =?utf-8?B?TTdpU0FxeFhKdkpUdWFHYTJKeHRVWEFWS3lRb3k2bjdESmxQdkhSL0s2S3Bn?=
 =?utf-8?B?RVdtMUhaWlN1YWZQWnFGK0FxSUF4UitnemFOY09DYWN5aTJuZ3ltTUpOVU1U?=
 =?utf-8?B?T0hYaEg1TXpxY0VUOW8vZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5592.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVZoNHdtdnZ4aDJOQzFQcVF6dEhVT0VzODJESXl1V0FvWHFoZjNsWFlRNEg0?=
 =?utf-8?B?Qml4UGt3OUEyZUhYZ21MM3QwVFl0VEc5Y1RFaEUrVlU2QUNZQnVNYzdGZm9k?=
 =?utf-8?B?Z0JwL0lZVXFxZSszQVF3eVczSzJzQy83RkhFcWZGRklVK0tXWUgrUkh0SnBH?=
 =?utf-8?B?d3Z4WkFab1Y5cDBhcDNvbVpibDF3dGQ0Vkp2TVdYZ2MwcjFPMHRKVzJnMmt0?=
 =?utf-8?B?dXJJeUYwTzE1NkxLSUlCSTVHbVgrcDY0eEdlSVMzUlRXN0VNZUUwTk5McU9o?=
 =?utf-8?B?d2k4dWJFTjVDMzRJMjd4M25RNG1sYXRzWER1NGZCakJoYWlJV1NhQThLVkNw?=
 =?utf-8?B?QWpGdkhuOFNuOWl5NTlMTm5BdlNqUG1ianp1UzBvWUErVXpmNXVFaXFKdkNK?=
 =?utf-8?B?dFcxb2R4Wi8zZkFaVWJNNXVUTDdQY255THhMUjcvVjhyZkVJbE8zV0xlOHRz?=
 =?utf-8?B?ZEIvS1ZOR0NNSVl1UGEwWmVQN2pacUJTcy9tWmRUajRpblBhOGZpYjJiODJM?=
 =?utf-8?B?Q1J3OFptRTl1ZFNsTWhla0pyaWh3bnV5VE1Pb2t5WVpoY3ZtK1lwZVNSaHV2?=
 =?utf-8?B?MzErbEFyZkFmaWZhUnZ3b3V6dWNZeVdCV0t2aGIwa3QzcmdqWEpBNC9qZzNT?=
 =?utf-8?B?eTFRbW1TK0ZPUHVoR1Vkd1lTQzJ2eUNGdG9rOW9lUVYzb3RZQ1E3MkNtM2FL?=
 =?utf-8?B?RlBaUEZuSEJ3bk9SVEVGOFF3S2VWMmlVNTFSVmo4eEpOWG1NeXcyYXdTdXlo?=
 =?utf-8?B?TjZNQTVHQVJjMnUvWXJhQU5tQjZBMTZSQkN2N3F6NThqM2Z2MlErUnk1Mjc2?=
 =?utf-8?B?OXc5MFZUR0M1U1VPaGhLSHh6aWxET3dibWxOd1haRGxWR0gzRGpCYW1SRnZm?=
 =?utf-8?B?Z2pBQ0QzNXBMU1lsYWFqMmpSVVBMWGhEdk82cDc1NXUwZ2JZWTBxNmZuOXVl?=
 =?utf-8?B?UGY3VFVVa2xXLysram1YK2hocmVLeXROZ3pjWWdJNFpmYnB6K05uOXBnN0RR?=
 =?utf-8?B?VmdLcXJ3Y2o3SndiTExGWmM5cm5DRU5WUnM2ZWJSbzN1QTRxemlhV2NoQ1JQ?=
 =?utf-8?B?aWEwNEpCakNVckRqZ2sveU9tbS9FdzVEd0ZGUFBTQldockJPekk4Y3Jucm9w?=
 =?utf-8?B?NERUSE9pVitpaHkrbnpQK2YxcmJkV3VTOVBKckQwbnZSOVdwK2p3aC8vU2Q3?=
 =?utf-8?B?KzRzRkZNL0hPRzJpWGVNNXNaTXpKTUxRMmF1S2hSZkZaYlJOOStXYnhGZDJH?=
 =?utf-8?B?K3l4L2VzNWpHWXo1OFZKSURmOUIyS21aYW16cURONVdlME5qNnZ2OGZoWWkx?=
 =?utf-8?B?Z2NOM0g0L0Nqdms5RGhldFRUVjVuaE5zSzhDMVdFOWtwdTF1NU0vYkIrdWtX?=
 =?utf-8?B?ZS84aTY4N1IxQ2poTDg0aFJ4U01vemNaOHowNzA5MlVXengwczh1c1lGdmRj?=
 =?utf-8?B?eFpLNTVkQmpibEV3U0pKSlpkMHNMSit2UlF0S2E1eDJJSndXRDJ0VFNBV093?=
 =?utf-8?B?cTBvdE9YWEZLMU9RN2IrNDhTV3N6U1QwRUZ0YnNLQ25TSk8vZUpKS3B6S0hD?=
 =?utf-8?B?bGQ1THpWYzgzZW9qSWs4QUU1RnV6eUgxeGVFc2VPakE1eXZaU0xDZzNBRWJi?=
 =?utf-8?B?NjlNUHJRUlh5Z2poMXpxQW5tNVltTmtGVkpRUnc5L1BmcjhFd1ZCb21CTko4?=
 =?utf-8?B?QVZDN0VKMEZTNWJpV3VrZmJwK0JyaXJNVnpYTEs1a3Y1NFo3eUZxSCszNlV2?=
 =?utf-8?B?NjlkT0JlcjRZN3I4SHJtVU1iZ3ZLMVZEbEpwOHdab0RkMVN5L1hTUnRMdmlI?=
 =?utf-8?B?dEV6b0xwTUhFMkhUS21YVmQwR1ptbExsOTJEdExNenNvUXlMTkViU1VuQUls?=
 =?utf-8?B?aVFaOHJFU1gxNmM0RlpBNHY0VG55Y3VhVmIzTnRXM2JEWEdPNjBYcXVadkY1?=
 =?utf-8?B?Q05XR2JIT1lPZDZxTXdHd1BoaGEvSXh0Zy9ucHVpa0VhTHNCbVE2aTZLL01F?=
 =?utf-8?B?Ui9JaDQ1eXdCWmxLN2xhNFZYRm4xaHEvQXVCM2xNTHlHUnduMTdMdmYyQ21V?=
 =?utf-8?B?TVBiZTNnbWZyUFdTRTJxd21SRFhEbFEwakZzNTZ5SXlxc2pIRXNFdjltOWZU?=
 =?utf-8?Q?N4+QLn0AvPkzM56Git6lGjBfK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfe2d0b2-d37d-47a9-a6e8-08dcdd282362
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 06:06:04.1513 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iJfl3r5kF04wuy2iVV3m58EmuoMvTYxf28rf5Y6dW5ng1Ff1hSEGISKgASA6H7U4C4o0KC/DhdVKq76vRgnjWZxkjTl9SwBiahfGU/up5ZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6759
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
MzYgQU0NCj4gVG86IENoZWUsIFRpZW4gRm9uZyA8dGllbi5mb25nLmNoZWVAaW50ZWwuY29tPjsg
dS1ib290QGxpc3RzLmRlbnguZGUNCj4gQ2M6IFNpbW9uIEdvbGRzY2htaWR0IDxzaW1vbi5rLnIu
Z29sZHNjaG1pZHRAZ21haWwuY29tPjsgTWVuZywgVGluZ3RpbmcNCj4gPHRpbmd0aW5nLm1lbmdA
aW50ZWwuY29tPjsgWXVzbGFpbWksIEFsaWYgWmFrdWFuDQo+IDxhbGlmLnpha3Vhbi55dXNsYWlt
aUBpbnRlbC5jb20+OyBIZWEsIEtvayBLaWFuZw0KPiA8a29rLmtpYW5nLmhlYUBpbnRlbC5jb20+
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDMvMjBdIGxpbmtlcjogQWRkIFNQTCBsaW5rZXIg
c2NyaXB0IGZvciBTb0M2NCBkZXZpY2VzDQo+IA0KPiBPbiA5LzI0LzI0IDc6NDggQU0sIENoZWUs
IFRpZW4gRm9uZyB3cm90ZToNCj4gDQo+IEhpLA0KPiANCj4gPj4+IEFkZCBhIG5ldyAuZGF0YSBz
ZWN0aW9uIGZvciBwcmVzZXJ2aW5nIHRoZSBvcmlnaW5hbCBzdGF0ZSBvZiB0aGUNCj4gPj4+IC5k
YXRhIHNlY3Rpb24gb2YgU29DNjQgU1BMLiBUaGlzIG5ldyAuZGF0YSBzZWN0aW9uIGlzIHJlcXVp
cmVkIHRvDQo+ID4+PiBtYWtlIFNQTCByZWVudHJhbnQgYWZ0ZXIgd2FybSByZXNldC4NCj4gPj4g
V2hlcmUgaXMgdGhlIGxpbmtlciBzY3JpcHQgY29waWVkIGZyb20gPyBXaGF0IGlzIHRoZSBvcmln
aW5hbCBmaWxlDQo+ID4+IG5hbWUgYW5kIHBhdGggPw0KPiA+DQo+ID4gSSB0aGluayB0aGUgc2Ny
aXB0IGlzIGNvcGllZCBmcm9tIGFyY2gvYXJtL2NwdS9hcm12OC91LWJvb3Qtc3BsLmxkcyAuDQo+
IENhbiBhcmNoL2FybS9jcHUvYXJtdjgvdS1ib290LXNwbC5sZHMgYmUgZXh0ZW5kZWQgc29tZWhv
dyBpbnN0ZWFkICwgb3INCj4gYXJlIHRoZXJlIHRvbyBtYW55IGRpZmZlcmVuY2VzID8NCg0KV2Ug
dGhpbmsgY2FuIHVzZSBhcmNoL2FybS9jcHUvYXJtdjgvdS1ib290LXNwbC5sZHMsIGJlY2F1c2Ug
d2UganVzdCBub3RpY2VkIHRoZSBDT05GSUdfU1BMX1JFQ09WRVJfREFUQV9TRUNUSU9OIHdhcyBh
ZGRlZCBpbnRvIGxkcyBhbmQgdGhpcyBzaG91bGQgYmUgdGhlIHNhbWUgZGVzaWduIHdpdGggY3Vy
cmVudCBwYXRjaC4NCg0KVGhhbmtzLg0KDQpCZXN0IHJlZ2FyZHMsDQpUaWVuIEZvbmcNCg==
