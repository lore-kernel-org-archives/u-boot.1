Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8912BFB5EA0
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 01:27:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 875AA84307;
	Tue, 17 Mar 2026 02:24:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q0y1nFCN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88799842F4; Tue, 17 Mar 2026 02:24:57 +0100 (CET)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50307842E6
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 02:24:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-662efd1bdd4so184289eaf.0
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 18:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773710694; x=1774315494; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rqcomgv/8hNeSxY5+b3zRzfGAKoK8qmxTHHWebzB3kU=;
 b=Q0y1nFCN8hErk7jaZKLWbN4/OhEW27v9wFdb75UqmKZ9aBzEHJ3ygS/KFjqv3V0/dZ
 ce8JvgdG0OaePO95/2LXbU59t8mke8K2zBGBlYDJ0Da54A47LcTHCrRxYTickbyjGvUb
 dju2lXL3znWgmc+UfbQ3CQ3eRIDoUN/By3zE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773710694; x=1774315494;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rqcomgv/8hNeSxY5+b3zRzfGAKoK8qmxTHHWebzB3kU=;
 b=WYX6O6mzezX1yx+3JnqlzjkkwBBezO1D1nlDCLuqYOcPAJTTppb3HHtTIHCFFZSy0r
 67G/DgusGo7LcWhLpzePsU4LQ81sNQ8hFtveItzqNfk4F8d/shsxbw637z7xP45/hRm3
 EQrBF6TNyHVLyPKkulP+vS8H6s+F7o+YKPgj6yfBUkouNMhNvLFk6IysmV+y2sxLzdTW
 lsdaVarbCttxCoPh4g73reoQDhSmXvV/GS6383RG7ucAySc/GkYu6AZ1LI9UTAgC1P5/
 NYauwTpaKmtZ0Jvd3JPWUu/l0kDf5pa4fYsh5oKi98wYadQe+cfPGOFMg4wj+4abLbvo
 WpDg==
X-Gm-Message-State: AOJu0YzIaJEeDWiOpwuP7j8FjlBilJQmXJnEZtgKLr2LRGUx9QpvLrsX
 govviicu5AeFE9oMPs22jJAcX4IQhnY4GFtfr8SSSCVVMQOJ3bSmxIg3hWiX/Y8acqVMHwh204Q
 PEFtu5Qk=
X-Gm-Gg: ATEYQzy0CrQLM+Qa+mRSREIFLcdsQlvNnfZ7VsprwRM3w9qWdbzea6+Xv7o5Gf7n5pT
 l8Bttn7HXcJZLmeFm48WAu9iMM4JwhGoBgpxCeqqnek5zSuuN/7Zh5n8jJzRh9V8eMMT2MfL4e2
 TbifWiaUj49wenMuSawRbaqo0F1JsmlQwsY2KiqGYRTjHt+PwrYbvVHIv2Z1jXJtjji7Ic1Yn8M
 SLvUyHYzbaALsNHYmV4y0pMjKENMdnxxNjxqY6vmiJ3EA0yT0nqzrZt9RmzL7Mlk/ZGggx/BKvo
 YnePxFs7tI0c5sxsLlC1HyCj6631BTDy4XY1n1GC50vFCVGW+v9hQ67Ufuay0yd+cMmMZ9H3UWT
 X5XHiFMWPaI4S72VjP39MATSVKq9irB2H4rMfCxMf7Joj57xMxf6X+zrPEIZ1QyNx0nJ5EXJCq+
 5n8l/1Y3cQ37VB3tcDBiew6U2J6+9733/BJiuYb2ISCTw0HOovlN7D98iUMu7OKjYvOFu2dmgZ4
 kOFZL8JNhDRYVZKqM7s4cCZn2N+861tXCmSQApSItD7fdjeREo=
X-Received: by 2002:a05:6820:f001:b0:659:9a49:8ee4 with SMTP id
 006d021491bc7-67c049986camr983294eaf.24.1773710694071; 
 Mon, 16 Mar 2026 18:24:54 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67bc8efae1asm11392178eaf.3.2026.03.16.18.24.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 18:24:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marek.vasut@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@dh-electronics.com
Subject: [PATCH] optee: Correct dependencies for BOOTM_OPTEE
Date: Mon, 16 Mar 2026 19:24:51 -0600
Message-ID: <20260317012452.4162719-1-trini@konsulko.com>
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

As exposed by "make randconfig", we have an issue with the dependencies
for BOOTM_OPTEE. This symbol needs to select BOOTM_LINUX and in turn
that is only valid for CMD_BOOTM or CMD_BOOTZ. Add this dependency.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
I am looking for feedback on this, so I've added the board maintainers
for the platforms which enable this option. It looks like this is only
valid on 32bit ARM platforms, to start with and not 64bit, is that
correct? That's why I excluded CMD_BOOTI from the list. I suspect that
this should really depend on CMD_BOOT{M,Z} and BOOTM_LINUX, and not
select it. If someone can confirm, I can do that instead, or someone can
just do the replacement patch for this. Thanks!

Cc: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: u-boot@dh-electronics.com
---
 lib/optee/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/optee/Kconfig b/lib/optee/Kconfig
index 34b9d8afe675..9251faf73cd7 100644
--- a/lib/optee/Kconfig
+++ b/lib/optee/Kconfig
@@ -40,6 +40,7 @@ config OPTEE_TZDRAM_SIZE
 
 config BOOTM_OPTEE
 	bool "Support OPTEE bootm command"
+	depends on CMD_BOOTM || CMD_BOOTZ
 	select BOOTM_LINUX
 	select OPTEE_IMAGE
 	help
-- 
2.43.0

