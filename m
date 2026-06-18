Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E610CCD98F6
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 15:51:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A57880287;
	Thu, 18 Jun 2026 17:51:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GDxJVm5j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3B30847EF; Thu, 18 Jun 2026 17:51:42 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 772D78005D
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 17:51:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-68d233bf083so1754223a12.1
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 08:51:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781797900; cv=none;
 d=google.com; s=arc-20240605;
 b=RmCFo2Bbj2FRe9eaOkkoVXjYrS5S5SE6hlXCbW4B8o0NfUlXHDyAsLMPJTEqtCUQVi
 YErWigy/TNGXLBzMuKmsiH6DNL1N+VnYy8hIrkucrLM030axo9JhQm7rqTVTHoS+bjiC
 2bYNBQp2P2JXZsLyLJRFmwfIlIir6Tea1JwEc3Wq0sr35IfeVSmim4ZIZtLk6tJ/nGHA
 U/JCqdOTxjXKhy0YQy9zqYmTqUWSlgCz/VGu54X05GhAkhNfXhI1iH6G+pk3RIZYLDET
 sHHUagOtr7kTg7jUjybsqGn50I2P9OYiuXjpPgE/wy5MJDG7uOgentcEh22fOaB6SJuk
 EctA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Vx9SzL6euLI7dTwnk9Ou7+rCy4nuZwhD/w4ogMh5CXo=;
 fh=DYMU3dRED0rmVKTDqXRHxrZw93vonVJHh6vC8tHyRiY=;
 b=MCveKXyAZGEdTTTDwXAVs0HYbVyQqR+Qa47pAiHs4lIUnptWlZhRHovv8Jk2sY4Ekj
 IbIAgTMdWLVoQDEw6tDyOL0Yy25cYry0olC27EQVlq3hxvxXWcnksvLk9LF1U1uzKmPg
 M/qdrRTntv6zf+ryvJXMrxip63TYCqVsgBskuwwLISZLaTSdIxcYUI+M9pkjjWrsEwAB
 wRp0wqv6Z8YQle6dmdUczPcmLYOx2+BInxmlB+LYypI64SHddd6rXjJDPxRw9TCYuWAq
 S9Ftaf0QONy/6NVwtqiKPVHBGnCJjesC2l/N9tmuKHfzSLn5La13srIe9y4PdMFNo3Vq
 HLJg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781797900; x=1782402700; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Vx9SzL6euLI7dTwnk9Ou7+rCy4nuZwhD/w4ogMh5CXo=;
 b=GDxJVm5jc61Q/oV8MSST/SdH6D3oaoVQDo2jMdQLFoOW9AnIHUdauJMzC7eZHiNl9q
 rZ569F0T8cem6wBInGIWj1oLk6XbCTLluD85NOoGBw6IEIL9/ZKw8OSa5UxtCdAMrcor
 UQ86EzsyUofAC+f4LGtvgfEqGy28IVGOtw/oM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781797900; x=1782402700;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vx9SzL6euLI7dTwnk9Ou7+rCy4nuZwhD/w4ogMh5CXo=;
 b=YjUKtoUhDp691EbjOKNvyKYBm7Wh/j5I3fG7BmHAzYtqayqnUqPbOMkR1G14S5qa/F
 aaYep6g8Nmn2snid2jzu/eNiIz/YSSSptkKIVaIJYLmF40hreC//QQJK/vJq1G1hUTC7
 1TEvUsarP3wOpG+uTIyYKb5A7+jJTl25gDWOUIJWW+E+Brxr8+6RM9fFz8YZsCnmAa7T
 ZH9lATt5R2Oy18Oam13jJZh/ZwQRMwwVANQ7WIJpWjM1b+e9gkN/928HYEeS3YIlhGM5
 Uu8P/mYDehldRl5obnNCMYu7qC/CTb8SYm733c7ahuMDmopB9IvL8PD94rbcJNbbgYqz
 Ivpw==
X-Gm-Message-State: AOJu0YzfXXlrFJIep0K6qWwOqVM0fDaqHRCcGEi65Zpofku8aIk1V2un
 9EqPwd+Bxgt0zEJlyxZB/4R+QOKlhGhqoScfITMGLG0u177NatLwOldy56HH47kRdQvD5QJKUWY
 /CGDxlzg4ctj+s5shjVZNuo+fU6MLejeod88wq2nF
X-Gm-Gg: AfdE7cmAgkw8Ub0l8civmt/hlDZXBg7Yf6LbkPGbufmd6F3OSt2jlshBPjoxXb2dkfO
 /hwOV1Fd6HMgFf5HpjjEmZ/h+Su+ckrOu6lJEdCfZmteKrBwFaMpOcyABGQNFs9s+P1pI5k4JGn
 nAprWHe2+u8ho686WcoFCWZtTYppY1zTPoOEOKj1Gc/jN6iuKkrO6k80eHf3Zh1gH+ZEdXBwCE1
 sxaMk/xchKbiB70TN/B+7qJfmkxzbJXGAI+L74LSVeNP3mlKrgelPYI9cCakM+BQkuTd6RBAg==
X-Received: by 2002:a05:6402:370f:b0:691:6fca:c1a6 with SMTP id
 4fb4d7f45d1cf-695476db4eamr4972548a12.26.1781797899850; Thu, 18 Jun 2026
 08:51:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260605033907.1909319-1-dmukhin@ford.com>
 <20260605033907.1909319-2-dmukhin@ford.com>
In-Reply-To: <20260605033907.1909319-2-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 18 Jun 2026 16:51:28 +0100
X-Gm-Features: AVVi8Cd5qhiGLMHvVAPS8iEnCxE0nVgHCYzKzZiTaAjvKPbB2my3lPeF5Q1UNhs
Message-ID: <CAFLszTiW818ybDfmgDfgE3_YnSfrZC7g3RWJeRmch5BRoOQUiw@mail.gmail.com>
Subject: Re: [PATCH v1 1/8] cros: add common helpers for GPT flags
To: dmukhin@ford.com
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com
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

Hi Denis,

On 2026-06-05T03:38:59, None <dmukhin@ford.com> wrote:
> cros: add common helpers for GPT flags
>
> Add common helper to decode/encode ChromuimOS-style GPT attributes
> similarly to [1].
>
> [1] https://chromium.googlesource.com/chromiumos/platform/vboot_reference/+/master/cgpt
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
>
> include/cros_flags.h | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 74 insertions(+)

> diff --git a/include/cros_flags.h b/include/cros_flags.h
> @@ -0,0 +1,74 @@
> + * Bit definitions and masks for GPT attributes for Chromium OS.
> + *
> + *  63-61  -- (reserved)
> + *     60  -- read-only
> + *  59-58  -- (reserved)
> + *     57  -- error counter
> + *     56  -- success
> + *  55-52  -- tries
> + *  51-48  -- priority

The table describes bit positions in the full 64-bit GPT attribute
field, but the masks and helpers below operate on a 16-bit value (the
top 16 bits, already shifted down to bits 0-15). So priority lives at
bits 0-3 here, not 48-51. Please reconcile the two - either
re-document the table in terms of the 16-bit value the helpers
consume, or have the helpers take the full 64-bit attribute and shift
internally. As written, a reader who trusts the comment writes wrong
code.

> diff --git a/include/cros_flags.h b/include/cros_flags.h
> @@ -0,0 +1,74 @@
> +#ifndef _CROS_FLAGS_H
> +#define _CROS_FLAGS_H
> +
> +#define CROS_FLAG_PRIORITY_MASK      0x000fU

The header uses bool without including <stdbool.h> or <linux/types.h>,
so it is not self-contained - it only compiles where the includer
happens to have pulled those in first. Please add the include.

> diff --git a/include/cros_flags.h b/include/cros_flags.h
> @@ -0,0 +1,74 @@
> + *     57  -- error counter
> + *     56  -- success

Re bit 57 the cover letter talks about counters/flags logic, but there
are no get/set helpers for it. Does that mean it is not actually used?

> diff --git a/include/cros_flags.h b/include/cros_flags.h
> @@ -0,0 +1,74 @@
> +static inline unsigned int
> +cros_flags_set_priority(unsigned int flags, unsigned int priority)

You can likely use uint here if it is only compiled for U-Boot and not
the tools.

> +{
> +     flags &= ~CROS_FLAG_PRIORITY_MASK;
> +     flags |= (priority & 0xf) << CROS_FLAG_PRIORITY_SHIFT;
> +     return flags;
> +}

The bare 0xf (and 0xf in set_tries()) duplicates the field width
already encoded in CROS_FLAG_PRIORITY_MASK. Please express this as
(CROS_FLAG_PRIORITY_MASK >> CROS_FLAG_PRIORITY_SHIFT) so the width
lives in one place.

> diff --git a/include/cros_flags.h b/include/cros_flags.h
> @@ -0,0 +1,74 @@
> +static inline bool
> +cros_flags_get_successful(unsigned int flags)
> +{
> +     return (flags & CROS_FLAG_SUCCESSFUL_MASK) >> CROS_FLAG_SUCCESSFUL_SHIFT;
> +}

Simpler as !!(flags & CROS_FLAG_SUCCESSFUL_MASK) - no shift needed,
and the bool conversion is explicit.

> Add common helper to decode/encode ChromuimOS-style GPT attributes
> similarly to [1].

Typo - ChromuimOS should be ChromiumOS (or the old Chromium OS, which
is what the header uses).

Regards,
Simon
