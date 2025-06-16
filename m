Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25741C71155
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 12:32:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 593DD81760;
	Mon, 16 Jun 2025 14:32:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="RU1UJfDJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA9A380C93; Mon, 16 Jun 2025 10:45:46 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91A178007D
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 10:45:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-32b43846e8cso20202141fa.0
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 01:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1750063544; x=1750668344;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uzmYQNRw88V4I2vZvOkaLFWNFIOkrAVCYPrwYpcBEbY=;
 b=RU1UJfDJ3bVZnWjzo5DH7u9VOKfZO1luHSkWsd7E1PEhq8B0S0QS2zYxSu7A8JNhKU
 IRXu9PTx51K1Z/yoJbssyAIoaiZ1YYIRwWUlejP6O1k1eGTNALlbEwNzoVi2GmVY/Pg0
 vEoa9aejqNQlpbuTgX3DdOId+VMRMsuPZ6jT4yVJOjd9jSdr4rEacOLLT3qUJTfXg1dw
 bvHOtc1KQEWJcuTynZH/TIOHOLyUwnrp/gPYjy+MYb57jGf5HUlY6PzxoophvUKkGWES
 32gEpKpBXQqY8p0kT4oIVzwXerLKwfuXKaipLx2c1vmzmWBsMI7YEBsEc0pdKB9RBeGB
 IMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750063544; x=1750668344;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uzmYQNRw88V4I2vZvOkaLFWNFIOkrAVCYPrwYpcBEbY=;
 b=v8VIjqbBBItPCAKmacMyZ2wX43b5dqv94BvEx7LVLA+j6zFZM4ReBwb/0bpLGURxnZ
 4eX5Z/83avJPnMu5/W3Bd05TsE+ZMo2kEDG7Gpqm6JK2gX642xwXTJ07evTv7VwrBspo
 lND48T1LqT12XyVoiH5GI03r77gpxi6+rfYJscoKje99FZGwrPURChxg5piRyBtHyG8f
 bXYgdqN5SkE4r0HZox4yP+h/KLskbKh7CFozReXGQd/aXMnDB2EKcUAQRBwguLu/r5da
 W0nDTU2OF4Bf1CvEPzXoPHwpitndCjAzPMl3zZpRyKizIxKItvoIkB23KDndqW30GVas
 vvlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXaRC2qUtmmPn3OlfCDbwD3yc0YeowFTQU2x02LKDNxWZoNEuXbyjPvR5UE5E/DHDhdMUKdvI=@lists.denx.de
X-Gm-Message-State: AOJu0YwrCOcRijddib3syQ5oDX67whElYQaNRWsq1suYlrs7qhiB4/3/
 ywLrC2VWr32hNlZPSuHkqRSpUHYmM+6hmiEmCAxG7TdjQ5MQ7cAH4H6jYJl7ZeOpN0LTRjSjhEw
 KnsthnssV2saFxSAKsgZSCmTNMjWEWo7PFb/iNiUybQ==
X-Gm-Gg: ASbGnct0O9hJKGbPnwkg/8PzSNQP7h3VcOn2cYs828qqHgWoQyHI7kzhPIHFza4iTNJ
 GWpSk+xIIubZoOy51FFYvl0o5jC+VzOhU3lepFa28bFubhNE2uOqmFjYrKxKnolQ6F7Pte2To7k
 pkaGGGPXtJGCcUp/AWMgXz/UXMO77R6N4Cca+zDy0+dWfELATT9P5O9A==
X-Google-Smtp-Source: AGHT+IGTpZTlqDn1wKsHoq4IonpHPKN8ZdXbZPrt6RS3QLXs44V+/OM5E/mJp/YVbJXQ9/Xy2hlvJ3+F+0/nqYEPmb0=
X-Received: by 2002:a2e:a585:0:b0:32a:c14b:7db9 with SMTP id
 38308e7fff4ca-32b4a2c470dmr18141621fa.7.1750063543569; Mon, 16 Jun 2025
 01:45:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250602-pullup-v1-1-edcde5a050dd@hifiphile.com>
 <87iklbuddu.fsf@kernel.org> <dd3a3cad-75df-43b7-862f-a51cacda3de6@linaro.org>
 <CA+GyqeaPEiwu7b3E-Gm+QMntGgcAVufAhy3jXZ4DzL9O9GANLw@mail.gmail.com>
 <87tt4k3sit.fsf@kernel.org>
 <CA+GyqeYhMBW2Hpa0cr=ruA+LJiOm4ycL0mzcKfkaF8w68JVdJw@mail.gmail.com>
 <878qlsgncu.fsf@kernel.org> <875xgwgn77.fsf@kernel.org>
In-Reply-To: <875xgwgn77.fsf@kernel.org>
From: Zixun LI <admin@hifiphile.com>
Date: Mon, 16 Jun 2025 10:45:37 +0200
X-Gm-Features: AX0GCFtzYxSsA3mb_gRkNgg4LXUuoSbB1ig6fn_EJsqsXHWpc2JECbqxEOWRKU4
Message-ID: <CA+Gyqeb8GZmWdnHK590UEox3SH1+z3dYx+MEAEpBUgW3zbMkCg@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: atmel: reliably generate disconnect by
 disabling controller instead of toggling PULLD_DIS
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Eugen Hristev <eugen.hristev@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>, Mihai Sain <mihai.sain@microchip.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 16 Jun 2025 14:31:59 +0200
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

On Mon, Jun 16, 2025 at 9:28=E2=80=AFAM Mattijs Korpershoek
<mkorpershoek@kernel.org> wrote:
>
> On Mon, Jun 16, 2025 at 09:24, Mattijs Korpershoek <mkorpershoek@kernel.o=
rg> wrote:
>
> > On Fri, Jun 13, 2025 at 16:45, Zixun LI <admin@hifiphile.com> wrote:
> >
> >> On Fri, Jun 13, 2025 at 11:22=E2=80=AFAM Mattijs Korpershoek
> >>
> >> Hi Mattijs,
> >>
> >> The case was reported in early May and MCHP have also observed the
> >> missing of detach event on host.
> >>
> >> My latest measure shows a differential signal level about +-350mV
> >> between DP&DM lines when
> >> DETACH and PULLD_DIS bits are 1, much lower than the detachment
> >> threshold of 625mV from
> >> USB 2.0 specification Table 7.3.
> >>
> >> From my view the patch can be picked, even on an unaffected family it
> >> won't have side effects.
> >> Unless one day we decide to implement SAM9RL and SAM9G45 errata then
> >> it needs to be retested.
> >
> > Ok, I will apply it. Since it's a bit late in the release cycle, I'll
> > send this out for -next.
>
> Zixun, before applying the patch, I'd like to add the comment I
> suggested in the code [1] as well.
>
> Do you you have any objections on that?
> PLease let me know
>
> [1] https://lore.kernel.org/all/87iklbuddu.fsf@kernel.org/
>
> >
> > Thanks again for your contribution!
> >
> > Mattijs
> >
> >>
> >> Best Regards,
> >> Zixun

Hi Mattijs,

I agree to add the comment to make it more clear.

Best regards,
Zixun
