Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F28FC25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 16:45:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F293A881C1;
	Tue, 21 May 2024 18:45:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="RqgbqWe6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABC8D8825A; Tue, 21 May 2024 18:45:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A277C87FA7
 for <U-Boot@lists.denx.de>; Tue, 21 May 2024 18:45:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kalen.brunham@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716309903; x=1747845903;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=qZvQh3i+/i12QcDJqhYmgyJ63GzjdNGXoLF2VMwGrvM=;
 b=RqgbqWe61C2u8CbUFSYfw0RvsACJ53KvUAJ35hRPRpbc7vf0WuGHlyqS
 dSFrV3OhIC7aGowrgdqO+qVDVAmOC2fXbv9BL5OakhzPzVDBihvS5rvhb
 1L2vip9h4pM4nJCjRAub1mNEAIpRhGIs2LqfFDqyRY8J9f40MSQ94ndNC
 uJVaGtO5enOV9jEVN5CXUxTGbxXKtX5m6ZoZ1JK9BJGnEcmE0QQEWu/g3
 R1jFr8M8XTHf3an3oIhw39ZSr86ps34N5yMSnW1xGrdT+sFt+fEEAbJtZ
 /XnHqHxGpzgTxjIsOxdoCmTR6dJLEb+2QVHpwpxD/2fxOyjPSm5TxpVQT g==;
X-CSE-ConnectionGUID: 8nuDsGtjRaK+4LxzvyeCwQ==
X-CSE-MsgGUID: fucHiCf0R2W9xjn8I1yjCg==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12369493"
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; d="scan'208";a="12369493"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 09:45:01 -0700
X-CSE-ConnectionGUID: erUzrFbYRC2/tnm+4Hr6uw==
X-CSE-MsgGUID: HcyScw3aQdu0n+Bl5P6hhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; d="scan'208";a="33594330"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 May 2024 09:45:01 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 21 May 2024 09:45:00 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 21 May 2024 09:45:00 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 21 May 2024 09:45:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QW8p/8sHAfOzEujxUcQoKSy+VSEL5PZ/CyxwoeSjhOPOU8OgdxM1XZGyoyR+8TUeCD5bxhtFOx41wWWmxE3q/oDSFpjBi6QF9It8OhsSL5HWrGeVLBdTbl6lVNAOyZRvRnAnEbTsxJcejZvF9cA2MP2wgVcgh4IGR/KKT4NLFyTcVnqbGP6lLORjVEHF73kGimxyYmgKRHo1C5tHX+L9KMGFclXeuS/skufm6VVFvPTD5rc+WJFgfny7FVM24OTr+EabYwEZpYZXtM9uLNpnPbemipJ0dNE+JayApTpaaVLGSJa6rXWBwlasxUzhCWcDbSlK4tshJq2San8APqLk4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEGhckjFHGQ6CLjUTFI6bCwrgOzxh9jBU2NUpzbOXUo=;
 b=KUg+BhiBulKFaoxo8SYA3tfxNnR4VtkgUQzvhL5qzp1miZ6LgYnbmwYrA/2CZeyd7LKS6nbQaxp2yDQaPncGCHOfeFdZnFNmkFF6YhQ/tuPs0h9J5yCVl2GNxIeEC9QbOKOZa/p5gCQgMAE6zSsxA4b6nHxFKuAncTHJ6pe1Gb6sj4B7yAy/JMn3KVsBgfO8dB+TaaBi9y3KRkpKt/DFtGqSTrMhdJLhak8OFLj0ZaU/+u/cDqmD0vIzUROFUYmra3tZjzrqkFM1aE/g9W2iR+8yYxwVpzZv7vC7erWOPl3xWjzHorJ3inN6Z/dwZ+jW+Xlt+HnOtZqR0zIs2y6wBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5296.namprd11.prod.outlook.com (2603:10b6:5:393::22)
 by SJ0PR11MB8295.namprd11.prod.outlook.com (2603:10b6:a03:479::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Tue, 21 May
 2024 16:44:54 +0000
Received: from DM4PR11MB5296.namprd11.prod.outlook.com
 ([fe80::4976:d526:d3f2:d785]) by DM4PR11MB5296.namprd11.prod.outlook.com
 ([fe80::4976:d526:d3f2:d785%4]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 16:44:54 +0000
From: "Brunham, Kalen" <kalen.brunham@intel.com>
To: Tom Rini <trini@konsulko.com>
CC: "U-Boot@lists.denx.de" <U-Boot@lists.denx.de>
Subject: RE: [PATCH 1/1] Added arm64 assembly for examples/api crt0
Thread-Topic: [PATCH 1/1] Added arm64 assembly for examples/api crt0
Thread-Index: Adqojlev93VX2sPCRR6waFJsm7XUJgC82DVQAAZzj4AAAJoS0A==
Date: Tue, 21 May 2024 16:44:54 +0000
Message-ID: <DM4PR11MB529670F5CFDA6B4EDA7B7206E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
References: <DM4PR11MB5296B1B9F0CFC701A8B11284E3EE2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <DM4PR11MB52961423BCE12552857A12A8E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521162543.GU2568172@bill-the-cat>
In-Reply-To: <20240521162543.GU2568172@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5296:EE_|SJ0PR11MB8295:EE_
x-ms-office365-filtering-correlation-id: 6af839ea-11dc-483b-6669-08dc79b55784
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?PfXLDWM9sX5fOKeV+Y8oYuyfFcFnXNSdHm8X6v2G7h0sm6MDa2rgRDwwvPsu?=
 =?us-ascii?Q?v3WxmV+ZgY6pq09GJCMIIc8IdMJpDpmsHler9v4O6vaocggPR0tvPqJJBgJZ?=
 =?us-ascii?Q?D1q5fXfQVtD0oYkrHafYhNp07IDE1B8cX13aBNVIjH77mRYIyTYoR5bVc7gj?=
 =?us-ascii?Q?KnAFfkiuKY2p2YHnbegxZgfez3X0qvacoKyZ3sfjp+QTK5RyCQvMtTaxRhvF?=
 =?us-ascii?Q?yYIo4hCqF7HDosCGck1aJTntZnHL3XfU3jg+X1tGCVlY2wEia9yzmkNnUTKY?=
 =?us-ascii?Q?aTW1mUfJv5zSVU3SEWKWbx5GVhzk+/m6xMAYsg4UD/w67gTO0Za83106bsCO?=
 =?us-ascii?Q?h09ta3rAdFGNY9JMgDml+QfClNKYegQKAebCewT+Kkmu9SgYEtTsqr3MN+EP?=
 =?us-ascii?Q?Whr4fHjtIkbkvNdcQXedexMX9d80cv7pNFfTC5iiguwZg3eBDyky37uuSW5b?=
 =?us-ascii?Q?twh6ojKk6Bq1PAMTYCSvM2dHi8e4TbePYFAgl+z3P003OGRxFEOgPmg49cko?=
 =?us-ascii?Q?VuhBxvNxnZaeEvt3ho6pew4skkioV5hqstMQ7mHuKnbllBBL3A9XwO5GGJmj?=
 =?us-ascii?Q?RGQfFUjD8VphAtQNLvEWrkZlb8XQoTeCCVpfFzYULNzJENFLL/JTnopmsI96?=
 =?us-ascii?Q?TNFCs/RGHdGvlBkG4+1hXzDs2r5TYx+wCMI8qBH+HtCf98kEOfGxjqAgjL6M?=
 =?us-ascii?Q?UcLxOiwONm7fD6wzluzmumUdg493cyBOouOGoyemHhzlpRbprY0nvil0crio?=
 =?us-ascii?Q?xDL8JJOkhFmqqWj5HKLRdQBjoILIj84cefHhg/iInHdIiIY0inh8Wk1m6ytE?=
 =?us-ascii?Q?C9K5eFPQ2gU5GyXmN0cUhCESe1XP5sbelfnpuv1j35NrvMxuFse2ZxP4WCdd?=
 =?us-ascii?Q?AycAXlXzqx2rsLR7LkwpLy7LF709anXy9dwG63l5RgU7UvIrwmJpttGNIhXS?=
 =?us-ascii?Q?qBivFdZqXjyjN3CStzuXIB1/XO/7YWz+nWALEmvfQnWjUTu6YzujoX+Y+BBY?=
 =?us-ascii?Q?nDU1gyGrjm2D1e8Q3jnxLVnAmY166PC+tAQhs4252wKouUb5QFRsixus0Rhr?=
 =?us-ascii?Q?caCWDb9x7LG4yo4+OXwcSGQyOUD3JgL1ZPXD36bR3oxjbA5PnjLHDVZko1Bt?=
 =?us-ascii?Q?eoxZpased9XC1qdIjNP/GV9SaJthlMDdD+FKnN1HqxZchfpcqgpOjyxMfXEN?=
 =?us-ascii?Q?LJr+v4gz8K/8KSc756oNpaDT0RkHAUxCg9veNQjcQ4Tws6bWdUv/CQB0gxXj?=
 =?us-ascii?Q?Bt+/SivaTHaaZajhhBWnnccaEmMct4YRBN79sr79dQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB5296.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sXR3Xsgudq/fQKAEjPX1vaWlAahWEzii3OdzhdSya75M8nK3XEi2pALtp8oo?=
 =?us-ascii?Q?/rfFZbkUY40i71AuYhYdwoUpgvOoGPYqt67YaX0LioEOj99qJM4fGLwYco8F?=
 =?us-ascii?Q?nss/1FADpmV81xd38FC6i8EfqpDxq7cFFo8eEnrsSlc45qpxebLD4pEU4D3p?=
 =?us-ascii?Q?yJ9oiWscRmgPhaq7kJFDhIRceDidLHhsBoNU8UHdCuSW43kPedQUukLJJycO?=
 =?us-ascii?Q?MZfYjKUKZqO9awVA2frFdmpcFRFQH0r5yRH4xv9RXMcjERLP65jqGrg9na7C?=
 =?us-ascii?Q?PLYxTxXQO+7PxjvsQx5Y+ZRldzA0yxARwp1uBtkwHGDforACmFId3lo2shF0?=
 =?us-ascii?Q?MfTNHqKbfCMy63AJBRPAgz5d6wx4NWZWzFzo2e/+AcyXS165tYvk7cEx1Mgj?=
 =?us-ascii?Q?pcnR0EQyifECxq1XwI1jucvDzXMYsvoOxEHeCIeOT84vn9UJ7jC41aeE3TND?=
 =?us-ascii?Q?0QJBHwRMg++oRg3af053HigCfOgkpmOwGNhGn3L4WJk+O/Y4hjE8B3PRJHnV?=
 =?us-ascii?Q?occalvIARb0uSBW5aDosgmq6SdvdEPoVB3gsNMTquXV5YULLTGIp7uzD7oC2?=
 =?us-ascii?Q?rgij4A37JJKlYS0AqwEs6AqpRnIJ+npUWQ0kp0Cv9gdj7M/ehlxMfQeVQA/u?=
 =?us-ascii?Q?1QCyj7GrdBr55kmYMJXWylfMo0aNZqJGMyoT0hD1JdUydDHZo7vS99DpSCov?=
 =?us-ascii?Q?MbW4y0TmRy4WuQlbmbEpTdKFk4zdtvphmCgAAlyr+kB7zk1BBteLZoKT5Eli?=
 =?us-ascii?Q?RCM/1/7bpx2QRPTGRJvjGIqdxUYU9lXnBslKp8fnCf2zGm5wSUCJROeNHt6r?=
 =?us-ascii?Q?MSoqHoTxhmnFrcE6IWAS1TkBBb+TVYdQJZrxOnXjfEBpx9hzP1XzBec8bNuL?=
 =?us-ascii?Q?40ILJw/RcCA0FIoLpyLubI2ZO1A42+pxucrDnR3J8YkYbBv+RWd3fyGDgCYE?=
 =?us-ascii?Q?/dqDPnzrPpKh1/7O7BcC50l4fRoaolexXztzOhxs3PrfDg/FiQbqaGnUciiX?=
 =?us-ascii?Q?PAizHwLJNPDXwz06g2PZxzc/AzkjH92mCzowpIENMYErTjKcvKoP+mwy4zFz?=
 =?us-ascii?Q?NE//BIGirce5Ps9Bb89FIRHoJaYN0LIVi4OhzoiG2r3T7keAymE7BxKMIcKc?=
 =?us-ascii?Q?FOqQhSoE4gju9owlhLd1fmJQdeCHeSmn03anSg51fsFCXVi//4Z5b0AvhfJp?=
 =?us-ascii?Q?io7Gt9RBpmlk7if+793m1fkVOLghfRaE48vFrs9XIZnLT7sQ/M8t6lYX6LoD?=
 =?us-ascii?Q?vVnjmm7m86koH2n2LURvJkvaz1Kouxu9jyDC/3oN9mJ40i/K0ngaeyUWZKC7?=
 =?us-ascii?Q?G75Lw52Y068EpD/WNwYOF9w/tnMPa9KyFYpaTCauPtUlqoUNUnP7tDYu7HDg?=
 =?us-ascii?Q?7Q71iJfwEeaC2egeyUReIHe1mAwqO5TWRp1/H3si85MPLSN531ScJy06xVpm?=
 =?us-ascii?Q?c9/iU2YzNo+Kn0f4wbXLBKoV9fZew1ylYWdq+VfMKc9ZujKVvKFSxyHrRWYx?=
 =?us-ascii?Q?vXUeVKcllHDjRdq03TACPuWnJJstrlkbKfh3lt7TDFlrULsVSJ3JmKui2USC?=
 =?us-ascii?Q?cdAj6sYXTgU6/MuTZnV/LMIE6lMY12i6I1pJaw26?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5296.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af839ea-11dc-483b-6669-08dc79b55784
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 16:44:54.3862 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E1KENegz1DHFfDxmT0/3FYNmlLqLNhY8gzXXNx1RUgRREzB2MLtp/ouFHtY4Fn3iOcLkpbY0Ea4kB8AH3fx2Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8295
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

I don't specifically need API, but today this is needed to enable creation =
of standalone applications which does work on our ARM64.

If the concern is fixing this startup code, then I can come back with a cha=
nge to the KConfig and Makefiles to enable compiling the hello_world standa=
lone example for ARM64.=20

Thanks.

-----Original Message-----
From: Tom Rini <trini@konsulko.com>=20
Sent: Tuesday, May 21, 2024 12:26 PM
To: Brunham, Kalen <kalen.brunham@intel.com>
Cc: U-Boot@lists.denx.de
Subject: Re: [PATCH 1/1] Added arm64 assembly for examples/api crt0

On Tue, May 21, 2024 at 01:21:01PM +0000, Brunham, Kalen wrote:

> Adding Tom Rini.=20
>=20
> Any update from others?
>=20
> -----Original Message-----
> From: Brunham, Kalen <kalen.brunham@intel.com>
> Sent: Friday, May 17, 2024 3:14 PM
> To: U-Boot@lists.denx.de
> Subject: [PATCH 1/1] Added arm64 assembly for examples/api crt0
>=20
> I've encountered a problem when compiling the 'examples/api' directory fo=
r ARM64 in U-boot. The problem lies in the assembly code in 'examples/api/c=
rt0.S' where the current CONFIG_ARM code is only 32-bit. When targeting ARM=
64, a 64-bit version is necessary.
>=20
> I have proposed a fix by including a 'CONFIG_ARM64' section in the assemb=
ly code as shown below.  These changes have been check via https://github.c=
om/u-boot/u-boot/pull/538.
>=20
> Feedback is welcome.

I would start by asking why you're using the API on ARM64, I don't know tha=
t it even works there otherwise.

--
Tom
