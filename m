Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698AECF3944
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:14:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2DD189229;
	Thu, 19 Sep 2024 16:12:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UVBtzQST";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E9E0891F7; Thu, 19 Sep 2024 16:12:20 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BBCA89229
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:12:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7191df6b5f5so641363b3a.0
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726755136; x=1727359936; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xFIZiu1sb50Hbu3DGjuHeiukNHEC0OWMePQLB5+Qbuk=;
 b=UVBtzQSTd+7Q3tHN/Bs5eVe6Yj17m9pwv9CWh5bst1VSlrbbbk6wLfGo0LsCQqYJJS
 t2POEh2G5KE+EJSRhF0CUMLZRofH8C43kUJXAeiPXIiQOB56NGs2KErOT3QsePrziIQa
 Npa4DlIiGhDhHdG5/4KzHqJCYnunD2lfszXWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726755136; x=1727359936;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xFIZiu1sb50Hbu3DGjuHeiukNHEC0OWMePQLB5+Qbuk=;
 b=mrqNLtPO3wFqYw06O5i9FtHPvuGAv0mrsdY4RkYKq3j8RKpQKhHZK9WtBEgH50Wvlw
 tv/9fbqY91TL3PiJ1ch07gWr3i4L0ODmyH/ucsCepNrlRFs9vp61UXilKgc3dcU4RIB4
 KGr+Dgv/VbPbULY2RDme+xyCQBP2so9wxT51Plugqe2WvOyZcug9SHFEqNHoek6+jGTP
 ypk8h6m+arUHCLqZsN9Zdur6qVG16bfh6Md3b+RtkZQjwK/d+9pp0EZEXjmSFwFy4IT0
 UVVDMEDOr9ILNpBop5oDSoeAyJQbRZbaoDhvVuGQoI39OsE7MquBo4MRz8LQ9bePK07a
 hbmA==
X-Gm-Message-State: AOJu0Yzej9vULABgcPbyl8/AHc438UmnpB4rn+wYUQq7OF6/oeUAYaIj
 S8JURYn7ZmQtD3PWOP4cM/1oeGv1U+z8goPp04mvhM2oxFKS9+IdSKoDs3IZp1L9suNrAJGc1lE
 rcBeLf0sTQA6CdiZT3JWcaODXqjlvAKJog2Ip
X-Google-Smtp-Source: AGHT+IHi3h8nkgewOmL9EThNc6Ua+K8uhF3/NmaTMOdnTIdVNreIwUrwPJkjJA9lZ3rTWfyL8KVEOM3TVLVBg+lsIxI=
X-Received: by 2002:a05:6a00:1ac9:b0:714:2dc9:fbaf with SMTP id
 d2e1a72fcca58-719261e73c0mr35498586b3a.18.1726755136577; Thu, 19 Sep 2024
 07:12:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
 <20240918152136.3395170-24-patrick.rudolph@9elements.com>
In-Reply-To: <20240918152136.3395170-24-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 16:11:49 +0200
Message-ID: <CAFLszTiPO5zb6F7j2YiJgRj0BiKwoqmNik1irTXaBy5KHzZz+Q@mail.gmail.com>
Subject: Re: [PATCH v4 23/35] drivers/arm: Implement acpi_fill_madt
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, 
 Tom Rini <trini@konsulko.com>
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

On Wed, 18 Sept 2024 at 17:22, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Fill the MADT table in the GICV3 driver and armv8 CPU driver to
> drop SoC specific code. While the GIC only needs devicetree
> data, the CPU driver needs additional information stored in
> the cpu_plat struct.
>
> While on it update the only board making use of the existing
> drivers and writing ACPI MADT in mainboard code.
>
> TEST: Booted on QEMU sbsa-ref using GICV3 driver model generated MADT.
>       Booted on QEMU raspb4 using GICV2 driver model generated MADT.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
> Changelog v4:
> - Read everything from the DT
> - Export armv8_cpu_fill_madt() to use it in other CPU drivers
> - Depend on IRQ
>
> ---
>  arch/arm/lib/gic-v3-its.c | 89 ++++++++++++++++++++++++++++++++++++++-
>  drivers/cpu/Kconfig       |  1 +
>  drivers/cpu/armv8_cpu.c   | 80 ++++++++++++++++++++++++++++++++++-
>  drivers/cpu/armv8_cpu.h   | 10 +++++
>  4 files changed, 178 insertions(+), 2 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

I'm still not sure why you are using u64 instead of ulong?
