Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99203EA71B5
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 02:12:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38A9383693;
	Mon, 20 Apr 2026 04:12:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YrYdULDT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EA5B83FF5; Mon, 20 Apr 2026 04:12:19 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 732CA82BF2
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 04:12:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ba25fd27571so363676666b.0
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 19:12:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776651137; cv=none;
 d=google.com; s=arc-20240605;
 b=Sl1uIk5xUYEI7ZNkG6EiUW1wRlpSz74FuX1KtT43ybVbt1+lw8RNTHgOBJFF91SAS5
 j9ujI3bslE23nZXTH0QZIpSfX8VlY0tueA4Zqb2re6mk+MFRboTprOkkTpmNSFrlnI1s
 WeqgOTCCU0WjI0TKNSsf5LV+/o8C9R1A5ASf/We4qNVSXVFgzUirTi28tbinlCiahN8V
 Ja+maou5hstQ0eZLOy7sZlBj2r63pQ/9HeKG+AKA9Z5xkD0NxbJNEyFybR+yOhANQrAG
 VURBwJ4uHZgUqaZ2rDU3mX2PmlwA+LVTFtobZ4vxR0PcN54wty22gsg8Qx1STK17CzTi
 SFrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UkH9+7A49vktGyZvzsMAHJO0wg1zvzRsNQU+6BVXNnY=;
 fh=JyUvwDeRDZBmaIcOB+ZPbNgllKHFgi4dFFNnhiCil7U=;
 b=T9AJREu4d7RNxyc6DXgiVbUqkAt6kJOp3RXMH/UOdY17YlpXzOqP8ymxzjKAjBCZK5
 JZnLvlmYBNXkGpIKZREafFEZ5z3r8m3QPOk/nkJQEzOJI73Org07//s4y3oPG+w1hO6b
 FwRznZck6vN16Lom394NZInbhDnkRGPXMA++nWn1OmKBjqJ0aWOU9ZnHR5fh9ewIJoHP
 Rlu4F3psDcFl+DN8FPPZoo3KwSasgpvuWcheolAfmxmgZ7vy02UDyW5qYMNxP1BaoIM3
 z4cPKTrgqT9nAsc1IjiTbzwrUJrFu72rzbc+iVTqDb0oVHSd8I1FB7mP8GLq+F9Rb9Rl
 2UGQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776651137; x=1777255937; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UkH9+7A49vktGyZvzsMAHJO0wg1zvzRsNQU+6BVXNnY=;
 b=YrYdULDT6C/0RrN6riATNqX53MtXeXTIOtcTXyvyRXbMZNh6oT3YvJ6MollkCHMhLJ
 Co+HT3KMhzsuMCgLNegJ6AJpCSpxUaG455kzUMr25KCfifaQEZh4nmB3VyG1MqmSrBPK
 XgZf3qmhishEeepqMZDTTGF2MUb7/YU/y9Dig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776651137; x=1777255937;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UkH9+7A49vktGyZvzsMAHJO0wg1zvzRsNQU+6BVXNnY=;
 b=bTrEPocTTyHumjzb/DSAAob8hNLaEwMXPowUdhdjbzHHFx4VyhWg3oRvtHnbqKciXB
 rZ9+Hsy5Rx5/GiinUx3rmUcNL+wNz83+XDnpIUf8Uyi8tlSVyUyNyio58DzpuO2LGWts
 f9H3BY1ODpehwFmKnR23jd+rYf/kX1KG2opXjK7qKnZj6FioS5ADpAxEpCBxy0pfOgeR
 rRd9BbaXJQJxrfO+7ziQKRKE7JZCvS95dPI4xuC3w3yxTs4TQ6mQG2wpB/yQPJ+nKNfB
 R5RUgcVZu8q8BNV/uwK1pwun0e6OEKSDx0H1ONRGxrTJvFF+anbI9UrPGFy/cKd5zuNU
 GuzQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9+ui8M3O/geYBgMOOZkE0K7q8AYp0a741MDYQMpyuVfoxVXe0YOPelbKwLRMhQ5FnU2/6Ao7c=@lists.denx.de
X-Gm-Message-State: AOJu0YxvOdvZS3j8Pfy6xApRyRoUOUvZlOdOl3+S37fI4hxJOvhKMzhY
 7F8pzoEjsLPiW/BM+jlWZytnaEGN4FaWlL3Xn+53A7CPwwWX7Qokoq/QOoTRU12vnFTP3nckkFR
 SfYKkhS0IniI81hIMhhYRIeFdEfidZchQR5IEY6ux
X-Gm-Gg: AeBDieuyfTTPsaB2kgdnXGAmAst79pFU/B0JYnZaKlWA4s0qNmXxjqUzTkcxGqa94GF
 pWGtno4OaJBZi64mGvscDTsl5dw8Ol9f+odBXAFE2sBRPCgMurEAHnPWeYDgGCw2MdzFFlP7PAM
 RNgop8hHxr6bapSy9GZDbCR/hf8Qlu6lEZKFGLJhViC6l23CQkZM0X64s8hUCM2zu086kEBVcZx
 G4lD8LaUGO6V0TOeSavqBzUtKpEKILPv2xBBs9CMYzxiQ2po2HweH+a6KPZ2tPWeweD4L8LWBjk
 lhms/ki3wD0t66BgIYTI
X-Received: by 2002:a17:907:a602:b0:b9c:c3ca:a724 with SMTP id
 a640c23a62f3a-ba418982fd2mr582858966b.8.1776651136847; Sun, 19 Apr 2026
 19:12:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260417130204.49896-1-philippe.reynes@softathome.com>
 <20260417130204.49896-5-philippe.reynes@softathome.com>
In-Reply-To: <20260417130204.49896-5-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Apr 2026 14:11:41 +1200
X-Gm-Features: AQROBzCHgaWdxU1enuKMqyrQ4K02aVHTQOH0SbkCKyfBy486vzX2q7V6j3MOrjQ
Message-ID: <CAFLszTiT+GFq46ayyZ6A2jVi7KNPp1KiCuciKeq7r2L0_GKY-w@mail.gmail.com>
Subject: Re: [PATCH v4 04/14] drivers: crypto: add software ecdsa support
To: philippe.reynes@softathome.com
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com, 
 trini@konsulko.com, simon.glass@canonical.com, u-boot@lists.denx.de
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

Hi Philippe,

On 2026-04-17T13:02:04, Philippe Reynes <philippe.reynes@softathome.com> wrote:
> drivers: crypto: add software ecdsa support
>
> Add a software ecdsa driver so it is
> now possible to use ecdsa signature on
> board without ecdsa hardware support.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>
> drivers/crypto/Makefile         |  1 +
>  drivers/crypto/ecdsa/Makefile   |  6 ++++++
>  drivers/crypto/ecdsa/ecdsa-sw.c | 33 +++++++++++++++++++++++++++++++++
>  3 files changed, 40 insertions(+)

> diff --git a/drivers/crypto/ecdsa/Makefile b/drivers/crypto/ecdsa/Makefile
> @@ -0,0 +1,6 @@
> +obj-$(CONFIG_ECDSA_MBEDTLS) += ecdsa-sw.o

This should use CONFIG_$(PHASE_)ECDSA_MBEDTLS for consistency with
lib/mbedtls/Makefile. Otherwise SPL builds defining SPL_ECDSA_MBEDTLS
will not include this driver.

Regards,
Simon
