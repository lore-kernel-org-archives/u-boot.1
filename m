Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A2EC3ABDD
	for <u-boot@archiver.kernel.org>; Wed, 14 May 2025 16:17:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 979B782A1C;
	Wed, 14 May 2025 18:17:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PIlYkI2c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CED8F82A46; Wed, 14 May 2025 18:17:46 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C827682162
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 18:17:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cf628cb14so9030225e9.1
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 09:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747239464; x=1747844264; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HvImyuZiYvyEwh/9ScFml+Vg7PGDmA592FjSQQoGMH4=;
 b=PIlYkI2cLrRHLnYcVQt36tsDprpI/h6QmHt/deY8Sslr5G8OSl7SgXhpmGTnHwWS7T
 iSGDbhLzZRXEmWsa3+LXXF9tJoMzjnYvwb7ML+E0X0rQhi/LoQmlvlK9i1kPb1Kl6Qe+
 tI5ACPaILwLdfM3Kqy4Gg9I8mV+XPXLu3Wl1W+flejK0Xnrdb8+E/ipCOKzcc4zJOuWh
 zDX0ayr9QGNhAes4lW2diISD0vSGicVykMyChL4LJDz87EEnLzzXRUKnyVs721REG05w
 xGbwa8/9d8NT+TC6/EzDSXUI47lvYWanqFXSzbgZyriv4tlYNuEPHHD0vT49N4NQBWn/
 Tt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747239464; x=1747844264;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HvImyuZiYvyEwh/9ScFml+Vg7PGDmA592FjSQQoGMH4=;
 b=A7ScWbfhoWZaaduanc/dEAP83NbnWuPKpFEFHJOu9HD6JN21cjJcB0qtnQKuLs5Vvr
 Xkjn3E34lhzGTRdHK5AQQca+Xs20+8kLqUloYxMSRQes2xGWqzIQurd4QZttDfJUtFT7
 HQ2bFOnFZtvRMUI5FTB4QAjv3+tAW1XegzJ4e8XnHuNT9iIDiL+Z3dnUqyLFID6A0wUy
 6MaiOLPWkl7BC5EefiWeY0GC1WwjIr9tz2SF6/01xHZzzcYNb3EeT0vKeiYRENPRbnJ/
 9JeynsH7XRAU4pE2PbTYdr4n6fKXQnIkpm0ung0kMdRE07myrXTDW6aqFeIPjR3STcA9
 +wzA==
X-Gm-Message-State: AOJu0YwKKt3mlykIerJuD5u7PPrCT1XjZG1R1XTMR0Q3UQ6WwUlkuqmK
 a1mSp+HZHgjP9b01gzP8UYEL2Hb0ZgXZg/RFiybLETXKAaX8sRiVwTCnGkVVdas=
X-Gm-Gg: ASbGncuW1qohRmE3kE9sw0RYBaFifIBqpgVVRbFLjsjlIRhLhJNwxKhTWtPa/FJ2CMY
 B64P6XyfcQ5ayOt7cVHF3K7w/fa7r8m1eO8BKCPbVwkFWSBT4JAJ+cTsScCkRJKNXDISEUy0XEi
 Bo5g8jl50iCheVcyp9JLmay5hF/xd9hRj+nQ0gPz7wcH37fJi8P0mx4Fmly05tqmVgtVLlzIp9N
 wNGBEkefSrLbMP1t5L7l69KWloBavKbdX2mHU9Arkv9B11ltv1pAeysM6E2CDyNuBLb234W2MQO
 meRVKdLp7mv0+/tNka4PZq1r2jWxtzZ29i1Bfp2LTS3QT032QduTiL3fDn6w
X-Google-Smtp-Source: AGHT+IGlI3sq3nr1s2ZHU6ONst4ovR5MRsod7u2U+7YHRV8FoLLgQUQaoNMcINWmwlB5OtZu/IUhOA==
X-Received: by 2002:a05:600c:348d:b0:442:d9fb:d9a5 with SMTP id
 5b1f17b1804b1-442f84e4829mr1634005e9.9.1747239463892; 
 Wed, 14 May 2025 09:17:43 -0700 (PDT)
Received: from adriano.. ([213.157.19.135]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f752f527sm10835555e9.19.2025.05.14.09.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 09:17:43 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, jerome.forissier@linaro.org,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH v3 0/2] test/py: enable HTTP testing
Date: Wed, 14 May 2025 12:18:39 -0400
Message-ID: <20250514161841.3591411-1-adriano.cordova@canonical.com>
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

Adriano Cordova (2):
  CI testing: add http server to CI tests
  cmd/Kconfig: select CMD_WGET if ARCH_QEMU

 .azure-pipelines.yml | 11 +++++++++++
 .gitlab-ci.yml       | 11 +++++++++++
 cmd/Kconfig          |  2 +-
 3 files changed, 23 insertions(+), 1 deletion(-)

-- 
2.48.1

