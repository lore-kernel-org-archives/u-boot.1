Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C49C3064D
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 16:03:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 825ED884DD;
	Wed, 26 Jun 2024 18:00:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G7r49Cll";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAD48884DD; Wed, 26 Jun 2024 18:00:24 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6C008859B
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 18:00:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-52ce6a9fd5cso3568550e87.3
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 09:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719417622; x=1720022422; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CiMow7s4j2CsLyjXWJPRpZ4yYDVro6zP4w6YhlUwuAw=;
 b=G7r49CllzDwYuBqxyMZtPYm0nglKDndwjfNld4YjMKMp8Xxl9rBwF+oPc1ZuhD72lE
 FwD01Cr+gvuE5kPIVRyn4uACh68eKoaLmIfPLJk2RL2g0oJUjaMZ79oyIpnvj6MO23mH
 M74yMGERnKfXYr60c5FcWrNf3dNskxvISAXts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719417622; x=1720022422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CiMow7s4j2CsLyjXWJPRpZ4yYDVro6zP4w6YhlUwuAw=;
 b=aL+VVYGP4jqyohFpJTvPAddegk/IaSOyZBB6zCYn9noUFpb+IacZjfiQaSrz1yXtEe
 p0KVuJH3go1x6oC2o/y34kwxyyzkCxbpxfwH1wru1hHHS/DYbFZFhh379YQ9uHXDeYfV
 cM656zKXQ9afeDNUAasQIshJ6h3G4Dr1pTDZ8gzR75HZZkF2hm/o2SIRaAL49V/YDo7J
 kPdmncn12hbRWaCbNVB61vkmQdg3o25b1EtDX6QVAnOrCD3ZT9uuKLE89Uee7CrFikRF
 L8tYwZ6uOzuTcIG1AHDsgIHvY2QZFcs164ENk8r9YQ9gthTWVZSthTaO6KKQLUN85goA
 6lNw==
X-Gm-Message-State: AOJu0YyvhUiWuVN0piW1YQMyip7jiIIu6DR74AMSueigowvN/q3ktLVD
 6scIi+0mhL6ANxdT2+Crv3XXIUt3M3fmg7ERQ/6PaFWlLDoF2AJA3C7MdM4UdMZTphxjhjsWGwx
 fJw==
X-Google-Smtp-Source: AGHT+IEGuGUJukKRfsWXRddDurJE7ed8OZOS1hGM8e/vnkx353vqtBlM6nNHn7qdYMn/Mt3IP/AUsA==
X-Received: by 2002:a05:6512:ba1:b0:52c:dd38:f3a3 with SMTP id
 2adb3069b0e04-52ce185cf4amr8875199e87.46.1719417619667; 
 Wed, 26 Jun 2024 09:00:19 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c827507bsm30753715e9.22.2024.06.26.09.00.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 09:00:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>, huang lin <hl@rock-chips.com>
Subject: [PATCH v5 15/16] rockchip: bob: kevin: Disable dcache in SPL
Date: Wed, 26 Jun 2024 16:59:44 +0100
Message-Id: <20240626155945.278640-16-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626155945.278640-1-sjg@chromium.org>
References: <20240626155945.278640-1-sjg@chromium.org>
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

