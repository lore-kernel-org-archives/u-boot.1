Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 619E0C54791
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 05:38:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83B7887DAF;
	Wed, 13 Mar 2024 06:38:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="N2zIIaGJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78AFC87DCC; Wed, 13 Mar 2024 06:38:35 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BFBF8753A
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 06:38:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2d27184197cso82334141fa.1
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 22:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710308312; x=1710913112; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MIZTcNmEJsemYoBfJkmrJU3tiyWsBCio9iPPjqfYUo4=;
 b=N2zIIaGJWIE/vUY0tPun6+b4JChkb2Lm4lmtQZNsLuK8cW4z3PJ6L35heqEYj2Bfm8
 gDNjQMoH1jjplm9gw780Ha06fNj/M2y8fPHzLlno5QtU17RR+DMJ979wlmduaJKbxNZ3
 NI/SRD1Yf31jJ8LW7xp+/WI/hqIp6UH7QZkEThxBcRO1MDxBWi021wg8B8nHKHXr4wWH
 cd5BX8HU2FiTmkFLLRA5lVhlPd52nspNMRN748nNkBJBdI74P35iP4CfTMFzLXoYMz76
 Z6ockTG1WqTw4rULzQJr9I2eiaRbMEwG6t7OAPpgoFaBF8TLuL59VIAffqhQn03PQmsj
 a4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710308312; x=1710913112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MIZTcNmEJsemYoBfJkmrJU3tiyWsBCio9iPPjqfYUo4=;
 b=bpBvUEDYgS/g+9FMhMKzhySbdxoj3q5XwpK+h3POFDteMYPELufxiM5Mh0UFGKIaE9
 nrEM2eIDRuz7gKugeV3juvq6cJp4HAiOSnB1Wei60sS2sfLHWf4w/ymWQesaGIqjLTbZ
 rjmwhQ2bZMCW0nVu0jHjtMcblloezrtT5+FHuAhESO8omd02Yq52fOisH3HNO98j0hhX
 huvcksqKKYC5dN2M1UKmsUbWcWz6BIP82IQ+SkO4gs9iMJGem6QpbNFt6sgyDAg66Ct7
 U1GRxPD+dXiA5bZtrpoot0aihZS1yCoq6+jlZM/YLBut6nIx+a0OfsvT8yf3w2+OPdpO
 06Hw==
X-Gm-Message-State: AOJu0YyIGX0XvqKtrEURXp9hcu8dUqNmyVt4xXdEFZfud+crR/+3LHYl
 Krrxvoyu5n9M2RvbZ6lL4ZET4Kr3R3nFWXZMu7kOUfEhPGFEI6QBydVoTjkZkfMpIzQB/0C9XEy
 wipToTqtmb0u6US840hUDXlwE4STDwU8FOKJu/A==
X-Google-Smtp-Source: AGHT+IGrIimStbFAtoKWG/6bGwv48etymlJ5iZ88sCyB/AMDZRNN6F20j424AArpv465HKAIgKjrhTcHbYnFUN2mbVo=
X-Received: by 2002:a2e:9593:0:b0:2d4:5ad9:37b6 with SMTP id
 w19-20020a2e9593000000b002d45ad937b6mr2007751ljh.3.1710308312480; Tue, 12 Mar
 2024 22:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <20231121070028.2614095-1-sughosh.ganu@linaro.org>
 <20240312145811.GA407350@e126523.budapest.arm.com>
In-Reply-To: <20240312145811.GA407350@e126523.budapest.arm.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 13 Mar 2024 11:08:21 +0530
Message-ID: <CADg8p95Y+UFFnoriH1QBFi3vagQojiaA24BqA6y9diLZY_jYaQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Generate capsules from config files
To: Bence Balogh <bence.balogh@arm.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Masahisa Kojima <masahisa.kojima@linaro.org>
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

hi Bence,

On Tue, 12 Mar 2024 at 20:28, Bence Balogh <bence.balogh@arm.com> wrote:
>
> Hello Sughosh,
>
> We are planning to use these changes in the Corstone-1000 platform.
> Do you have a timeline when these are going to get merged?

I will prioritize this task since you want to use these changes. I
need to send some changes which Simon has asked for. Once those
changes go through, these patches also should be merged. Will work on
this task. Thanks for letting me know.

-sughosh

>
> Thanks,
> Bence
>
> On Tue, Nov 21, 2023 at 12:30:24PM +0530, Sughosh Ganu wrote:
> >
> > Add support for generating capsules through a config file. Multiple
> > capsules can be generated through a single invocation of the
> > mkeficapsule tool, where the capsule parameters are fetched from the
> > config file.
> >
> > The format of the config file pretty similar to the one used by the
> > capsule generation tool in EDKII.
> >
> > The functionality is enabled on the sandbox variant and the EFI
> > capsule update test is now configured to generate the capsules through
> > a config file. The sandbox_flattree variant generates capsules through
> > binman, thus covering both the paths.
> >
> > Sughosh Ganu (4):
> >   tools: mkeficapsule: Add support for parsing capsule params from
> >     config file
> >   doc: Document capsule generation through a config file
> >   sandbox: capsule: Add a config file for generating capsules
> >   test: capsule: Generate capsules through config file
> >
> >  configs/sandbox_defconfig                     |   2 +
> >  doc/develop/uefi/uefi.rst                     |  70 ++++
> >  .../test_efi_capsule/capsule_gen_binman.dts   |   2 +
> >  test/py/tests/test_efi_capsule/conftest.py    |   7 +
> >  .../test_efi_capsule/sandbox_capsule_cfg.txt  | 162 ++++++++
> >  tools/Kconfig                                 |  15 +
> >  tools/Makefile                                |   1 +
> >  tools/eficapsule.h                            | 114 ++++++
> >  tools/mkeficapsule.c                          |  87 +++--
> >  tools/mkeficapsule_parse.c                    | 352 ++++++++++++++++++
> >  10 files changed, 781 insertions(+), 31 deletions(-)
> >  create mode 100644 test/py/tests/test_efi_capsule/sandbox_capsule_cfg.txt
> >  create mode 100644 tools/mkeficapsule_parse.c
> >
> > --
> > 2.34.1
> >
> >
