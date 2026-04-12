Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D31F3ED4A
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 01:37:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEEF983BC4;
	Sun, 12 Apr 2026 03:36:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="j8jgMFwT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 087E8839D9; Sun, 12 Apr 2026 03:36:39 +0200 (CEST)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 749C7839D9
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 03:36:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2ad9516a653so15302935ad.0
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 18:36:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775957794; cv=none;
 d=google.com; s=arc-20240605;
 b=cIfq7crHobEVdBARzHYkbcqpRQinVGdnX8Nh0bNwR/5s3l0nsvZfowgcTIdeg/jYcC
 A7KgJZgOenebH35vxCqIvFoaU8QBS0nTdEhcqdKa0qWE46C4eK3gYpw3O14SrSG9hdeA
 DyybVjo75kIpztNs/7Sr5mkQFcpMURNduj6byUxZvZEVt7Gd7mg0KjoMpCuVJH+FhjOh
 XxJQQlaHprI9KKcAbqP4ESK5w6OLOARlC2C1W8eucCVfNeyUiSzTOqNXxwniUtAR7DGx
 xvJLXcGTawPLp8r3/YOOSmtGetm5BVgirqjRbaT9WVgkJw8eQg7esl3/aA7LiXDBNlgX
 BAfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=83XoxZF10/D7FoUGT0g1iUGPAmHcJMzTav4Gs9Q+EDM=;
 fh=IdwO/rC/acyyEduxN1uOkpxtcUbuHgO/3u2O629Abb8=;
 b=ZRGGVLz1PmF6y47wGhjwyrJrrzfMflnT4/UNx6XEE8Nfb345bqOwHoMH5Zb3N/fUka
 o47checuAXegNchDmNhJHvNOtgObg4ThfVsmgEl6o/G3scOFARaeurJzwikh6HfF6P/e
 1BL8BfugY/ZF4R76Lfkg2aprGLcPn1m9Cr4t/4jCJWnJMuVtE7fVo4jQlTBJuUe4YsA5
 vHW+psXXdlJCISUKHQ344dJAf2XNA3UGsLRWkE17Mbmza4swNz32Hg9yYKfRWYuvbnBC
 Oj8YV/ewE8ycLwIzVmY/Clg2acoEW3M8NuKuFgdl5LbBYIMuwxZWVF9/07OklL78X1dQ
 7+Ng==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775957794; x=1776562594; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=83XoxZF10/D7FoUGT0g1iUGPAmHcJMzTav4Gs9Q+EDM=;
 b=j8jgMFwT1aJ09apNT2YCVZElJr21a/Zkj7IUlNVWdayYqh+5nKFFA5PQFyl1AqBvig
 B5dwwymZzF2kinlCOys91zv/bXh+TUrJK4LiX5RX46kKL+aADigiw6dLX/QK5X0n2nGI
 gyqSPhMgSJbTgjVm4JOkiUUg6z/jNKpdLu7N8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775957794; x=1776562594;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=83XoxZF10/D7FoUGT0g1iUGPAmHcJMzTav4Gs9Q+EDM=;
 b=cxVdndM3JaakQC9gGlGmkNFgwpXCeZ4ut2YDOs0PSiF3xNRizuIX9GmNh9dK2KRTBd
 ZBpIkp/Zz9/TmdoX2Qw5D2N2fBzNlDHtyA9h3SLzsm6p2Xg+QRFJyp9EQw4uInfBSOfj
 sabKEOrS961yqIyoxNQ/KSKz382V+CvQNCGIcyB5/Q5MKSnzERusJhM54G6sBzWEHb7q
 WdWOn7MLym/7kmA/ZodAz1Lw9Y871YbMM7jlpVezGnm1U5s/OYVANpJj/KaxEtEpvbE0
 CWhwptqMxXA/+kQkbPOU+8RDZ9+DTb38Zd00ZrwOUWKYKwccJ1QYt1HFy5492RFICYTB
 4/bw==
X-Gm-Message-State: AOJu0YzFnpqCRYuokySDHwOM1rQnVvV8QZxEvclxTBjc4BcTvbu+B4Tr
 2t9Q8dY1/iQbRiDe/Tp5jquXqOLZfXsixoDH4wX2RuUUC27XJ4K+2W3yvpqunNCvCOHNDanVG2/
 N5h58VGWO1QwQTKe/el2jp/r4/w7ZO0wXk+j+uuNhGUgtTIM/1MU=
X-Gm-Gg: AeBDieu3aP3IcGpZCtohmvT/VYBWUbTmdf0BQIjDNwT65OdKeYYSdFYmL6JmoQ6izDj
 wR2ARWzW6AO20VeVgpHI0DSd4Otfp7U4ATyIOHggXs4SLzBNBXRAGHuh+UeQOyF9oxtr0St4WZR
 rd4bwO9y1LN74lFGv7CY4jhkNaGBw/ddLvp1u954MnX9ZXFnJljEYWov0IOOoNgjAjK5e5Hih2u
 tmj5ozF1v9K1bMcsf5uBDjHfgdw9G9yKdLltUMeN2Y6FTaKNkAvVPhtHUbbiVxNFmW3GOvGYFJf
 Stfv/8+aTUSZYK0W
X-Received: by 2002:a17:903:1aa7:b0:2b2:d463:b8f5 with SMTP id
 d9443c01a7336-2b2d5a15f6emr84157025ad.21.1775957793748; Sat, 11 Apr 2026
 18:36:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260321134626.516665-1-sjg@chromium.org>
 <20260321134626.516665-2-sjg@chromium.org>
In-Reply-To: <20260321134626.516665-2-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Apr 2026 19:36:16 -0600
X-Gm-Features: AQROBzBxSGMg8oCZ6gvTKPmqShnxsusstkwhtp26Gtf2FA24_W45u3Urjx3MusA
Message-ID: <CAFLszThfW=K1h1q2rHC5cFYNQ5SCiPBMMDKOxEXUTdxxwYo-FA@mail.gmail.com>
Subject: Re: [PATCH 1/2] linker_lists: Fix end-marker alignment to prevent
 padding
To: u-boot@lists.denx.de
Cc: Simon Glass <simon.glass@canonical.com>, Tom Rini <trini@konsulko.com>
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

Hi,

On Sat, 21 Mar 2026 at 07:46, Simon Glass <sjg@chromium.org> wrote:
>
> From: Simon Glass <simon.glass@canonical.com>
>
> Change the alignment of end markers in ll_entry_end() and ll_end_decl()
> from __aligned(4) and __aligned(CONFIG_LINKER_LIST_ALIGN) respectively
> to __aligned(1).
>
> The linker places zero-size end markers at aligned boundaries based on
> what follows them. When the next list's start marker has a high alignment
> requirement (e.g., 32 bytes), padding gets inserted before the end
> marker. This causes the byte span (end - start) to not be an exact
> multiple of the struct size.
>
> The compiler optimises pointer subtraction (end - start) using
> magic-number multiplication for division. This optimisation only produces
> correct results when the byte span is an exact multiple of the struct
> size. With padding, the result is garbage (e.g., -858993444 instead of
> 15).
>
> By using __aligned(1), the end marker is placed immediately after the
> last entry with no padding, ensuring (end - start) equals exactly
> (n * sizeof) where n is the number of entries. This makes
> ll_entry_count() and direct pointer arithmetic work correctly.
>
> Fixes: 0b2fa98aa5e5 ("linker_lists: Fix alignment issue")
> Signed-off-by: Simon Glass <simon.glass@canonical.com>
> ---
>
>  include/linker_lists.h | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>

Any thoughts on applying this one?

My test series depends on it, but I'll send it as it is for now.

Regards,
Simon
