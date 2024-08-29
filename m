Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF14CC83F2E
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 15:04:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3E4588CEC;
	Thu, 29 Aug 2024 17:01:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lmmlY1+V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B57EC88CEA; Thu, 29 Aug 2024 17:01:53 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3CE988CB6
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 17:01:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6bf6e17cc2bso3925826d6.1
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 08:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724943710; x=1725548510; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lS+MHShgUtBpuITFG7AKiXdzJ+KmxoW++e24xvfJdQA=;
 b=lmmlY1+VQCMzorN+ATYdXzMp+aywdyvTASUL9T0Mj9cK0rJztNvNeDEVTI5/OayRaE
 ubYe9cehqGVS75PDqAXHITTuRYvESvgHe6PoDWN3L96lPLH/D/R5o06MegNyi0hBLrAu
 FIJlAZjtZA98FsGVDm9mNsx/vrYx1jamrS7i8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724943710; x=1725548510;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lS+MHShgUtBpuITFG7AKiXdzJ+KmxoW++e24xvfJdQA=;
 b=F8k4C8YccmdegFqi9UdM4EpM+3cnOrdCv3nbBttGlDckOdQVQ6V62khZcStZ5KRCHF
 RbgR1gRsuZadd4T1Bj9vsNZaM+47sZypt/w9to0pCs6Qf100Pw+PdMXvVZLF2ET8n3Lk
 yed1W6yRYxYPd6YIv2FpgVfMhBJ/BH4Gi/KVvU2Q0qJbr/Fzy/liRLCKm8GVkY+/GlrB
 Y1p5WY5StO1VBJorPYs0b2ghpSb+qm9tqMr3Pw+UNXiOuaz1CHIU8gfamJobJT0zAtGY
 oqOV7QpsWap5FdK3ML39yt4MfzKsDrPDvAvWT070w7JeqZpuBRNmQE/W3BDF9Is2kFhU
 NLcw==
X-Gm-Message-State: AOJu0Yy42i1Oyp855ytXqq80dUKQ75k8jhsquXcQ4dgWBKEKx8Lo4CD1
 /IOHhx1gvvGTUArMTiBPJOFe0q4sZnvNFXCBLm8PkQ33mL5EbGIr2r5u0cO89kiONe/tF0QFvUW
 /EdKKrDn+jSfhMyu8RVHVo56I6NJGMrs3BG01
X-Google-Smtp-Source: AGHT+IHTD08yARHXkCLX31LRfJzqiYBIdceMaZ+oF6lsT3IqRxKNP4YO4tIIcoJHfDqLyyUdWnmrb3Y0afZokX/Q/0w=
X-Received: by 2002:a05:6214:4381:b0:6b7:9a1c:713b with SMTP id
 6a1803df08f44-6c33e6835fdmr32953576d6.35.1724943710550; Thu, 29 Aug 2024
 08:01:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
 <20240816214436.1877263-8-raymond.mao@linaro.org>
In-Reply-To: <20240816214436.1877263-8-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 29 Aug 2024 09:01:39 -0600
Message-ID: <CAFLszTiWFD2dpb6z_5cibDe0aOpuPYug-mrC-ZiZ7v+SEDFhdQ@mail.gmail.com>
Subject: Re: [PATCH v6 07/28] hash: integrate hash on mbedtls
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com, 
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Andrew Davis <afd@ti.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Sumit Garg <sumit.garg@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Alexander Gendin <agendin@matrox.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
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

Hi Raymond,

On Fri, 16 Aug 2024 at 15:47, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Integrate common/hash.c on the hash shim layer so that hash APIs
> from mbedtls can be leveraged by boot/image and efi_loader.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Use the original head files instead of creating new ones.
> Changes in v3
> - Add handle checkers for malloc.
> Changes in v4
> - None.
> Changes in v5
> - Add __maybe_unused to solve linker errors in some platforms.
> - replace malloc with calloc.
> Changes in v6
> - None.
>
>  common/hash.c | 146 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 146 insertions(+)

I am not seeing the benefit of replacing U-Boot's hashing algorithms.
They work well and don't change. Also it seems to be making the code a
lot uglier, with an uncertain timeline for clean-up.

Can you do the rest of the integration first?

Regards,
Simon
