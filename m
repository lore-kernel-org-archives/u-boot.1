Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C37DC001E0
	for <u-boot@archiver.kernel.org>; Sat, 21 Oct 2023 15:44:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F18048759D;
	Sat, 21 Oct 2023 17:44:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Rlec46Cj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D507587596; Sat, 21 Oct 2023 17:44:21 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F4F187572
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 17:44:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-507cee17b00so2658102e87.2
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 08:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697903056; x=1698507856; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NrF2Alr5Fcs/7CWsYR5SdT2cP1Q/E0EwlnVVg9ur/Lo=;
 b=Rlec46CjuCyg+C6ZowBlDrSA4CFrTnOgGeeTz+P/LsylmbPxZYvReAibI+SwtTTgPJ
 D4mtHhySSC0QndG1g64gItZ5IkOy9jQUFAYwQnvXEDaki60QedX4mSC6X+9DfzO15j6M
 xPrBDhhuzv/qtaIFNrmbxX17Pbju15bSpOBb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697903056; x=1698507856;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NrF2Alr5Fcs/7CWsYR5SdT2cP1Q/E0EwlnVVg9ur/Lo=;
 b=ZoHEY8KAz+lAGEgdb3wY4a7aFBbin1UgtbadJ//b5C3I6TvdS511RWjcBiICI+rj29
 nWrXttmestXOVK9Xz1xlQw4CbUTtjTrIMbG9m6tRJC3sk3bCB9aeS5GKGDS2zZWEFlc0
 eZvVfrkxq7BYOzGe4zH/4EQr7ODityeLUSAyKDInsUCRDSGiv2mor+TiGkXOeYqvtrP3
 G5NYylntmTtpiyliQfWDG1401j+ZSUit40IfFsmBzUAupEzeF32AJNetXkU2gJad++en
 UKUuVpORPcW3KZrXVNSTBA5AQvDX+3HKyl/+gMK9gl1lw/9ZQ7BDS8oxFBiVKrIgZeYm
 B0Eg==
X-Gm-Message-State: AOJu0YzdQ+Gr22QFip7iCZFUY+IDoAT6bVJMOHAU3fTTFDYktUY2x4TJ
 CdKH+bCyEuoNQxomOg7dV4HkomhRmt972iveMNL1VhxaRo/W7GCf01N5d5FP
X-Google-Smtp-Source: AGHT+IGdbRyFsuKFz8iO+pQnRmdfnJJZAw/pgaLZz+7oPtXOWy9KKZDM24d0GlJ3huF0uAuVy+Hm86i0s8dSCDbFMAY=
X-Received: by 2002:a05:6512:5d5:b0:507:ad92:18d1 with SMTP id
 o21-20020a05651205d500b00507ad9218d1mr3203498lfo.68.1697903056192; Sat, 21
 Oct 2023 08:44:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-33-sjg@chromium.org>
 <20231019023253.GA1856856@bill-the-cat>
 <CAPnjgZ1xFkn806tSJzM2_wKhKz_GbJvA9bCALiaRV+wGaXz6_g@mail.gmail.com>
 <20231019145702.GZ3119521@bill-the-cat>
In-Reply-To: <20231019145702.GZ3119521@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 21 Oct 2023 08:44:03 -0700
Message-ID: <CAPnjgZ3xBLRWxvPVUezatcbM25SJ_5XR2Tp_SNGaf8eZpBMFsw@mail.gmail.com>
Subject: Re: [PATCH v3 32/32] sandbox: Add a test for disabling CONFIG_CMDLINE
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Tom,

On Thu, 19 Oct 2023 at 07:57, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Oct 19, 2023 at 08:00:00AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 18 Oct 2023 at 20:32, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Oct 16, 2023 at 04:28:23PM -0600, Simon Glass wrote:
> > >
> > > > Now that everything is working, add a test to make sure that this
> > > > builds correctly.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > Reviewed-by: Tom Rini <trini@konsulko.com>
> > > > ---
> > > >
> > > > Changes in v3:
> > > > - Rebase on Tom's LONGHELP series
> > > > - Correct 'of' typo
> > > >
> > > >  test/py/tests/test_sandbox_opts.py | 20 ++++++++++++++++++++
> > > >  1 file changed, 20 insertions(+)
> > > >  create mode 100644 test/py/tests/test_sandbox_opts.py
> > >
> > > This is not doing the equivalent of:
> > > make sandbox_config
> > > sed -i -e 's/CONFIG_CMDLINE=y/CONFIG_CMDLINE=n/' .config
> > > make oldconfig
> > > make all
> >
> > Buildman should do that automatically...is something failing?
>
> Yes. https://source.denx.de/u-boot/u-boot/-/jobs/716843 fails, but
> shouldn't, and it's only the no LTO job, so maybe there's some conflict
> there?

For me this was the EFI patch to make it depend on net. Perhaps you
hit a different one?

I am seeing build errors with ~CMDLINE ~LTO with your series.

Regards,
Simon
