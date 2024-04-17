Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBBB3C4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 10:51:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 534008844C;
	Wed, 17 Apr 2024 12:51:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="mRTKS9xQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFE8C88460; Wed, 17 Apr 2024 12:50:58 +0200 (CEST)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B35458844C
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 12:50:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20240417105052epoutp02aba1f643eb4fe9fd3687cfe5c87e1cbc~HC7RMtvzS0177901779epoutp02V
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 10:50:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20240417105052epoutp02aba1f643eb4fe9fd3687cfe5c87e1cbc~HC7RMtvzS0177901779epoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1713351052;
 bh=0TjNrTyafesgCGiHAEKC/k1lK3Bktr/VF/4YNrzPl5E=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=mRTKS9xQCHyvhK3oSxjn3Viw/loIqC532Y3fQHvGoyD6gbTyuhb9m6MAVXpRWYzRr
 dOtkz5QagC7iS4eKKntH/ha5R1My069E58XzTB4cf4Wzi0/QV55ZVfPgUwn+0qUGnr
 pj5Ev+zbhLab6+5jiclMcOtVBusrAqmiYRk4XIqc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTP id
 20240417105051epcas1p14decdd2b41c5469b8f978fc33ddc0502~HC7QuzPBv1628116281epcas1p1I;
 Wed, 17 Apr 2024 10:50:51 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.38.236]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4VKHkf5SXrz4x9Pp; Wed, 17 Apr
 2024 10:50:50 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 A6.17.19431.A89AF166; Wed, 17 Apr 2024 19:50:50 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20240417105050epcas1p246620646bb647f7becd54685a9a3042b~HC7PgyY5g0939809398epcas1p2d;
 Wed, 17 Apr 2024 10:50:50 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240417105050epsmtrp289a3ff02927d479fde94d74fe62b43ee~HC7Pf-VIf2270822708epsmtrp2i;
 Wed, 17 Apr 2024 10:50:50 +0000 (GMT)
X-AuditID: b6c32a4c-1d1ff70000004be7-b3-661fa98ac49c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 DE.A7.08390.A89AF166; Wed, 17 Apr 2024 19:50:50 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20240417105050epsmtip1f5ebf44bc8330e33681e4d29c15f8a23~HC7PPWaFH2655226552epsmtip1u;
 Wed, 17 Apr 2024 10:50:50 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Maxim Kiselev'" <bigunclemax@gmail.com>, "'Sean Anderson'"
 <sean.anderson@seco.com>
Cc: "'Tom Rini'" <trini@konsulko.com>, "'Peng Fan'" <peng.fan@nxp.com>,
 "'Marek Vasut'" <marek.vasut+renesas@mailbox.org>, "'Paul Barker'"
 <paul.barker.ct@bp.renesas.com>, "'Kever Yang'" <kever.yang@rock-chips.com>,
 "'Peter Geis'" <pgwipeout@gmail.com>, "'Oleksandr Suvorov'"
 <oleksandr.suvorov@foundries.io>, "'Stefan Roese'" <sr@denx.de>,
 <u-boot@lists.denx.de>
In-Reply-To: <CALHCpMhx_ViUXfgPPAHfn4jTp7X9grYCtAxH3pnz1bYjkUAg7Q@mail.gmail.com>
Subject: RE: [RFC PATCH v1 1/1] mmc: snps_sdhci: Add sdhci driver support
 for TH1520 SoC
Date: Wed, 17 Apr 2024 19:50:50 +0900
Message-ID: <01ca01da90b5$1c787e70$55697b50$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFW+cnwds75moLICqETQWy5ewwdHAGOydPfApsHvKYCh4KoQwKXr+qVsikp7iA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFJsWRmVeSWpSXmKPExsWy7bCmgW7XSvk0g8v3tCxO/dvKZrFt+k82
 i9aVd9gsnr6ZwWLx5+QPVosfq76wWpx95m0x734Lk8XJdR+YLKZO2sxu8XZvJ7sDt8fKF7PZ
 PebNOsHicehqJ6vHzll32T1eHVjF7nH2zg5Gj52z9zF5bHy3g8nj76z9LB7P/n1jD+CKyrbJ
 SE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAbpZSaEsMacU
 KBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgWqBXnJhbXJqXrpeXWmJlaGBgZApUmJCdcax3
 IkvBf8WKGa8eMTcw7lboYuTkkBAwkfh9/y1jFyMXh5DAHkaJU9M3sEI4nxglLp18zAThfGOU
 aHv4hqWLkQOsZelbI4j4XkaJrXM+sUE4Lxkl9kxewwwyl01AT+L/ooXMIA0iAtESP6emg9Qw
 C3xlkti56hIbSA2nQKDE0f2bmUBsYYEoie6m66wgNouAqsTUCW/ZQWxeAUuJJd9vskHYghIn
 Zz5hAbGZBbQlli18zQzxg4LEz6fLwHpFBPwkdsx5xwZRIyIxu7ONGWSxhMAVDom2nTtZIRpc
 JI593MoEYQtLvDq+hR3ClpL4/G4vG0RDM6PE0iUHWSGcHkaJfw3X2SCqjCX2L53MBPIas4Cm
 xPpd+hDb+CTefe1hhQQRr0RHmxBEtYrEpdcvmWDm333yH+oGD4nbE/sYJzAqzkLy2ywkv81C
 8sMshGULGFlWMUqlFhTnpqcmGxYY6uallsOjPDk/dxMjOFFr+exg/L7+r94hRiYOxkOMEhzM
 SiK8LcKyaUK8KYmVValF+fFFpTmpxYcYTYEhPpFZSjQ5H5gr8kriDU0sDUzMjIxNLAzNDJXE
 ec9cKUsVEkhPLEnNTk0tSC2C6WPi4JRqYNrDN+t526SVz+3cf586sFVb75usp/wER/8rKzsb
 DlS/F3n1Q0fb8ZLUvG7Nc/c5L7DaJexW2rRf3oT95o4SvY3RuU0O872YfQ/tPvlyesR/5mUv
 kpdx26nOePfwYPbuhy1G+6Z9FKxo33zrvphtqsq5mQ97AzXWXBeuKLR/1NLQ/oj/457IIkP5
 7sanMyZPOiNa53qgealeQ6J9/8Kw53mmJ6zzX//imfeKq/3AxOhV3eap55T5NsSe3Hy6eW39
 pdIY/4tKHSkvt7QxSzwKvV5fdeBnxGuh70uMhA7ZPHrDoHRih4Pnc+7zvVY3Xv4MYLkodkTi
 +/KKzMy5qVOrv0tv1Ax3PrYnkYtXqWrrisNKLMUZiYZazEXFiQDi6VmPXQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsWy7bCSnG7XSvk0gyUNwhan/m1ls9g2/Seb
 RevKO2wWT9/MYLH4c/IHq8WPVV9YLc4+87aYd7+FyeLkug9MFlMnbWa3eLu3k92B22Pli9ns
 HvNmnWDxOHS1k9Vj56y77B6vDqxi9zh7Zwejx87Z+5g8Nr7bweTxd9Z+Fo9n/76xB3BFcdmk
 pOZklqUW6dslcGU07OIomCxZ8X/PDcYGxvUiXYwcHBICJhJL3xp1MXJxCAnsZpT4e/YVaxcj
 J1BcSuLz06lsEDXCEocPF0PUPGeUuPdsH1gNm4CexP9FC5lBbBGBaIn9EzrB4swCv5kk9jzz
 gmjYwCRx49dksCJOgUCJo/s3M4HYwgIREvse7WYBsVkEVCWmTnjLDmLzClhKLPl+kw3CFpQ4
 OfMJC8RQbYmnN5/C2csWvmaGOFRB4ufTZawQR/hJ7Jjzjg2iRkRidmcb8wRG4VlIRs1CMmoW
 klGzkLQsYGRZxSiZWlCcm55bbFhglJdarlecmFtcmpeul5yfu4kRHKVaWjsY96z6oHeIkYmD
 8RCjBAezkghvi7BsmhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeb697U4QE0hNLUrNTUwtSi2Cy
 TBycUg1MlpcP75cq9Z4n+nDevNJ9zprpG/ZHV89dYCAoWpvVy/bm1/uXj67cPfU65rzw/ISX
 BkESb5dcPvhIO3TuUzar4EfRsttj44I1DM7c/f3i20mtFHeOXZ2bDs7Y7aJ2+Z2pysQ0CxGx
 Def1bvO8nVBcZMxrZ85QJraWV47hyBLGhyUdJ5XWKG7oO5V1IYz3gYz2qfkMPqrdD/+Jh6xO
 zu+yvOi/59buuQcD8/Qz95vMdHD84z6Die1My/UvypOkJy7jCzdc1yOSM//B7NTNZxoOXZM1
 2XzNevO3zv4X99jPWzcFq96el7Nw52ufG9u1BXjuqJworp+dftDpJO9Dv4SFlfdbLJ4cOL6O
 T9Lk42mRECWW4oxEQy3mouJEABFwwONBAwAA
X-CMS-MailID: 20240417105050epcas1p246620646bb647f7becd54685a9a3042b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240402185713epcas1p24ef43f8def9b3df6a9193fbf2e66a012
References: <20240330175948.80931-1-bigunclemax@gmail.com>
 <20240330175948.80931-2-bigunclemax@gmail.com>
 <04c61877-29ef-4a09-b003-eb36733ccca4@seco.com>
 <CGME20240402185713epcas1p24ef43f8def9b3df6a9193fbf2e66a012@epcas1p2.samsung.com>
 <CALHCpMhx_ViUXfgPPAHfn4jTp7X9grYCtAxH3pnz1bYjkUAg7Q@mail.gmail.com>
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
> From: Maxim Kiselev <bigunclemax=40gmail.com>
> Sent: Wednesday, April 3, 2024 3:57 AM
> To: Sean Anderson <sean.anderson=40seco.com>
> Cc: Tom Rini <trini=40konsulko.com>; Peng Fan <peng.fan=40nxp.com>; Jaeho=
on Chung <jh80.chung=40samsung.com>;
> Marek Vasut <marek.vasut+renesas=40mailbox.org>; Paul Barker <paul.barker=
.ct=40bp.renesas.com>; Kever Yang
> <kever.yang=40rock-chips.com>; Peter Geis <pgwipeout=40gmail.com>; Oleksa=
ndr Suvorov
> <oleksandr.suvorov=40foundries.io>; Stefan Roese <sr=40denx.de>; u-boot=
=40lists.denx.de
> Subject: Re: =5BRFC PATCH v1 1/1=5D mmc: snps_sdhci: Add sdhci driver sup=
port for TH1520 SoC
>=20
> Hi, Sean
>=20
> =D0=B2=D1=82,=202=20=D0=B0=D0=BF=D1=80.=202024=E2=80=AF=D0=B3.=20=D0=B2=
=2018:39,=20Sean=20Anderson=20<sean.anderson=40seco.com>:=0D=0A>=20>=0D=0A>=
=20>=20On=203/30/24=2013:59,=20Maksim=20Kiselev=20wrote:=0D=0A>=20>=20>=20A=
dd=20support=20for=20DesignWare=20SDHCI=20host=20controller=20on=20Alibaba=
=20TH1520=20SoC=0D=0A>=20>=20>=0D=0A>=20>=20>=20Signed-off-by:=20Maksim=20K=
iselev=20<bigunclemax=40gmail.com>=0D=0A>=20>=20>=20---=0D=0A>=20>=20>=20dr=
ivers/mmc/Kconfig=20=7C=2012=20+=0D=0A>=20>=20>=20drivers/mmc/Makefile=20=
=7C=201=20+=0D=0A>=20>=20>=20drivers/mmc/snps_sdhci.c=20=7C=20464=20+++++++=
++++++++++++++++++++++++++++++++=0D=0A>=20>=20>=203=20files=20changed,=2047=
7=20insertions(+)=0D=0A>=20>=20>=20create=20mode=20100644=20drivers/mmc/snp=
s_sdhci.c=0D=0A>=20>=20>=0D=0A>=20>=20>=20diff=20--git=20a/drivers/mmc/Kcon=
fig=20b/drivers/mmc/Kconfig=0D=0A>=20>=20>=20index=20cef05790dd..6936fa0928=
=20100644=0D=0A>=20>=20>=20---=20a/drivers/mmc/Kconfig=0D=0A>=20>=20>=20+++=
=20b/drivers/mmc/Kconfig=0D=0A>=20>=20>=20=40=40=20-671,6=20+671,18=20=40=
=40=20config=20MMC_SDHCI_S5P=0D=0A>=20>=20>=0D=0A>=20>=20>=20If=20unsure,=
=20say=20N.=0D=0A>=20>=20>=0D=0A>=20>=20>=20+config=20MMC_SDHCI_SNPS=0D=0A>=
=20>=20>=20+=20bool=20=22Synopsys=20DesignWare=20SDHCI=20controller=22=0D=
=0A>=20>=20>=20+=20depends=20on=20MMC_SDHCI=0D=0A>=20>=20>=20+=20depends=20=
on=20DM_MMC=0D=0A>=20>=20>=20+=20help=0D=0A>=20>=20>=20+=20Support=20for=20=
DesignWare=20SDHCI=20host=20controller=20on=20Alibaba=20TH1520=20SoC.=0D=0A=
>=20>=20>=20+=20This=20is=20a=20highly=20configurable=20and=20programmable,=
=20high=20performance=0D=0A>=20>=20>=20+=20Mobile=20Storage=20Host=20Contro=
ller=20(MSHC)=20with=20AXI=20as=20the=20bus=20interface=0D=0A>=20>=20>=20+=
=20for=20data=20transfer.=0D=0A>=20>=20>=20+=0D=0A>=20>=20>=20+=20If=20unsu=
re,=20say=20N.=0D=0A>=20>=20>=20+=0D=0A>=20>=0D=0A>=20>=20Why=20not=20use=
=20MMC_DW?=0D=0A>=20=0D=0A>=20That=20driver=20looks=20completely=20differen=
t.=20As=20I=20notice=20in=20the=20cover=20letter,=0D=0A>=20the=20MMC_SDHCI_=
ROCKCHIP=20driver=20is=20closer=20to=20TH1520=20driver.=0D=0A>=20https://lo=
re.kernel.org/u-boot/20240330175948.80931-1-bigunclemax=40gmail.com/=0D=0A>=
=20=0D=0A>=20Their=20IP=20blocks=20look=20very=20similar.=0D=0A>=20Moreover=
,=20on=20Linux,=20Rockchip=20SDHCI=20controllers=20(ex.=20rockchip,rk3588-d=
wcmshc)=0D=0A>=20and=20the=20TH1520=20controller=20live=20in=20the=20same=
=20driver=20-=20sdhci-of-dwcmshc.c=0D=0A=0D=0ARight.=20I=20didn't=20have=20=
its=20TRM.=20AFAIK,=20It's=20a=20different=20IP=20with=20DW_MMC.=0D=0A=0D=
=0A>=20=0D=0A>=20We=20could=20do=20the=20same=20for=20U-boot.=20It=20will=
=20require=20to=20get=20rid=20of=20Rockchip=0D=0A>=20specific=20defines=20t=
hat=20come=20from=20asm/arch-rockchip/hardware.h.=0D=0A>=20And=20maybe=20re=
name=20the=20rockchip_sdhci.c=20driver=20to=20sdhci-of-dwcmshc.c.=0D=0A=0D=
=0AIn=20u-boot,=20rochkip_sdhci.c=20is=20including=20the=20specific=20rockc=
hip=20code.=20(rockchip=20header..)=0D=0ASo=20I=20think=20that=20it=20can=
=20be=20a=20huge=20refactoring=20to=20use=20both=20SoC.=0D=0A=0D=0ABut=20if=
=20it's=20possible,=20I=20think=20that=20it=20can=20be=20reusable.=0D=0A=0D=
=0A>=20=0D=0A>=20That's=20why=20I=20mark=20this=20series=20as=20RFC.=20So=
=20I'm=20willing=20to=20discuss=20any=20option.=0D=0A>=20=0D=0A>=20>=20--Se=
an=0D=0A>=20>=0D=0A>=20>=0D=0A>=20>=20=5BEmbedded=20World=202024,=20SECO=20=
SpA=5D<https://www.messe-=0D=0A>=20ticket.de/Nuernberg/embeddedworld2024/Re=
gister/ew24517689>=0D=0A>=20=0D=0A>=20Cheers,=0D=0A>=20Maksim=0D=0A=0D=0A
