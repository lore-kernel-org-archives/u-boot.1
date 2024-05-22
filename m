Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82810C25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 17:22:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06E078885F;
	Wed, 22 May 2024 19:22:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="JKEZrmZ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA64688860; Wed, 22 May 2024 19:22:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C7CE8885B
 for <U-Boot@lists.denx.de>; Wed, 22 May 2024 19:22:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kalen.brunham@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716398556; x=1747934556;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=TSH7IlUUaad2K6+tOIM7uE5Hq8T8YIXrSWQy88KdUKM=;
 b=JKEZrmZ+LMGwaGW4HrgT3cJ0yq6b696YfY2uBBvVuRu4z+DO/H+B2Joi
 EeqODeoZymU5F6s0lerxZS1DJ+2FAqQdGdaWRsAOMsuxJCmSAkLTMcKz+
 pjxQq3PbatvDw7OJaIoEkxCb6KhNbkzDdBX9ZooXNZOFRrqzPj7dq+VBh
 +rMGm+vyKIHIobDkI/g8+lvWPB0c4Kxcaj03HWT2zdm3nvZQsNThDzJyl
 nFHG2WvdF6JvHc9uamH3bL4+a4WLAHfNmBCy1d+44lhylFl7rGkIDOKf7
 iPrCoTSqEdlIPGIhHDvIxhWxvt2ta/cB+SMAn6OUI9DOs1MdxS5g4su87 w==;
X-CSE-ConnectionGUID: FEqOpFRgS3upOZmUnRkAdg==
X-CSE-MsgGUID: E5yzNsgyTlm8dnR7xM+mgQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="23807576"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; d="scan'208";a="23807576"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2024 10:22:34 -0700
X-CSE-ConnectionGUID: IvhTU0zwSCe0wBpWo1wKKg==
X-CSE-MsgGUID: iUq/13vqSy6CZes1fKxDtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; d="scan'208";a="33349277"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 22 May 2024 10:22:34 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 10:22:33 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 10:22:33 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 22 May 2024 10:22:33 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 10:22:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bF9td5dZ9R9inbrRj5p7K/Pnl/sYDUg23FeQmZMW6imjk1Xus3L78ZEFfRH++OUA7NRD62fULnSNnGeIC6KlgaPHEsV9IitoQo3WM+nf7+a9wCkuyPFtVQTSRBiI9ox8RCM5bZPXEsEDMhIN7Mo+O10IeWzxzkbLEmGMd7SYl1BC4jexFURpVlcLH84vSXZ5/2o+u/fbyRLsdL2lldscxdDMrKjJ/TQP1D1Sbmwv4UcxCw6nIfrL3dKGSrSxBWw8rwxCUpE85WukkEmkz+ihWN5C5k+FerMeHl7tIfzrc/ozP5yIvBC2fjHSyGrHmjw4MNySuc8+OD8+tdahaetHQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JztjAoXaVZGtyyYp/vZXAqW0KoLnQWlbnKfmstQbcjQ=;
 b=hUNBdoaO59Nsrd/XRU8pnRnJMFUjZF2X6Kb2S9Gw/M43mAfFXHmOcPOTcTW10dRyxlaZil+pMMoRZo8MmLlKIWPZOjgqQbLYZqFqu/s1Vw3RQXrj5JQn6RxC4yOKUf6T6p0oXLvddcguwIJ+2u9lqIlZeVjLdMgAogtAJJsIoCk/o70BPa9BhhAzUnLqqJQ70dp1HhmoHNQKFFD2IWnL7mxP/fAIq0dzEvTK/Serkzv8bMSP3YcU6WMnhhDwko4hXB4G+1gZ6/DvGQRN98DBcUWIiPEQL6whrC/3Tmcyp9QfGP6g07YL7yMRhxmha86EmneD8c93wH+m3pONN2zW0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5296.namprd11.prod.outlook.com (2603:10b6:5:393::22)
 by BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20; Wed, 22 May
 2024 17:22:25 +0000
Received: from DM4PR11MB5296.namprd11.prod.outlook.com
 ([fe80::a82f:27ae:a8d9:6a81]) by DM4PR11MB5296.namprd11.prod.outlook.com
 ([fe80::a82f:27ae:a8d9:6a81%5]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 17:22:24 +0000
From: "Brunham, Kalen" <kalen.brunham@intel.com>
To: Tom Rini <trini@konsulko.com>
CC: "U-Boot@lists.denx.de" <U-Boot@lists.denx.de>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>
Subject: RE: [PATCH 1/1] Added arm64 assembly for examples/api crt0
Thread-Topic: [PATCH 1/1] Added arm64 assembly for examples/api crt0
Thread-Index: Adqojlev93VX2sPCRR6waFJsm7XUJgC82DVQAAZzj4AAAJoS0AAAJBKAAAAadUAAAv2KAAAEUXCAAAc8cQAAHE4P8AAC35oAAAWjIdA=
Date: Wed, 22 May 2024 17:22:24 +0000
Message-ID: <DM4PR11MB52968E794BE8B0A882A519A6E3EB2@DM4PR11MB5296.namprd11.prod.outlook.com>
References: <DM4PR11MB5296B1B9F0CFC701A8B11284E3EE2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <DM4PR11MB52961423BCE12552857A12A8E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521162543.GU2568172@bill-the-cat>
 <DM4PR11MB529670F5CFDA6B4EDA7B7206E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521164659.GZ2568172@bill-the-cat>
 <DM4PR11MB529668DA50F05F26AAD229F0E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521181534.GD2568172@bill-the-cat>
 <DM4PR11MB5296769279BCDD505F614E6BE3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521234624.GF2568172@bill-the-cat>
 <DM4PR11MB5296918A0447369D6B27891DE3EB2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240522143908.GI2568172@bill-the-cat>
In-Reply-To: <20240522143908.GI2568172@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5296:EE_|BL1PR11MB5978:EE_
x-ms-office365-filtering-correlation-id: 09c87908-2b84-4e7b-9379-08dc7a83bf5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?o07IjEWoMeU6nUbNrU4bWMgEGhzlQAmtdLb9r9jriJYgerg7JfZ4vhWVimAW?=
 =?us-ascii?Q?TTA2getxaiZVWkDVkiz1uKMSe6DrdUx0uJB5SsSvzLk27C4jM3Poc0DxX8Sw?=
 =?us-ascii?Q?YxSSREyDvW2vxfLM0vqii0zYTEyAEpsRSowi6yknhj1jvvcusG93xRbUutUC?=
 =?us-ascii?Q?diTg2+7W+NxhlBPF42HR7E1sKHbkdkmVg50LJIN//jMDCObgJGtkQRqMgN0h?=
 =?us-ascii?Q?aiNV0nO/sa7uIz0k3zwB4QMWQ3d+DB9ZVls61V4dR9fWYlvzsj8FLMjyjETd?=
 =?us-ascii?Q?uRTQcCk5WLWfOmnCklOkSetZMnC31gtNS/1kzoB/E2HUD3wFFt6wolN0roRq?=
 =?us-ascii?Q?L0y3Z8UUYbiZhozzEtPdAlANudiTrl0c6ei0FK0KsH+scK552kZ60EPG91Am?=
 =?us-ascii?Q?WRMib7ZmgQulObIo0aXUA10n7KluEFdntIfXZoQk9tlNC1tiHTOr7dz9pZNU?=
 =?us-ascii?Q?YvQrXnym//9pNvZJiS2HEK0eeESuhl5ZiT9alQmGF9QJoY2aFiYA5lNdUEOg?=
 =?us-ascii?Q?rL8owq6IgKET15lYmL2E3mQr6ZNaHn3ia9BFGQO9Jf/lgyX7WYuVq94gn24A?=
 =?us-ascii?Q?FzMsCJF3J+vCzv/gAiDirvwhzxP72VNl9vgl25O2B12RuMq13yQ6FnLJzXG8?=
 =?us-ascii?Q?xvtfdGJrq9CI2VnTKUhUFDKUkaIGnaQijRNtjES9voGe1QCqyhlHrj/p4g7c?=
 =?us-ascii?Q?LvjhVW47V+IsYvSQkCfN79KXI5lUymMatGa8K+5pCJNVa34hT2sFkVbqv15F?=
 =?us-ascii?Q?SlqRivJ+lmue74fNs+UMpPPzHWNAVrjxZ0P+MeKhGDlrwFhw55R/pUejqy8x?=
 =?us-ascii?Q?ABwLbgJf+6c07XTrMjA9FnIzDdVGe6E3CGNEth9i/O0b/goUe5qIiyk+g1kt?=
 =?us-ascii?Q?cWrxkUZwQ6k1kCm0dszeTXN6TEo2xUTPdFglVSf/eatxM0LmLC4hfSWQlDnm?=
 =?us-ascii?Q?cgEP5s/VGnpD+EGr+OT+6xsfEwlf5wh90Q5pnsFKXjn5NITIqpRtcujVmHAT?=
 =?us-ascii?Q?ynN34YUlu3cGbhbkAgrXZb15xO/dIUHbnkFUxmmzxlyoNTMdjFpX1OUcAmAk?=
 =?us-ascii?Q?r+OcGFSjK5auYfA4c9He1Rdb3qzTr7SkFhLRPYoPGCWZsETbnGgG08dSRStf?=
 =?us-ascii?Q?hR+Etn9efT6Pn74IiQGR9ohF0xEpMwjP/JX8AkuiR1QZdNVr37Gv994y08XL?=
 =?us-ascii?Q?3Wa/PaoRoCVaLHIR3SQoEQVmi4FWO8oytf0ucCjkyhyDoTGpOwgwh/Y1wxJE?=
 =?us-ascii?Q?erF7lrzKcX8q2hi03XDg7LgQHnAhPepglhF150Rch3PZb063/5X776ua3Ty9?=
 =?us-ascii?Q?i+VSWnnEfqs00hMyAfpivYWiTKlELoetOFdTbF1ifHMY3g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB5296.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hr05e45LVIuknLghtyJ2f5jp3OtH9w1YWOGdvLkx3LYS/YL2EGXSNjJ9HLAO?=
 =?us-ascii?Q?/C58+b6cxqwLq1rwl+KK7FmmSpilZICqvKN4cIfCcxwZfkhn0xnk+rbwC77J?=
 =?us-ascii?Q?xfdvhY6bQNZKb0tXQf13cYedMZAHE/2P9ROT1IXXy1Gm42eSlt4Lz2X2SMRx?=
 =?us-ascii?Q?r0KB2JBlbaaBOgIkdPvcPM43cd54z5AFnmUBV3OdDBF3f9raJ5aSpsgt3qGU?=
 =?us-ascii?Q?dNortzajyt6el9EJSwpRLD8HEl+0hqgd+Lh5/yCqgCJvBrzk2R8+W6hJp3Md?=
 =?us-ascii?Q?C1LUlJmxvYn6O1/USUU2s+5txfKbS0an36ZZXPmxheWWwGU8EkPOFp1sD+6H?=
 =?us-ascii?Q?Sd8BIl2ry+vSoQdVJhIwCkckuvAbC2MwUBN82dpKhrTMCri8JR9KVvrOW7tD?=
 =?us-ascii?Q?6mK9UZ/T/8kG5LnXzkC5Wd1mBvDQTDNBVzjxxxAMiwzFviF4cLGD0fPv+qbg?=
 =?us-ascii?Q?kw+nWKoAC09VsDpXyJCH2cLhxEzb4ZW0rxFmCUymbhQNSx+XTbWy+nvFQbML?=
 =?us-ascii?Q?yu3X4yH4wp4dbr0eC8jLpMmCXeS0e7rltQ2vvsgWeSuatPsiOfIzKmjT9gYU?=
 =?us-ascii?Q?yiRSnZCjF64ay9r4dveKn/zauWzUAsfrElWGldJGa/eM29bFhhja4ZscM3xn?=
 =?us-ascii?Q?1j0j7iXUQQ4O6TpcTe9uWhOx5XYRCm9Mp+dNvTYu7ARDDN1Is7/Aw5W6hQlZ?=
 =?us-ascii?Q?UcBJxQlKB71u3dpbmmhE2jdwHjIyRqPNKbTj22cDbkcipXxz9mPJ6mHmxsE9?=
 =?us-ascii?Q?KEjucK2zA+grCJ4ND4vFVqcZc1C/K/hZZ4cqEdrziJ1TIS6nJ99ChBkLAMvW?=
 =?us-ascii?Q?xwnq5xs3jAXX+v2GBbY47Zw+73/utbgzmB0jZPnb1k2iX8lsYFQH0HXxS0Zr?=
 =?us-ascii?Q?fLCamUUydsdAjtMwhi2UICQXEs2ZZNJVD/rBnie36XH/kwKU1/emuZZ58dpw?=
 =?us-ascii?Q?AtRI/AJJ7zDM0qZvpMB+9cDqAwUHYH+fmFj7YOn1Q7vjONl52SKSMl8Sjb0j?=
 =?us-ascii?Q?eYoUu8jR5EpMwEc5f7NP2kATCz/nlP4uESxL7QFxskakDO4mJH2uc3igWoPH?=
 =?us-ascii?Q?bXs64osSmVXQUehCqUrzFDlJHC5xYOGm+9pZ+r4JP138ShUNZeKL0WZdJXn3?=
 =?us-ascii?Q?tXnC9OIK7fQWdyGAXSLJKVaLp1lnm0RJQgiyVM8aQNoCx2dvErv2eTZas6s9?=
 =?us-ascii?Q?vgHfRZO1lO775Hx090CBok2i+SvXwzsR9AnBfZx74XxpKFQ7HrrWhAWkP57/?=
 =?us-ascii?Q?9COyIm7TqHJNCk5tO+bYke8JDH2URcg2TxcTk/noRfwzQkO0eO4whpGw8M2n?=
 =?us-ascii?Q?p7bi4PpxAmT98YBHEoMe89NYOUF+YBdiYpgKu/cjKb6knY0S6bbStwBCnipI?=
 =?us-ascii?Q?ABFRvp8FsdH2BuBBggvXItY6PPnRrnCfU0OEaAMReuOH57TxNTmMVQ9ch2Wo?=
 =?us-ascii?Q?ReXSNUaxZQmbv4Jtcu6Pu9vq3dhwJvrUQI+IpqSLnC9FGrxfKZcxF9+jWMiB?=
 =?us-ascii?Q?5vKlHXRgCVr3HTOF63BmaqBBVHg33y0BUEEoNOP3eXnxialxMum+LwWdEqC4?=
 =?us-ascii?Q?pAu/rt228AqdXvKOZl6C3t3nCrG8RUHexBwA+8E1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5296.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c87908-2b84-4e7b-9379-08dc7a83bf5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 17:22:24.9318 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YtDYUVl7DU1hfdtsWzWz3i0TKZmhUi5xge7I1tqPUDGhnvDZsu0UZhZrgpZhTzjlYQ9Yk0/aLcfvY3DQuk3OFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5978
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

BLK is currently a dependency for EFI_LOADER as shown in the snippet from l=
ib/efi_loader/Kconfig below. Perhaps the question is why EFI_LOADER require=
s a block device? If I remove this depends on BLK line, then I can enable E=
FI and successfully simulate the EFI hello world on my test design.=20


config EFI_LOADER
	bool "Support running UEFI applications"
	depends on OF_LIBFDT && ( \
		ARM && (SYS_CPU =3D arm1136 || \
			SYS_CPU =3D arm1176 || \
			SYS_CPU =3D armv7   || \
			SYS_CPU =3D armv8)  || \
		X86 || RISCV || SANDBOX)
	# We need EFI_STUB_64BIT to be set on x86_64 with EFI_STUB
	depends on !EFI_STUB || !X86_64 || EFI_STUB_64BIT
	# We need EFI_STUB_32BIT to be set on x86_32 with EFI_STUB
	depends on !EFI_STUB || !X86 || X86_64 || EFI_STUB_32BIT
	depends on BLK
	depends on !EFI_APP
	default y if !ARM || SYS_CPU =3D armv7 || SYS_CPU =3D armv8

Thanks.=20

-----Original Message-----
From: Tom Rini <trini@konsulko.com>=20
Sent: Wednesday, May 22, 2024 10:39 AM
To: Brunham, Kalen <kalen.brunham@intel.com>
Cc: U-Boot@lists.denx.de; Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH 1/1] Added arm64 assembly for examples/api crt0

On Wed, May 22, 2024 at 01:25:51PM +0000, Brunham, Kalen wrote:

> Hi Tom,
>=20
> I'm using a defconfig that does not enable any of the configs listed on t=
he default likes for config BLK (MMC, USB, SCSI, etc.), but I do have DM en=
abled. I cannot however enable BLK as CONFIG_BLK=3Dy is ignored. My current=
 hypothesis is that BLK is being forced to N by the select BLK in other Kco=
nfig files, but I'm not sure.=20
>=20
> Here's the Kconfig for drivers/block:
>=20
> config BLK
> 	bool # "Support block devices"
> 	depends on DM
> 	default y if MMC || USB || SCSI || NVME || IDE || AHCI || SATA
> 	default y if EFI_MEDIA || VIRTIO_BLK || PVBLOCK
>=20
> My current flow is:
> make mrproper
> make socfpga_agilex5_defconfig
> ./scripts/kconfig/merge_config.sh -O ./ ./.config ../../my_uboot_config.t=
xt
>=20
> Here my_uboot_config.txt hsd:
>=20
> CONFIG_MMC=3Dn
> CONFIG_USB=3Dn
> CONFIG_DM_MMC=3Dn
> CONFIG_SPL_DM_MMC=3Dn
> CONFIG_BLK=3Dy
> CONFIG_EFI_LOADER=3Dy
> CONFIG_CMD_BOOTEFI=3Dy
> CONFIG_EFI_LOADER=3Dy
> CONFIG_CMD_BOOTEFI_HELLO_COMPILE=3Dy
> CONFIG_CMD_BOOTEFI_HELLO=3Dy
>=20
> The only way I was able to get BLK set to Y was to add another default li=
ke || DM_SPI_FLASH, since I do enable SPI flash in this config.=20

And why are you trying to enable BLK without any block devices?

--=20
Tom
