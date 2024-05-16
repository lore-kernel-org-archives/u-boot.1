Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 486B9C25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 23:11:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B467388485;
	Fri, 17 May 2024 01:11:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="cS5OO30C";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="hfsbtY0J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B4E78848A; Fri, 17 May 2024 01:11:13 +0200 (CEST)
Received: from fhigh3-smtp.messagingengine.com
 (fhigh3-smtp.messagingengine.com [103.168.172.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A05488485
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 01:11:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 892C4114014B;
 Thu, 16 May 2024 19:11:10 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Thu, 16 May 2024 19:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715901070;
 x=1715987470; bh=b4wIL0T3RIVDcC1KwGs0C9K2sdo74OKkxmEmQN67Kk4=; b=
 cS5OO30C8XQ0snNV7rphLDBKfmtl07aa66s0hbLmVj+8ULNCZFuxnQ6pqpiC/ZCn
 OicZ9EWM15lRwnWbRO8i+i6DhhfoQwPsHZ5GU24Yyi9DN+2de8K2ecQURp17jXVA
 Fu83OfVPpKGGx/VTydvqaifkzohf1Tz2IQvbmm5ud404bwCXyUpbWVxxeQTNhylX
 3TBKg9j0KmbSL4p4sdfOWLtWicF88Cx8JoIu7w3eIC9ESqNYhTHw0vga5D+jaaoc
 8l9y8vbj0AQKj2v/b7GhPdInyeKioxilhq7BFGPai5OhNpOm3/FKI0tjN+2YQuDL
 lZv/ufyQn3xwomDkFqexoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715901070; x=
 1715987470; bh=b4wIL0T3RIVDcC1KwGs0C9K2sdo74OKkxmEmQN67Kk4=; b=h
 fsbtY0J40/hBW332IU7jJKc00csWD/YlGkytApskGOonH2eOQxCu666qiW+NKRQr
 oMpOKmmE9XJSV+jbvv7tzb6wi8WoUFSDB9TOPf5FyLuF6keYjgyCJn80atljKNKp
 p0+xIhdXu1vuixEe+/QFfj1uIP9mDCNyAJavqB8p1nMVbc2BhD/U0iRi4k3h71Sq
 myOoiJrPIIvf/tKgkqOx5Nhnsi3VHVZk6a+oovfV9pCG6EtKtnK5JrNKuUi5bXGW
 oeMot/YNiTrUkYFm8B7LYlHJrnEhoRyRd6VPaySqhF9ig1NVa6Z/8lIwQzfE0vNZ
 qjDQtJDZnebMzWP5I2Rqw==
X-ME-Sender: <xms:jpJGZkfzkVp9Yyefgw0dptR8OI8yEWR5N3wQXe4PsKXwKdkHXxapKA>
 <xme:jpJGZmN7INAIE4H3NSWB7v41kRsIFyQTePI0Pz8lSJJ_gnrrmwDDxMjY4pFCfXqwd
 OOPBcdTawTnzNbm3gQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehvddgudejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
 ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:jpJGZljTU10rHup0eqdDQCvsYz_VcRM27XikvGdEOVDGqS5F8H0NDg>
 <xmx:jpJGZp94lXanRoBH8meC-187HBgMacvfY0KBtNVop-PDWdqzPTT4yw>
 <xmx:jpJGZgv62hhPUcdeRM9toEff7cD5QmIlC3lSZ937SMN1uNbguQPy3A>
 <xmx:jpJGZgH17N5QqbgS6-k3o_twEG-VbyAls4FRRTKGXg_sxhqQ883bWg>
 <xmx:jpJGZiJjBUyjTjY51maCthNN9lPUdBwy5b1lLLdSTCCsTFsu6fsY1T3v>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 36F6836A0074; Thu, 16 May 2024 19:11:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-456-gcd147058c-fm-hotfix-20240509.001-g0aad06e4
MIME-Version: 1.0
Message-Id: <7a9fb41e-e207-4037-a8bb-eb8fc149e496@app.fastmail.com>
In-Reply-To: <20240517-virtio_gpu-v1-0-6353b87472c7@flygoat.com>
References: <20240517-virtio_gpu-v1-0-6353b87472c7@flygoat.com>
Date: Fri, 17 May 2024 00:10:52 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: u-boot@lists.denx.de
Cc: "Tom Rini" <trini@konsulko.com>, "Bin Meng" <bmeng.cn@gmail.com>,
 "Heinrich Schuchardt" <xypron.glpk@gmx.de>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 0/2] virtio_gpu driver and relevant fix
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
=8D=8812:03=EF=BC=8CJiaxun Yang=E5=86=99=E9=81=93=EF=BC=9A
> Hi all,
>
> This series added support for virtio-gpu device, it has been
> tested on QEMU riscv64 and aarch64.
>
> I also fixed a problem in EFI GOP so it works with EFI applications
> as well.
>
> There is a problem remaining. virtio_init() is being called too
> late to allow virtio-gpu to be selected as a vidconsole. My current
> appraoch is to register virtio_init in init_sequence_r, just after
> pci_init. Is this a viable approach? Should I introduce a config
> like CONFIG_VIRTIO_INIT_R to allow it to be selected by boards?

Just realized I made a mistake on preparing patches to be sent.

Two tiny modifications are missing from this series, dual endian
handling in patch 1 and removing an unused variable in patch 2.

I'll update a reversion, meanwhile fell free to review the current
version.

Apologize for the noise.

Thanks
- Jiaxun

>
> Thanks
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> Jiaxun Yang (2):
>       virtio: New virtio_gpu driver
>       efi: gop: Mark pixel_format as BLTONLY if we have sync hook
>
>  drivers/virtio/Kconfig         |  29 +++
>  drivers/virtio/Makefile        |   1 +
>  drivers/virtio/virtio-uclass.c |   1 +
>  drivers/virtio/virtio_gpu.c    | 298 ++++++++++++++++++++++++++++
>  drivers/virtio/virtio_gpu.h    | 428 ++++++++++++++++++++++++++++++++=
+++++++++
>  include/efi_api.h              |   1 +
>  include/virtio.h               |   4 +-
>  lib/efi_loader/efi_gop.c       |   9 +-
>  8 files changed, 769 insertions(+), 2 deletions(-)
> ---
> base-commit: 21aa37ec1cd4a12e01e0e863ec9e99d703ce4d52
> change-id: 20240513-virtio_gpu-abb4de685808
>
> Best regards,
> --=20
> Jiaxun Yang <jiaxun.yang@flygoat.com>

--=20
- Jiaxun
