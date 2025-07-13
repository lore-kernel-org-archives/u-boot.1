Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB12C83F1D
	for <u-boot@archiver.kernel.org>; Sun, 13 Jul 2025 01:11:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D72F808AF;
	Sun, 13 Jul 2025 03:11:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q8k6Kz6R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29F1A81D6A; Sun, 13 Jul 2025 02:28:06 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8F42805D7
 for <u-boot@lists.denx.de>; Sun, 13 Jul 2025 02:28:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ejona86@gmail.com
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-74b52bf417cso2115222b3a.0
 for <u-boot@lists.denx.de>; Sat, 12 Jul 2025 17:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752366479; x=1752971279; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=v489dALDnIb1k2yEBaE9gOUk0jyGXWz/c/CxRrFDdmc=;
 b=Q8k6Kz6RGK6F5ePZU9lgW3I7P4btNGb4zaY2pAXKvFSjwZ902uv6AtcpX3wKm7P3qL
 QkmVxqfN8e/ZoBmC+xnFmDscDzQRleJf4+aSPgsRlQHwLmdbZkk0WK4mL2MV2g8+bKEO
 HQGLb9A+enh1/K4DpWVhK3LwBoLfpfl74jRATd6pwPqODopo5o5VD1FI67xOpliKVXZw
 VgkDGncjU5/zsjD/6HO3XkMFAwmwFKXhp6sNiYTvoFTbChNtwg+BROHsNPKxO6MQqr5p
 MrhVDsF8ZPSgCyQpJLHogWZ/x7DVxEi5+ThmLXZ+QSakCYKyAfSKAwbeWF9Cc4f+EsVZ
 YhHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752366479; x=1752971279;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v489dALDnIb1k2yEBaE9gOUk0jyGXWz/c/CxRrFDdmc=;
 b=oZ2yjEHWdKK2cnrOItmnWns8fIWfvEmKUUdfMgoyTx8XAIw9+mvtbi4f3AGSepv5HF
 2r5JSDzT6Ew+3qu2Wf7I1PM0svaRElskBHl9o6CX8t7DfU4vzNnp0Kz83iKrT901v71w
 qpLTdR2E/UfT7BNhdH7TrhVjpwUqoV8meoN+9Tdx3Mb28sNJ3hY3IXNkxuvAHe27lP11
 UU7vkg4U98l936+OQr9VA25hcMIO4nqTSMCNvWa+9yguMZORZR9CouNam0CpVu0EnBw+
 NUEaSpKJ85B8n5X88k+BqkRxgNEHDnn6MEEHcPIBMiLy+nMzKNA4BGHZDGr72ViJT7+d
 dsig==
X-Gm-Message-State: AOJu0Yy3q1NuSybkltb+vAzv4ZJBUCK3mFNm8L7URzO8jZxqxI/6Ac+n
 QrL1Rh6DPF0s71ec/kKng6ieoO0QihgKDX1e8GReXxZGePhQVsWpAMY2PJxXxg==
X-Gm-Gg: ASbGncu7/8bdULbW09C1R3Mn+BkJGjErJMJvyRFx+bo9ROA9wGCjKGpo3tkX+EZPMOe
 U1nmNW+AHIKBGdHibfTDtXwuvMFzGLYPIijPR339Z/hcTlG4XUKAj+6HeIhMoU6xrK3E3dtyOtz
 Z/qflSyzF7qJQmptsCYrCIFseY2oTqQiVI4xXEK93LvRIA++1SScgvJgKnBfbAIp2oy3q+vFVHj
 W/+JyaPkRykQzq1091Z53kK7sEJ6XY9M13gyHuCkzXf3kuFsw61L8kZpbjwRs46oEwY5jlLbSGD
 /C6DI788ai3xW1p/4wv/kPy9QL8Mo5Y4+Wh8jfBB31mxNatz5VOhlaRCEuCplBylrvfj/RUnjVC
 jtaplbKxhJokQGQhNHBTAIQcjecB/wmM5
X-Google-Smtp-Source: AGHT+IFwepMPQAc7FDM1PYIb6wqs3QmoH5fhBGf5712rAB3ENg8css+fAYB4NL/oFgDiaHeWdfpM6w==
X-Received: by 2002:a05:6a00:b91:b0:749:b9c:1ea7 with SMTP id
 d2e1a72fcca58-74ee30456b5mr8850715b3a.17.1752366478770; 
 Sat, 12 Jul 2025 17:27:58 -0700 (PDT)
Received: from Winnie-the-Pooh.lan ([2601:647:4800:1482:798b:54ca:5a57:a40b])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9f5947csm8249046b3a.143.2025.07.12.17.27.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Jul 2025 17:27:58 -0700 (PDT)
From: Eric Anderson <ejona86@gmail.com>
To: u-boot@lists.denx.de
Cc: Eric Anderson <ejona86@gmail.com>
Subject: [PATCH] sunxi: Enable SPL/SPI boot for OLinuXino Lime2
Date: Sat, 12 Jul 2025 17:27:41 -0700
Message-ID: <20250713002741.367252-1-ejona86@gmail.com>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 13 Jul 2025 03:11:54 +0200
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

58e9502e6 "arm: sunxi: Enable SPL/SPI boot for Olinuxino Lime2-eMMC
boards" enabled SPI boot for the eMMC variant. Olimex offers the
"s16MB" variant with SPI flash populated but without eMMC populated.
Tested on board rev L.

Signed-off-by: Eric Anderson <ejona86@gmail.com>
---
 configs/A20-OLinuXino-Lime2_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/A20-OLinuXino-Lime2_defconfig b/configs/A20-OLinuXino-Lime2_defconfig
index f885fc01e6e..a2c3dade795 100644
--- a/configs/A20-OLinuXino-Lime2_defconfig
+++ b/configs/A20-OLinuXino-Lime2_defconfig
@@ -2,6 +2,7 @@ CONFIG_ARM=y
 CONFIG_ARCH_SUNXI=y
 CONFIG_DEFAULT_DEVICE_TREE="sun7i-a20-olinuxino-lime2"
 CONFIG_SPL=y
+CONFIG_SPL_SPI_SUNXI=y
 CONFIG_MACH_SUN7I=y
 CONFIG_DRAM_CLK=384
 CONFIG_I2C1_ENABLE=y
-- 
2.50.0

