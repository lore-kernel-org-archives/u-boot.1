Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53DD0C021BE
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 02:22:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 551A0807EE;
	Wed, 26 Feb 2025 03:21:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="BDAe+iw9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 826A080805; Wed, 26 Feb 2025 03:21:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59A8E80786
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 03:21:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740536515; x=1772072515;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=6gwMCtH4ZyuDU/N9OfdSBCRahUeAsYhSlLw0k6zKP/A=;
 b=BDAe+iw9Vf3DSkP3/qQcaujZD6SGf0V4JenN8thi2Zs5ds5PgMNPhdSq
 C3O2wZVjijohiTiDJ/gnDvx3J+ny+LgOUSTt132PI5FQibbsi3S6g4Q+C
 on9XIYklLZ9awK4BolU+oS1U1D5Vi1U6a5b3DmgVauP+SYi7TS+1QZBAk
 3gc+zCLj9/ZfNkq5ymP+20TkenFHvHKNfCE3VdkOvG/q+g/aobNuwU9a9
 gddws0yhFv00q+Ph4NKkXmiCAMn5SAimL/MyRPMSr4h8k+0zLVP+wq8yk
 eEblqr/EymWxYSRwZHpDDbqI4SLvTTKoLFFrdHioGTSvzqxog6T6GJOZ/ g==;
X-CSE-ConnectionGUID: 2UFReBdhTQSyoitnV3lRLQ==
X-CSE-MsgGUID: ILfVkuLrSTq2rtwUGgs/Dg==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="41251521"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; d="scan'208";a="41251521"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2025 18:21:53 -0800
X-CSE-ConnectionGUID: z4LkArtdQKyGTUPtH3dRSQ==
X-CSE-MsgGUID: l38h73TISAyiVtL3bGoudg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; d="scan'208";a="121511420"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2025 18:21:52 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 25 Feb 2025 18:21:51 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Feb 2025 18:21:51 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 18:21:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y0kzyq3wQcLKJI+DUM+9+vk6BdX6ok/pQ2wyS5jnpukmU3fd7dspBwI0kXSF7RyUamvrAVcOvE33OqCdiYGRBvT5LSeZxRh21uM+LsVl/mQDps5qJ98cfFgGrFdd3kCVico3AO+47KLpa4D7kbTpigpY1lZ0ApOztgI5I+rTL4lkjIqFowVyHlLQdy6LfCmWnIUF62WJOS9BLTlSkOQKALDr3qdpwLFuQPK511/kP4gOMrvDn+1DctJBsa0NUUvOB9mgUzB48CpzPsPFkosELxI0Mq6PV6nYpeS8CEaarpRqtmFuFxkMBu004Yb1bmpClwnxu853TgcAuuZkhmzFeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQgvpIe7JPsjwmmth2jNZFfUPfWe2YoqzYVertx8hfk=;
 b=HtyJubII/CX/7+5nbhPlES4Fncok9MAWbJHfHd091oKaUNXUXoY5Bq3+F9q0tGJAQjD0qW0Lo3zuKL1HjC1PINPKzZ10lBq9zswdul7kaEjMc7KJwMBoVaM3LRLp8OORt66vrfFJV49nvyLOv0yb5nZdY0Wt+Xa/6/VsV2/BCbHUH5IygS9YP6gc7DSJYfYEm/cYT5qXva2XsyYfslYqbxentcX3lV+Xg+aMfNiOnH/b2Hn8c1kbjBUnx5aXy7rz4V39ZLBAjsT12eCPi1tZ/a//wrbOqvPw+KcdbcmEfs+fz+LMyhQ5y977ZuvTqO/S5OoPAtIWxhRfnFHXC4+LHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 IA1PR11MB6292.namprd11.prod.outlook.com (2603:10b6:208:3e4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 02:20:44 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe%4]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 02:20:43 +0000
From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
To: Tom Rini <trini@konsulko.com>
CC: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>, "Meng, Tingting"
 <tingting.meng@intel.com>, "Ng, Boon Khai" <boon.khai.ng@intel.com>, "Hea, 
 Kok Kiang" <kok.kiang.hea@intel.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: RE: Pull request: SoCFPGA changes for u-boot-socfpga-next-20250225
Thread-Topic: Pull request: SoCFPGA changes for u-boot-socfpga-next-20250225
Thread-Index: AduHYG2X5CYjCmUtQ5azzS+q2he4rgATpuMAABF1w/A=
Date: Wed, 26 Feb 2025 02:20:43 +0000
Message-ID: <DM8PR11MB55925BD3877F17327787EFC1D2C22@DM8PR11MB5592.namprd11.prod.outlook.com>
References: <DM8PR11MB55926A01DEBF96A95B86AB8DD2C32@DM8PR11MB5592.namprd11.prod.outlook.com>
 <20250225175938.GR1233568@bill-the-cat>
In-Reply-To: <20250225175938.GR1233568@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|IA1PR11MB6292:EE_
x-ms-office365-filtering-correlation-id: ca5e9774-088e-42ce-027d-08dd560c2c4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?DpDAYBE3dsXv20jLJfp5R6JWVJZYAmRfGQAsSVIfSuy8VwTD9kan4p2oBgvZ?=
 =?us-ascii?Q?RNLrwSGDDF3qEz5bHnxfNKE3hD+U8IroKFvssb1fVavXtoU3HgQPzXWAuZG9?=
 =?us-ascii?Q?IxhaKvnf+rV+n1IsU+FQoXoiUMu6PJgMRP7D4UE72yW7appHnt1i7/EQR2gx?=
 =?us-ascii?Q?/ih7U2Ef0LyKTwzw0WlcELdk/9q+CXQHxSBGjwC9WTKMQlkyo2LHSSuc5NDN?=
 =?us-ascii?Q?FI/n9po7FQaSviwskDX3d7BOM7m4afG8rJhR/0i01E+xI59i0efSDdHLUwRz?=
 =?us-ascii?Q?Wv6SejJwyuXmury96WPx+JnjxxyGYZu4hN8v+Uk71e2WcY9nVjrBiApUR3uM?=
 =?us-ascii?Q?cQ8l32+X62gUh0ig8oaUOt18VndM/pSTk2iB+llReTrzF324MQKgZRYsctSm?=
 =?us-ascii?Q?g300OC7aHOR5hf0bmrwddF9WfYMqFbcfEtF4GK4H34BNeR1BcIGiNbFAVMVs?=
 =?us-ascii?Q?xyCBmF45657BNWEJm5TqAWOXtPUwNlGixebRW00k5ZvdK/lbGV19qQkyQrHD?=
 =?us-ascii?Q?1VeGYVBRIEdna3mGb8RgmhbMMBGyJz5SLIiro9kSNTvmj/y7maXQXWsH6a7i?=
 =?us-ascii?Q?A/oYx4xR4Ex3n+0Tn7B7+7/b+9aPbIy+Mg/p9SubEUkwBWp1T60oZhC5oaEW?=
 =?us-ascii?Q?3WeZGiXczGZhsOwG5dmPl7KtNFz6B9s74TjCl+Fd16BM/FNsTRuncyPNfCb5?=
 =?us-ascii?Q?xtVHkCCoQIu1v2gZaC0o/Mpes9yPa340keppL+6X6eUIU7RcwUyx/6u7+bVt?=
 =?us-ascii?Q?1I8ZFeOAlh3GnYI9eAF6+DKlNHWD7BRUHOu3lxBlzt2X79r34pfG2jkqPdkw?=
 =?us-ascii?Q?RF1HADj0TNKOszBAEtl48s8SUU9ESCLuBC0JF5akFRhor33K3vS5kiHUxx3w?=
 =?us-ascii?Q?DgBSgitwQP0M6vKQX8MRsiepfUJcFFtSSb8IV97hQT5V7gLwtSnJLh3HJ5QS?=
 =?us-ascii?Q?F0rDN0YcSy87LIb4ffHb+aFzyMFaaldIsbLLIBHE6kalYsCTXH+An2DVjg4f?=
 =?us-ascii?Q?qOoHRrVXnhiL5XxEEF/K0BmlABZVaJkXDC0VP4xE+vTJhdAZ6TOX38SMNxXu?=
 =?us-ascii?Q?7Onwm0zrYK3mjjeMWFL1oN72uKnGNp0gnrgSYHnvYQikcb4KfRaVF+/26Bpf?=
 =?us-ascii?Q?n47gAWCJqfvwpHMtu2JWt/g5q7zoV64rSYKyDOvARf8ovCDayg9B/HL7RZuI?=
 =?us-ascii?Q?rwrE43rMjhy7EBu1D8/VZixl/F+Fd7Mb1okzCNac7ca6gRiRWgwPxVy/EPC6?=
 =?us-ascii?Q?x43AoL+X0JH9YtN3u2/3+HM5yJJNlp9ycthr+IN4wOaeLMTANgXsLfDoYI4a?=
 =?us-ascii?Q?Iu8iNdlvGtRZiTPUqjfmyqFaxup6AKbT7ImQMjlt4GPXvMFMG4N5UO95dzun?=
 =?us-ascii?Q?iqJjHF7d8JrPWOV/ZbiIbTivXKSE?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5592.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3xIOECU4w/uH6dmoPvx6lG/0nyn0hus9Yj1CauJPW9iQydiScqAEQg5u90Ms?=
 =?us-ascii?Q?K3AD0lK3vnw7MCxRHu8BZGf46RYRgQ+ta2V8/nvn96ETGucIaNmxqa69jnJ0?=
 =?us-ascii?Q?0h82U5GGjGmR3RISEQniYGgC9xkRdEdL+VK5wVanm+7UNaW52otcUjvNk530?=
 =?us-ascii?Q?ozuKXxogN3F2AiTkRk3fa9BvXQAompw4/LbXklhVKmy2uPHNTupVX2nUmiV9?=
 =?us-ascii?Q?yTV5RYYOT9xqRAeN3HahPKJzEVP4wxm7RXZaDg9QmkxoD2/oWLZdtRrX2rOA?=
 =?us-ascii?Q?i69MC7ZZ//cdWXZGCJjKvXjmm/ieE0nprxZEpkAvSJVxYjURrO0ZmLLGnzE8?=
 =?us-ascii?Q?A4qKi6a/R54VdI3GoLOu414Chc0sBycMytQhOsn+jT3JMr0TyBvMyp/pzouz?=
 =?us-ascii?Q?LC3wV0+bFMeYnyJ1cPUypVtUUxMXckcdF68Mbl1eV373oaGyF8iGNTpxnNTQ?=
 =?us-ascii?Q?pW3EQyLMS2qRr2WBPrYv0gNBVZo3KRq/ryDR6qwvKDYlbY+TDY6erFWCEBJP?=
 =?us-ascii?Q?3t++kt6UkCUdZPirgCm4AWj0R5xJMNArCXA7/FwTiGMJ9GkZ28VquPcPTGFL?=
 =?us-ascii?Q?OpJVyLzIawV+FvOokJzee5a/6JbR9MmpgAo9wjqjHk/nb1zDsczMLFB19Snl?=
 =?us-ascii?Q?8QRhMfujXN5ha1bZ+1hxuzwakydUxrIkNO5Upszbt/pucr//rCucJrovJlu1?=
 =?us-ascii?Q?6WWMT4BlzvsZQWq1cQCz2Hl4xSjGVoAJ5zj8kFGmm6SapyLZGGk+AluOGzP6?=
 =?us-ascii?Q?0FRBbHVeZJKzfCfCCFqxFIRcUTvBE9VTGRlacWWAGJYR9qVTh46FZCE8uQ9V?=
 =?us-ascii?Q?JSJsYOMr4wW7Zf25TdP8E3OBbv15dLkSM+6lbrhlPUZ7HpqS7u5dbmOTEa9l?=
 =?us-ascii?Q?NyzyySCC6fhrFhd+fTsexQXQ6koUp1dP35jIuAtVyX2g9G3ADsS1TkaDYOAG?=
 =?us-ascii?Q?Ofh7urik1TrtqKojppH4mIXr77L1OUPO4VCNfr3L9zIEVnBkMGnO+k4Wy1pd?=
 =?us-ascii?Q?dshBa8aM4QWnnVj6AGpHt7vQ7s+vv8DFNhJTnX3WyPw7g2FTEgu1KKa1SRvL?=
 =?us-ascii?Q?0Br0xvIeuT4/EWAX6/bVvgGrmEQ+/HuXFQrk0MkP9u6fQVaAUNAoh7+ZcSDF?=
 =?us-ascii?Q?LBRNR6z5nd5omfNMvXU40mP1fEiJQenO6R0L0knya7j3Zq7xe1py/MmSzR5T?=
 =?us-ascii?Q?odtMbuH6qnMf2d9F8LR0LxAqN8f/gh8eQShqEzijm8lu7RgspHHPIg9eKWvL?=
 =?us-ascii?Q?HcOu4OoNbksLMGo1U4Ppd/4f67KMBsfRK6N7Zv0XxePJjEDnj5iNSkx+FC3a?=
 =?us-ascii?Q?aYlhBZt9Jv9r0h0EYK9L2XP1mxO93XBZxqUOQVKjeyYHCP8ofZMxrJV05PMO?=
 =?us-ascii?Q?uxg8mZDnV0ZoMA5iDcaqLJl8VHCx47DUfVNcsstHBxiL0y4yq6dgnoWL2DAQ?=
 =?us-ascii?Q?YWqcgPKwotPgMCyd6acGiiHfqsSoHwwjBFv3aXhfjY/j1FIxigL9+s0ljwYA?=
 =?us-ascii?Q?Ssob/l020H/Uz0bnaW6Ibkr7Cr4aJBd3AdO8vXnOVUgflZDvGT1+HRj5e4s2?=
 =?us-ascii?Q?CMfv4LM3g6atIF3WO17kLp7ElJ32TNapHFjTKrJw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca5e9774-088e-42ce-027d-08dd560c2c4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 02:20:43.8698 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DlFTgiXtiGKlaPEqz/G1vhux2nQpJl7tBaLlPxr8SiO3yJmiCLzlRnpSCum7VVRCx3tK0ThlIwDlHiXtkni86zat9oujpZcxc6kvsRrt0hU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6292
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

Dear Tom,

-----Original Message-----
From: Tom Rini <trini@konsulko.com>=20
Sent: Wednesday, February 26, 2025 2:00 AM
To: Chee, Tien Fong <tien.fong.chee@intel.com>
Cc: Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@intel.com>; Meng, Tingting =
<tingting.meng@intel.com>; Ng, Boon Khai <boon.khai.ng@intel.com>; Hea, Kok=
 Kiang <kok.kiang.hea@intel.com>; u-boot@lists.denx.de
Subject: Re: Pull request: SoCFPGA changes for u-boot-socfpga-next-20250225

On Tue, Feb 25, 2025 at 08:37:03AM +0000, Chee, Tien Fong wrote:

> Dear Tom,
>=20
> Please pull the SoCFPGA changes for next from u-boot-socfpga, containing =
boot support for the Altera SoCFPGA Agilex 5 platform in U-Boot. The change=
s include:
>=20
>                 1. Board-specific configurations and setup required to en=
able Agilex 5
>                    operation in U-Boot.
>                 2. Integration of cache coherency unit (CCU) initializati=
on routine,
>                    including CCU conguration in DT.
>                 3. Clock, firewall (configured in DT), SMMU, low level in=
itialization
>                    specific to Agilex 5.
>                 4. Integration of memory initialization routine, includin=
g DDR setup.
>=20
> This patch set has been tested on Agilex 5 devkit with QSPI boot (UBI/UBI=
FS) and RAM boot (TFTP & ARM DS debugger).
>=20
> Passing all pipeline tests at SoCFPGA U-boot custodian https://source.den=
x.de/u-boot/custodians/u-boot-socfpga/-/pipelines/24816 .

You forgot to CC the list as well, FYI.

Noted.

>=20
>=20
> Best regards,
> Tien Fong
>=20
> The following changes since commit dc0ee458f1afae4cb5c8a7b2c875bb24ffdf71=
ca:
>=20
>   Prepare v2025.04-rc3 (2025-02-24 16:53:59 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-socfpga.git tags/u-boot=
-socfpga-next-20250225
>=20
> for you to fetch changes up to ce5e8e60cee2b9dbab701935f99f46bc612be001:
>=20
>   configs: agilex5: Enable watchdog autostart (2025-02-25 10:53:56 +0800)
>=20

After removing some duplicate tags, applied to u-boot/next, thanks!

--=20
Tom

Thanks Tom.

Best regards,
Tien Fong
