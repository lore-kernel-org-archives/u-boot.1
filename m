Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB899CEFC25
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 15:33:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3169388DCF;
	Tue,  8 Oct 2024 17:33:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="ai2gb7xP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18E6088E26; Tue,  8 Oct 2024 17:33:02 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EE1F88DCF
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 17:33:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RdiesxCjGRXNeNyHFYzHsPjzVY+TU7wUfb28M7d6IaZC/DCt0KgAN6vhuZwCE4xQAF9eJ/cH6mVv/xWpJ2guH/4RTtUSxg9QorWnoQiyOJlVvKPMnRcudnmMhcQUBpgA4mT75zdOE8H15YlHUNnUxWRCu52+tbSqiS740Lw54fsEYHm8mK34QQtaYtVxYcgJPjZPJwXpceDYrD2dC3WEiq27wxNCDBNMUxlIAaaRlWMN4QAFgzJIXtV90Wivqcj3BjQ5f+oUm/SWoBBDvwj5+YHhu2SXwdXQSFNJBvfpi4urjo4Aqi046MRMOvjajoiA37WsNSeW+kNrVcySE0ytgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BVnmXyL7IDTzQAAunOJ2+r3iG039y8iEa5DKrTSUBg=;
 b=XEGVUlA3ds0WHuhG8DedPpYuhjEgyGSYWe5OJofZLiMTSnQnrEjfNCCiKPCh0BeqFOtqnbuCq3Ja2IKBjmR1YaPF7NiJTFRjMNKJdcuCLmenhIo98kR4p9ew9/nmTR28/FyNPZFtY0NTpoS3Ofgw3Q6AYM+UejnuvliueDhvJHcsGyXXfuZRpcD6NuWLP9/TcKFCt+olZYumo5AQCrLlYfRaAIfMpwhvsd+3vT3Yq4/DmZklavWYQ3SUhnnCqQlYio7shsngoRThEyTgg2lDV/1iccq/fPyrXs2hUoYWc4bci+zalg8g8jC1ZSV9bZK2/9yJyqyVyEUtKjOtrfkWog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BVnmXyL7IDTzQAAunOJ2+r3iG039y8iEa5DKrTSUBg=;
 b=ai2gb7xPoTuuNgUQ08C+tPwBhuJY+CuzzIsftGk4EODQiJ+3GeyKnglBcZfCna3xnc8vq4SJw9kgU2duO9WkhKAaHh+5w0Ry4IE0CGW7hlSVRSu2iwBK0XqzPHKi3YBVCMU14XT2ZlPYqJyzemsUfZpUcx/uljHocDW098OyGJbrmnhz3GerUx1lkuOfF7ttEioh8rRF5UmRVkL+xyFrskXnKGhgpfIFsxNNn1hIybHEKs9PDrmJiaZhgRwwfOT+dN4J0rgxdNUExcovx+M+jdm/a+XVWoZu89GTrkk02Spfu/R/fc1hE3v8m8Zy6vdnWLCWtSD3h11XG8TipOhHrA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB8PR04MB6972.eurprd04.prod.outlook.com (2603:10a6:10:11c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 15:32:55 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 15:32:55 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Tom Rini <trini@konsulko.com>
CC: Marek Vasut <marex@denx.de>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "sbabic@denx.de"
 <sbabic@denx.de>, "festevam@gmail.com" <festevam@gmail.com>, dl-uboot-imx
 <uboot-imx@nxp.com>, "Ross, Fedor" <fedor.ross@ifm.com>, Ye Li
 <ye.li@nxp.com>, "seanga2@gmail.com" <seanga2@gmail.com>, Alice Guo
 <alice.guo@nxp.com>
Subject: RE: [PATCH v1] imx: Kconfig: make IMX8_ROMAPI configurable
Thread-Topic: [PATCH v1] imx: Kconfig: make IMX8_ROMAPI configurable
Thread-Index: AQHbF37kzuMw1Gz0EUuu/Vr5DDF+e7J6PP8AgAASNwCAAAYXAIAA2ENggAAquwCAATdiwIAAUOQAgAAepnA=
Date: Tue, 8 Oct 2024 15:32:55 +0000
Message-ID: <PAXPR04MB8459220EACE6B95C44B6E5AA887E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241005233116.2781053-1-alice.guo@oss.nxp.com>
 <20241006212332.GQ4737@bill-the-cat>
 <f2f2ff63-e186-4065-8e75-7e0064d16037@denx.de>
 <20241006225032.GS4737@bill-the-cat>
 <PAXPR04MB8459A51F5CCFC565F8E395FF887D2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20241007141730.GT4737@bill-the-cat>
 <PAXPR04MB8459AC6BFC8402C2607A5817887E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20241008134130.GB14210@bill-the-cat>
In-Reply-To: <20241008134130.GB14210@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DB8PR04MB6972:EE_
x-ms-office365-filtering-correlation-id: 16121596-ff5b-4687-677c-08dce7ae7b37
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?zdW0WSfa6t0XXbK5po2cjCjx/JmIpse1M/v+4n8dMglSq7HIc82Pu2hD+uqj?=
 =?us-ascii?Q?pydL1JcJ0dor5zP7aWq4rYELOueeTsuC9d+nPnVTvIlnF5zJcQL5kEDXX8ts?=
 =?us-ascii?Q?a0VSEPg2+2ogeEQiojJx1WIA2TJLtvhq2TGqHc+zIXvNptI2zGgMaBegA8ZT?=
 =?us-ascii?Q?iGlRUDira5m5MIo3eOFi5IfsLA66xbb+rWS1fhaCDtQpxFkxoHZE+j0kMsmT?=
 =?us-ascii?Q?eYjIGEHNo2J/04GRt3YESoPKuHksgNB4kfyRi3LXkxfTh1H9aLvLuZhEl3Ri?=
 =?us-ascii?Q?91/K73KctQq5NcdpRgVKUVPvD6NSCtSfXOvw52f59jRDKEkLnEd5lTosntel?=
 =?us-ascii?Q?W899r5SLS4LP1ImlnzQ+JCAkx9o09ck8Xm16dAzBvfyd+q755krqNMRalf74?=
 =?us-ascii?Q?JBmbwp1KubHeGw0rPASehtQcG7TUhHVZRNfyew1/w5o6epAKBhEkti2qdeEM?=
 =?us-ascii?Q?dZle7md2HFP3ZuzUlBlvtI8vLJOvVGVtPRViiHxBn859igKvn7o/OhQjYXv6?=
 =?us-ascii?Q?tsiLFU7uFndP0VkYHw/l/R9wKCBZvzSg+vfHJt+aagnuB8hOTgpwLuhUSwUD?=
 =?us-ascii?Q?FgUHcqKDiDoqOdRmrWUTqc2yWxi2cKmrvg/TQPsox0t0hF3YyjmZFjhIqUVi?=
 =?us-ascii?Q?VaXpeEABed7DZHglRxr6FZO8bRA63U0pcdQmHWuYlsSBlGKPPf4WrEjTxvwE?=
 =?us-ascii?Q?3nHDP7vLZMzSVUO41AlK5GZ7Yw3yvzQ0eBGAdklXffGyKvjIQKdn1ZcvJzsA?=
 =?us-ascii?Q?uZ9212gCsd/gNELLcNMU+XVKgWusx6s76M8ikX0tA1vaI/A7ceZ41B4Sf6rH?=
 =?us-ascii?Q?EA2A+2ZRDdBB6nhe0Af56zNK5w/t9Z2wyAu9+0elhoRpyjmGpvKUIIoCb+Mv?=
 =?us-ascii?Q?7PpyhLLhiKyEXh9u1+0qscRfDRn12Mgh16r1NPpU1A5N48QjMjdm6+9Rlf2B?=
 =?us-ascii?Q?r9gVnzDDAvsnoX/SqNg3kmr5sW9Y/ttcygFhJAJWs6UW1qEFoZlTrKeZLO/i?=
 =?us-ascii?Q?yuhVftO3Rop2JWQDM3bbajGX7VkPKiJKcw+QVJzVVUOcSnSHSVkkzaRYn8Y1?=
 =?us-ascii?Q?CUA0cGAtGVcjOh+ZiZJKTdwW9IijMY2JaHxECx/KSufl+3+x5ONavNO9Sfa2?=
 =?us-ascii?Q?vVjQOOKTB6pHvVctAwLBIz3yDwHp+1ci3d5ezlFqfdRKkQWQAKe0MRAruIQX?=
 =?us-ascii?Q?RqmwNbgLfCp7XTl1iJIYbls1Mvy+GmLm26cLtvPYtBe5iLSsRrsU+ZbbeLqs?=
 =?us-ascii?Q?yOEsiqdaiTv/yPZzFNFnkl8Y18qCe9vljmx4KqcJy1ASpcvgJUqOtoEvCFGx?=
 =?us-ascii?Q?Oj1Fxyw+NWCpDsijfgmcgyFwrO/HDExK6e6ys1G+4SBjkg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g98FUkDyAVnZv4JdKvNjNvbKAeFG7MYOd6QU+lG18escZqYcdF3Mf3Lwmxsf?=
 =?us-ascii?Q?giXQ0TwUdzgrh/5zu7gEV8zvJtQEC/ugzMjX5DHJbbDTNPCt22Fo2lM68z/1?=
 =?us-ascii?Q?TdOi6HHKmbxKoUwfS9aORFEyHpQbx3W2I5I6HC6mmpSxjx4lZL0Pw7iMVFBv?=
 =?us-ascii?Q?6hqjr5eQBu1nkKhiNiSLiwIYHRTVBNsFrisZNyFyPScFAoz/jpuMMwj+qX5w?=
 =?us-ascii?Q?73pGJigw6INyDVVOgWTpejkomgakWtbhOcX1BwdAhNQx48ssyazEvhECMH/8?=
 =?us-ascii?Q?z3glgOz9Wyfur48GqBRW4Wqu26DO/CFdr9x/+h76ahyyC8SmCljYf4fLL5G9?=
 =?us-ascii?Q?+heiBRkt8uC+QQq0Rc6U4U8UuIhwPBWuKnF3jqFbBGD/fIgWM5SFPpapHO+z?=
 =?us-ascii?Q?2zvyYAUWlnhnDpoK8wFtmCyC8Zs6E+zKBw6dv8t/748xqRGTO4AmEkHUq2fQ?=
 =?us-ascii?Q?ptC675dSaM52/LsDT1MetP5i2eBAl9xffI8frcLwd7i5uuxWEJ7bDClD07fm?=
 =?us-ascii?Q?z3TaBrsa9EXkU+ZPZsuU8r0ttazXEkVDT72C6gW4q3IiQ1oYhxLklxWvsk+y?=
 =?us-ascii?Q?0lzqu0TnvmUipc5fYUtOQS6qiJ2foJU3jppCeGRbYiJqh4yTdhEF74+ELmUC?=
 =?us-ascii?Q?IRwHzUJIkHF7nEHmXU5P5h3rvFGiyIUpLgctD8mrQsRfu7gGVEf813I+GWHu?=
 =?us-ascii?Q?B6VTkTuak8U45ojh4zHjDz7bPEMxYOSMzLZa62sXRj2ZfVXplLryKf7WrJnT?=
 =?us-ascii?Q?4Mhu9JyO6BXqtgx4f++VtqFsqVUXW0Kt4/2NM3cp0dMXkUVIS4JO8TyPCYR4?=
 =?us-ascii?Q?4YZvNGJ4AtQ358SX5r1QrtTc9PSjVLdjdM2rLdWbIucSn9PVhaY9uJCNfZH1?=
 =?us-ascii?Q?EIpT9H+kQ0Ckjr6MYaU8MoCXhgPmQKnTBrQN4vJdIzGRouDtVAngwxZcmBoB?=
 =?us-ascii?Q?7gvwYJGuk5tzqRzno8zi1yOoczpWJAULyGchfRu1Hh5pLtD0w8pToQp/+ZCh?=
 =?us-ascii?Q?yqSZ8xMJ0ZJtxtjqwrbIjwWsAJibnd/0BDdrNW/+kO35zKPdZEDaFOLdMqPf?=
 =?us-ascii?Q?DzCu6dj34iCao/HlMt+kdXhPPtHO1If9dsJPrnGrWLWvwKnpEs9COugeOOE5?=
 =?us-ascii?Q?G1elLAmSAXUEqpiwjwfqx9MmH1KgzyvNVgCMM3iCk49m4CzDXNXEYmESZXNP?=
 =?us-ascii?Q?wd2ocPZiIqRxvddBLZM3mymlF9lt7WFqMVCIJltle5Bd2D5rloA9nE7k2RvD?=
 =?us-ascii?Q?f4i3xP6rkkxgtnCPmhuv93el0lSULKDivvQOmHi1Spu3PvYukqcBnidRinA2?=
 =?us-ascii?Q?ybziWAuDJaFxRZAoP8DfKWlaUyuWjSBeGD2EHczVSBJ11bIkdpyczaf63c+y?=
 =?us-ascii?Q?f5MK0NIdkJQqXNO3ewU14WkUg+AibIalBwyKX2Kas+/F37hIoTxLTfqAPEj1?=
 =?us-ascii?Q?2ZMY2ylfWWVG/NCHugYemwvalO8JPCQd8iaTGx2ds3aemNcEy0O8MWqw/acg?=
 =?us-ascii?Q?ww5XriReCc2nljRLz23UfgAGC7qVzFmcCKqShozaViqVuH+58yuEYEoGjvsZ?=
 =?us-ascii?Q?HTAtMBGdMVBcUjgVr6k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16121596-ff5b-4687-677c-08dce7ae7b37
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 15:32:55.6779 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U+TInjHY+BiFtDaT5cjYQwVCLVgVRTze/EwaXSHyTT0r6jf6IS7tRfE2bL/1LoohNp2QBPlqWcC7O+/qGySRoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6972
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

> Subject: Re: [PATCH v1] imx: Kconfig: make IMX8_ROMAPI
> configurable
>=20
> On Tue, Oct 08, 2024 at 08:54:38AM +0000, Peng Fan wrote:
> > > Subject: Re: [PATCH v1] imx: Kconfig: make IMX8_ROMAPI
> configurable
> > >
> > > On Mon, Oct 07, 2024 at 11:46:03AM +0000, Peng Fan wrote:
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Tom Rini <trini@konsulko.com>
> > > > > Sent: Monday, October 7, 2024 6:51 AM
> > > > > To: Marek Vasut <marex@denx.de>
> > > > > Cc: Alice Guo (OSS) <alice.guo@oss.nxp.com>; u-
> > > boot@lists.denx.de;
> > > > > sbabic@denx.de; festevam@gmail.com; dl-uboot-imx <uboot-
> > > > > imx@nxp.com>; Peng Fan <peng.fan@nxp.com>; Ross, Fedor
> > > > > <fedor.ross@ifm.com>; Ye Li <ye.li@nxp.com>;
> > > seanga2@gmail.com;
> > > > > Alice Guo <alice.guo@nxp.com>
> > > > > Subject: Re: [PATCH v1] imx: Kconfig: make IMX8_ROMAPI
> > > configurable
> > > > >
> > > > > On Mon, Oct 07, 2024 at 12:28:44AM +0200, Marek Vasut
> wrote:
> > > > > > On 10/6/24 11:23 PM, Tom Rini wrote:
> > > > > > > On Sun, Oct 06, 2024 at 07:31:16AM +0800,
> > > > > alice.guo@oss.nxp.com wrote:
> > > > > > >
> > > > > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > > > > >
> > > > > > > > Make CONFIG_IMX8_ROMAPI could be configured in
> > > defconfig.
> > > > > > > >
> > > > > > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > > > > > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> > > > > > > > Reviewed-by: Ye Li <ye.li@nxp.com>
> > > > > > > > ---
> > > > > > > >   arch/arm/mach-imx/Kconfig | 3 ++-
> > > > > > > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > > > >
> > > > > > > > diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-
> > > > > imx/Kconfig
> > > > > > > > index 134e42028c..9d3aafd2f8 100644
> > > > > > > > --- a/arch/arm/mach-imx/Kconfig
> > > > > > > > +++ b/arch/arm/mach-imx/Kconfig
> > > > > > > > @@ -179,7 +179,8 @@ config
> DDRMC_VF610_CALIBRATION
> > > > > > > >   	  the ddrmc_cr_setting on relevant board file.
> > > > > > > >   config IMX8_ROMAPI
> > > > > > > > -	def_bool y
> > > > > > > > +	bool "Enable i.MX ROMAPI"
> > > > > > > > +	default y
> > > > > > > >   	depends on IMX8MN || IMX8MP || IMX8ULP ||
> > > IMX9
> > > > > > >
> > > > > > > Since there's no help here, is this truly configurable, or
> > > > > > > is this something that should be select'd based on the SoC
> > > > > > > and
> > > > > presumably
> > > > > > > some of the newer IMX9 parts cannot use this?
> > > > > > I can imagine the MX95 calls into this custom ELE firmware
> > > > > > stuff instead of ROMAPI ?
> > > > >
> > > > > Alright. Perhaps this should be depending on the above and
> > > > > !main-ELE- symbol instead.
> > > >
> > > > Nope. To i.MX93, ELE and ROMAPI are both valid. There is case
> that
> > > > ROMAPI needs to be false while ELE is still true.
> > >
> > > Alright, but where is the choice made? As in, can a normal i.MX93
> > > board use one or the other, or will it depend on specific SoCs in
> > > the family?
> > > And is disabling this option even valid on the i.MX8 families?
> >
> > Sorry, my last statement was wrong. This is only to disable ROMAPI
> for
> > i.MX95. Downstream only has below:
> > ./configs/imx95_19x19_evk_lvds_defconfig:222:CONFIG_IMX8_ROM
> API=3Dn
> > ./configs/imx95_19x19_verdin_android_trusty_defconfig:221:CONFI
> G_IMX8_
> > ROMAPI=3Dn
> > ./configs/imx95_15x15_evk_android_dual_defconfig:217:CONFIG_IM
> X8_ROMAP
> >
> I=3Dn ./configs/imx95_19x19_evk_defconfig:222:CONFIG_IMX8_ROMAPI
> =3Dn
> > ./configs/imx95_19x19_evk_android_uuu_defconfig:222:CONFIG_IM
> X8_ROMAPI
> > =3Dn
> > ./configs/imx95_19x19_verdin_fspi_defconfig:226:CONFIG_IMX8_RO
> MAPI=3Dn
> > ./configs/imx95_19x19_evk_android_dual_defconfig:222:CONFIG_IM
> X8_ROMAP
> >
> I=3Dn ./configs/imx95_15x15_evk_defconfig:217:CONFIG_IMX8_ROMAPI
> =3Dn
> > ./configs/imx95_15x15_evk_android_uuu_defconfig:217:CONFIG_IM
> X8_ROMAPI
> > =3Dn
> > ./configs/imx95_19x19_evk_android_trusty_secure_unlock_dual_def
> config:
> > 222:CONFIG_IMX8_ROMAPI=3Dn
> > ./configs/imx95_19x19_verdin_android_uuu_defconfig:221:CONFIG_
> IMX8_ROM
> > API=3Dn
> > ./configs/imx95_15x15_evk_lvds_defconfig:218:CONFIG_IMX8_ROM
> API=3Dn
> > ./configs/imx95_19x19_verdin_android_trusty_dual_defconfig:221:C
> ONFIG_
> > IMX8_ROMAPI=3Dn
> > ./configs/imx95_19x19_verdin_defconfig:221:CONFIG_IMX8_ROMAP
> I=3Dn
> > ./configs/imx95_15x15_evk_android_trusty_dual_defconfig:217:CON
> FIG_IMX
> > 8_ROMAPI=3Dn
> > ./configs/imx95_15x15_evk_android_defconfig:217:CONFIG_IMX8_R
> OMAPI=3Dn
> > ./configs/imx95_19x19_evk_android_rpmsg_defconfig:222:CONFIG_I
> MX8_ROMA
> > PI=3Dn
> > ./configs/imx95_19x19_evk_android_trusty_defconfig:222:CONFIG_I
> MX8_ROM
> > API=3Dn
> > ./configs/imx95_19x19_evk_fspi_defconfig:227:CONFIG_IMX8_ROM
> API=3Dn
> > ./configs/imx95_19x19_evk_android_defconfig:222:CONFIG_IMX8_R
> OMAPI=3Dn
> > ./configs/imx95_19x19_evk_android_trusty_dual_defconfig:222:CON
> FIG_IMX
> > 8_ROMAPI=3Dn
> > ./configs/imx95_19x19_verdin_android_defconfig:221:CONFIG_IMX8
> _ROMAPI=3D
> > n
>=20
> So it sounds like this is not something to be prompted for and must be
> selected / def_bool'd appropriately.

Yeah, change to the following should be fine as of now and put this
into the i.MX95 patchset.

config IMX8_ROMAPI
-       def_bool y
+       def_bool y if (!IMX95)

Thanks,
Peng.

>=20
> --
> Tom
