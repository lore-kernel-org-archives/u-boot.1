Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 215BCC54EE3
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 12:12:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8B4388B5A;
	Wed, 28 Aug 2024 14:11:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Gutv4wh6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FA0488AA7; Wed, 28 Aug 2024 14:10:55 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80E8788AF8
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 14:10:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3730749ee7aso3899209f8f.2
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 05:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724847053; x=1725451853; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tt2vjY7MaKscycbDjgQS+EhvZk4u1eI0iM4tc60Fq+8=;
 b=Gutv4wh6LfIhPaHvquQIMpPqBr0MfavTkWTC4OT+maF58Vd1NsGJr0HKLnUjtJoYzj
 Se1pS6qCfkLMfGnGZeSCeomwzEWauo4+Cq08E1TjMQuHN8A5vuqdyL0HcWantXw3dx6g
 xtwhPBaorsyHCZ55Wlo7yBxZt3qn3EFoqUeLo+w3CyfUaeR3x0dNUvLCSV/lp8aL5r7C
 6KT76RfyvUe00T9uGZYBjMKSWobOwN2g0R9ji8cf2qBJJzDgYpFccKHjiouJW/WV3EGh
 nxMFGByMLiTXQHPgnuEslkeSKNNshlUBVhWwCyMOywV1nRXbac9eTZRcIIcrunQ3rU1Q
 z+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724847053; x=1725451853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tt2vjY7MaKscycbDjgQS+EhvZk4u1eI0iM4tc60Fq+8=;
 b=TO0RszQvHe2Zct27RgxdfWG0+q4FVvpza2Y+fAMluEdYHqR5sC1juVnoyZZ40MaWEK
 2kovgTgAgrFjIOi4LP7pTRayaD4oaYrTYIzjyllKyjJMBI5IUn8vW5XEM4LjemBlgQ+7
 /rU3VyBI3+kvcgmRHXGlpn9lv6NOzfCqZ8yLbzPI4QGd1yjDYlWBT/m3rmzLuk3nzvQP
 etlk3pWTqP12K4ASo7pIsb3y9hH8JSjHvz3LzVev4tDdGZDTpFbPJaoN4G9RonHCOSKy
 t9lQ2yVIFuaiBERGEf/J3dwhTMgqrnEW1YIS0FNzYETIpnIPpIuxWfWj1wHAQhRI4xlG
 0N4Q==
X-Gm-Message-State: AOJu0YwCR6zNQAX9PH5zAGOS1fhjV5MErIwxlG06V5PMgpVJ2CAcDB2S
 Szq099AyxSGLRaVIiBPF/lsE9Oc5djLy+MAj5q9CD7AQgb2Ztkj/ZESI5w7JbO9Yt/DntF7yEdo
 Ys83Cl4F3
X-Google-Smtp-Source: AGHT+IHKMLDry5yqq8F6hoaqPodWpQbGAvy9nlH0WDpSPKCTKCfoTd0G8U4tfMSXgylcOc7jrJQ86Q==
X-Received: by 2002:a5d:5911:0:b0:371:728e:d000 with SMTP id
 ffacd0b85a97d-3749680af92mr1212900f8f.1.1724847052741; 
 Wed, 28 Aug 2024 05:10:52 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:8ac3:aada:f033:985a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ba639687csm19470365e9.8.2024.08.28.05.10.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 05:10:52 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Love Kumar <love.kumar@amd.com>
Subject: [PATCH 11/13] test/py: net_boot: fix comment
Date: Wed, 28 Aug 2024 14:10:34 +0200
Message-Id: <418bd1a5d16cf1e0061fd499ac82bef5bae82f68.1724846454.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1724846454.git.jerome.forissier@linaro.org>
References: <cover.1724846454.git.jerome.forissier@linaro.org>
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

If env__pxe_boot_test_skip is not present, it defaults to True not
False. Therefore fix the comment.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 test/py/tests/test_net_boot.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/tests/test_net_boot.py b/test/py/tests/test_net_boot.py
index 63309fe82e..d7d7435692 100644
--- a/test/py/tests/test_net_boot.py
+++ b/test/py/tests/test_net_boot.py
@@ -75,7 +75,7 @@ env__net_pxe_bootable_file = {
     'check_pattern': 'ERROR',
 }
 
-# False or omitted if a PXE boot test should be tested.
+# False if a PXE boot test should be tested.
 # If PXE boot testing is not possible or desired, set this variable to True.
 # For example: If pxe configuration file is not proper to boot
 env__pxe_boot_test_skip = False
-- 
2.40.1

