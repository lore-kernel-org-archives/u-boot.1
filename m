Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A61D5C19F32
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 03:05:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14C03810EA;
	Mon,  3 Mar 2025 04:05:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="O9U/gS8B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EA84810ED; Mon,  3 Mar 2025 04:05:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E02C807B1
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 04:05:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740971106; x=1772507106;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=T3X+JvAFTTSHYrPtBOjRkmvzo/CRpxqUujthUKu8eB8=;
 b=O9U/gS8BttxOXb2su+DAyGSes0KANisTPlThDY4Wntk95i2OgzUJquJY
 qttICubfD4MLsdzqAhYBzLzL6j70QAxU5aoWT6jPx9ASOBR2ZwLuOTLaP
 PWyDKAkNKlFW9n9ToUdSGugGbs0lxEeKT2cJ+EPOuYSmVN4aoK4i9tn+u
 4deWgFk9VGMo5t9bbvovgYqibrxBIBuiq5ymdRa619TdmpgmSwAjiuVHH
 yoUqlG0m/PUf14/pqA95wbmtY3zKAT/4vZAbgPqQTjmV5vpVH+v2iDtQ/
 qTlZQbGj0M6CFmmST99+g9o2ZRZNU3+QOAOBPGHDojDgGYgswVNDyU1cD Q==;
X-CSE-ConnectionGUID: LL1T2bwES8K64IyLU+haYA==
X-CSE-MsgGUID: c2vB7tFmQzCLTk8E3lqofg==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="29417926"
X-IronPort-AV: E=Sophos;i="6.13,328,1732608000"; d="scan'208";a="29417926"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2025 19:05:04 -0800
X-CSE-ConnectionGUID: agspwMvXSwmBqL1/mzieGg==
X-CSE-MsgGUID: YTXInTsjRim7Mtdle6prGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,328,1732608000"; d="scan'208";a="122474558"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 02 Mar 2025 19:05:04 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 2 Mar 2025 19:05:03 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 2 Mar 2025 19:05:03 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 2 Mar 2025 19:05:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wbPMwwThaIrNsMPkpv+4AGMPssbZatUhdxkJLrZHCX8Uaz9CJFl9Rp7KkQHsqf4ssT371HaCibtoLFH5Q8mZll3Lxhk3sHEwVMKTzn1zG+ziZdRityJS/jaJ5JcuOknP3ONA2+8L+rDR912v/BEwhHdOfjpD1kGRiieFga7xFW5+AXu21rszN5zIlLJM0NZ9modcWihTQP2qJsRhtKtzq3xKJeXFdnXIrrzsYU+ag8ZfVkwtbQeJGlz8YADaPSTucbnP4c6iFwbOIupAxZJNBEQoB4/qDTBXcRIkyHFLUcLtt3qUyxteubAIwAJf9L0xzQdf76ps4aC0Eppoyb9qVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3X+JvAFTTSHYrPtBOjRkmvzo/CRpxqUujthUKu8eB8=;
 b=FcwI5AWlqBVKa/pTMhupFOH94BOVqRHP9C/Exdp9IGGfkE2FQ/MoI0n947PhDlcq+qjn7tEZ6+izvGrv+NbqeR5862JtJ2FpByoncc9DkZufpGcw/Gv8vsmUFB2uwqdd1xgrR+5ZHi0lPTxSm1WwsOKGR2/7pO0EoGe+jD0RoZvx51S2rJn36QfpqGtmezTihxXjbt9atkjyZ7Oh4e2kp+FuXl4ODayjQ8kuOS/D1nJ3xgEBlqtycHR/mwrM06Uy7g1lHjEJdu0LzlAb3WKknjCNurnAsxdTBHbHu9RR/US/RipXgiLPOrC34e3MRjRbrBJKJa6uTt3MQs7gGgOZdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 BL3PR11MB6409.namprd11.prod.outlook.com (2603:10b6:208:3b8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Mon, 3 Mar
 2025 03:04:51 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 03:04:50 +0000
From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
To: Lothar Rubusch <l.rubusch@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "trini@konsulko.com"
 <trini@konsulko.com>, "marex@denx.de" <marex@denx.de>,
 "simon.k.r.goldschmidt@gmail.com" <simon.k.r.goldschmidt@gmail.com>,
 "sumit.garg@linaro.org" <sumit.garg@linaro.org>, "sjg@chromium.org"
 <sjg@chromium.org>, "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>,
 "michal.simek@amd.com" <michal.simek@amd.com>, "Lim, Jit Loon"
 <jit.loon.lim@intel.com>, "barnas@google.com" <barnas@google.com>,
 "tien.fong.chee@altera.com" <tien.fong.chee@altera.com>
Subject: RE: [PATCH v4 03/11] ARM: dts: socfpga: add Mercury+ AA1 for u-boot
 dts
Thread-Topic: [PATCH v4 03/11] ARM: dts: socfpga: add Mercury+ AA1 for u-boot
 dts
Thread-Index: AQHbJ78UNCrbgff0VUqV61UlBg+VnrMhhkGggAl1aQCANoVZYA==
Date: Mon, 3 Mar 2025 03:04:50 +0000
Message-ID: <DM8PR11MB5592F2CD9F1EE6C9C65FC611D2C92@DM8PR11MB5592.namprd11.prod.outlook.com>
References: <20241026155220.26300-1-l.rubusch@gmail.com>
 <20241026155220.26300-4-l.rubusch@gmail.com>
 <DM8PR11MB5592B8B7BEB3B45165FD8EECD2E62@DM8PR11MB5592.namprd11.prod.outlook.com>
 <CAFXKEHYGUodqYn0WaVy=b_i+U00qp+isDv_6xu1nWWNGKxbaQg@mail.gmail.com>
In-Reply-To: <CAFXKEHYGUodqYn0WaVy=b_i+U00qp+isDv_6xu1nWWNGKxbaQg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|BL3PR11MB6409:EE_
x-ms-office365-filtering-correlation-id: 65491432-5c62-45c1-7756-08dd5a002a11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7416014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?UVFrVXVEZlpzM202TUlqRjRNQXg5SkZDSFM5T3lTS2k0Sm1wRjhjT2REMmhE?=
 =?utf-8?B?UGRTbDBaOGw1R0NLS3VCWEVZTlpETnFxY3F4UGlTSm5NT3lJSW9NL2Fydlpa?=
 =?utf-8?B?WnJsTFR2c0FucjJNUnUzdVM4NGhYamxwNEZlQVRudmpBM01QaG5YMm4xKytI?=
 =?utf-8?B?UmVnSGpiNzEzR0FSQlZlMzNNTFpVVURyc2t2Yy9xeC9ITThLNWhXRkZKalRs?=
 =?utf-8?B?VVU1M0FPeUpSc3l0bFJqbmxiRFBaWjR4c0pGTmovU0xqSC93Wk9RMjVTOTlN?=
 =?utf-8?B?NmI2a3o4YWdIWTVUTzZxVlBVV3pXMnVZRG9rc1l4VWNYRnc4UXFHc2drd0Mw?=
 =?utf-8?B?Y0p1K0ppM1ZHWHVOcmt6b0ttUU1pNEZtZE1nQU5taDN6VW1tZk80TWV0V1lq?=
 =?utf-8?B?eFJOeS9FNTBtTFQ3VVpDTmhaVzRRRXRQbUJxT25Md0hrbGlaa1VGL3FwYm9q?=
 =?utf-8?B?U05KSHpGbCs2UHRpVFZqcllXOWRLcG1xZnFRWE01UmFXQm5oR0NHVnBLaUZ3?=
 =?utf-8?B?Q1FzY2I3QUkyNkUzU0J5Nm5GMG12aHo1N0RvYTRnU2JMK0pqTk1DUlhRM1lF?=
 =?utf-8?B?SjBwZ2dNL3ZQMGxlSTVjcmJReHZaUGxJZnRuaW96WklzQklHWDN4WFlCQlg3?=
 =?utf-8?B?SW8yaFR1QjN4aFhqeDhJQjE2WHFFb2ZjNVBCOVZGQ0RCSC8yc2tEY1lRT2Nj?=
 =?utf-8?B?bDlkN0RldlRXeXB6WXlud0l6di9GQ2VEc05MTlNFdDBqOERiWnF4eElYL0d1?=
 =?utf-8?B?ck5zRUU2MlBTS2VNWWZjcUs5bXl6OUJjS0xVNW96QVJOcEtNYkJ4TEhtR2tR?=
 =?utf-8?B?WmZXbjc2S0FFcEtLOVQrejUwYi94eXQ5NjJnVWxBZG1qNVZVN1pxOXk4UkJ4?=
 =?utf-8?B?RnV3V3hyYVlIUnlCU09TLzgyMlFmME1Hc3BSbHBJRzh3bDFUU0JRM01hajhn?=
 =?utf-8?B?NnVYTytEVjVoMlJHR3Y4MGdjRi9JTldCeGZRRHl6NlZscEw4TVVCZEZZdDkw?=
 =?utf-8?B?WWFycFlqV1lpeC93aWRDWkFQUGwrMFVLRzd3cngrUjI3OVA2clVOelFJak95?=
 =?utf-8?B?RUZVZW9WN1ZvOG1JZWIvMTZSMlFzTUxvV2dLR010K2VVRWtITG5qL0xsYUlq?=
 =?utf-8?B?YVBUK2V3aXY5akwremxwaDVUQ09CY1JYMHdNZnlUMDRqUVJ6SDljaFJ2WUxG?=
 =?utf-8?B?SGVueUxtZWpRWFFhVTdYS3l5S1g5VytrTnNXUWdmRFBMejQ3VjgvUGNudnF2?=
 =?utf-8?B?ZW43SmlIb3I1K2pkY0JWeGJWY01IT3ZpYTl0OHpXSktlQUZNT1Fwa3RjekpB?=
 =?utf-8?B?ZjQ4TTVjN3J5dEZhTERSWFE1SHV6M3lqeml4ZEtMKzMxdjN2bklFbGd3R3ZJ?=
 =?utf-8?B?RHNGejBSNkNESTd6TWRRTTU3Z2gwUWI2U1pyQjBEUlhHVVJuZi9zWElVRGFw?=
 =?utf-8?B?UkRkSEQ1UmhkRTdnUGQ3WHcwRXE2a21VMjRYaC85SndVMFFyY2FlSGlOa3Fn?=
 =?utf-8?B?d3NOMkFKaU02ZmtsWFBUSHBrYzRrWWMrWWxjY1pYcVJOeFBvWXBaS05oN21x?=
 =?utf-8?B?OUk0NlEvN2tVUjM0MDJDckY2UTBxOG5QWXVIdnJOVmJjZHExM25WQ3Zua2JO?=
 =?utf-8?B?a2dQS3YwRE5QMjZSR29wakxtc0EzYnZ3U3R4TG5FODR5RFV3djlBcytJRklU?=
 =?utf-8?B?ZE5rMTJtVzRocFFzcXhiNXN2VGpqTHk2eU9Ka1o0Vlp4OFl5WG1yYTdoYlV6?=
 =?utf-8?B?U1VJeTZPRWFQYmhDN3VpNTRNRmM5WGxhMUZZN0xiWThpZkhBSklTRGNobzdB?=
 =?utf-8?B?WW1LbEd6c21uT0J5RmV2QXpnSkxiRTZ0aXdlTGNFVEJPL2FwVnpGQ2t3cW5O?=
 =?utf-8?B?RUdkcmIzbnp0dUN3cGVOMWdxZjZ6NkdjVzVpSUU3MFQyVXA4SFhiWXZVak9W?=
 =?utf-8?Q?JOBUhHcLYYeFWxEbqTiUYJ6l4bblRYit?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5592.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eld0T25OZ0ZrVHhFR0Z2Lzg0N1MxVUpOdHY1S1lTRzZFVjZ0cmsyYnovOWpo?=
 =?utf-8?B?Snp3WkdBd2xvSEVwN1hGNDVFVk8xVldaZ2pMb2dWNlgzdGp0N1pITWovMm5k?=
 =?utf-8?B?MEVCVTJHTEVac0twZG5zdzEyVzZHdFpNZEhjMUQvNDJHUVpwVTJvL2NvSFBm?=
 =?utf-8?B?RFZielJPVHFRbklEeUF3NzV6b0xYS2Zxa3pOM2EvNmZBNGFHaWRhOWpsOGRr?=
 =?utf-8?B?TFlwZ0swek9IdklDYmZlM2h6WkpnSTdaL2wxc0VaZU1rRTBDMFh6QStYRlFY?=
 =?utf-8?B?Zm1HYXBNb3NaSmtGdU4vZXh1bm1uTjNseWVxOVAzWS9PRlhaVStOVTh2Z2Fi?=
 =?utf-8?B?VnR3WkdYL0Z0dmIzWUdWdnJGM1hrU3luY1p6c0x4VFdObldicEpPR0h4OVFJ?=
 =?utf-8?B?bUFKTkJJUXJZU09yS3Vsamh5QVRLMFZEaTdOVlRQbkJhRWVBMUNtNFpyYmxp?=
 =?utf-8?B?c0M1bGNpQmtpK2VKcENwRHNGb2lNamF0VUNLcEZzc0pReGF1azQ4d2xMakNI?=
 =?utf-8?B?cXJ1M2lyQVloSXhkUkN5eFc3V1BINGphQThENEV1d1lFQWFsQ1pHVmhKNWxu?=
 =?utf-8?B?ZnRkRTNINDRXSjQvMFR4T3FYb1FkeldRNGNWSUZBWGdkS1R4RHFiaHdrek10?=
 =?utf-8?B?QTFHaDI1RCtJWjUwM3FBdGRNcGMrSnkzUEZhMCtqbHhadkFxSXZtNWdUYncr?=
 =?utf-8?B?TFYvRGFMV3VqcXg0T0Q3dis0NEtXSGJxOW1nY2x5NU04bGNDTDIvSk9Ia2pi?=
 =?utf-8?B?YTcrKzRzdEZPZ2tOMVRWOWRKS09qeEZmUkl1OWtzaDlKNnFYcVBqRk8vZTE0?=
 =?utf-8?B?d0JtRVFmdkRsY2lZcmw0RExPVDB5VUszSlJmL01DZEI2d2tCOWQvbkg2WjVi?=
 =?utf-8?B?bTlxOGNQZDFkQjdTYVBXdktVL2tRMXRSdGw5WXBpaVNVNWFsZWRBeVQyWDVG?=
 =?utf-8?B?UlIyUDhqUTFWSG9mVU5kVlliVDhWN053cjFDd2JJQ29BUE9JZEtybE5RbUJ0?=
 =?utf-8?B?dHkzSkE0K1lvd21jdURSWnlYTjYvb0JQUXpVWmVKeXYzTytTMEpjLzhUS0h0?=
 =?utf-8?B?YlRYWWhrYlk2Nmx6VFpmQUw3Y2pnWFl0MElXMlFnMGR4ZGYrVkN1YnFabmlL?=
 =?utf-8?B?QUgvanduR0ZSbENaS3NPYW1mSFRuTUZmR0NpcDJKSm1FRW9BeHY0ZE1DZ1pU?=
 =?utf-8?B?T1RwZS93YmRZTDhaMzNQNDlxRW90dWhCTDNjZkJsQzhnKzRyQUxkN0VsRk9p?=
 =?utf-8?B?ZkZ4eE1QUk5SaEhWT0pWcUJyVk0rbytVUWVXRGs1bWlFdzl6b0dycG1mODhH?=
 =?utf-8?B?cThGR2xWM2tMQXpWYVM4WHMzSVBPaTVRU0xhVldJZ2hSSlY1VGNwVGVOZ1Vo?=
 =?utf-8?B?VEtvRkpPMjdLOVFIaktYcFhoUE9TRWZJTlNIeTU2aDI5b2Q0a0FrSWxEMlc5?=
 =?utf-8?B?dmhKY05YZGY1bGNJVnhTYzdwb3VVT3gxaFdtUTBkK2ZnQ2lkOU8vdzZrOGJ6?=
 =?utf-8?B?VW5LYkQ0dTdRdXhZUTVIV1FsdkdYYXV3YkFQSFA0bFlaclk2OVJHNlB6anZa?=
 =?utf-8?B?NG0wbk5UcnJGeTVFZ0lEUlBDSFg4d3F6b2IwL2lCZ1JmbGZqbGkydDl0M09B?=
 =?utf-8?B?cmpyOW4yVzNzV243MWVBU0tPKzVNQlJwcFdsOXp5UU9DZXcwR1VDRUxncVgz?=
 =?utf-8?B?N3o3UHFFVklIT0dQMjhUTmFUNkI3bDZ2cG5JSTdXSUdrSGd2TjI0WTZuazZn?=
 =?utf-8?B?ellGb29LVlEvYXJhR005V0M3eDR4ckVuUFRrVWhiRWsyMklEUjgwc1JXb052?=
 =?utf-8?B?WDB5b3pNRDkzYytIRnpVSmgzRXdYRXFpL25lVDA0ekw4MW1LTDZocS94M1py?=
 =?utf-8?B?bDM4L3Zva3NKYVhnaThvcjRselFlSFVwWktmOWtEN2JMNU1Rd1hHV0xhN0dt?=
 =?utf-8?B?eUxxM1hhK0pYZkc5T01neU9uM3R2WmJ3TGNxdlY5ZGVMdjZEWUhhdm9MRyti?=
 =?utf-8?B?YlZNZmlLWEUrUU1LMXluN1pscko3Z0lBazJ5RlVHUWptbStMaWt5MXlWVS96?=
 =?utf-8?B?TWlUUG8wM3ZkdDdWa1k2TEU0eS91THpQRHRSWFJObk43VFNhbWl1KzN4QVA0?=
 =?utf-8?Q?5lYJsC8EiP+S8lt+yDXe+cDK4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65491432-5c62-45c1-7756-08dd5a002a11
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 03:04:50.8273 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oh/cHFWv4Vswtm5GdC7Fdblz7c6mQ+SFzLAuYisgHoxQTn6JasUDrr4/N2Es0yaoGbncPB93b+BaDbYK3pL/X3BWnoROq5TkW1LnxYOgmbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6409
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

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBMb3RoYXIgUnVidXNjaCA8bC5y
dWJ1c2NoQGdtYWlsLmNvbT4gDQpTZW50OiBNb25kYXksIEphbnVhcnkgMjcsIDIwMjUgNjoyNCBQ
TQ0KVG86IENoZWUsIFRpZW4gRm9uZyA8dGllbi5mb25nLmNoZWVAaW50ZWwuY29tPg0KQ2M6IHUt
Ym9vdEBsaXN0cy5kZW54LmRlOyB0cmluaUBrb25zdWxrby5jb207IG1hcmV4QGRlbnguZGU7IHNp
bW9uLmsuci5nb2xkc2NobWlkdEBnbWFpbC5jb207IHN1bWl0LmdhcmdAbGluYXJvLm9yZzsgc2pn
QGNocm9taXVtLm9yZzsgeHlwcm9uLmdscGtAZ214LmRlOyBtaWNoYWwuc2ltZWtAYW1kLmNvbTsg
TGltLCBKaXQgTG9vbiA8aml0Lmxvb24ubGltQGludGVsLmNvbT47IGJhcm5hc0Bnb29nbGUuY29t
DQpTdWJqZWN0OiBSZTogW1BBVENIIHY0IDAzLzExXSBBUk06IGR0czogc29jZnBnYTogYWRkIE1l
cmN1cnkrIEFBMSBmb3IgdS1ib290IGR0cw0KDQpPbiBUdWUsIEphbiAyMSwgMjAyNSBhdCAxMTow
M+KAr0FNIENoZWUsIFRpZW4gRm9uZyA8dGllbi5mb25nLmNoZWVAaW50ZWwuY29tPiB3cm90ZToN
Cj4NCj4gSGksDQo+DQoNCkRlYXIgVGllbiBGb25nIENoZWUsDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogTG90aGFyIFJ1YnVzY2ggPGwucnVidXNjaEBnbWFpbC5jb20+
DQo+IFNlbnQ6IFNhdHVyZGF5LCBPY3RvYmVyIDI2LCAyMDI0IDExOjUyIFBNDQo+IFRvOiB1LWJv
b3RAbGlzdHMuZGVueC5kZTsgdHJpbmlAa29uc3Vsa28uY29tOyBtYXJleEBkZW54LmRlOyANCj4g
c2ltb24uay5yLmdvbGRzY2htaWR0QGdtYWlsLmNvbTsgQ2hlZSwgVGllbiBGb25nIA0KPiA8dGll
bi5mb25nLmNoZWVAaW50ZWwuY29tPjsgc3VtaXQuZ2FyZ0BsaW5hcm8ub3JnDQo+IENjOiBzamdA
Y2hyb21pdW0ub3JnOyB4eXByb24uZ2xwa0BnbXguZGU7IG1pY2hhbC5zaW1la0BhbWQuY29tOyBM
aW0sIA0KPiBKaXQgTG9vbiA8aml0Lmxvb24ubGltQGludGVsLmNvbT47IGJhcm5hc0Bnb29nbGUu
Y29tOyANCj4gbC5ydWJ1c2NoQGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBbUEFUQ0ggdjQgMDMvMTFd
IEFSTTogZHRzOiBzb2NmcGdhOiBhZGQgTWVyY3VyeSsgQUExIGZvciANCj4gdS1ib290IGR0cw0K
Pg0KPiBJbnRyb2R1Y2UgdS1ib290IHNwZWNpZmljIGRldmljZS10cmVlIGZpbGVzIGZvciBFbmNs
dXN0cmEgTWVyY3VyeSsgQUExIFNvTXMgKEludGVsL2FycmlhMTApLg0KPg0KPiBHZW5lcmljIGRl
dmljZS10cmVlIGZyYWdtZW50cyBmb3IgbGludXggYW5kIFUtYm9vdCBzaGFsbCBiZSBwcm92aWRl
ZCBpbiBkdHMvdXBzdHJlYW0uIFRoZSBzZWxlY3Rpb24gb2YgdGhlIGdlbmVyaWMgZGV2aWNlLXRy
ZWUgZnJhZ21lbnRzIGRlcGVuZHMgb24gYSBzZWxlY3RlZCBib290LW1vZGUgYW5kIGEgc2VsZWN0
ZWQgY2FycmllciBib2FyZC4NCj4NCj4gT24gSW50ZWwvQXJyaWExMCBhIGhhbmRvZmYgc2V0dXAg
aXMgbmVlZGVkIGZvciBpbml0aWFsaXphdGlvbiBvZiB2YXJpb3VzIGNsb2NrIC8gcGlubXV4IC8g
RFJBTSBzZXR0aW5ncyBvbmx5IHVzZWQgYnkgVS1Cb290IHByb3ZpZGVkIGJ5IHRoZSBjdXJyZW50
IHBhdGNoLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZWFzIEJ1ZXJrbGVyIDxhbmRyZWFzLmJ1
ZXJrbGVyQGVuY2x1c3RyYS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IExvdGhhciBSdWJ1c2NoIDxs
LnJ1YnVzY2hAZ21haWwuY29tPg0KPiAtLS0NCj4gIC4uLl9hcnJpYTEwX2VuY2x1c3RyYV9tZXJj
dXJ5X2FhMS11LWJvb3QuZHRzaSB8ICA0NSArKysgIC4uLi9zb2NmcGdhX2FycmlhMTBfZW5jbHVz
dHJhX21lcmN1cnlfYWExLmR0cyB8ICA0NSArKysNCj4gIC4uLi9zb2NmcGdhX2FycmlhMTBfbWVy
Y3VyeV9hYTEtdS1ib290LmR0c2kgICB8ICAxOSArKw0KPiAgLi4uL2R0cy9zb2NmcGdhX2Fycmlh
MTBfbWVyY3VyeV9hYTFfaGFuZG9mZi5oIHwgMzA1ICsrKysrKysrKysrKysrKysrKw0KPiAgYm9h
cmQvZW5jbHVzdHJhL21lcmN1cnlfYWExL0tjb25maWcgICAgICAgICAgIHwgIDM3ICsrKw0KPiAg
Ym9hcmQvZW5jbHVzdHJhL21lcmN1cnlfYWExL01BSU5UQUlORVJTICAgICAgIHwgICAyICsNCj4g
IDYgZmlsZXMgY2hhbmdlZCwgNDUzIGluc2VydGlvbnMoKykNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0
NCANCj4gYXJjaC9hcm0vZHRzL3NvY2ZwZ2FfYXJyaWExMF9lbmNsdXN0cmFfbWVyY3VyeV9hYTEt
dS1ib290LmR0c2kNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCANCj4gYXJjaC9hcm0vZHRzL3NvY2Zw
Z2FfYXJyaWExMF9lbmNsdXN0cmFfbWVyY3VyeV9hYTEuZHRzDQo+ICBjcmVhdGUgbW9kZSAxMDA2
NDQgYXJjaC9hcm0vZHRzL3NvY2ZwZ2FfYXJyaWExMF9tZXJjdXJ5X2FhMV9oYW5kb2ZmLmgNCj4N
Cj4gZGlmZiAtLWdpdCANCj4gYS9hcmNoL2FybS9kdHMvc29jZnBnYV9hcnJpYTEwX2VuY2x1c3Ry
YV9tZXJjdXJ5X2FhMS11LWJvb3QuZHRzaSANCj4gYi9hcmNoL2FybS9kdHMvc29jZnBnYV9hcnJp
YTEwX2VuY2x1c3RyYV9tZXJjdXJ5X2FhMS11LWJvb3QuZHRzaQ0KPiBuZXcgZmlsZSBtb2RlIDEw
MDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwLi42ZTM4Mjg2NTcyDQo+IC0tLSAvZGV2L251bGwNCj4g
KysrIGIvYXJjaC9hcm0vZHRzL3NvY2ZwZ2FfYXJyaWExMF9lbmNsdXN0cmFfbWVyY3VyeV9hYTEt
dS1ib290LmR0c2kNCj4gQEAgLTAsMCArMSw0NSBAQA0KPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50
aWZpZXI6IEdQTC0yLjArIE9SIE1JVA0KPiArLyoNCj4gKyAqIENvcHlyaWdodCAoQykgMjAyNCBM
b3RoYXIgUnVidXNjaCA8bC5ydWJ1c2NoQGdtYWlsLmNvbT4gICovDQo+ICsNCj4gKy8qIEFycmlh
MTAgaGFuZG9mZiAodS1ib290KSAqLw0KPiArI2luY2x1ZGUgInNvY2ZwZ2FfYXJyaWExMF9tZXJj
dXJ5X2FhMV9oYW5kb2ZmLmgiDQo+ICsjaW5jbHVkZSAic29jZnBnYV9hcnJpYTEwLWhhbmRvZmYu
ZHRzaSINCj4gKyNpbmNsdWRlICJzb2NmcGdhX2FycmlhMTBfaGFuZG9mZl91LWJvb3QuZHRzaSIN
Cj4gKyNpbmNsdWRlICJzb2NmcGdhX2FycmlhMTBfbWVyY3VyeV9hYTEtdS1ib290LmR0c2kiDQo+
ICsNCj4gKy8qIFNwZWNpZmljIGJvb3QtbW9kZSAodS1ib290KSAqLw0KPiArI2lmIElTX0VOQUJM
RUQoQ09ORklHX0VOQ0xVU1RSQV9TRE1NQykgfHwNCj4gK0lTX0VOQUJMRUQoQ09ORklHX0VOQ0xV
U1RSQV9FTU1DKQ0KPiArDQo+ICsvIHsNCj4gKyAgICAgICBmc19sb2FkZXIwOiBmcy1sb2FkZXIg
ew0KPiArICAgICAgICAgICAgICAgYm9vdHBoLWFsbDsNCj4gKyAgICAgICAgICAgICAgIGNvbXBh
dGlibGUgPSAidS1ib290LGZzLWxvYWRlciI7DQo+ICsgICAgICAgICAgICAgICBwaGFuZGxlcGFy
dCA9IDwmbW1jIDE+Ow0KPiArICAgICAgIH07DQo+ICt9Ow0KPiArDQo+ICsmZnBnYV9tZ3Igew0K
PiArICAgICAgIGJvb3RwaC1hbGw7DQo+ICsgICAgICAgZmlybXdhcmUtbG9hZGVyID0gPCZmc19s
b2FkZXIwPjsNCj4gKyAgICAgICBhbHRyLGJpdHN0cmVhbSA9ICJmcGdhLml0YiI7DQo+ICt9Ow0K
PiArDQo+ICsjZWxpZiBJU19FTkFCTEVEKENPTkZJR19FTkNMVVNUUkFfUVNQSSkNCj4gKw0KPiAr
LyB7DQo+ICsgICAgICAgZnNfbG9hZGVyMDogZnMtbG9hZGVyIHsNCj4gKyAgICAgICAgICAgICAg
IGJvb3RwaC1hbGw7DQo+ICsgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gInUtYm9vdCxmcy1s
b2FkZXIiOw0KPiArICAgICAgICAgICAgICAgc2Zjb25maWcgPSA8MCAwIDUwMDAwMDAwIDM+Ow0K
Pg0KPiBUaGUgUkFXIHJlYWQgaW1wbGVtZW50YXRpb24gaW4gZnNfbG9hZGVyIGlzIG5vdCB1cHN0
cmVhbSB5ZXQsIEkgYWZyYWlkIHRoaXMgbWlnaHQgbm90IHdvcmtpbmcsIHlvdSB3YW50IGhlbHAg
dG8gdXBzdHJlYW0/DQo+DQoNClRoYW5rIHlvdSBzbyBtdWNoIGZvciBjb21pbmcgYmFjayB0byBt
ZSEgVGhlIFRMO0RSIGFuc3dlciBpcywgeWVzLg0KUGxzLCBzdGFydCBieSBmaXhpbmcgSW50ZWwg
cGxhdGZvcm0gbWFpbnRlbmFuY2UgaW4gdGhlIExpbnV4IGtlcm5lbCBmb3Igb2xkIEludGVsL3Nv
Y2ZwZ2EuDQoNCkZvciB0aGUgbG9uZyBzdG9yeSwgdGhlcmUgYXJlIHNldmVyYWwgcG9pbnRzIGhl
cmUgd2hpY2ggYXJlIHByb2JhYmx5IG5vdCBxdWl0ZSB0cmFuc3BhcmVudCBqdXN0IG9uIHUtYm9v
dCBNTC4gTGV0IG1lIGNsYXJpZnkuIFBlcnNvbmFsbHksIEkgaGF2ZSBhY2Nlc3MgdG8gc29tZSBF
bmNsdXN0cmEgaGFyZHdhcmUgYW5kIHdhcyBjdXJpb3VzIHdoYXQgaXQgd291bGQgdGFrZSB0byB1
cHN0cmVhbSBpdC4gVGhpcyB3YXMvaXMgZHJpdmVuIG1haW5seSBieSBteSBwcml2YXRlIGludGVy
ZXN0LCBzaW5jZSB0aGUgY29tcGFueSBnaXZlcyBhIC4uLmRvZXMgbm90IGNhcmUgYWJvdXQgb3Bl
biBzb3VyY2UuIEFzIHlvdSB3aWxsIGVhc2lseSBzcG90IHRob3NlIEludGVsIHBsYXRmb3JtcyBh
cmUgbm90IHRoZSBtb3N0IHJlY2VudCBJbnRlbCBwcm9kdWN0cyBlaXRoZXIuIEkgcGlja2VkIHRo
ZW0gYSBiaXQgb24gcHVycG9zZSwgc2luY2UgSSBkaWQgbm90IHdhbnQgdG8gIm1lc3MgaXQgdXAi
IGZvciB0aGF0IGNvbXBhbnkgd2l0aCBteSBwZXJzb25hbCB1cHN0cmVhbSBpbiB0aGUgZmlyc3Qg
YXBwcm9hY2guIElmIGl0IHdlbnQgdXBzdHJlYW0sIGl0IGNvdWxkIGJlIHRoZSBiYXNpcyBmb3Ig
ZnVydGhlciBFbmNsdXN0cmEgSGFyZHdhcmUgaS5lLiBYaWxpbngvQU1ELCBNaWNyb2NoaXAgYW5k
IG1vcmUgcmVjZW50IEludGVsLg0KVGhhdCdzIGEgYml0IHRoZSBiYWNrZ3JvdW5kIGFuZCBpbnRl
bnRpb24uDQoNClNvLCB3aGVuIEkgc3RhcnRlZCBsYXN0IHN1bW1lciwgdS1ib290IGNvbW11bml0
eSBzdGFyZWQgd2l0aCBkdHMgdXBzdHJlYW0uIE1lYW5zLCBteSBEVFMgbWF0ZXJpYWwgbmVlZGVk
IHRvIGJlIHByZXBhcmVkIGFuZCBzcGxpdCB1cCBpbnRvIGEgbGludXgga2VybmVsIHBhcnQgYW5k
IGEgdS1ib290IHBhcnQuIER1ZSB0byB0aGUgYml0c3RyZWFtIGhhbmRsaW5nIGFuZCBlYXJseSBp
bml0aWFsaXphdGlvbiBvZiByZWdpc3RlcnMsIGFsc28sIHRoZSB1LWJvb3QgRFRTIHdlbnQgcGFy
dGx5IGludG8gZHRzLXVwc3RyZWFtLCBhbmQgcGFydGx5IGludG8gdGhlIGNsYXNzaWMgRFRTIHBs
YWNlcyBmb3IgaGUgaW50ZWwvc29jZnBnYSBwbGF0Zm9ybS4gSSBtYW5hZ2VkIHRvIGltcGxlbWVu
dCBhIGR5bmFtaWNhbGx5IGFkanVzdGVkIEVuY2x1c3RyYSBEVFMsIGJhc2VkIGtjb25maWcgb3B0
aW9uLiBBdCB0aGUgZW5kIG9mIHRoZSBkYXksIHRoaXMgYWxsIHJlc3VsdGVkIGluIHRoZSBkZXBl
bmRlbmN5IHRvIGhhdmUgRFRTIG1hdGVyaWFsIHVwc3RyZWFtIGluIHRoZSBsaW51eCBrZXJuZWwg
cmVwby4NCg0KQm90aCBwYXRjaHNldHMgd2VyZSBhY3R1YWxseSBwcmVwYXJlZCBhbmQgcHJlc2Vu
dGVkIG9uIHRoZSBNTHMuIEZvciB1LWJvb3QsIHlvdSB3aWxsIGZpbmQgYWxsIGNvbW11bmljYXRp
b24gY29uY2VybmluZyB0aGUgdS1ib290IHBhdGNoZXMgaGVyZSBvbiB0aGlzIE1MLiBXaGVyZSBm
b3IgdGhlIGtlcm5lbCBwYXRjaGVzLCBJIGdvdCB0aGUgbW9yZSBnZW5lcmFsIHBhdGNoZXMgQUNL
J2QuIEJ1dCB0aGUgSW50ZWwgbWFpbnRhaW5lciBEaW5oIE5ndXllbiBkaWQgbm90IG1hbmFnZSB0
byBnaXZlIGZlZWRiYWNrLiBJIHdhcyBldmVuIGFibGUgdG8gY29udGFjdCBEaW5oIGRpcmVjdGx5
LCBhbmQgaGUgZ2F2ZSBtZSBiYWNrIHRoYXQgaGUgcGxhbnMgb24gZG9pbmcuIFRoaXMgd2FzIGlu
IGZhbGwgMjAyNC4gTm8gdXBkYXRlIHNpbmNlIHRoZW4uIC0gSGVyZSBpcywgSU1ITywgd2hlcmUg
eW91IEludGVsIGd1eXMgY291bGQgcmVhbGx5IGhlbHAgd29yayBvbiBzb2x2aW5nIHRoaXMgc2l0
dWF0aW9uOiBFaXRoZXIgaGVscCBvdXQgRGluaCBmb3IgdGhlIGtlcm5lbCBzdHVmZiwgb3Igb3Jn
YW5pemUgcmVwbGFjZW1lbnQuIERvbid0IGdldCBtZSB3cm9uZywgdGhpcyBpcyBub3QgbWVhbnQg
dG8gYmUgcGVyc29uYWwuIEknbSBzdXJlIGhlIHdpbGwgaGF2ZSBnb29kIHJlYXNvbnMgaWYgaGUg
Y2Fubm90IGNhcnJ5IG91dCB0aGlzIGpvYiBjdXJyZW50bHkuIE1lYW5zIHB1dCB1cCBzb21lb25l
IHdobyB3aWxsIChjby0pbWFpbnRhaW4gdGhlIG9sZCBJbnRlbCBwbGF0Zm9ybXMgaW4gdGhlIExp
bnV4IGtlcm5lbC4gQWxzbywgdGhlIEludGVsL3NvY2ZwZ2EgZHQtYmluZGluZ3MgbmVlZCB0byBi
ZSB3cml0dGVuIGluIFlBTUwsIEFGQUlSLiBUaGF0J3Mgd2h5IGUuZy4gUm9iJ3MgRFQtY2hlY2sg
Ym90IHdpbGwgYWxtb3N0IGJsYXN0IHlvdSB3aXRoIGVycm9ycyB3aXRoIHRoZSBjb21tZW50ICJj
YW4gYmUgYWNjZXB0ZWQgaWYgdGhlIHNwZWNpZmljIHBsYXRmb3JtIG1haW50YWluZXIgaXMgd2ls
bGluZyB0byIuDQpQbGF0Zm9ybSBtYWludGFpbmVyIGRvZXMgbm90IGFuc3dlciwgYW5kIEknbSBu
b3Qgd2lsbGluZyB3cml0aW5nIHRoZSBZQU1MIGR0LWJpbmRpbmdzIGZvciB5ZSBvbGRlIEludGVs
LCB3aGVuIHRoZXJlIGlzIG5vIG1haW50YWluZXIgZXZlbnR1YWxseSBhY2NlcHRpbmcgaXQuLiBI
ZW5jZSwgYWNjZXB0aW5nIHRoZSBFbmNsdXN0cmEgSW50ZWwgRFRTLCB3b3VsZCBtZWFuIHRvIGFj
Y2VwdCB0aGVtIHcvbyB0aGUgdXBkYXRlZCBhbmQgY2hlY2tlZCBkdC1iaW5kaW5ncy4NCg0KRm9y
IHRoZSAodGVjaG5pY2FsKSByZXN0OiBJIGhhdmUgZnVsbCBhY2Nlc3MgdG8gdGhlIGhhcmR3YXJl
LCBpLmUuIDMgZGlmZmVyZW50IEFycmlhMTAgU09NcyBvZiBFbmNsdXN0cmEsIGFzIDIgZnVydGhl
ciBDeWNsb25lNSBTT01zLiBBbGwgY2FuIGJlIGNvbWJpbmVkIHdpdGggMyBkaWZmZXJlbnQgY2Fy
cmllciBib2FyZHMgb2YgRW5jbHVzdHJhLiBUaGUgc2V0dXBzIGFyZSBib290aW5nIGluIGRpZmZl
cmVudCBib290IG1vZGVzIChTRCwgZU1NQyBhbmQgc29tZSBmcm9tIFFTUEkgZmxhc2gpLiBBZnRl
ciB0aGUgRFRTIHNlcGFyYXRpb24sIChyZSlpbXBsZW1lbnRpbmcgdGhlIG1pbmktZHJpdmVycyBi
YXNlZCBvbiB1LWJvb3QgRE0sIEkgbmVlZGVkIHRvIG1pZ3JhdGUgdGhlIHNldHVwIHVzaW5nIGJp
bm1hbi4gQnVpbGRpbmcsIGZsYXNoaW5nIGFuZCBib290aW5nIGludG8gYSBmdW5jdGlvbmFsIHUt
Ym9vdCwgaXMgdmVyaWZpZWQgZm9yIGFsbCBzZXR1cHMuIEFzIHlvdSBtZW50aW9uZWQsIHBhcnRz
IGluIHRoZSB1LWJvb3QgQVBJIGFyZS93ZXJlIHN0aWxsIHVuZGVyIGRldmVsb3BtZW50LCB0aG91
Z2gsIGJ1dCBNYXJlayBrZXB0IG1lIGluIHRoZSBsb29wIGhlcmUgKGFsc28gb24gTUwpLg0KDQpJ
IGFwcHJlY2lhdGUgeW91ciBwYXRpZW5jZSwgZm9yIHJlYWRpbmcgdGhpcyBhbGwuIEluIGEgY29u
Y2x1c2lvbiwgdGhlIHByb2R1Y3RzIGFyZSBzdGlsbCBzb2xkLiBZZXMsIHRoZXkgYXJlIGEgYml0
IGFuY2llbnQuLiB3aGF0IGV2ZW50dWFsbHkgYmxvY2tlZCBpdCwgaXMgSU1ITyByYXRoZXIga2Vu
ZWwgbWFpbnRlbmFuY2UgZm9yIG9sZCBJbnRlbCBwbGF0Zm9ybXMgd2hpY2ggc2VlbXMgb3JwaGFu
ZWQuIEZvciBtZSBwZXJzb25hbGx5LCBpdCBhbHJlYWR5IHBhaWQgb2ZmIGEgbG90IGZyb20gd2hh
dCBJIGNvdWxkIGxlYXJuISAtIFllcywgSSdkIGxvdmUgdG8gc2VlIHRoZSBzdHVmZiB1cHN0cmVh
bS4NClRoZXJlIHNlZW1zIHRvIGJlIGxlc3MgbG92ZSBieSBJbnRlbCwgdGhvdWdoLCBmb3IgaXRz
IHNvY2ZwZ2EgcGxhdGZvcm1zIG9uIExpbnV4LiA7KQ0KDQpCZXN0LA0KTA0KDQoNCj4gWy4uLl0N
Cj4NCj4gQmVzdCByZWdhcmRzLA0KPiBURg0K
