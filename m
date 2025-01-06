Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC1FCE77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 14:38:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E42F801E8;
	Mon,  6 Jan 2025 15:38:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Wx6tIFb9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C67FA8056D; Mon,  6 Jan 2025 15:38:53 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 937D9801DE
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:38:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aabfb33aff8so2583416066b.0
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736174331; x=1736779131; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BWsEq/5uHBdSJs3IX1EuoTc9/xCB5pnTaEILxEMuLjE=;
 b=Wx6tIFb9whf3Ta/Ssfa+50nNCmO8E8T3fTmV7+MoEJpPkmjmjd2lqv4LiinKe/xh8X
 P9QxYDh/2mGgD6i0O2Cx719j2oS8ZwJqhOlUxwwCNCA9iRJvoguwZR0VF8CzAfKERmX3
 S7+MSEjk4sq9ee52zFWI+P07kZ49zfs4DNNtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736174331; x=1736779131;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BWsEq/5uHBdSJs3IX1EuoTc9/xCB5pnTaEILxEMuLjE=;
 b=jiRGfVbVgOkInOjeGHIAfkKT4IQWejX2RrnjMkbAT7M/8XYsuViqY+jstc6tahlSkr
 yVLuJqUxdofGiuTKh2XbhVsiAAfjv10XJngYI3qm/C1uXHjO8E11Ct4SumkHILZ1XwGF
 PIm6Y5wfMzrcE10MoU1Q9ELDizthAW2u6vU8iKEjkJVig2kX1MvdljT2+rdrBXfzEO+o
 oLa7hAVdxVNT4sorH7qut8I2XuPZKigkD2HsFvCQltDB3wuK9gTvpcWqSjQycZ3ogkxG
 UkdtD7mxGb3FMkhcOTrJ59evuNT6BjZ4gcBbyXNCLoepgd7YqDr4s6j4QYEuSj2GMMo7
 p0Gw==
X-Gm-Message-State: AOJu0YyGz0X4184CKwTjHM/v5YSdz9/btIcyPmdPkRWNYbloZlcs9TPh
 ezDUoStcYHMfdk3IfnA4VBI7WtDFgXBu7coEqafvsyLtzrUhnGfCOw3XUhGZ1OiXRM2kAU3J5aO
 9il+QFT8FEl1cydBrIwINRO4BwrsbyQb90a1V
X-Gm-Gg: ASbGncsT11a4J5DHjp1r+HOGw7xWsTeRxkciLRFFYLXTsd+3rFVBWb24XINUOzT4MED
 V1tpNEttbkFtljt6lg71W1nZjfWuABPP+xXUxO/E=
X-Google-Smtp-Source: AGHT+IEJV2zUoC2fnFrCPfftlPnNP/rogLcH1Hflv7OOGCUYKVY4yyBVKt6ZXR+HJ6rcLWXScY+n/HO/KnsNRYHUbEU=
X-Received: by 2002:a17:906:6a11:b0:aa6:bcc2:3f02 with SMTP id
 a640c23a62f3a-aac349cb491mr4544362966b.29.1736174329491; Mon, 06 Jan 2025
 06:38:49 -0800 (PST)
MIME-Version: 1.0
References: <20250105203714.158480-1-marex@denx.de>
In-Reply-To: <20250105203714.158480-1-marex@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 6 Jan 2025 07:38:38 -0700
Message-ID: <CAFLszThQvKZfwsQudbOfDvnCMe=aeY=ppUhHKj6nV8=PtadDaA@mail.gmail.com>
Subject: Re: [PATCH] binman: Fill in most of the imx8mimage and imx8mcst tests
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Brian Ruley <brian.ruley@gehealthcare.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Marek,

On Sun, 5 Jan 2025 at 13:37, Marek Vasut <marex@denx.de> wrote:
>
> Rename the test .dts and tests and include the M suffix to indicate
> those tests are for i.MX8M, not for i.MX8, which is a different SoC.
>
> Update 339_nxp_imx8m.dts, add testNxpImx8MImageMkimageMissing and
> update nxp_imx8mimage.py test to bring nxp_imx8mimage test to 100% .
>
> Add 343..345_nxp_imx8m.dts, add matching tests and update nxp_imx8mcst.py
> to bring CST tests to 97% . It is not clear how to test the CST output
> file to reach 100%.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Brian Ruley <brian.ruley@gehealthcare.com>
> Cc: Paul HENRYS <paul.henrys_ext@softathome.com>
> Cc: Rasmus Villemoes <ravi@prevas.dk>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tim Harvey <tharvey@gateworks.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  tools/binman/etype/nxp_imx8mcst.py            |  4 --
>  tools/binman/etype/nxp_imx8mimage.py          |  4 --
>  tools/binman/ftest.py                         | 42 +++++++++++++++++--
>  .../{339_nxp_imx8.dts =3D> 339_nxp_imx8m.dts}   |  3 ++
>  tools/binman/test/343_nxp_imx8m.dts           | 26 ++++++++++++
>  tools/binman/test/344_nxp_imx8m.dts           | 28 +++++++++++++
>  tools/binman/test/345_nxp_imx8m.dts           | 19 +++++++++
>  7 files changed, 115 insertions(+), 11 deletions(-)
>  rename tools/binman/test/{339_nxp_imx8.dts =3D> 339_nxp_imx8m.dts} (93%)
>  create mode 100644 tools/binman/test/343_nxp_imx8m.dts
>  create mode 100644 tools/binman/test/344_nxp_imx8m.dts
>  create mode 100644 tools/binman/test/345_nxp_imx8m.dts
>

Thanks for looking at this! For me I get an error when applying to -next:

$binman test
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Ru=
nning binman tests =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
...........................................................................=
...........................................................................=
...........................................................................=
...........................................E...............................=
.E.................................E.......................................=
...........................................................................=
...E.......................................................................=
........................................................
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ERROR: binman.ftest.TestFunctional.testNxpImx8MCSTSPL (subunit.RemotedTestC=
ase)
binman.ftest.TestFunctional.testNxpImx8MCSTSPL
----------------------------------------------------------------------
testtools.testresult.real._StringException: Traceback (most recent call las=
t):
ValueError: Error 1 running 'cst -i
/tmp/binman.kv3d4uif/nxp.csf-config-txt.nxp-imx8mcst -o
/tmp/binman.kv3d4uif/nxp.csf-output-blob.nxp-imx8mcst': Install SRK
File not present SRK_1_2_3_4_table.bin


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ERROR: binman.ftest.TestFunctional.testNxpImx8MCSTFIT (subunit.RemotedTestC=
ase)
binman.ftest.TestFunctional.testNxpImx8MCSTFIT
----------------------------------------------------------------------
testtools.testresult.real._StringException: Traceback (most recent call las=
t):
ValueError: Error 1 running 'cst -i
/tmp/binman.jh5hnl3s/nxp.csf-config-txt.nxp-imx8mcst -o
/tmp/binman.jh5hnl3s/nxp.csf-output-blob.nxp-imx8mcst': Install SRK
File not present SRK_1_2_3_4_table.bin


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ERROR: binman.ftest.TestFunctional.testSimpleFitEncryptedData
(subunit.RemotedTestCase)
binman.ftest.TestFunctional.testSimpleFitEncryptedData
----------------------------------------------------------------------
testtools.testresult.real._StringException: Traceback (most recent call las=
t):
KeyError: 'iv'


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ERROR: binman.ftest.TestFunctional.testNxpImx8MCSTMkimageMissing
(subunit.RemotedTestCase)
binman.ftest.TestFunctional.testNxpImx8MCSTMkimageMissing
----------------------------------------------------------------------
testtools.testresult.real._StringException: Traceback (most recent call las=
t):
struct.error: unpack requires a buffer of 4 bytes


----------------------------------------------------------------------
Ran 581 tests in 1.784s

FAILED (errors=3D4)


I wonder if the cst needs to be updated (binman tool -f cst)? At
present it is using apt-get and has:

$ dpkg -l imx-code-signing-tool
Desired=3DUnknown/Install/Remove/Purge/Hold
| Status=3DNot/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Trig=
-pend
|/ Err?=3D(none)/Reinst-required (Status,Err: uppercase=3Dbad)
||/ Name                  Version             Architecture Description
+++-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ii  imx-code-signing-tool 3.3.1+dfsg-2ubuntu1 amd64        code
signing tool for i.MX platform

Regards,
SImon
