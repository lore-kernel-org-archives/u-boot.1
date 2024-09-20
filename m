Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86044CF9C55
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 15:59:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFD228888F;
	Fri, 20 Sep 2024 17:59:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nG16mFp6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B02788B14; Fri, 20 Sep 2024 17:59:14 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFD0188883
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 17:59:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6c359c1a2fdso16316396d6.2
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 08:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726847950; x=1727452750; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z2cVc1L1zSrL41txKQ8NxlzBRB0ayiM2nfycEcNua54=;
 b=nG16mFp6DJglwyyVmptZMc/KyXwnPdOawPgu6GT4dQ8QXGuxdsMwo/FrjsCWOIck9s
 hPWdkasKUPfLqtmpK1pcAd2NotK7qZTXITZLY5wHIwlKKeSAxDpW54fNUmwACxhd2uPG
 B23REGFWeUMWW2gMpQqEGueSFapyhzAAaN3bA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726847950; x=1727452750;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z2cVc1L1zSrL41txKQ8NxlzBRB0ayiM2nfycEcNua54=;
 b=L7bf3dk25wIJe7SDB/jC/IJrQ//uereN5ELSKgoH52xWJNcKA4PbhwrjYpVFwv5Egh
 I+eYHQhRHSyDQtrCUHqSluBX5KIxZM1GJ3Ok85bXW4qlkq1m7RkOXMwPfb2T3tBRmjS5
 i5hAIW4nDDsG48WR1i4BwWwHDgYO81CrFp1p8xcSMFr+qNL9uYAdLwCkjaS0AGORal6D
 DoLRB8CsuJhLUZQOIVBQfdH+cRQyEQ9bM5RIyadIyII3TA1W9UdXMs394RTIQ8qfHSX1
 ri4BU2aMdLb5c1VRFmununu4pU7kYKQF9enatbes2XUT/YysgbgCtD7q2+4tD3xOUDxy
 Hfvg==
X-Gm-Message-State: AOJu0YxoI8nqBl8fBGiWX0vbNhtSXPZUdB2q+SNHR9eoZ+f88D5naHG9
 LrIofChZuXdlzkmlRIhK2FHJXTzf3pC51MU3t5Dqecr5jJLnTCme7oGqZTSByv6r6KlY6tSmswp
 n6gNvvceY2tvjW4TcvBOu+Yb2gvdrkrh8DYiX
X-Google-Smtp-Source: AGHT+IGHJsuSIQX3f8AXhF4tqltiFyUgSUQZgezkcVYWFPQD8RMfgspciju7xYbTp3QQb45LRVMDdxSqdwHxQpulGfU=
X-Received: by 2002:a05:6214:190d:b0:6c3:7030:d28a with SMTP id
 6a1803df08f44-6c7bd6622c3mr35529036d6.43.1726847950626; Fri, 20 Sep 2024
 08:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240829145802.1827952-1-sjg@chromium.org>
 <20240829145802.1827952-4-sjg@chromium.org>
 <20240904222531.GA2479150@bill-the-cat>
In-Reply-To: <20240904222531.GA2479150@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Sep 2024 17:59:00 +0200
Message-ID: <CAFLszTieSjNrzT4i8pbjDXza==+VhHOG8sSHmU8aDykR3ypZzQ@mail.gmail.com>
Subject: Re: [PATCH 03/19] boot: Allow FIT to fall back from best-match option
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Eddie James <eajames@linux.ibm.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, 
 Paul-Erwan Rio <paulerwan.rio@gmail.com>, Raymond Mao <raymond.mao@linaro.org>,
 Roman Stratiienko <r.stratiienko@gmail.com>
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

On Thu, 5 Sept 2024 at 00:25, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Aug 29, 2024 at 08:57:46AM -0600, Simon Glass wrote:
> > When the best-match feature fails to find something, use the provided
> > config name as a fallback. The allows SPL to select a suitable config
> > when best-match is enabled.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  boot/image-fit.c | 19 ++++++++++---------
> >  include/image.h  |  4 +++-
> >  2 files changed, 13 insertions(+), 10 deletions(-)
>
> Don't we need a documentation update? If no, because this mechanism
> isn't well documented, can you please follow up with that? Thanks.

CONFIG_FIT_BEST_MATCH is mentioned in the spec [1]

But re the fallback, I'm not sure where that should be documented.
Perhaps add a note at [2]?

Regards,
Simon

[1] https://fitspec.osfw.foundation/
[2] https://docs.u-boot.org/en/latest/usage/fit/howto.html
