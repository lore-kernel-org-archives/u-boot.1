Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD70C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 15:29:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B18E88871;
	Mon, 29 Jul 2024 17:28:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SM3gqv95";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6328888853; Mon, 29 Jul 2024 17:28:47 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0A2888808
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 17:28:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e087264e297so2442404276.3
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 08:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722266924; x=1722871724; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SM9GRbRjPugUVeUIvpTsTbaJ0xBVFx6FTGuZMeIiiPo=;
 b=SM3gqv95bdsGoBihqaXUQMJwVY0MBjKcogcog7Ff3QDgLz/70LgpDDaPrnfaWH/ssy
 As81SIZbMTQtB0ZVwaYheYN16Tg7179A9THKl1x1t8sx0uDQPANTNRiTWPqyPzg4j0MT
 SMS0NoMbvDEsvtdiFBmo65rOXPDw+f6lzVupE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722266924; x=1722871724;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SM9GRbRjPugUVeUIvpTsTbaJ0xBVFx6FTGuZMeIiiPo=;
 b=oQGGenpp7JgL1HMXHwCcqSB2UrpqFTp+2xAabk6v1kdJprYpETxR4llFcYR83Kg7Ak
 sHN7zyFOxIYSbhPEBppYvde9sFQ46JLKFWyJjyRkM5xHiMA/D9/EnlO+tzZV+DyKsd3J
 VZxMlCpgxcrBj0r1bDI/6GNa0UNTO4XeI4aPr7zsaM2ZBnRPh33y3yOYMCV+NkaJ4I70
 q7ooFW4J41QjMBaE9Q6tXz1CN7nzLNXi91nIrDQpfUo6e7f7UxR7LsDHVDoIOfrgGnDh
 rKU+5aw9qn8/au6ABIHAfCAYHEinzEYSfJ1YpPJ6c4f2H8jX/KzUb5wTDhHS8EjV2VxC
 nUBQ==
X-Gm-Message-State: AOJu0Yz7LDsthyq9DEPPHRLcMMZQtzHjoS6KSJEe7v/mK2nPsJi2bK73
 05fGPBD2VeAwe43PGIACE897Vda+REA2C3IwFBHWZxvPeqQOLMLH60PMCAO7S8iLm7+vms8Zy8E
 kbxZzTy2X8YEJ+56QYYjU9sqW1NDMMMTF/MN2
X-Google-Smtp-Source: AGHT+IHWZ9jM+m6rqeNvr2YfjIZQ74RnSb6r7JRARITWzfTRGX3OfyyDm8A8qQBfgPHSC4gAux+3EYBf2Cw0ZsDBzVI=
X-Received: by 2002:a05:6902:1a4a:b0:e03:f049:8f6b with SMTP id
 3f1490d57ef6-e0b54447cddmr8114803276.5.1722266923658; Mon, 29 Jul 2024
 08:28:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
 <20240727071742.1735703-3-patrick.rudolph@9elements.com>
In-Reply-To: <20240727071742.1735703-3-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:28:32 -0600
Message-ID: <CAFLszTiCvvrp-PcVRsA3A=odKN9-zJCPuAG7O+c=gBtBg4Hxhw@mail.gmail.com>
Subject: Re: [PATCH 02/17] acpi: x86: Write FADT in common code
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, mbrugger@suse.com, pbrobinson@gmail.com, 
 trini@konsulko.com, bmeng.cn@gmail.com, 
 Maximilian Brune <maximilian.brune@9elements.com>
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

On Sat, 27 Jul 2024 at 01:20, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> From: Maximilian Brune <maximilian.brune@9elements.com>
>
> Write the FADT in common code since it's used on all architectures.
> Let the cpu code fill out the FADT body by introducing a new weak
> function acpi_fill_fadt().

This should be done using the acpi_ops struct...i.e. add a new
operation which fills allows a CPU driver to fill out the CPU info.

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

Regards,
Simon
