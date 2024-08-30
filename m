Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379DFCA0FFB
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 14:28:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9126888C2E;
	Fri, 30 Aug 2024 16:28:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cPG0rhMV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92F1A888FD; Fri, 30 Aug 2024 16:28:25 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D538388C2E
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 16:28:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-714187df604so1847353b3a.1
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 07:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725028100; x=1725632900; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0jbu908kupGpXeh/0CDFPG27kVUVDuK7tuCDubNEaA0=;
 b=cPG0rhMVJSN9fjLOj2vmWvARxPFXmExoueudp1s+zQdlBlDK7l5A6cQBK0/UfRknw3
 GZiJTefOhgDO/e6GMwlU2tpqCEdof9OQ/Aho+oz/2qNolVN0y0+NUMak12BBrRSrZUWr
 TbIkMScPmYyLrQbcbzTX8fjTmJGWwJ0v+qRBVSVAhDEVKWiPbEmgLkosYMDZo/K0+WW6
 5xrJKof4AM6Dsv+H8WLhDT8v/P7qd2sNKX/JfRkWeE2Xr7XvAP7PB+r2nipers/UYd2V
 WMUrx4zC2dlmfx4g5+EDc0jCVmyy+SNIwBaY7l/2YuREeGS/Sos0Bs+EKNMPKCbramaI
 Le1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725028100; x=1725632900;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0jbu908kupGpXeh/0CDFPG27kVUVDuK7tuCDubNEaA0=;
 b=RGLQ9VWaiPrvNeFCnv44IgdrAWY/+AcX1CMev0oc900oh2qZm8Jb9wQxMlTh9blK4Z
 BlDcKqty6K3t7GxY+d7xSSzP4wFRYVADZHv21qbmAogN9rtDJUx6buF/DoFa+7ZSZOI4
 Y/dGOdi56dvCCCoKEHuCknhoCEFRtkH/JQezelRgygxE64h1Z4N0KC9GowDVQbcUKSDV
 BvpJncYnya3LhJJm/GnLoKqgfIZIhsYKJREB3u9JygrXt0vVKrq3+zOBp3naoTe69mSe
 p+SycIlGvYxCAg1pgRA2Y1w8Kt0g5C2BzE8KxnyJ4ptpdNheuLP1ZEH1/wpzYLhI1Bb8
 Htnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfi+TXEi2gLxai1qaiqWdxsxKrywP9VTVSh5Zj6NXXDsBPbmejUmAkHbsAmkX9uL34HRl310I=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7zAX/6vGAwEAmmsWDTbIfMyGn80922Qz2y+wEBOucZ7z/K3yx
 FnM4RMBGW/DB6zQegrJ4BjHr8HuuRy6PRkztUhDGfeMtrj/nZsyjIu/tAABHagVDrpoTsCm8iSo
 pQfQjVXeVhxljnl1j2aMLV/E9fiFJEMG/cs1Fyg==
X-Google-Smtp-Source: AGHT+IHA8JmfOQFK+v4HVYdjO9sUNHqBpSSdEuA2LyFkzZx3krJ4bX3A/stcHwHM4MqS8qTaM3W+rYQOiDDA4Rc41Ws=
X-Received: by 2002:a17:902:d4cb:b0:1f9:d6bf:a67c with SMTP id
 d9443c01a7336-205276c7067mr39901575ad.5.1725028100118; Fri, 30 Aug 2024
 07:28:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1724846454.git.jerome.forissier@linaro.org>
 <1a6084e845a0612546a1e86d142208af945c8f77.1724846454.git.jerome.forissier@linaro.org>
 <CAC_iWjL9g0c8UHF3L44b8HEG-2=d57XsDXPpSogthWDPgzPcaw@mail.gmail.com>
 <CAFLszTjLmgXO-31CwAOv1qQ9x0aDk4aHGVkScDF1bz-WhfrHGw@mail.gmail.com>
 <CAFLszTgQNatTrhY_PVwN96tbuRvS=PRqawhH93+1TM9y_Mg79Q@mail.gmail.com>
In-Reply-To: <CAFLszTgQNatTrhY_PVwN96tbuRvS=PRqawhH93+1TM9y_Mg79Q@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 30 Aug 2024 17:27:43 +0300
Message-ID: <CAC_iWjLg5h5uPgK0rO04ajGL1z8bpxYAzv3j048hsXAwz22MzQ@mail.gmail.com>
Subject: Re: [PATCH 09/13] net: wget: allow EFI boot
To: Simon Glass <sjg@chromium.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de, 
 Peter Robinson <pbrobinson@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, Marek Vasut <marex@denx.de>
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

Hi Simon

On Fri, 30 Aug 2024 at 17:18, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Jerome,
>
> On Thu, 29 Aug 2024 at 08:04, Simon Glass <sjg@chromium.org> wrote:
> >
> > On Thu, 29 Aug 2024 at 01:34, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > On Wed, 28 Aug 2024 at 15:10, Jerome Forissier
> > > <jerome.forissier@linaro.org> wrote:
> > > >
> > > > wget followed by bootefi currently fails as follows:
> > > >
> > > >  U-Boot> wget 200000 192.168.0.30:helloworld.efi
> > > >  Waiting for Ethernet connection... done.
> > > >  HTTP/1.0 200 OK
> > > >  Packets received 13, Transfer Successful
> > > >  Bytes transferred = 12720 (31b0 hex)
> > > >  U-Boot> bootefi 200000
> > > >  No UEFI binary known at 200000
> > > >  U-Boot>
> > > >
> > > > Fix the problem by adding the missing efi_set_bootdev() call.
> > > >
> > > > Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> > > > ---
> > > >  net/wget.c | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> >
> > OMG the hack never dies. I hope I will someday create a series to tidy this up.
>
> I'm sorry for that remark, not helpful to collaboration.

If you've figured out what needs to be done to remove it, I can deal with it.
If not I'll put it on my backlog and have a look

Thanks
/Ilias
>
> Regards,
> Simon
