Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE632FEFB4D
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 13:20:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88CC783EC9;
	Fri, 27 Feb 2026 14:19:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=at.abb.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=at.abb.com header.i=@at.abb.com header.b="IaOcjMw8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B091383D1A; Fri, 27 Feb 2026 11:38:39 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E92C83642
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 11:38:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=at.abb.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wolfgang.wallner@at.abb.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eh41VVwwO0XESyiD0g8Hz+NP2N6VVlVfA4iSzN2VCufjPyQf+pbqOCcyaJUY3+vzBQG2BFLlkwZeSZcy+4dYhwFG51grxuW7GpW22FOYFpE+Na0KvlIePKJKOEPgvF9WFQETy9LfvSKFsx2YsG/tMZGRaTEkzvG8pK6C1fe+d64f2GFDsqwS6y+62LmPFl4pl+pvhAe/77r/zgMbvf0r7f8SG+9J/t6nz84uPW4fjiHXLlZku2G9OlBlQuPOSLla00+9ZdLlbyTWKT4zGGL5MlquKZC0UDriiFG4Byxowq2VXazit7VVf/sMdxzptJh1JKJ235SpdBvms1b32rjHUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hiBb7E/ddaEZLXe/ljCbE8YEqR4B+QHYlKkxj3VHOJ4=;
 b=MS6jNV5g9eChT7gaHB088TTV6FTvC5fJsT/A/mJBTW/AN69MP9iZ/UiLk8gT37S0uEu94IwTpUGcVntu2M0l2wIhTY/H8s7NHakAlt+G6V4C4z5OU5n2jyEbDJya1BC+2dA8IeAsxd41RWrmiFiwQrBR9QxdKyjcMjTi10xTgESzKC4lgr6oFGIocZ/6kgLnIcIqSU+JLH3k8xyKqIveS8f4c/LbEa8vaFdFKDn/W4F9xA0w95b6XqHRkrj0mI3JbstEtYaKUEq4wzqpwnphFA15AWAKk3GkgUVMIS8RsjBZsNSaJtiy4e9142BRjYSs673pY/QLP46omOg6A7I5BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=at.abb.com; dmarc=pass action=none header.from=at.abb.com;
 dkim=pass header.d=at.abb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=at.abb.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hiBb7E/ddaEZLXe/ljCbE8YEqR4B+QHYlKkxj3VHOJ4=;
 b=IaOcjMw8pRutkOoC9KQXUcKPwVcAT07u+6OoTpz3n0m3hE8ia77Wb+EUeYeOe7P5X5r6PbabBzE2j/NWIJf5q+bOSZ2DNMyqTYw6hFlX2qd6REAFt+WudyJU4y0t+TFrhFphpOm5/jJn1VOh5Q3zOTiXIzMZSgc7gLTOxoP9gT3L66M1C4Tn6KTJEft130eZbM/va9wEIhlWmCrGxHJWZEqME0NkYYNONhRqobpiSN0s8yAmrsn5mY0159GJOuIgZOgzbpeWR3mSuBIr/2RGgd7PG/gdnYW670NimMjdUGbU+2t3CBrHuqe2hfW8CJXnxYE+nFWJ9dVDW1OEWJ27kA==
Received: from DB9PR06MB8512.eurprd06.prod.outlook.com (2603:10a6:10:36c::17)
 by AM9PR06MB7169.eurprd06.prod.outlook.com (2603:10a6:20b:2c2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.15; Fri, 27 Feb
 2026 10:38:34 +0000
Received: from DB9PR06MB8512.eurprd06.prod.outlook.com
 ([fe80::c595:643c:30dd:131d]) by DB9PR06MB8512.eurprd06.prod.outlook.com
 ([fe80::c595:643c:30dd:131d%7]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 10:38:34 +0000
From: Wolfgang Wallner <wolfgang.wallner@at.abb.com>
To: Quentin Schulz <quentin.schulz@cherry.de>, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>
CC: Tom Rini <trini@konsulko.com>, Bernhard Messerklinger
 <bernhard.messerklinger@at.abb.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Michal Simek <michal.simek@amd.com>
Subject: RE: [PATCH 1/1] board/BuR/zynq: don't select non-existent
 SPL_BINMAN_FDT
Thread-Topic: [PATCH 1/1] board/BuR/zynq: don't select non-existent
 SPL_BINMAN_FDT
Thread-Index: AQHcpiEFiqnSIGFc1ECF9pWg1xnpe7WU8ViAgAFpgqA=
Date: Fri, 27 Feb 2026 10:38:34 +0000
Message-ID: <DB9PR06MB8512053633B5A7EA47C3A040B373A@DB9PR06MB8512.eurprd06.prod.outlook.com>
References: <20260225063559.47481-1-heinrich.schuchardt@canonical.com>
 <a1a57943-efcd-456d-a6c5-cf3d1d87b385@cherry.de>
In-Reply-To: <a1a57943-efcd-456d-a6c5-cf3d1d87b385@cherry.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_ActionId=c9aea728-ddf1-46c2-8021-3a7d02f411a3;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_ContentBits=0;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Enabled=true;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Method=Standard;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Name=d792d246-d363-40e2-82bc-6f0655128b68;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_SetDate=2026-02-27T10:26:38Z;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_SiteId=372ee9e0-9ce0-4033-a64a-c07073a91ecd;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Tag=10, 3, 0, 1;
x-processedbytemplafy: true
x-templafyemailsigvstoversion: 9.22.0.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=at.abb.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR06MB8512:EE_|AM9PR06MB7169:EE_
x-ms-office365-filtering-correlation-id: b9213873-6a1f-42c0-8e1f-08de75ec5bd6
x-abb-o365-outbound: ABBOUTBOUND1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: 5/7rBGoO79MOQDEzJoagU3XUNokNXPg3wWmIXIMGPFnGYDdED2LMQ+U6SKMsyt5FS+4zaSeZA0KQhsfp3Kasqk/PZ/hDrb7P4FB0+vjp6IVsJm0O+43xOnzWyIm+629ORCV9C0rh4FJTKfkHrna/71+Ayg8o1eEfIRbs31o5AllyGYqxJ1zenNvERZpG3GW592111GZcOJ83iwvWfiBuD5Mytr69lwSlwvqeXXJ9GUFJXT4MM+l3TiED6gHwMBQla6wW02hOECfs6mo07OeaDaR67l1jg23GvPkym3XYjFcx3Os4XXJ8gCaM5xyc5lap8jPk8cEZ4s5+dmItRJ78xuzrCkEu8HztYQ4qzH4GOQ4P5stRP5a4IG08XI88cD7sBltFMiFHe+p1T+XbZzbDaqNkyVjoFf9+t1PfObrcO2dc8o4+rFmc802quHf9pvZUkAYs40F4pOlYf4nHY/40VfSWcymxYSs474wwMF4vfVsXXTZ0R0q/ubAm5Gwp9Xx9FB/dBSwUbzbaq+Yj7ot9HaQWAUFoBjJqLQ+mSy15cHcTF6bKVmbGqBT9zfsImwGirswt5Vy3+NAzVOcrTNL5zjR13l5ylyAW0+746Kcy57tc0HbZy7JlScuZ8aHHCSdQeL/pTX40E9fRJqzvMRsRtbp7PRMAh1A+jEKfe4tXQYNr0yvkAoR23HONaU00syx835s7kPmiJj8ullgTSa8bJTgNN/DjOTAZDTzdxbyajT8p4mQYvCmL7f4gweIjyIu1KzQjVSmm/CWf8hQsw6juedtBRFapGDorqgdZZcffWrU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR06MB8512.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n4p6qBJH4orsBeX2g/pK0rxPa2EAOD35cEkcipFwozLJKfkd04NqnJ1fCd4J?=
 =?us-ascii?Q?0vnLmqcaOlZLMmaycL0Yc7fwCBe/bPpXpVZhGhWZQkto9JY1J3PZCwo04MIG?=
 =?us-ascii?Q?5m5G8X10c8d7Xi2TVPCmil3tNXerwHir6L+1Rh4/LuJuctNuSoYlTNG4zbs2?=
 =?us-ascii?Q?/RPugYXkLCUJZ0iyaeZ8FFv5/QGTnTAfwz27KO/ybFYOGYUtZqxurbJu5HWI?=
 =?us-ascii?Q?jKqYgwR5wmotGyfNRSiLmda+4yHGTPB0M/o+qVldGA02VQxTOwUBeNTOJax3?=
 =?us-ascii?Q?HDOb6h2oLUjin5Z6y7tduVDz3by0HsACqVOfVYQN7WAMObGOWTVhX96Ekcd6?=
 =?us-ascii?Q?DPKgCOqDQO4NhXSiKK6le89VYYY0vUdc/93CdvP1Sa8d+AGWeLgMnJaNdpL5?=
 =?us-ascii?Q?NiOW+ytdDQBhy2NGYC4NEgvemCTR/nINpTR62zkDn8xAFTUQ4KjpFVTU4mis?=
 =?us-ascii?Q?AsFg2tRmx8Z+NBLopet2dNfEkh0a8B4LNc5kgXcsGlf3/V2TJ+UMMSRz2bnP?=
 =?us-ascii?Q?wj14RizMJlN1BlVfdiA4o87iC+daqW6FEJWedrK0fQXeaAH5uEbLCbUKxAS8?=
 =?us-ascii?Q?0X1z+3FgJs/eda31SBSv9ahsCTnXrGGT4B/G/bX5FJmpXtBmj75JBrvwty/N?=
 =?us-ascii?Q?jQxa+bOd+GaN3wZkfs1Z+tIjwzJrx4TLbZVMW7Or0cTB9ygUEwjkYGejYfQO?=
 =?us-ascii?Q?NIT8SepruKmE+87gplL26n6f/nNAWJzgiwewukqzu+Da2yGIzk63aAxvMcQk?=
 =?us-ascii?Q?i3za9Y4XsMdiNrci6HcN7oc2Be1T/PQhOAnYlJFir6V+hJi7HhrkcNTt8C7T?=
 =?us-ascii?Q?UmFUX13RoGkZ1YbKsbR3Nk8qUDbTG0vq3XBkN8GCjjakbSrNvIg8vX06B9eL?=
 =?us-ascii?Q?BTm+vteYiWYD8imuHw/8jTUxZ5eJm/Ajv8IbpmsRZDPaPoouRge8AJrB5Ux6?=
 =?us-ascii?Q?nSGZ5rmdVCxAOW0MYZk0a+dfvC3Vjk9fh0frKJKOCtLtAq+sCLoB8znJbEn2?=
 =?us-ascii?Q?opboMI4QiE3aVGjR/JzZ0gDnTfyLkskGNGuIiBPwvCax5j0qNALuhr1hmjTj?=
 =?us-ascii?Q?RdfrmgXkVyWyKPE+p1qKIqQQmdj8ecPSn1cas671/uVOBkS7juebG/6G+LMG?=
 =?us-ascii?Q?kN4zV4B9/3hXXb171RjAALBlhu6fhMoyptzwVP1sQPQ0Dph7hIJ5lPFjOeQY?=
 =?us-ascii?Q?vlP5+pyATnNmRRm+A4WwSvInVlml1yGoWC0GM1Ryk7fWOV//HXJjOk4glcmT?=
 =?us-ascii?Q?RClvs9MSRfWdIHe/P1Rwr2V7ySaORlG6XR8Jf1mRenzZAMfWH8wiJVGW/Sj8?=
 =?us-ascii?Q?Tx69ll2mV9bfIDBQPgfaTeAtI1D4cMYr7NW7TPWCWE7NV+BMUVPNBVev+A1c?=
 =?us-ascii?Q?pR9BTB0mnqP90U88FkhJJUo9lOBYGBYCBspDgs3pBWjQzVW2WrcFUi26KKad?=
 =?us-ascii?Q?vyGOye2yjn8VmSnXrUEQaVYyl1agb7FD9zwqweqAqYCetsQwhTOif31mlkpU?=
 =?us-ascii?Q?+jatj2oSviSncVroBLZBE81tjt31lVfSQqfGx+zu0sxvjjXjLyuNS5E757Tz?=
 =?us-ascii?Q?7oKOAeFYczj//Bt7/nQRbFgZHRcwDYwa3vnW1k2bl7dYTl3tX35camRJ4LKB?=
 =?us-ascii?Q?xXST3nWQfEbApXEgD86naVXiYaM1weq9AEdWqdQk0TSYSS7wrdaAHSZ1ut5V?=
 =?us-ascii?Q?vwy7IIsntQPH6BzEK/neQRzGHoxbj1LyvHmNOSRrOZL/vDLLN3sWevcUypWP?=
 =?us-ascii?Q?EXnjdGJm2w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: at.abb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR06MB8512.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9213873-6a1f-42c0-8e1f-08de75ec5bd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 10:38:34.6046 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 372ee9e0-9ce0-4033-a64a-c07073a91ecd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M0l/eUqtoSOCevvncXPNIQKtfa91ehBfAPP0I6DZj4JGsVIg2BUxiRDsfcGsTPRq1GhZudu+rotSAgQrKhUY3QVDU0hXoQc9/2H7NKut+m0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR06MB7169
X-Mailman-Approved-At: Fri, 27 Feb 2026 14:19:56 +0100
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

Hi all,

From: Quentin Schulz < quentin.schulz@cherry.de>=20
>=20
> Hi Heinrich,
>=20
> On 2/25/26 7:35 AM, Heinrich Schuchardt wrote:
> > Symbol CONFIG_SPL_BINMAN_FDT does not exist.
> > Don't select it.
> >
>=20
> Maybe they wanted BINMAN_FDT here, but for brcp150_defconfig it's already=
 enabled.

The intention is to allow initialization of FPGAs already in SPL on some of=
 our boards (bcp150).
The FPGA bitstream is located via the binman entries in the devicetree.
Doing the initialization of the FPGA already in SPL saves a little startup =
time as the initialization of IP cores in the FPGA can than happen in paral=
lel with the rest of the CPU boot.

> While there's
>=20
> obj-$(CONFIG_$(PHASE_)BINMAN_FDT) +=3D binman.o
>=20
> in lib/Makefile, it's guarded by ifndef CONFIG_XPL_BUILD, which means it'=
s the same as CONFIG_BINMAN_FDT above.
>=20
> Also, there's a CONFIG_IS_ENABLED(BINMAN_FDT) in common/board_r.c but my =
understanding is that this is for post-reloc, meaning U-Boot proper, so SPL=
_BINMAN_FDT won't do anything even if defined in Kconfig, so:
>=20
> Reviewed-by: Quentin Schulz <mailto:quentin.schulz@cherry.de>

Just by reviewing the code I think that both the patch by Heinrich as well =
as the explanation by Quentin make sense and this define was not necessary.
But I'm currently working from home without access to the required boards t=
o test the patch.
I will provide more detailed feedback next week.

Regards, Wolfgang
