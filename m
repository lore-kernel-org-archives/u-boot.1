Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C251C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 14:07:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A96AB876A9;
	Mon, 27 Nov 2023 15:07:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L5Y5PpHe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 161BB8772C; Mon, 27 Nov 2023 15:07:10 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 212348769A
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 15:07:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-543c3756521so5817590a12.2
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 06:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701094027; x=1701698827; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5x9jK0YHBbG4AEDZa2HX1xcrlCuxW4L6KG1A+G/QrwY=;
 b=L5Y5PpHe1eq00QOnypMAlvJlYfVWsk7sxKz04/LssCQbitRo7oSCqV/IB+5tdRCqLM
 UkTauHnYF0QEZN8lZgrtkDW7wp7HoLqhVEcfTMeAzLLxoKgdZZ8jLQSo+K3/43nGfUqq
 7ISqZCWKR71rtslIIXM+6KFUSapho535yWaqldpnOHsGVguQZFtQZBD5qWzXhEOK9wHY
 gwRU1TTWwdtXsqpAhypjKb4MldO6eBngfKfhi+qfIKUJuJQeUJye8H9P6TjjbNAP/Xpw
 bg24uUaVgMth5viHmS/d+BSVKy4yv1YCxg9Awnwvm8u0hbihHo/RW55q/04JNFUMV7SF
 dIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701094027; x=1701698827;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5x9jK0YHBbG4AEDZa2HX1xcrlCuxW4L6KG1A+G/QrwY=;
 b=Gvf41mvAQe4IUXMMR7Mzi59Tb/+6EHrHmQASBc4PjiEAgoDWJDpoMXbc+NM5/s7TOz
 NORs/7clwluV/rWWo8GtLWcmXKlmG3sQuYwQQ/AGB9dWYj9WYJaxEQR613WOfYQbPDLd
 6sfJsx7BLIctatg7+bU7hrHIMzX9wMj2wjmm4KFDHBXa/oPoIszN4WaHWbVleQKh66tK
 BLQOcRjllJSfgBJkfZcIgx10v57f8MCqefBM38vUAxYmk41Pl4rHuqW/4ROn4juqRMVs
 sPFm9v3cIEuGPkOQhR9fi1aHET5RQioVcTBLvULFyOm6vECbTAiVhi2rEUrolm0dVQV2
 Nl/A==
X-Gm-Message-State: AOJu0YwwMaDSYreFUM/WotXI9KNqIC8sgT0Ivu8g/tmY1BiAsl0A3cpd
 MXw9u0pc/YnmV5lKEHLlzsanpYMTXKlXzD3/C4E=
X-Google-Smtp-Source: AGHT+IHGIQdTvu6y78+D9qA1SEUZoEEzUqrv4yzHoAwY5pLn0b6Dc28NwZ9a3FyGYs7nK/WIhwxibgesbXgb1nvyKpI=
X-Received: by 2002:a05:6402:2047:b0:54a:f3df:5814 with SMTP id
 bc7-20020a056402204700b0054af3df5814mr7606640edb.25.1701094027486; Mon, 27
 Nov 2023 06:07:07 -0800 (PST)
MIME-Version: 1.0
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231127125726.3735-34-maxim.uvarov@linaro.org>
 <20231127130828.GC2513409@bill-the-cat>
In-Reply-To: <20231127130828.GC2513409@bill-the-cat>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 27 Nov 2023 14:06:55 +0000
Message-ID: <CALeDE9OOQjn42otz_JYRrpgjPuJZkTj93qtpHg-d_j8Wap4+Ww@mail.gmail.com>
Subject: Re: [PATHv11 33/43] configs/am335x_evm_defconfig: inc SPL size
To: Tom Rini <trini@konsulko.com>
Cc: Maxim Uvarov <maxim.uvarov@linaro.org>, u-boot@lists.denx.de, 
 ilias.apalodimas@linaro.org, goldsimon@gmx.de
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

On Mon, Nov 27, 2023 at 1:08=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Mon, Nov 27, 2023 at 06:57:16PM +0600, Maxim Uvarov wrote:
>
> > Increase allowed binary size to fit lwip code.
> >
> > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> > ---
> >  configs/am335x_evm_defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/configs/am335x_evm_defconfig b/configs/am335x_evm_defconfi=
g
> > index f048e60f7f..9fd608bd76 100644
> > --- a/configs/am335x_evm_defconfig
> > +++ b/configs/am335x_evm_defconfig
> > @@ -124,3 +124,4 @@ CONFIG_WDT=3Dy
> >  CONFIG_DYNAMIC_CRC_TABLE=3Dy
> >  CONFIG_RSA=3Dy
> >  CONFIG_LZO=3Dy
> > +CONFIG_SPL_MAX_SIZE=3D0x29000
>
> As probably a problem for other platforms you made this change on too,
> you can't do this. The link limit is here because that's the limit the
> hardware (and ROM) imposes.
>
> You might need to either:
> - Figure out how to make lwip even tinier for the SPL case
> - Limit the old network stack to just for SPL, and a later task is to
>   reduce what's in the old stack to just what's also needed within SPL.

Maybe also verify if network is actually needed/used in SPL for those devic=
es.
