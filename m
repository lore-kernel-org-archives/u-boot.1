Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B0BC02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 05:24:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2C40801FB;
	Wed, 22 Jan 2025 06:24:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="U8WaYtOc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFCB980283; Wed, 22 Jan 2025 06:24:20 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07D48801F5
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 06:24:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737523458; x=1769059458;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=lwl44aLo3QuzoPsXRm6LxB9Jigzz2pd8MGpPMVFoyz4=;
 b=U8WaYtOcb3YPSE3DeJGYTSsjBZIcCygXNksO3Ow9MsPTrp2yTtW/DTGq
 wiQ9eRI8GZPeYwhqwdzT+Dms8FJbEPvvwg76D3hH7u77Agu1iLVI4QOcC
 OfXSPaVUyxyonBV0roouzpKshktZ7bngHKuQLhB61A3e4HKLeR0eN+Y7j
 5N7soYsvrVRay8CaYszin2GiCxWCId+MzXT2oP/BssgXi4kQcVXhjMxmp
 9qjEuuAlTMPADU9JjnVLcQcrjdjZZiNrGaZdSVTE4Zd8luc+oDtDikNA5
 VEH+kzzaoZQBM6upd7SvffuUjRaaDCZugU3PJsK8HflBtyxJldZlnRcPA Q==;
X-CSE-ConnectionGUID: Z7YnPwVeQqy49zB3NxtzrQ==
X-CSE-MsgGUID: kmvbxa2KSMuvROXIqanGmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="38216175"
X-IronPort-AV: E=Sophos;i="6.13,224,1732608000"; d="scan'208";a="38216175"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2025 21:24:16 -0800
X-CSE-ConnectionGUID: LCbAjPbISmGKpoUaQoC+5w==
X-CSE-MsgGUID: Qn1686IpQGSo7TG/Cj/kEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,224,1732608000"; d="scan'208";a="106936981"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 Jan 2025 21:24:16 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 21 Jan 2025 21:24:15 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 21 Jan 2025 21:24:15 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 21 Jan 2025 21:24:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L3oMbQQj0zu8bws5zwc3RaNr6nVfTbt+FNnsMPJ+P2i8gobcPqRgujssHwjHsuzMUGy4vLpIaUxILpNXr0pnPXZ478YA76Jv0b7BD0eJK5SYqhu4x33BeAHF3UM+qrmKd1ciQ5TbBv1WP/7wH6xvoI+LxujyN3vEYhirzRTNAdDY/kAqjt9hgxR8yI3SSxIRhqEN7ofv4cz7E3CpfIF475Hr3/dvtZSdVK5sFnJVHZcp0GarsbFlXHvdGYZ7P+UQS55Q+g6qzHZ+cKrTKYjefHZvZexSOk4tikqL1ubXkYUHeyV18YSA4BfIGyBUHOKlKzEAOnZBReaJnejlWd+atA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e13Jc7KpMxQTyocCSCx/3TTSFoTbVRnFd7t6o9Foueg=;
 b=g+ZkY1gmAjqEdZdj2RjMZBzycGMgxmXn/KA6Dyo6sDu8ba+vPRS8MWnwgihE+JKjtwB+OnsWd4h3NcPri5g525eQ8hQpct0fBM5wVFNSfqFes3nVL01HQf96R45q2KF/mGHtNKebf1OvcNTjcMHMJIutdPKKH9Hs4nSz4m6EKM1q/6Ft0jLHo1xw3P4inzp+XU22r4gf7lfi+jz6kuAqiytBRyHvEEnyDjGSTJYisb8dEfKKpXNSC/4qtCNFs8Aj1MHhh3gB4Da+C9T4DTEeyO8pFfad9neZeSLFgrDG8k1bEawc15Zm9QdKoMYd+gFJOdNNJWDPazQ0Q9eSiWNp1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 MN2PR11MB4694.namprd11.prod.outlook.com (2603:10b6:208:266::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.22; Wed, 22 Jan 2025 05:24:13 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe%4]) with mapi id 15.20.8356.014; Wed, 22 Jan 2025
 05:24:13 +0000
From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
To: "Ng, Boon Khai" <boon.khai.ng@intel.com>, Uboot Open List
 <u-boot@lists.denx.de>
CC: "Hea, Kok Kiang" <kok.kiang.hea@intel.com>, "Maniyam, Dinesh"
 <dinesh.maniyam@intel.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@intel.com>, "Zamri, Muhammad Hazim Izzat"
 <muhammad.hazim.izzat.zamri@intel.com>, Tien Fong Chee
 <tien.fong.chee@altera.com>, Kok Kiang Hea <kok.kiang.hea@altera.com>, Dinesh
 Maniyam <dinesh.maniyam@altera.com>, Alif Zakuan
 <alif.zakuan.yuslaimi@altera.com>, Boon Khai Ng <boon.khai.ng@altera.com>,
 Muhammad Hazim <muhammad.hazim.izzat.zamri@altera.com>, "Lim, Jit Loon"
 <jit.loon.lim@intel.com>, Jit Loon Lim <jit.loon.lim@altera.com>, Marek Vasut
 <marex@denx.de>, Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, "Tom
 Rini" <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Michal Simek
 <michal.simek@amd.com>
Subject: RE: [mailbox error message v1 1/1] fpga: intel_sdm_mb: add support
 for query SDM config error and status
Thread-Topic: [mailbox error message v1 1/1] fpga: intel_sdm_mb: add support
 for query SDM config error and status
Thread-Index: AQHbaKnL2h/wo/SKFUK/ODRWwiX01bMiShpg
Date: Wed, 22 Jan 2025 05:24:13 +0000
Message-ID: <DM8PR11MB559223A67D602D809E3AAF4ED2E12@DM8PR11MB5592.namprd11.prod.outlook.com>
References: <20250117063331.13890-1-boon.khai.ng@intel.com>
 <20250117063331.13890-2-boon.khai.ng@intel.com>
In-Reply-To: <20250117063331.13890-2-boon.khai.ng@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|MN2PR11MB4694:EE_
x-ms-office365-filtering-correlation-id: 014889cf-148a-49ac-f99b-08dd3aa50202
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7416014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?zroT+XCngjSoBVSbmPg7IfgdV4nFF6OVB8f2dJIBz6ghvQUk4VFqSEik0VXO?=
 =?us-ascii?Q?vrVBp2f3F3nFprb8esiOcLxXPtx4BltWj0lbWXI8xNd9jbeli9DvKQ+bimmF?=
 =?us-ascii?Q?/Dr03re3Ixo26gnyW/L/hmscQSyo0qVJ7aywYdrq88vnmHKK3oWNavfpRjwR?=
 =?us-ascii?Q?CgbZq4UQZabIMUtj4QXgsGaA8V99vXM5bs9QbSKmEzWJHbyL6fksFaJlahq/?=
 =?us-ascii?Q?3Qxp71zjbZjqjl8LX7f7eMsNqPscr14VBsz2KvV0Dp+T3vAEC+cl3dkuH7ny?=
 =?us-ascii?Q?Rdz1+mTT1kD8mjKUv47l+/0nyYf7gd5K0OSzh+OwT9vDERE40Gw4r6HH2Y2e?=
 =?us-ascii?Q?2iwTfvil2pzb/pl63h0rGtVnWelCHXD/OnpMchbEUViLzqARw8notn6PCMEA?=
 =?us-ascii?Q?YcMUJKa9N19XdsWx1YkVwiww+eO7NE4a/RFHVoqhsRbb2sh8Uy/OLD1WtHNV?=
 =?us-ascii?Q?YfPjRbEu2Jos5US6jfjxVXjX4wEyZY1Gc7IEBU/iG/vHRAXsW8wn1AvOhAWS?=
 =?us-ascii?Q?YuJGpLiZmvraxw/6n0NDyrzEjjSUy29fCeKxImza5DeOvQODp4LYhqLaEare?=
 =?us-ascii?Q?1x0AviRsVaQXb1PkOa6kpz6PbP0W9Ia1zTQ4pTN8rqIZGzpVXUgqBnRikq+9?=
 =?us-ascii?Q?6uQ6iRyvOdHuHzzBkpVX6ZM1vJP1DE5VGup3RmBMvheO5EI5EU8PqfU7LP9Q?=
 =?us-ascii?Q?ANrSG6SGQiaWwEQRtF3fycgepWKf2mXAN8hWTDQQIUBJEwMe0zcOjdA10NV7?=
 =?us-ascii?Q?qSEEK65/RsF27txs/V0GLPoOGHbdQ5Yj01SKsr9PgDUavDZw0YchFbkMlERF?=
 =?us-ascii?Q?k0RJj6tewNyUD+YbqSuWW3kP6VoEGR4Kb1LKg3V+jLJf9Gu2Io32JJ3rxjrr?=
 =?us-ascii?Q?NHuUtTG/q1eFFXyy1QxZnwrFKA46IlYpybhma4BgnK2xPp0YgermmuSRYQC7?=
 =?us-ascii?Q?ouOGcjzJA0W3D0NMx+n4DrK7R9M7iSoU+v4s5UM+nbwF+IOhpfBAms/aZgtv?=
 =?us-ascii?Q?pMkzP0640gQ7Ar2VKoOEw2u8KtTSkLmWgI1Tv+5AFiXsPLGD3SpUxRr8NG6D?=
 =?us-ascii?Q?l9PNUKoMhjDz/HBOU6DuClR90gtDpTJVOzmjp9/qz4gq/bAsry7rySMVEJtW?=
 =?us-ascii?Q?6DxrxBqXOgXqgFukh6ct02QgsyRK6eZpyXww9OB3KdubEJ8qfk/+xMukOF3B?=
 =?us-ascii?Q?s5yl3Oky3M+GdV4roDrf2dfYQkhrQy+ZrhaQk/ik3I7GGx5xGDJgRei3qija?=
 =?us-ascii?Q?TL+BCBMV3acw4kTz7qpNvien7/rbqeEG6/jpctFqH0xy0YHRBZ/HEzhjeyuH?=
 =?us-ascii?Q?9h7QHHzLvZAFy5R4GfmpHDUE7pl52z8+YeMZ84piyyx+MK1SE97NNC+xs851?=
 =?us-ascii?Q?7i9YU3JNjNYTWAEKUgQzhmS05TLDLw1sFHZha62PQQEEypruzjxtlIZS/2sD?=
 =?us-ascii?Q?/TVTEFXzdlMZ/vmCArQXmDcNuC0atrWW?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5592.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RfwhpwHIJ5GbYKfCMDGXcUqXjXUvqMJlSkR6bqtsKJUXfmYfKTGUJsq0ATTI?=
 =?us-ascii?Q?dh73QIxdRDLYJxfIjg1raFXOKWoBGm6ld46NCR0ElxkgVkA+sEnhDwzZZpG8?=
 =?us-ascii?Q?eTLR6B0OlMwykvLdpUos0qb0hgrtmHJANqUxKUqIeHd6jAQe/QEYfU62Pbel?=
 =?us-ascii?Q?1YhoYRbWMxDYGxlr0hDO9zk5v2uxYeBJl1M39KZE7KDw4L1JYfJTOnFQTgVh?=
 =?us-ascii?Q?yLT6OAaZqqnM5yOak/dgQYmU2MPOm6r87uciuZlXE1w3Qv1M/fHrktoJxC5p?=
 =?us-ascii?Q?kz/G73zsqp5vR4G0XsAF7Hoi3prqDix1+P/eYIhnxC2bo8dpZvDk6ew1Oppl?=
 =?us-ascii?Q?RG7XKPsNqh6EPy3z7ZLb8ASVE/pFAIqrU5KmEX5TTOl1cKLCT2hhG+yuHsN5?=
 =?us-ascii?Q?xZaQB4/MLLh3+SceYR6S1BDscJHv3W63wM5VK4gf53SNTcDpdPC26oF17LPa?=
 =?us-ascii?Q?MNABW6mWTPBgDukMOs/Cdue/7DMQmVC4BzZGo4/A8e//ckig+wkeEdbQTZRb?=
 =?us-ascii?Q?b1ri1P6pr8hTDsRZOPzxey9l+ufBANcRyhtS3paVXyB5NlbgFF5l8xP6M02O?=
 =?us-ascii?Q?qsJQKTLpTKm0bPrBachYA/hQBva/DiwXNr8p8Tgh++nvvsDIG70N+99vQnX9?=
 =?us-ascii?Q?gKBirYKLzBYt+r3be+Z7ienCMdbz7Vr7NjRY50R9MBkb7YIlWoAgOmQGPuO3?=
 =?us-ascii?Q?7/FXJXAZUKou4hW4+IWZGuMLUW7n24QtmucgaoSqSHx7pdQPB0ORabr40jId?=
 =?us-ascii?Q?B4VAwuiRwt2ij1ysHth1AyOSZQwnpWRv5Zwy84nZuNOzPCGnukCjrmTVUagA?=
 =?us-ascii?Q?xMB1v9RjfVq29wXIeIzHKr7xw13NQvemITgVYqlFS0vB0WTtccHXlxVnBpnb?=
 =?us-ascii?Q?+goCuVsUIOGbgXtOejKkkrgi69tDaKfBAT//qr4T+RzNxW2N87Vy4ZArhxDV?=
 =?us-ascii?Q?b7vu+w+aTorTnwlhta+q5/ntkrGYZ0PLUDZiMFcRLK4Uh6VW48AcVSg5kurX?=
 =?us-ascii?Q?I9bDZlmIdc+E/j2jDe2TZMr//xWjbxKb18SeRb6/h1qxfy8qKmf3t6FvOeD6?=
 =?us-ascii?Q?A6xzz2YXs8DgULnyc3PBXc0KdN3+St9Cga4pPfvNS62e5gYe0TnE/dqb4OL7?=
 =?us-ascii?Q?ZoAgmUMhSxZYwXwtupNBNOUwi6D+iAKF8WYo+6Gc5Nmanu07GP2PHRkGkGOY?=
 =?us-ascii?Q?UxSl4QSGybFxArWG8eeS9rE/BWAguJ9ImLDvCVny0G2XmmjExugkYjXt7eLM?=
 =?us-ascii?Q?LUhmsAcDSLUEtAaND+nrWqf1QhtyQ1FrT3sdurj+PV7fD8s8CmMdo03oNvk1?=
 =?us-ascii?Q?kwN44EdFrY459oviUn8pCu7SnC/inBVwIWBRKKHjOY1QfpV21CBTRdFx6fu+?=
 =?us-ascii?Q?UQv/QqC/dXfg+pRuEqqMYPKWAkw8ELioVMv7oBcCB/jALQG8k3qvEnZwXN7w?=
 =?us-ascii?Q?bIB423k5QhY0uaYrQr0N+G0cUw1A91BzgWnB5rSn8MMVJyBqZtz1KQCDLvcT?=
 =?us-ascii?Q?0Q3dbtc3sRLN+/2O/PH6hi6XZTSTqH1ybU8lox0GdUORsd+u8/g9tDr87eK5?=
 =?us-ascii?Q?7ZHVxdkri6tfNDQaxeqIcmvfbpsoR/KjxFAW7bRK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 014889cf-148a-49ac-f99b-08dd3aa50202
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2025 05:24:13.4133 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 71KEn9V8b/sNcvpYfMCgjx8EU7Yvuja1y29cYsfBtLw31RUJkKfeSwqi84NZF/7o3YxS9CKdunutwVHowSs9cOFSgolH9IYfaP5HyR/FoKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4694
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
> From: Ng, Boon Khai <boon.khai.ng@intel.com>
> Sent: Friday, January 17, 2025 2:34 PM
> To: Uboot Open List <u-boot@lists.denx.de>
> Cc: Chee, Tien Fong <tien.fong.chee@intel.com>; Hea, Kok Kiang
> <kok.kiang.hea@intel.com>; Maniyam, Dinesh
> <dinesh.maniyam@intel.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@intel.com>; Zamri, Muhammad Hazim Izzat
> <muhammad.hazim.izzat.zamri@intel.com>; Tien Fong Chee
> <tien.fong.chee@altera.com>; Kok Kiang Hea <kok.kiang.hea@altera.com>;
> Dinesh Maniyam <dinesh.maniyam@altera.com>; Alif Zakuan
> <alif.zakuan.yuslaimi@altera.com>; Boon Khai Ng
> <boon.khai.ng@altera.com>; Muhammad Hazim
> <muhammad.hazim.izzat.zamri@altera.com>; Lim, Jit Loon
> <jit.loon.lim@intel.com>; Jit Loon Lim <jit.loon.lim@altera.com>; Marek
> Vasut <marex@denx.de>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Tom Rini <trini@konsulko.com>;
> Simon Glass <sjg@chromium.org>; Michal Simek <michal.simek@amd.com>;
> Ng, Boon Khai <boon.khai.ng@intel.com>
> Subject: [mailbox error message v1 1/1] fpga: intel_sdm_mb: add support f=
or
> query SDM config error and status
>=20
> Currently the FPGA reconfig status only return a single error status whic=
h
> make the debugging of FPGA reconfiguration hard.
>=20
> This patch is to expose the error status, major error code and minor erro=
r
> code, for the FPGA reconfig to upper layer app.
>=20
> Signed-off-by: Boon Khai Ng <boon.khai.ng@intel.com>
> ---
>  .../mach-socfpga/include/mach/mailbox_s10.h   | 218 ++++++
>  drivers/fpga/intel_sdm_mb.c                   | 641 +++++++++++++++++-
>  2 files changed, 852 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/arm/mach-socfpga/include/mach/mailbox_s10.h
> b/arch/arm/mach-socfpga/include/mach/mailbox_s10.h
> index 2cc7c89044..45cc9912f9 100644
> --- a/arch/arm/mach-socfpga/include/mach/mailbox_s10.h
> +++ b/arch/arm/mach-socfpga/include/mach/mailbox_s10.h

[...]

Reviewed-by: Tien Fong Chee <tien.fong.chee@intel.com>

Best regards,
Tien Fong
