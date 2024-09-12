Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 875D2EE57F6
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 00:58:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAE5C88CFD;
	Thu, 12 Sep 2024 02:58:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Wq+ApHGU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2664688A43; Thu, 12 Sep 2024 02:58:29 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C14E88CBA
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 02:58:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-456757d8871so2004091cf.0
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 17:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726102706; x=1726707506; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LJthf9BDRaXo82QghtBTBGyxj6TEIHqAg6yfcr78bKo=;
 b=Wq+ApHGUhhnaBLvIcXtNr0INrmIU3f7oy8joM+MLUzRUNUWyaQoryHq2ZWCQjx7v24
 EctIvJwK+LKoOZ6QBE8mdsfOrFRiCcaywxClIq4FuMqU20FaCN0GZiFTh4TxOowGnmmF
 qrAEWp+2N2Xcs3mYalAHF6ibG7a5LOOoHOWpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102706; x=1726707506;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LJthf9BDRaXo82QghtBTBGyxj6TEIHqAg6yfcr78bKo=;
 b=TZLOOhhkplJ/pae1tiyXoj5R7Poej9VTJyCwD3jCRK7d0YlLoV/AA9medNcECCBC0D
 DVGxe4YLGNJ381C5l0mL09n3+Bb3BN5okiazz2ceb3bu8KKzTu6Yk/PYKDMJtqmn3b8i
 zyG9zCxhTmdwJcIHTsaPbUZjLJNJanHptvgFAP1s+mWw/wpP6i5nnxTowG23rscrxN3T
 be1XZyRa4uTZS1SembpyikkCa52ReH3b4WnFKEylt+sV9c5/MmrqshiXWsYV6nLvzx4l
 tGU+7bZZa85o+SCk6piPkOmednCJVn51+KJy7co3wCjmT3KkYoADgXWibQcoyIbwwSFk
 a3kA==
X-Gm-Message-State: AOJu0YyRxvVXclsXL1LkqqfLof2X5L0w9ca0nA7MEs1DBJEZvxWAWelN
 j/5Thr2e2YXpQH6ik83X6VSuu6s63qTRLi7dhAqzG6l6VxbN2EV5lALeaT+Wrw672LshyIn8Jo/
 5ElYpkvONkMkFmF5tUfF9BGJD86I5N9IXiqPKDoXiy7EDJT8=
X-Google-Smtp-Source: AGHT+IE+lz5q1LfpRuJgyv6hEgSxqkIRmz8aN7tT99eo8CPcu3QsJeKTuIq3kDzmght1PcfjwNJZRisFTQI6bXKmdyc=
X-Received: by 2002:a05:6214:5406:b0:6c3:54fe:ebef with SMTP id
 6a1803df08f44-6c5736e3075mr20474476d6.43.1726102705786; Wed, 11 Sep 2024
 17:58:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-3-patrick.rudolph@9elements.com>
In-Reply-To: <20240911062511.494855-3-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 18:58:15 -0600
Message-ID: <CAFLszTjt64P_0J4Mi6odXNWeAsG4pbJHhzyJ++Q8aD78Xi_seA@mail.gmail.com>
Subject: Re: [PATCH v3 02/30] acpi: x86: Write FADT in common code
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, Maximilian Brune <maximilian.brune@9elements.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>
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

Hi Patrick,

On Wed, 11 Sept 2024 at 00:25, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> From: Maximilian Brune <maximilian.brune@9elements.com>
>
> Write the FADT in common code since it's used on all architectures.
> Let the cpu code fill out the FADT body by introducing a new weak
> function acpi_fill_fadt().
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Bin Meng <bmeng.cn@gmail.com>
> ---
>  arch/x86/cpu/apollolake/acpi.c    | 20 +++------------
>  arch/x86/cpu/baytrail/acpi.c      | 17 +------------
>  arch/x86/cpu/quark/acpi.c         | 19 +-------------
>  arch/x86/cpu/tangier/acpi.c       | 25 ++----------------
>  arch/x86/include/asm/acpi_table.h | 12 ---------
>  arch/x86/lib/acpi_table.c         | 23 -----------------
>  include/acpi/acpi_table.h         |  9 +++++++
>  lib/acpi/acpi_table.c             | 42 +++++++++++++++++++++++++++++++
>  8 files changed, 59 insertions(+), 108 deletions(-)

This seems the wrong way around to me. We should not need weak functions.

The ACPI_WRITER() should be in each file, then each function should
call your common function.

Regards,
Simon
