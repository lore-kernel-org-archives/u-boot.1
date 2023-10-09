Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC78CD6114
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 17:58:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3130386D7F;
	Mon,  9 Oct 2023 19:57:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hPow5rhL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E09186504; Mon,  9 Oct 2023 19:57:45 +0200 (CEST)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1244086C27
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 19:57:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-d852b28ec3bso5069422276.2
 for <u-boot@lists.denx.de>; Mon, 09 Oct 2023 10:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696874261; x=1697479061; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kOPShpI2J5dEgxYKiwSPzMRHIaGGW6qdmB2m9yC3ih8=;
 b=hPow5rhLGmmDoC1Qu2F2wZrs+wsf0BZYQITx8CCCLXdbGHoz1K2WfmqXnw8hxAIO5t
 wih4FoA+BPV5yMpFaZpZ2YBpEMEHhr6O1uLWGPPq3jIc8DILMVH0awDtXqAhU3qj/ej+
 vJVDVzSsGMPjCMQUNsmaMmDv5zJPTikx5cLZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696874261; x=1697479061;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kOPShpI2J5dEgxYKiwSPzMRHIaGGW6qdmB2m9yC3ih8=;
 b=sNPr3mr+i4sTCwK1+df/HYAaUSiQyEjCigc1ZBLHpL5YZ6KOLv/Quaz2mEp/1r/kDi
 E/35zP7kjDS53AXJ2eMoS1/WQNPg8/9kh1BRmVCKSOhgUmgXyJNgcBmpEXlHIATsipjW
 3UE+AH3eC1fFLTeS5oVl11Ls5tEVdbbisl1BDObZVnARqGZQPpi8Ef/IJJj0o02iEjrc
 ruUqQep8olSENuBUkTIoVVfHiTNN9Un1d8QxpUvG4HD+TI2wOcgifdED3xI2vTrrz1Hd
 EokqxIAWadcRnc/z3bzmDVr5DRb0bIVXDLhbmSyXilf1ooklVeFFA1mEjTpof1Of2gIu
 Li1A==
X-Gm-Message-State: AOJu0Yx6EoS1f+PVdUbDmUL+SJtlqcBKcG4N4ET6JU8R3DlP2ujcUO08
 P1ylx9/63v+2F6SzBZz09FwbmXBVf8LP+4RydJrxNw==
X-Google-Smtp-Source: AGHT+IFNpmSQAS3dy1CKZxqNzd6UTHHp40TrGZrg5DxEze/OTnWF4OKn2ikO/btqz0wqy2vekNQws8j5HWVMoyiwkTo=
X-Received: by 2002:a25:6a85:0:b0:d99:d1b8:672f with SMTP id
 f127-20020a256a85000000b00d99d1b8672fmr4718971ybc.33.1696874261308; Mon, 09
 Oct 2023 10:57:41 -0700 (PDT)
MIME-Version: 1.0
References: <20231007155535.1699567-1-benwolsieffer@gmail.com>
 <CAPnjgZ0qrDB_+HUNdGeCzS2FS4+fb1x9Cyr7xTjGccLCHpxwWg@mail.gmail.com>
 <ZSMlNWJ9f7HkoaNg@Dell-Inspiron-15>
In-Reply-To: <ZSMlNWJ9f7HkoaNg@Dell-Inspiron-15>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 9 Oct 2023 11:56:55 -0600
Message-ID: <CAPnjgZ0EOZCdXJc4HRmHmKGmzDiAJQH7X=3sTP3dO5YFOeVMdg@mail.gmail.com>
Subject: Re: [PATCH] arm: rpi: explicitly enumerate mmc boot targets
To: Ben Wolsieffer <benwolsieffer@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Matthias Brugger <mbrugger@suse.com>, 
 Peter Robinson <pbrobinson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Ben,

On Sun, 8 Oct 2023 at 15:55, Ben Wolsieffer <benwolsieffer@gmail.com> wrote:
>
> Hi Simon,
>
> On Sat, Oct 07, 2023 at 02:18:48PM -0600, Simon Glass wrote:
> > Hi Ben,
> >
> > On Sat, 7 Oct 2023 at 09:55, Ben Wolsieffer <benwolsieffer@gmail.com>
wrote:
> > >
> > > Using the unqualified "mmc" boot target causes the Raspberry Pi 4 to
> > > fail to boot. c771e5b explains this approach as follows:
> > >
> > > > We don't need to specify the mmc devices individually, since they
are
> > > > used in order from 0 to 2, and standard boot uses that order anyway.
> > >
> > > In practice, U-Boot first attempts to boot from the unconnected mmc1
> > > interface, and, when this fails, moves on to attempt the USB and
network
> > > boot targets rather than trying mmc0.
> > >
> > > This patch explicitly enumerates the mmc interfaces, causing each to
be
> > > attempted in turn. This matches what is done on other boards, and
allows
> > > the system to boot successfully.
> > >
> > > Fixes: c771e5b8c2 ("arm: rpi: Switch to standard boot")
> > > Signed-off-by: Ben Wolsieffer <benwolsieffer@gmail.com>
> > > ---
> > >  board/raspberrypi/rpi/rpi.env | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> >
> > Does this patch help? [1]. Alternatively, if you just remove that
> > variable entirely, does it do the right thing?
>
> Yes, trying either of those suggestions makes it work correctly.

Thank you for testing this

In that case, I would rather that [1] since it should fix it for all
boards. If you want to send a patch to drop boot_targets, please do and
I'll leave that to Peter.

>
> >
> > Regards,
> > Simon
> >
> > [1]
https://patchwork.ozlabs.org/project/uboot/patch/20230923205017.1754340-1-sjg@chromium.org/
>
>
> Thanks, Ben

Regards,
Simon
