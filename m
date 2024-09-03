Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08ACECD13CF
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 08:41:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 930B388C6D;
	Tue,  3 Sep 2024 10:39:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="leJCoF8N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 291F588D40; Tue,  3 Sep 2024 10:39:07 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D66E588D28
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 10:39:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42bb9d719d4so36858735e9.3
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 01:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725352744; x=1725957544; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P9w4C1VZJ/ZW0U+WL/32spA/yy3oQgcllZbaXrOSnAI=;
 b=leJCoF8NoqAcx1THakWVfMveKqGdypQBMD42MWEhKa0BBA4y6IJhqj52fFDoCUHg2B
 LWiN0IMmsZ22Qtii3NTb8iY2eBab6BVkXODHq9dwqH/Ro4txTTDCRG31B/nUXAwql1e2
 UgXylyXkLm94PunSCQA9+IUDFvwjak+ibxysneR27Gfn16mkg/DxI13OjWsp2w7D6SvZ
 xwaKhe0KTXJSnuYVyzuTly9vOyIbRkueuJwSlP5MHPnGfDI3T1uAkjm9KI+INX3ZPZqd
 Rku6a5XdoxKJ0oMU4xzDA44G3MJjy4yby1EAe2HsD9D7NNleTcOUN4WwHpeRpLfvoivc
 nncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725352744; x=1725957544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P9w4C1VZJ/ZW0U+WL/32spA/yy3oQgcllZbaXrOSnAI=;
 b=tSn8wAxyw+Dt+ae3p4xrAceWnSZ0kMccmwGMTLo12LVb15etnZiG3Z37yJkuK6uJL0
 2KeYUmlgFxml1AsZxWol/n1G2ZeG97Wui0I22fxAYOpJX2Q8jbKxuX3J0ku/bYLFmt8B
 R2L97MUQ31h7Ce3w3/8KfjwetC1WTrYlpvqnCrJjyFn7UraDSC3E90/xpLkccYg8oN3f
 S/dJfUuO5ZyzV5powOdPxZo+JD6azJbh/4zqjJfWkCZdVfyN79eQWIjF4DaBCfQVughY
 6pBcp9TI26Z+HFoeoeJDcAFJ4QGHbbiXjpkPShhv9jtz5cmcR681977XNeoQkfadxfFU
 9x/A==
X-Gm-Message-State: AOJu0Yznok/ywAAUhkD7TkdP0HUUtBnbPoSk6dtzt3n+GAlh7viACxCV
 BDYyQbTW1DLeUSSlQgm4aU3ATDZox75C44HBUmR2cUrP6t6mHOQr+C4S+h2sbrYYVnrHaZdAjKT
 P70Ug62aY
X-Google-Smtp-Source: AGHT+IHLXvZVf6ZfkFkJA821e4VcJpfKBF7pNMxQOhTHMg/9+2I7vGVejBnpcFA4O4j4En0kyOTIwg==
X-Received: by 2002:a05:600c:1d9b:b0:426:8ee5:5d24 with SMTP id
 5b1f17b1804b1-42c880f41f0mr22473885e9.20.1725352744112; 
 Tue, 03 Sep 2024 01:39:04 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df795asm163103325e9.21.2024.09.03.01.39.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 01:39:03 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v3 16/16] cmd: pxe: CMD_PXE implies CMD_TFTPBOOT
Date: Tue,  3 Sep 2024 10:38:13 +0200
Message-Id: <36e09ed4de54d0b21006fa098f4ce1837bbb6419.1725351676.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1725351676.git.jerome.forissier@linaro.org>
References: <cover.1725351676.git.jerome.forissier@linaro.org>
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

cmd/pxe.c (CMD_PXE) calls do_get_tftp() (CMD_TFTPBOOT) therefore add
an "imply" to cmd/Kconfig.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
---
 cmd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 978f44eda42..be15a4d2670 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2091,6 +2091,7 @@ config CMD_ETHSW
 config CMD_PXE
 	bool "pxe"
 	select PXE_UTILS
+	imply CMD_TFTPBOOT
 	help
 	  Boot image via network using PXE protocol
 
-- 
2.40.1

