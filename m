Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31294C87FD2
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 07:49:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B29F833D7;
	Tue,  5 Aug 2025 09:49:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mwYQjq0d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A50D839D6; Tue,  5 Aug 2025 09:49:10 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6ED44833D1
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 09:49:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-615d1865b2dso6324623a12.0
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 00:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754380148; x=1754984948; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JVWzo2daREW3rJPUCK8vH44L/64kdE6s42Aed6nB/I0=;
 b=mwYQjq0dykobmV1THAhQunQw2dpnFl0Y6Xp37VckuObykHWhYYPDNQG20S6SViBkXU
 DC53vikCaPQKvBqrpi6g1zEwPjKXd9zX8qoiMjyXbuTWXlmrp/TGgDEqM4xaEFnhuMG2
 4pZXUPmXkGf4LBHYeqljMsugQkhroLmSBo7mKKH3wqA8iejMW501a5C/h2KTX0KXzSnh
 5ns+7nLdmZ6ib3JKO5FUhpnoToHXFj5aH/akwuacFDf4Af1dTL9yxuz3ZLZv4zO8dCIW
 tesj7lm03bX2A2ZS6jVHJlN+mvGvWrCAyKsAAXyF8JWA7ha3PYbS+8RWgM1ww+xEmvFe
 JRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754380148; x=1754984948;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JVWzo2daREW3rJPUCK8vH44L/64kdE6s42Aed6nB/I0=;
 b=JY/oKRI95RsW3R2/ajmKiLMSCcrJ2nua+IF+ovkl15jodj1tJ4TxPdj7XI47pchIbI
 JSTtoA22dy117aqr4SI+jOZJjHfjDr3Ozs5p1uhEezGl45YFj9KJmWq951YDsDB4hoLu
 qALKvawWVwqus9V9q7GUbedk96kzUg1ENuvEy2hY65uIfO34IRZD3TPDXABHvpnvYNEI
 s0r20OyziU4aO4ENRxcnQ1Bn/vnN17xMZf8/LyaF4xBmAvECd/NXxKcv7AAUSXOF5nvz
 X4fDKiFaLcoNCg/LR3F34V3p7t9EJBVpXKYmhUm9S2SOHVMKVqbqREJ0T8t51AJqRFtj
 Rxag==
X-Gm-Message-State: AOJu0Yw8YziXj3E8hlSXm5AJzso2QtdMWpOmfOAeo5Gsa8OfusFapZx6
 bJrVwC1n+PjmIhAvOYV1ZHCa0AJFXC/Ft8Or3oD0toSNs/qtIrIo/Yq9JrZM1rlCEd8NOCN60XZ
 4gQ/AyPXrzz6z4Ex1yoGuH/qQolnAIT4=
X-Gm-Gg: ASbGncun9CfChYhEn5lfDXt4yL7wNwOdaE/sIsnOuJ9luie3W3akmpqM3w5uJIsZ6Yu
 gYJfNYAlg/3U3EqNSG+KfE6kzMjlcFHB+wcpt2jJiVxjHXwE39XQFupg4VO/3paVtvLBOn8xk6p
 NjgAl6Jif8XIO1wg7FadGw7NF79hsKeYQHtaOrhfTtt0Ha4uooyXUiEWMvOerH8DpG8CLGp1ddS
 zbGt/wR/cFR2DKbaCQWFhOtaoQshgUauAk=
X-Google-Smtp-Source: AGHT+IH+4W/qZbjfto7ui6qMSJCysQsOW0UsikND4oILsy1N6WB6yrMv/HUIJGJuhXRbGlWTLdHVIX851oGqiisjXOg=
X-Received: by 2002:aa7:c858:0:b0:615:a3f9:7be2 with SMTP id
 4fb4d7f45d1cf-615e71451cfmr9103426a12.19.1754380147636; Tue, 05 Aug 2025
 00:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250804215719.1413106-1-trini@konsulko.com>
 <20250804215719.1413106-10-trini@konsulko.com>
In-Reply-To: <20250804215719.1413106-10-trini@konsulko.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 5 Aug 2025 08:48:55 +0100
X-Gm-Features: Ac12FXzhsEFblEzJYOoM6ZQhrNQarDLeA7VEFJPBdEcApLJW9X6-ugRkXYvq2H0
Message-ID: <CALeDE9OsF1ybUUGY4Fm-Uz2B3LxCce-KHymh9B6yHArK9J2kvA@mail.gmail.com>
Subject: Re: [PATCH] sysreset: Tighten some sysreset driver dependencies
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Mon, 4 Aug 2025 at 23:05, Tom Rini <trini@konsulko.com> wrote:
>
> The MPC83xx sysreset driver cannot build without access to some
> architecture specific header files. Express that requirements in Kconfig
> as well.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  drivers/sysreset/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
> index 67edf004205c..0181f6cd5819 100644
> --- a/drivers/sysreset/Kconfig
> +++ b/drivers/sysreset/Kconfig
> @@ -283,6 +283,7 @@ config SYSRESET_TPL_X86
>
>  config SYSRESET_MPC83XX
>         bool "Enable support MPC83xx SoC family reboot driver"
> +       depends on PPC
>         help
>           Reboot support for NXP MPC83xx SoCs.
>
> --
> 2.43.0
>
