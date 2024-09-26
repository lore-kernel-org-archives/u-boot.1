Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A254CDE038
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 21:34:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C663C88ED5;
	Thu, 26 Sep 2024 23:33:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E+ap2dpf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D178D88E77; Thu, 26 Sep 2024 23:33:45 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED8C688E6B
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 23:33:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6cb3062d9a6so9059426d6.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 14:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727386422; x=1727991222; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a5mqr1YeTyBwxls/Lax9pQpy+Y1lZK0KyVvbVo/SD9Y=;
 b=E+ap2dpfx8kiwwkyjj4Kohv/Hey+WexKwLeThH3B9X/++LweBEHaTQeBjGO+99NQsf
 9xLDUtO8Gq0Mkb8CeEp2exCY9rMxqXOhCoFeeBjWRSWiINZJ1h9lccOsvqzkwEkFH8RT
 vkNGpMkHZjr+GIytQ9XQVV2wKmn9ucOb4RCds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727386422; x=1727991222;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a5mqr1YeTyBwxls/Lax9pQpy+Y1lZK0KyVvbVo/SD9Y=;
 b=DH6JNFwH6zYLLnXr814A42uaqtR9vs4pTxQQ0V060lJ9Cys1SNChWmcSauuVQCRijV
 dzuGsGzGMw2DTuhVPNr5LAlqjka+45LPoZXIoL6SUdJ8OV8NXibjTORKbmvlE2YVkjwS
 4b6zIImU43GHS89ewuTIC/mC/56TJ6YfZSGGdMTSMSjCd1wcB2ZNCDH+2cpsjnwcln6M
 FfIOLYBdAghgQS7LUYWoD6ck6DxUMMVxUT4jwV857EFMeJbQREWuxlZuNd8Ua8UoM/6p
 D+Flyric5cov3cByaNb6qo35YhneJcHhgcWVAO8+2cfpUSgE+k9rR4YDPFhe2phGTV7z
 atrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaePVKw8S+uUmEA7uNYcStlZNxn7NufDCdiJxVfwd2EayDOUp902cCMJGm69lXfO/3hrn3r9g=@lists.denx.de
X-Gm-Message-State: AOJu0Ywu13Qiy4azeKVi8eX4fMTEKfx8dRfbbGtdzS9BQG1FkBX7KQO3
 hx1etU2ZwAPZ9AOyKPhwiNBH9YHRs7Q0pT+5aCR1LOP/pe9U3lMYcO9VnZDbVpGWfOxF81evNT9
 s0wkwIOaMV0tOax67akwgurEr7QLV7aZt674/
X-Google-Smtp-Source: AGHT+IHWcDEUJtLX8ghGMkFZNDYNit4RHjLhNE0T8JIVuD6aw4h2wdZIBQTt+XO9UQR1K/bFm/tC/z23vqt1wnTOMQ0=
X-Received: by 2002:a05:6214:5411:b0:6cb:20b6:f39a with SMTP id
 6a1803df08f44-6cb3b5c7d52mr19377816d6.13.1727386421898; Thu, 26 Sep 2024
 14:33:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240920225101.2008-1-ansuelsmth@gmail.com>
 <20240920225101.2008-10-ansuelsmth@gmail.com>
In-Reply-To: <20240920225101.2008-10-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 26 Sep 2024 23:33:28 +0200
Message-ID: <CAFLszTjcKKsfVW+QkZ9Z3SKDc0ffbt-XK7zGROWV=JK80qkwnQ@mail.gmail.com>
Subject: Re: [PATCH v4 09/11] doc: introduce led.rst documentation
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Sean Anderson <seanga2@gmail.com>, Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Yang Xiwen <forbidden405@outlook.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>, 
 Alexey Romanov <avromanov@salutedevices.com>, 
 Martin Kurbanov <mmkurbanov@salutedevices.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Artur Rojek <artur@conclusive.pl>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, 
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
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

On Sat, 21 Sept 2024 at 00:52, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> Introduce simple led.rst documentation to document all the additional
> Kconfig and the current limitation of LED_BLINK and GPIO software blink.
>
> Also add missing definition for sw_blink in led_uc_plat struct.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  doc/api/index.rst |  1 +
>  doc/api/led.rst   | 10 ++++++++++
>  include/led.h     | 41 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 52 insertions(+)
>  create mode 100644 doc/api/led.rst

Reviewed-by: Simon Glass <sjg@chromium.org>
