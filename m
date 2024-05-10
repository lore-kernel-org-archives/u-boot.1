Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B22C25B10
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 05:36:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D871A880F5;
	Fri, 10 May 2024 07:36:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Llw5Onf3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11BA28825B; Fri, 10 May 2024 07:36:29 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4750880A1
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 07:36:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a59b097b202so365441066b.0
 for <u-boot@lists.denx.de>; Thu, 09 May 2024 22:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715319386; x=1715924186; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Oh5vrhPBppz+/Z7C4tXpwbUgdzGo9xUSFmm4XHxGuEk=;
 b=Llw5Onf3h0DUFBSFpWOeWnun+oIF2kKlW65tjVKZRBs13T4rKvhIrq1bfn/F3e8Bzh
 BMcZ6L4wCIXgvUMrA1wiEZVX+rV7jSSgaqmvnAsql+EVz4AepS2nt9JNlFnH4AiOh6rP
 VtqYVOTnJpKtiwQYWLzYh4Ng0vN5mT2ruwbaKHoUHW/UjqApr8EUlJzgLSCL8pcrhMBl
 6G1g4UUCjHIdyIzTkZSPgbl6pGaLh24ioBPA81pqYIZWGsE+NEWSml4AF7aOU5HVVIoo
 oVxnEO85jLr52Ku9SS+7bKfU73A7GinuyDY3FCCHRo9MO9ib2BPrR9BbW1lBBD5GBr2C
 QFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715319386; x=1715924186;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Oh5vrhPBppz+/Z7C4tXpwbUgdzGo9xUSFmm4XHxGuEk=;
 b=M0+wGGJOiPiW7bSQOUOClhG5K2Y8BzH8s9JCjjTHaFA7wsT1kBmqHg7X9hF9+JIsF6
 IxoAOpUrfykKY9F8XIxupyJbUNnLvfAtVEbQIq6YEvkvTWkKkMlIDByxB8xB83DzdPTD
 lwrOxJd1DYsDkxtkvt8SeGw48ejaZPMSe57fG92Jr8dTiOfZl9de/gCI/FXYzYxmsux8
 ibwRQgaamrAV0DrpjrlRCw9fxNKxMSMAJUjlF4pU2mEhvUbN24Bz/5PgwUQDAu/D53qf
 XyTOTX7ZrpbH70KdhIKvh6udpYgiuFCGk5Z7N3MThIg5x7YUmtO6gOobhFa7kkfXbdEP
 H93w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCJxUDUECZVN//NH5igtpqcMQ5ygPowiNvusCeGu04o0JZQ3AmwwjAEazCZbTBgkeaFX49EjGp26lYCvPk7Kf7z1F8FA==
X-Gm-Message-State: AOJu0YzzPSBIUKpTFUQ2HX3hj5HHKCkgago4rl5tfOMmqZOQ17u37+hR
 vf/8E5tHOLNczO4H+eTL+NdBtSjKABRiFJiT9BOPoeMfdKAU6MSuW5uOdrWLjUekkoDADGRedgK
 G8Jybv4MKq70epocwKvASpBvsYmWYvnnjB1w75w==
X-Google-Smtp-Source: AGHT+IG7bSIxJv/4w8Kqm8G9XM7yZxI6UQY8b82v5JwkDHLH9yFpf4FvodJAYJtwaGZqIZ8oEsttkj+vW9uU1BOk3Vo=
X-Received: by 2002:a17:906:1992:b0:a59:b359:3e14 with SMTP id
 a640c23a62f3a-a5a2d5356d3mr102075766b.10.1715319386078; Thu, 09 May 2024
 22:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240509164123.1753050-1-j-humphreys@ti.com>
 <20240509164123.1753050-2-j-humphreys@ti.com>
In-Reply-To: <20240509164123.1753050-2-j-humphreys@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 10 May 2024 08:35:49 +0300
Message-ID: <CAC_iWjK2rTFkSdU2NW9o3fqe9+7=gy+qPEWqFhhXwEOk+5W5KA@mail.gmail.com>
Subject: Re: [PATCH v4 01/19] doc: uefi: capsules: Add Capsule Update porting
 section
To: Jonathan Humphreys <j-humphreys@ti.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Judith Mendez <jm@ti.com>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Simon Glass <sjg@chromium.org>, Nikhil M Jain <n-jain1@ti.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Bryan Brattlof <bb@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 Nishanth Menon <nm@ti.com>, 
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 9 May 2024 at 19:41, Jonathan Humphreys <j-humphreys@ti.com> wrote:
>
> Created a capsule update porting section in the documentation that outlines
> the steps a board developer must do when porting from an existing reference
> board implementation.
>
> In particular, added a big warning that new capsule GUID's need to be
> defined.
>
> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> ---
>  doc/develop/uefi/uefi.rst | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
> index 0389b269c01..36ac75278fa 100644
> --- a/doc/develop/uefi/uefi.rst
> +++ b/doc/develop/uefi/uefi.rst
> @@ -631,6 +631,18 @@ where version.dtso looks like::
>  The properties of image-type-id and image-index must match the value
>  defined in the efi_fw_image array as image_type_id and image_index.
>
> +Porting Capsule Updates to new boards
> +*************************************
> +
> +It is important, when using a reference board as a starting point for a custom
> +board, that certain steps are taken to properly support Capsule Updates.
> +
> +Capsule GUIDs need to be unique for each firmware and board. That is, if two
> +firmwares are built from the same source but result in different binaries
> +because they are built for different boards, they should have different GUIDs.
> +Therefore it is important when creating support for a new board, new GUIDs are
> +defined in the board's header file.  *DO NOT* reuse capsule GUIDs.
> +
>  Executing the boot manager
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
