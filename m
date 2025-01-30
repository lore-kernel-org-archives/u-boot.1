Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6166C0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 19:55:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9B3780EBA;
	Thu, 30 Jan 2025 20:55:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M2nXcJFE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D4E080EBD; Thu, 30 Jan 2025 20:55:06 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 746FD80EB6
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 20:55:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aaeec07b705so205491866b.2
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 11:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738266904; x=1738871704; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vqTxzZGYodODcK3d4abckVf4ae5n6LlBnVNCAn7R210=;
 b=M2nXcJFESDBsvc3JROEzDI2uqjZiG+aO1akBCbOC4u/GjwBcp5bPQDJ6wVkhlWyDQK
 95maPqrymKgrxkcg9sYlCKFK0x4NsgW3kbChzx/QmmEsuuHi5dwHpX2ZIXjtSuPT68qM
 0tQJ3nVioQ1Uw8nQCvtN+3FzeeqImCFaQdnWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738266904; x=1738871704;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vqTxzZGYodODcK3d4abckVf4ae5n6LlBnVNCAn7R210=;
 b=l9QVrZZXHEL4GrlqDK1TokZAnER6pBQTzzuZk2KRTPYfNXUPlS2ICyEoylD8/ZcRKR
 k5U7tWz5BsC4yORESTukEAvjgo3uPnskgs00pp9tf5Iu8P1agL4weJZ9SwB3ehxFsrab
 0bNmyIwSPGDR9S1kELjVKgDM+jqCslg2zH++VBE2UPTjGREpT2aHWmprDbO7d1tbERrt
 FSEZ+4Foo7SgokTni3XDh7dsqcEJ71e89dz00f/TPXaLaN2ffkGHPGzPYSH+CH/Aab7v
 wU0YX30aofImWlPZ75XViJbx07z1nN/Jk9Qh9JKu5KJYwv1wPG0+F3IhJPRvqEWPyu7g
 zcrA==
X-Gm-Message-State: AOJu0Yzu4vx7Po6ugHLyl2nqGuacLfwVecHQU9BMSit0PND53ki/U/PY
 /uLroXjTO/rzBGnCCgPJ7iuKtAIT07i6dmNj6Ie70gYHn1vXvR7uCckJDAfqA+l5zrXTBOcRcx4
 F9BCds/ashHYRARPNvis19DmN4mtwkH+GDynn
X-Gm-Gg: ASbGncufrTFMrIEvqGG39RMP6WYmFLhF2XaLScYSeXN2wvx5kH5mPN6P3cOIFprCfyt
 QeFEHXd57KM6leRq3ZyzwLse3eAaSGde7qox1FWL1d+B8s2eftoRlbfRuDo/ndMffm4ASUTeCCA
 ==
X-Google-Smtp-Source: AGHT+IELIFEo1nkkJ61xXGHdLekw2/8olzCgHosWeAXO0WVBD5yRp3HILa8RoyLrIzjm9yxsGwfBHDXzRQ13NvxANsA=
X-Received: by 2002:a17:906:794e:b0:ab2:faed:f180 with SMTP id
 a640c23a62f3a-ab6cfd0a46emr929165566b.33.1738266903600; Thu, 30 Jan 2025
 11:55:03 -0800 (PST)
MIME-Version: 1.0
References: <92438c16-1b8b-4e90-a44c-285140f59f0f@gmx.de>
 <e3ed313a-847d-4307-8c58-f40e8fcee86f@gmx.de>
In-Reply-To: <e3ed313a-847d-4307-8c58-f40e8fcee86f@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 30 Jan 2025 12:54:52 -0700
X-Gm-Features: AWEUYZmMfImEvQSJWh28Sqry0OKNLPUvoPZBvtDqn6t3IsOOnn7bPxU79EWHqLE
Message-ID: <CAFLszTiqw1J+0tQT1rDzX8ENGATm46t4MQytCyr7QJL18xG0ug@mail.gmail.com>
Subject: Re: make tests skips the DM tests
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Thu, 30 Jan 2025 at 01:32, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 1/30/25 08:08, Heinrich Schuchardt wrote:
> > Hello Simon,
> >
> > when running 'make tests' locally I get:
> >
> > test/py/tests/test_dm.py .
> >
> > ==============================================================================
> > short test summary info
> > ===============================================================================
> > SKIPPED [2] test/py/conftest.py:625: .config feature "sandbox" enabled
> > SKIPPED [1] test/py/tests/test_bootstage.py:39: No bootstage environment
> > file is defined
> > SKIPPED [1] test/py/tests/test_cat/test_cat.py:8: Setup failed
> > SKIPPED [1] test/py/tests/test_dfu.py:114: got empty parameter set
> > ['env__usb_dev_port'], function test_dfu at /test/py/tests/test_dfu.py:113
> > !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! _pytest.outcomes.Exit: Lab failure:
> > Timeout executing 'dm drivers
> > ': Marking connection bad - no other tests will run
> > !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
> >
> >
> > Shouldn't the required boardenv_* files be generated by running 'make
> > tests'?
> >
> > Best regards
> >
> > Heinrich
>
> When installing all packages mentioned in tools/docker/Dockerfile the DM
> tests are executed.

What about test/py/requirements.txt ?

Really we should document the packages needed. The doc/build/gcc.rst
file is supposed to do that, where it says 'Depending on the build
targets further packages maybe needed'. So perhaps we could add things
there, and even split out the things needed for tests?

>
> What is missing is an error message which package or tool is needed when
> the boardenv_* files cannot be generated.

Also we don't run 'make test' or 'make ptest' in CI and I know from
Tom that he doesn't use it either.

Regards,
Simon
