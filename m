Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 987A2CFB458
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 19:49:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C44F88D1C;
	Mon,  7 Oct 2024 21:49:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="JNfE5Yun";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEA5688D25; Mon,  7 Oct 2024 21:49:43 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9580A88B9E
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 21:49:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a995f56ea2dso141610466b.1
 for <u-boot@lists.denx.de>; Mon, 07 Oct 2024 12:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1728330579; x=1728935379;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nFysOoFqVibYx6oe+6JJ6tr3fzUp+zRALau5uYUHzlQ=;
 b=JNfE5YunPM3Ss20+ueH1JzIdZyMu7aM0uEkwNQ3Dcai5/AK/exLoit5SFzDqUe/3bF
 iTUEuFB5/mLLmXQc1futai7lVlKNrliuU9WWdBTt2DhjAvNmll9Nd6NWIcVNhfNYjPnS
 AzP55c/+alGD7M0EU+y07aC2lSKIdY+6rHhg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728330579; x=1728935379;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nFysOoFqVibYx6oe+6JJ6tr3fzUp+zRALau5uYUHzlQ=;
 b=R4Oxct2F4L/xDxzfWWIXISM4KG9sdA2PF3lBuqE6GIH0tRfixV1SA9sVvkEQGlSNXr
 yos+GrzovUm4QA19ZrWH91TxSYnSvS3y11lQb4sdyDvgUjHa5529Fg0BfUhEmogkaPZL
 5uv3+2Tl6LEj7oF1wSA85D3hFeh1jZM1ygaFHXcbxJHDLka2gn+bLxpMU6xk8JttQw43
 0j4K8qUJV7DE4DKbiW2lpyCqI6NyVatee1rBeYJl6VBxsjbEv1aL7BawQnoOXqgzASV7
 OIVp8GHH0l75GEdeg1tnRishMsJIzYw5ZaLgIGY1f3gyebu2fkhzOUPFhhDTEgWD8HcI
 ROPQ==
X-Gm-Message-State: AOJu0Yy5Z2ENsjwrImTblTOxFsRInwR4YrTWUmOi8r6b+bKgVf7Fs2l2
 7FEKe+eVMTJfmgxpReu3sIWTd/syVKvcrHP7cEp1hcZCvr4BH5XzBWMDMtkoyW3liGTLqoZyrPO
 dnPmoUBX5QxpJyzQpidmVFbPI/D3EqTJaeWPr9A==
X-Google-Smtp-Source: AGHT+IHlZxFWNLWR41uE+KNBTP9RmB2lJed5i54TNLviSBdfgdjRBXV8yaEI5wqGFf8ZPkQ0nVscOCIY4BIKuK3yiak=
X-Received: by 2002:a17:907:7206:b0:a99:3dbf:648d with SMTP id
 a640c23a62f3a-a993dbf6715mr754981866b.45.1728330578953; Mon, 07 Oct 2024
 12:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240930-bcmbca-nand-support-v1-0-e637c65de947@linaro.org>
 <20240930-bcmbca-nand-support-v1-3-e637c65de947@linaro.org>
In-Reply-To: <20240930-bcmbca-nand-support-v1-3-e637c65de947@linaro.org>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 7 Oct 2024 21:49:27 +0200
Message-ID: <CAOf5uwmajrFCddby9bs9JQFDbr5c=4y8he_PXb5UQZRNO1X-GQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] drivers: nand: bcmbca: Enable on BCM6846
To: Linus Walleij <linus.walleij@linaro.org>
Cc: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anand Gore <anand.gore@broadcom.com>,
 William Zhang <william.zhang@broadcom.com>, 
 Kursad Oney <kursad.oney@broadcom.com>,
 Philippe Reynes <philippe.reynes@softathome.com>
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

Hi

On Mon, Sep 30, 2024 at 3:25=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> The BCM6846 has the BRCMBCA NAND controller so enable
> it.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/mach-bcmbca/bcm6846/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm/mach-bcmbca/bcm6846/Kconfig b/arch/arm/mach-bcmbca/=
bcm6846/Kconfig
> index 229ab88dbb0d..5ef9535369ec 100644
> --- a/arch/arm/mach-bcmbca/bcm6846/Kconfig
> +++ b/arch/arm/mach-bcmbca/bcm6846/Kconfig
> @@ -8,6 +8,9 @@ if BCM6846
>  config TARGET_BCM96846
>         bool "Broadcom 6846 Reference Board"
>         depends on ARCH_BCMBCA
> +       imply MTD_RAW_NAND
> +       imply NAND_BRCMNAND
> +       imply NAND_BRCMNAND_BCMBCA
>
>  config SYS_SOC
>         default "bcm6846"
>

Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>
> --
> 2.46.1
>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
