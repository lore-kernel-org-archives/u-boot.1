Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5519CC4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 06:43:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4053879D3;
	Tue, 31 Oct 2023 07:43:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="qJdmIX57";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 497BE87A1D; Tue, 31 Oct 2023 07:43:07 +0100 (CET)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0483186F92
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 07:43:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20231031064259epoutp01f0c7c2586accace3f56d786525cb3f02~THhmKt0Os2570425704epoutp01P
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 06:42:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20231031064259epoutp01f0c7c2586accace3f56d786525cb3f02~THhmKt0Os2570425704epoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698734579;
 bh=i9ndbnLUdeNtHod3MR/uxONNFq1nHD7uKZ0zQX8iYlw=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=qJdmIX57OjLngFCA6rmAKCpPqQgkbECxOIgus+Gtdam9eHYv8aSXZ6YNp+nKvuHYn
 xERJ9t5NB6rySQiPM+RJnl23GkgfmM1/39D7IKPfaG0g9RMFkIVpKUl1eAJYdGo/8A
 6NFb+8+MfSuT6vsxtgsXRFknnNJbZgmJ7e5Rsim4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20231031064256epcas1p36f8ed2fad1287547dedb320c37a9f77b~THhj1v3DF0960609606epcas1p3I;
 Tue, 31 Oct 2023 06:42:56 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.231]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4SKLDb28XDz4x9Pr; Tue, 31 Oct
 2023 06:42:55 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 2A.25.09739.FE1A0456; Tue, 31 Oct 2023 15:42:55 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
 20231031064254epcas1p38ab8b48b9f2a78e97ef09afb8b913dfc~THhh4nOgA0980609806epcas1p39;
 Tue, 31 Oct 2023 06:42:54 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20231031064254epsmtrp1f997ca575e709512dd5f5a2be5ffc1ca~THhh323Dl1582015820epsmtrp1K;
 Tue, 31 Oct 2023 06:42:54 +0000 (GMT)
X-AuditID: b6c32a37-c0bff7000000260b-cf-6540a1ef3439
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 BD.90.08817.EE1A0456; Tue, 31 Oct 2023 15:42:54 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20231031064254epsmtip22d241de3b44b441e15c7e389f593b7eb~THhhnEByG1825218252epsmtip2L;
 Tue, 31 Oct 2023 06:42:54 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Andre Przywara'" <andre.przywara@arm.com>,
 =?utf-8?Q?'Jernej_=C5=A0krabec'?= <jernej.skrabec@gmail.com>
Cc: "'Jagan Teki'" <jagan@amarulasolutions.com>, "'Samuel Holland'"
 <samuel@sholland.org>, "'SASANO	Takayoshi'" <uaa@mx5.nisiq.net>, "'Mikhail
 Kalashnikov'" <iuncuim@gmail.com>, "'Piotr Oniszczuk'"
 <piotr.oniszczuk@gmail.com>, <u-boot@lists.denx.de>,
 <linux-sunxi@lists.linux.dev>
In-Reply-To: <20231021221911.16a6a145@slackpad.lan>
Subject: RE: [PATCH 1/3] sunxi: board: simplify early PMIC setup conditions
Date: Tue, 31 Oct 2023 15:42:54 +0900
Message-ID: <004e01da0bc5$7a210c60$6e632520$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQICxhFctULs6tp52ii3zw4GQnpLbQIv9iDYAYRZowICsinPVQKiUJM2r8m3kjA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLJsWRmVeSWpSXmKPExsWy7bCmvu77hQ6pBvdu81msmPeT0eJC+2QW
 iy+bJrBZPJ+/jtFiyr5dbBZzfl9gtnj+qJPN4u3eTnaLdVNesTtweqz9eJ/VY828NYweO2fd
 Zfc4e2cHo8eLzTMZPZbdFvF49XUuYwB7VLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGu
 oaWFuZJCXmJuqq2Si0+ArltmDtBpSgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwC
 0wK94sTc4tK8dL281BIrQwMDI1OgwoTsjOdzFrEWNHpWXJu8hrGB8adbFyMnh4SAicSzh2uZ
 uxi5OIQEdjBKfHk4mQ3C+cQosbzvHpTzjVFi//6tTF2MHGAtt3fFQsT3MkrsPbOEFcJ5ySix
 reMoK8hcNgE9if+LFjKD2CIC+RKv/rxhByliFljAJLF52SOwIk4BY4nbD66ygdjCAt4SD869
 AGtgEVCV6LxxjAXE5hWwlDjUc58RwhaUODnzCVicWUBbYtnC18wQTyhI/Hy6jBVimZ/E8t7f
 bBA1IhKzO9ugarZwSKx/5QVhu0jMPT2bEcIWlnh1fAs7hC0l8bK/DexQCYFmRomlSw6yQjg9
 jBL/Gq6zQVQZS+xfOhkcFswCmhLrd+lDhBUldv6eywixmE/i3dceVkhw8Up0tAlBlKhIXHr9
 kglm190n/1knMCrNQvLaLCSvzULywiyEZQsYWVYxiqUWFOempxYbFhjDozs5P3cTIzjdapnv
 YJz29oPeIUYmDsZDjBIczEoivIdNHVKFeFMSK6tSi/Lji0pzUosPMZoCA3sis5Rocj4w4eeV
 xBuaWBqYmBkZm1gYmhkqifPeetabIiSQnliSmp2aWpBaBNPHxMEp1cBkvSXulY97nOE6LfGP
 0i8O+nXrvOUpOeH3T6TZ/GJSyG6O+ezTt3OZ/fDat36CjmDR+2NzBOPsRSKXLWS+9PJLxEaZ
 Pzs88mavzdPMyHlrFX/cLEj7QcWclzdfr/q8eDXbOZbt6b+XP5yu+PnZHS3bi38Cp3pvcpte
 Znc1JDTzbNqm4Msnkm4bdnzaHsF0pbinhO+k/2bxegHTykcyd1+frDz88UW7xK0PJs6CXr1L
 Z7/NPbtv54+5D393d76wCVP4uFrWMeXKRqVXvEUnqx9I7LPLahC4Hbr3WsQqo/SGt6etZ/3+
 HGHrYO3+5I7F0f3RF28YLbvLZxjfWbJ5PXsIb8DFDUfuTE/cPf3lowaxU0osxRmJhlrMRcWJ
 ALrb8FlABAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsWy7bCSvO67hQ6pBm1fdC1WzPvJaHGhfTKL
 xZdNE9gsns9fx2gxZd8uNos5vy8wWzx/1Mlm8XZvJ7vFuimv2B04PdZ+vM/qsWbeGkaPnbPu
 snucvbOD0ePF5pmMHstui3i8+jqXMYA9issmJTUnsyy1SN8ugStjyuLVzAVHjCoaJ01gaWDs
 1Oxi5OCQEDCRuL0rtouRi0NIYDejxPKzT5m7GDmB4lISn59OZYOoEZY4fLgYJCwk8JxRYuZE
 dxCbTUBP4v+ihWDlIgL5Eq/+vGEHsZkFljBJ7JvtDTGzlUniy+VFYAlOAWOJ2w+usoHYwgLe
 Eg/OvQBrZhFQlei8cYwFxOYVsJQ41HOfEcIWlDg58wkLxFBtiac3n8LZyxa+hrpTQeLn02Ws
 EEf4SSzv/c0GUSMiMbuzjXkCo/AsJKNmIRk1C8moWUhaFjCyrGKUTC0ozk3PLTYsMMpLLdcr
 TswtLs1L10vOz93ECI45La0djHtWfdA7xMjEwXiIUYKDWUmE97CpQ6oQb0piZVVqUX58UWlO
 avEhRmkOFiVx3m+ve1OEBNITS1KzU1MLUotgskwcnFINTFZPFjGnzEl9OnEt98b0L4+eLXq5
 ulL5+i2pW1KXpqyQzunTuDk50Puq5IG4EHtN368fG2N+zxD7t1bR1HOWWcMujzXLVnsy9XNv
 VOr8+Mlf4sRc1WnSXmFSDq1rsv83Xr1mK2+79Eql1ZM9Ez/fWH1VYZOURLuhmsKUZ8qmIYtv
 rWI6v0k6ePEvvf37t+/J3HzqVeA2tam7vErrHr1YEqC14PK8VdONAhzDfdTD7wtUK+ntDJbe
 Ya0kd8mori5zUu6eB9+2vOVksdhyLXdb2OR5d0wLr8QdtmSPSPOuPrsokemJrbbFtBeV/ge2
 bck75PFrywybrWtTF36KOL5ORfLC3vZZBUcm72q+85il+4ivEktxRqKhFnNRcSIAFWkpACgD
 AAA=
X-CMS-MailID: 20231031064254epcas1p38ab8b48b9f2a78e97ef09afb8b913dfc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231021212022epcas1p1f34ed4f9c235d0e8aaace738f009feaf
References: <20231018155014.383566-1-andre.przywara@arm.com>
 <20231018155014.383566-2-andre.przywara@arm.com>
 <1965267.usQuhbGJ8B@archlinux>
 <CGME20231021212022epcas1p1f34ed4f9c235d0e8aaace738f009feaf@epcas1p1.samsung.com>
 <20231021221911.16a6a145@slackpad.lan>
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

Hi,

> -----Original Message-----
> From: Andre Przywara <andre.przywara=40arm.com>
> Sent: Sunday, October 22, 2023 6:19 AM
> To: Jernej =C5=A0krabec=20<jernej.skrabec=40gmail.com>=0D=0A>=20Cc:=20Jag=
an=20Teki=20<jagan=40amarulasolutions.com>;=20Jaehoon=20Chung=20<jh80.chung=
=40samsung.com>;=20Samuel=20Holland=0D=0A>=20<samuel=40sholland.org>;=20SAS=
ANO=20Takayoshi=20<uaa=40mx5.nisiq.net>;=20Mikhail=20Kalashnikov=20<iuncuim=
=40gmail.com>;=0D=0A>=20Piotr=20Oniszczuk=20<piotr.oniszczuk=40gmail.com>;=
=20u-boot=40lists.denx.de;=20linux-sunxi=40lists.linux.dev=0D=0A>=20Subject=
:=20Re:=20=5BPATCH=201/3=5D=20sunxi:=20board:=20simplify=20early=20PMIC=20s=
etup=20conditions=0D=0A>=20=0D=0A>=20On=20Sat,=2021=20Oct=202023=2008:34:06=
=20+0200=0D=0A>=20Jernej=20=C5=A0krabec=20<jernej.skrabec=40gmail.com>=20wr=
ote:=0D=0A>=20=0D=0A>=20>=20On=20Wednesday,=20October=2018,=202023=205:50:1=
2=20PM=20CEST=20Andre=20Przywara=20wrote:=0D=0A>=20>=20>=20So=20far=20we=20=
have=20a=20convoluted=20=23ifdef=20mesh=20that=20guards=20the=20early=20AXP=
=20PMIC=0D=0A>=20>=20>=20setup=20in=20board.c.=20That=20combination=20of=20=
&&,=20=7C=7C=20and=20negations=20is=20very=20hard=0D=0A>=20>=20>=20to=20rea=
d,=20maintain=20and=20especially=20to=20extend.=0D=0A>=20>=20>=0D=0A>=20>=
=20>=20Fortunately=20we=20have=20those=20same=20conditions=20already=20mode=
lled=20in=20the=0D=0A>=20>=20>=20Kconfig=20file,=20so=20they=20are=20actual=
ly=20redundant.=20On=20top=20of=20that=20the=20real=0D=0A>=20>=20>=20reason=
=20we=20have=20those=20preprocessor=20guards=20in=20the=20first=20place=20i=
s=20about=20the=0D=0A>=20>=20>=20symbols=20that=20are=20*conditionally*=20d=
efined:=20without=20=23ifdefs=20the=20build=0D=0A>=20>=20>=20would=20break=
=20because=20of=20them=20being=20undefined=20for=20many=20boards.=0D=0A>=20=
>=20>=0D=0A>=20>=20>=20To=20simplify=20this,=20just=20change=20the=20guards=
=20to=20actually=20look=20at=20the=20symbols=0D=0A>=20>=20>=20needed,=20so=
=20CONFIG_AXP_xxx_VOLT=20instead=20of=20CONFIG_AXPyyy_POWER.=0D=0A>=20>=20>=
=20This=20drastically=20improves=20the=20readability=20of=20this=20code,=20=
and=20makes=20adding=0D=0A>=20>=20>=20PMIC=20support=20a=20pure=20Kconfig=
=20matter.=0D=0A>=20>=20>=0D=0A>=20>=20>=20Signed-off-by:=20Andre=20Przywar=
a=20<andre.przywara=40arm.com>=0D=0A>=20>=20>=20---=0D=0A>=20>=20>=20=20boa=
rd/sunxi/board.c=20=20=20=7C=2032=20++++++++++++++------------------=0D=0A>=
=20>=20>=20=20drivers/power/Kconfig=20=7C=20=202=20+-=0D=0A>=20>=20>=20=202=
=20files=20changed,=2015=20insertions(+),=2019=20deletions(-)=0D=0A>=20>=20=
>=0D=0A>=20>=20>=20diff=20--git=20a/board/sunxi/board.c=20b/board/sunxi/boa=
rd.c=0D=0A>=20>=20>=20index=20ebaa9431984..65d79a02c25=20100644=0D=0A>=20>=
=20>=20---=20a/board/sunxi/board.c=0D=0A>=20>=20>=20+++=20b/board/sunxi/boa=
rd.c=0D=0A>=20>=20>=20=40=40=20-597,50=20+597,46=20=40=40=20void=20sunxi_bo=
ard_init(void)=0D=0A>=20>=20>=20=20=09=09=7D=0D=0A>=20>=20>=20=20=09=7D=0D=
=0A>=20>=20>=0D=0A>=20>=20>=20-=23if=20defined=20CONFIG_AXP221_POWER=20=7C=
=7C=20defined=20CONFIG_AXP809_POWER=20=7C=7C=20=5C=0D=0A>=20>=20>=20-=09def=
ined=20CONFIG_AXP818_POWER=0D=0A>=20>=20>=20+=23ifdef=20CONFIG_AXP_DCDC1_VO=
LT=0D=0A>=20>=20>=20=20=09power_failed=20=7C=3D=20axp_set_dcdc1(CONFIG_AXP_=
DCDC1_VOLT);=0D=0A>=20>=20>=20+=09power_failed=20=7C=3D=20axp_set_dcdc5(CON=
FIG_AXP_DCDC5_VOLT);=0D=0A>=20>=20>=20=20=23endif=0D=0A>=20>=20>=20-=23if=
=20=21defined(CONFIG_AXP305_POWER)=0D=0A>=20>=20>=20+=23ifdef=20CONFIG_AXP_=
DCDC2_VOLT=0D=0A>=20>=20>=20=20=09power_failed=20=7C=3D=20axp_set_dcdc2(CON=
FIG_AXP_DCDC2_VOLT);=0D=0A>=20>=20>=20=20=09power_failed=20=7C=3D=20axp_set=
_dcdc3(CONFIG_AXP_DCDC3_VOLT);=0D=0A>=20>=20>=20=20=23endif=0D=0A>=20>=20>=
=20-=23if=20=21defined(CONFIG_AXP209_POWER)=20&&=20=21defined(CONFIG_AXP818=
_POWER)=0D=0A>=20>=20>=20+=23ifdef=20CONFIG_AXP_DCDC4_VOLT=0D=0A>=20>=20>=
=20=20=09power_failed=20=7C=3D=20axp_set_dcdc4(CONFIG_AXP_DCDC4_VOLT);=0D=
=0A>=20>=20>=20=20=23endif=0D=0A>=20>=20>=20-=23if=20defined=20CONFIG_AXP22=
1_POWER=20=7C=7C=20defined=20CONFIG_AXP809_POWER=20=7C=7C=20=5C=0D=0A>=20>=
=20>=20-=09defined=20CONFIG_AXP818_POWER=0D=0A>=20>=20>=20-=09power_failed=
=20=7C=3D=20axp_set_dcdc5(CONFIG_AXP_DCDC5_VOLT);=0D=0A>=20>=20>=20-=23endi=
f=0D=0A>=20>=20>=0D=0A>=20>=20>=20-=23if=20defined=20CONFIG_AXP221_POWER=20=
=7C=7C=20defined=20CONFIG_AXP809_POWER=20=7C=7C=20=5C=0D=0A>=20>=20>=20-=09=
defined=20CONFIG_AXP818_POWER=0D=0A>=20>=20>=20+=23ifdef=20CONFIG_AXP_ALDO1=
_VOLT=0D=0A>=20>=20>=20=20=09power_failed=20=7C=3D=20axp_set_aldo1(CONFIG_A=
XP_ALDO1_VOLT);=0D=0A>=20>=20>=20=20=23endif=0D=0A>=20>=20>=20-=23if=20=21d=
efined(CONFIG_AXP305_POWER)=0D=0A>=20>=20>=20+=23ifdef=20CONFIG_AXP_ALDO2_V=
OLT=0D=0A>=20>=20>=20=20=09power_failed=20=7C=3D=20axp_set_aldo2(CONFIG_AXP=
_ALDO2_VOLT);=0D=0A>=20>=20>=20=20=23endif=0D=0A>=20>=20>=20-=23if=20=21def=
ined(CONFIG_AXP152_POWER)=20&&=20=21defined(CONFIG_AXP305_POWER)=0D=0A>=20>=
=20>=20+=23ifdef=20CONFIG_AXP_ALDO3_VOLT=0D=0A>=20>=20>=20=20=09power_faile=
d=20=7C=3D=20axp_set_aldo3(CONFIG_AXP_ALDO3_VOLT);=0D=0A>=20>=20>=20=20=23e=
ndif=0D=0A>=20>=20>=20-=23ifdef=20CONFIG_AXP209_POWER=0D=0A>=20>=20>=20+=23=
ifdef=20CONFIG_AXP_ALDO4_VOLT=0D=0A>=20>=20>=20=20=09power_failed=20=7C=3D=
=20axp_set_aldo4(CONFIG_AXP_ALDO4_VOLT);=0D=0A>=20>=20>=20=20=23endif=0D=0A=
>=20>=20>=0D=0A>=20>=20>=20-=23if=20defined(CONFIG_AXP221_POWER)=20=7C=7C=
=20defined(CONFIG_AXP809_POWER)=20=7C=7C=20=5C=0D=0A>=20>=20>=20-=09defined=
(CONFIG_AXP818_POWER)=0D=0A>=20>=20>=20+=23ifdef=20CONFIG_AXP_DLDO1_VOLT=0D=
=0A>=20>=20>=20=20=09power_failed=20=7C=3D=20axp_set_dldo(1,=20CONFIG_AXP_D=
LDO1_VOLT);=0D=0A>=20>=20>=20=20=09power_failed=20=7C=3D=20axp_set_dldo(2,=
=20CONFIG_AXP_DLDO2_VOLT);=0D=0A>=20>=20>=20-=23if=20=21defined=20CONFIG_AX=
P809_POWER=0D=0A>=20>=20>=20+=23endif=0D=0A>=20>=20>=20+=23ifdef=20CONFIG_A=
XP_DLDO3_VOLT=0D=0A>=20>=20>=20=20=09power_failed=20=7C=3D=20axp_set_dldo(3=
,=20CONFIG_AXP_DLDO3_VOLT);=0D=0A>=20>=20>=20=20=09power_failed=20=7C=3D=20=
axp_set_dldo(4,=20CONFIG_AXP_DLDO4_VOLT);=0D=0A>=20>=20>=20=20=23endif=0D=
=0A>=20>=20>=20+=23ifdef=20CONFIG_AXP_ELDO1_VOLT=0D=0A>=20>=20>=20=20=09pow=
er_failed=20=7C=3D=20axp_set_eldo(1,=20CONFIG_AXP_ELDO1_VOLT);=0D=0A>=20>=
=20>=20=20=09power_failed=20=7C=3D=20axp_set_eldo(2,=20CONFIG_AXP_ELDO2_VOL=
T);=0D=0A>=20>=20>=20=20=09power_failed=20=7C=3D=20axp_set_eldo(3,=20CONFIG=
_AXP_ELDO3_VOLT);=0D=0A>=20>=20>=20=20=23endif=0D=0A>=20>=20>=0D=0A>=20>=20=
>=20-=23ifdef=20CONFIG_AXP818_POWER=0D=0A>=20>=20>=20+=23ifdef=20CONFIG_AXP=
_FLDO1_VOLT=0D=0A>=20>=20>=20=20=09power_failed=20=7C=3D=20axp_set_fldo(1,=
=20CONFIG_AXP_FLDO1_VOLT);=0D=0A>=20>=20>=20=20=09power_failed=20=7C=3D=20a=
xp_set_fldo(2,=20CONFIG_AXP_FLDO2_VOLT);=0D=0A>=20>=20>=20=20=09power_faile=
d=20=7C=3D=20axp_set_fldo(3,=20CONFIG_AXP_FLDO3_VOLT);=0D=0A>=20>=20>=20=40=
=40=20-649,7=20+645,7=20=40=40=20void=20sunxi_board_init(void)=0D=0A>=20>=
=20>=20=20=23if=20defined=20CONFIG_AXP809_POWER=20=7C=7C=20defined=20CONFIG=
_AXP818_POWER=0D=0A>=20>=20>=20=20=09power_failed=20=7C=3D=20axp_set_sw(IS_=
ENABLED(CONFIG_AXP_SW_ON));=0D=0A>=20>=20>=20=20=23endif=0D=0A>=20>=20>=20-=
=23endif=0D=0A>=20>=20>=20+=23endif=09/*=20CONFIG_AXPxxx_POWER=20*/=0D=0A>=
=20>=20>=20=20=09printf(=22DRAM:=22);=0D=0A>=20>=20>=20=20=09gd->ram_size=
=20=3D=20sunxi_dram_init();=0D=0A>=20>=20>=20=20=09printf(=22=20%d=20MiB=5C=
n=22,=20(int)(gd->ram_size=20>>=2020));=0D=0A>=20>=20>=20diff=20--git=20a/d=
rivers/power/Kconfig=20b/drivers/power/Kconfig=0D=0A>=20>=20>=20index=207f3=
b990d231..83cb31c937a=20100644=0D=0A>=20>=20>=20---=20a/drivers/power/Kconf=
ig=0D=0A>=20>=20>=20+++=20b/drivers/power/Kconfig=0D=0A>=20>=20>=20=40=40=
=20-180,7=20+180,7=20=40=40=20config=20AXP_DCDC3_VOLT=0D=0A>=20>=20>=0D=0A>=
=20>=20>=20=20config=20AXP_DCDC4_VOLT=0D=0A>=20>=20>=20=20=09int=20=22axp=
=20pmic=20dcdc4=20voltage=22=0D=0A>=20>=20>=20-=09depends=20on=20AXP152_POW=
ER=20=7C=7C=20AXP221_POWER=20=7C=7C=20AXP809_POWER=20=7C=7C=0D=0A>=20>=20AX=
P818_POWER=20=7C=7C=0D=0A>=20>=20>=20AXP305_POWER=20+=09depends=20on=20AXP1=
52_POWER=20=7C=7C=20AXP221_POWER=20=7C=7C=20AXP809_POWER=0D=0A>=20>=20=7C=
=7C=0D=0A>=20>=20>=20AXP305_POWER=20default=201250=20if=20AXP152_POWER=0D=
=0A>=20>=20>=20=20=09default=201200=20if=20MACH_SUN6I=0D=0A>=20>=20>=20=20=
=09default=200=20if=20MACH_SUN8I=0D=0A>=20>=0D=0A>=20>=20This=20patch=20is=
=20great,=20but=20this=20last=20change=20doesn't=20seem=20to=20be=20directl=
y=0D=0A>=20>=20connected?=0D=0A>=20=0D=0A>=20It=20is=20an=20existing=20bug:=
=20there=20is=20no=20axp_set_dcdc4()=20for=20the=20AXP818,=20but=0D=0A>=20s=
ince=20the=20AXP818=20is=20not=20included=20in=20the=20guards=20at=20the=20=
calling=20site=0D=0A>=20in=20board.c=20above,=20we=20didn't=20notice.=0D=0A=
>=20So=20without=20this=20change,=20all=20A83T=20boards=20(the=20only=20one=
s=20using=20AXP818)=0D=0A>=20would=20fail=20compilation.=0D=0A>=20I=20just=
=20forgot=20to=20mention=20it=20in=20the=20commit=20message,=20will=20add=
=20it.=0D=0A=0D=0AWill=20you=20resend=20this=20patch=20after=20updating=20t=
he=20commit=20message?=0D=0A=0D=0ABest=20Regards,=0D=0AJaehoon=20Chung=0D=
=0A=0D=0A>=20=0D=0A>=20Cheers,=0D=0A>=20Andre=0D=0A=0D=0A
