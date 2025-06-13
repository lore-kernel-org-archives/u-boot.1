Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9824AC71148
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 14:26:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B049D82D21;
	Fri, 13 Jun 2025 16:26:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F1vN+mVu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B264382D34; Fri, 13 Jun 2025 16:26:14 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B41982CE7
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 16:26:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-40667dc8a62so1097266b6e.0
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 07:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749824771; x=1750429571; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M9TnHoSUcRaXSsS/EwiQg9fZn35Lr6w2GasE1udY7u8=;
 b=F1vN+mVu/1AOUUjYVJGKlBp8AXwMraIerV6Hz7+SMUvZsw0Gb85J1C0/nchYwWS+ZJ
 Zjzph4F4Vr436xeImQOJ3JRyGpCI9lDKnAmn/qhQAgBnmpSMUf9hJhXVWXIhGJhX7Tjl
 QWEeZ5OAlZOl/sl5CmlQHUA3IVuyBIGN8TthU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749824771; x=1750429571;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M9TnHoSUcRaXSsS/EwiQg9fZn35Lr6w2GasE1udY7u8=;
 b=d5kzJSqoRECIIdTpgSk1j21EtoG+MYqy+7krZmWS50gxFFyBWOqUr6wPj1kO740vSk
 BwwK6gNtCzrIe77mhr1b++oobXqEiQFVweaLyekQZXVtBvG7ciMLmUyixn1T0jHY1b69
 8MISAPF4cRmJhtIgjangPMc1JnQf0aOz4wC5grSrKc/BRy7cIXMb/kmU7nlpCMgWjvxY
 TTlDk/x8AxehrsW51EL0oVsfYFyIdW876tq+TtzVGIK3igna1aab2QenB55ZfRTjTYdD
 c7cwclNub2cMKxyhS3qr7PMZuEmsB0Hcch2bTZv/6M+xQAl5LMbBHXjGJZkxvXaX3dgF
 i8yA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRALbeIt+dUU3VKPMwb9RnoWfJ/9gR7/NbaoHzN0Wxb+rG+EEB4yU/wm/dX2kvTp1xhIOpp+o=@lists.denx.de
X-Gm-Message-State: AOJu0Yw2/OzTaboyCUFlQFo4ZFiITW6miGhdTebA/DitZm4Dqp4nh21Z
 erN5zrAEczCMqQoSnT0iR4Ockf4n3wuvViu75g8xOnZ0hTWke1kJmNXn9f4JluWVtL8=
X-Gm-Gg: ASbGncuoAyI9WP+MZL6WKzmBPao3eDzdPO/5ULXCTedF3DHkbCbVlFbkb7lDTB7vd9u
 IB7pRpo6RIesfs5jaJwMaEUG8GnUW/Zdo/IIRVrk9CFDL+Dl761EKZ4sCwWbMVDH32ZZxbSI0/j
 MO0WCkcP/9Ehaa5DLHBgI+ckZvk9FkUoR8jlmwLW6LTrcwbQMLqz7d4EqzH3Cqk7dCSisVuhUOK
 8gGWPjpt03o4jqFVLozyANQ8r82p/lpA8RXimpJp/euawAmAoO+4/vLY1k5oofs0zuMXhI9Ikb5
 /zdqhbgq6LdyNYZ4/0+bCYGOQOZWRe+vRjoPh88JZohDCbAsiRqocg8mplIYtdXhNP6OiQEZQeH
 4B+wolBvP4StaitvXOrj5jA==
X-Google-Smtp-Source: AGHT+IE5+w0Li5hCvpVvZOWCmxpfvzxRKNIqwf1jSUX+0GHPffOylwX/rDfH1MftjBxX4aYtUODkkQ==
X-Received: by 2002:a05:6808:3a16:b0:408:ee26:fa65 with SMTP id
 5614622812f47-40a71d6db3emr2374094b6e.17.1749824771043; 
 Fri, 13 Jun 2025 07:26:11 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40a741727f9sm284933b6e.32.2025.06.13.07.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 07:26:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Sukrut Bellary <sbellary@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>, Bajjuri Praneeth <praneeth@ti.com>, 
 Raghavendra Vignesh <vigneshr@ti.com>, u-boot@lists.denx.de
In-Reply-To: <20250530212232.1686613-1-sbellary@baylibre.com>
References: <20250530212232.1686613-1-sbellary@baylibre.com>
Subject: Re: [PATCH v2 0/3] ti: Add support for eCAP PWM and LCD pin mux
Message-Id: <174982477002.479222.15604735181166868988.b4-ty@konsulko.com>
Date: Fri, 13 Jun 2025 08:26:10 -0600
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

On Fri, 30 May 2025 14:22:29 -0700, Sukrut Bellary wrote:

> This patch series adds the support for
> 
> 1. In am33xx SoC[1], enhanced capture (eCAP) supports auxiliary PWM (APWM).
> This series adds the PWM driver support for the APWM feature for eCAP on
> AM33xx. AM335X_ECAP0_IN_PWM0_OUT is used to enable the backlight.
> 
> 2. Fix build warning in ti-ehrpwm driver in dev_deb().
> 
> [...]

Applied to u-boot/next, thanks!

[1/3] pwm: ti: am33xx: Enable Auxiliary PWM using eCAP
      commit: 1bf82082b9e4f079adaffc1dcee5306b082dc760
[2/3] pwm: ti: am33xx: Fix build warnings in dev_dbg()
      commit: d0bcbf782f5909b36d0af705e95c5c8ad4092bfc
[3/3] board: ti: am335x: Enable eCAP0 PWM and LCD pin muxing
      commit: 04df37a095cb08edb865b218398550341a6118c1
-- 
Tom


