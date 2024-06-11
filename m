Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D08C27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 18:55:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE90C88790;
	Tue, 11 Jun 2024 20:52:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UZQKDZyi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 204E2886C0; Tue, 11 Jun 2024 20:52:39 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7923831A1
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 20:52:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6ad8243dba8so29945266d6.3
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 11:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718131955; x=1718736755; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZhkBaI0z6DLJlF6XTdURphdG7tUt0caW9hcK4nGeeJg=;
 b=UZQKDZyiFH5SpFZZOGLXXJc0OfKZ4Uc7/sG9dU71okZjny2yX8PLYEwV6au2UytF+c
 mV50u0thQ4Ppegb1C5dBlL7U2qEodnPmVz1QBDvcvqfMjIHhq1wXWIQlkHBOjEJjeTrJ
 +Vx/624+molxq9q62jR0Pi2a3pwFacS/j3he0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718131955; x=1718736755;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZhkBaI0z6DLJlF6XTdURphdG7tUt0caW9hcK4nGeeJg=;
 b=tMhX2QQohm4GJ073cZFfU5vGOzO4DNUomticVTPbiK/zxtAdmh9MclHNih8rlmP3HI
 LxQ5poCMla9FYCRfSfKRFNS1acTEt51mhMYbHlCMzHV/PA414cmsYSVqENC3D2NwdPQb
 1686Udb6swrUPNCHlCOo0+5Jwtzn6nIIMr6/u0dOolu+u1t+mOM2meo6CUBJJ6xiwuXD
 o87DZp6EXgRNeCvbledYzxi18GOUEoCTX0tpWFqWuo8Ro2+3TAI9ypQfmi+iu31qBrCU
 3u3QqnohUzzLxIejgXbeN8xQc8/IpqpTsJJokbe1NX3ecjazQjvo/WuTOw/2xLQosh6b
 8llQ==
X-Gm-Message-State: AOJu0YyEDGRT1m1cjPTEvsB66UQsLtE8C2UT0sq1gSk5fCni5VVB7jzw
 9TF6htiE+qqQNIAfp9GDsGCTU9c/vrl4QS55k2I0H9B8rrXhvnEWc5V+BfXIXL/emD2NgEpc4Zv
 8YlmsIv5o+PmbfhuDNrzvDGv+OiTkZr2HKdxp
X-Google-Smtp-Source: AGHT+IEZAyJtedmO73WxaFuMTFbAJmp/QKpIKzRvqHhT0h5C7ESPFdPP2OrixGQ+G1kOro3asW3D+TIql+T2mDXD7pM=
X-Received: by 2002:a05:6214:4a8f:b0:6b0:7505:8846 with SMTP id
 6a1803df08f44-6b075058987mr101371636d6.39.1718131955596; Tue, 11 Jun 2024
 11:52:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240419065542.1160527-1-sughosh.ganu@linaro.org>
In-Reply-To: <20240419065542.1160527-1-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 11 Jun 2024 12:52:23 -0600
Message-ID: <CAFLszTgj6VUjYmz4emp3YE57Bhkaba0yOnOBaHRJDuRpT36Bxg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Generate capsules from config files
To: sughosh.ganu@linaro.org
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
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

Hi Sughosh,

On Fri, 19 Apr 2024 at 00:56, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
>
> Add support for generating capsules through a config file. Multiple
> capsules can be generated through a single invocation of the
> mkeficapsule tool, where the capsule parameters are fetched from the
> config file.
>
> The format of the config file pretty similar to the one used by the
> capsule generation tool in EDKII.
>
> The functionality is enabled on the sandbox variant and the EFI
> capsule update test is now configured to generate the capsules through
> a config file. The sandbox_flattree variant generates capsules through
> binman, thus covering both the paths.
>
> This is a rebased version of the earlier patch series that was sent to
> the mailing list [1]. That series was not getting merged as Simon had
> asked for generation of capsules as part of the sandbox platform
> build. Those patches have since been merged. Moreover, there has been
> adoption of the capsule generation logic by TI platforms as well, so
> that should address the concern which Tom had about it's usage.
>
> These patches are more of a step in the direction of adding support
> for generation of a multi-payload capsule. There has been a request
> for it's support for a platform [2].
>
>
> [1] - https://lists.denx.de/pipermail/u-boot/2023-November/538223.html
> [2] - https://lists.denx.de/pipermail/u-boot/2024-March/548126.html
>
>
> Sughosh Ganu (4):
>   tools: mkeficapsule: Add support for parsing capsule params from
>     config file
>   doc: Document capsule generation through a config file
>   sandbox: capsule: Add a config file for generating capsules
>   test: capsule: Generate capsules through config file
>
>  configs/sandbox_defconfig                     |   2 +
>  doc/develop/uefi/uefi.rst                     |  70 ++++
>  .../test_efi_capsule/capsule_gen_binman.dts   |   2 +
>  test/py/tests/test_efi_capsule/conftest.py    |   7 +
>  .../test_efi_capsule/sandbox_capsule_cfg.txt  |  73 ++++
>  tools/Kconfig                                 |  15 +
>  tools/Makefile                                |   1 +
>  tools/eficapsule.h                            | 114 ++++++
>  tools/mkeficapsule.c                          |  87 +++--
>  tools/mkeficapsule_parse.c                    | 352 ++++++++++++++++++
>  10 files changed, 692 insertions(+), 31 deletions(-)
>  create mode 100644 test/py/tests/test_efi_capsule/sandbox_capsule_cfg.txt
>  create mode 100644 tools/mkeficapsule_parse.c

Can you implement this in binman? I would like to avoid having a
separate config file from the image description.

Regards,
Simon
