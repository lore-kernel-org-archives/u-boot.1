Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3232C25B7C
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 23:39:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD34D888C6;
	Thu, 23 May 2024 01:32:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wysd/7B9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C443188828; Thu, 23 May 2024 01:32:15 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E7AF884E5
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 01:32:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5b277a61f6fso594251eaf.1
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716420731; x=1717025531; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2jMeGLO1IlJDYqTIdTf9GhLx78Z2YsLiJBjEhU1B4nI=;
 b=wysd/7B9N4klmH+fNIbYKzpflAfD5+WQ+x/Efc7Kirxp5SQb11zpSL3wlxx0NOVlhk
 /dJM+U0/UFZZXxSln6litJrO+lGzFMUZ9t5/BZUGH4Gpuz8yYTEmNi0WWq0tyuWU7geT
 751c2kE+fu8XEYu0o3np5+d9OmO47r7Bu/203DlKcay1KYCAVu891Zz2y6AfckqjhZwF
 VoJsTPapLkOVegsg9bCgGGJFkMWc0BMhqvYmXlq1Z6+lSMm3ySzu2mDb82VgnBFjExWJ
 +fh44xt1ZmoseTkAn5ppgjaCRZJSPs2Dct+FYoHsLArh2nN3ghSFnxHqXJ0bkhIiKB41
 eX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716420731; x=1717025531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2jMeGLO1IlJDYqTIdTf9GhLx78Z2YsLiJBjEhU1B4nI=;
 b=g+PFg+OUhb6IYpduB657XKXkLyirJ4b3xzQiWknLYcL15mlcGuZKBw5N7SWh40H3UI
 0Kjz2nulqobm/oq5Bb6xB4NLQN0t11heBpug+MFuxIw4d0BSl6Fo018zODwlECApoBdr
 goa9Hyf6JCmyrDXv7/oGHxr4mj1RoTkVB/LAFpFoWoLA2SeCL8ZhQjkjuZ3C1yCWvQAT
 uNSEyDvC0Izd7L4khqrdQD98yK8ZDEUx/v/ZeNHTpHq/SZivCaoFikaVpoUrAN4dAYA+
 x5qpqnG0LwhFnZoygsC5Ulqwbba3/yVZvLhVSoA1cwuZwADob9CajDtki2oUU92yJv0T
 HFDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeml3Z/oDuBv3J3Y8UYsIMPjE7VhNnj2I1ofPK5pGIMNby8HlR0G5fqAkc1pwwPSYgZkQHjjydJdmvObO+IxpU4/4umg==
X-Gm-Message-State: AOJu0Yz+VjXfw6GzTw/B0a91ccz7XSWi1YSfx2wdcP5t58avGEej1KKD
 duhZdkKvHGgXz0tRo6xbXjodHj6faHkcMbJMbszAS3RvfcIGNd4nd4XxDDM1Eqs=
X-Google-Smtp-Source: AGHT+IGl7momDsZvYvb0gLAgL+MLreue5xORpi2SUFtH6Xjpw+0NMGa9HzrsCe3t5hEVFG4CpiShgQ==
X-Received: by 2002:a05:6820:61c:b0:5af:2f93:47de with SMTP id
 006d021491bc7-5b7f977ff08mr415591eaf.0.1716420730913; 
 Wed, 22 May 2024 16:32:10 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5b29463e7d3sm5512638eaf.13.2024.05.22.16.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 16:32:10 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH 42/42] doc: samsung: Mention enabled eMMC in E850-96 board doc
Date: Wed, 22 May 2024 18:31:35 -0500
Message-Id: <20240522233135.26835-43-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240522233135.26835-1-semen.protsenko@linaro.org>
References: <20240522233135.26835-1-semen.protsenko@linaro.org>
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

eMMC is enabled on E850-96 board now. Mention that in the board
documentation.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 doc/board/samsung/e850-96.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/doc/board/samsung/e850-96.rst b/doc/board/samsung/e850-96.rst
index 0cb95473e536..0a7b6fc0c9dd 100644
--- a/doc/board/samsung/e850-96.rst
+++ b/doc/board/samsung/e850-96.rst
@@ -47,12 +47,13 @@ Build Procedure
 ---------------
 
 .. warning::
-  At the moment both eMMC and USB features are not enabled in U-Boot. Flashing
+  At the moment USB is not enabled in U-Boot for this board. Although eMMC is
+  enabled, you won't be able to flash images over USB (fastboot). So flashing
   U-Boot binary **WILL** effectively brick your board. The ``dltool`` [8]_ can
   be used then to perform USB boot and flash LittleKernel bootloader binary [7]_
   to unbrick and revive the board. Flashing U-Boot binary might be helpful for
   developers or anybody who want to check current state of U-Boot enablement on
-  E850-96 (which is mostly serial console and related blocks).
+  E850-96 (which is mostly serial console, eMMC and related blocks).
 
 Build U-Boot binary from source code (using AArch64 baremetal GCC toolchain):
 
-- 
2.39.2

