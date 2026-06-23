Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B61CDB46F
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 14:47:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 456CC849E5;
	Tue, 23 Jun 2026 16:47:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P5pGKPIf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A04BB849C5; Tue, 23 Jun 2026 16:47:36 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA746849EA
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 16:47:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-697b8540279so3012678a12.0
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 07:47:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782226054; cv=none;
 d=google.com; s=arc-20240605;
 b=MGoS0af+UlYt87QJaoBjh10Y5D+9YmMD8GYuwDfyHTPJFpJSQEpIWJDcu07jd9Kggu
 +yjNc8kuaNICyknwQizpt7Gt8j0KeCbBt9y06Q3P2n3Vr0rNBatNrjEgjXt9AjZjq9+h
 WXoMKczpAKx31TBHNajhiq+3dSvkqjyoCRKUpgs+vAqsrN1STxbLq8ddW2Mew6Rr4SrO
 c1OwywqD2VIndckEm/nJEN4Kx2PoXG/NFcwSr1SzmmamCSamCgOSk3nIfP/7zEEjh4qo
 QgQ4RUFm1irxrhDbbj5HWxk5cUUlS0basOzzsVXB177qk3tVdrM2y9J3FBZQfuBol+VP
 stdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vGJ/M896Skt+wCLU1XLFusutYIS5nnu6Fqha0MD2QJw=;
 fh=EwJU1mVuO3sY+j+e45zVUlabzQ1yFmJAhesnaad0Pbo=;
 b=PEzCuTFSmnmSR0qLcSR9Q0IxRbsTCBz1Xa7bwgvFBcZOdFZymso7mXu/3ypI/7nyBT
 Z113NZzfb4UDAsrlXSG53kgeTWj+sKYNbkG3y4NNouRhPy1JthOzEyRTUkx5iCDAad1K
 J0DV+ca2vhAXsJoP5yBF3DZlw2XYSaKgZMMjVXBL3CMbCTBh5H/i7v7jp45sV49FQ9/d
 b0YsxEMuc2k5ZLFND5NqnCMKBg30je8GL3be/ebOU5TZVvfJ/ZxymL/jURHE1jX3hY9c
 3sD1dCbh1ARHYc+fMoyWHjnIs9TCfXz/vZKAzQfA+V/ieTCiRVDgFcCG73VhugSU+XFD
 H8sg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782226054; x=1782830854; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vGJ/M896Skt+wCLU1XLFusutYIS5nnu6Fqha0MD2QJw=;
 b=P5pGKPIfJrQF4eZVnc4OOwaTiqpEx4OFHenFQQiUXpCserirtHyMiI3CRrCN1XM0xS
 ecCM65M07V/ceikuaZ7lXM6UyIqa+C5INGVnOazyq/Zd28SkTyzlpcH/Z9IWAsGS1cH7
 eEZPZ17edgDxwQa2eZXZr+gs0D0sfnW/6HkHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782226054; x=1782830854;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vGJ/M896Skt+wCLU1XLFusutYIS5nnu6Fqha0MD2QJw=;
 b=kLrx/nOG7ilh7985nFLXl2lHA3kNHeGTdaSWA082w+UH4VZ3aTw/s+JYlSLGKx7R4y
 WwSSIkhkJr7akY3AXbA47vsoNsEvWPFgnpYTZ87FfL4HuIDxKN5TTWAZt3dgNlE8hJFS
 ITdc7sTGFVIsqE5jxvizWrB34woUeadL0rlDOglBZ0gGi5iGyrAPL1ybynomwtK0vYSx
 Dlfx8XTc0SYg77MQtgy6q3GKuL4t9LHER+0vYQrEA1yqtfMXNXOcpktlM0dHgQ7Lgrz9
 IAhEi5DL5g+KlrfmqBl3Ux2KxJCIJbDYc/NijJwcD4l8RH8xKytflnvfymNbxA0s/96P
 cZ4g==
X-Gm-Message-State: AOJu0YxIMJLeVLZ0+EHKa4V7vILK6hjHfSCoB2sncQvh7uUktjdfF/55
 pDMrXP0TpfK+w7tSbT1II3fyRUppwyHBPr/CCIRItWdorubj+dLFgeAWNTRbQZj/5anysp5JS8b
 hkJOa9NwxqlSI3QT4LGWtwGJIAszgJoC3UZ0xx1h0
X-Gm-Gg: AfdE7cnZ53WbpmwoQFlY9GUBsZY7+03xt5omNxUQq0R3437HT8aNXzdE+tWYlrYLJmZ
 PPfCwnwStHORxn06/LbkuoigITXbCnP0JD+dirNTWe75SS5yzo39/fOjE/jf77tT1XL3+digVaJ
 nZFrlGKRKcr6o+U6lJ86YPd0ajySqZXrSPDrs+eFSAV5+y+EJx2miMz+wGFSjySqnq2u26BIM3d
 Z/0wMm3UCsEe6fxAuNmpRGi6ZczrLU7ARuWwpoP5hom7Atls2cTNHsI8dghKS7cBoa0V8hczlsw
 Am5Pcprq
X-Received: by 2002:a05:6402:5309:b0:697:e6d1:d007 with SMTP id
 4fb4d7f45d1cf-697e6d1d17amr1015726a12.28.1782226054213; Tue, 23 Jun 2026
 07:47:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260619-riscv-full-fit-image-support-v1-0-c6477cf4f410@maquefel.me>
 <20260619-riscv-full-fit-image-support-v1-1-c6477cf4f410@maquefel.me>
In-Reply-To: <20260619-riscv-full-fit-image-support-v1-1-c6477cf4f410@maquefel.me>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 23 Jun 2026 15:47:22 +0100
X-Gm-Features: AVVi8Cc2rY5r9U1jZrxGBBDYjY1fqVdzcXc9UlQASNKox2AUSDQZjxu5HFGcLnE
Message-ID: <CAFLszTiF4Jz7d=PdXvXsusQZ5436qUaFMBYsa76CS_G6uHDwpQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] image: fit: allow IH_OS_OPENSBI in
 fit_image_load()
To: nikita.shubin@maquefel.me
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>,
 Frank Wunderlich <frank-w@public-files.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Rasmus Villemoes <ravi@prevas.dk>, Anshul Dalal <anshuld@ti.com>,
 Michael Walle <mwalle@kernel.org>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Dhruva Gole <d-gole@ti.com>, Richard Genoud <richard.genoud@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
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

Hi Nikita,

On 2026-06-19T12:52:56, Nikita Shubin <nikita.shubin@maquefel.me> wrote:
> image: fit: allow IH_OS_OPENSBI in fit_image_load()
>
> Add IH_OS_OPENSBI to the list of supported OS types in the os_ok check
> so that FIT images containing an OpenSBI firmware can be loaded without
> error. Otherwise loading OpenSBI in full FIT Image is not possible.
>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
>
> boot/image-fit.c | 1 +
>  1 file changed, 1 insertion(+)

> diff --git a/boot/image-fit.c b/boot/image-fit.c
> @@ -2258,6 +2258,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
>               fit_image_check_os(fit, noffset, IH_OS_U_BOOT) ||
>               fit_image_check_os(fit, noffset, IH_OS_TEE) ||
>               fit_image_check_os(fit, noffset, IH_OS_OPENRTOS) ||
> +             fit_image_check_os(fit, noffset, IH_OS_OPENSBI) |
>               fit_image_check_os(fit, noffset, IH_OS_EFI) ||

Should be || not |

Regards,
Simon
