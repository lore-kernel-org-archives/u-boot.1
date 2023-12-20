Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E46C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 12:13:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E099787732;
	Wed, 20 Dec 2023 13:13:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YyhsAxmR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D36EF86E65; Wed, 20 Dec 2023 04:09:49 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27D7687032
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 04:09:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wan.yee.lau@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1703041786; x=1734577786;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Mr2CQTe1dseHzydLkKzeBq8mdfQb9IGdzASF2tJ+dxc=;
 b=YyhsAxmRDiDaLxETmf5vDTly31Pe+bUNxtXXKIr1x3jwQodlwDX7pFKY
 Xi3ZJ0iVHf0gn27RcpFyZGX2dQogzIu8xgRC+Gwumwj3deeueRrKX4qmz
 Fw3WQDMoJzusj1dIcy+fiduK2ngIkWcECbWkMwAd3/rvA2DLsLO9DnlcV
 psOAXecz046EGWAn5EfTOSHz0EeR3Jzu5VjdoMfBrQ82UXw/7bFAqaVcH
 CJOhS3a8kyC2+chdezdTArvKeLI418Mo6/jAjCZd8EMQFI5aZBK77+Eu6
 7lVArgl4AlLFZK2V9fXju6yiqLZ/dtfT47tYUQDyzXGY/Wv+OsMQLh+H1 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="399589342"
X-IronPort-AV: E=Sophos;i="6.04,290,1695711600"; d="scan'208";a="399589342"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Dec 2023 19:09:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="805107349"
X-IronPort-AV: E=Sophos;i="6.04,290,1695711600"; d="scan'208";a="805107349"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 19 Dec 2023 19:09:43 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 19:09:43 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 19:09:42 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Dec 2023 19:09:42 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Dec 2023 19:09:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+9bVIC+YlftsPbXEC929UBEgG2bAtU82g+g5wPtqUQWyHKE6jciwXSS5+vR6vhZzPvh7yC3CAr89w4tE6s057RCSAeOWB4LW8yTKmr7LHFUkgiG+mmHeJErCLRtOpybs2KhwX1iA5W2tPr2IpUdpWmpfXA9qmFEfGtwp5WgugPcl60zEZyguG/1V7wZMh8hod/CjcZ7p7pnx3Wj2im5/zHIsKSDwvTOkHCVrjT0M14HzQ50EAlBRdE209Fa0B6znnM3wcsQ7pSsFJ6CiBF0uZ3/GJ4pecTAprXekcO3OMbPp0lyOQLN65rO7/JtRlm7RBKJA14pmYxbQYjXK0Wd4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mr2CQTe1dseHzydLkKzeBq8mdfQb9IGdzASF2tJ+dxc=;
 b=F3tJSrNw6+/y/pZS396NnsirAfDVpkyVdIj1PHTDOQxMGhgBRRRYEOt3bDjfjdTR2JEiogcAxKBMHIhAjWon/Xdi2mSo13UTOlejm41groYlbz5phUbtFuKmfJh2ukAYK6bN2lC59xeUtaeeMFm/UdlP+9WTJACKBegrbyDNuNz2iy6kUjSGv8xjRZJjejCX1VukmMmBctufeGTh8ZbxG0YEjxpv9mbyqDXBZXOer2JRRbkRl16n5M8Wna9qjJZdiKyYn7p//PZLqSIu9+j3rSYPcjgka8qm5yvFd5lqIkc7INHfgxOEHZb+/cFaBrgoFwHv2coQEpJgIaf1GmApEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW3PR11MB4553.namprd11.prod.outlook.com (2603:10b6:303:2c::9)
 by PH0PR11MB5096.namprd11.prod.outlook.com (2603:10b6:510:3c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 03:09:39 +0000
Received: from MW3PR11MB4553.namprd11.prod.outlook.com
 ([fe80::5e77:986f:cc35:9028]) by MW3PR11MB4553.namprd11.prod.outlook.com
 ([fe80::5e77:986f:cc35:9028%5]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 03:09:39 +0000
From: "Lau, Wan Yee" <wan.yee.lau@intel.com>
To: Marek Vasut <marex@denx.de>, "Chee, Tien Fong" <tien.fong.chee@intel.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Simon Glass <sjg@chromium.org>, Kever Yang <kever.yang@rock-chips.com>,
 Bin Meng <bmeng.cn@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, "Jean-Marie
 Lemetayer" <j.lemetayer@kerlink.fr>, Peng Fan <peng.fan@nxp.com>, "Vladimir
 Zapolskiy" <vladimir.zapolskiy@linaro.org>, Konrad Dybcio
 <konrad.dybcio@linaro.org>, Simon Goldschmidt
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
Thread-Index: AQHaMklyixczvViI4UynCR3WXVD3cbCwXhiAgAEgnFA=
Date: Wed, 20 Dec 2023 03:09:39 +0000
Message-ID: <MW3PR11MB4553AD65903767C338B8E43AB696A@MW3PR11MB4553.namprd11.prod.outlook.com>
References: <20231208083726.26906-1-wan.yee.lau@intel.com>
 <DM8PR11MB5592CA687BF05641806BA22BD297A@DM8PR11MB5592.namprd11.prod.outlook.com>
 <edccf82f-2c65-4f09-bd9d-f94765ae015d@denx.de>
In-Reply-To: <edccf82f-2c65-4f09-bd9d-f94765ae015d@denx.de>
Accept-Language: en-MY, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR11MB4553:EE_|PH0PR11MB5096:EE_
x-ms-office365-filtering-correlation-id: eb882cc2-6cd8-4eb9-404d-08dc01091a88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7Oo74sx+kXa6zfO1hnJsDrU9ID7+RhuG9J01VWh4V17TByt6neLRnYov+ja9exlaZwOucgzk0/Qs8sRsiFaXOQPEAv3JRhdY/aaVgSbShV//8OZkIJUBxYWMtfcjYwDe7R8Z8rEkveM/ePx9MvZVCJkaDV6xKPRVtRBod8LTApnQgk6ohN0hiHXkNfhkojtINwft09fwCCMeyWSTIaA1OB4GyDExzN+7hrbEx9nZHBAl8qITfKaDpzqqjXnA/cEZ9Kk3atVO5Anb7xSpsSqINRtk7EnAh5SyhC2hERrRKWvvgtYTijBW2XqskNpTn7K3DotozPgLIv9kKsQTqW2MoOYGRsi53OC2P9oEpWqqXeBUWn2lVpYlH6P1G0x1yvYCjXYClsWwqwB0cK2ASzn2IdiQOMywm3E1Wx/nrWVlZwi9nSprtp9z11u2OGfbRFSeHy8lpjQjIf0XFdqYhWp2t6T8wX1nHux1kwYp/AHVAZTt+q8JUbYHT4OCwAZTAYbVwan7owA2vhNaWy4kA/uLhywXFTrU8u8BctuvziW7hhFIb7yECyUtyzoRat3PjVZXrKu8/dGJJrhhV90ftcUYkjnuKLvsv10X7TDyT3GsJGs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4553.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(396003)(136003)(366004)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(55016003)(41300700001)(9686003)(86362001)(6506007)(7696005)(26005)(53546011)(478600001)(38070700009)(8936002)(4326008)(7416002)(2906002)(8676002)(5660300002)(33656002)(110136005)(122000001)(83380400001)(71200400001)(316002)(107886003)(76116006)(52536014)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(38100700002)(82960400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QkRRY0NzNDdiWTN5em10U3FPQ2k1cklMRVA5OFcrNnZpZHA1TnhMMURtekVS?=
 =?utf-8?B?dXcvV2F3OUJHM0hieVpYaFgxbFlDMkFpL01OcEJoTDZHQ1h3SnZmb2NjSGlh?=
 =?utf-8?B?cmcwb0lZam1oS2JaQWZnNEgxSno4eE50aCt0aUxyRnVtSm5rSGJvMnJ1OE1Q?=
 =?utf-8?B?ZllBUldjNlpyWitEWDFnMWVuWUFEd0FNaWJEa1k3b1BKVkhaZEVQQU9ZY204?=
 =?utf-8?B?b1M5clp2aXlCQWdJM2hnS3hNZjZwNHNMWlhhTURweUN6ZWNIYm1HRGlGU2Y3?=
 =?utf-8?B?SXlPdVNwZ1lGSGJwdlVDU25SMUxMb3Exci9tWndmd3c0SXIvazJZeExWZFBh?=
 =?utf-8?B?TE9YNUhYQ1o1dWI0bUNLWWhaV09CM2hzU1psdzd5c1RZd2p2ajM3SllwOGZk?=
 =?utf-8?B?SUJQSlNJV0h0YWhWM2ZNbERrem82NU0ybjQ1dm5KRGxwVFU5bGxzZG9YQ3Iv?=
 =?utf-8?B?aDl0MUkyTDRoZ2hkOGtRNmQwdDNIVlU1L2JieW1Lbm5jcHcvNEdSbXJmc0FE?=
 =?utf-8?B?Ri9iRTZHVHFzbWJqWm1JTS9aZWV1c1Z0Tmk0elpzRjQ1SEh3dWNOSExGeEFu?=
 =?utf-8?B?djRKcDFSbHJzZXBZWUpOVWg3bHVCVXp4blR6Z2hVa2ZZZ0pBMzNQaTRaQldE?=
 =?utf-8?B?K21qTjh3QUlOZmFUc1BreTVKYXRma295dk15TXNJSDFvZURZd1FIazhvN0pP?=
 =?utf-8?B?VkVrTkZEU3gwb0lpZzFXUzJYVFlNL2ZJYnBFSkZJbkhyWCs0cjF4QnVwSWhG?=
 =?utf-8?B?bnFDa3dseTlHNU9kQmZqbmVvaHI2TmU0d2NpVUhVVlVRY0ZwQXU0dklncTZF?=
 =?utf-8?B?WEQrNVdFQmtOZmVrUzNWUy9VYlk0NVdEU29UeTJXYXBoZkFHU0liM3J3d3pE?=
 =?utf-8?B?OVNTd1dWSE1FejkycmE2U1QveklNN1BzSkhneEJ0d0lUQmlQWStDc01Wd3gx?=
 =?utf-8?B?NFYxcHE3TEM4K2JQQjJzbHNTVHUweVZoaWl1REZIZXJSL2RlNzNtSnh1alQ3?=
 =?utf-8?B?cEFvRU5ReXE3bGwvWkR1ejFiRWhRRHZQaDdFemZDSjVVVmsxZFVGbk5ob05X?=
 =?utf-8?B?KzNackM4RTJFUzZBT0plVlNnVDdLWU1wL1pmRE9kUEwxeHJ4MkdGSUdhWmRF?=
 =?utf-8?B?WHBWUnpoZGZDanlsdFlIdXY1bk1oYTdINGluOWJuZXJ3REpqVGVEeHlKK2ps?=
 =?utf-8?B?TTB1T3pmUWlOd3BkVkl1bGhTa2FTcEFYaVNkazhrRm1WdU9sNEE3UXptajZ2?=
 =?utf-8?B?Uy8vR0NkNWhFOVM2VnFSTG5Lc2RXaGcvUHc4L05sYUh2cGxzY09SK1hnUUIw?=
 =?utf-8?B?QklHYjN3b3d1eGVQeG84ck5WMWsyNTRWOENSQU1jQ1dIbUZXMVpTMy9uVm9Y?=
 =?utf-8?B?c0NoeUMwaDhPSGpFWk5ycERlc1dXMlhHaTMyV3FNc3YrRGZ0TFdEeDcxTDdz?=
 =?utf-8?B?MnhZK2hnTy80SURWN3FVWnBsV3lzZmttQzgyL3d2RktVS3d1ekl4QkFwSlZZ?=
 =?utf-8?B?QXhaVnpGZmlqencyS3BaLzFJQ1plNHEzdVN3Mk9vem5tSnVuVjh0dFhsTUVP?=
 =?utf-8?B?dXQ3TFJWN3l2SURlSU8wYUlIenpYU09hcW5KWk9RbVFmWFJkOTdWQ3VsTHhM?=
 =?utf-8?B?SWhrREJhNDFFUzgzRUluS0ZXQlM4Rzg5aCtjV3RuS3dwT0hRQ1hkR00xbDR4?=
 =?utf-8?B?QjNlNi9RZlYwdDlvZ0NHZW1zQU9xOWFPSnNnNEo0NDJ6RXI3bHJ6SGFpOGRD?=
 =?utf-8?B?aG1VaUtWWDhmeStkWkdGbk1xTmU5SmhOL0lLSFdYWjRmc1ZXNzRxVkNpeU00?=
 =?utf-8?B?clFyNEVVN1VQNHh4MWswMCtiTHVTeFdCUWVIVnVhWVk2N0NieWR2ZCtjQmRY?=
 =?utf-8?B?a2dTbWlrdndEMjZwdGlDYTNVS1dUdE4xcUsvelh5RERwZGNScEtGSUpKUzdh?=
 =?utf-8?B?OXVVVGkxVE8xREgzTmlUVXNVd3VYNTFiMnpCYmZ2K0xHOVAyRGN2aFZhdURj?=
 =?utf-8?B?YzFrdUpXQjQ0VDM2b1FRbld4Ym1zaUhTdkFxNmJXR0ZMSTA0YzRLQ2NKUlhU?=
 =?utf-8?B?Um9XaDNTMlUzZWNRRm45WWFtSzJmQnFOQ2s0OVpmQUorRTcvQ0JjazZtUTI5?=
 =?utf-8?Q?wnIfCEvLwvXhdEaiBU+TcouDH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4553.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb882cc2-6cd8-4eb9-404d-08dc01091a88
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2023 03:09:39.0849 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v6uNgBaHFJilreaq4vBdN/GqZELotyaLiZtDElqPEkaWwI3lgbGsjLhxNeZgojBbqaZK36QEx3IZmqaxRyBxEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5096
X-OriginatorOrg: intel.com
X-Mailman-Approved-At: Wed, 20 Dec 2023 13:13:44 +0100
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyZWsgVmFzdXQgPG1h
cmV4QGRlbnguZGU+DQo+IFNlbnQ6IFR1ZXNkYXksIERlY2VtYmVyIDE5LCAyMDIzIDU6NTQgUE0N
Cj4gVG86IENoZWUsIFRpZW4gRm9uZyA8dGllbi5mb25nLmNoZWVAaW50ZWwuY29tPjsgTGF1LCBX
YW4gWWVlDQo+IDx3YW4ueWVlLmxhdUBpbnRlbC5jb20+OyB1LWJvb3RAbGlzdHMuZGVueC5kZQ0K
PiBDYzogU2ltb24gR2xhc3MgPHNqZ0BjaHJvbWl1bS5vcmc+OyBLZXZlciBZYW5nIDxrZXZlci55
YW5nQHJvY2stY2hpcHMuY29tPjsNCj4gQmluIE1lbmcgPGJtZW5nLmNuQGdtYWlsLmNvbT47IEpv
bmFzIEthcmxtYW4gPGpvbmFzQGt3aWJvby5zZT47IEplYW4tDQo+IE1hcmllIExlbWV0YXllciA8
ai5sZW1ldGF5ZXJAa2VybGluay5mcj47IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPjsNCj4g
VmxhZGltaXIgWmFwb2xza2l5IDx2bGFkaW1pci56YXBvbHNraXlAbGluYXJvLm9yZz47IEtvbnJh
ZCBEeWJjaW8NCj4gPGtvbnJhZC5keWJjaW9AbGluYXJvLm9yZz47IFNpbW9uIEdvbGRzY2htaWR0
DQo+IDxzaW1vbi5rLnIuZ29sZHNjaG1pZHRAZ21haWwuY29tPjsgSGVhLCBLb2sgS2lhbmcNCj4g
PGtvay5raWFuZy5oZWFAaW50ZWwuY29tPjsgTWFuaXlhbSwgRGluZXNoIDxkaW5lc2gubWFuaXlh
bUBpbnRlbC5jb20+Ow0KPiBOZywgQm9vbiBLaGFpIDxib29uLmtoYWkubmdAaW50ZWwuY29tPjsg
WXVzbGFpbWksIEFsaWYgWmFrdWFuDQo+IDxhbGlmLnpha3Vhbi55dXNsYWltaUBpbnRlbC5jb20+
OyBDaG9uZywgVGVpayBIZW5nDQo+IDx0ZWlrLmhlbmcuY2hvbmdAaW50ZWwuY29tPjsgWmFtcmks
IE11aGFtbWFkIEhhemltIEl6emF0DQo+IDxtdWhhbW1hZC5oYXppbS5penphdC56YW1yaUBpbnRl
bC5jb20+OyBMaW0sIEppdCBMb29uDQo+IDxqaXQubG9vbi5saW1AaW50ZWwuY29tPjsgVGFuZywg
U2lldSBNdW4gPHNpZXUubXVuLnRhbmdAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHYxIDEvMV0gZHJpdmVyczogbWlzYzogQWRkIHNvY2ZwZ2FfZHRyZWcgZHJpdmVyIGZvciBJbnRl
bA0KPiBTb0NGUEdBDQo+IA0KPiBPbiAxMi8xOS8yMyAwODowMywgQ2hlZSwgVGllbiBGb25nIHdy
b3RlOg0KPiA+IEhpLA0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+
IEZyb206IExhdSwgV2FuIFllZSA8d2FuLnllZS5sYXVAaW50ZWwuY29tPg0KPiA+PiBTZW50OiBG
cmlkYXksIERlY2VtYmVyIDgsIDIwMjMgNDozNyBQTQ0KPiA+PiBUbzogdS1ib290QGxpc3RzLmRl
bnguZGUNCj4gPj4gQ2M6IFNpbW9uIEdsYXNzIDxzamdAY2hyb21pdW0ub3JnPjsgS2V2ZXIgWWFu
ZyA8a2V2ZXIueWFuZ0Byb2NrLQ0KPiA+PiBjaGlwcy5jb20+OyBCaW4gTWVuZyA8Ym1lbmcuY25A
Z21haWwuY29tPjsgSm9uYXMgS2FybG1hbg0KPiA+PiA8am9uYXNAa3dpYm9vLnNlPjsgSmVhbi1N
YXJpZSBMZW1ldGF5ZXIgPGoubGVtZXRheWVyQGtlcmxpbmsuZnI+Ow0KPiA+PiBQZW5nIEZhbiA8
cGVuZy5mYW5AbnhwLmNvbT47IFZsYWRpbWlyIFphcG9sc2tpeQ0KPiA+PiA8dmxhZGltaXIuemFw
b2xza2l5QGxpbmFyby5vcmc+OyBLb25yYWQgRHliY2lvDQo+ID4+IDxrb25yYWQuZHliY2lvQGxp
bmFyby5vcmc+OyBNYXJlayBWYXN1dCA8bWFyZXhAZGVueC5kZT47IFNpbW9uDQo+ID4+IEdvbGRz
Y2htaWR0IDxzaW1vbi5rLnIuZ29sZHNjaG1pZHRAZ21haWwuY29tPjsgQ2hlZSwgVGllbiBGb25n
DQo+ID4+IDx0aWVuLmZvbmcuY2hlZUBpbnRlbC5jb20+OyBIZWEsIEtvayBLaWFuZyA8a29rLmtp
YW5nLmhlYUBpbnRlbC5jb20+Ow0KPiA+PiBNYW5peWFtLCBEaW5lc2ggPGRpbmVzaC5tYW5peWFt
QGludGVsLmNvbT47IE5nLCBCb29uIEtoYWkNCj4gPj4gPGJvb24ua2hhaS5uZ0BpbnRlbC5jb20+
OyBZdXNsYWltaSwgQWxpZiBaYWt1YW4NCj4gPj4gPGFsaWYuemFrdWFuLnl1c2xhaW1pQGludGVs
LmNvbT47IENob25nLCBUZWlrIEhlbmcNCj4gPj4gPHRlaWsuaGVuZy5jaG9uZ0BpbnRlbC5jb20+
OyBaYW1yaSwgTXVoYW1tYWQgSGF6aW0gSXp6YXQNCj4gPj4gPG11aGFtbWFkLmhhemltLml6emF0
LnphbXJpQGludGVsLmNvbT47IExpbSwgSml0IExvb24NCj4gPj4gPGppdC5sb29uLmxpbUBpbnRl
bC5jb20+OyBUYW5nLCBTaWV1IE11biA8c2lldS5tdW4udGFuZ0BpbnRlbC5jb20+DQo+ID4+IFN1
YmplY3Q6IFtQQVRDSCB2MSAxLzFdIGRyaXZlcnM6IG1pc2M6IEFkZCBzb2NmcGdhX2R0cmVnIGRy
aXZlciBmb3INCj4gPj4gSW50ZWwgU29DRlBHQQ0KPiA+Pg0KPiA+PiBGcm9tOiBXYW4gWWVlIExh
dSA8d2FuLnllZS5sYXVAaW50ZWwuY29tPg0KPiA+Pg0KPiA+PiBUaGlzIGRyaXZlciBjYW4gYmUg
dXNlZCB0byBwcm92aWRlIHVzZXIgYSBjbGVhbiBpbnRlcmZhY2UgYW5kIGFsbA0KPiA+PiByZWdp
c3RlciBzZXR0aW5ncyBhcmUgY2VudHJhbGl6ZWQgaW4gb25lIHBsYWNlLCBkZXZpY2UgdHJlZSB3
aXRob3V0DQo+ID4+IG5lZWQgZm9yIGhhcmRjb2RpbmcgaW4gdGhlIHNvdXJjZSBjb2RlLg0KPiA+
Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBXYW4gWWVlIExhdSA8d2FuLnllZS5sYXVAaW50ZWwuY29t
Pg0KPiA+PiAtLS0NCj4gPj4gICAuLi4vbWlzYy9zb2NmcGdhX2R0cmVnLnR4dCAgICAgICAgICAg
ICAgICAgICAgfCAgNjYgKysrKysrKysrKw0KPiA+PiAgIGRyaXZlcnMvbWlzYy9LY29uZmlnICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAgNyArKw0KPiA+PiAgIGRyaXZlcnMvbWlzYy9NYWtl
ZmlsZSAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ID4+ICAgZHJpdmVycy9taXNj
L3NvY2ZwZ2FfZHRyZWcuYyAgICAgICAgICAgICAgICAgIHwgMTE3ICsrKysrKysrKysrKysrKysr
Kw0KPiA+PiAgIDQgZmlsZXMgY2hhbmdlZCwgMTkxIGluc2VydGlvbnMoKykNCj4gPj4gICBjcmVh
dGUgbW9kZSAxMDA2NDQgZG9jL2RldmljZS10cmVlLWJpbmRpbmdzL21pc2Mvc29jZnBnYV9kdHJl
Zy50eHQNCj4gPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9taXNjL3NvY2ZwZ2FfZHRy
ZWcuYw0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvZG9jL2RldmljZS10cmVlLWJpbmRpbmdzL21p
c2Mvc29jZnBnYV9kdHJlZy50eHQNCj4gPj4gYi9kb2MvZGV2aWNlLSB0cmVlLWJpbmRpbmdzL21p
c2Mvc29jZnBnYV9kdHJlZy50eHQNCj4gPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPj4gaW5k
ZXggMDAwMDAwMDAwMC4uNTQ1ODEwM2Y4OA0KPiA+PiAtLS0gL2Rldi9udWxsDQo+ID4+ICsrKyBi
L2RvYy9kZXZpY2UtdHJlZS1iaW5kaW5ncy9taXNjL3NvY2ZwZ2FfZHRyZWcudHh0DQo+ID4+IEBA
IC0wLDAgKzEsNjYgQEANCj4gPj4gKyogRmlyZXdhbGwgYW5kIHByaXZpbGVnZSByZWdpc3RlciBz
ZXR0aW5ncyBpbiBkZXZpY2UgdHJlZQ0KPiA+PiArDQo+ID4+ICtSZXF1aXJlZCBwcm9wZXJ0aWVz
Og0KPiA+PiArLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPj4gKw0KPiA+PiArLSBjb21wYXRpYmxl
OiBzaG91bGQgY29udGFpbiAiaW50ZWwsc29jZnBnYS1kdHJlZyINCj4gPj4gKy0gcmVnOiBQaHlz
aWNhbCBiYXNlIGFkZHJlc3MgYW5kIHNpemUgb2YgYmxvY2sgcmVnaXN0ZXIuDQo+ID4+ICstIGlu
dGVsLG9mZnNldC1zZXR0aW5nczogMzItYml0IG9mZnNldCBhZGRyZXNzIG9mIGJsb2NrIHJlZ2lz
dGVyLA0KPiA+PiArCQkJIGZvbGxvd2VkIGJ5IDMyLWJpdCB2YWx1ZSBzZXR0aW5ncyBhbmQNCj4g
Pj4gKwkJCSB0aGUgbWFza2luZyBiaXRzLCBvbmx5IG1hc2tpbmcgYml0DQo+ID4+ICsJCQkgc2V0
IHRvIDEgYWxsb3dzIG1vZGlmaWNhdGlvbi4NCj4gPj4gKw0KPiA+PiArVGhpcyBkcml2ZXIgY2Fu
IGJlIHVzZWQgdG8gcHJvdmlkZSB1c2VyIGEgY2xlYW4gaW50ZXJmYWNlIGFuZCBhbGwNCj4gPj4g
K3JlZ2lzdGVyIHNldHRpbmdzIGFyZSBjZW50cmFsaXplZCBpbiBvbmUgcGxhY2UsIGRldmljZSB0
cmVlIHdpdGhvdXQNCj4gPj4gK25lZWQgZm9yIGhhcmRjb2RpbmcgaW4gdGhlIHNvdXJjZSBjb2Rl
Lg0KPiA+PiArDQo+ID4+ICtHZW5lcmFsIHNldHVwIHdvdWxkIGJlIHRvIHNldCB0aGUgbWVtb3J5
IGFkZHJlc3MgdXNlZCBieSB0aGUNCj4gPj4gK3JlZ2lzdGVyLCBmb2xsb3dlZCBieSB0aGUgb2Zm
c2V0LXNldHRpbmdzIGNvbnRhaW5pbmcgdGhlIDMyLWJpdA0KPiA+PiArb2Zmc2V0IGFkZHJlc3Mg
b2YgdGhlIGJsb2NrIHJlZ2lzdGVyLCB0aGVuIHRoZSAzMi1iaXQgdmFsdWUgc2V0dGluZ3MNCj4g
Pj4gK2FuZCBsYXN0bHkgdGhlIG1hc2tpbmcgYml0cy4NCj4gPj4gKw0KPiA+PiArRXhhbXBsZToN
Cj4gPj4gKy0tLS0tLS0tDQo+ID4+ICsNCj4gPj4gK0NvbmZpZ3VyYXRpb24gZm9yIG11bHRpcGxl
IGR0cmVnIG5vZGUgc3VwcG9ydCBpbiBkZXZpY2UgdHJlZToNCj4gPj4gKw0KPiA+PiArCXNvY2Zw
Z2FfbWFpbmZpcmV3YWxsOiBzb2NmcGdhLW1haW5maXJld2FsbCB7DQo+ID4+ICsJCWNvbXBhdGli
bGUgPSAiaW50ZWwsc29jZnBnYS1kdHJlZyI7DQo+ID4+ICsgICAgICAgICAgICAgICAgCSNhZGRy
ZXNzLWNlbGxzID0gPDE+Ow0KPiA+PiArICAgICAgICAgICAgICAgICAgICAgICAgI3NpemUtY2Vs
bHMgPSA8MT47DQo+ID4+ICsJCSAgICAgICAgYm9vdHBoLWFsbDsNCj4gPj4gKw0KPiA+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgY29oX2NwdTBfYnlwYXNzX09DX0ZpcmV3YWxsX21haW5fRmly
ZXdhbGxAZjcxMDAyMDAgew0KPiA+PiArICAgICAgICAgICAgICAgICAgICAgICAgCXJlZyA9IDww
eGY3MTAwMjAwIDB4MDAwMDAwMTQ+Ow0KPiA+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBpbnRlbCxvZmZzZXQtc2V0dGluZ3MgPQ0KPiA+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAJLyogRGlzYWJsZSBvY3JhbSBzZWN1cml0eSBhdCBDQ1UNCj4gPj4gKyBmb3Ig
bm9uIHNlY3VyZQ0KPiA+PiBhY2Nlc3MgKi8NCj4gPj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICA8MHgwMDAwMDA0IDB4ODAwMGZmZmYgMHhlMDA3ZmZmZj4sDQo+ID4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPDB4MDAwMDAwOCAweDgw
MDBmZmZmIDB4ZTAwN2ZmZmY+LA0KPiA+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIDwweDAwMDAwMGMgMHg4MDAwZmZmZiAweGUwMDdmZmZmPiwNCj4gPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8MHgwMDAwMDEwIDB4ODAwMGZmZmYg
MHhlMDA3ZmZmZj47DQo+ID4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb3Rw
aC1hbGw7DQo+ID4+ICsgICAgICAgICAgICAgICAgICAgICAgICB9Ow0KPiA+PiArICAgICAgICAg
ICAgICAgIH07DQo+ID4+ICsNCj4gPj4gKwlzb2NmcGdhX21wZmVmaXJld2FsbDogc29jZnBnYS1t
cGZlZmlyZXdhbGwgew0KPiA+PiArICAgICAgICAJY29tcGF0aWJsZSA9ICJpbnRlbCxzb2NmcGdh
LWR0cmVnIjsNCj4gPj4gKyAgICAgICAgICAgICAgICAJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+
ID4+ICsgICAgICAgICAgICAgICAgICAgICAgICAjc2l6ZS1jZWxscyA9IDwxPjsNCj4gPj4gKwkJ
CWJvb3RwaC1hbGw7DQo+ID4+ICsNCj4gPj4gKyAgICAgICAgICAgICAgICAgICAgICAgIHNvY19u
b2NfZndfbXBmZV9jc3JfaW5zdF8wX21wZmVfc2NyQGY4MDIwMDAwIHsNCj4gPj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDB4ZjgwMjAwMDAgMHgwMDAwMDAxYz47DQo+
ID4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludGVsLG9mZnNldC1zZXR0aW5n
cyA9DQo+ID4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLyogRGlz
YWJsZSBNUEZFIGZpcmV3YWxsIGZvciBTTU1VICovDQo+ID4+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgPDB4MDAwMDAwMDAgMHgwMDAxMDEwMSAweDAwMDEwMTAxPiwN
Cj4gPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAvKiBEaXNhYmxl
IE1QRkUgZmlyZXdhbGwgZm9yIEhNQyBhZGFwdGVyICovDQo+ID4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgPDB4MDAwMDAwMDQgMHgwMDAwMDAwMSAweDAwMDEwMTAx
PjsNCj4gPj4gKwkJCQlib290cGgtYWxsOw0KPiA+PiArICAgICAgICAgICAgICAgICAgICAgICAg
fTsNCj4gPj4gKyAgICAgICAgICAgICAgICB9Ow0KPiA+PiArDQo+ID4+ICtUbyBjYWxsIHRoZSBu
b2RlcyB1c2U6DQo+ID4+ICsNCj4gPj4gKwlyZXQgPSB1Y2xhc3NfZ2V0X2RldmljZV9ieV9uYW1l
KFVDTEFTU19OT1AsICJzb2NmcGdhLQ0KPiA+PiBtYWluZmlyZXdhbGwiLCAmZGV2KTsNCj4gPj4g
KwlyZXQgPSB1Y2xhc3NfZ2V0X2RldmljZV9ieV9uYW1lKFVDTEFTU19OT1AsICJzb2NmcGdhLQ0K
PiA+PiBtcGZlZmlyZXdhbGwiLA0KPiA+PiArJmRldik7DQo+ID4+ICsNCj4gPj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbWlzYy9LY29uZmlnIGIvZHJpdmVycy9taXNjL0tjb25maWcgaW5kZXgNCj4g
Pj4gZmNjZDliODliOC4uYzQyMzkwNWJhMiAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVycy9taXNj
L0tjb25maWcNCj4gPj4gKysrIGIvZHJpdmVycy9taXNjL0tjb25maWcNCj4gPj4gQEAgLTY4Myw0
ICs2ODMsMTEgQEAgY29uZmlnIFNMMjhDUExEDQo+ID4+ICAgCSAgdGhlIGJhc2UgZHJpdmVyIHdo
aWNoIHByb3ZpZGVzIGNvbW1vbiBhY2Nlc3MgbWV0aG9kcyBmb3IgdGhlDQo+ID4+ICAgCSAgc3Vi
LWRyaXZlcnMuDQo+ID4+DQo+ID4+ICtjb25maWcgU1BMX1NPQ0ZQR0FfRFRfUkVHDQo+ID4+ICsJ
Ym9vbCAiRW5hYmxlIHJlZ2lzdGVyIHNldHRpbmcgZnJvbSBkZXZpY2UgdHJlZSBpbiBTUEwiDQo+
ID4+ICsJZGVwZW5kcyBvbiBTUEwNCj4gPj4gKwloZWxwDQo+ID4+ICsJICBFbmFibGUgcmVnaXN0
ZXIgc2V0dGluZyBmcm9tIGRldmljZSB0cmVlLiBUaGlzIGFsc28NCj4gPj4gKwkgIHByb3ZpZGVz
IHVzZXIgYSBjbGVhbiBpbnRlcmZhY2UgYW5kIGFsbCByZWdpc3RlciBzZXR0aW5ncyBhcmUNCj4g
Pj4gKwkgIGNlbnRyYWxpemVkIGluIG9uZSBwbGFjZSwgZGV2aWNlIHRyZWUuDQo+ID4+ICAgZW5k
bWVudQ0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9taXNjL01ha2VmaWxlIGIvZHJpdmVycy9t
aXNjL01ha2VmaWxlIGluZGV4DQo+ID4+IGI2N2I4MjM1OGEuLjhmODEzZWRkODQgMTAwNjQ0DQo+
ID4+IC0tLSBhL2RyaXZlcnMvbWlzYy9NYWtlZmlsZQ0KPiA+PiArKysgYi9kcml2ZXJzL21pc2Mv
TWFrZWZpbGUNCj4gPj4gQEAgLTg5LDMgKzg5LDQgQEAgb2JqLSQoQ09ORklHX0szX0FWUzApICs9
IGszX2F2cy5vDQo+ID4+ICAgb2JqLSQoQ09ORklHX0VTTV9LMykgKz0gazNfZXNtLm8NCj4gPj4g
ICBvYmotJChDT05GSUdfRVNNX1BNSUMpICs9IGVzbV9wbWljLm8NCj4gPj4gICBvYmotJChDT05G
SUdfU0wyOENQTEQpICs9IHNsMjhjcGxkLm8NCj4gPj4gK29iai0kKENPTkZJR19TUExfU09DRlBH
QV9EVF9SRUcpICs9IHNvY2ZwZ2FfZHRyZWcubw0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9t
aXNjL3NvY2ZwZ2FfZHRyZWcuYw0KPiA+PiBiL2RyaXZlcnMvbWlzYy9zb2NmcGdhX2R0cmVnLmMg
bmV3IGZpbGUgbW9kZSAxMDA2NDQgaW5kZXgNCj4gPj4gMDAwMDAwMDAwMC4uOTgyZjk1OTJjYg0K
PiA+PiAtLS0gL2Rldi9udWxsDQo+ID4+ICsrKyBiL2RyaXZlcnMvbWlzYy9zb2NmcGdhX2R0cmVn
LmMNCj4gPj4gQEAgLTAsMCArMSwxMTcgQEANCj4gPj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiBHUEwtMi4wDQo+ID4+ICsvKg0KPiA+PiArICogQ29weXJpZ2h0IChDKSAyMDIzIEludGVs
IENvcnBvcmF0aW9uIDx3d3cuaW50ZWwuY29tPiAgKi8NCj4gPj4gKw0KPiA+PiArI2luY2x1ZGUg
PGFzbS9pby5oPg0KPiA+PiArI2luY2x1ZGUgPGNvbW1vbi5oPg0KPiA+PiArI2luY2x1ZGUgPGRt
Lmg+DQo+ID4+ICsjaW5jbHVkZSA8ZXJybm8uaD4NCj4gPg0KPiA+IFBsZWFzZSBtb3ZlIDxhc20v
aW8uaD4gYWJvdmUgdG8gaGVyZQ0KPiA+DQo+ID4+ICsjaW5jbHVkZSA8bGludXgvc2l6ZXMuaD4N
Cj4gDQo+IEEgZ29vZCBzdGFydGluZyBwb2ludCB3b3VsZCBiZSB0byBoYXZlIHNvY2ZwZ2EgNjRi
aXQgbWFpbnRhaW5lciAsIHdpdGhvdXQgdGhhdCAsDQo+IHRoZXNlIHBhdGNoZXMgYXJlIG9ubHkg
YmVpbmcgYXJjaGl2ZWQgLg0KDQpIaSwNCg0KSXMgb25seSBvbmUgc29jZnBnYSA2NGJpdCBtYWlu
dGFpbmVyIG5lZWRlZCBvciB0aGUgd2hvbGUgc29jZnBnYSA2NGJpdCBtYWludGFpbmVyIG5lZWQg
dG8gYmUgaW5jbHVkZWQgZm9yIHRoaXMgZHJpdmVyPw0KDQpUaGFua3MuDQoNClJlZ2FyZHMsDQpX
YW4gWWVlDQo=
