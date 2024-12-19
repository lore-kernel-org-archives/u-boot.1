Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39FAE77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 05:39:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C07B8021D;
	Thu, 19 Dec 2024 06:39:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="FPnezD/i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E72DA80291; Thu, 19 Dec 2024 03:40:52 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDC8E8021A
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 03:40:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=muhammad.hazim.izzat.zamri@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734576050; x=1766112050;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=iqF3NrGWrvRLOQAd0DD7/GRgQHjrrvGsHkFmSmaYDXM=;
 b=FPnezD/iPYxvnC8hiybEq7h6b+e74d3nR/smygEMds7slT91TPqqIiQJ
 FHtV6T+lqH6Uw0BoLKbR2GKS/RmJHwfP+9qB0Aww3OUNsnd4oAL46Ru3+
 ZV7J84HVcyPXGia+G85z8tmfyDWI6kvX5Zng2EfnnvgCJeE4VntHpAxZX
 /N7OJjmbUgtYYVQXOZ7gE/a17zTiyDH5EIPiPOdI6zw5SX33kuKMlQu8O
 Ho1blSFexyYRAqLVJyXUieSpXyuxgZEcJkrV2KQZX893sIXqonbByIwNP
 fOsB3KoClIB+0TuhO2lI2tRyqDtD7Shp4n3QmZvGMM5mxxaInmt/7fqGH A==;
X-CSE-ConnectionGUID: ItHm/QTvQqWtECGUqQUlNw==
X-CSE-MsgGUID: PnUU4ekTQRSsqswrCNSwog==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="34798248"
X-IronPort-AV: E=Sophos;i="6.12,246,1728975600"; d="scan'208";a="34798248"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2024 18:40:48 -0800
X-CSE-ConnectionGUID: sVlGNBfTSYSbj6zRWvHafQ==
X-CSE-MsgGUID: 8Kh/IbumTkihERvxZ7kk6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,246,1728975600"; d="scan'208";a="97879700"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Dec 2024 18:40:48 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 18 Dec 2024 18:40:47 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 18 Dec 2024 18:40:47 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 18 Dec 2024 18:40:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D1jorvhr+HaBXRAQ1iQXSUbjf0+omOJZrl6JbYCEEDBFF1w/HlJMSP1yDkdDaTbQ/r1VrJqN845fPrJmb4aG6B2lNgdlXyZJYcpn0iLfHLEeHC3j9RDw71XmqCF6XwQ5OJv/BC+TfzNHxZIRmYGq9G5xoJzNkmFEmRKAN0VsmVjHUSuQntd9vNeaWM0/H5X7em3Ov+R6PW+oQmLK9Xg3jzLOJXI0ZTNBH+2lpZf8IxL5pcKVUWWK/xFlXr+9UQ0RmbsFTMT82TXh8XDmaNwh8x7AtMQ1i6xScAQbOHdVq53aKTYlMCk+zFt2InekSPpoHfQyeW/19qYt/+OCrQSeTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iqF3NrGWrvRLOQAd0DD7/GRgQHjrrvGsHkFmSmaYDXM=;
 b=AH/cSko+eYqdNAW9T6QAadvkiVyAdFrHOiPFZxdnToIt1ufy/G8Z9hmdiyh846x7TXVIR9U2FrSNmJZIqTgaYB8fZg0Qp6Vx62CinpASIsSBh6SzGjhweeD8C4hE6Ig/fk8a/PnL0bNbu9F2xN1Kzsclo+/gP1Pvkd4qduqxds4VE6t4ug6STD1zTVz0vcmUNORQ1IK+XO4vOVNZIVcUp/zLKCBArW44M8+BAt6gREiGlhhlo1aYvD9qAzruGTBxBm//ht3kQxW7+dWqO5JHtaOmpTN4vYoX+/qLcxjr+iKVJI2tHl79jVvu+ab4GwQmoBqOGXALfuuEF3Jzl5yJxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7562.namprd11.prod.outlook.com (2603:10b6:510:287::22)
 by PH7PR11MB7431.namprd11.prod.outlook.com (2603:10b6:510:273::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Thu, 19 Dec
 2024 02:40:40 +0000
Received: from PH0PR11MB7562.namprd11.prod.outlook.com
 ([fe80::6a7a:1c7f:cbd2:7bd7]) by PH0PR11MB7562.namprd11.prod.outlook.com
 ([fe80::6a7a:1c7f:cbd2:7bd7%6]) with mapi id 15.20.8251.015; Thu, 19 Dec 2024
 02:40:40 +0000
From: "Zamri, Muhammad Hazim Izzat" <muhammad.hazim.izzat.zamri@intel.com>
To: "Chee, Tien Fong" <tien.fong.chee@intel.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>, Tom Rini
 <trini@konsulko.com>, "Meng, Tingting" <tingting.meng@intel.com>, "Hea, Kok
 Kiang" <kok.kiang.hea@intel.com>, "Maniyam, Dinesh"
 <dinesh.maniyam@intel.com>, "Ng, Boon Khai" <boon.khai.ng@intel.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>, "Lim, Jit Loon"
 <jit.loon.lim@intel.com>, "Tang, Sieu Mun" <sieu.mun.tang@intel.com>
Subject: RE: [PATCH v1 1/1] arm: socfpga:agilex5: Fix system manager watchdog
 mode setting
Thread-Topic: [PATCH v1 1/1] arm: socfpga:agilex5: Fix system manager watchdog
 mode setting
Thread-Index: AQHbRsnOTRSGWON/+k+3JY5XJdNRk7Ls40MAgAANZqA=
Date: Thu, 19 Dec 2024 02:40:40 +0000
Message-ID: <PH0PR11MB75624DAF2583270729196C1693062@PH0PR11MB7562.namprd11.prod.outlook.com>
References: <20241205035600.10545-1-muhammad.hazim.izzat.zamri@intel.com>
 <20241205035600.10545-2-muhammad.hazim.izzat.zamri@intel.com>
 <DM8PR11MB5592F6A7AC540DAAA3454E1AD2062@DM8PR11MB5592.namprd11.prod.outlook.com>
In-Reply-To: <DM8PR11MB5592F6A7AC540DAAA3454E1AD2062@DM8PR11MB5592.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7562:EE_|PH7PR11MB7431:EE_
x-ms-office365-filtering-correlation-id: 805c6d37-4c44-4d33-a0ac-08dd1fd686df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?S5gWFWYfvUVYAaR3ukYslo1dmhfy7/q+poe37PfhVQuVYS96t6f3OhyBZ7tN?=
 =?us-ascii?Q?kBfuWQ1SxXgpCIw0H6DBDEZSv7WtYOwjmnMssTKq73o2MetdCKi2HVSAZem9?=
 =?us-ascii?Q?JlB628UswBbfR61gTCCcDl+txpfnGVn0C3VH3a/fnLLpcsAG5gOy2lZ3p1DN?=
 =?us-ascii?Q?HMEclsWPbrAZq5uDZe3tGFOUyhs2JQtXyTU0Mo2kGhQs4/qS6RqbmlA0qaHe?=
 =?us-ascii?Q?jtJm+Z8QsrxCx9rcu6uB9Fd0XBGp8nUjgXR6gfDQoMmOp05YOh3DdnrNS+hn?=
 =?us-ascii?Q?c/WrkptGVrhJzBu2PeRdjAl8uo3PIV0X3xkXeoWMtP6jQcRAPVNq11PuF7hX?=
 =?us-ascii?Q?tjA33XqqiJpoYgPAdKFDS1QOyzaSZ1y+vDZysBdsXI+izSP7WeU5Fpum0aFS?=
 =?us-ascii?Q?Q0qyuH2N/8zSJUwusYqUvqY6XgVRU9tdscFWXxa5p0LtvrUrRy6OIWlDsP79?=
 =?us-ascii?Q?022hK+2haotxfL+C31y3BVhWKZfE10Gy/O+KEY1l1v8Vzr/i6kJ05N3rZQgE?=
 =?us-ascii?Q?Bn67qNTlJi8N1b/Ru9pX3KJohw8c0NTgIrFhcEcZrxS1PgIBObUuJ7y48o2s?=
 =?us-ascii?Q?7PG2cF9aw71tzi6ilscTIlAJtoB/6xVH2lgs9LLbyYrNqViXp0MgF2Ctwsa+?=
 =?us-ascii?Q?7H0ueoPB3diD0N+xlCqy/tVMkSdywAfyhSH+vv1nWgmghT9w0s/Q42zOAvjq?=
 =?us-ascii?Q?YWuIPZC5j3qeqUH3RmPY3ICmVetU57OSVzI6PaQWXsQfWwJypJcCy6bD/T5Q?=
 =?us-ascii?Q?mudLuAZ0YWiYJ+3X2p7+ARCmpeiW3k7RtTXTL0FP8NOdl8MYN4uSKdVuwoUb?=
 =?us-ascii?Q?mP4s6nL2JCZ88q5Jh0/6d5XxgeJaAQlUKsxc2V1xRCb9GGhUeqf8mql1pCui?=
 =?us-ascii?Q?eL1brxtfh1+uVrh+Kj92xzr3/TqdInPqYkRAFSchSHGTPqaI1lXXSvcC25wX?=
 =?us-ascii?Q?uvuO2lAodmmeAaXoopbVuDHWrb/h3Eb637yamUbA0VSay4ZbCGwtZPKUgOjH?=
 =?us-ascii?Q?tDwruTHo1r7cXLhHV/Fyg1CmU6St352zHymvKfJJivv/AC8T65E3v20+gjJm?=
 =?us-ascii?Q?ex6VgtybndTz3syEpilQbl++b729080swMkBYH3NHmCpf98lyd78+0qeJkaF?=
 =?us-ascii?Q?yniK66gRpgJoURIIeVaeLIFlATUrBh7eGbbPBrDa5Tn5oe62FjLW2jGqBXKK?=
 =?us-ascii?Q?1fsfiW61rwHdphK+MLOD/bAuUMGvEV/cq/OaEDkMB0IcOHZpef6AAJYtJD9w?=
 =?us-ascii?Q?ZT0xZpOolaQbXaEvfjkboxClBpSpY8AD15rkhlNijBplOy/wxhDRcbgpJqQm?=
 =?us-ascii?Q?hHbyV+HMqGfFB+z+uzgxy4FV6fziJLqV7UG8OYls2eHKZU9E5uEJ/NQqno3i?=
 =?us-ascii?Q?GNx/kDfu44957isurnfFZxhZ953lIe/toUmnhtg0e9tO9QwEXjpG8/jwjrC6?=
 =?us-ascii?Q?r5bdmFqc9vPuEtCRuF64LH9FHawslZ0F?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7562.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uFkeueNjShMNFjfH+S2RiwhEh4Ok6HyTlS3lHIWHq2sbD0ytNgRfDTgI2OFG?=
 =?us-ascii?Q?RYxhJpaJmUqmF0AT46lUnsIzHTr59nhz6f1CGlwflabVuusobtlcSZs20pBX?=
 =?us-ascii?Q?YrNKVprYtNxsCpcllcQknuubB/7ioFgAcHPsJZ63AKNd4cOIyDEitM7VjG6H?=
 =?us-ascii?Q?I5Y8pvA0JeTlBXrh44csIPoWo9mcAyDUSGgKzeOoLNMMpVc0TIzvd4AxVPxJ?=
 =?us-ascii?Q?r+t9mPx0dQdx21NxgOt5TPwb0Tc6BDxZXk6uI+PUNxjkstjHc5qN8EVWeVsM?=
 =?us-ascii?Q?LyWOOiMAF1u/rnBXYWetEWbrpbTc0cLK0wtgsqkHHEM8OP8071u35QjzQrZc?=
 =?us-ascii?Q?FMfP0tIEc8OYhJ862jqD69DGTWp0yGJIthwBhcBMmo1mfzH/LKiOztHa8eLZ?=
 =?us-ascii?Q?OqBsXKkoT49x5Y1W09YEBWEsjD4gvMiGL8sdNPYTgxQryFgA33QhnD3scbj6?=
 =?us-ascii?Q?rMW0QfGCFe7WCFmhkjdu5g9WgQSgMt7XeoGwOvb3lTBiXAp++xz4yTl/Yn6I?=
 =?us-ascii?Q?6c1xcIGTUUcXGwPr+Y8ioo4r6hCiON8EKpkmXcgxgg29yayczZo62NAidgJ/?=
 =?us-ascii?Q?yCPf5EqkhpXI78J71MLow36PMjao1OKC48Tc98uDcp3Nxxox8OHNezaPuGyf?=
 =?us-ascii?Q?KBiYvIhhvAjImteli8QNfXiAXSCsmZSoC7xEDZrZJTyM86k14DTrDZ3/zmPQ?=
 =?us-ascii?Q?ikO3Gbyj0qJhpxerRzNshCJzJiSVhvUbkQF4Zu6FGkMVctGglugk85wmjV1x?=
 =?us-ascii?Q?5UXMTXFMTJv+r9VLB3DtN1Bv9k43gAuj4DO9f5FND8i9CFokmh97fE00CZ+y?=
 =?us-ascii?Q?InN6llISJIlPe6CubhmNgsj83LByslKwMHvVNrY0WlQ/aPjyX5ctL4RqPD9C?=
 =?us-ascii?Q?fECvwW4Pm2mQL22ujnhL7d7D3y0d2SgD6tOvzS27MGc8e84j+YnuUitQBu8c?=
 =?us-ascii?Q?eaS/oJiQcBzqW7zsCqDMUxUfguf8o/Xnhya06qre9WpKuVY+36WDE7FLKyFy?=
 =?us-ascii?Q?1EuYoxqs55jxEkP8ssfLu1z3D6J4GtEeH0jZfsos1DR2e89926Bfsvu2KwXU?=
 =?us-ascii?Q?RSmUwoZe3ZBBhAgRjBifC71F4QwHE/61LbReNFa605/SjFgIToWI3BsRmlAL?=
 =?us-ascii?Q?TWNHJK/jFyeC71g/Ac1PENblOR45ywNUs/Ctrm0mAmA2UMwu/nnByafFvj9C?=
 =?us-ascii?Q?AfDnF8U+gdnb8v8YvMiQz44Q9sYnm/tpEpqgZM/kG1IVzG8K7ILJffcT2zkw?=
 =?us-ascii?Q?hgq1Q2DP91nvF8M62F0D18q0xGqDunxbAf9Suk83EWBekOn6J6r8rAYtxMQJ?=
 =?us-ascii?Q?KIh3XgZ8MXrCJdEopMQcJuUHwjphgU0yArwe+o/Skc6guq5Ly98EhrfqtVL9?=
 =?us-ascii?Q?shIY9mvitXLjzR77kIyn8IZpZzcLn1QxYSfNUAxy/a/g99lg8ERwiNIBXDGG?=
 =?us-ascii?Q?rgGwSwpOb4Y9kyGSf/ZaaSvEm25ZfjJkHW3De4Up6BpBrSVuwo+rF5mIkNhP?=
 =?us-ascii?Q?qaERqWteaU8okJXFKXMLj3iWOeqZwqlnRwasARy/V47d1GB6zImyIzuI+fyc?=
 =?us-ascii?Q?HF/4zWiaWvc07y08W0G7nGGBeZOjcLnaNsm7qgP0MGw3BakeMmc0C1tcbFS9?=
 =?us-ascii?Q?gpFKl1O1zsNkpsK2Z+Z9Y2g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7562.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 805c6d37-4c44-4d33-a0ac-08dd1fd686df
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2024 02:40:40.2656 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lJnjw8g0Kr7FNzVp60LVNRTMwhjVEbaE0CIucqw7eFjTn1BFAKf0J16syLMTOEPh+/SQKGHvsqQaP3NU7XnuMK4atprTL5mX8XbshZGLBdACdCdkeOKoZJol1++AXJm6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7431
X-OriginatorOrg: intel.com
X-Mailman-Approved-At: Thu, 19 Dec 2024 06:39:52 +0100
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
> From: Chee, Tien Fong <tien.fong.chee@intel.com>
> Sent: Thursday, 19 December, 2024 9:51 AM
> To: Zamri, Muhammad Hazim Izzat
> <muhammad.hazim.izzat.zamri@intel.com>; u-boot@lists.denx.de
> Cc: Marek <marex@denx.de>; Simon <simon.k.r.goldschmidt@gmail.com>;
> Tom Rini <trini@konsulko.com>; Meng, Tingting
> <tingting.meng@intel.com>; Hea, Kok Kiang <kok.kiang.hea@intel.com>;
> Maniyam, Dinesh <dinesh.maniyam@intel.com>; Ng, Boon Khai
> <boon.khai.ng@intel.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@intel.com>; Lim, Jit Loon <jit.loon.lim@intel.com>;
> Tang, Sieu Mun <sieu.mun.tang@intel.com>
> Subject: RE: [PATCH v1 1/1] arm: socfpga:agilex5: Fix system manager
> watchdog mode setting
>=20
> Hi Hazim,
>=20
> > -----Original Message-----
> > From: Zamri, Muhammad Hazim Izzat
> > <muhammad.hazim.izzat.zamri@intel.com>
> > Sent: Thursday, December 5, 2024 11:56 AM
> > To: u-boot@lists.denx.de
> > Cc: Marek <marex@denx.de>; Simon
> <simon.k.r.goldschmidt@gmail.com>;
> > Tom Rini <trini@konsulko.com>; Chee, Tien Fong
> > <tien.fong.chee@intel.com>; Meng, Tingting <tingting.meng@intel.com>;
> > Hea, Kok Kiang <kok.kiang.hea@intel.com>; Maniyam, Dinesh
> > <dinesh.maniyam@intel.com>; Ng, Boon Khai <boon.khai.ng@intel.com>;
> > Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@intel.com>; Zamri,
> > Muhammad Hazim Izzat <muhammad.hazim.izzat.zamri@intel.com>; Lim,
> Jit
> > Loon <jit.loon.lim@intel.com>; Tang, Sieu Mun
> > <sieu.mun.tang@intel.com>
> > Subject: [PATCH v1 1/1] arm: socfpga:agilex5: Fix system manager
> > watchdog mode setting
> >
> > From: Muhammad Hazim Izzat Zamri
> > <muhammad.hazim.izzat.zamri@intel.com>
> >
> > This commit is to fix the system manager watchdog mode setting to
> > support until mode_4 for Agilex5. This changes can refer to system
> > manager register map on wddbg fields.
>=20
> You need to improve the commit message, the commit message should
> contains the description of issue you want to fix such as why no issue in
> Agilex device, and what / why this solution?
>=20
> [...]
>=20
> Regards,
> Tien Fong

Hi Tien Fong,

Okay got it. Will work on improving the commit message.

Thanks,
Hazim
