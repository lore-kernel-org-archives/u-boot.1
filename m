Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B62E6FE41
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 15:04:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B4FF864CB;
	Fri, 22 Sep 2023 17:04:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hHIwB8Wi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DF6B8468A; Fri, 22 Sep 2023 17:04:34 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 765F38468A
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 17:04:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-50336768615so3903890e87.0
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 08:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695395072; x=1695999872; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VdOgKd1kneCItJrNsbAAwGvZh/cXyby60hM94wFb29I=;
 b=hHIwB8Wi+Of96DK2MNTNRTlr6qabHkSO2D6XQfztteYdkjIRVeKOF+BPSXWQyraVZx
 I37SzXtbiZgao+7FSW0ceDlPhQ8ob+k5lc5QzFrG2yjfG3+5RmtDcG/q9URX9XIN0vBb
 C3FEqQrTeOWAN/QVu/0SUzmJjAyLpG0UvPu2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695395072; x=1695999872;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VdOgKd1kneCItJrNsbAAwGvZh/cXyby60hM94wFb29I=;
 b=fbcRX4QzsZlU7jbeRE5PBoMy/OT/mx2QXbTtnkafOI/cEBKccJc6zHYowpuCGQTXR6
 eRokjwlb/5mqdUPCILdC7mveAqQATKgSwGb9d7NBvljujM9SAWhdYhyA7t98c2xctKmb
 G3buicrBU64wAnX2QjZcmdwIgJ2+xHzqCw/rViUzVo7V+JlKE8+t+fr3RQ4A2sLOGMUb
 tU728niL9zhjUWxNMwlHBnezgayxA8wyF6fXywwZrXU9ghvVlfz4Xss1baPmrWlpU7Eo
 eIffwXBKJCqbCxIOSDeO0m/C9uIPcLHul/zx5kxZernZHI3T+mtfbucPhQP2cGrlu3WK
 cmIA==
X-Gm-Message-State: AOJu0YwgjO3MZJ/s9BValaGlsEp0Fgd1as9gBS/hkQwOqAFnyJ95fCvN
 AxSrS1FfZ/kOq6AvL5y3/iTSdwNzWOUyDl8h6BELDA==
X-Google-Smtp-Source: AGHT+IFj7reSj2XwNiGyvdA/X41C2JDAZvTP4UojzuWgL0xRk18sLOmV9iNFuK+ec4KU9LVIKFEf1vlAHB3E+4/SmTc=
X-Received: by 2002:a05:6512:3e15:b0:503:17fd:76bb with SMTP id
 i21-20020a0565123e1500b0050317fd76bbmr9939427lfv.39.1695395071445; Fri, 22
 Sep 2023 08:04:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNASYfwjuCQ70BZ5Gco+rme=H_fArxyT5rFsE334p2viSoA@mail.gmail.com>
 <3cd1e2b4-47b9-a3b3-d8c3-9f6c0481f479@ti.com>
 <CAK7LNAQg-x9L9s3j2d6DYdoW7WuHKfhMq5n=4GfrMLvjO9vQmg@mail.gmail.com>
In-Reply-To: <CAK7LNAQg-x9L9s3j2d6DYdoW7WuHKfhMq5n=4GfrMLvjO9vQmg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 22 Sep 2023 09:04:20 -0600
Message-ID: <CAPnjgZ0GuhfqFVd3eHutTNXiykMi2TysUFYuMk6cYb+4RB4nxw@mail.gmail.com>
Subject: Re: [Question] TI's u-boot.img is built twice
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Neha Malcom Francis <n-francis@ti.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>,
 srk@ti.com, s-vadapalli@ti.com, m-chawdhry@ti.com
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

Hi Masahiro,

On Fri, 22 Sept 2023 at 01:19, Masahiro Yamada <masahiroy@kernel.org> wrote=
:
>
> On Fri, Sep 22, 2023 at 2:27=E2=80=AFPM Neha Malcom Francis <n-francis@ti=
.com> wrote:
> >
> > Hi Masahiro
> >
> > On 21/09/23 21:06, Masahiro Yamada wrote:
> > > Hi.
> > >
> > > Since the TI platform migrated to binman,
> > > u-boot.img is built twice.
> > >
> > > It is created by "mkimage -E",
> > > then overwritten by binman.
> > >
> > >
> > > So, the data are embedded in the FIT structure
> > > instead of being appended.
> > >
> > > Is this intentional?
> > >
> > > To me, it looks weird.
> > >
> > >
> >
> > I haven't added the fit,external-offset property in the binman.dtsi so =
it was
> > not appended as external data and I did not find reason to. Is there an=
y benefit
> > in having the data appended than embedded?
>
>
>
> Placing payload data outside the FIT structure is a U-Boot hack.

No, it isn't a hack. It is part of the specification[1].

[..]

Regards,
Simon

[1] https://github.com/open-source-firmware/flat-image-tree/releases/tag/v0=
.8
