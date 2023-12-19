Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55473C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 07:07:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCE0086E05;
	Tue, 19 Dec 2023 08:07:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="BIfE6jo2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 010B386E05; Tue, 19 Dec 2023 08:07:06 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E0FE86BFA
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 08:07:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1702969622; x=1734505622;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=q7WtxZ47iKj52BHyko/PrWE6rZBdbbV4qTXi20nHYbs=;
 b=BIfE6jo2i9vpa2hFvq8MTgrLRJIsE8wYkCLJS33X5P3TLzBnAnea9wN1
 WaKRny2t6ikemSFjgtaZ8ou5U8/v8MobzP+CDw2GDj887jUr8soDPT2ds
 w+MM2VarKRzQNQh/CQ+W0mWxHUD+oQtJ4GvmzRv31wMcYHVCb1Edb2pvY
 b/ImRUgxz5GAiEHGTvackNY2q1jber4ZnnwAsythja+Uos9k40i9FU++8
 mDj13vmipNGl5BzUsT45SNdKp9DaKTzKVWcDFpEhGeKTYExy5x0Mz4oLk
 zvvSzYrnxCaJV9ZCFQfZMdQ/N+YrEM8edN1iFIuoSlOVs2eJvQsil3kaS w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="375107711"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; d="scan'208";a="375107711"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2023 23:06:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="1107249595"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; d="scan'208";a="1107249595"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Dec 2023 23:06:58 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 23:06:57 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 23:06:57 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Dec 2023 23:06:57 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Dec 2023 23:06:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DnoakI198MljK4BmaovSoWRigpLdicwgg94HKUIPivdTzlbvnnCO2VSzyO168nFLVD3KLGHOpywf+TX/rmztpRawYRXbDjlHqoblpHiOydQkeznbpm2/p/IwTUrOck28JWH9fFSInXKGcxE/2xCZmTMlLjyESv5Ak2Y/7f3fDAE8qMeqtBY6q5cNMaqIbgVnWO9M69eEjKGEBA+TwHjWcei+LN+58kYqeQagfydhToZawMTsywjA1K9uc/zwyIvT9jf9GDso62l8wrXahZocTaE8METdwt57PGPLSWjL0Sk6pQdxEcTCLzEg3DjVbXoOE3j0WoQGpYUbbq85wUT8mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxZRVfDvrFRF26xFlQS2PaAH6amszLBL3xM1Pk2PG2g=;
 b=n6Q/zLpa8ZBGQuvVp3H8GvspcbmwSrOE9SHTaAuPGvASra4GIihv7xKDzqucfLua0aOpF+j6F9X1JG7RRKdph+/JPbG2qBaoMVxC9P3ExTPxbFP1hDl3Md6alRAAnd7grrRQ3qrFgBObPz8mBz4tZ+bJmnrg/pjFfCNV/6yhqYaRpGQM5pdLSZHSA+H0fnU/5KHBPNCu6nJQsjire9LM+b2obvX53PCU6SwYTUlFWEx/IOob3dnoTjX8z3xFPgTro8DpCp3grQFO/JzS9SlB/m6TTn+L4fwFv0g+RLpDOHtRXn894hk253zjAaNsW9uAJ3AY/gS6qkzvIX/YPbIY8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 CY8PR11MB7731.namprd11.prod.outlook.com (2603:10b6:930:75::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.38; Tue, 19 Dec 2023 07:06:54 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::9e26:3fcf:912c:4259]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::9e26:3fcf:912c:4259%6]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 07:06:54 +0000
From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
To: "Maniyam, Dinesh" <dinesh.maniyam@intel.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>, "Hea, Kok
 Kiang" <kok.kiang.hea@intel.com>, "Ng, Boon Khai" <boon.khai.ng@intel.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>, "Chong, Teik Heng"
 <teik.heng.chong@intel.com>, "Zamri, Muhammad Hazim Izzat"
 <muhammad.hazim.izzat.zamri@intel.com>, "Lim, Jit Loon"
 <jit.loon.lim@intel.com>, "Tang, Sieu Mun" <sieu.mun.tang@intel.com>
Subject: RE: [PATCH] arm: dts: agilex: Increase reserved memory size to 32MB
Thread-Topic: [PATCH] arm: dts: agilex: Increase reserved memory size to 32MB
Thread-Index: AQHaLydygRiL3eMUnkukQcD5d5kYnLCwNP8w
Date: Tue, 19 Dec 2023 07:06:54 +0000
Message-ID: <DM8PR11MB5592A543380DFFB484D4F58DD297A@DM8PR11MB5592.namprd11.prod.outlook.com>
References: <20231215072151.27261-1-dinesh.maniyam@intel.com>
In-Reply-To: <20231215072151.27261-1-dinesh.maniyam@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|CY8PR11MB7731:EE_
x-ms-office365-filtering-correlation-id: 49dcde9f-6aa6-4c87-aa1f-08dc006114fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +SY7pKsrEnBzVBhoL9MvUtQpfLrC3XgCd0X5C8gew/El1mpT2SSMOLkUDtxMFemMcVnuL0Gpg7U4RBCNXqDz7EG7Hj7w9O5iSq87XvjZ+StNG1YO3MQy2hphxoUxBBWQhCTjbrbcrLCdo2hYbSPR7XV5cR+m70Tvs2tp+R0D5yxmytqaRWLIUxn8oAZq7+R41HYz6oBANPtRFMDTh+y98v41DGnugbob+hD2oDJE8ZQ2XY15L/7/yZCAWgnXQQZTMN+hKBJex9MjVEwKnDPWngP3kqGcUodPOtwNwl8mr5Z10/I6ZWE8aCKbk/Zs6Q3d3JOkffGZTYZdEYu0v+Rwn5j0xQpiS+tSbtuWtwYNzkC+lSOjngypiD4boi87fTe8HJOjDNYpBkr0cFgFQMkVvVmvjWiCBsHjohRbIUC1gSXfz77xFWVi5GMDdAGxm5l7peYdD+OOIRjaQQT7GwVFL69sPoZjmDS6S4oN21ioZi20vrJ5JRwku5XmT1lBzwWMGlmqhjrHmddYsxLjfOOFtdr/bRmkATlI9vaNk6sxxlYpztuXZjFu3pzZV/WxyPybfd0SRQ8ngfveo2qBhWkIBreUrgOsCraLj3GTKmwPjGM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5592.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(396003)(136003)(39860400002)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(83380400001)(107886003)(53546011)(9686003)(7696005)(6506007)(5660300002)(4326008)(52536014)(41300700001)(316002)(110136005)(2906002)(71200400001)(478600001)(8676002)(8936002)(54906003)(66446008)(76116006)(66556008)(66946007)(66476007)(64756008)(86362001)(33656002)(122000001)(38100700002)(82960400001)(38070700009)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1a4d4pp57hWQfuH0hx1JJlY/1lgcuAaDXBzTezE6y9EM6WEfBLbHhKl3cLtK?=
 =?us-ascii?Q?KzayntrC9Ao97ePW4UJ82E8qOggeZJua4MSF1x4dG29gpDN03l37seQZOhJf?=
 =?us-ascii?Q?o2TJqPQ3kBdzA3EZaWIXb/XHTjIeRwTn5f4VRBIUeh27hOn6/ocFIGTXMeFk?=
 =?us-ascii?Q?+TqA1f/GmdR1y2eC4D2lGbqS8JjBeGdFsPUctBDLd9mVBcWd963vpeAP2ie/?=
 =?us-ascii?Q?ut+KCJ3zsJLDpuIvDOmULTkU0ekp3wMr7I+BOPsZWvSedk8HwrBc3EX4sbq+?=
 =?us-ascii?Q?rtcJJUs/yu+3pqYU2oZ3bOXXUAQMekTT9lYcaCpyuxuUdBuyOEnW1xmd5PG3?=
 =?us-ascii?Q?t2gYJ+Dn/uemTvY0/cgPIfkes4EFHzW0L7JcYY6opnYPDG+wJeU6wHX114PN?=
 =?us-ascii?Q?+lQRbtxquHYjx8JNJbG8G9SlzTEIDdnl+HSkbFT9ks8Ck+fAPff7xzPZ75rS?=
 =?us-ascii?Q?wiKLP38PpGOG21AoJCtJPb2hpPIL4mCixnM9A04BdfoXOIocsBNdjme2Gzy6?=
 =?us-ascii?Q?HTecbltxmYvLuUvhDpxJl1IiTOJ+7GG2ZYAxvnKJgtE8OYDA4ueg5JLu42pn?=
 =?us-ascii?Q?pxchAMZckoSqVzcSJe7r1e0Vc0x9z/ziEs1yq57SsXElbO0h4HDDK6ioZHnA?=
 =?us-ascii?Q?dOBPeziUmlCnv58/9XFJ7cIMh2WUFZqRxm25EFKOkZjXKusPF16G+ztZj4qD?=
 =?us-ascii?Q?dGdzIc3dy5KDunZVI5uaVgYPbmPjuYN73HLTjqwlkTqCnpjAzliuLBz+xPXe?=
 =?us-ascii?Q?qt/J/xqNGPCDK2bvILNXCHjUPgibJxYEqYNnmtCI2cJE1DwmBTUY1bkXKLZc?=
 =?us-ascii?Q?e52JE6w4U98KieI2XhU1K0k+xXl4Kawd0BK+m8UkX7RsFZ8pWo72kLPcYF5g?=
 =?us-ascii?Q?EJWWOwO2IxhyCVfXa+DAN9gkmi3gWyu7J1YDebg4fxE5X3plc7F+WoJV6zyn?=
 =?us-ascii?Q?r6yjQrDfWmusJdeFXxruyfJEp6Sl7ZVFwrTyWyzkYZ8QnF/DaXmd0tFxj45I?=
 =?us-ascii?Q?OOjIcJH9mp3zrJU7pdMrIS4UaJwWCPWAOjL1DdOgmYL5ZzKGvCpLnRoRw4B+?=
 =?us-ascii?Q?3DbaIqvp850EXHWDd1kV2NxsCWoLr2M9RweG+EMzNt5sZd9q9rEyFXjxgtfs?=
 =?us-ascii?Q?SbXI23Ej4x0f3ZHZ+NXuUexlpExo96hiIsZ7CHEZ/xFEH4hQF80gczWqSlcf?=
 =?us-ascii?Q?0A7KdhqNMQbCRtCPwyp42JoZXzC6tLLnousX6WWTvfN2LyzFBzN6Iu4lvnXS?=
 =?us-ascii?Q?BaCpxKHJ9JuYPFVxxBdEL5FtrSO1Ot5RAUobwPDseDsYNOHtXl53LDN+MiQJ?=
 =?us-ascii?Q?dpKOnH2mK4koV8VA6mgl5CIHl6N2EgP1T258cmFhf8YT+sGuzR1zKQ8+SpPE?=
 =?us-ascii?Q?Yl46Ei6XdG4aWyehwFNIuXwkkLpVtB1gSt/UNAxmKRuYJ/wZSJ15chTSIOwi?=
 =?us-ascii?Q?/1x5LGmJhbwKo0oc9KL8XU+HS3PrAvR6Dq0OqULa87SpagJtWElPOz9ZfbbX?=
 =?us-ascii?Q?rz9T+CKBb9vE8NqeKjjZPC5V2d0HMjIPMxnpkO3x1XxWxbONi0iYBWUu2bW5?=
 =?us-ascii?Q?2Vfo69bEPqUPRk39h9+OC/sFQ9+a3GNgdYUt031J?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49dcde9f-6aa6-4c87-aa1f-08dc006114fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2023 07:06:54.3519 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SH2ORYhqK22lRF2+Myk4qyyFTv78qnayptKHc5+jhqE78tWlNN+4Dg2AVuv2x6cKlaHf6fLigzHaXZY19Kl63GcdmZ/JZP59HTuRDcOD7eY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7731
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

Hi,

> -----Original Message-----
> From: Maniyam, Dinesh <dinesh.maniyam@intel.com>
> Sent: Friday, December 15, 2023 3:22 PM
> To: u-boot@lists.denx.de
> Cc: Marek <marex@denx.de>; Simon <simon.k.r.goldschmidt@gmail.com>;
> Chee, Tien Fong <tien.fong.chee@intel.com>; Hea, Kok Kiang
> <kok.kiang.hea@intel.com>; Maniyam, Dinesh
> <dinesh.maniyam@intel.com>; Ng, Boon Khai <boon.khai.ng@intel.com>;
> Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@intel.com>; Chong, Teik Heng
> <teik.heng.chong@intel.com>; Zamri, Muhammad Hazim Izzat
> <muhammad.hazim.izzat.zamri@intel.com>; Lim, Jit Loon
> <jit.loon.lim@intel.com>; Tang, Sieu Mun <sieu.mun.tang@intel.com>
> Subject: [PATCH] arm: dts: agilex: Increase reserved memory size to 32MB
>=20
> From: Dinesh Maniyam <dinesh.maniyam@intel.com>
>=20
> The reserved space is extended to 32MB in Linux kernel because additional
> space is needed for authorization execution of JIC/RBF file.
> U-Boot required to align with Linux.
>=20
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
> ---
>  arch/arm/dts/socfpga_agilex.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/dts/socfpga_agilex.dtsi
> b/arch/arm/dts/socfpga_agilex.dtsi
> index c3ead2d72b..712304d07a 100644
> --- a/arch/arm/dts/socfpga_agilex.dtsi
> +++ b/arch/arm/dts/socfpga_agilex.dtsi
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier:     GPL-2.0
>  /*
> - * Copyright (C) 2019, Intel Corporation
> + * Copyright (C) 2019-2023 Intel Corporation <www.intel.com>
>   */
>=20
>  /dts-v1/;
> @@ -20,7 +20,7 @@
>=20
>  		service_reserved: svcbuffer@0 {
>  			compatible =3D "shared-dma-pool";
> -			reg =3D <0x0 0x0 0x0 0x1000000>;
> +			reg =3D <0x0 0x0 0x0 0x2000000>;
>  			alignment =3D <0x1000>;
>  			no-map;
>  		};
> --
> 2.26.2

Reviewed-by: Tien Fong Chee <tien.fong.chee@intel.com>

Regards
Tien Fong

