Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35459C02182
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 10:03:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BE5E801F5;
	Tue, 21 Jan 2025 11:03:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="g5bhh0d8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4CFC80326; Tue, 21 Jan 2025 11:03:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BE43800CF
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 11:03:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737453825; x=1768989825;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=fGxdYIdKwHGqjNimrvOKrPCRunRS8+OdNoz1c/bfo6M=;
 b=g5bhh0d8LXXo7UWmWkBWZzyPnoPh2ZRC38bslQ5EHSTYY1Jbj2TOc0XV
 Q+mWLm4vW7IiHMWFr+YzlqfpZEutWRJUKPXTifpUneoT6SVUDNXW1YDpZ
 utj8CA7u29rbQ5O9bKWRcUm1ImJRIqNp3FfRoZm32YUqehtnNfPtAEPCI
 BPZSW5k3n1WIS10GU1m6LhWiByKCBIC4Y3g+3a7kash2wP0cinWculuKm
 GEaxAahHZPGhYlkbXHDAARu+Sc922ytHf3syzwkWltdpjUuIGQ3KAr1Tt
 Ga6kqReIFBmmTsHd8oPCfgZOnE+Il8GfG9f6xizQNThR0B52wY8NQq9fG g==;
X-CSE-ConnectionGUID: 7ffY95J/SeKDF30tCf30Sw==
X-CSE-MsgGUID: XS9SUawlSRCvw/k+5nsblg==
X-IronPort-AV: E=McAfee;i="6700,10204,11321"; a="38009125"
X-IronPort-AV: E=Sophos;i="6.13,221,1732608000"; d="scan'208";a="38009125"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2025 02:03:38 -0800
X-CSE-ConnectionGUID: Mjlrqy0VQCWr8GUPOfYD1w==
X-CSE-MsgGUID: b/jyE/OEQZeDXBGY15ybbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,221,1732608000"; d="scan'208";a="107364907"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 Jan 2025 02:02:58 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 21 Jan 2025 02:02:58 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 21 Jan 2025 02:02:58 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 21 Jan 2025 02:02:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tjXezXb0m7Ev9Nd9WbWwogoCO4MVPOSkd2RrQ7PqIqaxfbFotAW6sq+fGMRV5+/H8njWx6eI4/7q+EETJQPDK/n0ootzHPqd6f1d5K2ygITfwz9+kPaABQbQRl+Mgrc8zS5yMaVDXIAuARwOXrvysxeFWY7gUpjy56eyc73iJbj6zqjdVHE4QM2bPLH2mhh5NRxO246x18VMMls5ddHgXFfMx9EipjZu9GaT5fpBRm7Nj6p7sYBDZDmpME4hsrt1bR+TdaqdtMKVjx/O4MndHo+hDNTrxeeFfTc40U/1dfYxjiBH1nUgvViSXr1ySYjHIa5kyPIJ5cuYdMGAT+8esA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cifuMO4lDcvD8LCRFK8hKikZBj/SAlmW/lfMsPnI+Qc=;
 b=ckzFz6ccAOqfK8CDaCcr8BQ3+WLDmea7mjrqIRFj2sgBHw/UcAUzbFYXvSpOK/yitCsj4q/iFgIlxwd+x+bc8USwrSHDNO+tEakiaDhYZSNOBhLuukVjd24q17spq6d/2RhOJyjLTc2hUvkldTJURy2Ngj5E/wTO7awL2egcZ76M5E+hf2BvotCapXUEOzqaK+tomuChOe7Vc9FPa/I5ipUhlyX1fhxhaq9L/fzy7/MIRCTzOFXVEy4XmMF3T+5vY9hsT7UCcJJ6lrcCHdmh1NY3/aYgGupbrQECdxo8GTdAyXPw1iSL9uuKuql6Zf0lb7+xXlkMeL6iqDuea+tmRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 IA1PR11MB7368.namprd11.prod.outlook.com (2603:10b6:208:420::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.16; Tue, 21 Jan 2025 10:02:42 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe%4]) with mapi id 15.20.8356.014; Tue, 21 Jan 2025
 10:02:42 +0000
From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
To: Lothar Rubusch <l.rubusch@gmail.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "trini@konsulko.com" <trini@konsulko.com>,
 "marex@denx.de" <marex@denx.de>, "simon.k.r.goldschmidt@gmail.com"
 <simon.k.r.goldschmidt@gmail.com>, "sumit.garg@linaro.org"
 <sumit.garg@linaro.org>
CC: "sjg@chromium.org" <sjg@chromium.org>, "xypron.glpk@gmx.de"
 <xypron.glpk@gmx.de>, "michal.simek@amd.com" <michal.simek@amd.com>, "Lim,
 Jit Loon" <jit.loon.lim@intel.com>, "barnas@google.com" <barnas@google.com>
Subject: RE: [PATCH v4 03/11] ARM: dts: socfpga: add Mercury+ AA1 for u-boot
 dts
Thread-Topic: [PATCH v4 03/11] ARM: dts: socfpga: add Mercury+ AA1 for u-boot
 dts
Thread-Index: AQHbJ78UNCrbgff0VUqV61UlBg+VnrMhhkGg
Date: Tue, 21 Jan 2025 10:02:42 +0000
Message-ID: <DM8PR11MB5592B8B7BEB3B45165FD8EECD2E62@DM8PR11MB5592.namprd11.prod.outlook.com>
References: <20241026155220.26300-1-l.rubusch@gmail.com>
 <20241026155220.26300-4-l.rubusch@gmail.com>
In-Reply-To: <20241026155220.26300-4-l.rubusch@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|IA1PR11MB7368:EE_
x-ms-office365-filtering-correlation-id: c53778ba-ca48-48b8-61a0-08dd3a02bed3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?QZkFF/UMp1YpJrHZR3nohYyZ9/s8c/qPf7v2zPwKdiQaOBAwNBJRbjAgSGZo?=
 =?us-ascii?Q?eC0TKzji6Sz6cg2d+PzAEHdFJHkX2NEvDX72IgVyf0E01X6Vg+RZmhUA30fu?=
 =?us-ascii?Q?pQtM7xEOss7yySOc+YXvYXTQPxFFEw+it9RycedTxk6RJ7OMmbO7x1bM2OJ8?=
 =?us-ascii?Q?7DcQyT0rRSDxqQDWijQ2kZXys9Rp9pglEbdf90AoUhtIkRZFEd6m6Z3I/GQA?=
 =?us-ascii?Q?y4eAJ+1NQXXOXUZVIJLGbv1bOxVsoHu7YOtrAv0g3T6UdGPztJ3wQUkg/41h?=
 =?us-ascii?Q?rwZdLSASdifvFwpO0cfoPSXGJroVSL6PRTqMIzYXFXtNJCIc5R3BVrlBA9aZ?=
 =?us-ascii?Q?vamqHzRtdfotWKmo/4WkPTCwXHMYZxeuD6r22ODBBg2Xpu8rDN4W7FHED5zF?=
 =?us-ascii?Q?qSvqqNCENeSib3mcElUGvclj6tI5TaISxhn4/MxqEC0egSshB75FDTQuuxUY?=
 =?us-ascii?Q?ig6L3YRxkRJ9wCcvNWm2lcBKwBPfTJzqbERJDy8c5qS0EtS7RHYDA/HAF2l8?=
 =?us-ascii?Q?9l+6dGbsnLYxrMzf+suzZMdaHZrbT9cHei2y8PEq7Bag/hIDdJUn99eIpdjr?=
 =?us-ascii?Q?69Ndbs8uuzbtxOzOvluP+0X8ATk2frNQ2gjKSY1gUq85ZSRSW14xLiaHgFOI?=
 =?us-ascii?Q?M6YH3ucbbu4nLXC+JsIvQd5/MyiudX7Jlw/WjGQCgAeMBnHbA7hakzF2QYJ1?=
 =?us-ascii?Q?ATfFWmI3InZsULM7iUahHL22+P6frG44uqAS6+3UexLB49FHAFKqx9JWScSb?=
 =?us-ascii?Q?JZblt+XIEUa2+vHq8ugPTaMsSST07Vt/AmhOWPKlo2qpxZprt4ZRbBJvbds2?=
 =?us-ascii?Q?WF/gWCioqSB2xXfvs1UzG2S5/hn9chSpwOf3UPqZF/0l4KmkINfF0X1ylqjp?=
 =?us-ascii?Q?VEH4jwpnFhMY9JtD1bslaSd8CzQEPZ/lmU1HoA24RzwWSiC/lCjDvEjq2GpP?=
 =?us-ascii?Q?z0JEqWgYbO/vLzm5M+I5ijdG9xek+8BI8B0Y8f7dfzcsIOSwioXSTFBjDlsN?=
 =?us-ascii?Q?gJfw5qdhiFdYcBSmZVxazfnOuGE33cyromJUEEa8GGt7IittpKxeA4fztlbo?=
 =?us-ascii?Q?KZiP9bItwPyWh/DPzChIqjDhICcJYt9ysV5xXJHgz6x82EQEB9cpKoLFoM/T?=
 =?us-ascii?Q?qvF3FS4s6e8t8oi58EmDNCJz3feGBIRRuFP+ZPSS9ZVrp7dOXTAgotwLh5tO?=
 =?us-ascii?Q?yVmAWMW7xEj40wLA2xWf35nIRn0xDMJRDwX8rdf7kzbWvYZKGtLne6VSo+q3?=
 =?us-ascii?Q?6QeRTC90Pux4hJnNdsletYeoTEirEtzJxbmv82aLXLOd5TaTdZ0SQqqGreBX?=
 =?us-ascii?Q?CwLQUZyJYKVW2+M/4Zy5HFVXliS7Jiyh36HnEc9dB8Zod9v+QFgh+zcSU2iF?=
 =?us-ascii?Q?1gwp+emf6ewGXLDSz4TzFwYvl6cbxTKHb4IYqfyucxZ9f9ItmaDGkXQLNdTM?=
 =?us-ascii?Q?F9EwwoQdJjtlVE74dwac2Z/nSs6CORLQ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5592.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zYLOuYHtSJ9pwVtdTCzRdoHKKMKGvfNBLQrXWDzott2YPtgD2KnZWJSFr4PO?=
 =?us-ascii?Q?EZ2ASXphQDtAWld4VZWNkXc+I6V9opmhyjK8gQBJyLgn94lOThiM6PhjosT+?=
 =?us-ascii?Q?oiDJGbiFYZr0a+h+ZXE10w8MkLXzSwzyiEugDi9qgteT/2FhgDRB0fPLwpEH?=
 =?us-ascii?Q?mm2J5cWndvgVGQGlCqrNTxa/Pdpw56TiYcvXTzGC4nNrwqxMAiusma+ynvQk?=
 =?us-ascii?Q?V+cPgI7FgJNWhpQA1i18jKRq7oFLGsSKmHJJEG47jVmLZr+hylUhYf5Yfj/T?=
 =?us-ascii?Q?MNWw3/iSSq3jwrre0UhyMZmjb3mnplhF/l4GvE9xIiE1ucRKyS0hRCFzEyp0?=
 =?us-ascii?Q?NgcM/znpnTzqhJr1YEsgISo93Je5COz8xRkDESQCHdGb6y53iVglcpiKRonl?=
 =?us-ascii?Q?E5jgxTi6FjX165G+2wZw40Wl5tYLGaQigJy986m5Dum15aRpXCiCRSepY1gj?=
 =?us-ascii?Q?z+bR+KZiHFYOGDnizT3VdUL15lPNFWgQRvceA58kUq+ah2d7zREilYBhf0k1?=
 =?us-ascii?Q?F1nStuLWOu3hTOF8n/PD16HyZx8ytTDKJglZm15L8vAQITQtbmo/iGyddVI2?=
 =?us-ascii?Q?T0Q3jEbZ02Xn5f3fy03Jvs8ZFQo/fecU4QI2af1xpY45Lkxr4F2/YJTfxu+9?=
 =?us-ascii?Q?K2/3eVTNx9N/6kCFKNRhzNAbE051S28bJwMICOXAxzFeEwVNRuPFJE2u1nV2?=
 =?us-ascii?Q?3PEmEyNIw0VVhshxGNYdgpCOtFMfGonqETjLG0e+nuqaejUGM09MKif4VISR?=
 =?us-ascii?Q?wCAzPp0TnYA5K9NglaL2t/wDR5anz1YiWkds8E1B/+t0xMJgAFY1RWRUwnEr?=
 =?us-ascii?Q?DqGHIjghPaPckVIClMv2rfNxZGabn4W0uhUHDY0218+hwx9nujtQZXRqPmFr?=
 =?us-ascii?Q?bssFWKlVCrPeoR8mTo4egmwssGYks7VlQk1qZ6FN4vAt2NZdvbFv5gffgT18?=
 =?us-ascii?Q?sjnTwuwKhv5kYoF7bUvU1l75cx/5D6BFR3IcRfeQ1mIbB0g8e5xvUUqFTrvs?=
 =?us-ascii?Q?iYfaRfZelnmkL1seB2q8B5y+LAgiVEGldg758pK4n8xoPlZscmW6AkKvGcfU?=
 =?us-ascii?Q?XdOvcDPvgoV1aLFLUYWyT8WRPjBnhh1RGz2k4abRQv/rz+i/eCMf4bmlAHX2?=
 =?us-ascii?Q?QAD+C3AnZAIIhOBtyvUsTf5NvY0fKJbswSi4bNd4PPCZ0K+Us39MY/wJvHXc?=
 =?us-ascii?Q?DCgDHEO7N1NLDqnXah4tjbQcrZjOPEEs93LagW/hQZXjnq1/wukByf7fnKmj?=
 =?us-ascii?Q?PfeyYio/igT5yDdsXi2U15a+hCrUSPoYzBdbHOeYQuoDnR8eoL9jC5Tlu/1k?=
 =?us-ascii?Q?5aJiN9M1q5KAsDwCRpFqtnfUp6/fQ136y/5orrnbpvmc/heLMW6IRsaU93MJ?=
 =?us-ascii?Q?iJEtMivLucM2JNw4mSPGhweZoifkE0ypLEjbYcxAcFAjTnDmzgDU4Mfx+Pp+?=
 =?us-ascii?Q?M9Di4i9CWUP+xomLPvx6j8GPQpWMj1ioPs3h3ZaZYWrL06PX0JLNiYb/Uxpk?=
 =?us-ascii?Q?1Xi9JVpHGGZK7rMbBEHBtu0GECiBD5MgpIsAwVkTo6s4bFHGcXRHhL914dsW?=
 =?us-ascii?Q?TWo7dRfBId5wLq8EvbGXawLmG2p/+Gm77UWTPh5+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c53778ba-ca48-48b8-61a0-08dd3a02bed3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2025 10:02:42.2219 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gPlTfQi8edltUzUROORWAQCPbdz63Wbzo05DtC4t+K4gvUsM0S+cdTvl9tRBzPa6cVtxurwS6u2M9swSj3VKzglfqAz0PTXN/iesFIL1Dyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7368
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

Hi,

-----Original Message-----
From: Lothar Rubusch <l.rubusch@gmail.com>=20
Sent: Saturday, October 26, 2024 11:52 PM
To: u-boot@lists.denx.de; trini@konsulko.com; marex@denx.de; simon.k.r.gold=
schmidt@gmail.com; Chee, Tien Fong <tien.fong.chee@intel.com>; sumit.garg@l=
inaro.org
Cc: sjg@chromium.org; xypron.glpk@gmx.de; michal.simek@amd.com; Lim, Jit Lo=
on <jit.loon.lim@intel.com>; barnas@google.com; l.rubusch@gmail.com
Subject: [PATCH v4 03/11] ARM: dts: socfpga: add Mercury+ AA1 for u-boot dt=
s

Introduce u-boot specific device-tree files for Enclustra Mercury+ AA1 SoMs=
 (Intel/arria10).

Generic device-tree fragments for linux and U-boot shall be provided in dts=
/upstream. The selection of the generic device-tree fragments depends on a =
selected boot-mode and a selected carrier board.

On Intel/Arria10 a handoff setup is needed for initialization of various cl=
ock / pinmux / DRAM settings only used by U-Boot provided by the current pa=
tch.

Signed-off-by: Andreas Buerkler <andreas.buerkler@enclustra.com>
Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 ..._arria10_enclustra_mercury_aa1-u-boot.dtsi |  45 +++  .../socfpga_arria=
10_enclustra_mercury_aa1.dts |  45 +++
 .../socfpga_arria10_mercury_aa1-u-boot.dtsi   |  19 ++
 .../dts/socfpga_arria10_mercury_aa1_handoff.h | 305 ++++++++++++++++++
 board/enclustra/mercury_aa1/Kconfig           |  37 +++
 board/enclustra/mercury_aa1/MAINTAINERS       |   2 +
 6 files changed, 453 insertions(+)
 create mode 100644 arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1-u-bo=
ot.dtsi
 create mode 100644 arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1.dts
 create mode 100644 arch/arm/dts/socfpga_arria10_mercury_aa1_handoff.h

diff --git a/arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1-u-boot.dtsi=
 b/arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1-u-boot.dtsi
new file mode 100644
index 0000000000..6e38286572
--- /dev/null
+++ b/arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1-u-boot.dtsi
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Lothar Rubusch <l.rubusch@gmail.com>  */
+
+/* Arria10 handoff (u-boot) */
+#include "socfpga_arria10_mercury_aa1_handoff.h"
+#include "socfpga_arria10-handoff.dtsi"
+#include "socfpga_arria10_handoff_u-boot.dtsi"
+#include "socfpga_arria10_mercury_aa1-u-boot.dtsi"
+
+/* Specific boot-mode (u-boot) */
+#if IS_ENABLED(CONFIG_ENCLUSTRA_SDMMC) ||=20
+IS_ENABLED(CONFIG_ENCLUSTRA_EMMC)
+
+/ {
+	fs_loader0: fs-loader {
+		bootph-all;
+		compatible =3D "u-boot,fs-loader";
+		phandlepart =3D <&mmc 1>;
+	};
+};
+
+&fpga_mgr {
+	bootph-all;
+	firmware-loader =3D <&fs_loader0>;
+	altr,bitstream =3D "fpga.itb";
+};
+
+#elif IS_ENABLED(CONFIG_ENCLUSTRA_QSPI)
+
+/ {
+	fs_loader0: fs-loader {
+		bootph-all;
+		compatible =3D "u-boot,fs-loader";
+		sfconfig =3D <0 0 50000000 3>;

The RAW read implementation in fs_loader is not upstream yet, I afraid this=
 might not working, you want help to upstream?

[...]

Best regards,
TF
