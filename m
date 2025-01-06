Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F7E7E77198
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 14:37:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E35B80726;
	Mon,  6 Jan 2025 15:34:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DA0lFGVA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5769B80717; Mon,  6 Jan 2025 15:33:59 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 321EB806FF
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:33:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3cdd57060acso8497825ab.0
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736174035; x=1736778835; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sg5nkE0DN6pohCK8Ky5lihLFK1ntldKMmd7xrkTjZ3Y=;
 b=DA0lFGVAvrUGz1FYZ1Pk9i3k211tOx7YwW8jCkmDTbvf/EKHpnuQEVf+olUbuIJa2h
 a8wDzKrXnc+FavVvgo2yZlnsSEwDtynjTay1GmPHLp0Sem7vtPDwpty4QeCSwEDXOwNh
 65LJl9Upf68d4HcsS210Rr4rnhw8PUOvDvJFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736174035; x=1736778835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sg5nkE0DN6pohCK8Ky5lihLFK1ntldKMmd7xrkTjZ3Y=;
 b=AwaYlX7SH+/dYApycZeQ3jU8SkXqCN8TGkFe7Vlv6b/sGOOOTF1VpwRJN58VmAijMC
 QLkJ8r6lehJUTxI/WFTv8bvGrbaIc0moo9FiczAkF9uiSxw/s+fiVGlXKgRSq5NPYrgC
 fqtfARzjgcMt3tpLqBfc2ZvfAg4Oq1DsIKuqzixhzUTMJTlGFbeBJHXeys/6NV9S7aT8
 CphX4bv/94qd4P5Cf51yqznHD4ZK++wGnmePEAgJezDKLI6vJ1nwnlwf/SkB8kc060n3
 fQdP0FvbxHGua5U8tR9Jigk0WaI3vhEDg0gV220pD7ac0yixajLLtj62vFVzn3dcYhyl
 qDKw==
X-Gm-Message-State: AOJu0Yz864yqWBub7vy1UPor/x7sptSz4+kbx+8lz28UvZiz0N33fcKp
 GLzzDUkBmkgq89EnhFsgBw45wHUO3z1eN9g0jeCXaaHasKV8/3b33hJEmf5RRLryoveV0+CLtgU
 =
X-Gm-Gg: ASbGnctaOQYhJj6u7G8uP7gJ+wgLRFknK5GujYkQTHBctGqFscaXZ4p0botSdemKcRI
 FdKYoaSLgkGlCrTtF+5az2SfWG/YYHb6Js7IkAFBqZoYgp0ziOG/DmiO32ouYujMzSQUUJkgl4j
 3fyCR6WFc7ibHcLB+NhvzVyvFVwhwZD+8AF7rNUlLZ+bW4PcOx31cMPKOo6Eq0JkbnW7t/FPZVc
 CuaRn30rDkawoCpT6C0EKik0BMgv7ry74UNKIzbZLactTmdjcJd2pGbysiZw0W7Vz8JN9BA4qRj
 gCIS/mQRLn8dv2U0ig==
X-Google-Smtp-Source: AGHT+IGthqFP/VIlFdIeJMntzAiDCEmviivcKs1mY7OwWvNVyuWc2TeDklES6Je3qnIZATCZxFkaGA==
X-Received: by 2002:a05:6e02:3891:b0:3a8:1195:f216 with SMTP id
 e9e14a558f8ab-3c2d25770a4mr480275095ab.10.1736174034787; 
 Mon, 06 Jan 2025 06:33:54 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c0e47d6ef2sm97200805ab.78.2025.01.06.06.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 06:33:53 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 27/33] x86: Enable UPL handoff for SPL
Date: Mon,  6 Jan 2025 07:32:23 -0700
Message-Id: <20250106143229.3023771-28-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106143229.3023771-1-sjg@chromium.org>
References: <20250106143229.3023771-1-sjg@chromium.org>
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

Add the GD_FLG_UPL so that a UPL-handoff is created.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/lib/spl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/lib/spl.c b/arch/x86/lib/spl.c
index aad748532d0..7a033505101 100644
--- a/arch/x86/lib/spl.c
+++ b/arch/x86/lib/spl.c
@@ -298,6 +298,9 @@ void spl_board_init(void)
 	if (IS_ENABLED(CONFIG_QEMU))
 		qemu_chipset_init();
 
+	if (CONFIG_IS_ENABLED(UPL_OUT))
+		gd->flags |= GD_FLG_UPL;
+
 	if (CONFIG_IS_ENABLED(VIDEO)) {
 		struct udevice *dev;
 		int ret;
-- 
2.34.1

