Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E480CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 03:42:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99D3186D86;
	Thu, 12 Oct 2023 05:41:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y8FfwJnt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F68386DE7; Thu, 12 Oct 2023 05:41:34 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36E1886DB5
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 05:41:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9b64b98656bso79083866b.0
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697082091; x=1697686891; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M/j4R4j+MEE9O2kP93XCPqLpd9m+6ianNSjvEuRyS1E=;
 b=Y8FfwJntp/EI8ifHhVmVeETO2YU5+Uf7ucLLtCDGjk+WHZ4Hkw1tk8CsAFLLtWzwF5
 eLdL0JCvdui9A89ZSvk2u+XzYlBF1zegF9k4+WkltnHb4rxraCZXWARuh6aMz+pXDDM+
 UqjTdZOhu623jXfm/Jsg/iZn4MMmJ1PC1WjBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697082091; x=1697686891;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M/j4R4j+MEE9O2kP93XCPqLpd9m+6ianNSjvEuRyS1E=;
 b=s74fSVayXDhx7XrPkow/77OyMfNohz5hcA6EyeSfeQ3pK5CUitPjioIDeky5abnZem
 cW8JNZfYDFWW69DBuOlX872VpK2ipw+B/TLNLA+JA/P4KkembCLYhHXLZ0vPJdc16Z39
 KAhOgYUOq8QThDlEY9fkqbh6JSbEmKBfijkdhKClJezIFoXezSEdj45kvkI+ZhajSvwH
 ctlLBH8Dx4oSoF7JClbBHi1QI8zrU+UVdAHmNF5IocjqOFaGH8p9LaaZq3yFpRX/AJ9P
 Adjobly7hOE/HXtlEhL34umW4aGo2K2NGZ/VjD5WKi+23MeHhqaX6NOaXb5xK6waFi9q
 K6iQ==
X-Gm-Message-State: AOJu0YzPL9MU+qPYRL9JrCtwx9HSsyjpQVmZk8kRLSL+TKOrK+BR3UVt
 D4lra/Mvy3qIGbYLO+DO5k7s4w9riaczqRFZGZqTlw==
X-Google-Smtp-Source: AGHT+IH4PiDaHSkI7Qa7lY/CIoeLy8r5ZpbplQ0zZi+oTJvNDAbnE4pkpSn+qlaqGzUb+eb2yRnRNPVvLSWM/hC/ZXg=
X-Received: by 2002:a17:907:75da:b0:9ad:a46c:2936 with SMTP id
 jl26-20020a17090775da00b009ada46c2936mr21566237ejc.8.1697082090722; Wed, 11
 Oct 2023 20:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-16-seanga2@gmail.com>
In-Reply-To: <20231012015626.3487451-16-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Oct 2023 20:41:09 -0700
Message-ID: <CAPnjgZ37EYOWfLKnG+B2Ef-CR29tSE+RTta5nP1tgvfF-Y6VVw@mail.gmail.com>
Subject: Re: [PATCH 15/26] net: bootp: Fall back to BOOTP from DHCP when unit
 testing
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
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

On Wed, 11 Oct 2023 at 18:56, Sean Anderson <seanga2@gmail.com> wrote:
>
> If we sent a DHCP packet and get a BOOTP response from the server, we
> shouldn't try to send a DHCPREQUEST packet, since it won't be DHCPACKed.
> Transition straight to BIND. This is only enabled for UNIT_TEST to avoid
> bloat, since I suspect the number of BOOTP servers in the wild is
> vanishingly small.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
>  net/bootp.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
