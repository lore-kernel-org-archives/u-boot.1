Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F26C25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 16:32:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83A058860D;
	Wed, 29 May 2024 18:32:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ODhg+mL7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B0298860D; Wed, 29 May 2024 18:29:57 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B61488615
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 18:29:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3d1d3c7f7c6so737976b6e.3
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 09:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717000194; x=1717604994; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4UfF5KNH0GY+EsEcAMx338y3ntSiP7OHAJVIqsgB2Tg=;
 b=ODhg+mL7HGyuhNJr9E8RbkkeaF8QWHMLliQ+CrEyU/GiKMd8LFixNoWYh2lFLc2p/o
 xrAQMO5Z4ZzRyExdGuDzPcDUFp8B52oG271ECZsSaatHkiQnGDEOkox0QVH3NpVouqkQ
 In6Cd4vQ+XO5xUb2OUmFf64s2bS2VTC5MsZ+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717000194; x=1717604994;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4UfF5KNH0GY+EsEcAMx338y3ntSiP7OHAJVIqsgB2Tg=;
 b=g+5VHkBUKfXLG6m3nWyUAz4eYmNh+vzzB+zUQEmRZq0fLh5O29rLyCHFPI2jiF0AAm
 JhDDVxsCSn61utHRDrLkhiMfxo8UXLA8/TO1o6OF8+3PeaGGOEOT3OLe2yrvBc/lZl6U
 OFtXxoyg0OmQC2Js+zMXBz1isCOLi3RVUMG+XzAK+4HMb32dsQ3Nj0fTBXCQIQwdKZdT
 +Jh2Etb9sBfhrnCDk38CNR7sqjCn1DwNrXWAa+6UJDywEquNf0coX4/i4o9uKpUWuGgf
 Q7EDcDTh1sKbc2b6kul8v5Jb3OoUTKA60GkRGv5obJPcS4SFpIIFDKBdpDYFc/Gsm/Ez
 UlMg==
X-Gm-Message-State: AOJu0YwKWkUSzagD+vXQJUhPpueuRIVt3WuUKhS1Ga/7isLWIjZcZZKg
 GT1vMg+INTV3Ne+v9yvM3f9tuBvQdyjuPO5GSqyq5BhSWx9fOE+zeq25nKPZ+nT65tT2k2mqeZD
 Xpn2F01O1MDOezZjzHq5PTQXw4qrkJb7iRAQT4N71DybgL7o=
X-Google-Smtp-Source: AGHT+IG3pbJHrWJqJ6HRtEDnKyeZ7v1PnOcsLDktlwfQSlLORZ2O2aTWVxYpWqLHSXUOVnsGtvD3XyZzD4jDmz7ImWc=
X-Received: by 2002:a05:6808:6096:b0:3d1:d4d9:d9dd with SMTP id
 5614622812f47-3d1d4d9dc1dmr3699140b6e.53.1717000194017; Wed, 29 May 2024
 09:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240527200417.2108290-1-rasmus.villemoes@prevas.dk>
In-Reply-To: <20240527200417.2108290-1-rasmus.villemoes@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 May 2024 10:29:43 -0600
Message-ID: <CAFLszThQPiyH+3L07=aufMLocL3YGiHaL20LMCvmx=BV28+7NA@mail.gmail.com>
Subject: Re: [PATCH] global_data.h: drop write-only field dm_root_f
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 29 May 2024 18:32:00 +0200
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

On Mon, 27 May 2024 at 14:04, Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> The dm_root_f field seems to be entirely write-only and hence
> redundant, unless 'git grep' fails to find some access generated via
> preprocessor token concatenation or similar.
>
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>  common/board_r.c                  | 3 +--
>  include/asm-generic/global_data.h | 4 ----
>  test/dm/core.c                    | 1 -
>  3 files changed, 1 insertion(+), 7 deletions(-)
>

It is used for accessing the pre-relocation devices in case that is
useful / possible. But it seems that we haven't had many use cases, so
I am OK with dropping this and adding it back later if needed.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
