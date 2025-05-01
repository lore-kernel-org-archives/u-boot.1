Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50FB2C369D9
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 01:05:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0734681F7E;
	Thu,  1 May 2025 03:05:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MmVz6PJK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99F53820EB; Thu,  1 May 2025 03:05:29 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB0DB8059D
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 03:05:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3d96d16b369so4005155ab.0
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 18:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746061524; x=1746666324; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RqimSeF2dpzt9IV+IROqI+1g1OwVe9jtPHN1L3WzxmE=;
 b=MmVz6PJK0bL2uzK9Wly1p5sHPXmjecTmqGJ7fVfnGtJBsA0DXu+Ki0trFJ0zh9AiiR
 d6H+bJuZI/4WtuEzBVBSSASnve8T5YRZpy0dsl1tCWssUmSHXB3G6A2SYz7vGJmLzM4X
 HxjOJjvG5Gr245Lw3qxqD+X/v9aRCa8VlUqLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746061524; x=1746666324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RqimSeF2dpzt9IV+IROqI+1g1OwVe9jtPHN1L3WzxmE=;
 b=WTDdUvyJ6lSBROJJYosg7sA7RxzDcNPhy+O+JoUgjsgYWTAwpRSna53s8CXeCIanfp
 QHDSLHCjCAYCA666gjTql6Dn/ApUlK3j+gowIBo3i/seFTm3CK+/wNBPA3ORRx3Ju/CF
 IIurtcyVnsR7uiLNx1+LuyEzMhItd3i3+EmVokgUMdc32WwzHB6v74xIxMC8koW2MQVv
 cZph5GJI/coew73LZRQIHodwpDdolLwPohahMG3WUNuONqdtu6eJtZQFXkGxfDypMyEz
 Eo0qw9VhyHuC65ndAXaGkPGPnFP0t2tSmCEMeYaVWPkALGI0AF8HaVLC4vAmtgLrWtUv
 kyQw==
X-Gm-Message-State: AOJu0YxZcpKQ8Z8XfTTKDZHf5LsSU6aMTuOonmZ2htKTe+ZwOeF1mY18
 Tiqf95lwS5ymncw3VOymYOjjbXg3eqgVOoVG0hFFPHNkk+CfVel2Nur0Hf7mk9H+N6T6TCfRLKE
 =
X-Gm-Gg: ASbGncsxxop8liQpsSx1s9Yon4+cXzHyjkVfITirQ8QBLsGVyIp1ZjaMGbZSaYqfl0G
 0q//c0f9k4fLGfFa2gZDWHGwc0s2F/+ue6tQvVtbomCv6/0E4x8Qw0R2Z+YFkIiiTe1N+eBtryh
 ThyCDm+PKfcOZxmI3fYar4f6b0Jk8917EAj7q5qKabaW/TsqjZcbGaQ/96ZO+PcvJZvhseYyV7s
 yVpb9nLUXWs6+HGJUv4u6oyNJ+I7/cwusz9JjLd/ygz4AH8pi/9TCXfneFFi/vRudQWISv3a/qY
 jEo0baltZcUxWpmo37Pzjt7OkK2Hbq2yeah1nttHPq8KAM+GJhsBq1Kdd6XYOsRBxXJ3IdZ9+sX
 Tww==
X-Google-Smtp-Source: AGHT+IFxzr6k4OJogmofg1prYrnIBqaGzXWdcGmMWslgrT79LzW+tnovzM2ViZmc8Bhm4rdaiea1BQ==
X-Received: by 2002:a05:6e02:3a08:b0:3d5:8923:faa5 with SMTP id
 e9e14a558f8ab-3d9676c816cmr55570775ab.10.1746061524198; 
 Wed, 30 Apr 2025 18:05:24 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d95f480a99sm10771855ab.68.2025.04.30.18.05.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 18:05:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 03/22] dhelectronics: Include env.h to permit reading the
 environment
Date: Wed, 30 Apr 2025 19:04:28 -0600
Message-ID: <20250501010456.3930701-4-sjg@chromium.org>
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

 board/dhelectronics/common/dh_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/dhelectronics/common/dh_common.c b/board/dhelectronics/common/dh_common.c
index 32c50b4f0f5..24fe6ff50b4 100644
--- a/board/dhelectronics/common/dh_common.c
+++ b/board/dhelectronics/common/dh_common.c
@@ -5,6 +5,7 @@
  */
 
 #include <dm.h>
+#include <env.h>
 #include <i2c_eeprom.h>
 #include <net.h>
 
-- 
2.43.0

