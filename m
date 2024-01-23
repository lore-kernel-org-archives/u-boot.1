Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E01C47258
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 04:13:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B8EC87B5D;
	Tue, 23 Jan 2024 05:13:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="MN4S8aTH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E7A88792D; Tue, 23 Jan 2024 05:13:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22D1A87B5D
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 05:13:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705983198; x=1737519198;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=UFOd/UMmsFeENAqaomSCfPK4TPnpWQb9uRUDg9MVsU0=;
 b=MN4S8aTHOrt7Z2L63DFVWkyATrDkqhGPtYV46taJaLdtUUnoJlDioEHn
 W8mS5IbLXly8hp+qPZRILMNWbHoORaRHWdjUhg84BraLpSKKZVkhD9xMH
 +1rHEWShp0CxfQkXm9C+GsZPOHqjU8OmWgAyCChHuuehirbdVNeHARprG
 3q/c/U5U/v+t0fvd7EAqM8tBTVI643CXE2bXHTZsZzfd32TW/4ckioT5v
 OFzhbCnlp+xu+ZDVawuMgH3gf1tRnZzWZ81s8mpT6W8k+ciI/OmxxmN9H
 85LQ/K8ALp1Qp+1f1xyN2MgAas/vIqbTzJde7YWoBxIeIYwD4BqQBVmfv w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="8802325"
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="8802325"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2024 20:13:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="856187771"
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; d="scan'208";a="856187771"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 22 Jan 2024 20:13:15 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 20:13:15 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Jan 2024 20:13:15 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Jan 2024 20:13:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iel8y4GBTeBApbRWSffUqOpoyxtXyxt2sP2ZPon36u8sj2PsDPgecS9CZLsRDaCq1D36Byt/NOxhISId+10H2O84GRvRXlc/j3GOBWKf0xEBlLcNrJZiRrYOfgWYu5YZImVmBhjxWB4xamts12cUXYfhuSi5bDGwrVOf5XqOT16/a9RIr9YqnwG4LKq3EXWCJouWaLJHFtgS7IeCRLGnATEyGGoaPwpxt15TJIauFKq2kmH5sq28oAwy/6U4KnR4Ux7rtMVMYhWSOgprOGr9K6CJGSed3eL7tV2J6tTGoL/3RuRa0ZEeNtARwiCC90VEDg/ZXDwuYkxS58j99imMyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ju/i96gusb2Wo3uEIjoVrQjdoBZG6R2IsaWQlpm+l1o=;
 b=IttYfdet2K8V18Uvdb9Bi78IRQpVhqydxh9UN6qHIRwo+rpACm61+pHZeSgcNh7JEpOvP74l3BUIhhOM1Qe+ZWyIN43zB5aEC24U82DrEC+LaU/gRSYME0PQQh0AO5E3ufNLTsyW1gjIp+JKCx0mAcvIkta0299TC1E345Cz+MqhWwr26l5nK/HMmqo4K+vfYCXqtWUcLPkhxKUja5feyQLmj0LcRMoVs6uCWKfUaJAkAXs/hAkYgUj8wP28TXlyFhvw5FsKp2RneoLLtfdJQB+t2lbIEraP8FByIb9vbNWX5rCMbA+mmQqg6BGNK1HM670kfIRJmMRuOPnza4H79Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 SJ1PR11MB6179.namprd11.prod.outlook.com (2603:10b6:a03:45a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Tue, 23 Jan
 2024 04:13:05 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::e293:879a:787b:a663]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::e293:879a:787b:a663%5]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 04:13:05 +0000
From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "Vasut, Marek"
 <marex@denx.de>, "Maniyam, Dinesh" <dinesh.maniyam@intel.com>, "Hea, Kok
 Kiang" <kok.kiang.hea@intel.com>
Subject: RE: Pull request: SoCFPGA changes for commit 3c9bb8fbdc77f
Thread-Topic: Pull request: SoCFPGA changes for commit 3c9bb8fbdc77f
Thread-Index: AdpNFYhK4gWXpeBGSTW3w5IisJD83gALFkSAABv2jOA=
Date: Tue, 23 Jan 2024 04:13:05 +0000
Message-ID: <DM8PR11MB559290F5C0977DDFA8195067D2742@DM8PR11MB5592.namprd11.prod.outlook.com>
References: <DM8PR11MB55920154289761E48681A3B2D2752@DM8PR11MB5592.namprd11.prod.outlook.com>
 <20240122144711.GF3652023@bill-the-cat>
In-Reply-To: <20240122144711.GF3652023@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|SJ1PR11MB6179:EE_
x-ms-office365-filtering-correlation-id: 8946137c-9999-4c1b-0e96-08dc1bc9993e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cp0/Uhb7347qEvSLyxEdtXBLqntj6jWl1vJLYibKE7klJtgXCN8U/27YI+pVcwXl3IDmzIgN1f4Bm150OV8HdV37Xu4Ywu+Gyjalz8lK5uaeLVGr0xsabGaCMSlS/BoMVzIqY703QqHahazLuHxpv1oU3tnh3NGb64JaQ4Bz/vZ/HJe/IF2r2MEudpd53L6IIjhj3egBUO01rCsB6GZXKZMF46WEjpZgyx6yo/TA9hORf2zdV9326Z0toLF1yt0uKZdYbRVXHmtfTMkDoiAwV0i+l1L4LOeZQ+LGfVMon4Et4EZ7dKAtN/9DRs+r9aQSFWCEfM8yFIC0v8TVqb12VOZ40wtJX49wbD74K1V22j2hv4uLj7lkIvGh19XNxxUjsotBQxUSfiohU7pDMVGKCOMx64YDF1oB9vqnnAFUP8PlNvBmpW92vj5dlTIyB25vo2cclWxQh3K2lHJ870QZuUqy8qJs1KaSTUfahxXGGF9kIiki09x8QeAoKSG5V0oHWpvDc1ZNTb8UKZd1dJB8KMGPRqvkmen2b/gGmRVCfC8TSXoumERKzGtHsK8wpk8plYb4nOeu/TzFgchMUJ5x6CbYYgTMxwnd45OTKYckchs14+B3bY4fdoeHGNrElOX4Q+Ztau9rOqJozRp3R5yoCwIkaCe7dmF3wQJmEaf9A/c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5592.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(136003)(376002)(366004)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(122000001)(38100700002)(82960400001)(33656002)(38070700009)(55016003)(86362001)(83380400001)(26005)(107886003)(316002)(66946007)(76116006)(8936002)(53546011)(8676002)(54906003)(966005)(66476007)(9686003)(7696005)(6506007)(66446008)(6916009)(64756008)(66556008)(478600001)(2906002)(41300700001)(4326008)(5660300002)(52536014)(71200400001)(98903001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T9HZZ4N7CsvpyCHZUKR8bIplfBNT6GkgHEls7xwSLI8m2YkSDyNX8q+jb4QT?=
 =?us-ascii?Q?HB0qJ9Fs7iZ2rmgZra5vgXTR7olD8tGRtmG4rFcftkFbbPOAb/+YewcVqaXB?=
 =?us-ascii?Q?nFpf5yW+NOu8QMucfBnJogWKztGzvw0XqIfV8fFZwG4QufF9diz1R9srYtrO?=
 =?us-ascii?Q?IBl3RdkKU+W3ZB5/r/7EUagwEhYsQ6tAKc3r4octuIbezNDw21Ba5D56K+Fw?=
 =?us-ascii?Q?sy/OxwYtlsgCDjO8WZyYT1o6Ht2wFJ2x6OiRA8373KZXSZ9Uxb+yI5BN2XFD?=
 =?us-ascii?Q?Cef95kcQ4W4RzRdw2xIIK7wFXg0QGjrx/zDoKoPHk7mby5E3zTCXwCkxYnjb?=
 =?us-ascii?Q?mxv0zMDF004KMa7I65r0zcOlAiNL1YyOeMpeG3jQSbbvaY9oQXNudQzlC7zq?=
 =?us-ascii?Q?R0I9ruj9i8b9h7zDFLJXna4T+oqQgLy5yznF9D8VDJij6DGpmuh1qXhL65YA?=
 =?us-ascii?Q?6PFKFR6naLVz76nf65EIrs97gMQQyZ1oEhm9P8w8dg1xmGAcL+D9QbM48tw4?=
 =?us-ascii?Q?40K7Lix3cpFjWfD33fJnDeJ2HbNDTNsd7MNlaOlJUPFOkDmFrscT5YqqceWS?=
 =?us-ascii?Q?c/P6y8chpRP73C2908CPX6d44pTDEkOoutoTLpgpsgFbyy21S6b9Op3WIHZq?=
 =?us-ascii?Q?xL9FgoRhDrHWpKxGu4LHkPt7JKkWtJJ6mRK78ZLUqDR2odKu6N9zqxfx2kZR?=
 =?us-ascii?Q?onsOHgp5/pFzAP0oHX6+U7qVtOu1HpFnquRZ7kyexF8AKghcVfvnNwF/HuAZ?=
 =?us-ascii?Q?T2U+eL7VE99fCE8vchVmejQSIQfd+LtsTJSKPbL3A6dQ27PQ8TFZceWS1nYU?=
 =?us-ascii?Q?K/5t7T6VmyfArbrufilnW0zxn88V5vfaBTNkKj9/8Zo/Y6PfSn7GI4lX2WDF?=
 =?us-ascii?Q?rA0/dyResICA5TLwQrygb4X/DsGh4bLAtiowvMzdN3NaZQNmpf2Ho4GV/p5k?=
 =?us-ascii?Q?o7fQiVm+t//v5++5HC0eSqEm2UpYuTDq211ufgcDUBBpaQOyOERPXWIvqrwR?=
 =?us-ascii?Q?oMXEvTP4NmyX47Wwamo2m/UDcGt0qC3j8xVN4Wd8iMwOgOXXQyPX4nX2EaqD?=
 =?us-ascii?Q?xN4JyNqrWifBEuUTq3tVGiuI7fJPXRN7vRdlfEzxpbtPFuDopq/EwhU2G/80?=
 =?us-ascii?Q?iOo0nv6Q5NpklapG80X8xTlR+S0GGZV7S7VTYszx4WkYGIktNYS0+u3a7Evd?=
 =?us-ascii?Q?bXzq8tUa4l6ziN7JKtzuRpvZktAYIUif4iOzjl5utQsvavZ02hf/ekHvoJ6z?=
 =?us-ascii?Q?KLIb3KoT1l0q2Og0jjv8R9SQMqyFkBv8QTnxxsJq5IO9QTvs67BVW5qShxyA?=
 =?us-ascii?Q?r5zaBOiDe1O4BveMeRBHkF57P6gFEc/P6a8+jaKPAavhf+g6LP5d/JY5bpVY?=
 =?us-ascii?Q?OHFzk5MBGz7FGF2ZGCkvhTN8VsPiVHntElm0PcnhVaudDJ4JGfamTmfoKc8E?=
 =?us-ascii?Q?M1Zf7O152i0tSP/xNAZWxG6ARWzrq91/BH6QQBy75DjrmmZ/7p/GC4VAyNXg?=
 =?us-ascii?Q?eNUMzgWCLmM3346mr7F37CD1eHu7O1GMbs5K2pCf6yQsXO0cwLsPn7b/SGyJ?=
 =?us-ascii?Q?gLhPdXY8WGtogch1Hz3xRZaAXNF2Ltj6g0/B+v0G?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8946137c-9999-4c1b-0e96-08dc1bc9993e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 04:13:05.2957 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +dxxtspfMxIo7C/39A+2f/gPLfb0fMUpwy/IcdlTmI/i/legWovkzKy1Cbt9AXewoEVzbktsnxdFRumPmmN2qEGdnkOaGr7HYwHDF8sPZlI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6179
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

> -----Original Message-----
> From: Tom Rini <trini@konsulko.com>
> Sent: Monday, January 22, 2024 10:47 PM
> To: Chee, Tien Fong <tien.fong.chee@intel.com>
> Cc: u-boot@lists.denx.de; Vasut, Marek <marex@denx.de>; Maniyam,
> Dinesh <dinesh.maniyam@intel.com>; Hea, Kok Kiang
> <kok.kiang.hea@intel.com>
> Subject: Re: Pull request: SoCFPGA changes for commit 3c9bb8fbdc77f
>=20
> On Mon, Jan 22, 2024 at 09:30:40AM +0000, Chee, Tien Fong wrote:
>=20
> > Hi Tom,
> >
> > Please pull the SoCFPGA changes as shown in below.
> >
> > Best regards,
> > Tien Fong
> >
> > The following changes since commit
> 3c04fcf3137d5f694d52b8f355373e4baabe5f78:
> >
> >   Merge patch series "k3-j721e: beagleboneai: Fix USB" (2024-01-20
> > 11:39:13 -0500)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/tienfong/uboot_mainline.git
> > 3c9bb8fbdc77f6bd56e97597d875d8965db3b96c
>=20
> Lets talk off-list about getting things moved to https://source.denx.de/u=
-
> boot/custodians/u-boot-socfpga/ please.

Sure.

>=20
> >
> > for you to fetch changes up to
> 3c9bb8fbdc77f6bd56e97597d875d8965db3b96c:
> >
> >   arm: dts: agilex: Increase reserved memory size to 32MB (2024-01-22
> > 16:51:29 +0800)
>=20
> There's a few more patches showing under:
> https://patchwork.ozlabs.org/project/uboot/list/?q=3Dsocfpga are they rea=
dy
> or need changes?

Thanks for pointing.
- Changes are needed for first item.
- Second item is already part of this pull request
- I will submit request for third item.

Best regards,
Tien Fong.
