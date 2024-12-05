Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DFAAE7716C
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 09:37:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAE69893A6;
	Thu,  5 Dec 2024 10:37:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="OFhjFCO9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F32DC890D5; Thu,  5 Dec 2024 10:37:01 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF25D8948D
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 10:36:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733391418; x=1764927418;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=PphWZnuLJRm88k/nmKG4L0e1R8rTTgVJJHaXLLjJd4Y=;
 b=OFhjFCO9dOKH7fu8wl94Z+jvFU1duNR9o+oKgybgK9oeFmOjga22rSoR
 0GrW4GFcB+zW91nm/btjRJpWUQi1rZhG8mZS1pyEcUjZG3Vnl/zHSMRBn
 O98azut+ypAqb643t39KoYrgvE/E1wX4G/qoXW9evLuF9X35ZMNqI8D3U
 GqgQLDq6kKWmnq/gBWGP1IhchjydJqI9Opi1wPLOQUnTXIrneHmxQwXO0
 ngucK2kqp1NdRPb31DAld6p6CEjG38OkHeLSvvWjxbeNEPtOo8J3Ra4XD
 aYUI9ihJHGTiNkRJziRlPX6R1YryDWW2MX/EnA3aUIvJoc1kpDzQFBqSX Q==;
X-CSE-ConnectionGUID: tt7TRcMgSKCLPUuX9Ed1Ww==
X-CSE-MsgGUID: 6FqRMzxBSA2hpFEOI2Jk/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="56171807"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="56171807"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2024 01:36:56 -0800
X-CSE-ConnectionGUID: OC2y9u/AQImtO+V+jz9GwA==
X-CSE-MsgGUID: wbYeLdNQQ4KnOmSUXN19mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="94479379"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 05 Dec 2024 01:36:57 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Dec 2024 01:36:55 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Dec 2024 01:36:55 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Dec 2024 01:36:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sCMLmIPAOfZytlRSTpkv0IPIQm0QiG57+ouXua5n+FlYRYqpgO2m7zJNi9uCa1hi7XYnVD/flTsTmpu4cFNAROdLskjJtDwNcrtdeX3EgGZpa0JXorrTP/UoJI2q6usaJc+vOry0deRwvgrRQMLlKKASPIYu1kqybJxLcxF8ZJYL9uHwMm1qaI7fYjX/Hm0NHat4TjQHYFno0TuwigptG6BlI0z1y+aV9vPgAIu3ATt3ulmE2zg7jsLDNZuRJLO96jOEJuXeNCRasEbNKWbz+68ur5Z+MCqf70+/6ACuQ9XcznBUXEyZTS7owp+OgU5CM7to7nKG7W/ZOyMkRVlp8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nd8Sj9VFeicD4VfuqcJqkLBW4hLuJLpzZqYoP5pdHmc=;
 b=s4HlDuyfo4y7nw77UOQLe8uvmovzlywLq7E6QOWm4I/FIZpWrRJgk+RNFNRml3z6Ue/iwm/HtMUGRriISvqVdaEkg7XJ/SHOQ/81zFQlRBf7tWJgIOCa+pCpb69pJ60raMqHiuPgNtU+nf50gH5r/Kj8iq8EV8tKgMeEolpvqZ3vamssCBWFufRA3q/sAZKiqDspLKuaxBSMMgwNtV9Rg0u+xAYTKttY8vsO27vRjh4dweeZDWhO/iN688WG2MvV1J6kCX8YY0c51JBUiilE/kTQUmoo0RZ4jGmumjKuN+jfwxr06SssmDUuqolj2QgF85EqEgYLgdmI3K8aMfyMXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5366.namprd11.prod.outlook.com (2603:10b6:208:31c::17)
 by PH7PR11MB6380.namprd11.prod.outlook.com (2603:10b6:510:1f8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Thu, 5 Dec
 2024 09:36:50 +0000
Received: from BL1PR11MB5366.namprd11.prod.outlook.com
 ([fe80::f073:1e46:c7ee:df9b]) by BL1PR11MB5366.namprd11.prod.outlook.com
 ([fe80::f073:1e46:c7ee:df9b%5]) with mapi id 15.20.8207.017; Thu, 5 Dec 2024
 09:36:50 +0000
From: "Maniyam, Dinesh" <dinesh.maniyam@intel.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Michael Trimarchi
 <michael@amarulasolutions.com>
CC: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>, Tom Rini
 <trini@konsulko.com>, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Johan Jonker
 <jbx6244@gmail.com>, Michal Simek <michal.simek@amd.com>, Arseniy Krasnov
 <avkrasnov@salutedevices.com>, Alexander Dahl <ada@thorsis.com>, "William
 Zhang" <william.zhang@broadcom.com>, Igor Prusov
 <ivprusov@salutedevices.com>, "Meng, Tingting" <tingting.meng@intel.com>,
 "Chee, Tien Fong" <tien.fong.chee@intel.com>, "Hea, Kok Kiang"
 <kok.kiang.hea@intel.com>, "Ng, Boon Khai" <boon.khai.ng@intel.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>, "Zamri, Muhammad
 Hazim Izzat" <muhammad.hazim.izzat.zamri@intel.com>, "Lim, Jit Loon"
 <jit.loon.lim@intel.com>, "Tang, Sieu Mun" <sieu.mun.tang@intel.com>
Subject: RE: [resend v2 14/19] configs: nand2_defconfig: Enable configs for
 nand boot
Thread-Topic: [resend v2 14/19] configs: nand2_defconfig: Enable configs for
 nand boot
Thread-Index: AQHbRveKyKhYgDbAvUuMQLjo5gdJx7LXYwLg
Date: Thu, 5 Dec 2024 09:36:50 +0000
Message-ID: <BL1PR11MB53660F0C5BE89BE5CEE5FBA982302@BL1PR11MB5366.namprd11.prod.outlook.com>
References: <20241205092315.25060-1-dinesh.maniyam@intel.com>
 <20241205092315.25060-15-dinesh.maniyam@intel.com>
In-Reply-To: <20241205092315.25060-15-dinesh.maniyam@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5366:EE_|PH7PR11MB6380:EE_
x-ms-office365-filtering-correlation-id: 61939dc7-e8fc-4027-e2df-08dd151058a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|10070799003|376014|7416014|1800799024|38070700018|7053199007;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?7z/Q/+WYvjNJoUu7WQn3rgKZBM8Rzxh1mdbPXAB5eYrXx1Bit/GmJ/tA0L?=
 =?iso-8859-1?Q?b0RoOHNTU7FcXWG9BDF00Xii8VeOQ7Tg1p7P1pXuzP98m4IdPqpk+7oauB?=
 =?iso-8859-1?Q?99p72f0m1/2Rprq7dUUQaqKl76ViYAidzPsFQpnFIjb5DOTJc1ajiDbS3O?=
 =?iso-8859-1?Q?Ep+2iltI4/rnWO14CxMjgRn5Npkz4BUrUij1et5sp4ICBvtKPIbu+p0rNb?=
 =?iso-8859-1?Q?GQbP8bAZDJp5JalQ1bW7xqKY9fLHQdm5cnvPc+U7nI6vGAcUuSmTV8luJf?=
 =?iso-8859-1?Q?jz1eY04ID7m7o4iuKjpLY3mjbpsyskxLOEeVsqJvKxDB7mCnL3saPe4SKx?=
 =?iso-8859-1?Q?2sgyZTOVwlEvCF5uh0d+9WImMqWWWwQktWkTJ4AWCw/imnPef2EA26nNrV?=
 =?iso-8859-1?Q?l8hKiZLeoFv3IVDQkMNggEUVeWHn6xcGCPILKSNOtiVJfztzVYokQLyHaI?=
 =?iso-8859-1?Q?7hIL/pdtvcoVZrFWTn3gGZ6URL5NUZnNeQJVrqjhVYUta9cKCVtLSvSqd5?=
 =?iso-8859-1?Q?QzLLEdO+VBtp+75W6+fXjV4dT5s+PeK/b7+Y8ZwTHH1OQlnDbjoFqmz7hW?=
 =?iso-8859-1?Q?kmCgBO3YB1rLtbMDF56JgH3uVu1PPq1mfuA4M3jgWIcibSzEgRSlYC37i5?=
 =?iso-8859-1?Q?bSJSosSWEOCGYInOXaGHf9R4mNZ5iqw+1p3p6bkFt6SQsJQ/I81OiPRse8?=
 =?iso-8859-1?Q?2e8iF9AvfkPwvsY01Wv7Lgw0UFBrEU/THGoW8MgiS4RPHWhLuyO9H2lmIA?=
 =?iso-8859-1?Q?JPLuJcQAA2ftWbivPqryh+dCPfcmvgnylVljM9YkDmFwLO9Bj76ksCFnuf?=
 =?iso-8859-1?Q?8Y41R2dlYPbXfv0ZXUAa42YlcZYk7kXGap9Ii2cpR9jn/xC0gbv00hC7D+?=
 =?iso-8859-1?Q?/S6XHxe2zrQLE/BsVghwI45KHJXwrXOPMDrteaTnkoTKywWw81ZmKee8pw?=
 =?iso-8859-1?Q?RqDdHJt8UhFs18FbN/h+nI+UYXhsCniUYWVYhVICGJQz6REc/3H2nVfPuu?=
 =?iso-8859-1?Q?vsFLxya4JqFyNN5HhuTWJz4WCtIOE/YCV/sVaDY7JCWoCIptbqUEigpmXs?=
 =?iso-8859-1?Q?QkH/+e7UMOEzAlpJT1I0u9DL417EdjmGmr6KvahA8R+O4NLR6dLu4uFsAe?=
 =?iso-8859-1?Q?gk4aZwa9Sz4d58gxSKGIpoIWrXEdOdeUJRvzw07+sAZrb4yc4Kk5cJu5wd?=
 =?iso-8859-1?Q?Do+33Lspht7ew2coP25kF0Yw0LsnGUxc73Ip82hzmjcKVSGQ7HOFRHT36x?=
 =?iso-8859-1?Q?umv6SR67e+3rYAA9KMT+uEMA6xwJWPv5FfUAv1SB/vwbnyCv75CC8ldLCU?=
 =?iso-8859-1?Q?lmVKhP+B6x77iplROJdTIdqSE4vilwnjyv4aUm+Z0QIZpkyzjB7bFHuQ9Q?=
 =?iso-8859-1?Q?1HSkBZ//NaX+m8fFjAUmOLNGVOrxnpsbXHxyyD2Al4bz1RCIhlOo8TqcEW?=
 =?iso-8859-1?Q?HISnyy1PHl2UdyRp82oLk7qki42XE1HFrWlj/Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR11MB5366.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(376014)(7416014)(1800799024)(38070700018)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Z8ufzDC29J1cLQgfQilXPFjbRrwjTf78sONdujEcIdC+KLreBaJvnfVGCv?=
 =?iso-8859-1?Q?6sHOZgrhRxtcN9UqsiUYDKAtA89zYwDw3EubfVaRV6oilN8LeAKREg8c+S?=
 =?iso-8859-1?Q?H0cy3TZunUisnxXJu1++zqAVK2zPTe4YdhEhvrkUwsGWY9Vbxl6l/VSN2P?=
 =?iso-8859-1?Q?pLwQkQGYGgte2a2QJC9krJMqO49Za+g98omvsRlcRAsjEraPu3rHWH2caJ?=
 =?iso-8859-1?Q?8gjXmsHjSlCnelDmRsTxfDJvzY2w6oX/CRpNcuxlWANmHlE/wmKSKj0JCk?=
 =?iso-8859-1?Q?YzfMN9ulff/9r63BP96lwPv4GwzLJAxhFYzljD9i3bEzsu395li3gBUB/l?=
 =?iso-8859-1?Q?U7wDW7sVY7neeT1a/Ne2DP1W0nY/7uA/DBafXUUb9Ao36e4g5CJwNcfWwo?=
 =?iso-8859-1?Q?pMlmYmfI1fnn6VCFvJQ0ZNKZSBB9LgIeagFq/B6Fbug2puhOL6O6KjVtMg?=
 =?iso-8859-1?Q?OIdIi3fMuzg32Xugr/E063PQD3IC/Qj9/VUShAhSIS+X1XqUMAnzl5J5NG?=
 =?iso-8859-1?Q?3iQd0ZauOBtvBr7uicYRdyiuR4lfSSH3OjhRFBJYejjH5AtD1kDJcAmumL?=
 =?iso-8859-1?Q?IlJcx5DH6Qzgi8+khbxy6cZiDcnR447oHgsW5aXB/u3pCRDsm3bg/pKz0B?=
 =?iso-8859-1?Q?G0TUbjFOuvUwqzd6gTMhQ23zHyzP1MB0FZTCLOvJBwWpuQcRyMIdTslPct?=
 =?iso-8859-1?Q?g97eyGP+usysFnTSxsu7j6nWGGlh46yGNBl0DgEkrljmUWdcCpUg8m8UYy?=
 =?iso-8859-1?Q?QLvvLE85ZX+OeuTpgOa3AiQQl3lImI1/RN6sBVtjLZrsYvHztI1/m9niTf?=
 =?iso-8859-1?Q?fruM3NNcoWyh4qtZDEI5DJQ6+NUNVZxeCiGm0aSOxlShyfbOEzElLndjHO?=
 =?iso-8859-1?Q?2iyEOTN3SBo3n/O7ZHjvWfJo37Q4AV+0tAS4tRaSDEvncKGiLmue3SyCmO?=
 =?iso-8859-1?Q?O/BjL0zlSIP6cMhmChiGZ9VfDyIYOUPKO1w2ODHQmyWP5txGJgIY4/7k8h?=
 =?iso-8859-1?Q?mUHklD5ffDycnZOTHpXaCymePFJWoqTu4WvXfxo6PKQCcBurx/A11R3nRz?=
 =?iso-8859-1?Q?8F7z1ZWHNVyU5y6VRcTTA0gVIrLWsBoIHLWYbJ58uwdCNcl5U3mpjNLDbZ?=
 =?iso-8859-1?Q?TzjgJKpFT7edW0xHHau5Twn4erAs14RQ24by8nHdCm+bEM8mxpu+fr7t4J?=
 =?iso-8859-1?Q?cVzeh+gvGL5tD/C8pXeJO2MquVT2bhROWJHkULBy0fkkR2Yua+uK7uLBWX?=
 =?iso-8859-1?Q?nJjCR+0p1ER90dC6H6CVkHR8DQ6x3krWXJlel4kM9GDMXe4dA/grzg8Ezh?=
 =?iso-8859-1?Q?oE0gtu8TJItRZQBrE1laBHuJqdz9BoP6XJKyC2iPG+xD6uHhOGbhbi/HII?=
 =?iso-8859-1?Q?iNoc6164Lh2pAFPofVb8WSd0C0epoAeCmtd2tt2mdzdAPE8L9mOq7a/Q7u?=
 =?iso-8859-1?Q?5gP17JZ5gmPkBECWYtOwVVmoz6vnbY13jrVGqi4WwLbdFLcRMClA2Ds2uU?=
 =?iso-8859-1?Q?wAl8Yfj8c41sjpjSlAyrcfFZzMhOx4sV/6K9uKjqxb43lFMyMwE/vI+vdv?=
 =?iso-8859-1?Q?MIiIGBCWf03JP40Tp2izwgCRH/GHImIUf2+TqncuuYPzf4zVGRrwvaGKpf?=
 =?iso-8859-1?Q?e6ChDDm34fMqAVmK5fJnHvTL3W1BFeTs70jozRj4ggYm2Q90WH5t3uPKE9?=
 =?iso-8859-1?Q?VxHJ7AKUFmzbP+jaNhH3t/4NNUsBZIKHQV85I/RL?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61939dc7-e8fc-4027-e2df-08dd151058a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2024 09:36:50.7076 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q7WKAAtp/J9PY5ftIH+wCW7Ys1TSq4TSk8WGR6q1tN3Bzf+lCdtFcfeN0RMMYhvMMHBuVRZ912IeCHoIzC4dgUJ3B3q5d3A5MRfS0KFUBVA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6380
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



> -----Original Message-----
> From: Maniyam, Dinesh <dinesh.maniyam@intel.com>
> Sent: Thursday, 5 December 2024 5:23 pm
> To: u-boot@lists.denx.de
> Cc: Marek <marex@denx.de>; Simon <simon.k.r.goldschmidt@gmail.com>; Tom
> Rini <trini@konsulko.com>; Dario Binacchi
> <dario.binacchi@amarulasolutions.com>; Michael Trimarchi
> <michael@amarulasolutions.com>; Johan Jonker <jbx6244@gmail.com>; Michal
> Simek <michal.simek@amd.com>; Arseniy Krasnov
> <avkrasnov@salutedevices.com>; Alexander Dahl <ada@thorsis.com>; William
> Zhang <william.zhang@broadcom.com>; Igor Prusov
> <ivprusov@salutedevices.com>; Meng, Tingting <tingting.meng@intel.com>;
> Chee, Tien Fong <tien.fong.chee@intel.com>; Hea, Kok Kiang
> <kok.kiang.hea@intel.com>; Maniyam, Dinesh <dinesh.maniyam@intel.com>;
> Ng, Boon Khai <boon.khai.ng@intel.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@intel.com>; Zamri, Muhammad Hazim Izzat
> <muhammad.hazim.izzat.zamri@intel.com>; Lim, Jit Loon
> <jit.loon.lim@intel.com>; Tang, Sieu Mun <sieu.mun.tang@intel.com>
> Subject: [resend v2 14/19] configs: nand2_defconfig: Enable configs for n=
and boot
>=20
> From: Dinesh Maniyam <dinesh.maniyam@intel.com>
>=20
> Enable configs for nand boot.
>=20
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
>=20
> ---
> v2:
> - remove the "this patch is to" commit phrases
> - using #include mechanism to keep track of the variant
> - add maintainer
> ---
> ---
>  board/intel/agilex5-socdk/MAINTAINERS   |  2 ++
>  configs/socfpga_agilex5_nand2_defconfig | 33 +++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
>  create mode 100644 configs/socfpga_agilex5_nand2_defconfig
>=20
> diff --git a/board/intel/agilex5-socdk/MAINTAINERS b/board/intel/agilex5-
> socdk/MAINTAINERS
> index b696f788c8..30d8815d20 100644
> --- a/board/intel/agilex5-socdk/MAINTAINERS
> +++ b/board/intel/agilex5-socdk/MAINTAINERS
> @@ -2,7 +2,9 @@ SOCFPGA BOARD
>  M:	Tien Fong Chee <tien.fong.chee@intel.com>
>  M:	Teik Heng Chong <teik.heng.chong@intel.com>
>  M:	Jit Loon Lim <jit.loon.lim@intel.com>
> +M:	Dinesh Maniyam <dinesh.maniyam@intel.com>
>  S:	Maintained
>  F:	board/intel/agilex5-socdk/
>  F:	include/configs/socfpga_agilex5_socdk.h
>  F:	configs/socfpga_agilex5_defconfig
> +F:	configs/socfpga_agilex5_nand2_defconfig
> diff --git a/configs/socfpga_agilex5_nand2_defconfig
> b/configs/socfpga_agilex5_nand2_defconfig
> new file mode 100644
> index 0000000000..3bfe6270fd
> --- /dev/null
> +++ b/configs/socfpga_agilex5_nand2_defconfig
> @@ -0,0 +1,33 @@
> +#include <configs/socfpga_agilex5_defconfig>
> +
> +CONFIG_ARM=3Dy
> +CONFIG_ARCH_SOCFPGA=3Dy
> +CONFIG_DEFAULT_DEVICE_TREE=3D"socfpga_agilex5_socdk"
> +CONFIG_OF_UPSTREAM=3Dy
> +CONFIG_BOOTARGS=3D"earlycon panic=3D-1 root=3D${nandroot} rw rootwait
> rootfstype=3Dubifs ubi.mtd=3D1"
> +CONFIG_TARGET_SOCFPGA_AGILEX5_NAND2=3Dy
> +CONFIG_PHY_CADENCE_COMBOPHY=3Dn
> +CONFIG_SPL_PHY_CADENCE_COMBOPHY=3Dn
> +# CONFIG_MMC_DW is not set
> +CONFIG_SPL_MTD=3Dy
> +CONFIG_CMD_NAND_TRIMFFS=3Dy
> +CONFIG_CMD_NAND_LOCK_UNLOCK=3Dy
> +CONFIG_SPL_MTD_SUPPORT=3Dy
> +CONFIG_MTDIDS_DEFAULT=3D"nand0=3D10b80000.nand.0"
> +CONFIG_MTDPARTS_DEFAULT=3D"mtdparts=3D10b80000.nand.0:2m(u-boot),-
> (root)"
> +CONFIG_CMD_UBIFS=3Dy
> +CONFIG_MTD_UBI=3Dy
> +CONFIG_MTD_UBI_WL_THRESHOLD=3D4096
> +CONFIG_MTD_UBI_BEB_LIMIT=3D20
> +CONFIG_SYS_NAND_U_BOOT_LOCATIONS=3Dy
> +CONFIG_SYS_NAND_U_BOOT_OFFS=3D0x0
> +CONFIG_SYS_NAND_U_BOOT_OFFS_REDUND=3D0x100000
> +CONFIG_UBI_SILENCE_MSG=3Dy
> +CONFIG_MTD_RAW_NAND=3Dy
> +CONFIG_NAND_CADENCE=3Dy
> +CONFIG_SPL_NAND_SUPPORT=3Dy
> +CONFIG_SPL_NAND_FRAMEWORK=3Dy
> +CONFIG_SPL_NAND_CADENCE=3Dy
> +CONFIG_SYS_NAND_ONFI_DETECTION=3Dy
> +CONFIG_SYS_NAND_BLOCK_SIZE=3D0x20000
> +CONFIG_SYS_NAND_PAGE_SIZE=3D0x800
> --
> 2.19.0

Hi Michael,

Please guide me through the process to=A0run the CI in github.

Thanks.
