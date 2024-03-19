Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F791C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 06:17:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C14D87F2D;
	Tue, 19 Mar 2024 07:17:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="UWXZBYaR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18A1983CF3; Tue, 19 Mar 2024 07:17:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BC4687F2D
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 07:16:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710829018; x=1742365018;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=O6SomqAQqY3foh4Zcli2LNpTI0FlVVQ2pBKUa7HNKRU=;
 b=UWXZBYaRsG6DVKyANp7JMljyxf5lrm1omEjZmqMvPosFiEg6b17Emh5T
 G52w2dg/dSV8YkErRNsQjq2rfGsyXc+KLGDB2/dSDtPa7JxbiZ7WKNiCB
 HV9QnKdC96pYaiPNMK2BY+KpPiU8141c8Uzqt0PSlTo1bPV2IpzdEEpk9
 CVINLy9abECtkQXKxqZ+nOjpcNAZRfozJhQOeBsfSF8Qhcm5Cnmrjlzzt
 3rKrtkaqPfOQch7o+BsFcGNfHxV4HQyUYRqdSkeqeakJbVS2E+mPN0WXr
 ITSXWCJz2vzDe1Da1NCLQ1PN2vzOW/Y9spTM0P5L/LSHz+Snk7kk76FQG g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="23132842"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; d="scan'208";a="23132842"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2024 23:16:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; d="scan'208";a="14166490"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Mar 2024 23:16:55 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 23:16:54 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 23:16:54 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 23:16:54 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Mar 2024 23:16:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZAHrqNwWRjYbc3WJvo+ZaR2gQC4CnFxJZDo/TXTZ8i897MTxifVjr4OVthQSbNAZTo8OaFkR2nLRV0aMdtQOM4lswTXquGKvMD43JaSRLuHF3WpnOwZ+i7ch//NQCW+CTu6TgeyYjRNfeEMHQDhbUibUSgPxyhEKCEa8lNTX1dfdPNtqnBRhxXosEFjGJtZcglwm7mOHBDhfZBf4p9cBwwzWU1xoK1eSUVbEai+OZOyAEcNesv7gaNLV5j7MpGmVdWfs7mK/+G2zvMe55b3t3DRU13GAcZ7pyN9rLAucfgY9dr6w4gV3uLcGWmSIIHPLq03IpR5ispNGBUX7eSUY1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmRGYD/+pH0r1jyrgPIm6o0vurRNyKJFPzB1+GjI5cM=;
 b=UbfDRV2KfetEa2Ai8l+UehIAWgfJwEMb8Nb76WOKXtq8VavJoD78RKAOdc9WvO+X6KYPtV/O7Mh7ualrSrvxc9rxgPLugkYPhw3SehNPXhMLSKWn+RLZ/mKqJGuxtyw3KMw6yQ33IbmQLxrWSJ+fB+RclHGNdCKGnRiUIZCSIh+FYO9xtIJWLVi4tfkJhoW4XdgW3QDraFQN7QnvexRe8UWzdQuDOegHuAPSDsnHECOJu+SVSzZlidkQbPj57CB9vUwLtqkvq/v9FL6GJqwEg4QRnfxG1JzE3/m9ia6GhsbRxqSbobPPTV6+ilk6ohptQ/9kwxM05l6tBF2HeLRLxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 PH0PR11MB7521.namprd11.prod.outlook.com (2603:10b6:510:283::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Tue, 19 Mar
 2024 06:16:50 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::2b63:5b44:7f2c:ed49]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::2b63:5b44:7f2c:ed49%5]) with mapi id 15.20.7409.010; Tue, 19 Mar 2024
 06:16:50 +0000
From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "Vasut, Marek"
 <marex@denx.de>, "Hea, Kok Kiang" <kok.kiang.hea@intel.com>, "Lim, Jit Loon"
 <jit.loon.lim@intel.com>, "Lau, Wan Yee" <wan.yee.lau@intel.com>
Subject: RE: Pull Request: SoCFPGA changes for efi-2024-04-rc5
Thread-Topic: Pull Request: SoCFPGA changes for efi-2024-04-rc5
Thread-Index: Adp5A3hlvzxxdemOSe2nfpHsvJxD3gALFZYAACVMAIA=
Date: Tue, 19 Mar 2024 06:16:50 +0000
Message-ID: <DM8PR11MB5592264EEE5C3328E3C0A70AD22C2@DM8PR11MB5592.namprd11.prod.outlook.com>
References: <DM8PR11MB5592FA8A7E0B0164296FD4ECD22D2@DM8PR11MB5592.namprd11.prod.outlook.com>
 <20240318122840.GB3442575@bill-the-cat>
In-Reply-To: <20240318122840.GB3442575@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|PH0PR11MB7521:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wq25XHmVLK2wli9ndnyX/U9WA1EZmg1/D6UTMzHjLCcX1AemsGlqoo7rvmzTRsQD3gKvAuaB79TFx9H2zvqWh60+7GBoNJpmKgPyv8SovK0oJwxLi6ntFGD2P7eYZiA07Qr8YsZXbFQYQzMipM8aeH6Ge64JSXbtRIq2izoXC8cq0hT0s3otJ3KxBO+V+6JT9MDbhJISJ2bqpRUPYWfbRaanCATsqAXzW+pEMiSlfJxNHYLL/KEkHCF9ywFv0OcW3ePxcfJv9rlFOxsjT3/MYTzCC1A14mvRXEz63shJP75uFDosRQcIoubJJ+sWAEAqhK+EDID9rnLo5YMXVatlZdXYSurg1Il/xiavBnD0N0TqjEndPMEtW0u645mVHHhyYf8VXRSP2tEyjOBz0YdPB2wDmlbVFq2IBx9cbDPES4eHb4Eb2yQy44ITnlACvwHkVI6pTywuroB1NCRcn2h7jD9dtJrtw6ElQUswhxMSWWnCzh8ftAvYwxNIn1na+bKyAxqCGbZQj7GuxtHpSGmjTziARGPpdPTd2ns5vVqDxQ7Ok1T7djymLnk7gHScptDUQUCcRB54nLTZaEoIsCEZzBcs5eM9d6hTGB8/G5bMOsg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5592.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sOQk562EeUZYwCdXvONBtNu0LOEQSuoo0s8NiHRIGGgYWAaCdoUDdJIQ0qDk?=
 =?us-ascii?Q?qrCR16SOroG9OPOp4nkWVwCJtWpDg85MiVeloI53qBAggVtpTVINaFsnU9NC?=
 =?us-ascii?Q?+cSTZr3l6Gba8Tu2uYf06Hj8jkuWQuRnn8lmFtZUj43OBuyOW6J1db1epUi/?=
 =?us-ascii?Q?/BxD40hbKh/tB8VuNqR4dOKg5BpPQU39G12VM+dzkL1cTho6FKtSPBCp2ynh?=
 =?us-ascii?Q?tSlLCWX+Fs52v/gfqQFuQDxkFSMu9xQx4bg7qY8X6tg+gs80l+F6z06tygBO?=
 =?us-ascii?Q?P/jhV8XOVfD3gL02nN1XuNCrEYR0EP0VpQBfpfYRQs8PllyD9GVchuW7BCrW?=
 =?us-ascii?Q?qP6L/zs88C6+50I3wHFt07ZpKPPSNdTRZFCzrCu8tuk4I9+rQBcyPctljUOY?=
 =?us-ascii?Q?OpTkMiTzYZ9XlsC8ObxB10JzSj7XdPhFUlTA81P0fkuSHs/NQ5B4nqRR/OHx?=
 =?us-ascii?Q?Vu3Xc44O9bT5WkI1dOMDKauOWIMgtmO3+YYwUNk85+Un2Aj/4cQ60Pvjq/Fz?=
 =?us-ascii?Q?wX2SfwjeJiXbhfaADD/ihf/kjmFBuM9rvPn9AAYaxRd1juqBBAIVHawoxwtf?=
 =?us-ascii?Q?rFEZhi5OyRtZvR0PN+19kmViWL9KCbCLQ3YxIJ2wn3g8KwhplmNrwSOgpbW2?=
 =?us-ascii?Q?aT3nuvjgkEdTpkiCN7q07VxyNHfsWVoxmEfHNHbUrEgNwbvs3wEFGIX/ZsC7?=
 =?us-ascii?Q?PCBcerQg0byt1brv/WQ6lpLijroEnSxDy6kNbGtujEjr7BesWMsUwTVuPQMq?=
 =?us-ascii?Q?/GFv+f0Hapvko+aqvu5h4pdYyrcb7Fu826l3NYUbMIbcVt9hoMd6MUlvLSaX?=
 =?us-ascii?Q?n7lQ5FLGChxcJDJoWOXWEdZzRN/zCmNn1gscwMJNi27ZgKC5C3fix+zDxRFh?=
 =?us-ascii?Q?jKelxCKqPsxak3dGjLBRNhHkiSOGF9i1TCPYqcX/uUwW7raaeY20q7LFx96O?=
 =?us-ascii?Q?WfTnAxoa99WqYf8WnUYkJ9FiuGvlwckxbXCCaHL7nH6ZE0wdjx6eLSnS3axt?=
 =?us-ascii?Q?YCi5YCmZD6fLStRTkiJVwrShKPpQPNKgZyc8+hVMBTFea0S/rMTo38ZxQPG+?=
 =?us-ascii?Q?lCOIwpLOrimULOmsbuIxLbMo1lGlb6nOBrJAfrtBUKHiL6c/o7DJ/9gCqIoE?=
 =?us-ascii?Q?C5vbW9IjXcOSItop9LGG9I9beynttD7cZwcLwzlbUtES3QBiEcbxYd5sbJre?=
 =?us-ascii?Q?etuEHiO4FHkxlz1KbI2LUospqLJFGH/0qQiLm/EA4+kixYjSX8OHa/K/xWs8?=
 =?us-ascii?Q?4JeSUPuOeqUkTkWw2qeVG6jXz3uzVTDHUCtKp2R9tEU2wUq2HedwcZX0K5wi?=
 =?us-ascii?Q?yk0tNawMeHdEmMQaAM7kl1dSKz8OeKUnnY2bIUNohDEhOdG+N/jXT3vYOOMM?=
 =?us-ascii?Q?U2jzYuU3M8Shqir4pgwdsh+jnwRfv85QbI8sIQxB0+bUqOzXVIGalcFsWuoi?=
 =?us-ascii?Q?SHzPpScN5+QZ5Lv6tuZnavdZWBjI/q4KWOFhV/cbNoxm+BmDeLmAj/nawuSM?=
 =?us-ascii?Q?oTcchDi/u8OaPQS402NFMesXEfFJ5ccdgkyZE0W4XcGG2QjuaG5TzAE+pbVh?=
 =?us-ascii?Q?NurRoDNHS0ZgSxAQH2Pj6WfCZNaqBQUcc6op+MRP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf41a37f-0dad-487e-8b20-08dc47dc2a3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 06:16:50.6374 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 39oPSbJ7QtfxU8Z25um33U0g9X6NDZMD/B3S+HCWFD6hTKEl1S8y+GrDNHEl65wZ1+fLBjNx0C/9D+GUNTFN/oAqHIOkhMGAnZmNQOaWpmY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7521
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
> From: Tom Rini <trini@konsulko.com>
> Sent: Monday, March 18, 2024 8:29 PM
> To: Chee, Tien Fong <tien.fong.chee@intel.com>
> Cc: u-boot@lists.denx.de; Vasut, Marek <marex@denx.de>; Hea, Kok Kiang
> <kok.kiang.hea@intel.com>; Lim, Jit Loon <jit.loon.lim@intel.com>; Lau, W=
an
> Yee <wan.yee.lau@intel.com>
> Subject: Re: Pull Request: SoCFPGA changes for efi-2024-04-rc5
>=20
> On Mon, Mar 18, 2024 at 07:17:24AM +0000, Chee, Tien Fong wrote:
>=20
> > Dear Tom,
> >
> > Please pull the SoCFPGA changes for master from u-boot-socfpga, thanks.
> >
> > Best regards,
> > Tien Fong
> >
> > The following changes since commit
> 86fd291a7990af84e96808f48eff2219dd4ef496:
> >
> >   Merge tag 'efi-2024-04-rc5' of
> > https://source.denx.de/u-boot/custodians/u-boot-efi (2024-03-13
> > 20:39:46 -0400)
> >
> > are available in the Git repository at:
> >
> >   https://source.denx.de/u-boot/custodians/u-boot-socfpga.git
> > 386fca68960994ece0d9da8a69a14495b5f1aedf
> >
> > for you to fetch changes up to
> 386fca68960994ece0d9da8a69a14495b5f1aedf:
> >
> >   arch: arm: Agilex5 enablement (2024-03-18 14:45:47 +0800)
> >
> > ----------------------------------------------------------------
> > Jit Loon Lim (1):
> >       arch: arm: Agilex5 enablement
> >
> > Wan Yee Lau (1):
> >       drivers: misc: Add socfpga_dtreg driver for Intel SoCFPGA
>=20
> Please rebase this on top of the current next branch, and use a tag rathe=
r
> than commit hash for me to pull. A short summary of the changes, either i=
n
> the tag or pull request email itself would be appreciated as well. Thanks=
.

Noted.

>=20
> --
> Tom
