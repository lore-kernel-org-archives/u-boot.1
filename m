Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66654C61DF4
	for <u-boot@archiver.kernel.org>; Fri, 24 Nov 2023 12:05:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 857C787478;
	Fri, 24 Nov 2023 13:05:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="hTQTSyoA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED101875E3; Fri, 24 Nov 2023 13:05:42 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C1AC87008
 for <u-boot@lists.denx.de>; Fri, 24 Nov 2023 13:05:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-332e40322f0so937162f8f.3
 for <u-boot@lists.denx.de>; Fri, 24 Nov 2023 04:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700827540; x=1701432340;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=B9eUE8sWPSh399otQrFHGgubQ1e2nHgx4wIQZzpOxJI=;
 b=hTQTSyoAkhDSGvKj5X8YIWqc8SaInQ+x6n8IzOGYpE0icWGnKX52ufxls1zzUwDDI3
 k7jPvQzZ5A7UeofT9OYEzH+cfIzKs6fUp8thKSLyjqKnwMqJ/3ebyDD1nymk8sTJKtNp
 G9f4Bstgagg2k6Wv7VV+HW+h4AjNcWvLUT9wq0e7pC0zHX9cWKSN1JeDZ8ZsgOKzhB57
 f7VHjOBR1XjTc35v0VqvktTEaI2EIq9haZCTBiE4nud2uV/USVusmAG2d47rYRwusGyA
 f3V8MLuW8tqoFF9LIZNJJHj3Y8h6E2PUXkExd24pfdyrR3zBQfc7xYWqnOrZjp3eMZUi
 dL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700827540; x=1701432340;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B9eUE8sWPSh399otQrFHGgubQ1e2nHgx4wIQZzpOxJI=;
 b=iAB4FKszfW2C3LPQEfCAhlzDdgdiE9VdSqvNcFcrvHT5luIy+WPWHepBlN5tnvT/pc
 5YFvSbsKnmRVzaydELfkt5ajIeqMusTCXhK6+u1c4PP4gZa7g7RwuPqEFsM8bZ9vGOlE
 HuwskZYnVdPQq4JBd6OuhYxXj7t8EK1ymCD4qIcWONZEblfw9wgtrGITEylVkXbF49ZQ
 BaXBSQybGepBLggO3Ix+y2ZaVmF/NlJsF3WfUF12Of14NGo5Orxj1v9Ss97UHQ7Yc2yi
 raho6SlgIEEUgvt0g7K9F0ks+ZTDgVlKuhJ5GwF6p5YWQ9b9THO1TnMTZNZ/zbc0/fQq
 ox7w==
X-Gm-Message-State: AOJu0YyiK5wE5sHcgplI4sEuaNihWhCL53A4p/pOtlqaMk5upVTK/S0I
 HGiSmvKBrPoSUeuvXxNfwJBWYAizLR0I/IqWpdbetzbd
X-Google-Smtp-Source: AGHT+IHEcB+1o7v6S9SOD9R3wr2RSqzCmBgL1st+OGd6GC+P9zXoDZaa/oegLs2BNt89m0lWidhlnA==
X-Received: by 2002:a5d:630d:0:b0:32f:7bf6:db01 with SMTP id
 i13-20020a5d630d000000b0032f7bf6db01mr2096414wru.67.1700827540141; 
 Fri, 24 Nov 2023 04:05:40 -0800 (PST)
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 j14-20020adff54e000000b0032db8cccd3asm4223732wrp.114.2023.11.24.04.05.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 04:05:39 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: u-boot@lists.denx.de
Cc: Shantur Rathore <i@shantur.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>
Subject: [PATCH] maintainers: rk3399: remove maintainer
Date: Fri, 24 Nov 2023 12:04:31 +0000
Message-Id: <20231124120431.115717-1-i@shantur.com>
X-Mailer: git-send-email 2.40.1
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

Remove Akash Gajjar <akash@openedev.com> from
MAINTAINERS as email is bouncing.

Signed-off-by: Shantur Rathore <i@shantur.com>
---

 board/pine64/rockpro64_rk3399/MAINTAINERS | 1 -
 board/rockchip/evb_rk3399/MAINTAINERS     | 1 -
 2 files changed, 2 deletions(-)

diff --git a/board/pine64/rockpro64_rk3399/MAINTAINERS b/board/pine64/rockpro64_rk3399/MAINTAINERS
index 303db144aa..220ee21f23 100644
--- a/board/pine64/rockpro64_rk3399/MAINTAINERS
+++ b/board/pine64/rockpro64_rk3399/MAINTAINERS
@@ -1,5 +1,4 @@
 ROCKPRO64
-M:	Akash Gajjar <akash@openedev.com>
 M:	Jagan Teki <jagan@amarulasolutions.com>
 S:	Maintained
 F:	board/pine64/rockpro64_rk3399
diff --git a/board/rockchip/evb_rk3399/MAINTAINERS b/board/rockchip/evb_rk3399/MAINTAINERS
index c7e412b54e..acdb840f20 100644
--- a/board/rockchip/evb_rk3399/MAINTAINERS
+++ b/board/rockchip/evb_rk3399/MAINTAINERS
@@ -93,7 +93,6 @@ F:	configs/rock-4se-rk3399_defconfig
 F:	arch/arm/dts/rk3399-rock-4se-u-boot.dtsi
 
 ROCK-PI-4
-M:	Akash Gajjar <akash@openedev.com>
 M:	Jagan Teki <jagan@amarulasolutions.com>
 S:	Maintained
 F:	configs/rock-pi-4-rk3399_defconfig
-- 
2.40.1

