Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D15E0C27C79
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 17:53:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 385C7882AD;
	Thu, 20 Jun 2024 19:53:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QPeS2887";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD89F884CA; Thu, 20 Jun 2024 19:53:47 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C26E18813A
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 19:53:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a6f9fe791f8so200377366b.0
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 10:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718906025; x=1719510825; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2nVV483uEJ40OjwOBFoGeCJb7jHFbFnOXmO72vTIj+U=;
 b=QPeS2887o439lqhjL+zhlNg84xjgahNG7QJbbgb7C7YeP9cgzzsJ5/K/boSBVpU1Kn
 7oN89J1XKAbIdmXZ3xAk6iDGo++EEv1aY9/2zg/bj3TwSBpHWfcR2itw3yjqbNYKX9Hh
 21m3SUdbrd4XQRlmLNLsZvO2AQa6oVMqMUMK2oX0/kTPU2AA0LclwhqgJBuqfdrVoFI1
 jOfBj5tvi+YtCht1zU2qKfDFgWuueOHCUtt7mzfotYKrDggWiw0e06q87H2AImBUO/E8
 9r7FFv4pUgi6ag7ScNL2WTyCh9ziuPVeyzMQHInr+2NkK42bSN8BVaxf4i9bTXkZ8ghI
 oIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718906025; x=1719510825;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2nVV483uEJ40OjwOBFoGeCJb7jHFbFnOXmO72vTIj+U=;
 b=SbeoD4DRnzEZCucPJSFD/b6RWoEUqq/6qfOFYZNDLsG5Qlwvf7f7NhIYHQPoEn0w0V
 pHlYfuRf07NWtEWURZJtHXJ5MzRt6XqMhKrq0mFedanvoUZifEp/5jx7jVVEgaClTBfN
 tfUC2Ni/TgU6RonL5fOr4JUwd+g1TvO+T773iiElUB38HRhNZUsFrCryeopRol1W8ehu
 WhYcWc4+AIgbxuydFi02UB3lOIpRHI5r59hzMJPitjtuWoa4o+8/5n0i2Xrg8u30O97c
 XFEcCU2QGh24+NhPaUclws41l5/50SNa4IpLs6WVO66lKleL/s2GFhabk/ajr+k7g8iJ
 a+KQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEEDNZlT+10dNAiBSLEjL2Sr2WSN+rzL+BLqvN8DNcV57TjsJoZONz9OJsfF7EPKY9GR96W+VxfNo5j+AKEBp4Pqp4ug==
X-Gm-Message-State: AOJu0YyVD+QM3H9/YWJkfPccIfrdRRz4vXRObf9DlpfVGaARfklmUvUo
 3oFX8u5PPAkKAqFgGrdCdzEOPYql98es0JSgEjscOnLr6cAbaH/0rbWg3YRhVeirEX5Q/cKfhf9
 zlUaIvY/xOwuz40tnWy3wv1bDm0A=
X-Google-Smtp-Source: AGHT+IH/V9B5KZfhNd25hYmxyxV/Tu+tHYXRK1eI2AXGJDDU/NuMDfwYVonfE1lem8r+Pin615GYpokBL7JluoXLTng=
X-Received: by 2002:a17:906:a257:b0:a6e:f540:8b5f with SMTP id
 a640c23a62f3a-a6f94f2ab1amr585625966b.19.1718906024943; Thu, 20 Jun 2024
 10:53:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240620-tsd-http-git-clone-v1-0-666e8d6a8949@cherry.de>
 <20240620-tsd-http-git-clone-v1-2-666e8d6a8949@cherry.de>
 <09a91cfd-080a-4c39-8887-c36b42fc8ba2@gmail.com>
 <20240620170830.GQ68077@bill-the-cat>
 <d5f90fe2-230d-477b-8d4e-ff6088acebee@gmail.com>
In-Reply-To: <d5f90fe2-230d-477b-8d4e-ff6088acebee@gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 20 Jun 2024 18:53:34 +0100
Message-ID: <CALeDE9PqLaxMvTK3chH06734sHs3JMH4U=gAV0rHA_RFrcbyRw@mail.gmail.com>
Subject: Re: [PATCH next 2/2] rockchip: remove support for Theobroma Systems
 RK3368 Lion
To: Alex Bee <knaerzche@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <foss+uboot@0leil.net>, 
 Klaus Goger <klaus.goger@cherry.de>, Heiko Stuebner <heiko.stuebner@cherry.de>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

On Thu, 20 Jun 2024 at 18:41, Alex Bee <knaerzche@gmail.com> wrote:
>
>
> Am 20.06.24 um 19:08 schrieb Tom Rini:
> > On Thu, Jun 20, 2024 at 07:03:26PM +0200, Alex Bee wrote:
> >> Am 20.06.24 um 12:24 schrieb Quentin Schulz:
> >>> From: Quentin Schulz <quentin.schulz@cherry.de>
> >>>
> >>> No meaningful changes were made to this SoM since February 2021. Nobody
> >>> from Theobroma has booted anything recent on that product since July
> >>> 2021 at the latest. The product isn't available to buy anymore and
> >>> disappeared from our website.
> >>>
> >>> This product is therefore unmaintained and it would be disingenuous to
> >>> say the opposite, so drop support for RK3368 Lion.
> >>>
> >>> If you're a user of Lion, feel free to revert this patch or contact our
> >>> sales/support department.
> >> That's a pretty interesting support-strategy. While I really don't care for
> >> this board, please don't go ahead and remove the whole TPL-/SPL-part for
> >> RK3368 in yet another pointless "cleanup"  only because lion was one the of
> >> last/only user. Even if EOL RK3368 is getting finally interesting in
> >> regards of display pipeline as we are finally getting a OSS gpu driver [0].
> >> I'm planning to add a board which uses TPL/SPL soonish (when my rare spare
> >> time allows).
> > Please update the MAINTAINERS file for the relevant to your future
> > platform, or even better possibly get a skeleton of this platform
> > posted. Thanks.
> >
> I don't think the whole platform would get removed as it has several users
> (and is maintained) - I just was a bit worried that TPL/SPL support could
> get removed, but now noticed there is one more user: evb-px5. So: sorry for
> noise.
> So I will go the usual way via upstream DT (linux tree) addition and so
> forth.

It's easy enough to bring back the pieces from git, I have a geekbox
somewhere I've always meant to take a closer look at.
