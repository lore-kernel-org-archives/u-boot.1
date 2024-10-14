Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BBF4D18153
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 21:51:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6F9388E0C;
	Mon, 14 Oct 2024 23:51:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XH1nsAWp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E91289202; Mon, 14 Oct 2024 23:51:05 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA8B987DC7
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 23:51:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6cbf0e6414aso16127836d6.1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 14:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728942661; x=1729547461; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KrBIxZKyyBb5blgaMx+PlY5Xg1ZkN/EENbk29ewocxI=;
 b=XH1nsAWpGCNllQpA8JNCMFxG0dgixlThWYJagVQsQj0xoq7WO2CJem8LAnG9IogCvv
 pBt/Mzin6v4THBIaG30rOdJTyiZAQhEGKnD7trr1IfG0Ble9qKOo9gfyK+h5+fimPIAA
 Lm0kTYISJz0g3mSAayvxACUuInI5HbyKsQKCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728942661; x=1729547461;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KrBIxZKyyBb5blgaMx+PlY5Xg1ZkN/EENbk29ewocxI=;
 b=shYE/e1OR+/ZIEo3xRdJKjV+eMea/qjq/CIvUQx9Uz0mwwlqD6yRbCc4b6r729L7tt
 NEwHdo4fbWY8jlCK5xYd+p1S+7xG7GIxPknyGFNSFYHCHHkBO91Orvrb86tki4zeNyDf
 SWfZoPnqwnaNzYSJ7nGM6qjGYUyEdxvKWFt0/LTeKAW1gnDDESvjyCDWB0AA6boJqbO0
 kX4FDB8SWKazrhcVcpWxeV1A7GJMPlTP4PhW0QJDt2rEWHI8G/548z567fCqRzRsaOd5
 aTrSh6p89bXAEcc637fziXoxnyofa4fw/Mn8jm+VfnxT370EOEyepm6J4wBscGK14XK1
 yvug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVx/7HKGaNBkOQIYPi/UuP1sIGKpw+Xh8RCAlXteGdhcPIC2PS+Tjbttn0jY3xFJWOKlG8vUvs=@lists.denx.de
X-Gm-Message-State: AOJu0Yx4d5QoAG8h3irSBpWnh9qzlUsPClhsGJ3TN4P+POI+ywRkzxEA
 XyofXPDSoCMd7MgzcMZWz5CvyW3S2l/imXSKs4lQKcI7j42vphzSmf58J4nLYprlFJA3Xgq9VSZ
 M28lQuD2BtyGZHEkWLAK67w1JZanFgfY9jvFS
X-Google-Smtp-Source: AGHT+IGe7LpbnjaUWSJ/wHQd34v4RqBkuGCtcDwH1f8cLZHgBR1nCdugiuHkDp4UxppNfUsJhi/Z3bMYIFMkGJmgIzM=
X-Received: by 2002:a05:6214:2b92:b0:6cb:ef8d:b10 with SMTP id
 6a1803df08f44-6cbf0098a23mr215259746d6.39.1728942661543; Mon, 14 Oct 2024
 14:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <20241011212126.747741-1-sjg@chromium.org>
 <20241011212126.747741-5-sjg@chromium.org>
 <71ECC011-77EC-4308-AFE5-0E301BC27F84@gmx.de>
 <20241012012716.GE14210@bill-the-cat>
 <CAC_iWjL_YQ24ZecbN7oC-37PRR6iuUiiui-a0VPqSSVRunepdQ@mail.gmail.com>
 <CAFLszTjzHBtR8vzk0wT-nNiwbsotqskVhVEX0ibh-Uea1+Da6Q@mail.gmail.com>
 <20241014214236.GB53053@bill-the-cat>
In-Reply-To: <20241014214236.GB53053@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Oct 2024 15:50:51 -0600
Message-ID: <CAFLszTi8iJRMBVd79JLumPVz3VB0A8w1v_ZM2pP9D_cp_nx3yg@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] efi: Reserve some memory for initial use
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>
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

On Mon, 14 Oct 2024 at 15:42, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Oct 14, 2024 at 02:19:56PM -0600, Simon Glass wrote:
> > Hi,
> >
> > On Fri, 11 Oct 2024 at 23:47, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Tom
> > >
> > > On Sat, 12 Oct 2024 at 04:27, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sat, Oct 12, 2024 at 12:01:54AM +0200, Heinrich Schuchardt wrote:
> > > > >
> > > > >
> > > > > Am 11. Oktober 2024 23:21:25 MESZ schrieb Simon Glass <sjg@chromium.org>:
> > > > > >The 'point of cooperation' is where U-Boot starts allowing EFI to use
> > > > > >memory outside of the U-Boot region. Until that point, it is desirable
> > > > > >to keep more below U-Boot free for loading images.
> > > > > >
> > > > > >Reserve a small region for this purpose.
> > > > >
> > > > > Your commit message provides no clue why this should be needed.
> >
> > Yes, I hadn't realised that people didn't understand what I was
> > getting at. Tom asked the same question on irc.
> >
> > It allows us to separate the lmb allocations from the EFI allocations,
> > so we don't need to have them both in sync. We use lmb for loading
> > images, then EFI takes over and does what it likes, respecting the
> > existing lmb reservations.
>
> But, again, LMB is not for loading of images. It's for dealing with
> memory reservations of various types.

Up until recently, I believe, my statement was true, but in any case,
this isn't gemaine to the issue here.

The point is, this is a useful distinction, allowing us to avoid the
complexity of keeping them in sync, and avoid putting this pain on
people who are not using EFI. We are either in U-Boot code, in which
case lmb rules, or we are going into an app, in which case EFI rules
(but must read in the lmb info).

We are going to end up with people turning off EFI_LOADER because it
behaves so badly.

Regards,
Simon
