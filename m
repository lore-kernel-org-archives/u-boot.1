Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BCB3CD11DD
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 02:00:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D5E387FB6;
	Wed, 27 Mar 2024 03:00:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Mul/2+7c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 495EA87FB6; Wed, 27 Mar 2024 03:00:53 +0100 (CET)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on072b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::72b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2011D87E3D
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 03:00:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUBuPLIxyjpglRJFGvfJ/ZdnTNwp8OFQtHLmOnea/GZzgvIpH7AbnuGnPZs4DCkMlRSwMIZvcy4iEbiJAHZSMuwOpPrgzF18uvNFNJpE3iP61la4Js0ahXGRGsFvsoM/sITonnxWGYNfpPyl0NeWVH6qBc3U865Wlbj6KK7HdR73BAfEb6GqhdAMVPpA9+l9jX9ldlwx56kMYcjvdgTMgOxejFgG9ykekHCRhZ82qA6v7oauuuNfE1Db8CqgrYFzZXXEmdheQMbF6Br37Vzl6PWLdl68won9FBAi6XmYYR0aMHMPO+RTnb/8AzhLcKX5Q9BtCpBywKV+hEABQsov3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2am+C/JfGQWEzaKXDMSSrDuv9DmnCrz0RcO0B7oC2F0=;
 b=VenVkjNHEEtMPARcjjTT/UzhgUVMVuIE90Vex5GB+SHQI4J+ZG9EvJqTvqmZS+Okq7HOrpUcjvMSf3Z6QRM1UuxssjZNmYBAqdBgLgIAn4MWYDMPCFyeF4i63//5EOMAPB447h3C0rGAxUkMY1gVnpu2RGlQKyTLSJROw7xK2TUDlEUmK2IhzoTahdh41J//njf+RYAR0J3PmjYIF3kI4zl4W97JZsxrQANikNXFsU8Gvh9+tLMQ+tcSiSiDEvCc359imY3zIVc0o5A75ke3UEqwnGtfb+OXqYghgn6ha0/s9W9yeNFzSXZNCF8JVzJ4EV34BMmxV6K2G1dMxmue9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2am+C/JfGQWEzaKXDMSSrDuv9DmnCrz0RcO0B7oC2F0=;
 b=Mul/2+7cELbUcF9xvHzpse0OjQiEFixUSxga/6IX/jKsfmV35yjwjjU65DtsJH3Cks66Q0dp/VAdy35mUUzHbpG7SzH9EKLGnZ6oSEMtPtuq3EUNTN/kq45rl9IAX7sVEU/kWPdNyWPn36ozuIhOJTLvYeT/yvrFXYtBNx0CxXc=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8507.eurprd04.prod.outlook.com (2603:10a6:20b:432::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 02:00:49 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Wed, 27 Mar 2024
 02:00:49 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "Viguera, Javier" <Javier.Viguera@digi.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, dl-uboot-imx <uboot-imx@nxp.com>,
 "festevam@gmail.com" <festevam@gmail.com>, Ye Li <ye.li@nxp.com>
CC: "Viguera, Javier" <Javier.Viguera@digi.com>
Subject: RE: [PATCH] arm: imx: fix signature_block_hdr struct fields order
Thread-Topic: [PATCH] arm: imx: fix signature_block_hdr struct fields order
Thread-Index: AQHaf23FakT3OasH+ky0l4Y27Fvx+7FK1jgA
Date: Wed, 27 Mar 2024 02:00:49 +0000
Message-ID: <DU0PR04MB9417EC8FA6586F81D25DE46E88342@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240326110656.21110-1-javier.viguera@digi.com>
In-Reply-To: <20240326110656.21110-1-javier.viguera@digi.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM9PR04MB8507:EE_
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gp+aNnYiDFp6aSljxziT43OjRm1xQe2Ui1enC2YacwC+UvMair7lGhDzIN0TBbFiQ10JROPzA36WlcVZF/xquUCu4To/CrLMvIkhB39cbttLh/bBRG7/n/ICS0haTRluEx5m7kug20ukl/6xiIG/bz7aNj/mugic7C43Bwksbc7zJiDuBMOEX85ccArN+b6eOmgB+ClZPXpKg4Hma5El3MxV2zMu88O2rIE0Xy7soP+qCUFR8j42bDphcgkV1gEANNHIbDsji4pk7ZwEY3BYA8Z0181uLX7BuurMyvaqCsjBubCCperMstAUOGR417HSouccqsbUHORPGghPvrGNAjcIt0/bu0TsQMwIFCuPaLmbfqX7nlUcuVChslW7o/Bc4zgKQVB9+27kj6Sc/g6OcLnZSt6s0q5I/ADtIA6pOo+XP/9DyMy7l9TNJUDXVU+6abw2yneNhtkrQiWz/K91BHNSunXVvQDkjmdGR98TVzSJ/91OzE5v1nrhcSnmtluxWRPM5W27lm5edFXgFMctoeLtviQuZtFfslETQdjetf+1wYsmj4ime8rVbFfnHvcFlioyFV0VFw/lkNScIxmPRw4pScTVagfZt9kCOGAdXnCVks+yNziXlm2Czh5eoiQTxiHxEWlOyuIByts48hIFXT3YsQS8cOVt4s6X3VKv9ww=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iYG8HrphUT5UMy6EkyDC4PXKE8LuWIhVAnFfOdzh/y1omazoSp9H4UY8TpcV?=
 =?us-ascii?Q?ldkC+i+AQLXVkTbZZHURaLXy9lQKjuVO/MkagFY6DQY5dyD7Cu2+2A9BPQJo?=
 =?us-ascii?Q?SVGyxJbktAbPy/qV1FJHhSvJBbWfUjFlXBYjVU5pUGf5CcQQ2T0HHxxi4taN?=
 =?us-ascii?Q?pAfZKDwRHebvSeu6X0va/MzOGcNBcBX10qIacNQeadg+BrHc7R7ZRckK78ev?=
 =?us-ascii?Q?DUxjg9qxuPFMQ0kUOVR1/eBoTqRh9BH0nLrrgyszWJCWT5BKyRW6ro0w7Af6?=
 =?us-ascii?Q?95/MP2+cvOoyjyZsbTSnYhRm+Eq1Vgb5fnxcKCBoqtZfphlQ6pk1V+NCBXL2?=
 =?us-ascii?Q?CY8CvxrGImtSs7L0nUn8tCa9ZEH7oKnnd6NhyDZi13gib2Q6JPG8GtrNmaxv?=
 =?us-ascii?Q?P+PhaJFVooXsumzhIWgqvh8kuYRdGI4oJ5Hx1J11QqZB1iYWNQY6DEKPQZr1?=
 =?us-ascii?Q?D4HtQhoNamn+cFZqrlK54jJycyDd7kRXbjZvwSsq8DwrMux1R08vUjpet2fN?=
 =?us-ascii?Q?eYc4Z/5Cd8s6PzG60iMaTUjaEj31JWUQhCxfuCHUSeJwiUdCrN0vsfYRe4KK?=
 =?us-ascii?Q?X7nSttQMeniWDoaTqhxTCEmoawz/8piS01dAL6gHNQh1eg8geUdyXEhv2pDF?=
 =?us-ascii?Q?/QtxsTRd+24QaL1zKdD8jmendVS7mR1EwL6hx43m63QdV58MQmbT87opYfdQ?=
 =?us-ascii?Q?2UYo2oniWIOR+8o0xrlVWkFc1W9ShSQ2bdtwJhEH/9OUKODOTPUMm3JNdFLO?=
 =?us-ascii?Q?ZayPC/OYTIQLoF3FdTpWySGJOvMzJpxBTB78AH0WqfCJkj4e/bDHVN+guDyz?=
 =?us-ascii?Q?vAba+PDxTkEGP6+cENkpW7nuYxPTcnPWtli1f+xxb5grWrXkzTyItCwXU/uc?=
 =?us-ascii?Q?9CJAhmzCfiH5eeGpLHaLJrnRR3S5U/iTkZOPVCKfqMsvYOsjcOX7LfEdmQfu?=
 =?us-ascii?Q?eYB0juc3DPZYIyNveU6KQW3mEo+08XSgy/cPEraoSafEXcVPDAfRhGmn4zSx?=
 =?us-ascii?Q?31x8v1kR+uvgZgY+3zJISS4V6mWH/kksK7myz5h2ih0kSEpm5ZsGxiGZPd1/?=
 =?us-ascii?Q?zxjtbn5081zRYelKWfELKW9IfZ4ihdIBG+hW1Mbo+G6inrFWe44RdusWJyhT?=
 =?us-ascii?Q?a+91nozMtrNTee+/tZrgwRnZHH8BRcj7WeRNAoUMgDMnRXU74ZoVd2xNtBrI?=
 =?us-ascii?Q?ppsAg5I8aanObvWqtUyGZKXp26Y0L4fdQUO2dg2ZAarwzyK3KmvaUlMB40uj?=
 =?us-ascii?Q?Nony1I/eDsKRMtedbIkWm/vbTBR6wIfBMNU+cilveLc0F/Y31W3EZg4b7fKM?=
 =?us-ascii?Q?jcIIFdgCxlEujrXiythBWvs8N0n5X8hCkAj/tKE4Kr3OcknXGzeiGAr931iQ?=
 =?us-ascii?Q?GypG0NeLJfr8WVH0u18kDVljH1MUA21xl/ICs3x3U9+PPbQRAmY9psRt03Sz?=
 =?us-ascii?Q?eKhLqrkpaJCut71GlwT4XE5g1Wrvnqo1hDDnOhYfxoApFWPp+w3o1YzMOe4l?=
 =?us-ascii?Q?vGyT8ySEh6e6O3a85dp7EqnTSf7SkHw0KvNSxk6u3Z6db8reZ5KaKDGkose+?=
 =?us-ascii?Q?/PkxzKAdfailKGDMs7k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 874d5915-33ad-40e1-a325-08dc4e01b952
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 02:00:49.0380 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: abvIVzU1TZK7hFBpXTVcigl4H2Qk/XbsWoCPo1QYcck/KL4KCC76+HHC+p+vytvtzkIyc8TzSPh2T73vX72ndA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8507
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

+Ye
> Subject: [PATCH] arm: imx: fix signature_block_hdr struct fields order
>=20
> According to the documentation (for example AN13994), for AHAB-enabled
> devices the format of the signature block is:
>=20
>   +--------------+--------------+--------------+-------------+
>   | Tag          | Length - msb | Length - lsb | Version     |
>   +--------------+--------------+--------------+-------------+
>   | SRK Table offset            | Certificate offset         |
>   +-----------------------------+----------------------------+
>   | Blob offset                 | Signature offset           |
>   +-----------------------------+----------------------------+
>=20
> Signed-off-by: Javier Viguera <javier.viguera@digi.com>
> ---
>  include/imx_container.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/imx_container.h b/include/imx_container.h index
> 54cd684e35d5..691c764b3e5b 100644
> --- a/include/imx_container.h
> +++ b/include/imx_container.h
> @@ -50,10 +50,10 @@ struct signature_block_hdr {
>  	u8 length_lsb;
>  	u8 length_msb;
>  	u8 tag;
> -	u16 srk_table_offset;
>  	u16 cert_offset;
> -	u16 blob_offset;
> +	u16 srk_table_offset;
>  	u16 signature_offset;
> +	u16 blob_offset;
>  	u32 reserved;
>  } __packed;
>=20
