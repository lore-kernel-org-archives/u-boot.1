Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15357E7717F
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 05:47:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B0F580141;
	Fri, 13 Dec 2024 06:47:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="d0NWrjwZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E01B8021D; Fri, 13 Dec 2024 02:12:03 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9479801EB
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 02:12:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7b6e8fe401eso106785085a.2
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 17:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734052320; x=1734657120; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iGy5NoQe0FvMRYd3OUwBfwpLmNyMWP7yE4sT3VkI/cE=;
 b=d0NWrjwZxyRBW1PW3h5m3AbnW5/UfSKb6wZGt+8jhT7boBtdV2hdaRfULrdVWv+l61
 TMtKJV5LjEYzt707WiDNgkSB6C7iUXUxWuaeY2CmxT1YYP8i0a9uHPfmzA6M0qLzw0T6
 IuDgpkqo+aBKJ3CBR8P42cFDJcUMgCplhTBkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734052320; x=1734657120;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iGy5NoQe0FvMRYd3OUwBfwpLmNyMWP7yE4sT3VkI/cE=;
 b=FhDJh/ki8XHTgTRvFmAlmBpU0qJ1jfmhKS/fvnnUPvy0QbnxGqP9r6edhACPf0gMb2
 Fwj7Ukc9Kha6cvHmluIiIM7owbcA0TZhc3qDUu+V6tElHsNvbKQiI0S9+LKCgS0F+dCy
 3yJV45tpC5B+Bt05sWGqMkSCAoff/+Vr2jxoeVqMPVkxeDNPp/M0tWbYP37KelXJL6zq
 kSFAECflVL3qGFPHd5EK7EJ0xU0qKdyZbKoXJqfEf+mXXrlRT1IgLk68DLCBgBwLlBkz
 Ccwx7tkz2p6IfMuVtymZyX6IqyJozliY1XJYXGowIsYVFFnf4eGAtHxd633FbKHTJxRi
 F8hw==
X-Gm-Message-State: AOJu0YxrOdmrpdPaTlo+8CF15A8cTzJaqMvZHEc1X8Orsax0lYDhRLbZ
 gE4mKgmFBQ7q+JqDM6q1b3gH0XTjMj7GTdcx4gD/8q/SZPJCqJRKJPLlUauoRL0=
X-Gm-Gg: ASbGncvos2E+5mgQbXQ8L24Ou4KfCOruoMNuWczquYR1iMnPjOXxY0LAILoxVJLZZE2
 VEX/+VyT7AMwAImnpaKvBwqNN6Fhz/eXoFAB3JKHUHI7bKYEKOqS5get/4ogSa3jYf1omvuw8xk
 GLv6PrpowaN2sjQXAnTOPetFOHAfImklGXvsVifHry3L28cIzm32ZGNAszhbbTvIQ5VblFwimsH
 ZF9JSUrFW8UWQ5t3sPsVrXuAxu69cuvSBKCJoCYynSCZeRF4QWMS3Q=
X-Google-Smtp-Source: AGHT+IF9IR9A0wH41Xoub/onAM1ZxR6WjHXud2eMW1GSme4WIIPOm3pdk12kJBMRvRBI5SiluWJvuQ==
X-Received: by 2002:a05:622a:1f0b:b0:467:6553:a85d with SMTP id
 d75a77b69052e-467a585a80dmr15363991cf.50.1734052319724; 
 Thu, 12 Dec 2024 17:11:59 -0800 (PST)
Received: from [127.0.1.1] ([187.144.29.192]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4672978dc20sm90148181cf.71.2024.12.12.17.11.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 17:11:58 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Anand Moon <linux.amoon@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Devarsh Thakkar <devarsht@ti.com>, Dragan Simic <dsimic@manjaro.org>, 
 Gary Bisson <bisson.gary@gmail.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Lukas Funke <lukas.funke@weidmueller.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Mathieu Othacehe <m.othacehe@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Maxim Moskalets <maximmosk4@gmail.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Michael Walle <mwalle@kernel.org>, Michal Simek <michal.simek@amd.com>, 
 Nam Cao <namcao@linutronix.de>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Paul-Erwan Rio <paulerwan.rio@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Raymond Mao <raymond.mao@linaro.org>, 
 Roman Stratiienko <r.stratiienko@gmail.com>, 
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Tim Harvey <tharvey@gateworks.com>
In-Reply-To: <20241207172412.1124558-1-sjg@chromium.org>
References: <20241207172412.1124558-1-sjg@chromium.org>
Subject: Re: [PATCH v3 00/19] vbe: Series part E
Message-Id: <173405231528.1635625.10928592597091154587.b4-ty@konsulko.com>
Date: Thu, 12 Dec 2024 19:11:55 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Fri, 13 Dec 2024 06:46:56 +0100
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

On Sat, 07 Dec 2024 10:23:53 -0700, Simon Glass wrote:

> This includes various patches towards implementing the VBE abrec
> bootmeth in U-Boot. It mostly focuses on SPL tweaks and adjusting what
> fatures are available in VPL.
> 
> Changes in v3:
> - Add new patch to avoid size growth in spl_mmc_find_device() debug
> - Use strlcpy() instead of strncpy()
> - Rebase to master
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


