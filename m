Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20CCFC25B7A
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 13:26:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81390882A9;
	Wed, 22 May 2024 15:26:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Mocb+jln";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63366882A9; Wed, 22 May 2024 15:26:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F229B87FC7
 for <U-Boot@lists.denx.de>; Wed, 22 May 2024 15:25:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kalen.brunham@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716384357; x=1747920357;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=BSZLrHJa+SyqesaEfeD0AomFbKMAD4HibzMPWKsEyas=;
 b=Mocb+jlnEa9JQAUr+KB0t8FKTHmfrozBFJiK36jOW4UHEd3seBe2uqLI
 xhfmp5RCcSHz+L5x54/1nC9D0XDym4ruXX9Qtkb9F3uTQ1JGck61wu5SB
 PbIx1SaDzZ/v7uDYL2vaqWCY0Wm/QSjImzQlJZ8jS1cxYww83KXNXjJlU
 a2zRDT+PkTws6fp5k65mwXPonbM3+ePXDAoTvEUvvlOxvCpnaY6DWfb44
 PR6Ipc7EDPh9lZAKKiaz6NtkXbeihPXlIKQ3Mc32ykI9tSI2BDyHa6d5k
 f54k8sfR3+2w6M7/3aiaakISKVeXh/6v6N1lgEpsID/NQrIFFDjihXa1S Q==;
X-CSE-ConnectionGUID: SSund64rQ2yvh/YduxQpZg==
X-CSE-MsgGUID: zlSmzfh5QHGmUZMmToHAkg==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="38018976"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="38018976"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2024 06:25:55 -0700
X-CSE-ConnectionGUID: RRxm2Z6DSvWPcdx63Q9plA==
X-CSE-MsgGUID: dwbE9ilQQ2eDYGlhWLgmKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="64515805"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 22 May 2024 06:25:55 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 06:25:54 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 22 May 2024 06:25:54 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 06:25:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UsiVuQlMh3dDZBV9UfBY5j98FNlI9HMWzrEpbzIQeNyzaju+GR+1izdm1Vd1bkoZj9Q+pLHx6h/L631RN/6bBrlzoMPBRfZnK/GEBxI1qLtt5gk9/00k989iwTiKOLriu2UKWeDEZ9wXnf6/e1VaA+x1WfU4udzWcIFKCttLiFT67qNW086eHdvB+Azk45EB+d3rhOzTPiEbCMWiYzHCvA1vRj6CbvlpHobEyo6sEYOjWO2lJm/A75UzDbqxCY7ZdpR6E4TlRmqxfK5wqV/2iSYSCSe1V43iQ0MvKofOvjsH4cS0SStBNgTqlgGe7d5C9YWdMp3xX0QycC3KLWR2JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enpS1Q1N/FIM8NfkP1uj0kkNvC3B6y5owb6n9Z9esPM=;
 b=HtPaKg/Ml+WMSlcMKGI1ph7AqOFK5y+FIjJHfOiGTscE6qsMUsGulZxUcmQ3IgZT53rgLswYZSKvuIJVkcUByArSRGNhykH+1HL8RvvtzHRr+lwf38nu/q1P0mbgQDS39K4oRzhSL5QsnE93UQZ9nNK6al5rZl0VydtYnFXM4XXjxxiTEi0oTURiW0/zcFDdx61OsoU3iBlgvl2HUGj9Qgo063AUsANx0PR8a5ccU/sNfQiq/BZNx4DXMgxc5O5rWVoIVlDJ/4jpVbu8iZbw+JZhNSL6ZwHl5GaYhPT++eUdiCwrQLAFDfIpjL9F/K5gymEE/TPkwUXFD9ZK+4ojyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5296.namprd11.prod.outlook.com (2603:10b6:5:393::22)
 by SJ2PR11MB7425.namprd11.prod.outlook.com (2603:10b6:a03:4c0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Wed, 22 May
 2024 13:25:51 +0000
Received: from DM4PR11MB5296.namprd11.prod.outlook.com
 ([fe80::a82f:27ae:a8d9:6a81]) by DM4PR11MB5296.namprd11.prod.outlook.com
 ([fe80::a82f:27ae:a8d9:6a81%5]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 13:25:51 +0000
From: "Brunham, Kalen" <kalen.brunham@intel.com>
To: Tom Rini <trini@konsulko.com>
CC: "U-Boot@lists.denx.de" <U-Boot@lists.denx.de>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>
Subject: RE: [PATCH 1/1] Added arm64 assembly for examples/api crt0
Thread-Topic: [PATCH 1/1] Added arm64 assembly for examples/api crt0
Thread-Index: Adqojlev93VX2sPCRR6waFJsm7XUJgC82DVQAAZzj4AAAJoS0AAAJBKAAAAadUAAAv2KAAAEUXCAAAc8cQAAHE4P8A==
Date: Wed, 22 May 2024 13:25:51 +0000
Message-ID: <DM4PR11MB5296918A0447369D6B27891DE3EB2@DM4PR11MB5296.namprd11.prod.outlook.com>
References: <DM4PR11MB5296B1B9F0CFC701A8B11284E3EE2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <DM4PR11MB52961423BCE12552857A12A8E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521162543.GU2568172@bill-the-cat>
 <DM4PR11MB529670F5CFDA6B4EDA7B7206E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521164659.GZ2568172@bill-the-cat>
 <DM4PR11MB529668DA50F05F26AAD229F0E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521181534.GD2568172@bill-the-cat>
 <DM4PR11MB5296769279BCDD505F614E6BE3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521234624.GF2568172@bill-the-cat>
In-Reply-To: <20240521234624.GF2568172@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5296:EE_|SJ2PR11MB7425:EE_
x-ms-office365-filtering-correlation-id: 2baabfbb-f62c-43e8-b383-08dc7a62b36a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?72nBlK4KyldM3Q5r9uu2q/BMrdUTYiFTKoBmSH7SfEsEYfLMgYmSXltrV0VU?=
 =?us-ascii?Q?EnfiYGbrz0v90et4ZwbiPPaE5Or0l3W/oe1y3VA/mhGVHrVI4lzA0YAxxLik?=
 =?us-ascii?Q?jq0WaKAHRsD7J1ZSR/kp2tnM3DJpX+YYLVjen8DalvP0/H1bPyM+qoOsIrjQ?=
 =?us-ascii?Q?eT/scgg1XQDSLFZiH84mRKyJbHUx93eXomUYeAl4TLXt4KjLreRHW+t/xSC1?=
 =?us-ascii?Q?7G0dYh4hXooSTrr+/BOXfsAMcaGZkG4nfwN8oB2cEgYge1AazOhhAF3VJKt9?=
 =?us-ascii?Q?Am37Wp+UDVUDzIoeMMKqMCqOJTjbYQcxKmIoi6tEwFDVuZwpVo8SNoSgTIcW?=
 =?us-ascii?Q?A3FD4s92Wa1eRH6dKngruxK5g5unU88b2EUmJUqNgf3UIe8GnPlTqwMe3SXS?=
 =?us-ascii?Q?R6AKTvdzd/Ycc1JXNr/5wJUhL1/tYrKqakDJZbSwMEtWSuJaQP5ziN/yG+59?=
 =?us-ascii?Q?ucZgVGYarOrG3mitS884qIqyP9iMaajY5UQb4Ig29GIhy0JJko9X7PC/gvjT?=
 =?us-ascii?Q?qk8H4QqeK75ql0uYb2XRSiXtO0XtzzpkN+6JyR2py5OGKVEN7D16dEnUHogx?=
 =?us-ascii?Q?q0QsZsC5akX2cD5Vr5rUFmMsIjBwu8Y2BbWUBynD5EVio5kD1iJgQ4j5c7j7?=
 =?us-ascii?Q?CaPNvg1k/jGEYkhZu9QYhQFjPNtlXLQCVSK/bdvOM0mrSbhbc/K8k6Iwnx/K?=
 =?us-ascii?Q?BkWKD0RsHwoZUxmNPqgVtCzIR9pICBb5DnNx9Vnfse+DCI6ntoGlJhNFqz1j?=
 =?us-ascii?Q?/fWzLTzLfaZZtDyV26zC7LIdBWcCHDbrXfRgG14CE8k78UPA+Jd9YU+/U2k3?=
 =?us-ascii?Q?nXLFCBvzR9DVAyBKpqcqpQTX1M/S8+uaAcwzpjR51rg0VvPkTrS+GPAbvIne?=
 =?us-ascii?Q?hIY0F3Lr+g7m6pU3Gggw968OtwUndg/WwRmqdFxxPhBKdxA/YDVss2ZuPnyU?=
 =?us-ascii?Q?0qqmiji67KRk17yXzPDlChmsMaZON/CGO4naQplNLy6MGlFbilgeOdcZUg+X?=
 =?us-ascii?Q?m9aHvckUO26l0NTsycWI50eCQRXmAcDk/E5H0PUF5UFjCOikEd2GG+M7pUwJ?=
 =?us-ascii?Q?EoxNV5vf4tuTHWt6ZHRA1gXiRSRSOXSqvXlKHAceN61YxGlcyER9vNgkDVP1?=
 =?us-ascii?Q?cTtjndSoRrpYMRzUvDpOkbI/koY2Tq4Q4I9h9aixgGxG4YNiBDLLDp5t9uIJ?=
 =?us-ascii?Q?nJV4dAPExhXHPvSRwKGvC/PiBw0DGzA2rkf77XQ2ze7Nq4Lw/4iDlHiEZwS0?=
 =?us-ascii?Q?AeerZKK/nGLK0k3/ry0b4AAg1r1bPYnnSa7V4rSv8MNENKJB4Ztz/FHRTjxW?=
 =?us-ascii?Q?JnvKG5ynvWBElaCAiVZvWANDxMmFhrR0Px61WUj6hQGpHQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB5296.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K9OH6QPNGDvVYpR/tZxItbahQJMvUNDs0Stq+SMV0VoFImVJZgg5u6SVMLeF?=
 =?us-ascii?Q?AbuRAjSLcEGZPSFcOWLEhwTMPp/EXkcVyrtbGRU9xAqonHU/tYpbMRVoDfoB?=
 =?us-ascii?Q?uZH8CH47Pouk85+TDQeOz+xCd5CNcGcQYCpVLqy7CCyg+cQ30GUMnRdDDld0?=
 =?us-ascii?Q?O/OcJgfdmUPGhOkwElnDo8coQMkAAjNB11spQv23kbIzShHyv84xjZm0Gum+?=
 =?us-ascii?Q?3rVB943oo3YNeHlDUkrXdTJqn8rxjy3HEWzam7GDIug3Syg9lVKpN/w8sDX2?=
 =?us-ascii?Q?7t1UUnVItv//QOAHZ+9PjWEdHDKFcehoij9U2ho0zeGrNk+HTCNE87k0R5oV?=
 =?us-ascii?Q?T7EgmHHZQTKNzHoMcYh4ggTexpp6mhqIRHow/mCQLZqUsAv4fuw5dls5fPmL?=
 =?us-ascii?Q?Tjwi9Nic0ixglGWIFMMv7BZs4SkL+Hr1hxM+fyqfXTuHNptLTnkDrRfZDloO?=
 =?us-ascii?Q?kU8bC2iri+VoLelwKfjQP+wj+SDdHIi6n/YfjPHWcD7JJ70tzQ4s3MmkQR+g?=
 =?us-ascii?Q?Lp0jCX1/2wWz0whPKoBi7q1QT50IwD3cFAip4UdLu7qkSgHzktuStc2BlSs1?=
 =?us-ascii?Q?dRXAdnr8u3dqopj1HHUHa0ftENwNwa7CBe5C7q+d5zQdAtHawCyilLdTOhe5?=
 =?us-ascii?Q?KUzzDZr/uvB3C72MTWqb8wkDac7hNwaW0l8zZkYm1Wb+SycR6uELC6P4EhRI?=
 =?us-ascii?Q?zd7DRcI/8JKm7Und7xlQAiAMZevKY/xWAvlASdAn1r2UUqg8aMJgsT0t01sp?=
 =?us-ascii?Q?pRWfPDzoGcYzOiBpBWQ3ZP45R30Oq4rcTSobuDxmDzO2lkcjXAW3uPBsdggD?=
 =?us-ascii?Q?zuqENKG7s41dYb5ET9G/2NAIrjqhJtcduFNaZFhX+7OsRQQZN8bfUZYUCc1Q?=
 =?us-ascii?Q?sYJGmarI1qI6y93XTen6g0VS/cuNil/sGfu1jmrTylfB/Ezkz192/s6xv6mk?=
 =?us-ascii?Q?yroKvmvxGqRZEACHOPoAW8P7REQnncExbKzo+IRzHxkQOdz9Gm2AKPQvL2my?=
 =?us-ascii?Q?hqKXjZLiPCcHEyuNnhQbv36xEQ6Wk+HlhMJrzolectGDFaEkiFMiIP2Pk0ob?=
 =?us-ascii?Q?1rV1GJJ9ywBGIMfHECwDWXZYIzc0Gvbahv8fLDy82OnSsM9RiEUn3vtPkdlf?=
 =?us-ascii?Q?YGBhqIXGG6zCE06i3eHrFpneUwNop29uRfeWsQXpUBcbnAhNQghYx/5r3bVe?=
 =?us-ascii?Q?riy/z8yVVOyYG5ZQ3sxeRSGg1CrsAozf+3iD9exF4QaX/eQO5WkIN7fNGbXe?=
 =?us-ascii?Q?ag1A3shoJOMqHwruObTL4Mq5p/lcs1QFRqUS/Ncs31DR9ozIN6DXHmgzNtko?=
 =?us-ascii?Q?hXu+RpTyLiUN8xUxtlgOpY58Ky6JGiNIwYIosBcLjeOuNAxlVlzO5kScvjvw?=
 =?us-ascii?Q?GX8gUmIH4ieht+OUObJBzkNN6r8L0r4xtcUvXzRBNeesD2pqv9TnHqafkkFj?=
 =?us-ascii?Q?jgVR/bk0CKF5RVMzXNYfe2DEwh84Wy4F4n2RztThed0TVdd0vTSRS/PeVjk8?=
 =?us-ascii?Q?+RUdAlBcFId+E1ksYkzxwAWhFf59lJXKAOgvfrk1xKLkkeE6XvmpLJGG0LuP?=
 =?us-ascii?Q?WlSRcGKeMYN4k3Zr+B4bNZJdVEkF/bYiQglDVXGE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5296.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2baabfbb-f62c-43e8-b383-08dc7a62b36a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 13:25:51.4970 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S03lRfcXsYfGtrfXSDwFpLpcgso7OhKEWDRllXG7lezy3y9ewhgzmeTt+61LG+HiJZZzU0b//OP0BO70FTu8fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7425
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

Hi Tom,

I'm using a defconfig that does not enable any of the configs listed on the=
 default likes for config BLK (MMC, USB, SCSI, etc.), but I do have DM enab=
led. I cannot however enable BLK as CONFIG_BLK=3Dy is ignored. My current h=
ypothesis is that BLK is being forced to N by the select BLK in other Kconf=
ig files, but I'm not sure.=20

Here's the Kconfig for drivers/block:

config BLK
	bool # "Support block devices"
	depends on DM
	default y if MMC || USB || SCSI || NVME || IDE || AHCI || SATA
	default y if EFI_MEDIA || VIRTIO_BLK || PVBLOCK

My current flow is:
make mrproper
make socfpga_agilex5_defconfig
./scripts/kconfig/merge_config.sh -O ./ ./.config ../../my_uboot_config.txt

Here my_uboot_config.txt hsd:

CONFIG_MMC=3Dn
CONFIG_USB=3Dn
CONFIG_DM_MMC=3Dn
CONFIG_SPL_DM_MMC=3Dn
CONFIG_BLK=3Dy
CONFIG_EFI_LOADER=3Dy
CONFIG_CMD_BOOTEFI=3Dy
CONFIG_EFI_LOADER=3Dy
CONFIG_CMD_BOOTEFI_HELLO_COMPILE=3Dy
CONFIG_CMD_BOOTEFI_HELLO=3Dy

The only way I was able to get BLK set to Y was to add another default like=
 || DM_SPI_FLASH, since I do enable SPI flash in this config.=20

Thanks.

-----Original Message-----
From: Tom Rini <trini@konsulko.com>=20
Sent: Tuesday, May 21, 2024 7:46 PM
To: Brunham, Kalen <kalen.brunham@intel.com>
Cc: U-Boot@lists.denx.de; Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH 1/1] Added arm64 assembly for examples/api crt0

On Tue, May 21, 2024 at 11:28:10PM +0000, Brunham, Kalen wrote:

> Hi Tom,
>=20
> Thanks for the feedback. I've been able to build the EFI "hello world"
> application, but did notice the logic for CONFIG BLK prevents it from=20
> being directly enabled even when the dependencies are met, which is=20
> why it didn't immediately work for me. Do you know the maintainer of=20
> drivers/block/Kconfig that I could review a patch with?

Can you please elaborate on what problem you see? Thanks.

--
Tom
