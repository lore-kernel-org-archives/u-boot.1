Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D18C021B2
	for <u-boot@archiver.kernel.org>; Sat, 22 Feb 2025 17:29:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7404080540;
	Sat, 22 Feb 2025 18:29:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gZapdu2N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98BD280EC0; Sat, 22 Feb 2025 18:29:47 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 638E1800B6
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 18:29:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-220f4dd756eso62710835ad.3
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 09:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740245384; x=1740850184; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l4pH+W6YGpGY7CEaGGix/3adIScNy4wA+6tNYC3jKOg=;
 b=gZapdu2NRYf56B0SRvUtiIJc6axfycUnHEqSSwEl9/A5mOBb61Fg0N8KsiS+qHMXBA
 2pMQ3F8v8Ajn+mSI++s9gfXrz2dV5BbWFfq76NG+xDP7PZUYhL3WoWKV62Oe6Sk7Elx2
 71gCgKwFL4RwVkhAfxg0ghgMTTv2OBrlv1hxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740245384; x=1740850184;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l4pH+W6YGpGY7CEaGGix/3adIScNy4wA+6tNYC3jKOg=;
 b=xKPv//vVKztcD8H0TInBF9UvjcpJGllG+FhbATkJQWf1WkRHgf8eE9O/+GSXTbgdgu
 9ZLbmivbCnHHWNK10ZA8G1I1nmDI8TpPWM+qzRzPUtl0PrK90vq/mRTBJ51wE7IAF8qf
 PegvLHlpqBog8MK1Na3RKROzOyYlZn4KjDC+6UuOXpMd5Ye/h/k/mEACZiP1c7+bzNWZ
 D7zWkV6b77mtTuOcNLyQAMVbr2WA/BUZquZjyM8pPDuGGNd91zeW4aGHsT7Beunh4uk5
 BoubUDqVUVLmLVj1clgYNJw2EWU1aVW1fCXO/NOd1OTpaj1Iro3V3D1YE1tbkVzLMTVW
 QrLA==
X-Gm-Message-State: AOJu0YzVLYa1w4nV5rpZNoIVOh0g2vxicYMc2PYi6NqTOI+b3wKQqCp1
 axQIJHEdVhrM2E1vah83Kscj42jOoV9SkiBNOMRrJmLIdJCPvN3dkTsSconQRmQ=
X-Gm-Gg: ASbGnctz55o7sYyneOEFxoJnapbHXvTzg+VrVmo2Rjjz0ywV4fKFArgA2ELXMUlGnFZ
 7iDfr2sdKwvX5tBmVxJFGY8oTubcDP4MP/ucsbrhtCnBByYoimAaoD4ePyBAN1PWQ8pkDUcxMvA
 eh4YIBtzBGXPBk6iv6V3ynvLlk1epEaySpZCNhbqRYXKmVvVk4MyD5Ew4yw+B84qfV1SvvXHe0t
 pxdpLvBY0+ofegJzWfrlSoKEuskPYrmBmVOY8N5s0IAQbCBRdOf0eXbeBm19eBhLyVdW3TrGAtN
 MqKeLPmNYKKS65/Hqm/ii8c=
X-Google-Smtp-Source: AGHT+IE/WY9jaoKjYWL6GcnTgseIH8veti3neh2gScDN4pOApEOB/qRJS/d3a2ERAQ+XCRC3jCn8Wg==
X-Received: by 2002:a05:6a20:3d89:b0:1ee:e785:a074 with SMTP id
 adf61e73a8af0-1eef3b1fc42mr14116599637.0.1740245383911; 
 Sat, 22 Feb 2025 09:29:43 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7324273e34bsm18116662b3a.108.2025.02.22.09.29.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Feb 2025 09:29:43 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Brandon Maier <brandon.maier@collins.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250204233355.2293249-1-sjg@chromium.org>
References: <20250204233355.2293249-1-sjg@chromium.org>
Subject: Re: [PATCH] buildman: Update tests for newer filelock module
Message-Id: <174024538243.3721828.2469008944983507483.b4-ty@konsulko.com>
Date: Sat, 22 Feb 2025 11:29:42 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Tue, 04 Feb 2025 16:33:53 -0700, Simon Glass wrote:

> Recent versions of this module call time.perf_counter() so add a patch
> for this also.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


