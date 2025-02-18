Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E363C021A9
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 01:43:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CC3C80843;
	Tue, 18 Feb 2025 02:43:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="bLoEcbB7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE7A48083C; Tue, 18 Feb 2025 02:43:53 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9E2980207
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 02:43:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739843031; x=1771379031;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3tb7lz4eqI58x6tdk0xp9/WtxgmUbkn2zSEuTzq1zWk=;
 b=bLoEcbB7lnkAzKGpVwRtq0hpn40PPtydJsLXMKOMtukoSxH310p/apt9
 bPUV2w/uj8HOGxy3J5BbkbZysaUJ++I5RCxnBnyt7A0NxIvdMpOoYanRK
 QTF3pQ/ZIOmzkZ2Xu/VEq9mlfjlrhv+CqFWQxSVGjjv3v2zek+S7I72HM
 LyTndBv5SAklJ0SKRhEJr0FbmxNwY+pERVko+u+5R4Mg/t2ua6Z8qlr2x
 iVhjToaYp/K3w3urPS+48qP0Gn7HmXheHEoT+2RnOr5pMTUVEMQ1giUS2
 Pxz85ppG5GK0JVuZ4zctrpzP8uIVG6FoIloDJ+jg4GipkoMFo5RFESKTf w==;
X-CSE-ConnectionGUID: d7I6dy4bTuCmXB2wF63lLw==
X-CSE-MsgGUID: r8/RzsYlQQOu9RilPDwGJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="50741588"
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; d="scan'208";a="50741588"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 17:43:49 -0800
X-CSE-ConnectionGUID: uWRoM4R5QCS80YHjBoA9KA==
X-CSE-MsgGUID: RW/DqmwTRDGI0iV/MtvNKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="137493798"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 17 Feb 2025 17:43:48 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 17 Feb 2025 17:43:47 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Feb 2025 17:43:47 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Feb 2025 17:43:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eW+fuj3gFAK+eELHwKWLWaqlUlrryWuMWnoGPuLl2PTgkcbOd27ecFPAIXF8YAMCqNE24SGz17oADmYWdc9QEUnosc4nJgENMXTEtBnsAnNde39xGZCaWvhWrNLiOh6ylbqwgUXXeoDgxEH2EsOkB2ZLGpicHu8Unz2bvnDIxdJAhL1jWyPcCAsXPm20dRp4/0BdDaZa/zCYHkGhg4XkRmf3XYKcE8jeOOVFURvldEkL7XpAp2N7ah7xXggBOZw9dRO9v16lMO2t/U/YQeYlVjCLbVcR20XXWIGNCh1/DsJPgeyUZ/jCLHd67I9Wp3/vy618aSlARIzC9Gy9p7jSxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3tb7lz4eqI58x6tdk0xp9/WtxgmUbkn2zSEuTzq1zWk=;
 b=YUwoRZkvMtvERssSnoKZhfq/3OZvh2fbnENiNfd7sON/wzx3qUYmu4d+XVpMWkZLwVzzcGi9K3QLUmHIWcKJ7rye0pq8/htvWPGwoTdUKSz9VbD+z715VClaFvnl9TYrKBG86KRVvoTiKIn0DUNWsDesk0VmR2HIRv3PW3Q1+ODi6Mhr4ehEZmRQ6FGwqe8NaP5ETrX7UYGDmLzIuESuvMWZOs+/ORJ7XM5Tmc4wt4nQeOWKrZK84Zk/QjPRb3HsLvwlmx1ppz3wI0CorskFVu3rQcZCA8j1isVQ7+Szc43hrEwUkgVU39WicLuCECriojyMHc3J7P6SPBsSI2C/gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 LV1PR11MB8850.namprd11.prod.outlook.com (2603:10b6:408:2b4::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.18; Tue, 18 Feb 2025 01:43:16 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::4046:430d:f16c:b842]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::4046:430d:f16c:b842%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 01:43:16 +0000
From: "Ng, Boon Khai" <boon.khai.ng@intel.com>
To: Tom Rini <trini@konsulko.com>
CC: Uboot Open List <u-boot@lists.denx.de>, "Chee, Tien Fong"
 <tien.fong.chee@intel.com>, "Hea, Kok Kiang" <kok.kiang.hea@intel.com>,
 "Maniyam, Dinesh" <dinesh.maniyam@intel.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@intel.com>, "Zamri, Muhammad Hazim Izzat"
 <muhammad.hazim.izzat.zamri@intel.com>
Subject: RE: [XGMAC dt bindings v1 1/1] dt: net: add DWC XGMAC binding
Thread-Topic: [XGMAC dt bindings v1 1/1] dt: net: add DWC XGMAC binding
Thread-Index: AQHbaI4f6BC9zwne0kCMiatxko5uWbMbQTMAgC+2AJCAAM8kAIAAs/NA
Date: Tue, 18 Feb 2025 01:43:15 +0000
Message-ID: <DM8PR11MB5751CA4FBF5317B3F871D01AC1FA2@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20250117031535.19595-1-boon.khai.ng@intel.com>
 <20250117031535.19595-2-boon.khai.ng@intel.com>
 <20250117175638.GV3476@bill-the-cat>
 <DM8PR11MB5751359F31EDC36DABABCF8CC1FB2@DM8PR11MB5751.namprd11.prod.outlook.com>
 <20250217145338.GL1233568@bill-the-cat>
In-Reply-To: <20250217145338.GL1233568@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|LV1PR11MB8850:EE_
x-ms-office365-filtering-correlation-id: 94beb408-856e-482f-a778-08dd4fbd9d20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?t8y1RRTuvQb2SrU9KXJE0FpjpNJMPDomeeBJJrky3qnbo6t3SeFiq8rYras+?=
 =?us-ascii?Q?9Y8dYUTZclok05qCl1MKo/KskB4s62SKzlZ4igp7w5qNDiNM7ZGmimttBeQx?=
 =?us-ascii?Q?6NFWgaYVVq/8FAWLxam6pIQ0tZanTHzHRTYcvxG97vbXXn/eFDq76cHgMA+L?=
 =?us-ascii?Q?Q1k2OBQImCm1nhp7kjrWjoIBDzKbBsiQ65FM2ynPm88Ij33KKOAmZrU8/OJL?=
 =?us-ascii?Q?NBLs+sXYdpsOyqq7mtR+7ewVzfAgLaIJUaPDXXIkMgfZlsXTXyeMfpLtOwv/?=
 =?us-ascii?Q?h8DUtINjBFUsR0ndwnIzu0zym3vvMi8Og0PLzKoKCPXBuLMjjUPlu9GS9qAu?=
 =?us-ascii?Q?/Acab/55Y55LmLYMdvKSs1tnrc5mF67zjK2Z0MSCHEejUQL1d+GUEOm0GtoI?=
 =?us-ascii?Q?PxSFg5SAk7B86e37obnXjYcua9ZXPuYZ3fUhZtPEN7monTVOSSezb0QeZbUP?=
 =?us-ascii?Q?evm7rDB8tBoWqs2eB7QBaBOVPMJePN+F9dsNFiWbqdGs5miV8p3LnnI0BuzJ?=
 =?us-ascii?Q?GZCZ+tiGcwArngMjU3EYgTqwCMu4m7MhjRlE652SMMOcO4rAekb0Lwqi0gfX?=
 =?us-ascii?Q?VXDBGBciiNutoCYWI9YapHubsYw/lRDL4gExbYkMd1Rt/Mxp+A9QlLTeySD0?=
 =?us-ascii?Q?fYpfWQqSHdkjXVY6k64dkiBugxcjXwpt2xd3hFxxYBSgr7OAHq6MxWGHkonw?=
 =?us-ascii?Q?+1BZoPUzss0XcGkuNStc0jdcUw4OLOX1aDoaWtXbLJEKwHv4ZpZGUOZt9qVv?=
 =?us-ascii?Q?qQPFHpNke2P2ggoqF+H7AaVqzBZF9wSkamsguvBNvcPd0J3Y7XU7JIXNVKlM?=
 =?us-ascii?Q?YtiSrgK+pj0RtzAca79k30LdhNqrWC/m9YcBQh7A5a78I5f1RcO5r1MIhMcG?=
 =?us-ascii?Q?PZt6c8c5S/I3ZZ1rqcOl31HXbhgbOrrUTZr7cA7Xz9d6fmaEpWEszb4xGbcK?=
 =?us-ascii?Q?jCKSfMHV603rqFRQoOA08/SC9AivFOZ0+6nTtyQf6c0i8KmY3slU+qeePtgw?=
 =?us-ascii?Q?SIpA8m/SYEDLtOsAHEzeEilTyKbgHZhnkh3uyMD/fb2xPF1cKRDIkRUILWtN?=
 =?us-ascii?Q?fYpmlh5w1JNNy/EUFnqIFlukp5OnDyFr2rN2iq974rUbskmNzMy1BGDL+vh+?=
 =?us-ascii?Q?TdpkdE3tdiJsMEl+Za4ZXSBRP+7WWgNnBFwsA+FcrS24saxS2xWHuevxK1xV?=
 =?us-ascii?Q?/r3DfJ5y68gVjxAs3lFIamAzC9RWUpDozd9IXC9GFKaVeGCdtqAreJLKR/C/?=
 =?us-ascii?Q?9dT65feH+m9OncyASFKdgxNitVG7Qh8XMxlayzo/A1XnmzTSdtNzeSDk7/fG?=
 =?us-ascii?Q?ZIUJSUgG3ALh+CF5Ni9bx0OiJe3SHvvN7P1cucvqdZcOJ/hN+WeGZ8p4ll9U?=
 =?us-ascii?Q?2LmKGED/S8KOyyz3rwbIMixIG1oTK7YuNxOx1rUpX8Ad18IeRSMylsglPB+J?=
 =?us-ascii?Q?0wxOqUR00ye1+HXMtB3VGqMLpzV/dEuk?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5751.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rsl8SIczESt8OkGH1yfVXTv5CVYgkIqvK8rYmsFPhCzGMeVPjKZlOb+isHHx?=
 =?us-ascii?Q?p+ifFzmCtQ1552LAeVjiBRa1VtoWJfTRr72nvGQdwkHnwj+GOr6E7SHHnHIz?=
 =?us-ascii?Q?7616ujfT8A0wZvpB0pl4Nt5ByC4txBK0C7OBoiyxBheqN4dfDBTML1SOGm92?=
 =?us-ascii?Q?ghR14IswN1tSv8u5hAkw60b+jKJr+8w2LO/QqVb74rQW4jzaYYCwcWfOIk2d?=
 =?us-ascii?Q?MfBg5PoN0VFSvdzt9XHYzlYTOjKNAwfj5iiCmAI1WWwpmmeaQbSGF6wIRZCy?=
 =?us-ascii?Q?tJUOlDz7I2Kv5jNl2RPb5U940NUzU9wnR4zFuQt9bhw73Bvlb9tRHOtsItCS?=
 =?us-ascii?Q?E6dpaATLhKt9HGGJW8JtvxSSJjbw2fYDpgBu5zHFFkhewkVCS0Sfkwmx1J7E?=
 =?us-ascii?Q?10GlZOt9p9gWWRjIOSdqg9qd5kzVQCN2mZ5ioowlY84KR6DmxLNulqM3g9eI?=
 =?us-ascii?Q?BZOkYY7Y06tl1n3Yk6CDghD/Otrj8EvjpG4QEznqwZ23nc/06h+fu2D60Efe?=
 =?us-ascii?Q?f3qzmQq4ykG54aDQgbfDUAMzMFyOBvWJ1ZVDuD8rEgI/Y1177bJK5ID1NPIT?=
 =?us-ascii?Q?QcVhiOjK3V0nL+L9KJCgPIo68anpoLCvPIKfnnPritkfsiN6xnrr38kTuSeF?=
 =?us-ascii?Q?/u53m5pl69+9sJ74fXTIHF2z/dU5H21eHj5wmtyfihYQjr0TMVk6KKUzkhWc?=
 =?us-ascii?Q?KWuQ9LVIkzCR5uXlubbYspq6vWhFek9ObIj7ZmOziqM0CH1tJGQKBfO7Y672?=
 =?us-ascii?Q?q/lImR3qRjTFdHfo/QI0cm+/4jhiXcKyNsJayDB0uaGerxrmkxoQnTVH2H3B?=
 =?us-ascii?Q?qi8H78gM8Rlxy3ygo0a27npHrhSK+1Dg+8bMot3Rhhgd9HryrW6sTOPISHqQ?=
 =?us-ascii?Q?Fdy8FfHGyN4i/PYBuah0H2+hPPl4BpLgawoeZQ6i8r+p97ddjNE7cF5S5svl?=
 =?us-ascii?Q?7MInPeKm9kOlxzRAIWIFHvl8OxPj8JEbOnCHH2s8SF/TN6lOmh2sNynTYogu?=
 =?us-ascii?Q?9l24cwL/z9W0BrzOSfu79GdFzdjzMwVwbEqLOmvYwtcnwjUJdfT57ucWhOm8?=
 =?us-ascii?Q?wpbFXMGWixgWT5JafPx/WabVMLJFiZTG4u9aaD+9JuaGwP2o/m0Kb9dMGY4p?=
 =?us-ascii?Q?HQWKwCf15vb+kvqFHf0oIe6nfKdVAEuSoADsl+w9vhvTcXcTYpXkmQqJ7rkL?=
 =?us-ascii?Q?l5OWY5OPKfYq898PGuBzxD3blzTOxwI81KSQcbi9j/zAdDKGbe3dsIskbwu0?=
 =?us-ascii?Q?38Dn31igBFDIH0tSGm6pCEMoeMhCHHpbt4akVOtjc2b1By93pPY8sBNmh1vm?=
 =?us-ascii?Q?1uu6MGhCcHFrrr2TjXfXsSCefGb/OIlOSOmhIy6bSYe+edDh1Su+3LeP/hbz?=
 =?us-ascii?Q?XNX8j9+GspxBHtySCUJ71ShacH+lPj9v6WzrWeuvQ28h6/ko2OeJWxvd72xI?=
 =?us-ascii?Q?pmFI2LfVAI6ttCh3r3Cax69+eySjsTQpZGa6z3UDeYhPqgSLpHq3n0s+u9pA?=
 =?us-ascii?Q?ZGE2t7Qgd//SWiEVB1l44RFtFz89S2X0OPhDqpYBHKJ3FYx7mjrnz/5YN8WH?=
 =?us-ascii?Q?gsPHosnSAlLz7FEbQEULUwsnOCbpfm2Kl0TuOjKn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94beb408-856e-482f-a778-08dd4fbd9d20
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 01:43:15.8897 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KjF6lfRUrpuiMFCELFAcm7Qrn6wveQH7vRVjhpwObEaMDaZ0TbbDGGnqhP2wnOAn9c2UuiuxyBrzy6TFFky0nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8850
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

> To be clear, it means you should use the same bindings at the linux kerne=
l,
> which we have in dts/upstream/

Hi Tom, okay got it. From Linux perspective we are using both below:
1) dts/upstream/Bindings/net/snp,dwmac.yaml
2) dts/upstream/Bindings/net/socfpga-dwmac.txt

In the case of U-Boot driver is mismatching with Linux binding (which is un=
likely to happen),
I will need to submit the changes to linux mainline to update the bindings =
on the changes?

In summary, can I say, we will drop this patch, and just follow the dts/ups=
tream binding?

Regards,
Boon Khai
Ng Boon Khai

