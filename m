Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF14FC369C2
	for <u-boot@archiver.kernel.org>; Sat,  3 May 2025 21:27:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A5EE8212B;
	Sat,  3 May 2025 23:27:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UufZ4vF0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0894780EE5; Sat,  3 May 2025 23:27:05 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D974E828BC
 for <u-boot@lists.denx.de>; Sat,  3 May 2025 23:27:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5f4b7211badso4609472a12.2
 for <u-boot@lists.denx.de>; Sat, 03 May 2025 14:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746307622; x=1746912422; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tKAB8ZaKBx8fSC4WCpnbHf3sBmx1x9STMLo4rq8wAtI=;
 b=UufZ4vF0tFwMlTXvM8toiFM/wrs9nYx8K8huOJ9JeaKKXVhSHDg2g7RLzg2Iv1MCXu
 RAEkTpV/F1SUEgFaqRhgdq0cbnsWNe4NHBPruHBXUh0p+sZmO3T1bBqTuMXfxXOpAYHq
 el4h/XD5wc63KpgxXeE9abtRWuYDLnMfAyGbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746307622; x=1746912422;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tKAB8ZaKBx8fSC4WCpnbHf3sBmx1x9STMLo4rq8wAtI=;
 b=R9Yhp870tq3DoeRDl+ZlxTYUoTAfRH6yDCLHyWsAcKQjkUWFJoMmG3L4hWHLbJOXrd
 UOGVNH3RThHQGumF5llIFqWKHbdxqNXkqaKY1ImwlcywMcRVcSCHHSFC+IitKhKlOj6c
 ffIct7C+aqlxmYpYTw0KBZ0VqCLqypnRfWHXCp5VLCCsXEby8Dkx6ZX/2bDq/0MYrMjt
 v9n/kP8u/wBCb73hlrdOIuO5NierxD1aB8AdiC4SVtCLZT3RPdZB7KUc5sZyQ2uJmaIl
 XaophEHNXPkoPwxS5MNXvWygqhzBJVJ/6JgrGHz2KSOLaBdYiR606oWs9s2Qm6q3VpkO
 onmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+2jKIvqNxep+60LkqylRDG5YTdSeYv3ebGQBif57O1U4wfXFneUV+6ft5Mfp9sRqaBQM5c/4=@lists.denx.de
X-Gm-Message-State: AOJu0YxqDUo9C4QZoxuPHVrAo4qHkodXUXI+BUK3MBkFw1kUrp4J7fWe
 ZIQ16zIX/WtqYRZfJDS5eSL/hyQGz5vfqLPEmNjXwYHcQwuAuri9Bo5DmeQbdXMlhKfFfGTuF2L
 9O7gXQ7wBvRzba66yLdO1fn0Fl0rQMaOmLiIB
X-Gm-Gg: ASbGnct0vbFd+ArLol6t8uZQ32Gsq1r232ldJ1TQ/20CfxbU3TEqc0yy2Qf2RgsMeeP
 mMu+gF7HWyRC3rOjaD0+JSGLJh/CdFmOEdWs41zU0AuepQ66lQOZp2UPjybV/EaqxmprnY2xAtE
 LCovx8nKOayP8sLVa0E+pPiFtII+gptPfhYemgQDEAN+yNRalg2s4m/05GJb0Sp753rA==
X-Google-Smtp-Source: AGHT+IGOWNihttWhsO3w9gtbMSaN/VZxNHHWujCU2RCs2Zq2L+D5fN4D3PV690EHVouG8mK4ij7fTYLJCQiETVy/OBc=
X-Received: by 2002:a05:6402:845:b0:5ed:994c:7e75 with SMTP id
 4fb4d7f45d1cf-5faa80020a0mr2938904a12.24.1746307622279; Sat, 03 May 2025
 14:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250503133155.55412-1-heinrich.schuchardt@canonical.com>
 <20250503133155.55412-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250503133155.55412-2-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 May 2025 15:26:47 -0600
X-Gm-Features: ATxdqUHYaBbR6TxtMBgrmvmSkpvs5OkMxM73pdH76-0l1E5tMlXAatZnOcezyQ0
Message-ID: <CAFLszThvh+fzrDoODdj7kYqVKXkL6xvAFcz8biOh3c-LaD2CFw@mail.gmail.com>
Subject: Re: [PATCH 1/2] test: allow multiple config options in buildconfigspec
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
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

Hi Heinrich,

On Sat, 3 May 2025 at 07:32, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> In some cases we have alternative configuration options that supply the
> same functionality, e.g CONFIG_NET and CONFIG_NET_LWIP.
>
> Allow to specify all of them as arguments for buildconfigspec() and execute
> the text if any of these is fulfilled, e.g.
>
>     @pytest.mark.buildconfigspec('net', 'net_lwip')
>
> Update the documentation.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  doc/develop/py_testing.rst | 24 ++++++++++++++++++++++++
>  test/py/conftest.py        | 10 +++++++---
>  2 files changed, 31 insertions(+), 3 deletions(-)
>
> diff --git a/doc/develop/py_testing.rst b/doc/develop/py_testing.rst
> index 217ae447035..7dbed8833bf 100644
> --- a/doc/develop/py_testing.rst
> +++ b/doc/develop/py_testing.rst
> @@ -514,3 +514,27 @@ of the `ubman.config` object, for example
>  Build configuration values (from `.config`) may be accessed via the dictionary
>  `ubman.config.buildconfig`, with keys equal to the Kconfig variable
>  names.
> +
> +A required configuration setting can be defined via a buildconfigspec()
> +annotation. The name of the configuration option is specified in lower case. The
> +following annotation for a test requires CONFIG_EFI_LOADER=y:
> +
> +.. code-block:: python
> +
> +    @pytest.mark.buildconfigspec('efi_loader')
> +
> +Sometimes multiple configuration option supply the same functionality. If
> +multiple arguments are passed to buildconfigspec(), only one of the
> +configuration options needs to be set. The following annotation requires that
> +either of CONFIG_NET or CONFIG_NET_LWIP is set:
> +
> +.. code-block:: python
> +
> +    @pytest.mark.buildconfigspec('net', 'net lwip')
> +
> +The notbuildconfigspec() annotation can be used to require a configuration
> +option not to be set. The following annotation requires CONFIG_RISCV=n:
> +
> +.. code-block:: python
> +
> +    @pytest.mark.notbuildconfigspec('riscv')
> diff --git a/test/py/conftest.py b/test/py/conftest.py
> index 5aea85647af..6c3ac67979a 100644
> --- a/test/py/conftest.py
> +++ b/test/py/conftest.py
> @@ -711,9 +711,13 @@ def setup_buildconfigspec(item):
>      """
>
>      for options in item.iter_markers('buildconfigspec'):
> -        option = options.args[0]
> -        if not ubconfig.buildconfig.get('config_' + option.lower(), None):
> -            pytest.skip('.config feature "%s" not enabled' % option.lower())
> +        nomatch = True
> +        for arg in options.args:
> +            if ubconfig.buildconfig.get('config_' + arg.lower(), None):
> +                nomatch = False
> +        if nomatch:
> +            argsString = ', '.join(options.args)
> +            pytest.skip(f'.config features "{argsString}" not enabled')
>      for options in item.iter_markers('notbuildconfigspec'):
>          option = options.args[0]
>          if ubconfig.buildconfig.get('config_' + option.lower(), None):
> --
> 2.48.1
>

I ran into this problem too. Would it be possible to have CONFIG_NET
mean that we have networking (either option) and CONFIG_LWIP mean that
it is lwip? The current Kconfig seems a bit broken to me....

Regards,
Simon
