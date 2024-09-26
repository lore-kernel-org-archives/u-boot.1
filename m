Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBA3CDE038
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 21:36:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32A7788EE8;
	Thu, 26 Sep 2024 23:36:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LJa1UeXe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F37D088EE4; Thu, 26 Sep 2024 23:36:31 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB40788EE8
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 23:36:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6cb2458774dso9631096d6.3
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 14:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727386588; x=1727991388; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wCXYyM/+/5xUBew91tJaMjtSI1SqU0ew4w353g67kVA=;
 b=LJa1UeXetwSq7eazU+rGaqB28v/mXTZToYuBhOvv3Pdm6zM89/esXNTP7eeD9vBJ5U
 DszMQ2v3nYt9+wIA2jvEZ0C/FwbM0fVHcd6T8MMKGWjYrqIWnBiHltbx2Lohv1urVgfB
 pQ501446cYwHdj6KkwSxNog9Qfbxnsa8ExyEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727386588; x=1727991388;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wCXYyM/+/5xUBew91tJaMjtSI1SqU0ew4w353g67kVA=;
 b=REOFg1RjGamZzexPgCW8sZ8nnnK8YoEbzrDyiqvJPJQhe05CME4ee0x+eTZ9OFAPXd
 4tMNgb9jylACoTJKLXFeBO+8Op2WAEXhZo+H14BwVjyNgA7n+4hOGTPRiDyOqFwaMCGc
 Zpxjkf6uvBF+U4xscV0WjBThUYTeNdajexNOhx6FHf0zwCtuMRHCP34vRT31hnWhgMHx
 GYHjH6w5SQ3TsCwmwIr1Xzs1CTdQYW7OrX3LV4zv9Mov0e5Ki5HCkJuFmPAenx1UB7Zd
 PKJMm/h6xZIhVd9ZIYFUEoEOpG/NQxfL7LKdqbx3Ghtm1wh3veaDWqlsFpYNYGQPH0W5
 IQpg==
X-Gm-Message-State: AOJu0Yy0s7XCIci+TuDNm6bz+YP+LiE9GBq73ucrycX3hOWillWy8ZAW
 hFSydvKKEwzfMrR94yA0cnzj5FdDqbYAyVDOFGQeTqEmTCDIMc1romKAMwCx+DHomkmHIng0AIr
 SfBTq/XhUoxtoNaA8TNoDsYXIYGKnl9vtdpjg
X-Google-Smtp-Source: AGHT+IGImaRecE0ViVpGkPVi4KVJb49MIkGg/SV0mWeasgshJ0HoGSjdCOISoCBFcUB0nDsHPzPPTBvbOCJnrvO7x6Y=
X-Received: by 2002:a05:6214:2f0f:b0:6cb:f8a:ba8a with SMTP id
 6a1803df08f44-6cb3b5f701cmr19872346d6.25.1727386588608; Thu, 26 Sep 2024
 14:36:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240925125622.197915-1-sjg@chromium.org>
 <20240925125622.197915-2-sjg@chromium.org>
 <20240926040636.GF4252@bill-the-cat>
In-Reply-To: <20240926040636.GF4252@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 26 Sep 2024 23:36:17 +0200
Message-ID: <CAFLszTjtW8hBpYMTUXZKALPUuC=4QE8=DQLgOn52XEmj6qg7ng@mail.gmail.com>
Subject: Re: [PATCH 01/19] spl: Reduce the size of the bl_len field
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>
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

On Thu, 26 Sept 2024 at 06:06, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Sep 25, 2024 at 02:55:27PM +0200, Simon Glass wrote:
>
> > This is a block length, so typicaly 512 bytes. Reduce the size to
> > 16 bits to save space, before more fields are added in future work.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  include/spl.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> I don't think this works as intended:
> 02: spl: Reduce the size of the bl_len field
>        arm: (for 1/1 boards) spl/u-boot-spl:all +8.0 spl/u-boot-spl:text +8.0
>             chiliboard     : spl/u-boot-spl:all +8 spl/u-boot-spl:text +8
>                spl-u-boot-spl: add: 0/0, grow: 2/0 bytes: 8/0 (8)
>                  function                                   old     new   delta
>                  spl_nand_load_image                         60      64      +4
>                  spl_mmc_load                               320     324      +4

Yes, unfortunately some ARM devices need more code to access a 16-bit
value. Perhaps this optimisation is not worth it?

Regards,
Simon
