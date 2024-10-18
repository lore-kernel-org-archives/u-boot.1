Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2EDBD30011
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 15:00:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7646D89249;
	Fri, 18 Oct 2024 17:00:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bX4irfZ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9C5E8920A; Fri, 18 Oct 2024 16:59:58 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 782E289234
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 16:59:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-71806621d42so1034298a34.3
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 07:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729263586; x=1729868386; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TouGvgCLZKXKQYXrzvwGa9eiUkoKZ69/1GXjHs+LqxA=;
 b=bX4irfZ2FPpc/1G+QOqkfGBDStW+++4XKRqJxlWwWJcX9ccgyVaGge5FOHMChWj4qm
 n/Iu0cAN8kwsTEgQNU02zZyT0hby3s5XBTnubGedSBGe4mTi66Jk5pE0D/L0fDt1JGiU
 hSsRtc+w52eBX1N0K7MLsul1ZVdU4d0IGnJxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729263586; x=1729868386;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TouGvgCLZKXKQYXrzvwGa9eiUkoKZ69/1GXjHs+LqxA=;
 b=vXMQN17T6V2L+XRcA1hPRi3n42b+4vm6hJhUGIth1u2zM3oRI35sFGll+jKS9aZBPG
 jx3SLwKZoYRn4ay6LTlE+Luq663XAC3/v7q2nC+sgyWVuq+XVrul83HkFTLqoWtC6m9d
 jFg7Z1DbIIKHWL/n3WYdj0iE/75VU5y7XsUiP0+fQCkKCgnvpIFuQ2HlQup4gPEZIEgy
 wfjx9va27a3DkjuAdvyWwHuJ71F7LV7ZUMEjtHue5WHJHRUCAjkh5NFzjHEYGrauMn+v
 FURlfbDfM4MhLkKtn/PTQZml5I9ql6buWVau1reMYIFAXyaPGAFrPn9Zmy4ZgpFzp2SV
 Qmpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4ox+vgyWACrsPRQ2WNJ6c3jZnSLUajjHKF5piqfUQusyQNPdwyZtnb6iPbo5FgBeHWe/QzAE=@lists.denx.de
X-Gm-Message-State: AOJu0YwLqrr4cnMMugFJ9+HfR2Yxef05AuSgXoW3K5ObIcw9oYgVCe5t
 G6tYvyGtO48o2ie5BaogwDJCGxAizD/Db61k/21Jc4aRpLlSwmGfirkDl3cxQn+8G2Kbor07VQj
 pmTt6Pu7WNdShxEJwn5ePGizsNprxff2oyol3
X-Google-Smtp-Source: AGHT+IGe1FYKUtim3XbE2dw5kKFad+WNqKYvkUNOE3jjiXnRustsWBcT23G/m8BPleybKBmvnBejgeaWVa7E0jC9m4I=
X-Received: by 2002:a05:6808:178b:b0:3e5:f43a:5d77 with SMTP id
 5614622812f47-3e602df23femr2482223b6e.42.1729263586165; Fri, 18 Oct 2024
 07:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240828201355.1111764-2-sjg@chromium.org>
 <20240828201355.1111764-1-sjg@chromium.org>
 <CAFLszTjk+LtGFUBb-Xgn_QX-W-QP+yCJ+E1C=V04VGcpi0mVng@mail.gmail.com>
 <f6cfcdee-e7a2-4564-a1f3-473fb47cb3cb@kwiboo.se>
In-Reply-To: <f6cfcdee-e7a2-4564-a1f3-473fb47cb3cb@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Oct 2024 08:59:35 -0600
Message-ID: <CAFLszTi9U=QFqekG93SoQmDrCE=vH3=N3BvZ8sQ8_yFBkv62RQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] x86: coreboot: Add timestamps from coreboot to
 bootstage
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, Stefan Roese <sr@denx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Jonas,

On Fri, 18 Oct 2024 at 01:44, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 2024-10-18 01:12, Simon Glass wrote:
> > Receiving timestamps from coreboot was unceremoniously dropped some time
> > ago. Add it back.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Fixes: 8ad01ce36f7 ("x86: Remove x86 specific GD flags as they are...")
> > ---
> >
> >  arch/x86/cpu/coreboot/coreboot.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > Applied to u-boot-dm, thanks!
>
> I was under the impression that you would rework this to prepend the
> coreboot bootstage records instead of adding the preceding coreboot
> records in the middle of existing U-Boot records.
>
> Or did I misinterpret your response [1] to my "bootstage: Do not sort
> records" patch [2] and you instead wanted me to do this?

I decided to worry about this later. There is a coreboot update as
well in this lot of patches. Once that is applied I have some more
pending patches and I will take a look at this.

I sort-of agree that sorting shouldn't be necessary...it's just that
with the boot sequence getting so complicated these days, I'm not
sure. But let's go with unsorted and worry about it later when we have
other cases (i.e. other than a prior stage) to worry about.

Regards,
Simon



>
> [1] https://lore.kernel.org/u-boot/CAFLszTjz9dX2UzUHgbmsr2no4seK07oo2PC++hS2t7CP7z8khA@mail.gmail.com/
> [2] https://patchwork.ozlabs.org/project/uboot/patch/20240803124149.2916030-3-jonas@kwiboo.se/
