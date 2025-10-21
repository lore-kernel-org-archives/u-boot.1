Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE03DCCD1A7
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 18:18:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 009EF8323A;
	Tue, 21 Oct 2025 20:18:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="R0bfnSAp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD7B78362A; Tue, 21 Oct 2025 20:17:58 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97A7D802C1
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 20:17:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-87be45cba29so81589236d6.2
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 11:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761070675; x=1761675475; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wSZJLAj0BMpvgmpRl4uhjkuBlh03exjRc/O7a9UT75Y=;
 b=R0bfnSApm6Up34Xt/3CrgbLrNigdLy4wKMHoTPDHHi63041xRpais9vR7fHrWM6IVa
 IIzEYkPxkmfssWv2lZDtC1qRnCE73CVNagzXTIPfX7WbE8hWiZSprsATf8xFiwnMlWnZ
 uqt7LxFDOlutbhXg5SaZ25FJnWWzq6qSbcSphU0+p3U9HQr2qBEMmJYYh2BJnrzFTzmi
 edu8X5yz60fmAGPndt136z8sohrAEMz4vboZgiRKHVAqu9Jt3cwpQc8oKLcfh9icBYaX
 txemO2MFX82HbdozbFPoq+YgwgKPpgj7SHf3z+mphmvpBcFp5gxPPgyIeFLkmaOK6HUH
 u9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761070675; x=1761675475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wSZJLAj0BMpvgmpRl4uhjkuBlh03exjRc/O7a9UT75Y=;
 b=KmbSMbSo1c6cYCyevjhq4Dz/FcF9WaXwTgiLSqChw7SJAWZvQyKmSPXxe+7Je//SVw
 rrbgEZIagcVrbRcrfZaUy0cLidyduK8v4Spj6vy2rngK+WJe+ZpZh1JrRplAaIYa7Czv
 qthT5tnWw8K1YkitOG+ZhYzdiqwCXFaQkFqvHZkhObmAKwiwWls35U6AWWDvjh+0acGX
 bRIOXJjl8AbPp1RZJQmjT1a7G5QzlzyRKtc7OppCKwPBen6DkIZ/fNtF3b9cw4PrcWoh
 oq7UZefOxzyBxavzBS/P4dkBEN4mh1ZfbQpbntoKjae0ovsCwi7caakF5tVRfs4GAu1H
 QT9Q==
X-Gm-Message-State: AOJu0YyIEdmkVFw6LAhWwbj+HFL2e4k3g76EEx+onfIwm077yFxQdkFJ
 V8GkXvkQrQj40BvWcmPsvnJR+pSniOsmPalO8qaom2nEeWasMUOy0de3z/bhoHxp55cViz3ZkGu
 0q/4f
X-Gm-Gg: ASbGncuX5MI/KSztrEfkN8QoQV7pje9nDHU2fSpPpVxNVtpehuUFjDI+88W5oPcVigz
 Evs8v63jZxyKwdSoPH4CWi0/aliEVW23kzbuk+MC2zgjzGMpeGQ2/5j3FwY+RnmibmOszUxrJY6
 rMF3D3tqpWLPPw1Z8UmP9rP8PtfBaVUnqrp+9kgsXWVmziUjlhlT7w57w6a3KGa3skm3JYtZ72r
 QzskqhnkajrxlkIJ8e3eBYXWCKc/OLImIXJwQH8j+XL1wNx/goUSZ9JAuNePRlzHRmCZfxkQa2N
 M5mPkBMz5wcdFbWniQjQehgyGf7bGy3XCeyx1N3QpwFPu0/zLkbTolM8UpyxDjVtwQiQWW2ejOt
 ppCRe4ayBPRqVov1Ka3CsUz7AvbNaWq6vkTADcdj8iSg0RR9oZWKjXKn9+3mhgv9zZCpamSgyCA
 y6O0C1UQMfIjQUx6qgvAcubACynis=
X-Google-Smtp-Source: AGHT+IFPOfnLN3iKE1nXwNhbiE7U7i/sysLGH+bEOAIQnlT3Xl3QfsqYuEhjzm0CSuLk6bbX+OI7QQ==
X-Received: by 2002:a05:6214:27ce:b0:87d:dcfb:aba2 with SMTP id
 6a1803df08f44-87ddcfbac73mr96542586d6.47.1761070675029; 
 Tue, 21 Oct 2025 11:17:55 -0700 (PDT)
Received: from localhost.localdomain ([209.227.150.67])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87d02884878sm72831526d6.31.2025.10.21.11.17.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 11:17:54 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [RESEND PATCH v5 5/5] ci: add test entries for
 qemu_arm64_tfa_fw_handoff
Date: Tue, 21 Oct 2025 11:16:58 -0700
Message-Id: <20251021181703.598342-6-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251021181703.598342-1-raymond.mao@linaro.org>
References: <20251021181703.598342-1-raymond.mao@linaro.org>
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

Add qemu_arm64_tfa_fw_handoff test entries to azure and gitlab
pipelines.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- None.
Changes in v3:
- None.
Changes in V4:
- None.
Changes in V5:
- None.

 .azure-pipelines.yml | 4 ++++
 .gitlab-ci.yml       | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 093596ee378..320f7567e6d 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -477,6 +477,10 @@ stages:
         qemu_arm64_lwip:
           TEST_PY_BD: "qemu_arm64_lwip"
           TEST_PY_TEST_SPEC: "test_net_dhcp or test_net_ping or test_net_tftpboot"
+        qemu_arm64_tfa_fw_handoff:
+          TEST_PY_BD: "qemu_arm64"
+          TEST_PY_ID: "--id fw_handoff_tfa_optee"
+          TEST_PY_TEST_SPEC: "test_fw_handoff"
         qemu_arm_sbsa_ref:
           TEST_PY_BD: "qemu-arm-sbsa"
           TEST_PY_TEST_SPEC: "not sleep"
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 9151d251856..033d4f9f0af 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -409,6 +409,13 @@ qemu_arm64_lwip test.py:
     TEST_PY_TEST_SPEC: "test_net_dhcp or test_net_ping or test_net_tftpboot"
   <<: *buildman_and_testpy_dfn
 
+qemu_arm64_tfa_fw_handoff test.py:
+  variables:
+    TEST_PY_BD: "qemu_arm64"
+    TEST_PY_ID: "--id fw_handoff_tfa_optee"
+    TEST_PY_TEST_SPEC: "test_fw_handoff"
+  <<: *buildman_and_testpy_dfn
+
 qemu_arm_sbsa test.py:
   variables:
     TEST_PY_BD: "qemu-arm-sbsa"
-- 
2.25.1

