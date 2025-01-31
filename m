Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CEBBC02192
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 22:04:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F06D80FA0;
	Fri, 31 Jan 2025 23:04:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f5opT6qV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBBC480FB5; Fri, 31 Jan 2025 23:04:26 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A65D880F95
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 23:04:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7b6eb531e13so139986285a.0
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 14:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738361063; x=1738965863; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=7Vij8hD3NW5wrhmCaKAfMgh7JV5ijfCSyqEzPNS8DEU=;
 b=f5opT6qVbaNMGj9LQpRWxWZMv9lPjhYAqE8cndwxJhsUqdM4mylQny65nh23lDo8bx
 wPWt6JFY0gVG0ROLmIWhikZn9/CypifnetbRn8h1hFrjvCg1WrUUTY5/prN3oPAH3v/g
 Ome9nP7ViZz8yhVCYRuPrQmK4O2oLm/c4ZsUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738361063; x=1738965863;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7Vij8hD3NW5wrhmCaKAfMgh7JV5ijfCSyqEzPNS8DEU=;
 b=QxJUHPeIwYenD9b5y8U23Irkv2f+j0uD13oOyXKTEaX/MWyx4di8RQFT2y1Gxhe9Y8
 Mi6cVS7G0zuizrfONzdWOELs7zKkFKKNyaKrUWdJLGUL+yYHMhQfRQrynqrk6ALc5sTs
 mxDZi2+bSMfVPgiV6TOCsgS2aOm7rjGBBV5pyk1chBhfCpnAGN7SAdXcBP1IzvNY0PZG
 dB5COayPysjrO9jnYNXQbb6Gx3fXcJj1MJ6ZXNFi4Xh89dMw1k4Tu0sk3C6sJNnEeYx2
 Cmkjg+X5TA5d0ZAAX4XgxePDYUW8O1ASJC0hv3PUaAfGJnjdnBvAwCzKxe4dQHbfIexR
 u8pg==
X-Gm-Message-State: AOJu0Yx5cIHS66sErEPrGpxn8R8PXPDSKB3kVx79WU93n0hiFaeTBEbu
 HNjW7Mg2eP5N6+hJUvWwS6HQmoBcXOazbFkHYXDJ1LxQL2wkWVqZXi59hioTqnEMkW0WdqFFZWq
 h
X-Gm-Gg: ASbGncvQlcDcjoL8dB6BWA0WFt52Kt+lq1LYnSLJQGtnQs3LYwmqxZ0LcauOEwRorEJ
 E2f2f7MLkuIZGy7kkyJd3k124Z3ireby8QTPTuzcr/AY5+3DVD01U7Yc608WWRtAIKHUy0UT0wh
 c4FSh1U1A7Oj9xJMh+KpTGLrY0rmggcI5nRraw6wTy0YcLEu9MMh25BFuH0EYH4nQYampLDFaDs
 s4ZQ76gwnc3JciJ4pQls0kd78T6KENr7hNGiC6xUgXJ12Wu1y24BH88+HEEwnYpWwiisy5lr4e/
 4R8siGFI6l0/mZCEyg==
X-Google-Smtp-Source: AGHT+IF6l+ozyKBmMRWfvUdsjYuVo9/RqXfppvkwOT987Nh4DIn3Wg/0q4bdA6oBK1ctQ9hfA28c7w==
X-Received: by 2002:a05:620a:244f:b0:7b6:cfab:9883 with SMTP id
 af79cd13be357-7bffccc97dbmr2032979285a.8.1738361063490; 
 Fri, 31 Jan 2025 14:04:23 -0800 (PST)
Received: from bill-the-cat.. ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c00a8cf5fdsm234853085a.35.2025.01.31.14.04.22
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2025 14:04:22 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] sifive_unleashed: Rename "spi-nor_qemu" variant to
 "spi_nor_qemu"
Date: Fri, 31 Jan 2025 16:04:20 -0600
Message-ID: <20250131220420.3059801-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Given how files are searched and parsed,
py/travis-ci/u_boot_boardenv_sifive_unleashed_spi-nor_qemu.py was not
being used due to the dash in the name. Use an underbar for consistency.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 ..._unleashed_spi-nor_qemu => conf.sifive_unleashed_spi_nor_qemu} | 0
 ...r_qemu.py => u_boot_boardenv_sifive_unleashed_spi_nor_qemu.py} | 0
 2 files changed, 0 insertions(+), 0 deletions(-)
 rename bin/travis-ci/{conf.sifive_unleashed_spi-nor_qemu => conf.sifive_unleashed_spi_nor_qemu} (100%)
 rename py/travis-ci/{u_boot_boardenv_sifive_unleashed_spi-nor_qemu.py => u_boot_boardenv_sifive_unleashed_spi_nor_qemu.py} (100%)

diff --git a/bin/travis-ci/conf.sifive_unleashed_spi-nor_qemu b/bin/travis-ci/conf.sifive_unleashed_spi_nor_qemu
similarity index 100%
rename from bin/travis-ci/conf.sifive_unleashed_spi-nor_qemu
rename to bin/travis-ci/conf.sifive_unleashed_spi_nor_qemu
diff --git a/py/travis-ci/u_boot_boardenv_sifive_unleashed_spi-nor_qemu.py b/py/travis-ci/u_boot_boardenv_sifive_unleashed_spi_nor_qemu.py
similarity index 100%
rename from py/travis-ci/u_boot_boardenv_sifive_unleashed_spi-nor_qemu.py
rename to py/travis-ci/u_boot_boardenv_sifive_unleashed_spi_nor_qemu.py
-- 
2.43.0

