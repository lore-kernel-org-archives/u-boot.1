Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2A9C0219E
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 08:00:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FF1B806FE;
	Tue, 11 Feb 2025 09:00:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cSz7Pwv/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56718807C0; Tue, 11 Feb 2025 09:00:02 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 155FE8043C
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 09:00:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-439473da55aso10360995e9.2
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 00:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739260799; x=1739865599;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tc23cMxK3qt1Y74r2oypD56koy7lJxaZP2fLMvJwyCw=;
 b=cSz7Pwv/xUp/mFBuW0MkW455HG7ANlC5KY22k7hW/6s5VcJbQ3hS3MCx8RXVupKGTo
 TAFxPQNWqY7vUNq8gn01Y8VBOzakyajb3Nb1VgLrXvJx6K0s5QypaqtemgI0KoRrR3Yq
 aCgsNZZSbJNbzrY4XAdfEM0iMB6kb2YmTgKFHGLnNYNlO4gfubks7AAbrX/eyNY+c6qU
 t4qF+M7ObhCohn7qaQ8If2H4hMVRRHCjv3bG2isZFZo+/a27LKfz59EcmErhX6U7r17L
 ZCdUJT9MFX0FKoJaFurRrZ1bN9+l4CkdI3/X9ePyWIigF45fkCEOE4cOhsuAc1MUs+rx
 GftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739260799; x=1739865599;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tc23cMxK3qt1Y74r2oypD56koy7lJxaZP2fLMvJwyCw=;
 b=uS5WDEMOh61nHO4CroL5FLbQzyJCrQLKxNWZDYP7ULU8fDPEgx8ffj9fk74c3BEIGv
 lOtlNPLkaHE8atS+xTCJR1tGKXPbFUpTzilTumeloOXhocFHwiePu1dNOOSW5c6tqz4K
 H5sEmiqy0Ye1U0TpjfYc+9IDjyhy+7VQT90MS8f/brYN3Ek+Nvr5Qvnr6Do+TNzfhCAO
 KNnqXhwO8XOWBR0WZUyc7sO9s8n1ZDGvJyoMq6rTUQznwA+hTyFCbcfWmBKFskU+Q4YX
 zogTGEuAYAyhWr0v0jALxw4fm87Fz/EBNuYwOO9ER2mPb0YNLjeTk5il3rQlJT4kw1SC
 rbWg==
X-Gm-Message-State: AOJu0Yzr0B7eBJkOiC+vl8FXaF7m+noVGJq5WCAjtNhE77jQQLkcCHuc
 5N94TbLK3dvA0SRzWWFm/FuJAuNt3fc+JsvyOJXeb0MaGNpeYiGR76eHQ2unbQA=
X-Gm-Gg: ASbGnctAxWXmwv0qDkJvYoXWSlNrbvqYMtb2HdFa9eiZT/oeFLt4CrJcWXScOWtjkog
 1zizuyfJuZKqu5jbKWqKc+VJge2MZ8BwjhJgPl/1MrBHRnIQRebSIwPcbh3smxSTO4quTHMZfYN
 5A6xuxY89fqd3KG/O5Rt6JnMurAz0oBF4/B6T2hpRmA+HGGfS28scdYnlooqqZ4izhnWrJSr1n3
 Oke/baQiHLyTjnv3H7dLDTa1iYuFZyQjoKUCXooEStDZUl6AHQG1sethAq96E2Vc2e6l/HE8sw2
 Id9J0kCqi+lovHpEi00tcXoiSrNinGU=
X-Google-Smtp-Source: AGHT+IEVEXV5vqhSVaAynjhGisENcs+pJd0MftrnzEGt7Bn2wKLLOSPbcKBLd7TeXaFsnyjdPPUWXA==
X-Received: by 2002:a5d:5885:0:b0:38d:e3e2:27c9 with SMTP id
 ffacd0b85a97d-38de3e229damr2706886f8f.8.1739260799506; 
 Mon, 10 Feb 2025 23:59:59 -0800 (PST)
Received: from [192.168.1.20] ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd2ef7efesm9197090f8f.52.2025.02.10.23.59.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 23:59:58 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: u-boot@lists.denx.de, Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marex@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Tom Rini <trini@konsulko.com>
In-Reply-To: <20241202074644.5380-1-patrice.chotard@foss.st.com>
References: <20241202074644.5380-1-patrice.chotard@foss.st.com>
Subject: Re: [PATCH v2] usb: gadget: f_mass_storage: Add schedule() in
 sleep_thread()
Message-Id: <173926079853.169372.11937323976344115519.b4-ty@baylibre.com>
Date: Tue, 11 Feb 2025 08:59:58 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319
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

On Mon, 02 Dec 2024 08:46:44 +0100, Patrice Chotard wrote:
> In case "ums" command is used on platforms which don't implement
> g_dnl_board_usb_cable_connected() and USB cable is not connected,
> we stay inside sleep_thread() forever and watchdog is triggered.
> 
> Add schedule() call to avoid this issue.
> 
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] usb: gadget: f_mass_storage: Add schedule() in sleep_thread()
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/4b6a3e860878de5198f5561a0d8c602a9c296f0a

--
Mattijs
