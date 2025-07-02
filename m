Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE2DC83038
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 01:08:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A70C4830E9;
	Wed,  2 Jul 2025 03:06:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="foHtC0Xk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E713982CFA; Wed,  2 Jul 2025 03:06:09 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC361830CA
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 03:06:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2ef461b9daeso4271637fac.2
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 18:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751418366; x=1752023166; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7h/el8HDwjAuDRmsMgm6oqyNJxoU2zwjU+XoTVjgLr4=;
 b=foHtC0XkBzzOF9xrlbbjjfX8Ja7ZPtnA8p9SnIa7IGAyO7ExDC21Ztk3T3r6lkk+Xa
 m/5HnwOsfOPNX435EQIXHPHSHXGotaD2qP1ZwtkeILJ/kTQFQPskCkNyK8LXiLbo5Cct
 rG7tRe54z73D9qYkQXQdt9gUqfN4BWVXCzJNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751418366; x=1752023166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7h/el8HDwjAuDRmsMgm6oqyNJxoU2zwjU+XoTVjgLr4=;
 b=OtW6dHGH5Ecp8RQPTpBZrwhWg5ymIGsjClXIlrMoSviu6hg6e7tWxtFo98GD6OzmuK
 yS7tcvzdmFFXduFzCwXE2pAbGFr3/rUJ/CeeNqCsrAVa04Yo3xLLRByURSWozu6rnzww
 EzsUQf/kdKcv0re7vWAP67zsR7g6joHnteN3OSZ+h9guEWpaB1qubWTJdGqFzYrhqCnr
 StAZ/cIcCVZP8N+Zt/0Sa47XQ2lC5KEALtk8YvVsDnRkcTHOD+G3o5nBxhru3UVuMjLe
 rf5xXSbTrGoilAHhWGJeHebZYP5CuVk72xbZmnwOfSR3XGxQBsl8ejmUkNzzawSmxlvW
 u3Tw==
X-Gm-Message-State: AOJu0YwfJ6PQcNgL2y8sktwiJFm958s5q6f8o0jYnks2DFeEpA/za7Sd
 YnmhmD4TYAYO9kcz6Nd/AEyzFMv+KphimwdZ2CsdeCHmXlCRo4DeZhtO5K/RsDlmo+8CsBqAqxD
 wh4aAu0g=
X-Gm-Gg: ASbGncuHbeDywOJbCDXKZBD7n5MnlV+yFemSuMcIyPgztxn3knZjEVRjfYeTmxUp/zW
 JFzaTXrFUAiqABXUCa3rAFfiB/7nPYvBwI8uHmPPlTOXxxb/eUFxGPa89g5wfxk7M4YWQ69M9Mk
 RF4LCkDplYrZvw9AonJCt3dLUDhMWcUj+b9O0QHrSSRAoyCaHbgi3mLcVHr4MFr0qFKT40uJoza
 YKUvMKjVI6aPNA+gu+5mJ/pE8M4x2cYPB8o8TvuNTA9YYm9QiqlAmKsrS5XlkTVuJkFmaq7Nhwo
 HNJDqDt23wzUC/CLS89aMrMjsLKUjiUPsV/z51TaT+s8f4DToVB6Uix6pJcLKqBs3QK6yAeG6Xg
 9X/TWvXPEhrmqUqKsR+m9OiQWj+VY8yF0wg==
X-Google-Smtp-Source: AGHT+IEZDtEjTPxf4gxB/wrUrRSBUUk0GfvDq93zfVlAEfZo6Jb3OCCn7y7YmbHyNhtDb76HCp9lpQ==
X-Received: by 2002:a05:6871:33a7:b0:2ea:6ea1:9625 with SMTP id
 586e51a60fabf-2f5c7b59dbdmr765691fac.31.1751418366509; 
 Tue, 01 Jul 2025 18:06:06 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b20dfsm3569640fac.25.2025.07.01.18.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 18:06:05 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH 2/2] common/avb_verify.c: Make use of LBAF for printing
 lbaint_t
Date: Tue,  1 Jul 2025 19:06:03 -0600
Message-ID: <20250702010603.19354-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702010603.19354-1-trini@konsulko.com>
References: <20250702010603.19354-1-trini@konsulko.com>
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

When printing the contents of an lbaint_t variable we need to use LBAF
to print it in order to get the correct format type depending on 32 or
64bit-ness.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: Sam Protsenko <semen.protsenko@linaro.org>
---
 common/avb_verify.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/avb_verify.c b/common/avb_verify.c
index cff9117d92f1..29a3272579cf 100644
--- a/common/avb_verify.c
+++ b/common/avb_verify.c
@@ -320,7 +320,7 @@ static unsigned long mmc_read_and_flush(struct mmc_part *part,
 	}
 	if ((start + sectors) > (part->info.start + part->info.size)) {
 		sectors = part->info.start + part->info.size - start;
-		printf("%s: read sector aligned to partition bounds (%ld)\n",
+		printf("%s: read sector aligned to partition bounds (" LBAF ")\n",
 		       __func__, sectors);
 	}
 
@@ -363,7 +363,7 @@ static unsigned long mmc_write(struct mmc_part *part, lbaint_t start,
 	}
 	if ((start + sectors) > (part->info.start + part->info.size)) {
 		sectors = part->info.start + part->info.size - start;
-		printf("%s: sector aligned to partition bounds (%ld)\n",
+		printf("%s: sector aligned to partition bounds (" LBAF ")\n",
 		       __func__, sectors);
 	}
 	if (unaligned) {
-- 
2.43.0

