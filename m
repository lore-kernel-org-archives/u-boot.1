Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B43C83F17
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 14:16:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F0AA82E26;
	Mon, 28 Jul 2025 16:16:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zox8/PwU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A20DF82EB8; Mon, 28 Jul 2025 16:16:34 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3772B82CBB
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 16:16:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-32b3b250621so43698131fa.2
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 07:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753712191; x=1754316991; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fZeomxyrzyfYuYi4Fgpey5WRZmw2cBVjZYAf8ul+p80=;
 b=Zox8/PwUdFyqvVqnQf3Hzl6CuyyFMcu/EeLSKHbXgzZdhF2JlFlRKKCtS+NL4EwFNl
 4g4jRDhuuWXBcnGvdB5nxF9ceupIYFLKyACD4ptG1KQdPtSeykFM5gssWNki9v0NO+cd
 B5vSwZrT+W9tz6aOeWALbmTyGJGPaRXevdlsh8dRaS9pezegRxQPvlrhUmpFO+viGa3n
 sC92LK9dDjN3VrDKuC3b+MvvIJviaW9w9e18hZNyETeK8NnPM9xTb+h5Cl3+yV4qWbtU
 PMDA2ngZy/dgnlRusMhdEZEf40UUhGm7nczg3IMmFQ8mXfbyYIQGMf+4guU/rmeOZfzb
 LC8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753712191; x=1754316991;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fZeomxyrzyfYuYi4Fgpey5WRZmw2cBVjZYAf8ul+p80=;
 b=LJg6agu/ico65aZ2KELgOw84xJKHpia0lJgsp3sjc+VNqv2CXzQZnbjzP4LN3kZ/iC
 pKq+bVDA7oBwEu7r0HKEQDK9no347+RcmA+OrC1XgC8eUh2JxlinT5Fq+4VKXh9YvgXR
 EGK/3Oj8XABjh/2OFoOEGNpIRrIvG+tawMNXbkpijn+caWYQlTtS6Kf2LR8CZN35ElOH
 16Jp2J66xy5XhNQlY7FuTlfo71IKwiySnZOk7/kvjhJU0dopl/ldw2UAsqmEmSyOyMrc
 4nBk3J871LOd4dCQZOwKJZrIfh2ef7DrpgJj/8IV4AHpn19nf0vMO3qhnJd2DsEJE5S8
 xG+A==
X-Gm-Message-State: AOJu0YxOzcUmKuCI7UVtrJ12SlGdtge1Rcne330c//3JtO5JmwvfeuE8
 IzK7Fxufr6Trm49bhk58NEsR1pfCKryFKjOfqeSFxhcuwabNArtFNNAMRTqh1FL80vb0hOfEPYn
 QmFhBBnBG9sycC8MfdiEycr85O94ZKJaJDGI3
X-Gm-Gg: ASbGncswRC4aErt92FB7FVT9p2I3yTZfPda7rgJ/To4oVy7eZunI48iCMo5Hdsy7nJV
 +lV0y7505AWAj+WXRR/GaRKxql0j2beKOjwRx66zDbniR974nSKPPKk5IqIEKqDuvhIjZVcjfO0
 YqUlPsotByGdej/D7CJEHAqFCAYStBf7WOV25+QDJONR7Nokn/n/kZwFxDRjyrkVMseY1lErBhi
 LRiK4s1xpkwyA8v4HHPdv3xrITRmgq7mc41U8o=
X-Google-Smtp-Source: AGHT+IHWdvUad4PRLkzWH2YoFPavWiuc5ksljYk5YrNeygh7J2alOHnyU7eZFuCzoUg7ntzV7axDnJVLbxcD7BDifn8=
X-Received: by 2002:a05:651c:1a0b:b0:32f:1c10:fa with SMTP id
 38308e7fff4ca-331ee7e2600mr49821981fa.28.1753712191123; Mon, 28 Jul 2025
 07:16:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250728141209.92123-1-antoine.picard@bootlin.com>
In-Reply-To: <20250728141209.92123-1-antoine.picard@bootlin.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 28 Jul 2025 11:16:18 -0300
X-Gm-Features: Ac12FXwD5adY9-rGfVQiADdKizuaTS7AwIWJocC4Vu5WdqqWgbVUUlCjJqFEOPM
Message-ID: <CAOMZO5BOKD2EQUaUS0r3z7Qz=7js2n6bgW3V=d9jZ6JzwLi-QA@mail.gmail.com>
Subject: Re: [PATCH u-boot v1 0/2] Add initial support for the i.MX93 11x11
To: Antoine Picard <antoine.picard@bootlin.com>
Cc: u-boot@lists.denx.de
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

Hi Antoine,

On Mon, Jul 28, 2025 at 11:13=E2=80=AFAM Antoine Picard
<antoine.picard@bootlin.com> wrote:
>
> This series introduces initial support for the i.MX93 11x11 FRDM
> development board
> in U-Boot. It includes:
>
> - Device tree files tailored for the board.
> - Board configuration header defining memory layout and basic hardware
> addresses.
> - Defconfig and Kconfig entries to enable building for the new board.
>
> A minimal working configuration has been tested on the hardware but
> without secure os.
>
> Feedback and suggestions are welcome.
>
> Signed-off-by: Antoine Picard <antoine.picard@bootlin.com>

U-Boot support for this board has been recently added:

https://github.com/u-boot/u-boot/commit/b40c9b0c22773c23322423e6206f049d8f8=
2c25d
