Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF4BE7717F
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 16:17:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA58D80245;
	Tue, 10 Dec 2024 17:17:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CjqLPbcf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B4E58023C; Tue, 10 Dec 2024 17:17:04 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8695C8026A
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 17:17:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aa6aee68a57so1747666b.3
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 08:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733847422; x=1734452222; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MU+RYS3RQtbAwLERtv0F6ahYuzXMxxJM79cZ1Bj+jb4=;
 b=CjqLPbcf9oVZoywktXi3JoHcREsEiy3LVeQUX73I/tdAtwuKtJXunrQQoIVqy7Dzl1
 +mkv/KZnVWncnXKhUf/tZXRutTdb4vm1gOwLHgSih/JY6TaxcyrtXkXT9x4LIPNFNJ97
 fIYxI+7kYofZRme5m9DDfPytdTNxlPNgWrRnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847422; x=1734452222;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MU+RYS3RQtbAwLERtv0F6ahYuzXMxxJM79cZ1Bj+jb4=;
 b=IC1cFuBnnWyr9OYooN+rQO1pxKXGKlHCFNK7qH0327HxOqSYaqwu0qeflER9Gz0aDd
 rqkfKELgOUJFfNGAJO7tXNp0wFu9ABWM7qTNKSM+u0qcQMHKNLF0JVQ63lbhuHoiMB4j
 SJogVxZv2Hfq/GBiwgAmhU6mv3Ug0WzEkzleUPXaNFYT1Ndwi4aXilu2jnHkBB8Ycu31
 tE+v3G2LFVb7MWUpcjz2z1RL4eqxl5NumwXr8nySr9zJCw+fiF+GntBW39xHIVrG56eQ
 ajtWOoQwtfYOmnlgpQjNJrDNqob+k143w+42Fbo7lzFfv/Wu9aESoZZhi0KwBCqS6X9m
 djcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXME6VeFo6x8BIzO4640GoF6HXXYwt5l3SvAm4+MmWOluNBLzxwtHpEPcnd0umK7BDSFWHedE=@lists.denx.de
X-Gm-Message-State: AOJu0Yzqffky3/9UvVwpw9L57Ld8gJWvDPCstiv7mA+qnp3mAW1ZbFsx
 rEElYbiXp6TBkxSPL6ebNpx5DuDQK3x/NdYusB/laqOBdR6G4EGCON9TyG/EK+3sLPUNE9LD/K0
 1sEjZWuaY7dXwv5Oszx28V4qaepxN8weeTluX
X-Gm-Gg: ASbGncsw+fsW6+Mf03MadOwpWey/T2mFOyqWz2pWHqwgI3/Epj0GqHPitCIFWe6R+9z
 lgHro8+rUWgcoKOm9z2HTM8k3fsSgvvs8VKpX
X-Google-Smtp-Source: AGHT+IGmmXOemWKV4pvzJoEJta+v9FbPN5HjIQQ83fe0X9vxvvmd7nCShDbT3Mumoae1xXuplcf9O/9viLPeQIjbais=
X-Received: by 2002:a17:906:292a:b0:aa6:71f1:4232 with SMTP id
 a640c23a62f3a-aa671f14719mr951368666b.24.1733847422001; Tue, 10 Dec 2024
 08:17:02 -0800 (PST)
MIME-Version: 1.0
References: <20241123195616.305687-1-mjg59@srcf.ucam.org>
 <20241123195616.305687-3-mjg59@srcf.ucam.org>
 <c9a76fec-a57e-466c-bdc4-0e18efd09ba0@gmx.de>
In-Reply-To: <c9a76fec-a57e-466c-bdc4-0e18efd09ba0@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 10 Dec 2024 09:16:50 -0700
Message-ID: <CAFLszTjzuDY2fO1eB80MeVq_jYW5UdFHDd3V+sptdEP6-BgfsQ@mail.gmail.com>
Subject: Re: [PATCH 02/10] Add part_find command
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>,
 Matthew Garrett <mgarrett@aurora.tech>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

Hi Heinrich,

On Tue, 10 Dec 2024 at 01:21, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 23.11.24 20:55, Matthew Garrett wrote:
> > From: Matthew Garrett <mgarrett@aurora.tech>
> >
> > part_find takes a GPT GUID and searches for a partition that matches
> > that. It then sets the target_part environment variable to the media
> > type, device number and partition number that matched, allowing
> > $target_part to be passed directly to bootm and similar commands.
> >
> > Signed-off-by: Matthew Garrett <mgarrett@aurora.tech>
>
> For user to memorize the command it would be preferable to add the
> functionality as sub-command to the existing part command.

I looked at that when sending this series. My only concern is that it
is wildly different from the existing 'part' command, in that it does
special EFI things.

But I don't have any strong opinions so am happy to incorporate it,
with its own Kconfig option, of course.

Regards,
Simon
