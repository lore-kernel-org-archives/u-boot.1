Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D806FC0032E
	for <u-boot@archiver.kernel.org>; Sat, 28 Oct 2023 10:07:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C9E087869;
	Sat, 28 Oct 2023 12:07:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="SifSDf0w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5600787869; Sat, 28 Oct 2023 12:07:52 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDF818783C
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 12:07:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1698487667; x=1699092467; i=xypron.glpk@gmx.de;
 bh=/FL5WQZ+iNXt92E0iZuHyln4FKIrD5flwif+dXWTzEg=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=SifSDf0weD7dGdsP89RpTrlmnjQUUTNOYIdMcUl2OXCRshvaOh1ZhO2xCNWq4vwo
 /4DsBw9RYdWEbBlE/tfDpDxSlq1ilRYVV7+XwVnUArofaP+bXO8yqhqmU9D5chWVN
 gEGlYVnc4i8BCq6xTF+NFrgKoU4viqpU7BeZNW9ZNuwJ0c5TAwKEtpzbx2TJdPpZO
 fZScqooKb7VoapCOch9kbZaqw4Nfflm665GuhNVgLomerLl/qDFvVXGqY5wArLlNX
 aBmb8K1PBs1xqHig0eVvv9bptuDw/hHZ4qSoUj3ZAwVm+uFmnAS4Ked0CibMlVy/z
 w4y0t85vQ6hx6knhKw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9FnZ-1qrz891o5X-006Lcg; Sat, 28
 Oct 2023 12:07:46 +0200
Message-ID: <a94380bd-bffc-4620-b08d-f149be97758b@gmx.de>
Date: Sat, 28 Oct 2023 12:07:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Pull request for tpm-next-27102023
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20231027112616.112555-1-ilias.apalodimas@linaro.org>
 <20231028005102.GF496310@bill-the-cat>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231028005102.GF496310@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:syUjwAlnG+n5oQWlcPqohq3Hv+SKQcHhwQJg8xomvNfQGbdzDTS
 SKgzb6jByKKKGFNDAw9csxTDwE1fI1MUSysgRmgIFMoVNzS+Y43WEbk0KCoglCci2d/WRa6
 M8hqHgs9mYjrNrRJJAn+3CzxIgEWBSp8xrnbcMWy7CQtF3KW/gUy3zYvIGYVVZU0jiTWJh+
 /K+PWmGhA6MhZTDH/Vhvw==
UI-OutboundReport: notjunk:1;M01:P0:/HQvozO9m90=;DflGrSriSCmQQPcijNrW+L2gmLg
 HwMbfnOx5X8witOEevaKat2cA3gQVF71Ybq/gGZro/0XOcV8ot33Zrg2MXgK6i3AaTvWkNq56
 55FfcCEBzYby0oXWfy58uGrHnKgzeKI84tdXML+jNHEml3SHS/0S1ejyEnuwi/uTlFHIuTwEb
 I8arPitZpj/2RZM/1JKAUOOmrlV4JHXZvd3Ih/YbAKrurtBAXCRQUoi/YRqlclA5P1jOR6SRg
 5jWCOTyJ7tWcbekFcA4eArCbVBywLPPSNfOeqn5nf9t6/QldxDkXuc2R8SyrJW7dxoR1XQjiV
 evemyTOrLF3CmY347R5wYkXaqWRkF6WTwqM3Slx8LQXEr/CP3WW4bR9Kolfv7jmkQtOOGn9WV
 giP9aao3V1MFEMHjxx91lNRu+OsFxe1TVzrfb2ngBcoUEsfaqalLZvN74QAG9nq+LNJaZidMY
 qsCHKLqxc79llv8IR+A6KtaOfN58I4TQ6RZGzL/mtmChEAx1xbIoQGSjV9FvLH16DlrpnuGGg
 k2bWOuZ05hBxdC4S09QSIKO+q27wKuUUPWVblNRhy0R2ptS6TggG10h2Ldin9zBTG8jdKsYlu
 gThfRECpWwRazbSrSNJ64Z8ly8Pmrs4Z4xJeBXi4TUCbqszEOdlAcyVxavbQ6SsSmW3JykxeG
 Al+4LUNbRB+g6cCWxmLFftJn0rEINnf2DzDwleakhDa+8G+/eGusd6PGHLh2k+BT2+H9fKeFb
 E3NhQhqu7w0x+IZdII2u/EPRHCqQ24qvVWmQlDGs72EAyDO6c33JAu04GCfgjqD2lGF4nkrSE
 /v
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

On 10/28/23 02:51, Tom Rini wrote:
> On Fri, Oct 27, 2023 at 02:26:16PM +0300, Ilias Apalodimas wrote:
>> Hi Tom,
>
>> The following changes since commit e29b932aa07fa0226d325b35d96cd4eea037=
0129:
>>
>>    Merge branch '2023-09-30-Kconfig-updates' into next (2023-10-01 11:5=
4:31 -0400)
>>
>> are available in the Git repository at:
>>
>>    https://source.denx.de/u-boot/custodians/u-boot-tpm/ tags/tpm-next-2=
7102023
>>
>> for you to fetch changes up to 4fd7d27ccb763ce8b836a0e4c5dd005392d38e18=
:
>>
>>    test/py: always use autostart on tpm2 selftests (2023-10-27 13:17:21=
 +0300)
>>
>> The pipeline https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipe=
lines/18327
>> showed had no red lights.
>
> Heinrich, I see that the docs job passed.  But I see:
> +++ b/doc/usage/measured_boot.rst
> @@ -0,0 +1,31 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +Measured Boot
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

If I make the underline too short I get an error:

Warning, treated as error:
doc/usage/measured_boot.rst:4:Title underline too short.

Measured Boot
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The message is created in
lib/python3.11/site-packages/docutils/parsers/rst/states.py:2750:
         msg =3D self.reporter.warning('Title underline too short.',

docutils does not create warnings for title lines that are too long.

I have sent a patch fixing our documentation:

https://lore.kernel.org/u-boot/20231028100312.20623-1-heinrich.schuchardt@=
canonical.com/T/#u

Best regards

Heinrich
