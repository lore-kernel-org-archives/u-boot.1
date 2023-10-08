Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D139E95A67
	for <u-boot@archiver.kernel.org>; Sun,  8 Oct 2023 21:55:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE0B486D60;
	Sun,  8 Oct 2023 23:55:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y56qkqQz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8653D86587; Sun,  8 Oct 2023 23:55:08 +0200 (CEST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EFE686DB0
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 23:55:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=benwolsieffer@gmail.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-419787a43ebso25974471cf.1
 for <u-boot@lists.denx.de>; Sun, 08 Oct 2023 14:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696802104; x=1697406904; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SM1TW6mH29YouGRYdpqt0KMcPhpFC+Ym2zseEo6S4Rs=;
 b=Y56qkqQzoBg6rEQL9cIwhX7F/ZMMnFlwH7ZJJfuxGBHefztEZY6dNPYbU0nwukyWOm
 X9X15CAvokOzz6ZMwgzLfv5/tNbapaaRG+XMTDI+69Xdo7WClZsnNFnXcpVgxRrG+GqP
 5XK2EP6hJO7c39LW+i94cHP0TuLrJJjnFeQl3bfYXTsLPyAOqSqKtj1ON7GM2BzwFOr1
 gAMs4nz4J1mOHNqiDPCFg0D5MocgVPnwyEsE7x9pNBRcdLlY7jMM4eVZnm4HJ6XpL7Qq
 XZ6pFGdruTTxDULgIJf8lHQFdwaQR96ObRN+FhoOlCbiiyKOhVPizPTVbGk7GGMHby8z
 0qBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696802104; x=1697406904;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SM1TW6mH29YouGRYdpqt0KMcPhpFC+Ym2zseEo6S4Rs=;
 b=ilvNqKQYVrwrEXF+vEyITCk2QOGX8P08LrfD/4COUbvOOZIgRYQC0/K5udeKC5N6Vw
 2Hitl5b6umlQRdGSUTP5Cj4z62jxqxIiRn9Lcom2BzZg2KvdCsR9TzhbxksoB+VBAFQA
 cL+jn8RiJTo4jawMBisbSLvC7MUVCU6o/hviigmQdBE+yvIBFPm2LTAxrjBDnF73azfw
 TzadtS1r/z2UeLxzqmg3KlfBDm+08vQijb3akIFs6Jn0FthYrSrjsRYOKR2IwPLW+ATr
 8drASTyCIVxYWn488zMXTG8dSuN9EExaTSGalaTYCFXEfzHUagcaElNlpKjoU2gUOLHe
 GC5Q==
X-Gm-Message-State: AOJu0YxRc9wjEt7IGwU2vtJxJBAwqCTTJ+KWvQGnUQmvs4TZ6Kjpru+p
 H5OUaSLQMjNlh6SyOZ7qTHQ=
X-Google-Smtp-Source: AGHT+IGL77bqsk9cqYJtd8wT/77p6/WJH73197HVaJi9L/X1bccbbWgOpWOEExxTKOa9Pkj1LLKe/w==
X-Received: by 2002:ac8:5746:0:b0:419:573c:59a3 with SMTP id
 6-20020ac85746000000b00419573c59a3mr18433419qtx.19.1696802104073; 
 Sun, 08 Oct 2023 14:55:04 -0700 (PDT)
Received: from Dell-Inspiron-15 ([2601:18c:8002:3d40:7920:e10c:26cf:ff86])
 by smtp.gmail.com with ESMTPSA id
 lf7-20020a0562142cc700b0065d0d0c752csm3310140qvb.116.2023.10.08.14.55.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Oct 2023 14:55:03 -0700 (PDT)
Date: Sun, 8 Oct 2023 17:55:01 -0400
From: Ben Wolsieffer <benwolsieffer@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH] arm: rpi: explicitly enumerate mmc boot targets
Message-ID: <ZSMlNWJ9f7HkoaNg@Dell-Inspiron-15>
References: <20231007155535.1699567-1-benwolsieffer@gmail.com>
 <CAPnjgZ0qrDB_+HUNdGeCzS2FS4+fb1x9Cyr7xTjGccLCHpxwWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPnjgZ0qrDB_+HUNdGeCzS2FS4+fb1x9Cyr7xTjGccLCHpxwWg@mail.gmail.com>
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

Hi Simon,

On Sat, Oct 07, 2023 at 02:18:48PM -0600, Simon Glass wrote:
> Hi Ben,
> 
> On Sat, 7 Oct 2023 at 09:55, Ben Wolsieffer <benwolsieffer@gmail.com> wrote:
> >
> > Using the unqualified "mmc" boot target causes the Raspberry Pi 4 to
> > fail to boot. c771e5b explains this approach as follows:
> >
> > > We don't need to specify the mmc devices individually, since they are
> > > used in order from 0 to 2, and standard boot uses that order anyway.
> >
> > In practice, U-Boot first attempts to boot from the unconnected mmc1
> > interface, and, when this fails, moves on to attempt the USB and network
> > boot targets rather than trying mmc0.
> >
> > This patch explicitly enumerates the mmc interfaces, causing each to be
> > attempted in turn. This matches what is done on other boards, and allows
> > the system to boot successfully.
> >
> > Fixes: c771e5b8c2 ("arm: rpi: Switch to standard boot")
> > Signed-off-by: Ben Wolsieffer <benwolsieffer@gmail.com>
> > ---
> >  board/raspberrypi/rpi/rpi.env | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> 
> Does this patch help? [1]. Alternatively, if you just remove that
> variable entirely, does it do the right thing?

Yes, trying either of those suggestions makes it work correctly.

> 
> Regards,
> Simon
> 
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20230923205017.1754340-1-sjg@chromium.org/


Thanks, Ben
