Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9534CC3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 14:25:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEC4083291;
	Wed, 28 May 2025 16:25:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bQmL6IlH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A88F1832A4; Wed, 28 May 2025 16:25:47 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED9A58328D
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 16:25:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ad56829fabdso642662366b.1
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 07:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748442344; x=1749047144; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LNQGGjST2UK4NYypAYNm4Sl41yctSIdqxEWJXWllGRc=;
 b=bQmL6IlHFPexerkmAe9/OyfN8mSqV3V+WZnu9nJkc2Y7Gza0lPv5KwIvSz0zKtqJO7
 zelwLdI7JMOXJwypwKtFxdY90Yxj7P/o4tNGHmquw9gW5nXmIR8N77qZtaZ5zth59fdX
 ISazGOwOQ088xWVprD/NFc4jH0DZ1SwNy98II=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748442344; x=1749047144;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LNQGGjST2UK4NYypAYNm4Sl41yctSIdqxEWJXWllGRc=;
 b=kcVC/I4ub1ZASnhQCni88I02onLtiN8ewDONgBGuSGZBWTkcU1Dp8rFO6TGE2vYZoL
 6HEU6ODQ/1lBKQchHt16FRn0HcMyL/PWYJDDQEPrUOPYYuwkow2p6k+nTCHEitJlXyXa
 YqYzaRno7i17AtnjKAyZZo7mIAN1i0eJdWk/xmtdpzNbT745ph52SM/53aIg0RYdm4ov
 mpOE7yq64LBZb407gcYD0750kvJZ1BBLSlyWEy2sLc5pTu0LZ4WWAMbCi/rHzyu7SJ9t
 SDN9fD+A/q+tNnlPGjQHhASQOwp5sjlma/R8qt50wWM+E1sdcvpZc3L1B6r+ei9ZyAY3
 iV2A==
X-Gm-Message-State: AOJu0YxBx5InS4ETcSqF1jKBrKUe569ReHKot9EoN9teQXNVOUrvw8fA
 w1jZIGJP2vcLGrbD2OvTfcRaflqf6S+EKD7zHFHGhTb1Kc4Ng/ygTf3j3P6pWUbJk1vUmnDgW6A
 K0t6u8SodmNSium6EdCnRBOHNs22+DeYF979F3aZ/CnQxQS1cgtVC4A==
X-Gm-Gg: ASbGncv2nZomA7ZXAcpOXi5jRGh3fm+lrz4MgnlDnvmGGc7aTic0ipMlGhbczRY1uix
 U/Ac5NVynav8p93ipKC9FSjme3+o4rb7ZvkOX2WoPLhaug9RzJuS6gXZYO8NN52Oa1dUZfg/PNc
 Gfcay5UJzJzXV3vFkZ14avagyAWNNanSot/7MsG7OJVg==
X-Google-Smtp-Source: AGHT+IGAdI6ZVoC90i74Q6Ig3XTiL4U+i0HgXJftmEYOChr8l0CD6lTgvosP3NwNj1XpQV09Vi5MeqvTGQmDlU+IXPA=
X-Received: by 2002:a17:907:6e8c:b0:ad8:8719:f6f3 with SMTP id
 a640c23a62f3a-ad88719f727mr819718266b.22.1748442344101; Wed, 28 May 2025
 07:25:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250528082520.152391-1-sjg@chromium.org>
 <20250528140929.GR100073@bill-the-cat>
In-Reply-To: <20250528140929.GR100073@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 May 2025 15:25:32 +0100
X-Gm-Features: AX0GCFunIdSUtH-6Imw2pyD9BuzKRGAzbsc25OTnWCG5DGnPbqxC4SXHtwonXr4
Message-ID: <CAFLszTiVtyAsdqLNaGrs11TuugAhTp0Rru30=yNJoAa2RyU6YA@mail.gmail.com>
Subject: Re: [PATCH 00/27] x86: efi: Various app improvements to support
 bootstd
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Janis Danisevskis <jdanisevskis@aurora.tech>, 
 Jerome Forissier <jerome.forissier@linaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Richard Weinberger <richard@nod.at>,
 This contributor prefers not to receive mails <noreply@example.com>
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

Hi Tom,

On Wed, 28 May 2025 at 15:09, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, May 28, 2025 at 02:24:26AM -0600, Simon Glass wrote:
>
> > This series makes a number of improvements to the EFI app. Mostly it
> > applies to x86 but the ARM version will share some improvements.
> >
> > The main updates are:
> > - Improve linker scripts and options to detect missing symbols and
> >   remove unused code
> > - Enable bootstd and provide a default which can find an extlinux OS on
> >   EFI media
> > - Make the 32/64-bit apps more similar in terms of features and link
> >   script
>
> So I give a little, and say Yes to you despite technical misgivings, and
> you post yet another big series that's based on your tree with already
> rejected changes in it. I do not feel that you are working in good
> faith. Please stop, and work in good faith.

What specifically would you like me to do for the EFI app?

Regards,
Simon
