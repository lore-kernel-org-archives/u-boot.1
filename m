Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7794CA0ECC
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 01:04:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EC0588D28;
	Fri, 30 Aug 2024 03:04:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ij57uFqX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D02F288D2C; Fri, 30 Aug 2024 03:04:49 +0200 (CEST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B47D488D17
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 03:04:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-44ff7cc5432so8813981cf.3
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 18:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724979886; x=1725584686; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=94cB59IEu03/K2S4Ila2dUuArCplnMWMIcBFcRb//44=;
 b=Ij57uFqXdp6ul82hvjlCuD/NmnLCnbRRc0/jWs4a7hYcNeYrAcIpySd+sKLCv5KFvf
 XMEbx9Q3zhIMR0mTUGvGHw8VCuFv/QiniWBkP+Sdk8e8xV3MjWOZs6TeuqQygoerUwj2
 moNdfCftLgLzegvZYKfViCPjMR4jEUOIXqDfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724979886; x=1725584686;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=94cB59IEu03/K2S4Ila2dUuArCplnMWMIcBFcRb//44=;
 b=PWUOKRtJJmYYFDsaTS4CT06yuS0VF9dAAPBGxntQj8FZoL7a1QDe4aehvAYD3bsk0S
 QMO4bgVpMcxRziW3iUc/mcvvkZZggnISKJXP3pxWEIxv6P9l/fYLg1qfmSREZBjx0BPx
 QoNwrq7iIZd1DVzUFykEt9Q1mReByu0wr+2Vs93lIUkYaVhd8zbY5sDFcbaj8SFmpnsc
 JOthAiL40xxPBItNQ4rJxjKBDNGzN4W4Ag22qHTNfUqAvRVPdYtkpj8yzZa2EUZQfy9L
 ofcc9gknyPUQnIcJLmomLiPggaYIpJ3zdW7tiAlA7wBR0ksexqvhhZJJTPw0qRp8Z+9s
 Jajw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXES53ENT8zh9fG1gsoQ2OEaXcZs44nYjh4ELgoh9U/tlUJLI6ZpI2nuB7qbAlbE+CpVJvTQRc=@lists.denx.de
X-Gm-Message-State: AOJu0YwMOKbFcjLr6hPkq0OcAgAictW7b1AeE59+GsDouaHacV2ao3yP
 ExeJi77o5m+VCQXcgLrW/WMBkOWKVw+4Ksdr69+CnxDTgZUpx552pqZzXYQZKgVPdb6pKoilNx6
 tVSxbETZZLnv340zZVkBmYFUGbdR5DRWxepYI
X-Google-Smtp-Source: AGHT+IE1LIJ1PsYFgRwSdNnnXlOSNFlOHiRFhLoUvqiIVb/MWQsy+i4HNybQAjBjWh7veEOMVgb5F+7wMOWsMNGp5/A=
X-Received: by 2002:ad4:4c0a:0:b0:6c3:4655:8d50 with SMTP id
 6a1803df08f44-6c346558fadmr16316646d6.3.1724979886703; Thu, 29 Aug 2024
 18:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240828220846.1205813-1-sjg@chromium.org>
 <20240828220846.1205813-18-sjg@chromium.org>
 <1637be2a-2fa8-4686-8868-077ed430ae8a@linaro.org>
 <CAFLszTjZOjXwY4PXGWkCu-7ehuA_XBCcnjLtmF4hKUC2K-NyNA@mail.gmail.com>
 <20240829165906.GG2479150@bill-the-cat>
In-Reply-To: <20240829165906.GG2479150@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 29 Aug 2024 19:04:36 -0600
Message-ID: <CAFLszTh4A2NH8d6hocom3pAzYB4ExgVbDRa+6phux7K5P9X4Pg@mail.gmail.com>
Subject: Re: [PATCH v5 17/20] test: Try to shut down the lab console gracefully
To: Tom Rini <trini@konsulko.com>
Cc: neil.armstrong@linaro.org, U-Boot Mailing List <u-boot@lists.denx.de>
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

On Thu, 29 Aug 2024 at 10:59, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Aug 29, 2024 at 09:01:17AM -0600, Simon Glass wrote:
> > Hi Neil,
> >
> > On Thu, 29 Aug 2024 at 08:26, <neil.armstrong@linaro.org> wrote:
> > >
> > > On 29/08/2024 00:08, Simon Glass wrote:
> > > > Send the Labgrid quit characters to ask it to exit gracefully. This
> > > > typically allows it to power off the board being used.
> > >
> > > Sending those characters every time could collide with other CI systems,
> > > I don't think it's a good idea.
> >
> > What systems are you thinking about and what sort of collision would occur?
> >
> > What do you suggest instead?
>
> Why do we need this at all? Did I miss where we send picocom the
> disconnect nicely key-combination?

When labgrid gets a signal, it exits. It doesn't continue its
co-routines and execute the end strategy to power things off, etc. I
suspect it could be made to do that, but I already have 62 Labgrid
patches, so I thought this would be expedient...

I can make this conditional on the new USE_LABGRID variable.

Regards,
Simon
