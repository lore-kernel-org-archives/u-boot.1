Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC90CC46CA1
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 03:52:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9FAA86F47;
	Thu, 12 Oct 2023 05:46:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DXbwGPG3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24B4086E51; Thu, 12 Oct 2023 05:46:28 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F34E586EBC
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 05:46:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5a2536adaf3so7549297b3.2
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697082385; x=1697687185; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F5YP9U39QEWIYWeRZ8VQpcnVfFYx9GPdx0sDtaZdV3E=;
 b=DXbwGPG3Zxv5hHQzxdet9DhmzlyiwIPOTMZxXj1VSfVgC0MlPJ6gqofJv+jdv4ciFw
 SJLKqGMz0Y+nYSSSvUGXYCTIl2kPBIkVAHtB7QSLVgxcBXpzJTsE1RTuarpZaKzTa6T6
 cFpQmerawS2sYKQlXL91XQZW0VOPtkIZ7aRGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697082385; x=1697687185;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F5YP9U39QEWIYWeRZ8VQpcnVfFYx9GPdx0sDtaZdV3E=;
 b=ROlHI3jB5cbr4Ue4I5vR6ibHX4rFbdA4vyndq+Q2OuL3l3Xl3KDvx0q3blhAQ4pgLl
 vuR09qELtStZNdBFcqHo18htqVblbm4f4dCzBtESZkYRpB7VMOR/ixsyrZTYgntaJbgn
 Qusaa+2J/20WGH4LI1SWa8NS+juYxc+Fj4zBDzoN75gL6Opam4LadQCCYpuMYdZJATby
 ds3gny5M1piRkQopM+WM1Z2T3rmxMkeomcpQpPfnzShscCeneUJI4+yQRsnTUMsJLnMq
 IOCKUwpy03tiAipb89mhlHpHd9eOMFGlBW/V/OsKzP4pJUyBcQ54l7xPyxprE0BR6LgV
 FQHw==
X-Gm-Message-State: AOJu0Yw7rZfbO3vHpBYg4w/MftCiRAQKnmpaBEDLy4kyCtM2iXfp96gS
 u6HAovJYCdSHWwhmJcC/B5p52nsbGSUqEkXHM8QO5yE2DOkvJC36fTo=
X-Google-Smtp-Source: AGHT+IH9bz16VdgflRguIociYTEiGz9pW+bx3JWEoCb+KowdjtfHgFd7fShndJ/4nP88/Qp0Pg4St87ySzf7mqHTCgI=
X-Received: by 2002:a0d:dfc6:0:b0:57a:2e83:4daf with SMTP id
 i189-20020a0ddfc6000000b0057a2e834dafmr23366913ywe.32.1697082384598; Wed, 11
 Oct 2023 20:46:24 -0700 (PDT)
MIME-Version: 1.0
References: <20231011153020.1008123-1-mchitale@ventanamicro.com>
In-Reply-To: <20231011153020.1008123-1-mchitale@ventanamicro.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Oct 2023 20:45:22 -0700
Message-ID: <CAPnjgZ2kv4V5NGBdTTMfBXPJm9wyFOwbnCz87HurRTQc=eQZTw@mail.gmail.com>
Subject: Re: [PATCH] riscv: binman: Fix compilation error
To: Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Yu Chien Peter Lin <peterlin@andestech.com>, u-boot@lists.denx.de
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

On Wed, 11 Oct 2023 at 08:30, Mayuresh Chitale
<mchitale@ventanamicro.com> wrote:
>
> Some platforms may not have any DDR memory below 4G and for such platforms
> the TEXT_BASE and LOAD addresses etc are all 64 bit addresses due to
> which the u-boot build fails with below error:
>
> u-boot/arch/riscv/dts/binman.dtsi:30.14-25
> Value out of range for 32-bit array element
> u-boot/arch/riscv/dts/binman.dtsi:43.14-25
> Value out of range for 32-bit array element
> u-boot/arch/riscv/dts/binman.dtsi:44.15-26
> Value out of range for 32-bit array element
> FATAL ERROR: Syntax error parsing input tree
>
> Fix by setting the address-cells property to 2 and converting load
> addresses to 64 bit values.
>
> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> ---
>  arch/riscv/dts/binman.dtsi | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
