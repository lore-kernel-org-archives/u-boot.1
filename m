Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C773DCD98CC
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 14:19:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC4A58489E;
	Thu, 11 Jun 2026 16:18:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pAV5inIA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9153848A9; Thu, 11 Jun 2026 16:18:42 +0200 (CEST)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 060ED83FEC
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 16:18:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-5175b6c4e19so82758171cf.0
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 07:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781187519; x=1781792319; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=plCA8Jyt6mmOq2O0r3bcd2FhfNjBCW97kvADzTa1liM=;
 b=pAV5inIA2ez2ViSz0BivxHmKh7fH6nKGN8EkqWKnN5aMrVRTaW1WA75ORq3LFvWYPO
 FHOX62nFkYe5y3Yz5xgcWykrHdSzHOsLG9Zcsb5yV6vXGp4P0qtFa4FNYGzH8fFHdIoF
 2S4J5mJhsnkz83gw/BtVEHw+D5PiXWBhRHwDiG+yObtH9zdx0X8l1gZL2eXK3K3ImRRJ
 edGx+NPj/Ri8CtIPy7Xy+5Ctop+7seZ3pd+WJB8Be8WxxsHQScmY8Fl301ixVVj6zbM+
 XUax7PR/0mWInmkHCOFQCq/NGS/iGl+dRq5OKSvqcEyt4AhEIsmjSQLp0QDvVX0fHEd1
 CuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781187519; x=1781792319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=plCA8Jyt6mmOq2O0r3bcd2FhfNjBCW97kvADzTa1liM=;
 b=VZ4v5WnV4WRomklYuyLUidbIewur7KQ55HtuUEtLIWdklZm6HLTn9516Wmbjk3qQ1+
 npqZfme5O+Kzh7Af7p/QFgn7IyjAu99DpqsCT2kR7A0BNBSY/DR6fkgTHmE0SPbTvyiy
 OySGVaegLZYyIptlUFqRs5blqZPgS7CNsV+qwLlWI9BIke0V62is5+FK3gEKqlX1VeX9
 P7v5JQhphUl67Hr8gWQSX05OALsnXHYtrNuYpvfaeozIESgcMSAD6DeM84PWRFKx5qFu
 RkYxwqmgAGNKP13yd0oNn3Ba4pp+FVfQkegrSAbViMibLlV9ls0m64A5Bj/1VobIKXrZ
 tkAg==
X-Gm-Message-State: AOJu0YyZk/hQeRYVBVQVeyRZdbC+3S8YDn/hN2vcIEGTh6RQweR8ai1C
 olvF+8SbHmWde68+EhwzQ/7f4wvC8HxI6UcnUwdimIffKiPiZ8tl0fIsGJT8wj13
X-Gm-Gg: Acq92OGfqsC94oj/JEt+o1CRVh+/hmRVT+OOxplGRAyBjtbjjqjgkOCuVUgSB/VleZW
 n7AVxe7Js8tZtNa97dQw2toklOvIMsT77VPYLGyd4xJz4XiZ1o0tsnZzmD7S6pkWi6OlJuzZ/7n
 mkVNHjGUV2VTLPHX/GGWTRn4DCxXDxjXmJgUN+fYFpbI/JFcwGwhKsMkXYEwAiVGTq6CHbXJTNk
 xCAvQ/XmUUl3j074cpHLmFQYkL7sRSF6hBuNKU7WtqTD4wh/+r9UgQwTY0w/XyZzvVMarDgBTus
 H9OjTBKfKf1ECUdkPAbSSxDDmCXzGj5o0jw7xSF18F3AAYRcSj1Ogy+WBg9ors/GeYVHlkFX4vy
 Z/siRFXo0739irOvg2nRiYisjiswhN1XRHWj59DmV8bekKLznrnk5WzL1iSP66XOVM+XVMThRKN
 2KbDHsi+CtMf9or5x6luINia7mN+4LV5Hu4QRSHKqy9fOZEczrtZNZWHWNZNMYN7cJHI4regJu3
 JhAVdH4VsE2U4+UVZI=
X-Received: by 2002:a05:622a:1449:b0:517:c65e:78f with SMTP id
 d75a77b69052e-517ee25b48amr45046341cf.37.1781187518662; 
 Thu, 11 Jun 2026 07:18:38 -0700 (PDT)
Received: from ubuntu.localdomain (23-91-246-209.cpe.distributel.net.
 [23.91.246.209]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-517ef67bb92sm18536031cf.27.2026.06.11.07.18.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 07:18:38 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com,
 Guodong Xu <guodong@riscstar.com>
Subject: [PATCH v3 5/9] riscv: binman: Always set default configuration in FIT
 image
Date: Thu, 11 Jun 2026 10:18:07 -0400
Message-Id: <20260611141811.68904-6-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260611141811.68904-1-raymondmaoca@gmail.com>
References: <20260611141811.68904-1-raymondmaoca@gmail.com>
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

From: Raymond Mao <raymond.mao@riscstar.com>

When CONFIG_MULTI_DTB_FIT is enabled, the FIT image contains multiple
device tree configurations for different boards. The default
configuration must be explicitly set to ensure the FIT framework
traverses all available configurations instead of falling back to
CONFIG_DEFAULT_DEVICE_TREE.

Without this default property, fit_find_config_node() will use
CONFIG_DEFAULT_DEVICE_TREE as the configuration name to match.
This prevents the SPL from correctly selecting the appropriate
DTB based on runtime board detection (e.g., from EEPROM).

Remove the conditional guard so that "default = conf-1" is always
present in the FIT image, regardless of CONFIG_MULTI_DTB_FIT.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>

---
Changes in v2:
- None.
Changes in v3:
- None.

 arch/riscv/dts/binman.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/riscv/dts/binman.dtsi b/arch/riscv/dts/binman.dtsi
index b518560bb94..84c261c6849 100644
--- a/arch/riscv/dts/binman.dtsi
+++ b/arch/riscv/dts/binman.dtsi
@@ -93,9 +93,7 @@
 
 			configurations {
 
-#ifndef CONFIG_MULTI_DTB_FIT
 				default = "conf-1";
-#endif
 
 #if !defined(CONFIG_OF_BOARD) || defined(CONFIG_MULTI_DTB_FIT)
 				@conf-SEQ {
-- 
2.25.1

