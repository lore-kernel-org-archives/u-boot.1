Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4299F45A12
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 23:05:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 412AB8419E;
	Sat, 11 Apr 2026 01:05:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EgLxbr+2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C0D1841C2; Sat, 11 Apr 2026 01:05:51 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B5ED84099
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 01:05:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-66fb5f2183fso4535662a12.3
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 16:05:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775862348; cv=none;
 d=google.com; s=arc-20240605;
 b=fph0AXbEwwdHLySLoV7mxosjfb1ts7X+ifc5R1In+meyho9hKiuhX66rUtQQcVKmUu
 tX20rA7Z5d3owCVdskkcau8/w27/ATUinyOobnC8DmIGsVjS+lI9oncCc6iwFEPqNL2n
 WSeTSjWesHLFHYOl3SnJUnpCaHhAne8KSRsVFWw3V66YGIwtB5oQwtgXzyX7PJIQ+qID
 5Lngxd/9zleRXqDikFwoDh5uAp0RfzbnsokCfxW+kljiK2S67kJ2LdYnAG0amRltJL1L
 LW/vtx+pyqhwMT+CelxbVVrcnd31NJbl1pmu+yIjbOghD5VNUYYpyD8/FAH1NQwcIZBz
 49Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=iG3Fi3bifYETjD0FtDjvtg4xtMeq7eojMfJp3La+dgI=;
 fh=4qB3mb730ZWpYHDqeRWveSqK679IS8Wf7To6jYrG52Q=;
 b=Rr13qWsdBbc5QgA6z+eA61Fnc2H5Pwcw7ciyv3B0IJbkNkCPFSCs9PfEgqr8IbthzL
 4psvxe3zp/nVV9Y2oieyZoGjyGnQRKJHjPhCI3ciz2IwwKICdDGMGj4Cf7MPP2OWLED3
 VJzwrP2RO6TMQ2iBAm8OPkpmkj6vyJiTjxC9LDJVpa30ERFpAPUUujIuHBw9EJguPsHI
 ZMfDuiBIJWKM4AmHrM6XPhLgacV0O5qLB5kESshACWDne17EzkHrznYh4cjkFA/NQE84
 OMfwYIVovnb7hxZ7W1KRNbWY12sCXqacIRPrd+h5CptH9mTRSlo6Z2QrjEZIGqRy7Cqn
 S+vg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775862348; x=1776467148; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iG3Fi3bifYETjD0FtDjvtg4xtMeq7eojMfJp3La+dgI=;
 b=EgLxbr+2LIRIJpV76mP0OHxNnabJ+Dmff1kQRWRpdrhPpMZnuqaLpJscOfKrB7F8ef
 XA+wFRMH7wDhUyDg+QfJrjDWDYPz1nAt4d4/6urNqUnNi5npk/uYEsnIKb4KFnDZvJNL
 GObXDhePw1gOIi+sKybFKCsQUbXoA7VtvAuMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775862348; x=1776467148;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iG3Fi3bifYETjD0FtDjvtg4xtMeq7eojMfJp3La+dgI=;
 b=q1WU8/4uMNvohSRInhMVtq4sc9hI6LUlYZM0ox5vnhhJvJxuSIr1iTVOWIrla8/iZS
 5H2NyMAN0vr2/ndj2yh1tRV4ZWNxEtOsd73zo5rBocBp6wwBhBKLLo2d5QHlKD9kEGgu
 T/Cc/P+yI10qBETxYCiAZi7ge7WAlskfc3irNNSDS2WK7CK451+EJJpCCN7B5wop0+an
 ufEsrY+pDHgP8BK4ffxGlzcZxzMd3z5PiZsaJ81LC98kCJZRbeEqjCdg3vvxpQfbOfgk
 JzUVHeyhgPsm8Fu4w4EJiAdjxnDU5leCe85kYQg/zYhrGCfEgAVGPUEqggtNCIIGIUgn
 PHwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVm5kv24a5+L9c6QeWXcHYAVT7XdVkwZbRTExTBM7xnh0gmeMnE7yv3urSkUk+6alvmH//81k=@lists.denx.de
X-Gm-Message-State: AOJu0YzI0Yr8ZaccREX9u/BhLKdpxPFXHRC9hVjKYDX+HmdfROR40uo8
 cLCgkQvz2rVpV3QeG9uWaGtcCSuf3iRr3GwO61rWsh1rOjnFQLEcBrlI4ouN9qlO28/RD7UfGg1
 cHI7mOs74xBtQHRR3/e1EvQhthB8Qzb3ext1TvO3F
X-Gm-Gg: AeBDiesWtvJkfydZYeRh9HqbbMEHTI6A9+ll7kh+x1pKgpvE4V0TUo+QDhHg0sVt4Ts
 3WEEDZCauARa4zvWnZ7uI7AeahKqacy9ClAD4wXwR9xPiBY4ynvJ2lff7djUHoHQAHcpuZxM4iI
 4mmo27CvvEBf9VtUeiMrSfEznm2IcS+Bjg/w/s9P/hBXiCGDjkTwK1k/WKvvw4XdmwW2l3PjeWJ
 JNKutYNDgNq98ILDSHGRYVc5U7/0juV3cKNqczTwJ+eIgFbh9bavSigXAoPOZ/CSyONVnrUwJsh
 S7aVyA==
X-Received: by 2002:a17:907:9615:b0:b98:6984:6627 with SMTP id
 a640c23a62f3a-b9d729c0986mr287073366b.40.1775862347967; Fri, 10 Apr 2026
 16:05:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTgR=jt+P5NciLw80PaCseZZw=XMT-Ha+NHQFNXxfMfndg@mail.gmail.com>
 <20260403153733.95117-1-matwey.kornilov@gmail.com>
In-Reply-To: <20260403153733.95117-1-matwey.kornilov@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 10 Apr 2026 17:05:35 -0600
X-Gm-Features: AQROBzC9CcCPC1CuC5z2-OEzpvxWV-h9NeBadWo1NlN-ebd5IwCgCMOOQK4Jil4
Message-ID: <CAFLszTgRtbfZpGeF2qBwNC=-k5JFdW+dqUkqriFy=fStZrKrcw@mail.gmail.com>
Subject: Re: [PATCH] doc: Fix fdt resize argument in fdt_overlays.rst
To: matwey.kornilov@gmail.com
Cc: sjg@chromium.org, u-boot@lists.denx.de
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

On 2026-04-03T15:37:33, Matwey V. Kornilov <matwey.kornilov@gmail.com> wrote:
> doc: Fix fdt resize argument in fdt_overlays.rst
>
> The argument is parsed as hexadecimal number.
>
> Link: https://lists.denx.de/pipermail/u-boot/2026-April/613799.html
>
> Signed-off-by: Matwey V. Kornilov <matwey.kornilov@gmail.com>
>
> doc/usage/fdt_overlays.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
