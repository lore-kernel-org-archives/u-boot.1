Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F15EC4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 05:11:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACE1E87ADD;
	Tue, 31 Oct 2023 06:11:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="qdU5WOFF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD16987ADD; Tue, 31 Oct 2023 06:11:13 +0100 (CET)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FBBA87557
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 06:11:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20231031051105epoutp02d3ed3f0454050c498ad12af96c9d29d9~TGRXOmcCy3180331803epoutp02z
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 05:11:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20231031051105epoutp02d3ed3f0454050c498ad12af96c9d29d9~TGRXOmcCy3180331803epoutp02z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698729065;
 bh=edJHZXLy3ynh5wzA7RZUksnSbtEYLjOZsTYWLksfP4I=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=qdU5WOFFqqt+h+XhULYqZSW+P5ftq8Zqky11gSKZ9fVkqGcQ0Wadz8ylgbg2rOAz+
 EhF+XHXeW3CrnMDcs8EgCAF144o4HtIxTo1w2fafVgjT4VH3OaH4E2SpuLUyc8umjZ
 EdrPHi5w2XNRkVdlQ6CJ86zSbHa2AYMJuZVBl0Ho=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTP id
 20231031051105epcas1p49eaaedbecaed3ce4517031dcd9d54531~TGRXCh5zF0118901189epcas1p4s;
 Tue, 31 Oct 2023 05:11:05 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.236]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4SKJBc0JZrz4x9Q3; Tue, 31 Oct
 2023 05:11:04 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 58.D6.09739.66C80456; Tue, 31 Oct 2023 14:11:02 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20231031051102epcas1p4af991eb9eafa7f1a657756cefe7938ab~TGRUDhpSj0117901179epcas1p4V;
 Tue, 31 Oct 2023 05:11:02 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20231031051102epsmtrp110518a70c5447884dea6d5953693ce24~TGRUC3lVO2849528495epsmtrp17;
 Tue, 31 Oct 2023 05:11:02 +0000 (GMT)
X-AuditID: b6c32a37-487afa800000260b-6b-65408c666c59
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 12.27.18939.66C80456; Tue, 31 Oct 2023 14:11:02 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20231031051102epsmtip1efa2ea8ef41bc841580aaaec1ffbb249~TGRTznsIl1552715527epsmtip1M;
 Tue, 31 Oct 2023 05:11:02 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Simon Glass'" <sjg@chromium.org>, "'Svyatoslav Ryhel'"
 <clamor95@gmail.com>
Cc: "'Patrick Delaunay'" <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
In-Reply-To: <CAPnjgZ08UbFUn538O8oA7D967ZTEFVZ+Kg7vfbAq7pKEbb4JvQ@mail.gmail.com>
Subject: RE: [PATCH v2 2/2] power: pmic: fix regulators behaviour
Date: Tue, 31 Oct 2023 14:11:02 +0900
Message-ID: <000001da0bb8$a4780cf0$ed6826d0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIfVYsG1EvT4iYqhJWSedtsaBeZWQENP99lAhmtyx8CWZOrnAI1WEKzAgFGLPEB64M4/gIRVVfqr2sljzA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplk+LIzCtJLcpLzFFi42LZdljTQDetxyHV4NQ3U4sD/b2MFpPWX2O3
 +LZlG6PF272d7A4sHrMbLrJ4PO3fyu6xc9Zddo+zd3YwBrBEZdtkpCampBYppOYl56dk5qXb
 KnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAO1UUihLzCkFCgUkFhcr6dvZFOWXlqQq
 ZOQXl9gqpRak5BSYFugVJ+YWl+al6+WlllgZGhgYmQIVJmRnNG+5wFbwTbXiwbQm9gbGaSpd
 jJwcEgImEps6LrF3MXJxCAnsYJS49HAtE4TziVHi4PobzHDOsytTGWFa2vetYQWxhQR2Mkoc
 6kqDKHrJKNHftYYdJMEmoCfxf9FCZhBbRCBY4sK73WA2s0CgxKt9PSwgNieQ/edsF9ggYQFH
 iWdv94PZLAKqEgvb5wLZHBy8ApYSZ19Hg4R5BQQlTs58wgIxRlti2cLXzBD3KEj8fLqMFWJV
 ksSlWRuhVolIzO5sA3tAQuAju8TXf7PYIRpcJJasmcsEYQtLvDq+BSouJfGyv40doqGZUWLp
 koOsEE4Po8S/hutsEFXGEvuXTmYCuY5ZQFNi/S59iLCixM7fcxkhNvNJvPvaA/aAhACvREeb
 EESJisSl1y+ZYHbdffKfdQKj0iwkv81C8tssJD/MQli2gJFlFaNYakFxbnpqsWGBMTy2k/Nz
 NzGC06OW+Q7GaW8/6B1iZOJgPMQowcGsJMJ72NQhVYg3JbGyKrUoP76oNCe1+BCjKTCwJzJL
 iSbnAxN0Xkm8oYmlgYmZkbGJhaGZoZI4761nvSlCAumJJanZqakFqUUwfUwcnFINTCbBLb8/
 LOBPPca4vuiyvqa6flbcrhvqpsmR6RIn/W+v7s3efedPFfvDHxuzVmu68PDnrzaVDi3qOpd3
 T67iJ+eFjX4Ggp8tF1259F5t35X4F6+qhbNFu6ZvbFfs3h8+1XLhi2b7nKO5x7Y25TPlbf3g
 eCdIvG9nk5Gk5iIvdYVnm9w5Y330MvaUnbvsqBxfWuftOEvokEup3NP0EtaT7DMfHrBV0tS9
 eTdSIFip71XZuqSdvTWPjjXdOLw+68+jf+pLKzg2T3vgdFAzZMomD0b3BB/HKS9zJ1hveapy
 dYPjbFnHeVbxKdwbdzZ5LjS20FXdP13z15z3rw8sSUqcx77P5/6+Kbfkq7dp2bfyKrEUZyQa
 ajEXFScCANBjO/QYBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsWy7bCSnG5aj0OqQe8rEYsD/b2MFpPWX2O3
 +LZlG6PF272d7A4sHrMbLrJ4PO3fyu6xc9Zddo+zd3YwBrBEcdmkpOZklqUW6dslcGVM6bvM
 WnBLuuLysr+MDYxTxboYOTkkBEwk2vetYe1i5OIQEtjOKLFy2lxmiISUxOenU9m6GDmAbGGJ
 w4eLIWqeM0pcffCCFaSGTUBP4v+ihWD1IgLBEtPerGQEsZkFAiVe7ethgWh4wizROvM4WBEn
 UOLP2S6wZmEBR4lnb/eD2SwCqhIL2+eygizjFbCUOPs6GiTMKyAocXLmExaImdoST28+hbOX
 LXwNdaeCxM+ny1ghbkiSuDRrIzNEjYjE7M425gmMwrOQjJqFZNQsJKNmIWlZwMiyilE0taA4
 Nz03ucBQrzgxt7g0L10vOT93EyM4PrSCdjAuW/9X7xAjEwfjIUYJDmYlEd7Dpg6pQrwpiZVV
 qUX58UWlOanFhxilOViUxHmVczpThATSE0tSs1NTC1KLYLJMHJxSDUzMWsv+F8msverLwOq1
 JYuD63Hf+bN8HXcuT92vXvyn7ewCoZM7Hfvk9D8emb3++PGWdSo8rXlFj1Jd2Sc4/WGp+e24
 ot1l5z6rjOKgnUtXsi/bPcntU6Dd9Ac9k2IjXY8kBjic3s/ttqjay1zy1n3T7KnKCwNOP3ny
 5c0x54O36o7uFndpmx14xKSZV26/ibZyQ9jy0AfPggIE5n+cMWcJNw/z8cM7l5SXPU9ef3/F
 pVLuP4XsunuvNnw8s8x9xs3+1RU3TwucmL+tYcsSc2uPbWXWClsPPuq8PEvmsnZ3gZzn9bIT
 ggqMK5exiUkWhfna/725gtfw1j7DlLh1wvb7Jxmutl/Fe7G19Un/9rnblFiKMxINtZiLihMB
 bgNQ7/4CAAA=
X-CMS-MailID: 20231031051102epcas1p4af991eb9eafa7f1a657756cefe7938ab
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230719010937epcas1p4be41151400ebea040e620a208be33636
References: <20230715183431.5318-1-clamor95@gmail.com>
 <20230715183431.5318-3-clamor95@gmail.com>
 <CAPnjgZ3_Q+nfW+qt1zmGFS2RLCeAzk6eMTEGsEBDdUU-gtzBZw@mail.gmail.com>
 <F441E992-C9A7-4873-8499-D36A477FD006@gmail.com>
 <CAPnjgZ0jBbwzQoi=n2kGGH87-y3r79sBHchr5kKe72M9DN1-Aw@mail.gmail.com>
 <539C9418-CF00-4D8C-8D4C-6461A6470E52@gmail.com>
 <CGME20230719010937epcas1p4be41151400ebea040e620a208be33636@epcas1p4.samsung.com>
 <CAPnjgZ08UbFUn538O8oA7D967ZTEFVZ+Kg7vfbAq7pKEbb4JvQ@mail.gmail.com>
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

If will resend this patch according Simon's comment, I will check again.

Best Regards,
Jaehoon Chung

> -----Original Message-----
> From: Simon Glass <sjg=40chromium.org>
> Sent: Wednesday, July 19, 2023 10:08 AM
> To: Svyatoslav Ryhel <clamor95=40gmail.com>
> Cc: Jaehoon Chung <jh80.chung=40samsung.com>; Patrick Delaunay <patrick.d=
elaunay=40foss.st.com>; u-
> boot=40lists.denx.de
> Subject: Re: =5BPATCH v2 2/2=5D power: pmic: fix regulators behaviour
>=20
> Hi Svyatoslav,
>=20
> On Sun, 16 Jul 2023 at 07:20, Svyatoslav Ryhel <clamor95=40gmail.com> wro=
te:
> >
> >
> >
> > 16 =D0=BB=D0=B8=D0=BF=D0=BD=D1=8F=202023=20=D1=80.=2016:08:10=20GMT+03:=
00,=20Simon=20Glass=20<sjg=40chromium.org>=20=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=B2(-=D0=BB=D0=B0):=0D=0A>=20>=20>Hi=20Svyatoslav,=0D=0A>=20>=20>=
=0D=0A>=20>=20>On=20Sat,=2015=20Jul=202023=20at=2022:08,=20Svyatoslav=20Ryh=
el=20<clamor95=40gmail.com>=20wrote:=0D=0A>=20>=20>>=0D=0A>=20>=20>>=0D=0A>=
=20>=20>>=0D=0A>=20>=20>>=2016=20=D0=BB=D0=B8=D0=BF=D0=BD=D1=8F=202023=20=
=D1=80.=2002:40:37=20GMT+03:00,=20Simon=20Glass=20<sjg=40chromium.org>=20=
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=B2(-=D0=BB=D0=B0):=0D=0A>=20>=20>>=
=20>Hi=20Svyatoslav,=0D=0A>=20>=20>>=20>=0D=0A>=20>=20>>=20>On=20Sat,=2015=
=20Jul=202023=20at=2012:34,=20Svyatoslav=20Ryhel=20<clamor95=40gmail.com>=
=20wrote:=0D=0A>=20>=20>>=20>>=0D=0A>=20>=20>>=20>>=20Currently=20device=20=
tree=20entries=20of=20regulators=20are=20completely=0D=0A>=20>=20>>=20>>=20=
ignored=20and=20regulators=20are=20probed=20only=20if=20they=20are=20called=
=0D=0A>=20>=20>>=20>>=20by=20the=20device=20which=20uses=20it.=20This=20res=
ults=20into=20two=20issues:=0D=0A>=20>=20>>=20>>=20regulators=20which=20mus=
t=20run=20under=20boot-on=20or=20always-on=20mode=0D=0A>=20>=20>>=20>>=20ar=
e=20ignored=20and=20not=20enabled;=20dts=20props=20like=20voltage=20are=0D=
=0A>=20>=20>>=20>>=20not=20applied=20to=20the=20regulator=20so=20the=20regu=
lator=20may=20be=20enabled=0D=0A>=20>=20>>=20>>=20with=20random=20actual=20=
voltage,=20which=20may=20have=20unexpected=0D=0A>=20>=20>>=20>>=20consequen=
ces.=0D=0A>=20>=20>>=20>>=0D=0A>=20>=20>>=20>>=20This=20patch=20changes=20t=
his=20behavior.=20Post-probe=20function=20is=0D=0A>=20>=20>>=20>>=20introdu=
ced=20which=20performs=20probing=20of=20each=20pmics=20child=20and=20if=0D=
=0A>=20>=20>>=20>>=20it=20is=20a=20regulator,=20regulator_autoset=20functio=
n=20is=20called,=20which=0D=0A>=20>=20>>=20>>=20handles=20always-on=20and=
=20boot-on=20regulators,=20but=20if=20none=20of=20those=0D=0A>=20>=20>>=20>=
>=20props=20are=20set,=20the=20regulator=20is=20disabled.=0D=0A>=20>=20>>=
=20>>=0D=0A>=20>=20>>=20>>=20Later=20disabled=20regulators=20can=20be=20re-=
enabled=20by=20devices=20which=0D=0A>=20>=20>>=20>>=20use=20them=20without=
=20issues.=0D=0A>=20>=20>>=20>>=0D=0A>=20>=20>>=20>>=20Signed-off-by:=20Svy=
atoslav=20Ryhel=20<clamor95=40gmail.com>=0D=0A>=20>=20>>=20>>=20---=0D=0A>=
=20>=20>>=20>>=20=20drivers/power/pmic/pmic-uclass.c=20=7C=2018=20+++++++++=
+++++++++=0D=0A>=20>=20>>=20>>=20=201=20file=20changed,=2018=20insertions(+=
)=0D=0A>=20>=20>>=20>=0D=0A>=20>=20>>=20>Can=20you=20add=20a=20test=20for=
=20this=20to=20test/dm/pmic.c=20?=0D=0A>=20>=20>>=20>=0D=0A>=20>=20>>=0D=0A=
>=20>=20>>=20Sure,=20may=20you=20specify=20what=20I=20should=20add=20to=20t=
ests/dm/pmic.c?=20Which=20behavior=20is=20needed?=0D=0A>=20>=20>=0D=0A>=20>=
=20>Just=20for=20the=20change=20you=20are=20making...you=20should=20be=20ab=
le=20to=20check=20that=0D=0A>=20>=20>it=20sets=20the=20regulators=20if=20yo=
u=20make=20sure=20there=20are=20some=20autoset=20ones=20in=0D=0A>=20>=20>sa=
ndbox.=0D=0A>=20>=0D=0A>=20>=20Easier=20to=20tell=20then=20to=20do.=20I=20a=
m=20basically=20interfering=20into=20device=20establishment=20process.=20If=
=20smth=0D=0A>=20goes=20wrong,=20any=20regulator=20related=20test=20should=
=20fail.=20At=20least=20my=20devices=20refused=20to=20boot/gave=0D=0A>=20un=
expected=20behavior=20while=20developing.=20I=20will=20look=20if=20I=20can=
=20find=20anything=20meaningful.=0D=0A>=20=0D=0A>=20Something=20like=20this=
=20in=20test/dm/regulator.c:=0D=0A>=20=0D=0A>=20struct=20udevice=20*pmic,=
=20*reg;=0D=0A>=20=0D=0A>=20//=20This=20should=20automatically=20probe=20th=
e=0D=0A>=20ut_asserok(pmic_get(=22pmic=4041=22),=20&pmic);=0D=0A>=20=0D=0A>=
=20//=20Check=20that=20the=20regulators=20are=20probed=20and=20on=0D=0A>=20=
ut_assertok(regulator_get_by_devname(=22ldo2=22,=20&reg));=0D=0A>=20ut_asse=
rt(regulator_get_enable(reg));=0D=0A>=20=0D=0A>=20See=20test.dtsi=20and=20s=
andbox_pmic.dtsi=20for=20the=20DT=20nodes.=20You'll=20need=20to=0D=0A>=20up=
date=20ldo2=20t=20too=20add=20the=20properties=20to=20cause=20an=20autoset.=
=0D=0A>=20=0D=0A>=20Regards,=0D=0A>=20Simon=0D=0A=0D=0A
