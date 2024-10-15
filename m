Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C29CFC279
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 09:06:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C1CF88E8B;
	Tue, 15 Oct 2024 11:06:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xS1beOaa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85F4C88F95; Tue, 15 Oct 2024 11:06:10 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33CC288E8B
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 11:06:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-539f1292a9bso2524082e87.2
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 02:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728983167; x=1729587967;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IW8X0n3TsIKIRqLtH7PVJgNLms4CzFMP8gLKFTV9f9c=;
 b=xS1beOaaSQwUqxu3r8wnioY6gIx1YDWH7A4abIT6UYqI/3zwCTZGNZJscHf0cLLCbp
 18sjr3LBZGgMQ4/J+N/ntiXWPjca6vxBqZBmsU4MNBMA1Ooyz8AAgrqPG0fylxi8PO9M
 KTPZDxXy2Y/PCRlxnp7ZXDGLMj+HQ2kF2k2bWmOnvP+9v2Am3N88C8cdTeDFDATOGGUa
 yPqNfl/0bKnGwREWpYm/aUIlY0+oWsV+cv9HXROQHg6VTaqUSdaYBGaEsJOtUoYmTS7s
 pXbVNbmNCBrJqoiIfTyNsOxK7iy95fER1IkFnwBmZ8Rqi6tFPQGn+uVTw1zXI6jjtXz6
 XjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728983167; x=1729587967;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IW8X0n3TsIKIRqLtH7PVJgNLms4CzFMP8gLKFTV9f9c=;
 b=uDFmS1nmec09DCvPk0iUXdQwelc0W34BCEnIY48NkqT66OE22T0wwHEsHgVKWI4kJC
 oXaNN7zWl9kQxX7mH814d2fbsbaeR11+eaSur5iEZ/WyE7VpNPBsoEn1Qd/H7M5CMB3e
 1X7wTghqyMgXHHzlq8wN97zvAQN+eTlqIEYk8hPdDC7m3jVtFsupEKTULIX+nzdeZgyk
 jCKGC7KRDAFr66hl7972pyN5hlCCgwZMz7/VtuThVI8M6VmE/Ct5DbYndgD39HEywcrK
 EvT8go6Og6cmvHwB/Luhp3NCBrT72Wz7gxZywBKayE/Iu987O6Gb62+CUzPKkU7mILDG
 DIow==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDDT43cILKu+HWLGsa/Yzb5r2FB1QSoWDUd4Kjzg4oQnHiOCh+S+uI6I0BAziyQFNfhASCgKg=@lists.denx.de
X-Gm-Message-State: AOJu0YxDmbBl9PCxk6jXf3tavAdYcjqIUE86n/40oiKB1XnGvYK8+qgI
 gVKqzq4dfyyOO/1JZQ+D2kxL9I9xR6Ex0sDdAqQTuOQBHlb4ROOODmMIWShvrgA=
X-Google-Smtp-Source: AGHT+IHta6mTuakK2lMf/Przt9B5ZJ46+gmc/8SLCe1uzASKTTV5E5B0KoDy8uUVBi7vdPSIt+YSUg==
X-Received: by 2002:a05:6512:6408:b0:539:dca9:19a2 with SMTP id
 2adb3069b0e04-539dca91bf3mr6163167e87.39.1728983167432; 
 Tue, 15 Oct 2024 02:06:07 -0700 (PDT)
Received: from mkorpershoek-xps13.carmes.etincelle-coworking.com
 ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f569e9esm11388555e9.18.2024.10.15.02.06.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 02:06:07 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Bin Meng <bmeng.cn@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
In-Reply-To: <20241011-u-boot-dwc3-gadget-dcache-fixup-v4-0-5f3498d8035b@linaro.org>
References: <20241011-u-boot-dwc3-gadget-dcache-fixup-v4-0-5f3498d8035b@linaro.org>
Subject: Re: [PATCH v4 0/3] dwc3: gadget: properly fix cache operations
Message-Id: <172898316649.19271.11245230377421386841.b4-ty@baylibre.com>
Date: Tue, 15 Oct 2024 11:06:06 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
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

Hi,

On Fri, 11 Oct 2024 16:38:23 +0200, Neil Armstrong wrote:
> We experience huge problems with cache handling on Qualcomm
> systems, and it appears the dcache handling in the DWC3 gadget
> code is quite wrong and causes operational issues.
> 
> This serie fixes the dcache operations on unaligned data,
> and properly invalidate buffers when reading back data from
> hardware.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/3] usb: dwc3: allocate setup_buf with dma_alloc_coherent()
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/1f12fc7e3350b179d17efaf5ba00fc3683cf33ec
[2/3] usb: dwc3: fix dcache flush range calculation
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/502a50ab1f7e32e3e90056597e8ce6a0931789ba
[3/3] usb: dwc3: invalidate dcache on buffer used in interrupt handling
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/3e47302dd71267b85e5ec65c5b6d881c23cce6cb

--
Mattijs
