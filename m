Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8B3C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 15:03:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75C1D87E3C;
	Mon, 18 Dec 2023 16:02:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="D6eMuua2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D1CE87E48; Mon, 18 Dec 2023 16:02:43 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 619A587E34
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 16:02:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5d7a47d06eeso26541617b3.1
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 07:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702911753; x=1703516553; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wA8Le2A4sePK4t/WDfQ4aSek7z+zBbUD7PNEcY9kSQ8=;
 b=D6eMuua2w0VEQqqqY5LKmWTX/7U9ZSYgXcxM6O/wVMBAZ7k8LXs3X++PHOPsBmzAza
 7JS/3gDultwaGWkWbw2yGFG+5ChGrFAKtusJlJYsS+898+BGWJ4hhsB9Ykj+KgamS+7F
 xitOVcaysD7Z+PIlMEj2DNX7mfmk/Qbv1V0CQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702911753; x=1703516553;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wA8Le2A4sePK4t/WDfQ4aSek7z+zBbUD7PNEcY9kSQ8=;
 b=rQLbqAFajemeACyAoXydsG5s8wOQ1CKGSC+K/g4PKxiENgvsr5zFvI77cB0b1CKw4U
 3gX9A7b6QeDqjG5XK0VL0+FmSlm7YnnuAErbvwmRVC5h+nh/4rL4d7inO2JYhFbdMXMq
 fSk+7guMzvp9Antf9fHAcrlEyd6nzcWvCf+6mbGzIUR35EDJhYmtPyF45bk/uNPPjFKU
 D7aU7zt2FKlCurkhq7B4tO8F1ORnGLqcQ4eNX2aduul2G2iTKy2qvhEqf6qGJFmo9T35
 Dsd+6v+AaIKUJ0VczLbRcVYLTWaIJqOAPasqVW/ZpZ2RdwSbHrCRVoULDW6RIHQbzJZm
 fgHA==
X-Gm-Message-State: AOJu0YxSGYWpZ3PLItMM/O7UDzypj9kvw53MG77Y+cJalZch14wXy01j
 HG2mX3jGSGuUL4pDHMugbldevhraXrSMTvsNndrRag==
X-Google-Smtp-Source: AGHT+IH+nvQh6bWF2B7BdD42BSbD08lgoVy9wATEddsDinSAQKR0LXRrQPnFqboQvoWeCgA5KEs6yHO7TfYfYEUK1L0=
X-Received: by 2002:a81:d54e:0:b0:5d7:1940:f3d2 with SMTP id
 l14-20020a81d54e000000b005d71940f3d2mr11558446ywj.58.1702911752813; Mon, 18
 Dec 2023 07:02:32 -0800 (PST)
MIME-Version: 1.0
References: <20231215133245.7923-1-heinrich.schuchardt@canonical.com>
 <20231215133245.7923-4-heinrich.schuchardt@canonical.com>
 <CAPnjgZ23cv=i+9_vuM3EaQ2-vUhEvzcd7Dynowd41M5hsSGHrA@mail.gmail.com>
 <05b45f95-f760-49ee-9888-39ff913177a6@canonical.com>
In-Reply-To: <05b45f95-f760-49ee-9888-39ff913177a6@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 18 Dec 2023 08:01:33 -0700
Message-ID: <CAPnjgZ2BOkNrN=oK2j-vWaCJqwcvK1FHMhnztAW_V3H=b0f7KA@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] arrm: add ACPI fields to global data
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

On Sat, 16 Dec 2023 at 12:23, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 12/16/23 19:46, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Fri, 15 Dec 2023 at 06:32, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> Add fields for the location of ACPI tables to the global data.
> >>
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> ---
> >> v2:
> >>          new patch
> >> ---
> >>   arch/arm/include/asm/global_data.h | 4 ++++
> >>   1 file changed, 4 insertions(+)
> >
> > These need to be #ifdefed as they affect global_data size,
> > particularly in SPL. In fact, we have a problem there.
>
> Why would it be problematic to have more unused fields in global data?

It uses memory, i.e. SRAM, which is not that large.

Regards,
Simon
