Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43B1E7718B
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 17:37:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7558803CB;
	Fri, 20 Dec 2024 18:37:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YN9M1+Bd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4309180381; Fri, 20 Dec 2024 18:37:33 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3278780381
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 18:37:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5d7e527becaso3318689a12.3
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 09:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734716251; x=1735321051; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wr35m766ncsTmurHjnWWXnBXyq6LksMETRrVp20JWCM=;
 b=YN9M1+BdO0yttAsWaJqprpBf66kEoh+ZYYoVLpOzi4DVq6ycXd6xEPMueE9MDzIICT
 hTWHGgrLNcIFkpA3QlHY7NwxUCWSYutCiSCkTfR2IXdYyx0bgMI4eAVw6H7ui7Sb2V2+
 ntkYlPujyIR5D60bwS57mMfy3auI6/hDAVGR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734716251; x=1735321051;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wr35m766ncsTmurHjnWWXnBXyq6LksMETRrVp20JWCM=;
 b=nOacAPVgRPFZgOFKJsYP+gsuhyOo/NYSc90Fk8GqBuFZYmGdrKGoqt28/Ia1X8PamT
 ekY7goyC7x88rLT6/m52slZjXZIc3K41Oc1M1O38guppRkRRrUKmYuI19/btNWKkmqqo
 Sww/nuTt0EvKWSbpveGqL6uTOIqYXAneF46eYSsufFLRLd6lPpXfSqrb9T+BQtoZLUWb
 Hgt9MeSSVJ1o8Aybge6pYRP+ZPgPZWMVDTk+W2LzJNesqd0Iu/U6C5AgK12EhKEy+V3L
 qquHAI7C1L/FoUXfnzdw1ZiyxXP7v3hiSlB4kRR2q2q5NcNu6dbbEvcLx7pYZKZuGXVX
 jV8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQ1IHFBxqSSbu+Ga2GUgQRODNTS9UaLhyehWQpo/oxArutChjn4zqUQpYhDOwH4B/Pbga2E0Q=@lists.denx.de
X-Gm-Message-State: AOJu0Yyzi8377SfzvH4opqBm9sdlFWMX6kA5/3fP/7IvLK9SHSacajxd
 U6WZgycPFg0bSR6ZCoA/TPsLnWy2RWFGovF4512yz1TdMOjYrnNNvbl2jjbHItrFg8fml8w7WCI
 ENnk9aovcTHdeoyH5fH/WDnOhTIzx2oqD7FOe
X-Gm-Gg: ASbGncsBAd5wYNmKVqfBRdMVytQBDRFOe7XYX6orKQRShgbh1Fq4VmATtNtT9HN2g54
 OqPfPfl8ghLJ6tPKxCgqlcmFAXJoyDK27Op3U1CQ=
X-Google-Smtp-Source: AGHT+IFJvShhw0vIwbYSBt8Lq4ri0k1XHHjr+fxopjl0bK354GN+64nQBfHZH7jDMPkO7+26dDc0v0ebo3yPmciLjKY=
X-Received: by 2002:a05:6402:3884:b0:5d3:ff93:f5f9 with SMTP id
 4fb4d7f45d1cf-5d81ddd625dmr7572607a12.20.1734716250671; Fri, 20 Dec 2024
 09:37:30 -0800 (PST)
MIME-Version: 1.0
References: <20241202-sandbox_repair_of_embed-v1-0-05aff4b0ccf7@salutedevices.com>
 <20241202-sandbox_repair_of_embed-v1-4-05aff4b0ccf7@salutedevices.com>
 <CAFLszTisVG9Jn-Zi9F6VUERmecn=g=x6EwaNQORS+yiaCRBJRQ@mail.gmail.com>
 <gzsr5konsq4iyxakbmcengqglrgoawu7kxf6mvtfmidpvz5xan@akuwzh3fe4pj>
In-Reply-To: <gzsr5konsq4iyxakbmcengqglrgoawu7kxf6mvtfmidpvz5xan@akuwzh3fe4pj>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Dec 2024 10:37:12 -0700
Message-ID: <CAFLszTi6KbuyJWPegwc3PFH15fVf80O-5xjCJnfXKp8s7QQMug@mail.gmail.com>
Subject: Re: [PATCH 4/5] test: sandbox: fix link error with do_ut_bootm if
 BLOBLIST=n
To: Evgeny Bachinin <eabachinin@salutedevices.com>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Levi Yun <yeoreum.yun@arm.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>, kernel@salutedevices.com,
 evgen89bachinin@gmail.com, u-boot@lists.denx.de
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

Hi Evgeny,

On Tue, 17 Dec 2024 at 02:11, Evgeny Bachinin
<eabachinin@salutedevices.com> wrote:
>
>
> Hi, Simon. See below, please
>
> On Fri, Dec 06, 2024 at 08:31:22AM -0700, Simon Glass wrote:
> > Hi Evgeny,
> >
> > On Mon, 2 Dec 2024 at 06:46, Evgeny Bachinin
> > <EABachinin@salutedevices.com> wrote:
> > >
> > > Having CONFIG_OF_EMBED=y && CONFIG_BLOBLIST=n leads to the link
> > > error:
> > > ```
> > > ld: /tmp/ccwtRVty.ltrans28.ltrans.o:(.data.rel+0x4e8): undefined \
> > >                                             reference to `do_ut_bootm'
> >
> > Are you sure? I don't see that one. The bootm test should not relate
> > to bloblist.
>
>
> I've double checked - reproduced on v2024.10. There we had in
> test/Makefile:
>   ```
>   ifneq ($(CONFIG_$(SPL_)BLOBLIST),)
>   obj-$(CONFIG_$(SPL_)CMDLINE) += bootm.o
>   endif
>   ```
> So do_ut_bootm()  was not built if BLOBLIST=n
>
> We do not see "undefined reference to `do_ut_bootm'" on v2025.01-rc3
> due to this patch:
>   7f8b8c5abc2 ("bootm: test: Move test into boot")
>   It made bootm.o dependant on CONFIG_SANDBOX and independent from
>   BLOBLIST.
>
> And because aforementioned patch fixes the issue, I'm going to get rid
> of this current patch.
>
>
> > This is what I see:
> >
> > buildman  -a OF_EMBED -a ~BLOBLIST --bo sandbox
> > Building current source for 1 boards (1 thread, 32 jobs per thread)
> >    sandbox:  +   sandbox
> > +===================== WARNING ======================
> > +CONFIG_OF_EMBED is enabled. This option should only
> > +be used for debugging purposes. Please use
> > +CONFIG_OF_SEPARATE for boards in mainline.
> > +See doc/develop/devicetree/control.rst for more info.
> > +====================================================
> > +
> > +Some CONFIG adjustments did not take effect. This may be because
> > +the request CONFIGs do not exist or conflict with others.
> > +Failed adjustments:
> > +~BLOBLIST             CONFIG_BLOBLIST=y
>
> Just a side note:
> I am not familiar with buildman yet, but it seems, it can not set up
> CONFIG_BLOBLIST=n because BLOBLIST is selected by 'select'.

That's right.

>
> JFYI, I'm going to extend the patch series by new patch to make BLOBLIST
> selectable from menuconfig for sandbox via 'imply'.

OK good.

>
>
> >     0    0    1 /1              sandbox
> > Completed: 1 total built, 1 newly), duration 0:00:11, rate 0.09
> >
> >
> > > ```
> > >
> > > Fixes: fe158657a5b ("test: inconsistent bootm tests")
> > > Signed-off-by: Evgeny Bachinin <EABachinin@salutedevices.com>
> > > ---
> > >  test/cmd_ut.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/test/cmd_ut.c b/test/cmd_ut.c
> > > index 842c2c3e7f65eb9fe017fa1949eb2390be171487..a14dbf4ca5e571a872585ff11bfe7adae3f4edf3 100644
> > > --- a/test/cmd_ut.c
> > > +++ b/test/cmd_ut.c
> > > @@ -107,9 +107,9 @@ static struct cmd_tbl cmd_ut_sub[] = {
> > >  #if CONFIG_IS_ENABLED(BLOBLIST)
> > >         U_BOOT_CMD_MKENT(bloblist, CONFIG_SYS_MAXARGS, 1, do_ut_bloblist,
> > >                          "", ""),
> > > -#endif
> > >         U_BOOT_CMD_MKENT(bootm, CONFIG_SYS_MAXARGS, 1, do_ut_bootm, "", ""),
> > >  #endif
> > > +#endif
> > >  #ifdef CONFIG_CMD_ADDRMAP
> > >         U_BOOT_CMD_MKENT(addrmap, CONFIG_SYS_MAXARGS, 1, do_ut_addrmap, "", ""),
> > >  #endif
> > >
> > > --
> > > 2.34.1
> > >
> >
> > Regards,
> > SImon
> >
>
> --
> Best Regards,
> Evgeny Bachinin

Regards,
Simon
