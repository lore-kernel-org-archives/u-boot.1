Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3786C83030
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 10:43:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29A7D88A99;
	Thu, 29 Aug 2024 12:43:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CXFxSURX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B90BC88B31; Thu, 29 Aug 2024 12:43:27 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 721C2889FF
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 12:43:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5becc379f3fso443520a12.3
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 03:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724928205; x=1725533005; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t3HUIxQdgc8adHb0hYUgrxI6ARA4dQRSHeURQa3DZ1c=;
 b=CXFxSURXNMoAAQbkPFKEQ8DIyWi1LUIfnT23D7AQtb0Tq0ELKPPwXnzQyDBwk8au4Y
 wGe+IyliBdTivgDoSnvN4AFrWe49zVwZjpxcjmgy2t8kvC2ucYPQpB0oFzpOwJEsdmYc
 rRw4WfbkORarVnZkhf1wqqAXs0rL7URJvGdnsRgZ3JN2cN0wi8XtpIkQMlpbpTCcG0mQ
 Hc/tBRg1Wj89O+QA4dgbRe+fknSwKyWUU0c/5MQ+/4aj31K1PAxuu8CGh//0M3AJHZIF
 UzYqT2DMxHKsUxaP2Wzkt2PH5Bc+nZOQJ3w9m3HMrWHyoqhiuNlc/ACAIOrH1enQFgGp
 cWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724928205; x=1725533005;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t3HUIxQdgc8adHb0hYUgrxI6ARA4dQRSHeURQa3DZ1c=;
 b=Inf7kA0fv0+tO81wMxoK+JSS0xbTRBn+KAEXs+iAS0HlFvUddhr/in18jhvZMTSRy4
 IAllY+LVt7CsCCmcRaqk95mTa8gLo7yiFXx8uUNbSexT00pb0DdqJPCsQ0LIC1cdTfxG
 uHckKJxuZwfVKFYbwBRyCbMkzh02myrcA7iqs9ZjPVhfz8QciWwW+5TRtvW8f0kvCy0q
 rgJw21le6zK12eZRSEZPbVkU8LdwDWIoiGh7sQXtwH+dlQXz0kh9TalgndWHS81T1nDq
 asRJMqU5aKA20iq4x0jBad+4PJYzRInEfffqDme5VdJiNE0iZe5txDrhwN/fhOcytowJ
 +zbA==
X-Gm-Message-State: AOJu0Yxu5CIiFHrhG8VTwE406pfxY2P2eKHWvuBaG9cRkCj+vsWQ3kso
 bTWX+vRET56MQ3g70K8RLtaZdKubjuQANOZNNtNfYraZkxQn1/wfdTG3IRoXLh9/Fs/mOHrNG8a
 V/3gSEOS5Tc/DZJ/ncKjI7iKn45I=
X-Google-Smtp-Source: AGHT+IFhMGgs0ZISiobb7hO0olWk5HLmK9xtRsFGwd5RF91swCMAdM3RFLW7dfqKvdPmLuAOdsbT4tXvDfUGI+mnYj4=
X-Received: by 2002:a05:6402:4308:b0:5c0:8c5a:f4f3 with SMTP id
 4fb4d7f45d1cf-5c21ed8699emr1854360a12.26.1724928204233; Thu, 29 Aug 2024
 03:43:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240828164523.125770-1-sjg@chromium.org>
 <20240828164523.125770-4-sjg@chromium.org>
 <CALeDE9Ptr0Ln4H24yMqxuw1+E_Wt5qBGdQabUH54PaYUTPf9Yg@mail.gmail.com>
 <CAFLszThK_t5EwL28vnzmSp5UZQrSEpBRsaXhnNudMQRe8-7Ejw@mail.gmail.com>
In-Reply-To: <CAFLszThK_t5EwL28vnzmSp5UZQrSEpBRsaXhnNudMQRe8-7Ejw@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 29 Aug 2024 11:43:12 +0100
Message-ID: <CALeDE9O-kmnqkosThf8xQpLZ2tEebiHvrUEzVJNDjiEff2-t2Q@mail.gmail.com>
Subject: Re: [u-boot-test-hooks PATCH v4 3/3] Provide some basic scripts for
 Labgrid integration
To: Simon Glass <sjg@chromium.org>
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

On Wed, 28 Aug 2024 at 22:25, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Peter,
>
> On Wed, 28 Aug 2024 at 12:14, Peter Robinson <pbrobinson@gmail.com> wrote:
> >
> > Hi Simon,
> >
> > > With Labgrid we don't need to specify the various methods, except for
> > > the console, which simply calls labgrid-client.
> > >
> > > This allows supporting any boards in your lab, without adding per-board
> > > configuration to these hooks.
> > >
> > > Provide ellesmere files as an example.
> >
> > What's ellesmere?
>
> It is a lake but also the name of a computer.
>
> >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > Changes in v4:
> > > - Support pytest fully with dual-build boards like Beagleplay
> > >
> > > Changes in v3:
> > > - Update scripts for latest version of Labgrid integration
> > > - Add poweroff.none and poweron.none
> > > - Provide -n flag when querying board info
> > > - Target the grpc version of Labgrid which is now in -master
> > > - Update README to cover the changes
> > >
> > > Changes in v2:
> > > - Make use of the common script (only) to set bin_dir
> > >
> > >  README.md                    | 50 ++++++++++++++++++++++++++++++++++++
> >
> > Maybe that should be in a separate labsgrid readme?
>
> My hope is that Labgrid becomes the normal way of running these tests,

Generally I agree with automated testing platforms, I think <insert
you're preferred platform here> makes sense, there's a bunch like
Linaro and a bunch in the arm ecosystem use LAVA [1] and  there's a
bunch more that I'm aware of.

Does it make sense, of course at some point in the future post this
being merged, make sense to look at a general way of making it easier
to plugin these sort of HW test platforms using this as a basis? I ask
mostly because putting a bunch of my devices into some sort of
platform can auto test things and of course everyone has an opinion to
which is the best one :-P

[1] https://validation.linaro.org/

> so having it in the main place (and perhaps eventually removing the
> old way) is my goal.
>
> >
> > >  bin/console.labgrid          | 42 ++++++++++++++++++++++++++++++
> > >  bin/ellesmere/common-labgrid | 46 +++++++++++++++++++++++++++++++++
> > >  bin/ellesmere/conf.all       | 24 +++++++++++++++++
> > >  bin/getrole.labgrid          | 25 ++++++++++++++++++
> > >  bin/release.labgrid          | 22 ++++++++++++++++
> > >  bin/release.none             | 22 ++++++++++++++++
> > >  bin/u-boot-test-getrole      | 38 +++++++++++++++++++++++++++
> > >  bin/u-boot-test-release      | 26 +++++++++++++++++++
> > >  9 files changed, 295 insertions(+)
> > >  create mode 100644 bin/console.labgrid
> > >  create mode 100755 bin/ellesmere/common-labgrid
> > >  create mode 100644 bin/ellesmere/conf.all
> > >  create mode 100644 bin/getrole.labgrid
> > >  create mode 100644 bin/release.labgrid
> > >  create mode 100644 bin/release.none
> > >  create mode 100755 bin/u-boot-test-getrole
> > >  create mode 100755 bin/u-boot-test-release
> > >
>
> [..]
>
> Regards,
> Simon
