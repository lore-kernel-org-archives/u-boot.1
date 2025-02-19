Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3668EC021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 02:55:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77A6D80A46;
	Wed, 19 Feb 2025 03:54:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="auUSCvAZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC7A880C8F; Wed, 19 Feb 2025 03:54:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82714809A4
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 03:54:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739933694; x=1771469694;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=k75nK1ZTaFAMYFJoo+QpFz190jvvGN3xHNpVKLN17qU=;
 b=auUSCvAZzT9EAK5RGJ0g7zTsOneCuPwngpiRsoPRgNKFT+ASUCDodS15
 D1lyGuR1o7/t8DwXP0LApWhBRX4QP68Bp7lySMYV0Omv/azEYNYx1XCXz
 5Tpwiem2Tgq8nfhCJwGk85KP5mudCrdCGGbA4bA37UmKcNRd5Z7KxsWE/
 HvcMn4h6qDFmLKONb1DKSFlKNsVMsQyZl3V/c0A66p2K78xWyCznTI8oS
 UGdUrg2qcueE/R38PO0ZGXhsLPtLjU15SSoyKzZRJ6tmOq3OPcflIW6hW
 R49M2UQ58poIQDmaKM/6jbNBAa1Q4MmJ9RUCzBjZk4FzJVPJsLolAQgm+ w==;
X-CSE-ConnectionGUID: /1WWBbxQQH+4mrychCYmwA==
X-CSE-MsgGUID: Igi31QbeTpSvsHEAfGwegQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="52060196"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; d="scan'208";a="52060196"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 18:54:52 -0800
X-CSE-ConnectionGUID: ACb1jKwKTnmPuWmf/XcoMQ==
X-CSE-MsgGUID: CPKbZXY+RCqio1vCxwZWjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="119517449"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 18:54:53 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Feb 2025 18:54:51 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Feb 2025 18:54:51 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 18:54:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y2XNvyyZdI1EH5Bf5lB5+Ecj+F/8S1o0XjTHGH4+E/HfmMtDAlmHRJntPdSI1iu8hL0r7rMKEtjKPNx7fEKtsn25Bqi94SKfsWLHk3pC65rhPOvVqoJc463H2umIhcl7pYY6dBtHRfJon2GR/UH4Es4Mr/UeOS66yW4Wx7NQI3mr9YmGEpSFytIyRJnvF5o0oPqi4Au0A2N6RXkuX3zlsK8SOc48hEw9vBHPWaUDLtMOhEDxn9Kvk8tTphv5jTmGd28h+SWA7xLzydQsKjMIb+RB8ULpqUqywCxQOXVx205VMmh0angf3ORKHZCrpUg0J1oKfeVOeaKqOMMxE4HoJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VX5YNORbO1oAdYn0NLS0fX60O10MehVuQSNwrzJDB3A=;
 b=mqRgEp66+EkzrJskZZ0Wcr61xazpQOG/EygLxn461ltjIWwIoikgY+bm6Mh+yhIOEVycoNU87ITpvuSfipPkT4kgRRI4uPaTzxEKOus8oRR209IdSENs5X2iqZWrivT5PCxuXCXXp1d/xdwU9FKv3lanDSZxpWxP0tkCk/qj/J8e6/NlBqLshw3vCbIjfilAWP/JQxXAZ4Bj2EzjerNlnjxxv5nUSXpnEqw/qHTLT5EIAi9h/VMtWQ/OV7/XG//Z9u8K4kiuNCgXRpYsm5uBREbt4jAWrmxAAyP0NDlWGrR/JRNVijkstSEDiYezNsV00URtWv0KQpZB+bfucr0CnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5366.namprd11.prod.outlook.com (2603:10b6:208:31c::17)
 by MW4PR11MB5774.namprd11.prod.outlook.com (2603:10b6:303:182::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 02:54:21 +0000
Received: from BL1PR11MB5366.namprd11.prod.outlook.com
 ([fe80::f073:1e46:c7ee:df9b]) by BL1PR11MB5366.namprd11.prod.outlook.com
 ([fe80::f073:1e46:c7ee:df9b%7]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 02:54:21 +0000
From: "Maniyam, Dinesh" <dinesh.maniyam@intel.com>
To: Tom Rini <trini@konsulko.com>, Frank Li <Frank.li@nxp.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Marek <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, Simon Glass
 <sjg@chromium.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "Heinrich
 Schuchardt" <xypron.glpk@gmx.de>, Jerome Forissier
 <jerome.forissier@linaro.org>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>, Dmitry Rokosov
 <ddrokosov@salutedevices.com>, Jonas Karlman <jonas@kwiboo.se>, "Sebastian
 Reichel" <sebastian.reichel@collabora.com>, Wang Jie
 <dave.wang@rock-chips.com>, "Meng, Tingting" <tingting.meng@intel.com>,
 "Chee, Tien Fong" <tien.fong.chee@intel.com>, "Hea, Kok Kiang"
 <kok.kiang.hea@intel.com>, "Ng, Boon Khai" <boon.khai.ng@intel.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>, "Zamri, Muhammad
 Hazim Izzat" <muhammad.hazim.izzat.zamri@intel.com>, "Lim, Jit Loon"
 <jit.loon.lim@intel.com>, "Tang, Sieu Mun" <sieu.mun.tang@intel.com>
Subject: RE: [PATCH 01/10] dt-bindings: i3c: Add YAML schema for Cadence I3C
 controller
Thread-Topic: [PATCH 01/10] dt-bindings: i3c: Add YAML schema for Cadence I3C
 controller
Thread-Index: AQHbgbDbNNz6e3ZDUkKfFBKSL5OqUbNNP7aAgAABRoCAAK52gA==
Date: Wed, 19 Feb 2025 02:54:21 +0000
Message-ID: <BL1PR11MB536672568A0F7371E4DA4C8B82C52@BL1PR11MB5366.namprd11.prod.outlook.com>
References: <20250218025705.50051-1-dinesh.maniyam@intel.com>
 <20250218025705.50051-2-dinesh.maniyam@intel.com>
 <Z7S0LcUSb5y8Nr4u@lizhi-Precision-Tower-5810>
 <20250218162847.GG1233568@bill-the-cat>
In-Reply-To: <20250218162847.GG1233568@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5366:EE_|MW4PR11MB5774:EE_
x-ms-office365-filtering-correlation-id: 7d2238f8-f721-4096-21eb-08dd5090b5fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|10070799003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?go+KxWhncHr5t8QsvD5AMM/Ukifu2W43n0cA1/ZWZ1pvCWG29obFdz7iIFsg?=
 =?us-ascii?Q?lgvGrYuovxG8Jo9+1uUH/dBt4vu7NK8abwwiwgBGaPyc9ZfEL8oIsplBVDnV?=
 =?us-ascii?Q?5uNJuQXcql6leVy3pB+UJF8d62vXGdE6MdirgZ7F4e7AAlvWvix2Rc59SHHP?=
 =?us-ascii?Q?z7vxEUgRkayPZTbbFkxGqWscCvp8Perj90VzHVFbYWSwxwEZFO7xw/GvNr5h?=
 =?us-ascii?Q?K2Sf9Jl3nnpx1eaNkUxY4FxgTGpEGlBcw00tf3DwfUsCbXzXOd4CD2jeFIfE?=
 =?us-ascii?Q?odFxOkrIdkyFD80WWAM/DBK1L3g0S7ZmDtimwRgNI59ELeunj+JSBTjuedUZ?=
 =?us-ascii?Q?O2T9p2a0fWIt7DcWSAR5IDVGiTLh9tac8br9+sP5+Rxqkkf4sKDHjJN2SOly?=
 =?us-ascii?Q?RIQnScFUy+qm+yTHj+dmIaEBhgPyx+Tif69bIx8AO/LvQq+z4yoeCKUvDwFi?=
 =?us-ascii?Q?AbCIMluUlWmLiKDAnfU86IYcYwvvo1FqdUEG0S/m0e6gWw/MjdY78GV4D/rS?=
 =?us-ascii?Q?bFpAPYbVsVJ6cnP/GpivgPa1XwKMe62lnfgm8eTotXjJ0tuhQQRQ8d3nevUd?=
 =?us-ascii?Q?JJbyZdAnme/PON5q7/dzw3fozcRGCEK8T+WyXQ49zifnhtHzl1TlLDkSc1Px?=
 =?us-ascii?Q?wKirAYm1K3lEE4MewQwWFYtb//Haow5yeq5WmDhlqry/mO7/QjxXzYk3/nmC?=
 =?us-ascii?Q?zUkOLkCNsoxi6UwNlNn36eEesnhUT5CsRM561z6CbbRtehcF7PXNO8IEZiwQ?=
 =?us-ascii?Q?ozLFThN8hkNxOxrE53qidJB/h7UqxL5o5m6pIrzs+u30hdfW+ZjrKliMkoCA?=
 =?us-ascii?Q?Z8Ame2mZGMUWIC66EYJhya/YkC3o1eG9RFf38LhGr2KonhFDfipz5YMMh0MS?=
 =?us-ascii?Q?pr8iXi4+ct6zzxyvhMxXLy4VFgX3m/lP9nOw1ELUjl+t5MHM97EwxPoy2e0v?=
 =?us-ascii?Q?qOMVLZXpDMfJ2zHCVPXllWqYUzMMw/eGBR+EiJLF43JREMI0loBC0JR4buY5?=
 =?us-ascii?Q?rOBRxsndX/jLEBWWZylT8XalL78nkLF3QmQp09tZnUwuxDNj32DTJEoRAN/k?=
 =?us-ascii?Q?ij0Xv0BDjDLc+EuEw8BMTeNND5cdtzBf+vU/IZdKpsfpgc/BnoGz2Rw6l374?=
 =?us-ascii?Q?ilXI/KJDTaAdHjhei3F1CSpV5EkPRc5g2bH8aMA8s6NaUcI6yHkn96tuANQm?=
 =?us-ascii?Q?J4RdVC85x7VGcKmxi4zJpy+Gqr/H8ju0eLiw4Nn8z3xkr3OFUvCl6opNWWyD?=
 =?us-ascii?Q?e7mR2H6+q5keaLQ/rFXgujoNBbP0hGqwVrYSMItokQ3u+qS+1IElET1Y2Eyc?=
 =?us-ascii?Q?j/uv3r11ndgT+6WAzPhRSrDUePp0vllwjaCEklj9Ly6igiyu09M8xciUb7Lv?=
 =?us-ascii?Q?chvyE6Vo5p+1JUGho9tv+7wtMXlLxJIGoyp46SRRxEM1UrjWQ/SF8JCcXzet?=
 =?us-ascii?Q?PSWkQEKb2Brqno9Bndcn34uUgCA1MYuj?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR11MB5366.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qqEMJd7jUMatyQpA1vSzJP3QOQk+xIdxZPFopHJ5+Bzxid26wirX+JpTliw9?=
 =?us-ascii?Q?jBz63TK6XAoBYcWRWYugenx0PGXiwTvfWoH0NYurE8VJR9uMan6MMmK+/dny?=
 =?us-ascii?Q?9fPcS0ZiSs1SvFc4L4YNaCsz9RzgNGChRuBnP+8fHGv37yXltBJPXvMBwf4h?=
 =?us-ascii?Q?2oMHQ/XyWfEtwx5hZRHTD+DQGgURbZWsXohsYDvNet737w+cljWq2YI+XGsC?=
 =?us-ascii?Q?0FAsCp3t7qDH3HRuCT7LCKdoqfKT8gugVWo+YqYEY4eTOMJyD5+AJNu9CxYm?=
 =?us-ascii?Q?7j3Av+YSGbNJPSJuMk0YX3wpFwk5UlMQBM+IY+AisiG0iiIymUYiseiCZ5AD?=
 =?us-ascii?Q?s4+5d8Y5QrjbT4l3Y0JhPBcsx2mRvnXTy/1fefKU2epGUc/ebK4jF6RJOvPR?=
 =?us-ascii?Q?OmH840lHS8c33Rg0gEz5JDGMGeZtrIFizlStbqJlnO2XmJ0kse5PpF1BRha/?=
 =?us-ascii?Q?Mrw/6aBS0mMCyD3JBvHpP3wUQJFMZufjS1Tb20IrxZUY3+HgQZ7wWv/39O4k?=
 =?us-ascii?Q?rzIpD2EfhcF02NCO2RDNKyqvHxhEfnsgdzT+Po28SRhen3j2OStcHJqyVl6e?=
 =?us-ascii?Q?ShjNbhaF1hpMSPj+MndgACoS272NR4fTChHK1e5ZivQTje4E7pwS5K7yfjmO?=
 =?us-ascii?Q?R73LMv/FmHnFNpkuqtWJMaxJnOEFp3Zro/g4oNOZPvRVEUYBRY3e6F7IBLh9?=
 =?us-ascii?Q?crCQgspB985tWM2nNRlOI2x2MQtG5Z93WnAQU0Y3zHgPrlSXSuvmUyt6Qxw1?=
 =?us-ascii?Q?FVxMJbJjwydSUgvDMgwEPBUr75LQYegR+aBrmzv24gsjjH+oj5BYxkVINe81?=
 =?us-ascii?Q?5O5hs4hHexDd4Y0NC5EK5sDiAPHJUkW+bGJwht0Vl2oqgKqB/Iod1lxzjgUO?=
 =?us-ascii?Q?q5okDxLqKxcfhb+8ZauVkvlWwgep/7qJ3xoC1gFPJbmF8ivybW98bUZOSoso?=
 =?us-ascii?Q?a6HuV68oU+x7GzjaimWiNlQ93/WF8pG4oQZ7SRqrk77LP0ZNp1XdNTDfn/sA?=
 =?us-ascii?Q?gkQiKNz3Lf9xJR+Un2O74CcBnOwbDHtYJ3KbA/rc9VTx5kBleBEsQ4YZ8Bns?=
 =?us-ascii?Q?gKAJ6ujNaWGMjNI4VUmJcTOWihEXa5fyL7Jhih+FzIHE7bvB6vqCvn90zS4s?=
 =?us-ascii?Q?fCoo7mB+v0KmjL2zYbD4cSXGw77LvMMUqAcnH6BomYsqlorvwg05ViDQeF6J?=
 =?us-ascii?Q?XXiqTsoQXza1Ahuo4cPEducuCP/pvEKbi+m0w0QWyE29u8XaZXscdcRW8WLB?=
 =?us-ascii?Q?JbWlhZeHMPu2sYjD+9nW7q3FAEuYJhjUc+suv7BfHJfFsh3fx8BmWoNmnFvi?=
 =?us-ascii?Q?toQNDX1QtVGfjJbbhlCfudqtbZunSDbz+j/Y5X2lJt25kcnp276GqeTelrJP?=
 =?us-ascii?Q?A3JyrnJatwNDp0JZBt9zNyiTt2fDcuSmeXJKNwZnUS1qqfK6FFaclFgYVazA?=
 =?us-ascii?Q?OiOBivDChk1Dql5B5TbU6PSo5/yEB3QpL7IMon1pJ8fz7Q2IuGSfZejjYWax?=
 =?us-ascii?Q?FHUAMHHqg2GaFYL2koK6eacbywrmsNKn3DfvDM15Wfgk+rIeH6SY1rocBvxF?=
 =?us-ascii?Q?UcTQBVl208ReBtfrxeKnLl0c6my/n9vS/Sms9Ao8ULkr2uQ/XOO9IQ88klWA?=
 =?us-ascii?Q?pX4ZccQJX5eYlLqE+osQQ9Z5o17AN/Qw8y7ILcKQfIOF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d2238f8-f721-4096-21eb-08dd5090b5fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 02:54:21.2986 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xsIeBJZFOjgVXvxd0VEo/jrylnL2hhnwPRWR/xE5LCEwhtWrVK1F0i3qgeLgfVN5aMJzE4VSaUvXFREzDGcN/ElrGSHKLcLGl8XEo1Xh/14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5774
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
> From: Tom Rini <trini@konsulko.com>
> Sent: Wednesday, 19 February 2025 12:29 am
> To: Frank Li <Frank.li@nxp.com>
> Cc: Maniyam, Dinesh <dinesh.maniyam@intel.com>; u-boot@lists.denx.de;
> Marek <marex@denx.de>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Simon Glass <sjg@chromium.org>; Ilias
> Apalodimas <ilias.apalodimas@linaro.org>; Heinrich Schuchardt
> <xypron.glpk@gmx.de>; Jerome Forissier <jerome.forissier@linaro.org>; Mat=
tijs
> Korpershoek <mkorpershoek@baylibre.com>; Ibai Erkiaga <ibai.erkiaga-
> elorza@amd.com>; Michal Simek <michal.simek@amd.com>; Dmitry Rokosov
> <ddrokosov@salutedevices.com>; Jonas Karlman <jonas@kwiboo.se>; Sebastian
> Reichel <sebastian.reichel@collabora.com>; Wang Jie <dave.wang@rock-
> chips.com>; Meng, Tingting <tingting.meng@intel.com>; Chee, Tien Fong
> <tien.fong.chee@intel.com>; Hea, Kok Kiang <kok.kiang.hea@intel.com>; Ng,
> Boon Khai <boon.khai.ng@intel.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@intel.com>; Zamri, Muhammad Hazim Izzat
> <muhammad.hazim.izzat.zamri@intel.com>; Lim, Jit Loon
> <jit.loon.lim@intel.com>; Tang, Sieu Mun <sieu.mun.tang@intel.com>
> Subject: Re: [PATCH 01/10] dt-bindings: i3c: Add YAML schema for Cadence =
I3C
> controller
>=20
> On Tue, Feb 18, 2025 at 11:24:13AM -0500, Frank Li wrote:
> > On Tue, Feb 18, 2025 at 10:56:56AM +0800, dinesh.maniyam@intel.com wrot=
e:
> > > From: Dinesh Maniyam <dinesh.maniyam@intel.com>
> > >
> > > Add a YAML device tree binding schema for the Cadence I3C
> > > controller,
> >
> > Cadence or snps? compatible string said snps.
> >
> > > defining required and optional properties for proper integration and
> > > validation with dt-schema.
> > >
> > > Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
> > > ---
> > >  .../i3c/cdns,i3c-master.yaml                  |  51 +++++
> > >  doc/device-tree-bindings/i3c/i3c.yaml         | 186 ++++++++++++++++=
++
> > >  2 files changed, 237 insertions(+)
> > >  create mode 100644
> > > doc/device-tree-bindings/i3c/cdns,i3c-master.yaml
> >
> > file name should be one of compatible string.
> >
> > >  create mode 100644 doc/device-tree-bindings/i3c/i3c.yaml
> >
> > Where doc/device-tree-bindings/i3c?
> >
> > in kernel, and already have i3c.yaml
> > Documentation/devicetree/bindings/i3c/
> >
> > stop here, fix file path firsly.
>=20
> We don't need this in U-Boot at all because we already have it:
> dts/upstream/Bindings/i3c/cdns,i3c-master.yaml
>=20
> --
> Tom

Will drop this commit, since the files in this commit are redundant.

Dinesh
