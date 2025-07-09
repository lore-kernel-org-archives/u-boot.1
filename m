Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E828AC83F0A
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 16:36:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7014683479;
	Wed,  9 Jul 2025 18:36:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="S2VQplQO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B11218357B; Wed,  9 Jul 2025 18:36:02 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9957B8344C
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 18:36:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-4067b7d7e52so59584b6e.2
 for <u-boot@lists.denx.de>; Wed, 09 Jul 2025 09:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752078959; x=1752683759; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9PtR9GFrC9GmduXCnXrURNkKu7Fez7f4sKBTWlNUjYQ=;
 b=S2VQplQOxBuXHW7dm7/CbgK1ugyroEupWrSqm7xbDaNc+rXz9iWZSKZM6ZwDWzvp08
 23Vt965QuY1h2/hth+4HvaSCpVIR/vsYhIoFJYIA8tPngeuQ/KTbGwXV8ZHHzixdsX+/
 3pfvtTv44N4jQVpzM3rjJz897YE0BXhXsKd9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752078959; x=1752683759;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9PtR9GFrC9GmduXCnXrURNkKu7Fez7f4sKBTWlNUjYQ=;
 b=V3r7Y4ewnMwRyBZlDAR5bQI7coKWX2pATFivng3dj6p6oTsm2BSmqrdGrIHiqnwLbi
 qF6VIqtm1SI1lWGeG7JMLS668f7S6POOEuNAFulPfReohkxz8tVopWz1DuPXjldusjBU
 QZoc1oj8YWC4strXM80SV0ITOGQb9ejHjqYiO03eeqYa0cQNo8PsGptux3qcLNHYMD9q
 vWO9VJqBH8zcn6ySzu+ZKhUvSnDiqeEMn3lGd6IJB0TxJQ6MTWN/K5dNC9r8NzHI1Fa8
 AlGgheFi7OcW8VJB0VF5QIx55Ul+EBCDgu0M6WMAlDSRjEIoemZV1I/vZoEIjmiMiJi3
 o1Uw==
X-Gm-Message-State: AOJu0Yy2Rz2KcZsuC2wP4C5yI5ufZ6p7iDgaIANV4jEaFxty2Mp2DLO7
 qMkqhJEhEJVDx6uW/sw4k43Sk7bxn5UFkL3kBiZTjgAar4c5L1Vj4JoJwWhspRo7SWHqEDeiRCz
 rd60KFUA=
X-Gm-Gg: ASbGncvuof9kIgyoaySvh9iwl57QBkL1yc1yOJCFwSPlk6VCvhONMcJo7AKwigQ9dIt
 rp0tPuPXChFkKT+9xyS6GPfEBvCfDKsxXDpg7DjSMgaIL1utj8FNm9YhSMd+SlKSEurpgpyvL+9
 JGvyxVhSSwcM/SvJyqEtwfCclX4jw9DVB5cHDdPOapHdsYyskm26OSwdh3TC25Yg7ZddMiOv7MW
 JRn7WekcfjFVKkTxjlelrhg9kgAfGDGZLsEF+PtEFP7Ebzva6YlcKUYmLv6kEQPR8EaZsBfUIng
 GTnsTDFRPgi3tTFRrdbk4Ce63r6I1g2YOiuP5qkBI7gS3eObuEaq+WnJ5DK7Ej5BoeGTJ74wLQY
 cYYhQpJWklWus9ZXUKiI=
X-Google-Smtp-Source: AGHT+IEmkL7p3/FO6d3lR/7l2zldW6Ga8/FFoV5T7BWTQ2zFBzBQr6nDlsSwRVK3VIbaZWiTsVTLKA==
X-Received: by 2002:a05:6808:2215:b0:401:16e:918e with SMTP id
 5614622812f47-413abe70c1amr522236b6e.8.1752078959254; 
 Wed, 09 Jul 2025 09:35:59 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e5ab33dsm2068341eaf.28.2025.07.09.09.35.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 09:35:58 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Simon Glass <sjg@chromium.org>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 Apurva Nandan <a-nandan@ti.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>
Cc: u-boot@lists.denx.de, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>
In-Reply-To: <20250623-am62p-fdt-fixup-trip-points-v1-0-12355eb6a72f@toradex.com>
References: <20250623-am62p-fdt-fixup-trip-points-v1-0-12355eb6a72f@toradex.com>
Subject: Re: [PATCH 0/4] Improve Verdin AM62P thermal setup by generalizing
 ft_board_setup_ex()
Message-Id: <175207895776.1827628.4168115355047544206.b4-ty@konsulko.com>
Date: Wed, 09 Jul 2025 10:35:57 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Mon, 23 Jun 2025 14:39:53 -0300, João Paulo Gonçalves wrote:

> In some use cases, board-specific device tree changes must not be overwritten
> by system fixups. Although U-Boot provides ft_board_setup_ex() for this
> purpose, it is currently only used on TI Keystone. This series makes
> ft_board_setup_ex() a generic option, allowing its use by other architectures
> and boards.
> 
> Additionally, considering that Toradex Verdin-AM62P hardware lifetime
> guarantees are based on a 105°C junction temperature (while TI AM62Px supports
> up to 125°C), this series implements necessary changes within TI K3 AM62P and
> Toradex board code. These changes include exporting common fixup device Tree
> functions used in TI K3 for board-code access and also fixup for AM62P thermal
> zones to correctly reflect the number of CPU nodes according to the SoC part
> number.
> 
> [...]

Applied to u-boot/master, thanks!

[1/4] boot: Make ft_board_setup_ex() generic
      commit: 2b7c6b6f3ca34970be61c5189d263f94f0c94917
[2/4] arm: mach-k3: Export common fdt fixups for use in board code
      commit: 9e672e4260144bf43a5b38db48537ecc097d296c
[3/4] arm: mach-k3: am62p: fixup thermal cooling device by cpu number
      commit: 7f4baa866dd510fe123290526dc1c7387dd48255
[4/4] board: toradex: verdin-am62p: Add fixup for critical trip points
      commit: a03f4a632bf7c2337586394e5e7db6b368cfb37f
-- 
Tom


