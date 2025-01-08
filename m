Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A609E77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 17:03:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BFF480690;
	Wed,  8 Jan 2025 18:03:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DIP3xP28";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7399800DF; Wed,  8 Jan 2025 18:03:28 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5ADB8006D
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 18:03:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aa6c0d1833eso11079766b.1
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 09:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736355806; x=1736960606; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Nsl02wXhhx4B92gqztyWpg+Dld1M+zlXJu1C+NKGe+0=;
 b=DIP3xP28D2BnbVNKdiVRTaL+CTWr3+imalJCo7QnuIxUiRZuH5J7P6fitJ5TuDeU1l
 dHCakQAxRQT1dA4Wqpzlpck16y+GPGTVrSRQpb42GzYQGmxA5s5RlFI6f1OeR2LZJO/n
 mpbTBfljTONBUHNNFFIMYFZkmxzyPSQUWdyeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736355806; x=1736960606;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Nsl02wXhhx4B92gqztyWpg+Dld1M+zlXJu1C+NKGe+0=;
 b=hP3YW8jrOXetla8kMPSn+y/ezyBXO0sJQZfleAHTeqrFduwYgB5jatPpnl+hK6nG/E
 hV8nffoWJrE/5DWjjPo0XiZtLNrxWEnQH9j/aqfhjCPw9poyl0y5k90TkjDEWmDej+7n
 Vyy223512YY8KFa8NbRTodm6WcTJJPI1pvdctRttsbYm5Tq8uojFhjzyaVMaAEyvlfJ0
 FsNT1296V7OigKDgFktmYhhh5WaVna9GagDE+r1CXIWQlKMMCBt99zJgmPjFz9Ongvnk
 4zwUVXiM6cuGms6jjAZRQV0EWXoTfe/lDgbipR8nCGlt5rs0rNcDf3ojprsQ0D7FZn+M
 Lj+Q==
X-Gm-Message-State: AOJu0Yzrq4OyvBClZYcOCrq9ac76yMuLq+pUSg1bnU+0erWY+PsnJp12
 CNNu/OZTHSz5DaVMJhglUl8APi4VYXIBroqZnz9g1OqDE85XsxHppeL2zRTG2vvdrEmqc7WCLak
 4fbrmHqexzLjv9eMjoxiXXD6eCogkQbIbMHMG
X-Gm-Gg: ASbGncuP/v1GLdqTqZr1yXQoch4vsotLAMQyuVK9qM+wS8BnUSJoLS9gEcdDcYLuQD2
 jh5RkEPk5fOM6hYmz2Xubs76jZuPrhcNeXHT5fmU=
X-Google-Smtp-Source: AGHT+IHUWbSFSi4BkXwEdr4bLcrhNMiklmvCsE4i81y4TaOJQrclt3hNMFncWVGad4Onkr3cjCLlMr4lk8GrWvSSlgk=
X-Received: by 2002:a17:907:94cc:b0:aa6:7cae:dba7 with SMTP id
 a640c23a62f3a-ab2ab6a851amr314575866b.4.1736355806009; Wed, 08 Jan 2025
 09:03:26 -0800 (PST)
MIME-Version: 1.0
References: <20250106144755.3054780-1-sjg@chromium.org>
 <20250106144755.3054780-3-sjg@chromium.org>
 <CAC_iWjLrSEpHgTGK3WhHTGQ-SF5Zg6o_h14x++ot8FD+JAm3RA@mail.gmail.com>
 <CAFLszTjaeMimD_0HczGXxJUhjDjP+-TjT6RdfW5XOzBFhg+hkQ@mail.gmail.com>
 <CAC_iWjLp3Yrr35CJLvZKM9nLS0X8PtOn7nQs205MZ69kO5R2CQ@mail.gmail.com>
In-Reply-To: <CAC_iWjLp3Yrr35CJLvZKM9nLS0X8PtOn7nQs205MZ69kO5R2CQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 8 Jan 2025 10:03:14 -0700
X-Gm-Features: AbW1kvb9L8vrFSSqHyDv-kw0vIWiT4J-MXFSoaZ9DBqq4nd-lB56xpZ9ajffNkg
Message-ID: <CAFLszTgWXcPnpwfaBpx7daSZ=QWZ5XgDXEg+KF0HUeF=uMEUFg@mail.gmail.com>
Subject: Re: [PATCH 2/8] efi_loader: Fix display of addresses in log
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
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

Hi Ilias,

On Wed, 8 Jan 2025 at 00:12, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Tue, 7 Jan 2025 at 15:58, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Tue, 7 Jan 2025 at 06:37, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Mon, 6 Jan 2025 at 16:48, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > The allocate/free-pages functions return an address, so there is no need
> > > > to convert it. Fix this.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > Fixes: c824a96d76d ("efi_loader: Use the log with memory-related...")
> > >
> > > I can't find that commit in -master. Is there anything I am missing?
> >
> > Sort-of. You, Tom and Heinrich NAKed this series. See [1]
>
> Ok, please don't cc me on patches that are not destined for master or
> next. I have no interest in out-of-tree work

Everything is out-of-tree until it is applied.

Yes, I'll try to drop you from future patches.

Regards,
Simon
