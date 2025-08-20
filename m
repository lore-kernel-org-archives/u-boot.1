Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C79CA0EF8
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 21:11:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0B9A81FEE;
	Wed, 20 Aug 2025 23:11:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="mRryI4s3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B23D82F03; Wed, 20 Aug 2025 23:11:45 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65053801DD
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 23:11:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1755724302; x=1756329102; i=xypron.glpk@gmx.de;
 bh=ixW/Ms5RuvVMIC/Rt0mowbo9/fGhSot0yrha35Vrh/Y=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=mRryI4s3C2vklFhfzpe91V+JUgOFqnyAg5Q764o9VaBm7TWVTHhIi224KHVRYv2g
 y5eg9LpLeDvdfNa0KoW/cXV//yY95SbYlrH9GfQhnVeFqLyIyQ8i7FHpNVIJin0t1
 fAQcvSvo2CNN5U338zHjioUW7rlv4XEeODHQwMCQEq2ELsjavy9uCzu3XgiZPhRgy
 w3uvjB6STFD7Zb5uEDc3RcDXJ7+a6e1lf0lYFKb4GN40OepoTFHXCmqj/kkvHpbSi
 v30Pd1+K7V/OUVULp4ZoA9ILQvy0o4U1JiCsiWBO0bABAkPUyXK4YONPtb9yS28R0
 7KFwvLQpkqcPcoPYBw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.104] ([46.114.108.215]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPokD-1vAc6n1JP1-00NFYm; Wed, 20
 Aug 2025 23:11:42 +0200
Message-ID: <b8842289-20b6-4519-b104-f002e4e8daf8@gmx.de>
Date: Wed, 20 Aug 2025 23:11:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] doc: Ensure consistency of "buildman" (in the
 middle of a sentence) and "Buildman" (at the beggining of a sentence) in
 tools/buildman/buildman.rst
To: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
References: <20250810233742.51902-1-adrianocarvalho.pt@gmail.com>
 <20250810233742.51902-6-adrianocarvalho.pt@gmail.com>
Content-Language: en-US
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250810233742.51902-6-adrianocarvalho.pt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MVup2LiyPwLdIGobYdWhY3a2A9mY3OGNPUEiZjAQnHvU9negMV9
 AT9u5VQIQVwrkblh15hc9zJSKM9TCeYaCZt1Tfl+lSyCSAJTDUqg1xkYvH+47a+PrvpTdhw
 Hlf41CLPv6zvCwVNFi6My35cCylEugNwRaKS2Yzur316PNUN42YRB87CzhnmgJXcq4YA2pI
 cehFDPGZcB+YxlJg3sEYQ==
UI-OutboundReport: notjunk:1;M01:P0:saT7O1ZEFak=;Ceyyl8ydbPTxvOpJSKd9RgvsoM1
 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
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

On 11.08.25 01:37, Adriano Carvalho wrote:
> This pattern was prevalent (although not intirely) in the existing text.
>=20
> Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>

I agree that we should use the same capitalization everywhere.
But isn't Buildman a proper noun?

Best regards

Heinrich

> ---
>   tools/buildman/buildman.rst | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
> index 48938044520..d5d22732088 100644
> --- a/tools/buildman/buildman.rst
> +++ b/tools/buildman/buildman.rst
> @@ -119,7 +119,7 @@ them later using -se. Note that buildman will assume=
 that the source has
>   changed, and will build all specified boards in this case.
>  =20
>   Buildman is optimised for building many commits at once, for many boar=
ds.
> -On multi-core machines, Buildman is fast because it uses most of the
> +On multi-core machines, buildman is fast because it uses most of the
>   available CPU power. When it gets to the end, or if you are building j=
ust
>   a few commits or boards, it will be pretty slow. As a tip, if you don'=
t
>   plan to use your machine for anything else, you can use -T to increase=
 the
> @@ -1021,7 +1021,7 @@ cycle through various different configurations, on=
e per board built by the
>   thread. Variations in the configuration will force a rebuild of affect=
ed source
>   files when a thread switches between boards. Ideally, such buildman-in=
duced
>   rebuilds would not happen, thus allowing the build to operate as effic=
iently as
> -the build system and source changes allow. buildman's -P flag may be us=
ed to
> +the build system and source changes allow. Buildman's -P flag may be us=
ed to
>   enable this; -P causes each board to be built in a separate (board-spe=
cific)
>   directory, thus avoiding any buildman-induced configuration changes in=
 any
>   build directory.
> @@ -1130,10 +1130,10 @@ these when present in defconfig files and handle=
 the resuiting Kconfig
>   correctly. Thus it is possible to build a board which has a ``#include=
`` in the
>   defconfig file.
>  =20
> -For now, Buildman simply includes the files to produce a single output =
file,
> +For now, buildman simply includes the files to produce a single output =
file,
>   using the C preprocessor. It does not call the ``merge_config.sh`` scr=
ipt. The
>   redefined/redundant logic in that script could fairly easily be repeat=
ed in
> -Buildman, to detect potential problems. For now it is not clear that th=
is is
> +buildman, to detect potential problems. For now it is not clear that th=
is is
>   useful.
>  =20
>   To specify the C preprocessor to use, set the ``CPP`` environment vari=
able. The
> @@ -1144,7 +1144,7 @@ like::
>  =20
>       make qemu_riscv64_defconfig acpi.config
>  =20
> -This is partly because there is no way for Buildman to know which fragm=
ents are
> +This is partly because there is no way for buildman to know which fragm=
ents are
>   valid on which boards.
>  =20
>   Building with clang
> @@ -1301,7 +1301,7 @@ with -E, e.g. the migration warnings::
>      ...
>      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>  =20
> -When doing builds, Buildman's return code will reflect the overall resu=
lt::
> +When doing builds, buildman's return code will reflect the overall resu=
lt::
>  =20
>       0 (success)     No errors or warnings found
>       100             Errors found

