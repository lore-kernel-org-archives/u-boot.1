Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E21CAD3C931
	for <u-boot@archiver.kernel.org>; Sun, 10 Nov 2024 11:52:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F38E189161;
	Sun, 10 Nov 2024 12:51:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lvO9zXVv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5552689110; Sun, 10 Nov 2024 12:51:39 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 715B689116
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 12:51:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43155afca99so25967745e9.1
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 03:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731239497; x=1731844297; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Jsi9+1oXtEK7GY9TXIImG9iazLycLcIavQ8/dm+agHI=;
 b=lvO9zXVvbyGWaeFz+qjnBNU7JFK4m9t+oQshuKZ+W53EgutAWsvVxIuhTLkdiXe/Lk
 0fL6HW1nsI238HWgKFrswHdKa7w00fLbPfuzxYCWovhNU/7FDTcxcX70sJTsMlYkt2eN
 fjJ2BofbWSBEr9fo7CZaFLo010/Uq7dtmzfUHma8R6ijvaaOxKxl5/gMz2Iqw9K8MgZY
 IGaU6exRPjzmNztra/VZ2NW0ZjsjjXVxQLJEOOzP2vB/BuDIcWSu+70H+VGBLPng5rdl
 rhlfdapezJcHcuOLXxCixKUYVsBVJycuHe4wlYKbAtplYplslj8rQqzE4dpOJ5XxZX6y
 Fnow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731239497; x=1731844297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jsi9+1oXtEK7GY9TXIImG9iazLycLcIavQ8/dm+agHI=;
 b=QJ83GGVLUaM+530Hw+zq/6N59eERkw0yjUV7MkKDzmiBgqjFKM9z/9eyqB7GzLtb0V
 3snwZHxRPaXq7njjlGi6KWwumPiMBTbSJK8UgZKlG/UUX3mPNwgiEjRh/vR0M5QVISxV
 8DWpQmcZsKZFVR5w5zNMpOGLucSbVwDpmP0lwDsu9EFdmFQlhzY+rnGBNefQcauedhm8
 TLqdoPsW5GL634y8Gb39zHbfRamLuvpNqOlxFpY6oDt5D3IhQN0YI2FxwgMPfm2Xreqi
 r+UHZr1nGe0xIY1KYluUXrOVMyEA/fJzsCJaShgBk16bf+QnJ7EqU9elmFWvH6t73sYN
 CP+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBNMer3xujvC+p1G9adn3l6cjMJ22u3mByAnUNcOJNUeAigozHdYAToGCGVzWB0v5+cLC2QZA=@lists.denx.de
X-Gm-Message-State: AOJu0YxX4i14GyCwLCK+XcL/DVrmdTkDwTqSve0NSSVeMTpAuiAl8e/a
 fYkxMcYIiS4vyolG+EPat1XKq9hrB8C/intCHsjqBkYOInmTJDcR
X-Google-Smtp-Source: AGHT+IHsTaG7rmkj42OgmYAc0fHrIvHMvwu12GCNhhHGO7luXjDsOHGjNixJ2bmJt7PKHE/ysgMksw==
X-Received: by 2002:a05:600c:4f4e:b0:431:4a82:97f2 with SMTP id
 5b1f17b1804b1-432b6858db8mr83278275e9.6.1731239496793; 
 Sun, 10 Nov 2024 03:51:36 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it.
 [93.34.91.161]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-432aa5b5fb1sm181423745e9.8.2024.11.10.03.51.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Nov 2024 03:51:35 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Marek Vasut <marex@denx.de>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>, u-boot@lists.denx.de
Subject: [PATCH v2 6/8] test: dm: Add test for ofnode options phandle helper
Date: Sun, 10 Nov 2024 12:50:25 +0100
Message-ID: <20241110115054.2555-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241110115054.2555-1-ansuelsmth@gmail.com>
References: <20241110115054.2555-1-ansuelsmth@gmail.com>
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

Add test for ofnode options phandle helper and add new property in the
sandbox test dts.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/sandbox/dts/test.dts |  1 +
 test/dm/ofnode.c          | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index b8a46463158..1ffa64a43e2 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -106,6 +106,7 @@
 			testing-bool;
 			testing-int = <123>;
 			testing-str = "testing";
+			testing-phandle = <&phandle_node_1>;
 		};
 	};
 
diff --git a/test/dm/ofnode.c b/test/dm/ofnode.c
index cf10e698d9e..f16b643fa3f 100644
--- a/test/dm/ofnode.c
+++ b/test/dm/ofnode.c
@@ -704,6 +704,10 @@ static int dm_test_ofnode_options(struct unit_test_state *uts)
 {
 	u64 bootscr_address, bootscr_offset;
 	u64 bootscr_flash_offset, bootscr_flash_size;
+	ofnode node, phandle_node, target;
+
+	node = ofnode_path("/options/u-boot");
+	ut_assert(ofnode_valid(node));
 
 	ut_assert(!ofnode_options_read_bool("missing"));
 	ut_assert(ofnode_options_read_bool("testing-bool"));
@@ -714,6 +718,13 @@ static int dm_test_ofnode_options(struct unit_test_state *uts)
 	ut_assertnull(ofnode_options_read_str("missing"));
 	ut_asserteq_str("testing", ofnode_options_read_str("testing-str"));
 
+	ut_asserteq(-EINVAL, ofnode_options_get_by_phandle("missing", &phandle_node));
+
+	target = ofnode_path("/phandle-node-1");
+	ut_assert(ofnode_valid(target));
+	ut_assertok(ofnode_options_get_by_phandle("testing-phandle", &phandle_node));
+	ut_assert(ofnode_equal(target, phandle_node));
+
 	ut_assertok(ofnode_read_bootscript_address(&bootscr_address,
 						   &bootscr_offset));
 	ut_asserteq_64(0, bootscr_address);
-- 
2.45.2

