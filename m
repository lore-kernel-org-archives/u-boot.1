Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C61AC2BB3F
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 02:35:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C7468704F;
	Thu, 16 Nov 2023 03:35:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m44zGes5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15A608725C; Thu, 16 Nov 2023 03:35:41 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7FF086F85
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 03:35:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9dbb3e0ff65so45160166b.1
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 18:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700102138; x=1700706938; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ybxn/ZOnN/oGgFk4httkcON+kg5XRm5XAgf0hBpU/2U=;
 b=m44zGes5lyNI5DuHc0HIe2ux9JGQWZjB4O3xk8PgIyoV3RzzF4BMb35XTVZ7eNPNBU
 hZTkRQ6yMDR9CKWb9FEBIZ9W5Uc0C2jm2VHq0SY/zeAPYFPCVRC7cCCdgQh7hhlYzGEx
 qagiX4qrh7wPg8MjdInO1AREXBY1yigeba8L4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700102138; x=1700706938;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ybxn/ZOnN/oGgFk4httkcON+kg5XRm5XAgf0hBpU/2U=;
 b=T1XU9R6D8Nosr10pJeGQnAhD+sWY702vsIR0hOhNbyMKvedWnHF1RCWTvGhcdrz+jp
 FThzwgRNKG7HM31KYd/NYRDlpJNyCpvLiW9BF4YFK9a3gS0OqarvFrbPREbGAnEKUF3T
 5RelSd3I4+CVfJpwhXwBJHfduYabtpa4fVsHBAHb6BFxTpQm+rBJHATfM9MZeW4XpAfi
 5w2hJ26EE1GecFIu0qqHfNEcf2FAguvDSB6BsrKFmp2/iNlivHhWT3r8h3jtOzrDprY0
 FGyG1h0hvwcEFeU43ZbEzmHe+SM9D2p8mNu/yrf4zQ780FDz02FgAEZuQhf2CYZNS9fN
 6pIg==
X-Gm-Message-State: AOJu0YxVKZdXvKqtdm5/8Hhof8an16xJr/gaK2lYF632Ph45Fa7F7ASw
 7WUo1YbcwHpdCH5+ogmQt1aEpmUm23erK0cjyPuBEsqnK9G26qyjoq0=
X-Google-Smtp-Source: AGHT+IGZbFz/ml1xJ1Q4zKhxU9ni6lFK/b6hkbgG/NwNnMoRh2Rx7xiW79iK+4Wzt7Wgzbb5UiQTjEF9HIFgFRJZZe8=
X-Received: by 2002:a17:906:480b:b0:9e7:2d0b:8c46 with SMTP id
 w11-20020a170906480b00b009e72d0b8c46mr13178139ejq.50.1700102138034; Wed, 15
 Nov 2023 18:35:38 -0800 (PST)
MIME-Version: 1.0
References: <20231112000923.73568-1-sjg@chromium.org>
 <20231112000923.73568-28-sjg@chromium.org>
 <20231115223800.GE6601@bill-the-cat>
 <CAPnjgZ379WFHcrVUYPTGZqhUvA95aaDKdfiqNGBOXt4hBrWrKQ@mail.gmail.com>
 <20231116014707.GI6601@bill-the-cat>
 <CAPnjgZ1v+ciAZGKgkgF3M1tzTdpFEMLJfj-xVQMLWpdmgYPzAw@mail.gmail.com>
 <20231116020710.GJ6601@bill-the-cat>
In-Reply-To: <20231116020710.GJ6601@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 15 Nov 2023 19:35:26 -0700
Message-ID: <CAPnjgZ3WPfg2Jt_a9besSQEZT8nCPV151s1AN7t-_pVyErFjVw@mail.gmail.com>
Subject: Re: [PATCH 27/29] bootm: Adjust the parameters of bootm_find_images()
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Eddie James <eajames@linux.ibm.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
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

On Wed, 15 Nov 2023 at 19:07, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Nov 15, 2023 at 06:56:33PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 15 Nov 2023 at 18:47, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Nov 15, 2023 at 06:42:19PM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Wed, 15 Nov 2023 at 15:38, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sat, Nov 11, 2023 at 05:09:12PM -0700, Simon Glass wrote:
> > > > >
> > > > > > Rather than passing it all the command-line args, pass in the pieces
> > > > > > that it needs. These are the image address, the ramdisk address/name
> > > > > > and the FDT address/name.
> > > > > >
> > > > > > Ultimately this will allow usage of this function without being called
> > > > > > from the command line.
> > > > >
> > > > > OK, so this goal is good.
> > > > >
> > > > > [snip]
> > > > > > +             return bootm_find_images(img_addr, argc > 1 ? argv[1] : NULL,
> > > > > > +                                      argc > 2 ? argv[2] : NULL, 0, 0);
> > > > >
> > > > > That we repeat this much harder to read test/if/else three times now is
> > > > > less good.  Can we find some way to hide the complexity here in the case
> > > > > where it's coming from a command and so we have argc/argv[] ?
> > > >
> > > > I can't really think of one. Ultimately this is coming from the fact
> > > > that the booti and bootz commands directly call bootm_find_images(). I
> > > > haven't got far enough to know whether that will still be true in the
> > > > end, but I hope not.
> > > >
> > > > IMO the correct place for the logic above is in the command-processing
> > > > code, where it decides which arg means what.
> > > >
> > > > I could imagine something like:
> > > >
> > > > static const char *cmd_get_arg(int argc, char *const argv[], int argnum)
> > > > {
> > > >    return argc > argnum ? argv[argnum] : NULL;
> > > > }
> > > >
> > > > but I'm not sure that is an improvement.
> > >
> > > I was thinking about this more after I sent this. And I think we might
> > > indeed want an inline / macro to handle this case more generally as I
> > > suspect we'll have similar cases where we need argN-or-NULL as we
> > > refactor other areas of code to split "here is the command" from "here
> > > is the library functionality" of it. Then we'll have:
> > > ulong foo = cmd_arg_one(argc, argv);
> > > ulong bar = cmd_arg_two(argc, argv);
> > >
> > > librarycall(foo, bar, ...);
> >
> > OK I can try something. But note that the one, two terminology becomes
> > confusing. Is the first argument zero or one? Also we often drop an
> > argument in a subcommand to allow things to start from 0 again.
> >
> > It might be better to use first and second, instead?
>
> Yes, please come up with a better naming scheme, I'm terrible about
> stuff like that.

Actually my naming has problems too...hopefully this has been solved
properly elsewhere and someone will reply to my patch.

Regards,
Simon
