Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1931DEDE990
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 08:14:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F45C86CA7;
	Thu, 14 Sep 2023 10:14:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="HuXFQIrT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56C6D86D76; Thu, 14 Sep 2023 10:14:29 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6813486A6A
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 10:14:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1694679262; x=1695284062; i=xypron.glpk@gmx.de;
 bh=LFFlYSM+1qngS2A8SJ24eVT2YOO3Rb6buOJb61ruVRU=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=HuXFQIrTNj6IhvSo3B4u5u4ASRixkpgJ72iYno/yASRoNHpV3WsMaEJoiTA+RFMJUaGSGa555DW
 BpNPhh/JTPgUavVnRmxLpdBMMwHnxzuYlarc45/tCB0BYcAUg31pENwl8qePHYX+jabvntAlm+XSE
 npaJ4W1lEnrRmju0z1mQZP8p9lbpS9DtvL8EVfxfQTAm3DSraMYr+IyA5AERFE70M0tcKN+Ru5Wqy
 dzR6g7IMsrxn9wgGKXs5kwP7mE2cnDvb3yJ9NNyvTsraloUOlp9qFu7XhTOLsmF8b1lxbWEPOoDRr
 Pt0z/WGdq1HXAsEhbUJuHtSUm6BlVpoJHNbA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfHAH-1rM76r2qBn-00grCi; Thu, 14
 Sep 2023 10:14:22 +0200
Message-ID: <83d1e8ba-7b2f-4d78-aca0-43ccdc98ba8f@gmx.de>
Date: Thu, 14 Sep 2023 10:15:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] doc: add documentation for gen_compile_commands.py
Content-Language: en-US, de-DE
To: Joao Marcos Costa <jmcosta944@gmail.com>
Cc: trini@konsulko.com, sjg@chromium.org, antoningodard@pm.me,
 Y.Moog@phytec.de, u-boot@lists.denx.de
References: <20230902145310.107054-1-jmcosta944@gmail.com>
 <20230902145310.107054-7-jmcosta944@gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20230902145310.107054-7-jmcosta944@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Pmbcppn4Um4rmKY3XnDh9feinL8Nzmrv7y1Fr1wIKTkkUUnaxo9
 iz1UWDNko72PQFvLA3fwkl2MbeCnIFZLTEiM+NsL/6WIXoDNxsd4wOrqZ0yribW9cEqTm0O
 cwBaHNsA4LrbgQR8bMwZdYv93E4RSPm9aXHuk7ocMFZRKZHFai4K/A+evdMYMQMmOg+UEe4
 BfRHjlmltzy3UglASHyVA==
UI-OutboundReport: notjunk:1;M01:P0:9/7dby/WqTo=;zn88bJhSgHrPxUA2K/vRuHuH968
 v/smLPPvfNc3Y2o3Q9uwZDESLzcccqantY9+Lkm5DznLUAzc5riy5Jrf7R56WDFw8FuUJwwBc
 kjtlkcYriXCQWhoq9sGAw5QAlfQZVQQh30SkQDli1/7FbFribPvzs8HfOVlGlrWzsquSvAQ1J
 OmwlLi2CXU3QZl2VO+BnFI8ZZBAX8D6GQ/AzWAB1w9lanPO+LT3Sh/OW2JFHc6EkSgwdYGW2R
 mkOBPNY9uVSrq1WF8rXTfgBXQe2Nd2OoPdYRrBXxhsR4qAibsrKpB93QDWY7+m4sXWlrsfWRb
 U0WrAWB1lgYHf04sokFVhjJjQXLTB+z5vG/7NAKAtB4JhbUxLEaftEhIhUkJO5S/Z/1SBoPs0
 ZE/4F74RqDH/7xUHqiI1oZ9QcnNM2ktegcLmauRxwQPWewsMSDdPb1MQ86z0g8ufTKSLTT25U
 JRO30pveDSIrzSf+DtyxLR7s0w9s7fMWiDhqITEDDHk4xSwN5j/l0XKlNo43QeQpVOs+ipANZ
 ppoxUcfOyjWvjTopNlAvucglFwm4qX3UV+7jewFdjcCymhYemrqPZojllf/HbFbljF5dbpATG
 df9gKGf/yGF1obJacws5Qc3SjuPIduhlXtpqtgUQ66yn2RlwBuirKDcuRv3IQPgEVncwyKUQd
 e2ofaa+R1inJY9WXAVfE0qcckmP0pDWnA2ayPQXt5l+YLQwInWXKeV5/0yqTo/+gPm+XQUt7F
 sjtre5qH4VwpZj+R5jxO/dL99+2geiorDOKJX1V0s+ePNACGwrJIfESqTlGHmnNLSGxM3Dy1B
 idta0N2g3T9rjQ+iHm4JGVQByC+pjsPuVkRBy4mIZf+gYmEe4PN+oT9Y60nFUaNLsM8O3Mblf
 oH1fg2g9Jmi2OKL37NIKpaInI7Cq7Wb+FBxyn6Bv3EjiQg/2yIwW+Ft7tQ0dqgy910qbbRBEa
 c8OCsjVzATF7PdNogNw4PpNWC2M=
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

On 9/2/23 16:53, Joao Marcos Costa wrote:
> This documentation briefly explains what is a compilation database,
> and how to use the script to generate one.
>
> This is not a portage, as there was no original documentation in the
> Linux sources.
>
> Acknowledge the documentation in the script's header and in doc/build
> index.
>
> Signed-off-by: Joao Marcos Costa <jmcosta944@gmail.com>
> ---
>   doc/build/gen_compile_commands.rst | 46 ++++++++++++++++++++++++++++++
>   doc/build/index.rst                |  1 +
>   scripts/gen_compile_commands.py    |  1 +
>   3 files changed, 48 insertions(+)
>   create mode 100644 doc/build/gen_compile_commands.rst
>
> diff --git a/doc/build/gen_compile_commands.rst b/doc/build/gen_compile_=
commands.rst
> new file mode 100644
> index 0000000000..6b32eb678a
> --- /dev/null
> +++ b/doc/build/gen_compile_commands.rst
> @@ -0,0 +1,46 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Thanks for documenting the script.

This line is not needed.

> +gen_compile_commands
Nobody who is unaware of the script would know what this heading relates
too. How about:

'Create build data base for IDEs'

> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +gen_compile_commands (scripts/gen_compile_commands.py) is a script used=
 to
> +generate a compilation database (compile_commands.json). This database =
consists
> +of an array of "command objects" describing how each translation unit w=
as
> +compiled.
> +
> +Example::
> +
> +  {
> +  "command": "gcc -Wp,-MD,arch/x86/cpu/.lapic.o.d -nostdinc -isystem (.=
..)"
> +  "directory": "/home/jmcosta/u-boot",
> +  "file": "/home/jmcosta/u-boot/arch/x86/cpu/lapic.c"
> +  }
> +
> +Such information comes from parsing the respective .cmd file of each tr=
anslation
> +unit. In the previous example, that would be `arch/x86/cpu/.lapic.o.cmd=
`.
> +
> +The compilation database is quite useful for text editors (and IDEs) th=
at use
> +Clangd LSP. It allows jumping to definitions and declarations. Since it=
 relies

Given this information I would have no clue which IDE or editor you
might possibly refer to.

Please, indicate the IDEs and how they have to be set up to make use of
the generated file or where to find such information.

> +on parsing .cmd files, one needs to have a target (e.g. configs/xxx_def=
config)
> +built before running the script.

Does this imply references are inaccurate or missing once I have edited
files and not recompiled yet?

> +
> +Example::
> +
> +  make sandbox_defconfig
> +  make
> +  ./scripts/gen_compile_commands.py
> +
> +The database will be in the root of the repository. No further modifica=
tions are
> +needed for it to be usable by the LSP, unless you set a name for the da=
tabase
> +other than it's default one (compile_commands.json).
> +
> +Options
> +=3D=3D=3D=3D=3D=3D=3D
> +
> +For further details on how to use the script and its options, please re=
fer to
> +its help message, as in the example below.
> +
> +Help::

There is not much information in the online help. The online help refers
to 'kernel build' which seems wrong.

Please, provide an accurate description here.

Best regards

Heinrich

> +
> +  ./scripts/gen_compile_commands.py --help
> diff --git a/doc/build/index.rst b/doc/build/index.rst
> index 64e66491bd..7a4507b574 100644
> --- a/doc/build/index.rst
> +++ b/doc/build/index.rst
> @@ -14,3 +14,4 @@ Build U-Boot
>      tools
>      buildman
>      documentation
> +   gen_compile_commands
> diff --git a/scripts/gen_compile_commands.py b/scripts/gen_compile_comma=
nds.py
> index 1a9c49b34a..aa52e88e18 100755
> --- a/scripts/gen_compile_commands.py
> +++ b/scripts/gen_compile_commands.py
> @@ -5,6 +5,7 @@
>   #
>   # Author: Tom Roeder <tmroeder@google.com>
>   # Ported and modified for U-Boot by Joao Marcos Costa <jmcosta944@gmai=
l.com>
> +# Briefly documented at doc/build/gen_compile_commands.rst
>   #
>   """A tool for generating compile_commands.json in U-Boot."""
>

