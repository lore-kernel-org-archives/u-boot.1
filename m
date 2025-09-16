Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E02CAC592
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 16:15:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F84283510;
	Tue, 16 Sep 2025 18:15:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OP91yUp1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 187578323A; Tue, 16 Sep 2025 18:15:14 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6FEA8350A
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 18:15:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-424073edddaso59895ab.1
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 09:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758039310; x=1758644110; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ojjwO/2rZI4bMa1astwC/nKY9VZZKvGaAsrHdeKS0is=;
 b=OP91yUp1c0fCL6AWZordlIHOc2yK/tN6K0P69Tm5XSptvkZ4sVVOAOmmDWIdm7pIsl
 dhqIMob7ZieF61fDWSmCHr0S7r5ek3ugw+em/Vf/UmFW/qjgwJj7Wtgv+AGYqtTo7Jag
 h5uXiG8+XO8aLaJeZHzb/BbUY0oQBfebiEn+T5Ri6zd7f9aKkLaSzwOTxujfuNtRPawC
 nFGkhIE/FZfF045DMEFVfPq9FJd1KEC+98lncTvBtNVbs3BHNVtWdGI/LboHlWPY7lu2
 8uSPUpFYfRLTFPBk8uuj8rvngyoDQwo70TMvRzFDNWOc7gOuf7vjV5pCWdVE74lXJfmd
 g95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758039310; x=1758644110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ojjwO/2rZI4bMa1astwC/nKY9VZZKvGaAsrHdeKS0is=;
 b=pjzQHwvRcZ+pdD/tCqAhGmghS5srjS+cvJK1D8c0rZYmN+irGmo/nD3ePQTa8fzSqX
 Qb+xxSXhJ1lAgV/UVBTLwrUzSoc2gK4Sn1WX241cnUBuksPCAseHNajpxpdc3io2ZcMg
 pjxQUBcY7JUsTK9c4W8DQ7jI7E2NzMz5c6GHkyEbcM0FnpF/ueoUPbI1170ZUwZ9LwW5
 VtS/4u5s+OfnXLVBoV+Qv2UBg1i9eV/O3jeKUx3Z0Ku+7fYvmtzA4DtR3ZEZkpxY+m8d
 jYUXdFC/FLQWeFVmn6J3/11sUOHiKvvG4PT1z1B/84psEHbaY7yu7J0+7fE7ViGbU7rl
 okDw==
X-Gm-Message-State: AOJu0Yzq//lyUWbC3yA58wdaCEgj0Dv40ikfaMBid8B9cPhFkSt94j7b
 7bTzfinGbTOfI6+Y8BF4e3h4uBLnppJddO9L/warj7R3aKCWDjzDNFMg+cKY9XjoBp0USYNIUDD
 zzNrw
X-Gm-Gg: ASbGnct6/D8ltRuBPpmfJbwiGPPpHizyiVNsuWkJtZJvDTCWSEg/ovunk+Dha+yYRBs
 V9TnevwRXZpzZKo7XqG1f5IjdkBkOz8t/quZRND2z4uvrW8EKTulGmnIHMlz8faIye4gDeXE0tM
 59t5mY8CSimZAn2wP8nID4JBb4zFIs+j/weHBvm+CR25HVmakdqhQhhW7njTbpmz/T1BXAi03Vh
 iLGajOcTUtQED9CxtRDoU40cpyZjx/xhcHZYUk2NPB06pb0vKvFEP4/V4n5NcPhvtLzBCWJFaCV
 vJMPAgBbi+T0tLyvCj273ufoLRHVgTGqOebCI4VrB7h1xzID/oQj5ETFU5YCNIe3jEApIO65DaF
 XAaV3KeXQzZX2A1DmieaPlC2ZGJUUsE58esoRHmFIu8j/1PMVb/t3siQyRbc6pFU6iay+bQfSfG
 1ZDaBEvodYzTofVHCx6+NP
X-Google-Smtp-Source: AGHT+IHnJBIU7qlOdw1ec6hsb/XookF51PkuZO7cGgyfDD8HLECLz0srD1QWGYy8lxFZPHLEBZNBpg==
X-Received: by 2002:a05:6e02:4807:b0:424:52b:add8 with SMTP id
 e9e14a558f8ab-4241143ecefmr22816675ab.3.1758039310102; 
 Tue, 16 Sep 2025 09:15:10 -0700 (PDT)
Received: from ubuntu.localdomain (209-227-169-220.cpe.distributel.net.
 [209.227.169.220]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-41f0ea1bdaasm68433615ab.39.2025.09.16.09.15.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 09:15:09 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 5/5] ci: add test entries for qemu_arm64_tfa_fw_handoff
Date: Tue, 16 Sep 2025 09:14:21 -0700
Message-Id: <20250916161426.32259-6-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250916161426.32259-1-raymond.mao@linaro.org>
References: <20250916161426.32259-1-raymond.mao@linaro.org>
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
---
 .azure-pipelines.yml | 4 ++++
 .gitlab-ci.yml       | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index eb547606ddd..4316041ad9a 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -468,6 +468,10 @@ stages:
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
index 61e4af96c9a..03f83320c87 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -400,6 +400,13 @@ qemu_arm64_lwip test.py:
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

