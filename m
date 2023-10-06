Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2CDDE94136
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 22:42:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C335786EA6;
	Sat,  7 Oct 2023 00:42:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Mvb4dHL0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9FAB86D6E; Sat,  7 Oct 2023 00:42:55 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDBAB86B89
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 00:42:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9936b3d0286so483876266b.0
 for <u-boot@lists.denx.de>; Fri, 06 Oct 2023 15:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696632173; x=1697236973; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tbJe5uh4l4WowaF+Dz/BNyMCwcBxsc/c/ZDqXyAhV2E=;
 b=Mvb4dHL0RUeLsSEEyK4NtG4nHQdQfunggStm4gdy6qHGmA5ivDjM1xLq3QP+2xxQG8
 TlBDde0gV+ABM0L+5fCvjj91jiI+Z3hXlbx0XWMkFEjxd8PLvC5P4JCou5Tm1AwWHxui
 OkI0SjC7q1CXSTdWLOJRe1m97yFL0Yu3wHMdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696632173; x=1697236973;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tbJe5uh4l4WowaF+Dz/BNyMCwcBxsc/c/ZDqXyAhV2E=;
 b=ctLS9GPmiZ9AWCJ+dgIRbTXrycF0rfcHXw+y8AC+7kcTJwdFAjBD+lnuVIkend5+GC
 73hbtfk3OnOHtwcMLYWKt+Wn14Lc4Ov6xsiBaCHICeAZRStlqTapO5SLyNIqZu3vGpLC
 NxhzHayuOTvwM7mSCoa3Oi9D7rcBPK1HD4Adj4qzWlpmzhljlQwGe+l8/EHD5/4XpZqJ
 9/mWiCgDkQTiBPC09n6WAlURpYCgWMifj9y/qA1s8MH2h8c/uNmyeS+zaNNCwPVfq7/P
 Kvc9QE7Ac1QfCvkJXQz4rwhwhKU/44xkDeKF/rGHF1o5aoz3v7ZzMwd0PMaAEaRvH1X9
 t94g==
X-Gm-Message-State: AOJu0Ywyany2Gf/zv+GU8yyppxBOs3hiXWygkHRY+OzVbHkYqWhjj/G1
 PfICoBmPZSZM1BFh9lNc6ZPnaVjElc8BXXRMM5vA5g==
X-Google-Smtp-Source: AGHT+IFUXQ/Q2OgM4/o+Dbwj97C/Z5Pk5dOl1xIw21nn18NIMWsMUJggxBxI+RaCQwycWf8KXMfMl84kC2OC9sYdPYA=
X-Received: by 2002:a17:906:31cc:b0:9ae:56da:6068 with SMTP id
 f12-20020a17090631cc00b009ae56da6068mr1076077ejf.57.1696632173128; Fri, 06
 Oct 2023 15:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230727215433.578830-1-sjg@chromium.org>
 <CALeDE9MADwXU_gExvQZJnxKYDk1C1YLiZyL1jhe9-Um1hQA=6Q@mail.gmail.com>
In-Reply-To: <CALeDE9MADwXU_gExvQZJnxKYDk1C1YLiZyL1jhe9-Um1hQA=6Q@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Oct 2023 16:42:38 -0600
Message-ID: <CAPnjgZ2L7Rfbuj6aN3oQqOPPxywraDaL1AM6xyQiNB8T6PFPGg@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 0/3] rpi: Convert to standard boot
To: Peter Robinson <pbrobinson@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Matthias Brugger <mbrugger@suse.com>, 
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
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

Hi Peter,

On Fri, 6 Oct 2023 at 03:22, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> Hi Simon,
>
> So with more testing of 2023.10 in Fedora we found a regression where
> the display dies when the vc4 module loads in the kernel. With further
> debug it was found that it was due to the new U-Boot and with
> bisecting it myself I have found this series is the cause of the
> regression.
>
> The testing I have done is with recent RPi firmware, U-Boot 2023.10
> and kernel 6.5.x, but also seen with 6.4.x, with a minimal text only
> image. I can also reproduce it by using the F-38 GA image, no updates
> and purely just changing the U-Boot component. I've done my testing on
> the RPi4.
>
> Let me know if you need more information, I believe you have a RPi you
> can test with.

Thanks for the report. Which rpi should I test with? I take it that
vc4 is a kernel module? Do you have the error message?

Regards,
Simon


>
> Regards,
> Peter
>
> On Thu, Jul 27, 2023 at 10:54=E2=80=AFPM Simon Glass <sjg@chromium.org> w=
rote:
> >
> > This series moves Raspberry Pi boards over to use standard boot.
> >
> > It also moves rpi over to use a text-based environment. Unfortunately i=
t
> > is not possible to empty the header file due to several CFG options.
> >
> > Fix the repeated "and and" while we are here.
> >
> > Note that this reduces rodata size by about 4.5KB. We could get another
> >
> > for a total image-size saving of about 15KB. This is mostly because
> > HUSH_PARSER is not enabled anymore and the environment shrinks down by
> > about 3.5K. Hush is not actually needed anymore, since standard boot do=
es
> > not use it. Also CMD_SYSBOOT is dropped since standard boot calls the
> > pxe_utils code directly in that case.
> >
> > Changes in v3:
> > - Rebase to -master
> >
> > Changes in v2:
> > - Rebase to -next
> > - Add new patch to disable DISTRO_DEFAULTS
> >
> > Simon Glass (3):
> >   arm: rpi: Switch to standard boot
> >   rpi: Disable DISTRO_DEFAULTS
> >   arm: rpi: Switch to a text environment
> >
> >  board/raspberrypi/rpi/rpi.env  |  77 +++++++++++++++++++
> >  configs/rpi_0_w_defconfig      |   2 +-
> >  configs/rpi_2_defconfig        |   2 +-
> >  configs/rpi_3_32b_defconfig    |   2 +-
> >  configs/rpi_3_b_plus_defconfig |   2 +-
> >  configs/rpi_3_defconfig        |   2 +-
> >  configs/rpi_4_32b_defconfig    |   2 +-
> >  configs/rpi_4_defconfig        |   2 +-
> >  configs/rpi_arm64_defconfig    |   2 +-
> >  configs/rpi_defconfig          |   2 +-
> >  include/configs/rpi.h          | 134 ---------------------------------
> >  11 files changed, 86 insertions(+), 143 deletions(-)
> >  create mode 100644 board/raspberrypi/rpi/rpi.env
> >
> > --
> > 2.41.0.487.g6d72f3e995-goog
> >
