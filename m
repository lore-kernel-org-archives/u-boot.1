Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E861EC43458
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 18:33:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3255D8404D;
	Fri, 26 Jun 2026 20:33:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="B+yoMJh5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52411846DF; Fri, 26 Jun 2026 20:33:10 +0200 (CEST)
Received: from mail-yx1-xb135.google.com (mail-yx1-xb135.google.com
 [IPv6:2607:f8b0:4864:20::b135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2764B83FEE
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 20:33:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-664b3831a20so145710d50.3
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 11:33:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782498787; cv=none;
 d=google.com; s=arc-20260327;
 b=na57hvFKV1n8QsZ2sQn6UXmfGxjIn0dBH/vDLaxuH/58/jfNl08AKB9cfzwzvyUG3j
 Y9kYDcIxYtyIQ0CzqC+bYzFrK0kWINLUZdbwsyqfBRpwEwsQwPsp9ZL3aVFxx59oPF7q
 YISefLuqfKMHss+fmehoSxipWix9qKM2se3+KelDg4EDin8CxmmIWl2onomP4RvpDqlP
 8KkKSeB9M/4oskO34mgRXzfsJfho3LzV0BanDZBF1Hji4zvF1OoX+4/wIytAPACQUqql
 A2tW1BbeFZfFwTwz83DbUd+4fnJiG1YFjqhNE7elv8nnypQxOlsCv4hR3fSBy+p0adz2
 A7ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=W9CaTn3W2foZH/pVLqbEs+eixnGhOjeDsZDLMME/VEI=;
 fh=Og8nVfni++7Yuu/n95fDhMQ2jmfhDhnsfIAMH9hk9ZA=;
 b=Dq9VUYJFw1bNYh7JUj14tuIt7Za3dGgECgKfVr4z+3mHjZgRNCMvnZ761Xl9HDdzBu
 XR4dOaSVgcXUIOgZe/CUhT2FzrW/aNpo945Bj9LCpXjuhVsOoU0TmQGEWoJPb7wSRuKU
 TPK0YmAJQvZX1foTYPPQQsbGmWaicOzIrFJT2lFgxS6+fmOZz1fZxYpEbeQ7IcjlVkgS
 8XOPvF4NPVDOO54h6vWzNtz6eJ7ZxN4+MwDhNTN0gHGrYym6R2ksYK5CRkwVCtn/2xVV
 CTb0/BhOpuyb+M8WKGlNuSU5zgga9hJ6fT+MjE2AkZLCUGy4MQywzYWO7HM5dJ2rTFxz
 rciw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1782498787; x=1783103587;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W9CaTn3W2foZH/pVLqbEs+eixnGhOjeDsZDLMME/VEI=;
 b=B+yoMJh55BApSUZO0bZMNrDPYXW6c6yXMMnScRMrC5u83m/EYCbQK/Il4v6YcJkI+U
 YxACTJcmtWXOXaHfYTtZUNVO62NWlHDx4mnQ4VeyiOcxCrVTkZyekF8wsKa8YdeMpHXb
 klhi7G/A9aKUHVVABt9qzrTFoSM9rhPegqj3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782498787; x=1783103587;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W9CaTn3W2foZH/pVLqbEs+eixnGhOjeDsZDLMME/VEI=;
 b=C2I6KeNy8ZirfACBNJ0ShcjLEargkgRWJZW4w6PBTce2tNCP1qJ4IjrABq8vtFnUrE
 y+OGy59Q4WMpvaSj1BAg5aRt50D88pzDAIKefNvRJzOQAuBiWr4ym/tl7pF2u0lpHYSX
 y4t9fvc/27aI7ijO3ofF6dkHKDhoh7GTL8okYsX7EdowJtz8m+5LB/4bR2+KD9MsOWE0
 heV6aS6zHQTCwk/HVPbmxD5+3GXgSK58RADsCUy3crjsWbEg6ZTNzwcbVmaaYk3VF2Y/
 48tGPhYptQljwon2RJJ7mHpY6zzf14Ib/3wwoez7KlKOaCVCEpz0bm9hJ0iW1B9zDW/t
 1baw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoMXRqhwbdhYpzOGXiXFGkwn22WriW7dMDkhdchOStYZ+Ekr8KU4GqqqRWzI6hHxumWf7sgwr0=@lists.denx.de
X-Gm-Message-State: AOJu0YzW1V//KkoGEXYsQFSgNjMqFtAoIgmHg0QaH7/PprDaYe+hK4Pr
 85ZbgdR8yp63+WAsIu5s+4Z9cCuPqm4juX80jfmBojXxztnKs13YTR3bZ99HgIvI8s0RvSdd4G/
 gzo4vU8yjVFXNMEAWHu5hnJx80FXM5xhbrvqRty9rlA==
X-Gm-Gg: AfdE7clt8JCV3ut5mM/yPXwMmSvP6i2lIIYZe7I/ZNL+JhFdjXXcQTMYSl9eW/hIRss
 Dw5rerL4j81eDoYnIMYaDvDmdyvSFjuPdyB00fsSHjZOu37ElzkcBnOhKg0V6JuFnrMjs2RNdEG
 nHCCtISoRRSEmx7hG0yoYEaD6ezNCEUTPTJtG9m7vCnV90mGnVJ+B6/PDYHfAD1ayU3k3ZApV3/
 5kSL/sTDThnh77Ylzc50RnleSwxIHWPsltSuhWNqvpSXz/cEKWPp0p/HrWZWrg2BBTI+BgOQQFj
 eMm3qvO3NsgALjqZeHwZE8Ixwrs=
X-Received: by 2002:a05:690e:34a:b0:664:ae6a:e9aa with SMTP id
 956f58d0204a3-664ae6b0c94mr1015761d50.80.1782498786795; Fri, 26 Jun 2026
 11:33:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260622224344.GF382693@bill-the-cat>
 <6359ffb0-804d-4241-ba70-941ed36a4f20@cherry.de>
In-Reply-To: <6359ffb0-804d-4241-ba70-941ed36a4f20@cherry.de>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Fri, 26 Jun 2026 20:32:55 +0200
X-Gm-Features: AVVi8Cf0475bK80RpsmyWtBgt4Hb_wopsd7AujUGZHVqweofznkSsiEgIAOktHc
Message-ID: <CABGWkvqhFz3ndriELZk3mvsSdDUQdfS65WyRJCRbmFAGBRoJVg@mail.gmail.com>
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hello all,

On Fri, Jun 26, 2026 at 8:28=E2=80=AFPM Quentin Schulz <quentin.schulz@cher=
ry.de> wrote:
>
> Hi Tom,
>
> On 6/23/26 12:43 AM, Tom Rini wrote:
> > Hey all,
> >
> > Coverity is back up finally and so here's the result of changes for the
> > last three RCs.
> >
> > ---------- Forwarded message ---------
> > From: <scan-admin@coverity.com>
> > Date: Mon, Jun 22, 2026 at 4:40=E2=80=AFPM
> > Subject: New Defects reported by Coverity Scan for Das U-Boot
> > To: <tom.rini@gmail.com>
> >
> >
> > Hi,
> >
> > Please find the latest report on new defect(s) introduced to *Das U-Boo=
t*
> > found with Coverity Scan.
> >
> >     - *New Defects Found:* 1
> >     - 4 defect(s), reported by Coverity Scan earlier, were marked fixed=
 in
> >     the recent build analyzed by Coverity Scan.
> >     - *Defects Shown:* Showing 1 of 1 defect(s)
> >
> > Defect Details
> >
> > ** CID 646439:       Integer handling issues  (INTEGER_OVERFLOW)
> > /test/cmd/part.c: 53           in setup_gpt_partitions()
> >
> >
> > _______________________________________________________________________=
______________________
> > *** CID 646439:         Integer handling issues  (INTEGER_OVERFLOW)
> > /test/cmd/part.c: 53             in setup_gpt_partitions()
> > 47            snprintf(dev_str, sizeof(dev_str), "%u", mmc_dev_num);
> > 48
> > 49            ret =3D blk_get_device_by_str("mmc", dev_str, &mmc_dev_de=
sc);
> > 50            if (ret =3D=3D -ENODEV)
> > 51                    return -EAGAIN;
> > 52
> >>>>      CID 646439:         Integer handling issues  (INTEGER_OVERFLOW)
> >>>>      Expression "_val2", where "ret" is known to be equal to -22, ov=
erflows the type of "_val2", which is type "unsigned int".
> > 53            ut_asserteq(mmc_dev_num, ret);
> > 54
>
> Does Coverity complain if we do:
>
> ut_assert(ret >=3D 0);
> ut_asserteq(mmc_dev_num, ret);
>
> ?
>
> We also use the same ut_asserteq() check in many oher places with the
> return value of blk_get_device_by_str() so I'm surprised it doesn't
> complain about those and why.
>
> Cheers,
> Quentin

I already had the patch ready; I'm uploading it now.

Thanks and regards,
Dario


--=20
Dario Binacchi
Senior Embedded Software Engineer
M. +39 328 0625246
dario.binacchi@amarulasolutions.com
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95
Amarula Solutions SRL
 Via Felice Cavallotti 25D, 41012 Carpi, MO, IT
info@amarulasolutions.com
www.amarulasolutions.com
