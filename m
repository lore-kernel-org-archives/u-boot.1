Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F8AC3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 12:51:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD8B7812BC;
	Fri,  2 May 2025 14:51:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oNbax70d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3F7E81E72; Fri,  2 May 2025 14:51:45 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FB24801BE
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 14:51:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5e5c7d6b96fso3620796a12.3
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 05:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746190303; x=1746795103; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qzHRaxjjaX2q2C2Re+BaC+W7U9iJCISqKVxfzPYTNBE=;
 b=oNbax70dEmqkMb9lLgY1WA5osO03RZ+G4FNd44ugg3DZJ/Unu4OuhHoP0YPhuTlEem
 nDAhdVJFUIrIQdjVlTcwfgGDdpWknpUeXCzPYaJVyvPY3P48b9xDiR0orBoWudllc8vl
 z2nvh9rAhJ3PE5sCdea4ELiECtudm2iZ1Kv/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746190303; x=1746795103;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qzHRaxjjaX2q2C2Re+BaC+W7U9iJCISqKVxfzPYTNBE=;
 b=hQ0dTU295dH4qZ0IIrHqlFK7G0JR1hAgEVwltGYmwahuRVj7aJeikRhoUjQbEoMd4A
 YIYlRXaZM58VJvOOcQCTqJyh6TYWrce8p6/iKabCuw/vetYg30DizkYmHkER3kvmri7W
 dtefFhdTC+11D1oMgT9yausoGSakrjdlYX/ClUk0kBh0suS52JH9/XPDLjZxVYVsRfOE
 5IUihQxHPzZMYIZ1QsQdE337byuyanrxEydjetSYfk8py96HLEz/J/X7iOXX2ciY7ME3
 YYdd2gM+Va/JA1lPhdOsiJbiFdaHJjfKS9SKPZN06ELaImgYC/eD2SX3UfiS8cIb+TPq
 +2vg==
X-Gm-Message-State: AOJu0YyOof7GvAGOlLuZ1oAAXpEw7iE1lQfVdYDLY/spnNYpvV9irUQq
 ZuDYQcd7OiquzshtkhvspM0ymoFKLYXs607tjHvQ0uCSRTYT9CvJNgiGpsvbmlYRjqGELTTxnS8
 ItFD3SVZTLox73v6BwPiQGZBHJ9/kIK4fp9J6
X-Gm-Gg: ASbGncvGABJuRufyE0036BhMxGjOqCHSUEJv7ljj8J0xXg45ipQq2liAvTNS+uk1X2u
 nHw9JJMnex2iQH+LQ4Cgo9styZPAucwDTMsI4/uITZCLCG7vHFgY3y5czNCkKq+qu6FFgR3EKSO
 KMN89Qh5HB8a/tlqtMfH/K9+s=
X-Google-Smtp-Source: AGHT+IEtnXyJEB5mizn9M/tEeBIAfKJ6f6wRLVpVtSRIz5o78l8DnWlvpbUnU1hOvE/bSUH6Mo/rrd8u4O2vSvUbj/M=
X-Received: by 2002:a17:907:3da1:b0:acb:7105:61a5 with SMTP id
 a640c23a62f3a-ad17adf2607mr305104166b.32.1746190302586; Fri, 02 May 2025
 05:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250501012530.3954999-1-sjg@chromium.org>
 <20250501140354.GC1261075@bill-the-cat>
 <CAFLszTgKbsE0N1AEkwydiQQLMrMRNDtivQWVKmDsESYqZE-4VA@mail.gmail.com>
 <20250501153015.GG1261075@bill-the-cat>
In-Reply-To: <20250501153015.GG1261075@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 2 May 2025 06:51:31 -0600
X-Gm-Features: ATxdqUHaIuhLCrIIqtVMNj-VmaaQxulEuB3YU6j3v6xaP3Qgm3gCJV30L09VDCg
Message-ID: <CAFLszTjvaGLARFCGVODsbRL8h+dLg9Pk1SCV3RcrsC1SrvmTqw@mail.gmail.com>
Subject: Re: [PATCH] CI: Update the CI lab
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>
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

On Thu, 1 May 2025 at 09:30, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, May 01, 2025 at 09:03:15AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 1 May 2025 at 08:03, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Apr 30, 2025 at 07:25:24PM -0600, Simon Glass wrote:
> > >
> > > > Update the boards in the lab to match the current situation:
> > > >
> > > > - bbb and pin64 are working again
> > >
> > > And were never disabled in mainline (since iirc I never saw them not
> > > working).
> >
> > OK good.
> >
> > >
> > > > - samus and c4 are still broken, with no end in sight
> > >
> > > Good to comment out.
> > >
> > > > - new boards for colibrimx8, rockpro64, rock3a/5b, rpi5, zybo
> > >
> > > Except the imx8 board doesn't work in CI in mainline and had it's own
> > > long discussion that petered out.
> >
> > It has been fine for me.
> >
> > https://sjg.u-boot.org/u-boot/u-boot/-/jobs/49094
> >
> > >
> > > Please v2 where you drop the line about bbb/pine64, and don't add
> > > colibrimx8 until you or someone else are ready to work on the underlying
> > > issues this exposed. Thanks.
> >
> > Do you know what issues?
>
> Yes, can you please look at the thread from your initial patches?

I see[1], but I'm still not sure what you are referring to. Is this a
board which is broken with your tree, or is there some issue just with
the lab?

Also I was wondering why Nvidia board was not in the list and then
found this patch which is marked 'changes requested', but I don't see
any reason:

https://patchwork.ozlabs.org/project/uboot/patch/20241217210920.2050997-1-sjg@chromium.org/

I marked it 'new' again.

Regards,
Simon

[1] https://lore.kernel.org/u-boot/20241217134417.4064239-1-sjg@chromium.org/
