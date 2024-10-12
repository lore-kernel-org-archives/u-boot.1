Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF03D1A428
	for <u-boot@archiver.kernel.org>; Sat, 12 Oct 2024 05:47:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A24E88D63;
	Sat, 12 Oct 2024 07:47:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d3D1PUzu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50C1288D66; Sat, 12 Oct 2024 07:47:18 +0200 (CEST)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EEC188C9C
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 07:47:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7ea56070f86so810823a12.0
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 22:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728712034; x=1729316834; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mtF2mv3LfYkpUkRcsJyC50L8mNnF4Wglza1yEU5BkLg=;
 b=d3D1PUzu8qNCggUry1ddpUm4IGJZSQ6ZSXOXNaVAcejQeDpxHoMEl5jwVYj2JMFsz0
 k6hqdcZs1kpov6SCeOKrQ7i1GIiOroXZD84Llz2UoFzlEetI/E+CQ4JDFb+IzFKC2LH5
 kKLNwZ4mVx9wguIE96Jyw9Qm7ADmL+pAA7OAdEdY80/mf8NtFQcc1QmavI5751nmVPTh
 wc5WjtD6VPd9FLiu+VVTXBvb7yGC9ajCP5GMpIF2nNnO2OzmyXbPiY9j+5F8sBavH7c5
 5R5Eg3g0WqFbjfwlvPEdxG4AW3hPRpLtSn2Eqt5+QYQZ13cY0nuZ8MGsatdvzH/PxpcR
 f55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728712034; x=1729316834;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mtF2mv3LfYkpUkRcsJyC50L8mNnF4Wglza1yEU5BkLg=;
 b=bQ2ZWogOIObH20LzabcwwzqkozbCbVPK2bCSJ/KMWhZM9GbCvqebt/F9I+m41MoH5k
 CoVOgZQwwaYZWKQRD8AeYVHwil/CLXEZZxfmH5vLY5tRPAA3OWQk79rFl097zuRk49Sv
 4QDap7b+9xq18ExfivqKjhuBJoMId1ibHcVYX/DNQg8v+jj2AJV6UMsL21H1ulDGql2+
 fB5769+glGpxD8MbjX3KCYuFiHgqFUIHAMAG5UUCVBxSiaVRMetw1NeXOL6fHoc59jel
 xMAvAFqrOR0SmeaBL8ckoYctVJ/qCC6IveYSdvu9edZ9TMrXFavT3Wzzyztf9ckwpOE6
 u28g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5pTwkzPxIBOZpq+lGq/RaJTtHN0wd/WbSsDNI6tIuutDYmYRj7z2KwUDn3cfQpPJLYbgVzR0=@lists.denx.de
X-Gm-Message-State: AOJu0Yxc00EHp4CyCZPwoV/thIXyLM2K2kqeq5jCbVC1v2KbPYTIjqvZ
 kQufIhMmeAE1kOKELMFsNdAWBC4ecAzdHMw7qOaelCa8zD9R9m9NzpjLTv09hcE11DP2TCY8d7M
 wAJLFbbGAhndgZ9BaF74afdi3cu3Y5G/yQMG7Zg==
X-Google-Smtp-Source: AGHT+IEdTw06rGsUQ4nGIcHtfNekzXEBcFLPBZgyBL9o1DbkbqmYYeY0Fjsg78+Q4NofB8Wn8I5siJ+GDHlULQh19v0=
X-Received: by 2002:a17:90a:ee8e:b0:2d8:85fc:464c with SMTP id
 98e67ed59e1d1-2e2c8059fe0mr14335266a91.11.1728712034502; Fri, 11 Oct 2024
 22:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <20241011212126.747741-1-sjg@chromium.org>
 <20241011212126.747741-5-sjg@chromium.org>
 <71ECC011-77EC-4308-AFE5-0E301BC27F84@gmx.de>
 <20241012012716.GE14210@bill-the-cat>
In-Reply-To: <20241012012716.GE14210@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 12 Oct 2024 08:46:38 +0300
Message-ID: <CAC_iWjL_YQ24ZecbN7oC-37PRR6iuUiiui-a0VPqSSVRunepdQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] efi: Reserve some memory for initial use
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>
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

Hi Tom

On Sat, 12 Oct 2024 at 04:27, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Oct 12, 2024 at 12:01:54AM +0200, Heinrich Schuchardt wrote:
> >
> >
> > Am 11. Oktober 2024 23:21:25 MESZ schrieb Simon Glass <sjg@chromium.org>:
> > >The 'point of cooperation' is where U-Boot starts allowing EFI to use
> > >memory outside of the U-Boot region. Until that point, it is desirable
> > >to keep more below U-Boot free for loading images.
> > >
> > >Reserve a small region for this purpose.
> >
> > Your commit message provides no clue why this should be needed.
>
> The alternative here would be a patch to doc/develop/memory.rst saying
> something to the effect of:
>
> EFI pool allocations start at ... U-Boot stack pointer +
> CONFIG_STACK_SIZE and grow downwards from there. These are done by ... a
> brief description of how the pool allocations work ... Nominally, this
> will extend for only a few pages worth of memory but depending on
> requests made by EFI applications can grow larger. All of this is
> covered by the LMB that covers U-Boot itself and is considered part of
> the U-Boot memory map. It may be broken down in to further detail to the
> memory map provided to the OS, in some cases.

I'll send a patch to update that next week. Perhaps even fold it in
the LMB series

Thanks
/Ilias
>
> --
> Tom
