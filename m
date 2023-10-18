Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E8E5CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 03:32:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3132E86F1E;
	Wed, 18 Oct 2023 05:31:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JqZwJN81";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1B2686F45; Wed, 18 Oct 2023 05:31:56 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02E1886F1E
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 05:31:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-523100882f2so10554998a12.2
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 20:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697599914; x=1698204714; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zACopg5I2b4fzvkrrnKj4NzJNZpmdcNooY4JTVI/SvE=;
 b=JqZwJN81kkm5BUlNhEyhEMxjWJM9MxlhHDwH65FQtQWss0zMwBrDp2w6h7efdlnxDD
 Ka3nRtHfwRMIW7SFxpo08ULmelOsFc9wotSLUU9OGS+yKDQ2Z2GtF9LTz+scg34nUl6l
 eZoM2UCnaB3sPS8cqey/UyqVKg8ZRJoRJg7Ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697599914; x=1698204714;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zACopg5I2b4fzvkrrnKj4NzJNZpmdcNooY4JTVI/SvE=;
 b=Mv1zkTcLXV68cG970SSHE7xYBlgZmpb4DmkuC2rQdCR36ICCEgc/GzB6DEAddwlvhV
 LbpnacAiO5ppjwtzg+/HWPoPPTMg3Hqf/PaF+hj07eovOr5ejfalndvGNqbCTLvh0MG4
 KjCcW2rMtU4F1093+AvwgFV9VIeTIH+1SQnWfPb8ZTORM3VVXWO30IBO/lzE6GFhRYTq
 yGWk2g400LXfaDiBNMtW7M3Gljifi/Z+GiE3NmfugR1V8c6Pj2JmVrJ8o9w0RjaZg611
 9GiQW9NKwikHYAWWMqW4QBX9kIwQWoOSH+0Y5T7hL1lZqLZfPI0ZJOJp9IR9ecDLYanN
 yHYQ==
X-Gm-Message-State: AOJu0Yw1BFapyBXrHE/Bx+60atrsLKFpVtoInZL8Ug5a9Vs9qBpsAf6s
 o7PP1U5oXV6lrqjSjMLXTGd0m5NKnYRJtY4m0/0AbvHlxTy4qK9GbDc=
X-Google-Smtp-Source: AGHT+IGgmU1c+KKW+Yi18ZbRA11SR+8POIGl6wGY95eqo6OG64l/jS8gfhnkgMnWDAs+RZt0CaMdkxnXxs+OMJv0wFI=
X-Received: by 2002:a17:907:97c3:b0:9c5:8a6b:29e with SMTP id
 js3-20020a17090797c300b009c58a6b029emr3199481ejc.13.1697599914371; Tue, 17
 Oct 2023 20:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-22-sjg@chromium.org>
 <20231017141320.GD3119521@bill-the-cat>
In-Reply-To: <20231017141320.GD3119521@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 17 Oct 2023 21:31:43 -0600
Message-ID: <CAPnjgZ39eOwfTOoGi1uNJPNZqJcuKfnVNhVxha7DDE=Mh8rkhQ@mail.gmail.com>
Subject: Re: [PATCH v3 21/32] efi: Rearrange the Kconfig for
 CMD_BOOTEFI_BOOTMGR
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
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

On Tue, Oct 17, 2023, 07:13 Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Oct 16, 2023 at 04:28:12PM -0600, Simon Glass wrote:
> > The command should not be used to enable library functionality. Add a
> > new BOOTEFI_BOOTMGR Kconfig for that. Adjust the conditions so that the
> > same code is built.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Suggested-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> [snip]
> > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > index 621ed5e5b0fb..13cad6342c36 100644
> > --- a/lib/efi_loader/Kconfig
> > +++ b/lib/efi_loader/Kconfig
> > @@ -32,15 +32,14 @@ config EFI_LOADER
> >
> >  if EFI_LOADER
> >
> > -config CMD_BOOTEFI_BOOTMGR
> > +config BOOTEFI_BOOTMGR
> >       bool "UEFI Boot Manager"
> > -     depends on CMDLINE
>
> This is another example of why I'm asking for re-ordering things so that
> first you clean / re-order things then you make all of CMD depend on
> CMDLINE.  This patch, aside from other feedback, is standalone, if you
> do that.

This patch is before the one that makes all of CMD depend on CMDLINE.

Regards,
Simon
