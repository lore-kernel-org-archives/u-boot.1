Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A746C3ABDA
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 05:25:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1683582CF4;
	Tue, 20 May 2025 07:22:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OGPuAZvn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B35E482D18; Tue, 20 May 2025 07:22:52 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB85582BF2
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 07:22:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a371097fe1so1306243f8f.1
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 22:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747718570; x=1748323370; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FlOVWnAUSlRC1SLA4QTAi4TtXpL5I212AUPdVxcHY8o=;
 b=OGPuAZvnmjdLWX8Qd1H2n2jYjdlTY0Mhgk6Yp+6xiCYWfr8ONzQ1J/xj0mmwlkDxoQ
 6ZKWaXI4PRVGesxw5Y6NvxavG2YFkr+diPkWDQgjFOcv/NjC+ZFZyvyQ4rjrramtF8TO
 uiR6gU4tZ+Pk3KISX01RZRSsaNEmpFKuttUS3gEbNxQNXGcZ5vk7ojFSaobkExtZI56A
 uGYz0Dkg+OLaI/tbJHT4sZPH7Br76oUSGe82OM4FXHg1w6fbQ6DOVUe1Ks/nUSRlysz0
 APmeZYTjxcSEJfBPmja7YZPSGUIZcvtXIbrg8w2oyTv3+8s/xQTZdp8TCkdJE33gUV7o
 5mTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747718570; x=1748323370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FlOVWnAUSlRC1SLA4QTAi4TtXpL5I212AUPdVxcHY8o=;
 b=iwwjAoPWVCP50UQwiPdUak3GSndTaZC40eGbwhpfQ5HNyWkrqO+JnSTHuII6nbKqSP
 IGDhpQRffpQUIwsb1WMvMiq6P3sXMwMVPnapwgcnn8sOBUfkM7mAq/EyvbgB+eBOxXSn
 mJtRcxTXvBcZffhIPgqYQd1fUscsGCNi3+NsbPLGhj92enhAHsV8GeYax9WzFDHvhwTI
 A9PCQvQ7XhsFNzZ83QoO0da412IjkfpQhtu0ktaEZulVJgBl9WhYKRx5CBwQx8WE4hnx
 gIt/jV2OYe1YvzmN3MFsm7FWp4jISvcknZRto523EZaech6Fd0zMKwfpDrAnDsrnDHFq
 kf6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHdXpKz5DyjpySJ4J2VLaQH4HIx3cszw2SQmlmpPV0PD6jkU5mvPRWz2DG7N4P3VJDHWDXnek=@lists.denx.de
X-Gm-Message-State: AOJu0Yz8dk7iIa2F9DWLwBa0VEX2i+cAuqJZUhFS3uvdwVSvOzVKJYUB
 WrpDvNsVMqaz2pxGe+c+uOauQ662yhokDZpzqHVCIMJyZKKz2XUTsmKB0SjjIppPLw8=
X-Gm-Gg: ASbGnctYR8lew8hfG7edQVUZyt1Q8Q7BpZwWzCGbx75LosDfAfZIaTgBBJZtXfdyVo4
 /Tll5yeLRnduZ0BaycZNKoGlN8jY0WIvOWwvgTl99T9YWsr9P3JY04z0BPWpzx8sUXWXjKg8mH1
 g3CzUsdXmp6quUedwsoi70Ug4BUEP9sGvzQbUYVg+Wit451U6sONkjIYbCWSzJ1cQLEkdqu7tdF
 XHJILwQ+VxDCNAEALdLf1h/eTeoambmexcrvwHLBSzUNMtbR49EQ5qltSepwdpBRTlDYiLvRJ3D
 cWr0gK5kJN4IwmeYEODplcDzeS74B4xCOdRirOk/mWlMVdbUX/o53QteFxQj2UpOwFNdt4qiz3I
 =
X-Google-Smtp-Source: AGHT+IE4PJqh3XO3FiTx4xXX2pZcXau1uZC7r4j20azBShWSRhqS/qvqa6np5S60PMt0etnvZFzF7Q==
X-Received: by 2002:a05:6000:2304:b0:39c:1429:fa57 with SMTP id
 ffacd0b85a97d-3a35fe5c560mr10827207f8f.3.1747718570342; 
 Mon, 19 May 2025 22:22:50 -0700 (PDT)
Received: from localhost.localdomain ([46.198.180.244])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca889e6sm15100762f8f.71.2025.05.19.22.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 22:22:49 -0700 (PDT)
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
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Subject: [PATCH 21/24] kbuild: strip whitespace in cmd_record_mcount findstring
Date: Tue, 20 May 2025 08:21:32 +0300
Message-ID: <20250520052153.307194-22-ilias.apalodimas@linaro.org>
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

Backport from kernel
commit 1a49b2fd8f58 ("kbuild: strip whitespace in cmd_record_mcount findstring")

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 scripts/Makefile.build | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index b7611c030088..aa48d2494332 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -221,11 +221,8 @@ sub_cmd_record_mcount = perl $(srctree)/scripts/recordmcount.pl "$(ARCH)"	\
 	"$(if $(part-of-module),1,0)" "$(@)";
 recordmcount_source := $(srctree)/scripts/recordmcount.pl
 endif
-cmd_record_mcount =						\
-	if [ "$(findstring $(CC_FLAGS_FTRACE),$(_c_flags))" =	\
-	     "$(CC_FLAGS_FTRACE)" ]; then			\
-		$(sub_cmd_record_mcount)			\
-	fi
+cmd_record_mcount = $(if $(findstring $(strip $(CC_FLAGS_FTRACE)),$(_c_flags)),        \
+       $(sub_cmd_record_mcount))
 endif # -record-mcount
 endif
 
-- 
2.49.0

