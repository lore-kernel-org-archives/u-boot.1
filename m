Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33230C982E7
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 18:06:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7761D83B82;
	Fri, 16 Jan 2026 19:03:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jEtxFMQT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F07CF83B2C; Fri, 16 Jan 2026 19:03:37 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE53A83B71
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 19:03:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-64b791b5584so4191310a12.0
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 10:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768586615; x=1769191415; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bzxoYSCgeFJWxhjkLGYTzXNDLcf4pbH0TysaMixA8sU=;
 b=jEtxFMQTWhatuSswDj/+HbefMyYnumzg5t8LAm3ulu2OUxOc/g2YxlrDTBC0jsG71+
 OeUvWbX5zweOlKavGkAG7Qb0Xwl2K+REcYqntl5LmSUjtmOWOUZFeUQGsExe1NtRLoPi
 kAGvo7GKcN/wDI5hGDUQtcJ7M69e3LfyNV8XGf0eYj9/VBV5euh1fLxpX41QTzDBervy
 QBkSTE+FgpI6N+/aWiCTcIPgNp6PVHBnluz7Qa8Mk+9I43/GDzg1uS2F6ZFicLp6Rbq+
 +TVgJryxpHaU9D0qxDUlFYRPA94h+ZUj3H1GJJTNeim53jPlQT3ycWhrPz8ZK3fEpnnr
 W5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768586615; x=1769191415;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bzxoYSCgeFJWxhjkLGYTzXNDLcf4pbH0TysaMixA8sU=;
 b=c8F0whTBKI2EVarxZun2TvVJGMOGt7TIZ4SWqzbEvm9RRcJCPhFFdtlJ1lqmY0owf7
 pHQhcqBThF+RQcv+x7RWkqpfqRo8nDohWh1m3epjm7uxxdt6fZf3BiTE9dvRluQ5XKbh
 u0JZTJk6znoqDvWMNJ6KRR1vjJ9IiaKJW3dK7iQJDRrtj5ZcP9UQ+iGnKxcZQt/6I+Vz
 fmmOEXtKiMsMsRdqQolw7YFcljHU0+7/r6qVDT0dDkJj7EW9+MHkDRFemUYxnl4N9nXT
 NIC2AlowOlZ12b1pKQTUJ8UxjUx8HOV3H5BMIbIm80HUVPZrDpO3CdKQxRbaQ0iT3AIf
 MRMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0ZB8qQYCjnTpvY0/2o5mC2+HigUFRU8mnVAWZ9tPDW4sHQ8cDD5cC3lnGq/z6ZmjMg+dB3pA=@lists.denx.de
X-Gm-Message-State: AOJu0Yy0j/CPmBwVJTXHqKInjYs+svFIzeT+m4dbO+STcVRugyRY+bwW
 L09odg7e20XPbFK7CmZdQBh0oNpMuhOUYazoBuD68cTZdXK6GkhNAusSH8uo6vb6jX4=
X-Gm-Gg: AY/fxX5a276WQrDCK/p3qwGTB1p4rmmpi9SgVMwSsfiUgMAcVYIrlGkjdo92bklRWe8
 jkqM3Teo+osNVN/h50WhyiXXxHL92XbmtoHEBHrAkWqFBfkd0g0hj0aw84fUVBio5g9756MaUf7
 8U0YIvXZdnwRkrat47Ft/J6Xipz8JpkMAQjRbNx61uXscKqyUOyD5fY6AX8q6YhJjOsAF91ctl+
 XxS578wMXZfvPL4k+QpsFQzBbemh8P32Gwy/RrScvRe15JJQBmDZM+XLa2VKR4WFheVjT7/JIFL
 yltX36wniFxOnMWeGLlbyj6f96te4f7OXRprjCtficS13NwU7UjMDPS5dirSvdQkBpn6VJEU2Fe
 GSiLhrStkoUId2jGaC5oPLBbtLTatPZ59Tzg95QJ5CTS5cUjmMa+V5le/icoISpYQRlLKrx0k7c
 3EAnRAa+ABfZ5CO/Z9L8YTN+3Wje378E9GwJuSGyawweZCWZTbbQyjfg==
X-Received: by 2002:a05:6402:42d3:b0:64b:7e89:811 with SMTP id
 4fb4d7f45d1cf-654ba1d2dc2mr2735165a12.13.1768586615205; 
 Fri, 16 Jan 2026 10:03:35 -0800 (PST)
Received: from lion.localdomain (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654533cc5e1sm2932712a12.19.2026.01.16.10.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 10:03:34 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Petr Vorel <petr.vorel@gmail.com>, 
 David Heidelberg <david@ixit.cz>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Luca Weiss <luca.weiss@fairphone.com>, 
 Simon Glass <sjg@chromium.org>, Petr Hodina <petr.hodina@protonmail.com>, 
 Matthew Croughan <matt@croughan.sh>, phone-devel@vger.kernel.org, 
 Simon Glass <simon.glass@canonical.com>
In-Reply-To: <20260108-pixel-config-v4-0-76a2212b69a5@ixit.cz>
References: <20260108-pixel-config-v4-0-76a2212b69a5@ixit.cz>
Subject: Re: [PATCH v4 0/2] Introduce Pixel config fragment for
 chainloading u-boot
Message-Id: <176858661385.3399278.12645916008692694395.b4-ty@linaro.org>
Date: Fri, 16 Jan 2026 19:03:33 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773
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


On Thu, 08 Jan 2026 23:13:00 +0100, David Heidelberg wrote:
> Snapdragon Google Pixel bootloaders require the TEXT_OFFSET to be
> exactly 0x80000. Without this, U-Boot or kernels will fail to load.
> 
> This patchset documents Pixel 3 and Pixel 3 XL and adds the necessary
> config fragment along with usage instructions.
> 
> It has been tested on Pixel 3, 3 XL (by me), and Pixel 5 (by Petr Vorel).
> 
> [...]

Applied, thanks!

[1/2] doc: board: qualcomm: document Pixel 3 / 3 XL support
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/500d2e5e5546
[2/2] configs: Add google-pixel fragment config for Pixel 3, 3 XL, 5
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/338dbbba8787

Best regards,
-- 
// Casey (she/they)


