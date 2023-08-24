Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A3AC27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 14:42:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDB53866CF;
	Thu, 24 Aug 2023 16:41:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="HKJUKNoG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FB5B86414; Thu, 24 Aug 2023 16:41:40 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD8EA86504
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 16:41:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-52557cc5e7bso8766885a12.0
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 07:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1692888097; x=1693492897;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=guCu5USCeHLY9+Zkr9eVXpPbVFiJuzpcNWNLnMmAIyg=;
 b=HKJUKNoGDsrw/LYUomZAQwW14UnJoqUh67y/m+bHfNf6yahcd/yRn6PNsM7weJpUSX
 RD1a89GDsCbU5gxQjH0oJaSLk/0sJ8MtVtZFlR9wKVGGi6p94q2KWYIh0q0jqZxkEeSc
 ZjztwmgzCTjfxXgOkvj78bQ0YNrlW9ngltnJWEOMXFqX7RcfZxVJv8YzmCfsmp8HPAPc
 Xz2un0YR/LFu0YWCtQZO1fuvEIrML/qXyuNYUGnFNwwjU9BfJQBVJbvpIutVHvBRNWlf
 EQtMw5REVj/O9qoQPhd37T1tVvoAQwgzqpLBY/HCohfFROrAovqZaOZ2LQCbLraHjd02
 XTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692888097; x=1693492897;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=guCu5USCeHLY9+Zkr9eVXpPbVFiJuzpcNWNLnMmAIyg=;
 b=XPtcYQnFPS//xkDMXE7+mtAKiUIH8I6XofgXGmj310J/mM3HgznXSLGD5mcFw7M0Rx
 73axr+6o8mvODFQcDR/7DiGBMoaEOw7TpMCeK7sMXH8p/GIl231WSbojqrz5aBiX5lN8
 bR1vmWaJ74tbKNIOpVCoz8kmkXfZB1+yRO9absABBpsHhout51DM2apqxyA4S5/AiSHp
 c5BHrIlhhP3XiWlxMMsGE/wo3YUAxAd3dPVBxirUeS2CO1sg/+1dQ2wVemamGRxFCDJa
 OkvYadPRVxFNvhnvwEuEd2aEj4ut81MSkjH8jbMrch+fybI9q+UTMpl1jildvSrEwEYe
 Fvxw==
X-Gm-Message-State: AOJu0Yx26lNpnQDk9ghqIzJ8y0xQKaTSo/3hNNay20B7bKKhzeuGQhbj
 LhxXUVZ42xV0XVZ/KpTl5t/dglBN03JhocA+HfNUXg==
X-Google-Smtp-Source: AGHT+IHP/vvI95Je5hxIJVWF0Uo2QWlxewdNJbrtSfXTA21a/jmxExwjzPQbfiQPhh6QT0UpEHyZDpxSPaJLvc6I+dg=
X-Received: by 2002:a05:6402:b2c:b0:522:ca6b:ad7d with SMTP id
 bo12-20020a0564020b2c00b00522ca6bad7dmr12617130edb.9.1692888097045; Thu, 24
 Aug 2023 07:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230824142109.2401528-1-ilias.apalodimas@linaro.org>
In-Reply-To: <20230824142109.2401528-1-ilias.apalodimas@linaro.org>
From: Simon Glass <sjg@google.com>
Date: Thu, 24 Aug 2023 08:41:25 -0600
Message-ID: <CAPnjgZ0JZCrPOCUZDgL10zXdB+LQQtv2MXZPcpcxXDY+u8MhHw@mail.gmail.com>
Subject: Re: [PATCH v2] efi_loader: delete handle from events when a protocol
 is uninstalled
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de
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

Hi Ilias,

On Thu, 24 Aug 2023 at 08:21, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> When a notification event is registered for a protocol the handle of the
> protocol is added in our event notification list.  When all the protocols
> of the handle are uninstalled we delete the handle but we do not remove
> it from the event notification list.
>
> Clean up the protocol removal functions and add a wrapper which
> - Removes the to-be deleted handle from any lists it participates
> - Remove the handle if no more protocols are present
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
> Changes since v1:
> - use the non safe list traversing macros on efi_register_notify_events since
>   we don't delete anythig from that list
> - Add a comment explaining the code that preserves the handle in case of a
>   removal failure
>
>  lib/efi_loader/efi_boottime.c | 89 +++++++++++++++++++++++++----------
>  1 file changed, 65 insertions(+), 24 deletions(-)

Is there a test for this behaviour?

Regards,
Simon
