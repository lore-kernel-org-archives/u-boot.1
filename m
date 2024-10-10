Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8061CCF11D5
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 12:02:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CFFD88BC2;
	Thu, 10 Oct 2024 14:02:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MDrlnh5X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4F7388E21; Thu, 10 Oct 2024 14:02:31 +0200 (CEST)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B09378837D
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 14:02:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-656d8b346d2so522303a12.2
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 05:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728561748; x=1729166548; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y9Z/dtgZUEmfdtYGG5Lhq6BUh8icZiSHj4HDxYVajWY=;
 b=MDrlnh5XRMLHmPiRjm5+FCR4Hy5SbSjNOxJv395fJDwesvzgMW7jhc2VoLWs5XfQ3Y
 eg4BPqn0K2RZKk6d1/YrEvJuESGcy5tEa7iz2VmZrH6hSRWjG20oOIT9ctNM7CJwWhLe
 mMLjRAZu4UGnHKYow/rVF9e7TRrD30BQFtpOGzQjfyaxBXcd2FvKECfwZskIRav70jaM
 Gm0vLudVqZARHITYglOncCSpplfBC4Q3fqDMFd8EB0pkI5PnKnE/ziCPd3ygx/XvFI0I
 Z+412iKYomyx1mROnXyJXNNsINduomj7pvfRj0YIT0fj+YxfugbS6okFcmgvXAB43ZKS
 HkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728561748; x=1729166548;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y9Z/dtgZUEmfdtYGG5Lhq6BUh8icZiSHj4HDxYVajWY=;
 b=dDyXD5DBelTi5fpUHLg15hHuRcLV8bllrW6VMO64MH4ZHbQtZ5oSD1o1lipdOO6kdK
 /IuxVLgI6hEht0DI0Pt3+NSCL3TkreFN1B2OSExJDfVpQD+CeapsqOjMx4vq6G2dsjx0
 7vdH2sPTvPGPxgYFYXi0ui2iNIOY8P/XA2qlnOBIoDymbUy+OoUzEEP6cWWWpj51ZCQN
 V1CY/PnUiqF72nxL6AT1UdIy0xvLDOzS2W/8GSmEp11u9+H/lNbk7zDTDHHxuFxUz3qs
 kvMH0qO2tbVmDzsUu9RS+S/uWbgdBqKYBt0XmmwNwTzR6NCbVWJPvoCEXQzOJknRVatK
 hehg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXonIPpBMu48JQ2cGCrVLf6njPSBygb7JW7yRwpyThOZLi2SecL7E0cVTA/xd/WE0CD7zt6Q4c=@lists.denx.de
X-Gm-Message-State: AOJu0Yy0nWzSgfPChTUjP0vbTumKjgPjUxp48mqIr1MFZGoKrjhA8orn
 pLDW5806alr3gp2Tmar+MbAFkAZBHCDrY8qHfsp/ZpooFVsgp1XM8JgS2f/s2feZhmJa5Ve6eJN
 787K3zVpT0ugI8NtGcOq55/4l3VfoO02JcNAeAw==
X-Google-Smtp-Source: AGHT+IEZ8FqSoDGY/A5IRjtamdRjkfhvQ4rGZGIfpuoB9glgBg0agyrKPXxVA8PcV29REbj+eMyr3MXa9qzxqmEXsFw=
X-Received: by 2002:a17:90a:8d81:b0:2e2:a667:1a18 with SMTP id
 98e67ed59e1d1-2e2a6671befmr6699406a91.5.1728561748128; Thu, 10 Oct 2024
 05:02:28 -0700 (PDT)
MIME-Version: 1.0
References: <20241009015020.25817-1-sjg@chromium.org>
 <20241009015020.25817-7-sjg@chromium.org>
 <CAC_iWjKh7_OKKMi9K6eMaiYUN-Nxf+ZQ0NuW9BYzK3u4F0Krcg@mail.gmail.com>
 <CAFLszTjBQaoF9g0nky5mAA429gzA8QvzjxHxooDaRo1=BB+stg@mail.gmail.com>
 <20241009223907.GN14210@bill-the-cat>
In-Reply-To: <20241009223907.GN14210@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 10 Oct 2024 15:01:51 +0300
Message-ID: <CAC_iWjK8Bb16aLAKtmYB0Aof4CJP-AAdsMTEYvnFeMeXaiWM9w@mail.gmail.com>
Subject: Re: [PATCH 6/6] cmd: Add a command to show the memory map
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>,
 Emil Kronborg <emil.kronborg@protonmail.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
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

On Thu, 10 Oct 2024 at 01:39, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Oct 09, 2024 at 03:14:25PM -0600, Simon Glass wrote:
> > Hi Ilias,
> >
> > On Wed, 9 Oct 2024 at 04:41, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > We already have a mem info command, which is pretty useless. Can't we
> > > reuse that ?
> >
> > I am not too keen on using that as 'info' is pretty vague. We could
> > perhaps create a 'mem' command with 'info' as one subcommand and 'map'
> > as another?
>
> Are we talking about "meminfo" which literally only prints gd->ram_size?
> If so, I don't think it's worth worrying about enhancing that.

Yes, that's the one

Thanks
/Ilias
>
> --
> Tom
