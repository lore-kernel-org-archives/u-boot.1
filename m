Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF02D11196
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 23:25:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DCDD88F12;
	Mon,  4 Nov 2024 00:25:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ZjwgGc6y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71AF988F33; Mon,  4 Nov 2024 00:25:10 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 259E7888EB
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 00:25:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730676300; x=1731281100; i=xypron.glpk@gmx.de;
 bh=Q/qoTHEIBocscNIoN8KG5vF/OQoWfZj5m79EX43C4zM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ZjwgGc6yCbAYLk4oI0ll2oNDQQW5GFmtFgmF2j1aJmeCIy1f5cUzK0970ZGTWowf
 VTlzbo7bPBWMuev6Ye8/QtJJ41muT5MrKj+0IKbA47JSUyLD1jKe2U/+uivhCHZhe
 +7Z3mYsFA0sCr51mq6Lus6aDOEzTTDKCUyhwXLDLEn/CLcKwLwbQc0B9Dz55fpdo2
 eW9pmSytO25iBRU8NBa2nfBKLRRuriju4uc01+pdUFIxEbQO858IyO1yCtXK9pfdp
 d3UwRP+K3ydySDwhvoCxtgEQGrAVTKzm5YBhCWYudZVG+93IZZcOawnzyBG3FcmXP
 Wy5xzED9s/ocLJvhCA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.105.238]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MORAa-1tTHE22A9O-00KeH4; Mon, 04
 Nov 2024 00:25:00 +0100
Message-ID: <47ada0aa-97fe-4c0a-a662-4b184175a17f@gmx.de>
Date: Mon, 4 Nov 2024 00:24:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/15] doc: sandbox: Add docs for the sb command
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241028124815.47262-1-sjg@chromium.org>
 <20241028124815.47262-6-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241028124815.47262-6-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ctG2jFREuZNPPyN9jQY/nFI5wcLNSI/+pW8zyPYA9VupXV8lE76
 tNFq8d01Dan0wBmnQxLIe7CC58Uv9AZJZ32PN6PjjX8sQjxLu9OjgawrbyRLAMDj2SpWxlp
 H2AlXKZru4Lp1XfPFU+yjjX9qM5/qIbXj3pbP4od37shK5TOpFgdJDjyPo5MvLp2TOZa6Z6
 uPKErz560OrTCPwCMwDzQ==
UI-OutboundReport: notjunk:1;M01:P0:ji51Qj0vt48=;6jASuLkGyZdCVyKZUDSyuAcHYJK
 GNAZ6xoWKWBwtGD0334CkgtlWG9q+OJ7fHrIpe2/sKie8WzHuCBbd8TWe/aD8oKCWHXJljNQ0
 wgOT8E8zep3LnQTyWPKP12bSoi37QWHOee72QfebCyGhy2uOV8LI97Eir+anKzLjT4K/gdHV1
 nqCYrL5B8eRSOqvOWCAP1vmpeqsmFwUL+x+bZGLvZ360pFjHkfAMW3Fysp5hxN5UH0oypu/C0
 mfYZ18ctRtrPdMsH7CQdFoWPj56XpTimSU5OGEvdZkjw01BxrqEXqdhVOerSs0/tpCn27Bzsm
 RC7RqfVBm8ECvlwMocOC5ex1Krffq4Emu5awZUrwa29KRnTp22I4V0/RxZ5LLRFrik8rNKrAi
 FAsSt0WsdHHVX+b7vtCwhHd5dHDJVDffJPGuWl75fLryR5gJ7yYmmCiD1BM2IqHkZ/gB4luS9
 MZ+V8i1ARS585NTkHuLr4hzA5af74Zcu7X49fEyqG6KsDWj07oW8ZADdCXzC1PeKpkAtpaNN9
 xIEpJxoEMLClUGRVmmdN2vo79+fUgyoaK2TrDOPwbMLSWziOn3edRcP8Hqvu/9WXwlnn1BseH
 Er0rPk7LB1SEJIM87UzcyuBQz0LTNaGlSPNii1MphHYjnL07qz1b/1IxLP+8gMLABwaNzw1Xd
 m8SzCRctNtiGAFUOdJCWb+PuffHE880BuTC+BPa99EYtQ45+KVldo0U5tqhondYCj0eZFZH9E
 br/7moeHdsATz7sgTFqr3wEe/PF4U5xjMqgEO6TjBqGTo6+r7b9XC+ZcM3uVQHXEx5Ku683Bf
 ObPgXo5QVrMjtzs4+x4aR7Pg==
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

On 10/28/24 13:47, Simon Glass wrote:
> This command has a few small features, so document it.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>   doc/usage/cmd/sb.rst | 54 ++++++++++++++++++++++++++++++++++++++++++++
>   doc/usage/index.rst  |  1 +
>   2 files changed, 55 insertions(+)
>   create mode 100644 doc/usage/cmd/sb.rst
>
> diff --git a/doc/usage/cmd/sb.rst b/doc/usage/cmd/sb.rst
> new file mode 100644
> index 00000000000..6f54f9d9eb7
> --- /dev/null
> +++ b/doc/usage/cmd/sb.rst
> @@ -0,0 +1,54 @@
> +.. SPDX-License-Identifier: GPL-2.0+

Please, use a valid SPDX identifier. See here

https://spdx.org/licenses/GPL-2.0-or-later.html

> +
> +.. index::
> +   single: sbi (command)

The sbi command is used to show the status of the RISC-V SBI firmware.
You wanted to describe the sb command?

> +
> +sbi command

ditto

> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Synopsis
> +--------
> +
> +::
> +
> +    sb handoff
> +    sb state
> +
> +Description
> +-----------
> +
> +The *sb* command is used to display information about sandbox's interna=
l
> +operation. See :doc:`/arch/sandbox/index` for more information.

The command can only show states and not any operation.

%s/operation/operational state/ ?

> +
> +sb handoff
> +~~~~~~~~~~
> +
> +This shows information about any handoff information received from SPL.=
 If
> +U-Boot is started from an SPL build, it shows a valid magic number.
> +
> +sb state
> +~~~~~~~~
> +
> +This shows basic information about the sandbox state, currently just th=
e
> +command-line with which sandbox was started.
> +
> +Example
> +-------
> +
> +This shows checking for the presence of SPL-handoff information. For th=
is to
> +work, ``u-boot-spl`` must be run, with build that enables ``CONFIG_SPL`=
`, such
> +as ``sandbox_spl``::
> +
> +    =3D> sb handoff
> +    SPL handoff magic 14f93c7b

As a user I would have no clue what this magic is used for. This needs
some explanation. Why should I care for some random number?

Is this really sandbox only information?

I would be much more interested what information is passed in general
from SPL.

> +
> +This shows output from the *sb state* subcommand::
> +
> +    =3D> sb state
> +    Arguments:
> +    /tmp/b/sandbox/u-boot -D

Please, remove /tmp/b/sandbox. I would expect the average user to invoke
the sandbox from the build directory:

./u-boot -D

> +
> +Configuration
> +-------------
> +
> +The *sb handoff* command is only supported if CONFIG_HANDOFF is enabled=
.

What enables the sb command?

Why do we need two sub-commands to show so little information?

It would be much easier to simply type 'sb' and get all the information.

If you there is so little information of interest, why don't you simply
implement arch_print_bdinfo() like you did on x86?

Best regards

Heinrich

> diff --git a/doc/usage/index.rst b/doc/usage/index.rst
> index db71711c393..24b2d2637b1 100644
> --- a/doc/usage/index.rst
> +++ b/doc/usage/index.rst
> @@ -103,6 +103,7 @@ Shell commands
>      cmd/reset
>      cmd/rng
>      cmd/saves
> +   cmd/sb
>      cmd/sbi
>      cmd/scmi
>      cmd/scp03

