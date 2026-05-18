Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D16CCD4F4A
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 16:47:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 169AD84676;
	Mon, 18 May 2026 18:47:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hAizYPrB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C4C48469A; Mon, 18 May 2026 18:47:35 +0200 (CEST)
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com
 [IPv6:2001:4860:4864:20::44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09D4C84664
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 18:47:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x44.google.com with SMTP id
 586e51a60fabf-439c00ed7e0so2320695fac.0
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 09:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779122852; x=1779727652; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BJeLare1eEJTBHNkzgN7wjjN4Nieu4X3M8asMvjHRc4=;
 b=hAizYPrBP7DDaG0Nrh/NTdoKg5sQvTvqdEUmTcLtElcNsr79cgPK8cMOzIm0UHY2p4
 MZqJGwzz0XsRU/A8MY6VVObGw5nzOuvezW2cvGOFyNh/32ppCUPxQqIF/P4MiLYwTH6q
 8I70EtYP8jDldPNVkVElQOpGpNFyw+4EEyeyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779122852; x=1779727652;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BJeLare1eEJTBHNkzgN7wjjN4Nieu4X3M8asMvjHRc4=;
 b=KSd/wp/M+BWD/fAXTS+67TkUMlbSTHOg/B2Rk/Uv+4cB82rreUhnbaulZzZRnhIU65
 aq3rEEGDsdz9R4XcHJuUC3RJAQdTUkVlNZFIIGm8BIdkFr89b5wui2n51lkqNuBtLYwO
 zGZp6ZMGr3V8QpcfF80vv5jItau1+FA3C/xNsX4qYbIzJGc08HkF58UOm5OzYVNiCUPm
 k67yg756lpUGZlYvE5Zb0H3mYa30HwQyuMIFhfvCwIBlRg04WvLq7yZOEQeCdvA/ngfS
 h4fhjQ8rLWidhbHG9G+FmLBpLWGpcZJQNox+OOZxXJdLJdTctXEdc/l8uk4xsUVtf/Xd
 7PbA==
X-Gm-Message-State: AOJu0YyOlyFmYZOYugST4wf58SdbxQ12IwC6yGUIdCgSyFEtG9XivTx4
 hYD4rwiygUJbl3tNEuzNF8fexJQXuEQoltqz7lj6mL6CvI8b9NTus6+a5dxnJVEyW9Q=
X-Gm-Gg: Acq92OFR2ql8YLWANq5VjyHyZqz77D6uB5w5AFrY/QZuw3K0mpf2mOIBaneS39l/Iq0
 Hex+L4glHJHqms0jJiQcl5Rr1aqYU3b+clUDdiekIrNsOVPKZG7odQSaKBsImppYYf/j6FWCacb
 mPhlFOjz7QvRaSqJfp3U3BYa++/YOhbfvvUddPiRQOjVXaIyZJaQ5o01bhWNLPnMvv117Oqw1/3
 Xm+co91Ic4GIdDE24apbzOxWA6reP31+bOHyIxg9xwfcTNaa2uVagCgPep6RSP8hhSXeHg2u77C
 WlPX8g2xm686Eg2FqERVlhN8HOpsjHTgulXpQQHsLJWH4YMBx8nc6IFZo8AzwA1h3AEfXXkluaS
 wVb5KmKosoFY7qeTamFBUGno/23BWHdII7TC3/0eTx7dYjRpcl/VoBTl/bp/4AGe7rhqPnn+YRi
 9XTThtD1zyh3+reRrKBGhf7QGESWQUoA7eAxyQtQnR/owcccdILHiyWsodXbfpnpd7MHmxZl9Kt
 njBa0mHhhDNZDEy3NnlJ6AOcHJRxRHuZzYhJQS2lGfPxowzdib9wf1NOw8t
X-Received: by 2002:a05:6820:2012:b0:696:1432:eca2 with SMTP id
 006d021491bc7-69c9bfb5c0bmr10445390eaf.52.1779122851769; 
 Mon, 18 May 2026 09:47:31 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a957639b2sm4517106fac.14.2026.05.18.09.47.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 09:47:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
In-Reply-To: <3d17d2ab-6b7b-498c-b131-099096b9d8ad@gmx.de>
References: <3d17d2ab-6b7b-498c-b131-099096b9d8ad@gmx.de>
Subject: Re: Pull request efi-2026-07-rc3
Message-Id: <177912285103.389050.5308904469375611347.b4-ty@konsulko.com>
Date: Mon, 18 May 2026 10:47:31 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Mon, 18 May 2026 17:07:25 +0200, Heinrich Schuchardt wrote:

> The following changes since commit 215496fec59b3fa09256b4fb62f92af46e2ec7f9:
> 
>    smbios: Do not fall back on devicetree without valid mapping
> (2026-05-15 08:18:11 -0600)
> 
> are available in the Git repository at:
> 
>    https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2026-07-rc3
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


