Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E59C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 07:05:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3919F86E05;
	Tue, 19 Dec 2023 08:05:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="BGjrWSyN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 073E086EA6; Tue, 19 Dec 2023 08:05:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D645486E05
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 08:05:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1702969522; x=1734505522;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=MrFLW369gFD9nKNzsLD/sxIUsAAyKyvYZNOj/w36yuU=;
 b=BGjrWSyNPCZ0/RcPEwuuS4bUezQO3XmbWtncjj5kScaTNd+pSwlwRxvV
 fCuUTsUaEzii7fZjrT84Fm0tWeXY0ryXkfo7aO3g/jCrCMG+bbnxD/wl0
 z0FnWwY4SxJ3wW5gHxc+4q9U9yAQsI5YGINO1PbVcIrmX/pBos1zw8A14
 mi4LOvUEsKdXuVxD2XNG52Ls4tE97FV4O93A8MPQ4TL/2H483ys3N4g38
 cFmRT/8AJR0VjoUzj1qGjsT43hmo2LzTLnbAOQ6oG/5AX4qbiaEk1sVDA
 ExYET49jFCve4wgM7j2mD7dmvrzQ8e7I9qridJ1OnhTKult7e7JHDnI31 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="394495338"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; d="scan'208";a="394495338"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2023 23:05:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="899259193"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; d="scan'208";a="899259193"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Dec 2023 23:05:18 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 23:05:17 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 23:03:32 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Dec 2023 23:03:32 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Dec 2023 23:03:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMs8uWOkFo0tlwrmqF41GTACY9oI/qv53v25vPbKHZBSRQmu7vxdUVDubSN7WvlS7dPUeR5CLdJaqXQWcrh6Skn72BghWss9HfbQr63BoY8ijP0ZDwwC67cBKIy1Dki9NHUCzd+wBUTrDNbdrVUbKsku6ZYl6NYVBY6Z78qRdE9lUlpifkOvpZZJsHX5K3wXMv6z1TCA7Gql2Azkk6hpBqPH/K+n7iI8HBaG9i2zYO3T0T78K0+yjp6agCC7mZ+DXV9Q53FFrquKX7rjAYNC1YEDapkYKP37Ok9s5WBlwBn7KpjmgHU+CZEw2GoERoewH3dVpsHIybiZv9DO2GWS8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGi/mZQfA7IQIP5gpWgfbsvL74S+JceOShZCs/gmD0Y=;
 b=D1qDyI3tqa00jYGqAKXxPlrTt/4qiTGs5onqZlHg3SV0o5DziqkGB1qKRCaUUvXw6QLP4YxQX/B2D2vfhh7Z+0x9E45oozIYFtMO5q1Uu3XbFveDdRsPSSZwdB1dnjBoenPROUt1zFxunYd9wi90DybiyMcoUSwWH45zhPliY6bSv7Z5pvTR89KPUF3ZhNwIGLmrV7WzobUOljrtanNBL/Cp8VbNGbCtqvODzE/tWIWqmdqodidFuCK/mVv3wZXahOllQ6wfaR8GI/WjwzAMODRiZxh8jTQ+hE4UeLgwMBknXzpWcVLI1DaFVFCOVMKGqlBDWOTt+lE6jkNRkMnP/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 CY8PR11MB7731.namprd11.prod.outlook.com (2603:10b6:930:75::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.38; Tue, 19 Dec 2023 07:03:26 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::9e26:3fcf:912c:4259]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::9e26:3fcf:912c:4259%6]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 07:03:20 +0000
From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
To: "Lau, Wan Yee" <wan.yee.lau@intel.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Simon Glass <sjg@chromium.org>, Kever Yang <kever.yang@rock-chips.com>,
 Bin Meng <bmeng.cn@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, "Jean-Marie
 Lemetayer" <j.lemetayer@kerlink.fr>, Peng Fan <peng.fan@nxp.com>, "Vladimir
 Zapolskiy" <vladimir.zapolskiy@linaro.org>, Konrad Dybcio
 <konrad.dybcio@linaro.org>, Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, "Hea, Kok Kiang"
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
Thread-Index: AQHaKbHP0Gwj4q+ySk6x1BfTusqx6LCwPVDQ
Date: Tue, 19 Dec 2023 07:03:20 +0000
Message-ID: <DM8PR11MB5592CA687BF05641806BA22BD297A@DM8PR11MB5592.namprd11.prod.outlook.com>
References: <20231208083726.26906-1-wan.yee.lau@intel.com>
In-Reply-To: <20231208083726.26906-1-wan.yee.lau@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|CY8PR11MB7731:EE_
x-ms-office365-filtering-correlation-id: c7407dc5-a3fd-49b4-3e9b-08dc00609589
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TiLnERe10N3fCROQ1nJRXqL8jjDavNOv/LSiaOqvnlriWj4yn0D5Ixqp5lpUu+KSpIpDnjbRBTJF8rhw30EghTrqNrPdys11nVjy505QkKx5DyqjVkaKhaQKmgTlDv5cWj6cxiCvbzVI43zeq77p/s2Fj3cjuAgxnbG+KuJ5MqsWjPt7YcVHTU8PdmqZmLJjIJGVfRkN2lWr3TWolI7kExwkp3oS5vUD5OxzBcX9niEmT/rVM36lNgeh+UIBvhgf/a+plpCBl9ewnu3PoUysaMr0qciJ5eEm6nQARkqRLxnjWicEnIdYd+5U1EPSIPM+vCWwkbAbpG/Tus4OmvnLU2p6VoWgwxjsNFbfj1cpPrQ30qqbAicDUP8tRX4zatQrJP22Sq/0SlpTg88JV4aLHg0DpJOyJaLZRNfkF40z8qPUQn+u9djmCs4Wle0nemFKVkxoT3sj+7hVF1BwUWWALJMj+ckJ6LnkcKHTnVIdAvHpX/nIERCHHD+tzkxuVVlyyw+ssajXmeSi+lcxMjKiZKj38Qq4WtyALtiqVUnMze4YJLmKci67cN+mUSSbYAPxYEj8O/H5bghVoKzhmlBGRSoZ/7AQm8SWwi0rDK/5XBc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5592.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(396003)(136003)(39860400002)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(83380400001)(107886003)(53546011)(9686003)(7696005)(6506007)(5660300002)(4326008)(52536014)(41300700001)(7416002)(316002)(110136005)(2906002)(71200400001)(478600001)(8676002)(8936002)(54906003)(66446008)(76116006)(66556008)(66946007)(66476007)(64756008)(86362001)(33656002)(122000001)(38100700002)(82960400001)(38070700009)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OMbMpxeOgEayWuCZUFUrzAoUD2tFS0Io9zYoWr643S4KbR8P1faDGo0ocpjc?=
 =?us-ascii?Q?Lq5KZq614NnFLivHBvcc1rhH9Y3KiG0JGU7HueTJpIRX8CNhS/QFJd/JZn9U?=
 =?us-ascii?Q?1lbRYx2jubG+//vtJ6IA10AStGrFneC3ryur2A+QGK1wAsai0E9wn2h15LQd?=
 =?us-ascii?Q?tOTmhL5wSy1IfhQcdHOsLq+8Z0ItqmocMI3VcEBB5J9EWlc9xLTeJQDs98cj?=
 =?us-ascii?Q?7c0Lu9elNncA/Ds3o8QQpcwfSqta+ELM08q7cWNF4Y9bKqavQxGVf5pJwH/q?=
 =?us-ascii?Q?pMwVbRwpqmmjaoXnGhJ/p64RFr4vaA71hNcF/5pFJeRLgw8i7fmhktjgXot1?=
 =?us-ascii?Q?1sRQkdhizbXGQ7FzLarucDNEB304Bo3ETape6/bahtlrGRPwLHnOv7C1VvQd?=
 =?us-ascii?Q?k7TalEkY4HTOo/7CpzRK20QAQDV5R3ph+XGVHES8XExK5ab/g278aF2nRuOt?=
 =?us-ascii?Q?K8nlvcChduZAOZToXmoPbw799FjSj/UxsfRBU/jUmVuDsyWSBRphgzynZaIC?=
 =?us-ascii?Q?kieUjPRKuARIEUK8QBrN1OE4ael18LLki11YPzpn5ujJOCdJPxLbkNpBm4ST?=
 =?us-ascii?Q?krQdParXojWMLnIWu5znj27UhO8sfdey5/dlIKn3SavEcG9e4nJ7bNV82QAL?=
 =?us-ascii?Q?njqYFhitwUNM4pnADN+MpotoDjd9YLIR2xNcZMiUksxLxZdX82RBPhd0Ws+S?=
 =?us-ascii?Q?xwgVuObJnG0+ln+NAAbnQ3qKvwkM2A081zxxNQc8TC5vzTsNdBQHau+qitBm?=
 =?us-ascii?Q?rGtNDYyCglPZoz/EnkkI9pnreubdMp6a6PEF0wXhEyBWM7OT+aYOko6Y9K7k?=
 =?us-ascii?Q?TxYlsFzwMiwaTVa7uzYf56AEfc3Tee2SvWaKJzm/oeSGsuf5p/fhUR1Wdgni?=
 =?us-ascii?Q?B/1/TTwMuMjRVCxHoLsU3NlEpXOE2oe0gvUX4BFZypRebQcqcOjqiHdPBvnb?=
 =?us-ascii?Q?ssPlJxId1mZvoAHPGyNenee/YtAmOYm+eU+MgeCKyakq8qVQfMAzSrt3oJHz?=
 =?us-ascii?Q?ZBbzjZrYpOf01rXkJg3biKUUUBUjzdHnlSAeH7dKME6F0mC4ctQf51Vw/83b?=
 =?us-ascii?Q?rymoVfoXB6BSmViqS2pRoOTdYSlSMEazfU7PQlulQDCrqCm7X48BVkfiTeWn?=
 =?us-ascii?Q?ccNquBl5zuSVvc1tRM8of9zcZExH92mwzyeP6b1ciFL2wF1uhAGnANijunHE?=
 =?us-ascii?Q?AY9K6WBgl1M6YvWQ0f/Jvm5y+XKLH4Qhavkub0XkkxYi88ftafit+rofPBCl?=
 =?us-ascii?Q?ATX4fJg+q3s4XCrb2VsQYSDL3PTsS6LopLLJYIg1lUzQMq2R+2uG8XK7hpea?=
 =?us-ascii?Q?pOMpqC0cBnJnytzofK4zDS/8TRFsFJlKh+OUqVNhn4EO4HDxigy7fYR54Z3V?=
 =?us-ascii?Q?jYuJ6qCirbQ/ktBwRlLpjoe0lIAD/aq9GqpJvRvkTOpaoC3ynJpfGJ1087qP?=
 =?us-ascii?Q?G8HIlrfL1Qd4P49xXn/Xqqfn8DwxRyMJ+T0W+e6wb7yRm8bYsTts3433ZhBI?=
 =?us-ascii?Q?jNrUWIYTKbQOtNjIdciTIU47dzHyBQItBbxUJ/quigSR/jIGL+oEDuRd9DYi?=
 =?us-ascii?Q?0+WI6d8GuTiT8YyPtTSJ6CA5jUHGSQn9/krg/3Xk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7407dc5-a3fd-49b4-3e9b-08dc00609589
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2023 07:03:20.4862 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UaQrYJzmK3V+9UrRH1GVf/z74b0nRyObXxNkLw9l5uGmWkL1P6vvfoh2VT9NA5IasqVPNzK87utoxYtHHybu3Op3cI2ZWULgT6YL+K7iyuc=
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
> From: Lau, Wan Yee <wan.yee.lau@intel.com>
> Sent: Friday, December 8, 2023 4:37 PM
> To: u-boot@lists.denx.de
> Cc: Simon Glass <sjg@chromium.org>; Kever Yang <kever.yang@rock-
> chips.com>; Bin Meng <bmeng.cn@gmail.com>; Jonas Karlman
> <jonas@kwiboo.se>; Jean-Marie Lemetayer <j.lemetayer@kerlink.fr>; Peng
> Fan <peng.fan@nxp.com>; Vladimir Zapolskiy
> <vladimir.zapolskiy@linaro.org>; Konrad Dybcio <konrad.dybcio@linaro.org>=
;
> Marek Vasut <marex@denx.de>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@intel.com>; Hea, Kok Kiang <kok.kiang.hea@intel.com>;
> Maniyam, Dinesh <dinesh.maniyam@intel.com>; Ng, Boon Khai
> <boon.khai.ng@intel.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@intel.com>; Chong, Teik Heng
> <teik.heng.chong@intel.com>; Zamri, Muhammad Hazim Izzat
> <muhammad.hazim.izzat.zamri@intel.com>; Lim, Jit Loon
> <jit.loon.lim@intel.com>; Tang, Sieu Mun <sieu.mun.tang@intel.com>
> Subject: [PATCH v1 1/1] drivers: misc: Add socfpga_dtreg driver for Intel
> SoCFPGA
>=20
> From: Wan Yee Lau <wan.yee.lau@intel.com>
>=20
> This driver can be used to provide user a clean interface and all registe=
r
> settings are centralized in one place, device tree without need for
> hardcoding in the source code.
>=20
> Signed-off-by: Wan Yee Lau <wan.yee.lau@intel.com>
> ---
>  .../misc/socfpga_dtreg.txt                    |  66 ++++++++++
>  drivers/misc/Kconfig                          |   7 ++
>  drivers/misc/Makefile                         |   1 +
>  drivers/misc/socfpga_dtreg.c                  | 117 ++++++++++++++++++
>  4 files changed, 191 insertions(+)
>  create mode 100644 doc/device-tree-bindings/misc/socfpga_dtreg.txt
>  create mode 100644 drivers/misc/socfpga_dtreg.c
>=20
> diff --git a/doc/device-tree-bindings/misc/socfpga_dtreg.txt b/doc/device=
-
> tree-bindings/misc/socfpga_dtreg.txt
> new file mode 100644
> index 0000000000..5458103f88
> --- /dev/null
> +++ b/doc/device-tree-bindings/misc/socfpga_dtreg.txt
> @@ -0,0 +1,66 @@
> +* Firewall and privilege register settings in device tree
> +
> +Required properties:
> +--------------------
> +
> +- compatible: should contain "intel,socfpga-dtreg"
> +- reg: Physical base address and size of block register.
> +- intel,offset-settings: 32-bit offset address of block register,
> +			 followed by 32-bit value settings and
> +			 the masking bits, only masking bit
> +			 set to 1 allows modification.
> +
> +This driver can be used to provide user a clean interface and all
> +register settings are centralized in one place, device tree without
> +need for hardcoding in the source code.
> +
> +General setup would be to set the memory address used by the register,
> +followed by the offset-settings containing the 32-bit offset address of
> +the block register, then the 32-bit value settings and lastly the
> +masking bits.
> +
> +Example:
> +--------
> +
> +Configuration for multiple dtreg node support in device tree:
> +
> +	socfpga_mainfirewall: socfpga-mainfirewall {
> +		compatible =3D "intel,socfpga-dtreg";
> +                	#address-cells =3D <1>;
> +                        #size-cells =3D <1>;
> +		        bootph-all;
> +
> +                        coh_cpu0_bypass_OC_Firewall_main_Firewall@f71002=
00 {
> +                        	reg =3D <0xf7100200 0x00000014>;
> +                                intel,offset-settings =3D
> +                                	/* Disable ocram security at CCU for no=
n secure
> access */
> +                                        <0x0000004 0x8000ffff 0xe007ffff=
>,
> +                                        <0x0000008 0x8000ffff 0xe007ffff=
>,
> +                                        <0x000000c 0x8000ffff 0xe007ffff=
>,
> +                                        <0x0000010 0x8000ffff 0xe007ffff=
>;
> +                                bootph-all;
> +                        };
> +                };
> +
> +	socfpga_mpfefirewall: socfpga-mpfefirewall {
> +        	compatible =3D "intel,socfpga-dtreg";
> +                	#address-cells =3D <1>;
> +                        #size-cells =3D <1>;
> +			bootph-all;
> +
> +                        soc_noc_fw_mpfe_csr_inst_0_mpfe_scr@f8020000 {
> +                                reg =3D <0xf8020000 0x0000001c>;
> +                                intel,offset-settings =3D
> +                                        /* Disable MPFE firewall for SMM=
U */
> +                                        <0x00000000 0x00010101 0x0001010=
1>,
> +                                        /* Disable MPFE firewall for HMC=
 adapter */
> +                                        <0x00000004 0x00000001 0x0001010=
1>;
> +				bootph-all;
> +                        };
> +                };
> +
> +To call the nodes use:
> +
> +	ret =3D uclass_get_device_by_name(UCLASS_NOP, "socfpga-
> mainfirewall", &dev);
> +	ret =3D uclass_get_device_by_name(UCLASS_NOP, "socfpga-
> mpfefirewall",
> +&dev);
> +
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig index
> fccd9b89b8..c423905ba2 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -683,4 +683,11 @@ config SL28CPLD
>  	  the base driver which provides common access methods for the
>  	  sub-drivers.
>=20
> +config SPL_SOCFPGA_DT_REG
> +	bool "Enable register setting from device tree in SPL"
> +	depends on SPL
> +	help
> +	  Enable register setting from device tree. This also
> +	  provides user a clean interface and all register settings are
> +	  centralized in one place, device tree.
>  endmenu
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile index
> b67b82358a..8f813edd84 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -89,3 +89,4 @@ obj-$(CONFIG_K3_AVS0) +=3D k3_avs.o
>  obj-$(CONFIG_ESM_K3) +=3D k3_esm.o
>  obj-$(CONFIG_ESM_PMIC) +=3D esm_pmic.o
>  obj-$(CONFIG_SL28CPLD) +=3D sl28cpld.o
> +obj-$(CONFIG_SPL_SOCFPGA_DT_REG) +=3D socfpga_dtreg.o
> diff --git a/drivers/misc/socfpga_dtreg.c b/drivers/misc/socfpga_dtreg.c =
new
> file mode 100644 index 0000000000..982f9592cb
> --- /dev/null
> +++ b/drivers/misc/socfpga_dtreg.c
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 Intel Corporation <www.intel.com>  */
> +
> +#include <asm/io.h>
> +#include <common.h>
> +#include <dm.h>
> +#include <errno.h>

Please move <asm/io.h> above to here

> +#include <linux/sizes.h>

--
Tien Fong

