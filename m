Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A413C5ACB2
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 01:43:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC4EF87498;
	Thu, 16 Nov 2023 02:43:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UEI6EQPh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43A4087448; Thu, 16 Nov 2023 02:43:22 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D89387045
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 02:42:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5b499b18b28so3087927b3.0
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 17:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700098953; x=1700703753; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zEgSoBuUt+hK0ABePAcl8OSHsWnOD+Z049zJGLzmVsg=;
 b=UEI6EQPhJHBcz0rmchvibYS+OeWx5/KzD/EMGqTJr5JcSPXj49uBaroy/MBQiA5KcK
 kSDz9Is2QEVJbDHNDj7btdLr6C18i9gVFC0bRlawdxFXUmqacRcDSKrbiP16VtGaJ+l0
 u2iPpETWc04LjmF0vnJWTsAEiQjDDvjAiHfnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700098953; x=1700703753;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zEgSoBuUt+hK0ABePAcl8OSHsWnOD+Z049zJGLzmVsg=;
 b=BiWm7FZzOQAwwdZRwiuBePhMKLXA3emtDwTwo4o583jEyclv8nLILVx2IiLcdUQih5
 tjp2+bwQxcp31uiKWFNO14ERnklwhwknuwE8qS8Up5MwI3kOPy2nHb2bk9WXQFBoOa8l
 4v0zkbaGMIa9MVQ5n6R5ILkJPWejK/c3r+65MqCX65cZrHru285X8DdMXPPujZ1MT/fu
 5k/yEn4x1JVM6aEidiTTmfN5b9rNdQFgkfrS0uGKxFxaJoY12H0SeVCvB+JSY5ZkYN1e
 z/PDQ6dIwnAhK3YMUsqe8OFzj0epRsScnKCkapYGu7mDhlogU6fYiZe11B9Bns+4jYjG
 bprA==
X-Gm-Message-State: AOJu0YyeaEgElejtKewpYj5WmTt5KFqRxCgDdShApUw3kCpQoaq+itg3
 hpuKDOPxQ9ys4VPWWzvadTdkGLrvW1ggxXQs0EEJyQ==
X-Google-Smtp-Source: AGHT+IGg4xvzXCF8Ggk2Azkgf7eX85eYtHhkTm1ZSPE40iAfdMDEWDRX6J/sL09tfC1/iS+egqaVnbVpInH7d641UUY=
X-Received: by 2002:a05:690c:4683:b0:5c1:47f2:6e05 with SMTP id
 gx3-20020a05690c468300b005c147f26e05mr12559104ywb.9.1700098952766; Wed, 15
 Nov 2023 17:42:32 -0800 (PST)
MIME-Version: 1.0
References: <20231112000923.73568-1-sjg@chromium.org>
 <20231112000923.73568-28-sjg@chromium.org>
 <20231115223800.GE6601@bill-the-cat>
In-Reply-To: <20231115223800.GE6601@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 15 Nov 2023 18:42:19 -0700
Message-ID: <CAPnjgZ379WFHcrVUYPTGZqhUvA95aaDKdfiqNGBOXt4hBrWrKQ@mail.gmail.com>
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

On Wed, 15 Nov 2023 at 15:38, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Nov 11, 2023 at 05:09:12PM -0700, Simon Glass wrote:
>
> > Rather than passing it all the command-line args, pass in the pieces
> > that it needs. These are the image address, the ramdisk address/name
> > and the FDT address/name.
> >
> > Ultimately this will allow usage of this function without being called
> > from the command line.
>
> OK, so this goal is good.
>
> [snip]
> > +             return bootm_find_images(img_addr, argc > 1 ? argv[1] : NULL,
> > +                                      argc > 2 ? argv[2] : NULL, 0, 0);
>
> That we repeat this much harder to read test/if/else three times now is
> less good.  Can we find some way to hide the complexity here in the case
> where it's coming from a command and so we have argc/argv[] ?

I can't really think of one. Ultimately this is coming from the fact
that the booti and bootz commands directly call bootm_find_images(). I
haven't got far enough to know whether that will still be true in the
end, but I hope not.

IMO the correct place for the logic above is in the command-processing
code, where it decides which arg means what.

I could imagine something like:

static const char *cmd_get_arg(int argc, char *const argv[], int argnum)
{
   return argc > argnum ? argv[argnum] : NULL;
}

but I'm not sure that is an improvement.

I have got a little further (15 more patches) and have added a 'struct
bootm_info' to hold the state of the boot, including the arguments for
the FIT address, ramdisk and fdt. But even then, the args will need to
be set up by the individual commands based on their syntax.

Regards,
Simon
