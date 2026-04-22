Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB3BFA1FD6
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 16:28:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20A4784366;
	Wed, 22 Apr 2026 18:28:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UEoLcoCr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CE4C842E7; Wed, 22 Apr 2026 18:28:38 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBA358439F
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 18:28:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso48857085e9.1
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 09:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776875314; x=1777480114; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GVXoYJszoYYeDIeEdirdEdZ0DE/tVE4lV1r3uPvG3L4=;
 b=UEoLcoCr7XZhAE5MY0dJDI3s5Q6W/RdOKnCAMfn6z7l61akZ4yFHX16aX9SPrmRgCw
 8LAWE8UjFidao69FS5U+NeVzHXkF0nxZijdeVlF40CCOIEY67JDF72rWbqlVg2f/Ga6v
 Mgc4Gs4e05piajyV3v+8Tv7e+7ggD0BQRTC/KSKTvY8wFODCiQgClUaUtp+hJEu1AzKA
 pAugcp7ZJwEuCyx0+4oDwvmDyKCjE7sQTHg7ZIYi3ACKUqanDPUerVgz6ZWe6WTY4ocb
 9w1N4Tgyb0fs99nvsNStZHXQrR/AOD9PSJrpU3iqQZs3Y6PnlMpIRtMBP9sCI+ADagDD
 q2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776875314; x=1777480114;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GVXoYJszoYYeDIeEdirdEdZ0DE/tVE4lV1r3uPvG3L4=;
 b=ldHkYXJKAByET1JBJwQ8KzH+XMBVD6XsN7imcIHTSRP8HIYs06J+8uFjiKKSD0qQBJ
 /cZsyPFqbvM7wGO9Tp6Mp5XcUmSb9FZNruinPLcyAa3UTPaE8KDbJhX6yD7/tGba3CTP
 leU78EZuyCRvg4p7nawsgaCTw0+fsevbq5+kuf/QPBU+oaLLPk+3g5ODh4j9n8Ehnypw
 YjRjGcG014lA1W2BoiQKS3Q58r9NQBtZXSzLA88nusu92ce7OIRvbk9YuX6d+1NlHN7C
 SX2CFTwUj0GM4h7Vod91Qn6j101CMTJEuTPwQiYtRDPpd/YzcCQDv7ZxJWux2S0i9oFo
 eHzg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8DgGAWCal6i8+XAblyZHaW/FR8qerYVJoMCbEbGB8OamdR4gCvvb0HXz5VXv5LihNZwyMxgVY=@lists.denx.de
X-Gm-Message-State: AOJu0YxDWtXaHDVv6L5CuJGDd2EDmxu1h4uqSqpwCsxLaQKG8dblk1Hq
 Nn6GuNjfdW0+FotzoigyS1wNyNPx7w7KWQGII/3chF7NDEPOYeazRl4i7jBe5fzqf6o=
X-Gm-Gg: AeBDievOPU6+khf2ENsegpbNT/WDaZF+UOQMFVYj0WsV5aEHLGBp2bXATdY4S16Heka
 inGgMq5LIJaXmLLW+5k0OkaTONgIGbYSLxcyeKttUbyS6x1IF0kbc0NE1HC8XHLGeNSTWC3PGZy
 PyaL9qDEUn7ccbZIlkMg2dYC5xm3C3uHyKUikjgHEBQxbYQdO0X14jjvds2jTi1tD+HRj77WefD
 l60qawNGrI1pdaMl+uMyVbtj72j88oltHgOM/YVlTEQF98nzxhlpp8x3x3q1ZzLDkVr8GR2wLIq
 3dyDSP4aCmP2l7NX2WSme5yfy7uq8HThIlvU1SNn1ZTq049uJTJAcma5Qs/2xHP+netb1r4IB9i
 Nzpln1AcamNh6PIfinBka303QhI9Qj8v5YyaGUZL5+uvQ6QgESyMrW+odNoWHOj9042W0uatMRx
 az3fA4nTZPFjeEqUpq2e0nXQG8xX04GgJne8071SfrK3XA7rYI5p8k1pI=
X-Received: by 2002:a05:600c:a30b:b0:487:4eb:d125 with SMTP id
 5b1f17b1804b1-488fb74dff1mr231656565e9.9.1776875314158; 
 Wed, 22 Apr 2026 09:28:34 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb7c0eacsm144898075e9.35.2026.04.22.09.28.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 09:28:33 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Ferass El Hafidi <funderscore@postmarketos.org>
Cc: Tom Rini <trini@konsulko.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260422-b4-amlogic-sysreset-capsules-v3-0-07b5ccc8f552@postmarketos.org>
References: <20260422-b4-amlogic-sysreset-capsules-v3-0-07b5ccc8f552@postmarketos.org>
Subject: Re: [PATCH v3 0/4] Enable EFI Capsule on Disk on Libre Computer
 LePotato & LaFrite
Message-Id: <177687531359.2025915.13597925861310436957.b4-ty@b4>
Date: Wed, 22 Apr 2026 18:28:33 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
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

Hi,

On Wed, 22 Apr 2026 15:43:22 +0000, Ferass El Hafidi wrote:
> Mostly everything is already in place to enable EFI capsules and in particular
> EFI capsule on disk.
> 
> First, switch all Amlogic boards to use SYSRESET. EFI Capsule on Disk
> functionality expects sysreset to be present. As the current reset_cpu()
> function in board-common.c is basically only doing PSCI reset on U-Boot
> proper, we can replace it with sysreset's PSCI support, which works just
> fine for that purpose provided BL31 is running (SPL stays on an
> SoC-specific reset_cpu() which does for(;;);, as the overhead for
> sysreset is too high and we don't have PSCI yet at that point).
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/4] arm: mach-meson: provide reset_cpu only when SYSRESET is disabled
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/93c13379a4446ea38f85c4e393d187b8de2159ab
[2/4] arm: meson: enable SYSRESET_PSCI
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/63a0b3e9abba4df4e6d560f317be2712862c6141
[3/4] configs: libretech-ac_defconfig: enable EFI Capsule on Disk
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/94deb742654ae2f8996e9db17158834261b8c05e
[4/4] configs: libretech-cc_defconfig: enable EFI Capsule on Disk
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/e07cc9e7fdcc35780f539ee1d452ffd3da0fbd1f

-- 
Neil

