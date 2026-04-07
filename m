Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39830FB519E
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 06:42:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D2B283936;
	Tue,  7 Apr 2026 08:42:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="n4SM5QCK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CA2083A41; Tue,  7 Apr 2026 08:42:01 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8895A8352B
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 08:41:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZXysO9yTaZ8tQ0LoTZaNKBidKq+psqZBEtMG+4o/xLabs8PKjYpagrpM2iHCZfKQbwE0N8Spvpy8ReI0SVpa+CQICydR+Flizp9YhRSLuJbxjVJsh78YrhQptc8GxnPs49ORFhdy1NZ826MeaWV4qCEzu+Xv58a+RJMF/iPIWeg6vUHPKKTDE8WfYO8GI2mee0VpX7fTBThaJGWdP5srhoi08QsQwG0HVmGAwLeVqrnwsB4YPd1hdjGf8iQ6Pv6pn72EMs2+cP/jsDgoy/G3QSACQ94ee7IkaAF3UxFmsOHiFPZg1cW7/mg/VYYyKKqJqE2z3sKza3H/VbpZiAn8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NpYqOoapFoWQGpbwd+eZD+ztjbR5j4XjNcG2YE6qJQ=;
 b=EFjU7NxClh0rmE+Varzae6xXKNOGNAeRuOqJvA0s5YmB53AtEv/kq85/EvX3QcjE5TpemZl/FhgpRxJBGhMTcA88o9xQgipTavfG5o4eYbfC9+ikuzL6fcSOklX5/TMRr3yRj7tPPCFP26STHs3wFFz0y3zWNiPXsxFJkNQsozczOc6KFJGIi27uI7EVem8aTlRfxL4BTdTLnyUsO6dAQ9paHTQ4sFtnBGacSAuwZVzIxehMSpYT/I4oszW9xu6YZKCyRZzgS0KUIAEYa7gq29IIFVyyKOF5YhlXY6Zmp2XgZykKKT0B4LZzXd4REoYpZOKreoB54wpAmNChGNNeNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NpYqOoapFoWQGpbwd+eZD+ztjbR5j4XjNcG2YE6qJQ=;
 b=n4SM5QCKrhKbFJQPN1jjDNEAb+C8w2zj7IC//Q23CIR2UfyDiIi7Jc+ZNaS3cxJ/WRWJQChpJcwtk17/zSlPmD6W5pD3gotOLohl+AXbxwlutgpHvIs0ymqbaxT8M1P4/556lLzl3bijR+WuO+/VYwK91cuQ2q60QBgJpKqHGSpHj8lE+lAJPW7Zba6gW2vMbVRTFsRnzAzspz/Uj0IQgL/mrBpZlDlIJsd+A9E/C8SQlhtbTH8XRrqey7SUz1Pu/u+33zU8bwB2+4k9ucoKcsChAtVktRVnub11CL6YmqRPTaLUw+LVfjZeHjR+tfEusmXv4gZC+70N4Jia8LV4gA==
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by MW5PR03MB6960.namprd03.prod.outlook.com (2603:10b6:303:1ab::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Tue, 7 Apr
 2026 06:41:53 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9745.022; Tue, 7 Apr 2026
 06:41:53 +0000
From: "MANIYAM, DINESH" <dinesh.maniyam@altera.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
CC: Tom Rini <trini@konsulko.com>, U-Boot-Denx <u-boot@lists.denx.de>, Marek
 Vasut <marex@denx.de>, Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Richard Genoud
 <richard.genoud@bootlin.com>, James Hilliard <james.hilliard1@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, "Chee, Tien Fong"
 <tien.fong.chee@altera.com>, "Hea, Kok Kiang" <kok.kiang.hea@altera.com>,
 "NG, BOON KHAI" <boon.khai.ng@altera.com>, "YUSLAIMI, ALIF ZAKUAN"
 <alif.zakuan.yuslaimi@altera.com>
Subject: Re: [PATCH 1/2] mtd: nand: raw: Kconfig: clean up SPL Cadence NAND
 dependencies
Thread-Topic: [PATCH 1/2] mtd: nand: raw: Kconfig: clean up SPL Cadence NAND
 dependencies
Thread-Index: AQHcq4aKJh8vW2pBCk6IILThfZsHE7WeclEAgCHM7b+AADR+AIAS5yzo
Date: Tue, 7 Apr 2026 06:41:53 +0000
Message-ID: <PH7PR03MB6942E3711A99A34A114E614AF75AA@PH7PR03MB6942.namprd03.prod.outlook.com>
References: <20260304032441.31558-1-dinesh.maniyam@altera.com>
 <20260304032441.31558-2-dinesh.maniyam@altera.com>
 <20260304143920.GT1388590@bill-the-cat>
 <PH7PR03MB6942D3E727EC89DE074BC0EFF756A@PH7PR03MB6942.namprd03.prod.outlook.com>
 <CAOf5uwm9eEMKe=CVGbZavGgmv3SArnnLZNcJs1RZJW7H6vgw_Q@mail.gmail.com>
In-Reply-To: <CAOf5uwm9eEMKe=CVGbZavGgmv3SArnnLZNcJs1RZJW7H6vgw_Q@mail.gmail.com>
Accept-Language: en-MW, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR03MB6942:EE_|MW5PR03MB6960:EE_
x-ms-office365-filtering-correlation-id: 8f537102-8715-4ca6-fcd8-08de9470c130
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|39142699007|1800799024|31052699007|366016|8096899003|55112099003|13003099007|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: jTuHQXfcwENbGiJtLBh//Yt/+t5UXTzc50qAEq51rGWE7taKv/PYL13BWMrWj7Nx00lbRBLByGwF64Zk5e6B029Um14u/XLGfkFpyTE6H5Ib5NQyrcmXXBKdjDm4zYjDwKMabeKil13+HYqMVN96iSOQmPoWyCmQ1N9VS1piAOuU58ruu3Rp/AmuWp19X0dz6bFXI7juDIYIkJYsdaGg/vPp9mWaUsK22ppSCESWJATXxvzEsMNUCaxCSKdviEcB4bJbCmK6z7vR0vrCYEY/I03ZIEaokNHm7l6loFYlD/GpV/7gkqalxSQPTQ594/ZnGvCIJFRmkIeZ9rTNqaYckVRpuJbno3zFFlun5Q78ok1To3hZfr1x9FDKD3GwQ8FlqIyi/mFvvVsbo5YvCgTWBu63h2tFj2HsQvZ/pJuTpptR98fY2OonGU2RJXClOI2C36diTv2LmBSuidN3nQn0tOO4Id6tnyZm4tyaIHyIjynfTrJV9Is7EhbYrOgLdGO4cTJbJMA4DH/34Dk9gDqTLMuquD+OPKnU7CUjjDdaOQvTNRiIAlPYG7vcCOrAD9/GjH7ZgBZ/3JJ+ZplleDQvsz8+bJYIC4w8qZws3QZjFXokE7HApNZLls4Olui7XKCCcSHxtb3ZkVAKqr4eNsjINfLDjkfrj+q0xfJqVyNUruSZdtSkYXT/Ahjjp6Eo3/xit99AOsZAv9Pm6oLKSdwb3HAZMh6zh775Wxnj9i6GzcE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(39142699007)(1800799024)(31052699007)(366016)(8096899003)(55112099003)(13003099007)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?m6EBplBsZKSkpmk9JPFIPUut8zLdD8NfR1lJ42MqoSAM5VJKMF6AdRCx?=
 =?Windows-1252?Q?JLohfP3J0TmtRVcEboWuTahYUSO3SPijScX+e6p3zF8n4ridZtEw/3jo?=
 =?Windows-1252?Q?ILztZvWYkzq0OI6COq1WkI7bwM+R1IFt1yqQd6GM/6jp4tagsjOr00sy?=
 =?Windows-1252?Q?hqNOBP7vp1+HxNa0amNiwj3TKHAWJLr2WOWuJthtY3mRWzK2Mk8k5ci1?=
 =?Windows-1252?Q?cQ1qnBlmvxrSFZIK7puYf6pHYMcwHE/dyH85g9k/SA/VFVTSVtW5AOL1?=
 =?Windows-1252?Q?bHkRalZVPW6/xNxSRBEwvtiApEx0Bwl6ovMTChr7cmOoYvdc/gVY8ED/?=
 =?Windows-1252?Q?2RX3zNu2tBjQRsmkZbvUwsyIZT+HBSUC6Pcv0HP9xLqDdgFTCvC9/iXp?=
 =?Windows-1252?Q?Zj5NTGvLVjDe/Rz9OVTzdOqRmgClqVgpNsI4s63nJ35Y0QcFL7PcxwxC?=
 =?Windows-1252?Q?hw6T+jDLAXoMu5txRdr619ip6D3H+bQWyXpIxV/uIz1Id3V1ITTg1a/u?=
 =?Windows-1252?Q?nxqyceTbnTundPOiSYYwtmXJmKr3+8DjOy4O4WMGe5TWGgeXac3E7nV/?=
 =?Windows-1252?Q?f9EElHRBLbYNyFy/EgKTqHePx70xy+YV6AmHUd62X0SSpnARDO9zXOBN?=
 =?Windows-1252?Q?PW2N/H7VffxqU/JsF+Ap5g3oHjU/USFkby9aL2u6yvi/7repT+I6vxT7?=
 =?Windows-1252?Q?fMvdg5lNFQpqHTyJnIP4cBaZf12C6SB8rnzpHzP0/J1OOeEcgot62cJc?=
 =?Windows-1252?Q?S6MsNCvN+6M2ZLmmxtaizAChKHgrXxJmDCVcRB9R0ThAzOIIpUCBtmne?=
 =?Windows-1252?Q?UJBHbbyPD5iH3HHSlUkDWlIKkD6mQ316LdRhpi/yIKeOYcfi+DuhouJ8?=
 =?Windows-1252?Q?OeNDYvtYR+pH2Z7Q7XDgz3zZXeOXnDKBG+mFyEg8LStyvSaHAWn0V48o?=
 =?Windows-1252?Q?CED6+2WHfyhHn4X2mFdX66lkBfa1OtEz4i3Un7mH0xzfIJ4++j/xk4Kc?=
 =?Windows-1252?Q?288wXD3ITvDw710tttRlxY5Rs+690rykktxulLZQiDWeNRytwfNF4Kq0?=
 =?Windows-1252?Q?cUs+jCXy68rVlLDcR3qZadV+V6jpzKbIthXkpj7GFMUFRI6VDkeJnMu/?=
 =?Windows-1252?Q?6hWWwDMwFqNFrQpHw7hPGrN/0eh99KnX8gHH2n6VQGCc3hJKpizm9EFe?=
 =?Windows-1252?Q?SRkvYPK3jLDBFgUt5/52dX9lj9YJDZIIcyhakioHBZFsaprdxWGnVViI?=
 =?Windows-1252?Q?+eik0kyt2L8/4cKShWtt97+5zMXi9MMvNGSDAqMHKQ9nC7FMdugaVj2L?=
 =?Windows-1252?Q?MAVnbAEDrzgu0CIN5MMVgUdzYnRVFuWDm1G6r4ljAwr1j57Q1RJx0Muk?=
 =?Windows-1252?Q?fPvX2nlQgjOi3cb6EEoXYb0VztkoqtVJdqNPeE1u3Vq5OU538yTrt0zf?=
 =?Windows-1252?Q?MQBAnbNAlyoziIzRQy0o+lDENsbU3mQDKcM8DaDMvO4GM8DZwuzeawDD?=
 =?Windows-1252?Q?wGdrKtT1zkhjWCoeGikOzXn5gw/JXQ9R81OLZ7yQ5pGdTzXwAOYZbPgX?=
 =?Windows-1252?Q?/AIPT7tIWj89jzmV1HC1ILfvLuEMdFNW6v/xfn3Dd6UBWGTlXDwhu8xA?=
 =?Windows-1252?Q?CRfaLEsQ8yCcHYT38ApnMlA7oX68jIxkFQQVrUC3u3XbpVxf6KMBs1Yt?=
 =?Windows-1252?Q?RIl6YyZ27le8JGZ2B4k1MIrq1W49YWl/gA/HHKHqKZWGkqh5/hUd2OCT?=
 =?Windows-1252?Q?MYEeQ3sXuQnRkSWfwthnapcDiKSqY/i+mL7SpNxUNSpPj06ZUyyv/SR1?=
 =?Windows-1252?Q?0GR4gd45gJOqTfN7VNDXT+1MIE4gSvbiG2IHJJ0/htObCmkYq77BumuY?=
 =?Windows-1252?Q?nRSKJJ8T4BDXPA=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f537102-8715-4ca6-fcd8-08de9470c130
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 06:41:53.1289 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZtUW8to3TuPTuzcxspOv/3vIF3bIDU+yTH3ncA5eXD0FDn4H6tZCyMyXWz34mUwdbSatbbNGvpGAL+i2cGIOk9Zr5gtqEuDkBwk+pn5mdT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR03MB6960
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Michael,

> Hi
>
> Yes I have two series on my queue, I I will work on them this week.
>
> Michael
>
> Michael Nazzareno Trimarchi
> Co-Founder & Chief Executive Officer
> M. +39 347 913 2170
> michael@amarulasolutions.com
> __________________________________
>
> Amarula Solutions BV
> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> T. +31 (0)85 111 9172
> info@amarulasolutions.com
> www.amarulasolutions.com<http://www.amarulasolutions.com>

Any update on these 2 series?

Regards,
Dinesh
________________________________
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Sent: Thursday, 26 March 2026 1:57 pm
To: MANIYAM, DINESH <dinesh.maniyam@altera.com>
Cc: Tom Rini <trini@konsulko.com>; U-Boot-Denx <u-boot@lists.denx.de>; Mare=
k Vasut <marex@denx.de>; Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com=
>; Dario Binacchi <dario.binacchi@amarulasolutions.com>; Richard Genoud <ri=
chard.genoud@bootlin.com>; James Hilliard <james.hilliard1@gmail.com>; Miqu=
el Raynal <miquel.raynal@bootlin.com>; Chee, Tien Fong <tien.fong.chee@alte=
ra.com>; Hea, Kok Kiang <kok.kiang.hea@altera.com>; NG, BOON KHAI <boon.kha=
i.ng@altera.com>; YUSLAIMI, ALIF ZAKUAN <alif.zakuan.yuslaimi@altera.com>
Subject: Re: [PATCH 1/2] mtd: nand: raw: Kconfig: clean up SPL Cadence NAND=
 dependencies


[CAUTION: This email is from outside your organization. Unless you trust th=
e sender, do not click on links or open attachments as it may be a fraudule=
nt email attempting to steal your information and/or compromise your comput=
er.]

Hi

Yes I have two series on my queue, I I will work on them this week.

Michael

Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com<mailto:michael@amarulasolutions.com>
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com<mailto:info@amarulasolutions.com>
www.amarulasolutions.com<http://www.amarulasolutions.com>

Il gio 26 mar 2026, 03:57 MANIYAM, DINESH <dinesh.maniyam@altera.com<mailto=
:dinesh.maniyam@altera.com>> ha scritto:
Hi Michael,


________________________________
From: Tom Rini
Sent: Wednesday, March 4, 2026 10:39 PM
To: MANIYAM, DINESH
Cc: u-boot@lists.denx.de<mailto:u-boot@lists.denx.de>; Marek Vasut; Simon G=
oldschmidt; Dario Binacchi; Michael Trimarchi; Richard Genoud; James Hillia=
rd; Miquel Raynal; Chee, Tien Fong; Hea, Kok Kiang; NG, BOON KHAI; YUSLAIMI=
, ALIF ZAKUAN
Subject: Re: [PATCH 1/2] mtd: nand: raw: Kconfig: clean up SPL Cadence NAND=
 dependencies

On Wed, Mar 04, 2026 at 11:24:40AM +0800, dinesh.maniyam@altera.com<mailto:=
dinesh.maniyam@altera.com> wrote:

> From: Dinesh Maniyam <dinesh.maniyam@altera.com<mailto:dinesh.maniyam@alt=
era.com>>
>
> Fix and align Kconfig dependencies for Cadence NAND in SPL.
> Move SPL-specific selects to SPL_NAND_CADENCE and remove them from the
> non-SPL NAND_CADENCE option. This avoids incorrect symbol selection and
> keeps SPL Cadence NAND support self-contained.
>
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com<mailto:dinesh.ma=
niyam@altera.com>>

Reviewed-by: Tom Rini <trini@konsulko.com<mailto:trini@konsulko.com>>

--
Tom

This patch has been reviewed by Tom Rini.
When you have a chance, could you please take a look?
If there are no further concerns, I=92d appreciate your consideration for m=
erging.
Thanks for your time.

