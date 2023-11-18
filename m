Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C7C7C5ACB3
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 17:16:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 252DD874F6;
	Sat, 18 Nov 2023 18:12:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AOjG+BBN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31678874ED; Sat, 18 Nov 2023 18:12:14 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0E2087263
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 18:12:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5c8ebf18a21so9871857b3.2
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 09:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700327523; x=1700932323; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5gorG8kHfmGM6ienbyN4hCs+A5kgQRhp/BvQuA+R9fg=;
 b=AOjG+BBNx8BFimaenGCYD6GZFsoSo1OFyjGbCA0wCPFGvtUtabRowbJ2DUKbtrc5No
 Sx3isJ0daofy+mhI28c8VGCp+S+I53eYdGXrSUYDZuYKerSLfP3EI7wvcHUmcOlF4b+F
 IPQqFv6PZZLUKcWw60Tj5hG0rJOapArBf5DV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700327523; x=1700932323;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5gorG8kHfmGM6ienbyN4hCs+A5kgQRhp/BvQuA+R9fg=;
 b=uPLuh78JeFTn9mTLgKUHivSiILkSdxsMDsfY4qlrtpzRJ+xoYIa94OCxXPSaURdHi/
 IPNPxn7AeGUXDIk3Vby7vAQGWkm+1pZWXL4ZWBu+0GSBJlOwQpTY8MvAtCzsjANzC/ab
 z6tqOYo+0ASystm7hbDVocf/cdqvsrCBRRVApq4SwIyhmqJXwEABrdcAdixrXozejBqU
 J2Wd0Ni3vqGdURiiBHJ0TLBcH1KxZ0G8pOLUunsjBCrwPZdKl8zKRqr0yIOY8yGa92yw
 7kQDiFiU6QF8ysU42iJ8lnV2PCYD97fvz979Moi8FKSH3OmEKQJMkn5XBbkCgDsq56em
 PfAA==
X-Gm-Message-State: AOJu0YyoRCWpN+IZv4krTaa9XjKUbFqIknMmD7A5scNG+tWSfGCOIo7/
 WD/+22HMcqwxRmbvs9CIwyy+TFGOruiKOqgWgkg0vw==
X-Google-Smtp-Source: AGHT+IHCmzv1i/b3h8Lg2HyMvEdVzIrWpTJDQo2q9n180em1RhknPbP1HuZ1ncjMdNYU8d1ZBrr03GwGEVBsgyp1zIU=
X-Received: by 2002:a0d:d8c5:0:b0:5c7:3a8:179d with SMTP id
 a188-20020a0dd8c5000000b005c703a8179dmr3025738ywe.14.1700327523334; Sat, 18
 Nov 2023 09:12:03 -0800 (PST)
MIME-Version: 1.0
References: <20231117225313.2144665-1-trini@konsulko.com>
In-Reply-To: <20231117225313.2144665-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 18 Nov 2023 10:09:56 -0700
Message-ID: <CAPnjgZ0ixd_AK22_76FGw=OzqCf2ysm9wqoaAkMYVJT_=9hPXg@mail.gmail.com>
Subject: Re: [PATCH 1/5] qe: Add <config.h> to linux/immap_qe.h
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Fri, 17 Nov 2023 at 15:53, Tom Rini <trini@konsulko.com> wrote:
>
> Given how we define QE_MURAM_SIZE today, this header needs to have
> <config.h> added to it.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  include/linux/immap_qe.h | 2 ++
>  1 file changed, 2 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
