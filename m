Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3212C83030
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 12:18:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E29D682E27;
	Mon, 30 Jun 2025 14:18:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sCC/ciNa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1893D81D6A; Mon, 30 Jun 2025 12:08:27 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2066781D6A
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 12:08:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a588da60dfso1146418f8f.1
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 03:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751278101; x=1751882901;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tUCxv553UloVfTHxkQLUjwndPBZfd+wJJUXvgQpELCA=;
 b=sCC/ciNajHQiSqLdRbN7bUrQjYpY7NtUupvzPck6++YpBfJGq+tMi8dVNE6KfZuCt4
 sGIPBvqusv8/rVPyyvjuP1dl48PUZx3Mw34ybSkHEziZ4aCv5lZdnnbQzsILcxCWq+7c
 4ULo/C5SS2ltYknis5iUdxDyxovaeNACoK7oVE6MYN93h7ESpFV4wy2pCdvujN8n64Ej
 Hvc094jr6UGENswahKZDsEwITTbifMotFduNALGyR2WpN2cfxV9L9WO0+vhht0A3uCuF
 q3jr8f6s8io9gftj5b5F9Ip3WVylHnkujfDbobUgUgBPe9C9a3ZhtHkVUcZGMQKV+DS8
 So8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751278101; x=1751882901;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tUCxv553UloVfTHxkQLUjwndPBZfd+wJJUXvgQpELCA=;
 b=NwxwRqqmC1PQhGNKCzbO4RUcp5ZiXPgyfzs7VgC2d6RMmR7TItlUD8C8PynkRNZY72
 PwlO0gdTGwpxCva1Vc/CWbF+6kMVWCc02O//tdAhZF1WPAr3ohu4OSQusUFYvuZtX8P+
 y42BsRgppCOQUQ/TL+fHY+XHAUZCXcHS/601euLzpojn9qX42OKk9tYsf0ZOdBb6feMZ
 tCErzdOJS4Km6+EovJph+uVjUx3bwXOqwOh82uj7z/CZO9WyuaMJSI2AUnIMUx2T9u9v
 7U4HHiV6mRIZXUpZN+7KAwd5PuyS0kxWh9MtzITNa1ZfkYNMaxHaijuCVfN0o4s/IRxS
 60JQ==
X-Gm-Message-State: AOJu0Yw1IhHj+/422o3uc0x6B3jPHwP5FgcGRgIowe9EqB6u5IiN6EnU
 1GcFqX/K+Am1oiy24n5hFg8R6yotA33/wxo3mmWwp7OSvJZ1yBIBK+kE4FFLngaB8kg=
X-Gm-Gg: ASbGncuvhTD340bHThxs4GQWFxZrPlt9ajxwe7LfFNhZN2i5F1bXAjWRXgY0CXsjW9Z
 L8jpKtOjucRGRtGfD3apTmfqEa53W7GIS97PjpZoJxEnCrdqnjP6UxNBTjn0ytsM514jhSdVyUg
 tKdBckVxiDTDe7aoacbaG7JEC8RJVBCzlv2++JyGcFKhXrYRdsC4uOiqqGoN/jr+Gp51l+7XOUp
 Tn9BMGLpY7UXtC734MTRzsn6UOmOPXs67wyWjpiG4sBilkIiolotE9axnuWTReSx/m8N12Yf4f3
 ZEZ2yuZPHrzxRvZQMbAlGxn54bRV8u9l7kO6eg1rPEsh/j2E9PT3kQNKia4HqDVUtF3TptYTaEK
 PFDOxNURrUeJ6klBbjZ8fvc2iShKxTtKqkflx9edNZ7oR2u7Nj+Q/
X-Google-Smtp-Source: AGHT+IGZBGubxcRQPh1rr1JYbGe7YR1QStdU6hv/EEq8qVg84sFFGS5SWwRgj7G/WrKM1cVJIu0b3Q==
X-Received: by 2002:adf:9c81:0:b0:3a8:6262:e78 with SMTP id
 ffacd0b85a97d-3a8fe5b1dd8mr6670955f8f.37.1751278101543; 
 Mon, 30 Jun 2025 03:08:21 -0700 (PDT)
Received: from [172.18.0.1]
 (2a02-842a-d52e-6101-1bf9-06eb-939c-90d1.rev.sfr.net.
 [2a02:842a:d52e:6101:1bf9:6eb:939c:90d1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e5f923sm9737883f8f.89.2025.06.30.03.08.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 03:08:20 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH 0/2] video: display: refactor display_read_timing to avoid
 code duplication
Date: Mon, 30 Jun 2025 12:08:14 +0200
Message-Id: <20250630-read_edid_cleanup-v1-0-ec7d425472c7@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA5iYmgC/x3M0QpAMBSH8VfRubYay8irSBrnj1MabZGSd7dc/
 i6+76GIIIjUZg8FXBJl9wlFntG0Or9ACSdTqctKW6NVgOMBLDxMG5w/D9WMTQVbsKmtodQdAbP
 c/7Pr3/cDS9xlSGMAAAA=
X-Change-ID: 20250630-read_edid_cleanup-8b85e61d3763
To: Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Mon, 30 Jun 2025 14:18:06 +0200
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

Commit 2dcf143398ad ("dm: video: Repurpose the 'displayport' uclass to 'display'")
left the display_read_edid() function unused by mistake.

This series addresses that oversight and introduces a new useful cmd.

Patch 1:
 - Refactors display_read_timing() to use the existing
   display_read_edid() function, eliminating redundant code.
 - Marks display_read_edid() as static since it is not used outside of
   the file.

Patch 2:
 - Adds a new read_edid command, which can be very useful for debugging
   or developing new display drivers.
 - As this command uses display_read_edid(), the function is made
   non-static again.

The patches are deliberately split to allow the functional refactoring
(Patch 1) to be applied independently, even if the command addition
(Patch 2) is deemed unnecessary.

Cheers,
Julien

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Julien Stephan (2):
      video: display: refactor display_read_timing to avoid code duplication
      cmd: add new command to read edid

 cmd/Kconfig                    |  6 ++++++
 cmd/Makefile                   |  1 +
 cmd/read_edid.c                | 37 +++++++++++++++++++++++++++++++++++++
 drivers/video/display-uclass.c |  4 +---
 include/display.h              | 10 ++++++++++
 5 files changed, 55 insertions(+), 3 deletions(-)
---
base-commit: 17012e3068d047ad71460f039eeb0c3be63f82a0
change-id: 20250630-read_edid_cleanup-8b85e61d3763

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>

