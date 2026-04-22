Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B4EF94CDC
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 08:14:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 560A683936;
	Wed, 22 Apr 2026 10:14:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PHRt8gxo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5211783C51; Wed, 22 Apr 2026 10:14:27 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 178158352B
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 10:14:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso70265135e9.3
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 01:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776845664; x=1777450464; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=58rO0BHCmcNKdyW0hYjR2hZXXpALkLzaUfe2KGPbU68=;
 b=PHRt8gxoLhSDfaC/Nx8nwBp3ITTXHwSYk/X7GRKdoPBQ2Lc2+FmD9MvZgqEFNjrD52
 iv96tEgayNBSn+O3i4KSCQqlBPwsNdfMv/KNokFthRrPPaS1PqHsF1mFE9elGIYozttY
 IHBO66F8V5iRmdfLClCpQlJ17km00bdYuWr1B8NXu5JY96pbAeEQQgapObBsBP2rL+0o
 DqNQdy8Gnb1Fnk12QuCPy0uDRYTXCP6ACdywytszv+9xR/4/27vSGwjVqGtyIt/0+6pa
 9qhg/uE8ohulvDa6pLypjasapdE+nlCViNhc+IrxTeLJBtuer/Xsv1RPFmwSgLiWqSsG
 tIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776845664; x=1777450464;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=58rO0BHCmcNKdyW0hYjR2hZXXpALkLzaUfe2KGPbU68=;
 b=hImG5/ITto2qYx3Awr2CmXViPKlHyL+imxIhyCZ04AF9lcWGP/67wCfwR4bmLIflmP
 3bYhdyuwEUrQD9dw6+jjx9XytnWmdr66ioWdgk6igRVybtPk44hKoTRwCMZV1J3QJo5j
 8n0+jHUTpIAA78EaWcVAFyrXH5c1P6bzdYU9eDGw5VvFX+gnwGkY/KH5OH/qXJxHC3H0
 AFLLbAkOvO+NB2xtvWU20GCCJwnrMhLFax/SoPNvmy9fLJ0nc0lI1xm7FQzknKY0BpNg
 minciR7Z5XtX4rEBddT82HAvbvG5j37N3n146te+ygQnLbt9w0xp3IQHVt9kpC4I7D4Y
 tqoQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8E6zvRjFSB58+xlRpJ0kGhknn2z6jIEmtjw5QrjbPnwDprBY9cxHT6OEwbGHKGirgSf3vuYJ4=@lists.denx.de
X-Gm-Message-State: AOJu0Yzptx0y4fl6X6Nv0YDGtY9H0cb/7DL581sTqlNW7F6g4U/daSDX
 /YIg+KttMkXZzt5PfyCb/b15m+yvYAsn9DodZAkirhb31Zrl7SdrKQKV5OoNN30KEz4=
X-Gm-Gg: AeBDies8nGT7m+LiyYsmLClNLAeaRTOBfIj9o0p6kJtd3NIKr65t69M8967bcpOi47V
 x7tXgHCC43XuiRMG2TP9pA6r7GjdHrzA1GKh6m67dX39y8T86yLrAHjKsuAGPO4tpVvg2V2sysi
 uB2b1Mq6+uFUuL0DTzZecZjJUShPF2DiNdTJ1AyCBkdavVSbZkY7g1YBSjj+JVdkos+r9/o/x0Q
 9T+V8osfB+Kqz8+NWm3dY3LHdFh6laqIk9ZedWKBvBYP2dP1r1zNG6YTOoztIttsdpGFdEEQ5hF
 P44/d6U7xog93BAzsuL1sIdhgk6Zydt6YOqLSuP5ltITHg0wi9Vv52AfayHPFooD9BnkV/TcmI8
 QorvlRt8MOG9mJhfwcuNWdSUewgL9WBc924nnoaKPGqmSuM58h8nSm0lmA8zzNokYy7jF62q5Os
 zFo0xoFXHu8ZvUtv9hn3BUHa+S17N6PKR/Nmxy/Ji0P0qtrnatOD/koII0LFAptSU5yg==
X-Received: by 2002:a05:600c:8183:b0:488:ab26:8fe0 with SMTP id
 5b1f17b1804b1-488fb765b1dmr250407915e9.15.1776845664319; 
 Wed, 22 Apr 2026 01:14:24 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891cc7b2efsm122016285e9.0.2026.04.22.01.14.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 01:14:23 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Ferass El Hafidi <funderscore@postmarketos.org>
Cc: Tom Rini <trini@konsulko.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260408-b4-amlogic-sysreset-capsules-v1-0-6f3386eb5124@postmarketos.org>
References: <20260408-b4-amlogic-sysreset-capsules-v1-0-6f3386eb5124@postmarketos.org>
Subject: Re: [PATCH 0/4] Enable EFI Capsule on Disk on Libre Computer
 LePotato & LaFrite
Message-Id: <177684566365.2679545.5969910941110488483.b4-ty@b4>
Date: Wed, 22 Apr 2026 10:14:23 +0200
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

On Wed, 08 Apr 2026 20:30:11 +0000, Ferass El Hafidi wrote:
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

[1/4] arm: mach-meson: move reset_cpu to spl only
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/a6f2d59191a6afb603927e821ab0077fdac970ab
[2/4] arm: meson: enable SYSRESET_PSCI
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/2cd6e8b143eec0f490c4797f2d18112c57cfc557
[3/4] configs: libretech-ac_defconfig: enable EFI Capsule on Disk
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/61a7cae07230cba2e8ac502c851ed36073081a81
[4/4] configs: libretech-cc_defconfig: enable EFI Capsule on Disk
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/b075c1d247113da582d61cc7192affb918cfae02

-- 
Neil

