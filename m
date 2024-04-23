Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF62C4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 09:15:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 412028857C;
	Tue, 23 Apr 2024 11:14:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ktZo2iz/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF19D8856A; Tue, 23 Apr 2024 11:14:54 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4F0B8850E
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 11:14:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2d895e2c6efso81641451fa.0
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 02:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713863692; x=1714468492; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ma7fdDmeQVtaHMmRRjmc4GRgfEM4iHODxoVvP0xiiu0=;
 b=ktZo2iz/AglTysw2PhfLXgpy5YWcdN5RFr3nE7oqfJdJprIBfmaSCj6OSQq/zxnZ30
 yhSzeRcLnoc9ucEjZsTnv09gAWpBiljggYcmWzlz1S3Z/52dBNF4gtb/NOvmrJqyc5CY
 rkdCF2eCU1GlSShqpaE1ApBsPVYeuSIW+hIaepsm8qHfGATPwUu+kKCUxfc96ruQvVV/
 lazDn+kUh4V9nHtoVhnzMv1gistmW++09lgiKxy2a8tKQxSmPScCQtOI1/qYYpbeQlBm
 +TXTxLV/GXwh+fX4Ep8F02qFrryEo9yHN9EdCQskAoCoTZCo4qonr/z/Eg9kqZ7sVs25
 Efrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713863692; x=1714468492;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ma7fdDmeQVtaHMmRRjmc4GRgfEM4iHODxoVvP0xiiu0=;
 b=xL9SX6YXA9Yip+NyzjftmFv4yKq/1GRrX0rceSl61CurAEYjz8Z5c7867UGChCBRzu
 668BH/yz7uJBc+y5iiRJquSYQJ1II/lLt/tBdQwlC8T1Sa+oXNLgO2NMaen9NpBQ4OZK
 6In3hgbKi4amSl+zzE66As8jR8qqkSSndDvp3v5jwGMGRV8R1Wr6Zrwjp8q4YRYWDWlC
 LSMW4Cih8q4C8qJy/6f/iQ+kXjn8nE6NWzteafzW+Cu1HeBB6iavxPRVZUsIhJlrhOIq
 yHoiQhWqb3QCv+wzf6k3PK7W/Ou0n3z3OEgAxKwXpmfzUGhToGlJQbvvlpmrhZ2s83kL
 SzKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCViQqVOIbRdUITRy0bvqzsmAQoOPz8Kq9pKGTjsVWPKDvJa+mJ/lhPffK36JjyVaXIVhZqtpj36U2dsE4Os8QyA2FOoJg==
X-Gm-Message-State: AOJu0YxI5pLX8uwayfPS96pkh8sREMy+qzG0VZtsR9kBzA1Ez2Rolr5F
 8xvfl715Yk53t2Yp3CpoInEkTj4ke5GDNOkWgJBAkv8shkQEuv6MMk8WoH9dgustZUGSPICti2i
 uXuQyZs8OIc19uEKt+GViD6ICAO48W463IJea0w==
X-Google-Smtp-Source: AGHT+IG1fDBbCwpKX3l/1YyHsr0rrqqS/gs5RzQntD3BJQZf3yNGqc1cHm4CMoUxLd5/WFDtx3q8s1pqN5ZeMktjEcc=
X-Received: by 2002:a05:651c:2c3:b0:2da:78e:f766 with SMTP id
 f3-20020a05651c02c300b002da078ef766mr6688388ljo.38.1713863691889; Tue, 23 Apr
 2024 02:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240419065542.1160527-1-sughosh.ganu@linaro.org>
 <20240419065542.1160527-3-sughosh.ganu@linaro.org>
 <7361ddbc-6ef5-47cf-9369-53b72ec5bab7@gmx.de>
In-Reply-To: <7361ddbc-6ef5-47cf-9369-53b72ec5bab7@gmx.de>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 23 Apr 2024 14:44:40 +0530
Message-ID: <CADg8p95BMCc6naxvgy+Wrv6v8rNZ4MKGLuV8RorewbaC-9LqvA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] doc: Document capsule generation through a config
 file
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

hi Heinrich,

On Fri, 19 Apr 2024 at 13:01, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 19.04.24 08:55, Sughosh Ganu wrote:
> > The UEFI capsule can now be generated by specifying the capsule
> > parameters through a config file. Highlight these changes in the
> > documentation.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> >   doc/develop/uefi/uefi.rst | 70 +++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 70 insertions(+)
> >
> > diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
> > index 0389b269c0..8586127a83 100644
> > --- a/doc/develop/uefi/uefi.rst
> > +++ b/doc/develop/uefi/uefi.rst
> > @@ -318,6 +318,76 @@ Run the following command
> >         --guid <image GUID> \
> >         <capsule_file_name>
>
> The users deserve a man-page mkeficapsule.1 that can be installed by
> distros as /usr/share/doc/man/man1/mkeficapsule.1.
>
> Do not expect the user to look up the information online.

Will add a man-page.

>
> >
> > +Alternatively, the capsules can be generated through a config
> > +file. When generating the capsules through a config file, the Kconfig
> > +symbol CONFIG_EFI_CAPSULE_CFG_FILE is to be used for specifying the
> > +path to the config file.
>
> Why do we need CONFIG_EFI_CAPSULE_CFG_FILE? You could use a fixed path
> or an environment parameter.

Will remove the config flags.

>
> > +
> > +The config file describes the parameters that are used for generating
> > +one or more capsules. The parameters for a given capsule file are
> > +specified within curly braces, in the form of "key:value" pairs. All
> > +the parameters that are currently supported by the mkeficapsule tool
> > +can be specified through the config file.
> > +
> > +The following are some example payload parameters specified through
> > +the config file.
> > +
> > +.. code-block:: none
> > +
> > +     {
> > +         image-guid: 02f4d760-cfd5-43bd-8e2d-a42acb33c660
> > +         hardware-instance: 0
> > +         monotonic-count: 1
> > +         payload: u-boot.bin
> > +         image-index: 1
> > +         fw-version: 2
> > +         private-key: /path/to/priv/key
> > +         pub-key-cert: /path/to/pub/key
> > +         capsule: u-boot.capsule
> > +     }
> > +     {
> > +         image-guid: 4ce292da-1dd8-428d-a1c2-77743ef8b96e
> > +         hardware-instance: 0
> > +         payload: u-boot.itb
> > +         image-index: 2
> > +         fw-version: 7
> > +         oemflags: 0x8000
> > +         capsule: fit.capsule
> > +     }
> > +     {
> > +         capsule-type: accept
> > +         image-guid: 4ce292da-1dd8-428d-a1c2-77743ef8b96e
> > +         capsule: accept.capsule
> > +     }
> > +     {
> > +         capsule-type: revert
> > +         capsule: revert.capsule
> > +     }
>
> Is this one file? Are these multiple files? If these are multiple files,
> please, put them in different code blocks.

These are multiple files. But eventually, we will be using this
feature to generate a multi-payload capsule. Again, this is on similar
lines to how this is done with the EDKII script.

>
> What are the curly braces good for? Please, use an established file
> format like YAML or JSON.

As discussed over IRC, I will check if I can use the YAML format and
keep the format similar to the one used above -- in key:value pairs. I
would prefer keeping the format similar to what is used in the EDKII
capsule generation tool. But if I can use the mapping node type in
YAML for providing this information, I will explore using YAML with
the libcyaml library for parsing the configs.
>
> > +
> > +The following are the keys that specify the capsule parameters
> > +
> > +..code-block:: none
> > +
> > +    image-guid: Image GUID
>
> Please use the following formatting:
>
> image-guid
>      Image GUID
>
> fw-version
>      Image version

I have kept the format similar to what is used in EDKII.

>
> > +    image-index: Image index value
> > +    fw-version: Image version
> > +    private-key: Path to the private key file used for capsule signing
> > +    pub-key-cert: Path to the public key crt file used for capsule signing
> > +    payload: Path to the capsule payload file
> > +    capsule: Path to the output capsule file that is generated
> > +    hardware-instance: Hardware Instance value
>
> Please, explain what a hardware instance is.

Okay

>
> > +    monotonic-count: Monotonic count value
>
> Please, explain what it is used for.

Okay

>
> > +    capsule-type: Specifies capsule type. normal(default), accept or revert
>
> ditto
>
> > +    oemflags: 16bit Oemflags value to be used(populated in capsule header)
>
> ditto
>
> > +
> > +When generating capsules through a config file, the command would look
> > +like
> > +
> > +.. code-block:: console
> > +
> > +    $ mkeficapsule --cfg-file </path/to/the/config/file>
>
> All available command line parameters of mkeficapsule should be
> described in one place.

Will fix

-sughosh

>
> Best regards
>
> Heinrich
>
> > +
> > +
> >   Capsule with firmware version
> >   *****************************
> >
>
