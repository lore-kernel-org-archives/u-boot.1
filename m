Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6EEFC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:39:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0391F8782C;
	Wed, 13 Dec 2023 21:39:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A+UdhCK/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36D9B8782E; Wed, 13 Dec 2023 21:39:06 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB49E87815
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:38:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-dbcdde08dc1so467736276.1
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702499938; x=1703104738; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=C9Ojg1y9uElCQD47eshgWy5Fht9hZTdnGqSPgxgItZ8=;
 b=A+UdhCK/vFd2gnxhg1uK0ReToxHH87jNqwJ8uxZDnqFHz+79uW7495u+JRUA+SVk7z
 wzJvEm96PvqwgEYHgolQtLoOFfjgOgA7UVYCMg+JpChyhwkXGHSZIYkbMJc+5ExJ1MIN
 tPfEo+/kaCgMCaF6S99sweZSdcdh7IM3+dNnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702499938; x=1703104738;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C9Ojg1y9uElCQD47eshgWy5Fht9hZTdnGqSPgxgItZ8=;
 b=ngVwsofOcwJ8RZz5B0kxUdD6/HXuIlPhmhkfUdn0I1sBt8XeVNaLI2uLZ8wjbj/YU3
 beIzhvhkM/uk/bTixFj+VOTfgvWY2SDKa1zqMlRtCz13cum4aO28GQPB49Wsnmc+0lEo
 bUoJBdFU1NxHe9CFoXjyhT6nShoZO/IxCRwcBj8AFShi0flwVKF9NLxb6aJNedbco6hi
 HtzY+x5ha2b0pgqDdexcZhsX54S6w8zhlINAESTqwLKrIMG1ekT+rMi/8XelpbKDHXjQ
 5Jw67h/vawE2G4Htm7EtTtyo+9XsZXtbia1s9yKMRKzF9Hecd2+H0KQUaZSm5VLfwOr+
 2GUg==
X-Gm-Message-State: AOJu0YyKEl+RLVJ7ulnvtDaeUqlsN2yvoxfTmEPYPTVvzjX4Zq6XJilU
 3lufebV5FaTNKQQz1hpUs6XvlYUkgeDHoPneRxu2VQ==
X-Google-Smtp-Source: AGHT+IHtmuFEfkG4HpkjGqWwN6uQBZySFVK8KILyeAte04qf9gxV8Tj0FOtwgbwHN2aCY7/MvtAS7Ez0UC0YLSwdJTE=
X-Received: by 2002:a25:944:0:b0:db7:dacf:6205 with SMTP id
 u4-20020a250944000000b00db7dacf6205mr6128211ybm.87.1702499938319; Wed, 13 Dec
 2023 12:38:58 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Dec 2023 14:38:55 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <871qby7y35.fsf@bloch.sibelius.xs4all.nl>
References: <871qby7y35.fsf@bloch.sibelius.xs4all.nl>
 <20231207123636.26264-1-ilias.apalodimas@linaro.org>
Date: Wed, 13 Dec 2023 14:38:55 -0600
X-Google-Sender-Auth: aWVoaWnbsBwDWcpz9PADVdh8Vk4
Message-ID: <CAPnjgZ1+BineczaRfHiEUSkb98gFNEgEc=oqV=n=TS5Q767RPw@mail.gmail.com>
Subject: Re: [PATCH v2] bootstd: Fix a memory leak in the efi manager bootflow
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: sjg@chromium.org, heinrich.schuchardt@canonical.com, kettenis@openbsd.org, 
 u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

> From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Date: Thu,  7 Dec 2023 14:36:36 +0200
>
> efi_get_var() allocates memory which has to be freed after the value of
> the variable is consumed. Free the memory properly
>
> Fixes: f2bfa0cb1794 ("bootstd: Make efi_mgr bootmeth work for non-sandbox setups")
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
> Apologies for the quick resend but the previous patches wasn't compiling due to
> the missing #include <malloc.h>
>
> Changes since v1
> - Add #include <malloc.h> since it's needed for free()
>
>  boot/bootmeth_efi_mgr.c | 2 ++
>  1 file changed, 2 insertions(+)

Oops!

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>

Applied to u-boot-dm/next, thanks!
