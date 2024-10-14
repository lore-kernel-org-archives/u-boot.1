Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2D6CFC503
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 07:06:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C46388F24;
	Mon, 14 Oct 2024 09:06:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qESgmrK0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EADFD88FB9; Mon, 14 Oct 2024 09:06:41 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4B63889C3
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 09:06:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-539ee1acb86so1124159e87.0
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 00:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728889599; x=1729494399; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5U3GuIXHY3cSD5k4kQqUQIyL9BkhSt16J0D5pni9fsk=;
 b=qESgmrK0nEnFvTUMqjpuyg3HsncMRtVBwsOwHAwTUWu+D2sIkfLyMD84N1QkQPCRxw
 aKgNfAF1oGvbH/eoc0ihUkmnQU+Vz7pt+7qJrEM5GbBB0fN2w4gomiklcIovtdjLtkGn
 EkG8awplunFQoW1Bg3wQGtmrLI0VzJ11DOMmTnTlgf1PHZgQQTvwumXMiiGqCnpJTljT
 +K3bu7mieP4TJwNmGG7jksJuQ131Pl5UvIWo8xYkP6xaXzBf9yARDcnVVJgmPQD790/Y
 YAI4hBTc66nchuDPpRSxYx0tT1WrqSAeJzeqR8ZAzetXrVPtdEmckQjxcO/MaV7aLwiL
 quYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728889599; x=1729494399;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5U3GuIXHY3cSD5k4kQqUQIyL9BkhSt16J0D5pni9fsk=;
 b=wd/rzKrtyyMOabcMFt95JZraiamwGeXhviG+hcQDKmGAPHIqBfFQkVWCi4/5vAJAdg
 UZ5Ce77+tQcAWt5EU8EGEjcQsQDKy1vAKPQYIQIySa1VWfTSTewTV7WaLa8zGkXtH00r
 ChFn0unljuVz64pameB4Z3RrlZ47HJkXkxdHDD10RRSLaD8XPi65/s9QdPJwPwplMJdo
 ChrEEYNZqQNbfaN/yReUnwfl/8n8z8tUEnmYmPYs7Zc5GaZyTUO9QUxI6PJas4wrLfV1
 yZ9mVwl6+Kt5lw0dXxruEf1TWlZERFG+AzGHMlbf2ABDz8Lalc3Sw+7SYygWBKFMgyHX
 8lew==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpXohlcc8MfppFnSqDEIezNE55stTYUrAij8aE0QQlA0OVdos5bOKfjFBZXIxxSZucbeYX4CM=@lists.denx.de
X-Gm-Message-State: AOJu0YxCKJ8LrNa1+UrW8jKRZ0BgrxVKfiO/QVH4EZ25Rzxo19drfg2W
 GhSHmhAhxST+YtUFv7XTWx7hi0u12zpBu5z1wiU+UflOzPAEWD3pJB01wSdcGe+SrVkBaQYIIUd
 TxAg=
X-Google-Smtp-Source: AGHT+IHZL3ShY6Vdeefe7PxDPwaAPFS/6O+Gpq3oyUKG4S/D4WluxJ/c3CuAetBE3+YU6rRrCa6M+w==
X-Received: by 2002:a05:6512:3e15:b0:538:9efb:dbe4 with SMTP id
 2adb3069b0e04-539e5732139mr2017561e87.46.1728889598865; 
 Mon, 14 Oct 2024 00:06:38 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43118362232sm112355015e9.48.2024.10.14.00.06.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 00:06:38 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io
In-Reply-To: <20241011-yukawa-aosp-parts-v1-0-7d74aa13ff8e@baylibre.com>
References: <20241011-yukawa-aosp-parts-v1-0-7d74aa13ff8e@baylibre.com>
Subject: Re: [PATCH 0/2] configs: khadas-vim3{l}: Android bootflow updates
Message-Id: <172888959800.206113.1581753403828595952.b4-ty@linaro.org>
Date: Mon, 14 Oct 2024 09:06:38 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1
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

On Fri, 11 Oct 2024 17:51:01 +0200, Mattijs Korpershoek wrote:
> Recently, some effort has been made to use the
> upstream android-mainline kernel on these boards [1].
> 
> To use android-mainline kernel, we should:
> * Increase the boot/recovery partition sizes (so that it fits)
> * Drop dtbo support, since these are not part of android-mainline
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/2] configs: khadas-vim3{l}: Increase boot/recovery partition size
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/ce138d9742bfa15f48462c22f25424e0fcbfbb24
[2/2] configs: meson64_android: Remove dtbo support
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/0b063d66406e5bc0f367dd735216abe6a6543271

-- 
Neil

