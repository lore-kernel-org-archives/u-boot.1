Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B4CC369C9
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 18:19:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 357178318F;
	Thu, 17 Apr 2025 20:17:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YEYycKtD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31F3783100; Thu, 17 Apr 2025 20:17:30 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C60F830AB
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 20:17:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3d6d162e516so8067995ab.1
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 11:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744913845; x=1745518645; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EQiVdwsNMU00OSE6PMAdupi2KzelisUfK+JEe9ivhGI=;
 b=YEYycKtDm34aNxWTJF9+EqPI1iAd10IJQovij4yM+tNHihSgaF+9dPod3BIwPaMwyL
 vyOUqVMR7ECr1pcjuw92J+goHOU9eELizvyhPyJLzjpCMaiG3rjNl5heosWkWHtiJvZb
 UGfYyHcLnGw0VRiKUnls69bOFxvBaDDwk/cGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744913845; x=1745518645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EQiVdwsNMU00OSE6PMAdupi2KzelisUfK+JEe9ivhGI=;
 b=KjDw6/cfSYedrBKDShxGNnYwkkEUd8WiP8li5u9iBe990MuTtcmVdT9L0aEdo/KC5Q
 QX/ds3L85TO6bQpDXNZ/91+Uhs0GCF0RQS/wh3Lizct37Q0jbdN3hmHJaclfZUCcbOTK
 D69SnYwOHpu0nrISAy3UP1dzz4M7sK2l2Ax1L4lxmZNUswiHU8mEqz3U7y+IX6rQxI39
 5oO19SGc3Vhq/ybJWCJwZi7WNje8QbdwqdcWOqU9NmYGC0w8EiM586zUmwflKcii470U
 IuWXk7N3E3PkBMILRkHXZkzlV6oj7QEPk7E8RdAU0LnFyy6crhggQwe+ZbgJ7efQ5hYr
 /1jA==
X-Gm-Message-State: AOJu0Yxl6g2POl+X5n9HiE8OI3TpMqdJZsjYN2wXeSyAosIuR0XEDNFg
 W6+DxovTyPWC17NBNWwTW56qgDcOT6Rj/wG8A4r5mtCIgH0nDyhBWBbxblmQ4WKOrAkPuh4AAVE
 =
X-Gm-Gg: ASbGncvC0uFHJuV7fRGZcs8epMkCgeQ2Di4uUSxnSZ0pt04aZ7ZTC8PSn8t1i1vQEpu
 KoejYDTyMPrgKZdugrv6fqM7/Qtuv+mqlGgvQfhrwlqavAsq/8ymCn2rXfJQL6sRJhFo+3DMYaj
 WdzP3C0thf6kItFs7MDjJSYMfKj77TOgOlMLRZMXHvfg4WaWWyS1N8h13bP1B8WSwSFqdDlySGz
 PecYkQYXn8kogLOEVpx9fhT4R/bQFxGQZvXEV+jVRx/nKZrJzzH7vAO1eYKbZ7YS1vzrRZrc4bO
 /Nxr6Myk/mxXq8zMUfaDqC09mQvN7L7DimUHpwiML/gsjyAapI1h3TQQJsQi8NvZqTZtDq7xGnI
 JHbY9spt+rRCv
X-Google-Smtp-Source: AGHT+IFWKFD36MTMO4hFMJ1NPIOHx7EwaKdh2OJtdzo+P0FW54qIfcHNNTOT7CiDjlni/IIYTMFExg==
X-Received: by 2002:a05:6e02:12ca:b0:3d3:d823:5402 with SMTP id
 e9e14a558f8ab-3d88ed95701mr1603255ab.7.1744913844291; 
 Thu, 17 Apr 2025 11:17:24 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f6a37cb9aesm66673173.28.2025.04.17.11.17.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 11:17:23 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v3 22/22] CI: Add tests for gitlab and azure
Date: Thu, 17 Apr 2025 12:16:04 -0600
Message-ID: <20250417121601.v3.22.I321f53b875ffb594a569796509e64830b9f3fe09@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417181613.1355024-1-sjg@chromium.org>
References: <20250417181613.1355024-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add tests that

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add test for aarch64
- Add tests for azure

 .azure-pipelines.yml |  6 ++++++
 .gitlab-ci.yml       | 12 ++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index cb787d32f14..737ba61b46a 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -444,6 +444,12 @@ stages:
         qemu_arm_sbsa_ref:
           TEST_PY_BD: "qemu-arm-sbsa"
           TEST_PY_TEST_SPEC: "not sleep"
+        qemu_arm_spl:
+          TEST_PY_BD: "qemu_arm_spl"
+          TEST_PY_TEST_SPEC: "test_passage"
+        qemu_arm64_spl:
+          TEST_PY_BD: "qemu_arm64_spl"
+          TEST_PY_TEST_SPEC: "test_passage"
         qemu_m68k:
           TEST_PY_BD: "M5208EVBE"
           TEST_PY_ID: "--id qemu"
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 5f3418e482f..7e42859faa3 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -376,6 +376,18 @@ qemu_arm_sbsa test.py:
     TEST_PY_TEST_SPEC: "not sleep"
   <<: *buildman_and_testpy_dfn
 
+qemu_arm spl_test.py:
+  variables:
+    TEST_PY_BD: "qemu_arm_spl"
+    TEST_PY_TEST_SPEC: "test_passage"
+  <<: *buildman_and_testpy_dfn
+
+qemu_arm64 spl_test.py:
+  variables:
+    TEST_PY_BD: "qemu_arm64_spl"
+    TEST_PY_TEST_SPEC: "test_passage"
+  <<: *buildman_and_testpy_dfn
+
 qemu_m68k test.py:
   variables:
     TEST_PY_BD: "M5208EVBE"
-- 
2.43.0

