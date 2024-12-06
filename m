Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D5DBE7716E
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 02:04:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1701C895E2;
	Fri,  6 Dec 2024 03:04:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="f7cqjBWO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7565C89582; Fri,  6 Dec 2024 03:04:01 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35EF58959F
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 03:03:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733450638; x=1764986638;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=DtJnhhDj3ifFS/jzqibfvEld7SbuUaClPV+AEfx6KBw=;
 b=f7cqjBWOZzL/Hs7DjOdn8jhILCjijPrattg8vGqF3qosUKWuTgXLcQDQ
 r6T77VMG1rs29ISSrwNCJ7A2IjnYnvQbay89Zou216eU9JrxY9cX7S6tz
 PJO7Fz+EDX1P6VAM0xX6gLfV1AIJhOPGcFefBYF9Q5P5EI5PegcmmpvSM
 zYdt0oGpSZaAMI2iC5xenHetcY/wjH9gbvcsLfcpTC8zDViAxqtAUumMO
 H3PF7k7geoP4dc9IKp1mUT9ykkIzayhTN8NVU8jDFZyfgFf98ZUQasu91
 GtRlmmvPBM1DnJaRaBP+f+YK/eec/qWkTa2qbTkdz6d9kJwPx0BnaAqHS w==;
X-CSE-ConnectionGUID: ZA/EMrKqRX2hR4cu3fXJFA==
X-CSE-MsgGUID: 4SXCjYSHRzaB8nhqGBpPqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="56280991"
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; d="scan'208";a="56280991"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2024 18:03:55 -0800
X-CSE-ConnectionGUID: xoAxDpTzQp+N1bWW3k2r8A==
X-CSE-MsgGUID: LO/xS3n0SuGUFEWn8EhXrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; d="scan'208";a="94350877"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 05 Dec 2024 18:03:55 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Dec 2024 18:03:54 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Dec 2024 18:03:54 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Dec 2024 18:03:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mh+/x+hy/oDBxWxl+SW4SMkwcCXCmExiokCBACnwWw+A81YHGOnMhQhX0ZKk+8AU0b7OCxXbFuu7iGTXMQLKZQ2VzYy9YDDQ8S8mllVOAytYAjbmX5qfBZei+JBxtfVgOx5lv7vD5YWvUdVXQRooTYlIUJKWxmzDvRN1nCXqwVFNmHBtKSq8uwhHdN3fcU3kIWto7JETBuZWUTKg6OLlx8RlTaprld0LKQmgrDrKjC5OM6/VfZetNiC9GXRkuGRX1ZcrG4yyGLhNddepYEZN9oYovkw6OiuBfqWU25DDjfvJTX/s4+mInW+ydRt1VxD70c6axVCpznaujuZDedYqbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZyqNgRUENXb5CVV3VcuIez29R+IqS5vR1yUntXSGCo=;
 b=xcrTol/kBweRCidw/CBBf7BFpDrDlW9A+ArCjkOs1ZWplS4GXHH571LP8bIQCrkGXtFEo0jy+Y3QygkJi+KWNm1+WRVw6PrH9o6TnNh7PFGwrLdlohvwG91oUrrFeErqtX9TehzF9MxI4D3ZGI5FpQ8zQ2rIcFWo1MIk/zuTDv+ak9hAhdWD/o4gEq6dsIgKskGWItrJKAMdffA1jvtV6b4fDPwEVs8qaZFZSM5TlujYs6AvIY/p7mpBKZcwgxtfcU8AmFh5y6OZgnz+GaLcB2nIZy+9PUIbHHku4B25ycwSgFq1EAPWTeY30547kfydetwri1RCRVbnDPgCx9kQCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5366.namprd11.prod.outlook.com (2603:10b6:208:31c::17)
 by DS0PR11MB7652.namprd11.prod.outlook.com (2603:10b6:8:14e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 02:03:51 +0000
Received: from BL1PR11MB5366.namprd11.prod.outlook.com
 ([fe80::f073:1e46:c7ee:df9b]) by BL1PR11MB5366.namprd11.prod.outlook.com
 ([fe80::f073:1e46:c7ee:df9b%5]) with mapi id 15.20.8207.017; Fri, 6 Dec 2024
 02:03:51 +0000
From: "Maniyam, Dinesh" <dinesh.maniyam@intel.com>
To: Tom Rini <trini@konsulko.com>, Michael Nazzareno Trimarchi
 <michael@amarulasolutions.com>
CC: U-Boot-Denx <u-boot@lists.denx.de>, Marek <marex@denx.de>, Simon
 <simon.k.r.goldschmidt@gmail.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Johan Jonker <jbx6244@gmail.com>,
 Michal Simek <michal.simek@amd.com>, Arseniy Krasnov
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
Thread-Index: AQHbRveKyKhYgDbAvUuMQLjo5gdJx7LXYwLggAACuICAAEyuAIAAxWkw
Date: Fri, 6 Dec 2024 02:03:51 +0000
Message-ID: <BL1PR11MB536683C574474DB29F2506A882312@BL1PR11MB5366.namprd11.prod.outlook.com>
References: <20241205092315.25060-1-dinesh.maniyam@intel.com>
 <20241205092315.25060-15-dinesh.maniyam@intel.com>
 <BL1PR11MB53660F0C5BE89BE5CEE5FBA982302@BL1PR11MB5366.namprd11.prod.outlook.com>
 <CAOf5uwk102CGq243krXHOjLkSFwPq7RPH8wdWk5Arg5SEaGFtg@mail.gmail.com>
 <20241205141544.GK2457179@bill-the-cat>
In-Reply-To: <20241205141544.GK2457179@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5366:EE_|DS0PR11MB7652:EE_
x-ms-office365-filtering-correlation-id: 44ae3ef8-3068-40da-1ca7-08dd159a3ad3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?j7d1WvWxxZ8nUDs44RdnYsj1t22oMxS0dE7nVqHN9wSnUYPI/Fi7bSuWIO4n?=
 =?us-ascii?Q?wG5t2FLBMFmrG9dQUqGiFul11/p9AuUoCb6cpMxVr/OYBYqO37d/bzTBnwT9?=
 =?us-ascii?Q?g1qNGXmNsyQxPT1Wo/GeQjh0MLLrYZi1c4robf9WF/hy25UtvoW4R5rDbun7?=
 =?us-ascii?Q?MCBqVwi6F7afrhhOPo/AISJz4d98AOhlr4Vcu1rYULDu8sGEAtraTNukLoJi?=
 =?us-ascii?Q?1lu/lAF70OCkoubQ9ywILrNzpC0SOQP4QYteF3KnWFMrsO2lOzMpBgvtfKPT?=
 =?us-ascii?Q?KO+RITLx1H6HRmFUjeTkr6+0527luq9cGlbeodXS8vPSDrFMoQTc9gtzT4BA?=
 =?us-ascii?Q?gvfSNmuaxUcHtoKWpO+HSurxa5BHmB3BWzmx74/jeHbMqC9HR7nnPDNgzIE5?=
 =?us-ascii?Q?Y7f0V0Z8J2RjOJ8172M7vzsftPXxeuEVHya2QkoxMFel3sIYxuddBQHKfyFv?=
 =?us-ascii?Q?E3XNfugCubXyMdtO/loXOVb8ZFh0LvJrq6hA7Z8eUEPjzElBm20K3w0eUeGt?=
 =?us-ascii?Q?Yx3lA2k9gr+bl3+Asq4P/7RCSDxXe7/mAlR4jdTsaasJgchYrncypot9RYYN?=
 =?us-ascii?Q?EeQUKIji0ICAuKCzZD59QLiXwxvyG0KqbwBuPLawwUvjSy3HiVuQz7T+AJIZ?=
 =?us-ascii?Q?7Yybjyc98ItEtxoMK7fBuzDmXZYAA4T3HJ2saWWQUuJqAvecsVw2OZ7WPftr?=
 =?us-ascii?Q?qJ6I9WZIZm7yy/pL1VylYlSiD0HPoICFD4B1jYknN5YJ8f6GvaEwo6QXT2d5?=
 =?us-ascii?Q?hXQLOB7m5BtjfEEQ76oCy0o49UZy60TcQaxczGutC5Dl5rw/XUm9Ctp5CFIT?=
 =?us-ascii?Q?Gpwe9mJuRy1A/lF+WZ8sdBCspFbTG0Y38zX7QIVZ/cLRHu9Hbb/1/KsOlcx9?=
 =?us-ascii?Q?klhorEqyVXNfEpY3JYKOJtzPcOEtpoJBSNBBWW+1BNNSav+uZmPs6e+flNnq?=
 =?us-ascii?Q?ZabjQ0zQY4YYCYyq2/2Jawk6yadxpBdonypKhNlZNeuFJ/6J5bjyuOMDQzFM?=
 =?us-ascii?Q?G/dqXjWmcRW6DeSqWf7rWHNpwpSvgRd30x1mtB+rs1MTbNN/iBkvaHndzCIL?=
 =?us-ascii?Q?1fqbwwmsAbR+OMt9jnHM0egi1HwIZXcjLpnBoIk4qSNQSobqszrt148hBvOo?=
 =?us-ascii?Q?ZO6UfQC2YgYatWiRzSP1GV2uF7O4NLSQRDRq8suSYBP3kpShekJgeWeUZglz?=
 =?us-ascii?Q?IRC8wAHhsO8k7lE5nPLfK4tfvqRfMGUvrqIlVNNK1Sor7+kIUerh5z/MfVob?=
 =?us-ascii?Q?IGlUMtxIyx9pLDHBb8mmu0IP8QNKTWlxA0cj2EDq2OU43x1vFCUVdy/qon/d?=
 =?us-ascii?Q?XHbRVLy3c3GqcQBs06aMES/Q3CVWJ5pokWDBDQItzH5LIw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR11MB5366.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YTiKvYHhfYnajRgAvG4wkWIle+BvRru/UlBUXE5p8qL2Q1VLHZtBIRZx/jB0?=
 =?us-ascii?Q?g5uBeS7Iq6VN4egDrpU9jTYtdVDo9WZ1VJI6UfFL1O6sXFUWJO1QEBp2tFUt?=
 =?us-ascii?Q?5obbrn38VWwSskto/UqNDw0M8wq/ATux6A/Xm5DlFpaQGKjViJyi+bSgQTRc?=
 =?us-ascii?Q?UERfu8gJ7kyz2V9ctCbbju4ZeyAQcElUpGNxvGsQ4/yzcijwRbLbqg0lvGpU?=
 =?us-ascii?Q?bZex0FCEawnQCJqxBCWulz5bcYwnDzFQKZwCYdKXzfs/7oOMJQDt7cvMgvxu?=
 =?us-ascii?Q?hxFg4fHZwBTqgtNDBBiiS0sfncuN56nHSaysSoSwkrZLd06abKnJmss7JmOd?=
 =?us-ascii?Q?aoZTnpYFW02kGDJQCQLYQDPs6TyPeN2cZplQvsABRn+qMX6RJEYlrZ1s2cjU?=
 =?us-ascii?Q?hN6KemBba9s7FP+6nhHr1mZ1SlAkT695JOLSId0R++l/2UtGFIExIxJPRjtj?=
 =?us-ascii?Q?ReQNG/j9PUhbVwyCw3nqwwE0Jld6xluTNkZaU+9aoOZR7nWEKufxzsoWwDoc?=
 =?us-ascii?Q?rVVxWZOqUoJ0YzGw2w0VidQNdaXvxfTSTWRZuIILlIh2KJjyEQpr04Vdw52c?=
 =?us-ascii?Q?3W25nr/XSCqWUIsIkWOhygsNajjCoK1Co2ww6TnB+ZPdNbEMCtGScvtDJoKS?=
 =?us-ascii?Q?bfx+aAhvkruhdGg996yCCXfWH4qs9fzXpkRXTY4cx2ME0AQZ9qia3lwWHQeb?=
 =?us-ascii?Q?0Gptgyv9Lxf3D+H3VXA5bZaXFIdT/Y7oEGSesiloRi8QJ+iEYuXFDdTiL7Aq?=
 =?us-ascii?Q?UQIg4heRhwOMTi4o9Q2/0K/TEz7w+U7FSUoMYxUecylG8/7voJuV0FN4JqcC?=
 =?us-ascii?Q?iYSiXs4MjvEyqTawzFPIr99MPJ5uqhLQKJZ3mxPNAcrZSotqaaudAtu0S6pa?=
 =?us-ascii?Q?eCnqSdiGlUttCpbfe48iC/zooclJ/tETppPA8CxLsne2DK1MUYGwvfFwc3kS?=
 =?us-ascii?Q?SlKGYejGdn7x8HMlep/tV7I6H9gip60JMzaD4Z8kQdENkS8pdtGMZQA4gBCm?=
 =?us-ascii?Q?Z957mRdioX05SYz5i4ZDOAyKQLr8fwzOQbLlqbHq8hEXSmLqsOW3+yvtr+Dv?=
 =?us-ascii?Q?uKYyAJfAOovW9oNCSt7uvhx0XwZvhZpsgyAw8FcUnHmoRnD2t5ok0kqleAbM?=
 =?us-ascii?Q?oX924um5uvvA5rMX4EmMx1NE+XETkW35fiA0VjXIbAXQUjGzsZGZMR3kg+wu?=
 =?us-ascii?Q?PsnOnEcTLceYHZYf1BHhkm6Lp8MSOZrVMteJhbc4pYeVpFpwrtaxXu/CUcmn?=
 =?us-ascii?Q?8LIedw8JRaaCbrN8Nt2lcvemMx+ytew8/lA2701601gSeKE37mulR1eK+sqc?=
 =?us-ascii?Q?sxI01fhIxHVGKtqfixwJZ/WlilxtFxzVky5HF7g3tOVkpZPKDzAyG4eLdXDI?=
 =?us-ascii?Q?Yx28M3duvqkjM3qrHnfNHlsJTLYrP6Bqr1H+Tl6bqENPY0R1viHPZGjLfYyB?=
 =?us-ascii?Q?wFCRodnnqrQ1C/mJUMuPYsKSCb3lca+SV34/X2kxg1YnXMZrxvQX02m+ODt4?=
 =?us-ascii?Q?JBTx8NYsyUq33IoYNwZ/fofkKr0wB1F5XbNvodW3or5pGASMZrSkzai6bgbr?=
 =?us-ascii?Q?28OZkVFOEMCuZAOX5pVY9x8DijtuEN/jTkHEpx20?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ae3ef8-3068-40da-1ca7-08dd159a3ad3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 02:03:51.2297 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8u8LrlmORETjpQXMWhxmH2clNTJnxPkBNVTV76xRhncPlmFt5yOQKKEwKfH8bH5FToXQ2DPzZMcbCnnSts0mykl0NCXVFSXWCVFKZIG38wc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7652
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
> Sent: Thursday, 5 December 2024 10:16 pm
> To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
> Cc: Maniyam, Dinesh <dinesh.maniyam@intel.com>; U-Boot-Denx <u-
> boot@lists.denx.de>; Marek <marex@denx.de>; Simon
> <simon.k.r.goldschmidt@gmail.com>; Dario Binacchi
> <dario.binacchi@amarulasolutions.com>; Johan Jonker <jbx6244@gmail.com>;
> Michal Simek <michal.simek@amd.com>; Arseniy Krasnov
> <avkrasnov@salutedevices.com>; Alexander Dahl <ada@thorsis.com>; William
> Zhang <william.zhang@broadcom.com>; Igor Prusov
> <ivprusov@salutedevices.com>; Meng, Tingting <tingting.meng@intel.com>;
> Chee, Tien Fong <tien.fong.chee@intel.com>; Hea, Kok Kiang
> <kok.kiang.hea@intel.com>; Ng, Boon Khai <boon.khai.ng@intel.com>; Yuslai=
mi,
> Alif Zakuan <alif.zakuan.yuslaimi@intel.com>; Zamri, Muhammad Hazim Izzat
> <muhammad.hazim.izzat.zamri@intel.com>; Lim, Jit Loon
> <jit.loon.lim@intel.com>; Tang, Sieu Mun <sieu.mun.tang@intel.com>
> Subject: Re: [resend v2 14/19] configs: nand2_defconfig: Enable configs f=
or nand
> boot
>=20
> On Thu, Dec 05, 2024 at 10:41:17AM +0100, Michael Nazzareno Trimarchi wro=
te:
> > Hi
> >
> > Il gio 5 dic 2024, 10:36 Maniyam, Dinesh <dinesh.maniyam@intel.com> ha
> > scritto:
> >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Maniyam, Dinesh <dinesh.maniyam@intel.com>
> > > > Sent: Thursday, 5 December 2024 5:23 pm
> > > > To: u-boot@lists.denx.de
> > > > Cc: Marek <marex@denx.de>; Simon
> > > > <simon.k.r.goldschmidt@gmail.com>; Tom Rini <trini@konsulko.com>;
> > > > Dario Binacchi <dario.binacchi@amarulasolutions.com>; Michael
> > > > Trimarchi <michael@amarulasolutions.com>; Johan Jonker
> > > > <jbx6244@gmail.com>; Michal Simek <michal.simek@amd.com>; Arseniy
> > > > Krasnov <avkrasnov@salutedevices.com>; Alexander Dahl
> > > > <ada@thorsis.com>; William Zhang <william.zhang@broadcom.com>;
> > > > Igor Prusov <ivprusov@salutedevices.com>; Meng, Tingting
> > > > <tingting.meng@intel.com>; Chee, Tien Fong
> > > > <tien.fong.chee@intel.com>; Hea, Kok Kiang
> > > > <kok.kiang.hea@intel.com>; Maniyam, Dinesh
> > > > <dinesh.maniyam@intel.com>; Ng, Boon Khai
> > > > <boon.khai.ng@intel.com>; Yuslaimi, Alif Zakuan
> > > > <alif.zakuan.yuslaimi@intel.com>; Zamri, Muhammad Hazim Izzat
> > > > <muhammad.hazim.izzat.zamri@intel.com>; Lim, Jit Loon
> > > > <jit.loon.lim@intel.com>; Tang, Sieu Mun <sieu.mun.tang@intel.com>
> > > > Subject: [resend v2 14/19] configs: nand2_defconfig: Enable
> > > > configs for
> > > nand boot
> > > >
> > > > From: Dinesh Maniyam <dinesh.maniyam@intel.com>
> > > >
> > > > Enable configs for nand boot.
> > > >
> > > > Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
> > > >
> > > > ---
> > > > v2:
> > > > - remove the "this patch is to" commit phrases
> > > > - using #include mechanism to keep track of the variant
> > > > - add maintainer
> > > > ---
> > > > ---
> > > >  board/intel/agilex5-socdk/MAINTAINERS   |  2 ++
> > > >  configs/socfpga_agilex5_nand2_defconfig | 33
> > > > +++++++++++++++++++++++++
> > > >  2 files changed, 35 insertions(+)  create mode 100644
> > > > configs/socfpga_agilex5_nand2_defconfig
> > > >
> > > > diff --git a/board/intel/agilex5-socdk/MAINTAINERS
> > > > b/board/intel/agilex5- socdk/MAINTAINERS index
> > > > b696f788c8..30d8815d20 100644
> > > > --- a/board/intel/agilex5-socdk/MAINTAINERS
> > > > +++ b/board/intel/agilex5-socdk/MAINTAINERS
> > > > @@ -2,7 +2,9 @@ SOCFPGA BOARD
> > > >  M:   Tien Fong Chee <tien.fong.chee@intel.com>
> > > >  M:   Teik Heng Chong <teik.heng.chong@intel.com>
> > > >  M:   Jit Loon Lim <jit.loon.lim@intel.com>
> > > > +M:   Dinesh Maniyam <dinesh.maniyam@intel.com>
> > > >  S:   Maintained
> > > >  F:   board/intel/agilex5-socdk/
> > > >  F:   include/configs/socfpga_agilex5_socdk.h
> > > >  F:   configs/socfpga_agilex5_defconfig
> > > > +F:   configs/socfpga_agilex5_nand2_defconfig
> > > > diff --git a/configs/socfpga_agilex5_nand2_defconfig
> > > > b/configs/socfpga_agilex5_nand2_defconfig
> > > > new file mode 100644
> > > > index 0000000000..3bfe6270fd
> > > > --- /dev/null
> > > > +++ b/configs/socfpga_agilex5_nand2_defconfig
> > > > @@ -0,0 +1,33 @@
> > > > +#include <configs/socfpga_agilex5_defconfig>
> > > > +
> > > > +CONFIG_ARM=3Dy
> > > > +CONFIG_ARCH_SOCFPGA=3Dy
> > > > +CONFIG_DEFAULT_DEVICE_TREE=3D"socfpga_agilex5_socdk"
> > > > +CONFIG_OF_UPSTREAM=3Dy
> > > > +CONFIG_BOOTARGS=3D"earlycon panic=3D-1 root=3D${nandroot} rw rootw=
ait
> > > > rootfstype=3Dubifs ubi.mtd=3D1"
> > > > +CONFIG_TARGET_SOCFPGA_AGILEX5_NAND2=3Dy
> > > > +CONFIG_PHY_CADENCE_COMBOPHY=3Dn
> > > > +CONFIG_SPL_PHY_CADENCE_COMBOPHY=3Dn
> > > > +# CONFIG_MMC_DW is not set
> > > > +CONFIG_SPL_MTD=3Dy
> > > > +CONFIG_CMD_NAND_TRIMFFS=3Dy
> > > > +CONFIG_CMD_NAND_LOCK_UNLOCK=3Dy
> > > > +CONFIG_SPL_MTD_SUPPORT=3Dy
> > > > +CONFIG_MTDIDS_DEFAULT=3D"nand0=3D10b80000.nand.0"
> > > > +CONFIG_MTDPARTS_DEFAULT=3D"mtdparts=3D10b80000.nand.0:2m(u-boot),-
> > > > (root)"
> > > > +CONFIG_CMD_UBIFS=3Dy
> > > > +CONFIG_MTD_UBI=3Dy
> > > > +CONFIG_MTD_UBI_WL_THRESHOLD=3D4096
> > > > +CONFIG_MTD_UBI_BEB_LIMIT=3D20
> > > > +CONFIG_SYS_NAND_U_BOOT_LOCATIONS=3Dy
> > > > +CONFIG_SYS_NAND_U_BOOT_OFFS=3D0x0
> > > > +CONFIG_SYS_NAND_U_BOOT_OFFS_REDUND=3D0x100000
> > > > +CONFIG_UBI_SILENCE_MSG=3Dy
> > > > +CONFIG_MTD_RAW_NAND=3Dy
> > > > +CONFIG_NAND_CADENCE=3Dy
> > > > +CONFIG_SPL_NAND_SUPPORT=3Dy
> > > > +CONFIG_SPL_NAND_FRAMEWORK=3Dy
> > > > +CONFIG_SPL_NAND_CADENCE=3Dy
> > > > +CONFIG_SYS_NAND_ONFI_DETECTION=3Dy
> > > > +CONFIG_SYS_NAND_BLOCK_SIZE=3D0x20000
> > > > +CONFIG_SYS_NAND_PAGE_SIZE=3D0x800
> > > > --
> > > > 2.19.0
> > >
> > > Hi Michael,
> > >
> > > Please guide me through the process to run the CI in github.
> > >
> >
> > I will do it for you and send some instructions today.
> >
> > Sorry for delay. I was busy ;)
>=20
> To run CI in github we have
> https://docs.u-boot.org/en/latest/develop/ci_testing.html and where it's =
not
> clear enough please send patches to update doc/develop/ci_testing.rst tha=
nks!
>=20
> --
> Tom

I will check this, Thanks A Lot!
