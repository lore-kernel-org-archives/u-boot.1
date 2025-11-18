Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9414ECEE348
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 18:06:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA42583F61;
	Tue, 18 Nov 2025 19:04:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QBOvcb0R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66EA483F60; Tue, 18 Nov 2025 19:04:15 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 507B983F56
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 19:04:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-4507605e19aso2862882b6e.2
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 10:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763489052; x=1764093852; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wLE67ELVpd7sM32JD1b3m5/7KRL2s9FETGrz3nCMAk8=;
 b=QBOvcb0Rp5E8THTYEH38usTwgOz9dDMRpMOJUgblfZQKTv7AmuDmzpYaZ8/gcIQaOe
 JqyBdFMFUCoRKuJ5pvZiMlhBYZfS621p/9BRg3g/b/0w3JJ7S/uKyUi3VuGUl1jU/jrN
 ABHzOxTokbjZcYtJgYMmefVvw1ctEaA2MTx5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763489052; x=1764093852;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wLE67ELVpd7sM32JD1b3m5/7KRL2s9FETGrz3nCMAk8=;
 b=m43eUgwediQs3CGbT6503BZVmTso+3+z+F8b/T7ex8h+41VgUg5BQqWXBolD9NXehH
 1Jb/+T+5pmg4n2Blu1kQqtKOpq0DdEDnuQdu9y7C2Vn2L+Bwtl1yzwitJ6VbjH7GCTZh
 khnxf/wmu+0cXOu7krbb+F1kxId1JcQ6fmmQ/6OjmUoo2PDTn6H0ZqHVDRJoys05T00I
 F7ZO7MPCUeCOyttKFZ7rb5GQBP2nAGoWBVR2sZPrZAZJ06gt2d+qdt7sPS7RtZZrggJ7
 k+xDEbOdLYOovrc2CPGecxch1DOpLFup/XZYrlFgACLeWRcU5pR3zzdxtA0h6E/EQD7j
 WS+Q==
X-Gm-Message-State: AOJu0YwFAld3BeoZpM0IzHnXdDOBtPvVatZPfxC/KWEYr8WxRTLD9Z3p
 HKPNML5Ed+4Le2vp5oZ2jy/XZuIfGC8TrR65RFCNomAh2PE80jC8ERLZpI06aNnoXasxnhrdbfv
 EYstrpXiHBg==
X-Gm-Gg: ASbGncunrwCYarCTSBGaltML9kq4kzvw7r3XY/c9qGpMCY94f4JrebHP/WpeLxAyFt2
 DbRgg0M8gvzAkxFFfDGxOaL+4zDgCTeL1Iy0a0ScOp/svlmEKYEzuKHW8e+cLru1tSjlJGSDe+O
 qpfqiGgQR2MtALO/HdU0nPu22opXQysh4did0pgRXgL97t3+M0/ypurrsnDDblKJHRYANQfT/dr
 0SlVKIlYRNSWfknaGGlNtXzvLfRqSIa0PKxyAyEezP9NGRpd9+c/EQkVXNJhRuVvr4NKThcxeHx
 LfHM8iYxIZqMjIW89ktbxBcoUx6hWsBM5MT6ewfQ4YhRjCTaAdW6j8aMpfkQ/GKO5TJEi8B5EPd
 7UH3Fjqo8C84ZatPNbcITbXYjgQQFlJtUdkuqj7N/6mSNzyl1PyrId04VeBszCaBQfN73zCDmEk
 z7uSdx7HSA+jo+b7BiK7cBsdxuBQ90dlzZKQU46lxrp8kXDax7y0nUN7S3AIyjQHs=
X-Google-Smtp-Source: AGHT+IHKJqaSwkf1ei6SCl27gJZWW2gaLsH4ERNrUW5vkZpSDa9CQsBAvClLZRjhIRHgfX+fhD5gEw==
X-Received: by 2002:a05:6808:2183:b0:450:45d3:a50d with SMTP id
 5614622812f47-4509746132bmr8180636b6e.30.1763489051763; 
 Tue, 18 Nov 2025 10:04:11 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c73a283b6asm6881795a34.5.2025.11.18.10.04.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 10:04:11 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@gmail.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] mx6slevk: Stop disabling device tree relocation
Date: Tue, 18 Nov 2025 12:04:10 -0600
Message-ID: <20251118180410.591192-1-trini@konsulko.com>
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

Remove setting of fdt_high to ~0, which disables device tree relocation,
from the default environment. Doing so prevents U-Boot from correcting
problems such as having an unaligned device tree and leads to various
failure modes in the OS.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
If there is some window of memory that must be used for where the device
tree is relocated to, bootm_low + bootm_size (or often just bootm_size)
or bootm_mapsize are the correct way do this. Please see
doc/usage/environment.rst for more details.

Cc: Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
---
 include/configs/mx6slevk.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/mx6slevk.h b/include/configs/mx6slevk.h
index d4e66a39882c..24019be7a3ec 100644
--- a/include/configs/mx6slevk.h
+++ b/include/configs/mx6slevk.h
@@ -19,7 +19,6 @@
 	"script=boot.scr\0" \
 	"image=zImage\0" \
 	"console=ttymxc0\0" \
-	"fdt_high=0xffffffff\0" \
 	"initrd_high=0xffffffff\0" \
 	"fdt_file=imx6sl-evk.dtb\0" \
 	"fdt_addr=0x88000000\0" \
-- 
2.43.0

