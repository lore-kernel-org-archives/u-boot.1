Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A41C3ABC9
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 08:52:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EBB180107;
	Fri, 16 May 2025 10:52:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RnheHso0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B1F78288D; Fri, 16 May 2025 10:52:23 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E57B80079
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 10:52:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso12321865e9.3
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 01:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747385541; x=1747990341; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wuy8OJuCXQ/xSvtMVwXLcbw8ayrb0y2dcT+BS9Jc//g=;
 b=RnheHso0LA3qx7WridC1bwwKnPSEASYW+AgR2humEIVxiKnGXfaeIrRhg1K+yqGFQ+
 gy0zu1INPIuoTLLG8UUAIWdSpyTUDOGupt/YhFqBDlUGCysLXZfX2zJtVLLchWTes263
 Ih+UIatoYm4KUA4+wDL4/AOiFnl9BRvl0kq2P8DBHkgWoFafZsUJNgcMROW4AXIepV5D
 hZXSWlhq7hm//Sy4XLz77LZcekuf5YKjaqpM48pNKNeCZxihFWh/kzb9sfPIn3wySZ0L
 nzE3ZbatMQtBhk+tbHTfIidsD7ck8wGtUPteQ1rWWFL2h9tr2MelGlbEyIvF+wUEh1QB
 qP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747385541; x=1747990341;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wuy8OJuCXQ/xSvtMVwXLcbw8ayrb0y2dcT+BS9Jc//g=;
 b=XPS15e9mutQJpXt3IvHBnyMieDnIDqiZSgujTa2en+ZeJP6PrqeRSECIBPVcwQKSfv
 8ldUReJLqZlrnxH51Z3oxkK30KECoEY8paessQ7VouNbOsqAjPNYmFPZgwfUhY9MZJQI
 o0PVFwVmXpwmFxqPRJoeDwCIjMbSH00fFMdMhE8kJzkydVr9zz/9+PYmtjmc52k7CysV
 JN7BzrFYxwzEeLS3kxlTNKj3e9c4yyUGo16n7qt4Pzg0fa3gmoPVlu5DACBaS3DFXJSi
 Ac0k+jNlWOkageFwNDj31H7850ufF56mrR028t+sUWuAFXYMEU5luO/MrnZMzo3IVXR9
 AR7A==
X-Gm-Message-State: AOJu0Yw0udIalYuaguJldIwhB08hPd0i+wim9nqmPVaYv6Ki1soQssvb
 Cj32Z4bX+Y8vX/tGFLqw3QIlKIfxNvfaqb1oqby0IVIfR6iv/xHSAwiSnxJSQXG3+U0=
X-Gm-Gg: ASbGncvsqAssC3M8eavyb9o4IQt5hlLmxFg3YKL6BbTaqanYEQ/JuqaHTBdpF9zFbzD
 TfubOY/hpdJZXb10LS8fSWPLtXtIMlqoutdDo+EwGLOAcFkgSAIAIyYn4G8GOYRR/Soc28bpJQ1
 8Zv7mFaOsMO5WY3nZbO5q+4w5QuSAi0q8V6GPMW+1HOXlfdI/vjzUqXQ27hGj/P1jdswnW4g3gN
 +9KB6Mo4c+Fs1LXRnsrJuWE8UhBs/GbtGtkA3rpmlOLYTc1nkWduizlfl+yH9M9uvN0dC2aG6p/
 V3tTsMHvcZmvj/xWOAqfmGGgUHSKOy8V4Ypws8RkaR9ZHZams9MR66C6fhZsWg==
X-Google-Smtp-Source: AGHT+IHBXfkx0k2lmcGBKh46Walu8/yXzJw+6yHBA0l0lS43B91KrXhW/APL4KFz0rC8wJIh5fY6XQ==
X-Received: by 2002:a05:600c:4f42:b0:442:dc75:5625 with SMTP id
 5b1f17b1804b1-442fd60cb7bmr22079565e9.5.1747385540462; 
 Fri, 16 May 2025 01:52:20 -0700 (PDT)
Received: from adriano.. ([213.157.19.150]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f39ef81csm96801125e9.34.2025.05.16.01.52.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 01:52:19 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, jerome.forissier@linaro.org, rfried.dev@gmail.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH v4 0/2] test/py: enable HTTP testing
Date: Fri, 16 May 2025 04:52:54 -0400
Message-ID: <20250516085256.30386-1-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
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

Enable HTTP server in CI to support HTTP tests in pytest

QEMU does not emulate an HTTP server, unlike other services like DHCP or TFTP.
To enable HTTP  tests during CI runs, start a simple Python HTTP server
on port 80. This allows tests that require HTTP access to run.

The HTTP server is launched on the host. For QEMU environments launched
with '-netdev,user' this means that the HTTP server runs together with DHCP
at 10.0.2.2.  HTTP testing needs to be explicitly enabled with
env__efi_helloworld_net_http_test_skip = False.

We also default `WGET=y` in `ARCH_QEMU` configurations so that these HTTP
tests are included automatically when using QEMU in CI.

changes in v2:
  - patch 1/3: do not add any extra parameter to conftest.py informing of
    the httpserver

changes in v3:
  - patch 3/3: deleted. Do not default to
    env__efi_helloworld_net_http_test_skip = False. Let the test be enabled
    explicitly if wanted. Now the name of the series does not make much sense.

changes in v4:
  - patch 2/2: remove comment in .gitlab-ci.yml that was preventing parsing

Adriano Cordova (2):
  CI testing: add http server to CI tests
  cmd/Kconfig: select CMD_WGET if ARCH_QEMU

 .azure-pipelines.yml | 11 +++++++++++
 .gitlab-ci.yml       | 11 +++++++++++
 cmd/Kconfig          |  2 +-
 3 files changed, 23 insertions(+), 1 deletion(-)

-- 
2.48.1

