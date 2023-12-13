Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67DECC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:42:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CE8E878B7;
	Wed, 13 Dec 2023 21:39:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CTB7Fk+u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B9F587883; Wed, 13 Dec 2023 21:39:22 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBDA787873
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:39:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a1f47f91fc0so888316566b.0
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702499959; x=1703104759; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3GhImlZi1UsBFmj0ZMva+bb4BTtlBxonZ3TqK8mmuN8=;
 b=CTB7Fk+uoShRnO0MCqTEHvS9GFS3lE7iefk5a7kjuyF1Hi/E8aXDIzQZT2UDpT2OI5
 EjkR0MKX4+W+s8g9J+E+nYL2Ep3fqjWTEm1PiF3UUUIhzASlqY/UFkB8sj8vULSKADGL
 skjynv6bv9N7T3qiVqMISTz39MRmlx1LAtAAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702499959; x=1703104759;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3GhImlZi1UsBFmj0ZMva+bb4BTtlBxonZ3TqK8mmuN8=;
 b=gvbE4vMoJvacFNawsls/tLfRiNZy21PbIgXzLtRKpFjiR9AErnCkMFG6CftDBsgA0H
 +mzFmTJ1DkfOYsKxbW0pnZ80uzrASFsXw6S8NhU18LSU2wWM+3rqcgeVY5S5ix6XYGCx
 KGybRp8198/6MqvtJPVKCwRxyt+Yt5TcLPXlb/1cPr2La14PgQaFTNnYPKWtwejOqLxC
 8lvuqMSV3AaKELuSA7H1RuY34Ozjw+Y8jmigH6byThpdPNlkLU1iHz0x3xYGYr2k6/zI
 bViJHDs3YtR3b+gs/ZT0JPgKgkzRP/Jnay8bUP2qcWto/MhpGtAP4zKbggnk8lDCdgDD
 h8bQ==
X-Gm-Message-State: AOJu0YzD/yw6UK9/3st4hzio8C5YmtEysP/VBRO/MsgOQM4s1Sc/htP/
 oq05bxZyp+jdxV+gPp9MX00Hbr4Blg7iE3RdwMY3qw==
X-Google-Smtp-Source: AGHT+IGP/8uDbcQuZPyUN+nYEvHSJ4mwwsF+Xo8+UBqVwkSj14W7MFcRYdwtpFiQQAq1YnYYiMsL+2VJSX2z0zQnvS8=
X-Received: by 2002:a17:906:1083:b0:a19:a19b:55df with SMTP id
 u3-20020a170906108300b00a19a19b55dfmr5011952eju.111.1702499958799; Wed, 13
 Dec 2023 12:39:18 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Dec 2023 12:39:16 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAC_iWj+z31=9e1N0XOkRBWrmfTwxWXLhMWpOGpSbr_wK+r8rvQ@mail.gmail.com>
References: <CAC_iWj+z31=9e1N0XOkRBWrmfTwxWXLhMWpOGpSbr_wK+r8rvQ@mail.gmail.com>
 <20231118215727.95086-1-heinrich.schuchardt@canonical.com>
 <20231118215727.95086-2-heinrich.schuchardt@canonical.com>
 <CAPnjgZ3f+emLPjdhSSLBnGrGbqnHe1a5cajyL0csdVz1KTDfqw@mail.gmail.com>
Date: Wed, 13 Dec 2023 12:39:16 -0800
X-Google-Sender-Auth: SbGMipfu6QbZ1_CDTzIAbT3K3ZM
Message-ID: <CAPnjgZ0wJWoKAmce62rNJu3O7QKs=Sa2yNKiwMeZFdurTJ1Ozw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] acpi: consider XSDT in acpi_find_table()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
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

On Sun, 19 Nov 2023 at 02:45, Simon Glass <sjg@chromium.org> wrote:
>
> On Sat, 18 Nov 2023 at 14:57, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > The RSDT table is deprecated and does not exist on all systems.
> >
> > By preference scan XSDT for the table to find. If no XSDT table exists, try
> > to use the RSDT table.
> >
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> > v2:
> >         consider that map_sysmem(0, 0) != NULL
> > ---
> >  lib/acpi/acpi.c | 20 ++++++++++++++++----
> >  1 file changed, 16 insertions(+), 4 deletions(-)
>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Applied to u-boot-dm/next, thanks!
