Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FDDC02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 04:46:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80CCB801F5;
	Wed, 22 Jan 2025 05:46:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="mWfEue6O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0B0A801FB; Wed, 22 Jan 2025 05:46:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17B868001F
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 05:45:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737521158; x=1769057158;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=2o8B6isJhmSRlXUxPYIc0kowgaPz9Jf801AT9kxPNAY=;
 b=mWfEue6OjHcvlEmQqUdzLa1CP/9U4oxzgCpByNTNNFu+hGeWIm4SL/kL
 E8uyRcv6/Q0Bwg8VPm/+kWOv+akJ+/FR+uRk+sNnNnjmj34VLv+SqKRSW
 lU4OeHrAa7FOds8x5u5yXJ1/ZokSg6wS7k7epFQeHxawbATXFgQZ/u0wN
 iUG89o/NJbnpF3Le2rn/45+1DlMUeQDEYO8tFOUjGM/0khg5QIizk1TYW
 p0iE8NBAqUXbpT4BDtUsDyDyWE1nNtOOdHK2Pw9gahGJEMMT0Ola7KAnK
 TeWyTOIqpmvPd/H3MG7feo/Nr7d6b9ZSOR0egJKg/Ps30Fr6o1oc6bsaF g==;
X-CSE-ConnectionGUID: odBlaF7nRGKGBNqIpaVTqg==
X-CSE-MsgGUID: YMtuLBk6R+2mX2Zh27bsYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="55377566"
X-IronPort-AV: E=Sophos;i="6.13,224,1732608000"; d="scan'208";a="55377566"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2025 20:45:53 -0800
X-CSE-ConnectionGUID: 2BFIoUXZQASVeUTBaIITGw==
X-CSE-MsgGUID: F+DLrtUvSf6Idju9Z4X6Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="111999503"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 Jan 2025 20:45:54 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 21 Jan 2025 20:45:53 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 21 Jan 2025 20:45:53 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 21 Jan 2025 20:45:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bAbnDg7yvo5alBu96FzlgDaHltI6VWiZT/2+TslppXRLMPe0+2YZ94HMe9HhpKX+78ih4HTJYX84N/wZJmpBRqlI85Q8aJrItR+jP++ausDmP2Fq9tf/iaTVFnLr313O8CurdrnoV4LcQ0V+PSWkkOzwydkZbDlgqTbpCc4f/CEsFTb5qMGnzsUOdhfNcCyylqgkWp0YabM1tOrfE6QSzv2NzHnogUbLsiUGuQx3ijSjj9W81X3TbloZP/Rn4aWrtL9M+Ip1xhNC+ybbEuJ5XPTmWki7VRiau4GTi+aRilVd9H1RN24XZHIqhzOO7XsW8F205UnPtxj02vMzLex1Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQWmv8K6bdsckKOF3wwruty8B+X6PzADwpbOSQvah98=;
 b=kUxF1x4CoOgcI6CASK5KYhRDQoz9pyb78wh7GEkYYewsc2WRgK8aDam6k3MR7Y+FAChT5/lhPiUUXnBmV3QCET621Jmsi72yVxLlUhwbpN8dB8VP+WEj0klsIl2T6chZPCNTQLoLvGSdkQYCvxtug7Qa1pHg+biSTVKwfSopoxIKpuWnTDmeXhpQhrwNAsVubv9L+Zgdsw4J86V2pccS0lYf+JSSq3LFtjkhe9YvbBFB2ODFGcOC0WmiD9s3aVBOQS9wIMOkU7PANybN+iMEd0jgnwDHhzjpyzdcVc2I6y4ejRIdbyRgmA/Tj6qB4Gkq71DfVQGtbxVvb3P5YVO1/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 PH7PR11MB7097.namprd11.prod.outlook.com (2603:10b6:510:20c::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.20; Wed, 22 Jan 2025 04:45:50 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe%4]) with mapi id 15.20.8356.014; Wed, 22 Jan 2025
 04:45:50 +0000
From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
To: "Ng, Boon Khai" <boon.khai.ng@intel.com>, Uboot Open List
 <u-boot@lists.denx.de>
CC: "Hea, Kok Kiang" <kok.kiang.hea@intel.com>, "Maniyam, Dinesh"
 <dinesh.maniyam@intel.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@intel.com>, "Zamri, Muhammad Hazim Izzat"
 <muhammad.hazim.izzat.zamri@intel.com>, Tien Fong Chee
 <tien.fong.chee@altera.com>, Kok Kiang Hea <kok.kiang.hea@altera.com>, Dinesh
 Maniyam <dinesh.maniyam@altera.com>, Alif Zakuan
 <alif.zakuan.yuslaimi@altera.com>, Boon Khai Ng <boon.khai.ng@altera.com>,
 Muhammad Hazim <muhammad.hazim.izzat.zamri@altera.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Subject: RE: [XGMAC RGMII-ID fix v1 1/1] net: dwc_eth_xgmac_socfpga: Add
 support for rgmii-id mode.
Thread-Topic: [XGMAC RGMII-ID fix v1 1/1] net: dwc_eth_xgmac_socfpga: Add
 support for rgmii-id mode.
Thread-Index: AQHbaKz2Kf67ksTIVE+9ZlaJtprlTbMiP1/A
Date: Wed, 22 Jan 2025 04:45:50 +0000
Message-ID: <DM8PR11MB559247B5EC60171847F3C84ED2E12@DM8PR11MB5592.namprd11.prod.outlook.com>
References: <20250117065625.27832-1-boon.khai.ng@intel.com>
 <20250117065625.27832-2-boon.khai.ng@intel.com>
In-Reply-To: <20250117065625.27832-2-boon.khai.ng@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|PH7PR11MB7097:EE_
x-ms-office365-filtering-correlation-id: e404131b-66ee-4feb-d899-08dd3a9fa526
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?zle5ORbDFieHtiI7FnZMLWYDE+5LA9M/za/5wBsWd6HBpuoawYy2LFYcvU/a?=
 =?us-ascii?Q?dRkKK5ULHD6nyDHM8sv4Cnq8JBsKqAV6/xSs6xBfVRshFH3X8xfe+4D9xHNL?=
 =?us-ascii?Q?u1I+RNX6E9sS4Lf2k+whB8rytjNfCEShHx8tGch2624GbPB7SzLUTSbz1FrA?=
 =?us-ascii?Q?KEXrj3QOY5r8ptY1L7YVGSlbaRQYlh8MkCHZmG+UwIWJM0aoX78VzkPowVwA?=
 =?us-ascii?Q?txfRsoPXtWOOxl4VKs2/H6GA9UDKhQFOH/YzRKlptFdyf7+NUNozfVuUOERJ?=
 =?us-ascii?Q?S4f+w8mE18k17e41NQZ/bVrFvkhuKOiOdelG9Vdu6MCtwvfVk9rH97dL7Jya?=
 =?us-ascii?Q?TcijoNBMQ1P7eLzLVH4FmpphWPO6k+pti89LEX1OxJ7MFmOTIdLitk8KFAlZ?=
 =?us-ascii?Q?WJvUP30KHTTvjI5rT72tLya5MXiXk3lLBBRRIuYIlY8CAiKBTO+vf3faJCRM?=
 =?us-ascii?Q?CRZcxA4+C5QZ4NglbK/xnwCfOoDGMK7lptjc4nGY5BIgdVNCSBLLiRruyswS?=
 =?us-ascii?Q?6g7vwYCWNfMQ2OXowItbzRYc/FomImQeE7MVbhWVMAqN/yh0lTA6EeHFWOeD?=
 =?us-ascii?Q?H4H7FDF04RnX6zqktTiMGYDXWUtoS749LUQmATRsTXcxqhHtiqLFXVeZsExP?=
 =?us-ascii?Q?RvRTPGx4dsVvBCQWCR6ThOTR/bs9D4Qv57H2PBc21YJAHG99kF3+df9cSqsv?=
 =?us-ascii?Q?UN4lysKSyQANSIOdNnRMwubKDA/SY6xD1BBorZpaXL3H7UtM1aOCLj0kkg2R?=
 =?us-ascii?Q?Kd7/3AgDsW1WOotN7iECRyGsHbqgVYdxpCzGbcUrNRv6JuDq0HCMbnjbMMQO?=
 =?us-ascii?Q?Xb4FOAJUqBN2eYt0EoQFBtj3VRZKz1Mj+SD6QKwEua1OWMpaKbcw/iPmZuUK?=
 =?us-ascii?Q?Calrk3j0pyObJT56vDtt4kSLVndv57kX8+jNXk9brKiYEa3AvwuBEFcOm7K8?=
 =?us-ascii?Q?iSeuYJByspqL2P6i5/o+xv2wdacGySFPcP5CNDO8lbhdj0n+XYxJ4gyYH3m/?=
 =?us-ascii?Q?7TpIey8YIq7TQ3dSEO7iTuNzxh2wtAgpg5yphH9iJCIxgXecI8ufH32h9YY8?=
 =?us-ascii?Q?M/SrBRVi0WB2efJJjdf8YfHxD55koKyULH65P6i4zxTPDhUZVUxFo8w64CLa?=
 =?us-ascii?Q?I2cVcSizHSPQ2ccqqcJ0JJgZD8asL+ITtw/R8328MIWH+TrO0gCF7aXNPtqS?=
 =?us-ascii?Q?DoBGN/e9217/lGeiIJcsMCE2Km3BGJpFMNIZSenJmxD29Rn1/dC1oglreBho?=
 =?us-ascii?Q?WKsPRwkaCTWglqqQymwrHcrcWseHL1fGm1ljdIAS4wskJpVZ2wWHNHmAG5z+?=
 =?us-ascii?Q?S46m4XJKONr9pweGxme4P3dC5lVknVrAlhv/QMc8hjVq8yuZ3vCh7vQIgzdy?=
 =?us-ascii?Q?mQ1J8KGGSXWvsT/WQEcMqVNL8vg/iGcXM5c+WtF3pfdvxufqBCVis7jhtPyX?=
 =?us-ascii?Q?0m6QuyUsPoxbp6gN0+vtRApeJdLgg547?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5592.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PQUPnFpp9WPDwohUjRMC6ISqlOiRy9jak90FXOxfsbM9TsYgZcuczekjU8Ob?=
 =?us-ascii?Q?8nX6QJrzG72dggOQGSwryPT5MwXT7iOVcW5zpcgvzN523ZGsFizvBkhfdmG1?=
 =?us-ascii?Q?46FX8JiC8PSn/Aj95a++wHYxWo8IfKMOzVNPXMiKlQAIDV7rfnlVG+hYqNAw?=
 =?us-ascii?Q?c+lUEQf64rMPFhTdk5x6Y3rPw+Nzittg66U4B5emPuYwDgChAg5JmGpEQW2C?=
 =?us-ascii?Q?sOEEvNSLZmlyzgssntOiRAxwJ7jopPONtcUiQNXiof4XnqfdAKBinY5hyTCu?=
 =?us-ascii?Q?pnRWVxQ7h4bZ1MAyDlJWvvJUHMQ9P45y4sHpSeJw/jTNlmTCtRoCh+R4rmoR?=
 =?us-ascii?Q?Q0LqTnPJOb1kJDcreQKPQuKeBHV+w+PjvNS8Iu8VQpXBrXxNijTac7LITrSz?=
 =?us-ascii?Q?97Kw7jMGvf0AYcQkMJmTzGpf4hRTFlJeSDL67+xm1OHMJHe9zh332RsKjns8?=
 =?us-ascii?Q?WQwgsTmOM0QkMAjTTcku0/YMrnzP+bSks9El6vU5e/9u/I/ufKREzxechJju?=
 =?us-ascii?Q?/eb9PcBLGpJ2doHpc7YaNYHk6pmq8mygwKOccgwsP3mVw1ORMn/mU8GZ5f+H?=
 =?us-ascii?Q?9Qh1m9xfoX7BBipt3A9QzKgy4SIu2K5OfpOhlGqG7/1Nx5Q3MhRpj3gXcDfw?=
 =?us-ascii?Q?zAZgc2WIWWt/Op/vy0D3M6mayPbynv+5JfRK9eYBFSAS6DjopHjbKLl9qMaJ?=
 =?us-ascii?Q?gXYY9QwhpNdznDErqnL+fRE0kywV6POySevXw9TEYT3nX2VQKEW6i7RZqsbe?=
 =?us-ascii?Q?YTIWWTssvcOmIKIm3g16U71Y0l2wSu/+24KC9U0XSFvmqH2GPOHqi+sPJlSX?=
 =?us-ascii?Q?hPZ8AGyyAJ2ph2VH7vP+ToynWkQl6M90RTgQK1p5htBK7oHw17akgJEo18NI?=
 =?us-ascii?Q?+wuxBl4zzSk486gRzZ/GjYaBpVbGf3PdP2skWMa6XDTMaI8A181/2IMT4UXf?=
 =?us-ascii?Q?PoW7yftA4gC7AMtJG+7FfVyPbO6jzCUqFFltcc0QkrgCD7raCfIabnsjLyOU?=
 =?us-ascii?Q?CI1KZW+L0kijmjVWX1Iq5KZPVYZCK4L+wMjhXgXLy/EGo7Y8mlex/N0Z/FPU?=
 =?us-ascii?Q?MhB8ZnTsWl03JRd7fvJvAyGt502uTdxdMrPvLWty/mn/A9z0Xu0qooo0VRmF?=
 =?us-ascii?Q?NjpSNtBc2dXfRirDg5AamDgiFTJ/dKGbRggE2SFfrq+v32HcqBGeYWJJJHIL?=
 =?us-ascii?Q?7eFYZWXqLklhjGbbkRXuowWvBG4vesKemURkMBtbLkUKWLtoV8VP87O00iyP?=
 =?us-ascii?Q?KcbzhTAhOie8MJKr7E3ALVe3VsTTK1Vb99z8wn+ix0azlXtnLytUrMZa/teX?=
 =?us-ascii?Q?ScEgRoMBKeBKBxVarK85krhVge7iZPmTwt45udf9Z7qAGg3Soir2ZjrprsXT?=
 =?us-ascii?Q?1QHaI3noH2+fTTuXXgJ8lJB02H4cYssKHKTLVZLu5yhGxUgS1/adGz7yqc/m?=
 =?us-ascii?Q?DrC11pACuqFOsZwuA8OrQyAMnxK4T4t3TJeiEienUQj4hcDuOmho9jctaNeB?=
 =?us-ascii?Q?IgNoC5bK3ER+HJ/Uz1jX+cm2uOLXGrHrKhksIMOoZ3qHuDh32qgJ9qLDN8+y?=
 =?us-ascii?Q?NT4mW7VonQFzz9wlvyCen+hMTaLlehbuadRUtIVy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e404131b-66ee-4feb-d899-08dd3a9fa526
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2025 04:45:50.0698 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QueOxmvaz3SX5aCJayZER9XJyyDPXJtZ0g7u6aUZMR2icfcQrqGyjD5rOUgxPjdUNRHfMDzshMDGezZfcaj7DkOUqo2BRVzQgpuZg0ZCpHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7097
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
> From: Ng, Boon Khai <boon.khai.ng@intel.com>
> Sent: Friday, January 17, 2025 2:56 PM
> To: Uboot Open List <u-boot@lists.denx.de>
> Cc: Chee, Tien Fong <tien.fong.chee@intel.com>; Hea, Kok Kiang
> <kok.kiang.hea@intel.com>; Maniyam, Dinesh
> <dinesh.maniyam@intel.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@intel.com>; Zamri, Muhammad Hazim Izzat
> <muhammad.hazim.izzat.zamri@intel.com>; Tien Fong Chee
> <tien.fong.chee@altera.com>; Kok Kiang Hea <kok.kiang.hea@altera.com>;
> Dinesh Maniyam <dinesh.maniyam@altera.com>; Alif Zakuan
> <alif.zakuan.yuslaimi@altera.com>; Boon Khai Ng
> <boon.khai.ng@altera.com>; Muhammad Hazim
> <muhammad.hazim.izzat.zamri@altera.com>; Joe Hershberger
> <joe.hershberger@ni.com>; Ramon Fried <rfried.dev@gmail.com>; Tom Rini
> <trini@konsulko.com>; Simon Glass <sjg@chromium.org>; Ng, Boon Khai
> <boon.khai.ng@intel.com>
> Subject: [XGMAC RGMII-ID fix v1 1/1] net: dwc_eth_xgmac_socfpga: Add
> support for rgmii-id mode.
>=20
> An issue was identified where selecting the phy-mode as rgmii-id in the
> device tree source (DTS) would cause the `dwc_eth_xgmac_socfpga` driver
> to raise an unsupported phy mode error.
>=20
> From the MAC controller's perspective, the rgmii and rgmii-id phy modes a=
re
> effectively identical. To address this, both modes will now be configured=
 to
> rgmii in the MAC controller.
>=20
> This change ensures that the rgmii-id phy mode is properly supported
> without error.
>=20
> Signed-off-by: Boon Khai Ng <boon.khai.ng@intel.com>
> ---
>  drivers/net/dwc_eth_xgmac_socfpga.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/dwc_eth_xgmac_socfpga.c
> b/drivers/net/dwc_eth_xgmac_socfpga.c
> index 87fb7e887e..1864187c17 100644
> --- a/drivers/net/dwc_eth_xgmac_socfpga.c
> +++ b/drivers/net/dwc_eth_xgmac_socfpga.c
> @@ -80,6 +80,7 @@ static int xgmac_probe_resources_socfpga(struct
> udevice *dev)
>  		modereg =3D SYSMGR_EMACGRP_CTRL_PHYSEL_ENUM_RMII;
>  		break;
>  	case PHY_INTERFACE_MODE_RGMII:
> +	case PHY_INTERFACE_MODE_RGMII_ID:
>  		modereg =3D
> SYSMGR_EMACGRP_CTRL_PHYSEL_ENUM_RGMII;
>  		break;
>  	default:
> --
> 2.26.2

Reviewed-by: Tien Fong Chee <tien.fong.chee@intel.com>

Best regards,
Tien Fong
