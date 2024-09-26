Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 919E6CCF9E9
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 06:02:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE14D88CC2;
	Thu, 26 Sep 2024 08:02:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="X7+fou/+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 352FD88418; Thu, 26 Sep 2024 08:02:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A09C88BD2
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 08:02:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1727330545; x=1758866545;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FpouWx1VKmNLcWqk3nFW5+uFFa7TphyS+5ANEYCucW8=;
 b=X7+fou/+aWM24OWJVn0EAoIAy7Sl+eDT9iAEhYk2e6xMgz/QOea1v7Xw
 Nww51zX/kbeErO75//SQmtqsU52gnYL6fYfe/Go9s5UwsAAyaeFQP6XVx
 /Lr2SkM+n11zBYAzgwdkPwKJ9PjxDeW4+BXvHkzDi7ZGc/BODZQVeIigF
 3LRxcm5PNHtQBuU9dGsJoY8toAngfv30NVgzms8tFDwYHDAQjJq3RhZsO
 PQ/1rUUR8Y2vSDqDCuDA5Np+MZgFGeGmYlx761ubhP+pdanO1ZyG/Jn4s
 uGMY0KJBLE+252Mh3HiRH9Nu0jzqhOVHkqTUSxPU+30NWoctu2m+GF1eQ Q==;
X-CSE-ConnectionGUID: CjB4iJW6SnSc5KRX9J3+oA==
X-CSE-MsgGUID: t087AAA+RjGzRer6Dw4zgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="26588630"
X-IronPort-AV: E=Sophos;i="6.10,259,1719903600"; d="scan'208";a="26588630"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2024 23:02:20 -0700
X-CSE-ConnectionGUID: gQXo6d9tRBGo2EtuyFdA9g==
X-CSE-MsgGUID: /sgnE5J2SXy/ETMSLc3/tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,259,1719903600"; d="scan'208";a="71686989"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 25 Sep 2024 23:02:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 23:02:19 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 23:02:19 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 25 Sep 2024 23:02:19 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 25 Sep 2024 23:02:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hhKgiUbn/xC4thLPzjBpUv1NH5ChOvC3T5cHiVll4GS6/GA8eQL7QG74OBGBNeWswkrxHh+rkGWdwwjI2zG3/REWp0rq/8CxjGTS+D0q4ndJTS0q2d690MywLe/26mRSlEvTXnRV0j+BvDiSCYFfiJvhtTLe1nQxG9Jg+RmfajbWoje4IEqoVYuVtGicDeKmZmyZBjkwg2Ylv+WqNjL8y+b9Z/MBAivTQozD+P/+yEuKMX5Q7+C3JPkFmm9Ol/vKPzT8I35QmHGNoXyXOjFdOoey/x/tFOLwW9iIyXOY+mNJK34/2NWQWjL99TNOkVIxFHRG9CtE+VZs++S0oUBDAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpouWx1VKmNLcWqk3nFW5+uFFa7TphyS+5ANEYCucW8=;
 b=lYJpRQGa8TA5YcJZMpMU278Z6vzkSIr2lE8k/j1lUVuzFOJMeHqwPKHOThshVEnrX1FWjaOhzBI3u+MnFOQjncI8Nx1kCF400r2f4v2ARZh+EjFr+dmvDTv7dYVuoV5geEJTRmGbWZTUH/Cw14vJT4STLyHVkcmTSQgmoHhxwckmF3jAiuTauOkFJOJsPjrO5LXXiYXYHUTgyhNLEA8OziGwg8X8duMsvLkrYfbiOG+6kxr/Q6hZU3jJ6XYiEMRKdYlghwPCwPUOZdRTZ/bo2aBwnSUFIJaGyBH9rek421l3dPPlNv5ysqR/eBWi7B4TXylxM8agVMTnc5bhO9Fa2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5585.namprd11.prod.outlook.com (2603:10b6:5:356::23)
 by PH8PR11MB7096.namprd11.prod.outlook.com (2603:10b6:510:214::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Thu, 26 Sep
 2024 06:02:16 +0000
Received: from CO6PR11MB5585.namprd11.prod.outlook.com
 ([fe80::dc6b:e780:5f06:b8cf]) by CO6PR11MB5585.namprd11.prod.outlook.com
 ([fe80::dc6b:e780:5f06:b8cf%2]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 06:02:16 +0000
From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, "Meng, Tingting"
 <tingting.meng@intel.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@intel.com>, "Hea, Kok Kiang" <kok.kiang.hea@intel.com>
Subject: RE: [PATCH v1 04/20] arm: socfpga: agilex5: Add low level
 initialization
Thread-Topic: [PATCH v1 04/20] arm: socfpga: agilex5: Add low level
 initialization
Thread-Index: AQHbCysxcBsr3IIvwUKhOtjjWPaLTLJiQ8QAgAQDArCAAQMWAIAAt5tAgAB7MwCAARslgA==
Date: Thu, 26 Sep 2024 06:02:15 +0000
Message-ID: <CO6PR11MB55854FEA82DE5B61948975F2D26A2@CO6PR11MB5585.namprd11.prod.outlook.com>
References: <20240920070242.20884-1-tien.fong.chee@intel.com>
 <20240920070242.20884-5-tien.fong.chee@intel.com>
 <9cc437c8-59dc-4e78-82d4-8ef479ca9ba1@denx.de>
 <DM8PR11MB55924FDB9E2C081EE97216CCD2682@DM8PR11MB5592.namprd11.prod.outlook.com>
 <19445387-1b9a-45e9-84f2-c6de0487ce34@denx.de>
 <DM8PR11MB559230887920D1150E8F9591D2692@DM8PR11MB5592.namprd11.prod.outlook.com>
 <3aa8bf84-ea2e-4485-8a2d-e1af9d483c98@denx.de>
In-Reply-To: <3aa8bf84-ea2e-4485-8a2d-e1af9d483c98@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5585:EE_|PH8PR11MB7096:EE_
x-ms-office365-filtering-correlation-id: 06ae3065-f4e4-4e28-3564-08dcddf0c5ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ekxOQm94M05vMG43VjVMN1VTZHFaNzY3aUI0Tm9zNGEvU3YyL2dUTkQxQ1FW?=
 =?utf-8?B?U3JSRnU5YnN1ZDFBU0g2U1Z6SjNiZGd2UGp1U0pyYWV2UzBQclZzV2ZkdkpU?=
 =?utf-8?B?TE9ZcGhpa0xTVmtQTDB5cTJLckd1dyt1Q0ttWkJ2UjJhRnZFWWZjUzlXa2VF?=
 =?utf-8?B?dVM1ZEJnM3UxWHVIUEMvZFNKRXlQVlVWYy9nbmQ0MTI5SHR5S1I3Y1FZdVRS?=
 =?utf-8?B?cUl1SXdxQTFEVWJwK3FtUEkyem9qU1piNXVBbFh3K1lidlVFVFVJYlZIbEdo?=
 =?utf-8?B?R200TDhpT2tWVXkwQjVUWFZLVnEvbGNKWit5RHd3RnpZSFNqQTRoRHBnR3po?=
 =?utf-8?B?WCtQSUROWGhyNE1CN2Npa3RSMmd0ZVJOWXNpYmFrTFhrRGNVVUpycUdvNS9o?=
 =?utf-8?B?TTlNSVlSZ3M1YjlIeDRSYUI4R05yTHAxQUk5Nm91Y1ZDN1p6WkFJb1c0K0th?=
 =?utf-8?B?UmRPRFk5RVZzQjB3aFU0TWQ5ZUl5ODRMNTYvUWcvY0toU2krQ1V2QklQWWU4?=
 =?utf-8?B?SXdvZVlpbjJrSFFZTHgrSWJ2eWwrMmJTKzhRdDdmRU1naERJUlA4UkU5MTBK?=
 =?utf-8?B?M3MyNWIzay8ySEFpbHlwWmppUElTc01Lc1RzczU3Z1YxR1lPNzR0elRpVTJK?=
 =?utf-8?B?NklQZ2U3cFRMWWI0OXdVY1pqUis5RmcvTWtWQnFTa05CeEhVQjZKaE9wR0NG?=
 =?utf-8?B?Z0JSS3VvU1JBQmh2U2MrNklQNGNXbkJ6b3VyVmpVWWFtbElyN0xYZkZDdGlp?=
 =?utf-8?B?Z3pUWHNIekhGQnN2bjhneGJ0N1Vsc0tKemJIeUVLZ09sV3pEUTRNb3RqMVYr?=
 =?utf-8?B?dUNERXZXUnIvb0VVVUViR0JiUTVOdGtBZldCZVVHcmZuSllhcUZKZ1hPOWti?=
 =?utf-8?B?akd0eEk5RHBINmVzNmNLTEdmanh3cFFCVXdvclU0ZHlqeW51TDFTRC9OSTIw?=
 =?utf-8?B?T1NXbHhERlhuODdNVURvaGowdTJiZWo2KzZySDVQSVJ5S2dKb20xSmE2SERy?=
 =?utf-8?B?NmppL3liaWEwTU5WdVlzelAyZzdMcTJ1SVFsMXlSYWtRYXhsNXFPeXBLcWUw?=
 =?utf-8?B?TXFNOUxqSVVrOU9rbDA5Zzc5b2FXTEZVdmhVZElwVldLdnZmYWM5cEgzbDJB?=
 =?utf-8?B?NjZLTkZNTGRpMWtlVFJxMDAxaXNXWEZ4cFY4YnZ0MkIrRVpMMUs4R3M0YjlZ?=
 =?utf-8?B?S29WM2hUSmRRSXFlek1VRno2a2JDai9vNSsweXE3UUhlTWNLN3Z2bVNDTjBN?=
 =?utf-8?B?MUxPeEp1MzRRVSttVXhhL0xSN29QZi9ZRW9iRnY1eWxFbzVrSTgxaTJueE5a?=
 =?utf-8?B?NC9kNmxkRnVEMU4zNXZucUFuOVgyY1FWbUFxWWxxMWRnZ2xRbTdmME4xdHBo?=
 =?utf-8?B?SE41SThPRW1uNW5NVGw3cC9XZW5BL0I3K3JpYU5MRDV1UUVCWXpiNEozM24y?=
 =?utf-8?B?WFJ5aWdZQzV0ZFpHZkJMSG5rcUNSTXJUcHBtcWttLzh0dmNVcFpFckxnQTIw?=
 =?utf-8?B?Y2czUm1xcm9SRklIcHNEZEpMVWRhNk5PREhTVFd5TjArM3VnWmwzbCt5MHRY?=
 =?utf-8?B?aVJ2YmJqWjAxRDZLZTR4R0k2V3h4UGYxRDV1TzJsQkhDU3JoVWxGU1Znd2to?=
 =?utf-8?B?eFBYSXF3anpLUU52NXFSckQ4SzNnSXhBaTZpcElNMzRpek92QU9TakhYeE1l?=
 =?utf-8?B?ekhtdG50MWwwNy9tRlF0TnVBRjVaZDVJQS9HdVhCN0J5K1dqTzVZNERzOFBh?=
 =?utf-8?B?b2tFUGRBOGZ5UGtaVksvL3dCVEdNVkZjVlB2WUZyeEVWNDdYSGUyNmppa05q?=
 =?utf-8?B?NDFjYVFTTHh2cWpOV3lHZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR11MB5585.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0lJZEEzVFFCaEZtc3lkcUgxbmp0TzVYdC9ReExLdU52OEdWbGJyejNhQW5H?=
 =?utf-8?B?ODNQdzlWenI2Y1pXYnM5TUx1TytwTnhPTVlWVkMxN1pEaTAvRmg1ekQ4b1hm?=
 =?utf-8?B?SU9VQVVXUE51N0c0VFBzYm1mWnEzVEFsYnNVNHBWYlNjZTFHTytJdHoveFhL?=
 =?utf-8?B?MDN4b1c1dnFRUDZoaVNseTZoK3FqSW5SazB1YmxONUJyd1QydE14YmF1MFJY?=
 =?utf-8?B?dXI1OW81NDRONEZxT3hiQmdmSDF1TFBKM1JxZjVQNDZkaktQbWlRMGQxY1BT?=
 =?utf-8?B?UGg0bVg3QVc4V0NLNjkvYTh6azJwT3MyemJWbXNjek8xcmtSdzNNbWpaQ0Mx?=
 =?utf-8?B?aEtYdVFmam96Y3YxVHd3Q1l4SThHZ3VKQVB5a2ZVSjVHZUU5T2N6OEZ5YzdW?=
 =?utf-8?B?ZCs0ekY5SXNwTjFydTh3aGdWY3BOeHo3MXdkM0tDdmxFcXVLRDJTVk9OTHRp?=
 =?utf-8?B?SFFTKzNnK3JZTE10T2Y3cjRsWjRHZkRucEtwSDEzUEluVlZmOXpFWVJNaktT?=
 =?utf-8?B?SjFPekNwYUpvOG4xWWE4dzRXNnF6UFJRSkMyY2lPVUhLYkRZdEk4Y0kvTFlI?=
 =?utf-8?B?b1dBKzhNdW5nVmNYcFlWdGR2N0o2NU1weGFXQ0RtQWVVQ2hmUThiOWp2WVFS?=
 =?utf-8?B?K2NrWmxURzhWNVV6b2lqbi9zQk1HQ2RVMXJ3MUllc2YvSHJvaGVyZG81cVll?=
 =?utf-8?B?cmNhTU4xbzc5SGxSYTNDVUx0RVdRWWpEcjJVUXNjN0JWZ0RhOW9yMDJQUVVK?=
 =?utf-8?B?WFJJT1dXOWlxdnFCYkhiNThuZEk0eGU4RUEwTkZoU0w0Q1hWNzJBaDlIOGNy?=
 =?utf-8?B?Q3Z1YlZmYjl2UXVJUXd3S3FzQndRbzA1eE9qRlRreDBycEI1QS9sK3dPWUdl?=
 =?utf-8?B?ODdMZXVSM1d2VndFV2F4Znp1RkdRdGJzenEyMW9OOFBQVkJMZHJ5YXNHWWR5?=
 =?utf-8?B?dUErR2Z6ZWVGeTJNQlNBSE83dWlCRTlWRHYxRk9NWndZb3VwYlZxSyttZGs2?=
 =?utf-8?B?OGswT3crNlY2TW1XNTdmdEMyNnZKZVZKY2hkTlE0YmxrSzZPL1IrMXhWbEJr?=
 =?utf-8?B?cUVJTHIwWU5QTnhtejVmdHdLUWY3aGlUcVpXVGJHaW1vOFpwRmYra3ZuWWN3?=
 =?utf-8?B?T0tOZmJrKy9oTWVzU0FhWlpYaU4zSjVEU1BPVHozcG9YK3ZGbXgwTlNZN0N5?=
 =?utf-8?B?UDAzRDhtMEE5VjgyZnR2eXRNaURFSnhOakx3UkVwR09WZktKbmoxbW84V0Js?=
 =?utf-8?B?Vm9ybWdZMW43ZmRWKzFFRXIrWmxGUFZsaGFyU3JQRVR2SGNzbjhSczI3K3cy?=
 =?utf-8?B?VU5tQ1RIVW1WUTlRZk1FajZCOFE0TlppeDFpcUhhejZUbE51L0ZjRGVpTUo3?=
 =?utf-8?B?cW1FSHB2UUdXeURmUkVvRU04STBDMXBjRFFNWm1MS2w4dDBzWXN0STJtWnBL?=
 =?utf-8?B?Y2ZzTjFNZVZ4dmVzS1RzL3A3R2FMNDlTZ05TR2p1d0taMlo0dk1kaWJxVitr?=
 =?utf-8?B?b1p3aDN4aUV3b2pZSlRsK0dCZWltMjJRM2djeUc1SGFEY3hqRWVGTVdQUmRt?=
 =?utf-8?B?d1M1ZkUweE9qQ3FFRGFPVERxVTNoLzVEbDdCRDVNQmZITjIzc2FGaEdxRWRo?=
 =?utf-8?B?dkRwQnpxZDNMT2ZNbGJjc01zTDJUdFAyUFN0QVZIVkdmcm8wVlM4VWVtckNJ?=
 =?utf-8?B?STI0ZmkrM2J0bnlpcVR6aFRHVlEyZnJPcEc2WlRsTTZMRjQ1cGhPUndtOEty?=
 =?utf-8?B?Sk82R1YrdWY3Y0dGVjV0QjRnV0FFQmtYTjVWRkt1YUFLVE5EeklJNmNGdlNB?=
 =?utf-8?B?WUgvdG5UU2NkclZ4blNkekVJOXprdnlDL1lON2xIelpuRnlXWnV4c1RQZWw2?=
 =?utf-8?B?SGpuUTVWbGpOS29Dd0UrTEZQaXptY0xOKzJwYU5EOVFBekNXZjg5TmpyNUxx?=
 =?utf-8?B?bDVnb3JHYkQ3cWMvNXQ0TjdGQmRNbFdrWnR3SDJRVHc3OHJhWGlaWTVrajBG?=
 =?utf-8?B?VURXRWxZd21sWXd5UUZIQWVJcmJhSG9ab0tiZm1WWlJmU1A5M1g1ekNkS0lX?=
 =?utf-8?B?K28yelYxSlNuZ2UzRzd0blZ6WUxZTnM1dW51a3FtWS9jRmhFQ0toTVB2YjhL?=
 =?utf-8?Q?OlK5UYXtdG0tjAGx2839R87WH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5585.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06ae3065-f4e4-4e28-3564-08dcddf0c5ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 06:02:15.9429 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P57vz0APXBRg+ylSba0Ppc3tJzcPO86EEXZy8Gq1DIGyNRYNsWLGrWuFVB7MxMvB7jgUtOgl8OD/GuSBLgKqDTOUAm2RmkNrBItpNILmXO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7096
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

SGksDQoNCj4gPj4gYXJjaC9hcm0vY3B1L2FybXY3L2xvd2xldmVsX2luaXQuUzoucHVzaHNlY3Rp
b24gLnRleHQuc19pbml0LCAiYXgiDQo+ID4+IGFyY2gvYXJtL2NwdS9hcm12Ny9sb3dsZXZlbF9p
bml0LlM6V0VBSyhzX2luaXQpDQo+ID4+IGFyY2gvYXJtL2NwdS9hcm12Ny9sb3dsZXZlbF9pbml0
LlM6RU5EUFJPQyhzX2luaXQpDQo+ID4+IGFyY2gvYXJtL2NwdS9hcm12Ny9sb3dsZXZlbF9pbml0
LlM6ICAgICBibCAgICAgIHNfaW5pdA0KPiA+Pg0KPiA+PiBNYXliZSBzdWNoIGEgZGVmYXVsdCBs
b3dsZXZlbF9pbml0IGZvciBhcm12OCBjb3VsZCBhbHNvIGhhdmUgYW4gc19pbml0ID8NCj4gPj4N
Cj4gPj4+IFdoYXQncyBjb25jZXJuIHdpdGggbG93bGV2ZWxfaW5pdCgpPyBJdCdzIGFsc28gd2ly
ZWQgaW50byBleGlzdGluZw0KPiA+Pj4gZWFybHkgaG9vayBmdW5jdGlvbiB3aGljaCdzIGxvY2F0
ZWQgaW5zaWRlIHN0YXJ0LlMNCj4gPj4gSSB3b3VsZCBsaWtlIHRvIGF2b2lkIGR1cGxpY2F0aW5n
IGxvd2xldmVsX2luaXQgZnVuY3Rpb25hbGl0eSBhcyBtdWNoDQo+ID4+IGFzIHBvc3NpYmxlICwg
Y29tbW9uIGxvd2xldmVsX2luaXQgd291bGQgYmUgdmVyeSB3ZWxjb21lIC4NCj4gPg0KPiA+IFN1
cmUsIEkgY2FuIGFkZCB0aGUgc19pbml0IHRvIGNvbW1vbiBsb3dsZXZlbF9pbml0IGFuZCBtb3Zp
bmcgdGhlIGNvZGVzIHRvDQo+IHNfaW5pdC4NCj4gVGhhbmtzLiBUaGVuIHRoZSBxdWVzdGlvbiBp
cywgaG93IG11Y2ggb2YgdGhpcyBzdHVmZiBjYW4gYmUgcmVtb3ZlZA0KPiBiZWNhdXNlIGl0IGlz
IHBhcnQgb2YgZ2VuZXJpYyBsb3dsZXZlbF9pbml0LCBJIGhvcGUgYSBsb3QuDQoNCkknbSBub3Qg
c3VyZSBJIGNvbXBsZXRlbHkgdW5kZXJzdGFuZCB5b3VyIHF1ZXN0aW9uLCBidXQgSSBjYW4gc2hh
cmUgd2hhdCB3ZSdyZSBnb2luZyB0byBkby4NCkRlY2xhcmluZyBhIHdlYWsgc19pbml0IGZ1bmN0
aW9uIGF0IGxvd2xldmVsX2luaXQuUw0KDQoucHVzaHNlY3Rpb24gLnRleHQuc19pbml0LCAiYXgi
DQpXRUFLKHNfaW5pdCkNCglieAlscg0KRU5EUFJPQyhzX2luaXQpDQoucG9wc2VjdGlvbg0KDQpD
YWxsaW5nIHNfaW5pdCBiZWZvcmUgbG93bGV2ZWxfaW5pdCByZXR1cm5lZCB0byBwYXJlbnQgY2Fs
bA0KICAgICAgICAgICAgICBbLi4uXQ0KCWJsIHNfaW5pdA0KCW1vdmUgbHIsIHgyOQ0KICAgICAg
ICAgICAgICByZXQNCg0KV2Ugd2lsbCBtb3ZlIHRoZSBjb2RlcyB0byBzX2luaXQgd2hpY2ggaXMg
ZGVjbGFyZWQgaW4gb3VyIHBsYXRmb3JtIGRyaXZlciwgYXJjaC9hcm0vbWFjaC1zb2NmcGdhIC4N
Cg0KVGhlIGNvZGVzIGlzIG5lZWRlZCB0byBiYWNrdXAgdGhlIGRhdGEgc2VjdGlvbiBhcyBlYXJs
aWVyIGFzIHBvc3NpYmxlIHRvIHN1cHBvcnQNCndhcm0gcmVzZXQgLyB3YXRjaGRvZyBkdWUgdG8g
d2FybSByZXNldCB1c2UgY2FzZSwgd2hlcmUgcmVsb2FkaW5nIFNQTCB3b3VsZCBiZSBza2lwcGVk
IGFmdGVyIHJlc2V0Lg0KDQpUaGFua3MuDQoNClJlZ2FyZHMsDQpUaWVuIEZvbmcNCg0K
