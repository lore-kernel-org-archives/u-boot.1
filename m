Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F768C25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 23:28:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC6A088403;
	Wed, 22 May 2024 01:28:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="jttSHSqM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A71A8843A; Wed, 22 May 2024 01:28:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7A9F8826D
 for <U-Boot@lists.denx.de>; Wed, 22 May 2024 01:28:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kalen.brunham@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716334102; x=1747870102;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=6uayfY7AjYsOHIrhTOVRAXRDP65NO5Nowy00ed7GkLU=;
 b=jttSHSqMwRcFzwCT4NFnyPSSdawHg8iWK4rZl8hfGg7T69DUp4FpNMax
 svmOJ6XCofOScPy74ZfrHw2IqJ81iZhR6eNz/iLW1ZaV4trGPa8JLFrI/
 pQstf+45Whb9Z8Qxa6VFznsZz7YKATSQgVYwL8XkjY7olcTOKNfMNhyUG
 VQgfPHSOaj+dn8dWfp1AW64rXvZrMPoT9g5XNUpCjk3XMZwOzh4O7jH53
 hWsQI7n2WK5eLTxRSGDsoCLe/UiUCB26CL4c+jNf5eCEsnBrHgL5L3hRz
 kI3Q7EqCe9YME8NsVBTnVNZq1tMdDpQl3PdC7fxJWli1cfFQxJTMkxCxZ g==;
X-CSE-ConnectionGUID: TQIz2AArSuGshxPbJQkvyQ==
X-CSE-MsgGUID: yuLM6h0TR3C8zJ+WQVgSUQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="23692513"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="23692513"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 16:28:20 -0700
X-CSE-ConnectionGUID: 1MQMihkCTxCg91bdMJB/5A==
X-CSE-MsgGUID: ZUQgKplpT9WaWWgLVdvCAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="63922310"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 May 2024 16:28:19 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 21 May 2024 16:28:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 21 May 2024 16:28:18 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 21 May 2024 16:28:18 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 21 May 2024 16:28:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hj+QVLMTd8j2bG0yy2r7+PynZbMmtDnoBIT2LT/WfXjxsB62QOsNFKVfiyNAD1IRbWRh2YvyFVB9T2VBYbNCgdQqgEH/TqYvj3nI6aFqQJ0An0LGypyq+BfjfhprzCQLuRQFot8hZ/WvFCKdzK6n4oHkvemGQ394KN53hiYVVkH+NgxZ92c2dBzETuzpWZSwYyd2QiG/b3hKGPKkH01EIrzB8XC1/09hpPTsA0TWr34LQEn/1KhRfN2jGthYeS22ESx5Gl00tKAmhuXi5dbvnvNFOt4vFK0L7d4ylb2xdGyH1dsrGV5+wXdh5SiNYARVNq4ZpzFhJvztG9epTDMz4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98IrbnV2i628fA+W6Tt1njTLQPmxENkk7Iyto+jo/38=;
 b=CCrYiOztczYrUKBi4zuosksNnLKmY0pU8pv9Xl21RqNIraqxQdDuTSnOEKgwLqUt2RqbEB/zKNpFEj1BmsC/+m2vKhS4ZJ7bVykXVTamTMuBQZ1JZs+1n3xedd22U3dLBVEfxUIRuG6QjOqRsFo0ATAzT54mKGcUI2ipSF84UJWyb3tD8UMQJgVEo4CS8u0iuGICFYAXpnM7nRt1sT5fWyIeMidPboNcHprGE6slqeCBD9WpRsqE3phjSYO6oJwq7kGsD5Tzpl/QSzm2GI0TtO1smmnMe9pxHos9477ks7P3ZddGnZQejPHGcw/YP3OoJbjnBjrNsDtJ8fUpL//9TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5296.namprd11.prod.outlook.com (2603:10b6:5:393::22)
 by SJ0PR11MB5814.namprd11.prod.outlook.com (2603:10b6:a03:423::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 23:28:10 +0000
Received: from DM4PR11MB5296.namprd11.prod.outlook.com
 ([fe80::4976:d526:d3f2:d785]) by DM4PR11MB5296.namprd11.prod.outlook.com
 ([fe80::4976:d526:d3f2:d785%4]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 23:28:10 +0000
From: "Brunham, Kalen" <kalen.brunham@intel.com>
To: Tom Rini <trini@konsulko.com>
CC: "U-Boot@lists.denx.de" <U-Boot@lists.denx.de>
Subject: RE: [PATCH 1/1] Added arm64 assembly for examples/api crt0
Thread-Topic: [PATCH 1/1] Added arm64 assembly for examples/api crt0
Thread-Index: Adqojlev93VX2sPCRR6waFJsm7XUJgC82DVQAAZzj4AAAJoS0AAAJBKAAAAadUAAAv2KAAAEUXCA
Date: Tue, 21 May 2024 23:28:10 +0000
Message-ID: <DM4PR11MB5296769279BCDD505F614E6BE3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
References: <DM4PR11MB5296B1B9F0CFC701A8B11284E3EE2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <DM4PR11MB52961423BCE12552857A12A8E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521162543.GU2568172@bill-the-cat>
 <DM4PR11MB529670F5CFDA6B4EDA7B7206E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521164659.GZ2568172@bill-the-cat>
 <DM4PR11MB529668DA50F05F26AAD229F0E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521181534.GD2568172@bill-the-cat>
In-Reply-To: <20240521181534.GD2568172@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5296:EE_|SJ0PR11MB5814:EE_
x-ms-office365-filtering-correlation-id: a9282cd8-04cd-4ce2-2d72-08dc79edada3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?8Y/02d/PycQsSvS3yAK38KNdoF229uSAneaVw7oKfjf+3d/UQlEEU1HTvjAM?=
 =?us-ascii?Q?KvIitJ4TbpdxFRqd9xsi3y4GanphtcLMlS+wcBRzWTOClz7j/AIGz9F8UTPK?=
 =?us-ascii?Q?nsJ77EUyDAR16rtwhamM5ZYOmNDLdeHfb1BBZLJj2o+sP35R9OnYsIT1ObER?=
 =?us-ascii?Q?yFvXOOYlEVMLmIJI7+PJeSGQjzmM0kf91IdY3TOTNRPttuPgMqU7o5wgJ2o0?=
 =?us-ascii?Q?hZcTQXHOQdmzRnsKZgRYIRwmi+VbVykvJXnnf8YEakuecyAUG8YVuoAHXq2I?=
 =?us-ascii?Q?xyJ+I5aOYpJEBDzpiyQcsQ3fA8RyLDtmnfxhOg5U7bXVwlQ/6RQ2xAprg2Wn?=
 =?us-ascii?Q?PHScyyduZKA60dVtn83bNBE2yvrTZO+/cotIFzNIHloMSr+LnenFCTVXEs+o?=
 =?us-ascii?Q?BX5gYxip1FkBYTyFdop+YtNBUw7mclq6XMySMDkU5Z8vDtftpvVI4uMhnAHm?=
 =?us-ascii?Q?RJ7ucdG6dDGdqs977DHe+vgrjqWe+Q1y46YqmQDKer61Lkok/7N6W6B2KnBg?=
 =?us-ascii?Q?1+dHZUwfAEkH/fWPtAfXKFoU5NHe0YIONi8cu7MgR0Ho+KkPyaxeTdKB6voM?=
 =?us-ascii?Q?M6m1MJuNM2aAhQVf9H1qhAiZ3daYVX+SsT8PL9KYeH3WE51rWbkANw8o031W?=
 =?us-ascii?Q?f/RXSc6uRwgk7XsPuKOD6RHj4wv/cH5TKpgd95nsxUyILIQ9WNCn44LbgI+S?=
 =?us-ascii?Q?FgqLrftaE++3LGe9WrZcvesMbmlb2dTRqVsPtjDg5yDjNO/FzG7ENcgzSg8X?=
 =?us-ascii?Q?HAY+rItfEvCypJh52eivwpW9IcS1blWLYyDEFDfZ+nmyzW2tyZ01xZIVqpcW?=
 =?us-ascii?Q?a5461IOVAPHOTRVzJd9T3Gng9Ubttk6JKYxSwlepzp7wqlPUZMLsIAULMRkO?=
 =?us-ascii?Q?B2KhqR1B2qDaFR/IJZQShs8dm1pAbhPVsmcFTYJv/soea01aN+z0gmKS2Jo4?=
 =?us-ascii?Q?EiqrcZWHLNvbDEgQ4Nmf+PPr1sZWhBZrYr/MsqpfGVG54L4ci80qfyI8piiN?=
 =?us-ascii?Q?9rQTwB/ubN8xvDz5e57Nyahn2/bz4KvK2aFUnBDVN8BdlN9CJK4DU+dRRtHK?=
 =?us-ascii?Q?seay0Uzq8nlESXfqLi06xWs8JSM0hnprP2GDPrp5IaLinBoqape5lfQI+oyc?=
 =?us-ascii?Q?q4nvK/AATfhIoZBs9q/BNhG29k/tj45QsDSGmJAD6ftZ6KoDPq/0mQhkEHVw?=
 =?us-ascii?Q?Barr23fjmRCyVN6HQB484Yk8jZSSDVkAnBefh/EK7fUe1KuODxkdYy2Pj5kD?=
 =?us-ascii?Q?qHLMAQqNTHUNc51LLAsg+k9TuTtJJGuw4ef4ihZbCjF5efRfRZ10QpcpfEE0?=
 =?us-ascii?Q?SRS3rhuhz4CAw1aiMY5zLWDdzpm/ale9XAYANuufWEn8gQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB5296.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mzmtp0UgakkiwRioig6PF4gnasRdLGBcbYJSPMMVu2ZOvKO6gG3rOfNRM3Dr?=
 =?us-ascii?Q?d0VX1b6xOoDXSXjvjGjWILhMd/40oFosi86DEXROsciS6XpbVGmP2towY9BZ?=
 =?us-ascii?Q?3KnMRIWZSPG0WNlA57IKlwhcsZIZEu2wu9mLA+BwnZhLuUehGDjJq9omqWFX?=
 =?us-ascii?Q?eCQqL6NcrgBNiB88lBsR5a2dWxAcqRdivDqpqoJaXlV3TR5hHdULnG2VPO05?=
 =?us-ascii?Q?01YIqYOMn1FFqAD17XPAmSMZa+c+XRm2OlMBNdG/Hubpcha25+6mkDPJqROZ?=
 =?us-ascii?Q?7xa0p3AWhV6JJaC7tgcGvcz+oyMx3XI7mAb9rJarURhRxdG6I9gvqVfxf/BF?=
 =?us-ascii?Q?y0aIU+thc5AVsQUkKZ1FszktjWM+XcFgIMuzkhl6eieiUoBeTYWC7FS1Qg6C?=
 =?us-ascii?Q?Mtn9gguJDbDwPA9iJyvGsHcRphgk01/AsYwU923ihp+6frkfmCccf6sahVDA?=
 =?us-ascii?Q?2FPgArVMKKpTCS2ba3H4rh1qR2C43bKfb5HRYaSE8IRYmJz8VDRu02YdRsJ2?=
 =?us-ascii?Q?oV/tVNr0z+WnP3i7L+rMCSYwnQJZXAyxK4gbJibqcEW8ElQRzniBZPIZFFTA?=
 =?us-ascii?Q?RScuwz4CsdRbKJnDMkzPS34iaohprENFpZJtcZ5/50Zd2d+tl3YzyWuadHPe?=
 =?us-ascii?Q?EHCm+cLIZSv8i/vfqzJ3UVts5ydHovw0spMB5FqdXjNDdH681Obbc4XBUe/n?=
 =?us-ascii?Q?cLvAJEn8dEg4ySHZmvebV8We2WuEh0GoiG7KdtHV3G0HdSLUfTRt7xrOa53o?=
 =?us-ascii?Q?OEceS8oL+AAqyfV8DkX2gD4dgoBPkQeumqGOquu68lFdWzG3ne0E2+MZci00?=
 =?us-ascii?Q?E3OIgA2WNpB+AVIqmTMZkHw4GyYpZK34SHgI1i1k9q2SIX0rleqTr0IS59iZ?=
 =?us-ascii?Q?tBSnVx9ikg1MywWPL2rSYYF2Emgu9p/3yRZnjVxB23ffTW4VmfE+8OfBeGXF?=
 =?us-ascii?Q?d7dHP/SMrgqmbic5qB96M8L6Uhiw3Gz4EKjS2NKvib43MlsW47qbr1x+RTni?=
 =?us-ascii?Q?wpyVIdYaNOGT4x5u0WBfZojUoKverGPU/TakQA/nveehEs3sL5EaORFrKarx?=
 =?us-ascii?Q?49b9PtwOqlsJHT/94ahqTykyXn8FtbjU2Fb4QYkjQ74UAqNsiJHuLp2qBq6x?=
 =?us-ascii?Q?ZuuWPorNg7CbEZx62OazpQz6SkpiCZPh6TDUaDbtHmr8FW9ptPSP1qNXFkqd?=
 =?us-ascii?Q?7FOEHX9vuaIMaoGxUPncGx24gMW951E0/aztZDcNQf1L39fb3Jvm5tuITFgj?=
 =?us-ascii?Q?Z/ccWZKSmzaf0CW0GNokT3MfOjXkZX9iPBgwXolwiq4xvRNdMyxH8TZ1Awfw?=
 =?us-ascii?Q?thppBoB7LCvJkk/r0aF1qmqqcaueTQy/TIz6WDbR72JrkdRpyFVQF/SOma5P?=
 =?us-ascii?Q?K9MoI8CGGTatHaUHVKaxi6DF/8Bn+MndNMmWJxumDxQbukB2zRRSu/x4Db+J?=
 =?us-ascii?Q?eLh1W/+XAmrAFkWUspNZ6O/C1KzQSFq4qLw5lURUq5I3R81XO3mwmvxTZKEt?=
 =?us-ascii?Q?eA6EWU0L0Brm7ahCYjjawe2aGJL2rE9g2K41td+CUGfh4iPUtys/uTk2W9jk?=
 =?us-ascii?Q?rsksxYNWIKDNms3zQ3/ke3/Fzk1u3dn7D6Zj2MfL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5296.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9282cd8-04cd-4ce2-2d72-08dc79edada3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 23:28:10.7042 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7w18y9WR5z9kzoCMcs+Wegs64Wgxxyz/pHDdK7G9svGA18emU0XDhiLu7XytV2IVliwmsIh/p08tYVE7BsLA5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5814
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

Thanks for the feedback. I've been able to build the EFI "hello world" appl=
ication, but did notice the logic for CONFIG BLK prevents it from being dir=
ectly enabled even when the dependencies are met, which is why it didn't im=
mediately work for me. Do you know the maintainer of drivers/block/Kconfig =
that I could review a patch with?

Thanks

-----Original Message-----
From: Tom Rini <trini@konsulko.com>
Sent: Tuesday, May 21, 2024 2:16 PM
To: Brunham, Kalen <kalen.brunham@intel.com>
Cc: U-Boot@lists.denx.de
Subject: Re: [PATCH 1/1] Added arm64 assembly for examples/api crt0

On Tue, May 21, 2024 at 04:54:58PM +0000, Brunham, Kalen wrote:

> Hi Tom,
>=20
> Fundamentally I want to create standalone applications that can be=20
> used to help debug low-level HW issues. The advantage to doing this in=20
> U-Boot is to leverage existing drivers and other facilities. I agree=20
> this is niche, but is something I saw one of our power-users do=20
> recently and are looking to share with our customers. Unfortunately,=20
> the Makefiles today make this more difficult than it should be, hence=20
> the desire to change this. My current goal is to enable a user to use=20
> the stock (unpatched) u-boot to minimally create a hello-world that=20
> they can execute following the existing examples/standalone steps.
>=20
> Are your plans to deprecate both API and Standalone?

So, the next set of questions become:
- Why isn't it just part of U-Boot? Make your tool a new command
  instead.
- If for license reasons you can't, why not just start from some other
  appropriate for your needs licensed skeleton and bootelf your tool?

We have long not done a great job with the U-Boot standalone API stuff, and=
 for a number of years at this point a lot of the use cases it was used for=
 could instead be filled by making an EFI application. There's a well defin=
ed API there, there's lots of examples, and frankly for the license related=
 questions, makes a much nicer answer.

That there's some power users out there making use of standalone to do usef=
ul things is news to me. Some of them speaking up and offering to be visibl=
e in maintaining it would be good (there's Coverity issues and lack of CI t=
esting, which should be addressed).

--
Tom
