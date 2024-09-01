Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8860FC54FC6
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 20:11:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1030D88B37;
	Sun,  1 Sep 2024 22:10:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NkpLJc+c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEDD588A7F; Sun,  1 Sep 2024 22:10:03 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A97488916
 for <u-boot@lists.denx.de>; Sun,  1 Sep 2024 22:10:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6c3552ce7faso14054846d6.1
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 13:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725221400; x=1725826200; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uryogDJyLXt2LRExw1W7g4B8IAPNAglgHem1CbZQe0o=;
 b=NkpLJc+c0NPObQ8EZlE88wiWtdGkUmNi+0CmawzeL4YVLCHAgKtKAmzwlxIDaEqV5j
 usS9brzYvJBktajMy71AEarrF7dz1klPzm7NUiMxqpXwtfN7uU5z1ro0t3ljAAQM8jUk
 JfR8q/yL0y+tGzslcEoTMGPqiREKRYGpNbUbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725221400; x=1725826200;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uryogDJyLXt2LRExw1W7g4B8IAPNAglgHem1CbZQe0o=;
 b=jYEbJX/6RxFQh6yWx8YCh9kP8SotaDE0qcwgom+/XKXUsaiAW6NLB7X6a0BeJdFGRh
 LGAkZ68jt+1kjDu48X42k2Cx7q6eCD231816XZLQGsD42XjfTsOX6H2jfJ6DQCCM/0ZK
 am5CzrSndhRMxeU3w7gENxL8yVhJpB8KGM1Om3EVD8DkhhpiTsN7DPCsGFNHY/NfZTJw
 r5lS7i2gxWYnJvIGeJGlgqELzB7pzKW9E8gn+dk+z7wVgKzT9SMtbazsRDPoQbDYB8Hs
 rFmloE1OOWyQt8Un1sbNjsiZFOVBlrI5gq9l+sxAEQJKvqEwX3UJBhQ73xjDu5Nvr/K+
 EkIA==
X-Gm-Message-State: AOJu0YzJ05YaTHSszHg/B5uBscLyCbXxb62hVrtHOWkIPDBgy4q8kTTt
 VCE6pQfyxExC1Jzi3upZxC2G2frDyZjFUtQ2CEZxN5IWYYHu4Wu9UNmk6r5MzWJXbBq3lvf6orC
 Olap43bdd0X9HiDR73PiC+OnLLN3WZ7VEK3MV
X-Google-Smtp-Source: AGHT+IFYUbodC5G99DM20jXSFZq2phsFIukzOVmr5iwjNzVoqFC+r7d1eBlQ/xwIqe0/qkqf9E/710zcytIeNw/Y07Y=
X-Received: by 2002:a05:6214:5294:b0:6c3:5ff2:7db3 with SMTP id
 6a1803df08f44-6c35ff2814fmr51699716d6.9.1725221400474; Sun, 01 Sep 2024
 13:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240823204824.443631-1-sjg@chromium.org>
 <20240823204824.443631-8-sjg@chromium.org>
 <da1bb893-a6f1-4dad-bacf-31e7b021d955@cherry.de>
In-Reply-To: <da1bb893-a6f1-4dad-bacf-31e7b021d955@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Sep 2024 14:09:48 -0600
Message-ID: <CAFLszTgDF8szR8JtC+Gp5H5zVnCUFsdH497Sn57kATAHz6oYDg@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] env: Provide a work-around for unquoting fdtfile
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Andrew Davis <afd@ti.com>, Bryan Brattlof <bb@ti.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Janne Grunau <j@jannau.net>,
 Jesse Taube <mr.bossman075@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>, Marek Vasut <marex@denx.de>, 
 Michal Simek <michal.simek@amd.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sumit Garg <sumit.garg@linaro.org>
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

Hi Quentin,

On Mon, 26 Aug 2024 at 09:56, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 8/23/24 10:48 PM, Simon Glass wrote:
> > Some boards use a CONFIG option to specify the value of this variable.
> > This is normally handled by efi_get_distro_fdt_name() but in the case
> > of sunxi this does not work, since 'soc' is sunxi, but the files are
> > in the allwinner directory.
> >
> > Provide a work-around for this particular case.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >   Makefile                  |  1 +
> >   doc/usage/environment.rst | 12 ++++++++++++
> >   2 files changed, 13 insertions(+)
> >
> > diff --git a/Makefile b/Makefile
> > index 9a52cc8d0b4..2452a916244 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1844,6 +1844,7 @@ quiet_cmd_gen_envp = ENVP    $@
> >               $(CPP) -P $(cpp_flags) -x assembler-with-cpp -undef \
> >                       -D__ASSEMBLY__ \
> >                       -D__UBOOT_CONFIG__ \
> > +                     -DDEFAULT_DEVICE_TREE=$(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE)) \
> >                       -I . -I include -I $(srctree)/include \
> >                       -include linux/kconfig.h -include include/config.h \
> >                       -I$(srctree)/arch/$(ARCH)/include \
> > diff --git a/doc/usage/environment.rst b/doc/usage/environment.rst
> > index cc33d3ec0f2..eaebf61742a 100644
> > --- a/doc/usage/environment.rst
> > +++ b/doc/usage/environment.rst
> > @@ -87,6 +87,18 @@ settings. For example::
> >
> >      #include <env/ti/mmc.env>
> >
> > +Quotes are not supressed, for example::
>
> s/supressed/suppressed/
>
> > +
> > +    fdtfile=CONFIG_DEFAULT_DEVICE_TREE.dtb
> > +    # produces: fdtfile="sun7i-a20-pcduino3.dtb"
> > +
>
> Is this not rather
> fdtfile="sun7i-a20-pcduino3".dtb
> ? (i have no clue but I've this gut feeling this doesn't match what the
> subst command does above and why the .dtb extension would be inside the
> quotes)

No, I promise! The quote get removed by the Makefile rule so the -D
compiler option uses an unquoted string

>
> > +For this particular issue you can use DEFAULT_DEVICE_TREE instead::
>
> Maybe use double tickquotes to highlight this is a variable? i.e.
>
> ``DEFAULT_DEVICE_TREE``
>
> ?

Will do.

Regards,
Simon
