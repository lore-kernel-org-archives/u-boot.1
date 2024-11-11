Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66992D2E9F0
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 14:20:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E63DE89319;
	Mon, 11 Nov 2024 15:20:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="phr73sBi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94B7D8931A; Mon, 11 Nov 2024 15:20:53 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54EE688F3D
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 15:20:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2110a622d76so40348305ad.3
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 06:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731334850; x=1731939650; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rZRNJkqDRYlU/Odx+GEaKm3wG80814O2MwyxTFI/mLY=;
 b=phr73sBit8ttjWmG+vaArzCUfUts4860gI++3pv/1ki6MJgX9ieH4wZohz6T6t81Wn
 /qNqpXeRPkiAIpnGmV55lt5twXv7Qz7U91G0eG7aN9vTW43LllgUL0Dx2Xmg1CROdptu
 Ml+o24O1nRCXC6ouklfYsgzeqdC9sT43iwdmQip/U+4weN9q9/AmxuCM4IWFSzE/QUMy
 oiZFbcVhgxPeUP6xz7fpqyWqgPTUfkIp9CUOAPqNS9gYXqQ/gSYej7RwgIw2hKlbU6nf
 WsKUPhxkD7o8OPSyEVagmGkycvYkVRIarnZ3O9ACInLyV8MEWL3u4qWSOHwk8bOxwadd
 bRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731334850; x=1731939650;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rZRNJkqDRYlU/Odx+GEaKm3wG80814O2MwyxTFI/mLY=;
 b=uTrivd9GOmkhBb2xQ/q6LxlR2XCJrW+g2tXScfxrJn8G/NSONv4FLI45VIwrFJQAKL
 ZgQP2UbXl0ZxRIUgsYIY2qKqpsnlwNGAJKkSXv95uW/t8DO5VaEnhWmtZgTVE+Srj8zP
 cGZbAsn6ZvjKHOXBzd2HWxX3+ccqIpT48ecIXoYPzhrXilfa4kd7Lf5bKE10ppkWFyRa
 QWQvaI1IhFklV7MZ961XivXPcvZhKj/7LDczPUSNghxILq5MRHY81C34peZBh/cxy6QX
 ew/K/wiEJPxnonMrM/yBDwYwDUIW0A2dA2zkuf7s1D185/PMxsEJpsgCwjJB/KuWwYpv
 SdNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOnOUquag5q1IGLfS1kFwfXhP4C4Br6+GeSCS3wyhX8hzFLsqrhPgsuFvmcOrTPlRULT5RK+Q=@lists.denx.de
X-Gm-Message-State: AOJu0YyfwYIrRISIarTlcJcjATNqXk2rayNiowUzWplELF5uec0ls2LM
 bstYRA48BzGgoDL/6OtrFPM/KGFIdIRc8D8fUAbHBNZ9ZkCVMiR6W2SmG8pyA8kcCyitQmPQU+J
 Bp4w8bWVcji3/AxC60l3uIS0Wh4bE9Ay1x2ohCw==
X-Google-Smtp-Source: AGHT+IFf4Ns5Bj3CfAYidcNu74f9Q4qE3Sh92A8DFweZdf0Po4SrsaA+xugZPGBhdUbYhLN52T2mB5ohATane9e/vXU=
X-Received: by 2002:a17:902:c411:b0:20c:5b80:930f with SMTP id
 d9443c01a7336-21183c41e75mr140157995ad.12.1731334849845; Mon, 11 Nov 2024
 06:20:49 -0800 (PST)
MIME-Version: 1.0
References: <20241110083017.367565-1-ilias.apalodimas@linaro.org>
 <20241110083017.367565-5-ilias.apalodimas@linaro.org>
 <CAFLszThNpU2cNNvU4uT2vkgFKJr7ss=j_UYfXTFXA_b4=LnurA@mail.gmail.com>
In-Reply-To: <CAFLszThNpU2cNNvU4uT2vkgFKJr7ss=j_UYfXTFXA_b4=LnurA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 11 Nov 2024 16:20:13 +0200
Message-ID: <CAC_iWjKFxtBxEqkkXSOhcRqN4fRRgMcsmFRVYeNZOnR4zERrQQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] net: lwip: Enable https:// support for wget
To: Simon Glass <sjg@chromium.org>
Cc: jerome.forissier@linaro.org, Anton.Antonov@arm.com, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Jonathan Humphreys <j-humphreys@ti.com>,
 Wei Ming Chen <jj251510319013@gmail.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 u-boot@lists.denx.de
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

Thanks Simon,

On Mon, 11 Nov 2024 at 15:03, Simon Glass <sjg@chromium.org> wrote:
>
> On Sun, 10 Nov 2024 at 01:32, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > With the recent changes of lwip & mbedTLS we can now download from
> > https:// urls instead of just http://.
> > Adjust our wget lwip version parsing to support both URLs.
> > While at it adjust the default TCP window for QEMU since https seems to
> > require at least 16384
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >  cmd/Kconfig      | 19 +++++++++++
> >  net/lwip/Kconfig |  2 +-
> >  net/lwip/wget.c  | 86 +++++++++++++++++++++++++++++++++++++++++++-----
> >  3 files changed, 97 insertions(+), 10 deletions(-)
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> Some nits / questions
>
> I am not sure what mbedtls_hardware_poll() is,

It's an entropy collector used by mbedTLS to ensure the platform has
enough entropy.
It's required if your platform doesn't support standards like the
/dev/urandom or Windows CryptoAPI.

> but if @len is too
> short, would it be acceptable to return an error? How many bytes is it
> requesting in the https case?

If you don't return enough entropy https:// will fail and mbedTLS &
lwIP will print an error. I think we currently use 128 and the default
for mbedTLS is 32.

>
> uclass_first_device() if you want the first device, not uclass_get_device(...0)

Sure

Thanks
/Ilias

>
> Regards,
> Simon
