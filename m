Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8321CC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 13:41:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 734D287A97;
	Thu, 28 Dec 2023 14:38:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WEy5VxEX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4005187A84; Thu, 28 Dec 2023 14:38:42 +0100 (CET)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D9B0879FF
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 14:38:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5ce10b5ee01so2004177a12.1
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 05:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703770718; x=1704375518; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V+QB4Tq7U8vBmSaCahkz/Qt7T5LRdB4+1kYiD9wYVQs=;
 b=WEy5VxEXhxOBahW74h55W2XgOieYkBkEbN4EWdQ75VvO0SL1FedJ/7PKNjNsMXZv/2
 CxYSqMkcP43I1Ft/YtuPbwGRFWAPjEyKjxkaBwOLeTNLKy/E1Ho6sGR2TGvwfEEV0Xmp
 bVnfbvPAZPLpin3UtIR/eahAFk/hiLoKEbwck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703770718; x=1704375518;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V+QB4Tq7U8vBmSaCahkz/Qt7T5LRdB4+1kYiD9wYVQs=;
 b=iRC52PYJ9x5dAci3GuURJyeEkqQgt9aIZYIh+b2cMLqw3WutbrvRBUhsj1xtSrZ/o6
 ayfa6hV3KC2kykcAi4FNBWDpUUyzebaThR9SARPqQ2x+hzSootuztPI77n4M6xxzjAuT
 y0xT3xs3tFoGe+8p6SIR/FGljAt6O7mBjXpfANDAPaiebIGHZVEPTbSr+cTf/JKZMJ/z
 vZj1/OAYpmNBH8TVgHkIYqPnzNOHgu70wnQ69jTetgshFHm6fKBivxvOhRBDHHaKTD/z
 9FJ2YduC6vxfedzWf1vmBP+O1CnRE4l9OMLT/l3yZZ4Ehrd5VJyzVd7+WOujuu6TYk1I
 OZzQ==
X-Gm-Message-State: AOJu0YzFKNYW0HRr9fB8Asg5hQQMD/qoAKBgZeL5S5OaGRfHykNCiXB7
 D/7euiR3h2ELt5CH0tpW9QwvJdpdIKPMIf8F9db3uvdpMOzZ
X-Google-Smtp-Source: AGHT+IFuR8fE9/JUG3nd3DmtvZbt500tUnDINwg60YEG+6jc5D5jWKsTrMGQhozJgdym/wXySRT/qgaSYFiyUi2wVnc=
X-Received: by 2002:a17:90a:ff84:b0:28c:6463:aa37 with SMTP id
 hf4-20020a17090aff8400b0028c6463aa37mr6795632pjb.46.1703770718567; Thu, 28
 Dec 2023 05:38:38 -0800 (PST)
MIME-Version: 1.0
References: <20231227082405.2202246-1-sjg@chromium.org>
 <20231227082405.2202246-2-sjg@chromium.org>
 <20231227132033.GP2652760@bill-the-cat>
In-Reply-To: <20231227132033.GP2652760@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Dec 2023 13:37:49 +0000
Message-ID: <CAFLszTjLVv0P2Q-pwEZvBkmHEWYX=Gg=wvPAvKpKFjiYJwPEeA@mail.gmail.com>
Subject: Re: [PATCH 1/9] microblaze: dts: Use the normal build rule
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Michal Simek <monstr@monstr.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Dec 27, 2023 at 1:20=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Wed, Dec 27, 2023 at 08:23:57AM +0000, Simon Glass wrote:
> > Build devicetree files using the normal SoC-generic rule. For
> > microblaze there is actually only one SoC and one board.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  arch/microblaze/dts/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/microblaze/dts/Makefile b/arch/microblaze/dts/Makefil=
e
> > index 427a8f9aaca..adc76ddf21f 100644
> > --- a/arch/microblaze/dts/Makefile
> > +++ b/arch/microblaze/dts/Makefile
> > @@ -1,6 +1,6 @@
> >  # SPDX-License-Identifier: GPL-2.0+
> >
> > -dtb-y +=3D $(shell echo $(CONFIG_DEFAULT_DEVICE_TREE)).dtb
> > +dtb-$(CONFIG_MICROBLAZE) +=3D microblaze-generic.dtb
> >
> >  include $(srctree)/scripts/Makefile.dts
>
> This (and nios2 and perhaps a few other arches) show that it would be
> easier to just drop the dts- line as it adds nothing over what
> scripts/Makefile.dts gives us.

For consistency I like to see a rule for each .dtb in the directory.

> I wonder how this will interact with
> OF_UPSTREAM and how it compares with arch/microblaze/boot/dts/system.dts
> in the linux kernel.

I don't see any interaction. Perhaps the maintainer can move this to
OF_UPSTREAM?

Regards,
Simon
