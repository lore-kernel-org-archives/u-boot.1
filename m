Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 267A1C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 18:58:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB9BC88365;
	Tue, 18 Jun 2024 20:58:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QlSlOuRY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54C5A8834B; Tue, 18 Jun 2024 20:57:58 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D1528824C
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 20:57:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3d21f7cc6c0so2919937b6e.0
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 11:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718737075; x=1719341875; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nK8m6zQ/oVk9xVb689UQqTVzngrV2xhpMM0p+EAgpT4=;
 b=QlSlOuRYjkxXcsLNz9INyjt+Dv1NW1fy1ccTr2d84RbXHc2eVJaB7xLBqqsUrfVhna
 UKc4Icy83BgJC6R0nb/+/QNTaOhrP1wOhV9wUPbul8mRvIfugAaO9pKAXTEk5GFOPqT3
 J+qCqu59YobP+HCttsXrBeG5pULAI/mTyUWjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718737075; x=1719341875;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nK8m6zQ/oVk9xVb689UQqTVzngrV2xhpMM0p+EAgpT4=;
 b=rdUa+k37cVJWXzyZYIYMsWqFYFDhg4+GHRBpNu1o0qHSvFL+0RZUOiHXqJdnLWG6+H
 MU5xq35RiG0jK5OU+u+c8kUlKfL2+2TfpWupR2o5CiIUWwgOZok/biQFmuHagN470g89
 II3DoIBGYnE/fyDrrm3kKcSFVCVIE6vHLNvr9pj2z5pn6v0aJOVqvDbPu8P90Wo0V+wJ
 hiPMJD/byPPgd0DgsP+wV72oETD2wRmAuMis5u67fk3b0gUvsS4JvFJwX8csCttUXClb
 strhPtR5FcUncEgdFMxfvEYDPBjEzsuXaA0R/X6I+MbQRR7bZ3jI3UHfc0tA8yRTjLhJ
 h4Nw==
X-Gm-Message-State: AOJu0YyzFJt++ONO1mwaN+cKhAMWNxDkqH7OzQ8zOZu46hcq+Y1mtK8/
 WLUglKo6O6a1KzjLO+wppiOP27YglQePuTSBnYQECyustaAc06weuifiSThoVuY=
X-Google-Smtp-Source: AGHT+IF8TmR3hCkDfAv0biL6HCuVsLBbH70VlUQnSrVfhwVfFh6qJCmltamw8gejl52RInici94aTw==
X-Received: by 2002:a05:6808:3a07:b0:3d1:fda9:3b05 with SMTP id
 5614622812f47-3d51b98f85dmr812779b6e.12.1718737075080; 
 Tue, 18 Jun 2024 11:57:55 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d2476e31cbsm1875120b6e.50.2024.06.18.11.57.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 11:57:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Kamlesh Gurudasani <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Judith Mendez <jm@ti.com>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, 
 Devarsh Thakkar <devarsht@ti.com>, Simon Glass <sjg@chromium.org>, 
 Nikhil M Jain <n-jain1@ti.com>, Neha Malcom Francis <n-francis@ti.com>, 
 Andrew Davis <afd@ti.com>, Maxime Ripard <mripard@kernel.org>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jonathan Humphreys <j-humphreys@ti.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240614163551.2610212-1-j-humphreys@ti.com>
References: <20240614163551.2610212-1-j-humphreys@ti.com>
Subject: Re: [PATCH v7 00/24] EFI: ti: Enable EFI capsule updates
Message-Id: <171873707330.3326390.9118605115146236700.b4-ty@konsulko.com>
Date: Tue, 18 Jun 2024 12:57:53 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Fri, 14 Jun 2024 11:35:27 -0500, Jonathan Humphreys wrote:

> Enable on disk capsule updates, which includes defining the firmware
> components (tiboot3, spl, u-boot) and enabling processing of raw capsule
> updates.
> 
> This is enabled for several TI SoC based platforms: AM64, AM62, AM62p,
> AM69, BeaglePlay, J7, and BeagleboneAI. The configs to enable this are in a
> single base config file. This will make it more scalable to add additional
> EFI capsule features (like authentication) across all TI boards that have
> capsules enabled.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


