Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 291FAC3ABC3
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 15:43:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAD4482935;
	Fri,  9 May 2025 17:43:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kSE/gtBZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DEAB82A1C; Fri,  9 May 2025 17:43:13 +0200 (CEST)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 498C4829E7
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 17:43:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-4def1dbfd50so237348137.3
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 08:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746805390; x=1747410190; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5XLLvDboMexhQM9Z1LcP63oXbw7xCLbMTeNlwRSE5mU=;
 b=kSE/gtBZdt/kJvs/j5oD6wpoJWnIO6aurj2roSj+Nd2o4+WMrowLeFxtSKrjhu+4Wr
 vQpzlC5dXCnw1YXKICI6Iw4OKgGLYh+TtWwGQV5LcQlgrTEJwOKYhOUHqMyG0LEhogEg
 qqsLNteObylaUrYVhJPq/oxFNJ8Jdq+ifVChdVEFwdLDs3hJvzyqG/NdHpkIQWeHZVGJ
 a94s2rPCLENxJYI/b7XiRsxkr43Mqsem2htHPianMNLloAuNQ+E3/SzEtKR4s6ZjMbZL
 q7dDsGfpzhS3cjyj8IFPJLNNWP0HEZ+b/IfIAq4gDn//1CvxbJRbX9CuqRNbEIMNXBLV
 /Zuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746805390; x=1747410190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5XLLvDboMexhQM9Z1LcP63oXbw7xCLbMTeNlwRSE5mU=;
 b=imG4tW858LzQZAmD1AcldMty69IzqCczRmc6VZhWK/mx4Qh9czkAok7WJ8F4/cz5Rs
 OSlQN7fNNXGyBcSCXQELMi4Hd35MWSYyGQb6evHxwIornKrMDg1MqyLsOd7/DSRv58bS
 W69LSCZcXaPe8HR8bd1ME8d7N5clQ80ktsAOJhIjNMMIQ1WwgaS/YDthWB+v4fBag/7w
 lZECggYE4aQ8lN5L+14cpDxBISSHiEE8NYggiQ2Xj291gzortWguZoouay/amXu0g5KP
 FBpIrc0EtazrN3jV4DlHU3KWw1SuOoc1MHiX9I3IPp4r7BE/uAFY28fboLr5DZbH9Y8Q
 pL6A==
X-Gm-Message-State: AOJu0YxK+cjF0c0TerS70oKpUrKQmiVU4nunP7cgtVeArQGB9/k+nq6o
 VXfBd+yHdiknNXtt6psBBRfgBLUUCW1uEFjb8ttkzsut4dR/T9M/LDsTuUgI
X-Gm-Gg: ASbGncvi0RhhMyZXcUOGn1ytkjL/W2zrk9/TBjujhoLdqFzrMNc0O8JJ8XudvuRcVIi
 pdlANP5cX9Ou7dZmFNknrcnm1c0RGi67HYmGXbfs8OwcEjEGe4jl7ZnwsqqpGiLpjqk91sTiTvl
 WOLqA4lx1VYPEKxOB2JXLUPjeo9hbR8QJIoHiYF+5C3gpVqxpbjP5Vg1DouiKOB5QBZwn8IaAqX
 juZg96D1O182VLroDMrFPC/zxWfTQLQQt4rZjZXKX+UXu2QcBr3+Oomt6bScv/XaSwJZ5lEFIy1
 6NK8zmu6R/5S2mveEp2Llo/hy1Xno+LSu2U6+ScJGFeVzwbtyYQu
X-Google-Smtp-Source: AGHT+IGBvx/OPVv/y8X+tR6JJx1qKCy0N7XgA6k1Z7UZ4geiBQaiExojr50JoHP+aEwOgB5abKuqzQ==
X-Received: by 2002:a05:6102:4bc7:b0:4c3:6a7e:c9f3 with SMTP id
 ada2fe7eead31-4deed2ff087mr3889647137.3.1746805390116; 
 Fri, 09 May 2025 08:43:10 -0700 (PDT)
Received: from adriano.. ([2800:300:6f54:8180:9366:b0c8:336a:d2c7])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-4deb203c1d4sm1303285137.28.2025.05.09.08.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 08:43:09 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 3/3] py/tests/test_efi_loader.py: execute HTTP testing if
 httpserver is provided
Date: Fri,  9 May 2025 11:43:52 -0400
Message-ID: <20250509154352.3483523-4-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250509154352.3483523-1-adriano.cordova@canonical.com>
References: <20250509154352.3483523-1-adriano.cordova@canonical.com>
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

Execute test_efi_helloworld_net_http if an HTTP server is
provided in the test environment.

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 test/py/tests/test_efi_loader.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/test/py/tests/test_efi_loader.py b/test/py/tests/test_efi_loader.py
index 58f2655191f..75a638030d1 100644
--- a/test/py/tests/test_efi_loader.py
+++ b/test/py/tests/test_efi_loader.py
@@ -190,9 +190,12 @@ def test_efi_helloworld_net_http(ubman):
     The helloworld.efi file is downloaded from the HTTP server and is executed
     using the fallback device tree at $fdtcontroladdr.
     """
-    if ubman.config.env.get('env__efi_helloworld_net_http_test_skip', True):
+    if ubman.config.env.get('env__efi_helloworld_net_http_test_skip', False):
         pytest.skip('helloworld.efi HTTP test is not enabled!')
 
+    if not ubman.config.httpserver:
+        pytest.skip('HTTP server is not up')
+
     do_test_efi_helloworld_net(ubman, PROTO_HTTP);
 
 @pytest.mark.buildconfigspec('cmd_bootefi_hello')
-- 
2.48.1

