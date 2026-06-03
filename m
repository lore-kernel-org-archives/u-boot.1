Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 756BACD6E55
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 18:21:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3B288469D;
	Wed,  3 Jun 2026 20:21:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fvSwgG0b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27BBD8486D; Wed,  3 Jun 2026 20:21:09 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17BCF8467E
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 20:21:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-43bf95c3f6fso976823fac.0
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 11:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780510866; x=1781115666; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SK/UW08gnihO+hTsy7/82jNkSboWl7i2ykpvf3z7yho=;
 b=fvSwgG0brBhPkPsGw0VMUO5cI096nV6b2eCzhi9h6AeN8heC3HoxS1gd6bSSj6ZaJf
 X4Kjn1839YW9AH2zZHqd+cKqLBhp3zjdI7fnsAvxnb5UCeFxYGkvxSo64CXu2lwK0q3b
 NmT4oSokNJxtGMIoiaPqLputOiCPMDzX/pcqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780510866; x=1781115666;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SK/UW08gnihO+hTsy7/82jNkSboWl7i2ykpvf3z7yho=;
 b=qdPDfHwQhoyj6APRImrnChu1AVs3LgRNRZMHRQK4WoD+K+qPS9MT+ComGmqTv+fBgX
 c4xmukMB1hqdG4B1NvIZeqHstQ7tRc4njf3/Ro5AQHfBUeR727vpEzv5x6cAsepMm6HD
 6xp8XZUKkV+SlaneWTLsB9jFaMqJrBXNQWVgBXqaanhqFn2UF1NyPx/c3bx3fZSN29JC
 wrnG8oLm/EXKJ/JtR7LOgkTVOE0ZSWRaFYB84ed4QWqPZJTm5b65GpASxCuzLjeWfuGr
 TFLQ38oKq5oFM1NxZz+kO2TKUg94+Tzq6oCCiLMBQIrrIF5nHCkRV/tiXkXuClqIF+be
 elOw==
X-Gm-Message-State: AOJu0YylOi75OB2a47kBZFSHOGMdvB8YlQaR0IpCRnSpVlHqjiZlSwEv
 daKKeCVo+9PCDNwQKcKAODfunujyqDp4b554YwiSzRkGNqgE92G2slRYcAY6HsycJqc=
X-Gm-Gg: Acq92OHl01He5CiA7QkAdOO8ckQeEbR/d1HvuyNlWkXif3y36b/kq12aDNuyemIqScg
 u8rz3UrHOTA4NIDAdJVzuDoSILgbJHy5RXW0+D0h5GNObty+Sx98Ro6bKzPHcPtUw12bg7bdeU3
 DWWAf7QTENaZs7H4l1Z3G60Yk3OL0qYKHd585SepzDh+fPwmDoRd0zHoU//D8DHR64QBja8hD3R
 9pOxCCemJmwDXW7G9nsjIPqsHFCoAA5JHzGBY39tC4d0YMVqeM/bU18DZmXLum6BonY5XeXRfVP
 4iJfP2xu+CgMHGNiwQInK+lVMANglYSVJXouN5tDJLvsprMs2F+ZXIApAiZNwGIDZVcb0k5V2bL
 bWqhx5+HPh2uvs++/QHC3LBieB5F/qwbHuENYX70vxPlvWFiyBbQsXqqym3mPNNdcXGZCZMz3p9
 H5ivon9qXoLPbGmtlz2GmZIEuORlev1o7ePAFJOI7aR0qYA/6w0BSOqZjMNOlM+aikBU47FFOaQ
 BInqaRsMnDeDADDYGaycxSJUU6/Hu73rqMiaiuTzv7lwLgBmRsgqvY3FWVH
X-Received: by 2002:a05:6870:3042:b0:43c:30c0:3ebe with SMTP id
 586e51a60fabf-44107cc8d78mr285404fac.4.1780510865522; 
 Wed, 03 Jun 2026 11:21:05 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-440d7d3c2casm2820886fac.7.2026.06.03.11.21.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 11:21:05 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260603004050.204724-1-marek.vasut+usb@mailbox.org>
References: <20260603004050.204724-1-marek.vasut+usb@mailbox.org>
Subject: Re: [PULL] u-boot-usb/next
Message-Id: <178051086476.2223942.6386572842975048896.b4-ty@konsulko.com>
Date: Wed, 03 Jun 2026 12:21:04 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 3 Jun 2026 02:40:11 +0200, Marek Vasut wrote:

> The USB part of the staticize and constify changes.
> 
> The following changes since commit 4674475760d293d6cca07c2f85ef48029e08078b:
> 
>   Merge patch series "Enable splashscreen functionality on AM62X" (2026-06-02 13:49:16 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


