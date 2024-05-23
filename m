Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E718C25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 16:02:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CAB587F19;
	Thu, 23 May 2024 18:02:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="GMwIiMH/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F4C7885BF; Thu, 23 May 2024 18:01:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF0DC87D4A
 for <U-Boot@lists.denx.de>; Thu, 23 May 2024 18:01:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kalen.brunham@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716480117; x=1748016117;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=czgeo9uqAXf5iWF94abRcnlL7iu6xOu5KT2PUng1c8E=;
 b=GMwIiMH/hfnOViaAAVNyxM46ZHHOlm0/sqYU9t9vXTeR6UXZmpoVyKog
 gpoOFwMultvuWUE0VeeaTh1IwgkXoYt6fB8MAcHYrSrp8N/q/vvuA1Fkw
 eatNAgFm7lJtnxaiyEV13H/0slM5cgaCnbWmySVA4Z7ekQfOEC3WVtT0U
 eZF8VMxgVevGCXi0ZBtdAx4H/Wy02heL5NDeqzaUW9qhgqRRdP16EO49K
 0Yi/vxlxyvIGXzQM+B0jx7GvB0XiCUqXhPrHLmWgo7HbiktC7f4pQPcZR
 JPVWruBh81xJ00STQ73MDFK5BXjLXWHr9qdQIMuz4bhFCQeKRkbReeRyl g==;
X-CSE-ConnectionGUID: uON+rqpURGydGcC5yT5mRA==
X-CSE-MsgGUID: x9D4ob2DT42DKT82u4SgHA==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="12994472"
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; d="scan'208";a="12994472"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 May 2024 09:01:36 -0700
X-CSE-ConnectionGUID: AXRY7na7SvuE+i/Vd0mOXA==
X-CSE-MsgGUID: 9UXHhfV9QLO4i26cxb930Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; d="scan'208";a="33825998"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 23 May 2024 09:01:36 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 09:01:35 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 23 May 2024 09:01:35 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 09:01:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DaK3R7iQWZeH2Q8rL8G5sOuC9CRmxK0TSANcqFblj515ESA97cTxcJUJJF6KxGaw97HF3o8zqFKlpZpO0tJT8NUTC5myM9GS+HulsFQiOHFwEFfI269aejq8lH/zsHEvUp5lohURdhx2WbvMfabmzgHXbtP1iVOVOvQB6VNE3rK/Gqq0NeShAVISEjD76bT1z5HiEnwXKmlZgf12dqG6qDTjG+FuhyhPleyDD8LxcxLBc1MpWhC0E0dd/Jm/mU8JSlXLEGCTzgvY0EnB8yQuNrQu36UTSoX3OUuFm1PfVWBb6YU7u9tLKTLHCBaYkIt3efVLkFbN6p0bsCtWjzk7Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2l9b0y421fQGfln8vSJRvKgXVLYXlHzmBkLLojHyhzI=;
 b=JOIg6l/eCYCf/k/nQbaZBQLgRfajIyKfHQuJJ75fQPbQexzOHnDhqkQxSC8WiG71PJjDWttaQ333WEBU//mGHw8dyPQ/A2K3IFOK/NuqSBy4zrt2gurNkst9XVYdTeaKld8C0PFmAjZ+qd5OdlnlH/k22uw5WUXJMAHsf/xlwnEcjs8NJ8xSok6jocFpoBXiFycrp4+GoBu+jp/tnszYmeqCotUfwQqIYZtm2IAgWvyeze4tuW0FRYpWtyCA3XqZn/RF/VHPr334TYJdBSj6Eko4VElXR0Y3L7+DHCVXoD9vCKqEGDsUsJ9SRx4R/ptMroGsLUIguZLKQ4hvXoMTzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5296.namprd11.prod.outlook.com (2603:10b6:5:393::22)
 by MW3PR11MB4620.namprd11.prod.outlook.com (2603:10b6:303:54::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 16:01:31 +0000
Received: from DM4PR11MB5296.namprd11.prod.outlook.com
 ([fe80::a82f:27ae:a8d9:6a81]) by DM4PR11MB5296.namprd11.prod.outlook.com
 ([fe80::a82f:27ae:a8d9:6a81%5]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 16:01:31 +0000
From: "Brunham, Kalen" <kalen.brunham@intel.com>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
CC: "U-Boot@lists.denx.de" <U-Boot@lists.denx.de>
Subject: RE: [PATCH 1/1] Added arm64 assembly for examples/api crt0
Thread-Topic: [PATCH 1/1] Added arm64 assembly for examples/api crt0
Thread-Index: Adqojlev93VX2sPCRR6waFJsm7XUJgC82DVQAAZzj4AAAJoS0AAAJBKAAAAadUAAAv2KAAAEUXCAAAc8cQAAHE4P8AAC35oAAAWjIdAALoXzgAAA8uKA
Date: Thu, 23 May 2024 16:01:31 +0000
Message-ID: <DM4PR11MB5296B8B0051B23A2AD03544CE3F42@DM4PR11MB5296.namprd11.prod.outlook.com>
References: <20240521162543.GU2568172@bill-the-cat>
 <DM4PR11MB529670F5CFDA6B4EDA7B7206E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521164659.GZ2568172@bill-the-cat>
 <DM4PR11MB529668DA50F05F26AAD229F0E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521181534.GD2568172@bill-the-cat>
 <DM4PR11MB5296769279BCDD505F614E6BE3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521234624.GF2568172@bill-the-cat>
 <DM4PR11MB5296918A0447369D6B27891DE3EB2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240522143908.GI2568172@bill-the-cat>
 <DM4PR11MB52968E794BE8B0A882A519A6E3EB2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240523153239.GS2568172@bill-the-cat>
In-Reply-To: <20240523153239.GS2568172@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5296:EE_|MW3PR11MB4620:EE_
x-ms-office365-filtering-correlation-id: 8a78ce3a-41ce-42b0-d95a-08dc7b419cfb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?PzvQGsavTXFOzgwpWUhD4jP7+e8Yk0tKBFtGO9OaIk9hqMSDIQcVZ+TDQtKW?=
 =?us-ascii?Q?e0poYVnjlGL97BZadcY4kOKARdHMV7w6bIORKAUpWEBp55MvNZldYWFvvkr/?=
 =?us-ascii?Q?8HiFMMsOk1bvl23WSEm30woRiiauxuI8vyxt+6XPMxwQZHPSLtxR3Gh0eeGn?=
 =?us-ascii?Q?Cleanpc7ePOYdk8fvDg/+rCaC4j+ou+725fv/kxIeLYLOsxXdWIM7E6OLJ+0?=
 =?us-ascii?Q?F2Hxn8oMQ9kpa3Mk61TLEVn0mCipaCnpY+C9qMXLhah3aACEK2W+V88Of0Gb?=
 =?us-ascii?Q?/pao3+rIXrfx7wkMaF4dgvrV/e9SM7w5VrZDjmhrETBC4TfV7pHhZmZrvEp/?=
 =?us-ascii?Q?lVCCmilCeI5bfM3x2M8PtxbevzCdTwUCjY9ekHdEaWkugm84QCe0yUIl/jxV?=
 =?us-ascii?Q?UcxbxLufICrhYfNi5QU96HvQCM4zwhmUWZTbSU7mMKx0RGVxC3goM1coKnfZ?=
 =?us-ascii?Q?TIagZcapCcbLWdfCb/8iD6UMrG1b/rSXKrE09umwkIJLNjUuFcbGJFQchqxo?=
 =?us-ascii?Q?dKhQb2xCDLtNKqS9lAV4DOOTYCawSP+KeEfN6p8mwVIvnKDDnKmkfHR44Ini?=
 =?us-ascii?Q?wayLUJ5M4sDChGka3C2FQ1nGajviN+pM7oqB9qOQ3g/hwgLoDULKFXxxezPc?=
 =?us-ascii?Q?96QrwEzNlaKUSYwUSW1w5XSN3KteKON+SAfXKHx4mph6Zjx1o6cEHHzgFgbC?=
 =?us-ascii?Q?mngOu+bbpD+e9Co4kmVe5R3EYT1uOFFRL1BVhU7pfVRAsUQWPVtUcbdC2ncy?=
 =?us-ascii?Q?96fqj4sHu3d/vX6HpfMdZq83GrX0kKsomVhZykO/7fhY7fVTCDUlMuT0yOQ1?=
 =?us-ascii?Q?bK4wVYYJtVu7MmS1faUoefjZwkyuGn62DGb3/mmERg/6PVTqjPC9X2UxDhjr?=
 =?us-ascii?Q?YW+I2qY1JLU3ktcGJXsnwxlQu+vZbF73ht/wmMv+kPKCyC3h5tMK5sEnvTRP?=
 =?us-ascii?Q?efVsCs7rpkiqhUgkSsWRPvffHpb4+ADkncJND+bfbmn1PRJWjAEgAwaqBhNU?=
 =?us-ascii?Q?yxsULPami12+u1lZXpzR+GF4e8lDvaY1/bBymURi5L+gw/grMOCS4h8hbD52?=
 =?us-ascii?Q?DHkiKDa0fwNMsKK4zQ19Wo7EB5w6fDN8qttOe+bL/crOBe864vfwOrPft3EE?=
 =?us-ascii?Q?T9qN5+63OxWK4qxU+h8EF859oMVQ5zlU0LGzGVq9oY0pyywVKsyBAOsIlIQv?=
 =?us-ascii?Q?UaoO5Hc7HkwwIsqNdVLNtV8EAC8hPeAjW0QJpwC3EYtT0/E0v3GWKLsuDhMY?=
 =?us-ascii?Q?O8lfFStlIq654QWgkGY6M6HpNhA6lEWF3uim4/rRM7dYPTVQ+nzU48r4paFG?=
 =?us-ascii?Q?OOiGYbNEYcH99ll/8mQp8fBDU/If9+Aeq3kW5MJVWjhzgQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB5296.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vdW3InhisVZTuZiFb5jUXVjnlsGRbZrMWclhDEvj9DkGGDUmKZ/gQLm1hmtT?=
 =?us-ascii?Q?4pXGFLwXxsYTT0QxNK1rBnuVNWgBgrk0dll0e4QIGwIHC/OdGo7owMX2TtrM?=
 =?us-ascii?Q?jKSpWDbCP9eYEAF7GcEMjfRUqXgPTV52n4baltS08bQqVuPFuY4F7erWJeOG?=
 =?us-ascii?Q?d1hDxkIB0U9+rsbdx+2XCR06t2w26IGkM5QybKQE0BuZZWrR0h1N95AMNchl?=
 =?us-ascii?Q?/td+oDW6wQi0/Keoi7jDziZzTUQ6QNT6g6Pq1Dh9F/vzFmAeehgxvJvU1P8p?=
 =?us-ascii?Q?CNdr3p/9LRAhZgGPNPU+Nf7YHBUcHC4vn+8M3ZXyzTYCq8m29ppQfBrLcZ7Q?=
 =?us-ascii?Q?JDX6x8n8C/+c9P2JROaVZgw81970xlvRwLStFzq3Zi52w4x/iIEGdNfWFxKe?=
 =?us-ascii?Q?a8dUUiLT9LhJocFZeyAl9ZH2eJKjbudcP+ZrPoHxkl7TMdMS4RRw30o5ZslF?=
 =?us-ascii?Q?8opzew5la0T6a29U+Vkqnh+3pQQnZcB6S9o+kPmobRRIb1QkYz0/l24QSrtV?=
 =?us-ascii?Q?chmU1wCSwHLpcnhs00XgJggzhqMOMOcBxFZF5Zb0N2kSfSgUUkS8Em/JFwyg?=
 =?us-ascii?Q?qmxajsEQaE2jL9pW0rcwiso92miSzsZXmZ168rWG6rcGEpxckmJtSspDTdgQ?=
 =?us-ascii?Q?o0BW1tnMX1XK2rlqX6CnUDq9E5zEvS7V2jMQruvSaTDXS+5ufZ1EMTj8nl+g?=
 =?us-ascii?Q?DlBA26nhrW7/WzAclkfMY6CKkgO3JyxMYfi2QUbMLHxEQJ5j0VCJO8MW0ogM?=
 =?us-ascii?Q?yborjhn6Iq0RsjsAwoKALPfK3FMTWq3Xswo9cdtQTdBNx1ef96yfHHKWTRNZ?=
 =?us-ascii?Q?cNiebdtvwhpC2l63HWmWmTC7rBsYdNxT526AhH7lg8WpTXADsjWJy0XxXTcG?=
 =?us-ascii?Q?i4AlsNC88NkNkDQmwRDmeoMzxdCsvgIhekQU1rKOu0M3257ffDJptQ8YZBlr?=
 =?us-ascii?Q?5a3hPHWV8i6KYVn6qAZnSy08E8anr1DkMsYcm1yh3TMQd/1zJjJC2aeXgRek?=
 =?us-ascii?Q?5KyZZDhGzOfPpFVq+FjPo3w5UTUJDRR/74fY0Laq9h/CacEOwGFfwzQvAFqO?=
 =?us-ascii?Q?3NTz2NWbG9oA8qO18FzmrwVLx61yAHZAVMg0U7qlY57yUr+CetUFW08Mrff+?=
 =?us-ascii?Q?DMw4zDAxS+aa7zO6ygZPSOXECff29TJxY9eD9EDkUJn3n2yx7hBtJ4Dp6YvL?=
 =?us-ascii?Q?7lP3f0diYNYDEG1BKlKYOQCxCJpcc7g3fE1EHkiYa+nSqHwZfr76so9dgytK?=
 =?us-ascii?Q?1eaRe8Zb7MvjZTrbx9TDztAG3LC+93N2hSKXfRCCy4IAC9DzSdquiL298G+W?=
 =?us-ascii?Q?E9uwVFcoltqeFicedWu/SiM4vc9u/+v+dHLCKWFDRsLkInP/zIZmquSbP/xs?=
 =?us-ascii?Q?dKIw9fR6mKOPUTtWzzkixVlSJ1U1pXVyOLUvWozgiUywcaabuxv6dxl4AMAg?=
 =?us-ascii?Q?XKGLmj21QQMhKgRggs46Il9H03p3DpPS+EYN4z5mYZ89toLlR39jI+8F0Uuk?=
 =?us-ascii?Q?8h+3hosXad103p8WT9BlbOeUgpFslac5+9sUeiTKGsFmKe4+Mx8uhnaanaym?=
 =?us-ascii?Q?r8s0vkKeQRockfDvR6B0ZpY+MJEB1/dfV2yltKJ6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5296.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a78ce3a-41ce-42b0-d95a-08dc7b419cfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 16:01:31.6528 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F70HtEr1EmFAaixujc7bVDktQLnay+BMydW1n5h6b10m3z/1E01jggdq3k5iGkm0Ti+G8BuhPS4TryLwt+WY2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4620
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

I can see that efi_device_path.c and efi_disk.c both #include blk.h.=20

-----Original Message-----
From: Tom Rini <trini@konsulko.com>=20
Sent: Thursday, May 23, 2024 11:33 AM
To: Brunham, Kalen <kalen.brunham@intel.com>; Heinrich Schuchardt <xypron.g=
lpk@gmx.de>
Cc: U-Boot@lists.denx.de
Subject: Re: [PATCH 1/1] Added arm64 assembly for examples/api crt0

On Wed, May 22, 2024 at 05:22:24PM +0000, Brunham, Kalen wrote:

> Hi Tom,
>=20
> BLK is currently a dependency for EFI_LOADER as shown in the snippet from=
 lib/efi_loader/Kconfig below. Perhaps the question is why EFI_LOADER requi=
res a block device? If I remove this depends on BLK line, then I can enable=
 EFI and successfully simulate the EFI hello world on my test design.=20
>=20
>=20
> config EFI_LOADER
> 	bool "Support running UEFI applications"
> 	depends on OF_LIBFDT && ( \
> 		ARM && (SYS_CPU =3D arm1136 || \
> 			SYS_CPU =3D arm1176 || \
> 			SYS_CPU =3D armv7   || \
> 			SYS_CPU =3D armv8)  || \
> 		X86 || RISCV || SANDBOX)
> 	# We need EFI_STUB_64BIT to be set on x86_64 with EFI_STUB
> 	depends on !EFI_STUB || !X86_64 || EFI_STUB_64BIT
> 	# We need EFI_STUB_32BIT to be set on x86_32 with EFI_STUB
> 	depends on !EFI_STUB || !X86 || X86_64 || EFI_STUB_32BIT
> 	depends on BLK
> 	depends on !EFI_APP
> 	default y if !ARM || SYS_CPU =3D armv7 || SYS_CPU =3D armv8

Do you recall why this is Heinrich?

--=20
Tom
