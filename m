Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA3A1061B1E
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 20:23:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6FE48352B;
	Mon, 30 Mar 2026 22:23:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gBwcObDu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C7F283F5B; Mon, 30 Mar 2026 22:23:47 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E358680212
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 22:23:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-46aa216a5edso1423437b6e.0
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 13:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774902223; x=1775507023;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1MNb1X0K5X1O/Q4q852gl9UVzknGdpKLC8aTQuZVbqk=;
 b=gBwcObDuK5xA7+CxFZipMIB4uRcJc/tyxmrUapmEahrUQpcZzBRt9UZLULowIX8hiF
 TWqD6O5k/oimrPvPsoQ0Z4KwDWowusiwCfolGlM9zDh2xPx6t29RsRZnHRQ+qYvKr6sH
 XnAFqFZMRiUMibBWJjOETM+0LBIl1Va0z0XJtC3Q72NeOhyGrk6iPsH2omAdJQe6QPC+
 UG3otEfA5qVjPPRyCkkTQwwQ/IdJ2Kv1YKT1pudcnP0lelbkHHCoPDOrFk9zJwNxdYm8
 rlT5OwZcyAGyWfAm+Lg9avR+sKrZqa9kz3dIvtz8WAdwpFz/PdYsUD7Lk3uFyCjCCsfG
 fSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774902223; x=1775507023;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1MNb1X0K5X1O/Q4q852gl9UVzknGdpKLC8aTQuZVbqk=;
 b=loJfVhGWBdPIuI1I8FpH3kZw6M5E9j92XK1uqd0jX4bUYEqm6j7Fy95cqqSshnGadU
 vvfM6aOtttt5JsN8BUCtw69cqun8u2F+y8WFsRgvsIu/nJIQ3eIdOlal2OHLRUDVcjlb
 qdMW3WBHi8PFmwmkoUeiltmfJM5za/Axt7EDAZNqFVgoenYeHgxwRs5Qx02vSrGZqfnh
 hJIbBtFiq3ncfcR5sctX6pgGyHnnypJxVLdoZfzunEUKIefRJaX5gxesAA+Z3qucQPB9
 cWdMeqbxd0X6O9TgjnYICL/M19DQQjUumLC+szxR2aEFavzK3lQ6UvR9LXIsm8qRJmZr
 +KZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjV8RcHsThyA4ztrJtG19uzaOKfQ5Rbt4G1TXuO+B0IZPqeUtYztnmj3YkVMzdNY1xOD4lxSs=@lists.denx.de
X-Gm-Message-State: AOJu0YwF3kS7ZQiHkEHiwSaurF1EKiXjF8YU78nEZBqIhI0j+6M+3YKQ
 8/qHgrAOnihke9nLAI1TymdwpZRCTpiw4EYOEYXc4moRxbdDNwxOQg5XVOhbnHfPWXs=
X-Gm-Gg: ATEYQzxCW39X9jQMum3OsXNmnyxp7LlrJHX/sHVLsT6hJNxG6fMgZNEbZAja/TdNZ4d
 mbNzyjYEm1j62uRoOqFs3heSx2peIkoy7TnxmzvD5I76LExNnsKc6l7TDvDtY2n3O6oLHcSzIxK
 l4MFmQnRmua4kTpuBsPWXmVZKlfY+lsdO0iRzlrO1TD5J+pEr0k3KLL99x8a+5eCZGliPFtjtdu
 D6+JIYJTan7pYRF+cdTpgDv67Ny5bFEOIiYgo/ujRlZXhTUlcEZEYfTLAoQ2bAOAxBvZSLFllnz
 f300o7+7UsSGa69nWOC7r1zF+pNjeHCR0ow/+AEnq4pareJtZjSzrGS5N3aCS3CjjQsMn3f34gf
 WgVULlvu+6y2+OcuhWVM5+aZ/USNvm0rq1jMgxjuVeXwtCRiAeK99HVgfdAKCPhBsv3GnIqffw8
 WY+YuiCoSTCOeXrFiw1/hR6nL7czGe
X-Received: by 2002:a05:6808:1309:b0:467:3f4:906b with SMTP id
 5614622812f47-46a8a64394cmr6689970b6e.51.1774902223550; 
 Mon, 30 Mar 2026 13:23:43 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:a67f:a092:38d7:379e])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41d048e1984sm5882608fac.4.2026.03.30.13.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 13:23:42 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/2] arm: mediatek: print specific CPU type
Date: Mon, 30 Mar 2026 15:23:17 -0500
Message-Id: <20260330-mtk-mt8189-cpu-type-v1-0-4059c3b52761@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY2MD3dySbCC2MLSw1E0uKNUtqSxI1U0yM0syTrSwMDa1tFQC6iwoSk3
 LrACbGh0L4ReXJmWlJpeAjFKqrQUAV09gIHcAAAA=
X-Change-ID: 20260330-mtk-mt8189-cpu-type-b66b3a883599
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=850; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=zjTvD3TIQ7e3wTxn83PTpAvZ6FZ4/QPi8M8uIjw9ENg=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpytu5gFN5aYClS3uh9zf5k52m5DrHO/MrsdLXc
 ZGla/v/ux6JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCacrbuRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AiusIAJobbHVeB/55IN25LB9D9jik4WPQ+8AU5ciCxVn
 000/e7QvP4Uvr8ewMl1kQAmnHtbhqh9UrLxjq1uaxIiNvSxIwVYHuyNtV7O6axgXdcmAiem7V98
 m7XhECY0YC/Q7OXM2EbBCoNcvYeu3S2Yusw8iIpGeo1nEybEsNAKLxEhZrSxEjDBXSA8A+V8SxT
 rWPXBMidoeQXqL5gK1bZBEVpEvXieGl4sdhng3mqG42CIWkPU+TCHOFwhc6ssfvmatTJ7mm6jen
 CFepL1UpYnVmv0H8JFT4QAjirzq//RuDH0+khblAlURAuPmfJj2mHhE7j/Pqi83USJWIYYYt8GC
 lzKE=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Since the mt8189 init code is shared by multiple similar SoCs, it is
useful to read the CPU type from the CPU itself and print it instead of
always using "MT8189" in order to have accurate information in the boot
log.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (2):
      arm: mediatek: add SIP platform bininfo lookups
      arm: mediatek: mt8189: print specific CPU information

 arch/arm/mach-mediatek/cpu.c         | 55 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-mediatek/cpu.h         | 14 +++++++++
 arch/arm/mach-mediatek/mt8189/init.c | 32 ++++++++++++++++++++-
 3 files changed, 100 insertions(+), 1 deletion(-)
---
base-commit: 49a76f715d8e348650feb17979d8d3ad52a66fb3
change-id: 20260330-mtk-mt8189-cpu-type-b66b3a883599

Best regards,
--  
David Lechner <dlechner@baylibre.com>

