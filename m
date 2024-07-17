Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95625C3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 14:35:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 366698867B;
	Wed, 17 Jul 2024 16:34:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="EymQlFMK";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="UnUIndBd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7691188AC2; Wed, 17 Jul 2024 16:34:44 +0200 (CEST)
Received: from fhigh4-smtp.messagingengine.com
 (fhigh4-smtp.messagingengine.com [103.168.172.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F03288ABD
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 16:34:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 7D8C21140087;
 Wed, 17 Jul 2024 10:34:41 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute4.internal (MEProxy); Wed, 17 Jul 2024 10:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1721226881;
 x=1721313281; bh=wa2q5/HvT7czyERmjRYWLBPhjluHXfssahIGe2H1keU=; b=
 EymQlFMKwfDHlGK/hSlEVg2CbBFG+uYMgIjGPea2RQ5mA79IKbipnvrNiNVLqfYx
 /WEaALNt4W/2WIACEH8r5mo099JdMYl//S63LUp0CwWqf+9Chds+SMWjYYPG6vpb
 Pj9chbhMaTs+EYS6zCYJAKsSg2RPcXHwjESyysyjkmTK64pxMFP44At9P445dHtY
 hAR2G8djJRFbqIVSZ8mVUoEkSZrLefYYa84riFwDLTUDtqdwWFwYi8UnJECtYn0a
 wEq2qRmkrGGUDfg9GRGziZTaViT6LQP1AUUoE1NZ+ddgTeRzJEjcc2DSl2TTkDM3
 A11XomwmmbWf2x8BAcwM6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721226881; x=
 1721313281; bh=wa2q5/HvT7czyERmjRYWLBPhjluHXfssahIGe2H1keU=; b=U
 nUIndBdt5OwWkoshd01THK2+sCnGFSysimSDNrzKPdBAieaqX6lALhkIQu1l1lit
 o6COcMbdChrZZhjGMANbgaOq8eb4VVtO2NNOFSSz/mAtZ/LXwn2tpupbeeZA5Rwg
 +AQreVK6S/8bWmQVnwFy3MAe726972GWbUbmfxc3psTRR4/DSNJiEpzckejVhTqh
 K+oNwbkd7W0p3xW7wJ7ZO7NZ39lGIFwKBYpeAiSqWEHST9o8h1pGMLmHxNUIOqdU
 SLtAmlJR2y8lIJylIIGKbMvGHhHynAkZyNadmuUvnvTvNesEMqI5/u5tUGSvLjbF
 vTBRWf6YrbhZjNZM6tpcg==
X-ME-Sender: <xms:gNaXZqxbF1aTFOSPRPTUCpF_Xve12_DEHIn_uCiRIxd_R3FOdrdXsw>
 <xme:gNaXZmSs1JbY8GPMnW54fwalMVde3NM4jzmhe-nvmIRkdS-FaVepPOdnoqhCjvOyT
 cbAyWFrbaICYpuLBMo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeeigdejudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedflfhi
 rgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
 eqnecuggftrfgrthhtvghrnhepudefgeeftedugeehffdtheefgfevffelfefghefhjeeu
 geevtefhudduvdeihefgnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
 hilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:gNaXZsWW_-Zl0tw-aOOg_RAb10nnWkxPlvA4lMgShHTyD087incaUQ>
 <xmx:gNaXZgicxxSmz_3GwrttZq7_G6THPKN_tiq-JZ-E2CxWAfKxKjosig>
 <xmx:gNaXZsBj0DLphyVGgv09vYz4R3-cUvvmU7vMwvSsfEuXXETO2bjiKA>
 <xmx:gNaXZhKVP9LzAMJwc7P0GdjpISJgwFUMIubKvXKcviehOxtzQrKq_A>
 <xmx:gdaXZqAXEoV9fHokLbjSGl-WqHj4jIjI2PByhutDGTA4jXOi4Mh4Lz7i>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 3AD0736A0074; Wed, 17 Jul 2024 10:34:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
MIME-Version: 1.0
Message-Id: <c2853d56-4bdc-4d1b-81d8-c880aa298988@app.fastmail.com>
In-Reply-To: <20240516-rework-video-format-v1-0-f69822b742a3@flygoat.com>
References: <20240516-rework-video-format-v1-0-f69822b742a3@flygoat.com>
Date: Wed, 17 Jul 2024 22:34:18 +0800
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: u-boot@lists.denx.de
Cc: "Tom Rini" <trini@konsulko.com>, "Heiko Schocher" <hs@denx.de>,
 "Marcel Ziswiler" <marcel.ziswiler@toradex.com>,
 "Anatolij Gustschin" <agust@denx.de>,
 "Heinrich Schuchardt" <xypron.glpk@gmx.de>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 "Simon Glass" <sjg@chromium.org>
Subject: Re: [PATCH 0/6] video: pixel format handling fixes and improvements
Content-Type: text/plain;charset=utf-8
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



=E5=9C=A82024=E5=B9=B45=E6=9C=8817=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8A=E5=
=8D=886:16=EF=BC=8CJiaxun Yang=E5=86=99=E9=81=93=EF=BC=9A
> Hi all,
>
> This series fixes endian related problem I found in general
> video system when testing my fresh virtio-gpu driver on big
> endian target.
>
> It also removed a lot of duplicated code on pixel handling,
> and make implementation of new pixel formats easier. Further
> more, it removed limitation on bpc for BMP display, now we
> can display any image depth on any target display controller.

Ping

>
> Please review.
> Thanks
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> Jiaxun Yang (6):
>       video: Move generated bmp headers to include/generated
>       video: Add gitignore for u_boot_logo.S
>       video: Rework pixel format handling
>       video: bmp: Rework with video_rgb_to_pixel_*
>       video: sandbox_sdl: Implement more pixel formats
>       video: bochs: Setup framebuffer endian
>
>  Makefile                          |   2 +-
>  arch/sandbox/cpu/sdl.c            |  58 +++++++++--
>  arch/sandbox/include/asm/sdl.h    |  17 ++--
>  board/aristainetos/aristainetos.c |   2 +-
>  board/toradex/common/tdx-common.c |   2 +-
>  common/splash.c                   |   4 +-
>  drivers/video/.gitignore          |   1 +
>  drivers/video/bochs.c             |   8 ++
>  drivers/video/console_truetype.c  |   4 +-
>  drivers/video/sandbox_sdl.c       |  16 +--
>  drivers/video/simplefb.c          |   2 +-
>  drivers/video/video-uclass.c      |  38 ++-----
>  drivers/video/video_bmp.c         | 201 +++++++++++------------------=
---------
>  include/dm/test.h                 |   2 +
>  include/video.h                   |  31 +-----
>  include/video_format.h            | 161 ++++++++++++++++++++++++++++++
>  lib/efi_loader/efi_gop.c          |   2 +-
>  test/dm/video.c                   |  18 ++--
>  tools/Makefile                    |   4 +-
>  19 files changed, 332 insertions(+), 241 deletions(-)
> ---
> base-commit: ad7dce5abd49ef3b5c93da5303e15449c8c162b4
> change-id: 20240516-rework-video-format-ae8afadc45a5
>
> Best regards,
> --=20
> Jiaxun Yang <jiaxun.yang@flygoat.com>

--=20
- Jiaxun
