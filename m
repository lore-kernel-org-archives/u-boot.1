Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E77D637A1
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 20:22:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFA918392C;
	Tue, 16 Dec 2025 21:22:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="m3HZTLPe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 920EB839B7; Tue, 16 Dec 2025 21:22:22 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 076128334F
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 21:22:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ralph.siemsen@linaro.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2a0bae9aca3so39199385ad.3
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 12:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765916538; x=1766521338; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=py2nBtlXSqmbsmSG9KlTFTVENAiRKpPyDOxmvfEaMvY=;
 b=m3HZTLPeSA0oEGaFaQk5NhMOMHoiAsGhtNmMGDZBfzCVP6MI0SDNS48pJNJneM5d4r
 EylmNPv3PswwA1BKSNbrdc/9R9FoY3Bnj8WPD+s5OT43bKx7gWfAJCQaHxYIoZIQ2Z9N
 msTenYyCoAnjFZid03Y9mlO8gPtVe7oy/hhIp3JlH4RRwSI4GDqs8hPjVIKLLKTQhH8d
 6w3UPDXuZ/kGnKAS+HrWgEqtl+u6ViL2YgGWiJUCMopZKfk/6eWE/OXjnkI5PP9RGjKO
 SY5D8sZeDLZZ0OiKyE7WyowYjSwn7pulaPzXOX1C47yTaenGaAWH60U7IiuImry4N4AX
 7VGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765916538; x=1766521338;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=py2nBtlXSqmbsmSG9KlTFTVENAiRKpPyDOxmvfEaMvY=;
 b=ssGpwDmPx7d8oLLbeXBVxlxbh2bBkICJON4+2hIZ33eI/kYGpKR0rzcb3SMQ71+Ef2
 fVEXZJITK/u0+NP1f/4ucG6RZKkVxQv2ldq6dPNk+pJv+vW0MV1wO14Fu4z4HnSO4ThD
 KOjimdDD5x9ymsGz8SHTa1LYf3gbT8NEgO4dp/aYtvf8wUfSZkzu1rizRGeSsA3paWBk
 79ryNdVmHToOaF+lOyZgPHOiq9pnwZ00pvdB6NoNQyOrnTR5rwkqmDLXtuIuYS26rcya
 zO3Qszq38Hy5FhHQq1Hof4id2+FO7z3kgUxs3h9oetpagQInTfmnNjkFtZrBNoj1hxtX
 d9iQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEN+JIxOfHh7CcIKWU5cRld2gudD8gb35AuM1RiO3As77K0IR1XfhEvPyXkIjrhx+Vy8qEyOI=@lists.denx.de
X-Gm-Message-State: AOJu0YxfIYoIsSTqorL8F9MWEhNbg+V8mEmYro53Rl2tcJTmPlpiss8h
 NBZ6TRS+y8f/8bPiJdLSED2UUxWnaGisj+yM+gn3xN0Zaz5BXO5G9ydhvbS4/XjeD68LyINS+Jd
 XIgcoCZMYwtEcBZCpPdO1XbarkJLx0mf+ZqckkYlILA==
X-Gm-Gg: AY/fxX7gTuU/3Kw+B7hxUMn9O6GeKNWc4ywjB5Vtz5ZZ7VP3JbdALPFMGxAFK1kqqXo
 CDnRsOPp1ElHAN6wbNvN0HWLdkM/+mWTumE19XxjBMON7xpUEg/wDiBMicLXCDoosNTi3y+YPEx
 sagxctI/bXN6YTS/aYbGtEHmgDWKNfynl9UzLO3I74jwtKQxYJixLYsfh0cRnjRXR1W272javig
 uSUOilbschBhJWFcB9ex68bTd41mI1/1MPEaadqs0s8GX1tULD5bAKpt1KtfhCXfqbu+sy8AQ==
X-Google-Smtp-Source: AGHT+IEpCsg0txRRju1M9UKIs809x1dAATNBSrmBKKAQHuC52vSZLgjwBYC45a3zCAwCziKMXNaihyoQ7cexQWEsyFE=
X-Received: by 2002:a05:7301:2882:b0:2ac:1b61:ae1 with SMTP id
 5a478bee46e88-2ac322f975cmr9550046eec.26.1765916538317; Tue, 16 Dec 2025
 12:22:18 -0800 (PST)
MIME-Version: 1.0
References: <20251125212953.1733-1-briansune@gmail.com>
 <CAN7C2SBn=6J0c7AOM64TOKsa8waGFTtLKUVYfnY7NyAYH_N1gA@mail.gmail.com>
 <d024aad3-6ad5-471e-8290-e802bdbf7ead@cherry.de>
 <CAN7C2SDdTsJADMWDZgugMnoTO-sqGUt1wQPsKyRwP=gHNdmQ2A@mail.gmail.com>
 <CAN7C2SBPC=u7QJD7T=3NUUOjPqXo1UWqHb_QRzsOR_wtvZrk7Q@mail.gmail.com>
 <85af1053-f8c6-4983-adba-7a1e845651e4@altera.com>
 <CAN7C2SA78DM+XaXMJNA26o0EzxFkdwL26BfcH91boepT0bDPKQ@mail.gmail.com>
 <CANp-EDaU0Vw0dqWOfAXKub6Qq8FN5LvNJyttB6-EA4imAK8mvw@mail.gmail.com>
 <CAN7C2SBSYkFrkaTDg7kuE2NsqUsjshZVepCdad+5buMSpBEmDw@mail.gmail.com>
 <CANp-EDZAJr5Hvh0T=53H-DeOU5G0mZ-ohs9c29+7eyOKny6yOA@mail.gmail.com>
 <CANp-EDZa0Y4NFOD2sco1xvONeLeixFQOrGLZ+hC275wMCHuF6g@mail.gmail.com>
 <CAN7C2SBop5h9WtF2GLRkWeNmLpBcDC5dHUmmR=WzRXTpr6-7VQ@mail.gmail.com>
 <CAN7C2SC7nfpDmQXjfJyZDw5m6HnfbSed+w_JNsS7+x2s190Huw@mail.gmail.com>
 <CANp-EDb+Txnrb15KuXBof6PMZp02WZ1MOy-LkrGoW-OLE8mWCA@mail.gmail.com>
 <CAN7C2SDj5yL4=tpEiG2ftjFQvrWvHSavXkz2JMJQGEgN_i4Dtw@mail.gmail.com>
In-Reply-To: <CAN7C2SDj5yL4=tpEiG2ftjFQvrWvHSavXkz2JMJQGEgN_i4Dtw@mail.gmail.com>
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Tue, 16 Dec 2025 15:22:09 -0500
X-Gm-Features: AQt7F2o2SPl2qbJSttDBclJK6YiLSbY_Pt7pX7r8v5OLXFytKRiq94xxEju6ZTM
Message-ID: <CANp-EDZpbdkKNzvqBS_RzGbJhJ8YP7-8BK9XZe6HuPiPqgQgYQ@mail.gmail.com>
Subject: Re: [PATCH v4] SDRAM Calibration Failed fix for GEN5 SoCFPGA
To: Sune Brian <briansune@gmail.com>
Cc: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de, 
 "Chee, Tien Fong" <tienfong.chee@altera.com>
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

On Thu, Dec 11, 2025 at 2:51=E2=80=AFPM Sune Brian <briansune@gmail.com> wr=
ote:
> Hi Ralph,
>
> Thanks again. Quick test on your proposed method.
>
> diff --git a/drivers/ddr/altera/sdram_gen5.c b/drivers/ddr/altera/sdram_g=
en5.c
> index 3c79bb11802..904f9bc6d03 100644
> --- a/drivers/ddr/altera/sdram_gen5.c
> +++ b/drivers/ddr/altera/sdram_gen5.c
> @@ -589,6 +589,9 @@ static int altera_gen5_sdram_probe(struct udevice *de=
v)
>         }
>         reset_deassert_bulk(&resets);
>
> +       socfpga_per_reset(SOCFPGA_RESET(L4WD0), 1);
> +       socfpga_per_reset(SOCFPGA_RESET(L4WD0), 0);
> +
>         if (sdram_mmr_init_full(sdr_ctrl, 0xffffffff) !=3D 0) {
>                 puts("SDRAM init failed.\n");
>                 goto failed;
>
> Works and all debug_log and max level=3D2.

Okay, great.

> However the same behavior can be repeated when CYCLIC / WDT off.
> It will fail and once CYCLIC is turned on it will pass again.

So there would seem to be another issue related to CYCLIC, hmm...

> So simply speaking the sequence.c somehow is so touchy on timing.
> I do test the most common timing bin of the DDR3 die.
> I guess there is no easy fix on this issue unless Altera do change a bit =
the
> sequence.c syntax.

One other complaint about sequencer.c is its size... the compile code
takes up a major portion of the 60kB size limit for SPL.

Ralph
