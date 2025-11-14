Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F77CE7B0E
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 13:47:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4B3A840BD;
	Fri, 14 Nov 2025 14:47:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JiND7Awh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7EF9840BE; Fri, 14 Nov 2025 14:47:04 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98DF4840B5
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 14:47:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b403bb7843eso382396566b.3
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 05:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763128022; x=1763732822; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TsznzVyE2DI6CoZ5lp+A6jHv0aeiAl2g9/H1o6iXkfA=;
 b=JiND7Awhx8H6UVmCYZxkez9ElPt/YEgG4hplSzRMsF8x8D2KIx1BNUrrwpVsId/9Pc
 xvuJdt+rMnA6/DiGOt6Y5NeLfGx8jDLFY+eyhtmC1W2qqj2GzhOeqIgk6IQe1H6epOOh
 M/rRPoNecM+iwKk0QKJ0yZ76WlwJKVdGxdoGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763128022; x=1763732822;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TsznzVyE2DI6CoZ5lp+A6jHv0aeiAl2g9/H1o6iXkfA=;
 b=C/N0ZSO18hEMObVkh3ZJyEHl2bq2LDv7d1ZuuQujQGnOvKyD5pDvdZx8DaJudy6xPL
 idSGFIR6VXP+m6mQxSu/QSVIOph3Fphme0sscGvK3dZOZglOsRaJgbIBRpFjpNaWFMwm
 16ddkr2sT6jp93jdBFpdRGKPDVdiZBV69xb61zo4PQ9q9xdT0f9wV/khIFA6JduAem50
 SzjYnCx22NmkpBw232MCI5cjq/hRevDbFO3Pz4S1linfht5Lcqx1m0sx54cz/U33ZZwG
 OrwcWfhLPyZn3hvmaZUxCQjlwjMaSAGf2/p+HlBZk/F9ytu47cd5qVIfFgNzCi+rhgtH
 QJdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmqMoTjIjQ756ntVkIH7PnslUsO2y11UCObExyDMlBmY6ZOwTZnzPml5jka8fiatyIFTUCZRQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzN6ZaXmPHjt3vDGkpH6iLmkQy9Js1HOuPtUg5ao9R6tV9dn2uH
 MR7q7xSTvx3P6+FnKUrk2GBdsHLwClya/yZmMdiu8jdZejCSibCyxxNLOu2vh8Lt86ymywBR2hE
 W2zLFtPnJ7T5L6DIRLnvAC4C5ZBv0QV/LmiA/xxcJ
X-Gm-Gg: ASbGncunkZD3w8DwPQtBv6UNFFbs/2I+okLocGGZPGL1tIISgUv/N4cVpOkGowCoYrK
 ALZIZm6vFMI4w+Fse1cR8FdfoNQXUU9umv4SvbhHekjylihunt3RGsnk6ll/V7Vh+OPEdE5cQri
 97C4hfVQyhZRJPy83Na6li6NmWQGOgtdfYH5vpzTr7I0sUvUW3S7bkeFNJm9q01itWFjN61YBm1
 nCrZzJitJkWTV22VzBlfLZC6oVetYlYd3+8oKTybrzWfugllxGVD6QQI9A3I1B6AaRJfg==
X-Google-Smtp-Source: AGHT+IG3I8iFunHM2BTf09cFCUWSMykbVTRQ4N+YwzYR9jKGwuHY/kzLvTOOiZfUpsiTQTxhk3RS+J2GsLoBqkzMrXE=
X-Received: by 2002:a17:907:1b1b:b0:b72:af1f:af7d with SMTP id
 a640c23a62f3a-b736789cb8dmr320803566b.29.1763128021938; Fri, 14 Nov 2025
 05:47:01 -0800 (PST)
MIME-Version: 1.0
References: <20251106210826.371672-1-marek.vasut+renesas@mailbox.org>
 <417e1b1a-0346-4297-9a72-7befc5b94311@gmx.de>
 <537299e3-05a1-4ff4-b594-9c73ed41a0cc@mailbox.org>
 <20251107155650.GE6688@bill-the-cat>
 <4b14ce54-6ba0-4e35-abad-6787b2d994fb@mailbox.org>
 <CAFLszTjjhOj8g63vs_hprykYrWvEM=YuwT4ZNDnuppuJ-8aXZw@mail.gmail.com>
 <f1f10508-4767-4943-8411-8eb4bb0618aa@mailbox.org>
In-Reply-To: <f1f10508-4767-4943-8411-8eb4bb0618aa@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 14 Nov 2025 06:46:49 -0700
X-Gm-Features: AWmQ_bk7Kz1yCWtdMWGV7CkE4m9HtxyfMP1ZAZ23ZHlcb2ryNm1l0GOCDU0ROCU
Message-ID: <CAFLszTjkpB-CMZNVBrsXDbexDG0saNcvGDKugQgxhES9MV1+tg@mail.gmail.com>
Subject: Re: [RFC][PATCH] kbuild: Produce diff between base DT and U-Boot
 augmented DT if DEVICE_TREE_DEBUG=1
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Sam Edwards <cfsworks@gmail.com>,
 u-boot@lists.denx.de
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

Hi Marek,

On Tue, 11 Nov 2025 at 08:26, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 11/11/25 1:38 PM, Simon Glass wrote:
>
> Hello Simon,
>
> >>> Maybe we put it in the u-boot-extras repo for now as a standalone
> >>> script, so people can be asked to run it and look at the output?
> >> I'd say no, because the output is full of noise unless the phandle
> >> non-resolution gets somehow improved.
> >
> > Another idea would be to create an fdtdiff tool which does this. We
> > already have fdtgrep[1]
>
> A new tool is not needed, up to date DTC retains the phandles across dtc
> -I dts -O dts and the result can be diff'd using regular diff.

That's good! Sounds like it was a bug.

Regards,
Simon
