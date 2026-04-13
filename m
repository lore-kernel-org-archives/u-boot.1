Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82447F34C5F
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 14:57:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFCBC83DC9;
	Mon, 13 Apr 2026 16:57:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OUeXAFp1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92537841BE; Mon, 13 Apr 2026 16:57:56 +0200 (CEST)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C21C7839D5
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 16:57:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2ab46931cf1so26862635ad.0
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 07:57:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776092272; cv=none;
 d=google.com; s=arc-20240605;
 b=h/NAgDG+VPTBMsuy3fa2RNP/q5QbAb1HtYSCx/BNImJuNZcap3dNIR9ZI9rv5SbST0
 pSOUNg8IP+YY70JLNqzKUCr8he6iBu7AfB6eFcFDVddz8kqpgKKCYqe7g1Op+KNHv0yQ
 BhwNy+Vp0UTuHyvpeKaTgcgw62uJmNRBYUkAQhRQKK8tIA+Z2/ecqHU/y42THOrNWHT4
 wbZVclvKQ1ew4DauUH9njKcwIbKt5uYVzfACBuHs+hhaX7ZVQ0Es7SvcCIO8o5yN395q
 8pa7OjCST/z9j4gasigyBdKXqETcIULF5rjG2rRZY4m+ZQwRJPaF3mGXCWtu+mENevES
 vLQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gCKkmflvDN4vfMe0WuXs+zNJ1N00shce1jddNpKl5us=;
 fh=dF+eCHOIT6SIbAzI5tBwPFZclvSQgQQ7Zo1JXO6SSnQ=;
 b=LIcSjZik8JFDi5oDwvBdL884AzvKKhAjTLha53evkwbPlOER1MothAgVXVVraPusZQ
 qYWY/w0KndTPtzznflxg06kXdRUzTlnUFKrtEbOtoVxtNM0i4haim8+CfTG4E0H/KVL1
 t273wGFifC39Abd3orixzrx69cAPY7hzyEbUgojCi2qNC0ScNJ6FHBmmGiXmsOI3TML6
 tuo491dvnBYlQXaHtkN8DECEsp0xAsQv5AnPvn7t2qDUakEdeVYN625bL61I+Ftsmiut
 vQUyYRx0jKiyW9AUWOahUxVAUBNjucfaeRO212+6wyCyRb2ChNVJwYJjamEF/MjJ4dv6
 HdOg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776092272; x=1776697072; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gCKkmflvDN4vfMe0WuXs+zNJ1N00shce1jddNpKl5us=;
 b=OUeXAFp10o0ALQ8mdJETZPBHpL0g/k/pasOs3iXbhNM0dTPPNZxRrAJfqVuW9MFP0E
 gacpRp18fOqOyIY6CMjNCWhGh/IqqylljsnndsLhojmQCaKCjE9gvg4TxFd7ArQj9R6p
 0LJrWX5ZU9CT+3U90Ao1gEnHF8YnijX1BVpF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776092272; x=1776697072;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gCKkmflvDN4vfMe0WuXs+zNJ1N00shce1jddNpKl5us=;
 b=rXukdnYjusTfLQMVQ5C6H4/bR/RtyzABhAXzUpRhCAGYS+0ZrxLIw2+dCDSlHsG5+y
 1vAWgjX/jLk3wd8rxiElq/lKxp/W1wHjzvteYnAqUG28Du5GRsm1KM/QoMXGYJ2AHXOE
 lka8IIhVdNOIIDhJcTmKSwuzw3aPe6LiPJJGuX2c+1AcmnhlOLPbqWwYb0TWhKHjFuAy
 UK3P74htze+ni35gahbgw2Trwi++S71saM9JkKPW9A5Ub9G8dL8Sh4BzSYCJA5QGwhUr
 IpkZWuvklJCcus8LMzg/DncAi2FbSfeLhb6bExiN44fJJza5IxaM20c5WSLWAsGM+Aaj
 oI4w==
X-Gm-Message-State: AOJu0YyntwQy3O60lNMxICkjcNCntevo1Zf96+l0UnGji6cwAVjbAYjm
 zl4pMyFcRL3D69wXnAAWPdcw69rxx7s6CsfP5hbz+Z4v6w/dDcB36YU5NbLb3HRrd8gPPzW1wmj
 F8+JPWlyU10eQYwoqgvu+f6vbtKknijhGnSWekK5g
X-Gm-Gg: AeBDievVOvYRKziuf0tCSvIbAR8mkXl6db3UWqkVnsnVHbhPaiRtlqcktI7enb1noEk
 cHZNZQENMoNSUwmNGg5haY/P4HWOWkJbe7dDwlLIwf81kJUDJ0Mh995mbRH4l0D1wEP1yTJRPjC
 RA4u3itTdfpLbZKHm4J69bJyCfY9F87w/q0mWBoylWMklpOxbchy83eGHojTrpqOuvcudfgjW0E
 BpXKkpsql0im1VMJcMRHquyBkYqLpZ1bRaPlJzf4cWwzREWZZVGp4/BxLe/Nf9CHLzZiM8IIOV+
 FT40Yg==
X-Received: by 2002:a17:902:7b91:b0:2b0:4c68:283f with SMTP id
 d9443c01a7336-2b2d5c55bc6mr90012685ad.5.1776092272095; Mon, 13 Apr 2026
 07:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260412195947.1982729-1-ravi@prevas.dk>
 <20260412195947.1982729-4-ravi@prevas.dk>
In-Reply-To: <20260412195947.1982729-4-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Apr 2026 08:57:13 -0600
X-Gm-Features: AQROBzB3A_n4orpjg3C17eODZSq6n_RH0IT-J0JEbAcL2V6T5Wd8FGgPGw0J2Wg
Message-ID: <CAFLszThip+L7JgkVt4_SDMDKgjc6=6HoXi8HseAcAL-yMGmytg@mail.gmail.com>
Subject: Re: [PATCH 3/8] lib/string.c: drop pointless __HAVE_ARCH_STRDUP
To: ravi@prevas.dk
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
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

Hi Rasmus,

On 2026-04-12T19:59:41, Rasmus Villemoes <ravi@prevas.dk> wrote:
> lib/string.c: drop pointless __HAVE_ARCH_STRDUP
>
> There have never been an arch-specific optimized implementation of
> str[n]dup, nor is there likely to ever be one, because unlike their
> cousins strlen(), strcpy() and similar that simply read/write the
> src/dst, the dup functions by definition involve memory allocation. So
> drop this irrelevant cpp guard.
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
>
> include/linux/string.h | 3 +--
>  lib/string.c           | 2 --
>  2 files changed, 1 insertion(+), 4 deletions(-)

> There have never been an arch-specific optimized implementation of

There has never been

Reviewed-by: Simon Glass <sjg@chromium.org>
