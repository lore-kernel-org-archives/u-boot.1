Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86042C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 14:45:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9167E81E5A;
	Fri, 14 Mar 2025 15:45:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BfcaZbaR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93A3381D65; Fri, 14 Mar 2025 15:45:28 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A079981DE9
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 15:45:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ac25313ea37so434162566b.1
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 07:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741963526; x=1742568326; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eWiSEav5ZTYqyUGckR4NwxK/n87+KTunpVIm29ZNeSs=;
 b=BfcaZbaRH7QGaLKMbosFbe65t8NJViGiCr9IXpoD4xcuazdq1wos2ghUhR203bj4Lx
 m9pXiLVbP/L3PEwEl6DK8iZsE12VSv273QLazntBsF3vz5L6pmS5c3disADWIe/Ja9jd
 FbbaavIu8sqzEOVZcURMxeAiouePeCR4oXLnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741963526; x=1742568326;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eWiSEav5ZTYqyUGckR4NwxK/n87+KTunpVIm29ZNeSs=;
 b=HmzHJNjLEuyvpyp17YUt5faXSOAGtMKEe2oByuJLgkG0Ba/frBP9gZXYMws8MVgzqi
 7meZ/nLUYITGjn5OTZ8VQA0l8e6be3DokmFj66K2pNKfUMHAEwmlBuaQBAGvOfqV9jsL
 B3tRvC5z6n3lQbDO3G4I7y8bOyPT+wMBun3ADLKazD14735JTz4K96YRXJLd5bg3GgfX
 6E8eEBJd0zQztIPikppMTT22+kLDfl11YHV7VvC9MioLkI/SlLyOyzw7CApV+DRPAi90
 A/iLqW+w9AcKwtsrjTzcsDpcnkxF9eOdLMu4mBfW49f0Emg7lvlSoDzd+X/rnQzrB/rH
 gMvA==
X-Gm-Message-State: AOJu0Yz9aECJ2VLZvIWe1Dn+ZO9rP4QnlD3qfMYtE7y6zRZpCcOrIYRD
 TbPNQorS5AXHIAmavRDxQ52RzOy56PpFydIsBHGTu9XbEdr174QyslvrrkFfrnv3+INUhMDXFUa
 ZRWAnHJptsfxTui2vCsFviUMncy2QXfTqMQgK
X-Gm-Gg: ASbGncteNMlvBHxdN+2dpYn7of2AKO40LFeZOksxaIG9TjXCQ3ImPu6h1OgNskOj508
 SBlQUZEnOczLemispkO3GAhoWVU95ZacTkyp5NjB1LtMHYETmZRwII8io5xIQm4tIH5gIkq3rgZ
 ZND8ohlPC1sevcj7y66/9Ec7jTU7sc
X-Google-Smtp-Source: AGHT+IHbpyrYWEOQReZWeLDJsQnaiOL/B0RotzhAhl57+3oQvy8jhdmkA4XwpwH57EDuTswovikUqldts0XW0Do4wv8=
X-Received: by 2002:a17:907:9487:b0:ac3:ef4:d34d with SMTP id
 a640c23a62f3a-ac330272dd5mr320651966b.28.1741963526049; Fri, 14 Mar 2025
 07:45:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250216204421.3560012-1-sjg@chromium.org>
 <20250216204421.3560012-28-sjg@chromium.org>
 <20250217174557.GP1233568@bill-the-cat>
In-Reply-To: <20250217174557.GP1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 14 Mar 2025 14:45:14 +0000
X-Gm-Features: AQ5f1Jpe3XZjlRLCX0qZMDl2hdG1EJYL6Ra_MY-KJDph6iZ235WqObaC3gxc-zc
Message-ID: <CAFLszTh_0ndtaSUADePBB6qNLQHzO555+pgd0ndyygAGHe-X3Q@mail.gmail.com>
Subject: Re: [PATCH v2 27/28] RFC: test/py: Deal with timeouts
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Love Kumar <love.kumar@amd.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Stephen Warren <swarren@nvidia.com>, 
 Stephen Warren <swarren@wwwdotorg.org>
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

On Mon, 17 Feb 2025 at 17:46, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Feb 16, 2025 at 01:44:12PM -0700, Simon Glass wrote:
>
> > The distro test takes a little longer to shut down and restart, so
> > add more time to this operation.
> >
> > Disable the sleep command for now, as it seems to be unreliable on
> > QEMU with '-cpu host'.
> >
> > More thought will be needed for both of these problems.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> We already do:
>     TEST_PY_TEST_SPEC: "not sleep"
> for every QEMU target in CI. The test fuzz-factor is generally enough
> for sandbox, but maybe we should just make that test opt-in.

It is useful to have it on real boards. For QEMU there is actually a
bug on x86 where the timer is wrong in some cases. Still, we are
making progress.

Regards,
Simon
