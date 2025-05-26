Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98BEC5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 10:19:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CC3D837FC;
	Mon, 26 May 2025 12:16:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V/wt6JjU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 205C5837FC; Mon, 26 May 2025 12:16:39 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 083C682B19
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 12:16:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3dc7294716cso19171335ab.2
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 03:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748254595; x=1748859395; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PeJBKL3nla9T56Me/+0hcxchUVY/x7aWt+q6cEB+zyw=;
 b=V/wt6JjUB2p1CYN0nmmNRdFxfvMAbbDQJRA3qJXCzX0wnaZWHNskwE9E7MKYj3mUsI
 R8zoII4/2UheUC2eqaX3NPEb7wN2TzxFqiiBXUKYt+FFDQXxMBkhk6v2ihkoAFIoOHye
 9JkES5QLiArOgaEvyrXr3PNEYaT02o/n7/AWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748254595; x=1748859395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PeJBKL3nla9T56Me/+0hcxchUVY/x7aWt+q6cEB+zyw=;
 b=ahY/iX+msBANHgrYCpDTzT7XrVeZOUuMvJtOOXNNUysYiyzwuvLphsrnbaqI+DKf3s
 hLDyubTqoocJdJdoDpeq3iw1givChyATs0fhobPRef13NWGwy0bKTxfZQox66+RXdO/N
 j84+C4xVF1Nq7+tAaxegY9cxI18VoIIY/6RPSnDmL6iFdEez9ke/BuJrFQv8XBg5UQ9b
 zeYuR5U5vZsmDSm0bXZcgR11jdSLujypqeUB7qSGjrh3uaYqf5hZxarAhJjImeX4urCn
 mXy2kMWDJ9WHBe85wH9mDp9qemXw7n900ykUQeWCIXMFzgz0J2nWzu3eo+YQKk6IeIJE
 tpMQ==
X-Gm-Message-State: AOJu0Yw2tHmJrLnPMjt28wtKsR/wGCsx1C8IGwHPHyvIYvQhxCd9tCzf
 CQ6pxHDWB10R4sCeUhh/SK6ucMx0PWMJ8gVPe9TBFhbCX3ZeA+OFnpvMY8fYf7+kqa0JfKpmiPf
 lsV/i0ykx
X-Gm-Gg: ASbGnctdyohilUoXUMXpoWabzx1v1Jh2o6YOfi1dj/R8rriey3KTCgXv5gDocMuhSNz
 LuVT/ddTsCNGA7MoZL6tXDhorHEoOk7RjL1RAy5TbLicFmq3jk/jNziEG86esfZMVgfxVdFHEFw
 iqa4bzZKu+88Doc3qTsyOkpH4ajuDHsN3idHaEnEcYeYJ50magQfGO5zN7uaeX/UJayGoK0wuqQ
 lxD4JRg3F93CqcZwBl1A+pRmAXa7IcW6JJ/qSM7b0hKqoJqH0cP3OC4I4hiLI2DIA3Kchkil3ZZ
 9pjqD9dgBZOkN0aQfs0YCSRg851TSVfgyjAbFrfTPlLRhBtGqFxk3QkbyRtCwNUJmSDUj6loUgE
 uFncSzeyjzzMg
X-Google-Smtp-Source: AGHT+IGwr6F30dhxsNWE3dixT6CXWRoA6vS0Ri32MoHgK1YpqOyGhbsEoGahwt3aTj15AsCBIHzTRA==
X-Received: by 2002:a05:6e02:19cb:b0:3dc:80e6:3819 with SMTP id
 e9e14a558f8ab-3dc9b754f6amr81352205ab.22.1748254594244; 
 Mon, 26 May 2025 03:16:34 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fbcc3b19aasm4679249173.52.2025.05.26.03.16.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 03:16:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heiko Stuebner <heiko@sntech.de>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sebastian Kropatsch <seb-dev@mail.de>, Tom Rini <trini@konsulko.com>,
 Xuhui Lin <xuhui.lin@rock-chips.com>, huang lin <hl@rock-chips.com>
Subject: [PATCH v5 18/25] rockchip: Add documentation for VBE
Date: Mon, 26 May 2025 04:15:04 -0600
Message-ID: <20250526101541.3254628-19-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250526101541.3254628-1-sjg@chromium.org>
References: <20250526101541.3254628-1-sjg@chromium.org>
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

Now that VBE is running at a basic level on rk3399, add mention of it in
the documentation.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 doc/board/rockchip/rockchip.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index b88299cbba2..cf983c91bd9 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -519,6 +519,19 @@ config-flash.ini:
         [OUTPUT]
         PATH=RK30xxLoader_uboot.bin
 
+Verified Boot for Embedded (VBE)
+--------------------------------
+
+VBE is supported on rk3399 at present, with SDRAM being set up in SPL. The full
+A/B/recovery flow is supported in U-Boot.
+
+To build this, use the rk3399-generic board, setting CONFIG_OF_LIST to the list
+of boards you want to support. All boards must use the same SDRAM type.
+
+VBE uses internal SRAM (IRAM) for the TPL, VPL and early SPL phases. The stack
+stop is near the top of this (0xff8eff00) with the 256-byte bloblist immediately
+following.
+
 TODO
 ----
 
-- 
2.43.0

