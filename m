Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E6EC369A2
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 01:47:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9169383981;
	Thu, 10 Apr 2025 03:46:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iqeDa5oY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F27B883987; Thu, 10 Apr 2025 03:46:27 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0DEB838BA
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 03:46:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2d09d495c6cso59462fac.3
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 18:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744249584; x=1744854384; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DzC4d3AMfP21hbJtsva8cJZutYqdVRBG7dNQFQ9RoMo=;
 b=iqeDa5oY/HLAzl+y8GAEyMzwrTEJMlOUwRxuGHUFXLsqIR9eVi1YVoqRBTrpGejBHR
 7n7D5L/SHR+1O/EKGlFekLzo6bgXF+xyqWVkljkWzzpSv4wVgV5kFFoJxo48eBcKa2ya
 Hv1QQgjFP/u8dxlIn7Xga8CpTj8yJv0O9nvC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744249584; x=1744854384;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DzC4d3AMfP21hbJtsva8cJZutYqdVRBG7dNQFQ9RoMo=;
 b=IXZ1SoJk8IjtToBFka9QirlFNX6yo6fHln8fJZ56wxWPKWMOkVxfNLIPdEteLiXItT
 08UGQKsIXm21kpXyxKIQO/Bf1vsqDDzDOvMVM6Wsm+wO0qphmRVqu4qOSRXLKJ6LskEj
 WpAo8eIOqYmR8YnBUQ4lcONgHNQKOZKvzvCo2OQ95dyxwbAAeddVHgwCZK9GVQTTbA1Z
 lmVmalHLZnqOmclkGyx+4lYl7bctTBWNpCf7KZ5XZ08tCoJFCYbyO0aVOHxO/XgZTVhd
 PVGWBTRgAJepArNeHHxK3WcerZ07xTxcakLNdP2YTedq0FGaiXn67p3cJclF7ITV/rn3
 wAhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFaoCgyrmbsJZrmpweFT0AK3ZC/k4zVPlSVpWqmrT4q9i41b9IVmeV7fdCARugnyf5xEzaY7A=@lists.denx.de
X-Gm-Message-State: AOJu0YyxLP3fLnYowVdlsQ8uaWogkx3ZtMbnf31IgMb11ojqKdY2BPvn
 t4INQXPaxmk8qvWWyjS4Xg/82A7wxgrB6mihGd++qSkC5P74Oj58OMOmjcBJyPbMkuRzoqtxmI1
 v
X-Gm-Gg: ASbGnctm8fTpG+6uBjW1YbHCLgRg0sm5mwOghdzNhZMnAUYbQ8j/CIqobT+cL8H6zA4
 TXYkiB9HPiEi6/Gdvfol4asKFha4HLmf5xumt9WZdgro1OaK3ecYCy3/cxooxFgNwhT1VNiQxZy
 r2fUx7qJ8GkIMsApUZ6vZfRh4bw6XiY6KNIS3t9DA/f9XobIzUmoZNSg/TE7ib/naxfydnRSakm
 k9IA8OHFI13Yt7KBwDRPuC3zsw6GIF4bVDcRxFxaFS0ZRglT+j1cMdOPpT/lUDy4hXXCy3Vpmff
 +RlWMQrDSKJJpIhwyHWgm3a9jauuN03SP8fR+8euvqhPTFmgvDwHV2TdIoOEiw8ugC44+PMjqP7
 N
X-Google-Smtp-Source: AGHT+IGxqjFzY7tAErre92AQJGIeAaSr4x80A0VxJlZMZ/3oCivgNH/SYd8Q+cSO4mDCODUDp/i5Yg==
X-Received: by 2002:a05:6871:4e83:b0:2b8:ec17:66e9 with SMTP id
 586e51a60fabf-2d0b36273e8mr444597fac.11.1744249584435; 
 Wed, 09 Apr 2025 18:46:24 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d096cd3764sm474569fac.31.2025.04.09.18.46.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 18:46:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>
Cc: Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Anatolij Gustschin <agust@denx.de>, Kyungmin Park <kmpark@infradead.org>, 
 Heiko Schocher <hs@denx.de>, Jagan Teki <jagan@amarulasolutions.com>, 
 Vignesh R <vigneshr@ti.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
In-Reply-To: <20250327153313.2105227-1-andre.przywara@arm.com>
References: <20250327153313.2105227-1-andre.przywara@arm.com>
Subject: Re: (subset) [PATCH 00/18] Annotate switch/case fallthrough cases
Message-Id: <174424958291.1824423.1212554066156666747.b4-ty@konsulko.com>
Date: Wed, 09 Apr 2025 19:46:22 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Thu, 27 Mar 2025 15:32:55 +0000, Andre Przywara wrote:

> C's implicit fallthrough behaviour in switch/case statements can lead to
> subtle bugs. Quite some while ago many compilers introduced warnings in
> those cases, requiring intentional fallthrough's to be annotated.
> 
> So far we were not enabling that compiler option, so many ambiguities
> and some bugs in the code went unnoticed.
> 
> [...]

Applied to u-boot/master, thanks!

[01/18] spl: mmc: properly annotate fallthrough
        commit: a6a9d3273346138fadb1a173fc2f5e9d0e61215a
[02/18] zlib: annotate switch/case fallthrough cases
        commit: 3d907a5a490b79b876a3f9c325b483a116f29b7e
[03/18] gadget: f_thor: annotate switch/case fallthrough
        commit: 2938eb1e022d7e1de23d89f941bc07b0776a2549
[04/18] use proper fallthrough annotations
        commit: 26b2482f124ba831e40a44ea0cb093203fd8d747
[06/18] fastboot: annotate switch/case fallthrough case
        commit: 06b1ebfe521d2729cd97db7dfed62469081f0ec3
[07/18] net: sun8i-emac: annotate fallthrough
        commit: 5ddb7d1265633d855889831bcad0ee4b9ea4a0d3
[08/18] usb: ohci-hcd: annotate switch/case fallthrough
        commit: 921e4d480dff3206020eacd4873795d0e57d7c20
[09/18] usb: xhci: annotate switch/case fallthrough properly
        commit: 4d108c884b5bd5cef13fa1eb11a65eefd4c48d3f
[10/18] video: annotate switch/case fall-through
        commit: 2c22efbb37b00fc353ffee56bf0b54c38639e08e
[11/18] net: e1000: annotate switch/case fallthrough
        commit: 960d3d933dbda88aed6d4fcf0711dbc7448ffd83
[12/18] mtd: ubi: annotate fallthrough
        commit: 64bc0124581b49093f5c348f5debe8889a56fedd
[13/18] arm: mach-k3: am62p: annotate switch/case fallthrough
        commit: bc3e28e11b7a8b0fb1765556642409e4006a33f7
[14/18] mtd: spi-nor-tiny: annotate switch/case fallthrough
        commit: 452dfcc3b461c1bfbc2126623f42f551000a9ca3
[15/18] mtd: rawnand: nand_base: annotate switch/case fallthrough
        commit: 3f61113c276ffe52380cec159b47e6024249ee2d
[16/18] cmd: pmic: annotate switch/case fallthrough
        commit: d29a90c8ce4a2e27f502f5ac5a051f7bcfd66e11
[17/18] cmd: spl: annotate switch/case fallthrough
        commit: 9ce2986e7e57277bac3c528412c0bb4443b7003a
-- 
Tom


