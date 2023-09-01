Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F76CA0FE6
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 08:00:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F15E8867B6;
	Fri,  1 Sep 2023 10:00:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RzEWByqz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC1B886725; Fri,  1 Sep 2023 10:00:14 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 270C88669D
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 10:00:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2bd0d19a304so30278211fa.1
 for <u-boot@lists.denx.de>; Fri, 01 Sep 2023 01:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693555211; x=1694160011; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3XrDR1tlbkea808j55ycnJqF9jB0ZvhT8/Iixoq8MVE=;
 b=RzEWByqzgzRm3Dpw/dVWBQTsIHntGQpEU2VSS4W80/tfd4dieCkUcv2bGcTY+2+iMZ
 RjCYAZHQcbqpVIOyEu/Rzw60qkXcufcmwkQ83AlRPybdHAcZzZ9YcA1gt1cXjdKLcLpa
 8UrJE6+rgu2SajQ4doulgF+fhARMgsreVrMoV5d/KStPB5V7mG6GcQvq/eSHRno1kiOK
 5+pYQcncSUk0o6PLsTlQ7rdyY38s8ab0zMf8x66nd9eoA9AsODIDGWaTSxZC5hBCFm5B
 l3cI+gOs7771YOScJPC0GhAjuwYVjavnKkPYTTufbezyoG7+AzJ3DiT7eoX3EnAYJB0F
 Dx8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693555211; x=1694160011;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3XrDR1tlbkea808j55ycnJqF9jB0ZvhT8/Iixoq8MVE=;
 b=fAngCC2sfipb96q0fTtKciY7BySLY73OUIxV2I7lBajKLLNmMlU3VWVwalvZsM+wrH
 l0Rckq36mVWr6bLeURYKGsFpCB6ZC/ZWRtlQbR89JZyqdP8cuhlHhgqryzFB+dMvbdZf
 qYDC3Dr3oNNY4Mz7QGV66Czfyz81rEW+/IqZvAoZJXuajlM/OgPw+/VdDKCvizoELcOb
 TbTdyGg76EOpSfz0ySve74zfiBrOLTU8ZnoP3rdOIdejlL1K3aeUFGY3c7ceI8r5MMHZ
 B8ZuLI3lJajW+lHYaAmzU7f0uGoK6jHxroQcJASBMxLF9zRWKgrktI4xJNQwpoSVopx5
 xsHQ==
X-Gm-Message-State: AOJu0Yw8D1zxp0abkKit3QGw31UbK4hC5jqLsDJcicKFdFGtbYl/WGSv
 oSm6PuyJ35UtgTzxMiuMHgEtZAfx7glOWfRde0azLtUuo1NwAb1E
X-Google-Smtp-Source: AGHT+IEXfv2lDPLa3Jp5kXH9ZMoLtM9iDTK1FTgMdKvAD6eGKUlC+aKl+/emVNgiwp/fDD7wR4gMMrBpun5z3nU4mN0=
X-Received: by 2002:a19:5010:0:b0:4fe:c98:789a with SMTP id
 e16-20020a195010000000b004fe0c98789amr953076lfb.37.1693555211201; Fri, 01 Sep
 2023 01:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <41f932e52bdd206b1b68d5ff313fc29b794a70e7.1693413381.git.michal.simek@amd.com>
 <b48a067e-4143-8cab-3387-e276e900e8f0@amd.com>
In-Reply-To: <b48a067e-4143-8cab-3387-e276e900e8f0@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 1 Sep 2023 10:59:33 +0300
Message-ID: <CAC_iWj+GZCHZkDf8C0v7oeJLwLZZep0jhKYv2at7BJ0gmqCFDw@mail.gmail.com>
Subject: Re: [PATCH] test/py: tpm2: skip tpm2_startup when
 env__tpm_device_test_skip=True
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, Simon Glass <sjg@chromium.org>
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

On Fri, 1 Sept 2023 at 10:09, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 8/30/23 18:36, Michal Simek wrote:
> > All tpm2 tests should be possible to skip when
> > env__tpm_device_test_skip=True but test_tpm2_startup is missing it.
> >
> > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > ---
> >
> >   test/py/tests/test_tpm2.py | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/test/py/tests/test_tpm2.py b/test/py/tests/test_tpm2.py
> > index fce689cd992d..c2579fa02c58 100644
> > --- a/test/py/tests/test_tpm2.py
> > +++ b/test/py/tests/test_tpm2.py
> > @@ -71,6 +71,9 @@ def test_tpm2_startup(u_boot_console):
> >
> >       Initiate the TPM internal state machine.
> >       """
> > +    skip_test = u_boot_console.config.env.get('env__tpm_device_test_skip', False)
> > +    if skip_test:
> > +        pytest.skip('skip TPM device test')
> >       u_boot_console.run_command('tpm2 startup TPM2_SU_CLEAR')
> >       output = u_boot_console.run_command('echo $?')
> >       assert output.endswith('0')
>
> Applied.

Uhm? Applied where? I had a few minor fixes I was planning to send to Tom

Thanks
/Ilias
> M
