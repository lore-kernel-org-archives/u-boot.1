Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43533C25B75
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 06:09:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAADA882DA;
	Mon,  3 Jun 2024 08:09:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="QKFZHVOy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A872882CE; Mon,  3 Jun 2024 08:09:10 +0200 (CEST)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F8E1882A6
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 08:09:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mk7.kang@samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20240603060857epoutp0485bc41a9da077c453689887866eb5fc1~VaZjJLP3M1012810128epoutp04N
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 06:08:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20240603060857epoutp0485bc41a9da077c453689887866eb5fc1~VaZjJLP3M1012810128epoutp04N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1717394937;
 bh=HgMbAHq3kUxKAtK7AKAmDxZP8xs/9JWdvTJcAzFL0Kg=;
 h=From:To:Subject:Date:References:From;
 b=QKFZHVOyvIa8ZPw8LCWZZEsX4pcY00A1GdTrTbh+C5W/rbe0m0S0OotJR9vhqkF1i
 HyBixatxB+5q3g3pkAVXpQUxvpkLNiHUdTeZLwSjkUzMusreDmORHi1qjccqPvBXKK
 u6yLau2DPvzJ5CT7TO2DhlY91myrT3gCBuNxqmr0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTP id
 20240603060857epcas1p1e406fcc4e67bd1033751c34715a6fea3~VaZi53LEz0567005670epcas1p17;
 Mon,  3 Jun 2024 06:08:57 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.240]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4Vt3Fh4JVNz4x9Pw; Mon,  3 Jun
 2024 06:08:56 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
 epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
 56.CF.09561.6FD5D566; Mon,  3 Jun 2024 15:08:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20240603060854epcas1p207233f59828c47f31e941894634b9af7~VaZf1Drgl3264632646epcas1p2W;
 Mon,  3 Jun 2024 06:08:54 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240603060854epsmtrp1c4af37e97ddefdce08ea5a13501487a8~VaZf0Z0No2459724597epsmtrp1D;
 Mon,  3 Jun 2024 06:08:54 +0000 (GMT)
X-AuditID: b6c32a39-b63ff70000002559-5b-665d5df66603
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 93.39.18846.6FD5D566; Mon,  3 Jun 2024 15:08:54 +0900 (KST)
Received: from mk7kang01 (unknown [10.88.105.222]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20240603060854epsmtip22cb15fa19a515d82453f66df5da10cda~VaZfod-h82314223142epsmtip2I;
 Mon,  3 Jun 2024 06:08:54 +0000 (GMT)
From: "Minkyu Kang" <mk7.kang@samsung.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: Please pull u-boot-samsung master
Date: Mon, 3 Jun 2024 15:08:53 +0900
Message-ID: <166001dab57c$83114450$8933ccf0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Adq1V7GVWTPx1KALSIGKJ8Jz1MUdkw==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7bCmnu632Ng0g13T5CymTtrMbvF2bye7
 A5PHqwOr2D3O3tnBGMAUlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ib
 aqvk4hOg65aZAzRfSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgVqBXnJhbXJqX
 rpeXWmJlaGBgZApUmJCd8WvOD/aC90IVB9vXszcwvuPtYuTkkBAwkZh5cQdzFyMXh5DADkaJ
 pQcuMYEkhAQ+MUp8mFoJkQCyry/7xwLTcWjSbWaIop2MEudW10IUPWeUmPDnGztIgk1AS+Lv
 wvOsILaIgIHEloM7wGxhoPivC8/YQGwWARWJtav7wLbxClhKXH53mxHCFpQ4OfMJ2DJmAXmJ
 7W/nMEMsVpD4+XQZ1Ew9iUPvtzBC1IhIzO5sA3tBQmAdu8TSr1vYIRpcJF7/OAh1tbDEq+Mw
 cSmJl/1t7BANkxklJi16xgjhrGeUODzrAyNElbHEzfUbgNZxAK3QlFi/Sx9iG5/Eu689YGEJ
 AV6JjjYhiGoliQMXDkB1SkjMvr4dqsRD4sDPMkhgxUpsffaFdQKj/Cwkb85C8uYsJO/MQti7
 gJFlFaNYakFxbnpqsWGBKTyCk/NzNzGCk5uW5Q7G6W8/6B1iZOJgPMQowcGsJMLbVxedJsSb
 klhZlVqUH19UmpNafIjRFBjwE5mlRJPzgek1ryTe0MTSwMTMyMTC2NLYTEmc98yVslQhgfTE
 ktTs1NSC1CKYPiYOTqkGJs+DYmpTHmgYry7dVSM2LWTSmZ/zolU9Pksp6E1ksS0LaZx3Uei2
 2Dv3zOq7D44aGs9YYnfd5WnK7Q3vfjOszHhccJW9r06n5cm8ivdaZUz129d0XD1b0HSkW1zk
 ckBRbuvnOV91w7dqGtgsMQrdqTshUC78/BPfO0FbFu/0vSF8bJ1q5Yqr1XctmxT8u/e9qFDi
 cJpjLdh6+G+dGIOp2ReLyHb/3Uzv3ngs377VliP92Ey1myufrPn6WmPXkcW/Tkm9TpKPDbBs
 OTtlntIV8QWurG7Za58uvl4w9a3gdKufp07fvcB+KZFvlpjA9bfZdm6yZf+2VHuvZmlYLfKR
 1WLjr+bHF5M32jLsldYLfaLEUpyRaKjFXFScCABGSyES9wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsWy7bCSvO632Ng0g/kzOC2mTtrMbvF2bye7
 A5PHqwOr2D3O3tnBGMAUxWWTkpqTWZZapG+XwJXxa84P9oL3QhUH29ezNzC+4+1i5OSQEDCR
 ODTpNjOILSSwnVFi60M9iLiExKTZF5i6GDmAbGGJw4eLuxi5gEqeMkrsmr+bBaSGTUBL4u/C
 86wgtoiAkUTrhk4mEFsYKP7rwjM2EJtFQEVi7eo+sDivgKXE5Xe3GSFsQYmTM5+wgMxnFtCT
 aNsIFmYWkJfY/nYOM8QJChI/ny6DGq8ncej9FqgaEYnZnW3MExgFZiGZNAth0iwkk2Yh6VjA
 yLKKUTS1oDg3PTe5wFCvODG3uDQvXS85P3cTIzhQtYJ2MC5b/1fvECMTB+MhRgkOZiUR3r66
 6DQh3pTEyqrUovz4otKc1OJDjNIcLErivMo5nSlCAumJJanZqakFqUUwWSYOTqkGJrvKlZs2
 y+coqu/r3uOcKs0prvbyMefSKwt9Jk86qyWxxow7OTTw4P69R9g0Lh7Wcm/Y3xFo5sMd9phR
 cTnHlq+X+afIbxNvz78kcDfw3sn4pBWya1SEelM51zyJfxjc9eDh3YV+Om8WbCxsWLUw8x7T
 cbXk6laXBwU96ibuK/nu/FJpl+9dwF+w1jqceW7Rs85tV2ubP09cEbf546MVs/iTexMa1csC
 PGRyZwhmHclucu08YcBm/nM5b3y9/HsbhTcSp/Im7zx/82roVbNgC7ef5i1Pez2nfql/WtGc
 UqXvVnlh6sOTL5ctrnaoS7velaYcrdwjomju46rrw6z36NL91JUhkS1O/S7657yUWIozEg21
 mIuKEwEIjBVIwwIAAA==
X-CMS-MailID: 20240603060854epcas1p207233f59828c47f31e941894634b9af7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240603060854epcas1p207233f59828c47f31e941894634b9af7
References: <CGME20240603060854epcas1p207233f59828c47f31e941894634b9af7@epcas1p2.samsung.com>
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

Dear Tom,

The following changes since commit 46ff00bea5dd2dd247d5e2fdadbf5dcf8653cd9a:

  Merge tag 'tpm-master-27052024' of
https://source.denx.de/u-boot/custodians/u-boot-tpm (2024-05-27 08:56:02
-0600)

are available in the git repository at:

  46ff00bea5dd2dd247d5e2fdadbf5dcf8653cd9a 

for you to fetch changes up to 7045c4dd04648fd2ba1806b75e139d941db0d6c5:

  arm: exynos: Map iRAM APM area for Exynos850 SoC (2024-05-28 11:54:07
+0900)

----------------------------------------------------------------
Sam Protsenko (3):
      arm: exynos: Migrate E850-96 board to OF_UPSTREAM
      arm: dts: e850-96: Remove not needed bootph-all flags
      arm: exynos: Map iRAM APM area for Exynos850 SoC

 MAINTAINERS                                                 |   7 +-
 arch/arm/dts/Makefile                                       |   1 -
 arch/arm/dts/exynos850-e850-96-u-boot.dtsi                  |  28 --
 arch/arm/dts/exynos850-e850-96.dts                          | 273
-------------------
 arch/arm/dts/exynos850-pinctrl.dtsi                         | 663
----------------------------------------------
 arch/arm/dts/exynos850.dtsi                                 | 809
--------------------------------------------------------
 arch/arm/mach-exynos/Kconfig                                |   1 +
 arch/arm/mach-exynos/mmu-arm64.c                            |   8 +
 board/samsung/e850-96/MAINTAINERS                           |   1 -
 configs/e850-96_defconfig                                   |   2 +-
 doc/device-tree-bindings/clock/samsung,exynos850-clock.yaml | 307
---------------------
 doc/device-tree-bindings/soc/samsung/exynos-usi.yaml        | 162
------------
 include/dt-bindings/clock/exynos850.h                       | 337
-----------------------
 include/dt-bindings/soc/samsung,exynos-usi.h                |  17 --
 14 files changed, 11 insertions(+), 2605 deletions(-)
 delete mode 100644 arch/arm/dts/exynos850-e850-96.dts
 delete mode 100644 arch/arm/dts/exynos850-pinctrl.dtsi
 delete mode 100644 arch/arm/dts/exynos850.dtsi
 delete mode 100644
doc/device-tree-bindings/clock/samsung,exynos850-clock.yaml
 delete mode 100644 doc/device-tree-bindings/soc/samsung/exynos-usi.yaml
 delete mode 100644 include/dt-bindings/clock/exynos850.h
 delete mode 100644 include/dt-bindings/soc/samsung,exynos-usi.h

Thanks,
Minkyu Kang.


