Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B0D7C5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 07:08:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB47F81E72;
	Tue,  3 Jun 2025 09:08:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V/RXjeQS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A613B81F0D; Tue,  3 Jun 2025 09:08:04 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 495C780F0E
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 09:08:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-60462e180e2so11104316a12.2
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 00:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748934481; x=1749539281; darn=lists.denx.de;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ITGMP7hln6IWw5uRG9ZzXb1NKBfxeXxsD+QAjMgM4/U=;
 b=V/RXjeQSiNBh4ke6KOigy2vXSD/b8KIDD24KIwbqaEWKDkjRt3+acoQeqb1KBCoDSp
 5mLKCxH9+UDRqpnayQBkzcUMVxuQfCUPgRBhucw6vp2g/4ZWGJW7HTQWudB5JibtnBrC
 XOedY2dOM3IpAXO3ASMNEQa5T43bJn57qa29n/ZwpAuV8HZC6NoLRiWAU1G4Z7Z3Xt1d
 BuV8yKNSct7Z+aBFJi8Gj7AlHl/cZraJNxMQobcjUf/EV1h02LBjgLElTstta+Dov18C
 hbwiVzJlBou9wH0lfe4rTn1lqgbxWb9DgsvIKy2omsWhIBx2Ks2yyOyu619eHN0z9nTl
 Y52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748934481; x=1749539281;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ITGMP7hln6IWw5uRG9ZzXb1NKBfxeXxsD+QAjMgM4/U=;
 b=FGcjEjjlG3yAtrmCb429EfQ7PLEmln/u0KrcoFoRpkhXfykuhi6Yuizedt7iyuyrls
 HcNYFlhz9hOprJImPE3lmyU9r9NGKFgXNYdmuooWzgLo2xiiu7AbZ9MJ//52XO7VNjS4
 vnf/wnHSAUNfssWo9UBxrTUDLGzcoCgjGDhqYJV1lp8z3SrDWSFk5OWHuE31MCuQXuwD
 tlhs5GmSOWfvTD4BszvhJaZvkOQ2akzJ0HPwof05WJQ/mLFmU4YRrp86t/muflO85kim
 OLmad4Vgz6+DwyUklplIxTYkmExec9emWA5BxRViBGoBXiy//Nki7ROwb/H+1+7CwGCU
 DZ2w==
X-Gm-Message-State: AOJu0YxoJjQVETKmUOaT0upM4cMaDqd6M9vs6BKusa3EsUPLIBDF8vgr
 79X2qDCEXDSK6q/7ygux8gRUYnDSGOqKH9SfBKvWOPUMmAdHHyPAvLtVke+krwq0tsDdjSF9Qar
 6KZSQSYjFCOsiaqfW9FZ4d2FDniBAQOzu
X-Gm-Gg: ASbGnctfu4h7NbHScSCT7Vs4bwSa7x2tfeeDOMUwFL19E5napYVU3lFrUpZHglBgJil
 2dJL6RezFExYrF7NQZWpTHQ/71HPXX+jUb8f0+SqTUe0mSqm0gtkbA2TO/0g35Re6gdWbIx3mOO
 5mmGukMaA+ZK+tx7Su7wI2V560PQINQZ4Io5x7ojpqpR78rfM45gAUrGlgc5KAeb7a
X-Google-Smtp-Source: AGHT+IHG1ZHVCFMejJQ4kVCjHSLVeDH61tC36N/IG0KEt6JwetfT5P/gZ+WXupogbgNyGBup5U8IONvUA0Qi9anAAiU=
X-Received: by 2002:a05:6402:35c2:b0:601:f3f1:f10e with SMTP id
 4fb4d7f45d1cf-6057c1a503dmr13583680a12.5.1748934481209; Tue, 03 Jun 2025
 00:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250602194507.15159-1-malysagreg@gmail.com>
 <20250602194507.15159-4-malysagreg@gmail.com>
 <EB8928C9-E912-4F52-B080-B7EACBA89740@gmx.de>
 <CABdDSeV0D2n223hu+2pAp0x_UksGU=15m09pwY7edgpP5kZ9_w@mail.gmail.com>
In-Reply-To: <CABdDSeV0D2n223hu+2pAp0x_UksGU=15m09pwY7edgpP5kZ9_w@mail.gmail.com>
From: Greg Malysa <malysagreg@gmail.com>
Date: Tue, 3 Jun 2025 03:06:05 -0400
X-Gm-Features: AX0GCFtt4Q0s18Zm4exjkfCeFGJ4vwyJeGF7xG0I_Nq82uwN-l6IN-b_6cfcPL4
Message-ID: <CABdDSeUaKVPYO5YvZqVe-eUiEYA0470QA40hH8FYc4FmUJv6Kg@mail.gmail.com>
Subject: [PATCH 03/10] docker: add ADI build-related tools to docker image
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, adsp-linux@analog.com,
 Simon Glass <sjg@chromium.org>
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

My apologies, I accidentally didn't hit reply to all, please see below.

---------- Forwarded message ---------
From: Greg Malysa <malysagreg@gmail.com>
Date: Tue, Jun 3, 2025 at 3:04=E2=80=AFAM
Subject: Re: [PATCH 03/10] docker: add ADI build-related tools to docker im=
age
To: Heinrich Schuchardt <xypron.glpk@gmx.de>


Hi Heinrich,

On Mon, Jun 2, 2025 at 4:11=E2=80=AFPM Heinrich Schuchardt <xypron.glpk@gmx=
.de> wrote:
>
> Am 2. Juni 2025 21:44:41 MESZ schrieb Greg Malysa <malysagreg@gmail.com>:
> >ADI processors require packaging with the ldr utility for bootrom
>
> "ADI processors" is not self explanatory. Can we add a sentence like
>
> "LDR files are the executable format for the Analog Devices ADSP-SCxxx on=
-chip Boot ROM. Provide the ldr compiler for ARMv7 and ARMv8."

Yes I can update the message with text like this for v2.

>
> >
> >+# Build ldr tool for ADI boards and install to match expected abi name
> >+RUN git clone https://github.com/analogdevicesinc/lnxdsp-arm-poky-linux=
-gnueabi-ldr.git /tmp/lnxdsp-arm-poky-linux-gnueabi-ldr && \
> >+      cd /tmp/lnxdsp-arm-poky-linux-gnueabi-ldr/src/ldr && \
> >+      ./configure && \
> >+      make -j $(nproc) && \
> >+      cp ldr /usr/bin/arm-linux-gnueabi-ldr && \
> >+      cp ldr /usr/bin/aarch64-linux-ldr
>
> In the Docker image we tend to put such tools into a directory in /opt.

I will make this change as well and run through CI again on my runner.
I'll wait a week or so for feedback on the rest of the series before
resubmitting. Thanks for the feedback!

Thanks,
Greg
