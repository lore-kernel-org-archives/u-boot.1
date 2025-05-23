Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6F4C54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 20:21:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CCC3833E8;
	Fri, 23 May 2025 22:20:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PkLru5h3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 415AD8334D; Fri, 23 May 2025 22:20:58 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F10D2833E8
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 22:20:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-602346b1997so436028a12.3
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 13:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748031655; x=1748636455; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rYHWjMDDuQXknlzJ41uPNsDkDBPYlxAMpqdGvsF+dNA=;
 b=PkLru5h3+2KfuegbQQzMDUs9BSTHIQQBuAd4jC0WMujCOAQHtO1UOTw8pr6babjgSA
 ZcdPj9MzpXfTjOEXXprm62Uhx3ft2w5OvuzlMMerBD0qPrCL/QLP42BuahZLCz7SaKtD
 ErRCRYEkOLI1rPqshUlxnLJkLS0vigiiQYC9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748031655; x=1748636455;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rYHWjMDDuQXknlzJ41uPNsDkDBPYlxAMpqdGvsF+dNA=;
 b=ok3evGsMN9tBIuHmQ9BZq/r5BhzmFUIrhdzBFMWIgPq23dQK95vGNscSUaGxToMOH7
 rDZuxsKVShdh4QikpusDsq6eMSIv0O0yJRQHoOnJT+g5yYCl3uVhzQWB1tAx4JWCIMMz
 IraZUi4z7I9eE9DEzyhGie38atutNbxv4R8Nhlqcnw0paGl0X3Fsecf1xgPcNYEYqvhZ
 hUzVhihmVtfisG3hyi3NB1dgotocsTsZP8rh2gjHGFkpFzna754Wiroshbcrh1VamBix
 cZJqM3vN8NA2pY78GyFdn4Ot3+ltHX67agDgIPrlUHfrlMTGWrGu7fTAUvIBYLzHMjTb
 bkgA==
X-Gm-Message-State: AOJu0Yyda509PH+AFc7zYPT5wRjFJvqj95XxezpY83QncFTeTZSjYu0z
 FnDT0e2ibl1k3vtUbG5ANLZVYg7F9x4izeIxUE49/eWWe99FiwKvW1GldtlYAOV+cmtdK2OIQip
 NyrmOG1tuzU5hO8f0ybrHTdCkABE5mLFRx47LAcii
X-Gm-Gg: ASbGncug76aznTZ8Wa+Xco25m+nAchUicfHGX+IsSaYOOW+3GR1yvqHqPXsdhOKP/US
 R+KB/ETowyJQ8Bl9amxxWicV5kY7bIm8Ueat2OHXc2HVZlc038aQUAuCjcQBBqZ1kB3q5ZVWxUb
 22dQ+XXU9ATqv/nqkcE/ITr/SZYsQXTYA=
X-Google-Smtp-Source: AGHT+IGdYuhYJ3xa0QJWU6Bc1etroEeUdqcFVhd61jKv3D6DH69ejlGsdjy4QhOTuuf9TM1kDV5LoxjrbZmJltzsVto=
X-Received: by 2002:a17:907:7b99:b0:ad2:39a9:f1b2 with SMTP id
 a640c23a62f3a-ad85b32b957mr39658566b.59.1748031655439; Fri, 23 May 2025
 13:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250504132356.2317305-2-sjg@chromium.org>
 <20250504132356.2317305-1-sjg@chromium.org>
 <CAFLszTi6LwvSoNtThF5DzKjJNFzJxB5rk5DjYi9wzsfkiwwjcg@mail.gmail.com>
 <20250523140455.GP100073@bill-the-cat>
 <CAFLszTj1v7dhvdj9vM70OP=Bb8j3FArYHS3SGcpnJO31z3Ns1g@mail.gmail.com>
 <20250523164717.GU100073@bill-the-cat>
In-Reply-To: <20250523164717.GU100073@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 May 2025 21:20:37 +0100
X-Gm-Features: AX0GCFuai7k9HlCp9pNR6WOnJcY0Sxqvo6zm_fldcV7LlmbmgdjNblajvRjG2No
Message-ID: <CAFLszTg0CO5PqagaAZNov-N4rv6D17iUV_qnAasJ336zW=eG9w@mail.gmail.com>
Subject: Re: [PATCH v2 01/30] patman: Move all non-test logic into control
 module
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Fri, 23 May 2025 at 17:47, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, May 23, 2025 at 05:32:36PM +0100, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 23 May 2025 at 15:04, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, May 23, 2025 at 08:19:30AM -0500, Simon Glass wrote:
> > > > It is easier for tests if the top-level control logic is all in one
> > > > module. Create a new do_patman() function to handle this. Move the
> > > > existing code into it.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > (no changes since v1)
> > > >
> > > >  tools/patman/__main__.py | 49 ++----------------------------------
> > > >  tools/patman/control.py  | 54 ++++++++++++++++++++++++++++++++++++++--
> > > >  2 files changed, 54 insertions(+), 49 deletions(-)
> > > >
> > > > Applied to sjg/master, thanks!
> > >
> > > Odd. I thought you had posted this against master or next, intending it
> > > for mainline, which is why I assigned it to you in patchwork. I see the
> > > cover letter is missing what commit it's against. And instead here you
> > > are once again spamming the list and with messages about your personal
> > > tree. Why?
> >
> > I'm applying it to my tree and intend to send you a PR at some point,
> > with collected tools/ patches. So I believe I need to send emails
> > about applying things and update it in patchwork. Let's discuss this
> > in a future call.
>
> I don't see what there is to discuss. Please follow the normal process
> for mainline and stop spamming the list with notices for your personal
> tree. You're also diverging your own tree further from mainline by doing
> this and making it less likely (multiple people have told you they don't
> want to review things not against mainline) any follow-up work will get
> comments other than that it's not applicable to mainline.

For patman, I have another series [1] I'm planning to apply to my tree tomorrow

Would you like me to send 'applied' emails for it to the mailing list?
Or perhaps just for the cover letter? Would you like me to send you a
pull request?

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=456256
