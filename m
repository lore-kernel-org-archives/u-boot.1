Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F4A9CE7A89
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 19:53:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB65F86B6D;
	Sat, 23 Sep 2023 21:53:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="VokJXa0+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CC4386B57; Sat, 23 Sep 2023 21:53:45 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 673C086B38
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 21:53:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2c00c0f11b2so63946341fa.1
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 12:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1695498823; x=1696103623; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MMLpOBZQPznv8/wmmTBMbmJ1UHX8i4veNn2NE8XbSso=;
 b=VokJXa0+275K2Fx0vByheB7UPmT05nrIvysxsWotBW1969dDsDQu7Ejc+eln+yq5dk
 61ZxWisWJcW3M18TyPeGG6rFh1xPieGbCZ2wEG2hpDNvs1XIFrQE9JxI1DsnhnFIs+Zk
 zN+K74Ps6Cudy4ZMRzI1foddxB9x3xd0a1MLeqYVkXXX3uiumKhsOgQBa6OBi4qmGWPy
 aJMA5NQaRLfN2BHPfSCOAWuzEzzHSZB1uE4FZ53Pw4H7QpH8b0b4ehZNBgjSXKnqMJV4
 uZ5d5HzP2oBuMYdh8Iof5UTyHxgpebFryXgbp1NT2Ko5k3aLyveNXDmXSjPdr/mQEI/F
 Zxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695498823; x=1696103623;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MMLpOBZQPznv8/wmmTBMbmJ1UHX8i4veNn2NE8XbSso=;
 b=CGkEI3b2432H18XfJRkrRS987kWUpUBWI7Qfc3hNGHrXhqNag4o8nT3p//4wTvke/3
 byWHcQpjQ7jWHlRjn/9E4y73wRLbb6xbd/3KHO2g7g2sqz1+0bTkpQZLF/FIChyq7Kix
 S7moPUqZSw17GOslkKjOWt/8N3B1kWlToxf3YV4vKl6t5/2XnYw9rayDsoha+Tk72JC3
 pWQL3QZrzANwFJjX8gajAhVN/KrOHPEXZT3jMGEqL90fGrUlAj/d+3vjHYXvJadMmwAo
 PK63XwBqRnlP8rR+euRqsCmNNSsswZ9lxNaoLXdfCcS/2Sb6Pc20TZhEpl1b+46mswM2
 TIcA==
X-Gm-Message-State: AOJu0Yzaxpt+i9jg7h3r0NpF4qVg72V7JGJr0OuFrVUu5JIKLq8UaKYe
 z2C1UgY6lJmkafme4uHCrlzxXzWIIcXDCeBVOCT5RA==
X-Google-Smtp-Source: AGHT+IETLXlYC0xVDtT8416LXURKNcvReq7zbEGSeU3Vk9RnTkH5O99NySwrCEZgUhQ8hGc5CwXguL20o/80qJZ01cc=
X-Received: by 2002:a2e:b004:0:b0:2c1:2995:b671 with SMTP id
 y4-20020a2eb004000000b002c12995b671mr2468335ljk.42.1695498822582; Sat, 23 Sep
 2023 12:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230918083231.20092-1-mps@arvanta.net>
 <ZQrpXpdKKbXyuDkY@swlinux02>
In-Reply-To: <ZQrpXpdKKbXyuDkY@swlinux02>
From: Simon Glass <sjg@google.com>
Date: Sat, 23 Sep 2023 13:53:30 -0600
Message-ID: <CAPnjgZ3AVe51nJqc2z4dds9T_Z3AVOJ503qv5zQJQZnDH5ihYw@mail.gmail.com>
Subject: Re: [PATCH 1/1] starfive: visionfive2: add mmc0 and nvme boot targets
To: Leo Liang <ycliang@andestech.com>
Cc: =?UTF-8?Q?Milan_P=2E_Stani=C4=87?= <mps@arvanta.net>, u-boot@lists.denx.de,
 Shengyu Qu <wiagn233@outlook.com>, Jami Kettunen <jamipkettunen@gmail.com>
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

Hi Leo,

On Wed, 20 Sept 2023 at 06:46, Leo Liang <ycliang@andestech.com> wrote:
>
> On Mon, Sep 18, 2023 at 10:32:29AM +0200, Milan P. Stani=C4=87 wrote:
> > boot from SDIO3.0 (mmc sdcard) first if it is plugged.
> > If mmc is not plugged try to boot from emmc if it is plugged.
> > If emmc is not plugged then try to boot from nvme.
> >
> > Signed-off-by: Milan P. Stani=C4=87 <mps@arvanta.net>
> > ---
> >  include/configs/starfive-visionfive2.h | 2 ++
> >  1 file changed, 2 insertions(+)
>
> Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>

How about converting to standard boot and then this will be automatic?

Regards,
Simon
