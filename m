Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A09C5C8303C
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 12:14:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF6F1803DF;
	Fri, 11 Jul 2025 14:14:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aSyQPpAR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07C57805D7; Fri, 11 Jul 2025 14:14:56 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EACB800D7
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 14:14:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-553c31542b1so1978094e87.2
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 05:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752236093; x=1752840893; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dPmp2KdDAISOiFXR3yfw7lMj8kEhRW2x7i3HAVqhfo0=;
 b=aSyQPpARUONOeLIRPyDm3v1JqJOL0EDeFes3lnoiYTym2KYuJZ3UIp1rIYZN6xdA+R
 HVlu3YwMj51Esix/CjNndYreItvRlXsjmfw2JewyNQXzwJOpJrQGo9Lm8C8eNjjKB1iG
 8OwdsZXZTBbS9ZmQa1gMb5SriKm7ccM96Q5WvShxs8OZh7AnurmzdG7m72wCK8q0HuUM
 gC8aL0NP3dOl3PsH+6NcIZoQSddCT3LfANc9XGDpMkO126VcRrIG04bBli+NAJTV/xBl
 DPoXoJzw3SvvzvTvS0G4nfl8OKbqL9U0TOOazkhjXAv9GdhSdtTOCj068hW7G4q/ufdg
 v2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752236093; x=1752840893;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dPmp2KdDAISOiFXR3yfw7lMj8kEhRW2x7i3HAVqhfo0=;
 b=d1CtlDdEkVoRV25MwlJe7K0YvMlOyt0OFUNI9RKqI7ANWTshuaGVX7TItWxfWvFBEY
 /r0MlixYyj7k1yte0BvMICNzl8wJ3srZVh1z93SDpAXiktOVqV1NHNQ8Bsr34NH+3JcN
 HrlrEV7knscdvtmAbJhAlpNCmZ6BSZD7w1182wiGV3hqIhtomm2z2oa9HK9Sc1LSnxCv
 JzUmnvAx61rSR6qNt6XBG+seARWoSAQG4Uhavda4+g/T4r4dOAn66SrO01Nv7/dRcwbY
 l5vR36F1OpwQvxvxZFLaJJ4zJY5KP1j8E/7NbuwJNLrkv16gFYHcnY6AHwSKQmNtN4oJ
 /CZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHQ6ggNwknPY7+vMAzl7LHncB9mz6jVz7v8Yi4GHfUN7ge6kDY/uFyE3uXzq0Di/adlDc9irc=@lists.denx.de
X-Gm-Message-State: AOJu0YzdJVCYFdZv881AxEpfviepaPtLPyU5VQIQoo4Upw2P+1agqYzu
 p1VjIux8MBergV6+1lZW+qTCpc2gRBdbKMFLH39EPJSymraOKOXaATOyX4zgTGHwAd3es+5IW8H
 tdXOgiMjKMb/Ya8oKG32EFlvUZcmJ8eU=
X-Gm-Gg: ASbGncvuc45OX0mewCS7Pxwsy5fO/qDgP1rLRq9MQdDuKkcVGtGVX6LTFKLdz5fbgk6
 ShC9mMqYirzJxRNhD/lDTmXynme2+54ffVfscEQs/7X0SKyXLAg8IUfQXVKGawd+jJH7y+jkqNw
 myReYalDCDDrwOlmvFobc2mT2g68H2f41QnJ3Rn8PjvHaJqfLPLTv2NJaZKqHdHxZPJGZkOiBY7
 txt93uf4ZziwS1EuUXmHKM4mXzsLsfyUmIN27M=
X-Google-Smtp-Source: AGHT+IEh4mT8bDT0Mg2wrYQewz2O0ZWAnJOVhVAGa6I+EQ+cEnsnhT5XQS9ekNr2/ob50em2J0L9oxNAsmb9rh4Rci8=
X-Received: by 2002:a05:6512:304e:b0:556:c4f1:c7d6 with SMTP id
 2adb3069b0e04-55a044ada33mr832674e87.7.1752236092845; Fri, 11 Jul 2025
 05:14:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250711085234.23659-1-ziyao@disroot.org>
In-Reply-To: <20250711085234.23659-1-ziyao@disroot.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 11 Jul 2025 09:14:41 -0300
X-Gm-Features: Ac12FXzIpoYbhcN__mQ2T9Wvi8zdTS-HEtS1oY0rLdMb6FDv99l22DS9quk64rg
Message-ID: <CAOMZO5DANDEVy8eAS+D4z1fKZX8zkaCishY+m9C+KA1WHCX-LQ@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: Avoid including architecture-specific Makefile
 twice
To: Yao Zi <ziyao@disroot.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Yao,

On Fri, Jul 11, 2025 at 5:53=E2=80=AFAM Yao Zi <ziyao@disroot.org> wrote:
>
> Stranges errors are observed when building U-Boot master for almost any
> RISC-V board, the messages are in two types, one is about duplicated
> symbols,
>
>         u-boot/arch/riscv/cpu//mtrap.S:32: multiple definition of `trap_e=
ntry';
>         arch/riscv/cpu/mtrap.o: u-boot/arch/riscv/cpu//mtrap.S:32: first =
defined here
>
> and the other is fixdep's complaint about missing dependency files,
>
>         fixdep: error opening file: arch/riscv/cpu/.mtrap.o.d: No such fi=
le or directory
>         fixdep: error opening file: arch/riscv/cpu//.start.o.d: No such f=
ile or directory
>
> where the latter could only be reproduced when building parallelly.
>
> Both the two types of errors are about files in arch/riscv/cpu, and
> there's a suspicious slash character in the reported path. Looking
> through RISC-V-specific Makefiles, there's only one place that may
> expand to such a path,
>
>         libs-y +=3D arch/riscv/cpu/$(CPU)/
>
> The right hand expands to "arch/riscv/cpu//" if $(CPU) isn't defined at
> the time of including. With some debug statement added to
> arch/riscv/Makefile, the output proves that arch/riscv/Makefile is
> included twice, once with $(CPU) undefined and once defined correctly
> according to CONFIG_SYS_CPU.
>
> Futher bisecting shows an extra include statement against
> arch/$(SRCARCH)/Makefile is added in earlier bump of Kbuild system. But
> the statement is evaluated before config.mk is included and definition
> of $(CPU), causing objects in arch/riscv/cpu/ are built and linked twice
> (once as "arch/riscv/cpu/*", and once as "arch/riscv/cpu//*"), resulting
> in the error.
>
> Let's simply remove the extra include to fix these nasty errors. For
> config targets, bumping Kbuild also introduced a new include to
> arch/$(SRCARCH)/Makefile, which is removed as well for consistency.
>
> Fixes: 5f520875bdf ("kbuild: Bump the build system to 5.1")
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

This fixes the mx6sabresd_defconfig build, thanks:

Tested-by: Fabio Estevam <festevam@gmail.com>
