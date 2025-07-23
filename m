Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A04C83F1A
	for <u-boot@archiver.kernel.org>; Wed, 23 Jul 2025 13:46:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBE4E834B4;
	Wed, 23 Jul 2025 15:46:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mQnGztg1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F61083477; Wed, 23 Jul 2025 15:46:12 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC58882BA1
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 15:46:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-748e63d4b05so4011202b3a.2
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 06:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753278368; x=1753883168; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7Cbtm/hxxLEvZ/tTe9F4B1EcFih8dQe5+vIr2xN5uSM=;
 b=mQnGztg1+I7kC8b5tG7+KajhtZlqYWR/MEW8U4NOzjJMrG/T+M6F1FroyNPgMrTinH
 Y9AWNuVxODF0sLCKzaaJw05dgv8j+ALtgy0BNFkrzi25K4IfDtvg44OxVAPMjncZgMc4
 zf3dRnz+cB6EYCCOUNDu6a2ooHyZJIWYWW8gWtA25sDLMv9M/tCgOoNaAOfZv/D7AWN+
 bZy0fgoWZ9rqg/EBPork+dfWgcW5MbO7iyThnFKNBiU3CPb7ZkYJl7BmaEFAEwQ6p8zs
 NMj0Gd7YM6+djrxgnEJGTtU8+N+g98UZm71UZNMbzIPLvQs2/6JQHOySDVIvdq4cjo6r
 H9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753278368; x=1753883168;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7Cbtm/hxxLEvZ/tTe9F4B1EcFih8dQe5+vIr2xN5uSM=;
 b=DpGwYImJaoLv49z+fBe5doZAhWTmK45EPApt3LcK5/7ogq47TwCmOt2qWouQJGxAu1
 zgnqzuauDSjLnhB8yv3xlHvdmyGPMlhK9yjmyIcrKrFrsQK3gCsOA/ZCRwX6Hx1afhLU
 C2zDYduOymJKbKLHoFy3awxXajBv6dp5qhN5w9+1UygWFWn/MGOMGVsp7bqW9VIGt9rJ
 EqDd3aktevVzr+ITDq0lE3tA6iZSACzvLCzHI0B2UzFy+dMSvandXT43PIV+GxSX6hKH
 eVptgXP5qU/814XjwPAnCOD9WCx571VtPgJeEXcWRB7fx5EorvqkeuwGbnnQUsxitrwk
 iiTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBFx6mw7s36QaQTIXLiCJNCybm/Z+1gX/v5qCGx+0FlJNATZeg+IKSQeRn8STViB92Bs+cDQU=@lists.denx.de
X-Gm-Message-State: AOJu0YyqwSmFCLyxrgVt8HzC9nnhs/D6pMh5m5AQIxFMbsy+bZmC5fiR
 kbvil9dp5hxNK72spmlayY5C0SZzh3nnoHL+FGmXTZX+cXU5v6AT8V7V
X-Gm-Gg: ASbGncv/wIbvHQP30Uw6GUnTgcwbY5/SXxLFDHdjE45D36P9+197ABAXvTbj0RmYi1h
 oME22dDMJP1xaSGbNfpk+NzUcE6j+Hz441mnoJ/1FYjOybqswZiW3ETLuQQjLRLswlQDwrqu0IU
 c+VQMsVhd/ZcTN9dy7H2Sp4I1ZKKoIJ6LgsjjIxdeHPQd3Cn1e9tv/Jv2hMKhZcWtl8Wpup0ry8
 HUBadx8UeTTfhIdsEP+hiXXappzaxIZuHO0Uj4qmInNURLe7CyfxAQ/kVcml0zk/Y0IrPXNDBy/
 c+ZUp3NCqZIZFmSQeXSz082aVFFt2acMCx/hG4bzbW4L1HHScL1DPtEIRTqlE0FZZ9NHcgs8Ug2
 PHKlZwhdvJnHEtvuYcIPH4ZHDlngNDyWnZUp+
X-Google-Smtp-Source: AGHT+IEwJ0C48YOJo+AkqWhOGHXlkJAcqLwuwGuS//ydPTvjFDCW2GJWViNG0o5J6rILxev12Xe9jg==
X-Received: by 2002:a05:6a20:12d5:b0:220:b161:431 with SMTP id
 adf61e73a8af0-23d48fe3850mr4834809637.7.1753278368309; 
 Wed, 23 Jul 2025 06:46:08 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:db41:d59a:1994:977c])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3f3c999588sm7154595a12.66.2025.07.23.06.46.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 06:46:07 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: peng.fan@nxp.com
Cc: trini@konsulko.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/3] imx93_evk: Fix the board name in MAINTAINERS title
Date: Wed, 23 Jul 2025 10:45:55 -0300
Message-Id: <20250723134557.1972331-1-festevam@gmail.com>
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

The board name is "i.MX93 EVK", not "MEK".

Fix it accordingly.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 board/freescale/imx93_evk/MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/freescale/imx93_evk/MAINTAINERS b/board/freescale/imx93_evk/MAINTAINERS
index 34ba278fcdfd..eb6e669bd17e 100644
--- a/board/freescale/imx93_evk/MAINTAINERS
+++ b/board/freescale/imx93_evk/MAINTAINERS
@@ -1,4 +1,4 @@
-i.MX93 MEK BOARD
+i.MX93 EVK BOARD
 M:	Peng Fan <peng.fan@nxp.com>
 S:	Maintained
 F:	board/freescale/imx93_evk/
-- 
2.34.1

