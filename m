Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD3ECDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 03:48:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6310386F04;
	Thu, 12 Oct 2023 05:45:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LeY4hOHb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00C6286E0E; Thu, 12 Oct 2023 05:44:41 +0200 (CEST)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0F2E86EB7
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 05:44:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-d9ace5370a0so64196276.0
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697082267; x=1697687067; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=P/AE27zao3k/vSbNnQJtz+3dr0+h1bZ+8tjfCz1sCNU=;
 b=LeY4hOHbtWSMaqJjZCrO2ocEVJFzGWA1FktO41tXB98UCTUKYio/PgAX+xrsukH73G
 53jCIYUi8XwJGE9aoTepClCThnzcRbSQtll7F0VB5ITW1m2aAXfgYkUL0UHko5xyFk3H
 OxVgpWxjMOOajszeZu8ZXxBrBwZ1un0RYWo0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697082267; x=1697687067;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P/AE27zao3k/vSbNnQJtz+3dr0+h1bZ+8tjfCz1sCNU=;
 b=pncv1szezx8oUEnUudrbW/0gugH3AoamfpRJcLhQpT2XqjWiO4qnK2CAnGVBIUVqK7
 iZr1eonZzwq5DAwAcsopqV4rQhPRSGNAMO163u+h5tOvt34Pt76UNnKEHtLeTbvD8hOk
 ZmFF11b9YWR+cnuxVPm1Zoi+eHkjCgdvi/DVqjaRKYCuO8u1WzCMtjmxwmY86YYCyV4Q
 bKcxhRiGP5lJd8OpBNtWNnj7HpqIHG4aYS6NCZtjeTQeGOY1miMe9Sf8d8phK99LbJkT
 dv02jwjvEWdgoHO8CqGCyrLr1cT42elH0IYpQFVQo96tBUjHq2GozUunWnaSJmqhpgQZ
 04Mg==
X-Gm-Message-State: AOJu0YzqOoacjAUteyxQVbOLGlUcOYVvx4TWG1HJ8Z4PiUcr9MU5iNxB
 /hYakspygXSJMbcko7D/kCHFohGbu8qLW4Jh7WEiqw==
X-Google-Smtp-Source: AGHT+IENvLe0lhmIdboVlayqwd0eTP6kLMEzPNb3Oe39CHllRknKlgeeJjes5/rsf2W5qwrSyUaxAeVdVqTLdXd+WSI=
X-Received: by 2002:a25:5f11:0:b0:d9a:c391:503 with SMTP id
 t17-20020a255f11000000b00d9ac3910503mr726193ybb.3.1697082267149; Wed, 11 Oct
 2023 20:44:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231011131552.14665-1-bmeng@tinylab.org>
 <20231011131552.14665-10-bmeng@tinylab.org>
In-Reply-To: <20231011131552.14665-10-bmeng@tinylab.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Oct 2023 20:41:43 -0700
Message-ID: <CAPnjgZ3svgJ4aAHs12swJy_UKByFGbUZR2WbjyPsa=GSnOWdjw@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] qemu: riscv: Enable UFS support
To: bmeng@tinylab.org
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, u-boot@lists.denx.de
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

On Wed, 11 Oct 2023 at 06:16, Bin Meng <bmeng@tinylab.org> wrote:
>
> This enables UFS support for QEMU RISC-V 'virt' machine.
>
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
>
> ---
>
> (no changes since v1)
>
>  board/emulation/qemu-riscv/Kconfig | 2 ++
>  doc/board/emulation/qemu-riscv.rst | 8 +++++++-
>  2 files changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
