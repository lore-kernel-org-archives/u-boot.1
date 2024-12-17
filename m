Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B9F3E77184
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 19:48:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 489CB80312;
	Tue, 17 Dec 2024 20:47:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l0qRdekJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C80A80291; Tue, 17 Dec 2024 20:47:40 +0100 (CET)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B872A80369
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 20:47:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-728f28744c5so5309059b3a.1
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 11:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734464856; x=1735069656; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NlzFBTl4DfonhFr8Sb67s+3BdXxLGJcWuDIYD7LsP0Y=;
 b=l0qRdekJS633Wev6X/fZ7G5C2BQCcVveYaTLJZEONYt587RsHeccYD2esmA9+9l1/1
 oM6YFzYHZNWkrdMTbXDXDDOzieFTVJ9+BDJhByUAy0S759UfQ+fhhlJIfO/6oNEXOxaz
 bBOoQ1CfDqE9t6ckZluPgs9G2HFRka8EhLxxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734464856; x=1735069656;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NlzFBTl4DfonhFr8Sb67s+3BdXxLGJcWuDIYD7LsP0Y=;
 b=HwEPsAwMh5v80oPprlTncQbcvU96sMmvyX4x39HIv54QQhrP2GNWOyvAskZv3UjC11
 1NOg0s5HPeazZyhmCH8L53QJAvS9fcbMOjI9j+WVzKMzQsyGbaXuRaBZ2L4x1PeIFGEe
 Y4aFcdLaBPAzEmeVrUm/9/OxecfvDiXvkdK8Hx0TkTZih3MlRpuaZ6Bc4cbUO47ofT+M
 cyOPryjdCjPrrR2m+z1qR2eWqAbL3qUy1aUbZIJ8gVSh9x6o+/rBpHj1KAQFhdnDQ/DW
 HgQExv3gbw85VtVytTERPvXoKTWczLYRc7VYRIMP6Dome1Vl3LF+W9ldeWlYhu9JqJJE
 KxZg==
X-Gm-Message-State: AOJu0YwFrDZ8eTKr/JlcPLuNhCEnB7ZxRfBDhyaU7lARjajqXpOlcg0L
 9r4g2UA0lIMtfc9gA0iga0GWvQVs6eRGnO7rwAsM36qcxMXY7HdRHGmTNatQy/ORoMr0ZP3pXZI
 4OGCww5TtHOwU0HJlt4WVO2KNuaOXzVtXfJMH
X-Gm-Gg: ASbGncsC+7PoagfWZzyEHd3CMART7+vMZK/8ws5Smgyi6eoa2vh5cFNLWUIY3xoC/jC
 3HrKgrNxlLGSsEmweIJOxOApFI8+84UO/6oEobs8=
X-Google-Smtp-Source: AGHT+IFh4xE/I66xmcOw6YbptxFhJGFgLO/b6/8vJDkoIPnTIwtD7XYmN9aZ6deu43WHdPKW/HsnTr2sGFrRmY44ilk=
X-Received: by 2002:a05:6a00:2445:b0:725:9afd:e195 with SMTP id
 d2e1a72fcca58-72a8d0311c1mr280611b3a.1.1734464856217; Tue, 17 Dec 2024
 11:47:36 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Dec 2024 11:47:30 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszTjou8eJYbFGm2gMYGY_y+kh5qcU20SOFMEUsKCrC_gqbQ@mail.gmail.com>
References: <CAFLszTjou8eJYbFGm2gMYGY_y+kh5qcU20SOFMEUsKCrC_gqbQ@mail.gmail.com>
 <20241211135418.563803-1-sjg@chromium.org>
 <20241211135418.563803-13-sjg@chromium.org>
 <CAC_iWjKt36c6KK7Sv0H8U5zP_i8Wys8v9UDdLxQ-Menh5Bm4pg@mail.gmail.com>
Date: Tue, 17 Dec 2024 11:47:30 -0800
X-Google-Sender-Auth: S5eMj44vvsabu7Zn2f7wNqoQ0f4
Message-ID: <CAFLszThNo3fY-r1Tt_t59B7qdX2UKVR6mGHD5srsUSX1AqL84Q@mail.gmail.com>
Subject: Re: [PATCH v5 12/23] efi_loader: Avoid assigning desc in
 efi_mem_carve_out()
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

On Wed, 11 Dec 2024 at 08:15, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Wed, 11 Dec 2024 at 15:54, Simon Glass <sjg@chromium.org> wrote:
> >
> > Rather than assigning desc and then changing two fields, assign all four
> > fields, for clarity.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  lib/efi_loader/efi_memory.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
Applied to sjg/master, thanks!
