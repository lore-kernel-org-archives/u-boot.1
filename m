Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6DE3EDF161
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 13:25:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E7A783DF3;
	Fri, 13 Feb 2026 14:24:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j+S2W/+S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFFC183AA9; Fri, 13 Feb 2026 13:02:06 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34712802C1
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 13:02:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ivitro@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48374014a77so4743515e9.3
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 04:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770984123; x=1771588923; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=au2+VjNGlKEuJk4XIFwxdD8ZR5AEH8Cjf5si70qrn0Y=;
 b=j+S2W/+Sr+LwmESc8z0aUB/URgAnN2SLBcoj6M//jhsmck8DRiTehz5kYCINrkVYzV
 dTFAFfHwLCZ75weU1JhGg8/THeY0/Mwf5/0ePybSl18s6fAd/InDkm25CWkZFft9F5Tk
 eHxQ8l3At3ppcZRSDZgWWomJb4tgNpD38DsHI7KJnz94NP/k3Ysl8gzYLgqZCzB6GrA8
 BxNjvE0k2oBeB1FJti/6AWrnFLr9k2+U2/VCbYWkQQGKzhemwmlX9J2nr0AoU1fithZV
 qw9hma286K9BVQCNI2azLawEA+v8b8mBUWsSHB+8nH673u3oymWqBtajzcN8olB67ay2
 OAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770984123; x=1771588923;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=au2+VjNGlKEuJk4XIFwxdD8ZR5AEH8Cjf5si70qrn0Y=;
 b=F/jKFjS/FJKBg8aLR/NarlY4bKD+uJKEYrS27vmnwxcJODVgEZgzqo+kT0Q11DShMv
 r5XZHahlM74a84LYysojyOKzHihqoq2+wzCI/+vKufnL+25vtY6IYYnvVD1te1j9S/g8
 S+TXYn4ZxxXNwi9zPG/ndCoICgGqmSd51FX90W0F62LrScOo/x5cflAEyoW/gx6T68JW
 7cuUAHbFzxsPepWsE+E1UXg+jBZrsEtiarFR9N5QEriyjyvz6tcuGUZH7iS6fsNUGVUm
 NcGoCSzw+T9QbZXHTqVcjpAi37XUXgQVU/JqyTmum2fDL/Z6V3ZcNKN38FmmEm0t6za3
 F3pQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNNiRxg4wdboS10NfPxG/e8YQR79yWU2PsrWuxGGEsm/tkdDWdZ9l5v9f5keAC79FG/yjU20Y=@lists.denx.de
X-Gm-Message-State: AOJu0YyQ24quRUJPPR21RSGD6UvF7aLwWBkwvpxmytiJRV8/jPPNce9m
 70I+oCBpogRvdN9bjwRhob/5/jd/KtPH/d0ZVbPfcx7YebuRQxqPNk0IDsoOUg==
X-Gm-Gg: AZuq6aK15DndZuWNllZrfB12ZtAnpx4D9/dwcO6nT0D/nwjS8Pfe/nWuGsu1lNajO/0
 f15/B6SIHuNZPwM0Au//uv224Wp7Mbig0NmMloZP/nma/qJyxIstK0ba5sUYktt7yst+LA1xOv3
 D7IRr6mRkU7/rorjvAX+DH+gWcpFANlYew5TT7uhWU58tcOFM5J4x5rW1SEXICAowKrwnOy1c3U
 Pp/3rAbQbroxcCicxoY4kAxaXdzRv08C1/obrmSfmYPk4uSAg4+q3OARyoGJCvKAx+WbqzLV5yc
 dM9+ySbxnfUNUx7ni/h59gBJ6sG6hiSEjscGdZxpMrLYHk2bb8pKj4Fs/ay0toIJK1ogTu33DRM
 evIEuzR8YToGuaBLV5grVVMCR+DFRzKcXsg40S6smvpPclms56rTOCAax7HWji6YvLVu8TvkZJa
 Ebg3/VZVdnlEV8k6W5j2CuSJnUbyxTiE1A+xImoZN8LWWnkKwtQQ==
X-Received: by 2002:a05:600c:1f91:b0:47d:4047:f377 with SMTP id
 5b1f17b1804b1-48373a69e47mr24114515e9.36.1770984123234; 
 Fri, 13 Feb 2026 04:02:03 -0800 (PST)
Received: from vitor-nb (bl19-170-125.dsl.telepac.pt. [2.80.170.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d482480sm292281435e9.0.2026.02.13.04.02.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 04:02:02 -0800 (PST)
From: Vitor Soares <ivitro@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: Vitor Soares <vitor.soares@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH] toradex: tdx-cfg-block: add aquila tda4 0223 pid4
Date: Fri, 13 Feb 2026 12:01:59 +0000
Message-ID: <20260213120200.543875-1-ivitro@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 13 Feb 2026 14:24:18 +0100
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

From: Vitor Soares <vitor.soares@toradex.com>

Add PID4 0223 Aquila TDA4 Octa 16GB IT to config block handling.

Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 board/toradex/common/tdx-cfg-block.c | 1 +
 board/toradex/common/tdx-cfg-block.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/board/toradex/common/tdx-cfg-block.c b/board/toradex/common/tdx-cfg-block.c
index 0fc3759695fc..17fda5038d41 100644
--- a/board/toradex/common/tdx-cfg-block.c
+++ b/board/toradex/common/tdx-cfg-block.c
@@ -189,6 +189,7 @@ const struct toradex_som toradex_modules[] = {
 	{ OSM_IMX93D_2GB_IT,                     "OSM iMX93 Dual 2GB IT",                TARGET_IS_ENABLED(TORADEX_OSM_IMX93)    },
 	{ OSM_IMX91S_2GB_IT,                     "OSM iMX91 Solo 2GB IT",                TARGET_IS_ENABLED(TORADEX_OSM_IMX91)    },
 	{ VERDIN_AM62D_1G_ET_GPU_NODSI,          "Verdin AM62 Dual 1GB ET",              TARGET_IS_ENABLED(VERDIN_AM62_A53)      },
+	{ AQUILA_TDA4O_16GB_IT,                  "Aquila TDA4 Octa 16GB IT",             TARGET_IS_ENABLED(AQUILA_AM69_A72)      },
 };
 
 struct pid4list {
diff --git a/board/toradex/common/tdx-cfg-block.h b/board/toradex/common/tdx-cfg-block.h
index b28033d8332e..69d4f5e449c6 100644
--- a/board/toradex/common/tdx-cfg-block.h
+++ b/board/toradex/common/tdx-cfg-block.h
@@ -147,6 +147,7 @@ enum {
 	OSM_IMX93D_2GB_IT,
 	OSM_IMX91S_2GB_IT, /* 220 */
 	VERDIN_AM62D_1G_ET_GPU_NODSI,
+	AQUILA_TDA4O_16GB_IT = 223,
 };
 
 enum {
-- 
2.52.0

