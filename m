Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8CD0CA0EFA
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 08:38:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E9108304A;
	Mon, 25 Aug 2025 10:38:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="n8anmlAv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4BB88304F; Mon, 25 Aug 2025 10:38:05 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::625])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8606081E13
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 10:38:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZOiLOyF253ASCUTf6cT5qbjgkjQwx28JbBeNv3pvlZs6V5/MSmtoHpAfdT4Yistxt+/dcmIeD/T2T3Eztwoqurxk31lI32m8QD6TRx7qDi8HY1bPJtqbjCwxNry9PQ3mPO3i4hgBp29WohGo0n5ZGdxTuIH2EzwNuyK93LIhgd2W6Cf8uKOkmPuodTaCsgUooX1sQYWiKC9gfK2Zk2w7OjKErEJntQie/RP7E5qklXkQLRa3f8LFWCfZy5peL6+qSt3d/9wXfpVCh8oABM5jywsVpk+WgIX5Ud3hgCZICh/4qB4W4rT7089vIw0N9Cndq1pwwCdj8If/BhYxe8LwiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hL+HnuPav58LVYWDNNAFu9H+dcw8NIr4ujWemo7QGxA=;
 b=tr+qh1nxCn58YKd6uwDm8/cGURWQNmyMCX1lOY5BtHzCdnhgfg5KpGAwAypjg7bzN2kmjfj/3nwv1xINqmhbvr5xnLpXK9JD39qU1AWR+FTZVl3sgSf2MAkuVWOx9j9WhO7ps5ZAneTcQAv9gDky1VtEZihR9DzB+nU/ZRrqF9zVZ2ms7s3S1OG4lrtzD0w2gog3gK5ARgjmUQ0m09arbifgIHwjQx1kk/joxuOmQ5G6NqrWSwQtSIl+r/6CPDbDr2eaxFxh72Kt8XKG9o6wQNLC3DhXtOwPIR3Bg4Eqa+lG41oCSSTAukNdEGKgCpz17hfkumCYX5rQufetIi3lPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hL+HnuPav58LVYWDNNAFu9H+dcw8NIr4ujWemo7QGxA=;
 b=n8anmlAvzHB2TdU+B9GQ3Tcl1bUq3PZX+5CVJtpfogvDFstQCr4G0cXmRxPiC2JyjzQS17FwtsJ3q81Db2Tl5LXLLXAmbRpi89X0g9IChlBcM4XHG8SiGBMAfpPGivKGcKwPm73s5UdnNDqoKp6aXfeptf/xl9QBt6I7dwroFKY+iKVhhatt+CLxsl9kwU+gS9dS96N8GD3ue5SF4/p4KUlfHHB2/2lH1l8n/UpPzEjKmf+sXatXtLz0TPefQAFU0QeXIt72Riz9cekA2P6eionMISyIelIvKJYnCeBeEqnkITnJCRRzDYgrkJFQFPe6KzmAA+OATkvjybthw0nhLA==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by DM4PR03MB6998.namprd03.prod.outlook.com (2603:10b6:8:44::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Mon, 25 Aug
 2025 08:38:00 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9073.010; Mon, 25 Aug 2025
 08:38:00 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH 2/4] configs: Enable USB DWC3 host drivers for Agilex5
Thread-Topic: [PATCH 2/4] configs: Enable USB DWC3 host drivers for Agilex5
Thread-Index: AQHcCEvStE/s38ss+UqqZs7J2QkrjbRzJn0g
Date: Mon, 25 Aug 2025 08:38:00 +0000
Message-ID: <LV8PR03MB8137D18100B36A95A6E8CC1AA73EA@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250808100412.9320-1-nareshkumar.ravulapalli@altera.com>
 <20250808100412.9320-3-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250808100412.9320-3-nareshkumar.ravulapalli@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|DM4PR03MB6998:EE_
x-ms-office365-filtering-correlation-id: 61a0d734-9da3-4701-2f12-08dde3b2b340
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?PGOoXyCkg4becP1L5APM8war66mayNcIreg4ivDYPLqvW1HDoyDi8ZH4n/U3?=
 =?us-ascii?Q?G/4g4uflTu8/pttJsm9/qxOtvl6NsIQKxv/dCUVr8DwkU18YWLOJEW14+rER?=
 =?us-ascii?Q?iRq0A8WI5e2B4hAkhbYYkEpt7R5VFDe0ReXEDxVUuWiokgP77hAc0TLe+7ii?=
 =?us-ascii?Q?+Qn8Kdnc251Vp7aQv++5gg190NW4ewxKlsg55LiL98R9lpx5AcU4udj0Zr7+?=
 =?us-ascii?Q?WPUcEZ9zsGmyquYyE9qRd9TaUyqg8awSMCXlVCEJZbOZ4mJlsin+MBddA0iK?=
 =?us-ascii?Q?gsHJekRhQdXy2HpVBqUmP/YcUBAdk3BdRwgtcZkuHWc2HXIGvK09YKORqYHh?=
 =?us-ascii?Q?dFL1rwHnDpq7BG4nTV0ScJ1IhriFy5DRkZU7JnCCx2e4rJXWzreojJ5JcFag?=
 =?us-ascii?Q?xJeOkw07SvGaohS6KJ0r7sLEthJZqfjgL+fOqRYrMfmZ54JZqjb4G1Ra+PvP?=
 =?us-ascii?Q?A6BjbdKoifYu0SWLK4VThOiLE8wEjFJcUw80L7Dpw8vpMPHFwV4Eg9Uw5J54?=
 =?us-ascii?Q?l5q2+I087pSsiG6UTLPnUPA0bRU8n9QyD60mBC7Qtvs4MPu7Ht7FNC/ChNLS?=
 =?us-ascii?Q?1JRrNjCZFQ5TX7mA3YXp0HISwOPA0E6hpvEY/QZzcdJWi7qDv5I8V6NNZIVn?=
 =?us-ascii?Q?IS3BcApb22Zmvv+nOcvazuQUJqtazmls0HPBGI0irWYEDzJ2HhTXSLfgqsz/?=
 =?us-ascii?Q?G+XV6wh7e2fTrmu8IZrV9rDMbdd2QllfZnUgSA1IuGDVYeiFFwnsE6qY77i5?=
 =?us-ascii?Q?TdzcZKGCFexQBkHFicwl3Dsoz/qWDahllaMdFPUa0srpR1ArQg0cqq42fdpl?=
 =?us-ascii?Q?SOZswcT8nOCHBwWPQIR3UZxaw5RHMGPNIleqaeUZOeBvWlF/QdhISy467jvA?=
 =?us-ascii?Q?yCJUSLvg9nhE4OL5sT++CAxM2rsve39I0qJYsmnaArpbI6Jiujo2AIoHEmWl?=
 =?us-ascii?Q?C/ThEzc5v2/ak0+fTtmfLzRylSj5+n3xW+oGDGxRbrzr9D5NtwZMjdLB4xlc?=
 =?us-ascii?Q?lPFCL97hHUkrUOWlxdXoC0T1ScHc72vAdFB0KtTNqPT3TaVhl13An2G44nSN?=
 =?us-ascii?Q?4h8EkC17N4vKh3BXgJ6PVDVeGarD+gamvIh8LFRV7nlh6UfBW3tNVi2cfxvV?=
 =?us-ascii?Q?+pIT+lDu/OR4ayPrV1xGefQ+QJjrAXFRvzxneYQxf+AEjs9a8HUaR1453XZn?=
 =?us-ascii?Q?C1D4YLlG3qgjjOkFf/zZ19D6k2AzR9K85Tbi44sBQYR+wxb1NCOjY7aj0U3Q?=
 =?us-ascii?Q?pXmjzO7zwMkQd8LbC/0Hk27TLWJhlgUwrY+mTA3URSTa03WFaYX2hArXSn7V?=
 =?us-ascii?Q?rBP0J1fNFO5W/dbQivyXuyf3+9W9sobaNy5WGFG+eBLAqLu580SUcbYUjvSz?=
 =?us-ascii?Q?4YwxAt2Y0V1xU051GbDrnf7/Cj7DwyiowPVGk86CCHU22CiCVQvufUVXmTWL?=
 =?us-ascii?Q?TM9szvNK2wWKzg8kKehNFE1MBZtp50Plo+Qp9CPPrM+KWbyPnJOkeg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o2Lw+J9TjYH0GIbKZpWErwkQhXTmDty+oWJaKkk+rvKomKdXGX0iyVNbkem4?=
 =?us-ascii?Q?pNb7W23DuM0QhDBqW+aAp/mtHQY1qN7Ev6atJt8xzrWgKDsRvvFl00etkkZa?=
 =?us-ascii?Q?A/INTY0JcLSpNZyKV5PnoHiIA6+Rl+Vx/Zd4gT6hVcLQS2v3UhmtKV1bHAmo?=
 =?us-ascii?Q?kdwe3jx2pMONc1GEZObZOp8kMeIhDD2DlrgBP6onRkcgGf6c/Ee1Pindvuxa?=
 =?us-ascii?Q?4XY2rdeaPfVxikgtL+a56GxCxYmkAe0OQGt6pki82+nPuwACLZkWDtrsXI/q?=
 =?us-ascii?Q?jgVuDjn7OSyc6suSl2eEL/siPSGrrgL1ktVo+pI46koLrnrqYlBVzDebc1Am?=
 =?us-ascii?Q?dB8dUq/n1HZZYjI0bvvzOz1+qIpbcbqDQRiQzkCG/CO6TUojPqcvdNrGEBT/?=
 =?us-ascii?Q?ND0b34nK1JYWX/7g997H5f9CPFSstSImTQklNMxPex/vj7L1HrluDzBPfM9l?=
 =?us-ascii?Q?ftpHGdmWh3NlectkVQL1YggpGXGJ7zaqroMA0ki43qPcivvhOkTUY9OhmO/i?=
 =?us-ascii?Q?VIBi9uTF7cveLCQ6CUQ+B/rvUkjhxxp71RQJwjlcmS+3T5I2mUV3Ht+1xfXx?=
 =?us-ascii?Q?Z3puQ7UhmxLgsdn3jAF1uTBPMnyOd0v9ksHbCYQwayvBU8db0oVJIDgafAHv?=
 =?us-ascii?Q?h9lk/KsxwuiLpjwYbMJZxg3NZOWvWXx5hBn5jxt0ESw1jnYki9mJQM1YPhSP?=
 =?us-ascii?Q?AWkpDo1NVRfjBu0sMVcdjSZ17d+qnPXrsYhUpV1/LvKGxhgGHd2bsxIfJe3N?=
 =?us-ascii?Q?rkF3bXO7r6A3QdNj4a/DN+MJgidExv26C+LP92EePMShoFhe1tVFbpkAHRy1?=
 =?us-ascii?Q?+vHb52nWnoVgZYatS/8X95cXlifH5sE67byZdsdXmlowZJzPUB/2deHIWK7B?=
 =?us-ascii?Q?SZnUONa34TdKFURrb5xgFAlLDvML7yP1LgKUweE3ngqThg5oPgjvQ0QNZkKc?=
 =?us-ascii?Q?ionOlYpcivtajflWgmpSj+Luvn4f7OKX4/42KlT6fKfDA3GIXo2Ci7PQYz0K?=
 =?us-ascii?Q?hB0KqGT33JWXadgktAujn3rmTfN2Z7sZRg8Pqq7ZQUZJLQBzzbalqMZLRxxg?=
 =?us-ascii?Q?RxvKXjF1tm21lWYNbePtDAp9Lu7qY4U9pR6SHwI9igAp/qJgAskWhAZOw4VH?=
 =?us-ascii?Q?iheKMqMTSokbJqB3WXGAB3Z6sZzgpPijlA/jtuNjHWqR6KAYYawT3QP0D5mJ?=
 =?us-ascii?Q?N5qoWMpviERosa++GecRVJd2+8DQ8sjefaGjTha95kJ4naxRLO4KN0AgtqgS?=
 =?us-ascii?Q?/DsPFLYKKzdLwM24XNHmVDfA2BiRWOe7Wekw3Q3HP4cicLbkfeK/qHvuoMrz?=
 =?us-ascii?Q?CpSJ8LaCyQpYqVmA6iukDltRt5I/CHg5Qr89RjYGjVQw6PmjNwtmBG97iUFz?=
 =?us-ascii?Q?7geG7+cT9EStsn2N4xGciSPuQ6SOrWadwOXE0c5ClaUYz0ZPdc9ik0uxpwEn?=
 =?us-ascii?Q?XQaToeWasF2AkHww45pbMRp1FH3M4xUFRuDM2gy1I0hsgA0bMzbAIyhPaUD3?=
 =?us-ascii?Q?YCN5xq58ooN9xhHkQvuHyVXTZXcg/B/VrE8AatcRr96CV1Uow5ltKRWkZQro?=
 =?us-ascii?Q?sz6fa8aTnNxiWDvimx1+j2J4wh3Ud2Vvd+2FmQun?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a0d734-9da3-4701-2f12-08dde3b2b340
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 08:38:00.6915 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B8b9DcedlQWct28/l0nlJHYeoDRcWrPKrFuAfZeGfF2AVpokvz2wtyCuR2E4a894VV9KM1yNV7iKVZS67G00VyZh3ppAcYnwz5CXDXh47LY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6998
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
> From: Ravulapalli, Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Sent: Friday, August 8, 2025 6:04 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Tom Rini <trini@konsulko.com>; Ravulapalli,
> Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Subject: [PATCH 2/4] configs: Enable USB DWC3 host drivers for Agilex5
>=20
> Required USB DWC3 host driver configurations are enabled for Agilex5.
>=20
> Signed-off-by: Naresh Kumar Ravulapalli
> <nareshkumar.ravulapalli@altera.com>
> ---
>  configs/socfpga_agilex5_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/configs/socfpga_agilex5_defconfig
> b/configs/socfpga_agilex5_defconfig
> index cc812c7008c..859750f02e7 100644
> --- a/configs/socfpga_agilex5_defconfig
> +++ b/configs/socfpga_agilex5_defconfig
> @@ -98,7 +98,9 @@ CONFIG_TIMER=3Dy
>  CONFIG_DESIGNWARE_APB_TIMER=3Dy
>  CONFIG_USB=3Dy
>  CONFIG_USB_XHCI_HCD=3Dy
> +CONFIG_USB_XHCI_DWC3=3Dy
>  CONFIG_USB_DWC2=3Dy
> +CONFIG_USB_DWC3=3Dy
>  CONFIG_DESIGNWARE_WATCHDOG=3Dy
>  CONFIG_WDT=3Dy
>  # CONFIG_SPL_USE_TINY_PRINTF is not set
> --
> 2.35.3

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

