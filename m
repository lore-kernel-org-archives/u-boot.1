Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB38C4451C
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 13:55:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEDF384E45;
	Fri, 17 Jul 2026 15:55:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JASpP38+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E75E784E4E; Fri, 17 Jul 2026 15:55:36 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0724384E36
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 15:55:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-69e5f8a193bso1397556a12.2
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 06:55:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784296534; cv=none;
 d=google.com; s=arc-20260327;
 b=ozA0+iOeIl3BaOLGgyjVA9p1kUBJI6BlfaffyG8A6bKPuYNDtFvTD5r5xuvC1QU1Jg
 gDuJ1svupY6AIxHYq28E9KgKJ55N365dLmW3WoOHYBPSwucHDG14VgnUHyrMj4GhyRPl
 uPw6yOZxM5aDesDiQ23NbcCHfr+IcENv9vrMsDsdeHGyXlqieUEZoLjh12gyjeJHfnnq
 UMOQth+CxAkGukma5u7YZY6uVWG/UkE6VyhVzv7KrR9xmQiu5L21gW0EfLzsNXlm0Tan
 AHvUxuV+Sc3aJwVhTOf6mHv+2Ymx/ugPwobLGeC/c4pBOfL80QA4G4O24EHSSnG1WpLS
 IwGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eTSzut6yW+cN8rzFUgNh6i88vaSslgJ+/xGn4Nb8C5E=;
 fh=xRMANhCuAIAE/s6h0kAA+Yz/4rMtMte3zGnd0xZ8qGM=;
 b=L1Tdt5TNgv6666TJv8TwOcmmv6FzeOj0ES/uDtpyIxMmu5JXgT7lEkQrTs+OjAbFvv
 Wswzytmde35/tsGHzOmQp/yH9EAINYvP8HsM+261GSXk0J2pkWfHAUc9mN1yy1bkp92Q
 2lf0xtVtSYnMk2JuGbQfKaZvjBXf555wGbXXtjKpuang64l5nTkkW2NGyLwUVm8SgGCK
 d6PvojlzOgKbcN/mPEZqTwb/XoqjniIOlmSROc8KldtQfMGFMIZObQAD8FbGh99r1b5J
 I6isZpFtiNhYHQfHL5smYXhd6iyDw4xQV/xqgHJSBypQPiNWUPFx1UWvDj7IiLeiRljD
 FOEQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784296534; x=1784901334; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eTSzut6yW+cN8rzFUgNh6i88vaSslgJ+/xGn4Nb8C5E=;
 b=JASpP38+KbGBeNEAEOrq/siYds9y5KM3mOYiI+ADVaNFQ8zh+g9NErV4cUVkXYOjc+
 247i3rJYpbZlrHXAMbHt4JBflAmyYsy08bhtkF/emF0tEQh7bIRA5TIeUKBrTAXJuW4J
 MEB4W6hV2dV1EaTE4um9UMRvHvvl7poe5+L0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784296534; x=1784901334;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eTSzut6yW+cN8rzFUgNh6i88vaSslgJ+/xGn4Nb8C5E=;
 b=ZHf0+LvVKmzAw606DsqwMmARpODKxmNX9yBrxBenVEmbQ8nqmsB/daIvQ3dLO3bavG
 iwMebn5oP7Gs5PAQPyjUczlctFGnEinZd47Xn7fxVwJEekbOwFsjCSLi9IpTQNeYoPpl
 sCz59QfkNNmDM+rYZGxGO/weZOO3HnRZSDcXGpQQwlIgYGeqIW82dv3Jf3T7RH8/v7iv
 D7QZluza8IP2fhG8RxG0Kssu9hrza01OS0rDyoWXh/I99SDpMqdvMH4oyu6vfgmegNHc
 vpAk7ko5j3v77pEnJtTllxmPYaxwY+iSU7x50gbkhbzzeJCB+Y7atVVHmxbXisgROTRz
 V9Gg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoYcvOGMmp5BHSn+rbOo/dqkSV/YxBEVHWJ+UQUaK/qVBJldB5O6shv/luxx40KKss1eIzL7vw=@lists.denx.de
X-Gm-Message-State: AOJu0Yxv+2SopGJKUvo/ZYgBcK6x8xf7UUxEbq/1NuLxh+qsZo0xGMB+
 3Q0NioBwxeSFm4VVswU18l0uDDhRWLrjkF52OVA7k3Q/nHq1Yrn55RvhAfDMEifYzDuVpy11SiH
 owWjw8+dnWBI0HYI1XBuFofSu5YkZcEstFypNyi2fZQ4bfqBwKrg=
X-Gm-Gg: AfdE7clW+wrTwD23qQwb6aMr0bqqjjc82PGBqH4CXFWQn5j6d3QsxVmvjTFlYGb6LQS
 I90o0Xb1MHv1CDJfGQ4bdAS5o5lTVZf1MBQrUBikWIHoFm3DjsB9oACvQrdxbffPFEPxsST36fh
 Jz/3iMArHNDupGOBFgS7Q77fuARMSk/LsuWjCKKIAUalsatZlzjd/Eb92JaoxUGApHmCrO0XKHb
 x9iXDrpzT3E90evgV7rP3gndSE7f9NpDWMJZDQ0s4B3xTGV0u6ViTSzXUtA
X-Received: by 2002:a05:6402:4595:b0:698:3eda:1197 with SMTP id
 4fb4d7f45d1cf-69e652b0459mr1048948a12.20.1784296534384; Fri, 17 Jul 2026
 06:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260708-image-android-oob-fix-v1-1-a96de8ccd25e@flipper.net>
In-Reply-To: <20260708-image-android-oob-fix-v1-1-a96de8ccd25e@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Jul 2026 07:54:56 -0600
X-Gm-Features: AUfX_mxamGJ3bZkIurSB96NETXFv9PeRUiPSBrlJcH6kyhDMbH7SiKOfn9q0meE
Message-ID: <CAFLszTg-usTXZ1=Luy5FGKiU7LbZHDnLA+nZCdqF0Ro2Bk0dBQ@mail.gmail.com>
Subject: Re: [PATCH] boot: android: fix out-of-bounds access in bootconfig
 parsing
To: alchark@flipper.net
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Safae Ouajih <souajih@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, 
 "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>,
 Guillaume Ranquet <ranquet.guillaume@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
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

On 2026-07-08T17:32:07, Alexey Charkov <alchark@flipper.net> wrote:
> boot: android: fix out-of-bounds access in bootconfig parsing
>
> When android_image_get_vendor_bootimg_size is called, its buffer is only
> allocated with enough space for the bootconfig header, but the
> android_vendor_boot_image_v3_v4_parse_hdr helper attempts to append a
> bootconfig trailer to it, causing an out-of-bounds access and heap
> corruption in some cases (e.g. triggered in sandbox test builds when
> extra bootmeths are added, resulting in a segfault of the sandbox
> process).
>
> Skip the dangerous memcpy operations altogether when the
> android_vendor_boot_image_v3_v4_parse_hdr helper is only called for size
> calculation purposes, and only append the bootconfig trailer when called
> from the actual bootconfig parsing code path.
>
> Fixes: 57e405e1f474 ("android: boot: support bootconfig")
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> boot/image-android.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
