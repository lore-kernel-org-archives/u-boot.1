Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B1FC3DA6E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jan 2024 13:16:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCA0A87949;
	Fri,  5 Jan 2024 14:16:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="B8Z+0LYK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49B8687575; Fri,  5 Jan 2024 02:54:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50831876C1
 for <u-boot@lists.denx.de>; Fri,  5 Jan 2024 02:54:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wan.yee.lau@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1704419684; x=1735955684;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=COKa+/wpX98Eotn6jR7faKhDy0gR4TkR9oCTfBLp2yE=;
 b=B8Z+0LYKq500q7YgZ7G5V9v1tQK6YGhG9IDYxfVPdLOl+DvYax7Yax2S
 bjndhVtOxX7DqAXuGBQYCLiGMOZQF50K+Ti9lK8FlgmLj8zCkUuv9bPaE
 3Ziq+P4LxCTZFbiNC/KQc2vED3jZhDCEyFlxUl0OsPfAEPgCe1OVqPsyL
 F73+qg/VaDsLgjRek7ARfaU+mgCQfxTQTgg5Nia4fIYPoWnvCkMGVUzM4
 CgTtlju6EhVCwcBb25DhGTKGs0eFlzPlo5UePi9B3kHV10rCtBATYa29I
 Ablxwx+eNb3lVPqBODOjAJ43JWflq9UWOw66PksTw30zPxbp+cnQOZWCk g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="4225341"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="4225341"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jan 2024 17:54:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="814816864"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; d="scan'208";a="814816864"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Jan 2024 17:54:36 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 17:54:36 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Jan 2024 17:54:36 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Jan 2024 17:54:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJBpvljoumCVN0hGdvxW8klCzoc+4q/PuSEqVdT35fheLy5Siv2c71xbP9bK+u8kW1zITIS585xgpIrfFMM4KDyNK5d4ur2IZYFbQfIkE7W4LpdZtIxM4HF8IVCBAZCk7X4Y2v90Z9BiUnmCgJamLVLe6qrRkGe/Fd82q5fylMDeoutvEglNCzI8Z4DRLrL5QnB0d68GNDoT+iIZ6kBoFNmgzBX0Psvi5f6jEMpyWZGSvG9U3xdLOC+WXbjfr+SXcgN/yNgZ+Q3IaXDJmoYFbQX4dkYhhtotkxJ0H0fpDA/Di+EoT0BnUpqVWJtmH9wGq+o5diubKmqtSwvFZTnBwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jzt4hPu3n1Me896RSCep9JW/3qzzgSNp+giH1X4076c=;
 b=cH9OpVunRLq3Fxi45mCORRkApg/qT8fnkR/w6vzuACC/x6s8IUbASMiM9rJlk4xSGYEe4/LSsvXe6kXtFTeM2oUY5OwmpsbykUhZK5Hc77TtylmyT4DZnLoVgopy1FPZvjk2dEXXaZ2iRVTZGSqM8RxHAOjxLPN22FdRe4PHcdescwpZ9ecXEJWVRfFDalBVCkk5BRwXekFL71uryENaBT7t5VtxYTsOBkaLPsRe2BYIgiwMD+WZvBaIPb1ddfv5jCMmzGbJNCE+9D3TB/lYyNI4ro0J1bmVkhEu5I4g1Qn1fTU0kfCfRgOdEax23PpybuNqp/bF+w9v8ZMRspAisA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW3PR11MB4553.namprd11.prod.outlook.com (2603:10b6:303:2c::9)
 by PH7PR11MB8599.namprd11.prod.outlook.com (2603:10b6:510:2ff::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Fri, 5 Jan
 2024 01:54:34 +0000
Received: from MW3PR11MB4553.namprd11.prod.outlook.com
 ([fe80::5e77:986f:cc35:9028]) by MW3PR11MB4553.namprd11.prod.outlook.com
 ([fe80::5e77:986f:cc35:9028%5]) with mapi id 15.20.7159.013; Fri, 5 Jan 2024
 01:54:34 +0000
From: "Lau, Wan Yee" <wan.yee.lau@intel.com>
To: Tom Rini <trini@konsulko.com>
CC: Marek Vasut <marex@denx.de>, "Chee, Tien Fong" <tien.fong.chee@intel.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "Hea, Kok Kiang"
 <kok.kiang.hea@intel.com>, "Maniyam, Dinesh" <dinesh.maniyam@intel.com>, "Ng, 
 Boon Khai" <boon.khai.ng@intel.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@intel.com>, "Chong, Teik Heng"
 <teik.heng.chong@intel.com>, "Zamri, Muhammad Hazim Izzat"
 <muhammad.hazim.izzat.zamri@intel.com>, "Lim, Jit Loon"
 <jit.loon.lim@intel.com>, "Tang, Sieu Mun" <sieu.mun.tang@intel.com>
Subject: RE: [PATCH v1 1/1] drivers: misc: Add socfpga_dtreg driver for Intel
 SoCFPGA
Thread-Topic: [PATCH v1 1/1] drivers: misc: Add socfpga_dtreg driver for Intel
 SoCFPGA
Thread-Index: AQHaMklyixczvViI4UynCR3WXVD3cbCwXhiAgAEgnFCAANrwAIAAopIQgADSloCAFr/LAA==
Date: Fri, 5 Jan 2024 01:54:34 +0000
Message-ID: <MW3PR11MB45535668EDBDDD0F191D471CB6662@MW3PR11MB4553.namprd11.prod.outlook.com>
References: <20231208083726.26906-1-wan.yee.lau@intel.com>
 <DM8PR11MB5592CA687BF05641806BA22BD297A@DM8PR11MB5592.namprd11.prod.outlook.com>
 <edccf82f-2c65-4f09-bd9d-f94765ae015d@denx.de>
 <MW3PR11MB4553AD65903767C338B8E43AB696A@MW3PR11MB4553.namprd11.prod.outlook.com>
 <c85be092-64de-4bac-842a-b7d1d4587d84@denx.de>
 <MN2PR11MB45528C0C90F9EFCF41312795B695A@MN2PR11MB4552.namprd11.prod.outlook.com>
 <20231221142629.GG2513409@bill-the-cat>
In-Reply-To: <20231221142629.GG2513409@bill-the-cat>
Accept-Language: en-MY, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR11MB4553:EE_|PH7PR11MB8599:EE_
x-ms-office365-filtering-correlation-id: b447163b-f0b6-4ed5-6045-08dc0d9143fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 076rcwYLFsQz3xfl5A4WGVazaYL/CQ9QB/t71MWJl+4r75pz9B1JMxqg0ECWYHZPsnv/5zn6WEiocsXyZ3EDwyA0E+nxrUTDenMStts6o4SDa1B3A90G0wc28eeMAYMnKz/4hBoDP8Yd5jKZi42OPEwM5UImu0ABUSNJNQHE+vlNv0LObgyWN3ceBgkSzj5w27DWE1Cuq7DK1uGyj19m81enP60cxdnYsXJhi0rgug01ByLBDiFYgnCeoLvuOYumGpbwqfkZIYv9FxOXB2rKC6a3U4tQQrDSsmlel2YK/DmpV/2PjpApguOCv8heQCzXEjKqRrPhtACVkwdHnKSOCx13sN/MbWGCsHHLBEdU1hK6haporGrUWHtnM7f1Kl2eMFyWTBXmSf9BnBj34KWoWlRYJ+DkOKBdo8ZxboDL1Q+93UngT67UdTMtuELZL4gLgaJIX+2Psh5XgiOCZZtus2yuo2NFkZUSzbh64qKH9tbWXBE+nOYKAucdBoy46q4fr5tp8KTYHdNaPqqC137vyubF9jgvW9+KzVWZMTdX49nR8GAHCSnfUgTZ64qICj7jthC34xN1bkhWT/Rd1vhxTsWiCHlFnipjpfjMpmKZoD8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4553.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(346002)(136003)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(55016003)(33656002)(7696005)(64756008)(38070700009)(66446008)(76116006)(6916009)(66946007)(6506007)(66556008)(66476007)(86362001)(53546011)(9686003)(41300700001)(38100700002)(82960400001)(26005)(107886003)(83380400001)(122000001)(71200400001)(316002)(8936002)(2906002)(52536014)(478600001)(5660300002)(4326008)(8676002)(54906003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rUjVyuOgw5eSYkTFTtwaL9H6fvwk1WB+aEdWq7x/MO6uHpYkx/c8pjxB0i2e?=
 =?us-ascii?Q?Uqb5vyeoPyGvOmug6YzvtzuoBntLLM38BmQh39QuVeTKnhNzGWSOULFdRJxr?=
 =?us-ascii?Q?snNQw17N9Py1kJ5vW4tv8GgnukZOez43cABa10Is7oSXn8dwwjgmyF5Drv2/?=
 =?us-ascii?Q?X4dq7aG2iaYWrgWxeWzk83lPKVKbePM5JDXu1/fWLD8YA83SQdvJSWUXOudE?=
 =?us-ascii?Q?DI2+tjrM0RioF7k3h4DffztewT6DsQfKk5McbrUQx4+Nygpcj9clMrXxn9VR?=
 =?us-ascii?Q?ixJ+U8vflAPaRNq1dJUnLAmDiKEI+gqEeIx8YvSC6jYIltHWkzMKiq1n1ent?=
 =?us-ascii?Q?CO2UktjvIf3I3RMzt3XY0DMTbMaqvmizgmSUubNtIuplWLcqeqAA6oNLOvr2?=
 =?us-ascii?Q?nIgVYAChyKtqThPabdwpY3lGbqeBDpMsXXqFhFXCPV71QBLKIlb4Ks8TwDDe?=
 =?us-ascii?Q?dNGtSFRncLWwkOV00hFiUXDH5/fLuFzGxJslYoKrfAC4GOSJq5TXuEGSYISb?=
 =?us-ascii?Q?iB8gcjqEFuWlc4sIxDg/T6PfYjTjSoIWxuxmYUay24P4Z3mWoZA/n2XDWepH?=
 =?us-ascii?Q?Dl4+OI4d2JR+fCkRT6Pk1sKrL1HH6TBpEhLHU2oCsit5XANj+n+d4c/V5NIt?=
 =?us-ascii?Q?y/asCVAOK39pGNROH0vD2PlNcZMSButVNsJyrKqJEMFdV7YfRGqe1Js9hnDP?=
 =?us-ascii?Q?cZiZp/pnbECEkh3y4aUibJQLzHlWt3VD+f5kn+/8efVpneGotq6GCxV9JJnj?=
 =?us-ascii?Q?rqqoE2d9dcReECemcy9UI2HkfSQhG8LUJwZypmc26eIRIc5BSfcZJr3G6xuR?=
 =?us-ascii?Q?7R9QLR1UT9jKpAJInjhy4xCWQXht7SRuwJYqy6XgkK5JyBSRME3wR0S1C4Wt?=
 =?us-ascii?Q?jtOJnJQ9q+TJqGYTTKaD09cLRalCq1OiZT8r42Q3R9nT0xGEAL9NKN1eDdls?=
 =?us-ascii?Q?QAFbR/LCt0thiwwvalW9muOaocvWC7UVy1C7XmZFlU2KOVNgEEx6eyt4JoPI?=
 =?us-ascii?Q?XmckVii89RgpR4Axuux3ONE+NIFCRhtFFU/2+qcQis0DUzgfU37tvHeSkO+f?=
 =?us-ascii?Q?iONG6L5wvB4OIzMRpcDtpbXnEp5dwEChugfaOpZKeqCRfnU6E/m2sW0scpex?=
 =?us-ascii?Q?I2wTYtgA3uYisC+mOT/qZYe+T9QuwE4S0sXQYjQs4oudD5JLjSaOyF1CAYrf?=
 =?us-ascii?Q?JbbQeuXP17ngmn/BaDlnWLsdhGJpEPiakAfKsa45A5cp750EPr5NDHKRGQ7+?=
 =?us-ascii?Q?oEF7HrGUwYfeS/FDlqNWJYXWjekOooaOLHi1oWEyWRf/9GHVpCZy4E4rLRK9?=
 =?us-ascii?Q?wQfL8K5D+Hpf37h9MuvUNF0h3M6X2R0+MA2aYJ26Wz4OER9j0xKWozUHdoph?=
 =?us-ascii?Q?bL3dUojMsO3LcUQslFBrSKLbH59kjkVVbbDzs67z/WEngthFyMUUKqhRwJoY?=
 =?us-ascii?Q?WtwU9gpiv5NgAxjpiWRYPXbdJX0TJ+MWg8Fz6Oz8Ay1NIxF3HML2BgDyhpm9?=
 =?us-ascii?Q?1aMLMgNIDcCCPwW6EGUWJt7lgiOKqMKg/S58x+xsEoM1ZXj7z0do/CWoNAz0?=
 =?us-ascii?Q?OZuml9Je2sA8CXYfNrXgZ14bjUQ4jqWcHI93SWTQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4553.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b447163b-f0b6-4ed5-6045-08dc0d9143fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2024 01:54:34.1292 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K9DwmRbTsl9/s0u0K+jwpHDJHX95PzgW2yXdWscLQ5T6tGrt4h3J2hLtmJKviEjnQ6oMJ/b+BaxqV/c7/OTKZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8599
X-OriginatorOrg: intel.com
X-Mailman-Approved-At: Fri, 05 Jan 2024 14:16:22 +0100
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
> Sent: Thursday, December 21, 2023 10:26 PM
> To: Lau, Wan Yee <wan.yee.lau@intel.com>
> Cc: Marek Vasut <marex@denx.de>; Chee, Tien Fong
> <tien.fong.chee@intel.com>; u-boot@lists.denx.de; Hea, Kok Kiang
> <kok.kiang.hea@intel.com>; Maniyam, Dinesh <dinesh.maniyam@intel.com>;
> Ng, Boon Khai <boon.khai.ng@intel.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@intel.com>; Chong, Teik Heng
> <teik.heng.chong@intel.com>; Zamri, Muhammad Hazim Izzat
> <muhammad.hazim.izzat.zamri@intel.com>; Lim, Jit Loon
> <jit.loon.lim@intel.com>; Tang, Sieu Mun <sieu.mun.tang@intel.com>
> Subject: Re: [PATCH v1 1/1] drivers: misc: Add socfpga_dtreg driver for I=
ntel
> SoCFPGA
>=20
> On Thu, Dec 21, 2023 at 01:59:02AM +0000, Lau, Wan Yee wrote:
> >
> >
> > > -----Original Message-----
> > > From: Marek Vasut <marex@denx.de>
> > > Sent: Thursday, December 21, 2023 12:11 AM
> > > To: Lau, Wan Yee <wan.yee.lau@intel.com>; Chee, Tien Fong
> > > <tien.fong.chee@intel.com>; u-boot@lists.denx.de
> > > Cc: Simon Glass <sjg@chromium.org>; Kever Yang
> > > <kever.yang@rock-chips.com>; Bin Meng <bmeng.cn@gmail.com>; Jonas
> > > Karlman <jonas@kwiboo.se>; Jean- Marie Lemetayer
> > > <j.lemetayer@kerlink.fr>; Peng Fan <peng.fan@nxp.com>; Vladimir
> > > Zapolskiy <vladimir.zapolskiy@linaro.org>; Konrad Dybcio
> > > <konrad.dybcio@linaro.org>; Simon Goldschmidt
> > > <simon.k.r.goldschmidt@gmail.com>; Hea, Kok Kiang
> > > <kok.kiang.hea@intel.com>; Maniyam, Dinesh
> > > <dinesh.maniyam@intel.com>; Ng, Boon Khai <boon.khai.ng@intel.com>;
> > > Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@intel.com>; Chong, Teik
> > > Heng <teik.heng.chong@intel.com>; Zamri, Muhammad Hazim Izzat
> > > <muhammad.hazim.izzat.zamri@intel.com>; Lim, Jit Loon
> > > <jit.loon.lim@intel.com>; Tang, Sieu Mun <sieu.mun.tang@intel.com>;
> > > Tom Rini <trini@konsulko.com>
> > > Subject: Re: [PATCH v1 1/1] drivers: misc: Add socfpga_dtreg driver
> > > for Intel SoCFPGA
> > >
> > > On 12/20/23 04:09, Lau, Wan Yee wrote:
> > >
> > > Hi,
> > >
> > > can you trim the CC list to relevant people ?
> > >
> > > [...]
> > >
> > > >>>> +++ b/drivers/misc/socfpga_dtreg.c
> > > >>>> @@ -0,0 +1,117 @@
> > > >>>> +// SPDX-License-Identifier: GPL-2.0
> > > >>>> +/*
> > > >>>> + * Copyright (C) 2023 Intel Corporation <www.intel.com>  */
> > > >>>> +
> > > >>>> +#include <asm/io.h>
> > > >>>> +#include <common.h>
> > > >>>> +#include <dm.h>
> > > >>>> +#include <errno.h>
> > > >>>
> > > >>> Please move <asm/io.h> above to here
> > > >>>
> > > >>>> +#include <linux/sizes.h>
> > > >>
> > > >> A good starting point would be to have socfpga 64bit maintainer ,
> > > >> without that , these patches are only being archived .
> > > >
> > > > Hi,
> > > >
> > > > Is only one socfpga 64bit maintainer needed or the whole socfpga
> > > > 64bit
> > > maintainer need to be included for this driver?
> > >
> > > U-Boot currently does not have any SoCFPGA 64bit maintainer, that
> > > needs to be fixed .
> >
> > Can you share the steps on how to get this fixed? Is there a guide on
> > how to add/process new maintainers?
>=20
> Well, the first step is to identify someone with familiarity with SoCFPGA=
 and U-
> Boot and time to spend in the community.
>=20
> --
> Tom

Thanks. What is the next step after identifying the person that fits the re=
quirement?
How do I proceed with adding the new maintainers.
