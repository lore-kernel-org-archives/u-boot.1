Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DDACDE03A
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 21:33:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02FAA88E90;
	Thu, 26 Sep 2024 23:33:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bmV6AgfF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D78088E6B; Thu, 26 Sep 2024 23:33:41 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CACED88EA4
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 23:33:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6cb259e2eafso13034836d6.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 14:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727386416; x=1727991216; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=22pxcaVgWOWKo22MKQdq8GMuR4zxeG/DZPxy86q8CXE=;
 b=bmV6AgfF4IUCI8BitctVe7E8FPHpYnCkD7KNJASoh9UddRHDM4g7xxbpSH7Gq7N5qp
 ip2bELRj4hROgRWcUX5V3OeF8f6lNDNVV3Vsn6RgovutIV1g33ViM8rFgbMlZPX5eZwt
 8dNC3QjWAZkUR4rjVwBvoE4G9Z/Cxj8dW3V5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727386416; x=1727991216;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=22pxcaVgWOWKo22MKQdq8GMuR4zxeG/DZPxy86q8CXE=;
 b=cA5Fk7RngS6DsG0ekO8YIt9OBGyMc2+m7iR5mSORLS/HRfeDRQ7ZZywzXyoQc8YLtf
 e9oqhY7zWvHXcB/UteVL3jHasYXl1dftzd/ywuIJpurkZ9Q2PL3/GTTbHEd8GxPRBNq/
 Y3Scs+6UIZ2KF1fmOxU+KZA5piWwxVUM+uWbpkerXcz/Ckm9ajQ8epkzSv7myUJRo0fK
 hFmkl36WIY4cdsu5rr43O5nsfjwBnep3B/t3e6r/lef5iRPl3qZQUyLbQ9nRH8Wpv7Q1
 g7uRcdRtSB0RtjvhA9pvOgCPDpT6nzuiGskMY2vzhpkuBHYmnSA9p9vXTYTnohzbJvab
 8oSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRywNFJIe1ZQILMzKRMAxD9mkcNmlZ0A/1V91fNeVAGMeZGsCHeDu+IqR/FtTIPDxxAezsGFw=@lists.denx.de
X-Gm-Message-State: AOJu0YzLz1BYeDsMhn62fwbEDXTChZhoz18f7/5FfZW/ALAc8YL/OjVU
 Sb6MzxyuXHdt5kJBSe5cyz7pcPLRbGePlL3hOlSRIJMYVbcevrPFrvGyHAi8hesoxXp6gTwkcgy
 3TlJgunBoFIdE7GZbvmeCM2ES0QgtbPDeVDmo
X-Google-Smtp-Source: AGHT+IEvkrgB9DUE5ngkALFQj0WCCVDvsHR+EUWGaOi8wwAx9MDdvwyIQC11dODeMfSLL1aK4TzFamqVWxxU9tUDtTQ=
X-Received: by 2002:a05:6214:1d2e:b0:6c4:d2f9:644e with SMTP id
 6a1803df08f44-6cb2f2832c7mr71939166d6.12.1727386416383; Thu, 26 Sep 2024
 14:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240920225101.2008-1-ansuelsmth@gmail.com>
 <20240920225101.2008-7-ansuelsmth@gmail.com>
In-Reply-To: <20240920225101.2008-7-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 26 Sep 2024 23:33:23 +0200
Message-ID: <CAFLszTh-VLX+j4pwQrjkJMBfBH2-wVT+6s8ERvqN6-ZdAu_CXg@mail.gmail.com>
Subject: Re: [PATCH v4 06/11] tftp: implement support for LED activity
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

On Sat, 21 Sept 2024 at 00:51, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> Implement support for LED activity. If the feature is enabled,
> make the defined ACTIVITY LED to signal traffic.
>
> Also turn the ACTIVITY LED OFF if a CTRL-C is detected in the main
> net loop function.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  net/net.c  | 4 ++++
>  net/tftp.c | 5 +++++
>  2 files changed, 9 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
