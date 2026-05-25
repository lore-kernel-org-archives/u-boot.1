Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F7ECCD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 15:24:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A62BB848C6;
	Mon, 25 May 2026 17:24:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XBNjirV3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C000848C5; Mon, 25 May 2026 17:24:10 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0447848BB
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 17:24:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-bcd0111ea98so1360568266b.1
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:24:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779722647; cv=none;
 d=google.com; s=arc-20240605;
 b=bKRjYMrJVvpH2+Z+d1RRqNsUh5yzx5oXyWu2QA1D07ZNe2oA6jJkRayLsn6hh2yIHD
 OdUubWrT3PLxbcj62GkelkGYm6wSfnCVpZW6kSjGgHZxFqQRrf5mDKkfGqqhiJRWgJSx
 m/MnTrObmTBBtTeLg2k8cOFMP1UAGI+ImI28Z42l2L+ueB8ilBKaoqENSKpbvwq5WpHs
 olbk7P/0fo7yhQ9cf0a8/7MlfpcKjvW0JvZh2TruJuaQlYLB2axWxvwcqpJol5hldnuQ
 npBFldfKzOXOfTTRQRcZjum2bA3e4YC9goH8tMF9O590qvTasxKjUfVzFaCFz1DbXvQM
 +PnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=V3MEYroseC9lTpz0kM6K91QE/4c+S1W1iDcFlBRR9jg=;
 fh=DYMU3dRED0rmVKTDqXRHxrZw93vonVJHh6vC8tHyRiY=;
 b=L3ffFrnYuo1eeVOEYdji7OAA7oOIyN4j6eLctVkyCMoDdoq/cLf+KzsFrEI0W11Kdy
 aJAEj6U+Hv4g3Hl2BcKf8hqOoAaohJGQQZ4eR6hl8+Pwqd/bfI6UGZ6P4wUP5GH+tC+K
 59JR8cY3cr/GvJPdKDnh5KsEfbIamzfERiSPNVkRNpO1SG6Qxjd3mQwduWDeD/jy4HiD
 575spdbmypKpNPcbEwXjvFCb2a+gczqwwFsDir0q7yKwyt8gLDCevrj62FUVkw2KG8ru
 HCkcOHMOj/EVWHTFHHN4+jbEEoeaBiiMQuJkes+nZTp0ijOhOftwUCNtyh/TwvafC/Rc
 LOpw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779722647; x=1780327447; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V3MEYroseC9lTpz0kM6K91QE/4c+S1W1iDcFlBRR9jg=;
 b=XBNjirV3tGmypSU7uodSafs5roUQaelP3CfRYsuJqYQzn1qlyhz13KcxuEMxH6wQMz
 P7CE80ocsdselNkSwgCnCG4BuMN4Lom3aR0QQsZ3Rbp+cKfoJDgbTbQa/LyTrL/xm7Le
 KmOi0/vHbQ8i0DYaqWVJGAiia5fbTWL2yG8tQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779722647; x=1780327447;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V3MEYroseC9lTpz0kM6K91QE/4c+S1W1iDcFlBRR9jg=;
 b=CkfSkwm7zYhizZuXnSc7Is4i5zU4R0ZVuHs/jtrMkcNFWWYT0haTZsXUsZZqs3Ea1E
 LXN/Fw49jQeXjGhZ7F3YOpYGgjOY6aQvavMJ0wrvlC5K4DwmhjyV4gZk95BINcfG7ePf
 hAldCOoECLwjsikaRZgyccH4Ddh94pzq7gVTn7o/6iDj5tweywvCTYz1BwTypilhyY5o
 8wdPegRXh8KMc8z/Iio2iDE3KkHJuasYhvX03ftV2zbrnAg7Fx/EsqKpLt3EY0WeZYpw
 aWJJ4skJ7gb4a2X9V4vg7ZHzXrw7LDAY3tXiPDYL1D7nx5qtZ+o/GKCr12ZkTYDCnqku
 g3Ag==
X-Gm-Message-State: AOJu0YzFWPIe1NIZOQ3og9wU//f4PeUFAGTqTIAahM7SJi8fF2D5bUd6
 ntnZLBM1VvcT83Qc0xtgq+TX2f7oVqMeDf1c7JJLUFZdMg/u+XZwkZAAL6Rop9btLzOEwUGhC9M
 uwTxk/ctOmWr6+OFAcbOtPHqjfInwn5+srTz8eiKP
X-Gm-Gg: Acq92OErWU2SaE1rWV/MF4DL27NeLSugboNWVaisg020dPOgxlQdf1s7qKEInnawV8a
 vTcpm5UeRAEMPmamtwdbaapzqd7CRhEB0whCsP6BojCZLvnARUvWfJbyY6o9NAEAdjQS9huUWyD
 6GCSjOkgbqonAUT03hS+joAtJmf8Jeo4zrNGGSYT0GSC15pxa69rbfzLfUfPvcd1QFJog115fZ+
 KfQTtQgRAlemwC57TLjuUaJyvjIpCgU+CI5Vw+EDoEphNkdvn0gNS37aRmyaAGDESPqzgYrlLaB
 aHn6bwIKxrzQybFT
X-Received: by 2002:a17:907:724a:b0:bd5:2ed4:4ef6 with SMTP id
 a640c23a62f3a-bdd28b79bfamr843242666b.19.1779722647182; Mon, 25 May 2026
 08:24:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260522012312.860026-1-dmukhin@ford.com>
 <20260522012312.860026-5-dmukhin@ford.com>
In-Reply-To: <20260522012312.860026-5-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 May 2026 09:23:55 -0600
X-Gm-Features: AVHnY4LquuCs_BdNgGFx-q-BAX8rYN5vXtSWx8rOS88NMcVQPeL-we-RFPTZWls
Message-ID: <CAFLszTgQtVNiYLys+O0FnBUJ-M0PM_i2MM6ubBSswQjLycuFTw@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] reset: x86: Use cpu_hlt() in
 pch_sysreset_power_off()
To: dmukhin@ford.com
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com
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

Hi Denis,

On 2026-05-22T01:23:09, None <dmukhin@ford.com> wrote:
> reset: x86: Use cpu_hlt() in pch_sysreset_power_off()
>
> Use cpu_hlt() instead of open-coded 'hlt'.
> Also, use cpu_hlt() in reset path (including EFI) too.
>
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
>
> drivers/sysreset/sysreset_x86.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

> diff --git a/drivers/sysreset/sysreset_x86.c b/drivers/sysreset/sysreset_x86.c
> @@ -10,6 +10,7 @@
>  #include <pch.h>
>  #include <sysreset.h>
>  #include <acpi/acpi_s3.h>
> +#include <asm/cpu.h>
>  #include <asm/io.h>
>  #include <asm/processor.h>
>  #include <asm/sysreset.h>

cpu_hlt() is defined in <asm/processor.h>, so do you need this new include?

> diff --git a/drivers/sysreset/sysreset_x86.c b/drivers/sysreset/sysreset_x86.c
> @@ -65,7 +66,7 @@ int pch_sysreset_power_off(struct udevice *dev)
>       outl(reg32, pm.base + pm.pm1_cnt_ofs);
>
>       for (;;)
> -             asm('hlt');
> +             cpu_hlt();
>  }

The commit message says "use cpu_hlt() in reset path (including EFI)
too", but x86_sysreset_request() is untouched - only the EFI path.
Please reword, e.g. "also replace the open-coded busy loop in
efi_reset_system()".

Regards,
Simon
