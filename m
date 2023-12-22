Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0418C41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 15:43:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0A8A8771E;
	Fri, 22 Dec 2023 16:43:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CqllLEbK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADE4387740; Fri, 22 Dec 2023 16:43:43 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3B19874D5
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 16:43:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2cb21afa6c1so26794831fa.0
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 07:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703259821; x=1703864621; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lx9Hw6uOgUmJIMghh0EJEl1OoWYEmyZvgcBt0TN8DOY=;
 b=CqllLEbKdx6R7Hm/GPbNovHCEY31AiTcZunyGnP4+uRzR4caZaXmorR22fUnvcCUdB
 MgdjUJiqcGsHiRHGUSMPElgt2JWCms4BsAM2PG5LNYbh1eS+beE1v5mOk0DPXBY9hPv+
 xdeBu28kTUGKKbou2GVyxE9b3/FJUMuQjSgcZVAU3BdjUSIaLTljFwCnVSzg16yYit+6
 MDssa9ZQ+8GjDoPxbWNZL2NSg7+WUjIHnuehmB4Rct0ntaWz050ygbc9fNUMrcIcxjaZ
 4xI7xVs17r05vT09KvfCVCwip8KAX6LzBdwpyiWHYbQtX52WZw99ZM7i42erHnQGEdtq
 Jerg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703259821; x=1703864621;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lx9Hw6uOgUmJIMghh0EJEl1OoWYEmyZvgcBt0TN8DOY=;
 b=EZEJ8MKPrXYa/7qYYEtIgk5z2L/w6p8kJCTPuxgKu3I4Esrfq6oSRJVCkbsrFf8T2S
 jMyV+qWKae5eiPyEFq3nmC6HX18FmNepDhdA1olnJiZqWlHR2kTfGdnXH6uZPT44criq
 pdFknmo462/imChhAgLEt2J4cj/y6DsQ4GcIupG3BQxo9vfGSSWr4GPt9t6tfrgUFLDj
 pWnCGlR05b8woXW8BPTuCqH0+38EumgiAmS5TUCKUEU49QEXi4B+FNDWywgC5+7tj2+1
 2XI+6/fVCnVksh99UJaNI4S3HDgMT4Dabr3uZSGxo2IcEttlPNlp5nNaN9SnjhT7eSg5
 j0Mw==
X-Gm-Message-State: AOJu0YxAgYeVVmcOR88wgg4tNGYWpfjmBEURikY9+evzdT3A9j1Xahyr
 Mz38MVP+VHY3as4bcrR04Q7cEjz0pTSksVZeDdE=
X-Google-Smtp-Source: AGHT+IHTm1wlTUzMsnW1XwqryHDEO+7+CRCL9QcNiNVXaAHeha9WZkeSQZoaYuVYySrKwWu9VOssF3beSlelyXCMN0M=
X-Received: by 2002:a2e:a4d1:0:b0:2cc:5a76:212f with SMTP id
 p17-20020a2ea4d1000000b002cc5a76212fmr837403ljm.99.1703259820774; Fri, 22 Dec
 2023 07:43:40 -0800 (PST)
MIME-Version: 1.0
References: <20231222150156.39783-1-xypron.glpk@gmx.de>
 <170325942760.2653128.4640507980296072811.b4-ty@konsulko.com>
In-Reply-To: <170325942760.2653128.4640507980296072811.b4-ty@konsulko.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 22 Dec 2023 15:43:29 +0000
Message-ID: <CALeDE9PwPsxKQx5j_embNv_4NwXSt68Mo7apBPwDOWdApPA=mw@mail.gmail.com>
Subject: Re: [PATCH 1/1] bootmeth: pass size to efi_binary_run()
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, u-boot@lists.denx.de
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

On Fri, Dec 22, 2023 at 3:37=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Fri, 22 Dec 2023 16:01:56 +0100, Heinrich Schuchardt wrote:
>
> > If we call efi_binary_run() with size parameter set to zero, we get an =
error
> >
> >      Not a PE-COFF file
> >
> > Fill the missing value.
> >
> >
> > [...]
>
> Applied to u-boot/next, thanks!

Is this a fix that should land for 2024.01?
