Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6767C54F2E
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 13:31:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37EDD83242;
	Fri, 23 May 2025 15:31:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KStFLGH2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5E7E83280; Fri, 23 May 2025 15:31:03 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C860C83236
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:31:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ad5740dd20eso940843866b.0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 06:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748007060; x=1748611860; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Wrbqc8avKCPdG94IS9QX1OhOBFnniV1Wi7DKwi1W974=;
 b=KStFLGH2ZurDKaQIP6jH0PaFcKvLWEL8q4aAAQD29rsIIla9f7QhjRWelvnJVKjqfh
 5eAZNC5eyQnIrkDIwGAIHVA5wrSRCot2n0O2Qx7VQe9Cv1upZUtKWDTSWKXa2OH3zZPE
 fjSQ76iiP1Ouxe8gM5ydi8DqeVNHk0zk7ou7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748007060; x=1748611860;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wrbqc8avKCPdG94IS9QX1OhOBFnniV1Wi7DKwi1W974=;
 b=k0NTwJwWaAEoxNaFIDjFOu0lzLO17nr6OCGFQdmaO+hDy2B6sZ5wbaDMnjWPFcQL4Q
 bdO9X5RatJ+uhCO2TkgfWXkOh2pyBIISnydGV68Q64xnsbffoFoyuClOPeJh/oq0yIpq
 LsbGDJnMEF4gWAJOjq3EcUoXx+oJGjZ8aSwIhQApcyAGfkjxexlwBgOEKLNkdeBjJ3od
 LEVlc61p2X9DyMkr8h2iK1u2P/gXXpXBjmvBWKyV86SiaHIcGsoRo8N6l5DpEfb/PYQk
 SmNfNwF8kEvFIPw8/PXtou92yBIlvvh9r7SpNNZimF/r55CcYVEPSYBzcE8oCfZ50dqH
 84hA==
X-Gm-Message-State: AOJu0Yx5pB/G8IbQGD0rgmvONbq2M1HXKC4OSUswzDGvXyfup3Mr7Ia+
 h9LiQYV3Y4ppj5V7K9IlTpyruL1+XJ9SOrtWRzfqDG87OyGCNtct8odPU/+91XthbnM9XF+EuQa
 qF9Y5A/G9BdTRqD4QOCvgXHNuBq8XcZ/5iWBOu2t7/OGB8PKF1H9h2sDYjQ4=
X-Gm-Gg: ASbGncvQEeC6jbPMShjjWoTqJvvpl3gFEXRu+Erk6sj9CmBm1ytluU4gKVZ9r/h06yL
 Jmz4BpYDscEvVtHtCUccJTvK+0tr/nb1ouCqg/PbNq3gbu3F4AweqjqOHq+PSZRSYR8Kpg8Ku6p
 BYAec5caHTfIg3SljgX2NLZXO3hL3fA03BHQ==
X-Google-Smtp-Source: AGHT+IESBd+hKhSKh21J4NQNwkMftSubSYsgNjdVbm6TLlJ4r8cKdAWNz+s4GGG30uqzWtBPrFKnozfeocpE5J8fuao=
X-Received: by 2002:a17:906:794a:b0:ad2:5408:bf1a with SMTP id
 a640c23a62f3a-ad71c697da1mr273407066b.61.1748007060189; Fri, 23 May 2025
 06:31:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250523130651.1329593-1-sjg@chromium.org>
 <20250523130651.1329593-2-sjg@chromium.org>
In-Reply-To: <20250523130651.1329593-2-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 May 2025 14:30:44 +0100
X-Gm-Features: AX0GCFt9uQLhHexXNqf9HXzJcRspMyZ0EoTVXrmP4c8w53zPKYLGJddkvN8MSws
Message-ID: <CAFLszTgXN6iksaMAGQwC7GqysKhpWFBx10pJphjdfujAX_dewQ@mail.gmail.com>
Subject: Re: [PATCH 01/10] efi_loader: Separate device path into its own header
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 =?UTF-8?Q?Christian_Kohlschu=CC=88tter?= <christian@kohlschutter.com>, 
 Daniel Golle <daniel@makrotopia.org>, Eddie James <eajames@linux.ibm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Janne Grunau <j@jannau.net>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Maks Mishin <maks.mishinfz@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Moritz Fischer <moritzf@google.com>, 
 Pawel Kochanowski <pkochanowski@sii.pl>, Raymond Mao <raymond.mao@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tim Harvey <tharvey@gateworks.com>, 
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <ziyao@disroot.org>
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

Hi,

On Fri, 23 May 2025 at 14:07, Simon Glass <sjg@chromium.org> wrote:
>
> These functions are useful for the EFI app. As a first step towards
> making these available outside lib/efi_loader, create a separate header
> file and include it where needed. Add proper comments to the functions,
> since many are missing at present.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  cmd/bootefi.c                              |   1 +
>  cmd/eficonfig.c                            |   1 +
>  cmd/efidebug.c                             |   1 +
>  include/efi_device_path.h                  | 419 +++++++++++++++++++++

Unfortunately this file needs a forward declaration at the top:

struct udevice;

[..]

Regards,
Simon
