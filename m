Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C15ACD6E49
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 22:47:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A8F28485F;
	Sat, 30 May 2026 00:47:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hw1rcvcd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06B91846E2; Sat, 30 May 2026 00:46:59 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF38C84837
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 00:46:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-69df5352d0eso1669785eaf.3
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 15:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780094815; x=1780699615; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ry2oD1R+qFe+PDtGDGc58aNKvsW4+QlEuijra+2dxhc=;
 b=hw1rcvcdlEB3VYDa0iBAGDD8ewBJNJrrTUP8WTbvppreRkGV+Y9Dr7To8HCQG3iDQ9
 KcPz8hpeKsSXgkcLhNi2SuO0Xm14mox308Afu+/9krxUDrQUtqITBhPvhwssYcDpuTx2
 RR3ju/3WarmdfBzZU9+z0eP8wPKINI4y0VT9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780094815; x=1780699615;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ry2oD1R+qFe+PDtGDGc58aNKvsW4+QlEuijra+2dxhc=;
 b=bt86b+FN9WJao6R4idwMk35vm6FbP264FdrCDZOcy4HrZqM6bKPNRK+HgYVuYhaS5j
 2ZIvD/hWnmX//Q2I+E4sY6UrwRrxr3HBV6Pd80v/e4Ppy4tKrit0I/nC5UiVA8U1uC3o
 HoVbMjbbNVu2kWirjRzXGKWnoQDqe6hCssRBaKEOYvpoWHQWaeZiKQ69BXPYXJBGz9TT
 kNI8NtKqKzFFGCnQ/92gldwEDFhVwGSAkochkh0HmfE3+IdaT2nE4qJDhMjE+WzMKALd
 21GgGMy18RZRvvZ8pvbkho3Tbl3Di16r1QIFoiN+0aDyd/bVQtqxxmPCPpcCRYE2NNIX
 wOog==
X-Gm-Message-State: AOJu0YxSVSur3zTHFh7axe2WU1IGbvunfeqW00VhWMLZzRUie/khAxx5
 BNci9Fx8ZoTln5q/INKOv+0HffBvdjIXCYbTmYl0DrizE+urg3bXLwp9F2g7rmFDgCM=
X-Gm-Gg: Acq92OG26CcZK7dHbDjNhei4d2V0tMwyFgqRrdTpu55Mzazz7yJdZXBdoQ3/qrp0mRP
 NMKYrlO7D2zYmQx0klK/dMTr4qARMs4/3ZKN2hLa5czhDQjT0yE95vhS6AqjuqqX6ZbV5/5t4b0
 s7Jzu34ZFDWSIwWyu9Q2f4h1gCgvd82YKhNT009ew7DBjz9f63fnMdDdGSR34LOFvm7oTQV7GzZ
 7A4wXhxv4062Thzk1jUYuWb+Pjrl5rH8840cItYquu9sMSParRyVU+t+c0+uDoiHMMIoeEcvhCG
 Kdn+/fE/DsDQO5HiLflanGehuyOyS0HBREDTWZYQKVUMQiO9RX6yPlw2HhHYkvX4ER9eR/ufDIv
 XwJGifNbhQDxikf5nuDbd8Y1lN6wIBy4AIxayIiMre+bptLyhHoaO+aGzMWOmC3X84/Y7nr79kl
 FgQbIYkYwInRSAvD5BXsfxLkd2QZ5o36/8nhEPdnN7KQhR10lR50nZqVOexBkQUfxiPGBBGm2rI
 97ZOyB3kjoQwOMWjPBiH87A+Pkwwp+TSXaScGffbsnt+GE10TMu8GE=
X-Received: by 2002:a05:6820:8186:b0:69d:9190:a818 with SMTP id
 006d021491bc7-69e103c1882mr686856eaf.32.1780094815621; 
 Fri, 29 May 2026 15:46:55 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69e0696923bsm2112441eaf.11.2026.05.29.15.46.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 15:46:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Sparsh Kumar <sparsh-kumar@ti.com>, 
 Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Vitor Soares <vitor.soares@toradex.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Franz Schnyder <franz.schnyder@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, Bryan Brattlof <bb@ti.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
In-Reply-To: <20260508-v1-update-rm-cfg-v1-0-ec9d033f8ec1@toradex.com>
References: <20260508-v1-update-rm-cfg-v1-0-ec9d033f8ec1@toradex.com>
Subject: Re: [PATCH 0/4] board: toradex: k3: Sync rm-cfg with TIFS
 v12.00.00 firmware
Message-Id: <178009481463.728062.13960676537124304840.b4-ty@konsulko.com>
Date: Fri, 29 May 2026 16:46:54 -0600
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

On Fri, 08 May 2026 10:52:08 +0200, Ernest Van Hoecke wrote:

> This series updates the Resource Management configuration for Toradex
> K3-based boards and makes sure the TIFS-specific RM configuration is
> used where applicable.
> 
> For Verdin AM62P, the tifs-rm-cfg.yaml file is refreshed with
> k3-resource-partition V12.00.00 so that it stays in sync with the
> existing rm-cfg.yaml update for the v11.02.09 and v12.00.00 TIFS
> firmware resource reservation.
> 
> [...]

Applied to u-boot/next, thanks!

[1/4] board: toradex: verdin-am62p: update tifs-rm-cfg
      commit: 7920dc90dd525af3ba3efe328ce5be989b1c2ec1
[2/4] board: toradex: verdin-am62: add missing tifs-rm-cfg.yaml
      commit: 4fd5302675a3c9300c1add3d53d7d2418daf3126
[3/4] board: toradex: aquila-am69: update rm-cfg.yaml and tifs-rm-cfg.yaml
      commit: 78dff83dd78f5f3bc3bc0b5b4c559c0648d7b836
[4/4] arm: dts: k3: k3-am62*5-verdin-binman: Enable tifs-rm-cfg in binman
      commit: 927e4880f2d6f45543a73ef1aa1f4dacbdc392f9
-- 
Tom


