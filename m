Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0125AEA3C4E
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 13:15:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76389840B0;
	Thu,  9 Apr 2026 15:15:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="lBnn60xI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 114F384142; Thu,  9 Apr 2026 15:15:42 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC29D83CF5
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 15:15:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48897fd88ebso9465075e9.2
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 06:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775740539; x=1776345339;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mCgZsZZ3zjWYziUMUWWBxi6kutRYPT7usCoWJEIoQGo=;
 b=lBnn60xIL4gkDm3jPLq9NHB5H9D4+CFdXQDxLPiQp6FB7u24ABsE/A8Bj3BUVfcNzZ
 G4xLOeC+eQ7RWJvvf9uqbwe5tqlpZ8MgDDSLMr9q1gn+HY2pPYg6f9aJ8ueU6tUxrJwR
 q2Gf63qG5t6kVhiyiJLFKRFhUfGUHoZZY3TAUQPzqYeyUnhYoPAZbBTr8nC29pYU9Ec5
 EVh+bnHQXqSqL60yiyV98/6RM1w9QBtjmnw9XgVz/DSIHTuGT/MSO2ha15z9vWt4uAfM
 2togdO2rYB/Vq1PadISge50UDB4ROuOnDc9cZnvFU7IZgd56jKbgpVSYgEvT1RKToOhE
 aNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775740539; x=1776345339;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mCgZsZZ3zjWYziUMUWWBxi6kutRYPT7usCoWJEIoQGo=;
 b=ZXnriGEDHM6ZF7GYDFHv6VvUBASrXOc92+8isoiEd0T4gCUIgHx2n+kU7omb6qrES7
 rEoCQdMBirDSTyzCRPAINZz3RV0ENnLnstrBhSgHBPrdMQKONUQA17A2kaZrASxe9p/p
 jx9YjSyv6mYvstmRirtLDvvsqY3FkLftysxI7mJXTsD+l2SprxwRohkTMQn/GKtbrjdN
 lbXoktKLDeVtcv7XVjDu0vTP02a0uqb2blCqsdN+3t9fCX5mY5YE5NAEewCUfeiY6iJC
 hp/yKCH/sK2HUGM6q2aH4yNRlFj19HJRFMxPLPF1uhTB7uJaFedw6uzMkOy/OA3tL+72
 4ltg==
X-Gm-Message-State: AOJu0YxtVMCcZ5nQc3eEY+3mB9/1caQglWDwu9eVf6ng6OLK8GZRxr2U
 MW7M4KI9tahPXkzwLmhvhhp+PUOqdgXizVZsJswjbttogmxSnQpCqApzC9l1s7+5mKM=
X-Gm-Gg: AeBDievTTy2DMefqmsNSiI5dGstrbQZu6jbIFamTfABbAmnSxpJoree3jMOe5YKPIpB
 onEUU/MFyE4c3Apd+pW7nDAaA7ilAgItOT2UKV6sQL+onLtwygBAg3NsnQJfIRXbizwJp1vEirT
 nfeu/Y13Xqz/FKreFX7yiCefEP4l/tK/BDbWNVYCh2X1TMj5cEknQsCr8oB497NzXPc85BrsJzu
 9Ze1dIALfCuI9qHx+PfT9pJJdBuGAObATDOLWK/5gK4wyVtlXW04QHWXcWLjmg9P+rqvsoMpRJc
 0R5oF/KGqjYTDl44r4eqO+qY/2k6hIbXtel0y3YQczApu/PpRxTtPaoXjW5bPVuZVXc02EfvZTL
 Q/tfO0x4M1jtN+1zTu0FhnnaTUPxZqNmzFpf6qIPzayNqYgv8l2QJfOhEuNmPSHfetNpK9f/R5G
 bDlrGhuSwuV3AjLhZUYbRZh/p2zhPJE3LqEJWC8QVwP+QlIg0pH+/UXVtq9gb1stfIfo26V1VfK
 t+aklpeZF1aIjt9y+cL/W3UUvLsn6NZYkRZpMGeXndBqobeeTH+kTFfrhTvIJWVDtZpHpfMWcCE
 ZphOa1A=
X-Received: by 2002:a05:600c:c0dc:b0:485:3193:6ddb with SMTP id
 5b1f17b1804b1-488ccf3a0fcmr39485325e9.3.1775740539093; 
 Thu, 09 Apr 2026 06:15:39 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-c778-651b-ee6b-086f.rev.sfr.net.
 [2a02:842a:d52e:6101:c778:651b:ee6b:86f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488cfa5d118sm55034675e9.11.2026.04.09.06.15.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 06:15:38 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 09 Apr 2026 15:15:43 +0200
Subject: [PATCH v2] boot/fit: fix misleading comment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-boot-fit-fix-8-byte-alignement-for-overlays-v2-1-32a7878e134a@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/52NQQqDMBBFryJZd4qJVqWr3qO4yOioA5qUJIQG8
 e6NHqGLv3gf/n+78OSYvHgWu3AU2bM1GdStEMOizUzAY2ahStWUlaoBrQ0w8ZkvdIApEOiVZ0M
 bmdxaBzaSW3XyUHUSSy1bnGoS+fHjKK8u27vPvLAP1qVLHuXZ/ueJEiSoR4uyUtjgqF+o08ro6
 D7YTfTHcfwAEPZxRekAAAA=
X-Change-ID: 20260324-boot-fit-fix-8-byte-alignement-for-overlays-381b0a17bf4e
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>
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

When load address is specified but set to 0, we ignore it and load in
place instead. The current comment is misleading, so update it.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
It turns out that the else is not useless. The comment associated to it,
was misleading, so update the comment instead of removing the else
branch
---
Changes in v2:
- update comment instead of removing else branch
- Link to v1: https://lore.kernel.org/r/20260324-boot-fit-fix-8-byte-alignement-for-overlays-v1-1-257b132b6bda@baylibre.com
---
 boot/image-fit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 067ad236081..2d2709aa5b1 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2282,7 +2282,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 		printf("   Loading %s from 0x%08lx to 0x%08lx\n",
 		       prop_name, data, load);
 	} else {
-		load = data;	/* No load address specified */
+		load = data;	/* load address specified but set to 0 */
 	}
 
 	comp = IH_COMP_NONE;

---
base-commit: f0000b4a57e9edf8ff8454b9056d767466dff57f
change-id: 20260324-boot-fit-fix-8-byte-alignement-for-overlays-381b0a17bf4e

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>

