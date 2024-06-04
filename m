Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2025CC25B74
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 03:35:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CD0A883BA;
	Tue,  4 Jun 2024 05:35:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="XvjCG8lB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42CF2883F9; Tue,  4 Jun 2024 05:35:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E7648835D
 for <U-Boot@lists.denx.de>; Tue,  4 Jun 2024 05:35:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kalen.brunham@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717472103; x=1749008103;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=89deH3oB1YKIwsoE6tx+VEVCg1deZ8cz1BRzZeOBrCE=;
 b=XvjCG8lB9hhrcxovSRVksOiqQI01y/0l455IMQoiEXBs9KJeNDT27puG
 hXlNTMrnJtSx6080i5ac1lyUZ8i2HiT2/o0Pj0AVKQ0CjPXlvo+sA8Oco
 X3YupvKBWAj3E3v2qWwEwvSPTPC0wufnrzJL7mQ7sHU8mRmLsHx8a9NOZ
 tyGB4sTZONzrMP003eP92yWDEurHVXNZwWiZheeYHUOZAemseQnsQtbPc
 aEbqJBoYmT9EFZPxbcDP9X/H+0/veiTnvQWqQauHqMHfc33+EISRle1e9
 XQmL7TMz3a6bpzzSuOFw7zGKH3+Fjhmtz0QruC50hMio8qNHWIh7KTi5o w==;
X-CSE-ConnectionGUID: xBJCXsk2Sr2odYG159/kZA==
X-CSE-MsgGUID: 7zRUQl/4SD6Zzu1pzrCOFw==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="31525790"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="31525790"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 20:34:57 -0700
X-CSE-ConnectionGUID: dnv4zqatSIqb9hWEURMlew==
X-CSE-MsgGUID: THW0RcDgTQGzYY2P/F1cgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="37180764"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Jun 2024 20:34:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 20:34:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 3 Jun 2024 20:34:57 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 20:34:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhPrCDR1IPvbmpxIGWKogiJbQjnJyhYIUdViZRxU9qKrARts6FoBaTpWIeiGTHhBivVB0bNtorVJn0Ar2Qfmh+SKff2Lp2qZvE6ss55gUwRFeXd8VckmwzFbhEdTNzDgr9hSzywIKFIIb3e8RXlUYDAPwGwAlw0kfrCsxooUHfn+USADG818QZJHYWDjLbFMCOhhbzycofeNMRWMIMLwRO0As/tFTbXuqczr/NkVv5LifH4OMGgZkefVKvyf8nFP2Vok0vefmM8DbdQFVoUEJqg7Qc1mKv/+DpfAfaqiiqnODOq1TuKf9HZRWHr+4CNSxSkuzcxC1ITGtSA7VuiCTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89deH3oB1YKIwsoE6tx+VEVCg1deZ8cz1BRzZeOBrCE=;
 b=Rk2D/NkjCkC3DveVMTgO0tKfRBEygD4zAjjFPkTsT/3JrTtPYYgC1S3Mk7QwnN08MtkZMVwvM8Ndmfh1sM/QuyjNkFElsXVm0NGNw4bti+Egk0x1Jxh5eS+ka0OJLCt9lRik1Gh2W97HmS1VGkN4CX4pPBm/3JhtLYB0/Cf1RbpqWCTqJ6XTe7VRTenV8Dta6tn9a/JpWHvPUlNrXvnPPPpICzgekb8F7Bf+4hptOZHH5wnDu5bld6aAQW9BR8hrXjRPeEovYPSKe0n1UnnILBXt6Ja7WEOl4GGhpbUULRs/eaG34hhNgtQKZLiRI/OaH+W5P+Z6NXWxvTe9CHUbGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5296.namprd11.prod.outlook.com (2603:10b6:5:393::22)
 by DS7PR11MB7833.namprd11.prod.outlook.com (2603:10b6:8:ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Tue, 4 Jun
 2024 03:34:55 +0000
Received: from DM4PR11MB5296.namprd11.prod.outlook.com
 ([fe80::a82f:27ae:a8d9:6a81]) by DM4PR11MB5296.namprd11.prod.outlook.com
 ([fe80::a82f:27ae:a8d9:6a81%5]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 03:34:55 +0000
From: "Brunham, Kalen" <kalen.brunham@intel.com>
To: Tom Rini <trini@konsulko.com>
CC: Jiaxun Yang <jiaxun.yang@flygoat.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "U-Boot@lists.denx.de" <U-Boot@lists.denx.de>
Subject: RE: [PATCH 1/1] Added arm64 assembly for examples/api crt0
Thread-Topic: [PATCH 1/1] Added arm64 assembly for examples/api crt0
Thread-Index: Adqojlev93VX2sPCRR6waFJsm7XUJgC82DVQAAZzj4AAAJoS0AAAJBKAAAAadUAAAv2KAADFJ5OAAGQbwwAAk4NdAAA1gcwAAEOFFiAAVimOAAAVLBiA
Date: Tue, 4 Jun 2024 03:34:55 +0000
Message-ID: <DM4PR11MB5296E1D83E3AC318389107E3E3F82@DM4PR11MB5296.namprd11.prod.outlook.com>
References: <20240521162543.GU2568172@bill-the-cat>
 <DM4PR11MB529670F5CFDA6B4EDA7B7206E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521164659.GZ2568172@bill-the-cat>
 <DM4PR11MB529668DA50F05F26AAD229F0E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521181534.GD2568172@bill-the-cat>
 <d5887c6d-fc80-4f89-be51-db9b8da3863f@app.fastmail.com>
 <20240527160708.GJ2568172@bill-the-cat>
 <DM4PR11MB52966C57EFE2BE722B9E8DC1E3F32@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240531160258.GN3714513@bill-the-cat>
 <DM4PR11MB5296624D138053E9457054B8E3FE2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240603172322.GA68077@bill-the-cat>
In-Reply-To: <20240603172322.GA68077@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5296:EE_|DS7PR11MB7833:EE_
x-ms-office365-filtering-correlation-id: bec34880-c05d-40a8-79e3-08dc84474d4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?9IJlKMHpDLe3vi8e1iHFqJMflyauGRCSCrLCrfgxV3xI4QEUMQ2dG0bgtP9T?=
 =?us-ascii?Q?lKlfxBTK8u6HuyK/IPs82oYtSNbMxlkNs/2wqUwdu7oqW1Q7n8f/22VzYaYq?=
 =?us-ascii?Q?Lh9VQMnOaWXtNoGskO2uwi/sMs9XQsoXATvFnu7Nx3bh7PWdeyDqJJ+7t4xF?=
 =?us-ascii?Q?8Sc9BRVcbL0NpreZOEzVCcwUrK/GmyERWziUM+n7GlFLur8+TN76ERldQXge?=
 =?us-ascii?Q?U37YtGi0a3Z5fiSZDGS3aQyGmUbQ7GQKNX/JFDs+2JztGYHW6VxZpZt0xi2z?=
 =?us-ascii?Q?c8a7+QzVo9FLTEsd8fjWhyrNiyfHwYohEMFAPxOH0H/x/Mj6H4J/2xxxWZxQ?=
 =?us-ascii?Q?0rKluXXQjSWur1l0oKQxC/TBdpsGwYE45A1WhJ+S6sh1CPDL4fU+fvczfgwc?=
 =?us-ascii?Q?Xfh7hDaFdLZu6A1xAaun6xWS/7mBUY1Iy15am/N82WNezUM+7dBjcbnUZfCU?=
 =?us-ascii?Q?6tfBOPU6LDK2HydYeBqPOoQWtk8EAQeZV+WkkacsfQnR54PU17hzHQfUORDs?=
 =?us-ascii?Q?kpZQnTyKB2lEISj8o4hm07fJwCwEQcW6dElGm+woiLx4vN3H2H6k2JqeovNV?=
 =?us-ascii?Q?Fh6XVfLtvx+1nPHZHIAYmbUiCTFLnR14gQGOoLElCpQEBj/cT0By0IEn9vkq?=
 =?us-ascii?Q?hJXyhBDW+EF7cNtbdKGGqgzS1dtVohTdqy2qjP6wG+1mKI7klaO1A4TKZ+JH?=
 =?us-ascii?Q?eef/j5s4dioknd+cH8qUMvNedCGfb+XJTaQiynTMPpeztGUtBw3YV7CGTOC2?=
 =?us-ascii?Q?CEy4dPwkw8T7itD5a8f5QUdeuoT0JlnvXpgJiLjxynkdNxxsnSmOMBrKqPok?=
 =?us-ascii?Q?C5udCnqV9Hzivks/maDSv9W8gHBhMrgczGleWuW2DroPifje2Jz8t2WOw63N?=
 =?us-ascii?Q?4rsaeU9Fb+N9rcTCh5U3R5BHUsKJj5nCc+RrFb5c5j97ihGsAkIOjXYl7jar?=
 =?us-ascii?Q?sLqJyEW9ZQqG0fAhLLTr7cdfEvwpkcN1jOCnPNHPlgodZ90RSAzsvx6E93CZ?=
 =?us-ascii?Q?iyUPZ1QTp8YHRVA6R05o7L/LnUBc4wJ9PqPNtzO/Wqm056ghoS4Rgc/j03ta?=
 =?us-ascii?Q?upV4tJpoqt7fx2/pUDF31yOVDlXd3IGjHx3M15WkcRS0RP+kS2PIwn2kfV3N?=
 =?us-ascii?Q?7/YTTTAgmS6TDstKv56HWAE5OIPlee5OpWeelxhkUwfdeXIj6zLrnDlQtgBZ?=
 =?us-ascii?Q?G3i/QAGk2gh+RQqgGh22ylFtrCgGF+UBqyoRhl4z4Xnf4t8XWAyLAz5GuqF2?=
 =?us-ascii?Q?uznONn34UA4rrvN/8xv+DLeZfTXNQH6yJSHcCFQU3g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB5296.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?I0w+eMm0LKrKQWLVNiWtPpqVVnja+J6wZdck5mVCG295RrClk2ZiEVIDc2CH?=
 =?us-ascii?Q?jsZX1wskCdI7QxwGbJ/UALnT7azk8Lv8m7sJp4SxaO73o8JuN0lNEFB4dIKy?=
 =?us-ascii?Q?nHqPpMuzZO0DXlMjgnFPoOyRsowNQvpmvMqYDNV6leuN/m3LIDASvTcU7Yn/?=
 =?us-ascii?Q?UzRssntrXS4ebxe+P1e1Yh6yh8MdIivYOAIitlaOTDJHdmdpJg2ptn/25i01?=
 =?us-ascii?Q?i92O+nt8BtaDMrMAa/8pw7WB2Tu+uNnwPW1pVvRaHyFbcXFRudUzc0U5187R?=
 =?us-ascii?Q?XAZ3MH7ePV4OtUY6a+0JfbH9KWFvNF8WaH5DkbxgVWcCAGUte1SAj46eWcW8?=
 =?us-ascii?Q?FGw/zo9hN3qtkM9xuOBBgP/B2znm0bobRcR9w/reQkxXUybJcPtHI+ing0Kd?=
 =?us-ascii?Q?k7dp8c53BaYLgpFlC5xuNrMBcivB8QRXATNH6IEqqfTFzxO+XlkfHvR549XG?=
 =?us-ascii?Q?a93eYxNqzEfwVX6VDvuuUWJhgFqu1G9SN1fquiX2U7Hgo8CJEZsqYv1Z/dcs?=
 =?us-ascii?Q?vEDCis94pgvegmsT4nMyF0xcDImjh1NIV532ywYjTN0FM8cDByPtzIBUNlc9?=
 =?us-ascii?Q?h7z7h97sSNCthSvHln8Zh26sTCe61wKhGD2+WBroMTVTDk21tYiG+OCUS28j?=
 =?us-ascii?Q?7yZykYR8HJo6/7XvsjGv8dGy1SS5UGUrNaL2hubdKIbsjV4L/xH++DSpJUDW?=
 =?us-ascii?Q?xwsZePRDkv51I5YGHe7GZNmTGZeCEs0WhMFaBracE9YT7WQuTEnXI05d4WgI?=
 =?us-ascii?Q?eXpj1hRxX91wTeRssTxIOCFOM5SPaV1dKh2LFlHyd9XOokdIuaj4Yq+dfcWz?=
 =?us-ascii?Q?b9fAZoCQ0cDvKf55V2DfLbG+N1KrPMqKtCO2gNfzjtThO6EQgbP68V+McvKe?=
 =?us-ascii?Q?kcfPVAatHWM72NqlD9TYrO93DrfmWshp7OjW5ammK739RcBhB17GPTJ5jaoo?=
 =?us-ascii?Q?MjzsOhtgIl844xmohTCpzMF+XHonaOgFeOzf7/JDi8N7KboIkRYbYV5QsVoN?=
 =?us-ascii?Q?+KsfYGE8Wb7mv1eIOZyeV99VOzjkPkZeACE6ga5QakEFR421kSO/rOlkwM5V?=
 =?us-ascii?Q?eCAOK0elvY0TRIMkYY8OvyMrdh0B6TODUVzAwU6l2ky1QDn1/wYWXHp+Pv9r?=
 =?us-ascii?Q?C0hyGInIrpu+izUztnOSKIlD3R+XTK+gwdCP/WLrvtT3nYSStuEmgb6Adaf+?=
 =?us-ascii?Q?atxINnqv1DiWt5ADx3TZrVSznzD91GVLNZVyVL9+B28RTY5KjYGTETEeO+v+?=
 =?us-ascii?Q?M5tPkB7jT4Z/raECRwXwUQQpS54yt9DFxTssGiurgtUyptu1ONS8jzbRLXTO?=
 =?us-ascii?Q?0ULWxpx8tp4BzL2Q0wv0GLNpqRUjJp1QjKyaqel9BZIgewSteB3tGp+MAYH+?=
 =?us-ascii?Q?Gruq5RBM8HDrrhh/ZFC+W3MGCF+PPu+pTvD+rKfC5hqIe+hHcBB8q2cuzhK2?=
 =?us-ascii?Q?O6YU3Z4f+vB0GlE1TwmaFGxXqfKKd6Sh2G4QzSGstvLP8TkpmKbah39rozMI?=
 =?us-ascii?Q?WpiqQPU9LDJ6gtJklCAujBUKsg1wXMjigzGooMCKrXDE9GcEwz1EbJIC7yan?=
 =?us-ascii?Q?qkZctW3hn8h8suyVaSjIF82yR5p1IWvms2X1hqlMJO93572mbNmCN4RG7mti?=
 =?us-ascii?Q?MmUd+ZXZZXrYUta+9I7kDesKqzBfRiaTB5Kwxca1AJbf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5296.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bec34880-c05d-40a8-79e3-08dc84474d4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 03:34:55.4000 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SdqWP0JtvllSW269pBKyyPEc6fjJ6fM8f+AHwZUCLM/5gmYVrxto3wO4EnRmJnJBX7rukRh7ypjAvhU/F/z15w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7833
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

Hi Tom/Heinrich,

I have https://github.com/u-boot/u-boot/pull/574 that has a proposed change=
. It is currently failing clang sandbox, which looks a little strange and I=
'm looking into it. Please let me know if you have any feedback on the gene=
ral strategy.

Thanks,
-Kalen

-----Original Message-----
From: Tom Rini <trini@konsulko.com>=20
Sent: Monday, June 3, 2024 1:23 PM
To: Brunham, Kalen <kalen.brunham@intel.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>; Heinrich Schuchardt <xypron.glpk=
@gmx.de>; Ilias Apalodimas <ilias.apalodimas@linaro.org>; U-Boot@lists.denx=
.de
Subject: Re: [PATCH 1/1] Added arm64 assembly for examples/api crt0

On Sun, Jun 02, 2024 at 12:16:38AM +0000, Brunham, Kalen wrote:
> Thanks Tom.
>=20
> Can you suggest who is the existing owner of this code I could work with?

You should CC Heinrich for sure once you have things working.

>=20
> -----Original Message-----
> From: Tom Rini <trini@konsulko.com>=20
> Sent: Friday, May 31, 2024 12:03 PM
> To: Brunham, Kalen <kalen.brunham@intel.com>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>; Heinrich Schuchardt <xypron.gl=
pk@gmx.de>; Ilias Apalodimas <ilias.apalodimas@linaro.org>; U-Boot@lists.de=
nx.de
> Subject: Re: [PATCH 1/1] Added arm64 assembly for examples/api crt0
>=20
> On Thu, May 30, 2024 at 02:53:17PM +0000, Brunham, Kalen wrote:
>=20
> > Hi Tom,
> >=20
> > What are next steps on this change?
> >=20
> > I'm committed to the idea of EFI apps opposed to examples/standalone.
> > EFI currently requires block devices which is not enabled when only usi=
ng flash.
> >=20
> > Should config BLK be updated to include DM_SPI_FLASH?
> > Should we explore how to remove BLK as a dependency for EFI_LOADER?
>=20
> Yes, someone needs to explore how to cleanly make BLK optional for EFI_LO=
ADER.
>=20
> --
> Tom

--=20
Tom
