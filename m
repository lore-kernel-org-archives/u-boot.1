Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C16C0218B
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 02:51:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C212A801FB;
	Wed, 22 Jan 2025 03:51:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ERuuC4gL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3542B80283; Wed, 22 Jan 2025 03:51:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E5E9801F5
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 03:51:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737514266; x=1769050266;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Th2kNanS/gzjjKH/U2ohEECybwhmFP0fWc/I3a0cLcc=;
 b=ERuuC4gLs6YHTpxf58KyaBtU0t40ZEssdTBVNGQQDsOH3MiW9afwzgfq
 fKN7a7dvIGH6h8YSJRtJ11lyZb9YfyXMA4ngNUh2XfiEEoPmoxw7oxNTh
 sZ8UMyPSYILBbRNOB65TEYSZKAvkHQWoHwU8KnkOJOrJUomPlgZOt1VYm
 bvYJLJHyOGVp+4ADVNB9hTsDckrcv9KDPaVg9QyZ/hXIHeIW8TFKx7InW
 aqAdlehKpUJ7pomQi4/BY29jXWNnq0H0cnbEMZtv8gwmmf+IsE6teVl35
 +GK46wjUbgDyprglyoa+yXPuAixzD6rZRcb2VEXpA7KcPm7/+YofVYYwU Q==;
X-CSE-ConnectionGUID: 5uqLgV7RSAm3cvHoAsPZQw==
X-CSE-MsgGUID: EQrfsUFoRGSx1+9P7SM73A==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="25560459"
X-IronPort-AV: E=Sophos;i="6.13,223,1732608000"; d="scan'208";a="25560459"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2025 18:51:03 -0800
X-CSE-ConnectionGUID: Lq1tK1JxT4aihWYkDTXrjw==
X-CSE-MsgGUID: KY8/KTA/SlyHgTJ4jl03jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,223,1732608000"; d="scan'208";a="112000051"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 Jan 2025 18:51:01 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 21 Jan 2025 18:50:52 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 21 Jan 2025 18:50:52 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 21 Jan 2025 18:50:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sC30GFNmZ+mxcyMO9RdLwu+5vLAk293eKgnqZxpwzjCzdi8wDLhRc+o4M71hpm5hOm15JRdSsDk4QkkA9KZx6Gl2iSHE9vV9QEF0iJRwTcwQvgys3woUbYQ3Xdc4fHmVum7dWt/NUUDln/rLTs4cUb/euKdUs2p1k6nieloSDohDcqTExrHzX/mpq3Aye07TNb5eh5CQmWE3PbqG0CX6Jiv7etC78C7mSa29jUrUgpkAMiBuQ8X2gCk1ePAD6CzNXSsalk5AzbsRIk5aCeV6SoBr0tzZZfrUyIACPI0RiSkBuisVNlIPfGP8+1UClIOTx+2hTij73eM7rLyPf7kk8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiYT7gtxGCo4Gi6np11AEqycbT+iiDmSp5FK2IKoL2k=;
 b=XrZboln7wEINwdgi3D3qvVUXfUsGG1lo/TVeFkYN5kl2BzFzb78e548dJu3hSEre2LeJ6jnykqo9MLOBF1mwqjzkVJLDhuvHBXZ3HEPIQ7QZi+TTLQ6kvF2iOT7byp9yq8k78wfEl6D2Fjoqpd/xr+pc7ufeSbc7cX2XgjTcFyBOy5+uDtRo6OTZyh2rzryLDJM6yNwQ7pfCZfPlyUQbnPxI73S7D1ET2CpFFk9bvn4j0x4FFCkPR5p5PsoT/XBHVqTI5LuWHYoXj7xATJ0P5Ka54R9E1xUmtOOGgdn6uXhCu74w770AJsLk9R7lM29tFHVlpDsUK3RwAyzIO3k8ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 LV8PR11MB8485.namprd11.prod.outlook.com (2603:10b6:408:1e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Wed, 22 Jan
 2025 02:50:21 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe%4]) with mapi id 15.20.8356.014; Wed, 22 Jan 2025
 02:50:21 +0000
From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
To: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>, "Alif
 Zakuan Yuslaimi" <alif.zakuan.yuslaimi@altera.com>, Simon Glass
 <sjg@chromium.org>
Subject: RE: [PATCH v1] arch: arm: mach-socfpga: Mailbox buffer and SDM
 doorbell improvement
Thread-Topic: [PATCH v1] arch: arm: mach-socfpga: Mailbox buffer and SDM
 doorbell improvement
Thread-Index: AQHbbHRX/aFyltOnbU6NaOBBYUftgLMiF0QA
Date: Wed, 22 Jan 2025 02:50:21 +0000
Message-ID: <DM8PR11MB55922DA9F926D687B1403B37D2E12@DM8PR11MB5592.namprd11.prod.outlook.com>
References: <20250122022102.31186-1-alif.zakuan.yuslaimi@intel.com>
In-Reply-To: <20250122022102.31186-1-alif.zakuan.yuslaimi@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|LV8PR11MB8485:EE_
x-ms-office365-filtering-correlation-id: 24f1b180-381c-4bbb-a303-08dd3a8f8346
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?b9gKYuKTmI7U5v/J95PRRLBx/e1mtbHtcHnJsJznxCLWU+3o/iKDGGt6CVeb?=
 =?us-ascii?Q?Tqe66YYDepzhbMTqdS9ga2oUZAR9suK0C5/SFUgiN3ImJAZne1qSkwcuYwJs?=
 =?us-ascii?Q?O1naK1tA6msb9GrEPjtdM9IoQmpBz1+Mwu2LcRgZcY78h2NYYLKokAIGlWM9?=
 =?us-ascii?Q?xbV4fm4x71hNAwy93vLaYM4EYXtFL0/Pg4o8yED5t3zFUgj1o/WKmUPpdqPx?=
 =?us-ascii?Q?SoqbNtqjw1pqDWuBn+wZYCjyWjKW43HAvefFa6e+TJzmlSKepNgxVuLE4ay3?=
 =?us-ascii?Q?P7AlZoD0gra6DxfQ5s4CeSwN0BDix+T/ql6XDgXXCp5TGu5si6t8h/LdLw21?=
 =?us-ascii?Q?m21HDjVLZ5P7SCo1rOqMA+1mMml2Dx5dIfGsjH8TSAo/+IZy06lOSp6PqwwY?=
 =?us-ascii?Q?fXqRK6AzggcihBwG8dEFTd9yu9QPV7SMbqoTlSNLWl3AzpJFKgwUlOozRm1t?=
 =?us-ascii?Q?TyOllgWbzKmqC15L2ueCgRks6LtNUmngn+E72RycMcta4gSWfX7rdnCCM4J0?=
 =?us-ascii?Q?dm/sfrVzSHlG6VXLfYNX7d5xqHS5POazgbJmfjDhkY7K0b6enGDSRFg5UDzw?=
 =?us-ascii?Q?iI21XbWwyNH/vTi9/GSx16Q6scLGltkgP+8zU/y0FcfOQEzYlVbwlrcc82m3?=
 =?us-ascii?Q?nShugmb0X3IgYG0S3oZ2ukInKs60usGCOzzDuMxFNVW2zCaNoDjWMdeDq4Gv?=
 =?us-ascii?Q?R/mfKLP+3UaYDHmt3D7AAEUbNIP55GwT3V7tLh9A9/ZQqdkMzFDNg8tHh9qT?=
 =?us-ascii?Q?EnDxMysZpNajW8l4GuFf3iWm7xENgVihOfwUKwmsKTYSlrRUrnFANZWx6wnh?=
 =?us-ascii?Q?5Stjn3B1SDQcrJ1Ybh4j+nMe7GndrjY7bWeeHnplT/9ZitbumoDG0V8WnraO?=
 =?us-ascii?Q?huox7w/EmNbOxhuKOpT4rC9myNxNKRDrWUBnYXUBNjdcLgMOS9wbrebaPni5?=
 =?us-ascii?Q?vqC4y3bliQXv0vjw5egHR7MBqNL9kc2e2c0RaorndQ4xAQSV8iwRdYpnB0V5?=
 =?us-ascii?Q?3+nguJkkF7jLdQIX1RL/C45+JP9v5zC9hJPdIXpHr3ny3zwnI0KotyFRvlb0?=
 =?us-ascii?Q?tTNjkc8045Fv1gQdMm1JzIi/lu3HocNPvPWL1XYFktcvqn0vK8QUZPRK7wVA?=
 =?us-ascii?Q?2CmhOUwrPCEWy9lF+CJ318P10d4mXxzXb4izmDyt9lti61LroFmXAhdjLJL7?=
 =?us-ascii?Q?4TiFjqQ1vn9G1PZVBXgtxMYoesFAsj5S+OpFZErBXVGYOX7iSSd4e4dj2v49?=
 =?us-ascii?Q?+HQIzfzE8uZanPjqqBJelU9OqbOKrmHzYk5Iu0C6r+Sa6Tzo/qUctPR78qsu?=
 =?us-ascii?Q?kKKPDxPY51rfoDjy+QJvRtw8ySHGRAO9Aqm0O8dwjzIlhk6URVBLSifpywxU?=
 =?us-ascii?Q?cpsNh3Ke55YtcVH1AChLsbIwzMGp6JZRPxZTOpi8VjbIgvtAibZzviGaE65h?=
 =?us-ascii?Q?aDV83epZ4TPE0vPoSBhRcXfYbXjmdgFD?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5592.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T9ZkUUTXJLBJcugGPWzzpD304ChqdqRvY9ZsZJstUB9EsaTVffG+Cu3zRuYP?=
 =?us-ascii?Q?B/9JL/b91Ljy2at3iv4Py8bMz905y7oOx55fECRGpIxnVtf6Hz3wx7gSMOTi?=
 =?us-ascii?Q?WrFuV2kl+BdSzso82RhUqWZm9QH5HwXR6LzPQQMDNl+ml76FuuBoXuLxCnqk?=
 =?us-ascii?Q?6yPIVrHUuR2YCt3hyfHYbHbpGFrH+1BSFbEva1z7AbHECvkdHjPf25a4NQHD?=
 =?us-ascii?Q?Vr4ba+l+n/kdbdgVeld6EoE9gXZMdHEbPG3jzTP60AK33h2tknGDJvRPtB3/?=
 =?us-ascii?Q?IzXNd+quTi1tOWtAxLe7m1W4yyLroxd0SBuZli300sa4ikblHCkkKR6qb+WC?=
 =?us-ascii?Q?MkRnqS16p1hAplSbCvn5F0mWbkmfHuRO7PIX/Z/j33X0UuenTeggovie8rwm?=
 =?us-ascii?Q?tU8NnyA+v5C/k3+CqTisbPSfVOQtMNNsm0Rn0QNqvqxCmk99VC4BJ9OL/bk/?=
 =?us-ascii?Q?3mwp0gQDJY+027CrPoTWULCn2CbdeCymDtoZuAVIkzjwq82AaWN6Uahn6Wfk?=
 =?us-ascii?Q?1L8zG1c4Kc13rqee79YGdwtknmx/R1qCnTp8mKtTtXa8oWG96dhwwihTTAoJ?=
 =?us-ascii?Q?wReQs0ozdTjTIrsch+F9OKxCyZWLtTQak9gYp31xOJiCDDsepOttkF/4eyvt?=
 =?us-ascii?Q?FfphDa38iH1OnAhEAJG7vswBn6tmDKxreb+H9hA70UHQJIVfNL3TCkP9m6QG?=
 =?us-ascii?Q?/3QzAzk/BXqT8cRXLEiJcNnJz65i8GEgVjOhn8AaKyKBRzSaa41HyEJDVG4Z?=
 =?us-ascii?Q?PKq1bBYMV4r+I1ymY3k5fQp9lqhLAPfcpLY5nIollRqTF9q1p+wHDYFlFu9q?=
 =?us-ascii?Q?+HfIbSHRZAE1aZWq0lvYOAXgyD1Ixho1ABADX7G8yuBxDFsecGUVGDIJGk21?=
 =?us-ascii?Q?PCSE8BzLPccw0BF+FJ1+e1WBClRp3CnJ9gm76JcBYhzoKT34m9k9PQFNlXfr?=
 =?us-ascii?Q?i7Df8zOkgFG5OSSXI64Orw7UId81ms6SeCTTG8TFnUddtWaLfbuZ8izYYp0n?=
 =?us-ascii?Q?3j38iVXWuQ2GlD70ZuQg24E7apBs8XpW45QVuvWLYxCBx+fXGwN3C6EMBg2u?=
 =?us-ascii?Q?h1zfBFA8Vz+oeBFCJw+ur0whGcY7am6diOCLmXIsdZo7DuVYEQvE8hfbZ2VJ?=
 =?us-ascii?Q?nUgoWG35H6zIsGE7tfi2FfAaV5FA0QstRxDCUkKRmWjdaQBypxR7WFqMCglU?=
 =?us-ascii?Q?9Slym6QzVZFLr0tcYPUouOhFqkp5784kZa9zv0iUvXLcElNVj/GeJnNA8BtW?=
 =?us-ascii?Q?YvUtbRoJSVTGbVjrgomV/BOYw8BsDJjuy0/k/NIpN865Ob0Y3vEEP4a0nMrF?=
 =?us-ascii?Q?CpK/i1oPCxdENmTf2/nKRiHEhWCl8cAzZQ5p7QOIjhYD4++SJnqBkxOq3lnB?=
 =?us-ascii?Q?kM12qjLKjX0zkabNRI+Asb4GzuSm60CfsrFh9O/Fv/zMa41aeqFyN1E+fq1b?=
 =?us-ascii?Q?acfsLJUc7MP6Bvsr9zdczFPYQw3QUEFRmqR5HzzirPXpIDtFy1X6oa8n8EZi?=
 =?us-ascii?Q?Evo7oVJv/Eaa/Eu4LQrpC3LmYHFur2DR9aJUNOyEj4XISKcKFdw1W/893msr?=
 =?us-ascii?Q?lkr2jUxyuAlzipwKTMRy6CWLtxVRx48M9xOlBMbV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f1b180-381c-4bbb-a303-08dd3a8f8346
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2025 02:50:21.3371 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jfjdfyRdA5yLvkDDCJcd3dJ6DMSwDf2frVvh55cOVLXD+wkGOnXkjJc59DAkoF9na7C3RuvkNVEb1omF8STV2PCYXf+Q+Y5vK4qYt/nJh5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8485
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


-----Original Message-----
From: Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@intel.com>=20
Sent: Wednesday, January 22, 2025 10:21 AM
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt <simon.k.r.goldschmidt@g=
mail.com>; Chee, Tien Fong <tien.fong.chee@intel.com>; Tom Rini <trini@kons=
ulko.com>; Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>; Simon Gl=
ass <sjg@chromium.org>
Subject: [PATCH v1] arch: arm: mach-socfpga: Mailbox buffer and SDM doorbel=
l improvement

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

The current write and notify SDM to read mechanism has a flaw where SDM is =
not notified enough to be able to read all the data in the buffer.

This is caused by SDM doorbell will only be sent out once the command buffe=
r overflow check is satisfied. If the command buffer does not reach overflo=
w status, no SDM doorbell will be sent out, which may cause a timeout as th=
e mailbox driver will be waiting for the SDM to read the buffer to empty ev=
en though SDM is not notified to do so.

The solution is to remove the command buffer overflow check and set the SDM=
 doorbell to always trigger at the end of the command buffer.

This will ensure that the SDM is able to read all of the data.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/mach-socfpga/mailbox_s10.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-socfpga/mailbox_s10.c b/arch/arm/mach-socfpga/ma=
ilbox_s10.c
index 2b4f26040fe..b69bd3e47ec 100644
--- a/arch/arm/mach-socfpga/mailbox_s10.c
+++ b/arch/arm/mach-socfpga/mailbox_s10.c
@@ -88,6 +88,8 @@ static __always_inline int mbox_write_cmd_buffer(u32 *cin=
, u32 data,
 			MBOX_WRITE_CMD_BUF(data, (*cin)++);
 			*cin %=3D MBOX_CMD_BUFFER_SIZE;
 			MBOX_WRITEL(*cin, MBOX_CIN);
+			if (is_cmdbuf_overflow)
+				*is_cmdbuf_overflow =3D 0;
 			break;
 		}
 		timeout--;
@@ -96,10 +98,6 @@ static __always_inline int mbox_write_cmd_buffer(u32 *ci=
n, u32 data,
 	if (!timeout)
 		return -ETIMEDOUT;
=20
-	/* Wait for the SDM to drain the FIFO command buffer */
-	if (is_cmdbuf_overflow && *is_cmdbuf_overflow)
-		return mbox_wait_for_cmdbuf_empty(*cin);
-
 	return 0;
 }
=20
@@ -125,13 +123,11 @@ static __always_inline int mbox_fill_cmd_circular_buf=
f(u32 header, u32 len,
 			return ret;
 	}
=20
-	/* If SDM doorbell is not triggered after the last data is
-	 * written into mailbox FIFO command buffer, trigger the
-	 * SDM doorbell again to ensure SDM able to read the remaining
-	 * data.
+	/*
+	 * Always trigger the SDM doorbell at the end to ensure SDM able to read
+	 * the remaining data.
 	 */
-	if (!is_cmdbuf_overflow)
-		MBOX_WRITEL(1, MBOX_DOORBELL_TO_SDM);
+	MBOX_WRITEL(1, MBOX_DOORBELL_TO_SDM);
=20
 	return 0;
 }
--
2.25.1

Reviewed-by: Tien Fong Chee <tien.fong.chee@intel.com>

Best regards,
Tien Fong
