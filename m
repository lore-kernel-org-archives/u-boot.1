Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AAAFC04FFE
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 14:33:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F9FC887A4;
	Wed,  8 May 2024 16:33:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RzW3fKzI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2625E887DC; Wed,  8 May 2024 16:33:19 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26706887A4
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 16:33:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2df848f9325so51333901fa.1
 for <u-boot@lists.denx.de>; Wed, 08 May 2024 07:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715178796; x=1715783596; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xq2zLyDXA7QhkaRmT3Irxya55MKm1ktHeDa6s4lSxV0=;
 b=RzW3fKzInNXBU8YGyjJe938fLaHPQohIe1I/VGh1Guue6FeCCCsZ8bPDPC7FmcLvIc
 rLYsMZi+JcTm7tHQ0+HTqIILjGf86/vInSOhzT1eUpcqKW6NvChd4dFqjAF6dKI1yWtB
 FgIJ7fCUT34f/COgOs8MxwlArtXyUJw51+H0kFgrXHyRS8yBnUIi8pwhVR8BruEf/TMn
 069wdKWhGOkhVgkMgoGH4/HbssF0UJhjbCf8JNsL816vIJqNfXaCafkLuIrChHoGXn7f
 REKWWfzaKV/3Kqcp0F7sMN8xHw9MtV6gcylJeHkrNf6/knHRuwn3wMXa+XVdE3ergjz1
 vWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715178796; x=1715783596;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xq2zLyDXA7QhkaRmT3Irxya55MKm1ktHeDa6s4lSxV0=;
 b=kMpRy2N09jZ0OYECBNqxPexEDOD/lpLc3GW49KgW9568wChFX71radtNwkbflklwV1
 Z2K6EoIpkFcoPCDQNf+RokDcQLffwh6Vmlx/ryz8+PoEZ5stKgrIHEqeCE1aQxM9aHqX
 lU2dbxPv0q77NVLBmm/wIRzuY0957x4pbJgp25SqV1Vf/Lf8P9KbdlskP7qTl2ytjIu1
 g8Hx6YmLyqIZ0vVFKt1ijHW7aQGyGnameyLGx+h7jkaO+bVrcXaTogr37o0hqzKjEnKx
 MjhxfUWBas+Rf3xnz5R2wOU4DtVjZcYK15NBt1qfc7wSt5UjLtZyBfkJ4CvNoCUYAmF7
 0pUA==
X-Gm-Message-State: AOJu0YzwERf0RuwvJzGLFLMy1X0KsPNVVKd9BgQ1t1yVGQ/KZsdAppJh
 fE5fz8IuXLAg14O9ja6CS/bo6Gz62M8roA+CtsXvz8aM7U9zfAsWpC7zSiEie56mSHwQnil8cD0
 2ds368EDWq8gag9IimSP7bmyK+Tup8C9c1L17Cg==
X-Google-Smtp-Source: AGHT+IHFnyWB7GCZ6H2Oo7Jm9Ck9iBZcq2h8OCL5T/BCO4KyLfDumXGo69NjKWMXDz83Opd0PolZdvzNYIdAKtwbQ1Y=
X-Received: by 2002:a2e:3017:0:b0:2da:d2b8:ffb0 with SMTP id
 38308e7fff4ca-2e4475a0e46mr17591491fa.41.1715178796393; Wed, 08 May 2024
 07:33:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240507175132.1456512-1-raymond.mao@linaro.org>
 <20240507175132.1456512-16-raymond.mao@linaro.org>
In-Reply-To: <20240507175132.1456512-16-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 8 May 2024 17:32:17 +0300
Message-ID: <CAC_iWjJ2nNub7q-qnR2jj-uh6oE2VicLtZETRWOoCGpiMmCLog@mail.gmail.com>
Subject: Re: [PATCH v2 15/28] mbedtls/external: update MbedTLS PKCS7 test
 suites
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Simon Glass <sjg@chromium.org>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Andrew Davis <afd@ti.com>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, Ilya Lukin <4.shket@gmail.com>, 
 Sergei Antonov <saproj@gmail.com>, Bin Meng <bmeng@tinylab.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, 
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>
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

On Tue, 7 May 2024 at 20:58, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Update the PKCS7 test suites for multiple certs.

Please explain why. Does this belong to U-Boot or the patch should be
sent to mbedTLS directly?

Thanks
/Ilias
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - None.
>
>  .../external/mbedtls/tests/suites/test_suite_pkcs7.data       | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/mbedtls/external/mbedtls/tests/suites/test_suite_pkcs7.data b/lib/mbedtls/external/mbedtls/tests/suites/test_suite_pkcs7.data
> index d3b83cdf0aa..2dd1c56109f 100644
> --- a/lib/mbedtls/external/mbedtls/tests/suites/test_suite_pkcs7.data
> +++ b/lib/mbedtls/external/mbedtls/tests/suites/test_suite_pkcs7.data
> @@ -14,9 +14,9 @@ PKCS7 Signed Data Parse with zero signers
>  depends_on:MBEDTLS_MD_CAN_SHA256
>  pkcs7_parse:"data_files/pkcs7_data_no_signers.der":MBEDTLS_PKCS7_SIGNED_DATA
>
> -PKCS7 Signed Data Parse Fail with multiple certs #4
> +PKCS7 Signed Data Parse Pass with multiple certs #4
>  depends_on:MBEDTLS_MD_CAN_SHA256:MBEDTLS_RSA_C
> -pkcs7_parse:"data_files/pkcs7_data_multiple_certs_signed.der":MBEDTLS_ERR_PKCS7_FEATURE_UNAVAILABLE
> +pkcs7_parse:"data_files/pkcs7_data_multiple_certs_signed.der":MBEDTLS_PKCS7_SIGNED_DATA
>
>  PKCS7 Signed Data Parse Fail with corrupted cert #5.0
>  depends_on:MBEDTLS_MD_CAN_SHA256:MBEDTLS_RSA_C
> --
> 2.25.1
>
