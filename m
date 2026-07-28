Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B587C54F4C
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 13:00:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AC29A60B45;
	Tue, 28 Jul 2026 13:00:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7FZ4FuR_5LTs; Tue, 28 Jul 2026 13:00:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9786760B44
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785243637;
	bh=8Dalwn4OYZnHzrCq9qqtgyhZ8Q5SOQOhtRkvV437un4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EJRxIJ/PsmlxspUJMoo8TDwlYLVReHloTY4OM1Hr3i58FX6/8ZYb68/LFLr5U+drk
	 U/7rhE8oC4SdTXE1qhceJ8AtVn1ruymu/TQeLiZPTw7msq9hi6hgYJslhkaKdGHL2G
	 tH9i5+4OTjVZNVdpDzvu+6LeCsBSpk9l8PevPyT/KP12wj58EIcxmFROxB1gWGIWlq
	 Es6uuK1mCV4AABUg2lFTd8rZGEnTGnlQV6iOvqKg2l5dLaBPoayhg25ctQ7KSaOo1z
	 esRLZ1Xwr4qzfb+XTup2GKvcUwr2cxvQx8QVMRaE9duomAS7+RdWn881svAQ1SkjJl
	 BTwPPHIpYmwog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9786760B44;
	Tue, 28 Jul 2026 13:00:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1F3042E5
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:25:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 05628810CB
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:25:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QgJ7IHNVG8Nq for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 11:25:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5D32D810B0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5D32D810B0
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5D32D810B0
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:25:45 +0000 (UTC)
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2caf228a910so28449885ad.2
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 04:25:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785237944; cv=none;
 d=google.com; s=arc-20260327;
 b=JiVymrQYROI0D1mOwlSX8WeeO4yezrmr8131kYRWP9schTQbP4AtFoATLJbGR6cecV
 7IuiBGoDbc6dUNfHxz9G2VfKECEbpTGlq5AMCr+rG5Ts8dJL276m9lzc45FG+iHYgrKN
 oLFLn0OX8/Z3w1gHnXoPZlN2F19hW4gi6A22LVSpPSDP9+VX/qBbS3qOrPeIQRwD3Nug
 j9EoixyLcNvhMf09WR4idJ4e0cbQsIJcmduIrlPAKEHji37hrisA06+wakEjxN/+GfIU
 dSjSKaI/vwb84kL7afD9EWGDBV42VEvqipNSrnsF9yRgbuuP18U/+1H4O+7GHOB9SpPJ
 OVPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8Dalwn4OYZnHzrCq9qqtgyhZ8Q5SOQOhtRkvV437un4=;
 fh=9zr5Ce17Oa01gQ9NKzhCpXcASrFTGpe635MCU71jNI0=;
 b=kO9xgstkttWJv8faubz18hnP1eJ532rhvgnPKcwvwO3r/eSF0AXw1JrjM5AYtMsmUO
 BVdX+TRRtVqP/q6+52DXjZyoEx5rEymwcBuk9CtKtQ73gRGefFtIZWmKvBIhK/VuiqbI
 2X83ZmJ7SsQxSVQZBvRCQAWsMIlUBh+/nmA1Y51MGdYzlO1mOSUxixmuGLNiYt/xyuC8
 x6J2dvmEFkw+fpyoG7NKsjhZBexxlHlcP3VZtP+zN9bga8bR4bG2UxdF7f7NimiEZ02r
 SohXypmnuTNjKjbG4UCtZF1RcL1SODhSQX8R5Ua/5QT2iOfr6JGJ+RK0xElwU3sqNNpA
 UguA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785237944; x=1785842744;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8Dalwn4OYZnHzrCq9qqtgyhZ8Q5SOQOhtRkvV437un4=;
 b=hcNyYsqV8UV+vcqCFlTMWHIhBVQRJyL0x5GWtjEF5yKCn0tqIAAgmwZSy9hHnpvzwK
 rV+CZf78tuzZ2MTCziambCc19Gnw7e/c8ddEVZIyl0QJks+FUvr2l27ZJWdDoA6RoqdA
 6Znl8lPu9QISN5aTBU7cQN021MPUoT6dOEuw31mRoG+FT3QF8yz8QqaqTBJrAnjV/AAF
 t3XtdUKsvncN7ojOvFeBqq8KP9OcGQcfZTS4Mz0Djmy+1KURU67XTyyOg7m09CvDJvhy
 oFFCD4fZQ8dNQeKDrw570T4DLUrdtNhvt1vAuqQHmLahqKLiLG5OCYL7H0Csc/R0tp2t
 lpig==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq4KgFbXIyX9LzroxbxMw8SJt+ZIrsQLxhiPH72QAaqu1UeRAD9XRtiwXw/UwG5/5+Wv9XKX3I=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxAoYXlf2XdUBJ8/jKtuueTbr3ZcTT0dNOp3hdiwUsy4/W3b7Sf
 +53KellWBzyEAA9OjQuk4OUywc+1PstadNHeRr8NEL1JbFXY1xfWqJ12FUMSlI5D+xC5C01fZz5
 N5SUrl3s6etEyIGkoAwbGvzlTE80SU/CKX6YPX60K
X-Gm-Gg: AR+sD115uwrg3inj8r+PBZZyVHX07tKFHXCzYwEONZZuTt+5zpaQHzQ/2nR+Tk2FYdo
 uYuEEYN7lRxC97ODIqspay3gX/tmwNt9bT6AhXb29TOe2zoNhdH2ML2NgMbsb/1UgKQvbeACNKU
 rgRmIMIhiG1iIUaq18Ufq6Sg8xB0kKJzerHZKD+8o4fPr/cAYqx3k9BkxYzmh11h2eVGRgwDqzG
 pvwz4rBrfCmVHs12V1/XMcdWJ8RcewAXrHm93kecVYiS3iWmJ5Nb/7z+8eC
X-Received: by 2002:a17:902:e888:b0:2cc:f7c6:834e with SMTP id
 d9443c01a7336-2d015f08e1emr23883545ad.32.1785237944422; Tue, 28 Jul 2026
 04:25:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260719-submit-ce-series-v2-v5-0-3c41f66d4522@gmail.com>
 <20260719-submit-ce-series-v2-v5-14-3c41f66d4522@gmail.com>
In-Reply-To: <20260719-submit-ce-series-v2-v5-14-3c41f66d4522@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 05:25:24 -0600
X-Gm-Features: AUfX_mx2ZKrolYgLLYy0vU7JuQxjPZEfdm73JMEtworVfNkvjlb-0M9uAwEW328
Message-ID: <CAFLszTjKGTyXVXebvwK4RfM=d3XyaydtvYDYJWwN4cHP3AsgEA@mail.gmail.com>
Subject: Re: [PATCH v5 14/14] crypto: allwinner: add sun8i-ce hash driver
To: james.hilliard1@gmail.com
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>,
 u-boot@lists.denx.de, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Chen-Yu Tsai <wens@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, 
 Thierry Reding <treding@nvidia.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <u-boot@0leil.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marek.vasut@mailbox.org>, Rasmus Villemoes <ravi@prevas.dk>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Aristo Chen <aristo.chen@canonical.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Francois Berder <fberder@outlook.fr>, Peng Fan <peng.fan@nxp.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Randolph Sapp <rs@ti.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Alexey Charkov <alchark@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Anshul Dalal <anshuld@ti.com>, 
 Johan Jonker <jbx6244@gmail.com>, Francesco Valla <francesco@valla.it>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michael Walle <mwalle@kernel.org>, 
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, E Shattow <e@freeshell.de>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Raymond Mao <raymond.mao@riscstar.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, Heiko Stuebner <heiko@sntech.de>, 
 Vincent Jardin <vjardin@free.fr>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 28 Jul 2026 12:59:47 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785237944; x=1785842744;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8Dalwn4OYZnHzrCq9qqtgyhZ8Q5SOQOhtRkvV437un4=;
 b=JiGfZNPaw3Lf4YmRoF8qlcrdEZnfeU1dbqA2zlDqqC9ZfC681Anu2mEDYCZxtK0Z9x
 OYqYA0oA2/TaTtYLy9uE5t1Dm4CTVFqiDeS+iQexELs5j5A8iLWmKk5aLyoh5dYwVuVL
 6rSHQezplemxzw1oWqlumSLLtv8yF3K1j2qy4=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=JiGfZNPa
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 2026-07-20T04:13:44, James Hilliard <james.hilliard1@gmail.com> wrote:
> crypto: allwinner: add sun8i-ce hash driver
>
> The Allwinner sun8i Crypto Engine includes hardware hash methods. Add a
> UCLASS_HASH child for the sun8i-ce parent so FIT hash verification can
> use the accelerator from U-Boot proper and SPL.
>
> Support MD5, SHA1, SHA256, SHA384 and SHA512. Build the final hash padding
> in the driver. Stream directly addressable input through bounded 64 MiB
> zero-copy tasks and word-unaligned input through a fixed 128 KiB repack
> buffer. Feed each intermediate state back through hash input-IV mode,
> keeping heap use independent of input size while word-aligned cacheline
> offsets remain zero-copy.
>
> Map input, padding, optional state and a cacheline-rounded private output
> through the parent's DMA objects. Keep the descriptor output length limited
> to the algorithm state, then submit hash work on the dedicated completion
> channel through the shared task-session API. Keep one session across every
> continuation chunk while retiring each task before releasing its mappings.
> Release mappings in reverse preparation order after the session retires.
>
> H6 and H616 use bit-sized hash task lengths, so keep each submitted chunk
> within the 32-bit task descriptor field. Feed the watchdog from the shared
> CE polling path while waiting for hardware completion.
>
> In SPL, only advertise hash algorithms selected for that phase so
> SRAM-constrained builds do not accept wider algorithms unless requested.
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>
> drivers/crypto/allwinner/sun8i-ce/Kconfig         |  26 ++
>  drivers/crypto/allwinner/sun8i-ce/Makefile        |   1 +
>  drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c |   6 +
>  drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c | 343 ++++++++++++++++++++++
>  drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h      |   5 +
>  5 files changed, 381 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
