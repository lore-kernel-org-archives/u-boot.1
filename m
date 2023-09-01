Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE35CA0FE1
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 08:09:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C908D8669D;
	Fri,  1 Sep 2023 10:09:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mPBQ6tHd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0851D84003; Fri,  1 Sep 2023 10:09:25 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5948C866AA
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 10:09:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-4ff09632194so3064342e87.2
 for <u-boot@lists.denx.de>; Fri, 01 Sep 2023 01:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693555760; x=1694160560; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dLFdsU99Myn4PEF1ZSHmzwqqjUtq6gmTeM9LCgH8CMM=;
 b=mPBQ6tHdWSvygoQoIhcmHJSazqHNSZjNBdaNMTXx4MWzfJW4W1/XqNbdI+obPFpheO
 1MRGUqQzw3wPaEB1L0ij2Ypfnkk0jxj4bReS8jFm21SOO57Vy9ocyE9WqEHkUfZx0SzN
 mzpN9Qy84zQHvMtRiyxI5F+gUiOBQaiD7Pc5Gnu/0iHy1BwaTBB2Jhdgrw4vIScyCFKm
 0h/9nQyrdJ94b9Jzzh0M3R09/zEEtnmgXxTa/+MZGQYrC5qOEhde2Irt6QflK3jkNgqo
 BFDUwqSLXT/A8D+MqyPZAoFAqGvB7VRidTkCHR1oX3eIvAwWWg2fpUlXrYSdqdS7EGhp
 w+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693555760; x=1694160560;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dLFdsU99Myn4PEF1ZSHmzwqqjUtq6gmTeM9LCgH8CMM=;
 b=XApT+4bfDuVnrbk6EafYGAOuXC60YOJsd4t0UQSHAX7yu9Weicu9pCJ1e2ekk91kru
 5kAL0R+Ivj53Thg54yl+FOpLgdQDWE4ZfuKyA2Z2z5/8JV4bFbJIGl+rNN+sAeNxS6+r
 ZtoagudBN4Ko90cd+vvWWbGibbN4p67v3ckFAHhy7Os4Fmn2rZZAArB1mTCfd5SGAeUz
 0a4AoIrYgdAhtIBK/5huG1lwSdrBzM0PDowNRUqh97w2FcMxghheFCTOeSh6QNQfUNVe
 Y92jClTN4hGU5js9IW9fc7LMtD4jEfkoBP/PvEkP/fPXCI7gB0o3ItufXwMebuq7l2rj
 uHHg==
X-Gm-Message-State: AOJu0YyP43RcNAvQbPQehWh2PQy2sZQtKXEiGlAngVnZUyIDU3Y2s21e
 TXNj1yIokLfOU+s31yP8Q8SVgFid0QzSl0M5QchxnQ==
X-Google-Smtp-Source: AGHT+IHfqKJkR3g9JEYf6O3FoEtlFy1HHw7n+w3xzzpmxDbQTbdhWFGfhmJHX8jGqlh6dwlYAk+GfxuRA/QsZFL7hcs=
X-Received: by 2002:a05:6512:e9d:b0:4fc:df79:3781 with SMTP id
 bi29-20020a0565120e9d00b004fcdf793781mr1318001lfb.66.1693555760042; Fri, 01
 Sep 2023 01:09:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230814173944.288356-1-alpernebiyasak@gmail.com>
 <20230814173944.288356-5-alpernebiyasak@gmail.com>
 <CAPnjgZ2d1mJp28UP2+zKC6+2pED_=YdovA_jaNJz2r+C=-jufg@mail.gmail.com>
 <8add4068-7b05-4f32-8eb7-31366fb396b9@gmail.com>
 <CAC_iWjKADqX3HaJON6CELbGeAD5VDvdyGfgHPxCjA8G+YRd7gg@mail.gmail.com>
 <4e21c034-102a-4aac-b630-43546e97de5e@gmail.com>
In-Reply-To: <4e21c034-102a-4aac-b630-43546e97de5e@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 1 Sep 2023 11:08:41 +0300
Message-ID: <CAC_iWjJiX9TCqPBzLDST7xW5pdqGh-E6DMHUKj_+sHqzbdfw9A@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] doc: qemu: arm: Add a section on booting Linux
 distros
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng@tinylab.org>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Bharat Gooty <bharat.gooty@broadcom.com>, 
 Stefan Roese <sr@denx.de>, Qu Wenruo <wqu@suse.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Bin Meng <bmeng.cn@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>
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

On Thu, 31 Aug 2023 at 12:25, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
>
>
>
> On 2023-08-30 10:33 +03:00, Ilias Apalodimas wrote:
> > Hi Alper,
> >
> > On Sun, 27 Aug 2023 at 18:49, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
> >>
> >> On 2023-08-15 01:43 +03:00, Simon Glass wrote:
> >>> Hi Alper,
> >>>
> >>> On Mon, 14 Aug 2023 at 11:40, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
> >>>> I actually want to put the root.img device first so that the VM can boot
> >>>> into the installed system when it reboots, but U-Boot can't find the
> >>>> bootflow on the second drive. I tried e.g. `bootdev list -p; bootflow
> >>>> scan -lab`, but it seems to only ever search the first virtio-blk.
> >>>> However, `eficonfig; bootefi bootmgr` makes it boot somehow.
> >
> > eficonfig, apart from displaying the boot options on a menu scans all
> > media that have a simple filesystem protocol installed and configures
> > the efi boot options.  That's why bootefi bootmgr boots properly
> > afterwards.  You can probably boot even without eficonfig, but only
> > bootXXX.efi files will be accounted for and no boot options will be
> > added.
> >
> > The EFI spec describes the bootmgr functionality in detail.  Back when
> > the bootmeth patches were added, I suggested we shouldn't deal with
> > EFI at all simply because it all already works and is backed by a
> > spec.  Instead, we should just have a boot option in the methods that
> > spells "EFI" and let the bootmanager deal with the details. But
> > honestly, I've lost track of those patches.
>
> I think bootflow and EFI should be different views on top of a single
> "what can we do now that we are in U-Boot" model. IIUIC it's possible
> for e.g. UEFI Shell to be built-in boot entries, so we could expose
> bootflow entries (and more) similar to those?

I am not sure I am following you here.  The EfiShell is an
application. You can use 'eficonfig' to add/delete boot entries for
EFI, which will appear on a menu.

> And EFI-based secondary
> bootloaders like rEFInd could let us choose them in a graphical menu,
> efibootmgr could change their order or reboot into a non-EFI flow...

I'll have to check rEFInd, but I think it looks for PE/COFF binaries?

Thanks
/Ilias
