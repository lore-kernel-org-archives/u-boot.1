Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF75C83F03
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 09:13:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2433783439;
	Wed,  9 Jul 2025 11:13:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="l1S0Wy2a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 244578343B; Wed,  9 Jul 2025 11:13:55 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67B7783423
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 11:13:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7d45b80368dso551832685a.1
 for <u-boot@lists.denx.de>; Wed, 09 Jul 2025 02:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752052431; x=1752657231; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VAeA4qel7H5l90peSY4YD7m0Vdq0Om5syHcRbFAjiEs=;
 b=l1S0Wy2aCXgujQYNaNByvuLDQOrgLYnbSMV48eBrChhpmQ0PrJJVbrevBm/Gzz+aZ8
 JjgSZq8z8LxPzxesa5WveitYkApeBzaj2g4qst+uxfCjfhRudKa/lvNpFpNEiIU0ZUGV
 SK0Du8vh4k7J8w6cSjDBxTiJydfQC2TVYM8naQ3zS1b7T5UU2VMHzJEbalcuC1RtmxUR
 c1hsRiYR5lP7GkqIzh3GnfykWZ9nPApzAOcE4xPrfOlnhcXw5vuWEpwv7PGhZ+oG6euo
 ciSVo9RzJZSfPL03Tv4384krDj5MaJ8AiZUA1k/YM1dQ6Y/8ALjfYBNec+jYBlj9SK3V
 VQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752052431; x=1752657231;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VAeA4qel7H5l90peSY4YD7m0Vdq0Om5syHcRbFAjiEs=;
 b=oNv+3x0y9izYLefQq/vlaILZsM4YBoKBaDm4zfe+ezyPa3N7fKm9xURlqAz+Ks9ltO
 NDvUWXL0v/By3KbEhaXadyyWI9WXNOU+8HrZJtP9crGGxoAFnkRE7CIdnH5JdW4P0nLT
 DI/YJc48oi5z0YrhJNkJuwwCuNO2h7NuQcm2tj45dKYHmHi5d/XJ1WIqoPeeWCVLVg8f
 aUjRpzA8UiQ2HWmpy/5TlifWhq63iFoDXUXAOvWJ9u5pZBptEYHnG8qxgCTGTsF9+s58
 f2Dzjrj9tzigpO0PHYGn2bxF6nQJ5HYYzR7ZOjNE49GfMh8Yg01iO2DMCwhaI6bhPdtJ
 sIWQ==
X-Gm-Message-State: AOJu0YxSpNLl+1KKdMeE090yXgDpFn1lL+vyQftV64+Ojrbz2KTgSdcb
 PGU7xcPIonCYbJcOte8fZs0fypVy0WOOdrH0w9oMssY6Jdj4ox86oCn+l0oofCvMunBeSMG1eRL
 oTnsJkWiYkFaLc6128/wJJTHbzhU5xMp8ETrjoiYVeQ==
X-Gm-Gg: ASbGnctfPVtapgkveh/LHRHKPE9/fEEeMisW8licPK3Hz7OFlKYax4HhsRt6VepIGt1
 T+Hqeots+8JGvJqwOqAyx1rOUGc3kDMO28Uyr2GC9mSexggP3VvRTBTshGJJp0IG3oCeAk3UxS9
 tW5qhl+I5h2klA1q69UeQ6VOotfzG7YnntvRXL6dQtHikC
X-Google-Smtp-Source: AGHT+IGaZkNdEmvGkGpYsXOpPvw3dQwIDcivFk6+QVMnAIBFOD2cPTjnfjmVV7Ool40Q9LU0WdRQdXDWEhhdlca9kX4=
X-Received: by 2002:a05:6214:440a:b0:6ff:7678:bd0e with SMTP id
 6a1803df08f44-7048b8ad123mr29712256d6.8.1752052430799; Wed, 09 Jul 2025
 02:13:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250708141011.GT6424@bill-the-cat>
In-Reply-To: <20250708141011.GT6424@bill-the-cat>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 9 Jul 2025 14:43:39 +0530
X-Gm-Features: Ac12FXz6vim3m9iiF5Lygrpn1r9l-a8baq1Qs1-cFyv8GCl8uabUIYuYeGCBleg
Message-ID: <CADg8p96SmvQNmD8MBCOt9uFCn_yj19eAXxZDUx9MdyzUuu_joQ@mail.gmail.com>
Subject: Re: New Defects reported by Coverity Scan for Das U-Boot
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marex@denx.de>, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, 
 Aristo Chen <jj251510319013@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Sean Edmond <seanedmond@microsoft.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
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

On Tue, 8 Jul 2025 at 19:40, Tom Rini <trini@konsulko.com> wrote:
>
> Hey all,
>
> Good news, Coverity Scan resumed putting information in the email
> report. Bad news, 20 new issues now that next has been merged.
>
> ---------- Forwarded message ---------
> From: <scan-admin@coverity.com>
> Date: Mon, Jul 7, 2025 at 5:39=E2=80=AFPM
> Subject: New Defects reported by Coverity Scan for Das U-Boot
> To: <tom.rini@gmail.com>
>
>
> Hi,
>
> Please find the latest report on new defect(s) introduced to *Das U-Boot*
> found with Coverity Scan.
>
>    - *New Defects Found:* 20
>    - 6 defect(s), reported by Coverity Scan earlier, were marked fixed in
>    the recent build analyzed by Coverity Scan.
>    - *Defects Shown:* Showing 20 of 20 defect(s)
>
> Defect Details
>

[...]

> _________________________________________________________________________=
____________________
> *** CID 569481:         Control flow issues  (MISSING_BREAK)
> /lib/lmb.c: 763             in lmb_alloc_mem()
> 757                     return 0;
> 758
> 759             if (!addr)
> 760                     return -EINVAL;
> 761
> 762             switch (type) {
> >>>     CID 569481:         Control flow issues  (MISSING_BREAK)
> >>>     The case for value "LMB_MEM_ALLOC_ANY" is not terminated by a "br=
eak" statement.

The missing break is on purpose, so this is not an issue. Nonetheless,
Heinrich has sent a patch [1] to put a fallthrough statement here.
Thanks.

-sughosh

[1] - https://patchwork.ozlabs.org/project/uboot/patch/20250708121251.83980=
-1-heinrich.schuchardt@canonical.com/


> 763             case LMB_MEM_ALLOC_ANY:
> 764                     *addr =3D LMB_ALLOC_ANYWHERE;
> 765             case LMB_MEM_ALLOC_MAX:
> 766                     ret =3D _lmb_alloc_base(size, align, addr, flags)=
;
> 767                     break;
> 768             case LMB_MEM_ALLOC_ADDR:
>
>
>
> View Defects in Coverity Scan
> <https://scan.coverity.com/projects/das-u-boot?tab=3Doverview>
>
> Best regards,
>
> The Coverity Scan Admin Team
>
> ----- End forwarded message -----
>
> --
> Tom
