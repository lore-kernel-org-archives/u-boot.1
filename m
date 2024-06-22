Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0CCBC27C78
	for <u-boot@archiver.kernel.org>; Sat, 22 Jun 2024 15:03:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F1C1866F6;
	Sat, 22 Jun 2024 17:03:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ahbN89Ru";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B875887D1A; Sat, 22 Jun 2024 17:03:21 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D8B4866EB
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 17:03:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2c1a4192d55so2318515a91.2
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 08:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719068598; x=1719673398; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h9AM3DWeBzBiV/DYBNOLnHLefxVSzMjBvPsq8rb7xpQ=;
 b=ahbN89Rufx47IyMs6awzd9cW3MVtV99RclgVVEBP1vD6BAGz19lEMhMdzfpa5Pswp6
 5Exzs4okHKlGhmuP4TgWMABPhldC2teHm3D4Cg1sxLgu1p1OFpNVGZLfu+sQZeG7559z
 NZLiN7Rs9N/mDAPZAoLQziMxdExgsp+D+Dx5zYQXXrqlfMR1AJaKvQ5R+M6UUk5jIryr
 aeo2SNutvSBzf9U6CLn7KmNtR3GYrY1CQzdYVLvJtzkZWXAzoEqANZWCuGHSv8xqtjYD
 rDRu50lMZS49do2N8EB0ji+uHB7AryWFsLca2uKU0PN/ViyhdQNZqzm4YX/BE11QhvVE
 AsKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719068598; x=1719673398;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h9AM3DWeBzBiV/DYBNOLnHLefxVSzMjBvPsq8rb7xpQ=;
 b=joewnATQGNUSBw89a3Q0uFSXAlxC4EWkvI9thlooehJuT0DHDE9e4lvmTltPcDKaE4
 77yTLAkhs6oH6FgfEPXrAO32uUrhxu61umfzMwRe9yB8ssqn4+yycQosv14jDKgg7XyT
 HpD7HmeUrcvQixi7C2QRXWXErvKL0FfW3KpX6SKVISd5nZHjefJmKKbxPEhyBbhPHck5
 wIM9Uv+rBzRqAP7G9WepxYcXqF7vQU4gx9IuyE88vSbO41ji1bS/QnYzD6LMjqzDjV13
 hRYKE5w4VNSygIn5dG1or62GnIIQ8wk4E4QZRyOTtQVUQHK8lc/6iL7I9zw+sElJoYMQ
 2e9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAx1MPsyG1TtLWMBAS/5EnzrqhG5AIvNmm3vHCkKFdOLw3P3zW4JaVeR+QaRWq9yQdNrhQoP2b3wJVTI2oZNZ6TBk0gg==
X-Gm-Message-State: AOJu0YyYp0JeVQcULngw3BMt6+lq5NJgsSh/7jmDqZUYFkAbXzAZDmOP
 V29BYN+xKphpwa4xYO0HdNlBWE5L5eseTq/1dC3SvsLzZFhxLSj40hi/YgvzuR6SQTLs7LhtIzE
 W39hen17/B9AJHjYk0JHXoCchgsSnuVeHQ12klA==
X-Google-Smtp-Source: AGHT+IEfn9JpbbEtTyY50agrSe7xFXMvPbSpaawOtHgzkdE5Iwx3BtfWceMa5+CCYeiLO6FtKz/AhEUWWWPXUaNhxDU=
X-Received: by 2002:a17:90a:8c91:b0:2c8:5bc1:aaf5 with SMTP id
 98e67ed59e1d1-2c85bc1ab78mr391906a91.1.1719068597665; Sat, 22 Jun 2024
 08:03:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240618122348.126196-1-heinrich.schuchardt@canonical.com>
 <CAC_iWjJgFhAaDQU2TucwmG7rpwkT2CUnHg6zKrkaeEJNub4e-Q@mail.gmail.com>
 <129ef964-b046-4985-a1f7-738457c369bd@canonical.com>
In-Reply-To: <129ef964-b046-4985-a1f7-738457c369bd@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 22 Jun 2024 18:02:41 +0300
Message-ID: <CAC_iWjLw4UZSBU2yVU7HgKi6GOSN8W14w6zWqMcWatE+nQPv8Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_selftest: can't have measured device-tree with
 kaslr-seed
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de
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

On Sat, 22 Jun 2024 at 17:58, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 18.06.24 17:54, Ilias Apalodimas wrote:
> > On Tue, 18 Jun 2024 at 15:24, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> Test that we don't have a /chosen/kaslr-seed property if we measure the
> >> device-tree.
> >>
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> ---
> >>   lib/efi_selftest/efi_selftest_fdt.c | 7 +++++++
> >>   1 file changed, 7 insertions(+)
> >>
> >> diff --git a/lib/efi_selftest/efi_selftest_fdt.c b/lib/efi_selftest/efi_selftest_fdt.c
> >> index aa3b13ae3ab..066d9581432 100644
> >> --- a/lib/efi_selftest/efi_selftest_fdt.c
> >> +++ b/lib/efi_selftest/efi_selftest_fdt.c
> >> @@ -227,6 +227,13 @@ static int execute(void)
> >>                          return EFI_ST_FAILURE;
> >>                  }
> >>          }
> >> +       if (IS_ENABLED(CONFIG_EFI_TCG2_PROTOCOL_MEASURE_DTB)) {
> >> +               str = get_property(u"kaslr-seed", u"chosen");
> >> +               if (str) {
> >> +                       efi_st_error("kaslr-seed with measured fdt\n");
> >> +                       return EFI_ST_FAILURE;
> >
> > When does this run? efi_try_purge_kaslr_seed() tries to remove the
> > kaslr-seed before measuring a DT. Are we safe enavbling the check
> > here?
>
> do_efi_selftest() is called after efi_install_fdt(). efi_install_fdt()
> invokes efi_try_purge_kaslr_seed().
>
> We would get an error here if efi_try_purge_kaslr_seed() were removed
> and measuring the DTB enabled.
>
> Best regards

Thanks! That's what I was wondering

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> Heinrich
>
> >
> > Thanks
> > /Ilias
> >> +               }
> >> +       }
> >>          if (IS_ENABLED(CONFIG_RISCV)) {
> >>                  u32 fdt_hartid;
> >>
> >> --
> >> 2.45.1
> >>
>
