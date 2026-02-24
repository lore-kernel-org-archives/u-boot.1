Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E238FF4BB7F
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 20:02:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D051F83642;
	Tue, 24 Feb 2026 21:02:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KBTcuyOp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C115D83E63; Tue, 24 Feb 2026 21:02:23 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1C1C82BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 21:02:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-45f194e9a98so2163189b6e.3
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 12:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771963340; x=1772568140; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ptvco/WTZBXlZxoKYNBABahkRWaOUa7fQq8l3tpATZQ=;
 b=KBTcuyOpzgYqvMEoLEYjLN7JP0EFRg9XgmA5pR4UrwZJysj3KhEF/zs24s+xgofXnW
 oi7KO7SpVfwI6GP1XkCmbifFP6dMMhgp+3uPT0syA+GYcGLeWheky4wMulrATB6S2SlA
 vnKo9+nCwau2p5jEyF5Cx1tzkJkel5OC+YlPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771963340; x=1772568140;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ptvco/WTZBXlZxoKYNBABahkRWaOUa7fQq8l3tpATZQ=;
 b=jXLCyj2N9bKzWLOLAU2Gi2DgYq0W7dgMNP0wxDrRTz5sdHOieRggaJ2uRz1rJG4vjS
 e4HwDkckwul5sRXok/3FBmWDPlDkMVXS7DCLOwU0Un9x/d34zHExlorGrYDB+Xz3Ejpi
 Jie6ZQxulpNBqI9RoxBhYydgOqK7wksMHXiwXYYI87YC6I37mvelRNQDHmWMzeYLmI3f
 NqBtupRhNLmkJ3q2Cd25pkgicel5Hjix6/gYrSPLYTXpRqQtXhdo+tg+jmZehDscPwTp
 FlwIMXtdlfKS9zFWi97YizAKfLi4jenrxe7Re9i6SldatpXVbqKjFHZUNgRP/AaP9Pmf
 Vykg==
X-Gm-Message-State: AOJu0YzhkakAsx2k/1xEndtiAkJrMhoIr/flqjQl70rhLaP+acQayOpC
 pXabfLgepRfBrvEwYy1SzEAK4EbVhWvU5eib36Gv2hT2EUVtzJsbzyV0DF5Wid0TkqE=
X-Gm-Gg: AZuq6aIoPjsEcaZexsd1KZss6JRJuZB6COuWFlLd1zBSg+mUiWAbXkpkQCSiW9yf8UC
 Zrz+LZVrPFYN5C7KwdWrb7o+nHprI9EQUUF/Fq10cFRVTJxY0znjx4SK6MfroOnWNLPG6/ylvIv
 +cFKTHrqRcu9PDEbvkhqdyRmUonzLbA75fTvuqpThZaCAI2HLiyrnV7OgO+xu8ozzU1GCIwDID0
 ypZHWhSMrKHe1DfUouSEUk6o+R9Z3ay3WMLLhHNKUCwFthcR/rIjJUsCdO+zT4k3i+dUblY+p+x
 Wx0uZOYElQzUex3l47CRYgHCQp3Ax6N8VZMhiIDRdlnrymmMQgMwSpwv+v55TNzxNvgXQZdHNbU
 hjb6kEpauLNGCQ7TF5VqDvHSp5bOSX1cI88O1zdOAQScLFyKfxrs2Bu4xU2bRyq5jKTLo7xw8sH
 hGUQ6bO4KeRTOdZKxyZ2xu9k05Kw3z/MTD3UjRndEA8CmP1Nroc+eN7Rg++NYPCNdgGSenJq2Oj
 XBe4VUW08VbgTaivafRzA5H4x561w3kzIq1GYKpTp0x4uTrlQ==
X-Received: by 2002:a05:6808:3989:b0:44f:eb07:5042 with SMTP id
 5614622812f47-4644636ef41mr6267257b6e.44.1771963340197; 
 Tue, 24 Feb 2026 12:02:20 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4644a012dc7sm7621369b6e.6.2026.02.24.12.02.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 12:02:19 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, James Hilliard <james.hilliard1@gmail.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Frank Wunderlich <frank-w@public-files.de>
In-Reply-To: <20260223204005.2705968-1-james.hilliard1@gmail.com>
References: <20260223204005.2705968-1-james.hilliard1@gmail.com>
Subject: Re: [PATCH 1/1] boot: fit: validate FDT/DTO payload before
 fdt_open_into()
Message-Id: <177196333924.158215.12744627973308129315.b4-ty@konsulko.com>
Date: Tue, 24 Feb 2026 14:02:19 -0600
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

On Mon, 23 Feb 2026 13:40:04 -0700, James Hilliard wrote:

> boot_get_fdt_fit_into_buffer() calls fdt_open_into() for both the
> base FDT and overlay DTO blobs loaded from a FIT image.
> 
> Those blobs come from FIT payload data. In the overlay path,
> fit_image_load() is called with FIT_LOAD_IGNORED, so the IH_TYPE_FLATDT
> header check in fit_image_load() is skipped. This leaves fdt_open_into()
> to consume header-derived offsets/sizes from unvalidated input.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] boot: fit: validate FDT/DTO payload before fdt_open_into()
      commit: 0b2939464feef001e4d4b69578f29a7a4d572fcd
-- 
Tom


