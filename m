Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A786CAC5B0
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 12:20:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5B0482A9E;
	Mon, 29 Sep 2025 14:20:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XVl/uXQl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 961DA8319C; Mon, 29 Sep 2025 14:20:32 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A2318206E
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 14:20:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-61feb87fe26so6489847a12.1
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 05:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759148429; x=1759753229; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=59bYRkFSbfCqCCiGR87JGrikLRZkZagtLEUKz/WQbh0=;
 b=XVl/uXQlU2U/Hg0Nq1X7eCa6CYDL2UA6wpxUj89OZpfy0MWGYU2qxLxXk99BaDHuut
 viV/twRcoPMh5tFZLuHDof06z2uG92RZWsE8eJlIa5CPvjsx7OvywkKmaQVfmYS4Ip98
 cjwY3fu/FoAFjPHAN4q3pCkInb1e6pa8GeEY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759148429; x=1759753229;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=59bYRkFSbfCqCCiGR87JGrikLRZkZagtLEUKz/WQbh0=;
 b=gbpve1lzgeShvXsP5P7BnmQYb8XNq3GlDs8BqA2PnonxKqwbitFCfCP4/f5OC2Lel4
 ifNTSG3gBibc/l0zIz5odlppJiwN+lx8ubpuhhMnvhK5jUmlp8NyFi9WIfmLxHp2/1lm
 LARoSbfiQCBFiYj7ZoLm4+Yl6YqC+bzklPnVIHhOGIAaH8PNG5+sjt0OgkoiyU6fblSi
 ZGYBKRKITgrueEKs2QYsqRFr9ToCu2JDdygt5be2POvRxOqGj6yk18ukcYZlgoVFqJ88
 pDTX7dLVMP+KntaNim4gxogWRvP4j/93oHXRiWIZhlhnG0s+ZBGl4NNv7KWM+L9ZukPS
 EPhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4yRIpzqsJfhlMTZQ+qlGlBdRZtTMLZMyizUaI7rfIqFSTJKr/Cn66oaqBYcyIn9qWH0ZLQxU=@lists.denx.de
X-Gm-Message-State: AOJu0Yw5UxO7cSk6j9vDCc2Z1n2PmKsJOQhteigKT0DCHVDrqPgNKdWG
 +/EsFKYeNQZSaAdbl0Bc9fNda4pcv74bAUoZ7xMhm1oYo1+30QeEVbvUH1RtrYApBJpYA4Ndxus
 Zond6XDwgI1OEizGGYbUpxmAvsoYSWGufdJQ1GTqj
X-Gm-Gg: ASbGncuJMvPEVCPLwcHQ0m3bZmh0c+8EZ7FKCMdKrMVFOWv8dl2YsdHmrDTHAOK8qs3
 c2+QZmohu4lRDjQxOpUaKWrpPE2rAFHMrPm8r7O3EmHatnTW4//3dVKjd+WGrUGRlTzWcrm1I9J
 5KWOfzp4NwgvQ3s2hMgEK8KXICCS0bl/KX44qEnC0vEHRCFcZdHIjmkHLc6lL9Sao5lqO5zT4JW
 h+gHven3RIyTw5+6F/wSaRZVoU=
X-Google-Smtp-Source: AGHT+IGE5iV4e2xjn1791QDY24hyyn2qGnNJNKg7zsyXkbF/6Huq/jN019hvJMWikOyOrO/yxVehElbEVWbenn2G4jk=
X-Received: by 2002:a17:907:7ea5:b0:b3e:5f20:88ad with SMTP id
 a640c23a62f3a-b3e5f20dfe6mr465225766b.28.1759148429525; Mon, 29 Sep 2025
 05:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250814120029.234237-1-Max.Merchel@ew.tq-group.com>
 <20250821191232.GA917481@bill-the-cat>
 <077e9371-4bd4-4c70-b505-428e8a491d83@ew.tq-group.com>
In-Reply-To: <077e9371-4bd4-4c70-b505-428e8a491d83@ew.tq-group.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 29 Sep 2025 06:20:17 -0600
X-Gm-Features: AS18NWCsNF26IxCnvU8_iUQa8-7YimVf2_k_RwCQi1w3s82aNT6WiW1ki5ZXF7o
Message-ID: <CAFLszTiKR2La5GBNBJxYOWZm08+KsqcFxLjdfV+kfBh63=CPuQ@mail.gmail.com>
Subject: Re: Re: [PATCH] bloblist: fix missing OR between licenses in the
 SPDX-License-Identifier
To: Max Merchel -alt <max.merchel@ew.tq-group.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, u-boot@ew.tq-group.com
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

Hi Max,

On Mon, 29 Sept 2025 at 03:59, Max Merchel -alt
<max.merchel@ew.tq-group.com> wrote:
>
> Hello Simon,
>
> Am 21.08.25 um 21:12 schrieb Tom Rini:
> > On Thu, Aug 14, 2025 at 02:00:11PM +0200, Max Merchel wrote:
> >
> >> Currently, the conditions of both licenses (GPL 2.0 and BSD-3-Clause) =
must
> >> be met. However, the original commit message states that the BSD-3-Cla=
use
> >> was added to allow use of the files under a less restrictive license t=
han
> >> GPL 2.0. Therefore, the required OR between the licenses has been adde=
d.
> >>
> >> While at it update the SPDX-License-Identifier to SPDX version 3.
> >>
> >> Fixes: 6c9e3d1f ("bloblist: Relicense to allow BSD-3-Clause")
> >> Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
> >> ---
> >>   common/bloblist.c  | 2 +-
> >>   include/bloblist.h | 2 +-
> >>   2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > So I'm going to defer this as the outcome of
> > https://patchwork.ozlabs.org/project/uboot/patch/20250101195817.995321-=
1-sjg@chromium.org/
> > was that it's fine to relicense but a v2 with a differ commit message
> > is needed. And while I thought about doing the v2 myself now, I think
> > this is something that really must come from the author.
> >
> >
>
> What's your opinion on this?

Yes I agree that we should relicense to GPLv2+ only. If you'd like to
send a patch I can add a review tag.

Regards,
SImon


>
> --
> Best regards,
> Max
>
> TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Ge=
rmany
> Amtsgericht M=C3=BCnchen, HRB 105018
> Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan S=
chneider
> http://www.tq-group.com/
>
