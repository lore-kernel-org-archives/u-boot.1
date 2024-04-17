Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43571C4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 00:14:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A32A087FB6;
	Wed, 17 Apr 2024 02:14:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ILOI2CRq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACA1288003; Wed, 17 Apr 2024 02:14:09 +0200 (CEST)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21CF887FA0
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 02:14:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5ca29c131ebso3298491a12.0
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 17:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713312844; x=1713917644; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HiskrRFbVlenrzQYTAsslT66jfjZ+jbob8K8PUmHi0s=;
 b=ILOI2CRqLvQf1SYoGhMCOT642hNhkQ4mAzq3HEMGpd0CnBNXklM+bDdo1xiZTE+Y9q
 HnsypqNjISete23Lg3qfMAFkB8fx2dIe37YBX59z6nLDzFf8Q9b1R14wud2KWTIcYzaI
 ktYq61khM3n7NPsaamouryzcSGibwe5gDFW4WgN6I9tdrPZAhflmt7oIHoQ5HE24tYMC
 peD9YOJn6O+mhWe1gQZZawnmCRy4d+uKuMZUPjwAzWfq/OjpKdbPFMgfY2TOaRACillj
 /oNG9PW5Vz3ARWe0ZlGNeTKtqiM3eZHFOquc9y+lA2mgWjQOcgMv/481h7cEsC8m7Q0E
 Idiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713312844; x=1713917644;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HiskrRFbVlenrzQYTAsslT66jfjZ+jbob8K8PUmHi0s=;
 b=Sv5NxaCAtzMSQOgLJGBahuG7g12DKmx42rilncWJQI9oPGZtV1ikwLstz3xB13qdr4
 AoUpgkcrHVVkWAGok1HPXsV830pyHSskvzafxik9E/kLBVi104paDcAVUlVRB/ZQyLHs
 gHHga0o3G8wxZ3R7DjrJpbiaKRrJ2dDDL+3l/KmY+P7+ZOns5g9bvQquSwhc6uNFMM3a
 Ha0CBB+lnG4JducaNeaoDT5MROw2J6JJkvf6ctQTFFZAKYwDHOm0WV52S7xuqyR+SaAT
 wXW0h57aNdY2F6Y6Dv24WmjyBBrwCYwGpyfqkX3dENWTSRydjwEzj4Erfatq1XlGnM4o
 QNEw==
X-Gm-Message-State: AOJu0YzhqM5gSiuU5UuBb1omaquHw9r3qpDgm8Duu0CG2QqK/MfUr+hC
 5wKRIHX8IZyWJwFFT47RQUodqMMkCxVOw0jApuYx+DzikSEYw2E0nk6OiDiseaTV+tFK5Vg/hiu
 jQC/0EVAX0M7Yebk/Dxv09dNVaAUljiDqQMn0C+QlmZKOW7toz5w=
X-Google-Smtp-Source: AGHT+IH1O3IdXQXf64+oCt0MDtIlDCbN98RQGXsD/wyp2RKn287AayPoYAeGEHLp/TBcu5QgktqJQYpayDludmpyDKo=
X-Received: by 2002:a17:90a:4605:b0:2a5:3753:6050 with SMTP id
 w5-20020a17090a460500b002a537536050mr12304158pjg.46.1713312844517; Tue, 16
 Apr 2024 17:14:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240416190019.81016-1-raymond.mao@linaro.org>
 <20240416190019.81016-7-raymond.mao@linaro.org>
 <20240416191947.GV1054907@bill-the-cat>
In-Reply-To: <20240416191947.GV1054907@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Tue, 16 Apr 2024 20:13:53 -0400
Message-ID: <CAEfUkUJi-CCxPo+o1TepxWTNugJhZ23X4YupowiiwLB+90ojxQ@mail.gmail.com>
Subject: Re: [PATCH 06/23] image: remove redundant hash includes
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, xypron.glpk@gmx.de
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

Hi Tom,

On Tue, 16 Apr 2024 at 15:19, Tom Rini <trini@konsulko.com> wrote:

> On Tue, Apr 16, 2024 at 12:00:02PM -0700, Raymond Mao wrote:
>
> > Remove the redundant includes of u-boot/md5.h, u-boot/sha1.h,
> > u-boot/sha256.h and u-boot/sha512.h
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> >  boot/image-fit.c | 4 ----
> >  boot/image.c     | 2 --
> >  2 files changed, 6 deletions(-)
>
> Can you please explain how these are redundant? It's not clear, thanks.
>
> Both image.c and image-fit.c include image.h that
includes <u-boot/hash-checksum.h>.
So we don't need to explicitly repeat "#include <u-boot/<digest>.h>" in
both files.

Thanks and regards,
Raymond
