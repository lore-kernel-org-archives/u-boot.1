Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21BCC3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 10:53:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3612188578;
	Sat, 20 Jul 2024 12:50:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GGe67gza";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A65D888C3A; Sat, 20 Jul 2024 12:50:21 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B4CB88C80
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 12:50:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3687f91af40so959284f8f.0
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 03:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721472618; x=1722077418; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=flE7HT89pbbEKdZqXJexqCmQU772NTjAA3iSrpKaFn8=;
 b=GGe67gza3jmNTJRWiS2Ly8YqYj9nui1HbvwwNDZ3Wso6jBugjCJhMiMGf1zCM9BudI
 bZb1m39ZVgEDoor8lRefFkrOJKuWk3ygw1BA2Rb4gFUqyei0gWlaqQP2C6CR7Y1RRkW+
 ioMThRjsWyPT/XFYLhe/tqPYMzMhFnr4is65g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721472618; x=1722077418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=flE7HT89pbbEKdZqXJexqCmQU772NTjAA3iSrpKaFn8=;
 b=X2Q4FwRa4AzuYNDPRYcd2Fkl1y8xIWA607RYQO3raqqyC8GEw5zcQP96S7SQG0LrMM
 i0hHJ/ArqmmdcvG4P4h3Kg2iS9sRgT5SZEBG/ykOUXeSZaxUx3iqmTMJyu9D+bAdJLAW
 E9JqHVqSCnhfbrvBFhk86cbZEw7OU7030mVVvrcdiyyzz7pEAMVqcLxwG9Fg4i3mydEk
 vhB35In/1EM1Hs/H9DQPjHbuFsOdTxu0VDXBhcPRH1rPrHnMhEZPq5Y4Ow2bWc1U3rkS
 9vq2GeVyXyEPNP9xTyGlKL+euGF7mDgxkQVkPABsK/xK6V2OomXY4VaTHTNS/784SYOm
 nKLg==
X-Gm-Message-State: AOJu0Yz56o4VOtuZT17GdhalDOz1VhlzJD/ZVB5vD9NdP9kR3loVGULm
 B2e1yMl1gw2xES56E0b6FoUNwJ5Pv2kc3DdiPOugg4Z0vvUsXaOQ93l0WeCSxq/HAcHJBj14IcM
 =
X-Google-Smtp-Source: AGHT+IHO/Jmysr7nFoeFFD1R9rplhpZYRs3wXuCcyiJvcsXkHotjFuG9gHFdZLNJmUnPBrFR+BZNyw==
X-Received: by 2002:a5d:5586:0:b0:368:303b:8fe7 with SMTP id
 ffacd0b85a97d-369bbbb335fmr777551f8f.7.1721472617931; 
 Sat, 20 Jul 2024 03:50:17 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878684225sm3715616f8f.9.2024.07.20.03.50.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 03:50:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>, Marek Vasut <marex@denx.de>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 19/20] Makefile: Provide VPL devicetree and padding to binman
Date: Sat, 20 Jul 2024 11:49:49 +0100
Message-Id: <20240720104950.2730773-20-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240720104950.2730773-1-sjg@chromium.org>
References: <20240720104950.2730773-1-sjg@chromium.org>
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

Provide these parameters to binman so that it can produce images
targeted at VPL.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index f5b2512f369..d8e2e6a1b4b 100644
--- a/Makefile
+++ b/Makefile
@@ -1388,8 +1388,10 @@ cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
 		-a rockchip-tpl-path=$(ROCKCHIP_TPL) \
 		-a spl-bss-pad=$(if $(CONFIG_SPL_SEPARATE_BSS),,1) \
 		-a tpl-bss-pad=$(if $(CONFIG_TPL_SEPARATE_BSS),,1) \
+		-a vpl-bss-pad=$(if $(CONFIG_VPL_SEPARATE_BSS),,1) \
 		-a spl-dtb=$(CONFIG_SPL_OF_REAL) \
 		-a tpl-dtb=$(CONFIG_TPL_OF_REAL) \
+		-a vpl-dtb=$(CONFIG_VPL_OF_REAL) \
 		-a pre-load-key-path=${PRE_LOAD_KEY_PATH} \
 		$(BINMAN_$(@F))
 
-- 
2.34.1

