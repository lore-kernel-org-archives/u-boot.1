Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F41C7113C
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 21:25:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0BEB888D4;
	Wed, 28 Aug 2024 23:25:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TOwDC2Bw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3BC38855C; Wed, 28 Aug 2024 23:25:11 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD45D885C5
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 23:25:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6c331543ef0so10862826d6.1
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 14:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724880308; x=1725485108; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+WdvCXYzp4QDy2ieaLlh1rQ9EokK08w7zTayoDmSTRU=;
 b=TOwDC2BwA1PdTh1cYdONZMIvUEG5Qx0zWWJQaPBJHxknZH418W6eyvE5E1GH0VXZG5
 pTWxK7833PJEflii7Ilf7amGRdQ1eah82A0nNBCug3QtMpSx5MDmulrAcmXwyzpyUNda
 f3itXER5Eb03arTtdMPFKYIfzAKnz0nq+ocag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724880308; x=1725485108;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+WdvCXYzp4QDy2ieaLlh1rQ9EokK08w7zTayoDmSTRU=;
 b=Xw/c9T+DzWx6qinWNcWx66R/jtnMIG8jaD39t0bt7B6fsPv3MwUVe7cn3o6MdazwqP
 AqbKMSVOyBZPGBJCfGhbNPZ5AzSyfGtslr46HlaTfuz0CEJZUOSvcYe+BFdLjzuCzZ2E
 /hcHuM4m285hVUaX3HvkzptgcjVyprrus2dqOU7/pqh/o8pBDrQJ/ywowZHQ0XzoOlXA
 4Qdg1s6OhiqhV63zb0Bf88F5OC7UEOp038NMoIojtEMDBhP7HTEDiEdXsuZoPxveudp5
 JYM4vGLlMndUbufmuu8Ay8/UtZxbZYafMfZQxlMgA/rUZZ8iH5qq+//1rUEY93Ouf5Wl
 caDw==
X-Gm-Message-State: AOJu0Yy/sAPBFfyIGdHgG2Lf9LcOdWeljFUKkETxTbn/2CPhFm/VW3H1
 M/sLm7tW5dMZJeZC1G/eyU8NDYfxFVTndYOu+8bf3Vck36lFaUvTDmSklEVeTdMQ3W1oXuu7vmj
 EamYd7O7Imyx/ahy2gb52AxovTdi1GYVVZ/Jg
X-Google-Smtp-Source: AGHT+IEBdSzQcEeE8zHw33/X4PTguybJvLdem4DQj/NDzOoapse5U39j/eO68l3/kYLwB/IF53MSG4uBljo2eE8yf4g=
X-Received: by 2002:a05:6214:3b84:b0:6bf:5d95:1f31 with SMTP id
 6a1803df08f44-6c33e623041mr9271706d6.19.1724880308564; Wed, 28 Aug 2024
 14:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240828164523.125770-1-sjg@chromium.org>
 <20240828164523.125770-4-sjg@chromium.org>
 <CALeDE9Ptr0Ln4H24yMqxuw1+E_Wt5qBGdQabUH54PaYUTPf9Yg@mail.gmail.com>
In-Reply-To: <CALeDE9Ptr0Ln4H24yMqxuw1+E_Wt5qBGdQabUH54PaYUTPf9Yg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 Aug 2024 15:24:57 -0600
Message-ID: <CAFLszThK_t5EwL28vnzmSp5UZQrSEpBRsaXhnNudMQRe8-7Ejw@mail.gmail.com>
Subject: Re: [u-boot-test-hooks PATCH v4 3/3] Provide some basic scripts for
 Labgrid integration
To: Peter Robinson <pbrobinson@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
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

Hi Peter,

On Wed, 28 Aug 2024 at 12:14, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> Hi Simon,
>
> > With Labgrid we don't need to specify the various methods, except for
> > the console, which simply calls labgrid-client.
> >
> > This allows supporting any boards in your lab, without adding per-board
> > configuration to these hooks.
> >
> > Provide ellesmere files as an example.
>
> What's ellesmere?

It is a lake but also the name of a computer.

>
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v4:
> > - Support pytest fully with dual-build boards like Beagleplay
> >
> > Changes in v3:
> > - Update scripts for latest version of Labgrid integration
> > - Add poweroff.none and poweron.none
> > - Provide -n flag when querying board info
> > - Target the grpc version of Labgrid which is now in -master
> > - Update README to cover the changes
> >
> > Changes in v2:
> > - Make use of the common script (only) to set bin_dir
> >
> >  README.md                    | 50 ++++++++++++++++++++++++++++++++++++
>
> Maybe that should be in a separate labsgrid readme?

My hope is that Labgrid becomes the normal way of running these tests,
so having it in the main place (and perhaps eventually removing the
old way) is my goal.

>
> >  bin/console.labgrid          | 42 ++++++++++++++++++++++++++++++
> >  bin/ellesmere/common-labgrid | 46 +++++++++++++++++++++++++++++++++
> >  bin/ellesmere/conf.all       | 24 +++++++++++++++++
> >  bin/getrole.labgrid          | 25 ++++++++++++++++++
> >  bin/release.labgrid          | 22 ++++++++++++++++
> >  bin/release.none             | 22 ++++++++++++++++
> >  bin/u-boot-test-getrole      | 38 +++++++++++++++++++++++++++
> >  bin/u-boot-test-release      | 26 +++++++++++++++++++
> >  9 files changed, 295 insertions(+)
> >  create mode 100644 bin/console.labgrid
> >  create mode 100755 bin/ellesmere/common-labgrid
> >  create mode 100644 bin/ellesmere/conf.all
> >  create mode 100644 bin/getrole.labgrid
> >  create mode 100644 bin/release.labgrid
> >  create mode 100644 bin/release.none
> >  create mode 100755 bin/u-boot-test-getrole
> >  create mode 100755 bin/u-boot-test-release
> >

[..]

Regards,
Simon
