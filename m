Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A44C83F27
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 14:05:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 698CA88BB2;
	Thu, 29 Aug 2024 16:05:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XnFjz534";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F0B788B94; Thu, 29 Aug 2024 16:05:10 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81F9D88BB2
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 16:05:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6bf6e17cc2bso3544846d6.1
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 07:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724940307; x=1725545107; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sCWQCedrPT+JLRSX9AF6hQ2rJSqH0upZgH2GA+rdFvM=;
 b=XnFjz5346+0jmMQ2OdLxSh9YZ1PItDuyrb70hfYBipXMl7funDa+TizT/sJ4GrsQ++
 GUHnMyfHh54WcJLiu/jlbnFqvdeqr593DEWLVYJeRlrAoudZ1bQl3JhFMosDtmyv2X9j
 BohHHOhUCuPWVe4YxJCP2srLRTO8O0CJ303xU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724940307; x=1725545107;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sCWQCedrPT+JLRSX9AF6hQ2rJSqH0upZgH2GA+rdFvM=;
 b=snrUraMYAHm0yF5y4/9Kwf7H9PxtMmHtc8AcVlBeofgLxkRHmJGGNwHkMo0mL2yn8e
 hEmO+qWmh7sgZVzGNCTUdYQgr3GjgTp66UTkS7fAWVxZ0e8WMaO0PNFwKDrI0nIp+MRE
 uxzXKiLUfDR5K0859LeaVkyDocsh9NjPYgTqfinWzWXinJ4VHP8jHu1pG7TkD8uPmzRn
 VsF+1+78EEcZFMmuHIO9tB0tZTIjtm4Y+OrSRdhhpQbkmHu00m6LEjLSq2XMBf8GRDb8
 +/me1sfZegzlM3xA3PH7E8GOEhzpKhOUQpAJlGAscjUZVa3/OSDQUTnNdm6CgwZqpzIv
 XLYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyvu5kbStyI8qmlyxvVVmA7rVhavh6fA76o5yxKxqUV/HtkQAAWEnFES1JNwhBv+edoEtch4A=@lists.denx.de
X-Gm-Message-State: AOJu0Yz5SfPbveLIi/Hu7XbD1B8m26liTaOsTG6hTppWP75+ee+1zS9A
 xdfmW6DxIA4WCsz+ij6Fo0kPLDlE2FrMhKjHN8YnjYx1u4EdI6HPtmpQMOYRlxTjgn09QaVc6kd
 QAFyJ/FtvGPBnPmCacKc0gDyDwvpix/Y2fQ3A
X-Google-Smtp-Source: AGHT+IF4doCWw+0U1ftVIOkquNRlERQtzZQXlSPK+l1CW0+gc/4g8xQNGOVvpcw586tWXLecAHOhWdO0Mvw1zBoH38I=
X-Received: by 2002:a05:6214:598f:b0:6bf:8ab9:679d with SMTP id
 6a1803df08f44-6c33e684a6emr34561696d6.44.1724940307227; Thu, 29 Aug 2024
 07:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1724846454.git.jerome.forissier@linaro.org>
 <1a6084e845a0612546a1e86d142208af945c8f77.1724846454.git.jerome.forissier@linaro.org>
 <CAC_iWjL9g0c8UHF3L44b8HEG-2=d57XsDXPpSogthWDPgzPcaw@mail.gmail.com>
In-Reply-To: <CAC_iWjL9g0c8UHF3L44b8HEG-2=d57XsDXPpSogthWDPgzPcaw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 29 Aug 2024 08:04:55 -0600
Message-ID: <CAFLszTjLmgXO-31CwAOv1qQ9x0aDk4aHGVkScDF1bz-WhfrHGw@mail.gmail.com>
Subject: Re: [PATCH 09/13] net: wget: allow EFI boot
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Thu, 29 Aug 2024 at 01:34, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Wed, 28 Aug 2024 at 15:10, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
> >
> > wget followed by bootefi currently fails as follows:
> >
> >  U-Boot> wget 200000 192.168.0.30:helloworld.efi
> >  Waiting for Ethernet connection... done.
> >  HTTP/1.0 200 OK
> >  Packets received 13, Transfer Successful
> >  Bytes transferred = 12720 (31b0 hex)
> >  U-Boot> bootefi 200000
> >  No UEFI binary known at 200000
> >  U-Boot>
> >
> > Fix the problem by adding the missing efi_set_bootdev() call.
> >
> > Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> > ---
> >  net/wget.c | 4 ++++
> >  1 file changed, 4 insertions(+)

OMG the hack never dies. I hope I will someday create a series to tidy this up.

Reviewed-by: Simon Glass <sjg@chromium.org>



> >
> > diff --git a/net/wget.c b/net/wget.c
> > index 0e4dc5159d..cf7681a4e7 100644
> > --- a/net/wget.c
> > +++ b/net/wget.c
> > @@ -8,6 +8,7 @@
> >  #include <command.h>
> >  #include <display_options.h>
> >  #include <env.h>
> > +#include <efi_loader.h>
> >  #include <image.h>
> >  #include <lmb.h>
> >  #include <mapmem.h>
> > @@ -429,6 +430,9 @@ static void wget_handler(uchar *pkt, u16 dport,
> >         case WGET_TRANSFERRED:
> >                 printf("Packets received %d, Transfer Successful\n", packets);
> >                 net_set_state(wget_loop_state);
> > +               efi_set_bootdev("Net", "", image_url,
> > +                               map_sysmem(image_load_addr, 0),
> > +                               net_boot_file_size);
> >                 break;
> >         }
> >  }
> > --
> > 2.40.1
> >
>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
