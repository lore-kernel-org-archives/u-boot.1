Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D3DCD8C92
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 13:28:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 225E384843;
	Mon,  8 Jun 2026 15:28:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B7N1WmS6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C46A784843; Mon,  8 Jun 2026 15:28:24 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E15368405A
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 15:28:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-bed4f2f0898so545445766b.3
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 06:28:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780925302; cv=none;
 d=google.com; s=arc-20240605;
 b=LrT6BTnPrqz9LZ94v5W+TAGWEsIK59CTd2KKb3dK1DGRikc8ewU5HtBy4Kq9MOjaAA
 LaI/94q//qWMswhgAUJYGLxGiw2D8l44y3M0yeFeP3gdhOy3ax721FD545LeBZpgYBvP
 hKealRqTZT1zhjAInDsE0geNqyTKCKa9L8JdY63xhcLXkEUtxA7NWED2hf4dVwbKaP63
 6BKNku4e4nzuwwYAl6L1YhEfGx5iHebhQ/qXv/4Nb6W96zmAozUmNn3evSS2Whrbp04k
 nE7uarVIw0jA+ldlMDz2Yc2O8mkB7+ofB+mRr5GHsYNxZnD5zoSMxhMRUiHIx0xQzCKq
 F/aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ractLCB+wjTBsFXfk9mJWeVHrsJ8pQfq2jVRTuv1fbA=;
 fh=UHUx1BDKHdocvmGSlr/PQ3KVOzKk1jhgkH55wk7Q0/c=;
 b=bZ1uyXUtBdHNkMSFh0dOA/Ar9Ck6UxEJeGpZ/bsJhpRwyE2EcMXn00I79eTjJPHOcN
 Ijzf4E8HIrMW14AXmFePkjcN6RjmPHHzguC1EHvheeS1v5TM54x+UqyXxqZfBSDSneOc
 NkpDJ2K5s5exI2Yd4RVXuzNwXWDAOfIPcXwZKTL059zOIqzondzay4+gHNLXJD0mze5O
 3iCvMebKeLIqESq91pHb/nEFIakx1Vt4uGtexUlhOfz+aCXjxcmDBdQeEcxWozE0Ecjt
 QQ/DmsbvrUR7lLSrKr4Zcu4exYZn2J0iIRyl2Q/m/aDycVa3FKvYMxHQNU6umpEKRlyg
 vdgQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780925302; x=1781530102; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ractLCB+wjTBsFXfk9mJWeVHrsJ8pQfq2jVRTuv1fbA=;
 b=B7N1WmS6q2ytumNpEHZXxYmlzd3fg7om19WhNTX6h3jz6wLh2oPmISs6PiHI5yUnZ+
 LYQH/TOpUoGsfA1maJEg0VUq1ANsMCRqtFCXLX/d1u2zSngJNw+2LR2sHA5f1biao36P
 MUV7cWjG+vvttQfmKiU9BrbryKTYCjlOJAdzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780925302; x=1781530102;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ractLCB+wjTBsFXfk9mJWeVHrsJ8pQfq2jVRTuv1fbA=;
 b=gGO7U2mZyNVeoqtbZ+YKkeGJL6cK5+41f9CWD7HrqSA/0FoMfJKEjmys33NyiQ6dlV
 7/o4VyY64SWvHLahQ162aogM6IZQScnYqM32ff6Ua7EsTT0MmEXdE7Vff/q7zdgW6f94
 xBz/iiFtZY8aluqUD2m/s+0Nacr1lCFzv2S1d0AAJ6KUFejKR7geKqYx17X4IwUXzgk/
 /BBt5mYYtkOqzfQUHNPM2WeFwZV92qiey7MwI9nZzEnB9z5948xYwqIM265vTOtRtELC
 olmwJiF1QN8AqE/erCTRp0xnZALvgJHVgdm65eXDTtIB8dfcPD2DvqbUWGI7LvObD8jA
 jdLg==
X-Gm-Message-State: AOJu0YzVzvzGC3zU/E3PiuV/9qqA72wh+YgcfOL3qlctEZox1P6BQ4vy
 vyL5TWSeDu1ZRz518PY6xohw51CoTSO9FFW62zRfDht9oUEiaqr6P+bMERYaBPzYXGKt2K93FkH
 qPOFdXTQr+EGwMWQpEkzVt2Mp6QVSWGrwdwY6/55OGAg+O0ZNchk=
X-Gm-Gg: Acq92OFYhPODzob2Fb5GI6jRsjHYUuSkDeCyX8rKQ2kfe/jbg4pWotz7p/8LAFHQAG+
 ZqORno7jbSfIlWL1/Onnsp8QSBiIpnfpuueauhYWuCcmbiFjAi5V0QUpU9HtjuVH9YwLQ9oibdG
 x7vjEhREFO5zyrJwIYFj65mJ/GI4yvvW76pjB1HjP2Q61NoXwci3CGvG3hpZcYR+I0UdAuV3fc0
 WU8g9ugpPmbS23HoV3uBhnpcf9DHXl3HUWKFl+xM6lMjmq6vUG46TE9GPvlQzEbhaeLSWsHlmw1
 wFqgESbIw7g2PPMU
X-Received: by 2002:a17:907:7b8b:b0:bed:83ee:9223 with SMTP id
 a640c23a62f3a-bf372f1ee4fmr743560866b.45.1780925301937; Mon, 08 Jun 2026
 06:28:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260608-android-binman-v2-0-b8203682507f@samcday.com>
In-Reply-To: <20260608-android-binman-v2-0-b8203682507f@samcday.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 8 Jun 2026 07:28:06 -0600
X-Gm-Features: AVVi8CdnrBmUqFQBfGO8namDy-WnLkSxapjua7f54ThQ9h52j0pT7gv59svQp8U
Message-ID: <CAFLszTiXygEjctn9Ait5nn7PHkJO=ja1x9xubfsfJWivUj6gsA@mail.gmail.com>
Subject: Re: [v2,0/8] Generate Android boot images with binman
To: devnull+me.samcday.com@kernel.org
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

Hi Sam,

On 2026-06-07T23:37:09, Sam Day via B4 Relay
<devnull+me.samcday.com@kernel.org> wrote:

> Binman configs that produce flashable boot artifacts are introduced for
> the following devices:

>
>  * google-sargo (vanilla v2)
>  * oneplus-fajita (vanilla v2)
>  * samsung-a5u-eur (QCDT v0)
>  * samsung-gt510 (QCDT v0)
>  * samsung-j7xelte (DTBH v0)

Great to see this and thanks for digging into the binman side! I don't
have any exynos7 hardware in my lab, although I do have exynos5. Is
there an available kit or device?

That list above needs an update. So far you only have some starting
points for qcom. I'd like to unblock that too, but it can be a
follow-on.

It feels strange to be replying to devnull+me.samcday.com@kernel.org -
presumably this will get to you somehow :-)

I have a lot of comments, mostly about adding tests...if you need help
getting 'binman test -T' to work, let me know.

Regards,
Simon
