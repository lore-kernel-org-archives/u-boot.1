Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E921C54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 20:01:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C406382E66;
	Mon, 26 May 2025 22:01:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ZCIVanZr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC1D982E67; Mon, 26 May 2025 22:01:56 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC84282E25
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 22:01:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-23449dde9ccso11832055ad.3
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 13:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1748289713; x=1748894513;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AoMMgthn3tUAzouiTDdbEndsLMdiedZk962c/tHpJMo=;
 b=ZCIVanZrl907ZVLZuzBNIQC9IYHr9JxQRVpDmqnvXMhI53SuLsi9t+FMbFFOb5rf5A
 gASFJiFZUrJnITSnH3rHu0EfKXVD/JF8ohiRm7ciA5L2TgHF7duTFIqUwAml4JIZQ6um
 uKjYt+iPr8Z++w/KQ+ztYcDa9h/QHyBwgTfEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748289713; x=1748894513;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AoMMgthn3tUAzouiTDdbEndsLMdiedZk962c/tHpJMo=;
 b=vn6Q8ZeF69aN8alC27+Y9KS/V6FzlSDhgVDVOKyTn/mrPSKN1ePJ3ijyyvzBNw0f3m
 yc/qCNr/bCqTD5V8HHrpSKOGVGAEtX7U3zQRV4ZffMQk4nojj/FolNP/RhjGGnm7BBEY
 kQOXsvmpwym+/BMkz/hfaQtWKoryN1LU9g81bznx0AUETon2hMFmVFq5KNZFi5i4Ewdv
 4zaamSdIJfIK17Sci7gRxOf5pGhhbH0UQlrSS29r3N/6RkezAlE6CTlSP53jYIgihUlJ
 NYYvgTWh9KpeETQhKVgRUSxWbhO6EmPNChaUhoQTqbS+IoMJ5sTNLsTAv5P6ptyj/kIE
 IUsg==
X-Gm-Message-State: AOJu0YyPmxDGmwyMcY6Md7DgAj07VEiGMsPSg5NYW7AZeAH9BAW6Jh9F
 41N6M7MuNfi7Y46KwCD4DboUsQAJzzGh6PzPMN2tBaLBa8lHzulzRM+11LFR3i9jfotNhdWkkPq
 Qa1OrNL4EMeYVSHxNbrFoCA+j2OVlYSUk770k0VY8Xg==
X-Gm-Gg: ASbGnctSYrVkfoFGYPzIQBkHUCvRbOyc2d9h8EkDMZsC4a4JpS0aj0QCo8YaPSLwhqC
 rlwxWKCL7+zdkpzuZMpxoE3IlJAb9p1QfsWrnJrjecN+RMngxIB0Wz9liWPCc3Vv3IqRwcHYLer
 +9bENC8ovORUutFYxKp1+0mjEeaujYUBrpEyeG6o2HGJgLJlLzLnjcJUMYsiWhlw==
X-Google-Smtp-Source: AGHT+IGWeXcvrfdnGpMrVTAkvxsrlTjsy3EDnrGxLrW3FKBKBuR6ScPubz95Y8JcK44JwXiP/i9c54WGEE0y58+4pxc=
X-Received: by 2002:a17:90b:4b83:b0:30e:382f:8b86 with SMTP id
 98e67ed59e1d1-3110f824189mr18519800a91.15.1748289713110; Mon, 26 May 2025
 13:01:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250526194811.1179530-1-michael@amarulasolutions.com>
 <20250526194811.1179530-3-michael@amarulasolutions.com>
 <CAOMZO5ARdWa2bZrg+0VnndR66yFbmAOMNaMtn6PFS1Y9b1xPOw@mail.gmail.com>
In-Reply-To: <CAOMZO5ARdWa2bZrg+0VnndR66yFbmAOMNaMtn6PFS1Y9b1xPOw@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 26 May 2025 22:01:41 +0200
X-Gm-Features: AX0GCFtb0vBlCjto0YJMNgwblNWG0xAA_uYLO_fOkZUZbO__lxtHLU8wH5O0YJ4
Message-ID: <CAOf5uwm5mTn3ac65cZiZedpo3kLQH4H1PEWtYMR+Rp_f8tR9fQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] mtd: nand: Add support for EDO mode 1-5 to IMX6ULL
 platform
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>
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

Hi Fabio

On Mon, May 26, 2025 at 9:58=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi Michael,
>
> On Mon, May 26, 2025 at 4:48=E2=80=AFPM Michael Trimarchi
> <michael@amarulasolutions.com> wrote:
> >
> > The clock driver allows to boost the NAND performance
> > controller. Make changes to let it use the new clock driver
> >
> > =3D> time nand read ${loadaddr} kernel
> >
> > NAND read: device 0 offset 0x500000, size 0x800000
> >  8388608 bytes read: OK
> >
> > time: 0.488 seconds
>
> Out of curiosity: what was the original read time without the clock
> driver being used?

The downstream driver I made 2 years ago before this change was around
3/3.5mB/sec, if I remember correctly.
One point all the IMX6 platforms can then be migrated but I don't have
any board with me.

Michael


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
