Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3167C4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 11:17:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1673088452;
	Wed, 17 Apr 2024 13:17:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="Xev1i3WU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6745688456; Wed, 17 Apr 2024 13:16:59 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F4FE8836A
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 13:16:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-349c5732fd1so366141f8f.3
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 04:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1713352616; x=1713957416;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XUt9HOPF6U2sKBADg7IzBHjXzTLg5IJKlajlXJvMfdE=;
 b=Xev1i3WUl5A8EoEXd8fZQXXJGqN7d0fbNYub4yW+FL8u6EZZIcZVFCiHcJSyYBs0Dr
 2HxJtmzMWHDQm5css8XG0ESS5d01PCFbniNC4GkaFkwat3xDGOd0c/1JLANEYdYij3LV
 zSQcRK8YpPdv1iPZoFi2iKD556v1s25hk15jRWDW62QtAbrtsySkzloZlRhA/7XvzeRV
 zAlmZZYdLz9Tjv8esZDV8V7X5JfRA9fazSIwoZ5J20ni76I0r5ocIKNxAX0TkCwGwZdj
 gFdNCMBo4S+L0+sT7OruGWtAUim9QoY5meXZuyrVqyaXTWOsE5t6S+PQezD9py0HkOQF
 XQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713352616; x=1713957416;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XUt9HOPF6U2sKBADg7IzBHjXzTLg5IJKlajlXJvMfdE=;
 b=pkMQHU45/sNae1zZlPvAdakAx6qpBzx7minDLVcQ5GfNT5NnlMlICLn3NUkBpnwgvH
 qQqoE/tWWm7MX9IOT6AuaeqT1Dsdn/gRLe+T3j8buZoleuHXK1xpOuT6Yci+EV0VVv93
 ENnb5OdMUvQmfSEICd08qMJhtdW1fL3qDVk2ayF3uZpHm6sL/VD7llBf5SioQ6D4dK9x
 QyvcuZw7yulFPqbU/BHOOVRwhja4r/VWoPOAQs4jxM9iS4XpfER4XeUcbDJ4Ly5HfD3I
 NoLZaU4QGeeUItDuYCciLGhN0vO8RognuGhct7nVjmVWyyUgjmT4wiIDPOrXZwEXh8bz
 moiQ==
X-Gm-Message-State: AOJu0Yw68L9TCiibajbBKP3BtkIycn3wD10D92iDr/5uhNn1KF58AJ+A
 RVM9ZniYsm7ePiNkJOfxr3hYLRMNIlAo4xU8A8guLe/X+XQlVMZffVMXpLDGCHDOTYNNbx996AM
 XIo016w==
X-Google-Smtp-Source: AGHT+IHjA8kLAV617q0f8Zd13HKopjBCjhlsNjd1DS5/LkjGmfZnlW2qv/G3r88LeHUFECiLOp2iJA==
X-Received: by 2002:adf:cd11:0:b0:348:b435:2736 with SMTP id
 w17-20020adfcd11000000b00348b4352736mr4518889wrm.51.1713352616478; 
 Wed, 17 Apr 2024 04:16:56 -0700 (PDT)
Received: from localhost.localdomain (ip092042140082.rev.nessus.at.
 [92.42.140.82]) by smtp.gmail.com with ESMTPSA id
 g14-20020a5d46ce000000b0034335e47102sm17294978wrs.113.2024.04.17.04.16.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Apr 2024 04:16:56 -0700 (PDT)
From: lukasz.czechowski@thaumatec.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 trini@konsulko.com, Lukasz Czechowski <lukas.czechowski@thaumatec.com>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Subject: [PATCH] ram: rockchip: px30: Replace misleading log message
Date: Wed, 17 Apr 2024 13:16:25 +0200
Message-Id: <20240417111625.288202-1-lukasz.czechowski@thaumatec.com>
X-Mailer: git-send-email 2.34.1
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

From: Lukasz Czechowski <lukas.czechowski@thaumatec.com>

Remove the log message "out" from sdram_init function which
pollutes the console. It brings no meaningful information and
might be unwanted in case silencing the console is required.
Instead, add a debug log with a more meaningful message, printed
only if DEBUG is set. The same convention is used for other
boards, i.e. rk3399.

Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
---
 drivers/ram/rockchip/sdram_px30.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ram/rockchip/sdram_px30.c b/drivers/ram/rockchip/sdram_px30.c
index 21498e8957..3b429973cd 100644
--- a/drivers/ram/rockchip/sdram_px30.c
+++ b/drivers/ram/rockchip/sdram_px30.c
@@ -712,7 +712,7 @@ int sdram_init(void)
 
 	sdram_print_ddr_info(&sdram_params->ch.cap_info, &sdram_params->base, 0);
 
-	printascii("out\n");
+	debug("Finish SDRAM initialization...\n");
 	return ret;
 error:
 	return (-1);
-- 
2.34.1

