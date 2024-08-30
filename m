Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A283CA0FE1
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 12:01:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CB3588AB2;
	Fri, 30 Aug 2024 14:01:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F1kGJy4U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A93988AB2; Fri, 30 Aug 2024 14:01:15 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A26488A5B
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 14:01:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2f5064816edso18695691fa.3
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 05:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725019273; x=1725624073; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PFPoLhuPITbV4+HRiJRrZOOZPNRlgHCRpXsgVK7IW64=;
 b=F1kGJy4UQiFmBU+9VIsGoqH9CElNSLouM8OwsSArUQCv9lVuLFijyzcN6wMEwo5dsU
 l3RXaC90AJGtodX3eTLC6WlR/EM6S4X1Rx1MWzC0G+sNonNbfq2YS4nl8dKAR2QaUTyK
 DvnFb217LItw04Y+HB1mB+HSsO56FX/wHyrIal+D9XXyhECcdubuMS158/2d8B4eISV0
 /a1thAFpmO/8DQuCBZUvqr3DNO65q+DBe2Copvo9YLA+lmHjcXB3NyXoBZJ2cP8H5wG1
 /38pBVrVlQ6T/bGrAmH3SjCQmMgjZE6hayI1GUgC+1oMWPZnetmbmQwXtO1w0spmaP9A
 1v0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725019273; x=1725624073;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PFPoLhuPITbV4+HRiJRrZOOZPNRlgHCRpXsgVK7IW64=;
 b=nQiFNGyWd3SikAiV9ExmjjUH4TunKlk6Tz4JpjWTybtpVVQm5cbsJFRW1vjKlHG/7a
 kqtgJfssDPw+vMG301Ow2NEUuUTKpJG8IPpbfRopBDZmfnjayRC/1VbAAuU8onteYztD
 1jE09s75POgM0mgDPf4zM8l4Ivso+IPjfk7U424W8wUjKwhefDbL5Dsvj5R9khMPu93i
 Kx3BpMsiLrsdYQtmT2ECurEazxvXQgXhIEFxNuJ+y9f9BnLSITgFB4vGHAQ/G3iqqkCk
 NKEikwJ0EFNkLO7YY0zE7+3Y/mRqPiN4fuQdq8Ow0QCTgsGKFG20IItdZ7WsbehgZG8s
 dmLg==
X-Gm-Message-State: AOJu0YxIOEI1LPMJMKDyl+Q3ycISY+hM4WDmMvj0i5bGgyDFFqeCPbp/
 YaEL7CiypEBSS98fDNChJyijEhGeAVuLqmL7OL8SGHO5JwPFdflviPS1p+qP26Pgod/4jd0gmFw
 SCo7zqrfcluyGYsZjPXbHgVeFrkXMco3D
X-Google-Smtp-Source: AGHT+IGt4uHdFhWwNVCvwWYw/pA7KQQVEPghfgpJ/e44nobzFNFgAsKk4vVzjK8N7Ljy6CJITbN/1b4GxmOWhf3oPPQ=
X-Received: by 2002:a2e:e02:0:b0:2f1:563d:ec8a with SMTP id
 38308e7fff4ca-2f61054a85dmr33997071fa.41.1725019271709; Fri, 30 Aug 2024
 05:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1725012294.git.jerome.forissier@linaro.org>
 <ba3bd0c9116b3338e4d08f4c2caebf5818c0d94e.1725012294.git.jerome.forissier@linaro.org>
In-Reply-To: <ba3bd0c9116b3338e4d08f4c2caebf5818c0d94e.1725012294.git.jerome.forissier@linaro.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 30 Aug 2024 13:01:00 +0100
Message-ID: <CALeDE9OD++3rYgGSuNd++3Ap0QeF7DJD+zDrXEwaX-S01jrazg@mail.gmail.com>
Subject: Re: [PATCH v2 15/16] common: update: UPDATE_COMMON implies
 CMD_TFTPBOOT
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, 
 Devarsh Thakkar <devarsht@ti.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
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

On Fri, 30 Aug 2024 at 11:17, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> common/update.c (UPDATE_COMMON) depends on tftp_timeout_ms which is
> defined in cmd/tftp.c (CMD_TFTPBOOT). Therefore add the appropriate
> imply statement to Kconfig.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  common/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/common/Kconfig b/common/Kconfig
> index 83c81edac2..968d4fb66a 100644
> --- a/common/Kconfig
> +++ b/common/Kconfig
> @@ -934,6 +934,7 @@ menu "Update support"
>  config UPDATE_COMMON
>         bool
>         select DFU_WRITE_ALT
> +       imply CMD_TFTPBOOT
>
>  config UPDATE_TFTP
>         bool "Auto-update using fitImage via TFTP"
> --
> 2.40.1
>
