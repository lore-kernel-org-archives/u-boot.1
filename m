Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9491D15DAD
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 18:01:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F4598398D;
	Wed,  3 Dec 2025 19:01:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NrsPUoL7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27D3A83A71; Wed,  3 Dec 2025 19:01:13 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3E05828A2
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 19:01:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ralph.siemsen@linaro.org
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2981f9ce15cso608485ad.1
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 10:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764784869; x=1765389669; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ZO8X2z4OrKmlpzLzdfiuuiofa/57cqUYBJPyiJTd6c=;
 b=NrsPUoL7qrnCL9tFgT1RUJOmayCmy6F67ID3sMDHll68UKykZ5i8CopXNgLAwsqiMK
 iV9mvMTK5MWoFE2lRYrNTx05hoZe4rzr5X73+8yBWH/vqrGkxlABiltXda7EgSgmJXFX
 CBSyedXFEN0ywzpFxB5vpWqZCBESIUsJerPozxwX4IZQQ7S0ESAtYbQ1mPE5LvrvCNvg
 8ilX4B9jcLLbjRRM2BZ9/1IWODSwUhKHxgg9/Iv1ABJIdSkeRjaVpRdfkU1fXCgiAtBJ
 sfUPWd+rXCQmVesITGRCrRfCs0zMmj1CYOoj7X/FIret0QcYURQlPasB6NL3ZfcYEu5Q
 OV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764784869; x=1765389669;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3ZO8X2z4OrKmlpzLzdfiuuiofa/57cqUYBJPyiJTd6c=;
 b=IqzeTk+D0jppLHVOnxy6qg1Hwi79U37pc0JIa6jbaK4pkADHRJQ9stZbPZ5vSd58+k
 WQG66w6AjrAmn8BKEAPVTWkP5yTBMx4KqiHs3otQtjCavlTGllQjMzSnUKje1eJj4Y3g
 VwT4R+jSYSTpSWs8TuaWsYLfe+rUmW4hjcOiprIq31Ne/I2tgakEK4a/25tKO8Q7PyUN
 1zrqKcUE8QM3KhCgIWygRr01IHx+DjL71wZuwbMNpigUMaJaXyJvnDmjLpyb+uUrcpLK
 bkdJMvx94biflkxbhHR1kHemKyxTT2H2CRoygX3w5e05Fv7vTuDkMn0sulAi1VIwB0WJ
 eeew==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUzZVsExkBm+L2gOJtdF26CGnWQ0ftC1sQv74zthviOdmfvWrniovC3tIzVgVz/dRSBvCFiDw=@lists.denx.de
X-Gm-Message-State: AOJu0YxQKZeLrOfS8N+/stmBCvIlRrrLlE5aypAXV56euwwrFu9x1PaA
 lGVDn7tNGOjKeLLyInfIbGUAjPbxtSFz90B0iq1G+5FTU53hwrXOerpHrcNdtj1yLl2KXp6ZtM4
 DFfMoyMau1X/6NFGUg1iVqEKJdvvdKHo9L1/A5yV9sQ==
X-Gm-Gg: ASbGnctus/QDqkFA7J5nW276sCfCVLZO/lE9l8aTW4oDbezSYSPu1wZe0WWBd0A0esv
 PEV74iyR6AdbqKPNrLTyEBhuMuR7ayT174cA0nwPw0Xt2iMXgr0VhE64u+geq53xctk02he/4eD
 p6Ifu4BRxQZWcQ9z/mw29il/DTA+pn57q3WHzTJGHWc+rbtkotGUJcmJfQZmTRRb+aH6TdlsTRq
 Q3V76X1dZUrHSSll2Capa13SQNHTuNfGP7MzDoNZcTNQa8tgc5H7+2O0Rhy9X/fWzLGn8O84Avg
 jyb7/ezC
X-Google-Smtp-Source: AGHT+IF+HSo6d93K2I43brEfIOJZVykPtqB2V6qo1wyhQLEmX8m+2gqHN3yjFdItrxiqKPNtP0ezASQYm3Hlt39Jm1A=
X-Received: by 2002:a05:7300:d810:b0:2a4:5b32:2a4d with SMTP id
 5a478bee46e88-2ab92e2bf55mr1560010eec.29.1764784868772; Wed, 03 Dec 2025
 10:01:08 -0800 (PST)
MIME-Version: 1.0
References: <20251125212953.1733-1-briansune@gmail.com>
 <CAN7C2SBn=6J0c7AOM64TOKsa8waGFTtLKUVYfnY7NyAYH_N1gA@mail.gmail.com>
 <d024aad3-6ad5-471e-8290-e802bdbf7ead@cherry.de>
 <CAN7C2SDdTsJADMWDZgugMnoTO-sqGUt1wQPsKyRwP=gHNdmQ2A@mail.gmail.com>
 <CAN7C2SBPC=u7QJD7T=3NUUOjPqXo1UWqHb_QRzsOR_wtvZrk7Q@mail.gmail.com>
 <85af1053-f8c6-4983-adba-7a1e845651e4@altera.com>
 <CAN7C2SA78DM+XaXMJNA26o0EzxFkdwL26BfcH91boepT0bDPKQ@mail.gmail.com>
In-Reply-To: <CAN7C2SA78DM+XaXMJNA26o0EzxFkdwL26BfcH91boepT0bDPKQ@mail.gmail.com>
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Wed, 3 Dec 2025 13:00:57 -0500
X-Gm-Features: AWmQ_bny1E3Ejc6m3Jjb0fCRcAlUxeVUyz_fU45e5DWeruYNNfNb6tImxqmVO5U
Message-ID: <CANp-EDaU0Vw0dqWOfAXKub6Qq8FN5LvNJyttB6-EA4imAK8mvw@mail.gmail.com>
Subject: Re: [PATCH v4] SDRAM Calibration Failed fix for GEN5 SoCFPGA
To: Sune Brian <briansune@gmail.com>
Cc: "Chee, Tien Fong" <tienfong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi Brian,

On Mon, Dec 1, 2025 at 8:24=E2=80=AFAM Sune Brian <briansune@gmail.com> wro=
te:
> I am enclosing a bit log here.
> I had diff both sequencer on mainstream and altera trunk.
> No diff.
>
> As for the sdram_gen5.c there are diff but no major point
> before calibration fail is trigger. ECC is not use or setup.
>
> Setup:
> No CYCLIC no WDT all off on dts and .config.
> No modification on code.

I had similar problem on a custom board with cyclone V. I tried
disabling the watchdog but this didn't make any difference.

After bisecting, I traced it to commit 3b8dfc42a23 which changed
CONFIG_SYS_TIMER_COUNTS_DOWN into a real Kconfig symbol. Although this
was updated in socfpga_cyclone5_defconfig, I had to make the same
change in my defconfig.

Not sure if this is your problem too, but worth checking, particularly
if you're using a custom defconfig.

Regards,
Ralph
