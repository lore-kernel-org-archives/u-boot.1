Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08BCFC3ABDD
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 05:22:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BCE382C10;
	Tue, 20 May 2025 07:22:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="njhn4byR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DCD582C0C; Tue, 20 May 2025 07:22:07 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4541382BD7
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 07:22:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-442fda876a6so33711155e9.0
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 22:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747718525; x=1748323325; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hLBYUCG2aR96Y6W3ij/bCgrGA+lEuBvlwVcfMTYe918=;
 b=njhn4byRgQV11ImYABkKA5FZg+8tao9Jo0A1Bc+h4jldWUBD+OA5HgWv+oUBX5WzQD
 umr3t+EJNq8Lerk4qbVJDlQC0n8MkfSwW7AMFbwygerfvE4daXNjvfYtH9tUCw11F7dL
 eTQ0iiZcB3XRI0TbEYjDRPNWIdOFkqU3T0hB5iTMsvc6GYWSz+JjmHyPQWs+aZNKwvE/
 QwQ2p4H9EL76Txa2rcyvc4tzL1Ghitg9Wd/oI3M1kcJ8yj3PJQVKVJV+N5IIZ3jjGFZH
 2eo0eoeuiMZEuTJPOk0+e7WPOHIRQvwXKEINZZ0aZ9zEDmH/xPyr0pdxTFB5LH4GGoPN
 k2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747718525; x=1748323325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hLBYUCG2aR96Y6W3ij/bCgrGA+lEuBvlwVcfMTYe918=;
 b=YXFON5mvbs/Xh7qBP33np0irTzog7rQ2Uw/kZE6gLX/+capkrQdwEOGHRwhoFs3SR4
 yEDxYgpWCZjTEbNyq47XMI33H+FYkdZLy1Jksubf4E3b2MV6DHKuiGcP33J1GnxCxaBp
 ckvYsiD8Qu5OmWpx58gtiofbvArxMO0ruifVmhTXk0yuUTlLE0VkPu9mZFRvkxjux72I
 F2uo5WVXywo+trQexbeAXPSNV00jOhHu82jlVqRG3H0laJpKBA7fO/OeuP4wc6RimFAk
 UC7T44G8I2y5cIeKGfsV/sTLjxHdFJQhR9D1+oz4Fxg0GoPRfXY6Bb71g8LOqU+ONfil
 iwzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTrtWsYWpPdZm3cnnp86dmsSo0ZPJOrE/J19sS+/0/2kcXYtLE74d1POtO/XPc3Kfs9AOfRv0=@lists.denx.de
X-Gm-Message-State: AOJu0YwFlwriJPtB8TdKzoWGCX4UPyF+lQ/QfqHrVRsU4xmV98+/H+xu
 dRqKpCfLCLOuM9FFKYDpnwFyPjV/XEbuN9cYa0+hj+sXQkd5UGbWkQ120sicYsLfNlQ=
X-Gm-Gg: ASbGncsanDadY8dKLoSCQqvUPdMcRK9FxORXrxeez3Og8mu7oxqlplIuaRVoJx9aJdq
 XJnGCh60oicd2juatBLnFwNAaVeBWsYr1pmTwCmsr90g7QBnJBw7KTHGVa+AyGQIXuUfPOShXCf
 Ya32YCVXbYGx5WnKdLdUSlxEQL88dmXmoVnc5pUKpikdG1qU8XfPkJjyhbi5FenwSMd1aIP8yik
 D2RmP6HKJo7ru86h/D5mbn1LjqWaPwmqT8f4nufqWffWeUEXmzoB/W4aI9wCBm+r9ikC16pJ+T3
 Dg351b5G9ppA1f2THGDRhIZRzsYs5YkGlx1xLhgQwrA4yClTPTBz1PNd5fAP33TVLd9Sn9sYwxk
 =
X-Google-Smtp-Source: AGHT+IFMrJ7bwS68+MIw/Tk9FOP/5PaupG1IGM3/8wIISlww79f5JfR8a33IDQchw5OtGHjPun75qQ==
X-Received: by 2002:a5d:5850:0:b0:3a3:63d3:369d with SMTP id
 ffacd0b85a97d-3a363d3396cmr9633824f8f.0.1747718524757; 
 Mon, 19 May 2025 22:22:04 -0700 (PDT)
Received: from localhost.localdomain ([46.198.180.244])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca889e6sm15100762f8f.71.2025.05.19.22.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 22:22:04 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Michal Simek <michal.simek@amd.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jonathan Humphreys <j-humphreys@ti.com>, Sam Edwards <cfsworks@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH 02/24] kbuild: disable dtc simple_bus_reg warnings by default
Date: Tue, 20 May 2025 08:21:13 +0300
Message-ID: <20250520052153.307194-3-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520052153.307194-1-ilias.apalodimas@linaro.org>
References: <20250520052153.307194-1-ilias.apalodimas@linaro.org>
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

Backport changes from the kernel
commit 70523a3ce5ff ("kbuild: disable dtc simple_bus_reg warnings by default")

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 scripts/Makefile.lib | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 83fd5ff6c31c..2422ac980a46 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -302,6 +302,7 @@ DTC_FLAGS += -Wno-unit_address_vs_reg \
 	-Wno-alias_paths \
 	-Wno-graph_child_address \
 	-Wno-graph_port \
+	-Wno-simple_bus_reg \
 	-Wno-unique_unit_address \
 	-Wno-simple_bus_reg \
 	-Wno-pci_device_reg
-- 
2.49.0

