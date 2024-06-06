Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6893DC27C54
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 15:05:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDEB58845E;
	Thu,  6 Jun 2024 17:04:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q4WDu8X0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11E7088453; Thu,  6 Jun 2024 17:04:32 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0155D88459
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 17:04:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6afbf9c9bc0so5764766d6.3
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 08:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717686269; x=1718291069; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=07FW4H3RjcZeJFfWrX5YA2SByGS4uz4cnwtlxUezFr4=;
 b=Q4WDu8X0dM4uBhAyq9Pk7qfEGbg5d0WeOfJtz+xuWx13w2dOL3j7qBWHICcBCB0PS/
 Dh3NXVS50XbIzyH6C8O5tmEUBy6AFaqVQnFir0lm2BSuaAmAr3e6jJKLRM/ya3kkFAvk
 N7osDFCUamzt2uSf0hAVHw8Ri0IKw6QaZNZJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717686269; x=1718291069;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=07FW4H3RjcZeJFfWrX5YA2SByGS4uz4cnwtlxUezFr4=;
 b=GpNWc+TIZCU5E5pjUKdIEDTqdrf423Zi6PolrkIVT+WL/WAvzUM9IZBsNp8AZcJBpU
 ddWFfXyaqlip0xi+Rnd8FMtB+Ka4ulIV0BKhnM0eoGcO3A8ZfK/omiGpgyRmYNTZFREA
 dQI7j/txefYakzOVE8afnYNlTHCs56p3Z2ZxA2Obh0qOo4sO/uJwa92V15Oi1YSdf7qd
 KZZK/ZlOEExhTEv6WTqn/cWQdPkiZrieSYq8X5IVSiakpN2nbE6tgej0h0Y4ef/vazDZ
 P8kkr2bplRurK/l4RJHF7CkFOsTQcsPJDEEDA7YpATj5G6i8QV/NurEdnIyNE2Kg87Pe
 A8GQ==
X-Gm-Message-State: AOJu0YyM31Qw6G88Se/Z/8E3G0erftpNbpWMxtcXYETB6TA2Wh+YiqQO
 YLSWYgo+mkBbZ4dzoHYHVJ9F4LWJQPwqdpn0aWQT2LyNokQMbXZ3gY/c2iwfy0kV7vIxMcO4U4B
 OVk1rZ9+VoR7lkw4rSYhg5EakfP+jCrLadgNk
X-Google-Smtp-Source: AGHT+IHFFz44HNIHTlP8OZHD5kVsKzpvFiVxCE6sqbv1aPDlJL+VftSxYbXeM2tg0miY9MoRwdaA4uFYfuFmGrt7Fq4=
X-Received: by 2002:a05:6214:4385:b0:6ae:d66c:40db with SMTP id
 6a1803df08f44-6b030aa92dbmr57678646d6.65.1717686268760; Thu, 06 Jun 2024
 08:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240605032521.1142768-1-sjg@chromium.org>
 <20240605032521.1142768-10-sjg@chromium.org>
 <20240605144224.GR68077@bill-the-cat>
 <CAFLszThEeXFtqf-Yk+_WbJ2GJtkFdC-R-_nWH2HAE9rjn0d8ag@mail.gmail.com>
 <20240605201509.GW68077@bill-the-cat>
In-Reply-To: <20240605201509.GW68077@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Jun 2024 09:04:17 -0600
Message-ID: <CAFLszTisz7GUBzSYS9doV2vfPfM14=-v7ADsPbrALYZkuqrtiA@mail.gmail.com>
Subject: Re: [PATCH 9/9] Revert "arm: am335x: Enable SPL_OF_CONTROL on some
 configs"
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Martyn Welch <martyn.welch@collabora.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
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

On Wed, 5 Jun 2024 at 14:15, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Jun 05, 2024 at 02:08:54PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 5 Jun 2024 at 08:42, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Jun 04, 2024 at 09:25:21PM -0600, Simon Glass wrote:
> > >
> > > > This is a partial revert which makes boneblack_vboot boot again.
> > > >
> > > > This reverts commit f4b64e9736e73ceec14d51600bed9a8ac48f9fe8.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > >  configs/am335x_boneblack_vboot_defconfig | 1 -
> > > >  1 file changed, 1 deletion(-)
> > > >
> > > > diff --git a/configs/am335x_boneblack_vboot_defconfig b/configs/am335x_boneblack_vboot_defconfig
> > > > index d473a1a793b..3ec4abddd77 100644
> > > > --- a/configs/am335x_boneblack_vboot_defconfig
> > > > +++ b/configs/am335x_boneblack_vboot_defconfig
> > > > @@ -40,7 +40,6 @@ CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
> > > >  # CONFIG_CMD_SETEXPR is not set
> > > >  CONFIG_BOOTP_DNS2=y
> > > >  CONFIG_OF_CONTROL=y
> > > > -CONFIG_SPL_OF_CONTROL=y
> > > >  CONFIG_ENV_OVERWRITE=y
> > > >  CONFIG_ENV_IS_IN_MMC=y
> > > >  CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
> > >
> > > So, this change was a while ago. But I did it because some of the
> > > drivers, tho I forget which ones exactly, really were not functional
> > > without SPL_OF_CONTROL enabled. That said, does am335x_evm_defconfig
> > > work in your configuration? I think we have to keep am335x_evm_spiboot
> > > because it's so radically different from how the rest of the possible
> > > options boot, but I'm not sure we need a vboot defconfig? Or if we do,
> > > it should be updated to use the #include logic these days.
> >
> > I don't actually have an am335x_evm board, which is why I'm using bbb.
> > We only have the vboot version, since the non-vboot was removed a
> > while back.
> >
> > In any case, with this patch, bbb boots again.
>
> Yes, the am335x_evm build supports all of the TI (or associated, like
> beagleboard) platforms. Please give it a try.

Yes, that works. So what should we do with the boneblack config? We
really should have something that boots.

Regards,
Simon
