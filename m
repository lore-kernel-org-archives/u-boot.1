Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8715FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:41:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FA658421D;
	Sat, 25 Apr 2026 18:41:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="yrzz9Wk+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E80B084255; Sat, 25 Apr 2026 18:41:46 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC77E841F2
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:41:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b941762394aso1203065466b.1
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 09:41:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777135304; cv=none;
 d=google.com; s=arc-20240605;
 b=VSc2Ynsx1gr1+H0Bfw0guZpjxrdy2tMJjrudnpT65hSKCLWSoeOUMDAYmuIUUqB/oa
 xqtMvzFvyYTUdywTedrsqZAtzBesGnaPOpfRzZlDyp6SGtI8RYNmhMKAgVIAKU/3OIS6
 f3YncXfvKykV0oRdTc+3OYMq0vWG7+gaz9ebAOFj9Sada0xqhShGCsJYCsIT6ThTzTqx
 gxCYdvHgbLN/GW28iCVdIYYXvIjk2mPT3QnM1UJLkHAZlFjZ8MFDzWOpPshC0yVQCAD+
 7tYVJsSI8I5YD+6yGG2XBakfcKCaUGp6kLlhz+B0teEextYWjQzzqGZLwBdDOqgt/jDl
 NraQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9q0q9GPlYVyhjwUZQaUcNDP/7RfoHgtbiMg5uN50fo4=;
 fh=aRvqr786YHtUBe82UfMSbcUOWrfCR5PP4CDOUQfNeac=;
 b=Ht1dVwN60yxyi9D2hLuFlBkF7B3tNIVwb2RjqmxYhnKn1hn47E/Cv/y/2iNQdp5gPR
 t7owFtEwIkwfCsuDVOj0FI28rE4NOVxoFS179p8zv2iWdnZkSMJ9XX81tau5Sinwtrcm
 8UiY76oxTn6vQAAXyTnhKT3h1bIG73YW6zLImAnEdcG1+RZSyiOXoFydXaLP80jzB4Tt
 bfFKC3sOJVwKSwE409UgBCqOjIaXANuqmPq4+fzoStZG9KVDdC7bdTgWXhuWY/8MC6Zn
 6fB3eZiEfu5YWg9gtUMhG/b12Uq/q9u5IS73MNEydmVw8YVN2UQlZ9rZz1jDt53fmA/t
 GhKQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777135304; x=1777740104;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9q0q9GPlYVyhjwUZQaUcNDP/7RfoHgtbiMg5uN50fo4=;
 b=yrzz9Wk+ubv4iYgkG7kw4or3EuUFmex5NYGXY9P8O328AjODfiUQ9/g7N0RhFVBfBz
 r8U/Qbo1+EGzXZtxGGUl0kRzh6sJ9sTJsO8F/UgI1El2QLblxy56Ccl1hrT46iz9WBdN
 +Zaxs7HC63bKVA3vWrgoAlR03KMORM4+5ydtVLLVeSp4npt6XTBzXDm+CzyeK9aybiUL
 EUiqi9VZ4CLMxkwOmNtHUY3UhWfeTewNd613ykJjonhJvXknku3PGW2TLxoWB5QvXABZ
 nyMpNqvHTnm+d5fSBVGK6wCYh3iYoUJ01NGw3fooLRghwBNeyk5n8fbj8AgLX734ujdE
 V4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777135304; x=1777740104;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9q0q9GPlYVyhjwUZQaUcNDP/7RfoHgtbiMg5uN50fo4=;
 b=PZ/mso+D9W5DVdBt1AO/b9wlN1t8O0lY4sYOJ4GwZ9YJoXHPlnskhNGvs5VBJ/iJL0
 AeCslWhNXRUwp7TKhU+E3Z6tbGjlcM4OMr85OzfgE7qw0vl22l+oLFII2UOe/RIYYcrs
 lsHW9+WWUXiEdjJ4l7E5Gh8SiVHl2m3FlI+DG0qR8X6iuGzO1qRwh1EgcuzVKhoayUyN
 GnVNYZnngS3MUsspIrYqaGAxRiZQB7M8knxPp0RT0Wg544oZg6Em4i5+FV2B6050KkBG
 jDqiN9YEsy2MTYXk5Z67BhUYH3Iw2gyTaIdGo7rLFDUiRvQLCTip7SHSvzPurOgSRxZa
 ZSFQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/1uIzngGTDgMOAghxX0EalCXxKm7PbXtJu+5+fzoyn48KyCusPqmvdnJiqdxxJMcKExH4J4H0=@lists.denx.de
X-Gm-Message-State: AOJu0YzMFw22YxiMqhQl8vHQWZqT0SHORbDi+yVUJPjw3s604J0GylTj
 Q2oYEIkb6xx/Pfh4EjYfwRNNnkfm4uU/Xpd/HKnIgz4V1ohOZTY1ibPIMBLi5bNyuRk4sxIry7g
 FgTEStkiJ4hAK5SKxi2k2GeKWInOPvHmf/CQ1shwHIWAl9sGakDdghIs=
X-Gm-Gg: AeBDietR970202vTWXVNPa76PRkCWwwtI8ZE6c8Rl3kd5HmlCzwjvEaG0h1ngJ0p51H
 MxmhS4aFYETcNcKPjTkxgRMlST4C9D+Yf7uDWOMwJd/Ho4zyxZl9L6hct1M9v8nmSnkWlPFFWie
 ho1mY3rFCLVJM7iJ4pBM55d4SEG+k0ErcZHa/LDFJXol31NHQSZQo5D8RhUKvLKLJPgMBMpIqS7
 clMPqtxK7jy15LoUFF2XaE3AmhmaKRRBQLJjp4ALdjdEHqxNDXnIv14Xb3eNZNccbLvTpn/TpS5
 7rxJevkqyu7xxq+HQh0P89MCws+nDgrzl52o8fZIRlC77aO+80zA2QXwvuwrnwjKiae2rQLztn3
 cQhbbXuOi2ZHf3yzgrw4xQrFAQYKFEXi7y2A01w==
X-Received: by 2002:a17:907:26c8:b0:ba8:cad2:e001 with SMTP id
 a640c23a62f3a-ba8cad2e090mr721545866b.46.1776951760026; Thu, 23 Apr 2026
 06:42:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260421-mtk-configs-remove-ident-string-v1-0-66d5fc3d67be@baylibre.com>
In-Reply-To: <20260421-mtk-configs-remove-ident-string-v1-0-66d5fc3d67be@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 23 Apr 2026 15:42:27 +0200
X-Gm-Features: AQROBzDt4Yv7TSxyeTemA6KzHYG8nwj9cNS-VrFvj0sscj2jLR4JKHTDAgwhNNs
Message-ID: <CAEHHSvaTDTceQ=RR4fpJzE9KtU=TEt7vRqMc4ceQUjsN3-R0yw@mail.gmail.com>
Subject: Re: [PATCH 0/5] configs: mediatek: remove CONFIG_IDENT_STRING
To: David Lechner <dlechner@baylibre.com>
Cc: Julien Masson <jmasson@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Le mar. 21 avr. 2026 =C3=A0 16:10, David Lechner <dlechner@baylibre.com> a =
=C3=A9crit :
>
> Until recently, MediaTek defconfigs didn't set CONFIG_IDENT_STRING.
> mt8365 added this and then it was copied to some recently added
> defconfigs.
>
> This is just appending extra text to the version string that gets
> printed, so it has no functional impact. To keep things consistent for
> all MediaTek defconfigs, let's just remove it from all of them. This
> also frees up the CONFIG_IDENT_STRING option for use by downstream users
> that may want to add their own custom string to the version output to
> help identify their custom builds.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> David Lechner (5):
>       configs: mediatek: mt8365_evk: remove CONFIG_IDENT_STRING
>       configs: mediatek: mt8370_genio_510_evk: remove CONFIG_IDENT_STRING
>       configs: mediatek: mt8390_genio_700_evk: remove CONFIG_IDENT_STRING
>       configs: mediatek: mt8395_genio_1200_evk: remove CONFIG_IDENT_STRIN=
G
>       configs: mediatek: mt8395_genio_1200_evk_ufs: remove CONFIG_IDENT_S=
TRING
>
>  configs/mt8365_evk_defconfig                | 1 -
>  configs/mt8370_genio_510_evk_defconfig      | 1 -
>  configs/mt8390_genio_700_evk_defconfig      | 1 -
>  configs/mt8395_genio_1200_evk_defconfig     | 1 -
>  configs/mt8395_genio_1200_evk_ufs_defconfig | 1 -
>  5 files changed, 5 deletions(-)
> ---
> base-commit: e3405917a1806971d9e72a94186b299f05581e1a
> change-id: 20260421-mtk-configs-remove-ident-string-c825e222863e
>
> Best regards,
> --
> David Lechner <dlechner@baylibre.com>
>

Thank you,

Reviewed-by: Julien Stephan <jstephan@baylibre.com>
