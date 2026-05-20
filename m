Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE6FCD4F54
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 09:12:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBEA6846FD;
	Wed, 20 May 2026 11:12:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cL73S68s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9B27844CF; Wed, 20 May 2026 11:12:29 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8412846CA
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 11:12:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so54540645e9.2
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 02:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779268347; x=1779873147; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q9Mb6DStYHT/Pq3N8w8i+WT5+TYRu6va+NDf96M2U1I=;
 b=cL73S68sY8XGKreGxTraTPddbgL9rs7BVFxMg3PHgLz58r7Qqbi4zGaZCUKJxvHFJr
 1DncddYHKhSy6q7z+KH/mhAPGASvYcahTHCZuFLEGvjjf9NMcuQRZiYubeBc7cG5UakJ
 rWT+YysoAxpjyx2MYcICBoi7CnICB0nbkL1Xe/BtopjhO/miMuPLE4Xk07OSlWwMuPkG
 Jqoj4TbRlYkSBJa4spnh/tS53By9Ljz60LmQErQoFYs5TY0sbftaBmr0YUXoSwEAcYSj
 iGcWtNQHD/NPsNYhEMOQPuT0241QyA4LiFxm4yvDP+65UyUgd0uPpzSilUHj0hnafjqT
 6Qfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779268347; x=1779873147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q9Mb6DStYHT/Pq3N8w8i+WT5+TYRu6va+NDf96M2U1I=;
 b=cMnKfdVnAhfa2hOg0/KCYbHkQ2TZ3dsQ4zhr49RhovscXXdknumFSRGbamnBd4aL8a
 14TJveVOKnVSpjcNFuoS29B7NJTPBWXxHcX2WAVhjiBJcfrif9HxhXo05hOEX9l+2+k5
 DAw9jbaQM22o1zgMnUh6SUSVO4kjukaBFv5obnA2mFhPgL+BWzzDoAO8XMHY2VCZUjoK
 3KtQI5hW7Nb+H71ppcdEdF/Mkk70vue1FdaILBAhm8JsiuDhpN5cxnd9KLgmBLwHolPd
 Wfb5obscN4Gfr852QU5Ef/+gxn7/PDStAZ8Rf7I/JWGhptvU1KaxnPDEvR3ipjmz3e8t
 gXVw==
X-Gm-Message-State: AOJu0YzhSFytc0KImNyJpqu5rZh2bzF/GB6lpPNiUvTKahxgsrkzP8qB
 xA1JXqoctvx2jm1KthwAV7xnCy/moaKClnR6K5B4E+5x3MXMAVfA0d0i
X-Gm-Gg: Acq92OGSFtM5er3jw8RhpUmBfqYFnbClrDvOe27I3r+7f7D9QGeNJSqWsXXD1fJlmHq
 eby12HAU2fA+lT3t4NHNJlsU3UMvQYhQUOlRh5QFqSo8iVe3YmjL/wxgqDyzR+H1KYSPIZgsE7k
 Cij5es6fRUkp3pzbmOSOwKwMxfav6HTD4gNihpc7T8V3J5AFQK4EaiuDJShzWTFFQFVHa8zs7V+
 2WkkIhwtoPpDDcEZZJvmJ7+4KTD+69EoU5ibSbc8/Vc4rZOfKr+OUMjXPDy2fY5bH3OVVcRLHOn
 j04bh5MGYVfGu3pPL59axPxltyMhlT8fmBlT0gT6XGpVU5N0+I1CFhXrOHs55PHKMGTDTkKqc6H
 dRohX4oYTpMpdJ0HiA77fI2ZQ3Ap64u7TvQNXTodEmFrztmpOMSJa9EJZwmlvCeOfu4vAJk4T94
 F5VwZ49GV2DyZY
X-Received: by 2002:a05:600c:3506:b0:485:40db:d40c with SMTP id
 5b1f17b1804b1-48fe60e13d1mr353556185e9.3.1779268347111; 
 Wed, 20 May 2026 02:12:27 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45e6a135f0csm33660416f8f.27.2026.05.20.02.12.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 02:12:26 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/1] ARM: tegra: tf700t: Align panel timings with Linux
Date: Wed, 20 May 2026 12:11:55 +0300
Message-ID: <20260520091155.44696-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260520091155.44696-1-clamor95@gmail.com>
References: <20260520091155.44696-1-clamor95@gmail.com>
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

Downstream timings provided by ASUS do not allow enough time for the
bridge to set up properly. Switch to the timings provided by the Linux
kernel's simple panel driver.

Suggested-by: Michele Brocco <brocco@perceptos.de>
Tested-by: Michele Brocco <brocco@perceptos.de> # TF700T
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/tegra30-asus-tf700t.dts | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/dts/tegra30-asus-tf700t.dts b/arch/arm/dts/tegra30-asus-tf700t.dts
index 47606ede9d6..c82bdbad2d6 100644
--- a/arch/arm/dts/tegra30-asus-tf700t.dts
+++ b/arch/arm/dts/tegra30-asus-tf700t.dts
@@ -139,18 +139,18 @@
 					display-timings {
 						timing@0 {
 							/* 1920x1200@60Hz */
-							clock-frequency = <154000000>;
+							clock-frequency = <157200000>;
 
 							hactive = <1920>;
-							hfront-porch = <48>;
-							hback-porch = <80>;
-							hsync-len = <32>;
+							hfront-porch = <154>;
+							hback-porch = <32>;
+							hsync-len = <16>;
 							hsync-active = <1>;
 
 							vactive = <1200>;
-							vfront-porch = <3>;
-							vback-porch = <26>;
-							vsync-len = <6>;
+							vfront-porch = <17>;
+							vback-porch = <16>;
+							vsync-len = <2>;
 							vsync-active = <1>;
 						};
 					};
-- 
2.51.0

