Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FD1C3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 10:51:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2923B88C5C;
	Sat, 20 Jul 2024 12:50:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NIHUbhHw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A425E88BC0; Sat, 20 Jul 2024 12:50:13 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7499688C3A
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 12:50:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-36858357bb7so1148266f8f.2
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 03:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721472610; x=1722077410; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uhBO5IAmqkDe90P0FBq9rSNufT7LlpSkRyi8ty1Htz0=;
 b=NIHUbhHwBfPjUe1GwIWMN0ZACSE/LgvJW8sDcLoKRBTgOdcUlQjOBv/iDhNXHHporJ
 AFXatGIFPDIZCxy2aTlsJi0eJUIzWJjOz040Zl97D/QDZ8k6eame7kt7ltqbuXc4z3k0
 FgI8Cn/EHwZwaM9EsC/CfonMLdAX1YSKtc3Gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721472610; x=1722077410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uhBO5IAmqkDe90P0FBq9rSNufT7LlpSkRyi8ty1Htz0=;
 b=Qprp2flZ9LO36U3AFaNDlkjwg2Fpo5r/yz2lHsbTks29N0aZfHKjt1mmS+UXJjxP8l
 7s29WiKtQZ5zA0bLzweY7am8nwHjpJfvsczrxNntg7yDJ70u7sim3LeGj5PGlyq3uaZ7
 GHHXB4XscnBy1iEWDUtGxe13Zj/TjZZVuyFrOLvsSiXa5eEg3bFdRwuYeAZ3bjjExj5z
 z71uOjnvo4L4yjfEROCLb1IG+mbqPB/eWsU03/czw4VfCyjGLi+KMP4j6EvaH8pTvuUG
 vXZIxsi6Wl8yxq61UpWUYc8x2dkfBAUqToqqgZIZoNCpPFZLJSLUvIEDlI07gEZLxbXX
 EwHw==
X-Gm-Message-State: AOJu0YyIPbVLGy2dkWM9B6PxhPiPs+Twtxfrkb4R0Xbmr/jSOVToISF3
 UCq0Ngj5NA98GyVelSVASkQ/cq+DrrYyOWHvILR5iLs+CQryoJmWoVrS4XNR4CRGCKq9h71HoNk
 =
X-Google-Smtp-Source: AGHT+IH3HP+VrTrIqmk6pq7UT4ZGfP7JVjtC1hwejB00JWNLHklcXXp4y998dJozukfYtWDCFXVOkQ==
X-Received: by 2002:adf:f10d:0:b0:367:9c08:b94c with SMTP id
 ffacd0b85a97d-369bbc698a4mr756103f8f.42.1721472609723; 
 Sat, 20 Jul 2024 03:50:09 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878684225sm3715616f8f.9.2024.07.20.03.50.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 03:50:09 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>, Jonas Karlman <jonas@kwiboo.se>,
 Lukas Funke <lukas.funke@weidmueller.com>, Marek Vasut <marex@denx.de>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/20] binman: Fix a comment typo in _DoReadFileDtb()
Date: Sat, 20 Jul 2024 11:49:40 +0100
Message-Id: <20240720104950.2730773-11-sjg@chromium.org>
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

Fix a minor typo in this function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/ftest.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index e4da04030a5..bb691cb3ff2 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -546,7 +546,7 @@ class TestFunctional(unittest.TestCase):
             dtb_data = self._SetupDtb(fname)
 
             # For testing purposes, make a copy of the DT for SPL and TPL. Add
-            # a node indicating which it is, so aid verification.
+            # a node indicating which it is, to aid verification.
             for name in ['spl', 'tpl', 'vpl']:
                 dtb_fname = '%s/u-boot-%s.dtb' % (name, name)
                 outfile = os.path.join(self._indir, dtb_fname)
-- 
2.34.1

