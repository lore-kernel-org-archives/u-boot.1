Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D83A0CD5BD0
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 00:49:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19F988469D;
	Thu, 28 May 2026 02:49:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JUdBL6bR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 805C884886; Thu, 28 May 2026 01:49:41 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55C7A846D1
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 01:49:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7e603d0ee0aso3570034a34.2
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 16:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779925778; x=1780530578; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FdAOJd0aaPyTjbVGb52Ev8+ibU6+NooTtMOPhY5NK7Y=;
 b=JUdBL6bR88bQ/X+LjM+k5VSKdH+Iw+G9hhLo7ye1dZgm1K80zmpnmENmgaL4RGKDjG
 qk9cCL84Y+Jq/hflbKO5UyYTKyazu3mjZXAEOvfATZ1+2ULk1+8Z/zIO7+AcFuRZfwcX
 m3pehxqPskY3OpGEhAxzBCTUvjS2r5puWuyJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779925778; x=1780530578;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FdAOJd0aaPyTjbVGb52Ev8+ibU6+NooTtMOPhY5NK7Y=;
 b=sOxwzGa+d6hq2JdAZBR4EujxSOOX71nD/zeUvIyqllXfHt9Qu5eeXmFspqi1HL3xY4
 qADeHtHpIvwcNffq2UOpw9lpKVoboQ7YUHa+t6VoDYC3JINJ/B6W1LdVUPfFuO8ml42j
 hD1NuxslgLZFiPRK8rKp/mGWrmfGw9YOVAdGyV7AeZc7q/OV1zlLtmhLpSuii5rBo+sa
 MOwuIYjGxAUB70jbNCKq50+sPsnAV+B00STsq1SPOQHshKGXofFWhbi+qBkH9oKlbK/Z
 MiWLF3p/UYz6sT88areQoL6oTNf0hLdVOwWZCP1yCdTuOYGeyAEQUzX+9IlCmQrKZjHK
 YMfQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9bRCbvspedp/tMaLv/BsLNZ8Y+/0E1u5OF216tTNNXDHr+0oMO+HgJfRQWxDfMf5E7dE1wDEs=@lists.denx.de
X-Gm-Message-State: AOJu0YzA4y4wUwxP1pXedZHmsXlfcLNBrRjVWBsvD7ndAgnykiGKE0Sz
 I85qVkFE1xWEognk+VnCRLFROa6nIKAcBGQVsEbTkNL4YO1IVJmua2Pyo0gyKNk7X60=
X-Gm-Gg: Acq92OGg5868G0/L+bZLJpduZagIAqjgNc31a8QMcF+Pdr5+HJBxEFjAKxvhts7i7/3
 1RYMkX7FyRK4x+uXaexmrBNWpJcjS0dLjBPK9oRboUO/0F7UzUezkkdtmyGUYMDNzP6kpcUio2G
 6v+TS7ctlj3MdzJNJgV78vmBhraLVg6A45bXTzUqtML4RSeRBsd/13/hAhBWpS4X0lIQ8bNHGka
 /n9cQdVlxTcu/ehV4JBOAlDD67vBQr4RNu3uMTWf2NXoQ+i6+R2nY8LdY5FttSVCt5hE1dHtKY/
 N0YBUQsI5us6cbTPsJjlMdwQGfxmfKS6Y2jTNQDeTog2qfjDpNu2dQw64EhGfkBQ9RnFz7gcfkc
 wicGRJKsM67lpiihhF1YPfLhOyMWSWALrWoqdiwPypHoSzWiDSvLOD088y+M0SA1gjiUwJDGV+T
 +l97TV5VAtsTlblyj/VKR3c3kMljx3WNWSTpoeKdcG+v49CDj/53mmgbVxrUngVsRXjunwn+bql
 miFYYbJnEzLDfI0FzLfG+EdYf9oMg1cphafMvbRgeZZs1ktsx9CphoPFP+Sy/7F3w==
X-Received: by 2002:a05:6830:6418:b0:7e3:d3b8:d1fb with SMTP id
 46e09a7af769-7e5fec81568mr15990237a34.1.1779925778043; 
 Wed, 27 May 2026 16:49:38 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e60645a84dsm12526013a34.2.2026.05.27.16.49.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 16:49:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ludwig Nussel <ludwig.nussel@siemens.com>, 
 Benjamin ROBIN <dev@benjarobin.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Pieter Van Trappen <pieter.van.trappen@cern.ch>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Shiji Yang <yangshiji66@outlook.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Aristo Chen <jj251510319013@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de, 
 Daniel Golle <daniel@makrotopia.org>
In-Reply-To: <cover.1778887196.git.daniel@makrotopia.org>
References: <cover.1778887196.git.daniel@makrotopia.org>
Subject: Re: [PATCH v5 0/8] fit: dm-verity support
Message-Id: <177992577595.148372.2425706978553046143.b4-ty@konsulko.com>
Date: Wed, 27 May 2026 17:49:35 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Thu, 28 May 2026 02:49:25 +0200
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

On Sat, 16 May 2026 00:37:31 +0100, Daniel Golle wrote:

> This series adds dm-verity support to U-Boot's FIT image infrastructure.
> It is the first logical subset of the larger OpenWrt boot method series
> posted as an RFC in February 2026 [1], extracted here for independent
> review and merging.
> 
> OpenWrt's firmware model embeds a read-only squashfs or erofs root
> filesystem directly inside a uImage.FIT container as a FILESYSTEM-type
> loadable FIT image. At boot the kernel maps this sub-image directly from
> the underlying block device via the fitblk driver (/dev/fit0, /dev/fit1,
> ...), the goal is that the bootloader never even copies it to RAM.
> 
> [...]

Applied to u-boot/next, thanks!

[1/8] image: fit: add dm-verity property name constants
      commit: d3eee4d3b120f2fe30932b2f29d935cc9ac9ddb3
[2/8] boot: fit: support generating DM verity cmdline parameters
      commit: cafe3d6e90e661bd9d42b19f1e2d891da48f3fce
[3/8] include: hexdump: make hex2bin() usable from host tools
      commit: 96e180d354de563ce6dc68cbcac26d67f326940d
[4/8] tools: mkimage: add dm-verity Merkle-tree generation
      commit: 1e4829855234d8dc91c2840a79e9a64a2e8bf3a6
[5/8] doc: fit: add dm-verity boot parameter documentation
      commit: f34597790e655baf25ff3081da654f7fc725b56b
[6/8] test: boot: add runtime unit test for fit_verity_build_cmdline()
      commit: e7ee728ace3c6cc45fce3d8f14560d2be99ec07a
[7/8] test: py: add mkimage dm-verity round-trip test
      commit: e52b2c6e7fd0f99b8c3ccea92361db6896978222
[8/8] configs: sandbox: enable CONFIG_FIT_VERITY
      commit: 89d3c1fe1b0fb5db15fce96a7e6db7885ebf240e
-- 
Tom


