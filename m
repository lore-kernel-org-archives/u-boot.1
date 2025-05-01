Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB068C369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 01:05:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A46681FDE;
	Thu,  1 May 2025 03:05:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kdq/7uUK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CCF58056A; Thu,  1 May 2025 03:05:33 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FDA1809A5
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 03:05:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3d5e68418b5so4085605ab.2
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 18:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746061527; x=1746666327; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=teuHPvzuW2rg71egngI1U0tQify39zQ86jODiPF+9xk=;
 b=kdq/7uUKQEF3uKorwUNvGpyuZaFIxp+MNqvHP7wMlqMG7vgBRLLwP2UZ0uG9IoLz2Q
 O0adJCDCZOx2sxli0b72PpN8gdh2PNPFU+0UviXZBBk0PozALh8BRcvQP2tX3YyA0wP5
 KoGC5SJSszOHXu78brLU0PPeh96LuefMq7SUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746061527; x=1746666327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=teuHPvzuW2rg71egngI1U0tQify39zQ86jODiPF+9xk=;
 b=TnYB7vx8lCX/k8VIZz5UmIiflrQeSqsBZdIIXTRnBWNM9jMoLFAQWK+hyyFbV6Winl
 w5XJx5jjuENb+VUimb02ja+VPdOn0l0admy+8FmLeIzOZWAEfs5TLnR8m0Af/LIWEp1f
 tD3BBHh5GrFfaus+hFzMbmt0baz/Cv8R6sF4+ghq7X473oUCvBaQgmUKfac06C6x2tmH
 HZKeFtvpCnYpy6Go7hPNqZxoVqxtzaAYdw9aV7uVd5nBSfHCkxVWNhi/lwZDN/jWIXBV
 ZJwRiVKKFRF+QvdX2mw1AWxlOVRakf+2GSno+UKLeLnbE8JCFQPsrldIz6YnYURwYhhi
 PRrw==
X-Gm-Message-State: AOJu0Yx0hGLkTNGplmpg+qDGvcZ6/62l8ldog+IrjBZ2tp/vfZg7CQDs
 bL3I8ixXpK2RSzschXGGp+NRJ52Qn+DHSNQ0Jt2WHJvN5sko9owye3XCnZ2Sf5mNJo4QWjv7b0g
 =
X-Gm-Gg: ASbGncuzGN0AhPM7H3SIb0chmexw0JjnEjUAyHZKQ4Ed96N3t7uX+DmliSze2KnFrQ5
 nDhg0tE1kAnfNVf00x7AmJ68Lz+gR2WTQ87gkHwARuvlSHsrBGO4pLXkkpLh1zG7KQv05SVWyKj
 Eqk/xTvtyVV3CHt4S5le3oYQr0vjhfPVXQWTtEC+1DkGCuV4+J3Zbn9su9g/zpXWGFSmwhpCqDC
 QtAJsL3dBuaD3xDts3zy5aBgkTZHZayp0CZrhmy74HcqgMsOhHhTVCc2A8SfwvzHAuzm669pBVt
 6CfYT/hzQJhvzmjyfiZeGLrfh6MgjRs1REY/W+z0EJlhDY8uIAiRbiIJCGsZQumlfhETCp0Rdq9
 hvcPQqXAsh9Mg
X-Google-Smtp-Source: AGHT+IFTA6lwcRBX8r/Q4fsN8t2M3AfsWZiba62nKaCyl6ZukAc9+HqyuzlJikFBgRDsW/cmDlmQzw==
X-Received: by 2002:a05:6e02:1a05:b0:3d9:398f:b836 with SMTP id
 e9e14a558f8ab-3d96771a28emr63314455ab.17.1746061527192; 
 Wed, 30 Apr 2025 18:05:27 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d95f480a99sm10771855ab.68.2025.04.30.18.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 18:05:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Fabio Estevam <festevam@gmail.com>,
 Jason Liu <jason.hui.liu@nxp.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@denx.de>
Subject: [PATCH v2 04/22] imx8ulp_evk: Include env.h to permit reading the
 environment
Date: Wed, 30 Apr 2025 19:04:29 -0600
Message-ID: <20250501010456.3930701-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501010456.3930701-1-sjg@chromium.org>
References: <20250501010456.3930701-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This file reads from the environment but does not include the correct
header. Update it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 board/freescale/imx8ulp_evk/imx8ulp_evk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/freescale/imx8ulp_evk/imx8ulp_evk.c b/board/freescale/imx8ulp_evk/imx8ulp_evk.c
index 0af61067263..4bf77a488cc 100644
--- a/board/freescale/imx8ulp_evk/imx8ulp_evk.c
+++ b/board/freescale/imx8ulp_evk/imx8ulp_evk.c
@@ -3,6 +3,7 @@
  * Copyright 2020 NXP
  */
 
+#include <env.h>
 #include <miiphy.h>
 #include <netdev.h>
 #include <asm/arch/imx8ulp-pins.h>
-- 
2.43.0

