Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F35C83F27
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 05:00:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC41E83020;
	Mon, 21 Jul 2025 07:00:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H0ciJT4t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEB258303B; Sun, 20 Jul 2025 22:36:02 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AE8E82D06
 for <u-boot@lists.denx.de>; Sun, 20 Jul 2025 22:36:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ag.dev.uboot@gmail.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a6f2c6715fso2967482f8f.1
 for <u-boot@lists.denx.de>; Sun, 20 Jul 2025 13:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753043760; x=1753648560; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1qQLZ+6G9S7Lv/sfGbwTTQQHLiXVaThfvPe01li/pZY=;
 b=H0ciJT4tS8rBSd6ouzGgCSfhqohWLrGlwvCorFEh4xhLETvl8TYidl1r9x59wsdqa9
 p5gXpbLun6/0K6h8k3mYA1zo3CwdRF/wThmGbU5bK7m2gIi91pxtZMja9+jPS3CwETJi
 b12SErUVKrm8fnbGo1JZVOsyx2jHzpRC33fTIdOdoFGA9+g/Q7mPpDczCS1VL1oiM1rP
 HjLOuRg7EGSJX0J5oGfiWzvfVqQpHsAcFs3AtswbXL+lC2Xo04LHtU404ggt6Zy78zaO
 6CD729bzKccoGVo/SRyF5YMP2x4EOr9LDO5/cec+C/ch+e+Kg5sIs9vdCZU/dKiJkk9G
 OqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753043760; x=1753648560;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1qQLZ+6G9S7Lv/sfGbwTTQQHLiXVaThfvPe01li/pZY=;
 b=tLa9gJ0cdQgYt8sVCFpey5NBo0yBDZj4O6SWaoMAz0ySFThgyJsf3gFmoVQ4njlAAK
 vgA0dCgFk9F6yAH7d3zy6wRxtoZvwhn+A2IU8TLvJRD4gnIoZcHMhwRWZRgvCpuJySsu
 vg1850cRD3LKfMeKiT3KJPt1BNfQuDIeLH+if+cKImEkQbLc1tm7awszcSHoCEJ2Rkxh
 XtyMsheQfNmihJeJIdiIIy1waeSBUMw/kbE9TmsvSGP8/OkrbZZS+epI8PlqlUTR1hmk
 nNwciOjqaku7xOmUJq4+qUltqxop9k7p9GZK+KxT1M98fDKGDqEZiM8Gtb3VdZ/ERKF9
 2ePw==
X-Gm-Message-State: AOJu0YxvjEd6LR60O87tpFa8nIehnSV9RL7t8cymZr7RqnLooCyKIUwD
 iqJI/S89M216RW9qSmG1hEmVpdBeJcOWzetYxys/Kmf1aZU9VGG7TNB43/d9PpkY
X-Gm-Gg: ASbGncuUockN2UiLw0Uuvl3Fzemvcw5NjDFT71tKRbcDmb+1asgaHT41d1GqNh40uZ/
 ouoT2GeaWLt1CeVYj+jCKQV4UjVoX/HYA6Kpn/kQxeD5FjquWj0yXQokvhL2HpiHQ5cGNAQVcqn
 7B+29G0dn4wF4EnBHQL1FJIUFlWfhw6IsTq/bQMsYYV/ouGLj4TBwQuP1+U5VTCZG4ehbFzG79w
 gmU+LLcYIx/EFYbD5FGjzTB8t5tVZna7RwlPqBx7K9rYP6z3U7KFjAkQIkint3YOQ8jU0cPVV9v
 tGg06r7rjXN6oRW0QY4XFVjLlkpS2qs3uv6kS5uV2NZuKGKR0SXaE5460s/5av9UbJvzFpELK8T
 kjCpFK5T8NZuMADV2kqbEJQ1nYVrP/6Rbm/YBa5WEqcPw/6ew5tY=
X-Google-Smtp-Source: AGHT+IH/gnTHmqwnizfyFjmL7vjbsudibWXCTMDWmshiCYO3FYeoyH9mLdZx7AH6NqerBifhuYCe5A==
X-Received: by 2002:a05:6000:4619:b0:3a4:fc07:f453 with SMTP id
 ffacd0b85a97d-3b60e4b8592mr12317503f8f.8.1753043759696; 
 Sun, 20 Jul 2025 13:35:59 -0700 (PDT)
Received: from crub.agik.hopto.org (pd95f1e66.dip0.t-ipconnect.de.
 [217.95.30.102]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4563b5a4253sm82857845e9.3.2025.07.20.13.35.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Jul 2025 13:35:59 -0700 (PDT)
From: Anatolij Gustschin <ag.dev.uboot@gmail.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
Subject: [PATCH] MAINTAINERS: Update email of Anatolij Gustschin
Date: Sun, 20 Jul 2025 22:35:58 +0200
Message-Id: <20250720203558.2278842-1-ag.dev.uboot@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 21 Jul 2025 07:00:49 +0200
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

Use new email for community work. Also remove my
capricorn SoM maintainer entry since I do not
have access to this hardware anymore.

Signed-off-by: Anatolij Gustschin <ag.dev.uboot@gmail.com>
---
 MAINTAINERS                         | 2 +-
 board/siemens/capricorn/MAINTAINERS | 1 -
 board/terasic/de1-soc/MAINTAINERS   | 2 +-
 doc/git-mailrc                      | 2 +-
 4 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ce7f7e03505..f914fc54f54 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1865,7 +1865,7 @@ F:	common/spl_reloc.c
 F:	include/vbe.h
 
 VIDEO
-M:	Anatolij Gustschin <agust@denx.de>
+M:	Anatolij Gustschin <ag.dev.uboot@gmail.com>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-video.git
 F:	drivers/video/
diff --git a/board/siemens/capricorn/MAINTAINERS b/board/siemens/capricorn/MAINTAINERS
index 3b4bd64dd00..9c8c7a6ecdc 100644
--- a/board/siemens/capricorn/MAINTAINERS
+++ b/board/siemens/capricorn/MAINTAINERS
@@ -1,6 +1,5 @@
 CAPRICORN BOARD
 M:	Alexander Sverdlin <alexander.sverdlin@siemens.com>
-M:	Anatolij Gustschin <agust@denx.de>
 M:	Heiko Schocher <hs@denx.de>
 M:	Walter Schweizer <walter.schweizer@siemens.com>
 S:	Maintained
diff --git a/board/terasic/de1-soc/MAINTAINERS b/board/terasic/de1-soc/MAINTAINERS
index 1e726e93603..6e7eee9c3e3 100644
--- a/board/terasic/de1-soc/MAINTAINERS
+++ b/board/terasic/de1-soc/MAINTAINERS
@@ -1,5 +1,5 @@
 DE1-SoC BOARD
-M:	Anatolij Gustschin <agust@denx.de>
+M:	Anatolij Gustschin <ag.dev.uboot@gmail.com>
 S:	Maintained
 F:	board/terasic/de1-soc/
 F:	include/configs/socfpga_de1_soc.h
diff --git a/doc/git-mailrc b/doc/git-mailrc
index 1982785f60e..747ceda3307 100644
--- a/doc/git-mailrc
+++ b/doc/git-mailrc
@@ -13,7 +13,7 @@ alias u-boot uboot
 alias abiessmann     Andreas Bießmann <andreas@biessmann.org>
 alias abrodkin       Alexey Brodkin <alexey.brodkin@synopsys.com>
 alias afleming       Andy Fleming <afleming@gmail.com>
-alias ag             Anatolij Gustschin <agust@denx.de>
+alias ag             Anatolij Gustschin <ag.dev.uboot@gmail.com>
 alias agraf          Alexander Graf <agraf@csgraf.de>
 alias alexnemirovsky Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
 alias alisonwang     Alison Wang <alison.wang@nxp.com>
-- 
2.25.1

