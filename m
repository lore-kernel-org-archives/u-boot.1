Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C796C3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 10:28:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2F46888AA;
	Wed, 24 Jul 2024 12:28:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B1nLZTCT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AF38888EE; Wed, 24 Jul 2024 12:28:56 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F653888A5
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 12:28:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3db05db11e1so689475b6e.2
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 03:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721816933; x=1722421733; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oKtIusj/5n2SL9ZQ2pWgyZiIx2KsrVMgYD8EOJVinMg=;
 b=B1nLZTCT+QEbctsuDsQvG2A0IiUmLCi8iKDk47n5Qn83N1TiwvZaRaSAoVxA5IrAbT
 frTpBNYIEVCVOFv2M9QHVm/FaqFsrsMS+JUjNEEoYMUQhZyrIJ8sxHz1MSS/zM+y6bCu
 Ht5jzXgmElE5YGx7TOc8llkMGkOtWjSRcb9k+J86ODf3tZORR3V/PUuCc0cQmMmfUF7q
 J8EOyWk5wNHWCTs5xjdXzKzBv0mi1muNILYozrGnvhqA0p6wSDg0vsodXx7EfHommLpH
 qr8V4CthuPJ20tOINXvkI59EghVK9jz5IMTbCsMMUYCfipP5gKdMlwjAvdMO/hCyWiYG
 ZGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721816933; x=1722421733;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oKtIusj/5n2SL9ZQ2pWgyZiIx2KsrVMgYD8EOJVinMg=;
 b=oRSaAZvFND0+gJxLGOTpTlUYojp4SBXsPfB07uXXYqNItQpK2fhIb1VlbtBs+u0qH4
 yz1fzjd7ZOaeABKdXjMycGQNkvSGfyR8H520lLLOgrlzLMA/duc03pVTyO/iRrVzgVZW
 3seAWQ9UjSYk0lUKWJPnqXcLUbxunE2/ZZiRKiox/hzXiGaZ02O+92bM/tU9KE/qGJ/K
 QUipSVK3Rk4m4dqNftkHOT1Nw5VQ5BYXjGzm6nUZ7bv87GlTVZdyHymbbowllvdWnDnQ
 eQw+C3sbgbUwrW913l1ATCO3wrSVKs/2vfMHl12FYlgLCBK5yurMwa2TLxtebMtUFXqu
 GqxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKEh/Nr7jkyb2Tgdh7iTSYJm6keLuC5UIbIkSCHbAXq2Xe6fQ+lPLW0K6VjmZYO8jfEZNOadJeT++3UlZmaTx/CaSTPw==
X-Gm-Message-State: AOJu0YxlwDTKyIOYt9ZqbuKogHzZyvvAVYL0Bov4DQS/6MltMKpC5dVB
 Oo/8uPuPcFNwYUG9lT6FVVkFHWvR56zEg3390HLsIVWz19nL/Hp4AGXfgzAgpvqp5InAi1s+4y0
 2Qw4EXV1iZsr1620zMFgQANuP5yc=
X-Google-Smtp-Source: AGHT+IFbcUl5VwgeLzgMf71sdhrxlV9oJ0WsXjX/a9RqWLlY6WOIFD7Wc5lvRvsWY8v4ktWUp1LV1HYySoowDrazsOU=
X-Received: by 2002:a05:6870:f115:b0:260:fdd5:4147 with SMTP id
 586e51a60fabf-2648ca30204mr1413461fac.15.1721816932794; Wed, 24 Jul 2024
 03:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240716031709.24943-1-semen.protsenko@linaro.org>
 <CAPLW+4mAqpgWwiX4fvZFjWMWPtY9Mx11b9oPghzfpFoD8FU98A@mail.gmail.com>
 <CALrBrZ1d-1Ytxtos9-NzDjNwyyY8T+aOqHU03+KDhJLdMYPt6A@mail.gmail.com>
 <CAPLW+4n1zkoT8L6QDW1CKxVn=auK=VhaNR4LmJs60hvvzyNs2w@mail.gmail.com>
In-Reply-To: <CAPLW+4n1zkoT8L6QDW1CKxVn=auK=VhaNR4LmJs60hvvzyNs2w@mail.gmail.com>
From: Minkyu Kang <promsoft@gmail.com>
Date: Wed, 24 Jul 2024 19:28:40 +0900
Message-ID: <CALrBrZ2a6vOoi9ofpbNkP9-pjJ9XZJTyoRB2hjK+KSrBdY4GnQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] arm: exynos: Enable TRNG for E850-96 board
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Anand Moon <linux.amoon@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Lukasz Majewski <lukma@denx.de>, 
 Minkyu Kang <mk7.kang@samsung.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi,


2024=EB=85=84 7=EC=9B=94 24=EC=9D=BC (=EC=88=98) 03:23, Sam Protsenko <seme=
n.protsenko@linaro.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> [snip]
>
> >
> > Your patch was failed to apply to u-boot-samsung due to the
> e850-96_defconfig.
> > please rebase the patch.
> >
>
> Just sent v3, please take a look.
>
> > and about mmc patches, those have delegated to mmc maintainers.
> >
>
> Do you know if I should I ask some specific MMC maintainer to apply
> that series? That series was pending for a while now and I really want
> to get it merged as soon as possible :)


Mr. Chung will check.


>
> Thanks!
>
> > Thanks,
> > Minkyu Kang.
> >
>
