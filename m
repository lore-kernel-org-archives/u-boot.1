Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A07CA0FFB
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 14:19:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 407DD88C24;
	Fri, 30 Aug 2024 16:19:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HIBmNUHt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B2EF88C24; Fri, 30 Aug 2024 16:19:19 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B4BB88C41
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 16:19:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6c351809a80so1702526d6.1
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 07:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725027555; x=1725632355; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NqZYeAJ20jM0+Fm1nA9OIwKnlij+C6N3QND95/3b3j8=;
 b=HIBmNUHt3casfBnxFqI4GpAX8TemqDZcVY/aiCS6lGKB1OEveUwYdzB8bByksAY6Z/
 17JTTBFmoHdNIi3J9JCkBdAvV6UEQwrrI/oxQHblme/ZjYhTlsjSetT7p6UsP7Jk7zub
 ND01qvWJrZwiOCTBfqNBpNYMwFxZ45Eqgdx4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725027555; x=1725632355;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NqZYeAJ20jM0+Fm1nA9OIwKnlij+C6N3QND95/3b3j8=;
 b=Sg0KHMplRLq0eAjGNADbjTAU0Uv68w9Y+vNYxX82HlYJqBgAeXjne+0KVn99c7kuup
 y1p0+2gWrmtFdgpObQQQNoPyHYLsM0K0oGRxg/jGNnF0fRa30N229fVkNPZY3WP+Lgrw
 +dTxmD65/oRmXsMYMaQ9f65Q23Kq841ez9VQziTSjiqo90sYNTsZf5rDD41o86/P40hE
 DIxdIJU/A9TzCdIQwCOEVsG5hU+lVJ1Uy0A6GVq989meGk/qI+9tlHtOZa8NHGiApZq0
 NZjhU9yUCyg2SIVdDpOFgnCh+2oK8fjQyJXB2Yh6Eziuhqb+DIv/K5ponleePsSaYqD/
 vojg==
X-Gm-Message-State: AOJu0Yzm4BmWIxa00aKoIFlOdJGImDn490V6V491YSuPU8R3XpFeuzPJ
 2IxnY2m+HucB4Uq30vu4qv1dSoCRWOJE5xsoURAazT1yuFM1OYWG4FEhfb6R0uZ2hYxAoGvhakr
 l4NYa8QhB2ifpnzjgv98lXd+LuCut95PIdkKlUMMxLAr4Khc=
X-Google-Smtp-Source: AGHT+IE8QordNy2013Tgd9bYncCkeIUv44RW4GEZaQgE4Y5K1QdLUrOGIkq6iNi9WQQ3ODz+LD1mjmUBACGSlMQxntw=
X-Received: by 2002:a05:6214:5502:b0:6b5:e895:82f0 with SMTP id
 6a1803df08f44-6c33e69430bmr76395926d6.43.1725027555454; Fri, 30 Aug 2024
 07:19:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240829185602.3179812-1-trini@konsulko.com>
 <CAFLszThtfWK7pm-JV35Z083G43TL3ySfcuX9a83-rcMHmh=OnA@mail.gmail.com>
 <20240830014943.GR2479150@bill-the-cat>
In-Reply-To: <20240830014943.GR2479150@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 30 Aug 2024 08:19:04 -0600
Message-ID: <CAFLszTivDQ50yvTgXqc88afxX6UgcFNVLCGp=34HuwgaGt7ytw@mail.gmail.com>
Subject: Re: [u-boot-test-hooks][PATCH 1/2] bin/writer.rpi_mount: Use kernel=
 and simplify logic
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

On Thu, Aug 29, 2024, 19:49 Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Aug 29, 2024 at 07:06:06PM -0600, Simon Glass wrote:
> > On Thu, 29 Aug 2024 at 12:56, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > Rather than guess what we need to name our u-boot.bin file as for it to
> > > boot make use of the kernel= option to always call it u-boot.bin and
> > > then on 64bit platforms (and since future platforms use rpi_arm64 this
> > > list should not grow) also pass in arm_64bit=1.
> > >
> > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > ---
> > >  bin/writer.rpi_mount | 25 ++++++-------------------
> > >  1 file changed, 6 insertions(+), 19 deletions(-)
> > >
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > > diff --git a/bin/writer.rpi_mount b/bin/writer.rpi_mount
> > > index 73fb8bf6af04..ab7c3b5a2430 100755
> > > --- a/bin/writer.rpi_mount
> > > +++ b/bin/writer.rpi_mount
> > > @@ -25,30 +25,17 @@ build=${U_BOOT_BUILD_DIR}
> > >
> > >  echo "Writing to ${mount_dir} from build at ${build}"
> > >
> > > +sudo cp -v ${build}/u-boot.bin ${mount_dir}/u-boot.bin
> > > +
> > > +echo "enable_uart=1" | sudo tee ${mount_dir}/config.txt
> > > +echo "kernel=u-boot.bin" | sudo tee -a ${mount_dir}/config.txt
> >
> > Does this keep appending more and more lines?
>
> No, the first tee will zero the file and subsequent -a's append.

Oh yes.

This is one trouble I have with rpi - there is an existing config.txt
and some of it seems to be necessary on some boards. But I don't have
the code to set up everything. Typically I just get a config from a
distro and that is how stays, with just an addition or two. If we can
generate it from scratch as you do here, then things are easier.

Regards,
Simon
