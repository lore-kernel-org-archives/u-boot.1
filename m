Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59535CF9C6B
	for <u-boot@archiver.kernel.org>; Tue, 24 Sep 2024 06:02:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFD1B881C1;
	Tue, 24 Sep 2024 08:02:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="iS8fDbsJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FD4087705; Tue, 24 Sep 2024 08:02:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4FA988387
 for <u-boot@lists.denx.de>; Tue, 24 Sep 2024 08:02:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1727157750; x=1758693750;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=B1nqr6LA1nIth5gGP5zGdNtCdQ5SckjjqbPldrmQVZU=;
 b=iS8fDbsJmm5664T2v301AXFDqS4S/G5hhMOCUmbi29cAqkNEWY5ReTNZ
 xBO9tdOGhGIOzypmLGA34GSaJOSB25/kpXT2Yrh9yRLs/hVb9VJEHX2tx
 ElXZMYSZnnFODIxvYSuU9R74zrVUPFVui4NV0Rqc2ObiieCmc21SqeXJc
 RkqdVkPl4Gw9girv5ZO2BwZGPwLV8BRThlfOVB83kXIh4FVIPjLF0y2eN
 gi5+Oe7ERoiF7N/wyK+iSzzelsARRd/76vy6JotvNz4Yewmxf0TQBb2Em
 xqA8IxEpNSJEpTu3G1H5ZCXRhWh5JCvs/E0RXJHFiWsA/K3cKG6aU4ZiW Q==;
X-CSE-ConnectionGUID: j5JoEDApTPiKKEsR/Ywhkg==
X-CSE-MsgGUID: 6WeYYaruRLOPd4ZtueGYYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="25647070"
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; d="scan'208";a="25647070"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2024 23:02:14 -0700
X-CSE-ConnectionGUID: ITlYqed6Slec+eGFKFtLKw==
X-CSE-MsgGUID: laZSa4Y8T5azWgKHKhzo1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; d="scan'208";a="76079834"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 23 Sep 2024 23:02:14 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Sep 2024 23:02:13 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 23 Sep 2024 23:02:13 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 23 Sep 2024 23:02:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vAOZ1duDCKQc6K5zTxaF89FS1X1tPr16N/TFkdLE6VJjzzQsWWu73HjzwVezlV+TTX9KHf3EUgH/hzsXwcUVFr4KIuJUwFDmG/YVc1/li7vyNWuwnb6QBT3bIXHPCMOyQ5Ka8XzKLsct4v3w6ij+lvOHfcKQNNfe61SPlZErG3lL6OGxtavSW6Chg2LBl4Q0+562rhJQwR/bg6w9lYubDsFBJqg67FvY3mImdBp9DH1LCeAES2G9pQeSmWXsFptUthcdz5qg6UPOAaF0LPdxw+InN7Q1IS0GPMt7snOHGJHu3bPZe+oOlroiw0w6XR3gc2LuKW6acPWK4vidCmqS0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1nqr6LA1nIth5gGP5zGdNtCdQ5SckjjqbPldrmQVZU=;
 b=iusFpMTCgWcGgVmvLHhBMOGrFBX8g8MeM39GXEyv1vvWmpAcn1bvNnILMjvw+YbhVE+HqA3+h1xjdPvfOwjstjHAlx9Ry1TOYuNiMOlQgDg3q4c/7RvzD0pSM9YWziLBBOPj0YFE5YJ/SqK2do2hozvHoBTO4au3N1lh4VvIXz1E4bDdU8JHUA7hroL0bOYlm+w6q1rnzoSxLgcQAqGtivNdJst3dWlqbZZP3EAiJGwxc8JnyV455NAh/UiQMcI+bxiP9Cv26WTN2P5SHKdoIGTG+jEC/hVOy7m8EKuHfwPXxfwsXQ7ABenV8UmXUkxtCz8Bzwbyi+0B9SxfhvsWng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 CH3PR11MB7795.namprd11.prod.outlook.com (2603:10b6:610:120::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 06:02:10 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe%5]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 06:02:10 +0000
From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, "Meng, Tingting"
 <tingting.meng@intel.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@intel.com>, "Hea, Kok Kiang" <kok.kiang.hea@intel.com>
Subject: RE: [PATCH v1 08/20] arm: dts: agilex5: Enable XGMAC
Thread-Topic: [PATCH v1 08/20] arm: dts: agilex5: Enable XGMAC
Thread-Index: AQHbCys595Xy+QfqzUelHQSJaf/ZbrJiRCeAgAQzT+A=
Date: Tue, 24 Sep 2024 06:02:10 +0000
Message-ID: <DM8PR11MB5592C2455A4CFA9CDE0F6DD8D2682@DM8PR11MB5592.namprd11.prod.outlook.com>
References: <20240920070242.20884-1-tien.fong.chee@intel.com>
 <20240920070242.20884-9-tien.fong.chee@intel.com>
 <92fa9c17-bbf4-49b5-8d7c-4b7d06f60736@denx.de>
In-Reply-To: <92fa9c17-bbf4-49b5-8d7c-4b7d06f60736@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|CH3PR11MB7795:EE_
x-ms-office365-filtering-correlation-id: f8ad3bff-1eab-4abe-4df2-08dcdc5e6d80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RjFoem1YaDEzdTRlQlJvdzRjRTBXSW1BY0JvVm11YVdtOVR1ek9zYTNvWXJS?=
 =?utf-8?B?VmNQT0lNbWEvOFBZQW1YclkyRWg0ZWtzbFZDZ05TOWx4aXp0cFo1YmVBazlu?=
 =?utf-8?B?UWJlQ0VRWGUzbEZsbGN3bnUxbEpUcjZzazdQQVprMU5Rb0tGZnR0d2x1T1R4?=
 =?utf-8?B?T3FXczIwVGQwMGJZOVY1VUtjZW5lclJpWGYyUHpITEo2OEJrN29hWHh2Vk02?=
 =?utf-8?B?QjhoeTdXTW5LUTVrdDFkOFUwaU1ublBTcXh6MElseE5CZG9uR2NreTFxWVpt?=
 =?utf-8?B?eFU2dXF4eUp3WXhVYWEzS1pkUGc1eHFtdUEzMit6MGJqU3hHODdFNUhmb2Jh?=
 =?utf-8?B?clVaSUFmbzRubktyUzRHL2V6YVFXUHdiMlFiZEhlNzByS3l4aTNYR3FxYWxI?=
 =?utf-8?B?NGRmcmdVYkJIUGpLQXJUOVVCc1NSMVJPMm9Jb3FtRVNPU2t5OU0vRUcxdWl4?=
 =?utf-8?B?bm51aXRac3FFMDNOODVsdFBubVF5a2U1MnF2aFJ4TWk1eTNWYjFRSW02dnhO?=
 =?utf-8?B?SEZOZXl3KzdUT2pIcXVYTmtFUHkyU25OTXhlTU9RY2d6Y2NrMC81bE1LQkVE?=
 =?utf-8?B?QjRWM2dRRkhtOFZNQk4yKytSa002KzQ0QXp0WXY0VDlCaitBdUpXaGhmdFNO?=
 =?utf-8?B?TS9UK2FQY0h4MEZGQjdaeFVjUkRKN296TGxkVXZWejdBSzd2QmtnaG1CMG1s?=
 =?utf-8?B?TlBKRmRKdlB4b2pxc2tlMFFVMWJRN1BEZk80bEE2cyswN3dVaGFsSVhxK3ZS?=
 =?utf-8?B?bDNyZXlxdkw1SE9PS05XcEkvRjg0U0hGRnNLK3F1ekpPU295ajFDT1FHSjQ3?=
 =?utf-8?B?aGhSL1FSWHY1NFp5aHNVVHVIR3NRcTV5RUhOYzNHelN5WUFGNmFXb0NwTEUr?=
 =?utf-8?B?QmFlU3A1N2c1SlhXUWdvSHdYMSsyNEM1Sm1YT1YxQkxDSW1pTTdEZUlWWU93?=
 =?utf-8?B?d1MwbVQ1NUFkMnRubGVrRnd6UEw4WWlLazhkODFXbXBOckwxSmJqWFdtSmtM?=
 =?utf-8?B?OFl1cGtLbHdFYVhqUU50OTllRTlscTBoWDZOdGJzUVlBYWNmNE9GMFFYS3VQ?=
 =?utf-8?B?dzFvbEs3R0JKMHdjZjRLZHN3R01TbTJqSTJ2RGFCdGdmQXBkWSsxbWEwWjgy?=
 =?utf-8?B?cHl5eFhody83MHFzTmNWTnpsSzlodCt1d0ViTkY5My8wL3VRTWU4bU1DTktB?=
 =?utf-8?B?cE5QT2huRStSVi9uK0g4UWRzcXRuY1lwMlRKaWpTUzZvNnN2OUErVktzKzho?=
 =?utf-8?B?UWUzMmVpc0NYTVpSVzBoQ1pnUEVoUEk5OEF6SUpSUHdPV2hRR0FtN2NXbk5R?=
 =?utf-8?B?dWRQMk8rUGhNdC9qWUI4bldVeFNrUk1vU05hUXkwdWp5QkNTTEJJRGk2NzVM?=
 =?utf-8?B?ZVZUdDBpZzU1V1JudkpaSkJUYlh0VXR0Ri9sVkNwTGkwc1E2aVpweFZPNGwv?=
 =?utf-8?B?UHd1dzF0VkpnS3FoMEkvakV3Vm1rL2ZoUkNRckdQTXJ1KzZoaFpYOUxndGtS?=
 =?utf-8?B?KzkrMitVN0xVVkk2b3BzbzBqQklvV3FjbFJxYWdKTlF4dWRaQnJuUHpPbERC?=
 =?utf-8?B?RWJ5MUZJMXk1VTBDUWx2a2tOaFJMK3dFOW5jYkd6UG5ERHZ5SVNOV1NQcjFL?=
 =?utf-8?B?VGMydmdGSzJsSnhXWUJOdGNnczVlV2t6ZXNQejRnRXVqQThEdjVrSk9yVGdk?=
 =?utf-8?B?SjBxTmpCNlBxYVZsQ056THBlNWZIWjl4ODgwUGVRRmtSOGdGakhFTkxqZDcy?=
 =?utf-8?B?dndPdVc0OENKTlRsYVdhbWw2eWVsZHFjb0lXSDkzQk03U0puVXRVa0lneXQ4?=
 =?utf-8?B?RERGY1RnM3IxNno5ZEZ1ZFpyOG9yNHlzd25tZld0TjhuSld1dlVwTEpWRkc5?=
 =?utf-8?B?VkVDSzVtVDI5TWRrZjBZV3BZL2t2eVpUTzlrQUowS1NBT3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5592.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlV6RDQ4RjhpcG1GakU5azl1c2hYS0hKVi84SkoxaDF0bFA4TXFtdnd0dmhW?=
 =?utf-8?B?eWdjbWZZMGNBNE1lWTJ3Mi9SUmh4aEpWUjdYZzNkYjdNQ0ZQaU56b0VmUm8y?=
 =?utf-8?B?Q2lhdzVzWGRSbUNRb0Uvbjc1ZGR1UkxrY2gzMlNOVlQzdmcwdmRYRGhFS0JB?=
 =?utf-8?B?aHZPeExMdDlzaG5hVkU0U0tpczNjanBBTDNMQmhnVFkxZzR3d29PWUtwL0Mx?=
 =?utf-8?B?ay9id01JWmVGZmZ0aU52NDAyTnlkSWM1ZzlsK3BTNWhTNVJVdm5FbkJXL0ZN?=
 =?utf-8?B?K2RUQ3YxWnh0aWxhcEF5c3Mxc1FRcHpEbStDajhJWk8zNEJPbEU3bHlIeGdU?=
 =?utf-8?B?L3prZlllSWZyQ3ZVNUxZQlowbjJPSWtnOXBIbTVBRHVRcmtoazJhY3g4bStw?=
 =?utf-8?B?WTFWM1AxOGxGemtVSDBsRStlWG5GZHBCYUN4bzR2M3JvRmxFOVJTUVpxeHIr?=
 =?utf-8?B?bjcweWg3ZDAySGRKLzJWRGFHc1ByaFRaWWI5QmpDazlvQ21VdnBLTkFNTHZI?=
 =?utf-8?B?MER6dVg5QVlJWVlmV3Fmb0VzaVF2ZVVQeWQ3ZWdQN1p0Q080MmR6TmpHcWEr?=
 =?utf-8?B?N2NYNHNVanhBSzhvVjBzcUwwTFpYcE5RaWRXQzBacmxMbHB2VllidEtORjQv?=
 =?utf-8?B?N1dEdjluSGNVckxBcjZUYUtNUEZaVVJyMCtyMWxGWUtWVFBWRU1hdFRxM1RV?=
 =?utf-8?B?bytEVUxPY295blFWenFiOFdJc3daTnY3NG9oWG05UWRKUGVPRUpRKzJlZUU1?=
 =?utf-8?B?SzRNamg5Z2J6TWp2QVBuYzZQM1dyNm96L01oSGQ0MWdET3hLeVBkMFlkSmw1?=
 =?utf-8?B?blpsbDN1MHBZR1ZuZTh4a21kVkdrdWJhMXJrMHZaK0RDT0VDS3IxZERReS9X?=
 =?utf-8?B?YzNwK0Vtc0lmN1dITGxuWnhldWtzT1VuU0E4NW9IRjZ5WklvZys0RWEwTTMr?=
 =?utf-8?B?SWhkVWRBdTdLNC84NWgvQnRSS2lMTk1iUStJLzFnc2RRTDV0QStXZnhsWW0x?=
 =?utf-8?B?NkxoRzdYd0NuRlc3UnhrMFFhUHMvUk9icGtyTk1pT20wWERtZlc1Znh1eFVn?=
 =?utf-8?B?YkhwL2tlS2J5S2tMZWI5c1NoY3E3OTBGN0FhR2J5clkrbzBXcXdQZ1doWHVt?=
 =?utf-8?B?cVg0T0RmNytEQ3lEZWxFQnFnZUgxL2ZSbVR4ajRuakxrOW1PTnhQcm84eWZq?=
 =?utf-8?B?Sm93ZW0zOEMxRUhNNS9CRlBCOUdzcDh4TWdqakdrRkJlR3B1R2huRjdnR3p0?=
 =?utf-8?B?M3JEL0xXOUlLTkk3OUJydmdmN0pDQnJnNkFKQWJWVHlDUzQydnhHcDcxNzdu?=
 =?utf-8?B?clNFcmVTODZ1a3BEUS83eEl4cWtabGZyMEY0TkR5T21US0lVME9lcUN1b2dB?=
 =?utf-8?B?MWFjN1BTMUlCT0lVczFwdVZqZUFXT3lCanpTZU9VSmI3ZTIwZ1g3OC9ZdUxK?=
 =?utf-8?B?a3VnbFVXNWl3UnVOdmpEemVLSVNEM05aSHMxb2dJeGoxbHhUNngxRlFLaWto?=
 =?utf-8?B?M2JhZFR1SHNXYUF3UjNIL04wZENnUndCV3VVd0ZLUnlpakdiZ2xqU2w1UkFL?=
 =?utf-8?B?enpoenpRNEwzbEdDd3FnenMreXJJbEM4TE5RRkJ6b1FlME1KNlZoR1VlLzdn?=
 =?utf-8?B?MEtiRlVzdU9CajY1TU1oVzZWWk5zeVlBNGJEZ25tNndURTVkUE1EaE1Idlg0?=
 =?utf-8?B?R3hVUjBVTDlqVWQ5eElpTTUyUGdCT0QrQlhzNHVWTnhJVndtQmpDS3BFNFAy?=
 =?utf-8?B?VmdNV1dhRng4RzhYckNtNEh3SDBKSEZheUhtaXhjL3JiMWhRN1RBeE5LSEZz?=
 =?utf-8?B?bC9Yd1o1TzNsZU1pT2VtTHd3NmRMZ0tsOVdkSkJ3VExORmVlS0hWUDhRL0px?=
 =?utf-8?B?Rzg1ZFNkNTA0QUtXTkJtcnNuMkNRWmtodjJGZzl6aTFUTDU2OUF5RWlpRjFU?=
 =?utf-8?B?Vzg2TGFqRXZ1TXRYYXdJNkxsSTFlUXA3QXNmek5aSTJwelV1c3FmdUFhUnpK?=
 =?utf-8?B?Ky9pUkVTaEJYajBnbjRVby80RmZWdEl3aC9oREZOeC9WdDgzbDk3MkpPTURG?=
 =?utf-8?B?STlsdXRMQTQ1Zm1wUTRlZElBbkY2SGJTS2lueUs5MzZaN05IOUxQNnBZZWRv?=
 =?utf-8?Q?T5P7pjeIZK5/EI0j+AWF164j4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ad3bff-1eab-4abe-4df2-08dcdc5e6d80
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 06:02:10.1570 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wH9siWzCDcWzobQjXKrrj4bU/dDFvFbZEM7Pyae2X68CyTRpPuFWbfV7XK4Mn4/AbKONEB+4rpnBRCXfh55KMpKFtRLT1N0hNHhViB9IzMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7795
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
MSBQTQ0KPiBUbzogQ2hlZSwgVGllbiBGb25nIDx0aWVuLmZvbmcuY2hlZUBpbnRlbC5jb20+OyB1
LWJvb3RAbGlzdHMuZGVueC5kZQ0KPiBDYzogU2ltb24gR29sZHNjaG1pZHQgPHNpbW9uLmsuci5n
b2xkc2NobWlkdEBnbWFpbC5jb20+OyBNZW5nLCBUaW5ndGluZw0KPiA8dGluZ3RpbmcubWVuZ0Bp
bnRlbC5jb20+OyBZdXNsYWltaSwgQWxpZiBaYWt1YW4NCj4gPGFsaWYuemFrdWFuLnl1c2xhaW1p
QGludGVsLmNvbT47IEhlYSwgS29rIEtpYW5nDQo+IDxrb2sua2lhbmcuaGVhQGludGVsLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAwOC8yMF0gYXJtOiBkdHM6IGFnaWxleDU6IEVuYWJs
ZSBYR01BQw0KPiANCj4gT24gOS8yMC8yNCA5OjAyIEFNLCB0aWVuLmZvbmcuY2hlZUBpbnRlbC5j
b20gd3JvdGU6DQo+ID4gRnJvbTogVGllbiBGb25nIENoZWUgPHRpZW4uZm9uZy5jaGVlQGludGVs
LmNvbT4NCj4gPg0KPiA+IEVuYWJsZSBYR01BQyBmb3IgU29DRlBHQSBBZ2lsZXg1IGRldmtpdC4N
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFRpZW4gRm9uZyBDaGVlIDx0aWVuLmZvbmcuY2hlZUBp
bnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gICAuLi4vYXJtL2R0cy9zb2NmcGdhX2FnaWxleDVfc29j
ZGstdS1ib290LmR0c2kgfCAzMw0KPiArKysrKysrKysrKysrKysrKysrDQo+ID4gICAxIGZpbGUg
Y2hhbmdlZCwgMzMgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJt
L2R0cy9zb2NmcGdhX2FnaWxleDVfc29jZGstdS1ib290LmR0c2kNCj4gYi9hcmNoL2FybS9kdHMv
c29jZnBnYV9hZ2lsZXg1X3NvY2RrLXUtYm9vdC5kdHNpDQo+ID4gaW5kZXggOWViMjFkNjU0Mjgu
Ljc1YWIwNTAzMWJjIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtL2R0cy9zb2NmcGdhX2FnaWxl
eDVfc29jZGstdS1ib290LmR0c2kNCj4gPiArKysgYi9hcmNoL2FybS9kdHMvc29jZnBnYV9hZ2ls
ZXg1X3NvY2RrLXUtYm9vdC5kdHNpDQo+ID4gQEAgLTEyMiwzICsxMjIsMzYgQEANCj4gPiAgIAli
b290cGgtYWxsOw0KPiA+ICAgfTsNCj4gPg0KPiA+ICsmZ21hYzAgew0KPiA+ICsJc3RhdHVzID0g
Im9rYXkiOw0KPiA+ICsJcGh5LW1vZGUgPSAicmdtaWkiOw0KPiA+ICsJcGh5LWhhbmRsZSA9IDwm
ZW1hYzBfcGh5MD47DQo+IFNob3VsZG4ndCB0aGlzIGJlIHBhcnQgb2YgTGludXggRFQgYWxyZWFk
eSA/DQoNClRoaXMgZW5hYmxlbWVudCBub3QgeWV0IGluIExpbnV4IERULCBJIGJlbGlldmUgb3Vy
IExpbnV4IHRlYW0gaXMgc3RpbGwgd29ya2luZyBvbiBpdC4NCg0KUmVnYXJkcywNClRpZW4gRm9u
Zw0K
