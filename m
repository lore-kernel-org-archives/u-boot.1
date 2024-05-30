Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F683C27C44
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 14:53:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F35B988705;
	Thu, 30 May 2024 16:53:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="KTTYOoSG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5C2188708; Thu, 30 May 2024 16:53:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8518886AE
 for <U-Boot@lists.denx.de>; Thu, 30 May 2024 16:53:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kalen.brunham@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717080802; x=1748616802;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HhBo5VLSf3dr4OB8B/Yq0TQ1K7XElhrnu6OOA4qoGJ0=;
 b=KTTYOoSGAW/GSxhi2pN+bXer6YtFaldsMfWf6j/Wiq065E81+L6p4OtT
 MIsGVhFPL9tCau4oawP4MVzM9ND7icTchpnf8t+aiIQLtmHmlCQo1TiDc
 y9vjd7VRCkcAXYmMn7ap8BN9sYBMpSwYkCr0ddS40d0rzefflNCbwZajm
 y5BY8gEWICEV3pGhj8LLPxCbuUziiE48uMIkasiyjgBr4GmwRmKgIDL/t
 W8auiPxbRi+LPe22o8r0j+SaKmGrLsKpw8diB1fY0Szg5BduntQAhjWqN
 p7zm85qAeqiubRfijpgYx18GDLKeafnyudG2eaEgW9a18R7CP+pxkjCh2 Q==;
X-CSE-ConnectionGUID: j/MqtHMOTu28usrX3Sep7w==
X-CSE-MsgGUID: kj53JgQuQvWcOZSOQO2fbw==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="11811444"
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; d="scan'208";a="11811444"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2024 07:53:20 -0700
X-CSE-ConnectionGUID: HncV/WkyTrOPVLAOSFeuCw==
X-CSE-MsgGUID: qxuffOh4Q9mzfeFsWgP2+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; d="scan'208";a="36463409"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 30 May 2024 07:53:20 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 07:53:19 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 30 May 2024 07:53:19 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 07:53:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pv9+MjyJteEB5NvWLuVoGfer6ZGwiQn/dOKzgpX/Hv48WvRRB6ljfTMJx4DxrmESTK49Ea+2gG46VLPG6RoA0rwNEBB7ELrLv4pEOpWkVYRGr9Bln2eIYkVPKXqTykd48xj+AbHA8URELw62Ac3wnOYQ6pfy8SXxZ1C1FY6H7Ch056gxcQY2Xgwptr8GAOVdmBvaG5EtDikV2yRMmm8vrBXfP+Slb2WhUO2p2eL+M3kXUpRvHQpyvJiHfpwbgo1WGSx0vce6w9iq3WzldyXPUsEwsN3XnaLdT37Z7fNhxlDhrxmSOvaXqhRB0HfkIeECoDTizsDlV8SiEsAzCSc1vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhBo5VLSf3dr4OB8B/Yq0TQ1K7XElhrnu6OOA4qoGJ0=;
 b=HBKisO+y1+7EFGDEnHFGupkMiF72OCzvGz1SfgUl9mcIMx6wneZAygwxXXQo3yPoCi6GpZnNzEIMAWmiz6niSw2ktMjznHQxsKgGcMvP32P6xBSIObn8Ghd8t2kIS8EP8Y7GAk8VvMLSYE0tSGdtzTwz6qCsRjISo/xldpitfQipx/PCnHIAyW67h++DA0+Z/gyCnedWsVwp8AdSX5hFLVphlQvt3CnrV2Z9g7EL+XTqu+NBg8QkyZplBzOd2selkrHXfLIuTF2ovRPFP0aHS5tgiStWZm9C8vdRW3xDfY3irMpRvow0dyUBOkhdtGBjl3G2YE0fL0wBjgPKR3VQ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5296.namprd11.prod.outlook.com (2603:10b6:5:393::22)
 by LV8PR11MB8463.namprd11.prod.outlook.com (2603:10b6:408:1ed::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 14:53:17 +0000
Received: from DM4PR11MB5296.namprd11.prod.outlook.com
 ([fe80::a82f:27ae:a8d9:6a81]) by DM4PR11MB5296.namprd11.prod.outlook.com
 ([fe80::a82f:27ae:a8d9:6a81%5]) with mapi id 15.20.7633.017; Thu, 30 May 2024
 14:53:17 +0000
From: "Brunham, Kalen" <kalen.brunham@intel.com>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, "U-Boot@lists.denx.de" <U-Boot@lists.denx.de>
Subject: RE: [PATCH 1/1] Added arm64 assembly for examples/api crt0
Thread-Topic: [PATCH 1/1] Added arm64 assembly for examples/api crt0
Thread-Index: Adqojlev93VX2sPCRR6waFJsm7XUJgC82DVQAAZzj4AAAJoS0AAAJBKAAAAadUAAAv2KAADFJ5OAAGQbwwAAk4NdAA==
Date: Thu, 30 May 2024 14:53:17 +0000
Message-ID: <DM4PR11MB52966C57EFE2BE722B9E8DC1E3F32@DM4PR11MB5296.namprd11.prod.outlook.com>
References: <DM4PR11MB5296B1B9F0CFC701A8B11284E3EE2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <DM4PR11MB52961423BCE12552857A12A8E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521162543.GU2568172@bill-the-cat>
 <DM4PR11MB529670F5CFDA6B4EDA7B7206E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521164659.GZ2568172@bill-the-cat>
 <DM4PR11MB529668DA50F05F26AAD229F0E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521181534.GD2568172@bill-the-cat>
 <d5887c6d-fc80-4f89-be51-db9b8da3863f@app.fastmail.com>
 <20240527160708.GJ2568172@bill-the-cat>
In-Reply-To: <20240527160708.GJ2568172@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5296:EE_|LV8PR11MB8463:EE_
x-ms-office365-filtering-correlation-id: 635f02c6-5c7d-4e86-4d71-08dc80b83d89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?UytDQXRkeWJtUUZwYzcvNVVqUURicVplM0lxQXFISjkrVGdnRHRRR214YndD?=
 =?utf-8?B?cHB2dlhzL3ZobkVtOXZJUGRGb0UrVVNvYWtPOGZlQWxnSG1Tdnl3ZVEzVVZR?=
 =?utf-8?B?aUF5VDEvWXcxZXhNN2NyWTZSeE5FNVU0SWFiZzdhdDFNMTJXNzFpM3N0LzI1?=
 =?utf-8?B?bThFT2pIMUtLVkt4SFd3ai9Kb3JXYWh2UndiWUFvSDlENWh6aldYNVk1ZjNs?=
 =?utf-8?B?UlRXVlRGVS9PR21VMThrOE5hR1lLUHFJVmtFS0RidFlnbmxTSjRrMWxPcXdD?=
 =?utf-8?B?VUJxUTZSQVRxR3hEc2ZoVndjMG1yMWRyT05rWUFremVwRk5hWmFlam1YRER4?=
 =?utf-8?B?MW0raEtpb2JKSVQxNmcwVG5PNmQ4Y3pZOWhTSHhiM3pIaVlrMUNneDlNbldr?=
 =?utf-8?B?eVp0M2hram8zMGduTi9jSkVaSlhPczlEN2tLeEVjbGlSMVJ3eXFUZzhZMElP?=
 =?utf-8?B?eE5wd2dYNkZlU29QZEEvVWlqTC9EV08vT2l1bVFIcUpIL2l0SFRaWkdUZEZo?=
 =?utf-8?B?bTJzNTFJTWNKYnhnNThEdC8ydUx3bnFNQ2wyaGxydWROdEhtWlk5TWJWVWFW?=
 =?utf-8?B?U1VxNHBBU3Y0YVJjbFlIeVBTbmQ5QjBNYnFoajJPZVNoOTVpV3hsU2I0VnQx?=
 =?utf-8?B?QnNNOGpkS1RhaHk3OWlVNXdoWWcwM2oxS1ZlVHViK2JUMEt6WnFieUllSXVO?=
 =?utf-8?B?bFRPc3gvQVBvZTl6dUNnZGhrNExaMlBDS0tCSXlGcStJUld5NWtvU0V3bEQw?=
 =?utf-8?B?dUxxT1FJajgyVFdHNzVyaW5xNSt2L0dHb2V4UHc3WThMVk9PaE44dXRBYkds?=
 =?utf-8?B?KythY0IrTTBHN1JoQ3RBdDdmUWFvamJyRFVPWlYzd2RxczBPRXprQ1NKOTFW?=
 =?utf-8?B?K0lBeWN5UUdqZmNWYXFPYU9iMFdFMjUyRnhHYlFCOEowQzVMOUgxa1ErRVdT?=
 =?utf-8?B?Si9mOWtqb2svRTFjRDZjNExVd3JIUUtkdzBVVDZsRTJILzEvR091RFBBTDgv?=
 =?utf-8?B?R09GOC9xOUgyVloySGRaRXN6dU5JejVFVG1TVjdZQyt3bGZMNDB0K0NuTFh6?=
 =?utf-8?B?VWM4SlB5NjRmeWs2dzVTeHVJdWo4ZkpydU9rVStFQnJpa1Y3bStMSjQvNERD?=
 =?utf-8?B?WllpUmdIYlVvcUJpQlF1NW9ROVZncGgvTnAxeUpXWDBWSDhwWGlDODlBWFRU?=
 =?utf-8?B?YXFsUy8xOUtSb2lsUlhpMFo5a05qdDltRk1HSGF5aTcwME45NXA1b2xYSmRD?=
 =?utf-8?B?RHRHbloxL1RvUmJUSS9OdnZhc3ROOHVSenoxYkJYY2duNGZWUjdmYWVYdEdJ?=
 =?utf-8?B?RU1LbmdpT3NWTkZWbEFvb015RFN5NTN5ekdiWHVvMVBocmJqSmlvVUN2ODdm?=
 =?utf-8?B?NW1xZ3FtUUJ1MWxqQkhsK0pDOUEvQm5SNzIySG4yakE0WTBDdVNnTm15L3FT?=
 =?utf-8?B?aGZMeTk1LzV3Wkg4MmwvV2FJcCt0MUw1ampHaVhHeU5XZ2lPTHhjckYwS1hN?=
 =?utf-8?B?anl0Q2pqTnNaTXdhdUVWcTA2NGk3dkxITnZNcWJTTVdJVTIxMUYyckkwVWJk?=
 =?utf-8?B?aUtMNWpzNlZPczFjN3RzM3F3MWxvc0JrK2kxWHVsdCtiMGVaNGxPUWxmZHQz?=
 =?utf-8?B?L2Q5ZER3ZERRcit4NDJ6eVpZUXZoc3pyNlhUbHJ0cW40RHVCK0c5eXJlck13?=
 =?utf-8?B?NWJGOUtWVUZ3S3FjVFRkWHlFcU5jSWlncVBVQlpGZFdEU1krK0NQU1JPbkc5?=
 =?utf-8?B?YjVkUVZrYmNkcC9BSFZlSWxLdVNMUFZBMDNoOEJwSjFLUFZCZVRwYng0OUtW?=
 =?utf-8?B?TzRaYmNpT3d2ZmdMNDVFQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB5296.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1I2VVh5MHorcDQ4bEtxZlBKOEpkdFdiWjA1eEovR3ZyUXNEckw1cUlBdkdN?=
 =?utf-8?B?dVRZSFRsdzI5RlkraC95aEQ1YUtJWWRjL1BYOUR6WGM1V2dWTlFQbnNFZnFT?=
 =?utf-8?B?SVpROVBFQ3Z4ZUtnOG5ST28wMEMxbzU4NFVsZ2lyc3dkVTUrT3gxeXFMckdq?=
 =?utf-8?B?bUdwcWJXdm44VnMrT1VlcjJsNlFZTGZiOWNFRFNEaXVvRno3bkduazdNV3Q0?=
 =?utf-8?B?S2NVVk9lN1BxcTJkSWlyRi9vS2Z2ZVlnYTgycTdYZ2ErS1hBYnJzSkdHd1Vo?=
 =?utf-8?B?Z2oxbEZGZ09ncUdsYWlHdGg0WU1FcnlZWFpuMmZpUTg1R3BBai9LZW5Cd2Vr?=
 =?utf-8?B?YjFHYm0vMTNjNEpHK1I1cW1NWnFjMWgzN2lLaHpmbUNTYmo3Wi9xQWdqS01B?=
 =?utf-8?B?OXNRTDB3RU5IVXhoZWtnYmluWm52U2xoeDRNK3drOFBoNWpIamZhNVQwV3V5?=
 =?utf-8?B?MEVEbkhjY0N2WjByTkNoaDBnNis2V2V1RFV5T2hsbUZ6L0JrTFdZaExqQWJ4?=
 =?utf-8?B?WXpkRU0zOWhaclYvaDFlK2FnVWF2aUxiYXB4Q1Y0cWttMUdBQW45SXJCZjJp?=
 =?utf-8?B?NlVQN2hVbUllb050NU9KdFN2Y0o3Uk4yV21GV1VUR040VS9PS3BVaGN2dno4?=
 =?utf-8?B?eXFEdWN0MnRoNDBHSUdmc1NiMmFoSnJVM1NyN3hnWXlKOHI1N2FtU2xxTkFL?=
 =?utf-8?B?QUFPQmY0R0owcUV2WUlOZnBlMGw4cW9ySEZUb2xLQ2tPTUJWNm9ndk4rZzJ5?=
 =?utf-8?B?R3F3Um9SQVdOeC84SGNqNmJ4WStCd0ptTTVETVZQZjZjR1puSXBqTXRPQ21q?=
 =?utf-8?B?dWxzR09wb3Bpc09odVJucXJJVE0vSDUyUmxaVEJqMHYvSGFNTkV4bFNRaTJx?=
 =?utf-8?B?TndCSXc4Tlh5OFlYNm1xaml6R0M4ckowY0VwWEd1L1JPY3RXeVJQMTRHSS9P?=
 =?utf-8?B?YUxlWjl5a1VueXBDQlpZbVBuZTN4OWRwVDNHWkFxUzlaOHk2V0J5SGZqMVBy?=
 =?utf-8?B?QnJld0gxbjNRRFBzR1N1NzFHZVl0V1JwTDBOR0NucFhaTE9YZktJWWtnbHJV?=
 =?utf-8?B?WktxOGpOZlVRalN1a3R6dGlabW16Y1IyTFpLTXJiL1BlRFRYTG1oYnNESW1j?=
 =?utf-8?B?T0s1YmQ5T2ROSWlVbnkzdDVhWFVROHJNdFdZWGJqR0R2M09xZEpiZnZ4cW5U?=
 =?utf-8?B?S3BNd1Z2SFVZYnVPdjhCTU1CV2RlWHQ2cUhSTzBySy9XL2JkUHpHVnVPTFJV?=
 =?utf-8?B?eWhwU2s0ZllWYUVZN2lMWTNiQks2WmZNei9KOUwyZ041K0ZTYm5QWTRNblJ6?=
 =?utf-8?B?T1lrcXFiM09sL2ZhcUhxSGFhU2JIQld2VDBMc1lRZ0ZtanQrY0VPZGRVNHVz?=
 =?utf-8?B?TEIvMWpod0pOTFNvZCtaTU93Y3kwUFc3SndlNStGcmp1VURLWGdUUm5kSEpY?=
 =?utf-8?B?WGR5eGFhbnVBR0tidERCeUJuZnhaUGUyRXMxSzlFV1NmVzhoakRnK3JsUnJC?=
 =?utf-8?B?aHQxaG1xRElpOWMzaWFIN09VYzEyakViUnNBLzNPWEFFb3BlRy8xYzh1QU85?=
 =?utf-8?B?RDNiencrYitRY0JnRDh6QVJnMXRsUnpYSlo4S0NScThieitYdldjeEhwMlNL?=
 =?utf-8?B?U0FWZ2tKSUMwUWVyZmJqcU4vK2FsYUJZeWVoTGtaajVjOThMMVFHR3RWODdq?=
 =?utf-8?B?SldKVXkzdGFXblFMY21yeTQyYzlYOXhjeUdhSnQ2QWQ0bWtWdWlWclczQUlO?=
 =?utf-8?B?OVFEcDBSbFc4ZlphMmZjSisvMnRXc0FZSzVNbTIvQ3UzZnRCR0puelZTelFW?=
 =?utf-8?B?YjRxU1p4dktqbmFtMzQ2dnNKbjAza1RISGQ0UC9yTlBianoxYmd2OElUR2sy?=
 =?utf-8?B?OEx6b3VkeFhhaUN5U3FJS1hwTkkyQ1JDWjYzRHptbjQzLzhNWXNRL1ZnNE8w?=
 =?utf-8?B?TEx5SVEzT0NrTUtya2VVTXRVNUVvdkMxbzUwdlJUUTZBa2ZCNU9VN09Ud0N5?=
 =?utf-8?B?ZTgvOTExZENKa1IyTHlRaEdZUW5ueC9tTDJIRUhlTEk2ek14NHZoZjFZa3B2?=
 =?utf-8?B?SWNZOTFZWXZtVndMOG9QeGpFdVEvZmp1TElTeUdsVXNNM0lmQlVubldOYi9l?=
 =?utf-8?Q?Nbdn9Pgx4NAdhxVt+wkxcYjNf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5296.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 635f02c6-5c7d-4e86-4d71-08dc80b83d89
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 14:53:17.4157 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YPovSjO43Ds8ORkhx5a2nTVXhUzv4mu4x845l3opnGkv958fTt0nHM4GKXeiURWiF8Bas2LxnQ1kMyQ1HjlvAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8463
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

SGkgVG9tLA0KDQpXaGF0IGFyZSBuZXh0IHN0ZXBzIG9uIHRoaXMgY2hhbmdlPw0KDQpJJ20gY29t
bWl0dGVkIHRvIHRoZSBpZGVhIG9mIEVGSSBhcHBzIG9wcG9zZWQgdG8gZXhhbXBsZXMvc3RhbmRh
bG9uZS4NCkVGSSBjdXJyZW50bHkgcmVxdWlyZXMgYmxvY2sgZGV2aWNlcyB3aGljaCBpcyBub3Qg
ZW5hYmxlZCB3aGVuIG9ubHkgdXNpbmcgZmxhc2guDQoNClNob3VsZCBjb25maWcgQkxLIGJlIHVw
ZGF0ZWQgdG8gaW5jbHVkZSBETV9TUElfRkxBU0g/DQpTaG91bGQgd2UgZXhwbG9yZSBob3cgdG8g
cmVtb3ZlIEJMSyBhcyBhIGRlcGVuZGVuY3kgZm9yIEVGSV9MT0FERVI/DQoNClRoYW5rcy4NCg0K
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFRvbSBSaW5pIDx0cmluaUBrb25zdWxr
by5jb20+DQpTZW50OiBNb25kYXksIE1heSAyNywgMjAyNCAxMjowNyBQTQ0KVG86IEppYXh1biBZ
YW5nIDxqaWF4dW4ueWFuZ0BmbHlnb2F0LmNvbT4NCkNjOiBCcnVuaGFtLCBLYWxlbiA8a2FsZW4u
YnJ1bmhhbUBpbnRlbC5jb20+OyBIZWlucmljaCBTY2h1Y2hhcmR0IDx4eXByb24uZ2xwa0BnbXgu
ZGU+OyBJbGlhcyBBcGFsb2RpbWFzIDxpbGlhcy5hcGFsb2RpbWFzQGxpbmFyby5vcmc+OyBVLUJv
b3RAbGlzdHMuZGVueC5kZQ0KU3ViamVjdDogUmU6IFtQQVRDSCAxLzFdIEFkZGVkIGFybTY0IGFz
c2VtYmx5IGZvciBleGFtcGxlcy9hcGkgY3J0MA0KDQpPbiBTYXQsIE1heSAyNSwgMjAyNCBhdCAw
NToyMDo0M1BNICswMTAwLCBKaWF4dW4gWWFuZyB3cm90ZToNCj4gDQo+IA0KPiDlnKgyMDI05bm0
NeaciDIx5pel5LqU5pyIIOS4i+WNiDc6MTXvvIxUb20gUmluaeWGmemBk++8mg0KPiBbLi4uXQ0K
PiA+DQo+ID4gV2UgaGF2ZSBsb25nIG5vdCBkb25lIGEgZ3JlYXQgam9iIHdpdGggdGhlIFUtQm9v
dCBzdGFuZGFsb25lIEFQSSANCj4gPiBzdHVmZiwgYW5kIGZvciBhIG51bWJlciBvZiB5ZWFycyBh
dCB0aGlzIHBvaW50IGEgbG90IG9mIHRoZSB1c2UgDQo+ID4gY2FzZXMgaXQgd2FzIHVzZWQgZm9y
IGNvdWxkIGluc3RlYWQgYmUgZmlsbGVkIGJ5IG1ha2luZyBhbiBFRkkgDQo+ID4gYXBwbGljYXRp
b24uIFRoZXJlJ3MgYSB3ZWxsIGRlZmluZWQgQVBJIHRoZXJlLCB0aGVyZSdzIGxvdHMgb2YgDQo+
ID4gZXhhbXBsZXMsIGFuZCBmcmFua2x5IGZvciB0aGUgbGljZW5zZSByZWxhdGVkIHF1ZXN0aW9u
cywgbWFrZXMgYSBtdWNoIG5pY2VyIGFuc3dlci4NCj4gDQo+IEhpIFRvbSArIFUtQm9vdCBFRkkg
Zm9sa3MsDQo+IA0KPiBTb3JyeSBmb3IgY2hpbWUgaW4gaGVyZS4NCj4gDQo+IEFGQUlLIHRoZXJl
IGFyZSBxdWl0ZSBhIGxvdCBvZiB1c2VycyBvZiBVLUJvb3QgQVBJIGluIE1JUFMgd29ybGQsIA0K
PiBtb3N0bHkgZm9yIEJhcmUgbWVudGFsIGFwcGxpY2F0aW9ucyB0byBwZXJmb3JtIGNoaXAgZGlh
Z25vc3RpYyBvciBwcm9ncmFtbWluZyBzdHVmZi4NCg0KVG8gYmUgY2xlYXIsIEknbSBub3Qgc2F5
aW5nIHdlIG5lZWQgdG8gZ2V0IHJpZCBvZiB0aGUgYWJpbGl0eSB0byBydW4gcmFuZG9tIGJhcmUg
bWV0YWwgYXBwcy4gSnVzdCB0aGUgYml0IHdoZXJlIFUtQm9vdCBleHBvc2VzIHNvbWUgQVBJIGZv
ciBhIGZldyBmdW5jdGlvbnMuIFdlIGRvIG5vdCB0ZXN0IGl0LCBhbmQgSSBkbyBub3Qga25vdyBo
b3cgd2VsbCBpdCB3b3Jrcy4NCkZvciB3aGF0IHdlIHByb3ZpZGUgdGhlcmUgSSB3b3VsZCB0aGlu
ayBqdXN0IGRvaW5nIHdoYXRldmVyIG9uZSBub3JtYWxseSBkb2VzIGZvciBiYXNpYyBzdGRpbyBm
dW5jdGlvbmFsaXR5IG9uIGJhcmUgbWV0YWwgd291bGQgYmUgZmluZSBpbnN0ZWFkLg0KDQpCdXQg
SSBkbyBuZWVkIHRvIGJlIGxvdWRlciBhYm91dCBteSBpbnRlbnRpb25zIGhlcmUgYmVmb3JlIGp1
c3QgZG9pbmcgaXQsIHNvIHRoYXQgb3RoZXJzIHdoaWNoIGRvIG5lZWQgLyB1c2UgaXQgY2FuIGNo
aW1lIGluLg0KDQotLQ0KVG9tDQo=
