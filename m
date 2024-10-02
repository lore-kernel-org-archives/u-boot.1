Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340C6CF8548
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 22:56:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1C4489028;
	Thu,  3 Oct 2024 00:55:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IA3kTCzg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC05D88FAA; Thu,  3 Oct 2024 00:55:50 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99F5B88FEC
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 00:55:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6cb284c1a37so3324326d6.1
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 15:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727909747; x=1728514547; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5Wh0SBecN+X+eJGHKcNVqFmqHtlvnzMpz2FHKnqi4wc=;
 b=IA3kTCzg4ua+hxv6OqoO+cEAJDo7km90UYjZO/eOXY8EFMWylB0XWYDFT23KOuad4o
 3jMMpi1HHmjCNaQjSo9E0y8MFEW1nZ3FCa/wq0K0R0qF/ooW4g03O5wUDEshDSqbaJaA
 0es8NM362/9X/YRfuZszJk2zwFH6RrsyOrY2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727909747; x=1728514547;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5Wh0SBecN+X+eJGHKcNVqFmqHtlvnzMpz2FHKnqi4wc=;
 b=OYua+TnZFdlA9/1bo8ViJXO8WTRbnHdNURC86j8Za4/lmNhRw0i14x+kgsy20Q5eNT
 EFSik7vTxHByGAM8vz5oB55CtV2esdTWSqukT6g6AeJK0SJ1C5TyTrOZcaBBEfc3l+td
 0FkpziwBg9tN0Qy3ojrEjy/eYKXCtI9Vj3gvXzrTfvHj8TF/mZvdYvtZ4w4DDp9LWuTH
 KPqOagLCCtg1pjKz1QbcPXx2we3vUK4K7xYAASfxfgYYTf1RdepLItV5UL+xsMaaePCA
 GR1/g1SgKQYADPQ+cKVUyFZ7MuXlMtBco6s8JzUn4vozHMLwfoLfPRlTEm0silwGZ05V
 h5hQ==
X-Gm-Message-State: AOJu0Yx4v5kKsoHACIYD10UDA97DJAzshfBzEobcsYpISb6fogfPQ/Mh
 oNIqVB11KAyyYTYh+ovTFs0ZkymR6gQ7jjZckmu/FGdboS6qnOBuoUXhR7YHGhy5eSoCFmh5McD
 4OVkhyPsDxTGYOnSL3jLZWNgz49wskczVJ9qE
X-Google-Smtp-Source: AGHT+IHBzjt7xtCfeBdpeKSzOLWzeE0AwRcELmiAPQgtxw5ymXYxxSNX4zg/t/3S2qFuKtBsZTFzJZKzyofjOOQ09rg=
X-Received: by 2002:a05:6214:498f:b0:6cb:3883:bdbb with SMTP id
 6a1803df08f44-6cb819f5e5bmr79376546d6.25.1727909747552; Wed, 02 Oct 2024
 15:55:47 -0700 (PDT)
MIME-Version: 1.0
References: <20241002094832.24933-1-patrick.rudolph@9elements.com>
 <20241002094832.24933-34-patrick.rudolph@9elements.com>
In-Reply-To: <20241002094832.24933-34-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 2 Oct 2024 16:55:37 -0600
Message-ID: <CAFLszTjPKSPyOj2ytZpKixtyverBuBFkDp7+JtmreSvbmDa=ew@mail.gmail.com>
Subject: Re: [PATCH v6 33/37] arm: mach-bcm283x: Add ARMV8_MULTIENTRY support
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, 
 Matthias Brugger <mbrugger@suse.com>, Peter Robinson <pbrobinson@gmail.com>
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

On Wed, 2 Oct 2024 at 03:57, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> When ACPI is enabled over FDT the APs cannot be brought out of reset
> by the OS using the "FDT spin-table" mechanism, as no FDT is provided
> to the OS. The APs must be released out of reset in u-boot and then
> brought up in an ACPI compliant fashion.
>
> When ARMV8_MULTIENTRY is specified, the APs are released from reset
> and will enter U-Boot after it has been relocated as well.
>
> By default ARMV8_MULTIENTRY is not selected, keeping existing behaviour.
>
> TEST: All APs enter U-Boot when run on qemu-system-aarch64 and on
>       real hardware.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Matthias Brugger <mbrugger@suse.com>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> ---
> Changelog v2:
> - Drop CPU code from board
> - Add CPU driver to release APs from reset
> Changelog v4:
> - Use the generic armv8 CPU driver
> - Probe all CPUs
> - Release secondary CPUs in the probe function
> - Use of_to_plat() to parse DT
> - Drop udelay()
> - Select the GICv2 driver
> Changelog v5:
> - Cosmetic fixes
> - Drop arch_early_init_r()
> Changelog v6:
> - Update header order
> - Drop ifdef
> ---
>  arch/arm/Kconfig              |   1 +
>  arch/arm/mach-bcm283x/Kconfig |   5 +-
>  drivers/cpu/Makefile          |   2 +-
>  drivers/cpu/bcm283x_cpu.c     | 214 ++++++++++++++++++++++++++++++++++
>  4 files changed, 220 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/cpu/bcm283x_cpu.c

Reviewed-by: Simon Glass <sjg@chromium.org>
