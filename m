Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389FAC36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 15:54:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3A8780FDA;
	Tue,  1 Apr 2025 17:54:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Nw1lFdE3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 505E381703; Tue,  1 Apr 2025 17:54:08 +0200 (CEST)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0171280584
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 17:54:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ff6a98c638so11527359a91.0
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 08:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743522844; x=1744127644; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AGzXlmldMSUVnrPZfTJ37CN5SQgYV4hLqFGdrWbTbeo=;
 b=Nw1lFdE3K4Sy7MD+tc2MQUdgr+Us6hpNATcOFD+oNa6a6wOthKTsySj2v91MRwtk8i
 XbDxwLws3MJ2RaBjR1NsgRBls5qayHUGqrWb0CTdeZ2xswDMd+8zLUJA3cnp+I+RJIPa
 wGvyDGnU+wX7d35hspZNHdvha1SgPt5rIIPYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743522844; x=1744127644;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AGzXlmldMSUVnrPZfTJ37CN5SQgYV4hLqFGdrWbTbeo=;
 b=VPogD4ZWY+cJ2cFXoNk02wBaofqahKppFXcKILn39r4/WMyMEDEoIlX5rqfTA4E/3e
 yl62KfPPpAwyo6mB9+ATl+wPvFRSNRxIf5m8+nfSIi0NYuwPcCss5b/txvGorvucFV/b
 x4NdcTDthagXsgyun8iafa0OP15+OUymyU59KjGJaApYAbIWrjbYCg4HJJwZwsPRumpG
 LyMsY2ivpsGWUV513k/5xih0zbNPpGnQGn2Zxurr7MnUSluSQV1nhhbu65n1Fn8mDyPH
 RgTY01ipoKHM91/uvWcOPIXABAxfqJUMOzBFQJhUN1Vwok57PpSfRurvc0YPWAIg/E5I
 RhCA==
X-Gm-Message-State: AOJu0Yy/okiy+w8uNUaD6cpKDaCFsc2FXvyfnswvaKBe/AX8izf5PBEl
 DZyyl8kictiTEq95slBROBWuiYEg8WIu3U4QNnYp9Hc+feGdv5bpy1woQSFlX1ekL02bM1mlT7z
 F7vZo2/cZ8ORZnYTUC8EJ+kvPTawH1lt54jsb
X-Gm-Gg: ASbGncvjpJnmWQnZ6gW1s3BH6FSZ+OOMAnoWaUMITU7hT9Y0gaiOvHj9A3Ab2Fu/LRL
 jbudbISwZzSatT6KK+mOWrpEXXOcgzQ1LIe34AfjN41IYDZtZ/GSSdpwFcFC8PKzrB48MGtpfex
 BbXhQljueXN+5PgNPec9dS6Emuctyy1qhi+rsnRIw=
X-Google-Smtp-Source: AGHT+IEaDI80VBhlXHplCpViOv7IOQqVgRF13jlLbLgrMy6Q9+LnZ53H3GAJQSAWUfLX99HBCor5BTwJRCSDGUwX/cI=
X-Received: by 2002:a17:90b:2dc2:b0:2f9:cf97:56a6 with SMTP id
 98e67ed59e1d1-30531fa18b7mr24370752a91.14.1743522844511; Tue, 01 Apr 2025
 08:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250319143820.2385092-1-sjg@chromium.org>
 <20250331174008.GG93000@bill-the-cat>
In-Reply-To: <20250331174008.GG93000@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 2 Apr 2025 04:53:32 +1300
X-Gm-Features: AQ5f1JqTASR3lUiNxb3Y_GAiJG-gg6ilzo5s-znwFnuKhamDumc1NqhIA--fm5Q
Message-ID: <CAFLszTio55sM+TUyV429Fv8vXv-AkE-HWS4ROC_qOZK=UdjBMw@mail.gmail.com>
Subject: Re: [PATCH 00/17] bootstd: Useability improvements
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Baruch Siach <baruch@tkos.co.il>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Dragan Simic <dsimic@manjaro.org>, Guillaume La Roque <glaroque@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Julius Lehmann <lehmanju@devpi.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marex@denx.de>, Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>, 
 Nam Cao <namcao@linutronix.de>, Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Richard Weinberger <richard@nod.at>, Roger Knecht <rknecht@pm.me>,
 Stephen Warren <swarren@nvidia.com>, 
 Stephen Warren <swarren@wwwdotorg.org>, Sughosh Ganu <sughosh.ganu@linaro.org>
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

On Tue, 1 Apr 2025 at 06:40, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Mar 19, 2025 at 03:37:54PM +0100, Simon Glass wrote:
>
> > This series collects together some bootstd improvements:
> >
> > - Improve iteration when there are a lot of devices
> > - Add a test image for Ubuntu (to compliment Fedora)
> > - Improve the naming of USB devices and bootdevs
> > - Add a new command to set the bootdev order
> > - Add a little more debugging
> > - Use an abuf when dealing with allocate files
> > - A few other minor things in bootstd
> >
> > Most of these issues were found when adding the new test image and more
> > USB devices to sandbox.
>
> This isn't based on mainline, either:
> > base-commit: 569681e993486b830035064f23ec87bcd70795d1
> > branch: schc
>
> And I don't know why.

I am sending patches in the hope that people can review them and that
some of them may make it into your tree. I'm doing everything I can to
minimise the differences and I would encourage you to do the same.

Regards,
Simon
