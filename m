Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A752C4706F
	for <u-boot@archiver.kernel.org>; Mon,  1 Jan 2024 16:50:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 522E98784B;
	Mon,  1 Jan 2024 17:49:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k2PGd3Q1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A76D987837; Mon,  1 Jan 2024 17:49:31 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACC7A876C9
 for <u-boot@lists.denx.de>; Mon,  1 Jan 2024 17:49:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-67f95d69115so72524356d6.1
 for <u-boot@lists.denx.de>; Mon, 01 Jan 2024 08:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704127766; x=1704732566; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UYfj9WGkqMZwZDwbH62uk5HGS9bmaVOypeHNawVDXEo=;
 b=k2PGd3Q1TvNnAYIUQnvyra1cabhJrbLfgR+GsAxcbJ+OR605ANKHVvhCxu2CfakKsX
 fCj5gMRztNIa/kXFb6Sk8oif8oyilPwt6O5K5OTnJEXEGucpElUP8HSLSCHtaW+P0DP9
 GgLmScAwPs2WeSPQdtiqD4SooVN6jTOxw3sM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704127766; x=1704732566;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UYfj9WGkqMZwZDwbH62uk5HGS9bmaVOypeHNawVDXEo=;
 b=QQ/m5Kx3DmXUZ0XwXamFSlLJeLdJy14PipIEXCM7DJuEBI+3oUOTSNonXg6AjKRXP6
 uMohRlruYqmifhXG6+FAbNvX7rcGNpSzuo0g086WHsPgEzsV8jDGbKMfuKeMxGyOfKFd
 Rd8XXzwCaY33ErHemxhVRwsWHtfRMvc0O7ABu2u0WE8aBnGO6ybmQMp4gXJTHvJ7Xr7r
 t56151IzFr5adyJwUnna4qmysDrfbJu+fjEKKnx43ja8BW3/N/g2OaK7ztpMKKXPpW9l
 DZ81Ut0uTj3eA92nPnvbSQARdQs6oTs3tS6/PqYhylOe53MyOcRDCjVseBJ7pnkGgBrB
 5csQ==
X-Gm-Message-State: AOJu0YwCkzkDJHhVH6uAPXRBjBst5HgcExmlRRnlM3dUz7GmHkelc5VD
 WXSyAqqokr+W82SHDP5vV818yKOCV1qj1EcPeFxslNwPzDVq
X-Google-Smtp-Source: AGHT+IEzNbm1yUCdKi5LQw1d8peKYUS+YRaWClvHvddWuIdS686jVpuBNREp0agwm0tpiDGJQarF9v0KmV2Jp5iWUlM=
X-Received: by 2002:a05:6214:23cb:b0:680:b912:688d with SMTP id
 hr11-20020a05621423cb00b00680b912688dmr1275397qvb.91.1704127766120; Mon, 01
 Jan 2024 08:49:26 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Jan 2024 11:49:25 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231217163627.2339802-7-sjg@chromium.org>
References: <20231217163627.2339802-7-sjg@chromium.org>
 <20231217163627.2339802-1-sjg@chromium.org>
Date: Mon, 1 Jan 2024 11:49:25 -0500
X-Google-Sender-Auth: EWbvSUL3GMa6OdHn_78FrNI-WwY
Message-ID: <CAFLszTg=1mRS80TUEj1X_7Teh5TNxEsH0Sh1VCrNDC4cTPiEaQ@mail.gmail.com>
Subject: Re: [PATCH 06/10] fdtgrep: Simplify code to inverting the match
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

The code to invert the match in h_include() is a bit convoluted.
Simplify it by using disp->invert only once.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/fdtgrep.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

Applied to u-boot-dm/next, thanks!
