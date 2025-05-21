Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EDD8C2D0CD
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 13:37:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7F3182E31;
	Wed, 21 May 2025 15:37:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="m6TNX7F1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C86B82E9A; Wed, 21 May 2025 15:37:29 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1513982E2D
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 15:37:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-70df2e31510so6628577b3.1
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 06:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747834646; x=1748439446; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hQAo1QaIyUazaqPED+Bxa3M6/BmKDxNwo+8dXee+JYg=;
 b=m6TNX7F17PIduy8YG3llu2qjL4btzy1W4+B5WTJ8UzLSbrqI0X5W8qBqMjmvONV7pR
 B/DPU7kYNehq8Iv6lZaOkanPtLFpyEmItZn+sRkQl0nVDp34FqUTbJ5XerIyH1jNvnjS
 +VTJTCRSfi3Dmfq+eL/aLlPD6zLQFNKAl59vzQ+VwPGU+ISBRfUG6P8new7ZbRz3laN3
 I2EhKaRlBiwLvc+fgp6GGj/PARAO3Q5jDWuj8FCy0FRi7cuK2IT7Z9To2ZHbveqL27NG
 ADxz3WdEi/3F3T2Z9qZOZsXotvo25ZJEFNwYqGJE/yV9wSvpRs0usp1dpfn7uUZ2M/2X
 V1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747834646; x=1748439446;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hQAo1QaIyUazaqPED+Bxa3M6/BmKDxNwo+8dXee+JYg=;
 b=Zwaxa/tck2ugA7II6L/F8phDmzQioDsS4fkUEhD1/98jQvI/dZkwEioFcHBDJjcUQ+
 vyvwRPKa9DxldacTVgt/znDo/d0xFHx4eMsY/YSP0z+6fEBU+zn8uLZ8ZprUw4sLOfij
 xNec9QfFSzmsALaYmYe6GOq+2vtVwT5bTBeA1uKrRfkz1WPj8A2PvLHzBiUeuKMABmbl
 RpauVVe2eFmHpnQ7nG/Z7KhZ6lO9zMDrSriQ7z1bmuhkw5O3JD8dL9XInxEPDFy7isLq
 Jv4VQtpcrdnRfNCmUeNSsxsCk/Sdq0oahx7EE3ov20xKI9FzcDDWPVqCXTHxn0vYNYHY
 c1dA==
X-Gm-Message-State: AOJu0Yz4lCxDSaH+Z4JMtiS+vQ5lapNDpToi3YZFbKwaPwHwQFsYcLXB
 Lzhp1N6Uy+W2MU2niidVnQvFU/KhaxOzeB02EyrDCcVj2jWODLOMR+L7TgbjUKpC6zI5T9HfUxT
 4ELksNtrbNzGW43DQUzIlLbm2LFJqWvV/ENlli4lQOg==
X-Gm-Gg: ASbGncu6RpuWUyApqJShMc+MYvGEplpwbHOcX1316t/4Ju/ei7siTws1q2CXdUpIceP
 /9CGqif5BJ1LuIkMbSCtxSMlKpPcIg7uwHjVh2MJ9N164oQ2zolE7f8MkiZPflnXmkdcG4udG6N
 fdDzauLokoJMLI8fgy/HVe4AT9GNqLze1V+mxq/97NTuT+
X-Google-Smtp-Source: AGHT+IH2jU2xtOJGOP9wNGF2OKMhPnoWCkYifymYUeNy6OJfuIY+hNn5BrdBRX6xouUb4w/L8i8yJpNvD82KoCP68sA=
X-Received: by 2002:a05:690c:9a82:b0:70d:f09a:bb4d with SMTP id
 00721157ae682-70df09ad963mr44822857b3.0.1747834645873; Wed, 21 May 2025
 06:37:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAC_iWjJirOoP49HAzMSmnK0B5fZji9+-GAg7Vku3DWOZ6DQOhw@mail.gmail.com>
 <87o6vm3zg9.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <87o6vm3zg9.fsf@bloch.sibelius.xs4all.nl>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 21 May 2025 16:36:50 +0300
X-Gm-Features: AX0GCFvQY6awu0NAMo_PMHGBu_l8bG-SgopH7b9GBGsWz_pGD-Ke1C5sk15Hq5E
Message-ID: <CAC_iWjKv2Ga0JqPHsNxRqARmcpthuBkNFzDhJyGXfGPgPAyZ-Q@mail.gmail.com>
Subject: Re: QEMU & KVM broken for arm64
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 xypron.glpk@gmx.de, andre.przywara@arm.com, kettenis@openbsd.org
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

Hi Mark,

On Wed, 21 May 2025 at 15:44, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>
> > From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Date: Wed, 21 May 2025 12:07:40 +0300
> >
> > Hi all,
> >
> > Starting from commit 53d5a221632e  ("emulation: Use bloblist to hold
> > tables") I can't boot U-Boot with QEMU (version 8.2.2) & KVM anymore.
> > The command line to reproduce it is:
> > qemu-system-aarch64 -smp 2 -nographic -cpu host -m 4096 -accel kvm
> > -bios u-boot.bin -machine virt,secure=off
> >
> > commit 24768a23a9b3 ("emulation: fdt: Relax condition for
> > OF_HAS_PRIOR_STAGE") boots fine.
> >
> > Simon do you have an arm64 host to reproduce this?
>
> Does the same thing happen without "-accel kvm"?

No that still works fine (but you have to change the cpu from host to
something else). E.g
qemu-system-aarch64 -smp 2 -nographic -cpu max -m 1024  -bios
u-boot.bin -machine virt,secure=off works fine

Thanks
/Ilias
