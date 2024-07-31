Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042EBC3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 17:42:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80E9D8897F;
	Wed, 31 Jul 2024 19:42:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UiP/dppW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D32678894E; Wed, 31 Jul 2024 19:42:49 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2BFE8894E
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 19:42:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fedorross@gmail.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a7a9a369055so666092366b.3
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 10:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722447767; x=1723052567; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tziS2iu08W90eoNUPJ4GL7R/PTfQTUpmRZ+jQszIEIM=;
 b=UiP/dppW2CzBvOWXjzbiGt9OjK7bJ9Ib9v5KyWqWQRlfChBlrNj8wBjB+K+ltsX58t
 YmhbEw30JWela72tqc4z2jz7IoBagdzMwYB0K7udJioNBc4j2Zow+dZDXEoRLPSEfkL5
 x+NvoNDGARYImkEc7P/yfTT/v8FxS+hudbldv07khsduR04QvjdbNfk5bPJ7WiJ6vyEk
 s3+LfMhA2U+8JuLHoKZXe+866rrVraM3t0bvuBksiVXr9HLBHWx/gz0uwmoYcSyoZJb0
 6ZYnNth4ngLv/GUewNNp+vuZ+CrJcyN9aUB1duRkGpPnHUHj1bitChnc8HHT6ISLJNKj
 1xTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722447767; x=1723052567;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tziS2iu08W90eoNUPJ4GL7R/PTfQTUpmRZ+jQszIEIM=;
 b=ggB/Bvl5ed60GuovbYj567GuQ9upa13qPJpHg/Z61C54Q81OqWbkYAZ8+8SKjIJMTK
 cW30vsb82eUmDLr8So4uozHhovBx2mxSk18qyLUarflN6f5vYAbwmOwWjadSCkSmzY0b
 /JHQZOE69CmVoE8X1LDJHJOpcTPFVZQwPiGTtxG6r3lDHfrswIV+lt53zUVhR+LfMONJ
 4mUNZKiV244XIVy/imEDcT3RXF1m0ohx7FkdTqVKkdv4iygoV6JmHltQlgeOd8ggkRTX
 /TmyaxrfTO/Nfdr73munHzSqETuWrtJ8Zv4FGzDEevliyNHmSBJHEj78Z5/Ppx+K/ZBh
 bUKw==
X-Gm-Message-State: AOJu0Yzyborkx/LvvV9cY1rA2jdjZccoLa4ZWkkkqn8bzaSgzNEuMBJi
 pR2v7hLcVhnSnPz8EWgjCuaB5DkBPGYFTeyByUojkVhSJsTA27IZefmuDI3awhsPQm/ErXu0nt5
 M4Fn2zAHtQFdA2EPsI6cp3cDw0G8Gud3m
X-Google-Smtp-Source: AGHT+IGk//CFqTdmuUugWXRpKoHIlqCPMYXMhc3smOodtWgkSKYkkpxngZ2sJJDlIh5i+F6OwUfVlmBEY+J9aUE6pSw=
X-Received: by 2002:a17:907:7d86:b0:a72:5f9a:159a with SMTP id
 a640c23a62f3a-a7d3ff583a6mr1196553866b.2.1722447767048; Wed, 31 Jul 2024
 10:42:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240730152529.143651-1-fedor.ross@ifm.com>
 <381c3a16-cae8-5543-1e5e-4551197f709a@denx.de>
In-Reply-To: <381c3a16-cae8-5543-1e5e-4551197f709a@denx.de>
From: Fedor Ross <fedorross@gmail.com>
Date: Wed, 31 Jul 2024 19:42:36 +0200
Message-ID: <CAEGWRBCXUUHSbZ3OSKcqNzQyEB0qQq9mF7v4isGHwFC1-t67Vg@mail.gmail.com>
Subject: Re: [PATCHv2 1/3] i2c: imx_lpi2c: Fix a typo in bus_i2c_receive
To: hs@denx.de
Cc: u-boot@lists.denx.de, Fedor Ross <fedor.ross@ifm.com>,
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
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

On Wed, Jul 31, 2024 at 5:41=E2=80=AFAM Heiko Schocher <hs@denx.de> wrote:
>
> Hello Fedor,

Hello Heiko,

> On 30.07.24 17:25, fedorross@gmail.com wrote:
> > From: Fedor Ross <fedor.ross@ifm.com>
> >
> > Fix a typo in a debug message. It should be 'for' not 'fot' .
> >
> > Signed-off-by: Fedor Ross <fedor.ross@ifm.com>
> > ---
> > Cc: Heiko Schocher <hs@denx.de>
> > Cc: Tom Rini <trini@konsulko.com>
> > Cc: Marek Vasut <marex@denx.de>
> > ---
> >
> > Changes in v2:
> > - Add additional '---' below SoB line to separate Cc list. This way it
> >    does not get included in the commit message when the patch is applie=
d.
>
> You may also take a look at patman tool in u-boot:/tools/patman

I'll take a look at that. Thanks!

> Reviewed-by: Heiko Schocher <hs@denx.de>

[...]

Best regards,
Fedor
