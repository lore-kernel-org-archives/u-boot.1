Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D7EF8D755
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 18:44:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DF5F8423E;
	Thu, 16 Apr 2026 20:44:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XXmnVy/y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C7E18424E; Thu, 16 Apr 2026 20:44:06 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EE0A80077
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 20:44:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b9b1ffbb9f5so1177960166b.2
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 11:44:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776365044; cv=none;
 d=google.com; s=arc-20240605;
 b=Q1xqTZUcyDW+5d6ow1fmuAWCCIrRKRHJi3N+iIkRd+1ZhPGykENNnTL59iMcCXo4um
 k/eY6/R3U8lC5igsz6oG1LsXW/p+5EV0vgNi126QReWtrYnlh0xQCbTNowG7Oxq4DNo2
 /vjd9JNXPBqDgyppc0EWrOwBxBY/n/KJws0ufTgCUtcgtRhDaRWBt9PSnJxWyNIR3roh
 zWQZCSzIMbQ6DCYC4NH5rmVA3JzvI5AI+fPKaFk5sL03LKi3LVRuoXnc3m8S4TYtDNKE
 jt2argmoF2IsT+Tj1pd4+sYPQQ8SSUQ9qv4IS5HWxFaupIUIEWM+Kyt3dyVx6WVmE025
 AsVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8bC9Zhf/E42MJRTX2Ap9rjKl1tNyYW8ZxcXq99CkFxE=;
 fh=xveFpcE3d9lKQkwp4RgAuM+/FBZikc7hNIK5sYYtMIo=;
 b=iehsdAM3wrYIuoQI+BqAmUEPx1P+ZY+B/+wg9f0xE4iHBS9p4cbB+tpoFDKPW/3b9R
 33a7Y9n+YWA+j89Fpdibdvh3QlpnojkF7g8z+6iXsIhYnM3xiYIS7DNlOkdl6AS+94WN
 CLw+L+zq5rANNMdGiRkHUKKkr/gtBb0+VtKi/J7Sapzb4YLDlJCeYJmpaWssa8VdKutE
 QI7yoZcdzOgPBCoWqiMMfPz8qdEdy7Z0GfDmpM/NPX8d6YwAeKR43U+WRNxU31hMoIuC
 5c8TV81jQ8b7niNE1211l4G8Yswc36+uU75EBhGZG0O3oZiFAxZ1eerWf6HIjputTXLG
 2MTA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776365044; x=1776969844; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8bC9Zhf/E42MJRTX2Ap9rjKl1tNyYW8ZxcXq99CkFxE=;
 b=XXmnVy/y0boH9Fn6V7itKWtIUjgFGsTgq2IfYO4DxL4w8T26tQIJE1Qt2eUtv96Ghw
 WCinlCmbsZ1B8RDrMfbf7u/C1D4hWCkBLMvgr0Fuxkcz9dtOeKEKMkR6K+OFWy2JZi9l
 SZ7FzJR52jIvt55fjH/r83HzVbbaLcXshKPMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776365044; x=1776969844;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8bC9Zhf/E42MJRTX2Ap9rjKl1tNyYW8ZxcXq99CkFxE=;
 b=WCJ8hjyaXsB11LBoOEs0yZU0BQeBwAC4Y6doo0qGNVduNB86heqKrcGxK6yP9E4nGO
 5LRHEmmTmzAjAOzchQiHHd9vxuNPB5h9JdgjXF18u1fScxfsQSFhQimUWZCUsE6pH9Hl
 Qb+yHxJMhkl3uxEOGj2hwm7Iimh7GssR/4Bz2u4OchoM83+UzYYd0Uy/Norcdz2/4hJm
 OWrYa8dFbB3e9bhZbtQhfELWz+q9vIqYQGlE8MViCqXc/jUMM4Pnp1XTLhaiBrIz1hsf
 jhkABez+GzyjdKfqVWeFkrhfOZ9xAiWSEu7qPCE/cH88mMRRtJAN1Py8oX62jXjcbBcp
 uINQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/YvAiduy+kWWM5TU+20Y3y6Lgq7u136qpKUXRI3WOtuhXpXgVnyLEm0P3PqNZtjc2xSUmnwDs=@lists.denx.de
X-Gm-Message-State: AOJu0YxVg/ylYUFCjGnOIDPXs/PlWA1UrgBydIYBEJZLF7rL5S8hrbZ3
 QLZrQAs/K7TcIEf+Aa+O5tzicQQ/g7h7imeSJ56iXiu1HhPdff1MY7VxJ2FGMCy3hxjkTqD9nhh
 K8yQkLazSEL1xXMN/6kCdjd2F9ImAt9n3mBgRasUZ
X-Gm-Gg: AeBDietH0BNMV6mVH7F8yAb5XROLf9uWkUFVDP7kNW0wDglAjuAWoDH2Pt6e6UJWzgO
 MD5PZWRudMuHz/hgDPJG6sGssw9lQXpILEKt+HxyUu0D2JE1fnWWB3DpATz/qSJv6CT6sNqKh3N
 9BdAresz5Ly35jXcmYmM0leNrT/bGb/H5Y0Sl286EgipNfGVnRvHVJxWVgwp2ZLxXKD0E+UHuKM
 AQzd0yknilI+QfHTh1lvHIzlmS6NvgYqvPgS6ECHSeP6tq4GeDZEX4QwcIriLrHAi1cA7EBUqSa
 IPFPSleBc4Oqy1YT3cvCF50no/X89G8=
X-Received: by 2002:a17:907:cc05:b0:b97:98e9:1b17 with SMTP id
 a640c23a62f3a-ba3dda965ffmr26234366b.28.1776365043686; Thu, 16 Apr 2026
 11:44:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260415151759.85015-1-philippe.reynes@softathome.com>
In-Reply-To: <20260415151759.85015-1-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Apr 2026 06:43:43 +1200
X-Gm-Features: AQROBzB0xHLnL9UrDeV4pxNuoBmp0RRSmbjxNZRlxcFoKNcaUqYJCCbQ9NazpDI
Message-ID: <CAFLszThYZ434etE8MnR3ccC8hBYbORPGMB1DEqNXTAaRjZzm8A@mail.gmail.com>
Subject: Re: [PATCH] sandbox: enable FIT_SIGNATURE
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: trini@konsulko.com, simon.glass@canonical.com, u-boot@lists.denx.de
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

On Thu, 16 Apr 2026 at 03:18, Philippe Reynes
<philippe.reynes@softathome.com> wrote:
>
> Since commit d09256283f72 ("FIT: Image pre-load signature
> support must select not depends on FIT_SIGNATURE")
> FIT_SIGNATURE is disabled on sandbox. But this config
> is used on many fit signature tests. So FIT_SIGNATURE should
> be enabled on sandbox.
>
> Fixes: d09256283f72 ("FIT: Image pre-load signature support must select not depends on FIT_SIGNATURE")
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
>  configs/sandbox_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>


> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> index b681b91c3f9..f26295103f1 100644
> --- a/configs/sandbox_defconfig
> +++ b/configs/sandbox_defconfig
> @@ -21,6 +21,7 @@ CONFIG_EFI_CAPSULE_AUTHENTICATE=y
>  CONFIG_EFI_CAPSULE_CRT_FILE="board/sandbox/capsule_pub_key_good.crt"
>  CONFIG_BUTTON_CMD=y
>  CONFIG_FIT=y
> +CONFIG_FIT_SIGNATURE=y
>  CONFIG_FIT_CIPHER=y
>  CONFIG_FIT_VERBOSE=y
>  CONFIG_BOOTMETH_ANDROID=y
> --
> 2.43.0
>
