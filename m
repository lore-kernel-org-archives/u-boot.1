Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D6DC2BA18
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 17:56:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 387718859C;
	Sun, 23 Jun 2024 19:53:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b+m7gSCm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7F588837A; Sun, 23 Jun 2024 19:53:33 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C443F884B2
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 19:53:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3762eadd807so10239275ab.1
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 10:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719165210; x=1719770010; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CiMow7s4j2CsLyjXWJPRpZ4yYDVro6zP4w6YhlUwuAw=;
 b=b+m7gSCm7gNyKIFVUPsVyq3TIUhlXvFrfOfpz3acPGTuGz8ZpmGRFEiH+YW4+lT5a4
 wxOCHRMbYZIUOtauN3YhFG8uB0NWSTWERhF0KtkoWkwOPt580L1cnuKKbNYQIMXYVeoU
 kZUa2D0mmOPluuzVKwQnBsU19oOY2Jm3DCcBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719165210; x=1719770010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CiMow7s4j2CsLyjXWJPRpZ4yYDVro6zP4w6YhlUwuAw=;
 b=EO4oxj5V5kF0hw7rGQckKoznopJ2NM1O/OcZKtGLOOfT1poJ82FdSFlEElkk6fmFWM
 cZ802FGWnfBK9Cov/xh7i1A6NBdNq17Sgf5bV8xYQuHdyNxm7Ib45FQSQuf7alXBXbgz
 IcMIermNIYxz+2uY8NlnJP9NmRBwAVJWYSrr2D3A+T1zq/Gg77l6obXJUGzsOqn9VSV1
 ip8FhaySzDwNa0An/QcCzgdl4M0cB4+u0+TtXZmo3I2aKubnbhEMvLpofxsiYU8pIJeU
 Q5Ef4ivxXn6AnMw6H3TFmoaY416jf3MJQmV58G85szeBnoksp6mlAxr2xR4lnO43iDja
 2jIg==
X-Gm-Message-State: AOJu0YyegRr0dOIwTAXb2j9Fsz3eIS/ze9/+yvAJIsAX8ECSmlVK46zs
 Y1+6j/2DFjwTQ2tL8uQalw46hLfKe9a275OC04UBQHyXUtuMjQdWPdSli5A8AzsSAJYTBpxrW9l
 Tcw==
X-Google-Smtp-Source: AGHT+IFbCex4h4YuKZ3ghnPn81SNf6CA2nHRBvaA/Z7NtAVX9HgUlTje81zDnijcVkN//ab6m/07Qg==
X-Received: by 2002:a05:6e02:144c:b0:375:86c9:9ec9 with SMTP id
 e9e14a558f8ab-3763f5b7c7dmr40137175ab.11.1719165210434; 
 Sun, 23 Jun 2024 10:53:30 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d113ff85sm1636834173.81.2024.06.23.10.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 10:53:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, huang lin <hl@rock-chips.com>
Subject: [PATCH v4 15/16] rockchip: bob: kevin: Disable dcache in SPL
Date: Sun, 23 Jun 2024 11:53:01 -0600
Message-Id: <20240623175302.1463973-16-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623175302.1463973-1-sjg@chromium.org>
References: <20240623175302.1463973-1-sjg@chromium.org>
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

This causes a hang, so disable it. Unfortunately the RAM-size fix does
not resolve the problem and I am unsure what is wrong. As soon as the
cache is enabled the board appears to hang.

Fixes: 6d8cdfd1536 ("rockchip: spl: Enable caches to speed up checksum validation")

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 configs/chromebook_bob_defconfig   | 1 +
 configs/chromebook_kevin_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/chromebook_bob_defconfig b/configs/chromebook_bob_defconfig
index acfe3934104..b2ecfa6050c 100644
--- a/configs/chromebook_bob_defconfig
+++ b/configs/chromebook_bob_defconfig
@@ -1,5 +1,6 @@
 CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_SPL_SYS_DCACHE_OFF=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00200000
diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
index 95fdb418d82..da748e4f022 100644
--- a/configs/chromebook_kevin_defconfig
+++ b/configs/chromebook_kevin_defconfig
@@ -2,6 +2,7 @@ CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
+CONFIG_SPL_SYS_DCACHE_OFF=y
 CONFIG_TEXT_BASE=0x00200000
 CONFIG_SPL_GPIO=y
 CONFIG_NR_DRAM_BANKS=1
-- 
2.34.1

