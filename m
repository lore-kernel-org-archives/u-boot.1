Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A05C54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 06:27:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BBAD880BE;
	Thu, 28 Mar 2024 07:27:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="gfQjwrMk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DC21880C0; Thu, 28 Mar 2024 07:27:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B774687F65
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 07:27:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711607276; x=1743143276;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=DTLC3aNguCnL6kmD1n4/wA2WJgsQXzwzjF6vHv3n3Oc=;
 b=gfQjwrMkjTDTgKPt7jAYFVLbDV+nwH9xuPn/QGfJ9gAwWvU50VHWsi8f
 jn8Wh6VDv1/4i8prjj3eSdzXDmm1cQ4LunNt8UDW32jYgK5cDak/CME9r
 KJvBh2oORNZDFHG8XiqwDjW9RN2e1twJaQx8nmrfyRlnVYZjjVAvrE3Pl
 kjlUuqp9QhjEDzGHBW+XdSjMDeSHRhUAwIh09joP9hLOt7E+lq5r1ccmW
 GknCQfUC4hAfGN79zdEcb41ypOpPSStzfeb9iS2a+H1FC6eAqci8ye+tA
 /LhYfEyRR7i+E4U4csAH1Dko/HNTzBKFdIG5JjpOjlN8FPwkHO8po9+KD g==;
X-CSE-ConnectionGUID: lzHCoiHvTxuNazAGDEsGCg==
X-CSE-MsgGUID: JW6trFmpTWuwstyXSu/Hbg==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="29224563"
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; d="scan'208";a="29224563"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 23:27:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; d="scan'208";a="16575243"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 27 Mar 2024 23:27:53 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 23:27:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 27 Mar 2024 23:27:52 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Mar 2024 23:27:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FuuHWnloglu+YnNdr7Z4sa4tB6TRcUmMltW2CrE/VINRNyABz6vKHTSr0lraPgM3Be6lEf/PYPR7xGfrD3e64i6QWGDeV+UZvM4Wjmopf8VVuoyoXlx0/iYOUFYmZommftXGI8xabcE9oH7sxqWOmQa8UQDwn2qZ8T0KTUL2Zq7UtFoZ1YLnhr6RFB9MKqa02L/x8L9nGMs/wGTjUBBsPZldbWHSH1/KNjWsq1wVnTN45D9eptsuhiS4LnJIgZPtL9b9UzD/VRc7D+hJlN/bgtucqqdAqa6cvkEqZykLsJCYms43b9QXshVUlqekNQDEzBUaXUdE1h5OAjd1vO1lyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vI8znZ60/vn4oALC0PghgvetiI6+mYTQuLLZom3Ov5w=;
 b=eAHyESKrhj4rIT5XHoxknvIOiWWzkjINU6OFe//gcmGtvgQt+Bqag0cmlFpaBla5QZQ8WXb2K1ZNmL+joBm/IclO8PCj51ZfyYsDv2F6OZJREDJFNlDTqBOSJej3awYWzcLBggjx9YDfjMAyrY6PqvPaPzFPfecYXuMoLLsCLXik5mq34CqBgkWmWA9RWRsD09V8iUfC80XMGjGHnQLhm4fAj4pAx11Z6yOrEzfTmWmuIwWOilYF2KbrPtys6OzvqEmzEb+V128yvNGaQEiyxXCpOKjnGqsNkq8N+UO7YWyn0OICggcKNtrh/gWSGF5S67Nq3m8z7uzenV0XlhrsRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5593.namprd11.prod.outlook.com (2603:10b6:510:e0::15)
 by DS7PR11MB6104.namprd11.prod.outlook.com (2603:10b6:8:9f::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.33; Thu, 28 Mar 2024 06:27:50 +0000
Received: from PH0PR11MB5593.namprd11.prod.outlook.com
 ([fe80::578a:c773:871:ca82]) by PH0PR11MB5593.namprd11.prod.outlook.com
 ([fe80::578a:c773:871:ca82%7]) with mapi id 15.20.7409.028; Thu, 28 Mar 2024
 06:27:50 +0000
From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
To: "Lau, Wan Yee" <wan.yee.lau@intel.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "Chong, Teik Heng" <teik.heng.chong@intel.com>, Marek <marex@denx.de>,
 "Hea, Kok Kiang" <kok.kiang.hea@intel.com>
Subject: RE: [PATCH v1 1/1] [U-Boot] drivers: misc: Fixes: Rename
 CONFIG_SPL_SOCFPGA_SEC_REG to CONFIG_SPL_SOCFPGA_DT_REG
Thread-Topic: [PATCH v1 1/1] [U-Boot] drivers: misc: Fixes: Rename
 CONFIG_SPL_SOCFPGA_SEC_REG to CONFIG_SPL_SOCFPGA_DT_REG
Thread-Index: AQHagNjQ5qQu8qYrj0KEMvYBXFeCZrFMsFYw
Date: Thu, 28 Mar 2024 06:27:50 +0000
Message-ID: <PH0PR11MB559383F746B017875C6D61B5D23B2@PH0PR11MB5593.namprd11.prod.outlook.com>
References: <20240328062400.11208-1-wan.yee.lau@intel.com>
In-Reply-To: <20240328062400.11208-1-wan.yee.lau@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5593:EE_|DS7PR11MB6104:EE_
x-ms-office365-filtering-correlation-id: c1203ffd-fd03-49ce-4423-08dc4ef03108
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N8fBcxVWM22ky4sNwDO0sH/8KbKiJHn3IRgIJeb3d+oL1W4eLidwW0UmqaQtwoI74VoKgynjnGPNro3/NJCn4k/q4EqHDJ20F1/bmIZ0rFDwseVPIiWHX2dzrsTOG7fabu/S+HTn1QnhWDx4nIEVGY/XMQ5PzheqqN0FwuXw3HTJ/JtdsnKi2LAQPm8GCX/zku6gj+sifMPIhLhFC0+psOrP2F5bUNxx0nHosrdZ7hIy/HQqMH6zzry8oksAgFhPciu3tLagYt58OUOdtLYRteTEZWa4FSk3ySzpVg2OewqgCwQcQwd1oltGuJkpzc5Z3462NkBZUgSjtPMhuROb1/TktBd4lfUVM8hqAaRd4cF6yqKrFCI3C8GrKUnWESU5J69UWhktc/ed1n+wApMOC2Y+8lueGLITi1yVE6aZoFzaJUcY7QnP6taHHh8H90KxWfr+7kzJriG4ppj8QxhUablmD+IjiaA8dP/2mUSsXw1a0tfa+Vi77Cdn9nQygj4RM2yDoD2Muei1FHGrYOaH2wRA2v4s0q8k+coTfCQ+pgBmMIk0dGZcGgE/6XVqR73vN8UaL1GeQTeNvUgjgtbNdQnAqEZFQd8vtHsIOh7LBOPDP9xyGUyehyHyFZYU1TaKdf/rljaT8/+iivOIRh+fC4ntdNzAXSBzC62de7rWROoVyFC8XLh1531ePeWO0tkvjzNOLiUwUBc7GGMJyTRyEtRWh00TwHVyEzjMcUHQ9es=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5593.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fp3whyanjavHUS4h/M+/V+2IzZK0wU67sq8S5UPlnCAj4t0k0EptfQbj1+VX?=
 =?us-ascii?Q?7u70HIyAAKB+uu3qCj1V0bLr4lkCX3+MxngQDopFWlgyj1Gl9DbxgjleUXbQ?=
 =?us-ascii?Q?Z7POjwQRtV9HhB+cv2XMe6LbqNd8E0yLxFooJMf5G7A3jwoWHnClxPNTP9Zq?=
 =?us-ascii?Q?mr860USI4rxTS8K6uZjFnzNgyZYtLuop9okJPXcuTLlultw/xpUg872PFztI?=
 =?us-ascii?Q?n3Nrro/WKAuRt8hy+4KYydkg3wFZ8x2c8+0IZ9e9+iCscG2sx9MBNvEC3eeo?=
 =?us-ascii?Q?O2k7UYW5eBkU1PnjZaIbtNvriEW0qA5myv8GX4/0NZoLdU7LwUKTmyfPt82Z?=
 =?us-ascii?Q?w7hyWgG24HVcKGSXv8+ymm82vEGstw+uvdZubCro0DedlBg1AXIFzGKI0cF9?=
 =?us-ascii?Q?dATYNmZKdDM/5KCwpscNyFfwrv1mYJo6Bnt4Bz7oCbUTgFw127t4MdNS88d5?=
 =?us-ascii?Q?bbP76ujJyZrc9SSsizHnEJxqXOTxuB/Zqt65rNMPSedUFCkpFfeKGNsIOg7z?=
 =?us-ascii?Q?MYRnMI5Mmjnf+Jyl2zQMq5JQfxwGmYdwisc1vcXRwc5B/RcGtkyV0VnP3uZ3?=
 =?us-ascii?Q?0EyiN4k3wbQm9N60WcGZWdDGSrH9kINCdSwHwbMQsIaSEI/ikdToVWaTCsEt?=
 =?us-ascii?Q?dAixabjV42nXe/sOuMygQNtJaMKhdxsxXR2oh8GeP4jOinMcLRI5hzzmj+u/?=
 =?us-ascii?Q?U6DA0P0vls/twkNkB6v+GaMSIY1PkcSKR0EZLnqf77S8MO+DeMyPYIpBlIK/?=
 =?us-ascii?Q?YDeiWHpi9MPViPV3W8x0SuNnYHh7L4PEIlGvXFoHe+/ugxyfiF/LHb6khYBL?=
 =?us-ascii?Q?Ie6OiNry279Bv9dcbh5m718lk5/kH6cL1DOAbxVb/KMtBE36GEfaKW+AO9q+?=
 =?us-ascii?Q?5Xi0FAYqDXneBc36Fo/C2ZCgbzNsk6e/3A7Irzkwq/huHw/vuyZ+iRvXx/Ud?=
 =?us-ascii?Q?oY8W+OjwmGcTYKq+8Qlgr2oe7YTVfy4rnEp2tfeSBiGTBjHjXEex9P7iZkqS?=
 =?us-ascii?Q?FVOwH49osocOFZ+ay70HItXwvxFO+LZhkFiNRQLG9B2RR/9NehT/smC7oi64?=
 =?us-ascii?Q?R566bdYVNJ0WCtLrw1+IxAX/mObDgjuzYRBql4EoxnwagKRSbaa4gZ8fLfA2?=
 =?us-ascii?Q?HwN447omq/+M8Eb+FNB9hkpePEf+Yj3uEwjNiGnQDQka4RRLYJLBg2o+uLdz?=
 =?us-ascii?Q?UIgID+ny98v3n4sqCeOzfuMP/CnFoGsIZURTdb/SfVoTxr36XPQzmjUSQerl?=
 =?us-ascii?Q?EBOWz0avJu/UK25/49i1AJp9DstMKAFTwrbwORVQtfjgvO4gYpxhdSOBH2ZZ?=
 =?us-ascii?Q?q3mAeN28V6mH3Euq4saWf7dclwJokmaoQ5/0IBmxN5dNNYR6iJkTw/fM0TRY?=
 =?us-ascii?Q?TlasQkMBZOhMmZuYnR3xAo6thaNGT7l4jMticX1VtM82Vi2QXYZqVB8rqkEK?=
 =?us-ascii?Q?MVDJqXsEnknuBGszuHJq0nWSykvbNX4c7HPm87eJ2gBozsu3KT2G65v3FbWr?=
 =?us-ascii?Q?6NZBwamlRiX5yOXVvVv2uwcrNcLYKO/q19BHq9SKNVEVlKtewEwCkNvZERDC?=
 =?us-ascii?Q?eQwDjg3kyZLCGKuBJrpIzaaKPwu6l6L4q7+WtMdO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5593.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1203ffd-fd03-49ce-4423-08dc4ef03108
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 06:27:50.1183 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qUMGxpk2PekSzKYSoQN0jKIN0UL0mqm8nKDU9OIc0vcy81kJAbr/zacs0OucOxR8m5zm6wMczlMhNFAR9RW9YqG3ITu0g4mzbN/4pSclQgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6104
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
> From: Lau, Wan Yee <wan.yee.lau@intel.com>
> Sent: Thursday, March 28, 2024 2:24 PM
> To: u-boot@lists.denx.de
> Cc: Chee, Tien Fong <tien.fong.chee@intel.com>; Chong, Teik Heng
> <teik.heng.chong@intel.com>; Marek <marex@denx.de>; Hea, Kok Kiang
> <kok.kiang.hea@intel.com>
> Subject: [PATCH v1 1/1] [U-Boot] drivers: misc: Fixes: Rename
> CONFIG_SPL_SOCFPGA_SEC_REG to CONFIG_SPL_SOCFPGA_DT_REG
>=20
> From: Wan Yee Lau <wan.yee.lau@intel.com>
>=20
> Commit 3f190c55a4211215914126b74357344342329943
> ("drivers: misc: Add socfpga_dtreg driver for Intel SoCFPGA")
>=20
> This commit rename CONFIG_SPL_SOCFPGA_SEC_REG to
> CONFIG_SPL_SOCFPGA_DT_REG in Makefile.
>=20
> Signed-off-by: Wan Yee Lau <wan.yee.lau@intel.com>
> ---
>  drivers/misc/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile index
> 1522f6c3b7..5bb1b315cd 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -90,4 +90,4 @@ obj-$(CONFIG_K3_AVS0) +=3D k3_avs.o
>  obj-$(CONFIG_ESM_K3) +=3D k3_esm.o
>  obj-$(CONFIG_ESM_PMIC) +=3D esm_pmic.o
>  obj-$(CONFIG_SL28CPLD) +=3D sl28cpld.o
> -obj-$(CONFIG_SPL_SOCFPGA_SEC_REG) +=3D socfpga_dtreg.o
> +obj-$(CONFIG_SPL_SOCFPGA_DT_REG) +=3D socfpga_dtreg.o
> --
> 2.25.1

Reviewed-by: Tien Fong Chee <tien.fong.chee@intel.com>

Regards
Tien Fong

