Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E75AC021AB
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 07:29:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EFA2801DE;
	Wed, 19 Feb 2025 08:29:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hUkDECrQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B292809A4; Wed, 19 Feb 2025 08:28:59 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 193BA800D7
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 08:28:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739950136; x=1771486136;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=0h3Z8FLVcidCFWZ3RGY3/hS6nLVTpUXNc0OlYjkxOQU=;
 b=hUkDECrQpkt4+lgf2E8OW0FyF8XwEpeVdd/mpscLJ5WbdjbgSQHSizHv
 s830kzkg0T1C67bcaD+PK46fn7yDhYUqLw7FXfwYWoIRwZ6EkMXQuJdej
 /HLJehF9cBCsMNthyIPcbRcAFX+MEQ7xbYWkW1hWuwHhQcMvdqOiMCjuI
 1Pr3OYCoQyOSktMz8HMwRC9SzcQyVrG0hBn4LKb/EqZ3QTyaYpVXSlzIP
 am76RHuLxL+Vb65nyZdw7I9FeLqQ5O15XYNKPPHUXZa/BGMNlooZiee2E
 CfkERdGc96rkMsv3100y5LcrVShDE7p79hOJligfQEs3mX/6QyqZ6rwZX g==;
X-CSE-ConnectionGUID: +NWJiS+/TbqBUWeyM94cRg==
X-CSE-MsgGUID: UfGeufpnSrycJNaZ+vV01Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44323088"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; d="scan'208";a="44323088"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 23:28:54 -0800
X-CSE-ConnectionGUID: /z5aN6zMQf+4R3YU0kpLBA==
X-CSE-MsgGUID: WVSIHaY6S9Sxw0iGaYdAAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; d="scan'208";a="115148712"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 23:28:54 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Feb 2025 23:28:53 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Feb 2025 23:28:53 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 23:28:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ld1Q1lR4LGiVNvgKPwiPeJ9aE4cvkjFP77mJv/0REsAgV0mvyIQrKz4iW6hJyuo7J2TxBvM7gkDLcQjkbp4B3myeHEW+1+I0kha23VLW1l4mugE1O+zUZ6oLWX9BuaBVW9y0QrsGNRq9dKNfFrYHQhUnP208MuT1gBWziw284H/spARbyrmBrYlj4YomfPueh+1FS2dL/PtMYs6LJRB4tzdSJ9Lcs+OAYjKKordXig/ngHk2Mh4NCoqJOsZ4pQjjrheIy3b79lXWob08vlcmQRgDvdbkeiF8xqO/bA0cCIhFv9JZpB7HU7QrsT1AZ00PcCRc1nW0fCCj5zXyELk9Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5ZnzVmsESKievDStVptLb/1ZpSQhgjWkp2SPKWVef8=;
 b=uZks5J0c8Pm6SzlsJc9Fd6ZFmPDkkLz/pUfICHYdkHdYUEmwlSgdxTrTt+OpL8NMDAHCysyNTaqWIweSvcUuXgAJogUWLN3T4EmsB4ALApxLEGrKLK7JcNqBI7Sxch555K3IzmzniCTR2w8LGKL9+eDSjQF+A0N3iphxE4NvEUSfHqSYwbwFcD3GfXDMlLgH4ZivNgU76vmNz9kQSDUiud2n4L05cNUEYpWqEOAI05MEs5qZVd7NPiq9eb330BJTmqjxMZ5yHQE7cMh0UEkg/LKcRi1qOG9m+L0i2YaDBK+1RfgCzcflPGHbB3ZKc/rjneX+FQ8LfCv2v+45S6p23Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 CYYPR11MB8405.namprd11.prod.outlook.com (2603:10b6:930:c6::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.18; Wed, 19 Feb 2025 07:28:21 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe%4]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 07:28:20 +0000
From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
To: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, "Lim, Jit Loon" <jit.loon.lim@intel.com>,
 Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Alif Zakuan Yuslaimi
 <alif.zakuan.yuslaimi@altera.com>
Subject: RE: [PATCH v1] arch: arm: dts: agilex5: Enable I2C3
Thread-Topic: [PATCH v1] arch: arm: dts: agilex5: Enable I2C3
Thread-Index: AQHbeHC/irEDFBWo6k++2TZ5hXQkcrNOTrkg
Date: Wed, 19 Feb 2025 07:28:20 +0000
Message-ID: <DM8PR11MB559282B99D13AE68F9C5A1EDD2C52@DM8PR11MB5592.namprd11.prod.outlook.com>
References: <20250206082511.1531-1-alif.zakuan.yuslaimi@intel.com>
In-Reply-To: <20250206082511.1531-1-alif.zakuan.yuslaimi@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|CYYPR11MB8405:EE_
x-ms-office365-filtering-correlation-id: 27eefd64-e0c1-48e8-4ddf-08dd50b6fca1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ybNU8i2CsRZWeT05y/umF8gM5JjN3JDLx5pzJ4ULFyM8k5SnCMv3bIKmB+s6?=
 =?us-ascii?Q?2bu9kEpXjI39hR9vhQyhfn0lJL83PrsI67TKqK5uEyYVgf5aHwFduEc5lMFj?=
 =?us-ascii?Q?U6tHH5x+w5AtJmg/OTsI/XN9m5+0hDh9tKEaBBqlTn+D8GzmlsL8qeKJJgEg?=
 =?us-ascii?Q?VCkNnBuVH1zB/G+mg3i+mUCaZo3OW0Ig5UYcGdHKALzsj0XgMAPtjKoFufBd?=
 =?us-ascii?Q?wJRb7NxsmkmxXLvTh5wnOSSZ3EHTAveMG11fgGKuTRY4EcyMrrlszXU+bjYd?=
 =?us-ascii?Q?tbt/SeglCCOead9+lFL5xqqWm0lJGYuA+I5tTq0Uujm4SAPHWsIZ6w/cBHho?=
 =?us-ascii?Q?e4r3wZweVhxnPzwLjBOa/x+w645A49TgRJo8stXvWvlpezasSV86TkKh8n+Y?=
 =?us-ascii?Q?7AjF2qk4n5q+PR2AAnVIyMDHPqamf5IfvXmi7b1RzliHKvmKvzqgBRIk6P/b?=
 =?us-ascii?Q?tj0NPMEFFebspc1br+cENOXeXYmibXg1MxzayjuNME6P9jA9/PZbTkN49nQ4?=
 =?us-ascii?Q?T1dyrsifNpBVVY4zMIJo0RFY3hqg0FirSz9qKxb+CXBmCzjrbOp/MWkx+cTx?=
 =?us-ascii?Q?CLXMn5TyWiaJfE709SrwwvK6utRXX/82tMluqlX9n1fYKvsvtcETYxPmcNtp?=
 =?us-ascii?Q?RtZPEJOlnHA/NWFix2GOBMqGUD4a0HEjJ/Jesp08YW2DjErcB2W85zANv36o?=
 =?us-ascii?Q?xN9SXIYDeIwq8sRKlgdfwHRbA4ACovccEesd+qRdsaWFqeyIXKJ+SenoOIS6?=
 =?us-ascii?Q?bNcRo9L76VkIQ2NZLRrQ7BWnPLqBnYURa1RH9pSnaI9uLyplBVxTFO0Snx8R?=
 =?us-ascii?Q?5Wh3DG/Q/6pX/4uZisJchzww5mup6CcYYY6imdKW2P0rIInkKx61CPZaswBQ?=
 =?us-ascii?Q?Qe8QQYWL7w5FpjbdmizsZ7+4udvThfImo9zcxzcZvCPjw7H1YByfHDrcE7EH?=
 =?us-ascii?Q?mZ8okpJuBXxSjC7/nfrp+Xi1MIBbzC4BHnbOSLLJkdpR8nDYxrw4fXwBv1Vm?=
 =?us-ascii?Q?7B1uL43h8c1kSaVoGWQ8IpY9MnP4Ec9JCqlLW1jwiZpVKZKFXA8xNNGqSBHt?=
 =?us-ascii?Q?zrfzo3B3oKIp5kkjdVi0o099VdCljdkr2Vdh3DUNpfk6W9PeTjNSn4kc673r?=
 =?us-ascii?Q?td/E3mgCytE3owFzdHjzc0wpNB6RZnOa53Bw0DzggSJ6dDdywEwV2fvCdLdj?=
 =?us-ascii?Q?14s+u1xpg1IIlU8jo35K5ywin2ggMl9EaB4/9AklyWv9VrTgtkuFJ8cMIWCh?=
 =?us-ascii?Q?iOnB9OyeGRLMGeP9Tdn8BXkDfEilJjqk1iGbukyuRfBKTSjVRo4S0r7hhSqj?=
 =?us-ascii?Q?hhAiNU6mNX0hL+Uk8wjonFQNOI8EViTQWVFsUHq62p3xbf0ieN5xsVez81CV?=
 =?us-ascii?Q?tSTwlAoWXP14lAU95NsgDkWFfhFyU8gEg6MxwFggi6Pq0NuldIMJ64/J09yy?=
 =?us-ascii?Q?OeqftkOpm2Nr7sW67UDwZGXoZbgrdkqf?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5592.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Hz84QKDX6YaYbDRGtcMZgH/uZvM5Y++1adZobCUYGPWo65PgBJpYqUkntRdY?=
 =?us-ascii?Q?DWcWEjlYrhzTlmTLeoiwAbfpd2jIlD/a47t8WoybkAGw81vXyEWrc6y2bzVO?=
 =?us-ascii?Q?m/+xhMeqqVQdW3OcNzqAa8J5mW9ixc60tXk24qg5OOj5mJvZzYwzCAAcpNcu?=
 =?us-ascii?Q?f+RjuIJBVTvlVeGwGtQLe1QqCwgX3Cs0TMRsec6Z7xF18GjMwx2tqZFL5FMA?=
 =?us-ascii?Q?kOxtELAcARDY633AsZK2w9UwtBEtqXGhBctHksoB+Tf6UMlvslitFvjmWIGf?=
 =?us-ascii?Q?x/cVRcsqxdGd2roh2oAuWwxlvyo1WyvMSXruxCzK5CunwHbDo5ySkf5Ovyzq?=
 =?us-ascii?Q?rWEW5OumKzuaGnfgBv1ZFuWVqORaCeFyCIU2cx7iH1U/CKCFmy7PJoKjftTb?=
 =?us-ascii?Q?nUspfqy8jtM1kRoXeOLcxpK+1gCDYb795XYI+Ccdlpk8284KUCITsqb1FE7q?=
 =?us-ascii?Q?1ByZeo50Ifr+uqgNccP0NSNXsoEdrCkSktDmXpqCbfImtECuEufoTX0Hf2gy?=
 =?us-ascii?Q?E9RkIDvAGOwMFmmc1s2tqP30AMLS8X2zkSqpzJlgYNAAcR14bickMSzmQIGF?=
 =?us-ascii?Q?+y5g61hrxcaeKTQtWygWdGjJ/9FDnKW9Ix/pBGaDBOHZunJ81YwSGlNyW9q1?=
 =?us-ascii?Q?ROOj9MN90nGmj64qJvr0/blM+5KET8SPOqdU5yR4/7B47TXIZ5h0oOaQp1S1?=
 =?us-ascii?Q?jNFwonYs0OlZyHzjFGsOHjNsVW4qbB1okTtOkkNmOowVPqkXwMdYlfo/D1Ip?=
 =?us-ascii?Q?dP2zf1YaXWPqKNO0TnX3lzJl5at9vOAXNFgDiRpmXPpqiga9mA+UaWezzhCG?=
 =?us-ascii?Q?KJU5f1ifFmQr9WBKueAZ6oerkQgd5QkLPEHSlFXMekNK5KHfr4XAdAXR530L?=
 =?us-ascii?Q?wtfvsAl5rSmeKtbNzMayeyNckTpZylkuQiRL7VAD6prRbtJaxGyjYSfZ1OEl?=
 =?us-ascii?Q?aNFHpWpCnPWAJEwZB3HejklCfRdE8WzsaRMWXlnoE5r3LVRjRHMmaDhz5GgL?=
 =?us-ascii?Q?OVQKcD1q6Ysp8AL1zzqfFq1bHC9+JLEuSPDi9nh6ZFkDa8SZ8FUd36s7gXei?=
 =?us-ascii?Q?C5PtFHF9/l5rIxzWn+d07o91mrH3QqJgXWluVJ5cavJpZEh1o0UJBRf3KGFa?=
 =?us-ascii?Q?CYb2qlckFiFQ2RNaZeJkG83l5lX969F73KSNhDxrbZoWLPnu2guQVNClBT7m?=
 =?us-ascii?Q?ioQiOTY/fO9rq80vu4zUugX7KKSoXD1wVQmubQoPV3IMJ+ZIKtVW7her9V3z?=
 =?us-ascii?Q?RsOjgL61RmwdEgEbj9+mW/syxDF8gG8o+sS4jNqVYZsVPMNGKGlRgJVZq7OD?=
 =?us-ascii?Q?ejH74hIA3MuMprAez2DGLMxINYyH4YtEw4+9wUD9zPhWVCQmasIKIoybl/H6?=
 =?us-ascii?Q?3X+RhdoHrs6Jf7lecYa0LpevsIxFXAxJ9ujjTroFlMNEM0nMJRuyxEdz9VpA?=
 =?us-ascii?Q?XA+nmwTexZmZsv238hpXHanUAlmE1FhJ4CWpGoitvI/9+nKy/VLbrfDCOeIh?=
 =?us-ascii?Q?LdwEKdaJIZ2kU+T/lrIZUVxLqWLUsB1WJ70HnomC80Err8Bru+WIrN1W7xaC?=
 =?us-ascii?Q?s7b6HrB4gQBkUNbFcgJlAg5UEGEhjhNotdzSQQQ/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27eefd64-e0c1-48e8-4ddf-08dd50b6fca1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 07:28:20.8606 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cDuNSkpkw/uhsRqgmKxDkT1q0h8aC7UZ7E0AWrHSoJsjge/725eHwSVCHxAZB9a9flNawGRm9uMrw//94VTdGf7nk3GtotyDd4lZA/iZxgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8405
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
Sent: Thursday, February 6, 2025 4:25 PM
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>; Lim, Jit Loon <jit.loon.lim@intel.com>; =
Chee, Tien Fong <tien.fong.chee@intel.com>; Marek Vasut <marex@denx.de>; Si=
mon Goldschmidt <simon.k.r.goldschmidt@gmail.com>; Yuslaimi, Alif Zakuan <a=
lif.zakuan.yuslaimi@intel.com>; Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@=
altera.com>
Subject: [PATCH v1] arch: arm: dts: agilex5: Enable I2C3

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>

Enable i2c3 node in Agilex5 device tree

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/dts/socfpga_agilex5_socdk.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/socfpga_agilex5_socdk.dts b/arch/arm/dts/socfpga_=
agilex5_socdk.dts
index 852e1e5ae3c..ca87e99f9fa 100644
--- a/arch/arm/dts/socfpga_agilex5_socdk.dts
+++ b/arch/arm/dts/socfpga_agilex5_socdk.dts
@@ -62,6 +62,10 @@
 	status =3D "okay";
 };
=20
+&i2c3 {
+	status =3D "okay";
+};
+
 &i3c0 {
 	status =3D "okay";
 };
--=20
2.26.2

Reviewed-by: Tien Fong Chee <tien.fong.chee@intel.com>

Best regards,
Tien Fong

