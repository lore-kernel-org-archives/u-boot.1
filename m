Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1881FCD5BB3
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 23:15:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 859BE83FF5;
	Sat, 23 May 2026 01:15:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NQb/7HHH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4A89848B6; Sat, 23 May 2026 01:15:10 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E6E283C2B
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 01:15:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-67fd8befac7so17284409a12.2
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 16:15:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779491708; cv=none;
 d=google.com; s=arc-20240605;
 b=BYecUwe+iZzxM23Pd/nOc5xRxnfWQSHCit9Yp5225QuxzG3766ngkqn/rns5YkFdb4
 MtCwBbr8sMZlF/kRNfVGAg5ddR1wgHMuNrRe80/pABkK698ldJ2YW5tdmyD+BcBPn2d0
 d/KB/KxjwGUWCQZb4jf1nqSJKIJzupK9Qld+1Z1uNuc7PJRSOdqbii0YsU68sDGIIVBR
 iHIAUlYjDLZCedQeaRo9MwnpQzVKPsa4yOO0HOv0n9vG9ITr1FC4v5rfgdXm6btLRrCC
 7GlSi2lbQT/pfbEvYLUR/IGUTA4/CcClbtCHwoWAqRzNuWnhkzgcah45p9BjDUTl3BQz
 wWKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=c075k4LMJ4Y8EqaRiZW35iUCb2NhzWO3qEJa4nel1i4=;
 fh=3cGkqt4Xgv2w9dTeeIJFEJ5AO4AvGobPArcY4WlS1wc=;
 b=ZXSRAVqmYE43fYdPgAu7ugUu5Ps+0TQuC46LPLrFlKPANaCjyC2bHL9DHAUZduVEjW
 FV8SxSPvKGY/D0MvTXUp/Ekj5Zos5iViHT4jM6Tq89/xInA2hBFoT/eNVodbEp7a2Lex
 d1PBvyhRiWagqlurPkYi4T5DT0PFyCtK5/JZlFm5uyoLgTPU/kCr49EiJrGvMnP9TMI9
 vIeVwN9aaMxJoj6UnVNr7N1AoTjDSb7+V8nzmKhxEentdV0fzISFk8F8qFCKlOREhA5x
 mXE4TBpmhTwT1Pm0PcYE0XkEMm5jSvos+bT4+b9/K2fYN2RxSdiwhEvvJCJpGMLHEfr3
 ccrw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779491708; x=1780096508; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c075k4LMJ4Y8EqaRiZW35iUCb2NhzWO3qEJa4nel1i4=;
 b=NQb/7HHHXJZNzzHDnzVL1wdHrGivKAexC722zEQOkoc4ZwSFtgcwiPnLLAzxB4D1QV
 J2dSfjAeXoJtNBEXIZiXLiZEw6I605KHEYwGqAjufeNW8HG41ceo7IfO4DOm0pquxCli
 UfCTrdFeuS9/KUcTVy9dyveU9yvVnBcDRPe60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779491708; x=1780096508;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c075k4LMJ4Y8EqaRiZW35iUCb2NhzWO3qEJa4nel1i4=;
 b=YmO35UQxE82l2zIgQgg0WnywYOUV4SIzKjBuKdEIBpTQIF6MrSktwYe3EtUJqvwTVv
 892qPca1C6FPTbpVeepTpa91sgB/D7ce7IfWlblOpVrYMzCAD7tiymV2lyqd/GIg0nAD
 SInDGGQ0PiX+gL/1YYRKj4ytz0TjcGERkyTrjj6aXr69zPQfhYv4uwATBIae4HbKuzdv
 Mp8tALwafXuuEoyX+7BeBGxr7lPM/Hmk9pQyucpJgTA89GilTISFvTR1h/trJmnTWbry
 w+a1uqrMFQxwuV4Jh/5Q3hXhtXpYEa0k1Okv7EuqhYWs4feExL/oqMlDxlUg4A5PaT/B
 QScA==
X-Gm-Message-State: AOJu0YxeT5v2DTMra3C3Nm/in4jj2yCS7K2/YCnomWfBVlg6QMxY3fnq
 LWxl0Rah5D6xzkOmPxQu58l2a4EwhecufBwGwPNKybZBxWmXTq+FJXGcvMuJIewA5BzCv9yeMme
 BnyXwcJyGm9REVBTdbCnrXcMAmRN+W/1URmj3vq6q
X-Gm-Gg: Acq92OE+8QlklKtcWOexwiMpZaqfqQEO1PUIt+Tg6HaHtIoTgdBF6PHekjvut3mVt/g
 XQs6SuFU5END+inNgUMV0/d8qnpXFudQKHfDxamJfO5HjSu8sxIZ9SnbwYsoIxIlEPUxVlR2Q5b
 IHPyEaaB7wJTqiSUHor5x1FA2ly6RcDwFuixxh2xXeCIhcjS4Qg6X4XNQKc3TF57PzdL44JQrsf
 V0pnAbI2f0Rhw2ytZoTzWSKJsOo+xz+ohGF1IWt0Z8Ca5JANVLmHrX544G8nVJRhDix5lehKI29
 vLRdBlxl1b9fdmay
X-Received: by 2002:a17:907:72d3:b0:bdc:ac75:73b9 with SMTP id
 a640c23a62f3a-bdd266bc8e8mr363837666b.43.1779491707910; Fri, 22 May 2026
 16:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260519152101.716714-1-trini@konsulko.com>
 <CAFLszTh3vk3FbrOXWrxY1JP_Se7ewuoQhHETZhjrkKcQLZ5pzw@mail.gmail.com>
 <20260522150014.GQ1858239@bill-the-cat>
In-Reply-To: <20260522150014.GQ1858239@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 22 May 2026 17:14:54 -0600
X-Gm-Features: AVHnY4L9VgU3fZ1NQjisu6bq-GnV8ftO6Wg4p02yQ9SX78dUqGy8tZGqTA-uOsM
Message-ID: <CAFLszTiNu_pQb9Lzuy3R6wy5-KE16NSh93EUcjfJRZhLuVSX3g@mail.gmail.com>
Subject: Re: [0/5] Remove some empty bootdev_ops structures
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Fri, 22 May 2026 at 09:00, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, May 21, 2026 at 05:30:12PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On 2026-05-19T15:18:15, Tom Rini <trini@konsulko.com> wrote:
> >
> > > This series fixes bootdev_get_bootflow to not require the ops
> > > field in the driver to be set and then removes the empty struct from the
> > > places which had been creating one.
> >
> > Two more empty bootdev_ops structures fit this pattern:
> > nvme_bootdev_ops and usb_bootdev_ops. Please can you fold those into
> > v2 so we clean them all up together?
>
> I'll follow-up and remove those later, and also update the doc and
> remove the mmc one.

OK

>
> > > As part of Marek Vasut's work to add static and/or const to structs that
> > > should have it, but do not, it exposed a small problem with the bootdev
> > > uclass.
> >
> > BTW for patch 1 it would be useful to update the comment for
> > bootdev_get_ops() to indicate it can return NULL - normally, we don't
> > allow this.
>
> Don't allow which? I get the feeling you're saying I need to audit the
> reset of the uclasses for optional ops fields and then see who is just
> setting an empty struct and fix them too..

No, I just mean that there should normally be an ops pointer, unless
the uclass itself does not support any operations. The case of using
NULL for the ops pointer is really just an optimisation. I'm fine with
it, but it might create confusion for people, so it would be good to
document it in the uclass header file, where supported.

Regards,
Simon
