Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6191E77184
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 14:01:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B59E80243;
	Tue, 17 Dec 2024 15:00:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FlLU5hYM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C0DC80282; Tue, 17 Dec 2024 15:00:57 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A50580224
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 15:00:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aa6aad76beeso744983566b.2
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 06:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734444054; x=1735048854; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t2Ohf9RXSoXX+aTwKtcGpy7/gueyP0xvze6ID8/F+mY=;
 b=FlLU5hYM6saNqI/yrEe3QfEqafagjBhUNXyWcnTTA2VGBTSJFBGzAELCnNi2rcBXqm
 Wr5JXPvR1Whk4dit4R2ncc6TKwabvXmVYqPulT6ynVU2EyWYlgnexmm7uIETk4+tSFrV
 2wBZozG7N9nHAiHD8XFcuwmWdL0p5RU8aUwbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734444054; x=1735048854;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t2Ohf9RXSoXX+aTwKtcGpy7/gueyP0xvze6ID8/F+mY=;
 b=UmADlOqNZMtNBnv8fPMkDaRsicx8NBXia9An4XHTKmwyffUoNoff6hrZCZzaoae8y/
 qy/eYWDd8atcJuXrFTHbQQ6b8vOMT/3OXatIcQPeCxkkVCvm6Ez9D/CDLlK345DO1uvg
 C59o+75UUosr51Y0Yp4CZyjMZPs4ZBu5m86m+Ppr5NSTZk1nj5XIbcKvYTK30OqsBCC7
 FMulmxGRRQjBO7vP8KGBErG1gfRY+v52nbWJaMgmXisPpcnuuayXRMTP+CGKynNu054f
 TFwBsTK5eRZcPs7A23UPxm6/2I8DBL/FZj/RMjrn0mKoJBtj6jkmaJEqjXMVRDTA9+za
 popQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUciZK0V/YvXjOf0m70y45PsAnZCMim43kesYf59nPjNB4P2BfpnNIpCewIbgrudUMgYKWPwGA=@lists.denx.de
X-Gm-Message-State: AOJu0YzF3uMtKGLrMOvlOBf5fjkkRcfSgflAYHjxV2sJ8e4StACUL2dj
 WVxUj53dG556Y5szdZ0ubXxecMDxZroEbadteppWLel9z+2PLi1ESM+YdH1WQdQg1B209feQZFd
 bfkDpvgNQZPCksJXr8PwIXEIt5eONiTjLC3gM
X-Gm-Gg: ASbGnctKW1nVjsB6JRsAvYdaqey67fJ/skS9JEJNi95wgnFQ/bPBbDkN6pQ64vcIetg
 AO1fGP77SeAINeJVm9UFBYgh+K58DqQGzdwhvIU0=
X-Google-Smtp-Source: AGHT+IHU+nCAewPvSukl+MVNCxwZUvbGVW4CjF0OqqsxsIwXsGmbJNmPffw6g97rXXuZlpN2jCmnSkxeDN2pJW/WbIc=
X-Received: by 2002:a17:907:7819:b0:aa6:6c46:7ca1 with SMTP id
 a640c23a62f3a-aab778dfe77mr1649602166b.10.1734444054555; Tue, 17 Dec 2024
 06:00:54 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Dec 2024 08:00:53 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241211004503.3775922-3-sjg@chromium.org>
References: <20241211004503.3775922-3-sjg@chromium.org>
 <20241211004503.3775922-1-sjg@chromium.org>
Date: Tue, 17 Dec 2024 08:00:53 -0600
X-Google-Sender-Auth: ka9HgDe5eT4spRn9BrozN2kBNa0
Message-ID: <CAFLszTh1sRnW75Ny6nJUDCBrajr1FCB-TCzv+TNBMiFPSnRMgg@mail.gmail.com>
Subject: Re: [PATCH 2/3] efi: Support an embedded DTB for the 32-bit app
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

While this is not likely to be used these days, it seems best to keep it
in sync with the 64-bit app. Update the linker script to support a
separate devicetree.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/lib/elf_ia32_efi.lds | 5 +++++
 1 file changed, 5 insertions(+)

Applied to sjg/master, thanks!
