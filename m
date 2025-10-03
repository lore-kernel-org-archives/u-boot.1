Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D141CCA471
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 19:23:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C9BA8386F;
	Fri,  3 Oct 2025 21:23:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jk0COYgn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAC5E838F3; Fri,  3 Oct 2025 21:23:12 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C34BC83826
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 21:23:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-91179e3fe34so130505539f.1
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 12:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759519389; x=1760124189; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A3tKC6PWN7PztNoSvGkwHWTqd70XtxVLDr/qmlRI6pM=;
 b=jk0COYgniP+PkzaTtSzh81+VP5KSRB/ZY1JteQRlO4e3zb1cuz0Na49jgnvAq8bbSW
 NsWzO0gM/TIczxnh6ROZA1T0hFQZ/qAH+ji6hLDYd3/Rbd32XGFzbat4TmQk33Si2ifK
 0lD94sqKK2wl8g1JPYncUBSo/XsgDhnVxNWFC7Y6hkWTrGUN2byOUqtBvYD0eTxMd6k2
 IvvxFfTxO/WE6xnllsCdx3gSFzDON7ZaQK8F3AmkYczdJ5v2tyaNsRYgCS+slsP/YbMD
 4g2cymTXTctKG3oHPldI0CK16brcpKPYQSpZ94HFFY0C1VovEvu3Q0Qso7M/vPfrsm7i
 XRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759519389; x=1760124189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A3tKC6PWN7PztNoSvGkwHWTqd70XtxVLDr/qmlRI6pM=;
 b=B/fUbMZ1Hx86KBqAII4kw2tylpAYZ5sum8biyrB4qNffD9BdQYnWljKBwT/90UdXpv
 O0g8M02o6YZgBQXB/sidlwlM/u/E/iYsZw3r9UgJf9GiWA/BZ7OseTdBYE/M7cuKYoll
 Bl9kNSQdrBA/0Dm3doyUDgm9Q0m2ufZk1XOrrBWQOKl6u5mnhT3drhdXSs9AsFGwHQDd
 8WGhIwscK9daXY6TSKDEFhtXdC2aN/NztmjoEKVDwJuZI5gL7MWeYYWsGVBPx4dFXYQ7
 eRXW2Ckkgh0J82cem0hBEsb/SmpVVngEXGoqGkx8xiSW60GC3FUcK3O/NVrAgxKJsCL6
 TnXw==
X-Gm-Message-State: AOJu0YxyngP95IaPJOGWOjjlNLRcmiJiSnlDjj5n3Q2N2wSdJsxWoyma
 ubvuDe3XA/CazLm+/Lgs2WGBwZUtGtzydUgcz6ahnYYF6MQy2/iYtW2FoGV/Z7zieLdXvd7uBrt
 vy65r
X-Gm-Gg: ASbGncs66TQRzcHwaby8F+e1/pd2IuUPsK1myCXH2WqGmg2+E12KsfDqgNTXY/f+7uZ
 4orT03CDsqemhIEq08c5Cpkc2kFGxuLPrSvW5Mx2vF6RqkzkHf1QrzoNQ6pVUl7S+SuY+zFGgNl
 w04QX2WuU0jNROOrrdESpBqzXkBmEgAF3zmkxGmkrl1/15l6EybLhgGP83d6IzcUNJqCk3NvVvJ
 YdQl3XEDBfLSsLqG+z1+Cj86nkJHPebksxiz3029Mp50FEl9XJDXHSjXeM5Kc1bs77H3tFJW+Kz
 FdFlrp4lh0iXKz8CdHbtCP1YELTr11XOgf9LI7ACixEU/qhpt/3byxU9DYbr2L6kk6c3VaEFloR
 9hqm/m7zfYaPH1AlnOX0lQc/OSy+PKZtyAFKyLP2v/w/D9VuloRdc8WFpBBLIGSxhZX6yGUETR6
 nJfj97ElKh
X-Google-Smtp-Source: AGHT+IEq3uHboXDGmnn30rSO3iIe7I3gBm2UNpqoDbAsgFg6tiltU2Z7pESIMFOjE8QQxbBz6uVFpA==
X-Received: by 2002:a05:6602:340f:b0:8f6:8812:ef66 with SMTP id
 ca18e2360f4ac-93b96a366c5mr570090339f.4.1759519389190; 
 Fri, 03 Oct 2025 12:23:09 -0700 (PDT)
Received: from ubuntu.localdomain ([209.227.150.67])
 by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-93a7d81bf16sm208975239f.4.2025.10.03.12.23.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 12:23:08 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH v2 5/5] ci: add test entries for qemu_arm64_tfa_fw_handoff
Date: Fri,  3 Oct 2025 12:22:19 -0700
Message-Id: <20251003192222.767882-6-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251003192222.767882-1-raymond.mao@linaro.org>
References: <20251003192222.767882-1-raymond.mao@linaro.org>
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

 .azure-pipelines.yml | 4 ++++
 .gitlab-ci.yml       | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 1382e4f6475..a380a546fe1 100644
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
index 224485a2e64..3a4f474ecf4 100644
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

