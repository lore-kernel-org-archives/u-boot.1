Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E66E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 19:49:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 705BC80371;
	Tue, 17 Dec 2024 20:47:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CsdtKih5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 740CC802C2; Tue, 17 Dec 2024 20:47:54 +0100 (CET)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 382CB80315
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 20:47:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7273967f2f0so6144844b3a.1
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 11:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734464870; x=1735069670; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IMPJs0XfjKAngp0tAvl0Advwt9JX1TFdzTJNEIM22oU=;
 b=CsdtKih5AT+RwW5mF6HrPBbUpjiFt10MSSsumyBCg9DG9QzvcTDwEQmPqLi6tg0pHI
 CK50Opqi1EAYBuHiG6jpHWrubzkEj1ZFDEsEPqJCzXa4wUp9GrPpn5E7UDHlhOG5k5fL
 oNGVxe+UfIx7rndrMGlVd9Jq1hGNPOr3vBCkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734464870; x=1735069670;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IMPJs0XfjKAngp0tAvl0Advwt9JX1TFdzTJNEIM22oU=;
 b=FRigjIdhvX79X3YEdCQXVJW9+rFzlFgS6lGrSBtjm6NMYKL1BCaXiPwr/89KfU2Szi
 cXcYR/+9lNIyKIIOqPZYhIAfNmC+ebpuY1J5dJtwRc2IJpvWzHJd6DqOwK4bXbYslbyn
 I+az9kr8lgWuoUdpv1nOOk9OJF0y2/6iit6ZL1N8eNShJLt2MuXbauNvqno4vXefsox+
 7iqYvJN8+0UdCkzCMMExk/igVPH833CWfJM8ejxHcEfP2tjRB3RJmEgPli+9wbf4Rua7
 VhQzRtRyOmbgJ73fK5YwHGExiv7L35XvEbsf3V02n3fiy8IkNABcWBlTbstzFslmTFP8
 4OJQ==
X-Gm-Message-State: AOJu0YxwSqHFeFc+H2JojDjfUkbCeDs1mkXy2d1lQzBfKelE1kdCxgiv
 mxltfLieCkYGxJLd+brHGdVSi97xfoE6CyWkAM3H775y6kys0L7By3s7cH3ibJlm0yVi851EHyh
 Wx+o4geBcHWsgZbw0QTK0Vwt7TiR2wkMZGfAz
X-Gm-Gg: ASbGncuZtKJRJ0J2YfPHUv07O5fhWvToeqGcNR9NQex7qs1YzFGP06We5YoiHB43591
 4oYidR4e7c4SC8RpgGcki3JKmjY46AREVWNffnTM=
X-Google-Smtp-Source: AGHT+IGepb8ha0QP2EWU5iemqB/gngx0UMwW7jZCv3G6jAGU5mvJ4m+zGE2WgwfLK8DduCaCH3/FkR0bmut4Sgpgtjs=
X-Received: by 2002:a05:6a00:240f:b0:727:3cd0:122f with SMTP id
 d2e1a72fcca58-72a8d23b7f9mr326932b3a.9.1734464870673; Tue, 17 Dec 2024
 11:47:50 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Dec 2024 11:47:43 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszThxT4NxAONLCJEt9beieFtuN4TWRPVV1byTvRNf8+===A@mail.gmail.com>
References: <CAFLszThxT4NxAONLCJEt9beieFtuN4TWRPVV1byTvRNf8+===A@mail.gmail.com>
 <20241211135418.563803-1-sjg@chromium.org>
 <20241211135418.563803-10-sjg@chromium.org>
 <CAC_iWj+g0Jzg3DMP2KgFnabhMe5U_L4mtvUYA+HUBms5_z5+BA@mail.gmail.com>
Date: Tue, 17 Dec 2024 11:47:43 -0800
X-Google-Sender-Auth: tuAlRUM89IgJxYW6EPhCoPErMbE
Message-ID: <CAFLszTiqQOK6LX65y7s4NYE10JfaE-Gc7phiVj=gZs3nrqHKpw@mail.gmail.com>
Subject: Re: [PATCH v5 09/23] efi_loader: Drop virtual_start from priv_mem_desc
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Ilias,

On Wed, 11 Dec 2024 at 08:09, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Wed, 11 Dec 2024 at 15:54, Simon Glass <sjg@chromium.org> wrote:
> >
> > This field is always the same as physical_start, so keeping track of it
> > separately is unnecessary and confusing. Drop it.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  lib/efi_loader/efi_memory.c | 10 +++-------
> >  1 file changed, 3 insertions(+), 7 deletions(-)
> >
Applied to sjg/master, thanks!
