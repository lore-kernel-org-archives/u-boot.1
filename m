Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E12CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 03:31:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23FFE86F08;
	Wed, 18 Oct 2023 05:31:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Cf7q/cqD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F56686F08; Wed, 18 Oct 2023 05:31:38 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4258786F42
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 05:31:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-53e84912038so5796137a12.1
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 20:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697599896; x=1698204696; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PM0W1g0/OUB7ph/1FEAaljHHGz3NI96Z2UlO5k+ABm0=;
 b=Cf7q/cqDBE/8lszk0X1SRj/DvSGfzTCP4+hxrQKb/t6sCG8WW52/mgBEDz5DCn+ctn
 1xdsDVvHsOQc253afwWN+VoZxSxy4kgVKN7oXFasRsldRwoKR1A51M4q/zTzKjCqUJCg
 rpFrUr+UQP3fsNE/LU5A5663t74xkarVHVpIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697599896; x=1698204696;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PM0W1g0/OUB7ph/1FEAaljHHGz3NI96Z2UlO5k+ABm0=;
 b=nvD2+Q0x3Kgu/VaUYee6Y+fSWEZynKyIAEDJXw/2w7GYec2rRQbnP8K6/iky7PORAu
 +JgIQk4yElKjyXqKrSWLNp8RHeU4P0yhfrm6VCYaof7cU7zNmRSHpcmu0456fuL0AcEx
 k1tY/PfUAHfKjvPe7TbXvmYxfIJF/IlNTcrIs0Ux8YdhJo2ZkcguDwDuNQn0SmhOgaqH
 O9k0fdyX8xaEFDNkmifYomRMMDcZHgonjFzePjJ/NzpddD0dxxY9jPRY/N61g/I/HgrU
 QGioJcXVZfdUvRdLDl0C5+1lUa+dtGNElVtNaS3BgCMCd8MfmByirIz6PiO4hWcOEPlI
 bJRQ==
X-Gm-Message-State: AOJu0YwAA74OSGqsTrgZw44W6JLmEC+AK3GXHj+ckQme21Ip88xgji/x
 RdU2WQOIQW54frjoW2rE4A/oM0pLuSkIoCYyTLsfaVIUgXYN7c8cPMs=
X-Google-Smtp-Source: AGHT+IFZPi+W38+92zuV96zE8pdnl+lyXFHJWl86WRx/czTRACfgYiRGcFImnnLcihRajVx83HFNpSgPJ+RZqw6DCI0=
X-Received: by 2002:a17:907:2d0a:b0:9c1:9bc5:c263 with SMTP id
 gs10-20020a1709072d0a00b009c19bc5c263mr2949443ejc.50.1697599895627; Tue, 17
 Oct 2023 20:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-19-sjg@chromium.org>
 <20231017140703.GZ3119521@bill-the-cat>
In-Reply-To: <20231017140703.GZ3119521@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 17 Oct 2023 21:31:22 -0600
Message-ID: <CAPnjgZ0QZRqVWZKZtHC6op9-0eOe2-WmmOPoL6tJEPUjvmqOAQ@mail.gmail.com>
Subject: Re: [PATCH v3 18/32] video: Allow use without CONFIG_CMDLINE
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Anatolij Gustschin <agust@denx.de>
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

On Tue, 17 Oct 2023 at 08:07, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Oct 16, 2023 at 04:28:09PM -0600, Simon Glass wrote:
>
> > Provide a fallback for when CONFIG_SYS_CBSIZE is not provided, so that
> > the console can still be used.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  drivers/video/console_truetype.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/video/console_truetype.c b/drivers/video/console_truetype.c
> > index 14fb81e9563c..e4dad3f9a191 100644
> > --- a/drivers/video/console_truetype.c
> > +++ b/drivers/video/console_truetype.c
> > @@ -125,7 +125,11 @@ struct pos_info {
> >   * Allow one for each character on the command line plus one for each newline.
> >   * This is just an estimate, but it should not be exceeded.
> >   */
> > +#ifdef CONFIG_SYS_CBSIZE
> >  #define POS_HISTORY_SIZE     (CONFIG_SYS_CBSIZE * 11 / 10)
> > +#else
> > +#define POS_HISTORY_SIZE     (250 * 11 / 10)
> > +#endif
> >
> >  /**
> >   * struct console_tt_metrics - Information about a font / size combination
>
> NAK, this either should be SYS_PBSIZE (output buffer) instead which you
> move out from under CMDLINE or SYS_CBSIZE (input buffer) should also be
> outside, and both get a help text to explain them a bit better.

I think PBSIZE would be better. Even better (eventually) will be to
drop this truetype buffer if input is not needed.

Regards,
Simon
