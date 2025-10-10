Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D884CCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 11:15:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE0F58419D;
	Fri, 10 Oct 2025 13:14:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="POWncwgN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 266FD83FC1; Fri, 10 Oct 2025 13:14:55 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5551783FE6
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 13:14:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b3c2db014easo376233066b.0
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 04:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760094893; x=1760699693; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EruilifVWk7v6K7uo/dkBWd1jIPoqHjEri5V8ACJCrA=;
 b=POWncwgNAPWcLZaD+xQM8dV/0R7H1tCPaH6KCj1vzEt2ZTaIhUDjOI4rzxS1VZmpzv
 kKyITe2hayGdE5RgYuauBAqUW2g9NHbjraOb3+HgS1Ejgo6/ohGqu7+zWzu7MdP9zQAk
 Nh45ti7BICOydfzo3MnP4uHf7FFnZuKjPdCTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760094893; x=1760699693;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EruilifVWk7v6K7uo/dkBWd1jIPoqHjEri5V8ACJCrA=;
 b=sInu0f62GVmXIYN0QddVX9HsTmzyOLNOI5ynI+NxfLUJ8XsSMiSsdm9G34dCDHmoNi
 awck98gLWGoyonjpOkns8pHJaZ0grbuzXRymKQA0VM4TETAIW+QWEZI0813p0BH5O++N
 /M/3aQUifksKUs9TLXtCfCJQ4JCTAK8/Ov9WN9EWd4NgdlwpiggniqR9HoiGlT6TaG2x
 F6IYURyqE4rZcvcrP0whMoCaZDOJV5u+RRB97fZKlp/xGUtHw32e0kED+vpQ/+zxrtIf
 UTzYQhAObjbgrps4rmazrT4ww68DfGiuwwv7/PUMKPpt+bXun/5Jk5OHs6CxeyTlHFFD
 7urQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXm9+AQFMtYnJjNsW79fD+ZsrefZVL9vKSvpfxfYDNE2ty1qKbdrDbYC3TZ4yN3pUvhdtlPc4E=@lists.denx.de
X-Gm-Message-State: AOJu0Yy0dVoWt+VfCAHfUmoli6ZAIo+uwtaqwFn5PBVd1x0dAKczN59E
 tCtujxEtxdPrG+oImlxZTjEQoE2YqPxyHu9nd8TCNA+w7ccabcWQvVjXQph0Wa7SoZwchHuEkRO
 jIuch2tMUl5zP1K2z7Gyk4NxhVbu+QU8wpm+rF87h
X-Gm-Gg: ASbGncshAeEebr/hTjYokTvSvqbj2Kn19geIyInG3nMKzEwy/uPPWca6W+LhhlFZvEC
 1ZY8arCk4yUAdDylyZAyF4mE4Eda9ZkMu0pMKG5nr5WUhFgnCD52Gj5H6g/AA+GCuIJmwoWuDDv
 ahjqZC9b2V/C1zbHp8sLCvNAC5qRn2ggdw7kwyYf3cGnllShxLXeFPB6PZrqWBkZLOpXXS3IMjx
 BRiHNIpDjf2UO1IsWrI5A==
X-Google-Smtp-Source: AGHT+IEJmK29DeOUIYpTZ7UVauKVVZknkiobHtWHpiFIaCDEc49A2TF/5+xah+OyvGCoG6iQmA0aHte7hTQ24ZElG3A=
X-Received: by 2002:a17:907:961b:b0:b3a:ecc1:7769 with SMTP id
 a640c23a62f3a-b50ac0cb195mr1150829266b.52.1760094892793; Fri, 10 Oct 2025
 04:14:52 -0700 (PDT)
MIME-Version: 1.0
References: <20251009-feature_sysboot_extension_board-v2-0-e09b39e54de5@bootlin.com>
 <20251009-feature_sysboot_extension_board-v2-18-e09b39e54de5@bootlin.com>
In-Reply-To: <20251009-feature_sysboot_extension_board-v2-18-e09b39e54de5@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 10 Oct 2025 12:13:36 +0100
X-Gm-Features: AS18NWCm-m348UvnL2spQhPYhrhlWmN3WxpMHc-Uq7ZJmru9atU_YMJaIzcKf6s
Message-ID: <CAFLszTh1hnxNUYDDkSjWj+nca8xtE8ZPFLnQCzHUyQkLtsJ91g@mail.gmail.com>
Subject: Re: [PATCH v2 18/18] boot: bootmeth_efi: Add extension board
 devicetree overlay support
To: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Hans de Goede <hdegoede@redhat.com>, 
 Mario Six <mario.six@gdsys.cc>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
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

On Thu, 9 Oct 2025 at 15:51, Kory Maincent (TI.com)
<kory.maincent@bootlin.com> wrote:
>
> Add support for scanning and applying extension board devicetree
> overlays during EFI boot. After loading the main board devicetree,
> the system now scans for available extension boards and applies their
> overlays automatically.
>
> Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
> ---
>
> Not yet tested, need to find a board with extension boards and supporting
> EFI boot. Roger Quadros could you test it on your side?
> ---
>  boot/bootmeth_efi.c | 67 ++++++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 56 insertions(+), 11 deletions(-)

Very nice!

Reviewed-by: Simon Glass <sjg@chromium.org>
