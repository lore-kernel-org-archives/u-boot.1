Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1262EE57F6
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 01:03:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A57E88E2E;
	Thu, 12 Sep 2024 03:01:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IgTZFG6S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0790E88E0F; Thu, 12 Sep 2024 03:01:14 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB08F88D09
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 03:01:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2d89229ac81so355079a91.0
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 18:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726102870; x=1726707670; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IiOMoQA50ITSfpv05gVJ1JdHHG9N6SM3Lee18Pj1gs8=;
 b=IgTZFG6SPoZH5Z/iO+5zu6FhrD2mOlCmWzr4RtZpkaE4UN78dk8Vvrf6tfljbw+d6q
 I8il3iivSaxzBbEkgzjPYauQD/odV06WE2QMOdo20SmIzhbtcKbvXGaVoqiYHnFzJWCA
 z66PC45ZcJhGe5F0Tnl0uCqUhlPLRLtm1En6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102870; x=1726707670;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IiOMoQA50ITSfpv05gVJ1JdHHG9N6SM3Lee18Pj1gs8=;
 b=DRynmNOWnA13OJqf1Q1OGoASt29/+9EvXevQP6t9TxYi7mUuOya5594RZjGYirKEJ6
 3thrWU6ay9uVtWhN84oK0/pRceRabLGgyv8LkuHHniMhizaXhunuQGBZnKacIqRyihQW
 kfZcnJdVP1uOyQrJ4WHqq0xAkkHNBVAgvEOSF5RWNrmXmEKIs35KmQnk6CHUEN6Lyujm
 TUUkn/6YFUU1HUpuTewmcHtW6+xNuV2k59XxxrJ+NmRUDFk7gQ8+vEOwjBuzDB0fIXoo
 x1llpm5dAhspRtjJ64i7kIJv8UHEVAk8gLwWgnGBSXyhBqSY3jr8GKq33KykusVFpzKZ
 6+kA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWodyyf6cd55lEztw2SfJFRDifHFw8th7YAL/s4G8ejindpKdC9wfS2aMrI1KzfIZxBPX749Q=@lists.denx.de
X-Gm-Message-State: AOJu0YyIqHAi2zzYDUwPdT1FTmniisKUj93cGTp5Q7M4yigD4gdKqAhv
 Kbh7ep2jS4LlJL4Bhlia/c5X3guQbhzzgBw+870eacLuY25p8zbnRgQtLjEHwFdK/QP3C1ZxOCo
 Mma3A0++GU/PBdz7G3LhasvTJn+eABeMjfPlx03IVkVP1N5Y=
X-Google-Smtp-Source: AGHT+IHqirWFj8TRFIXLy3O5KqdzPNep4gTlRQTOAw8mawLmvDxv/THZyTgDWqLaBqy0caLeLK7r3VuoqDixHvoVxCA=
X-Received: by 2002:a17:90b:3888:b0:2d8:9f4c:ecb8 with SMTP id
 98e67ed59e1d1-2db9ff90ca9mr1467788a91.13.1726102869970; Wed, 11 Sep 2024
 18:01:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240911214945.15873-1-ddrokosov@salutedevices.com>
 <20240911214945.15873-5-ddrokosov@salutedevices.com>
In-Reply-To: <20240911214945.15873-5-ddrokosov@salutedevices.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 19:00:57 -0600
Message-ID: <CAFLszThcidHwAs=RSEg2anSMiHAAkWBget6FiXuDjG0GxALxtg@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] cmd: bcb: introduce 'ab_dump' command to print BCB
 block content
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: igor.opaniuk@gmail.com, mkorpershoek@baylibre.com, 
 semen.protsenko@linaro.org, trini@konsulko.com, colin.mcallister@garmin.com, 
 4.shket@gmail.com, avromanov@salutedevices.com, u-boot@lists.denx.de, 
 kernel@salutedevices.com, rockosov@gmail.com
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

On Wed, 11 Sept 2024 at 15:49, Dmitry Rokosov
<ddrokosov@salutedevices.com> wrote:
>
> It's really helpful to have the ability to dump BCB block for debugging
> A/B logic on the board supported this partition schema.
>
> Command 'bcb ab_dump' prints all fields of bootloader_control struct
> including slot_metadata for all presented slots.
>
> Output example:
> =====
> > board# bcb ab_dump ubi 0#misc
> > Read 512 bytes from volume misc to 000000000bf07580
> > Read 512 bytes from volume misc to 000000000bf42f40
> > Bootloader Control:       [misc]
> > Active Slot:              _a
> > Magic Number:             0x42414342
> > Version:                  1
> > Number of Slots:          2
> > Recovery Tries Remaining: 0
> > CRC:                      0x2c8b50bc (Valid)
> >
> > Slot[0] Metadata:
> >       - Priority:         15
> >       - Tries Remaining:  0
> >       - Successful Boot:  1
> >       - Verity Corrupted: 0
> >
> > Slot[1] Metadata:
> >       - Priority:         14
> >       - Tries Remaining:  7
> >       - Successful Boot:  0
> >       - Verity Corrupted: 0
> ====
>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>  boot/android_ab.c    | 68 ++++++++++++++++++++++++++++++++++++++++++++
>  cmd/bcb.c            | 35 +++++++++++++++++++++++
>  include/android_ab.h | 10 +++++++
>  3 files changed, 113 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
