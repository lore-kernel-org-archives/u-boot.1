Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB6CAC19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 10:36:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4170C809A5;
	Fri, 28 Feb 2025 11:36:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CqFDA8NX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CD9C80FE2; Fri, 28 Feb 2025 11:36:52 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E027807D7
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 11:36:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740739010; x=1772275010;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=GoV9UYZOr+Ee/DZOEY80E4L0lTb5sB4xH8/nugx56Jo=;
 b=CqFDA8NXcG8Yws8znHBYRFlTCVX7pNbX8FkYaGEtobDJ927gI9HasHC8
 G3/C2Lf0NhvsjeaRy2K9puiWT5VnJRtYTljvpSXslQC6YazSN5XxsViCJ
 mVFk8viTTBlRNk0tzVnLjCz6wJ/FTq2JGNAtYtXcteYqATxJZVuYSnq4F
 XapYlekDrm54+FUnyULL1DUjQpMy050WtN4QM3jI0I4FkVL5f6zvtLGhA
 J+Sfy+SkTji4xl9bSx/gPZ5+RLZRIdyyWTG9pNZ+OnOsrPW6vvNivrST1
 HHR6lPsYgm7Bqvg1EgKXVTLs0mxEITU5JJ052MVFlx2eHtc3aMK+nQoUo w==;
X-CSE-ConnectionGUID: saR7RCQVSoiytzF1UIfdEA==
X-CSE-MsgGUID: sQNb1A8uSsqTb8oiz+JXgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="52298209"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; d="scan'208";a="52298209"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2025 02:36:48 -0800
X-CSE-ConnectionGUID: vzh+yqgIT6GVyAXqtozj4w==
X-CSE-MsgGUID: iGNA8207TzKLGd3zQmXWlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="117828577"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2025 02:36:48 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 28 Feb 2025 02:36:46 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Feb 2025 02:36:46 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Feb 2025 02:36:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLB8m1IuM0/t/+aD747QgfIQ/i5qnHuCa4v27+dWY4CD51oB/Jk8XyBzzjFNxAZ25XhE0PyH4QfABtsL73HOk4kTBs6DN5uhFAe23XcMeWhFewRiDv94sF83NJhrEZi1NWUzZZiJdhrfRibLlq2pJR5wo4K0P07gdpRCXDlbVPQ3JJqivIg2tnnyinu9yy2oUOCqMBiuLVHlhX67ni1M/3YbwukGeyQJDQzm99jku9YYo++3nQ+/kkVSBAS8i1boqavZxInJA1JxzHdUgwn8pImrQntk0TNw5l50vxD9ZUi/h0W5yFhbQ2uilRgdWDMEPWFSuUxJCioBR9/SHve9XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/i7AXDpUn6j6eiH2BOJfkZQbSIAGu3ZjZQc4l7WN4dw=;
 b=L6yK1F2nPvkOBCDMf7tP4QGDi+g/aSAlORvC+Y3Rc0+ViCMlDKHFsSXYcsKX8diuYzfKXtf1Sln9SlT3C2n5xYYJ6fc9g+8RvWiBnqv8RRv4DCwSymrG0X4bJqr2viRA1Jmi6n7VwSmKaW4jk1tZ8ib0C5HlU3ZbPEULT8WcLhLlBj4cQx02A+UTl1LvzHujlsSOklfw23x8Qj7snWc6edmCvdbewcC1Jb4Hstwkx83VS43wuB3W9JfK6aOZKfsaZXqtSw83kICng/6EEnEFyHbyz8z61zURZEz/b8n9F5RS3SkHl2JCrcua4x6Fp+XG9RAxcFdN5Ndtd4aSFEMAnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 PH7PR11MB6497.namprd11.prod.outlook.com (2603:10b6:510:1f2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Fri, 28 Feb
 2025 10:36:44 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe%4]) with mapi id 15.20.8466.016; Fri, 28 Feb 2025
 10:36:42 +0000
From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "tien.fong.chee@altera.com"
 <tien.fong.chee@altera.com>
Subject: RE: [PATCH] MAINTAINERS, git-mailrc: socfpga: Update email to Altera
Thread-Topic: [PATCH] MAINTAINERS, git-mailrc: socfpga: Update email to Altera
Thread-Index: AQHbiM1+NcHYDHSMKkC1OVyBabR0/7NbKt2AgAFcZdA=
Date: Fri, 28 Feb 2025 10:36:41 +0000
Message-ID: <DM8PR11MB55926C2203261A2B86614029D2CC2@DM8PR11MB5592.namprd11.prod.outlook.com>
References: <20250227040904.18714-1-tien.fong.chee@intel.com>
 <20250227134809.GT2640854@bill-the-cat>
In-Reply-To: <20250227134809.GT2640854@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|PH7PR11MB6497:EE_
x-ms-office365-filtering-correlation-id: b2bd8fa9-886d-433a-4cf5-08dd57e3ca64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Q2VmaPounsGvqagGi2Q6o7JCPcMYglon2pWX/bu+L9c4qT19+W7bU8Yre/iF?=
 =?us-ascii?Q?10blgWmmX3ih7X+sVM8/gjfG4RDNJVyXKXqWqZH9Kgjohxfm8z6vdDcgjart?=
 =?us-ascii?Q?rdCfKBRwk1iF36VndrRmxFeujb3jRj70mWxAyibr4K5Hpe5JXPjC87bU+7h+?=
 =?us-ascii?Q?ZtbkbkpfG7CbdvwnHUpTeRWQYQVMBIXywVkY/TqFaXwuD19/JU5VwyJytHEx?=
 =?us-ascii?Q?GKYQC3bGLDrGA62tnE8ZSZuQZ4Zh9RTieEmtGTk7Tcm/KJBvRpeyJ4OjX10X?=
 =?us-ascii?Q?TBovgWvsQ1pjML8/cFQBoX8z8thRtEe5IALadJY8udDNf3nugtumg+XlqNhD?=
 =?us-ascii?Q?Is4pqmBw8ip2DeINVV31JdnvEWIWQKuUjAF/wKyfg7NkLTafdhsScD1u/NLU?=
 =?us-ascii?Q?sf2r74XJ9r6ophEA0Y+unP7VJ9WnqpJwWqSKnZGvROR27UzdaSUxQ3C4Qoha?=
 =?us-ascii?Q?FMTsCK1LsZnoo0fUylkQTqdMB8Eed4c6Jp87T8MqvtXEPJcmmCDiepHm8V+S?=
 =?us-ascii?Q?arUf5wHnHj5Z27h29r6BpkDEq2U9x6SHEKm9C7ZNB5w5gDXilcSJFsbBNbnm?=
 =?us-ascii?Q?6ZHUUp+5L/MKLAhEbioSunTOrOuqFcF2jHYQ+j++XROjG2ol/1fiIhL0SIK2?=
 =?us-ascii?Q?msSB0eKYfz4BCZ/MCCtnedK8Ih56pAKpljlda9eJNDFqo5flkfzRR1ZnFDyk?=
 =?us-ascii?Q?95WmUDvke4gJoePjWMU7UtBk0SHHr1NZQLUrF5s7dSIBapagYxymuWeLMVA+?=
 =?us-ascii?Q?VsOb2JGuYcD0Xc6OGDgLruaKNIzqYT1S4ET29dfOZGI9CgZ1c0hXDD/ToLkW?=
 =?us-ascii?Q?OYKWt/yov777tMvdP8VdIv6brnWA0QEOXDXpg4HWGg6GNovVysTvkwFDFrdz?=
 =?us-ascii?Q?IydWyOQLC8iLBDeY8tyg1Yc/bg8KJPpsYihjOY2z+oYAzOJB3ikTGNyRWYcT?=
 =?us-ascii?Q?ADPPFZUBx8PwllrvytjC7lCRKy9ZhdWPgfMeUIhPkJFZVzAMW0I8bTick3y5?=
 =?us-ascii?Q?+yCOHEfh0TFkF2OuW7HsJ4DrTlbtk//9S/M3d5FkQw2ujWCcP1YVMZDOBrGx?=
 =?us-ascii?Q?XXU4Jc1VZ33pKvUWzTrRavfog6qF09slwQffch5vzA5NKw7B/LWgoT/5UbZv?=
 =?us-ascii?Q?KpjM5TgGJRWPqLhDfErdJxzJ6Is49ryOkPrAUwarj6bMI6eW8NDVirMfr+nY?=
 =?us-ascii?Q?Xu/MEHgw65CtsfHhqYk2s3Irlj3PwKwfF3sWtSPcFFGftjp3sw5hNs77TBY9?=
 =?us-ascii?Q?jmBU0YQGyude16TNkZsD38zUZe29w3tl2kLG0av9uXysMt85Y5NMgW7krIvV?=
 =?us-ascii?Q?pm2iO5bnShBsFAQ8daH9fMDFNLfb49krBKB5T/xhWC4V9wE90jsS9OTuPUa2?=
 =?us-ascii?Q?hfWykOAFd4sS6cJ1eSa4cX0FgckqjI5Vqap121lEkbh+oWO/iwDAAu00OK8M?=
 =?us-ascii?Q?P5pDhP6tf9mJCZFKacJ4GAtYC3JvJCPg?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5592.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P7VojnFyFmBjAhFT7XVX93fePUcyE8EA0yoH+/o8QI1txRBFvu43qr3+KkZR?=
 =?us-ascii?Q?cEhL9cykNjzjwwunJhDidfQKOfr+sdCCmmzMTAyiEssBpxPFspu4g03QCxul?=
 =?us-ascii?Q?gAwNm0dnhYpkMbPUPakWbZ3eDpldX9cV6Ucr5KVkT7jOkHwYwb25STRKB0Ic?=
 =?us-ascii?Q?en6pOqEX4hOrHArTs0ZQ7V4CzksqEaOomYAjQSuVSnAtmpRTRElAtk0hjdZe?=
 =?us-ascii?Q?xDdC4iHmIMvvULKiN5Trz+ipFPl80xMUe9eqTN0fpS2VtexP7gAUkdFUiq1n?=
 =?us-ascii?Q?rx2aYvJPX8T5uyDB4igTiwyo2bVUd6d2AxKTK0btsW3+cDhnFBEyC1BkfPoz?=
 =?us-ascii?Q?IC3A1EYX0MPCAWiLBx1zozHhVjDJlfwt+D1CszyRYJiQljfzEYgssweIOEo8?=
 =?us-ascii?Q?lt73VCzjaR8HYlkr4atK9V0H3tEG8JGKcgBFdrixpchWW9HK1q+OnkLczzUU?=
 =?us-ascii?Q?Dv+jO8oAlzYi1U0rJFIjmOvhJuoOG0z5CWPu/pj1UdVkAfk8mf2FvvLJg/26?=
 =?us-ascii?Q?2buuz1lCBW0u3BZXpR2DbMgQfD7v51hFzn9ut/exexLe5yQON/IQTA4tKyO1?=
 =?us-ascii?Q?+ZLqDIwBi5EouK7nSj4M1/sQYxBXqLrHttHgvajGHGyJUBBzQPX4V8KNPmiq?=
 =?us-ascii?Q?1Ir2KgTbvxxWBiSBJPfL+SquEyIHJJEAD3Vx9gYXn+QP+cOmMe+FJVgxG1hb?=
 =?us-ascii?Q?t65mhFV6S/4g7YJv/dRQT7vjvsBBxCpZW/h3eCe5NxdOjbPCnVSZabAaMocR?=
 =?us-ascii?Q?IVROdpCTjMnjwHpQYyPHYqtHSKgN/eVb7UCfSvlMTkaKUvi1sUoISyawGvRS?=
 =?us-ascii?Q?gjXvwFPTU1wUGHkUomBZV6E1WZ3eeCNJXC3gxJChp4w7XbWxUYMUdf1o65sk?=
 =?us-ascii?Q?1VZ7joM3hzp/eEUW28cK3QIudkpj9/WGiCbM2cjthvjeJhYlxr9Ld3kK6eLu?=
 =?us-ascii?Q?XqhJ7ERjsZPQ5SSqlfia0aVICSex2+8FybnMevgJo1R1//OMLIs/8VSoUarm?=
 =?us-ascii?Q?FsPTF3D+0Q9SEBFZ6klEujEDIMiMbAJhjywB0DJAk4BH7ibLkIAG6xXtH2Ej?=
 =?us-ascii?Q?lu8qhYThZZK97pog23yV73YFiHybf16pyc0gkTIrtjU1T7536ig78LQP4igC?=
 =?us-ascii?Q?J8LtvuCmBZ+KmEfxA1afyoOJm/g1qG4FWCa/VgbGhpzP/R9qMJhLW7P1J8HE?=
 =?us-ascii?Q?UEq5JBS6Bx4doPOCQMr48cyzT1trIp7+XXP432tON1rKWHtGw27IHeRMUysF?=
 =?us-ascii?Q?EdhL1Ft8VAGTUV/WJMuNje+R2kvCItpmFguC88n5SPuIVa3uBif/1veADC2S?=
 =?us-ascii?Q?KzqRI7TXY1GLqCOwV6MYzwqsBxFvgDG1AFXCQg60IffPgzw+4v/I6Zk1myn1?=
 =?us-ascii?Q?PIESrD9KIbNV/8hO5cPu37r68EW7ZGnuIBpj7BR8DrVlNO6/teR8DrCIkXE0?=
 =?us-ascii?Q?/Hvra1nKHNJNAyA1DD8K07G5HggSbUDlKJYSIimonaAvDW7SZfChRW2pHZk1?=
 =?us-ascii?Q?JrVExPABFTJEairCxN5uD9l4+Cs7Oia31Y+sh93U8SvDnOK8I9fTBQ82u+oT?=
 =?us-ascii?Q?YHU62RHHGwvhUcOFSXHheAnkHeF8ZaW9SeHf0qXS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2bd8fa9-886d-433a-4cf5-08dd57e3ca64
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 10:36:42.0606 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6t1gpxQ5TH2C0ZxtsKP/1B0T2WeO/+2PzkJanoN0YXNizE1wFyM05aFR5S2UFcbVug6AlGfb4run7RIMpjOBUehN39WDY7TbVF0LR1uuxmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6497
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

-----Original Message-----
From: Tom Rini <trini@konsulko.com>=20
Sent: Thursday, February 27, 2025 9:48 PM
To: Chee, Tien Fong <tien.fong.chee@intel.com>
Cc: u-boot@lists.denx.de; tien.fong.chee@altera.com
Subject: Re: [PATCH] MAINTAINERS, git-mailrc: socfpga: Update email to Alte=
ra

On Thu, Feb 27, 2025 at 12:09:04PM +0800, tien.fong.chee@intel.com wrote:

> From: Tien Fong Chee <tien.fong.chee@intel.com>
>=20
> Altera officially split off from Intel, the email need be updated to=20
> ensure uninterrupted support and communication
>=20
> Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
> ---
>  doc/git-mailrc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Similar to the xilinx.com -> amd.com transition, I think you should update =
.mailmap as well for everyone listed in MAINTAINERS files, thanks!

I think the changes are already done at next branch https://github.com/u-bo=
ot/u-boot/commit/04ea9147d5bdab1370ced118acf35db7ac9e281c

Best regards,
Tien Fong
