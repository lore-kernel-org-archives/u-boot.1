Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14509C2D0CD
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 12:37:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7E1182F6F;
	Wed, 21 May 2025 14:36:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=yahoo.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=yahoo.com header.i=@yahoo.com header.b="ZFJ0MMCs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3120F82E81; Wed, 21 May 2025 12:27:28 +0200 (CEST)
Received: from sonic315-49.consmr.mail.ne1.yahoo.com
 (sonic315-49.consmr.mail.ne1.yahoo.com [66.163.190.175])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06DDA82E2D
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 12:27:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=skorpyon1992@yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1747823243; bh=rxxEimmvs74fl/SejBArbCWSataac5FdIO/YkgzSY54=;
 h=Date:From:To:Subject:References:From:Subject:Reply-To;
 b=ZFJ0MMCsh4fitfiYlaak/eOkfSeW5kUshQ9sqn9mZycAwZ7bNf4vyRDfc/xqcAc1NKcHb6whsA0hxXMNrvmZ9VuBUoqtNudlNcOsiAb0nwbsDwsAWEIjFA/RdmXzX493x6WXm+t4qJYLZ91Cp/lD7S3AO4Y4/W94Pw2HzhGwHMMFOHcHx5WMvhSL8JP2MxWqGsAUWUeTQBlO7ALZ4WQHK/EUjk5CE3ULCzgC/1Amn8UcTlmF4gw5XUkRGTpL+YEaTzuUUYH+AAJeo0rAe1PHWwVt13HY5LUZW2OfzAdGG5D9waxVLp+wyI/ranovywhn9gfnzVjclpm+fTCvxMh5tg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1747823243; bh=5U6pJbDX9mnTPWvV3ok+MgYU7ZD3yHsNsf7jW2lmM3p=;
 h=X-Sonic-MF:Date:From:To:Subject:From:Subject;
 b=HAXCV/Dutt7fJmqxAPb/GGdanSIZgiIf5PJZ1QB51XlpXbLfTC7xDOKW2sHO+C0y0xm4gP/ZO4WNrlWyw1uPoxJis4tSBmaFEc47O1gjqGY6mD9gbqjsPW5QdvCXFaeJQQndkYA2AQhjDYDVftPUMBwK9/OYuIl/Q84Lr9r+SlbgIWx1FOP6WzBJg1XxAjt9awBsfUskIczFplLmBlbzFwNqsciykkyh6xCJBxuBNf9Z65HDfQSOPTmglMsAIcSk9zxsn2irlSZUBnSQ9XZfjEhicsXUswfSReBgRy8kDeu0YCtKPfhYZmWhWOxBwpHyDh0QhgqLFOw1bRgEDUQSGA==
X-YMail-OSG: NnxZi_IVM1klMu9UocTDgmZ4xo5ISok6RenXEpv41x37sR.epWHEPlJ1IdgBJFo
 n5NpHSzP2Gn2O5CZ10ZeLF2YeBw8HaXOQSFjuLCZlLBVdnbyAb81Fh.PA83tSHszuMR6Zd0ucuPl
 hDFr5ixocNOrI5xEWpoWQELaLJm1UJtl4VKzoYJsfIF7_VXeHI9WS47QrgWSXp0GoP4wHgqQ5.4g
 GzDZ7_T46C5kHDLiWxnvc7R4qzcfFdNu_U.KydjPVws.T_aH4VlNb3bgrWtisvmC0ijJyyY7GvTz
 WxT7T5q2Nnnr6JEABj3bE55SCHjNdK8KRWda.3WAjsmmvWhO9wtaa7m.H9ahYpSZgn_.y6EvgF_b
 WwGwin66gfYxAup6KOR7HUtibNXum_4a0Bkc_b0_QBr8Ro_9xSQgP4HOVthumETJD.TUfHTHXaa1
 tIskEXpJ2Ihb30e4oCgIplXQ8NFg9VjYKAHklpiA32BJvcC_xB3R5v9UePh3MY_yVJZv42mJ2hW4
 ah9XTOOv.6k4qIF2bLORbwGUFydgdNMTOZ7d7UoO0LkIW0o0FtJnayFYSHp1KpoUI9msUClmRA1m
 rgZ5lOwPXTO3o99SmnJELzYXF8XBNAMcNAcSSqvMLBbLnPrRYH3VwQ3sNXv9IwaOk1NuDTGrPkU7
 wY33ypRiXMJKpnGriExCQoIOmjbik0au7AHviT3KOGk9g9p9V0b2elf7fIgT5i.ZJRlGwrvDC7jE
 3QUUuYXNNGekoGsIxNXhIAxgsl5FELXrWoaFc9kRCQooMIfWPMxl0MKQU_HWK2xAgFTHiTyEOMSF
 DvJg8WaqKEqL8eZrZWcqxFt4xjKbGZ1Jc39_SyB24JsCRjWE9eZr_ORDIU4Va8.zoypyDTZwo2VN
 kTBcQHHgs08r37aKGjQTT_OpFibMLnShyCSrXeTh_r2kf9OfP_DbB2D7mO0jW4svd5JwIJbqGA22
 cdNo7TYuLVGJlzVE3P7vsRvu8T1vyO.atgfMCJseU26FjvW.NiosQEoL.gnRdKkYTToOLwcy8YuV
 EGJyQOdZt0Go0JjhNcrnaoOH8JyiQMfruIbZo5Pe.w_49MbtEj3Nmmjnrh_GIAgP28qBWNJym3mc
 BnNOVUgLktCy0y8bbJmaSNkvWlKVTYDZecR4ze9Lf0QRDqeicQEia2G3VrKzu.k.NFkY88Wyqd03
 EsST6K60L6cjeJKTYPZ0fzOWyNcMuooAryA4sJpg76sLGyqk4x7Fvd8hS3PwbICrm9jOi7UiZfxF
 XUtOX_s03.BLaZJk6xGXixEUB8JY3qXZ_NvFIXKeJlTfse1oGaJwd8WzW6kDQ8TMvYyflS5TMQ4r
 hpLcBFB0fmV51LFAAHJS6aBGP30XHu4weO1e2VwgOY5mhXVeKIkW6IMnVjlI.6Bm.TuBWiswVqnr
 qFKdloKvV3eVBuhuCAD5nYPvuDE7ieJe6efZLLhHy1QawJ1f_wkzm4vHkdUJLGLTbHjIh6TYfZU6
 97eGGIvYfYNnIEN6SCXBo5gRnuWTbxN8Ku.Za7x9WsOUPQCKKN8nQtRBgzLMx0uAUiolgX0fgm_L
 sZa.F6BEJ9QDqrOaY7IZkXDpr00tWITkpYYOiW4rxmYY8gSHTZem_4tmvzF_w0G7856.QtbkAmzK
 6fdikJ7F9RcBMJKV8JlDd4cbE6F.h3Sb1GOx3FwWh7KCqTceStj.8yzbSXEhR11tB4uxM7.ofpx9
 PFnNnAjwvnR3dSreRkGs5aZ9pjCJTx_mwRU8oQ4RvCmJsj41UuWjU.cgmprMYIvHTQYFrMbK_IbA
 8L6gcB7tPjRppjkxXhSkDZbkQqU1wd_AHe_ZtyIIt4nXZuoaZDSDn0Yzp3Mva1VX.tY69J9Pr0Bj
 j88WhBFh80SRB6WGcMga6X9COXvnKpYlShtsES68osWG9MD8TllP4VtBuGo4JK_9caqLU3xba5eY
 57KERHgeAa9ohkqoRLPbwj9CKuuPsJ9kSHIIythJAlN9.EhN1zxPK6obQnwevbOp5usQo0WcHloe
 EAXkUzz1iqlSwNxAXhXdvGLnNxbH5j7CnAlayD3bJ8ArZwkAs2QAAyP.Nnuty3nDO6SEhWyYqWNC
 0vxQQkDYindSZwt9gpClOmXfOs_eutVhvhxxGWelwebvpXG0T4hkylrC5M87AewTEm70eyU.RXuW
 o41x9UYxvUoRSD3ZHXj43k32C3PndQSPuSmqWDCLVv0XJVzvwjKVpkzzFuXL_D5Bq7AP9Ssmk9js
 BSScDNdmIk2cxBknnnoYFgZqJmP1PLMo8NbsEZDctIc8gFRmuPzE-
X-Sonic-MF: <skorpyon1992@yahoo.com>
X-Sonic-ID: 1df36357-9ddf-4aba-989d-3fd50f46f78b
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic315.consmr.mail.ne1.yahoo.com with HTTP; Wed, 21 May 2025 10:27:23 +0000
Date: Wed, 21 May 2025 10:25:22 +0000 (UTC)
From: Valentina Skorpion <skorpyon1992@yahoo.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Message-ID: <1495046231.2955539.1747823122875@mail.yahoo.com>
Subject: Save sspi output bytes in variable
MIME-Version: 1.0
References: <1495046231.2955539.1747823122875.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.23840 YMailNorrin
X-Mailman-Approved-At: Wed, 21 May 2025 14:36:46 +0200
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Hello all,
=C2=A0I am using uboot 2024.07 on a Verdin imx8mp board and would like to s=
ave the output of the result (the bytes) into a variable.We have developed =
an spi peripheral that would retrieve us value that we would use further in=
 the boot process (we would parse the spi output and set proper boot partit=
ion and devnum in u-boot-initial-env).For example :=20
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Verdin iMX8MP # sspi 1:0.0 =
16 00
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0AA03
=C2=A0 How can I save in variable the result in hex (AA03 in such case), or=
 if there is a way to do it in u-boot-initial-env ? I have seen so far only=
 scripts and if statements that looks at the return code , but not the outp=
ut on the console.=C2=A0 Many thanks!
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Best regards,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Valentina.

