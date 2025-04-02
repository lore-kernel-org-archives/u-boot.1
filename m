Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D15C36017
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 14:28:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C324181703;
	Wed,  2 Apr 2025 16:28:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wOc+TiUL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05A0B81F28; Wed,  2 Apr 2025 16:28:23 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1B3380FDA
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 16:28:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cf848528aso58310755e9.2
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 07:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743604100; x=1744208900; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NQtJoYTY6LKlcnOYNQA2I5xrhPk6JQU8CVPlDVh3F+0=;
 b=wOc+TiUL6SrVVgDduHN6ZRANNH/WQG0e3X8I71NOZVG3r+c3k6VxzXI/GB+5iPLACA
 T1uNyl1KJGXh1A0HzgghaJB3DqT04cxZlVZwfPUk2lKbOS14DFtzF8GJmsSf6XESz+dg
 pWlpDPPeIpP4dSIkC6cPGY2wBZYDtO/kVDx4XnvCLrp1oABeLR5aXH5VeAZ3U1vgX61N
 pGCz0SICQavRUKw09pRrMQowt/RBIFCMVZwV+YfnwaBVgl6L1kvKQffCx8Cht/9p6QwX
 pbHSj4fE/W0RNyhwRj1aco1fwtPlVUMwJbAqpFxIb22mbJxUlybb7taWcKPTF6LgWqPk
 u3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743604100; x=1744208900;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NQtJoYTY6LKlcnOYNQA2I5xrhPk6JQU8CVPlDVh3F+0=;
 b=WSkYiuquKND23Skgy6KgQ17iZ4LzpN0bC0DYrPhAnKxP26xVxbg2wwPKehSvOrKq9B
 XhpP2yUJmNAvwII/1n6SRThccewRji9N3FeZEuiG7HlEVCTkhdUcTHRrn/m9Jmo5zwOe
 WUa1XlxnlZ6o9XZPACVPeYPUk84JNrKYQ1LKCFDs6sQ31/r+y7LolfXdseU/xLRS/HKn
 m0HxUlRAzd2e71xCP3atkWpqYk5IjEKmZr2UPg3ck1O1epJoxsjLIMjl+fNCy1hlJjH3
 rBhBJrXW//WztaZ5GquvpdETKKH+APGFvEaIn2sTkM39XHPxdyynky14hgBxcPgUb4pA
 nCUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWP0iuDLCu3Bp3MTC5Ac44ju+EDi6mo7F/SfUWaHxQb18Xj7r0BTdIvbtTWFO0pNqFsc8XU/zk=@lists.denx.de
X-Gm-Message-State: AOJu0YzlIix/wb5I1l+4xLZZOuYlM+FTSyXCFF3QXjk9uHbNsye9aGVh
 xA6F7dtkVYF1h5Bm7r2Z/WPQf3pGZ+EAEJNARHCvRZj7DNCkepAR5FmAqzXmCwM=
X-Gm-Gg: ASbGncsO3+nTGRbeUc4JYaWc0EVIkyvL1XDYkwOm0utv21mSd1JCEvgMccSvM1Q0sDp
 ev3b5Ng5DZjyefPXhL1sHyuaSrsS8UoCOq17xFHcK9ThBPfiF3azRgWlzJ1bkJVtSlYY5P5DjLt
 ++vsKrzDATTM2Rb/nYvwU7eNF1YqbazuouG6X24fXdnCQRvBrC+PulO/lyXZSev0rIoOXgQxzic
 EXD+GbdSW5/jKaAFx5qXH5gBUL2fbhjpXo6Wc6DAHre6wHsdXNvT5GkbMzHO/nVjxS7mOHbblyr
 ZNjKbtW64lCCct2E4uRJPlaEyFnRG3XPaU8OjqKQ2qZh0Nv60z23nSpjuixWBgZJDnZHa7launE
 bRn6sYV3qy8FrprQaRpQ1Ww==
X-Google-Smtp-Source: AGHT+IEP6/01LF42eiQfsTeAaM5kZWX+fgMuaXSXkVLCz3tzwn7zEM2r4rUCXUwhvxf72MvjuGz9iA==
X-Received: by 2002:a05:6000:1acf:b0:38f:6287:6474 with SMTP id
 ffacd0b85a97d-39c29752f9cmr2495891f8f.15.1743604100297; 
 Wed, 02 Apr 2025 07:28:20 -0700 (PDT)
Received: from lion.tail248178.ts.net (163-60-142-46.pool.kielnet.net.
 [46.142.60.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c266c132fsm4371694f8f.13.2025.04.02.07.28.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 07:28:19 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io,
	u-boot@lists.denx.de
Subject: [PATCH] hmibsc_defconfig: disable DM_USB_GADGET
Date: Wed,  2 Apr 2025 16:28:03 +0200
Message-ID: <20250402142812.368168-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.48.1
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

As with the db410c this breaks linking as it conflicts with the USB
controller used by these platforms.

This fixes building after DM_USB_GADGET was enabled by default for
mach-snapdragon.

Fixes: 7235dbedfce3 (mach-snapdragon: enable DM_USB_GADGET by default)
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 configs/hmibsc_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/hmibsc_defconfig b/configs/hmibsc_defconfig
index 88c9c70a6399..4550eba71ab2 100644
--- a/configs/hmibsc_defconfig
+++ b/configs/hmibsc_defconfig
@@ -69,8 +69,9 @@ CONFIG_DM_PMIC=y
 CONFIG_PMIC_QCOM=y
 CONFIG_MSM_SERIAL=y
 CONFIG_SPMI_MSM=y
 CONFIG_USB=y
+# CONFIG_DM_USB_GADGET is not set
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_MSM=y
 CONFIG_USB_ULPI_VIEWPORT=y
 CONFIG_USB_ULPI=y
-- 
2.48.1

