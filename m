Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B6DCF9C71
	for <u-boot@archiver.kernel.org>; Tue, 24 Sep 2024 05:49:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C92F88356;
	Tue, 24 Sep 2024 07:49:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="PEaIdCJj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE342884D2; Tue, 24 Sep 2024 07:49:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A158088387
 for <u-boot@lists.denx.de>; Tue, 24 Sep 2024 07:49:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1727156975; x=1758692975;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Mz2IJQ/VFZlbwLP44rQ4l5SHpKZfex5VfsA0UEKPsUM=;
 b=PEaIdCJjYzAHjJHVTV070oLy29jc+9Inw/CB/zRA77N+y8X0hmsLVzu6
 JyvLq2w4TP0Fzj6j66HB7LVykhBt6Yuq9cI+hsNBmvJsf1CMplgc+I+pj
 4IyPLmcmjvdty0t5TB5pze6L74pk20eCCk+RqtGyddPbV06U7Bg1LSv78
 Nh7iygQvgS7HuB5oVloTUHE+MGFFPMJg4m+Zuu4D7br6ysiXqqt6hGsNh
 mygolMhd5o55lVf6ZTuHSelfaY/KV2hzYr0yzDhlcH8K+PHNdi4gpKXxO
 kUfKMYJut63u6arA7CbK8snt7M5jLQiNMgKH4hszjSh/gVbTchgInCkSl Q==;
X-CSE-ConnectionGUID: um76v0MrQ2Wz8EygAQIDEw==
X-CSE-MsgGUID: 4BfukbCjTAyMQ25Dvu32Lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="26011583"
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; d="scan'208";a="26011583"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2024 22:49:21 -0700
X-CSE-ConnectionGUID: 2dcPFjlBRpaL0c/ede8u+A==
X-CSE-MsgGUID: g7df/xq6QA+/pnX/Q3W0FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; d="scan'208";a="76223305"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 23 Sep 2024 22:48:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Sep 2024 22:48:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 23 Sep 2024 22:48:51 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 23 Sep 2024 22:48:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VFrG8vUnq0/Bx8WCd3MwSu95tVYkbXM2hYudavHVdSHKvZo/WBL8AwavBCCsE6YOxwtwhAlDNpmjbIRXesiP4/pVK1pql0FZsX7jngbKvQ2I6k3BEe+eZauqksG78m0qG4G1z0epQwFgePS3gY9gZr7DfgJWtodIifCpyLW1dLZxjEkGGG5EUpgRBMGPHa6xM7CqnDy3HAsUWh4ORNdQAHC69kufyMSciG8/bDY82Tm0a9NjelrONOmCm7Wo6wt76zowmbxEntfL4Kl95NOfvWAqF4e3Yf3/cP9ZzCUw+UGem+MkpouP5Pq+F0U5pkh/zGffX8wnKuLLIZVNlIokUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mz2IJQ/VFZlbwLP44rQ4l5SHpKZfex5VfsA0UEKPsUM=;
 b=COkOWFoVOhPsJWx01LWXKvLfSqkA84IspGqMyMFzz1jEmiBeLzGsbX06DVsEmqkOtfcZtps+xFKmvEvimZIFPt/m0GE4czDJu/BXpjlHP7HRDaqTWqr0vEIc9zMR+vG7ozl8vsMtYfi/gr87GAxpkwiX6z6H6ZFp2Tv8HvfF8vu/dTV7XEsOuAnYiw2x5pTgbHRgRgmYpWLZU0rDieBIIu/9JL7HrpYNlJIpzCxWMyRURRyluRPjUnZ691dJp+C8Mp99TOmuqfW4CXuJhgIIJ8iTzMot/TnuixJIO8audtNLNoIHY+ziNSMqsRUwkGH93V/rcMysEgUOJB4b18JQ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 SN7PR11MB7639.namprd11.prod.outlook.com (2603:10b6:806:32a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 05:48:49 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe%5]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 05:48:49 +0000
From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, "Meng, Tingting"
 <tingting.meng@intel.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@intel.com>, "Hea, Kok Kiang" <kok.kiang.hea@intel.com>
Subject: RE: [PATCH v1 03/20] linker: Add SPL linker script for SoC64 devices
Thread-Topic: [PATCH v1 03/20] linker: Add SPL linker script for SoC64 devices
Thread-Index: AQHbCys436r47VSYzkSeBHU6d0cYMLJiQ5AAgAQwerA=
Date: Tue, 24 Sep 2024 05:48:49 +0000
Message-ID: <DM8PR11MB55923CF1E2F876C6EB68FC9BD2682@DM8PR11MB5592.namprd11.prod.outlook.com>
References: <20240920070242.20884-1-tien.fong.chee@intel.com>
 <20240920070242.20884-4-tien.fong.chee@intel.com>
 <858854ad-bebb-4199-bd8f-a5807a2144dd@denx.de>
In-Reply-To: <858854ad-bebb-4199-bd8f-a5807a2144dd@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|SN7PR11MB7639:EE_
x-ms-office365-filtering-correlation-id: fbc51a0c-098e-42be-101a-08dcdc5c9053
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?V1FiS3VVcXFKUUtneVJqK3hMUWtGYUdtTE9DTUVuS09TaXpianBTUENiSmhs?=
 =?utf-8?B?RHJFdWVxUWNVOUhSSlgrL1F1dVczWlJmVjdlTWpWaGRLZ0c0TU1na0cwaUF4?=
 =?utf-8?B?WVZlUlN0Y0RlQTREK0grQVcyUHEwOWx5OFFxYkhwb1R2MlVEMGZFTnRwZk0y?=
 =?utf-8?B?R3hlTG1sNGNKdFYxSWRTQjEvM0loRGovZlBDeHNLNS9leVhNekFiZUV5em94?=
 =?utf-8?B?c3ZBVjF2YU9FSG9yTGVNYzZLejdtNENLdDBRS09qU2IwTXB1WFI0OGJ0bGZy?=
 =?utf-8?B?RzdQWWZ0NnhCVTkvaFk1RS9OcnM5MEkzMmZpL0VKN0tHMmJTR1VVWS81N2F6?=
 =?utf-8?B?cWI4RzExNG9LMzM5UnRkQzQzY2JBU0Y0czl0S2hGSy9xcDFEZWUrVXJxUE5r?=
 =?utf-8?B?MmJmTkNjQi9hVjExVnNxOE9BSjUyczJaeGk1MGpTMytmRFNGbkhId1hiSUVw?=
 =?utf-8?B?T2htdjliMWU2WEk0bUVtMjk5aVpLdzFja0duMEd1eWppYzNWYlVYZ2s1UVJX?=
 =?utf-8?B?cEQwN2s3UUpzWU1JU2tJa3RZaWI0WFkrOHBOWllHcTV1OXZ4YXFIVlBrdFl1?=
 =?utf-8?B?SGhZZjFoU2gxVnVDT2dsSDhVUmlxSnRzZk5pMHhnYVk2dElMbVl0Mmx1aTZJ?=
 =?utf-8?B?bWtFVHdyRHZwNDVPMEJWaWpiblAyNnNvZUh4MWdaVDUxYkl2ejRjSDdBZ1Bo?=
 =?utf-8?B?T3FyTnF4Q1RZL3p4YURWbE0xWmVDQ25sRmUwZEVaV0xJNkpUSTY4anVJMlZR?=
 =?utf-8?B?U2FOeTBiUEdWUEx1dWJGYmdBd2xhTktlSnFwdGtxMnhBZUJybi9NcFBDb2dG?=
 =?utf-8?B?U3VOQm9hV3hKV2l2K2d4bnZvVDhEdTZiVlBtajF4M3RINi9FV0tSeXVTd09h?=
 =?utf-8?B?b1pOaXVFdjh4SUFUQXFkR1pPdUxpUXM0c0dBOUFxanRPL3oxQ3BFaWJkNGZF?=
 =?utf-8?B?cWFIRE10ZldZekFhRWhBTEVuNS9iSll0bkh5NHAwbkxIUGJzODVZZHNtVjc3?=
 =?utf-8?B?ZFVuNWtibmlhUU5FRmc2bjQvekIyVC9iWmliNnBvOXV5MFdzZTFvRjhrL0E2?=
 =?utf-8?B?elVscmxJNFM2WXJaS2MxNVViYUpaMklyV3I0MW1YUVgyUTEzSTFHZEw4RTVm?=
 =?utf-8?B?ZDdjNFZXb25PWWo0dUpHOHk0UFNuU1Jzb3k3RjJreHkycVNHUzVFVFVMYm04?=
 =?utf-8?B?QjVrQkVBKzRuNmpNdTNvbGtCUTNoSWk0MXVKT3ZkZlRCOFNXVTEvVUhrMXZE?=
 =?utf-8?B?WGVubmNLaVAvZGd3d1FENlNkbmlRMHNBVmlTaXFtd3QzdnRqeTJtdUZOK0JD?=
 =?utf-8?B?TkNRZ1Z0UVNIVXdjM2ZROWFuQVE3UTg5WDRYdnNpaEZVNHUyekdqaXJCZmdR?=
 =?utf-8?B?a3BEVGl6OXdKbUt1OWNIZ3ZSdXZ2S3c1Q2FXTWpnZGR0WVphdmE4bjd2SXNR?=
 =?utf-8?B?Mjg4SzVKR0VpQUtoNGozUk9hUVVaQUlCM2RxaElSZFBMcE9wTEN6SVRLZ3VP?=
 =?utf-8?B?bXVnalJUaWhtR0ZrOE5RQlB0WlZxOFZCNmFHdm4zT2c5c3kzSi9lb0RwVlE5?=
 =?utf-8?B?MVEzOHpuTkVNS3N3WFVBUGFNVzNSTXVkVjBEbGhMZEszUEZiallnc2NoTHpx?=
 =?utf-8?B?M0liZ09aSXpsSlBYc2tjUTFCUHg3cW9yaXh2OFFYMXVubVN0ejJuUkpkVDMx?=
 =?utf-8?B?ZFJJK0RFd25qT3FRVnFLUHZWZUVyZ2g0Y281ZVpjNkwrRVRsTGlDbVpSMllK?=
 =?utf-8?B?emZvT1I1VDBXQWprRXBFM1lnWEo3bDFyblZ1c2VSZTZ2WHpXT1AyWG1oZjl1?=
 =?utf-8?B?dU9YanBVdHQzK0hWclBSNE1nUllVVXRWbVRmaDJqVzhveDVqTVJxNlFyZE9m?=
 =?utf-8?B?WkQxeGgwMTVqQzNjdzJHOFNMRGpxVEMzNDFUbTRrRkJUTkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5592.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d28rQ0c2M3F5Znc5UlRTOVIrY2xMYjhaZ1RhTjdXbWhlN0lYUWdzY0tDa2Fk?=
 =?utf-8?B?VFJCL3VzcmdkdzdkUitvQkxDbzNESUJVNmsxYXlFWGlhdGRsTU5XRHFxQUtW?=
 =?utf-8?B?QmM0V3NrZ2Q1eGZBTG9jSzcxb3ZDR005V0pMZDdqS0F2blQwNTZRRjJkUGp2?=
 =?utf-8?B?QkpGRnhDTi9DNHh1NW02UTJMdW9OWUFBb1RLek1YNjRHQnlYWnQraWdRL09P?=
 =?utf-8?B?RGNuZXBFeHV1MUFVRXhEbWNLYVZKUHlTVWpHajFWdWxGeE1Ka0hhby9nZUtw?=
 =?utf-8?B?Mmc1Wm9HL3NybG5FZklSMFBKRG1rZDJycmR2Y0tWaGZLSmN4OWdSM1FmQ3Vi?=
 =?utf-8?B?d3JhTW9yQ0RLMkFXdlNaTDJBSHM0YlRqdE1rY3VUMEo0N2ExUWdNNjJEVkkx?=
 =?utf-8?B?dUVVWGVxYXJjUHhXSFk1WHJGRUxWbERwWjAzMjN5ZFBSdTJJemtuajRoNHZu?=
 =?utf-8?B?WmEwekZ0bEJPVlNtTVZrV1l4Q3M3MGdUK1piWGFIM2lGbTF4V001UEZBVDVp?=
 =?utf-8?B?RG00cStPdUM2Y3M3S2hGWU5ScXI0RkZkMVMxSU5KNHQrSDM4SDlGOFdSektV?=
 =?utf-8?B?TVdQa2JuQnIwZnZQZlhQQVdUc3NPMzNqUGNuMFZONm1saHgvU0dyaDR4Ync5?=
 =?utf-8?B?MFkreUdrWWZKNlU3NXpDWDZNaUszL0g5dVZwaW9DMjFwWk5HNHlKNDVJNjVH?=
 =?utf-8?B?K1c0KzZaV0VTT1VLZVN3dkVGb00rYzF2a1czTFhTNWRCS0xDaFBCSVhEckl0?=
 =?utf-8?B?Q3hIczhUUURoTUZYWnVpWkJ0aHllM1BlZFNHRmU4Y3krSWVLTnczR0ZGbHQz?=
 =?utf-8?B?b3JPT1JMdzB3TTVZb3BVQ0xGckJrUXBaZVdnOG4rWVF1VkRjRXlSUFF3c2pq?=
 =?utf-8?B?all5d3VSUmdETm5rVWNkb1NNRUxnZ1NITDNKSkJJL2dkOWxrbmhId3FhVERT?=
 =?utf-8?B?RWxueHBaaWZpaWQraThDbVdXZzRpaXpWQ0trdDF6TC8rbEhML2x4Qk5QUFds?=
 =?utf-8?B?R0hpQmtuaG84d3U1c29wY3NTUU9HTDBheFRmMjVmS3VNS3p2UjFmTzMzNXEy?=
 =?utf-8?B?WlYrVW45OUdzaTBHQVd5VVZlTllsN1hQYjB4Z0hTdUFwcXI4YUE0aDFNSFRv?=
 =?utf-8?B?SzJUeXlKc1dNNkJwVVF1ZXRKcVA2NVljZ2Y3NzNiWWp2ZUVJWHQwbWZsczRH?=
 =?utf-8?B?TlFVSzgxcWt0VmxJRVhEL3RMNmllNng2S0NnMEZUTnAwMmxYTjErSjMzdCtY?=
 =?utf-8?B?dEhCdjFGWHJYMTZXRmFFc0tGM2xqdFVUcjFjamVCcjBoaTNxbXRtaW9rMEZV?=
 =?utf-8?B?ZnF1T2VQR3B1L25mN1dkTlZ2aS9wdVNjU1JpRFZWK0VCTUN5a3hpbFFCL0tK?=
 =?utf-8?B?RjZIaU13aGpQMnd5eWhBSCtKdW1KU1B5ZDl4Zk1KTHpBSkZ0RWVDYkMxQTIr?=
 =?utf-8?B?bkdNa2FqTGxSL1NsQ3lhMEJiQ0tjTU5DY1RVTHJVM0lJN1JNdURCRXdsNkJN?=
 =?utf-8?B?dkVaMnRaWlhYRmpKb2NVUHl2eU9qQnpwK25PdHpHSWZNOU43UlhuSEZnNS9F?=
 =?utf-8?B?M3cvK28vSnloRVAzVWNyRjdYUm1TMVhydnl1TVJjZGJiTEJab291RitWY1Q1?=
 =?utf-8?B?UlptUkorOE9Ic2I5V05zQTN5cW16dVlwbWJweW5ReGQyd3VhZ0JIVEVkWDdi?=
 =?utf-8?B?cDVmNGRRQTIrSnUzNnE1VGUvWkR3citHajNlTE10MTVrZkNJOHpIL2l2OVFq?=
 =?utf-8?B?T3dGSTh2U1FhazF5YVJzUWViam1ZeDZsTW40TjNFUkYvV0tHYVNZNnVsR01h?=
 =?utf-8?B?Uno2aGR4a2NhTEdqcVJuT1ZnTnMwMzl5eUhoTG5OVU4rMWRMV1puVDU5d3Jp?=
 =?utf-8?B?QzR4Q3FtRGducHExVXZJajlvV0NMQ0xQWTY2M2JRZUk3TW1TSzRxYXAzRnhG?=
 =?utf-8?B?STRpN1J0YWlMVUFGM1NWRklYRllpYUJZZHA0Z0E2NmxNQ0NCTk5ISTNyaUNB?=
 =?utf-8?B?V0hUMzEzTXErVm5ST2Jxa0RVcjZSZGREN1ZVR0VMcGU0RWR6TXVLdGxHNmV6?=
 =?utf-8?B?c0EzeVlBWGxaemRscE9ENmxxMk9MTjNmMFNEUFAyOE4yQjUyVGVEb29PcDFj?=
 =?utf-8?Q?MYxjyyLXNygX1I4W7BA77XAzQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc51a0c-098e-42be-101a-08dcdc5c9053
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 05:48:49.5762 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zgmWmauWtCh/SLJ6bBynBFu3VDw5Y108RSTlzpAV1fuGVAtp4bSpZy6Pq5IIZjoRZCGcYgIFNBI59l4cor4dTvekmiLq9fmSRfYDdoVJPac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7639
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
PG1hcmV4QGRlbnguZGU+DQo+IFNlbnQ6IFNhdHVyZGF5LCBTZXB0ZW1iZXIgMjEsIDIwMjQgOTo0
OSBQTQ0KPiBUbzogQ2hlZSwgVGllbiBGb25nIDx0aWVuLmZvbmcuY2hlZUBpbnRlbC5jb20+OyB1
LWJvb3RAbGlzdHMuZGVueC5kZQ0KPiBDYzogU2ltb24gR29sZHNjaG1pZHQgPHNpbW9uLmsuci5n
b2xkc2NobWlkdEBnbWFpbC5jb20+OyBNZW5nLCBUaW5ndGluZw0KPiA8dGluZ3RpbmcubWVuZ0Bp
bnRlbC5jb20+OyBZdXNsYWltaSwgQWxpZiBaYWt1YW4NCj4gPGFsaWYuemFrdWFuLnl1c2xhaW1p
QGludGVsLmNvbT47IEhlYSwgS29rIEtpYW5nDQo+IDxrb2sua2lhbmcuaGVhQGludGVsLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAwMy8yMF0gbGlua2VyOiBBZGQgU1BMIGxpbmtlciBz
Y3JpcHQgZm9yIFNvQzY0IGRldmljZXMNCj4gDQo+IE9uIDkvMjAvMjQgOTowMiBBTSwgdGllbi5m
b25nLmNoZWVAaW50ZWwuY29tIHdyb3RlOg0KPiA+IEZyb206IFRpZW4gRm9uZyBDaGVlIDx0aWVu
LmZvbmcuY2hlZUBpbnRlbC5jb20+DQo+ID4NCj4gPiBBZGQgYSBuZXcgLmRhdGEgc2VjdGlvbiBm
b3IgcHJlc2VydmluZyB0aGUgb3JpZ2luYWwgc3RhdGUgb2YgdGhlIC5kYXRhDQo+ID4gc2VjdGlv
biBvZiBTb0M2NCBTUEwuIFRoaXMgbmV3IC5kYXRhIHNlY3Rpb24gaXMgcmVxdWlyZWQgdG8gbWFr
ZSBTUEwNCj4gPiByZWVudHJhbnQgYWZ0ZXIgd2FybSByZXNldC4NCj4gV2hlcmUgaXMgdGhlIGxp
bmtlciBzY3JpcHQgY29waWVkIGZyb20gPyBXaGF0IGlzIHRoZSBvcmlnaW5hbCBmaWxlIG5hbWUg
YW5kDQo+IHBhdGggPw0KDQpJIHRoaW5rIHRoZSBzY3JpcHQgaXMgY29waWVkIGZyb20gYXJjaC9h
cm0vY3B1L2FybXY4L3UtYm9vdC1zcGwubGRzIC4NCg0KUmVnYXJkcywNClRpZW4gRm9uZy4NCg==
