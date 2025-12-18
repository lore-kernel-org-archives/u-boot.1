Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8311D6ACF7
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 12:04:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 550FE83D00;
	Thu, 18 Dec 2025 13:04:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="On4GZjLN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB488800AB; Thu, 18 Dec 2025 13:04:52 +0100 (CET)
Received: from mail-yx1-xb136.google.com (mail-yx1-xb136.google.com
 [IPv6:2607:f8b0:4864:20::b136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CBED83D00
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 13:04:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-6442e2dd8bbso548515d50.0
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 04:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766059489; x=1766664289; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SvBqQAbM8Gicwo6btOdJMrbOiCdF2oyIX5cnoKXjFI4=;
 b=On4GZjLNMudFo/ze21PADk9m15Cridfv2osV6aSvkPPnF8EvpIlXHOnaBISX1ygySY
 utSK+a4xxEqzMt0xNTsG/gB5DfVumaRdd+672fpK2AQyVqHG9Dar+uMfZLvfO+s7132o
 wNWcNNt2hJKFwYFZmJwtGkJcCCfe4/yxCrSdxqhFK+Fc9PBp+y7lJFdCXdUFuunrJGCW
 zHHuChfj/iJjGNO1PbJi8Zjf+rCJqpavm8lArtawuWcvIB9mIfB4lH++Y/KYCU6ktiyy
 fxNP9lulD2IrYo6o4wNJauJjVcg4jDVBxxHdXT3AOWF0M7BqltQlAwbw8JtOkvJgEoFZ
 wlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766059489; x=1766664289;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SvBqQAbM8Gicwo6btOdJMrbOiCdF2oyIX5cnoKXjFI4=;
 b=fmNpSnNI9XMvdIxbkV6pcmlW5cUFgBGKKVT+Ws47dkb3m09T4NcT03epKsuWSRO0rj
 kQkZ7fCX0Rq8NRPIiKp0OXLeGVZS1nN2me0My1ormBvDOwPIK5SzDQ+KXuZYzuOpqWWQ
 AoNPDDrDdjBRcLzZi5xd6L60oHrQhtoQtsua522nw/bWnv8zuoWZBlYkb6Y3NkWy9s1n
 z1j99vsWMyATjMlFxgSQ0lHg5a+j6Hq6S6RMDJVqdhU/0xKn3MDKviUw8/JzfTNZhQUg
 cADT9bbXocvtRj1V8Ip5+yVA0eWE8MtvVL8aheN5QDcJpVyHEcR/8WXwASNfFQR6moRC
 TxEQ==
X-Gm-Message-State: AOJu0Yy05edefuy1KkNpGi8V9zRG3J6EFO7LY/Sc9lSihwk0SOmMB6//
 MKibduWCumuFAmy6D+9YMjvbfI79mpnOLWuFlzQ1YfIJFph4yceBdQFTPYVH5i/gkoHvFGTT6Lo
 w/a/jO4+ojr5Eye5Xb7SmOI+uzhuWupll32lDRZmUaQ==
X-Gm-Gg: AY/fxX6mLSJ4nCEPY6SiIhfpYJMRgASENtFSRMaJONPtYL+V5whL87RJ81TmESm3LlA
 ek2CPxx6FHG8HfbjAvetuidSMhIXP6oMbQvdktkE0IJqwAxFtV59navC3AMscMNwnVdqzAMtHdL
 x4m/tu3u0wBHYoP9vHcSdruiOAlClfQLVLyMoP6VnQPs2nIaN3e0GFQCAPnMCZBsS2l4jMxGDtW
 0EF52bwOhxe95ZhbIuHIIf5nKfMR9n5xglshrkH6zQ9qLw85+LsGWug2S8ze3FoPFMQBJxJYDN/
 259RkEolVMjkdjRThvbZ4/ZpruGO5+P/+mgLdi+p6kRX9mJFviPBpLvo92Fm1nBdlD561e0rd+b
 uqhDyQb6zEc7nUTcZJFh0JoQlRvILXo8pxRoPsfOCz83gtehkohKVr+PbcbVxNzsaIdx4Gjt+XD
 2ZQsi/6pbc8PuO3OOlOE4FCsL1G28zayKOlm78asgy7hXU3JxGGgRicfUJSXKDZRBukRjLeAJK6
 /+Bx+EiX48gHQdDaqx6MHOd9h4pbIMIH7p10ucemDqWpb+56cHirSG4bBqSyfopHUobUr+x4CZC
 QLFGPNG1HPONGfY+7Z6CIhHEO7Uvi++V
X-Google-Smtp-Source: AGHT+IETu/6D3VBqh3Zf88+wEx7sEGFSFjQaAZeSCyiTFUJuSIEJJ0LvLgda9tJgooHpS35tc8Tv0E9fIhnlNN91QbQ=
X-Received: by 2002:a53:b60c:0:b0:63e:1943:ce49 with SMTP id
 956f58d0204a3-645555ee245mr12465516d50.39.1766059488681; Thu, 18 Dec 2025
 04:04:48 -0800 (PST)
MIME-Version: 1.0
References: <20251212-feature_fwumdata-v2-0-ad51572fbe79@bootlin.com>
In-Reply-To: <20251212-feature_fwumdata-v2-0-ad51572fbe79@bootlin.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 18 Dec 2025 14:04:12 +0200
X-Gm-Features: AQt7F2ruVYkO3L0QH35N53EUTWR-bKTc0KRd_iVsskuQPPDSRbRSbrExM07jHUM
Message-ID: <CAC_iWjLT1OJxADQ5bZaz_E7shWbGUJSnDQK7_dQM7agOKEvK0A@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Add support for fwumdata
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Greg Malysa <malysagreg@gmail.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Jerome Forissier <jerome.forissier@linaro.org>,
 =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Stefan Roese <stefan.roese@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Heiko Schocher <hs@nabladev.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 E Shattow <e@freeshell.de>, 
 Raymond Mao <raymondmaoca@gmail.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Shiji Yang <yangshiji66@outlook.com>, Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Yao Zi <ziyao@disroot.org>, 
 Leonard Anderweit <l.anderweit@phytec.de>
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

Hi Kory,

I haven't lost track of this, I'll try to have a look as soon as I can.
For the record, I still don't think this is a great idea. I'd rather
have people follow the design docs.
I understand the acceptance capsule feels 'weird', but there was a
good reason for it. There's a PR with an update to the spec, which
makes the acceptance substantially easier now that all the ecosystem
parts are in place [0[

[0] https://github.com/ARM-software/edge-iot-arch-guide/pull/21

Cheers
/Ilias

On Fri, 12 Dec 2025 at 18:23, Kory Maincent <kory.maincent@bootlin.com> wro=
te:
>
> Add a new fwumdata tool to allows users to read, display, and modify FWU
> (Firmware Update) metadata from Linux userspace. It provides functionalit=
y
> similar to fw_printenv/fw_setenv but for FWU metadata. Users can view
> metadata, change active/previous bank indices, modify bank states, and se=
t
> image acceptance flags. Configuration is done via fwumdata.config file.
>
> Made a few change to mkfwumdata tool along the way.
>
> Here is an output example
>
> $ ./fwumdata -l
> FWU Metadata:
>         Version:            2
>         Active Index:       0
>         Previous Index:     1
>         CRC32:              0x1f21ff7b
>         Metadata Size:      120 bytes
>         Descriptor Offset:  32
>         Bank States:
>                 Bank 0: accepted (0xfc)
>                 Bank 1: accepted (0xfc)
>
>         Firmware Store Descriptor:
>                 Number of Banks:       2
>                 Number of Images:      1
>                 Image Entry Size:      80
>                 Bank Info Entry Size:  24
>
>         Images:
>                 Image 0:
>                         Image Type GUID:  65ae85ad-1fb3-0b46-8c5d-285543a=
a6eab
>                         Location GUID:    51513491-da07-2a4f-9bea-375ea53=
b1b5c
>                         Banks:
>                                 Bank 0:
>                                         Image GUID:  cb2df442-f929-6a44-a=
374-672d92eb2aa7
>                                         Accepted:    yes (1)
>                                 Bank 1:
>                                         Image GUID:  a839a18f-395c-484f-8=
3b8-0354077c8f9f
>                                         Accepted:    yes (1)
>
> Changes in v2:
> - Fix a small offset mistake in last patch
>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> Kory Maincent (6):
>       tools: gitignore: Add mkfwumdata to the git ignore file
>       tools: Reorganize mkfwumdata tool into fwumdata_src directory
>       tools: mkfwumdata: Improve error message specificity
>       tools: mkfwumdata: Add bank count validation for FWU metadata v2
>       tools: Add support for fwumdata tool
>       tools: mkfwumdata: Remove dependency on fwu_mdata.h header
>
>  MAINTAINERS                           |   7 +-
>  doc/develop/uefi/fwu_updates.rst      |   4 +-
>  doc/fwumdata.1                        | 222 +++++++++
>  tools/.gitignore                      |   2 +
>  tools/Kconfig                         |   9 +-
>  tools/Makefile                        |   4 +-
>  tools/fwumdata_src/Kconfig            |  19 +
>  tools/fwumdata_src/fwumdata.c         | 854 ++++++++++++++++++++++++++++=
++++++
>  tools/fwumdata_src/fwumdata.config    |  33 ++
>  tools/fwumdata_src/fwumdata.h         | 138 ++++++
>  tools/fwumdata_src/fwumdata.mk        |  10 +
>  tools/{ =3D> fwumdata_src}/mkfwumdata.c | 106 ++---
>  12 files changed, 1315 insertions(+), 93 deletions(-)
> ---
> base-commit: 31bf4a1c308773895a8e7ea047b3cea037e4c922
> change-id: 20251107-feature_fwumdata-58508d61e1d3
>
> Best regards,
> --
> K=C3=B6ry Maincent, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com
>
