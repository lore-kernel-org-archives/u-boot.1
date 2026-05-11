Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9DBACD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 13:42:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7886183C51;
	Mon, 11 May 2026 15:42:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CS0xKcFJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C59A83DBF; Mon, 11 May 2026 15:42:31 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82F178341A
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 15:42:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6804e24803bso1239731a12.1
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 06:42:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778506949; cv=none;
 d=google.com; s=arc-20240605;
 b=YQfdX1UI7Li62xdBhXYjwixkVKIpmI/ADJbVM157JegeixCUFe3hq0rvgRiy/+qdls
 gN9BGDKCqz3r2Qr40NPPFO+T1rwJS6rRQQu0pAKpb6C9TiKP0BFKg652InKLZfYxy6aC
 lJ6mncsK6lLtJkNzEfKMdgoWHaWc/dD7mirbTGZtFUy0/4X/u8zgnEQY7GaK74HGQLp6
 rRk3HznxpPNdYjbkrZpMvUo/B5HOqVHMY5Hfeq3uoVPgGardFgC1kpBenqrbk7SvVMmc
 Ky8pPeVsmVb69B4aGkHC9KoPHLCRSKlwEXdiyfpumNuA6SQCBrjvFEc7ABovJd5yht7v
 hT6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yRFmbmziDMSI6C8OrEGDzHrOiVz30wIIUVZaDBZfR+E=;
 fh=sIWgUzLaCEnfakr9YZiC7EQow5S8NWuzTkJzQgLwaqo=;
 b=j5kxklBn6iz1kj9613F9OJaynXH+nv/mEH9z02ZTjYdPNO9YvS3LTWYCSfyMVGSA/G
 hid0mbkbREJ2KUTPmnFA93+9WsJpf7wxFEP3VzlWv1RocGh3nIbgZRrculnk4gs+7ucJ
 08uFAvU07H0dukTc5b+BBStjOxAGi8rYfJ5HXS2h1YxtMSIQSq47G6PGWZu0208g5J4H
 DlDgrtzIN4FKt0f+yXEqcuSwpiDLnZVtYihXDoPWeiv2kOA7Jo+LQ5c16NZoPEtqMhKp
 Qj8CIbOShzWd7Ghqlwf3+Zj7mCpKbKuGk29uByE7VfELK0DXQ2yVAg7kz2HDYH8QdkOz
 u2Pg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778506949; x=1779111749; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yRFmbmziDMSI6C8OrEGDzHrOiVz30wIIUVZaDBZfR+E=;
 b=CS0xKcFJOLk9mXHJk6BSjvCW2k9JT/7cDGoNuvyAgALtT32hCrYNIc0b7IIpi0zmAM
 zSGrTm+MS9s8x8UpNvP0zcRXpHXbmbczbN8Z7IX8qu2qZUrTFPLMtRk/y7cbi0wOSRQV
 Fau7jPhi6I0mziY0qSPdk/S4nCvU/we4XJiLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778506949; x=1779111749;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yRFmbmziDMSI6C8OrEGDzHrOiVz30wIIUVZaDBZfR+E=;
 b=kfFrGelYC3Hh/J1xmdh9dv+OwdPyOixx+WHiIRw9SqoNnJoQnLyRbYWC6CUszmd5lx
 EC5fQeLiC2qkh0A5b0P8wdTD4mXhwpBtQEYUM22c0hubzBq2WzwCVJ5D1O/SAg/9So9I
 Mv7MCZDslHw2qXRPCdmvbNN/2hIOLoU1aS+CBCv7InwFfyvQP2Pt6xEeTd1Do8Xpbs4Z
 WZgladwBYXYNP2vYTJqMiTfMk2RNXq6JGbchzKQRet4KgmYh875ILE+mnuQJDwctSD7F
 Y2EA7q8SoWXQbF7Iw8ivrUnYoX4ZSmCjEBNQ2wkWsJdKXDcQJ9GpwJgmgJC5wjDFGAc0
 D34g==
X-Gm-Message-State: AOJu0Ywq29nU72VqDh2WNimrP0K+cQLNsFlva52cJsvxF/p2skvefmF7
 ISkzdqNygEO8ya60cSCoWqsKtzbBhHDOADGsfRexuBwkR7Qj2Vm+Z902319AE+UIvUEYfC3/nBx
 sUBO7khSoFbvh3omecYnY2xf3X4apI2x/cpZuKRlQ
X-Gm-Gg: Acq92OHIFPcnP5c6n3Mti8xXqxf9jWHg3ZxwwdiLsuaBceAqQNNA/c90UBlCSejDiE5
 XRLBHdETwH0OuvaPHOS+of8p2EUc4/K5U0LBCNj8zskdeB5bsLe/2IAZh68/vEn40V/14ivZ7nO
 EzgIPvVSQloRXiJEKCkxtr+HklXWhiIfpbIaWYJ0rqz35K3LG095mZF/N5pAfvf3hjJnN6DtRiz
 B0bYz/6yplg3FWrr1EPLtlX5x7IMlPjsCfc6AIFvSAMXa4XpJgnSdjVJxk72C12QzgfOiEh1zks
 aVltFw==
X-Received: by 2002:a17:907:9345:b0:b9d:1673:9994 with SMTP id
 a640c23a62f3a-bcaacd3d944mr817379466b.39.1778506948989; Mon, 11 May 2026
 06:42:28 -0700 (PDT)
MIME-Version: 1.0
References: <BESP194MB2805FFE6CC316B1923542634DA3A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
In-Reply-To: <BESP194MB2805FFE6CC316B1923542634DA3A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 May 2026 07:42:17 -0600
X-Gm-Features: AVHnY4KgezCE2R2QC2_WHngB_lv2F0_alc6eIeKMgywbOH10wQ5CNzaudMbP2gw
Message-ID: <CAFLszTif34aU=JmT9Xxejmsz2Acyfn8D803ihcJZMFZiPXV2Ag@mail.gmail.com>
Subject: Re: [PATCH] led: Fix toggling LED on initial SW blink
To: fberder@outlook.fr
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On 2026-05-09T17:30:53, Francois Berder <fberder@outlook.fr> wrote:
> led: Fix toggling LED on initial SW blink
>
> If the LED is in the ON state, it is briefly set to OFF
> then to ON immediately due to falling-through in the default
> case.
> This commit ensures that no fall-through occurs and thus
> a LED initially in the ON state is turned off before blinking.
>
> Signed-off-by: Francois Berder <fberder@outlook.fr>
> Acked-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> drivers/led/led_sw_blink.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
