Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B367D6E2DC
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 19:59:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E3E080050;
	Thu, 18 Dec 2025 20:59:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WtPpfXNs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52FD7800AB; Thu, 18 Dec 2025 20:59:03 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC64C8003E
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 20:59:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-78c5b5c1eccso15070427b3.1
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 11:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766087940; x=1766692740; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tqB2JjliS2u+Idvr9ZGB0yBC3QF1DVW0gsfTWB32608=;
 b=WtPpfXNsELJIztQBU/ptd7TzMhwxxog1/B6pJradnCNXbJNlUZyJV3sWEi0IX67ELh
 0IPpTHIy/4mp3lKFmZzjSVwYw5KTNvu015HS6cVMKJGkQ/M6bTTi9wnFLbvjrA7raCoV
 iYZMlGe6SSJfsB00UYGIWaH1sXIlW6uo8mjeDoiTcbuMfSwbINeKC6omIogKBtnh49w8
 7dXHOoEvvwpCqnzvJ9wNcP/tg1leoyx7hbIlwV9sf0VwOLS38ktm0q/OiDxg3OMPncgP
 T9arGSpDz1CBiIfWbuQ1HuubATt4v9rUz7LZ4jVVlf/UooIh1zRvi6I+YzZyDSJUfmLN
 bXSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766087940; x=1766692740;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tqB2JjliS2u+Idvr9ZGB0yBC3QF1DVW0gsfTWB32608=;
 b=BkbNtFD6bf5dIflef/JkjQxHUWeKH+uB+Q1p9QGgxh4UKWv/yP+oYV4bxEpjT45gt8
 hBNcJPo/0tvr4gOifO9ijIqzYJIca4JYIPyqekYwUXOYjCjuUm7kkqcn7Zu128BKYRE4
 2Ph48ashk1LB9jztLfk+qEjJQn0s3/esaGpw7RmFMXX7J22aadcR4l0w3WUub0KAJXtR
 yWpdVBZrShK9P5venMcDa0elahrrXLW98/x74ntMbH4+iZPe6dXf53kY55CJenTzegIy
 30cQfNGugCMK8P7Ldd6ZLIIsG8ZFDpj3E0sDmzh2AmTwmFOFQRYrBnOrDdXOc4WGBF0U
 zwgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFtCbfC3iDhW0NifzvpDU0LiFvvLXQM7R9kR1H31RJqrMRI1iSVVA3xkUIdTA5fEF+wlE0TdE=@lists.denx.de
X-Gm-Message-State: AOJu0YxwDVDnDCxtlzEuIaOHC1hmAdjb2cFBO9F2KaRf0ADWLEiqr5Dh
 Xm2QSwimBxv3iGVrQ6TP9Jd0BaM9wbuLvSoeKe4lyMTbZjUnn/vVKy8S68XqwuRZRhtba5d4fNM
 fW03eeaAc4pOrPSniQLxxANisO+MrfqMlYLBRHb0=
X-Gm-Gg: AY/fxX6pIoWLisCcqKQf+Cuv+x4O1/pG3afBScwCgWU2D2fgr3KhcdufufERQdfbB+Q
 lhRO/ZkzrGC9WS4ZJVf/UcJglSoPbsvSS4BIrx6ne/oJJvhlVa3zmtktRclC3ExqgQRBAy3Xkg5
 k/2vPhGfZSsXsE8ccszkYy6X2tiYJjGHY5qfLWNi+5ZJ3oQJskYL2MT9KMetX2XFT4kZVwIlQed
 I/MrnQP7wLeHa24NpFczC8DjYJgMq1TkFB7mT6YkiQvXc2nraR3iYdfV/a1/mJFXkh6wA==
X-Google-Smtp-Source: AGHT+IEsV4eDRA9o6GzaDwZRN6dX0IU1u0vGh6UYlZv1qLMBV/PJ4A7dALzI2zW68XU0fYRaN5YtYAz6qCDZ2g2HS9c=
X-Received: by 2002:a05:690e:1519:b0:63f:af94:79d2 with SMTP id
 956f58d0204a3-646632c3186mr3106674d50.34.1766087939615; Thu, 18 Dec 2025
 11:58:59 -0800 (PST)
MIME-Version: 1.0
References: <20251218194218.1972757-1-judge.packham@gmail.com>
 <20251218194218.1972757-4-judge.packham@gmail.com>
 <20251218194619.GO303283@bill-the-cat>
In-Reply-To: <20251218194619.GO303283@bill-the-cat>
From: Chris Packham <judge.packham@gmail.com>
Date: Fri, 19 Dec 2025 08:58:48 +1300
X-Gm-Features: AQt7F2oXdZmO-NZ1_6N8h47HuhYHfjufQlWaIYhacCgDpMtiEcll9QxxCMcudRg
Message-ID: <CAFOYHZBRNdVRwhP3XNH_xodPB3iq4RZOXjUTEE5=rMRWj+0yKg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm: mvebu: Add Allied Telesis x220
To: Tom Rini <trini@konsulko.com>
Cc: stefan.roese@mailbox.org, u-boot@lists.denx.de
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

On Fri, Dec 19, 2025 at 8:46=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Fri, Dec 19, 2025 at 08:42:18AM +1300, Chris Packham wrote:
> > Add the Allied Telesis x220 board. There are a number of other variants
> > with the same CPU block that are sold under some different brand names
> > but the x220 was first.
> >
> > The x220 uses the AlleyCat3 switch chip with integrated ARMv7 CPU.
> > Because of this it is reliant on a binary blob for the DDR training. In
> > upstream u-boot this is replaced by an empty file.
> >
> > Signed-off-by: Chris Packham <judge.packham@gmail.com>
> > ---
> >
> > Notes:
> >     Changes in v2:
> >     - None
> >
> >  arch/arm/dts/Makefile                    |   1 +
> >  arch/arm/dts/armada-xp-atl-x220.dts      | 162 +++++++++++++++++++++++
> >  arch/arm/mach-mvebu/Kconfig              |   7 +
> >  board/alliedtelesis/x220/.gitattributes  |   1 +
> >  board/alliedtelesis/x220/.gitignore      |   1 +
> >  board/alliedtelesis/x220/MAINTAINERS     |   7 +
> >  board/alliedtelesis/x220/Makefile        |  14 ++
> >  board/alliedtelesis/x220/README          |   4 +
>
> We shouldn't have board README files anymore, it should all be rST and
> under doc/board/... and so we should get this platform started in the
> right direction there please.
>

Sure no problem. I'll convert the db-xc3 while I'm at it

> --
> Tom
