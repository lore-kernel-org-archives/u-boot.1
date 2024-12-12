Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A08E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 19:50:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79D24801CF;
	Thu, 12 Dec 2024 20:50:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Frowtx6i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07062801DA; Thu, 12 Dec 2024 20:50:28 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 977DB801BE
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 20:50:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5d27243ba8bso1822153a12.2
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 11:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734033025; x=1734637825; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nLSniyT6iaXq9O/1X9du+ZjjOx3ySkHH1zyiYcIg0Ig=;
 b=Frowtx6iRnJ1z7nOVzlR/M7J07jGh3Wd+9rMKP793aAkw9qjTi1lrC9JvgtsFDpOAf
 tqL3SGKXIL2vkOsBzWKxpSBWy7jZfj+W588DEni1SWYrfSWPHZWuibO+PgNDi1cF4C28
 Bz0cx6fRKD2S2tdyRwmKaB+cYKOqQWgLy3KLthlhw61dh9AZqVb5toi/ysG+Kf3ce6Jz
 aEjpQCB4OnIrv1lCvKraxFKE/G8AwexPABAe8XXCr3Z5CCnK2qGq9CsD2yQxff2nygSg
 w33LjJOz8htwXdPIESqnTmRVe34+lD4a34Jwpj0ljNnO2KC78bF4ZOfel1X9dd8Bd78X
 wR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734033025; x=1734637825;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nLSniyT6iaXq9O/1X9du+ZjjOx3ySkHH1zyiYcIg0Ig=;
 b=TyXhw/SvS9JVyUo3GLEyXfkBJsDndtMnBR+7k9XQyp83uzOW0i9gVt0QLq9O5JMZM8
 aa9uXUSf1gpXg1i3phOugDJ8jEIVj/KLOPG6FpjTjW5BdgKfzINDzDwLuuY3H2X41gzz
 vOZc3MtnvrK3e3J++zBkrc4IbGJbEdPtQkNJY0HTBN4u26ONhss3eXJIk6u4D67NJ8zA
 ry238UbKRZuNy9mULOQ+Zi+u6u7fqmOCMrMfSjOj1a3fNX0UPhJAvzYeDgvBSB1j/Hoa
 w168/oTxFAFlACzYOUKMODlCAOkss4z/LGG4myM++vSuY4BqkX+joeojuD4e7eTFTnaU
 t/EA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTvjZ/znzPfffPEyd2YHiV9PJl5R26CgajlGF1YuZpmEn3bvtJM04w6Ex6dREQxXX9310aVTw=@lists.denx.de
X-Gm-Message-State: AOJu0Yzhptx1NgpEXS4YAFOZjSvmNkr1gKu0EMvVqH97UsAiKQMUgtOp
 5b2lwSZYMOhGPk8lhHKh8HzcPXQutxYEg+9OK86xUSYdIEPwY+g3bs9AJw+xQnDXPTEQI/oZwGn
 Q55EzhqCBeGMAM6zhkcAIZXV+iJD8czRrUD9mMw==
X-Gm-Gg: ASbGncsU/ON/fOU/35f2NXECYlOgHvO5arinQN2A2y5yIte4/VBhiQQiMRBIGqg/Ypb
 kN9i1uFwKsZmoW2KRLlITDKzyvSz0VxWnojgnlKw=
X-Google-Smtp-Source: AGHT+IEeVgoC/8DfjdkbuOWurYAsLRrt1e+qIoVte4cEAdooidxolgpJIhkh/mWAYM1w7nNl1biRJsf1AGglL0wPex8=
X-Received: by 2002:a05:6402:27d2:b0:5cf:d19c:e21c with SMTP id
 4fb4d7f45d1cf-5d63238c775mr1862132a12.20.1734033024986; Thu, 12 Dec 2024
 11:50:24 -0800 (PST)
MIME-Version: 1.0
References: <20241202070624.1295497-1-sughosh.ganu@linaro.org>
 <173358702572.3722028.2684286775587826268.b4-ty@konsulko.com>
 <092f9d73-c0c5-419e-b6e5-e671f8227753@foss.st.com>
 <20241212191822.GK1505244@bill-the-cat>
In-Reply-To: <20241212191822.GK1505244@bill-the-cat>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Fri, 13 Dec 2024 01:20:13 +0530
Message-ID: <CADg8p94h9rdV+gLxuhmNTi7yWhdDjOy32SpJwGSugTovtq39Rw@mail.gmail.com>
Subject: Re: [PATCH] lmb: prohibit allocations above ram_top even from same
 bank
To: Tom Rini <trini@konsulko.com>
Cc: Patrice CHOTARD <patrice.chotard@foss.st.com>, u-boot@lists.denx.de, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 E Shattow <lucent@gmail.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>
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

On Fri, 13 Dec 2024 at 00:48, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Dec 11, 2024 at 05:18:28PM +0100, Patrice CHOTARD wrote:
>
> >
> >
> > On 12/7/24 16:57, Tom Rini wrote:
> > > On Mon, 02 Dec 2024 12:36:24 +0530, Sughosh Ganu wrote:
> > >
> > >> There are platforms which set the value of ram_top based on certain
> > >> restrictions that the platform might have in accessing memory above
> > >> ram_top, even when the memory region is in the same DRAM bank. So,
> > >> even though the LMB allocator works as expected, when trying to
> > >> allocate memory above ram_top, prohibit this by marking all memory
> > >> above ram_top as reserved, even if the said memory region is from the
> > >> same bank.
> > >>
> > >> [...]
> > >
> > > Applied to u-boot/master, thanks!
> > >
> > Hello
> >
> > This patch is breaking the boot on STM32MP135F-DK.
> >
> > On this platform, we got an area above gd->ram_top,
> > this area, reserved for OPTEE, is tagged with LMB_NOMAP in boot_fdt_add_mem_rsv_regions().
> >
> > Since this commit 1a48b0be93d4 ("lmb: prohibit allocations above ram_top even from same bank"),
> > this area is no more tagged as LMB_NOMAP, because it's previously been
> > tagged with LMB_NOOVERWRITE in lmb_add_memory().
> >
> > By not being tagged LMB_NOMAP, the MMU configuration is impacted and leads to a panic.
> >
> > I suggest to revert this patch.
>
> Hi Patrice. Can you please re-test current top of tree? I believe Sam's
> series should resolve this problem as well. Thanks!

Tom, that won't happen. This is a separate issue from what is being
fixed by Sam's series.

Patrice, please let me know if the hang is being fixed by the change
that I had suggested earlier in this thread. For some reason I don't
see a hang on the DK2 board despite the board having a similar memory
map of memory being reserved for the op-tee image above ram_top with
no-map property.

-sughosh

>
> --
> Tom
