Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29317CD5BD5
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 17:13:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C7F484875;
	Thu, 28 May 2026 19:11:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A8Q+GFL5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75B5F848AA; Thu, 28 May 2026 19:11:33 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86AA184878
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 19:11:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-bd56d108454so2328273766b.2
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 10:11:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779988291; cv=none;
 d=google.com; s=arc-20240605;
 b=VdCAqFHp5Ix5FnLRFFLkrk3O+7ctNYu2vkuAHMXjfPUSLyaLwxWf0jrXUPxe1j/Sex
 tlozt+eHM4sjCA6vnR68pGhTylMsHwroksVpzhe3AciDZG/GXeMS94lwlT6cQJ+QnM92
 MG7OBb9+6zDo682lTzqc+4xnyOrpy1fvMoOU9HuH6qUsQCeERtPbQXQBC1qF1Oaxvvcu
 Xd4w5QnFVJMoV1EfH+nWSc7W96PLjCJgd8fTuPCf5mAr+hrUAGOAcnp2hpcQBOTYdjdB
 6cDt+08uskuXHnNKqGiVwNcO0ATlKWJy6W1PexffoM2MomUR7TYMLnwUa3fZkmk3E9uL
 OP1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AKugTR7v9dQlh2vYWo5w3NFsPmS4+O7yiOigMNh+H08=;
 fh=TLlTwc6e0EM1UOHgq/N5gqp6DtrgO8jLW2+A5GG9ksw=;
 b=L3OllgBg0ax4g0gPwYP/p8HYs24J1KvOlaznzPZCokTErTjvMTrKsvb8Ly95BvVa3i
 BiXr52hLUDlqzVJooPJTetL46kAe83D9TTBzJxh8WrVFrIRcbBEseVKu+cX4WzAxjael
 IP+KQUEhrG8RMjK4n9yw0PxKVph2XrYDPOlxVj87+A/TH6LPTdpS45EDEtmUk32t6/kX
 0qaK9TPTvYdXT/CiXUn5RxGiLNEKFDoGqBc9TQwZs1tozfyyccLz23MZGxWC5pnGBsio
 qDbKFVYpD94kQmzEjRlMmXDVv7/zhnOFDij0RZ1+VMX2u40acMHnUP916Zq5oipHC3Ht
 hkvA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779988291; x=1780593091; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AKugTR7v9dQlh2vYWo5w3NFsPmS4+O7yiOigMNh+H08=;
 b=A8Q+GFL50+sOu6TFBIUVl3+yRN3F26boqIRsnGodkEOLeeuLBaYoQuCQuCeS0HvOTV
 SvRePFNCYxamuKyDQnRqscmbrdMXQnxncLW6GVbhzB1e+yc09i03V89R84kBiJI+mJyL
 1D0vtdQ/96rrY9bzW23LK6V8kP5XpmyD8yOTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779988291; x=1780593091;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AKugTR7v9dQlh2vYWo5w3NFsPmS4+O7yiOigMNh+H08=;
 b=N3LiozxmBuWySZmT+8QLsPgk18ShEy+LxCTyQW/t9POmihi9o43ZmwiHmfOiu8xCti
 2UDSHvDzFbtX2q6c2YVEJtikwFItZXkBqohNPdA1PoGu66CB83mfSMcfeeAl4VUWglP0
 H49aNftURROSUcQy3IAEt1TylJsSGz9WpDZFzGIB9XQihfBsWwS7BliCfgOZhbZCkHEx
 zLA2qVr+Rr3ZBj0h6at5dxh3pdzo0/Zm6b/6sl4sMC3ayD/q5kOGwcwskdoGVCYFUN/y
 xTv0Yh780PcslKT4eTcufKMXAGWZPz1zjISRjnYL+G4OJcyqhJZxmYUcS/toJY20nPfC
 SijQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8wgrQM737otaBkewOklno4fIVYcxjSWOINm4tDLym1suy6oZ3RltXgrK3pi3rxT0YsdOSncac=@lists.denx.de
X-Gm-Message-State: AOJu0Ywoax5mn0P791BGnp2r5Aln0YU9cb2fvIHBTdcgwsEjNcstGenP
 c6/Idx3MUre41Yq2jgy/bh1ZXzpWDcUC5VhbNT67XOxpwkf4wteApAqn0gH90jUFOfrWBoqfTxT
 Fb7gAA1VTEf3SB/4yiJwv65OPGCoFqoCvJOfGcO+N
X-Gm-Gg: Acq92OEouOuR6XQ36nQLsYCyZeVhLCg0wpgCvBbDtXi9YbysFwQ/mKxQBk4ZJHxsE2F
 cYTYJOsYdzDTOEbB7neK3BiDX2RdqMkoItG/ifp2FvidSpSN0ZRe9bS7j22IcmRCS6lBMzB1Ntf
 pXOL9X6WFaSN4k4jn6xoL2CDF7nAZ/eyIiQk076+NKVW92iTp4O/sS7lNhhWj6khZiwGvbbOzWV
 lLDq/UNGNweWYTcM3XQLAwQlFe79yduTXk4XIb8SN3MewXQMa8r8cTrID/EqxTGKnSiBZuEY1qg
 bM0wTJvMyZAT7qzn
X-Received: by 2002:a17:907:3e02:b0:be3:d140:2b54 with SMTP id
 a640c23a62f3a-be973a368e1mr4560166b.31.1779988290849; Thu, 28 May 2026
 10:11:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260527161033.3273795-1-sjg@chromium.org>
 <20260527161033.3273795-3-sjg@chromium.org>
 <6fc3e71a-8872-4c35-969a-f54ce2869947@gmx.de>
In-Reply-To: <6fc3e71a-8872-4c35-969a-f54ce2869947@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 May 2026 12:11:18 -0500
X-Gm-Features: AVHnY4LJAUITnSJ4MKV8cXLdAgvCCBrfLV0PiWYpUbZMjpaGXfVqvPGvKdfqdDM
Message-ID: <CAFLszTjv3St5ZDGQ_GGV2rOtqX_X8MOn9=FocBhbH3gDygDFgQ@mail.gmail.com>
Subject: Re: [PATCH 02/13] alist: Allow inclusion from OS headers
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi Heinrich,

On Wed, 27 May 2026 at 20:36, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 5/27/26 18:10, Simon Glass wrote:
> > Sandbox needs to include system headers in some files, but also wants
> > to use alist. Adjust the headers to permit this.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >   include/alist.h | 16 +++++++++++-----
> >   lib/alist.c     |  1 +
> >   2 files changed, 12 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/alist.h b/include/alist.h
> > index b00d9ea97d6..69d7cdb722f 100644
> > --- a/include/alist.h
> > +++ b/include/alist.h
> > @@ -10,8 +10,14 @@
> >   #define __ALIST_H
> >
> >   #include <stdbool.h>
> > -#include <linux/bitops.h>
> > +
> > +#ifdef USE_HOSTCC
> > +#include <sys/types.h>
> > +#include <stdint.h>
> > +#else
> >   #include <linux/types.h>
> > +#endif
> > +#define BIT(nr)                      (1UL << (nr))
>
> BIT(nr) is already defined in include/linux/bitops.h.

Yes, I should have just used that #include here.

>
> We must not assume that no module includes both alist.h and
> linux/bitops.h. E.g. include/expo.h and include/lmb.h include both
> alist.h and linux/bitops.h. We should avoid redefinitions.
>
> The following is an abuse of the enum type:
>
> enum alist_flags {
>          ALISTF_FAIL     = BIT(0),
> };
>
> As this is the only use of BIT(), we could simply use the value "1" here.
>
> #define ALISTF_FAIL (1)
>
> But as ALISTF_FAIL is the only bit in flags used, the best solution
> would be replacing flags by a boolean called fail.

Yes we could just use a bool, but I expect there will be more flags at
some point, e.g. a way to indicate that the alist is not actually
allocated with malloc().

Regards,
Simon
