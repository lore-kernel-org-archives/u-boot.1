Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BDD8C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 11:51:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C0B487D33;
	Tue, 28 May 2024 13:51:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="o+UWVr9Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8590C87EAC; Tue, 28 May 2024 13:51:01 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E68C87AD2
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 13:50:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1f480624d10so5791075ad.1
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 04:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716897058; x=1717501858; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LHim6GJKr/d6ob363g6M3Xrcvq2PkDFhv3r1tmUAyFI=;
 b=o+UWVr9Q9vHo2bUMp42hSeKUvKDUvqqCgd8We2SKO6ap2nEx50ViO458iyp4cRNZFh
 i/zkZbbzSmmr/J3bRGsoegTgn3oTU3w7NnuKbzrSW/MAa0ojZ42q+WZ8MOj1ejT2xlzY
 pVNu6qLwL0u78sO1DSzlb7trdHgScfCIo5X9dyvHgTpfohdPfiY9kwnJ5vw1g2V47I2R
 b/CF6kPUtJBLlqgQtZtpiCwikrQGM27FxY9jS0FEdYz3s+RZlOCIeS80T9ofGa9vpzHy
 pVVNgqA2AOZbjqLVOXGP66m8aUs+rxEH0tzVQYNmlbghoEdXv2nzj+g61mqptpu+bozZ
 IP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716897058; x=1717501858;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LHim6GJKr/d6ob363g6M3Xrcvq2PkDFhv3r1tmUAyFI=;
 b=ccji/6oDKmXDHkjI3gyjBaLKAgI2EE6iAU74R9Y6CCv9T7BDzeGt7v0v6qEjO2QAEN
 mD4KFdBP3Ca7mOzR5YN/jo2v9364RR+9jp51lbx94RBCFc2L/aj5TND/LlM30+ckNtXI
 XVg8cZ/3Lg9AoIsvcDBTuiGtHJOuFP3/0YekRhX5ZYTmfvvMwrvc3MJCCpo6p4v31hQJ
 Rn4O0Y5EQF+LuU1o1cG8UqgHPxsSTmvdneMl4Ac9b+kk/4ax1QDzCKCJSoWoiWqgNxDW
 Kl5v/b5h8+ofbjM5I/se9G4yPFVmQYx6j9BjLIziAqCVkNJYw0V6kTbJyF8HsN3cSwYF
 O/fA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWF9v4B7VA0W9KmZtB+WX3mISgM8uQrVNJ32wyT7hPRpI9Tzx1bSoPdzwo4gH3u+KNMJrX3itT59wv7s4rni4mbS1+EbQ==
X-Gm-Message-State: AOJu0YyJehsvf9JPdLw7ZvZ1WRCKRu0WAAlUgTRPS2hKtW+ujVjVSjZU
 QK3eMmv8pOJi96xnhWDLhlVYIxReJXkGSdvZFoEIe1hWadTB3dAm26zKiMdk3csweASB1rVIrOE
 PqFM3k5tzHzNOV87Bs6uK9JrALzvsfFRY2KuJMg==
X-Google-Smtp-Source: AGHT+IGSJNvF3rjPO+L1X75Ig25eGTtA/tCfaqcT9w0PlmOFUhxI29EYdkkUZMuHTuwOQigtGRthkgPJK149ihlJNkE=
X-Received: by 2002:a17:902:ec91:b0:1f4:a6cb:db3d with SMTP id
 d9443c01a7336-1f4a6cbdd7fmr61253525ad.44.1716897057648; Tue, 28 May 2024
 04:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1716566960.git.jerome.forissier@linaro.org>
 <20240527092301.GA7851@francesco-nb>
 <23a33323-35d8-4ece-b57b-cdfbc318d3c4@linaro.org>
 <20240527094522.GA22281@mail.duskware.de>
 <ce97ef0a-29d1-4735-b44b-0ce517bb82d7@linaro.org>
 <20240527124757.GE6853@mail.duskware.de>
In-Reply-To: <20240527124757.GE6853@mail.duskware.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 28 May 2024 14:50:20 +0300
Message-ID: <CAC_iWjKpRLA6y-CaOMQp+dDSzVFk6XFDD90QZQw4DivO6AtGzg@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] Introduce the lwIP network stack
To: Martin Husemann <martin@netbsd.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Francesco Dolcini <francesco@dolcini.it>, 
 u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>, 
 Maxim Uvarov <muvarov@gmail.com>
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

Hi all

On Mon, 27 May 2024 at 15:47, Martin Husemann <martin@netbsd.org> wrote:
>
> On Mon, May 27, 2024 at 02:45:01PM +0200, Jerome Forissier wrote:
> > That certainly would work but again, isn't it a decision to be made
> > by the device manufacturer or more generally the one who builds u-boot
> > for the device?
>
> Very true, and if you get the verification part working, your full solution
> is better!

Just to chime in a bit on the why. HTTPs is one of the options we can
easily plug in with LWIP & mbedTLS. But apart from that, getting a
richer TCP/IP stack that has been used for years in RTOSes is a win on
its own.

We can now easily add multiple net-based applications without having
to implement the underlying TCP/IP stack.  LWIP is a very slight
increase in size (~1%) and the advantages are well worth it.

Cheers
/Ilias
>
> Martin
