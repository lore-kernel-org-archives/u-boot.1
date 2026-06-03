Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F01DCD6E55
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 10:38:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BC8983FF5;
	Wed,  3 Jun 2026 12:38:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wOW8pLA+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7F5A840ED; Wed,  3 Jun 2026 12:38:06 +0200 (CEST)
Received: from mail-yx1-xb12c.google.com (mail-yx1-xb12c.google.com
 [IPv6:2607:f8b0:4864:20::b12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F6E583EF9
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 12:38:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-6604df9ba4eso378021d50.0
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 03:38:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780483082; cv=none;
 d=google.com; s=arc-20240605;
 b=Mo9lKEew07NdPofTi0qG7tO8uFhDTotuPjfgn3l4L67CNa5VviYHiby/47907dzp5u
 Jc20XcfkviSX0WOOlXbePSJKi/DKJEE53I65V6iJd3duhfUFco0ivDa05cFx5Dd0Pn/H
 CHH3EEr5t3aDGnB93kTIeZg+oaN4Pv756q+cxGtZyESSeCfRhHButwKN5DqYwI0rBqtd
 2RMXLP3fxeyz4tpTUATVGVvweNJYBBiyMKtdqX0C3EgJfbbN/3905pEy6A6Yp5cv2sj/
 B2hEKmrlfbWPHnv55YjR9Xblz3VuADo5wWT62O+JZFW8aSWzBTOk4VRBOUnWCnJgz1Ws
 iOcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bpJisatG4XVYLbcL01JQfJf/1udkmHQIcZft1IgS9Rk=;
 fh=qHuurAjEGyW7uZ8Zs7K1T/FS0N1C1Wfafc/5P8ZPdfY=;
 b=Xb5I831ZYTno2RVOKspIpsl9qf8WDgToxc8WpQjrAlp3ZPgFdkD16hwzeWUuYiomRr
 lfVANZftaJnx5rnmV12q+opspe3Ps1Tp7I5kwGlWA12nzJf6w1mF4UVUSffv4kDKqIcY
 QkOm7uA2CB4Quxl4HmnWYdOARqYnxv5we/XGDiGeSCBj2+S5rc/kA3nWcLsZyD9IvvPo
 FEgnDUUlMMV+IYSKa5OE5c2XLqeeapvO0Z1coLzKwNQuV0rchyssAu5eYx50wgh3zoY4
 TtmWUixE+DP96rV/HttqqBXKdUlDqwIaBNuKhTf79OrSfIz7XHuOXSLod/0DqAVfOnVb
 HGsA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780483082; x=1781087882; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bpJisatG4XVYLbcL01JQfJf/1udkmHQIcZft1IgS9Rk=;
 b=wOW8pLA+au22HfdMEi1QgD63Y25fH5+z/ACg7o7nC9LoypjfU+/nV0VsIxFwfpM9PT
 nf0GsiydHeE6ODK/aYb8qYGFIX0lDkxanYCOAOKdVuFexoFPOSCr42QxbnZEc0oZ/F2l
 11F6ePlD0Ojf6976/xnJVmcoWMyb1ZDr7cvjEtfa9Vhun91fZMQTOvxZduTGuU8e7Peh
 vNbcahNacpRgj61dV4xQr6mDUq7u0jAOefj9HPvADqB8+KYQ8jJijuIxLY2lqxlxS+x5
 ByA33FNqk7shUttkz+k0k6tlUaPcL4d4Mc+0TaQMD+VkcOifsH88ntChdRH61hVlqroO
 pskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780483082; x=1781087882;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bpJisatG4XVYLbcL01JQfJf/1udkmHQIcZft1IgS9Rk=;
 b=KLNWmS3caYnmPXEGesBPqq8sJGhQtmT1e1H88SlHeHTV+zgS9npApI6bS8ojjE7brj
 pcNAzmHEwCwH6HVDfmMhHr21dZq2d+Bfewdg8GynUU8POs/cL9thZHb2iJKqvo69P6Z0
 maBaYlYJjtTIdKn8iRAfSSGjx8rWGa+/98Fk2brxykKqk3CgpzbjD8RNv2piE+H6ptSw
 Nxdt7knVJWn3f28eg2oEeK6txwbeGoEaPOOshts1/CFoAvZ13Yi7fj7xKhZFJbiSscAF
 oGsN4u1TJE9HeM30Dk4F+L0Tsy4LkLpaJnU/6D5UqnAjYeFptz0qd49M7KD2lI5riHvw
 pGYw==
X-Gm-Message-State: AOJu0Ywr46te09s5h9gtxi9xtn5bWNEzoLVOyKzLDSADYMUiOTEYJFYf
 hjDfaaiFQjUTqiJupxWaXXdgCq2XjKEErLDM1u7NQfjUOZIZIx5muJk3200Po1nKEhuG1pQJ3kc
 5pEBLQ7oPLBAPuBsIW1VlWCjzBfEUEq9H0YMjM59Tag==
X-Gm-Gg: Acq92OHn3wOaoyEFu8AsmT1WQrZa80se+73TKy7ZqEhffxe8O6+6AKr3KbETQ+2CeWk
 1vZtSrh+fSxe9DCRO6ZTLgrzkkp6sidXOTLvF4P8vLXByBAVnqDzG6vhOCl62tlOiOxRHrY9X7I
 PfGqdgJLLLu1HCBDNAr4sar0jI08FNB7sqiNcaBoxa/sPemg2XoniAcRT8iaYnTaFFs9vmZw9r2
 Z+tdekLYuNKJK9/t/mCivxgh7et+Z29MNFEORE82QSkJ4UK47GAyQe27AtcnABqGByzlE98g48S
 tmyZbS5pVOxTkDUvtXS5c8vZVOyYYoGnW1Sj3jsR059C2V/HaVvVARLfyQLLBLtLrjJQhWM2IGT
 iGwR5vIglwZy25/RUp4CuLYvrdB7IwR3Yi+UsL9Bg3BakNmUNgqK02eh6S26K1ShpMTU+Lo+wob
 jZOgblClPJx+WUuQgAWN6KYFrOZh/NjhlglYMbc1ooyhodpsjM+iM4Ca1No4ZKO13T3fEo+S5qX
 cZuyHMWo2ZUfy+1A50mqWSpDTXrFM+F7jtxE0yb1uFcp20d7qx89ox6uFXekI3F4KxGUsp16jH+
 SIQ375F//J2pTh1lClb1C+FC3pDAI3v4iziMcbJhzGS655KY25QREj1FZ/2D/93pocimEWUMAKb
 KNE774q8RfVcxNgIi
X-Received: by 2002:a05:690e:1287:b0:660:68ac:21ba with SMTP id
 956f58d0204a3-660dcc38021mr2018879d50.29.1780483081757; Wed, 03 Jun 2026
 03:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260530144604.71190-1-marek.vasut+renesas@mailbox.org>
 <8e28ea5f-039e-4620-bb88-8e992290da58@mailbox.org>
In-Reply-To: <8e28ea5f-039e-4620-bb88-8e992290da58@mailbox.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 3 Jun 2026 13:37:26 +0300
X-Gm-Features: AVHnY4KUxxOn294OpeJR41ZV1RizZYijlnqM7XZxIUrF6kMhr0PXVyeV1X-N42c
Message-ID: <CAC_iWjJHEXshSgbimHRo9LPOpL36B_cOKiyrsNoqMEuyFeMdxg@mail.gmail.com>
Subject: Re: [PATCH] [RFC] lmb: Optionally limit available memory to 4 GiB on
 limited systems
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 David Lechner <dlechner@baylibre.com>, Heiko Schocher <hs@nabladev.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Holger Brunck <holger.brunck@hitachienergy.com>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Tom Rini <trini@konsulko.com>
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

Hi Marek,

On Sat, 30 May 2026 at 18:06, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 5/30/26 4:45 PM, Marek Vasut wrote:
> > Some architectures can not DMA above 4 GiB boundary,
> > limit available memory to memory below 4 GiB boundary.
> >
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > ---
> > Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
> > Cc: David Lechner <dlechner@baylibre.com>
> > Cc: Heiko Schocher <hs@nabladev.com>
> > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Cc: Holger Brunck <holger.brunck@hitachienergy.com>
> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Cc: Peter Robinson <pbrobinson@gmail.com>
> > Cc: Quentin Schulz <quentin.schulz@cherry.de>
> > Cc: Simon Glass <sjg@chromium.org>
> > Cc: Sughosh Ganu <sughosh.ganu@arm.com>
> > Cc: Tom Rini <trini@konsulko.com>
> > Cc: u-boot@lists.denx.de
> > ---
> >   lib/Kconfig |  8 ++++++++
> >   lib/lmb.c   | 20 +++++++++++++++++++-
> >   2 files changed, 27 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/Kconfig b/lib/Kconfig
> > index 77ebc79e1db..29911068a69 100644
> > --- a/lib/Kconfig
> > +++ b/lib/Kconfig
> > @@ -1295,6 +1295,14 @@ config SPL_LMB_ARCH_MEM_MAP
> >         memory map. Enable this config in such scenarios which allow
> >         architectures and boards to define their own memory map.
> >
> > +config LMB_LIMIT_DMA_BELOW_4G

This seems the right idea for now, but is it really 4G or ram_top?

> > +     bool
> > +     depends on LMB
> > +     default y if ARCH_BCM283X
> > +     help
> > +       Some architectures can not DMA above 4 GiB boundary,
> > +       limit available memory to memory below 4 GiB boundary.
> > +
> >   config PHANDLE_CHECK_SEQ
> >       bool "Enable phandle check while getting sequence number"
> >       help
[...]

Cheers
/Ilias
