Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 443AEC44515
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 08:23:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20F81846B0;
	Mon, 20 Jul 2026 10:23:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XwAsYi/2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDF2480517; Mon, 20 Jul 2026 10:23:38 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1045838D7
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 10:23:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4953e04ef16so40217635e9.2
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 01:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784535816; x=1785140616; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y/AtmA9/dAGsu2lQ/eOZ2tsd2QJUU7eAcWiLmV6F7oM=;
 b=XwAsYi/2zxGhIsuMtQAPI902dzysto7qq7erdFoPoPQGuHJB7nLGYpihEJpqV7mp8R
 l1rRDnHvQsjprp8GreKzUx2Rcm0818DxJ44n53xGpUqip59GtPZbrMG/PeLOE7cazKPC
 11HZK/ch3tn210mAlVm5jzhSQ10sMIUbzAjicdrPKQz9f5T8WpHGyX+743G6eqlFuwZm
 IaaoQnB8bpJu3KODhLSkVcZfXYvsbhSA4/zFIAWhHknj5gM1z57NSUw1L4juOPZKp2e2
 JtSnkplnKwaURyuqJGkbOQrRfJLxKZwtBmOks9GCfldQwVIUuS68lI2/ChpU06tried0
 H4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784535816; x=1785140616;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y/AtmA9/dAGsu2lQ/eOZ2tsd2QJUU7eAcWiLmV6F7oM=;
 b=AyPQxrggBKiLnprkfWXBKP/Np/zly2Fbfi8+n4ofkf/Aoaa99hPhDVTX5vcRkZv446
 k5KWqq1KbreA8blHYUJwWHMKYlwjLcBkUiosk9rhAhqoQV171WGuwsv4SNOhibjwRVmJ
 mx1rNrMIzqJBm3IjBuSCzYjcu3vXRhsxV6ePMNGfVJWOGA96kP83Ha2/zlhCLqwTSnvc
 tpa+GryaeAp88h/wRja72YABd3BxZR/9NjmatKcR8DRj0ys4SyY8zOs9XZOJSsEqUwDc
 glaZlE55F0qB9aaOT0JVaXIG+nlP80DUgX0Ifq74BlhEZU+q8fxMLNaQSqKqGDc1M3AF
 2RlA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoDrBafZrJI4FDHYvb3GOeY/tDgEz5zSysCk+YlFPVlihEGt7kAw9pZW3auHrN7MeALcD9kddc=@lists.denx.de
X-Gm-Message-State: AOJu0YyQSTzwKajnEkzPfWxEb9y4+l0X1Yyabil8DKb1fGrhJLQb+yof
 4bqkqjAxE3kcpTZSviVpkUdomTkf/te53tqb/DYgukAwZEmvy4Ov5GIEikr6EsGUOOM=
X-Gm-Gg: AfdE7clIVNKRTPfmMjbsIrp8U0hP6ZGBP8YZ3nJs+g4B7vMf0SHHFwJMnEOdC1+fpqU
 i/s0Cy4TXRTT54UVzB8DeGuAmRV/7MlHjs4a3S+vU6mdzg60Fgbb3lzUFY7FefZy60HR/YS2a+Y
 F7mXg0st+ECkTudiHc6fw7VQoDq9FiYH9aRffN2vUEZ5bxb98lJAfEK7YKc0l7qtsm48xrupAf1
 M43yBK/XJBOJv3lbG1k6ACTMMUdwBa0EKhHvk/MNaCQPoFfH/NLmTKM23JdSHDML2ZTA0XbxuFS
 /tGJjxum17p0XWzlUA6LdQHxUT7tCFXwTxpXWqzrwByRE8lD4RC2oa545+Cw23TmPON4WOX4Ze4
 MSSpof7TTcm+l1HZccvJwXdOAAZQ+Rwghwo6hrn6qrwe1vpwssBN9u1zs+aru/PtwM0cOjSV5LH
 V3ZvAb7+oFVrDgrIW9+pou+o81AmfGSPhWbw==
X-Received: by 2002:a05:600c:1554:b0:493:a570:df7d with SMTP id
 5b1f17b1804b1-4954a402f91mr154240595e9.20.1784535816290; 
 Mon, 20 Jul 2026 01:23:36 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49549c9c940sm242852495e9.13.2026.07.20.01.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 01:23:35 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 20 Jul 2026 10:23:29 +0200
Subject: [PATCH v4 1/3] tools/patman: Migrate mailing-list to
 lists.u-boot-project.org
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-osuosl-ml-switch-v4-1-20ec1c334dd2@linaro.org>
References: <20260720-osuosl-ml-switch-v4-0-20ec1c334dd2@linaro.org>
In-Reply-To: <20260720-osuosl-ml-switch-v4-0-20ec1c334dd2@linaro.org>
To: u-boot@lists.u-boot-project.org, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tony Dinh <mibodhi@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Heiko Schocher <hs@nabladev.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, Heiko Stuebner <heiko@sntech.de>, 
 David Lechner <dlechner@baylibre.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Walter Schweizer <walter.schweizer@siemens.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=864;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=jMqFFJna27R0nJL2DrUFja+iHMOb/f1mP6bOhHnQcDs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqXdsEAI9UA9Q8DWhGY+PzEFOoQ6AXoeBqHC7DxQii
 LTa5DueJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCal3bBAAKCRB33NvayMhJ0RYDD/
 wPpkooLrn/wRK6AyszxTSUrwaokq+Qs89NtY1BBgpa1Bthyha3RKIG2AVGsak38Wy/tTYrZZGwBgDO
 30A5wANThnU0Nx2TnK4cSTAHdQiiIizBh5Wfc7BLZy7SmKL3PGd+zgeErS6yBIPJmOxGwlbmRAwY7b
 yYFDN+SCVB+0dISNiqaoBoAY6xfiqqiny18EBSRpHUUj3Nu4JPBzeq16JKgYlsZ4na9xJ1QxkQLVMx
 KV0rBqvekpv1f6OUI4SUM8TGrhohDyXBCnTBqaY0bFIXNzV2NnEntsUC8+DmrmVqrcTm6ndeRMDcHS
 FReKC9vjOYF84HS+FUCPk2fW3RacuJQEMJLMCq3Kk8q4hceMwNIdreMSlXspJ+/uBX35VY+PF7srkq
 vFclqYEc0MwPST55OdliqKhM6nM1sxHU49Oe/OZwhxJEeK/RdtkSFqZNkKyMDX+xY9IFu6sJtKJijQ
 sTjl1Oo2FF76B1ncFmPSRNJ0EA0wLDN0KDjGq9MwqSeaon4U8zv1XVq34VPekubovznpJV9yfROhTb
 a/FKcyd/wSbaqKtPHaWvsQ9VBJnZQVGGNt7YVkO+I6TJUz8l9bEihoE+a0dJDQY70w9xGFb9KLlpNG
 Lm4Ve/3rBGaTai8+9CjmphQOgUNaLVDrRM93pj71yFPUhSGnSkgHstxBOlyQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

The U-Boot Mailing-list is moving to the lists.u-boot-project.org
domain, so update all references of the list.denx.de to the new
domain in the patman code.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 tools/patman/settings.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/patman/settings.py b/tools/patman/settings.py
index 17229e0d823..fe65b1d3fb7 100644
--- a/tools/patman/settings.py
+++ b/tools/patman/settings.py
@@ -162,7 +162,7 @@ class _ProjectConfigParser(ConfigParser.ConfigParser):
 def ReadGitAliases(fname):
     """Read a git alias file. This is in the form used by git:
 
-    alias uboot  u-boot@lists.denx.de
+    alias uboot  u-boot@lists.u-boot-project.org
     alias wd     Wolfgang Denk <wd@denx.de>
 
     Args:

-- 
2.34.1

