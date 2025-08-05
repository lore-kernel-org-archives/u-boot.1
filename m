Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31421C87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 12:07:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C96583249;
	Tue,  5 Aug 2025 14:07:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AmQ1BaWN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06FFA8324C; Tue,  5 Aug 2025 14:07:35 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D0A383214
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 14:07:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7dd8773f9d9so419749285a.2
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 05:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754395651; x=1755000451; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uN7aYd6JgarjtFOBAXCvpmWNQf8ed5Zwxh3Jf1gXXzA=;
 b=AmQ1BaWNo+YT11l65Vh21rDLcq9vT0a1K2pI7eITgyszbk5Yq4+9/4VR4Ej88oevV9
 25DucuS90pAl+oYpSesJb5i8Iru9AmNLuIHkZvvqW7VlLKPDckVp+B4xc4WwV2QJYI0F
 +maKJlULosdguAJSrxPtp31ETRRU7RFj8D3xAowKXa4Nb1lTvgqu46o7ao1fp5cPTaS9
 D0oppIdnUAmy6StpDkM/BEJueJ0aiovETp/8Hf7yn3+qK6wkQfK2KJG5A/ExmclNSTEN
 ne+gPPtpsQHetmBj7xeQ5sa2/0D8IRRGUzjA7jtNTn/EIJd0I3L30WOhYcafvGYwXbWl
 iOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754395651; x=1755000451;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uN7aYd6JgarjtFOBAXCvpmWNQf8ed5Zwxh3Jf1gXXzA=;
 b=a5J0BrjDcuk1KWF7zYM8O6cSuj0Wb68QtLW7mdHBTM8rA5zLS8NvWWYPs4mjB2sSv0
 V5dP3IKrA6ppLrTWomJJrPva/ksmSBtqwE0TMAg+btDaX3EffUFjsHiUCwMZyDibzgFN
 Fo6mbitZJGLm3XNjQZt3p5+1DQXKdwa1Znceg7enLfGx8hOACqudjh8brvJ7gJ60GfLe
 AaykHl+NtCJX61t86Y3EyUI6rTSoSCGAYH3qRtrBAWJnNtfH5kmA0BAvWchJqdr5qTTh
 37ScM+bz98yA6vEEAR7Dv+6BTnr/u/r8dYAJmwerlWUXHMoFwVEH1p18uvkC/CQpEjXB
 2yQg==
X-Gm-Message-State: AOJu0YzrQV25zE9dcCHl8GC+k1PYGmSbCwvgTJgpphQ5zwfGWbi/yBa8
 Wfd9gbVSpo7ehz6V8xm/15EtY7itXApp380lJcB+XesBrhNjG5if6+7cMu8V7mIbiZe1cYwlpcX
 2e9AlEknwm8BIY4CLLrrezSP33/PBTy/8b5g8+1ON9Q==
X-Gm-Gg: ASbGncsPK6qkIOcDd5dS3GWUdb1QLzg0ogx8abbEv5DPVNQzsllo10ROtIgdwMRiblt
 NAwlod6HjpXiVpQoPoUu0umvcXt6JXsdQJraRlkAJO6tnD8kmdUU2WMdMFW+aA8AUvaoRZmlbsK
 VJ65zrnbkNb2kRv0s2nyK1hCuBdE5qe4V13XNPB4LQONTJoupuoC7lUBsMFc2M4IltuhWmZhQU9
 lbQkl0w
X-Google-Smtp-Source: AGHT+IHdF+cIMGkTrXrrsRCIc55GbrX7q03T/2etP9NwYw9LoAkciibCSpFPgbuiqTAj0RaoYDgJ/5HHItmPCK5E6YM=
X-Received: by 2002:a05:620a:710c:b0:7e8:239:f829 with SMTP id
 af79cd13be357-7e80239fd96mr777878485a.31.1754395651278; Tue, 05 Aug 2025
 05:07:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250805094012.2268436-1-tomas.alvarez-vanoli@hitachienergy.com>
 <CADg8p966M2Ym3L0ZPLMiuMMQq6=D2MrvFd0WdrZkTzUJVvUnRQ@mail.gmail.com>
 <DB9PR06MB7849F1DFD6B6D9956A8FD66FC222A@DB9PR06MB7849.eurprd06.prod.outlook.com>
 <CADg8p940FJoAOWQ3L5nRCZDhaSp_C-PdQbuh1XoT9RjfrizyWw@mail.gmail.com>
 <DB9PR06MB78496FE3E20E12819419D195C222A@DB9PR06MB7849.eurprd06.prod.outlook.com>
In-Reply-To: <DB9PR06MB78496FE3E20E12819419D195C222A@DB9PR06MB7849.eurprd06.prod.outlook.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 5 Aug 2025 17:37:20 +0530
X-Gm-Features: Ac12FXxY-5HcFtooAVcYf2wm4QHLnATWh0Ashj3VZPf_4rBWVwBCHnZpkQYtAqU
Message-ID: <CADg8p97w3vAkvOPp2=OCXrZ5qS8iDDtT0EJ-0iNO-k3LEXMrCQ@mail.gmail.com>
Subject: Re: [RFC 0/1] use lmb to calculate ram left for the kernel
To: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "trini@konsulko.com" <trini@konsulko.com>
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

On Tue, 5 Aug 2025 at 17:00, Tomas Alvarez Vanoli
<tomas.alvarez-vanoli@hitachienergy.com> wrote:
>
> >I am confused here. You mention above that the address of the rootfs is =
determined based on its size. So you do know the memory that would be neede=
d for the rootfs? Also, how does calculating the amount of RAM left over fo=
r the kernel help. I mean, what if the kernel is bigger than the amount of =
>left over memory? Can that not happen if you don't know the amount of memo=
ry that would be needed for the kernel as you mention above.
>
> Sorry, maybe I misused the term "kernel memory". I am referring to the am=
ount of physical ram available for the kernel to use:
>
> From the kernel parameter docs:
>
> ```
>         mem=3Dnn[KMG]     [KNL,BOOT] Force usage of a specific amount of =
memory
>                         Amount of memory to be used when the kernel is no=
t able
>                         to see the whole system memory or for test.
>                         [X86] Work as limiting max address. Use together
>                         with memmap=3D to avoid physical address space co=
llisions.
>                         Without memmap=3D PCI devices could be placed at =
addresses
>                         belonging to unused RAM.
> ```
>
> We know the memory that is needed based for the rootfs "in runtime", it's=
 not something we can compile into u-boot (if you add a new binary to the r=
ootfs then it's bigger).
> We don't want the kernel to be touching this piece of memory that emulate=
s the mtd partition.
>
> I hope this clears up the usecase.

Okay, I see. Given that we now have a global memory map for lmb, I
don't think that using lmb functionality is the best way of computing
the amount of memory that would be available for the kernel to use.
Please note that with a global and persistent memory map of lmb, there
is no guarantee as to where the first chunk of used memory lie above
your rootfs memory. Earlier, I think this was fine as the lmb memory
map was local, so you could copy the ramfs to some low memory region,
and then show the rest of memory as available in the lmb memory map.
That might no longer be the case. So this computation of memory
available for the kernel will have to be re-designed. I think instead
of relying on the lmb memory map for your computations, there should
be some fixed memory region where the ramfs would have to be copied,
and then the rest of the memory can be considered as safe for the
kernel to use.

Btw, I tried looking for the function that you are changing in your
board file in the patch, but I do not see it in the upstream U-Boot.

-sughosh

>
> Tomas
