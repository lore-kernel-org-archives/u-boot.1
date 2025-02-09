Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03397C02199
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 14:29:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CE7980944;
	Sun,  9 Feb 2025 15:29:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nlLjzUTj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27F04809A5; Sun,  9 Feb 2025 15:29:04 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC5DE80141
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 15:29:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2fa345713a8so3662164a91.2
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 06:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739111340; x=1739716140; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=whBokhv/ZH2wi5WhS9USWj5Opnvr8dsL0JuU8zVT8js=;
 b=nlLjzUTjm7QjNAd1DWCDnA8+UfQzOR3SjtfH2YqRz5xhgt8LuulS0qCumo1WvEJ3pD
 ahnhwtgeaApSpY41bRggbn2KwLGz/eK9EDtkti5MAnAML17izbGBT7Tay4ZxrrtG8lUb
 i8NAyf2teBabuJETjiWlGRJ3EBaWzYMgFbGCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739111340; x=1739716140;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=whBokhv/ZH2wi5WhS9USWj5Opnvr8dsL0JuU8zVT8js=;
 b=pSrOS8Z8JE6UMp4NQotXxc7edxO6rFRl4YvL7D+XBlkEMvc+ycdp+3/p0NGfyULg9F
 zEh99O4BQVa6uQhsC6d3ITrYFpaftTxo1vRj2yNrBIF/BgbI+m31S3jV6+wohrNy0vXK
 JdfmkaXGxFYAZQzvT8mF9LD7okIKT5Gc0IyVd7cBQIRYHOaoslGULM6CRRd6bYpY5a9h
 H7zpKC4BCR74SZtBc6iXwRZOJEgK/0tUSRikMZFE1VpXs8YhuNxIpvxid7G2Y/NI9EDU
 2SWQkCAyQ6UDYyDdqgTr+zWxdGfgC5ZFrt11jV7m2mqovFw6N7oKIiaZYTvyg2TAIQJ3
 /nxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCURv1ClKeu1tdDbEmuw+zRdfugjwr0FUTpWXorojQZ1jtopYu5+h5UU+f+v9KYuJra1PHsaL1E=@lists.denx.de
X-Gm-Message-State: AOJu0YxoZ5tfg0G/Q6oLzNDTKfU3+3H+EaziKURD1p5JUpirQGfHAmH9
 HO0t0kOCsngVnqFT3//QQUL421DPKrOJmBv016P7geUraxziknWDci2upnAowrtWL+Fgz2OX6ve
 5+JtEeRufQ1VtI5FCN6JPQgUsD7xoTRcE3enQ
X-Gm-Gg: ASbGncuC0M2Z8ZzIq6vMUJNmFEoPElSUNMt+HO+agka+5zMJc/xSaZvUFVLyabo+nY3
 Ydu3pZCNby8pTwH81r1Vq/S77FpwbUe5bLxUeCxH21rJgmf+6j2gbIlNArG7RDXGAKQTi1qE4cA
 ==
X-Google-Smtp-Source: AGHT+IFT2srcmOS++w513oM3XKREGFLKBwuvKCaLY+fZC0BIPqdClW4DXvGTaxoa2HTn39ByvoSj4d41LkFxoK7V60A=
X-Received: by 2002:a17:90b:3f4d:b0:2f2:8bdd:cd8b with SMTP id
 98e67ed59e1d1-2fa243eef5cmr15272084a91.29.1739111340414; Sun, 09 Feb 2025
 06:29:00 -0800 (PST)
MIME-Version: 1.0
References: <20250208224945.2641933-1-jonas@kwiboo.se>
In-Reply-To: <20250208224945.2641933-1-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 9 Feb 2025 07:28:38 -0700
X-Gm-Features: AWEUYZkQvZuwB6EhQeNj0M51caWofntaLhTu0qeMru1LBs65-E4LB3DWaMHT4aM
Message-ID: <CAFLszTj=NNZ=-uJojzPZ7WZbUe2HVp+OB8M2o2MFbKTHd1fbDw@mail.gmail.com>
Subject: Re: [PATCH 0/3] rockchip: rk3399-gru: Fix missing TPL and SPL banner
 on debug UART
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi Jonas,

On Sat, 8 Feb 2025 at 15:49, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> The PP1500 and PP3000 power rails must be on very early for the U-Boot
> TPL and SPL banner to be shown on debug UART for bob and kevin.
>
> This series restore the early power on of these power rails in
> board_debug_uart_init() for both TPL and SPL to restore the missing
> U-Boot TPL/SPL banner.
>
> The reverted patches was introduced in v2024.04-rc1.
>
> Jonas Karlman (3):
>   Revert "rockchip: rk3399: Drop unneeded bob and kevin board specific
>     code"
>   rockchip: rk3399-gru: Enable TPL_GPIO for bob and kevin
>   Revert "rockchip: rk3399: Fix TPL build of bob and kevin"
>
>  arch/arm/mach-rockchip/rk3399/rk3399.c | 23 ++++++++++++++++++++++-
>  configs/chromebook_bob_defconfig       |  1 +
>  configs/chromebook_kevin_defconfig     |  1 +
>  3 files changed, 24 insertions(+), 1 deletion(-)
>
> --
> 2.48.1
>

Thanks for figuring this out! I'll let Tom run this through the labs.

Regards,
SImon
