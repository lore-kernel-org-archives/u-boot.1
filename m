Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B574FF8867
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 03:22:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5193841DF;
	Tue, 28 Apr 2026 05:22:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="EX3QSCDy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FD8F8426C; Tue, 28 Apr 2026 05:22:52 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8017841DF
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 05:22:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CpwPJGkYRw96S5q2BeCGh2uKeIBE0hoUaYom5HI3a4NMH2QOVlhpLp02Q4uT9/Mdhg60Ps6HjONHdDy0S2mpCUxlA4rRIUNBAMOx1NY2x6lSAoHr25A5HApNC7dD8nPIh5TIhOcew2lDHW2KN87CUiS7IyIBGdqxEnkSq443TcuZiaRbgdbNi0ynqM1FWpl/wjg09gpN8hbGYDB/sod26R32k5zb7O3WQOh9e5ySlAWUauUaQ/OcEvHlZct3XRbLVUXNwd9tCCAhWb6uJL0IA6KNNXCfrDuzzEp4wQuk6wmBqjwRxi9Y0EIuF/OQbxSqgpZbXJl4sM7d2Op5Ckvd5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuXa4BP2O45gvnCIjJQgL6ckDMBlird7huKdtU6q1fU=;
 b=FzXiV2G6kCuIl3pbYmvNLDhJwwsnIAFDZ3gRwq/yX3ccNUz8KtAde9JUwMEwzP6iqCBlmFGUNapdaBZQjS+aEcxSwUpII6WWb7VsiTYasVswuARO/HafZK1bOsRpGMMSA1WDIiGNUvOa0l7QKOGgZqHbVjuj5tROe/xzWGjIqSMMxRlYcnCOmo9p5SmIbzql+lm5inSdf/k/7Nz+7uWE/9Rhb5clneuF8sfVxLzr1Thx5kUHWlhJt2s/I48hlDDDvvMJbYvyhxu6KK4H5st6QcdmJGjng2EPkLj2mvwklbe4H2Eln00G6cVqF5LIg4JCxw7ovRmnp9Oy0RhjeBuqMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuXa4BP2O45gvnCIjJQgL6ckDMBlird7huKdtU6q1fU=;
 b=EX3QSCDy9QlWM3+kwscFK6M8mBdTJu8mk0szW1IqUoVJZGIf9MEQUZmEbx84eNPWvocuyLEofasY89vEUYYPZ/ZmNhXGj6HD+wrWQAV0HOxTQz2skiBu9mKAb57SrqaY6Bqfob4yyjpBezMPVafeygJIME9jFSoC5aHMXP5SOWWtufQTSFuTHrodL4bgCuGJ1tdnuGQcJkgQnZSvgUgXlmU96cd3JYdkKrJ/yT78/vKX2CJ/8NeTOY6IKF29DZC3TyYmJH0S0UfW4rziDYcwjZgXIHHk/wCvB67A+svybADI3eC2xo19hX041PPfVSxh+4jSjuNfyAaVkN2f5FohJA==
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by BY5PR03MB5266.namprd03.prod.outlook.com (2603:10b6:a03:22d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 03:22:45 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9846.021; Tue, 28 Apr 2026
 03:22:45 +0000
From: "YUSLAIMI, ALIF ZAKUAN" <alif.zakuan.yuslaimi@altera.com>
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, Simon
 Goldschmidt <simon.k.r.goldschmidt@gmail.com>, Lukasz Majewski
 <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>
Subject: Re: [PATCH v1 1/9] arch: arm: dts: stratix10: Switch to using
 upstream Linux DT config
Thread-Topic: [PATCH v1 1/9] arch: arm: dts: stratix10: Switch to using
 upstream Linux DT config
Thread-Index: AQHcwxEtgZBZlXMdt0OMrlIwYxBwB7XpW5QAgALypYA=
Date: Tue, 28 Apr 2026 03:22:45 +0000
Message-ID: <f118b61557a145a9b1821021cb68788f361c300d-537c-4f29-ae33-ab75427ab5a5@altera.com>
References: <20260403022513.9446-1-alif.zakuan.yuslaimi@altera.com>
 <20260403022513.9446-2-alif.zakuan.yuslaimi@altera.com>
 <59456182-5ab3-4558-9586-c3333e7d5dfb@altera.com>
In-Reply-To: <59456182-5ab3-4558-9586-c3333e7d5dfb@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-clientproxiedby: SI2PR01CA0028.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::21) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-traffictypediagnostic: PH7PR03MB7063:EE_|BY5PR03MB5266:EE_
x-ms-office365-filtering-correlation-id: cf184e36-6c96-415f-de3e-08dea4d56a7b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|18002099003|22082099003|56012099003|55112099003;
x-microsoft-antispam-message-info: GfP58QieITQSFSDx6NggwqBnHcSVh24XJiJ3rPJZy7PPEpxGFiUygBGHKipyOMNJtK6Ci85xNuVw9nH6Yr2ghvLx9zFPBf52LNJitd9Ek/lD3ow/AkGc5IptrBwFtoFEUCRm/SrsguYRZYOylHZQxtGsr8dDmbeVF8VXUzTJlRUaFLxhonCvTiw6+PFnB4+4aLwADxQdNFt4UsJGhzL1usP9KcQjMizdqrlpL7FISBm5qcdMAZ9Mifeihr03e53l0lQBDlssMRt7WgrGRdkPBd3ZIDXb3QispFdcYt32sn3H6jywYsFNjdDUQRoMwBg4QV/D/rpdr2W8M0toMXFan+T8ZYr6OoIXVD+P7WPMcfePiRu3TGH11McegQyg0A0Camcup7ZupEk3QL+YmrhMdjRs+iCt35/WcachFhMXcR1Bcyarn+rHHhY7Yhcgty4t4qo6h+VT9gY64ZFSvuda4aRrb47gNQ+3W3nasRLZz4o5ScFymbhAef9wd55vUAB1rCuCjajm+OFiYuLXQOWPNj3Q8Umpy0OwupUkNyzCH2jO+7gIZvA5iliwZd5R08f9v85wAvxTOkuCDznVz7YEYMlb1KwARIl4Fa8ZBNqzzgSHqYaxgjvBo/8VQ1SCQefsR6dOklyT9t6OC4tDT/v04ohMUshM0Q+9R+oSaiz1qPFLWe4HK9do9vUuAey0YQbbau/Hgiww/m1+ksDXbN0iyIeL2dUfYtghSVIkrhsjgPE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099003)(55112099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pe8kVdKLZbv9heKfMaFC7nxWxwOLUpfQaLVYCbZKcwJcK0c+rCoKKzyu0j?=
 =?iso-8859-1?Q?V6+6E+sotzXOG9stu4wj2aTyBrPPxY5C1MlDWPhbUtZGifGfwlt0aYa5LK?=
 =?iso-8859-1?Q?EsW4HQBNVBC/uG+KKWx3Fbp2Wd5mfG/9oVgdN84saTWGrssDmeJy66iwSG?=
 =?iso-8859-1?Q?AsNOs772Q+Qhwb7HCySstRaRspE/KQLSrGLHW8DgLiujPvkrlPwQHP/USv?=
 =?iso-8859-1?Q?/KeGyZtaJH11KvVispqLGtEU66YhroDsee5iyZ9jyYBlcQ4u5Pcm2a9An5?=
 =?iso-8859-1?Q?0iZV51gImTcg6nOBTGijIqncGePX5Oc0hgGx3p2e5eMly4zQBYnJRlKcyu?=
 =?iso-8859-1?Q?AIHiSZMF2JuHdUz+dyPD7YI8KdBVnR2tRRILzo9BtuTU1AxR2yC/6A0tqO?=
 =?iso-8859-1?Q?2ifj9SZK2YvgPC62DKWdGoZwIL7+TWwTgJx3aKQ2I5cOAv3S+R/+w5M0sO?=
 =?iso-8859-1?Q?3KXr+PUBDnG5eK86f6W5U9VKT5KwMlqcerBEDEqnE5qYOb66FFaeE1h+Vs?=
 =?iso-8859-1?Q?AIZLDuJj+Dnft9bCZLTkBThzwWopSmQHWD7njxsVL9mcRHV31yUYDg4z8H?=
 =?iso-8859-1?Q?NuVdG54ISIfAsCSCp1+JhUkp3/BYbm+mQrTYLF3kgFYRqsYmREe6TOMrWr?=
 =?iso-8859-1?Q?3NLwCtB3S+yS9AA94T79NHVey8WScPWw3gAgPg/rPcO5ttqdxVxAc6ayWH?=
 =?iso-8859-1?Q?ogKue1AjP632pRX/UygbHTEPfHI8dqa12Ec3g/7OJbgWuZv3OF2nf/GHaZ?=
 =?iso-8859-1?Q?a790XcHOx2GBEHeeLPiXFPrvFXEMGxY2ALvt1mhTp9GgtIRq3pdhrPqwpd?=
 =?iso-8859-1?Q?FCkGd6y13q6di/lguWxbmSMeDnHIJ+FyaNKjlXNikiTbreFrDv2aIsY5uR?=
 =?iso-8859-1?Q?K8hTmiQYnXNRQYsDKnzIpPV7wJfZdHG5pqSO0tIoztZL7fAcNxm/pC/Tsd?=
 =?iso-8859-1?Q?oA7LljSR+gqwUBXwgQOhlgYVOnpd9tAcG7r1BPh6ICekWd5NNHJENXtJSU?=
 =?iso-8859-1?Q?T+t/UXakfVSwnUByBa08uQ9dYpCYQzTLUnJfMG/9kVeQkwjhOW5dqqhErc?=
 =?iso-8859-1?Q?h0csnfhoVoTpIoIHA6mv70y8A2wY92tk8XNeAb2dKBcvhgk8c+lrBjyUR6?=
 =?iso-8859-1?Q?RWyUDxVHYA2yz/vugfkCkq6vjtAjKryPMyCiTzAbzRYd4kTZaxrcD5M1EL?=
 =?iso-8859-1?Q?FyJyiH/0lSiOOKYo6KKGw0Q5Yq3WeC2O4avMgoZEfssSlLSUEbeImHPKKi?=
 =?iso-8859-1?Q?vQFrNdQ9AhlHr0VGoBdQBMUvw3BgE1dsaQLLLto4OXfNDermhsszHkYvxe?=
 =?iso-8859-1?Q?GlxvJkgYlzUmzzv96UihEFroHT7kGGFUOeDq+Yp+BmOEx7afDhVYP+Losp?=
 =?iso-8859-1?Q?ISX37iIzLHxFNoj5aZmEWANzG0Pd5E6cK5Zstn46f37CgX0NJbJamZqj7z?=
 =?iso-8859-1?Q?QlrTbVLZnJWhpeUTr3i+CwdsfEMaFWybi79C3BhgvnH1u5ETruw5vfKZjO?=
 =?iso-8859-1?Q?c05wmF8UEtN2TRCmT5yxwOZTjPDKFQrTJw66yILhsxn0/4wAEUBmBA+IW9?=
 =?iso-8859-1?Q?4IIaA8Pk8LNLY2phpbURBgxlV7Zoude27Uqs3T6ojSVI35Ch5Yz34jdaXF?=
 =?iso-8859-1?Q?KMxcml50Kr7+07jyj/POqZcbA1WE6a7czDPg9xNOtrLXyuHoFVILwiDJoX?=
 =?iso-8859-1?Q?sCGTJ0W2Tep0x56pxxqipK3Esd9Obxa8oOrFXnWrNRxcBcokack1TBWeNr?=
 =?iso-8859-1?Q?Gkz4sp6vtHfQy9rNcsvtWqsnhmUo/kz7XB80ucWLWnlhrxs+p4pdbtZgys?=
 =?iso-8859-1?Q?M3ITMvJvlNQth36vE1+frOUQInVnwcI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <CC58533AED6348489F120359F909B35A@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf184e36-6c96-415f-de3e-08dea4d56a7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 03:22:45.4227 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k6F008miBV6iQVrub2SX454dyZWFnVPo/DyTgLs2eXPArV40cfrM/mzfE8KcWPGW7mXZhobiSkA6pEQW4HN3nNJ5uv3kfzV3pKoI7kBDRK8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5266
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

Hi Tien Fong,=0A=
=0A=
On 21/4/2026 5:25 pm, Chee, Tien Fong wrote:=0A=
> Hi Alif,=0A=
> =0A=
> On 3/4/2026 10:25 am, alif.zakuan.yuslaimi@altera.com wrote:=0A=
>> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>=0A=
>>=0A=
>> Migrate the legacy Stratix10 platform to use the upstream Linux device =
=0A=
>> tree=0A=
>> configuration. This helps reduce maintenance overhead and aligns U-Boot=
=0A=
>> with the Linux kernel's DTS hierarchy and naming conventions.=0A=
>>=0A=
>> This change improves consistency between U-Boot and Linux by removing=0A=
>> custom/legacy DTS handling and instead relying on the standardized=0A=
>> definitions provided by the upstream Linux DTS.=0A=
>>=0A=
>> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>=0A=
>>=0A=
>> # Conflicts:=0A=
>> #=A0=A0=A0 configs/socfpga_stratix10_defconfig=0A=
>> ---=0A=
>> =A0 arch/arm/dts/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 3 +-=0A=
>> =A0 arch/arm/dts/socfpga_stratix10-u-boot.dtsi=A0=A0=A0 | 158 +++++++=0A=
>> =A0 arch/arm/dts/socfpga_stratix10.dtsi=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | =
430 ------------------=0A=
>> =A0 .../dts/socfpga_stratix10_socdk-u-boot.dtsi=A0=A0 | 149 +++++-=0A=
>> =A0 arch/arm/dts/socfpga_stratix10_socdk.dts=A0=A0=A0=A0=A0 | 143 ------=
=0A=
>> =A0 configs/socfpga_stratix10_defconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=
=A0=A0 3 +-=0A=
>> =A0 6 files changed, 292 insertions(+), 594 deletions(-)=0A=
>> =A0 delete mode 100644 arch/arm/dts/socfpga_stratix10.dtsi=0A=
>> =A0 delete mode 100644 arch/arm/dts/socfpga_stratix10_socdk.dts=0A=
>>=0A=
>> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile=0A=
>> index d90e02ca4e5..91da88481fa 100644=0A=
>> --- a/arch/arm/dts/Makefile=0A=
>> +++ b/arch/arm/dts/Makefile=0A=
>> @@ -460,8 +460,7 @@ dtb-$(CONFIG_ARCH_SOCFPGA) +=3D=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
>> =A0=A0=A0=A0=A0 socfpga_cyclone5_vining_fpga.dtb=A0=A0=A0=A0=A0=A0=A0 \=
=0A=
>> =A0=A0=A0=A0=A0 socfpga_cyclone5_ac501soc.dtb=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 \=0A=
>> =A0=A0=A0=A0=A0 socfpga_cyclone5_ac550soc.dtb=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 \=0A=
>> -=A0=A0=A0 socfpga_n5x_socdk.dtb=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 \=0A=
>> -=A0=A0=A0 socfpga_stratix10_socdk.dtb=0A=
>> +=A0=A0=A0 socfpga_n5x_socdk.dtb=0A=
>> =A0 dtb-$(CONFIG_TARGET_DRA7XX_EVM) +=3D dra72-evm.dtb dra7-evm.dtb=A0=
=A0=A0 \=0A=
>> =A0=A0=A0=A0=A0 dra72-evm-revc.dtb dra71-evm.dtb dra76-evm.dtb=0A=
>> diff --git a/arch/arm/dts/socfpga_stratix10-u-boot.dtsi b/arch/arm/ =0A=
>> dts/socfpga_stratix10-u-boot.dtsi=0A=
>> index 3e3a3780469..a3b4c0564f9 100644=0A=
>> --- a/arch/arm/dts/socfpga_stratix10-u-boot.dtsi=0A=
>> +++ b/arch/arm/dts/socfpga_stratix10-u-boot.dtsi=0A=
>> @@ -3,6 +3,164 @@=0A=
>> =A0=A0 * U-Boot additions=0A=
>> =A0=A0 *=0A=
>> =A0=A0 * Copyright (C) 2020 Intel Corporation <www.intel.com>=0A=
>> + * Copyright (C) 2026 Altera Corporation <www.altera.com>=0A=
>> =A0=A0 */=0A=
>> =A0 #include "socfpga_soc64_fit-u-boot.dtsi"=0A=
>> +=0A=
>> +/{=0A=
>> +=A0=A0=A0 aliases {=0A=
>> +=A0=A0=A0=A0=A0=A0=A0 spi0 =3D &qspi;=0A=
>> +=A0=A0=A0=A0=A0=A0=A0 i2c0 =3D &i2c1;=0A=
>> +=A0=A0=A0=A0=A0=A0=A0 freeze_br0 =3D &freeze_controller;=0A=
>> +=A0=A0=A0 };=0A=
>> +=0A=
> =0A=
> =0A=
> [...]=0A=
> =0A=
> =0A=
>> +&spi1 {=0A=
>> +=A0=A0=A0 compatible =3D "intel,stratix10-spi",=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "snps,dw-apb-ssi-4.00a", "snps,dw-=
apb-ssi";=0A=
>> +};=0A=
>> +=0A=
>> +&binman {=0A=
>> +=A0=A0=A0 /delete-node/ kernel;=0A=
> =0A=
> =0A=
>  =A0Duplicate /delete-node/ kernel in binman: both socfpga_stratix10-u- =
=0A=
> boot.dtsi and the board-level dtsi emit this node deletion.=0A=
> =0A=
> [...]=0A=
> =0A=
> =0A=
>>=0A=
>> +=A0=A0=A0 board-4 {=0A=
>> +=A0=A0=A0=A0=A0=A0=A0 description =3D "board_4";=0A=
>> +=A0=A0=A0=A0=A0=A0=A0 firmware =3D "atf";=0A=
>> +=A0=A0=A0=A0=A0=A0=A0 loadables =3D "uboot";=0A=
>> +=A0=A0=A0=A0=A0=A0=A0 fdt =3D "fdt-0";=0A=
>> +=A0=A0=A0=A0=A0=A0=A0 signature {=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 algo =3D "crc32";=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 key-name-hint =3D "dev";=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sign-images =3D "atf", "uboot", "fdt-=
0";=0A=
>> +=A0=A0=A0=A0=A0=A0=A0 };=0A=
>> +=A0=A0=A0 };=0A=
>> +};=0A=
>> +=0A=
>> +&binman {=0A=
>> +=A0=A0=A0 /delete-node/ kernel;=0A=
> =0A=
> =0A=
>  =A0Duplicate /delete-node/ kernel in binman: both socfpga_stratix10-u- =
=0A=
> boot.dtsi and the board-level dtsi emit this node deletion.=0A=
> =0A=
> =0A=
> Best regards,=0A=
> =0A=
> Tien Fong=0A=
> =0A=
Thanks for pointing these out, I will proceed with further clean up for =0A=
v2 submission.=0A=
=0A=
Alif=0A=
=0A=
