Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B7BC02196
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 12:33:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69BD180934;
	Thu,  6 Feb 2025 13:33:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IeD4gy1d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C7DE80A23; Thu,  6 Feb 2025 13:33:20 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 160E18091B
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 13:33:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5dcd3454922so1757314a12.1
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 04:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738845197; x=1739449997; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bTjLbpvL27BcxprNLiB45/A9a255pG3wG1SdB+K9XZ0=;
 b=IeD4gy1dHa4LeY8EswhFL+1aX2wK6jteVeqhZKidsUgmCVe41krTV7Y599KaIblN7E
 7FiLh9/d6dcIjnyhu+mTS7becYqsLyI1e1y1kIMru0hZgB2cduXPl7UIGZNkihcWUus+
 o4nwU0AD8dIVPk98P8o+nARcTmWplV5hKOJwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738845197; x=1739449997;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bTjLbpvL27BcxprNLiB45/A9a255pG3wG1SdB+K9XZ0=;
 b=YbHgIw9G18dY+W2cq3rmj8YAsrTvw8e8Lt5e1llKo3joVPsB+Hasb8XXvwqpb4OkHF
 dkymKg7Ri7Comh1VayM7vp0XGD3214m4blmT6cuo9WJ7PsOQSv+e0d72rfTTJdCY5HRB
 LAi/DFI72rfiS9IdBIlPLwa5cbwT0vWjct7/+XIV6Q2eZdWWPNRqWaairTYBCVHqEF+V
 0k1//jhMPU8SveolD6T6ABZW5xv9G3N2/QZjf6ak38cYOAs0ORWIBNeqiXReAbZ9qf6j
 wsT3Xk2FLvvosfdDBgXRhlEqe9FhrD6/ecQRu2CNSB8i20wHazEYU7PTK8UlfWgMypgP
 Rmag==
X-Gm-Message-State: AOJu0YwVysKqYqyGMzDW2mzXHgXTzN5juIYAEsvJ6+7vMrSW8OYKsBIB
 8UrcL5e716AbcaWQZlKM+lYLKaNZNHO0hd3YErmGeRngbGraUBWNbUw2csk4ws6sySQg5wlkPrt
 vbUKiVN0Vz/VFQSTM06gwPHVI+bA4Ih51bgB3
X-Gm-Gg: ASbGncvFHqpbmwaDmb+KmhAMsLmtFgvDu7gWThhI3OqeFTgbrgBB8ogNrHiiFtu0iSO
 SNKp4N0/sVJq5OAEBFzX+GQbFKUl5+2H9Yncw1NuxTb5Pu6O3hZ7tumbX0yDBeWFZ3FrMVJsYYA
 ==
X-Google-Smtp-Source: AGHT+IFUqNTr9+j3BynIJrY8LFiXafD5ODAiIe+r7h1WgvYW6Q1TwczTa9O5pOKeJmQbxabjyuYc8t+0ggVlcRX4Zrk=
X-Received: by 2002:a17:907:96aa:b0:aaf:1183:e9be with SMTP id
 a640c23a62f3a-ab75e215547mr716033166b.2.1738845197577; Thu, 06 Feb 2025
 04:33:17 -0800 (PST)
MIME-Version: 1.0
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-22-sjg@chromium.org>
 <20250203200937.GL1233568@bill-the-cat>
 <CAFLszTgO-nErzRg4FnM3rGCeHgfsAKCui3p9OhqP1YipyyN3=A@mail.gmail.com>
 <20250204020008.GB1233568@bill-the-cat>
In-Reply-To: <20250204020008.GB1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Feb 2025 05:33:06 -0700
X-Gm-Features: AWEUYZms0NWqgjJSqQTx0XIcKGEZ7ADSfoGgvSbGVoF8nmmRFGY3j_BgGCINeI0
Message-ID: <CAFLszThqpfGF1pgAy4GP0Yt+jZsKdYwC0bRcnnsy0WduAYBEXw@mail.gmail.com>
Subject: Re: [PATCH 21/32] efi: arm: Drop exception code when running as an
 EFI app
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
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

Hi Tom,

On Mon, 3 Feb 2025 at 19:00, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Feb 03, 2025 at 05:38:52PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 3 Feb 2025 at 13:09, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Feb 03, 2025 at 10:42:14AM -0700, Simon Glass wrote:
> > >
> > > > This code cannot be used since EFI is in charge of managing exceptions.
> > > > Drop it.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > >  arch/arm/cpu/armv8/Makefile | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > Why is SPL on in this case?
> >
> > SPL is enabled by a specific Kconfig option, which seems to have
> > exceptions but not exception levels. That seemed to match what the EFI
> > app wants, for now.
>
> OK, so why aren't you turning off SPL? You're not using SPL at all,
> right?

Not using SPL, but using the same code as SPL happens to use.

Regards,
Simon
