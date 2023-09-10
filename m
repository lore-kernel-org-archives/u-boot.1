Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D64C6EE49A4
	for <u-boot@archiver.kernel.org>; Sun, 10 Sep 2023 19:14:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B03786D02;
	Sun, 10 Sep 2023 21:14:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QNEniz6C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E61386CFC; Sun, 10 Sep 2023 21:14:41 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2836386CF5
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 21:14:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-58d41109351so67096247b3.1
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 12:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694373275; x=1694978075; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hSCxt27KZiF4mCQofacQvPgFP70F0CN8no/5n2ATK0g=;
 b=QNEniz6C9qvFd3Xi7ltT7o0/60tb+fsHuicKXmSCqsM6BU79j2R6pFHS85IVOKSZFW
 9LHQDjc1HOrxzlAUNcJz62N1Yg439E7OevJvYdW3+vXurZDgVnowAXFwj8B9S8MMHlmY
 zxNf8mSB1ksZzo+laDSURAp7sznz2DY8zKNo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694373275; x=1694978075;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hSCxt27KZiF4mCQofacQvPgFP70F0CN8no/5n2ATK0g=;
 b=onll4bWbbEbLlBU/n/rA9vph72JtUsWdrI9dtQEC0NabItOdxstz1vqtIyuSqQWc71
 Alz0OtnqCbiWSycjkXSd133x2wj3r2f6azcygDzc5Arb+eeAL7BPZuKbgMSdLCNJfD36
 8GhChkP0KTmkWa2xYmpNPbEC17hjoqOutroAEynmb4fqnIj26lZAn4Y6KNIE86hiQGuN
 B0RaaqE93GXPuNA1G6rwprelS25aW6IXr5QLTIOcdV3nNrR2r58ePSiIkVhncgTXxq14
 G/ZQQKDR0geDxPNsm+iD5nNJ3XBv/tkkb/vvMdGv3aXxMpOztNjLvyNh6qHxLTS6AVaT
 XqVg==
X-Gm-Message-State: AOJu0YwfrclhEAr9p8bZDzlg7CXK90LduxaM7CceeuKFfjdk3OKI/vYt
 QWNztfELqGuaEoXpcM8i7bTQJLegVDvhvNvsMg44Vg==
X-Google-Smtp-Source: AGHT+IHbcX+S2UpZ6e27h0MNlOeSmMhXsYeAMc8MYmaTuxZTOGkVjxtaO1NhJ5jluYHCXhyzZLFtH3BHs/YJrPMGjsw=
X-Received: by 2002:a25:ce01:0:b0:d72:652f:4054 with SMTP id
 x1-20020a25ce01000000b00d72652f4054mr12615877ybe.16.1694373274644; Sun, 10
 Sep 2023 12:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230907205045.15406-1-jmcosta944@gmail.com>
 <2e7387ce-e47a-4f51-8521-a43971ab62d4@gmx.de>
In-Reply-To: <2e7387ce-e47a-4f51-8521-a43971ab62d4@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 10 Sep 2023 13:13:19 -0600
Message-ID: <CAPnjgZ2UUhUw=F-XPo84U7dqQJVbGe08L-f7_ojKP+_Np3s44w@mail.gmail.com>
Subject: Re: [PATCH v1] doc: Update path to source_file_format.rst
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Joao Marcos Costa <jmcosta944@gmail.com>, trini@konsulko.com,
 miquel.raynal@bootlin.com, u-boot@lists.denx.de
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

On Fri, 8 Sept 2023 at 13:28, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 9/7/23 22:50, Joao Marcos Costa wrote:
> > Previously, the file extension was .txt, and it referenced the uImage.FIT
> > directory, which no longer exists. This commit updates the path accordingly.
> >
> > Signed-off-by: Joao Marcos Costa <jmcosta944@gmail.com>
> > ---
> >   doc/usage/fit/howto.rst | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/doc/usage/fit/howto.rst b/doc/usage/fit/howto.rst
> > index c933703d1d..8b38cd534d 100644
> > --- a/doc/usage/fit/howto.rst
> > +++ b/doc/usage/fit/howto.rst
> > @@ -22,7 +22,7 @@ for its latest version. mkimage (together with dtc) takes as input
> >   an image source file, which describes the contents of the image and defines
> >   its various properties used during booting. By convention, image source file
> >   has the ".its" extension, also, the details of its format are given in
> > -doc/uImage.FIT/source_file_format.txt. The actual data that is to be included in
> > +doc/usage/fit/source_file_format.rst. The actual data that is to be included in
>
> Thank you for updating the reference.
>
> In the HTML documentation we want to generate a link here using:
>
>      :doc:`source_file_format`
>
> Best regards
>
> Heinrich
>
> >   the uImage (kernel, ramdisk, etc.) is specified in the image source file in the
> >   form of paths to appropriate data files. The outcome of the image creation
> >   process is a binary file (by convention with the ".itb" extension) that
>

Reviewed-by: Simon Glass <sjg@chromium.org>
