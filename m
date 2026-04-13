Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B05E4EBFD28
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 09:43:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DFC183F75;
	Mon, 13 Apr 2026 11:43:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="VvECgaP2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AE36840D8; Mon, 13 Apr 2026 11:43:00 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56AA3839DF
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 11:42:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snBTtk2pze+dug3UC8zNzVVV8YM52zOqYiNopqG7KQx0BtXwGA2r4sCrqsWZcsXHTZu+kO7hfgDeM5rRAzpz6O4pVhIytstBCclzgnzQoAIzvQkAEIMpOymzrCoWIQHY3os0+EywoM2PzxOOW432uf0yrCWDNaZnj4+tQpxWdl518EZOCSmdej9JF6GT4ffVIeFFO7WIGgatqMpZi/NLB7ih8r3NYUN8eOBi8/u/Sqj33YKDADmMNcx/Hfi+I6JVJX4ThKcKH2j5FoWPRtFNVqK3c1xqaq2l8VV7X7FFo2yHmEQ5QygUGgA/Ld1cWkiyTSUeG6cwwcRMuArHeFQbFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4pH464l/2iOLrYNxN2RhjQJprG4j7bYBpU8nHxpOVBU=;
 b=KTMlsF894o4H1OSicVK/rEOGkH9gvEpKjh3OXiupjuAzBw7LFM0+zLTfxp3dOjADpyq3nm8edqOM4wXURh6ZV3iiY8SU9442JyESYzecckHpyxyCbrJDw7Pj05xprJnFdhFQHqda+Pv87yDUdhWeLYVp9kSIp0OKFLRTR2GpVEAZGRVAZLwQevY+jzkFeys779GRNVL21S0LGa7G3aTj4PDe7C+RRYJ/lHiAKpvlbUr1Kf2s+25RE6vNcE6wrD9VvaGaaLUg5rFVq9cPFh8YTQc/6s2nfi7hiHkCKajukdd+hpWHi1UjdDvcTr0xeRNX+o6Xfy2RDVz+KFG2tZSNmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pH464l/2iOLrYNxN2RhjQJprG4j7bYBpU8nHxpOVBU=;
 b=VvECgaP2TXbnvZCMFYHpsuNhkbJ33yy1Ny2ZDbl+jn9SPESsdBYT+3IKrTdcAtsB2nKFQRonPEGxiRJBhbGvfpPlG/DPkwaodT7TOSqrhLiyx+flVAHZymeFuSHPlxflwNwdI6U/xV9jsDmA/b10savZm9VSjYnK2yS1lc3KqfcnTDLTJSNEdkwBnRdpM3JzKJSBMmzZO1SG3H0fgCSWuEP4jo3zhucKytTw6Bw4KpFYiA8+gmZJGIH0+7zQSPheqqR0aubkR2pXb4ymzMHmqvucVj0fcdPScuDGbNuthlXi91Q+ONF7QZ3yJ9SvltjQFmW9wn2gIT/I3KMxeu3JAA==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SA3PR03MB7256.namprd03.prod.outlook.com (2603:10b6:806:300::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 09:42:53 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 09:42:53 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "NG, BOON KHAI" <boon.khai.ng@altera.com>, U-boot Openlist
 <u-boot@lists.denx.de>
CC: "YUSLAIMI, ALIF ZAKUAN" <alif.zakuan.yuslaimi@altera.com>, Marek Vasut
 <marex@denx.de>, Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tingting Meng <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>,
 "MANIYAM, DINESH" <dinesh.maniyam@altera.com>, "LOK, CHEN HUEI"
 <chen.huei.lok@altera.com>, "Hea, Kok Kiang" <kok.kiang.hea@altera.com>
Subject: Re: [PATCH v1 2/2] arch: arm: dts: socfpga: Update system manager
 core registers masking bits
Thread-Topic: [PATCH v1 2/2] arch: arm: dts: socfpga: Update system manager
 core registers masking bits
Thread-Index: AQHcpgXqqolUBiIRekycw9xFZ5Wrg7XdB4vA
Date: Mon, 13 Apr 2026 09:42:53 +0000
Message-ID: <LV8PR03MB81371969729FCFE3EC35A48DA7242@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20260225032149.1342-1-boon.khai.ng@altera.com>
 <20260225032149.1342-2-boon.khai.ng@altera.com>
In-Reply-To: <20260225032149.1342-2-boon.khai.ng@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|SA3PR03MB7256:EE_
x-ms-office365-filtering-correlation-id: 0840c789-8169-4068-6427-08de994108aa
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|55112099003|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: sNxJTR1xd2Xi+rAOfEQO+CynCW/ZJ5HT9Qr4nO7W3FATsHUu8ebdE4ILA01CQ6mXOJe2uDmlsHllzALQIxqAoCK69XrCFGl+3BydAsUmGmD51Yr/N00U7RJENZ+mxtLmcu3IZy1VgOkFj2uFGmi8H3+7LaAkUNrG+GS+wf6ac7IkCPl/35Xv3cUqMLiNnHWLUAi07eTlHZtQNorQRoi2bP4POdZj6xwCeWiA8rGBjogh+64XM0RsX3CtEih00vxWHlU5R4vFA7mZCSZIbInv5Upn8ViLp6EFYRCXx78XW6UWkdowx6rvBLBryIFSfGr46vJSvgaT/l9ezNtJslhE9DfP54ndgZXAW+JZmzKykJ5PCsTz2cpbQ1xloE8rPXSa9/MnuLFC45rfxVaoGJtOHp6jgBx9InbeSOXiWf5wQm2r+1THz77e8AHXP2Rc1eMEfSypWZ6Acrptds51MkHJ0GLrWJHJal/Har6QLdg7hotgqnHP4bdkwdY/3Vv4JpD4kEWSUgFpIqmBQB5Sg+mQ7UWdbEZI9Ni2nul+oTqEl12FtDukeSrBWj4M5JZQAwtDh8GXDonputTw3n0Z7pHVq+YdcNQO+atZ0W5nJNZpsuCWLHE0fsSl8M7zfZ5ILVEf7Q/Gd1/eKm0Zrt2bpkekUBQB5VoICVECXl+cpXpvOd/GjX4Rz8Agts9XDlCwM5MzkrFw27vlPi4gt7fOP7CvrV+GzWhJLoRptgiFAS+RhaiFNgnjzwV8qx4aWhLA1ye8bxdzlJNpLTTyYpLMCCt0XfYp+LCHWOTGI0IMb+pIGqw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(55112099003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?zmdKN4CYAWO83olJuYkUmRjgAB1S+6qyK6fD7cZSp9pJlmVsDOguo+QxYY?=
 =?iso-8859-1?Q?e2r5ZwLip6+bARizxw4pp3RQP5l1edRyw8OXVfrFrgbXDurbAIwUDvfIak?=
 =?iso-8859-1?Q?AMgcPVli6u5C57ClFBvv2GV52fz7gkI1OSEsQEU6sOAkNleGtwArtdFZdW?=
 =?iso-8859-1?Q?mVsbQ795vyvL17ZwbuUqbLgNv4Agt7NtfXykE62oazv0pX57NbBingyb19?=
 =?iso-8859-1?Q?ee4zMHOaDbHr1CMy50L7gPbaP8btLDINpt2WIFhMo2aG7ezsh0wk/AhgD4?=
 =?iso-8859-1?Q?jzDYIGT2QlkF5DtZg8wVMtGn+TRfCBtZKZUaaF4/OQK/ymNc7zQbqpUIcS?=
 =?iso-8859-1?Q?HCyVoGf+jlDfFoR7Ey8iFcG7NAbpEl4YaAoXW2WBIU57a1I7E+i4lumFhP?=
 =?iso-8859-1?Q?cWI1ceJGEXC7EpHbJUzWR7Z0I+eHxGPnu7wBTgdIu/5MU1LvQNv5F0IrW0?=
 =?iso-8859-1?Q?EH+il0rPanEUT9u2DfM2hCq9M0m0+5V3Hd3c4DXlWVoBAG7bvLiUBfON22?=
 =?iso-8859-1?Q?yhl07jQR6+i3K3s2abFmjl4PlyClZTyMHE3TpbbUT45REfDtbu/PW3wo+j?=
 =?iso-8859-1?Q?7JZV8VJoF8LypRDP+00ZGbX7MtMlm7WQNtJVGvFXCWRUXSVS2Kx33EZYrx?=
 =?iso-8859-1?Q?W1nlhLnajJfW7QOkSlYfLu1hmuixzozHR71Oavr0x5BkS2jz5vHNBEer+d?=
 =?iso-8859-1?Q?gTqbxFLIeMfH1eH3mmTnoZcTC5+hNVPUPNBEDtuK4s6YzoiGwtTpOM2rPU?=
 =?iso-8859-1?Q?S8BLXR/mM9Cj84zu8bH7v2d+E60ORMdf0kxK51KhlgST1V/TLyEsRE2Sc5?=
 =?iso-8859-1?Q?53Eu60ZpkKKxlsdeLxAva3jHfFjS+7+FmOHvcWZ8y9QSj1Xf04r5l29GzQ?=
 =?iso-8859-1?Q?07N63lx+6f2UJd4VzAkaP+7bIjmuTnqOuIafQtQkGsyFaG3FQ5fB33kVlD?=
 =?iso-8859-1?Q?48dpBbyimIBCR1f+3DsBAQdn+o1hBxGkkQsbBJn7MZqa1vw2gpfbRdam/A?=
 =?iso-8859-1?Q?WxHHxEZz2ilHL30KF7GRFH/7P77SLZIvghFuzDq/Ugb2URJYa8Lc1R3ymP?=
 =?iso-8859-1?Q?Bd1PpzQQ+cZ383d26D5EXjVyM3LUPhIZz51GUbH0Tn9dHAyg70YfG3tjYU?=
 =?iso-8859-1?Q?3s5Zv7GvvkpceXcZs/QoeIQ0GvUnxS6j2mJtlzYU6KzVLVZsT+s5ntJUUd?=
 =?iso-8859-1?Q?95Nm1pgAKHiZ9pfWqGSSVTe2KQnPEtwthQXq0eSCkPJAoelZMBM8Sbgspp?=
 =?iso-8859-1?Q?Z6+p5T9PPs+7feXO1rURROTXoKEWFCdTEpdNGYPacNRPQAgOMICxRwLaFQ?=
 =?iso-8859-1?Q?/cwDJu2s3i1G6rwtEpfmKbzMEuXmmvDgSBkpnjMgxa2NB+aggBOOb2IaFC?=
 =?iso-8859-1?Q?z5UY4sq85hkl9CwnGAgJy+IGnb8zwWH7ZFvwzwuThUJEjtYKjguehPGWn9?=
 =?iso-8859-1?Q?bXa+0LwyiK13kQqp0nPSlHhmIf4vaNy86/aOEewdSDUuwPCyWuKmb9lJny?=
 =?iso-8859-1?Q?m1aPt1sTMaNpwhwZdlXTeM+3R0H4VP4baQOlA+IOawtUAFzBfk65oENh13?=
 =?iso-8859-1?Q?RzjbV5F+xbVVwpGxJIkYGfMl4YBqKPZ3QT6/j5THeCPVnoPmsjmRC2/3ed?=
 =?iso-8859-1?Q?Dtef9z7MUQNbLjux2DphXVD3EymAaweZxyqVgfbv/sMRlewm1iZ23WUx9J?=
 =?iso-8859-1?Q?1E3ZNGFi9RZYQaqGsRRREKczIoLSaadRZXIDJKFV/IUWy7lRYajoXqa9vb?=
 =?iso-8859-1?Q?4/lcxPfWjYOqiaphdubcZol5FFTCOlQjtZUU1uNP4Hp1li9TlPJdSJiXcx?=
 =?iso-8859-1?Q?Umx3i/0fNg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0840c789-8169-4068-6427-08de994108aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 09:42:53.0383 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GKN8pmOIxYtOxBfVt0KUse2gXRJwgaKkw8VOvdhi6N5d6++BG7eSQZPSTdaj/U1soJ9Tya6YfcIJzJs9XT1gUSc7ydhbpceO7kRcL7Pv+JA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7256
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

> From:=A0Ng, Boon Khai <boon.khai.ng@altera.com>=0A=
> Sent:=A0Wednesday, February 25, 2026 11:21 AM=0A=
> To:=A0U-boot Openlist <u-boot@lists.denx.de>=0A=
> Cc:=A0Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>; Ng, Boon K=
hai=0A=
> <boon.khai.ng@altera.com>; Marek Vasut <marex@denx.de>; Simon Goldschmidt=
=0A=
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong=0A=
> <tien.fong.chee@altera.com>; Tingting Meng <tingting.meng@altera.com>; To=
m=0A=
> Rini <trini@konsulko.com>; Maniyam, Dinesh <dinesh.maniyam@altera.com>; L=
ok,=0A=
> Chen Huei <chen.huei.lok@altera.com>; Hea, Kok Kiang=0A=
> <kok.kiang.hea@altera.com>=0A=
> Subject:=A0[PATCH v1 2/2] arch: arm: dts: socfpga: Update system manager =
core=0A=
> registers masking bits=0A=
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>=0A=
> Using wide masks may modify unintended bits, which could break the system=
.=0A=
> Updating the mask values to only modify intended bits set by the value to=
=0A=
> fix this.=0A=
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>=0A=
> Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>=0A=
> ---=0A=
> =A0arch/arm/dts/socfpga_soc64_u-boot.dtsi | 14 +++++++-------=0A=
> =A01 file changed, 7 insertions(+), 7 deletions(-)=0A=
> diff --git a/arch/arm/dts/socfpga_soc64_u-boot.dtsi=0A=
> b/arch/arm/dts/socfpga_soc64_u-boot.dtsi=0A=
> index a6e0b615717..1506ff15447 100644=0A=
> --- a/arch/arm/dts/socfpga_soc64_u-boot.dtsi=0A=
> +++ b/arch/arm/dts/socfpga_soc64_u-boot.dtsi=0A=
> @@ -143,19 +143,19 @@=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D <0xffd12000 0x00000500>;=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 intel,offset-settings =3D=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* i_sys_mgr_core_emac0 */=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <0x00000044 0x0a000000 0xffff010=
3>,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <0x00000044 0x0a000000 0x0a00000=
0>,=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* i_sys_mgr_core_emac1 */=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <0x00000048 0x0a000000 0xffff010=
3>,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <0x00000048 0x0a000000 0x0a00000=
0>,=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* i_sys_mgr_core_emac2 */=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <0x0000004c 0x0a000000 0xffff010=
3>,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <0x0000004c 0x0a000000 0x0a00000=
0>,=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* i_sys_mgr_core_nand_l3m=
aster */=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <0x00000034 0x00220000 0x007733f=
f>,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <0x00000034 0x00220000 0x0022000=
0>,=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* i_sys_mgr_core_sdmmc_l3=
master */=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <0x0000002c 0x00000020 0x03ff03f=
f>,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <0x0000002c 0x00000020 0x0000002=
0>,=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* i_sys_mgr_core_usb0_l3m=
aster */=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <0x00000038 0x00000200 0x03ff30f=
f>,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <0x00000038 0x00000200 0x0000020=
0>,=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* i_sys_mgr_core_usb1_l3m=
aster */=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <0x0000003c 0x00000200 0x03ff30f=
f>;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <0x0000003c 0x00000200 0x0000020=
0>;=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 bootph-all;=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
};=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };=0A=
> --=0A=
> 2.43.7=0A=
=0A=
Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>=0A=
=0A=
Best regards,=0A=
Tien Fong=
