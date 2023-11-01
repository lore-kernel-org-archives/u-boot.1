Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D9EC4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 05:46:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67CC6876A2;
	Wed,  1 Nov 2023 06:46:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="WAERT790";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A950A876A2; Wed,  1 Nov 2023 06:46:22 +0100 (CET)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 389E587D06
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 06:46:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20231101054603epoutp048c2281e498cada941ac6dba86b468266~TaZLc3Hgb1791817918epoutp04g
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 05:46:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20231101054603epoutp048c2281e498cada941ac6dba86b468266~TaZLc3Hgb1791817918epoutp04g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698817563;
 bh=J96aso14lF4vyClHaxLIoAh02ewvMjLdYlRSjJi5UZA=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=WAERT790mxMyuCFOoZcSQqfbunULobXhfoAzG49y1zD+8TYmb+lVpb/2sQ8Ysr8Bs
 i2lSfbgWdNXr+mtyMV/bdxMmr6xUlsRHuvJ2MmDXokUMQtA37QoJrcSgfpFuLC5Dym
 Nui+DI1hkqZNROmlj6nJxhKUY+hD/NnkVapfjaW4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20231101054603epcas1p24c09402a0699029262a098894f2218c3~TaZK39WLY1079510795epcas1p2h;
 Wed,  1 Nov 2023 05:46:03 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.237]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4SKwwV218vz4x9Q6; Wed,  1 Nov
 2023 05:46:02 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
 0A.87.10025.A16E1456; Wed,  1 Nov 2023 14:46:02 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20231101054601epcas1p46ac0f62b761bb8b4b435c4e8c31df7f7~TaZJHbMdN1909219092epcas1p44;
 Wed,  1 Nov 2023 05:46:01 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20231101054601epsmtrp28e99f2341d58dbaa9202981477513cec~TaZJFqKae1114311143epsmtrp2L;
 Wed,  1 Nov 2023 05:46:01 +0000 (GMT)
X-AuditID: b6c32a39-c2bf870000002729-7e-6541e61a9f0d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 4B.7C.18939.916E1456; Wed,  1 Nov 2023 14:46:01 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20231101054601epsmtip257771ce792092df4bca3fd205a1329fd~TaZI0ByL50810108101epsmtip2Z;
 Wed,  1 Nov 2023 05:46:01 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Fabio Estevam'" <festevam@gmail.com>, "'Marek Vasut'" <marex@denx.de>
Cc: <u-boot@lists.denx.de>, "'Abdellatif	El Khlifi'"
 <abdellatif.elkhlifi@arm.com>, "'Heinrich Schuchardt'" <xypron.glpk@gmx.de>,
 "'Ilias Apalodimas'" <ilias.apalodimas@linaro.org>, "'Ramon	Fried'"
 <rfried.dev@gmail.com>, "'Roger Knecht'" <rknecht@pm.me>, "'Sean Edmond'"
 <seanedmond@microsoft.com>, "'Simon Glass'" <sjg@chromium.org>, "'Tobias
 Waldekranz'" <tobias@waldekranz.com>
In-Reply-To: <CAOMZO5B7YMuSRxjMnvuQ0u3MgLxZ=B9PwrqDe0DNOd3nJT7eXw@mail.gmail.com>
Subject: RE: [PATCH v4] cmd: mmc: Add mmc reg read command for reading card
 registers
Date: Wed, 1 Nov 2023 14:46:00 +0900
Message-ID: <020b01da0c86$b1efba80$15cf2f80$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLDyBprx2d92eVVj28hfBS8HDvcsAEyVXU9AiD5DJ+uduKywA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMJsWRmVeSWpSXmKPExsWy7bCmga7UM8dUg9VnOC1eXe9ltXh41d+i
 t+U3s8WbtkZGi8Ofz7Jb3Dx4ntFi/6I6i29btjFaLDq+kNXi7d5OdovDUz8wOnB7rJm3htFj
 dsNFFo95s06weOycdZfd48PHOI871/aweZy9s4PRo3XHX3aPo3vOsXn82baUMYArKtsmIzUx
 JbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+hiJYWyxJxSoFBA
 YnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BaYFecWJucWleul5eaomVoYGBkSlQYUJ2xoSzD1gL
 FvFUTN18nrmBcSl3FyMnh4SAicTVA0vZuxi5OIQEdjBKbJ7TxwbhfGKU6Jh+ACjDAeG8MoJp
 2NH/AqpmJ6PEhM/nGCGcl4wSSyb2soFUsQnoSfxftJAZxBYR8JbYOfcmWAezQDuzxImdL1hB
 EpwCgRKHrjwD2yAsEC7x81omSJhFQEXiZ9NCsDm8ApYS547MZIGwBSVOznwCZjMLaEssW/ia
 GeIiBYmfT5exQuxyklhy5iQbRI2IxOzONmaQvRICFzgkjs86ywTR4CJxYONtFghbWOLV8S3s
 ELaUxOd3e9kgGpoZJZYuOcgK4fQwSvxruM4GUWUssX/pZCaQq5kFNCXW79KHCCtK7Pw9lxFi
 M5/Eu689rCAlEgK8Eh1tQhAlKhKXXr9kgtl198l/1gmMSrOQ/DYLyW+zkPwwC2HZAkaWVYxi
 qQXFuempxYYFpvDYTs7P3cQITs1aljsYp7/9oHeIkYmD8RCjBAezkgjvYVOHVCHelMTKqtSi
 /Pii0pzU4kOMpsDQnsgsJZqcD8wOeSXxhiaWBiZmRsYmFoZmhkrivOfe9qYICaQnlqRmp6YW
 pBbB9DFxcEo1MEWGa17Knx7hz+dzdIPrr//uUnU2oYU75n/QTruWLP93d3LkTw6XTn2RKclV
 JxfU9cUumMVm/li36MQx932uvjdU/GzYzpQXarMLl9e3PrAX/50rMU2zf23pzj3eelusPrux
 12401OfhFCyI/7Vawbf7IN+nT/dUcj67dll/eV5adEFkIi/bf8vYs7LpZe9Ou6/bup9xQfuG
 KQ/Nb8mIXjGNqbStu1UmHDzb50ebkPyRMhs1njfTf4onSiQfvpv3QDqtYlYx95aef9snXLhV
 d3cD+6QjbUGdKf6pk58W6GjNVO2P1d6lz7ezX1Cp+jKTmvRm8dt1gurxvk+qOI3VQxepp5uH
 PtnUdijlbq0SS3FGoqEWc1FxIgA+UNJeVgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWy7bCSvK7kM8dUg8ezBSxeXe9ltXh41d+i
 t+U3s8WbtkZGi8Ofz7Jb3Dx4ntFi/6I6i29btjFaLDq+kNXi7d5OdovDUz8wOnB7rJm3htFj
 dsNFFo95s06weOycdZfd48PHOI871/aweZy9s4PRo3XHX3aPo3vOsXn82baUMYArissmJTUn
 syy1SN8ugSvj8o6DzAU9XBWTZqxia2Dcx9HFyMkhIWAisaP/BRuILSSwnVHiVK8uRFxK4vPT
 qUBxDiBbWOLw4eIuRi6gkueMEptPP2YBqWET0JP4v2ghM0iNiICvxJXH3CA1zAK9zBJ9P2+z
 QzScZJQ4/PU2I0gDp0CgxKErz9hBbGGBUImvZ3uYQWwWARWJn00LwY7gFbCUOHdkJguELShx
 cuYTMJtZQFvi6c2ncPayha+ZIQ5VkPj5dBkriC0i4CSx5MxJNogaEYnZnW3MExiFZyEZNQvJ
 qFlIRs1C0rKAkWUVo2hqQXFuem5ygaFecWJucWleul5yfu4mRnBsagXtYFy2/q/eIUYmDsZD
 jBIczEoivIdNHVKFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8yrndKYICaQnlqRmp6YWpBbBZJk4
 OKUamNTipnjqXBLizmiMDV7+53anomTs1Tpl/ismsa3bI/+ddF0RynOna0nh/W0F0WGhu72e
 aKnU8bX1fitXfDJdV41h09UQFVPZ70cecl4KtTZ++ErFyUHxslQY39amBs9TBz/6Pf+SseRC
 zZpmh6oNYQcYLA7IB7a7lRV4blWO3JKrV/Z4Z5e746uf9vpiM/Jm6u77F3gu1mPhjHtB5UYf
 qvNfn82749XH3XQjhEPb2KalWmHnosVZuj8+28tYlzY7in8++ddqPfdXa+uUX3IH7YI3bo7k
 DbkaIm9ToPXMtfyj91Vhn42zIj9532/2qzreLHZqypxZBz9vV5v3+luMx8x9d4V/Xos57dqp
 J/xFiaU4I9FQi7moOBEAErbn5zwDAAA=
X-CMS-MailID: 20231101054601epcas1p46ac0f62b761bb8b4b435c4e8c31df7f7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231031160921epcas1p34f70e9e582204ef204a9b73eb5f330ae
References: <20231031122020.95007-1-marex@denx.de>
 <CGME20231031160921epcas1p34f70e9e582204ef204a9b73eb5f330ae@epcas1p3.samsung.com>
 <CAOMZO5B7YMuSRxjMnvuQ0u3MgLxZ=B9PwrqDe0DNOd3nJT7eXw@mail.gmail.com>
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
> From: Fabio Estevam <festevam=40gmail.com>
> Sent: Wednesday, November 1, 2023 1:09 AM
> To: Marek Vasut <marex=40denx.de>
> Cc: u-boot=40lists.denx.de; Jaehoon Chung <jh80.chung=40samsung.com>; Abd=
ellatif El Khlifi
> <abdellatif.elkhlifi=40arm.com>; Heinrich Schuchardt <xypron.glpk=40gmx.d=
e>; Ilias Apalodimas
> <ilias.apalodimas=40linaro.org>; Ramon Fried <rfried.dev=40gmail.com>; Ro=
ger Knecht <rknecht=40pm.me>; Sean
> Edmond <seanedmond=40microsoft.com>; Simon Glass <sjg=40chromium.org>; To=
bias Waldekranz
> <tobias=40waldekranz.com>
> Subject: Re: =5BPATCH v4=5D cmd: mmc: Add mmc reg read command for readin=
g card registers
>=20
> On Tue, Oct 31, 2023 at 9:20=E2=80=AFAM=20Marek=20Vasut=20<marex=40denx.d=
e>=20wrote:=0D=0A>=20>=0D=0A>=20>=20Add=20extension=20to=20the=20'mmc'=20co=
mmand=20to=20read=20out=20the=20card=20registers.=0D=0A>=20>=20Currently,=
=20only=20the=20eMMC=20OCR/CID/CSD/EXTCSD/RCA/DSR=20register=20are=0D=0A>=
=20>=20supported.=20A=20register=20value=20can=20either=20be=20displayed=20=
or=20read=20into=0D=0A>=20>=20an=20environment=20variable.=0D=0A>=20>=0D=0A=
>=20>=20Tested-by:=20Jaehoon=20Chung=20<jh80.chung=40samsung.com>=0D=0A>=20=
>=20Reviewed-by:=20Jaehoon=20Chung=20<jh80.chung=40samsung.com>=0D=0A>=20>=
=20Signed-off-by:=20Marek=20Vasut=20<marex=40denx.de>=0D=0A>=20=0D=0A>=20Re=
viewed-by:=20Fabio=20Estevam=20<festevam=40gmail.com>=0D=0A=0D=0AApplied=20=
to=20u-boot-mmc/master.=20Thanks=21=0D=0A=0D=0ABest=20Regards,=0D=0AJaehoon=
=20Chung=0D=0A=0D=0A
