Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB871C531D2
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 14:49:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 70C1A60A5F;
	Thu, 23 Jul 2026 14:49:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KEWyvaQZCQyN; Thu, 23 Jul 2026 14:49:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2C7C360A56
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784818177;
	bh=TNDbO+VFrKNhD2dLpiVOrhEDc8ladD3QUWlbiO0S7Yo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MGEkiuqjVqp+NCprCHwC+JNRVarXOSi9SthfHz9k0AGQVQnPE+H1wOoT7SmtDyN49
	 VddUjzlg3EJEt9VkmCqe1u998bjic4IIc3SXaDDRJX1ZBU0zoOFwnGkhFWtoFNNQF9
	 U0FQVDAIgyD8VvjkAZbs8wpan+1mgsTbVp666ElZPpyqvac4tmjp4Q3ZebZ29Bksih
	 B260w19v5s7XdDiBRV8l8ay6bReI/H2nf8d7fQA51GhFAQuSEUWqR9dY5EIOriJ4Ve
	 3eQ87jPORANIid4IFD7c0Dclof0AoWuCA4rhnc+jIM3BmpLYJeiVDMs2UdHWWkl9CN
	 X5L3wkm8OetgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2C7C360A56;
	Thu, 23 Jul 2026 14:49:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7BCE8707
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 14:49:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 66CD240A09
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 14:49:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4217zxRJA9DR for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 14:49:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a2d; helo=mail-vk1-xa2d.google.com;
 envelope-from=hfranco@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3793C409C4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3793C409C4
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com
 [IPv6:2607:f8b0:4864:20::a2d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3793C409C4
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 14:49:33 +0000 (UTC)
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-5c2dbaf828eso306619e0c.0
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 07:49:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784818172; x=1785422972;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TNDbO+VFrKNhD2dLpiVOrhEDc8ladD3QUWlbiO0S7Yo=;
 b=YUezkm6CmWBRl/XvTw8yJPSe8ZYkQpTcQoHbJc567hjIQanx+dWsgdfq0off54g3j8
 TOaWyRlz+6txf3YNwCfkNwijATQOZfhMsr6HBwBXYc2agnz5xiUWXUdv1GaJ1unvm4Ub
 nZDkco2VzU/bCswRC6JAunVc6TpyofSK9oLRU/uqOcUT4vg/dgQ2/UaMFRywX0XVXvpG
 8hx/5Bx2y3tHpCyOaTPCVGqFWzXPnGZV4PcRPWW3/xuhJK/SfYyw6X7Y9R1zN2Lcdy6Z
 /QdExfCP+OZXkhdo7itfS5QFf15Se5lRaj0soAprj2G0lvDuXLfJEcbtrGql6VrR6Cb9
 4S6w==
X-Gm-Message-State: AOJu0YzACDEnKU5OLd/IqlUQk0d5VUnPocqqWQPJcWUS7jzqQqm2Us6i
 7Ufcdq+rLgj3iOOIsWUYsBgwePeJYtKRg/R9+turDwzSy59DvsAg5rJVTl5gLNMQQEE=
X-Gm-Gg: AR+sD13uOblXUmlygTPb+6+fQfiRWCasjdS9TjSZsqp7L0t3vJIQY08ePLNA2kFpgY7
 95izqd5SdPaG4ZxLauAME1BTX0LbeidrdZyshuTZ4mWvkEYAW1FbqJpLbsc4cYeYtNsi/AdH88X
 sSyhpFIM72DQsCIFQgkfmwhecjq34bmd31Ft70GGbucVrAfMamBIEw88cMOisYEk4c1oYAvUo2L
 CEGd9SU6EI2/awYfn/K/V4DjGqbBL9L5ZkGJ8NfTIaWtpbrgMKcLkRtGdmBD64sB4v7wV+BYW3i
 MVrBKQZyQvYIAQqqyG8hNZ0W8vNV18pextvFgF5jQb5C29fCfzNqfMlC+7XB+g76kl9DTn/95uw
 s98/FccWTe7weduL1L5hlpxwQ4Oj79FNwqAd81IAr8wLZwhXdzmVKCFIIOBhQHWJpfBdndjwJDh
 3oov4sdizzUAi3/75VAzv3IJw5rvUb+MRaBgZGVJ1Qcw==
X-Received: by 2002:a05:6123:6d:b0:5bf:b500:c4f4 with SMTP id
 71dfb90a1353d-5c2d9fead59mr1202987e0c.2.1784818171751; 
 Thu, 23 Jul 2026 07:49:31 -0700 (PDT)
Received: from [127.0.1.1] ([2804:14c:4c5:9534::a19c])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-9774404089fsm4739175241.3.2026.07.23.07.49.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 07:49:31 -0700 (PDT)
From: Hiago De Franco <hfranco@baylibre.com>
Date: Thu, 23 Jul 2026 11:44:34 -0300
Subject: [PATCH v2 1/2] board: sophgo: move ethernet driver to common directory
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-add-milkv-duo256m-v2-1-2e1373dbcb8d@baylibre.com>
References: <20260723-add-milkv-duo256m-v2-0-2e1373dbcb8d@baylibre.com>
In-Reply-To: <20260723-add-milkv-duo256m-v2-0-2e1373dbcb8d@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Kongyang Liu <seashell11234455@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Randolph Sheng-Kai Lin <randolph@andestech.com>, Yao Zi <me@ziyao.cc>, 
 Andreas Schwab <schwab@suse.de>, Michal Simek <michal.simek@amd.com>, 
 Martin Herren <sputnik@on-the-web.ch>, Peng Fan <peng.fan@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, u-boot@lists.denx.de
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784818172; x=1785422972;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TNDbO+VFrKNhD2dLpiVOrhEDc8ladD3QUWlbiO0S7Yo=;
 b=VOQI6hdD0QH1aAYFKOGeSzx4dMUabKGgfGOvfziEg2g8ZZJY6AG5SiKf8ezHV+WCGo
 KZ+gRcOMbxdvuWDZiMDafDkDsTaRhn7ivlnAeLv0WT+jcuN98zRj87sXY/+99dokn1zc
 4CTUz/OW0kA2sRlOVB4hWCELMDkuRmt2fQ6YENLbtuoc6nQbGQj6CDqjw+Hd4RoRiyJt
 UvcGF8RL/yIJuZTLiw0QFU5ofe4Q1e5fBz846dUj9apX4zsATUVx0fPcbaMNzQ5puUZl
 FgNqs+7oIeWFk6yhnwr5kepvXg4pyBlsyVbTw8Ni4sCAMPtQu8ibW6h1zDnMVLeYFl3c
 EZKQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=VOQI6hdD
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

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
2.53.0

