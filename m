Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A58FCC3ABD8
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 15:40:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88D5F82A9E;
	Fri, 16 May 2025 17:40:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c8BdfJ4C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63E0F82AAA; Fri, 16 May 2025 17:40:31 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F1698006D
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 17:40:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7423fb98cb1so2684602b3a.3
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 08:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1747410027; x=1748014827; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V16JLeSSevhAdRoBExdY+Q7ZWRp2jcNOeeaYgKcv7sw=;
 b=c8BdfJ4CFixAgWFcAOalr5W3dzSxdXIXxCAUHStLVTY93vOpDSFiAIUBD0dE5yZOb6
 ItAjZfHDwz2dH93FDpArdMGht8zjxzpCbosR58gU/XoVKk3SFuBpaxr1LSUpWrANbumP
 Xn91tJ1bro71l3hjhhsdD/9KBV0dOcRLUJ3Xk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747410027; x=1748014827;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V16JLeSSevhAdRoBExdY+Q7ZWRp2jcNOeeaYgKcv7sw=;
 b=IMIJ8uyEUVGl+9u7oKv9FYVAesufiPYme5paQFuypbnchA8CKKomxFn4qelEc5rfzd
 rUlc6lyiGVy1UfxFLGKAYceIs9CCJ8Edb4vGHgdb5HSMrcr3X7q3mLvL5dHCiAR6/83x
 4cfatiAElYWYG05Z9cviG2ZX/zr8KbW3WMo8nAiySQLEmVodpMsxhsKXHARUMw8LKML/
 6pUhQYqsNdSarn9jndATDCbmsgNgWc2o58/NxQi2Jr3FVmgAJai8v+KY3kixbAiMKneJ
 NnoZQBfa81DMgAzzwqlwWZhZlGJX0qbR3I33u1+qTt+uIHGbujWbe6qQ/Yb6LOQA6CMD
 Xhzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwcRXWISk5CbUwx5n8x2RryBmb4BlPJWSz4zBhO1JY6CbrGXzCvEtYVduDPt72DWXjtcTCOdI=@lists.denx.de
X-Gm-Message-State: AOJu0YyTL36e/08buRnqOk3CrQdLb0wKML4wgJxeIloiX1fP9x7DEizS
 WFFKbaN2zQVY0Dx6dYZL8R8xcwLxLffGs8TD6K5dKDm5zO94ieAar7ejJSv89YibPQcI6ypPjOK
 MH8zdlhQXzgn4yd6BZa16d+P3iFIkVvKJIfWx1Sel
X-Gm-Gg: ASbGnctTm5xLso/RKyxVI767B81RCmttGgbVMuFRo5U1THnmchBa3M72KAM3MQ8U5KH
 I9QCLYdctjXuy5O094oozF/0GFnrKJgNe+waat9po/5GGOtQomVacZXnKWbUbqBdlNH8S+Jw8tU
 ALjyF4UnEbqrYo/9BgqRpmATSWXSOI5oStFA==
X-Google-Smtp-Source: AGHT+IGGjpbXbiEG6Sh3HgKfkmDpSy5qY0IIr+fholkiJ1IuntOuvprE+twqk8hO+uR0Qf2+B7ZSRpasstXNuU8LZKo=
X-Received: by 2002:a17:902:c408:b0:22e:7f55:763 with SMTP id
 d9443c01a7336-231d45d4010mr44164175ad.51.1747410027619; Fri, 16 May 2025
 08:40:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250503133155.55412-1-heinrich.schuchardt@canonical.com>
 <20250503133155.55412-2-heinrich.schuchardt@canonical.com>
 <CAFLszThvh+fzrDoODdj7kYqVKXkL6xvAFcz8biOh3c-LaD2CFw@mail.gmail.com>
 <CAM=mAOkNo=kuNNo9fDEfUNOXSE5cQc3zhx54BAWNy--tt1u3Lw@mail.gmail.com>
In-Reply-To: <CAM=mAOkNo=kuNNo9fDEfUNOXSE5cQc3zhx54BAWNy--tt1u3Lw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 16 May 2025 17:40:05 +0200
X-Gm-Features: AX0GCFuudFiaEkEEYRByTjT6Xax1MuBaYmI06PCBJLGV4e0cQlFQA1FmjRfDSwk
Message-ID: <CAFLszTjfR+Gwme6YKtjnF_6H9g49FKD_uRXR8Eput6K32kcUcQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] test: allow multiple config options in buildconfigspec
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

On Sun, 4 May 2025 at 07:27, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
>
>
> Simon Glass <sjg@chromium.org> schrieb am Sa., 3. Mai 2025, 23:27:
>>
>> Hi Heinrich,
>>
>> On Sat, 3 May 2025 at 07:32, Heinrich Schuchardt
>> <heinrich.schuchardt@canonical.com> wrote:
>> >
>> > In some cases we have alternative configuration options that supply the
>> > same functionality, e.g CONFIG_NET and CONFIG_NET_LWIP.
>> >
>> > Allow to specify all of them as arguments for buildconfigspec() and execute
>> > the text if any of these is fulfilled, e.g.
>> >
>> >     @pytest.mark.buildconfigspec('net', 'net_lwip')
>> >
>> > Update the documentation.
>> >
>> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> > ---
>> >  doc/develop/py_testing.rst | 24 ++++++++++++++++++++++++
>> >  test/py/conftest.py        | 10 +++++++---
>> >  2 files changed, 31 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/doc/develop/py_testing.rst b/doc/develop/py_testing.rst
>> > index 217ae447035..7dbed8833bf 100644
>> > --- a/doc/develop/py_testing.rst
>> > +++ b/doc/develop/py_testing.rst
>> > @@ -514,3 +514,27 @@ of the `ubman.config` object, for example
>> >  Build configuration values (from `.config`) may be accessed via the dictionary
>> >  `ubman.config.buildconfig`, with keys equal to the Kconfig variable
>> >  names.
>> > +
>> > +A required configuration setting can be defined via a buildconfigspec()
>> > +annotation. The name of the configuration option is specified in lower case. The
>> > +following annotation for a test requires CONFIG_EFI_LOADER=y:
>> > +
>> > +.. code-block:: python
>> > +
>> > +    @pytest.mark.buildconfigspec('efi_loader')
>> > +
>> > +Sometimes multiple configuration option supply the same functionality. If
>> > +multiple arguments are passed to buildconfigspec(), only one of the
>> > +configuration options needs to be set. The following annotation requires that
>> > +either of CONFIG_NET or CONFIG_NET_LWIP is set:
>> > +
>> > +.. code-block:: python
>> > +
>> > +    @pytest.mark.buildconfigspec('net', 'net lwip')
>> > +
>> > +The notbuildconfigspec() annotation can be used to require a configuration
>> > +option not to be set. The following annotation requires CONFIG_RISCV=n:
>> > +
>> > +.. code-block:: python
>> > +
>> > +    @pytest.mark.notbuildconfigspec('riscv')
>> > diff --git a/test/py/conftest.py b/test/py/conftest.py
>> > index 5aea85647af..6c3ac67979a 100644
>> > --- a/test/py/conftest.py
>> > +++ b/test/py/conftest.py
>> > @@ -711,9 +711,13 @@ def setup_buildconfigspec(item):
>> >      """
>> >
>> >      for options in item.iter_markers('buildconfigspec'):
>> > -        option = options.args[0]
>> > -        if not ubconfig.buildconfig.get('config_' + option.lower(), None):
>> > -            pytest.skip('.config feature "%s" not enabled' % option.lower())
>> > +        nomatch = True
>> > +        for arg in options.args:
>> > +            if ubconfig.buildconfig.get('config_' + arg.lower(), None):
>> > +                nomatch = False
>> > +        if nomatch:
>> > +            argsString = ', '.join(options.args)
>> > +            pytest.skip(f'.config features "{argsString}" not enabled')
>> >      for options in item.iter_markers('notbuildconfigspec'):
>> >          option = options.args[0]
>> >          if ubconfig.buildconfig.get('config_' + option.lower(), None):
>> > --
>> > 2.48.1
>> >
>>
>> I ran into this problem too. Would it be possible to have CONFIG_NET
>> mean that we have networking (either option) and CONFIG_LWIP mean that
>> it is lwip? The current Kconfig seems a bit broken to me....
>>
>> Regards,
>> Simon
>
>
> Hello Simon,
>
> Yes, we can think about reworking the network configuration in a future series.
>
> E.g. have as choice
>
> * CONFIG_NET_LEGACY
> * CONFIG_NET_LWIP
> * CONFIG_NET_NONE
>
> and CONFIG_NET := !CONFIG_NONE
>
> But I think it is still valuable in its own right to be able to express a logical OR when defining test dependencies.
>

Yes OK

Reviewed-by: Simon Glass <sjg@chromium.org>

> Best regards
>
> Heinrich
>
