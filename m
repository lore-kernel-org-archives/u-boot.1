Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39634C7EE39
	for <u-boot@archiver.kernel.org>; Sun, 29 Jun 2025 14:46:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90DAC82EB8;
	Sun, 29 Jun 2025 16:46:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="j5QPWds1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B95C382ED0; Sun, 29 Jun 2025 16:46:11 +0200 (CEST)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6484481E13
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 16:46:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-4a44e94f0b0so52050891cf.1
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 07:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751208366; x=1751813166; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LoX94s2UPjs0Ked4mWQtyKUe6N7c1nHtD7Omgn7WtDM=;
 b=j5QPWds1Z40e/J/Wcl8sRDLDhe47dTHF9qBlNgyZfQ3qXSInoSWTrVbvMhC/aj1e+I
 36U85mn3uFU9OvcW1W9ATwzutZUq5tpkSGl/1yXEOZ8XhXh7kDEcYLphZQVnY94IWTAY
 Jn9rTD6cetxKOUqcqRBDewiQmDVUqNhBXLfvX0fCj/rG8bvOuSorS3k56tuG4YeAgOgF
 +mSvbp+YNPTGmb+F+Qko6gZX0qy+szLoSGSAeh60s7J9JpAqK4gr5Dk5rLTcy05pdc7U
 6rbPWHU38B7iSQRja0eucTS7KeJE7Vj80MAr2qfNDvlFr+sA7zNI3Z2EFbbsypBr5DQa
 MwMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751208366; x=1751813166;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LoX94s2UPjs0Ked4mWQtyKUe6N7c1nHtD7Omgn7WtDM=;
 b=QBqrLhRHHIJ6ypUSzebsi8b8BGQlF8LSUJKKJVK+dNFT1j9zSENW592TG8A8MA3KEU
 5fn9yiErYycVBoiZYRdaZxI+EEvl/zlL/DpZJG6l1sr277urICIFv3PWX9MNwcJDKp7i
 QIFPlR++anOss7s77UXRHiLi55KZujfrV+gP3UqaQdVbDAPsZq6cQDJbCkb2Hk5ze//O
 teVoEbabzXkBO3dSF5LCnGPBX4q2Trah6ZWIV/UOzGYAEQHyg5tkEiCh9eyGIY7EaeA4
 +A9y7OrZbWp1ZiApcJSGrIcyLNTaQGfqs5R8jMWc9vyrahECxcVyTbjj/YwAnA0O8wwW
 5Dzw==
X-Gm-Message-State: AOJu0Yx2xBCFoLonhp1jUV1AwkW2r9CdoI7Ej5aj9xJ83nfU3CE/6ZsR
 zejpPcdlA098KsW1E/tcN61QdkFDuYIiamiZamFCVDxRCbTx76KT2+hL6QkS9gN4/Y0nAkPW7fP
 RqHivet/PFpHn2feNX/UeUi9unGpL98CHMDDcHVA1hjBnUTKB9smMJUo=
X-Gm-Gg: ASbGncsE/i9cNOkjWVLLLmLtKnpRebW+al9vL2DGiK6QgxSTM51g1KedSx73L86Nt1U
 UEdWfGhAbEcVHN22tNCNnkxOJ1VurchI74aB7zP1pDrxEEnmJPY01g/bZaXaH9khZfassXuKXy3
 iQXig6oEglM7s1eYphRjsb5z+Gw5plNXNdKQoGPebSh97G
X-Google-Smtp-Source: AGHT+IG0FwlBx/Ygh5+v0TfI96CytKGvU02JLbABR9a0r6Px+6woVY5vP2fMZ/8Ou6XXEup699JHJHvn+yxKrD5p0Fc=
X-Received: by 2002:a05:622a:110b:b0:4a5:a96d:6068 with SMTP id
 d75a77b69052e-4a7fcde957cmr180816691cf.37.1751208366186; Sun, 29 Jun 2025
 07:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250627112509.264221-1-sughosh.ganu@linaro.org>
 <CALeDE9MixLWWM+YRpERY1NqNpFVW9JyVT=um7_PaLVa7YY7dHg@mail.gmail.com>
In-Reply-To: <CALeDE9MixLWWM+YRpERY1NqNpFVW9JyVT=um7_PaLVa7YY7dHg@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Sun, 29 Jun 2025 20:15:55 +0530
X-Gm-Features: Ac12FXwRRO7yXV709zhu9o6VwQO2VqlEnBxmpGtUt8LW28FhuWpaREv5ape_nm4
Message-ID: <CADg8p96vdCktQOfnPE_BZkq4eLwNwCsNVi8fkkmchQj8_3cmmw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] eficonfig: add support for URI based boot option
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
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

hi Peter,

On Fri, 27 Jun 2025 at 17:36, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> Hey Sughosh,
>
> > Add support for adding URI based boot option through the eficonfig
> > command. Also add a basic test case for checking validity of the URI's
> > being passed to the wget function.
>
> I suspect more an extension to this feature, have we looked at getting
> the URI boot options via dhcp?
>
> I'm not sure what options the LWIP dhcp stack support but it would be
> a useful automatic deployment option

That is an interesting use-case scenario. The one thing to think about
is whether it would be better to do this through a dedicated command
instead -- that command can then support other aspects that Heinrich
had suggested earlier. Things like which network interface to use, the
http server ip, the address to load the payload to from the server
etc. Also, eficonfig is a boot menu driven maintenance of the Bootxxxx
variables. So it might be a bit cumbersome from the point of scripting
this.

-sughosh

>
> > Changes since V2:
> > * Added comments for eficonfig_create_uri_device_path() - patch 1
> > * Added comments for fill_dp_uri() - patch 1
> > * Remove some superfluous newlines added - patch 1
> >
> >
> > Sughosh Ganu (2):
> >   cmd: eficonfig: add support for URI device path based boot options
> >   test: wget: add a test case for validating URI
> >
> >  cmd/eficonfig.c      | 131 ++++++++++++++++++++++++++++++++++++++++---
> >  include/efi_config.h |   4 ++
> >  test/cmd/wget.c      |  20 +++++++
> >  3 files changed, 147 insertions(+), 8 deletions(-)
> >
> > --
> > 2.34.1
> >
> >
