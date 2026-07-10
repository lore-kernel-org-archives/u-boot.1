Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E342C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 16:34:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 990AE8498C;
	Fri, 10 Jul 2026 18:34:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="owItH4HN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E5188498C; Fri, 10 Jul 2026 18:34:41 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1639F84A90
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 18:34:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hfranco@baylibre.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-8114a4542b2so15034907b3.1
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 09:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783701278; x=1784306078; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4F2X1gcAcxCUXWpvofwzHLlBZh/r+vPZKeerBrtgRYg=;
 b=owItH4HNz9vH8AQ+BdTIrVDrnw4P6onYhvBFDaNmP1OJL0iz3uNqoa1DnRyADNy0Eo
 zNLmjTzYBthDYnl2CrpCvxOE8VM2eGErrzQYHw96FopP55niB3ou0tgnkRkxDFQkT4kC
 I5tQOAb6WBkQ/gcnPeo7eDGzSogdhuglPJOPgbJ4+/mhj7hJDdEnfc/Fr5n+jVdevrpL
 r33zjOk9X0ceRaehhB6AWqYVyBzVH1UGFTqa3TJBf2I0IrADTT/8ejgsmEFY8LQ9Jhwe
 CACy6voytstXkbsN7hUFiG0yJyhNbkGgcRcnMnz0jFxRsaafhyzl9jjhqarUM8uoh2Ad
 auYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783701278; x=1784306078;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4F2X1gcAcxCUXWpvofwzHLlBZh/r+vPZKeerBrtgRYg=;
 b=GC+7YXU5g2Rr3aCFn8fNGCod5pk7SPqz2cT+B2M59EIxznOdrLQLuP8k6abvqkZrsp
 CkjHQcKDU568Dk2QW5DhuqElW5hQQK9T5N2F/vIPIj1tpvnjzw+jxGu6fLIlkJ6bcmgO
 eiCTanTBUdX2Uzvbe2x4tZ5wVwSe6hQekI/iruW94c2W8RQvnHYmh8U9/d3ru+1p5LFX
 0vN4MwZHz/r/TJ5Jp9blnd22XMN7RK80QKNtcXKqbQyXatXNRuztLlw+9kx8ZUxtICRy
 Zgwbz34AcfJI8kP4Ff4wMxrhl3GO8wM3GwFj6anuUrLLmj7T270lHTtC8G02oU4D9pZL
 h0nw==
X-Gm-Message-State: AOJu0YyQn3VFHrhYZR3mwlVUyILP4SPuLp/ApD9yAt9Iow3LHN2KxVDc
 KxdoEBitkMqH7R0ecy/lAZgU/hFydXoWEYEX6BLAcUoG1tVRerDHwwio3Fl9XbkfoDo=
X-Gm-Gg: AfdE7ckHvXXOWyYUxpUeMtpNajtsHQryrQjDiGM+d3AyqAeVbjIYA/6t9gdJL2ziaA1
 fsWmPbGGplhfChexSK0X+oKPL8VQHdZE/tlTz5Jolo1QvlCnNpmZJiDCA4wAnSQ4r2FZAaPYg4E
 dFy671Nh6GlBVD60cxYLx+V950z6jZrNRuwUhq3zMACxLh1rDgLnPRREk+4rNu1VfaMvPvw3Eod
 rkLoLiZLBcElr0HsSWNgWAUNURpF748IGriNLOMN/c1Qd04BLRVyZ76okRh8P9SlDJKMY+rieAL
 dfZkmI/sGU+mk9BngWx+g2X508X0gYyWrsF/IOhxu8i7/fqMfIVzrz2IvzjkXDuS6YBxsrXQwik
 IKPAiJoBkK0zPE/eqgSYqOTFq2AX65ez5GLTnFeft1SoLcA2F7t4wsSZG0yz6RJS86Gxzrk/3yW
 dftvjJm6Pi+OzlgWcC4sn0jc62A5Nnh7AlMgOyZnyXo1qm1E/0Ut0tVEYXYQ==
X-Received: by 2002:a05:690c:6e82:b0:7d1:dd7b:b71f with SMTP id
 00721157ae682-81dbca208a3mr95461937b3.29.1783701277675; 
 Fri, 10 Jul 2026 09:34:37 -0700 (PDT)
Received: from [192.168.0.219] ([2804:14c:4c5:9534::40b5])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81e6c1ee792sm50007747b3.38.2026.07.10.09.34.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 09:34:37 -0700 (PDT)
From: Hiago De Franco <hfranco@baylibre.com>
Date: Fri, 10 Jul 2026 13:33:55 -0300
Subject: [PATCH 1/2] board: sophgo: move ethernet driver to common
 directory
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-add-milkv-duo256m-v1-1-0f761100361d@baylibre.com>
References: <20260710-add-milkv-duo256m-v1-0-0f761100361d@baylibre.com>
In-Reply-To: <20260710-add-milkv-duo256m-v1-0-0f761100361d@baylibre.com>
To: u-boot@lists.denx.de
Cc: Kongyang Liu <seashell11234455@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Yao Zi <me@ziyao.cc>, Conor Dooley <conor.dooley@microchip.com>, 
 Randolph Sheng-Kai Lin <randolph@andestech.com>, 
 Michal Simek <michal.simek@amd.com>, Andreas Schwab <schwab@suse.de>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Martin Herren <sputnik@on-the-web.ch>, 
 Chen-Yu Yeh <chenyou910331@gmail.com>, Peng Fan <peng.fan@nxp.com>
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

This will make easier for future boards to reuse the same driver (e.g.
Milk-V Duo 256MB).

Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
---
 board/sophgo/{milkv_duo => common}/ethernet.c | 0
 board/sophgo/{milkv_duo => common}/ethernet.h | 0
 board/sophgo/milkv_duo/MAINTAINERS            | 1 +
 board/sophgo/milkv_duo/Makefile               | 2 +-
 board/sophgo/milkv_duo/board.c                | 2 +-
 5 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/board/sophgo/milkv_duo/ethernet.c b/board/sophgo/common/ethernet.c
similarity index 100%
rename from board/sophgo/milkv_duo/ethernet.c
rename to board/sophgo/common/ethernet.c
diff --git a/board/sophgo/milkv_duo/ethernet.h b/board/sophgo/common/ethernet.h
similarity index 100%
rename from board/sophgo/milkv_duo/ethernet.h
rename to board/sophgo/common/ethernet.h
diff --git a/board/sophgo/milkv_duo/MAINTAINERS b/board/sophgo/milkv_duo/MAINTAINERS
index 651a0592f7a..6941dc5b376 100644
--- a/board/sophgo/milkv_duo/MAINTAINERS
+++ b/board/sophgo/milkv_duo/MAINTAINERS
@@ -2,5 +2,6 @@ Milk-V Duo
 M:	Kongyang Liu <seashell11234455@gmail.com>
 S:	Maintained
 F:	board/sophgo/milkv_duo/
+F:	board/sophgo/common/
 F:	configs/milkv_duo_defconfig
 F:	doc/board/sophgo/milkv_duo.rst
diff --git a/board/sophgo/milkv_duo/Makefile b/board/sophgo/milkv_duo/Makefile
index 18ada7d72ff..aa321d15687 100644
--- a/board/sophgo/milkv_duo/Makefile
+++ b/board/sophgo/milkv_duo/Makefile
@@ -3,4 +3,4 @@
 # Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
 
 obj-y += board.o
-obj-$(CONFIG_NET_LEGACY) += ethernet.o
+obj-$(CONFIG_NET_LEGACY) += ../common/ethernet.o
diff --git a/board/sophgo/milkv_duo/board.c b/board/sophgo/milkv_duo/board.c
index f0944859b58..34339c42925 100644
--- a/board/sophgo/milkv_duo/board.c
+++ b/board/sophgo/milkv_duo/board.c
@@ -5,7 +5,7 @@
 
 #include <dm/lists.h>
 
-#include "ethernet.h"
+#include "../common/ethernet.h"
 
 int board_init(void)
 {

-- 
2.54.0

