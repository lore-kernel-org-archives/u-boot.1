Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC0E4C5475B
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 08:13:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF374880BB;
	Fri,  1 Mar 2024 09:13:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="cMpLbkqW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3B6D83330; Fri,  1 Mar 2024 09:13:28 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DDD487D9C
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 09:13:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709280806; x=1740816806;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mjFXP0EFqws1B9+q0Q5OB65bcZvl1Sp/yMgZH5XXKAM=;
 b=cMpLbkqWiDXJlmWUGE2+wFnjE6RTpOIisxH0leNnZZR/8+XvhufRKTDY
 xWAyefCgE5LWUtyPKlY3H3ePTXfvidYTBlBAQ1VafvNBWd/eQJpCowKDJ
 oP+FNXlTCrlqlj1CFKD9e/kgZrtT256Jt78eDCWZWlAr3w447ICvuK4wV
 Omm0fbSlOm0kAoLeMAv85dqS6dyzjG3t0/iL+UvFgnvZPHUrpC9IIAOOg
 l1Lr4n4DKK6AkF7oGKQwtX5Y6Tt0Wz/VIPme0H5L2au2VRTY5HNqoj5eu
 dpBPjpyqmv7SEGM0JqqWFLGu0Ewgcmfe022bFMIgqJ+DEhnaLarcbheko Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3977717"
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="3977717"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2024 00:13:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="8269198"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 01 Mar 2024 00:13:23 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 00:13:22 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 00:13:21 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 1 Mar 2024 00:13:21 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 00:13:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVETmPMUTjU38jsyq+U2eonbojzizSOKwsvuodmLiQdJNZ5jUCLXJsT3ZGSdi2EmZZrGoeX4Zsz+YIEPlGpkTwknxWpCKkvvrrKL7edVBU7u6jKBcHHDLRvpW9/U+KtEhGmvS9qJDaagEGJCB6c5z/Bfgc90JppXqH7/Tm3jWL5nwRkuL1Sk0+YOC4EdB0AL38KfzbRRDN/5fgK4paM60jLcmWyD59B3WZ1L+Iyc8PUnQaXaUIfvv/MdN4/Ed0cmc5dPGEPjd8f3AkxhNY1SncPQj4j/ypuywhrbgDzHCfoGShMPFLe5DzH2R3WqI6CPN+TD5aoJ4Lz6zzUTn+UQUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjFXP0EFqws1B9+q0Q5OB65bcZvl1Sp/yMgZH5XXKAM=;
 b=npNJK2o2RgveI2jObxqxpcgsETsCmErYLRpKg8ex9oLuksUco9VbIgBLqBX+UqbIRN7qJNKbjCZ13BQKP6vo0CGpQB03+QWBrXVGf4m8H0aoh/hhLYzMVArdukHiW+yn2VRuqSezktlqPv/evacVlsJqjiiejw4bRUytLNuALY+ELgThYJkltYb0Vd8qsiiiH/5IQ3JjwP6f+l0c55gXyEUVJk7KP62GFRy8ExSSvu7vqPaw4uMirwJ3KXYg6f5/PJWGDODP0fX1gd7xujwWk5BrHLZv9i4z7Crt9nosJ0rJ8TCj/aYl0+OO5No016CuDZi89nye6WoBjn+4PmgMWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 DM4PR11MB5246.namprd11.prod.outlook.com (2603:10b6:5:389::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.25; Fri, 1 Mar 2024 08:13:18 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::d4e:e166:9da2:571]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::d4e:e166:9da2:571%4]) with mapi id 15.20.7339.026; Fri, 1 Mar 2024
 08:13:18 +0000
From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
To: =?utf-8?B?TWljaGHFgiBCYXJuYcWb?= <barnas@google.com>, Dinh Nguyen
 <dinguyen@kernel.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Marek Vasut <marex@denx.de>, Martyn Welch
 <martyn.welch@collabora.com>, =?utf-8?B?UGF3ZcWCIEFuaWtpZWw=?=
 <pan@semihalf.com>, Simon Glass <sjg@chromium.org>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 "Tom Rini" <trini@konsulko.com>
Subject: RE: [PATCH 0/2] arm: socfpga: arria10: allow to reprogram FPGA with
 warm reboot
Thread-Topic: [PATCH 0/2] arm: socfpga: arria10: allow to reprogram FPGA with
 warm reboot
Thread-Index: AQHaZaLOS9SWsaTO4kuP8v2uU3x6L7EhVAOAgAAM4YCAATI1AA==
Date: Fri, 1 Mar 2024 08:13:18 +0000
Message-ID: <DM8PR11MB55921AB1D108EE84BCDDBE00D25E2@DM8PR11MB5592.namprd11.prod.outlook.com>
References: <20240222152102.1677445-1-barnas@google.com>
 <a83ca999-aa53-4d81-a570-677ba644b0fe@kernel.org>
 <CAO4U=yuHDFpAZ4tk2e_o=T2Wj5b1U5+i=htDqv30VPaug1_YmQ@mail.gmail.com>
In-Reply-To: <CAO4U=yuHDFpAZ4tk2e_o=T2Wj5b1U5+i=htDqv30VPaug1_YmQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|DM4PR11MB5246:EE_
x-ms-office365-filtering-correlation-id: 79c07aea-cc03-406c-037d-08dc39c773b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: izxfUXqocXzBllljFTIcOuzjSa0QvvoyxGST0uXg0Qn6ZPFvwke35zaoloKK3Fcrku+FrN6LE8ia2sIFUVFHlSGg5W4sZ5a5QrlbTMyrxMX7mCZ0Bls3QD5iGSTGcQaTSfeAvhP8h5m8KTA/EOB6vTdsHBa8DB9X+GC4dW/xCe1RQveH5N5ZsN/UD5xmBR/E4W0igfoVPrp0AemxX9F/Ci/IRclGtkV+ADRmh++39gqjU8ZcDsJYOoqfJYMCieOAp+PvSIBUSQ1xElyaBv2UFLpQC6xmqJjuC1um1tJSHClQgqCiqHKjkob4da087KxwGlN8vPuUpZZ4OsKDJghxNOKOmJ4W827G1SGeaqJjCvXU88yiAHS10HBD3Xq4pQqupSV/r8K08B9FxCVpekddOfKiiNhv6Re8A1clG4OBmR6gKdMjl3Umoq418iGMdFdpolxSZ04DREQLTuG2lPkrPOk6EOHg0D7iUiI7VJufwff/Ckp37gWQtP84iYSAd/7TO00yxNWCFbQuqGi0vdrUI33gkqwDrPgJDCSy5wA+jlUTp5FbAti+33H+40Ctyk+UPzMOB6+X60TUKp28ycaZ/YZHOb0Bx/UIuPWMyTmbfrSeeJJFmu3HlKwcuASX6N2eegt4YP6RVId/fbX9jvPDRf5LpeODgkFy2GPmHLgnpM0QSVFhgjnYSpSloKZamAP1QO/QuFwYrgCN/fA4F1T9NFm3xZaO/AOfN7/6qBk2OE4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5592.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THdSL0VjRFhrT1NFL1ZEVEhMY2lmcm8xU2tibFJ2L1BjZUpldHFJVjBuOWpW?=
 =?utf-8?B?SW9MMlQrTjF4eDhSeXJrV3VGekd1SGdxTllLMzVHM0JRT3IzYlJnZHJ2TVBl?=
 =?utf-8?B?Z3V2bk45Sm1rTS8ycHoxWk1rUTMvSUxyZ2c0UDNucWxOZjUzVHlad2FJbyt5?=
 =?utf-8?B?TmlYN2tsbzUwYksreHFrT3JmV0NIUkZYVWpOZmJ1VzRObWxSTEJsbno5RlpN?=
 =?utf-8?B?SkdWbnlOcXJXc0tBcUtoWlN4dUNRS0pQL1NnL1YwbzRyQXNyNVM1RkcrRklD?=
 =?utf-8?B?eURnamFYUEcrWlFnemRKdjhnR0hGS3J1MS9KYTZ0cHAySE9ZVzRFVytFZTV5?=
 =?utf-8?B?OEF4dHBVcFBNSWkvVGVST0pxZUs5OTNNK3poWWFuejhvZ2JQNHpld3lIQjE0?=
 =?utf-8?B?VXFyZTVabmxEZHNpNkF4alpYVVFOOFlRSU5EZ3pUam1zbkdNcHZCZjIyR01h?=
 =?utf-8?B?aEFaTjZOeGl0RnJGMWJiYnBINlYxdHlrdVlUenlzYmVKSDk4ZE52ZW45U014?=
 =?utf-8?B?YWRRemxnZGhCSm15MkR0Y21mb0RKd01qSUhoY1UySUt5TDNyZGlTdWNaRkxT?=
 =?utf-8?B?YXBjYUZKcUNuc3M3VVFtWVFraGdNc2NCeDFUSGg2YjkrVVFhNTNtaVBrYWx5?=
 =?utf-8?B?UWF2cU84aWhEWEhCWW1zZFhBZy93NU96Z0g0cERWZEZmYjBaV0JCVEd1am9B?=
 =?utf-8?B?Um5pcWpyTyt3RS9MWG9VZGRrZG5aa3RpMjZNeG94OUVvanBRUG12OTErQ21H?=
 =?utf-8?B?bE5HZllzanFadWtFQnpjNExEOElPTHlRSGtmeEF4cld6bkV0Z0tlTjlyNWtl?=
 =?utf-8?B?VDlLN1Z0TkFQaTVZWGxqWVk1ZEljOUZUbWIxR2c3ZTJ4THp4ckF6d3FkME44?=
 =?utf-8?B?WFhCcC9NTG1XK0djazM3aWdNZ0hpU2pWeWw0aS85RW5IOVNNSkM1Y1lrYUFv?=
 =?utf-8?B?SW0wYWR4WVhoVHZmYTc1RHFxM1dTZzBxR3llK0phaGEvcGl6THRrUjJIRDJv?=
 =?utf-8?B?Snl6Z2RzQkNXVytkaWN6UlhtV21mM01uRjczTDNjSCt3UDVwemE2OE9CTHZH?=
 =?utf-8?B?YnR5cjBVK2RQako5SkFYUDJCQ3NPaXVHZWlRWkYrK2ExbFpVVnl2SjhmTVpY?=
 =?utf-8?B?UXhPN0ZoZmV6SGJtWG1IVHAwdTZBZFg2QllxczhrdXdvUTg5dTlEN0FYWXRM?=
 =?utf-8?B?UzhTaGxhcGZvWElKVUxjdnM1SlcrWUpRYXI5UWI0YkhVRHc1N1FsSitTRlBU?=
 =?utf-8?B?ejhJbVE3TnhlYlpDYytyeFBZWUd6LzRwcFBtSkFmN3o4TnlvZVArZ0t3N0RH?=
 =?utf-8?B?V1cwb3hoRVpnUnNjWjZmQnFZbHdDeGMybUJ0SHVRY2twNUdRRE0rWmgvWmti?=
 =?utf-8?B?WncvTDRmWm9BeEtaQnJleEJ4dE4yR1VvVjBqZE04Y2dEV01KU0Q4SWhxUHZi?=
 =?utf-8?B?QVl3YllpRXA3S3NSQ2xjS0ZtQmY2V3RubXVSNml3c0tiSStweGh0S1VHZENh?=
 =?utf-8?B?cUV3cWFGV0MxNWc1UG9mOTg4NVovZzBvNDQ0V0p4aElTYmk5Y2s2VTROSGtK?=
 =?utf-8?B?QWhIa0JqRFV4WlVkMlBzU3RNN2NjOHUwRGlRYjA1REd6d3RiM2l6ZXlBK1Za?=
 =?utf-8?B?WWs3dUdRaGVUeUw5enA0Y0Nkak50NngyOFZzZlJLUGpZblUrTWFTd1RqL1Fn?=
 =?utf-8?B?anhKSHZnc2YrbDBLNkFCUFlKa1lKQlFDeHhIQU4vU2NKNHZGZDZja01UVGtH?=
 =?utf-8?B?ZG1FMXNFczFKSVhWcmtZTm5USUtwZExrTFVocFhmQzhpWVZmclJqMk03K25s?=
 =?utf-8?B?QmpPdjhrZHJkSXRoaWpCN21jdXFXMGQ0M0htTmZ1dFpMemxqdmR0ZFBYdzIy?=
 =?utf-8?B?bU41SFN0Tml5L0FDcElkZmd4Q2VPTVViNSt4SGtOVGNLWC9yU0FnVzc2cWJz?=
 =?utf-8?B?K08vczB3UlFVQ05acHIzaEs0VlJ2MER0UjNkMmhaZkpBSGZjZWVTbFlsdEMr?=
 =?utf-8?B?RFhxUWNHTjFWSzJabS9nakYzMkU3ZHRrbTFleGExMmZEL09iVkFQMWx4VUk4?=
 =?utf-8?B?c2xkOXg5MTVQdmtkY290a280MytqVEptSXdSaURyRk5RWThJU3NJYytPSUtk?=
 =?utf-8?Q?hHybdYyJBsDetPZ3229dtEK5S?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c07aea-cc03-406c-037d-08dc39c773b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 08:13:18.2203 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4vAnw/bhIUNiWFWaK9Kh5vZ14iuLjoic1uwdirGLsN21ECHCvCoNrvrkZLd3RKFJCcy9rQPPj0Nsaulw1+mGyWmX0aia623ncyNP5UwUS3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5246
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWljaGHFgiBCYXJuYcWb
IDxiYXJuYXNAZ29vZ2xlLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5IDI5LCAyMDI0
IDk6NDkgUE0NCj4gVG86IERpbmggTmd1eWVuIDxkaW5ndXllbkBrZXJuZWwub3JnPg0KPiBDYzog
dS1ib290QGxpc3RzLmRlbnguZGU7IE1hcmNlbCBaaXN3aWxlciA8bWFyY2VsLnppc3dpbGVyQHRv
cmFkZXguY29tPjsNCj4gTWFyZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+OyBNYXJ0eW4gV2VsY2gN
Cj4gPG1hcnR5bi53ZWxjaEBjb2xsYWJvcmEuY29tPjsgUGF3ZcWCIEFuaWtpZWwgPHBhbkBzZW1p
aGFsZi5jb20+OyBTaW1vbg0KPiBHbGFzcyA8c2pnQGNocm9taXVtLm9yZz47IFNpbW9uIEdvbGRz
Y2htaWR0DQo+IDxzaW1vbi5rLnIuZ29sZHNjaG1pZHRAZ21haWwuY29tPjsgU3Z5YXRvc2xhdiBS
eWhlbA0KPiA8Y2xhbW9yOTVAZ21haWwuY29tPjsgQ2hlZSwgVGllbiBGb25nIDx0aWVuLmZvbmcu
Y2hlZUBpbnRlbC5jb20+OyBUb20NCj4gUmluaSA8dHJpbmlAa29uc3Vsa28uY29tPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIDAvMl0gYXJtOiBzb2NmcGdhOiBhcnJpYTEwOiBhbGxvdyB0byByZXBy
b2dyYW0gRlBHQSB3aXRoDQo+IHdhcm0gcmVib290DQo+IA0KPiBPbiBUaHUsIEZlYiAyOSwgMjAy
NCBhdCAyOjAz4oCvUE0gRGluaCBOZ3V5ZW4gPGRpbmd1eWVuQGtlcm5lbC5vcmc+IHdyb3RlOg0K
PiA+DQo+ID4NCj4gPg0KPiA+IE9uIDIvMjIvMjQgMDk6MjAsIE1pY2hhxYIgQmFybmHFmyB3cm90
ZToNCj4gPiA+DQo+ID4gPiBCeSBkZWZhdWx0LCB0aGUgYm9hcmQgcmVxdWlyZXMgcG93ZXIgY3lj
bGUgKGNvbGQgYm9vdCkgdG8gcHJvZ3JhbQ0KPiA+ID4gdGhlIEZQR0Egd2l0aCBiaXRzdHJlYW0u
IFRoaXMgY2hhbmdlIGFkZHMgS2NvbmZpZyB0aGF0IGFsbG93cyB0bw0KPiA+ID4gZW5hYmxlIHJl
cHJvZ3JhbW1pbmcgdGhlIEZQR0Egd2l0aCBldmVyeSBib290LiBUaGlzIG1ha2VzIHRoZSB1cGRh
dGUNCj4gPiA+IHByb2Nlc3Mgb2YgdGhlIGJpdHN0cmVhbSBvbiB0aGUgZmlsZXN5c3RlbSB0byBi
ZSBhcHBsaWVkIHdpdGggc2ltcGxlDQo+ID4gPiBzeXN0ZW0gcmVib290Lg0KPiA+ID4NCj4gPiA+
DQo+ID4NCj4gPiBJZiB3ZSB3YW50IHRvIGVuYWJsZSB0aGUgcmVwcm9ncmFtbWluZyBvbiBldmVy
eSBib290LCB3b3VsZCBpdCBtYWtlDQo+ID4gc2Vuc2UgdG8ganVzdCBkbyBpdCBhbmQgbm90IGV2
ZW4gYm90aGVyIHdpdGggdGhlIEtjb25maWcgb3B0aW9uPw0KPiA+DQo+ID4gRGluaA0KPiANCj4g
VGhlIEZQR0EgcHJvZ3JhbW1pbmcgcGFydCB0YWtlcyBxdWl0ZSBhIGxvbmcgdGltZSwgc28gaXQg
aW5jcmVhc2VzIHRoZQ0KPiByZWJvb3QgdGltZSBzaWduaWZpY2FudGx5Lg0KPiBJIGRvbid0IHRo
aW5rIHRoYXQgZXZlcnlvbmUgbmVlZHMgdGhlIHJlcHJvZ3JhbW1pbmcgdG8gaGFwcGVuIGV2ZXJ5
IHRpbWUuDQo+IFdlIG5lZWQgdGhhdCBiZWNhdXNlIG91ciBib2FyZHMgYXJlIGNsb3NlZCBpbiB0
aGUgbGFiIGFuZCB0aGUgcG93ZXIgaXMgbm90DQo+IGVhc2lseSBhY2Nlc3NpYmxlLCBzbyBpbiBj
YXNlIG9mIHVwZGF0ZSB0byB0aGUgYml0c3RyZWFtLCB3ZSBzaG91bGQgYmUgYWJsZSB0bw0KPiBy
ZW1vdGVseSB1cGRhdGUgaXQgd2l0aCBhIHB1cmUgd2FybSByZWJvb3QuDQo+IFNvIEkgdGhvdWdo
dCB0aGF0IHRoaXMgc2hvdWxkIGJlIHNldCBieSBLY29uZmlnIHRvIG5vdCBib3RoZXIgb3RoZXIg
dXNlcnMgd2l0aA0KPiBsb25nZXIgcmVib290IHRpbWVzLg0KPiANCj4gTWljaGHFgg0KDQpSZXBy
b2dyYW0gc2hvdWxkIGJlIGF2b2lkZWQgd2hlbiBGUEdBIGFscmVhZHkgaW4gdXNlciBtb2RlLCB0
aGlzIGlzIGZvciBGUEdBIGJvb3QgZmlyc3QgdXNlIGNhc2UuDQoNCkZ1bGwgcmVwcm9ncmFtIGlz
IHNsb3cgaW4gU1BMLCBiZWNhdXNlICB2ZXJ5IHNtYWxsIGJ1ZmZlciBpbiB0aGlzIHNtYWxsIE9D
UkFNIGNhbiBvbmx5IGJlIHVzZWQgdG8gcHJvY2VzcyB0aGUgZnVsbCBSQkYuDQoNClNpbmNlIHRo
aXMgaXMgYW4gb3B0aW9uYWwgY29uZmlndXJhdGlvbiwgSSBkb24ndCBzZWUgYW55IGlzc3VlIHdp
dGggdGhlc2UgY2hhbmdlcy4NCg0KVGllbiBGb25nDQo=
