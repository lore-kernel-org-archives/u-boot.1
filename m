Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22415C021A0
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 05:11:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B435807F1;
	Mon, 17 Feb 2025 06:11:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Zpn+tanS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 576FE80C7E; Mon, 17 Feb 2025 03:35:49 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CAE4808B6
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 03:35:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739759747; x=1771295747;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+lqmOpZWXjz86lQtQvhz6Z3UfyzuChx1w8d7/DChDxs=;
 b=Zpn+tanSZrYkcp6jA/KJTsB7wdBiTMPwABfrCnNapBHQma4fsbn7H4E6
 D95rBGlKfhm7Hw7tktFXACph3cVXLTrkx87/UngQLHCXtv+1Dj44e4r78
 yuRYpTNTATcMpLy7UPeeYZLJaVAvDDLadbMGGSo2Uj/TB1xmtKHVpOVXc
 xrbsvvHb34YLQf7vN2mgicS1yVtfkoQGAFnTCguTzbLI8f7AF06+CWRhI
 F/hBnLk7c4oLddPVp9FerG5C4+iHz+DWAsFvZJq8sOrthPWgEOoatnK9x
 ETkIvzOnS/wryHs9XDpA4M09iKjp2MYASLX58J0XnHbgKBS8kC97aUSOV w==;
X-CSE-ConnectionGUID: NzVF5NG3SEaO03YcBmPwmQ==
X-CSE-MsgGUID: YpohBOw0TPio9efwGk7xyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="57962635"
X-IronPort-AV: E=Sophos;i="6.13,291,1732608000"; d="scan'208";a="57962635"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2025 18:35:45 -0800
X-CSE-ConnectionGUID: RzpHX+urRI+9onvt9s8QKg==
X-CSE-MsgGUID: rsUAdoPOQYmicRNKmHqosg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,291,1732608000"; d="scan'208";a="114623005"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 16 Feb 2025 18:34:41 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 16 Feb 2025 18:34:41 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 16 Feb 2025 18:34:41 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 16 Feb 2025 18:34:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UZSVVZcdgWnP7RtiTNvF845ywigvRqJL+Wu+yKrArpNnAJw7Qyb5+5seoGdg2qoFvtqxMMVXaEFI4NjKZ6onS/fy6wxvirhg+VFS/YH81Ouyk9SXxeV6csOd3Cl12SDrb1CLibvute5KaU0aIvy14F+40MEuCG0L61a9968M9wQqVJE5xDspTDWDT8FSmX/SIXm823vZ7bPlPakJokU9Ih2qcmQPjbN4y7Vim3ebDq0oKUTOWEXDKpAsb3HrBQRVt81VMF8lT80AV0ppa8DBXAUfiblHztE0Nc9dGdEmJ0TBpJMMpNT8en7dBFMLK6NcVI1uxbCVJO3UwdeR7PWzdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2n+lD2l2j8BvwmQjnP60adQrkn0n3sgVpLeHcQpKVNU=;
 b=cmaXXMPnl0755j7G0H6HzGT4frmGrPXc/BYDoBx/ESbs1aSD44LZRoFAWi5D9TOSJXl/G/X69XKf8i23FzKi+doqHj1tDDrXInufSjywOdYvIfohCmCOcBuCSjqi9kM4Xu9iq0D8cM1otETMes6LSLLtDdWWahkd4lV2eOlQ3p2sDRsHAIjr55+8BEWiNkRaWE1y44E3vVY9Tlu90RpV4cXCFyjpvmV86AHHyvLDd3TP07GVRz8uBaUWMA2R3UDObwtgk1gaXQMXEAcJU938rUlkrWvYKkGo2EMlYJoEgQVjzNjEzEigH8PXCQcIplb72y0gwd7bkg0hoyFebX1RqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 CY5PR11MB6140.namprd11.prod.outlook.com (2603:10b6:930:28::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.18; Mon, 17 Feb 2025 02:34:25 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::4046:430d:f16c:b842]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::4046:430d:f16c:b842%5]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 02:34:24 +0000
From: "Ng, Boon Khai" <boon.khai.ng@intel.com>
To: Tom Rini <trini@konsulko.com>
CC: Uboot Open List <u-boot@lists.denx.de>, "Chee, Tien Fong"
 <tien.fong.chee@intel.com>, "Hea, Kok Kiang" <kok.kiang.hea@intel.com>,
 "Maniyam, Dinesh" <dinesh.maniyam@intel.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@intel.com>, "Zamri, Muhammad Hazim Izzat"
 <muhammad.hazim.izzat.zamri@intel.com>
Subject: RE: [XGMAC dt bindings v1 1/1] dt: net: add DWC XGMAC binding
Thread-Topic: [XGMAC dt bindings v1 1/1] dt: net: add DWC XGMAC binding
Thread-Index: AQHbaI4f6BC9zwne0kCMiatxko5uWbMbQTMAgC+2AJA=
Date: Mon, 17 Feb 2025 02:34:24 +0000
Message-ID: <DM8PR11MB5751359F31EDC36DABABCF8CC1FB2@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20250117031535.19595-1-boon.khai.ng@intel.com>
 <20250117031535.19595-2-boon.khai.ng@intel.com>
 <20250117175638.GV3476@bill-the-cat>
In-Reply-To: <20250117175638.GV3476@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|CY5PR11MB6140:EE_
x-ms-office365-filtering-correlation-id: 7a9d5224-774c-4137-bd60-08dd4efb97e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?8xc8qLuhkDhuyV9rS132+LYlkyakRE39yPafEFBDrhhoBbddbS2nW3vzDyxk?=
 =?us-ascii?Q?HeNt7zw1JDeg1TL9ZX9SMd7FSs4tAUhAmnzRNDuLiPgC158i+Ic3V0JfeT4c?=
 =?us-ascii?Q?XqMYTfVdL6NElFZOZ+sE6UH7RwkYymtygwScsSxioJYxBC+9qnsHGE96rQFb?=
 =?us-ascii?Q?778bZ5G0D/y/CTFvCNrZsdJQR2grI3SQ6wBq4bHGjNEa/dchD3g3WLJWLHE/?=
 =?us-ascii?Q?hXErsWSk+EWTO8bWSb4Je4ZOkh6RT84IORRYYND/bHy73096OhhCKVzz7xnh?=
 =?us-ascii?Q?uwHa2XHu05OxkPcBk7AMC+dk1IpbwyT76fZwJtCC0BD88N1oCPIIJZiAjnq9?=
 =?us-ascii?Q?A8KKcaapmGZX5hEoGrkbX/+4U66UMNqXxF8atm/lvhuZObeMoAUHhSvbFwLB?=
 =?us-ascii?Q?C9o4OCdpZfc4fHgX0kd3YRRomYdZ2ig2kLxXiC6M13eam6TFnAe0XhkR2fbq?=
 =?us-ascii?Q?L3EFN9NL0UDKKGkJ3h7g8qYLQLSmxs7wy2PBFdkEEpppubN9b3r6eJKz/1D2?=
 =?us-ascii?Q?rxZH1Spv5QYYPtMyUcsGRoqK6uCJM2rmDF120ubYVamGVlKCpn9nby44r99G?=
 =?us-ascii?Q?VR4MXMmYYwdKy1fgAiopPwK74TFutyjhrwxohtGDY8beTvnSmt3AxrRa3jzy?=
 =?us-ascii?Q?C7MlH0e0qu1UB3oB2N7aSyMCVB7S781d+u1UyWpIrHpqw5x3Mi1kpDYUwZml?=
 =?us-ascii?Q?zvz8BNXr6hFGVLIn2aUGH1d+8cFGzZ/btqm1jds4aC91uqBguk4KxpBSnfzV?=
 =?us-ascii?Q?ZzVGEO/dsGfsWyZWYovebZiqaTAhU7Sy1a/O27aXPzgqH7b0/LZfZyfvqp66?=
 =?us-ascii?Q?KLCAoiutZh+cnyfKbVR8nTrXkuvVrNFKzJ3VWlwQ7XLxWc7mKizjvhq8MY0l?=
 =?us-ascii?Q?y4TrpXPmtFrOOJpGGI4MHuaxnpHTY5XczJOqaErJdxDsX9xhUWeJDCvEvEOz?=
 =?us-ascii?Q?moNiFU9oRp/rOpQLKC9cASiCcalCkfpPgtynzrn194ubBL2xBhBL46EdU1zE?=
 =?us-ascii?Q?Q50wS42b5uCZJHN09tqo75Civf1sqVN46LNFohbB9hIy9N3P5gBvM+9qzlry?=
 =?us-ascii?Q?CDzcEXR+CMUQUjf6C6zwh1qwUBrVXY3EwQPj0/PpubAL16QOYdE5PVveGeLM?=
 =?us-ascii?Q?Wq6BZjZ00A07cycvUJYLtOlT509y9lwpJ9hkd74Y6ZuEmd5qqDSGTHhiy0+A?=
 =?us-ascii?Q?MfvS3/XZAOqI7FqjaxZ6dxXE0etF/fdsNS7ecD3g9FkK6mAJLQ39mVbivqSI?=
 =?us-ascii?Q?Lv0s61t16rWmc8g+OR5lPp7fmkN5iDDcqnViDu5vn1usAOkvg2YqZ61rKt86?=
 =?us-ascii?Q?dptbktVTiBxFB4rjtRUe1AimeuzSSpb5TjJ+jUDhwCwbMEfqi5jR0fpiDz6l?=
 =?us-ascii?Q?b6N3L+nPHN3sT3+NoUH4Lwn32r/ZZbkQfVVLMtiLnuBhM/zpBwCCC9lHh9GA?=
 =?us-ascii?Q?k73nyxMgabP1cXb5HfFHkQ1UHOR+93Uw?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5751.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/9z16d4ChFcCOKdtxjTxDo8riJNvsenzoc+lRZh3wO98sgYM5gJkv1bVCaug?=
 =?us-ascii?Q?Tcg0j0/YZ29km+UdSleW7v4qJuEnF9xZH1yAC4XOiBTGLXeQIRcfFUf1Hdm0?=
 =?us-ascii?Q?PPyUPPafFzYvgn0ah1ovjC2caO4UMEvsixlD1uwVaZjdbolO6RHYsD5yn9rl?=
 =?us-ascii?Q?GSqFSrayzORLHM9Ii6cs6wRusjRjIDTH43VeuQAYmh8DVW5Hw0mN6ABadKLA?=
 =?us-ascii?Q?jJ/ecbONtVSGFA9Ggo2fd7Gb0EY/jeEoaCV4vpbIi8K2vcnqP10OgtpnA/g2?=
 =?us-ascii?Q?3t+qTUiG74eBTe87URo1IGICIMw3JL8wbwete7EV+eshBEgYp/E5bInWVEox?=
 =?us-ascii?Q?q9WbjlldE4c3WqhixKtHJBI6aeNx2ohvygjrY1bVYidwrxNOGo3qXv7Unl/z?=
 =?us-ascii?Q?ZfLdOToXEH0WATmuzblYz++QOA6yK8m/dK56gG+5Zy4Erz3xNueQAZrpYcDl?=
 =?us-ascii?Q?wDsaOrPT3VoTu2dmMFdXNRIVZVbO5Mxlui8LQl0x831ac+Gum/pxNSZK9kgc?=
 =?us-ascii?Q?nUB3tzUI+j8UZ5JNPj64Fy0A78PVrKm2isPEJ7ixDEgrqUWs8y6xjSAbQ9MP?=
 =?us-ascii?Q?kG3wW+4z0eOVsAfAfZvC/GlPpszKQ77XlVZbFBbG61CZ97bk7n+lElI2ZYZS?=
 =?us-ascii?Q?kCMyN9Zv0ndtcIAUAYNIxKrTIK7T45Mw4+qQPSM9NRjnyBG3SVeDwthY0g8A?=
 =?us-ascii?Q?Fk/WVZS8TtD7idIfGClsJZBnXI0zJkI+NL3fprD8/9626bUHW5UQJnFRgRQC?=
 =?us-ascii?Q?zSrPNEMb38s3HZwmSTrC1PGtvez8Eo6Q8HZq/NxxhU4Gz7aersZC/9K94UzT?=
 =?us-ascii?Q?R0bdUlnrjXb4fQeAnYKg9sarYDjl/UGDjaXPP2rJ4VmBBcARZZwormFMI21R?=
 =?us-ascii?Q?Dma1aE2OA81rfW2tKW6E6K3FfXeuqHK92gYAR32MJLozvwh9o/wixc+xBu88?=
 =?us-ascii?Q?3zRw9BEtFrnTxqK2asXaBu96uUkXyIn/eoQ/R0+HLBzktoYcOtMtSQwWd/9I?=
 =?us-ascii?Q?Yr7A6+zlBcZNPt9ZWxXeq2zbOG3LD73nVVBI6vp7YPEDPWhrVMwcSpkWPOB8?=
 =?us-ascii?Q?mlAfAs2j81vGVH3/l2+eakioiKK3qu7DsMcjGRcTVc26f90kfrHvhIl3mMia?=
 =?us-ascii?Q?M4jF4Xtb4IBgP39cienM6j9R8etk2kEii0g/Ijy8Z17RAFXskgs7Z2PoirTM?=
 =?us-ascii?Q?hMFx+WA1qLul6PIT10OYb1XSq7S4UwlwHlD07EErT+G95J31MrC7JZfzKDFh?=
 =?us-ascii?Q?0LB/yWIWO4HTObmGlJNxgnbmuK13qtE7Ftt0ALiG3ERJjbIfGBq3Bgj93KOL?=
 =?us-ascii?Q?xIWSZqC4nfYdTwOJrMQTkcVIHssRLyL8Evi+MRWl9tszB+QphS/4vX6s0AKo?=
 =?us-ascii?Q?4B8nmeU7QOfBTqDA/ImZVFJeE9SEsoh8cNxPl5HNEoDCf6HaI3aToMoRJhmk?=
 =?us-ascii?Q?BlVdnMRmes5kOBogaR26Zs0QLc4vWwziJ+/uNx7ltW1/qkrthXhpowSFH4Yk?=
 =?us-ascii?Q?vtOzICcXIfAWBc9QpCRz8r9kmMtO/uwhrcR67GJ/ZozocsHE5WlYTgrxpfMB?=
 =?us-ascii?Q?VY/0Rb0KezJwO3EEv+WkWKYOh/hSFvMudwS6LBys?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9d5224-774c-4137-bd60-08dd4efb97e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2025 02:34:24.8339 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SpWRSHANJSl6BnrmBTVMSx6Y8vma5vo/PM5Tt515wySdRO/GqivAYLeYmBOYiSCM3/qDhFTgRhXHoo5ONbUyTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6140
X-OriginatorOrg: intel.com
X-Mailman-Approved-At: Mon, 17 Feb 2025 06:11:31 +0100
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
> Sent: Saturday, 18 January, 2025 1:57 AM
> To: Ng, Boon Khai <boon.khai.ng@intel.com>
> Cc: Uboot Open List <u-boot@lists.denx.de>; Chee, Tien Fong
> <tien.fong.chee@intel.com>; Hea, Kok Kiang <kok.kiang.hea@intel.com>;
> Maniyam, Dinesh <dinesh.maniyam@intel.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@intel.com>; Zamri, Muhammad Hazim Izzat
> <muhammad.hazim.izzat.zamri@intel.com>
> Subject: Re: [XGMAC dt bindings v1 1/1] dt: net: add DWC XGMAC binding
>=20
> On Fri, Jan 17, 2025 at 11:15:34AM +0800, Boon Khai Ng wrote:
>=20
> > The Synopsys DWC XGMAC is a configurable Ethernet MAC/DMA IP block
> > which supports multiple options for bus type, clocking and reset
> > structure, and feature list.
> >
> > Signed-off-by: Boon Khai Ng <boon.khai.ng@intel.com>
> > ---
> >  .../net/snps,dwc-xgmac-ethernet.txt           | 67 +++++++++++++++++++
> >  1 file changed, 67 insertions(+)
> >  create mode 100644
> > doc/device-tree-bindings/net/snps,dwc-xgmac-ethernet.txt
>=20
> Same comments as the first binding patch.

Hi Tom, I didn't quite get the context, the previous comment in the first b=
inding patch
were " We need to just use the upstream binding here, thanks."

Do you mean I can just use the doc/device-tree-bindings/net/stmmac.txt
as the binding for the xgmac driver?

>=20
> --
> Tom
