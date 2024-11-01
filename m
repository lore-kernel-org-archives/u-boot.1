Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 918FAE6F069
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 15:34:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ADD589305;
	Fri,  1 Nov 2024 16:34:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cV4GUHrN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7780892E1; Fri,  1 Nov 2024 16:34:11 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9FA4889A2
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 16:34:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a9aa8895facso325197466b.2
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 08:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730475249; x=1731080049; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=44ux1sUenTr65D+lT3RM8fcJ2bcSdU4YvwdzH9dLT2E=;
 b=cV4GUHrNDY2Fk5hnrAWDpQlb+GHSSKW8BrZeOF+uPF19Atp+2lbstaNVpZIkZqmqaU
 lWOA/mJSlsAjEpdCA0bQ+iYQxRq/6QoCSFbaRUAqs6cPL6LueVty9lvmz/Oq2eO39QZ4
 mYCx4XcC6EqIJo954C+bFByIo3cf844Xkq1YU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730475249; x=1731080049;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=44ux1sUenTr65D+lT3RM8fcJ2bcSdU4YvwdzH9dLT2E=;
 b=i7Is4fZzmC94zCqiuOYdWt5tiQ1I4GPe1aDt4AwI0/xHvINQ32IWZyUS7Sa+HBMtdu
 w6xGcm6XI0cFZqhrTB1TnIjz4xIHAqEStqhtUCLVm69+u1tdD5PPAXWJGW7Phkvy+v1E
 SVgbSR5W5yOK+ro1yGJKRH09UJFDY+DUx614+gRxczBwD0/anpEln5cAFabp5oE19TGt
 JFUlaMl6i0iFZQcrCfjuLVt6IAwSU85CwZ3vEhnXJ3A52X6H+zWNl7u3gdx/YdWTBmi8
 z2zOVT/IO3Oy961Gh4Y5FEBxXQkhbkYuV0B6PCQLYN/DiAd0ehZWAG6YankjulBXG7XU
 0D4Q==
X-Gm-Message-State: AOJu0YwrqlMJipxVsyR4Pkb2lc6se2/f2JfjEyqLEhKUEoW8a91FHyEO
 7HokzTttWkPUY9y+kkXJanfm8Hw8Ji3vG409DC2gBrX4Hzf3gugLc23P+sNwz2E7fadVj57yptM
 IP5y6WNh3fXQOIiGtqU2hJl6071KtZxHspvv5
X-Google-Smtp-Source: AGHT+IFx60AiIj/loZapG+SoP7ug98u5M151NuRSMT5oowS0SC6PqiKoI8ZeP59UwoDizN1onDw/4WZRVOg7gMx+koM=
X-Received: by 2002:a17:906:6a28:b0:a9a:e9c:1d8d with SMTP id
 a640c23a62f3a-a9de5ed2633mr2219414966b.17.1730475249229; Fri, 01 Nov 2024
 08:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <20241010015145.1977999-1-sjg@chromium.org>
 <20241010015145.1977999-4-sjg@chromium.org>
 <20241029235308.GD2558755@bill-the-cat>
 <CAFLszTiuA_-xZZoca=DpXZTd2GRsdJb4Z2O3nO5Ab7bjaAxXfQ@mail.gmail.com>
 <20241031184212.GD3600562@bill-the-cat>
In-Reply-To: <20241031184212.GD3600562@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 1 Nov 2024 16:33:54 +0100
Message-ID: <CAFLszThjEtd6EzWt1N7NErVqWh15f9tjfnnjfNwv04t8R3b_-Q@mail.gmail.com>
Subject: Re: [PATCH v7 03/11] test: Allow connecting to a running board
To: Tom Rini <trini@konsulko.com>
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

Hi Tom,

On Thu, 31 Oct 2024 at 19:42, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Oct 31, 2024 at 07:00:24PM +0100, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 30 Oct 2024 at 00:53, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Oct 09, 2024 at 07:51:37PM -0600, Simon Glass wrote:
> > >
> > > > Sometimes we know that the board is already running the right software,
> > > > so provide an option to allow running of tests directly, without first
> > > > resetting the board.
> > > >
> > > > This saves time when re-running a test where only the Python code is
> > > > changing.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > >
> > > I'm not NAK'ing this, but this is not a open to errors kind of change
> > > that I like. It also feels like an unrelated "I find this change useful"
> > > kind of change.
> >
> > Are you saying this change is open to errors?
> >
> > It just avoids needing to reset the board when I know it is already in
> > a good state. So it is a time-saver.
>
> Yes, I'm saying it's open to errors since your assumption is "the board
> is running what I want to test". As a human, I've violated that
> assumption in the past running tests and short-circuiting the loop to
> just re-test what's running.

Yes, that's why it is an option. I sometimes find myself iterating on
the pytest part of a test, where U-Boot is not changing.

Regards,
Simon
