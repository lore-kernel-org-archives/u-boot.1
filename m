Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A465ECF9C6B
	for <u-boot@archiver.kernel.org>; Tue, 24 Sep 2024 08:52:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E130B882BE;
	Tue, 24 Sep 2024 10:52:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="RztFQFyO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7EB0886DF; Tue, 24 Sep 2024 10:52:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AE5F882BE
 for <u-boot@lists.denx.de>; Tue, 24 Sep 2024 10:52:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1727167933; x=1758703933;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vPLIvO9XMvcv321/BpnrOP8UUt01iXNi6Bu9A2HPMjw=;
 b=RztFQFyOwqNpaUvFOaDfUeINWdBG6AQV3bQgMJck/iC7moH1oWYK2HqQ
 tfVsTOe409QYZxzV9RG45QXxWZv3UfKxurdSkAG71/WyU3mdVAMjjC1bq
 LbU/OpjFgHcsmk2n7ApEJvgfR6Yn07iXN2WVtbp6T9BETF01VL6H0/nHq
 TQWCL1kmRmgipYgUmTSZLCRg+m5Eq4PSUFeZ4n1GpUmRcv6XmwJSsosnG
 bPE1PU/bbS+BXjovIxKm4DnKyDrNxdWpXEm2ZFtANMyTsGd9LY7YMpEGE
 NB7QpX/qSHdi7ssUvAY9yfBSFJADM2lf/hdfqT8vMZAC2vZe1/6RxBMTG w==;
X-CSE-ConnectionGUID: VUFPgX4nTLWkuXLMasiCOg==
X-CSE-MsgGUID: jdGiPqtySqG5fg/sRe2Szw==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="26244120"
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; d="scan'208";a="26244120"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2024 01:52:09 -0700
X-CSE-ConnectionGUID: qJcgAm6eSPOY+6xkxeE1QQ==
X-CSE-MsgGUID: WQjxzvQpT2iq/akqvO29yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; d="scan'208";a="71678858"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 24 Sep 2024 01:52:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 01:52:08 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Sep 2024 01:52:08 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Sep 2024 01:52:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ha3QdqVX/U9KZ+il96qRPVBqn2lTr2wFU5pGBiBaQxBReKpVsLInUuxcDPLkTCFYGHt8J/faG/gE80WLdQPElByUuL3z7hukru7JpOX/P+9VaJSiHncOWbVnjGhRH/WKbvV4et0yS0g2KSj0D8PI08lHBPo26TqO74yAdsAFTxuALVD5beXx+dxdfmZuhru8mIWGeyEPntDUFnU1U1cuAng3PjJTP3DiTZ4rzZURxDt4aHVaU+Um3DXLvrKAcZyBXIMGKFdDAWRF1amTHw7h9gTFvh+PtGqHrivrTNdJNB1UaVwjhPDzwv5edONzNy6H1nMFDxBvQcswfh2Jh8Zqpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPLIvO9XMvcv321/BpnrOP8UUt01iXNi6Bu9A2HPMjw=;
 b=mbLCvlOYZE78QpikJYGjTDbzF+ApBGS+kLjeZy38slCqK1hoPQKao9ZEvPt9AnL6XHDP9D5NnjMkEQ3cfgXZobV5Gjj8xWQNGu0MIi0atLFl+gr9jpB3xlCRBA1k59uUkA+2nUQBX1TA4Y+zTyeLrajo/BOmmLoNFS2fybiQyIuccua0MhP0p3XioMLYUTbfVix6c57UQGUzvE8/dBRaYooi4dUIKMKy9pVymBgb68oJGfUQ9zhCtvfBJAdPb6dyYaJbXLRHVADSku8OkLpnePZLR/VrHcktkYurkLxPsLgXgNe4SgrO3YdZ8dh/iNo66Fo0SdhrWybg99pWZSixOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 PH0PR11MB4933.namprd11.prod.outlook.com (2603:10b6:510:33::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.27; Tue, 24 Sep 2024 08:52:06 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe%5]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 08:52:06 +0000
From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, "Meng, Tingting"
 <tingting.meng@intel.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@intel.com>, "Hea, Kok Kiang" <kok.kiang.hea@intel.com>
Subject: RE: [PATCH v1 09/20] sysreset: Add reset support to SoCFPGA Agilex5
 device
Thread-Topic: [PATCH v1 09/20] sysreset: Add reset support to SoCFPGA Agilex5
 device
Thread-Index: AQHbDC9WpgAQHpjngkW0VsxgPuN1crJmpUKQ
Date: Tue, 24 Sep 2024 08:52:06 +0000
Message-ID: <DM8PR11MB5592F3ABE39FF548B02C6CB4D2682@DM8PR11MB5592.namprd11.prod.outlook.com>
References: <20240920070242.20884-1-tien.fong.chee@intel.com>
 <20240920070242.20884-10-tien.fong.chee@intel.com>
 <30cf32f0-75e1-47d8-b340-5cf3dd68a8c4@denx.de>
In-Reply-To: <30cf32f0-75e1-47d8-b340-5cf3dd68a8c4@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|PH0PR11MB4933:EE_
x-ms-office365-filtering-correlation-id: 5e1a7b80-a4fa-4843-b304-08dcdc762af2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UzEvbFhjM2xDZ3YvVjFIVTdtNDJ0YzQ3bytrNmtRdkRLS1E2QXp5Zm9LNUM4?=
 =?utf-8?B?WkRyNmVDdEUwMkVtOGFLVmNlOHFDOUVONm1Td1RDS3JIcmczdEw5a005VUVm?=
 =?utf-8?B?aDNOSC9HanBlZTFhdnRhZWlWYVZrQW5iVUl1ZmxRanJJQVNkOVVmMlNvZXpy?=
 =?utf-8?B?bmhRS3AvMDN2YkdZbHozV2F5Ym1nYmVoa2t3MnhFSUdZbzU4TDFrSDgrR2hI?=
 =?utf-8?B?ZlZ6ZXVIaTkyWk9SdHlScWdNSU1FZTZ3c004dlVZUXd2YXBQVlZobnk1WWJM?=
 =?utf-8?B?aXpaM2FnV25tVXdpM2VScUMyb2JvejJ1Ny9MUThXQkI0cTZsd2xmSG1yOFlv?=
 =?utf-8?B?YnpGUllud280cVJsZHVDNW9uTEFvMnQ5S3dYZTV2VjVDTGh0V2VxWDVBelhL?=
 =?utf-8?B?SHp1R0I5eGRlRXhFZzloWkxCdzEzVkgzVVF6K01VK3pXMm1ZdURRZnhwcTk1?=
 =?utf-8?B?WTVZWVNsUzJ6Z0VtcjJ2V3cwVTl0UDBRS3d5YVhtMkwwUXJjZmhGbkJUWmky?=
 =?utf-8?B?NThjNG1iN1J6cStZWUdOb1VGREEvMFN5WTU1VkpZeThMaFN5NW9reTV6UHVG?=
 =?utf-8?B?MDZENXpzSlVKVUcrWi9kcVc0RTVzUHZoUXBQdE5WSmNzVXNEWDF6ZGw1a0x2?=
 =?utf-8?B?VDdLME1yL2VSa2NxdytVSGwzejQxRlFjK0VYQ1EycGdldk5sMUtYb2kwbmdx?=
 =?utf-8?B?TWxHZGM1czBoNWtUeDFaSEFTQnByV2tCdDlTeWxKLzcwSHhuNFJ4YlJreWtm?=
 =?utf-8?B?WmMvbGtnZXowMGVBL0FzUFgyemFyOEVUalA1dFVWUWdQZ2tLUXhPU281cWF2?=
 =?utf-8?B?a0Y5UmJZUFQrNTZBcG9tZXZiQk15ZmdXbWozdVNNYkhLUlQ5aWVqME5qSVVB?=
 =?utf-8?B?amNKOU0zLzgzM3ZjRS96dlkvUjFTSGJ2ZG5ibTJBbnhnR0ZKeG13WWZLcFVE?=
 =?utf-8?B?Sm53dk1OQzY4WDh3Z05iNFJtOWl2MmgyVVZTUHFTUmVDdkdUekQxTWJsWWls?=
 =?utf-8?B?U1BoT3UwdHJFS3N6YTBidDRQWXdVc0Q0WmFsdGViSmJIdWtvNzl1QWU3TjZD?=
 =?utf-8?B?M21UMWpyRnFLQTBsQVBlK3R6emJReXpyUmpIM1hzemJva2Rqck5NZXpKOEVk?=
 =?utf-8?B?MG5CRWxQQUVkbllmUjZZNDgwSjFIRGtRbnp3alFWS1ViSi9MelRFZ0xtNmY5?=
 =?utf-8?B?cWsvVWRRaG8yOGFIekw5TzhmRXRkMUFTUEs2ZXJCVHpjczRvUEtZNys1d3do?=
 =?utf-8?B?OXRMdVl3TzlOMXB4MDkxVVNDYUlSTTcyZVkyN1UwNmszSTZ2UGM0QjRhN0pS?=
 =?utf-8?B?cHl6WnlvVmtKTFFCamhMU3hYdkljNCtDZGZmNkRzMXpKaHhrWkVydzZDOVhr?=
 =?utf-8?B?SXAyV3F0bkxNa0k0cVBDYUE1SHlsN0xoT1VoNG5MSDdkeTJRSTZNMTRzRFhn?=
 =?utf-8?B?cU9WT3lESEdHRW5ablNwbFA4MHBVSktWRmhRTk40N3h6OUdCcTZXeWdqYlAz?=
 =?utf-8?B?aWQrWWhjNlgzNnc3ZGFQZ2JVbGNrZmJIeENjWHN1M3JySUp4bVBtdkFaN2ha?=
 =?utf-8?B?eWtzRzNKZGE1MTFvWGx1Z0Mwek1mbFoxdVZVaXhEYmU1bHJOQ05maWhDWG1C?=
 =?utf-8?B?Q05TY2N6R3JjU1BYSEJXZUt4YktPRFdkOGxGa3pKL1BtZkVldmQ1VVp1NUo5?=
 =?utf-8?B?aVRRWUVXcFc4Y0RlWXdqME1HdmtBbWZYcDVMZ0FoSVprK09rWnZiVjkvSjN2?=
 =?utf-8?B?bFUrZld6YnplZ2Y1NXpmL2N0YnlBL2wydkkxalRUcSs0NTYwOUtXTzR6NEdE?=
 =?utf-8?B?ak1wNzlsNlpXUWdQdE4yUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5592.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3IwQ0Jpb3JlUFFNMXp1dnFtbnRLdHJvUnRBMzhaNnVWbnIxaHFsK2ZZVmJG?=
 =?utf-8?B?WWxTVFlCUnR6YlM3OHByL2o2T2ZCVktvdHVONEZiaDdnQ0FmSUNFL2Zoajdz?=
 =?utf-8?B?MW1CRGhmTHdXaFRGNDZ5dGg4SzM2VC9PamlOWXFBZ1hIeGZ3eG5naEZSMVd4?=
 =?utf-8?B?MFM0L0VSQ2I3VGRpeWJYMGoxV3NMM3dXTmg0NEJwdjZUbEVZRmh2QlFBWTE4?=
 =?utf-8?B?czhPWDV3Zk5EVUZYSjdNdUdwZm9oZDZNWXo2alZOeGJDNGpHVWR4ZDNZb1hS?=
 =?utf-8?B?U0V2MWhmN0V5eFc1alpNNWxpQ2FQRE1jR0xIaGRuSXg4K2l5NmNBTVp6a0t4?=
 =?utf-8?B?bVUrVGpYTXFKeDV5Zzl1Vnl1YjRqNlhhR2dDcExyOFpLQ2tDeHJLSGRDUzhq?=
 =?utf-8?B?M01MUGxWcEU5eUhqekJaVkdrMHBpdnBHKzAzaWRjUHVGVEd0NVdDVmJqeFFQ?=
 =?utf-8?B?WmVGK2o1VENYTDl6TlFBSVJhaEJRanpsdEt3MHNPVGhyL2I5TUtoS29ENW00?=
 =?utf-8?B?Mkg3OFlsdkdBT2Jxc2RnRlFXZk5oRjM5bmdGdExFY3lIRWxIN01DYnVVZnl1?=
 =?utf-8?B?ejZzYjNFditOb0w4dTZQaHFaZG1qWW9yTHVWYThVS21BemovbllaWlh1QmVv?=
 =?utf-8?B?SHNXOHovZFovc3ROUnBiWFNhckVTbFZmd2s4WWkzeW0ycWhZamdYZDNYM09P?=
 =?utf-8?B?N3liTkNBaFVSUTRTR3k1RmFCU250eE1PU05jU0FtL3VFU2U1UEVrNklzNTJS?=
 =?utf-8?B?UjcyaTRicFRHYzZMUm9mVUE1Zk9kS3hnREY4eWNLNzFRQkhDVXBPblRJNXp1?=
 =?utf-8?B?eWd3ZGsxMVpVQkliODRQeWtPeG1TdktOMlJPU3VjQzkxQUFvRGc5T2tMREk0?=
 =?utf-8?B?S1VyanVXYUFCb1dsT0NXU0VLR1pNejN3MU05dHZYL1l6QkFiK2RVSGRDaGQ4?=
 =?utf-8?B?KzBLNjdmei9NL3oweExpWTVGM2I3bTE2QjA1eXNYWjdYdjY3QnVkMnVxZFpO?=
 =?utf-8?B?SUhvTHkwckVwMDZOSzMrbElIV0VKaVNENE8wa2xVS0hPdVdmOUpqcFhycUFJ?=
 =?utf-8?B?NThKYXFFeEpqOTRpazBUNTJnUllTL1RUUU1abFRmWmN2c1V0bTVGTjA3ck40?=
 =?utf-8?B?OE5scWcxa2JvRDRDSWZ0NS81aGZTbnRzNVdJTDdhUnBHYzNKdWcrYVB4c2p2?=
 =?utf-8?B?NDBTME1RV21vRXFjR05URUs1THNBc05IektORGtTUTZNeVhCUTNpQXhWMEl2?=
 =?utf-8?B?ODA2T0dnWUNpcGE5R2hMRzhlVmRQWitUbC94SkFsUU1ZV1gvQzRCZGx1bG9i?=
 =?utf-8?B?a0grMnIxN3Z1RG1PUjI4MlY2dUV2L21sQXVKWnljRllGK2UwT3Q3ckJISyt4?=
 =?utf-8?B?S1RqTGF4angrNDhjSjU0K1RJYjRtblRtSVMvOGhHV0NndHJyYklQalAxSVNk?=
 =?utf-8?B?RWttb2Z6WmNCMHJrOU92V21FS2xDTUd1dXg4VnBoV2wvb0ZjVkxKMzBmeXZC?=
 =?utf-8?B?ME9kZ3RKaEdySVZBKzBkQXZVaGRMNkpuV0ZqN1dyOGFRTnJHdVFlL3hKQkVT?=
 =?utf-8?B?S3IxZ041K0RjZHI0eER2R2g4NXpEd3gyU3pqYmJkUU9IdlpvNU1LYkxnRU1m?=
 =?utf-8?B?SzNmRURLRnJVdXZrTERseWtiRWloUTBUZkd1bGdDQlhaeFB5aW5lWDF4UWdC?=
 =?utf-8?B?U1lTWVlITERveUZJdnYyYVpKdlFuUSthMlhNRDJaSkMwR0ZOZUNITUJpOEcz?=
 =?utf-8?B?b0NYcTdCem1KY21nTzc1YTcvMWw1d0xhcEt4TWo2NzRLc005WWdSWERlWVZ1?=
 =?utf-8?B?OEROa1lORlhoZjVtSHRJSW03dlNqLzRXMjBwUHFCeWM5K3pVNDc5bmxuOFVK?=
 =?utf-8?B?cEtuL1NwN09RVU1KVmQ0cFZIQWw4cXNrc2orQ0FQY09qbTdnWUdtd2ZOYWda?=
 =?utf-8?B?ei9qOEw1eFN6a2p2bGZLY1VGWVNTR1ZzYitqTHltNUhOQVRpbnBvTzV3ckdr?=
 =?utf-8?B?Z2RmSTR4L1kyL3VoUDVMQm85WWlZeXFSaFAxMnhSd056ZFRqbjVJcEY5UXdG?=
 =?utf-8?B?eTRSajV3Uk9kdGlTRU1nQlpReGNOdTZGbmN6UmlyK2Nod0IzdGg0Z2YwZlQ1?=
 =?utf-8?Q?9H6mucugjyAAcuInajR/SNVKY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1a7b80-a4fa-4843-b304-08dcdc762af2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 08:52:06.3968 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZT7oqywvseMyCOZlSHlqWN9hfh8ODxXwH4MkcZaCkxEvYM3aV3O6EB4eMJYWLtD/NV0GyoUqLGeh4616Lvap6XlH8SzKwpLmCgfNdY7umd8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4933
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
MiBQTQ0KPiBUbzogQ2hlZSwgVGllbiBGb25nIDx0aWVuLmZvbmcuY2hlZUBpbnRlbC5jb20+OyB1
LWJvb3RAbGlzdHMuZGVueC5kZQ0KPiBDYzogU2ltb24gR29sZHNjaG1pZHQgPHNpbW9uLmsuci5n
b2xkc2NobWlkdEBnbWFpbC5jb20+OyBNZW5nLCBUaW5ndGluZw0KPiA8dGluZ3RpbmcubWVuZ0Bp
bnRlbC5jb20+OyBZdXNsYWltaSwgQWxpZiBaYWt1YW4NCj4gPGFsaWYuemFrdWFuLnl1c2xhaW1p
QGludGVsLmNvbT47IEhlYSwgS29rIEtpYW5nDQo+IDxrb2sua2lhbmcuaGVhQGludGVsLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAwOS8yMF0gc3lzcmVzZXQ6IEFkZCByZXNldCBzdXBw
b3J0IHRvIFNvQ0ZQR0ENCj4gQWdpbGV4NSBkZXZpY2UNCj4gDQo+IE9uIDkvMjAvMjQgOTowMiBB
TSwgdGllbi5mb25nLmNoZWVAaW50ZWwuY29tIHdyb3RlOg0KPiANCj4gWy4uLl0NCj4gDQo+ID4g
KwlpZiAocmVzZXQgJiYgIXN0cmNtcChyZXNldCwgIndhcm0iKSkgew0KPiA+ICsJCS8qIEVuc3Vy
ZSBjb250ZW50IGluIGRjYWNoZSBpcyBmbHVzaGVkIHRvIHN5c3RlbSBtZW1vcnkgKi8NCj4gPiAr
CQlmbHVzaF9kY2FjaGVfYWxsKCk7DQo+ID4gKw0KPiA+ICsJCS8qIHJlcXVlc3QgYSB3YXJtIHJl
c2V0ICovDQo+ID4gKwkJcHV0cygiRG8gd2FybSByZXNldCBub3cuLi5cbiIpOw0KPiA+ICsNCj4g
PiArCQkvKiBkb2luZyBhcmNoaXRlY3R1cmUgc3lzdGVtIHJlc2V0ICovDQo+ID4gKwkJcHNjaV9z
eXN0ZW1fcmVzZXQyKDAsIDApOw0KPiBDYW4gdGhpcyB1c2UgU1lTUkVTRVRfUFNDSSBkcml2ZXIg
aW5zdGVhZCA/DQoNClRoaXMgZHJpdmVyIHNlZW1zIGNhbiBiZSB1c2VkIGFmdGVyIHF1aWNrIGNo
ZWNrLCB3ZSB3aWxsIHRyeSBvdXQgdGhpcy4NCg0KVGhhbmtzLg0KDQpSZWdhcmRzLA0KVGllbiBG
b25nDQo=
