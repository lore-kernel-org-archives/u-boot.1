Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4D5CF3944
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:14:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2C71891E6;
	Thu, 19 Sep 2024 16:12:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TAqvZic7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE6818921E; Thu, 19 Sep 2024 16:12:09 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADEA3891DD
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:12:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-71970655611so798542b3a.0
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726755126; x=1727359926; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UtnnCn0Y9s81n+qtO2rzBAYRraJEO13QyZhtfk47L/8=;
 b=TAqvZic7OSdEMVpxI4HNvhAZwAaHPdS92EgUJ7qyvve1U/WehxA/jLJFPIzsQHWnMq
 OFbPRiqMuqGvaqh0drD7RTreo3xEdlhZEkHP4gI7nD/E+KJdizNYeG809rVr8DZOFl1U
 aQEjFo0PK0wXsUNwquu4Nc4YGE1JI1uKWzD0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726755126; x=1727359926;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UtnnCn0Y9s81n+qtO2rzBAYRraJEO13QyZhtfk47L/8=;
 b=YkDcIlXIQxGcgVZtquuKg5IokSmk2Bnbowq2MDYg0m0WLT6pgMJBroEWemho6J4vo7
 Y5eE0TTqbqginq2W6IxhfYjmMaOLE6oCJLX3pRNv20NFTi88tMDmT5eZg5VSK1s+9nXO
 tMUfythBhATbr1ectXVMr/aHztmMJc7hFRuGYzKkzLykzOV4kdjdC0uAl4Wr3ABwF33S
 cbyj0usNHZNjFOa1Ne8kQ9WJUukHtDNFyIo/VG+3S7slp2Cty2LJtE1K1jP0WB6ONIWU
 8+HJ8UZXKGPhTIkOvqExqWFP3tvHYT1gNfluDVVm4fjOV5nXnCCHr7vEEc+hrBBFZE9V
 OWCA==
X-Gm-Message-State: AOJu0YzEuvWcx1GXhy1AfRSXdjCNCDJxvJ77Lx6ZpPR61hLEjcYYxQDP
 sx6l7dxl2SA5M8i3LExiiEnIVXM2JbgqwWoV5DvpjH9qWqPhZLbqMm7y9zz2i/ka9IU/2ah3L60
 okZTcivxKix7bhfeDPHoQL52Jzt/djdwI+N8+I3nps/m7eeGnZPcz7BM=
X-Google-Smtp-Source: AGHT+IGoStBkUPa4cMi0EbIpGRCcX+qBpsWamtDxERCCwWwMTz0H/z/l3wbYy/jPsGN5xXbhZr5+SIkNuF7xBTjuMgs=
X-Received: by 2002:a05:6a00:4b16:b0:704:2563:5079 with SMTP id
 d2e1a72fcca58-71926211ddemr37413927b3a.27.1726755126090; Thu, 19 Sep 2024
 07:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
 <20240918152136.3395170-19-patrick.rudolph@9elements.com>
In-Reply-To: <20240918152136.3395170-19-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 16:11:48 +0200
Message-ID: <CAFLszThWr0zbnVB4wgNYFCK9Quxqa_MsHOcDOTixnMbn7Ly9tg@mail.gmail.com>
Subject: Re: [PATCH v4 18/35] drivers/cpu: Add generic armv8 cpu driver
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
> Add a generic driver that binds to armv8 CPU nodes. The generic driver allows
> - to enumerate CPUs present in a system, even when no other driver binds it
> - generates ACPI SSDT code for each CPU
> - Fill the ACPI MADT table (implemented in a follow up patch)
>
> The newly introduced code could also be reused on other CPU drivers that are
> compatible with armv8.
>
> TEST: Booted on QEMU sbsa and verify the driver binds to CPU nodes.
>       Confirmed with FWTS that all ACPI processor devices are present.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
> Changelog v4:
> - Export armv8_cpu_fill_ssdt to use it in other CPU drivers
>
> ---
>  drivers/cpu/Kconfig     |  6 ++++
>  drivers/cpu/Makefile    |  2 ++
>  drivers/cpu/armv8_cpu.c | 73 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cpu/armv8_cpu.h | 21 ++++++++++++
>  4 files changed, 102 insertions(+)
>  create mode 100644 drivers/cpu/armv8_cpu.c
>  create mode 100644 drivers/cpu/armv8_cpu.h

Reviewed-by: Simon Glass <sjg@chromium.org>
